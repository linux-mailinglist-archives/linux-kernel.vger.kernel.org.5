Return-Path: <linux-kernel+bounces-142176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0C8A287A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD671F21FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58404D9F4;
	Fri, 12 Apr 2024 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4/0dwmO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7B4BAA6;
	Fri, 12 Apr 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908122; cv=none; b=quEzk9xIU/3BwdvKX40nQmEB9RPUc3j9lftD3oYuM0dVmPxZZjN/H8TNAAqo6CrKIpjhL+XD9KJ3ioWto1JYIQWsW2isIlePwrCzhzv63uzvG0LrtFddzhBvgpzHpEjRFLVRaT9voNUVh2mH7QbWMqiv2NnfR7KH+uKHSnR8Jys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908122; c=relaxed/simple;
	bh=CF9oWDzCYOqtphIi9RHhUlEJ0YZEjnZhZllTYc5lRe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6kK4c2kX7IWlJ6VappmB83rxujj+GB/i6q1luR4AQxfLtzmCRBHWWawZH8wt28l4IwJrJnW26/IfmwLq5cJj89EyT1r538gd2YfinJo8vmmymW+xscsSW0NqKeIkDWpdZi/GAYMB1DWMP0jrkZDp/2SjlPW/ev+O3f9xqFvW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4/0dwmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4B7C113CC;
	Fri, 12 Apr 2024 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712908121;
	bh=CF9oWDzCYOqtphIi9RHhUlEJ0YZEjnZhZllTYc5lRe8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W4/0dwmOm139lOpxDlRRyrAMKb1EVMISM8nVCYpv9ZCM7rr+OGDUSwNXBgzQmOlKY
	 eHp+HIOHZZjfBmtNfor1hRINuJFovViPaDycq+QqZieC4NW0VYh7wifdqXYImizUo0
	 KKo+dI5PmfrwY1CBCFIZ1hrXaZd2GSjESFdPqJAbqWBtsE6P0D5XP/HfZlZ/VMwlem
	 hejpYM+606MEjwA1U89ZTrcCDGswR9qvvo31LpHzHSSqs20gNy92mmnQvkX+Bn2m8U
	 rh6086/C+f4aLJSSDZR87W58RP+fcTNq9v7mc4ZqGSSn62y4068WGSgfpigPrKM2uU
	 FPZJX2NysVIaQ==
Message-ID: <9b7df4f5-3a3c-40ff-b5c2-adeed2dcf780@kernel.org>
Date: Fri, 12 Apr 2024 16:48:38 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add max_dispatch to sysfs
To: dongliang cui <cuidongliang390@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Dongliang Cui <dongliang.cui@unisoc.com>,
 ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410101858.1149134-1-dongliang.cui@unisoc.com>
 <5a67c4f7-4794-45b4-838c-7b739372d3a5@kernel.dk>
 <5a83c1f7-3ab8-486a-b633-33b44858d290@kernel.org>
 <CAPqOJe1FsfA-sx4JXB-UyhUZ4ui3eagFJJ6Z6TfBUpp76ZSw9A@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAPqOJe1FsfA-sx4JXB-UyhUZ4ui3eagFJJ6Z6TfBUpp76ZSw9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/12/24 16:25, dongliang cui wrote:
