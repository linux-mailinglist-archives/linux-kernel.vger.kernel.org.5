Return-Path: <linux-kernel+bounces-90916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF7E8706BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406DA1C2248E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5D4AECA;
	Mon,  4 Mar 2024 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJvKJ2jz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECFA4AED4;
	Mon,  4 Mar 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568957; cv=none; b=pzRfYJnsIy2Q6TKbNnwgUuxsWcV8UFpjCmOaULuxohGLoXuNIZx9Ecy3X5XCPJZeewRXLoMUtVhmKIkakcKBQwwAjs2wAhmm4kmRI5fnkH9ZHrI5Fg5kDPkhl7MNfqoF1antotittuaRRs/mlXshr5wmXE0q+bw15hZTIrJSEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568957; c=relaxed/simple;
	bh=5UjUBHQcbiA7fW0QY/jq4aDeSZ3PgJ6ZY2uuh+R3gIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwvHaFEj8JgwEKCOcPZeSgMB+DiMPKlaJWMDFIsHQRqSAlu7e7eqw6VgsbIk3ekzw/igoeRDBDIylnBIUrSkLWV6LJDmh1lIr2AGnYmK0w64+mhETXTfgVvGyKrzMiAjkkw/3WnkYpKeIrm3mtv9RUunzthhGnH5Ec02vXtnIsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJvKJ2jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9BCC433C7;
	Mon,  4 Mar 2024 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709568956;
	bh=5UjUBHQcbiA7fW0QY/jq4aDeSZ3PgJ6ZY2uuh+R3gIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJvKJ2jz657aI/dArKolO9jKBpef5omnFl+tyfudMjVk6f7AL2CM+UzGuzfNfQ45n
	 13V0nIWLWY7hC7hhWvmmYFfosJZ5J6PUspBj5XIQeAOUDvpodectdCJD2B8XrwWlU0
	 P5xhZIONHSOmBoFmMeh7xuQuI8T072DEJrV6bpD+dLVXZp74NA/g1SWZ6+RxOBo8kb
	 PNvNJeZvTcUfOW518kOm+TeLAbxiH3UlnnU3UO04O4oHWN2vFmJC0O0Ov/T4reS8F1
	 6wAfDj97gId/z9cQP1GrViIv/oeYqssQZO8nbwSPJq6xgTzIyEATZ3+sUvYt1Ia8cV
	 C+EX6pYJBeA4A==
Date: Mon, 4 Mar 2024 17:15:52 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <ZeXzuWVmC9AnsECt@debian>
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ux3VpOsCkBw0zK1k"
Content-Disposition: inline
In-Reply-To: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>


--ux3VpOsCkBw0zK1k
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 Mar 2024 17:15:52 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options

Hi Oliver,

On Sat, Mar 02, 2024 at 01:19:42PM -0500, Oliver Crumrine wrote:
> It was not made clear in several socket options that they were not
> supported by SOCK_STREAM; this patch fixes that.
>=20
> Socket options not supported by SOCK_STREAM are handled in the
> ip_cmsg_recv_offset function in net/ipv4/ip_sockglue.c. The function is
> called for udp sockets, and indirectly by ping and raw sockets, but not
> for TCP sockets, as they don't support these options.
>=20
> Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>

Could you write some small example programs demonstrating that these are
not supported?  I'd like to check it with a small program, if possible.

Have a lovely say!
Alex

> ---
>  man7/ip.7 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/man7/ip.7 b/man7/ip.7
> index 2b4b06324..104e65feb 100644
> --- a/man7/ip.7
> +++ b/man7/ip.7
> @@ -828,6 +828,9 @@ is not zero, the primary local address of the interfa=
ce specified by the
>  index overwrites
>  .I ipi_spec_dst
>  for the routing table lookup.
> +Not supported for
> +.B SOCK_STREAM
> +sockets.
>  .TP
>  .BR IP_RECVERR " (since Linux 2.2)"
>  .\" Precisely: since Linux 2.1.15
> @@ -989,6 +992,9 @@ in which the kernel returns the original destination =
address
>  of the datagram being received.
>  The ancillary message contains a
>  .IR "struct sockaddr_in" .
> +Not supported for
> +.B SOCK_STREAM
> +sockets.
>  .TP
>  .BR IP_RECVTOS " (since Linux 2.2)"
>  .\" Precisely: since Linux 2.1.68
> @@ -998,6 +1004,9 @@ ancillary message is passed with incoming packets.
>  It contains a byte which specifies the Type of Service/Precedence
>  field of the packet header.
>  Expects a boolean integer flag.
> +Not supported for
> +.B SOCK_STREAM
> +sockets.
>  .TP
>  .BR IP_RECVTTL " (since Linux 2.2)"
>  .\" Precisely: since Linux 2.1.68
> --=20
> 2.44.0
>=20

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--ux3VpOsCkBw0zK1k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXl87gACgkQnowa+77/
2zJe2Q/3SJ6w3CPhRqqEtV98dUTnuRY47cAGYcQKTUTLUii6nI32EPqc2+jBRIQx
SEUqj/JK1aRQ72wr9cAIaSHV6qu6Xuk2NXtO7+Abur+njoBuQDwq7Az9nspihvnE
txUmwZJqWOewqcpTZdgqWa5AuQbF9ksd12lsAPAO+eU3vJGSFJTCc/dRXrsM5d6r
8d9VEmVIskDJoTWDnt88bpt3ozxWhaFK217VpOiR0L5o/6OTV1Ho4xfUOujRnysf
AKqT1L95b9RhtpmRSaCTAkl7NIDf5UIfEeLKK1gJOBO19w11g0wi9TvICEGMvopH
GuKvdsPvkO6iQp83WUVK7SeYY3c7TcG2sk6A2JJpIvvkc3CzbxibE4X0lBRceqQj
oVkb5xLiQ91qpNlQY2P4Ixo1AvwSJjkFzvnnbOvM6/lYducs425tcBAsNsAwp0a5
xXm7crlvxXmBxsqfmddIGuCMjilLb0sCn0gaCKk9bYVaOTwWLSUsx2H0gdRMVhcH
RthLFZyDJoHNvocwOsgwKBCtMf1wBgRI5be4qlE8X6yTYSl+gF3+3ujevU/8e7bK
k+3VVShtn22ycP23Tj0oU9jyVhx9IUIcP+7xwxEpnQle34FSVl4JNK/faZpZLlAz
Jh9FjkFDfUzsd/w7j6QjC8UZY8/h7J56y86bWzZd7IqQe9jOvQ==
=AgFf
-----END PGP SIGNATURE-----

--ux3VpOsCkBw0zK1k--

