Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B777A16F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjIOHJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjIOHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:09:40 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E8F10E6;
        Fri, 15 Sep 2023 00:09:34 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c232d36da8so839491a34.1;
        Fri, 15 Sep 2023 00:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694761774; x=1695366574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJl6f0UNgp9s5U6+NACE5ZojfzRIittwLj+OcfEUzag=;
        b=HikqwEA5cwePA7ToP3JeS5wFKAtocWWDmWc38U+u31Vs4+boIPTkMk1g+zdHBf90jE
         0cymVNqSLGq2EaRXIYpmE2SFIkmsXDznuUs6Kw64jnh1aYtkS+bFBvRDiss6ceYuvqJX
         wDl0vkSTCpXJs/Ec4PgUdtomooR3kgCV3ruq2Mm0XkEZB0IUEMxJXSYBRymsZky1dBAq
         VHUZhqSg0/eZ/PaVJDCWNvON/2spYGxSYCw6cR8rkPx1J/HjuGk8tPWlQpwaLHHR9vRU
         DknuIycWTk2NZaQf0fqm2YNEX79AN/VKgZLEzb5VM6MPfHvI22349OPE8Ro7CJ14KzvM
         xKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761774; x=1695366574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJl6f0UNgp9s5U6+NACE5ZojfzRIittwLj+OcfEUzag=;
        b=IbT5E79JDAJ5z6n95bTuGaeBbvlOrr3KUP9Xk997Ja3W9S0C8tUREg2U4xVNeoIBvo
         mF7OtSGc1f+ZIurRYZq34dSg/6Ro1B+b+qrFsX8lVX/HadNuiIS9USVLym/DtieDzjsG
         YiPMebqcb69ovaCoF4yac/2OwXQ0F4gM3GRd4B/kvhWspjBvBiV504sDXY3mtSeANva7
         Hu7uQI9mgwJLganjtChzYRStKIXccEs1xajWjmUz6yIS0wW91ca8wXu20LHCILg0mHp/
         9UfSh5vN4cHnVdPe+CWpm5IbGmjoqYJHXuwObjkcyxwt1/FiBBI01dOolaSdxQIMBbfF
         sE5Q==
X-Gm-Message-State: AOJu0YyQ14BX36Y2oUAErhUv+e+ScHcBre36XAjPnj+JmhonrepIBBqL
        UJ29oOy8F9jqugyJwBGEbY8=
X-Google-Smtp-Source: AGHT+IFd+uJ28ZuLKFUpC0OCCnpyF8Le/2xhZDsYf6fEP9cxkrrHtulYRtTtZ8W5VK2u/bT6/SM10w==
X-Received: by 2002:a05:6358:90d:b0:134:d128:9f5f with SMTP id r13-20020a056358090d00b00134d1289f5fmr700984rwi.9.1694761773768;
        Fri, 15 Sep 2023 00:09:33 -0700 (PDT)
Received: from localhost.localdomain ([222.95.63.58])
        by smtp.gmail.com with ESMTPSA id h2-20020a63b002000000b005777a911342sm2159018pgf.59.2023.09.15.00.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:09:33 -0700 (PDT)
From:   Wang Chen <unicornxw@gmail.com>
X-Google-Original-From: Wang Chen <wangchen20@iscas.ac.cn>
To:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
Subject: [PATCH 00/12] Add Milk-V Pioneer RISC-V board support
Date:   Fri, 15 Sep 2023 15:08:56 +0800
Message-Id: <20230915070856.117514-1-wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 [2]
in a standard mATX form factor. Add minimal device
tree files for the SG2042 SOC and the Milk-V Pioneer board.

Now only support basic uart drivers to boot up into a basic console.

The patch series is based on v6.6-rc1. You can simply review or test 
the patches at the link [3]. Hope this series will be merged soon.

Thanks

[1]: https://milkv.io/pioneer
[2]: https://en.sophgo.com/product/introduce/sg2042.html
[3]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal

Emil Renner Berthing (2):
  dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2042 uarts
  serial: 8250_dw: Add Sophgo SG2042 support

Inochi Amaoto (1):
  dt-bindings: timer: Add Sophgo sg2042 clint

Wang Chen (8):
  dt-bindings: vendor-prefixes: add milkv/sophgo
  dt-bindings: riscv: add sophgo sg2042 bindings
  dt-bindings: riscv: Add T-HEAD C920 compatibles
  dt-bindings: interrupt-controller: Add SOPHGO's SG2042 PLIC
  riscv: dts: add initial SOPHGO SG2042 SoC device tree
  riscv: dts: sophgo: add Milk-V Pioneer board device tree
  riscv: dts: sophgo: Add sophgo,sg2024-uart compatibles
  riscv: defconfig: enable SOPHGO SoC

xiaoguang.xing (1):
  riscv: Add SOPHGO SOC family Kconfig support

 .../sifive,plic-1.0.0.yaml                    |    1 +
 .../devicetree/bindings/riscv/cpus.yaml       |    1 +
 .../devicetree/bindings/riscv/sophgo.yaml     |   28 +
 .../bindings/serial/snps-dw-apb-uart.yaml     |    3 +
 .../bindings/timer/sifive,clint.yaml          |   26 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    4 +
 MAINTAINERS                                   |    7 +
 arch/riscv/Kconfig.socs                       |   10 +
 arch/riscv/boot/dts/Makefile                  |    1 +
 arch/riscv/boot/dts/sophgo/Makefile           |    3 +
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 1794 +++++++++++++++++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   16 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  513 +++++
 arch/riscv/configs/defconfig                  |    1 +
 drivers/tty/serial/8250/8250_dw.c             |    5 +-
 15 files changed, 2411 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml
 create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi

-- 
2.25.1

