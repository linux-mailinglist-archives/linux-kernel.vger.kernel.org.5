Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFF876E44B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjHCJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjHCJZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:25:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587E211B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691054727; x=1722590727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wq+v2Oj+6Mxd2a//oJirAmmObJX/ETHVeQsh34JFG4Q=;
  b=T3v+bpjSEb//g/JN2G2zeMeaARkUgZSv2oZBfa4sbTCfYmwjs5KsuJJY
   EL76U6LvJXWhu9OFl8Nai7Wvx16azeWC8ncjPZhOP+W0tMuJ/kbpV46eZ
   wZIjExfCuTMzo3KILUtba3VxWiLZa58AOfz0VSodgXjKgTQMRrwNr43cx
   9XC4ayKTczs0Sp4DwMoI8dbAqGEj/U+cO5xQW7Hcl5IUaufu61G2G/jzX
   drNF4CSecdi0G9AJ9LaGvSLcGz2XwyW4r/bT6Zu3Z+jpCFcawNfSCAWw2
   v5ojOBzvUzrhukCaJ1nGwpnAcAnHNbzfGaFyVAUvVmdX4BlQ+ISfiNLBD
   g==;
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="asc'?scan'208";a="239547799"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2023 02:25:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 3 Aug 2023 02:25:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 3 Aug 2023 02:25:24 -0700
Date:   Thu, 3 Aug 2023 10:24:48 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     dylan <dylan@andestech.com>
CC:     Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
Message-ID: <20230803-stadium-unusable-6cf00e35ec22@wendy>
References: <20230725132246.817726-1-alexghiti@rivosinc.com>
 <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com>
 <ZMtv5+ut5z3pjlFJ@atctrx.andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nozptzZSf18sXWvu"
Content-Disposition: inline
In-Reply-To: <ZMtv5+ut5z3pjlFJ@atctrx.andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nozptzZSf18sXWvu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 05:14:15PM +0800, dylan wrote:
> On Sun, Jul 30, 2023 at 01:08:17AM -0400, Guo Ren wrote:
> > On Tue, Jul 25, 2023 at 9:22=E2=80=AFAM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > The RISC-V kernel needs a sfence.vma after a page table modification:=
 we
> > > used to rely on the vmalloc fault handling to emit an sfence.vma, but
> > > commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> > > vmalloc/modules area") got rid of this path for 64-bit kernels, so no=
w we
> > > need to explicitly emit a sfence.vma in flush_cache_vmap().
> > >
> > > Note that we don't need to implement flush_cache_vunmap() as the gene=
ric
> > > code should emit a flush tlb after unmapping a vmalloc region.
> > >
> > > Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for vmalloc=
/modules area")
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/cacheflush.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include=
/asm/cacheflush.h
> > > index 8091b8bf4883..b93ffddf8a61 100644
> > > --- a/arch/riscv/include/asm/cacheflush.h
> > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page *=
page)
> > >  #define flush_icache_user_page(vma, pg, addr, len) \
> > >         flush_icache_mm(vma->vm_mm, 0)
> > >
> > > +#ifdef CONFIG_64BIT
> > > +#define flush_cache_vmap(start, end)   flush_tlb_kernel_range(start,=
 end)
> > Sorry, I couldn't agree with the above in a PIPT cache machine. It's
> > not worth for.
> >=20
> > It would reduce the performance of vmap_pages_range,
> > ioremap_page_range ... API, which may cause some drivers' performance
> > issues when they install/uninstall memory frequently.
> >=20
>=20
> Hi All,
>=20
> I think functional correctness should be more important than system perfo=
rmance
> in this case. The "preventive" SFENCE.VMA became necessary due to the RIS=
C-V
> specification allowing invalidation entries to be cached in the TLB.

We are at -rc4 and this stuff is broken. Taking the bigger hammer, which
can be reverted later when a more targeted fix shows up, to make sure
that v6.5 doesn't end up broken, sounds rather prudent. Otherwise, the
original commit should probably be reverted.

> The problem[1] we are currently encountering is caused by not updating th=
e TLB
> after the page table is created, and the solution to this problem can onl=
y be
> solved by updating the TLB immediately after the page table is created.
>=20
> There are currently two possible approaches to flush TLB:
> 1. Flush TLB in flush_cache_vmap()
> 2. Flush TLB in arch_sync_kernel_mappings()
>=20
> But I'm not quite sure if it's a good idea to operate on the TLB inside f=
lush_cache_vmap().
> The name of this function indicates that it should be related to cache op=
erations, maybe
> it would be more appropriate to do TLB flush in arch_sync_kernel_mappings=
()?
>=20
> [1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August/037503.=
html


--nozptzZSf18sXWvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMtyYAAKCRB4tDGHoIJi
0u/zAP97NUn9kei7lOztrs80Kjn5bphODbu+95FYx7AzN9ltnwEAsbXegqjY7oxy
Y54cRpYdqg38D3rmo30B74v1GcEJWA0=
=imZu
-----END PGP SIGNATURE-----

--nozptzZSf18sXWvu--
