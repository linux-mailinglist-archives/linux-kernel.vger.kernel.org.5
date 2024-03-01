Return-Path: <linux-kernel+bounces-88625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E56286E45A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8BE1F269F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3700C70CCD;
	Fri,  1 Mar 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yRATUcaU"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5970CBF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307006; cv=none; b=o36pSX1BDWCKeC9SE+rZTK38JxLWA2YDmKdZH+Oen4VrjUbGyu8k99fbUD/C41/QjNKvLuhIIu6ZCdUmBhH2XUnhKCE2txQ2/WoRW2hY9fW+Z8V2u06DISHgtiw5MuC3T3nscJPMcZFXf8fNseuWazumQUNE4171bhmVFY7xfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307006; c=relaxed/simple;
	bh=I1uWE9DpsoosndzzuWpPPfCptv98Id+uzZjAljEvYQc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=GqKAa0wHWCkYPzRYtsgaRE/PlinPUWJnDNrccu36ITVrrhp5VRKJONwbq7G+DflRE6OGXtUHRFMH6rnIO4UlbcjGqWa7p38kgaqpetL9EYsd3/AlnCXqVAdcZptpI9oUtTi2GKBKW9QsbxBeLMHfWyeZp3Io0iBk2gMJnPICSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yRATUcaU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d2ab9c5e83so23126791fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709307002; x=1709911802; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=BRJMyL12Hfga3nBS66W3o9I5fxawyXMCNLNUrn0/Hvw=;
        b=yRATUcaU3E7Vae6O96rI1awojOkW9Po71t5JK+f60PDI2iVyrzCZak7HJWSwCevLnX
         NCvPNnlLw1z5yxzqYcfjxlnRLOwjRLTBdU5TK0R0BIuoV2ymSgH709Xkx7vRBmQGI2ju
         dcBg73jbwe2vOjZMw+ppIgTLpGanEs7QUJhJnWH0ckGtYVidQiuERrSfOvMRur3GaVPR
         cNQ/KrzqAjUozozcTQvrEmgSpCN+KVv3RnHbymR82O/bPRD3nMCs9W//Dmz8c1eXBP3P
         XtcSovqjnrERJMALaPG1nG5s68mI+WhO3LwWU48GNhSQa8sjsP/VWVdGkPFXmPFKTqKu
         AMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709307002; x=1709911802;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRJMyL12Hfga3nBS66W3o9I5fxawyXMCNLNUrn0/Hvw=;
        b=MkoYGAGZeI2mhzf13dLJb9IVzHVvo2YjrjqHBdSR+yLiCvcAlzp30fHsJGrbxLatKR
         aC+1NRhC668DnwLloHqGGASih6/P6+QpFbZ5AkwEw16zRjORF80NIxlQR7Chzh4q/2Dy
         wV6bKwkB6UTBJAXf9UsmnXif7us3bF4W7qorWYeQ2KcganDB8MML6jldCv710AOEsqea
         To7u5UOCzI+2cK+u4CXjCBALNZbDqsh3UdPgWHYGJbadMJtXKpCvfUHscmcG/nFcnR+J
         wYsaUWV6xaNReq0hmN+KWU5Z06ae57Pu0rrGJNPkKHZzoMJCoi+r5YkWkfXBzhDKtYYA
         YEBA==
X-Forwarded-Encrypted: i=1; AJvYcCWnmkw/gfc5WFcN/83eP2yG6iEsxiMlK5EHchxA3RW0SksrMbf+pyu8+/nU6OlXR8fylVC9Rk9TNsqsmSRRR49Bw0IioRRJlpfKHVQe
X-Gm-Message-State: AOJu0YypfyDr3tVtFpNCC2amj6lLKa5n18RQK15J2JDKT1Rt2lhVgSLf
	yEKaWFA1wRUsADU+9sACzMKoH0JCn4fT2PwXqDgJHtcayUO45ljuowstrqgBFYU=
X-Google-Smtp-Source: AGHT+IFtbsethllwdu9/U10rpGbV0itlW8rLnEVMWQkX3g7hsPRaSzXqc3jmdeQd4Le6Db0GX6+1Dg==
X-Received: by 2002:a2e:7d01:0:b0:2d2:b651:b0c3 with SMTP id y1-20020a2e7d01000000b002d2b651b0c3mr1563443ljc.49.1709307002212;
        Fri, 01 Mar 2024 07:30:02 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:efbe:c807:bcd8:19bf])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b0033d67791dc0sm4797347wrr.43.2024.03.01.07.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:30:01 -0800 (PST)
References: <20240301132936.621238-1-avromanov@salutedevices.com>
 <20240301132936.621238-4-avromanov@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, clabbe@baylibre.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev,
 linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
Subject: Re: [PATCH v5 03/21] drivers: crypto: meson: make CLK controller
 optional
Date: Fri, 01 Mar 2024 16:21:20 +0100
In-reply-to: <20240301132936.621238-4-avromanov@salutedevices.com>
Message-ID: <1jwmqmrmva.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Fri 01 Mar 2024 at 16:29, Alexey Romanov <avromanov@salutedevices.com> wrote:

> Amlogic crypto IP doesn't take a clock input on some
> SoCs: AXG / A1 / S4 / G12. So make it optional.
>

I commented this patch on v2 and the comment keep on being un-addressed.

The SoC either:
* has a clock that is required for the IP to work
* Or does not

It is not something you are free to provide or not.

For the record, I find very hard believe that some SoC would have clock,
and other would not, for the same HW.

Isn't it more likely that the clock just happens to be left enabled by
the bootloader on some SoC and it conviently allows to ignore it ?

> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/crypto/amlogic/amlogic-gxl-core.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index e9e733ed98e0..a3a69a59f476 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -269,16 +269,11 @@ static int meson_crypto_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Cannot request MMIO err=%d\n", err);
>  		return err;
>  	}
> -	mc->busclk = devm_clk_get(&pdev->dev, "blkmv");
> +
> +	mc->busclk = devm_clk_get_optional_enabled(&pdev->dev, "blkmv");
>  	if (IS_ERR(mc->busclk)) {
>  		err = PTR_ERR(mc->busclk);
> -		dev_err(&pdev->dev, "Cannot get core clock err=%d\n", err);
> -		return err;
> -	}
> -
> -	err = clk_prepare_enable(mc->busclk);
> -	if (err != 0) {
> -		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
> +		dev_err(&pdev->dev, "Cannot get and enable core clock err=%d\n", err);
>  		return err;
>  	}
>  
> @@ -306,7 +301,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
>  	meson_unregister_algs(mc);
>  error_flow:
>  	meson_free_chanlist(mc, mc->flow_cnt - 1);
> -	clk_disable_unprepare(mc->busclk);
>  	return err;
>  }
>  
> @@ -321,8 +315,6 @@ static void meson_crypto_remove(struct platform_device *pdev)
>  	meson_unregister_algs(mc);
>  
>  	meson_free_chanlist(mc, mc->flow_cnt - 1);
> -
> -	clk_disable_unprepare(mc->busclk);
>  }
>  
>  static const struct meson_pdata meson_gxl_pdata = {


-- 
Jerome

