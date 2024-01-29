Return-Path: <linux-kernel+bounces-43549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12996841561
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFE6B238B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F4E159568;
	Mon, 29 Jan 2024 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tWyAS0DH"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CE158D64;
	Mon, 29 Jan 2024 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566074; cv=none; b=A/eIQi4fXCMFXOWOYTfWnfolXKPheHccAhMpi30AKclxAlVV+z4+aZ8OKAeE49lWHq11WgrZ5Gl1O73yOR2XcjjFouQOGxxlA4qHUFkZ8BV5+afVbnSJtrMhxwEco5WdKRz8XIHSvjAdu3rzkZk7r7TbTihgxcTlkDtpran5bH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566074; c=relaxed/simple;
	bh=wixU7yRV9NlusV5scNvEpbGvwOfBd/ohYhUmP1NlXiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlsYl1lGdve6NzzcLlCQraKl+SXPXiYrlmylxvBaElkiGYn/KAaYsX3IYlMoZcZcdbT1bZVILGudQl/mI0GLVvfvTpj6AOlD+wqUSun9NccbQKY7og+zqeDPgPBir2+fV5zfeAZzfbGmL8ph8CF+lYPQxYhH86ORFBgINVibJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tWyAS0DH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U0zcU69tdu8DwEXJakd+sl7ysMSDueWc4K7kpgFy5Lw=; b=tWyAS0DHWtAcTCL+NvUnXVK5Qe
	SzjIdYE+qwOitPiEE1nBArtmd+2eM1+1Rl3T0Mquny10IB3cOUhirGwe6GpoFCO9gbh0yEbtfCGCb
	VIvTzDPx1o8QAymnhmAVJVi7ZHJZ853bpBl4XTD64mM6nENcvdj9K6DdDNf2VuuwwaCD3hCs684xb
	oKQxUiM8aC/aIOyuvYSKwX0sOPCYOlSDwk2Tqi+op127EFOyaR4dSmnGWbmPAJXiGYB8gXp3hzPdP
	hpmwEnsckX5uuTKRHCfWFbttoOrGQihH7cO/eDkq2w1kM8BVf0K0qzQIcHpMnRdSp7Nj9dEVHhS5i
	a9ywdjIw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49220)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rUZn2-0000zl-1H;
	Mon, 29 Jan 2024 22:07:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rUZmz-0004t8-LT; Mon, 29 Jan 2024 22:07:37 +0000
Date: Mon, 29 Jan 2024 22:07:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1
 aliases to fix hctosys
Message-ID: <ZbghqTg9aG4g399d@shell.armlinux.org.uk>
References: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>
 <ZalMsJZKrpwncEDp@shell.armlinux.org.uk>
 <79f9bd25-a05f-43b2-8d93-5d51adae1824@solid-run.com>
 <24c24b0b-da49-4452-b6ad-64c4c2d20e11@solid-run.com>
 <ZaqIQ7X4/iI3jxtU@shell.armlinux.org.uk>
 <8d5bfef0-ced5-4f3f-a176-707b0dcbd0ea@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d5bfef0-ced5-4f3f-a176-707b0dcbd0ea@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 29, 2024 at 07:26:07PM +0000, Josua Mayer wrote:
> I have tried reproducing this on 6.7.0 with imx_v6_v7_defconfig:
> I use expect [1] to capture kernel rtc messages during boot,
> explicitly overwrite load capacitance bit to ensure
> regmap_update_bits in pcf8523_load_capacitance has work
> to do during next probe, and finally trigger software reboot.
> 
> On HummingBoard-2 I  have not seen the issue during 80
> reboot cycles, and on solidsense not seen during 25 cycles.

I think at this point we should put it down to something spurious,
or maybe it was specific to having run an older kernel, or something.

Unless it can be reproduced, I don't see much point in spending more
time on it - I haven't noticed it happening again recently.

That said, I tend not to reboot this platform very often!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

