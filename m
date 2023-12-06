Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB21C806326
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346622AbjLFAFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346563AbjLFAFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:05:36 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F27F1A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:05:40 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bfd3a5b54so3021039e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 16:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701821138; x=1702425938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RP7nKtWfYoUzguTS/VKVOS7gViQ15zCDVCS0hR/PhBI=;
        b=D/aNRtiARtjUcKKcoNxLpJ0VMVfvV43Q8qAOaJZlSgF8SdLvng7Uzr3vhsJCH1V2CW
         6d+aUx64Iyt4SMwTBChwsZlGF/bOsgJQuctcUaRX9rKc6qTljpiWPcwZBVASuOqeMKcY
         bInACpazgdW3+hiLG0UN/12Z0ICghzVLiGepgBigUoOt5DVSZ06z+XVDWdXtXIL+e6kW
         NBTgqOslSPhNu+apjG5pPd8cEPRRKhNyGw5JXhArtODyfJflE4I7tTyDnS0cLCaIVYuj
         oSn02cgw/x0AI1XT8PHawqU/NsqvjoGJ40LhB5ojMW2L4I5aPFmtqAmPrKh6uw9KHSjE
         61aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701821138; x=1702425938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RP7nKtWfYoUzguTS/VKVOS7gViQ15zCDVCS0hR/PhBI=;
        b=d4s3UG6vVz2kIgrGgDyLK4BfMiD2gchhY4jFmk6MVVvSO9iRI8o8Zn4h768CZdiS5s
         KQNet/OYbkqIodfASNqWu6pYb1yT8oC+8/vypAaD11Whdo6Jior2mUOuGAdN09qqowLV
         bCZRVPSxg274SDy/qXBUGWg6oFD5zrfXilXYZNLc6cas3oMW8Nsn8gTegdMUatEsE5GY
         scIOC8zfbpvYv1nK1VGiNMCUH3yOse1jhA7g6B8EptnOZ/hmyj7mGsiZpI/7ach2IT4U
         0z/t3DZaLK/ontZpwzK5LcJhRsBQB2l5V73C916ZfQgshE3tjbWFuEeoMbVgFcTtl7lh
         a3CA==
X-Gm-Message-State: AOJu0YwQ8JvoJFDObwQN8CfYL5G29neipiIrl4Wm4jFTF6ebzhUWWBWq
        QWcrfQbyoThamngwwJfGbut5g4xSXkKm00dxhA8XCjOAuUU=
X-Google-Smtp-Source: AGHT+IGKktn7HHDLwAV42qseKcbMNbVaXmATh5nrHRAX4Ogdmds+Zagcmt4Suf2Kbh5Gotw6pwae5Mv3w4NK3vKK6E8=
X-Received: by 2002:a05:6512:3585:b0:50b:f3fc:125d with SMTP id
 m5-20020a056512358500b0050bf3fc125dmr42122lfr.38.1701821138330; Tue, 05 Dec
 2023 16:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20231203135753.1575-1-jszhang@kernel.org> <20231203135753.1575-2-jszhang@kernel.org>
 <ZW4lUDpl0eZVNjrp@ghost> <20231205021406.GD1168@sol.localdomain>
 <ZW8rbgsTqmuLTvoK@xhacker> <ZW+Oc8sJNcPLWk1Q@ghost>
In-Reply-To: <ZW+Oc8sJNcPLWk1Q@ghost>
From:   Charles Lohr <lohr85@gmail.com>
Date:   Tue, 5 Dec 2023 16:05:27 -0800
Message-ID: <CAGu26P9KiZQhTGO1TrRzGV86GjivmC7_HQaE5p_kNemx+euaEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The automatic detection code has become a bit of a thorn both for
folks like me who use the kernel for some fast-spin up aodr
virtualization (where check_unaligned_access soaks up 1/4 to 1/3 of
the total boot time and unaligned accesses are always fast) as well as
causing issues for the FPGA soft core development where they easily
know ahead of time what the situation is going to be.  It would be
extremely welcome if the access could always be overridden with a
config value that could either force on or force off unaligned access
and avoid execution of the check function permanently.  I don't see a
world where for some of us, we would ever want autodetection on.  In
the RISC-V arena, many times we're dealing with very small systems
where the marginal cost of dead code is rather high.

On Tue, Dec 5, 2023 at 12:57=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Tue, Dec 05, 2023 at 09:53:50PM +0800, Jisheng Zhang wrote:
> > On Mon, Dec 04, 2023 at 06:14:06PM -0800, Eric Biggers wrote:
> > > On Mon, Dec 04, 2023 at 11:15:28AM -0800, Charlie Jenkins wrote:
> > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > index 7f8aa25457ba..0a76209e9b02 100644
> > > > > --- a/arch/riscv/Kconfig
> > > > > +++ b/arch/riscv/Kconfig
> > > > > @@ -654,6 +654,18 @@ config RISCV_MISALIGNED
> > > > >           load/store for both kernel and userspace. When disable,=
 misaligned
> > > > >           accesses will generate SIGBUS in userspace and panic in=
 kernel.
> > > > >
> > > > > +config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > > >
> > > > There already exists hwprobe for this purpose. If kernel code wants=
 to
> > > > leverage the efficient unaligned accesses of hardware, it can use s=
tatic
> > > > keys. I have a patch that will set this static key if the hardware =
was
> > > > detected to have fast unaligned accesses:
> > > >
> > > > https://lore.kernel.org/linux-riscv/20231117-optimize_checksum-v11-=
2-7d9d954fe361@rivosinc.com/
> > >
> > > Is the plan to make the get_unaligned* and put_unaligned* macros expa=
nd to code
> > > for both cases, and select between them using a static key?  Note tha=
t there are
> > > a very large number of callers of these macros in the kernel.  And wh=
at about
> > > kernel code that checks CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS direct=
ly?
> > >
> > > AFAIK, no other Linux architecture supports kernel images where the u=
naligned
> > > access support is unknown at compile time.  It's not clear to me that=
 such an
> > > approach is feasible.  A static key can easily be provided, but it's =
unclear
> > > what code would use it, given that currently lots of kernel code assu=
mes that
> > > unaligned access support is known at compile time.
> > >
> > > Meanwhile, there are people building kernels they know will only be d=
eployed on
> > > systems where unaligned accesses are supported.  To me, it seems usef=
ul to
> > > provide a kconfig option for them to build a more efficient kernel.
> >
> > Generally, I agree with Eric's above points. Various subsystem such as =
net, mm,
> > lib and so on have different code path for CONFIG_HAVE_EFFICIENT_UNALIG=
NED_ACCESS,
> > while Charlie's patch only touch partial code of arch/riscv, and even i=
f those
> > subsystem maintainers agree with dynamic code patching(I still believe
> > persuading those subsystem maintainers is not easy), that's still a
> > huge task which needs to be done step by step. So before that, we'd
> > better let this series merged and benefit all efficient unaligned acces=
s
> > riscv systems. When the huge task is completed, we can remove the confi=
g
> > option.
> >
> > Thanks
>
> It would be best to enable all of the paths that leverage
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS at runtime (using hwprobe)
> instead of using a compile-time flag to do so. However, as you say, that
> is large task and doesn't need to be done immediately. For now I agree
> it is sufficient to use this new RISCV_EFFICIENT_UNALIGNED_ACCESS
> config.
>
> - Charlie
>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
