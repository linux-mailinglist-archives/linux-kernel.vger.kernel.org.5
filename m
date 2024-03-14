Return-Path: <linux-kernel+bounces-102920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4567687B859
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB2CDB21ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61787F9EF;
	Thu, 14 Mar 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W7omPnN9"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4E17BA2;
	Thu, 14 Mar 2024 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400328; cv=none; b=PgRjb3YoOwRBn6fC++AAXkX71V+w6nqpj4NtARpUoxgklugEX1gAb/pKCskphmYh5iNASoyLPKrCqOh2bGVpzaqLvM+/BznP6zYsAdy8ea2KCiGSGqpEBYavZT9Dk80LIioUxGwXZxJ959BQukg8LAXYOmSu74qgjnaHCjXNne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400328; c=relaxed/simple;
	bh=M9/waeQYtjh2RVYctqjLxomU+TwqqnJNewvELUWzQTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ocw3rbXsPAQesjN0gO+uS4VvBzrxLod99z7EunGVSq4McE5a2ZDCTx7zk1seEUt9BXKaCVEITAB+kAXsQY5SkIS/SFfzPNR6or+jSBX+F6XFfat+HSLQR5+zs5SShxSV0TDg1NUf0oiDqm/E1tg2hwLlOu9uZF0lm7QbHtqeW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W7omPnN9; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0D26FF803;
	Thu, 14 Mar 2024 07:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710400324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5VEjuuC5AnU2gJMo8TZ6MI2cdvYkDyizNf/LUfFzY0=;
	b=W7omPnN9K0mk9NXpTw72bzIAJRdqYDOB4XIotsYwt1WH+u6qMlbVPLpEEZSwvEg4IDpL+7
	IHFiXNXdg8+0UcUURrxWX5sGoedCEAnUOidpf4on92uFdvTigr6aXeXgl1F/96AULv/dJA
	SYAGlgYzd7fLLdRQ4IwYv/Cy5K2IbS9qyup091Tge8INdmBbq1IlOTsJ4afqPAkfdN95NS
	Y/2x1IN9g1IqaU2FYIop4+XeXeoAVnv9cFViYR2HEHYTsP+lTn1n2x3ZLaWCxvMeLa+G4w
	X3XKQAWsYE/YaiUcD5zq0KbsQdKy26xMnJUIDN/Rn2KmkfoNajoaL+9T4U8FwA==
Date: Thu, 14 Mar 2024 08:12:00 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yury Norov
 <yury.norov@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Lunn
 <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>, Ratheesh Kannoth
 <rkannoth@marvell.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 1/5] net: wan: Add support for QMC HDLC
Message-ID: <20240314081200.5af62fab@bootlin.com>
In-Reply-To: <87ttl93f7i.fsf@mail.lhotse>
References: <20240307113909.227375-1-herve.codina@bootlin.com>
	<20240307113909.227375-2-herve.codina@bootlin.com>
	<87ttl93f7i.fsf@mail.lhotse>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Michael,

On Thu, 14 Mar 2024 10:05:37 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Hi Herve,
> 
> Herve Codina <herve.codina@bootlin.com> writes:
..
> This breaks when building as a module (eg. ppc32_allmodconfig):
> 
>   In file included from ../include/linux/device/driver.h:21,
>                    from ../include/linux/device.h:32,
>                    from ../include/linux/dma-mapping.h:8,
>                    from ../drivers/net/wan/fsl_qmc_hdlc.c:13:
>   ../drivers/net/wan/fsl_qmc_hdlc.c:405:25: error: ‘qmc_hdlc_driver’ undeclared here (not in a function); did you mean ‘qmc_hdlc_probe’?
>     405 | MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
>         |                         ^~~~~~~~~~~~~~~
> 
> 
> IIUIC it should be pointing to the table, not the driver, so:
> 
> diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
> index 5fd7ed325f5b..705c3681fb92 100644
> --- a/drivers/net/wan/fsl_qmc_hdlc.c
> +++ b/drivers/net/wan/fsl_qmc_hdlc.c
> @@ -402,7 +402,7 @@ static const struct of_device_id qmc_hdlc_id_table[] = {
>         { .compatible = "fsl,qmc-hdlc" },
>         {} /* sentinel */
>  };
> -MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
> +MODULE_DEVICE_TABLE(of, qmc_hdlc_id_table);
> 
>  static struct platform_driver qmc_hdlc_driver = {
>         .driver = {
> 
> 
> Which then builds correctly.

My bad, I missed that one.
I fully agree with your modification.

Do you want me to make a patch (copy/paste of your proposed modification)
or do you plan to send the patch on your side ?

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

