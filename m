Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71C37A8011
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjITMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjITMce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:32:34 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A08F93
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:32:23 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EFE123F687
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695213141;
        bh=m4FPyNvdvmlpYt/1ajOb9yCUgZkaoGUmg3Y31/Q4Vp0=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qfPkhg775bXL0vXM1FO732SyR2bATcCUHE7I+dYLQnbD3HoixEB2PYOTwcVJkyYjr
         rdldkacIFDjZ04+/Mdco2reVhHGBTD4ddP9YoVH3TUQayWfRA/LIrPyum76l1ruLPx
         raar+QG3Xt5QcRwEktm4CCQFObMd45m8tungnEkMbHR0LWiWieY64vI+5epLwZCyaU
         TmlAl7JFAX6UykLF8l7HDEAsi8zud8KZNhf9HIUciHmSj0eMzaTiZe2o3ZjBB1OAv3
         +TEu1XrQ1HIdN65TY4rxzwyXtpxoz5ky5L7Fbi7kpB6E0E94XpzE0+qEHtDEtMlg/C
         71B2M4aEUan1A==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-417b3a0bd09so36312951cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213139; x=1695817939;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m4FPyNvdvmlpYt/1ajOb9yCUgZkaoGUmg3Y31/Q4Vp0=;
        b=Efsf8J/Acdd5rNMoLgTdP5yqzYBueyHh0J3RjK4HBkK10EXPyLnzMFs59i4nA4MRH2
         jSoeyiKJioepbhqtaiKKpxyf+e3xdWFxzcvHpLK7ltnpxNCl3FBCoEzLc2+wwDbwYiIX
         iEREZJeCUK3uNknD+WvUyiS4xpbdOtUE1R5Q3s5HiI2ATfcvNqW5zMFLj/22Y0aLVszD
         m1hjzErtn5SzIl7D2n93B53v4R5av+R+PsqhsLArMfrNHEtO8bm0Y7lNh+7tocPcEYIi
         gDS/RW8NaPv7gPWtoI7B19xSB8TFBiSxRc8VhP9p+QmKP/TdFZ5Up1e+7BNV/RyHdk5k
         ZNEQ==
X-Gm-Message-State: AOJu0Yw08NGvRxYCde68hLcJYGlk8h1Hmj8/aRCr9iLDmV6W80PNmH60
        i2omgFqjhGrHTsdD/lmGgeiNiFh7rkc4x+qHENlBxoFnNIsUqU1OU75OB/y0okU9ScaHTwI9caA
        XDBxB4B/s0uSdJNbPSELU906EQl0VGFh9hhCxqdaEfeE1sVcCHWBQUWC41Q==
X-Received: by 2002:ac8:5e08:0:b0:417:d1e7:5e9b with SMTP id h8-20020ac85e08000000b00417d1e75e9bmr2269554qtx.26.1695213138436;
        Wed, 20 Sep 2023 05:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhJuW/GqPRmF3omRMfka12BFvL4nkplxo9DWm7XCV7SLk7o79RjeDQ7bmqGVCIkhYlydILJSXfFT91T8MeGxI=
X-Received: by 2002:ac8:5e08:0:b0:417:d1e7:5e9b with SMTP id
 h8-20020ac85e08000000b00417d1e75e9bmr2269513qtx.26.1695213137654; Wed, 20 Sep
 2023 05:32:17 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Sep 2023 05:32:17 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <389a43ee.298cc.18ab27f3440.Coremail.wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <ffe6a61a8879232aea7b86ff8aee5d681c6bd287.1695189879.git.wangchen20@iscas.ac.cn>
 <CAJM55Z-SYmGL-BjNi6EUKOrq34H=p1hRaRfkjGvBOqoKfacM1g@mail.gmail.com> <389a43ee.298cc.18ab27f3440.Coremail.wangchen20@iscas.ac.cn>
Mime-Version: 1.0
Date:   Wed, 20 Sep 2023 05:32:17 -0700
Message-ID: <CAJM55Z_zgk+MAjymrzbNJadzJAxZDtZgoZ_kAbcEMOyLuk4OcA@mail.gmail.com>
Subject: Re: Re: [PATCH v2 09/11] riscv: dts: add initial SOPHGO SG2042 SoC
 device tree
