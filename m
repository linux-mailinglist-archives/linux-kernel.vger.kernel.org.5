Return-Path: <linux-kernel+bounces-144754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D3F8A4A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7761F26419
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7044137142;
	Mon, 15 Apr 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="txcTHLnK"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F135364A1;
	Mon, 15 Apr 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169400; cv=none; b=N3tBoLany8wQSWREpoxjFm+BMutqDeeIFd27mfnF3prhyyebXqLD/RVbKmrZ8YNWH0GUHEsdPZRhu6QUfIlxCpG/+RV3mESKYDeMowu1mm5HKCep/baVHGIERYKUlFwv2yObIMLc2ZQyEb97+NIirtcK5b3dxYEB90FfYQeJkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169400; c=relaxed/simple;
	bh=k43CipV8ZHSfpduPM45MpqkCIYdzmykelApczgqGy3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czoc/oPlpejsWDvkF6ezcvSRZcsod+MV42DmvtmcWGX+TJMVqL9SFOiODnaN7PTLE2MMMrOD5/wgRXTUXZhuB+11XfX+YgNHALG5ms6SkSRtOkvI/ir6JFCwJQbuq5q78W/cG8AXyBaaz2mGimO/9pkL+qS5TWDeyzVpN/wPpA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=txcTHLnK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BSJeJ5B1I88yxnyki1y91ceWqhSeop2Eza3ElbkRR1c=; b=txcTHLnKJi9KZQYV3Spam/Qcd7
	nQdqTA/llna3f5QWvsBb500ayPp8XY7VYH7Iyr3IDpVwCZjuo25PNp7h02o+9oRZmHDhOBhm6D7WZ
	0ShvMAmTYwtCgoaG1uUi7gwz/PyNAL5Jl58+PauQinJoZ56N82WdgxB96rB1m9Via+Hpymk4bLl40
	JmlAl7Q35cel89jG0ONxsvDwFuq9w8Z6QCXDGnK2mfSVOpoNO/QfHy03TZK8knjKLaa6JB/uirHMU
	y+MUiB3gGx1pLjIQSaxWvqhana82u0ByAnF5IimKbEME8tMNxwXUAb/qcD32orAkVG/CWuzPlaq4s
	DvxDNO1g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50578)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwHcN-0005ld-1Z;
	Mon, 15 Apr 2024 09:23:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwHcN-00023Y-49; Mon, 15 Apr 2024 09:23:11 +0100
Date: Mon, 15 Apr 2024 09:23:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: richard clark <richard.xnu.clark@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] sdhci: Fix SD card detection issue
Message-ID: <Zhzj7+nm8q03+p4g@shell.armlinux.org.uk>
References: <20240415070620.133143-1-richard.xnu.clark@gmail.com>
 <52c08a01-8357-44dd-b727-a06438ec6c30@intel.com>
 <ZhzVmmndefd5zDFh@shell.armlinux.org.uk>
 <CAJNi4rO16FDmRUCWyK=+DF5TbfryJLsX3VUN3j1mAeas7Rh84w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJNi4rO16FDmRUCWyK=+DF5TbfryJLsX3VUN3j1mAeas7Rh84w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 15, 2024 at 04:17:14PM +0800, richard clark wrote:
> On Mon, Apr 15, 2024 at 3:22 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Mon, Apr 15, 2024 at 10:18:39AM +0300, Adrian Hunter wrote:
> > > On 15/04/24 10:06, Richard Clark wrote:
> > > > The mmc_gpio_get_cd(...) will return 0 called from sdhci_get_cd(...), which means
> > > > the card is not present. Actually, the card detection pin is active low by default
> > > > according to the SDHCI psec, thus the card detection result is not correct, more
> > >
> > > SDHCI spec covers the SDHCI lines.  GPIO is separate.
> >
> > ... and the key bit of information that should be mentioned is in the
> > case of a GPIO, the GPIO library can be told if a GPIO is active-high
> > or active-low in either firmware or via the GPIO lookup data, and this
> > should be used instead of drivers inventing their own "quirking".
> >
> Agree! But unfortunately, it seems I can't find the right place to
> handle this from either firmware or via the GPIO lookup data. Will be
> appreciated if any suggestion about that?!

If you're using DT, then, for example:

        cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;

is all it takes. If you are using firmware then GPIO lookup data isn't
what you should be using. I'm afraid I don't know the ACPI bindings for
SDHCI.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

