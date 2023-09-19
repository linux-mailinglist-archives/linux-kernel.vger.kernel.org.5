Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B197A6A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjISSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjISSMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:12:31 -0400
X-Greylist: delayed 17318 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 11:12:24 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0C399
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:12:24 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id E409B15061E4;
        Tue, 19 Sep 2023 20:12:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1695147140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANWqkIzAETSvA4PrqRhZdJgczKD7vgIKzAd9A12E7o0=;
        b=uC12+vlG1ciz8xeRHclk7QfuKPk8xHzApn9tbJcybu1lS5SIcZb+MLqn5YtbcFTAxya/Y0
        0NWpXlI2NodkrsUa7extOWZI5XREfW47wV01eh9fmqxD6g1nhnmX1tHkInNGHGF2Ua9sAf
        97ExXlHL4JT+ozhsiqqTqsA6D6Yi0SU=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
        Fei Yang <fei.yang@intel.com>,
        Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [REGRESSION] [BISECTED] Panic in gen8_ggtt_insert_entries() with v6.5
Date:   Tue, 19 Sep 2023 20:11:47 +0200
Message-ID: <2554845.iZASKD2KPV@natalenko.name>
In-Reply-To: <ZQnBrLCPnZfG0A1s@casper.infradead.org>
References: <4857570.31r3eYUQgx@natalenko.name> <6287208.lOV4Wx5bFT@natalenko.name>
 <ZQnBrLCPnZfG0A1s@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2258031.PYKUYFuaPT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2258031.PYKUYFuaPT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Matthew Wilcox <willy@infradead.org>
Date: Tue, 19 Sep 2023 20:11:47 +0200
Message-ID: <2554845.iZASKD2KPV@natalenko.name>
In-Reply-To: <ZQnBrLCPnZfG0A1s@casper.infradead.org>
MIME-Version: 1.0

Hello.

On =C3=BAter=C3=BD 19. z=C3=A1=C5=99=C3=AD 2023 17:43:40 CEST Matthew Wilco=
x wrote:
> On Tue, Sep 19, 2023 at 10:26:42AM +0200, Oleksandr Natalenko wrote:
> > Andrzej asked me to try to revert commits 0b62af28f249, e0b72c14d8dc an=
d 1e0877d58b1e, and reverting those fixed the i915 crash for me. The e0b72c=
14d8dc and 1e0877d58b1e commits look like just prerequisites, so I assume 0=
b62af28f249 ("i915: convert shmem_sg_free_table() to use a folio_batch") is=
 the culprit here.
> >=20
> > Could you please check this?
> >=20
> > Our conversation with Andrzej is available at drm-intel GitLab [1].
> >=20
> > Thanks.
> >=20
> > [1] https://gitlab.freedesktop.org/drm/intel/-/issues/9256
>=20
> Wow, that is some great debugging.  Thanks for all the time & effort
> you and others have invested.  Sorry for breaking your system.
>=20
> You're almost right about the "prerequisites", but it's in the other
> direction; 0b62af28f249 is a prerequisite for the later two cleanups,
> so reverting all three is necessary to test 0b62af28f249.
>=20
> It seems to me that you've isolated the problem to constructing overly
> long sg lists.  I didn't realise that was going to be a problem, so
> that's my fault.
>=20
> Could I ask you to try this patch?  I'll follow up with another patch
> later because I think I made another assumption that may not be valid.

I can confirm this one fixes the issue for me on T460s laptop. Thank you!

Should you submit it, please add:

=46ixes: 0b62af28f2 ("i915: convert shmem_sg_free_table() to use a folio_ba=
tch")
Cc: stable@vger.kernel.org # 6.5.x
Link: https://gitlab.freedesktop.org/drm/intel/-/issues/9256
Link: https://lore.kernel.org/lkml/6287208.lOV4Wx5bFT@natalenko.name/
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 8f1633c3fb93..73a4a4eb29e0 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -100,6 +100,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  	st->nents =3D 0;
>  	for (i =3D 0; i < page_count; i++) {
>  		struct folio *folio;
> +		unsigned long nr_pages;
>  		const unsigned int shrink[] =3D {
>  			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
>  			0,
> @@ -150,6 +151,8 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  			}
>  		} while (1);
> =20
> +		nr_pages =3D min_t(unsigned long,
> +				folio_nr_pages(folio), page_count - i);
>  		if (!i ||
>  		    sg->length >=3D max_segment ||
>  		    folio_pfn(folio) !=3D next_pfn) {
> @@ -157,13 +160,13 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  				sg =3D sg_next(sg);
> =20
>  			st->nents++;
> -			sg_set_folio(sg, folio, folio_size(folio), 0);
> +			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
>  		} else {
>  			/* XXX: could overflow? */
> -			sg->length +=3D folio_size(folio);
> +			sg->length +=3D nr_pages * PAGE_SIZE;
>  		}
> -		next_pfn =3D folio_pfn(folio) + folio_nr_pages(folio);
> -		i +=3D folio_nr_pages(folio) - 1;
> +		next_pfn =3D folio_pfn(folio) + nr_pages;
> +		i +=3D nr_pages - 1;
> =20
>  		/* Check that the i965g/gm workaround works. */
>  		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >=3D 0x00100000UL);

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart2258031.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUJ5GMACgkQil/iNcg8
M0ttQg/+KmoVERiaxpyxpfy0WkGob59zl5yPYXkdu8yziS+9IpKShcZITNzicm/S
icxeaKjgAKvdEksTLEOHYwFCu3D9Fsdkjq0y/fwJPI95nXx5Rc7Fqe9AylXDlweZ
CLX/dxs3tyyKAco+qd6LUVsrUY1WnBV0HhnUQgi+UCURrsOTq9v9BJVV7mtkVL8t
ILhxPuXR/JN40BlElEtPtbjAhfNcywz/SkImsRK8vMVa14jTbtPlTvR6Y3nZhWV4
DPFLzBPGDe6VeM4sRAHGDXeSq3ShrkdnRsVUeRrl+fCGEXL8Ntd5n2Quw1Bbu5YU
ZwQxkGPt2nDZYXMA9YpT8Xs2ezZfAysbSeNPwdvE2wUO12UJsiZh/nxkTDMVY7cn
WnsoF5JgSiloR4eBEPF2OpHmL1Lx6wMjL1Y0FvNfX/POUw9wIdlIfObXjaneNZ1D
8UlKb+s2KTCZGso65TNEwUi8kha2l4uVu/KqYvo1NMIjB/e6P3l0FxPokxRcIs6+
nvC0hGWcPaAWru8xx7bTSCfavNlXGinidLCEKR55Umq8DurVm6dXkFtCMtYrkDUB
S/xKO5hvYkRZT24kKdFhTUoKVqpatOjJe0B79wKOBHoKThXCYYUSHIDoVhHcqQ/r
q/g1/BjxCYj4Fpnhw+QfRNmm427bBL8Gn1ciL4ie8Ezfs69lSoM=
=4cF8
-----END PGP SIGNATURE-----

--nextPart2258031.PYKUYFuaPT--



