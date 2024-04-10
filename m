Return-Path: <linux-kernel+bounces-138411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A248289F0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FE81F21F21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD86615D5C0;
	Wed, 10 Apr 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="o1fFTQYC"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A215CD53;
	Wed, 10 Apr 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748496; cv=none; b=IDx5XYXxuA6mkPVicMigXF+bWWbzWlJNzCJhBQy7tjPpkvmWDC6NAF2NpU3cfnwbHHlvKbG5tPBCvt3HbFBRqwyjV7qMyMAYjtF7MtWqxxtfewO/ihxx39mJIvLUQCbgs89SrW+62cm9YxWc+t4tafoBcB0eI0yVoY8WlcKG6Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748496; c=relaxed/simple;
	bh=iSGZYzDz5WFUw1mxkgJEXJyBYVpthNiTyJJK1sa2BSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1bNm4f5KvCH/Zu3D29FBBqODsQddMmClwJQUh4Lry8Pf+6Jw7GLMIY0SFlCpuavB+ngE/lhy/B30AmM7Qzqbujwsg9rPmNVakJ09WOzYTLVEGJCeZMKhSn7XfQL2u/nSATqLkuFypvL6JQKljk7WQ4URYHO8n+iEIgGRt+/oXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=o1fFTQYC; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8C9E5600A5;
	Wed, 10 Apr 2024 11:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712748489;
	bh=iSGZYzDz5WFUw1mxkgJEXJyBYVpthNiTyJJK1sa2BSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o1fFTQYCJdIxHcXtbMfU/J5kn3DmedMcwhnqb1AmrteQauXo0jwTYI88m60aaH44y
	 kEdb9QEGawiyB1Hntx94Os6j9wtGBJ/sfmsoGp7XU3kZUEOudu2u5QWkSI2SgorEep
	 CSUeMIxlkBKxgUFxi5jRoSVsGOBP/xcTYiSVwG5lkfO/MQSNbLk6cr82UF8pwGYXaf
	 xtTa5R71nudOKPc34RYk9yTAsw/mM07fVarAQcviKIdtCncwmO18od6UzatIpm1kCg
	 +aKmKHiSd/TywV3Z5wMJAs4y3AycBNC3BIrn20DZ4BSuLT3PfoNdSbiy9LEB+FsG5z
	 Dwuz4LRX5TRVg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id D2E1D20038B;
	Wed, 10 Apr 2024 11:27:59 +0000 (UTC)
Message-ID: <628da266-fe6a-4e4d-8fc0-9d416dc39eaa@fiberby.net>
Date: Wed, 10 Apr 2024 11:27:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] flow_offload: add control flag checking
 helpers
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 Louis Peens <louis.peens@corigine.com>, Yanguo Li <yanguo.li@corigine.com>,
 oss-drivers@corigine.com, Taras Chornyi <taras.chornyi@plvision.eu>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <20240410093235.5334-1-ast@fiberby.net>
 <20240410093235.5334-2-ast@fiberby.net>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240410093235.5334-2-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/24 9:32 AM, Asbjørn Sloth Tønnesen wrote:
> These helpers aim to help drivers, with checking
> for the presence of unsupported control flags.
> 
> For drivers supporting at least one control flag:
>    flow_rule_is_supp_control_flags()
> 
> For drivers using flow_rule_match_control(), but not using flags:
>    flow_rule_has_control_flags()
> 
> For drivers not using flow_rule_match_control():
>    flow_rule_match_has_control_flags()
> 
> While primarily aimed at FLOW_DISSECTOR_KEY_CONTROL
> and flow_rule_match_control(), then the first two
> can also be used with FLOW_DISSECTOR_KEY_ENC_CONTROL
> and flow_rule_match_enc_control().
> 
> These helpers mirrors the existing check done in sfc:
>    drivers/net/ethernet/sfc/tc.c +276
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>   include/net/flow_offload.h | 55 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
> index 314087a5e1818..9ee3ad4a308a8 100644
> --- a/include/net/flow_offload.h
> +++ b/include/net/flow_offload.h
> @@ -449,6 +449,61 @@ static inline bool flow_rule_match_key(const struct flow_rule *rule,
>   	return dissector_uses_key(rule->match.dissector, key);
>   }
>   
> +/**
> + * flow_rule_is_supp_control_flags() - check for supported control flags
> + * @supp_flags: control flags supported by driver
> + * @ctrl_flags: control flags present in rule
> + * @extack: The netlink extended ACK for reporting errors.
> + *
> + * @returns true if only supported control flags are set, false otherwise.
> + */


The kdoc test failed:
 > include/net/flow_offload.h:463: warning: No description found for return value of 'flow_rule_is_supp_control_flags'

For some reason I didn't find kernel-doc.rst, because I searched for autodoc sphinx stuff.

Will do proper "Return:" in v3.

I wasn't able to reproduce the kdoc failure[1] locally:

$ ./scripts/kernel-doc -none include/net/flow_offload.h
$ ./scripts/kernel-doc -none -v include/net/flow_offload.h
include/net/flow_offload.h:345: info: Scanning doc for function flow_offload_has_one_action
include/net/flow_offload.h:453: info: Scanning doc for function flow_rule_is_supp_control_flags
include/net/flow_offload.h:475: info: Scanning doc for function flow_rule_has_control_flags
include/net/flow_offload.h:488: info: Scanning doc for function flow_rule_match_has_control_flags

[1] https://netdev.bots.linux.dev/static/nipa/843159/13623977/kdoc/

pw-bot: changes-requested


> +static inline bool flow_rule_is_supp_control_flags(const u32 supp_flags,
> +						   const u32 ctrl_flags,
> +						   struct netlink_ext_ack *extack)
> +{
> +	if (likely((ctrl_flags & ~supp_flags) == 0))
> +		return true;
> +
> +	NL_SET_ERR_MSG_FMT_MOD(extack,
> +			       "Unsupported match on control.flags %#x",
> +			       ctrl_flags);
> +
> +	return false;
> +}
> +
> +/**
> + * flow_rule_has_control_flags() - check for presence of any control flags
> + * @ctrl_flags: control flags present in rule
> + * @extack: The netlink extended ACK for reporting errors.
> + *
> + * @returns true if control flags are set, false otherwise.
> + */
> +static inline bool flow_rule_has_control_flags(const u32 ctrl_flags,
> +					       struct netlink_ext_ack *extack)
> +{
> +	return !flow_rule_is_supp_control_flags(0, ctrl_flags, extack);
> +}
> +
> +/**
> + * flow_rule_match_has_control_flags() - match and check for any control flags
> + * @rule: The flow_rule under evaluation.
> + * @extack: The netlink extended ACK for reporting errors.
> + *
> + * @returns true if control flags are set, false otherwise.
> + */
> +static inline bool flow_rule_match_has_control_flags(struct flow_rule *rule,
> +						     struct netlink_ext_ack *extack)
> +{
> +	struct flow_match_control match;
> +
> +	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL))
> +		return false;
> +
> +	flow_rule_match_control(rule, &match);
> +
> +	return flow_rule_has_control_flags(match.mask->flags, extack);
> +}
> +
>   struct flow_stats {
>   	u64	pkts;
>   	u64	bytes;

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

