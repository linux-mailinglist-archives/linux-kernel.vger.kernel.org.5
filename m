Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758A0798FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbjIHTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243999AbjIHTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:35:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996941FD5;
        Fri,  8 Sep 2023 12:34:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52335C113C9;
        Fri,  8 Sep 2023 19:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201657;
        bh=QMmeLRSiRWbRogfiw01mWm6eX/eA17b2tIZlPL1WIwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yvwqx2Y0lVLnbOICoEHlEAPy2xEldKHIbRGb9fZL8/uef/PtywnLG+Q9C2Qgl8U8Y
         dPNtdyae3jjq6na44y1qBhGtdaye8x6j8aqnBu/SiQZmisHK9rPSZ399G5Z6YnNl2z
         pUvAWLA2ZEOlOiEU0jLfaAlSTxnYr2du5I3pw+7uespseYeToFixHQzib95He+3uFm
         /nF5KmGaMcNTMA1ctPYex6V+MLTfl2gQICKEK+X3LB/Gzzut3GqeBBAHFVL90EMdzT
         knKVpZvR/6/Ltp6kHlog4qAeiVHGa/f5JFs25jhjCFNwnUlGD9aDO/V9aG4rv8J4kl
         hw4QO/Fv4mClg==
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
Subject: [PATCH AUTOSEL 6.1 04/22] arm64: dts: qcom: sm6350: correct ramoops pmsg-size
Date:   Fri,  8 Sep 2023 15:33:48 -0400
Message-Id: <20230908193407.3463368-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193407.3463368-1-sashal@kernel.org>
References: <20230908193407.3463368-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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

[ Upstream commit c86b97a72065e06eacb993dc71fa9febc93422af ]

There is no 'msg-size' property in ramoops, so assume intention was for
'pmsg-size':

  sm6350-sony-xperia-lena-pdx213.dtb: ramoops@ffc00000: Unevaluated properties are not allowed ('msg-size' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230618114442.140185-5-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 35f621ef9da54..6a419afeb1a03 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -346,7 +346,7 @@ ramoops: ramoops@ffc00000 {
 			reg = <0 0xffc00000 0 0x100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 			ecc-size = <16>;
 			no-map;
 		};
-- 
2.40.1

