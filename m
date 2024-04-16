Return-Path: <linux-kernel+bounces-146442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA98A655D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC211C21CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F00482864;
	Tue, 16 Apr 2024 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="moCOUKVD"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42D7FBC6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253472; cv=none; b=gfrMFWeT9PTA4YFIcEdv8mLSWr/Qwi7LR1KTuLYhfq9LzHyWFL/gI55H1PS8f3TNdvL1xqx+1/pvud5CBgYgietd0s2nxmSDBoXS1VgV0XRflshrxplPEPACYwUul9eNu7Ntxb7LnCEZrHF0A0WQ7QvGKcz2q5dBjVkw49SX+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253472; c=relaxed/simple;
	bh=y9gOE2zuKiIA3PVc9oPZQMxUqwvKVk8idGCEvr2B1w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO7wFxFKbMf5BsbJ+qcxoptl2M2giFV1OEAMugGGSFauibwHXYtlcl+873+abq+TgtLZWG3M0fsHzcxgKNQJOeWPR7P5Ysr+oH5mIj4XvcLR7uipt99I2TYWatMmrvpnDSyQQGsxp2CQFg1UqwgQ01N1U9dFiP53QzXty9O3504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=moCOUKVD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5701dec0c0aso2478207a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713253468; x=1713858268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AkbPRxuJaFbf8hemSHK1ZWQRF0fsDq8QRKmW1NagRfM=;
        b=moCOUKVDYu97XfRqUsugkHszVhb0d68eYpYE6omXdDtRhSbEW22lCX5DpMqezwofMp
         2d7TCcMZlXgCXVvNI5sdrCpqa6HvLEmHCmafGp/te4M0Pedb2X54eatczGQfxzm5CGXZ
         29T5jAlCf7yMwKQZ4VgZCiV68rfZXQrOXsXH6SATlsiyZMGMPyqUObW7hBe1wLlLSebs
         z3gMtmWYP5wvPWfF9WBmUbpEu+iXuKvEYFcHExv/ab4DwrbIpvsRfrOspt4z21sexFIM
         3pif8yOoraQVAKN1zinw+I+UmvAUUD4VpchoiszVcB3sFIJsdBD7LB8lnyLF/D/RNW5j
         Bviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713253468; x=1713858268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkbPRxuJaFbf8hemSHK1ZWQRF0fsDq8QRKmW1NagRfM=;
        b=PaIjkzSwdZBd00WC7yFcSS6MuQxpDGKJhLIk8lVuk4fEo52VSokfGvFAvANiPQSL6+
         A54tTpOJjaniU8hEAsZkZ3+tz9IYC2gtBnGjoJ+aYq0IO80Egugdk3t5Ql5WlT1zOBtZ
         MZty4USO1ogLxWicyC9Bojnr795rya02lNVlB063wy53EH1G9O7P19swTIP3mGpUZaAt
         5GwpbbC2R1iuOvaPeFbFQKQjSi2RsYHFa73s7XNKm+0HaHPvReihFVipqxWYZr+uUigB
         nhQGo8r126gVa9MdECNRtJCuiaMOL8U2YHDMM6+z5rI9Sy1QqVLDtArKt8AmGD8fOKmO
         ChUw==
X-Forwarded-Encrypted: i=1; AJvYcCXyHXqBn5if7MyPfQDkwv8fn0lA0JpdvwmWGPsTFATS0LevzY0yv3KhvyfgA6+azi3PnqGFMfGyKyrOzxDrknsQlehbY4y1UkGFSOnD
X-Gm-Message-State: AOJu0YyRKZtUBXIlLPi/nhyB6ltHCfAkAFN6VRWUJFtux4lO2Eh6AQzk
	13K5Ge46Khz+bhQyr09Yme/ZLLYFyQeE0q2tQuwXeKOMdRiYfsjitev+2oVTeIk=
X-Google-Smtp-Source: AGHT+IHyv6GyLcCM7SuFRY2lQ0w+D3nRQ0Oogv+NgpwSUUhg8+w7A2aBnM/9CzYE2fZ/BNYLgCzdrg==
X-Received: by 2002:a50:8d0b:0:b0:570:38a:57ea with SMTP id s11-20020a508d0b000000b00570038a57eamr6318788eds.33.1713253468256;
        Tue, 16 Apr 2024 00:44:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fk27-20020a056402399b00b0056e78e90a1dsm5799411edb.49.2024.04.16.00.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:44:28 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:44:23 +0300
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
Subject: Re: [PATCH 09/35] media: v4l: async: refactor
 v4l2_async_create_ancillary_links
Message-ID: <a1917f15-ba04-4d8b-8dd6-0c1bc9a498ca@moroto.mountain>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <20240415-fix-cocci-v1-9-477afb23728b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-fix-cocci-v1-9-477afb23728b@chromium.org>

On Mon, Apr 15, 2024 at 07:34:26PM +0000, Ricardo Ribalda wrote:
> Return 0 without checking IS_ERR or PTR_ERR if CONFIG_MEDIA_CONTROLLER
> is not enabled.
> 
> This makes cocci happier:
> 
> drivers/media/v4l2-core/v4l2-async.c:331:23-30: ERROR: PTR_ERR applied after initialization to constant on line 319
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/v4l2-core/v4l2-async.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
> index 4bb073587817..e26a011c89c4 100644
> --- a/drivers/media/v4l2-core/v4l2-async.c
> +++ b/drivers/media/v4l2-core/v4l2-async.c
> @@ -316,9 +316,8 @@ v4l2_async_nf_try_all_subdevs(struct v4l2_async_notifier *notifier);
>  static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
>  					     struct v4l2_subdev *sd)
>  {
> -	struct media_link *link = NULL;
> -
>  #if IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
> +	struct media_link *link;
>  

I think another way you could write this is to remove the #ifs...

	struct media_link *link;

	if (!IS_ENABLED(CONFIG_MEDIA_CONTROLLER))
		return 0;

	if (sd->entity.function != MEDIA_ENT_F_LENS && ...

regards,
dan carpenter

>  	if (sd->entity.function != MEDIA_ENT_F_LENS &&
>  	    sd->entity.function != MEDIA_ENT_F_FLASH)
> @@ -326,9 +325,10 @@ static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
>  
>  	link = media_create_ancillary_link(&n->sd->entity, &sd->entity);
>  
> -#endif
> -
>  	return IS_ERR(link) ? PTR_ERR(link) : 0;
> +#else
> +	return 0;
> +#endif
>  }
> 

