Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5995F7D9BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbjJ0Onm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjJ0Oni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:43:38 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A9C4;
        Fri, 27 Oct 2023 07:43:35 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 8279B40553;
        Fri, 27 Oct 2023 19:42:48 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698417769; bh=/wvspNZ6UnwHBJSoNffLyGijS/yc+9Bx1gjik/P77pE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=0TKezU14dvQYvmZVCGhrOkT0XMcQVoePyWFa1I3rRm6mX4nIMDQkDiluXU7Jy+xjo
         5b/L/FgM0buo9gOBYyYQcJ9diV0i55P2iwvM2ByaMHUZj5uudoONCyJUSKUbC7KuCN
         PAyHpkQ+WUrDvkVYgCreFW4JCU8XFe0KCrycBlJZaw4toIVjZi7IFsoKCwfaao5DIr
         sbvcDPg1Tm/+LDEEMTmIsv7Yf0yOWj9uygWUSsmWPQd+IpxHQuZFL+sf1IE6dsEfoq
         RS/KkKO1QhFH1HHNm4hnCPfOV31Nh7GIWcKuP62bg+OpO+HGwb60otqk7xY2YcmUOh
         HWS2tuk+XdVIA==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Fri, 27 Oct 2023 19:42:21 +0500
Subject: [PATCH 1/3] arm64: dts: qcom: acer-aspire1: Enable RTC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-aspire1-sound-v1-1-5ff3cf8b5701@trvn.ru>
References: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
In-Reply-To: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=693; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=/wvspNZ6UnwHBJSoNffLyGijS/yc+9Bx1gjik/P77pE=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlO8xbT/dr4P0OR1A/Mcg7Izk15NCEbz2Ss101B
 ClTp7VwQNaJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZTvMWwAKCRBDHOzuKBm/
 de0FD/sGSQp699iOGnsKkb4UdbmDIxMt8Iwx4iwbvxX3zqcano/O6E8lu9tmB+ZXUMRR874ni3Q
 ZaysymuK1cCXW02SL2Kq14OzUj/o+hw9kYpHstfGS5dZjxErMPMcHwhn3xl+63C9yEdi61cElBY
 9hZ69fmLwbGzUYxcu/2Ed3janX1ee42nYa49iTA2TklbczxFY/RFCrEOzBBL5yckqFcYD/z4Ry/
 l0/lRlcmiypWpNX+rVDO3l0VwbmuOvXGm6cmk8qzWOtDH86/lIPtFb17IAo1pgdgPmdLxCbMAyN
 Zomz6AbKBmVDtFiLbBnqNAVRp72VF1jbjQaNX/J7fE1bjg2qq60Intb9LshPCXYklW0wm/illaa
 cCXREzzvHgTO+7oZ9tzgPT4K+FRqnGFxeMlfhb9CfWpIW2t+R0+AZXo4amdPJrpowe0RPddm0W2
 ScZbpYQGxYMiUR3/t81JH2fV9ynRL8VtqqiGvbGafMyN3lOauIy5ws4d3BLheCjZcGnuP8czll1
 nSQENoP1olh46Hiut5DZbji7iGN+l/gF7W3G23u2LI6sqXuyqleO2qdtDpTNsxz1o2mofXsSUZ+
 x26pEBIus5bkFChiV8q4YpDUwUSX/vAdFs6dJmwTJs3R7NP/Zp0LT4I4BPOMQcAPskO06JNGalH
 Y5jXKc9ZqA3o72Q==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm6150 has a read-only RTC that can be used to keep the time with some
extra userspace tools. Enable it.

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
2.41.0

