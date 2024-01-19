Return-Path: <linux-kernel+bounces-31426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A811832E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3881C21CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1405A56456;
	Fri, 19 Jan 2024 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="U386wNGe"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3855E7C;
	Fri, 19 Jan 2024 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685379; cv=none; b=AxmY78IrtmEcKUXfJC2p88QE1fmfeF5RwJ8fe+a2XxhpcvcEG4rTTAYEQodLCL74yWCfmGo3DsfxmwmLhP1eFtjAdv6I/PWHLWV9mfHJpQ7IM7YcnAj4U45GXE75b1ucZnHffmOFvCMf923s9ZekDqDe4G1AS0Hlk5cSRchOc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685379; c=relaxed/simple;
	bh=wFLS/DRuClG477WloVYRf2DcpMH14Dg3hMZDefXJDs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQrvuxK/VKRKgoCuhUCo0/xbENgLAfmrxmYsh8x5RRLw4iIHsLigzQmSCYMevYkytxl+r9HstPjfrvAjQHK/BenGy5d7QuDi1wddklhrfI1wwSXIqAPdVLQ3yd4tdKEHOpEoAcmpbsxR9S7dPTfr5ZUVGyu8uQ3iiGt2iDq9xgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=U386wNGe; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id QsgFrYNTInarWQsgFrf3Du; Fri, 19 Jan 2024 18:29:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705685367;
	bh=JwBsDqoOR8SiedNBXI31hNKQkl0we/KwEcGVoVCDXdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=U386wNGewBzAthdqhIdujVAu3XxD1xge3Hkts4nbBqvQ1Geu44Q7jwKuf+Qij0377
	 RI7NJB2U0tzYQQw+aLF8arczrhTNhLwB8g6f+BCu123s0xGISChTRFNpImAk+DaTWe
	 mWTqTcJTGOtPh95WBtomd3LbbCOykeIxr69gLDDla+KgJt2xxFXWP7RLF10znWjsM2
	 857qN/+hb4j5WEbcKLKvjKqfjAIrbTfMXdxcwNiYg3Q4FZyP8ykSrXKAN7OBzYk/Ke
	 4GHKH7AHzMpPkcuZQH29lYqD2zNFLjxyt7YTxKmh6dNyb9Wz/7q/JZD8SOZWzeYSsT
	 Ow2jA0miGUPHg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 19 Jan 2024 18:29:27 +0100
X-ME-IP: 92.140.202.140
Message-ID: <51576fbb-c7dd-4ee8-a77f-ae7f62b254ab@wanadoo.fr>
Date: Fri, 19 Jan 2024 18:29:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] backlight: Add Kinetic KTD2801 driver
Content-Language: en-MW
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20240118-ktd2801-v2-0-425cf32e0769@skole.hr>
 <20240118-ktd2801-v2-2-425cf32e0769@skole.hr>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240118-ktd2801-v2-2-425cf32e0769@skole.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/01/2024 à 18:32, Duje Mihanović a écrit :
> Add driver for the Kinetic KTD2801 backlight driver.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> 
> ---

..

> +	ktd2801->gpiod = devm_gpiod_get(dev, "ctrl", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ktd2801->gpiod))
> +		return dev_err_probe(dev, PTR_ERR(dev),

PTR_ERR(ktd2801->gpiod); ?

CJ

