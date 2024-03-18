Return-Path: <linux-kernel+bounces-106670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3027C87F1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC2E1F223B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4C158224;
	Mon, 18 Mar 2024 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqIPWlCp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63905811A;
	Mon, 18 Mar 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796111; cv=none; b=bpTjks8Ekb9LP5fK3oxQTWj9FQTcXTPSQWzChXQNpEOsbKA34nk4Q0AOi/YWsLQEH4Pac/Czm1fKcagb+qNKAbO4GvpVuWOHUdvvzzr3DeJs03I4mMzWE5DAMPWwvbEeVgawXUAUAD7HeZ1kLPlyQrEYxUBrTp736UjslUCeXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796111; c=relaxed/simple;
	bh=mV5MyCSs3JJ9buBIDLzCKARQjBbMnmcwq3P7njjAWyg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qjS0GbRPCYuMpLcYgKXJSi2s83DohxCFcAfze3ZAKY108pY2NeHXO7Pt2FOqIUj/wjgl4vUYDMd3Y/yH5apXORAFa9zVxZ32KXfSS+yrHjIWKuUow8aG7zSnxpUyv4uOKQd+h8MpOkslcoFRQtBmfiC0fJUtlbh/GviI1V3UBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqIPWlCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BA0C433C7;
	Mon, 18 Mar 2024 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710796111;
	bh=mV5MyCSs3JJ9buBIDLzCKARQjBbMnmcwq3P7njjAWyg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jqIPWlCp/BiXeDNYAuAIFWGTZWj1JNFJKaANZuaRKYPNM1NundQbWY6qFPYHhOD7f
	 Cg5WCW52y29d3gR8UdoXcSSJFobAdSTClwKMmpQbBuX9wPzxCz9IceIGYC4A/8XUen
	 9Ro2gYeeq+YBHY7QQR3KhTxIoQFShnfKH9fV2MhWYsScvaWlV4MH6Zat3ZF3XWRbPa
	 oJ8mNif8bNmlLjeFDLPSdCEPMhhZTFodMWkUEUjx5mOuOMh556pgYxXt5HKabTKQDS
	 pQEmlexxLxR+UDwAMBg4lnauMpTfI7S6TI1J3sdBm68pCbN9KgvCzNzDqaMci/zCXn
	 TpIlB6DieV1Ew==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 23:08:28 +0200
