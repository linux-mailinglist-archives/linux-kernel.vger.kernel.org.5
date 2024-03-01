Return-Path: <linux-kernel+bounces-88139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D286DDCF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C412B221DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2D36A33A;
	Fri,  1 Mar 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BOr0fTGx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C506A014;
	Fri,  1 Mar 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283832; cv=none; b=qbyRyF/30GDh5XYMoG+eZq8Nywysxpf9Ewq5OZARR1CYboPkP+kc6YymEOO88ZwQnPK/wBp9cWIaRwsGFT0Pi4nlE4LpB6s37GtqhhbjvoREdm/bpjmKxu0FJZRmN0/3d/pI1SA8ZziB3ly04apiF1S8BHRFX88CD39g9VfOEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283832; c=relaxed/simple;
	bh=hkf4tHhd3AClvUxsa8LdGdo131B48+hG3jkXyZorL0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzYwbMDRGvuNrdXpYXTmjLchfMkA3weFUF0FSJuBfY6GH3nkgDvaaEz57HDRJwex3xMQHxQ0lyFzHt9xmQ29rsd4IQw/NpTiVRhyz+/oouDHa38K9baT91lcsGSHf2CFxvP5O7k/IsTDa+b6e7CL8NezVPK/jXxpBKBeYF1GWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BOr0fTGx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709283829;
	bh=hkf4tHhd3AClvUxsa8LdGdo131B48+hG3jkXyZorL0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BOr0fTGxd8buRCpSPVkD7hu6KavyqqEhPT+mNOfdzEy1d0+snnGQPf+Tv/C1nPpA/
	 efQNQ/RBTEqjxVoi22f/+U2sx9HEFVfKfqN/aaJy2JNwiZSoNSEan7dv2qxJeq7g4T
	 T3v0G60DqpvGaNRee0haVGps28lrNC1QSV6/YW+v03iIy1bL4O8JllqEOfdskxvysF
	 FMUTmc+PZdcbIQXbAAJ8P6WMxdJ86ABFc4AVz0clDEUO9QMRC28kUUpeNQPDSL0PwU
	 TaVr3OfJt+Kfl2t6AqtP3589GiRQon6ApVy/AG6Zq+d+sZ/cPv5yiiT/7NDjZ5Gvwz
	 d1Rb4OoDlH9dA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4F88637814A4;
	Fri,  1 Mar 2024 09:03:48 +0000 (UTC)
Message-ID: <ea7f25bf-2294-4ad4-bc18-226827d49ae8@collabora.com>
Date: Fri, 1 Mar 2024 10:03:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: mediatek: vcodec: support 36bit physical address
Content-Language: en-US
To: Yunfei Dong <yunfei.dong@mediatek.com>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Nathan Hebert <nhebert@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240301020126.11539-1-yunfei.dong@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301020126.11539-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/03/24 03:01, Yunfei Dong ha scritto:
> The physical address is beyond 32bit for mt8188 platform, need
> to change the type from unsigned int to unsigned long in case of
> the high bit missing.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c        | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> index cf48d09b78d7..85df3e7c2983 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> @@ -1074,7 +1074,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
>   	unsigned int mi_row;
>   	unsigned int mi_col;
>   	unsigned int offset;
> -	unsigned int pa;
> +	unsigned long pa;

If you used the right type from the beginning, you wouldn't have to fix that ;-)

Is there any reason why you didn't - and still don't use the `phys_addr_t` type
for the `pa` member?

Cheers,
Angelo

>   	unsigned int size;
>   	struct vdec_vp9_slice_tiles *tiles;
>   	unsigned char *pos;
> @@ -1109,7 +1109,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
>   	pos = va + offset;
>   	end = va + bs->size;
>   	/* truncated */
> -	pa = (unsigned int)bs->dma_addr + offset;
> +	pa = (unsigned long)bs->dma_addr + offset;
>   	tb = instance->tile.va;
>   	for (i = 0; i < rows; i++) {
>   		for (j = 0; j < cols; j++) {



