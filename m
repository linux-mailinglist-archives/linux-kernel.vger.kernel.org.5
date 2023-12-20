Return-Path: <linux-kernel+bounces-7419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAFC81A7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBBF285352
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD01DDD4;
	Wed, 20 Dec 2023 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ6zqdZV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9601DA35
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7cc0f5bcb4fso25599241.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703104590; x=1703709390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUVV3nvmIFREJ94/uU3gKA9j+xl55+CVV1feR0augDU=;
        b=cQ6zqdZV4e4fPxaGkejkFzKz6TwyE9J8QlM3mVe6xjPDOzuQ9xJ6Jy7Srk1VvHtJdd
         bn20Eq9ZtdOt2M+IE2Ds4eNqpewS2NgyLiO+YPt7xqbR46lIi5cNS54kLUUztWMNxMjp
         nqyQsvKXFa+G87Xn3l2ZZWpp2w1Rv7zB19rhOzTOyvXDWypGGMCOQPbYW/+V5VoaQ83Q
         0oIDHXbUbDnwLyCnMY7DPsIWWPR4SRn4cSqQCcmcijO6BuaRPdK7LvxrMw9ctDTNzC2K
         vPiHeNqfcxyaHsygvyOoQUAyck5IYs7shvxiNxxuBeSJPdwbIYdn3b080jWmQP1wlIhq
         lh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703104590; x=1703709390;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUVV3nvmIFREJ94/uU3gKA9j+xl55+CVV1feR0augDU=;
        b=MWhCGhA6CbodTvUd2vA62FPb5S0pLtwa1hENfT1iujfogabQ6yubcnEJGEQoHzVA+y
         hpgqUDhCzTccvANpOW7j/Y4vuhAWN/28wXhJCwVUrLb9lgrmCaosPkleUe69qHCRBUHN
         0I20yW0Cz5AzUi3PuolLdkEhBOnTVx7OVRiNfosHTiMG/qypUUpt7ueruGb0mGQM8AWY
         YJ41KnjFG4Rq+LGHVpjT/0ql/pXrq0WSObHVxlT3QoWgpwYdynWNBdgKo0qGc5nS4AWy
         ATetaxhdf2lKbCog4uyvWmZxv7ZsqL0mbTeTIzL7Yp/6kPg89+Tt+QToBQd07PCGz6It
         Q3vw==
X-Gm-Message-State: AOJu0YwpfQ2JQRw2PjiylKTyvEjPIPbTDuvSWGNV5O/RMXe+V5DllcW+
	V6x5bC8YqgLyYJowfLHvQjA=
X-Google-Smtp-Source: AGHT+IGlkuEIgtq/nlBc2/TpOgKhmmQQ7kSmxneFHS8SKf3JrvH1xOo8t3EsXoRMjo6Ovw5SmTJ9Fg==
X-Received: by 2002:a05:6102:c93:b0:464:92e8:5db1 with SMTP id f19-20020a0561020c9300b0046492e85db1mr323216vst.9.1703104590555;
        Wed, 20 Dec 2023 12:36:30 -0800 (PST)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id k15-20020ac8478f000000b004240481cee0sm182102qtq.58.2023.12.20.12.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 12:36:30 -0800 (PST)
Date: Wed, 20 Dec 2023 15:36:28 -0500
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: arnd@arndb.de
Cc: jdelvare@suse.de, kgugala@antmicro.com, mholenko@antmicro.com,
	joel@jms.id.au, linux-kernel@vger.kernel.org, soc@kernel.org
Subject: Re: [PATCH] drivers/soc/litex: drop obsolete dependency on
 COMPILE_TEST
Message-ID: <ZYNQTLzKBLW29nUS@errol.ini.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124161618.34ca07b3@endymion.delvare>
X-Clacks-Overhead: GNU Terry Pratchett

On Thu, 24 Nov 2022 at 16:16:18 +0100, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> As a minor optimization, this also lets us drop of_match_ptr() and
> ifdef-guarding, as we now know what they will resolve to, we might as
> well save cpp some work.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Gabriel Somlo <gsomlo@gmail.com>
> Cc: Joel Stanley <joel@jms.id.au>

Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

Arnd: since it's been a while (sorry about that), please advise on
whether Jean should re-send the original patch, unless you can grab
it directly from here and pull it through the soc tree:
https://lore.kernel.org/lkml/20221125142756.3e51a28d@endymion.delvare/

Thanks much,
--Gabriel

> ---
>  drivers/soc/litex/Kconfig          |    2 +-
>  drivers/soc/litex/litex_soc_ctrl.c |    4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> --- linux-6.0.orig/drivers/soc/litex/Kconfig
> +++ linux-6.0/drivers/soc/litex/Kconfig
> @@ -7,7 +7,7 @@ config LITEX
>  
>  config LITEX_SOC_CONTROLLER
>  	tristate "Enable LiteX SoC Controller driver"
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  	depends on HAS_IOMEM
>  	select LITEX
>  	help
> --- linux-6.0.orig/drivers/soc/litex/litex_soc_ctrl.c
> +++ linux-6.0/drivers/soc/litex/litex_soc_ctrl.c
> @@ -82,13 +82,11 @@ static int litex_reset_handler(struct no
>  	return NOTIFY_DONE;
>  }
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id litex_soc_ctrl_of_match[] = {
>  	{.compatible = "litex,soc-controller"},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
> -#endif /* CONFIG_OF */
>  
>  static int litex_soc_ctrl_probe(struct platform_device *pdev)
>  {
> @@ -131,7 +129,7 @@ static int litex_soc_ctrl_remove(struct
>  static struct platform_driver litex_soc_ctrl_driver = {
>  	.driver = {
>  		.name = "litex-soc-controller",
> -		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
> +		.of_match_table = litex_soc_ctrl_of_match,
>  	},
>  	.probe = litex_soc_ctrl_probe,
>  	.remove = litex_soc_ctrl_remove,
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
> 

