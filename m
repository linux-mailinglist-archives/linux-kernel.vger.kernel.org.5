Return-Path: <linux-kernel+bounces-112527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EF4887B33
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E69B20CC4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1907A50;
	Sun, 24 Mar 2024 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="glYVI1+v"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB663B;
	Sun, 24 Mar 2024 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711240196; cv=none; b=NwXJ0iHrzWiUgHQULzUx/ze3ZX0FK2JziIP+uWOX7TZOvUEpwDB/s0xDnmk0cq6Y3PPOnD7/2h0tJ1PZJk3XA4oHwLy+jKasQfa7Qmrg+rbaVOLV6uL4EnLR3ptksMOYVhubT4wuybZJ51Xhh4FtpbMd/56SB/amxKkgs/aOFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711240196; c=relaxed/simple;
	bh=hGA0pjESfcbSCju3TJsdHOFR1tokO3qHUenTDCHAAC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsOyzeZOJlZY7e3YbU6hVrcdSwyUXLMHXoWHxWlDC2U7zKaqhO6wD1ScZ+BljbRRgKxGVG621uxswSucGQu/X7xa/r+LiTLFAujbEa6Nd2JUBubf9iERobNRIDd2NxKpuYnw3FLHcbVO901aJUwaDgsZ+ml7LGn/SLGl7wLJuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=glYVI1+v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=utodYAxgZ6ASqBLu4FhUWyXcojcCXmq+kx0E9Y88w7s=; b=glYVI1+vBRKw99jYBcJe2Nckm5
	wF28eI7xrGwdTSXBvmUjc2YEs1BcOTuUClUrYQUZL0bpF7VfZ+tJplhnWVEdboi9eRhTGQhFroNkn
	r9NjTcghnBAq7mOdszxAB7tdEwYajqlAf35NegF1xaoFHoLX00AsinSVpvMGDc2+tEXhgXlyzm5O5
	ARyHbdNEwD1evurglCPZQAfCzaGWKH/DcbGgdxSJz/ley6IAx3xn4u8me9YUgXIDWLfwCcMsuAylc
	RhN6FU2LgnLxOsNvJfhSixYIUTGnot+TrKcHDL2XxHx7YlWTbLKvaZ0RhlhQ26Gbur7DB0i66Ax/Z
	c56TZtZw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roBkD-0000000BTCn-3Emz;
	Sun, 24 Mar 2024 00:29:49 +0000
Message-ID: <4a81b4cc-90fd-415d-83c1-fe0f0ca7cac9@infradead.org>
Date: Sat, 23 Mar 2024 17:29:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Fix documentation on tp_printk cmdline option
Content-Language: en-US
To: Vitaly Chikunov <vt@altlinux.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
References: <20240323231704.1217926-1-vt@altlinux.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240323231704.1217926-1-vt@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/23/24 16:17, Vitaly Chikunov wrote:
> kernel-parameters.txt incorrectly states that workings of
> kernel.tracepoint_printk sysctl depends on "tracepoint_printk kernel
> cmdline option", this is a bit misleading for new users since the actual
> cmdline option name is tp_printk.
> 
> Fixes: 0daa2302968c ("tracing: Add tp_printk cmdline to have tracepoints go to printk()")
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bb884c14b2f6..623fce7d5fcd 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6599,7 +6599,7 @@
>  			To turn off having tracepoints sent to printk,
>  			 echo 0 > /proc/sys/kernel/tracepoint_printk
>  			Note, echoing 1 into this file without the
> -			tracepoint_printk kernel cmdline option has no effect.
> +			tp_printk kernel cmdline option has no effect.
>  
>  			The tp_printk_stop_on_boot (see below) can also be used
>  			to stop the printing of events to console at

-- 
#Randy

