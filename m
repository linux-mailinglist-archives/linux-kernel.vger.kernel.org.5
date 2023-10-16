Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C817CAC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjJPOwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjJPOwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:52:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87392E1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:52:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so3086548e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697467959; x=1698072759; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfaMwAxMjRfwOpinKHvcClwhMqvNGEGJeqo+8rgwK64=;
        b=f2eCGu1aVE04lQujJpkQyR7HAjTPhFkc5EphOC9htqrAFOvdbUWU2uQg1g1uVn78yn
         mx/EY6sCFdxt3QlIIWfu61eny23bFHCeE/9iinYMQTj2NCh3RIgZ+HWtulQqbnNsJeiQ
         e44W5eiHkd+dtXOIYns/jGtcJz1zdWRX7Y+nS1iCLS+IupkuP+EZ5cO7ITkdAN8/AZnA
         OQO5YLV8oVnUogxamfQkCTEsXBlKG5+XJarl8DoCWNJgIpOkKbJtwYXUqwhCZ+4S5itk
         pmfeZE9lJVRpNyeRbuQGcgDk0dNN+7oiMykZJEn8t8kMFdOIa/tluVz4XAkmNI3S+qnL
         bHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467959; x=1698072759;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfaMwAxMjRfwOpinKHvcClwhMqvNGEGJeqo+8rgwK64=;
        b=V/KcS1jG7oPXR4wxHXZ3sy51zLX2ZlGzvkl2Y/ilnljl8+mtaWSgFpLGCP/gzJEHJO
         MwwkI2U8iCCT1fC+gmPVDZ1/cGbAOfwUrFvfVTnp51tIdtDogr3SgEAfhY9izlCeM2Er
         8VbjF25JGim9X7xJuyYLzvE3b4t9Vn1iFnDtzl+pI4I8gjZaePGo+LmXoge9PsR3p5FV
         Sperc6sZX7Mj1YpE1xFjwEvjqlKViFOWogN7liHJiiUAMgVu115eM12A5HsJ3S5X3pZd
         IoA1uFJVB+vlDtX3HmxrQri/GRspxlwjq5UoDflatI86w2keEZ4BrybmNLUq3phCpeze
         tEKg==
X-Gm-Message-State: AOJu0Yz/N9W3AyVvqwlsAa2XFCqAslnDqWuwvXcZPI9yRE10tLpicYMM
        zqVdzzwOwQqll1k6j5FW7Mo=
X-Google-Smtp-Source: AGHT+IHPXRreqpJIfRixdtagW7epVNulxi7pgxOISUFw6x+ARuUNOEchm+6itcoT3ESNmcoYtuyp5Q==
X-Received: by 2002:a05:6512:3ca0:b0:507:a8f9:d67f with SMTP id h32-20020a0565123ca000b00507a8f9d67fmr3388315lfv.24.1697467958208;
        Mon, 16 Oct 2023 07:52:38 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id i14-20020ac25d2e000000b0050422588213sm4571218lfb.209.2023.10.16.07.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:52:37 -0700 (PDT)
Date:   Mon, 16 Oct 2023 17:52:22 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc:     Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
        xaver.hugl@gmail.com, pierre-eric.pelloux-prayer@amd.com,
        Daniel Vetter <daniel@ffwll.ch>,
        'Marek =?UTF-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Stone <daniel@fooishbar.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hwentlan@amd.com,
        Rob Clark <robdclark@gmail.com>, ville.syrjala@linux.intel.com,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com,
        joshua@froggi.es, wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 6/6] drm/doc: Define KMS atomic state set
Message-ID: <20231016175222.7a89e6ab@eldfell>
In-Reply-To: <aa424bf8-5652-4a44-9b93-bdc0a31d835a@igalia.com>
References: <20230815185710.159779-1-andrealmeid@igalia.com>
        <20230815185710.159779-7-andrealmeid@igalia.com>
        <1b23576d-1649-ff5c-6273-b54729ea46d8@mailbox.org>
        <b48bd1fc-fcb0-481b-8413-9210d44d709b@igalia.com>
        <20231016151856.74af9305@eldfell>
        <aa424bf8-5652-4a44-9b93-bdc0a31d835a@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Bz+Yx.C6psyZpVX2eLu8wAL";
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

