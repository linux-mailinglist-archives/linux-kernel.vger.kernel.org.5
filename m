Return-Path: <linux-kernel+bounces-48934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1189F84635A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25E31F24063
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34333FE37;
	Thu,  1 Feb 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM24FYvT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427773D3BC;
	Thu,  1 Feb 2024 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826074; cv=none; b=nZBYxOshPSL470gaqxzFmOOMSOftJGi3ISV6pOMMrA1uF3T6vi1Tawoz2B/rWqCyyPN7+yeizpIMOu3DDQJGg1HmJbYL9gB0RMySaibS5N4gsUSTvnPj7X4W0tlhic8FhHQTnoAO3trsxxj1anD9YOsx+jf59FNZot35z7Tds1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826074; c=relaxed/simple;
	bh=1PfMxcXazCM2Ebis4rzJlTIC5ad7jHl/eqWgGdFnSN4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=aSVteJCXmAjjaftOpG0EFfdBwu+z5tB8EXW6Q70ZnVJZLHUc1nFHyOQwtvxy3TPmequ1O4L4FFlksHBQpo22niAzw0UE9fTPeOHVbDKfEy8d3lgimsv/edYuFFTNJ3xGmuDViDlVvCFvXVBvL2yPO/xudBc1uV7Zy/8L/qM92oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM24FYvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A6FC433C7;
	Thu,  1 Feb 2024 22:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706826073;
	bh=1PfMxcXazCM2Ebis4rzJlTIC5ad7jHl/eqWgGdFnSN4=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=LM24FYvT1I7gmXU8D8X3ZfhvD0B5sFjKjVjS+DgzKjDOG2Y22mrH2tpKkXORaC4nO
	 hh2EO1bNdF4qAZDddqyJvA8wWaiGuFUVIybEfWn2bOW0ZAOpe0djtBpqxx6nk4QYWD
	 3nUfdk3lc5PsTvUYs1uCZdgo5wgR5C/DqgeuwZBX12ieRBoRw6vbNEVkyuziQ3biTT
	 ZE3hebMh/G9KIHA5A6G+sPJpn8l52Ho1/O0f50nBWMAL89wYscX/asApmPi54Fi7pf
	 51JPV2T4Y5eTq7wPgAiYQ/DwWPG2jZ808qd1lWM6burwtz21DZIrynkX6E3CwB8e3p
	 q18/0u9YGOmFA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 00:21:10 +0200
Message-Id: <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "Sasha Levin" <sashal@kernel.org>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
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

What is the sequence of events that leads to this triggering the
underflow? This information should be represent in the commit message.

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

BR, Jarkko

