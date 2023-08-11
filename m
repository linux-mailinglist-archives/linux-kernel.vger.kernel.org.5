Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61BF778A57
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjHKJtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjHKJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:49:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8E72728
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691747380; x=1723283380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9VhyV6tf6nKG8sQMJiUssXz+BHVJ+A8d6JFwhaqPn7k=;
  b=HGkXkIbirvaTu5tRTx612MO/ScW94Bt/ZOyx468CMNbDkYEhVFWPt4m1
   tVxuOBEmUd83fmXpTObh0ULftM8Q0eYxUUxa14uDRFb9AFry08jAtsOio
   dWwCRaVxC6WAkSRJb02DFdqV7nmWNuElXR0eXEy9u5LFKmLDFNKJofd7F
   BRjvr/Pv0brmWHSFYOTa+q+yUrYKwzZaFNHogY6qwHeMIvBlV4LyB0iAD
   crDZQD45NW/s5EuC//EbQ7qQ4mnWpJ7r7IuUt+lNhowciIAeosNz5OiQw
   LwSAoe7W9eOradvoTXGtnUQwguzHNm6JTT5Tc3zdoOvcjfQk3mYFYtkAI
   w==;
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="asc'?scan'208";a="229327501"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Aug 2023 02:49:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 11 Aug 2023 02:49:11 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 11 Aug 2023 02:49:08 -0700
Date:   Fri, 11 Aug 2023 10:48:31 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Guo Ren <guoren@kernel.org>
CC:     Palmer Dabbelt <palmer@rivosinc.com>, <leobras@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <parri.andrea@gmail.com>,
        <andrzej.hajda@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables
 of size 1 and 2
Message-ID: <20230811-lip-penalty-ded332178318@wendy>
References: <98f523e515b2adc2aa7bb8d133353bad74e30897.camel@redhat.com>
 <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
 <CAJF2gTQgv5xsfSfvV7KePAXFnFQOMq4GXOp40kQgM54L6hVD7w@mail.gmail.com>
 <20230811-overlook-displace-330af8289647@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1G+VqHK18bMDBLDF"
Content-Disposition: inline
In-Reply-To: <20230811-overlook-displace-330af8289647@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1G+VqHK18bMDBLDF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 07:27:28AM +0100, Conor Dooley wrote:
> On Fri, Aug 11, 2023 at 09:40:30AM +0800, Guo Ren wrote:
> > On Fri, Aug 11, 2023 at 12:23=E2=80=AFAM Palmer Dabbelt <palmer@rivosin=
c.com> wrote:
> > >
> > > On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> > > > On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> > > >> On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> > > >> > xchg for variables of size 1-byte and 2-bytes is not yet availab=
le for
> > > >> > riscv, even though its present in other architectures such as ar=
m64 and
> > > >> > x86. This could lead to not being able to implement some locking=
 mechanisms
