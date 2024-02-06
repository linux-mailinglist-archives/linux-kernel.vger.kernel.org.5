Return-Path: <linux-kernel+bounces-54596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3B84B158
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49101B2488F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B01712D165;
	Tue,  6 Feb 2024 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BzSbca5G"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A64812D140;
	Tue,  6 Feb 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212032; cv=none; b=IXDfNiyKvc3Qu0TdmK1ldG5FsZEdI0Lqp++QhEt/66G9wBzAy3YZkRd1ouzMnm7oC1JLZc+wdwSMUZc2z5kI6TKoxeyVXq1Ieji1pZJJIOno4jfbV0R4O1rlhGqAT8JGoLyO1gLDXUg2gWOT/3k9tqeGXTvqY2lrGwKEm8f1fHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212032; c=relaxed/simple;
	bh=fQlylVz2jQb6NzL/+ZmTPkrnm96XO8ophYiGOdTCP8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LScybBhBUTect1lxJlF4G42nVXdOVNJkxtxo9UD8FQldo300Q3hK8rOywIWtSg0o7DYNw5vQO6YlH9ehQVjVTnILaJ6c7xNc4n4V7mfIYZtWrfE853yJjkAy2bC02q0heAJVbV7pLJMnz3yby4Hlf9H93Veo54IVWqG4hWtE9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BzSbca5G; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707212029;
	bh=fQlylVz2jQb6NzL/+ZmTPkrnm96XO8ophYiGOdTCP8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BzSbca5G9L3dzYbj7Chv/fm/rPCI1A0STw4ZW1zwSCyXp14y9HgLkPOYLVpM4JLxS
	 kjEVKyTlRDfWrRf83f8oc/+gLNWXUIO4DiC++tRCNHRDQ5QtU9+qdjL9SzoolgrW5j
	 SrZ/wQd/P4x/XxXV89kmGSIWgZZg19cOi5n/7k3CAgBcLrc5RkFuEuxlIv17V98v6+
	 NEeD1tVrPf4TdPFaegUu7Gx8YAKbesHL48lb8gW5r4frhrWa9uAKQUOAC6KQxTRWPx
	 UF5XwORaNQNPvKnzOxpifiwe3ugm+1qeaLJepWPYQeZYVJRLCY8rswdRVCfDXbJry4
	 y+FoHd6UJQIew==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 659763782039;
	Tue,  6 Feb 2024 09:33:48 +0000 (UTC)
Message-ID: <f5044987-2514-44cf-83d4-0976b37dc683@collabora.com>
Date: Tue, 6 Feb 2024 10:33:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/19] power: reset: mt6323-poweroff: Use
 devm_register_sys_off_handler(POWER_OFF)
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240205194437.180802-1-afd@ti.com>
 <20240205194437.180802-12-afd@ti.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240205194437.180802-12-afd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/02/24 20:44, Andrew Davis ha scritto:
> Use device life-cycle managed register function to simplify probe and
> exit paths.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   drivers/power/reset/mt6323-poweroff.c | 28 ++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/mt6323-poweroff.c
> index 57a63c0ab7fb7..ca5d11b17ff03 100644
> --- a/drivers/power/reset/mt6323-poweroff.c
> +++ b/drivers/power/reset/mt6323-poweroff.c
> @@ -14,6 +14,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/mfd/mt6397/core.h>
>   #include <linux/mfd/mt6397/rtc.h>
> +#include <linux/reboot.h>
>   
>   struct mt6323_pwrc {
>   	struct device *dev;
> @@ -21,11 +22,9 @@ struct mt6323_pwrc {
>   	u32 base;
>   };
>   
> -static struct mt6323_pwrc *mt_pwrc;
> -
> -static void mt6323_do_pwroff(void)
> +static int mt6323_do_pwroff(struct sys_off_data *data)
>   {
> -	struct mt6323_pwrc *pwrc = mt_pwrc;
> +	struct mt6323_pwrc *pwrc = data->cb_data;
>   	unsigned int val;
>   	int ret;
>   
> @@ -44,6 +43,8 @@ static void mt6323_do_pwroff(void)
>   	mdelay(1000);
>   
>   	WARN_ONCE(1, "Unable to power off system\n");
> +
> +	return NOTIFY_DONE;
>   }
>   
>   static int mt6323_pwrc_probe(struct platform_device *pdev)
> @@ -51,6 +52,7 @@ static int mt6323_pwrc_probe(struct platform_device *pdev)
>   	struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);
>   	struct mt6323_pwrc *pwrc;
>   	struct resource *res;
> +	int ret;
>   
>   	pwrc = devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
>   	if (!pwrc)
> @@ -63,19 +65,20 @@ static int mt6323_pwrc_probe(struct platform_device *pdev)
>   	pwrc->base = res->start;
>   	pwrc->regmap = mt6397_chip->regmap;
>   	pwrc->dev = &pdev->dev;
> -	mt_pwrc = pwrc;
>   
> -	pm_power_off = &mt6323_do_pwroff;
> +	ret = devm_register_sys_off_handler(pwrc->dev,
> +					    SYS_OFF_MODE_POWER_OFF,
> +					    SYS_OFF_PRIO_DEFAULT,
> +					    mt6323_do_pwroff,
> +					    pwrc);

	if (ret)
		return dev_err_probe(....);

Regards,
Angelo

> +	if (ret) {
> +		dev_err(pwrc->dev, "failed to register power-off handler: %d\n", ret);
> +		return ret;
> +	}
>   


