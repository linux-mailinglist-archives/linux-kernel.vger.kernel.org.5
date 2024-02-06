Return-Path: <linux-kernel+bounces-55488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EFA84BD50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6911828F682
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74671426D;
	Tue,  6 Feb 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jA7hZxgs"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E4200B8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245066; cv=none; b=Ewnyxz9NoOh3crlmGFN/rL7cVqvx9v2jGKdaX7tJeWMxjGgC1blzRoazghHSwb7bw+PyoOikCU55CJBJxFlGhkz9PuLS7RS+PzHRgtmowCh5lMUyytuSbrkj30Me+fjYID7yxvWg8nRCmGzMcM7ZmeDbptdv2zn3Ys7OUvAeKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245066; c=relaxed/simple;
	bh=4VPwghyLKyIokpPsf/9skodjSJIC1F4FYH1tensC6Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J99cfmRtsAP4QbdMCmqSCAcq4Znqdfv8xs0dRUzXGAiowEMDcA00tWcHiv5dZBarOlixWSJhlqerO8PzYidn0+rNO5Ip5kh3gVP0dov+QiuVJV9gHVIFHq5xvBRoWRpDMei/UURXkXyTfjw2HNxfpXYY50e+G5DF6reIOQhGSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jA7hZxgs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-296c827b42dso792105a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245064; x=1707849864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bMG0kuBwMQCEUIv0B0FpnFBvMPqYtZh5SEjjp7Kx7o=;
        b=jA7hZxgsvJHREu1UlqF8g9sqstb4zrDl4XspKRyUTU4n5oNS1lBes13so62Skm06uW
         R8bAqWA762CMOXUckoGQNa/q0hDt6kalOIQEFR4r4aYUsxs859KKwtR4ffX9PQCnKv/2
         gTDWHjgX3XBt8d3erMeSK6W+zmmij9TbsE+aY5+ICrm6U+PjgEhCh9xh/3jnrX//zJ11
         VxqfauGEXuy8EEcgE8+bE8Wa6N9JI03OomVsShuB43Me/PPEXpeua8BCz9b9AVEnzinK
         bFt4mTIYGtuL1p0rFRM9zrPNK7gdaFu1XWBpfzYsoq4zhPpeO85VTWpWsbI/lc00KLzv
         bkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245064; x=1707849864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bMG0kuBwMQCEUIv0B0FpnFBvMPqYtZh5SEjjp7Kx7o=;
        b=iv5FjVOAhJrPlW6sZjFYLF3Mi2ueh6w+2NdsLdAxId+EwnBD4RyKGgqKnkxnU7kqPh
         EbCMdmSffIs88uRRtn+nuBpN5r/4Rgj46Lc+LJ5sbInOKOdIiV+0zm6SZEXzgF4zWggP
         U9CzQ9KSbjaSjhTWOE8ENtlJc6QImiMWGKjAxsqb7LQzv1a/l+Zdjrm3zfSCU+LQcOWQ
         +BYXnlpeD8NgFHeZpdwRNVlVJaSj5D0dThcUaNvcM7xinc1mvus/3H/PEq0XrrGyMRE8
         QUn+X4KRxXj3dbEbO1fY+vfmPfONpsiya5R+UYgyD/IdS8U62O+RD+wLBQtRexnoCesO
         bygA==
X-Gm-Message-State: AOJu0YzpNxQdhujog+ZGfXF5uAD6v3MMSvyvcUENO6ovalRQuPh0hZP8
	Mq+B2SB9bf3kXKmb361ol4mrIjPX9hS3puYRqLSQ13KMM3akHBA9/DNKYXhIom/kXph5yQm/2ba
	OiGQsJtBe5EXrDKmme1Iovz0deAM05v/zxEEEfg==
X-Google-Smtp-Source: AGHT+IE1M9jGPWeVmzaj4xWfBVBRIZdNjHRf3o+XRIOAWaTnt4AKWsQCW3sG2JWW7haM1Di4pWWbAXjzVZtz44ZpflE=
X-Received: by 2002:a17:90b:3598:b0:296:235b:20b with SMTP id
 mm24-20020a17090b359800b00296235b020bmr401263pjb.29.1707245064629; Tue, 06
 Feb 2024 10:44:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org> <20240206085238.1208256-4-tudor.ambarus@linaro.org>
