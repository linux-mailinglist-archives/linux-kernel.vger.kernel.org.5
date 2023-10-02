Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD817B5775
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbjJBPjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbjJBPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:39:11 -0400
X-Greylist: delayed 83172 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Oct 2023 08:39:06 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2693;
        Mon,  2 Oct 2023 08:39:06 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 9BE981528EB4;
        Mon,  2 Oct 2023 17:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1696261142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOB88vPQiLyH370nTLoYIxokwI7a/8OLj2bT7Vxp3cw=;
        b=pWXunvHw7ykTJg5hBsOg9EX0UAyT7FxfqVQMTpPDUw0Ad3+mLwq+Vj11H1fg015DGMouCo
        HDMokGSEED/qVoVe/NscrAb22quvRHi7Y+jUpi2n0kKzJZt4v0y0NCA2RqDB8IODILxZlF
        JC4Gq82iC3zo/kynuS1cSb+zfeXbs2c=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [REGRESSION] BUG: KFENCE: memory corruption in
 drm_gem_put_pages+0x186/0x250
Date:   Mon, 02 Oct 2023 17:38:48 +0200
Message-ID: <2160215.irdbgypaU6@natalenko.name>
In-Reply-To: <ZRrUjcWqtmzPV3Fs@casper.infradead.org>
References: <13360591.uLZWGnKmhe@natalenko.name> <2300189.ElGaqSPkdT@natalenko.name>
 <ZRrUjcWqtmzPV3Fs@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13361251.uLZWGnKmhe";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13361251.uLZWGnKmhe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Matthew Wilcox <willy@infradead.org>
Date: Mon, 02 Oct 2023 17:38:48 +0200
Message-ID: <2160215.irdbgypaU6@natalenko.name>
In-Reply-To: <ZRrUjcWqtmzPV3Fs@casper.infradead.org>
MIME-Version: 1.0

On pond=C4=9Bl=C3=AD 2. =C5=99=C3=ADjna 2023 16:32:45 CEST Matthew Wilcox w=
rote:
> On Mon, Oct 02, 2023 at 01:02:52PM +0200, Oleksandr Natalenko wrote:
> > > > > > BUG: KFENCE: memory corruption in drm_gem_put_pages+0x186/0x250
> > > > > >=20
> > > > > > Corrupted memory at 0x00000000e173a294 [ ! ! ! ! ! ! ! ! ! ! ! =
! ! ! ! ! ] (in kfence-#108):
> > > > > >  drm_gem_put_pages+0x186/0x250
> > > > > >  drm_gem_shmem_put_pages_locked+0x43/0xc0
> > > > > >  drm_gem_shmem_object_vunmap+0x83/0xe0
> > > > > >  drm_gem_vunmap_unlocked+0x46/0xb0
> > > > > >  drm_fbdev_generic_helper_fb_dirty+0x1dc/0x310
> > > > > >  drm_fb_helper_damage_work+0x96/0x170
> >=20
> > Matthew, before I start dancing around, do you think ^^ could have the =
same cause as 0b62af28f249b9c4036a05acfb053058dc02e2e2 which got fixed by 8=
63a8eb3f27098b42772f668e3977ff4cae10b04?
>=20
> Yes, entirely plausible.  I think you have two useful points to look at
> before delving into a full bisect -- 863a8e and the parent of 0b62af.
> If either of them work, I think you have no more work to do.

OK, I've did this against v6.5.5:

```
git log --oneline HEAD~3..
7c1e7695ca9b8 (HEAD -> test) Revert "mm: remove struct pagevec"
8f2ad53b6eac6 Revert "mm: remove check_move_unevictable_pages()"
fa1e3c0b5453c Revert "drm: convert drm_gem_put_pages() to use a folio_batch"
```

then rebooted the host multiple times, and the issue is not seen any more.

So I guess 3291e09a463870610b8227f32b16b19a587edf33 is the culprit.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart13361251.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUa5AgACgkQil/iNcg8
M0syzg/7BciM9R4z20hUehuS7SJe83FiC1Cgucq3pMgk42d+48MZTzND3Xui+p8v
WXpF98grtGA1nzPzfBngpkwzPVHCL2Psf/mT+ea86et2jNMPtoQBJ0BQYo4DL83F
AG7VP9HRo9aPKwppoYsOnEEJmXqx1iqsHn0O89uworE0aV6aRRM4POZVsafKNjdT
vAlYmRrueMS/F6YhfjcVlPd7G4K7SQTg0glBOgWo9rY9C7Ox/oNgf1MqGcp+L/V3
2lYuFDFzj4fAHikW1zm74ujUbEXJ3FtG0knmkWcqNIjJ5yWwJk3l3birm0ni0PX6
e22IoVoShI0W9rTpDlUEPkx7OEQ6taAwadWJbKhNdBMOjdpm1BFkDCmWH4HCWOgd
o1ChU5iQfJldc50ymThnHVX5JxutVaPmNZDYWWAL9iMUdTkI0NkgqtWm5ZgaXRq3
vJbZLqWAiHxA3UqvstvrzGwX3VswbJsjDV+Lqi1I27MW+xti81I3BzBP2+kfM/0I
7bqi/XC5DboJFpNy5ac2BJdZn2ZktqAi3tkGKr4cAJViohE1/50kjAWrS+gWISOJ
8f7UivDTV+AxizGySF88gekEA9raxURl40GK7rvBvQMwi7Fd1njzRct/O4neDlaP
MlmoKVsz6VJoOuANweZqkyHyHYRALaxRGXxkE3yPXIfeWaFwGWc=
=38a+
-----END PGP SIGNATURE-----

--nextPart13361251.uLZWGnKmhe--