To:     =?UTF-8?B?5rGq6L6w?= <wangchen20@iscas.ac.cn>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        guoren@kernel.org, jszhang@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        xiaoguang.xing@sophgo.com, Inochi Amaoto <inochiama@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E6=B1=AA=E8=BE=B0 wrote:
>
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Emil Renner Berthing" <emil.renner.berthi=
ng@canonical.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023-09-20 19:32:19 (=E6=98=9F=E6=
=9C=9F=E4=B8=89)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Chen Wang" <unicornxw@gmail.com>, aou@eec=
s.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kern=
el.org, emil.renner.berthing@canonical.com, guoren@kernel.org, jszhang@kern=
el.org, krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, li=
nux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com=
, robh+dt@kernel.org, xiaoguang.xing@sophgo.com
> > =E6=8A=84=E9=80=81: "Chen Wang" <wangchen20@iscas.ac.cn>, "Inochi Amaot=
o" <inochiama@outlook.com>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v2 09/11] riscv: dts: add initial SOPHGO=
 SG2042 SoC device tree
> >
> > Chen Wang wrote:
> > > Milk-V Pioneer motherboard is powered by SOPHON's SG2042.
> >
> > Hi,
> >
> > I'm just wondering what is the relation between SOPHON and SOPHGO?
> > I think most of the content refers to the SoC as Sophgo SG2042 or SOPHG=
O
> > SG2042, but here you're using SOPHON.
>
> "SOPHGO" is the company name, "SOPHON" is the brand name. The whole name =
of SG2042 is "SOPHON SG2042".

Ah, so in this case (and next patch) it should be either "..powered by SOPH=
GO's
SG2042" or "..powered by the SOPHON SG2042", right?

