Return-Path: <linux-kernel+bounces-155183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C418AE66A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35A01C21FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A1712EBE5;
	Tue, 23 Apr 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVXlHu9C"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2590F85631
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875902; cv=none; b=oTSQdLMTELh0M0cwTIqmOTvL8LIGYfh7x+CDoHIZy2BKH9Spcnil8NEbFtP71qWHsJBkGChMJH9HQN9MwLB7MUy+M/KHMHaS/MaKC/RrZvXeWFdWO2lgQnn4RVVdna5A7K54QrGsWYruz/pWt9qXCXaSRJNLbuWUT4nk7ZpiDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875902; c=relaxed/simple;
	bh=J/tw8yRBYo/0EgSy+tQkCdevIsk8fSb0kvRYZM3GDFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLeHKXeHemwjw/HWH4P9m+Aov0sqAz3xwuosWwhOdWe/BoMJKFpYE37BCfqLku30jWBdmM0JrG4qhH+CigxwgXCLcoYtZ1zu/g1s/zZG43hyydH3tOB1aqjA4QHjLOKlvFQbDD33vCBTVYdqv03KqES4MQXGIvuzHYUQNbgt7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VVXlHu9C; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso452915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713875899; x=1714480699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIW/4kaIcgQ3dsiNOn7qNP3zsB635HzMYPtbd1p9/VE=;
        b=VVXlHu9CXZqoztQocy6u8DU5OvlCWLqmddqPlIx+wpHX0wTpPj8TCfe1ERm+EZTO+o
         utS5D1h7KdnNUnrUnr7rpmKNGKsZWxUHpy0SIFDfQMahqUEyNi5+lGKdB2dAmHzDH/0q
         AvZJFyQobDhudPsyBZ/W09TGyWFa8J33WLZ5EcH8P5Zfnd1IfjsegCdp43iNT2WXhwAn
         G8y+aXANy1u3/xF/iYtdCZTv+IqYMjVdw4JkaClOSoswtPA5/S/aAiTWf2lrBE+w4vdt
         Fpjpq8jO9IFXs5PFQ58PXuP7T+Gzi3fLjci1+n9M889k7pysCdhzVYOei//ClqVAAJ07
         /n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713875899; x=1714480699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIW/4kaIcgQ3dsiNOn7qNP3zsB635HzMYPtbd1p9/VE=;
        b=Ziyn1GcNzL97gaShsbd8Ba4SNdgl3eq9tskTLUnbcJvQPa3TfeDJfhA+Frp9VdqgZQ
         GSIYxZOJ28MeATyjaLjxEIgulfRa7U73gAOcND3TSY4GGsFEljJSEoecb6cLkvZWLvMH
         Mm/N4Wrr7Q3rRBqnqJpAWLYP+ldsnSjo3TG3p06z8tvBFmJKfU4X4MOY11aCqIYsQhqp
         sOXRele9VYIMAfWAJrTPi25yxE6XFZJ0vy4zziCSVOm17euiv3z43A1d2cESqL85/rRd
         mSnrlPCKCZ3Lzej8C9kmlEqqWgDNQx03DcTN3sxBmU2iVPWxLUQ77aJXBd/k/7g4B9eU
         dGJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCd+jcoeuEuf+i9b0ymdccn9XMbf3hQBiyLO3CVnvuG/UuosephCCG6fhh9q/aN6doG1z4TUscZPDaVv35BnQrYhrm1Wgm0yMg2o6c
X-Gm-Message-State: AOJu0Ywqv3d/C2sOHq0vFyF4MfDHR3yERhWtzRp3UBR+FlFKTUoDYU3E
	3YqUkRqhUbqWTQXih6UaguKfEjrrHW2qhx6k3mOSYpkydhczpIxrHlUvKy2IOrM=
X-Google-Smtp-Source: AGHT+IHZPOUNNlHUfJ4UIDp40yrSx/o6yztNYiaRDe88l58PFdLYTv00xpM4C5Wj4nVQ3nuIAT5XVw==
X-Received: by 2002:a05:600c:3b9c:b0:418:7ec1:7bdb with SMTP id n28-20020a05600c3b9c00b004187ec17bdbmr1874101wms.5.1713875899466;
        Tue, 23 Apr 2024 05:38:19 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id s7-20020a05600c45c700b0041aa570bcd3sm3029800wmo.35.2024.04.23.05.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:38:18 -0700 (PDT)
Message-ID: <92b02fd3-5eba-42a7-a166-21b14724b10c@linaro.org>
Date: Tue, 23 Apr 2024 13:38:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ASoC: qcom: display port changes
To: Johan Hovold <johan@kernel.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <ZieihZRKe7OtP-nV@hovoldconsulting.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ZieihZRKe7OtP-nV@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/04/2024 12:59, Johan Hovold wrote:
> On Mon, Apr 22, 2024 at 02:43:50PM +0100, Srinivas Kandagatla wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patchset adds support for.
>> 	1. parse Display Port module tokens from ASoC topology
>> 	2. add support to DP/HDMI Jack events.
>> 	3. fixes a typo in function name in sm8250
>>
>> Verified these patches on X13s along with changes to tplg in
>> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
>> and ucm changes from https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp
> 
> It looks like your UCM changes are still muxing the speaker and *each*
> displayport output so that you can only use one device at a time (i.e.
> only Speaker or DP1 or DP2 can be used).
that is true.

What is the use-case to use more than one audio sink devices at the same 
time for a laptops?

How do you test it? I never tested anything like that on a full desktop 
setup.

May be some manual setup in Wireplumber, but not 100% sure about 
multiple stream handling.

> 
> As we discussed off list last week, this seems unnecessarily limited and
> as far as I understood is mostly needed to work around some
> implementation details (not sure why DP1 and DP2 can't be used in
> parallel either).

It is absolutely possible to run all the streams in parallel from the 
Audio hardware and DSP point of view.

One thing to note is, On Qualcomm DP IP, we can not read/write registers 
if the DP port is not connected, which means that we can not send data 
in such cases.

This makes it challenging to work with sound-servers like pipewire or 
pulseaudio as they tend to send silence data at very early stages in the 
full system boot up, ignoring state of the Jack events.

> 
> Can you please describe the problem here so that we can discuss this
> before merging an unnecessarily restricted solution which may later be
> harder to change (e.g. as kernel, topology and ucm may again need to be
> updated in lock step).
> 
>  From what I could tell after a quick look, this series does not
> necessarily depend on muxing things this way, but please confirm that
> too.

These patches have nothing to do with how we model the muxing in UCM or 
in tplg.

so these can go as it is irrespective of how we want to model the DP 
sinks in the UCM or tplg.


--srini
> 
> Johan

