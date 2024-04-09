Return-Path: <linux-kernel+bounces-136767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83B789D7EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BC6289494
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0527129E81;
	Tue,  9 Apr 2024 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="GP/brSoG"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2527786269;
	Tue,  9 Apr 2024 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662291; cv=none; b=KnEhCaJq8a/+5gcuz7jS4EIguHXlGOoMuwunkVakUfLdpyo6Tqd3Mzu/BRxgjxSPzfp/CuFtEbNxfAmKxMVSJVzJERkVav+AkORZp4dsZvP75+uQDcuRlHY2QZHwBXH/TicxvfpOnXO84Zo05EzjPwTCYtQf4k7UeEG1yCEbmA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662291; c=relaxed/simple;
	bh=rm1QdbQ5uW835B6nce57jWAfuuDhA8pehQI5461e4TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSrQnEIvxn3Zs18/3u+tB4l2Z9cUf6+9sX7ygBFajBB9lfMipOqCI0fd4vz7ljczZfnM44r2e8X9Vn1A51bbTAHs/f5ffVz16fFQcWcFLRrsY33qDkj2Gtm+BfLauYFIG/Pp86DHrFjLWPbtArnR0w7ItcV6OL8zGUtffhRBEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=GP/brSoG; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C05EC600A2;
	Tue,  9 Apr 2024 11:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712662285;
	bh=rm1QdbQ5uW835B6nce57jWAfuuDhA8pehQI5461e4TY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GP/brSoGAVzWjHUe8MJi8zpoKrisXc08/3+hy2vQPPUfi+I5zfcEuo6JO9N0MEFPe
	 D1JIINqniu2Uncb8PgN7LNGtuaMmdW9ove/C6tIfomDTfELZq7l0Vez64C9mDajdHS
	 S8Ihi+DhBQCEeViefdnWXGu0uuiAJAva2htLvBaQlnSAOewPdL9PSPj3dnm+fhxCLR
	 siST75q+UdxAN8dFgNdSzYU+ot2iaGKl5r1UM+TkBXjrJXjI3Qr3hH/29192EDRrV7
	 uJKQWxhx1Dwo5WCeDwik9a6z4Yq5cK/FyCCPHldfIw0IQusq51sSUEN7TVl6s23Y3l
	 FEW+pZKBhDuKw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 2CC7C200221;
	Tue, 09 Apr 2024 11:31:16 +0000 (UTC)
Message-ID: <bfb88a63-c3be-4d05-9868-877570e9eea5@fiberby.net>
Date: Tue, 9 Apr 2024 11:31:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] flow_offload: add
 flow_rule_no_control_flags()
To: Baowen Zheng <baowen.zheng@corigine.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Louis Peens <louis.peens@corigine.com>,
 Taras Chornyi <taras.chornyi@plvision.eu>,
 Woojung Huh <woojung.huh@microchip.com>,
 "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yanguo Li <yanguo.li@nephogine.com>, oss-drivers <oss-drivers@corigine.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <20240408130927.78594-1-ast@fiberby.net>
 <20240408130927.78594-4-ast@fiberby.net>
 <DM4PR13MB5882C0B494203376530F33E6E7072@DM4PR13MB5882.namprd13.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <DM4PR13MB5882C0B494203376530F33E6E7072@DM4PR13MB5882.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baowen,

On 4/9/24 2:09 AM, Baowen Zheng wrote:
> On April 8, 2024 9:09 PM, Asbjørn wrote:
> 
>> This helper can be used by drivers, that doesn't support any control flags, to
>> reject any attempt to install rules with control flags.
>>
>> This is aimed at drivers, which uses flow_rule_match_control(), but doesn't
>> implement any control flags.
>>
>> Only compile-tested.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>> include/net/flow_offload.h | 13 +++++++++++++
>> 1 file changed, 13 insertions(+)
>>
>> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h index
>> c1317b14da08c..415d225204a1f 100644
>> --- a/include/net/flow_offload.h
>> +++ b/include/net/flow_offload.h
>> @@ -471,6 +471,19 @@ static inline bool
>> flow_rule_no_unsupp_control_flags(const u32 supp_flags,
>> 	return false;
>> }
>>
>> +/**
>> + * flow_rule_no_control_flags() - check for presence of any control
>> +flags
>> + * @flags: flags present in rule
>> + * @extack: The netlink extended ACK for reporting errors.
>> + *
>> + * Returns true if no control flags are set, false otherwise.
>> + */
>> +static inline bool flow_rule_no_control_flags(const u32 flags,
>> +					      struct netlink_ext_ack *extack) {
>> +	return flow_rule_no_unsupp_control_flags(0, flags, extack); }
>> +
> How about to squash this change with series I patch since they have similar functions for driver to use.

Do you have a link to the series, couldn't find it on the netdev list.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

