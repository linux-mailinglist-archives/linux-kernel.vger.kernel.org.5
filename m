Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E468C8000CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjLABHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLABHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:07:41 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EF210E2;
        Thu, 30 Nov 2023 17:07:46 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so1516403b3a.3;
        Thu, 30 Nov 2023 17:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701392865; x=1701997665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUm1+PoLufKuRdIAF0NESslVUVq3hoSsK9m/WIJoGLk=;
        b=c5U9e4xgyB3S1M/HHcVB8s3F6kqoa4bdeujXHvrKo+f95J41Q7S07Oh2mKpKLoDE6w
         twELpNVEgO2dal4+JAJJKy9Q5xqTTYj8UKzwQIrrxIjLE3ZfRuXHoQ/pm6eICFPFI6mS
         iQiT5TCirA+ofU9mZdSqE/AJ/nfZ0xbNFs2iHC9GmbF44VMRlN4zGFa5abK1rxWJaSCU
         UOc5NDtd06lcH8RyOJJF9zp/Vwz7Xcgo05MDSVBprxseUWBu/fCeXy2kLUey/+sxKeVG
         vZOW7CsJlU+AP4tDzaSMlsLK3Ycluy8rlbIe+Dd74Ly1MFPzMOombzQUXVDsJMXWCcCc
         nzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701392865; x=1701997665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUm1+PoLufKuRdIAF0NESslVUVq3hoSsK9m/WIJoGLk=;
        b=JiD1OwFbWxjyAE6x911PK8DSAj03TZ72msQJD0+Ep1p+teJdxCIF0dCUy1W5aOwIjt
         TgjNLNuxm0EnFMTdIwT5dp7Xqb4+Va5JgTU0mHjoLHduyAt0guW1pPzaLcOfqrb9Gu/I
         N0wP0IwzKnW2UwfuYdAYdN2h2n0arUmBlqTDz7EdrvhLBYBkAlx9zeC6DI5YAYT8Fp/i
         yzy3B38zbF8H6xaDhj9uFJasrRoq+K6Cirj8is2GzvyfNizdOL9CvhYCN9LxzO+YkD3k
         CUm5I/mP0GTbFJbwdE5iRyPpTRCcdGKaL0BK4nnusZwqr7HSuhg9CDI8bWe62ILERsws
         MO1g==
X-Gm-Message-State: AOJu0Ywh8qkEH/5ibJmdIKtgI219E+M+TrXKjMHLwK5KZoQHf+QxsHfy
        jL5IYtVPWyBMA475vzYj7t8=
X-Google-Smtp-Source: AGHT+IEpqLtFWr3jS1uwx80udQpJF7FenfSx2/8uNdOnCyRz8PMl0jnNpn2rP/xjSVKJUPB3LIk5Pw==
X-Received: by 2002:a05:6a20:244b:b0:18c:fa:17f7 with SMTP id t11-20020a056a20244b00b0018c00fa17f7mr28928374pzc.46.1701392865475;
        Thu, 30 Nov 2023 17:07:45 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x67-20020a626346000000b006be0fb89ac2sm1887957pfb.197.2023.11.30.17.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 17:07:44 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 5370710136909; Fri,  1 Dec 2023 08:07:41 +0700 (WIB)
Date:   Fri, 1 Dec 2023 08:07:40 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
        Daniel Stone <daniel@fooishbar.org>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Attreyee M <tintinm2017@gmail.com>
