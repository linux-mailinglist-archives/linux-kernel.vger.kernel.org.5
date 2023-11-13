Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591767E99F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjKMKPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMKPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:15:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6866135
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:15:15 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507c5249d55so6510409e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699870514; x=1700475314; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rzaUs2XAqeA/RwRAkAgsgiaQodYWE7wdOheKWd5RMI=;
        b=EDdacfL3sRHnBCUQDckBnP2kIFNFHLu24Q2oFX/qDoaQFWn6kXxZAD6rtxInsIegtC
         qeJLgXcvwPKtzkUaul9mTE2AmpJ8UhnUU+kSUAKLWg006v/4ZwkfWFr5NTaGGl1amWRU
         cWe5eiGze4rYQqOP/qn8X2wwCeKtJ/90tJYsMdqlhqRQMC4s/qAvpqKVMCdBFEguDpU6
         nxffQKwoaUGVlCsLo9mJfuTN89oLnHc6T/e2zb11uoR2Kq7Qq0QB4CC8m4k2IUPZ+238
         j260C9IEeZs53nxpidKP1PO3QBsa6wR0ZmJz0Z6QiOE0MiuYRtzbeYdqUFZBALOYxduO
         XxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699870514; x=1700475314;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rzaUs2XAqeA/RwRAkAgsgiaQodYWE7wdOheKWd5RMI=;
        b=UODcv7sJuDno7BwfC5l7hzo6d/dO9O+u7285cwjowpoYk7WzXwe0IzYKc80wTe6pDB
         ezHOmm9M6rtKdB/qxiBBTdKOPSJVkg9BqyjNaQ2L7zHlBBLYnFvFHIPflh1UJS6vFr3x
         KMWbfLOBto48k9kJQ3WRk5eoDPjb3LIBOsrZavqSHo5atKmehYShmzjITR/ARcJe3Dg7
         lqnzmECV4II28h2N008u+/ZYgO4MAHEsvR3df5hjWs5oKxXeQxpPuzshZt7V4afl8T6R
         4s6y3HAy3Ok2QbBurawHh5ckoO8GhXluwS8eesXlfPEQGCwlrBdkPa6M0tsp7x9qNddF
         8FwQ==
X-Gm-Message-State: AOJu0YyWbV7bvzXCtJmbdAoMVi1sbAF+oaJ+QykIXhBNhC9Ei+opaHU5
        3hX+NNr5K7f2pnZu+KPQwoo=
X-Google-Smtp-Source: AGHT+IHtYW+7Xf0/srPPhEqOEnKJaAXNGJ9qvsN45itd/Zr75+AjH5CsC3G+tdXul0NcVxuVwX18aQ==
X-Received: by 2002:a2e:bc25:0:b0:2c5:23f8:1111 with SMTP id b37-20020a2ebc25000000b002c523f81111mr5497470ljf.41.1699870513595;
        Mon, 13 Nov 2023 02:15:13 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id a16-20020a2e8610000000b002c0055834b3sm941568lji.4.2023.11.13.02.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:15:13 -0800 (PST)
Date:   Mon, 13 Nov 2023 12:15:08 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
        kernel-dev@igalia.com,
        'Marek =?UTF-8?B?T2w=?= =?UTF-8?B?xaHDoWsn?= <maraeo@gmail.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>, xaver.hugl@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        alexander.deucher@amd.com, wayland-devel@lists.freedesktop.org,
        hwentlan@amd.com, christian.koenig@amd.com, joshua@froggi.es
Subject: Re: [PATCH v6 6/6] drm/doc: Define KMS atomic state set
Message-ID: <20231113121508.16a75352@eldfell>
In-Reply-To: <ha7UwaZ0eilF_Hl6wWqJXJQ0oy9_rD1FKUNDwIlNxC-vT3InSP4bpTRwVnZG9QvzZBsX4W-p_vz5FfByoAXuGewyhVtwVd4KyRSMJ4G8cQ4=@emersion.fr>
References: <20230815185710.159779-1-andrealmeid@igalia.com>
        <aa424bf8-5652-4a44-9b93-bdc0a31d835a@igalia.com>
        <20231016175222.7a89e6ab@eldfell>
        <ZS1ST6XAUHilBg3d@intel.com>
        <8NqDNz1Y8H5I_WhNhOj0ERarBH7nJhGQAsDHbmSnwzoOFtXPBPILwxLlF8-vDPKR06Uknp1BDSt7-6gTmHls62k79ETajXDfPRsmIP-cZN0=@emersion.fr>
        <ZS55mXTSxpXKYbsd@intel.com>
        <mawSNnD1hQ6vCVrNVMAvuQESnTToKPXrtiHIXXdqC-mq_LkxWOizPCcXx_KiEASVX-Mbm0LgjfTYkMNOjSAKCldpkXHAd9MmRzbC8ECPsTs=@emersion.fr>
        <5_NYn1PEc-XUYiRf5fC9oQqTaJxoAuvHVvw1PVTume5m8_cbOyku2Q2XKdCm66g0WcMq_RL8oSp52AowBzX9WAEiVBgdmYtPeXI9SWnD6Ts=@emersion.fr>
        <20231113113804.6e2adfa8@eldfell>
        <ha7UwaZ0eilF_Hl6wWqJXJQ0oy9_rD1FKUNDwIlNxC-vT3InSP4bpTRwVnZG9QvzZBsX4W-p_vz5FfByoAXuGewyhVtwVd4KyRSMJ4G8cQ4=@emersion.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6bNbi9WwCvCAexOid30925v";
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

