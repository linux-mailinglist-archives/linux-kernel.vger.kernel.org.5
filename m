Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10E17B9FC5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjJEO3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjJEO1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:27:44 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06B583D6;
        Thu,  5 Oct 2023 00:56:24 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id A74A5152DF11;
        Thu,  5 Oct 2023 09:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1696492577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qLErRg+IY+M+tMiWfSLlVJCQY74BdF5SCkyderIHIa0=;
        b=h7xrC5PkklBLzvH13lJaXipMzYLk7ODNLFPeypzjuPHUyCP+2NbcQ+lR7VinR5D68csHYC
        ER5lSQNMZ1BujtcDRgS1EEmaOkSp5YuOTsVmySu1ONKkk1UjK2aNxkLw21T5v35ccRaPjP
        ET8Ej0R8oBGTFKEcgEr9SS7Use/bjM4=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Matthew Wilcox <willy@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Linux Regressions <regressions@lists.linux.dev>,
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
Date:   Thu, 05 Oct 2023 09:56:03 +0200
Message-ID: <3254850.aeNJFYEL58@natalenko.name>
In-Reply-To: <fed1cbf3-0926-4895-a8ba-d6fa9fd53dbe@suse.de>
References: <13360591.uLZWGnKmhe@natalenko.name> <2160215.irdbgypaU6@natalenko.name>
 <fed1cbf3-0926-4895-a8ba-d6fa9fd53dbe@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3261088.44csPzL39Z";
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

--nextPart3261088.44csPzL39Z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Thu, 05 Oct 2023 09:56:03 +0200
Message-ID: <3254850.aeNJFYEL58@natalenko.name>
In-Reply-To: <fed1cbf3-0926-4895-a8ba-d6fa9fd53dbe@suse.de>
MIME-Version: 1.0

Hello.

On =C4=8Dtvrtek 5. =C5=99=C3=ADjna 2023 9:44:42 CEST Thomas Zimmermann wrot=
e:
> Hi
>=20
> Am 02.10.23 um 17:38 schrieb Oleksandr Natalenko:
> > On pond=C4=9Bl=C3=AD 2. =C5=99=C3=ADjna 2023 16:32:45 CEST Matthew Wilc=
ox wrote:
> >> On Mon, Oct 02, 2023 at 01:02:52PM +0200, Oleksandr Natalenko wrote:
> >>>>>>> BUG: KFENCE: memory corruption in drm_gem_put_pages+0x186/0x250
> >>>>>>>
> >>>>>>> Corrupted memory at 0x00000000e173a294 [ ! ! ! ! ! ! ! ! ! ! ! ! =
! ! ! ! ] (in kfence-#108):
> >>>>>>>   drm_gem_put_pages+0x186/0x250
> >>>>>>>   drm_gem_shmem_put_pages_locked+0x43/0xc0
> >>>>>>>   drm_gem_shmem_object_vunmap+0x83/0xe0
> >>>>>>>   drm_gem_vunmap_unlocked+0x46/0xb0
> >>>>>>>   drm_fbdev_generic_helper_fb_dirty+0x1dc/0x310
> >>>>>>>   drm_fb_helper_damage_work+0x96/0x170
> >>>
> >>> Matthew, before I start dancing around, do you think ^^ could have th=
e same cause as 0b62af28f249b9c4036a05acfb053058dc02e2e2 which got fixed by=
 863a8eb3f27098b42772f668e3977ff4cae10b04?
> >>
> >> Yes, entirely plausible.  I think you have two useful points to look at
> >> before delving into a full bisect -- 863a8e and the parent of 0b62af.
> >> If either of them work, I think you have no more work to do.
> >=20
> > OK, I've did this against v6.5.5:
> >=20
> > ```
> > git log --oneline HEAD~3..
> > 7c1e7695ca9b8 (HEAD -> test) Revert "mm: remove struct pagevec"
> > 8f2ad53b6eac6 Revert "mm: remove check_move_unevictable_pages()"
> > fa1e3c0b5453c Revert "drm: convert drm_gem_put_pages() to use a folio_b=
atch"
> > ```
> >=20
> > then rebooted the host multiple times, and the issue is not seen any mo=
re.
> >=20
> > So I guess 3291e09a463870610b8227f32b16b19a587edf33 is the culprit.
>=20
> Ignore my other email. It's apparently been fixed already. Thanks!

Has it? I think I was able to identify offending commit, but I'm not aware =
of any fix to that.

Thanks.

> Best regards
> Thomas
>=20
> >=20
> > Thanks.
> >=20
>=20
> --=20
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart3261088.44csPzL39Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUebBMACgkQil/iNcg8
M0tJ/Q/9FPtmZXPGSlNkh2qFBHnyONCuzzj6LT+47+l6Fm7nsJgSnF74o/yV/pMh
q7vpMK9rD5WvRyb5fgLxv+qfYz0t09dnOs5K+ZMjpLdeM5GMp78fFB1E/HOUAADx
JjTDrWvykfLEDoTBnZedZjxZTaHeR8b0wLvh9f9tF4Z25jeYvy9zWFDueXX97rBo
/VxH88ZCRlNwFstWH8qwa6W6DP2hiSb4osfYsftRib0xU3Gu1fNKrsWyw95VfeTd
ReiHGad9mQ4Y1AN3Ff9NeoT6/rM/2rG7h6xSgvsVrt1MAw/iwW24bH1lKUe+5f1k
fgR7nv6flGS4FF7zZ+deiI+dUaiyt1urG1zZh5U6VhzzW2VandPoTJHE+L1kT8WF
kAEsYCwRV2v0lw0YL9JhIPhDgCOT7pLWsIXmZXUKnr7IcR7cGwBPMNYpgxgpYyj0
YqujL4hPU64n46AHLaVlHBAsXO0CLgDqDJjgfbsiWe15XPnAkq0bm8QJRLBjTM0M
7Z6yr0eiGA1cdZtu8wgwen7ZEH94Lq2aBPhHAhSjSqWLlGJunN/aNSi6u3dVGy4h
ag1vpbsw2un3WU97sd3AjDunpUn01rk0GiyCWjraCbAyFAQKyVNgdonMGcV5wzX4
fTHWSuLNytga3UcQ/hCYxldyK/iT/HkFV37Z/aKGJX752dw9KNA=
=eWGs
-----END PGP SIGNATURE-----

--nextPart3261088.44csPzL39Z--



