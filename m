Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22B07B0F98
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 01:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjI0XkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 19:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0Xj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 19:39:59 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFC6F4;
        Wed, 27 Sep 2023 16:39:57 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65b10205207so36626826d6.0;
        Wed, 27 Sep 2023 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695857997; x=1696462797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQWVSyMSESKVXR7lHsisu37f0DFjVJDNSkQFdAeg8Rc=;
        b=glEnYWQKUCJsHEyo4ev9nrcbV3fvHL3I1eg+YGWrouZxy3Htwc/81fhaHMta+RAFzc
         nr7CtV6Epb0GBmSYSViqF8dkPfG+OhbIOJjBnzlQOQ5TMXz4fwVtIB8FlVJP/nsmti4G
         LsWjYcFXuaUy3GcHBmhDcENs4Omfvza3aY4kHRUTd+AGXnMcG90gQjPyvB5K8LOYfotl
         s8UG6u50Oz1dHEte6kNV+0zPwHlKfbN+MERyz0xnQmBzNLsOV5O4a+53tphASdsgUkcU
         n2xE5AcMeKO6FJVm698NDe3Wltwy6ihNJ/CVMds6WICDwZHojEOHBuidBPmJDcLUfsB0
         TLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695857997; x=1696462797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQWVSyMSESKVXR7lHsisu37f0DFjVJDNSkQFdAeg8Rc=;
        b=exefzGnt3/tcNcPK+zBFs/OvD33gozBa7jKHUAyBgqBrQaq7m0VSjz5JNHjWV4zwbd
         zxO4XmLX37jbB+6g6PVsBbjuATY+owRTGvt6dJ8XqeywgZ89pUh+oh6SH5mMVfnJ6kST
         rRI/AL4hrab8h55k3Sdmi5FK2YIyRBXMxCA3sYkU7R1KzIySVpNvQQreuleJD3FcwcQB
         Z2wXNInvVOiV1QxXLpCejJ2/epFpPfE9QCulVGAvRIPzhDNQjgTbUAS8iuVChrcIxeoE
         os9fQCcOqNCZbC2z1RiHnMYFcrG3hvQjE40Qn1sJhc6ori24de3IbXIWSIdbhDl7rDaE
         JDzw==
X-Gm-Message-State: AOJu0YxFXR8ODYBZanNkcKLNfCq5T4Y3dq4cyWSj8HZRq2bt48GJux45
        wPhC156oIWBInzKFhlfG6Qyk9NpQWtauH/FF+XE=
X-Google-Smtp-Source: AGHT+IFoprYkIDxUtCHlyYzh+wqHcvx4P6k6uIZuO/hY4iiSk4nxHrGQAOkw+bADmNjWozNYnrs3WHNz87mEp9N4gkU=
X-Received: by 2002:a0c:f04c:0:b0:65b:1744:55d4 with SMTP id
 b12-20020a0cf04c000000b0065b174455d4mr3619280qvl.3.1695857996868; Wed, 27 Sep
 2023 16:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695804418.git.unicornxw@gmail.com> <20230927-ebony-duress-44ff45d3d253@spud>
In-Reply-To: <20230927-ebony-duress-44ff45d3d253@spud>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Thu, 28 Sep 2023 07:39:45 +0800
Message-ID: <CAHAQgRC2xeqUu4mDZRJd3brcPNT4KovX65rNE7YXm+ku0+eERg@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add Milk-V Pioneer RISC-V board support
To:     Conor Dooley <conor@kernel.org>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor@kernel.org> =E4=BA=8E2023=E5=B9=B49=E6=9C=8828=E6=97=A5=
=E5=91=A8=E5=9B=9B 00:09=E5=86=99=E9=81=93=EF=BC=9A
>
> Hey,
>
> On Wed, Sep 27, 2023 at 04:54:38PM +0800, Chen Wang wrote:
> > Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 [2=
]
> > in a standard mATX form factor. Add minimal device
> > tree files for the SG2042 SOC and the Milk-V Pioneer board.
> >
> > Now only support basic uart drivers to boot up into a basic console.
> >
> > Thanks,
> > Chen
> >
> > ---
> >
> > Changes in v3:
> >   The patch series is based on v6.6-rc1. You can simply review or test
> >   the patches at the link [5].
> >   - add new vendor specific compatible strings to identify timer/mswi f=
or sg2042 clint
> >   - updated maintainers info. for sophgo devicetree
> >   - remove the quirk changes for uart
> >   - updated dts, such as:
> >     - add "riscv,isa-base"/"riscv,isa-extensions" for cpus
> >     - update l2 cache node's name
> >     - remove memory and pmu nodes
> >   - fixed other issues as per input from reviewers.
>
> v3 looks better indeed. I had some comments on the bindings and dt
> patches, but none were particularly major.
>
> Thanks,
> Conor.
>
Thanks, Conor, I will continue imrpoving according to your commnents.

