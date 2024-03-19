Return-Path: <linux-kernel+bounces-107502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC7187FD60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62C4281AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CE57F7C7;
	Tue, 19 Mar 2024 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/6qC1AN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E197F486;
	Tue, 19 Mar 2024 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710850121; cv=none; b=TXsO3dkkdWqsM7OJSMT+DXa9Iu6J5WJp5+D8IX2cfC/SCZG6Slj7zbf/Lt6FOELln7y81k53hHje5nVztDPnouIOtblTjmTGGlK5L3jraobRh9sqHkhqgFq+v7sqWTQrH8Xl9Jqdt3c3ZzaGxCdoGpOEaMQ7J0euf3PTxntmyac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710850121; c=relaxed/simple;
	bh=hnSVsLiLejS2+H2QkSYnP/1VC+dBGjS25lGVUBroTNM=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=Jn1OSnbl2ewGkFOupkk44HNM/dvIvOEJOMb89mcDnkCRv1uiXHbzrpIRa4AeAupzAfvIH9/BntqyLRVZPspFDtaY6T16NLn5FbQbbloe4fIwSS+p6Dt2guVBW/txnqoWxMDad0dgwmkjXz0Y1E3QepMHl1aOYGaIx6ULQD5kvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/6qC1AN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF96AC433C7;
	Tue, 19 Mar 2024 12:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710850121;
	bh=hnSVsLiLejS2+H2QkSYnP/1VC+dBGjS25lGVUBroTNM=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=S/6qC1ANHMIvVNMlBpY/FEIfzg21ybAe6BjNnNSWe8VX2Vi9A9XudWvAdNx8j3uzE
	 03fdkU/dTxYfY0WC10r3RaK90sK8IRwKczX5EcXA6TkbvCdm0ZyVrnCBtVmzF5/l1N
	 OFYILoRBkXVG3NdZP7iKDcLTKEX1q/32L1nNVy+0adleyZttizwpNd6uemATz4pUgw
	 72rca3a2DSz5SzoAiDwOKYbSd/+ukCpCNZVRdudSoUIznilfrnizhX8RXqAJRvChP6
	 M7S4iIIqDRjikI/KpbcctbztXR6V+Fxo23LkHwnyRJilvGAZ1nYFph1dBYdlirp6ZX
	 UqHT4RLzgE+hQ==
Content-Type: multipart/signed;
 boundary=c332393a90d01da165088274218ef3aba6b575ac7f9169419f630293fb78;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 19 Mar 2024 13:08:33 +0100
Message-Id: <CZXPQZY8PUGE.QZM8XSOUNMT4@kernel.org>
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
To: "Ayush Singh" <ayushdevel1325@gmail.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "open list"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
 <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
 <0f3f56d4-3381-44f1-91bc-c126f3ced085@linaro.org>
 <c8031e17-5ae8-4794-8b8c-1736be6452d3@gmail.com>
 <CZXMK3W52AFO.1APK080GVJESK@kernel.org>
 <5a9b1cd9-05ec-4606-92b6-eadbc7af6202@gmail.com>
In-Reply-To: <5a9b1cd9-05ec-4606-92b6-eadbc7af6202@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--c332393a90d01da165088274218ef3aba6b575ac7f9169419f630293fb78
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Mar 19, 2024 at 12:36 PM CET, Ayush Singh wrote:
> >> Regardless, this patch actually does not contain any code for EEPROM
> >> support I have just mentioned it to give more context on why mikroBUS
> >> manifest is the focus of this patch instead of DT overlay or something
> >> else.
> > Right, and I think this is the crux here. Why can't you use DT
> > overlays? The manifest files, seem to be yet another hardware
> > description (method) and we already have DT. Can't we have some kind
> > of userspace helper that could translate them to DT overlays? That
> > way, you could also handle the EEPROM vs non-EEPROM case, or have
> > some other kind of method to load a DT overlay.
> >
> > Admittedly, I've never worked with in-kernel overlays, but AFAIK
> > they work with some subsystems.
> >
> > -michael
>
>
> So let me 1st go over 3 cases that the driver needs to support:
>
> 1. Non EEPROM boards:
>
> Using overlays should be pretty similar to current solution. If the=20
> manifest is converted to overlay in userspace, then we do not even need=
=20
> to do manifest parsing, setting up spi, i2c etc in the kernel driver.
>
>
> 2. EEPROM boards
>
> How do you propose handling these. If you are proposing storing dt=20
> overlay in EEPROM, then this raises some questions regarding support=20
> outside of Linux.
>
> The other option would be generating overlay from manifest in the kernel=
=20
> driver, which I'm not sure is significantly better than registering the=
=20
> i2c, spi, etc. interfaces separately using standard kernel APIs.

You did answer that yourself in (1): you could use a user space
helper to translate it to a DT overlay, I don't think this has to be
done in the kernel. Also how do you know whether there is an EEPROM
or not?

> 3. Over Greybus
>
> It is quite important to have mikroBUS over greybus for BeagleConnect.=20
> This is one of the major reasons why greybus manifest was chosen for the=
=20
> manifest format.
>
> Also, it is important to note that mikroBUS manifest is being used since=
=20
> 2020 now and thus manifests for a lot of boards (both supporting clickID=
=20
> and not supporting it exist). So I would prefer using it, unless of=20
> course there are strong reasons not to.

And also here, I'm not really familiar with greybus. Could you give
a more complex example? My concern is that some driver might need
additional properties from DT (or software nodes) to function
properly. It might not only be a node with a compatible string but
also more advanced bindings. How would that play together with this?
My gut feeling is that you can handle any missing properties
easier/better (eg. for existing modules) in user space. But maybe
that is already solved in/with greybus?

Here's a random one: the manifest [1] just lists the compatible
string apparently, but the actual DT binding has also reset-gpios,
some -supply and interrupt properties.

-michael

[1] https://github.com/MikroElektronika/click_id/blob/main/manifests/WEATHE=
R-CLICK.mnfs

--c332393a90d01da165088274218ef3aba6b575ac7f9169419f630293fb78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZfmAQRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvssqgEA04NYkPfPrSqNNIGZGNCkWoEFhm0cSpD1
0kMsQQMcLz8BAMO9O7XV3ER/VGUaI2mQh9OOZ4XJDT0M2vanXUGYPBMA
=d2XY
-----END PGP SIGNATURE-----

--c332393a90d01da165088274218ef3aba6b575ac7f9169419f630293fb78--

