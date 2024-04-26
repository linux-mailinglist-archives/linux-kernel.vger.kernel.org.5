Return-Path: <linux-kernel+bounces-160050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9418D8B3859
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1C91C230E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E893147C67;
	Fri, 26 Apr 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxYfYQoJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07BF13E88A;
	Fri, 26 Apr 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137926; cv=none; b=lA7tds5MdMkFXiC4jOgTAkxyj+9rnUbo7UDTGG7bq3+R92qB9hmTl3mvYwpAb/xog1y/Dh2j5bEmZTvAM6LQ77292gHVTSNSO9G8I4bBJECYymvshoamISdE/YNxH1/GuakwAMYgwK778amJ9lExRQPzj/kp55Y36rSblGL2t30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137926; c=relaxed/simple;
	bh=wrFvzBHWtoD17fbW2f/KSN/X1vBLYzoBPj1SNMLxdRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0aD/DO7a9zZMYjy83iFfUAv92bilnSYJCZyKjpmN4BURoJETpnCakWrtzFnEvo52U2WTv6Z6cF1vTobF4DVi74I0MMTVeLKxSz+q6cVvbrDgc0bxTE2E1OOwTm0AQ2a0Wu4lGQCJfSAlOfrCxwiDXuA6V2l8h1kBrxgRh2J4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxYfYQoJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714137925; x=1745673925;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wrFvzBHWtoD17fbW2f/KSN/X1vBLYzoBPj1SNMLxdRo=;
  b=FxYfYQoJiqQ4XFK0+20FMa/SdLPdyR14aywTaRZZrqY0I0BOOJ9eidwS
   D2kckzlnJNOmiwV+UTAYJWHl78DcWFCFZ5q9IOE3CAbmlRm7a88cs7MDT
   H1NHT9DiUAu3iAlc5tcpoo8HwpRTzxXKB4dAQyPBb7D5fX+CiihHYiRDW
   PA4ZYH2XB6PdWRfd3h2JxAG4OPBktKMobIw1uChJZRZ4CzdvfouaFRaUc
   rU+8+42FkFvnGSkYvDg/yRkJqIT+vDkYlIJxQ1sOwTAditnAlu8fopdqj
   MUkHqLfD38jKQ2Vv0xyQNChUIDPL1E5jUNnpvGzj/j9FFowJ26cmWjoKh
   w==;
X-CSE-ConnectionGUID: ZKv3CoJfR0WM2TDV1wlD+A==
X-CSE-MsgGUID: omO/glAoR7GgvzoCwfq3BQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="27388466"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="27388466"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:25:24 -0700
X-CSE-ConnectionGUID: Gl8OHmJ8Qr+bku/V74LdJA==
X-CSE-MsgGUID: YJy8i+p+RI6WRk3uU1XurA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25302209"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:25:18 -0700
Message-ID: <3d70c19f-bab8-4e50-9551-de406a0e0314@linux.intel.com>
Date: Fri, 26 Apr 2024 15:25:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 22/41] ASoC: usb: Add PCM format check API for USB
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
 <20240425215125.29761-23-quic_wcheng@quicinc.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240425215125.29761-23-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/2024 11:51 PM, Wesley Cheng wrote:
> Introduce a helper to check if a particular PCM format is supported by the
> USB audio device connected.  If the USB audio device does not have an
> audio profile which can support the requested format, then notify the USB
> backend.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---

(...)

> +/**
> + * snd_soc_usb_find_format() - Check if audio format is supported
> + * @card_idx: USB sound chip array index
> + * @params: PCM parameters
> + * @direction: capture or playback
> + *
> + * Ensure that a requested audio profile from the ASoC side is able to be
> + * supported by the USB device.
> + *
> + * Return 0 on success, negative on error.
> + *
> + */
> +int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params *params,
> +			int direction)

Perhaps name function similar to its snd_usb equivalent, so 
snd_soc_usb_find_supported_format?

> +{
> +	struct snd_usb_stream *as;
> +
> +	as = snd_usb_find_suppported_substream(card_idx, params, direction);
> +	if (!as)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_find_format);
> +
>   /**
>    * snd_soc_usb_allocate_port() - allocate a SOC USB device
>    * @component: USB DPCM backend DAI component
> 


