Return-Path: <linux-kernel+bounces-22229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701F4829B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E172893DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B3487BF;
	Wed, 10 Jan 2024 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="ex5xt/dz"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295ED3FB3A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67f9f6caabcso29621756d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1704893219; x=1705498019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuoo03iviwWHkadCNQ9VBPxTicDGZj9k5/ZvAak2Qbc=;
        b=ex5xt/dz232KyKLRhd4TxvgnZLLpEsAXxuj/8d476ESLx4CCGBCf+9c//2/0d2af4K
         hqx0UBlzfCF+3JOiQfZpVN0SgIoiB47Z/pemFRpc7d+6cIFxgSWX0q4eV+Nnf5EVHFcl
         FtbLiZBo91yGILxOX5/e3FzeX4GYDNQaGR+lc3j937xcHJLjv7MqpG+A9GlxWYza6wvV
         dRxm3Oi5KJ5zLQ/iAmZZWzB8IeTh0uwbGAfTS32ifTE3eriF5urYkdehLLM2iOGW9+n0
         JwjMuy8MiIoTpBttS8ygte0f10nvpZK6wMp/Q0CoVKnV7lLRuRd4lPlq217HBQyQQUFi
         QgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704893219; x=1705498019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuoo03iviwWHkadCNQ9VBPxTicDGZj9k5/ZvAak2Qbc=;
        b=Em8hbeaJ+xCvU/Z8D1kz1SPQFUoptwb6IwAM0rnGgBMSZbj/1ncHrpDDz8e3rDPV49
         G1BMqp9rdFC7sYZ/PGvc3RjWkwqW9AxTtw4VRFNwkiitZUKdx3PvWOKTdXIx9+Fvq9CB
         8Mh0fNJ/o6j9lzE5bP+ekWPb/dTALYUCN/AtGIVkdcY7+FlddEb5ZFCROl+yB7q8wfii
         l0z32iR9js+adhOipHEU3Rnk5BvK29g6S8aCf4KlD2Npvh5gSQNxXCdr4jBCDEa9MN//
         T384j9xLseOkMR0qzUZWu3BW7uvZlKsUQZpWM5icYZbpn3oJWrV3umWEjWd5f3RDiCQc
         x88g==
X-Gm-Message-State: AOJu0YxeHJdZAYpRAPHeNPXp9txeRCGJAxYa74y4mDK/BCzhp16V/OG2
	7DlzCf8/u/MYC63yz0pLqm/75kByL2x7Xum1uA1/Lv4CZaWj0g==
X-Google-Smtp-Source: AGHT+IGdIXuMwkWII7EUXBHcbytK3jAqcLwzlJCM9W48o+05Ly6ZHA8R+Kz3tpJUp7CvP/x73Q5f0ChjbDvYlVh7+7A=
X-Received: by 2002:a05:6214:1630:b0:680:f8b7:44fe with SMTP id
 e16-20020a056214163000b00680f8b744femr985896qvw.13.1704893218734; Wed, 10 Jan
 2024 05:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is> <20240109181104.1670304-3-andri@yngvason.is>
 <CAPj87rNan8B5urDFkmD_Vti4to6p3NmvXYsTFQTNg-Ue2ieDug@mail.gmail.com>
 <CAFNQBQwiqqSRqzXAnC035UWCGF3=GGFR5SpDd=biPTOEA+cWbQ@mail.gmail.com> <ZZ509L_kmVC4IUBW@phenom.ffwll.local>
In-Reply-To: <ZZ509L_kmVC4IUBW@phenom.ffwll.local>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 10 Jan 2024 13:26:46 +0000
Message-ID: <CAPj87rOiS8F=oDW3iE=bgFyfeJnYhy8kPF2v-uYOq3xgYtVPAg@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/uAPI: Add "active color format" drm property as
 feedback for userspace
To: Andri Yngvason <andri@yngvason.is>, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>, 
	Werner Sembach <wse@tuxedocomputers.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 10 Jan 2024 at 10:44, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Jan 09, 2024 at 11:12:11PM +0000, Andri Yngvason wrote:
> > =C5=A3ri., 9. jan. 2024 kl. 22:32 skrifa=C4=91i Daniel Stone <daniel@fo=
oishbar.org>:
> > > How does userspace determine what's happened without polling? Will it
> > > only change after an `ALLOW_MODESET` commit, and be guaranteed to be
> > > updated after the commit has completed and the event being sent?
> > > Should it send a HOTPLUG event? Other?
> > >
> >
> > Userspace does not determine what's happened without polling. The purpo=
se
> > of this property is not for programmatic verification that the preferre=
d
> > property was applied. It is my understanding that it's mostly intended =
for
> > debugging purposes. It should only change as a consequence of modesetti=
ng,
> > although I didn't actually look into what happens if you set the "prefe=
rred
> > color format" outside of a modeset.
>
> This feels a bit irky to me, since we don't have any synchronization and
> it kinda breaks how userspace gets to know about stuff.
>
> For context the current immutable properties are all stuff that's derived
> from the sink (like edid, or things like that). Userspace is guaranteed t=
o
> get a hotplug event (minus driver bugs as usual) if any of these change,
> and we've added infrastructure so that the hotplug event even contains th=
e
> specific property so that userspace can avoid re-read (which can cause
> some costly re-probing) them all.

Right.

> [...]
>
> This thing here works entirely differently, and I think we need somewhat
> new semantics for this:
>
> - I agree it should be read-only for userspace, so immutable sounds right=
.
>
> - But I also agree with Daniel Stone that this should be tied more
>   directly to the modeset state.
>
> So I think the better approach would be to put the output type into
> drm_connector_state, require that drivers compute it in their
> ->atomic_check code (which in the future would allow us to report it out
> for TEST_ONLY commits too), and so guarantee that the value is updated
> right after the kms ioctl returns (and not somewhen later for non-blockin=
g
> commits).

That's exactly the point. Whether userspace gets an explicit
notification or it has to 'know' when to read isn't much of an issue -
just as long as it's well defined. I think the suggestion of 'do it in
atomic_check and then it's guaranteed to be readable when the commit
completes' is a good one.

I do still have some reservations - for instance, why do we have the
fallback to auto when userspace has explicitly requested a certain
type? - but they may have been covered previously.

Cheers,
Daniel

