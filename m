Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0417AB689
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjIVQ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjIVQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:55:56 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBB7A1;
        Fri, 22 Sep 2023 09:55:49 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 6B77ECFADA;
        Fri, 22 Sep 2023 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1695401747; bh=W/kDrQeaSI62hH6jV6KXvip55D7j8XsE3KTj4V7VwTk=;
        h=From:Subject:Date:To:Cc;
        b=jZ8zj2hie3ugBQvwqrjkk1fbcJkzFJ2LmH9p9WzzE8NjSB/KDRQY8P271lCouzItP
         eyOIOmnWdhVd1JQ8c1TiXgKUo5c7gK6Lbc7dcBuV3qSZEuval5pkUFjIFgt/FK8m/x
         Ntdvj2UeY+ydt3yJDbiARmcNpE2VfqIoPql6CrTE=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/3] Add blsp1_i2c6 and blsp1_uart2 to MSM8226 SoC
Date:   Fri, 22 Sep 2023 18:55:11 +0200
Message-Id: <20230922-msm8226-i2c6-v2-0-3fb55c47a084@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO/GDWUC/3XMOQ6DMBCF4augqTORGUdeUuUeEQWLHabARDZBL
 OLucehT/k963w7JRXYJ7sUO0c2ceAw56FJA29fh5ZC73ECCpLCCcEiDIVLI1CoUXnf61tW+Ng3
 kyzs6z8vJPavcPadpjOupz+Vv/QPNJQq0SlJjbKm0sY9NhulzXdYNquM4vrpNseKoAAAA
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=W/kDrQeaSI62hH6jV6KXvip55D7j8XsE3KTj4V7VwTk=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlDccC8KwnrJ2vrcxRJCUt0wmNclz9Ce9uSPhcm
 2hGfGLBYRmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZQ3HAgAKCRBy2EO4nU3X
 VimaEACCUPKlruo8GcnlFKI8y1BFXl6jDg1Y6D/a+nU6t4HOSelMzQI5XkOeHq4NcaOzT7IEI0/
 qk2Ya9ZW7t+dK+Lo6Pj9DnUMaRH1anazCy1HtyQnAGnOiBFHiF55gqtmZXLUvPDZZAhuLas2ypw
 p6kAbkw3kG7e/zJDkhIc04rkL/+x8/WUOY3TNN2oV4mlCTe8qAvEiCkKv7CWMwITov6ZTciZT3c
 dLsFWaPxX2YZm4MtD9Y+DbhxC0UAyrGzVWOpzS6MjARSnVWTaeP6B2rfzI+70NKbludkbrCeiWg
 IQJk3sJ0oPI71JcysgKXQWc6NwX6BNNzuxL/ayNo2+6QTDetM016DERgK4SAYdztqjTM2QO+Aji
 FRJGv7UENEREf8M7JUPw3DXcj3vdLCltERBgnJCuUUPAb10uw60l7d4alHVyEyigMnsRoVnfYI8
 PijFcWbgR5uLYGU8SJQubF9EWwWHVMWSWUths8eKjEBI48M25sbXXvYvuHfLOBIHSxB18TLoRjx
 UlVtDkDO+tKUQgOaBtHNHnH2A0bsDPQhdnn7jgMOufXnVgjbPJWoCIgLFerDGxEJE0Y5wJtLB4X
 VbC6s/v23OHW9T6KA3ihzi0oO3gUs9GdlkPhOP/l1SJM57NeO+dXqBx/sjFtoT0nconyaoZKbGm
 XzwZGvVLErQ6wGw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the I2C bus and UART interface found on the MSM8226. For the I2C bus
we also first need to add the pinctrl function in the driver.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Add binding change patch
- Adjust property order in dtsi
- Link to v1: https://lore.kernel.org/r/20230902-msm8226-i2c6-v1-0-9632b8916789@z3ntu.xyz

---
Luca Weiss (3):
      dt-bindings: pinctrl: qcom,msm8226: Add blsp_i2c6 function
      pinctrl: qcom: msm8226: Add blsp_i2c6 function
      ARM: dts: qcom: msm8226: Add blsp1_i2c6 and blsp1_uart2

 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     |  4 +--
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi           | 33 ++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm8226.c             |  8 ++++--
 3 files changed, 41 insertions(+), 4 deletions(-)
---
base-commit: 940fcc189c51032dd0282cbee4497542c982ac59
change-id: 20230902-msm8226-i2c6-0f7d74dafa8b

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

