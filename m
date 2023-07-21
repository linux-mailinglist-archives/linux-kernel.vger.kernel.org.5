Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3275C16D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGUIWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjGUIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:22:45 -0400
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0683935BB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:22:16 -0700 (PDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198]) by mx-outbound15-196.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 21 Jul 2023 08:22:03 +0000
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-666e5f0d639so1036825b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1689927723; x=1690532523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDM7nE/kDkBUUCIWdECWtqZB+MuR9RP67EhfBGiTieI=;
        b=Eg1JBvCWIBmDC+6Pb13Gg84fx2zjiv2w+FtI9sCz+h7m8nzrs7oZOpvHsBDnQkIdoG
         fiOWpeYtNa6hpX6hxtSFiAYOlmWm4HhVhhZ573B/hrjeFG4/2NRbUwiSZO0dl+VUSrEA
         852ldklqI1jw8/FVFmd/vLp/Xfa+CAQ6ryBvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689927723; x=1690532523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDM7nE/kDkBUUCIWdECWtqZB+MuR9RP67EhfBGiTieI=;
        b=cvKvF0863NQkHpzh52Siyj4bMb8zTEKGzQ9VGDqBtcxI6wAz70M3SNezm0YALfmmUK
         leItgzrmDDgEmZ74ZxzzWqFBdXboJxqp/dPUToH3ZnXpofEvvXAnJ8eIcLTs+GEGal7M
         BOoEoljxxlDvXLrZb31jDHH0LAuCeaAj+TCCq/nnUleW9nIwcmzD3RciAwMhAdTZwp/y
         J2M1jcZsdH0WLTI87kDjE2MM5Lb2p+NUAPZVemha0TzxYc9Vs7kLGiNvhpRRNz9twjLs
         ucjDNFL7QEfXHFQ/9AK/4Q9waS9x+7aagf2wXBS4kTG8GZq6NFJSbRjzu8PHl1BA9sT1
         EmVQ==
X-Gm-Message-State: ABy/qLZXHBpwN7f4zbGXv+dZFL5xnqe6W02pVYGdxmjG9tsW+dvnrvx2
        UMCNkOFdA2UUAM0UlaFkaRtvt7qBR8BZpmsEfACMqiITFQaNl4JOKiUfUMUOfXoZU/qDsylkILb
        q6DaVz1XjCgXt5HtYpHd6PEQreQlohHmRyIMZqucV62pM7mK3Qe+TP679Cwb0
X-Received: by 2002:a05:6a00:1815:b0:682:7d8a:f887 with SMTP id y21-20020a056a00181500b006827d8af887mr1374959pfa.30.1689927722753;
        Fri, 21 Jul 2023 01:22:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH1Zxf6TXBn6XQFYUPJY1UwCRxTdKLh2FyF2lWdphifFelNW/n/A1CaxQ4JnWv62hoz97NZ9g==
X-Received: by 2002:a05:6a00:1815:b0:682:7d8a:f887 with SMTP id y21-20020a056a00181500b006827d8af887mr1374934pfa.30.1689927722389;
        Fri, 21 Jul 2023 01:22:02 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:6308:2db:e8cc:7446:e541:858e])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78dc1000000b00674364577dasm2404155pfr.203.2023.07.21.01.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:22:01 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V2] arm64: dts: ti: k3-j721s2-main: Add dts nodes for EHRPWMs
Date:   Fri, 21 Jul 2023 13:51:50 +0530
Message-Id: <20230721082150.12599-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1689927723-304036-12349-4952-1
X-BESS-VER: 2019.1_20230720.1826
X-BESS-Apparent-Source-IP: 209.85.210.198
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNjAxArIygIIWRkmJRhaJyW
        kWRpbmxmZpBuYpJqaGJonJqeapqaYWSUq1sQB8vQO4QQAAAA==
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.249629 [from 
        cloudscan17-1.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Add dts nodes for 6 EHRPWM instances on SoC. Disable EHRPWM nodes in the
dtsi files and only enable the ones that are actually pinned out on a
given board in the board dts file.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

Changes in V2:
Addressmreview comments:
- Removed unneeded syscon compatible

V1: https://lore.kernel.org/linux-arm-kernel/20230713114021.28450-1-sinthu.raja@ti.com/

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index ed79ab3a3271..2fb90b899560 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -58,6 +58,72 @@ serdes_ln_ctrl: mux-controller@80 {
 			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
 					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
 		};
+
+		ehrpwm_tbclk: clock-controller@140 {
+			compatible = "ti,am654-ehrpwm-tbclk";
+			reg = <0x140 0x18>;
+			#clock-cells = <1>;
+		};
+	};
+
+	main_ehrpwm0: pwm@3000000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3000000 0x00 0x100>;
+		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 160 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm1: pwm@3010000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3010000 0x00 0x100>;
+		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 161 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm2: pwm@3020000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3020000 0x00 0x100>;
+		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 162 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm3: pwm@3030000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3030000 0x00 0x100>;
+		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 163 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm4: pwm@3040000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3040000 0x00 0x100>;
+		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 164 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm5: pwm@3050000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3050000 0x00 0x100>;
+		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 165 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	gic500: interrupt-controller@1800000 {
-- 
2.36.1

