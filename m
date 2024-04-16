Return-Path: <linux-kernel+bounces-146431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BCC8A652B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE9028447D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA58249A;
	Tue, 16 Apr 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHdVgNVw"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5A78C66
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252742; cv=none; b=Ll3ZYxRV4SsEcM//0mgodnqvtsIULwo6pfAovz07FZTQfNsFeAA/t5obZsGYETD0xjrn6vYOLo7jiM6QWvkm04KkQf03MKyzwRY4rK1N/X+NlCS0Q29eL0xDTWIBIDm4sZBQAJ8nkaqWRiJStVONMzfihtO1XXdkzoNHfa5Vb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252742; c=relaxed/simple;
	bh=Cs1dgXPtyii2K9Gr9D0keZ57yvHI7OfDP8UWsuFVXPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDCcdgEh3AZXKdmfqBdMF9QhoddEKrOqmIwKdiDXVHDZMDDd56JimCH7qJZgyiP2w8zOAvQkVMNn0fJmM4eZvOxrHNl01DvmWPBjj4peudibgfEHGn+dywxasEtk78rT/r7xANVKsPAjxWqdk0KJVwPWlegDiL+7Cecn9XhXaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jHdVgNVw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51beae2f13so459191666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713252739; x=1713857539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8R9bVOGo16amHaHdQgn3vohiOg/80cUEYV+3t7qlHzM=;
        b=jHdVgNVw0xBVycy6FryZ/6a/Xi0qXaubIU5rhNKkprqtgwmPi9meLe5k4zG6cyYM0+
         mY7rWYsVMxd3whSYm19DgwcmIc8NovyyQ33uncARihnb9WImpyt1/tUMQKa5UqBBQI01
         xYqlJRLWJulSbW1m5uNb2RhM32xcQzwI7X8Z4rENT55gwpQrHd8f95D8E/sDi5JWSDEz
         6+7Sw2KGcjHP4AW4DtljQ+oRJZ0wsRQa3Euy/BaYS5P1ihyr8PCverM5GBIGfxhp+AwX
         ky4CjKOxkjS/mR3Eh0iST5+t9O2wF2V/72j27kIEtnM4yzrrochKOVihGlJtYM5qaQNQ
         hqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713252739; x=1713857539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R9bVOGo16amHaHdQgn3vohiOg/80cUEYV+3t7qlHzM=;
        b=roMCRrqGrWwSGEiYl22vh8Z6SIqYxF9Etvuj1xmg5soDon44FJNf6GPhB7njavB5xn
         ReUQzYQ63L8CiXXToCP9OkwLoi66o8jpIg/XD2SI9lxhqh39wPb0S2tmfenn2Fq5QWs1
         C9rylkNXiwH6BORyRiQQUNVrf07UAbmweYlMkCqx8xDSKa4za4IgFvGA/szGE9akVsFn
         vmEs7LW207yTCbfC1A056aZQ2P1CrWO8vekhKCmCc/BRPVJNLVR2X0Hi6gE0/ubNWLaE
         H4w/PFYnYEibnXxdQbuBZFb9opmUSf8tKgCYrWK01XqLwRdS1tNLNpp/kojtSuZb5nYn
         Zpnw==
X-Forwarded-Encrypted: i=1; AJvYcCUP4KW0W+30T+exeRuIz7euN11CZi/0oFapq+Rbo//bKWEDRDMQwEidYe8b0OYE/HKgGI0ZcidVwZ/HBS/Rf93dCYt8o6ZMyaTM7ZMb
X-Gm-Message-State: AOJu0YzgJJuEQPlZZyBeuUwG9xkYT54khYgRqmkXU2nddQOA2t37oTBR
	ynCjV55n2fKTWGzJzM1F9FZ5vD8x2IQlqOJmJGo7tpFbmEsmyVrqVLUu5zYrfPA=
X-Google-Smtp-Source: AGHT+IEiSwmXJXJlRrwBTxtu6/XHomvPQRR0BAqxebaWeb0WkKlHDct2PHGh5ytZktKV5zyNXHYwQg==
X-Received: by 2002:a17:906:57d6:b0:a52:6c4e:25ae with SMTP id u22-20020a17090657d600b00a526c4e25aemr2620587ejr.44.1713252739010;
        Tue, 16 Apr 2024 00:32:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qb11-20020a1709077e8b00b00a51ab065bf0sm6421883ejc.202.2024.04.16.00.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:32:18 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:32:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>,
	Abylay Ospan <aospan@netup.ru>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Dmitry Osipenko <digetx@gmail.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Pavel Machek <pavel@ucw.cz>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 02/35] media: stb0899: Remove unreacheable code
Message-ID: <e5824d5b-9aa4-4b92-91a4-7e26de8b293d@moroto.mountain>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <20240415-fix-cocci-v1-2-477afb23728b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-fix-cocci-v1-2-477afb23728b@chromium.org>

On Mon, Apr 15, 2024 at 07:34:19PM +0000, Ricardo Ribalda wrote:
> chip_id is an unsigned number, it can never be < 0
> 
> Fixes cocci check:
> drivers/media/dvb-frontends/stb0899_drv.c:1280:8-15: WARNING: Unsigned expression compared with zero: chip_id > 0
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/dvb-frontends/stb0899_drv.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/stb0899_drv.c b/drivers/media/dvb-frontends/stb0899_drv.c
> index 2f4d8fb400cd..222b5476ebfd 100644
> --- a/drivers/media/dvb-frontends/stb0899_drv.c
> +++ b/drivers/media/dvb-frontends/stb0899_drv.c
> @@ -1277,11 +1277,6 @@ static int stb0899_get_dev_id(struct stb0899_state *state)
>  	dprintk(state->verbose, FE_ERROR, 1, "Demodulator Core ID=[%s], Version=[%d]", (char *) &demod_str, demod_ver);
>  	CONVERT32(STB0899_READ_S2REG(STB0899_S2FEC, FEC_CORE_ID_REG), (char *)&fec_str);
>  	fec_ver = STB0899_READ_S2REG(STB0899_S2FEC, FEC_VER_ID_REG);
> -	if (! (chip_id > 0)) {

This is not dead code.  It's possible for chip_id to be equal to 0.

regards,
dan carpenter

> -		dprintk(state->verbose, FE_ERROR, 1, "couldn't find a STB 0899");
> -
> -		return -ENODEV;
> -	}
>  	dprintk(state->verbose, FE_ERROR, 1, "FEC Core ID=[%s], Version=[%d]", (char*) &fec_str, fec_ver);


