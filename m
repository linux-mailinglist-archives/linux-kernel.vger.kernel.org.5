Return-Path: <linux-kernel+bounces-8300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E025D81B522
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946301F24B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB43E6E5AF;
	Thu, 21 Dec 2023 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p0qj3aYa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003C6BB47;
	Thu, 21 Dec 2023 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703158989;
	bh=sBcVhTPX0KzScwCba4WSn6p7nU4vpZvw5YuVMBcWBiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p0qj3aYadHaObYFgJ2vmkd7YL0aKtYQn2VGHuLDLMP4mDbmINeIPiy6mK5vCbP+BY
	 up+B1qook3kf5upNHyLxnVxl3sGgCsL6XnwFrfrk2252JvuYfRqtTr1YTzxzNvfH/F
	 Ie2zci91+urTkSa/yIttc6HEDUQwU+mL2C49m2z6JzAxxEF4XWK59FymGvOgsZD1ax
	 nmEmBZL0IiULWlC9gcH5is/mzRk/orFlm5eQc8N9IU4mxieYw6iXzplTbxtDq5D6ME
	 CnJGLUES6MSBM20ns5PGXdkHfcfT8NyuRL/Dgwm13CRannr33c/lrLYqC8lcxwybcu
	 DOw+IWzDDd0TA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5EF593781FFE;
	Thu, 21 Dec 2023 11:43:08 +0000 (UTC)
Message-ID: <d962815b-087d-4851-b6f0-981531149be9@collabora.com>
Date: Thu, 21 Dec 2023 12:43:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] media: mediatek: vcodec: Only free buffer VA that
 is not NULL
Content-Language: en-US
To: Fei Shao <fshao@chromium.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231221092226.1395427-1-fshao@chromium.org>
 <20231221092226.1395427-4-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231221092226.1395427-4-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/12/23 10:17, Fei Shao ha scritto:
> In the MediaTek vcodec driver, while mtk_vcodec_mem_free() is mostly
> called only when the buffer to free exists, there are some instances
> that didn't do the check and triggered warnings in practice.
> 
> We believe those checks were forgotten unintentionally. Add the checks
> back to fix the warnings.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



