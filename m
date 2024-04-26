Return-Path: <linux-kernel+bounces-160054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB748B386D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0E71C234F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEC6147C89;
	Fri, 26 Apr 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYKm5VGy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAC13E88A;
	Fri, 26 Apr 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138013; cv=none; b=iHoDYDco2c+AZ5Jy2TLGxAyhelAooKc/p3emTEHnZ8QMJASYYk20ZVnnHhEKRDKIx6M7PJB0b716o/aYM5N9qtY0ON7Rry3mQ365g+uYgtKJvX9t8PgwVwT/62Sq2FF3CjnK+LRB4+Hd8xcOyF1Ik8z7C0IgiTFX+0rqUuMN0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138013; c=relaxed/simple;
	bh=+uYe9/x+IyHqzkvDA3Df7sQhXUVBGynf8X0Ns4EUF9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+245hl3NU5Ov2ozekRyFJS1zzLmA9ZYKvV2Asp7qHzgGKVhm94mcaElE9NUWkdoArrxPqRG7oKhf8iD0vTJJIN6BWqpNz7J6tdCoYnpEUKYN1mTwHT6aIe+bAnfF4ZG6fBzjY46J9NTvVdCTRKLtrcy9GAyurM59OhOeCl2meE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYKm5VGy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714138011; x=1745674011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+uYe9/x+IyHqzkvDA3Df7sQhXUVBGynf8X0Ns4EUF9E=;
  b=AYKm5VGyZUfxcgTPHL8aKs/Kqd/0qNR8J//EXLpLbBsTr05z1vKML81w
   HzSqJpEgcY5e6CsqRDmJWMGiDSKOIMFousPczcbiRkzdI7y3KZXVRDsV4
   FThvsw6675m+NnNJkup4HnVAr9qjRR5zRWSaUhwhSvwEsHQITNCqZacCG
   DJC3uYfFB40gRR3Si5WI5BcHgcwH5kt0lA5u+LGrJnftdonxr/wpkQmG3
   7qU5F6Fma+dnCrq7pv3NahsxflnpXo0w/fIDfOP0AgYyChq/ZMNw5sFN/
   yb/4wp1S23Z7MC1fVh03oW1ieJ7RTWtslxFLC3D+b+h80eX5rI8BDmR98
   Q==;
X-CSE-ConnectionGUID: sPgWN0GqQCyVsJz6FJb32Q==
X-CSE-MsgGUID: /F2hEw2RQOWtGq4Qw/hjiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="27388608"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="27388608"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:26:50 -0700
X-CSE-ConnectionGUID: xwgeRoRqT4ugnI1Te21ZzA==
X-CSE-MsgGUID: 7L/JNJSaTgeljesKbElbtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25302283"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:26:45 -0700
Message-ID: <c8bd16e8-b204-471b-a702-36e14c8695c5@linux.intel.com>
Date: Fri, 26 Apr 2024 15:26:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 33/41] ASoC: usb: Create SOC USB SND jack kcontrol
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
 <20240425215125.29761-34-quic_wcheng@quicinc.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240425215125.29761-34-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/2024 11:51 PM, Wesley Cheng wrote:
> Expose API for creation of a jack control for notifying of available
> devices that are plugged in/discovered, and that support offloading.  This
> allows for control names to be standardized across implementations of USB
> audio offloading.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---

(...)

>   /* SOC USB sound kcontrols */
> +/**
> + * snd_soc_usb_setup_offload_jack() - Create USB offloading jack
> + * @component: USB DPCM backend DAI component
> + * @jack: jack structure to create
> + *
> + * Creates a jack device for notifying userspace of the availability
> + * of an offload capable device.
> + *
> + * Returns 0 on success, negative on error.
> + *
> + */
> +int snd_soc_usb_setup_offload_jack(struct snd_soc_component *component,
> +					struct snd_soc_jack *jack)
> +{
> +	int ret;
> +
> +	ret = snd_soc_card_jack_new(component->card, "USB Offload Playback Jack",
> +					SND_JACK_HEADPHONE, jack);
> +	if (ret < 0) {
> +		dev_err(component->card->dev, "Unable to add USB offload jack\n");
> +		return ret;
> +	}
> +
> +	ret = snd_soc_component_set_jack(component, jack, NULL);
> +	if (ret) {
> +		dev_warn(component->card->dev, "Failed to set jack: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_setup_offload_jack);
> +
>   static int snd_soc_usb_get_offload_card_status(struct snd_kcontrol *kcontrol,
>   				   struct snd_ctl_elem_value *ucontrol)
>   {
> 

I'm not sure if this should be handled in generic USB API, this feels 
like something that should be handled in specific device driver side, 
like all users currently do.

Anyway I think there should also be some function that tears jack down, 
by calling:
snd_soc_component_set_jack(component, NULL, NULL);
so it can get cleaned up properly?