--Sig_/6bNbi9WwCvCAexOid30925v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Nov 2023 09:44:15 +0000
Simon Ser <contact@emersion.fr> wrote:

> On Monday, November 13th, 2023 at 10:38, Pekka Paalanen <ppaalanen@gmail.=
com> wrote:
>=20
> > On Mon, 13 Nov 2023 09:18:39 +0000
> > Simon Ser contact@emersion.fr wrote:
> >  =20
> > > On Monday, October 23rd, 2023 at 10:25, Simon Ser contact@emersion.fr=
 wrote:
> > >  =20
> > > > > > > > > > > > > +An atomic commit with the flag DRM_MODE_PAGE_FLI=
P_ASYNC is allowed to
> > > > > > > > > > > > > +effectively change only the FB_ID property on an=
y planes. No-operation changes
> > > > > > > > > > > > > +are ignored as always. [...]
> > > > > > > > > > > > > During the hackfest in Brno, it was mentioned tha=
t a commit which re-sets the same FB_ID could actually have an effect with =
VRR: It could trigger scanout of the next frame before vertical blank has r=
eached its maximum duration. Some kind of mechanism is required for this in=
 order to allow user space to perform low frame rate compensation. =20
> > > > > > > > > > >=20
> > > > > > > > > > > Xaver tested this hypothesis in a flipping the same f=
b in a VRR monitor
> > > > > > > > > > > and it worked as expected, so this shouldn't be a con=
cern.
> > > > > > > > > > > Right, so it must have some effect. It cannot be simp=
ly ignored like in
> > > > > > > > > > > the proposed doc wording. Do we special-case re-setti=
ng the same FB_ID
> > > > > > > > > > > as "not a no-op" or "not ignored" or some other way?
> > > > > > > > > > > There's an effect in the refresh rate, the image won'=
t change but it
> > > > > > > > > > > will report that a flip had happened asynchronously s=
o the reported
> > > > > > > > > > > framerate will be increased. Maybe an additional word=
ing could be like: =20
> > > > > > > > >=20
> > > > > > > > > Flipping to the same FB_ID will result in a immediate fli=
p as if it was
> > > > > > > > > changing to a different one, with no effect on the image =
but effecting
> > > > > > > > > the reported frame rate. =20
> > > > > > > >=20
> > > > > > > > Re-setting FB_ID to its current value is a special case reg=
ardless of
> > > > > > > > PAGE_FLIP_ASYNC, is it not? =20
> > > > > > >=20
> > > > > > > No. The rule has so far been that all side effects are observ=
ed
> > > > > > > even if you flip to the same fb. And that is one of my annoya=
nces
> > > > > > > with this proposal. The rules will now be different for async=
 flips
> > > > > > > vs. everything else. =20
> > > > > >=20
> > > > > > Well with the patches the async page-flip case is exactly the s=
ame as
> > > > > > the non-async page-flip case. In both cases, if a FB_ID is incl=
uded in
> > > > > > an atomic commit then the side effects are triggered even if th=
e property
> > > > > > value didn't change. The rules are the same for everything. =20
> > > > >=20
> > > > > I see it only checking if FB_ID changes or not. If it doesn't
> > > > > change then the implication is that the side effects will in
> > > > > fact be skipped as not all planes may even support async flips. =
=20
> > > >=20
> > > > Hm right. So the problem is that setting any prop =3D same value as
> > > > previous one will result in a new page-flip for asynchronous page-f=
lips,
> > > > but will not result in any side-effect for asynchronous page-flips.
> > > >=20
> > > > Does it actually matter though? For async page-flips, I don't think=
 this
