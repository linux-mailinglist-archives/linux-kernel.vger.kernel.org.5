Return-Path: <linux-kernel+bounces-53932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F5784A82F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8830BB26B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F4313A888;
	Mon,  5 Feb 2024 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bm7WOZR1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F350C48783;
	Mon,  5 Feb 2024 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166649; cv=none; b=D5416UV1kymIKroTlMS/FnDzAH/DM6sF/DYGPkRNk/Bkrgnxwp2J6BrJZoivhZR5mzzpioGZnXGKkyPo+bwvmxfq0xrOo8P+Gc4enPDyGgu3vccX1qNn1bntFno9wzVaJXg2a/9DbFhZg7p0/SOIN0J0y1cHCL09jeCquWhJXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166649; c=relaxed/simple;
	bh=n9NXOBKbZzHnS6QoP5z2ZivCMPOrduYRvq0pRS862fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioqpNJjpJuySZaI4NtJvZvNRMvCOcC6Yb/RGGm7Vcz/iq2y0bn1TfsldxQe/l+euVwa60bEAphCbUsAMaKNhi3oEZcchEk+0sQSCb5RKdrsxe1Ncm6ymqKBPmlxij4U4ye4sWKBLfxdVjHCRS4K3RXvebsNl/biX3PsCrRZYHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bm7WOZR1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=BK6dgOw0DUhNxnKL/qa1Tc0mcbdX59+dC5ywm0Fydo4=; b=bm7WOZR1fo7zAHVEX5zIhUN5T0
	GC2PDtLeaTYO7hzWkcuhTfm1xY+lcxLR3VdbZE8J6sdK4Ebt6YQ9hxSUollhaxy0MWZITK5qFh6+s
	fmvRLaQ4I59pzFUhYFRPOVuc+EDHRkijxsjS+LHIru7DifWqZdal1GoCvKaVz2N8lmwfvBuFgSZ0R
	PDiT1uYmdnz4HQrHp6oOEIceH3Rt/y1ltuO0F8+EUeQlgu79ysH+nPk2GqUbL2qPc11ADe1iQL5LV
	gqzCM2PxnfildQNjnPywbovMBFihzDipVX2VuXwOIDXKmv4/L0ZOpnf58XhwCf7K7zpEVRSXqTbwU
	YxayafJg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX61s-000000058Qn-0COD;
	Mon, 05 Feb 2024 20:57:24 +0000
Message-ID: <65734029-0cbd-4870-905f-024fcc09a634@infradead.org>
Date: Mon, 5 Feb 2024 12:57:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: admin-guide: tainted-kernels.rst: Add
 missing article and comma
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@toblux.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 trivial@kernel.org
References: <20240205132409.1957-1-thorsten.blum@toblux.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240205132409.1957-1-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/24 05:24, Thorsten Blum wrote:
> - Add missing article "the"
> - s/above example/example above/
> - Add missing comma after introductory clause to improve readability
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/tainted-kernels.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index 92a8a07f5c43..f92551539e8a 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -34,7 +34,7 @@ name of the command ('Comm:') that triggered the event::
>  
>  You'll find a 'Not tainted: ' there if the kernel was not tainted at the
>  time of the event; if it was, then it will print 'Tainted: ' and characters
> -either letters or blanks. In above example it looks like this::
> +either letters or blanks. In the example above it looks like this::
>  
>  	Tainted: P        W  O
>  
> @@ -52,7 +52,7 @@ At runtime, you can query the tainted state by reading
>  tainted; any other number indicates the reasons why it is. The easiest way to
>  decode that number is the script ``tools/debugging/kernel-chktaint``, which your
>  distribution might ship as part of a package called ``linux-tools`` or
> -``kernel-tools``; if it doesn't you can download the script from
> +``kernel-tools``; if it doesn't, you can download the script from
>  `git.kernel.org <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/tools/debugging/kernel-chktaint>`_
>  and execute it with ``sh kernel-chktaint``, which would print something like
>  this on the machine that had the statements in the logs that were quoted earlier::

-- 
#Randy

