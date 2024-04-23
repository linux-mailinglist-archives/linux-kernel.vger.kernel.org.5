Return-Path: <linux-kernel+bounces-155498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEA48AEB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA721F233AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C627A13C9BE;
	Tue, 23 Apr 2024 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N94ncVk9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01913BAFE;
	Tue, 23 Apr 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887113; cv=none; b=RQFRDzhc9c2sDDm9sxau5NBAA53uYa/no1yJ005llO8qkd02H/k62Wjwfx4/VkzPs9tVcdOTb+vO082GeeAbJskh46AzhTWcx61EXJEqb/rsZzXuQaN81IBwt3QE3ZFj7khrIEKjcLvZ0vPNQ/ZIQ7czP99nM/Pt1U7pPb/kN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887113; c=relaxed/simple;
	bh=MA9446VKnhvmz6/0EyeIfdr7SFbSysHM+adFvzkui6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HT9CJUq73LvFBn/cm3sHkpKqIYbwZc/h0N0AQMBCkZUy0P+Uw6LFW8N0vCl53GaYk8McDgkYEN6ggQH7eW4IWA11XqusytmuKW4ho6k8bIxyGpjtLGWzWmCmbgVN2/wXoRM7ZCsdnggtiQagKk4Z2EWQCW2PeMK7f7PuboVXUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N94ncVk9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713887112; x=1745423112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MA9446VKnhvmz6/0EyeIfdr7SFbSysHM+adFvzkui6g=;
  b=N94ncVk96IuTdrdY2dkzG6Ba2xaWY+6jtz8dZGOViswhIKOJDIbzmh8r
   QBZ/QHA5TUc3WL4xzeZ4ofdgbQ2TxEn0/5Qw/PwyPU4SPhaLtWsCVtPTD
   M5u2jbH3tL6OUhtvrT3UAxgpW9Bx63AwEz3x3q3LSIm16cYunDV29uQ+c
   EYlE1d5t4McATuy/BTxSQJxlT0aNBRN++kTMV9vkrlXbh0aCUesMFfqWf
   d4yH7/fKwJePvIGHXNMYhfb0V2G1fck7rqybQTJtT3VrJcAVKh3RQyJ20
   TwT3I96o8bDqRIrbnyEahJ+inyoOFHNnj1gV6ZwucxS2jD30kI7SCmG+e
   g==;
X-CSE-ConnectionGUID: 0zTSBhqBT22n/L0iuDGOkA==
X-CSE-MsgGUID: g8u3l+I/RvCpJYIW7wjN7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="10021997"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="10021997"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:45:11 -0700
X-CSE-ConnectionGUID: mp1IFeV0RzGJ6l5msSO2OQ==
X-CSE-MsgGUID: fRB2rqL4QYyVS/b1hmHg+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28904442"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:45:10 -0700
Date: Tue, 23 Apr 2024 08:42:42 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ben Gainey <ben.gainey@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, will@kernel.org, james.clark@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 0/4] A mechanism for efficient support for
 per-function metrics
Message-ID: <ZifW8rZk41t4ukIV@tassilo>
References: <20240422104929.264241-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422104929.264241-1-ben.gainey@arm.com>

> Cursory testing on a Xeon(R) W-2145 with a 300 *instruction* sample
> window (with and without the patch) suggests this approach would work
> for some counters. Calculating branch miss rates for example appears to
> be correct when used with the instruction counter as the sampling event,
> or at least this approach correctly identifies which functions in the
> test benchmark are prone to poor predictability. On the other hand the
> combination cycle and instructions counter does not appear to sample
> correctly as a pair. With something like
> 
>     perf record -e '{cycles/period=999700,alt-period=300/,instructions}:uS' ... benchmark
> 
> I often see very large CPI, the same affect is observed without the
> patch enabled. No idea whats going on there, so any insight welcome...

My guess would be that the PMI handler cleared L1 and there are stalls
reloading the working set. You can check L1 miss events to confirm.
Unfortunately with the period change it cannot use multi-record
PEBS which would avoid the need for a PMI.

-Andi

