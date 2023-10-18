Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88FD7CE62A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjJRSTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjJRSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:19:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2076.outbound.protection.outlook.com [40.107.215.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8B6B6;
        Wed, 18 Oct 2023 11:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnFBYhKaxqKepJlVPWdpvWZnEVya63OepNYSQ+/buLIs6vChKSeFvWjz7oLfoUVJlbGnNy1GW8nNvXirRyh0ZO6KOmOphc4bkawTDTOWhy1uVlOxk+jdX0o6ckymGBVrQDJzUDArBr3W6dnN5vXw1TrJ5vikv9kLzWMQzLgKAvmEWGSos9YQnDYSBAHXoYNKuSBAefJHkJkMKHlP9Jz/4a+Ovif+ipRZHDI7GzhO3jwjne3Fl32ce4BFmwwdD2QcXLCXw6pG0cfXM6Gi7cEUVBShdNLMm3WzKN36L7mYsHtEDt8WWGNglUWpGEfDxBXgv+s7MZq/wlQu5cOFj1W62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=polezbJFj+dPB54UAh/56La19SOHoM1aBicBq/pbJL4=;
 b=IB5jzIUX2R7PKBOzf0lZHK89CQeVAL8WhblHlnKhEaBn/85JyXKpLCHXL40jiH39q2cvlCdbVHKyrSa+/MTZmJVHCpztgOWxVTMvcjtPAqA6woQcTu+09XhfwKN7y+cJwAU+8lcPrsZva7/6BxdF/M8oSqvHFGT627yptYkpoe3rgMxM4il/b0zBpHghaO/g/t3xZyasDtg1yWpni0YYmUfeNX/d+bUAUnTIjS/cU9vTNk7MU6bfBieqkisU6GHUkShFq6UDxmadHZ7Dh5EpbnTboaNC+h8fxvNvyLNYvWD3RdRsU67mtwnuoJZvKbtqdrQm2k6YsKFyztuLJjTPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=polezbJFj+dPB54UAh/56La19SOHoM1aBicBq/pbJL4=;
 b=dKY4CNgb3vQ1OzfBfOI7qsZJ299I19MFn34tOJX23/2ztQKYhGUjIx6u0vtxjxjjhofszXuZCfN0uDJz2Tfwxr0R25hQ3Ibw/pRVBbYkALRtrNa9etVtIboqfLIpVxYov9NRKqE5WUvt2tq1SV7imzG1Prk672rejM5P2t6MH50=
Received: from SG2PR03CA0121.apcprd03.prod.outlook.com (2603:1096:4:91::25) by
 KL1PR03MB6336.apcprd03.prod.outlook.com (2603:1096:820:ac::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Wed, 18 Oct 2023 18:19:31 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:91:cafe::6e) by SG2PR03CA0121.outlook.office365.com
 (2603:1096:4:91::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 18:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 18:19:31 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Oct
 2023 02:19:28 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 19 Oct 2023 02:19:28 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id B90DF68E72;
        Wed, 18 Oct 2023 21:19:27 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id AF8C421CFCF4; Wed, 18 Oct 2023 21:19:27 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>,
        <andrew@codeconstruct.com.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: hwmon: npcm: Add npcm845 compatible string
Date:   Wed, 18 Oct 2023 21:19:24 +0300
Message-ID: <20231018181925.1826042-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231018181925.1826042-1-tmaimon77@gmail.com>
References: <20231018181925.1826042-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|KL1PR03MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b6beac-7f83-43c2-e8fc-08dbd006c5f8
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dycu7oPW0WPaeLDMvLUXamBxZcmm5T7SOSWkFC8Jx4C9tLm8CbuQWrA0KrjmANr1I5A1ckUipdWWGR5l1zrDkk88yDyjOmp2cWz4MD/JX71kEy3p6OgzIFUVX/rPKHZASxR9Siv3PercJL8FVWpIcT5v7l820zYYKHHs5ikZryoUNVgop8seIIf636+rx5cWjqhNIecF/9s1YQ1NVIExr7DalCcOxv/UhQ3/z5D1TtbfzcGVm+0aDCgguWMnlv2ZsrJA9XPQegKm0RDOZVPcyx4/Yt96dVviqHJOMzXm44sDdOJ2SgxTlwAEHvgY7EfAfcODyURANgnUXLKwQnFA9FxBF0S5bpJ8WsR3Sp9AAJmbo8dEnXbYIZtatcSi1XMvAB16e5vdTnzKsQHAkLhK2TIQNsuQwRNJSMnr2g3J7oF8e6K9pLLSaWq2GwG0yc/QxcmCnTDDR5ce53rr/qd/QWu8fQ4H/DJgIWi7i3X5hmWZREUjb/ucMkQIDnfgt5oUF6v9eyRUxqY6geOml3gEAkpu3U/rVDo1UuoRDZhPq57/z7620srxxctG61w9VoEZmVBIoh2vaRxVdaKu+ThGXViqJlWn98okAlrXfmMg0jtx5s/EVDQpUs87d3frf2JSk+G0Owb6eI07D3ougNIt1ndK5JfX913aW0x0rRsqTAY0pGJRrUiJitobBmiXohul7YRu6vKIGfGZWMDkLzNyFm1hu1dArd/YFEylSv15nZ9/G+bb3mbJVtSr9WC6ANTuq+S7dhKu4yErrGvA8hZAkpWkKp1hpwq4eiPM6i90m7adorAwnJnTjZXjnnydHShWKAhqan5PIBfDGffQei9lYBI5qPZb00Tw4MhbzRhVoT2uHtStDq8jlTSmW1xexvHF1inZuA17YjofBEUOgAg4Qg==
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(84050400002)(230922051799003)(186009)(64100799003)(48200799006)(82310400011)(451199024)(61400799006)(36840700001)(46966006)(40470700004)(73392003)(42882007)(336012)(6266002)(82740400003)(356005)(921005)(26005)(47076005)(36860700001)(83380400001)(7416002)(5660300002)(70206006)(41300700001)(54906003)(76482006)(70586007)(8936002)(8676002)(4326008)(1076003)(110136005)(42186006)(55446002)(2906002)(316002)(478600001)(6666004)(40460700003)(83170400001)(40480700001)(82202003)(81166007)(2616005)(36756003)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 18:19:31.1768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b6beac-7f83-43c2-e8fc-08dbd006c5f8
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6336
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for Nuvoton BMC NPCM845 Pulse Width Modulation (PWM)
and Fan tach controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
index 8523777f560c..18095ba87a5a 100644
--- a/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
+++ b/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
@@ -1,12 +1,16 @@
-Nuvoton NPCM7xx PWM and Fan Tacho controller device
+Nuvoton NPCM PWM and Fan Tacho controller device
 
 The Nuvoton BMC NPCM7XX supports 8 Pulse-width modulation (PWM)
 controller outputs and 16 Fan tachometer controller inputs.
 
+The Nuvoton BMC NPCM8XX supports 12 Pulse-width modulation (PWM)
+controller outputs and 16 Fan tachometer controller inputs.
+
 Required properties for pwm-fan node
 - #address-cells : should be 1.
 - #size-cells	: should be 0.
 - compatible	: "nuvoton,npcm750-pwm-fan" for Poleg NPCM7XX.
+				: "nuvoton,npcm845-pwm-fan" for Arbel NPCM8XX.
 - reg			: specifies physical base address and size of the registers.
 - reg-names	: must contain:
 					* "pwm" for the PWM registers.
-- 
2.33.0

