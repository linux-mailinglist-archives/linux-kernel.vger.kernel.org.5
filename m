Return-Path: <linux-kernel+bounces-110219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0579885B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6B1285A21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB248625B;
	Thu, 21 Mar 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iV4b3JuV"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC918624E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034728; cv=none; b=N+aVcYx2OVwIgcxWxazVGvtdj6Uy6iXgWvUH9lsg0v8TU/m+eJYw6y9DzwAVurD2r7QycSfzUtjFI6DWEQ/FhHkHuT0FPX5YMpQFFp8PpWNceH8tsdYEaVxy5pCCtpzu4KLGubhDF92z135NLxnsVAdKpOr7XFjjKhMNMVyxSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034728; c=relaxed/simple;
	bh=keHTiEytawshQb8pgvqpSP5oSevhiW6x2JK067oi9nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9iS6dg5qVmto4qfKNQ3ScAKgavd3pZgG7rIzb0ARhGFj8CxuN+VkR7uQDmRUGVsyISytNh/fgo9m10OkRzwcB/c9gsiiG93syt3/OK6Uzcny6KkpiBWt0s5Z8QQpJO6RG9dCmLSRxVA+h9TeKhC9dVzbU9uLBxqnFMhxqqbIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iV4b3JuV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso834260b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711034726; x=1711639526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=82OI8Gh7oQu/9StlFoR10DICm6BhP8N6L+l5Ik+ILaw=;
        b=iV4b3JuVmqqxcc46GxoxvkIj+168yQojSblvVjG5JsICN6AEUjE9zAp7VrayNvlvXL
         4iRFzvkFXJwBfCnqByJzVl3WSg/L/pV5iB+o1fhQ8X2vji+DlVE5ELAoxdVKTH/X2zud
         qqLwgcheSoI8eM9hyHLW6YwgJuJB20mijs72FfYyx0tUC42ZAZZ0ACgakbhI1d3y43aF
         paaVuFXs2UNznYRLe8wvm/0FDEQoCYyXfNJi4rLjzpDILZH/IM4kWiJ0j8YdDUHk6Zhw
         eiwjPieAcyjtaicrNCPTtaZGtrPw9WLZqbM12ivdg/HUBNlnY8UXPR28JjWRbNn05tim
         ndAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711034726; x=1711639526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82OI8Gh7oQu/9StlFoR10DICm6BhP8N6L+l5Ik+ILaw=;
        b=H9tUUeuO1jxDgI61SRhmEYfnUMjM37ic1qjmiSnrQKLe8butv8/aQe26CpPwX+YF/v
         aBOyHwib5cC/kxR/c/bceh5J2357mpiu2bhqzVCN1tW2ASv3gEopHbJUW7/sgL1mehBm
         ynwDdW6WDzby6s8yxjAgWpPD2XCQN464USgMuLuFunwcQHOYoGzUEbcfmYaeQVK12Grw
         kK7/FgnMqQsNkZfvkCq58JWWk1oLokXI96kOzCluaiJYcN37TeH6oBP8QqUxwP6DPJKN
         sdjH87h4flkUMJdl5dGbNlc5QJRhU2wUjTHbRdlUnS16irrxJHWr805binTY7eZRraZj
         gIPw==
X-Forwarded-Encrypted: i=1; AJvYcCXa9w1vOOws2u8FUDjM961tdtj/OFeX50OaKjAfCW29/XRVtGxkmukk49WFjfyqE4hhSEkbdLyyvonWCYvIvjBomD+Eef9pufJral/J
X-Gm-Message-State: AOJu0Yz7Cqguhth/QLxwFh4ZUHnmvsUgGyzKQ4tM1fqW2iqNSimbKQcF
	iRYZ7STPQfyEKp3gNNmwnHs91CQQpJukeKfpb+9QVxjbXVGA5uLkagGPe2Gxm2Y=
X-Google-Smtp-Source: AGHT+IEmFIp+48D2B1hUzpIyAXGeGOM1HqTNVM5BMRBIcH3HZOKodw1pu3F3fpANojgpouNGrD0GsQ==
X-Received: by 2002:a05:6a00:3d42:b0:6e6:a3b3:923c with SMTP id lp2-20020a056a003d4200b006e6a3b3923cmr2898786pfb.6.1711034726278;
        Thu, 21 Mar 2024 08:25:26 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:d9a2:e52:d93:c759])
        by smtp.gmail.com with ESMTPSA id fi37-20020a056a0039a500b006e69a142458sm13534453pfb.213.2024.03.21.08.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 08:25:25 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:25:23 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: andersson@kernel.org, matthias.bgg@gmail.com, tzungbi@kernel.org,
	tinghan.shen@mediatek.com, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wenst@chromium.org,
	kernel@collabora.com
Subject: Re: [PATCH 1/2] remoteproc: mediatek: Make sure IPI buffer fits in
 L2TCM
Message-ID: <ZfxRY475SKaRYVTj@p14s>
References: <20240321084614.45253-1-angelogioacchino.delregno@collabora.com>
 <20240321084614.45253-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321084614.45253-2-angelogioacchino.delregno@collabora.com>

Good day,

On Thu, Mar 21, 2024 at 09:46:13AM +0100, AngeloGioacchino Del Regno wrote:
> The IPI buffer location is read from the firmware that we load to the
> System Companion Processor, and it's not granted that both the SRAM
> (L2TCM) size that is defined in the devicetree node is large enough
> for that, and while this is especially true for multi-core SCP, it's
> still useful to check on single-core variants as well.
> 
> Failing to perform this check may make this driver perform R/W
> oeprations out of the L2TCM boundary, resulting (at best) in a

s/oeprations/operations

I will fix that when I apply the patch.

> kernel panic.
> 
> To fix that, check that the IPI buffer fits, otherwise return a
> failure and refuse to boot the relevant SCP core (or the SCP at
> all, if this is single core).
> 
> Fixes: 3efa0ea743b7 ("remoteproc/mediatek: read IPI buffer offset from FW")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index a35409eda0cf..67518291a8ad 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -132,7 +132,7 @@ static int scp_elf_read_ipi_buf_addr(struct mtk_scp *scp,
>  static int scp_ipi_init(struct mtk_scp *scp, const struct firmware *fw)
>  {
>  	int ret;
> -	size_t offset;
> +	size_t buf_sz, offset;
>  
>  	/* read the ipi buf addr from FW itself first */
>  	ret = scp_elf_read_ipi_buf_addr(scp, fw, &offset);
> @@ -144,6 +144,14 @@ static int scp_ipi_init(struct mtk_scp *scp, const struct firmware *fw)
>  	}
>  	dev_info(scp->dev, "IPI buf addr %#010zx\n", offset);
>  
> +	/* Make sure IPI buffer fits in the L2TCM range assigned to this core */
> +	buf_sz = sizeof(*scp->recv_buf) + sizeof(*scp->send_buf);
> +
> +	if (scp->sram_size < buf_sz + offset) {
> +		dev_err(scp->dev, "IPI buffer does not fit in SRAM.\n");
> +		return -EOVERFLOW;
> +	}
> +
>  	scp->recv_buf = (struct mtk_share_obj __iomem *)
>  			(scp->sram_base + offset);
>  	scp->send_buf = (struct mtk_share_obj __iomem *)
> -- 
> 2.44.0
> 