> > > >> > or requiring some rework to make it work properly.
> > > >> >
> > > >> > Implement 1-byte and 2-bytes xchg in order to achieve parity wit=
h other
> > > >> > architectures.
> > > >> >
> > > >> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > >>
> > > >
> > > > Hello Arnd Bergmann, thanks for reviewing!
> > > >
> > > >> Parity with other architectures by itself is not a reason to do th=
is,
> > > >> in particular the other architectures you listed have the instruct=
ions
> > > >> in hardware while riscv does not.
> > > >
> > > > Sure, I understand RISC-V don't have native support for xchg on var=
iables of
> > > > size < 4B. My argument is that it's nice to have even an emulated v=
ersion for
> > > > this in case any future mechanism wants to use it.
> > > >
> > > > Not having it may mean we won't be able to enable given mechanism i=
n RISC-V.
> > >
> > > IIUC the ask is to have a user within the kernel for these functions.
> > > That's the general thing to do, and last time this came up there was =
no
> > > in-kernel use of it -- the qspinlock stuff would, but we haven't enab=
led
> > > it yet because we're worried about the performance/fairness stuff that
> > > other ports have seen and nobody's got concrete benchmarks yet (though
> > > there's another patch set out that I haven't had time to look through,
> > > so that may have changed).
> > Conor doesn't agree with using an alternative as a detour mechanism
> > between qspinlock & ticket lock.
>=20
> Hold on a sec, I don't recall having a problem with alternatives - it
> was calling the stronger forward progress guarantee an erratum
> (which it isn't) and an ISA extension w/o any "abusing" that framework
> that I did not like.

Hmm, what I wrote here makes no sense reading it back. Let me try again:

	Hold on a sec, I don't recall having a problem with alternatives - it
	was calling the stronger forward progress guarantee an erratum
	(which it isn't) and "abusing" that framework that I did not like.
	The series effectively mixed and matched whichever part of ISA
	extensions and errata that was convenient.

>=20
> > So I'm preparing V11 with static_key
> > (jump_label) style.
>=20
> I don't think there's much point rushing into making it based on static
> keys when no progress has been made on implementing support for
> non-standard extensions. Changing to a static key doesn't change the
> detection mechanism, I've not got a problem with using alternatives for
> this stuff.
>=20
> Thanks,
> Conor.
>=20
> > Next version, I would separate paravirt_qspinlock
> > & CNA_qspinlock from V10. That would make it easy to review the
> > qspinlock patch series. You can review the next version V11. Now I'm
> > debugging a static_key init problem when load_modules, which is
> > triggered by our combo_qspinlock.
> >=20
> > The qspinlock is being tested on the riscv platform [1] with 128 cores
> > with 8 NUMA nodes, next, I would update the comparison results of
> > qspinlock & ticket lock.
> >=20
> > [1]: https://www.sophon.ai/
> >=20
> > >
> > > So if something uses these I'm happy to go look closer.
> > >
> > > >> Emulating the small xchg() through cmpxchg() is particularly tricky
> > > >> since it's easy to run into a case where this does not guarantee
> > > >> forward progress.
> > > >>
> > > >
> > > > Didn't get this part:
> > > > By "emulating small xchg() through cmpxchg()", did you mean like em=
ulating an
> > > > xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
> > > >
> > > > If so, yeah, it's a fair point: in some extreme case we could have =
multiple
> > > > threads accessing given cacheline and have sc always failing. On th=
e other hand,
> > > > there are 2 arguments on that:
> > > >
> > > > 1 - Other architectures, (such as powerpc, arm and arm64 without LS=
E atomics)
> > > > also seem to rely in this mechanism for every xchg size. Another ar=
chs like csky
> > > > and loongarch use asm that look like mine to handle size < 4B xchg.
> > > >
> > > >
> > > >>  This is also something that almost no architecture
> > > >> specific code relies on (generic qspinlock being a notable excepti=
on).
> > > >>
> > > >
> > > > 2 - As you mentioned, there should be very little code that will ac=
tually make
> > > > use of xchg for vars < 4B, so it should be safe to assume its fine =
to not
> > > > guarantee forward progress for those rare usages (like some of abov=
e mentioned
> > > > archs).
> > > >
> > > >> I would recommend just dropping this patch from the series, at lea=
st
> > > >> until there is a need for it.
> > > >
> > > > While I agree this is a valid point, I believe its more interesting=
 to have it
> > > > implemented if any future mechanism wants to make use of this.
> > > >
> > > >
> > > > Thanks!
> > > > Leo
> >=20
> >=20
> >=20
> > --=20
> > Best Regards
> >  Guo Ren



--1G+VqHK18bMDBLDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNYD4AAKCRB4tDGHoIJi
0mzjAP9I84a/grioF+CwmaV5BGDLO1LDXujkNHMIBw0Tz7h+oQEA2KgImdGzanYA
k1XgIZMkhGz5oJDQ4HibU9KuHFaRzgI=
=9y9Z
-----END PGP SIGNATURE-----

--1G+VqHK18bMDBLDF--
