Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1986C7D10F5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377513AbjJTNzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377492AbjJTNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:55:13 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2065.outbound.protection.outlook.com [40.107.247.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532F8126;
        Fri, 20 Oct 2023 06:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9X3GiLU+HSv3j3/NQ1XBinKZlwpRMpWxkjqMIqrOGfqgG7mTzT/OBCDNt9HwXPRfcBKmEG1K8miB9d7vZDxMMqeC8DnXt7eihUbwoRUrARbGcKgwwi72RcHh7QIpSQ+5KZTsrjSo6KKM3jRUpYSkuTdiH58KyB4UBPo8nxVRWQ742L224rHA0ZFR8SU0bcKNtfu9yjlCpDJutITn59Xnffxj6BSnXrVy1D513zsVHqrcqAbxx1Q9VAcZjlnvWfOe40qUzkSwAdVDWOwq/2YeliyUXU6+wYJd0AvQut/8O/jFi76PeKh5tuKM12eo88NBhiIu5QLugnT1fF5wih82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL5ABtSNgLi+dQc5aNO33BNZWlRE7efVTD/efBxKMJA=;
 b=A8iNCisvXO3q8aJ6wgVsFqrkdEmB9Ewmu8eOFOjtpyHNn4jN4lKqhtW/A/aIRLmjJHPtARYTGkuNhS9eb7NnM8R7g0eLt3w5uAI9EdvCObecVZpJpECKPK81hvOhssyKzLBCLuoCzpGnqmx5mNyzHAbddgYsKKzM/056I0XKBhwpKHJ6qkzR5aV/r1uyfAOty0ID1GRt4FEzaO4sXnDdaMIzV5Nb21yuOOzzkOFJUCYFHf5QxEL8OKi9FsZZRAsUMjV9uGUwuzaRJIP8F8AeOuA69R/wLdgc/6/k9Y01JhukJPoKQM1meUoCEUW1VGRSdvq+rUs0ouZ4TxQWHR8mtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL5ABtSNgLi+dQc5aNO33BNZWlRE7efVTD/efBxKMJA=;
 b=U+u5LeHcAj/U/tJMRFnYGpwH1QPP/y+Ee7ehj1CLcldMCo8W9WnT4TivcN6e67CfZfUbINYG2glh9//Xf/j5F3NjzxVOi8cbosWntxnutQjNbME6HKUNKwdPXRvFG7fQ7c2j1ASb8t0fVntYShqH6VuRKdpxkTYeEVnKe1mBAzI=
Received: from DU2PR04CA0002.eurprd04.prod.outlook.com (2603:10a6:10:3b::7) by
 DB9PR01MB9391.eurprd01.prod.exchangelabs.com (2603:10a6:10:361::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 13:55:04 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::41) by DU2PR04CA0002.outlook.office365.com
 (2603:10a6:10:3b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Fri, 20 Oct 2023 13:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 13:55:03 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Fri, 20 Oct 2023 15:55:02 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 0/1] dt-bindings: backlight: mp3309c: remove two required properties
Date:   Fri, 20 Oct 2023 15:54:32 +0200
Message-Id: <20231020135434.2598578-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Oct 2023 13:55:02.0812 (UTC) FILETIME=[05FC65C0:01DA035D]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|DB9PR01MB9391:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 59314fc7-14d4-46be-5952-08dbd17428f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k40vTAhJS0dRqOSMnM84y0gMtm0Bdksz+/yQjf6/+cm9WmkC/Eop6qjeI6fbYpgUi/8BmopfZeDFkAxd2VmrBKj03ur5kTcNKwzKM+Xred1MAqFqJvC+uTWc2ih0CtfxJ+RyLVT1m9THCz6UKGMmlFlucO6p9aAUKCW+0YoPwL+N5I0DYzFa+p3TEdXSWR5pJiFp7nK6chqDofAPXwcEnrkumjecdxTiJBpZTJIewLZpOmUDkGHqd6WK7RpC60NVAq1a5LE4v1gAcNXMa2ML0omwjjBuNAUNjNGvczO/3B4FFXWJgudIyeFSm8YfmZC6q8XRdUfdzrU/b6VJ2FaRATElWmpt9G6Y72XTa1BOOX1SgsHiWQManq3uS7Crrn0ZUKsamT6B4M6j3NcuD6TSD0EGUhMp8140D88o8efdWL6dZbeV2xhJLXYPDBNdmYBzmAMQicLEntiMN6MXJcHf6xB7cZjDi2Fl5nbHwOWw7xy3fhiGtfDvqpWwUmjheLU88Z1VjTtlRl1Qj7itjIij6Yqru60ZaGMKOnBNj91rrZ1YvrK07gTplmiB6gfh58V0iPTe04yyzrgUwy2u0flPGJqRTxhjy5rPEtqYwdfmnyqQYwP1aRYlGJWgrYVhm8zjjZSpstsnlvE+zuJioaOWtafikIFtNJlxF3cQzCRzyFUAU/bh8wcSEv4lrLDEkSuRsOLXYa+rhf8kJEGSWtCJ+dzkcdgd3Iax9GnTu2RPg2gEldb0fY576LcITJ89Bo6P
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(346002)(376002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(46966006)(36840700001)(2906002)(4744005)(6666004)(5660300002)(41300700001)(8676002)(4326008)(8936002)(450100002)(110136005)(70206006)(70586007)(316002)(336012)(478600001)(107886003)(40480700001)(26005)(1076003)(2616005)(83380400001)(36756003)(47076005)(36860700001)(81166007)(82740400003)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 13:55:03.4645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59314fc7-14d4-46be-5952-08dbd17428f8
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR01MB9391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove the following two not-required properties from the
"required" section:

- max-brightness
- default brightness

Other changes:

- improve the backlight working mode descripion in the "description"
  section
- update the example, removing the "max-brightness" and introducing the
  "brightess-levels" property

Note: the "brightess-levels" property is present in the last version of the
      common.yaml file, so it is not decalared here.
      For this last version see my patch:
      
[1/1] dt-bindings: backlight: add brightness-levels related common
 properties
commit: d5272d39995f4150062a67e6f2cef556edece740

Flavio Suligoi (1):
  dt-bindings: backlight: mp3309c: remove two required properties

 .../bindings/leds/backlight/mps,mp3309c.yaml           | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.34.1

