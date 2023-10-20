Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB087D1503
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377895AbjJTRlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjJTRlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:41:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874A9126
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:41:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b2018a11efso1025209b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697823675; x=1698428475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGbVQasln/jrbpxM5bbU/VVQ+qKhLEyPaP52SP0T2Pw=;
        b=ertHjJI7GJ3r/r7hVezdJF/E/V5he+iyAtvR9MjN0m/2qZwHKgi9IpDHmTQNMI2uf/
         6CN9gVNhptM5ujT07w59oowW5JAphR6lU2KXxNvKEXU+5Zl46LPYU3kXTO5XqG3k6hwz
         yS1bdw8nbFWWiFSJh5DnHjz+03LbbXLHplNhp8dCt+oL2TpXsbKdLGd1XlBAPQqTVg8p
         wup+pdOZyy7PIDEkprAkCI5ZMJBRc7yc9OnxkzZO6JMePr2wLVwGEHv/OC0QZBcQf9DY
         l6NFrQGWg8LfWeQdOqhONdKLjdlDOqNtwLJvxQ+3C4m/AW1tGCnJkeIm9HNAoGQbEDK3
         1WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823675; x=1698428475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGbVQasln/jrbpxM5bbU/VVQ+qKhLEyPaP52SP0T2Pw=;
        b=Vm+s6SQM2Tt3fehaHVmAYsDfASEnzoInGNSWZJSKGn44XV5YLRtM9RZPAKOctSEPmJ
         YNOgLT1VyRXnGM8/YIcGIj1FNE1afyCSc4LsdfMnTU5FhR919vquoXDWMg/r3zR/z5p7
         PNBy+y3CYGv6FglGZYvEaWEbBahJosdWQ4R9iDU/Pq9n5SxlTPY84S1VvNrdbFK9M3vX
         ZIJpgBCd8FCgSMkrxF5DBnW3pFtcMQU5jU7bq2AIyTmL2hPWOkrM9oEySCRmMQB5oiWU
         1SFTtzT7ZqMY38eaC8cLOOdzrkeRhQ/GP9F6rbaVpjCsUpdzgOi043wnWQgh1UDzUzFb
         U4Cw==
X-Gm-Message-State: AOJu0Yw+00dctG2M5g3hP41aDFqYx4n+UzfhmlUbfiK00zgLe0Zbyr3C
        FRmDkfR14cOWtJWEq4esFnviHQ==
X-Google-Smtp-Source: AGHT+IEz3/RiqJ5hsW008JMWSIPxul1/7O1/YL7eTgdjLk6JeEhWfPPB642yJZchfajqYPpu3xoZ+w==
X-Received: by 2002:a05:6a21:78a7:b0:14c:a2e1:65ec with SMTP id bf39-20020a056a2178a700b0014ca2e165ecmr2849436pzc.38.1697823674989;
        Fri, 20 Oct 2023 10:41:14 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:1ae7:ff4d:7ac7:3fe0? ([2804:14d:5c5e:44fb:1ae7:ff4d:7ac7:3fe0])
        by smtp.gmail.com with ESMTPSA id r8-20020aa79628000000b006905f6bfc37sm1795931pfg.31.2023.10.20.10.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:41:14 -0700 (PDT)
Message-ID: <0bb2989d-1be6-47d6-80da-76b0cf349033@mojatatu.com>
Date:   Fri, 20 Oct 2023 14:41:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] net: sched: extend flow action with RSS
To:     Hariprasad Kelam <hkelam@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kuba@kernel.org, davem@davemloft.n, sgoutham@marvell.com,
        edumazet@google.com, pabeni@redhat.com, xiyou.wangcong@gmail.com,
        jhs@mojatatu.com, jiri@resnulli.us
References: <20231020061158.6716-1-hkelam@marvell.com>
Content-Language: en-US
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231020061158.6716-1-hkelam@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2023 03:11, Hariprasad Kelam wrote:
> This patch extends current flow action with RSS, such that

..current skbedit action..

