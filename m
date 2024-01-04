Return-Path: <linux-kernel+bounces-16685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F682426F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED471C23F55
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C640F224D5;
	Thu,  4 Jan 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y8rRXlep"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256121343;
	Thu,  4 Jan 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y1A8fgZsiIjsazqh2xXbSQAE7toMo839MhQ2MSFa1Ik=; b=Y8rRXlepBxDcgCzTA7uGpVud/D
	k6UiLHKLWjtAi60KxLwieZ5dGpeTkkKhx8hLP2gQ1a/2yP/23fNx52Ni9hMfIArOoaCiqHF649NrL
	/UrUYIc+HmCWT7z4WLOR8hICBXldkNSVsH/VEYFjoL7dni5lc4IeWVVdAcWGLZ3GPxfk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLNPd-004LdL-03; Thu, 04 Jan 2024 14:05:29 +0100
Date: Thu, 4 Jan 2024 14:05:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gan, Yi Fang" <yi.fang.gan@intel.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Choong Yong Liang <yong.liang.choong@intel.com>
Subject: Re: [PATCH net v3 1/1] net: phylink: Add module_exit()
Message-ID: <fb1cc3a4-8615-4cee-8fe7-29966c4cb7c7@lunn.ch>
References: <20240104101255.3056090-1-yi.fang.gan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104101255.3056090-1-yi.fang.gan@intel.com>

On Thu, Jan 04, 2024 at 06:12:55PM +0800, Gan, Yi Fang wrote:
65;7401;1c> In delete_module(), if mod->init callback is defined but mod->exit callback
> is not defined, it will assume the module cannot be removed and return
> EBUSY. The module_exit() is missing from current phylink module drive
> causing failure while unloading it.

This is still missing the explanation why this is safe.


    Andrew

---
pw-bot: cr

