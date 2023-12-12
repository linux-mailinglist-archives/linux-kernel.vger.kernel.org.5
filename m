Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5CF80E996
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjLLLBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLLLBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:01:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C971BA0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:01:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E27FC433C8;
        Tue, 12 Dec 2023 11:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702378884;
        bh=TWul6GuP3ycEIwRJUResXs9+3GenDabzL0eL29/CcCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VeG986QmrBs4P56OQbmiouuIxjTdLUCmVXD0pAd5DDdNpLFrEUYHiZtipRN807gKR
         B2a21lFbQ01kTSQrhlhvJTxluW9oiyFC/kB+ugPcZBuMzG2KjjWQ4W5+rU8YSsL76c
         I16GJRVRxzYz8f/UqKgaPpKPTOX1/8InUEkli5pJpFEshpZSWVpnIVsqHcs+iTf/cg
         kh+RUZw8rmcb8lNy2Rl9qPx9cJ3jwr6GXumBdaDXo+kKQwH1HwaMiDjhm5ufjQjK6F
         nWh9wR7Gx7AG6J2qL68R070S/Ko42idK8VXLuRgE2GYPjVEe3RCHUZwZCAa5LhsvWa
         rHaekG0QVFEZA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1fb13a0951bso2073897fac.3;
        Tue, 12 Dec 2023 03:01:24 -0800 (PST)
X-Gm-Message-State: AOJu0YzBORF4cprOOPw23HDO0WhWoSW9kIBX4BCo6jQF26u0P8lIfqDz
        Rh4SvRol+X0hI9JA7pVd/OvgisECO/kLQRWu5JY=
X-Google-Smtp-Source: AGHT+IGIj5IpolEdigDfY5x2sEukESTV5hAANNVX7b5VXeJyIBI0ZHO/jlwzjPY/tHFbdUGmbfXfnar89Csv/thR1Wo=
X-Received: by 2002:a05:6870:7251:b0:1fb:75b:2bb7 with SMTP id
 y17-20020a056870725100b001fb075b2bb7mr3371296oaf.115.1702378883769; Tue, 12
 Dec 2023 03:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20230911214751.2202913-1-robh@kernel.org> <2eaa2e1d-b6cf-4032-af28-5e8f6428e95f@amd.com>
 <CAL_JsqLUKyNU7vrYhVzdTKKExXN8-Dyy8cEFd6PNW=b03VDOvg@mail.gmail.com> <6410439d-cc02-408f-bc8e-3d8e808b8e47@amd.com>
In-Reply-To: <6410439d-cc02-408f-bc8e-3d8e808b8e47@amd.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 Dec 2023 20:00:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQr09+ei2mBkMBDEFOyx1kx70RScjsh1v-XaKGmDG8RgA@mail.gmail.com>
Message-ID: <CAK7LNAQr09+ei2mBkMBDEFOyx1kx70RScjsh1v-XaKGmDG8RgA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: xilinx: Apply overlays to base dtbs
To:     Michal Simek <michal.simek@amd.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:01=E2=80=AFPM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 11/29/23 17:13, Rob Herring wrote:
> > On Mon, Sep 18, 2023 at 5:56=E2=80=AFAM Michal Simek <michal.simek@amd.=
com> wrote:
> >>
> >>
> >>
> >> On 9/11/23 23:47, Rob Herring wrote:
> >>> DT overlays in tree need to be applied to a base DTB to validate they
> >>> apply, to run schema checks on them, and to catch any errors at compi=
le
> >>> time. Defining the "-dtbs" variable is not enough as the combined DT =
must
> >>> be added to dtbs-y.
> >>>
> >>> zynqmp-sck-kr-g-revA.dtso and zynqmp-sck-kr-g-revB.dtso don't exist, =
so drop
> >>> them.
> >>>
> >>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>> ---
> >>>    arch/arm64/boot/dts/xilinx/Makefile | 9 ++++-----
> >>>    1 file changed, 4 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dt=
s/xilinx/Makefile
> >>> index 5e40c0b4fa0a..1068b0fa8e98 100644
> >>> --- a/arch/arm64/boot/dts/xilinx/Makefile
> >>> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> >>> @@ -22,11 +22,10 @@ dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-sm-k26-revA=
.dtb
> >>>    dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-smk-k26-revA.dtb
> >>>
> >>>    zynqmp-sm-k26-revA-sck-kv-g-revA-dtbs :=3D zynqmp-sm-k26-revA.dtb =
zynqmp-sck-kv-g-revA.dtbo
> >>> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-sm-k26-revA-sck-kv-g-revA.dtb
> >>>    zynqmp-sm-k26-revA-sck-kv-g-revB-dtbs :=3D zynqmp-sm-k26-revA.dtb =
zynqmp-sck-kv-g-revB.dtbo
> >>> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-sm-k26-revA-sck-kv-g-revB.dtb
> >>>    zynqmp-smk-k26-revA-sck-kv-g-revA-dtbs :=3D zynqmp-smk-k26-revA.dt=
b zynqmp-sck-kv-g-revA.dtbo
> >>> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-smk-k26-revA-sck-kv-g-revA.dtb
> >>>    zynqmp-smk-k26-revA-sck-kv-g-revB-dtbs :=3D zynqmp-smk-k26-revA.dt=
b zynqmp-sck-kv-g-revB.dtbo
> >>> -
> >>> -zynqmp-sm-k26-revA-sck-kr-g-revA-dtbs :=3D zynqmp-sm-k26-revA.dtb zy=
nqmp-sck-kr-g-revA.dtbo
> >>> -zynqmp-sm-k26-revA-sck-kr-g-revB-dtbs :=3D zynqmp-sm-k26-revA.dtb zy=
nqmp-sck-kr-g-revB.dtbo
> >>> -zynqmp-smk-k26-revA-sck-kr-g-revA-dtbs :=3D zynqmp-smk-k26-revA.dtb =
zynqmp-sck-kr-g-revA.dtbo
> >>> -zynqmp-smk-k26-revA-sck-kr-g-revB-dtbs :=3D zynqmp-smk-k26-revA.dtb =
zynqmp-sck-kr-g-revB.dtbo
> >>> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-smk-k26-revA-sck-kv-g-revB.dtb
> >>
> >> Applied.
> >
> > Why is this in next still, but not in Linus' tree?
>
> I was OOO and didn't send pull request to Arnd. I will do it for 6.8. It =
means
> in 2-3 weeks from now.
>
> Thanks,
> Michal
>


This is a regression by 45fe0dc4ea2e.



Fixes: 45fe0dc4ea2e ("arm64: xilinx: Use zynqmp prefix for SOM dt overlays"=
)


is suitable.






--=20
Best Regards
Masahiro Yamada
