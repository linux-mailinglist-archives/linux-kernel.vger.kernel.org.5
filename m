Return-Path: <linux-kernel+bounces-63542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2414853103
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E472283875
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AC546444;
	Tue, 13 Feb 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="XZpp7W7g"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E54F60B;
	Tue, 13 Feb 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829009; cv=none; b=jzJM+iNfOodIWGu038SjIiYYC2F2KLFE0ZzafAPrzxv+cFdw/OHJd6YbnEmVFmzLF/WE5gXyTO4H3C7+ajy1w4HK1N5+7LaVEmuiz/fxahW7OCYfVHZbDNsBECGIcl+bQZxjQh5wbJZ4DOpycIAYLhXFPu6Q10dX1+j6DhN6emw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829009; c=relaxed/simple;
	bh=qF7tMH7G9DibHjOZH7dai6/rsAP4RyQAquo8YwpVoc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKz2A47tT9jT+CNyNGgPGQz4hYt8xxxzdCa1idUVFZ13Guj/BTISfKo+d+3lJcf75k+H74UqgWAoSjgkPnxGxvFF1zi3R9qNvJ/hBC59DwJBHofORnvlYqImc+fYK3dmWEKD3iElvI4QiaZMcTHbt8qwtMlhEkH9+qcre9scrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=XZpp7W7g; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id CC0B86033F;
	Tue, 13 Feb 2024 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707829006;
	bh=qF7tMH7G9DibHjOZH7dai6/rsAP4RyQAquo8YwpVoc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZpp7W7gkKCvNQchCC9YPe/SoU7WmThjjmxwQmy3W9OpO84HYW/5tpiudNjay3nwr
	 o6HJr0lHXT4+iCioK0ncydUOKoFf+Ur50oPZEmWZik/+wBHNcOud8syCM4A7r0wglW
	 6EybxEPUYyhj1ldRiSooYcD2JmxptKLnMSkhvQxN2cIwwsfqDFPAQ439WP/xSQ2eDm
	 U9SSGdSYQLyo+zuvoOPVEjdygrs2rmXX1Hj9XvrrQc+xCPIJczkBZAbV5z018ZUh3H
	 SXHaKihsc62/hm5omTHJx9FtqsQ3irYuoCxSwmqIyisbZu8pWrd6+9QwgwsyYSoasC
	 kGSyDHYBrXAow==
Date: Tue, 13 Feb 2024 14:56:18 +0200
From: Tony Lindgren <tony@atomide.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, aford@beaconembedded.com,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: omap3:  Migrate hsmmc driver to sdhci driver
Message-ID: <20240213125618.GG52537@atomide.com>
References: <20240213124146.202391-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213124146.202391-1-aford173@gmail.com>

* Adam Ford <aford173@gmail.com> [240213 12:41]:
> The sdhci driver has been around for several years, and it supports
> the OMAP3 family.  Instead of using the older driver, let's finally
> migrate to the newer one.

I think we also should do these to avoid incomplete conversion:

- ti,dual-volt property can be dropped

- ti,non-removable should become non-removable

- ti,omap3-pre-es3-hsmmc probably should not be needed with sdhci

Regards,

Tony

