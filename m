Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122897BA3ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbjJEQAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjJEP5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:57:43 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FBA4695;
        Thu,  5 Oct 2023 08:17:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EE6BE0010;
        Thu,  5 Oct 2023 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696519067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvH8TojWLX5PBOVWWWtrIYBix9PjUxHjvbmCvPQRWkE=;
        b=iuj2Hf/o0T6P92uvZ0fWwcbUtAvIpStnI6H/7KBQEoGLMSa1VL4jOjF+/UvE1MfEYUy/CW
        77vDVJjOyLBExgbxDHtiDz84KzSrxp3OnDH+RvgMWW+PaKOR0N+Sjkdqcu+LDW2WeSyKBh
        bF2Z1+LMcDuCzLOuc9adjddmWhISxGvg3ZxBXv0r72M42BjJrjumsUd+hiXqfC5FJe+nyP
        XBviODz8fWkbFSsvFRLMsF1gul/fpCcTg8JKUzTmPzq++AkUeUwpynPlDGhFJ28rZKMIwJ
        AvUgu8nqDCysAe5zC98Kc/DYZ0G255+S9tRU5m/hfK5DZ5tT849KxdSphJZFfA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 08/11] MIPS: mobileye: Add EyeQ5 dtsi
In-Reply-To: <CAL_Jsq+Pn=kWFL32Cit-vnyJg2pnap2TMn4LPVr9nTmyK-FrZw@mail.gmail.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-9-gregory.clement@bootlin.com>
 <CAL_Jsq+Pn=kWFL32Cit-vnyJg2pnap2TMn4LPVr9nTmyK-FrZw@mail.gmail.com>
Date:   Thu, 05 Oct 2023 17:17:45 +0200
Message-ID: <87mswxcd46.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

> On Wed, Oct 4, 2023 at 11:11=E2=80=AFAM Gregory CLEMENT
> <gregory.clement@bootlin.com> wrote:
>>
>> Add a device tree include file for the Mobileye EyeQ5 SoC.
>>
>> Based on the work of Slava Samsonov <stanislav.samsonov@intel.com>
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  arch/mips/boot/dts/Makefile                   |   1 +
>>  arch/mips/boot/dts/mobileye/Makefile          |   4 +
>>  .../boot/dts/mobileye/eyeq5-fixed-clocks.dtsi | 315 ++++++++++++++++++
>>  arch/mips/boot/dts/mobileye/eyeq5.dtsi        | 138 ++++++++
>>  4 files changed, 458 insertions(+)
>>  create mode 100644 arch/mips/boot/dts/mobileye/Makefile
>>  create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
>>  create mode 100644 arch/mips/boot/dts/mobileye/eyeq5.dtsi
>>
>> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
>> index 928f38a79dff..edb8e8dee758 100644
>> --- a/arch/mips/boot/dts/Makefile
>> +++ b/arch/mips/boot/dts/Makefile
>> @@ -8,6 +8,7 @@ subdir-$(CONFIG_LANTIQ)                 +=3D lantiq
>>  subdir-$(CONFIG_MACH_LOONGSON64)       +=3D loongson
>>  subdir-$(CONFIG_SOC_VCOREIII)          +=3D mscc
>>  subdir-$(CONFIG_MIPS_MALTA)            +=3D mti
>> +subdir-$(CONFIG_SOC_EYEQ5)             +=3D mobileye
>>  subdir-$(CONFIG_LEGACY_BOARD_SEAD3)    +=3D mti
>>  subdir-$(CONFIG_FIT_IMAGE_FDT_NI169445)        +=3D ni
>>  subdir-$(CONFIG_MACH_PIC32)            +=3D pic32
>> diff --git a/arch/mips/boot/dts/mobileye/Makefile b/arch/mips/boot/dts/m=
obileye/Makefile
>> new file mode 100644
>> index 000000000000..99c4124fd4c0
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/mobileye/Makefile
>> @@ -0,0 +1,4 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +# Copyright 2023 Mobileye Vision Technologies Ltd.
>> +
>> +obj-$(CONFIG_BUILTIN_DTB)      +=3D $(addsuffix .o, $(dtb-y))
>
> You didn't add anything to 'dtb-y'. Did you test this?

