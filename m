Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A783A7AE466
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjIZEJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZEJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:09:15 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAD4E9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:09:08 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6c4d625da40so3379299a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695701348; x=1696306148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqOFR+aV2U747dOvG4VR290UntHO+h5U56cTzrU/C40=;
        b=RVRuxCV9UxPq9ivAiEFO3pzFyI46rQd842Pu4Fpu9yOkIQzaWIQ/8uIi55O7pMMZxD
         5Jni4QA4gA9p5k6E5a8+1wOTiU8t727yDr3XrIGVPiMep+84hSGjWUVRXOWE+t8lnMB7
         T1TdkCay+nNKOnXydGfR3H+I5h/CFQ1iI+7YiI5sFlRCum3FjlzxtiaiFBv/5avsT2ms
         +SnI5ozP+VjiChzksZssEusASH3isEm1CeJgLpzL0OaD2jXHOFC33QuKDQmGV3s+Zap/
         nBaoU2GXwkYlKy+AQKoZWXYc4HZgzntdBBMOQZP0srMkZRuldqsLgy20ijIB4tt+5SyU
         L4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695701348; x=1696306148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqOFR+aV2U747dOvG4VR290UntHO+h5U56cTzrU/C40=;
        b=GSi3QNizeLKfz5GKvbbfJWkUQ0adR2qYwRmu0lCGimh/dxoUs8HvTwTnaQ/bYnlqK3
         Q+pR9wdwqptyzeaSoWrft7zkEVsC6Qw6ML/ioMh31D3tHVbyQXT5jghujwV46Mm+8Oki
         u18RTfg6+vJseXXZZiS/hwxJv6lOexyN+JIRdpyIlCZ2N0BRMXoB6S/kVd2UPP3CY0Gw
         5a991+u43+0typm2Lnnj4ecYQxudEcGpn3nXGFAE7UtifopmqIacuFXuH8TWGIaIaiOn
         UEDC0zr9VjhW/zFsgOtWhXAmDb91U3Fo4fhs3ZZlmfhTTLeNVyvdTxahvRreO/KOdr2l
         uOAw==
X-Gm-Message-State: AOJu0Yz9Dmg/7397Ycas34/6MWXZAlnMtnjvwPrFArLzcRhShBMBTV8U
        YvcMlQZEDdXUzrR2RtjGq4Y8LTEuYkM4O2dJj+g+4A==
X-Google-Smtp-Source: AGHT+IGmAxRog0hnxnVuuXVJuHjUbHq/ZKXhq770X+Pd2SPALmcAYb8MwVNhUMNSdmD8plbQLTGKkz2OCmPClWmIJ90=
X-Received: by 2002:a05:6808:1a21:b0:3a7:2690:94e0 with SMTP id
 bk33-20020a0568081a2100b003a7269094e0mr13581224oib.4.1695701347858; Mon, 25
 Sep 2023 21:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
 <20230925133859.1735879-3-apatel@ventanamicro.com> <ZRHH25IyJJLWSolC@ghost>
In-Reply-To: <ZRHH25IyJJLWSolC@ghost>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 26 Sep 2023 09:38:56 +0530
Message-ID: <CAK9=C2UoKxM+wknB4n8=okyXCCE6t0Vvz4jU_tBW6DMm6Vb3DA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] RISC-V: Detect XVentanaCondOps from ISA string
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:18=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> On Mon, Sep 25, 2023 at 07:08:52PM +0530, Anup Patel wrote:
> > The Veyron-V1 CPU supports custom conditional arithmetic and
> > conditional-select/move operations referred to as XVentanaCondOps
> > extension. In fact, QEMU RISC-V also has support for emulating
> > XVentanaCondOps extension.
> >
> > Let us detect XVentanaCondOps extension from ISA string available
> > through DT or ACPI.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 1 +
> >  arch/riscv/kernel/cpufeature.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index 0f520f7d058a..b7efe9e2fa89 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -59,6 +59,7 @@
> >  #define RISCV_ISA_EXT_ZIFENCEI               41
> >  #define RISCV_ISA_EXT_ZIHPM          42
> >  #define RISCV_ISA_EXT_SMSTATEEN              43
> > +#define RISCV_ISA_EXT_XVENTANACONDOPS        44
> >
> >  #define RISCV_ISA_EXT_MAX            64
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 3755a8c2a9de..3a31d34fe709 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -182,6 +182,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >       __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> >       __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> >       __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > +     __RISCV_ISA_EXT_DATA(xventanacondops, RISCV_ISA_EXT_XVENTANACONDO=
PS),
> >  };
> >
> >  const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> I worry about storing vendor extensions in this file. Because vendor
> extensions are not standardized, they can only be expected to have the
> desired behavior on hardware with the appropriate vendor id. A couple

Assuming that a vendor extension is only available on hardware with
appropriate vendor id is not correct because:
1) vendor A can allow vendor B to implement a custom extension
    defined by vendor B
2) vendor A and vendor B can jointly develop a RISC-V CPU where
    both vendors integrate their custom extensions.

It is best to identify a vendor extension independently with a
"X<vendor_name><extension_name>" string to keep it simple
and scalable.

Along these lines, each T-Head custom extension should have a
"XThead<xyz>" name associated with it.

> months ago I sent a patch to address this by handling vector extensions
> independently for each vendor [1]. I dropped the patch because it
> relied upon Heiko's T-Head vector extension support that he stopped
> working on. However, I can revive this patch so you can build off of it.

At least, the conditional operations don't need a hwprobe interface
because an application is either compiled with or without conditional
operations. In other words, effective use of conditional operation is
only possible if compiler generates these instructions based on
code patterns.

>
> This scheme has the added benefit that vendors do not have to worry
> about conficting extensions, and the kernel does not have to act as a
> key registry for vendors.

How can vendor extensions conflict if they all follow the
"X<vendor_name><extension_name>" naming scheme ?

>
> What are your thoughts?
>
> - Charlie
>
> [1] https://lore.kernel.org/lkml/20230705-thead_vendor_extensions-v1-2-ad=
6915349c4d@rivosinc.com/
>

Regards,
Anup
