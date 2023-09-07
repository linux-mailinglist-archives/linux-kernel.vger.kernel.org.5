Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ED4797AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245553AbjIGRs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245653AbjIGRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:47:59 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B8E1FCC;
        Thu,  7 Sep 2023 10:47:40 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 4A47D42459;
        Thu,  7 Sep 2023 15:03:07 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694080988; bh=i1gk8JxNVLETk27EA9LrnzcpBehXDaBm+IlRLdJDN/Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=u0KlIlCjEyFQ/R0nNYQyXOnuhQbPxf5Ji00AtK5s+HwlKOz6KYdOaSWKXs5BN0Gfy
         hjtwYeBi9BWSOf0y2PJ/v54DEGr4Iz5JPiQTz93tC0ivdYCC3oJAkiaGOAwTkq+d0f
         QUGe0yWL8R/0O6T8vgXZlFEktQURv4tK973EmqnswrCAbvBm/XMBN2yoJg2lstLo6L
         +PmG81T70PnfpCXULiIAJJeTFvakbKoq/pILbKpiQuvg+nlPKTzqJbQ2eeEgT0k1pE
         znUrLR5XyFHmNb4dTyDMlthoc23hxj04i+jmEu6Kd1hWmPQUG1o3LNVuQL/Qus7pwP
         NHVJ3zU2fJ78Q==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Thu, 07 Sep 2023 15:02:36 +0500
Subject: [PATCH v3 3/4] arm64: dts: qcom: sc7180: Add tertiary mi2s pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-sc7180-adsp-rproc-v3-3-6515c3fbe0a3@trvn.ru>
References: <20230907-sc7180-adsp-rproc-v3-0-6515c3fbe0a3@trvn.ru>
In-Reply-To: <20230907-sc7180-adsp-rproc-v3-0-6515c3fbe0a3@trvn.ru>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=i1gk8JxNVLETk27EA9LrnzcpBehXDaBm+IlRLdJDN/Q=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk+Z/XWAZ81NG9cEWoNg/arlUET6ey+BLy29toe
 Wr9tHGgESaJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPmf1wAKCRBDHOzuKBm/
 dZrBD/40ON6dfhALiXYIP2wA8AEpmPlhYxum0hVFhtLUEp2SrmrFrNDn3zGTI3NJu1lbw4pd3SQ
 bkRptK1wxvCRSqvzchrkIK5/+KkO3Ps10s9TRYykKHRcN1+kWqOTj6LeWOJw2iVKHRedWzFN+RF
 UHdNuoOjVOMO8Mso/6N1IMHNYUzMgrOm3xnPp5Is49Ejv5I4YjQFFPkv0ak6dsKlYZBMfGy/iJm
 2LJQPBYJWia+5gqoMWL6oI/XOr41HuWlKFrxruGWoPRu5/fxQWu1qlX27YmTM/N1Cc6DjXzg/h0
 7g/yKTxlN3D4sebbFhEc8hOgLit+nxUG3IwjNiwAi78ESs86i1sTZ256ORDZPlkZAnU42P82ku4
 iz/Apz1wHgmML9G2UaH73/1jOJinKO/Wzd4jNC33FHHR2yY5mQwEA9hGA1FQD1GZ1qkONcb5cyy
 ui+FZmhralwjDsd7Iroe7Lcqg95a7LAUXFq59wvpLNdpmqFDFLcLMCXGppOcJJFlGW47FJhuOg1
 QvPidWEFhk0BpB89Ckn+IwXG1dSYqN8+h1jXHdTINP7X4eJL6e00jscuZf6+vh1DiEN/v74x8u2
 Ne4cTR0Oh+VxGqHx0bQSjzorpbCld4hpIhhrvjxYhLSMhssLMwQWiLVAV9ei0maYqDsHCqPVjXu
 S64vG9dKwwTjvsw==
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
v3: reorder the node to sort by pins
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index a79c0f2e1879..322fa478515f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2042,6 +2042,11 @@ pri_mi2s_mclk_active: pri-mi2s-mclk-active-state {
 				pins = "gpio57";
 				function = "lpass_ext";
 			};
+
+			ter_mi2s_active: ter-mi2s-active-state {
+				pins = "gpio63", "gpio64", "gpio65", "gpio66";
+				function = "mi2s_2";
+			};
 		};
 
 		remoteproc_mpss: remoteproc@4080000 {

-- 
2.41.0

