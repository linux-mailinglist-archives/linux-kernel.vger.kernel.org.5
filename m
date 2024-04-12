Return-Path: <linux-kernel+bounces-142557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8459B8A2D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07CCFB210B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71351537E6;
	Fri, 12 Apr 2024 11:13:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707D3D3B1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920384; cv=none; b=GZiLCPnZLhjTVVIUt19zZ6o4Y4ymipski8mV7walmWjmRe0oNsawBe6rBz+q0skOkY3JbWw9A2pKCiWPPuSxm1dHeRNQHmrPLKLvzxDMtRcXKO9t7s8LHQZmAmas05bUsYzRy0sASSCtLD4Wu3XR9/moEaDl+c7LZx4yM2YkuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920384; c=relaxed/simple;
	bh=BIhxuHW1Tjky9MrjNACsugUh3NwevbqdVTM1vytmnWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOmVlFG3wlACXchugK0ru4x/DwMeM8t6iR7JDPbe8QsUcYf+jGTukDk+BOUJeP9WY8XM3lRIwz2Uu+pdAal8QyA/NEjWbZlHnRHbn2YJnWXz2px5+0ggdWcxeswDfAAjFwizkErYaikAyusIlOzUjukdWxdxD+sz2SlqLmZPFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvEpt-0001qU-JT; Fri, 12 Apr 2024 13:12:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvEps-00BriS-DR; Fri, 12 Apr 2024 13:12:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvEps-0007Gu-15;
	Fri, 12 Apr 2024 13:12:48 +0200
Date: Fri, 12 Apr 2024 13:12:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: allow suspend/resume for 16 channels
Message-ID: <zf74jdjza2kfgmiecmlwlws46fmy3rtxvcocmkwewgx64oewpm@xfyq2zt6ts5u>
References: <20240412060812.20412-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="poakpkong5ugzklq"
Content-Disposition: inline
In-Reply-To: <20240412060812.20412-1-raag.jadav@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--poakpkong5ugzklq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 12, 2024 at 11:38:12AM +0530, Raag Jadav wrote:
> diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
> index a8b074841ae8..c6e2df5a6122 100644
> --- a/drivers/pwm/pwm-dwc.h
> +++ b/drivers/pwm/pwm-dwc.h
> @@ -38,6 +38,12 @@ struct dwc_pwm_info {
>  	unsigned int size;
>  };
> =20
> +struct dwc_pwm_drvdata {
> +	const struct dwc_pwm_info *info;
> +	void __iomem *io_base;

=2Eio_base is only used during init time and so doesn't need to be tracked
in driver data.

Otherwise I (only slightly) dislike
> +	struct dwc_pwm_drvdata *data;
because "data" is very generic. I'd call it ddata. But I don't feel
strong here. I'm happy if you change to "ddata" in v2, I will silently
apply anyhow if you prefer "data".

> +	struct pwm_chip *chips[];
> +};
> +
>  struct dwc_pwm_ctx {
>  	u32 cnt;
>  	u32 cnt2;

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--poakpkong5ugzklq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYZFy8ACgkQj4D7WH0S
/k7jKQf/bACV0R2IYOq2hc4q93teGFMYg3qIOIF1L0GI3pUYcKBM3NR32NrNCl1t
QSLHTq+WjUIaWu7lgbebUfUL9ryD7adwoOyoS2BpvWxpojJWOp2lT8AVXMLYrLQU
0p0dwZiiRzw3jhz+pQ7unXLIYzJQTXiFlKDqwkkbovxdSwXdDGSnyVcRHOQQIFHZ
yx1lKmMnMSzFBPD2VSJQyw/k2K8O0rLA0KAPkAf0pCi2ctE9iPjaL4uhkxBzjD+U
xJKz+W9GlVmmNsCzXbu+YRUOFckZf4EO35CQXfbiqBhk/+DpqlKSdSL6TbJn69p1
/rr4AUJfpYzyaUKHQlO99AHdfprLiw==
=hzLm
-----END PGP SIGNATURE-----

--poakpkong5ugzklq--

