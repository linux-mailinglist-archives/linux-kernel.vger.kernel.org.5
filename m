Return-Path: <linux-kernel+bounces-75336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE6A85E6C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784E51C2504A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3E785953;
	Wed, 21 Feb 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="lO+1jSA2"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72648593D;
	Wed, 21 Feb 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541717; cv=none; b=GER/VoBut7tW4gwKctUbq9Qw2eN3/BBanpnIMaAYnLUPS5QgkFQXcYXGCnVXUXtOu9X2anzNTbR72zAkxh7qgsTvqzHlFddZKqgHkHAoYjEGHK3AshwrRoclUszhG+oz/a58SwtcPAc18sIrUyhy9MG9EH4Rxe+UYwWecH8MD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541717; c=relaxed/simple;
	bh=5yFmU+7gBjh/6EdAcmQuHZaNUqH8peAPfvS5j1XIGsA=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=rNCIT7qfpI/LcnshNtH1dl+ZJEqFRKMPlOqAcBQUK4yz1ug/7djyYq5sfNmGX3/KohsvHjtKbCQx9nZBzlXfNeLMM9Iy71tbpLnewQlDGyDBwuTG6vdlGO/Lg4mRs/9YW6XIDpSv67dZIH41lS4T0ecJe/Yj+P8MADsixsHTWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=lO+1jSA2; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=Gx8Pfqp+y6ASQB8ZhO8FSQgg3ZRRiF9AlxCIvFk4iFE=; b=lO+1jSA2jFreXwBbqs36SCeJq5
	epTNSwwEakid+hzaoMpthjve+aKKe6/WwxDVL1s1np9EJpLPBvgD4DrOUzXPKaxkPx5Wk1Ln2AuNq
	s1tDXxdDTajNp0TJya8yXa9ylkrr9v2kVOC5SSntYWQOyZyAbb9BtTcO2mq+muLcyZis=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56330 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rcrk5-0000ah-NF; Wed, 21 Feb 2024 13:54:53 -0500
Date: Wed, 21 Feb 2024 13:54:52 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
 <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Paul
 Cercueil <paul@crapouillou.net>, Vladimir Zapolskiy <vz@mleia.com>, Thierry
 Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andi Shyti <andi.shyti@linux.intel.com>
Message-Id: <20240221135452.6fdeb71e60509cca1be016c3@hugovil.com>
In-Reply-To: <20240221183442.4124354-2-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
	<20240221183442.4124354-2-andriy.shevchenko@linux.intel.com>
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
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -3.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v1 01/14] serial: core: Move struct uart_port::quirks
 closer to possible values
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 21 Feb 2024 20:31:17 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Currently it's not crystal clear what UPIO_* and UPQ_* definitions
> belong two. Reindent the code, so it will be easy to read and understand.

two -> to.

Hugo V.


> No functional changes intended.
> 
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/serial_core.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 55b1f3ba48ac..2d2ec99eca93 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -467,8 +467,8 @@ struct uart_port {
>  	unsigned int		fifosize;		/* tx fifo size */
>  	unsigned char		x_char;			/* xon/xoff char */
>  	unsigned char		regshift;		/* reg offset shift */
> +
>  	unsigned char		iotype;			/* io access style */
> -	unsigned char		quirks;			/* internal quirks */
>  
>  #define UPIO_PORT		(SERIAL_IO_PORT)	/* 8b I/O port access */
>  #define UPIO_HUB6		(SERIAL_IO_HUB6)	/* Hub6 ISA card */
> @@ -479,7 +479,9 @@ struct uart_port {
>  #define UPIO_MEM32BE		(SERIAL_IO_MEM32BE)	/* 32b big endian */
>  #define UPIO_MEM16		(SERIAL_IO_MEM16)	/* 16b little endian */
>  
> -	/* quirks must be updated while holding port mutex */
> +	unsigned char		quirks;			/* internal quirks */
> +
> +	/* internal quirks must be updated while holding port mutex */
>  #define UPQ_NO_TXEN_TEST	BIT(0)
>  
>  	unsigned int		read_status_mask;	/* driver specific */
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 
> 


-- 
Hugo Villeneuve

