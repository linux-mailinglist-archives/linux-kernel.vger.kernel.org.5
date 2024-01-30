Return-Path: <linux-kernel+bounces-44496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021DC8422D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CA51F22A05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2266A35B;
	Tue, 30 Jan 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qafc92t5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D61664D3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613576; cv=none; b=TZo0ncA3v1Eag5p/JCt2p5Bp503/mWL+gQ8XSeErNh0PhpHQ4aetUrnUF9Is5sNgadfDT5/rdGNfB0K9CGV0njlPIJHz4buuvBs0ZQP/xLWbcRi6DckqmA0SzlAoG78WCn7NKZkZrW2/k88hBbQTSLHXx2msY8u40Bf424baU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613576; c=relaxed/simple;
	bh=QsmMvdygEzykc/sigoFHqJXzg33HVkZ+pgYlsBhHams=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekrfw3V33HLDMqvOtFNb5nyLGAOVRuAvte4Y3Nz88eDId9ZRMJlP69j4T2Fz0VZrNfh54sJ2hryml5Sq1/xF74FCyLgVqJSFA5YqYpqCPuaGK+S47iWPNzPUkpNkXk+k3QlciaUQucfeGihVjkOIYnArAKPa8B8m5m0nW4qPTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qafc92t5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613573;
	bh=QsmMvdygEzykc/sigoFHqJXzg33HVkZ+pgYlsBhHams=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qafc92t5mUfWNoHkO4pzlKcIqlcsJSEfVnIvGZCqMXYCTHgibJYm/XEGYWztFAtz4
	 H23b7iwyyg3hrRS/UWcKZTt3mhs2kAAwzMcNZjPaKqCTSPRwoYCPT2pox0pujSH63i
	 bupyE3ezU/ylG/r8jQV4f57N29GqleERwqh9ocn+Y0QeamVWFyMkPVNi7kr2oEXvsV
	 Ssj3B406/aGsy402OJsC1hDkkNXn0xyQ/nSzqk4PU6sDk+OOGTLmboyIwMUOK6/0CJ
	 eHCgvsn3EPZDgakogJil9lWDCEYlix1alHZlHyn/N9MQVCMaiVphqTeRdyZtAW+C1W
	 URIHohc3FZ7VQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8DCDE3782051;
	Tue, 30 Jan 2024 11:19:32 +0000 (UTC)
Message-ID: <98c8da0f-efe8-4ce0-8534-106114141cba@collabora.com>
Date: Tue, 30 Jan 2024 12:19:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] soc: mediatek: mtk-socinfo: Add extra entry for
 MT8183
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 William-tw Lin <william-tw.lin@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 William-tw Lin <william-tw.lin@mediatek.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20240130095656.3712469-1-wenst@chromium.org>
 <20240130095656.3712469-3-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240130095656.3712469-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/01/24 10:56, Chen-Yu Tsai ha scritto:
> The MT8183 has another socinfo match, with the second cell only
> differing by one bit. Add it to the driver.
> 
> Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting chip information")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/soc/mediatek/mtk-socinfo.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
> index 3909d22062ce..42572e8c1520 100644
> --- a/drivers/soc/mediatek/mtk-socinfo.c
> +++ b/drivers/soc/mediatek/mtk-socinfo.c
> @@ -45,6 +45,7 @@ static const char *cell_names[MAX_CELLS] = {"socinfo-data1", "socinfo-data2"};
>   static struct socinfo_data socinfo_data_table[] = {
>   	MTK_SOCINFO_ENTRY("MT8173", "MT8173V/AC", "MT8173", 0x6CA20004, 0x10000000),
>   	MTK_SOCINFO_ENTRY("MT8183", "MT8183V/AZA", "Kompanio 500", 0x00010043, 0x00000840),
> +	MTK_SOCINFO_ENTRY("MT8183", "MT8183V/AZA", "Kompanio 500", 0x00010043, 0x00000940),

Are you sure that 0x940 is the same MT8183V/AZA?

Added William-tw to the loop; MediaTek, can you please confirm, and please say why,
there are two MT8183V/AZA with two different ChipIDs?

Thanks,
Angelo

>   	MTK_SOCINFO_ENTRY("MT8186", "MT8186GV/AZA", "Kompanio 520", 0x81861001, CELL_NOT_USED),
>   	MTK_SOCINFO_ENTRY("MT8186T", "MT8186TV/AZA", "Kompanio 528", 0x81862001, CELL_NOT_USED),
>   	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/AZA", "Kompanio 830", 0x81880000, 0x00000010),



