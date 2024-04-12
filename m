Return-Path: <linux-kernel+bounces-143204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69E28A35C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EEF1C20FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B2A14EC59;
	Fri, 12 Apr 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggwifxal"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4584DE1;
	Fri, 12 Apr 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946753; cv=none; b=QrySX2KSnB9zN950Ij0cXBXXtyGtiJGq/ANOM3G0ZG7hpjysoTI+uOIVrJdR8XZeII8aj/malnWn1K3xSTDNJfjx71kQmZG3n2DnqF2YXg9zIgVMiH0Eps0CAYu6Y6kHPmdXf8xLc678CZz/RvZ0uHPyH/xLX6uMvhhHlsnCB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946753; c=relaxed/simple;
	bh=ttvLuHMoGwHeewRvCwDqfzT3SMzAGEX8nFjD//4xCgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHBlUqOOyKgbnv6lcyXD+v/+AiAmXrg/2jWp92KqF48HtQ/kUiB6X53m0CanhJcE9kQ5joLQMcMglfnT4GwO/juZ4QyFdSum3fftaf/ktvmd1VbmrrNw4/tPc1cLwz8A6+GBEadVWjlPS9hepeiDMn3XQkQE3zxRK+xkcy6YgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggwifxal; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712946752; x=1744482752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ttvLuHMoGwHeewRvCwDqfzT3SMzAGEX8nFjD//4xCgs=;
  b=ggwifxalrQK1/nzTFC/o5MdMLpF67FjUKo6DvtiUnfL0xEdBV9++3ImE
   3GTtCdLKjaPt3BuRwP/ZX7A9kQXC1KAtdDnbWl6Ul6ic6YCC48/0Lkytx
   p96W4mY5qZ2cGyDbjz163rtYe2eg59BuZ7EsCRuf7dLd9/r7ksE2KM6JA
   f0XtyjYbH2L6tVq+9w05c6tV2EkTGpxK8Vz971lWSy5V1bA9mFmOq0Jkp
   hsI7y3024K/yzYcPDce6YWahxORnnO0EIFl4IhQxX9id9l1F7cOzq9j4c
   WHmO3qoOMRlOZg5B38Gw5lO8GVDTTFyNTenPVCTJ3I4Beg6i7gndmgG0u
   g==;
X-CSE-ConnectionGUID: oYZfG546RR+lQp5KOJOHDg==
X-CSE-MsgGUID: yIBIf/rVRku21sxBdsWbMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="18971725"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="18971725"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:32:31 -0700
X-CSE-ConnectionGUID: sVe73lVISr27H0YQwp5q+Q==
X-CSE-MsgGUID: K0K4azY0TC6o/W9mWqeStw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="44568319"
Received: from zchen24-mobl1.amr.corp.intel.com (HELO [10.209.67.36]) ([10.209.67.36])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:32:30 -0700
Message-ID: <69d360fc-85e4-4a6d-8f08-9f90dd7ec583@linux.intel.com>
Date: Fri, 12 Apr 2024 11:32:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] platform/x86/intel/ifs: Classify error scenarios
 correctly
To: Jithu Joseph <jithu.joseph@intel.com>, ilpo.jarvinen@linux.intel.com,
 hdegoede@redhat.com, markgross@kernel.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
 ravi.v.shankar@intel.com, patches@lists.linux.dev
References: <20240412172349.544064-1-jithu.joseph@intel.com>
 <20240412172349.544064-2-jithu.joseph@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240412172349.544064-2-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/12/24 10:23 AM, Jithu Joseph wrote:
> Based on inputs from hardware architects, only "scan signature failures"
> should be treated as actual hardware/cpu failure.

Instead of just saying input from hardware architects, it would be better
if you mention the rationale behind it.

> Current driver, in addition, classifies "scan controller error" scenario
> too as a hardware/cpu failure. Modify the driver to classify this situation
> with a more appropriate "untested" status instead of "fail" status.
>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewe

Code wise it looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> d-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/runtest.c | 27 +++++++++++++-----------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 95b4b71fab53..282e4bfe30da 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -69,6 +69,19 @@ static const char * const scan_test_status[] = {
>  
>  static void message_not_tested(struct device *dev, int cpu, union ifs_status status)
>  {
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +
> +	/*
> +	 * control_error is set when the microcode runs into a problem
> +	 * loading the image from the reserved BIOS memory, or it has
> +	 * been corrupted. Reloading the image may fix this issue.
> +	 */
> +	if (status.control_error) {
> +		dev_warn(dev, "CPU(s) %*pbl: Scan controller error. Batch: %02x version: 0x%x\n",
> +			 cpumask_pr_args(cpu_smt_mask(cpu)), ifsd->cur_batch, ifsd->loaded_version);
> +		return;
> +	}
> +
>  	if (status.error_code < ARRAY_SIZE(scan_test_status)) {
>  		dev_info(dev, "CPU(s) %*pbl: SCAN operation did not start. %s\n",
>  			 cpumask_pr_args(cpu_smt_mask(cpu)),
> @@ -90,16 +103,6 @@ static void message_fail(struct device *dev, int cpu, union ifs_status status)
>  {
>  	struct ifs_data *ifsd = ifs_get_data(dev);
>  
> -	/*
> -	 * control_error is set when the microcode runs into a problem
> -	 * loading the image from the reserved BIOS memory, or it has
> -	 * been corrupted. Reloading the image may fix this issue.
> -	 */
> -	if (status.control_error) {
> -		dev_err(dev, "CPU(s) %*pbl: could not execute from loaded scan image. Batch: %02x version: 0x%x\n",
> -			cpumask_pr_args(cpu_smt_mask(cpu)), ifsd->cur_batch, ifsd->loaded_version);
> -	}
> -
>  	/*
>  	 * signature_error is set when the output from the scan chains does not
>  	 * match the expected signature. This might be a transient problem (e.g.
> @@ -285,10 +288,10 @@ static void ifs_test_core(int cpu, struct device *dev)
>  	/* Update status for this core */
>  	ifsd->scan_details = status.data;
>  
> -	if (status.control_error || status.signature_error) {
> +	if (status.signature_error) {
>  		ifsd->status = SCAN_TEST_FAIL;
>  		message_fail(dev, cpu, status);
> -	} else if (status.error_code) {
> +	} else if (status.control_error || status.error_code) {
>  		ifsd->status = SCAN_NOT_TESTED;
>  		message_not_tested(dev, cpu, status);
>  	} else {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


