Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5A7929E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354532AbjIEQ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354319AbjIEKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:41:34 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F2199;
        Tue,  5 Sep 2023 03:41:30 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 2F2FD4242B;
        Tue,  5 Sep 2023 15:41:26 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693910486; bh=94WYtO7i7RiviKXkVzwc9KKusQ2/IejlQ7IgqMIIY1A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=L80XpvZU7H7SvQt2ecdc898YK/WBUHJHnwHKmNwTZ2/WEgxV1+RWk1VNsFQGhI0pc
         0iT3j7DBHu3CSfFQIB+HCOZIqnvv3NxzSAa3p1EuVMOAINBNMO1OCnzLCQ+dm9KcIj
         fIkX7r+Kv81tyYExW5i2tp1tn/vE/JPTVHjK5cSJUTATONI1ARdJMmqFZ8zhmZhWoF
         kW47GxDuuUO6ZbRPJG7ek79CWskn1/Ff51xbWwgAanUMHZrhXjQsGtNVQHv0OP2X4I
         LN/zhOBGCTh647odYTSWztbo2Fr4By7Ic5D5o/4/BRwRIk3UO9/fb655EDX+PPf7jk
         Z8IBZuDi/WP7Q==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 05 Sep 2023 15:41:06 +0500
Subject: [PATCH v2 3/4] arm64: dts: qcom: sc7180: Add tertiary mi2s pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-sc7180-adsp-rproc-v2-3-8ab7f299600a@trvn.ru>
References: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
In-Reply-To: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=94WYtO7i7RiviKXkVzwc9KKusQ2/IejlQ7IgqMIIY1A=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk9wXTsVlB9eNjv/aj1o7kXK7yZ7p9bFsUk6VH6
 6c9KvgEiZiJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPcF0wAKCRBDHOzuKBm/
 dZVSD/4pbLCXZoltv+ovAsy2xX5qonlpOXEjzAzwzfDgsV5xwBND0zuHByzRO2B8hZXRQ0fFIE6
 kWcVMHxV/MgE4w4x3LEJyt13MqWGb4s+Ltas2yESsWZ5xDfpkVq/sfB64ZNCHcldIrmrJlKDAIs
 viH7wlO+MBgnnr3ZnY4q30tyekLkaQ+p83ZrBSErxOAY/MDaGWFz+VFb96jEigdhYw/2iG74Lqo
 u0WruZdEvZuXL3QxWz09xqIpAWP/A0XrNuJmrUXJvbxUnXYJx9VGgYTJ7yyBFYHTmE7Qu6LRTyt
 MDVl3XBGxtMJ5pli6AA5MwG/zav0YfF8AblFNswUBf9prRkL9I/SnuqKHEjVbvR9tPpB3hl+18d
 3jThIgKr4zoay5daajLHGse6b/8VYNYUNXd836bvQRfnl7w4egl2lRyIOB0FS20My/zEpVl2Gf2
 CoOpXa+hFANluxZMTmCCzu1ueqJhVKO/T2nEca9i1Z+GXeBXUaN7rpP4Y/qalUCltNn7fkPgkSa
 zUBuh3HMYh+IcGOOBZLE3LF2ev4+mXCy2IDSUgcOKGa915TliDdnL3gbHLTXHOihUAvEMGE08H5
 KFiDTZ39TZTKVAtqyj7JxwPinjy9rEL7X23td3qL6wdxCfUF1NkVcfRHoK0cJxn8w14pc9WcA4B
 UxMx9/6ej979Nyw==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices use tertiary mi2s to connect external audio codec.
Add it near the other two i2s pinctrl definitions so the devices don't
have to duplicate it.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index a79c0f2e1879..9f68b5ff0030 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2033,6 +2033,11 @@ sec_mi2s_active: sec-mi2s-active-state {
 				function = "mi2s_1";
 			};
 
+			ter_mi2s_active: ter-mi2s-active-state {
+				pins = "gpio63", "gpio64", "gpio65", "gpio66";
+				function = "mi2s_2";
+			};
+
 			pri_mi2s_active: pri-mi2s-active-state {
 				pins = "gpio53", "gpio54", "gpio55", "gpio56";
 				function = "mi2s_0";

-- 
2.41.0

