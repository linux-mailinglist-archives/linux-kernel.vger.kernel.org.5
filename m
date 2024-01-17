Return-Path: <linux-kernel+bounces-29069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB88307D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0FF1F224F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13B21370;
	Wed, 17 Jan 2024 14:16:00 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E371621366
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500960; cv=none; b=lxBTgvWxhwyQvt1vQSw6NwJZMWpzKDuPS262WBc5BZLtuxbuc7/MRXcfCugBvQ9dZdY917VWj/AceQgo9PHcB1DZsk3Trm7jcVTVTQE2QdjdcLlL1Lc7IWLFd5WvaH3m/iiGgNFPqEoDTmOrTgtqlhGVuuPPQF8LpP7RMzDLE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500960; c=relaxed/simple;
	bh=EgbSsBpieApp3XdtsQbjo9VtVrmoPc5sPfMOhxwW6oE=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=Sx+34JKuj57AaJK80mMBX8FbL8rJeShqf0CesHaM3Fj4i7Fimkkk9zzEVGK7Z7VEbJ82sAxpwLD48149m21nUhsoLtBkHqlNF/3OuwyMxZfItiZNPazDUFDu0HHlUwhNOO2PgJbAHk78kr2MCmzzjhmtfamcE1gsH0wOu/YoDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33728f82a71so2370648f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705500957; x=1706105757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTjyhIfNKOIzZDL3R53ZyLUJvUHP8AzHTMPKLV0aqC4=;
        b=vzyOi+xRmP5T65Xj7/z73R/D8r0toIbAXT8G/nh5QM3NtihK3nKQtKhEy1UG4gNjHy
         WIbHB/O8BIcny2rk4ja3fitsgKjEaqmow7iuki3PidQ+TBc7W+P7E0T8SLenPxKw1VeS
         g0FT8gNDU9A19BZd9A5RpMeCl0E4qB76nTza6/+vCTJ7MaiyLb2GKSM7RH3lbAB691M/
         W6shMm16OkmdceJ2ICMI6Thygyc+vAOKrTDJX98QdGRl968GMtQtSwz6LxsZ0w/22KZB
         rS2KdmiGW5PkyN4udsg0OMu/l9TteIJcbMSt4Irjwcs780E7OF26roIzUWc3Oe6XMmLL
         h6Ow==
X-Gm-Message-State: AOJu0YwQ8q8Ht2PI8dOo7H+dlUj2m1CtJuVN53VpgpwVn/SMFABF0nF2
	cp0AoYe3amzCgvfYtf0SPfo=
X-Google-Smtp-Source: AGHT+IFTyonW2nbHuSG92zem4mwib1KSa7A1dkGySlJexu+qsj6eAEwjb/jRyK2olDDa/V2kPLBXgA==
X-Received: by 2002:a5d:522b:0:b0:337:b74b:76ee with SMTP id i11-20020a5d522b000000b00337b74b76eemr3135624wra.7.1705500956952;
        Wed, 17 Jan 2024 06:15:56 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id cp32-20020a056000402000b00337c55d9a28sm836720wrb.93.2024.01.17.06.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 06:15:56 -0800 (PST)
Message-ID: <3c4d77e9-922f-4cb4-b3d8-1c2c49fdcf4c@grimberg.me>
Date: Wed, 17 Jan 2024 16:15:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
Content-Language: en-US
To: stuart hayes <stuart.w.hayes@gmail.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
 <ZZbhKM0L8pFYX_zd@kbusch-mbp>
 <19075505-b1a6-48d3-9732-7277c4697cf6@nvidia.com>
 <6af7ec28-2114-47da-a5a6-b0b6357169eb@gmail.com>
 <54b5e83b-4b08-4c5e-afec-1c672561fa81@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <54b5e83b-4b08-4c5e-afec-1c672561fa81@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/16/24 21:14, stuart hayes wrote:
> 
> 
> On 1/12/2024 1:36 PM, stuart hayes wrote:
>>
>>>
>>>
>>> On 04/01/2024 18:47, Keith Busch wrote:
>>>> On Thu, Jan 04, 2024 at 10:38:26AM -0600, Stuart Hayes wrote:
>>>>> Currently NVME namespaces are scanned serially, so it can take a 
>>>>> long time
>>>>> for all of a controller's namespaces to become available, 
>>>>> especially with a
>>>>> slower (fabrics) interface with large number (~1000) of namespaces.
>>>>>
>>>>> Use async function calls to make namespace scanning happen in 
>>>>> parallel,
>>>>> and add a (boolean) module parameter "async_ns_scan" to enable this.
>>>>
>>>> Hm, we're not doing a whole lot of blocking IO to bring up a namespace,
>>>> so I'm a little surprised it makes a noticable difference. How much 
>>>> time
>>>> improvement are you observing by parallelizing the scan? Is there a
>>>> tipping point in Number of Namespaces where inline scanning is better
>>>> than asynchronous? And if it is a meaningful gain, let's not introduce
>>>> another module parameter to disable it.
>>>
>>> I don't think it is a good idea since some of the namespace 
>>> characteristics must be validated during re-connection time for example.
>>> I actually prepared a patch that makes sure we sync the ns scanning 
>>> before kicking the ns blk queue to avoid that situations.
>>> for example, if for some reason ns1 change its uuid then we must 
>>> remove it and open a new bdev instead. We can't kick old request to 
>>> it...
>>>
>>
>>
>> Sorry for the delayed response--I thought I could get exact data on 
>> how long it takes with and
>> without the patch before I responded, it is taking a while (I'm having 
>> to rely on someone else
>> to do the testing).  I'll respond with the data as soon as I get 
>> it--hopefully it won't be too
>> much longer.  The time it takes to scan namespaces adds up when there 
>> are 1000 namespaces and
>> you have a fabrics controller on a network that isn't too fast.
>>
>> I don't expect there would be any reason to disable this.  I only put 
>> the module parameter to
>> disable it in case there was some unforeseen issue, but I can remove 
>> that.
>>
>> To Max Gurtovoy--this patch wouldn't change when or how namespaces are 
>> validated... it just
>> puts the actual scan work function on a workqueue so the scans can 
>> happen in parallel.  It will
>> do the same work to scan, at the same point, and it will wait for all 
>> the scanning to finish
>> before proceeding.  I don't understand how this patch would make the 
>> situation you mention any
>> worse.
>>
> 
> I have numbers for the namespace scan time improvement.  Below is the 
> amount of time it took for
> all of the namespaces to show up when connecting to a controller with 
> 1002 namespaces:
> 
> network latency   time without patch    time with patch
>    0                        6s                 1s
>   50                      210s                10s
> 100                      417s                18s


That is a big improvement. I wouldn't say that 1000+ namespaces
is a common requirement. But the improvement speaks for itself.

