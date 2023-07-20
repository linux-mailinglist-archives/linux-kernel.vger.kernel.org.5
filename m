Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F6375ABA0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjGTKDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGTKDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7FB7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689847337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJqbwcpKpzwPfyG3YY4y4NKa/rYO72LYoQWc/nRB+o0=;
        b=IIW4rB5183vpNLsdg72Ly/IpnqMp7/tX/nLIIOreuQ+10HGLL78mAgsW1hvhUrBBRzHY3F
        UxTFjIoHpODvqYfTHrNkuhIfcYAxGF79DmTgCWUwbuytFzcOu+QSjvuNzqlwOZqdqf8ttG
        c4s60etTQcwVWJlJzEkfkxniG0pH6LM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-ZarbtGt9Oaq-zEmVx4Z6QA-1; Thu, 20 Jul 2023 06:02:15 -0400
X-MC-Unique: ZarbtGt9Oaq-zEmVx4Z6QA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-403aa5cca80so8212741cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689847335; x=1690452135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJqbwcpKpzwPfyG3YY4y4NKa/rYO72LYoQWc/nRB+o0=;
        b=U1HgnQJ1wILCykKBZ/tZRxztPLmks6AbTVhQF29+tCa1BO1PzwsXfeZd6yWSVJNddA
         qGWbEJWCcuy3LcZIBo1I2R04RMzAer+jOzv2UTS/TrS0BMuNZxXgieydT/+BarEuPm5x
         gSSk3Ez7HEDTzj2zER2lLD6xm6QO0HunzUClTwDj1sbr2P8z5KSzfYaPwNswDMsnugjJ
         aU8YFNUask7AhjCzSXErfz6Z5saNtiTHSxycsFKb7/UhmV8soQpqB2Msyjz0d4fEolHc
         mSv8slSmVpciMz/TLLpbMNpH/WXK/1c5ooc0JVtVlgzC9ydAKLlWyb6EoREALRu/mR3g
         XiDA==
X-Gm-Message-State: ABy/qLZGNMOpwE+P+6o34bLRZT4uT6mOQl1Tv6YHj+fkTNUd6iy/q/Vt
        qZCbCGcYeFaahOao4V8pEGJHjaHqsh07DULN3wNZnxc9ZJcYfF9x/z7YLDrHGXarveHJp4Ia7bu
        2g9/Y8rmOzk2MRzBw9tZYaChTpafmXJI4qUM=
X-Received: by 2002:a05:622a:1805:b0:400:9a53:75d2 with SMTP id t5-20020a05622a180500b004009a5375d2mr24445694qtc.18.1689847334806;
        Thu, 20 Jul 2023 03:02:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEueH+j6ORrxZFhAXhiVK6nEIkbqbyb11QsjbwMYGrPWVDKS0lWgmf3hbPTLv9WE3yd3Wg8BA==
X-Received: by 2002:a05:622a:1805:b0:400:9a53:75d2 with SMTP id t5-20020a05622a180500b004009a5375d2mr24445677qtc.18.1689847334529;
        Thu, 20 Jul 2023 03:02:14 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id cr19-20020a05622a429300b0040335131048sm189838qtb.93.2023.07.20.03.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 03:02:14 -0700 (PDT)
Date:   Thu, 20 Jul 2023 12:02:12 +0200
From:   Maxime Ripard <mripard@redhat.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3] drm/ssd130x: Fix an oops when attempting to update a
 disabled plane
Message-ID: <c5khbm4v2ynjgcfhin2htixkyuycfydr6rie5irnyu6gytxg6q@4ghg4ufjgnfx>
References: <20230717163027.480918-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qe3hblf2skw3xamx"
Content-Disposition: inline
In-Reply-To: <20230717163027.480918-1-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qe3hblf2skw3xamx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 17, 2023 at 06:30:22PM +0200, Javier Martinez Canillas wrote:
> Geert reports that the following NULL pointer dereference happens for him
> after commit 49d7d581ceaf ("drm/ssd130x: Don't allocate buffers on each
> plane update"):
>=20
>     [drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
>     ssd130x-i2c 0-003c: [drm] surface width(128), height(32), bpp(1)
>     and format(R1   little-endian (0x20203152))
>     Unable to handle kernel NULL pointer dereference at virtual address 0=
0000000
>     Oops [#1]
>     CPU: 0 PID: 1 Comm: swapper Not tainted
>     6.5.0-rc1-orangecrab-02219-g0a529a1e4bf4 #565
>     epc : ssd130x_update_rect.isra.0+0x13c/0x340
>      ra : ssd130x_update_rect.isra.0+0x2bc/0x340
>     ...
>     status: 00000120 badaddr: 00000000 cause: 0000000f
>     [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
>     [<c0304200>] ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
>     [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
>     [<c02f9314>] drm_atomic_helper_commit_tail+0x5c/0xb4
>     [<c02f94fc>] commit_tail+0x190/0x1b8
>     [<c02f99fc>] drm_atomic_helper_commit+0x194/0x1c0
>     [<c02c5d00>] drm_atomic_commit+0xa4/0xe4
>     [<c02cce40>] drm_client_modeset_commit_atomic+0x244/0x278
>     [<c02ccef0>] drm_client_modeset_commit_locked+0x7c/0x1bc
>     [<c02cd064>] drm_client_modeset_commit+0x34/0x64
>     [<c0301a78>] __drm_fb_helper_restore_fbdev_mode_unlocked+0xc4/0xe8
>     [<c0303424>] drm_fb_helper_set_par+0x38/0x58
>     [<c027c410>] fbcon_init+0x294/0x534
>     ...
>=20
> The problem is that fbcon calls fbcon_init() which triggers a DRM modeset
> and this leads to drm_atomic_helper_commit_planes() attempting to commit
> the atomic state for all planes, even the ones whose CRTC is not enabled.
>=20
> Since the primary plane buffer is allocated in the encoder .atomic_enable
> callback, this happens after that initial modeset commit and leads to the
> mentioned NULL pointer dereference.

I think that's where the problem lies: you must not allocate a buffer in
atomic_enable.

After drm_atomic_helper_swap_state(), the new commit is being applied
and you aren't allowed to fail, and an allocation can fail.

Everything needs to be prepared by the time _swap_state is called, and
it's one of the point of atomic_check.

So you need to allocate your buffer there, and use it in whatever
atomic_commit related hook you need it in.

The typical way of doing this would be to create a custom state
structure that embeds the global one, create your own reset,
atomic_duplicate_state and atomic_destroy_state implementations, and
store the buffer pointer there.

Maxime

--qe3hblf2skw3xamx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLkGJAAKCRDj7w1vZxhR
xb3DAP467ZC4xwaMcpeAN/JCF36jZ/w3OkV6Wp2IWhvd6gjJMAEA4vwpEJdb9z9S
vJgNVFAAGlad6ZeJTgQ4tMs+SozE5gA=
=5vxz
-----END PGP SIGNATURE-----

--qe3hblf2skw3xamx--

