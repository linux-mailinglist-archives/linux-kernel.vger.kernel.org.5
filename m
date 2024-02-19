Return-Path: <linux-kernel+bounces-70988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F2859F12
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5321C210B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCCA22EEA;
	Mon, 19 Feb 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qtGV317q"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B8224CC;
	Mon, 19 Feb 2024 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333413; cv=none; b=qoGF+2cMM0EC8XtXmK4Bir8388cmRDnrz1qV55Umci3Y7NgHjs3YxE6Eemz4k2wRwtvNmp74RzosyNXR4uN5nPkBPEsuDX1+xpnreFJGinPKD1tk37B7OJQPuufOX9hO0CDwS9maLXw0mJf4L973XaiqJ8YgI10tWlvbKMQK0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333413; c=relaxed/simple;
	bh=9N9JTATGue0lSrwB0YkyG4L8xvvl/c/Kp9BnJrpO4FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=skKVijyAIo06Tf+PBlUxP51+xxFAZFBGmgkLe0CACG1HxJMrJ2s8ohExQL60zf4Sufgw1tYH+NvkW9FSKPuRPBoymmO3UCnjD+dyC/2YqH1q9XUWA30LxHmKverC0IUsv5yD3YW9UDNp/pReS0agGreJaSwufOZ2lozrWWa09NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qtGV317q; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.102] (unknown [103.86.18.199])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD68A183;
	Mon, 19 Feb 2024 10:03:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708333402;
	bh=9N9JTATGue0lSrwB0YkyG4L8xvvl/c/Kp9BnJrpO4FQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qtGV317qIx71HN77jzgzM1hT4bFDAScyOC+DWe70QgG1TtNW3329gWqf0GBrZ9yqM
	 xV1JOTpX/FYwkOQBncMu0+9eHLSIq0PtqMjaWleV/s770VrrZglCVmrFsKq9qt+JBi
	 XkYVEi58+/Y32KAJrIPbeQhn7GoXjnf1D9OAArs8=
Message-ID: <b500676e-431f-40fc-868b-9f9bb359a109@ideasonboard.com>
Date: Mon, 19 Feb 2024 14:33:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: rkisp1: Allow higher input resolution
To: Adam Ford <aford173@gmail.com>, =?UTF-8?Q?Ond=C5=99ej_Jirman?=
 <megi@xff.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-kernel@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>,
 "open list:ROCKCHIP ISP V1 DRIVER" <linux-media@vger.kernel.org>,
 "open list:ROCKCHIP ISP V1 DRIVER" <linux-rockchip@lists.infradead.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Paul Elder <paul.elder@ideasonboard.com>
References: <20240217185202.1754750-1-megi@xff.cz>
 <20240218205908.GA12766@pendragon.ideasonboard.com>
 <pftafukuzq7qzbhlvwtmeg3mburnttylgy4246timlghtrdgx4@r6munvmj6oqt>
 <CAHCN7x+zi3WxnY-mxZFKePs1cS=-DprEmh_CnypJ4XK7xBzjMQ@mail.gmail.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <CAHCN7x+zi3WxnY-mxZFKePs1cS=-DprEmh_CnypJ4XK7xBzjMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi All,

On 19/02/24 7:39 am, Adam Ford wrote:
> On Sun, Feb 18, 2024 at 3:02 PM Ondřej Jirman <megi@xff.cz> wrote:
>> On Sun, Feb 18, 2024 at 10:59:08PM +0200, Laurent Pinchart wrote:
>>> Hi Ondrej,
>>>
>>> (CC'ing Paul and Umang)
>>>
>>> Thank you for the patch.
>>>
>>> On Sat, Feb 17, 2024 at 07:51:58PM +0100, Ondřej Jirman wrote:
>>>> From: Ondrej Jirman <megi@xff.cz>
>>>>
>>>> In BSP driver, it is allowed, and it works in practice. Tested on
>>>> Pinephone Pro/RK3399 with IMX258 at full res.
>>> Paul, Umang, do I recall correctly that you have a similar change ?
>>> Could you review and test this (especially on the i.MX8MP) ?
>> It's also a limit from the datasheet, so the change should not be that
>> controversial:
>>
>>    https://megous.com/dl/tmp/d2b333043ecebaf3.png
>>
>> (so that it doesn't sound like I just copied the BSP values)
>>
>  From what I see in the i.MX8M Plus reference manual, it has a max
> resolution of 4096x3072, so it might be necessary to move this off

This is what I (and I assume Paul too) have been working with on i.MX8M 
Plus. So it's the known and tested value of max ISP input from out side.
> from a #define into a structure that varies by product family.

Yeah!
>
> adam
>> regards,
>>          o.
>>
>>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>>> ---
>>>>   drivers/media/platform/rockchip/rkisp1/rkisp1-common.h | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>>>> index 4b6b28c05b89..74098ddbeeb3 100644
>>>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>>>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>>>> @@ -33,8 +33,8 @@ struct dentry;
>>>>   #define RKISP1_ISP_SD_SINK                 BIT(1)
>>>>
>>>>   /* min and max values for the widths and heights of the entities */
>>>> -#define RKISP1_ISP_MAX_WIDTH                       4032
>>>> -#define RKISP1_ISP_MAX_HEIGHT                      3024
>>>> +#define RKISP1_ISP_MAX_WIDTH                       4416
>>>> +#define RKISP1_ISP_MAX_HEIGHT                      3312
>>>>   #define RKISP1_ISP_MIN_WIDTH                       32
>>>>   #define RKISP1_ISP_MIN_HEIGHT                      32
>>>>
>>> --
>>> Regards,
>>>
>>> Laurent Pinchart


