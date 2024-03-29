Return-Path: <linux-kernel+bounces-124433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527CE89178B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCD2B21715
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B9869DF4;
	Fri, 29 Mar 2024 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="JLdXTkNn"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D424404;
	Fri, 29 Mar 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711291; cv=none; b=AeelJSk0ilQDvsVdiZPFjMD7Jvq8ZNPNdayikp26fE+ryIpjkQEwZIvfUakvdLQjuh3J1suJJMkW0NFxCSSltUqhp4VbPcypSr7Vx8LdUV3y3e6J+lrPS5VCzFvv7f4aUB4ACwaWnVKcN2TV5hxgVe0SkSYaW1ghfYl0MJ0o6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711291; c=relaxed/simple;
	bh=iYfgBZq2XkewePDydkRtWmj3V6D86xmwWJACA5tmCh4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=dtzNdqApODHyh6drI466g3CfYT7Oo1uNzR0/MCUwlQDjEdrxlbav+KzBXsT/ARhgW3YW8tqPJQciRssA3cG8torSlMq5FqkRtv0z+vM3lOiE+gq+Bo1YnsAixAClyR9Tht7XNjrklodv4w5OsqD9GOCzxeoJPkKpVTGcLiwIlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=JLdXTkNn; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1711711277; x=1713011277;
	bh=x9UKxvyS++Fyq3GyH9GiClHfoBx7ExITUMiryYH2sw0=;
	h=Mime-Version:From;
	b=JLdXTkNnJB7nUIjW7cBAsYk3HjAZDkO+aFijQlq5n01wm14QNZjtB61VyW8SRaQjs
	 5ziu7Dfr2lDo6FiG6JVnGkGj742YLLrkzqH30b7yfNdYWGNgwjFyYS7ApA+D3BfGEz
	 e/fI3aC1fVqrOSrPY8OnCqS+SIiv8WDAStaI/HZPXGnmyqbmFNYnHqhi7O6e+b2Xti
	 7fZec0x0AAHeQvg5xBJHMqD4gCQL4BESJwTSE+vFpOvEp/tMJDK/laEcpuQaLKL7im
	 pRLQayNg41fdg9+5B03NpunO1Ha3byOrCQDBMaI591H6dMGqxyEs3BjxHW+oHTvye3
	 oEsZLjt5elgQw==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42TBLFbr010799
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 12:21:17 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Mar 2024 12:21:15 +0100
Message-Id: <D06708BSGQ0J.1L4YOKOADM7T6@matfyz.cz>
Cc: <regressions@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH] pwm: Fix setting period with #pwm-cells = <1> and
 of_pwm_single_xlate()
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
From: "Karel Balej" <balejk@matfyz.cz>
References: <D05IVTPYH35N.2CLDG6LSILRSN@matfyz.cz>
 <20240329103544.545290-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240329103544.545290-2-u.kleine-koenig@pengutronix.de>

Uwe Kleine-K=C3=B6nig, 2024-03-29T11:35:40+01:00:
> For drivers making use of of_pwm_single_xlate() (i.e. those that don't
> pass a hwpwm index) and also don't pass flags, setting period was
> wrongly skipped. This affects the pwm-pxa and ti-sn65dsi86 drivers.
>
> Reported-by: Karel Balej <balejk@matfyz.cz>
> Fixes: 40ade0c2e794 ("pwm: Let the of_xlate callbacks accept references w=
ithout period")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 54a62879fffa..ee3ef3f44bc5 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -512,7 +512,7 @@ of_pwm_single_xlate(struct pwm_chip *chip, const stru=
ct of_phandle_args *args)
>  	if (IS_ERR(pwm))
>  		return pwm;
> =20
> -	if (args->args_count > 1)
> +	if (args->args_count > 0)
>  		pwm->args.period =3D args->args[0];
> =20
>  	pwm->args.polarity =3D PWM_POLARITY_NORMAL;
> --=20
> 2.43.0

Thank you, this fixes the issue for me.

Tested-by: Karel Balej <balejk@matfyz.cz>

Just a nit: I am not sure if perhaps this being part of the report
thread is sufficient, but generally there should probably also be a
Closes: trailer for regzbot to automatically mark the report as resolved
among other reasons.

Best regards,
K. B.

