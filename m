Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D967B507D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbjJBKkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbjJBKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:40:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C1DBF;
        Mon,  2 Oct 2023 03:40:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690ba63891dso12692062b3a.2;
        Mon, 02 Oct 2023 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696243250; x=1696848050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9BO5D+Mkjuw7PSwT8qd3pRlmg1ZqF7ESwmXR7Zy97c=;
        b=V6DIKY09QHgbYbYx4NWHqQQm0V3JaLQOzpkeQ4Xc7GlOv2RdQX/v7VH9XiCGAsB8fn
         2beMXSRldtz5vr/ABF3zM6bzPvbt3QGt39CsN03rXnnj6wB6rrw7PkIQ/1MHbKmkwyco
         cdj5aHqAIv/gWsC6gkdIXMapqGMhubK5zRdYG9wH5b2ltDNA9Ah/m5jRQ+9/LKzcmzR5
         2GIHhQKtumMvZH1piGmObnltKZ6WPMxa8+ZhuD25CeEk1OsmvgXcuFgtG36Rm9SNNXPP
         GGQmj5TfA16kVN0MRFNQPFyDjJOjTx2nrVLwh1XPzdD/0y/q8cVruldOF3SoBUhj6TIy
         y51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696243250; x=1696848050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9BO5D+Mkjuw7PSwT8qd3pRlmg1ZqF7ESwmXR7Zy97c=;
        b=A3G+EdE0vuiDItyzueAYEFfDky4L9TcfoHv70A9Kpewj8memAlAI9zFUoXG0TJqVVw
         /8XKU/QseqPoSeP0I3opd3Z4wsLnaPFZm+eIo1Qf8kQ4t1nwRUHplurSLnzWjXrnnvxv
         ICHk6n32/nLaBF1/tiH2sXRMF1Uq51XaIMlwFekUo5sHLk7E0TdcV+BbTk6/Ze1yXSZW
         Zn6ayTA1MU++lqB5lbKB6bD8JtKACJvs40JwUYpZoo4fJs74WU1JzmyBEv2TlDuzH1YG
         c5ShFuyo+utWeP9rmb8RQN9KGwMfRIHqpWiMklfBTX+uSOR7daKqL35NTNDkecTz8ewX
         f0eA==
X-Gm-Message-State: AOJu0Yzp0l0meUFL6klQsQrw3cr/kb3G1rrY16qPgbfJ6vZplgbUfXmw
        KyYAJUh0JtfjfLKELC3KHS8=
X-Google-Smtp-Source: AGHT+IFlnNgl9H4s1s1mbNRBP7UTYC/EN207XDgHcMg4TOAVrYrNv9S3E9tLPTTfOAc6vNuU6e6xLw==
X-Received: by 2002:a05:6a20:2447:b0:14c:5fa6:e308 with SMTP id t7-20020a056a20244700b0014c5fa6e308mr10801060pzc.43.1696243249963;
        Mon, 02 Oct 2023 03:40:49 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f7d400b001c0c86a5415sm3085459plw.154.2023.10.02.03.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 03:40:49 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E92F9813713B; Mon,  2 Oct 2023 17:40:43 +0700 (WIB)
Date:   Mon, 2 Oct 2023 17:40:43 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linaro-mm-sig@lists.linaro.org,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] BUG: KFENCE: memory corruption in
 drm_gem_put_pages+0x186/0x250
Message-ID: <ZRqeK_OgfDS4liMt@debian.me>
References: <13360591.uLZWGnKmhe@natalenko.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uM8moMeUE6uskfmd"
Content-Disposition: inline
In-Reply-To: <13360591.uLZWGnKmhe@natalenko.name>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uM8moMeUE6uskfmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 06:32:34PM +0200, Oleksandr Natalenko wrote:
> Hello.
>=20
> I've got a VM from a cloud provider, and since v6.5 I observe the followi=
ng kfence splat in dmesg during boot:
>=20
> ```
> BUG: KFENCE: memory corruption in drm_gem_put_pages+0x186/0x250
>=20
> Corrupted memory at 0x00000000e173a294 [ ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! =
] (in kfence-#108):
>  drm_gem_put_pages+0x186/0x250
>  drm_gem_shmem_put_pages_locked+0x43/0xc0
>  drm_gem_shmem_object_vunmap+0x83/0xe0
>  drm_gem_vunmap_unlocked+0x46/0xb0
>  drm_fbdev_generic_helper_fb_dirty+0x1dc/0x310
>  drm_fb_helper_damage_work+0x96/0x170
>  process_one_work+0x254/0x470
>  worker_thread+0x55/0x4f0
>  kthread+0xe8/0x120
>  ret_from_fork+0x34/0x50
>  ret_from_fork_asm+0x1b/0x30
>=20
> kfence-#108: 0x00000000cda343af-0x00000000aec2c095, size=3D3072, cache=3D=
kmalloc-4k
>=20
> allocated by task 51 on cpu 0 at 14.668667s:
>  drm_gem_get_pages+0x94/0x2b0
>  drm_gem_shmem_get_pages+0x5d/0x110
>  drm_gem_shmem_object_vmap+0xc4/0x1e0
>  drm_gem_vmap_unlocked+0x3c/0x70
>  drm_client_buffer_vmap+0x23/0x50
>  drm_fbdev_generic_helper_fb_dirty+0xae/0x310
>  drm_fb_helper_damage_work+0x96/0x170
>  process_one_work+0x254/0x470
>  worker_thread+0x55/0x4f0
>  kthread+0xe8/0x120
>  ret_from_fork+0x34/0x50
>  ret_from_fork_asm+0x1b/0x30
>=20
> freed by task 51 on cpu 0 at 14.668697s:
>  drm_gem_put_pages+0x186/0x250
>  drm_gem_shmem_put_pages_locked+0x43/0xc0
>  drm_gem_shmem_object_vunmap+0x83/0xe0
>  drm_gem_vunmap_unlocked+0x46/0xb0
>  drm_fbdev_generic_helper_fb_dirty+0x1dc/0x310
>  drm_fb_helper_damage_work+0x96/0x170
>  process_one_work+0x254/0x470
>  worker_thread+0x55/0x4f0
>  kthread+0xe8/0x120
>  ret_from_fork+0x34/0x50
>  ret_from_fork_asm+0x1b/0x30
>=20
> CPU: 0 PID: 51 Comm: kworker/0:2 Not tainted 6.5.0-pf4 #1 8b557a4173114d8=
6eef7240f7a080080cfc4617e
> Hardware name: Red Hat KVM, BIOS 1.11.0-2.el7 04/01/2014
> Workqueue: events drm_fb_helper_damage_work
> ```
>=20
> This repeats a couple of times and then stops.
>=20
> Currently, I'm running v6.5.5. So far, there's no impact on how VM functi=
ons for me.
>=20
> The VGA adapter is as follows: 00:02.0 VGA compatible controller: Cirrus =
Logic GD 5446
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: v6.4..v6.5

--=20
An old man doll... just what I always wanted! - Clara

--uM8moMeUE6uskfmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRqeJgAKCRD2uYlJVVFO
o94vAQCdK24gbHlE/TSwSnvd8j9uYgtSWF/9JqsuTYcNEIa0QAEAqxCJP7ARfCvm
lDkVmrAMOBGxe7Qpk16rqel6QsVTZQQ=
=lq18
-----END PGP SIGNATURE-----

--uM8moMeUE6uskfmd--
