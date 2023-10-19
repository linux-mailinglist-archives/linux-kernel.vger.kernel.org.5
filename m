Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E51A7CF245
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjJSISC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjJSISB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:18:01 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F758121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:17:56 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79fab2caf70so66278539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697703475; x=1698308275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTRribnuit49G/y2EzbJW5y/2X4z+tHgfEKRHq2xxoY=;
        b=V8FC29OIeQwwHF4v/TSfZKmqCtCxTMd7eNtl7HeIlR9ao3ZoU2ZalSYG5qNt+R3VHQ
         jJldNqypw0zzsar9hEmjNiQ9gO+AfkWgAYVUfUXgcO/Cf1EBlIXCbIVo3bFejlUsLEs1
         y3VJOEr9lmGEFLO0d9OXeIkx4tBQQbukg8MHDuELimjndtJbMCszgSmn09mPrcSg/j+D
         dZZafaKQDnRRbxD/xowGI4dvsHdLv8cCBx/w17otKfWvuwjqETUQyxyHgHN/G8+JXJsU
         AyupDY9gtYDHTmR53z7nuCCxmmJlJ4oTg2Yry8cuZcfIVAfyNkrN07vebeeKXzYRFsO/
         wWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697703475; x=1698308275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTRribnuit49G/y2EzbJW5y/2X4z+tHgfEKRHq2xxoY=;
        b=i9Ft37JEfO0vKvz4rlw0JclxNF0NNnh8BRB3rKfte89fKZHmREHCbt9Lz+nPJ2D3VT
         tC4PaCjm5R3iAX6UWzWYdK31TM52O6Ndy4UnLLfteZHib/rPIYxQRkdIHLSg14inX1Kq
         WcdRsjeIH/PT60pr9t8eDRueU+EJet7lmaoY1UZ1hJJHFsOahI2czyU1hV5g7mV7R0X2
         tYnJw67MReqzrCiG2IWRt078M+fRJpoCBHfbRgnHP8CpyTkt+AqSQ0eqQrkrk5SByOo4
         kbZixZZ3PvDjPq4rrMGMrcd+twH7KF0FbxAipJUVHcQu75BFQ232oukTx7q3p3HVLxst
         zFmg==
X-Gm-Message-State: AOJu0Yy34JFxtT5aQ2v2fTWFa+Yxr1o+0uHfxVJ3cauVysMK35ezGVWe
        EKjTnj1hv3SgFt25JPSC/os/4g==
X-Google-Smtp-Source: AGHT+IGe5nKRw+md+BBt3ZQJSAmpr5vhEIgwOaeR5uUz3l+eZsLAGJRYdyyePTsbGWd80XvIo9t32A==
X-Received: by 2002:a05:6e02:13c1:b0:350:f353:4017 with SMTP id v1-20020a056e0213c100b00350f3534017mr1585801ilj.0.1697703475324;
        Thu, 19 Oct 2023 01:17:55 -0700 (PDT)
Received: from [10.84.155.153] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id a13-20020a65640d000000b005b458aa0541sm2500961pgv.15.2023.10.19.01.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 01:17:54 -0700 (PDT)
Message-ID: <f15b0f64-5fa6-ac43-8299-4e48742c6243@bytedance.com>
Date:   Thu, 19 Oct 2023 16:17:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/2] handle memoryless nodes more appropriately
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, vbabka@suse.cz,
        mhocko@suse.com, willy@infradead.org, mgorman@techsingularity.net,
        mingo@kernel.org, aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1697687357.git.zhengqi.arch@bytedance.com>
 <2a3bd858-5464-4569-be1e-2a1867d90c15@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2a3bd858-5464-4569-be1e-2a1867d90c15@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2023/10/19 15:56, David Hildenbrand wrote:
> On 19.10.23 09:36, Qi Zheng wrote:
>> Hi all,
>>
>> Currently, in the process of initialization or offline memory, memoryless
>> nodes will still be built into the fallback list of itself or other 
>> nodes.
>>
>> This is not what we expected, so this patch series removes memoryless
>> nodes from the fallback list entirely.
> 
> What's the end result of this change -- IOW why do we care? Patch #1 
> mentions "which will reduce runtime overhead." and patch #2 mentions 
> "This will incur some runtime overhead.". IIUC the comment in patch #1 
> correctly, these changes don't fix anything, correct?

Yes, after dropping the NODE_MIN_SIZE constrain in x86, the panic
problem fixed by this patch no longer exists (Unless there are other
architectures that have this constrain).

The reason I am re-sending this patch is that I agree with Ingo's point
of view:

```
While I agree with dropping the limitation, and I agree that
9391a3f9c7f1 should have provided more of a justification, I believe a
core MM fix is in order as well, for it to not crash.
```

I also think that core MM should be safe (not crash) even in some weird
topology.

> 
> Did you look into showing a performance gain?
> 

No, and I think the performance gain should be small, after all it just
traverses one less node. ;)

Thanks,
Qi


