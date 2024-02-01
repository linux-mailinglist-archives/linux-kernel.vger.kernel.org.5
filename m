Return-Path: <linux-kernel+bounces-48703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41978845FF8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A088C1F241E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C300662158;
	Thu,  1 Feb 2024 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSsdxOkd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82F12FB0E;
	Thu,  1 Feb 2024 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812334; cv=none; b=ufiqQjOqCoFpw+tyousiv6HvWQSNnmoq57oQcW8vMEbQ92Cb/akqpjiDsWOJE6Khgt/ZdmtsjorfYDUl6lFCdEzeS6OfDHqZXZzkTO5hYRyJmqjou2cO7BJTecSRS8cIIEQUfFuVZfeNOMjtVPngooj57hz0Vjt++akbyphL9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812334; c=relaxed/simple;
	bh=HBONCdrxzDqsxndhvVUnYO6LFvC8ZcUi1vLplgj5IO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/yidI5sloCES8F70OtTEGsNmk++zngN/VDceUvMs2ljX8dzLmJVOJI9ZrHwS0e29g2uPGeUYD9DmhvqQeYpucPfqWkjvRmpmvUU1LQkt5oV+1BXR6woEjx5K/cxdBqKVw5Y7bVGteg54PmoEhUrV6322bh+BIC2wNP8ltwnwtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSsdxOkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF8DC433C7;
	Thu,  1 Feb 2024 18:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706812334;
	bh=HBONCdrxzDqsxndhvVUnYO6LFvC8ZcUi1vLplgj5IO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSsdxOkdBhbQAtPx9jBFEUfHGCwzCZ6edeHKJcNVeywrqCdY9zdUgOVZgDCnj+Z8+
	 7GkqdwI0CTph2ii7IV8ROrZkSAVVIOYonb7Ij+kvVfiMENKSQYlakprWWFCB+t63pZ
	 j1ZtdSPIid5DyqCluM5OBkoY1MFI6ik6QNKyT2ZaqdVa8aX1Nx92NpsIHhhQLXlXTT
	 an00Jwx5gLXg781IrDQtS907l1GxqExYTbW5hEhdUl28Rzqojgqj/W9+u3bONiW0Oj
	 3thn3wbo+tD9lAEZFbD/CFgCBBUi1Bqnu8+GNFKnK8TGM6atGxhKuV1rM8oIFok4eK
	 1U7gsZzUm0BFg==
Date: Thu, 1 Feb 2024 18:32:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Charles Hsu <ythsu0511@gmail.com>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: sort entries
 alphanumerically
Message-ID: <20240201-silliness-unfair-265a0d896377@spud>
References: <20240201075805.7492-1-krzysztof.kozlowski@linaro.org>
 <5461a237-1df4-4077-86ef-e9ff6ff17e27@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N+zoBAHBXolU7sZ9"
Content-Disposition: inline
In-Reply-To: <5461a237-1df4-4077-86ef-e9ff6ff17e27@roeck-us.net>


--N+zoBAHBXolU7sZ9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 05:25:13AM -0800, Guenter Roeck wrote:
> On 1/31/24 23:58, Krzysztof Kozlowski wrote:
> > Sort entries alphanumerically.  This was a semi manual job with help of:
> >=20
> >    cat Documentation/devicetree/bindings/trivial-devices.yaml | grep ' =
   - ' > old
> >    cat old | sort -n > new
> >    diff -ubB old new
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
>=20
> Acked-by: Guenter Roeck <linux@roeck-us.net>

