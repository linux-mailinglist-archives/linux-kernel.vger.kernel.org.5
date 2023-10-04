Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8F87B7B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbjJDJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjJDJKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:10:21 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625498
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:09:58 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3ae5ee80c0dso1096809b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696410598; x=1697015398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylNz1Ckdn9LPUHarFzFqv2tL05dcUwYtY95IXdt1WH8=;
        b=Oo8u0+hcufpi2mYnD1EX9m8YVzV/Qsxul6ObdoK8/6LX+g+y3yE3xj0g14IPhtzn1Q
         mERBw5FG+mAOA8Lyu33tcmfhfutPURgIINQbktRGvwZGBmEBt0zFLlp0kfLwLih3KxoK
         Kp/NK4uPUQNooHMzuXJ90CA/oDMGJmNEagL89C4ryiD9TFHS2wMHpFfzDTVT/Bvdo5O8
         IrVfXfp7szcQJs4je1Qiy2VAc75M05Q+mq7X8huZzCuSxenGlP7PPDAG10+MiTdNW29A
         XWLQ3WR9N1M9YQKyea3ANOtSjWbKM4CWIvag+AniNHXW0SZBm6rhOMsHNS4/4Brs5nBf
         lsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696410598; x=1697015398;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ylNz1Ckdn9LPUHarFzFqv2tL05dcUwYtY95IXdt1WH8=;
        b=ZjGVRmhwJPH0tyXe4x6GTVFy/jZ9fVZekrfPq9SBBQMdC6dAmdv1FmEl0LrhSVdJqR
         FgPNA0syvbMq3a9ImDb16ofSuAGn5dpbK3gh2xmQ6M8F5kU+9Yd+rDJP05qh59BJgXnr
         Sc5OYXxzF1QlCpZoz9mBbivT2iFT8a9Su9Vl3sXHYExWCZmu4lice2RJLujeFNtFfh8p
         XD5wOIYriRk+OGBrKh7llAupzUZGqaQl7XOE65Jjz94DdAxaN0O5qRSRmY2g5XmCnu9C
         G45mDgoN/2qrB+gU26aLA1Inv3dnGXHHbaEHRWTBcwfl5PWZ935kOx4ZdJXtM+6MezEg
         yrrw==
X-Gm-Message-State: AOJu0YzXPhxtZ5/XlFzKL6wZJD8NscXbTD9K2YEdZcZ7RL4wrjtPl4wU
        AlGZCxB2FfsYhugxUL+DWKLb9Q==
X-Google-Smtp-Source: AGHT+IF/KNgERzwYtv9U+/WMyGygFw6iF+RKAKVcW3HyGa4BzT8fd+9FY9uGjtHdwAcIj308/UP2OQ==
X-Received: by 2002:a05:6358:9042:b0:142:efb8:5295 with SMTP id f2-20020a056358904200b00142efb85295mr1976701rwf.19.1696410597856;
        Wed, 04 Oct 2023 02:09:57 -0700 (PDT)
Received: from [10.254.225.239] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id bg11-20020a1709028e8b00b001c771740da4sm3112573plb.195.2023.10.04.02.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:09:57 -0700 (PDT)
Message-ID: <06c2a26e-fa22-382c-0572-eab0d0124fb2@bytedance.com>
Date:   Wed, 4 Oct 2023 17:09:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH v3 5/9] maple_tree: Update the documentation of maple tree
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
 <20230925035617.84767-6-zhangpeng.00@bytedance.com>
 <20231003184625.lqnfmgc35o7pgeff@revolver>
In-Reply-To: <20231003184625.lqnfmgc35o7pgeff@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/4 02:46, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230924 23:58]:
>> Introduce the new interface mtree_dup() in the documentation.
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   Documentation/core-api/maple_tree.rst | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-api/maple_tree.rst
>> index 45defcf15da7..3d8a1edf6d04 100644
>> --- a/Documentation/core-api/maple_tree.rst
>> +++ b/Documentation/core-api/maple_tree.rst
>> @@ -81,6 +81,9 @@ section.
>>   Sometimes it is necessary to ensure the next call to store to a maple tree does
>>   not allocate memory, please see :ref:`maple-tree-advanced-api` for this use case.
>>   
>> +You can use mtree_dup() to duplicate an identical tree. It is a more efficient
> 
> "You can use mtree_dup() to create an identical tree."  duplicate an
> identical tree seems redundant.
Okay, I will modify this sentence. Thank you.
> 
>> +way than inserting all elements one by one into a new tree.
>> +
>>   Finally, you can remove all entries from a maple tree by calling
>>   mtree_destroy().  If the maple tree entries are pointers, you may wish to free
>>   the entries first.
>> @@ -112,6 +115,7 @@ Takes ma_lock internally:
>>    * mtree_insert()
>>    * mtree_insert_range()
>>    * mtree_erase()
>> + * mtree_dup()
>>    * mtree_destroy()
>>    * mt_set_in_rcu()
>>    * mt_clear_in_rcu()
>> -- 
>> 2.20.1
>>
> 
