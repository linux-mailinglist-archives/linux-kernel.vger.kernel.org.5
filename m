Return-Path: <linux-kernel+bounces-78984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD6861BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6841F26037
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C01012B6F;
	Fri, 23 Feb 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6Jfx8VW"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4D101DE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713173; cv=none; b=d0iYwcivivkk4GUI6AXhvRlYjtfZSoqIVZYxNlao3W6Vl/Wr4QmJLhw14bsYncD4H0zUcFAIqjUB08Ql0ylDkDwT6Qa1YKSkMPMOHLxKctIc+u3OsT+IiVMnUhnATeXwIbuBpAnHzoNrXxWRKOkthEwiWDNAEDDq/r3uaDWO1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713173; c=relaxed/simple;
	bh=aJ3BGTq9NSm9cTk4WqmOlLYGGdjSeSEuf85VeSJX3KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lctJdOKig2gNMrsGKtugZIGRQScRvJm3ScLBQ2OGQ0BmA+C1R8izCrkeM7vD1ixlj5iijhnnlKRH/Cnahz6HGEIBv9cSEzCKCMsKJLRU3aDBOPBWALs0Ywa3BuG05dkcXmZilyTlCaK9oEjVS1Ju5vWpBW47Ga9vpRxshQU/dJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W6Jfx8VW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e4e7e25945so524220b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708713171; x=1709317971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXNKJkVEkUZdoKeA6PbFxQU2RahxqYWMcCRd6gZZ97g=;
        b=W6Jfx8VWODznOO4K6E905873J2WaIy9kFrEBIS2prbgiAw2I30FNz5uvPrxQ/aoRNa
         hwIFQlz5p+69a4O8gp2FAKd06U2+zf3/rcIMbyJMdbYmR4eHYoFUGrFjKDpE3iZFONrT
         XAgR7MLb+TF1biT2RXENW7n7nZ52UDgJZmcL8WQKT5hD1FSOiHDXZ74382aFs93JWOR1
         UF4ucLIkoj+s3ylbB4BsNR/+VjU6V9w8aBPLuIZfBDWxn00ZPEWRtrjf7dfS5TGqDUE+
         PO+b7YbWftkIRwhGdZ+OAU11QEgMqmcDDQG1iMWauIwfxkVqTDkfPazsB/7yL73GATay
         8H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708713171; x=1709317971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXNKJkVEkUZdoKeA6PbFxQU2RahxqYWMcCRd6gZZ97g=;
        b=BrAjWyCe8FH7k+sDCzK1Ad2YKo7KOQyLz3yQN8IY4PKlaojw9CXzNt0BzRl1eP/uO7
         luMV2sErYCKhXat75TUnTvp8HYaWD2PXhR72aK5aHgAuYdC34aV8Lq1JhD5vMQT3lEJw
         My/3V58AQmPg1u0bJctR5w4FYdqzBpykZDpcqNAE7itXiqeOSZpRJdalf8lwi5OuCqXS
         MtrECvrhljzZcQV6KxwqTC7jXRp0TqGxcVRUwnUHG4aTRmOyhhM3R/PQWpai+rIXz+lC
         EiWIZHItd7hdyo8FfRPdtVJh/HoGDpWfF3usFx82Uf/G9GuD6v45PGo+/2wUIkTrKfsh
         EvTA==
X-Forwarded-Encrypted: i=1; AJvYcCUFlGySVGVDW51PIw9TSJDJgvKQ8RA3/FPmaOufj9IoCEIRozRrWQ3Uzpj1cyKFNT+wec88XAv4AVEdHWmliWmZcoYHUMk5og5L4ISJ
X-Gm-Message-State: AOJu0Yy8D3guNntcOPDXVKIt5O9hw3C9ERPNotXiJ8wHiY2ggF3On4xS
	iul0VktpIfFs7I7lYHCjG4WDWd2UToivonY9mpNmWx2xe1C+CGjJ1ypJt/W0hvg=
X-Google-Smtp-Source: AGHT+IG4UQYH68MX7y3iRYfp2fJ92YT55kxRllR+ksVeb/ZiaoCE5+Ml7rd1sXmqZO+dsdfexxhreQ==
X-Received: by 2002:a05:6a00:2310:b0:6e4:cf7c:6c28 with SMTP id h16-20020a056a00231000b006e4cf7c6c28mr599071pfh.22.1708713170112;
        Fri, 23 Feb 2024 10:32:50 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:a9ba:9d9e:b797:23f1])
        by smtp.gmail.com with ESMTPSA id fn21-20020a056a002fd500b006e47e3e139esm7520820pfb.26.2024.02.23.10.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 10:32:49 -0800 (PST)
Date: Fri, 23 Feb 2024 11:32:47 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/7] remoteproc: core: Add check on cached_table
 pointer
Message-ID: <Zdjkz9bgaz+QkLg1@p14s>
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
 <20240214172127.1022199-4-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214172127.1022199-4-arnaud.pouliquen@foss.st.com>

On Wed, Feb 14, 2024 at 06:21:23PM +0100, Arnaud Pouliquen wrote:
> Add a check on the optional rproc->cached_table to perform the memory
> copy only if it is not null.
> 
> 2 use cases to support:
> - starting on boot, in which case rproc->cached_table can be null,
> - starting on crash recovery, where the cached table is used to save
>   the resource table configuration on stop and re-apply the configuration
>   on the re-start.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 283ca071e35c..34b0093689da 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1278,7 +1278,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	 * that any subsequent changes will be applied to the loaded version.
>  	 */
>  	loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
> -	if (loaded_table) {
> +	if (loaded_table && rproc->cached_table) {

.. and this becomes:

        if (loaded_table != rproc->cached_table)

with a detailed comment about what is going on and a reference to
tee_rproc_parse_fw().

There are other things to adjust in this patchset but starting with that will
hopefully deal with a few of them.  We can address the rest at the next
iteration.

I am done reviewing this set.

Thanks,
Mathieu
>  		memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
>  		rproc->table_ptr = loaded_table;
>  	}
> -- 
> 2.25.1
> 

