Return-Path: <linux-kernel+bounces-166830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365848BA026
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AEE51C223F9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B7A173333;
	Thu,  2 May 2024 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiQqVago"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C884171E71;
	Thu,  2 May 2024 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673759; cv=none; b=B4L3jGarmdYisr+GOnV1bH/KwL17dv2M61IkoQXgoo8NbgV7ncMVMsX3CN6yldvox7VeweLuGrwnuHJJqoX/xVKwaTcHb3LI8TJ6P6oAcwI4y1oL/PzSkUL8pqrQf3OSCUS2Am0rKSZJAWds5aaV0UwjGaLQCxS+twOrREJpi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673759; c=relaxed/simple;
	bh=X7DrFE5tkPNVeoKphzhmBGA84w2IH/LJ5mcMYnCjHuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ImO4+xktGNgCTrxwexso/bPq1xz4LUJZuG1dyBilZds7E1wSqvW/trk8cCQrqCiQnlyTRS4LPxpPA4W+vz7EbCYJ+q3Qui4kM3koDT2svAlyxKA4avP1dnFyGBVPNieKhDJGFCfu8TUG+IStPjKrRr+aCDm3rZ0E6DIxLVf5VEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiQqVago; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714673759; x=1746209759;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=X7DrFE5tkPNVeoKphzhmBGA84w2IH/LJ5mcMYnCjHuY=;
  b=SiQqVagoPHZWbgZkoPeZCvD89OkWQYxgzCgHwMpog0qAtvTwfo5N2Nwm
   Rd2kFQaR6W9EIF3i1rl/NwLRT7G32/ShOO0Ku5UqirRpuNseRmhdr738Y
   MoyoHTehBmpPZrElVYlCru5nOWmka/ZYtjOWF+ZZKYa5hjzVAlJ3B4544
   MxGrG+qc9+SrDDZryxlNEGfUHyhzms1ib5LptfEQ8FytPzNl4AZ9tHsSc
   n7zCjk8NMCGusBzqAmUq/ZZD1NQrSAzfWEZLgcBEchENXrLwt06gVewrX
   4Rc9dntXy5Apyrl4eVus0/N5TS7FX2h5mclFWrU/5W6IzoysLwWP/Dq9/
   w==;
X-CSE-ConnectionGUID: 1DDYHusATrSUZjVmMIDF1w==
X-CSE-MsgGUID: 9kcPSfNCQeGbxzd8Gu3cBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21078434"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21078434"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:15:58 -0700
X-CSE-ConnectionGUID: 6/TBRK5kSW6Z257tKIDi9g==
X-CSE-MsgGUID: pMdGUqKIRe6ELbYWmn/Xew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27704908"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:15:57 -0700
Received: from [10.213.161.211] (kliang2-mobl1.ccr.corp.intel.com [10.213.161.211])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 87B2D20B5739;
	Thu,  2 May 2024 11:15:55 -0700 (PDT)
Message-ID: <78a63434-c7b8-4ada-b59f-b6dd547b5b63@linux.intel.com>
Date: Thu, 2 May 2024 14:15:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Assume sysfs event names are always the same case
To: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, James Clark <james.clark@arm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240502040112.2111157-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240502040112.2111157-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-05-02 12:01 a.m., Ian Rogers wrote:
> By assuming sysfs events are either upper or lower case, the case
> insensitive event parsing can probe for the existence of files rather
> then loading all events in a directory. When the event is a json event
> like inst_retired.any on Intel, this reduces the number of openat
> calls on a Tigerlake laptop from 325 down to 255.
> 
> v1 sent as an RFC:
>     https://lore.kernel.org/lkml/20240413040812.4042051-1-irogers@google.com/
> 
> v2: addresses review feedback from Kan Liang, by updating
>     documentation and adding tests.
> 
> v3: incorporate feedback from Thomas Richter <tmricht@linux.ibm.com>
>     that s390 event names are all upper case. Do a lower case probe
>     then an upper case probe, make documentation and tests also agree.
> 
> v4: add checks to write (kernel test robot) and fix a typo.
> 
> Ian Rogers (6):
>   perf test pmu-events: Make it clearer that pmu-events tests json
>     events
>   perf Document: Sysfs event names must be lower or upper case
>   perf test pmu: Refactor format test and exposed test APIs
>   perf test pmu: Add an eagerly loaded event test
>   perf test pmu: Test all sysfs PMU event names are the same case
>   perf pmu: Assume sysfs events are always the same case
> 
>  .../sysfs-bus-event_source-devices-events     |   6 +
>  tools/perf/tests/pmu-events.c                 |   2 +-
>  tools/perf/tests/pmu.c                        | 468 ++++++++++++------
>  tools/perf/util/parse-events.c                |   2 +-
>  tools/perf/util/parse-events.h                |   2 +-
>  tools/perf/util/pmu.c                         | 111 +++--
>  tools/perf/util/pmu.h                         |   4 +-
>  tools/perf/util/pmus.c                        |  16 +-
>  tools/perf/util/pmus.h                        |   2 +
>  9 files changed, 416 insertions(+), 197 deletions(-)
> 

Except the warning for the uninitialized 'ret', the rest looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

