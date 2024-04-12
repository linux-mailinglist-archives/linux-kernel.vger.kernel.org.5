Return-Path: <linux-kernel+bounces-141815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9248A23D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2182850BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8070210957;
	Fri, 12 Apr 2024 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnR28Fkg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5D017F5;
	Fri, 12 Apr 2024 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889658; cv=none; b=jBtqpVBPacDeqmgUvrN86Qif7DcQxq7RMXDdIwteo5sy9wf2eNr7dtC3JkOQeFfY/0CEPZcNYNizoG9sZoDd9A80PjCpdiAnhXcl5hEHgOqJAcldJ7+hq1q4trlpwY84doEocl/NWDmFq40sw0NpfuSKS98DvFpC6y1u99iF2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889658; c=relaxed/simple;
	bh=kGmm58BT06O9yqjxpPGmRd+KyvDBx4YO3Lh9CYHUisg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UazoFcuMKwlngKODrEhm76ZhPfJW9SHOJuweKG0M/YMJK4vAlOZjKxYUVVqx90UT5PoSMkwrnmTD2Un2ggKGkR3BEp9kV0RftRcFregcx+yYysVlTDOv2PR5MLZovynLiUGEd+jVMDQq91yVxJxJlRXPdvYfvWQwtK/d5UECsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnR28Fkg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712889657; x=1744425657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kGmm58BT06O9yqjxpPGmRd+KyvDBx4YO3Lh9CYHUisg=;
  b=ZnR28FkguTsxq3S8DWQeD7UHzdz+dtfdiAojjY5YEbMmv2jm4OQAOlgO
   cOTax/Dm1VISU3/+MIl6uRjWDOda8ZThYq1RIFhk/clXFHprKI+IYtank
   yESV2p+8JXugNpUaIGj8s5jAz76uS1KB/dREMJGMS4wmrnP3b4axg8Px+
   IuIDTjoaoSZM6m5BPcjhgvBFEbpL9yOTkem/fD47qLNNXEC+9YmfU7ILq
   I5DVIemNYsqZaRfYg3uS6ndLt+202VaK64FkFKiqE3InQxvUIs7S6CHEm
   IsGelgRrZSxUpaN5AZ3grkzXvzWgDkhUK6NiwPpSpPfLcNhfTEZA3Mkoi
   Q==;
X-CSE-ConnectionGUID: y0FlLHP5T4i1cLQmtDnYCQ==
X-CSE-MsgGUID: GAVaNsdoRSqL5ai5XaXqLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8182974"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="8182974"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 19:40:56 -0700
X-CSE-ConnectionGUID: 1O/0wnL7Rhuv48mOco3sZA==
X-CSE-MsgGUID: FSe5bPHMQZ2VFKQU6tVLlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="25898351"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 11 Apr 2024 19:40:52 -0700
Date: Fri, 12 Apr 2024 10:35:48 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Peter Colberg <peter.colberg@intel.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2] mfd: intel-m10-bmc: Change staging size to a variable
Message-ID: <ZhieBC124oq/Fcqa@yilunxu-OptiPlex-7050>
References: <20240402184925.1065932-1-peter.colberg@intel.com>
 <20240411154956.GH2399047@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411154956.GH2399047@google.com>

On Thu, Apr 11, 2024 at 04:49:56PM +0100, Lee Jones wrote:
> On Tue, 02 Apr 2024, Peter Colberg wrote:
> 
> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > The secure update driver does a sanity-check of the image size in
> > comparison to the size of the staging area in FLASH. Instead of
> > hard-wiring M10BMC_STAGING_SIZE, move the staging size to the
> > m10bmc_csr_map structure to make the size assignment more flexible.
> > 
> > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> 
> Xu Yilun, Peter,
> 
> Do you require a pull-request from an immutable branch for this?

No need. The patchset could all be applied to mfd branch.

Thanks,
Yilun

> 
> -- 
> Lee Jones [李琼斯]
> 

