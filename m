Return-Path: <linux-kernel+bounces-70540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C58598FC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33331F229FE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801F973167;
	Sun, 18 Feb 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Adi8QjoG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407EF6F511
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283432; cv=none; b=PK5Db7uQ1vu68vj58B9whp7Ldyg1Ju5Sq/H4owmtx3sfdxN90K9omcBtp2xrUzQzvq4nmJcGtN5s6LxW8YpYpMMUPcSnhPG+kcS5Us+8HD118+ptUFJDFejingAvdiJaZ2crODqn4gqrMYYfos1n2he4daDs4BU20UUzmhZE2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283432; c=relaxed/simple;
	bh=C+4nxFZBqNlqit0yXwEnwf8ZCrqFiLqFqZe2842sj7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcMBPxW89oUSGjRF7amKcbzhGmgF8O5arewfSxrKZZ8tJxaMz0/VUqkl5c6OOEW/uOex7iAq4y/WbacuzcQ/Ld8VJ5qLWAvwQwWHkXYfmW4Ei9tPgDGk/M1MJ0DV6Z+fiH4B3zX44xpG3m3sAF60bmz6ErA1XKAfR/1pKdyEFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Adi8QjoG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=mzw3JFNrqj9QCCSMwfJzzL23wHmF4f7t1d4OEg6cGmg=; b=Adi8QjoGmsLvn81xZIEjpyOIDV
	XRnuflwjaEw5tDUro/Dkq42Vdm9RjhUYDlI+O/GqYxMMN1gcJOQJdl0SAe9uVVIG5LWrp+7fqL41H
	41hsu+g2vVS62HuPk9XDb1i0MECFzpqvseTqWuT9kUFBhc3JUT39F2xkMLpho6FIz98zX7553RuOd
	s5bAmnPo6BbuSzQQjYHxV6GEbXFus5AZZ5JtB+i4FCDQINCbKrwiHtzG+FIjHi4OBMPXwuW8ukxZK
	CLUQ2dq4xQ7Lnvx4lFWrywMvIsbrkET/w4lIYBJtS0ycNnPnE79ckCkpposNN5dU1zQ1KDWCHSv5h
	K8AK1Y3g==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbmYX-00000008Hko-0kXt;
	Sun, 18 Feb 2024 19:10:29 +0000
Message-ID: <ae677f7e-0694-4af0-8f43-df839444aca8@infradead.org>
Date: Sun, 18 Feb 2024 11:10:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH printk v2 10/26] printk: nbcon: Fix kerneldoc for enums
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-11-john.ogness@linutronix.de>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240218185726.1994771-11-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/24 10:57, John Ogness wrote:
> Kerneldoc requires enums to be specified as such. Otherwise it is
> interpreted as function documentation.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/console.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 5c55faa013e8..d8922282efa1 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -130,7 +130,7 @@ static inline int con_debug_leave(void)
>   */
>  
>  /**
> - * cons_flags - General console flags
> + * enum cons_flags - General console flags
>   * @CON_PRINTBUFFER:	Used by newly registered consoles to avoid duplicate
>   *			output of messages that were already shown by boot
>   *			consoles or read by userspace via syslog() syscall.
> @@ -211,7 +211,7 @@ struct nbcon_state {
>  static_assert(sizeof(struct nbcon_state) <= sizeof(int));
>  
>  /**
> - * nbcon_prio - console owner priority for nbcon consoles
> + * enum nbcon_prio - console owner priority for nbcon consoles
>   * @NBCON_PRIO_NONE:		Unused
>   * @NBCON_PRIO_NORMAL:		Normal (non-emergency) usage
>   * @NBCON_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)

-- 
#Randy

