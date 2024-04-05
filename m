Return-Path: <linux-kernel+bounces-132638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A84A899795
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE7CB22B17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D67145FE2;
	Fri,  5 Apr 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TvY/fwRv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84F146589;
	Fri,  5 Apr 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304816; cv=none; b=LsVH7rOlAVFcZR/ZWdDauuHkKDXwAyy9VUnEatIM854nqB7kJhWxRYM2yZVDFwYQwCU7yEws/yiBfLRgoat0BJCPCMcL/tEILo81W/bncB7qbp6oVd3bfLyLrMoY/ByEx9NJq1+Wtx9zByL8ghxmKxFM5GxPMN4J+J/5n3MUcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304816; c=relaxed/simple;
	bh=BZivL1tsuPOsE7R9f+yNA2qQdac1vOe40dCDW47TSe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEO1S373mW5LiQftldF3ymcgl+ESUztUrThiEsI/2WsG/3P3+iY6uvgKydiPI8Av0D0Xibjlln8NYOyk//Z9zN4EIO28GO6GM/2XTVdt70EjRNJ76C4Za3NPlGKlOZrghfagK+sS8JxtAPdQIYFZunZJtt8fnPRTIv4fIET2geg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TvY/fwRv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712304813;
	bh=BZivL1tsuPOsE7R9f+yNA2qQdac1vOe40dCDW47TSe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TvY/fwRv4FCNyJ4kIFWQ4GAQvYvHXQosmeA79XzQQVZmhMAhgABODc0ClFqBdR4La
	 jZVMpOYuRDFJlhjyEzJPGBHFiqHwlexH2oaotmXB0yJriNS7k3YsM6jx1SaeUIIB+6
	 QG7/n1SVJ5u4CG+WdN67VtxHBBCv7f6N7bqQKDvg99CbFmRU/Ks2QP5814nyzLtYG2
	 SKv3edtBE1t6I7X2C+TEBcpnn/NTPkFRs8x3+Maa9a1xXJ6x8Dc6nsT1yQ6uoztTQI
	 459eJHX09fosEj7n2Il21Mw89BwmK8n5PzjzQ5il96UBbKpY5wcPI4ieOzouSqQTKk
	 g3MQxLYEOOP2w==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8653F378212D;
	Fri,  5 Apr 2024 08:13:32 +0000 (UTC)
Message-ID: <2a3b897a-71f7-4a94-a13c-1aa8b2d96e78@collabora.com>
Date: Fri, 5 Apr 2024 10:13:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: verisilicon: Fix auxiliary buffers allocation size
To: Nicolas Dufresne <nicolas@ndufresne.ca>, ezequiel@vanguardiasur.com.ar,
 p.zabel@pengutronix.de, mchehab@kernel.org, heiko@sntech.de
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20240328093439.18712-1-benjamin.gaignard@collabora.com>
 <20240328093439.18712-2-benjamin.gaignard@collabora.com>
 <c8de69fc6cb6029e96f3e6b6c1eeb1de9304ccff.camel@ndufresne.ca>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <c8de69fc6cb6029e96f3e6b6c1eeb1de9304ccff.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 04/04/2024 à 20:00, Nicolas Dufresne a écrit :
> Hi,
>
> Le jeudi 28 mars 2024 à 10:34 +0100, Benjamin Gaignard a écrit :
>> Use v4l2_av1_tile_info->tile_cols to know the number of colons
>> in the frame. This made auxiliary buffers meory size computation
>> more accurate.
> Seems like this is potentially going to impact some conformance tests. Anything
> to report from fluster results ?

Flusters AV1 score is the same.
Maybe we have been lucky when allocating memory until now.
That said the test stream have 8 tile columns which is unusual but admitted by AV1 specifications.

Benjamin

>
> Nicolas
>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> Fixes: 727a400686a2 ("media: verisilicon: Add Rockchip AV1 decoder")
>> ---
>>   .../media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c    | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
>> index cc4483857489..65e8f2d07400 100644
>> --- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
>> +++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
>> @@ -257,7 +257,8 @@ static int rockchip_vpu981_av1_dec_tiles_reallocate(struct hantro_ctx *ctx)
>>   	struct hantro_dev *vpu = ctx->dev;
>>   	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
>>   	struct hantro_av1_dec_ctrls *ctrls = &av1_dec->ctrls;
>> -	unsigned int num_tile_cols = 1 << ctrls->tile_group_entry->tile_col;
>> +	const struct v4l2_av1_tile_info *tile_info = &ctrls->frame->tile_info;
>> +	unsigned int num_tile_cols = tile_info->tile_cols;
>>   	unsigned int height = ALIGN(ctrls->frame->frame_height_minus_1 + 1, 64);
>>   	unsigned int height_in_sb = height / 64;
>>   	unsigned int stripe_num = ((height + 8) + 63) / 64;
>

