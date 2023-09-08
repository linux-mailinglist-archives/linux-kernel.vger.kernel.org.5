Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45620798F15
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbjIHT3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbjIHT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:29:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C5CE7;
        Fri,  8 Sep 2023 12:29:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521BEC433CB;
        Fri,  8 Sep 2023 19:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201344;
        bh=uHO+Q/O3TUhiy98/0vOrynfp3LhqdOsayA4/p5By93Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmuxtttLS9K2w48N7iYGYq++K1R7R0Fk88KWReQ31viVnUV+WTo1hhS6w9JLDZjJx
         +KjNoxO3PPXCRLGID1qFjvPn1f7vrpyLsa1dTV1m8VWLOgEWDhEECOH9Hcv0UUcJnd
         DBE89VSrJNOI+jBNRPogR28+PJ+H2RNce0lXsqVqY1iUAQ8PJVIUdPa2KyiWd+KPBU
         jn5EE7MPgmuGWiSNgLtnEBLrPYfbaTa8Qv+8qWw+BMkGutYFBoU1Al/x/b72owRTjf
         CQL5ZjiusWKTFrMqpIA2Of0go2OiMfjeAetFaBQ1k9o92BUYe1XHwHGnTLMtZLHP8h
         HbuzAJoR7iXxQ==
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
Subject: [PATCH AUTOSEL 6.5 06/36] arm64: dts: qcom: sm6125-sprout: correct ramoops pmsg-size
Date:   Fri,  8 Sep 2023 15:28:17 -0400
Message-Id: <20230908192848.3462476-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908192848.3462476-1-sashal@kernel.org>
References: <20230908192848.3462476-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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

[ Upstream commit 2951e7e7611a3ea04de98d0f1bfc4e7ec609ef29 ]

There is no 'msg-size' property in ramoops, so assume intention was for
'pmsg-size':

  sm6125-xiaomi-laurel-sprout.dtb: ramoops@ffc00000: Unevaluated properties are not allowed ('msg-size' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230618114442.140185-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
index a7f4aeae9c1a5..7c58d1299a609 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -52,7 +52,7 @@ pstore_mem: ramoops@ffc00000 {
 			reg = <0x0 0xffc40000 0x0 0xc0000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 		};
 
 		cmdline_mem: memory@ffd00000 {
-- 
2.40.1

