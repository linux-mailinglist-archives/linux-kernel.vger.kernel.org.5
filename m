Return-Path: <linux-kernel+bounces-32315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEFC8359FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272C21F23411
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6FC4A33;
	Mon, 22 Jan 2024 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tngkpeMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5091C2E;
	Mon, 22 Jan 2024 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896623; cv=none; b=THlAc7t9Wu2hVK/DmCrn3zGhMPfBYH+nwoMEnUX+5lvStdGWIffR10aS7FrSONWe1kHCpcTtmRy6n4UbgZl4UTVnQhMHa0AGBs6DolZXOgpQyPqGtt8ZyuiXMTS63Le1bzyNZOkpDZaPkqEiZHNAYUtUPbrDS6e/6DwxPsk3z/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896623; c=relaxed/simple;
	bh=za0u5GnYHE4ehHb3iprv2PuIL+6HBFUS4n1kw0KU1vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK8rFu4PGZYbsTtJnnFCr1V+d5CrSuZy3O60KoqqxXvLzy4KgbqkJW+0tLJoltI9MP69OWoXzisz7hG/LWwcqCDXoKLWPBLKnJ1WNLhyCyPdiitJIRGrxeCn20uNo8Y5aEnCZxUR/WuYhhy8NjTPyXmfisAZCzm2jFu7RTWukos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tngkpeMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AE1C433F1;
	Mon, 22 Jan 2024 04:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705896622;
	bh=za0u5GnYHE4ehHb3iprv2PuIL+6HBFUS4n1kw0KU1vg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tngkpeMG1j8UleIoz3SnK5YgUv+HmMy8IqPn/d5yxgiJ9x3TNPFlMMPY3naHJ9fxW
	 cn3wTZ9MIC1lnJUAW+BNzG/8A5Qvdq8muNhKhsYGnxYrEolMYrTZcyt+qLNhQaLsNr
	 KiCr80TY3nE2M/muam+BZujmYynP6SHOyokgRhtMF13Zs5ajLGMzKcxRoQVtqPfN9Y
	 vmqAygSsD9HVZ7gqusE2aHiRVYMoQQaWBPuHvmsE55OqbE0+SHFe5jC6uTYgU6ZgHc
	 ksGdaXoWaXIINElPpdWyUK8Ws/9UGGHUpHDfELW21Xcjr7B76Q/Y+yvNHAiJSraqU4
	 QRfx4Iaf0jeMA==
Message-ID: <90209854-8515-4f1e-8d6b-0182c8cab7ea@kernel.org>
Date: Sun, 21 Jan 2024 21:10:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Discuss]iproute2: ipv6 route add fail
Content-Language: en-US
To: gaoxingwang <gaoxingwang1@huawei.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: liaichun@huawei.com, yanan@huawei.com
References: <20240105094255.1498461-1-gaoxingwang1@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240105094255.1498461-1-gaoxingwang1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 2:42 AM, gaoxingwang wrote:
> Hello everyone,
> 
> Here is a particular problem with routing.
> Sometimes users can run the ip -6 route command to add a route whose destination address is the same as the gateway address, and it can be successfully added. However, adding another route with the same gateway address will fail later.
> 
> Example:
> # ip -6 route add 2409:8080:5a0a:60c7::7/128 via 2409:8080:5a0a:60c7::7 dev eth2
> # ip -6 route add 2409:8080:5a0a:60c7::8/128 via 2409:8080:5a0a:60c7::7 dev eth2
> RTNETLINK answers: No route to host
> 
> Does the kernel not support this application scenario?
> Or should the kernel not allow routes with the same destination address as the gateway address to be added so that other more meaningful routes can be added successfully?
> 
> This question puzzles me, thank you very much if your can reply.

try running `perf record -e fib6:*` and then run both route commands
above. After both have run, Ctrl-C on perf and then run `perf script`

