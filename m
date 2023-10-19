Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBFB7CF6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbjJSLYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbjJSLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:24:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1467F112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:23:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9d922c039so63883265ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697714636; x=1698319436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VF/u7v+FfXAzClIKnamx2tkzWYY5JIn4XlyArKKgPL8=;
        b=X7U1rshc9628aproLgSEJDvZkQ4KZ41S5ByEryPlsSgwmRpYQ+GELRdFUwBdk40hW2
         HDkWT1qrcum3FbAbEQZlrGaxA3dEJrc9ZmG+DubayKKR+8vBkK3Mk6e0j4ZLe4ew3JVv
         fvtdB/1c4EAotIcSV6nLv/KyBxoDIKVxNcq2x08EoaGvrv2Q5Khq5JBBM/7Mk3qGCpx5
         l0gWu8hqN3clDrF15rcF7UaQ6Q9+gLUuRUb0UaZX+BikpHJxRt72gJryz5RmufRHsNFd
         FTSLa/py1Pm6+qgIEifmfyeQL5jpQcRMJ2XNJSbBNagsO68LD6yH2PkeQLybrn1H8b4r
         Ca1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714636; x=1698319436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VF/u7v+FfXAzClIKnamx2tkzWYY5JIn4XlyArKKgPL8=;
        b=kNY+TMHBSYEFhhpRxXDIx9hSgWuEDfqK5YhkoNNcuxzQ0/tDsSUgEmdrmc2j89/lkM
         9bWchLFqOxaRZpSsbHOgssBQEGzrOmnkAD/U29L2h4WL+3mR2XSeR3XLjcTGEsQywRfw
         CeQMaMDr7X1JvBV2sO7Xa6YBWQkpQjl2gSiQ046dNDDjHN+o79a9MPjUICC6m0y/s3ko
         g6wQ+XHCKxT4tEnQ9vwxJrUWmFydGBJYXW+JFe+JLFZfJQu8b9Yr/V/Fublwq4lOCeUm
         e6g+Dq84j00BXbgRduUQU+I49a/Rc1zEmnq3E/kaMKYzkxpud/xdWKkaZQpFaBF3gd/6
         ySaQ==
X-Gm-Message-State: AOJu0YzWwQBLdUJZBpkOTdmy3Vzvsl/BBO2rAR3JxQ3Cd3cciq+jmrDy
        2BHKDkVtezlckHHn6byEseqe8w==
X-Google-Smtp-Source: AGHT+IFR49iD8VLXzx3yOb3XpwNAik63G/UfUtMnCbZ0RN7DU/cesmLuLL+whKzOtnwe9o6monqyjQ==
X-Received: by 2002:a17:903:11c7:b0:1c7:2740:cfb3 with SMTP id q7-20020a17090311c700b001c72740cfb3mr2336782plh.35.1697714636426;
        Thu, 19 Oct 2023 04:23:56 -0700 (PDT)
Received: from [10.84.154.4] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b001c736b0037fsm1699750plb.231.2023.10.19.04.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:23:56 -0700 (PDT)
Message-ID: <c3110f12-5d9f-4907-a712-5a1004ec4fdc@bytedance.com>
Date:   Thu, 19 Oct 2023 19:23:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH net-next v2 3/3] sock: Fix improper heuristic on
 raising memory
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
 <20231016132812.63703-3-wuyun.abel@bytedance.com>
 <d1271d557adb68b5f77649861faf470f265e9f6b.camel@redhat.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <d1271d557adb68b5f77649861faf470f265e9f6b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/23 4:53 PM, Paolo Abeni Wrote:
> On Mon, 2023-10-16 at 21:28 +0800, Abel Wu wrote:
>> Before sockets became aware of net-memcg's memory pressure since
>> commit e1aab161e013 ("socket: initial cgroup code."), the memory
>> usage would be granted to raise if below average even when under
>> protocol's pressure. This provides fairness among the sockets of
>> same protocol.
>>
>> That commit changes this because the heuristic will also be
>> effective when only memcg is under pressure which makes no sense.
>> Fix this by reverting to the behavior before that commit.
>>
>> After this fix, __sk_mem_raise_allocated() no longer considers
>> memcg's pressure. As memcgs are isolated from each other w.r.t.
>> memory accounting, consuming one's budget won't affect others.
>> So except the places where buffer sizes are needed to be tuned,
>> allow workloads to use the memory they are provisioned.
>>
>> Fixes: e1aab161e013 ("socket: initial cgroup code.")
> 
> I think it's better to drop this fixes tag. This is a functional change
> and with such tag on at this point of the cycle, will land soon into
> every stable tree. That feels not appropriate.
> 
> Please repost without such tag, thanks!
> 
> You can send the change to stables trees later, if needed.

OK. Shall I add a Acked-by tag for you?

Thanks!
	Abel
