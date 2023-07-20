Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4F75AD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjGTLfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGTLfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:35:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01EF136
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:34:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b852785a65so5281665ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689852874; x=1690457674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RmeowStXIEPULQOAaOWZp78vxjHDoSNjkADxM9sQfc=;
        b=M0DrMvL74mRRIv17Hv8ig5J7sQWnEZTZf84dLaKCQsXxQtcIgMlfIxVoaUskKOWIQp
         fc302CL33o59MSl/yZvbZ3cRlyAqQ9Kh0p54L4s336jjQljCzQbPmPNSghHWbn49o8Ql
         nQIvdHMaKpDxF1KLMqkeUTAACQaYlmmEtxaIsbMJ5xyfdUTgLnJEACez6gA4w3gnEy1b
         ILbyO3KvZmyrBsyIkE4hD01a9/9tAVPHEyBG1j5r2rIVFiUjio2hrkrjITfr0xQYaSJY
         53iJT35RsFQW7KN5Czi4n0AEmfUDUCTM9PP9fUG9bs9UyQrpj0H+HtBmSr/2nv9oXdjM
         EPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689852874; x=1690457674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RmeowStXIEPULQOAaOWZp78vxjHDoSNjkADxM9sQfc=;
        b=GiLATJPpuGjjDHBWzWZWOAhozYcaNQj1Jv9Ux1Wk3PSV5ErPf5dg1loxa8KlY6kTHc
         kgFtq1WulmwC/DcW4SGq8bPwyIh2k1bDsXkj9/CirE0OU+dyz0+IEKipNOSgQl5mSKs2
         q9ZFCzMQVE+JL7/BUL7N7kWWbeFjd+BgyUk6cuqMy0BKSOuQtFCrvIKm9yXONuJnXcFJ
         jrbJyiZim9qSTXC1YqVIWLypciVBZ3oPkFtAE6NhHv5TdWypyzj/dqsYDRqfgpVuwPHL
         9ppeiHLa216+B9rOUqVuphOaLx5UUBoouEItJhgJGPFZH/0Nlz+JR4UUi4F9uAbgDAIS
         Irzw==
X-Gm-Message-State: ABy/qLbHn3Mv8MKtpOBMUsFBvPaASp0n/Z4v71Yqs6ay1I6vBJ08bDwy
        OMD2ZVsP/yV9vadVeKXpkfDZzw==
X-Google-Smtp-Source: APBJJlEm8W4mnf+mF4gI7WktAlJnS5x7bFKZNwTAJEow8jjEkLt3J+3pVRZGBlItCxEzfFEMbMdYiQ==
X-Received: by 2002:a17:902:ea04:b0:1b9:ea60:cd89 with SMTP id s4-20020a170902ea0400b001b9ea60cd89mr7763594plg.7.1689852874310;
        Thu, 20 Jul 2023 04:34:34 -0700 (PDT)
Received: from [10.4.72.29] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b001b891259eddsm1105151plx.197.2023.07.20.04.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 04:34:33 -0700 (PDT)
Message-ID: <be65ab74-8ee4-9ae5-f0ff-88c9fd2fbeb5@bytedance.com>
Date:   Thu, 20 Jul 2023 19:34:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators
 of sockmem pressure
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
 <d114834c-2336-673f-f200-87fc6efb411f@bytedance.com>
 <CANn89iLBLBO0CK-9r-eZiQL+h2bwTHL2nR6az5Az6W_-pBierw@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CANn89iLBLBO0CK-9r-eZiQL+h2bwTHL2nR6az5Az6W_-pBierw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 4:57 PM, Eric Dumazet wrote:
> On Thu, Jul 20, 2023 at 9:59 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> Gentle ping :)
> 
> I was hoping for some feedback from memcg experts.

Me too :)

> 
> You claim to fix a bug, please provide a Fixes: tag so that we can
> involve original patch author.

Sorry for missing that part, will be added in next version.

Fixes: 8e8ae645249b ("mm: memcontrol: hook up vmpressure to socket 
pressure")

Thanks!
	Abel
