Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B07E786DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbjHXLbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbjHXLar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:30:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F95910FA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:30:45 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-50078eba7afso7523340e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692876643; x=1693481443;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASyf3JC5XyPQVGDixUt3RWgAOAA8jJHFRroqWQwv3RY=;
        b=qpWZxM2Qjloj1a+cMHGM3pQr4DDwiArvbnTdwZyhVNpDspv2WeRdlce6m4AaLzGtvY
         6CaLulniYcF0RtAdGImuUE7nj71aI1BQqSevZFdcR1X8sdoMwiLAoJF8JJJMjpCjPr/H
         Q0g1F9+VJ9woK7K1P6luuzJmMO5e5CrMNkOgcf6mJdIDyi1VTVkzz72wP4e/3ezipNdR
         qo2d1LWOEOB48ZKO8TIZ5xdNGuEKYqEIsCox+oyOh2YuI4J/4n3BIQUPpX7v30NV5kxJ
         rmE97TYM7CNRd8bdwHdqgCk6pGpVsUw4XCM6jAQSH33vPy3kAUQMr/3dEkgoRRyPskFh
         i0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876643; x=1693481443;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASyf3JC5XyPQVGDixUt3RWgAOAA8jJHFRroqWQwv3RY=;
        b=g0doQuUQ/WCs1JIIuqiX7o0bHGwzvdh3tK6sUgwMSkMywl+EDXwyD/MHbvjVeoXbxx
         A89Oy2Ast/GqSQak5Nsddk5i4O0wqhtwdShMqzcRk/ZHODXhzddbX3JL0+m2tPfjPLwY
         9Kg3+TM8V/Kn3gkvURdXhYMlOWH+5Zh8rRi2fznXyk7Pi+nM7PSIlFyV1WhCtAkAo1rn
         aT8/jUzjsEYSjoe58uCyx853lMeliX7aqsU7yQmBPj+rl75CR9rqY5i3iGLbPD4TALKq
         u+pmEBteoNpx0P7jYPW35za65SnljEVHhczxumfDbSiWyXHMTmTgRrxsspw5ZHYZbExo
         bPhA==
X-Gm-Message-State: AOJu0YxAH5zR18veKSXWWfqm//ouZGVT5Yv1kfW2x2kNQFptfzZ98UPc
        RU06jthes8ryVrnUl+Nn/bA=
X-Google-Smtp-Source: AGHT+IH4D6GfK5xg3N8hhq7h5mDdx+ATwxZUuYfEAtXL/l0B4+m8CCj/sEqnZt/7cbA9Fbt6O63yXw==
X-Received: by 2002:a05:6512:b94:b0:4ff:8c0f:a745 with SMTP id b20-20020a0565120b9400b004ff8c0fa745mr12988582lfv.54.1692876642771;
        Thu, 24 Aug 2023 04:30:42 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id v17-20020ac25611000000b004fe4ab686b4sm3110828lfd.167.2023.08.24.04.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:30:42 -0700 (PDT)
Date:   Thu, 24 Aug 2023 14:30:32 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        'Marek =?UTF-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7] drm/doc: Document DRM device reset expectations
Message-ID: <20230824143032.65d7e74a@eldfell>
In-Reply-To: <20230818200642.276735-1-andrealmeid@igalia.com>
References: <20230818200642.276735-1-andrealmeid@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I4PIBoGe6NF2KXplXhCJGSP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I4PIBoGe6NF2KXplXhCJGSP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Aug 2023 17:06:42 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Create a section that specifies how to deal with DRM device resets for
> kernel and userspace drivers.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>=20
> ---
>=20
> v7 changes:
>  - s/application/graphical API contex/ in the robustness part (Michel)
>  - Grammar fixes (Randy)
>=20
> v6: https://lore.kernel.org/lkml/20230815185710.159779-1-andrealmeid@igal=
ia.com/
>=20
> v6 changes:
>  - Due to substantial changes in the content, dropped Pekka's Acked-by
>  - Grammar fixes (Randy)
>  - Add paragraph about disabling device resets
>  - Add note about integrating reset tracking in drm/sched
>  - Add note that KMD should return failure for contexts affected by
>    resets and UMD should check for this
>  - Add note about lack of consensus around what to do about non-robust
>    apps
>=20
> v5: https://lore.kernel.org/dri-devel/20230627132323.115440-1-andrealmeid=
@igalia.com/
> ---
>  Documentation/gpu/drm-uapi.rst | 77 ++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>

It's a good introduction, even if answers to the most interesting
questions were not found yet.

Does it still answer the questions you had originally that you set out
to document?


Thanks,
pq

> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst
> index 65fb3036a580..3694bdb977f5 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -285,6 +285,83 @@ for GPU1 and GPU2 from different vendors, and a thir=
d handler for
>  mmapped regular files. Threads cause additional pain with signal
>  handling as well.
> =20
> +Device reset
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The GPU stack is really complex and is prone to errors, from hardware bu=
gs,
> +faulty applications and everything in between the many layers. Some erro=
rs
> +require resetting the device in order to make the device usable again. T=
his
> +section describes the expectations for DRM and usermode drivers when a
> +device resets and how to propagate the reset status.
> +
> +Device resets can not be disabled without tainting the kernel, which can=
 lead to
