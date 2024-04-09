Return-Path: <linux-kernel+bounces-137315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B1F89E04D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A641D1C21234
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E258D13E3FF;
	Tue,  9 Apr 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwFBl0k9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF513E05F;
	Tue,  9 Apr 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679924; cv=none; b=NqBb1B9x2+Luorm34o9mWcdJKYyp2lLwXpd1esPNp45ukW5WEJNSl0BhVvEhygtSHM94dpQI6m+w2XY2ZTCPkm1QIY6hJdrHn0fG064XXAcNJrNLnI69Lx7hQ8rgTgdLz/h06txDfSGgvIOzlHvqA8amh81AIrwjmkRnWBg5gAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679924; c=relaxed/simple;
	bh=uJctOMuhPDkERpG5xm6MiFTXF8uTWooFYRCnRMixZwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFuxZNHND8v8yGe9OgXPiPEyaqIofgeo/LKyysJPIR4BfCKjlKMuWg07OKzqFawtXbICKFN5SKcPtmKv3RJKMbYs9008XoOr7yWz9gnu9Q18zfQYcgZmWSryw4WUKmsMYlU1QFWGPeHx/HmwPD61mycBABZC5Oq5vyeiZIl5+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwFBl0k9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B87C433F1;
	Tue,  9 Apr 2024 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712679924;
	bh=uJctOMuhPDkERpG5xm6MiFTXF8uTWooFYRCnRMixZwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwFBl0k9bkLttN/WJ96r6EQuRwo4CDY4jxuBxzWIg14f93pv0PXA2elk2b9bmBxwL
	 AQuupZp7GdMt7a/0Pf9xRg8C1sO7eLJQgeBP42fsrpd5z+OQffouhHHuv3pNfSRLtK
	 TSZVhCFYdEhS9fkq2NNigvC9AZksrsCZFy+snBiqx9qxbjHPtmupR45ALDlRaPwmOv
	 fT9POW2ESCxlgTN0GgTJ55bAUKZF8LzhPQqB7WZaIbrCMBZyFmd4HK6r6l10ydwUBd
	 6iqNB46VIBbw9c+TnsneeTPW7/qfO1OxuOdAzj8PBMX4g9DLn/XajPuWl90NVAPD3R
	 oM9M6kfXvG8XA==
Date: Tue, 9 Apr 2024 09:25:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 1/4] kbuild: turn on -Wextra by default
Message-ID: <20240409162521.GB3219862@dev-arch.thelio-3990X>
References: <20240404151713.3493098-1-arnd@kernel.org>
 <20240404151713.3493098-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404151713.3493098-2-arnd@kernel.org>

On Thu, Apr 04, 2024 at 05:16:54PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The -Wextra option controls a number of different warnings that differ
> slightly by compiler version. Some are useful in general, others are
> better left at W=1 or higher. Based on earlier work, the ones that
> should be disabled by default are left for the higher warning levels
> already, and a lot of the useful ones have no remaining output when
> enabled.
> 
> Move the -Wextra option up into the set of default-enabled warnings
> and just rely on the individual ones getting disabled as needed.
> 
> The -Wunused warning was always grouped with this, so turn it on
> by default as well, except for the -Wunused-parameter warning that
> really has no value at all for the kernel since many interfaces
> have intentionally unused arguments.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have not done any LLVM builds with this change but if this is going to
be in -next for a little bit, we should be able to get any regressions
handled quickly.

I am in favor of more warnings but I am a little nervous this will make
compiler upgrades (or tracking their mainline) even more difficult. I do
not have a feeling for how often warnings are added to -Wall and -Wextra
so this may be unfounded but the kernel's -Werror use complicates this
in my opinion. I can engage with the clang folks to try and be given a
heads up when a warning is going to be added to -Wextra, it would be
good to have someone do something similar for GCC, so that those
upgrades do not cause something like this change to be rolled back.

It is easy enough to back out of this if necessary though, so:

Acked-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/Makefile.extrawarn | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index c5af566e911a..c247552c192c 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -82,12 +82,14 @@ KBUILD_CFLAGS += $(call cc-option,-Werror=designated-init)
>  # Warn if there is an enum types mismatch
>  KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
>  
> +KBUILD_CFLAGS += -Wextra
> +KBUILD_CFLAGS += -Wunused
> +
>  #
>  # W=1 - warnings which may be relevant and do not occur too often
>  #
>  ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
>  
> -KBUILD_CFLAGS += -Wextra -Wunused -Wno-unused-parameter
>  KBUILD_CFLAGS += $(call cc-option, -Wrestrict)
>  KBUILD_CFLAGS += -Wmissing-format-attribute
>  KBUILD_CFLAGS += -Wold-style-definition
> @@ -190,6 +192,7 @@ else
>  
>  # The following turn off the warnings enabled by -Wextra
>  KBUILD_CFLAGS += -Wno-sign-compare
> +KBUILD_CFLAGS += -Wno-unused-parameter
>  
>  endif
>  
> -- 
> 2.39.2
> 