> > > > would result in any actual difference in behavior? =20
> >=20
> >=20
> > Hi Simon,
> >=20
> > a fly-by question...
> >  =20
> > > To sum this up, here is a matrix of behavior as seen by user-space:
> > >=20
> > > - Sync atomic page-flip
> > > - Set FB_ID to different value: programs hw for page-flip, sends ueve=
nt
> > > - Set FB_ID to same value: same (important for VRR)
> > > - Set another plane prop to same value: same
> > > - Set another plane prop to different value: maybe rejected if modese=
t required
> > > - Async atomic page-flip
> > > - Set FB_ID to different value: updates hw with new FB address, sends
> > > immediate uevent
> > > - Set FB_ID to same value: same (no-op for the hw) =20
> >=20
> > It should not be a no-op for the hw, because the hw might be in the
> > middle of a VRR front-porch waiting period, and the commit needs to end
> > the waiting immediately rather than time out? =20
>=20
> I'm not sure=20

Would people not want to use async commits to trigger new VRR scanout
cycles without content updates?

I seem to recall previous comments that switching between sync and
async commit modes may take a moment (intel's one last sync flip), so
using sync once in a while then using async otherwise is probably not a
good idea.

> > > - Set another plane prop to same value: ignored, sends immediate ueve=
nt
> > > (special codepath) =20
> >=20
> > If the sync case says "same", then shouldn't this say "same" as well to
> > be consistent? =20
>=20
> Okay, I think I chose my words badly. By "same" I meant "same as
> previous item in the list".
>=20
> Here I tried to be more explicit and explain why it's the same behavior.
> We have a special path in the kernel code that ignores the change, but
> the effective result is that it doesn't differ from the sync case.
>=20
> Here's a fixed matrix where I don't use confusing words:
>=20
> - Sync atomic page-flip
>   - Set FB_ID to different value: programs hw for page-flip, sends uevent
>   - Set FB_ID to same value: programs hw for page-flip, sends uevent (imp=
ortant
>     for VRR)
>   - Set another plane prop to same value: programs hw for page-flip, sends
>     uevent

Programming hw for page-flip probably triggers a new VRR scanout cycle,
even if the FB address didn't change.

>   - Set another plane prop to different value: maybe rejected if modeset =
required
> - Async atomic page-flip
>   - Set FB_ID to different value: updates hw with new FB address, sends
>     immediate uevent
>   - Set FB_ID to same value: updates hw with new FB address (no-op for th=
e hw),
>     sends immediate uevent
>   - Set another plane prop to same value: ignored, sends immediate uevent
>     (special codepath)

Just like Michel points out: if this case has a special case ignoring
the set, then this case will not trigger a new VRR scanout cycle like
the corresponding sync case does.

>   - Set another plane prop to different value: always rejected


Thanks,
pq

--Sig_/6bNbi9WwCvCAexOid30925v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmVR9ywACgkQI1/ltBGq
qqcOLg//aENH/YGXJFSAaa7U/b5a15bjSk0KT6YsWFgdxSVo+At/1BIdx8tPVQuo
s/haxSzjuNba/YLevARZVFsGBCyYQG+BLqE1M1q5g6umjjgS9Yhw2B8Ik2elnxSY
U8o575TWYmq+9SMVK2qxXUNKbomxGtLUSCNC67yLRD+Xtz2prBgox/QCkxSZTPcz
W/x+rLN/93IdU5sEF73uoH7rGReovDupVimwEnCRIxlwEMT4xtZmRVDRVITkx16I
+oZaZnLZE4V8G6BaFtMFkhN33Z13g/lxA71MbCNdVAamSOepQaC+MP0BqF49QEnr
NXkKckUK7dx+sjVEpW/6CHKZ/7u8ewxBjdtxKMFKSMuYFpIASZeaUz3QSK+Ke2py
zWji+lFYgtr/HIKbkdVHjI0Q/4OtQPmujzAPFioM2VD4r1p/apkeW1Ikf+ZrxlWk
XXvxBVyMyTker23+EQC97g+CyDNApinc88V5ab0GrzQMC9gWQBCLn34/TqRq2tsZ
ymxYWI3R4YOKqSXLPesE0e/sVDyN1sURAWNvUz1W3Ymm4Y7L/LF5YZbDH/UbcZhW
0J3+JgrCDoHOKTPmAx6OTyGZxZ/QH4I/5c00JOlxbtl1D/8xF7/OfbGCACIhZoY0
QWa6q1cMsPd4O1hKBHAvkSWHBV7PQEf6ljHq/5MlzDDLLAAJNZs=
=LCPG
-----END PGP SIGNATURE-----

--Sig_/6bNbi9WwCvCAexOid30925v--
