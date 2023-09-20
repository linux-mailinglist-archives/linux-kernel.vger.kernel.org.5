Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB57A8F67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjITW0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjITW0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:26:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722E7131
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:25:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94DEC433CB;
        Wed, 20 Sep 2023 22:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695248707;
        bh=1hAloOg1XEAD5sA3NdMjJDFHNgWUZuNJi8NkzQ+xdjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/2KPRd2tXwhiYuAlPNMWxsUNRs/wpf1+Sac1UGySMFHFfVKeYXKyYqACvf59kvO+
         tFIhvgM4ukD7ZJFFF/zxvBQyjN/KG1w0oeJ4TnWUEQIvBwaBzbtd5uXBh7gW1HbCcN
         SMtsSNNAHvlrCvG5ZuXNTwx82nwSIZkNVIlJWicqkXOAko1hOFR1U1t24679AB0Tml
         Fpj0jipmupESYNFGQJlwvke3ufTWUxr3NNttgDgL0rkKud5+gJbWq61w0Dua7SOVOP
         l+wjfDFk69iWDYwAp/STa/+UgMmDy2cpABeKiapA9cmU/N+e415mg82CvPXyC5m9nQ
         gg3iuZ74L+AFQ==
Date:   Wed, 20 Sep 2023 23:25:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v2] RISC-V: Probe misaligned access speed in parallel
Message-ID: <20230920-0e2bce9821557cce8d022157@fedora>
References: <20230920193801.3035093-1-evan@rivosinc.com>
 <20230920-98a392b40f88c69e852e2c88@fedora>
 <CAOnJCUK7KTO0n_8wDYDxh2ULtEvMWF-re2dEX6nng_tX1AGgPw@mail.gmail.com>
 <CALs-HsuurXBZ2p=jYKvPq6ZMScugm5rBchttD6Wv9Mtupfx3NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nhi9TlVMSb87TbQQ"
Content-Disposition: inline
In-Reply-To: <CALs-HsuurXBZ2p=jYKvPq6ZMScugm5rBchttD6Wv9Mtupfx3NQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nhi9TlVMSb87TbQQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 03:06:45PM -0700, Evan Green wrote:
> On Wed, Sep 20, 2023 at 2:27=E2=80=AFPM Atish Patra <atishp@atishpatra.or=
g> wrote:
> >
> > On Wed, Sep 20, 2023 at 2:04=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > Yo,
> > >
> > > On Wed, Sep 20, 2023 at 12:38:01PM -0700, Evan Green wrote:
> > > > Probing for misaligned access speed takes about 0.06 seconds. On a
> > > > system with 64 cores, doing this in smp_callin() means it's done
> > > > serially, extending boot time by 3.8 seconds. That's a lot of boot =
time.
> > > >
> > > > Instead of measuring each CPU serially, let's do the measurements on
> > > > all CPUs in parallel. If we disable preemption on all CPUs, the
> > > > jiffies stop ticking, so we can do this in stages of 1) everybody
> > > > except core 0, then 2) core 0.
> > > >
> > > > The measurement call in smp_callin() stays around, but is now
> > > > conditionalized to only run if a new CPU shows up after the round of
> > > > in-parallel measurements has run. The goal is to have the measureme=
nt
> > > > call not run during boot or suspend/resume, but only on a hotplug
> > > > addition.
> > > >
> > > > Reported-by: Jisheng Zhang <jszhang@kernel.org>
> > > > Closes: https://lore.kernel.org/all/mhng-9359993d-6872-4134-83ce-c9=
7debe1cf9a@palmer-ri-x1c9/T/#mae9b8f40016f9df428829d33360144dc5026bcbf
> > > > Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
> > > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > Tested-by: Andrew Jones <ajones@ventanamicro.com>
> > > >
> > > > ---
> > > >
> > > > Changes in v2:
> > > >  - Removed new global, used system_state =3D=3D SYSTEM_RUNNING inst=
ead
> > > >    (Jisheng)
> > > >  - Added tags
> > > >
> > > >  arch/riscv/include/asm/cpufeature.h |  2 +-
> > > >  arch/riscv/kernel/cpufeature.c      | 22 +++++++++++++++++-----
> > > >  arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
> > > >  3 files changed, 28 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/inclu=
de/asm/cpufeature.h
> > > > index d0345bd659c9..b139796392d0 100644
> > > > --- a/arch/riscv/include/asm/cpufeature.h
> > > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > > @@ -30,6 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
> > > >  /* Per-cpu ISA extensions. */
> > > >  extern struct riscv_isainfo hart_isa[NR_CPUS];
> > > >
> > > > -void check_unaligned_access(int cpu);
> > > > +int check_unaligned_access(void *unused);
> > > >
> > > >  #endif
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpu=
feature.c
> > > > index 1cfbba65d11a..40bb854fcb96 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -556,8 +556,9 @@ unsigned long riscv_get_elf_hwcap(void)
> > > >       return hwcap;
> > > >  }
> > > >
> > > > -void check_unaligned_access(int cpu)
> > > > +int check_unaligned_access(void *unused)
> > > >  {
> > > > +     int cpu =3D smp_processor_id();
> > > >       u64 start_cycles, end_cycles;
> > > >       u64 word_cycles;
> > > >       u64 byte_cycles;
> > > > @@ -571,7 +572,7 @@ void check_unaligned_access(int cpu)
> > > >       page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_=
SIZE));
> > > >       if (!page) {
> > > >               pr_warn("Can't alloc pages to measure memcpy performa=
nce");
> > > > -             return;
> > > > +             return 0;
> > >
> > > Dumb question maybe, but I am limited setup wise at the moment due to
> > > a hardware failure which makes checking stuff hard, why the signature
> > > change? Requirement for on_each_cpu()?
> > >
> >
> > Requirement for smp_call_on_cpu.
>=20
> Right.
>=20
> >
> > > >       }
> > > >
> > > >       /* Make an unaligned destination buffer. */
> > > > @@ -643,15 +644,26 @@ void check_unaligned_access(int cpu)
> > > >
> > > >  out:
> > > >       __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void check_unaligned_access_nonboot_cpu(void *param)
> > > > +{
> > > > +     if (smp_processor_id() !=3D 0)
> > > > +             check_unaligned_access(param);
> > > >  }
> > > >
> > > > -static int check_unaligned_access_boot_cpu(void)
> > > > +static int check_unaligned_access_all_cpus(void)
> > > >  {
> > > > -     check_unaligned_access(0);
> > > > +     /* Check everybody except 0, who stays behind to tend jiffies=
=2E */
> > > > +     on_each_cpu(check_unaligned_access_nonboot_cpu, NULL, 1);
> > > > +
> > > > +     /* Check core 0. */
> > > > +     smp_call_on_cpu(0, check_unaligned_access, NULL, true);
> > > >       return 0;
> > >
> > > Why does this function return an int if it can only return 0?
> > >
>=20
> This is a requirement on the initcall_t function pointer type.

Ahh great, thanks for the explanations!


--nhi9TlVMSb87TbQQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQtxOQAKCRB4tDGHoIJi
0gsAAP4oRm6nyjbOWvN0vK15n5APUUbx9gPnLXg16eOjQf84QwD+NsZutNpl565C
z1nB04KBD87Lss8Ip4tkKtxkvOSdogA=
=dkma
-----END PGP SIGNATURE-----

--nhi9TlVMSb87TbQQ--
