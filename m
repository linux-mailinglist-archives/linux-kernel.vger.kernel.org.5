Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9597B8358
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbjJDPPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243162AbjJDPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:15:19 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1CDD;
        Wed,  4 Oct 2023 08:15:06 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65b05a45046so13090376d6.2;
        Wed, 04 Oct 2023 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696432505; x=1697037305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XofsIHRxsDy7/uRjDVuvcJl4debwFqPRlofVbC1gCrc=;
        b=EQDr/VkAI7pGn0t2Q4624pLnS01LCzvN8OTZhnElwA6bLUXabjUfNRZqXk2+43K2Yc
         TVe1dkj3GXj64XLPwsrTdfoQHrbwpGj82aOu1vMwOANBgsf693YPWaukWJc/XmaWLRnH
         orA4OboUEvjVUNerzHbghVvMM+vC+Co1uFKyZlFkVy74VPvdKxWOFubsoZtDcrR5HuQb
         ZDYziFfjd7pqLDQDqLnmkBSG0n/K3hCMRsCZZ6i63uO57KqbqA5c1PsNtmsIbLKj/5jk
         geAFP+25koJn4Tz2ixq1/7p9eJnIr/8Mdb4j465urLcBy2/KLrpiBGBvqAyUkQRbIvuB
         DozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432505; x=1697037305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XofsIHRxsDy7/uRjDVuvcJl4debwFqPRlofVbC1gCrc=;
        b=mNBsQfkC6eyhTub+whh4XYxyAruGee1K9JeraGNKm/kf+Wsbu0GdlF7e5qn+7bihob
         gvr8jmb62+7Rfxi6oC7flo5/+MRGmy/xanQaRlBHGJcVHmqqlwvtYByWpyRp7KjzHEyf
         gX5D+zS9h9AzGPKKcJPrCXJMpIJv9yrOyKTIKcR2vceG5qkb48W7bbTsRj2fTSjTKWzg
         c4AZSj1GPWtMuMckCoTvp2LhTsDutdHudj8KlwUXBOCBN4No6txiHBrDrsBi7zG8MGb5
         gVyLv8GlRXnrDwnws+7HF0VCcgNiVY55qK9mdIoKSAXDQO/k4gjoZ9h9GjVxri24SwZD
         e02w==
X-Gm-Message-State: AOJu0YyLvBzR6lXlMW0U7wmKqYuFDlK+myKe5jIXBlHBI1kmvPlKnR/w
        XHxE04Y9RBd9CMzRM3YR96Ie1U3Zdl05EmA6Moc=
X-Google-Smtp-Source: AGHT+IHS41SDTJ9MvIGZTDuAJyUx9ePq7eV48gxklE+o6Lc0ODQwAmgGKXZwUit0zxOMQqBd9fyWJZ0fBEn1NpnxVbM=
X-Received: by 2002:a05:6214:5506:b0:65a:fcc7:d77 with SMTP id
 mb6-20020a056214550600b0065afcc70d77mr2373966qvb.55.1696432505322; Wed, 04
 Oct 2023 08:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696426805.git.unicorn_wang@outlook.com>
In-Reply-To: <cover.1696426805.git.unicorn_wang@outlook.com>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Wed, 4 Oct 2023 23:14:54 +0800
Message-ID: <CAHAQgRChywKWKX2=Cyn4VBrZKfy6pY2meHtVqRyBcfRUm7mHYQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Add Milk-V Pioneer RISC-V board support
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this email, it was sent out by mistake.

Chen Wang <unicornxw@gmail.com> =E4=BA=8E2023=E5=B9=B410=E6=9C=884=E6=97=A5=
=E5=91=A8=E4=B8=89 23:11=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 [2]
> in a standard mATX form factor. Add minimal device
> tree files for the SG2042 SOC and the Milk-V Pioneer board.
>
> Now only support basic uart drivers to boot up into a basic console.
>
> Thanks,
> Chen
>
> ---
>
> Changes in v4:
>   The patch series is based on v6.6-rc1. You can simply review or test
>   the patches at the link [6].
>   - Update bindings files for sg2042 clint as per intput from reviewers:
>     - rename filename from sophgo,sg2042-clint-mswi/sg2042-clint-mtimer
>       to thead,c900-aclint-mswi/thead,c900-aclint-mtimer.
>     - rename compatible strings accordingly.
>   - Update dts as per input from reviewers: don't use macro for cpus's is=
a
>     properties; use new compatible strings for mtimer/mswi of clint.
>   - Use only one email-address for SoB.
>
> Changes in v3 [v3]:
>   The patch series is based on v6.6-rc1. You can simply review or test
>   the patches at the link [5].
>   - add new vendor specific compatible strings to identify timer/mswi for=
 sg2042 clint
