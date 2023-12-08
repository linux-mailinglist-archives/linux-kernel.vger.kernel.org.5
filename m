Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54584809CFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjLHHQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjLHHQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:16:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC3A1724
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:16:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E433BC433C8;
        Fri,  8 Dec 2023 07:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702019790;
        bh=x1LVuWnPlnaL4+2ytK6scMJJiGc0PC686IXbzerTiJw=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=rTe+JZ0zp4T5LGm27ilvRzON+mk5FlHVKXQJcllo9M0PActoOXd7UAMozvAlSqU/h
         crjfKAq7bKOH7JH3RoZf9uVkZYmSDScuiHlq5loAD/Uy8Lwa/GEnbEhU5MdybkPipd
         0nGrdnmb7E5/DRQ/XLSjoqsKgR7K/lWa6r7xNdxMvPVfNk7z1MhOiqMm0ro4ZIH5W2
         aT1ybXcPoGAelDhD8YaItF2KVQF98lxlBSg2kmXkmPi885cFS8F9htZlu5YQheZ/IQ
         JWKEezRxxHHPfcqw0aDgbf9+ft5qqoy0oWriqaP03RMTDYs+I5NlqeXqF7gXf62pcY
         I1v4UJ5NSEzPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id CD23DC4167B;
        Fri,  8 Dec 2023 07:16:29 +0000 (UTC)
From:   Xianwei Zhao via B4 Relay 
        <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/2] Add some devices nodes for S4.
Date:   Fri, 08 Dec 2023 15:16:25 +0800
Message-Id: <20231208-s4-dts-v2-0-5a93fa356c5d@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMnCcmUC/0XMQQ6CMBCF4auQWTuknVZCXXkP46LSASYRSlqiR
 MLdbdy4/JL/vR0yJ+EMl2qHxC/JEucCOlXQjX4eGCUUAykymlSL2WJYM5IN/AjNuSHloMRL4l6
 239HtXtynOOE6Jvb/uSanHDnratLKGNOixk38/GapP6OPVz894yBd3cUJjuMLP2hC5pwAAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702019788; l=1074;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=x1LVuWnPlnaL4+2ytK6scMJJiGc0PC686IXbzerTiJw=;
 b=ec+Ua7KFxOXT8HGqxc1F4xX4Bxgl9cTzrFEJxXZPSLqxRST5tvzJdnm2ui19/ZBp6SAD0ck5l
 lZlTeCFIAC2BJ+NJl5bWz97x6ZiBFhzLebcuXOWgOFX6ZZnSMlCmcE4
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: <xianwei.zhao@amlogic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some device nodes for SoC S4, including periphs clock controller
node, PLL clock controller node, I2C nodes, SPICC node, NAND
controller node, Ethernet MAC and PHY node.

Add reserved memory for board AQ222 which is used by ATF.
Enable NAND, SPICC nodes for board AQ222.

---
Changes in v2:
- Separate and independent commit for dts file.
- Revision format error.
- Add comment for resered memory.
- Link to v1: https://lore.kernel.org/all/20231129092949.2103338-1-xianwei.zhao@amlogic.com/

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

---
Xianwei Zhao (2):
      arm64: dts: amlogic: add some device nodes for S4
      arm64: dts: amlogic: enable some nodes for board AQ222

 .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     |  56 ++++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 350 ++++++++++++++++++++-
 2 files changed, 405 insertions(+), 1 deletion(-)
---
base-commit: 093098370b4693b0da8b7fdf5fd212cb46705928
change-id: 20231208-s4-dts-24debd656209

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>

