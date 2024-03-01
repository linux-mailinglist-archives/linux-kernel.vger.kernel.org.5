Return-Path: <linux-kernel+bounces-88473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352CB86E217
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49EC289D55
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C47870CDC;
	Fri,  1 Mar 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmdJHaBd"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B26F06D;
	Fri,  1 Mar 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299815; cv=none; b=CWtgbQPyt08pWP2cgclO5dEw7TGo/67xvyv3md+VEbGkcqOmDU3Q29NBfP+Etmc4rEy1lmbJHDtzHU3D5dgX/w2Krl6X7AFVVN0hi/dQhFSvRoIZFyCGCDCytwDgcJtZ+tpRZF6tysS7voB/nxFn7kNoBgrcMhuiIlZNhMdoIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299815; c=relaxed/simple;
	bh=Cb3N2rHpFtZQNAnh8qaVDyGADLlBDepE3AHgVkfB5/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSWVwQfdmsXQcU1nkU4ds9pYRL1tXrj6paBrwwlgftTaTgpe8uN1xHO1u5gSQOF7bTifWz8e0uWRBu4JCs5DRoVugok8Dttf0b78W30pZgxihItyij681/xnl5LkpdCL6sVupfV7ZYKRkLhH9sZDFfqi9vVnkZmpymJ1tP/oWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmdJHaBd; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so1843292a12.1;
        Fri, 01 Mar 2024 05:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709299813; x=1709904613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HHckA948ZmaGkyMViYat8ojP3Slv0abWxwkHxBmiobA=;
        b=FmdJHaBd+vm+05n71QyKuZTU4jegTE23JLXB0hhpdwJla4DAv7K/z/mK67HBd3kDWp
         UtHKCFGEwAZRbcL2VLQCDXGrnU0X7W4fqMagEsHux11BjwDCLKoNCmLS/TwsTZQIbWV9
         ccSe2AMPj8e0fNbwgV8kZNCk4zjBMR46IchgqEVBKKmdNELTk4L1S2cx3OceAZczq+2p
         m2xVpszc65nVTKgth/qPhIkO+irkoYIatBBrM3YlmhCazS6lyJGV/XczExkCnijA/AUS
         MKuhjnkOsTlbf658LhymSF07V7LMheWe9EwzCwIHD69yw7XMpHhzx5S3wFT8DnGOv8OF
         ENyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709299813; x=1709904613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHckA948ZmaGkyMViYat8ojP3Slv0abWxwkHxBmiobA=;
        b=K0WRQ8aAKSoDc2Co1K6aRDPtDJ5LxHDi3dP4S4GgQD6UQk1PAlRL6qfUNyu6W507PZ
         Wj+qCtbXzB1Pi1YFtyJ2dwqJppjVs11KzhE66AkkrgbH9abU0FD9C6Bb0cAZ6ARgui1t
         lXtLnpoGE3joCh/ReqHzFjJvzfj6MdlOD75RRj5j5atopaXzL//W31i1v+fTHoBwOPIy
         J+qqXCB+sSXoNr8fIbAkL/o2AqvpqbFiHA13gCFTwIKiBZ7Km5xO1x2z+m9+4xfyp8mS
         IIYOlBNmGlSdSs2pV/3AUMKz1vAAT1ZRXtXCl/tQCmJZWzfICbi3Xq4Br41jMHD0ArRX
         TtdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf0rd0RI7szp35qJ2WnMhKPGnkpSdk5vBwnupu+42QhwupsWLM1+rdwlzt4GgMWyX3GnNIVuxgQRAeOoYgrdCBFGPCXQP2CWH2gEpECqRSBAlJADo8iMclvClh/hh1PnAs8foR
X-Gm-Message-State: AOJu0Yw8PhpgtWoVAjTA/kd02MC7TTEpl0Qv4YEQHorP+oVNGExwef//
	6XQPdFtXdW/BWSz55G/DORQWmZpBaM4rfkj28Be4AyzGNtCcY0CcqjSghuv9I1Pxh2VcP42D/dL
	CJxEZc3svICdReKDFQoSemN4Tp+bmJyJ8CG90fw==
X-Google-Smtp-Source: AGHT+IFjPiaNvT7Wmp/5bfnXXjIvPQWaa0U3BGSTH5v/V1+baHlSVrYfIKXQxO+DT5ucIicUHZPSIsOYQ1+VUT2jHHs=
X-Received: by 2002:a17:90a:4981:b0:29b:6a7:c52c with SMTP id
 d1-20020a17090a498100b0029b06a7c52cmr1588418pjh.38.1709299812985; Fri, 01 Mar
 2024 05:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229195532.7815-1-christian.gmeiner@gmail.com> <2d65be7ae251221bd7524871e0cbf4b22d16a9f9.camel@pengutronix.de>
In-Reply-To: <2d65be7ae251221bd7524871e0cbf4b22d16a9f9.camel@pengutronix.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 1 Mar 2024 14:30:01 +0100
Message-ID: <CAH9NwWe3r1sbB7BqW1zmFGxjnzOOg8Z-LBzhAP7x_kq=o9T=0A@mail.gmail.com>
Subject: Re: [PATCH] etnaviv: Restore some id values
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lucas,

>
> prefix for etnaviv kernel patches should be "drm/etnaviv: ..."

Ah yeah .. corrected in v2.

>
> Am Donnerstag, dem 29.02.2024 um 20:55 +0100 schrieb Christian Gmeiner:
> > From: Christian Gmeiner <cgmeiner@igalia.com>
> >
> > The hwdb selection logic as a feature that allows it to mark some fields
> > as 'don't care'. If we match with such a field we memcpy(..)
> > the current etnaviv_chip_identity into ident.
> >
> > This step can overwrite some id values read from the GPU with the
> > 'don't care' value.
> >
> > Fix this issue by restoring the affected values after the memcpy(..).
> >
> > As this is crucial for user space to know when this feature works as
> > expected increment the minor version too.
>
> Uh, right. Lying to userspace about the GPU identity doesn't seem like
> a good idea.
>
> >
> > Fixes: 4078a1186dd3 ("drm/etnaviv: update hwdb selection logic")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.c  |  2 +-
> >  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 14 ++++++++++++++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > index 6228ce603248..9a2965741dab 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > @@ -494,7 +494,7 @@ static const struct drm_driver etnaviv_drm_driver = {
> >       .desc               = "etnaviv DRM",
> >       .date               = "20151214",
> >       .major              = 1,
> > -     .minor              = 3,
> > +     .minor              = 4,
> >  };
> >
> >  /*
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> > index 67201242438b..1e38d66702f1 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> > @@ -265,6 +265,9 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
> >  bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
> >  {
> >       struct etnaviv_chip_identity *ident = &gpu->identity;
> > +     const u32 product_id = ident->product_id;
> > +     const u32 customer_id = ident->customer_id;
> > +     const u32 eco_id = ident->eco_id;
> >       int i;
> >
> >       for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
> > @@ -278,6 +281,17 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
> >                        etnaviv_chip_identities[i].eco_id == ~0U)) {
> >                       memcpy(ident, &etnaviv_chip_identities[i],
> >                              sizeof(*ident));
> > +
> > +                     /* Restore some id values if ~0U aka 'don't care' is used. */
> > +                     if (etnaviv_chip_identities[i].product_id == ~0U)
>
> You can drop all those if clauses. Either the hwdb value is an exact
> match and the value is the same or it's the don't care value and you
> want to restore it, so a simple unconditional assignment would make
> this a bit more compact.
>

Makes sense - thanks for your review!

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

