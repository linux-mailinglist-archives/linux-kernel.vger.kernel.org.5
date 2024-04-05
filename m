Return-Path: <linux-kernel+bounces-132642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A08997A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB3B1C20C46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F2146002;
	Fri,  5 Apr 2024 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lNDi1GUq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C648CF2;
	Fri,  5 Apr 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305073; cv=none; b=M4Irst499W+Y/DW/Mspb5TgbQHqH79vHkNWaMDVa9Zu8gE9TKLQSHnWN+a6APxoMNsZKXULAcXwk/44ezoveVy3RgxBb4yQO40pTupgoanR1zUas1lFFo6wI0IvwrIbtPawSNb1NzjxdAW2rP7YwV5QzMCzQ8s8gyCt8BJr0hDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305073; c=relaxed/simple;
	bh=2ttnx/syndg1SQwF3EPAEoa5ox2rpecAHGxXciYNAHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrKMQJcm2uQ3/oV62lMQciFrnOh1dYysj9uhPY2Why6sug3O0mVWS68Rr8vVhmMky7IX3V/UinpQwcYhv/TUhWUHr8avj0Lg7azD8RmcIjAHztaSyqfc5QZGo2T9Pe72XHTUpaImbgu4P3w1myfdwb/h79SlidA7mBc2cjhrPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lNDi1GUq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712305070;
	bh=2ttnx/syndg1SQwF3EPAEoa5ox2rpecAHGxXciYNAHA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lNDi1GUq481w8n4ZvQHskVubVZVHye+7Mk7oZ4ndKU3aKRXi0wnBIRrRrUsZSr8sM
	 xPvcR7vsjVNzh0nC7bQ2uMvNmkhNxPw6bgv8JCcVBG+2Mr4Ey+jY2uKPCuKiX0DhNI
	 EhE1L49+O+6Dtd5BxYrqV+/SJtktnSQNw+81/jKBivKNqKDMnIlgFXI1d3zO+tarKl
	 9nYSww5mpaH/LOqFLpqxbxCbYjvbLXzJT+dg9k8+2OwybGNheaTQd097QbeUco3gq2
	 1thO+Wi05vVqT8HPEhvlGJ7yA5amGyeBDlm6Tz6mfbRnvmgfLPp3AHAoTqU7n6cDx1
	 EV+OPSJKAk+3w==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F0E073780EC6;
	Fri,  5 Apr 2024 08:17:49 +0000 (UTC)
Message-ID: <ebbe249f-bce6-4e81-969f-c63ab4b063f3@collabora.com>
Date: Fri, 5 Apr 2024 10:17:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: verisilicon: AV1: Be more fexible on postproc
 capabilities
To: Nicolas Dufresne <nicolas@ndufresne.ca>, ezequiel@vanguardiasur.com.ar,
 p.zabel@pengutronix.de, mchehab@kernel.org, heiko@sntech.de
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20240328093439.18712-1-benjamin.gaignard@collabora.com>
 <e4d01c27aa976c44e0b7122e39111be062a4deb4.camel@ndufresne.ca>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <e4d01c27aa976c44e0b7122e39111be062a4deb4.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 04/04/2024 à 19:59, Nicolas Dufresne a écrit :
> Hi,
>
> Le jeudi 28 mars 2024 à 10:34 +0100, Benjamin Gaignard a écrit :
>> RK3588 post-processor block is able to convert 10 bits streams
>> into 8 bits pixels format.
> Does it come with any HDR to SDR capabilities ? cause stripping off 2 bits means
> that tone mapping will cause a lot of banding as it won't have the expected
> precision. I'm simply trying to make up the big portrait so we don't just offer
> yet another foot gun. But perhaps its fine to offer this, its just that we don't
> have a mechanism to report which pixel format in the selection will cause data
> lost.

No it just to enable post-processor capabilities like we have already for G2/HEVC.
Since it is a post-processor pixel format it will be enumerated after V4L2_PIX_FMT_NV15_4L4
so it will update to userland to decide to use it or not.

Benjamin

>
> Nicolas
>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> Fixes: 003afda97c65 ("media: verisilicon: Enable AV1 decoder on rk3588")
>> ---
>>   drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
>> index f97527670783..964122e7c355 100644
>> --- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
>> +++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
>> @@ -82,7 +82,6 @@ static const struct hantro_fmt rockchip_vpu981_postproc_fmts[] = {
>>   	{
>>   		.fourcc = V4L2_PIX_FMT_NV12,
>>   		.codec_mode = HANTRO_MODE_NONE,
>> -		.match_depth = true,
>>   		.postprocessed = true,
>>   		.frmsize = {
>>   			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
>

