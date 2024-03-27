Return-Path: <linux-kernel+bounces-120283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28A88D54C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94292A5039
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD623773;
	Wed, 27 Mar 2024 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5LYzJS6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEE22F00;
	Wed, 27 Mar 2024 04:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512254; cv=none; b=tLMx3he8UoS+wpQl9c0DwehmTBRg7t4/7J6R4kIiLD+/q6LW0JqvPAu4aFUnB2h3qXZ3EtbwsOlzgVMZlqQEZ15RrSVSBlCjViNa/a2GqRpN4Kc4SkwLLjYfZpW2YawaflfmdO66dYG/f+lke3jdUqJIZtLG9lJNfGTqvynva3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512254; c=relaxed/simple;
	bh=lZ9YORRD2cjb6H23mT2QiMkZ3f+zO7pgeUMUfeQKOD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuWvEKs4sTxu3TftVQH50iuUYz64peKGZGIPS7ny3QC+VEJiNahbQI6amQVE4PTrijfEHvLBICYD1+N+Tcp5Lp4RTybiBRi2EgZ3Znj8cDcF59WoPq3rg7zbXI6MVnm9qkiRAQCHu1OIoxIFmqC9Y1st9N5jKx6rCM/37i0sVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5LYzJS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344F3C433F1;
	Wed, 27 Mar 2024 04:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711512253;
	bh=lZ9YORRD2cjb6H23mT2QiMkZ3f+zO7pgeUMUfeQKOD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e5LYzJS6xKvz7rl3C2Ix6ObippjF4zUUh12ri0KJTjZlxyG+0T4Jxy5dU2zugFIZR
	 B8LaDyn8b/stXUN/SVxdZomS2g0x8UPpjUaT/lBcixqNZ0tTAiAPLdSDsAF+IhWG25
	 IJApIYpyORp9gzqRyyfvKrfQ2JH+WGHvksj/nGwvYPy5RVw+xBNp1RvFSoPG4aRMtK
	 Cr712R0HlFeL6sMJCv6xngCYxBNu3+FCucZhS3jMjjN78y4JG1odDpU8X+phHOA9jw
	 Ai0pija9g3vZoK9FQgiRJkejxfnRmTLLY7hxgkFKg9+wD64pEtTlJa85Rano8faeP6
	 Y340++hKyHJXg==
Date: Tue, 26 Mar 2024 21:04:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
 <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Simon Horman <horms@kernel.org>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] idpf: make virtchnl2.h self-contained
Message-ID: <20240326210412.1bfce311@kernel.org>
In-Reply-To: <20240326164116.645718-3-aleksander.lobakin@intel.com>
References: <20240326164116.645718-1-aleksander.lobakin@intel.com>
	<20240326164116.645718-3-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 17:41:15 +0100 Alexander Lobakin wrote:
> To ease maintaining of virtchnl2.h, which already is messy enough,
> make it self-contained by adding missing if_ether.h include due to
> %ETH_ALEN usage.
> At the same time, virtchnl2_lan_desc.h is not used anywhere in the
> file, so remove this include to speed up C preprocessing.

Breaks allmodconfig, it seems..
-- 
pw-bot: cr

