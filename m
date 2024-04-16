Return-Path: <linux-kernel+bounces-146451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B83B8A657D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAF11C223FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B218526E;
	Tue, 16 Apr 2024 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ndXtNV3h"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5267FBBA;
	Tue, 16 Apr 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254127; cv=none; b=karfiswCWIucZOimuSRS36iFdiPgR21q/mGA9lb3LJywpzOyUB2hvTgsn8ykMZSl6UDMZTkV5mdFO59tSTLwhXaIuYvaoeDWF06fot9iiNyWNRPLBvGnM69iumeskf9sFM+vvFAE4OSeGEip6aF5xoQ75EW2H263wBbG5Pv9zV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254127; c=relaxed/simple;
	bh=/N51T8HnLQj9KU4DpUIGD0F8mipJ+bMfeUuzlyssn4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kc6qQ/LI6G9IJEkqq1sN1EUfQNSr4g+N1mqzyEmnd5JhAuw57jRjwSycZAOqC7w20hg4rYmj/AZaRVu9z6nUDR6Ybob6k3ZhS39b9LrWk9Zcrr8cKeSq1Bk8EDfNvWGjESw5d5CgWJflHbxBA6G7GeBltt51MAamEUi9h+VupkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ndXtNV3h; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713254119;
	bh=/N51T8HnLQj9KU4DpUIGD0F8mipJ+bMfeUuzlyssn4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ndXtNV3hcFpkcNYJo8JuG7v+O3l6lDGNurA3lFy6h2pDZZGy9mMH3RXI7tSDsSIoj
	 tf1QBfxFe2Mn0z9lpqVd8FGPlQRwoosatdNvPrBeSuv00uqnC5Gh6FZrn2Gtm/GakO
	 idCukbxDYZrkjXV6mPP68/W6HO5+IwyITWJop/zr8XtkX82mWjBIWazunwNrfln70x
	 o/UV/Qb6phNaxfZVtlYpsh21k0glAS8aO1MjzFDKMcxpRgnwfPmFykO8GgQ2YJvvTt
	 4KJS4xnwBWGnKM37nTdEFYVoGo1F6cxlixLcN7vhV9FGQE25OjAVAD4luS1nHCFjkd
	 /u/9FsyQeCQzw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 225CB37804B2;
	Tue, 16 Apr 2024 07:55:18 +0000 (UTC)
Message-ID: <4d60e9e4-9eae-4b0a-abb2-b1ad3d278fc9@collabora.com>
Date: Tue, 16 Apr 2024 09:55:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-boost-crypt property
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "avri.altman@wdc.com" <avri.altman@wdc.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
 <20240415110012.148871-4-angelogioacchino.delregno@collabora.com>
 <c9634a286fbdb4c98a7fe6703a4eb10d66dfcb9e.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <c9634a286fbdb4c98a7fe6703a4eb10d66dfcb9e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 16/04/24 09:03, Peter Wang (王信友) ha scritto:
