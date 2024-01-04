Return-Path: <linux-kernel+bounces-16669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C9E824225
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57D71F2372C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8BF2231C;
	Thu,  4 Jan 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IIIPJc9Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC312230A;
	Thu,  4 Jan 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=em8656SBmFHuCoSI6Hw7pHiwOvfMbL7DUtlbPOdcosg=; b=IIIPJc9QzwaijPod1f+lYfIUlU
	AYiygKn9dmrcgfr6FR8efPlyPxk7oGMaN60icGgMu2P2bEcU69iCW1SSbkdk/5b7dVh1BiBOujbRP
	WUxVzR6jyKZ7V5NdAC/HyYy+R13rrQ3o4w8K3QiHH7J3Wk3BZ+QN0meADrxgLU1N2zq0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLNKd-004LX7-Ub; Thu, 04 Jan 2024 14:00:19 +0100
Date: Thu, 4 Jan 2024 14:00:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gan, Yi Fang" <yi.fang.gan@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	John Stultz <jstultz@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Looi, Hong Aun" <hong.aun.looi@intel.com>,
	"Voon, Weifeng" <weifeng.voon@intel.com>,
	"Song, Yoong Siang" <yoong.siang.song@intel.com>,
	"Lai, Peter Jun Ann" <peter.jun.ann.lai@intel.com>,
	"Choong, Yong Liang" <yong.liang.choong@intel.com>
Subject: Re: [PATCH net v2 2/2] net: phylink: Add module_exit_stub()
Message-ID: <b1b962d1-403f-41b4-9ef8-f2cdb33795e7@lunn.ch>
References: <20231221085109.2830794-1-yi.fang.gan@intel.com>
 <20231221085109.2830794-3-yi.fang.gan@intel.com>
 <0f85171e-cb9c-47dd-bb7d-f58537e24a54@lunn.ch>
 <MW6PR11MB8310E51E5EEDA8EE98BC37D4B967A@MW6PR11MB8310.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW6PR11MB8310E51E5EEDA8EE98BC37D4B967A@MW6PR11MB8310.namprd11.prod.outlook.com>

On Thu, Jan 04, 2024 at 09:45:47AM +0000, Gan, Yi Fang wrote:
> Hi Andrew,
> 
> The function phylink_init() is introduced by others.
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.6.y&id=eca68a3c7d05b38b4e728cead0c49718f2bc1d5a 
> The module_exit() is added by referring to
> https://elixir.bootlin.com/linux/latest/source/kernel/module/main.c#L738.
> Since the macro function is rejected, I will send a V3.
> Let's see if Rusell King has any comment. Thanks.

Please don't top post when using linux kernel mailing lists.

> > You are missing justification it is actually safe to remove phylink. Maybe Russell
> > King deliberately did not implement
> > module_exit() because it can explode in interesting ways if it was?

You still need to explain why it is safe to implement it.

    Andrew

