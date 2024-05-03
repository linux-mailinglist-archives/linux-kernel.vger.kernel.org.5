Return-Path: <linux-kernel+bounces-168072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68D48BB34E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A4B1C21B23
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7294F158D9D;
	Fri,  3 May 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="M/Z9Mozo"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198F2E646;
	Fri,  3 May 2024 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761207; cv=none; b=nODRKnBUDeffKTrZLQuxMlLGdMStBtQ9ozv5o/553TIKE+iIXiD9ucNUkhtNqr/SD8FgRBIzJ7LDzliqjluene/YgRsS7cTpbCoaG8xgPPXVT41sh9XofxRLtB+XrtSeXxtAUDbyoJ03fo2XVbCJDcQmavbKYp5jDulcxlyMWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761207; c=relaxed/simple;
	bh=22XhEY7vXhT21sOWfVvwQyhmCuaRe5IA2N+3Oas/3Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4vbEyyEBsrZE9ZXdVNjXcJUrzXVIdTJDFVEbHY9AJMBcQZA7RjLA22d5hM75JvQvoum0yOhzklx0M37Y/ghpofPXLTcQmzRKToDaWzNBG4zwrhOhDkPDrt9aRwUlwypWwq3fHiyex77/bs+Q9SNzgVkLpCy8+31TwUc0jVFs2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=M/Z9Mozo; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714761185; x=1715365985; i=parker@finest.io;
	bh=v7kJzyUvZiR5tE18FRC14zJTkTgmWaOraudEp3nzKek=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M/Z9MozosaYDT++n7HDh8bNpKhJDF4kwBth1ZoRvKfaD8LkIEj86DwPl0kET8uU4
	 Y/VTiOnBfZ+yxMQCVAvS0eSZ8p6Xfvf/nNL69mToV3oARFasn9mNH0UWV1lwagJog
	 VCIlGyYip7ToVubwuzKOWQ2d+gQliKuHoHZfvP7ofgxYNKUYLPGmUDYS7hbNkqHe0
	 cc0rCmvqBZE+ptHdGO+IluDmEHqkdlu5BjLEM3f1hBKxWEQydG5uTRodsoGjpeCZ3
	 qTdLkQP9trMpAv7M0+h7jkuo1IN/nJVcOYTE7IQ7QHjqOmziTL7TDcQwse9ekbF/O
	 rOEGDjIuiUdQttv3RQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M6SuT-1ss36g0mwF-00rxd0; Fri, 03 May 2024 20:33:05 +0200
Date: Fri, 3 May 2024 14:33:03 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <20240503143303.15bf82bc@SWDEV2.connecttech.local>
In-Reply-To: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F1IeiN1k56yuKR+6PWmO0mM4xoZZm3//U46G+/nOhE+QBjJcUMR
 dDFUZPQ2RwW0++HvTVp9vFIhjKz2ac0IQAg5wPMxaFvrGzGwE+BZRtneE++B+69+DXXUQcX
 RzGk8ZA4Ci3r5PGBM5mf2jgIbsltIm3k6vYpfQDcLQlRVJ1nmjR/6MtnWZn5duCUMOg46tg
 a5T/QpiqDJQnmwLvRNlew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z6tPXeVmnlA=;EnWuVFXag5b+89g7vcHid7uBS0j
 cJzBLP0zciG67QYq4nXDKis0mdiLlNZaUC3/vTuH7zqpaw5RWOT/7igoO5UYHavWrzDc1Jfkk
 Ql5I4PDsBM29DCFWNyQKQ2RbHfiLWMoo9p4yMr6xtjJAcOc0X99xO2NKZgEUeIp3HrAuy3zk/
 c+QSzzPN8wnMwlgOaFfYww7qU6QhmYBFAPB+rFzqbAPF/cNKwlPGUERqdjXlr2lJvr5WRm+Y7
 lTLFYFTOI2edV+d71/pg+7YBoNQggs3dxZd/VLD3jzu9+EWW99zUQcIR6l87lwoxLKo/Ecw1r
 oKCSuwVCNu6l9LNlcCH/JsgZfCbAeOTa8j++AzlqwhAj+0XmcIfHrUss3MeyykzLxQV7Rda27
 GrUArWkw4jcDjUfe5B3oCbuI2rIZRTXBXFIz8uCuQZFbm4KYwmp/Hg+2e+Sanr5rq1s721rmK
 rvkaZcVdeX0ShaIFwLQRm2COkO6pUBaik0fKNxtDl8d2w6XaZvsMTVI41aZphFkQJ7qMopCQP
 JLEImCKbYDh6wRc4RU1HVKtEE9q7u9QdqHPbOXtV0SnOnRcAr7N88rEZ9VHlyLg5He8R+dq79
 bDjOJW6YXKslrUOKNdYgItuyL7qcWr/N7br+Vzty+FFSLg0GiHb7GGRM1hVwQGodnMenE2fYS
 PG8rWuidwUpAzW2RvfBZLCMB6Zb0xt/dt8bytnmKcYXWYPd5+TrwI9y3sYDxrQPOiDmMTSoCF
 qIPOubzqyi+7UL+AkouqQodqKoXjvuRw4ivsr+0koqQimsZM66Vm5M=

On Fri,  3 May 2024 20:15:52 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> After a rework for CONNTECH was done, the driver may need a bit of
> love in order to become less verbose (in terms of indentation and
> code duplication) and hence easier to read.
>
> This clean up series fixes a couple of (not so critical) issues and
> cleans up the recently added code. No functional change indented by
> the cleaning up part.
>
> Parker, please test this and give your formal Tested-by tag
> (you may do it by replying to this message if all patches are
>  successfully tested; more details about tags are available in
>  the Submitting Patches documentation).
>

I was able to test the Connect Tech related code and everything is
work as expected. I can't test the non-CTI related changes but they
are pretty minor.

Tested-by: Parker Newman <pnewman@connecttech.com>

> In v2:
> - fixed the EEPROM reading data loop (Ilpo, Parker)
>
> Andy Shevchenko (13):
>   serial: 8250_exar: Don't return positive values as error codes
>   serial: 8250_exar: Describe all parameters in kernel doc
>   serial: 8250_exar: Kill CTI_PCI_DEVICE()
>   serial: 8250_exar: Use PCI_SUBVENDOR_ID_IBM for subvendor ID
>   serial: 8250_exar: Trivia typo fixes
>   serial: 8250_exar: Extract cti_board_init_osc_freq() helper
>   serial: 8250_exar: Kill unneeded ->board_init()
>   serial: 8250_exar: Decrease indentation level
>   serial: 8250_exar: Return directly from switch-cases
>   serial: 8250_exar: Switch to use dev_err_probe()
>   serial: 8250_exar: Use BIT() in exar_ee_read()
>   serial: 8250_exar: Make type of bit the same in exar_ee_*_bit()
>   serial: 8250_exar: Keep the includes sorted
>
>  drivers/tty/serial/8250/8250_exar.c | 459 ++++++++++++----------------
>  1 file changed, 203 insertions(+), 256 deletions(-)
>