> On Mon, 2024-04-15 at 13:00 +0200, AngeloGioacchino Del Regno wrote:
>> There is no need to have a property that activates the inline crypto
>> boost feature, as this needs many things: a regulator, three clocks,
>> and the mediatek,boost-crypt-microvolt property to be set.
>>
>> If any one of these is missing, the feature won't be activated,
>> hence, it is useless to have yet one more property to enable that.
>>
>> While at it, also address another two issues:
>> 1. Give back the return value to the caller and make sure to fail
>>     probing if we get an -EPROBE_DEFER or -ENOMEM; and
>> 2. Free the ufs_mtk_crypt_cfg structure allocated in the crypto
>>     boost function if said functionality could not be enabled because
>>     it's not supported, as that'd be only wasted memory.
>>
>> Last but not least, move the devm_kzalloc() call for
>> ufs_mtk_crypt_cfg
>> to after getting the dvfsrc-vcore regulator and the boost microvolt
>> property, as if those fail there's no reason to even allocate that.
>>
>> Fixes: ac8c2459091c ("scsi: ufs-mediatek: Decouple features from
>> platform bindings")
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/ufs/host/ufs-mediatek.c | 55 ++++++++++++++++++-------------
>> --
>>   1 file changed, 30 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-
>> mediatek.c
>> index 688d85909ad6..47f16e6720f4 100644
>> --- a/drivers/ufs/host/ufs-mediatek.c
>> +++ b/drivers/ufs/host/ufs-mediatek.c
>> @@ -575,51 +575,55 @@ static int ufs_mtk_init_host_clk(struct ufs_hba
>> *hba, const char *name,
>>   	return ret;
>>   }
>>   
>> -static void ufs_mtk_init_boost_crypt(struct ufs_hba *hba)
>> +static int ufs_mtk_init_boost_crypt(struct ufs_hba *hba)
>>   {
>>   	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
>>   	struct ufs_mtk_crypt_cfg *cfg;
>>   	struct device *dev = hba->dev;
>>   	struct regulator *reg;
>>   	u32 volt;
>> -
>> -	host->crypt = devm_kzalloc(dev, sizeof(*(host->crypt)),
>> -				   GFP_KERNEL);
>> -	if (!host->crypt)
>> -		goto disable_caps;
>> +	int ret;
>>   
>>   	reg = devm_regulator_get_optional(dev, "dvfsrc-vcore");
>>   	if (IS_ERR(reg)) {
>> -		dev_info(dev, "failed to get dvfsrc-vcore: %ld",
>> -			 PTR_ERR(reg));
>> -		goto disable_caps;
>> +		ret = PTR_ERR(reg);
>> +		if (ret == -EPROBE_DEFER)
>> +			return ret;
>> +
>> +		return 0;
>>   	}
>>   
>> -	if (of_property_read_u32(dev->of_node, "mediatek,boost-crypt-
>> microvolt",
>> -				 &volt)) {
>> +	ret = of_property_read_u32(dev->of_node, "mediatek,boost-crypt-
>> microvolt", &volt);
>> +	if (ret) {
>>   		dev_info(dev, "failed to get mediatek,boost-crypt-
>> microvolt");
>> -		goto disable_caps;
>> +		return 0;
>>   	}
>>   
>> +	host->crypt = devm_kzalloc(dev, sizeof(*host->crypt),
>> GFP_KERNEL);
>> +	if (!host->crypt)
>> +		return -ENOMEM;
>> +
>>
> 
> Hi Angelo,
> 
> If retrun -ENOMEN, host will init fail.
> But previous is skip boost crypt feature only.
> It change the driver behavior.
> 

This is fully intentional: if a platform supports boost-crypt, this means that the
feature *MUST* be enabled, and must *not* be disabled if a memory allocation fails,
as that is relative to available pages at boot, and not to SoC feature support.

Keep in mind that the allocation was moved to *after* checking if such platform
does indeed support the boost-crypt feature, and it is critical to FAIL probing
if there was no memory to allocate the host->crypt structure.

> 
> 
> 
>>   	cfg = host->crypt;
>> -	if (ufs_mtk_init_host_clk(hba, "crypt_mux",
>> -				  &cfg->clk_crypt_mux))
>> -		goto disable_caps;
>> +	ret = ufs_mtk_init_host_clk(hba, "crypt_mux", &cfg-
>>> clk_crypt_mux);
>> +	if (ret)
>> +		goto out;
>>   
>> -	if (ufs_mtk_init_host_clk(hba, "crypt_lp",
>> -				  &cfg->clk_crypt_lp))
>> -		goto disable_caps;
>> +	ret = ufs_mtk_init_host_clk(hba, "crypt_lp", &cfg-
>>> clk_crypt_lp);
>> +	if (ret)
>> +		goto out;
>>   
>> -	if (ufs_mtk_init_host_clk(hba, "crypt_perf",
>> -				  &cfg->clk_crypt_perf))
>> -		goto disable_caps;
>> +	ret = ufs_mtk_init_host_clk(hba, "crypt_perf", &cfg-
>>> clk_crypt_perf);
>> +	if (ret)
>> +		goto out;
>>   
>>   	cfg->reg_vcore = reg;
>>   	cfg->vcore_volt = volt;
>>   	host->caps |= UFS_MTK_CAP_BOOST_CRYPT_ENGINE;
>>   
>> -disable_caps:
>> -	return;
>> +out:
>> +	if (ret)
>> +		devm_kfree(dev, host->crypt);
>> +	return 0;
>>   }
>>   
>>   static int ufs_mtk_init_va09_pwr_ctrl(struct ufs_hba *hba)
>> @@ -648,8 +652,9 @@ static int ufs_mtk_init_host_caps(struct ufs_hba
>> *hba)
>>   	struct device_node *np = hba->dev->of_node;
>>   	int ret;
>>   
>> -	if (of_property_read_bool(np, "mediatek,ufs-boost-crypt"))
>> -		ufs_mtk_init_boost_crypt(hba);
>> +	ret = ufs_mtk_init_boost_crypt(hba);
>> +	if (ret)
>> +		return ret;
>>   
> 
> Most ufs-mediatek platform dosen't need "mediatek,ufs-boost-crypt"
> Remove this property will casue most platform try error and add init
> latency.
> 

Yes this causes -> less than half of a millisecond <- of additional boot time
if the dvfsrc-supply is present but boost-microvolt is not.

I really don't see the problem with that :-)

Regards,
Angelo

> Thanks.
> Peter
> 
> 
> 
>>   	ret = ufs_mtk_init_va09_pwr_ctrl(hba);
>>   	if (ret)


