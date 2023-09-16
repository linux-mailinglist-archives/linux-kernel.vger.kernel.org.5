Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778577A2C68
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbjIPAdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbjIPAd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:33:27 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF7ECC7;
        Fri, 15 Sep 2023 17:32:36 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7a826cf93a8so1041912241.2;
        Fri, 15 Sep 2023 17:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694824355; x=1695429155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSgpTl3s5xlqE9qnmQJsK0Gu0HeFWcZ36wEdWqiUY/0=;
        b=Q76K4YzJFYuGnvV3z/pO8pHs8dWAKgrZx3eWVBSw6rEDhVOzeQQNGvSejzi1JjnDTp
         Oh/RSKBSXO9FfSCSIHA8ZpNQwrpRodvDajt4Jep4CBUZWyHOsl6VL0E+wIjZ7hfKssP2
         q4IXNvf+pBt1P62s+StsfowK2WXkNH2sw8r+cpLUqhXkdiiCiU0NoVftvbCNC3t7Ml7f
         bmr8qtkVxhOTSW802PxPmcsemk94dJPu/0LvyDy1L7nDdofX32g+cMhqdItGR7HSXth+
         duuBwoAtINxX8qpfwEGavhWSI9yc/lvRoxJ8Gmfe6HQS6SxFyMOMBtw/DJ083qmjvxuZ
         RWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824355; x=1695429155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSgpTl3s5xlqE9qnmQJsK0Gu0HeFWcZ36wEdWqiUY/0=;
        b=K8ckwygpMkuqWDQIV79nplVCZ/ibQ/pKTCOqVPXwgMc16Fy8vdACndPCPnsG7izmvC
         1HuWIkMmxjJBR8fWohXOGSb8h/JWEWEsmq4Xr5ZTUKzaIs3mTqvKIQ5+rKFk5iJZewZm
         n31i5NsVHqYcw6iSt77GKuXdYZRHar0J6sgEaswblcroT0akyhZoLaikX4Pw/VCoNFu6
         wR07U3SHmnqLQYRD7A5cmF9a6RAvDry8/EIsY0suac+JhLZR+U1leL+rAh31NG0ffnUk
         lN/7SYztuR3W4Jje7cekVH3gZwZI6NwE+3NLhnyJXRiBkdJTyQ9nQRsqpM9m0jZa0/te
         b8ww==
X-Gm-Message-State: AOJu0YzJgLsWFYDsUUe8434bqdjAdxZADsnphgcflXi3LYbd6c0A3CFC
        936wSCLMg25IfdTD8Q5UOJXItwf/asmL73tIpg5mRaF8tnbhb1Pp
X-Google-Smtp-Source: AGHT+IHKloctG4VPedbAi2PNydChlV8b2FL9RhlEYJq6OZengzOTdCc/azzBibGpVVfgVCkv3aI1V2lrjPXdzQL+wo8=
X-Received: by 2002:a05:6102:508:b0:44d:50f8:f with SMTP id
 l8-20020a056102050800b0044d50f8000fmr3201076vsa.17.1694823836846; Fri, 15 Sep
 2023 17:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230915072431.118154-1-wangchen20@iscas.ac.cn> <fa9755be-13c0-6934-9f48-f6cb35518331@linaro.org>
In-Reply-To: <fa9755be-13c0-6934-9f48-f6cb35518331@linaro.org>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Sat, 16 Sep 2023 08:23:45 +0800
Message-ID: <CAHAQgRDtQDx-DBSs6Afs_C3qrRDxqONENM9rXu43dWCw0ehXPA@mail.gmail.com>
Subject: Re: [PATCH 07/12] riscv: dts: add initial SOPHGO SG2042 SoC device tree
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
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

Thanks for your input, Krzysztof, I will correct these in next revision.

Regards,

