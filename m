Return-Path: <linux-kernel+bounces-30194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6D831B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097091C22003
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECBD286B4;
	Thu, 18 Jan 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgZSVx6/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF83A24A16;
	Thu, 18 Jan 2024 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705587999; cv=none; b=Kijahr/fE85bOlmrLqzqyYCUufL+o/8sxaYzFLi2fp3K+y7RuS8+/gpu8MY6BgbZ41wIpO6K7VJgNDW5shR+AlFQhNXvGoQuqNKVD9KvaE/0xa0Sw6NWUyQHCVdZ4pDKO36M1fC5lQ5cbgONe5W07Aryvj1IYbsFUyX+KNqa+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705587999; c=relaxed/simple;
	bh=39MnDT1Nd/TqfvZlkQypZm9c/OafUxX0MQn0a9iNJQY=;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=D37t12HL+F4/BrdsoCzdaoA0h+n8Q4ctgSkO8OLvYes6JpXcFD09egVPEmB4/RYn3wvc+4/BChFbfGT1TJCYdbDsQViWGqYcAX2x0CW4nJT8K7qDFRBXnZWPNkaXrJNxjCB/E+TIJDsPMNqQRj1HjnHIsUb8U9GKBRl9vDgZoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgZSVx6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B48C433F1;
	Thu, 18 Jan 2024 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705587999;
	bh=39MnDT1Nd/TqfvZlkQypZm9c/OafUxX0MQn0a9iNJQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fgZSVx6/a6zstxGfBEJWWhIklN9Cm46UQ5afFjcQlGeoCr+wzWaCH05EssuC7Ww3v
	 P/ZGwgZvgpMbaVlWDThBxBZ0JfFVA1wqIfuFx+CEgJ7mb4/0tDaW2bvc1nYTB9XKvG
	 XQUNwPA5Iu9TlcQqAftdWK7+kmbznLJ7L/ONG3eLSqaf3XZaViRN0kQvWXEZfY3HJ+
	 ouH9yGyNNQbbeVWLeVpjY/Zqej0kxSo2baycWK6mImIH6WuTlwYc8Dj9TemP6WJNlG
	 AC3aeYuERKFjrO9Cz7wZlyeMdjbXzTmHxBKUDp7/XQ9ZBBFmlOQ3ccUl9GRkzOqf4J
	 ozY+fdXIXIosQ==
Message-ID: <ec547d33-214f-4952-aa33-c271e9edad63@kernel.org>
Date: Thu, 18 Jan 2024 16:26:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjToga2VybmVsLm9yZyA2LjUuNCAsIE5QVSBkcml2ZXIs?=
 =?UTF-8?Q?_--not_support_=28RFC=29?=
Content-Language: en-US
To: Cancan Chang <Cancan.Chang@amlogic.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Jagan Teki <jagan@edgeble.ai>, linux-media <linux-media@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Dave Airlie
 <airlied@redhat.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
References: <SEYPR03MB704641091854162959578D7E9AFFA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <SEYPR03MB70462A385A52A317427E93B59AFCA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf11hxBpg3T6MoVrL0GaOD_=xB+-dWeEtDH0cCyzyQ-q1tg@mail.gmail.com>
 <SEYPR03MB70463AEED951A0E2C18481099AC2A@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf13ZiYYoXE+S_wQ_EhjiACPGJGT+70_stwpY_=aD=VYa4A@mail.gmail.com>
 <SEYPR03MB704690FD9116A31D6FBCF32A9AC1A@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf128vYZ+EGHvZD0_ND2CGBzwMKk6OyhVRW_z=xCOSmi47w@mail.gmail.com>
 <SEYPR03MB7046F74834B7D789C2DD4E459AC1A@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf10HAi+HEEWy=C4395eaHh_iSmcW1v87A+1J8QN9_P7tUQ@mail.gmail.com>
 <SEYPR03MB704698F40D90FF6B50D72AC39AC8A@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAAObsKBpD3D76_ugTYDT8p-Fhb6zXOmQQP0yb7qj9jK+=JrqgA@mail.gmail.com>
 <96719046-d391-42be-8abc-564c9c909b97@kernel.org>
 <SEYPR03MB704685CBDC9D3158DBE4D8449A6F2@SEYPR03MB7046.apcprd03.prod.outlook.com>
