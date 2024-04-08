Return-Path: <linux-kernel+bounces-135744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D189CAAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E45C1F27375
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825961442FB;
	Mon,  8 Apr 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8Tggwn2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192F143860;
	Mon,  8 Apr 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596985; cv=none; b=SC1CiHo8IQkeX9TJDFBw5Bi72iyhJAZ3/WE4N3ZTdyzJP6Oo3esoG5yY7WGVmaqoCrUajeLja+iUyh0Fko7HY+qXQPcofdcmKzrzfKFCKdQ9oecMg+KrO6OaWZ+KkQteEtVHsIdx2C5g+hylmwr2ULLtFgcIo3AvpSIhk9aIGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596985; c=relaxed/simple;
	bh=Pqh3pyoAGMUHh7oj7/eiymnpIKVlFY2rZB4bG8dyHWI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h2Z7pwoAq6mjMYC49hTFyaqBCF2fWX+Dy0cAYQYdkNJFzcHSwMRWHS0itms9jHX50xn4C9gYQdO/gkwloX7wpncEn3Lm2Hq60wpmSsfLYEEfmwELIWlN32sK6miN69O3awyS1zaKjULXBN/4RCeRmEpIAH8V22HgxkRbluGQb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8Tggwn2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712596984; x=1744132984;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Pqh3pyoAGMUHh7oj7/eiymnpIKVlFY2rZB4bG8dyHWI=;
  b=Y8Tggwn2E7nnZ1xEP3lOhSfcO5IQl55ssMdB9lmfsvtabS/SaD3w2Fg2
   2YDzTP6HkbXcA7PsP1TvgPb/2YriqvotGmnqtdUoYqI1DSG+Em62MkUUl
   K8qeId8RUHRHk4I9Ero5joK95uaAAfd/9xxVWyQKecWyPEEWMLvQQ1Nql
   kjig9jAWMWETSwO/acKzxNy1AHQ62mtpu79BA2C/NHv5IywQfT2edSURm
   zhVyjlKRn15h3H85c/iZCxgQH6yDzhBPZZUBLUivc5cjgqot50daENG0a
   tAI+GKrS/YjC1aepISY441jjDIAI5dfvBFlOEESzXhQusYt5YeTXicG5c
   w==;
X-CSE-ConnectionGUID: KOw7q+nwSz674k2fFXtLIA==
X-CSE-MsgGUID: dSR1qco2TPCnPOT6mhfGdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8112054"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8112054"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:23:03 -0700
X-CSE-ConnectionGUID: axvwqU3gQVOpapr20X6fPA==
X-CSE-MsgGUID: JxHFW/8+Qwm9nS4h3K8IXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19877439"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:23:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Apr 2024 20:22:57 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH V3 8/9] platform/x86/intel/sdsi: Simplify ascii
 printing
In-Reply-To: <20240405032507.2637311-9-david.e.box@linux.intel.com>
Message-ID: <6dd8b2c0-1c89-43f0-0426-df8d483a7b1e@linux.intel.com>
References: <20240405032507.2637311-1-david.e.box@linux.intel.com> <20240405032507.2637311-9-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 4 Apr 2024, David E. Box wrote:

> Use printf width specifier to set the display length of encoded feature
> names.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> V3 - Add FEAT_LEN #def
> 
> V2 - Split of V1 patch 7
> 
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index 45bc69e6718e..0c9670ba1f15 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -43,6 +43,7 @@
>  #define METER_CERT_MAX_SIZE	4096
>  #define STATE_MAX_NUM_LICENSES	16
>  #define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
> +#define FEAT_LEN		4
>  
>  #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
>  #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
> @@ -409,11 +410,10 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  
>  	printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle_length));
>  	while (count < BUNDLE_COUNT(mc->bundle_length)) {
> -		char feature[5];
> +		char feature[FEAT_LEN];
>  
> -		feature[4] = '\0';
>  		get_feature(bec[count].encoding, feature);
> -		printf("    %s:          %d\n", feature, bec[count].counter);
> +		printf("    %.4s:          %d\n", feature, bec[count].counter);
>  		++count;
>  	}
>  
> @@ -494,7 +494,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
>  			sizeof(*lki) +			// size of the license key info
>  			offset;				// offset to this blob content
>  		struct bundle_encoding *bundle = (void *)(lbc) + sizeof(*lbc);
> -		char feature[5];
> +		char feature[FEAT_LEN];
>  		uint32_t i;
>  
>  		printf("     Blob %d:\n", count - 1);
> @@ -507,11 +507,9 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
>  		printf("        Blob revision ID:           %u\n", lbc->rev_id);
>  		printf("        Number of Features:         %u\n", lbc->num_bundles);
>  
> -		feature[4] = '\0';
> -
>  		for (i = 0; i < min(lbc->num_bundles, STATE_MAX_NUM_IN_BUNDLE); i++) {
>  			get_feature(bundle[i].encoding, feature);
> -			printf("                 Feature %d:         %s\n", i, feature);
> +			printf("                 Feature %d:         %.4s\n", i, feature);
>  		}
>  
>  		if (lbc->num_bundles > STATE_MAX_NUM_IN_BUNDLE)
> 

Hi,

After staring this for a while, I cannot get rid of the feeling that the 
removal of NUL termination is a step into wrong direction. But IMO, 
instead of the caller side, the NUL termination could be added inside 
get_feature().

-- 
 i.


