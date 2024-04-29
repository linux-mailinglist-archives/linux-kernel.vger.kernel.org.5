Return-Path: <linux-kernel+bounces-161978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 730DC8B5418
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B126AB21353
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31412030B;
	Mon, 29 Apr 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeBcUTjG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9112E7F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382412; cv=none; b=oMz/Gsc61VvWjo2DP7ya19+55iJjm6xVLl5U7yzKP3DsDkme8rnOAWHPINYP+HpQoCdk5NAopQS3WvcbLjrtDQTAPs4oTyCCPJyBTtPtnKpcJkG2tD53xAkol5yowIIV8krqv3WRZNjePYDJKLxDOMMcsUlXIN9qmZj1C6f1L8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382412; c=relaxed/simple;
	bh=Y4bDuRSz6TSLz3mVCCjXzVCR5pym+nGoMR5ch9kpkR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fxHvRsXVRKxsyrQWwLvCaUaIK0k5zis9IZ/LdED/Zg0ndthFdfknjxHWN9NNJTZzJiMfr5PcQ0ZHCLdYNpwGpmgojZLDbL+FXmA/8l5NnTAdJaP3kXueyoRjpT32gFtTXTkfV6bVCumUYuCffMSvPXvUb6wA78h3L90Pq1BUKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeBcUTjG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714382410; x=1745918410;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Y4bDuRSz6TSLz3mVCCjXzVCR5pym+nGoMR5ch9kpkR0=;
  b=JeBcUTjG7BEFUqrncqvszHvEVjDqfNylQP6nYHEsy6FWZGmJd7T2IrzQ
   W4XK6g+fPRJrbZ2cDJYEhk63lfTBBIYh72lGjtGA+qb8l1lnO0U0whkom
   Q7/8sV7JYbLICwOnBQ+Hp5aualkd5wLK3ZTNXNwFN5qjadx0mDS+Gc4Nh
   ZMM1ajDTJQR9j5I+LVZwgIRTIECM5imPPIl1CaW4xt/OGn+LjZwRUA8pn
   OOr1DayFa0FxITbFqmfsxVWL65B7i4bt10L3sunib/5S7hQQevISIPpic
   vsd379jrfdxgX6KI4SKCA4btaMYipy2TQLPHHuV36202xbmdsa00OKXuR
   A==;
X-CSE-ConnectionGUID: xsfdljZ4TlCj8U20W8hVlA==
X-CSE-MsgGUID: mvrjThVnTnqEWWC1/MVZnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9958800"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9958800"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:20:10 -0700
X-CSE-ConnectionGUID: whTviabCQ5apEoLo5b0/eQ==
X-CSE-MsgGUID: dKioqKMaQBq/p9WyJJh/VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26461169"
Received: from aantonov-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.49.167])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:20:02 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
 lvzhaoxiong@huaqin.corp-partner.google.com, Hsin-Yi Wang
 <hsinyi@google.com>, Javier Martinez Canillas <javierm@redhat.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Joel Selvaraj <jo@jsfamily.in>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Cong Yang
 <yangcong5@huaqin.corp-partner.google.com>, Sam Ravnborg
 <sam@ravnborg.org>, Douglas Anderson <dianders@chromium.org>, Daniel
 Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] drm/mipi-dsi: Reduce bloat and add funcs for
 cleaner init seqs
In-Reply-To: <20240426235857.3870424-1-dianders@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240426235857.3870424-1-dianders@chromium.org>
Date: Mon, 29 Apr 2024 12:20:00 +0300
Message-ID: <87jzkg4jb3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 26 Apr 2024, Douglas Anderson <dianders@chromium.org> wrote:
> The consensus of many DRM folks is that we want to move away from DSI
> drivers defining tables of init commands. Instead, we want to move to
> init functions that can use common DRM functions. The issue thus far
> has been that using the macros mipi_dsi_generic_write_seq() and
> mipi_dsi_dcs_write_seq() bloats the driver using them.
>
> While trying to solve bloat, we realized that the majority of the it
> was easy to solve. This series solves the bloat for existing drivers
> by moving the printout outside of the macro.
>
> During discussion of my v1 patch to fix the bloat [1], we also decided
> that we really want to change the way that drivers deal with init
> sequences to make it clearer. In addition to being cleaner, a side
> effect of moving drivers to the new style reduces bloat _even more_.
>
> This series also contains a few minor fixes / cleanups that I found
> along the way.

FWIW, I like the general approach taken here. Thanks!

BR,
Jani.


-- 
Jani Nikula, Intel

