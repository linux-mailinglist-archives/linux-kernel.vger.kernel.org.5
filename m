Return-Path: <linux-kernel+bounces-158027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7158B1A60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9711C21412
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0002A3C08D;
	Thu, 25 Apr 2024 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="WbKBXPKZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="O44VQT3J"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183662B9C8;
	Thu, 25 Apr 2024 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023447; cv=none; b=FnuB+l0DtaBP7z6hDyrUfv3UfKws3GU0mVJgXRNr6M4XfK2gyJVcs8aSN6DuAeiJSoS3Cwl9g5Mg9UurrzBZ49qOyNSZLmZgsJoKuoUuMZadQ9kV0ffcECl+ACrtQK+dlxTGwQCR4w7PLqI7lu3WsoGiM9+NFIcNg9Dcau84R0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023447; c=relaxed/simple;
	bh=jZmOl3rou60PlMW9u4r/ORdM+/lfAajXL/HWXhh7L48=;
	h=Subject:Date:From:To:Cc:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaYtHfOetoy5VDjhFDS6ze1DZbNC43eRThD9xfSFsPjqV8uDPlN2uRfPpLSm2REpRb1pak7LNaUX9g6yU1O19nqUZ71Q1+4dhbjGU6xG01zF63xy/6y/BeLrtFQKA/DYPlZn1uFnU1EwXwSuCI+mbWJx+PJ/0l2mgy0y4Sqws04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=WbKBXPKZ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=O44VQT3J reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714023443; x=1745559443;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=x2ZR+RxKM/yGV3UpXGKOOZBBDQ6YDdkkFSm5SsEI2O8=;
  b=WbKBXPKZB2soyiaMmER/UYom8cLLZCEJpl3uQfNz4i7PSZj9GQNNReOc
   ToSAaBGu8x27me6IbYbUPGAzug7mRv8ZJAmpDeNoYQOy+ux0TjcKBIhjy
   A+LdduWDIjxKWrVcmtWMBuqw+G8C7Io/HgZEi39rCrTLn3bZ8PnBC7JVG
   F0qSkjsKFGV5FERFrvmlj/E351v/QSJE0Ecpz6ZGESIU0+ZE4XbMzUA86
   Dpiy0bmeSBNoW6dMf4Mswb3X4dwfE5NcLkPw27v3IXVz4QAT6TBYhyI8L
   6QcDbiNdinSRI03HC/hCEdisr6diwQ5/WszswvWNlDHP/4WQpIijxgyRA
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,228,1708383600"; 
   d="scan'208";a="36602691"
Subject: Re: Re: [PATCH 2/4] can: mcp251xfd: mcp251xfd_regmap_crc_write(): workaround
 for errata 5
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Apr 2024 07:37:19 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBEC71754C3;
	Thu, 25 Apr 2024 07:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714023435;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x2ZR+RxKM/yGV3UpXGKOOZBBDQ6YDdkkFSm5SsEI2O8=;
	b=O44VQT3J6MtRj/ezPHG1zEQv2dl16x3f0IgUHHEGLhP9MW1QNn3QXnJ0+YzTqor4N5juyH
	vKdoWzxDDywAOTvHeObegS838YXIKrgRuvduVoOlL73AOFj74+N90o2dHuYmVpU6rO9fsB
	mm23DiqbyxnV5/o2DU/lRUlaYwgBU5cqwobBXnyMtIGPDSI2Mnb6gTKxFYLFAdkemRdz8R
	iILPRW8JT9hJWNvPFOMaU4lfHe58zi6r9r4lmWbTLVVETDonbWn1qIFNjvy4W5vfEb2Lle
	GjFGSvONhFL8KYgpRqaBYemFrjT0Q0Ed+FImsXcgrokCeHz5wPF5H/d8AwJ21Q==
Date: Thu, 25 Apr 2024 07:37:13 +0200
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Message-ID: <ZinsCZy0D7YBK0Gu@herburgerg-w2>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-2-bc0c61fd0c80@ew.tq-group.com>
 <20240424-worm-of-massive-triumph-2eaf27-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424-worm-of-massive-triumph-2eaf27-mkl@pengutronix.de>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Apr 24, 2024 at 01:51:37PM +0200, Marc Kleine-Budde wrote:
> On 17.04.2024 15:43:55, Gregor Herburger wrote:
> > According to Errata DS80000789E 5 writing IOCON register using one SPI
> > write command clears LAT0/LAT1.
> > 
> > Errata Fix/Work Around suggests to write registers with single byte write
> > instructions. However, it seems that every write to the second byte
> > causes the overrite of LAT0/LAT1.
> 
> This change doesn't use single byte write instructions.

