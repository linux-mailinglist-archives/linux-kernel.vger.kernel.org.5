Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96817BF633
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjJJIkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjJJIkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:40:11 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F53C10B;
        Tue, 10 Oct 2023 01:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPWH53yLjynXkn9FxbXMZ/rhcSvB/VYQroO7967+W7513jQlVgGcuyKhJfY4WQHMwsyg80v1IBBU1D9poz9WESJp9s8buqyabN9P7UixrR1KUCrNTchTkmM6hSj+22KEZM0ZW1q7UxRwB0Xv52ts5XwdUsC6ntH5KbIfR4rWvzGnK9g6UalfEVnC27ee3wNU0OWSnIbXE9HHfYz22gfEnJ4GCj7AgEFP21NtvgmLQpdnXARzrzPN7/cuhPX6cNbpXMbYrMxOJtYkqxgN0Ueq1hBNiQ/amIJr0UyZUONWk3rPJm2Bsg6yAwdh+WMBxaDKMuzNCAXsMrULOPoK2nEo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWYHkwmvA9jrBuIs67grJ25LSNK9wo+TIrzrkO/aXPk=;
 b=H7X8req2l+jqKjGB5iHevQuk4Qcmn29mLq2QbRpFscq5ErN0d3goQYqCfw2RXo7q4rk2G7fSmN6YGkAnW/rxRttRJnVw9r02i9pKAfWg9PtNUzXS5Gjt8IopXMAwl4923/+t3bkn7B2gRJ2QvCzK6LUqvBK4pMDs7aLEoBMXWfLZOfJR1qyNoEw4a6RuAGfv5G9Kdl2+/tA+/VzWNI1dVq5pT93aEi3g5yPjxPyCo/dVKG9xnMH8sgRDCe11JJTvRD6VTMM2BehFRQLVpsNYwnViDQpytjgC37O1r4q5I0DbJnDKONYbFBuGeDhX8WZDgjWHkshYSGzC06F2SFC45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWYHkwmvA9jrBuIs67grJ25LSNK9wo+TIrzrkO/aXPk=;
 b=AHHH3TrI/ON+1u6FBUHtzWFKQFZlNPaHm+5UqQ1TW2bO/AhFRpAP1KQhkhl8bUT2nbrcpk6RSlwUqnZHN89XZYECPBVWTlJ7n8jxiSlp75iaz01/G4wd/IqgQlvgnzcIRSBd1wJQoIs7Sw4LSPNz5TIe6btIao8wWS+5tWTxez8=
Received: from AS9PR06CA0118.eurprd06.prod.outlook.com (2603:10a6:20b:465::20)
 by DB9PR02MB7259.eurprd02.prod.outlook.com (2603:10a6:10:24a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 08:40:03 +0000
Received: from AM4PEPF00027A6B.eurprd04.prod.outlook.com
 (2603:10a6:20b:465:cafe::d3) by AS9PR06CA0118.outlook.office365.com
 (2603:10a6:20b:465::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 08:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A6B.mail.protection.outlook.com (10.167.16.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 08:40:03 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Oct
 2023 10:40:02 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 10 Oct 2023 10:40:02 +0200
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
        by se-intmail02x.se.axis.com (Postfix) with ESMTP id 36A952CD1;
        Tue, 10 Oct 2023 10:40:02 +0200 (CEST)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
        id 19C9362933; Tue, 10 Oct 2023 10:40:02 +0200 (CEST)
Date:   Tue, 10 Oct 2023 10:40:02 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        <linux-arm-kernel@axis.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/20] pinctrl: artpec6: Convert to platform remove
 callback returning void
Message-ID: <20231010084002.GG11306@axis.com>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
 <20231009083856.222030-10-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009083856.222030-10-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6B:EE_|DB9PR02MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: cd674dde-cadb-42a0-12b7-08dbc96c7f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9w8VCbrFEjC3Wz5mvx0la+2rgBOnTvDAV9CBoMOqIWBoHZn37AFhonueuAa299DnHFiWw8XtzR6ralGwb/FMtb5/nKoAa7wyHTkRppz5U57annRLgXyp/xZO70tKiypKCewg9DA2nYSLJpOJM2s/94fGKmEpL0eOwki50o0WovrnK7oYjw+jGLdWxYLtMCTsIV3J5hh+YExYOF5UU2PtTfoO9OZQsmKV+Kl+uW7L3Zi32hA8KbjAf00N50ID/+hYj95DGTDTIAJoAWDJYXD3tlzVNFP/Pf/anbcUqMs6HE8OQxJ4j1UlsCdr8GktitKzPedCwa4lsk5zvIIWfqPEiITuODy5rngNaJO1oupg/8PBKK/HsoFQoEogMOmz8YWt+3VqECtlsLwIRARRZ5UPLFFBJ7I9axSgS0nExCRofYTsTHv86DzfLlTGzh/QQAhk3vP0r/KsezcoFpmCc0T72Jj3PtAW4XERNTr5cSjyW+N81dzRAvpuTMIqHDtN2CNu1kEoFmsgMuD45hpwVJXiOPFh1D/iE2sGM9Sql2vTd9Yg6OCJMpkSQwTdG5/wQT10DaeLpCvsl7HwjHbDDw0Iy6TFDfcuVh7a+X69gWAbuohNDa16G417hpI5goQg2J5VK83Bl6qYoYiQ2Lb9uwqT75BDhazcJ60HHmQUjizzMCmH39TuN0cxtjJAF8Jbch4o65MpL4UAtecNRZzuzQcJmTcryQuB6Ai+MdlcH2XAXYQ6sxW+h8WkRyIjuad2mYQcBgrNbk16zGsACpnSPa8i+g==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(83380400001)(40460700003)(2616005)(336012)(426003)(1076003)(26005)(40480700001)(70206006)(42186006)(54906003)(316002)(6916009)(356005)(70586007)(33656002)(41300700001)(47076005)(82740400003)(4326008)(8936002)(2906002)(4744005)(8676002)(81166007)(44832011)(5660300002)(6266002)(66574015)(36756003)(86362001)(478600001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 08:40:03.5495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd674dde-cadb-42a0-12b7-08dbc96c7f80
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7259
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:38:45AM +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>


/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
