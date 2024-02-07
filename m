Return-Path: <linux-kernel+bounces-56410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1416C84C9D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B4FB218D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFD81D52C;
	Wed,  7 Feb 2024 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc6rSSXv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB42F28DB5;
	Wed,  7 Feb 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306158; cv=none; b=c68OWBEZT6btYshV7XkOlvtU4E27BDbWp/g1QBuBXo8EgxdebLVdigd1rwXNPIQrBS3uP5Axh//7wlaehQ+k1tP7T6gL9Hifab8kqM14tpkPdSDYQAYwljTp41sqXq0VgJK8e3ld1OOBETN6gWl9R5GzYL8AwcUxSdH+96hse8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306158; c=relaxed/simple;
	bh=XpxsVVfrjuq/oa0I9Xt14QpRjxruHgQkYsHIwU0K3nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3BQbM4fW/5WOr8ja0ryKxdlW6cHcgdn6bTyNU74WZSavyauwrZkFLDLhs1hY0rbuwnabsdaPttp63o3uyC/UJ7ZOTleoe65peb1eMN8ee4g6jE/YsJ8zZhcJJ/WqKIpaUshb4CVlUrHN5uBfUDXnczQ62BLjI2K95M/n1cgsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc6rSSXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401F8C433F1;
	Wed,  7 Feb 2024 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707306158;
	bh=XpxsVVfrjuq/oa0I9Xt14QpRjxruHgQkYsHIwU0K3nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bc6rSSXvs8rbJF7g57zugFswEYqIhYe4ldKySaFh5c/kQltBpIWLZbAEDMWxHLTrB
	 Q5d9GCPhZ5EjzJwcBtSrvWrjGXX543XntcCnRdoki33sESy7cIt0iG4q4ZEB5kagTR
	 9+l4cjGB0D7l04fRGw6KxUuNRQYqhMqjfWXivYQCgs697l99ytyy4hWXd8/T+RorHI
	 yLtRMK8J/f7e3Wy00DMpkRQDdBlfFwNal0r7DbNFqphY5bXwRzvFGZgtOQN05Y4gLz
	 Di9WpM52RF54U8FU4aF0zX7W7v4S1Z2J4oavdUr2x/IirQR0jZrs555zfstcap6FK/
	 dUk2nMQ490xiQ==
Date: Wed, 7 Feb 2024 11:42:34 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net v2 6/9] net: fill in MODULE_DESCRIPTION()s for ipv4
 modules
Message-ID: <20240207114234.GJ1297511@kernel.org>
References: <20240207101929.484681-1-leitao@debian.org>
 <20240207101929.484681-7-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207101929.484681-7-leitao@debian.org>

On Wed, Feb 07, 2024 at 02:19:25AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the IPv4 modules.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

My comment on the previous patch notwithstanding,
this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


