Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3247D1C75
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjJUKUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjJUKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:20:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66EF1BF;
        Sat, 21 Oct 2023 03:20:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 786BEC433C8;
        Sat, 21 Oct 2023 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697883645;
        bh=ZZ68ZPi/suxrQ2sypyhx1bc0WmB+NG00aBTdxhJfjdo=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=jm6nVF/3IUsjlV9huNxWCM9lmSvgJI83txk9a0uyNNPYfsY/vsl0O2QAYCRFeKgGK
         Q0VRu3HXBnyZkoSQT54TsXNQ3ZvKtC2F3QEjy2rvfLoU9e2tXEvv/LLFq/m7cBQrXp
         Ex0F8kNxcoZUCvqd1+s9Cg2xxSLu6ZXj0ImCnWF0qDodumbCU3eZUOnTfgqcj2wUcm
         vvJe/uga4fAp9ME6MiGYD233p5wy3ov79rxwpgEaT03O6EnCHgMGZBUDjECUfc9PpD
         gnndGJ+DiQvAKohbK3nvaziY9ZkrtekRlLft0hZVgzd85EuemGgWrsB5rw2ZItZhCy
         gx75lqkBbiyaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 58405C0032E;
        Sat, 21 Oct 2023 10:20:45 +0000 (UTC)
From:   Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Subject: [PATCH v2 0/3] Add initial support for Xiaomi Mi 11 Ultra
Date:   Sat, 21 Oct 2023 18:20:37 +0800
Message-Id: <20231021-sakuramist-mi11u-v2-0-fa82c91ecaf0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPWlM2UC/x3MQQqAIBBA0avErBN0CsKuEi3MphpCC6ciiO6et
 HyL/x8QSkwCbfFAoouFt5iBZQF+cXEmxWM2oMbKaDRK3HomF1gOFdiYUw2WrCVsvK495GxPNPH
 9L7v+fT8M0WvJYgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        Xilin Wu <wuxilin123@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697883643; l=1030;
 i=wuxilin123@gmail.com; s=20231021; h=from:subject:message-id;
 bh=ZZ68ZPi/suxrQ2sypyhx1bc0WmB+NG00aBTdxhJfjdo=;
 b=31ZrEbizsso30dbm1A04cuJgTiM7ym+eXyhFd0HHSVGVy7/2+Ti4kNF/dwpXCLPQPf0Y6VmLv
 r7aUcnHQ9T1DX3ZGw3Msi7DkMCLxLIZGoI+4huWYjaq2KpuxwPM13bP
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=edoFbrGewAWr5/CxptHll7XzvXBjYiN49RrEgipi1Cg=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20231021 with auth_id=89
X-Original-From: Xilin Wu <wuxilin123@gmail.com>
Reply-To: <wuxilin123@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for Xiaomi Mi 11 Ultra.

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
Changes in v2:
- Modified framebuffer node name
- Removed trailing blank line
- Ensured all status property be the last one
- Added UFS host controller supply
- Link to v1: https://lore.kernel.org/r/all/20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com
---

---
Xilin Wu (3):
      soc: qcom: pmic_glink: enable UCSI for SM8350
      dt-bindings: arm: qcom: Add Xiaomi Mi 11 Ultra
      arm64: dts: qcom: Add device tree for Xiaomi Mi 11 Ultra

 Documentation/devicetree/bindings/arm/qcom.yaml |    1 +
 arch/arm64/boot/dts/qcom/Makefile               |    1 +
 arch/arm64/boot/dts/qcom/sm8350-xiaomi-star.dts | 1249 +++++++++++++++++++++++
 drivers/soc/qcom/pmic_glink.c                   |    1 +
 4 files changed, 1252 insertions(+)
---
base-commit: 2dac75696c6da3c848daa118a729827541c89d33
change-id: 20231021-sakuramist-mi11u-b9e99e27c04c

Best regards,
-- 
Xilin Wu <wuxilin123@gmail.com>

