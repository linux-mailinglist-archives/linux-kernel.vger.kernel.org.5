Return-Path: <linux-kernel+bounces-63449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61DD852FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AE91C2258E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8838DFC;
	Tue, 13 Feb 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="ZskQNqdd"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE5938DD5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824407; cv=none; b=a6keQHSDW3M+qvxBbCiLctBBLi3PeIdxQNKAHm4zGj0L4rxa3LIXRHLoJExumN5uhHx1SokdtQX0Ab5NSSNHRYy6S5RfFgdFlRJbzLDEYrqcMzES+j2yMiLdxKeVYYpjRhec1zkSmcyM+u2dZl495x6unOia3PzShNlVj4JF2Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824407; c=relaxed/simple;
	bh=5Q2HXSgg+WfNCJ48Lf3xpfGuoRZjbywT1xHUXRUUcU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbSQU5LMtdlqPR//xGP8VryQPlfkyT6flJkOfGIQRmUUDcleU/zov7ZEJ+FImwSoNben++Ny+tTEZ5HT37kOgfGvrcX+o7pWsMNIbdAscbxbLCXB5trsBb7pEu75nIkNHsWY2w7m1Gkxfwv+qDMHwOt5/M3s8BTAfVDOWIQwRNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=ZskQNqdd; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbbc6bcc78so3292972b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1707824405; x=1708429205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q2HXSgg+WfNCJ48Lf3xpfGuoRZjbywT1xHUXRUUcU4=;
        b=ZskQNqddfZI+gxMdYQ8F9NPNrv6CrHSCiA3F/hPu8g94Bs4eFRVIMjlC5ygXrEWb4L
         xXkHT5TRtZzLfVgg5XmljMlNit34scTctLgZhgCO2YCrDu5Mbfk4QP5/hLxuDARDRFX3
         7upeAKFsGk50WwhMVJpkXLYXFfAww9QemCuyYnrBtJHoUeuKbfq9CM6fqRAVNemyb+hy
         0MuF/XwN8DahkugryOPvBP+J+8W3HIjCQiK2RiGaQ8lxweW1621PMheWCHpjnkkQmrdX
         W/HAbMheG0FT0bxPZGwmwPrzQbq8V99sULybOkY2ey6PQJT2lzrkpCzYwbsp34LR2sKe
         uPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707824405; x=1708429205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Q2HXSgg+WfNCJ48Lf3xpfGuoRZjbywT1xHUXRUUcU4=;
        b=oD/bFv9pGEeegzwyn2Jwesm3gHF5YfE9JOETATA6uH+x8p3+BTQu3qlNafxIaq9/HH
         1Pl+UJHnX0QCFLTAqT98kfiAFnr/4I7ybi+CZe43DyWo6N3OvGnfdD3+eCfXI1KA+dgM
         9AlAfJBcZxsC56cKlILTagmxvNx576b0dUw6YU9wIzyloK7VAaktFnztWshGKg4Ru7TJ
         RA585BhUf4y1ZihLbl4FJxX49vSqcS4JYS5zef19/+jGRWAfvWmQJwM0PxXAHpMOJsKT
         1FBKSS/X1bCM5mO4TECc5p9RXAhzXr4qAwOk8zdQnJ0Fybmm1VnHCtlCcvy4v0aq5mYc
         ojQg==
X-Forwarded-Encrypted: i=1; AJvYcCUi//mnV6SePOEiM2S5hk0tKO2gh8OXAvez7oqP5K+hh6qyi7eb0NDvvHKQkfIJnLbL/YNKSsqTZr/b/8Rv4hG+C9vJC3jyA7qBOvgB
X-Gm-Message-State: AOJu0YxqQEDHyD1cwl5MJZcglY9T1L+IXvMWeKLwBcvbNpLG3mBinuo8
	WqGoPQ2Ig4PiuJwBHgPdo96/zvIwg1Ju6++rUiDv1W4GUCiQ+lc8qLeD9DS4kRDVhqRcZVxcXeJ
	rI7pbSU/rTfC9f633Fvy2aEvsCxHWQutOo7Ryxg==
