Return-Path: <linux-kernel+bounces-88134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7C486DDC1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D542B26F36
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4980B6A33C;
	Fri,  1 Mar 2024 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="we1dloiL"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6496A034;
	Fri,  1 Mar 2024 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283636; cv=none; b=tvJLZ0NNd86LFqmGZTvTuJmJp92csivTS5frpil+YqxdCO9YOuS7YmK+zovhigtD9gPgoX/kob+OKYSNSvjzB+P66WdtLNGU6owbyd1bsq7oFMziZ4tuggrY/fthaDkx3i5b2vRLrDpFLOVCqNwjCOmx71RggibsyTsT1811s68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283636; c=relaxed/simple;
	bh=oAFztLp/4jG5aPVuwccvklYKukOY5Xi/lceGKNTY+II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDPwDlwDpP4qd7pH8+qxHbiO58r+/aU9mDqJthN4Dk3Vhd+8WUadA/bppbCfxAVx7PiohlajggRPTcWsQt8MZUfJTgzXbGIyr8SMWZy4oUZf2vNqabDLvaFsGiWHDMjbCbRtXN4NM8cSUkp1/kywGGuzgAcKQ6bBYDGzjZYpceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=we1dloiL; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A8C872208C;
	Fri,  1 Mar 2024 10:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1709283632;
	bh=AEjfsT6r+Ol9iuZ3KRRaO59JjAWFeCrR2k+DPca4gDU=; h=From:To:Subject;
	b=we1dloiL7R8trMuVoMh8EhefI2DnPowzOV4bEK+vDJbAuAfChYkf+xBzkQ3lW5ILP
	 Hy0zUl5MZ8+7Y6PXSeIyu/lCEXVVM74HRr0rVA3dyV1JL+oXxV052MOmgvireEiD6o
	 KxnUpKgnE2nV/gv3V1+RcJLmR7PO/FP6JK8QhlMi4PeM3cZoi9FYHtdpSROHO/NQYh
	 nI5KEcdUg1A6w7jV7yhgmUs8B6JV7Zxo+O6qy55pGaa2yP0K5d6RARoxF5rc7YQS2m
	 0T9OtPoTsLUUDkT/DYrgDdTa25SXbwr+ho9XLHbuXM36l6vx2VnVMSSMUuGodYNxBV
	 09V7f5w1JUtdg==
Date: Fri, 1 Mar 2024 10:00:30 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: ti: k3-am62-verdin-dahlia: support
 sleep-moci
Message-ID: <20240301090030.GB6605@francesco-nb>
References: <20240301084901.16656-1-eichest@gmail.com>
 <20240301084901.16656-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301084901.16656-3-eichest@gmail.com>

On Fri, Mar 01, 2024 at 09:49:01AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Previously, we had the sleep-moci pin set to always on. However, the
> Dahlia carrier board supports disabling the sleep-moci when the system
> is suspended to power down peripherals that support it. This reduces
> overall power consumption. This commit adds support for this feature by
> disabling the reg_force_sleep_moci regulator and adding a new regulator
> for the USB hub that can be turned off when the system is suspended.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


