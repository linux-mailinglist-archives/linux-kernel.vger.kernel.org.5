Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7842B788291
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243952AbjHYIoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243954AbjHYIo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5FF26A8;
        Fri, 25 Aug 2023 01:43:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFA46674DD;
        Fri, 25 Aug 2023 08:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18C50C433C7;
        Fri, 25 Aug 2023 08:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692953024;
        bh=vnXQ9pNzSHGVvPmZJ7uQHNEZVNLQ05YRY8c7hb7Ravk=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=tOB+o2z3rw28M5KsCk0a9GGGpP9T911j7VmfFX67JuMW7wSlgZW/gTETOYVeGEw19
         egVERGy8lWr9978ieHsSfyjkZtKCLQAwwdl66L8rDyFH5kmU94MUsez5FS/XcuKDtn
         HeYVis91BDh17gJVBUFdZJpkgufZ0l8HcegXADT3iBmwK0l315NZQ8XkwVK+CzLYUe
         3CGfb/amNeG+fDC3dXuy85jDNSq3Bc2aS9bsOvEFmD5ElKodg+LgtQ7MUl2HmeXFQq
         MH1qywDTwFM0cR+JsubAjf/let6OVpj8C5y6TJym07HnlB8eMCegAURmTWZvOJLX2a
         8sDZ6ZqSfX9xw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id E925BC71134;
        Fri, 25 Aug 2023 08:43:43 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Subject: [PATCH v2 0/2] device tree support for ST M48T86
Date:   Fri, 25 Aug 2023 11:43:24 +0300
Message-Id: <20230823-m48t86_device_tree-v2-0-21ff275f949d@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKxp6GQC/32NTQ6CMBBGr0JmbU0pVYor72EIGcogTSzotBIN4
 e4WDuDyfT95CwRiRwEu2QJMswtuGhOoQwZ2wPFOwnWJQUlVSKMK4bWJ5tx0aWupiUwksFSEqCp
 dVgbSscVAomUc7bBdPYZIvBVPpt59dtutTjy4ECf+7vI539K/njkXUigt06TVxQnt1ePrTT09j
 p6gXtf1B2QIIJXPAAAA
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692953023; l=1298;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=vnXQ9pNzSHGVvPmZJ7uQHNEZVNLQ05YRY8c7hb7Ravk=; =?utf-8?q?b=3DUMK5u45Hw5yI?=
 =?utf-8?q?/xg/NWbYvdUnHJhZO/nb7EBm0ZXilbIfLzsQ7FHSj56ClPW4RbRvESJW8o2cnqsk?=
 mlIGoqixDBVTcjor5QBif9BAnfX6kjz8V70snTLiYMQgzk7njo3W
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for ST M48T86.

The reason it can't go to trivial-rtc.yaml, is that it has 2 registers
instead of a single one. The registers are 1 byte wide.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Changes in v2:
- add links to mailthreads where the actual tags were recieved:
  - dt-bindings: rtc: Add ST M48T86 was Reviewed-by Krzysztof in v3 "ep93xx device tree conversion"
  - rtc: m48t86: add DT support for m48t86:
     - Acked-by Arnd in very first "ep93xx device tree conversion"
     - Reviewed-by Linus in v1 "ep93xx device tree conversion"

Was asked by Krzysztof to send this part separately.

Link: https://lore.kernel.org/lkml/61b9e036-7864-65c6-d43b-463fff896ddc@linaro.org/
Link: https://lore.kernel.org/lkml/20230601054549.10843-12-nikita.shubin@maquefel.me/

---
Nikita Shubin (2):
      dt-bindings: rtc: Add ST M48T86
      rtc: m48t86: add DT support for m48t86

 .../devicetree/bindings/rtc/st,m48t86.yaml         | 38 ++++++++++++++++++++++
 drivers/rtc/rtc-m48t86.c                           |  8 +++++
 2 files changed, 46 insertions(+)
---
base-commit: 89bf6209cad66214d3774dac86b6bbf2aec6a30d
change-id: 20230823-m48t86_device_tree-a72eaa294798

Best regards,
-- 
Nikita Shubin <nikita.shubin@maquefel.me>

