Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312BD7B4A5E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 01:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjJAXpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 19:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJAXpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 19:45:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A19C6;
        Sun,  1 Oct 2023 16:45:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6907e44665bso14392472b3a.1;
        Sun, 01 Oct 2023 16:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696203948; x=1696808748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vvjOV/SJHwlBfuAQ9Hpu2fBDMywi9nmiPQcO1/0180=;
        b=DbhSQ4XhZmfeaTYZ+RKIL6/q9nQXdpoyxGhalDGkCENhIV0+xU2CbM8Vl9A/4RzeZY
         H673NFnlU376pUoCDWTiEn1NYg4YiEcclcYLrVhg2t4ZX6XUtW2tF6YkPc7kjqwRSSQO
         DMtlKjn743GVkFFzCOGE6bEgKPSCUtjfSd2QO4y59/wy6QElj8kAdlW6Vk0uxDnyha0i
         lBhAf3kr6w+vn0CJYkWeWJTs/6gXevwTI9CifNF8HuhOmHQLuyEW7rNNvQWJqLX/wjQg
         s2qXg8/keW+ox/2wDNaz1eysTK1ag/A0a/Ri4ZWINzJ1lQpP8oK2407iAL9yVe7TrH3D
         tZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696203948; x=1696808748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vvjOV/SJHwlBfuAQ9Hpu2fBDMywi9nmiPQcO1/0180=;
        b=buQ3JiStUbU2/qtSxHlucG0heWWWSP/jImLRO0d3BsrSxZzBNLkFBXnTPmkXzXyGCF
         PYqZD7bh+XdHyiOwbU6pGDI4p0DIpDCiP2F4PR7IVpL9IaA/c5YwXlLNmgSIQQxThVZC
         4k3bl5me+uev/dVjDr9y62CwgymhMVxhpa8KvPbPo4+HqIIKWg+DpxWDviIQ6KycfNKp
         pZJl4WdUgFjHWV/QlQF/fAdfOtHKppc14lEIGXkKjl+7R0S+BKwdyxKw9CZqKLJfjuuM
         HM6fr+Hrt5fPZVLl274XsGEQ7B1mvpNNVZK2gYXAVFg2TaSzT0neOxMkihTL/HESQwph
         +npg==
X-Gm-Message-State: AOJu0YxNoRZ+HTpmNl7vITetufwcTUi7bCcVC1b8HOMYAKIeCffCViV5
        0eweIqwQlBZ/uBk2G1gbEBW3zMdY4/0=
X-Google-Smtp-Source: AGHT+IHz8QtBxh5UpcXHxqq1V7wU5Le8vKu+zUqpAxF2dUNjqVwWaUCWgNdN7SxncLebsJNcFYx8tQ==
X-Received: by 2002:a05:6a00:982:b0:68e:36bc:194a with SMTP id u2-20020a056a00098200b0068e36bc194amr13053460pfg.15.1696203948274;
        Sun, 01 Oct 2023 16:45:48 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id f1-20020aa782c1000000b0069305627494sm10416369pfn.165.2023.10.01.16.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 16:45:47 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0070F8017C4F; Mon,  2 Oct 2023 06:45:44 +0700 (WIB)
Date:   Mon, 2 Oct 2023 06:45:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org,
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
Message-ID: <ZRoEqEPxPAz3QlEz@debian.me>
References: <13360591.uLZWGnKmhe@natalenko.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yoF7gxy4SjBfUd1U"
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


--yoF7gxy4SjBfUd1U
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

Do you have this issue on v6.4?

--=20
An old man doll... just what I always wanted! - Clara

--yoF7gxy4SjBfUd1U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRoEoAAKCRD2uYlJVVFO
o9s5AP9kGuHk47ES1xM3sSRWMksEAyOgSfb9PPRtW2GW6eLYrwEAncNNUUPjdgsp
of+ra71dF0EDOM0682RgxNmO1A/YTQw=
=/Uxd
-----END PGP SIGNATURE-----

--yoF7gxy4SjBfUd1U--
