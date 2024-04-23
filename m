Return-Path: <linux-kernel+bounces-155773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D28AF6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16191C21CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B5F13F452;
	Tue, 23 Apr 2024 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="DP04iC5C"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8CE13E3F8;
	Tue, 23 Apr 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713898779; cv=none; b=DOWojuCb/94TBaJSYDq7lwyYBaUTIx+SywsWQyshlhOCEFJO2LtnKpQkaBwQ1cRvRGGSF9uA7XLkPSdpA2KczNpxkk2tmeBc9uQhRc2acZz+HuaRefxMIf1RyLqRV7Jn+nA2Jlq0yb6t6g4cUHp3wYZIICSydZG+dlmXIlMpThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713898779; c=relaxed/simple;
	bh=T7XszNRd8d+6SJEaBpiVinIwTQ8ta84/yRO4o6mv+wA=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=UeqtRV608oN2D/wZ38yAdCBAi6QDVi9oaiqcJHmWxtd8sySs5S3w8ED7vlhhxNNEI+z0RgEns8gBz8gQCF2RT2T8weBumhExRCONubC4uI3FVpWsV6ekvCZ1ajZSFIv/mnMV3dOJJQPObsaNblxA6MxoE1BiH5DhqYwk4u+HLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=DP04iC5C; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=71XbR04R1YkOfno5gJ7a+xFyEwpBdthJL1F3pof/8tw=; b=DP04iC5Ci929JBdYjlKl5/6yNs
	t/0uKrH5tUprvgZl2veE/dRXKBLuED2FrAMpBXWART1pqWxNSPZC9Cd8Xuka25jHo0GjSWH4Oc0iC
	Eth3QIjVAbMrticl2F4RJOu4loQ1g93Kj6ADHoIhV9dLTUCzcwVEWG0Ez4mjSQCdk3vQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:53768 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rzLME-0000Qp-VJ; Tue, 23 Apr 2024 14:59:16 -0400
Date: Tue, 23 Apr 2024 14:59:10 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Konstantin Pugin <ria.freelander@gmail.com>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com,
 robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
 manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
 u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 Lech Perczak <lech.perczak@camlingroup.com>, Ilpo =?ISO-8859-1?Q?J=E4rvin?=
 =?ISO-8859-1?Q?en?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Message-Id: <20240423145910.c3141dbd01665213526b54fa@hugovil.com>
In-Reply-To: <20240422133219.2710061-2-ria.freelander@gmail.com>
References: <20240422133219.2710061-1-ria.freelander@gmail.com>
	<20240422133219.2710061-2-ria.freelander@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -2.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v7 1/3] serial: sc16is7xx: announce support of
 SER_RS485_RTS_ON_SEND
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Mon, 22 Apr 2024 16:32:13 +0300
Konstantin Pugin <ria.freelander@gmail.com> wrote:

Hi Konstantin,

> The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, but
> after the commit 4afeced55baa ("serial: core: fix sanitizing check for
> RTS settings") we always end up with SER_RS485_RTS_AFTER_SEND set and
> always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT, which
> breaks some hardware using these chips.

it took me a long time to properly understand what you meant in your
commit message. In my setup, I have the property rs485-rts-active-low
defined, and couldn't reproduce the problem. It is only after I
commented this property that I got a warning about the "invalid RTS
setting"... I also got it by defining rs485-rts-active-high.

I suggest the following changes to the commit message:

----
When specifying flag SER_RS485_RTS_ON_SEND in RS485 configuration,
we get the following warning after commit 4afeced55baa ("serial: core:
fix sanitizing check for RTS settings"):

    invalid RTS setting, using RTS_AFTER_SEND instead

This results in SER_RS485_RTS_AFTER_SEND being set and the
driver always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT,
which breaks some hardware using these chips.

The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, so fix
this by announcing support for RTS_ON_SEND.
---

If you agree to these changes, feel free to add:

Tested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hugo.


> 
> Fixes: 267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
> Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 03cf30e20b75..dfcc804f558f 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1449,7 +1449,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
>  }
>  
>  static const struct serial_rs485 sc16is7xx_rs485_supported = {
> -	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
>  	.delay_rts_before_send = 1,
>  	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
>  };
> -- 
> 2.34.1
> 
> 
> 


-- 
Hugo Villeneuve

