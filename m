Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9E7DDCBC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbjKAGfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345130AbjKAGfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:35:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2233.outbound.protection.outlook.com [52.100.0.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F188DDA;
        Tue, 31 Oct 2023 23:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFWDSO82lGqKvbtFWDXbIwlr5e0cpk0qawjzwiFZ0E72Wphb9NmvBbDkOmzTt+NoquODVR4F0x0QPkt1aacQ9Rbyk3euUCAZSDcmuugyDfiQ08FkFtOk0iKinB3G9PHdmgV1wNDexmxIyxxPJZyD1imJTMZPWCq9SI6tkvCUhEiyT4AK7G327KXzR/yrpzBeEbjiBiFjN1UajbHQ1xmv7PY3uaOe86UEnKw+ZiKznxquDf8Wo8TksKKdI436F9Nah8BEJVMvPypUPxvpg/NTUc/+NLKOqsI3Ndzjln+2Go5L1QNBr+wyNstzcH4FJnOvynKHHsqc6XbooPaYypu88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcaICetR5lyEKj6pIUQJ2asUqjV4ZwfHDhAFVDFV/yA=;
 b=ecMEr9RMVi9PbsoJp83TFiFTeNBX/lgp4/pxyYEBsanvhSTpcBKJzjmQkQfarHPSiIALdQwf5fp6liADdDJzL0iHKqVd7lFYRKfWyvJFKtY+3A7vWeV2raFA3X1v3Is+F+tq7k/y6DWoRp6V3bvBzKT2kthMHSWJ9UFafey0F7WBx/5siLpvssc30D4Pnq0/afftaXjI58UPEXvFzIv4fOhPwIOXAN3Ggj6RMIL67+bxdpOWSKDSOkvY1lSSnbsNnpS+kxhgoawJduJxew8fXg0iC232CmANxtt2smDj7P64J0qwmVBoGx170/T/1u8dU/500UU99nIwzPfC3G3j/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcaICetR5lyEKj6pIUQJ2asUqjV4ZwfHDhAFVDFV/yA=;
 b=TxIxzSzrJvGMlRT0p1zwR6Ztt/DgVdUbqVg2MydSb99LBSnbd4ig8oEgKWFRsBFXWgEBvfegNwa5ebj24PQn7sO+Ai1V4riqKFSYXiycxU2bKUzYITIb+Ksfl8LtoAuOlI92DLMEpd/dG1aqYgRW7MXSdTu3lor59xljEo9VtCg=
Received: from SG2PR06CA0205.apcprd06.prod.outlook.com (2603:1096:4:68::13) by
 SEZPR03MB8208.apcprd03.prod.outlook.com (2603:1096:101:19f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.26; Wed, 1 Nov 2023 06:35:30 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:68:cafe::29) by SG2PR06CA0205.outlook.office365.com
 (2603:1096:4:68::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Wed, 1 Nov 2023 06:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 06:35:30 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Wed, 1
 Nov 2023 14:35:18 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 1 Nov
 2023 14:35:17 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 1 Nov 2023 14:35:17 +0800
From:   Seven Lee <wtli@nuvoton.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>,
        <SJLIN0@nuvoton.com>, <wtli@nuvoton.com>, <scott6986@gmail.com>,
        <supercraig0719@gmail.com>, <dardar923@gmail.com>
Subject: [PATCH v3 2/2] ASoC: nau8821: Add slew rate controls.
Date:   Wed, 1 Nov 2023 14:35:14 +0800
Message-ID: <20231101063514.666754-3-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101063514.666754-1-wtli@nuvoton.com>
References: <20231101063514.666754-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|SEZPR03MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc017f8-2af8-41fe-f523-08dbdaa4be51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Wi2A7PkDZk815I4cc1xCinNu78xRMA72et1mHFXwHdHHbSRxiy4FWOabThFnszq5LX1saSGgAsdhu18B5fifYPwyL+LMw18LAPZ21ZrVnya4CU4N3aAShYUSRvyMFnxs6A/u9yzbXnpFZ0sM6LEM6PUnr4cccsdm/Vx49STrrokBm5rx6dHIHwomlurx9/kdMJhQ0V+CBlZ3LclTeMcZsiD5NTIAnvBisvhpxbxaqNiQboBaFew2KBGCvnpKuLV67ABEfpASge85EYgGF0BfFARti12mTxA4MhC6yD3544GBeKy+oQJRAKDw3ZZOYUYueK0WB1rk9e0Nmnqfhp4WGqdv7cgYUX8eJDxqe5jpiG8sRjdBlZSmW9k7jqBtfnoN36v+kuPaZ/j6Z7FfJDs6N6qeT5mNSruc2VdQpGlb6A1xm/mdM4zXXpbb4T8OM8/8I9KJOYOreEeTjgCvcHbmEU41g7Nmo3hrJPCUbznuz3g40PPYsG+5jJoA/Lpn/7MzPvtvWwVo/DJKf6yM4jjeduD5+rTQhKYCYOCt6fXZ1Ze1xNu9NONPxruB743n+N4E2VTwp/y3MdMx0EVQrfKkl/dGYlwbLfYdgBjYJOtz+9CVXnRxhch3zwqabonVRaQ/58E7YwRm2z5VonroZDDbRGdzVmP0ysuDQTKgUf1fhHDmi1mdWbZu1nqP83PptAMAoTEGwbLze7tqoHdFvsjEIvuGE9dWLYT5lOO3et6aoqx1s3PxlTfsmDMgrY0knGzAAGVifmvfmaAVOsFO0kodcMDlvw4b6Am+JlSDx7lEGlB63VZM2LW5Us7MdcnpTL58j0TXOEAq8/7ybs8PKRVFa0Pi/fP8fw/Q6jkaxmwJ+8=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(5400799018)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(34020700004)(36860700001)(6916009)(54906003)(316002)(41300700001)(47076005)(8936002)(82740400003)(8676002)(86362001)(70586007)(70206006)(2906002)(4326008)(478600001)(40480700001)(81166007)(426003)(7416002)(336012)(5660300002)(356005)(36756003)(40460700003)(1076003)(83380400001)(26005)(2616005)(6666004)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 06:35:30.4341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc017f8-2af8-41fe-f523-08dbdaa4be51
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch supports DMIC clock slew rate controls.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 sound/soc/codecs/nau8821.c | 7 +++++++
 sound/soc/codecs/nau8821.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index 6e1b6b26298a..012e347e6391 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -1738,6 +1738,10 @@ static int nau8821_read_device_properties(struct device *dev,
 		&nau8821->dmic_clk_threshold);
 	if (ret)
 		nau8821->dmic_clk_threshold = 3072000;
+	ret = device_property_read_u32(dev, "nuvoton,dmic-slew-rate",
+		&nau8821->dmic_slew_rate);
+	if (ret)
+		nau8821->dmic_slew_rate = 0;
 
 	return 0;
 }
@@ -1797,6 +1801,9 @@ static void nau8821_init_regs(struct nau8821 *nau8821)
 		NAU8821_ADC_SYNC_DOWN_MASK, NAU8821_ADC_SYNC_DOWN_64);
 	regmap_update_bits(regmap, NAU8821_R2C_DAC_CTRL1,
 		NAU8821_DAC_OVERSAMPLE_MASK, NAU8821_DAC_OVERSAMPLE_64);
