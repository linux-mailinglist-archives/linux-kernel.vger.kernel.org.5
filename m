Return-Path: <linux-kernel+bounces-104872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324DA87D4D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B768C283516
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47DA5479F;
	Fri, 15 Mar 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXlBE2U7"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217F535DB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710533678; cv=none; b=WL6z9QXda0TGUGnx18xenKu0YB5XWHCIc9k0+pKiA88PICdamkxM/4NacQ7LynmacvhZMtXQZM7rtjZeMQHkUk2NYFdgPt61Kd9ZtxuanYFWWu8J+s6BdsqVG++WM89YW4FTU21sqbbSpz2o3SyWzLnuCuYppXUiXAWZ+Y7gzNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710533678; c=relaxed/simple;
	bh=nFEHXT/ylyLCa900IA9PFnKY9MAwcOJTEsnXYFP5+js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nx9f+wQMGZx+jv9+Hvompq3trWu8CY+McezjlZg8KGAkX67m7DKPacJkQnO6OJ1u30cG9mxnG7ZRx4ghP3RcRS6j86lip3zW0aZQWUM0am6j766m3qAVRRx5V7IVsbPXX9ApebfrTeVF7hUoL3TB1lpAhKJBH+1dyWJUkIh5QPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CXlBE2U7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4682272ff6so138293466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710533674; x=1711138474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odLjH6pCRhbd6VY/8IpKN5+gXDMhrfAYCr6uel2M/zo=;
        b=CXlBE2U7XlaLj5OA0z5M5J6kDZpCSKUJZ1F2K/BypbHL8py99AcYxUqY/7p+JgrPOn
         gZ+YxYe129tPgI79VDXyd/RdasUmCyjoBfQGrCqZOj2rvfGKXAQtpmNqhCKSnPGrhlXC
         exc6OervAckHF6wfVYqy589fNTMJmk9s2MLtWinjZSH9WmezjVUUHl3ZA4pdi3E1SGfD
         VvQn9vcN5AMTbKN/RtE4Jt28k1vHep7f3/yx1m70vDbtqg71O1abcOJ6btW9zuExibZq
         A2jX+Oroz/etnGdazS/npHy0udtgOAxDrDIYfuVuYOKJb+yl6zWRBn28FOD3m4TM6/ah
         YE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710533674; x=1711138474;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odLjH6pCRhbd6VY/8IpKN5+gXDMhrfAYCr6uel2M/zo=;
        b=YaexrxLz7DC930vjzUipID3M1bMwwRHH3tHBikkwX5qMaaRU8OgOpruWArzvNeIIoR
         LsrquWcan70ZnpIKAd4RZaJHq5cyHb2uNQcAltrW5Bw4Chz8K7JX1PxqeC4ZkA5BzlMw
         rr0IG/7c6QrIzdiQk0iLxlrmDlNJXy2Dmty2q7SLKdj3ZjsUTy1VphPCWc4cXiycloKM
         LcFt7ZqML2jyl2G6mjfAC5VvdRi7PLTP76qYcFJITAdAmNezeAmf1lBq1nViLm67UXO7
         71jy7tVdCtp3Y2DljF3B6NdWJ6HPgKR3WJU3tkSdAQNCi2BQGvJzs9f3HwEGPKwFSlQc
         3V/g==
X-Forwarded-Encrypted: i=1; AJvYcCWE8+gRdbzd4IyiQfMURmnOpb1xe4i4SfTm3dnc7gBsuL/Cqbx4wT5hizYGTRh3XTIBqUX8nStwfyv2jHIwANeUwW+bfMiO0aTkiX77
X-Gm-Message-State: AOJu0YxPhD1Gg1DiWxShIoEtPBge46jaWCU6VMEIh5fP3s81QyKf0Nas
	Kwh9xyKlSuzsnezTTxkD3qTCBJeUNREEk/6f+iL0RlLX2m9v4eF6uXA+Hd2DGMA=
X-Google-Smtp-Source: AGHT+IEsS46iEcSasaXWquxv5k5qikS5zVamCo2J4zeZor8vCboZ/fxtqwqJns14sHIDjc/FiAzt+Q==
X-Received: by 2002:a17:907:72d5:b0:a46:a23f:bc2c with SMTP id du21-20020a17090772d500b00a46a23fbc2cmr27440ejc.25.1710533673785;
        Fri, 15 Mar 2024 13:14:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id hj11-20020a170906874b00b00a46a04d7daesm90052ejb.115.2024.03.15.13.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 13:14:33 -0700 (PDT)
Message-ID: <b70ceddb-0f36-4ee3-bafe-01e4683cc72a@linaro.org>
Date: Fri, 15 Mar 2024 21:14:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] w1: Add w1_find_master_device
Content-Language: en-US
To: Ayush Singh <ayushdevel1325@gmail.com>, linux-kernel@vger.kernel.org
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-3-ayushdevel1325@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240315184908.500352-3-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 19:49, Ayush Singh wrote:
> Add helper to find w1_master from w1_bus_master, which is present in
> drvdata of platform device.

Who needs this?

> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  drivers/w1/w1.c     |  6 +++---
>  drivers/w1/w1_int.c | 27 +++++++++++++++++++++++++++
>  include/linux/w1.h  |  1 +
>  3 files changed, 31 insertions(+), 3 deletions(-)

Why is this in the patchset? What are the dependencies? Please clearly
express dependencies between patches or merging needs in cover letter.
Otherwise please do not combine unrelated patches from different
subsystems together. It's make review and merging only difficult.

> 
> diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> index afb1cc4606c5..ce8a3f93f2ef 100644
> --- a/drivers/w1/w1.c
> +++ b/drivers/w1/w1.c
> @@ -673,9 +673,9 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
>  	sl->dev.of_node = of_find_matching_node(sl->master->dev.of_node,
>  						sl->family->of_match_table);
>  
> -	dev_set_name(&sl->dev, "%02x-%012llx",
> -		 (unsigned int) sl->reg_num.family,
> -		 (unsigned long long) sl->reg_num.id);
> +	dev_set_name(&sl->dev, "%s-%02x-%012llx", sl->master->name,
> +		     (unsigned int)sl->reg_num.family,
> +		     (unsigned long long)sl->reg_num.id);
>  	snprintf(&sl->name[0], sizeof(sl->name),

Why? How is this related to the goal "add a helper"? Where is the helper
used? I don't see. Don't combine unrelated topics in one patch.

>  		 "%02x-%012llx",
>  		 (unsigned int) sl->reg_num.family,
> diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
> index 3a71c5eb2f83..2bfef8e67687 100644
> --- a/drivers/w1/w1_int.c
> +++ b/drivers/w1/w1_int.c
> @@ -242,3 +242,30 @@ void w1_remove_master_device(struct w1_bus_master *bm)
>  	__w1_remove_master_device(found);
>  }
>  EXPORT_SYMBOL(w1_remove_master_device);
> +
> +/**
> + * w1_find_master_device() - find a master device
> + * @bm:	master bus device to search
> + */
> +struct w1_master *w1_find_master_device(struct w1_bus_master *bm)

Why are you duplicating w1_search_master_id()? Without locking? Sorry,
this looks like you did not look at all at existing code.

Best regards,
Krzysztof


