Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F807CF697
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345346AbjJSLWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345316AbjJSLWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:22:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F070811B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:21:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c77449a6daso64073095ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697714517; x=1698319317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+pZUkJVQsJVYjHJbhfYRUL1BGoXYIgN45kZzTiGXTQQ=;
        b=ALrZW5e+yyjg56xjvaR0sJ3nlXARIc9t4B44KPzrtq2Gn954xVVw8D4QbvSX2mqqXw
         Gf1v9zk0LHlPpN/yI9NyIGGt13ArQO6it9Er11JZKB7peHF2XQOq+13mfhum3z7vt0OV
         uW8K+7GPkSTmQVeiPE28ZQut6fdfHrWq5zjkxRfgx+SxZkLBjWeUHIIyZiuLbTIstZGA
         MIAepzUh766Re4ClvvvHFTPsobvW7jkpCEmi6y59L4Z9ZPTFbg3raizKprP0OmOs8oL3
         y/XFJj6iOfuR+K29ErJuguE6iQDB9wcN7HwQcfuyicFIJ8ibrl5s6ebizv4x7R2yCnxO
         q0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714517; x=1698319317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pZUkJVQsJVYjHJbhfYRUL1BGoXYIgN45kZzTiGXTQQ=;
        b=lJqs7nGUqZkVewkqwNJRJvet5TcRfCsnJ6yuDQlOeiBgh6UgIWDFCOEahAdFtJOHVN
         /hNcfHGygPEQSTTnivRD01Xo6IRg4ki+3etg7cx2zWGD9xNRpq1pdu4Z6Y75YTHWCe31
         q+feS6nmOyebZHOLwliQquZtX4B6wx0K+VkvpQjeH85NO9a7jJyeNGts/n8L9y/q70JJ
         jh2NqnuOPDzgs8qgeU3uAGPANLqorNZfOMC+p3BAPGwlSUwUUqQfCnd2K6sDDgZSOq7U
         uFJABTZKUdeUP0Vq6VFSZNmdUbEJPgTmzYPCw+csBL8QmdB/SCOhxIbsgZkK9kEBAgvu
         NKYw==
X-Gm-Message-State: AOJu0Yyf9zPk+JwQtoTlRpjKygEhtltCWZzZRP2ZMZSdtPNU3MLVE9FB
        CBjuir9Qhfws2zMDecne0MSFrA==
X-Google-Smtp-Source: AGHT+IEQcz6xBFwuBkQxgnbo3UVJhoruTv5UOA95CIsVn1e3IC4x0Scxa9t7KIKwkdhiTCtOuiCwPw==
X-Received: by 2002:a17:902:ec88:b0:1c7:733b:27c7 with SMTP id x8-20020a170902ec8800b001c7733b27c7mr2029569plg.56.1697714516999;
        Thu, 19 Oct 2023 04:21:56 -0700 (PDT)
Received: from [10.84.154.4] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jb11-20020a170903258b00b001c9c6a78a56sm1708399plb.97.2023.10.19.04.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:21:56 -0700 (PDT)
Message-ID: <5283655b-b8c6-43da-939e-5a0d088caad6@bytedance.com>
Date:   Thu, 19 Oct 2023 19:21:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH net-next v2 3/3] sock: Fix improper heuristic on
 raising memory
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
 <20231016132812.63703-3-wuyun.abel@bytedance.com>
 <CALvZod6FRH2cp2D2uECeAesGY575+mE_iyFwaXVJMbfk1jvcgQ@mail.gmail.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CALvZod6FRH2cp2D2uECeAesGY575+mE_iyFwaXVJMbfk1jvcgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 11:52 PM, Shakeel Butt Wrote:
> On Mon, Oct 16, 2023 at 6:28 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
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
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> 
> Acked-by: Shakeel Butt <shakeelb@google.com>

Thanks!
