Return-Path: <linux-kernel+bounces-141319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D488A1C94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EC3287256
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3989F82482;
	Thu, 11 Apr 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdZoJw2r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F623BBC3;
	Thu, 11 Apr 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852892; cv=none; b=VFFnMLv9kXj2c+ETnPFC55D8whmUxH27GlZzcj8XPZCiZGH5hpNndaPN5Vz1HuhmHxNwJ4jUFvkAEOiALl/8A0Q/fyhNLyXED7p3GBBcRbJK0V2z5NVb9Dj6WkbDeT19ogsMK/LVKdQ+isVqfxcZnpNnvDjTb1j0MNeO03Uv9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852892; c=relaxed/simple;
	bh=3XlIAOs87uqlOBPMpqubX7mfWhYqIMI28TNCOjbin5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCqpeyeyzXoI4fB1ObGEyh/S50RciSnqs/5en1qo+UCTqp+SGwu/c46UXb8wR0enBI2AEkixnJ2Sk1tqkjQiPKp6mqNezQX8CZw5Cn+h6hk386BCWZkZpV3JsAbPHYFxJF1Hbd2SzmYWD0ma/zEELFCpVN1a4nIJx+JI76bV09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdZoJw2r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712852890; x=1744388890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3XlIAOs87uqlOBPMpqubX7mfWhYqIMI28TNCOjbin5U=;
  b=DdZoJw2r/RtjVpxa7ykTqtcgj79Aoj4DRiBjCo+3gTNxv6jr4QmtoqH5
   G/P+eCmdgozQftm8H7rH6CEMB+ltfxVH5cXBKY9d/P0Oadhe5VZPqnaHh
   AasKz1iXCZ4kYuf9Cyq61qgT+4UuDiJ3cg3aBOvJrkTTArOXsVHDoEgJF
   k0HdI1X8ZHVjCWrg/Ipl7rV+SWGlS2FfjKe6IoUu6YqfGu784M6Fqhw0K
   WCwchtAiEp+/hIeWY3wf81YFQh2fUESb08/gJtpOhW63Gpdc3QSqiScvh
   Vxc52ZhmRr64HgBCglF9Et4d4tjM1spuACFcVpiKLdzyxV61BIvdkM7fa
   g==;
X-CSE-ConnectionGUID: 0jMTWNdAS2aFaNOLUT54iw==
X-CSE-MsgGUID: C5tGTc4JTjmMoJI+VZ//xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18837131"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18837131"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 09:27:42 -0700
X-CSE-ConnectionGUID: eO0p8wtaQSW5ISEQjzvlNQ==
X-CSE-MsgGUID: 0V9qqLyfQMOCzSrfOBR6XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25422038"
Received: from ntasneem-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.182.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 09:27:41 -0700
Date: Thu, 11 Apr 2024 09:27:39 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: repair file entry in COMPUTE EXPRESS LINK
Message-ID: <ZhgPe5mDt2ocXovz@aschofie-mobl2>
References: <20240411062443.47372-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411062443.47372-1-lukas.bulwahn@redhat.com>

On Thu, Apr 11, 2024 at 08:24:43AM +0200, Lukas Bulwahn wrote:
> Commit 12fb28ea6b1c ("EINJ: Add CXL error type support") adds the header
> file include/linux/einj-cxl.h, but then adds a file entry with cxl-einj.h
> (note the swapping of words) to the COMPUTE EXPRESS LINK (CXL) section.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair the file entry in COMPUTE EXPRESS LINK (CXL).

How about stating the impact, something like:

get_maintainer.pl can only return commit_signer history for file
include/linux/einj-cxl.h because the entry in MAINTAINERS is wrong.
Correct the entry so that the full MAINTAINER list is returned.

It is interesting how you found it and I'm not suggesting deleting
that.

Thanks,
Alison


> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edf6176a5530..03204db05027 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5415,7 +5415,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	drivers/cxl/
> -F:	include/linux/cxl-einj.h
> +F:	include/linux/einj-cxl.h
>  F:	include/linux/cxl-event.h
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
> -- 
> 2.44.0
> 
> 

