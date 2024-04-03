Return-Path: <linux-kernel+bounces-129722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685AA896EFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B36E1C25B70
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95113142E82;
	Wed,  3 Apr 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B2u3Aj7J"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CD91C683;
	Wed,  3 Apr 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147975; cv=none; b=CauaBvQN/sGjmfB26ys+nFkja71njZmAQLaJZm5Us3eSuWw845RUWo+wkrzHAQz/GhK3f2kQ1K/pK7baEknK5AmgAYYiVSP5HAB9Dml7vBefjUzHCSeG7hyLWRAOaDFfP3RynIVJYr+QroWIyhdYdDJVTdRCrJ0O2XMBpWtttDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147975; c=relaxed/simple;
	bh=56cFVVN36vdvA9j0k6U4c9Yyi7PsljXwFIP8sKfDAn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZPIWcFRd3dp1PjmeYMy3nTYvYtoUPLeXR0v4edGJYoDOVsiIJR+sZn6DWS8wFI3lhU3XHQHUINBR0DpTcBzfywvkX3A23qRZqfrO4qzyLJlJYJ4M2OBHs95Tw6qdn5Lc4ZNAptDkNbW26GTqbP5eVgxQJlJJlJ6U6ocoIRlZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B2u3Aj7J; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712147972;
	bh=56cFVVN36vdvA9j0k6U4c9Yyi7PsljXwFIP8sKfDAn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2u3Aj7JWJ8T2VlEkSysWrQyL+7YwxPLSHmUGGV4BCQp8UFuxEVhBu/+jKSjZtaER
	 vCqPQtjmwNfKZQbcMUePtxgVz+Kj6lPlMzM07fINBNnFf+6jGU+LlFRayM31Mee6jO
	 XuvzckZb1w9G7nOLmdyKUFnydK0J1mornC2SEZ+eBKyBG9MGasDoorQ1E6ijzyLNs6
	 ynJ4qR7K9G5Ho7qktbwUev0m2NHYsNYnU5F7PhHp6POrq4/5xNyXLkKGSkgt0Mib4z
	 YVajJb6UlXXb08K4lXDsHnTQ0hmKMZpZoRKAcrJ4tXGDyyYDrL77NcPxfclDI4Ercj
	 shje3a066P9Qw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C26C6378200D;
	Wed,  3 Apr 2024 12:39:31 +0000 (UTC)
Date: Wed, 3 Apr 2024 14:39:30 +0200
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
Subject: Re: [PATCH] media: mediatek: vcodec: fix the error sizeimage for
 10bit bitstream
Message-ID: <20240403123930.wkzgxb6lymzb7hng@basti-XPS-13-9310>
References: <20240403093018.13168-1-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240403093018.13168-1-yunfei.dong@mediatek.com>

Hey Yunfei,

On 03.04.2024 17:30, Yunfei Dong wrote:
>The sizeimage of each plane are calculated the same way for 8bit and

s/The sizeimage of each plane are/The sizeimage for each plane is/

>10bit bitstream. Need to enlarge the sizeimage with simeimage*5/4 for
>10bit bitstream when try and set fmt.

s/bitstream/bistreams/
s/Need to enlarge the sizeimage with simeimage*5/4 for 10bit bitstream when try and set fmt./
   Scale up the sizeimage by 25% for 10-bit bitstreams in try_fmt./