In-Reply-To: <20240206085238.1208256-4-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 6 Feb 2024 12:44:13 -0600
Message-ID: <CAPLW+4k+FkuNwsyvWH54gcLz0YFmh8OmvOWt_LdQvELRXMvOTQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] spi: s3c64xx: add s3c64xx_iowrite{8,16}_32_rep accessors
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> Allow SoCs that require 32 bits register accesses to write data in
> chunks of 8 or 16 bits. One SoC that requires 32 bit register accesses
> is the google gs101. The operation is rare, thus open code it in the
> driver rather than making it generic (through asm-generic/io.h)
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 70 +++++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index c15ca6a910dc..cb45ad615f3d 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -142,6 +142,7 @@ struct s3c64xx_spi_dma_data {
>   *     prescaler unit.
>   * @clk_ioclk: True if clock is present on this device
>   * @has_loopback: True if loopback mode can be supported
> + * @use_32bit_io: True if the SoC allows just 32-bit register accesses.

A matter of taste, but: just -> only.

>   *
>   * The Samsung s3c64xx SPI controller are used on various Samsung SoC's =
but
>   * differ in some aspects such as the size of the fifo and spi bus clock
> @@ -158,6 +159,7 @@ struct s3c64xx_spi_port_config {
>         bool    clk_from_cmu;
>         bool    clk_ioclk;
>         bool    has_loopback;
> +       bool    use_32bit_io;
>  };
>
>  /**
> @@ -412,6 +414,59 @@ static bool s3c64xx_spi_can_dma(struct spi_controlle=
r *host,
>         return false;
>  }
>
> +static void s3c64xx_iowrite8_32_rep(volatile void __iomem *addr,
> +                                   const void *buffer, unsigned int coun=
t)
> +{
> +       if (count) {
> +               const u8 *buf =3D buffer;
> +
> +               do {
> +                       __raw_writel(*buf++, addr);
> +               } while (--count);
> +       }

How about:

    while (count--)
        __raw_writel(*buf++, addr);

This way "if" condition is not needed. The same goes for the function below=
.

> +}
> +
> +static void s3c64xx_iowrite16_32_rep(volatile void __iomem *addr,
> +                                    const void *buffer, unsigned int cou=
nt)
> +{
> +       if (count) {
> +               const u16 *buf =3D buffer;
> +
> +               do {
> +                       __raw_writel(*buf++, addr);
> +               } while (--count);
> +       }
> +}
> +
> +static void s3c64xx_iowrite_rep(const struct s3c64xx_spi_driver_data *sd=
d,
> +                               struct spi_transfer *xfer)
> +{
> +       void __iomem *regs =3D sdd->regs;

Suggest declaring aliases here, like this:

    void __iomem *addr =3D sdd->regs + S3C64XX_SPI_TX_DATA;
    const void *buf =3D xfer->tx_buf;
    unsigned int len =3D xfer->len;

Using those in the code below makes it more compact and easier to read.

> +
> +       switch (sdd->cur_bpw) {
> +       case 32:
> +               iowrite32_rep(regs + S3C64XX_SPI_TX_DATA,
> +                             xfer->tx_buf, xfer->len / 4);
> +               break;
> +       case 16:
> +               if (sdd->port_conf->use_32bit_io)
> +                       s3c64xx_iowrite16_32_rep(regs + S3C64XX_SPI_TX_DA=
TA,
> +                                                xfer->tx_buf, xfer->len =
/ 2);
> +               else
> +                       iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
> +                                     xfer->tx_buf, xfer->len / 2);
> +               break;
> +       default:
> +               if (sdd->port_conf->use_32bit_io)
> +                       s3c64xx_iowrite8_32_rep(regs + S3C64XX_SPI_TX_DAT=
A,
> +                                               xfer->tx_buf, xfer->len);
> +               else
> +                       iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
> +                                    xfer->tx_buf, xfer->len);
> +               break;
> +       }
> +}
> +
>  static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>                                     struct spi_transfer *xfer, int dma_mo=
de)
>  {
> @@ -445,20 +500,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_sp=
i_driver_data *sdd,
>                         modecfg |=3D S3C64XX_SPI_MODE_TXDMA_ON;
>                         ret =3D s3c64xx_prepare_dma(&sdd->tx_dma, &xfer->=
tx_sg);
>                 } else {
> -                       switch (sdd->cur_bpw) {
> -                       case 32:
> -                               iowrite32_rep(regs + S3C64XX_SPI_TX_DATA,
> -                                       xfer->tx_buf, xfer->len / 4);
> -                               break;
> -                       case 16:
> -                               iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
> -                                       xfer->tx_buf, xfer->len / 2);
> -                               break;
> -                       default:
> -                               iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
> -                                       xfer->tx_buf, xfer->len);
> -                               break;
> -                       }
> +                       s3c64xx_iowrite_rep(sdd, xfer);

This extraction (with no functional change yet) could've been a
preceding separate patch, preparing things for this rework.

>                 }
>         }
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>

