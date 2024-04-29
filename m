Return-Path: <linux-kernel+bounces-161877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489ED8B5299
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDC41F21686
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5141759E;
	Mon, 29 Apr 2024 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zjl2L+fS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97075883D;
	Mon, 29 Apr 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377068; cv=none; b=A7BG0P0B4zYFtNb0s/AZ/6NoO7tk9J0782WJ4zd8FgT+HtmghyQRVKqrYS9hggqws22viHKuKB/Y9MwHPreWNV/psliEujg4j8iLu3n+oRAv1gNGSzih2425y2OgBbysW14GFhetAcUzGYE4BeMIUFxTV6V8pLadTpu0CbGJ1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377068; c=relaxed/simple;
	bh=McMEvZTQ6MNqR/t54W2eBDQB6SXAnERPBrY+KwJc16Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1ZmrQPf596CUXiLfjJf5ePfk2+hRgI9hwh7olIePfasIs53b4Ytw0kwmB/mWBR2fp5b2ysejrvMaImVWpYbr7x2jq6cRdO4YAa1p9RAPdHNiQy4SjdspkkojbYP/bIU7WI+wfCsJVzpf4cwb9CFj5kt9AES41Mv4/VQYE0v/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zjl2L+fS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015AFC113CD;
	Mon, 29 Apr 2024 07:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714377068;
	bh=McMEvZTQ6MNqR/t54W2eBDQB6SXAnERPBrY+KwJc16Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zjl2L+fShKi1Srk5oK9LjSUdOYVVoFxv4TbxuKP2BxTrzdtIqKC20YbMx6t4y2Ccj
	 d94jmHjjk88Q915550yLOZvNSey3AnNJMFKr8uI6RGEhDk5VhY4M3JXBZRo3CBj29e
	 S8zThCWLdJ+cowu5VzrTiGRLJqju7cRrA0GPWUd8=
Date: Mon, 29 Apr 2024 09:51:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] docs: stable-kernel-rules: explain use of
 stable@kernel.org (w/o @vger.)
Message-ID: <2024042957-revision-sublevel-57c2@gregkh>
References: <cover.1714367921.git.linux@leemhuis.info>
 <6783b71da48aac5290756343f58591dc42da87bc.1714367921.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6783b71da48aac5290756343f58591dc42da87bc.1714367921.git.linux@leemhuis.info>

On Mon, Apr 29, 2024 at 09:18:29AM +0200, Thorsten Leemhuis wrote:
> Document when to use of stable@kernel.org instead of
> stable@vger.kernel.org, as the two are easily mixed up and their
> difference not explained anywhere[1].
> 
> Link: https://lore.kernel.org/all/20240422231550.3cf5f723@sal.lan/ [1]
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/process/stable-kernel-rules.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index b4af627154f1d8..ebf4152659f2d0 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -72,6 +72,10 @@ for stable trees, add this tag in the sign-off area::
>  
>    Cc: stable@vger.kernel.org
>  
> +Use ``Cc: stable@kernel.org`` instead when fixing unpublished vulnerabilities:
> +it reduces the chance of accidentally exposing the fix to the public by way of
> +'git send-email', as mails sent to that address are not delivered anywhere.

The "fun" part of just saying this is that then it is a huge "signal" to
others that "hey, this might be a security fix!" when it lands in
Linus's tree.  But hey, we do what we can, I know my scripts always use
this address just to put a bit more noise into that signal :)

That being said, it's good to have this documented now, thanks for it:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


