Return-Path: <linux-kernel+bounces-77550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A76B86075C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45191F23DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A283279E4;
	Fri, 23 Feb 2024 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs0KJuYr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9823209;
	Fri, 23 Feb 2024 00:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646498; cv=none; b=juXJUz1Tk3V1/VQ9hKhgTEfLYG4VvMUzo5toq/aLoWfV6Af9Q7DPvzhvEr4vw/MnBp9/veyrvMAi5ldJ82WFXtmdYYJVdpkdv9zlTdVXeK2M8ff7txkAbgwuejahdpuwgDmyv/qjyc5bHpPZZdzH5043wCiQbp/ZLeOo04rQ22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646498; c=relaxed/simple;
	bh=j+ESD4Q/QZWpzJ5PpQQRTIfQxg53nG40zpN2uQgqods=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=UZv5F3a5zLrgngRdxPlcHr62Gn0Jg7wOsBsGQQGhka0kHCE0T0LhYERu2JH3wk1K0/TH8Uc5njQUXRbZzCFQ/y6oUPysa0rcobcbq/Pe6rrPJ41qFFN8jIJt7Hjn7lOVZgOtRuspXvhLa9vxL3ALw0moHqDpOU4XO736SeM0Znw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs0KJuYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3E8C433C7;
	Fri, 23 Feb 2024 00:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646497;
	bh=j+ESD4Q/QZWpzJ5PpQQRTIfQxg53nG40zpN2uQgqods=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gs0KJuYrsbWv0csq9XYhI1MSXveC6+TJux7Yu8n+3P/GUY4HF6Q4eJot5v0D0cowJ
	 D6PZUi8jVGWIj0JFmpOlo7yqoFib31jJtAo9JVnBcJSE3Ab0bg4eVkXCtoMdmhM7yJ
	 nGKdnAAPk/TKgmJvyqzxj2Vn/IotNsRDVQ2dkvEDsRfw6dmowZVm/MGPUbi4T6HXYW
	 YV8uzTrV+/BJs7T/gYsg3NzKDdZvtC6nAexp1Ukg/pcHfLuBkTaPJbZ1pN59Znq+h3
	 68aoBcbx0azO7lh/sIC5DJX9GhScZfHXgxdsZVewRxJbi/oO3x9wQHhd96L4+0Hjbd
	 w8sMNd9iQqplA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 02:01:32 +0200
Message-Id: <CZC0MQ8XX32O.8NIQ5WNDKUFJ@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "Sasha Levin" <sashal@kernel.org>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
X-Mailer: aerc 0.17.0
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
In-Reply-To: <20240131170824.6183-2-dpsmith@apertussolutions.com>

On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
> Commit 933bfc5ad213 introduced the use of a locality counter to control w=
hen a
> locality request is allowed to be sent to the TPM. In the commit, the cou=
nter
> is indiscriminately decremented. Thus creating a situation for an integer
> underflow of the counter.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Reported-by: Kanth Ghatraju <kanth.ghatraju@oracle.com>
> Fixes: 933bfc5ad213 ("tpm, tpm: Implement usage counter for locality")
> ---
>  drivers/char/tpm/tpm_tis_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 1b350412d8a6..4176d3bd1f04 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -180,7 +180,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chi=
p *chip, int l)
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> =20
>  	mutex_lock(&priv->locality_count_mutex);
> -	priv->locality_count--;
> +	if (priv->locality_count > 0)
> +		priv->locality_count--;
>  	if (priv->locality_count =3D=3D 0)
>  		__tpm_tis_relinquish_locality(priv, l);
>  	mutex_unlock(&priv->locality_count_mutex);

To make this patch set better the whole story should be scenario based.

Starting from cover letter the explanation is way too rounded to guide
to the conclusion that these are actually best possible code changes to
fix the issue.=20

I agree fully on that the problem should be fixed but given that the
scenarios are fuzzy deciding whether this the right things done right
is the open question.

I.e. we need the steps for destruction and how these patches change
those steps to make this right. Since the whole topic is complicated
I'd use PC Client spec as reference.

BR, Jarkko

