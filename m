Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ADF76D0BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjHBO7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjHBO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:59:07 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6238D19AD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:59:05 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a716f1ec3fso473565b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1690988344; x=1691593144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkmn55yZh1Rz2MwlfyBOzuu4eBd6dwrDT9L9Cwq53pI=;
        b=OtTCxZ1uO6KGb/7Vy+iET/QDAClw9bYJdjMQW2anIJXeLYWTLukaWJ5plk49aE85YL
         TNMMtTu6wuQf5Iyoz6rgoIVSDddrA79p8WUKfWw9xTOiK9Oy9KQHBTvEro6vYv2K0Wz1
         rCA1DBZoDP9ZSyC8RT8C7A5MHk2Pq+iZgGNDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988344; x=1691593144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pkmn55yZh1Rz2MwlfyBOzuu4eBd6dwrDT9L9Cwq53pI=;
        b=jM+OcxFZtkFWRVPsP45vqiFqhg3RxoFMnmHVj3tZiqz31XSbuCJpxjNpAIK6jJqXI0
         Tpr6x6hmSxgVRA9YL3685Lg4xORbbg2tMTtK2PoiYdDnD4sUqD+US67EZgD38ZEDeFEY
         Grq6WzGw73YTogxyc1zPa5bI2UKNjTHKo0Ct3OmNccJ7+9TElH2oMELctdqVIF7WsV+V
         W70jfb1eyX8d1swlnBr3/pHnIhsEI7UqBUTMvtUsUCnFzbh6asRT6nwmtbal5t10WH5f
         ctEhLD6ZKk+eodA8j+Oo3AtJmeV5/8xVY6Ks8WvGA5A9AYdWLi0fjPTL/51PZe6gm32B
         mKNA==
X-Gm-Message-State: ABy/qLYiodNCC6/qocugQz+FaXfB0RzgS7a05LgZEeY6oY2oZjJhhMgU
        CcvvwM9MyCTB9WS8hbgHAClYX7N0evkKETtHBQMZGg==
X-Google-Smtp-Source: APBJJlG7s6LInHyvHFYr1Mc+JjNw0wI3JAe6FASZYgSUHMNQkbDcagsLdus2tHIGWJRIhFSeeDhMRcI3pXptt+vnN3w=
X-Received: by 2002:a05:6808:1926:b0:3a7:16f3:a46e with SMTP id
 bf38-20020a056808192600b003a716f3a46emr12040217oib.2.1690988344485; Wed, 02
 Aug 2023 07:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230707224059.305474-1-andrealmeid@igalia.com>
 <20230707224059.305474-7-andrealmeid@igalia.com> <ZK0ZlciR66oTO+Td@phenom.ffwll.local>
 <20230713105142.122a0cc1@eldfell> <35a8e502-c36c-e67e-29ba-a20ae6134c6d@igalia.com>
In-Reply-To: <35a8e502-c36c-e67e-29ba-a20ae6134c6d@igalia.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 2 Aug 2023 16:58:52 +0200
Message-ID: <CAKMK7uFMYjueTT8DTE5MER6wPNCHCS8gJriQsAR=4WnzAXRp8w@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/doc: Define KMS atomic state set
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 at 04:01, Andr=C3=A9 Almeida <andrealmeid@igalia.com> w=
rote:
>
> Em 13/07/2023 04:51, Pekka Paalanen escreveu:
> > On Tue, 11 Jul 2023 10:57:57 +0200
> > Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> >> On Fri, Jul 07, 2023 at 07:40:59PM -0300, Andr=C3=A9 Almeida wrote:
> >>> From: Pekka Paalanen <pekka.paalanen@collabora.com>
> >>>
> >>> Specify how the atomic state is maintained between userspace and
> >>> kernel, plus the special case for async flips.
> >>>
> >>> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> >>> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >>> ---
> >>> v4: total rework by Pekka
> >>> ---
> >>>   Documentation/gpu/drm-uapi.rst | 41 +++++++++++++++++++++++++++++++=
+++
> >>>   1 file changed, 41 insertions(+)
> >>>
> >>> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-u=
api.rst
> >>> index 65fb3036a580..6a1662c08901 100644
> >>> --- a/Documentation/gpu/drm-uapi.rst
> >>> +++ b/Documentation/gpu/drm-uapi.rst
> >>> @@ -486,3 +486,44 @@ and the CRTC index is its position in this array=
.
> >>>
> >>>   .. kernel-doc:: include/uapi/drm/drm_mode.h
> >>>      :internal:
> >>> +
> >>> +KMS atomic state
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +An atomic commit can change multiple KMS properties in an atomic fas=
hion,
> >>> +without ever applying intermediate or partial state changes.  Either=
 the whole
