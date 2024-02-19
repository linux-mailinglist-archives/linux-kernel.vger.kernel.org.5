Return-Path: <linux-kernel+bounces-72033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E9285AE11
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09ED21F22E82
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43DF5475D;
	Mon, 19 Feb 2024 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Z3cm5RRq"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE8645BFA;
	Mon, 19 Feb 2024 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379562; cv=none; b=Tugpj0KzTPROnAUFrxTlSvQ7YKGBNzeydx5qFS2VVIQXjmqNX/Kp+LxmXorJlnfm06MW1AvWUrZNbgPyJSuLTzMAvQwwE8O8VmD6CR6qbyuhMGSAS8J+P3Y4F9I9X8ZTePVzpNL8WCS+4Yz+e65aCKHY+k1PJnslnO2CmwWWVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379562; c=relaxed/simple;
	bh=0Uj0TEYAVl1N+ryaeMyYaWin46FVZqeDShsZz+K5gdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sg2gUJVha6CtEDVZLtNj65i5qwzv6hgg+lsx2uOpforZI6l/A+gN/w2vABz0n0hXmlH98tz/IRLiUxlXbb6MHN8buwuMuSbpIPR7hjMmDxVop+XeMDxsozmJMaUVufhHlrnZj5sgGToDj8jnBUYad5G6AtrpPI6Q+yKTzUndqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Z3cm5RRq; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 484A247A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708379560; bh=/sGpY7ZQ8fXIb+Q0hw1+y34Hj8sxxoRre8b/MFfEl2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Z3cm5RRqgTVmJM45NUtTKbfOAegLhBjHLxNNE59BXfC81omLAz2sRbbLXGLzyMA0W
	 0eBM2kM7uV+pUxM4U1IUHYiUuvfYH8icDpdluEyJdewjpmyRu6pPV6K+xBDUH15rg9
	 GJIhWD7t92u9PvqAFGGUMZPY6b+70yLVWEbisESpk4dYJPw2qX/TwGw0+XOu7ebrzj
	 ECjw+ykcjwlM2h98Frbu69lJWw0PivctXFuNfNVMdmx5DmB2Rw5E4LOe8BoILuy8q/
	 AvUbUXm1fXje6p/FGRzaW88T7Hg9HevH1cfFaMFXObZAR0+NISOJMxAUx0XoiX+1Te
	 H6Z3RyZKOgKPw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 484A247A99;
	Mon, 19 Feb 2024 21:52:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: SeongJae Park <sj@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Set the field name for subsystem profile
 section
In-Reply-To: <20240216201902.10095-1-sj@kernel.org>
References: <20240216201902.10095-1-sj@kernel.org>
Date: Mon, 19 Feb 2024 14:52:39 -0700
Message-ID: <87il2km89k.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SeongJae Park <sj@kernel.org> writes:

> Subsystem profile section entry identifier is not having its field name
> that can be parsed by maintainers_include.py, unlike other sections
> which have their own human-readable field names.  As a result, profile
> sections on rendered rst file is having weird name, 'P:'.  Set the field
> name as 'Subsystem Profile'.
>
> Fixes: 4699c504e603 ("Maintainer Handbook: Maintainer Entry Profile")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..25fa30bec35f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24,7 +24,7 @@ Descriptions of section entries and preferred order
>  	   filing info, a direct bug tracker link, or a mailto: URI.
>  	C: URI for *chat* protocol, server and channel where developers
>  	   usually hang out, for example irc://server/channel.
> -	P: Subsystem Profile document for more details submitting
> +	P: *Subsystem Profile* document for more details submitting
>  	   patches to the given subsystem. This is either an in-tree file,

Applied, thanks.

jon

