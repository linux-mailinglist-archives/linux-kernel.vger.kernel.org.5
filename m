Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE07A90B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 03:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjIUBxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 21:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIUBxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:53:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C996AB;
        Wed, 20 Sep 2023 18:53:04 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8AxTev+oQtlanEqAA--.10539S3;
        Thu, 21 Sep 2023 09:53:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxndzwoQtlCvsMAA--.26254S2;
        Thu, 21 Sep 2023 09:53:01 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v6 0/2] gpio: loongson: add more gpio chip support
Date:   Thu, 21 Sep 2023 09:52:45 +0800
Message-Id: <20230921015247.23478-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxndzwoQtlCvsMAA--.26254S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was to add loongson 2k0500, 2k2000 and 3a5000 gpio chip
driver support.

Change in v6:
		1. Add a reviewed-by for gpio driver.
		2. Rework the commit log.
		3. Replace changes to "u32" in loongson_gpio_chip_data.
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

 .../bindings/gpio/loongson,ls-gpio.yaml       |  21 +++-
 drivers/gpio/gpio-loongson-64bit.c            | 119 ++++++++++++++++--
 2 files changed, 127 insertions(+), 13 deletions(-)

-- 
2.20.1

