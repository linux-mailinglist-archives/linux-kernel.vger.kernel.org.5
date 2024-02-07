Return-Path: <linux-kernel+bounces-56407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920E584C9CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39A81C25D86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3CA1D525;
	Wed,  7 Feb 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO39sJ+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF21B7F4;
	Wed,  7 Feb 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306110; cv=none; b=TKl1Qz+yA287uo1bCL4wGdsFveut4D8C/0ajBcI5zwqkTmNjrjJTwT+dXnDgfmTXKcEaj1M2hjNJCz2fmpNLbjh7D+CEZ5KRXouWipi07LzU45UygjBMeietSqYmEKdyCfVhBZDwP+Bke0kBAfEIkukS5O7TdkPLzgbMaAbVKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306110; c=relaxed/simple;
	bh=1EUbZRaJcsEcz3FbSjVo4LgSYAR+H7vShgUvCE01oH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOVWTsV/vPr1u6w2odDTfiaZLxylWTpkerPpLN0xbkFICWpQaXCCaGRwv4SCEYI2OgcT+VFoocpN1t+9a1WWn4y8O0cg6TiP9rQRgMJURo3cJiYIQbL+MXPJXY2cQgf/oTvlMzu1ct8yjqHq3HpVbTZ2E8+mCk7h0KxrivfAihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO39sJ+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B0FC433F1;
	Wed,  7 Feb 2024 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707306110;
	bh=1EUbZRaJcsEcz3FbSjVo4LgSYAR+H7vShgUvCE01oH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rO39sJ+PvCldczgWJQ2vbdjozNg34UsDZKRl9+EReACMrsPI//XoCvyxX1sGda74B
	 HZwQYnBxujoGgo+08YRWIIy2UQEjf02bmat8WsunuqwT5gatcFX/np3y7YzX/W/reY
	 t2zYJckRiHKH4bBILgcpHGVFV8ltLOW3tWqnWDAAZkf5EcCwiapz1FA0ouuk4PUIhv
	 wxv2QQaXWeL37RC1FJcR1S3jtSQ9/JzIESEK0PZQnvu0DNK9U8kWBlKLoVxWntd5Ht
	 /zVpQGFO7y6khO6NKlVvBjrb2GheJMTz57nl13qUgkjywCcxif/91Yqenm0wL0dIEx
	 B3QueiCcTbPLQ==
Date: Wed, 7 Feb 2024 11:41:46 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net v2 3/9] net: fill in MODULE_DESCRIPTION()s for af_key
Message-ID: <20240207114146.GH1297511@kernel.org>
References: <20240207101929.484681-1-leitao@debian.org>
 <20240207101929.484681-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207101929.484681-4-leitao@debian.org>

On Wed, Feb 07, 2024 at 02:19:22AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the PF_KEY socket helpers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


