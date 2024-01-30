Return-Path: <linux-kernel+bounces-44006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EEE841C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9564D1C22879
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B413F9FF;
	Tue, 30 Jan 2024 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="lRP5wqfh"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185038FB0;
	Tue, 30 Jan 2024 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597154; cv=none; b=SdGUFsTIY4j7rPOj1YjUS6RDyBh+G1SNv45U/CoM30RKFo/XM84RIjD9Yo0P2T/xc2E21qjitivEZBKKr8Qaeta+Lf+bMh+c2cuRiQEmBzoZ8nOfKdeMoUqprimItT7261dm8pYTDTyA3x2gS+C2QAtyrJzujPTTc2afGpbxq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597154; c=relaxed/simple;
	bh=hkpGj9OHDqmg5LLACRfNfNcEmbMlSDJ8qQ+JPuRBq4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KROJSfNF7yIKcjJ6faxGYUBBdOuXUOfiKgPpLVTum/ktzvjfRUbgLZI7iCeCWxYRSNGhhKXWYrWBSyujvvYpQS85MpIJyBNgxW+lOrhz2sfIHE/CHqEL5JSW5ASjeKTX8W3OJClYZsD7Lr3TbOYilIQTD6jb1dRnbikUoA7Izcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lRP5wqfh; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B59D8207BA;
	Tue, 30 Jan 2024 07:45:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706597141;
	bh=FxsvfETjaPEQI8snXPU1qv7kZWitYTiHpzdkfTm0vnI=;
	h=Received:From:To:Subject;
	b=lRP5wqfhX9V/IqOzcCJ7+HtnietOccMFfiAIbBFa/UElj29ZEI+8smoeqU6R7tM3w
	 FGzKZdVMT5lpXY8AnaBFRKMZQi++JlVvMCbwpUsvOfYYtROUTpTCYLiKNLxo66mee8
	 T+vdFoV2jKC7E6JhGnWabpATY3NzaHWziN+x8qhE/uUCtXAFQAK1Z7+eOwIVUMTQUm
	 IfkMWt9qtooHt26Ac+ilqUJLQiOUpSYqYhQrnJUeYhRcwkv3rzLzr/yix4l49yEkSV
	 sbrsG7Qp3cndkyCUZer8lmKurlubpf66tbrkrNVU2qtWHSsyKOVY/MWMo1ffvMh40n
	 JWOdoZatFQumA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id C56CB7F9A0; Tue, 30 Jan 2024 07:45:23 +0100 (CET)
Date: Tue, 30 Jan 2024 07:45:23 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Peng Fan <peng.fan@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] gpio: vf610: allow disabling the vf610 driver
Message-ID: <ZbibA9QbOn19AXcn@gaggiata.pivistrello.it>
References: <20240124205900.14791-1-martin@kaiser.cx>
 <20240124205900.14791-2-martin@kaiser.cx>
 <20240126122719.GA13659@francesco-nb>
 <ZbgX-HGjM5fdftCG@v2202401214221251712.nicesrv.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbgX-HGjM5fdftCG@v2202401214221251712.nicesrv.de>

On Mon, Jan 29, 2024 at 10:26:16PM +0100, Martin Kaiser wrote:
> Thus wrote Francesco Dolcini (francesco@dolcini.it):
> 
> > On Wed, Jan 24, 2024 at 09:58:57PM +0100, Martin Kaiser wrote:
> > > The vf610 gpio driver is enabled by default for all i.MX machines,
> > > without any option to disable it in a board-specific config file.
> 
> > > Most i.MX chipsets have no hardware for this driver. Change the default
> > > to enable GPIO_VF610 for SOC_VF610 and disable it otherwise.
> 
> > > Add a text description after the bool type, this makes the driver
> > > selectable by make config etc.
> 
> > > Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for GPIO_VF610")
> > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > > ---
> 
> > >  config GPIO_VF610
> > > -	def_bool y
> > > +	bool "VF610 GPIO support"
> > > +	default y if SOC_VF610
> 
> > any reason for having this default y for SOC_VF610, but not for the
> > other SOC that uses the same variant (i.MX7ULP, ... ?).
> 
> Ok, it's probably not as consistent as it could be.

..

> Does this make sense?
sounds fair to me.

Francesco

> 
>    Martin