> >
> > Changes in v2:
> >   The patch series is based on v6.6-rc1. You can simply review or test
> >   the patches at the link [4].
> >   - Improve format for comment of commitments as per input from last re=
view.
> >   - Improve format of DTS as per input from last review.
> >   - Remove numa related stuff from DTS. This part is just for optimizat=
ion, may
> >     add it later if really needed.
> >
> > Changes in v1:
> >    The patch series is based on v6.6-rc1. Due to it is not sent in thre=
ad,
> >    I have listed permlinks of the patchset [v1-0/12] ~ [v1-12/12] here =
for
> >    quick reference. You can simply review or test the patches at the li=
nk [3].
> >
> > [1]: https://milkv.io/pioneer
> > [2]: https://en.sophgo.com/product/introduce/sg2042.html
> > [3]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-mini=
mal
> > [4]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-mini=
mal-v2
> > [5]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-mini=
mal-v3
> > [v1-0/12]:https://lore.kernel.org/linux-riscv/20230915070856.117514-1-w=
angchen20@iscas.ac.cn/
> > [v1-1/12]:https://lore.kernel.org/linux-riscv/20230915071005.117575-1-w=
angchen20@iscas.ac.cn/
> > [v1-2/12]:https://lore.kernel.org/linux-riscv/20230915071409.117692-1-w=
angchen20@iscas.ac.cn/
> > [v1-3/12]:https://lore.kernel.org/linux-riscv/20230915072242.117935-1-w=
angchen20@iscas.ac.cn/
> > [v1-4/12]:https://lore.kernel.org/linux-riscv/20230915072333.117991-1-w=
angchen20@iscas.ac.cn/
> > [v1-5/12]:https://lore.kernel.org/linux-riscv/20230915072358.118045-1-w=
angchen20@iscas.ac.cn/
> > [v1-6/12]:https://lore.kernel.org/linux-riscv/20230915072415.118100-1-w=
angchen20@iscas.ac.cn/
> > [v1-7/12]:https://lore.kernel.org/linux-riscv/20230915072431.118154-1-w=
angchen20@iscas.ac.cn/
> > [v1-8/12]:https://lore.kernel.org/linux-riscv/20230915072451.118209-1-w=
angchen20@iscas.ac.cn/
> > [v1-9/12]:https://lore.kernel.org/linux-riscv/20230915072517.118266-1-w=
angchen20@iscas.ac.cn/
> > [v1-10/12]:https://lore.kernel.org/linux-riscv/20230915072558.118325-1-=
wangchen20@iscas.ac.cn/
> > [v1-11/12]:https://lore.kernel.org/linux-riscv/20230915072624.118388-1-=
wangchen20@iscas.ac.cn/
> > [v1-12/12]:https://lore.kernel.org/linux-riscv/20230915072653.118448-1-=
wangchen20@iscas.ac.cn/
> >
> > ---
> >
> > Chen Wang (9):
> >   riscv: Add SOPHGO SOC family Kconfig support
> >   dt-bindings: vendor-prefixes: add milkv/sophgo
> >   dt-bindings: riscv: add sophgo sg2042 bindings
> >   dt-bindings: riscv: Add T-HEAD C920 compatibles
> >   dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
> >   MAINTAINERS: add two files to sophgo devicetrees entry
> >   riscv: dts: add initial Sophgo SG2042 SoC device tree
> >   riscv: dts: sophgo: add Milk-V Pioneer board device tree
> >   riscv: defconfig: enable SOPHGO SoC
> >
> > Inochi Amaoto (2):
> >   dt-bindings: timer: Add Sophgo sg2042 CLINT timer
> >   dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi
> >
> >  .../sifive,plic-1.0.0.yaml                    |    1 +
> >  .../sophgo,sg2042-clint-mswi.yaml             |   42 +
> >  .../devicetree/bindings/riscv/cpus.yaml       |    1 +
> >  .../devicetree/bindings/riscv/sophgo.yaml     |   28 +
> >  .../timer/sophgo,sg2042-clint-mtimer.yaml     |   42 +
> >  .../devicetree/bindings/vendor-prefixes.yaml  |    4 +
> >  MAINTAINERS                                   |    9 +
> >  arch/riscv/Kconfig.socs                       |    5 +
> >  arch/riscv/boot/dts/Makefile                  |    1 +
> >  arch/riscv/boot/dts/sophgo/Makefile           |    3 +
> >  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 1880 +++++++++++++++++
> >  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   19 +
> >  arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  325 +++
> >  arch/riscv/configs/defconfig                  |    1 +
> >  14 files changed, 2361 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/sophgo,sg2042-clint-mswi.yaml
> >  create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml
> >  create mode 100644 Documentation/devicetree/bindings/timer/sophgo,sg20=
42-clint-mtimer.yaml
> >  create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
> >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi
> >
> >
> > base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> > --
> > 2.25.1
> >
