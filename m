Return-Path: <linux-kernel+bounces-133362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5E789A2DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CFB28870B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893617164F;
	Fri,  5 Apr 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="t33EO4xO"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F029163A97;
	Fri,  5 Apr 2024 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335690; cv=none; b=a/+9i3g7LrMlcS7AKcFSMNGDR0yE70VUcDsVhmvV7l2h2CqQ2Vfu4hdd64IH7EE3o2dG49oVM4+OteQbz8tT9C+uOfuunnkE5+yZljl5TPQGGU1s4R1OnY/cnRafGFYPYLkMW6Rs9D/7ovT+GYb69iY2qX8mJl1H4llKCRBAXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335690; c=relaxed/simple;
	bh=Rca1o2FBhj6lgrKzncw2lDGKtrVSO+XtFw9fsH7yT8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCnTyj3IpTPpSWfOFz7tPACZ+8zE5UP4PAHcoDSndy3VWmpgE/hqBD/UwoRf9nun1MkrfxLNKND5SSmZlEY3bfk6RE4AX3KQ5QjGLrAJSypsNU8zATl3/RKDShIYoPUfLZ33PQ9o4wfUzPneD/QKfZERh9MkLvPs/FEyNPlJXik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=t33EO4xO; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 822EA1F8F7;
	Fri,  5 Apr 2024 18:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712335684;
	bh=foR7bmaRUcq8x5BtLYzCdRDc3wu+vH8F2zTuBsXYaNc=; h=From:To:Subject;
	b=t33EO4xO6wGe8mGOF++zT32IG9JaZc9pURFgkQmHbtI5p+AIE4VSEK76Hl3DuXXEP
	 RK8ipqm4UWZRHEahyGwrUoABCK+hRDPkV3o7HB2xc9e2uf7oNLIE+sDiD3rIpcY5Go
	 L3DRcwm/E/WkS+wOWrE/L0tCd1/BLsp2Kz+I80SbJrSVVPbWHysX1xgPMopINFmWqo
	 B1olPRSGsUQOfBtDH46HZf5bb7kHvbEMVS2L2EvU3Z+OUk8fPQu2pprxJnXHqyZVIT
	 Yx+PLRHeE4Ey0P/2Wziw7mXHHyGcTqiz4nCWHv5g25A0TvRnBdiMO9+329TWhB/Bw2
	 J6hwWy18bIyPg==
Date: Fri, 5 Apr 2024 18:48:00 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/4] arm64: dts: freescale: imx8mp-verdin: replace
 sleep-moci hog with regulator
Message-ID: <20240405164800.GA5994@francesco-nb>
References: <20240405160720.5977-1-eichest@gmail.com>
 <20240405160720.5977-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405160720.5977-2-eichest@gmail.com>

On Fri, Apr 05, 2024 at 06:07:17PM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The Verdin family has a signal called sleep-moci which can be used to
> turn off peripherals on the carrier board when the SoM goes into
> suspend. So far we have hogged this signal, which means the peripherals
> are always on and it is not possible to add peripherals that depend on
> the sleep-moci to be on. With this change, we replace the hog with a
> regulator so that peripherals can add their own regulators that use the
> same gpio. Carrier boards that allow peripherals to be powered off in
> suspend can disable this regulator and implement their own regulator to
> control the sleep-moci.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


