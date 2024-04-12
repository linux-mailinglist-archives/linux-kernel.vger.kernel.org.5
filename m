Return-Path: <linux-kernel+bounces-141968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D288A2599
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213F0B21F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F4318C1A;
	Fri, 12 Apr 2024 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwe+EtfK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B717731;
	Fri, 12 Apr 2024 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899108; cv=none; b=av1Oqp4DI9CqtuatkfaV1XOMNam6mk/OiIuCrANCOMsLMsIE1iWjkFx9Gy90rZ9xLeLftWwlUNvAq/BXq+h0HYpkiwTOQcGtF2FSrES5q5Jag04T0cQueK+RhcmCFTjMAlwX2i0jMHPurfZlbuDMY+Iiv/y8nLwy8e6HTZ1/ARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899108; c=relaxed/simple;
	bh=INmCQ1fpE400k9JPfwAu6ECyCbxAnmhVAOebNyCBIzw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=edL6oEXBZDpO6jGL2p5xW8DgE82iHGDQM1y98DZXsOtKrjsyAV+SjhWocUkUm+HQDeTUND77j+adljrpo/BtF209q1UIPTY/bJ0ab1QiFHC8NzG0OYGWCbjSjUqlg0IyCOgkRGBvHps6+s9hpdsLPjJrWMvpkT7sULSyCK8RNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwe+EtfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B32BC2BBFC;
	Fri, 12 Apr 2024 05:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712899108;
	bh=INmCQ1fpE400k9JPfwAu6ECyCbxAnmhVAOebNyCBIzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wwe+EtfK2fuopyb9scsa5ijsx9IAenvkV1Y4fCPsafZeHf8NFOTiZ2rW7s5/gtgpB
	 38r9mK9dWztcuiMTUevejtFmil1CZJWkISsOxYCNRqo9+wHbxGcHmLPHXM03NvOCUV
	 UBxKH2ccMDBWv9ewyY1dQT5MeP9qYgpQJ1S0TrKypiEiiIQtf/mAqD3GDTVcr5c0di
	 aM5lPi07dfPDqtf+2QXr9QNgbCwwhQA4QIWNJacEjiFatOKyFUY/AUGBsQ1XxFXYoX
	 2Vtv4wlJvJ2yWG7TySsWtWIoHRQP/uX0iIHGR4Y6MmVHuLrtn1Qzq9tXdhQGjI5Auq
	 jvfFPb4NFDVDg==
Date: Fri, 12 Apr 2024 14:18:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, changbin.du@huawei.com,
 christophe.leroy@csgroup.eu, geert@linux-m68k.org, jpoimboe@kernel.org,
 kjlx@templeofstupid.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ndesaulniers@google.com,
 peterz@infradead.org, tglx@linutronix.de, tj@kernel.org
Subject: Re: [PATCH v2] init/main.c: Remove redundant space from
 saved_command_line
Message-Id: <20240412141822.bc7cb44065dab62bf9f2e5ff@kernel.org>
In-Reply-To: <20240412032950.12687-1-ytcoode@gmail.com>
References: <20240412080839.c903a0058bd6594d31bc1d3e@kernel.org>
	<20240412032950.12687-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 11:29:50 +0800
Yuntao Wang <ytcoode@gmail.com> wrote:

> There is a space at the end of extra_init_args. In the current logic,
> copying extra_init_args to saved_command_line will cause extra spaces
> in saved_command_line here or there. Remove the trailing space from
> extra_init_args to make the string in saved_command_line look more perfect.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>

OK, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Let me pick this to bootconfig/for-next.

Thank you,

> ---
> v1 -> v2: Fix the issue using the method suggested by Masami
> 
>  init/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 881f6230ee59..0f03dd15e0e2 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -627,8 +627,10 @@ static void __init setup_command_line(char *command_line)
>  
>  	if (extra_command_line)
>  		xlen = strlen(extra_command_line);
> -	if (extra_init_args)
> +	if (extra_init_args) {
> +		extra_init_args = strim(extra_init_args); /* remove trailing space */
>  		ilen = strlen(extra_init_args) + 4; /* for " -- " */
> +	}
>  
>  	len = xlen + strlen(boot_command_line) + 1;
>  
> -- 
> 2.44.0
> 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

