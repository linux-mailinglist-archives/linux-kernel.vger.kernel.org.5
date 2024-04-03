Return-Path: <linux-kernel+bounces-130460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A96C897876
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B0E1C25BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79751524DC;
	Wed,  3 Apr 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2JI47Kk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B1153BCB;
	Wed,  3 Apr 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169851; cv=none; b=rqmGDWDTejKwKRL9Zgd/d+pWvvEiuwzHssHnitRR1Gv4gRENMJi5CnWzhkYhtLfWMQsp7V6e0bEFKJfKSfmAwrjpUFTXFl0LnYzvb/3Ie8k5sBsk7uK7wReeESpVfGaem0A9+96uhRZlYBg7XABjv+cPybZxWgMMt8OB3ev0txM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169851; c=relaxed/simple;
	bh=asBWHNsOxuFsIUGvryGVvV6AmuzfPwokHExbMcGi0ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1AaSCiFOLKsvzXDqTOq8yDUpWj2gt44yTCNa90rX/zvTWn30/5oPHV37M2bQbc7/gz1Y+5zRq4M2WSdA2/BlIXfp9HgyALOhlUzdB0eqbByuy9NrlqF1IZVkHF6aK7pMrFJGMxJHSgwlhPnAeHf7H69JhfX/QCLEbsqpVLZ4BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2JI47Kk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712169850; x=1743705850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=asBWHNsOxuFsIUGvryGVvV6AmuzfPwokHExbMcGi0ws=;
  b=i2JI47Kk14Y2sQCrwpstEDHJeCZDDoypW5OMaQ6FYftz1TdSqLuFQTKe
   +1H8lQk1rYRbnJk/UPCf7Lt3qHHZLK0bmQBvnBDXYG61hcsoMnOvnlqUm
   bR9qy54XCcXYja+gL6H0kzOH3MPBZccdUahZz85i8UxgNj+dP9cgbTQUe
   3zJ/CuT1ZwM1tv/glGT148jL0tDvcRrLBxo7g0cD7hCYrAlisiMlFWiIv
   7PD59mqXifIAsUrTq9fei35R2xhDLQBPOY4vDHiJ4KefGWjtQKvzCy6dZ
   DMez4GW0Uxp3s8EQaiIoQdaXWx6hr9Qo9Qo15QA4utT7WQYcyRXw5hoJu
   w==;
X-CSE-ConnectionGUID: ikdN9vWRTLSrTwpW5hx4bg==
X-CSE-MsgGUID: fzRIry+PRBGdgvPofYEOFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7268001"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7268001"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 11:44:06 -0700
X-CSE-ConnectionGUID: Vc2mcmdFQSyfVE95KdJWzA==
X-CSE-MsgGUID: 9VRwHznbR9+3xhJ6WRYGdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="23179345"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 11:44:05 -0700
Date: Wed, 3 Apr 2024 11:44:04 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf metrics: Remove the "No_group" metric group
Message-ID: <Zg2jdJ3-LNRkL95T@tassilo>
References: <20240403164636.3429091-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403164636.3429091-1-irogers@google.com>

On Wed, Apr 03, 2024 at 09:46:36AM -0700, Ian Rogers wrote:
> Rather than place metrics without a metric group in "No_group" place
> them in a a metric group that is their name. Still allow such metrics
> to be selected if "No_group" is passed, this change just impacts perf
> list.

But what's the point of it? It will just make perf list more verbose,
but I don't see any advantage.

-Andi

