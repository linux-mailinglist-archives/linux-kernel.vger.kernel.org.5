Return-Path: <linux-kernel+bounces-156906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC48B0A28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4672B27DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A835B46435;
	Wed, 24 Apr 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PnVmdGqf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440815ADA0;
	Wed, 24 Apr 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963282; cv=none; b=ev7qj4UvahMA62GgPuRHVTPSglovYkjSbfYHH4NzatstDgKK0hTzO3DVB1Imri4gcZy6htLc+hgncsOqAiBBUd7/P5qj1HXRHmwBQVLl20LDLIuch1DUXDl9qBgFBgbcDBGDrAw3B+vaByjtHIevjdPRZm7F4gTD4MwP4kTd2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963282; c=relaxed/simple;
	bh=qdaeX/Pk+DcIM6hJBtx1rCYaCblxZTumnXXazIdcr6U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JRzVTpnJrHjZDUQWbY2sw8ZBJHEzCwg/yaAYLfUyd/u9AzqK15e7TY6oj5Oy5IplxQc9IjRYYRsPkGbDGdf4oIwqJJZHR1/rWRbjAy4bmADuqYeT9xXNG2HNH7tr8Z41TagjaBjPBfjr48RMurP7GfX+dXpojjWN1Qp0bLmT4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PnVmdGqf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713963278;
	bh=qdaeX/Pk+DcIM6hJBtx1rCYaCblxZTumnXXazIdcr6U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=PnVmdGqf8HNZ4N3lv0SMsNW1uefy2c6NmZlfQ7Wm6sH3LQNrgaaguQIS32x6d/nhp
	 VgNCTOK74JdtJAjlTXIuBd0Cof6DWqGYlrX+Mmp/NSJS1ZwpWDk1uSbqslD25SgPvF
	 IiMxF/r/J1FmZLMzuen/YRC2q/NXwlJ221c6K74XaEV+osftenhVgQQFabtLOyDL8D
	 SHBZmQNRyYB/PVZ6Xj0s9ct8lOBm03imz0shNsqvueqQnRglZzfKpwTiOD/1xvcMfz
	 NveFP1QsUsZi4/DoCu8xoLUXml9M9iFPdWGx7t9cMx0dhd6EiQWcC57kYTqjdQyJNu
	 biLom3dB4HaHA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DAEA437813E3;
	Wed, 24 Apr 2024 12:54:37 +0000 (UTC)
Message-ID: <44257461-b9df-4107-8684-2d9c1b7ad6ba@collabora.com>
Date: Wed, 24 Apr 2024 14:54:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] regulator: Add refactored mtk-dvfsrc-regulator
 driver
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
 <6bd66ba2-7fcc-4981-a2cd-d4500540da76@collabora.com>
Content-Language: en-US
In-Reply-To: <6bd66ba2-7fcc-4981-a2cd-d4500540da76@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 24/04/24 14:53, AngeloGioacchino Del Regno ha scritto:
> Il 24/04/24 12:35, Christophe JAILLET ha scritto:
>> Le 24/04/2024 à 11:54, AngeloGioacchino Del Regno a écrit :
>>> The previous driver never worked, and never got even compiled because
>>> it was missing the DVFSRC driver entirely, including needed neaders.
>>>
>>> This is a full (or nearly full) refactoring of the MediaTek DVFSRC
>>> controlled Regulators driver, retaining support for the MT6873, MT8183
>>> and MT8192 SoC, and adding MT8195.
>>>
>>> As part of the refactoring, this driver is now probed using its own
>>> devicetree compatible, as this is a child of the main DVFSRC driver
>>> and gets probed as a subnode of that.
>>>
>>> Reviewed-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>> Signed-off-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>>> ---
>>>   drivers/regulator/mtk-dvfsrc-regulator.c | 196 +++++++++++++++++++++++
>>>   1 file changed, 196 insertions(+)
>>>   create mode 100644 drivers/regulator/mtk-dvfsrc-regulator.c
>>>
>>
>> ...
>>
>>> +static int dvfsrc_vcore_regulator_probe(struct platform_device *pdev)
>>> +{
>>> +    struct regulator_config config = { .dev = &pdev->dev };
>>> +    const struct dvfsrc_regulator_pdata *pdata;
>>> +    int i;
>>> +
>>> +    pdata = device_get_match_data(&pdev->dev);
>>> +    if (!pdata)
>>> +        return -EINVAL;
>>> +
>>> +    for (i = 0; i < pdata->size; i++) {
>>> +        struct regulator_desc *vrdesc = &pdata->descs[i];
>>> +        struct regulator_dev *rdev;
>>> +
>>> +        rdev = devm_regulator_register(&pdev->dev, vrdesc, &config);
>>> +        if (IS_ERR(rdev)) {
>>> +            dev_err(&pdev->dev, "failed to register %s\n", vrdesc->name);
>>> +            return PTR_ERR(rdev);
>>
>> Hi,
>>
>> Nit: (in case of v6)
>>
>>      dev_err_probe()?
>>
> 
> I don't think there's going to be any v6, as there's nothing else to do on
> this series.
> 
> Mark, if you want to fix this up before applying, that should then be, exactly
> 
>          rdev = devm_regulator_register(&pdev->dev, vrdesc, &config);
>          if (IS_ERR(rdev))
>              dev_err_probe(&pdev->dev, PTR_ERR(rdev),
>                        "failed to register %s\n", vrdesc->name);
> 


Uff! Forgot the return!

         rdev = devm_regulator_register(&pdev->dev, vrdesc, &config);
         if (IS_ERR(rdev))
             return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
                          "failed to register %s\n", vrdesc->name);

:)))

> Otherwise, nevermind I guess..?
> 
> Cheers,
> Angelo
> 
> 
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com




