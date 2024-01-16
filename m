Return-Path: <linux-kernel+bounces-27754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C43B982F55F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2041CB23B03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3331D533;
	Tue, 16 Jan 2024 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcSYsMbG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFEB1CFBE;
	Tue, 16 Jan 2024 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433457; cv=none; b=Xh7IDoyugvx4xQ60cixU4ZHcvGoPfc21n+umm+ZU3RyFbSjkGNGAHYrhNr+HwShaj81ePaT8sT31lUn+l2WArGxbtRbYV36/uhcWebEqaHpOr7QpL3RXNrR5hVt91j/6nH9naMwdshvdvnMUl1M/DD3u7kC20ClxIcVeLRLTnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433457; c=relaxed/simple;
	bh=nFYmtr+6YzRDg3+bAiJfqwdAdGxuORN0ImfHiq3Hs2s=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=MX/DuhWHnYuv26SUg7Vi1KkA1MJN7kT2YimSf4nS8R7TuucGC9pqJv29wpZJloixRnMBDcDRt25mjXijHJTYs8cAFD/RbeKO6Px8Xbvs+qy40RFXX4zsaeU/SRrFnR865Xy2Y5ig51oWi6b30PtHPpZeZeG8Ic2TZfVhiBj3fiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcSYsMbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3266FC433F1;
	Tue, 16 Jan 2024 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705433457;
	bh=nFYmtr+6YzRDg3+bAiJfqwdAdGxuORN0ImfHiq3Hs2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcSYsMbGsXMaV+a88y2F015OKzhzdrpOpnXsWBjGlDu3aIJapJe5S8RiykrqQm4Rv
	 bo1Sb6zV6VGsLv6WUNNMXA42ph6NT/tF6tuHZCxiyfZ7CoKhNomz97j35bJR+Unoct
	 u90p6fxoQ8DFt/qva4wk43R80YM4U/jZ9zqNZj7Q/cD2HAMiG4s5bKyu80GtXws2MV
	 hIV177w1KqwzeH6GUtGG6z0kPajAMl+nF/Bjn03Ah+h7HflMFZnqsj8FI3WxG/RYE3
	 kl41EiIXp0kME1pouIpOEJ3EsR0JE8+yhsid7jXfCL3UVYJTc2u2Cx4BtlVdlPu3A3
	 hD9WezZLAvK7w==
Date: Tue, 16 Jan 2024 13:30:55 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: don't anchor DT_SCHEMA_FILES to bindings
 directory
Message-ID: <170543338330.282631.14506406638025276437.robh@kernel.org>
References: <20240116062731.2810067-1-git@andred.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240116062731.2810067-1-git@andred.net>


On Tue, 16 Jan 2024 06:27:31 +0000, André Draszik wrote:
> From: André Draszik <andre.draszik@linaro.org>
> 
> Commit 5e3ef4546819 ("dt-bindings: ignore paths outside kernel for
> DT_SCHEMA_FILES") anchored all searches to the bindings directory
> (since bindings only exist below that), but it turns out this is not
> always desired.
> 
> Just anchor to the base kernel source directory and while at it, break
> the overly long line for legibility.
> 
> Reported-by: Michal Simek <michal.simek@amd.com>
> Closes: https://lore.kernel.org/all/827695c3-bb33-4a86-8586-2c7323530398@amd.com/
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  Documentation/devicetree/bindings/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Added a 'Fixes' tag and applied, thanks!