unicornx

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2023=E5=B9=B4=
9=E6=9C=8815=E6=97=A5=E5=91=A8=E4=BA=94 15:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On 15/09/2023 09:24, Wang Chen wrote:
> > Milk-V Pioneer motherboard is powered by SOPHON's SG2042.
> >
> > SG2042 is server grade chip with high performance, low power
> > consumption and high data throughput.
> > Key features:
> > - 64 RISC-V cpu cores which implements IMAFDC
> > - 4 cores per cluster, 16 clusters on chip
> > - ......
> >
> > More info is available at [1].
> >
> > [1]: https://en.sophgo.com/product/introduce/sg2042.html
> >
> > Currently only support booting into console with only uart
> > enabled, other features will be added soon later.
> >
> > Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> > ---
> >  MAINTAINERS                                 |    1 +
> >  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 1794 +++++++++++++++++++
> >  arch/riscv/boot/dts/sophgo/sg2042.dtsi      |  513 ++++++
> >  3 files changed, 2308 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0e0d477dab38..b74d505003e2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20068,6 +20068,7 @@ M:    Xiaoguang Xing <xiaoguang.xing@sophgo.com=
>
> >  M:   Chao Wei <chao.wei@sophgo.com>
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/riscv/sophgo.yaml
> > +F:   arch/riscv/boot/dts/sophgo/
> >
> >  SOUND
> >  M:   Jaroslav Kysela <perex@perex.cz>
> > diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/b=
oot/dts/sophgo/sg2042-cpus.dtsi
> > new file mode 100644
> > index 000000000000..0b6cd3559693
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> > @@ -0,0 +1,1794 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > +/*
> > + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> > + */
> > +
> > +/ {
>
>
> ..
> > +
> > +             cpu0: cpu@0 {
> > +                     compatible =3D "thead,c920", "riscv";
> > +                     device_type =3D "cpu";
> > +                     riscv,isa =3D "rv64imafdc";
> > +                     reg =3D <0>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <512>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <512>;
> > +                     next-level-cache =3D <&l2_cache0>;
> > +                     mmu-type =3D "riscv,sv39";
> > +                     numa-node-id =3D <0>;
> > +                     status =3D "okay";
>
> Drop, it's by defualt. This applies everywhere.
>
> > +
> > +                     cpu0_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <1>;
> > +                     };
> > +             };
>
> Missing blank line
>
> > +             cpu1: cpu@1 {
> > +                     compatible =3D "thead,c920", "riscv";
> > +                     device_type =3D "cpu";
> > +                     riscv,isa =3D "rv64imafdc";
> > +                     reg =3D <1>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <512>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <512>;
> > +                     next-level-cache =3D <&l2_cache0>;
> > +                     mmu-type =3D "riscv,sv39";
> > +                     numa-node-id =3D <0>;
> > +                     status =3D "okay";
> > +
> > +                     cpu1_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <1>;
> > +                     };
> > +             };
>
> Missing blank line. This applies everywhere.
>
> > +             cpu2: cpu@2 {
> > +                     compatible =3D "thead,c920", "riscv";
> > +                     device_type =3D "cpu";
> > +                     riscv,isa =3D "rv64imafdc";
> > +                     reg =3D <2>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <512>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <512>;
> > +                     next-level-cache =3D <&l2_cache0>;
> > +                     mmu-type =3D "riscv,sv39";
> > +                     numa-node-id =3D <0>;
> > +                     status =3D "okay";
> > +
> > +                     cpu2_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <1>;
> > +                     };
>
>
> > +
> > +             l2_cache0: l2-cache@0 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
>
> Missing blank line
>
> > +             l2_cache1: l2-cache@1 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
>
> Missing blank line
>
> > +             l2_cache2: l2-cache@2 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache3: l2-cache@3 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache4: l2-cache@4 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache5: l2-cache@5 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache6: l2-cache@6 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache7: l2-cache@7 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache8: l2-cache@8 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache9: l2-cache@9 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache10: l2-cache@10 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache11: l2-cache@11 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache12: l2-cache@12 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache13: l2-cache@13 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache14: l2-cache@14 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +             l2_cache15: l2-cache@15 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <1048576>;
> > +                     cache-sets =3D <1024>;
> > +                     cache-unified;
> > +             };
> > +     };
> > +};
> > diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/d=
ts/sophgo/sg2042.dtsi
> > new file mode 100644
> > index 000000000000..5c4b82f13207
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > @@ -0,0 +1,513 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > +/*
> > + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> > + */
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +#include "sg2042-cpus.dtsi"
> > +
> > +#define SOC_PERIPHERAL_IRQ(nr) (nr)
> > +
> > +/ {
> > +     compatible =3D "sophgo,sg2042";
> > +     #address-cells =3D <2>;
> > +     #size-cells =3D <2>;
> > +     dma-noncoherent;
> > +
> > +     distance-map {
> > +             compatible =3D "numa-distance-map-v1";
> > +             distance-matrix =3D <0 0 10>,
> > +                               <0 1 15>,
> > +                               <0 2 25>,
> > +                               <0 3 30>,
> > +                               <1 0 15>,
> > +                               <1 1 10>,
> > +                               <1 2 30>,
> > +                               <1 3 25>,
> > +                               <2 0 25>,
> > +                               <2 1 30>,
> > +                               <2 2 10>,
> > +                               <2 3 15>,
> > +                               <3 0 30>,
> > +                               <3 1 25>,
> > +                               <3 2 15>,
> > +                               <3 3 10>;
> > +     };
> > +
> > +     /* the mem node will be updated by ZSBL. */
> > +     memory@0 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x00000000 0x00000000 0x00000000 0x00000000>;
> > +             numa-node-id =3D <0>;
> > +     };
> > +     memory@1 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x00000000 0x00000001 0x00000000 0x00000000>;
> > +             numa-node-id =3D <1>;
> > +     };
> > +     memory@2 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x00000000 0x00000002 0x00000000 0x00000000>;
> > +             numa-node-id =3D <2>;
> > +     };
> > +     memory@3 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x00000000 0x00000003 0x00000000 0x00000000>;
> > +             numa-node-id =3D <3>;
> > +     };
> > +
> > +     reserved-memory {
> > +             #address-cells =3D <0x2>;
> > +             #size-cells =3D <0x2>;
> > +             ranges;
>
> Missing blank line
>
> > +             linux,cma {
> > +                     compatible =3D "shared-dma-pool";
> > +                     size =3D <0x00000000 0x10000000>;
> > +                     alloc-ranges =3D <0x00000000 0xc0000000
> > +                                     0x00000000 0xd0000000>;
> > +                     reusable;
> > +                     linux,cma-default;
> > +             };
> > +     };
> > +
> > +     pmu {
> > +             compatible =3D "riscv,pmu";
> > +             riscv,event-to-mhpmevent =3D
> > +                     <0x00003 0x00000000 0x00000010>,
> > +                     <0x00004 0x00000000 0x00000011>,
> > +                     <0x00005 0x00000000 0x00000007>,
> > +                     <0x00006 0x00000000 0x00000006>,
> > +                     <0x00008 0x00000000 0x00000027>,
> > +                     <0x00009 0x00000000 0x00000028>,
> > +                     <0x10000 0x00000000 0x0000000c>,
> > +                     <0x10001 0x00000000 0x0000000d>,
> > +                     <0x10002 0x00000000 0x0000000e>,
> > +                     <0x10003 0x00000000 0x0000000f>,
> > +                     <0x10008 0x00000000 0x00000001>,
> > +                     <0x10009 0x00000000 0x00000002>,
> > +                     <0x10010 0x00000000 0x00000010>,
> > +                     <0x10011 0x00000000 0x00000011>,
> > +                     <0x10012 0x00000000 0x00000012>,
> > +                     <0x10013 0x00000000 0x00000013>,
> > +                     <0x10019 0x00000000 0x00000004>,
> > +                     <0x10021 0x00000000 0x00000003>,
> > +                     <0x10030 0x00000000 0x0000001c>,
> > +                     <0x10031 0x00000000 0x0000001b>;
> > +             riscv,event-to-mhpmcounters =3D
> > +                     <0x00003 0x00003 0xfffffff8>,
> > +                     <0x00004 0x00004 0xfffffff8>,
> > +                     <0x00005 0x00005 0xfffffff8>,
> > +                     <0x00006 0x00006 0xfffffff8>,
> > +                     <0x00007 0x00007 0xfffffff8>,
> > +                     <0x00008 0x00008 0xfffffff8>,
> > +                     <0x00009 0x00009 0xfffffff8>,
> > +                     <0x0000a 0x0000a 0xfffffff8>,
> > +                     <0x10000 0x10000 0xfffffff8>,
> > +                     <0x10001 0x10001 0xfffffff8>,
> > +                     <0x10002 0x10002 0xfffffff8>,
> > +                     <0x10003 0x10003 0xfffffff8>,
> > +                     <0x10008 0x10008 0xfffffff8>,
> > +                     <0x10009 0x10009 0xfffffff8>,
> > +                     <0x10010 0x10010 0xfffffff8>,
> > +                     <0x10011 0x10011 0xfffffff8>,
> > +                     <0x10012 0x10012 0xfffffff8>,
> > +                     <0x10013 0x10013 0xfffffff8>,
> > +                     <0x10019 0x10019 0xfffffff8>,
> > +                     <0x10021 0x10021 0xfffffff8>,
> > +                     <0x10030 0x10030 0xfffffff8>,
> > +                     <0x10031 0x10031 0xfffffff8>;
> > +             riscv,raw-event-to-mhpmcounters =3D
> > +                     <0x00000000 0x00000001 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000002 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000003 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000004 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000005 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000006 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000007 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000008 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000009 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000000a 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000000b 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000000c 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000000d 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000000e 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000000f 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000010 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000011 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000012 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000013 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000014 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000015 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000016 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000017 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000018 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000019 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000001a 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000001b 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000001c 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000001d 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000001e 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000001f 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000020 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000021 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000022 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000023 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000024 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000025 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000026 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000027 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000028 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x00000029 0xffffffff 0xffffffff 0xff=
fffff8>,
> > +                     <0x00000000 0x0000002a 0xffffffff 0xffffffff 0xff=
fffff8>;
> > +     };
> > +
> > +     soc: soc {
> > +             compatible =3D "simple-bus";
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <2>;
> > +             ranges;
> > +
> > +             clint_mswi: clint-mswi@7094000000 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>
>
> > +                     compatible =3D "sophgo,sg2042-clint-mswi", "thead=
,c900-clint-mswi";
> > +                     reg =3D <0x00000070 0x94000000 0x00000000 0x00004=
000>;
> > +                     interrupts-extended =3D <
>
> Your formatting is odd. This wrap is not needed.
>
> > +                             &cpu0_intc 3
> > +                             &cpu1_intc 3
> > +                             &cpu2_intc 3
> > +                             &cpu3_intc 3
> > +                             &cpu4_intc 3
> > +                             &cpu5_intc 3
> > +                             &cpu6_intc 3
> > +                             &cpu7_intc 3
> > +                             &cpu8_intc 3
> > +                             &cpu9_intc 3
> > +                             &cpu10_intc 3
> > +                             &cpu11_intc 3
> > +                             &cpu12_intc 3
> > +                             &cpu13_intc 3
> > +                             &cpu14_intc 3
> > +                             &cpu15_intc 3
> > +                             &cpu16_intc 3
> > +                             &cpu17_intc 3
> > +                             &cpu18_intc 3
> > +                             &cpu19_intc 3
> > +                             &cpu20_intc 3
> > +                             &cpu21_intc 3
> > +                             &cpu22_intc 3
> > +                             &cpu23_intc 3
> > +                             &cpu24_intc 3
> > +                             &cpu25_intc 3
> > +                             &cpu26_intc 3
> > +                             &cpu27_intc 3
> > +                             &cpu28_intc 3
> > +                             &cpu29_intc 3
> > +                             &cpu30_intc 3
> > +                             &cpu31_intc 3
> > +                             &cpu32_intc 3
> > +                             &cpu33_intc 3
> > +                             &cpu34_intc 3
> > +                             &cpu35_intc 3
> > +                             &cpu36_intc 3
> > +                             &cpu37_intc 3
> > +                             &cpu38_intc 3
> > +                             &cpu39_intc 3
> > +                             &cpu40_intc 3
> > +                             &cpu41_intc 3
> > +                             &cpu42_intc 3
> > +                             &cpu43_intc 3
> > +                             &cpu44_intc 3
> > +                             &cpu45_intc 3
> > +                             &cpu46_intc 3
> > +                             &cpu47_intc 3
> > +                             &cpu48_intc 3
> > +                             &cpu49_intc 3
> > +                             &cpu50_intc 3
> > +                             &cpu51_intc 3
> > +                             &cpu52_intc 3
> > +                             &cpu53_intc 3
> > +                             &cpu54_intc 3
> > +                             &cpu55_intc 3
> > +                             &cpu56_intc 3
> > +                             &cpu57_intc 3
> > +                             &cpu58_intc 3
> > +                             &cpu59_intc 3
> > +                             &cpu60_intc 3
> > +                             &cpu61_intc 3
> > +                             &cpu62_intc 3
> > +                             &cpu63_intc 3
> > +                             >;
> > +             };
> > +
> > +             clint_mtimer0: clint-mtimer@70ac000000 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>
>
> > +                     compatible =3D "sophgo,sg2042-clint-mtimer", "the=
ad,c900-clint-mtimer";
> > +                     reg =3D <0x00000070 0xac000000 0x00000000 0x00007=
ff8>;
> > +                     interrupts-extended =3D <
> > +                             &cpu0_intc 7
> > +                             &cpu1_intc 7
> > +                             &cpu2_intc 7
> > +                             &cpu3_intc 7
> > +                             >;
> > +             };
> > +
> > +             clint_mtimer1: clint-mtimer@70ac010000 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>
>
> > +                     compatible =3D "sophgo,sg2042-clint-mtimer", "the=
ad,c900-clint-mtimer";
> > +                     reg =3D <0x00000070 0xac010000 0x00000000 0x00007=
ff8>;
> > +                     interrupts-extended =3D <
> > +                             &cpu4_intc 7
>
> Srsly, fix your style. This is unreadable.
>
> > +                             &cpu5_intc 7
> > +                             &cpu6_intc 7
> > +                             &cpu7_intc 7
> > +                             >;
> > +             };
> > +
>
> ...
>
> > +
> > +             intc: interrupt-controller@7090000000 {
> > +                     compatible =3D "sophgo,sg2042-plic", "thead,c900-=
plic";
> > +                     #address-cells =3D <0>;
> > +                     #interrupt-cells =3D <2>;
> > +                     reg =3D <0x00000070 0x90000000 0x00000000 0x04000=
000>;
> > +                     interrupt-controller;
> > +                     interrupts-extended =3D <
> > +                             &cpu0_intc  0xffffffff &cpu0_intc  9
> > +                             &cpu1_intc  0xffffffff &cpu1_intc  9
> > +                             &cpu2_intc  0xffffffff &cpu2_intc  9
> > +                             &cpu3_intc  0xffffffff &cpu3_intc  9
> > +                             &cpu4_intc  0xffffffff &cpu4_intc  9
> > +                             &cpu5_intc  0xffffffff &cpu5_intc  9
> > +                             &cpu6_intc  0xffffffff &cpu6_intc  9
> > +                             &cpu7_intc  0xffffffff &cpu7_intc  9
> > +                             &cpu8_intc  0xffffffff &cpu8_intc  9
> > +                             &cpu9_intc  0xffffffff &cpu9_intc  9
> > +                             &cpu10_intc  0xffffffff &cpu10_intc  9
> > +                             &cpu11_intc  0xffffffff &cpu11_intc  9
> > +                             &cpu12_intc  0xffffffff &cpu12_intc  9
> > +                             &cpu13_intc  0xffffffff &cpu13_intc  9
> > +                             &cpu14_intc  0xffffffff &cpu14_intc  9
> > +                             &cpu15_intc  0xffffffff &cpu15_intc  9
> > +                             &cpu16_intc  0xffffffff &cpu16_intc  9
> > +                             &cpu17_intc  0xffffffff &cpu17_intc  9
> > +                             &cpu18_intc  0xffffffff &cpu18_intc  9
> > +                             &cpu19_intc  0xffffffff &cpu19_intc  9
> > +                             &cpu20_intc  0xffffffff &cpu20_intc  9
> > +                             &cpu21_intc  0xffffffff &cpu21_intc  9
> > +                             &cpu22_intc  0xffffffff &cpu22_intc  9
> > +                             &cpu23_intc  0xffffffff &cpu23_intc  9
> > +                             &cpu24_intc  0xffffffff &cpu24_intc  9
> > +                             &cpu25_intc  0xffffffff &cpu25_intc  9
> > +                             &cpu26_intc  0xffffffff &cpu26_intc  9
> > +                             &cpu27_intc  0xffffffff &cpu27_intc  9
> > +                             &cpu28_intc  0xffffffff &cpu28_intc  9
> > +                             &cpu29_intc  0xffffffff &cpu29_intc  9
> > +                             &cpu30_intc  0xffffffff &cpu30_intc  9
> > +                             &cpu31_intc  0xffffffff &cpu31_intc  9
> > +                             &cpu32_intc  0xffffffff &cpu32_intc  9
> > +                             &cpu33_intc  0xffffffff &cpu33_intc  9
> > +                             &cpu34_intc  0xffffffff &cpu34_intc  9
> > +                             &cpu35_intc  0xffffffff &cpu35_intc  9
> > +                             &cpu36_intc  0xffffffff &cpu36_intc  9
> > +                             &cpu37_intc  0xffffffff &cpu37_intc  9
> > +                             &cpu38_intc  0xffffffff &cpu38_intc  9
> > +                             &cpu39_intc  0xffffffff &cpu39_intc  9
> > +                             &cpu40_intc  0xffffffff &cpu40_intc  9
> > +                             &cpu41_intc  0xffffffff &cpu41_intc  9
> > +                             &cpu42_intc  0xffffffff &cpu42_intc  9
> > +                             &cpu43_intc  0xffffffff &cpu43_intc  9
> > +                             &cpu44_intc  0xffffffff &cpu44_intc  9
> > +                             &cpu45_intc  0xffffffff &cpu45_intc  9
> > +                             &cpu46_intc  0xffffffff &cpu46_intc  9
> > +                             &cpu47_intc  0xffffffff &cpu47_intc  9
> > +                             &cpu48_intc  0xffffffff &cpu48_intc  9
> > +                             &cpu49_intc  0xffffffff &cpu49_intc  9
> > +                             &cpu50_intc  0xffffffff &cpu50_intc  9
> > +                             &cpu51_intc  0xffffffff &cpu51_intc  9
> > +                             &cpu52_intc  0xffffffff &cpu52_intc  9
> > +                             &cpu53_intc  0xffffffff &cpu53_intc  9
> > +                             &cpu54_intc  0xffffffff &cpu54_intc  9
> > +                             &cpu55_intc  0xffffffff &cpu55_intc  9
> > +                             &cpu56_intc  0xffffffff &cpu56_intc  9
> > +                             &cpu57_intc  0xffffffff &cpu57_intc  9
> > +                             &cpu58_intc  0xffffffff &cpu58_intc  9
> > +                             &cpu59_intc  0xffffffff &cpu59_intc  9
> > +                             &cpu60_intc  0xffffffff &cpu60_intc  9
> > +                             &cpu61_intc  0xffffffff &cpu61_intc  9
> > +                             &cpu62_intc  0xffffffff &cpu62_intc  9
> > +                             &cpu63_intc  0xffffffff &cpu63_intc  9
> > +                             >;
> > +                     riscv,ndev =3D <224>;
> > +             };
> > +
> > +             uart0: serial@7040000000 {
> > +                     compatible =3D "snps,dw-apb-uart";
> > +                     reg =3D <0x00000070 0x40000000 0x00000000 0x00001=
000>;
> > +                     interrupt-parent =3D <&intc>;
> > +                     interrupts =3D <SOC_PERIPHERAL_IRQ(112) IRQ_TYPE_=
LEVEL_HIGH>;
> > +                     clock-frequency =3D <500000000>;
> > +                     reg-shift =3D <2>;
> > +                     reg-io-width =3D <4>;
> > +             };
> > +     };
> > +
> > +     aliases {
> > +             serial0 =3D &uart0;
> > +     };
>
> This does not go to the end. Keep the nodes ordered alphanumerically.
>
> > +
> > +     chosen: chosen {
> > +             bootargs =3D "console=3DttyS0,115200 earlycon";
>
> NAK. No need and not suitable for mainline usage.
>
> > +             stdout-path =3D "serial0";
>
> You need only this.
>
> > +     };
> > +};
>
> Best regards,
> Krzysztof
>
