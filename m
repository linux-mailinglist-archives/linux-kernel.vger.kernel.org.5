Return-Path: <linux-kernel+bounces-7414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E2D81A7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4A51F231BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AAC1DDD4;
	Wed, 20 Dec 2023 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTCsxwbp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE641DA35;
	Wed, 20 Dec 2023 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b9f8c9307dso28442b6e.0;
        Wed, 20 Dec 2023 12:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703104531; x=1703709331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVoim3ZI7VZX/tKDQGzFMPPOl07OuoqY3KhlixMQhCE=;
        b=cTCsxwbpYjiSwZD7+ep45sjVKSQmqTV7FfqP+W/KGb3ce6Q1A2cNcqWv3/FiZb+Dee
         l2pK3eENiTj+ZCX88o8MnJTbuyEwwKpvAzBPo7nWOHGFiYncQxYwGI3ARjDwD1ZpDeCt
         1lBjcrJKGC240t5TwjA7VgkyHKQT6OWfUQbIGfrTrblONI6co4XEyzWN+YL6FGdnsneF
         FYHIiFp3k7KXYf61Wedjw4/MwmVsiVip1YpY+UypBFu0IHLJePe0ryzzZPg8PX4LN4pr
         aEAsuF365JPm33lGRdcTT2tKgXFsOsM6cJjAIN2RKHgQmgQw0VZ57lp3ler5P80LDHqc
         jZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703104531; x=1703709331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVoim3ZI7VZX/tKDQGzFMPPOl07OuoqY3KhlixMQhCE=;
        b=H1WJxjDVmFUhwp7u9U0Fql8JGu1pGHiYjOxMpfwDk4E9/LUp3uz3KHKEvdzWObF9RZ
         gwFp2CvNsFhcoLfeH2m6iUfQ1OvGONrLK/HafIuK5vUk9Lsfm72WoZ/0PHcHO0kY4o6j
         9nbwroZN9weHknJp7akZ4M36LPuoOhUO4eG7xTtdOWsV7Ln9IRbHtgBvnzK8oC0MH7pF
         hyNqHoyBTy1LbaQLFc2xhj4xQVieSQqgxAr2BNw3MJctCnUTfqcoqYUvZWwRGJBTYXhY
         qc0qeX9rPsRsF8fcU+4DKWZFm9qBbAFrfJB4G2MQweP1a/a0LBxXZe+6Ji3MivLTX9bk
         6K8A==
X-Gm-Message-State: AOJu0YzLgLKGWahlXNIpISxCqtlu+hoPwnM6573R/Zj6sloylf9WfCaG
	6JSppfj2Lfl9qFahBFTUGV0=
X-Google-Smtp-Source: AGHT+IH6PMDyng/5PnOlcknBm5cZ5WiPB0L/Y1T9IJYbEWvlvF71Ms3ilAkxMRNhfQTcavEdbDFhhA==
X-Received: by 2002:a05:6808:2129:b0:3bb:7681:aac with SMTP id r41-20020a056808212900b003bb76810aacmr642856oiw.79.1703104529811;
        Wed, 20 Dec 2023 12:35:29 -0800 (PST)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id er14-20020a056214190e00b0067f4886019dsm142513qvb.122.2023.12.20.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 12:35:29 -0800 (PST)
Date: Wed, 20 Dec 2023 15:35:21 -0500
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: arnd@arndb.de
Cc: soc@kernel.org, Andrew Davis <afd@ti.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>, Mark Brown <broonie@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH RFC 2/5] drivers/soc/litex: Use
 devm_register_restart_handler()
Message-ID: <ZYNQCTIRDj1VAwPJ@errol.ini.cmu.edu>
References: <20231117161006.87734-1-afd@ti.com>
 <20231117161006.87734-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117161006.87734-3-afd@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett

On Fri, Nov 17, 2023 at 10:10:03AM -0600, Andrew Davis wrote:
> Use device life-cycle managed register function to simplify probe error
> path and eliminate need for explicit remove function.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

Arnd: the original patch is available here for the purpose of pulling via
the soc tree:
https://lore.kernel.org/lkml/20231117161006.87734-3-afd@ti.com/

Thanks,
--Gabriel

> ---
>  drivers/soc/litex/litex_soc_ctrl.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> index 10813299aa106..7a0096d93c73d 100644
> --- a/drivers/soc/litex/litex_soc_ctrl.c
> +++ b/drivers/soc/litex/litex_soc_ctrl.c
> @@ -69,14 +69,11 @@ static int litex_check_csr_access(void __iomem *reg_addr)
>  
>  struct litex_soc_ctrl_device {
>  	void __iomem *base;
> -	struct notifier_block reset_nb;
>  };
>  
> -static int litex_reset_handler(struct notifier_block *this, unsigned long mode,
> -			       void *cmd)
> +static int litex_reset_handler(struct sys_off_data *data)
>  {
> -	struct litex_soc_ctrl_device *soc_ctrl_dev =
> -		container_of(this, struct litex_soc_ctrl_device, reset_nb);
> +	struct litex_soc_ctrl_device *soc_ctrl_dev = data->cb_data;
>  
>  	litex_write32(soc_ctrl_dev->base + RESET_REG_OFF, RESET_REG_VALUE);
>  	return NOTIFY_DONE;
> @@ -107,11 +104,9 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
>  	if (error)
>  		return error;
>  
> -	platform_set_drvdata(pdev, soc_ctrl_dev);
> -
> -	soc_ctrl_dev->reset_nb.notifier_call = litex_reset_handler;
> -	soc_ctrl_dev->reset_nb.priority = 128;
> -	error = register_restart_handler(&soc_ctrl_dev->reset_nb);
> +	error = devm_register_restart_handler(&pdev->dev,
> +					      litex_reset_handler,
> +					      soc_ctrl_dev);
>  	if (error) {
>  		dev_warn(&pdev->dev, "cannot register restart handler: %d\n",
>  			 error);
> @@ -120,20 +115,12 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static void litex_soc_ctrl_remove(struct platform_device *pdev)
> -{
> -	struct litex_soc_ctrl_device *soc_ctrl_dev = platform_get_drvdata(pdev);
> -
> -	unregister_restart_handler(&soc_ctrl_dev->reset_nb);
> -}
> -
>  static struct platform_driver litex_soc_ctrl_driver = {
>  	.driver = {
>  		.name = "litex-soc-controller",
>  		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
>  	},
>  	.probe = litex_soc_ctrl_probe,
> -	.remove_new = litex_soc_ctrl_remove,
>  };
>  
>  module_platform_driver(litex_soc_ctrl_driver);
> -- 
> 2.39.2
> 

