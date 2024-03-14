Return-Path: <linux-kernel+bounces-103473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A5A87BFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698391C22748
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8B071B43;
	Thu, 14 Mar 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSPPS5gY"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125BF71B27;
	Thu, 14 Mar 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429686; cv=none; b=HmjbJY2ZMFMgHo4lBzrvwdc+ROKkpkc137njjcaXhQnG/k0903J9wjMDmepJHZgydfJyfPobg44fl472rQjqBHM8uRFTZJRNSOBlSVRMfEy0F3oMbWrCuWU0MxgcFUA5zh8T5P26ryUol10b4JJo76oTihOVTCJVn688oCq8Qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429686; c=relaxed/simple;
	bh=Nxn5JtOFrYpN0fHpacI2byBmMGBLKNGEX9bKalqA2BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4mYLpLCybJWMgdgLa75wCRn+q/jmRgALQ/AP4CRftc5MY0C6174ZC2Nx+hwXrlE+d2caL+Vf0bx5VKWyHAiMC8o8gSnMavhqZeGjUogizbEdkHy9r0C4SX1T8wWBH0FnfQvS5ZXJnNdH3hLIJSes17yuJlNrAw/3eJ3pNcysQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSPPS5gY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6082eab17so1030223b3a.1;
        Thu, 14 Mar 2024 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710429684; x=1711034484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7sWNt577aBHDyddBZ3kkUFNs3z9eJyKWD9qgLbpckE=;
        b=SSPPS5gYQlIWQSZo7CBjX/wMs/KE7HrADgJAG6jtVjIdi7ym4YlpkI9vwUcgQ59PBr
         41ZaPQONVQD8K0bW29Uc7tebV/rpN8xWUkZ8gzX7qIsIYKA9w33zzlpzwFwCE6/7fPDu
         R5FJalb1YI3D71e9TUMHZCNPUVY13A+OIe4irFRuUb9GnE7so6JA7/fmtXtttUm3lOTj
         m6DlhweXnWWMCh4+dapnT0rRfTDCwa3rYOwm5a6VGCGTpdV4dXrWpJ5UIxwp+LdrVpGw
         mmTswOQ8Ogb00e0xQlDVC5S+0ELqN5HO0iedWWTKQsu+bB17vR5a/trbo0SPJNyDQ2Vp
         HCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429684; x=1711034484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7sWNt577aBHDyddBZ3kkUFNs3z9eJyKWD9qgLbpckE=;
        b=D4uQlRLURbq2gmGCJwnSLrP+onxV85oANQvEiJvbSP5u3doFCveSCWq4vVlIbwxFK2
         e2D0VQtPPmFaOQJoIRC75SF6mE2/CA1dD806oA1TpkaaoQ5sKhtUGIUyNA3jl+CEhp76
         2qABSdlV2+/4t0gteH48UI8k9zAcUGzdrk/7BZWPEjyx9OH4RXol3S/NdKqzjaLMin79
         M2P4LCzOycNBLvR7lC3+zAOc8vaJRQZc4FT7rHkbj//VTf6AA/efrxjltEWFfJ94PuFc
         GMgzjJj3PLoZmL2nBya3JIAUmb1TsWUCUS1nNmZ2sa8ZuXfxFo1KzEnaKG/RhVRJOS0i
         H8vA==
X-Forwarded-Encrypted: i=1; AJvYcCXX1Qj1MDIwPhcywOBfM9SMbA7CcExmMvktcZKdm5rfO+UaF8/deRKUnre9Aook3Gc2jH+DFZW9Cx/F2kUgzitjAi/vYA5jcmSAOcCEXFHRQHQKpHkswvfzGbQ8dk1VkylGqyAZ5Crg56trFT8w7QDqYu3vCFis3RA/9Z7JOAvRkZ/vO8vE35XrYeIsWTUzlDxjAgd0S9VjZ38A2g4=
X-Gm-Message-State: AOJu0YwFckHrbvZ5xWZx3J1KLYWVkl+2VVZxhIWlbYIEPr7zpKYtMX0h
	idZc1K5N8Xsf4z02W5+nAnqnkP7gFvPwfSkM7gQzFiEGrehNY0FR
X-Google-Smtp-Source: AGHT+IE976LiIs3J+wZRKHFMiWO2GPc/z1HYI5pokfTUW/WlvRcrsBtERWAE0daVU3yJUtEiJynjHA==
X-Received: by 2002:a05:6a00:2312:b0:6e5:eab8:4db8 with SMTP id h18-20020a056a00231200b006e5eab84db8mr2351181pfh.17.1710429684285;
        Thu, 14 Mar 2024 08:21:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y1-20020aa793c1000000b006e6795932a4sm1618767pff.80.2024.03.14.08.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:21:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 14 Mar 2024 08:21:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	Simon Horman <horms@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v9 07/27] net: wan: Add support for QMC HDLC
Message-ID: <bd7b7714-1e73-444a-a175-675039d4f6e4@roeck-us.net>
References: <20231115144007.478111-1-herve.codina@bootlin.com>
 <20231115144007.478111-8-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115144007.478111-8-herve.codina@bootlin.com>

On Wed, Nov 15, 2023 at 03:39:43PM +0100, Herve Codina wrote:
> The QMC HDLC driver provides support for HDLC using the QMC (QUICC
> Multichannel Controller) to transfer the HDLC data.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> ---
[ ... ]

> +
> +static const struct of_device_id qmc_hdlc_id_table[] = {
> +	{ .compatible = "fsl,qmc-hdlc" },
> +	{} /* sentinel */
> +};
> +MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);

I am a bit puzzled. How does this even compile ?

Building powerpc:ppc32_allmodconfig ... failed
--------------
Error log:
In file included from include/linux/device/driver.h:21,
                 from include/linux/device.h:32,
                 from include/linux/dma-mapping.h:8,
                 from drivers/net/wan/fsl_qmc_hdlc.c:14:
drivers/net/wan/fsl_qmc_hdlc.c:783:25: error: 'qmc_hdlc_driver' undeclared here (not in a function); did you mean 'qmc_hdlc_probe'?
  783 | MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);

Guenter

> +
> +static struct platform_driver qmc_hdlc_driver = {
> +	.driver = {
> +		.name = "fsl-qmc-hdlc",
> +		.of_match_table = qmc_hdlc_id_table,
> +	},
> +	.probe = qmc_hdlc_probe,
> +	.remove = qmc_hdlc_remove,
> +};
> +module_platform_driver(qmc_hdlc_driver);
> +
> +MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
> +MODULE_DESCRIPTION("QMC HDLC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.41.0
> 

