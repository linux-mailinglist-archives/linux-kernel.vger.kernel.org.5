Return-Path: <linux-kernel+bounces-165635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03A8B8EE7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A969B21186
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEC7DDAB;
	Wed,  1 May 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVpOppxs"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713C18039
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583819; cv=none; b=IYvyAHN/NFnVUh7uzy54z+ilpewOUPBJG8KbUWyzvirmeOJ34PulpNZ80qwlcvu4CPGSD5IlVumY1jZSfWUhOk0lKenfJUVSXmsPKhCImXyGAi3YpIXT/REvlJ+Iqrj5K1ry/Skp5Nv3cZG04IWJZwM4vM4XmM7CpOJnd36yFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583819; c=relaxed/simple;
	bh=02BhFBAy4ZX6ytoV+oKn8+uM4s9GylTFH+6SsonvGE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBw5E1df5DQhfcUA5U+BtV2mTuGWq6G8yNkZDZtRGvWTWilkVFxViKQpK8w0u9GIXLM+YdQ/zJ/aArfvXek5rHr/ljoGUcu2qJS6Y3cFBb3ckYr2h7odHUkrJIEG/ibV+pX6fAWuGTusF1IZf+FlmrnZgzICdtb46QLANjqWYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iVpOppxs; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51ef64d04b1so345659e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714583815; x=1715188615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOHqyTk2nsRZy88pDJJ/quBzrqb3UUPa7Yn14ZhLib4=;
        b=iVpOppxsz5ghxxUEB9NfOFKKI+6G8FWE8KMpEIgL0IzcDWO4UZU0AxzNOAubNoopfN
         wjDM612rx0zN/3xvdmazYR0SfUpXTWhGudu6WKk0hkW3jEUkVEA3CZ1UlmRSoRPZ/6Vg
         6jh64wo3h4vc8RtCyuPEogJauoXB7cj9we+zmVBImIlXav+Epi9zhso7KEwFJL8Oa+Fe
         D5oDbAAGeTOuSvCkxWVy6dZ6tkNo61rsMt3dn65YW4J5gK5gwwAh+GyeiY9KGXdMYwhT
         QOh0+tIniDa0BMRg+6CaFlTm2JlG1ykwbhZdyw/VV7ozKz3xoHVWT6DaM+O9Xs+DwgDM
         kLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714583815; x=1715188615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOHqyTk2nsRZy88pDJJ/quBzrqb3UUPa7Yn14ZhLib4=;
        b=VdG5qb/OgpE9HErZQulx3oQYDLYLsXbbLclVEIWp21+3LugUwwjaCTWx4lbKeTxwSv
         a6WIqMdN4p5wKoN0iOFVdkjNSX5mgbkSmqFRVmxdFZGDOniWAg2ceXgK+hM5ixtBbI1a
         jQ6mGnYfons2byiRhdR9AKUXVyBM9O4AqCiTSQ9ihihkpNdNATsHsvpuEYEE0GQibt/q
         gpNSNgygRbcEaKrVadVvHBS29+GHTG9q23QDctJ2a76bQmCYF2pFSfK2rH/9gXx6QbeQ
         5YTJXxzWOLz9jxSZBwyxbQ4NpnrDTOBwE5HmgV8W8iyUMBLlZa04iknk3sosA5sYvEjs
         Cbmw==
X-Forwarded-Encrypted: i=1; AJvYcCWrnjxQXBLV42uQKKBFA23yM64TFuYvdX5iASOC9iW0so9Wl+CnF2lWCOh10YHBG6Dt3AUU0HNRkUEWhn2fq47sL0NWeMEyCkEhKf68
X-Gm-Message-State: AOJu0YzuK0+2BDsjVHn/0BG8pOKidXjyLC4RSZ1k3a1yCcrdVuVEZRkc
	0JmGDldrdM4OXMKRGkDMn2KADQJ6hLNFSblfh3rhwVLTNRqJvpciSM1K980DXKQ=
X-Google-Smtp-Source: AGHT+IGQV4KLhJUah5uwpDXzYUszrhPNSItjqkYS07RJilfCu8tUsg9Dz64nf2enkLVMqtqy/1k75Q==
X-Received: by 2002:a05:6512:12c7:b0:51f:196:d217 with SMTP id p7-20020a05651212c700b0051f0196d217mr197144lfg.63.1714583815158;
        Wed, 01 May 2024 10:16:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t10-20020a192d4a000000b0051d5616c3e1sm1524897lft.231.2024.05.01.10.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:16:54 -0700 (PDT)
Date: Wed, 1 May 2024 20:16:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-samsung-soc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org, imx@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 10/21] pinctrl: st: Use scope based of_node_put() cleanups
Message-ID: <f6aa3a17-90d2-42e3-8c55-639dfcdbf8ca@moroto.mountain>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
 <20240501-pinctrl-cleanup-v1-10-797ceca46e5c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501-pinctrl-cleanup-v1-10-797ceca46e5c@nxp.com>

On Wed, May 01, 2024 at 08:56:08PM +0800, Peng Fan (OSS) wrote:
> @@ -1224,8 +1221,7 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
>  	grp->pin_conf = devm_kcalloc(dev, npins, sizeof(*grp->pin_conf), GFP_KERNEL);
>  
>  	if (!grp->pins || !grp->pin_conf) {
> -		ret = -ENOMEM;
> -		goto out_put_node;
> +		return -ENOMEM;
>  	}

You could delete the curly braces as well.

regards,
dan carpenter



