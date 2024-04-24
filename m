Return-Path: <linux-kernel+bounces-156900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDEE8B0A17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C7228676E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0BA15B12E;
	Wed, 24 Apr 2024 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LBcehXwz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE33398A;
	Wed, 24 Apr 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963187; cv=none; b=YE1BsOuteflJiT7gDIuBymF7J4K/oNpptgWgPyLLXVcvomZ65TB4pw9kF7aS96je6H5zYIbLYLu/+xg3/V51BDP+dDKxS4KYFbzy/uTVl/Op7NsKmmsJDC8fDzDINVNL5qbQNsDVmDzYEioBEN/1BqyzgoXoqAcCRggLfPwWeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963187; c=relaxed/simple;
	bh=JSqiDgDbyjkgKn+XJMpRiyYF7Ww8VBzY6JarthfyaiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1WxAxqD288FlgdNXcKoqKtPU7BgX48kQx3IOCNx+GwZKyPLJ7r2r9ZrG7iYuV6knXQTSz8kaPOwvuGlZ1mzLanda9Grr0qsC/Hl8dee8Pko47ax0hEBXivwRXH12jRXtj/STiKFiHCknnxBhVlFrXdqO876FAXrekJfJ+ccv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LBcehXwz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713963183;
	bh=JSqiDgDbyjkgKn+XJMpRiyYF7Ww8VBzY6JarthfyaiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LBcehXwzofAel3lzY+NnDkrkkkQrbfH2otP/FBGJwq5UniuYmJCgcuciYq/mPhC6j
	 BZJUmJoEKBUGCOWvs+8VDn09IJo2GagaeKicgotOgdRDBOMmtRmzZH+u/Kdg8RFdtA
	 0zvZU8WEAlu5Hc7XjWZZimdl0nQYSDXsnAH8Y8LFCuRcY7y1N4CZ36Jo88ZmNc/c+0
	 tZlrYl2fB3zgqaviTQe0zDpdymxdU+4aGcPmZGveVk7vrILViZggA68fbEeDoFZ/Ad
	 M/7GVTHBED4ss4LKoF/fmYWk7/BV8CjmkhRFTwshN8TX4aa3FUYJfp/6oTmcgIOTpx
	 Hv88iwW+Odv0A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CBC3937820F9;
	Wed, 24 Apr 2024 12:53:02 +0000 (UTC)
Message-ID: <6bd66ba2-7fcc-4981-a2cd-d4500540da76@collabora.com>
Date: Wed, 24 Apr 2024 14:53:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] regulator: Add refactored mtk-dvfsrc-regulator
 driver
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: amergnat@baylibre.com, broonie@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, djakov@kernel.org, gustavoars@kernel.org,
 henryc.chen@mediatek.com, keescook@chromium.org, kernel@collabora.com,
 krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 matthias.bgg@gmail.com, robh@kernel.org, wenst@chromium.org
References: <20240424095416.1105639-1-angelogioacchino.delregno@collabora.com>
 <20240424095416.1105639-7-angelogioacchino.delregno@collabora.com>
 <93c12354-2e4d-4b21-bc96-eeb55442e365@wanadoo.fr>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <93c12354-2e4d-4b21-bc96-eeb55442e365@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 24/04/24 12:35, Christophe JAILLET ha scritto:
> Le 24/04/2024 à 11:54, AngeloGioacchino Del Regno a écrit :
>> The previous driver never worked, and never got even compiled because
>> it was missing the DVFSRC driver entirely, including needed neaders.
>>
>> This is a full (or nearly full) refactoring of the MediaTek DVFSRC
>> controlled Regulators driver, retaining support for the MT6873, MT8183
>> and MT8192 SoC, and adding MT8195.
>>
>> As part of the refactoring, this driver is now probed using its own
>> devicetree compatible, as this is a child of the main DVFSRC driver
>> and gets probed as a subnode of that.
>>
>> Reviewed-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> ---
>>   drivers/regulator/mtk-dvfsrc-regulator.c | 196 +++++++++++++++++++++++
>>   1 file changed, 196 insertions(+)
>>   create mode 100644 drivers/regulator/mtk-dvfsrc-regulator.c
>>
> 
> ...
> 
>> +static int dvfsrc_vcore_regulator_probe(struct platform_device *pdev)
>> +{
>> +    struct regulator_config config = { .dev = &pdev->dev };
>> +    const struct dvfsrc_regulator_pdata *pdata;
>> +    int i;
>> +
>> +    pdata = device_get_match_data(&pdev->dev);
>> +    if (!pdata)
>> +        return -EINVAL;
>> +
>> +    for (i = 0; i < pdata->size; i++) {
>> +        struct regulator_desc *vrdesc = &pdata->descs[i];
>> +        struct regulator_dev *rdev;
>> +
>> +        rdev = devm_regulator_register(&pdev->dev, vrdesc, &config);
>> +        if (IS_ERR(rdev)) {
>> +            dev_err(&pdev->dev, "failed to register %s\n", vrdesc->name);
>> +            return PTR_ERR(rdev);
> 
> Hi,
> 
> Nit: (in case of v6)
> 
>      dev_err_probe()?
> 

I don't think there's going to be any v6, as there's nothing else to do on
this series.

Mark, if you want to fix this up before applying, that should then be, exactly

		rdev = devm_regulator_register(&pdev->dev, vrdesc, &config);
		if (IS_ERR(rdev))
			dev_err_probe(&pdev->dev, PTR_ERR(rdev),
				      "failed to register %s\n", vrdesc->name);

Otherwise, nevermind I guess..?

Cheers,
Angelo



