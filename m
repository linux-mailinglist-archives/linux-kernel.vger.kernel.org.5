Return-Path: <linux-kernel+bounces-117915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD888B136
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5631F3B31E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C773245033;
	Mon, 25 Mar 2024 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="JDWkMkfc"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C080FC01;
	Mon, 25 Mar 2024 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398094; cv=none; b=eB/yeg4oLmfWfsff8ppTVXr0++XjsuvC0YELn1BdHzsD5lmHD0ikzGqIhlTNT/FnolIznBZQMN5dZ6I6ZOVr3Gw1Thx8gA7Zx7J6k9v3Eugq2Ch41SK5MvlhMO5/9lnr7YUMTQX5kWjBJESutLlFNeUn4bCyIUCbEI0/h/zgR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398094; c=relaxed/simple;
	bh=a+z3qKumD+RQg3H6lUB5SaV/7DJ5gP11DLjMy8pF7WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esLFlOfqzl17kh2d/j6HYhDsK51oHSLU8tWN1RQJwpvAQWSMeCw/FvlAmfxJXS/t/wrt6uUHxA9W6NuoqjFERCptR1pYQDpsAy6fhxBba+gPldZZ8KrCUtypBEf5fJxZrSseVGDoFtH8G2b96g0jBRXI26vJpya05a/jQFcKsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=JDWkMkfc; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roqp0-003NzO-1U;
	Mon, 25 Mar 2024 21:21:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rkYfldBj3PRsa1Dy1CFhJw9d4S4bgs5eahv262+sdRk=; b=JDWkMkfcIOmuGiIGE865IPb2Pl
	T0S3ZyUfwoq6deGR7lFt0pMcHnIzfCXNLTHaSGO2ZBz58uMI+7M7rx+W6NwRUPFHMsBRfeabngEda
	EXLFYdcuvAK2LTYx9au2SBPk0YBIRhVurf6uoiMDZVPa8cFNpwYQOPTV/y81GBzn3zjvU3qYvP4Ei
	j4VqIae3b58yb4u9rjiNJPf0qPSp/ddzNbamh2BpWUAQDSOZae1/nNFj5bSpIptQnUCumSGNmsMLW
	2V0NF6VpfMoiIbuRFYAa/jXVvfdWgvQigaX+CPJM7hVbceEA1ajK7rDtAzYMLgDQbaHcz6nPvHICa
	rWtLunKQ==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roqoz-0000he-1O;
	Mon, 25 Mar 2024 21:21:30 +0100
Date: Mon, 25 Mar 2024 21:21:27 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mazziesaccount@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [RFC PATCH 2/2] mfd: rohm-bd71828: Add power off functionality
Message-ID: <20240325212127.7583c845@aktux>
In-Reply-To: <b5cc609a-b3c5-4994-bcd5-e25a43d33cff@linaro.org>
References: <20240324201210.232301-1-andreas@kemnade.info>
	<20240324201210.232301-3-andreas@kemnade.info>
	<b5cc609a-b3c5-4994-bcd5-e25a43d33cff@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 13:13:13 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 24/03/2024 21:12, Andreas Kemnade wrote:
> >  	struct regmap_irq_chip_data *irq_data;
> > @@ -542,7 +560,18 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
> >  	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, mfd, cells,
> >  				   NULL, 0, regmap_irq_get_domain(irq_data));
> >  	if (ret)
> > -		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
> > +		return	dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
> > +
> > +	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
> > +		if (!pm_power_off) {
> > +			bd71828_dev = i2c;
> > +			pm_power_off = bd71828_power_off;
> > +			ret = devm_add_action_or_reset(&i2c->dev,
> > +						       bd71828_remove_poweroff,
> > +						       NULL);
> > +		} else
> > +			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");  
> 
> Missing {}
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
No, it does not complain about the {}. I was a bit unsure whether it is
required or not, but I was sure that checkpatch.pl does catch such things.
Yes, documentation clearly says that braces are required in those cases.

Regards,
Andreas

