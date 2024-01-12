Return-Path: <linux-kernel+bounces-24918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C4382C4A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D46D1F24C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F45E175B7;
	Fri, 12 Jan 2024 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLSyzMAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06222612;
	Fri, 12 Jan 2024 17:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68526C433C7;
	Fri, 12 Jan 2024 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705080282;
	bh=X9aIgnasVq1ypHKDDLf+2qteQS6RYhO2XgOOTnuWQ50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLSyzMApkgq1DzOQ/6xVeUI4wOXZ1Z6Y1UCqgLE/5psQwLRfxRCvEYZ0Hq2hMoEB6
	 lH2jLkWUcUgB6kaMgCmt7lB1EdoliSJZrvEeiEl1dHf3e9MGVA8KQLgIuyqtHFZysG
	 enZKmO8TkEsGOGwW/YRACj5bE7cdFPbs0R9h0lyJwws+R5a8Oig/iMpqObQssOQXHk
	 8RmfxU7RlI0LwQTUAL8AL+SWOIEwlKQkrM3JfRKwKmC7awmaR8ZW8UfFaK8vAiuH2P
	 jTm45jbyKMA8OYk9r+aSqrnHvBsR8gQM9nB2HVlHsBq5BNuVU3hTc8I2yJv5Ti1EXf
	 sNdTIJFDQLKPA==
Date: Fri, 12 Jan 2024 17:24:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	Joel Stanley <joel@jms.id.au>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 1/1] tpm: tis-i2c: Add more compatible strings
Message-ID: <20240112-unrevised-wafer-649c0ebffda5@spud>
References: <20231214144954.3833998-1-ninad@linux.ibm.com>
 <20231214144954.3833998-2-ninad@linux.ibm.com>
 <20240109-saddling-nintendo-c7fbb46bb0dd@spud>
 <77fe0ccd-53ff-4773-9787-0d038434297f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5Qj7R76LV+2xqmCh"
Content-Disposition: inline
In-Reply-To: <77fe0ccd-53ff-4773-9787-0d038434297f@linux.ibm.com>


--5Qj7R76LV+2xqmCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 10:43:08AM -0600, Ninad Palsule wrote:
> Hello Conor,
>=20
> On 1/9/24 11:11, Conor Dooley wrote:
> > On Thu, Dec 14, 2023 at 08:49:53AM -0600, Ninad Palsule wrote:
> > > From: Joel Stanley <joel@jms.id.au>
> > >=20
> > > The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
> > >=20
> > > https://www.nuvoton.com/products/cloud-computing/security/trusted-pla=
tform-module-tpm/
> > >=20
> > > Add a compatible string for it, and the generic compatible.
> > >=20
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.=
au
> > > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> > I don't understand why you broke this series up and dropped patches.
> > NAK, these compatibles are not documented.
> >=20
> The original series has three patches:
>=20
> 1) Adding compatibility string which I am adding in this series.
>=20
> 2) Adding schema for the TIS I2c devices which is already covered by Luka=
s's
> patch (already merged in linux-next) https://lore.kernel.org/all/3f56f0a2=
bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de/
>=20
> 3) Removing "Infineon,slb9673" from trivial-devices.yaml which is not done
> as it is already added in the TPM specific file. I will add it in my patc=
h.
> Good catch!

Dropping this should be a standalone patch (with a Fixes tag I suppose).

Looking at what got merged:
      - description: Generic TPM 2.0 chips conforming to TCG PTP interface
        items:
          - enum:
              - infineon,slb9673
              - nuvoton,npct75x
          - const: tcg,tpm-tis-i2c

There's no need to add "nuvoton,npct75x" to this driver, since a
fallback to tcg,tpm-tis-i2c is required by the binding. Adding the
generic compatible however makes sense.

If there's a good reason to add it (like existing QEMU releases that do
not have the generic compatible, but claim to have the npct75x) then
please note why we should make an exception in your commit message.

You need not carry the NAK, the motivation behind patch is fine.

Thanks,
Conor.

--5Qj7R76LV+2xqmCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaF11gAKCRB4tDGHoIJi
0oZjAP9cSm6dL8yxX6MY+K9Mp7w5I9vyiWifxFTd3DFY1N+KmQD7BHbpqKGn/WSc
/8WU0cPvQfINzbW93T1Avxc1wvV8Bgo=
=QpGa
-----END PGP SIGNATURE-----

--5Qj7R76LV+2xqmCh--

