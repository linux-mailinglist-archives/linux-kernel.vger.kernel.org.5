Return-Path: <linux-kernel+bounces-40607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE8C83E31A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC29B2141D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5455C22EE9;
	Fri, 26 Jan 2024 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jrqy0iQa"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738322612
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299787; cv=none; b=qG+8Sx8bMgpz7v0QrHR6n+okAdxVjSLHIi6PmeiaoZq+PXeMAPv9d5ScuVvbBmuj4KEmwcW76RB+bpsKsmQiaiduBoMZrRUfTzE53vAlohZseKIXD+eZEnj6SSPjv6LfvUXMTcwRSlCD8pz/kcdcZtHYf2dkT4+lnrE7gTGRrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299787; c=relaxed/simple;
	bh=26UmmMdUwHYMA5666/eDGLbOSATXZsruBdeY8Aig6Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2HBMvzt+DRYLEWI5oCjbY6Ptw1cRL0A1dwr4iPbA0+NkA1n6XvtHZYYcQuVlRjEhhk7hBo42+ybkHRPAFVPa+rIZ+NAKS2Uq0sy6x2XsyLUrHUXvDUaSzSJIs+R1czu1G92sdqgj63nf41vMjKgTnKRCZBq4WLxjICMZ/R0+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jrqy0iQa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d50d0c98c3so18228815ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706299785; x=1706904585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/1tKkzsqc4Lxn/B+1z+yYYxCGxfUQO3LjVc+R01ieg=;
        b=Jrqy0iQaweq3Ap/pZmCCNtWSZIUqc40SILHnDBAK9CnSNjtUajrLe/zlDEsDJaTqQJ
         fResHodY6jngc5ZaD8ahkEzw1a3WDu7g0CSeMsNQZs9ElA5Rm1elA9aWaOheD6Aej1DH
         4qorXiJ455bmbjdNGLVeYscD9wwOQurtTRUq5tTDM0swkgfFp4JbFjN0igfTcxkQymc+
         2ZMoh90oae4+To1y6tjnkBHvB+Gs23R++w9QXg1J7jA7gGqqTCntXz7jsaRnTFy2C7nL
         NvfL70C7Qw++urjurNNdJqSi8GoqEV42H4MFaiZFxddwzHNTpiUha42J9GmZrmqF60Zk
         LQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706299785; x=1706904585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/1tKkzsqc4Lxn/B+1z+yYYxCGxfUQO3LjVc+R01ieg=;
        b=rj3Yh/I0cnMtWHN8qa5IpNN4zNfYN8GKD0lxrmC0FHXPlhEtU2ZPPEgpByBxv5Mf9Z
         fJZI2S+K3l4p7exBnJJvJ5yTOm5BaySTwXp+SgY/QXKzs8swFdlI5XGLrAmRtT2PwRi6
         mx+sHycF/XXV+P7JuTsj3SbKUJKt0PuMONsrmPdXarlmV6W7hTAmPPkIZq78z+5ju9KL
         At5erkdudTlxyRpaYIrMY9kqfY5BwAmzavyxTgRcAKzPisZn+5xoYzAkh+i/iAWuAPG8
         2f1zX7iTLBRcrHG2icSdcgMhfaPwqggEyg7vz9BYc2EFHmyPdNaQu51zWEI0PezRNIcY
         LuCw==
X-Gm-Message-State: AOJu0YyUDS15iMdTTLRXp1VCYkY2lbyzQtz+E4o9mCo5V4012pHWfSvX
	6A92obH+JR1PoW8cq6DC7kCjWXvtKQumyU0QUCG6Tk3CAjMVpWCoa2a6t5rjCKI+okReWiZ4k7R
	rfDNCl2c0KqkFRkkBiL+2sstByM3xjqH+2mE6JA==
X-Google-Smtp-Source: AGHT+IH2rs0C2o8K7YBb3nQFCnS/YduyrRBKw5z2DfxwWvlgOq59M+qY6wRCka+xar/JGAiMbqPHaDdfeJslVIO1cpk=
X-Received: by 2002:a17:90a:9f82:b0:28e:878f:9b35 with SMTP id
 o2-20020a17090a9f8200b0028e878f9b35mr1869586pjp.34.1706299785635; Fri, 26 Jan
 2024 12:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org> <20240126171546.1233172-17-tudor.ambarus@linaro.org>
In-Reply-To: <20240126171546.1233172-17-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 14:09:34 -0600
Message-ID: <CAPLW+4mZc84mt3E6VJWVJta9o0nKvk00-9vok9-Z80JU45ev2Q@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] spi: s3c64xx: drop a superfluous bitwise NOT operation
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, jassi.brar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:16=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:
>
> val &=3D ~mask;
> val |=3D mask;
>
> is equivalent to:
> val |=3D mask;
>
> Drop the superfluous bitwise NOT operation.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

That's much more clear. Also I'm pretty sure if you compare .o file
before and after the patch, they would be identical -- another way to
argue the patch has no functional change.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index e9344fe71e56..43b888c8812e 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1089,7 +1089,6 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_d=
river_data *sdd)
>
>         val =3D readl(regs + S3C64XX_SPI_MODE_CFG);
>         val &=3D ~S3C64XX_SPI_MODE_4BURST;
> -       val &=3D ~(S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
>         val |=3D (S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
>         writel(val, regs + S3C64XX_SPI_MODE_CFG);
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

