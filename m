Return-Path: <linux-kernel+bounces-148094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E659F8A7DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6FB22DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4698077F11;
	Wed, 17 Apr 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+EPyvmK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3A6F068;
	Wed, 17 Apr 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340879; cv=none; b=fASI1+h4s8zvVdAmEJ+la51hw+JEvFtWd0oywnbXI/Cl200dwuiteUWuEQBOA765zUxx8SpxyxeX0AJeRVOesgPsFDFYrCGIxGMQl8KCiD0lhKvaWFWDoeFlZOdRF6yQi92SBBL8aUAmHwETjUt79AbinRyVJNReGvVv/ecXPWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340879; c=relaxed/simple;
	bh=stFHSl8F/ZzKI0Ru1yFqLLar6pPPZF0zWrYDY45yiow=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SfnGFmPXoSbkTcgIXpeLoUMnHEWi/vOfSY1rDPwl1eWh48vZKXYKhsdRmuqicGzANxhRTfS0ySTQzrp2vq6dL7lVcpzKGIg9nMCZLoHE1NOgBoZ3Z2uDnr0wgAsIw3hhNGva0RFTHchPhiuUOs7i87xeYnMlt8AgAXHtkwkZOIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+EPyvmK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713340876; x=1744876876;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=stFHSl8F/ZzKI0Ru1yFqLLar6pPPZF0zWrYDY45yiow=;
  b=A+EPyvmKgVA5e4NEcCVyWjSoF3+ah1tKnpqBfHa+5yR0K4XBcmAouE71
   PnVGPeKXfFB8fdyzT/60hxB8Oa/oeSLDHbWzW/VCx/+A7SS72vgR9IMS2
   GSU6o40lyQeR9p7wjSbyL5Llg1qOdhEsavijGbtq+2nVisclUv6rOFMwg
   91aEn3kj6eZcKFX62akkdqUHHkWLxp+stxgklpdN+AROTHtNzErPVLqVw
   QBvTdEpNexWg7kbzOYKb0xoKXm6mmFEawExamwQorstXJZ5L5Tjkwe4cf
   kS+2tHPklgCp4yhNjSW90KhW8MU0KN3fh8WY3pt2NghnjEAPUf3y3VpwD
   w==;
X-CSE-ConnectionGUID: hChmdGuYRNyDM7f64FI73Q==
X-CSE-MsgGUID: tihl1K/hQGOLzylsB8ywCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26330373"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="26330373"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:01:05 -0700
X-CSE-ConnectionGUID: GmnSLvzTR8ygVDCc8CsRQg==
X-CSE-MsgGUID: JCuIQk/5STuYgExwZVwBew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="27096732"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.35])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:01:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 17 Apr 2024 11:00:59 +0300 (EEST)
To: Michael Pratt <mcpratt@pm.me>
cc: LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Wander Lairson Costa <wander@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 3/3] serial: 8250: Set fifo timeout using
 uart_fifo_timeout()
In-Reply-To: <20240416182741.22514-4-mcpratt@pm.me>
Message-ID: <67b8f469-6634-5e58-17cf-f66f7b9a225e@linux.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me> <20240416182741.22514-4-mcpratt@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Apr 2024, Michael Pratt wrote:

> Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> reworked functions for basic 8250 and 16550 type serial devices
> in order to enable and use the internal fifo device for buffering,
> however the default timeout of 10 ms remained, which is proving
> to be insufficient for low baud rates like 9600, causing data overrun.
> 
> Unforunately, that commit was written and accepted just before commit
> 31f6bd7fad3b ("serial: Store character timing information to uart_port")
> which introduced the frame_time member of the uart_port struct
> in order to store the amount of time it takes to send one uart frame
> relative to the baud rate and other serial port configuration,
> and commit f9008285bb69 ("serial: Drop timeout from uart_port")
> which established function uart_fifo_timeout() in order to
> calculate a reasonable timeout to wait until flushing
> the fifo device before writing data again when partially filled,
> using the now stored frame_time value and size of the buffer.
> 
> Fix this by using the stored timeout value made with this new function
> to calculate the timeout for the fifo device, when enabled, and when
> the buffer is larger than 1 byte (unknown port default).
> 
> The previous 2 commits add the struct members used here
> in order to store the values, so that the calculations
> are offloaded from the functions that are called
> during a write operation for better performance.
> 
> Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.

Did you actually see some perfomance issue with 115000 bps? Or did you 
just make the "better performance" claim up?

> Fixes: 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> Signed-off-by: Michael Pratt <mcpratt@pm.me>
> ---
> V1 -> V2:
>  Use stored values instead of calling uart_fifo_timeout()
>  or checking capability flags.
>  The existence of the timeout value satisfies fifosize > 1.
> 
>  drivers/tty/serial/8250/8250_port.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 5b0cfe6bc98c..cf67911a74f5 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2066,7 +2066,10 @@ static void wait_for_lsr(struct uart_8250_port *up, int bits)
>  {
>  	unsigned int status, tmout = 10000;
>  
> -	/* Wait up to 10ms for the character(s) to be sent. */
> +	/* Wait for a time relative to buffer size and baud */
> +	if (up->fifo_enable && up->port.timeout)
> +		tmout = jiffies_to_usecs(up->port.timeout);
> +
>  	for (;;) {
>  		status = serial_lsr_in(up);

Hi,

Is this the only reason for adding the timeout field? I think you should 
just refactor the code such that you don't need to recalculate the timeout 
for each characted when writing n characters?

-- 
 i.


