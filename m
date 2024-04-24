Return-Path: <linux-kernel+bounces-156757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCACF8B07BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFBC1C22EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE7159906;
	Wed, 24 Apr 2024 10:54:27 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB99152E0B;
	Wed, 24 Apr 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956066; cv=none; b=miQXiQlZ5RHCr3MPbbiBplOhXD/C4YiZ6O//q+GERsJ8prV3CmZws1IKJ0HNHwgN5c3ql7zM//DJlSyxUStxDv5oTaYNZz5tLg2T2FdPnODS0w5afZjiP/QzRB7vdeZvCr/BWxvtl6krp3m0jgwN+zQzHdOkow/l9nMg2yLjfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956066; c=relaxed/simple;
	bh=dTdKB9+IkBBoLgEPCcacEl7xptPU+1wETHC5RBLak14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBUcST1H/NrhCgKaMio34dBQ5E0+5v3/cb2Flwg8MsuF3Kx4FnzCqRLePzs85W2ImyIiXWw4RKL/ncZowvLQD78XbgLDGecTVDKZfhQY8sZ9MuZGrq/G9ymB/nJh4mo73o3OtwghmSyU7lI69OBbvaBWb82ONIJnNgjaQgeBYko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed112c64beso5853031b3a.1;
        Wed, 24 Apr 2024 03:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713956064; x=1714560864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbRk+8O9BzuC/xDyoYPxAM90+rfheN7dqlzCKkmo9fI=;
        b=fKmq+FGj9fRPPgTYSaw1imRarnZJN+CUe6bHGD/N7Var7038bDN4DX+jRY6y/e7OOA
         Jtv8r0LkZmNmn0+K0EssPxFs7hJndLr4QM3aHWwLmhyev0b6IOTi2+QPMCuhBawBNUrR
         O4yGvBiuKTh9U2VC3RczlfOSUH4aSe09ijpPjLKp4PAAm1LczrIM+shBERbIX8DKk4zF
         57xQTNOOiM32oMpO/L0D8HkP1cdk1j64dpAL/beasZ49dCcIIv8FQDuvaa5wDfYVFoVs
         pFs8DJ+b1LTr09SyyPdpufcNLKNmm5ni1fc4wygVF0Kew5PKk4/89pDAWAAC1yf35mJ9
         fFMw==
X-Forwarded-Encrypted: i=1; AJvYcCUIOV4soHI/Wc6YOz3P8PrBJHehC0UxRSd8UITAhbwk9FkFRW7WYdN+QWykKFVQXhVk5mlco3LJbNx3+yD+jVXYR3ykddyKCkW1F0NM7w3RXQqw5Yr3WW7oM23DmchD3n+x1/H6cKep8fevtgPJQNrfcZ2lmTCRyckuxZicYdhtMB9a6wFKcnKJw61ob45e7WW1gaIHpWMq4MGUCQ==
X-Gm-Message-State: AOJu0Yz8ijjXmH9LoE4sm/QbbfD21N8RAOWfbyjDe+G1czAutgBID3s1
	3luRL+WpaJ5EtYDSjmUFQcy3fc7HO5bBxtmgXGi/cGqlR9KVtu9cVM2PXutZj3oZQUUmD+NcEMx
	TxieY/ECxk4GEnizRcO9jMbtclKY=
X-Google-Smtp-Source: AGHT+IEPBBrIzHYPuawwbCDK5O95umbDiYxjntGXJscMNGrfD44AaArcqQZ2F8S4CSUjX7zpwGx4/+8Es4RQwo03Gzc=
X-Received: by 2002:a05:6a00:ccd:b0:6eb:3d37:ce7a with SMTP id
 b13-20020a056a000ccd00b006eb3d37ce7amr2675985pfv.21.1713956064157; Wed, 24
 Apr 2024 03:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-2-bc0c61fd0c80@ew.tq-group.com>
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-2-bc0c61fd0c80@ew.tq-group.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Wed, 24 Apr 2024 19:54:12 +0900
Message-ID: <CAMZ6RqKYfFNGpKdwvu2ekuE5FDwiXgmH=Q3bA=QmDMKPLEzYsQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] can: mcp251xfd: mcp251xfd_regmap_crc_write():
 workaround for errata 5
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Thomas Kopp <thomas.kopp@microchip.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux@ew.tq-group.com, alexander.stein@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"