X-Google-Smtp-Source: AGHT+IGY/umyWm9bGSp8LHaGaJz80J84aewnjhUP9V6Jb+gnCRdR0+blD57TP5/5wjkX/1eM5Zy3sDhyNB6cBCf5o5M=
X-Received: by 2002:a05:6808:302a:b0:3c0:32d7:b93b with SMTP id
 ay42-20020a056808302a00b003c032d7b93bmr8548576oib.50.1707824404899; Tue, 13
 Feb 2024 03:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-tidss-fixes-v1-0-d709e8dfa505@ideasonboard.com>
 <20240213-tidss-fixes-v1-1-d709e8dfa505@ideasonboard.com> <20240213110440.13af335a@eldfell>
 <bb8089cd-2a57-4ed0-a8bd-2140a89b0887@ideasonboard.com> <ZctCCCJORdDEaDl1@xpredator>
In-Reply-To: <ZctCCCJORdDEaDl1@xpredator>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 13 Feb 2024 11:39:53 +0000
Message-ID: <CAPj87rPpdOQLLu5oGVfqDUh0_j9NXqc3XgZe5=tcOzUfVoeeqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/tidss: Fix initial plane zpos values
To: Marius Vlad <marius.vlad@collabora.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Pekka Paalanen <pekka.paalanen@haloniitty.fi>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sam Ravnborg <sam@ravnborg.org>, Devarsh Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, 
	Francesco Dolcini <francesco@dolcini.it>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	"wayland-devel@lists.freedesktop.org" <wayland-devel@lists.freedesktop.org>, Randolph Sapp <rs@ti.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 13 Feb 2024 at 10:18, Marius Vlad <marius.vlad@collabora.com> wrote:
> On Tue, Feb 13, 2024 at 11:57:59AM +0200, Tomi Valkeinen wrote:
> > I haven't. I'm quite unfamiliar with Weston, and Randolph from TI (cc'd) has
> > been working on the Weston side of things. I also don't know if there's
> > something TI specific here, as the use case is with non-mainline GPU drivers
> > and non-mainline Mesa. I should have been a bit clearer in the patch
> > description, as I didn't mean that upstream Weston has a bug (maybe it has,
> > maybe it has not).

Don't worry about it. We've had bugs in the past and I'm sure we'll
have more. :) Either way, it's definitely better to have the kernel
expose sensible behaviour rather than weird workarounds, unless
they've been around for so long that they're basically baked into ABI.

> > The issue seen is that when Weston decides to use DRM planes for
> > composition, the plane zpositions are not configured correctly (or at all?).
> > Afaics, this leads to e.g. weston showing a window with a DRM "overlay"
> > plane that is behind the "primary" root plane, so the window is not visible.
> > And as Weston thinks that the area supposedly covered by the overlay plane
> > does not need to be rendered on the root plane, there are also artifacts on
> > that area.
> >
> > Also, the Weston I used is a bit older one (10.0.1), as I needed to go back
> > in my buildroot versions to get all that non-mainline GPU stuff compiled and
> > working. A more recent Weston may behave differently.
>
> Right after Weston 10, we had a few minor changes related to the
> zpos-sorting list of planes and how we parse the plan list without having
> a temporary zpos ordered list to pick planes from.
>
> And there's another fix for missing out to set out the zpos for scanout
> to the minimum available - which seems like a good candidate to explain
> what happens in the issue described above. So if trying Weston again,
> please try with at least Weston 12, which should have those changes
> in.

Specifically, you probably want commits 4cde507be6a1 and 58dde0e0c000.
I think the window of breakage was small enough that - assuming either
those commits or an upgrade to Weston 12/13 fixes it - we can just ask
people to upgrade to a fixed Weston.

> > Presuming this is not related to any TI specific code, I guess it's a
> > regression in the sense that at some point Weston added the support to use
> > planes for composition, so previously with only a single plane per display
> > there was no issue.

That point was 12 years ago, so not that novel. ;)

Cheers,
Daniel

