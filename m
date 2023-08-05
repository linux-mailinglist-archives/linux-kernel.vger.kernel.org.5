Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F67770FE0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 15:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjHENOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHENOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 09:14:43 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DF5E70
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 06:14:40 -0700 (PDT)
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E93EB3F20E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 13:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691241278;
        bh=UIZCorPNYUH2jkiVRuR7FSmjsopaTm8kFTAnEKf8VTE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=bHZvhihxtmDr5Ow0JCOUpb91//mNIAdHegjOHODQUatzVrA0lNNFvzbYPCZfnDvX4
         f3YOmOzJaPR/rQhljJFoalICXpCWME4/UpZVmb9p0HDZJEzwxhEwqC67DD8dJzjAzz
         p2VRUkPW597Yp82env3puuVEcAad10zB5ezZMhsAXdEByO8y0fxUVI6MvWaBKkVktl
         xGxVi1tFwNrYi44dXe9uEJWrlDhWvv3r526CagxOvlxEBK2nUWYNDqi09pd20ccrc5
         XL6Q1qc5TB2djG3Z5MWzXL6Jr4phdouddU3L4lYLknEcOYkzQ5Gj/btfsdvfVGNqgS
         TBRf3ftbpbpVQ==
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7683da3e2a5so332739385a.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 06:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691241277; x=1691846077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIZCorPNYUH2jkiVRuR7FSmjsopaTm8kFTAnEKf8VTE=;
        b=Fv90HJ0q8yJLv4YcAS42b7R1fT6sU3Ixh2AKBViwDBCHD6RnqAdtVLPpZ/jo5kG4vC
         h21imcxeP0moCXcWVosDjWrqZceGi6vKZwpsZFvpmepdoSMtrtdiQy5HJwqcR6Yslqr7
         37/ysaa4j40swjaTZT7sWW6HX8G0MhfNblsGyXcxW0wTgP64paiR+8fjnqRI3XpatpNI
         k3qkUIXLtk73OB3RGvCXGpbKo803oU1wJ2pJByNcKRsxqTZ+lDlxWK3+AfEq2SB2ElI+
         rgfB0AVgwVsH23vdkMWEtZq75ICMEnDphgValFW9qSAekP15PrYxFAdYVtettQTKdSad
         i08A==
X-Gm-Message-State: AOJu0YwmZb+c/7L5MEo4/hImyuzENETwZ+irKWz6XDkcd5QIwnPKDMLT
        S0iODxt1Y+xoZqF79l5NIeNI7VvGr9f99tC7Wb4B6ntmtY21N5adgF4a48ixImOfYqyrcnpkAM4
        OeIh+jnEfJGW0m4mzJR2l/sFD0gRgiXwfGesmyzECU2+fMtFyy0/bZO4k+g==
X-Received: by 2002:a05:620a:b19:b0:76c:4833:f851 with SMTP id t25-20020a05620a0b1900b0076c4833f851mr4889926qkg.47.1691241277322;
        Sat, 05 Aug 2023 06:14:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+eIfLgnZw5L9ycwyhdLrN0uqyoE4q3saqIVPvg88zQ5KEtjZikqCgXF3BhVK1Upko+kK9baLSnF/xrJ3ejpg=
X-Received: by 2002:a05:620a:b19:b0:76c:4833:f851 with SMTP id
 t25-20020a05620a0b1900b0076c4833f851mr4889905qkg.47.1691241277035; Sat, 05
 Aug 2023 06:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-4-william.qiu@starfivetech.com> <CAJM55Z8gVEZS4Ws2Gi7_JbdkS-4y3_8mQvR4ZxLCWZ4A1y9X1g@mail.gmail.com>
 <CAJM55Z-h+CUmWtkn31Ek+qvxrOr5_Jz3QRRLqWYLz2A0E+h+rA@mail.gmail.com> <d967d628-6961-568e-d72e-ce0e17153818@starfivetech.com>
In-Reply-To: <d967d628-6961-568e-d72e-ce0e17153818@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Sat, 5 Aug 2023 15:14:20 +0200
Message-ID: <CAJM55Z_sXt8G4+SFuN74g95zjE73f=9gbtVE+dxZ0UDEcH1hMQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] riscv: dts: starfive: Add mmc node
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 13:26, William Qiu <william.qiu@starfivetech.com> wrote:
> On 2023/2/15 20:22, Emil Renner Berthing wrote:
> > On Wed, 15 Feb 2023 at 13:12, Emil Renner Berthing
> > <emil.renner.berthing@canonical.com> wrote:
> >>
> >> On Wed, 15 Feb 2023 at 12:35, William Qiu <william.qiu@starfivetech.com> wrote:
> >> >
> >> > Add the mmc node for the StarFive JH7110 SoC.
> >> > Set mmco node to emmc and set mmc1 node to sd.
> >> >
> >> > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >> > ---
> >> >  .../jh7110-starfive-visionfive-2.dtsi         | 23 +++++++++
> >> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 47 +++++++++++++++++++
> >> >  2 files changed, 70 insertions(+)
> >> >
> >> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> >> > index c60280b89c73..e1a0248e907f 100644
> >> > --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> >> > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> >> > @@ -42,6 +42,29 @@ &rtc_osc {
> >> >         clock-frequency = <32768>;
> >> >  };
> >> >
> >> > +&mmc0 {
> >> > +       max-frequency = <100000000>;
> >> > +       bus-width = <8>;
> >> > +       cap-mmc-highspeed;
> >> > +       mmc-ddr-1_8v;
> >> > +       mmc-hs200-1_8v;
> >> > +       non-removable;
> >> > +       cap-mmc-hw-reset;
> >> > +       post-power-on-delay-ms = <200>;
> >> > +       status = "okay";
> >> > +};
> >> > +
> >> > +&mmc1 {
> >> > +       max-frequency = <100000000>;
> >> > +       bus-width = <4>;
> >> > +       no-sdio;
> >> > +       no-mmc;
> >> > +       broken-cd;
> >> > +       cap-sd-highspeed;
> >> > +       post-power-on-delay-ms = <200>;
> >> > +       status = "okay";
> >> > +};
> >
> > These nodes are also still oddly placed in the middle of the external
> > clocks. Again please keep the external clocks at the top and then
> > order the nodes alphabetically to have some sort of system.
> >
>
>
> Hi Emil,
>
> I'll update it in next version.

