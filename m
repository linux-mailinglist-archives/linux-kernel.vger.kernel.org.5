Return-Path: <linux-kernel+bounces-76011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD28D85F1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153451C231F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C7A1799F;
	Thu, 22 Feb 2024 07:33:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A453C0D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587209; cv=none; b=KK+7K4IeqdexE9K4Nxs6uMqCp5uW0B2UdNOawCuPaZ1yg75MzmIjJri8AALaFUhROaNGZbVUkngAEq+AZzKWGHkmDwY1Zjs+iFGAgUWXuhzD+QragO4TOOahF5ZwYWrEm05EfJNzYMLXaVtNu8M4q6bTPy361yqYc8yDe4JemsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587209; c=relaxed/simple;
	bh=gU6tfQ+cOAm8YbZZk/Hpe9xbq1OuIDBImVaJ5LnBC6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BucHROfpLZUOaTBHnGvpI2sSL7T4IP+ZX39gWcWY31veLeSoUnbQezZGxlvTfxrNH5h/Srxxf9BumH3/QJQ9XHYqBsrxLpRJeDmT1ZlP+n86H0KdTK64dnMvN8hlpTgsHWpfPcGzzEA8Ajjl12nyoal2kYWInNO9EAajtdv4gvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rd3Zt-0005o6-Nw; Thu, 22 Feb 2024 08:33:09 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rd3Zr-002Bik-IP; Thu, 22 Feb 2024 08:33:07 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rd3Zr-002hqY-1V;
	Thu, 22 Feb 2024 08:33:07 +0100
Date: Thu, 22 Feb 2024 08:33:07 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 1/1] net: dsa: microchip: Add support for
 bridge port isolation
Message-ID: <Zdb4s-Qo-9PnPVtZ@pengutronix.de>
References: <20240221093429.802077-1-o.rempel@pengutronix.de>
 <20240221175357.GE722610@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221175357.GE722610@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2024 at 05:53:57PM +0000, Simon Horman wrote:
> Hi Oleksij,
> 
> I haven't looked over this patch closely.
> But it does seem to have some Kernel doc problems.
> 
>   .../ksz_common.c:1905: warning: bad line:
>   .../ksz_common.c:1924: warning: expecting prototype for ksz_adjust_port_member(). Prototype was for ksz_update_port_member() instead
> 
> You can observe these by running ./scripts/kernel-doc -none
> 
> I'm going to flag this as Changes Requested in patchwork
> as typically this kind of problem gets flagged by bots sooner or later.
> 
> pw-bot: changes-requested

Thx!


Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

