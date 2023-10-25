Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F757D656C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjJYImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjJYImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:42:08 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D52D9C;
        Wed, 25 Oct 2023 01:42:06 -0700 (PDT)
From:   Stefan Hansson <newbyte@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1698223325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PlCQ+ZrJ2KnIONYyu5EKJVJa1cceO7WNfqL1V47Gmf4=;
        b=NklrLQe9I0Kvv7+9iWAoz5vtIZrj/VVrLj+pgLMnVoj599XDPUFG30OY2OjB2IsPMw+hUl
        8XTtPsg/JVODiBQy0SaIbcPeoIE2fhBendngHOLcOv6+pIEuJlHhPSpFl+5bk9dy6krdF3
        6Z/0kiJOC2xd3IPTZHK8hm/nx9zV+zE=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Stefan Hansson <newbyte@postmarketos.org>
Subject: [PATCH v3 0/4] Add samsung-matisselte and common matisse dtsi
Date:   Wed, 25 Oct 2023 10:37:48 +0200
Message-ID: <20231025083952.12367-1-newbyte@postmarketos.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a common samsung-matisse dtsi and reworks
samsung-matisse-wifi to use it, and introduces samsung-matisselte. I
choose matisselte over matisse-lte as this is how most other devices
(klte, s3ve3g) do it and it is the codename that Samsung gave the
device. See individual commits for more information.

---
Changes since v1:

 - Rebased on latest linux-next
 - Added qcom,msm8226 compatible to matisselte inspired by recent Lumia
   830 patch. This is done as in v1, the patch was rejected because I
   included the msm8226 dtsi despite not marking matisselte as
   compatible with msm8226, and I was not sure how to resolve that. As
   such, I'm copying what was done in the Lumia 830 (microsoft-tesla)
   patch given that it was accepted.

Changes since v2:

 - Updated commit message for UART patch to explain why it was added.
 - Gave more flags to git to provide a hopefully more readable patch.

Stefan Hansson (4):
  ARM: dts: qcom: samsung-matisse-common: Add initial common device tree
  dt-bindings: arm: qcom: Add Samsung Galaxy Tab 4 10.1 LTE
  ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 LTE
    (SM-T535)
  ARM: dts: qcom: samsung-matisse-common: Add UART

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm/boot/dts/qcom/Makefile               |   1 +
 .../qcom-apq8026-samsung-matisse-wifi.dts     | 589 +++---------------
 ... qcom-msm8226-samsung-matisse-common.dtsi} |  59 +-
 .../qcom/qcom-msm8926-samsung-matisselte.dts  |  36 ++
 5 files changed, 117 insertions(+), 569 deletions(-)
 rewrite arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts (89%)
 copy arch/arm/boot/dts/qcom/{qcom-apq8026-samsung-matisse-wifi.dts => qcom-msm8226-samsung-matisse-common.dtsi} (90%)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8926-samsung-matisselte.dts

-- 
2.41.0

