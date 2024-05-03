Return-Path: <linux-kernel+bounces-167609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0698BABE7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE49B1C21C24
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51271509B2;
	Fri,  3 May 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTfKBZV2"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD3152535;
	Fri,  3 May 2024 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737286; cv=none; b=Bf/hEw+WLOBu6itpu2D/93M5vQvuqDiqp2q2pe/3N7evtAtKeTely2+E7WKgM3PTPNl86J8XDEVkw/19jmLnGrGgbAMKmT+xUdDQ8R+33NN+JwNDZ9YLbsAmfpjlGH2M/NAQqc/SjIxqIEW+66uU5tLwsjGg8qY74/RmMmrz0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737286; c=relaxed/simple;
	bh=3uoLblbVviTSySfRLQkzlYKhujxP1w39CaWd7TOXBiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRuLB2OOpWz+j51HjBNdN91DL8mQBYJXX0j3v+cCDjofpxu43+PXMgzwnjQoebeTPzf7ejOKt9yaNYxn/qLgChchwxcNGTopaUSg8eVpP1cFs+nqcdu2m4jpv7UX7SqmAwVY6wKwxzFnUnp0eSeC4Bf/43Hyh+eFsiCXtdKaf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTfKBZV2; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a55bf737cecso1184666066b.0;
        Fri, 03 May 2024 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714737283; x=1715342083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0oauZc70ukT9KbYDGTPtwlZBYsnxCGZgVEqDznEFYqQ=;
        b=hTfKBZV22SKavLho8JhWoMMCQQjXYbAuC/d3UJVyEuxiw5HPK5IDU4qiapAJhvpIhY
         2dMRRmxcxcWfMc6sLsTGAfEj1gggD2cuHQgV+fE0UbZH41zSZnwn0weowUT3s6pPADZp
         fkcdoe0Ya7LnRbjTkcI4Uc+uozY8vqfeQwDhvdFqsNcjtJix/R/kagDRsnwFVTLe5KiX
         u3xp1ESVM7AmVpQlSLCbqpvTIqyzgpEX/KvYSi3v8OrEwU+ZyHOAICBKaQppMc7iXxgf
         pGf3wpLNbnlHZ5HQsybaYGYb0PW3cOffJZ8jbMhFuS3amHDZ/kt4Xrx8HFgnvG/8JLf5
         eflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714737283; x=1715342083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oauZc70ukT9KbYDGTPtwlZBYsnxCGZgVEqDznEFYqQ=;
        b=P1B80E5ooCDaooVeQvF94gXmkaPMJkap9NNuS3FQY1GuTyA7xaVGLTMzkOeTe8dyK0
         VHQDufKhHMHNytROABqeEGisjijACzmDuOMbwhcbPV5LX23bcx2qSB7hIngYStTxIkpD
         ndNhwBDMm/M0WQsoo9/KVibIkViboCPdU5NAOmun7TawU0EktkZp2EK4UqdDKa07PRBW
         qOnEGXaQnjtIaHQAJmHbBh5P0hw1Y4uDZKGWksF8lNayiGcJ8oOQJq17zq0ydCkvtFqy
         5N4xqAi7hpLby3yrxP1UCPsIDbdoJRUjZ5mkwZ7zgVn27kasT5o2NR29P0rpswNmBjF4
         tikg==
X-Forwarded-Encrypted: i=1; AJvYcCVw/HvnykNDeKF2MVTtCgB0YSmNjUyE5ZoRZSVW/EamoR4vbeGyvtwOjQnUvA6p/GTeAi9EI7MKf7XZlb3z/fGOM22jHeiLxkmVirA27/vwRKgG+aawl9IsrPxEeIat1q7n4pYspQ/09UwI
X-Gm-Message-State: AOJu0YzH2Evqmqh1api02Pa6dSVKRl26YId/Nka3fUga2K3hkDy9DWnR
	Jzupdgbq071taCZ1+telaPBLEQYTjxKIj2iQlKGYOhWL5KZ3aZj7
X-Google-Smtp-Source: AGHT+IHW15hSCP1X3duU6HX04FPukVySYrSsXbGUmXqmySFFVYB0m9NveeVvpZJWpndt2EmA6KT6JA==
X-Received: by 2002:a17:906:b7da:b0:a58:e4dc:ad99 with SMTP id fy26-20020a170906b7da00b00a58e4dcad99mr1573887ejb.2.1714737283388;
        Fri, 03 May 2024 04:54:43 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-47.cable.dynamic.surfer.at. [84.115.213.47])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906369500b00a596ea236f4sm1631792ejc.212.2024.05.03.04.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 04:54:42 -0700 (PDT)
Message-ID: <3823976c-13b6-4662-a9fd-7615cf69475a@gmail.com>
Date: Fri, 3 May 2024 13:54:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: hvc: hvc_opal: eliminate uses of of_node_put()
To: Lu Dai <dai.lu@exordes.com>, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com
Cc: mpe@ellerman.id.au, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, shuah@kernel.org
References: <20240503114330.221764-1-dai.lu@exordes.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240503114330.221764-1-dai.lu@exordes.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/24 13:43, Lu Dai wrote:
> Make use of the __free() cleanup handler to automatically free nodes
> when they get out of scope.
> 
> Removes the need for a 'goto' as an effect.
> 
> Signed-off-by: Lu Dai <dai.lu@exordes.com>
> ---
>  drivers/tty/hvc/hvc_opal.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> index 095c33ad10f8..67e90fa993a3 100644
> --- a/drivers/tty/hvc/hvc_opal.c
> +++ b/drivers/tty/hvc/hvc_opal.c
> @@ -327,14 +327,14 @@ static void udbg_init_opal_common(void)
>  
>  void __init hvc_opal_init_early(void)
>  {
> -	struct device_node *stdout_node = of_node_get(of_stdout);
> +	struct device_node *stdout_node __free(device_node) = of_node_get(of_stdout);
>  	const __be32 *termno;
>  	const struct hv_ops *ops;
>  	u32 index;
>  
>  	/* If the console wasn't in /chosen, try /ibm,opal */
>  	if (!stdout_node) {
> -		struct device_node *opal, *np;

Generally, you should always initialize the variable where it is
declared. What would happen if the variable goes out of scope before it
gets initialized? Now it is not dangerous, but if new code is added and
it returns because of some error, we might run into trouble.

In this particular case you can solve this easily by putting together
your modification and the assignment right after the comment.


> +		struct device_node *opal __free(device_node), *np;
>  
>  		/* Current OPAL takeover doesn't provide the stdout
>  		 * path, so we hard wire it
> @@ -356,7 +356,6 @@ void __init hvc_opal_init_early(void)
>  				break;
>  			}
>  		}
> -		of_node_put(opal);
>  	}
>  	if (!stdout_node)
>  		return;
> @@ -382,13 +381,11 @@ void __init hvc_opal_init_early(void)
>  		hvsilib_establish(&hvc_opal_boot_priv.hvsi);
>  		pr_devel("hvc_opal: Found HVSI console\n");
>  	} else
> -		goto out;
> +		return;
>  	hvc_opal_boot_termno = index;
>  	udbg_init_opal_common();
>  	add_preferred_console("hvc", index, NULL);
>  	hvc_instantiate(index, index, ops);
> -out:
> -	of_node_put(stdout_node);
>  }
>  
>  #ifdef CONFIG_PPC_EARLY_DEBUG_OPAL_RAW


Best regards,
Javier Carrasco