+	regmap_update_bits(regmap, NAU8821_R13_DMIC_CTRL,
+		NAU8821_DMIC_SLEW_MASK, nau8821->dmic_slew_rate <<
+		NAU8821_DMIC_SLEW_SFT);
 	if (nau8821->left_input_single_end) {
 		regmap_update_bits(regmap, NAU8821_R6B_PGA_MUTE,
 			NAU8821_MUTE_MICNL_EN, NAU8821_MUTE_MICNL_EN);
diff --git a/sound/soc/codecs/nau8821.h b/sound/soc/codecs/nau8821.h
index 00a888ed07ce..62eaad130b2e 100644
--- a/sound/soc/codecs/nau8821.h
+++ b/sound/soc/codecs/nau8821.h
@@ -236,6 +236,8 @@
 #define NAU8821_DMIC_SRC_MASK	(0x3 << NAU8821_DMIC_SRC_SFT)
 #define NAU8821_CLK_DMIC_SRC	(0x2 << NAU8821_DMIC_SRC_SFT)
 #define NAU8821_DMIC_EN_SFT	0
+#define NAU8821_DMIC_SLEW_SFT  8
+#define NAU8821_DMIC_SLEW_MASK (0x7 << NAU8821_DMIC_SLEW_SFT)
 
 /* GPIO12_CTRL (0x1a) */
 #define NAU8821_JKDET_PULL_UP	(0x1 << 11) /* 0 - pull down, 1 - pull up */
@@ -573,6 +575,7 @@ struct nau8821 {
 	int jack_eject_debounce;
 	int fs;
 	int dmic_clk_threshold;
+	int dmic_slew_rate;
 	int key_enable;
 };
 
-- 
2.25.1