Message-Id: <CZX6LU6VWC48.1FA08R7TZJMRM@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 11/13] crypto: ecdsa - Register NIST P521 and extend
 test suite
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-12-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-12-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Register NIST P521 as an akcipher and extend the testmgr with
> NIST P521-specific test vectors.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecdsa.c   |  30 ++++++++++
>  crypto/testmgr.c |   7 +++
>  crypto/testmgr.h | 146 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 183 insertions(+)
>
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index 4e847b59622a..894599f1885f 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -269,6 +269,28 @@ static unsigned int ecdsa_max_size(struct crypto_akc=
ipher *tfm)
>  	return DIV_ROUND_UP(ctx->curve->nbits, 8);
>  }
> =20
> +static int ecdsa_nist_p521_init_tfm(struct crypto_akcipher *tfm)
> +{
> +	struct ecc_ctx *ctx =3D akcipher_tfm_ctx(tfm);
> +
> +	return ecdsa_ecc_ctx_init(ctx, ECC_CURVE_NIST_P521);
> +}
> +
> +static struct akcipher_alg ecdsa_nist_p521 =3D {
> +	.verify =3D ecdsa_verify,
> +	.set_pub_key =3D ecdsa_set_pub_key,
> +	.max_size =3D ecdsa_max_size,
> +	.init =3D ecdsa_nist_p521_init_tfm,
> +	.exit =3D ecdsa_exit_tfm,
> +	.base =3D {
> +		.cra_name =3D "ecdsa-nist-p521",
> +		.cra_driver_name =3D "ecdsa-nist-p521-generic",
> +		.cra_priority =3D 100,
> +		.cra_module =3D THIS_MODULE,
> +		.cra_ctxsize =3D sizeof(struct ecc_ctx),
> +	},
> +};
> +
>  static int ecdsa_nist_p384_init_tfm(struct crypto_akcipher *tfm)
>  {
>  	struct ecc_ctx *ctx =3D akcipher_tfm_ctx(tfm);
> @@ -352,8 +374,15 @@ static int __init ecdsa_init(void)
>  	if (ret)
>  		goto nist_p384_error;
> =20
> +	ret =3D crypto_register_akcipher(&ecdsa_nist_p521);
> +	if (ret)
> +		goto nist_p521_error;
> +
>  	return 0;
> =20
> +nist_p521_error:
> +	crypto_unregister_akcipher(&ecdsa_nist_p384);
> +
>  nist_p384_error:
>  	crypto_unregister_akcipher(&ecdsa_nist_p256);
> =20
> @@ -369,6 +398,7 @@ static void __exit ecdsa_exit(void)
>  		crypto_unregister_akcipher(&ecdsa_nist_p192);
>  	crypto_unregister_akcipher(&ecdsa_nist_p256);
>  	crypto_unregister_akcipher(&ecdsa_nist_p384);
> +	crypto_unregister_akcipher(&ecdsa_nist_p521);
>  }
> =20
>  subsys_initcall(ecdsa_init);
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index c26aeda85787..a017b4ad119b 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -5097,6 +5097,13 @@ static const struct alg_test_desc alg_test_descs[]=
 =3D {
>  		.suite =3D {
>  			.akcipher =3D __VECS(ecdsa_nist_p384_tv_template)
>  		}
> +	}, {
> +		.alg =3D "ecdsa-nist-p521",
> +		.test =3D alg_test_akcipher,
> +		.fips_allowed =3D 1,
> +		.suite =3D {
> +			.akcipher =3D __VECS(ecdsa_nist_p521_tv_template)
> +		}
>  	}, {
>  		.alg =3D "ecrdsa",
>  		.test =3D alg_test_akcipher,
> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
> index 986f331a5fc2..9bde04be8df9 100644
> --- a/crypto/testmgr.h
> +++ b/crypto/testmgr.h
> @@ -991,6 +991,152 @@ static const struct akcipher_testvec ecdsa_nist_p38=
4_tv_template[] =3D {
>  	},
>  };
> =20
> +static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] =3D {
> +	{
> +	.key =3D /* secp521r1(sha224) */
> +	"\x04\x01\x4f\x43\x18\xb6\xa9\xc9\x5d\x68\xd3\xa9\x42\xf8\x98\xc0"
> +	"\xd2\xd1\xa9\x50\x3b\xe8\xc4\x40\xe6\x11\x78\x88\x4b\xbd\x76\xa7"
> +	"\x9a\xe0\xdd\x31\xa4\x67\x78\x45\x33\x9e\x8c\xd1\xc7\x44\xac\x61"
> +	"\x68\xc8\x04\xe7\x5c\x79\xb1\xf1\x41\x0c\x71\xc0\x53\xa8\xbc\xfb"
> +	"\xf5\xca\xd4\x01\x40\xfd\xa3\x45\xda\x08\xe0\xb4\xcb\x28\x3b\x0a"
> +	"\x02\x35\x5f\x02\x9f\x3f\xcd\xef\x08\x22\x40\x97\x74\x65\xb7\x76"
> +	"\x85\xc7\xc0\x5c\xfb\x81\xe1\xa5\xde\x0c\x4e\x8b\x12\x31\xb6\x47"
> +	"\xed\x37\x0f\x99\x3f\x26\xba\xa3\x8e\xff\x79\x34\x7c\x3a\xfe\x1f"
> +	"\x3b\x83\x82\x2f\x14",
> +	.key_len =3D 133,
> +	.params =3D
> +	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> +	"\x00\x23",
> +	.param_len =3D 18,
> +	.m =3D
> +	"\xa2\x3a\x6a\x8c\x7b\x3c\xf2\x51\xf8\xbe\x5f\x4f\x3b\x15\x05\xc4"
> +	"\xb5\xbc\x19\xe7\x21\x85\xe9\x23\x06\x33\x62\xfb",
> +	.m_size =3D 28,
> +	.algo =3D OID_id_ecdsa_with_sha224,
> +	.c =3D
> +	"\x30\x81\x86\x02\x41\x01\xd6\x43\xe7\xff\x42\xb2\xba\x74\x35\xf6"
> +	"\xdc\x6d\x02\x7b\x22\xac\xe2\xef\x07\x92\xee\x60\x94\x06\xf8\x3f"
> +	"\x59\x0f\x74\xf0\x3f\xd8\x18\xc6\x37\x8a\xcb\xa7\xd8\x7d\x98\x85"
> +	"\x29\x88\xff\x0b\x94\x94\x6c\xa6\x9b\x89\x8b\x1e\xfd\x09\x46\x6b"
> +	"\xc7\xaf\x7a\xb9\x19\x0a\x02\x41\x3a\x26\x0d\x55\xcd\x23\x1e\x7d"
> +	"\xa0\x5e\xf9\x88\xf3\xd2\x32\x90\x57\x0f\xf8\x65\x97\x6b\x09\x4d"
> +	"\x22\x26\x0b\x5f\x49\x32\x6b\x91\x99\x30\x90\x0f\x1c\x8f\x78\xd3"
> +	"\x9f\x0e\x64\xcc\xc4\xe8\x43\xd9\x0e\x1c\xad\x22\xda\x82\x00\x35"
> +	"\xa3\x50\xb1\xa5\x98\x92\x2a\xa5\x52",
> +	.c_size =3D 137,
> +	.public_key_vec =3D true,
> +	.siggen_sigver_test =3D true,
> +	},
> +	{
> +	.key =3D /* secp521r1(sha256) */
> +	"\x04\x01\x05\x3a\x6b\x3b\x5a\x0f\xa7\xb9\xb7\x32\x53\x4e\xe2\xae"
> +	"\x0a\x52\xc5\xda\xdd\x5a\x79\x1c\x30\x2d\x33\x07\x79\xd5\x70\x14"
> +	"\x61\x0c\xec\x26\x4d\xd8\x35\x57\x04\x1d\x88\x33\x4d\xce\x05\x36"
> +	"\xa5\xaf\x56\x84\xfa\x0b\x9e\xff\x7b\x30\x4b\x92\x1d\x06\xf8\x81"
> +	"\x24\x1e\x51\x00\x09\x21\x51\xf7\x46\x0a\x77\xdb\xb5\x0c\xe7\x9c"
> +	"\xff\x27\x3c\x02\x71\xd7\x85\x36\xf1\xaa\x11\x59\xd8\xb8\xdc\x09"
> +	"\xdc\x6d\x5a\x6f\x63\x07\x6c\xe1\xe5\x4d\x6e\x0f\x6e\xfb\x7c\x05"
> +	"\x8a\xe9\x53\xa8\xcf\xce\x43\x0e\x82\x20\x86\xbc\x88\x9c\xb7\xe3"
> +	"\xe6\x77\x1e\x1f\x8a",
> +	.key_len =3D 133,
> +	.params =3D
> +	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> +	"\x00\x23",
> +	.param_len =3D 18,
> +	.m =3D
> +	"\xcc\x97\x73\x0c\x73\xa2\x53\x2b\xfa\xd7\x83\x1d\x0c\x72\x1b\x39"
> +	"\x80\x71\x8d\xdd\xc5\x9b\xff\x55\x32\x98\x25\xa2\x58\x2e\xb7\x73",
> +	.m_size =3D 32,
> +	.algo =3D OID_id_ecdsa_with_sha256,
> +	.c =3D
> +	"\x30\x81\x88\x02\x42\x00\xcd\xa5\x5f\x57\x52\x27\x78\x3a\xb5\x06"
> +	"\x0f\xfd\x83\xfc\x0e\xd9\xce\x50\x9f\x7d\x1f\xca\x8b\xa8\x2d\x56"
> +	"\x3c\xf6\xf0\xd8\xe1\xb7\x5d\x95\x35\x6f\x02\x0e\xaf\xe1\x4c\xae"
> +	"\xce\x54\x76\x9a\xc2\x8f\xb8\x38\x1f\x46\x0b\x04\x64\x34\x79\xde"
> +	"\x7e\xd7\x59\x10\xe9\xd9\xd5\x02\x42\x01\xcf\x50\x85\x38\xf9\x15"
> +	"\x83\x18\x04\x6b\x35\xae\x65\xb5\x99\x12\x0a\xa9\x79\x24\xb9\x37"
> +	"\x35\xdd\xa0\xe0\x87\x2c\x44\x4b\x5a\xee\xaf\xfa\x10\xdd\x9b\xfb"
> +	"\x36\x1a\x31\x03\x42\x02\x5f\x50\xf0\xa2\x0d\x1c\x57\x56\x8f\x12"
> +	"\xb7\x1d\x91\x55\x38\xb6\xf6\x34\x65\xc7\xbd",
> +	.c_size =3D 139,
> +	.public_key_vec =3D true,
> +	.siggen_sigver_test =3D true,
> +	},
> +	{
> +	.key =3D /* secp521r1(sha384) */
> +	"\x04\x00\x2e\xd6\x21\x04\x75\xc3\xdc\x7d\xff\x0e\xf3\x70\x25\x2b"
> +	"\xad\x72\xfc\x5a\x91\xf1\xd5\x9c\x64\xf3\x1f\x47\x11\x10\x62\x33"
> +	"\xfd\x2e\xe8\x32\xca\x9e\x6f\x0a\x4c\x5b\x35\x9a\x46\xc5\xe7\xd4"
> +	"\x38\xda\xb2\xf0\xf4\x87\xf3\x86\xf4\xea\x70\xad\x1e\xd4\x78\x8c"
> +	"\x36\x18\x17\x00\xa2\xa0\x34\x1b\x2e\x6a\xdf\x06\xd6\x99\x2d\x47"
> +	"\x50\x92\x1a\x8a\x72\x9c\x23\x44\xfa\xa7\xa9\xed\xa6\xef\x26\x14"
> +	"\xb3\x9d\xfe\x5e\xa3\x8c\xd8\x29\xf8\xdf\xad\xa6\xab\xfc\xdd\x46"
> +	"\x22\x6e\xd7\x35\xc7\x23\xb7\x13\xae\xb6\x34\xff\xd7\x80\xe5\x39"
> +	"\xb3\x3b\x5b\x1b\x94",
> +	.key_len =3D 133,
> +	.params =3D
> +	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> +	"\x00\x23",
> +	.param_len =3D 18,
> +	.m =3D
> +	"\x36\x98\xd6\x82\xfa\xad\xed\x3c\xb9\x40\xb6\x4d\x9e\xb7\x04\x26"
> +	"\xad\x72\x34\x44\xd2\x81\xb4\x9b\xbe\x01\x04\x7a\xd8\x50\xf8\x59"
> +	"\xba\xad\x23\x85\x6b\x59\xbe\xfb\xf6\x86\xd4\x67\xa8\x43\x28\x76",
> +	.m_size =3D 48,
> +	.algo =3D OID_id_ecdsa_with_sha384,
> +	.c =3D
> +	"\x30\x81\x88\x02\x42\x00\x93\x96\x76\x3c\x27\xea\xaa\x9c\x26\xec"
> +	"\x51\xdc\xe8\x35\x5e\xae\x16\xf2\x4b\x64\x98\xf7\xec\xda\xc7\x7e"
> +	"\x42\x71\x86\x57\x2d\xf1\x7d\xe4\xdf\x9b\x7d\x9e\x47\xca\x33\x32"
> +	"\x76\x06\xd0\xf9\xc0\xe4\xe6\x84\x59\xfd\x1a\xc4\x40\xdd\x43\xb8"
> +	"\x6a\xdd\xfb\xe6\x63\x4e\x28\x02\x42\x00\xff\xc3\x6a\x87\x6e\xb5"
> +	"\x13\x1f\x20\x55\xce\x37\x97\xc9\x05\x51\xe5\xe4\x3c\xbc\x93\x65"
> +	"\x57\x1c\x30\xda\xa7\xcd\x26\x28\x76\x3b\x52\xdf\xc4\xc0\xdb\x54"
> +	"\xdb\x8a\x0d\x6a\xc3\xf3\x7a\xd1\xfa\xe7\xa7\xe5\x5a\x94\x56\xcf"
> +	"\x8f\xb4\x22\xc6\x4f\xab\x2b\x62\xc1\x42\xb1",
> +	.c_size =3D 139,
> +	.public_key_vec =3D true,
> +	.siggen_sigver_test =3D true,
> +	},
> +	{
> +	.key =3D /* secp521r1(sha512) */
> +	"\x04\x00\xc7\x65\xee\x0b\x86\x7d\x8f\x02\xf1\x74\x5b\xb0\x4c\x3f"
> +	"\xa6\x35\x60\x9f\x55\x23\x11\xcc\xdf\xb8\x42\x99\xee\x6c\x96\x6a"
> +	"\x27\xa2\x56\xb2\x2b\x03\xad\x0f\xe7\x97\xde\x09\x5d\xb4\xc5\x5f"
> +	"\xbd\x87\x37\xbf\x5a\x16\x35\x56\x08\xfd\x6f\x06\x1a\x1c\x84\xee"
> +	"\xc3\x64\xb3\x00\x9e\xbd\x6e\x60\x76\xee\x69\xfd\x3a\xb8\xcd\x7e"
> +	"\x91\x68\x53\x57\x44\x13\x2e\x77\x09\x2a\xbe\x48\xbd\x91\xd8\xf6"
> +	"\x21\x16\x53\x99\xd5\xf0\x40\xad\xa6\xf8\x58\x26\xb6\x9a\xf8\x77"
> +	"\xfe\x3a\x05\x1a\xdb\xa9\x0f\xc0\x6c\x76\x30\x8c\xd8\xde\x44\xae"
> +	"\xd0\x17\xdf\x49\x6a",
> +	.key_len =3D 133,
> +	.params =3D
> +	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> +	"\x00\x23",
> +	.param_len =3D 18,
> +	.m =3D
> +	"\x5c\xa6\xbc\x79\xb8\xa0\x1e\x11\x83\xf7\xe9\x05\xdf\xba\xf7\x69"
> +	"\x97\x22\x32\xe4\x94\x7c\x65\xbd\x74\xc6\x9a\x8b\xbd\x0d\xdc\xed"
> +	"\xf5\x9c\xeb\xe1\xc5\x68\x40\xf2\xc7\x04\xde\x9e\x0d\x76\xc5\xa3"
> +	"\xf9\x3c\x6c\x98\x08\x31\xbd\x39\xe8\x42\x7f\x80\x39\x6f\xfe\x68",
> +	.m_size =3D 64,
> +	.algo =3D OID_id_ecdsa_with_sha512,
> +	.c =3D
> +	"\x30\x81\x88\x02\x42\x01\x5c\x71\x86\x96\xac\x21\x33\x7e\x4e\xaa"
> +	"\x86\xec\xa8\x05\x03\x52\x56\x63\x0e\x02\xcc\x94\xa9\x05\xb9\xfb"
> +	"\x62\x1e\x42\x03\x6c\x74\x8a\x1f\x12\x3e\xb7\x7e\x51\xff\x7f\x27"
> +	"\x93\xe8\x6c\x49\x7d\x28\xfc\x80\xa6\x13\xfc\xb6\x90\xf7\xbb\x28"
> +	"\xb5\x04\xb0\xb6\x33\x1c\x7e\x02\x42\x01\x70\x43\x52\x1d\xe3\xc6"
> +	"\xbd\x5a\x40\x95\x35\x89\x4f\x41\x5f\x9e\x19\x88\x05\x3e\x43\x39"
> +	"\x01\xbd\xb7\x7a\x76\x37\x51\x47\x49\x98\x12\x71\xd0\xe9\xca\xa7"
> +	"\xc0\xcb\xaa\x00\x55\xbb\x6a\xb4\x73\x00\xd2\x72\x74\x13\x63\x39"
> +	"\xa6\xe5\x25\x46\x1e\x77\x44\x78\xe0\xd1\x04",
> +	.c_size =3D 139,
> +	.public_key_vec =3D true,
> +	.siggen_sigver_test =3D true,
> +	},
> +};
> +
>  /*
>   * EC-RDSA test vectors are generated by gost-engine.
>   */

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

