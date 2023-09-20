Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171117A72D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjITGed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjITGeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:34:31 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1249F;
        Tue, 19 Sep 2023 23:34:25 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1c50438636fso3857579fac.1;
        Tue, 19 Sep 2023 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695191665; x=1695796465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+O3AJdPC6+mmDlzoTLR1My0ueM7+QDiCckAE4a7Rtso=;
        b=PliHGNJ8Ke6wwc30w9e4fvOwiTb+F2wtQ60qa8KHoNdOjB1VcMC/kzBNKjpFI3W4E8
         3eCU32Sz3kGzprsf0ygWbfCgJQD8BVWyAGG8qtjxEiiEHWZQ/m285F8zEeDhkKvhnup8
         ourAvSP6YZQNwfffCbYI2ZX5wEnA1skPx4nK2SxWVRkEx+XDN2f0rie1n/tr235meg/d
         f54iGOo+ZYM6oQ4CK0wHQ9mGs1kr/PKp6Z1KoY9uBgqLnwSwUF09TA2vKUj3k313/PXS
         cubNrk5RR0B/7V9es3eYEj6aAfOd+HHUAVkGd2ryiRPp3yvLtVJ4EhwnlY2c6K7cq9J2
         /kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695191665; x=1695796465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+O3AJdPC6+mmDlzoTLR1My0ueM7+QDiCckAE4a7Rtso=;
        b=g/CWZnd0AFMIXrLJYJVMQPTOOy0s6JV9CaNkyr8SRpDRnhWyp2sGKww4pdNaOHK0++
         gkUc02H89sQPnNrgfBgHZSFnGEeNYBrMMaBMkmRmu/EJAEJbDkxokzoFN/+2K3iK+RxY
         W+BesSiiBUqgFu7EFbitfjdWZ9zCpcPfttK1keB6opHti+TQew6Xhaa1PxivMvUMil3t
         atohX5K3/bmXOzhNWxKliNL6KssQ1ooQkCXe+hHoM2mXw3YNhG//cTrlKWGpCGjGwY5D
         ZfX4OQK7/d47YGQ3d9s7LF7499eQV9ENP5Zdc+fQ0qP1rOvyxeqf7kcfsM7E/yunjuo6
         KuTA==
X-Gm-Message-State: AOJu0Yx11ZUZfhzcRtsS6tiK6pBEktohJgUeCLFU/1TJncaT5KidU7pS
        A+qwLHtcrLo1LonzbA1Ktbc=
X-Google-Smtp-Source: AGHT+IEHnNyf0jXITy3BDsnEYu+CXUH5KU3JnL7xXa/F0/zqdtvEtErvGFatqOAs3bzaIniIkKcHyA==
X-Received: by 2002:a05:6870:d404:b0:1c8:d72a:d6b8 with SMTP id i4-20020a056870d40400b001c8d72ad6b8mr1885261oag.36.1695191664887;
        Tue, 19 Sep 2023 23:34:24 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id r21-20020a056870625500b001d4f1ec39b3sm6842515oak.23.2023.09.19.23.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:34:24 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
X-Google-Original-From: Chen Wang <wangchen20@iscas.ac.cn>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v2 00/11] Add Milk-V Pioneer RISC-V board support
Date:   Wed, 20 Sep 2023 14:33:48 +0800
Message-Id: <cover.1695189879.git.wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Thanks,
Chen

---

Changes in v2:
  The patch series is based on v6.6-rc1. You can simply review or test 
  the patches at the link [4].
  - Improve format for comment of commitments as per input from last review.
  - Improve format of DTS as per input from last review.
  - Remove numa related stuff from DTS. This part is just for optimization, may
    add it later if really needed. 

Previous versions:
v1: due to it is not sent in thread, I have listed permlinks of the patchset
    [v1-0/12] ~ [v1-12/12] here for quick reference. You can simply review or
    test the patches at the link [3].

[1]: https://milkv.io/pioneer
[2]: https://en.sophgo.com/product/introduce/sg2042.html
[3]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal
[4]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal-v2
[v1-0/12]:https://lore.kernel.org/linux-riscv/20230915070856.117514-1-wangchen20@iscas.ac.cn/
[v1-1/12]:https://lore.kernel.org/linux-riscv/20230915071005.117575-1-wangchen20@iscas.ac.cn/
[v1-2/12]:https://lore.kernel.org/linux-riscv/20230915071409.117692-1-wangchen20@iscas.ac.cn/
[v1-3/12]:https://lore.kernel.org/linux-riscv/20230915072242.117935-1-wangchen20@iscas.ac.cn/
[v1-4/12]:https://lore.kernel.org/linux-riscv/20230915072333.117991-1-wangchen20@iscas.ac.cn/
[v1-5/12]:https://lore.kernel.org/linux-riscv/20230915072358.118045-1-wangchen20@iscas.ac.cn/
[v1-6/12]:https://lore.kernel.org/linux-riscv/20230915072415.118100-1-wangchen20@iscas.ac.cn/
[v1-7/12]:https://lore.kernel.org/linux-riscv/20230915072431.118154-1-wangchen20@iscas.ac.cn/
[v1-8/12]:https://lore.kernel.org/linux-riscv/20230915072451.118209-1-wangchen20@iscas.ac.cn/
[v1-9/12]:https://lore.kernel.org/linux-riscv/20230915072517.118266-1-wangchen20@iscas.ac.cn/
[v1-10/12]:https://lore.kernel.org/linux-riscv/20230915072558.118325-1-wangchen20@iscas.ac.cn/
[v1-11/12]:https://lore.kernel.org/linux-riscv/20230915072624.118388-1-wangchen20@iscas.ac.cn/
[v1-12/12]:https://lore.kernel.org/linux-riscv/20230915072653.118448-1-wangchen20@iscas.ac.cn/

---

Chen Wang (8):
  riscv: Add SOPHGO SOC family Kconfig support
  dt-bindings: vendor-prefixes: add milkv/sophgo
  dt-bindings: riscv: add sophgo sg2042 bindings
  dt-bindings: riscv: Add T-HEAD C920 compatibles
  dt-bindings: interrupt-controller: Add SOPHGO's SG2042 PLIC
  riscv: dts: add initial SOPHGO SG2042 SoC device tree
  riscv: dts: sophgo: add Milk-V Pioneer board device tree
  riscv: defconfig: enable SOPHGO SoC

Emil Renner Berthing (2):
  dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2042 uarts
  serial: 8250_dw: Add Sophgo SG2042 support

Inochi Amaoto (1):
  dt-bindings: timer: Add Sophgo sg2042 clint

 .../sifive,plic-1.0.0.yaml                    |    1 +
 .../devicetree/bindings/riscv/cpus.yaml       |    1 +
 .../devicetree/bindings/riscv/sophgo.yaml     |   28 +
 .../bindings/serial/snps-dw-apb-uart.yaml     |    1 +
 .../bindings/timer/sifive,clint.yaml          |    8 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    4 +
 MAINTAINERS                                   |    7 +
 arch/riscv/Kconfig.socs                       |    5 +
 arch/riscv/boot/dts/Makefile                  |    1 +
 arch/riscv/boot/dts/sophgo/Makefile           |    3 +
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 1744 +++++++++++++++++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   19 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  439 +++++
 arch/riscv/configs/defconfig                  |    1 +
 drivers/tty/serial/8250/8250_dw.c             |    5 +-
 15 files changed, 2265 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml
 create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.25.1

