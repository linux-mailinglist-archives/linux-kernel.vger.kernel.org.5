Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61087710B4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHERDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHERDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3061AE51;
        Sat,  5 Aug 2023 10:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96C660C57;
        Sat,  5 Aug 2023 17:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EB17C433C7;
        Sat,  5 Aug 2023 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691254995;
        bh=h5eU9XX1o4OOf6S1Raai5CwCugmHSOAJ95Q+DWakPuw=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=Q4u2B3z0rmOLUsxCfRWXVEEU28ISgmLSi7UeFwI9EMwmURyLspZLH96RSzotRdnjU
         c932vJVe7CKCunh1MADBKanP/2Ub6hotjYZOEx9moVY8C/fDGunBPjiGAHGy+sfXLI
         aQbNuPCaG1+CR6c9X1h7O4f32zrageZzaZSwbvXU46rZLkOomsb/eH+yYTu1mfj+uh
         KYr8+MZOvrBI/5kpXsgLXXcse9vhFpvDFfao3cG/Tj/86CsWJtgzILNbw6m0Sz5HXo
         NySgAgNGcFMNDaVLyr7dihx4pvMO+FAMsk13GswEaofos885wMysgSUd5bRM3NSHtW
         xlj//Gs0Bu0xA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id EB55DC0015E;
        Sat,  5 Aug 2023 17:03:14 +0000 (UTC)
From:   Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Subject: [PATCH 0/3] Add initial support for Xiaomi Mi 11 Ultra
Date:   Sun, 06 Aug 2023 01:03:09 +0800
Message-Id: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM2AzmQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwMz3YrMxPzcTN3iksQi3VRT4xQLs0TjJFPLVCWgjoKi1LTMCrBp0bG
 1tQDLOwb7XQAAAA==
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
        Xilin Wu <wuxilin123@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691254992; l=698;
 i=wuxilin123@gmail.com; s=20230805; h=from:subject:message-id;
 bh=h5eU9XX1o4OOf6S1Raai5CwCugmHSOAJ95Q+DWakPuw=;
 b=OQntiV/U7W7Rd3Y6oKVtP7h9tiC8jZyOIZJXVbI7q66nLcgekYC8dPLbkpz3+elHdgC+e5Emt
 e05ygSe7qp7B1fzegauog7IlNEUxEgdJd564vM4/+wSoYzNbAfBcMbO
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=OZIrHT2qWm7yEdp5fsVR7GsFx1wxciIii20H06Ud088=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20230805 with auth_id=73
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

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
Xilin Wu (3):
      soc: qcom: pmic_glink: enable UCSI for SM8350
      dt-bindings: arm: qcom: Add Xiaomi Mi 11 Ultra
      arm64: dts: qcom: Add device tree for Xiaomi Mi 11 Ultra

 Documentation/devicetree/bindings/arm/qcom.yaml |    1 +
 arch/arm64/boot/dts/qcom/Makefile               |    1 +
 arch/arm64/boot/dts/qcom/sm8350-xiaomi-star.dts | 1251 +++++++++++++++++++++++
 drivers/soc/qcom/pmic_glink.c                   |    1 +
 4 files changed, 1254 insertions(+)
---
base-commit: d2aae0f5a3d5af50b13b13cb452745cd0428ce5e
change-id: 20230806-xiaomi-star-e53d86a3b59e

Best regards,
-- 
Xilin Wu <wuxilin123@gmail.com>

