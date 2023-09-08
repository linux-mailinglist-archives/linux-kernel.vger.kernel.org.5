Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE015799018
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbjIHTg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243064AbjIHTgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:36:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598B8E49;
        Fri,  8 Sep 2023 12:36:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0797DC116A6;
        Fri,  8 Sep 2023 19:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201737;
        bh=xrgxr4Y8Yed6tOi6JB2L5gdz9bPPYcKHgYGjdAKK5yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1gRCTSJGNyz2fykywXwPQ/z7JpWef2TA419xANErWZPZNsFqtidPgorjsJZgAn8m
         v/cs3WidNkD1bUuizFd1jEuM3DJpTg7Mf4fS4hqvHf7R12EG9BCFH+yPbR1G9Dp1sp
         vNxAB2ekbGshlpLLGIKXB/tTHJtW9M2u8OUShMpAvXvizalUi+Ay6kPGvQbgCApGk0
         Zco3tP52y8lew+LqtERA33gmnKSjtJtAbfN3W9wHj3z2OJqjRXMRyKUVCVce1Hajbk
         A+w9EcIYxIWn/wZ3gBBBciLWQ+FOseb7xQG2B0ut52FSBb2ItPsiJWJBNi7fnmMgPd
         zVaV1K/s+Sw4w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/13] arm64: dts: qcom: sm8150-kumano: correct ramoops pmsg-size
Date:   Fri,  8 Sep 2023 15:35:19 -0400
Message-Id: <20230908193530.3463647-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193530.3463647-1-sashal@kernel.org>
References: <20230908193530.3463647-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 4e6b942f092653ebcdbbc0819b2d1f08ab415bdc ]

There is no 'msg-size' property in ramoops, so assume intention was for
'pmsg-size':

  sm8150-sony-xperia-kumano-griffin.dtb: ramoops@ffc00000: Unevaluated properties are not allowed ('msg-size' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230618114442.140185-6-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index 04c71f74ab72d..c9aa7764fc59a 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -127,7 +127,7 @@ ramoops@ffc00000 {
 			reg = <0x0 0xffc00000 0x0 0x100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 			ecc-size = <16>;
 			no-map;
 		};
-- 
2.40.1

