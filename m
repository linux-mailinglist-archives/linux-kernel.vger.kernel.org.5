Return-Path: <linux-kernel+bounces-40608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A4C83E320
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3421C23D68
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A962E22EEB;
	Fri, 26 Jan 2024 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwOZbQLF"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1E22627
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299960; cv=none; b=T3WdpIt8F5bfADXW75T6sPJPApNCqCw295AKTZ0BBS74JtD4dKOn32r55YvURelm77N+grg8IAaeX7yeW0lMtLSCimNZlkGMjrAvKRVNFzl8SmAt+nAZfXbVpVQlrykHZQSzzGmuHEzDKh+C99fCoSOGZt3X0MOhA94b2uHKkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299960; c=relaxed/simple;
	bh=a0Yq/xTAMlDgouEDJitJ2//0i4ddNSp6ZXp1xU8MJUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaqMdm4Z71zvX1jxfCOJMixDQfj9jvOH1x+CJYQdqHhz9K8+D0CljJZNFCXIMidEWjA381/penFnNuPKNANU8qEFyFFVv2dv/cdS0d77dZoU4ucAX0vJr6gb2MjgwJwhzz4xNS8CoEtnL7Gt7OdlLslVIirOP9wj9fAle0WYYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KwOZbQLF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddc2a78829so500533b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706299958; x=1706904758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXknaZoV7R8gu53HcjmL9jfNkrYiJhew3UKB+296MG4=;
        b=KwOZbQLF8y8gH1+5oQDwyNzhC+XGNuCM34nIBWyaLwgMg3mvxEokXV1XW7NgXSIrOV
         xl8x8lAAcOQMuDnFGnEFN4fgX4OU/falbKxwiRDtc/tVw0qjSnslRfIRpHf0zGuUWghR
         U79XdXxTyoQO4XXrTmHyJTEnTM6K5+1nKqMCQTlL81I3noau8AAz0iBcPaI7paYvClS5
         BPrXqWF4+9mPpneqTwrbOFSAXf3t5Xa4Eov3GjIPAAWYrHWIH7d+oFA1cUsF9Cb+SULh
         eQN/h09/aAq5WP5WD8OJUjEAquGaLMD+VgUDkIEKIUcnqixSg12AywARddxt/IKHU1LT
         YaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706299958; x=1706904758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXknaZoV7R8gu53HcjmL9jfNkrYiJhew3UKB+296MG4=;
        b=hvvGCw9F7uPIhB/A26PjKVD5HTlhXhZj0LgI/G/CUj2CPvtuvdQ76d+dmggguz2GqX
         afeCRH/FUh+orTzMW1rEDKNgt/Q9nmq2wQv9PBOWxVg6eh1Ik55JR0kOX+75j76eB44s
         OCBxoxEArZuUmN/BYSbTkkj1Mm5yk50+HfOhZPrzjgnjPXucuYdTkIdoAH7vwQMaiXoN
         stfkigYZRF+apsjRx8AbAC1lyVksi3HhHEyuoebO0WhysGfHDSgtWxKQ3IuZBN1bAkQ/
         KKkbHGYr9BXlermpQIeWvvDxcrxOP07eaKNdJADyUfmCHNHx0vWKJIydf1H7tGehxmqI
         183A==
X-Gm-Message-State: AOJu0Yx/7lo7eAJGtS/zM0oL1YtTfnW55B5A2lRzvUJJeC8VB2ab+1XY
	nzuaABZYNhSZGCWXkQBP0w4XOKGQlCOkxX6elWyKUcymmS6Ga/a1y79sr5O55jSvwBOG2Im35Vo
	FVhb/7YSYm1qIvY+iezVOrpwMR/e5j/MLLej60g==
X-Google-Smtp-Source: AGHT+IGQmEZzfiOh1fpYp4H6iNpq3oBgyslVxXR/i0o+p3GeM5StV5cAMpb/lDVLrSXfDBgoSp4VTuqTHdeK3clkiMk=
X-Received: by 2002:a05:6a00:230b:b0:6dd:db87:6394 with SMTP id
 h11-20020a056a00230b00b006dddb876394mr404534pfh.11.1706299958071; Fri, 26 Jan
 2024 12:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org> <20240126171546.1233172-18-tudor.ambarus@linaro.org>
