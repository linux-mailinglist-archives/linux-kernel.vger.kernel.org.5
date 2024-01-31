Return-Path: <linux-kernel+bounces-46112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ADB843A81
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0317A1F2A3C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCBC60BAD;
	Wed, 31 Jan 2024 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CdTe1YQU"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186EF605D5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692270; cv=none; b=l1ktIc3BOZjQWkUCsWA3CBXwAdvVjTmjENGTKaOTkAy3jyFFlrkmGDVX1Vx8hCK23JYn30z5ak02+TC+bmRkd63e3QEFjRmFSwGk96MiBwQQ3kGOQDio3BEdfbOc1e+d3cPy6ZhhSkCa2Ifyb629qT5yMwTrrJZGky5U7L1rcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692270; c=relaxed/simple;
	bh=NH2etRj/6qjghtCNgvl/AG6envctjUG+1+4PACKTM48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT7icDPXnVFCZkAUpaQ9uXz3VFHydEuHPfCAZcFGxIM3jSsrN82kfzMKFKoklCpVv0xKdKF7e61NRWBFjnafHOUZJlcb+a0gz6Qvrf0TRXP+a63dwWQhDeMtgCoADk62huHmMHNizm3hcv8M27x3tLCOpcy77VfOfvNTvv2rl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=CdTe1YQU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a27e7b70152so186560866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706692267; x=1707297067; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORBEpQ5F08UVhnCzKa+jzZ+oJJNJsZKWbQ0DCuxPaWc=;
        b=CdTe1YQUzexoGnXkejwtL73hxANu+i1V3y0cjRlzNu57zGNnwytqoKXFyowqBJs58/
         jhYSSdcMMpB+cAE227b92rcJGVqqEes7E1xXMswBb8TVQM+ICNgArqdplfDoa2AQLNXg
         vICo0cfxNGunjuUMuTkBSAmbr3MER2eTZHglM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692267; x=1707297067;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORBEpQ5F08UVhnCzKa+jzZ+oJJNJsZKWbQ0DCuxPaWc=;
        b=M1kkYjWXLlH7Pto44JEavGCoepYv5VbOI/KfoFW7lRzwJxFxHZwNeakzxQPMI6gUV9
         vCaiFKOj+LIo4YPv8TRvD9wMtfIg5yVliDdW6b44elPB8YawWBITT1P8f885wcDaqq+d
         bgARmodGEAhORgoYpyqfMi32GCQW5YRAyaG5+8PY1GioHpDCIlZ0TYxsrDcY1RGxYm6Z
         bDjFefkDnK7IyihI07t8dIiAgXgAq47FwWcj6b1zjb0UchIxlsiT51X0HF1cB1H5TgW4
         D24LYzGhPdHIhGwu/N4uAMCEuYfDF3wgMn8GmSs+uIon4Hr+mKDdlx9qF6AxM5mFOG+7
         nckw==
X-Gm-Message-State: AOJu0Ywkj45sIpbMGxQL3seLK0tz8vgd8XpFlOkr96FtP1kLxrjHgWha
	oRarNVzassOzgen1z6riKVNvEOlzTQdcOH+n0FgwNGJymFf1kl7MCxUBFRpbTQs=
X-Google-Smtp-Source: AGHT+IHHkRoncH5TZwJ2KO/1SVucsjdiD6pGPJaM5NKeKM2EzUdubU6eh2uy4dvG7OzWu32QgOh+eg==
X-Received: by 2002:a17:906:4a52:b0:a35:b6a1:712d with SMTP id a18-20020a1709064a5200b00a35b6a1712dmr697445ejv.2.1706692266392;
        Wed, 31 Jan 2024 01:11:06 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906254900b00a311685890csm5987876ejb.22.2024.01.31.01.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:11:05 -0800 (PST)
Date: Wed, 31 Jan 2024 10:11:03 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>
Cc: "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
	"michel@daenzer.net" <michel@daenzer.net>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"mikita.lipski@amd.com" <mikita.lipski@amd.com>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"maxime@cerno.tech" <maxime@cerno.tech>,
	"daniel.vetter@intel.com" <daniel.vetter@intel.com>,
	"nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"quic_abhinavk@quicinc.com" <quic_abhinavk@quicinc.com>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"manasi.d.navare@intel.com" <manasi.d.navare@intel.com>,
	"lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
	"sean@poorly.run" <sean@poorly.run>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
	"fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"jani.nikula@intel.com" <jani.nikula@intel.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
Subject: Re: [PATCH] drm/atomic-helpers: remove legacy_cursor_update hacks
Message-ID: <ZboOp7JOp5teV1Cs@phenom.ffwll.local>
Mail-Followup-To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"michel@daenzer.net" <michel@daenzer.net>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"mikita.lipski@amd.com" <mikita.lipski@amd.com>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"maxime@cerno.tech" <maxime@cerno.tech>,
	"daniel.vetter@intel.com" <daniel.vetter@intel.com>,
	"nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"quic_abhinavk@quicinc.com" <quic_abhinavk@quicinc.com>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"manasi.d.navare@intel.com" <manasi.d.navare@intel.com>,
	"lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
	"sean@poorly.run" <sean@poorly.run>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
	"fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"jani.nikula@intel.com" <jani.nikula@intel.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
