Return-Path: <linux-kernel+bounces-106665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EF387F1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3572A1C20F65
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420FA5821B;
	Mon, 18 Mar 2024 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIVre6YP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C56250EC;
	Mon, 18 Mar 2024 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795937; cv=none; b=EipgtgHj4peVC6sgnV3ygnc/g6/wfDH2iT37ZRPnWNSKINhdWuiOoMjziyGKVUmQE0jfgowsqV6yv79IBmEDT9z6IVCpURK6hSmWrYxf9Na3sZSFHU0l6+eEYoXsbxXUC5JhbR5hzRXF7Duplyd0zr8KCn12TSo5yBehBHzSGeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795937; c=relaxed/simple;
	bh=VljmY+vHdIOew+g8Bg8csDq2nwbCNbkexDBBoVLITuA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=t6KNSCiAhQbaeSXJlP3LCKHbwifmTxo25SslasJyc7K1LDNNr6o9jFn09ioQ5ikTRb6F29naAYv9wyKriNxkFgx3Kt9XOzJDY7Kpt9X4sTdqfvXk3nu28hFwc/1pHmXFYKR+WFx0D/i3gGhzqs+hO262jwEKahlIQsyDXJXDLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIVre6YP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D0BC433C7;
	Mon, 18 Mar 2024 21:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710795937;
	bh=VljmY+vHdIOew+g8Bg8csDq2nwbCNbkexDBBoVLITuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIVre6YP9imiMoL68Tjwxj9EMs9ej4+KrtplW7c4uo75GsfQBF/Bib8dh+Scv1Bcr
	 eZsPiiJjd7r9lflwvjJNkbcre0/IoAwWVZvFjA/EHXuAxnoLbai692OCJBUVq+UD1D
	 /CLBTiE5gs+myaREnmx+ITgSKBusd/oPP//x7qc1VMPQjMzsvCEAz9TmwCfujErN8X
	 EvnuY7caWw5VoswIVs+B82ugcuCWojLQhb8JGF38jJFFYq+TOoL7lnU84O6WO2XWiB
	 VBQQLxNT7pNE+9VgwyAtOdtQ/s9JFI4OWMhTd+ErhiJks7vW29n4Ol9oQijQkJtbI5
	 00ik1Bq1Bo7vw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 23:05:33 +0200
Message-Id: <CZX6JM30P6FG.138133OLNGMS2@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 08/13] crypto: ecc - Add NIST P521 curve parameters
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-9-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-9-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Add the parameters for the NIST P521 curve and define a new curve ID
> for it. Make the curve available in ecc_get_curve.

This is rare example of "complete story" in this series despite being
short, so no complains :-)

>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecc.c            |  2 ++
>  crypto/ecc_curve_defs.h | 45 +++++++++++++++++++++++++++++++++++++++++
>  include/crypto/ecdh.h   |  1 +
>  3 files changed, 48 insertions(+)
>
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index ead40b5ebb46..4f6fa8617308 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -60,6 +60,8 @@ const struct ecc_curve *ecc_get_curve(unsigned int curv=
e_id)
>  		return &nist_p256;
>  	case ECC_CURVE_NIST_P384:
>  		return &nist_p384;
> +	case ECC_CURVE_NIST_P521:
> +		return &nist_p521;
>  	default:
>  		return NULL;
>  	}
> diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
> index ab1ef3d94be5..0ecade7d02f5 100644
> --- a/crypto/ecc_curve_defs.h
> +++ b/crypto/ecc_curve_defs.h
> @@ -89,6 +89,51 @@ static struct ecc_curve nist_p384 =3D {
>  	.b =3D nist_p384_b
>  };
> =20
> +/* NIST P-521 */
> +static u64 nist_p521_g_x[] =3D { 0xf97e7e31c2e5bd66ull, 0x3348b3c1856a42=
9bull,
> +				0xfe1dc127a2ffa8deull, 0xa14b5e77efe75928ull,
> +				0xf828af606b4d3dbaull, 0x9c648139053fb521ull,
> +				0x9e3ecb662395b442ull, 0x858e06b70404e9cdull,
> +				0xc6ull };
> +static u64 nist_p521_g_y[] =3D { 0x88be94769fd16650ull, 0x353c7086a272c2=
40ull,
> +				0xc550b9013fad0761ull, 0x97ee72995ef42640ull,
> +				0x17afbd17273e662cull, 0x98f54449579b4468ull,
> +				0x5c8a5fb42c7d1bd9ull, 0x39296a789a3bc004ull,
> +				0x118ull };
> +static u64 nist_p521_p[] =3D { 0xffffffffffffffffull, 0xffffffffffffffff=
ull,
> +				0xffffffffffffffffull, 0xffffffffffffffffull,
> +				0xffffffffffffffffull, 0xffffffffffffffffull,
> +				0xffffffffffffffffull, 0xffffffffffffffffull,
> +				0x1ffull };
> +static u64 nist_p521_n[] =3D { 0xbb6fb71e91386409ull, 0x3bb5c9b8899c47ae=
ull,
> +				0x7fcc0148f709a5d0ull, 0x51868783bf2f966bull,
> +				0xfffffffffffffffaull, 0xffffffffffffffffull,
> +				0xffffffffffffffffull, 0xffffffffffffffffull,
> +				0x1ffull };
> +static u64 nist_p521_a[] =3D { 0xfffffffffffffffcull, 0xffffffffffffffff=
ull,
> +				0xffffffffffffffffull, 0xffffffffffffffffull,
> +				0xffffffffffffffffull, 0xffffffffffffffffull,
> +				0xffffffffffffffffull, 0xffffffffffffffffull,
> +				0x1ffull };
> +static u64 nist_p521_b[] =3D { 0xef451fd46b503f00ull, 0x3573df883d2c34f1=
ull,
> +				0x1652c0bd3bb1bf07ull, 0x56193951ec7e937bull,
> +				0xb8b489918ef109e1ull, 0xa2da725b99b315f3ull,
> +				0x929a21a0b68540eeull, 0x953eb9618e1c9a1full,
> +				0x051ull };
> +static struct ecc_curve nist_p521 =3D {
> +	.name =3D "nist_521",
> +	.nbits =3D 521,
> +	.g =3D {
> +		.x =3D nist_p521_g_x,
> +		.y =3D nist_p521_g_y,
> +		.ndigits =3D 9,
> +	},
> +	.p =3D nist_p521_p,
> +	.n =3D nist_p521_n,
> +	.a =3D nist_p521_a,
> +	.b =3D nist_p521_b
> +};
> +
>  /* curve25519 */
>  static u64 curve25519_g_x[] =3D { 0x0000000000000009, 0x0000000000000000=
,
>  				0x0000000000000000, 0x0000000000000000 };
> diff --git a/include/crypto/ecdh.h b/include/crypto/ecdh.h
> index a9f98078d29c..9784ecdd2fb4 100644
> --- a/include/crypto/ecdh.h
> +++ b/include/crypto/ecdh.h
> @@ -26,6 +26,7 @@
>  #define ECC_CURVE_NIST_P192	0x0001
>  #define ECC_CURVE_NIST_P256	0x0002
>  #define ECC_CURVE_NIST_P384	0x0003
> +#define ECC_CURVE_NIST_P521	0x0004
> =20
>  /**
>   * struct ecdh - define an ECDH private key


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

