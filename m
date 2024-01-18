Return-Path: <linux-kernel+bounces-30069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764368318BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97131C21FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B392724214;
	Thu, 18 Jan 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="JE8QnRsP"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47424207
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578717; cv=none; b=bj1IE5Vy2W2v7WcBHZZ4uqGWN0dObVh/xqRAvlQXLYOCMAIMQYtOvR68rsByCV/5lxJc3qCJEOfd9ScYFH3ZVSbckZnyVoY8KWSZdDDsgfR27dsgRIBxd1xEjfxdv18qPHwFk6ulqTG9QE8jdDlCiRxRbV0woLxOE2/Iqfl8CdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578717; c=relaxed/simple;
	bh=+J4HlKZgPkAnNbe+/5Ny2aDPSavVymgjuzDiJAbIaS8=;
	h=X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=AnsBRKIm0u+dg1p0u3r1gdbYrk6RF6n9Ga/lQZ20FWFrW+xXOV2HDJ0/BUGMZGs6HiiBgWZRUXMXKveQPdJzecHxVEaWC7t2i1Y2zAA9OVALdvym7zhRMwJVdUxUHBGtYN08B37Nay0Ewb+6+371i9vwjhbT0B+sIwl4UfYHcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=JE8QnRsP; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: d01b7825-b5f7-11ee-b097-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d01b7825-b5f7-11ee-b097-005056aba152;
	Thu, 18 Jan 2024 12:50:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=9tytfViqCFLbiU7Wz6e6k4feBX9DmDYV8/hI1tB8vDg=;
	b=JE8QnRsPGR1vwks6J1+Dy8zd6fvxR+oiZaaoM915UGciixmcWQSR6BdUvuRmzKnpzUeY5Ni8F92kX
	 2Aj+dcsxdd0u4ceF8KFoz19GZlVw/8TEFvIPVVDKA4BOEx1QwFAeNQ0CAVTgCSNTxIrrhib4/xHf2J
	 MjDuxRtGV2VZ3HUrOhk7U5X64Pz74A73aQLmmnlwLDhYmXawk0xr9vE48KLpYMsq7uaoYtrqU61sOn
	 CuQx7WGxzxL1ktgklu+taU1k/K+9/uqdkWt4/aQR+M0sI6pFTKo4bwRZ4Itw2cvlAos4vKYa044faL
	 /rUnUA+/8clQrlcviW/VQO1mo0uCWEQ==
X-KPN-MID: 33|tp53BvIYLealaXNB0Z4K1LSygruItIfMLFmkwha891rB2GE/geg/8A2U7Esak0Y
 UYzNA3PBJwI/ZWFa7qzD9fg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|iq2f6SR/PHyL6mX/Ziu73uaIUmrxzofpuz9uS59ol1C66aRryIrRw9Yif2uJcAj
 5gr0I7siTiygX4gF+ug1TeA==
Received: from [10.47.75.249] (unknown [173.38.220.58])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id d011b4f8-b5f7-11ee-824d-005056ab1411;
	Thu, 18 Jan 2024 12:50:45 +0100 (CET)
Message-ID: <edaa388e-fc26-4318-b468-64366aa86699@xs4all.nl>
Date: Thu, 18 Jan 2024 12:50:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: media videobuf2: Stop direct calls to queue
 num_buffers field
Content-Language: en-US
To: Tomasz Figa <tfiga@chromium.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: m.szyprowski@samsung.com, mchehab@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20240115170826.214519-1-benjamin.gaignard@collabora.com>
 <20240115170826.214519-2-benjamin.gaignard@collabora.com>
 <c832da45-c818-420d-aaf8-05c15c1e5426@xs4all.nl>
 <521a2a44-9ec1-4898-aca7-721d07e12643@collabora.com>
 <CAAFQd5DWOZwm2E8BwfONtjrcg289wPHJEe3TMZKsBvDcn3OfNw@mail.gmail.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <CAAFQd5DWOZwm2E8BwfONtjrcg289wPHJEe3TMZKsBvDcn3OfNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/18/24 12:22, Tomasz Figa wrote:
> On Tue, Jan 16, 2024 at 6:32 PM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>>
>>
>> Le 16/01/2024 à 10:21, Hans Verkuil a écrit :
>>> On 15/01/2024 18:08, Benjamin Gaignard wrote:
>>>> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
>>>> This allows us to change how the number of buffers is computed in the
>>>> future.
>>>>
>>>> Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the number of queue stored buffers")
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> ---
>>>>   drivers/media/common/videobuf2/videobuf2-core.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>>>> index 41a832dd1426..b6bf8f232f48 100644
>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>> @@ -989,7 +989,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>>>>      bool no_previous_buffers = !q_num_bufs;
>>>>      int ret = 0;
>>>>
>>>> -    if (q->num_buffers == q->max_num_buffers) {
>>>> +    if (q_num_bufs == q->max_num_buffers) {
>>>>              dprintk(q, 1, "maximum number of buffers already allocated\n");
>>>>              return -ENOBUFS;
>>>>      }
>>> There is another case in vb2_ioctl_create_bufs() where num_buffers is accessed directly.
>>> Can you fix that one as well?
>>
>> It is removed by the patch I have send just after this one:
>> "media: core: Refactor vb2_ioctl_create_bufs() to always set capabilities flags"
> 
> I'd prefer that to be also included in this fix, so that it's all
> logically grouped together. Actually Hans also ended up including that
> change in his patch, without the commit message mentioning it.

Yeah, it's borderline. But I think it is better if this patch updates both
places, and then I'll make a v2 for my patch on top.

Regards,

	Hans

> 
> Best regards,
> Tomasz


