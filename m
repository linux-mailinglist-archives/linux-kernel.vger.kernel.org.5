Return-Path: <linux-kernel+bounces-74762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 860FD85D92F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53AFB23F96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6076C99;
	Wed, 21 Feb 2024 13:15:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A8E69DF2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521325; cv=none; b=O9sRyFi3Ak1kKg3BkTeyFVi6i2XSUaGxjf0l/rviHRXwM4fHXEcL35fsAb3/RWGGEqsg0eej/OH1LcmR8ObND/C2Knc57+ugjKzrv90QfJWa0coP5moSgYANxPiump6f1Djl1LbJ9OPa3lOOAk+95UnoTMEAd5NK7W8x8pR8nBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521325; c=relaxed/simple;
	bh=nPne4q7JlWz3mcWsYUNx4f2M8e4DzRnR7m7tEam7xpg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZS9/iO3uyZTeMdn4mI3rI5Uw4QsQkqbg6tfKmlfNynm6KiAnorSuIT5wf0lPn/Mq8CsJIR1pmQOaNeJOAJAACHbibrN9RjHBMDVOWCd/U/T0cD4LrJGc1lLAXlToGzPM25i44VO52w9GuQvpci1/41xTCYTdZt+Azm3wsWFT4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcmR4-0001CI-QA; Wed, 21 Feb 2024 14:14:54 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcmR1-00237N-FS; Wed, 21 Feb 2024 14:14:51 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcmR1-0008xE-1G;
	Wed, 21 Feb 2024 14:14:51 +0100
Message-ID: <d203819f09749f0ff9e08a80471b7fed3dad67a8.camel@pengutronix.de>
Subject: Re: [PATCH v14 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for
 ASPEED g6 PWM/Fan tach
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com, 
 linux@roeck-us.net, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 corbet@lwn.net,  u.kleine-koenig@pengutronix.de,
 naresh.solanki@9elements.com,  linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,  linux-pwm@vger.kernel.org,
 BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Date: Wed, 21 Feb 2024 14:14:51 +0100
In-Reply-To: <20240221104025.1306227-4-billy_tsai@aspeedtech.com>
References: <20240221104025.1306227-1-billy_tsai@aspeedtech.com>
	 <20240221104025.1306227-4-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2024-02-21 at 18:40 +0800, Billy Tsai wrote:
> The driver support two functions: PWM and Tachometer. The PWM feature can
> handle up to 16 output ports, while the Tachometer can monitor to up to 1=
6
> input ports as well. This driver implements them by exposing two kernel
> subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
> existing drivers for controlling elements such as fans (pwm-fan.c),
> beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driver
> provides sysfs interfaces for fan.
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  Documentation/hwmon/aspeed-g6-pwm-tach.rst |  26 +
>  Documentation/hwmon/index.rst              |   1 +
>  drivers/hwmon/Kconfig                      |  11 +
>  drivers/hwmon/Makefile                     |   1 +
>  drivers/hwmon/aspeed-g6-pwm-tach.c         | 549 +++++++++++++++++++++
>  5 files changed, 588 insertions(+)
>  create mode 100644 Documentation/hwmon/aspeed-g6-pwm-tach.rst
>  create mode 100644 drivers/hwmon/aspeed-g6-pwm-tach.c
>=20
[...]
> diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6=
-pwm-tach.c
> new file mode 100644
> index 000000000000..597b3b019d49
> --- /dev/null
> +++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
> @@ -0,0 +1,549 @@
[...]
> +static void aspeed_pwm_tach_reset_assert(void *data)
> +{
> +	struct reset_control *rst =3D data;
> +
> +	reset_control_assert(rst);
> +}
> +
> +static int aspeed_pwm_tach_probe(struct platform_device *pdev)
> +{
[...]
> +	priv->reset =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Couldn't get reset control\n");
> +
> +	ret =3D reset_control_deassert(priv->reset);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Couldn't deassert reset control\n");
> +	ret =3D devm_add_action_or_reset(dev, aspeed_pwm_tach_reset_assert,
> +				       priv->reset);
[...]
> +}
> +
> +static int aspeed_pwm_tach_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_pwm_tach_data *priv =3D platform_get_drvdata(pdev);
> +
> +	reset_control_assert(priv->reset);

This is already done by aspeed_pwm_tach_reset_assert(), looks like
aspeed_pwm_tach_remove() can be removed. With that, priv->reset can
become a local variable in aspeed_pwm_tach_probe().

regards
Philipp

