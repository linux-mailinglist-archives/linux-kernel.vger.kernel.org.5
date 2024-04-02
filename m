Return-Path: <linux-kernel+bounces-127497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B15894C80
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D235C1C20431
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE239AC3;
	Tue,  2 Apr 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uh40wk5f"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505D383A4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042253; cv=none; b=ApvTX1GjowzMb3+pSC0OF2AO+CFHV54Abq3JjB8cGL1tv8kLQMM9hiGGoRkOs87KfWwlGpR430LPva52MTXTUA1Xf5ojRSlDEM+CCj1b9w26ptLrUpZNhuNPLX5yyw5YNtqL6VSLbBRd4pRkOAy6j4XAcnCWckPiZy1jP4dA6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042253; c=relaxed/simple;
	bh=eN+1HKdl2zbDnDnFxj0qA5MUBSn6KCCqGxvqIEzcWOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWVL8mgMaIa1W5x7tZJUWnLYBSMqTbC6x5Igz+GM8vampvxpXaZEfdLhiu61X6RF7ZZtTmIf05VhYs+wWQjI+mUnukoWVHGu/JbubNoUJm93dbb2FrszyHu1fFfDb+hKGsx5tm3/j3CnVZd1Vfft8g8a3WLHWK6KsblyJPVNxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uh40wk5f; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E15E5E0012;
	Tue,  2 Apr 2024 07:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712042244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyiqMn8iq2POB6jW9ztBdA/Viq5fYoh35k7L3HoZwIg=;
	b=Uh40wk5fU8+Okrt7gbO/UybeRHjE7GG08Zt7oV8jypkMnxeZwDGQ1It108zB+pE9T77D7E
	SfsJsj2wH4DV7bXz6JkvKcXyHVFMYC9SWqYB5Q65Kf/yZ10beck4+iQVNgZ9YpwC6UDuiz
	y/0WrjM4muYdQqWwAKGOpA2F1kNfQcavQMIigkRZCgBh95OlHeFtJ+lTrCUjPpknikZtNL
	QxmDUXPtX0vcmvdtwGuSLjH3pmYeQnL/TtSLj7JZ78FPOozZVIGwP8SbHWyqCi9Qn/2vpq
	BSiA8O/wlu5P/Nr5Xrdi/CBp/Pz8oMIOzEu3EuEa2/tghhWWMNRmlaoDexjv6Q==
Date: Tue, 2 Apr 2024 09:17:23 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Michael Walle
 <mwalle@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] nvmem: layouts: sl28vpd: drop driver owner
 initialization
Message-ID: <20240402091723.1923c13c@xps-13>
In-Reply-To: <20240329-module-owner-nvmem-v1-3-d700685f08e1@linaro.org>
References: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
	<20240329-module-owner-nvmem-v1-3-d700685f08e1@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Fri, 29 Mar 2024 17:13:37 +0100:

> Core in nvmem_layout_driver_register() already sets the .owner, so
> driver does not need to.
>=20

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/nvmem/layouts/sl28vpd.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28=
vpd.c
> index 53fa50f17dca..e93b020b0836 100644
> --- a/drivers/nvmem/layouts/sl28vpd.c
> +++ b/drivers/nvmem/layouts/sl28vpd.c
> @@ -156,7 +156,6 @@ MODULE_DEVICE_TABLE(of, sl28vpd_of_match_table);
> =20
>  static struct nvmem_layout_driver sl28vpd_layout =3D {
>  	.driver =3D {
> -		.owner =3D THIS_MODULE,
>  		.name =3D "kontron-sl28vpd-layout",
>  		.of_match_table =3D sl28vpd_of_match_$

Thanks,
Miqu=C3=A8l

