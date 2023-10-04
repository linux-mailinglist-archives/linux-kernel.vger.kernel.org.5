Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD17A7B83BE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjJDPiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjJDPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:37:59 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29602D8;
        Wed,  4 Oct 2023 08:37:55 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c646b5028dso1471967a34.3;
        Wed, 04 Oct 2023 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696433874; x=1697038674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJqHnUlx2VOSGtYh5XeNz8W9/poCSBylKJ6mcsi9iaI=;
        b=Dbso4P39VkOv83VscHH2oerun4R8jq9RiQbdIdYhqPdz5a5X93ALav9lPerCppBb8e
         aIMvZA1JULNC5c68Mkm65mIeMmO/FWHo8CzACxfVYViYV1e7pcRUKcDvd5piwqhijqjD
         k1YVC4LuCNjCORrmHHLMGqzpkaHbII0qo9T6cJ7QDiP7mrk8ertoXGL+krwpVogkCTrz
         jvFY9Nj5fMtFwdfy6dJA4+E5+DggmNrZmSmdA9CS11d7kYmRrINZN/upjUWOxOjvGTwA
         n0+LeqLCI6scj2jtslT+XmoJ01JUkHwPuf8IHUoqA79woiYRqcOd87Ba+AQXfZxCxsnG
         cxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696433874; x=1697038674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJqHnUlx2VOSGtYh5XeNz8W9/poCSBylKJ6mcsi9iaI=;
        b=u1Q7YzP4tNjaatKlMr/GXlo45HyDW0CuZoLwwufYWyI5QW7gc7dVXyywNnAv4ACAP0
         tS87eDjaT/p9y1rFFleBIr54rmmLjRqFFuTVe0GtVzA5ZsGLsr+obCvfjvWizDDTC1T9
         yWueOajbobAzDL8RKiW/JsSlHeNWqGD7O+qwVdQLhDcfWkAHmt/bpBataae0R4AWMGkb
         44K7JAPfQF6DVaywxouzgTSfIVlLmxtowL330xAAc3SmS25VF7I1R44CzGwRa/WEZ1v1
         Px48EWmPwulY7dpFobum3Y3zhFEg4DrIdpcLrwsAmSqurwAPhxB8QPwy+vcLWchBY8cu
         uTzg==
X-Gm-Message-State: AOJu0YwzfG/Zt39E2wPX1OjcFdQ3UJ0HZlson2MPblwOFNvNLPO7EYlS
        meeXyK8vx92pBPAGDdQ4c0o=
X-Google-Smtp-Source: AGHT+IFqIokQOJawfzAmpFJ1J5+t3vPIhi0qW7YrgGdp+voI8NaYAgta1W1P75bskOFAlUujxOtc8w==
X-Received: by 2002:a9d:6b14:0:b0:6bd:11b:39bf with SMTP id g20-20020a9d6b14000000b006bd011b39bfmr2730083otp.4.1696433874320;
        Wed, 04 Oct 2023 08:37:54 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id m2-20020a9d6ac2000000b006b96a4287d4sm490199otq.5.2023.10.04.08.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:37:54 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v4 00/10] Add Milk-V Pioneer RISC-V board support
Date:   Wed,  4 Oct 2023 23:37:20 +0800
Message-Id: <cover.1696433229.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/riscv/boot/dts/sophgo/Makefile           |    3 +
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 2000 +++++++++++++++++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   19 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  325 +++
 arch/riscv/configs/defconfig                  |    1 +
 14 files changed, 2481 insertions(+)
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

