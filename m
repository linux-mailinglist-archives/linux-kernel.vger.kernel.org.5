Return-Path: <linux-kernel+bounces-110220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59485885B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5A51C21C88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A168624F;
	Thu, 21 Mar 2024 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="akYgZSmU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6358385278
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034831; cv=none; b=Nnkwcy8AYECQfLWayhHPPnOVp5qI0JvyXw/nqkaWXbgHIyDjigW4t3dnyIF/qZ1ywRqXvRY9rzBTy4XHLoaOtb7HX4hVBl9NFsP7axQCp730R0fv4zEfkdEh3qXO7aHHj+aij1kJtHukn8HnPXO56aRpEXBbK0NVzKpeWrmVq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034831; c=relaxed/simple;
	bh=n8T4C2A5gem4U8d3WvHIEu6sVO6mAM1shyUf70RSvro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E97SJXORqWx8KlIUtSyhkRR+2AZacK37JWi3lXXcxc+wRGQ6OITPb+LeANcI7BRSA6dL0CbrQ0cuOSM0hirqB2TKhRgtIUAF+g5DGetH4eEnpX32C/s899vgrzC20gN7/GwyQhjM+/Ke0FLNNCRSk99Lv+S6YpN+f+PJ4ab337g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=akYgZSmU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e04ac4209eso9360115ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711034830; x=1711639630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xaUG2ldhaQRaRHuk6t4MDB7vN1BXN+/W59BKlbNm/o=;
        b=akYgZSmUvzmL0HUiIiKO5kfSN46jX00L0Y3uBZH4B4+SYPTo87xY1MvAVQJC+O9WR5
         YMf8HGmcTQtv4aStnJhY2ORf23v8nM/VS76KRFAz36ZlrNFXniU9nMNtY4akh1+koJ1s
         Ugp5eKwcXkGIPczST0x2d5RMQvJGnU91zeMXpR8e4HTDBTsIbU1wgBM4TSIop5L71giu
         dOgy9zwn86x+b9/BQSZtU/rSU/JCYi2S8BBmzrZ7PuJml76H19q2oS0qbvbr74TFbrpy
         b8P05IW8i+v71seOqlfa3xSonXNtPa3AW88VXTihXpm1stxiVqVTNkW20B0PpK1OG3/5
         Ok1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711034830; x=1711639630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xaUG2ldhaQRaRHuk6t4MDB7vN1BXN+/W59BKlbNm/o=;
        b=e9Taea7DjhtGhgROwUZApG2zgVuXYWkryNhZN+dJDDxlNGoW2GiBqXrHEIDn5BCarz
         hKkxYzOi7upOQZ/RiR35XVnsRf7gShVo5rIMCg7XLFicZPIjM+WV0q8S3AXdd1yHdg3e
         EQVJKPTzDSBCgOH8aqR4c40jDPQCSkFD468xCZE1VZ97mpTousu0m6LTz8a7JZ/r/Wv4
         YRzgYMZ9UZBFCXIoOp9WroStAlLlveL1A326Codv4Np3efqP26L7GIp5SC6wmBW7zYMI
         CMmBKtPhuXi4tUR99ne8JF5wDswNdABpQ785K13UIsq75fYiCXr27+IsR3iksbRerEeJ
         gPzA==
X-Forwarded-Encrypted: i=1; AJvYcCWMv/FIW+MCJvTdQL4c83jI6dAfxIvq9dypW4dQYvvij+7GPFbPNPyQQjXIAfkGh6J6d72t9Pjgd/lXgwaF9E0yS+s+9n1ITC6sJGGY
X-Gm-Message-State: AOJu0YwHB+ooF2VqwOVbZVqCmU9UDDFCELGorbB2+J0i8TGnj6np2ank
	CYomA3eT/KZlFgxbzefYhbZVCEOipbK+BbkUOWiVPqpg5kvUIzc9cd6hG82Opvs=
X-Google-Smtp-Source: AGHT+IFZusUIQQGZ01wR/lIafQ3ProKPMjN3Xn3Bpv3FxV8YHFTb1NMxzLzr2zATgiRssYtdZLM9qA==
X-Received: by 2002:a17:903:22d0:b0:1e0:1e87:c9d8 with SMTP id y16-20020a17090322d000b001e01e87c9d8mr13021667plg.7.1711034829723;
        Thu, 21 Mar 2024 08:27:09 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:d9a2:e52:d93:c759])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001dee3fe3c1asm15077983plb.258.2024.03.21.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 08:27:09 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:27:04 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: andersson@kernel.org, matthias.bgg@gmail.com, tzungbi@kernel.org,
	tinghan.shen@mediatek.com, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wenst@chromium.org,
	kernel@collabora.com
Subject: Re: [PATCH 2/2] remoteproc: mediatek: Don't parse extraneous
 subnodes for multi-core
Message-ID: <ZfxRyMyUqyqtXy8n@p14s>
References: <20240321084614.45253-1-angelogioacchino.delregno@collabora.com>
 <20240321084614.45253-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321084614.45253-3-angelogioacchino.delregno@collabora.com>

On Thu, Mar 21, 2024 at 09:46:14AM +0100, AngeloGioacchino Del Regno wrote:
> When probing multi-core SCP, this driver is parsing all sub-nodes of
> the scp-cluster node, but one of those could be not an actual SCP core
> and that would make the entire SCP cluster to fail probing for no good
> reason.
> 
> To fix that, in scp_add_multi_core() treat a subnode as a SCP Core by
> parsing only available subnodes having compatible "mediatek,scp-core".
> 
> Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 67518291a8ad..fbe1c232dae7 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -1096,6 +1096,9 @@ static int scp_add_multi_core(struct platform_device *pdev,
>  	cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
>  
>  	for_each_available_child_of_node(np, child) {
> +		if (!of_device_is_compatible(child, "mediatek,scp-core"))
> +			continue;
> +

Interesting - what else gets stashed under the remote processor node?  I don't
see anything specified in the bindings.

Thanks,
Mathieu

>  		if (!cluster_of_data[core_id]) {
>  			ret = -EINVAL;
>  			dev_err(dev, "Not support core %d\n", core_id);
> -- 
> 2.44.0
> 

