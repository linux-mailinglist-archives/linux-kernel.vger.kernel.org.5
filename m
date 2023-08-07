Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC2F771BA9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjHGHlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjHGHlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:41:03 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC51E10EC;
        Mon,  7 Aug 2023 00:40:58 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Bx5fAJoNBkBuARAA--.40293S3;
        Mon, 07 Aug 2023 15:40:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB838n9Bk+dBMAA--.56868S2;
        Mon, 07 Aug 2023 15:40:56 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v3 0/2] gpio: loongson: add firmware offset parse support
Date:   Mon,  7 Aug 2023 15:40:41 +0800
Message-Id: <20230807074043.31288-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB838n9Bk+dBMAA--.56868S2
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

Add some GPIO register offset value parse support for device properties
allowing to specify them in ACPI or DT.

Change in v3:
		1. Reword the dt-bindings patch commit log information.
		2. Add "loongson,ls2k1000-gpio" compatible.
Change in v2:
		1. Reword the patch commit log information.
		2. Add some GPIO register offset description in yaml.

Yinbo Zhu (2):
  gpio: dt-bindings: add parsing of loongson gpio offset
  gpio: loongson: add firmware offset parse support

 .../bindings/gpio/loongson,ls-gpio.yaml       | 40 +++++++++-
 drivers/gpio/gpio-loongson-64bit.c            | 74 +++++++++++++++++--
 2 files changed, 106 insertions(+), 8 deletions(-)

-- 
2.20.1

