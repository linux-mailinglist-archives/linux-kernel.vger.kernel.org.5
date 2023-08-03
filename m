Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A4576E536
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjHCKGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHCKGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:06:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D65FC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691057163; x=1722593163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aOqpJ84Ym1QwOIt6SBmTi8DnDwzr1ZYox/0f92CTJp8=;
  b=a7HMRDuc4RErmGfROhlZ12FikF6zOThjNDzWU+fuiXqVI059Cq2NVRsS
   ZfSsjGWg7ViGba5VaOAO4cOmRfOEQLPqKMVeDw3vMgHBN+nA0DFrgoxHI
   F7lsgMrmyMf7p2TuU/0bF73iMhHkp8ySfUsujwWGu1219dfuI0A+qqBwD
   5IgGsPmenNi0RwpFxppS5NWCklk08KaTAWu0kDRsNFV3zEJ2deeSiSFY2
   2t9TceRs5mWlurUZo2Oc+u01MW5E2LsQPM/xICO13gkZsW/jqWu57BKqD
   AoIxfqCIg/GIMg/ZdXiCtKcxN+gFBUa9djWOvIy2SFhQqDI3P4r7jsTuI
   w==;
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="asc'?scan'208";a="226932287"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2023 03:06:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 3 Aug 2023 03:05:58 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 3 Aug 2023 03:05:56 -0700
Date:   Thu, 3 Aug 2023 11:05:20 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     dylan <dylan@andestech.com>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
Message-ID: <20230803-chatty-scorpion-0311b40b915b@wendy>
References: <20230725132246.817726-1-alexghiti@rivosinc.com>
 <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com>
 <ZMtv5+ut5z3pjlFJ@atctrx.andestech.com>
 <20230803-stadium-unusable-6cf00e35ec22@wendy>
 <CAHVXubiz-7LaxCJLW=-ekr7TBFswXojr1ODU4mo59Z1OBmjieg@mail.gmail.com>
 <CAHVXubg_7GwsdVpA_tPNYk2PUuQVheSfa31YbQPJg46enh2cfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wgEZWvV03h9AGeOU"
Content-Disposition: inline
In-Reply-To: <CAHVXubg_7GwsdVpA_tPNYk2PUuQVheSfa31YbQPJg46enh2cfQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--wgEZWvV03h9AGeOU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 11:58:41AM +0200, Alexandre Ghiti wrote:
> On Thu, Aug 3, 2023 at 11:48=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > On Thu, Aug 3, 2023 at 11:25=E2=80=AFAM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > >
> > > On Thu, Aug 03, 2023 at 05:14:15PM +0800, dylan wrote:
> > > > On Sun, Jul 30, 2023 at 01:08:17AM -0400, Guo Ren wrote:
> > > > > On Tue, Jul 25, 2023 at 9:22=E2=80=AFAM Alexandre Ghiti <alexghit=
i@rivosinc.com> wrote:
> > > > > >
> > > > > > The RISC-V kernel needs a sfence.vma after a page table modific=
ation: we
> > > > > > used to rely on the vmalloc fault handling to emit an sfence.vm=
a, but
> > > > > > commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> > > > > > vmalloc/modules area") got rid of this path for 64-bit kernels,=
 so now we
> > > > > > need to explicitly emit a sfence.vma in flush_cache_vmap().
> > > > > >
> > > > > > Note that we don't need to implement flush_cache_vunmap() as th=
e generic
> > > > > > code should emit a flush tlb after unmapping a vmalloc region.
> > > > > >
> > > > > > Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for v=
malloc/modules area")
> > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/cacheflush.h | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/i=
nclude/asm/cacheflush.h
> > > > > > index 8091b8bf4883..b93ffddf8a61 100644
> > > > > > --- a/arch/riscv/include/asm/cacheflush.h
> > > > > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > > > > @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct =
page *page)
> > > > > >  #define flush_icache_user_page(vma, pg, addr, len) \
> > > > > >         flush_icache_mm(vma->vm_mm, 0)
> > > > > >
> > > > > > +#ifdef CONFIG_64BIT
> > > > > > +#define flush_cache_vmap(start, end)   flush_tlb_kernel_range(=
start, end)
> > > > > Sorry, I couldn't agree with the above in a PIPT cache machine. I=
t's
> > > > > not worth for.
> > > > >
> > > > > It would reduce the performance of vmap_pages_range,
> > > > > ioremap_page_range ... API, which may cause some drivers' perform=
ance
> > > > > issues when they install/uninstall memory frequently.
> > > > >
> > > >
> > > > Hi All,
> > > >
> > > > I think functional correctness should be more important than system=
 performance