Yes, because this is not necessary. Single byte write instructions
wont't fix the problem. The microchip errata sheet is wrong or at least
misleading expressed.

From my observation single byte insctructions won't fix the problem. No
write to bits [16:24] does fix the problem.

I talked to Thomas Kopp from Microchip about that and he confirmed my
observations.
> 
> > Never write byte 2 of IOCON register to avoid clearing of LAT0/LAT1.
> 
> I discovered that erratum, it's described in
> mcp251xfd_chip_rx_int_enable():
> 
> 	/* Configure GPIOs:
> 	 * - PIN0: GPIO Input
> 	 * - PIN1: GPIO Input/RX Interrupt
> 	 *
> 	 * PIN1 must be Input, otherwise there is a glitch on the
> 	 * rx-INT line. It happens between setting the PIN as output
> 	 * (in the first byte of the SPI transfer) and configuring the
> 	 * PIN as interrupt (in the last byte of the SPI transfer).
> 	 */
> 
> The problem is that the SPI writes 1 byte at a time, starting at the
> lower address. The chip updates the GPIO pin's status after each written
> byte.
> 
> This may leads to a glitch if you have an external pull up. The power on
> default auf the chip is GPIO/input, the GPIO line is not driven by the
> chip and with the external pull up this will result in a high level.
> 
> If you configure the GPIO as an output/high, the driver first writes
> bits 0...7, which results in the GPIO line being configured as an
> output; the subsequent bits 8...15 configure the level of the GPIO
> line.
> 
> This change doesn't take care of this.

I'm not sure if this is the same problem. Anyway, with this fix we didn't
see any glitches on the gpio lines.
> 
> I'm not sure, if it's better to have 2 dedicated writes to IOCON in the
> driver or try to hide it here in the regmap.

What would be the alternative? Maybe add a mcp251xfd_write_iocon
function to the driver and call there regmap_update_bits twice?

> 
> > Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> > ---
> >  drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 35 +++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> > index 92b7bc7f14b9..ab4e372baffb 100644
> > --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> > +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> > @@ -229,14 +229,47 @@ mcp251xfd_regmap_crc_gather_write(void *context,
> >  	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
> >  }
> >  
> > +static int
> > +mcp251xfd_regmap_crc_write_iocon(void *context, const void *data, size_t count)
> > +{
> > +	const size_t data_offset = sizeof(__be16) +
> > +		mcp251xfd_regmap_crc.pad_bits / BITS_PER_BYTE;
> > +	u16 reg = *(u16 *)data;
> > +
> > +	/* Never write to bits 16..23 of IOCON register to avoid clearing of LAT0/LAT1
> > +	 *
> > +	 * According to Errata DS80000789E 5 writing IOCON register using one
> > +	 * SPI write command clears LAT0/LAT1.
> > +	 *
> > +	 * Errata Fix/Work Around suggests to write registers with single byte
> > +	 * write instructions. However, it seems that the byte at 0xe06(IOCON[23:16])
> > +	 * is for read-only access and writing to it causes the cleraing of LAT0/LAT1.
> > +	 */
> > +
> > +	/* Write IOCON[15:0] */
> > +	mcp251xfd_regmap_crc_gather_write(context, &reg, 1,
> > +					  data + data_offset, 2);
> 
> You write 15:0 in 1 go here.
See above.
> 
> > +	reg += 3;
> > +	/* Write IOCON[31:24] */
> > +	mcp251xfd_regmap_crc_gather_write(context, &reg, 1,
> > +					  data + data_offset + 3, 1);
> > +
> > +	return 0;
> > +}
> > +
> >  static int
> >  mcp251xfd_regmap_crc_write(void *context,
> >  			   const void *data, size_t count)
> >  {
> >  	const size_t data_offset = sizeof(__be16) +
> >  		mcp251xfd_regmap_crc.pad_bits / BITS_PER_BYTE;
> > +	u16 reg = *(u16 *)data;
> >  
> > -	return mcp251xfd_regmap_crc_gather_write(context,
> > +	if (reg == MCP251XFD_REG_IOCON)
> > +		return mcp251xfd_regmap_crc_write_iocon(context,
> > +						 data, count);
> > +	else
> > +		return mcp251xfd_regmap_crc_gather_write(context,
> >  						 data, data_offset,
> >  						 data + data_offset,
> >  						 count - data_offset);
> 
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


Best regards,
Gregor
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