> +hanging the entire kernel through shrinkers/mmu_notifiers. Userspace rol=
e in
> +device resets is to propagate the message to the application and apply a=
ny
> +special policy for blocking guilty applications, if any. Corollary is th=
at
> +debugging a hung GPU context require hardware support to be able to pree=
mpt such
> +a GPU context while it's stopped.
> +
> +Kernel Mode Driver
> +------------------
> +
> +The KMD is responsible for checking if the device needs a reset, and to =
perform
> +it as needed. Usually a hang is detected when a job gets stuck executing=
. KMD
> +should keep track of resets, because userspace can query any time about =
the
> +reset status for a specific context. This is needed to propagate to the =
rest of
> +the stack that a reset has happened. Currently, this is implemented by e=
ach
> +driver separately, with no common DRM interface. Ideally this should be =
properly
> +integrated at DRM scheduler to provide a common ground for all drivers. =
After a
> +reset, KMD should reject new command submissions for affected contexts.
> +
> +User Mode Driver
> +----------------
> +
> +After command submission, UMD should check if the submission was accepte=
d or
> +rejected. After a reset, KMD should reject submissions, and UMD can issu=
e an
> +ioctl to the KMD to check the reset status, and this can be checked more=
 often
> +if the UMD requires it. After detecting a reset, UMD will then proceed t=
o report
> +it to the application using the appropriate API error code, as explained=
 in the
> +section below about robustness.
> +
> +Robustness
> +----------
> +
> +The only way to try to keep a graphical API context working after a rese=
t is if
> +it complies with the robustness aspects of the graphical API that it is =
using.
> +
> +Graphical APIs provide ways to applications to deal with device resets. =
However,
> +there is no guarantee that the app will use such features correctly, and=
 a
> +userspace that doesn't support robust interfaces (like a non-robust
> +OpenGL context or API without any robustness support like libva) leave t=
he
> +robustness handling entirely to the userspace driver. There is no strong
> +community consensus on what the userspace driver should do in that case,
> +since all reasonable approaches have some clear downsides.
> +
> +OpenGL
> +~~~~~~
> +
> +Apps using OpenGL should use the available robust interfaces, like the
> +extension ``GL_ARB_robustness`` (or ``GL_EXT_robustness`` for OpenGL ES)=
. This
> +interface tells if a reset has happened, and if so, all the context stat=
e is
> +considered lost and the app proceeds by creating new ones. There's no co=
nsensus
> +on what to do to if robustness is not in use.
> +
> +Vulkan
> +~~~~~~
> +
> +Apps using Vulkan should check for ``VK_ERROR_DEVICE_LOST`` for submissi=
ons.
> +This error code means, among other things, that a device reset has happe=
ned and
> +it needs to recreate the contexts to keep going.
> +
> +Reporting causes of resets
> +--------------------------
> +
> +Apart from propagating the reset through the stack so apps can recover, =
it's
> +really useful for driver developers to learn more about what caused the =
reset in
> +the first place. DRM devices should make use of devcoredump to store rel=
evant
> +information about the reset, so this information can be added to user bug
> +reports.
> +
>  .. _drm_driver_ioctl:
> =20
>  IOCTL Support on Device Nodes


--Sig_/I4PIBoGe6NF2KXplXhCJGSP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmTnP1gACgkQI1/ltBGq
qqd+qQ/9Ef0rbYI8EH7+wyhquOWEi9zaZmc/CzTCRL+XDkjUjSiw3mxvV3VIoyny
Uv17w/6y0yX9+Yd0XwgYgeIYRtNTYVGJzPyFKBeOeGLutCj1w5OZcOMrui47O91z
BEksXg2ihmB7LWIaX2nR8XLICKXOIn7rPgh4RuB8rltmX23grJm+tLVvd6VFVwNd
VddO79s7k/ouwgK6gqMJG5ERPc5FTM8mFvwSXnc0UrivcuBNSUdOW2Jk2bRDc8hg
n7WDQSK7jZHVf8swQoKj7YlDY4No7YqPORCNxgsUCWtmHFhINk/mvX5Ws0KSCDa4
rGUqJQSfzYpy4H3QRtbwBiCTwD8NeVZmaj8JLgbEPMWzYUy9zmsPcHJogbt0V+dc
UcWrlkqpbNUGVT3PSd2K9640GNu4noo3SlrIO34AYwN1byStUOTYQSiGI0LSYgBt
aatt00CkGFR2AAp2+nH2Wk8JB1/BiNuPmO9KnyVhx3/6kv5ZqEYz+8Yzr+uo6M+H
yF5FNEnuUh8RN2srWLfbBF4D7MrsRnbXD2BFkqLImTPrfbrMii5kjIulOnpfgMXP
bpMO4hyl7jRoQoLC+Ef0To6Nf4V5SyNniczBuU2rfrN+VJroyXbPZFMWTR6zOnx7
OOgkO3ggWbpbGiile5nb2fy5G1nRoXrG/0o29Vz/Lcnf4OUCh/o=
=jaoU
-----END PGP SIGNATURE-----

--Sig_/I4PIBoGe6NF2KXplXhCJGSP--