References: <20230216111214.3489223-1-daniel.vetter@ffwll.ch>
 <20230307145613.xvhru3fpcudlpazt@houat>
 <aac416742920953999a9ce230ac68139bf5b9790.camel@mediatek.com>
 <ZbKlsTEvGPiGtzS3@phenom.ffwll.local>
 <1349365de499bae53a8c868738c7270fc16813d5.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1349365de499bae53a8c868738c7270fc16813d5.camel@mediatek.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Wed, Jan 31, 2024 at 05:17:08AM +0000, Jason-JH Lin (林睿祥) wrote:
> On Thu, 2024-01-25 at 19:17 +0100, Daniel Vetter wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Tue, Jan 23, 2024 at 06:09:05AM +0000, Jason-JH Lin (林睿祥) wrote:
> > > Hi Maxime, Daniel,
> > > 
> > > We encountered similar issue with mediatek SoCs.
> > > 
> > > We have found that in drm_atomic_helper_commit_rpm(), when
> > disabling
> > > the cursor plane, the old_state->legacy_cursor_update in
> > > drm_atomic_wait_for_vblank() is set to true.
> > > As the result, we are not actually waiting for a vlbank to wait for
> > our
> > > hardware to close the cursor plane. Subsequently, the execution
> > > proceeds to drm_atomic_helper_cleanup_planes() to  free the cursor
> > > buffer. This can lead to use-after-free issues with our hardware.
> > > 
> > > Could you please apply this patch to fix our problem?
> > > Or are there any considerations for not applying this patch?
> > 
> > Mostly it needs someone to collect a pile of acks/tested-by and then
> > land
> > it.
> > 
> 
> Got it. I would add tested-by tag for mediatek SoC.
> 
> > I'd be _very_ happy if someone else can take care of that ...
> > 
> > There's also the potential issue that it might slow down some of the
> > legacy X11 use-cases that really needed a non-blocking cursor, but I
> > think
> > all the drivers where this matters have switched over to the async
> > plane
> > update stuff meanwhile. So hopefully that's good.
> > 
> 
> I think all the drivers should have switched to async plane update.
> 
> Can we add the checking condition to see if atomic_async_update/check
> function are implemented?

Pretty sure not all have done that, so really it boils down to whether we
break a real user's use-case. Which pretty much can only be checked by
merging the patch (hence the requirement to get as many acks as possible
from display drivers) and then being willing to handle any fallout that's
reported as regressions for a specific driver.

It's a pile of work, at least when it goes south, that's why I'm looking
for volunteers.

Note that handling the fallout doesn't mean you have to fix that specific
driver, the only realistic option might be to reinstate the legacy cursor
behaviour, but as an explicit opt-in that only that specific driver
enables.

So maybe for next round of that patch it might be good to have a 2nd patch
which implements this fallback plan in the shared atomic modeset code?

Cheers, Sima

> 
> Regards,
> Jason-JH.Lin
> 
> > Cheers, Sima
> > > 
> > > Regards,
> > > Jason-JH.Lin
> > > 
> > > On Tue, 2023-03-07 at 15:56 +0100, Maxime Ripard wrote:
> > > > Hi,
> > > > 
> > > > On Thu, Feb 16, 2023 at 12:12:13PM +0100, Daniel Vetter wrote:
> > > > > The stuff never really worked, and leads to lots of fun because
> > it
> > > > > out-of-order frees atomic states. Which upsets KASAN, among
> > other
> > > > > things.
> > > > > 
> > > > > For async updates we now have a more solid solution with the
> > > > > ->atomic_async_check and ->atomic_async_commit hooks. Support
> > for
> > > > > that
> > > > > for msm and vc4 landed. nouveau and i915 have their own commit
> > > > > routines, doing something similar.
> > > > > 
> > > > > For everyone else it's probably better to remove the use-after-
> > free
> > > > > bug, and encourage folks to use the async support instead. The
> > > > > affected drivers which register a legacy cursor plane and don't
> > > > > either
> > > > > use the new async stuff or their own commit routine are:
> > amdgpu,
> > > > > atmel, mediatek, qxl, rockchip, sti, sun4i, tegra, virtio, and
> > > > > vmwgfx.
> > > > > 
> > > > > Inspired by an amdgpu bug report.
> > > > 
> > > > Thanks for submitting that patch. It's been in the downstream RPi
> > > > tree
> > > > for a while, so I'd really like it to be merged eventually :)
> > > > 
> > > > Acked-by: Maxime Ripard <maxime@cerno.tech>
> > > > 
> > > > Maxime
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

