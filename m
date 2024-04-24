Return-Path: <linux-kernel+bounces-157886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E148B1819
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8762831AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86601C14;
	Thu, 25 Apr 2024 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Rewpzcqr"
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF86816;
	Thu, 25 Apr 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714005743; cv=none; b=j/MDqKtBhLDKh/bURHp8/xb0h4OlOHETPDggi6QbIu48AXhAAqk6SPjUWOFKqdcwRWHIwnx+GNdtQsPYQBtMgjnjnQBBcN7HB0h/xetg32mRNkUrNBSXQg7PnLS5M6fCkefx2le8bGdrqYnXRPbk2eChKLVW2D7ahzRNM6a72Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714005743; c=relaxed/simple;
	bh=Hre7W80W6Sa6/1VsF3RTEXPkgnH7ao/VPskpGPGZYhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjjDbzIU8G/bnXMbuRAGfs7vPhIi8eK3I6YRw2Nx8mll0fklt5iE+k0LBGLjTPI598pSAHrLsCnPunBRE1HadWSP0cHNc8A1gCB9VgnA5bGfkysfyp2RmwUwGpiSgGoThIVfHK0oTSXAQnioZYZX2XC2VRtC9vJLKnWTckVJMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Rewpzcqr; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id zZxwrgXWsHa8WzZxwrW7sY; Wed, 24 Apr 2024 12:35:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713954909;
	bh=h2zecfNezQcLS7/TPEc/i/RBRBH4yoSAoRIJo8Y12us=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=RewpzcqrFLLCX8GSjycSHK/O7YxBxMhCOig8ckghUv80CaJFslEskHhJ1Y8ioT2Hu
	 tQkdEdydNfFXFCgq/t5JH+UCKBSCRD0QQKPW2FXw53Z3qAQ+i5dCDtotEqjXk5A7Jh
	 4lmyuc5ygkVRv32F1a528mNyAo+WgSTElkNu4YopJ//yCdVRXZciBexmZeS/kUPJxT
	 geFAUo18k7wvt00zkCqux9gJGwpUuC1zCh86UOu72UcqLLKBtZvMlfk4Ex0fjgOwH9
	 6KfIOFqKj2C657lUcx2eEGGMBzSXh6GKymFn0DmcYZNvr6e/ZbgYmcn4MypF44DIfw
	 3pQZzecB/H2+A==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Apr 2024 12:35:09 +0200
X-ME-IP: 86.243.17.157
Message-ID: <93c12354-2e4d-4b21-bc96-eeb55442e365@wanadoo.fr>
Date: Wed, 24 Apr 2024 12:35:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] regulator: Add refactored mtk-dvfsrc-regulator
 driver
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: amergnat@baylibre.com, broonie@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, djakov@kernel.org, gustavoars@kernel.org,
 henryc.chen@mediatek.com, keescook@chromium.org, kernel@collabora.com,
 krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 matthias.bgg@gmail.com, robh@kernel.org, wenst@chromium.org
References: <20240424095416.1105639-1-angelogioacchino.delregno@collabora.com>
 <20240424095416.1105639-7-angelogioacchino.delregno@collabora.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240424095416.1105639-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 24/04/2024 à 11:54, AngeloGioacchino Del Regno a écrit :
> The previous driver never worked, and never got even compiled because
> it was missing the DVFSRC driver entirely, including needed neaders.
> 
> This is a full (or nearly full) refactoring of the MediaTek DVFSRC
> controlled Regulators driver, retaining support for the MT6873, MT8183
> and MT8192 SoC, and adding MT8195.
> 
> As part of the refactoring, this driver is now probed using its own
> devicetree compatible, as this is a child of the main DVFSRC driver
> and gets probed as a subnode of that.
> 
> Reviewed-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
>   drivers/regulator/mtk-dvfsrc-regulator.c | 196 +++++++++++++++++++++++
>   1 file changed, 196 insertions(+)
>   create mode 100644 drivers/regulator/mtk-dvfsrc-regulator.c
> 

..

> +static int dvfsrc_vcore_regulator_probe(struct platform_device *pdev)
> +{
> +	struct regulator_config config = { .dev = &pdev->dev };
> +	const struct dvfsrc_regulator_pdata *pdata;
> +	int i;
> +
> +	pdata = device_get_match_data(&pdev->dev);
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	for (i = 0; i < pdata->size; i++) {
> +		struct regulator_desc *vrdesc = &pdata->descs[i];
> +		struct regulator_dev *rdev;
> +
> +		rdev = devm_regulator_register(&pdev->dev, vrdesc, &config);
> +		if (IS_ERR(rdev)) {
> +			dev_err(&pdev->dev, "failed to register %s\n", vrdesc->name);
> +			return PTR_ERR(rdev);

Hi,

Nit: (in case of v6)

	dev_err_probe()?

> +		}
> +	}
> +
> +	return 0;
> +}

..

CJ


