Return-Path: <linux-kernel+bounces-44578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A084249E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18799B25243
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB7A6A033;
	Tue, 30 Jan 2024 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qft49v2T"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B36A036
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616433; cv=none; b=LwhwxKEqAac6JeaguxufkwK9dNRthOBZ0MR3qMm+QgGIp8c0IitpzrAe5YrqfhcPxbLvR8cYyoaoCgZzI8joBDfALMiSqw6dMwKhlU8dungC7AS2zee+tPzrVpwwnG8n1iHAW58mmjuy44BKcigsmwOH07WuJsX7BFvxpyQCGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616433; c=relaxed/simple;
	bh=lccpQK3PSK7WIyeUVAhCOB6LOdNwTfMMMzzSDXBHnCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bC+R2Yy9IDNkxoX5AtI+ZjRJek6beA6I0PqcKkP5MlFGNSV4x0+F9WC39ItM5iguq4q7+h3aGMm318jLmA4lZehOgV3e51ulAr8fSAyO9GRBdxVw9Vw2iKMZtvyANAikWfHf5CiCtRIPWNcfoMvN3T5nleAdEeaDWiZFTPZhlOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qft49v2T; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-602cab8d7c9so41729507b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706616430; x=1707221230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLcG4HSMsok8OgW9kIfoonSsgZVQI6gGRsjiQ9jl1ag=;
        b=qft49v2TQzyCn1UoQ+45+DsRu+ZfiaTHXge3GcnaYN/JeMnFTHe5Y53JB2mkltC1mJ
         IqoUOmkdH7WdBk74vD5RzR22cf91u/WtMxQlOtJR61Z3NroIt3kHvcF4HyZgzh5Ezzp1
         EtW/Cc48CASnnEuOvueYgU5y3KpE+jipAUhxU55RJPf1i/UZs9NFBS2jy3e+7nqFBMD5
         /qJlNWwI2PDq6b4YBmqwRjsgQ791OeCAlGOYVXuSISIKR/eFMoPY1lcM0uUnlq01Dggt
         eQAHyDtz9Z/BB7W8l220qIeWNXVf0f0efxWJnezRxjx5xmUyxGoHz7zN9M1Zm7XoUfFv
         SSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616430; x=1707221230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLcG4HSMsok8OgW9kIfoonSsgZVQI6gGRsjiQ9jl1ag=;
        b=kGaJsWCz9H67pfGYCl3K2JCjmGASQjl95VDzsTe0fYbG/Wj9WEWSs5a1RqN+oOYC2Y
         qhpqNfhAa9pxlmQ0E9bNKIDi6z1S09RDDye1sqSjtDe/VnICYB0rCJLOaXJmRhfirQJk
         i+ubPhnUTRvUmGJYhSQgoEoqD38yDM8fzLvMvQdqcAuRtMD59jPDSMYYfPC5OExxC03A
         FXzqd12ZQovqVFkdXZI/wWIhAynyUgRW/X6fD7PT2hmNSFQ/qj6RJJAAvfVdWtaC14bV
         BH+O6RaCbjtCz8fdFTOv9mhSZygoQVbbvcowr99gadBFnOQVHnssofPApaegS23S7uK/
         NufQ==
X-Gm-Message-State: AOJu0Yyth8K7y93qjYRpD574FONu5PX8sk2ez2Bwb0gfV+KQG6Y37Cxh
	53Ofgyhssui26VCa//7iTiiy5QwZ3yw817dgpTAxcgQqSMpSaZdylP2Qz9KzETcwC3YHhTqq01/
	1Z6/MFBNmNdZ7IWB48T/yMzDtUs3s9BE+TpsrwA==
X-Google-Smtp-Source: AGHT+IFiIk5mLx1BTIPjxiEuu61f8VEJBW3ENgrpjiz3Pw1GeRA3bVO2GLwMIF1c4DdF1DHZmHrw2zz116TNB7Qdfhg=
X-Received: by 2002:a81:eb0d:0:b0:5ff:6028:99f5 with SMTP id
 n13-20020a81eb0d000000b005ff602899f5mr5554333ywm.41.1706616430609; Tue, 30
 Jan 2024 04:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <583c57d0ae09f9d3a1e1a7b80c1e39ada17954b7.1705244502.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <583c57d0ae09f9d3a1e1a7b80c1e39ada17954b7.1705244502.git.christophe.jaillet@wanadoo.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Jan 2024 13:06:34 +0100
Message-ID: <CAPDyKFrghmeDkUfkJ2kvk14bv_GWPKR6iJkCTJUjzNCaB9EFuA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove usage of the deprecated ida_simple_xx() API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jan 2024 at 16:02, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
>
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added when
> needed.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 12 ++++++------
>  drivers/mmc/core/host.c  |  5 +++--
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 32d49100dff5..a9b60b91e32f 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -206,7 +206,7 @@ static void mmc_blk_kref_release(struct kref *ref)
>         int devidx;
>
>         devidx = mmc_get_devidx(md->disk);
> -       ida_simple_remove(&mmc_blk_ida, devidx);
> +       ida_free(&mmc_blk_ida, devidx);
>
>         mutex_lock(&open_lock);
>         md->disk->private_data = NULL;
> @@ -2467,7 +2467,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         bool cache_enabled = false;
>         bool fua_enabled = false;
>
> -       devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
> +       devidx = ida_alloc_max(&mmc_blk_ida, max_devices - 1, GFP_KERNEL);
>         if (devidx < 0) {
>                 /*
>                  * We get -ENOSPC because there are no more any available
> @@ -2577,7 +2577,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>   err_kfree:
>         kfree(md);
>   out:
> -       ida_simple_remove(&mmc_blk_ida, devidx);
> +       ida_free(&mmc_blk_ida, devidx);
>         return ERR_PTR(ret);
>  }
>
> @@ -2703,7 +2703,7 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
>  {
>         struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
>
> -       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> +       ida_free(&mmc_rpmb_ida, rpmb->id);
>         kfree(rpmb);
>  }
>
> @@ -2719,13 +2719,13 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>         struct mmc_rpmb_data *rpmb;
>
>         /* This creates the minor number for the RPMB char device */
> -       devidx = ida_simple_get(&mmc_rpmb_ida, 0, max_devices, GFP_KERNEL);
> +       devidx = ida_alloc_max(&mmc_rpmb_ida, max_devices - 1, GFP_KERNEL);
>         if (devidx < 0)
>                 return devidx;
>
>         rpmb = kzalloc(sizeof(*rpmb), GFP_KERNEL);
>         if (!rpmb) {
> -               ida_simple_remove(&mmc_rpmb_ida, devidx);
> +               ida_free(&mmc_rpmb_ida, devidx);
>                 return -ENOMEM;
>         }
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index cf396e8f34e9..7cc9a33d28ca 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -76,7 +76,7 @@ static void mmc_host_classdev_release(struct device *dev)
>         struct mmc_host *host = cls_dev_to_mmc_host(dev);
>         wakeup_source_unregister(host->ws);
>         if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
> -               ida_simple_remove(&mmc_host_ida, host->index);
> +               ida_free(&mmc_host_ida, host->index);
>         kfree(host);
>  }
>
> @@ -538,7 +538,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>                 min_idx = mmc_first_nonreserved_index();
>                 max_idx = 0;
>
> -               index = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
> +               index = ida_alloc_range(&mmc_host_ida, min_idx, max_idx - 1,
> +                                       GFP_KERNEL);
>                 if (index < 0) {
>                         kfree(host);
>                         return NULL;
> --
> 2.43.0
>