z sorts before a, please fix in the whole file.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> > ---
> >=20
> > Cc: Charles Hsu <ythsu0511@gmail.com>
> > Cc: linux-hwmon@vger.kernel.org
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > ---
> >   .../devicetree/bindings/trivial-devices.yaml  | 73 ++++++++++---------
> >   1 file changed, 37 insertions(+), 36 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/D=
ocumentation/devicetree/bindings/trivial-devices.yaml
> > index 5b52950e6bfc..41982a41398a 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -28,6 +28,7 @@ properties:
> >     compatible:
> >       items:
> > +      # Entries are sorted alphanumerically by the compatible
> >         - enum:
> >               # Acbel fsg032 power supply
> >             - acbel,fsg032
> > @@ -49,12 +50,12 @@ properties:
> >             - ams,iaq-core
> >               # i2c serial eeprom (24cxx)
> >             - at,24c08
> > +            # i2c h/w elliptic curve crypto module
> > +          - atmel,atecc508a
> >               # ATSHA204 - i2c h/w symmetric crypto module
> >             - atmel,atsha204
> >               # ATSHA204A - i2c h/w symmetric crypto module
> >             - atmel,atsha204a
> > -            # i2c h/w elliptic curve crypto module
> > -          - atmel,atecc508a
> >               # BPA-RS600: Power Supply
> >             - blutek,bpa-rs600
> >               # Bosch Sensortec pressure, temperature, humididty and VO=
C sensor
> > @@ -115,20 +116,6 @@ properties:
> >             - fsl,mpl3115
> >               # MPR121: Proximity Capacitive Touch Sensor Controller
> >             - fsl,mpr121
> > -            # Monolithic Power Systems Inc. multi-phase controller mp2=
856
> > -          - mps,mp2856
> > -            # Monolithic Power Systems Inc. multi-phase controller mp2=
857
> > -          - mps,mp2857
> > -            # Monolithic Power Systems Inc. multi-phase controller mp2=
888
> > -          - mps,mp2888
> > -            # Monolithic Power Systems Inc. multi-phase controller mp2=
971
> > -          - mps,mp2971
> > -            # Monolithic Power Systems Inc. multi-phase controller mp2=
973
> > -          - mps,mp2973
> > -            # Monolithic Power Systems Inc. multi-phase controller mp2=
975
> > -          - mps,mp2975
> > -            # Monolithic Power Systems Inc. multi-phase hot-swap contr=
oller mp5990
> > -          - mps,mp5990
> >               # Honeywell Humidicon HIH-6130 humidity/temperature sensor
> >             - honeywell,hi6130
> >               # IBM Common Form Factor Power Supply Versions (all versi=
ons)
> > @@ -197,6 +184,8 @@ properties:
> >             - maxim,max1237
> >               # Temperature Sensor, I2C interface
> >             - maxim,max1619
> > +            # 3-Channel Remote Temperature Sensor
> > +          - maxim,max31730
> >               # 10-bit 10 kOhm linear programmable voltage divider
> >             - maxim,max5481
> >               # 10-bit 50 kOhm linear programmable voltage divider
> > @@ -209,8 +198,6 @@ properties:
> >             - maxim,max6621
> >               # 9-Bit/12-Bit Temperature Sensors with I=B2C-Compatible =
Serial Interface
> >             - maxim,max6625
> > -            # 3-Channel Remote Temperature Sensor
> > -          - maxim,max31730
> >               # mCube 3-axis 8-bit digital accelerometer
> >             - mcube,mc3230
> >               # Measurement Specialities I2C temperature and humidity s=
ensor
> > @@ -241,8 +228,6 @@ properties:
> >             - memsic,mxc6655
> >               # Menlo on-board CPLD trivial SPI device
> >             - menlo,m53cpld
> > -            # Micron SPI NOR Authenta
> > -          - micron,spi-authenta
> >               # Microchip differential I2C ADC, 1 Channel, 18 bit
> >             - microchip,mcp3421
> >               # Microchip differential I2C ADC, 2 Channel, 18 bit
> > @@ -259,40 +244,56 @@ properties:
> >             - microchip,mcp3427
> >               # Microchip differential I2C ADC, 4 Channel, 16 bit
> >             - microchip,mcp3428
> > -            # Microchip 7-bit Single I2C Digital POT (5k)
> > -          - microchip,mcp4017-502
> >               # Microchip 7-bit Single I2C Digital POT (10k)
> >             - microchip,mcp4017-103
> > -            # Microchip 7-bit Single I2C Digital POT (50k)
> > -          - microchip,mcp4017-503
> >               # Microchip 7-bit Single I2C Digital POT (100k)
> >             - microchip,mcp4017-104
> >               # Microchip 7-bit Single I2C Digital POT (5k)
> > -          - microchip,mcp4018-502
> > +          - microchip,mcp4017-502
> > +            # Microchip 7-bit Single I2C Digital POT (50k)
> > +          - microchip,mcp4017-503
> >               # Microchip 7-bit Single I2C Digital POT (10k)
> >             - microchip,mcp4018-103
> > -            # Microchip 7-bit Single I2C Digital POT (50k)
> > -          - microchip,mcp4018-503
> >               # Microchip 7-bit Single I2C Digital POT (100k)
> >             - microchip,mcp4018-104
> >               # Microchip 7-bit Single I2C Digital POT (5k)
> > -          - microchip,mcp4019-502
> > +          - microchip,mcp4018-502
> > +            # Microchip 7-bit Single I2C Digital POT (50k)
> > +          - microchip,mcp4018-503
> >               # Microchip 7-bit Single I2C Digital POT (10k)
> >             - microchip,mcp4019-103
> > -            # Microchip 7-bit Single I2C Digital POT (50k)
> > -          - microchip,mcp4019-503
> >               # Microchip 7-bit Single I2C Digital POT (100k)
> >             - microchip,mcp4019-104
> > +            # Microchip 7-bit Single I2C Digital POT (5k)
> > +          - microchip,mcp4019-502
> > +            # Microchip 7-bit Single I2C Digital POT (50k)
> > +          - microchip,mcp4019-503
> >               # PWM Fan Speed Controller With Fan Fault Detection
> >             - microchip,tc654
> >               # PWM Fan Speed Controller With Fan Fault Detection
> >             - microchip,tc655
> > +            # Micron SPI NOR Authenta
> > +          - micron,spi-authenta
> >               # MiraMEMS DA226 2-axis 14-bit digital accelerometer
> >             - miramems,da226
> >               # MiraMEMS DA280 3-axis 14-bit digital accelerometer
> >             - miramems,da280
> >               # MiraMEMS DA311 3-axis 12-bit digital accelerometer
> >             - miramems,da311
> > +            # Monolithic Power Systems Inc. multi-phase controller mp2=
856
> > +          - mps,mp2856
> > +            # Monolithic Power Systems Inc. multi-phase controller mp2=
857
> > +          - mps,mp2857
> > +            # Monolithic Power Systems Inc. multi-phase controller mp2=
888
> > +          - mps,mp2888
> > +            # Monolithic Power Systems Inc. multi-phase controller mp2=
971
> > +          - mps,mp2971
> > +            # Monolithic Power Systems Inc. multi-phase controller mp2=
973
> > +          - mps,mp2973
> > +            # Monolithic Power Systems Inc. multi-phase controller mp2=
975
> > +          - mps,mp2975
> > +            # Monolithic Power Systems Inc. multi-phase hot-swap contr=
oller mp5990
> > +          - mps,mp5990
> >               # Temperature sensor with integrated fan control
> >             - national,lm63
> >               # Serial Interface ACPI-Compatible Microprocessor System =
Hardware Monitor
> > @@ -323,12 +324,12 @@ properties:
> >             - samsung,exynos-sataphy-i2c
> >               # Semtech sx1301 baseband processor
> >             - semtech,sx1301
> > -            # Sensirion low power multi-pixel gas sensor with I2C inte=
rface
> > -          - sensirion,sgpc3
> >               # Sensirion multi-pixel gas sensor with I2C interface
> >             - sensirion,sgp30
> >               # Sensirion gas sensor with I2C interface
> >             - sensirion,sgp40
> > +            # Sensirion low power multi-pixel gas sensor with I2C inte=
rface
> > +          - sensirion,sgpc3
> >               # Sensirion temperature & humidity sensor with I2C interf=
ace
> >             - sensirion,sht4x
> >               # Sensortek 3 axis accelerometer
> > @@ -374,8 +375,6 @@ properties:
> >             - ti,lm74
> >               # Temperature sensor with integrated fan control
> >             - ti,lm96000
> > -            # I2C Touch-Screen Controller
> > -          - ti,tsc2003
> >               # Low Power Digital Temperature Sensor with SMBUS/Two Wir=
e Serial Interface
> >             - ti,tmp103
> >               # Thermometer with SPI interface
> > @@ -397,10 +396,12 @@ properties:
> >             - ti,tps544b25
> >             - ti,tps544c20
> >             - ti,tps544c25
> > -            # Winbond/Nuvoton H/W Monitor
> > -          - winbond,w83793
> > +            # I2C Touch-Screen Controller
> > +          - ti,tsc2003
> >               # Vicor Corporation Digital Supervisor
> >             - vicor,pli1209bc
> > +            # Winbond/Nuvoton H/W Monitor
> > +          - winbond,w83793
> >   required:
> >     - compatible
>=20

--N+zoBAHBXolU7sZ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbvjqQAKCRB4tDGHoIJi
0pUkAQC7COG0wQHXHHVbr9oUN80S3HyMBEKEt1fd8f2t04rMUgEAxFHMu3kpe2Oi
8v4ZZvn3JWpDH2UeG3AlDkN1ByEr0gE=
=hyjd
-----END PGP SIGNATURE-----

--N+zoBAHBXolU7sZ9--

