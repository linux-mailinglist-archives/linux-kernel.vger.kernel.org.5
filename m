Return-Path: <linux-kernel+bounces-89173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E921786EB9C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BF01F2306D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721E659163;
	Fri,  1 Mar 2024 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvCLSZkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21E859153;
	Fri,  1 Mar 2024 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331373; cv=none; b=PuqygixIG8mj5qgewvNNqVRH0BigzCIUBsC/+8zhk97dMDgWlC9MoBQ/e2DctPGQQb4+vBJqrbUZflRhR71SX9C4FEPZ6HQBKKdtMx8EEgSFh+w9rDRoPZHYtQbFnvSknz+d08DdhUEmr7/yjQg5LhryzhoLm2CU2/ZspeWAxvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331373; c=relaxed/simple;
	bh=LJuIQFukpHI3j0cJHkQpRofhGTNtPQXNa5W8OdNEN1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFsT6sscip50f0zaS5Ow802y9osJ+FrNz77aLpPHIdHm5DFoXDcXeMI00lU+T3JlmrLnXIlWOZ19lOPT+sJhRhqLY0rbcy/C52HgrE6qpnUuwD/OGgydaRH0WCnIo+9lY6axmyQKR5/0roVMx7Xg94ilY2DqzfTKOMYAiQ8WFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvCLSZkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14F2C433C7;
	Fri,  1 Mar 2024 22:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709331373;
	bh=LJuIQFukpHI3j0cJHkQpRofhGTNtPQXNa5W8OdNEN1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvCLSZkXt1+PGO47H7i+AifOOEsxZKS2EW6eRbXy+jsraAQbc1qGPFDZm7vujNyUj
	 DfRxLO3w0R/PBlCgs+dud76hc3xY6nlwFSOkkh8m4k+wc2UtpjCPWzHHflK6E395+Z
	 V1JKczDaugpVP6z5Z/OkzpYa5NZ9E+T03S8zUf949DGCA4A+kykefxDfczr3rxdGJ7
	 uFzg27GjuXfjxZRLEU3ZeppT+lAtq/V+L1QCbwWtAfGlo2YBpP1u37Hv69MGHiuTya
	 DHdDh04f7OKAJpIyWNR6N7w1dRSfySuyGYKuElnXy2yDyYV8NqM7ZqLHngDH4CvRjT
	 R27dpIJDaqLtQ==
Date: Fri, 1 Mar 2024 15:16:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: fix inconsistent indentation in top Makefile
Message-ID: <20240301221611.GB2610495@thelio-3990X>
References: <20240301112108.1958281-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301112108.1958281-1-masahiroy@kernel.org>

On Fri, Mar 01, 2024 at 08:21:07PM +0900, Masahiro Yamada wrote:
> Commit 3b9ab248bc45 ("kbuild: use 4-space indentation when followed
> by conditionals") introduced inconsistent indentation because it
> deliberately touched only the conditional directives to minimize the
> change set.
> 
> This commit reformats some blocks in the top Makefile so they are
> consistently indented with 4 spaces.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  Makefile | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d84c0fb215fd..859b0f52949e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -295,51 +295,51 @@ single-build	:=
>  
>  ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
>      ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
> -		need-config :=
> +        need-config :=
>      endif
>  endif
>  
>  ifneq ($(filter $(no-sync-config-targets), $(MAKECMDGOALS)),)
>      ifeq ($(filter-out $(no-sync-config-targets), $(MAKECMDGOALS)),)
> -		may-sync-config :=
> +        may-sync-config :=
>      endif
>  endif
>  
>  need-compiler := $(may-sync-config)
>  
>  ifneq ($(KBUILD_EXTMOD),)
> -	may-sync-config :=
> +    may-sync-config :=
>  endif
>  
>  ifeq ($(KBUILD_EXTMOD),)
> -        ifneq ($(filter %config,$(MAKECMDGOALS)),)
> -		config-build := 1
> -                ifneq ($(words $(MAKECMDGOALS)),1)
> -			mixed-build := 1
> -                endif
> +    ifneq ($(filter %config,$(MAKECMDGOALS)),)
> +        config-build := 1
> +        ifneq ($(words $(MAKECMDGOALS)),1)
> +            mixed-build := 1
>          endif
> +    endif
>  endif
>  
>  # We cannot build single targets and the others at the same time
>  ifneq ($(filter $(single-targets), $(MAKECMDGOALS)),)
> -	single-build := 1
> +    single-build := 1
>      ifneq ($(filter-out $(single-targets), $(MAKECMDGOALS)),)
> -		mixed-build := 1
> +        mixed-build := 1
>      endif
>  endif
>  
>  # For "make -j clean all", "make -j mrproper defconfig all", etc.
>  ifneq ($(filter $(clean-targets),$(MAKECMDGOALS)),)
> -        ifneq ($(filter-out $(clean-targets),$(MAKECMDGOALS)),)
> -		mixed-build := 1
> -        endif
> +    ifneq ($(filter-out $(clean-targets),$(MAKECMDGOALS)),)
> +        mixed-build := 1
> +    endif
>  endif
>  
>  # install and modules_install need also be processed one by one
>  ifneq ($(filter install,$(MAKECMDGOALS)),)
> -        ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
> -		mixed-build := 1
> -        endif
> +    ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
> +        mixed-build := 1
> +    endif
>  endif
>  
>  ifdef mixed-build
> -- 
> 2.40.1
> 

