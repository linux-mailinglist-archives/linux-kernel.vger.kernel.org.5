Return-Path: <linux-kernel+bounces-166116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600BB8B966C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AE9287F92
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3103D3BD;
	Thu,  2 May 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+OEMBwh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157837144;
	Thu,  2 May 2024 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638424; cv=none; b=M6VL3xNXeeWf/GxeXRqJCDxSLP92/MfmnAXlJ8U/iW6z45q9NxwFgFj43tAKSs91V8H//lds3HsDqWue4Hh0cmeQ0SxalMj04C6PNGKx7RhkNKa3FeHwsyG0uEUV2cnvSkY/u840EdlfWsFB1rndv6GxA4pOzJuXMoRnAUTsKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638424; c=relaxed/simple;
	bh=E+KSBCsIoTpEAZ5J8YrJdsZ7vYdsTvhIijqtMmmDOA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLpsArIMeB7ADzhkwpfX3EFrUr1rKL7bXDSsbUvedtOP3GAMJrRcMYnCXANX4tB6/gQEJTLzGcrZ8INOdEqNCfcKmLZH3ZjKwniigh/84Mb4cTWGnrbUEwEVPNyQHlQPMcqB39E1ghsm3aZEfC+ydwfhGEP0cIyp755YF9+Jh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+OEMBwh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714638419; x=1746174419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E+KSBCsIoTpEAZ5J8YrJdsZ7vYdsTvhIijqtMmmDOA8=;
  b=n+OEMBwh9xFSiew52dXgpaK7RO2C53XqJ9XRL1asKtKcz8SPqo3q1OQN
   Y28pCIpVQn0VKbBQxpy7uUHLcrTtwogP8lVZkX0kB7naeC26il7veNrV8
   Xo5C3Ni/K1cSAyc7Bpb78IuRMYU4CUfTe64wUx2WgTMd1JyvJGWFFgLYJ
   j1i1joyT2u2rJ58bUbUNX8oJmzm+JeXesU7/jJveG1VkK+v+xLMfxpmHL
   57T5hIDTg4lhrc8+HKsgGi99mVcAQqyF3GBK6SBHagbVRHuKkKQXUkleG
   bszZ/F7ZE8Zx3sozuJvYpnrRvrwDmRR21pETHatZxWp+z00XJwaLGVp4Z
   g==;
X-CSE-ConnectionGUID: wfm6TfV2RcaHGasYiKtmTg==
X-CSE-MsgGUID: 05xXVd5NTjqSe0aPOT0VDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10523245"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10523245"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 01:26:58 -0700
X-CSE-ConnectionGUID: Rp3kvbO/SnmIbrXmu+BBjA==
X-CSE-MsgGUID: uek/9aNOTqWATURqoVnIcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27130016"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 01:26:55 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 46EB511F832;
	Thu,  2 May 2024 11:26:52 +0300 (EEST)
Date: Thu, 2 May 2024 08:26:52 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>, linux-media@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 0/5] media: Fix compilations with !ACPI !PM and !OF
Message-ID: <ZjNOTOa6aByTjlyH@kekkonen.localdomain>
References: <20240501-fix-ipu6-v2-0-a5629a37a0fb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501-fix-ipu6-v2-0-a5629a37a0fb@chromium.org>

Hi Ricardo,

On Wed, May 01, 2024 at 01:08:08PM +0000, Ricardo Ribalda wrote:
> The current media-stating has some errors when configurations are
> missing. Fix that.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Changes in v2:
> - Remove missing __maybe_unused (Thanks Hidenori)
> - Include https://patchwork.linuxtv.org/project/linux-media/patch/20240430213633.23767-2-laurent.pinchart@ideasonboard.com/
> - Link to v1: https://lore.kernel.org/r/20240430-fix-ipu6-v1-0-9b31fbbce6e4@chromium.org

Thanks for these! I'll submit the PR for these probably today, with another
IPU6 fix.

-- 
Kind regards,

Sakari Ailus