From: Oded Gabbay <ogabbay@kernel.org>
In-Reply-To: <SEYPR03MB704685CBDC9D3158DBE4D8449A6F2@SEYPR03MB7046.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/01/2024 8:23, Cancan Chang wrote:
> Hi Oded,
> 
> Thanks for your code review. I‘m working on cleaning up the OS-wrapper code
> and adjusting driver submodules. I will fix it befor sending patch series.
> 
> On the other hand, is it necessary to covert the driver to use drm? Amlogic's driver
> is not only used in the visual field, but also in voice-related field, and is not very
> compatible with drm. It hardly enjoy the convenience provided by drm. So，can we
> do it like accel/habanalabs which has  almost no use of drm, is this friendly to you?
> 
> thanks.

habanalabs is a special case as it was a couple of years already in 
drivers/misc, and therefore didn't use drm mechanisms at all. If we 
would have upstreamed a new driver, the expectation would have been that 
we would use some drm mechanisms.

I think that the minimal requirement is to use GEM/BOs for memory 
management operations. At least I see both qaic and ivpu use it.

ofc, you need to register your device through drm/accel and use the 
sysfs/debugfs drm infra.

If you have device memory that the user can allocate and map, then you 
will also need to use TTM.

I don't think you need to use drm_sched as it is tightly coupled with 
how GPUs work.

