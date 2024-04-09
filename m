Return-Path: <linux-kernel+bounces-136732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CB689D7B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50463282BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D114E86131;
	Tue,  9 Apr 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="NPlx3xSk"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA08593D;
	Tue,  9 Apr 2024 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661232; cv=none; b=nBlMFbXrgSDYP7qXZiQSvsC1wQ1kItAW2SxBh7goRzDEUY8EASlE9DXfBvIf7ovC3oZrc6dtG96bfxio2eqd3IK15krs9aFwu71mcLpeCuAa08slKisDXrLVkregcL+yVetldu+CrkEhQQwU2g7QwCK5zJcLLAFixrHARTOBmbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661232; c=relaxed/simple;
	bh=5bVejtBKpem9uNwEH+4qa25UXT6wHLuTwQMG/ZuVVxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLyfSfsBk+aF4wN/n/FNmrpsggv1l6zWoM8XceUwXr2DxIeKgduuVgGsmQxaf4T+k4BNfjkffksGPDfk/mQ1W/GuYnKy5flrnz2rv7WGSrj0ntxGkm7ceAXRUlcZKhNsam2W8nhF/u/Lrov4BkEfSHkj1uCsAO2nAil2SrTOXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=NPlx3xSk; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 17B06600A2;
	Tue,  9 Apr 2024 11:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712661225;
	bh=5bVejtBKpem9uNwEH+4qa25UXT6wHLuTwQMG/ZuVVxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NPlx3xSkfUiMDONhRbRsqPpV+K1d2QECtICZ0PCzvIi/FQ9hoJifUC9lY/42UM9RF
	 w3XruSMWqTXl9FtLnPEloIVnZhzIK/A5md/K56AkZOgNjzxl3c9oFCjMjeq+C0nJ2Y
	 P1EiqXucYSz3yKeHnoa4+3iMXNvmosE/oiHkAP66cEBKJEAdV9dwlD70/DKbqEpiFr
	 3sUqFF/gxksTcusQPcfg9bB0vOttXMbM2qF1QCRjt3bCpRHkSTuBRX3zyo0Et5f5uy
	 8QApBPWgNL+3+vRx4bgw5rUmvmMRlSVoE8EpDI1X9oKqkxtPW3kEAVQP55+EIfMppb
	 fF9xP8vWu848g==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id F200B200A3D;
	Tue, 09 Apr 2024 11:13:22 +0000 (UTC)
Message-ID: <2c7bc566-c975-4dd8-a17c-10c7b9ff3928@fiberby.net>
Date: Tue, 9 Apr 2024 11:13:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] flow_offload: add
 flow_rule_no_unsupp_control_flags()
To: Louis Peens <louis.peens@corigine.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Taras Chornyi <taras.chornyi@plvision.eu>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yanguo Li <yanguo.li@corigine.com>, oss-drivers@corigine.com,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <20240408130927.78594-1-ast@fiberby.net>
 <20240408130927.78594-2-ast@fiberby.net> <ZhT/E1qDsMmMxGwb@LouisNoVo>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <ZhT/E1qDsMmMxGwb@LouisNoVo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 4/9/24 8:40 AM, Louis Peens wrote:
> On Mon, Apr 08, 2024 at 01:09:19PM +0000, Asbjørn Sloth Tønnesen wrote:
>> [Some people who received this message don't often get email from ast@fiberby.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> This helper can be used by drivers to check for the
>> presence of unsupported control flags.
>>
>> It mirrors the existing check done in sfc:
>>    drivers/net/ethernet/sfc/tc.c +276
>>
>> This is aimed at drivers, which implements some control flags.
>>
>> This should also be used by drivers that implement all
>> current flags, so that future flags will be unsupported
>> by default.
>>
>> Only compile-tested.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>   include/net/flow_offload.h | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
>> index 314087a5e1818..c1317b14da08c 100644
>> --- a/include/net/flow_offload.h
>> +++ b/include/net/flow_offload.h
>> @@ -449,6 +449,28 @@ static inline bool flow_rule_match_key(const struct flow_rule *rule,
>>          return dissector_uses_key(rule->match.dissector, key);
>>   }
>>
>> +/**
>> + * flow_rule_no_unsupp_control_flags() - check for unsupported control flags
>> + * @supp_flags: flags supported by driver
>> + * @flags: flags present in rule
>> + * @extack: The netlink extended ACK for reporting errors.
>> + *
>> + * Returns true if only supported control flags are set, false otherwise.
>> + */
>> +static inline bool flow_rule_no_unsupp_control_flags(const u32 supp_flags,
>> +                                                    const u32 flags,
>> +                                                    struct netlink_ext_ack *extack)
> Thanks for the change Asbjørn, I like the series in general. I do have
> some nitpicking with the naming of this function, the double negative
> makes it a bit hard to read. Especially where it gets used, where it
> then reads as:
>      'if not no unsupported'
> 
> I think something like:
>      'if not supported'
> or
>      'if unsupported'
> 
> will read much better - personally I think the first option is the best,
> otherwise you might end up with 'if not unsupported', which is also
> weird.
> 
> Some possible suggestions I can think of:
>      flow_rule_control_flags_is_supp()
>      flow_rule_is_supp_control_flags()
>      flow_rule_check_supp_control_flags()
> 
> or perhaps some even better variant of this. I hope it's not just me, if
> that's the case please feel free to ignore.
I agree, I will update the naming in v2:

flow_rule_no_unsupp_control_flags             => flow_rule_is_supp_control_flags
flow_rule_no_control_flags        + s/no/has/ => flow_rule_has_control_flags
flow_rule_match_no_control_flags  + s/no/has/ => flow_rule_match_has_control_flags

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

