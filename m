Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAC380E549
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346074AbjLLHzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346059AbjLLHyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:54:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D765171F;
        Mon, 11 Dec 2023 23:54:35 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-286f8ee27aeso5568497a91.3;
        Mon, 11 Dec 2023 23:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702367675; x=1702972475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFRZUoAD4VFKEOVifbbDQ7RKmVNtR05fvh+zOM0+EOs=;
        b=XlxCTerGAweqzWPal5MeJyLxrRmRRrf2AFWCEsupPrr5CS+clo71c/Wb1jaX2kT1bF
         zEVa09D2ULplzQhnnbrmE7ut7OwPpOD9Ui0wxVMC5tpnpJy3cVrSv30tIPNfW1opj63k
         Hg80cYpMAx/oSoxeUAmRbPmqkJZXGYew/sR6no7IF0hmDTuVOgnT6BPDUt5wdCpmxa/G
         IkQxZoiqHTKkqcooKhE4o3tir+aw52jzVMDnJCxu0Jh8tixHpKEJudQy/Lf2eHfWduZj
         Ye45TrVl5LCz0pASoeSsEPtLeynJd5/7IHiaFDeVai30clbWuYJEweHjNSVSQB4b2Tr0
         BHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702367675; x=1702972475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFRZUoAD4VFKEOVifbbDQ7RKmVNtR05fvh+zOM0+EOs=;
        b=hRIQp4xywkuKKLJykyhPvAv/8N25go0brd1i8jBnmPfGgoN6acS5ABhEPmcta/L7PD
         CfYXwFHghSZonYtkcPqwjfWqHr7tAbgTf0OHaJbIYohrzxunVFDqll0E5OC62eKC5uSK
         43kXRh0IZrJ5gCsEBoxGTzogVY9VQLyzePagKBg7kn0gl8a3yD2OziL1N5Bj2fe6/+PR
         LfWdSe10V5tw2n3AYzf35sn402KffJb7rFa3Bk9VwAPbPl6pgRQ4vkiHDSdtX5R65Bhu
         /KUsyexIYMUcZtXvxdwUSSLPgI1Aw+obPBa/pPyyXHh/Q3YYjRHhaZb8Nw4kNxB/mBiy
         4gvQ==
X-Gm-Message-State: AOJu0YztBUOyWx79fEDau646asKUJzBLigRFliMW36BJq2+QLxpJg19n
        pnZki/tWlq1kuG8PkagLzFQ=
X-Google-Smtp-Source: AGHT+IGNAVQ6JcEmb2IpiIKEKpUDOC/kTTABVCLMRPQ9qM4CLq1mSFUgTd84yieq+ST8JziA0dPmqw==
X-Received: by 2002:a17:90a:31c1:b0:286:f3ec:2a1 with SMTP id j1-20020a17090a31c100b00286f3ec02a1mr4511497pjf.31.1702367674864;
        Mon, 11 Dec 2023 23:54:34 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id qi9-20020a17090b274900b0028a28ad810csm8144319pjb.56.2023.12.11.23.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:54:34 -0800 (PST)
From:   Yang Chen <yangchen.openbmc@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jerry.Lin@quantatw.com, EasonChen1@quantatw.com,
        Leslie.Tong@quantatw.com, yangchen.openbmc@gmail.com
Subject: [PATCH 11/11] ARM: dts: aspeed: minerva: add sgpio line name
Date:   Tue, 12 Dec 2023 15:52:00 +0800
Message-Id: <20231212075200.983536-12-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_75_100,WEIRD_QUOTING autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SGPIO line name that the project's function can use by the
meaningful name.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 31197183cc59..942e53d5c714 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -392,3 +392,152 @@ &gpio0 {
 	/*Y0-Y7*/	"","","","","","","","",
 	/*Z0-Z7*/	"","","","","","","","";
 };
