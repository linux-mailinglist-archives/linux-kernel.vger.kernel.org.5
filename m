Return-Path: <linux-kernel+bounces-160049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C208B3853
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50621C22C85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC2A147C68;
	Fri, 26 Apr 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H00NgdkS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9227146D62;
	Fri, 26 Apr 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137910; cv=none; b=Rwj+7eeJpL47/52S09jtOa9uXbdwPsSGI4FHcdQGmpUrWJ1oPAVaYxDccNfDxLg22fyGB6uJm70DYckN1Xs8HVfixty12pLjSapRM2XofA2BK5MZC2U6tXz8uDipK7DWtDKOGRbmkl1lqGKBPeX1EqEBkmJmveLoLdScyhitGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137910; c=relaxed/simple;
	bh=ckDRuhsvVS1VZSimrLSwe76FYVFxcPXR+y8JqIk4Hrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4MtUGG/Fm67v8AVOmFaiiahy4dpYI2NnBLg6dHzwQCpH61ZL/sqN4fIpZX5ER9vSE+WOmaFr42+r+CXvfiDY3O/4Hf/I//5xNlG0a31QC4zlm3qNUh3Ofx7HMWI4nxUlzR2rbpuejkeaeKxLhqI/YOfENJOW15VGVTXnTZ1Ou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H00NgdkS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714137909; x=1745673909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ckDRuhsvVS1VZSimrLSwe76FYVFxcPXR+y8JqIk4Hrg=;
  b=H00NgdkSGOETAO0uXkpNy50eVFE4gUriz9jUORmu2sgD/RBNR4CQnV2o
   krxIONYgNy/5VIBrELEcLTP0cUUnomlvvc4xblseApsaE//KE1XRnH6cS
   Vgd9wjQqNpJfbzfOSJH760k+ZOymMf/hbY2VOXFGmdCMJf1E0q/eeLWp/
   oi1fJ7Wl0Tano3s2CZaOsu2Kyp/fz+ncHHpbgkmkoQBS/I7mFR2XfGn+0
   BlzZiT1tlDdzKmWkIGyyZA6+25rlSA9jR4LATB+YsO5WHvE2ady1wHPO1
   cAhEAoRpHnKK3+TbPilHIT6r1Jdk+TW8GtlAVqKi0s/WshAruXJ5ORlNV
   w==;
X-CSE-ConnectionGUID: RK4q18J1T5C2g2Bw5FwZyA==
X-CSE-MsgGUID: mPaSsJcnT2WKS5WQ93XX3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="27388423"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="27388423"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:25:08 -0700
X-CSE-ConnectionGUID: e13BTyWfSnS+Wk2p9q4Yrg==
X-CSE-MsgGUID: kknPYFCBTRSMZLGJk31ntQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25302192"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:25:02 -0700
Message-ID: <b8ff8777-6bcb-4fd7-9480-231536d23759@linux.intel.com>
Date: Fri, 26 Apr 2024 15:25:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 09/41] ASoC: Add SOC USB APIs for adding an USB
 backend
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
 <20240425215125.29761-10-quic_wcheng@quicinc.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240425215125.29761-10-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/2024 11:50 PM, Wesley Cheng wrote:
> Some platforms may have support for offloading USB audio devices to a
> dedicated audio DSP.  Introduce a set of APIs that allow for management of
> USB sound card and PCM devices enumerated by the USB SND class driver.
> This allows for the ASoC components to be aware of what USB devices are
> available for offloading.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---

(...)

> +const char *snd_soc_usb_get_components_tag(bool playback)
> +{
> +	if (playback)
> +		return "usbplybkoffld: 1";
> +	else
> +		return "usbcapoffld: 1";
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_get_components_tag);

Is this used to expose some information to userspace?
Can those be some more readable strings if so, like:
usbplaybackoffload, usbcaptureoffload

(...)

> +
> +	node = snd_soc_find_phandle(usbdev);
> +	if (IS_ERR(node))
> +		return -ENODEV;
> +
> +	ctx = snd_soc_find_usb_ctx(node);
> +	of_node_put(node);
> +	if (!ctx)
> +		return -ENODEV;

Perhaps introduce some helper function, you do this 
snd_soc_find_phandle() followed by snd_soc_find_usb_ctx() in few places...