> >>> +commit succeeds or fails, and it will never be applied partially. Th=
is is the
> >>> +fundamental improvement of the atomic API over the older non-atomic =
API which is
> >>> +referred to as the "legacy API".  Applying intermediate state could =
unexpectedly
> >>> +fail, cause visible glitches, or delay reaching the final state.
> >>> +
> >>> +An atomic commit can be flagged with DRM_MODE_ATOMIC_TEST_ONLY, whic=
h means the
> >>> +complete state change is validated but not applied.  Userspace shoul=
d use this
> >>> +flag to validate any state change before asking to apply it. If vali=
dation fails
> >>> +for any reason, userspace should attempt to fall back to another, pe=
rhaps
> >>> +simpler, final state.  This allows userspace to probe for various co=
nfigurations
> >>> +without causing visible glitches on screen and without the need to u=
ndo a
> >>> +probing change.
> >>> +
> >>> +The changes recorded in an atomic commit apply on top the current KM=
S state in
> >>> +the kernel. Hence, the complete new KMS state is the complete old KM=
S state with
> >>> +the committed property settings done on top. The kernel will automat=
ically avoid
> >>> +no-operation changes, so it is safe and even expected for userspace =
to send
> >>> +redundant property settings.  No-operation changes do not count towa=
rds actually
> >>> +needed changes, e.g.  setting MODE_ID to a different blob with ident=
ical
> >>> +contents as the current KMS state shall not be a modeset on its own.
> >>
> >> Small clarification: The kernel indeed tries very hard to make redunda=
nt
> >> changes a no-op, and I think we should consider any issues here bugs. =
But
> >> it still has to check, which means it needs to acquire the right locks=
 and
> >> put in the right (cross-crtc) synchronization points, and due to
> >> implmentation challenges it's very hard to try to avoid that in all ca=
ses.
> >> So adding redundant changes especially across crtc (and their connecte=
d
> >> planes/connectors) might result in some oversynchronization issues, an=
d
> >> userspace should therefore avoid them if feasible.
> >>
> >> With some sentences added to clarify this:
> >>
> >> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > After talking on IRC yesterday, we realized that the no-op rule is
> > nowhere near as generic as I have believed. Roughly:
> > https://oftc.irclog.whitequark.org/dri-devel/2023-07-12#1689152446-1689=
157291;
> >
> >
>
> How about:
>
> The changes recorded in an atomic commit apply on top the current KMS
> state in the kernel. Hence, the complete new KMS state is the complete
> old KMS state with the committed property settings done on top. The
> kernel will try to avoid no-operation changes, so it is safe for
> userspace to send redundant property settings. However, the kernel can
> not assure that every redundant information will always result in a
> no-op, giving the need to take locks to check par of the state. Giving
> that, some redundant information can lead to a full damage path. This is
> not something bad by itself, but userspace need to be aware of that side
> effect.

I think the addition about damage tracking should be a separate
paragraph, and not mixed in with the general explanation that no-op
updates might lead to oversync/overlocking issues. Because the damage
tracking issue is more a question of efficiency/power usage, but
should not (for most drivers/hw at least) result in delays and missed
updates due to oversynchronization of updates.

Also in my opinion the exact damage update rules are more a plane
property issue, and should probably be clarified there if the current
documentation is not clear enough. Since it's not about whether no-op
updates get avoided by the kernel, but what exact damage is implied in
various cases (and that implied damage has to exist, otherwise
backwards compatibility is broken, but userspace can avoid these
issues by setting an empty damage property for that plane update
explicitly).

So I think for this doc part here the discussed text is still good
enough, but we might need more in other places.
-Sima


>
> > Thanks,
> > pq
> >
> >>> +
> >>> +A "modeset" is a change in KMS state that might enable, disable, or =
temporarily
> >>> +disrupt the emitted video signal, possibly causing visible glitches =
on screen. A
> >>> +modeset may also take considerably more time to complete than other =
kinds of
> >>> +changes, and the video sink might also need time to adapt to the new=
 signal
> >>> +properties. Therefore a modeset must be explicitly allowed with the =
flag
> >>> +DRM_MODE_ATOMIC_ALLOW_MODESET.  This in combination with
> >>> +DRM_MODE_ATOMIC_TEST_ONLY allows userspace to determine if a state c=
hange is
> >>> +likely to cause visible disruption on screen and avoid such changes =
when end
> >>> +users do not expect them.
> >>> +
> >>> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed t=
o
> >>> +effectively change only the FB_ID property on any planes. No-operati=
on changes
> >>> +are ignored as always. Changing any other property will cause the co=
mmit to be
> >>> +rejected.
> >>> --
> >>> 2.41.0
> >>>
> >>
> >



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
