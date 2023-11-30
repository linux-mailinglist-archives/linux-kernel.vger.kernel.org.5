Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF497FEE3A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345116AbjK3Lq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjK3Lqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:46:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2A73848
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:45:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B2EC433C8;
        Thu, 30 Nov 2023 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701344710;
        bh=JNkR9EjPBKE3T4ENiOD9ib+nug7CA6U/xJMJjrAqZps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxOBkApolmVpqBeownjdXlvxdGTNt45FYzGD/5KNopyIJkGI6SbSI89qwP2IW6oHb
         oyeHDFU2nNjv144vQJqBUbNt3vXq8dTi7NwpE1yqIQRWymMeF6f/EXOzc6YUwcqdLh
         53e+ZCSS7YKG5PVi9MxWsQ1KbmY0mNkgoyDNPFLbqZsM13GVs6JdW/zVgb0IQAfE/t
         xziNuSWTl6G1V5WADpSd/HhfZraf4ZJ+V1wBCrVst9wRKWW4zSua9yvf5exvYpTLPs
         NJ0zulxtUWTq3Y9LPit6MBvPeK3X8BpK0r72yh2bU34rrot2/KKLWjfM2syd+OvwlV
         4ZDfArrer9GYg==
Date:   Thu, 30 Nov 2023 11:45:05 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
Message-ID: <20231130-shower-award-3cd5f1bba5db@spud>
References: <IA1PR20MB4953C82499C5D81D2C6A020BBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953F9D77FFC76A9D236922DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAK9=C2WAv5jJBt56xBea268DeyUA+YvbU7i+ahVjueafCi-r6A@mail.gmail.com>
 <20231130-decibel-passenger-6e932b1ce554@spud>
 <CAK9=C2Vsx8ddpYiqUhvqnJpdb-FKeNhLz3PsVpSeEz4TeQHiEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VKYk05yx41tbUITR"
Content-Disposition: inline
In-Reply-To: <CAK9=C2Vsx8ddpYiqUhvqnJpdb-FKeNhLz3PsVpSeEz4TeQHiEg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VKYk05yx41tbUITR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 04:51:32PM +0530, Anup Patel wrote:
> On Thu, Nov 30, 2023 at 3:27=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Thu, Nov 30, 2023 at 03:01:24PM +0530, Anup Patel wrote:
> > > On Sat, Nov 18, 2023 at 12:39=E2=80=AFPM Inochi Amaoto <inochiama@out=
look.com> wrote:
> > > >
> > > > The timer registers of aclint don't follow the clint layout and can
> > > > be mapped on any different offset. As sg2042 uses separated timer
> > > > and mswi for its clint, it should follow the aclint spec and have
> > > > separated registers.
> > > >
> > > > The previous patch introduced a new type of T-HEAD aclint timer whi=
ch
> > > > has clint timer layout. Although it has the clint timer layout, it
> > > > should follow the aclint spec and uses the separated mtime and mtim=
ecmp
> > > > regs. So a ABI change is needed to make the timer fit the aclint sp=
ec.
> > > >
> > > > To make T-HEAD aclint timer more closer to the aclint spec, use
> > > > regs-names to represent the mtimecmp register, which can avoid hack
> > > > for unsupport mtime register of T-HEAD aclint timer.
> > > >
> > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > > Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT t=
imer")
> > > > Link: https://lists.infradead.org/pipermail/opensbi/2023-October/00=
5693.html
> > > > Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.=
adoc
> > >
> > > The ratified Priv v1.12 specification defines platform specific M-mod=
e timer
> > > registers without defining any layout of mtime and mtimecmp registers.
> > > (Refer, "3.2.1 Machine Timer Registers (mtime and mtimecmp)")
> > >
> > > The "thead,c900-aclint-mtimer" can be thought of as is one possible
> > > implementation of "riscv,mtimer" defined by the Priv v1.12 specificai=
ton.
> > >
> > > If it is not too late then I suggest making this binding into generic
> > > "riscv,mtimer" binding.
> >
> > We could definitely reorganise things, it's not too late for that as
> > implementation specific compatibles would be needed regardless, so
> > software that would've matched on those will continue to do so.
> >
> > That said, does this platform actually implement the 1.12 priv spec if
> > there is no mtime register? The section you reference says:
> > "Platforms provide a real-time counter, exposed as a memory-mapped
> > machine-mode read-write register, mtime." It seems to me like this
> > hardware is not suitable for a generic "riscv,mtimer" fallback.
>=20
> Yes, the T-Head mtimer does not implement both mtime and mtimecmp
> so technically it only implements a portion of the ratified RISC-V mtimer
> chapter.
>=20
> >
> > Am I missing something there Anup?
> >
> > It doesn't even implement the draft aclint spec, given that that says:
> > "The MTIMER device provides machine-level timer functionality for a set
> > of HARTs on a RISC-V platform. It has a single fixed-frequency monotonic
> > time counter (MTIME) register and a time compare register (MTIMECMP) for
> > each HART connected to the MTIMER device."
> >
> > But I already said no to having a generic, "riscv" prefixed, compatible
> > for that, given it is in draft form.
>=20
> I am not suggesting T-Head timer implements aclint spec. Also,
> since aclint spec is in draft state it is out of the question.

I did not intend to imply that you were suggesting that there should be
one. I was just trying to clarify that I was not trying to bring back
the topic of a generic aclint binding applying here.

> My suggestion is to treat "3.2.1 Machine Timer Registers (mtime
> and mtimecmp)" as RISC-V mtimer defined by the RISC-V privileged
> specification and define "riscv" prefixed DT binding for this.

I'm not against a binding for that at all.

> This binding defines two possible values for "reg" property:
> 1) contains two items: a) mtime register address and,
>      b) base address of mtimecmp registers
> 2) contain one item: a) base address of mtimecmp registers
>=20
> The t-head mtimer seems to implement #2 whereas the RISC-V
> mtimer (Priv spec) aligns with #1.
>=20
> If we want to keep this DT binding t-head specific then
> we should remove option #1 (above) from this DT binding

This part is already the conclusion of one of the other "branches" of
this thread and is (AFAIU) Inochi's plan for the next version.

> and add separate "riscv" prefixed DT binding for RISC-V mtimer.

Do you know of any users for a "riscv,mtimer" binding that are not
covered by existing bindings for the clint?

Cheers,
Conor.

--VKYk05yx41tbUITR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWh1wAAKCRB4tDGHoIJi
0tTrAPoCJ+T+YM3dA7jbCLL4W/Awf+VDdj/J2pMkjJ5bKfCMygD/fEwJfrAvowq+
L64lkqtaXIQZsnBWYdOZ8jc/LJ8WkQ8=
=oCOP
-----END PGP SIGNATURE-----

--VKYk05yx41tbUITR--
