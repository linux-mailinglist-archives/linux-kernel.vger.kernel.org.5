Return-Path: <linux-kernel+bounces-143813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E82298A3DC4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2D7B213DF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DDE45020;
	Sat, 13 Apr 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNjCDD3g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B341DFF8;
	Sat, 13 Apr 2024 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713027061; cv=none; b=V7T5JfBj/dqKgVE9F0sq+9WR6SS4cpOcOTyanqXOhhmrwXzyxitXA2RLEPi7q3Ugosx80dsCRNyDhKF0xyw8nCyjFM6lv2s0Qx4yn9zk1X7d78/7L2Hrqk7YN1D6Poz63EZ1RzZr+ITe74evF3CV0gpEpMB5bIXbk1669ueqPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713027061; c=relaxed/simple;
	bh=fCXK9vlYjjkxqPAsWTH2wUnB688CYxdjVJy2JRxr+kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V44/s5b+FKTbZvspUrWaO4iTIRmKJPRp62Vi1KXYUwBDhqPkI1eiramuUFvK3yF5QcY4WEtUYKPWUpcJNAcbB+b4iEVvHlV8hg/8/2UfOVLLT96zxFA7dt7IVHCu64RylzE2WIrzjTEVUx2LAAho9WaUtxuFoJtkHYAAdTbPzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNjCDD3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5211C113CD;
	Sat, 13 Apr 2024 16:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713027061;
	bh=fCXK9vlYjjkxqPAsWTH2wUnB688CYxdjVJy2JRxr+kc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iNjCDD3gltr0hfad/DIZEFkWHMoSVpSzXTS8PtpfKh+HjPsqfAtTX8/8Oh0aBa8T/
	 4Hj4Qk2kOShrOKTg9wBs5UJWw8Nh8RlDJDDRiwBaUVX8UN+LdhT7JGrfWKZ6W9jnkD
	 8I+mzIUNxXUK2Qps+t4zSX7peS1DYpc1qlfzMM297vZVRDOWPnL/KuamAUJ/TtTx7t
	 1mYIHKqHenXJaXe+tq1jxwV0Oo9wHYDZmbYPGmchzWlsXs0dp4xi/8UENnGCJ+4Fr0
	 w1g8kIm8j4QE+trAN9hg6b6A5m0bB7/5nn7T6K/GRpaMsZXkVqDpde1oTgLKLTa5SH
	 YZVWMrJiwwTjw==
Message-ID: <bedc4b7e-cbb9-45a8-9b71-c7d9534d60bf@kernel.org>
Date: Sat, 13 Apr 2024 10:50:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: ipv6_gre: Do not use custom stat
 allocator
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
References: <20240412151928.2895993-1-leitao@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240412151928.2895993-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 9:19 AM, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the ip6_gre and leverage the network
> core allocation instead.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv6/ip6_gre.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



