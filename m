Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835A280536D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442230AbjLELtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345333AbjLELtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:49:06 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27F2134;
        Tue,  5 Dec 2023 03:49:10 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 43CCC42C07;
        Tue,  5 Dec 2023 16:49:01 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1701776941; bh=gzWF3rdaRNbWM6Y2yZtA77FcwsJjOf5PGoWi8i750Xo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lhiareoJVkyKa+j5RnoheyFJHu96mFQR5baaaAt2teY9wYaCRp8dXEC9o+SFc1k5I
         bgYHkVv7gjkGx3JP6ncuyvcI+jpXjMXr9Z3FyaOF9418XeT+8IVuYvbGv4ysk+P3ss
         cUQmqMALgEIckU8/fx/t6JZu6UJZLNq7y+1LSJOyZPspGlT/4UqBDc5Uecp8ZS2QQ9
         YLjKut7c+mKP8GUqSE7AwOPiLercPz5fBTh3E1FsSphCb7C9SrvXd2td32yIL0kosY
         eDWg52iy50W/bN75nQu5Sa2+gWoZ32+h6ldMZbyDla10pzr6WtptZY+3HYcvLApSkq
         mZqmCzbqgs9fQ==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 05 Dec 2023 16:48:10 +0500
Subject: [PATCH v2 1/3] arm64: dts: qcom: acer-aspire1: Enable RTC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-aspire1-sound-v2-1-443b7ac0a06f@trvn.ru>
References: <20231205-aspire1-sound-v2-0-443b7ac0a06f@trvn.ru>
In-Reply-To: <20231205-aspire1-sound-v2-0-443b7ac0a06f@trvn.ru>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=748; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=gzWF3rdaRNbWM6Y2yZtA77FcwsJjOf5PGoWi8i750Xo=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlbw4rvT0YNWWRpsHwuZVuY4BuWm14Ne3fzXlr6
 ZlrU7GLmziJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZW8OKwAKCRBDHOzuKBm/
 dbfKD/4qo1ZDIMxmH0MuvxWcfpX035PV16r8ksEZIp/1FF8ahUYBp9adjlQQXKn4x79m3CC7thw
 YlR8s+4GwbzZyg8SqoSfEUMRPFwv7egKn5r1y/nUvpCUHRfpUwiPxkggH7wG0pRJ/T1kf4w64vJ
 VIqh/oJUhoScAQgRmY8VrMj0gGl2TcIvTZOHcFrRP9U7L2pprvlM2e5DZo10lbvB7ZSiQsFzGfk
 uwpT5JG6ad3bIsHE9h+eIQZ/JS+SYYF037X5v/LcX5pKgUTX9NecQnvFoU14ayh1FopQaM8FUTf
 J8vJdUzrcr8prsQwJRoUTDZ0eH6k8JnwS9PF1qTVvS0ZWgwi1FgO8Q43mLXkWWmCKXr+oakotxx
 KUFHsUCFr/0ONwysN7M7Wz3bF6QCEYVBq+M/4E2Y1lIX2FlmOkw0Q2wAxbDiuvGwywu04bMgPLo
 zaMn4hrvFEguAyIySNBlEx9sMmWBH5cAdiQPzZ/WMHV9szIt+KcenHxlfjlRufCV+v0aFlTUUdb
 iaHUPQw6hn0k72MIqUSvO2JgGs7mhCE2co+QE1r5r7syWpPXYnQZuNaqI0FtFAeeWNvenXR/IQh
 zC6/8fU5komivzNFqoSejqm9o0TKwodsXXSoo+cjMaJfWexcL0mOXNQnm0Yl8+WKCjSBBWXuwR8
 FDH56GH4lD7RLQg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm6150 has a read-only RTC that can be used to keep the time with some
extra userspace tools. Enable it.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index dbb48934d499..cfde8cd47107 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -351,6 +351,10 @@ &pm6150_pon {
 	status = "disabled";
 };
 
+&pm6150_rtc {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

-- 
2.43.0

