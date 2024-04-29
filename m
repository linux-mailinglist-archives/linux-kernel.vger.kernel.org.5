Return-Path: <linux-kernel+bounces-161893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6A18B52D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF08FB20C08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1C1757D;
	Mon, 29 Apr 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DBlSfx9a"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E415E86;
	Mon, 29 Apr 2024 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378106; cv=none; b=JIeyGRgs87OtbaDWcGL3Jx2d7eNmqtQTlNWvC1aj4HCXKtvS8iBEhyZXsOGmamT2pw2twn15HKqriUPGNlHwhtlierPhBQ8Cdq23FESBdqe/nhLkZJjScMststfdaW/ukBYQtzfuFKZoFYK3n5roIMmBcbPhn5bvNlvRKNtlgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378106; c=relaxed/simple;
	bh=pTjfAPq13MjrIZFyd2W2RPgVaYx79/VZ4aaxirIjUNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cslCTY9/iPPQJ6RJx8IAzimkzl8WZIQe6C0cvDd73L5HAL9lCu1IHjYwwJTJoCwqKhUhrxJfh6HXukUeqCmnV42WCe57BGpbSFoQgi89ktBP70O04noT83P9SrsSrjMlu+5ZPaZ/OtAa+IpFxzK09SIyzUTfGp6MjpkQrJjs3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DBlSfx9a; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714378102;
	bh=pTjfAPq13MjrIZFyd2W2RPgVaYx79/VZ4aaxirIjUNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DBlSfx9abwJOPEHMh/Y9whzwSrts1w/5CpjQJgw9zT6GTidmxkP6wlsMfPqxek9nz
	 o0H9CpCNFL6/kWNK1gyPD0An9BQVGGlTtQ15KNZgskWP9ZCM0tbnX8igIDccg4fzxQ
	 lpgMVYh92QIS4eiMxfG7vB82HC+yvpnSyutXs5ztyNBooLWmqksPWsnf2EpHs06NSG
	 GqRHvwb6nmL30/e9cx3IzTuuMZDWBEv6v4HQtkzuPWfqqewqFlCgAGu6U/vAxpHqJZ
	 qaO3mPFhIqNU5BNzIzTR6e22k4663rQq21eLqYmT8qHuuXbd+nAPv/XM7lcC6kPYFL
	 WrpS4Pt2noJVA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 74902378134F;
	Mon, 29 Apr 2024 08:08:21 +0000 (UTC)
Message-ID: <57529d24-8b46-4eed-95ed-463ad3f4190e@collabora.com>
Date: Mon, 29 Apr 2024 10:08:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] soc: mediatek: Add MediaTek DVFS Resource
 Collector (DVFSRC) driver
To: Nathan Chancellor <nathan@kernel.org>
Cc: djakov@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
 henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org, amergnat@baylibre.com,
 Dawei Chien <dawei.chien@mediatek.com>
References: <20240424095416.1105639-1-angelogioacchino.delregno@collabora.com>
 <20240424095416.1105639-5-angelogioacchino.delregno@collabora.com>
 <20240424190405.GA2803128@dev-arch.thelio-3990X>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240424190405.GA2803128@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/04/24 21:04, Nathan Chancellor ha scritto:
> Hi Angelo,
> 
> On Wed, Apr 24, 2024 at 11:54:13AM +0200, AngeloGioacchino Del Regno wrote:
>> The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
>> Hardware module used to collect all the requests from both software and the
>> various remote processors embedded into the SoC and decide about a minimum
>> operating voltage and a minimum DRAM frequency to fulfill those requests in
>> an effort to provide the best achievable performance per watt.
>>
>> This hardware IP is capable of transparently performing direct register R/W
>> on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
>>
>> This driver includes support for MT8183, MT8192 and MT8195.
>>
>> Co-Developed-by: Dawei Chien <dawei.chien@mediatek.com>
>> [Angelo: Partial refactoring and cleanups]
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ...
>>   drivers/soc/mediatek/mtk-dvfsrc.c        | 551 +++++++++++++++++++++++
> ...
>> +#define KBPS_TO_MBPS(x)			((x) / 1000)
> ...
>> +static void __dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u32 reg,
>> +				    u16 max_bw, u16 min_bw, u64 bw)
>> +{
>> +	u32 new_bw = (u32)div_u64(KBPS_TO_MBPS(bw), 100);
>> +
>> +	/* If bw constraints (in mbps) are defined make sure to respect them */
>> +	if (max_bw)
>> +		new_bw = min(new_bw, max_bw);
>> +	if (min_bw && new_bw > 0)
>> +		new_bw = max(new_bw, min_bw);
>> +
>> +	dvfsrc_writel(dvfsrc, reg, new_bw);
>> +}
> 
> Using KBPS_TO_MBPS here results in
> 
>    ERROR: modpost: "__aeabi_uldivmod" [drivers/soc/mediatek/mtk-dvfsrc.ko] undefined!
> 
> when building ARCH=arm allmodconfig with clang. I did not check to see
> if this is visible with GCC but if it is not, it is only because GCC
> implements certain transformations for constant division that clang may
> or may not have implemented (there was some work on getting all
> transformations that GCC has supported in clang as well but I do not
> think was ever completed). Perhaps KBPS_TO_MBPS() should be dropped and
> the new_bw assignement turned into
> 
>    u32 new_bw = (u32)div_u64(bw, 100 * 1000); /* Multiply divisor by 1000 to convert bw from Kbps to Mbps */

Thanks, I honestly didn't check clang.

Your suggestion looks good, I'll do exactly that.

Cheers!
Angelo

> 
> or something like that.
> 
> Cheers,
> Nathan


