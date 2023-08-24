Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5307787C12
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjHXXou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjHXXok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:44:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0951FB;
        Thu, 24 Aug 2023 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692920666;
        bh=7+BnlHzMR7wvX4+PBBLlTIQX/T67NZKboN/2H8/LH28=;
        h=Date:From:To:Cc:Subject:From;
        b=awxenqeTbAoXPcB2OB423Bs+jxfK8eATBq3W4vJWOloX60ByfZIRS1AHbIINDAeq6
         uYm0/9o2I6TQGvQNsSzboNwh+odDYsZBRbSj1cuJjX2eI5oQrIb4l5M2XUSIkci5k5
         /nwVZnaukgbwKJuLdgvcyblXk2vgBWV5lBcWKANSwSwmi43JIbWoaBNy1AVM5Y/xJc
         5go95sp7CdFRzE5EdhW2lX9CefUpAMxK+QTuWHPlQxiCbAB/wNV3IXewG1uPynuzOH
         mAcmt0yl5BA00f1Lu65cG9nhcML8bOQfhk39um7OVkk5F9sga8mzbCRcONsmTXdcNe
         x3IlSoA5GU2XQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RX06f1qS9z4wxN;
        Fri, 25 Aug 2023 09:44:26 +1000 (AEST)
Date:   Fri, 25 Aug 2023 09:44:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Stafford Horne <shorne@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the openrisc tree with the mm-stable
 tree
Message-ID: <20230825094405.22d29abf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O3QLT2sfT9q_jGzjOLpUzat";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O3QLT2sfT9q_jGzjOLpUzat
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the openrisc tree got a conflict in:

  arch/openrisc/mm/ioremap.c

between commits:

  53c98e35dcbc ("openrisc: mm: remove unneeded early ioremap code")
  9b994429fe18 ("openrisc: mm: convert to GENERIC_IOREMAP")

from the mm-stable tree and commit:

  c289330331eb ("openrisc: Remove kernel-doc marker from ioremap comment")

from the openrisc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/openrisc/mm/ioremap.c
index 91c8259d4b7e,c6717f876c1c..000000000000
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@@ -22,7 -22,89 +22,7 @@@
 =20
  extern int mem_init_done;
 =20
- /**
 -static unsigned int fixmaps_used __initdata;
 -
 -/*
 - * Remap an arbitrary physical address space into the kernel virtual
 - * address space. Needed when the kernel wants to access high addresses
 - * directly.
 - *
 - * NOTE! We need to allow non-page-aligned mappings too: we will obviously
 - * have to convert them into an offset in a page-aligned mapping, but the
 - * caller shouldn't need to know that small detail.
 - */
 -void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
 -{
 -	phys_addr_t p;
 -	unsigned long v;
 -	unsigned long offset, last_addr;
 -	struct vm_struct *area =3D NULL;
 -
 -	/* Don't allow wraparound or zero size */
 -	last_addr =3D addr + size - 1;
 -	if (!size || last_addr < addr)
 -		return NULL;
 -
 -	/*
 -	 * Mappings have to be page-aligned
 -	 */
 -	offset =3D addr & ~PAGE_MASK;
 -	p =3D addr & PAGE_MASK;
 -	size =3D PAGE_ALIGN(last_addr + 1) - p;
 -
 -	if (likely(mem_init_done)) {
 -		area =3D get_vm_area(size, VM_IOREMAP);
 -		if (!area)
 -			return NULL;
 -		v =3D (unsigned long)area->addr;
 -	} else {
 -		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
 -			return NULL;
 -		v =3D fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
 -		fixmaps_used +=3D (size >> PAGE_SHIFT);
 -	}
 -
 -	if (ioremap_page_range(v, v + size, p,
 -			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
 -		if (likely(mem_init_done))
 -			vfree(area->addr);
 -		else
 -			fixmaps_used -=3D (size >> PAGE_SHIFT);
 -		return NULL;
 -	}
 -
 -	return (void __iomem *)(offset + (char *)v);
 -}
 -EXPORT_SYMBOL(ioremap);
 -
 -void iounmap(volatile void __iomem *addr)
 -{
 -	/* If the page is from the fixmap pool then we just clear out
 -	 * the fixmap mapping.
 -	 */
 -	if (unlikely((unsigned long)addr > FIXADDR_START)) {
 -		/* This is a bit broken... we don't really know
 -		 * how big the area is so it's difficult to know
 -		 * how many fixed pages to invalidate...
 -		 * just flush tlb and hope for the best...
 -		 * consider this a FIXME
 -		 *
 -		 * Really we should be clearing out one or more page
 -		 * table entries for these virtual addresses so that
 -		 * future references cause a page fault... for now, we
 -		 * rely on two things:
 -		 *   i)  this code never gets called on known boards
 -		 *   ii) invalid accesses to the freed areas aren't made
 -		 */
 -		flush_tlb_all();
 -		return;
 -	}
 -
 -	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
 -}
 -EXPORT_SYMBOL(iounmap);
 -
+ /*
   * OK, this one's a bit tricky... ioremap can get called before memory is
   * initialized (early serial console does this) and will want to alloc a =
page
   * for its mapping.  No userspace pages will ever get allocated before me=
mory

--Sig_/O3QLT2sfT9q_jGzjOLpUzat
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTn60UACgkQAVBC80lX
0GzJoQf+LTQxt2r9GEZzU3wmpw+SOoCsUXpjBH5+V7XZjP2YaRc5ma6zPMVmBBq3
Ly/Kr7a+FQ9YdZ2noJFlvx5HL+lUlzqoWUdWTUtCMHLubg98OfP1I8x5tAp/6dno
MBwo6j48nF5w4HDQAKGEZ7O0Gmqo/9KGWcnRwhYRd1+k6uJtQMoAATYwn0cL57mV
s4TjlQQJWzfhCaSXU6wanbuaX1sr9mYqImwZCeMli/D9yDgCpuBgR5GLdkFuS24c
I2orFNTjxBwTjMcWmtl4IjlUm9mPK/mbSfQBJ7Y4XVya7Z5VCHKr+KIzN7eJwQui
rmfEhtY2n1dw/562xoS/RAWwRov7uw==
=reCz
-----END PGP SIGNATURE-----

--Sig_/O3QLT2sfT9q_jGzjOLpUzat--
