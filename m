Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4789B77C5DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjHOC3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjHOC2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:28:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E1010D0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:28:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686efb9ee0cso4738713b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692066508; x=1692671308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0lxq9OjfrA60t47ee0fVJ+mpuBSaW/wISgNC9Vr6aM=;
        b=LRLT6XP/XT24hYVtEu3IvtUN57S9JLlno5LNRkdEtYZV4f2UieqgXdcPq4qlVC1iVw
         lfZu9hnms0iFTvbbIbJXIDDaK/RE1hjvlN+2vhknUB8GXoGlq7MSbu67hxSY6VDq3BQ+
         Plr/WMT57GfqWc/UZF7hXtwA8VSJHGrjleUwAKZuiKlgh/WhikEYV4L26qIsgp1DPApK
         Aq2Lsmm7ANV1743gfKej8PRH7SeT5BKGn5wNO+TwteP5XO3AOjehrkjRZiwdLXjmmf9i
         impumhPSk0pbbQNu27JpjBVFownW6iiChFQtzNxbHzC4qMKl9eCSYGZISzSLLPVOtnXE
         WKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692066508; x=1692671308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A0lxq9OjfrA60t47ee0fVJ+mpuBSaW/wISgNC9Vr6aM=;
        b=VHs8sdapBjf226PGgVQ/LG9RPXioaifAdWwbjHK36bEoJMtPmCZXVmK1BGsTH3DAtd
         A9Ei9YCcIoVSx3vHoHoUZNZdFvOTjHZBlf2gUbu3EVrnz0eh02utaSd8Mdh90rw3hL9/
         EmevL5GleTPU5qMjj8DOaCsRtZUmj4D6cxJpz8jhrAYEnfXRvZ6aNoxkYcXM/GaJSWdD
         MMsUK3+PcZ32ThvKubnqVIJ90+Z47dsXpg5QttLf42L87PXf7YVd0GHPa2yO/89Dt8TT
         uQdEodbGE+ez79EUY71uBoSTT95dADf1qN5VvTqsxfhF6yvSi6uiBPCcht0dVNTX979f
         bBHg==
X-Gm-Message-State: AOJu0YwdDRe+zh5GPpfC4U1nBR3WBxWj7985yaC9er+KFkmJnA9/cP2q
        MBVxnu5JHusDIYYx9RfXW9lbCw==
X-Google-Smtp-Source: AGHT+IF0Oahb0/bzmi8xlwgfys35ZcW8ZDVuZHtOLCZ/YfMQuqZlHjVmsVUEHQPx+bRFNXftB5V0SA==
X-Received: by 2002:a05:6a00:10cc:b0:686:babd:f5c1 with SMTP id d12-20020a056a0010cc00b00686babdf5c1mr12653781pfu.25.1692066507969;
        Mon, 14 Aug 2023 19:28:27 -0700 (PDT)
Received: from [10.85.117.81] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id k19-20020aa790d3000000b00682bec0b680sm8539945pfk.89.2023.08.14.19.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 19:28:27 -0700 (PDT)
Message-ID: <dda53b5a-3298-500f-45c5-f5d123559e8e@bytedance.com>
Date:   Tue, 15 Aug 2023 10:28:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 2/5] mm: Add policy_name to identify OOM policies
To:     Jonathan Corbet <corbet@lwn.net>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-3-zhouchuyi@bytedance.com>
 <87h6p1uz3w.fsf@meer.lwn.net>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <87h6p1uz3w.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/8/15 04:51, Jonathan Corbet 写道:
> Chuyi Zhou <zhouchuyi@bytedance.com> writes:
> 
>> This patch adds a new metadata policy_name in oom_control and report it
>> in dump_header(), so we can know what has been the selection policy. In
>> BPF program, we can call kfunc set_oom_policy_name to set the current
>> user-defined policy name. The in-kernel policy_name is "default".
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   include/linux/oom.h |  7 +++++++
>>   mm/oom_kill.c       | 42 +++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 46 insertions(+), 3 deletions(-)
> 
> So I have a possibly dumb question here...
> 
>> diff --git a/include/linux/oom.h b/include/linux/oom.h
>> index 7d0c9c48a0c5..69d0f2ec6ea6 100644
>> --- a/include/linux/oom.h
>> +++ b/include/linux/oom.h
>> @@ -22,6 +22,10 @@ enum oom_constraint {
>>   	CONSTRAINT_MEMCG,
>>   };
>>   
>> +enum {
>> +	POLICY_NAME_LEN = 16,
>> +};
> 
> We've defined our name length, fine...
> 
>>   /*
>>    * Details of the page allocation that triggered the oom killer that are used to
>>    * determine what should be killed.
>> @@ -52,6 +56,9 @@ struct oom_control {
>>   
>>   	/* Used to print the constraint info. */
>>   	enum oom_constraint constraint;
>> +
>> +	/* Used to report the policy info. */
>> +	char policy_name[POLICY_NAME_LEN];
>>   };
> 
> ...that is the length of the array, appended to the structure...
> 
>>   extern struct mutex oom_lock;
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 255c9ef1d808..3239dcdba4d7 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -443,6 +443,35 @@ static int dump_task(struct task_struct *p, void *arg)
>>   	return 0;
>>   }
>>   
>> +__bpf_kfunc void set_oom_policy_name(struct oom_control *oc, const char *src, size_t sz)
>> +{
>> +	memset(oc->policy_name, 0, sizeof(oc->policy_name));
>> +
>> +	if (sz > POLICY_NAME_LEN)
>> +		sz = POLICY_NAME_LEN;
>> +
>> +	memcpy(oc->policy_name, src, sz);
>> +}
> 
> This truncates the name, possibly leaving it without a terminating NUL
> character, right?
> 

Yes, indeed. We should guarantee that the policy_name is terminated with 
a NULL character to avoid some undefined behavior.

Thanks for your helpful review.

------
Chuyi Zhou

