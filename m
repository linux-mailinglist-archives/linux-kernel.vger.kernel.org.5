Return-Path: <linux-kernel+bounces-22006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB58297CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B2E281D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6DF40C12;
	Wed, 10 Jan 2024 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TkZpBCd+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9F405C6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55369c59708so711591a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704883447; x=1705488247; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UMDg8vYs5fytU0eXd7i9MvEuOqrlrSDfuGIjAzp5aO8=;
        b=TkZpBCd+qzZZhlKocDcYAOVpyRjZqh0e18Q1JcH+PH/JLH757sqTf41GTWBigULkg8
         ObGeGLbfD9PoyTv9nu8/O+NyhBWkPhqpHDo7uYUhp8EBczYnDXspobRl1aTYbCAbGz7V
         3OVw7meQQSAqUNjLeG4HauSzeRkdA32POCZDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883447; x=1705488247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMDg8vYs5fytU0eXd7i9MvEuOqrlrSDfuGIjAzp5aO8=;
        b=YWMcwKUkfSC053M+5fxknqGDm+guzysnOEQOXzP1GfIxz2DYjRyD9p54Qvnj/rentg
         38PKtCjGuXsHD3LP4ttLdR4WI1817Ov2TbbfhIdpOUlHwPMRE77P6hyo2nF+Bxqv9Lme
         0m57wQgFcTjyqa8enHuRB9LrubqFjYU0TvT+yks+24Mlwo8jUR4SNKdAz54IIesYv4EV
         pG+arsx7W4StlKcryJA3U+6U//r082RFsQyJs1ZZpil5O1Xkm+a1f+ixIXk1oOaWERV5
         UYJtSxFLv4DFPAf7N6m29kjEdWCRJmasEGGaGF96NO80uURfht2lL3kmUj5wBBG0fyHg
         dYsQ==
X-Gm-Message-State: AOJu0Yw2Uuxw0PVFpGrV2END/W/So5JqGdjHYmz0WiXoac+JCyrhW1Mb
	FmoEgkpVqD6ZRwodwFqhwdjoM6FZZWqHQQ==
X-Google-Smtp-Source: AGHT+IGq5gfRJlxZlKGWvfar8Z1t60a4l9NJUielIcSGPeGv8HnSSId42vEbByEzK0cy5OcGqHFXHg==
X-Received: by 2002:a50:aacb:0:b0:557:1b89:4f01 with SMTP id r11-20020a50aacb000000b005571b894f01mr910339edc.2.1704883447330;
        Wed, 10 Jan 2024 02:44:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p31-20020a056402501f00b005585049ddc9sm569130eda.45.2024.01.10.02.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:44:06 -0800 (PST)
Date: Wed, 10 Jan 2024 11:44:04 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Andri Yngvason <andri@yngvason.is>
Cc: Daniel Stone <daniel@fooishbar.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	Simon Ser <contact@emersion.fr>,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH 2/7] drm/uAPI: Add "active color format" drm property as
 feedback for userspace
Message-ID: <ZZ509L_kmVC4IUBW@phenom.ffwll.local>
Mail-Followup-To: Andri Yngvason <andri@yngvason.is>,
	Daniel Stone <daniel@fooishbar.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	Simon Ser <contact@emersion.fr>,
	Werner Sembach <wse@tuxedocomputers.com>
References: <20240109181104.1670304-1-andri@yngvason.is>
 <20240109181104.1670304-3-andri@yngvason.is>
 <CAPj87rNan8B5urDFkmD_Vti4to6p3NmvXYsTFQTNg-Ue2ieDug@mail.gmail.com>
 <CAFNQBQwiqqSRqzXAnC035UWCGF3=GGFR5SpDd=biPTOEA+cWbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFNQBQwiqqSRqzXAnC035UWCGF3=GGFR5SpDd=biPTOEA+cWbQ@mail.gmail.com>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Tue, Jan 09, 2024 at 11:12:11PM +0000, Andri Yngvason wrote:
> Hi Daniel,
> 
> þri., 9. jan. 2024 kl. 22:32 skrifaði Daniel Stone <daniel@fooishbar.org>:
> 
> > On Tue, 9 Jan 2024 at 18:12, Andri Yngvason <andri@yngvason.is> wrote:
> > > + * active color format:
> > > + *     This read-only property tells userspace the color format
> > actually used
> > > + *     by the hardware display engine "on the cable" on a connector.
> > The chosen
> > > + *     value depends on hardware capabilities, both display engine and
> > > + *     connected monitor. Drivers shall use
> > > + *     drm_connector_attach_active_color_format_property() to install
> > this
> > > + *     property. Possible values are "not applicable", "rgb",
> > "ycbcr444",
> > > + *     "ycbcr422", and "ycbcr420".
> >
> > How does userspace determine what's happened without polling? Will it
> > only change after an `ALLOW_MODESET` commit, and be guaranteed to be
> > updated after the commit has completed and the event being sent?
> > Should it send a HOTPLUG event? Other?
> >
> 
> Userspace does not determine what's happened without polling. The purpose
> of this property is not for programmatic verification that the preferred
> property was applied. It is my understanding that it's mostly intended for
> debugging purposes. It should only change as a consequence of modesetting,
> although I didn't actually look into what happens if you set the "preferred
> color format" outside of a modeset.

This feels a bit irky to me, since we don't have any synchronization and
it kinda breaks how userspace gets to know about stuff.

For context the current immutable properties are all stuff that's derived
from the sink (like edid, or things like that). Userspace is guaranteed to
get a hotplug event (minus driver bugs as usual) if any of these change,
and we've added infrastructure so that the hotplug event even contains the
specific property so that userspace can avoid re-read (which can cause
some costly re-probing) them all.

As an example you can look at drm_connector_set_link_status_property,
which drivers follow by a call to drm_kms_helper_connector_hotplug_event
to make sure userspace knows about what's up. Could be optimized I think.

This thing here works entirely differently, and I think we need somewhat
new semantics for this:

- I agree it should be read-only for userspace, so immutable sounds right.

- But I also agree with Daniel Stone that this should be tied more
  directly to the modeset state.

So I think the better approach would be to put the output type into
drm_connector_state, require that drivers compute it in their
->atomic_check code (which in the future would allow us to report it out
for TEST_ONLY commits too), and so guarantee that the value is updated
right after the kms ioctl returns (and not somewhen later for non-blocking
commits).

You probably need a bit of work to be able to handle immutable properties
with the atomic state infrastructure, but I think otherwise this should
fit all rather neatly.

Cheers, Sima
> 
> The way I've implemented things in sway, calling the
> "preferred_signal_format" command triggers a modeset with the "preferred
> color format" set and calling "get_outputs", immediately queries the
> "actual color format" and displays it.
> 
> Regards,
> Andri

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

