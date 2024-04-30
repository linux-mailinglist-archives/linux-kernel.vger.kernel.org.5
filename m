Return-Path: <linux-kernel+bounces-163352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CFD8B69BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8661A1C21C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5E1175B7;
	Tue, 30 Apr 2024 05:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmLLtt1I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831017589
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453849; cv=none; b=ZPO0qVQEeN/0N+2ydYhyna/sYyM2ESzepu5L2DjOeKSHuhqD28vARtzT4pyy6wRPSU33ZBO81YqrSyTwjvOgnYCB3JVfr1Xv4O1jo686KYJ/7nBhR4S+3kiv2POeSq6K4nfdCdch4oUOtRT2s6Rf2HxZCAsSfjQZtnBp3GcbhoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453849; c=relaxed/simple;
	bh=VSb98eDGVt9SRHwNWupysddHqD5t16DQXrkFIt7miX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVvBD+rmysD5XCgaQthJM52Jvs2MkvNZgT5HPkT/IMIGt+5GmxbBxlgkuIRxKkowp5AXrYKIOB/V/oOWDz4l8QNefWc6DgQcAlsueKQ4YWqs1KbgftmA17TslyOe+c2qupzMVzVeQSnYlsacPRphCcw4ntG/Bb0Gv0a3X20HZ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmLLtt1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E3BC2BBFC;
	Tue, 30 Apr 2024 05:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714453849;
	bh=VSb98eDGVt9SRHwNWupysddHqD5t16DQXrkFIt7miX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mmLLtt1IjTxdV3+ONX64hPElmV2URptISu3dJ9Ur/sPFTsnfI8psoqvcGlu8HPapq
	 9pWz3+Q5BvmxMqzMjVJXRM06NFj5htoZtgPInMX4JAfM1O8Q4WzBSgTCtoupH10xmV
	 ZGpUZb/RjyKYZowxX/FyikB01620CxhBT/6tkye8bdDGJVj9IPk56ve4ktHND4JnYj
	 XF3Pgpu32kWK1xWGp4hvH94/fQuwhqw09ykTuyr9obaJ2PSSRMy7MJKY7V4NKia+IU
	 VBLO7woLLoC2CfRb8S0OfmsCF43lItdaVjIwqe4f5cIFRFXWcPuy09TLxMBtMByYvN
	 F2mO584cEi5Cg==
X-Mailer: emacs 29.3 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, naveen.n.rao@linux.ibm.com,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: powerpc: Remove Aneesh
In-Reply-To: <20240430044228.49015-1-mpe@ellerman.id.au>
References: <20240430044228.49015-1-mpe@ellerman.id.au>
Date: Tue, 30 Apr 2024 10:40:42 +0530
Message-ID: <yq5attjj306l.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Ellerman <mpe@ellerman.id.au> writes:

> Aneesh is stepping down from powerpc maintenance.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c121493f43d..93af33ee8541 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12478,7 +12478,6 @@ LINUX FOR POWERPC (32-BIT AND 64-BIT)
>  M:	Michael Ellerman <mpe@ellerman.id.au>
>  R:	Nicholas Piggin <npiggin@gmail.com>
>  R:	Christophe Leroy <christophe.leroy@csgroup.eu>
> -R:	Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>  R:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> -- 
> 2.44.0

