Return-Path: <linux-kernel+bounces-6423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A968198A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BC31F25528
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91611CAD;
	Wed, 20 Dec 2023 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zoiVQdE5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521B13FF5;
	Wed, 20 Dec 2023 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=yy3Pd8xxVQGvQhu3e4sEndMfOiP5mA8UbKObDBwiH1M=; b=zoiVQdE5Br0fTA1+Sn9IQcEluf
	Rx4NTC6svRwUJDH66srMrY7jrUKBnydtcGe07wqhqh0JCnqVRLs0IqOE82URdB+ApI6LK4/wuE4IB
	zl4MPSktxQrlM+d+yTk+003gJlaho8XEXWLM3azSgOYDcWGcozqvdbQ7yh3TJmuJaQH//xhIlm2eT
	6gpi6NLKpwqgVRRtpWzN+bLFvRTgNhmCSJ5+V6PH/jfW3QYWIR4Mh/YDKT2YbualcJp61E1A0xEIS
	+ECesDqDt2apeC6OUu0E/gpQXrJuN7nnyraKRlBh3VLUI8c+2tRjwLtPVcCFKnz85jB/F8h8U0V1H
	G9zsY5vw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFq8O-00GJ40-2Q;
	Wed, 20 Dec 2023 06:32:48 +0000
Message-ID: <9c955128-6867-4d0a-b2f1-eab692748315@infradead.org>
Date: Tue, 19 Dec 2023 22:32:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc/tegra: fuse: Define tegra194_soc_attr_group for
 Tegra241
Content-Language: en-US
To: Kartik <kkartik@nvidia.com>, sfr@canb.auug.org.au,
 thierry.reding@gmail.com, jonathanh@nvidia.com, frank.li@vivo.com,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231220061013.120173-1-kkartik@nvidia.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231220061013.120173-1-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 22:10, Kartik wrote:
> Tegra241 SoC data uses tegra194_soc_attr_group, which is only defined
> if config CONFIG_ARCH_TEGRA_194_SOC or CONFIG_ARCH_TEGRA_234_SOC or
> both are enabled. This causes a build failure if both of these configs
> are disabled and CONFIG_ARCH_TEGRA_241_SOC is enabled.
> 
> Define tegra194_soc_attr_group if CONFIG_ARCH_TEGRA_241_SOC is enabled.
> 
> Signed-off-by: Kartik <kkartik@nvidia.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c | 3 ++-
>  drivers/soc/tegra/fuse/fuse.h       | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
> index 233b8e7bb41b..c34efa5bf44c 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
> @@ -407,7 +407,8 @@ const struct attribute_group tegra_soc_attr_group = {
>  };
>  
>  #if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC) || \
> -    IS_ENABLED(CONFIG_ARCH_TEGRA_234_SOC)
> +    IS_ENABLED(CONFIG_ARCH_TEGRA_234_SOC) || \
> +    IS_ENABLED(CONFIG_ARCH_TEGRA_241_SOC)
>  static ssize_t platform_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
> index f3b705327c20..9fee6ad6ad9e 100644
> --- a/drivers/soc/tegra/fuse/fuse.h
> +++ b/drivers/soc/tegra/fuse/fuse.h
> @@ -124,7 +124,8 @@ extern const struct tegra_fuse_soc tegra186_fuse_soc;
>  #endif
>  
>  #if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC) || \
> -    IS_ENABLED(CONFIG_ARCH_TEGRA_234_SOC)
> +    IS_ENABLED(CONFIG_ARCH_TEGRA_234_SOC) || \
> +    IS_ENABLED(CONFIG_ARCH_TEGRA_241_SOC)
>  extern const struct attribute_group tegra194_soc_attr_group;
>  #endif
>  

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

