Return-Path: <linux-kernel+bounces-79532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807E98623B6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F0E1F23F87
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1537818E3F;
	Sat, 24 Feb 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax7/KRhK"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72F1400B;
	Sat, 24 Feb 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765747; cv=none; b=RdxsKLX8KTh5Gdu8YNkNsI4ot92AESnBI7gwjiD2PzSSNO7bA8Q7Y9uRk0zQWXFDDpJTUYThsotuPMXx57LzW7HJe535G29tPn2kcJxSNya6k5DmxKzypq0eCvsofXCiZgRpOCs6E80qwZOBAsOXIvz8OGkgFA0mvVL2U/fzLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765747; c=relaxed/simple;
	bh=Q1oMbEw0NLdRkWu0F9h/Gc9Oz5SC4qKZQNvZFGmheI4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Bi4MChQEMEPTPwVMh44NQTKoJZshIsUpCRh9cVDMMLJMxDIAKW1PYCb6hWiHXreAVRMibdyEbzK/beCzZ7OnZoMOqDjN2W86Twf9pgYeC0r49pZ0EzjSsFBLUDkksmvEAX4QyOzZRPUl94ks9k84DkTT/AuDa452zyBiaWiYb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax7/KRhK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512be9194b7so1322840e87.1;
        Sat, 24 Feb 2024 01:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708765744; x=1709370544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He0fBSHHPtIHZTRjcYmDZndFACrI+q2AezJo3cfp+yQ=;
        b=ax7/KRhKL3JgVJSwwIHubvQJ9Z65+f/O1lQFyxK+LYyol0UGNHayOCgcBgFKI8i0At
         qoUcF2OldmBRU7dTHhNHKfoJqnaWPT68x2Up6ydfHYx+tFQRvrT5Roa5Q2el/3bhA0Vv
         1bruFcpj1bbu5RhM0rSXuulOQVqF7dH1AULv/I50iBrnKxj5wdmtISP2jw0KogbnxkXI
         iLBkcMlREsXLM8BTsSdA7/z0FLVidI+3LyKJXGTytAS5ltFslnBBVfmlPy1Cl41vFfF3
         t0KgWr1Ja92GvcxT3us7WlT+9QZrso/pl2eujBvI3qxT8Qq94qutIJDGxtdm/ppVnr8c
         sOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765744; x=1709370544;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=He0fBSHHPtIHZTRjcYmDZndFACrI+q2AezJo3cfp+yQ=;
        b=ezT/HyB7G7N2OLvDnOE3JhGUHH7PQQpjF6MFH5+OvBJJqeORuUJTXzKjW3UiSkEkiY
         ey6cc6wnAXaZyzmzSqdj4O3m3QNo5oVmAGAaW6WFynrVJhnUEhB+azuYTPXGq59pPDAk
         KIqcLssZGhUZf8P5xodlnjsH4tDwviBFonX8vY91mRV61Stg6rB3nKSCy51I5f/DM1gu
         wE9FyDSHl6h2lKToNKAtcxhmHkTdlA9mwGVDy9Xn36I0li6Hw0ekL6Gu2LlcI1kHB/UE
         6dlaNZRHChG79wQLFfN9yLw2UFBwSjx/xUKOBw800qq9kqXnsCeT7gY6yspFiWsdBXOE
         daPA==
X-Forwarded-Encrypted: i=1; AJvYcCV0k75IB8Y2GEjXpg8wiHl+Jh08VmJtLSBG4e+woAxOVh97wpGXY1RaoKnhyWu0sCKSiIE8zym2Y3JworlsZOnzSKp4i78M2zlnux89jZ7t2jwRoktHGjetXX8S0ZU5YsuuTiysnW3tRYObivYxESAklpNPgxJ2lmWTAjnwRGhUXO1J4g==
X-Gm-Message-State: AOJu0YweNdF4qQy0c6robwjRQi0zqE1f34qypayen4DvpgK5yQ5VEO6q
	V+A5B7oJ67oCmsd64T6KtnWn48WrpriBUNdm1XHcQkl6uTpulny1
X-Google-Smtp-Source: AGHT+IGOmcFSCvj0DtbfsvvOm/TWfrSBjSEkwMeQyio5qdvAlQZq6fJHLF/fXG4q8mE1YEuQM4uU/w==
X-Received: by 2002:a19:f710:0:b0:512:bd51:a0ea with SMTP id z16-20020a19f710000000b00512bd51a0eamr1115299lfe.9.1708765743390;
        Sat, 24 Feb 2024 01:09:03 -0800 (PST)
Received: from [192.168.1.105] ([178.176.74.19])
        by smtp.gmail.com with ESMTPSA id t30-20020a195f1e000000b005118e37462asm144768lfb.89.2024.02.24.01.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 01:09:02 -0800 (PST)
Subject: Re: [PATCH v3 4/8] usb: cdns3-ti: support reset-on-resume behavior
To: =?UTF-8?Q?Th=c3=a9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Gr=c3=a9gory_Clement?= <gregory.clement@bootlin.com>,
 Kevin Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
 <20240223-j7200-usb-suspend-v3-4-b41c9893a130@bootlin.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <b778d2e8-3fcf-afe4-2e48-0348be19a085@gmail.com>
Date: Sat, 24 Feb 2024 12:08:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240223-j7200-usb-suspend-v3-4-b41c9893a130@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2/23/24 7:05 PM, Théo Lebrun wrote:

> Add match data support, with one boolean to indicate whether the
> hardware resets after a system-wide suspend. If hardware resets, we
> force execute ->runtime_resume() at system-wide resume to run the
> hardware init sequence.
> 
> No compatible exploits this functionality, just yet.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index 4c8a557e6a6f..f76327566798 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
[...]
> @@ -220,8 +226,29 @@ static int cdns_ti_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int cdns_ti_suspend(struct device *dev)
> +{
> +	struct cdns_ti *data = dev_get_drvdata(dev);
> +
> +	if (data->match_data && data->match_data->reset_on_resume)
> +		return pm_runtime_force_suspend(dev);
> +	else

   Pointless *else* after *return*...

> +		return 0;
> +}
> +
> +static int cdns_ti_resume(struct device *dev)
> +{
> +	struct cdns_ti *data = dev_get_drvdata(dev);
> +
> +	if (data->match_data && data->match_data->reset_on_resume)
> +		return pm_runtime_force_resume(dev);
> +	else

   Here as well...

> +		return 0;
> +}
> +
>  static const struct dev_pm_ops cdns_ti_pm_ops = {
>  	RUNTIME_PM_OPS(NULL, cdns_ti_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(cdns_ti_suspend, cdns_ti_resume)
>  };
>  
>  static const struct of_device_id cdns_ti_of_match[] = {

MBR, Sergey

