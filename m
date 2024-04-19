Return-Path: <linux-kernel+bounces-151496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E88AAFA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0DBB243CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7612C81F;
	Fri, 19 Apr 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="m5+1eAEJ"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC912B141;
	Fri, 19 Apr 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534190; cv=none; b=eIsSuVBgEHa+UlW2U4DUePTUD5j6irbgcelw9gel5YHhx4rIYDuMN8abNc+72yEvJ6/7xqgogikahmmGMo3ax1hOr70cH5kYPSIeSDdayYdt4eOnU8SAa3KBus7IdDyTrthxHBO6ANdCPV4COGgF/HG5ryOdHAcyFqNLcro0Ch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534190; c=relaxed/simple;
	bh=Ao+6HPE1Vskkt49HDiuaB/xLvWW49nY4+8hJXaqEBIA=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=N8mQqQ9n2bLll4oVliK9E0SpQy3kdCd83nFRj498iE63C4Dbx064QQcYADcyKydfLk7/81HdZYyiIqKCNJm9t6JFbfJXcMoCokHPlDd/eqRAWixLt0zTKocIVUI9JMu7PfHv4s1Jpv5aKzHE1dYPcW+gB0NHhQJGrz40qf8vxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=m5+1eAEJ; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=/SWo5T27HPZBjevRWtDoRJYaikHCKvINDhNye9BXHcg=; b=m5+1eAEJeajoC+i2udjQOm/4DR
	ZNrHejjMiqEaL5Ss5yhC/p9Beuczp8gxFkNdgi7U3AsVPGmqc6QRI0qgNtxd9/y4MQJ9xPfmGjnLc
	H6Fo0JtGvdRBvmd67EYVcnV31WUZvSTLxxwZfVa79KH0JBEKs0hA/2SzNmAXWGhYIiPE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:48460 helo=debian-acer)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rxoW3-0002rg-Qg; Fri, 19 Apr 2024 09:43:00 -0400
Date: Fri, 19 Apr 2024 09:42:59 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: Konstantin Pugin <ria.freelander@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Lech Perczak
 <lech.perczak@camlingroup.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Message-Id: <20240419094259.4257fefba753f6bd5962720c@hugovil.com>
In-Reply-To: <20240419124506.1531035-1-rilian.la.te@ya.ru>
References: <20240419124506.1531035-1-rilian.la.te@ya.ru>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -2.2 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v4 0/3] add support for EXAR XR20M1172 UART
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Fri, 19 Apr 2024 15:45:00 +0300
Konstantin Pugin <rilian.la.te@ya.ru> wrote:

> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
> it has additional register which can change UART multiplier
> to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
> flag to guard access to its specific DLD register. It seems than
> other EXAR SPI UART modules also have this register, but I tested
> only XR20M1172.
> Yes, in datasheet this register is called "DLD - Divisor Fractional"
> or "DLD - Divisor Fractional Register", calling depends on datasheet
> version.

Hi Konstantin,
it would probably be a good idea to also add the device to the list of supported devices for this driver in the Kconfig file.

Hugo.


> 
> I am sorry about too many submissions and top post reply. About second -
> I do not know how to reply properly to this ML from GMail phone app. About first - I just
> get very good feedback from Andy Shevchenko, and want to fix his review picks ASAP.
> 
> Changes in v2:
>   - use full name in git authorship
> 
> Changes in v3:
>   - change formatting of commit messages to unify width
>   - rework commit messages according to code review
>   - add XR20M117X namespace for EXAR-specific register
>   - do not use UPF_MAGIC_MULTIPLIER for checking EXAR chip,
>     use s->devtype directly
>   - replace while loop to fls function and expanded check
>   - sort compatibles
>   - reformat multiline comment.
> 
> Changes in v4:
>   - rebase onto tty-next branch
>   - added Kconfig mention of the chip
>   - used rounddown_power_of_two instead of fls and manual shift
>   - used FIELD_PREP instead of custom macro
>   - removed has_dld bit from common struct, replaced by check function,
>     which checks directly by s->devtype
>   - fixed tab count
>   - properly apply Vladimir Zapolskiy's tag to patch 2 only
> 
> Konstantin Pugin (3):
>   serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
>   dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
>   serial: sc16is7xx: add support for EXAR XR20M1172 UART
> 
>  .../bindings/serial/nxp,sc16is7xx.yaml        |  1 +
>  drivers/tty/serial/Kconfig                    | 18 +++---
>  drivers/tty/serial/sc16is7xx.c                | 62 +++++++++++++++++--
>  drivers/tty/serial/sc16is7xx_i2c.c            |  1 +
>  drivers/tty/serial/sc16is7xx_spi.c            |  1 +
>  5 files changed, 70 insertions(+), 13 deletions(-)
> 
> 
> base-commit: c6795fbffc4547b40933ec368200bd4926a41b44
> -- 
> 2.34.1
> 
> 
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>

