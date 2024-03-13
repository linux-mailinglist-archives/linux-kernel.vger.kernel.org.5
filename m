Return-Path: <linux-kernel+bounces-101366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3297587A606
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC30D1F21AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAFB3D3A0;
	Wed, 13 Mar 2024 10:40:20 +0000 (UTC)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A173D0DD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326420; cv=none; b=XxkPpexJrGJFqrJkwFPf4nm/6guqjtqCVnvfxdQvufVb0OlkXWi5Vh7WmPZA45MbNMW7N009aF6xMfvD6lruppRSVFlTKnJc0uG458RqdmIsphcxw9ggeBbPaLi84IFBGaEEa4LPpjVw++PsfDd1twYKt4yCBLLRbBwQC1gUUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326420; c=relaxed/simple;
	bh=DWfzBi/hY8b2ekN9IriDT2CRKZhaspCa2KsynZL8fDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMy8vRIXyLDkhq9OepiR7OFq2be35Yhy8FgS9S8UW3TtOnaNMbGOmL6LHfNM0ahDpQ/RKdJADBn/RxPuE65ATBmf0/kMul5NMeZ5h/aykk9PtizlPk0Su0WKNR5K5XgzAjqsEVX1usyB2PLLwu9R74kZey54FEAeQCpM6NljpJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id B175DA01B6;
	Wed, 13 Mar 2024 11:40:15 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 67qlf_VEHszX; Wed, 13 Mar 2024 11:40:15 +0100 (CET)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id C630EA01AB;
	Wed, 13 Mar 2024 11:40:14 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rkM1u-000000009Kn-1rvr;
	Wed, 13 Mar 2024 11:40:14 +0100
Date: Wed, 13 Mar 2024 11:40:14 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: William Hubbs <w.d.hubbs@gmail.com>,
	Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>,
	Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] speakup: devsynth: remove c23 label
Message-ID: <20240313104014.thhiz2pektmqun4b@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Arnd Bergmann <arnd@kernel.org>,
	William Hubbs <w.d.hubbs@gmail.com>,
	Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>,
	Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240313100413.875280-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313100413.875280-1-arnd@kernel.org>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

Hello,

I have already sent a fix to greg.

("speakup: Fix warning for label at end of compound statement")

Samuel

Arnd Bergmann, le mer. 13 mars 2024 11:04:03 +0100, a ecrit:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-16 and higher warn about a c23 C extension that is also a GNU extension:
> 
> drivers/accessibility/speakup/devsynth.c:111:3: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
> 
> clang-15 just produces an error here:
> 
> drivers/accessibility/speakup/devsynth.c:111:3: error: expected statement
> 
> This is apparently the only such warning in the kernel tree at the moment,
> so just convert it into standard C code using the equivalent 'continue'
> keyword.
> 
> Fixes: 807977260ae4 ("speakup: Add /dev/synthu device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/accessibility/speakup/devsynth.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/devsynth.c b/drivers/accessibility/speakup/devsynth.c
> index da4d0f6aa5bf..76b5e942dc1b 100644
> --- a/drivers/accessibility/speakup/devsynth.c
> +++ b/drivers/accessibility/speakup/devsynth.c
> @@ -68,7 +68,7 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
>  			case 7: /* 0xfe */
>  			case 1: /* 0x80 */
>  				/* Invalid, drop */
> -				goto drop;
> +				continue;
>  
>  			case 0:
>  				/* ASCII, copy */
> @@ -96,7 +96,7 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
>  					if ((c & 0xc0) != 0x80)	{
>  						/* Invalid, drop the head */
>  						want = 1;
> -						goto drop;
> +						continue;
>  					}
>  					value = (value << 6) | (c & 0x3f);
>  					in++;
> @@ -107,7 +107,6 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
>  				want = 1;
>  				break;
>  			}
> -drop:
>  		}
>  
>  		count -= bytes;
> -- 
> 2.39.2
> 

-- 
Samuel
---
Pour une évaluation indépendante, transparente et rigoureuse !
Je soutiens la Commission d'Évaluation de l'Inria.

