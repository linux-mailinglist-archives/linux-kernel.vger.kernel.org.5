Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE31751A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjGMHwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjGMHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:51:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17793173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:51:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so733547e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689234714; x=1691826714;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4oZ68SaUqVH0D2Zc2sc1Hk+yQM9B+LeCSgmzfoPq70g=;
        b=oLIosKjpSzUdO2vaCQ859Xx47UjYRIJS9O0weHTp9nHxlFc4so+UTfBg0hxgvcsq4B
         dBQz5S0k8c2TUeWyFCks8AMzoHnKUoSEV4nGq2D9uRST09/hj5WIeGhQQTl7TbU0tkKp
         jusb4g3wdGG9PgclqInX9tSEDpsHh9Jk6q8XgZpLcqbsy17Balj019pXJRmF2Nllg6ue
         jiooqz3sfYbUqLs3zYsHg28FPRgrWoJG9WSvfnRyJlH5XZ9d5E1U3DfPIIjNO5AffJV5
         NA/gZPlKYPF4aF5ei2vqwsxk4GV3imoe4GGWVQ49rzChwdgxzfioDjwPSrtKndURVcfw
         cXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689234714; x=1691826714;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oZ68SaUqVH0D2Zc2sc1Hk+yQM9B+LeCSgmzfoPq70g=;
        b=I/mDSD+D+lHbgbXIsRI2pgURJKJRgz0K9VAx8xGgvVJMaSvDyIIz/XadwymQipbnk4
         Ol4QDJKVlRwbeM67lcWCdt2858bjMCSMSl2SC6Tg365TJtP3lKWfr19Tum98pdqbJt9X
         d0vj9G21NJ/J+S9Y3kSF1gOdBmTChV4t00CtzomrhIjaE/AWIXivPgtDnC3MTi1ORY/1
         XO2Yze4f0h30hZ7UmMUWp21yXVc44j0EuEwqq3qnoJFdCF13xhjJ415Aj2KDplAlkkcQ
         Xe/YUFOB5K9cU7OKoqrUmGnB2RBBM1faH7cdkSu6LrH790BsKW5fLmgip3IpsiDbEEd6
         p6iA==
X-Gm-Message-State: ABy/qLYKzq7IAvuQjm3pWDh3zqs47x8ryvfY0deTcXthPsxlsRFo+MNM
        CVFHtCzFgk/oy1S5DMDl2WI=
X-Google-Smtp-Source: APBJJlFWdpdNCZjmxfbdUWTl4ESYDoRy84nBwhykBkLHk0plqvI1FvsVLw49fzew1qmRJ8dp0wfs5g==
X-Received: by 2002:a2e:9f17:0:b0:2b6:cb0d:56ae with SMTP id u23-20020a2e9f17000000b002b6cb0d56aemr635204ljk.11.1689234713822;
        Thu, 13 Jul 2023 00:51:53 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id l18-20020a2e7012000000b002b6c61bac2esm1374734ljc.92.2023.07.13.00.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 00:51:53 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:51:42 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wayland-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>,
        'Marek =?UTF-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com
Subject: Re: [PATCH v5 6/6] drm/doc: Define KMS atomic state set
Message-ID: <20230713105142.122a0cc1@eldfell>
In-Reply-To: <ZK0ZlciR66oTO+Td@phenom.ffwll.local>
References: <20230707224059.305474-1-andrealmeid@igalia.com>
        <20230707224059.305474-7-andrealmeid@igalia.com>
        <ZK0ZlciR66oTO+Td@phenom.ffwll.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s775lQ2oUepIq0FO_JB10fu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s775lQ2oUepIq0FO_JB10fu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jul 2023 10:57:57 +0200
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Fri, Jul 07, 2023 at 07:40:59PM -0300, Andr=C3=A9 Almeida wrote:
> > From: Pekka Paalanen <pekka.paalanen@collabora.com>
> >=20
> > Specify how the atomic state is maintained between userspace and
> > kernel, plus the special case for async flips.
> >=20
> > Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > ---
> > v4: total rework by Pekka
> > ---
> >  Documentation/gpu/drm-uapi.rst | 41 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >=20
> > diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uap=
i.rst
> > index 65fb3036a580..6a1662c08901 100644
> > --- a/Documentation/gpu/drm-uapi.rst
> > +++ b/Documentation/gpu/drm-uapi.rst
> > @@ -486,3 +486,44 @@ and the CRTC index is its position in this array.
> > =20
> >  .. kernel-doc:: include/uapi/drm/drm_mode.h
> >     :internal:
> > +
> > +KMS atomic state
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +An atomic commit can change multiple KMS properties in an atomic fashi=
on,
> > +without ever applying intermediate or partial state changes.  Either t=
he whole
> > +commit succeeds or fails, and it will never be applied partially. This=
 is the