> the user can install flower offloads with action RSS followed
> by a group id. Since this is done in hardware skip_sw flag
> is enforced.
> 
> Example:
> In a multi rss group supported NIC,
> 
> rss group #1 flow hash indirection table populated with rx queues 1 to 4
> rss group #2 flow hash indirection table populated with rx queues 5 to 9
> 
> $tc filter add dev eth1 ingress protocol ip flower ip_proto tcp dst_port
> 443 action skbedit rss_group 1 skip_sw
> 
> Packets destined to tcp port 443 will be distributed among rx queues 1 to 4
> 
> $tc filter add dev eth1 ingress protocol ip flower ip_proto udp dst_port
> 8080 action skbedit rss_group 2 skip_sw
> 
> Packets destined to udp port 8080 will be distributed among rx queues
> 5 to 9
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>   include/net/flow_offload.h             |  2 ++
>   include/net/tc_act/tc_skbedit.h        | 18 ++++++++++++++++++
>   include/uapi/linux/tc_act/tc_skbedit.h |  2 ++
>   net/sched/act_skbedit.c                | 26 +++++++++++++++++++++++++-
>   4 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
> index 314087a5e181..efa45ed87e69 100644
> --- a/include/net/flow_offload.h
> +++ b/include/net/flow_offload.h
> @@ -168,6 +168,7 @@ enum flow_action_id {
>   	FLOW_ACTION_PTYPE,
>   	FLOW_ACTION_PRIORITY,
>   	FLOW_ACTION_RX_QUEUE_MAPPING,
> +	FLOW_ACTION_RSS,
>   	FLOW_ACTION_WAKE,
>   	FLOW_ACTION_QUEUE,
>   	FLOW_ACTION_SAMPLE,
> @@ -264,6 +265,7 @@ struct flow_action_entry {
>   		u16                     ptype;          /* FLOW_ACTION_PTYPE */
>   		u16			rx_queue;	/* FLOW_ACTION_RX_QUEUE_MAPPING */
>   		u32			priority;	/* FLOW_ACTION_PRIORITY */
> +		u16			rss_group_id;	/* FLOW_ACTION_RSS_GROUP_ID */
>   		struct {				/* FLOW_ACTION_QUEUE */
>   			u32		ctx;
>   			u32		index;
> diff --git a/include/net/tc_act/tc_skbedit.h b/include/net/tc_act/tc_skbedit.h
> index 9649600fb3dc..c4a122b49e94 100644
> --- a/include/net/tc_act/tc_skbedit.h
> +++ b/include/net/tc_act/tc_skbedit.h
> @@ -19,6 +19,7 @@ struct tcf_skbedit_params {
>   	u16 queue_mapping;
>   	u16 mapping_mod;
>   	u16 ptype;
> +	u16 rss_group_id;
>   	struct rcu_head rcu;
>   };
>   
> @@ -106,6 +107,17 @@ static inline u16 tcf_skbedit_rx_queue_mapping(const struct tc_action *a)
>   	return rx_queue;
>   }
>   
> +static inline u16 tcf_skbedit_rss_group_id(const struct tc_action *a)
> +{
> +	u16 rss_group_id;
> +
> +	rcu_read_lock();
> +	rss_group_id = rcu_dereference(to_skbedit(a)->params)->rss_group_id;
> +	rcu_read_unlock();
> +
> +	return rss_group_id;
> +}
> +
>   /* Return true iff action is queue_mapping */
>   static inline bool is_tcf_skbedit_queue_mapping(const struct tc_action *a)
>   {
> @@ -136,4 +148,10 @@ static inline bool is_tcf_skbedit_inheritdsfield(const struct tc_action *a)
>   	return is_tcf_skbedit_with_flag(a, SKBEDIT_F_INHERITDSFIELD);
>   }
>   
> +static inline bool is_tcf_skbedit_rss_group_id(const struct tc_action *a)
> +{
> +	return is_tcf_skbedit_ingress(a->tcfa_flags) &&
> +	       is_tcf_skbedit_with_flag(a, SKBEDIT_F_RSS_GROUP_ID);
> +}
> +
>   #endif /* __NET_TC_SKBEDIT_H */
> diff --git a/include/uapi/linux/tc_act/tc_skbedit.h b/include/uapi/linux/tc_act/tc_skbedit.h
> index 64032513cc4c..83f53550bb88 100644
> --- a/include/uapi/linux/tc_act/tc_skbedit.h
> +++ b/include/uapi/linux/tc_act/tc_skbedit.h
> @@ -17,6 +17,7 @@
>   #define SKBEDIT_F_MASK			0x10
>   #define SKBEDIT_F_INHERITDSFIELD	0x20
>   #define SKBEDIT_F_TXQ_SKBHASH		0x40
> +#define SKBEDIT_F_RSS_GROUP_ID		0x80
>   
>   struct tc_skbedit {
>   	tc_gen;
> @@ -34,6 +35,7 @@ enum {
>   	TCA_SKBEDIT_MASK,
>   	TCA_SKBEDIT_FLAGS,
>   	TCA_SKBEDIT_QUEUE_MAPPING_MAX,
> +	TCA_SKBEDIT_RSS_GROUP_ID,
>   	__TCA_SKBEDIT_MAX
>   };
>   #define TCA_SKBEDIT_MAX (__TCA_SKBEDIT_MAX - 1)
> diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
> index ce7008cf291c..127198239ac7 100644
> --- a/net/sched/act_skbedit.c
> +++ b/net/sched/act_skbedit.c
> @@ -112,6 +112,7 @@ static const struct nla_policy skbedit_policy[TCA_SKBEDIT_MAX + 1] = {
>   	[TCA_SKBEDIT_MASK]		= { .len = sizeof(u32) },
>   	[TCA_SKBEDIT_FLAGS]		= { .len = sizeof(u64) },
>   	[TCA_SKBEDIT_QUEUE_MAPPING_MAX]	= { .len = sizeof(u16) },
> +	[TCA_SKBEDIT_RSS_GROUP_ID]	= { .len = sizeof(u16) },
>   };
>   
>   static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
> @@ -126,8 +127,8 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
>   	struct tcf_chain *goto_ch = NULL;
>   	struct tc_skbedit *parm;
>   	struct tcf_skbedit *d;
> +	u16 *queue_mapping = NULL, *ptype = NULL, *rss_group_id = NULL;
>   	u32 flags = 0, *priority = NULL, *mark = NULL, *mask = NULL;
> -	u16 *queue_mapping = NULL, *ptype = NULL;
>   	u16 mapping_mod = 1;
>   	bool exists = false;
>   	int ret = 0, err;
> @@ -176,6 +177,17 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
>   		mask = nla_data(tb[TCA_SKBEDIT_MASK]);
>   	}
>   
> +	if (tb[TCA_SKBEDIT_RSS_GROUP_ID] != NULL) {
> +		if (!is_tcf_skbedit_ingress(act_flags) ||
> +		    !(act_flags & TCA_ACT_FLAGS_SKIP_SW)) {

nit: use tc_skip_sw()

> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "\"rss_group_id\" option allowed only on receive side with hardware only, use skip_sw");
> +			return -EOPNOTSUPP;
> +		}
> +		flags |= SKBEDIT_F_RSS_GROUP_ID;
> +		rss_group_id = nla_data(tb[TCA_SKBEDIT_RSS_GROUP_ID]);
> +	}
> +
>   	if (tb[TCA_SKBEDIT_FLAGS] != NULL) {
>   		u64 *pure_flags = nla_data(tb[TCA_SKBEDIT_FLAGS]);
>   
> @@ -262,6 +274,9 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
>   	if (flags & SKBEDIT_F_MASK)
>   		params_new->mask = *mask;
>   
> +	if (flags & SKBEDIT_F_RSS_GROUP_ID)
> +		params_new->rss_group_id = *rss_group_id;
> +
>   	spin_lock_bh(&d->tcf_lock);
>   	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>   	params_new = rcu_replace_pointer(d->params, params_new,
> @@ -326,6 +341,9 @@ static int tcf_skbedit_dump(struct sk_buff *skb, struct tc_action *a,
>   
>   		pure_flags |= SKBEDIT_F_TXQ_SKBHASH;
>   	}
> +	if ((params->flags & SKBEDIT_F_RSS_GROUP_ID) &&
> +	    nla_put_u16(skb, TCA_SKBEDIT_RSS_GROUP_ID, params->rss_group_id))
> +		goto nla_put_failure;
>   	if (pure_flags != 0 &&
>   	    nla_put(skb, TCA_SKBEDIT_FLAGS, sizeof(pure_flags), &pure_flags))
>   		goto nla_put_failure;
> @@ -362,6 +380,7 @@ static size_t tcf_skbedit_get_fill_size(const struct tc_action *act)
>   		+ nla_total_size(sizeof(u32)) /* TCA_SKBEDIT_MARK */
>   		+ nla_total_size(sizeof(u16)) /* TCA_SKBEDIT_PTYPE */
>   		+ nla_total_size(sizeof(u32)) /* TCA_SKBEDIT_MASK */
> +		+ nla_total_size(sizeof(u16)) /* TCA_SKBEDIT_RSS_GROUP_ID */
>   		+ nla_total_size_64bit(sizeof(u64)); /* TCA_SKBEDIT_FLAGS */
>   }
>   
> @@ -390,6 +409,9 @@ static int tcf_skbedit_offload_act_setup(struct tc_action *act, void *entry_data
>   		} else if (is_tcf_skbedit_inheritdsfield(act)) {
>   			NL_SET_ERR_MSG_MOD(extack, "Offload not supported when \"inheritdsfield\" option is used");
>   			return -EOPNOTSUPP;
> +		} else if (is_tcf_skbedit_rss_group_id(act)) {
> +			entry->id = FLOW_ACTION_RSS;
> +			entry->rss_group_id = tcf_skbedit_rss_group_id(act);
>   		} else {
>   			NL_SET_ERR_MSG_MOD(extack, "Unsupported skbedit option offload");
>   			return -EOPNOTSUPP;
> @@ -406,6 +428,8 @@ static int tcf_skbedit_offload_act_setup(struct tc_action *act, void *entry_data
>   			fl_action->id = FLOW_ACTION_PRIORITY;
>   		else if (is_tcf_skbedit_rx_queue_mapping(act))
>   			fl_action->id = FLOW_ACTION_RX_QUEUE_MAPPING;
> +		else if (is_tcf_skbedit_rss_group_id(act))
> +			fl_action->id = FLOW_ACTION_RSS;
>   		else
>   			return -EOPNOTSUPP;
>   	}