Oded
> 
> ________________________________________
> 发件人: Oded Gabbay <ogabbay@kernel.org>
> 发送时间: 2024年1月11日 21:14
> 收件人: Tomeu Vizoso; Cancan Chang
> 抄送: Jagan Teki; linux-media; linux-kernel; Dave Airlie; Daniel Vetter
> 主题: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC)
> 
> [ EXTERNAL EMAIL ]
> 
> On 11/01/2024 10:04, Tomeu Vizoso wrote:
>> Hi Oded,
>>
>> Out of curiosity, did you end up taking a look at Amlogic's driver?
>>
>> Cheers,
>>
>> Tomeu
> Hi Tomeu,
> Yes, I have looked at the driver's code. It was not an in-depth review,
> but I tried to mainly understand the features the driver provide to the
> user and how much complex it is.
> 
>   From what I could see, this is a full-fledged accelerator which
> requires command submission/completion handling, memory management,
> information and debug capabilities and more.
> 
> Therefore, I do think the correct place is in the accel sub-system,
> which will require you to convert the driver to use drm (we can discuss
> exactly what is the level of integration required).
> 
> As I said, I didn't do a full-fledged review, but please note the driver
> has a lot of OS-wrapper code, which is not acceptable in the Linux
> kernel, so you will have to clean all the up.
> 
> Thanks,
> Oded
> 
>>
>> On Sat, Oct 7, 2023 at 8:37 AM Cancan Chang <Cancan.Chang@amlogic.com> wrote:
>>>
>>> Oded,
>>>          You can get the driver code from  github link： https://github.com/OldDaddy9/driver
>>>           e.g.  git clone https://github.com/OldDaddy9/driver.git
>>>
>>> ________________________________________
>>> 发件人: Oded Gabbay <ogabbay@kernel.org>
>>> 发送时间: 2023年10月3日 18:52
>>> 收件人: Cancan Chang
>>> 抄送: Jagan Teki; linux-media; linux-kernel; Dave Airlie; Daniel Vetter
>>> 主题: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC)
>>>
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Thu, Sep 28, 2023 at 11:16 AM Cancan Chang <Cancan.Chang@amlogic.com> wrote:
>>>>
>>>> “What happens if you call this again without waiting for the previous
>>>> inference to complete ?”
>>>>      --- There is a work-queue in the driver to manage inference tasks.
>>>>            When two consecutive inference tasks occur, the second inference task will be add to
>>>>            the "pending list". While the previous inference task ends, the second inference task will
>>>>            switch to the "scheduled list", and be executed.
>>>>            Each inference task has an id,  "inferece" and "wait until finish" are paired.
>>>>
>>>>            thanks
>>> Thanks for the clarification.
>>> I'll wait for your driver's code link. It doesn't have to be a patch
>>> series at this point. A link to a git repo is enough.
>>> I just want to do a quick pass.
>>>
>>> Thanks,
>>> Oded
>>>
>>>
>>>
>>>>
>>>> ________________________________________
>>>> 发件人: Oded Gabbay <ogabbay@kernel.org>
>>>> 发送时间: 2023年9月28日 15:40
>>>> 收件人: Cancan Chang
>>>> 抄送: Jagan Teki; linux-media; linux-kernel; Dave Airlie; Daniel Vetter
>>>> 主题: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC)
>>>>
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> On Thu, Sep 28, 2023 at 10:25 AM Cancan Chang <Cancan.Chang@amlogic.com> wrote:
>>>>>
>>>>> “Could you please post a link to the driver's source code ?
>>>>> In addition, could you please elaborate which userspace libraries
>>>>> exists that work with your driver ? Are any of them open-source ?”
>>>>> --- We will prepare the adla driver link after the holiday on October 6th.
>>>>>        It's a pity that there is no open-source userspace library.
>>>>>        But you can probably understand it through a workflow, which can be simplified as:
>>>>>        1. create model context
>>>>>             ret = ioctl(context->fd, ADLAK_IOCTL_REGISTER_NETWORK, &desc);
>>>>>        2.  set inputs
>>>>>        3.  inference
>>>>>              ret = ioctl(context->fd, ADLAK_IOCTL_INVOKE, &invoke_dec);
>>>> What happens if you call this again without waiting for the previous
>>>> inference to complete ?
>>>> Oded
>>>>>        4.  wait for the inference to complete
>>>>>              ret = ioctl(context->fd, ADLAK_IOCTL_WAIT_UNTIL_FINISH, &stat_req_desc);
>>>>>        5.  destroy model context
>>>>>              ret = ioctl(context->fd, ADLAK_IOCTL_DESTROY_NETWORK, &submit_del);
>>>>>
>>>>>
>>>>>         thanks
>>>>>
>>>>>
>>>>> ________________________________________
>>>>> 发件人: Oded Gabbay <ogabbay@kernel.org>
>>>>> 发送时间: 2023年9月28日 13:28
>>>>> 收件人: Cancan Chang
>>>>> 抄送: Jagan Teki; linux-media; linux-kernel; Dave Airlie; Daniel Vetter
>>>>> 主题: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC)
>>>>>
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>> On Wed, Sep 27, 2023 at 10:01 AM Cancan Chang <Cancan.Chang@amlogic.com> wrote:
>>>>>>
>>>>>> “Or do you handle one cmd at a time, where the user sends a cmd buffer
>>>>>> to the driver and the driver then submit it by writing to a couple of
>>>>>> registers and polls on some status register until its done, or waits
>>>>>> for an interrupt to mark it as done ?”
>>>>>>     --- yes， user sends a cmd buffer to driver, and driver triggers hardware by writing to register,
>>>>>>           and then, waits for an interrupt to mark it  as done.
>>>>>>
>>>>>>       My current driver is very different from drm, so I want to know if I have to switch to drm？
>>>>> Could you please post a link to the driver's source code ?
>>>>> In addition, could you please elaborate which userspace libraries
>>>>> exists that work with your driver ? Are any of them open-source ?
>>>>>
>>>>>>       Maybe I can refer to /driver/accel/habanalabs.
>>>>> That's definitely a possibility.
>>>>>
>>>>> Oded
>>>>>>
>>>>>> thanks
>>>>>>
>>>>>> ________________________________________
>>>>>> 发件人: Oded Gabbay <ogabbay@kernel.org>
>>>>>> 发送时间: 2023年9月26日 20:54
>>>>>> 收件人: Cancan Chang
>>>>>> 抄送: Jagan Teki; linux-media; linux-kernel; Dave Airlie; Daniel Vetter
>>>>>> 主题: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC)
>>>>>>
>>>>>> [ EXTERNAL EMAIL ]
>>>>>>
>>>>>> On Mon, Sep 25, 2023 at 12:29 PM Cancan Chang <Cancan.Chang@amlogic.com> wrote:
>>>>>>>
>>>>>>> Thank you for your reply from Jagan & Oded.
>>>>>>>
>>>>>>> It is very appropritate for my driver to be placed in driver/accel.
>>>>>>>
>>>>>>> My accelerator is named ADLA(Amlogic Deep Learning Accelerator).
>>>>>>> It is an IP in SOC,mainly used for neural network models acceleration.
>>>>>>> It will split and compile the neural network model into a private format cmd buffer,
>>>>>>> and submit this cmd buffer to ADLA hardware. It is not programmable device.
>>>>>> What exactly does it mean to "submit this cmd buffer to ADLA hardware" ?
>>>>>>
>>>>>> Does your h/w provides queues for the user/driver to put their
>>>>>> workloads/cmd-bufs on them ? And does it provide some completion queue
>>>>>> to notify when the work is completed?
>>>>>>
>>>>>> Or do you handle one cmd at a time, where the user sends a cmd buffer
>>>>>> to the driver and the driver then submit it by writing to a couple of
>>>>>> registers and polls on some status register until its done, or waits
>>>>>> for an interrupt to mark it as done ?
>>>>>>
>>>>>>>
>>>>>>> ADLA includes four hardware engines:
>>>>>>> RS engines             : working for the reshape operators
>>>>>>> MAC engines         : working for the convolution operators
>>>>>>> DW engines           : working for the planer & Elementwise operators
>>>>>>> Activation engines : working for activation operators(ReLu,tanh..)
>>>>>>>
>>>>>>> By the way, my IP is mainly used for SOC, and the current driver registration is through the platform_driver,
>>>>>>> is it necessary to switch to drm?
>>>>>> This probably depends on the answer to my question above. btw, there
>>>>>> are drivers in drm that handle IPs that are part of an SOC, so
>>>>>> platform_driver is supported.
>>>>>>
>>>>>> Oded
>>>>>>
>>>>>>>
>>>>>>> thanks.
>>>>>>>
>>>>>>> ________________________________________
>>>>>>> 发件人: Oded Gabbay <ogabbay@kernel.org>
>>>>>>> 发送时间: 2023年9月22日 23:08
>>>>>>> 收件人: Jagan Teki
>>>>>>> 抄送: Cancan Chang; linux-media; linux-kernel; Dave Airlie; Daniel Vetter
>>>>>>> 主题: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC)
>>>>>>>
>>>>>>> [你通常不会收到来自 ogabbay@kernel.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>>>>>>
>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>>
>>>>>>> On Fri, Sep 22, 2023 at 12:38 PM Jagan Teki <jagan@edgeble.ai> wrote:
>>>>>>>>
>>>>>>>> On Fri, 22 Sept 2023 at 15:04, Cancan Chang <Cancan.Chang@amlogic.com> wrote:
>>>>>>>>>
>>>>>>>>> Dear Media Maintainers:
>>>>>>>>>        Thanks for your attention. Before describing my problem，let me introduce to you what I  mean by NPU.
>>>>>>>>>        NPU is Neural Processing Unit, It is designed for deep learning acceleration, It is also called TPU, APU ..
>>>>>>>>>
>>>>>>>>>        The real problems:
>>>>>>>>>         When I was about to upstream my NPU driver codes to linux mainline, i meet two problems:
>>>>>>>>>           1.  According to my research, There is no NPU module path in the linux (base on linux 6.5.4) , I have searched all linux projects and found no organization or comany that has submitted NPU code. Is there a path prepared for NPU driver currently?
>>>>>>>>>           2.   If there is no NPU driver path currently, I am going to put my NPU driver code in the drivers/media/platform/amlogic/ ﻿, because my NPU driver belongs to amlogic. and amlogic NPU is mainly used for AI vision applications. Is this plan suitabe for you?
>>>>>>>>
>>>>>>>> If I'm correct about the discussion with Oded Gabby before. I think
>>>>>>>> the drivers/accel/ is proper for AI Accelerators including NPU.
>>>>>>>>
>>>>>>>> + Oded in case he can comment.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Jagan.
>>>>>>> Thanks Jagan for adding me to this thread. Adding Dave & Daniel as well.
>>>>>>>
>>>>>>> Indeed, the drivers/accel is the place for Accelerators, mainly for
>>>>>>> AI/Deep-Learning accelerators.
>>>>>>> We currently have 3 drivers there already.
>>>>>>>
>>>>>>> The accel subsystem is part of the larger drm subsystem. Basically, to
>>>>>>> get into accel, you need to integrate your driver with the drm at the
>>>>>>> basic level (registering a device, hooking up with the proper
>>>>>>> callbacks). ofc the more you use code from drm, the better.
>>>>>>> You can take a look at the drivers under accel for some examples on
>>>>>>> how to do that.
>>>>>>>
>>>>>>> Could you please describe in a couple of sentences what your
>>>>>>> accelerator does, which engines it contains, how you program it. i.e.
>>>>>>> Is it a fixed-function device where you write to a couple of registers
>>>>>>> to execute workloads, or is it a fully programmable device where you
>>>>>>> load compiled code into it (GPU style) ?
>>>>>>>
>>>>>>> For better background on the accel subsystem, please read the following:
>>>>>>> https://docs.kernel.org/accel/introduction.html
>>>>>>> This introduction also contains links to other important email threads
>>>>>>> and to Dave Airlie's BOF summary in LPC2022.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Oded
> 


