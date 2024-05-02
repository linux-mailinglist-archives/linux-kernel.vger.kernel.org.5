Return-Path: <linux-kernel+bounces-166894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A4D8BA170
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089CEB22F18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE8181308;
	Thu,  2 May 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HH7Akq59"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC41158845;
	Thu,  2 May 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680797; cv=none; b=BWrvYxKZ8Z/ah2SQ2Mrpr+V+1THyiUEUzX1ZBJfiV2+iswfbs42kwONckQNlHEQkEBUUzWSKZ5Kh6qHWqC/qQPeF2rIirL11QrtLv9XPFkdnhjbeRtggAIWS+57tlbBEApJsxWwq/1flaba9YtrU+9jYWEXk350Ey8ZmtxULDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680797; c=relaxed/simple;
	bh=qFIP7k9Gs4vwTcVje7q6elE+MmAusYXcHMvSEBBntAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuOQLWBAyGfkSHgsQDhE32oTK3a86ffyiJ8Pugh/zhtX77Lc4dneNFOmfcuAdrxoTc11AHvMU/h58qWPYXecEuWlWiRLt9C334t1u38xg7jvJ42IBSbxO2BCaZrDncpdluV9X6Qirfjxr70zeMQjY0BPeU5vmeiypO3eqwwpiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HH7Akq59; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 2cngsZkixUMqY2cngsWQgT; Thu, 02 May 2024 22:13:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714680786;
	bh=4hGjswma74ozpI6l2DVvyyn31CrL8ZkyXTaEf2lOVKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=HH7Akq59Ise5EXDVdE64IqVsm/TLFHUnEWfNQuWaAiDnQobOhuhdZJe705bfi08qb
	 IHUW6uaodfGEeDngh+D1goA7Kzzdknjt9MQ0G5RMyV6ergnVVDM4FnxuDhXbY4bBUL
	 4OrsqJacDu67Gn2+ijqPM42G9H3LMC3YN64cPEA3XrL7g+Tn2Gkmfn/9UZ+1M5kjd6
	 lc52oGB7Pv8/CFDnV4c8vZ+7GpC8dnx6kTVMg+iD4sVkkp/IYVD+ywNT+ZA9o/4rd1
	 sOW7PYrOpivBJZuPEaGjqqjONA6q2m1auX7WP+0+c3wNiUXbMOqtWr+pgfeA4kqCTl
	 aLweBxWQddaAg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 02 May 2024 22:13:06 +0200
X-ME-IP: 86.243.17.157
Message-ID: <1f42371c-2fc9-46e5-b27b-3167e026e772@wanadoo.fr>
Date: Thu, 2 May 2024 22:13:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] leds: sy7802: Add support for Silergy SY7802 flash
 LED controller
To: git@apitzsch.eu, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
 <20240401-sy7802-v2-2-1138190a7448@apitzsch.eu>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240401-sy7802-v2-2-1138190a7448@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/04/2024 à 23:23, André Apitzsch via B4 Relay a écrit :
> From: André Apitzsch <git@apitzsch.eu>
> 
> Add support for SY7802 flash LED controller. It can support up to 1.8A
> flash current.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>   drivers/leds/flash/Kconfig       |  11 +
>   drivers/leds/flash/Makefile      |   1 +
>   drivers/leds/flash/leds-sy7802.c | 532 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 544 insertions(+)

..

> +static int sy7802_led_register(struct device *dev, struct sy7802_led *led,
> +			       struct device_node *np)
> +{
> +	struct led_init_data init_data = {};
> +	int ret;
> +
> +	init_data.fwnode = of_fwnode_handle(np);
> +
> +	ret = devm_led_classdev_flash_register_ext(dev, &led->flash, &init_data);
> +	if (ret) {
> +		dev_err(dev, "Couldn't register flash %d\n", led->led_no);
> +		return ret;
> +	}
> +
> +	return ret;

Hi,

Nitpick: return 0;

CJ

> +}


