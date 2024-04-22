Return-Path: <linux-kernel+bounces-152978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93078AC704
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3D21F21907
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996653F8ED;
	Mon, 22 Apr 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Qb0JHkTD"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A53D6B;
	Mon, 22 Apr 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774719; cv=none; b=tOGR7Mq8EeMUAxv+VT9oATu5scMESKETDS4FAG4sxwTAYLDh+FOqUG6LxveUf0R/mADMDsq2xzoutAf1ITRtjsFD3sD1vBTVssyIjOArqQBbL54g+aACiyhbEedHskqWyhnbsXg4EBIslkgfRL/HF1ADXVfmC5487sn50GEtitk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774719; c=relaxed/simple;
	bh=jrYGl7sNNl2Fe3kJVpIabxToZJezOrrnFG6Xq1JJMF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jw4W5xexYU209Xw0EKv+S6rFuKjKHbNjTYoygde5fDoa/6QgYsw1QPmCrgT3e6DosT1XEa3JxeKmKawbDUVV2pmeYJ/1YYiZTuydpDgXTzWpg+a9FD1q/uB+P0SgOm5PVsgeNyrnet9uwZofOtpe1c9snv6CICp8YOGHNOvyUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Qb0JHkTD; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E20D2600A7;
	Mon, 22 Apr 2024 08:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713774708;
	bh=jrYGl7sNNl2Fe3kJVpIabxToZJezOrrnFG6Xq1JJMF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qb0JHkTDjW8hRfXpMa33I+3+HBesPdqMHTjX6d++1dk+C3e9I9dqMR0SoF9esi42j
	 XBxpqVUea9ZWDRon2SCuKx7F+p0uJfSx9z2aCe1/2USAnQZG5W7mF0lGCVJ79vsQwG
	 HEw3hzlvAvXPArqTS6sRhSnYKHmFkQMWWlVhgWbrgHkSqZ2KQ4nN2fCY+5Pab1g2TY
	 SY+oEey2PG4mSAd+ubFJz5TraEko8E674J8QFj/KLcI+/sKQ8Eee/0WhcI2axAiGUy
	 9PU52HnSCVWV9pMhCCUnKa9MZkYx4kfOtYPYDupuvgWK5l1Z8nzpjlyFpU4Udqy7V+
	 sFx2geXFpAmGQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id E930D20401F;
	Mon, 22 Apr 2024 08:31:35 +0000 (UTC)
Message-ID: <5fbbedde-92c1-4b0a-aeb4-cb17ecd01d5b@fiberby.net>
Date: Mon, 22 Apr 2024 08:31:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: flower: check for unsupported control
 flags
To: Jianbo Liu <jianbol@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
 Tariq Toukan <tariqt@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>
References: <20240417135110.99900-1-ast@fiberby.net>
 <16bc67f3767644005a26affad3cbd96f6319ca98.camel@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <16bc67f3767644005a26affad3cbd96f6319ca98.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jianbo,

Thank you for the review.

On 4/22/24 6:58 AM, Jianbo Liu wrote:
> On Wed, 2024-04-17 at 13:51 +0000, Asbjørn Sloth Tønnesen wrote:
>> Use flow_rule_is_supp_control_flags() to reject filters with
>> unsupported control flags.
>>
>> In case any unsupported control flags are masked,
>> flow_rule_is_supp_control_flags() sets a NL extended
>> error message, and we return -EOPNOTSUPP.
>>
>> Only compile-tested.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> index aeb32cb27182..5019280cfcdd 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> @@ -2819,6 +2819,11 @@ static int __parse_cls_flower(struct
>> mlx5e_priv *priv,
>>                          else
>>                                  *match_level = MLX5_MATCH_L3;
>>                  }
>> +
>> +               if
>> (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT |
>> +
>> FLOW_DIS_FIRST_FRAG,
> 
> We reject FLOW_DIS_FIRST_FRAG at several lines above. I think you can
> remove those lines and add FLOW_DIS_IS_FRAGMENT as the only supported
> flag here.

Sure, I can do that. I originally kept it, since the error message was
more user-friendly.


-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

