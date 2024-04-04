Return-Path: <linux-kernel+bounces-131942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C939898DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC6C1F2C945
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FE013340D;
	Thu,  4 Apr 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnpsQAZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1512F5BC;
	Thu,  4 Apr 2024 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254141; cv=none; b=RkM3h//gVwr5GPYzqrzuFhX/94yUO+iJWNClkbfD+jIqeHUhrH5xQnFU+Ptvfhux8vWiVfOSL3YesvihCZ4HsTcH2/uxd53LgSbENMwVE662UAxjnk7qn92q1KY8h0RmJBIcO6mN/laBRBWh+sknAbqHFTsPnxPgZKKAb7LWfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254141; c=relaxed/simple;
	bh=0gy6joTUAZeaCWNN9P4vHaZCeNFrzTQ69aD73ydSImY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osx2a1K9MuQ5/8hgaY1R8jEWFDQgCOscIthmB9hhnzYZtpZSh3J8qDb07BdQtZry5yXfQi0M4HmGRIeqqkJ9fW2hYTc0xDcwLS3JqVNdSI9kSWYHL1pMZz46ddvZnjmTc1b+BjUAqhg21MgjdNCdAP7FaZXMjfWM8uA5C5HXwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnpsQAZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CAFC433A6;
	Thu,  4 Apr 2024 18:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712254140;
	bh=0gy6joTUAZeaCWNN9P4vHaZCeNFrzTQ69aD73ydSImY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gnpsQAZ1bhpAKixST4vQznxblI1ulrpMI58/xqKuo60BB9k3F9VUTSzS8eYooXNzu
	 Zx94E4Y7397aHMaqqwGb15M2yh4yvFz9ifcy5BVkVSaNA793dHeei4dZ2aT1uSJVb2
	 WJvyslnJmw6u4xw/2QNUObEWMhcU+ipbxgTaBRXNIahUWdOo+PGRL2PcmPSfM0FqZ6
	 Iui8uWDn9OYWaiOjHC5FOXIjgCoM65uWst1K2LkeBKRIOO4+LCCTmayoPVmvroOJvh
	 U47jfNubWJ3eaALDXhu+FWwl2HWIcigugJInsl0YekAs+eOtXQ5YZouQnO2NB4CdTL
	 XUi+P4tczsWaw==
Message-ID: <a89e9211-c946-4d1f-a30e-c6017b13eff6@kernel.org>
Date: Thu, 4 Apr 2024 12:09:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] ip6_vti: Remove generic .ndo_get_stats64
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240404125254.2978650-1-leitao@debian.org>
 <20240404125254.2978650-2-leitao@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240404125254.2978650-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/24 6:52 AM, Breno Leitao wrote:
> Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
> configured") moved the callback to dev_get_tstats64() to net core, so,
> unless the driver is doing some custom stats collection, it does not
> need to set .ndo_get_stats64.
> 
> Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
> doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
> function pointer.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv6/ip6_vti.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: David Ahern <dsahern@kernel.org>


