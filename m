Return-Path: <linux-kernel+bounces-139789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA26F8A07BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DDB1C22DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D7A13C837;
	Thu, 11 Apr 2024 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YGouY9bQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293C54F5FE;
	Thu, 11 Apr 2024 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813443; cv=none; b=s9nceVOcbMbslPYKF1nGBW/H6aOdiWEHJ8HiBek4pJXOfze7dQxcxPvfKLK70Qz8+J5L04VzqM74UVaO0RCr9LM4HsndHIk1HuhoIihiGGctW+HUtT1OfoIfgcZx5o6U+eKTDeykczaBrCnE5AcNxyoHMJerECN0TA3dskLBCic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813443; c=relaxed/simple;
	bh=DrNxdSNSpnp4FkqzibLUniz/OyZTm29PQBAYMHVCMEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnmuIJvMUbbsq0+EQjvcQvYsipnmeR0Nye2CZrLypZI3fWxuLd+7tViUZqwRLVrIJf+AUqlHPbsRsBFZSOlFg+uOt38rcCotjbrwG0vWcN4scuXyUi4kvvBifY3wV8D/bbZNlNaxc1hVg3BfupdM5kKVX2UcL+1eZLB1HHFPjPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YGouY9bQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33578C433F1;
	Thu, 11 Apr 2024 05:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712813442;
	bh=DrNxdSNSpnp4FkqzibLUniz/OyZTm29PQBAYMHVCMEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YGouY9bQMWvFtwwNcD5tNT1DRhPtJQYPLtCGajmmNHymxZba0wRia34iDvaHNI3OP
	 Vaw/jkISDOy+MLvQi/93VCiZOfyUKY9CzJmxbRlWe2ROU/mfIZ+FvjN0WTgblyAZys
	 oqiiX7GaanovnYrklpwqo34Mril3b3DyHzXMaLcw=
Date: Thu, 11 Apr 2024 07:30:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] docs: stable-kernel-rules: call mainline by its
 name and change example
Message-ID: <2024041156-nintendo-paddling-eaad@gregkh>
References: <cover.1712812895.git.linux@leemhuis.info>
 <ec5dff37a62681beb74f89f8fcde41b6618152f0.1712812895.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec5dff37a62681beb74f89f8fcde41b6618152f0.1712812895.git.linux@leemhuis.info>

On Thu, Apr 11, 2024 at 07:25:05AM +0200, Thorsten Leemhuis wrote:
> Fine-tuning:
> 
> * s/Linus' tree/Linux mainline/, as mainline is the term used elsewhere
>   in the document.
> 
> * Provide a better example for the 'delayed backporting' case.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/process/stable-kernel-rules.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index ebd57cb9277f7b..3c05f39858c78a 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -6,7 +6,7 @@ Everything you ever wanted to know about Linux -stable releases
>  Rules on what kind of patches are accepted, and which ones are not, into the
>  "-stable" tree:
>  
> - - It or an equivalent fix must already exist in Linus' tree (upstream).
> + - It or an equivalent fix must already exist in Linux mainline (upstream).
>   - It must be obviously correct and tested.
>   - It cannot be bigger than 100 lines, with context.
>   - It must follow the
> @@ -127,7 +127,7 @@ comment to pass arbitrary or predefined notes:
>  
>     .. code-block:: none
>  
> -     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
> +     Cc: <stable@vger.kernel.org> # after 6 weeks in a stable mainline release

I do not know what "stable mainline release" means here, sorry.  "after
4 weeks in mainline" means "after in Linus's tree for 4 weeks, but
Linus's tree is not "stable mainline".

thanks,

greg k-h

