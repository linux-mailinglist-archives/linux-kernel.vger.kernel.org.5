Return-Path: <linux-kernel+bounces-88192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971386DE5E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2635B287071
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819526A8BA;
	Fri,  1 Mar 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ig46G8V0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E606A356;
	Fri,  1 Mar 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285773; cv=none; b=ausKpaDY5IUSz33MJQuHAFvEho6lRc7wOKD2Rsxu2zmdPWbJ7b0AjlS9aDz4t6hFlLSqWdE3b8a9oVlgc2fIB9sylTHQhriJgmZAzP68xOHg6oEkjTWeoHF7QmPDEoyswHwNpnA3v/gvTwTP3v8sYmocktzn2nua9OBtsDHzdWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285773; c=relaxed/simple;
	bh=Gmf0uAuSVCHCNz8dYID/8N8Eng78uQAJL21zEESINHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X10kmOS1TUoy4QhukLO/lWenWri9Qsou3TMYld99Fns+CaIfE9cqBOYiA3zWpK0ys2O/I1NZmP0Gl0+plzgHca3XqsEi5HmpIQXVkGxCEVUYYYTvBs8ZuyWUvm6bGbhH9IXOwllEq5yUIAHCfJk3i8krDX3+CPVSypDtB0I93Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ig46G8V0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709285770;
	bh=Gmf0uAuSVCHCNz8dYID/8N8Eng78uQAJL21zEESINHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ig46G8V0pkgNPXWHGVJB/JcKf0H593/uLUmsUXQHbWjQx4kF5UVwVCYRuSoK2aOdw
	 BP3PDLMyaGt+zv3W7kFW1FMQSsNolK0+DaQ4EG4RRDTAJnkA28kNFcs/Utre/aP0eK
	 q+RDgJWxv+p1RjN5fwX5tad13FyU54e2tPc5j+iwYEI5FJUCEjWMO8I5wS+jAD79rG
	 NOn7t+DvE0GrKqvqoFxYDp22QBfde1KIDbxhIJ77KEz1887NulmfZIgyvACmGBGzVU
	 y+DmCWHqEOzCv+QJT68pdrrbES/pVEyoycyNuP2AIWR42ajqEP97BUhealuWYyeiF0
	 aIbd4jGPtJgGg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6783B37810CD;
	Fri,  1 Mar 2024 09:36:09 +0000 (UTC)
Message-ID: <7de218a7-680f-40a8-a002-d6a2c87f53ee@collabora.com>
Date: Fri, 1 Mar 2024 10:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: mediatek: vcodec: support 36bit physical address
Content-Language: en-US
To: =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= <Yunfei.Dong@mediatek.com>,
 "nhebert@chromium.org" <nhebert@chromium.org>,
 "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
 "nfraprado@collabora.com" <nfraprado@collabora.com>,
 "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
 "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "frkoenig@chromium.org" <frkoenig@chromium.org>,
 "stevecho@chromium.org" <stevecho@chromium.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "hsinyi@chromium.org" <hsinyi@chromium.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240301020126.11539-1-yunfei.dong@mediatek.com>
 <ea7f25bf-2294-4ad4-bc18-226827d49ae8@collabora.com>
 <c1f489c474e3d00ff8573225c5d282df4d82f9e1.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c1f489c474e3d00ff8573225c5d282df4d82f9e1.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/03/24 10:23, Yunfei Dong (董云飞) ha scritto:
> Hi AngeloGioacchino,
> 
> Thanks for you reviewing.
> On Fri, 2024-03-01 at 10:03 +0100, AngeloGioacchino Del Regno wrote:
>> Il 01/03/24 03:01, Yunfei Dong ha scritto:
>>> The physical address is beyond 32bit for mt8188 platform, need
>>> to change the type from unsigned int to unsigned long in case of
>>> the high bit missing.
>>>
>>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>>> ---
>>>    .../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c        | 4
>>> ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git
>>> a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_
>>> lat_if.c
>>> b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_
>>> lat_if.c
>>> index cf48d09b78d7..85df3e7c2983 100644
>>> ---
>>> a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_
>>> lat_if.c
>>> +++
>>> b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_
>>> lat_if.c
>>> @@ -1074,7 +1074,7 @@ static int
>>> vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance
>>> *inst
>>>    	unsigned int mi_row;
>>>    	unsigned int mi_col;
>>>    	unsigned int offset;
>>> -	unsigned int pa;
>>> +	unsigned long pa;
>>
>> If you used the right type from the beginning, you wouldn't have to
>> fix that ;-)
>>
> Yes, you are right, thanks for your remind.
>> Is there any reason why you didn't - and still don't use the
>> `phys_addr_t` type
>> for the `pa` member?
>>
> pa is also iova, dma address. Change it to dma_addr_t looks much
> better.
> 

Ok, dma_addr_t looks good as well.

Cheers!

> I will change it in next patch.
>> Cheers,
>> Angelo
>>
> Best Regards,
> Yunfei Dong
>>>    	unsigned int size;
>>>    	struct vdec_vp9_slice_tiles *tiles;
>>>    	unsigned char *pos;
>>> @@ -1109,7 +1109,7 @@ static int
>>> vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance
>>> *inst
>>>    	pos = va + offset;
>>>    	end = va + bs->size;
>>>    	/* truncated */
>>> -	pa = (unsigned int)bs->dma_addr + offset;
>>> +	pa = (unsigned long)bs->dma_addr + offset;
>>>    	tb = instance->tile.va;
>>>    	for (i = 0; i < rows; i++) {
>>>    		for (j = 0; j < cols; j++) {
>>
>>


