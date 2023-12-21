Return-Path: <linux-kernel+bounces-8299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EFD81B520
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5569B1C24F84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA316E2A1;
	Thu, 21 Dec 2023 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TFM05tf5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37F31DA3B;
	Thu, 21 Dec 2023 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703158988;
	bh=Ooyo7cFIzcwmmqODzrdGSMJ0PnUsddzGotcXVunWRCw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TFM05tf5xJkbcJ5fK+qrJ+/xhaHuaVmjqxZtkCf6cdSJQAqC4cLGxctKfwlPGPKNN
	 SD5/G6nie/n/3szGdDCTnMaTlop4alnGMC0YqrOpVil47QEw605kL7fknTx+mkFUZH
	 a5jAfz/3KKcym43ySHes4MqKmwz4l9i1831yMbDIIcLgKr+o4q587s1H9+vmhOYK82
	 bUVhYYObnb2fYERFLOwreaFSJyTyroAtCGB+33HFuuoWu/VSHzBrlvtFCGmwbEOItd
	 lX5I/KoatFr56yhZz3M9WZJ5T2j7OM4To9gsMW8v3201z3pUjhcF8/Unkd/BhOucNO
	 0RKX9tB/YS4rw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2866D3781FC9;
	Thu, 21 Dec 2023 11:43:07 +0000 (UTC)
Message-ID: <e822fa39-ba03-4816-a58e-a8328c39e051@collabora.com>
Date: Thu, 21 Dec 2023 12:43:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] media: mediatek: vcodec: Update
 mtk_vcodec_mem_free() error messages
Content-Language: en-US
To: Fei Shao <fshao@chromium.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231221092226.1395427-1-fshao@chromium.org>
 <20231221092226.1395427-3-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231221092226.1395427-3-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/12/23 10:17, Fei Shao ha scritto:
> In mtk_vcodec_mem_free(), there are two cases where a NULL VA is passed:
> - mem->size == 0: we are called to free no memory. This may happen when
>    we call mtk_vcodec_mem_free() twice or the memory has never been
>    allocated.
> - mem->size > 0: we are called to free memory but without VA. This means
>    that we failed to free the memory for real.
> 
> Both cases are not expected to happen, and we want to have clearer error
> messages to describe which one we just encountered.
> Update the error messages to include more information for that purpose.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



