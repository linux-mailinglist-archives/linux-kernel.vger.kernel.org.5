Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BC07A30C4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 15:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbjIPN57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 09:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbjIPN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 09:57:40 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC051CE7;
        Sat, 16 Sep 2023 06:57:34 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 0869D42497;
        Sat, 16 Sep 2023 18:57:29 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694872649; bh=847j1rUWJlDoCXhmyrnEuR7Aod2ZrxmdyV8KuAPhF8g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qyfkTH5Ej1qAyM2T1MMB2hY/k1qjl2axIRl/dfmpHcQKZGtjsakR1oReChRc5jnuf
         TinOxdFiK5XItql9pKaf51Sx8ZwfIMVkvNp3syu5Aybf6A1M3PXqXhS4AFJkvJ4bQw
         upL+xYkFCeBGOmWKQb5REAmip1weRWI8lnnsz7//V4H6wLyusZWv2j4/hNmtMdAZYo
         bNAbI+0ill6FNscnq1YoddJFTUvxtyIT0PR7/ICUqWC/08wSrwprFHCogjRVaWsD/h
         hbMQAkJHZSz0c5G2WFnfiIRv96kV0YzryDynmtweYvWEWQ2QbeJoyXuY3gt6zgMvaO
         afv75LB1hEqEA==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Sat, 16 Sep 2023 18:57:05 +0500
Subject: [PATCH 2/3] arm64: dts: qcom: pm8916: Add BMS and charger
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-pm8916-dtsi-bms-lbc-v1-2-7db0b42f9fb1@trvn.ru>
References: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
In-Reply-To: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2360; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=847j1rUWJlDoCXhmyrnEuR7Aod2ZrxmdyV8KuAPhF8g=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlBbQ7E/Bvhtz4C1q2oHH6JfjSWnn48h6MmpVQc
 NJYTmCgJImJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZQW0OwAKCRBDHOzuKBm/
 dZ7ID/4kmWxwrFkSKflGg9d7sObwPEj3GDmKlDRwMS+Gz9ONTbicJYLjF79R8q28jYC5L+XA+Pu
 vMnqhMIoODfHBAL6su+0ZcDcUQ2isX/OiqeOh2BNBdWskSR+RQf4yaMZo9AUosDdU5tRx+lNYmG
 MMlv0WxaTB6M+cXRJACOHI26/Z0vwOefwEVmXOGtWDfHCpGl9+4H/qo0aAGbHL/z+i1l6e7TOYs
 CcleLZlw23Pp4+gDdxpgLoH6o2s3BDMmFlb7SytyQ9j8IiRdJT0fbFuUm/aX5ec8h7gBMUo35my
 limVuUPkEVtjvjzSvQExSmQrIZ/CUsh3slk3uVnKiRpb4gUMr7Vyk2rQ+ren/icEGPhqTsklEcX
 ndS2Vj5QcLY14RnjHCb0DG2sMXNJy7j6hFLzB8DNy91LQgiNiEs45OxgYbCugsDSqx5IhA0lfcH
 Sxt87wDUYfZZr7GMUWJ6SXGy+ejZyXWBpTPBwQQtiAO1UX9r2I9HxR/WCA9Eb0vwPo0xqnGXzH6
 NOZa1p/TMJCA6mdNCymWZizzlIEAPI8v6KvpgVYcjqVdbZNc9d7fHW+eWCNeWDKSZy9NTVH4u5R
 k17zMLK35LYzEMza8BsPBKenntbm5/3SypOfWcXKODrLPF7Ru9Ofc4lFPXknXZLm/ov+rOWWp45
 o+brSB0giSay+aw==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm8916 contains some hardware blocks for battery powered devices:

- VM-BMS: Battery voltage monitoring block.
- LBC: Linear battery charger.

Add them to the pmic dtsi so the devices that make use of those blocks
can enable them.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/pm8916.dtsi | 48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index 223442f909f1..24690cfdabb6 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -41,6 +41,35 @@ watchdog {
 			};
 		};
 
+		pm8916_charger: charger@1000 {
+			compatible = "qcom,pm8916-lbc";
+			reg = <0x1000>, <0x1200>, <0x1300>, <0x1600>;
+			reg-names = "chgr", "bat_if", "usb", "misc";
+
+			interrupts = <0x0 0x10 0 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x10 6 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x12 0 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x12 1 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x13 0 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x13 2 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x13 4 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "vbat_det",
+					  "fast_chg",
+					  "chg_fail",
+					  "chg_done",
+					  "bat_pres",
+					  "temp_ok",
+					  "coarse_det",
+					  "usb_vbus",
+					  "chg_gone",
+					  "overtemp";
+
+			status = "disabled";
+		};
+
 		pm8916_usbin: usb-detect@1300 {
 			compatible = "qcom,pm8941-misc";
 			reg = <0x1300>;
@@ -91,6 +120,25 @@ channel@f {
 			};
 		};
 
+		pm8916_bms: battery@4000 {
+			compatible = "qcom,pm8916-bms-vm";
+			reg = <0x4000>;
+			interrupts = <0x0 0x40 0 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x40 1 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x40 2 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x40 3 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x40 4 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x40 5 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "cv_leave",
+					  "cv_enter",
+					  "ocv_good",
+					  "ocv_thr",
+					  "fifo",
+					  "state_chg";
+
+			status = "disabled";
+		};
+
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>, <0x6100>;

-- 
2.41.0

