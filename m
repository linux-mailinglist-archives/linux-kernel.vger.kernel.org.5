Return-Path: <linux-kernel+bounces-21527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646F98290C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13862288155
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADE63E478;
	Tue,  9 Jan 2024 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="IHr+JpU4"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003893BB20
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5f8cf76ef5bso22099457b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1704842534; x=1705447334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebXuRtZ+jV+LA1Jw2fSqPglODs+5bJfr1352MU2Bcvc=;
        b=IHr+JpU4D9WgsuCfEhOl4L4y6MIEnOKIkBOaH8gYN/MXBjgge3LmhtbYsy9C9j8EcR
         xC9pF57oBeen/JYZItNFHxPen3Xm1rAgq8egHPyEpJ6bQmPyh9JdyrnoEhAI2V9FtTGu
         U6xV16tBWoIRz/ToTbMZ0Eu18netQ69R7Fvd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704842534; x=1705447334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebXuRtZ+jV+LA1Jw2fSqPglODs+5bJfr1352MU2Bcvc=;
        b=OKdedrHEz6qOA+XLuqAwaSfhU+LOQwTYTduWBW/UfPFHa95mnQC89rZujyo6Z6lign
         xGm4Ht1UtyUbS02iYLGFtjY2mP6EMJch2tlKu9zmoqKiuSqD1zK84J4P5aMIY+fHIQs+
         pF1VDkaU0V17cnzexLH4Y9H1TxWDCq669WfSUeXBNCvYwKpPcBIL6wTYuY1f37Cswv8m
         oeYayN9C9R2lRTWwnfMpx9F4tU/ocVHfS5yWDTFswfvwBbvdBvR6xeL5t8rRfgXUgkcO
         GBQvDCR1QfiwUUmeFZ87Lml3SnG0TWQEdeAqnX9JLX/FFL7/ZrrSheNdCD30W8XqfiX1
         XnTA==
X-Gm-Message-State: AOJu0Yy+mGhk+sxRnfXUgnOSXf+ouVAs/KpNmDo5lL0lE9DFaZm/nPjZ
	WoW2/aZaGBDhqwKIsgPB10oi/qYVROaiyhbLk8d+ig7Bu0AiOQ==
X-Google-Smtp-Source: AGHT+IE8JDGH9ecjWUCMBMUouMOhuyEPG+0LSA+8kz0oPtVDBlLstNCfdQ5skELRjOnAGKeDWrBS6QE4QfdwIuqGTVo=
X-Received: by 2002:a81:4857:0:b0:5ee:1ca0:b7ef with SMTP id
 v84-20020a814857000000b005ee1ca0b7efmr258078ywa.42.1704842533828; Tue, 09 Jan
 2024 15:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is> <20240109181104.1670304-3-andri@yngvason.is>
 <CAPj87rNan8B5urDFkmD_Vti4to6p3NmvXYsTFQTNg-Ue2ieDug@mail.gmail.com> <CAFNQBQwiqqSRqzXAnC035UWCGF3=GGFR5SpDd=biPTOEA+cWbQ@mail.gmail.com>
In-Reply-To: <CAFNQBQwiqqSRqzXAnC035UWCGF3=GGFR5SpDd=biPTOEA+cWbQ@mail.gmail.com>
From: Andri Yngvason <andri@yngvason.is>
Date: Tue, 9 Jan 2024 23:21:38 +0000
Message-ID: <CAFNQBQxM3dxdWRRY28jyXi4PZbgh7V+L7L6W1HQn40PwUGPNaA@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/uAPI: Add "active color format" drm property as
 feedback for userspace
To: Daniel Stone <daniel@fooishbar.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>, 
	Werner Sembach <wse@tuxedocomputers.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Please excuse my misconfigured email client. HTML was accidentally
enabled in my previous messages, so I'll re-send it for the benefit of
mailing lists.

=C3=BEri., 9. jan. 2024 kl. 22:32 skrifa=C3=B0i Daniel Stone <daniel@fooish=
bar.org>:
>
> On Tue, 9 Jan 2024 at 18:12, Andri Yngvason <andri@yngvason.is> wrote:
> > + * active color format:
> > + *     This read-only property tells userspace the color format actual=
ly used
> > + *     by the hardware display engine "on the cable" on a connector. T=
he chosen
> > + *     value depends on hardware capabilities, both display engine and
> > + *     connected monitor. Drivers shall use
> > + *     drm_connector_attach_active_color_format_property() to install =
this
> > + *     property. Possible values are "not applicable", "rgb", "ycbcr44=
4",
> > + *     "ycbcr422", and "ycbcr420".
>
> How does userspace determine what's happened without polling? Will it
> only change after an `ALLOW_MODESET` commit, and be guaranteed to be
> updated after the commit has completed and the event being sent?
> Should it send a HOTPLUG event? Other?

Userspace does not determine what's happened without polling. The
purpose of this property is not for programmatic verification that the
preferred property was applied. It is my understanding that it's
mostly intended for debugging purposes. It should only change as a
consequence of modesetting, although I didn't actually look into what
happens if you set the "preferred color format" outside of a modeset.

The way I've implemented things in sway, calling the
"preferred_signal_format" command triggers a modeset with the
"preferred color format" set and calling "get_outputs", immediately
queries the "actual color format" and displays it.

Regards,
Andri

