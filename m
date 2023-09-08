Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F24798FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjIHTeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345010AbjIHTds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:33:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7DCE43;
        Fri,  8 Sep 2023 12:33:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932DCC433B8;
        Fri,  8 Sep 2023 19:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201541;
        bh=Du3vWgVnnjM2mFAct+jBLCB9mh4ASU/R+4e/CHQuAPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9yxm261tKsj/wucpQmEphXb+EwjJDhSgP1FD/N/Os80ZfkRobWwp0OZm8PguPUVh
         GHjrHQz95x0m97W92gOQ/CbK59dF7ic2HkWALdUdSZW7E0ulyQ7efC+oTiSUtNBdBu
         fW7sqx+WyuWdH9YOh9DYbVX2LFfsgu7VxXAhR9EONYF9AtAdvWoMzz2WJAHYWQoAel
         D7TkcLLqYmkA2ZETBKWo+yCuRldWJYZSXnWDLDG0G/Iq4BR4gTXLScbNZrFyeyyWJD
         LRLzHz/yV1OYgTEw96YhdpgKl3tUByUg1JWjvSDHy7266Myz0PHwGc/DiTpDrkGU8b
         LBa0UXceEASig==
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
Subject: [PATCH AUTOSEL 6.4 07/31] arm64: dts: qcom: sm6350: correct ramoops pmsg-size
Date:   Fri,  8 Sep 2023 15:31:36 -0400
Message-Id: <20230908193201.3462957-7-sashal@kernel.org>
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
index ad34301f6cddf..332c7a8fcd6b0 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -513,7 +513,7 @@ ramoops: ramoops@ffc00000 {
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

