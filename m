Return-Path: <linux-kernel+bounces-81389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B0867548
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121901F261EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7EF127B69;
	Mon, 26 Feb 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Gikzga5N"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CA8528C;
	Mon, 26 Feb 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951166; cv=none; b=uK0iWb7QMK8VJU+ZlWkbuLvSTTDVtnnR8S+HtBq5Fzz4bLcXnOwu6jnpWoMj2VQ7akt+5rrjtOe7nybCof6C8Kigll56Do/RWCW+CudRdTBZwrbL7FNBsBmJDlf4WhjpZbIPZlxPGeuStlCZSOOFLLNQWN0A/LGfzAfySCOTkYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951166; c=relaxed/simple;
	bh=leBMz78ecPcrLpo4jWp3OD2kzCaYPdWixO79WpUqSTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbA1nM7pFl1logHc/cn4IozqU0rwpmS+jLLuuqF9a66CtPhMg4MHadwBKVAWwrU3q67jhPoJ6/WL5Q2O0AnVDsfE/4DqgVZlKUa6QCKd+uMzU+aM8+NBkWLSVAFkpkq7I8MQkhjTMlG7QThY1sZ0rpV3Meo9V5mSMo0MyLN+1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Gikzga5N; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708951163;
	bh=leBMz78ecPcrLpo4jWp3OD2kzCaYPdWixO79WpUqSTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gikzga5Nt88vHmKjoR02aYiPPaAHIRYRQMo9buItMr0k0CQLXw0R1p7nC7BhBButD
	 LsRc+BAhk3TlmKPkZFGSylmBpz59zUSg3eSF0MkgWANZLJizPexryHbslpF4nK2Gyy
	 jAsBdWAPNjSy4sg3IrlEglDI+Y1p3dG16ow44t6gSkXumnxA8D4TeYq/yBbnxmfveX
	 H8OOoZQUOg4uZgUBK+9kY8RrOdhZ+/ERUPiSwLxx4yZK/v3m5Iqg0v9RoSL+AF511u
	 wA9raKJC59MDuOye2oSGEA+DXQMl5pu9x51arabwGJzW+XeLq5mUTl+g5N3HelrK9k
	 YRS2BNoVv2PvA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0AE7F37803EE;
	Mon, 26 Feb 2024 12:39:21 +0000 (UTC)
Message-ID: <db96c6cb-2d7c-4a9e-8763-d2055da3a442@collabora.com>
Date: Mon, 26 Feb 2024 13:39:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] drm/mediatek: Rename "mtk_drm_plane" to "mtk_plane"
Content-Language: en-US
To: Shawn Sung <shawn.sung@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
 <20240226085059.26850-4-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226085059.26850-4-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 09:50, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename all "mtk_drm_plane" to "mtk_plane":
> - To align the naming rule
> - To reduce the code size
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>


