Return-Path: <linux-kernel+bounces-23920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE7282B3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E821F22DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81A651C46;
	Thu, 11 Jan 2024 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="fHWJ2f4M"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324750264
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5f68af028afso49058277b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1704993502; x=1705598302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reRg+juZFTzYLAuymnc77j283thAAyu9GtKD+8yi8oo=;
        b=fHWJ2f4MgIwGKzOsXgfG9dMQlXYuSoFtDj/Lxofu4OwUO0D0f6SdstOcnFFY4p7gdE
         NEOn+nZiaBzgAcisvRJpnN21dRkSAeBRESFp4I7hHLe1mO0n2b57Je32yhVjIfAOYra3
         SOr2EUgW5u6LTnwqltXclstzK7kJKOvPDfJZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704993502; x=1705598302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reRg+juZFTzYLAuymnc77j283thAAyu9GtKD+8yi8oo=;
        b=kWeUTmilsYFg5SkMCj59nUkgKohuhayrxHqM69RE4ToHMjqnzdzEaNnUw8T8M3lCJb
         YQWgLgAaGoaKqqOxdq+3RAjRuLfTH3mkuIyaT1dOCKcM1CmnoeuvKeNXEbwFg3y/FWo5
         anPi/eyxpSJbJu6J0Q48WJNHub4SRVz6VMU3Kte5+2f2CJQJJYJDC2mh3V8xQJ7FH6b4
         iu8YVzojRysAxDcLfyDvP6ZSKOl8AcbX5V+zJO5P07lHDFPNWy+JZzcMT72nzrA6DF/0
         wpMBz6H1U7wZJuUj0QnVPo05nx3SZKvVczKbgEiMKGU5X7NCGJS2jL3XM1XLquE98KNv
         8xfw==
X-Gm-Message-State: AOJu0YyJuQaYx5Pexwo1KrEOhO12dvERgtLkoEwOvrMcHnSK0UE1HPDj
	hF9MZY29ki0nTX6jM45fh1UUXtMg1a/lMxSRK48mlcbzann2Kw==
X-Google-Smtp-Source: AGHT+IE39wedx9qoJqNO6MjAU4E5XVco4roigw4JCooGGaUKrzldoRbPFpkW15iiHXNNuutcoyizp+NdmoWt5CbB2Gc=
X-Received: by 2002:a81:84d1:0:b0:5e9:94dc:b77f with SMTP id
 u200-20020a8184d1000000b005e994dcb77fmr123269ywf.9.1704993502233; Thu, 11 Jan
 2024 09:18:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is> <20240109181104.1670304-3-andri@yngvason.is>
 <CAPj87rNan8B5urDFkmD_Vti4to6p3NmvXYsTFQTNg-Ue2ieDug@mail.gmail.com>
 <CAFNQBQwiqqSRqzXAnC035UWCGF3=GGFR5SpDd=biPTOEA+cWbQ@mail.gmail.com>
 <ZZ509L_kmVC4IUBW@phenom.ffwll.local> <CAPj87rOiS8F=oDW3iE=bgFyfeJnYhy8kPF2v-uYOq3xgYtVPAg@mail.gmail.com>
In-Reply-To: <CAPj87rOiS8F=oDW3iE=bgFyfeJnYhy8kPF2v-uYOq3xgYtVPAg@mail.gmail.com>
From: Andri Yngvason <andri@yngvason.is>
Date: Thu, 11 Jan 2024 17:17:46 +0000
Message-ID: <CAFNQBQwjeJaX6B4oewpgASMUd5_nxZYMxUfdOG294CTVGBTd1w@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/uAPI: Add "active color format" drm property as
 feedback for userspace
To: Daniel Stone <daniel@fooishbar.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>, 
	Werner Sembach <wse@tuxedocomputers.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

mi=C3=B0., 10. jan. 2024 kl. 13:26 skrifa=C3=B0i Daniel Stone <daniel@foois=
hbar.org>:
> >
> > This thing here works entirely differently, and I think we need somewha=
t
> > new semantics for this:
> >
> > - I agree it should be read-only for userspace, so immutable sounds rig=
ht.
> >
> > - But I also agree with Daniel Stone that this should be tied more
> >   directly to the modeset state.
> >
> > So I think the better approach would be to put the output type into
> > drm_connector_state, require that drivers compute it in their
> > ->atomic_check code (which in the future would allow us to report it ou=
t
> > for TEST_ONLY commits too), and so guarantee that the value is updated
> > right after the kms ioctl returns (and not somewhen later for non-block=
ing
> > commits).
>
> That's exactly the point. Whether userspace gets an explicit
> notification or it has to 'know' when to read isn't much of an issue -
> just as long as it's well defined. I think the suggestion of 'do it in
> atomic_check and then it's guaranteed to be readable when the commit
> completes' is a good one.
>
> I do still have some reservations - for instance, why do we have the
> fallback to auto when userspace has explicitly requested a certain
> type? - but they may have been covered previously.
>

We discussed this further on IRC and this is summary of that discussion:

Sima proposed a new type of property that can be used to git feedback to
userspace after atomic ioctl. The user supplies a list of output properties
that they want to query and the kernel fills it in before returning from th=
e
ioctl. This would help to get some information about why things failed
during TEST_ONLY.

Emersion raised the point that you might not know how much memory is needed
beforehand for the returned properties, to which sima replied: blob
property. There was some discussion about how that makes it possible to lea=
k
kernel memory, especially if userspace does not know about a new property
blob. Emersion pointed out that userspace should only request properties
that it understands and pq agreed.

Emersion asked how the user should inform the kernel that it's done with th=
e
blob, to which sima replied: DRM_IOCTL_MODE_DESTROYPROPBLOB. Sima also
mentioned using some sort of weak reference garbage collection scheme for
properties and there was some further discussion, but I'm not sure there wa=
s
any conclusion.

I asked if it made sense to add color format capabilities to the mode info
struct, but the conclusion was that it wouldn't really be useful because we
need TEST_ONLY anyway to see if the color format setting is compatible with
other settings.

I asked again if we should drop the "active color format" property as it
seems to be more trouble than it's worth for now. pq mentioned that there
are 2 separate use cases (in his words):
- People playing with setting UI would like to know what "auto" would resul=
t
  in, but that's just nice to have
- The other use case is the flicker-free boot into known configuration He
  went on to point out that the main problem with "auto" is that any modese=
t
  could make the driver decide differently. This means that we cannot fully
  rely on the previously set property.

However, leaving out "active color property" did not put us in a worse
situation than before, so the conclusion was that we should leave it out fo=
r
now. For GUI selectors, the current TEST_ONLY should be good enough, and al=
l
the fancy stuff discussed previously isn't needed for now.

To summarise the summary: this means that we will drop the "active
color format" property and rename the "preferred color format"
property to "force color format" or just "color format" and failing to
satisfy that constraint will fail the modeset rather than falling back
to the "auto" behaviour.

Cheers,
Andri

