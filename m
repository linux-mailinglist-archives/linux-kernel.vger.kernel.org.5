Return-Path: <linux-kernel+bounces-1329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654C9814D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2371E1F2517B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDBD3E473;
	Fri, 15 Dec 2023 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GlwvFBbS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5C25546;
	Fri, 15 Dec 2023 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=56+Wae/xX9CIF/Rb17HxT31PTyujjzTbsxy+sp2Y1vA=; b=GlwvFBbSvLeKzj0bgyCL8gJ9SX
	j6jK5r4uA2qjfS9oos86V7tLq6rmiL7blM7qk+kWqZTWOY3pnE+EqF0o4VN8IaiJxE5shdE9+wPwl
	YXTort9mUAZBpvow1tPlpX4GXAFt/osQP+BJK1HjLyS6HCpJrpL5dAZUvdGueuOvOlZETt/vwzDwq
	oS8tHmaWd/7EPyBd6kS1ynzNMV99Yfe5aTY1Y2s61y2Pz43ixo7rEOFT6zliPsFM18UQr2KJF2we5
	27d1omiYQ8/UgXkhC0Bz/HHWWaHIz6YxCQXAy+mNo7QEccRBVeYfBVLLSbWPX6jnPaD8KITGQwPCq
	nkZ6Le3A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEBNa-003vcV-1c;
	Fri, 15 Dec 2023 16:49:38 +0000
Message-ID: <03c0b3bd-5798-4066-964e-a884485fe1d3@infradead.org>
Date: Fri, 15 Dec 2023 08:49:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] kernel-doc: Aling quick help and the code
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
References: <20231215150341.1996720-1-andriy.shevchenko@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231215150341.1996720-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/15/23 07:03, Andy Shevchenko wrote:
> The update to the quick help mentions -Wshort-description, but
> code never supported for that. Align that with the code by allowing
> both: -Wshort-description and -Wshort-desc.
> 
> Fixes: 56b0f453db74 ("kernel-doc: don't let V=1 change outcome")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

(Note: in Subject, s/Aling/Align/)

> ---
>  scripts/kernel-doc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 0a890fe4d22b..7d7ed3e43946 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -23,7 +23,7 @@ kernel-doc - Print formatted kernel documentation to stdout
>  
>  =head1 SYNOPSIS
>  
> - kernel-doc [-h] [-v] [-Werror] [-Wall] [-Wreturn] [-Wshort-description] [-Wcontents-before-sections]
> + kernel-doc [-h] [-v] [-Werror] [-Wall] [-Wreturn] [-Wshort-desc[ription]] [-Wcontents-before-sections]
>     [ -man |
>       -rst [-sphinx-version VERSION] [-enable-lineno] |
>       -none
> @@ -328,7 +328,7 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
>  	$Werror = 1;
>      } elsif ($cmd eq "Wreturn") {
>  	$Wreturn = 1;
> -    } elsif ($cmd eq "Wshort-desc") {
> +    } elsif ($cmd eq "Wshort-desc" or $cmd eq "Wshort-description") {
>  	$Wshort_desc = 1;
>      } elsif ($cmd eq "Wcontents-before-sections") {
>  	$Wcontents_before_sections = 1;

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