Hi William,

It seems the mmc nodes are still missing from the upstream device
tree. The sysreg nodes have been added in Conors riscv-dt-for-next[1]
branch, so I don't see any missing dependencies. Could you please
update and send a new version of this?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=riscv-dt-for-next

/Emil

> Best Regards
> William
>
> >> >  &gmac0_rmii_refin {
> >> >         clock-frequency = <50000000>;
> >> >  };
> >> > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> >> > index 64d260ea1f29..17f7b3ee6ca3 100644
> >> > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> >> > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> >> > @@ -314,6 +314,11 @@ uart2: serial@10020000 {
> >> >                         status = "disabled";
> >> >                 };
> >> >
> >> > +               stg_syscon: syscon@10240000 {
> >> > +                       compatible = "starfive,jh7110-stg-syscon", "syscon";
> >> > +                       reg = <0x0 0x10240000 0x0 0x1000>;
> >> > +               };
> >> > +
> >> >                 uart3: serial@12000000 {
> >> >                         compatible = "snps,dw-apb-uart";
> >> >                         reg = <0x0 0x12000000 0x0 0x10000>;
> >> > @@ -370,6 +375,11 @@ syscrg: clock-controller@13020000 {
> >> >                         #reset-cells = <1>;
> >> >                 };
> >> >
> >> > +               sys_syscon: syscon@13030000 {
> >> > +                       compatible = "starfive,jh7110-sys-syscon", "syscon";
> >> > +                       reg = <0x0 0x13030000 0x0 0x1000>;
> >> > +               };
> >> > +
> >> >                 gpio: gpio@13040000 {
> >> >                         compatible = "starfive,jh7110-sys-pinctrl";
> >> >                         reg = <0x0 0x13040000 0x0 0x10000>;
> >> > @@ -397,6 +407,11 @@ aoncrg: clock-controller@17000000 {
> >> >                         #reset-cells = <1>;
> >> >                 };
> >> >
> >> > +               aon_syscon: syscon@17010000 {
> >> > +                       compatible = "starfive,jh7110-aon-syscon", "syscon";
> >> > +                       reg = <0x0 0x17010000 0x0 0x1000>;
> >> > +               };
> >> > +
> >> >                 gpioa: gpio@17020000 {
> >> >                         compatible = "starfive,jh7110-aon-pinctrl";
> >> >                         reg = <0x0 0x17020000 0x0 0x10000>;
> >> > @@ -407,5 +422,37 @@ gpioa: gpio@17020000 {
> >> >                         gpio-controller;
> >> >                         #gpio-cells = <2>;
> >> >                 };
> >> > +
> >> > +               mmc0: mmc@16010000 {
> >> > +                       compatible = "starfive,jh7110-mmc";
> >> > +                       reg = <0x0 0x16010000 0x0 0x10000>;
> >> > +                       clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
> >> > +                                <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> >> > +                       clock-names = "biu","ciu";
> >> > +                       resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
> >> > +                       reset-names = "reset";
> >> > +                       interrupts = <74>;
> >> > +                       fifo-depth = <32>;
> >> > +                       fifo-watermark-aligned;
> >> > +                       data-addr = <0>;
> >> > +                       starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
> >> > +                       status = "disabled";
> >> > +               };
> >> > +
> >> > +               mmc1: mmc@16020000 {
> >> > +                       compatible = "starfive,jh7110-mmc";
> >> > +                       reg = <0x0 0x16020000 0x0 0x10000>;
> >> > +                       clocks = <&syscrg JH7110_SYSCLK_SDIO1_AHB>,
> >> > +                                <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> >> > +                       clock-names = "biu","ciu";
> >> > +                       resets = <&syscrg JH7110_SYSRST_SDIO1_AHB>;
> >> > +                       reset-names = "reset";
> >> > +                       interrupts = <75>;
> >> > +                       fifo-depth = <32>;
> >> > +                       fifo-watermark-aligned;
> >> > +                       data-addr = <0>;
> >> > +                       starfive,sysreg = <&sys_syscon 0x9c 0x1 0x3e>;
> >> > +                       status = "disabled";
> >> > +               };
> >>
> >> Hi William,
> >>
> >> These nodes still don't seem to be sorted by address, eg. by the
> >> number after the @
> >> Also please move the dt-binding patch before this one, so dtb_check
> >> won't fail no matter where git bisect happens to land.
> >>
> >> /Emil
> >>
> >> >         };
> >> >  };
> >> > --
> >> > 2.34.1
> >> >
> >> >
> >> > _______________________________________________
> >> > linux-riscv mailing list
> >> > linux-riscv@lists.infradead.org
> >> > http://lists.infradead.org/mailman/listinfo/linux-riscv
