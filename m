Return-Path: <linux-kernel+bounces-167721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880348BAE00
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD731F232B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B12153BF4;
	Fri,  3 May 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTcfm/EW"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE451153BD1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744059; cv=none; b=ZhAlkNN/L1Je5RfcjGYBPypDVLyc1QWcILBr3Bkw4JhJnM5p1uAtz+zXl0yANtqW2YVpD+zdVMmXz8CgS59919+UeWAXPyRb7/WQX53sPtcek/cfs/UH6e12DVb564jSwbnAg0A6nMfs2k+iWtkpFUxSje+ryk292Fdlp5sMpRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744059; c=relaxed/simple;
	bh=iFzFySdvqYlfRl4Ui4A1b/pniHe923+mjxQ/LLLWxVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIpN6c8eDnCIw/Dd9lameLqj8cwZv2a84dTHapuwWDx6KFDTaPkAA9qWYlQQK/Q8yB9mZ0I9y0TfEYcey5e5KvOFOZtDR8NVwLglxXxE6IbtHfLJzEyYEM8wGJtaWcmgnzAAma9W3BqVTohLv8KU0mQTl0YbfZr6sum9VNJQLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iTcfm/EW; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de5acdb3838so8468104276.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714744057; x=1715348857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g3ua50wpq46PgdKK2kII6t9P1G0JXIDxe02SWFIKB2s=;
        b=iTcfm/EWONRaWgxXUYZLWSvI4LJjuT4abW2ZWKdJ7Fz0y89iGRA/54mqH5NJxGy0W7
         nTy6RMjZGVFOnnWpj726Ux+N0tnzvY1y5wxKql9zmPojdO4AuHxiWf1os/SpoMoEK0nY
         LYagLYhJAbkz7e+yuNqgxgCzJ74UB3diCbY1zUYI5GCrlNbfWK2FW8izIujLn8zTnw2b
         BtnW6pIZKZjDOd2r+XhMk42zFR0OcWUIfY6fZaj5lINX1RR8Eg0QnUsLMibRfGLCEQ6a
         hBtRC0fNEoLAgqgfWPetFKqelRExkAMGpDtutDtQi9C3ke21adx4FLgK90TtVsYb5cIn
         +kZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744057; x=1715348857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3ua50wpq46PgdKK2kII6t9P1G0JXIDxe02SWFIKB2s=;
        b=P0SMDZRPiOx5oUlqGiRQJtQJqTNLSXPJFcmmkF89Rkq4oYHMRWa80dMuX5CH9rn1lX
         6THN1edf2vIcNyHxgo8+h7vAAKkfFuF/SZxwzwiDl9XBJJlroD73Zw1MaeHgC7UM7S7g
         FuAzq+7PHJ9fjPPm2AKJLwhj5rJ56ef0B5EVGVQteDODbLM0/BtCa6RTvMCyGpS1CRrM
         zC/UPfoWe06i0KLIKuCVuOaL07dPFeAYZqc/gvs2QFwcdY2aTP/fAPEOngDwhNsQg68h
         gWIrXEKy+4Zketea5llpwGFEKB7P+k+6K/pDomRKS8h+LfRd71PrdI8CaeXmXj55iHZt
         IxDg==
X-Forwarded-Encrypted: i=1; AJvYcCWaVeM6RdYq/p+uVvnwSooZ+K5T7ATAlwrHxnzPKIz5vMosciS82kn7tlVFLShAxCZTFiXa+s8Zm5u6HsZH/a8MSYib6PYrocryxJNr
X-Gm-Message-State: AOJu0YzWu+WF1sFOYXjx+Kj++WAhQv4Lkc3NGbvG02U7m2RAkS5J5Ah/
	91wq4drvf0bAS+qmcPmUxtK+Y/5B+0dBkyytkT5Muq/jP6zVmJqgbQmQwuAxe7sMxQ/SQp1Xh1b
	YG30FZ+MRWh60ksPwRFHw8QGsBxf0OImNLAGT2g8+AoK4vzrI
X-Google-Smtp-Source: AGHT+IFCuW+7abwZEByNtAeiagPvZZDoW1SqybjOPgHEIkI9MFnN7S85ZcrViqmJw/BY7SH5+t9n6nJVkwGDYTNHIL8=
X-Received: by 2002:a25:b115:0:b0:dda:a7a9:7b59 with SMTP id
 g21-20020a25b115000000b00ddaa7a97b59mr2785467ybj.50.1714744056830; Fri, 03
 May 2024 06:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-ti-sci-pd-v1-0-a0e56b8ad897@ideasonboard.com> <20240415-ti-sci-pd-v1-1-a0e56b8ad897@ideasonboard.com>
In-Reply-To: <20240415-ti-sci-pd-v1-1-a0e56b8ad897@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 3 May 2024 15:47:01 +0200
Message-ID: <CAPDyKFrGJFy87STpBcdUKaVCRg+PKDKKSZHMkbeSHsVGe6urQw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] pmdomain: ti-sci: Fix duplicate PD referrals
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, J Keerthy <j-keerthy@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 18:00, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> When the dts file has multiple referrers to a single PD (e.g.
> simple-framebuffer and dss nodes both point to the DSS power-domain) the
> ti-sci driver will create two power domains, both with the same ID, and
> that will cause problems as one of the power domains will hide the other
> one.
>
> Fix this checking if a PD with the ID has already been created, and only
> create a PD for new IDs.
>
> Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 9dddf227a3a6..1510d5ddae3d 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -114,6 +114,18 @@ static const struct of_device_id ti_sci_pm_domain_matches[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ti_sci_pm_domain_matches);
>
> +static bool ti_sci_pm_idx_exists(struct ti_sci_genpd_provider *pd_provider, u32 idx)
> +{
> +       struct ti_sci_pm_domain *pd;
> +
> +       list_for_each_entry(pd, &pd_provider->pd_list, node) {
> +               if (pd->idx == idx)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -149,8 +161,14 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>                                 break;
>
>                         if (args.args_count >= 1 && args.np == dev->of_node) {
> -                               if (args.args[0] > max_id)
> +                               if (args.args[0] > max_id) {
>                                         max_id = args.args[0];
> +                               } else {
> +                                       if (ti_sci_pm_idx_exists(pd_provider, args.args[0])) {
> +                                               index++;
> +                                               continue;
> +                                       }
> +                               }
>
>                                 pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
>                                 if (!pd) {
>
> --
> 2.34.1
>

