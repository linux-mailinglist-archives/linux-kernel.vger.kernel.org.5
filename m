Return-Path: <linux-kernel+bounces-157343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDBE8B101A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1081C2470C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2B16C6B7;
	Wed, 24 Apr 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="otKxIOsd"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3B15ECC7;
	Wed, 24 Apr 2024 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977010; cv=none; b=WwyPY3NsVYQKQH67G1ceR3A1+8YKKAJvlzGhVw/D/m9twPC+53AAgXzNUet4Zp/6kQCLTlvKvrRjzuYJmlNIVLeEIE2gAclU6Mhg42il8rb8dCIr4+vMtcd67ji3hVBPOBl956jj0/rEBw5czK7xMEQ5us6ZMG2szjo+zrvJhC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977010; c=relaxed/simple;
	bh=4lFQdEjkvGXYmHpN1Zb/f8Uu/Vk5mUCIUFY3zg5YBxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSB83YqQJ4QzaOvrNj7aPj4B2MhxgORw6AAqMn/Xhqf9OeyG6UJeuXeayvc3MDDFTfzXPMI7lbYDpe4EdQEncR3iS9RhIhGDMPDZason2maitVtKWFN2QmlFtE7Bb9AajebwEJeDPkmC5eisjiTgE1CHaeKHKbLAvSjHlXJyYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=otKxIOsd; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id EF0D5600A2;
	Wed, 24 Apr 2024 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713977005;
	bh=4lFQdEjkvGXYmHpN1Zb/f8Uu/Vk5mUCIUFY3zg5YBxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=otKxIOsdTbl7M4gl1ogesMJKcWgj05WkzcyBiUiwKASacEuskc6qJ0v9ntQTEfA0D
	 VfGvBIZ+5jGsV0BvNGaq+7WKMVBkh6/gGWpY7723scd5r6GaXKJvdQy4cbXJOcFgHc
	 Vtoi84nkWobSZp3Y28O0uwfd1tCt3tbW8TAZyTBmia7kXNwluJL2D+t6R791lgm044
	 qMMPHiaTg7QkChsNldJDbjedcsXWRdcgh6XcoAiPaZ4BX0mYcZ6yqormgwKlL8SV9d
	 xdHlo32UtXKbsPWPJXDUMdZ0HQLRxbo4jNml4POyMmt7gRYGHkg5zVZ8/ZRHGOc4OH
	 DoX9XpFTN9fzQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id E39D9201C3F;
	Wed, 24 Apr 2024 16:43:14 +0000 (UTC)
Message-ID: <923135c6-1bd1-414d-b574-c201644d35ab@fiberby.net>
Date: Wed, 24 Apr 2024 16:43:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: qede: flower: validate control flags
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>
References: <20240424134250.465904-1-ast@fiberby.net>
 <Zikcq2S90S97h7Z0@nanopsycho>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <Zikcq2S90S97h7Z0@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jiri,

On 4/24/24 2:52 PM, Jiri Pirko wrote:
> Wed, Apr 24, 2024 at 03:42:48PM CEST, ast@fiberby.net wrote:
>> This driver currently doesn't support any flower control flags.
>>
>> Implement check for control flags, such as can be set through
>> `tc flower ... ip_flags frag`.
>>
>> Since qede_parse_flow_attr() are called by both qede_add_tc_flower_fltr()
>> and qede_flow_spec_to_rule(), as the latter doesn't having access to
>> extack, then flow_rule_*_control_flags() can't be used in this driver.
> 
> Why? You can pass null.

Ah, I see. I hadn't traced that option down through the defines,
I incorrectly assumed that NL_SET_ERR_MSG* didn't allow NULL.

Currently thinking about doing v2 in this style:

if (flow_rule_match_has_control_flags(rule, extack)) {
         if (!extack)
                 DP_NOTICE(edev, "Unsupported match on control.flags");
         return -EOPNOTSUPP;
}

pw-bot: changes-requested

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