Subject: Re: [PATCH] drm/doc: Define KMS atomic state set
Message-ID: <ZWkx3IcUTxO-IdIK@archie.me>
References: <20231130200740.53454-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="caVVT7EznlCmrsO+"
Content-Disposition: inline
In-Reply-To: <20231130200740.53454-1-andrealmeid@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--caVVT7EznlCmrsO+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 05:07:40PM -0300, Andr=C3=A9 Almeida wrote:
> From: Pekka Paalanen <pekka.paalanen@collabora.com>
>=20
> Specify how the atomic state is maintained between userspace and
> kernel, plus the special case for async flips.
>=20
> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>=20
> This is a standalone patch from the following serie, the other patches are
> already merged:
> https://lore.kernel.org/lkml/20231122161941.320564-1-andrealmeid@igalia.c=
om/
>=20
>  Documentation/gpu/drm-uapi.rst | 47 ++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst
> index 370d820be248..d0693f902a5c 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -570,3 +570,50 @@ dma-buf interoperability
> =20
>  Please see Documentation/userspace-api/dma-buf-alloc-exchange.rst for
>  information on how dma-buf is integrated and exposed within DRM.
> +
> +KMS atomic state
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +An atomic commit can change multiple KMS properties in an atomic fashion,
> +without ever applying intermediate or partial state changes.  Either the=
 whole
> +commit succeeds or fails, and it will never be applied partially. This i=
s the
> +fundamental improvement of the atomic API over the older non-atomic API =
which is
> +referred to as the "legacy API".  Applying intermediate state could unex=
pectedly
> +fail, cause visible glitches, or delay reaching the final state.
> +
> +An atomic commit can be flagged with DRM_MODE_ATOMIC_TEST_ONLY, which me=
ans the
> +complete state change is validated but not applied.  Userspace should us=
e this
> +flag to validate any state change before asking to apply it. If validati=
on fails
> +for any reason, userspace should attempt to fall back to another, perhaps
> +simpler, final state.  This allows userspace to probe for various config=
urations
> +without causing visible glitches on screen and without the need to undo a
> +probing change.
> +
> +The changes recorded in an atomic commit apply on top the current KMS st=
ate in
> +the kernel. Hence, the complete new KMS state is the complete old KMS st=
ate with
> +the committed property settings done on top. The kernel will try to avoid
> +no-operation changes, so it is safe for userspace to send redundant prop=
erty
> +settings.  However, not every situation allows for no-op changes, due to=
 the
> +need to acquire locks for some attributes. Userspace needs to be aware t=
hat some
> +redundant information might result in oversynchronization issues.  No-op=
eration
> +changes do not count towards actually needed changes, e.g.  setting MODE=
_ID to a
> +different blob with identical contents as the current KMS state shall no=
t be a
> +modeset on its own. As a special exception for VRR needs, explicitly set=
ting
> +FB_ID to its current value is not a no-op.
> +
> +A "modeset" is a change in KMS state that might enable, disable, or temp=
orarily
> +disrupt the emitted video signal, possibly causing visible glitches on s=
creen. A
> +modeset may also take considerably more time to complete than other kind=
s of
> +changes, and the video sink might also need time to adapt to the new sig=
nal
> +properties. Therefore a modeset must be explicitly allowed with the flag
> +DRM_MODE_ATOMIC_ALLOW_MODESET.  This in combination with
> +DRM_MODE_ATOMIC_TEST_ONLY allows userspace to determine if a state chang=
e is
> +likely to cause visible disruption on screen and avoid such changes when=
 end
> +users do not expect them.
> +
> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
> +effectively change only the FB_ID property on any planes. No-operation c=
hanges
> +are ignored as always. Changing any other property will cause the commit=
 to be
> +rejected. Each driver may relax this restriction if they have guarantees=
 that
> +such property change doesn't cause modesets. Userspace can use TEST_ONLY=
 commits
> +to query the driver about this.

The wording LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--caVVT7EznlCmrsO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWkx2QAKCRD2uYlJVVFO
o1dzAQCN5LKZj1UCW2xL0voB6jCSuPsFMnO4NRaUQ6gOPmqvvQEA/eALo0PO1AJE
7eegxBLTYviNT27pENbRqxLvYpGQJQc=
=8SQb
-----END PGP SIGNATURE-----

--caVVT7EznlCmrsO+--
