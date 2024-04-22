Return-Path: <linux-kernel+bounces-153443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA98ACE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACDF2836E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD314F9D0;
	Mon, 22 Apr 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJZ8GXlQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F914F13D;
	Mon, 22 Apr 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792510; cv=none; b=rMZJ7IGCMFq4RBxM4PhbV2DeVRKIYzPE+9KblX11D7A9UydPeMrG7AmvDmTHQ+SfvpJrNKqnwOkv3bMivwdRW44UIK2QCLuUBPhNrSKKDgJIPArPJFSrUxzhS8rNgvxgjRqfFSk63gMeYBEUkGwBoZCqmWFinFSmzKNHYVrOgYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792510; c=relaxed/simple;
	bh=8WYLYLq9GXgoOMMHpu8Y0v31BXd06Q6aFr4b9wop27I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FZQ6s8EPCTvp0hf6HrpjY+d4KZZs2zgwWDca+M3bjsb6LbRSxPpzMSGd0IGH2xwenQ//G829M7PWcDJo/FNmn2GvKuknJgq57pzw6SngSwUCFbnrQ0Udeh2HHbYP0B1iu5weExjDLnTEFrQDq3u1HT1QcHu28CMyfh6jt31ybIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJZ8GXlQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713792509; x=1745328509;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8WYLYLq9GXgoOMMHpu8Y0v31BXd06Q6aFr4b9wop27I=;
  b=QJZ8GXlQezLmPH74phytkgU1dkok3jhYKUePYXPTjzK+0qB4No+sPqFK
   WSZAmCboVNcLDCOT0TSZmgLJvuytqT/u1pq5hp4+MbFOYG5QrTm6cwXyX
   eVrzzq1z0B67xN18stCOWoq4CR4aOl0wSzTGcK/QV7DWDXet7EvxRhnMJ
   7ZhDU6Y5u+tI8FAiRZvxdxqnhktgz8mYZbnY2TCoy3UTVsKTwl8HIWZCL
   Rxh/qyqpsYRyO3DsecHpLBaImLBsyLOS9DFP7286wvfEa56+bYJZ2e6Pq
   QHrLnC5zNsgGRXAiPz2mko6Vi0OyqF3aw1G7IYTuC+QrEH3jzx0ZNq7My
   Q==;
X-CSE-ConnectionGUID: XTosl/NcQ6uwmZ5ofIqjkQ==
X-CSE-MsgGUID: DL7mwxnOSi2vulcOBpEjQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9550257"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9550257"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 06:28:28 -0700
X-CSE-ConnectionGUID: 4ZoJ6RI7Tme9DTelmP6I4w==
X-CSE-MsgGUID: kqN+eb1RQ2uGQEPn3YSErQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24622441"
Received: from ralbanes-mobl.ger.corp.intel.com (HELO localhost) ([10.252.63.128])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 06:28:24 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 00/11] drm: Restore helper usability
In-Reply-To: <ff4f9e8f-0825-4421-adf9-e3914b108da7@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1713780345.git.geert+renesas@glider.be>
 <87il09ty4u.fsf@intel.com>
 <ff4f9e8f-0825-4421-adf9-e3914b108da7@app.fastmail.com>
Date: Mon, 22 Apr 2024 16:28:21 +0300
Message-ID: <875xw9ttl6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 22 Apr 2024, "Arnd Bergmann" <arnd@arndb.de> wrote:
> On Mon, Apr 22, 2024, at 13:50, Jani Nikula wrote:
>> On Mon, 22 Apr 2024, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>>> 	Hi all,
>>>
>>> As discussed on IRC with Maxime and Arnd, this series reverts the
>>> conversion of select to depends for various DRM helpers in series
>>> "[PATCH v3 00/13] drm/display: Convert helpers Kconfig symbols to
>>> depends on"[1], and various fixes for it.  This conversion introduced a
>>> big usability issue when configuring a kernel and enabling DRM drivers
>>> that use DRM helper code: as drivers now depend on helpers, the user
>>> needs to know which helpers to enable, before the driver he is
>>> interested even becomes visible.  The user should not need to know that,
>>> and drivers should select the helpers they need.
>>>
>>> Hence revert back to what we had before, where drivers selected the
>>> helpers (and any of their dependencies, if they can be met) they need.
>>> In general, when a symbol selects another symbol, it should just make
>>> sure the dependencies of the target symbol are met, which may mean
>>> adding dependencies to the source symbol.
>
> Thanks for doing this.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
>> I still disagree with this, because fundamentally the source symbol
>> really should not have to care about the dependencies of the target
>> symbol.
>
> Sorry you missed the IRC discussion on #armlinux, we should have
> included you as well since you applied the original patch.
>
> I think the reason for this revert is a bit more nuanced than
> just the usability problem. Sorry if I'm dragging this out too
> much, but I want to be sure that two points come across:
>
> 1. There is a semantic problem that is mostly subjective, but
>    with the naming as "helper", I generally expect it as a hidden
>    symbol that gets selected by its users, while calling same module
>    "feature" would be something that is user-enabled and that
>    other modules depend on. Both ways are commonly used in the
>    kernel and are not mistakes on their own.

Fair enough. I believe for (optional) "feature" the common pattern would
then be depends on FEATURE || FEATURE=n.

> 2. Using "select" on user visible symbols that have dependencies
>    is a common source for bugs, and this is is a problem in
>    drivers/gpu/drm more than elsewhere in the kernel, as these
>    drivers traditionally select entire subsystems or drivers
>    (I2C, VIRTIO, INPUT, ACPI_WMI, BACKLIGHT_CLASS_DEVICE,
>    POWER_SUPPLY, SND_PCM, INTERCONNECT, ...). This regularly
>    leads to circular dependencies and we should fix all of them.

What annoys me is that the fixes tend to fall in two categories:

- Play catch with selecting the dependencies of the selected
  symbols. "depends on" handles this recursively, while select does
  not. There is no end to this, it just goes on and on, as the
  dependencies of the selected symbols change over time. Often the
  selects require unintuitive if patterns that are about the
  implementation details of the symbol being selected.

- Brush the invalid configs under the rug by using IS_REACHABLE(),
  switching from a loud link time failure to a silent runtime
  failure. (I regularly reject patches adding IS_REACHABLE() to i915,
  because from my pov e.g. i915=y backlight=m is an invalid
  configuration that the user shouldn't have to debug at runtime. But I
  can't express that in kconfig while everyone selects backlight.)

If you have other ideas how these should be fixed, I'm all ears.

>    The display helpers however don't have this problem because
>    they do not have any dependencies outside of drivers/gpu/

Fair enough, though I think they still suffer from some of them having
dependencies. (Wasn't this how the original patches and the debate all
got started?)


BR,
Jani.


-- 
Jani Nikula, Intel

