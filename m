Return-Path: <linux-kernel+bounces-106107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0574987E941
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619A6282C89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94491381C6;
	Mon, 18 Mar 2024 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln+WCaVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53F9A2A;
	Mon, 18 Mar 2024 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764567; cv=none; b=F8nngUOg2d3h8yyhPj0UcEJ3l1kDPRH0a2yckMgTNdZUA8tWzyZr+wGvYVBCCZqa8Ln032NSJxq1/Spr85CZJyv7RZ9Ty3EvojycsE6xJ6qmK7Dq4gVfiLHa6kVpH00H2FVENPJiOV2b6HIxK7NR1SU7c4m577tjRzD0pCYE7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764567; c=relaxed/simple;
	bh=un1g+YfgVkYFs27YaapA86lET7/7qDXX/87foF3/4jQ=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=YtZdW9emqGJk0qviqH+fahG6/1W/YLJlqjOryrmhCpqH5arkpZLfog+1+Rj3AGFjk7K4Ea3F7PTEQsZc/9xKC/IqTZOiMwI/uD676RTaO0RyCeN3gatf4U0cjHpOQFuFwYrHrgwmlvMmixz6uSHUXIR71O0FWDWQw2wrYCQYs+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln+WCaVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97ADC433F1;
	Mon, 18 Mar 2024 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710764567;
	bh=un1g+YfgVkYFs27YaapA86lET7/7qDXX/87foF3/4jQ=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=Ln+WCaVdNRqXaJFEuNS5IoXa4rRybNMBmx+LnPLdoJtQJ4xqmpdcYJHtwq71mfprs
	 KdfRAPkcJDqETrkrxAeuexH4AwM/KC+fDT4tFJ1PjqK4U2H4DBxZ0uiqMMz0W8msIY
	 whR+8woYzhVQN24/90IGy2hWtUoWfHD+lN1hRiS84pO/zXHG1d3QVM9RfiXDkCY+hZ
	 pAPYFgNtweCNjG9uMaWNln7uobtZUG2Ul3pwmZdrbwpXYUnD77+NqPzfCKDPzwH+XJ
	 W6aQtPsJsnE2ii5mWbSlzK8eyDf1uj35iYzKLnJ8ZF4jsax2P7EOMNCfCIcwGtVwOr
	 5ETGK47CYH+pA==
Content-Type: multipart/signed;
 boundary=5b1cdbb2bfff3981f7fa73881728b1e490b4ec8b8dbb9cc9a77399e55bd9;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 18 Mar 2024 13:22:39 +0100
Message-Id: <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Cc: <jkridner@beagleboard.org>, <robertcnelson@beagleboard.org>,
 <lorforlinux@beagleboard.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>, "Derek Kiernan"
 <derek.kiernan@amd.com>, "Dragan Cvetic" <dragan.cvetic@amd.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Vaishnav M A" <vaishnav.a@ti.com>, "Mark
 Brown" <broonie@kernel.org>, "Johan Hovold" <johan@kernel.org>, "Alex
 Elder" <elder@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/TEXAS
 INSTRUMENTS K3 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open
 list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, "moderated list:GREYBUS
 SUBSYSTEM" <greybus-dev@lists.linaro.org>, "Vaishnav M A"
 <vaishnav@beagleboard.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Ayush Singh" <ayushdevel1325@gmail.com>, "open list"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
In-Reply-To: <20240317193714.403132-2-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--5b1cdbb2bfff3981f7fa73881728b1e490b4ec8b8dbb9cc9a77399e55bd9
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sun Mar 17, 2024 at 8:37 PM CET, Ayush Singh wrote:
> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
> developed by MikroElektronika for connecting add-on boards to
> microcontrollers or microprocessors.
>
> mikroBUS is a connector and does not have a controller. Instead the
> software is responsible for identification of board and setting up /
> registering uart, spi, i2c, pwm and other buses. Thus it needs a way to
> get uart, spi, i2c, pwm and gpio controllers / adapters.
>
> A mikroBUS addon board is free to leave some of the pins unused which
> are marked as NC or Not Connected.
>
> Some of the pins might need to be configured as GPIOs deviating from thei=
r
> reserved purposes Eg: SHT15 Click where the SCL and SDA Pins need to be
> configured as GPIOs for the driver (drivers/hwmon/sht15.c) to work.
>
> For some add-on boards the driver may not take care of some additional
> signals like reset/wake-up/other. Eg: ENC28J60 click where the reset line
> (RST pin on the mikrobus port) needs to be pulled high.
>
> Here's the list of pins in mikroBUS connector:
> Analog - AN
> Reset - RST
> SPI Chip Select - CS
> SPI Clock - SCK
> SPI Master Input Slave Output - MISO
> SPI Master Output Slave Input - MOSI
> VCC-3.3V power - +3.3V
> Reference Ground - GND
> PWM - PWM output
> INT - Hardware Interrupt
> RX - UART Receive
> TX - UART Transmit
> SCL - I2C Clock
> SDA - I2C Data
> +5V - VCC-5V power
> GND - Reference Ground
>
> Additionally, some new mikroBUS boards contain 1-wire EEPROM that contain=
s
> a manifest to describe the addon board to provide plug and play
> capabilities.
>
> Link: https://www.mikroe.com/mikrobus
> Link:
> https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standar=
d-specification-v200.pdf
> mikroBUS specification
> Link: https://www.mikroe.com/sht1x-click SHT15 Click
> Link: https://www.mikroe.com/eth-click ENC28J60 Click
> Link: https://www.mikroe.com/clickid ClickID
>
> Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  .../connector/mikrobus-connector.yaml         | 113 ++++++++++++++++++

See also
https://lore.kernel.org/r/YmFo+EntwxIsco%2Ft@robh.at.kernel.org/

Looks like this proposal doesn't have the subnodes. How do you
attach a kernel driver to it's spi port for example? Only through
the manifest files?

-michael

--5b1cdbb2bfff3981f7fa73881728b1e490b4ec8b8dbb9cc9a77399e55bd9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZfgyDxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvumDQD8CZkXa8J8MUqzwei97TL1VRyNWj2W9lIy
UvuoJENGh0oBAJxlj4QiS6iQAYFIzlfq+qxOHyAaZxYmbMrXfMzOEV0C
=Uh8v
-----END PGP SIGNATURE-----

--5b1cdbb2bfff3981f7fa73881728b1e490b4ec8b8dbb9cc9a77399e55bd9--

