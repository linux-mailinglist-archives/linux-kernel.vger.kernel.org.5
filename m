Return-Path: <linux-kernel+bounces-7349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E40481A653
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7AEB22D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F4481D8;
	Wed, 20 Dec 2023 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PpAdagND"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A500481A0;
	Wed, 20 Dec 2023 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703093290; x=1703698090; i=markus.elfring@web.de;
	bh=JaA2fxNDoommCiVHVHU09SsAG6D3wIoXFEtfnfjjzyQ=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=PpAdagNDYHmfbvfxI7B/w48jLC4VbRtiPJoOuT5HMwRothHp8nyH7BM+1XlI1GXy
	 x7cF9YHPOJuGE9Wb3I4ojwY3+6W29jnsymSvmp48uMNRWZ6xTgQj2XIWdghxDfYLy
	 H0HZNcHgl2o8QuD4xuvPVjHDRBo6IxQMpydnwbcxNmxw5ImQy7dlPTb2KR/0SrJEW
	 5UID2CK9h5SUOl+jIS7BelnberEx/MraxwLvebQpcYQBFSl5WwTTp4xmN/9EYGQ3T
	 kKYVAc5nzdDEr46ozMQ2A3Cs88UcdOweo+TL14SRHOhwkkQwpcbUom/BKs/g87+z+
	 vrRSTPY2hlS6Sa0iAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDQj-1qhDe23aCd-00bEh6; Wed, 20
 Dec 2023 18:28:09 +0100
Message-ID: <b472d62b-47f9-428b-b5a9-9b3c526f487c@web.de>
Date: Wed, 20 Dec 2023 18:28:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
 linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Avadhut Naik <avadhut.naik@amd.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 John Allen <john.allen@amd.com>, Muralidhara M K <muralidhara.mk@amd.com>,
 Tony Luck <tony.luck@intel.com>, William Roche <william.roche@oracle.com>
References: <20231218190406.27479-2-yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 1/3] RAS: Introduce AMD Address Translation Library
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231218190406.27479-2-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LpOpQfMLOJ28U+FSOEeLudUgnY5BrKIWUS5XPC8lBFWoQcidS0T
 9lozXUO+fqIs7Wu3ya3Sc2AxIFe7PFUuzjDyY13RUlOGDQ7Ix1ILCZczYDV5Svc4orw2aDB
 ODpQ608s2CEVWK2j2yg2EqOrowmzOynbfaiRTvjgN66a6R3tD1iilXK3P/EEynEQo3hruLj
 Uy28EHxF3BM8RnM+hyQTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BZhrZ0n9XNQ=;orYPngzetXKwht6bs8pgPrNY/DX
 Y8iC3CaY4LFN12PIPDORRoVi12WvG6+MJj0+PJ1meq4yw0Q7FVhJV9TLF5Xwgxsln82R9mUCC
 qdEqXger5KJyNIudna1WPlBVMOeNdptednZOcT01J8wE1uuud7Jp9bC5q5T8d6E6SkCpCdVGx
 5ztLaX71l0vkgICJTsBdXB8cjFpMijpHUSq/Gqb+SyTN4ZmsNzKnU9I+hh6C0ZtROoOhWoEXD
 yZYAXrI6V4ioHKm7j8beZ/HFs+c4mnvt6lmpIm3yOiiozN6HDmS6jdQxQ7sZrXu+UluQ6D3CK
 affCPmCd3B9kPXm0eiyCnYNe8uqC5KOlS/Fz6j8PUfjVV7F7NYKY1TYhxfcko4U747PoUAJ5R
 1jRlWXFNZO8jLUlLik2fbx6uHaNaYGuUfXU+/xLsUburG6ZeY1V0gguoNgKh7vHjLhMc9Tq+d
 nYW9v1Gm2/BFOsEy+Eq6PuyYKiCJpdrpPUM4fwYQASUAESTjSTnA/8Hlm3pyluHAjbn8ruK4t
 0DR4rZxGZc+IxrjG4mVmGNtukNa65cIgjkHgFhzNrWLkQNOMmlLqLCHzCDw7/njIQRH8Si8hM
 Iu+Cm5LBVN7JcVB0MqnhP9daW15uUsEK6TYaU1WgmItx1VSkvuLsudPiOl1uRgg+6NbCIgT81
 gJAVE9CrOvnKzJNO0q0obdVXlqMNZ/wgMuduM/Dl0Y+JWUuRnGGu/yyZCXvKNDv+QmRMuhr7N
 qhfVdfk7sC1ib42IqZHx2SZRYRe0fsF5+cyFOLyhAHCg8CCPpN4ZUpc53dCNeJa3oC/gVhXqG
 ko1+1HkNq7NIOX2DIT5NYBlFQgKLXf1qCrjylPxkOkKOSSUYZBawwk/QVNw4nXXlMJSCFygfq
 5o0WWUAPf6Jzq3OYlEeMVUfoVpj1v6KwVcCfvT2PZF25RNMbrA4sg7L1i6dQzBw+kNgEJR92J
 e566SLzWy+ZQ1DJfm8W4w76Ri/o=

=E2=80=A6
> +++ b/drivers/ras/amd/atl/map.c
> @@ -0,0 +1,667 @@
=E2=80=A6
> +static int get_coh_st_fabric_id(struct addr_ctx *ctx)
> +{
=E2=80=A6
> +	if (df_cfg.rev < DF4p5)
> +		ctx->coh_st_fabric_id =3D FIELD_GET(DF2_COH_ST_FABRIC_ID, reg);
> +	else
> +		ctx->coh_st_fabric_id =3D FIELD_GET(DF4p5_COH_ST_FABRIC_ID, reg);
=E2=80=A6
> +}
=E2=80=A6

Is the following statement variant a bit nicer?

	ctx->coh_st_fabric_id =3D FIELD_GET((df_cfg.rev < DF4p5)
					  ? DF2_COH_ST_FABRIC_ID
					  : DF4p5_COH_ST_FABRIC_ID,
					  reg);



> +static bool valid_map(struct addr_ctx *ctx)
> +{
> +	if (df_cfg.rev >=3D DF4)
> +		return FIELD_GET(DF_ADDR_RANGE_VAL, ctx->map.ctl);
> +	else
> +		return FIELD_GET(DF_ADDR_RANGE_VAL, ctx->map.base);
> +}
=E2=80=A6

Can the following statement variant be integrated instead?

	return FIELD_GET(DF_ADDR_RANGE_VAL, (df_cfg.rev >=3D DF4) ? ctx->map.ctl =
: ctx->map.base);



> +int get_address_map(struct addr_ctx *ctx)
> +{
> +	int ret =3D 0;
> +
> +	ret =3D get_address_map_common(ctx);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D get_global_map_data(ctx);
> +	if (ret)
> +		goto out;
> +
> +	dump_address_map(&ctx->map);
> +
> +out:
> +	return ret;
> +}
=E2=80=A6

Would you like to use a function implementation like the following instead=
?

int get_address_map(struct addr_ctx *ctx)
{
	int ret =3D get_address_map_common(ctx);

	if (ret)
		return ret;

	ret =3D get_global_map_data(ctx);
	if (ret)
		return ret;

	dump_address_map(&ctx->map);
	return 0;
}


See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.7-rc6#n532

Regards,
Markus

