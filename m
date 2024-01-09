Return-Path: <linux-kernel+bounces-21476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB684828FF8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12591C24F68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5963E46B;
	Tue,  9 Jan 2024 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="0npko/aG"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736553E47B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78313803243so307311785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 14:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1704839550; x=1705444350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ynsR4nnFEaZADpxDZxOiLIugSOI6RO8hBMHt22YNR9I=;
        b=0npko/aGgr1kUFI6yhknHxWu4EryvC+PlMH2C62KAD7dIs+85zD6oTa96FPzk9qRNt
         dFJPRp1snSZsb82uJs/G3dfyGj6rV8RW2O/3vdvbMo+dhq0zxLFOk8+x8oLgjc0TbFxX
         gUH2rcjNlZ4sKVyPcnOfg5nBfDm4ui+Rp/zVlh1vw2Xurbzl0s6JbQRw/HIKoRszIlXn
         H6CNKwipgVbhL/DAvRfRWofq2XlyV9VblJ3SywqJyTAF3XHH6TitjURhr8wS9gpZsmom
         1LEBV7Fv+tUp+qKxJ5FfT3mXC6OqPLipUJaWZBNZVou8KEmm/rdmYIzmbOzM7UgF8JOQ
         C5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704839550; x=1705444350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynsR4nnFEaZADpxDZxOiLIugSOI6RO8hBMHt22YNR9I=;
        b=hWI8eEiXt5ZL8UJcmlbjkflNjU//SrK8Gaaw9meMR+G7tfccDviapdT96pSF5vxdDf
         A2PkaD3d06dfov7nv2PP2fSQXrmc5qq3C774TlGqbWHjo1mFummIlg/rU8eZq4ZqlM1T
         R4qCR9xqXmovelGx54DalR5pdsz6ili5HEA06SyyWpWdiPQFjPN1HsXTYCXwF2px7uVA
         H3849G45zhxbaRliUBy7rPC8qnkZXcrqdRhBAGt26DaL4JIGcChXmNDDb+aMIFPM3SLk
         T30DqqQ/TfDkffsR0TN0BpL9evvtrkxQDx7IltUtTxYhh2UPL5hA5VM36drEH332Ktqv
         thmQ==
X-Gm-Message-State: AOJu0YwYjZcAGUFWtzOnHHWFX3nlfVjCGAaFrgJdZoIdRpsdnXyL9qhU
	p3IX+KX18Y+O2CY03romC0IQvzMycEOdI2pHYJKSWP9dZ/rCJA==
X-Google-Smtp-Source: AGHT+IEni1Ntup6ec+s61FZRN+0Cq4rkHJLzEGZRkocUASUKr2AOtWgASwxL8J0ZDkXeq6OC/kMNJ7/4oMga4t3FLWw=
X-Received: by 2002:a05:6214:48f:b0:680:857:1bd9 with SMTP id
 pt15-20020a056214048f00b0068008571bd9mr218069qvb.82.1704839550148; Tue, 09
 Jan 2024 14:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is> <20240109181104.1670304-3-andri@yngvason.is>
In-Reply-To: <20240109181104.1670304-3-andri@yngvason.is>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 9 Jan 2024 22:32:18 +0000
Message-ID: <CAPj87rNan8B5urDFkmD_Vti4to6p3NmvXYsTFQTNg-Ue2ieDug@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/uAPI: Add "active color format" drm property as
 feedback for userspace
To: Andri Yngvason <andri@yngvason.is>
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

Hi,

On Tue, 9 Jan 2024 at 18:12, Andri Yngvason <andri@yngvason.is> wrote:
> + * active color format:
> + *     This read-only property tells userspace the color format actually used
> + *     by the hardware display engine "on the cable" on a connector. The chosen
> + *     value depends on hardware capabilities, both display engine and
> + *     connected monitor. Drivers shall use
> + *     drm_connector_attach_active_color_format_property() to install this
> + *     property. Possible values are "not applicable", "rgb", "ycbcr444",
> + *     "ycbcr422", and "ycbcr420".

How does userspace determine what's happened without polling? Will it
only change after an `ALLOW_MODESET` commit, and be guaranteed to be
updated after the commit has completed and the event being sent?
Should it send a HOTPLUG event? Other?

Cheers,
Daniel