>
>Fixes: 9d86be9bda6c ("media: mediatek: vcodec: Add driver to support 10bit")
>Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>---
> .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 47 ++++++++++++++-----
> 1 file changed, 34 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
>index 9107707de6c4..45209894f1fe 100644
>--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
>+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
>@@ -259,6 +259,7 @@ static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx *ctx, struct v4l2_format *f,
> 		pix_fmt_mp->num_planes = 1;
> 		pix_fmt_mp->plane_fmt[0].bytesperline = 0;
> 	} else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>+		unsigned int dram_y, dram_c, dram_y_10bit, dram_c_10bit;
> 		int tmp_w, tmp_h;
>
> 		/*
>@@ -280,22 +281,42 @@ static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx *ctx, struct v4l2_format *f,
> 		    (pix_fmt_mp->height + 64) <= frmsize->max_height)
> 			pix_fmt_mp->height += 64;
>
>-		mtk_v4l2_vdec_dbg(0, ctx,
>-				  "before resize wxh=%dx%d, after resize wxh=%dx%d, sizeimage=%d",
>-				  tmp_w, tmp_h, pix_fmt_mp->width, pix_fmt_mp->height,
>-				  pix_fmt_mp->width * pix_fmt_mp->height);
>+		dram_y = pix_fmt_mp->width * pix_fmt_mp->height;
>+		dram_c = dram_y / 2;
>+
>+		dram_y_10bit = dram_y * 5 / 4;
>+		dram_c_10bit = dram_y_10bit / 2;

I'd skip the two 10 bit variables (dram_y_10bit & dram_c_10bit) and
instead do it like this:

```
   dram_stride = pix_fmt_mp->width;
   if (ctx->is_10bit_bitstream)
     dram_stride = dram_stride * 5 / 4;

   dram_y = dram_stride * pix_fmt_mp->height;
   dram_c = dram_y / 2;

   if (pix_fmt_mp->num_planes == 1) {
     pix_fmt_mp->plane_fmt[0].bytesperline = dram_stride;
     pix_fmt_mp->plane_fmt[0].sizeimage = dram_y + dram_c;
   } else {
     pix_fmt_mp->plane_fmt[0].bytesperline = dram_stride;
     pix_fmt_mp->plane_fmt[1].bytesperline = dram_stride;
     pix_fmt_mp->plane_fmt[0].sizeimage = dram_y;
     pix_fmt_mp->plane_fmt[1].sizeimage = dram_c;
     ...
   }
```

Also, why do you call all the variables dram?

Please this isn't tested, but shows the general direction to repeat a
lot less code.

Greetings,
Sebastian

>
> 		pix_fmt_mp->num_planes = fmt->num_planes;
>-		pix_fmt_mp->plane_fmt[0].sizeimage =
>-				pix_fmt_mp->width * pix_fmt_mp->height;
>-		pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width;
>-
>-		if (pix_fmt_mp->num_planes == 2) {
>-			pix_fmt_mp->plane_fmt[1].sizeimage =
>-				(pix_fmt_mp->width * pix_fmt_mp->height) / 2;
>-			pix_fmt_mp->plane_fmt[1].bytesperline =
>-				pix_fmt_mp->width;
>+		if (pix_fmt_mp->num_planes == 1) {
>+			if (ctx->is_10bit_bitstream) {
>+				pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width * 5 / 4;
>+				pix_fmt_mp->plane_fmt[0].sizeimage = dram_y_10bit + dram_c_10bit;
>+			} else {
>+				pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width;
>+				pix_fmt_mp->plane_fmt[0].sizeimage = dram_y + dram_c;
>+			}
>+		} else {
>+			if (ctx->is_10bit_bitstream) {
>+				pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width * 5 / 4;
>+				pix_fmt_mp->plane_fmt[1].bytesperline = pix_fmt_mp->width * 5 / 4;
>+
>+				pix_fmt_mp->plane_fmt[0].sizeimage = dram_y_10bit;
>+				pix_fmt_mp->plane_fmt[1].sizeimage = dram_c_10bit;
>+			} else {
>+				pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width;
>+				pix_fmt_mp->plane_fmt[1].bytesperline = pix_fmt_mp->width;
>+
>+				pix_fmt_mp->plane_fmt[0].sizeimage = dram_y;
>+				pix_fmt_mp->plane_fmt[1].sizeimage = dram_c;
>+			}
> 		}
>+
>+		mtk_v4l2_vdec_dbg(0, ctx,
>+				  "before resize:%dx%d, after resize:%dx%d, sizeimage=0x%x_0x%x",
>+				  tmp_w, tmp_h, pix_fmt_mp->width, pix_fmt_mp->height,
>+				  pix_fmt_mp->plane_fmt[0].sizeimage,
>+				  pix_fmt_mp->plane_fmt[1].sizeimage);
> 	}
>
> 	pix_fmt_mp->flags = 0;
>-- 
>2.25.1
>