On Wed. 17 Apr. 2024 at 22:45, Gregor Herburger
<gregor.herburger@ew.tq-group.com> wrote:
> According to Errata DS80000789E 5 writing IOCON register using one SPI
> write command clears LAT0/LAT1.
>
> Errata Fix/Work Around suggests to write registers with single byte write
> instructions. However, it seems that every write to the second byte
> causes the overrite of LAT0/LAT1.
>
> Never write byte 2 of IOCON register to avoid clearing of LAT0/LAT1.
>
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 35 +++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> index 92b7bc7f14b9..ab4e372baffb 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> @@ -229,14 +229,47 @@ mcp251xfd_regmap_crc_gather_write(void *context,
>         return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
>  }
>
> +static int
> +mcp251xfd_regmap_crc_write_iocon(void *context, const void *data, size_t count)
                                                                            ^^^^
count is never used.

> +{
> +       const size_t data_offset = sizeof(__be16) +
> +               mcp251xfd_regmap_crc.pad_bits / BITS_PER_BYTE;
> +       u16 reg = *(u16 *)data;

This line made me scratch my head a lot.

When I see a void * parameter named data, I expect this to be a memory
region. Here, if I got this correctly, data is just a pointer to a u16
which represents the low bit of a register.

So, if you are not passing an address to a memory region but just a
single scalar, why the void *? Wouldn't it be better to just do:

  mcp251xfd_regmap_crc_write_iocon(void *context, u16 reg)

> +       /* Never write to bits 16..23 of IOCON register to avoid clearing of LAT0/LAT1
> +        *
> +        * According to Errata DS80000789E 5 writing IOCON register using one
> +        * SPI write command clears LAT0/LAT1.
> +        *
> +        * Errata Fix/Work Around suggests to write registers with single byte
> +        * write instructions. However, it seems that the byte at 0xe06(IOCON[23:16])
> +        * is for read-only access and writing to it causes the cleraing of LAT0/LAT1.
                                                                  ^^^^^^^^
clearing

> +        */
> +
> +       /* Write IOCON[15:0] */
> +       mcp251xfd_regmap_crc_gather_write(context, &reg, 1,
> +                                         data + data_offset, 2);
> +       reg += 3;
> +       /* Write IOCON[31:24] */
> +       mcp251xfd_regmap_crc_gather_write(context, &reg, 1,
> +                                         data + data_offset + 3, 1);
> +
> +       return 0;
> +}
> +
>  static int
>  mcp251xfd_regmap_crc_write(void *context,
>                            const void *data, size_t count)

This also uses the const void* data, except that here, this is kind of
forced by the prototype of the write() callback function from struct
regmap_bus. Also, count is properly used.

>  {
>         const size_t data_offset = sizeof(__be16) +
>                 mcp251xfd_regmap_crc.pad_bits / BITS_PER_BYTE;
> +       u16 reg = *(u16 *)data;
>
> -       return mcp251xfd_regmap_crc_gather_write(context,
> +       if (reg == MCP251XFD_REG_IOCON)
> +               return mcp251xfd_regmap_crc_write_iocon(context,
> +                                                data, count);

After changing the prototype of mcp251xfd_regmap_crc_write_iocon(),
this would then become:

                return mcp251xfd_regmap_crc_write_iocon(context, reg);

> +       else
> +               return mcp251xfd_regmap_crc_gather_write(context,
>                                                  data, data_offset,
>                                                  data + data_offset,
>                                                  count - data_offset);

