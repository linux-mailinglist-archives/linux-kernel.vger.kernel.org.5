Return-Path: <linux-kernel+bounces-110051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA456885962
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EFFB22D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D7C83CCB;
	Thu, 21 Mar 2024 12:49:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F43717B;
	Thu, 21 Mar 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025370; cv=none; b=s67l69mQlYtIPM4aTN7j30loHKKVZj5D+QE5JMN/2bKAqN1VoJYl3LBCE47NbtrUY/+vatHtBqv7+FJp0/5S9RHEy9Om0+sdgvaqQiIq4Pxt8sG2mzMtj9JEuI79fUR02t1XcQw2cm1GzKZdq1mUP5bkkH7FGXKE5v723PV78zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025370; c=relaxed/simple;
	bh=6Vej4cpwmjyLizSNv2zTuiYPa3uTC+licjVz4+pju8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2dauEfdNVdBFr42MYznkrE0tnjakgIeKpLiP8/tZ4c27/m4TLR34Hnn9rLH3i011Kvs80NFWMQjf/YhSw57Vbv4ps6IsFQQAuSKlNyXmY4wGjpwn4Wu1Wdk4zWwiL9elwKqB7bfErjFT0s4HYTQNQsWhY7pwIlc1lCEHCnZXrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8E0C433C7;
	Thu, 21 Mar 2024 12:49:28 +0000 (UTC)
Message-ID: <443e9909-7036-48a4-a1ea-c3908263282e@xs4all.nl>
Date: Thu, 21 Mar 2024 13:49:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW3YxXSBzdGFnaW5nOiBtZWRpYTogc3RhcmZpdmU6?=
 =?UTF-8?Q?_Renamed_capture=5Fraw_to_capture=5Fdump?=
Content-Language: en-US, nl
To: Changhuang Liang <changhuang.liang@starfivetech.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jack Zhu <jack.zhu@starfivetech.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
References: <20240301070025.11144-1-changhuang.liang@starfivetech.com>
 <d741106e-5bff-441a-beb3-5ef1c81d912a@xs4all.nl>
 <SHXPR01MB0671C5F9FD505906E460FA2FF232A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <SHXPR01MB0671C5F9FD505906E460FA2FF232A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 1:17 pm, Changhuang Liang wrote:
> Hi, Hans
> 
> Thanks for your comments.
> 
>> On 01/03/2024 8:00 am, Changhuang Liang wrote:
>>> The pixel formats captured by the capture_raw video device depends on
>>> what pixel formats come from the source device. It is actually dump
>>> the source device data. So renamed it to capture_dump.
>>
>> I don't think 'dump' is a great name. I think what you really want to say is
>> 'unprocessed'. And usually that is indeed called 'raw capture'.
>>
> 
> StarFive JH7110 SoC also supports the output of the raw format data from ISP port, see:
> 
> https://lore.kernel.org/all/20240306093334.9321-1-changhuang.liang@starfivetech.com/
> 
> So I think it is better to call the ISP output port "capture_raw".

If it is processed by the ISP, how can it be 'raw'? Or do you mean that this uses Bayer pixelformat?

The normal convention AFAIK is that the term 'raw capture' generally means that
the sensor bayer data is captured without being processed (or only minimal processing).

Looking at:

https://lore.kernel.org/all/20240306093334.9321-6-changhuang.liang@starfivetech.com/

I think you indeed mean that you can get the processed ISP data in bayer format
through a separate video device. So I would call that port 'capture_bayer' and keep the
'capture_raw' name for the port from the CSI receiver.

Regards,

	Hans

> 
> On the other hand, Old "capture_raw" video devices can also support YUV color space, 
> mainly depending on the camera output format. There may be a confusion called it "capture_raw".
> 
> Regards,
> Changhuang
> 
> 


