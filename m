Return-Path: <linux-kernel+bounces-125067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FDF891F88
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24521C28E28
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E00137767;
	Fri, 29 Mar 2024 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rieQ2LMl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA952F72;
	Fri, 29 Mar 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719287; cv=none; b=ZXD7SXZe2bnoV91nc5VUbigv5N+q4PHRno92rZY+ax/3sJv4HGXVSGHuOilRLL2MIWQgk3bfsJABiDdhudovmMqEreZG+oWc0IkMdSWaBv6fkZWu6LOO8hT881sdjWTwuPPpu8+dHBT3xLwojlCZ1XyE6FbS0rruJ+tgPmmWL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719287; c=relaxed/simple;
	bh=VzDig2CeGY5nSO715kS9xRpG3Tj08hHyWl+GKUj84U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7DR9nUl5o823ngU3dBR/Qi2lgZXyHsYfgRWbvgkiSQ/F24nxambaFD1iqmiqPQ3bazMlj5i585ReprKAJnDP1WAUufwIgBlaUuRetod0IDR0sbqoAsnNsnIDN+QO9muHlT9PfC/34MPAGwZ+Utda+PEaLVlh3Vd/OrJCdJFeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rieQ2LMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475A2C433C7;
	Fri, 29 Mar 2024 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711719286;
	bh=VzDig2CeGY5nSO715kS9xRpG3Tj08hHyWl+GKUj84U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rieQ2LMlNClsq7evBz4+YZTgI3gWaqKAc5GWL+fVq1OZVKfwl+CsHx57f5JGTWxhV
	 NLGGQ9eej6CEB0+BzQj9RzY0dDh7UerDdX4LgdP83OJJfEq7iv+xoOTgm7SwJUUXuV
	 fCNdY459Ms2fPmJTG5DuMk2Q4UqsoFZp3GUaGs+w=
Date: Fri, 29 Mar 2024 14:34:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "bounds: support non-power-of-two CONFIG_NR_CPUS"
 failed to apply to 5.4-stable tree
Message-ID: <2024032935-antsy-imitation-1453@gregkh>
References: <20240327122125.2836828-1-sashal@kernel.org>
 <ZgQowqqGf-E7Cpcz@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgQowqqGf-E7Cpcz@casper.infradead.org>

On Wed, Mar 27, 2024 at 02:10:10PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 27, 2024 at 08:21:25AM -0400, Sasha Levin wrote:
> > The patch below does not apply to the 5.4-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Looks like you just need a little more fuzz on the patch.
> 
> diff --git a/kernel/bounds.c b/kernel/bounds.c
> index 9795d75b09b2..a94e3769347e 100644
> --- a/kernel/bounds.c
> +++ b/kernel/bounds.c
> @@ -19,7 +19,7 @@ int main(void)
>  	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
>  	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
>  #ifdef CONFIG_SMP
> -	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
> +	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
>  #endif
>  	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
>  	/* End of constants */

Now fuzzed, thanks.

greg k-h

