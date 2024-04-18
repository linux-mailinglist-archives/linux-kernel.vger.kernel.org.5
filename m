Return-Path: <linux-kernel+bounces-150464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7141E8A9FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D98E283B15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6465616FF29;
	Thu, 18 Apr 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj5tuHOY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9C16F90F;
	Thu, 18 Apr 2024 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456873; cv=none; b=gimBBCIEOHHaCK1GP+Bjdp9c4UIhCqNcPML4qRQESzdRd+U9Y15RQhpGqik1iTSldVqa0gE177OCEIhIfeq1XcD8/AvIfs/JAVH9vsb7q4s+zZZ9+OqYKoylSOtoFueeXZskMP4sM+YvFsjanfiU5rGt0CQDag1wdD2ngEeNnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456873; c=relaxed/simple;
	bh=+l71YujbwnGzn01gUZb635Sx3Bh6QLbxqYBJkSt6IYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esHmhUMMaM3yrxg/EUVPgM6UC1qQfOBh97QuRzDBHqbxwu5CRl1BzbDui/uuQ/fWBUgX5W9vRVi31FYusIbn8QGlQHC4FDE077mq3VXLdQwCKmzsULbikgU53DqpBn0589wnhN0d6dKsku0IkGdGqi3LF9oBLXHNJNfQcgrE0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj5tuHOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41F7C113CC;
	Thu, 18 Apr 2024 16:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713456872;
	bh=+l71YujbwnGzn01gUZb635Sx3Bh6QLbxqYBJkSt6IYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bj5tuHOYbzHnNkBi3b5apDmR8m+Zrd29XRqZpstixbbqhO/LQriaqLSst0JIt+N2m
	 oXXIBYhFrGcbd3JDlBgCotfNw44b0ciHHRUSrlZ76F2lJIG7z946hfqpm4982OCm5P
	 OQ2daCuX22Vot50jNGXFFr2u3hQCPPvgI5oXrUuWZr/KoeZe0jcJ1Ram/p564H6DU4
	 F4bXQhuwPi6V+fhi4CM5w7gLrWeAb6IDD6d/RkANhmH7MawtaFXLfSIWv46gK/1W7L
	 35F8yLI205vhJ/ycNw24ZYLKv9DINc7iIrd5FRv/l1D7dgd5uaEPTX5JhtGyzhabs6
	 dYqdQSiZX5q+Q==
Date: Thu, 18 Apr 2024 09:14:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alex Elder <elder@linaro.org>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <20240418161430.GB2410@sol.localdomain>
References: <20240414170850.148122-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414170850.148122-1-elder@linaro.org>

On Sun, Apr 14, 2024 at 12:08:50PM -0500, Alex Elder wrote:
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 9c7cf73473943..bce43b01721cb 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -1235,17 +1235,18 @@ example. Again: WARN*() must not be used for a condition that is expected
>  to trigger easily, for example, by user space actions. pr_warn_once() is a
>  possible alternative, if you need to notify the user of a problem.
>  
> -Do not worry about panic_on_warn users
> -**************************************
> +The panic_on_warn kernel option
> +********************************
>  
> -A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
> -available kernel option, and that many users set this option. This is why
> -there is a "Do not WARN lightly" writeup, above. However, the existence of
> -panic_on_warn users is not a valid reason to avoid the judicious use
> -WARN*(). That is because, whoever enables panic_on_warn has explicitly
> -asked the kernel to crash if a WARN*() fires, and such users must be
> -prepared to deal with the consequences of a system that is somewhat more
> -likely to crash.
> +Note that ``panic_on_warn`` is an available kernel option. If it is enabled,
> +a WARN*() call whose condition holds leads to a kernel panic.  Many users
> +(including Android and many cloud providers) set this option, and this is
> +why there is a "Do not WARN lightly" writeup, above.
> +
> +The existence of this option is not a valid reason to avoid the judicious
> +use of warnings. There are other options: ``dev_warn*()`` and ``pr_warn*()``
> +issue warnings but do **not** cause the kernel to crash. Use these if you
> +want to prevent such panics.
>  

Nacked-by: Eric Biggers <ebiggers@google.com>

WARN*() are for recoverable assertions, i.e. situations where the condition
being true can only happen due to a kernel bug but where they can be recovered
from (unlike BUG*() which are for unrecoverable situations).  The people who use
panic_on_warn *want* the kernel to crash when such a situation happens so that
the underlying issue can be discovered and fixed.  That's the whole point.

Also, it's not true that "Android" sets this option.  It might be the case that
some individual Android OEMs have decided to use it for some reason (they do
have the ability to customize their kernel command line, after all).  It's
certainly not used by default or even recommended.

- Eric