+
+&sgpiom0 {
+	gpio-line-names =
+	/*"input pin","output pin"*/
+	/*A0 - A7*/
+	"PRSNT_MTIA_BLADE0_N","PWREN_MTIA_BLADE0_EN",
+	"PRSNT_MTIA_BLADE1_N","PWREN_MTIA_BLADE1_EN",
+	"PRSNT_MTIA_BLADE2_N","PWREN_MTIA_BLADE2_EN",
+	"PRSNT_MTIA_BLADE3_N","PWREN_MTIA_BLADE3_EN",
+	"PRSNT_MTIA_BLADE4_N","PWREN_MTIA_BLADE4_EN",
+	"PRSNT_MTIA_BLADE5_N","PWREN_MTIA_BLADE5_EN",
+	"PRSNT_MTIA_BLADE6_N","PWREN_MTIA_BLADE6_EN",
+	"PRSNT_MTIA_BLADE7_N","PWREN_MTIA_BLADE7_EN",
+	/*B0 - B7*/
+	"PRSNT_MTIA_BLADE8_N","PWREN_MTIA_BLADE8_EN",
+	"PRSNT_MTIA_BLADE9_N","PWREN_MTIA_BLADE9_EN",
+	"PRSNT_MTIA_BLADE10_N","PWREN_MTIA_BLADE10_EN",
+	"PRSNT_MTIA_BLADE11_N","PWREN_MTIA_BLADE11_EN",
+	"PRSNT_MTIA_BLADE12_N","PWREN_MTIA_BLADE12_EN",
+	"PRSNT_MTIA_BLADE13_N","PWREN_MTIA_BLADE13_EN",
+	"PRSNT_MTIA_BLADE14_N","PWREN_MTIA_BLADE14_EN",
+	"PRSNT_MTIA_BLADE15_N","PWREN_MTIA_BLADE15_EN",
+	/*C0 - C7*/
+	"PRSNT_NW_BLADE0_N","PWREN_NW_BLADE0_EN",
+	"PRSNT_NW_BLADE1_N","PWREN_NW_BLADE1_EN",
+	"PRSNT_NW_BLADE2_N","PWREN_NW_BLADE2_EN",
+	"PRSNT_NW_BLADE3_N","PWREN_NW_BLADE3_EN",
+	"PRSNT_NW_BLADE4_N","PWREN_NW_BLADE4_EN",
+	"PRSNT_NW_BLADE5_N","PWREN_NW_BLADE5_EN",
+	"PRSNT_FCB_TOP_0_N","PWREN_MTIA_BLADE0_HSC_EN",
+	"PRSNT_FCB_TOP_1_N","PWREN_MTIA_BLADE1_HSC_EN",
+	/*D0 - D7*/
+	"PRSNT_FCB_MIDDLE_0_N","PWREN_MTIA_BLADE2_HSC_EN",
+	"PRSNT_FCB_MIDDLE_1_N","PWREN_MTIA_BLADE3_HSC_EN",
+	"PRSNT_FCB_BOTTOM_0_N","PWREN_MTIA_BLADE4_HSC_EN",
+	"PRSNT_FCB_BOTTOM_1_N","PWREN_MTIA_BLADE5_HSC_EN",
+	"PWRGD_MTIA_BLADE0_PWROK_L_BUF","PWREN_MTIA_BLADE6_HSC_EN",
+	"PWRGD_MTIA_BLADE1_PWROK_L_BUF","PWREN_MTIA_BLADE7_HSC_EN",
+	"PWRGD_MTIA_BLADE2_PWROK_L_BUF","PWREN_MTIA_BLADE8_HSC_EN",
+	"PWRGD_MTIA_BLADE3_PWROK_L_BUF","PWREN_MTIA_BLADE9_HSC_EN",
+	/*E0 - E7*/
+	"PWRGD_MTIA_BLADE4_PWROK_L_BUF","PWREN_MTIA_BLADE10_HSC_EN",
+	"PWRGD_MTIA_BLADE5_PWROK_L_BUF","PWREN_MTIA_BLADE11_HSC_EN",
+	"PWRGD_MTIA_BLADE6_PWROK_L_BUF","PWREN_MTIA_BLADE12_HSC_EN",
+	"PWRGD_MTIA_BLADE7_PWROK_L_BUF","PWREN_MTIA_BLADE13_HSC_EN",
+	"PWRGD_MTIA_BLADE8_PWROK_L_BUF","PWREN_MTIA_BLADE14_HSC_EN",
+	"PWRGD_MTIA_BLADE9_PWROK_L_BUF","PWREN_MTIA_BLADE15_HSC_EN",
+	"PWRGD_MTIA_BLADE10_PWROK_L_BUF","PWREN_NW_BLADE0_HSC_EN",
+	"PWRGD_MTIA_BLADE11_PWROK_L_BUF","PWREN_NW_BLADE1_HSC_EN",
+	/*F0 - F7*/
+	"PWRGD_MTIA_BLADE12_PWROK_L_BUF","PWREN_NW_BLADE2_HSC_EN",
+	"PWRGD_MTIA_BLADE13_PWROK_L_BUF","PWREN_NW_BLADE3_HSC_EN",
+	"PWRGD_MTIA_BLADE14_PWROK_L_BUF","PWREN_NW_BLADE4_HSC_EN",
+	"PWRGD_MTIA_BLADE15_PWROK_L_BUF","PWREN_NW_BLADE5_HSC_EN",
+	"PWRGD_NW_BLADE0_PWROK_L_BUF","PWREN_FCB_TOP_L_EN",
+	"PWRGD_NW_BLADE1_PWROK_L_BUF","PWREN_FCB_TOP_R_EN",
+	"PWRGD_NW_BLADE2_PWROK_L_BUF","PWREN_FCB_MIDDLE_L_EN",
+	"PWRGD_NW_BLADE3_PWROK_L_BUF","PWREN_FCB_MIDDLE_R_EN",
+	/*G0 - G7*/
+	"PWRGD_NW_BLADE4_PWROK_L_BUF","PWREN_FCB_BOTTOM_L_EN",
+	"PWRGD_NW_BLADE5_PWROK_L_BUF","PWREN_FCB_BOTTOM_R_EN",
+	"PWRGD_FCB_TOP_0_PWROK_L_BUF","FM_CMM_AC_CYCLE_N",
+	"PWRGD_FCB_TOP_1_PWROK_L_BUF","MGMT_SFP_TX_DIS",
+	"PWRGD_FCB_MIDDLE_0_PWROK_L_BUF","",
+	"PWRGD_FCB_MIDDLE_1_PWROK_L_BUF","RST_I2CRST_MTIA_BLADE0_1_N",
+	"PWRGD_FCB_BOTTOM_0_PWROK_L_BUF","RST_I2CRST_MTIA_BLADE2_3_N",
+	"PWRGD_FCB_BOTTOM_1_PWROK_L_BUF","RST_I2CRST_MTIA_BLADE4_5_N",
+	/*H0 - H7*/
+	"LEAK_DETECT_MTIA_BLADE0_N_BUF","RST_I2CRST_MTIA_BLADE6_7_N",
+	"LEAK_DETECT_MTIA_BLADE1_N_BUF","RST_I2CRST_MTIA_BLADE8_9_N",
+	"LEAK_DETECT_MTIA_BLADE2_N_BUF","RST_I2CRST_MTIA_BLADE10_11_N",
+	"LEAK_DETECT_MTIA_BLADE3_N_BUF","RST_I2CRST_MTIA_BLADE12_13_N",
+	"LEAK_DETECT_MTIA_BLADE4_N_BUF","RST_I2CRST_MTIA_BLADE14_15_N",
+	"LEAK_DETECT_MTIA_BLADE5_N_BUF","RST_I2CRST_NW_BLADE0_1_2_N",
+	"LEAK_DETECT_MTIA_BLADE6_N_BUF","RST_I2CRST_NW_BLADE3_4_5_N",
+	"LEAK_DETECT_MTIA_BLADE7_N_BUF","RST_I2CRST_FCB_N",
+	/*I0 - I7*/
+	"LEAK_DETECT_MTIA_BLADE8_N_BUF","RST_I2CRST_FCB_B_L_N",
+	"LEAK_DETECT_MTIA_BLADE9_N_BUF","RST_I2CRST_FCB_B_R_N",
+	"LEAK_DETECT_MTIA_BLADE10_N_BUF","RST_I2CRST_FCB_M_L_N",
+	"LEAK_DETECT_MTIA_BLADE11_N_BUF","RST_I2CRST_FCB_M_R_N",
+	"LEAK_DETECT_MTIA_BLADE12_N_BUF","RST_I2CRST_FCB_T_L_N",
+	"LEAK_DETECT_MTIA_BLADE13_N_BUF","RST_I2CRST_FCB_T_R_N",
+	"LEAK_DETECT_MTIA_BLADE14_N_BUF","BMC_READY",
+	"LEAK_DETECT_MTIA_BLADE15_N_BUF","wFM_88E6393X_BIN_UPDATE_EN_N",
+	/*J0 - J7*/
+	"LEAK_DETECT_NW_BLADE0_N_BUF","WATER_VALVE_CLOSED_N",
+	"LEAK_DETECT_NW_BLADE1_N_BUF","",
+	"LEAK_DETECT_NW_BLADE2_N_BUF","",
+	"LEAK_DETECT_NW_BLADE3_N_BUF","",
+	"LEAK_DETECT_NW_BLADE4_N_BUF","",
+	"LEAK_DETECT_NW_BLADE5_N_BUF","",
+	"MTIA_BLADE0_STATUS_LED","",
+	"MTIA_BLADE1_STATUS_LED","",
+	/*K0 - K7*/
+	"MTIA_BLADE2_STATUS_LED","",
+	"MTIA_BLADE3_STATUS_LED","",
+	"MTIA_BLADE4_STATUS_LED","",
+	"MTIA_BLADE5_STATUS_LED","",
+	"MTIA_BLADE6_STATUS_LED","",
+	"MTIA_BLADE7_STATUS_LED","",
+	"MTIA_BLADE8_STATUS_LED","",
+	"MTIA_BLADE9_STATUS_LED","",
+	/*L0 - L7*/
+	"MTIA_BLADE10_STATUS_LED","",
+	"MTIA_BLADE11_STATUS_LED","",
+	"MTIA_BLADE12_STATUS_LED","",
+	"MTIA_BLADE13_STATUS_LED","",
+	"MTIA_BLADE14_STATUS_LED","",
+	"MTIA_BLADE15_STATUS_LED","",
+	"NW_BLADE0_STATUS_LED","",
+	"NW_BLADE1_STATUS_LED","",
+	/*M0 - M7*/
+	"NW_BLADE2_STATUS_LED","",
+	"NW_BLADE3_STATUS_LED","",
+	"NW_BLADE4_STATUS_LED","",
+	"NW_BLADE5_STATUS_LED","",
+	"RPU_READY","",
+	"IT_GEAR_RPU_LINK_N","",
+	"IT_GEAR_LEAK","",
+	"WATER_VALVE_CLOSED_N","",
+	/*N0 - N7*/
+	"VALVE_STS0","",
+	"VALVE_STS1","",
+	"VALVE_STS2","",
+	"VALVE_STS3","",
+	"CR_TOGGLE_BOOT_BUF_N","",
+	"CMM_LC_RDY_LED_N","",
+	"CMM_LC_UNRDY_LED_N","",
+	"CMM_CABLE_CARTRIDGE_PRSNT_BOT_N","",
+	/*O0 - O7*/
+	"CMM_CABLE_CARTRIDGE_PRSNT_TOP_N","",
+	"BOT_BCB_CABLE_PRSNT_N","",
+	"TOP_BCB_CABLE_PRSNT_N","",
+	"CHASSIS0_LEAK_Q_N","",
+	"CHASSIS1_LEAK_Q_N","",
+	"LEAK0_DETECT","",
+	"LEAK1_DETECT","",
+	"MGMT_SFP_PRSNT_N","",
+	/*P0 - P7*/
+	"MGMT_SFP_TX_FAULT","",
+	"MGMT_SFP_RX_LOS","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","";
+};
-- 
2.34.1

