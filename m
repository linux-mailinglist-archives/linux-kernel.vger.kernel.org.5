Return-Path: <linux-kernel+bounces-40628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A081C83E361
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5736B2873EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB02377E;
	Fri, 26 Jan 2024 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+N2oFYi"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2923750
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706301012; cv=none; b=CrAIljSZ2v91aGwRnscza1bcyQLYQ/iX2S9f3U1qp7hv7Z7OrPOu2dQica+Sl3PvZaHNaV4tdok+W30SWsiLHeMDFuS7Uc0xPVfClOFumxEpgAFqD5E6XOaIAZXUPQhOldgoLf8rTvxhSvocYxTUnZaUOvM3T8TkGMsdqGLCEKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706301012; c=relaxed/simple;
	bh=AZL2DiPws0S6+MBaKLJGGRKAIx0Xr+661L82JlgRYPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7ursbGAzYxJhSpVbwxzjcA0jE35LA4/w8EicpawOYFlWeah0nsgukmq3l8Gy1yKhR9LmSGN7gR4q+e2BAALdop0SfTIdnPI+4clW9cDdmH1Pbkx6FaM2bOjkFoKhC796phHb/0jEXyPYFuvl4Zc4ZQWReAoHqw1bRpGhwraVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v+N2oFYi; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbed0710c74so796994276.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706301010; x=1706905810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZTd/qK4fjgGkjgEEZAEvtUcKpHSu6w+GQ9nB6HrsPo=;
        b=v+N2oFYi5I5DFNj/ijZx0suvviAhzj2S3+K+88E97pCNWWmYCEyB2G9LS9rw5xruhs
         YoU7u4lEFqgzTD+V1lg/6wPic/UoMfQbouNlNWfjKbaO2sttkefcuMF0WZd1mFiBW3Rh
         x0NQVbzOtlh5jIJ+4McKUXwyxYwnfE06L4Rc6mld7TYY/mnirFPgewMadXzPONE37qpB
         vQ/zGDAkj7NXguVvK9QZrVf93GR+uvHLF+eE0xW0WH3IfvAKGssboYYSomy0AGircQzc
         PuUXB6Hjkbezu3ajlbKwk6QeZpoIMAKBTzNydun0IWywbBg2R44x0mdAzatoW6x8FsFU
         Cmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706301010; x=1706905810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZTd/qK4fjgGkjgEEZAEvtUcKpHSu6w+GQ9nB6HrsPo=;
        b=qJiHiIKovognDCUk/N9OrJ2+wZ90vx4FrWvC3w3AmAtqM3SORq0UR7ccvY00BcSV8F
         Wq3gUZ5rK7eXuNyMo8itL096NdUCEKQ1hkdRmpLzM/Mx4FYXOvdMNzagyXXKwb2eGajj
         3DGcM6e0Mxn/VqRi1bRSMDoBRTsW4X94l4Mj+JZ3zCRWf/U5PYZqVk98bOA1f+D8Dwca
         HXQKVGArvO0OYFLfXna+BkTR/f9G28ShSOznvIpyIhDTtU4VTwl7bVs25XI2LX+tkdTc
         AKubUNSviPuD5dKTOtshwdIVWlH/b/Pj/ekyYfp+NYVt1HAkDAsbODdkGKWOwP0lK8Ba
         9sdg==
X-Gm-Message-State: AOJu0YyeYezwYZwjZ5kmsxfwvl/erajWhnpB0So1IhyWYiAJrRw8cjAm
	NInYYI3qLxxBPMPZYFvc4mckK0H4nTBwBgMBfID8DSArf6uHQmEu7KnS2107YJIoC0igW9jqmfF
	LzPAw5BC8A1W1Y9NKkAWjkYFgWmAhNZwKHBStkg==
X-Google-Smtp-Source: AGHT+IFRFALlNQJrY0JCp8H/TgJzhu2cMZX+uZJkl0AdOae8gvAP2suk/MGyKDXEOw7FfiRM8ExjaxYpUup11X6q9Ug=
X-Received: by 2002:a25:9948:0:b0:dc1:f71f:a1e8 with SMTP id
 n8-20020a259948000000b00dc1f71fa1e8mr473812ybo.128.1706301009942; Fri, 26 Jan
 2024 12:30:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706296015.git.quic_uchalich@quicinc.com> <12bfdd23772c49530b8b0993cc82bc89b3eb4ada.1706296015.git.quic_uchalich@quicinc.com>
