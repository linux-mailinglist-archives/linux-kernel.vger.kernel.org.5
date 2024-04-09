Return-Path: <linux-kernel+bounces-136660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2990389D6C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4A31C21575
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDE385629;
	Tue,  9 Apr 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5AQpQ5k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B4134416;
	Tue,  9 Apr 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657660; cv=none; b=hgLe6868jtVlJDbTnXqntMIdURIdwbdoxc0QgMBYpOgkgqLLXXX/H/ghFf09+3y0wo7A38hW9Fo6H4No0KNvTaA82uHKmYrUQbNUBi06drWjAk1HQ8Nxj4rx15T2JF1VnG/ZTQljBc32UMvtPLaG4Mxt1ljQRycGxIcszKyF8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657660; c=relaxed/simple;
	bh=/HdsMnAppID2c/T4mP9olHUzTPjv3yVarzfCvUZ29fg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u6BRQYGhJbj7Em1aSfQhp6+v5469lFahbP3kTHv38W37EnhdcohqwGzVePb1wSBIKydygWkSAYNyiURbZKy8plk5qJcfIArQrMgTn2qcUBYQIXyVq7Ge09Ll6bqTPZeQx3rqC9JZdklLi8B70HwzWZJPZumUNEvCEZRatonE8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5AQpQ5k; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712657658; x=1744193658;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/HdsMnAppID2c/T4mP9olHUzTPjv3yVarzfCvUZ29fg=;
  b=I5AQpQ5koz4IMx09Emdru1FfHW6sOe9OgDS7XKmjFyJPH6zDZOunrLbc
   ezbmtxeyyPJp3I28YSfbMD9GPcf3Q/VCmbEwWle773LHHb9RhzUsg6TVN
   0lCke7lzMf55Khq9oiKeMhsTMUgStLOawQ4X423LbaTNybqUFOgA5zKTv
   pXsx//Zc0NUE9OAq6qOjchalJv2SvXALyCRllIW7aLZA3cO4dRCzodqTG
   +0rbz3DBtujYbkqIJITmsNbg2/EoGdo96wFezmQNaBKak2H1SZ5Zq91Nv
   wX6sL0pHLg1sVawt5kbX7ehJYck7/zW2mkTfGtQgtMvcp9Czt9spQDGXX
   Q==;
X-CSE-ConnectionGUID: Z3Drv98YT6iP1WvZtHyPFw==
X-CSE-MsgGUID: CAp3ioGRRKW+Is6znYeMBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8193955"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8193955"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 03:14:17 -0700
X-CSE-ConnectionGUID: h6vK66UbSkiXc+RIBnnazw==
X-CSE-MsgGUID: NfhpuIMUS02Pkod9R4umgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="51180842"
Received: from mserban-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.59.228])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 03:14:11 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang
 <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter
 <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/9] tools/include: Sync uapi/drm/i915_drm.h with the
 kernel sources
In-Reply-To: <ZhTwPLliHXKPAJUQ@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240408185520.1550865-1-namhyung@kernel.org>
 <20240408185520.1550865-2-namhyung@kernel.org> <874jcb9etk.fsf@intel.com>
 <ZhTwPLliHXKPAJUQ@gmail.com>
Date: Tue, 09 Apr 2024 13:14:09 +0300
Message-ID: <87pluy972m.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 09 Apr 2024, Ingo Molnar <mingo@kernel.org> wrote:
> * Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
>> On Mon, 08 Apr 2024, Namhyung Kim <namhyung@kernel.org> wrote:
>> > To pick up changes from:
>> >
>> >    b112364867499 ("drm/i915: Add GuC submission interface version query")
>> >    5cf0fbf763741 ("drm/i915: Add some boring kerneldoc")
>> >
>> > This should be used to beautify DRM syscall arguments and it addresses
>> > these tools/perf build warnings:
>> >
>> >   Warning: Kernel ABI header differences:
>> >     diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
>> 
>> All these years and I never realized there are header copies
>> there. But... why copies?
>
> It's better than all the alternatives we tried so far:
>
>  - Symbolic links and direct #includes: this was the original approach but 
>    was pushed back on from the kernel side, when tooling modified the 
>    headers and broke them accidentally for kernel builds.
>
>  - Duplicate self-defined ABI headers like glibc: double the maintenance 
>    burden, double the chance for mistakes, plus there's no tech-driven 
>    notification mechanism to look at new kernel side changes.
>
> What we are doing now is a third option:
>
>  - A software-enforced copy-on-write mechanism of kernel headers to 
>    tooling, driven by non-fatal warnings on the tooling side build when 
>    kernel headers get modified:
>
>     Warning: Kernel ABI header differences:
>       diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
>       diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h
>       diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
>       ...
>
>    The tooling policy is to always pick up the kernel side headers as-is, 
>    and integate them into the tooling build. The warnings above serve as a 
>    notification to tooling maintainers that there's changes on the kernel 
>    side.
>
> We've been using this for many years now, and it might seem hacky, but 
> works surprisingly well.
>
> Does this make sense to you?

Yes, although there are probably pieces of the puzzle I'm missing.
Thanks for the explanation! (That might work almost as-is copied to
tools/include/uapi/README. ;)

It's also kind of funny to find this kind of back alleys of the kernel
repo I've never wandered to before.

BR,
Jani.

-- 
Jani Nikula, Intel

