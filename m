Return-Path: <linux-kernel+bounces-143895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7668A3EE3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257BE1F21581
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4881E56471;
	Sat, 13 Apr 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da62TjAa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB35473D;
	Sat, 13 Apr 2024 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044731; cv=none; b=jkKnJUAFPyfPaZRsdFioIlfobo2q9F/mqGkfiqPhAQuXbw23x4/igdRBakOBM4a4JC1BVGcz/gBlHBt9utAyfMg12LawSmS2SqkQQdHzmBqIoF+q79nHn/Cz3ElGGgtnOjvxYxJuBWIRQI1qdJf6NmHPwjPLNh3FE4U9z+VI7Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044731; c=relaxed/simple;
	bh=FzLB7n/twCvzDX/J6gv95pU+9q2Pb9pg4D+FYJtgJlk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=dTw40OtNV9Ve4YYDCThy3zIEoWZTFebS0diXEPwaMPw2O6336TIWjFZNygm1X3NOBvZTQbu4IYFEvDMJtgZsl4TDIHWttnzpGayy8OT/xmm2dbRfchqSsNiuWJsUj1neD4jiXfocdGt4aXJwDiJVawyGQ4SLjEAr16oPS8o6m7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da62TjAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4895C113CD;
	Sat, 13 Apr 2024 21:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713044731;
	bh=FzLB7n/twCvzDX/J6gv95pU+9q2Pb9pg4D+FYJtgJlk=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Da62TjAanwNVWTw7rAchDoffabfGssvntnvuNVm47pha5P6Dko59kAFA/Xa0H5J2L
	 xrXx83+CEs6eEwTVanO6Ks6oMSwlAnM6GT9+ll7oQs+Em7KvA0NE0AWQ9yWG2ke6m4
	 Q0OsSBe/xxPys3VTy1/pU0YAO55A3TLrrs+LXbSO35E8mpRdV1/SE6r75ZBz+E6oRX
	 SRDkVShZjl8BZEKfhkCPWIvCfNJY5QnBI7Y0Bw65Yhl3nXCunBiT4C9CV6Y8i0etli
	 Hw8WVUHUWlpcQQTUPAVHr4X6uFSXFCqGT3l/b1uypAFgbtwkG1i35Z/65WvUgnDGUd
	 KMSmwbndfATng==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Apr 2024 00:45:28 +0300
Message-Id: <D0JBOC2PWDNZ.35KM8ORI81JZH@kernel.org>
To: "M. Haener" <michael.haener@siemens.com>,
 <linux-integrity@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Alexander Sverdlin"
 <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 1/2] tpm: tis_i2c: Add compatible string
 st,st33ktpm2xi2c
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-2-michael.haener@siemens.com>
In-Reply-To: <20240413071621.12509-2-michael.haener@siemens.com>

On Sat Apr 13, 2024 at 10:15 AM EEST, M. Haener wrote:
> From: Michael Haener <michael.haener@siemens.com>
>
> Add "st,st33ktpm2xi2c" to the TPM TIS I2C driver. The Chip is compliant
> with the TCG PC Client TPM Profile specification.
>
> For reference, a datasheet is available at:
> https://www.st.com/resource/en/data_brief/st33ktpm2xi2c.pdf
>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2=
c.c
> index 9511c0d50185..1f277c34e6da 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -384,6 +384,7 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>  static const struct of_device_id of_tis_i2c_match[] =3D {
>  	{ .compatible =3D "infineon,slb9673", },
>  	{ .compatible =3D "nuvoton,npct75x", },
> +	{ .compatible =3D "st,st33ktpm2xi2c", },
>  	{ .compatible =3D "tcg,tpm-tis-i2c", },
>  	{}
>  };

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

