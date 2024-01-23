Return-Path: <linux-kernel+bounces-34833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032D2838818
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359D81C220F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102F52F71;
	Tue, 23 Jan 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IipoaWVK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B1810;
	Tue, 23 Jan 2024 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995643; cv=none; b=pGaaqyQhm7c8f/keLCjcfZIFr56T7SLLWa2CN2vWt9wIoaW6ra84nS2LcMWl0Sx5C3N3rspG3Flh3y9/18csUSRwa5J1LQjrRXPVCsQvAItlazm+mjazXPapPi9J/YFGYjGAvn/9PDVHsmFDic6cm8slrLniqkoZIvhSCWtyRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995643; c=relaxed/simple;
	bh=ZoqLbtBF8i+gzadYvqr5JJ9kHSwfg9TbADroP5aIfWc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d25tqcZgHq3fXQU8vCHbw30NlRwfbr1z04kKe8pP9hFZiegTPSNLk5s+fYyLwK0wJs0vgJSiZPSDGJj0wh/CiYzfcY0pEOUVUamPkCu1j7cquam6z92dZUxvKp5jWGadF54fwg0p/IBILUsre4SsN53FUCq31FdAv1IjS07J+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IipoaWVK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705995641; x=1737531641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZoqLbtBF8i+gzadYvqr5JJ9kHSwfg9TbADroP5aIfWc=;
  b=IipoaWVKjgHjdqfmkSe5jj7suz6mk5xWFg4R7ir7a7Nkw3uh/zHwKgJ6
   hRl1QKFHmdxPyUc7fzCOv8WPvEaneinhvU+Vzxp+JGFsjTB5GOLJ7Y/Fb
   LZMyg3Dq5QYw2y6shoe6u/p9NjJaJk7F9vDGE0B0VwdsvVDLlq0SWfsXJ
   FENtmxR5Xf7ChMv9Xyy1DBfh5dsYHpxknoU/ZrDqlPEbaf1WB/u1lIpDp
   Ni6v5euIXs1ecuqTHMqHgFsabl2pChS+4f97YO43fBdO2SNkLyaQsN0cF
   aHbiCOabi05thctaZRrKh91KPXn8ajj+Eq2yXedQXk8YLyoSr5LUJjYsV
   g==;
X-CSE-ConnectionGUID: w/pk/xxkRa+jFa3DU5zIZw==
X-CSE-MsgGUID: hyNmLgQ4Tda7JxR6YODDzA==
X-IronPort-AV: E=Sophos;i="6.05,213,1701154800"; 
   d="scan'208";a="15629781"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 00:40:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 00:40:24 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Jan 2024 00:40:24 -0700
Date: Tue, 23 Jan 2024 08:40:23 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Breno Leitao <leitao@debian.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <abeni@redhat.com>,
	<edumazet@google.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Claudiu
 Manoil" <claudiu.manoil@nxp.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>, Paolo Abeni
	<pabeni@redhat.com>, <dsahern@kernel.org>, <weiwan@google.com>, "open
 list:OCELOT ETHERNET SWITCH DRIVER" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 14/22] net: fill in MODULE_DESCRIPTION()s for
 ocelot
Message-ID: <20240123074023.pu5hqjarvhawufmc@DEN-DL-M31836.microchip.com>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-15-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240122184543.2501493-15-leitao@debian.org>

The 01/22/2024 10:45, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Ocelot SoCs (VSC7514) helpers driver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> ---
>  drivers/net/ethernet/mscc/ocelot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> index 56ccbd4c37fe..12999d9be3af 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -3078,4 +3078,5 @@ void ocelot_deinit_port(struct ocelot *ocelot, int port)
>  }
>  EXPORT_SYMBOL(ocelot_deinit_port);
> 
> +MODULE_DESCRIPTION("Ocelot SoCs (VSC7514) helpers");
>  MODULE_LICENSE("Dual MIT/GPL");
> --
> 2.39.3
> 

-- 
/Horatiu

