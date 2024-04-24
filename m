Return-Path: <linux-kernel+bounces-156563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A89928B049B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEBA2B23EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC3E15886D;
	Wed, 24 Apr 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CFafo2Xe"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647C156C7D;
	Wed, 24 Apr 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948137; cv=none; b=jr4FzZLWgThnw1ZTCnjQkPgNBgGu8LVEhCmr02LXJH2ArqFMoN6EceWdyjjPHyWbM8WsgZBfHFQIP2sI2dw5B+CeQFUDYRZm0oQJqKbogyBOEnRDr7teE5zvISVzKXKjl9tyV/TzdqDEGu4BlkIPPfhplgzicHKUxh+b2NuTMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948137; c=relaxed/simple;
	bh=5SydQyN/5lWa8I8pFYYcZKMUixYgURPFJ+gffcKbuKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGdFZHJ5m3a1PzSI0ITEdgT+316hmnW41phtPMFM3+WAPLBvZqjAXKKGuBmDrtV2zlT94SlW/5GCmOS4xG7+z+R0gURcNXzgVHN8Z2Nc7RBXbJy7bNqQsO3TALcF3Zh9lOjFAxSerE2f4Iyfz5bPY510MHNs9AE5abwvfGYblfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CFafo2Xe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713948133;
	bh=5SydQyN/5lWa8I8pFYYcZKMUixYgURPFJ+gffcKbuKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CFafo2XeZwh36dwmwc6mZsXswmvDqENIuTqdFxBIadjxjWz1sg+xqvxUCmw174zc5
	 mPQDGhV4QOl2fNxMQGY6rhqxoGeS5zb66/H73rGlWhm78kTLwUtnRGvPatWs7/vVV4
	 Q3NIW21+7/42vLA2grf5T3rEGrfWc+ZOOp06VUOIm+l7VzYrtmUKCVx4BIh/rnfYYV
	 0iO25WJ8xI3zucQnPBGuJl5DU+JhTYLSJbbVysY9tSK6/s9/BIm4tP+NS+u83srcE2
	 rqZw4iQSOY+K2RfAn/Scj88VH8/yb3pGpce7+6kZMXnPcT3schLiKsemOcT6PnAVk4
	 0yvahe9T2JSyQ==
Received: from [100.74.67.65] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D66473781FE9;
	Wed, 24 Apr 2024 08:42:12 +0000 (UTC)
Message-ID: <9075808c-783b-4af6-a92f-2a6d3f25d225@collabora.com>
Date: Wed, 24 Apr 2024 10:42:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] media: i2c: add MAX96714 driver
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org, mchehab@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
References: <20240325131634.165361-1-julien.massot@collabora.com>
 <20240325131634.165361-5-julien.massot@collabora.com>
 <ZhkaR-83uciNFi2b@valkosipuli.retiisi.eu>
 <a70e3792-b938-4c20-840d-5dfa9bdc4b9c@collabora.com>
 <ZijDHtSa2vACgBjl@valkosipuli.retiisi.eu>
Content-Language: en-US
From: Julien Massot <julien.massot@collabora.com>
In-Reply-To: <ZijDHtSa2vACgBjl@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 4/24/24 10:30, Sakari Ailus wrote:
> Hi Julien,
> 
> On Tue, Apr 23, 2024 at 04:01:16PM +0200, Julien Massot wrote:
> 
> ...
> 
>>>> +static int max96714_enable_streams(struct v4l2_subdev *sd,
>>>> +				   struct v4l2_subdev_state *state,
>>>> +				   u32 source_pad, u64 streams_mask)
>>>> +{
>>>> +	struct max96714_priv *priv = sd_to_max96714(sd);
>>>> +	u64 sink_streams;
>>>> +	int ret;
>>>> +
>>>> +	if (!priv->enabled_source_streams)
>>>> +		max96714_enable_tx_port(priv);
>>>> +
>>>> +	ret = max96714_apply_patgen(priv, state);
>>>> +	if (ret)
>>>> +		goto err;
>>>> +
>>>> +	if (!priv->pattern) {
>>>> +		if (!priv->rxport.source.sd) {
>>>> +			ret = -ENODEV;
>>>> +			goto err;
>>>> +		}
On enable streams the check is here :)
Streaming is not possible without a remote serializer when pattern 
generator is disabled.

I may refactor this code later when we will have the internal pad, to 
declare
properly this stream.
.

>>>> +
>>>> +		sink_streams =
>>>> +			v4l2_subdev_state_xlate_streams(state,
>>>> +							MAX96714_PAD_SOURCE,
>>>> +							MAX96714_PAD_SINK,
>>>> +							&streams_mask);
>>>> +
>>>> +		ret = v4l2_subdev_enable_streams(priv->rxport.source.sd,
>>>> +						 priv->rxport.source.pad,
>>>> +						 sink_streams);
>>>> +		if (ret)
>>>> +			goto err;
>>>> +	}
>>>> +
>>>> +	priv->enabled_source_streams |= streams_mask;
>>>> +
>>>> +	return 0;
>>>> +
>>>> +err:
>>>> +	if (!priv->enabled_source_streams)
>>>> +		max96714_disable_tx_port(priv);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int max96714_disable_streams(struct v4l2_subdev *sd,
>>>> +				    struct v4l2_subdev_state *state,
>>>> +				    u32 source_pad, u64 streams_mask)
>>>> +{
>>>> +	struct max96714_priv *priv = sd_to_max96714(sd);
>>>> +	u64 sink_streams;
>>>> +	int ret;
>>>> +
>>>> +	if (!priv->pattern && priv->rxport.source.sd) {
>>>
>>> When will priv->rxport.source.sd be NULL here?
>>
>> Indeed it should not, the priv->rxport.source.sd can only be null if:
>> - There is no serializer
>> - The stream has been started with pattern generator and the pattern
>> generator
>> has been disabled while streaming.
> 
> It seems priv->rxport.source.sd is also accessed in
> max96714_enable_streams() without such a check.
Please see my reply above :)

> 
>>
>> In V7 I will drop this check and add another one to prevent disabling the
>> pattern
>> generator while streaming.
> 
> Sounds good.
> 
>>>> +static void max96714_v4l2_notifier_unregister(struct max96714_priv *priv)
>>>> +{
>>>> +	v4l2_async_nf_unregister(&priv->notifier);
>>>> +	v4l2_async_nf_cleanup(&priv->notifier);
>>>
>>> It'd be nicer to call these directly IMO. Maybe we could introduce
>>> v4l2_async_nf_unregister_cleanup()? Feel free to post a patch. :-)
>> Ok, I will call these directly, and I will do the same for the MAX96717
>> serializer.
>>
>> I will post a patchset later introducing the
>> `v4l2_async_nf_unregister_cleanup`
>> and converting all the drivers calling these two functions.
> 
> That would be nice. :-) It should be easy to do that with Coccinelle.
> 
> ...
> 
>>>> +	ret = max96714_enable_core_hw(priv);
>>>
>>> Please switch to runtime PM.
>>
>> Ok, the v7 will use runtime PM and I will use the powerdown gpio
>> to poweroff the device. However it implies to move some functions arround
>> e.g initialize the tx or the pattern generator ..
>> So it it will be done as separate patches.
>>
>> Playing with the pm_runtime operation also showed up that the connection
>> doesn't always resume properly, I will extra patches to fix that.
> 
> Ack.
> 

-- 
Julien Massot
Senior Software Engineer
Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

