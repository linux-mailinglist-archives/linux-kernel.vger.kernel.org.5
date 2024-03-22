Return-Path: <linux-kernel+bounces-111729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E104388700D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4D5285E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBC455C08;
	Fri, 22 Mar 2024 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sWxK41QI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE542E62E;
	Fri, 22 Mar 2024 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122703; cv=none; b=MTdQpmICKJfYClvv4vnf2KJN3G5ABvbnXFK4HRMMK2vCaCBvAfWzuEf6P78WU+TIQTeuPqHo4pqZxYUJaXnn3y9juH7uKcxXndrzZk6z0I1jcIHdrXD6Z8HsVTqkCNh4f3ts30YVaP/d6zLssbLeBNJKdZVpxyILWUmK4ZfvupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122703; c=relaxed/simple;
	bh=Zr2cd54MgddzgfTdF0+M/aAwttdJCFe4vAyZCKWRKC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQrEZIcLrnZMbp30VGTJl3EezE5Zw3EEe5kPTtA7GT4VQt0Uxbhu1eDXaZfwoKQ53s8YNtG37FCc9WgPMcLvEJ3hhN+vHRvaMFT5ak3qXftW+kJTNllNBxsTgPVtfHTVaZzeA3yEWJEmfcTr8ZNQKu4csKGtSDwsliU2yfPqhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sWxK41QI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=DyDMdzAsGaOXL+Ymrn5kRCmWfUv/supTTQ8T5KTu0m4=; b=sWxK41QI0BDSXirW8ZBzZR8FFl
	CKJUKNlbvbW+hclj6DNqdqhHpTszlezb0aPdeVAHYkzovJWqFQOzUplMu7wLLqbiGKgaOrGS5mi+t
	fSlr820FNa5XW0KSrkQoxhV6+UDBqqZvCcxdADD3UL1Lnjns+3gakEYMRiKXigiwpILpdy5xH/nQW
	BA2XRw3ARLVy8oNBnJrkO671W0WeRdE9q888FCPTLbcejp5SeuPYPiWNZ4sfR73D9boKojyZXX8bP
	e0znS6XiBGTXrHIRNOcFxqLrtZYu8x8Ks8hOgU6iFx3F9T8bBnqkd/SxftGAnNWRaUs1oFmwAyyjo
	BTpgqr8g==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnhBB-00000007pM7-1L2S;
	Fri, 22 Mar 2024 15:51:37 +0000
Message-ID: <a9bddc1c-9652-400c-8f79-b745894604d9@infradead.org>
Date: Fri, 22 Mar 2024 08:51:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: fix FTRACE_RECORD_RECURSION_SIZE Kconfig entry
Content-Language: en-US
To: Prasad Pandit <ppandit@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240322121801.1803948-1-ppandit@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240322121801.1803948-1-ppandit@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/22/24 05:18, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Fix FTRACE_RECORD_RECURSION_SIZE entry, replace tab with

replace the tab between "default" and "128" with a space

> a space character. It helps Kconfig parsers to read file
> without error.

Parsers should accept either tab or space but this is a
reasonable change.

> Fixes: 773c16705058 ("ftrace: Add recording of functions that caused recursion")
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/trace/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 61c541c36596..47345bf1d4a9 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -965,7 +965,7 @@ config FTRACE_RECORD_RECURSION
>  
>  config FTRACE_RECORD_RECURSION_SIZE
>  	int "Max number of recursed functions to record"
> -	default	128
> +	default 128
>  	depends on FTRACE_RECORD_RECURSION
>  	help
>  	  This defines the limit of number of functions that can be

-- 
#Randy

