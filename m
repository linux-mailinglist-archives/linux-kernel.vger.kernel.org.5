Return-Path: <linux-kernel+bounces-25003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ED282C5F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A4C286F02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0101642A;
	Fri, 12 Jan 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWmKU2lC"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CA16419
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-20451ecbb80so3448454fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705088214; x=1705693014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4Kvga+gCCknNcaIDhI5P0YQnHCrcQUlvVgE/vEI7AQ=;
        b=XWmKU2lCe+jzMjE4DCTP7ihlEEac2Xj5mT+WmlnmYWB/bYmY4CiJrAwPJL2jUV9sQL
         yqDkTKz0o5yljZJiLOJlZM1AjKhdmUiagCkX+I7DQ2riNX5h6kzxfdbbcJYRvEZ67Q02
         LLybHy+TeQZKirYOKFf4U/jD0X0ACO0cTKuAgVhG8cWsI2xYh5OlgHzfs3SDPY0lfASq
         /raabDTn4t8IvoKTd7byL6/S54z8S155QA2PS4Mb+N3h5EmcmzjkOo9nEVNK6CW2mMb3
         Mr++Qun4TGyufqELHzcVCi917lRGtC8mbR9QJv6FLKluWq8VBmnGEmQVVjMI5yHWZp1O
         J4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705088214; x=1705693014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4Kvga+gCCknNcaIDhI5P0YQnHCrcQUlvVgE/vEI7AQ=;
        b=F7mMfavAAs/eSbH2KpdYMWAz6x0QTmIIsURt3YYEt35UYKutbiaKlH1yuttIVdOebD
         qNjYbLLAEokmJvD63O024Bly8gaCd7KRCLoTbdz/VxPb/XJuAd1P89Y82BmtmmaguFJK
         ShOe3uG62rruXnXFMG1IEVIHJJeTXc0jfJgdJBGj8ACmtMk21cRUGTKahAARnGkkN+ki
         vJItx3WEHQAw2cEXdwhau24UPunDKi4dnl3+0PtUf3n72nHFdp8P+RVvDbb1UI3TJrHP
         C2UUkyhV5znjF1w8M4F4sp4L5LTIuRz5GjiIB1mEb/t5ss8Eh4HRqricVIutxrKzQCPs
         MRpA==
X-Gm-Message-State: AOJu0YxdRrrj9lpWx2GtO9o3/0xHMZg8C8i9DJ10nWsVLHaOYmX9k0U0
	VkafFvRBH2gzomCApA0k4CA=
X-Google-Smtp-Source: AGHT+IEs16qGmAqhDHcPe664G8j2FDJbJZqAJRciT5h1idWKdvOb1zElvzcttSUTDiZq3Wfx1Pz3Dw==
X-Received: by 2002:a05:6870:9f03:b0:1fb:75b:99c5 with SMTP id xl3-20020a0568709f0300b001fb075b99c5mr1870013oab.116.1705088213832;
        Fri, 12 Jan 2024 11:36:53 -0800 (PST)
Received: from [192.168.1.224] (067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id qr1-20020a056870ef8100b0020650e8e782sm948786oab.57.2024.01.12.11.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 11:36:53 -0800 (PST)
Message-ID: <6af7ec28-2114-47da-a5a6-b0b6357169eb@gmail.com>
Date: Fri, 12 Jan 2024 13:36:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
 <ZZbhKM0L8pFYX_zd@kbusch-mbp>
 <19075505-b1a6-48d3-9732-7277c4697cf6@nvidia.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <19075505-b1a6-48d3-9732-7277c4697cf6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> 
> 
> On 04/01/2024 18:47, Keith Busch wrote:
>> On Thu, Jan 04, 2024 at 10:38:26AM -0600, Stuart Hayes wrote:
>>> Currently NVME namespaces are scanned serially, so it can take a long time
>>> for all of a controller's namespaces to become available, especially with a
>>> slower (fabrics) interface with large number (~1000) of namespaces.
>>>
>>> Use async function calls to make namespace scanning happen in parallel,
>>> and add a (boolean) module parameter "async_ns_scan" to enable this.
>>
>> Hm, we're not doing a whole lot of blocking IO to bring up a namespace,
>> so I'm a little surprised it makes a noticable difference. How much time
>> improvement are you observing by parallelizing the scan? Is there a
>> tipping point in Number of Namespaces where inline scanning is better
>> than asynchronous? And if it is a meaningful gain, let's not introduce
>> another module parameter to disable it.
> 
> I don't think it is a good idea since some of the namespace characteristics must be validated during re-connection time for example.
> I actually prepared a patch that makes sure we sync the ns scanning before kicking the ns blk queue to avoid that situations.
> for example, if for some reason ns1 change its uuid then we must remove it and open a new bdev instead. We can't kick old request to it...
> 


Sorry for the delayed response--I thought I could get exact data on how long it takes with and
without the patch before I responded, it is taking a while (I'm having to rely on someone else
to do the testing).  I'll respond with the data as soon as I get it--hopefully it won't be too
much longer.  The time it takes to scan namespaces adds up when there are 1000 namespaces and
you have a fabrics controller on a network that isn't too fast.

I don't expect there would be any reason to disable this.  I only put the module parameter to
disable it in case there was some unforeseen issue, but I can remove that.

To Max Gurtovoy--this patch wouldn't change when or how namespaces are validated... it just
puts the actual scan work function on a workqueue so the scans can happen in parallel.  It will
do the same work to scan, at the same point, and it will wait for all the scanning to finish
before proceeding.  I don't understand how this patch would make the situation you mention any
worse.


