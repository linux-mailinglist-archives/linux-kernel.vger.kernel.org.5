Return-Path: <linux-kernel+bounces-160310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B988B3BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E5C1C23AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB08149C4B;
	Fri, 26 Apr 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ah9UPkSd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D318C1F;
	Fri, 26 Apr 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145881; cv=none; b=u79COUNUn4hoa8ysWNHK/eFj0VwCmAseHFp/S0MXjmsDI8jpqv3QoCr4ZWZX9EL5EePziG1cBKJaYoSrCxEiOQwGK2T6WISzUEjsZkAVeQE4cf85zPhshbx+4JlkC4Dh0Atf3YR6SlsNQHc3jYW6gkcg+7lpAht8Vn8r3fkCBq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145881; c=relaxed/simple;
	bh=c0vyoVzitYc/zSN8C3BrJHOUwCVElAyP9Xh4ECQgFnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfBoVHFfQFrpJszUWVB+DBK8csd1MiPbxagEMvg0vaEBspJP4tsZaojhO+q4CADUkoScO7o+mAeZZUNWaqbfP2qNlN6KGATOPEEVP7APCp3+LgP4XNQuhaVnDuc4Q8H194rjAwSdWORS4mWJcgzALk78XWuyfTDoGlk3+mbxdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ah9UPkSd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714145880; x=1745681880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c0vyoVzitYc/zSN8C3BrJHOUwCVElAyP9Xh4ECQgFnE=;
  b=ah9UPkSdAok5gp+76hp8kzqwfUnb+TLaoSGDHWV/0VmNNLnrF3r7pzdh
   0x47INsSX7LCqeSyDhxmuWTxeu75qnZvDJ5ZXhfXsYPWvs9d3irrto3+1
   9JP61OA4d1v21rRPmb/7FlbEVXVAmRmGkPsiRv7ER5MKMxictvXg1ZS/x
   7nCxQbAvSvi5ZUcEIJYHEvne1+ZCEn3VmEj/44Uctr67671MQ3jNniOgd
   AW8kHF0prKtid0v/sCec3NjcJM62oRXOqW2bCcIN/lGUutNzMZGlKtMWB
   6k+YHv91OGVjcEHT6qcwIOEMIKUYbPNBNpIPfxgQJdHQVCh53b/0+BQRO
   A==;
X-CSE-ConnectionGUID: aWHf+pTtSROd7fPs/3biNw==
X-CSE-MsgGUID: VRIXkjsCQACE2ZTAk4R9CQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="13673353"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="13673353"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:37:59 -0700
X-CSE-ConnectionGUID: 5v4iPZWMSEGb6qBNSctDnQ==
X-CSE-MsgGUID: o9PGFEQpQ7yaAVRdrId0XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25528965"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:37:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0Ne6-00000001MfR-1aTp;
	Fri, 26 Apr 2024 18:37:54 +0300
Date: Fri, 26 Apr 2024 18:37:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: lumingyindetect@126.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: Re: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
Message-ID: <ZivKUr0hyJOixLgL@smile.fi.intel.com>
References: <20240426114716.1275085-1-lumingyindetect@126.com>
 <87d376e4-84f1-48c3-8c5d-955f706f3bfb@moroto.mountain>
 <Ziu-HUUE43xsjnia@smile.fi.intel.com>
 <047e490b-0dbf-49b7-9506-996f0053e92d@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <047e490b-0dbf-49b7-9506-996f0053e92d@moroto.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 06:32:33PM +0300, Dan Carpenter wrote:
> On Fri, Apr 26, 2024 at 05:45:49PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 26, 2024 at 04:53:18PM +0300, Dan Carpenter wrote:
> > 
> > > > Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67
> > > 
> > > This is the wrong hash and the format is wrong.  It should be:
> > > 
> > > Fixes: 254cc7743e84 ("serial: 8250_lpss: Switch over to MSI interrupts")
> > 
> > Since you are here, just pay attention that this does NOT fix anything
> > as it uses pcim_enable_device(). I hope smatch won't stumble over this
> > and produce false positives.
> > 
> 
> Ah...  No, this isn't a Smatch warning.  I think I tried to add it but
> was told it was wrong because I have this in my unpublished code.  :P
> 
> // Are these affected by pcim_enable_device()?
> //      { "pci_alloc_irq_vectors", ALLOC, 0, "$",  &int_one, &int_max },
> //      { "pci_free_irq_vectors", RELEASE, 0, "$" },
> 
> So when we're using pcim_enable_device(), calling pci_free_irq_vectors()
> is harmless but not necessary?

Yes, precisely.

-- 
With Best Regards,
Andy Shevchenko



