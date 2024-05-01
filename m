Return-Path: <linux-kernel+bounces-164845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE4C8B83EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3FFB21F74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49634C83;
	Wed,  1 May 2024 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qf5qLzh5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998432F2D;
	Wed,  1 May 2024 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714526240; cv=none; b=cVqKYajf9vsjb4Irt8R718jT+1FzS5Ur53HH3w9SlDQ7KmbbNhX9njXk3eFZxIliNh4eseTXhK4Y06sBnUqXungAqbCjfJtUQGxkNlXlcuXmlpl/xw7hSsDIXrlqbMW8pgZsnpmZJL7DsvDx6gLwF1zfLPc9R8Y/fa5MATJmwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714526240; c=relaxed/simple;
	bh=oJaUTBcQlK8qJ9qOb+HMLCEHC2Kl529WSXhH2LODFiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDHBdx+gBVawv8zcjg+qtj4kMy6Jft67XGAn4ABjLZK+2a1YrJb/YVvCeiKP09NG8hbb1uGvvwbiPAqx3mg/uGO1Osj0HX91llHq1Vl3UA+hcvyzqq+oiz0kXHZ0q/keZAeK2+6q3NpbamDiSQo52uX90Fe5nUtNrw/ox+Bqs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qf5qLzh5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714526239; x=1746062239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oJaUTBcQlK8qJ9qOb+HMLCEHC2Kl529WSXhH2LODFiU=;
  b=Qf5qLzh5yWypTJ5GBRJ5nzbCsCG+ekWdsHQpBacvGnKUTfkAtEtdPS3c
   Iq+XYXYQOti4zYRmKop3mYDzqkXha3VaxbUyiPbndSQm4dRrtXeLi2q4B
   zV6QF01NwvhVD5ggcCLrRSV8/HelzdfY1g7xq5P9ETXcuG10ds/iqr5Fk
   RCT23PzboA/FmnA5CQQ2lPj1d0eKtO8OeRhcCm0xoac+0IwbSyCmX49H7
   Hqi0whjLmT9pEIHi0tcmG9jRTMrXg0AdaXnY+1xIorQWkvW8glZb7c2Zt
   Vm76VRBouwRNhIsIRwuKKcd3kUNClM2xKs+jIfLKhkwx0w4xo0Zs/8wnP
   g==;
X-CSE-ConnectionGUID: jRsU/NO/Trqqcy9EPuX6dw==
X-CSE-MsgGUID: VPlocZetQFyP4TusnMMGVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="32757386"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="32757386"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 18:17:18 -0700
X-CSE-ConnectionGUID: eZEkDgarR2yNzyiu4A4j/Q==
X-CSE-MsgGUID: TZFKuiSkRQCCRRzzo988Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31257776"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 18:17:17 -0700
Date: Tue, 30 Apr 2024 18:24:02 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 1/3] thermal: intel: intel_tcc: Add model checks for
 temperature registers
Message-ID: <20240501012402.GC29652@ranerica-svr.sc.intel.com>
References: <20240425171311.19519-1-ricardo.neri-calderon@linux.intel.com>
 <20240425171311.19519-2-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0i4pREX_HPRvxFM209MiwMScxGCYUr0L8XSXfvkrav1_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i4pREX_HPRvxFM209MiwMScxGCYUr0L8XSXfvkrav1_Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Apr 30, 2024 at 09:07:39PM +0200, Rafael J. Wysocki wrote:
> 
> This clashes with the Tony Luck's rework of Intel CPU model defines
> (see https://lore.kernel.org/lkml/20240430164913.73473-1-tony.luck@intel.com/),
> so I'd rather defer it until commit 2eda374e883a ("x86/mm: Switch to
> new Intel CPU model defines") reaches the mainline and make it use the
> new CPU model defines from the start.

Sounds good to me. I can repost the remaining patches of this series once
Tony's rework is merged into mainline.


