Return-Path: <linux-kernel+bounces-135727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FF989CA71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773091F23153
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C0514387E;
	Mon,  8 Apr 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jduS4//O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E5142906;
	Mon,  8 Apr 2024 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596225; cv=none; b=S2Awch2LXy6xS3FerIrUgt1fPeydxP5Bs0yli8TaRjkxpqSk9UM9UTr3lsI4oHg6TBaH286NinwMRCob5MUOInhp0aLlwirYc3UWtXJ0L82q7euJr+a8XmonTTAAyDLiwgFGIpNDmNRVpddfwC17/zQH0zW+0oEBHuYfoJJMRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596225; c=relaxed/simple;
	bh=qB02tO0c11oTDoGkptLF9S44KzrfXCWpSzxS13m35GA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=raLTy9j0c5IFQv5Csj87BWMJbWWDTBD81FONIOSv38OtUqXI/F8Jrc3N2eZWKPWNXhqNyMEAw8T3ey4n5kJq3UQ03tDXfQxXoPX9eq2dZF5QHydK9AWx+VQqR+iPP84V29lSIrOI3vAxagf4i7NkqpDum2tTv3gqWcVzbiCi8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jduS4//O; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712596224; x=1744132224;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qB02tO0c11oTDoGkptLF9S44KzrfXCWpSzxS13m35GA=;
  b=jduS4//OMiC71tK2mwlg/ZZYB2Cyl8HywMkjie+o0lXHoqsfthdgL/dp
   Z2YrPkCOJb7MNwrFRhY20k6S9vmMzzjPupGi7vDJVLqlHMMVbndxzSE3U
   bc5J12bKvXzJonuquswkh1r3JIxFfh8W4jcT0c4rOUQi9lQ9yWkU9lGDt
   Ic95Vwj1eKiPKN5uZeUvrZywjuuCy18Ky1wtIjbE1rv59enRnC3aVfshD
   jx/knl7w0sFOZBn7k1zQ1ym205yqOP4esw0tO+90VmWmObsgej5b027gb
   qYLTCgEN3IQP79Zo57MO5+2wZNNAYEytpSQjpfWOU44TDJyOjXNvSibt0
   g==;
X-CSE-ConnectionGUID: EJlnlxQTQ9+binjwE18Xsg==
X-CSE-MsgGUID: K8mxhO8qTWu160/4TmpfiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="33285774"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="33285774"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:10:23 -0700
X-CSE-ConnectionGUID: 7rD6KCJESBGEq2pgugLXIA==
X-CSE-MsgGUID: Vo9e1p9GSHKfBP7XuibKdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="50949697"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:10:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Apr 2024 20:10:16 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH V3 7/9] tools/arch/x86/intel_sdsi: Fix meter_certificate
 decoding
In-Reply-To: <20240405032507.2637311-8-david.e.box@linux.intel.com>
Message-ID: <5fa57609-fc49-c499-b2c7-ec9400696619@linux.intel.com>
References: <20240405032507.2637311-1-david.e.box@linux.intel.com> <20240405032507.2637311-8-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 4 Apr 2024, David E. Box wrote:

> Fix errors in the calculation of the start position of the counters and in
> the display loop. While here, use a #define for the bundle count and size.
> 
> Fixes: 7fdc03a7370f ("tools/arch/x86: intel_sdsi: Add support for reading meter certificates")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> V3 - Use macros for bundle size and count
> 
> V2 - Split of V1 patch 7
> 
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index a0711177e1bb..45bc69e6718e 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -394,7 +394,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  	printf("MMRC encoding:                %.4s\n", name);
>  
>  	printf("MMRC counter:                 %d\n", mc->mmrc_counter);
> -	if (mc->bundle_length % 8) {
> +	if (mc->bundle_length % METER_BUNDLE_SIZE) {
>  		fprintf(stderr, "Invalid bundle length\n");
>  		return -1;
>  	}
> @@ -405,15 +405,16 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  		return -1;
>  	}
>  
> -	bec = (void *)(mc) + sizeof(mc);
> +	bec = (void *)(mc) + sizeof(*mc);

The first (mc) doesn't need parenthesis. But this could be rewritten to 
avoid void * entirely:

	bec = (struct bundle_encoding_counter *)(mc + 1);

-- 
 i.

>  	printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle_length));
> -	while (count++ < mc->bundle_length / 8) {
> +	while (count < BUNDLE_COUNT(mc->bundle_length)) {
>  		char feature[5];
>  
>  		feature[4] = '\0';
>  		get_feature(bec[count].encoding, feature);
>  		printf("    %s:          %d\n", feature, bec[count].counter);
> +		++count;
>  	}
>  
>  	return 0;
> 

