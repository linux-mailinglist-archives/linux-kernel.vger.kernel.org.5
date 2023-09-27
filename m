Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9775B7AFE52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjI0I1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjI0I06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:26:58 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE75CD6;
        Wed, 27 Sep 2023 01:26:53 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dd7139aa57so1428842fac.1;
        Wed, 27 Sep 2023 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695803213; x=1696408013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MoYbiHoRTBkFkCQeE69Y8EorC+SjrK0dNJelyHZJ5P0=;
        b=ZjY8YTrsFC5I9I+ieRG54W33dEMBIrh7/PgrM9vpa9YFNE8ry8SuGmGsMcPMeTqA9s
         JvdmyLQqAv3x08X1kef7QBFSzJSd65o3836r1HMCkVo5afi3fAemhTQWdY5621K59ZUV
         AGCgt6pjGKP9eE+rzujLTlDXOzMT2of8qRDfGYoMx6ZA5Vb88nUOmXonjTKq4nYZg+Nw
         T/KBt9uu0SCOjNQHGWqbpUrEecn9FSkokq5QIUgSbBAVObA3H0/8GTZuhzhpaXy5CYpD
         9/DWf3w51qdlcPg/wZ1LAB7NpKdqoRJiBQPr608oBYSU85zlBclu9jsTXigpzJbQAzl2
         KxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803213; x=1696408013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MoYbiHoRTBkFkCQeE69Y8EorC+SjrK0dNJelyHZJ5P0=;
        b=d4arqYKrVgX5kdX1g3+drya5Q6rWUedMIkoheLbpmugYQ4K5+zKXJfrY1Y2SZG+zUL
         UDIISr5AqNH7eZtjdZEud4ZUwnmQPasZzF7ahpfmtQJ4VilfTXv2S3jrpQ6TBuHQN6Ui
         44yMGaM9dguV7bObZxS3djNvwt/YB8fhFUANLMiY/q6adDJMlAT1qmn3mKB9M0OEY7E5
         AKMTl/Jj0t56NF/BgbL+6xZJK05L4HFLGh7lhQiCLsX7gAdyx1qfwUJGhfj3fe6z1wwM
         asDunjklJ5eWADdmii7lporbPvsQnapABx713V951LFbSvQsY2aKXa1l5HF2LePHoBdP
         kSJQ==
X-Gm-Message-State: AOJu0Ywn1vIX5wmo1EFqP4K8jvV2bL1mx+/1ijRTZFi9YJH3rPlGkbVt
        ImTaNYnqAUrIJjmU+I1gEEE=
X-Google-Smtp-Source: AGHT+IGVV/z5+SDGNfk91RauZf5PzYRtx+9PTSX3+r4EWpxM6aEHiB2PiI0uYmG6F7CWjOeVHge57w==
X-Received: by 2002:a05:6870:e2c9:b0:1be:f311:4a29 with SMTP id w9-20020a056870e2c900b001bef3114a29mr1694214oad.20.1695803212619;
        Wed, 27 Sep 2023 01:26:52 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id v3-20020a056870e28300b001dcde628a6fsm1952812oad.42.2023.09.27.01.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:26:52 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com,
        unicorn_wang@outlook.com
Subject: [PATCH v3 00/11] Add SOPHGO SOC family Kconfig support
Date:   Wed, 27 Sep 2023 16:26:46 +0800
Message-Id: <cover.1695800389.git.unicornxw@gmail.com>
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

Changes in v3:
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

Changes in v2:
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

Chen Wang (9):
  riscv: Add SOPHGO SOC family Kconfig support
  dt-bindings: vendor-prefixes: add milkv/sophgo
  dt-bindings: riscv: add sophgo sg2042 bindings
  dt-bindings: riscv: Add T-HEAD C920 compatibles
  dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
  MAINTAINERS: add two files to sophgo devicetrees entry
  riscv: dts: add initial Sophgo SG2042 SoC device tree
  riscv: dts: sophgo: add Milk-V Pioneer board device tree
  riscv: defconfig: enable SOPHGO SoC

Inochi Amaoto (2):
  dt-bindings: timer: Add Sophgo sg2042 CLINT timer
  dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi

 .../sifive,plic-1.0.0.yaml                    |    1 +
 .../sophgo,sg2042-clint-mswi.yaml             |   42 +
 .../devicetree/bindings/riscv/cpus.yaml       |    1 +
 .../devicetree/bindings/riscv/sophgo.yaml     |   28 +
 .../timer/sophgo,sg2042-clint-mtimer.yaml     |   42 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    4 +
 MAINTAINERS                                   |    9 +
 arch/riscv/Kconfig.socs                       |    5 +
 arch/riscv/boot/dts/Makefile                  |    1 +
 arch/riscv/boot/dts/sophgo/Makefile           |    3 +
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 1880 +++++++++++++++++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   19 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  325 +++
 arch/riscv/configs/defconfig                  |    1 +
 14 files changed, 2361 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-clint-mswi.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/sophgo,sg2042-clint-mtimer.yaml
 create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.25.1