In-Reply-To: <20240126171546.1233172-18-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 14:12:26 -0600
Message-ID: <CAPLW+4nL6D7R88Q_kJjAT-bWTFBk8a=FT0vL+fyRgxaDeSyhNw@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] spi: s3c64xx: use bitfield access macros
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
> Use the bitfield access macros in order to clean and to make the driver
> easier to read. Introduce S3C64XX_SPI_MAX_TRAILCNT_MASK to replace value
> and offset equivalents (S3C64XX_SPI_MAX_TRAILCNT,
> S3C64XX_SPI_TRAILCNT_OFF). While touching the register definitions, align
> their values to the same offset.
>
> No functional change intended, the bit operations shall be equivalent.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 193 ++++++++++++++++++++------------------
>  1 file changed, 101 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 43b888c8812e..7f052d6cd2ba 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -4,6 +4,7 @@
>  //      Jaswinder Singh <jassi.brar@samsung.com>
>
>  #include <linux/bits.h>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> @@ -18,91 +19,96 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/spi/spi.h>
>
> -#define MAX_SPI_PORTS          12
> -#define S3C64XX_SPI_QUIRK_CS_AUTO      (1 << 1)
> -#define AUTOSUSPEND_TIMEOUT    2000
> +#define MAX_SPI_PORTS                          12
> +#define S3C64XX_SPI_QUIRK_CS_AUTO              BIT(1)
> +#define AUTOSUSPEND_TIMEOUT                    2000
>
>  /* Registers and bit-fields */
>
> -#define S3C64XX_SPI_CH_CFG             0x00
> -#define S3C64XX_SPI_CLK_CFG            0x04
> -#define S3C64XX_SPI_MODE_CFG           0x08
> -#define S3C64XX_SPI_CS_REG             0x0C
> -#define S3C64XX_SPI_INT_EN             0x10
> -#define S3C64XX_SPI_STATUS             0x14
> -#define S3C64XX_SPI_TX_DATA            0x18
> -#define S3C64XX_SPI_RX_DATA            0x1C
> -#define S3C64XX_SPI_PACKET_CNT         0x20
> -#define S3C64XX_SPI_PENDING_CLR                0x24
> -#define S3C64XX_SPI_SWAP_CFG           0x28
> -#define S3C64XX_SPI_FB_CLK             0x2C
> -
> -#define S3C64XX_SPI_CH_HS_EN           (1<<6)  /* High Speed Enable */
> -#define S3C64XX_SPI_CH_SW_RST          (1<<5)
> -#define S3C64XX_SPI_CH_SLAVE           (1<<4)
> -#define S3C64XX_SPI_CPOL_L             (1<<3)
> -#define S3C64XX_SPI_CPHA_B             (1<<2)
> -#define S3C64XX_SPI_CH_RXCH_ON         (1<<1)
> -#define S3C64XX_SPI_CH_TXCH_ON         (1<<0)
> -
> -#define S3C64XX_SPI_CLKSEL_SRCMSK      (3<<9)
> -#define S3C64XX_SPI_CLKSEL_SRCSHFT     9
> -#define S3C64XX_SPI_ENCLK_ENABLE       (1<<8)
> -#define S3C64XX_SPI_PSR_MASK           0xff
> -
> -#define S3C64XX_SPI_MODE_CH_TSZ_BYTE           (0<<29)
> -#define S3C64XX_SPI_MODE_CH_TSZ_HALFWORD       (1<<29)
> -#define S3C64XX_SPI_MODE_CH_TSZ_WORD           (2<<29)
> -#define S3C64XX_SPI_MODE_CH_TSZ_MASK           (3<<29)
> -#define S3C64XX_SPI_MODE_BUS_TSZ_BYTE          (0<<17)
> -#define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD      (1<<17)
> -#define S3C64XX_SPI_MODE_BUS_TSZ_WORD          (2<<17)
> -#define S3C64XX_SPI_MODE_BUS_TSZ_MASK          (3<<17)
> +#define S3C64XX_SPI_CH_CFG                     0x00
> +#define S3C64XX_SPI_CLK_CFG                    0x04
> +#define S3C64XX_SPI_MODE_CFG                   0x08
> +#define S3C64XX_SPI_CS_REG                     0x0C
> +#define S3C64XX_SPI_INT_EN                     0x10
> +#define S3C64XX_SPI_STATUS                     0x14
> +#define S3C64XX_SPI_TX_DATA                    0x18
> +#define S3C64XX_SPI_RX_DATA                    0x1C
> +#define S3C64XX_SPI_PACKET_CNT                 0x20
> +#define S3C64XX_SPI_PENDING_CLR                        0x24
> +#define S3C64XX_SPI_SWAP_CFG                   0x28
> +#define S3C64XX_SPI_FB_CLK                     0x2C
> +
> +#define S3C64XX_SPI_CH_HS_EN                   BIT(6)  /* High Speed Ena=
ble */
> +#define S3C64XX_SPI_CH_SW_RST                  BIT(5)
> +#define S3C64XX_SPI_CH_SLAVE                   BIT(4)
> +#define S3C64XX_SPI_CPOL_L                     BIT(3)
> +#define S3C64XX_SPI_CPHA_B                     BIT(2)
> +#define S3C64XX_SPI_CH_RXCH_ON                 BIT(1)
> +#define S3C64XX_SPI_CH_TXCH_ON                 BIT(0)
> +
> +#define S3C64XX_SPI_CLKSEL_SRCMSK              GENMASK(10, 9)
> +#define S3C64XX_SPI_ENCLK_ENABLE               BIT(8)
> +#define S3C64XX_SPI_PSR_MASK                   GENMASK(7, 0)
> +
> +#define S3C64XX_SPI_MODE_CH_TSZ_MASK           GENMASK(30, 29)
> +#define S3C64XX_SPI_MODE_CH_TSZ_BYTE           0
> +#define S3C64XX_SPI_MODE_CH_TSZ_HALFWORD       1
> +#define S3C64XX_SPI_MODE_CH_TSZ_WORD           2
> +#define S3C64XX_SPI_MAX_TRAILCNT_MASK          GENMASK(28, 19)
> +#define S3C64XX_SPI_MODE_BUS_TSZ_MASK          GENMASK(18, 17)
> +#define S3C64XX_SPI_MODE_BUS_TSZ_BYTE          0
> +#define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD      1
> +#define S3C64XX_SPI_MODE_BUS_TSZ_WORD          2
>  #define S3C64XX_SPI_MODE_RX_RDY_LVL            GENMASK(16, 11)
> -#define S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT      11
> -#define S3C64XX_SPI_MODE_SELF_LOOPBACK         (1<<3)
> -#define S3C64XX_SPI_MODE_RXDMA_ON              (1<<2)
> -#define S3C64XX_SPI_MODE_TXDMA_ON              (1<<1)
> -#define S3C64XX_SPI_MODE_4BURST                        (1<<0)
> -
> -#define S3C64XX_SPI_CS_NSC_CNT_2               (2<<4)
> -#define S3C64XX_SPI_CS_AUTO                    (1<<1)
> -#define S3C64XX_SPI_CS_SIG_INACT               (1<<0)
> -
> -#define S3C64XX_SPI_INT_TRAILING_EN            (1<<6)
> -#define S3C64XX_SPI_INT_RX_OVERRUN_EN          (1<<5)
> -#define S3C64XX_SPI_INT_RX_UNDERRUN_EN         (1<<4)
> -#define S3C64XX_SPI_INT_TX_OVERRUN_EN          (1<<3)
> -#define S3C64XX_SPI_INT_TX_UNDERRUN_EN         (1<<2)
> -#define S3C64XX_SPI_INT_RX_FIFORDY_EN          (1<<1)
> -#define S3C64XX_SPI_INT_TX_FIFORDY_EN          (1<<0)
> -
> -#define S3C64XX_SPI_ST_RX_OVERRUN_ERR          (1<<5)
> -#define S3C64XX_SPI_ST_RX_UNDERRUN_ERR         (1<<4)
> -#define S3C64XX_SPI_ST_TX_OVERRUN_ERR          (1<<3)
> -#define S3C64XX_SPI_ST_TX_UNDERRUN_ERR         (1<<2)
> -#define S3C64XX_SPI_ST_RX_FIFORDY              (1<<1)
> -#define S3C64XX_SPI_ST_TX_FIFORDY              (1<<0)
> -
> -#define S3C64XX_SPI_PACKET_CNT_EN              (1<<16)
> +#define S3C64XX_SPI_MODE_SELF_LOOPBACK         BIT(3)
> +#define S3C64XX_SPI_MODE_RXDMA_ON              BIT(2)
> +#define S3C64XX_SPI_MODE_TXDMA_ON              BIT(1)
> +#define S3C64XX_SPI_MODE_4BURST                        BIT(0)
> +
> +/*
> + * S3C64XX_SPI_CS_NSC_CNT_2 is a value into the NCS_TIME_COUNT field. In=
 newer
> + * datasheets this field is defined as GENMASK(9, 4). We don't know if t=
his mask
> + * applies to all the versions of the IP, thus we can't yet define
> + * S3C64XX_SPI_CS_NSC_CNT_2 as a value and the register field as a mask.
> + */
> +#define S3C64XX_SPI_CS_NSC_CNT_2               (2 << 4)
> +#define S3C64XX_SPI_CS_AUTO                    BIT(1)
> +#define S3C64XX_SPI_CS_SIG_INACT               BIT(0)
> +
> +#define S3C64XX_SPI_INT_TRAILING_EN            BIT(6)
> +#define S3C64XX_SPI_INT_RX_OVERRUN_EN          BIT(5)
> +#define S3C64XX_SPI_INT_RX_UNDERRUN_EN         BIT(4)
> +#define S3C64XX_SPI_INT_TX_OVERRUN_EN          BIT(3)
> +#define S3C64XX_SPI_INT_TX_UNDERRUN_EN         BIT(2)
> +#define S3C64XX_SPI_INT_RX_FIFORDY_EN          BIT(1)
> +#define S3C64XX_SPI_INT_TX_FIFORDY_EN          BIT(0)
> +
> +#define S3C64XX_SPI_ST_RX_OVERRUN_ERR          BIT(5)
> +#define S3C64XX_SPI_ST_RX_UNDERRUN_ERR         BIT(4)
> +#define S3C64XX_SPI_ST_TX_OVERRUN_ERR          BIT(3)
> +#define S3C64XX_SPI_ST_TX_UNDERRUN_ERR         BIT(2)
> +#define S3C64XX_SPI_ST_RX_FIFORDY              BIT(1)
> +#define S3C64XX_SPI_ST_TX_FIFORDY              BIT(0)
> +
> +#define S3C64XX_SPI_PACKET_CNT_EN              BIT(16)
>  #define S3C64XX_SPI_PACKET_CNT_MASK            GENMASK(15, 0)
>
> -#define S3C64XX_SPI_PND_TX_UNDERRUN_CLR                (1<<4)
> -#define S3C64XX_SPI_PND_TX_OVERRUN_CLR         (1<<3)
> -#define S3C64XX_SPI_PND_RX_UNDERRUN_CLR                (1<<2)
> -#define S3C64XX_SPI_PND_RX_OVERRUN_CLR         (1<<1)
> -#define S3C64XX_SPI_PND_TRAILING_CLR           (1<<0)
> +#define S3C64XX_SPI_PND_TX_UNDERRUN_CLR                BIT(4)
> +#define S3C64XX_SPI_PND_TX_OVERRUN_CLR         BIT(3)
> +#define S3C64XX_SPI_PND_RX_UNDERRUN_CLR                BIT(2)
> +#define S3C64XX_SPI_PND_RX_OVERRUN_CLR         BIT(1)
> +#define S3C64XX_SPI_PND_TRAILING_CLR           BIT(0)
>
> -#define S3C64XX_SPI_SWAP_RX_HALF_WORD          (1<<7)
> -#define S3C64XX_SPI_SWAP_RX_BYTE               (1<<6)
> -#define S3C64XX_SPI_SWAP_RX_BIT                        (1<<5)
> -#define S3C64XX_SPI_SWAP_RX_EN                 (1<<4)
> -#define S3C64XX_SPI_SWAP_TX_HALF_WORD          (1<<3)
> -#define S3C64XX_SPI_SWAP_TX_BYTE               (1<<2)
> -#define S3C64XX_SPI_SWAP_TX_BIT                        (1<<1)
> -#define S3C64XX_SPI_SWAP_TX_EN                 (1<<0)
> +#define S3C64XX_SPI_SWAP_RX_HALF_WORD          BIT(7)
> +#define S3C64XX_SPI_SWAP_RX_BYTE               BIT(6)
> +#define S3C64XX_SPI_SWAP_RX_BIT                        BIT(5)
> +#define S3C64XX_SPI_SWAP_RX_EN                 BIT(4)
> +#define S3C64XX_SPI_SWAP_TX_HALF_WORD          BIT(3)
> +#define S3C64XX_SPI_SWAP_TX_BYTE               BIT(2)
> +#define S3C64XX_SPI_SWAP_TX_BIT                        BIT(1)
> +#define S3C64XX_SPI_SWAP_TX_EN                 BIT(0)
>
> -#define S3C64XX_SPI_FBCLK_MSK                  (3<<0)
> +#define S3C64XX_SPI_FBCLK_MASK                 GENMASK(1, 0)
>
>  #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
>  #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
> @@ -112,16 +118,13 @@
>                                         FIFO_LVL_MASK(i))
>  #define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
>
> -#define S3C64XX_SPI_MAX_TRAILCNT       0x3ff
> -#define S3C64XX_SPI_TRAILCNT_OFF       19
> -
>  #define S3C64XX_SPI_POLLING_SIZE       32
>
>  #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
>  #define is_polling(x)  (x->cntrlr_info->polling)
>
> -#define RXBUSY    (1<<2)
> -#define TXBUSY    (1<<3)
> +#define RXBUSY    BIT(2)
> +#define TXBUSY    BIT(3)
>
>  struct s3c64xx_spi_dma_data {
>         struct dma_chan *ch;
> @@ -664,16 +667,22 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_dr=
iver_data *sdd)
>
>         switch (sdd->cur_bpw) {
>         case 32:
> -               val |=3D S3C64XX_SPI_MODE_BUS_TSZ_WORD;
> -               val |=3D S3C64XX_SPI_MODE_CH_TSZ_WORD;
> +               val |=3D FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
> +                                 S3C64XX_SPI_MODE_BUS_TSZ_WORD) |
> +                      FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
> +                                 S3C64XX_SPI_MODE_CH_TSZ_WORD);
>                 break;
>         case 16:
> -               val |=3D S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD;
> -               val |=3D S3C64XX_SPI_MODE_CH_TSZ_HALFWORD;
> +               val |=3D FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
> +                                 S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD) |
> +                      FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
> +                                 S3C64XX_SPI_MODE_CH_TSZ_HALFWORD);