> > +fundamental improvement of the atomic API over the older non-atomic AP=
I which is
> > +referred to as the "legacy API".  Applying intermediate state could un=
expectedly
> > +fail, cause visible glitches, or delay reaching the final state.
> > +
> > +An atomic commit can be flagged with DRM_MODE_ATOMIC_TEST_ONLY, which =
means the
> > +complete state change is validated but not applied.  Userspace should =
use this
> > +flag to validate any state change before asking to apply it. If valida=
tion fails
> > +for any reason, userspace should attempt to fall back to another, perh=
aps
> > +simpler, final state.  This allows userspace to probe for various conf=
igurations
> > +without causing visible glitches on screen and without the need to und=
o a
> > +probing change.
> > +
> > +The changes recorded in an atomic commit apply on top the current KMS =
state in
> > +the kernel. Hence, the complete new KMS state is the complete old KMS =
state with
> > +the committed property settings done on top. The kernel will automatic=
ally avoid
> > +no-operation changes, so it is safe and even expected for userspace to=
 send
> > +redundant property settings.  No-operation changes do not count toward=
s actually
> > +needed changes, e.g.  setting MODE_ID to a different blob with identic=
al
> > +contents as the current KMS state shall not be a modeset on its own. =
=20
>=20
> Small clarification: The kernel indeed tries very hard to make redundant
> changes a no-op, and I think we should consider any issues here bugs. But
> it still has to check, which means it needs to acquire the right locks and
> put in the right (cross-crtc) synchronization points, and due to
> implmentation challenges it's very hard to try to avoid that in all cases.
> So adding redundant changes especially across crtc (and their connected
> planes/connectors) might result in some oversynchronization issues, and
> userspace should therefore avoid them if feasible.
>=20
> With some sentences added to clarify this:
>=20
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

After talking on IRC yesterday, we realized that the no-op rule is
nowhere near as generic as I have believed. Roughly:
https://oftc.irclog.whitequark.org/dri-devel/2023-07-12#1689152446-16891572=
91;


Thanks,
pq

> > +
> > +A "modeset" is a change in KMS state that might enable, disable, or te=
mporarily
> > +disrupt the emitted video signal, possibly causing visible glitches on=
 screen. A
> > +modeset may also take considerably more time to complete than other ki=
nds of
> > +changes, and the video sink might also need time to adapt to the new s=
ignal
> > +properties. Therefore a modeset must be explicitly allowed with the fl=
ag
> > +DRM_MODE_ATOMIC_ALLOW_MODESET.  This in combination with
> > +DRM_MODE_ATOMIC_TEST_ONLY allows userspace to determine if a state cha=
nge is
> > +likely to cause visible disruption on screen and avoid such changes wh=
en end
> > +users do not expect them.
> > +
> > +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
> > +effectively change only the FB_ID property on any planes. No-operation=
 changes
> > +are ignored as always. Changing any other property will cause the comm=
it to be
> > +rejected.
> > --=20
> > 2.41.0
> >  =20
>=20


--Sig_/s775lQ2oUepIq0FO_JB10fu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmSvrQ8ACgkQI1/ltBGq
qqf1OA//fJK8h1tp8IR/16mqP3HqQeX16D7e0MdvIHc/y7KianjdxUSxVL33S2Q/
vwnUlRT5XM6YFyMel8lqXj9W/kXQKFWKc4dZ32FV4nRKH7/Mq1T29qLbcuo72f4a
toACgRxJuAxFuevU27PPH9CVNrxcBB8713PXVlwigRsM1csCokppguU6Kt5Gh5Hu
YnS/oNhDzNbNfZhyX58epE38G3zdp9oUp0lgsx6k11Oe2ASEPX7mTTjNqLE5nQii
JxsvoAv81RNqe4SvGDLex9pweeyXSItESL7lMJWXZFyIzFxu1H1CzImwtp+Zn3w5
FuRheSx7WYlw/V+/M0dWr+uyZu9Tc49epPdQOfHjY40sKIMPJ7U4IMoxtLaJEHNp
79Ghi5u0LuvqlS82ZdbrYLZzULau9gLUnM4kKi37W0m2NqBNbjBE8Oqrc4JyC3yj
uvxB6kQa9679q7JC5q+um9qvTwFUjWy0JnK9RgMNgHTBDYjtj+O0k2V8jvxPMLXL
Y+GrMq7jsJJmu35m6dpPtfLczX920qozJyiomkqDTvPD7oASF5NK0wn2QdjTvMjg
hSm6HvG6CydwwszFVC/kFLDYXW0r1ErHMaV0wpqIQTsAVmQiER58oWX1k1+HtVyL
UTr1gfmUhoEipv0DClFSWXntolF7QRFe2Z5jmO6fVWTLp1paKic=
=hqk3
-----END PGP SIGNATURE-----

--Sig_/s775lQ2oUepIq0FO_JB10fu--
