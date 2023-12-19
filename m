Return-Path: <linux-kernel+bounces-5173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D965581878A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0981F23BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95B91804D;
	Tue, 19 Dec 2023 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlswlgzV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B0710E5;
	Tue, 19 Dec 2023 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-203fed05a31so8693fac.0;
        Tue, 19 Dec 2023 04:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702989263; x=1703594063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwHmTFeEehKOaOu6iVKukiI2Xe8hwl6/KhukRfcBoho=;
        b=SlswlgzVENskFx2o5i/QCJ2mW9gmKdsEkga3vORLJWVe77yWKiFWSyzwi2NqetHha6
         BPO1ajIZlTWXYXqZ8dk2HtQH8T2qJWiSLGt+3BrGeukARjb99K4oDIIJMWa8b26QUjOh
         JIq7hEaOx9L/kMK5dzSMgcLBSJeCACseEGEOTH9PIy+AvrEFVhBXjz5F1T1h1qH7oiIj
         1FJ/K0tUHMHSkrvxq3FGkrwbrPenKZt2Y5BubSByyaMkdVA77TKVEMopPByJ3cIEVx7s
         vfJ5FsRggC32m+T/3R09atcfBH4Kg82BMArWjm/oobxmVB1A3BG97Su7btcn+EIfG4Jn
         0fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702989263; x=1703594063;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gwHmTFeEehKOaOu6iVKukiI2Xe8hwl6/KhukRfcBoho=;
        b=u6Kml9vZu6ACoKTiZXugQcWYVjW2QqcySUn2lCcc+9JW3qQaekwBMo2H1ioiks/1Sf
         QPUm7E8ZQvP9yFE/rUyLSWL2lMUvQAP6Rh+rhcB5hPkmkSqEkwAKMV4xJP5C2qlVS1g6
         36GvpJnz0xQHhuqNhIRurCMLZllqi2cT8WUhiPXcOuudT9XGHTjQSqqonqbQ29qTosTw
         8uNoqg4iQ9FDqfEUiIWFM1IcrvuA2q/lGHyExrY1fp8o8ePluDS31qU1qDL+gFB2tNBb
         zvAodcB4XXLYl7Ufn7OuqKbAFA8G7PNWLTzgtGdjZQ6tFO9MWb1PTskqIAOActoMd+5c
         A/Ow==
X-Gm-Message-State: AOJu0YzktUt4F3rsf7+tX4xyGHyrUUZm4tZWixfmsovwf3a1LZEP9mtI
	Qo8QKdXEsXz14n2g79vPSQ==
X-Google-Smtp-Source: AGHT+IHVJBTzhlK2961aU1/aWwN2mixlQ7Nbh1X/XnRN9zpQEeKZ2hNCJt+RL5etGIFrj+gj/4oEiA==
X-Received: by 2002:a05:6870:40ce:b0:1fb:75b:12ee with SMTP id l14-20020a05687040ce00b001fb075b12eemr21809762oal.64.1702989262425;
        Tue, 19 Dec 2023 04:34:22 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id gb8-20020a056870670800b001fb4aaf261csm7004856oab.32.2023.12.19.04.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:34:22 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:b5d7:ee3a:2c5b:8083])
	by serve.minyard.net (Postfix) with ESMTPSA id 5A7C9180047;
	Tue, 19 Dec 2023 12:34:21 +0000 (UTC)
Date: Tue, 19 Dec 2023 06:34:20 -0600
From: Corey Minyard <minyard@acm.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] ipmi: Remove usage of the deprecated ida_simple_xx() API
Message-ID: <ZYGNzHt8yPMPTYfd@mail.minyard.net>
Reply-To: minyard@acm.org
References: <b1a7a75263400742e5fda6bd7ba426772dc8ef11.1702961986.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a7a75263400742e5fda6bd7ba426772dc8ef11.1702961986.git.christophe.jaillet@wanadoo.fr>

On Tue, Dec 19, 2023 at 06:00:39AM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.

Thanks, queued for next release.

-corey

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index d6f14279684d..b0eedc4595b3 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3053,7 +3053,7 @@ static void cleanup_bmc_work(struct work_struct *work)
>  	int id = bmc->pdev.id; /* Unregister overwrites id */
>  
>  	platform_device_unregister(&bmc->pdev);
> -	ida_simple_remove(&ipmi_bmc_ida, id);
> +	ida_free(&ipmi_bmc_ida, id);
>  }
>  
>  static void
> @@ -3169,7 +3169,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
>  
>  		bmc->pdev.name = "ipmi_bmc";
>  
> -		rv = ida_simple_get(&ipmi_bmc_ida, 0, 0, GFP_KERNEL);
> +		rv = ida_alloc(&ipmi_bmc_ida, GFP_KERNEL);
>  		if (rv < 0) {
>  			kfree(bmc);
>  			goto out;
> -- 
> 2.34.1
> 

