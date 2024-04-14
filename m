Return-Path: <linux-kernel+bounces-144358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A58A44F6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 21:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8CAB21427
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27136136676;
	Sun, 14 Apr 2024 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dDG6L9lI"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE71DFF4;
	Sun, 14 Apr 2024 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713124128; cv=none; b=FCE7xlBXXNyIRc0aai2DmQCHpyww0eZHiD+o2j0oYs4Jc1zv+k7PxzdEtJZciIM5KzJKYacgEuaesTfdM7LOZ6UeJR9qOvjZYvbz0frVlyiPupGcOe8TW2thC39YvIO2aZelNG9qRWSwOFSJb4U0K6kfqtXKcQvrdZygBoXpHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713124128; c=relaxed/simple;
	bh=uSujPCydcBAksC0rSozBmnZc8KDhTQh1sz1wkKuA8dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu3Wy++IWVwAF6dwSkRa2ESU2DQeO5Li/ujO1wwR0NoYJK/TBk/9eS1kfiM3aUOiRvyuao1Jm73x7qJzapbN94Ls+c8EaFDlN272R8FTBES8gJFE8gBW2gZj+UMWfihFJIN5HU+LFkV+0FqdxZqQFQHE1cIi8PIpKvi7UN7ssU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dDG6L9lI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 12D4C512;
	Sun, 14 Apr 2024 21:47:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713124079;
	bh=uSujPCydcBAksC0rSozBmnZc8KDhTQh1sz1wkKuA8dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDG6L9lIHouBnxKYoM2mE97PSM5E8WkPnYHCuyB5sRXbeiQa/PcifjROHyl5+PiB0
	 wylJFw2gM8RfUGKlisvkcceppYwV7//LgExaMcT/y7zrN9N1wBFoCQrIadMQG2fVtp
	 oZsUxDlhmwTaL92GhEOmrwivrHjMdRyD7qGHPRFg=
Date: Sun, 14 Apr 2024 22:48:35 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alex Elder <elder@linaro.org>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <20240414194835.GA12561@pendragon.ideasonboard.com>
References: <20240414170850.148122-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240414170850.148122-1-elder@linaro.org>

Hi Alex,

Thank you for the patch.

On Sun, Apr 14, 2024 at 12:08:50PM -0500, Alex Elder wrote:
> Several times recently Greg KH has admonished that variants of WARN()
> should not be used, because when the panic_on_warn kernel option is set,
> their use can lead to a panic. His reasoning was that the majority of
> Linux instances (including Android and cloud systems) run with this option
> enabled. And therefore a condition leading to a warning will frequently
> cause an undesirable panic.
> 
> The "coding-style.rst" document says not to worry about this kernel
> option.  Update it to provide a more nuanced explanation.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  Documentation/process/coding-style.rst | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
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

Those options are not equivalent, they print a single message, which is
much easier to ignore. WARN() is similar to -Werror in some sense, it
pushes vendors to fix the warnings. I have used WARN() in the past to
indicate usage of long-deprecated APIs that we were getting close to
removing for instance. dev_warn() wouldn't have had the same effect.

>  
>  Use BUILD_BUG_ON() for compile-time assertions
>  **********************************************

-- 
Regards,

Laurent Pinchart

