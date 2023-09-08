Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0851679906B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbjIHTqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbjIHTqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:46:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED60E10E9;
        Fri,  8 Sep 2023 12:45:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C53C433B9;
        Fri,  8 Sep 2023 19:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201543;
        bh=Urg/EUF/1ccy/Oc01d4RAoQLRm8rbLpp+Ln7Eb3Gtug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QISUZq+aAFypZCxgAOSkiOlVw/7awu9Ei4QJvMSlVi1+aVX+Y1xHlc/vXTHDW6bzf
         mIav8Ob3MaEljwkQkcPWtXCERjiWZ1+bFZR+kXd5/kotuZjgaUU6tbN1dKUVuiIv7O
         GcSds7/TSS5UzMj1JinaaWJIDgo3r004b5msvQg+IzP8B1B66OGAw70nZV6abH0DfD
         ocEHHtocM68gPFhiTD8FvLRfBF+/lb2t0PrP/BgP2ARXOBGiUpAcK6oJcZGRErVleU
         eFK2kRNOsqA8If4OZljrInkYjfET+ZsTw+LlvDLKQqa+2TXbb//jXarZPJcM2FDv/m
         MtMG0v8SkN4qQ==
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
Subject: [PATCH AUTOSEL 6.4 08/31] arm64: dts: qcom: sm8150-kumano: correct ramoops pmsg-size
Date:   Fri,  8 Sep 2023 15:31:37 -0400
Message-Id: <20230908193201.3462957-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193201.3462957-1-sashal@kernel.org>
References: <20230908193201.3462957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
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
index 47e2430991ca0..698c1a9d9feed 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -161,7 +161,7 @@ ramoops@ffc00000 {
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