> On Thu, Apr 11, 2024 at 1:19 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 4/10/24 22:17, Jens Axboe wrote:
>>> On 4/10/24 4:18 AM, Dongliang Cui wrote:
>>>> The default configuration in the current code is that when the device
>>>> is not busy, a single dispatch will attempt to pull 'nr_requests'
>>>> requests out of the schedule queue.
>>>>
>>>> I tried to track the dispatch process:
>>>>
>>>> COMM            TYPE    SEC_START       IOPRIO       INDEX
>>>> fio-17304       R    196798040       0x2005       0
>>>> fio-17306       R    197060504       0x2005       1
>>>> fio-17307       R    197346904       0x2005       2
>>>> fio-17308       R    197609400       0x2005       3
>>>> fio-17309       R    197873048       0x2005       4
>>>> fio-17310       R    198134936       0x2005       5
>>>> ...
>>>> fio-17237       R    197122936         0x0       57
>>>> fio-17238       R    197384984         0x0       58
>>>> <...>-17239     R    197647128         0x0       59
>>>> fio-17240       R    197909208         0x0       60
>>>> fio-17241       R    198171320         0x0       61
>>>> fio-17242       R    198433432         0x0       62
>>>> fio-17300       R    195744088       0x2005       0
>>>> fio-17301       R    196008504       0x2005       0
>>>>
>>>> The above data is calculated based on the block event trace, with each
>>>> column containing: process name, request type, sector start address,
>>>> IO priority.
>>>>
>>>> The INDEX represents the order in which the requests are extracted from
>>>> the scheduler queue during a single dispatch process.
>>>>
>>>> Some low-speed devices cannot process these requests at once, and they will
>>>> be requeued to hctx->dispatch and wait for the next issuance.
>>>>
>>>> There will be a problem here, when the IO priority is enabled, if you try
>>>> to dispatch "nr_request" requests at once, the IO priority will be ignored
>>>> from the scheduler queue and all requests will be extracted.
>>>>
>>>> In this scenario, if a high priority request is inserted into the scheduler
>>>> queue, it needs to wait for the low priority request in the hctx->dispatch
>>>> to be processed first.
>>>>
>>>> --------------------dispatch 1st----------------------
>>>> fio-17241       R       198171320         0x0       61
>>>> fio-17242       R       198433432         0x0       62
>>>> --------------------dispatch 2nd----------------------
>>>> fio-17300       R       195744088       0x2005       0
>>>>
>>>> In certain scenarios, we hope that requests can be processed in order of io
>>>> priority as much as possible.
>>>>
>>>> Maybe max_dispatch should not be a fixed value, but can be adjusted
>>>> according to device conditions.
>>>>
>>>> So we give a interface to control the maximum value of single dispatch
>>>> so that users can configure it according to devices characteristics.
>>>
>>> I agree that pulling 'nr_requests' out of the scheduler will kind of
>>> defeat the purpose of the scheduler to some extent. But rather than add
>>> another knob that nobody knows about or ever will touch (and extra queue
>>> variables that just take up space), why not just default to something a
>>> bit saner? Eg we could default to 1/8 or 1/4 of the scheduler depth
>>> instead.
> Current mechanism will try to pulling everything out of the scheduler,
> regardless
> of the priority of request. Perhaps reducing the queue depth does not solve the
> priority disorder scenario. Reducing depth may also weakens the role
> of priorify.
> 
>>
>> Why not default to pulling what can actually be executed, that is, up to the
>> number of free hw tags / budget ? Anything more than that will be requeued anyway.
> The process of pulling the request out of schedule will try to obtain
> the hw tags.
> If hw tags are obtained, request will continue to be pulled out of scheduler.
> However, for slow devices, the number of hw tags is generally greater than the
> number of requests that the device can currently handle, and
> unprocessed requests
> may not be arranged in dispatch_list in order of priority.

What ? If the number of hw tags you have for your device is larger than what the
device can actually handle, that means that your device driver is very buggy. A
hw tag is a direct identifier of queued commands on the device side. So you
cannot have more than what the device allows.

May be you are confusing this with the fact that even if you have the correct
maximum number of hw tags, the device may sometimes refuse to accept a new
command using a free tag. E.g. a scsi device may return TSF (task set full) even
if its queue is not full (some hw tags are free). But that is not the common case.

As for the commands not being arranged in priority order when submitted, that is
also strange. You are going to get the commands from the scheduler in priority
order, so they will be sorted naturally as such in the dispatch queue, unless
you get a lot of requeue from the device (again, generally not the usual case).

> And for budget, I found that the budget is set by the driver. Some
> slow devices,
> such as emmc, do not register this interface, unable to set budget.

May be that is exactly what you need to do to solve your issue: implement that
for emmc. Have you tried ?


-- 
Damien Le Moal
Western Digital Research


