Return-Path: <linux-kernel+bounces-133363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5380889A2DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1351C21EDD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522DB17166E;
	Fri,  5 Apr 2024 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="eSfdcReK"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E21171664;
	Fri,  5 Apr 2024 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335695; cv=none; b=QfcRxJFF+ICC431H0Qu0slup0hdgXv6ETvjmh+6xvPho1WxbGlMi/RiK+oNT0mcE4GDzQSv/V8yJ+9hRw8I1DiUygujXGZZ/iTIb1i1TKSLhATCqSe/UH8XIyDU73e4XkNsuc4kR8IZt6esFiHOhK45LA6bnWbAdhFfdUzeKBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335695; c=relaxed/simple;
	bh=cRpxZRKNCTQ6AqlhM9ULdUw7ASsNjkRne4AMGt82I5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf5ySX/14fGMhethsAeSGjUbKG76zaEvbD8YBd2i5x9pKSTSqF5kSzsSjCFo/elvFyyN5VJjccXwJu+NzFTZarxAsdHWsUuI7n1Vuf73Dsw2K/7OyCuAEQws3aCXxEubSe1XIdKCDGGvScUrC/fJzOsixOMPQKFtwunoEANM5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=eSfdcReK; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EA4261F8F8;
	Fri,  5 Apr 2024 18:48:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712335691;
	bh=l6zV/h5btQbyVE4bWXF1ysGUW5eyMy2SadI9F0S3u78=; h=From:To:Subject;
	b=eSfdcReKl+jGTrhi9jT4tF+LjTzqsbkBdlAzvMv8UHU66k8dy+j1eIrCytu32K5xB
	 bwlE5XEHdltLSr2FC/JOq6S5b5SCqMqBqwVNQsm+H/5AK2cD54foZ5rVJeAsubgGbM
	 cHJCVgZcXfpVRRIVXEx1iwEEQrIdfDzmxWk84TllTeUMNP8p6m6qJBFiRzugU3qZZW
	 qs+csQak/kVtLan3Vm6haWhOTcLNXEsB3fNBgh5XlK+SkGr2Olv29wVttBc/qYqgnL
	 d54188o75o/MsnjdJ/29mTs2SCPdWzn7VOuiOK1zdqKeWdGp/+oNaY7Nee5xaz5E5+
	 InlGsKbs6rpmw==
Date: Fri, 5 Apr 2024 18:48:09 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 2/4] arm64: dts: freescale: imx8mp-verdin-dahlia:
 support sleep-moci
Message-ID: <20240405164809.GB5994@francesco-nb>
References: <20240405160720.5977-1-eichest@gmail.com>
 <20240405160720.5977-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405160720.5977-3-eichest@gmail.com>

On Fri, Apr 05, 2024 at 06:07:18PM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Previously, we had the sleep-moci pin set to always on. However, the
> Dahlia carrier board supports disabling the sleep-moci when the system
> is suspended to power down peripherals that support it. This reduces
> overall power consumption. This commit adds support for this feature by
> disabling the reg_force_sleep_moci regulator and adding two new
> regulators for the USB hub and PCIe that can be turned off when the
> system is suspended.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


