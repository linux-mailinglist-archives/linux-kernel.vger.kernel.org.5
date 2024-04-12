Return-Path: <linux-kernel+bounces-143243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD818A3638
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB757B2395B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD39614F9EC;
	Fri, 12 Apr 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1kHyLw9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11C14AD37;
	Fri, 12 Apr 2024 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949241; cv=none; b=dO7bnDgspknU0z1KMkTaFKMbpepyZQEtpy7/kVv6qsNK3sxwykRWEZJfbuWyMOwYWt4R/xWRFeecUlMIyRv0+E5MUQyzTXX/eh0IteLNoN6rse98KsHrOdeJDErhu6uTtnFiHLjPReM0MVhUYW4JhOZLGEWLjnLcfdIBvzZIMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949241; c=relaxed/simple;
	bh=Eu3ZcZPFL16HSzXgIdXanfvswaxE9WSR58W60oCYX1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fn9rDdSfCrDTpY5ruBgqvkWTWVpBPWhn1yvsGWjQYTQsG37QRzCLX5ojQ0+utDZAsJlxHnmB97NGFF/ROkrENKCk+/x7djdC52kq14O5HG19hmJtueWD1PQU+qJ8ZnxgcyMOU0u6HAiTWHMW+JFDCUIzRaJJ9UuDBBig2625Xt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1kHyLw9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712949240; x=1744485240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Eu3ZcZPFL16HSzXgIdXanfvswaxE9WSR58W60oCYX1A=;
  b=h1kHyLw9jG1mSlPE9pRxS8PO1Ol8XraPcLvUWYI3+oHW7hq4SeLnPDkJ
   PWkYbsQ4dxkWqt5zdZQ0+rJ9KQXnRqJm7TOeve1WWz5lWBFbXGKOne5k3
   XANrRS1tsW4UDvPXRtWGRUr6jzBsUrykUa0tAx6yGUX7k7zg4S/UjAEuh
   LLzUPq9ekbAL6qmxA+gzmYolj3tFyWDwPr6hXg1S1AD4FMxBISVW/o3kd
   dcpsGByryf5XtT4N45WXu9amMXw1vVXBrh5tXs7b0/9GjGXbTNLJI+Yth
   7m7cbotxLZZgzChAfiHAocJA3TMLY7rqryraPG9ISBCdk0NLHxEO6pPW6
   w==;
X-CSE-ConnectionGUID: CUOPCJzMSjGxnSz03ZpSng==
X-CSE-MsgGUID: s/svFllQR7Ggv6U2TdhLCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12200342"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="12200342"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 12:13:59 -0700
X-CSE-ConnectionGUID: VQj/SEm1QCagNhACyRVF7w==
X-CSE-MsgGUID: vJ5c31aURduo5abfjbOttw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="26107097"
Received: from zchen24-mobl1.amr.corp.intel.com (HELO [10.209.67.36]) ([10.209.67.36])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 12:13:59 -0700
Message-ID: <156e1b5b-0f19-4993-b46c-7b67b91317a4@linux.intel.com>
Date: Fri, 12 Apr 2024 12:13:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] platform/x86/intel/ifs: Disable irq during one load
 stage
To: Jithu Joseph <jithu.joseph@intel.com>, ilpo.jarvinen@linux.intel.com,
 hdegoede@redhat.com, markgross@kernel.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
 ravi.v.shankar@intel.com, patches@lists.linux.dev
References: <20240412172349.544064-1-jithu.joseph@intel.com>
 <20240412172349.544064-4-jithu.joseph@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240412172349.544064-4-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/12/24 10:23 AM, Jithu Joseph wrote:
> One of the stages in IFS image loading process involves loading individual
> chunks (test patterns) from test image file to secure memory.
>
> Driver issues a WRMSR(MSR_AUTHENTICATE_AND_COPY_CHUNK) operation to do
> this. This operation can take up to 5 msec, and if an interrupt occurs
> in between, the AUTH_AND_COPY_CHUNK u-code implementation aborts the
> operation.
>
> Interrupt sources such as NMI or SMI are handled by retrying. Regular
> interrupts may occur frequently enough to prevent this operation from ever
> completing. Disable irq on local cpu around the aforementioned WRMSR to
> allow the operation to complete.
>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---


Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/platform/x86/intel/ifs/load.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index 584c44387e10..39f19cb51749 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -233,7 +233,9 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
>  		chunk_table[0] = starting_chunk_nr + i;
>  		chunk_table[1] = linear_addr;
>  		do {
> +			local_irq_disable();
>  			wrmsrl(MSR_AUTHENTICATE_AND_COPY_CHUNK, (u64)chunk_table);
> +			local_irq_enable();
>  			rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
>  			err_code = chunk_status.error_code;
>  		} while (err_code == AUTH_INTERRUPTED_ERROR && --retry_count);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