>   - updated maintainers info. for sophgo devicetree
>   - remove the quirk changes for uart
>   - updated dts, such as:
>     - add "riscv,isa-base"/"riscv,isa-extensions" for cpus
>     - update l2 cache node's name
>     - remove memory and pmu nodes
>   - fixed other issues as per input from reviewers.
>
> Changes in v2 [v2]:
>   The patch series is based on v6.6-rc1. You can simply review or test
>   the patches at the link [4].
>   - Improve format for comment of commitments as per input from last revi=
ew.
>   - Improve format of DTS as per input from last review.
>   - Remove numa related stuff from DTS. This part is just for optimizatio=
n, may
>     add it later if really needed.
>
> Changes in v1:
>    The patch series is based on v6.6-rc1. Due to it is not sent in thread=
,
>    I have listed permlinks of the patchset [v1-0/12] ~ [v1-12/12] here fo=
r
>    quick reference. You can simply review or test the patches at the link=
 [3].
>
> [1]: https://milkv.io/pioneer
> [2]: https://en.sophgo.com/product/introduce/sg2042.html
> [3]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minima=
l
> [4]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minima=
l-v2
> [5]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minima=
l-v3
> [6]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minima=
l-v4
> [v1-0/12]:https://lore.kernel.org/linux-riscv/20230915070856.117514-1-wan=
gchen20@iscas.ac.cn/
> [v1-1/12]:https://lore.kernel.org/linux-riscv/20230915071005.117575-1-wan=
gchen20@iscas.ac.cn/
> [v1-2/12]:https://lore.kernel.org/linux-riscv/20230915071409.117692-1-wan=
gchen20@iscas.ac.cn/
> [v1-3/12]:https://lore.kernel.org/linux-riscv/20230915072242.117935-1-wan=
gchen20@iscas.ac.cn/
> [v1-4/12]:https://lore.kernel.org/linux-riscv/20230915072333.117991-1-wan=
gchen20@iscas.ac.cn/
> [v1-5/12]:https://lore.kernel.org/linux-riscv/20230915072358.118045-1-wan=
gchen20@iscas.ac.cn/
> [v1-6/12]:https://lore.kernel.org/linux-riscv/20230915072415.118100-1-wan=
gchen20@iscas.ac.cn/
> [v1-7/12]:https://lore.kernel.org/linux-riscv/20230915072431.118154-1-wan=
gchen20@iscas.ac.cn/
> [v1-8/12]:https://lore.kernel.org/linux-riscv/20230915072451.118209-1-wan=
gchen20@iscas.ac.cn/
> [v1-9/12]:https://lore.kernel.org/linux-riscv/20230915072517.118266-1-wan=
gchen20@iscas.ac.cn/
> [v1-10/12]:https://lore.kernel.org/linux-riscv/20230915072558.118325-1-wa=
ngchen20@iscas.ac.cn/
> [v1-11/12]:https://lore.kernel.org/linux-riscv/20230915072624.118388-1-wa=
ngchen20@iscas.ac.cn/
> [v1-12/12]:https://lore.kernel.org/linux-riscv/20230915072653.118448-1-wa=
ngchen20@iscas.ac.cn/
> [v2]:https://lore.kernel.org/linux-riscv/cover.1695189879.git.wangchen20@=
iscas.ac.cn/
> [v3]:https://lore.kernel.org/linux-riscv/cover.1695804418.git.unicornxw@g=
mail.com/
>
> ---
>
> Chen Wang (8):
>   riscv: Add SOPHGO SOC family Kconfig support
>   dt-bindings: vendor-prefixes: add milkv/sophgo
>   dt-bindings: riscv: add sophgo sg2042 bindings
>   dt-bindings: riscv: Add T-HEAD C920 compatibles
>   dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
>   riscv: dts: add initial Sophgo SG2042 SoC device tree
>   riscv: dts: sophgo: add Milk-V Pioneer board device tree
>   riscv: defconfig: enable SOPHGO SoC
>
> Inochi Amaoto (2):
>   dt-bindings: timer: Add Sophgo sg2042 CLINT timer
>   dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi
>
>  .../sifive,plic-1.0.0.yaml                    |    1 +
>  .../thead,c900-aclint-mswi.yaml               |   43 +
>  .../devicetree/bindings/riscv/cpus.yaml       |    1 +
>  .../devicetree/bindings/riscv/sophgo.yaml     |   28 +
>  .../timer/thead,c900-aclint-mtimer.yaml       |   43 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |    4 +
>  MAINTAINERS                                   |    7 +
>  arch/riscv/Kconfig.socs                       |    5 +
>  arch/riscv/boot/dts/Makefile                  |    1 +
>  arch/riscv/boot/dts/sophgo/Makefile           |    3 +
>  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 2000 +++++++++++++++++
>  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   19 +
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  325 +++
>  arch/riscv/configs/defconfig                  |    1 +
>  14 files changed, 2481 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/thead,c900-aclint-mswi.yaml
>  create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml
>  create mode 100644 Documentation/devicetree/bindings/timer/thead,c900-ac=
lint-mtimer.yaml
>  create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi
>
>
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> --
> 2.25.1
>
