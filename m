Return-Path: <linux-kernel+bounces-44499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873BF8422DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AF91F210D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979A9605B1;
	Tue, 30 Jan 2024 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CEOYJzCs"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C545BE7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613650; cv=none; b=lmc3W6y68kNTkYU/FyqYp/n7UbrC1UU+YrCqyrs8Epjl0XYYCtqf/UgfIqn3KSGwAz5ya11x9XV2RjKB7QfplqEzxxCe7c49e2Yf8SRzZeBumDONEBqMz7ThEnPTQefDfYM/f0Tu0YmFyNZBavjtDkjls0rYN4yLhjAUh1zZAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613650; c=relaxed/simple;
	bh=nOtEkQkKnVv5uTMuTYFwuhOtca6YIW7z2/cNVod3Uzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPMAt+lWp800KELWVIIjXDwpp5UHtxIAfEbPkhonDGtoXwBh5BHZDHGMuDhPgWJygF6r8wASx2ZCiqI8ZqXJvjhtTruQU2FkHgjc84CDuQ9TW6FntBTXIhfA/4zslQHqSMXLtaPEhm4pdcP5cbv4SNXNuVMYlhqLqugOPhecLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CEOYJzCs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613647;
	bh=nOtEkQkKnVv5uTMuTYFwuhOtca6YIW7z2/cNVod3Uzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CEOYJzCsf0kVz3Ts+/SIpv0NuvvZzXyl9nTzvVIkDBqfZHtnSShINYyvmUCdhTcEi
	 d8v4EhxpDdgdACJ5kxNwyFvvXhvR/m1ofeNvP8uAUaaptw/F2DlpVoTDs1bMYOk/LP
	 aPOlw7bAwbNb3Hx1si3ZUHrULL9BYiWQb1PcccZjqW6J1MaIr7j0Rd1qItHhZlSnbK
	 +d+73z5rxqX4DqBeYrtl/xLDxzQJPeSjh5KFYVSL8A14wzZpLEY8qrr+UsuloObDg+
	 Huxrt3h2F464/Lbi8FKrjW1xjkGzBP8237yAzFnli1VVfV2qWj9sBpJk84sm8y+ocC
	 i48k7fvvMdVXg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 674023782068;
	Tue, 30 Jan 2024 11:20:47 +0000 (UTC)
Message-ID: <068e98bb-c4c3-4c50-83b3-a6c999abc1ff@collabora.com>
Date: Tue, 30 Jan 2024 12:20:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] soc: mediatek: mtk-socinfo: Clean up NVMEM cell read
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 William-tw Lin <william-tw.lin@mediatek.com>
References: <20240130095656.3712469-1-wenst@chromium.org>
 <20240130095656.3712469-2-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240130095656.3712469-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/01/24 10:56, Chen-Yu Tsai ha scritto:
> The mtk-socinfo grabs the NVMEM device devm_nvmem_device_get(), but then
> proceeds to put the device directly with nvmem_device_put() if the read
> is successful. If the device fails to probe and goes through the devres
> release path, the device would be put a second time, triggering a
> use-after-free error from KASAN.
> 
> Fix this by dropping the devres part. Since the NVMEM cell data is read
> only once, there is no need to keep the reference around.
> 
> While at it, clean up the function to directly reference the NVMEM
> device node and use that to find the NVMEM device, instead of finding it
> by name, which is more fragile. The cell node is always a direct child
> of the NVMEM device node, courtesy of the legacy NVMEM cell layout. Thus
> of_get_child_by_name() is a better way of finding the cell. Last,
> correctly put the device node once its use is over.
> 
> Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting chip information")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



