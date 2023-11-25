Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751487F8AB0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjKYMUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYMUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:20:03 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA295D6;
        Sat, 25 Nov 2023 04:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1700914777; bh=UdGEv17E3hADi12SsQvKXsMSfqGDSsuNeaYFESGrjdk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=wTpPLHW8z7ca6AJhErXFAC4R4WnTbREJAmiDLia0GxyUp5/5Q4KHlTnKg6iDlkPna
         kTo3ROnMqYdJnI/wQnZYfh3FXJqaxfSDzd6CXb/RqR+dg7BcOM00LVIPdIuOuK1jVu
         CYtOC+Wfe6hlDyKLngymph9mCDMh31rQS4pYFshg=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sat, 25 Nov 2023 13:19:27 +0100
Subject: [PATCH v2 1/2] arm64: dts: qcom: msm8953: Set initial address for
 memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-msm8953-misc-fixes-v2-1-df86655841d9@z3ntu.xyz>
References: <20231125-msm8953-misc-fixes-v2-0-df86655841d9@z3ntu.xyz>
In-Reply-To: <20231125-msm8953-misc-fixes-v2-0-df86655841d9@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=UdGEv17E3hADi12SsQvKXsMSfqGDSsuNeaYFESGrjdk=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlYeZXvatWXYJzXEZ6FjI5/HS4cRAQyBJuohxSV
 V7kqHpbO1KJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZWHmVwAKCRBy2EO4nU3X
 VhMHEACjjLgF+I7uJI59zY9sXv37xkBYt5o69pWh54DCFVOcMb1RHJ0Yop4cvkZmwa9hA/S+gBI
 sDmfSXsYGvqpZ3TdHf4uyZ4Hfxsb27bv+ltjLvluvzZColbtZVKK9tmvT9j9kq2RixrUWQFBUME
 1DE9+74FQKqX9hTKocOwS4nkBcv3rV4bgnoz+ZZJ3+zQMi4ZCDEYKcSSOkFP2CI9h+4OUT1GK3V
 q3W5vF8M+972KQxSC/Yi375dIpqyqeHlU/pLISeVs+TTu+vZVo/hPRruAtyT71oe1DyFwFcU7c8
 7L26cQuu3IMWkaFGkOSBj51727SsTHEGFrFLEYo7jMoQ50BJjAnLBIPJAU2t8DeHQCNgkR4AVql
 pms9lVmHXIV8X/xxJLp9D9ZhlF4pmr1+GFhor5xkF9S1pn12jk966c0NQOwDmgdjOoaYy/q8sZG
 MGx1TxLnsS3LAiIUJ+3RlJcj8p/msQD4lN5iL1rP/EnLi6QGodBqyjxd1OlEKzjsM2JqBMUIKHw
 7M5QpIYRwFHZwairzNMfMOs8ktp0k/7uApMZ9U1HPmHLEB7tPWNrt8f5Ru9AEB660ylGNReATA+
 cOwOJ+WnPQjjC9Zk3baI2ESMO4HDIjJDCO2oxXuKTyWUHcCSA01ou9UElDzL+7K9gIkJfNrJlSX
 bcOvLIVjE1KtfnQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtbs_check really doesn't like having memory without reg set.

The base address depends on the amount of RAM you have:

  <= 2.00 GiB RAM: 0x80000000
   = 3.00 GiB RAM: 0x40000000
   = 3.75 GiB RAM: 0x10000000
 (more does not fit into the 32-bit physical address space)

So, let's pick one of the values, 0x10000000 which is used on devices
with 3.75 GiB RAM. Since the bootloader will update it to what's present
on the device it doesn't matter too much.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index e7de7632669a..a3ba24ca599b 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -174,10 +174,10 @@ scm: scm {
 		};
 	};
 
-	memory {
+	memory@10000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the reg */
-		reg = <0 0 0 0>;
+		reg = <0 0x10000000 0 0>;
 	};
 
 	pmu {

-- 
2.43.0

