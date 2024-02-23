Return-Path: <linux-kernel+bounces-78759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E907F861876
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5632850B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7E712883A;
	Fri, 23 Feb 2024 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m90r8sf8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1049186A;
	Fri, 23 Feb 2024 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707041; cv=none; b=H1+fD0MUyVhP44hR3lQrgXWUWMeTkFTh3CHxc7EQL88TXpsY5wvCC9iyD9hWP/XeEb1UVHdzUc7DEMkj1NbXKWBVVJAQK/MFRcWzzWHx/P0XbOEKptFMjk+mVVyVUQgYPC9awVdZt/jeSWlYYVT1lgg4dgbp2g75TNz/rke+fTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707041; c=relaxed/simple;
	bh=FcFKkcD+KedUPd0nKCzo9Sr+131bk/+fxgGpLieoX10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hX4e9S9PDYLU5neVthA2XvaPqcM0gKjWvS7e5UGQnRKMliBrRkkBkaVhW2TS/jhz8pZjgXtwQ1s3iw2oHrxD5cNeJJkZV5GlakT5X+WzPatKxLKEJj4eVOeHa+BFYt4oNwPnD+GISAnbvv7SFvavmWfcBDSPmQbruqfX9pdoAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m90r8sf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214D9C433F1;
	Fri, 23 Feb 2024 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708707040;
	bh=FcFKkcD+KedUPd0nKCzo9Sr+131bk/+fxgGpLieoX10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m90r8sf8rpAUhp0YsZ+A4WeQny1295+J2EUWd2WI/7ORXn6afHm6UHyrbjezOSHvA
	 ltphprEqUjuiWq6LwNJ8tX8+Y2qYnUqxMnSAIUnk1a03aM/J8bH+NAbbEruroyOzQH
	 +KJf7/Dl9SreMNRV1pdtFKwvNaHBcMK4zNDEf680YBpybMhgX8v3CFaZiYDtNMFRwe
	 Zzf/HVbCW4OubxUvFJYH8uHaxNdBKZycj2ZJhmgdIlf0x5I72W99GLsJsl3SjLBnR1
	 cFdLKpZt2bIV4eJSzXUok5jdgbKK66czDsVgWsP+TGtNPk3udTNlzsuFF/94dcbp2c
	 lYlxRG7IYpbbQ==
Message-ID: <fd7b788a-2e12-4828-8f5f-d17536ed5a10@kernel.org>
Date: Fri, 23 Feb 2024 09:50:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/3] ioam6: netlink multicast event
Content-Language: en-US
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <20240223144135.12826-1-justin.iurman@uliege.be>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240223144135.12826-1-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/24 7:41 AM, Justin Iurman wrote:
> v4:
>  - rebase on top of net merge
> v3:
>  - patchset was mistakenly superseded due to same cover title used for
>    iproute2-next equivalent patch -> resend (renamed)
> v2:
>  - fix warnings
> 
> Add generic netlink multicast event support to ioam6 as another solution
> to share IOAM data with user space. The other one being via IPv6 raw
> sockets combined with ancillary data. This patchset focuses on the IOAM
> Pre-allocated Trace (the only Option-Type currently supported), and so
> on IOAM "trace" events. See an example of a consumer here [1].
> 
>   [1] https://github.com/Advanced-Observability/ioam-agent-python/blob/netlink_event/ioam-agent.py
> 
> Justin Iurman (3):
>   uapi: ioam6: API for netlink multicast events
>   net: ioam6: multicast event
>   net: exthdrs: ioam6: send trace event
> 
>  include/net/ioam6.h             |  4 +++
>  include/uapi/linux/ioam6_genl.h | 20 +++++++++++
>  net/ipv6/exthdrs.c              |  6 ++++
>  net/ipv6/ioam6.c                | 64 +++++++++++++++++++++++++++++++++
>  4 files changed, 94 insertions(+)
> 
> 
> base-commit: a818bd12538c1408c7480de31573cdb3c3c0926f

For the set:
Reviewed-by: David Ahern <dsahern@kernel.org>


