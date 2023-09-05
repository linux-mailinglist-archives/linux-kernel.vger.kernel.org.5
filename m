Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A444A792B3D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbjIEQuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352448AbjIEFsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:48:21 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5D312E;
        Mon,  4 Sep 2023 22:48:18 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 6338B4243A;
        Tue,  5 Sep 2023 10:48:08 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693892889; bh=94WYtO7i7RiviKXkVzwc9KKusQ2/IejlQ7IgqMIIY1A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Xxobzq4e56Z/axil1YXKVBtmxkgQnPwkEmrYnwH4JP96sEru1rhQ+GT+qo096OK+k
         5uc2zPZkW9193QUh/xbQgo2Y3Fzane4PrIt2RulTpWIQ33f6TZgAR/ehXuwdlgli+U
         l9l9k5caZSoHl6aBJjM0sM4LlFUo8rJw1guiKhzhdq6IyZPbUGyCw5q6BqxwiDM0PI
         G6JYliotfKeMJ+TC4pDnR+y3ypfH7GZNMIxCk8PFnAmTjVEE3tFeX/211DnR4FYbFk
         rSUj9o429TiPMOZVxt3Ekh00AyRrcTK1Ozdo97NzbErXQBWLZN0WuemkafUFPW92Jm
         el3wcGpbMKckw==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 05 Sep 2023 10:47:22 +0500
Subject: [PATCH 3/4] arm64: dts: qcom: sc7180: Add tertiary mi2s pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-sc7180-adsp-rproc-v1-3-dfea7699da7b@trvn.ru>
References: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
In-Reply-To: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
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
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk9sESU0L+EdBYL1kTsdO/1Nw58Zav86S5JiNIZ
 sYf2KS7ViuJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPbBEgAKCRBDHOzuKBm/
 dRKWD/4tG5iumQ0FRqT3xRYJEgsOGxa+st3+/TACrblG7ryPFTIWqnOED4TWIpvi0TJJrMjTCRB
 G8LvRpgheE8jzdoHQ8Ma1b1WWx4NDBQh/Ugw64KbuMZSjju7ZX4sRdKc2kmntTibyy2/RADNdRy
 +vxPlCbk65DqbmWkmihIM0NGvjidajE55CJDUv2Oq2aquuAQ29n3kW2t3H22rhqb3GSJa0xzmlS
 UYVWr8i9zuCr0H/KnmxAybAes41nUJTRFvL37ZI49w7hlbeoqwQvD5UuKfmpSRPus2sfMEPCs9C
 TDHR6y9wH5TfDfE7qIbBIhAYMz+KX2LTCmhSrh5BhIxyN5FVezovQXG5xp0QMNwYpnhFA4A0Hh4
 Qtu2AaMrWt15laoELeLr1G25qGEP0i5bw05PLzGmZHcsR7mk5Ro7YvcgbIlQUxF4ZBG134yrxYh
 eB7PxCP7qyFR8zslOntNYqNnwYch+JZ+VkYjHjrk0eMC1GdM72Dj9ZOCtjU/LCYRnZpEBFDlnb9
 iQXej1cyWLIr4H4fdqvMK82NgSkF0yGS2llkxkRskZW5sjfjm8xeBSg8AqEN/bwL0gFPfHh33YO
 DRgOqHoPZ7b8EU7UL6soVCc0JOkAVLzNAdAC8yRo7WUOngqnaIVCJk32sjHcqXYHrpdxdsyT9p8
 za68eIcLj6TMmHQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

