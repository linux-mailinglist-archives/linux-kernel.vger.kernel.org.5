Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272DC7A9D55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjIUTbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjIUTaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:30:10 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CEDAE973;
        Thu, 21 Sep 2023 11:06:02 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7740c520847so54019785a.2;
        Thu, 21 Sep 2023 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319562; x=1695924362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5aeL1m05j80e9oN+xLZ02mKk3/iGVLqCptcDUWIcms=;
        b=QfQFZ3/X9hsLR1yfOaZwgrgkoPQ1hynKWCe0fweT3/uXfgzVZqaZAX+gVgoAQGztNd
         CmcXCFIrj9YP3f8zcwBsxgDv4qlGmjZnaL5x79LLyjIYhElNtyWzuYHZWqyM6zGsyALd
         oM137uPYZTjSG8cHnbv1/vhiD8aynxE89T3lz3nRgNezGr2xDrucRmyqnnA4ODtABtok
         hno4LW7j8/YzT9XcvlMcS8n6dLJ9bqJ7tzmm52MvpHaLF/L7Y1O3PAiC3zPGoduHyvdI
         JVDp56D5aDmI+99nhOcK9lsGFA6hrd742Cy5WkOz51ELl9EfF58iv3ak+7m94vcKDblr
         AhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319562; x=1695924362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5aeL1m05j80e9oN+xLZ02mKk3/iGVLqCptcDUWIcms=;
        b=ovM49d6nWpHgtkQQhXfHVk/zPzBYmqTcOTrW8nofQEUlB0+SVxhYb4eF7iw2vai+bC
         B9F+yBcYYj+3Y6wD4yaea9DrYLKO5/65Kl66khUcrkU/hK4UrEHxDOi9Vlou8Ah0s94m
         13L7gVdrHVZM8qLQlYJXozFyqnJJR6TbkyGcDaicxiCbcvRvbXkzfy1cqPGpBY2E8ddT
         JQflVsikaJQWfTgMN5skeXNM7L8lQCuqjeR8A9gRKr/gMhgiRL4sXxvsSOExnQnsWflm
         yACskBItbMhfPWTgQyjbAf54sl5XndetSmMEeptvq8SLeeUAe84yNtpZMUmU+/XWtBky
         Ff7A==
X-Gm-Message-State: AOJu0YxxFj49HwnEo/tBkUZL6g6ffN8yGHJ0dABAIkXvdhL6g97S2VcV
        7g3vOVwh5oqUSgZ3P7Y+aMVRMiY+KyWDv9AVKwgbtEK+
X-Google-Smtp-Source: AGHT+IFjNuOaLnHZLJ3fR+xF1yRtMBP8O4XMFMdJeKXbl6vddyCODioXw7GjWdGHIclBjkNV6I63+h/UTPRHiQtPx5g=
X-Received: by 2002:ad4:41ca:0:b0:64f:4e64:5962 with SMTP id
 a10-20020ad441ca000000b0064f4e645962mr5569416qvq.31.1695290198622; Thu, 21
 Sep 2023 02:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <ffe6a61a8879232aea7b86ff8aee5d681c6bd287.1695189879.git.wangchen20@iscas.ac.cn>
 <20230920-financial-declared-7b4b4baae517@wendy>
In-Reply-To: <20230920-financial-declared-7b4b4baae517@wendy>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Thu, 21 Sep 2023 17:56:28 +0800
Message-ID: <CAHAQgRBmUtyz-U+1Fu9qdvyhMuSzg+o4MMbTV9duUXsoSoPqUQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] riscv: dts: add initial SOPHGO SG2042 SoC device tree
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regards,

unicornx

Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=882=
0=E6=97=A5=E5=91=A8=E4=B8=89 16:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Yo,
>
> On Wed, Sep 20, 2023 at 02:40:32PM +0800, Chen Wang wrote:
> > Milk-V Pioneer motherboard is powered by SOPHON's SG2042.
> >
> > SG2042 is server grade chip with high performance, low power
> > consumption and high data throughput.
> > Key features:
> > - 64 RISC-V cpu cores which implements IMAFDC
>
> That's not quite true though, is it?

The cpu cores of SG2042 is c902 from T-HEAD, it supports vector, but
it's v0.7, not official v1.0. If we declare it as supporting
v-extension, the latest kernel(since 6.5) will issue rvv1.0
instructions during booting and make c902 crash. So we have to remove
"v" from the capability of ISA to pass the booting of machine. You can
check the "riscv,isa =3D "rv64imafdc";" in DTS.

>
> > - 4 cores per cluster, 16 clusters on chip
> > - ......
>
> What's a "....."? ;)
I just cited a description from TRM of SG2042 and it looks too long. I
will give a better description here and avoid using "......" in the
next revision.

>
> >
> > More info is available at [1].
> >
> > [1]: https://en.sophgo.com/product/introduce/sg2042.html
>
> Link: please.
>
> > Currently only support booting into console with only uart,
> > other features will be added soon later.
> >
> > Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com=
>
> > Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
>
> There are 4 sign-offs here. Surely some of these should be
> co-developed-bys?
>
> > +             cpu0: cpu@0 {
> > +                     compatible =3D "thead,c920", "riscv";
> > +                     device_type =3D "cpu";
> > +                     riscv,isa =3D "rv64imafdc";
>
> Please also add riscv,isa-base & riscv,isa-extensions.
>
> > +                     reg =3D <0>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <512>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <512>;
> > +                     next-level-cache =3D <&l2_cache0>;
> > +                     mmu-type =3D "riscv,sv39";
> > +
> > +                     cpu0_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <1>;
> > +                     };
> > +             };
>
> > diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/d=
ts/sophgo/sg2042.dtsi
> > new file mode 100644
> > index 000000000000..747fd9764c95
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > @@ -0,0 +1,439 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR MIT
>
> You should add () around the GPL-2.0 OR MIT.
>
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
>
> Why? What does this do? Where was it copied from?
>
It should be unnecessary=EF=BC=8C I will remove it in the next revision.

> > +
> > +/ {
> > +     compatible =3D "sophgo,sg2042";
> > +     #address-cells =3D <2>;
> > +     #size-cells =3D <2>;
> > +     dma-noncoherent;
> > +
> > +     aliases {
> > +             serial0 =3D &uart0;
> > +     };
> > +
> > +     /* the mem node will be updated by ZSBL. */
>
> huh? So these are random numbers below? Either put something useful here
> or delete it please.

The memory for SG2042 is not fixed, the bootloader will detect memory
installed on board during booting and fill the actual address and size
in the memory node. The comment " /* the mem node will be updated by
ZSBL. */" is telling this.
We write memory nodes like this to make them act just as placeholders
and the value is by default written as zero.


>
> > +     memory@0 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x00000000 0x00000000 0x00000000 0x00000000>;
> > +     };
> > +
> > +     memory@1 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x00000000 0x00000001 0x00000000 0x00000000>;
> > +     };
> > +
> > +     memory@2 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x00000000 0x00000002 0x00000000 0x00000000>;
> > +     };
> > +
> > +     memory@3 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x00000000 0x00000003 0x00000000 0x00000000>;
> > +     };
>
> > +     soc: soc {
> > +             compatible =3D "simple-bus";
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <2>;
> > +             ranges;
> > +
> > +             clint_mswi: interrupt-controller@7094000000 {
> > +                     compatible =3D "sophgo,sg2042-clint-mswi", "thead=
,c900-clint-mswi";
> > +                     reg =3D <0x00000070 0x94000000 0x00000000 0x00004=
000>;
>
> & nak to this without further explanation!
>
> Thanks,
> Conor.
>