--Sig_/Bz+Yx.C6psyZpVX2eLu8wAL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Oct 2023 15:42:16 +0200
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Hi Pekka,
>=20
> On 10/16/23 14:18, Pekka Paalanen wrote:
> > On Mon, 16 Oct 2023 12:52:32 +0200
> > Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> > =20
> >> Hi Michel,
> >>
> >> On 8/17/23 12:37, Michel D=C3=A4nzer wrote: =20
> >>> On 8/15/23 20:57, Andr=C3=A9 Almeida wrote: =20
> >>>> From: Pekka Paalanen <pekka.paalanen@collabora.com>
> >>>>
> >>>> Specify how the atomic state is maintained between userspace and
> >>>> kernel, plus the special case for async flips.
> >>>>
> >>>> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> >>>> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com> =20
> >>> [...]
> >>>    =20
> >>>> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed =
to
> >>>> +effectively change only the FB_ID property on any planes. No-operat=
ion changes
> >>>> +are ignored as always. [...] =20
> >>> During the hackfest in Brno, it was mentioned that a commit which re-=
sets the same FB_ID could actually have an effect with VRR: It could trigge=
r scanout of the next frame before vertical blank has reached its maximum d=
uration. Some kind of mechanism is required for this in order to allow user=
 space to perform low frame rate compensation.
> >>>    =20
> >> Xaver tested this hypothesis in a flipping the same fb in a VRR monitor
> >> and it worked as expected, so this shouldn't be a concern. =20
> > Right, so it must have some effect. It cannot be simply ignored like in
> > the proposed doc wording. Do we special-case re-setting the same FB_ID
> > as "not a no-op" or "not ignored" or some other way? =20
> There's an effect in the refresh rate, the image won't change but it=20
> will report that a flip had happened asynchronously so the reported=20
> framerate will be increased. Maybe an additional wording could be like:
>=20
> Flipping to the same FB_ID will result in a immediate flip as if it was=20
> changing to a different one, with no effect on the image but effecting=20
> the reported frame rate.

Re-setting FB_ID to its current value is a special case regardless of
PAGE_FLIP_ASYNC, is it not?

So it should be called out somewhere that applies regardless of
PAGE_FLIP_ASYNC. Maybe to the end of the earlier paragraph:

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
> +modeset on its own.

+As a special exception for VRR needs, explicitly setting FB_ID to its
+current value is not a no-op.

Would that work?

I'd like to try to avoid being more specific about what it does
exactly, because that's not the topic here. Such things can be
documented with the property itself. This is a summary of what is or is
not a no-op or a modeset.


Thanks,
pq

--Sig_/Bz+Yx.C6psyZpVX2eLu8wAL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmUtTiYACgkQI1/ltBGq
qqcogA/5AUHpaJpLiNY5OmjFAMgtNyE0I2iqQTMRxdD7HxoY+S8MIHB6jq/Ac2cD
bgbV2k2AHbm+toVzZeTOgDK4PZqQe+2Mfi53Fe+MhJz364YkFvhUJ1+wvk0rzs6f
SQ+HKfVVsUfXGz5lLjAcG5xSxRHdTBNiS3GtfTBSDZewdvBfrntZwA5B22MxiSua
/iEdu8aYjO1WAvdz0/SzV2pNfcyfo71gHKCY1aHBD1Hkf6aqJMLHsbgQng8tkKir
MVmARPURGZCXgJpYsNMJYU/0p4ByN/jXrsbDAXu37IAEECqLxwIWeIQgoahTGIXu
dVIuxgRyuEOdnxB6rkt8u5iTkLY4jJAx26nx3Zi8MkbimPvWHjQt1cyfrS3Q4ZyG
7kj028Q2ekwvbsPRqlD+Msqg/1v2WQgYm5HIHicSGP0tKkg4IXZj+z84T8Bcl8Gw
7xZTHqLgLrFdXq1HTG0Co5r1pRCFD1EgaGJqrMI/AN/RzZ6TjGZ/kVeM3roZw0zK
tUbhu9Ndh4AfYmrTPx74IVHTNqsYl8OCrjaYvFkCkAHy3gzLrlmjQwMuof9Q/l+1
FxcDrPC3v0xKnGsrAW2Doyi3idzOdtyquUzJgN4pqlnAn1zV1hXMQZt8LxVUBXuK
UDk+hGMxCYb0Z2L1t/Sg6HaLlMxFH5br5OtJhUl1K0cYLavNrjE=
=Lyhk
-----END PGP SIGNATURE-----

--Sig_/Bz+Yx.C6psyZpVX2eLu8wAL--
