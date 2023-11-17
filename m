Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81577EF23F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjKQMGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:06:20 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACB2C4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:06:17 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1462569b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700222777; x=1700827577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFm5Pu0agEK9a7iJvBBpcsBGBSXE9+wDQ7nErPyNqnY=;
        b=DK7B9YQCnRFzzbVXiVgUtLE/+04ba5a3V5C82TqZBvy4PsvGMJ5Yr4ltCKuEZk70+F
         RDqeUHsNhTLNVm/31HmdohcpnozZ8lrQJqLdSi9EL6MVLm2YalV/CnaTBFDP0EbakqoH
         SeuVlNbY4FDuNZnD8fQ81vg4EWc0A+pvb0kGuA3n5/U65PUz3hV1rALtHX6xk1K3lhZs
         sakspbE8p8BI8hcj7GRuXrD5dkYE3df0DpyaroI8qTicnhAf2MOjAqV/gQ+p+mALbh5V
         tqrVlzRQFZSd72KN3Q1R1oseWIgH+vEr8v27/8BJqUT+q7JyIicHjJ+5oOBhV3uWX0PW
         hODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700222777; x=1700827577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFm5Pu0agEK9a7iJvBBpcsBGBSXE9+wDQ7nErPyNqnY=;
        b=E43Sk663EvWw3IkBccHbcx8GjDO4AX+KNTnZnlO8QI3GeTDSFa66ukXISEiBU5qKDj
         17kzokoI0nLYN8BxvEN4WW8YHURft7PYyLHECbgkkws47TIrwMfwtc2vU8EEfqZNW2XN
         Jvy1Wu5JDu9zO/UjbjDQvXZX/hm6ptegUVR8Eo9z6Veql2jNg5U7t1lF+qDENmntiqg0
         pNJNJgiNNLYnv7o7ZbaFVYio0gq48LBd/a8KfmqTVp+CmIwTOpLFAwB8mr4IWgtobb7V
         y9/7Dxbb4ay1WA7vX5WRjfsfCBSOOVEUNmeFJzXkL2kxTwZsSPVv/+x4FCkR/ojNtO13
         2Z9Q==
X-Gm-Message-State: AOJu0Yy/xQVEbykIChkORqdFou32X6yWB3BaebLuEykMDf27Jy9PKR0a
        ES2uBAYRgGmn9PvgUtrtIxSYQg==
X-Google-Smtp-Source: AGHT+IG5/JAITrdtmzXFF8GueoT0ZXmJ4X6D5BBH37fSr59QAckV81gP7OL0XDyQTobtzutUDO6rgQ==
X-Received: by 2002:a05:6a00:310f:b0:6c4:d6fa:ee9d with SMTP id bi15-20020a056a00310f00b006c4d6faee9dmr6293709pfb.1.1700222776972;
        Fri, 17 Nov 2023 04:06:16 -0800 (PST)
Received: from ?IPV6:2804:14d:5c5e:44fb:7741:c354:44be:5c3f? ([2804:14d:5c5e:44fb:7741:c354:44be:5c3f])
        by smtp.gmail.com with ESMTPSA id g31-20020a63565f000000b005891f3af36asm1262704pgm.87.2023.11.17.04.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 04:06:16 -0800 (PST)
Message-ID: <b9a9aaef-a306-4fcf-83df-28140d9311bf@mojatatu.com>
Date:   Fri, 17 Nov 2023 09:06:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sched: Fix restricted __be16 degrades to integer
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231117101815.1867175-1-chentao@kylinos.cn>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231117101815.1867175-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 07:18, Kunwu Chan wrote:
> net/sched/cls_api.c:2010:25: warning: restricted __be16 degrades to integer
> net/sched/cls_api.c:2695:50: warning: restricted __be16 degrades to integer
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>   net/sched/cls_api.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index f73f39f61f66..4c47490eb0c1 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2007,7 +2007,7 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
>   		tcm->tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
>   		tcm->tcm_block_index = block->index;
>   	}
> -	tcm->tcm_info = TC_H_MAKE(tp->prio, tp->protocol);
> +	tcm->tcm_info = TC_H_MAKE(tp->prio, be16_to_cpu(tp->protocol));
>   	if (nla_put_string(skb, TCA_KIND, tp->ops->kind))
>   		goto nla_put_failure;
>   	if (nla_put_u32(skb, TCA_CHAIN, tp->chain->index))
> @@ -2692,7 +2692,7 @@ static bool tcf_chain_dump(struct tcf_chain *chain, struct Qdisc *q, u32 parent,
>   		    TC_H_MAJ(tcm->tcm_info) != tp->prio)
>   			continue;
>   		if (TC_H_MIN(tcm->tcm_info) &&
> -		    TC_H_MIN(tcm->tcm_info) != tp->protocol)
> +		    TC_H_MIN(tcm->tcm_info) != be16_to_cpu(tp->protocol))
>   			continue;
>   		if (*p_index > index_start)
>   			memset(&cb->args[1], 0,

I don't believe there's something to fix here
