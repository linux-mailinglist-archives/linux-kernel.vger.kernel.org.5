Return-Path: <linux-kernel+bounces-27741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A60382F51D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F181F2178C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EE01D524;
	Tue, 16 Jan 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE4+36VA"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB251CF9A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432450; cv=none; b=kxuB+xBhMuRR9N2ObkjAUDK2mLXsRvKaAKhar9AdTvVkpNJiCCrNodXy9ZbpqRxyY2LLKfrhybHOLswEHH5zrqxd+V9+0zZpjpnouCEi+mxi07IbFryilco5zZPRVYgdQx4cAN7uNPbiw4X9+9ujTpko86YXq8cwgxm4U/bag1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432450; c=relaxed/simple;
	bh=Fbnz7FPBrcti991j/EwHKvXpDJlEoSZDaidwRrEcZDU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=PC0eUHjE0zCDlMj1LQkhYQ5J7m779xEzQkwf4P/nXY5iRiYt45+cwPscDX0C6Sx69jqkBxIQlJkrkiJQl/EJpZrDcwzgGAwKe6K2TpYf3nkoL0I4wsrlmixCFovoEkrsa8wNP64k71xy3k59h5kd8sjMQEWwgtJZ2w9OepQCiK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE4+36VA; arc=none smtp.client-ip=209.85.160.46
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2107f19e331so403424fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705432448; x=1706037248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MbLC8Ddbd9bzM5OMVafilprvsHCcgoHUHePNLUHpOwE=;
        b=HE4+36VAkOxcV79xf898M/pt6IhkEYjar0WRD4zcGnEPFcJq5/xNnqCURBfcQZwRou
         oRSPAvIW7pi5i6GMWwE5/TutlaBp1X6G6+miAohbZOn9O9FvnkhK+3lDa73MRYvBleQI
         QrJ/3UC/zo52sTeqVnrYgjaFKvEt/DOWKfP82TzDEHnKSAde+KeiQRTiW7eGBUbwzZDZ
         vflI26ekv5LjxEBWsWgJhEjqZ2Sm15/V8kgNibfsLeozxn5KxJMh9jgbXW5iCzO+72vT
         r/i7mcpgTpDAnelSSMBIDRFbeKbOwEqbzlsrGNDJiEBXNNYjzTOa7gAug4+5uzKJA8OO
         4mGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705432448; x=1706037248;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbLC8Ddbd9bzM5OMVafilprvsHCcgoHUHePNLUHpOwE=;
        b=Fu+B3mDSCqRogbt4VAY0iMpv+NJuMSLLyhyqqLWt188InBLg2BVYGzpyboiFEm0Pmk
         haxOAqzfLDTihkvqZLUSgI36UtF9LrtJ3c4lrvQsbRwGIudzoZ0GHMRO5z9H6WRPzG5o
         CMPwTwuYBBZy0uM4R7FVHo6M9KS3PXj8YKjus/Ek1AjflTLC6diYIKWI/wJA/hYqIPBD
         p00Bqm//3ZcgnueF74jMyhaZksi4+7kWxVC/rDdL7BikNDII5OzxyPluQ3n07bxOuZF8
         VI7Hayyt+N4K0qOADGslqZT/WKSSsEKirNu7++3O3OW8TX9VL2HL6ETBZhYEfYcMkWHL
         RykA==
X-Gm-Message-State: AOJu0YwhQONCYIZOeuV23tKxhE2jeqoQF/xgduChgyjr407P1tWdRfrG
	68BrJkQgm2sEYWr3daaWfJM=
X-Google-Smtp-Source: AGHT+IGlwbJPbao+HmUiFBxQTFVp5qK5cqfXMZUD7s0fPQ+zBJiI+nFyf6LVZO0bGwmc1akCLYLdyw==
X-Received: by 2002:a05:6871:3a11:b0:210:86d6:76ed with SMTP id pu17-20020a0568713a1100b0021086d676edmr583105oac.64.1705432447693;
        Tue, 16 Jan 2024 11:14:07 -0800 (PST)
Received: from [192.168.1.224] (067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id mm19-20020a0568700e9300b002053c704c33sm3156555oab.43.2024.01.16.11.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 11:14:06 -0800 (PST)
Message-ID: <54b5e83b-4b08-4c5e-afec-1c672561fa81@gmail.com>
Date: Tue, 16 Jan 2024 13:14:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
From: stuart hayes <stuart.w.hayes@gmail.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
 <ZZbhKM0L8pFYX_zd@kbusch-mbp>
 <19075505-b1a6-48d3-9732-7277c4697cf6@nvidia.com>
 <6af7ec28-2114-47da-a5a6-b0b6357169eb@gmail.com>
Content-Language: en-US
In-Reply-To: <6af7ec28-2114-47da-a5a6-b0b6357169eb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/12/2024 1:36 PM, stuart hayes wrote:
> 
>>
>>
>> On 04/01/2024 18:47, Keith Busch wrote:
>>> On Thu, Jan 04, 2024 at 10:38:26AM -0600, Stuart Hayes wrote:
>>>> Currently NVME namespaces are scanned serially, so it can take a long time
>>>> for all of a controller's namespaces to become available, especially with a
>>>> slower (fabrics) interface with large number (~1000) of namespaces.
>>>>
>>>> Use async function calls to make namespace scanning happen in parallel,
>>>> and add a (boolean) module parameter "async_ns_scan" to enable this.
>>>
>>> Hm, we're not doing a whole lot of blocking IO to bring up a namespace,
>>> so I'm a little surprised it makes a noticable difference. How much time
>>> improvement are you observing by parallelizing the scan? Is there a
>>> tipping point in Number of Namespaces where inline scanning is better
>>> than asynchronous? And if it is a meaningful gain, let's not introduce
>>> another module parameter to disable it.
>>
>> I don't think it is a good idea since some of the namespace characteristics must be validated during re-connection time for example.
>> I actually prepared a patch that makes sure we sync the ns scanning before kicking the ns blk queue to avoid that situations.
>> for example, if for some reason ns1 change its uuid then we must remove it and open a new bdev instead. We can't kick old request to it...
>>
> 
> 
> Sorry for the delayed response--I thought I could get exact data on how long it takes with and
> without the patch before I responded, it is taking a while (I'm having to rely on someone else
> to do the testing).  I'll respond with the data as soon as I get it--hopefully it won't be too
> much longer.  The time it takes to scan namespaces adds up when there are 1000 namespaces and
> you have a fabrics controller on a network that isn't too fast.
> 
> I don't expect there would be any reason to disable this.  I only put the module parameter to
> disable it in case there was some unforeseen issue, but I can remove that.
> 
> To Max Gurtovoy--this patch wouldn't change when or how namespaces are validated... it just
> puts the actual scan work function on a workqueue so the scans can happen in parallel.  It will
> do the same work to scan, at the same point, and it will wait for all the scanning to finish
> before proceeding.  I don't understand how this patch would make the situation you mention any
> worse.
> 

I have numbers for the namespace scan time improvement.  Below is the amount of time it took for
all of the namespaces to show up when connecting to a controller with 1002 namespaces:

network latency   time without patch    time with patch
   0                        6s                 1s
  50                      210s                10s
100                      417s                18s

I'll prepare a v2, removing the module parameter and including this data.

