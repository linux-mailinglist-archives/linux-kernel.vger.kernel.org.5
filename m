Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833927E4810
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjKGSSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjKGSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:18:05 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E3C95
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:18:03 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67543357443so6581796d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699381082; x=1699985882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WLCW16Xg7Xn8d3v2wxVZoyZyg6JSBPp7KLV1yqXGiU=;
        b=JbKjRhtnLG2Y4pajkzA+C7xwhmZWx8bGGPDHAe7bGzSlRJkGilKZgigLhDs9pt+KwJ
         SM34i7oyunY9XvEgQPtS4CEI7/KKyXfiUjmzhoUjn5XwrXrmGkxG2VJlqTSTDJszv3HB
         kGXEhhobT9g1EJhPHtilUYitw8j+Hd4XdAU1oTO+S3Gn7Q+Z94IfpK9HkAvjhxLgGizP
         Hf7Yo38tr397qAQ9VOriCoAo7W7NPTuU8AilOz/R2Qlhz3jZUVFMYK17f6xGkSPhcqlA
         OzW2NiRivhjiMmCHWF8GcCAeX2JpHprTYaOQ4FCO6z6pNuVlvl998Q/kh7JNTBXb1wk0
         MxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381082; x=1699985882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WLCW16Xg7Xn8d3v2wxVZoyZyg6JSBPp7KLV1yqXGiU=;
        b=rjVOt//yllrNJDHIpit6ii+O4ro7MOmvFU1VFgP8kJOPYIwUSZegrtKL7Vii9LYGk5
         lN2QlurTKyiEY9Oy4BvGE+KcginEW7sHgf9T6gKMJJ1k3b+KEh+ocbWqqMuP1NqSzxOr
         H75xEVuUZ694RGh3MBz5MJ1L+I9a6A80CWTQeCduhpHPNt8L9fq7GpsOMJ0N+GzHmy9+
         kduqHcJw01aLLs7gY40iQwT+utquTQooTQ8LsL7d9C7BaBuQ+kwu4Z2zzM4rn0oSaAbE
         F6LvUm8nVtdpU1DcWMFlaFKcGm0SKvlI2GrwjA7UBS5FJvb5KTa6x9YmZd3PZrVRJODz
         aZbg==
X-Gm-Message-State: AOJu0YxuFr9yNVP4mEokhBzQ3YvMzayFKyiVoVDrv/LnRs5LQ5208ndy
        pw/7v4ffvcAiI47sqIV0ovoLIGQ9B2ezbyhwis4=
X-Google-Smtp-Source: AGHT+IFLNLe5eHq2T+bIJ7tp2J+DQcG/C7vgP1l+OnPU4g55+MbHChAdPmktd6VH2aKRRtaaWOolt5BtjOhwknFj/Lw=
X-Received: by 2002:a05:6214:5ce:b0:670:b357:82bd with SMTP id
 t14-20020a05621405ce00b00670b35782bdmr29829202qvz.6.1699381082278; Tue, 07
 Nov 2023 10:18:02 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNsDLvZR8RGf9ji5938QreSix89FCpGHju+9in2x6OfDw@mail.gmail.com>
 <CADnq5_ObMvxN4pFAsWU7OM3SAtYCNHKE_fHsLqizGm0p1ubp=w@mail.gmail.com>
In-Reply-To: <CADnq5_ObMvxN4pFAsWU7OM3SAtYCNHKE_fHsLqizGm0p1ubp=w@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 7 Nov 2023 23:17:51 +0500
Message-ID: <CABXGCsPXp_pWZcyVQajYSTZKeViRqjfXK2=jmuRXh0yug_OoWQ@mail.gmail.com>
Subject: Re: 6.7/regression/KASAN: null-ptr-deref in amdgpu_ras_reset_error_count+0x2d6
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 8:29=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> Already fixed in this commit:
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/d1d4c0b7b65b7fab2bc6f=
97af9e823b1c42ccdb0
> Which is in included in last weeks PR.
>

Thanks, it fixed the issue above.
But, unfortunately this is not the only problem which I see on my laptop.
Now I am observing 100% GPU loading all the time.
And it looks as I show on this screenshot: https://postimg.cc/QHLQncMg

And another bisect round says that this commit is blame:
=E2=9D=AF git bisect good
de59b69932e64d77445d973a101d81d6e7e670c6 is the first bad commit
commit de59b69932e64d77445d973a101d81d6e7e670c6
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Wed Sep 20 13:27:58 2023 -0400

    drm/amdgpu/gmc: set a default disable value for AGP

    To disable AGP, the start needs to be set to a higher
    value than the end.  Set a default disable value for
    the AGP aperture and allow the IP specific GMC code
    to enable it selectively be calling amdgpu_gmc_agp_location().

    Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c           | 27 ++++++++++++++++---=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c        |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             |  3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 10 files changed, 37 insertions(+), 18 deletions(-)

I checked twice and ensure that it not happens on commit
29495d81457a483c2859ccde59cc063034bfe47d

--=20
Best Regards,
Mike Gavrilov.
