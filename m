Return-Path: <linux-kernel+bounces-121837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2652988EE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AC029D946
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5832F14F9D6;
	Wed, 27 Mar 2024 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jje+WtQW"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD214F123;
	Wed, 27 Mar 2024 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564609; cv=none; b=S35nx4YY85iJbZf5RZrmOaU0gfvwQVLfrmzzXb2YEcceFWrf5CA6XB3DlOb4tZmWu00jm3yU7h/N84+yMXwxzrZfM4gj9D8I+BM4W3zJdKH845HM5q6Ecze0PtqjKXG2zBlYVmj1yWIvKAfmZr3YauTfVAOTgF/kxFrQU71xBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564609; c=relaxed/simple;
	bh=05Vtrdwjo9vnA0afYAWqnqaRReuzR9JZQNH6yJD6kvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goclVsToSlVXf4m8uz+IZS15F0jOpLD9+cwLwABvJoaoSS04uUTqqw/+tzKHCZC1EVjAdsdqwym90OReYNgTmEXnnoq3nyOoEu51mq3EGpOqll7mKLuO21tOpClC3l6us/aq5Y1HVY7r3Sa9QI+oVaQgx2TQ/kHnyG13s3aENg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jje+WtQW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so43550a12.3;
        Wed, 27 Mar 2024 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711564607; x=1712169407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUnyZDHxAplu3zLriBC+152zgXY6ostH4U6MjgQjkKE=;
        b=Jje+WtQWpdDSAxKXV54YVoiGtfgjGbYi9pbV9mK0kAw0logkiMUH1csWVUqHGEfdUu
         NmlS0yti8qqmfaCe5Jvbva/R3sZ5yZOHF6R0CA2jsstO2SN6fhdlB85jt+7p8XfAyPyc
         zGCoAq8H5bRPe6CytsP1L6EAHYHmPKC/wZTM8ppuNPLw9DwVp1MM16D3EVRwK9h0cw31
         xsOHzYB4HyaE8PKKmrWbWN30Yp+Gu68PofnJyhOH/xEik4t4dc2GuVSQTElR9K10TNT4
         oNZnxsNjNFl8CgRkpy7M8CaooKypxlhbbtru+jKAIw/4ujivC3mOCzPWSl8Ku3qvq20Y
         zNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711564607; x=1712169407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUnyZDHxAplu3zLriBC+152zgXY6ostH4U6MjgQjkKE=;
        b=UuIiwbeS85Mi+FozhgsKA25NCkxESCjRg57mUIzsn2idM2jYT3soGQP33Gemkz702f
         b+1AhWz/+GfCnVLlf+hKqT2UqtmouPkr4baCf5UEWwVZLNktzq7NW1XtCgg0iHCd1JHr
         Z6/AsGctDEqFTncGdtTyEYsD2RfjwgYRKflcgXVkuUzLFIEja98UCaLVrL8jLRU8f/Jq
         86VgU3FVFLP4W0OB7+dYWS4bNtoQdEDOiaUC9qO3H6G40/hvVtFEJYuU3SeAgMVDlX4m
         ZvXS+pf7zBjbhh+PAmxvJwMV8kqzPEF7AwmGsviIlMlFWisWwMZJdZT7cLw8+aqOvl9Z
         VgOA==
X-Forwarded-Encrypted: i=1; AJvYcCVAwSCyNvg9dWQwi050ui6uipA8cYj8HRA4wDgV2+2FkkbJ3jm7lxlzHiKATxBuUm3wTdPhkt7nr9H2hs3mGdBcUT66F8WPhK/7qrPNJ164+2FZFfwsb1lJtWh9I/qWCKh/4NuvcMCG26ziAqI=
X-Gm-Message-State: AOJu0YxJphfM6q2wxudvoei4QW7WsvBDmnzYyTdlYzVMm85dH5TpWH5k
	RGsXSPKpkZE8ShOnHXg7hoW5XBya0f1lPrRCQG4923ZWShqexY2R
X-Google-Smtp-Source: AGHT+IGjeJyqlh/96GXHF3+Mi9fguELi362cjO5V2legq+rKdrso1IEiyMUXWtqDu7FvJNth5x4iaQ==
X-Received: by 2002:a05:6a20:1202:b0:1a3:ca1f:8baa with SMTP id v2-20020a056a20120200b001a3ca1f8baamr786270pzf.32.1711564607431;
        Wed, 27 Mar 2024 11:36:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gu24-20020a056a004e5800b006e6f8e9ab6asm8531011pfb.15.2024.03.27.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:36:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Mar 2024 11:36:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: mtx-1: drop driver owner assignment
Message-ID: <97006bea-f233-43c9-a038-f2a71ff7c443@roeck-us.net>
References: <20240327174638.519445-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327174638.519445-1-krzysztof.kozlowski@linaro.org>

On Wed, Mar 27, 2024 at 06:46:38PM +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mtx-1_wdt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> index 152e41ecbb14..06756135033d 100644
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ b/drivers/watchdog/mtx-1_wdt.c
> @@ -236,7 +236,6 @@ static struct platform_driver mtx1_wdt_driver = {
>  	.probe = mtx1_wdt_probe,
>  	.remove_new = mtx1_wdt_remove,
>  	.driver.name = "mtx1-wdt",
> -	.driver.owner = THIS_MODULE,
>  };
>  
>  module_platform_driver(mtx1_wdt_driver);
> -- 
> 2.34.1
> 

