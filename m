Return-Path: <linux-kernel+bounces-136768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851A089D7F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C791F255C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C512B175;
	Tue,  9 Apr 2024 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Ft6gJj7a"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235F86AF4;
	Tue,  9 Apr 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662292; cv=none; b=rzJM9ROrwHpjAwnAZ/sBGp07AMHRYcO+BS4tgMKooV1nboTHgKCekhmJpnLJSxx+sIcK6k9LxRc390tfsZAfRXON7Hnbxu25N3q5UWA4yexjiQAKi3S0kGWMHXP4hmsJEMgqfHIPygK9BBuGqoqC09h3U2mxQZvZMYoeIO8PJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662292; c=relaxed/simple;
	bh=KrtG11jsWt0L92meyAZwvjNrnN2k6Bpq7GNwODxPiUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUePPBpMVHatzmCup1WCrNC1dYkthMJuUGNXZNs0H5oh6+dXBvcnj0fWO7/qNgHe05JhBrJv97VV/oojaKCknsu9+nl/DlH+bSit+BFecOH4zetcmWm0Ycaqh/4HM/YGrk6W6VmHd4siP46eYl6Hor053o1d1tt+EU07pOoJ8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Ft6gJj7a; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 034A3600A5;
	Tue,  9 Apr 2024 11:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712662286;
	bh=KrtG11jsWt0L92meyAZwvjNrnN2k6Bpq7GNwODxPiUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ft6gJj7a4L1lyyqwTOAC+M1o1Y9L5HQ42QIsh8PVmiacf0yY+ankB+4N4uKn6gluZ
	 C1KrcKfOvi9se09nyfh7HbBXKkzTSjxMDrKOiQQNU7z6vHeL4rHBubCwEaSC7rYNAY
	 FTJ+WWR/SWgdn+MJ29bpEe6bUvKzdmg7LfURnICntFtdTRJ/A17rrIkwql3aS7LvLa
	 YomvZ2daTXwn+x8LxnJOjbIOUyXGxfvLf2X+EAv9SWpTCseqmt/+aoiTezjJ/r/7Bu
	 UUFpfXZbPHPNzcWX/jLdrWEGcxv+K878+PPKI54OoGXkUSktOaW0omz7qPzA9wSOe7
	 jiIHfYtIQzL1A==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id C345A200251;
	Tue, 09 Apr 2024 11:27:53 +0000 (UTC)
Message-ID: <e35f1f15-9c39-4e9c-a4af-bfa59e0e1a6f@fiberby.net>
Date: Tue, 9 Apr 2024 11:27:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] flow_offload: add
 flow_rule_no_unsupp_control_flags()
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
 <20240408130927.78594-2-ast@fiberby.net>
 <DM4PR13MB588247E7A37F98213BD0B9C4E7072@DM4PR13MB5882.namprd13.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <DM4PR13MB588247E7A37F98213BD0B9C4E7072@DM4PR13MB5882.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baowen,

On 4/9/24 1:56 AM, Baowen Zheng wrote:
> On April 8, 2024 9:09 PM,  Asbjørn wrote:
> 
>> This helper can be used by drivers to check for the presence of unsupported
>> control flags.
>>
>> It mirrors the existing check done in sfc:
>>   drivers/net/ethernet/sfc/tc.c +276
>>
>> This is aimed at drivers, which implements some control flags.
>>
>> This should also be used by drivers that implement all current flags, so that
>> future flags will be unsupported by default.
>>
>> Only compile-tested.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>> include/net/flow_offload.h | 22 ++++++++++++++++++++++
>> 1 file changed, 22 insertions(+)
>>
>> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h index
>> 314087a5e1818..c1317b14da08c 100644
>> --- a/include/net/flow_offload.h
>> +++ b/include/net/flow_offload.h
>> @@ -449,6 +449,28 @@ static inline bool flow_rule_match_key(const struct
>> flow_rule *rule,
>>         return dissector_uses_key(rule->match.dissector, key);  }
>>
>> +/**
>> + * flow_rule_no_unsupp_control_flags() - check for unsupported control
>> +flags
>> + * @supp_flags: flags supported by driver
>> + * @flags: flags present in rule
>> + * @extack: The netlink extended ACK for reporting errors.
>> + *
>> + * Returns true if only supported control flags are set, false otherwise.
>> + */
>> +static inline bool flow_rule_no_unsupp_control_flags(const u32 supp_flags,
>> +                                                    const u32 flags,
>> +
> Hi Asbjørn, thanks for your work, it makes sense for driver check. Will it better to name flags as "ctrl_flags" to make it more clear since it indicates the ctrl_flags in rule and you name it as control.flags in the following print message.

Good point, I will rename that argument in v2.

I copied the error message verbatim from sfc.

>                                                     struct
>> +netlink_ext_ack *extack) {
>> +       if (likely((flags & ~supp_flags) == 0))
>> +               return true;
>> +
>> +       NL_SET_ERR_MSG_FMT_MOD(extack,
>> +                              "Unsupported match on control.flags %#x",
>> +                              flags);
>> +
>> +       return false;
>> +}
>> +
>> struct flow_stats {
>>         u64     pkts;
>>         u64     bytes;
>> --
> This should not be included in this patch.

It's the default 3 lines of context, as is default in git format-patch.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