>
> >
> > Also it would be great if you could decide if it's spelled SOPHGO or So=
phgo and
> > be consistent in all these patches.
>
> Thanks, I will double check this in next revision.
>
> >
> > /Emil
> >
> > >
> > > SG2042 is server grade chip with high performance, low power
> > > consumption and high data throughput.
> > > Key features:
> > > - 64 RISC-V cpu cores which implements IMAFDC
> > > - 4 cores per cluster, 16 clusters on chip
> > > - ......
> > >
> > > More info is available at [1].
> > >
> > > [1]: https://en.sophgo.com/product/introduce/sg2042.html
> > >
> > > Currently only support booting into console with only uart,
> > > other features will be added soon later.
> > >
> > > Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > > Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.c=
om>
> > > Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> > > ---
> > >  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 1744 +++++++++++++++++=
++
> > >  arch/riscv/boot/dts/sophgo/sg2042.dtsi      |  439 +++++
> > >  2 files changed, 2183 insertions(+)
> > >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> > >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > >
> > > diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv=
/boot/dts/sophgo/sg2042-cpus.dtsi
> > > new file mode 100644
> > > index 000000000000..9fc79b1cf3bf
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> > > @@ -0,0 +1,1744 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > > +/*
> > > + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> > > + */
> > > +
> > > +/ {
> > > +	cpus {
> > > +		#address-cells =3D <1>;
> > > +		#size-cells =3D <0>;
> > > +		timebase-frequency =3D <50000000>;
> > > +
> > > +		cpu-map {
> > > +			socket0 {
> > > +				cluster0 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu0>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu1>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu2>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu3>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster1 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu4>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu5>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu6>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu7>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster2 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu16>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu17>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu18>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu19>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster3 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu20>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu21>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu22>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu23>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster4 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu8>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu9>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu10>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu11>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster5 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu12>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu13>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu14>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu15>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster6 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu24>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu25>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu26>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu27>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster7 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu28>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu29>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu30>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu31>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster8 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu32>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu33>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu34>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu35>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster9 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu36>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu37>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu38>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu39>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster10 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu48>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu49>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu50>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu51>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster11 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu52>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu53>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu54>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu55>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster12 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu40>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu41>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu42>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu43>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster13 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu44>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu45>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu46>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu47>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster14 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu56>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu57>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu58>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu59>;
> > > +					 };
> > > +				};
> > > +
> > > +				cluster15 {
> > > +					 core0 {
> > > +						cpu =3D <&amp;cpu60>;
> > > +					 };
> > > +					 core1 {
> > > +						cpu =3D <&amp;cpu61>;
> > > +					 };
> > > +					 core2 {
> > > +						cpu =3D <&amp;cpu62>;
> > > +					 };
> > > +					 core3 {
> > > +						cpu =3D <&amp;cpu63>;
> > > +					 };
> > > +				};
> > > +			};
> > > +		};
> > > +
> > > +		cpu0: cpu@0 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <0>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache0>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu0_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu1: cpu@1 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <1>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache0>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu1_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu2: cpu@2 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <2>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache0>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu2_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu3: cpu@3 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <3>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache0>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu3_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu4: cpu@4 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <4>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache1>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu4_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu5: cpu@5 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <5>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache1>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu5_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu6: cpu@6 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <6>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache1>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu6_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu7: cpu@7 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <7>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache1>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu7_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu8: cpu@8 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <8>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache4>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu8_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu9: cpu@9 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <9>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache4>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu9_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu10: cpu@10 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <10>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache4>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu10_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu11: cpu@11 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <11>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache4>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu11_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu12: cpu@12 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <12>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache5>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu12_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu13: cpu@13 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <13>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache5>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu13_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu14: cpu@14 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <14>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache5>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu14_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu15: cpu@15 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <15>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache5>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu15_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu16: cpu@16 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <16>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache2>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu16_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu17: cpu@17 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <17>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache2>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu17_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu18: cpu@18 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <18>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache2>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu18_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu19: cpu@19 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <19>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache2>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu19_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu20: cpu@20 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <20>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache3>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu20_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu21: cpu@21 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <21>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache3>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu21_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu22: cpu@22 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <22>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache3>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu22_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu23: cpu@23 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <23>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache3>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu23_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu24: cpu@24 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <24>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache6>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu24_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu25: cpu@25 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <25>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache6>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu25_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu26: cpu@26 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <26>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache6>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu26_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu27: cpu@27 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <27>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache6>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu27_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu28: cpu@28 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <28>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache7>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu28_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu29: cpu@29 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <29>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache7>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu29_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu30: cpu@30 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <30>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache7>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu30_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu31: cpu@31 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <31>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache7>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu31_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu32: cpu@32 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <32>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache8>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu32_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu33: cpu@33 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <33>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache8>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu33_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu34: cpu@34 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <34>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache8>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu34_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu35: cpu@35 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <35>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache8>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu35_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu36: cpu@36 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <36>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache9>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu36_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu37: cpu@37 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <37>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache9>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu37_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu38: cpu@38 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <38>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache9>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu38_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu39: cpu@39 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <39>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache9>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu39_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu40: cpu@40 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <40>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache12>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu40_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu41: cpu@41 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <41>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache12>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu41_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu42: cpu@42 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <42>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache12>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu42_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu43: cpu@43 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <43>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache12>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu43_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu44: cpu@44 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <44>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache13>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu44_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu45: cpu@45 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <45>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache13>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu45_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu46: cpu@46 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <46>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache13>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu46_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu47: cpu@47 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <47>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache13>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu47_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu48: cpu@48 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <48>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache10>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu48_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu49: cpu@49 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <49>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache10>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu49_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu50: cpu@50 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <50>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache10>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu50_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu51: cpu@51 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <51>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache10>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu51_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu52: cpu@52 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <52>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache11>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu52_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu53: cpu@53 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <53>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache11>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu53_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu54: cpu@54 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <54>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache11>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu54_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu55: cpu@55 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <55>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache11>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu55_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu56: cpu@56 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <56>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache14>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu56_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu57: cpu@57 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <57>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache14>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu57_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu58: cpu@58 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <58>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache14>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu58_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu59: cpu@59 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <59>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache14>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu59_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu60: cpu@60 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <60>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache15>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu60_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu61: cpu@61 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <61>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache15>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu61_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu62: cpu@62 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <62>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache15>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu62_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		cpu63: cpu@63 {
> > > +			compatible =3D "thead,c920", "riscv";
> > > +			device_type =3D "cpu";
> > > +			riscv,isa =3D "rv64imafdc";
> > > +			reg =3D <63>;
> > > +			i-cache-block-size =3D <64>;
> > > +			i-cache-size =3D <65536>;
> > > +			i-cache-sets =3D <512>;
> > > +			d-cache-block-size =3D <64>;
> > > +			d-cache-size =3D <65536>;
> > > +			d-cache-sets =3D <512>;
> > > +			next-level-cache =3D <&amp;l2_cache15>;
> > > +			mmu-type =3D "riscv,sv39";
> > > +
> > > +			cpu63_intc: interrupt-controller {
> > > +				compatible =3D "riscv,cpu-intc";
> > > +				interrupt-controller;
> > > +				#interrupt-cells =3D <1>;
> > > +			};
> > > +		};
> > > +
> > > +		l2_cache0: l2-cache@0 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache1: l2-cache@1 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache2: l2-cache@2 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache3: l2-cache@3 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache4: l2-cache@4 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache5: l2-cache@5 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache6: l2-cache@6 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache7: l2-cache@7 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache8: l2-cache@8 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache9: l2-cache@9 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache10: l2-cache@10 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache11: l2-cache@11 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache12: l2-cache@12 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache13: l2-cache@13 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache14: l2-cache@14 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +
> > > +		l2_cache15: l2-cache@15 {
> > > +			compatible =3D "cache";
> > > +			cache-block-size =3D <64>;
> > > +			cache-level =3D <2>;
> > > +			cache-size =3D <1048576>;
> > > +			cache-sets =3D <1024>;
> > > +			cache-unified;
> > > +		};
> > > +	};
> > > +};
> > > diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot=
/dts/sophgo/sg2042.dtsi
> > > new file mode 100644
> > > index 000000000000..747fd9764c95
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > > @@ -0,0 +1,439 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > > +/*
> > > + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include <dt-bindings interrupt-controller=3D"" irq.h=3D"">
> > > +
> > > +#include "sg2042-cpus.dtsi"
> > > +
> > > +#define SOC_PERIPHERAL_IRQ(nr) (nr)
> > > +
> > > +/ {
> > > +	compatible =3D "sophgo,sg2042";
> > > +	#address-cells =3D <2>;
> > > +	#size-cells =3D <2>;
> > > +	dma-noncoherent;
> > > +
> > > +	aliases {
> > > +		serial0 =3D &amp;uart0;
> > > +	};
> > > +
> > > +	/* the mem node will be updated by ZSBL. */
> > > +	memory@0 {
> > > +		device_type =3D "memory";
> > > +		reg =3D <0x00000000 0x00000000 0x00000000 0x00000000>;
> > > +	};
> > > +
> > > +	memory@1 {
> > > +		device_type =3D "memory";
> > > +		reg =3D <0x00000000 0x00000001 0x00000000 0x00000000>;
> > > +	};
> > > +
> > > +	memory@2 {
> > > +		device_type =3D "memory";
> > > +		reg =3D <0x00000000 0x00000002 0x00000000 0x00000000>;
> > > +	};
> > > +
> > > +	memory@3 {
> > > +		device_type =3D "memory";
> > > +		reg =3D <0x00000000 0x00000003 0x00000000 0x00000000>;
> > > +	};
> > > +
> > > +	pmu {
> > > +		compatible =3D "riscv,pmu";
> > > +		riscv,event-to-mhpmevent =3D
> > > +			<0x00003 0x00000000 0x00000010>,
> > > +			<0x00004 0x00000000 0x00000011>,
> > > +			<0x00005 0x00000000 0x00000007>,
> > > +			<0x00006 0x00000000 0x00000006>,
> > > +			<0x00008 0x00000000 0x00000027>,
> > > +			<0x00009 0x00000000 0x00000028>,
> > > +			<0x10000 0x00000000 0x0000000c>,
> > > +			<0x10001 0x00000000 0x0000000d>,
> > > +			<0x10002 0x00000000 0x0000000e>,
> > > +			<0x10003 0x00000000 0x0000000f>,
> > > +			<0x10008 0x00000000 0x00000001>,
> > > +			<0x10009 0x00000000 0x00000002>,
> > > +			<0x10010 0x00000000 0x00000010>,
> > > +			<0x10011 0x00000000 0x00000011>,
> > > +			<0x10012 0x00000000 0x00000012>,
> > > +			<0x10013 0x00000000 0x00000013>,
> > > +			<0x10019 0x00000000 0x00000004>,
> > > +			<0x10021 0x00000000 0x00000003>,
> > > +			<0x10030 0x00000000 0x0000001c>,
> > > +			<0x10031 0x00000000 0x0000001b>;
> > > +		riscv,event-to-mhpmcounters =3D
> > > +			<0x00003 0x00003 0xfffffff8>,
> > > +			<0x00004 0x00004 0xfffffff8>,
> > > +			<0x00005 0x00005 0xfffffff8>,
> > > +			<0x00006 0x00006 0xfffffff8>,
> > > +			<0x00007 0x00007 0xfffffff8>,
> > > +			<0x00008 0x00008 0xfffffff8>,
> > > +			<0x00009 0x00009 0xfffffff8>,
> > > +			<0x0000a 0x0000a 0xfffffff8>,
> > > +			<0x10000 0x10000 0xfffffff8>,
> > > +			<0x10001 0x10001 0xfffffff8>,
> > > +			<0x10002 0x10002 0xfffffff8>,
> > > +			<0x10003 0x10003 0xfffffff8>,
> > > +			<0x10008 0x10008 0xfffffff8>,
> > > +			<0x10009 0x10009 0xfffffff8>,
> > > +			<0x10010 0x10010 0xfffffff8>,
> > > +			<0x10011 0x10011 0xfffffff8>,
> > > +			<0x10012 0x10012 0xfffffff8>,
> > > +			<0x10013 0x10013 0xfffffff8>,
> > > +			<0x10019 0x10019 0xfffffff8>,
> > > +			<0x10021 0x10021 0xfffffff8>,
> > > +			<0x10030 0x10030 0xfffffff8>,
> > > +			<0x10031 0x10031 0xfffffff8>;
> > > +		riscv,raw-event-to-mhpmcounters =3D
> > > +			<0x00000000 0x00000001 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000002 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000003 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000004 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000005 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000006 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000007 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000008 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000009 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000000a 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000000b 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000000c 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000000d 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000000e 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000010 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000011 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000012 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000013 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000014 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000015 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000016 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000017 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000018 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000019 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000001a 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000001b 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000001c 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000001d 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000001e 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000001f 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000020 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000021 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000022 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000023 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000024 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000025 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000026 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000027 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000028 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x00000029 0xffffffff 0xffffffff 0xfffffff8>,
> > > +			<0x00000000 0x0000002a 0xffffffff 0xffffffff 0xfffffff8>;
> > > +	};
> > > +
> > > +	soc: soc {
> > > +		compatible =3D "simple-bus";
> > > +		#address-cells =3D <2>;
> > > +		#size-cells =3D <2>;
> > > +		ranges;
> > > +
> > > +		clint_mswi: interrupt-controller@7094000000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mswi", "thead,c900-clint-mswi=
";
> > > +			reg =3D <0x00000070 0x94000000 0x00000000 0x00004000>;
> > > +			interrupts-extended =3D <&amp;cpu0_intc 3>,
> > > +					      <&amp;cpu1_intc 3>,
> > > +					      <&amp;cpu2_intc 3>,
> > > +					      <&amp;cpu3_intc 3>,
> > > +					      <&amp;cpu4_intc 3>,
> > > +					      <&amp;cpu5_intc 3>,
> > > +					      <&amp;cpu6_intc 3>,
> > > +					      <&amp;cpu7_intc 3>,
> > > +					      <&amp;cpu8_intc 3>,
> > > +					      <&amp;cpu9_intc 3>,
> > > +					      <&amp;cpu10_intc 3>,
> > > +					      <&amp;cpu11_intc 3>,
> > > +					      <&amp;cpu12_intc 3>,
> > > +					      <&amp;cpu13_intc 3>,
> > > +					      <&amp;cpu14_intc 3>,
> > > +					      <&amp;cpu15_intc 3>,
> > > +					      <&amp;cpu16_intc 3>,
> > > +					      <&amp;cpu17_intc 3>,
> > > +					      <&amp;cpu18_intc 3>,
> > > +					      <&amp;cpu19_intc 3>,
> > > +					      <&amp;cpu20_intc 3>,
> > > +					      <&amp;cpu21_intc 3>,
> > > +					      <&amp;cpu22_intc 3>,
> > > +					      <&amp;cpu23_intc 3>,
> > > +					      <&amp;cpu24_intc 3>,
> > > +					      <&amp;cpu25_intc 3>,
> > > +					      <&amp;cpu26_intc 3>,
> > > +					      <&amp;cpu27_intc 3>,
> > > +					      <&amp;cpu28_intc 3>,
> > > +					      <&amp;cpu29_intc 3>,
> > > +					      <&amp;cpu30_intc 3>,
> > > +					      <&amp;cpu31_intc 3>,
> > > +					      <&amp;cpu32_intc 3>,
> > > +					      <&amp;cpu33_intc 3>,
> > > +					      <&amp;cpu34_intc 3>,
> > > +					      <&amp;cpu35_intc 3>,
> > > +					      <&amp;cpu36_intc 3>,
> > > +					      <&amp;cpu37_intc 3>,
> > > +					      <&amp;cpu38_intc 3>,
> > > +					      <&amp;cpu39_intc 3>,
> > > +					      <&amp;cpu40_intc 3>,
> > > +					      <&amp;cpu41_intc 3>,
> > > +					      <&amp;cpu42_intc 3>,
> > > +					      <&amp;cpu43_intc 3>,
> > > +					      <&amp;cpu44_intc 3>,
> > > +					      <&amp;cpu45_intc 3>,
> > > +					      <&amp;cpu46_intc 3>,
> > > +					      <&amp;cpu47_intc 3>,
> > > +					      <&amp;cpu48_intc 3>,
> > > +					      <&amp;cpu49_intc 3>,
> > > +					      <&amp;cpu50_intc 3>,
> > > +					      <&amp;cpu51_intc 3>,
> > > +					      <&amp;cpu52_intc 3>,
> > > +					      <&amp;cpu53_intc 3>,
> > > +					      <&amp;cpu54_intc 3>,
> > > +					      <&amp;cpu55_intc 3>,
> > > +					      <&amp;cpu56_intc 3>,
> > > +					      <&amp;cpu57_intc 3>,
> > > +					      <&amp;cpu58_intc 3>,
> > > +					      <&amp;cpu59_intc 3>,
> > > +					      <&amp;cpu60_intc 3>,
> > > +					      <&amp;cpu61_intc 3>,
> > > +					      <&amp;cpu62_intc 3>,
> > > +					      <&amp;cpu63_intc 3>;
> > > +		};
> > > +
> > > +		clint_mtimer0: timer@70ac000000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac000000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu0_intc 7>,
> > > +					      <&amp;cpu1_intc 7>,
> > > +					      <&amp;cpu2_intc 7>,
> > > +					      <&amp;cpu3_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer1: timer@70ac010000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac010000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu4_intc 7>,
> > > +					      <&amp;cpu5_intc 7>,
> > > +					      <&amp;cpu6_intc 7>,
> > > +					      <&amp;cpu7_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer2: timer@70ac020000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac020000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu8_intc 7>,
> > > +					      <&amp;cpu9_intc 7>,
> > > +					      <&amp;cpu10_intc 7>,
> > > +					      <&amp;cpu11_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer3: timer@70ac030000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac030000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu12_intc 7>,
> > > +					      <&amp;cpu13_intc 7>,
> > > +					      <&amp;cpu14_intc 7>,
> > > +					      <&amp;cpu15_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer4: timer@70ac040000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac040000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu16_intc 7>,
> > > +					      <&amp;cpu17_intc 7>,
> > > +					      <&amp;cpu18_intc 7>,
> > > +					      <&amp;cpu19_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer5: timer@70ac050000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac050000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu20_intc 7>,
> > > +					      <&amp;cpu21_intc 7>,
> > > +					      <&amp;cpu22_intc 7>,
> > > +					      <&amp;cpu23_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer6: timer@70ac060000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac060000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu24_intc 7>,
> > > +					      <&amp;cpu25_intc 7>,
> > > +					      <&amp;cpu26_intc 7>,
> > > +					      <&amp;cpu27_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer7: timer@70ac070000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac070000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu28_intc 7>,
> > > +					      <&amp;cpu29_intc 7>,
> > > +					      <&amp;cpu30_intc 7>,
> > > +					      <&amp;cpu31_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer8: timer@70ac080000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac080000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu32_intc 7>,
> > > +					      <&amp;cpu33_intc 7>,
> > > +					      <&amp;cpu34_intc 7>,
> > > +					      <&amp;cpu35_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer9: timer@70ac090000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac090000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu36_intc 7>,
> > > +					      <&amp;cpu37_intc 7>,
> > > +					      <&amp;cpu38_intc 7>,
> > > +					      <&amp;cpu39_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer10: timer@70ac0a0000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac0a0000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu40_intc 7>,
> > > +					      <&amp;cpu41_intc 7>,
> > > +					      <&amp;cpu42_intc 7>,
> > > +					      <&amp;cpu43_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer11: timer@70ac0b0000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac0b0000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu44_intc 7>,
> > > +					      <&amp;cpu45_intc 7>,
> > > +					      <&amp;cpu46_intc 7>,
> > > +					      <&amp;cpu47_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer12: timer@70ac0c0000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac0c0000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu48_intc 7>,
> > > +					      <&amp;cpu49_intc 7>,
> > > +					      <&amp;cpu50_intc 7>,
> > > +					      <&amp;cpu51_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer13: timer@70ac0d0000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac0d0000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu52_intc 7>,
> > > +					      <&amp;cpu53_intc 7>,
> > > +					      <&amp;cpu54_intc 7>,
> > > +					      <&amp;cpu55_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer14: timer@70ac0e0000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac0e0000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu56_intc 7>,
> > > +					      <&amp;cpu57_intc 7>,
> > > +					      <&amp;cpu58_intc 7>,
> > > +					      <&amp;cpu59_intc 7>;
> > > +		};
> > > +
> > > +		clint_mtimer15: timer@70ac0f0000 {
> > > +			compatible =3D "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mt=
imer";
> > > +			reg =3D <0x00000070 0xac0f0000 0x00000000 0x00007ff8>;
> > > +			interrupts-extended =3D <&amp;cpu60_intc 7>,
> > > +					      <&amp;cpu61_intc 7>,
> > > +					      <&amp;cpu62_intc 7>,
> > > +					      <&amp;cpu63_intc 7>;
> > > +		};
> > > +
> > > +		intc: interrupt-controller@7090000000 {
> > > +			compatible =3D "sophgo,sg2042-plic", "thead,c900-plic";
> > > +			#address-cells =3D <0>;
> > > +			#interrupt-cells =3D <2>;
> > > +			reg =3D <0x00000070 0x90000000 0x00000000 0x04000000>;
> > > +			interrupt-controller;
> > > +			interrupts-extended =3D
> > > +				<&amp;cpu0_intc 0xffffffff>,  <&amp;cpu0_intc 9>,
> > > +				<&amp;cpu1_intc 0xffffffff>,  <&amp;cpu1_intc 9>,
> > > +				<&amp;cpu2_intc 0xffffffff>,  <&amp;cpu2_intc 9>,
> > > +				<&amp;cpu3_intc 0xffffffff>,  <&amp;cpu3_intc 9>,
> > > +				<&amp;cpu4_intc 0xffffffff>,  <&amp;cpu4_intc 9>,
> > > +				<&amp;cpu5_intc 0xffffffff>,  <&amp;cpu5_intc 9>,
> > > +				<&amp;cpu6_intc 0xffffffff>,  <&amp;cpu6_intc 9>,
> > > +				<&amp;cpu7_intc 0xffffffff>,  <&amp;cpu7_intc 9>,
> > > +				<&amp;cpu8_intc 0xffffffff>,  <&amp;cpu8_intc 9>,
> > > +				<&amp;cpu9_intc 0xffffffff>,  <&amp;cpu9_intc 9>,
> > > +				<&amp;cpu10_intc 0xffffffff>, <&amp;cpu10_intc 9>,
> > > +				<&amp;cpu11_intc 0xffffffff>, <&amp;cpu11_intc 9>,
> > > +				<&amp;cpu12_intc 0xffffffff>, <&amp;cpu12_intc 9>,
> > > +				<&amp;cpu13_intc 0xffffffff>, <&amp;cpu13_intc 9>,
> > > +				<&amp;cpu14_intc 0xffffffff>, <&amp;cpu14_intc 9>,
> > > +				<&amp;cpu15_intc 0xffffffff>, <&amp;cpu15_intc 9>,
> > > +				<&amp;cpu16_intc 0xffffffff>, <&amp;cpu16_intc 9>,
> > > +				<&amp;cpu17_intc 0xffffffff>, <&amp;cpu17_intc 9>,
> > > +				<&amp;cpu18_intc 0xffffffff>, <&amp;cpu18_intc 9>,
> > > +				<&amp;cpu19_intc 0xffffffff>, <&amp;cpu19_intc 9>,
> > > +				<&amp;cpu20_intc 0xffffffff>, <&amp;cpu20_intc 9>,
> > > +				<&amp;cpu21_intc 0xffffffff>, <&amp;cpu21_intc 9>,
> > > +				<&amp;cpu22_intc 0xffffffff>, <&amp;cpu22_intc 9>,
> > > +				<&amp;cpu23_intc 0xffffffff>, <&amp;cpu23_intc 9>,
> > > +				<&amp;cpu24_intc 0xffffffff>, <&amp;cpu24_intc 9>,
> > > +				<&amp;cpu25_intc 0xffffffff>, <&amp;cpu25_intc 9>,
> > > +				<&amp;cpu26_intc 0xffffffff>, <&amp;cpu26_intc 9>,
> > > +				<&amp;cpu27_intc 0xffffffff>, <&amp;cpu27_intc 9>,
> > > +				<&amp;cpu28_intc 0xffffffff>, <&amp;cpu28_intc 9>,
> > > +				<&amp;cpu29_intc 0xffffffff>, <&amp;cpu29_intc 9>,
> > > +				<&amp;cpu30_intc 0xffffffff>, <&amp;cpu30_intc 9>,
> > > +				<&amp;cpu31_intc 0xffffffff>, <&amp;cpu31_intc 9>,
> > > +				<&amp;cpu32_intc 0xffffffff>, <&amp;cpu32_intc 9>,
> > > +				<&amp;cpu33_intc 0xffffffff>, <&amp;cpu33_intc 9>,
> > > +				<&amp;cpu34_intc 0xffffffff>, <&amp;cpu34_intc 9>,
> > > +				<&amp;cpu35_intc 0xffffffff>, <&amp;cpu35_intc 9>,
> > > +				<&amp;cpu36_intc 0xffffffff>, <&amp;cpu36_intc 9>,
> > > +				<&amp;cpu37_intc 0xffffffff>, <&amp;cpu37_intc 9>,
> > > +				<&amp;cpu38_intc 0xffffffff>, <&amp;cpu38_intc 9>,
> > > +				<&amp;cpu39_intc 0xffffffff>, <&amp;cpu39_intc 9>,
> > > +				<&amp;cpu40_intc 0xffffffff>, <&amp;cpu40_intc 9>,
> > > +				<&amp;cpu41_intc 0xffffffff>, <&amp;cpu41_intc 9>,
> > > +				<&amp;cpu42_intc 0xffffffff>, <&amp;cpu42_intc 9>,
> > > +				<&amp;cpu43_intc 0xffffffff>, <&amp;cpu43_intc 9>,
> > > +				<&amp;cpu44_intc 0xffffffff>, <&amp;cpu44_intc 9>,
> > > +				<&amp;cpu45_intc 0xffffffff>, <&amp;cpu45_intc 9>,
> > > +				<&amp;cpu46_intc 0xffffffff>, <&amp;cpu46_intc 9>,
> > > +				<&amp;cpu47_intc 0xffffffff>, <&amp;cpu47_intc 9>,
> > > +				<&amp;cpu48_intc 0xffffffff>, <&amp;cpu48_intc 9>,
> > > +				<&amp;cpu49_intc 0xffffffff>, <&amp;cpu49_intc 9>,
> > > +				<&amp;cpu50_intc 0xffffffff>, <&amp;cpu50_intc 9>,
> > > +				<&amp;cpu51_intc 0xffffffff>, <&amp;cpu51_intc 9>,
> > > +				<&amp;cpu52_intc 0xffffffff>, <&amp;cpu52_intc 9>,
> > > +				<&amp;cpu53_intc 0xffffffff>, <&amp;cpu53_intc 9>,
> > > +				<&amp;cpu54_intc 0xffffffff>, <&amp;cpu54_intc 9>,
> > > +				<&amp;cpu55_intc 0xffffffff>, <&amp;cpu55_intc 9>,
> > > +				<&amp;cpu56_intc 0xffffffff>, <&amp;cpu56_intc 9>,
> > > +				<&amp;cpu57_intc 0xffffffff>, <&amp;cpu57_intc 9>,
> > > +				<&amp;cpu58_intc 0xffffffff>, <&amp;cpu58_intc 9>,
> > > +				<&amp;cpu59_intc 0xffffffff>, <&amp;cpu59_intc 9>,
> > > +				<&amp;cpu60_intc 0xffffffff>, <&amp;cpu60_intc 9>,
> > > +				<&amp;cpu61_intc 0xffffffff>, <&amp;cpu61_intc 9>,
> > > +				<&amp;cpu62_intc 0xffffffff>, <&amp;cpu62_intc 9>,
> > > +				<&amp;cpu63_intc 0xffffffff>, <&amp;cpu63_intc 9>;
> > > +			riscv,ndev =3D <224>;
> > > +		};
> > > +
> > > +		uart0: serial@7040000000 {
> > > +			compatible =3D "sophgo,sg2042-uart", "snps,dw-apb-uart";
> > > +			reg =3D <0x00000070 0x40000000 0x00000000 0x00001000>;
> > > +			interrupt-parent =3D <&amp;intc>;
> > > +			interrupts =3D <soc_peripheral_irq(112) irq_type_level_high=3D"">=
;
> > > +			clock-frequency =3D <500000000>;
> > > +			reg-shift =3D <2>;
> > > +			reg-io-width =3D <4>;
> > > +			status =3D "disabled";
> > > +		};
> > > +	};
> > > +};
> > > --
> > > 2.25.1
>
>
> ------------------------------
>
> Best Regards
>
>  =E6=B1=AA=E8=BE=B0(Wang Chen)
>
> </soc_peripheral_irq(112)></dt-bindings></wangchen20@iscas.ac.cn></emil.r=
enner.berthing@canonical.com></inochiama@outlook.com></xiaoguang.xing@sophg=
o.com></xiaoguang.xing@sophgo.com></inochiama@outlook.com></wangchen20@isca=
s.ac.cn></unicornxw@gmail.com></emil.renner.berthing@canonical.com>
