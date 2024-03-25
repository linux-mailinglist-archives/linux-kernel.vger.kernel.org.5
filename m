Return-Path: <linux-kernel+bounces-116895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB1C88A67D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC08B35A78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C63A12C80D;
	Mon, 25 Mar 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGpnpF/U"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0B19D1B7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363970; cv=none; b=MIqApujnWzwL8MrV3b/3fyVA7sDhUKiKVUomF71rO8BvHwLy4l+A71MHevsHX+sie0BMf8Ii82qbi25sIBENop/lZoi8zKNS4HyEEo8pULvphxDVJsPSssyhmmbTGCsRd7BOIf5ZCSmhZY/RxLOV5cwDudK17a7jIjeGgS8rqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363970; c=relaxed/simple;
	bh=krCHL+qxAQ4SQ2psaIH85lNezKIzeTKZh1ZNAsaTRY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN7fS4lraJ2ZIZnhLLvWExAdqAhKOBFrCjOpC7ckaoJ9oCRgDTSyEKZkCmeqQPcsoZCksW0ctYqMZj67ohg7TTpjN43a79S3nP/C1aRWmf7vnIq63r577u1sT9qPhgbUt1sUL1krL3bVDjXayTvcLvV8s4C0xRtKdz22mOEHT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGpnpF/U; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515a81928a1so1744249e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711363967; x=1711968767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B/45gkU1OW/Fa6jqiOKHWiKJTgLo8h9uP7u3dIPIa2Y=;
        b=xGpnpF/UIQYWQY/gDMIz6KBG+snbPIYjkMDxZrK3B8rFRKledvnifIcno/7ZY2naNc
         oNTvJcFyuU22bbKFpTbAat4bOnE3EUWH1CvVAWs+cxakG1yod4lTwpnNx6yFfBmT7KLP
         APQGNjGQdYCdqQrBjTDYAqB3ZB2P+ix5fobRRWoyVCXVOuzzateS7Ep+dPIuxfXdcVBu
         6mmASZF8vdhe1aQa8QudENDJUtbZGIKaRS3axCItweI9RxlYee7HIlPSzx3Njk7nK5zl
         PX87ihlyNetTCK5K2Y6ZHTX57Ka6plQR8Gg9dJwd7eS+qXhOkseaWp5ClRTxdbVftJcr
         bpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363967; x=1711968767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/45gkU1OW/Fa6jqiOKHWiKJTgLo8h9uP7u3dIPIa2Y=;
        b=lDnl/iD8gfc6JQ23uly9sPDqKGZydQHHPFMJrcL2ruWI2OVmlBkCNoINMPWlEPnmuh
         5XblSHD77KbVk0hwELk+sC9fthjHwMgx2g//vSoPgLLAB45lG2MMHyysPbgtM0baOGRT
         a+sUaZFRwO2WFq5UZb31GfVVXhlb7lrMC5mMcsBeEoOn3ZKQJkFHOfqdI/5aDIkpAcxF
         2erxZNFi0jRdn29U0ChHaVO6vbGGWOB79EISlKogDP5yoHEJQcDjTZaIxQmFZ+3Q/pex
         QKDa76/6DF49hKVNdGqm81P6e5WSZ+AH2pdI79EL7TAkAUaarPOl2WGTz9hjDvH21QGw
         xNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4XfWOHiRHT+PEh48641Z7Mxjw0AKzwycbFUbJv5kY9HEgyaWQ1M/wBY+a1a0PteTexvgbondqOre8e56skyzXzmfh3ljxdSthzQsA
X-Gm-Message-State: AOJu0Yx8AViAjND/K03PIz0CdweV1kFIXpalk0YoI5ih7suSfMghk542
	VZX1yAR46a8H00nSW6WRvL8+nC+wpZbBVwSJFnC7lgbCxwNvL21wfcXMIpTgcVI=
X-Google-Smtp-Source: AGHT+IEclAfbiEIquW9pL3ASZRMHbyWd/lIOzT5bu64XepiQ3fVd79XZUHfg0x/tT73njuoHcmQwYA==
X-Received: by 2002:a05:6512:1590:b0:515:a9d5:aab6 with SMTP id bp16-20020a056512159000b00515a9d5aab6mr3848775lfb.18.1711363966528;
        Mon, 25 Mar 2024 03:52:46 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id kj9-20020a170907764900b00a4636d9d28dsm2903246ejc.69.2024.03.25.03.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:52:45 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:52:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/11] riscv: Kconfig.socs: Split ARCH_CANAAN and
 SOC_CANAAN_K210
Message-ID: <e255a964-27bf-4eb9-8e9a-4f60d1ccd12b@moroto.mountain>
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
 <tencent_F208A26B5338C6E14AC6648730368AF0FD0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F208A26B5338C6E14AC6648730368AF0FD0A@qq.com>

On Sat, Mar 23, 2024 at 08:12:17PM +0800, Yangyu Chen wrote:
> Since SOC_FOO should be deprecated from patch [1], and cleanup for other
> SoCs is already on the mailing list [2,3,4], we remove the use of
> SOC_CANAAN and use ARCH_CANAAN for SoCs vendored by Canaan instead from
> now on. And allows ARCH_CANAAN to be selected for other Canaan SoCs.
> 
> Then, since we have Canaan Kendryte K230 with MMU now, the use of
> SOC_CANAAN is no longer only referred to K210. Thus, we introduce a new
> symbol SOC_CANAAN_K210 for any conditional code or driver selection
> specific to the K210, so users will not try to build some K210-specific
> things when MMU is enabled and see it fails to boot on K210.
> 
> [1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@kernel.org/
> [2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spud/
> [3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46bb29@spud/
> [4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655a4d@spud/
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/Kconfig.socs                        | 8 +++++---
>  arch/riscv/Makefile                            | 2 +-
>  arch/riscv/configs/nommu_k210_defconfig        | 3 ++-
>  arch/riscv/configs/nommu_k210_sdcard_defconfig | 3 ++-
>  4 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 623de5f8a208..5710aee456ac 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -72,11 +72,13 @@ config SOC_VIRT
>  	  This enables support for QEMU Virt Machine.
>  
>  config ARCH_CANAAN
> -	def_bool SOC_CANAAN
> +	bool "Canaan Kendryte SoC"
> +	help
> +	  This enables support for Canaan Kendryte SoC platform hardware.
>  
> -config SOC_CANAAN
> +config SOC_CANAAN_K210

This breaks git bisect, right?  There are references to SOC_CANAAN that
are get updated later in the patch series.  You can't delete SOC_CANAAN
and leave the other references dangling.

regards,
dan carpenter