Initially yes, and finally we switch on the FIT image generation, so we
don't use it anymore

>
> Also, CONFIG_BUILTIN_DTB is supposed to be for legacy bootloaders
> which don't understand DT. For a new SoC, fix the bootloader.

I can remove it

>
>> diff --git a/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi b/arch/=
mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
>> new file mode 100644
>> index 000000000000..a0066465ac8b
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
>> @@ -0,0 +1,315 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +/*
>> + * Copyright 2023 Mobileye Vision Technologies Ltd.
>> + */
>
> I assume these aren't all really fixed, but just 'I don't have a clock
> driver yet'. That creates an ABI issue when you add the clock
> driver(s). Just FYI.

Indeed they aren't all fixed. The plan is to replace the relevant ones by a
real clock driver when ready.

In this case some part of the dts file will be modified. But is it a
real issue ?

Booting with a new kernel with an old dtb will still continue to work in
the same way. it's only new tdb with old kernel that won't work, but we
are not supposed to support this case.


>
>> +
>> +/ {
>> +       /* Fixed clock */
>> +       pll_cpu: pll_cpu {
>
> Don't use _ in node names.

OK
[...]

>> +/* PLL_CPU derivatives */
>> +       occ_cpu: occ_cpu {
>> +               compatible =3D "fixed-factor-clock";
>> +               clocks =3D <&pll_cpu>;
>> +               #clock-cells =3D <0>;
>> +               clock-div =3D <1>;
>> +               clock-mult =3D <1>;
>> +               clock-output-names =3D "occ_cpu";
>
> Isn't the default name the node name? Drop these unless you really
> have a need and they aren't redundant.

indeed it's not used, I remove them too.
[...]

>> --- /dev/null
>> +++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
>> @@ -0,0 +1,138 @@
>> +// SPDX-License-Identifier: GPL-2.0
>
> Doesn't match eyeq5-fixed-clocks.dtsi

OK

>
>> +/*
>> + * Copyright 2023 Mobileye Vision Technologies Ltd.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/mips-gic.h>
>> +#include <dt-bindings/soc/mobileye,eyeq5.h>
>> +
>> +/memreserve/ 0x40000000 0xc0000000; /* DDR32 */
>> +/memreserve/ 0x08000000 0x08000000; /* DDR_LOW */
>> +
>> +#include "eyeq5-fixed-clocks.dtsi"
>> +
>> +/* almost all GIC IRQs has the same characteristics. provide short form=
 */
>
> Maybe so, but I prefer not having 2 levels of lookup to figure out values.
>
>> +#define GIC_IRQ(x) GIC_SHARED (x) IRQ_TYPE_LEVEL_HIGH

OK I remove it.

>> +
>> +/ {
>> +       #address-cells =3D <2>;
>> +       #size-cells =3D <2>;
>> +       cpus {
>> +               #address-cells =3D <1>;
>> +               #size-cells =3D <0>;
>> +               cpu@0 {
>> +                       device_type =3D "cpu";
>> +                       compatible =3D "mti,i6500";
>> +                       reg =3D <0>;
>> +                       clocks =3D <&core0_clk>;
>> +               };
>> +       };
>> +
>> +       reserved-memory {
>> +               #address-cells =3D <2>;
>> +               #size-cells =3D <2>;
>> +               ranges;
>> +
>> +/* These reserved memory regions are also defined in bootmanager
>> + * for configuring inbound translation for BARS, don't change
>> + * these without syncing with bootmanager
>> + */
>
> Indent with the rest of the node.

OK

Thanks,

Gregory

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
