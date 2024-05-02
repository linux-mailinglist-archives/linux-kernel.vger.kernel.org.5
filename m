Return-Path: <linux-kernel+bounces-166371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43898B99B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B41D1F23D5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451CD6CDCC;
	Thu,  2 May 2024 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftuPKS2c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8F65FEF2;
	Thu,  2 May 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647941; cv=none; b=QHIcBTsMeRKPjzg2cR9KiBWyHeRIURKzkC7qdzLyhRXml0ebE36uYfo4ojmdK59CXVBNuW56CQ19lVglD4aMjnaU0eoGw4BZVgFImSTgkuRmObRdFNjVlEYfli4h1jXWxXW0pNB8W5A8/QGUszOEBGEx2jt4wPGpN8BVqnZuzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647941; c=relaxed/simple;
	bh=EluTdDMIMNhKZ/EkpupaemH1PZsrZoO5k/Ow1fEItns=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=hgudez0EHh1lSeBgMrnyQ6P9F1uXbbhzXjgkjErC+XGidjJggXOQuOFhqRUe7FScZ8oNkbb02EnlTlY+cm7+T82zHuDJ80hmIVfNQhBMV3G7jIVcFvVruLygQHSbb62YEZhXn/LmQvsAYnwhp/T+Vv1L5n2kCBDEoxzyzvXvEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftuPKS2c; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714647940; x=1746183940;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=EluTdDMIMNhKZ/EkpupaemH1PZsrZoO5k/Ow1fEItns=;
  b=ftuPKS2c6s6Q6BcO03FR5MvmaWT642aql9qTd4VwhhM615excS1TAHcF
   c9zmc2rp/d0eBS0bjC/PpknfcH5DXWZ9MzCAskdkPdyMLUx+W88fFRv8A
   GNrGBdEeB3YFR5ywBb8QUnjYDV7ylN+kCa+mErnVhsnOAOeTw9f6dfkou
   T8LVGsgHgUnIYaEeN/yyJMYy3wfWIO1wtlVVs5LCPc3W1CVfFTsIc2AYj
   yj3f4C0tAdSo09qyIPsEnNGI4e+qnKQBawITc/+WQpVfk3sMjS/+7sMgL
   SzPA72pIQdUBhv1bfnYw1btn3TkEE/U/AnrehM2eNl4AW99WmaXG1oPuC
   Q==;
X-CSE-ConnectionGUID: oUmZip18Tjm7AxchHOyvjA==
X-CSE-MsgGUID: QnUiwb2NQxGOBAcRY3am0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="21813489"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21813489"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 04:05:39 -0700
X-CSE-ConnectionGUID: RNrykgpXQNOhcPL/BW4gnA==
X-CSE-MsgGUID: 8wdqEQM1TVOscvvgR0xz0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50280954"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa002.fm.intel.com with ESMTP; 02 May 2024 04:05:34 -0700
Message-ID: <ddd682da-5cfd-db09-e316-3c54939caf90@linux.intel.com>
Date: Thu, 2 May 2024 14:07:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
 Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
 tiwai@suse.com, robh@kernel.org, konrad.dybcio@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240425215125.29761-1-quic_wcheng@quicinc.com>
 <20240425215125.29761-7-quic_wcheng@quicinc.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v20 06/41] usb: host: xhci-sideband: Expose a sideband
 interrupter enable API
In-Reply-To: <20240425215125.29761-7-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.4.2024 0.50, Wesley Cheng wrote:
> Some use cases maybe require that the secondary interrupter's events to
> be handled by the OS.  In this case, configure the IMOD and the
> skip_events property to enable the interrupter's events.  By default,
> assume that the secondary interrupter doesn't want to enable OS event
> handling.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>   drivers/usb/host/xhci-sideband.c  | 28 ++++++++++++++++++++++++++++
>   include/linux/usb/xhci-sideband.h |  2 ++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
> index 255feae33c6e..6fdae9840c11 100644
> --- a/drivers/usb/host/xhci-sideband.c
> +++ b/drivers/usb/host/xhci-sideband.c
> @@ -237,6 +237,30 @@ xhci_sideband_get_event_buffer(struct xhci_sideband *sb)
>   }
>   EXPORT_SYMBOL_GPL(xhci_sideband_get_event_buffer);
>   
> +/**
> + * xhci_sideband_enable_interrupt - enable interrupt for secondary interrupter
> + * @sb: sideband instance for this usb device
> + * @imod_interval: number of event ring segments to allocate
> + *
> + * Enables OS owned event handling for a particular interrupter if client
> + * requests for it.  In addition, set the IMOD interval for this particular
> + * interrupter.
> + *
> + * Returns 0 on success, negative error otherwise
> + */
> +int xhci_sideband_enable_interrupt(struct xhci_sideband *sb, u32 imod_interval)
> +{
> +	if (!sb || !sb->ir)
> +		return -ENODEV;
> +
> +	xhci_set_interrupter_moderation(sb->ir, imod_interval);

Is there a need to adjust the moderation after initial setup?

If not then maybe we could pass the imod_interval as a parameter to
xhci_create_secondary_interrupter(), and avoid exporting
xhci_set_interrupter_moderation()


> +	sb->ir->skip_events = false;
> +	xhci_enable_interrupter(sb->ir);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xhci_sideband_enable_interrupt);

I can't find the place where xhci_sideband_enable_interrupt() is called in
this series. How is it planned to be used?

Thanks
Mathias