> > > > in this case. The "preventive" SFENCE.VMA became necessary due to t=
he RISC-V
> > > > specification allowing invalidation entries to be cached in the TLB.
> > >
> > > We are at -rc4 and this stuff is broken. Taking the bigger hammer, wh=
ich
> > > can be reverted later when a more targeted fix shows up, to make sure
> > > that v6.5 doesn't end up broken, sounds rather prudent. Otherwise, the
> > > original commit should probably be reverted.
> >
> > The original commit that removed vmalloc_fault() is required, handling
> > vmalloc faults in the page fault path is not possible (see the links
> > in the description of 7d3332be011e and the example that I gave in the
> > thread https://lore.kernel.org/linux-riscv/dc26625b-6658-c078-76d2-7e97=
5a04b1d4@ghiti.fr/).
>=20
> Actually the problem was there before this commit (Dylan has the issue
> in 6.1), so no faulty commit to revert :)

Ah, my bad - I was focusing on 7d3332be011e ("riscv: mm: Pre-allocate PGD
entries for vmalloc/modules area") from your commit message. Big hammer,
followed by tweaks or a replacement sounds like the way forward to me
so!

Cheers,
Conor.

> > I totally agree with Dylan that we'll work (I'm currently working on
> > that) on the performance side of the problem in the next release, we
> > need correctness and for that we need a preventive global sfence.vma
> > as we have no means (for now) to distinguish between uarch that cache
> > or not invalid entries.
> >
> > >
> > > > The problem[1] we are currently encountering is caused by not updat=
ing the TLB
> > > > after the page table is created, and the solution to this problem c=
an only be
> > > > solved by updating the TLB immediately after the page table is crea=
ted.
> > > >
> > > > There are currently two possible approaches to flush TLB:
> > > > 1. Flush TLB in flush_cache_vmap()
> > > > 2. Flush TLB in arch_sync_kernel_mappings()
> > > >
> > > > But I'm not quite sure if it's a good idea to operate on the TLB in=
side flush_cache_vmap().
> > > > The name of this function indicates that it should be related to ca=
che operations, maybe
> > > > it would be more appropriate to do TLB flush in arch_sync_kernel_ma=
ppings()?
> >
> > TLDR: The downsides to implementing arch_sync_kernel_mappings()
> > instead of flush_cache_vmap():
> >
> > - 2 global flushes for vunmap instead of 1 for flush_cache_vmap()
> > - flushes the tlb in the noflush suffixed functions so it prevents any
> > flush optimization (ie: a loop of vmap_range_noflush() without flush
> > and then a final flush afterwards)
> >
> > So I'd favour the flush_cache_vmap() implementation which seems
> > lighter. powerpc does that
> > https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm=
/cacheflush.h#L27
> > (but admits that it may not be the right place)
> >
> > Here is the long story (my raw notes):
> >
> > * arch_sync_kernel_mappings() is called from:
> > - _apply_to_page_range(): would only emit global sfence.vma if vmalloc
> > addresses, I guess that's ok.
> > - __vunmap_range_noflush(): it is noted here
> > https://elixir.bootlin.com/linux/latest/source/mm/vmalloc.c#L406 that
> > any caller must call flush_tlb_kernel_range(). Then the implementation
> > of arch_sync_kernel_mappings() would result in 2 global tlb flushes.
> > - vmap_range_noflush(): does not fit well with the noflush() suffix.
> >
> > * flush_cache_vmap() is called from:
> > - kasan_populate_vmalloc(): legit since it bypasses vmap api (but
> > called right a apply_to_page_range() so your patch would work here)
> > - kmsan_vunmap_range_noflush(): called twice for the mappings kmsan
> > establishes and flush_tlb_kernel_range() must be called afterwards =3D>
> > 3 global tlb flushes but the 3 are needed as they target different
> > addresses. Implementing only arch_sync_kernel_mappings() would result
> > in way more global flushes (see the loop here
> > https://elixir.bootlin.com/linux/latest/source/mm/kmsan/hooks.c#L151
> > where  __vmap_pages_range_noflush() would result in more
> > flush_tlb_all())
> > - kmsan_vmap_pages_range_noflush(): here we would flush twice, but
> > same thing for the arch_sync_kernel_mappings() implementation.
> > - ioremap_page_range(): legit, same as arch_sync_kernel_mappings()
> > implementation.
> > - vmap_pages_range(): legit, same as arch_sync_kernel_mappings() implem=
entation.
> >
> > Let me know what you think!
> >
> > Alex
> >
> > > >
> > > > [1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August/0=
37503.html
> > >

--wgEZWvV03h9AGeOU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMt74AAKCRB4tDGHoIJi
0n9AAP9p8wSLc34+foGsl1TI2vO9fjUdR9X21aZKeqBsiZYk4gEApOS7Mpbacvcn
kOBIpwMehsrvBZ3u1ifukyTc5xYqEwQ=
=5rST
-----END PGP SIGNATURE-----

--wgEZWvV03h9AGeOU--
