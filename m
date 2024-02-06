Return-Path: <linux-kernel+bounces-54157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8413384ABA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234871F24FDF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57561523A;
	Tue,  6 Feb 2024 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byseLhi4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985E14A12;
	Tue,  6 Feb 2024 01:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183326; cv=none; b=CcCoWcjXgM40mAz6ml3/fTQt92d8Fd/7BOuKlPCLr914K4KmQucYxNLqjAGNtZNA5fpyIclOjFDEHwaUNqKlpkjdBlu+q0AtY/9SmRUULqdA5gVCokuqqtMCZClZQXvec/ko0QYN0o6ZHnSB4XW4hgxuaXlXEX/HncKdgt1LRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183326; c=relaxed/simple;
	bh=GTypLeGQD+FlzS9/zrkSLFidGHzGhNVLfKzk8fk8Lq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Drx5wo97XvlmYG+qfrrI++0D5NVmZr7MSThjflEWSy0A6Hlsfk2UoCRnJQek3N2BuS5pkczuOCRHmvTpLDZyYrwskI6TrWKGzZc1y8tRfpoqW6rsiGNh/75zKawUvfANyU/gr21VU0iRy2NzhQj1pV/B0e9y/8l2h9h/pVZJqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byseLhi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BD8C433C7;
	Tue,  6 Feb 2024 01:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707183326;
	bh=GTypLeGQD+FlzS9/zrkSLFidGHzGhNVLfKzk8fk8Lq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byseLhi4ko8ezhY9OGnbrVUra+uZuwttTrKNF+xhNjRRVUZF2ha7eNIt+zRbK3RvF
	 djq7s40BpArHEP/S4wTeZkrVP5F6TS8s2xUoK9NUh74njy3uwFdqRggWW3cLjUMxth
	 zysHHoF25GekW6YrXp7c6o099yLnqtH7/N5BEpB2bJ8UIGQ6LqaO8rhTVe9mu8TiNk
	 QOULH2fjV3KDEVCoX5dcIUmB0wLobCunYRjFCWBB49niOUYS/WBEEAxZoXALCeTtyf
	 GVmVy/NilbK64+7anIbuZUOdHH+YpjN3f2sc4dY3TUOMDeJU8n3zFHM9QTRoOhmwhj
	 2uPAaedyZ6Z5A==
Date: Mon, 5 Feb 2024 18:35:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] kbuild: rpm-pkg: mark installed files in /boot as
 %ghost
Message-ID: <20240206013524.GB3151678@dev-arch.thelio-3990X>
References: <20240202133520.302738-1-masahiroy@kernel.org>
 <20240202133520.302738-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202133520.302738-2-masahiroy@kernel.org>

On Fri, Feb 02, 2024 at 10:35:18PM +0900, Masahiro Yamada wrote:
> Mark the files installed to /boot as %ghost to make sure they will be
> removed when the package is uninstalled.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/package/kernel.spec | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index aaedb6d1b26f..ecedcfc11e73 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -77,6 +77,10 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
>  		echo "%ghost /lib/modules/%{KERNELRELEASE}/modules.${x}"
>  	done
>  
> +	for x in System.map config vmlinuz; do
> +		echo "%ghost /boot/${x}-%{KERNELRELEASE}"
> +	done
> +
>  	echo "%exclude /lib/modules/%{KERNELRELEASE}/build"
>  } > %{buildroot}/kernel.list
>  
> -- 
> 2.40.1
> 

