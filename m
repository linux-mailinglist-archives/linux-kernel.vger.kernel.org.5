Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA00B7B4B62
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjJBGUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjJBGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:20:37 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE290AB;
        Sun,  1 Oct 2023 23:20:33 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 4C3141528555;
        Mon,  2 Oct 2023 08:20:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1696227627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3fQdtHTcIZFqz9pyHvM86qId7PCboP0/SwERmpmp9sI=;
        b=ONz3hpW9j8RF6uHRMXa68TnztyZYRzydfE2lxBSAEw0iZGjJQah4g7y/OA1hihmmfMifaG
        F5ngSTIh0qsF2PRoFRSjBmpHTTk6n4p26wiJ1Ow6qddOhl7GR+IymQ9YRZ9O+xwlO9ejiH
        DyXUk27v4ac8uJe1qZiUK2zyj3mUpsU=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] BUG: KFENCE: memory corruption in
 drm_gem_put_pages+0x186/0x250
Date:   Mon, 02 Oct 2023 08:20:15 +0200
Message-ID: <2701570.mvXUDI8C0e@natalenko.name>
In-Reply-To: <ZRoEqEPxPAz3QlEz@debian.me>
References: <13360591.uLZWGnKmhe@natalenko.name> <ZRoEqEPxPAz3QlEz@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12296369.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12296369.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Date: Mon, 02 Oct 2023 08:20:15 +0200
Message-ID: <2701570.mvXUDI8C0e@natalenko.name>
In-Reply-To: <ZRoEqEPxPAz3QlEz@debian.me>
MIME-Version: 1.0

Hello.

On pond=C4=9Bl=C3=AD 2. =C5=99=C3=ADjna 2023 1:45:44 CEST Bagas Sanjaya wro=
te:
> On Sun, Oct 01, 2023 at 06:32:34PM +0200, Oleksandr Natalenko wrote:
> > Hello.
> >=20
> > I've got a VM from a cloud provider, and since v6.5 I observe the follo=
wing kfence splat in dmesg during boot:
> >=20
> > ```
> > BUG: KFENCE: memory corruption in drm_gem_put_pages+0x186/0x250
> >=20
> > Corrupted memory at 0x00000000e173a294 [ ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! =
! ] (in kfence-#108):
> >  drm_gem_put_pages+0x186/0x250
> >  drm_gem_shmem_put_pages_locked+0x43/0xc0
> >  drm_gem_shmem_object_vunmap+0x83/0xe0
> >  drm_gem_vunmap_unlocked+0x46/0xb0
> >  drm_fbdev_generic_helper_fb_dirty+0x1dc/0x310
> >  drm_fb_helper_damage_work+0x96/0x170
> >  process_one_work+0x254/0x470
> >  worker_thread+0x55/0x4f0
> >  kthread+0xe8/0x120
> >  ret_from_fork+0x34/0x50
> >  ret_from_fork_asm+0x1b/0x30
> >=20
> > kfence-#108: 0x00000000cda343af-0x00000000aec2c095, size=3D3072, cache=
=3Dkmalloc-4k
> >=20
> > allocated by task 51 on cpu 0 at 14.668667s:
> >  drm_gem_get_pages+0x94/0x2b0
> >  drm_gem_shmem_get_pages+0x5d/0x110
> >  drm_gem_shmem_object_vmap+0xc4/0x1e0
> >  drm_gem_vmap_unlocked+0x3c/0x70
> >  drm_client_buffer_vmap+0x23/0x50
> >  drm_fbdev_generic_helper_fb_dirty+0xae/0x310
> >  drm_fb_helper_damage_work+0x96/0x170
> >  process_one_work+0x254/0x470
> >  worker_thread+0x55/0x4f0
> >  kthread+0xe8/0x120
> >  ret_from_fork+0x34/0x50
> >  ret_from_fork_asm+0x1b/0x30
> >=20
> > freed by task 51 on cpu 0 at 14.668697s:
> >  drm_gem_put_pages+0x186/0x250
> >  drm_gem_shmem_put_pages_locked+0x43/0xc0
> >  drm_gem_shmem_object_vunmap+0x83/0xe0
> >  drm_gem_vunmap_unlocked+0x46/0xb0
> >  drm_fbdev_generic_helper_fb_dirty+0x1dc/0x310
> >  drm_fb_helper_damage_work+0x96/0x170
> >  process_one_work+0x254/0x470
> >  worker_thread+0x55/0x4f0
> >  kthread+0xe8/0x120
> >  ret_from_fork+0x34/0x50
> >  ret_from_fork_asm+0x1b/0x30
> >=20
> > CPU: 0 PID: 51 Comm: kworker/0:2 Not tainted 6.5.0-pf4 #1 8b557a4173114=
d86eef7240f7a080080cfc4617e
> > Hardware name: Red Hat KVM, BIOS 1.11.0-2.el7 04/01/2014
> > Workqueue: events drm_fb_helper_damage_work
> > ```
> >=20
> > This repeats a couple of times and then stops.
> >=20
> > Currently, I'm running v6.5.5. So far, there's no impact on how VM func=
tions for me.
> >=20
> > The VGA adapter is as follows: 00:02.0 VGA compatible controller: Cirru=
s Logic GD 5446
> >=20
>=20
> Do you have this issue on v6.4?

No, I did not have this issue with v6.4.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart12296369.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUaYR8ACgkQil/iNcg8
M0tfyBAAnP91s5U8yswmuT3DF9ceF6Wd92FqSCJ7Sl0tmXBvCZEeGDYG+mHJroBS
vU/TynG7tClvuIbjGWMYtPY6rYpQ7R76RfzPvFVgweHxvlMgFZ4c5WWIeJ6DlaIO
uQ+MEH+lxO/kdG3J9wgnpMKwzqqozP4k80oXibP0vFeoerb/UVnk+YHtXsBollmi
kgxel8QcEZrwac33ns2JoxgDFULEoeUVAdOxrutl84ZRDhzR2RED08lnvoAVf+E7
a8rwA3FQj4tg005l6X5Dgjs2QcAxDkpZ0A/n6ZoHdnMzO+3VBGfkOqGqOVlaOqYN
cFjZ9rstkV6QA6mjAPAzoyPBASXK/jH0Aj2YAPZTSRh01H1BATbbduCp6Q/QtX4s
PlrcWRprA22wyhhRsaMBAU0fjTgs4mVmZgdfflZR98Jzdb/J9SJFIl6bDlWE72C7
l7NtFubLbuK3PsDVmvBa/r+QOLMCIZDQcDwAa+k+rn7eT+Is5CQC5YCCzL5hfyTJ
Nu2pjwVR6qDY+/OEasJj7QQvRrgDfB6Bwr6MDvj5ktT0GO17XizM/u2Jq/z+xKpa
8hqtszU5BHwIZdnt/MZTGCBghp7CoOKcV9uEUh13AKU5e0GiClb3DlpzWAhOF1KA
gPE+PNMujL5D1SQ9k8cbEPoZuq91SStdFwEnk3e1nJMWeSjmmFs=
=83J6
-----END PGP SIGNATURE-----

--nextPart12296369.O9o76ZdvQC--



