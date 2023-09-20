Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F377A7540
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjITIFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjITIFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:05:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAEC97
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:05:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F01C433C7;
        Wed, 20 Sep 2023 08:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695197135;
        bh=4z5ocVO20kmwYYtIcTCNJGr7rb3Lqyayq1Zc4dQto/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KSDwx1ppRPVtSLYT8nXbEoPMBbj8Eege4himYGREzIF+3qgL2TR4tUcQcWso0RR/D
         ibCDHH9tFJgTa9gOrpnH0uiLftIyHfzQc6lPuYJohTys85YB/r2o9hv1UuCNoUp0Di
         9e0rIZWLkfoen9LXSdwc4YUAKfpFchAZpyAgl8xecROwToPu2T7ekncSZAoMAqFQNt
         +T3LWeQUKvZuo9yKV5eQr8Qf752TWS4b1ofvSa+i5Vr2Y5mUVtGAM/olAvQul0KCo+
         qjRI6cV+Tvgu6uFVDhRnVjS4NPUioY0frO/KboY4vAghbPsoL6LyjOSuDy+CNjypW9
         qr/TIu/bzQQuw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2bffc55af02so53709001fa.2;
        Wed, 20 Sep 2023 01:05:35 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz4dyJNcm3hUH0sjm0KUyozehpiUmFL8dyxXnUtwaqj3QwYNola
        bUr+2idptJDhwbmWfHvX0DGfh1uPddQWc9oBcPA=
X-Google-Smtp-Source: AGHT+IFQCEdz0BmFYbfJmUDySjWk4q+NyrOTm1esI+1FfKMftbTBYe3qHzQwq/RGrzgW/l5edoUq7BFYp8iN2AGMODw=
X-Received: by 2002:a2e:9006:0:b0:2c0:21b6:e82e with SMTP id
 h6-20020a2e9006000000b002c021b6e82emr1472090ljg.4.1695197133713; Wed, 20 Sep
 2023 01:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <e9ff83e4fac9a9ebd217ef10e5f8d3260342102b.1695189879.git.wangchen20@iscas.ac.cn>
In-Reply-To: <e9ff83e4fac9a9ebd217ef10e5f8d3260342102b.1695189879.git.wangchen20@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Sep 2023 16:05:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTsCT0sBN1Qi28f-G7n+KuUe0Ny0+4rHWoND67b2wswSg@mail.gmail.com>
Message-ID: <CAJF2gTTsCT0sBN1Qi28f-G7n+KuUe0Ny0+4rHWoND67b2wswSg@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] riscv: dts: sophgo: add Milk-V Pioneer board
 device tree
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 2:41=E2=80=AFPM Chen Wang <unicornxw@gmail.com> wro=
te:
>
> Milk-V Pioneer [1] is a developer motherboard based on SOPHON
> SG2042 in a standard mATX form factor. It is a good
> choice for RISC-V developers and hardware pioneers to
> experience the cutting edge technology of RISC-V.
>
> Currently only support booting into console with only uart
> enabled, other features will be added soon later.
>
> [1]: https://milkv.io/pioneer
>
> Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  arch/riscv/boot/dts/Makefile                  |  1 +
>  arch/riscv/boot/dts/sophgo/Makefile           |  3 +++
>  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 19 +++++++++++++++++++
>  3 files changed, 23 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
>
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index f60a280abb15..94788486f13e 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -6,5 +6,6 @@ subdir-y +=3D renesas
>  subdir-y +=3D sifive
>  subdir-y +=3D starfive
>  subdir-y +=3D thead
> +subdir-y +=3D sophgo
>
>  obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/so=
phgo/Makefile
> new file mode 100644
> index 000000000000..5a471b19df22
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_SOPHGO) +=3D sg2042-milkv-pioneer.dtb
> +
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/r=
iscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> new file mode 100644
> index 000000000000..d6e8c0285d1e
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +#include "sg2042.dtsi"
> +
> +/ {
> +       model =3D "Milk-V Pioneer";
> +       compatible =3D "milkv,pioneer", "sophgo,sg2042";
> +
> +       chosen: chosen {
> +               stdout-path =3D "serial0";
> +       };
> +};
> +
> +&uart0 {
> +       status =3D "okay";
> +};
> --
> 2.25.1
>
LGTM

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
