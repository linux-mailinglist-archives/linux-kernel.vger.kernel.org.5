Return-Path: <linux-kernel+bounces-34714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B5783867B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116E2289FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A03A210F;
	Tue, 23 Jan 2024 04:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AddHfXIH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4284400;
	Tue, 23 Jan 2024 04:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705985964; cv=none; b=NImqozgvRPC6gCIn8XFWMrQ9+0/oJb20iiSmmaCoALBeB5O6KVUK6lpklwnPLLffrhJDfCvh0D5k7E9qN5rAGzO5EEJOdz13uZSb4xQjhB/CzmV71dt97/vXmzVscYmPIgctk1RFxwxz9zaBwwL8Hreoh23Qgue6lOeny5Mtz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705985964; c=relaxed/simple;
	bh=ApZQ9VoLyfXDpKyhqM+8FaPkC3Zfhdt/ukiSEDuybXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcNJq/+ZQc4aEBGkDnnhLPnYEdGR+FnyODekleEvc5cLqICzNBm2Z7MeSPM/271OMAbK+cKgy/LWXTmOvhlNAvKTgsNWp3lz9pAq0AZRsgO+9tilXEUW8ntjSBeIwMqV8siWQ2U9NyHFl3XwcG8wd4BT5irikTKwd9uqTguEmX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AddHfXIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8E9C433C7;
	Tue, 23 Jan 2024 04:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705985964;
	bh=ApZQ9VoLyfXDpKyhqM+8FaPkC3Zfhdt/ukiSEDuybXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AddHfXIHlhBKJqgtXct057VQxQH0SC/J77m29Z74Pdz5fXxwCojt5MpJvbLmU8N15
	 8YbnP4W4RhRraViNliJYTojC7/pDT1Po0a5T8Az9VBa/+RD6j+SaqJ/otikqxigRxp
	 ahoFANc5O06G7uGs2l923mcWl9OrFPBgaCTpaHFqtFLNAxn8IO6UUF8pisOdP8ZEU2
	 J0fHn0psL/TT2gcEx7IgPXrmjt5Jf8pnN1y1NmTR2mqZ9ZKg/KkvVqGOaKx58cJmQ4
	 wCJIdV/2U247mKtXfX7AW8dreFRnLxk/7loNzNqwl5ZjzwLZcRU/+YbrwwU07VnFiT
	 OOUgBtCpee61Q==
Message-ID: <0e12d8a0-4ef8-4b22-bc61-072247df47a7@kernel.org>
Date: Mon, 22 Jan 2024 21:59:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Discuss]iproute2: ipv6 route add fail
Content-Language: en-US
To: gaoxingwang <gaoxingwang1@huawei.com>, edumazet@google.com
Cc: davem@davemloft.net, liaichun@huawei.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, yanan@huawei.com,
 yoshfuji@linux-ipv6.org
References: <CANn89iK05tppo0neGmKTdU-Dp8Dap6ayxda-++Z3LRp3DFrq+w@mail.gmail.com>
 <20240123030813.2493801-1-gaoxingwang1@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240123030813.2493801-1-gaoxingwang1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/24 8:08 PM, gaoxingwang wrote:
>>> Hello everyone,
>>>
>>> Here is a particular problem with routing.
>>> Sometimes users can run the ip -6 route command to add a route whose destination address is the same as the gateway address, and it can be successfully added. However, adding another route with the same gateway address will fail later.
>>>
>>> Example:
>>> # ip -6 route add 2409:8080:5a0a:60c7::7/128 via 2409:8080:5a0a:60c7::7 dev eth2

I missed that this is a self-referencing route. This one really should
fail because it adds itself as a gateway.

>>> # ip -6 route add 2409:8080:5a0a:60c7::8/128 via 2409:8080:5a0a:60c7::7 dev eth2
>>> RTNETLINK answers: No route to host

and this one fails because of the above self referencing route; see
ip6_route_check_nh:

        err = ip6_nh_lookup_table(net, cfg, gw_addr,
                                  cfg->fc_table, flags, &res);
        /* gw_addr can not require a gateway or resolve to a reject
         * route. If a device is given, it must match the result.
         */


>>>
>>> Does the kernel not support this application scenario?

you need to remove the host route that adds a gateway as itself


