Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C226D78C457
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjH2MgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjH2Mfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:35:51 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68A80A3;
        Tue, 29 Aug 2023 05:35:46 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Ax1fAf5u1kr8IcAA--.58695S3;
        Tue, 29 Aug 2023 20:35:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHCMb5u1kE3dmAA--.31948S2;
        Tue, 29 Aug 2023 20:35:43 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v5 0/2] gpio: loongson: add more gpio chip support
Date:   Tue, 29 Aug 2023 20:35:22 +0800
Message-Id: <20230829123524.17291-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHCMb5u1kE3dmAA--.31948S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was to add loongson 2k0500, 2k2000 and 3a5000 gpio chip
driver support.

Change in v5:
		1. Use boolean initializer for lgpio->chip.can_sleep.
		2. Remove the code that about io width gain from ngpios.
		3. Fixup the ls7a-gpio and ls2k-gpio items in yaml file.
		4. Add the reviewed-by information for dt-bindings patch.
		5. Add some comments in loongson_gpio_to_irq.
Change in v4:
		1. Reword the title and commit log information.
		2. Remove the offset parse in DT and add it in of_device_id and
		   acpi_device_id's data field.
		3. Add more gpio chip dt-bindings support in yaml file.
Change in v3:
		1. Reword the dt-bindings patch commit log information.
		2. Add "loongson,ls2k1000-gpio" compatible.
Change in v2:
		1. Reword the patch commit log information.
		2. Add some GPIO register offset description in yaml.

Yinbo Zhu (2):
  gpio: dt-bindings: add more loongson gpio chip support
  gpio: loongson: add more gpio chip support

 .../bindings/gpio/loongson,ls-gpio.yaml       |  21 ++-
 drivers/gpio/gpio-loongson-64bit.c            | 125 ++++++++++++++++--
 2 files changed, 130 insertions(+), 16 deletions(-)

-- 
2.20.1

