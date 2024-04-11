Return-Path: <linux-kernel+bounces-139775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852318A078D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE831F24C55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D345C13C8E6;
	Thu, 11 Apr 2024 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkC/P1S8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC613C838;
	Thu, 11 Apr 2024 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812744; cv=none; b=GBE9jNqdSA95NWJywCZsJmK4e3kNWI1ooYH6ZGy/8mBoJRE3tG3nx1KI/3UGySQfo2ANMBhNcVIip4sAwMHgnvjfnOULeTXOohqI3N0q6mNa4xMEnAS7sBoenipi5qA7vQx4rpkk/YMSUrJyJeWQIJSMFOkIxk7rswhyEOBjN8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812744; c=relaxed/simple;
	bh=XgFUk20c57p70PXg9xZ1MkCgiZA4e9NkJIiIFaVCIWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msg312gdaiOoGPgnpupLAZBVPut+6AlasUop1pC2L2FlptVkbshYlTxy9S+3mYbyGn5nNTVJRyv2qDrn27L5pgpygGYRot32EHQmB5UVUnqiDIdplVtjMDPThYEyxoX/QP48oF0W5Z7yVyHfx2ocucRWCo4Qn9VXjjR8mDK2hkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkC/P1S8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BCCC433C7;
	Thu, 11 Apr 2024 05:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712812743;
	bh=XgFUk20c57p70PXg9xZ1MkCgiZA4e9NkJIiIFaVCIWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EkC/P1S8ZLFmo/55ZH+2juxzh/cOeAJu6NiJ9nZ+sdOxBtcGPd3gaKhQLIWqmX7Jq
	 DzNKWvBaC/aQORzZPQLfhl5PkomYFyn6jkV1zgRut5qJNjyNpZYiH8GZ+ssmoeLw1l
	 mC+RZwRxWT+6EtvRY1e/Yzsvu9fO8rDrvcGkL/G82PZm2Lg0IKZUarM70yzGbOfkm9
	 YJQZFProYuohwqrJIq8/b+TnHY1bS1OTwvRNLZcKaUTuJE9W/Nu27L2UC70qadZ/fM
	 gUYyMLLnPBP3lswkTcFKA24y9zf3MtVvyh7U/j1pSzcEnAq/ccSxh8NIgKNWva+9Sj
	 EeCVh9OtbFVWQ==
Message-ID: <5a83c1f7-3ab8-486a-b633-33b44858d290@kernel.org>
Date: Thu, 11 Apr 2024 14:19:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add max_dispatch to sysfs
To: Jens Axboe <axboe@kernel.dk>, Dongliang Cui <dongliang.cui@unisoc.com>
Cc: ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cuidongliang390@gmail.com
References: <20240410101858.1149134-1-dongliang.cui@unisoc.com>
 <5a67c4f7-4794-45b4-838c-7b739372d3a5@kernel.dk>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <5a67c4f7-4794-45b4-838c-7b739372d3a5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 22:17, Jens Axboe wrote:
> On 4/10/24 4:18 AM, Dongliang Cui wrote:
>> The default configuration in the current code is that when the device
>> is not busy, a single dispatch will attempt to pull 'nr_requests'
>> requests out of the schedule queue.
>>
>> I tried to track the dispatch process:
>>
>> COMM            TYPE    SEC_START       IOPRIO       INDEX
>> fio-17304       R	196798040	0x2005	     0
>> fio-17306       R	197060504	0x2005	     1
>> fio-17307       R	197346904	0x2005	     2
>> fio-17308       R	197609400	0x2005	     3
>> fio-17309       R	197873048	0x2005	     4
>> fio-17310       R	198134936	0x2005	     5
>> ...
>> fio-17237       R	197122936	  0x0	    57
>> fio-17238       R	197384984	  0x0	    58
>> <...>-17239     R	197647128	  0x0	    59
>> fio-17240       R	197909208	  0x0	    60
>> fio-17241       R	198171320	  0x0	    61
>> fio-17242       R	198433432	  0x0	    62
>> fio-17300       R	195744088	0x2005	     0
>> fio-17301       R	196008504	0x2005	     0
>>
>> The above data is calculated based on the block event trace, with each
>> column containing: process name, request type, sector start address,
>> IO priority.
>>
>> The INDEX represents the order in which the requests are extracted from
>> the scheduler queue during a single dispatch process.
>>
>> Some low-speed devices cannot process these requests at once, and they will
>> be requeued to hctx->dispatch and wait for the next issuance.
>>
>> There will be a problem here, when the IO priority is enabled, if you try
>> to dispatch "nr_request" requests at once, the IO priority will be ignored
>> from the scheduler queue and all requests will be extracted.
>>
>> In this scenario, if a high priority request is inserted into the scheduler
>> queue, it needs to wait for the low priority request in the hctx->dispatch
>> to be processed first.
>>
>> --------------------dispatch 1st----------------------
>> fio-17241       R       198171320         0x0       61
>> fio-17242       R       198433432         0x0       62
>> --------------------dispatch 2nd----------------------
>> fio-17300       R       195744088       0x2005       0
>>
>> In certain scenarios, we hope that requests can be processed in order of io
>> priority as much as possible.
>>
>> Maybe max_dispatch should not be a fixed value, but can be adjusted
>> according to device conditions.
>>
>> So we give a interface to control the maximum value of single dispatch
>> so that users can configure it according to devices characteristics.
> 
> I agree that pulling 'nr_requests' out of the scheduler will kind of
> defeat the purpose of the scheduler to some extent. But rather than add
> another knob that nobody knows about or ever will touch (and extra queue
> variables that just take up space), why not just default to something a
> bit saner? Eg we could default to 1/8 or 1/4 of the scheduler depth
> instead.

Why not default to pulling what can actually be executed, that is, up to the
number of free hw tags / budget ? Anything more than that will be requeued anyway.

-- 
Damien Le Moal
Western Digital Research


