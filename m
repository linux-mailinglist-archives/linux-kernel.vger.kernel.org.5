Return-Path: <linux-kernel+bounces-131031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BA2898232
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8039E1F245E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9485CDE4;
	Thu,  4 Apr 2024 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asXyt6EQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C25159158;
	Thu,  4 Apr 2024 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215680; cv=none; b=dOmerWTy8qFM3YwbvDWhPsY3vWgjrtfq2Cp1D2I0+WFI3URUuVRNQy+39HAaEnV9AKp4odu0T8ePO8wmjXhfG9K19hW29+nsJarsVahDCXQDAVcB9bUJ2EPya4XGpSN2ESMpPLKFSRIpadUdxdbzriJehF8fG9BEdexqGinVglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215680; c=relaxed/simple;
	bh=RKQ+b/6tx0j5fcRbGd1+ZSjUZNL7pamhVmxxau7bjRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1AVk9S0tX8WOlXod62BmJKJnvtuJl6JBew18lV+7RNEDjsO7QT9kxyzLYlPvuLVY9E1gNxV1Nv673me+jAS9F66EDVe000T8iZCL83yK/YNINnvlAJsfYL02wuc239IodvJMro0Tar8UIc2FMGP8X5EwNqp5KkHKXiH0OxPT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asXyt6EQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712215679; x=1743751679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RKQ+b/6tx0j5fcRbGd1+ZSjUZNL7pamhVmxxau7bjRk=;
  b=asXyt6EQqJKrNjoNw/DnP1R0Ggm+kIyoggjSe8OzmqOdqgi9jQoTed5B
   yTAT5+wY/5p2Wq7s5hRWJKgUbTIRXjoG1Dxrutv1KlpwBG1eiDD6qPodq
   R01UwcMllCIhaxASc8TdAEPHbJn9rf4IGN4rOuqCARlf9AMcullCnZ8NM
   5W/5FiNbhd2rspK+qt92aLX2w2Sh8kF89NeSqc+64gHHORrMo7MJyRd7L
   Bg5Y3s9eP6rCcV9wCSa5ukcb4Ph2Jlbg0i1U3Xq41boTviHqc41hBEf02
   glCc1i+a+MXCfbBjyWyUOfb+jYd3YAQXk+LgzxQZvD1GFiX3dnnw2u+/c
   Q==;
X-CSE-ConnectionGUID: 9xeE+pR2QtScVCODI1CcMQ==
X-CSE-MsgGUID: O5cOmguMQAOV/syGdiTSiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18639036"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18639036"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 00:27:58 -0700
X-CSE-ConnectionGUID: oppg5AWXS++CeE9U/jyXuw==
X-CSE-MsgGUID: Ivckoag3Qg6Aicdl0XJzcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18802468"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 00:27:50 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id A685611F855;
	Thu,  4 Apr 2024 10:27:47 +0300 (EEST)
Date: Thu, 4 Apr 2024 07:27:47 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yong Zhi <yong.zhi@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
	Dan Scally <djrscally@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tianshu Qiu <tian.shu.qiu@intel.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Hyungwoo Yang <hyungwoo.yang@intel.com>,
	Rajmohan Mani <rajmohan.mani@intel.com>,
	Vijaykumar Ramya <ramya.vijaykumar@intel.com>,
	Samu Onkalo <samu.onkalo@intel.com>,
	Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@intel.com>,
	Jouni Ukkonen <jouni.ukkonen@intel.com>,
	Antti Laakso <antti.laakso@intel.com>
Subject: Re: [PATCH] media: ipu-cio2: Remove unnecessary runtime PM power
 state setting
Message-ID: <Zg5Wc6DMPYBqlCFr@kekkonen.localdomain>
References: <20240325220325.1452712-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325220325.1452712-1-helgaas@kernel.org>

Hi Bjorn,

On Mon, Mar 25, 2024 at 05:03:25PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> ipu-cio2 uses generic power management, and pci_pm_runtime_suspend() and
> pci_pm_runtime_resume() already take care of setting the PCI device power
> state, so the driver doesn't need to do it explicitly.
> 
> Remove explicit setting to D3hot or D0 during runtime suspend and resume.
> 
> Remove #defines that are no longer used.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Hyungwoo Yang <hyungwoo.yang@intel.com>
> Cc: Rajmohan Mani <rajmohan.mani@intel.com>
> Cc: Vijaykumar Ramya <ramya.vijaykumar@intel.com>
> Cc: Samu Onkalo <samu.onkalo@intel.com>
> Cc: Jouni Högander <jouni.hogander@intel.com>
> Cc: Jouni Ukkonen <jouni.ukkonen@intel.com>
> Cc: Antti Laakso <antti.laakso@intel.com>
> ---
> This code was initially added by c2a6a07afe4a ("media: intel-ipu3: cio2:
> add new MIPI-CSI2 driver").
> 
> Even at that time, the explicit power state setting should not have been
> necessary, so maybe there's a reason for it.  I have no way to test this,
> so if it *is* needed, please:
> 
>   - Add a comment about the reason and
> 
>   - Convert it to use pci_set_power_state() so the PCI core knows about the
>     change and all the required state transition delays are observed.

Thanks for the patch.

The device seems to work fine with the patch applied so I presume it wasn't
necessary to begin with.

-- 
Regards,

Sakari Ailus

