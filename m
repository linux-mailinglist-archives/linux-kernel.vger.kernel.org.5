Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE597BA52F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbjJEQOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240989AbjJEQMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:21 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6401826A40;
        Thu,  5 Oct 2023 05:31:19 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 28C07152EC14;
        Thu,  5 Oct 2023 14:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1696509072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/S7sO6RIBOF4vIV+ArsfqILLGplFRTHSIr7ucl8RgcU=;
        b=dKdsqudq0s8tzcvq9WwYKCnJB75WGj3Q+TxbsIUOt41RSK4oTHhaZpCpWTYP3GFlNrCRyl
        QjgTMW9kvm6qRUKKFdAxyeguyfc3Go1Fvitw0Vbvwnx4fPRPvj9rhbF3PEtpDMuRGBYnst
        t3efLn5VJy7aIewqLYsfbmP7Ke1Gte0=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Regressions <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
        Maxime Ripard <mripard@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Subject: Re: [REGRESSION] BUG: KFENCE: memory corruption in
 drm_gem_put_pages+0x186/0x250
Date:   Thu, 05 Oct 2023 14:30:55 +0200
Message-ID: <22037450.EfDdHjke4D@natalenko.name>
In-Reply-To: <ZR6p4MpDbQpZiUSZ@casper.infradead.org>
References: <13360591.uLZWGnKmhe@natalenko.name> <3254850.aeNJFYEL58@natalenko.name>
 <ZR6p4MpDbQpZiUSZ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7578566.EvYhyI6sBW";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7578566.EvYhyI6sBW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Matthew Wilcox <willy@infradead.org>
Date: Thu, 05 Oct 2023 14:30:55 +0200
Message-ID: <22037450.EfDdHjke4D@natalenko.name>
In-Reply-To: <ZR6p4MpDbQpZiUSZ@casper.infradead.org>
MIME-Version: 1.0

Hello.

On =C4=8Dtvrtek 5. =C5=99=C3=ADjna 2023 14:19:44 CEST Matthew Wilcox wrote:
> On Thu, Oct 05, 2023 at 09:56:03AM +0200, Oleksandr Natalenko wrote:
> > Hello.
> >=20
> > On =C4=8Dtvrtek 5. =C5=99=C3=ADjna 2023 9:44:42 CEST Thomas Zimmermann =
wrote:
> > > Hi
> > >=20
> > > Am 02.10.23 um 17:38 schrieb Oleksandr Natalenko:
> > > > On pond=C4=9Bl=C3=AD 2. =C5=99=C3=ADjna 2023 16:32:45 CEST Matthew =
Wilcox wrote:
> > > >> On Mon, Oct 02, 2023 at 01:02:52PM +0200, Oleksandr Natalenko wrot=
e:
> > > >>>>>>> BUG: KFENCE: memory corruption in drm_gem_put_pages+0x186/0x2=
50
> > > >>>>>>>
> > > >>>>>>> Corrupted memory at 0x00000000e173a294 [ ! ! ! ! ! ! ! ! ! ! =
! ! ! ! ! ! ] (in kfence-#108):
> > > >>>>>>>   drm_gem_put_pages+0x186/0x250
> > > >>>>>>>   drm_gem_shmem_put_pages_locked+0x43/0xc0
> > > >>>>>>>   drm_gem_shmem_object_vunmap+0x83/0xe0
> > > >>>>>>>   drm_gem_vunmap_unlocked+0x46/0xb0
> > > >>>>>>>   drm_fbdev_generic_helper_fb_dirty+0x1dc/0x310
> > > >>>>>>>   drm_fb_helper_damage_work+0x96/0x170
> > > >>>
> > > >>> Matthew, before I start dancing around, do you think ^^ could hav=
e the same cause as 0b62af28f249b9c4036a05acfb053058dc02e2e2 which got fixe=
d by 863a8eb3f27098b42772f668e3977ff4cae10b04?
> > > >>
> > > >> Yes, entirely plausible.  I think you have two useful points to lo=
ok at
> > > >> before delving into a full bisect -- 863a8e and the parent of 0b62=
af.
> > > >> If either of them work, I think you have no more work to do.
> > > >=20
> > > > OK, I've did this against v6.5.5:
> > > >=20
> > > > ```
> > > > git log --oneline HEAD~3..
> > > > 7c1e7695ca9b8 (HEAD -> test) Revert "mm: remove struct pagevec"
> > > > 8f2ad53b6eac6 Revert "mm: remove check_move_unevictable_pages()"
> > > > fa1e3c0b5453c Revert "drm: convert drm_gem_put_pages() to use a fol=
io_batch"
> > > > ```
> > > >=20
> > > > then rebooted the host multiple times, and the issue is not seen an=
y more.
> > > >=20
> > > > So I guess 3291e09a463870610b8227f32b16b19a587edf33 is the culprit.
> > >=20
> > > Ignore my other email. It's apparently been fixed already. Thanks!
> >=20
> > Has it? I think I was able to identify offending commit, but I'm not aw=
are of any fix to that.
>=20
> I don't understand; you said reverting those DRM commits fixed the
> problem, so 863a8eb3f270 is the solution.  No?

No-no, sorry for possible confusion. Let me explain again:

1. we had an issue with i915, which was introduced by 0b62af28f249, and lat=
er was fixed by 863a8eb3f270
2. now I've discovered another issue, which looks very similar to 1., but i=
n a VM with Cirrus VGA, and it happens even while having 863a8eb3f270 appli=
ed
3. I've tried reverting 3291e09a4638, after which I cannot reproduce the is=
sue with Cirrus VGA, but clearly there was no fix for it discussed

IOW, 863a8eb3f270 is the fix for 0b62af28f249, but not for 3291e09a4638. It=
 looks like 3291e09a4638 requires a separate fix.

Hope this gets clear.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart7578566.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUerH8ACgkQil/iNcg8
M0uSnQ/8D3tmJs/f/83sUR46G/rwqMpmxwX6gQNu0TmxXVWRtMhvcJ0aPMOFOFyd
4gIyLgpN6iwrx7q6CN4XH38pCgmbozKW1zhUC0WhUHgipOChC/levjj1yQbmPaYB
zm0JAjP39Uq7JnUgdD0JwW54kJJy5ENthILoHDWhIMIXj7DHowiNIWxD16sBvRbG
/ISVR18MvPTGL4J8M+Jj1HNWToBirW72r1xx6nO8G+rCnS/+vP6o5u/rJPoMBuKJ
fZ/6gNzSKQ5r0VYHWdOB5ye+YI6WjCDgwBSKabQW3iZ4e53LS1m0xpUrqAU4J3w3
q8CgV2cwe3ls36ihNwkJEU8dog1rJgLxphcA2Llqs3lweBi2D62EhLk3oHVsg5kD
qeEymkFsYZYxvAymu/bgu6Jf0sniYYI7UxcWvFDEijM6NJiJ9F/u0bCsriaY392E
HfGX70BX7lWVh0LXGkUgNqt1cAOthcmUGBL8SeD8vqKvqsZIv2GwqhzkuD+0lTAF
mOpICu+WgTasm7naR9xvd8gj1OXgJZcZ8wVtzqi3hek+0e4n7Bzqb1E7b0iaUlf1
SWKp+IQV6qEXmslnoMe8pYjJtTrT7fxTyZ5728wO5bakh5RzUEl99ilYA99abw19
DaPTa54wxN/HxWZmyPJ2YZWqcjbIDBBhSTY07aWvZUcrvdbHToE=
=ROyz
-----END PGP SIGNATURE-----

--nextPart7578566.EvYhyI6sBW--



