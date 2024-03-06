Return-Path: <linux-kernel+bounces-93823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2EF873533
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0970A28BA3D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788C460B84;
	Wed,  6 Mar 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXbW1vYN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94263A262;
	Wed,  6 Mar 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722716; cv=none; b=tbbDuuhJ/UhUkQLyvj9Cz0UaKfrOPbCMsASY+lR8iF0yZN84mvwcU3fFIgo0DHfv2jPp9Dki7JxiRaoPgtpNsYzDCktvtPjJmQPDJrdFOkEvGFHxy+T67SIro0lFf3+L/QZ8nvowtEnCZKT8PvDTYKooBrigyuarvCnwSigd49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722716; c=relaxed/simple;
	bh=54s2DjrDdCI7US7oHXkWWWhCfQrI4Vrohb9IHY8B5/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/pkYrdhzSnnSETdbv1aI3i8pxDtfB0ha0vVKXVA3g/JLoLt9+zwAcI6x6l4QjupUB6U4BkscnT9efg/vajp3VGOwPoQPj4EYZ2fvVI2O7yunmrk1TDWxoeI4IHhHhCn6sFoFzr96k8clOsR1YK/8S6w8Qws6xVK2p6//8frqXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXbW1vYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8820CC433C7;
	Wed,  6 Mar 2024 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722716;
	bh=54s2DjrDdCI7US7oHXkWWWhCfQrI4Vrohb9IHY8B5/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXbW1vYNG9Z12VkEy7Xav1MM+Gp+xVRLoLqVJOK6HfmlnDcACeD3KLR/1TPKMyaKb
	 pXmOVhOyY2GfTfpwvsYtl+8pdGCoIbO7j0d5k7ieVDtkhwQjkyUc5Blg+C2fC+PO68
	 zYEttzgUL/PteFCoalotN3BFLOK58A2gz+Kb61BzUKuqYGUOUCGVwAvj9JqWaH2O92
	 B/8eHqYRyqHqohvMIKMZpZxYSdDrNs/Wz8hIJJPwZIceJIZkha7vQsTzjdLlOQ8na5
	 PNx/JMf8RXeEb1gVJf1ZRyIh49KW9bNFBu67iqZDMlC2ojO+SQ7wjl93mX/PDq1tkv
	 +k8pvTa+yJpAw==
Date: Wed, 6 Mar 2024 11:58:32 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <ZehMWQ0LkemsTHAC@debian>
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
 <ZeXzuWVmC9AnsECt@debian>
 <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2l9L6u35RRDmYlsD"
Content-Disposition: inline
In-Reply-To: <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>


--2l9L6u35RRDmYlsD
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 6 Mar 2024 11:58:32 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options

Hi Oliver,

On Tue, Mar 05, 2024 at 02:31:48PM -0500, Oliver Crumrine wrote:
> Hi Alex,
> I have attached two programs in the form of C source code below. No
> special compilation options required. To change between the three
> different socket options outlined in my patch, there are two options on
> line 16 and 18 with a comment above them explaining how to use the
> fields.
>=20
> Here's how to use the programs:
> 0. Make sure you have netcat installed.
> 1. Compile the dgram one.
> 2. Run it.
> 3. Run nc localhost 8888 -u (in a seperate terminal window or tab)
> 4. Type whatever into netcat and press enter
> 5. Observe that there is a control message recieved, and there is a byte
> printed, which is the first byte of the data in the control message.

Can't reproduce this.  The terminal running nc(1) isn't printing
anything.

alx@debian:~$ which nc
/usr/bin/nc
alx@debian:~$ which nc | xargs realpath
/usr/bin/nc.openbsd
alx@debian:~$ dpkg -S /bin/nc.openbsd
netcat-openbsd: /bin/nc.openbsd

> 6. You may repeat this for the three different socket options.
> 7. Repeat for the stream one, but use nc localhost 8888 (without the -u)
> for #5.
> 8. Observe that there are no control messages recieved with the stream on=
e,
> and byte is 00, which is the initial value of the variable, before it has
> a value assigned when the control messages (of which there are none) are =
read.
>=20
> Thanks,
> Oliver

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--2l9L6u35RRDmYlsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXoTFgACgkQnowa+77/
2zLA3w//Wb7uRoWE1TV+WmMQ2qhh3r9jVVsJ3OEZ3N1P6bRXT15V5Zeew7CoN08d
nckxUcFwGwDXDsw/pAwwCjDWjgT91m9VWaheWRAQvT50Gv5AIZc2B9anMMuHNieD
e/kBXzqIVaoUyT+cuXhn0ad0MPdKStp9MvNPSE69rLyFVKlmS5/t7opFEKqSWbnQ
HZTA3RjNrl90STwT02h9GTtQtAb2Ni3KTEL4TN5fy5OSgYeqDAgzIazAn4jYhRLy
9q6GcP744iKPbqU2Rastds6epO2vlq4s6D8uSP+BBnJ3TTEd/+A973iOZVoRQis7
IX2A24AGYH4tq1mZ65/RVcd4eI1wcLU/J5fewwzQViMZFufF1y3Hc2oPyy8H4Ojj
MZySW7uPIJMd0hKQT1gFj+U97V9PLkyI+zfIetbBh0bGbEb+GogGEC5nsnMyzkbG
1aE+l5C2rj1D7MrksNpZyIsSY965i/TQy04lVyB6W+t5mqyeBp9FsfiloL0vMXJu
IqsmOaoVAWMO+PpxThg2m/8PiidKRojT9GlHxP8Shn3FPlUpG2CkwFLZFvPulwvG
90KUrr7fxeDa30RPdVMm8B+BNfdoXYSFHc3VLigD3arCrjUrasyhgPMHb4mHVsUd
1hpXdeGxHlQiF8bwvvDpxKLEv2v0lWVRTomWK93NEYVLtKk218w=
=UkIi
-----END PGP SIGNATURE-----

--2l9L6u35RRDmYlsD--

