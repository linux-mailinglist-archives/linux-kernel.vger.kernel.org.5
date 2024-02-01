Return-Path: <linux-kernel+bounces-47809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E0845325
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E61288034
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C315AABE;
	Thu,  1 Feb 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="nUaY49pE"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656715AAAA;
	Thu,  1 Feb 2024 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777543; cv=none; b=LqFboKySz0QJ4+4iKNrJxs6Z32Q5XRb1fDgpKT81T8jZMoMnFA+nMwcNGjLUw5CXhFguDvFUVpSvFlizupUEZM7MzzAhcZqIEFdV5Fc/nFN4CZaA+ZgZHBkv3SuouiYtf2O/9YrNMud8vYBJokbNZiCfdfiyjMkEFabuM4/mLk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777543; c=relaxed/simple;
	bh=qjXRMPTBXgNCfrzVvw0+vXsJAlv2osyQDadESelPs2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBfXD+iJRlNr0Q7+a0VHRNqz1U4Hj1WMSH5Y2SnYmJ4GSffQXao4SyKtZHmzMM0ZWGywcV/fepoHb3fSfqS6cLc0QSoAOgj+ePqWwqBTy5ubLRQeY41ztc7qpLsm4XbwlMytuczeeBo7oanadGhWjiUxVCxQDrcDKFitVw2+SDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=nUaY49pE; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 97D8F21597;
	Thu,  1 Feb 2024 09:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706777536;
	bh=mEEupIMEH/i7kGo9lESs51Pok88ap/wDkvXExYpqB6c=; h=From:To:Subject;
	b=nUaY49pE37chEBYH8+n5sOOBXEAToefJYv9tDDSpOJTacwiuUGfCE0VG5Yz42kycG
	 OJUuTvGqNaAQRd0stbkWc4TS8YlPnlF+hiVS4lGfi1I91xi+Gf2i81ezCU4i8QA/6p
	 AJlSAfRYI61qFgBui+F58Y5KAVDU/VS/q7AO4sNECCvhkG7KY3anQRME19SnzYci+u
	 49LQMvkDbU49ezszAejG9dKLTFOeUCuDKxeDT8oHPIQMzGZ6XTGKuLy8hWuYeZxL7e
	 Ft1jgoC9EAQ0KugT0/spYIAYFcyIiM14hJs5zvDE73n1aRmUDqZ10u/q7b2uXEFDvt
	 CWaLwovoEMCzw==
Date: Thu, 1 Feb 2024 09:52:05 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Carlos Song <carlos.song@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	dl-linux-imx <linux-imx@nxp.com>,
	"benjamin@bigler.one" <benjamin@bigler.one>,
	"stefanmoring@gmail.com" <stefanmoring@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: imx: fix the burst length at DMA mode and CPU
 mode
Message-ID: <20240201085205.GA3906@francesco-nb>
References: <20240131101916.437398-1-carlos.song@nxp.com>
 <20240131194207.GB12870@francesco-nb>
 <VI1PR04MB5005EB37DD02F4E32D94336FE8432@VI1PR04MB5005.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5005EB37DD02F4E32D94336FE8432@VI1PR04MB5005.eurprd04.prod.outlook.com>

On Thu, Feb 01, 2024 at 02:02:36AM +0000, Carlos Song wrote:
> > From: Francesco Dolcini <francesco@dolcini.it>
> > Add #include <linux/bits.h> given you are using BITS_PER_BYTE
> > 
> I found that <linux/property.h> has been included in spi-imx.c driver.
> And <linux/bits.h> has been included in <linux/property.h>.
> So I didn't add the "#include <linux/bits.h>" on purpose.

I think you should be explicit and include this header.
Code get refactored all the time and you can prevent issues this way.

Francesco



