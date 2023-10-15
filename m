Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47C77C9B73
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjJOU0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjJOU0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:26:11 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1A8E4;
        Sun, 15 Oct 2023 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697401566; bh=pbPno1ZqQXw35M/Z5s/GrtA5wtsZugP/6ACjMTW6oyI=;
        h=From:Subject:Date:To:Cc;
        b=y0/Jbv6UIndPL2kJAXCBHdQCEHOq2+12DPYwiBKLPtMkruNpf6q79BY5pvN7L+HlX
         SV9GUYRuAi/mpPxyiv7hB2sE+eYAR42RW5z+br7HrSJYydXnKk+haVM/5Z8XTjakfK
         mkimPLriTz+M6HitnenEGtbJCjEEmFzh/cE1a1og=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Small dtsi fixes for msm8953 SoC
Date:   Sun, 15 Oct 2023 22:26:00 +0200
Message-Id: <20231015-msm8953-misc-fixes-v1-0-b800deca9e46@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANlKLGUC/x3LMQqAMAxA0auUzAbaBrF6FXEQTTVDVRoQQXp3i
 +Pj819QzsIKg3kh8y0q51HhGgPLPh8bo6zV4K0nZ12LSVPoW8IkumCUhxVDF6kjbyn2Aep4Zf5
 D/caplA8JleMIZAAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=568; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=pbPno1ZqQXw35M/Z5s/GrtA5wtsZugP/6ACjMTW6oyI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlLErbYljQeUeEnk/kRf8HLnZdN7A7BH52pEftn
 02ca11hPyCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSxK2wAKCRBy2EO4nU3X
 VgcyEADJc8/zuEHN1PkJE9JjkV9O+rffDd9h//I6YG8s0693AJe6i8CE8tURZQqj8aVUzxbvXGd
 E4NyVjsns4NGY4oYJumwkMgrqDh64f4wpzcL+3fQka/fXeK119+VgtB5t+wZFa/vF2M68YAABlg
 AaC7ViGqRCfRUY4SZjTM690Cyw+SPRoJmehY6U0X7Ure4uE1rNdFF4jTxXJgxkU3I+z1sBG/8e1
 IUR1EIHTpCkmawHGF4Tqc25XvZzcpMl8Zd1vfUtmFiM0Nvq8sPCk2xLIy1bzJPYa5iq5WAmi08q
 FdAEKirNMaEB+iwHXJs1eLb517zaSw7zFTonzfoKdLoytcVSqu06SVZjagOgleeI9PX3OT9JLby
 byy+G26Ulx4A65u6iu3DsG1ZSmMxyTc0xLsEM85QtgUBEX2IecSXGDU3yreO1qMw+AgD1LVdBdU
 52ZomDx7yR1NvlihRhV4h7Kvy9GNUJqFvFU5uIwQt/2hD6ZckxleQDO7A9ZCzpjwFxKcStvoB+Y
 utcmBBj8bkLE7KPodbvc8HP/K0JfrAiV2qOX0fFpt2yn9UF3M+LD672jzU8qjVY8igUIw5Ftnca
 vSHMdZ+Q3xiCZF1j6N471YonU32A+NWCPWC1YuV3V9xcDaAw8ijSYvLm1qSMHfjivezUeNlkHz7
 QILNZwJAlnIr2Hg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some small things in the qcom/msm8953.dtsi file to make dtbs_check
happier than before.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (2):
      arm64: dts: qcom: msm8953: Set initial address for memory
      arm64: dts: qcom: msm8953: Use non-deprecated qcom,domain in LPASS

 arch/arm64/boot/dts/qcom/msm8953.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 2933a1156742d8c47550493a77af8e2d81cf3c84
change-id: 20231015-msm8953-misc-fixes-87f373203f98

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

