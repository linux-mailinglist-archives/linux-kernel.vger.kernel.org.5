Return-Path: <linux-kernel+bounces-161407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEBE8B4B9D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440301F21528
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DECE6A347;
	Sun, 28 Apr 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="Mq+7lI9N"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46D5B693
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714305984; cv=none; b=NaRpAiGGfgAwSPHe4gYsw6dimnYARVCpe/p9ETOWN+Duxepg0OWL4a1L6NfnRFf4XwK26qS7ySpoBjgu8rGURH82w8cRDQHXU4b+dy036XApqwSQyE75c0Rxq5RGzL8cQVmmmQWHu0d7idxDIWemuCE6dD2B2I0ijFzQA7ANIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714305984; c=relaxed/simple;
	bh=+XZR/H2IEv9IjwDx4Fi2n5kzKDZposEiTAx2GYa/PE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPpIB1tVdTERO3fmvp8ha+N8WNuQWwzhl5tHJym68OgX692SFZLyusCMrvHJuX0z0qIyaoTE4eMCYfwAtz+JhztPEIuWy6kK1xIpSC8xd2b3OWktVEOxVEDNgIr9D1cevc1eNEXtCB13qFkUVdNjfhub9yxPILcvPVfejifqKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=Mq+7lI9N; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f3f6aa1437so521876b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1714305982; x=1714910782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7Puehy8P6JLTcZ0cSqMx2ZhFLTSzcAEUxqgkAcEo9g=;
        b=Mq+7lI9NphoSH9oGGScW5Tmo6oLgCGb+fTruEGdFuIpjQBNsEIqFapwEtkHeosVAw0
         BmZqOUGvCFe47VZ0cJASPYwIokpxACrbV0XVARTlIT2d36cTkyW9uZs4ZrUL9weUq3/y
         J6BLAFJVtQlTTjueVRu2OaJTw3jWiVRtSEKeC/ckN2+quplXN37aXQV6zmHdpXyIUHqn
         HwsL16uaVLRmm7XzTX0lxYoKgsejLua8Tx6nRsMzJbmxnp6VVizyDM8HaIgUhtFZIJzo
         NE7fCCJXwawcn7WpJz3ldu70AXQUWG2jCtDYMq5Mv33havivuWl41KNH9krL5V1sXWTc
         soMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714305982; x=1714910782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7Puehy8P6JLTcZ0cSqMx2ZhFLTSzcAEUxqgkAcEo9g=;
        b=v1L2hiDvgOQlqACqfBJPcFn4StNpb+37aN6O+AjEKwdBUpH3Zo4QcMY4xUUff7tuCK
         fFjdquyW18YeZ6jol8Nzyi07cKstXq2gakX0d6BiknqNVDHFZJthczxCjLqN7XrGvy4X
         0Xc5s/DBIFPQOLH4YUprRYINwOO+lAys1EhvPOnfY+zP0rNMNbv7moS2M+X8cNdPnXz1
         rbNRR6oS/mlkXGOwlXbJy46cVPH7Rp+wqEShJvP8OXilm9j+73SBHSAxZWip9AUCBQFo
         290CLlfeIQ+zuTULOCPXAEr62G0+wCbumjP44oKxcjEZ4et1XcQ1kr0+dpjnX/btfFKr
         Ekdw==
X-Forwarded-Encrypted: i=1; AJvYcCX5mRzuDySmExXLGqvxXOwURyaKAtWOQxNAcbpw0C9qKVVg0Ei7xocWiwNIntJirAPlIVT2S/69KPIuSFyLBOo7Npx2F+UCe1aWsz31
X-Gm-Message-State: AOJu0YzYfimeEmPETyZHlvOIkYKyddjrZJfkssvywenRUTCmYKvJJYiz
	13Sx/vYoad8nHi+lC8tGi/RqDQBNlQuEiDWTIaauP8ViX/rQGbr0fi+//s4q7Gk=
X-Google-Smtp-Source: AGHT+IGdfh6v+jBIQuSGQH2LjYfZ5KzStpJnTg/6mCYFQ1QXySzsWc3Tsnzee/ZH2ef7Owa+RlFdzA==
X-Received: by 2002:a05:6a00:2da9:b0:6ed:d5f5:869 with SMTP id fb41-20020a056a002da900b006edd5f50869mr9779472pfb.3.1714305982237;
        Sun, 28 Apr 2024 05:06:22 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:885d:4711:59d4:b6a2? (2403-580d-82f4-0-885d-4711-59d4-b6a2.ip6.aussiebb.net. [2403:580d:82f4:0:885d:4711:59d4:b6a2])
        by smtp.gmail.com with ESMTPSA id m19-20020aa78a13000000b006e697bd5285sm17496178pfa.203.2024.04.28.05.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 05:06:21 -0700 (PDT)
Message-ID: <6d401f1b-bc3f-4064-adc1-a22d9a65c778@tweaklogic.com>
Date: Sun, 28 Apr 2024 21:36:17 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: apds9306: Fix input arguments to in_range()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240427090914.37274-1-subhajit.ghosh@tweaklogic.com>
 <20240428124745.2cb0e2a2@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240428124745.2cb0e2a2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/4/24 21:17, Jonathan Cameron wrote:
> On Sat, 27 Apr 2024 18:39:14 +0930
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
>> Third input argument to in_range() function requires the number of
>> values in range, not the last value in that range. Update macro for
>> persistence and adaptive threshold to reflect number of values
>> supported instead of the maximum values supported.
>>
>> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
>> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> Applied to the togreg branch of iio.git. Pushed out initially as testing
> for 0-day to take a first look.
> 
> Thanks,
> 
> Jonathan
> 
Thank you Jonathan.

Regards,
Subhajit Ghosh


