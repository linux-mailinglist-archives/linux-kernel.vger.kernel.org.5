Return-Path: <linux-kernel+bounces-88203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E097586DE9B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43B2282C68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B46A8CE;
	Fri,  1 Mar 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QlpjN5Nc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73446995C;
	Fri,  1 Mar 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286742; cv=none; b=HTd1UXeqxoy/xxeeq6S+vCJkkn8RujlbybltHWW7J1cUsLINLjjo2d38VTxWUWcBoNykGaeQAxYSTQHcIUqsVYxXs+AVzKHHHwfG5vhuU1jPVKLeDF76DGEe6JBXLA8OctfNu5iKtXwDojajaDEQZQ4QeAnOHAB1xFdJgIiPdaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286742; c=relaxed/simple;
	bh=0eEAsDUiGlym1jRBLErLtOHPYKonoraS/Q/lwYdLL6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umiwyrmIKcrGdeV+FDewlvy7nZbWk8eYlMk5732kPxWE7uKtCbi0ngTrsmB9LLzqnps4OXoWJLUiZSjNxZlKm1W2v1ZureQIs1KnE7qDfp9PNQcF4KzbGjdoqAYjldaF00PQQZE3DKmXixI0tQS/w7h9dhKCLveg/LCjmc5/dGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QlpjN5Nc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709286738;
	bh=0eEAsDUiGlym1jRBLErLtOHPYKonoraS/Q/lwYdLL6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QlpjN5NcAeEwbGqu8RBj8FauZX1FwPsgaeROmXHEoWtABFUvUWIUbaBKxyeneagj+
	 1UMyEDl4P6erEOnJi3aTI2uM1hCwNRyrngSEcUGRVU0ADqgSHnhjKGJ2wkL0tIej5y
	 Leu0Qqm0fJ+NA7PsAPAlPG4hCRWAToti342lVzo/jtY3F07QE5naDvn17ZiHnKo0wv
	 tDob4iV+b+hgvM8LtksTiyL5m1Wt3SY6YUGeB/L3g0Q4UEHOa/KEUeKwliFIMsJ2vJ
	 ubUxB9KvFGIfD7PLvjj4SPMfjJN1ut8Doyf29CMphkVvKLctsGmaGV61XRH55wxG5k
	 093TghaWTwZKQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B50A037820C2;
	Fri,  1 Mar 2024 09:52:18 +0000 (UTC)
Date: Fri, 1 Mar 2024 10:52:17 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: =?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4=?= Prado <nfraprado@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Nathan Hebert <nhebert@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] media: mediatek: vcodec: support 36bit physical address
Message-ID: <20240301095217.bmsnizobpb736fgg@basti-XPS-13-9310>
References: <20240301020126.11539-1-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240301020126.11539-1-yunfei.dong@mediatek.com>

Hey Yunfei,

On 01.03.2024 10:01, Yunfei Dong wrote:
>The physical address is beyond 32bit for mt8188 platform, need
>to change the type from unsigned int to unsigned long in case of
>the high bit missing.

I would reword this a bit, the address is not beyond 32 bit, which would
could be interpret as if the address starts after 32nd bit, instead it
is larger than 32bits. Secondly, we don't change the type in case the
high bit is missing, we change the type unconditionally, we do change
the type so that the high bit isn't missing.

My suggestion:

The physical address on the MT8188 platform is larger than 32 bits,
change the type from unsigned int to unsigned long to be able to access
the high bits of the address.

One more question below...

>
>Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>---
> .../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c        | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
>index cf48d09b78d7..85df3e7c2983 100644
>--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
>+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
>@@ -1074,7 +1074,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
> 	unsigned int mi_row;
> 	unsigned int mi_col;
> 	unsigned int offset;
>-	unsigned int pa;
>+	unsigned long pa;
> 	unsigned int size;
> 	struct vdec_vp9_slice_tiles *tiles;
> 	unsigned char *pos;
>@@ -1109,7 +1109,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
> 	pos = va + offset;
> 	end = va + bs->size;
> 	/* truncated */
>-	pa = (unsigned int)bs->dma_addr + offset;
>+	pa = (unsigned long)bs->dma_addr + offset;

I can see in other parts of the driver that bs->dma_addr is converted to
u64 or uint64_t. Is unsigned long always 64-bit on the different
Mediatek platforms? If so, why do you prefer unsigned long over u64?
(Which describes the type more precisely)

(Same applies for:
drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c:452)

Greetings,
Sebastian

> 	tb = instance->tile.va;
> 	for (i = 0; i < rows; i++) {
> 		for (j = 0; j < cols; j++) {
>-- 
>2.18.0
>
>

