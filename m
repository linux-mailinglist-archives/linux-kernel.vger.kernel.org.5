Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E129E811E05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441829AbjLMTFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjLMTFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:05:32 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01rlnn2041.outbound.protection.outlook.com [40.95.53.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A0CD0;
        Wed, 13 Dec 2023 11:05:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fC4ld0gpItKHxaGEfnMcffkEBwNBch/BNB6XguhlQWME6/6povYbK+h0gCAt7v9o4RRm59C3+0nHkVccoH8GifIarJ/D/w8HIGeyWInBcWI5c8cHu4P3cpX7R4yLl67JxOxPdl3U/L7hKkzPgyAjc+d+kPWBEFmLuxTAt22iWf1z51LYYtnq2fHSd8+F3Dd0atvJHBR7x81L9hwGAPMLfP391/5o2uYlBx6idLymbErpP3sYQVDplhTEygb0i9eDv9BHD/A//p4RABu9NHI4cWF0VvxxJJz9sKqkzJHqmPXp38qqMDEC4v/VGuxP+cmzxmx9OZRiJG/JbEtSQ/mG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i9VXHA17foOwtFxfhCvfV4OjRJRyDaaG7Oh+1HoFj4=;
 b=EVM1h/ZmjctDCcRc9KDJsuPt2dedxRVx3ZQfIyZpC+bY2w/F7EwoLrNfY53198sgvQS+32kkZf3HIfsUcEPtyHlq4ekNfzwcMIhG5ZBKS8Mz1EKbWRWzWS4MZFWqGNdgiRTna523Br6ppbQjRSOqaKuZRiKwijTlOcWygPqkA/9beKAMlvmVOzRINvJx3owOdRGlrz/9G320NtrkT7mlvFuTM2UIxqBBbbKWslsPi0h7wNovURO0NO7QUnB/2dhq8OQJVARy2/1raMDst8sr7ioY2yAYwHau8L5RZdoDx8YlWUcSQm6N1FDjrOWJyRZdcPo4QYDOWj3M1zPsyhy3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 211.75.126.7) smtp.rcpttodomain=arndb.de smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i9VXHA17foOwtFxfhCvfV4OjRJRyDaaG7Oh+1HoFj4=;
 b=uYKQgOKERm+SAjSIxb7OeTh+AwPm6K+GRnfnFwpv3v8alc5awH165tH1jFhHvobAlDrsgy3B2d2DwW5gm1UJIsZfiuJsmE0cyDagyOeSrWIddwg223viq2Fcu2RM37NuisyLCnQID5Z7qDDaKjDqqCzRBCV43c+3WXKz100js84=
Received: from KL1PR02CA0033.apcprd02.prod.outlook.com (2603:1096:820:d::20)
 by TYZPR03MB7060.apcprd03.prod.outlook.com (2603:1096:400:337::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 19:05:35 +0000
Received: from HK2PEPF00006FB1.apcprd02.prod.outlook.com
 (2603:1096:820:d:cafe::1f) by KL1PR02CA0033.outlook.office365.com
 (2603:1096:820:d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 19:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 211.75.126.7)
 smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 211.75.126.7 as permitted sender)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB1.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 19:05:34 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 14 Dec
 2023 03:05:33 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 14 Dec
 2023 03:05:33 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 14 Dec 2023 03:05:32 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 23EF45F5D7;
        Wed, 13 Dec 2023 21:05:32 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <arnd@arndb.de>, <pmenzel@molgen.mpg.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 2/3] soc: nuvoton: add configuration menu
Date:   Wed, 13 Dec 2023 21:05:27 +0200
Message-ID: <20231213190528.3751583-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213190528.3751583-1-tmaimon77@gmail.com>
References: <20231213190528.3751583-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[211.75.126.7];domain=NTHCCAS01.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB1:EE_|TYZPR03MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e89f2bb-b129-447c-b52b-08dbfc0e7c13
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJNOYgGeNoJ72Oxh181XSsFA31P5q4Q/Fw2uiMvH7sDMnNa4pXuqrN5STdO4vIfSUxlXzUpiOw+8BMAvWjfkp+Zw1uBkGj5OMgGmaBbx4n21x5wu720kf0y1Icv4iw30NJjOYNYAmtlhcbItSMA4yLiqG/JoeE06NEjNWMX2GVj1dVKSpHAUiuZjwFEJytq57bKD+5TMsJ6+FDiZkWT3wkkZL8I9sXjkG6ylXakti5gawE58Gfn0qGBWz/AvNJhFSSp+Dbo7vblgiddmB4lANJf0jziyYBcCwiG5CDZ4GP3YIXkvf1jQMg3WS3b49n80qEACkMvFjOWwNwLix5TcPqZ2sWz/uA8Ys2ElFyhzYrghIiatfURjQiu2a3nQHzR7BS01IIfr8ls7zGFnakGgGo+Fj3QIgXiz/XKV7fCYMuV9ZTWSz29IXhZsZ4DcuaQkH71453TD3FXzmbu1ZMiTmyVAyxsDOb1KgNf/bid15Q0mknCXEZeu7gnrxH3+K6lD4//JiqTujCWn565KNEmffc6IBXmjkrdeCjkTViP3El+NtBos25RstHI/LiGHR9b9z+EPUnBX1bYoAK5iw/q6ecdxz4HHIgKJgMP3LF8UdYcAczGwl2yFkfKosdz7781jaBesG8xZQVzcLucNjz7K0vVPYQ0bg90Y+MAxNqHQkrsQ4EsP8Lfyez8QZ13Hvv6Tf0iNnUEQu6/08tFs9dBL2K/Bm2Ng742itmjYYlR/3L0MdBTVd2k+xmGD6ePvnVk8eWiNeNE2FJ7Ux7E2gIDicvOGCatASr00tsKnqUrQnwOR8tzhISx9hFhAeG4rARoF
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(48200799006)(82310400011)(451199024)(64100799003)(61400799012)(40470700004)(46966006)(76482006)(47076005)(26005)(2616005)(6666004)(1076003)(82202003)(82740400003)(356005)(81166007)(86362001)(55446002)(54906003)(316002)(70206006)(70586007)(110136005)(498600001)(336012)(6266002)(35950700001)(40480700001)(83380400001)(40460700003)(8936002)(8676002)(4326008)(73392003)(7416002)(5660300002)(4744005)(2906002)(921008)(41300700001)(36756003);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:05:34.3996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e89f2bb-b129-447c-b52b-08dbfc0e7c13
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7060
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,PDS_HELO_SPF_FAIL,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_FAIL,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add menu configuration to Nuvoton SoC drivers.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/soc/nuvoton/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
index df46182088ec..d5102f5f0c28 100644
--- a/drivers/soc/nuvoton/Kconfig
+++ b/drivers/soc/nuvoton/Kconfig
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-menuconfig WPCM450_SOC
+
+menu "NUVOTON SoC drivers"
+
+config WPCM450_SOC
 	tristate "Nuvoton WPCM450 SoC driver"
 	default y if ARCH_WPCM450
 	select SOC_BUS
@@ -9,3 +12,5 @@ menuconfig WPCM450_SOC
 
 	  This driver provides information such as the SoC model and
 	  revision.
+
+endmenu
-- 
2.34.1

