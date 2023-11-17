Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516877EF245
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbjKQMGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQMGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:06:52 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75784B9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:06:49 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so1530746a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700222809; x=1700827609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mh9tUJDuns9YEWMfiG7SwEu1WyJUjncM3Z8yl4XlzMU=;
        b=vYIYjoYMBhkJV3wlMbdcXeamqepKwo6Rf/GK2d5aqa16B7/q9ILMimYjUcyepU0nO7
         gjWkhgPY/n9JCI8bTqpAs/grCDmWAFECmW+c9uq3gKZrdz/8jEZJk253kQzx3WFrySrF
         HiFKH7NGCFdm1JMO50iiyjz7tUfe0zcn/NpB5Ot/ATJ9LmxI5pUN8R/2Qmv2fgSNRTiE
         dkzotkf/TG1NamP34jBizrrANtL339RKQ69/TC5Lx0OJ7qPFvf0YOe099RwIYL+AQ8hm
         HmdeHZBEL5yJhxubT+D8sQRuGBJBv6OZIeziQatCL1mgAU0GsA67FYoYKwIjXfhfve+u
         KBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700222809; x=1700827609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mh9tUJDuns9YEWMfiG7SwEu1WyJUjncM3Z8yl4XlzMU=;
        b=WRVxNTclLO14mKp5sdx2A54+Ea05kKhn+kEbOKaBWXjG8M79vxNWzGVRtmPaQDW5CC
         ipk7rY+7UNHEZqlcF6By4a7IAHxGKZccTN+BBm+j1xsIhSpYG9lYPiOHCvOddxg74Iwp
         HrxO1AAIVZMocLYPp/8FhNKayq0PKIEHVESgZw9+JSx/0CTcrSGy0qLpBk+AE3EX73Jq
         tJvlNqt8GuvUaGGfe+ZUQFVfLcHvVSMNv8cz3C0KCrfHVLtf5wxa0YAgc5f/tpvlx41D
         w7uzhmlWJBQ3mqhZwfbA+D2ldwHn1nh46xKrnDD9KgpqS7TMTdZUMVUVeyfmAbuagOpX
         4ksw==
X-Gm-Message-State: AOJu0YxpJQ1bzVzbv0WGoLm3o+QkB8gDia9DX7BKwCiw9J/42MGTOtXG
        s+cdn3xZk2/7ltP2Ea+usloR3Q==
X-Google-Smtp-Source: AGHT+IGcMjqeBju84wf/mocfA5heReBZ9MgmJcllLMQhA4u/59/yWwb9vhYUxUWorIcfGN41BYbcRw==
X-Received: by 2002:a05:6a20:c901:b0:186:603b:6b6e with SMTP id gx1-20020a056a20c90100b00186603b6b6emr16909248pzb.17.1700222808950;
        Fri, 17 Nov 2023 04:06:48 -0800 (PST)
Received: from ?IPV6:2804:14d:5c5e:44fb:7741:c354:44be:5c3f? ([2804:14d:5c5e:44fb:7741:c354:44be:5c3f])
        by smtp.gmail.com with ESMTPSA id g31-20020a63565f000000b005891f3af36asm1262704pgm.87.2023.11.17.04.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 04:06:48 -0800 (PST)
Message-ID: <16c758c6-479b-4c54-ad51-88c26a56b4c9@mojatatu.com>
Date:   Fri, 17 Nov 2023 09:06:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sched: Fix an endian bug in tcf_proto_create
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231117093110.1842011-1-chentao@kylinos.cn>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231117093110.1842011-1-chentao@kylinos.cn>
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

On 17/11/2023 06:31, Kunwu Chan wrote:
> net/sched/cls_api.c:390:22: warning: incorrect type in assignment (different base types)
> net/sched/cls_api.c:390:22:    expected restricted __be16 [usertype] protocol
> net/sched/cls_api.c:390:22:    got unsigned int [usertype] protocol
> 
> Fixes: 33a48927c193 ("sched: push TC filter protocol creation into a separate function")
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>   net/sched/cls_api.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 1976bd163986..f73f39f61f66 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -387,7 +387,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
>   		goto errout;
>   	}
>   	tp->classify = tp->ops->classify;
> -	tp->protocol = protocol;
> +	tp->protocol = cpu_to_be16(protocol);
>   	tp->prio = prio;
>   	tp->chain = chain;
>   	spin_lock_init(&tp->lock);
I don't believe there's something to fix here either
