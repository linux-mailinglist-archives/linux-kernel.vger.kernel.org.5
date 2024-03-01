Return-Path: <linux-kernel+bounces-88205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB9D86DEA6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F424B247F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECA76A8D3;
	Fri,  1 Mar 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tGYVJO92"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B3B6995C;
	Fri,  1 Mar 2024 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286852; cv=none; b=fiU4vVEMu8MsjLtvCYKpFA9XZRzZUGw3mSYtrTv1VFKBa2E2qKsVewV9b5haqStScpsebPAM3MtuOyFdYB6elPNmIdHs9blfJHXAGnWXvBdzTyRdVDOVJ+Iy9pYgo7rXljEKwPP1CwNqcn/1hls2D86THnMdtayk81p0ApAl5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286852; c=relaxed/simple;
	bh=TvOeS+gkrSoRl27YcSo8vGBcXBu+FwFHZ14acWBgVEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgRzOrfu0EKTSUaKCX11jXs5K9MLZAFmC+Za+AyxHUJ9KGj3LmXx2cgJ/3Px2+bJHqMWgXXVZT3eYXv7F0rcZ6mOAfLpdHqAs1BOxZ53cqmaH6ON5RjVHMCtDvZg8IXwwOV9Yp8dFeUlOSMls5HA7G7/iJGOXZhr3RVUNvuFLTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tGYVJO92; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709286847;
	bh=TvOeS+gkrSoRl27YcSo8vGBcXBu+FwFHZ14acWBgVEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGYVJO92s/E6trrtTDfgT+rP/d8KDOX34glXLf4m+QrACnCjhGQFkS61NSd/RtYCF
	 8pQV8vHl1BXN0RvsMg20mMlWgowlIXj4u7OaTaG5W5WBm4xBzQOyWiTS/ZmEIdcZIZ
	 /+EpvaJqbevyu6cTOK43M1ChP0zaLSdLHXL3nZvaOeIRj2IVPFRBn0Z0ZFzW+19ZPw
	 pER4iNs+324frTCLttf+rGsb4BQYYGSwDk/pdPgbJjmNbhEIdNNJH/GuvALrLSwOdN
	 A9wYGh9bD/PdgMGUgx9Jbp4prk+iLBBgeN2RVHdE4PCbrMj76auO5kMYxihIwy1IL9
	 xGyZBwAfYDT7w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 788D737820C2;
	Fri,  1 Mar 2024 09:54:07 +0000 (UTC)
Date: Fri, 1 Mar 2024 10:54:06 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Yunfei Dong =?utf-8?B?KOiRo+S6kemjnik=?= <Yunfei.Dong@mediatek.com>,
	"nhebert@chromium.org" <nhebert@chromium.org>,
	"benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
	"nfraprado@collabora.com" <nfraprado@collabora.com>,
	"nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"frkoenig@chromium.org" <frkoenig@chromium.org>,
	"stevecho@chromium.org" <stevecho@chromium.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"hsinyi@chromium.org" <hsinyi@chromium.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] media: mediatek: vcodec: support 36bit physical address
Message-ID: <20240301095406.4xu2fadgwgswn6jj@basti-XPS-13-9310>
References: <20240301020126.11539-1-yunfei.dong@mediatek.com>
 <ea7f25bf-2294-4ad4-bc18-226827d49ae8@collabora.com>
 <c1f489c474e3d00ff8573225c5d282df4d82f9e1.camel@mediatek.com>
 <7de218a7-680f-40a8-a002-d6a2c87f53ee@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7de218a7-680f-40a8-a002-d6a2c87f53ee@collabora.com>

Hey Yunfei,

On 01.03.2024 10:36, AngeloGioacchino Del Regno wrote:
>Il 01/03/24 10:23, Yunfei Dong (董云飞) ha scritto:
>>Hi AngeloGioacchino,
>>
>>Thanks for you reviewing.
>>On Fri, 2024-03-01 at 10:03 +0100, AngeloGioacchino Del Regno wrote:
>>>Il 01/03/24 03:01, Yunfei Dong ha scritto:
>>>>The physical address is beyond 32bit for mt8188 platform, need
>>>>to change the type from unsigned int to unsigned long in case of
>>>>the high bit missing.
>>>>
>>>>Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>>>>---
>>>>   .../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c        | 4
>>>>++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>>diff --git
>>>>a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_
>>>>lat_if.c
>>>>b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_
>>>>lat_if.c
>>>>index cf48d09b78d7..85df3e7c2983 100644
>>>>---
>>>>a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_
>>>>lat_if.c
>>>>+++
>>>>b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_
>>>>lat_if.c
>>>>@@ -1074,7 +1074,7 @@ static int
>>>>vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance
>>>>*inst
>>>>   	unsigned int mi_row;
>>>>   	unsigned int mi_col;
>>>>   	unsigned int offset;
>>>>-	unsigned int pa;
>>>>+	unsigned long pa;
>>>
>>>If you used the right type from the beginning, you wouldn't have to
>>>fix that ;-)
>>>
>>Yes, you are right, thanks for your remind.
>>>Is there any reason why you didn't - and still don't use the
>>>`phys_addr_t` type
>>>for the `pa` member?
>>>
>>pa is also iova, dma address. Change it to dma_addr_t looks much
>>better.
>>
>
>Ok, dma_addr_t looks good as well.

Ah alright, disregard my comment about unsigned long vs u64 then, but
please have a look at the other casts in the driver as well as you
currently cast to either:
- u64
- uint64_t
- unsigned long

Greetings,
Sebastian

>
>Cheers!
>
>>I will change it in next patch.
>>>Cheers,
>>>Angelo
>>>
>>Best Regards,
>>Yunfei Dong
>>>>   	unsigned int size;
>>>>   	struct vdec_vp9_slice_tiles *tiles;
>>>>   	unsigned char *pos;
>>>>@@ -1109,7 +1109,7 @@ static int
>>>>vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance
>>>>*inst
>>>>   	pos = va + offset;
>>>>   	end = va + bs->size;
>>>>   	/* truncated */
>>>>-	pa = (unsigned int)bs->dma_addr + offset;
>>>>+	pa = (unsigned long)bs->dma_addr + offset;
>>>>   	tb = instance->tile.va;
>>>>   	for (i = 0; i < rows; i++) {
>>>>   		for (j = 0; j < cols; j++) {
>>>
>>>
>
>