Two people complained it makes the code harder to read. Yet it's not
addressed in v3. Please see my comments for your previous submission
explaining what can be done, and also Andi's comment on that matter.
Also I think new patch series are being submitted a bit too fast,
people might not have enough time to provide the review.

>                 break;
>         default:
> -               val |=3D S3C64XX_SPI_MODE_BUS_TSZ_BYTE;
> -               val |=3D S3C64XX_SPI_MODE_CH_TSZ_BYTE;
> +               val |=3D FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
> +                                 S3C64XX_SPI_MODE_BUS_TSZ_BYTE) |
> +                      FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
> +                                 S3C64XX_SPI_MODE_CH_TSZ_BYTE);
>                 break;
>         }
>
> @@ -799,7 +808,7 @@ static int s3c64xx_spi_transfer_one(struct spi_contro=
ller *host,
>
>                         val =3D readl(sdd->regs + S3C64XX_SPI_MODE_CFG);
>                         val &=3D ~S3C64XX_SPI_MODE_RX_RDY_LVL;
> -                       val |=3D (rdy_lv << S3C64XX_SPI_MODE_RX_RDY_LVL_S=
HIFT);
> +                       val |=3D FIELD_PREP(S3C64XX_SPI_MODE_RX_RDY_LVL, =
rdy_lv);
>                         writel(val, sdd->regs + S3C64XX_SPI_MODE_CFG);
>
>                         /* Enable FIFO_RDY_EN IRQ */
> @@ -1072,8 +1081,8 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_d=
river_data *sdd)
>         writel(0, regs + S3C64XX_SPI_INT_EN);
>
>         if (!sdd->port_conf->clk_from_cmu)
> -               writel(sci->src_clk_nr << S3C64XX_SPI_CLKSEL_SRCSHFT,
> -                               regs + S3C64XX_SPI_CLK_CFG);
> +               writel(FIELD_PREP(S3C64XX_SPI_CLKSEL_SRCMSK, sci->src_clk=
_nr),
> +                      regs + S3C64XX_SPI_CLK_CFG);
>         writel(0, regs + S3C64XX_SPI_MODE_CFG);
>         writel(0, regs + S3C64XX_SPI_PACKET_CNT);
>
> @@ -1089,7 +1098,7 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_d=
river_data *sdd)
>
>         val =3D readl(regs + S3C64XX_SPI_MODE_CFG);
>         val &=3D ~S3C64XX_SPI_MODE_4BURST;
> -       val |=3D (S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
> +       val |=3D S3C64XX_SPI_MAX_TRAILCNT_MASK;
>         writel(val, regs + S3C64XX_SPI_MODE_CFG);
>
>         s3c64xx_flush_fifo(sdd);
> --
> 2.43.0.429.g432eaa2c6b-goog
>