In-Reply-To: <12bfdd23772c49530b8b0993cc82bc89b3eb4ada.1706296015.git.quic_uchalich@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 26 Jan 2024 22:29:59 +0200
Message-ID: <CAA8EJppapW5nOFphBWove1ni8nbkA=xHON9D13NYeYHhyqL1Fg@mail.gmail.com>
Subject: Re: [PATCH 5/5] soc: qcom: llcc: Add regmap for Broadcast_AND region
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 21:48, Unnathi Chalicheemala
<quic_uchalich@quicinc.com> wrote:
>
> To support CSR programming, a broadcast interface is used to program
> all channels in a single command. Until SM8450 there was only one
> broadcast region (Broadcast_OR) used to broadcast write and check
> for status bit 0. From SM8450 onwards another broadcast region
> (Broadcast_AND) has been added which checks for status bit 1.
>
> Update llcc_drv_data structure with new regmap for Broadcast_AND
> region and initialize regmap for Broadcast_AND region when HW block
> version is greater than 4.1 for backwards compatibility.
>
> Switch from broadcast_OR to broadcast_AND region for checking
> status bit 1 as Broadcast_OR region checks only for bit 0.

This breaks backwards compatibility with the existing DT files, doesn't it?

> While at it, also check return value after reading Broadcast_OR
> region in llcc_update_act_ctrl().

Separate patch, Fixes tag.

>
> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> ---
>  drivers/soc/qcom/llcc-qcom.c       | 12 +++++++++++-
>  include/linux/soc/qcom/llcc-qcom.h |  4 +++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 4ca88eaebf06..5a2dac2d4772 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -849,7 +849,7 @@ static int llcc_update_act_ctrl(u32 sid,
>                 return ret;
>
>         if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
> -               ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
> +               ret = regmap_read_poll_timeout(drv_data->bcast_and_regmap, status_reg,
>                                       slice_status, (slice_status & ACT_COMPLETE),
>                                       0, LLCC_STATUS_READ_DELAY);
>                 if (ret)
> @@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
>         ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>                                       slice_status, !(slice_status & status),
>                                       0, LLCC_STATUS_READ_DELAY);
> +       if (ret)
> +               return ret;
>
>         if (drv_data->version >= LLCC_VERSION_4_1_0_0)
>                 ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
> @@ -1282,6 +1284,14 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>
>         drv_data->version = version;
>
> +       if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
> +               drv_data->bcast_and_regmap = qcom_llcc_init_mmio(pdev, i + 1, "llcc_broadcast_and_base");
> +               if (IS_ERR(drv_data->bcast_and_regmap)) {
> +                       ret = PTR_ERR(drv_data->bcast_and_regmap);
> +                       goto err;
> +               }
> +       }
> +
>         llcc_cfg = cfg->sct_data;
>         sz = cfg->size;
>
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index 1a886666bbb6..9e9f528b1370 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -115,7 +115,8 @@ struct llcc_edac_reg_offset {
>  /**
>   * struct llcc_drv_data - Data associated with the llcc driver
>   * @regmaps: regmaps associated with the llcc device
> - * @bcast_regmap: regmap associated with llcc broadcast offset
> + * @bcast_regmap: regmap associated with llcc broadcast OR offset
> + * @bcast_and_regmap: regmap associated with llcc broadcast AND offset
>   * @cfg: pointer to the data structure for slice configuration
>   * @edac_reg_offset: Offset of the LLCC EDAC registers
>   * @lock: mutex associated with each slice
> @@ -129,6 +130,7 @@ struct llcc_edac_reg_offset {
>  struct llcc_drv_data {
>         struct regmap **regmaps;
>         struct regmap *bcast_regmap;
> +       struct regmap *bcast_and_regmap;
>         const struct llcc_slice_config *cfg;
>         const struct llcc_edac_reg_offset *edac_reg_offset;
>         struct mutex lock;
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

