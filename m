Return-Path: <linux-kernel+bounces-11348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E11581E4EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF221C21C41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200014B12C;
	Tue, 26 Dec 2023 05:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5IPCPV/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D44AF94
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dbd6a9b8d0so1478042a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 21:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703567552; x=1704172352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0iNKdIpJSITWaZLzy5O8z2rRPM6jmHasdKMlm7CuZQ4=;
        b=x5IPCPV/OkExca36+bDZzhqS6xPzDkB4Fl+wJOGPj009Jnc1FuiqArYkA6VpU6orXY
         E4FTiU8Ip9PKMWFLGlgFBUr2ISvScv0sqwyhddkIWSwjfrr0GCWEfz//mgzy1B4F3ki5
         w6xlHmvzsov7omWm3KpQiIp3Xa8WqXuiRTTs7+Xqnjajz26u81PbiDz64RgoGsY30sYm
         8dbsGL7VUuEypWQni6PhZ1m8WkxoPSDhSHqBN4i/vmqBkwM8AD+Ubj0qLkqT9HK0vqvB
         y4FS24ytxrD3RnROyV1IjqIj2WNL1r05Kjk204zfTer8YPg13sxYUFUHn4LOMQLW8wMX
         7PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703567552; x=1704172352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iNKdIpJSITWaZLzy5O8z2rRPM6jmHasdKMlm7CuZQ4=;
        b=Je874We3Ve/plPaXeI65j89Cc0hkGqxaIoTL2ueWv/8mky1oJBzv0AJ65MternsAfI
         GCsHiFAddsQSijeG4/EqciJAg9upSNL/TcLccUNP1Jj1mEdRMqixfZoZnuObt3xR2qEV
         pxuu+wNnOo1ZKWlZLfBiPU66edkx10OOIbNDHGCee1PH5iV55dDZpCuOET8QQsxmRa14
         IcARkugQdh4khDr+QLX5wkqKugKPcGvvZV7HY7EwF0HBnZktFLNFJdWBdB5c7rlgCeWE
         VaT92aDbGxomUGjJ6Z6+jk0PTo1BLMdgcZAqBmqPt0AW8aYrDCZqv/KMsNv5+SeknLFh
         Y6BQ==
X-Gm-Message-State: AOJu0Yxx4yW/MGVe6MB3K5YbVisD3OqatbJY/c/2emeb9A1RfuhalzoO
	kGeatlErHJID/oHw6g3fE/zLVfUBKlR+Ag==
X-Google-Smtp-Source: AGHT+IFaY/J977H+wxPYPiTUpnLSv9MnQE/pcBU7ImIz5cO01ECm+my/zk6hCHdW8re2ZtavqBsjvw==
X-Received: by 2002:a05:6830:1610:b0:6da:32b3:529f with SMTP id g16-20020a056830161000b006da32b3529fmr4096002otr.49.1703567552036;
        Mon, 25 Dec 2023 21:12:32 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006d9af59eecesm3810268pfn.20.2023.12.25.21.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 21:12:31 -0800 (PST)
Date: Tue, 26 Dec 2023 10:42:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
	sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org,
	daniel.lezcano@linaro.org, rafael@kernel.org,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	m.szyprowski@samsung.com, xuewen.yan94@gmail.com,
	mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
Subject: Re: [PATCH 1/2] OPP: Add API to update EM after adjustment of
 voltage for OPPs
Message-ID: <20231226051228.oe7rpgf34nwgr5ah@vireshk-i7>
References: <20231220110339.1065505-1-lukasz.luba@arm.com>
 <20231220110339.1065505-2-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220110339.1065505-2-lukasz.luba@arm.com>

On 20-12-23, 11:03, Lukasz Luba wrote:
> There are device drivers which can modify voltage values for OPPs. It
> could be due to the chip binning and those drivers have specific chip
> knowledge about this. This adjustment can happen after Energy Model is
> registered, thus EM can have stale data about power.
> 
> Introduce new API function which can be used by device driver which
> adjusted the voltage for OPPs. The implementation takes care about
> calculating needed internal details in the new EM table ('cost' field).
> It plugs in the new EM table to the framework so other subsystems would
> use the correct data.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/opp/of.c       | 69 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 ++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 81fa27599d58..992434c0b711 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1596,3 +1596,72 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
> +
> +/**
> + * dev_pm_opp_of_update_em() - Update Energy Model with new power values
> + * @dev		: Device for which an Energy Model has to be registered
> + *
> + * This uses the "dynamic-power-coefficient" devicetree property to calculate
> + * power values for EM. It uses the new adjusted voltage values known for OPPs
> + * which have changed after boot.
> + */
> +int dev_pm_opp_of_update_em(struct device *dev)

I don't see anything OPP or OF related in this function, I don't think it needs
to be part of the OPP core. You just want to reuse _get_power() I guess, which
can be exported then.

This should really be part of the EM core instead.

-- 
viresh

