Return-Path: <linux-kernel+bounces-24527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC482BDEC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEC71C256F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D55D91E;
	Fri, 12 Jan 2024 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0lADas1"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FA5D915
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so5720551f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705053194; x=1705657994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmPRDDpe1a2Em5SXxYrA1LLppbMT+QjFBtfOB+D16p8=;
        b=p0lADas1W8/t09EJVfCnxgY2Ynp1808wQWnoZRigkLuyrUvB+m8EEwJBwJXWvQF4MI
         XJopB0DzaFXPWjZPMaRBXaEGAVOl/xpLdAAcGJ60J5PbnSW//aO3p8mV4dGcblQj4bvj
         2LXVvsNSmOq/2jwl2tKTNIVxCMBKGEdAuHBNVe8ks0gEm7Rq216UmkVohSwShDV46u1M
         qzOmQ9WvPp8fFaW/hwbBOzZzO4Isf7DKyhDPhEH1vDaJ2Y0ex1Qc3fZZOMg/sT10Eslf
         VGKSnQIVxx8D776HUijwRrT/rHccIHcL48x5WgwLme4XewbkaEoTMh5rBkZinBfAwpGD
         k+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705053194; x=1705657994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmPRDDpe1a2Em5SXxYrA1LLppbMT+QjFBtfOB+D16p8=;
        b=PjaB0XePzILl5g4+5esNsk3uRQ5fmVpaBtCLN0qiXTF6qAeFI/eeF9WzhB30Xptcv3
         3UFx/8VAT+KSF+DwX464kQvwzq5kU7kv46rwXtC9FuGMZibavmF4ohM0+XDektf7/zLk
         9f2PADERxyHPchASKC1mf8CGS3He9q8zJnU1YBMgfj1ZgtQ6Jmu6OJlk/vEle8L1x6e3
         48riiazUoFXuKpk2McnJjzAqpIBu+CPdKkBFqIsusHqjTdCaWJZlQz3Jik6vm1WIO2tz
         gZX/EBBZDhtKPFGMi3cBMc4mAgW50EAQL5AV0W96VBORGnG2IdrZQ8jmj8xjMq/c5dm2
         RXsQ==
X-Gm-Message-State: AOJu0YygbWq8+nqEXf+HzZy1/pDGj45g2mCmYjvPTtj3FbIgW41hT/xC
	+JUdv4fxdjCvTYeJtWEMi8oCjQMFdft7sQ==
X-Google-Smtp-Source: AGHT+IHRcRqWpb2C0sctjOIkcYeOwOLsysdMzT4MGiJc2oWytkY9z63i0pxI/Cz6nwK8Y1OE8B13Bg==
X-Received: by 2002:adf:ed4c:0:b0:336:6af9:9f2c with SMTP id u12-20020adfed4c000000b003366af99f2cmr320437wro.65.1705053193935;
        Fri, 12 Jan 2024 01:53:13 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id dr18-20020a5d5f92000000b0033677a4e0d6sm3428824wrb.13.2024.01.12.01.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:53:13 -0800 (PST)
Date: Fri, 12 Jan 2024 12:53:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Fix double unlock in
 rzg2l_dt_subnode_to_map()
Message-ID: <300d204b-8151-45f3-9977-7ceb3a5c5eb0@moroto.mountain>
References: <f8c3a3a0-7c48-4e40-8af0-ed4e9d9b049f@moroto.mountain>
 <185128ab-f229-4b40-91cd-ebdc138e11ac@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <185128ab-f229-4b40-91cd-ebdc138e11ac@tuxon.dev>

On Fri, Jan 12, 2024 at 10:55:40AM +0200, claudiu beznea wrote:
> Hi, Dan,
> 
> Thanks for your patch!
> 
> On 10.01.2024 20:41, Dan Carpenter wrote:
> > If rzg2l_map_add_config() fails then the error handling calls
> > mutex_unlock(&pctrl->mutex) but we're not holding that mutex.  Move
> > the unlocks to before the gotos to avoid this situation.
> > 
> > Fixes: d3aaa7203a17 ("pinctrl: renesas: rzg2l: Add pin configuration support for pinmux groups")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > (Not tested).
> 
> I've tested it on RZ/G3S SoC and all is good.
> 
> However, I think, to keep the locking scheme unchanged and simpler (FMPOV),
> commit d3aaa7203a17 ("pinctrl: renesas: rzg2l: Add pin configuration
> support for pinmux groups") should have been call rzg2l_map_add_config()
> just before the mutex is locked. That would be the following diff:
> 
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -447,6 +447,16 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev
> *pctldev,
>  		name = np->name;
>  	}
> 
> +	if (num_configs) {
> +		ret = rzg2l_map_add_config(&maps[idx], name,
> +					   PIN_MAP_TYPE_CONFIGS_GROUP,
> +					   configs, num_configs);
> +		if (ret < 0)
> +			goto done;
> +
> +		idx++;
> +	}
> +
>  	mutex_lock(&pctrl->mutex);
> 
>  	/* Register a single pin group listing all the pins we read from DT */
> @@ -474,16 +484,6 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev
> *pctldev,
>  	maps[idx].data.mux.function = name;
>  	idx++;
        ^^^^^

> 
> -	if (num_configs) {
> -		ret = rzg2l_map_add_config(&maps[idx], name,
> -					   PIN_MAP_TYPE_CONFIGS_GROUP,
> -					   configs, num_configs);
> -		if (ret < 0)
> -			goto remove_group;
> -
> -		idx++;
> -	}

Does the ordering of the maps[] not matter?

> -
>  	dev_dbg(pctrl->dev, "Parsed %pOF with %d pins\n", np, num_pinmux);
>  	ret = 0;
>  	goto done;
> 
> Would you mind doing it like this?
> 
> Please, let me know if you want me to handle it.

Either way is fine.  Whatever is easiest.

regards,
dan carpenter


