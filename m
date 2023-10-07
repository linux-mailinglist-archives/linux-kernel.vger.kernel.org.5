Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA717BC5C5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343728AbjJGHwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343650AbjJGHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:52:13 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2B4A6;
        Sat,  7 Oct 2023 00:52:12 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c4e38483d2so1940144a34.1;
        Sat, 07 Oct 2023 00:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696665132; x=1697269932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWKeZClVDNfE0So7VZ4pIq0hNbqjkSr0/ljukMM3ovM=;
        b=S+IZRTmzaBqbDMV611L3Zx4WLdZZlzNP0CJoaUex+6/JsfZPc5Ibm4psTt9oqM1J1i
         taBgfnl9fNmeNgknhZsIMXTaKFRAoueLn47DYr5JRaEjimC5u//pU3Yb05Xgs5Wvt5mZ
         D6TzF9Tq3ci8lLD57uEdJ+RA3feY6ICOMFpx60WUpYX8SbWhDjENybg1FjfCA65AwYtn
         WSFu/KlyZjdQUUvFxHpzTU/r/lxu7YuL8k/axfZ5kM+G5vvQutqjAZ6m09ePw9tGiU10
         /VRduxVklWC9Cc5/WHbvCUkYj9xUHNsysRLu3Tgqo4a3758cqE5Fq/bGDI6mYw59WXOQ
         19HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665132; x=1697269932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWKeZClVDNfE0So7VZ4pIq0hNbqjkSr0/ljukMM3ovM=;
        b=YvI4d23lM4Fh+VUPlrMqvSnFp2tDNn50DQPYU6rvxq4I2geSnatiC+QLlBoUVuQDBo
         ZPjC4u7UCSA38M86Mw4XaRIKXDaHJzUmb8CHDmJ+YOOJU74o9AG2soGKzmjapmNn51uq
         Aj1lBiW4LgPEXUQv7t2VbuWQd2Q9NeEL87THf+XJardEoO+k8v1RCErFWJU/gblcnUn6
         /GCMNpIDL1jHbYD+bSJzV7W7ULl8KtfVswBlPymnkRgFW5BDvYmMZVq8bHrLxZaRaaCt
         pBymmOoieodm2MQUWC86RBncGKd/NBBS6mQGLPDq03B2vfY8gnIurTa/W1rXhX1CwfhC
         7cpg==
X-Gm-Message-State: AOJu0YzLcsUcUe9MKMcuGN4str29na05UK7cOjOXs9EAv+c4k11oDZnK
        EfAiF6wO0z2yQKkeuVdUsE0=
X-Google-Smtp-Source: AGHT+IFa/2c1DveRTEF3n6nFpcOHxweHFzgtiW7qY9f2w5gQcY9IpaJvjg05thOsqoy+pQy2tCfRIg==
X-Received: by 2002:a05:6830:155a:b0:6b9:146a:f1c9 with SMTP id l26-20020a056830155a00b006b9146af1c9mr10304109otp.0.1696665131722;
        Sat, 07 Oct 2023 00:52:11 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id s6-20020a056830148600b006b9d8c31e94sm837383otq.39.2023.10.07.00.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 00:52:11 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v5 00/10] Add Milk-V Pioneer RISC-V board support
Date:   Sat,  7 Oct 2023 15:52:04 +0800
Message-Id: <cover.1696663037.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
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

From: Chen Wang <unicorn_wang@outlook.com>

Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 [2]
in a standard mATX form factor. Add minimal device
tree files for the SG2042 SOC and the Milk-V Pioneer board.

Now only support basic uart drivers to boot up into a basic console.

Thanks,
Chen

---

Changes in v5:
  The patch series is based on v6.6-rc1. You can simply review or test
  the patches at the link [7].
  - dts: changed plic to support external interrupt
  - pickup improvements from Conor, details refer to [8].

Changes in v4:
  The patch series is based on v6.6-rc1. You can simply review or test
  the patches at the link [6].
  - Update bindings files for sg2042 clint as per intput from reviewers:
    - rename filename from sophgo,sg2042-clint-mswi/sg2042-clint-mtimer
      to thead,c900-aclint-mswi/thead,c900-aclint-mtimer.
    - rename compatible strings accordingly.
  - Update dts as per input from reviewers: don't use macro for cpus's isa
    properties; use new compatible strings for mtimer/mswi of clint.
  - Use only one email-address for SoB.

Changes in v3 [v3]:
  The patch series is based on v6.6-rc1. You can simply review or test
  the patches at the link [5].
  - add new vendor specific compatible strings to identify timer/mswi for sg2042 clint
  - updated maintainers info. for sophgo devicetree
  - remove the quirk changes for uart
  - updated dts, such as:
    - add "riscv,isa-base"/"riscv,isa-extensions" for cpus
    - update l2 cache node's name
    - remove memory and pmu nodes
  - fixed other issues as per input from reviewers.

Changes in v2 [v2]:
  The patch series is based on v6.6-rc1. You can simply review or test
  the patches at the link [4].
  - Improve format for comment of commitments as per input from last review.
  - Improve format of DTS as per input from last review.
  - Remove numa related stuff from DTS. This part is just for optimization, may
    add it later if really needed.

Changes in v1:
   The patch series is based on v6.6-rc1. Due to it is not sent in thread,
   I have listed permlinks of the patchset [v1-0/12] ~ [v1-12/12] here for
   quick reference. You can simply review or test the patches at the link [3].

[1]: https://milkv.io/pioneer
[2]: https://en.sophgo.com/product/introduce/sg2042.html
[3]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal
[4]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal-v2
[5]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal-v3
[6]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal-v4
[7]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal-v5
[8]: https://lore.kernel.org/linux-riscv/20231006-empathy-unrefined-ff1168095093@spud/
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
[v2]:https://lore.kernel.org/linux-riscv/cover.1695189879.git.wangchen20@iscas.ac.cn/
[v3]:https://lore.kernel.org/linux-riscv/cover.1695804418.git.unicornxw@gmail.com/

---

Chen Wang (8):
  riscv: Add SOPHGO SOC family Kconfig support
  dt-bindings: vendor-prefixes: add milkv/sophgo
  dt-bindings: riscv: add sophgo sg2042 bindings
  dt-bindings: riscv: Add T-HEAD C920 compatibles
  dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
  riscv: dts: add initial Sophgo SG2042 SoC device tree
  riscv: dts: sophgo: add Milk-V Pioneer board device tree
  riscv: defconfig: enable SOPHGO SoC

Inochi Amaoto (2):
  dt-bindings: timer: Add Sophgo sg2042 CLINT timer
  dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi

 .../sifive,plic-1.0.0.yaml                    |    1 +
 .../thead,c900-aclint-mswi.yaml               |   43 +
 .../devicetree/bindings/riscv/cpus.yaml       |    1 +
 .../devicetree/bindings/riscv/sophgo.yaml     |   28 +
 .../timer/thead,c900-aclint-mtimer.yaml       |   43 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    4 +
 MAINTAINERS                                   |    7 +
 arch/riscv/Kconfig.socs                       |    5 +
 arch/riscv/boot/dts/Makefile                  |    1 +
 arch/riscv/boot/dts/sophgo/Makefile           |    2 +
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 2000 +++++++++++++++++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   19 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  325 +++
 arch/riscv/configs/defconfig                  |    3 +-
 14 files changed, 2481 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
 create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.25.1

