Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2F7FB1F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbjK1GX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjK1GX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:23:56 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999DE183
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:23:42 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f9f23b4fa2so1038919fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701152622; x=1701757422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbwrnUh6cvf5haA/BX0nPLmj+8uunF8iu3+nmhJrr78=;
        b=eqg4cHZBkRVQFJQxJk0tiMAtrX8JxIV0TxYsm88yvGpba3WT3PllaIUyu1jSfPRxtG
         nIuCRfgZEn4rdpvSU00CXxdEQdeZ2M/wdPxM5PreKc5VxixU6PinzwaZNGRRXkQlEUE+
         49hN8/1p9dSJl+jeiGOR+BeLy5vNvtTRQYvyBpA6ldrKyZ+8dvQPPadt96aT0Q0uVISb
         NO43D/ZR23y54UmLw6HeyEmLWXyZbXjXYw+w4yGEte1MYdRvS1DocmtTnpvYA4hsXrk6
         hRBQENeTp0rYzcyCACTbG7COuYAw4CsPXMxCWMBnZZMYijiEdL+uWpmnAZbHHFnMcmBh
         L0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701152622; x=1701757422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbwrnUh6cvf5haA/BX0nPLmj+8uunF8iu3+nmhJrr78=;
        b=V6knGSvH9RmJaUxbjs8Wr2A2QDyWmtuwsaUnDf1/YxTY+XwjtKtOhtIpfbHB21uoZk
         Iw4KFJA0bkIKMVuzWzTsYdReaWLnAo1ViAp+AZfxopjpF/wZcxnSfN8g/EjWI+KZFxIW
         XOXYJhyH6HeIjojZQZ/n/3I4/aOz7zPRIa+BBP6j2WlydXdM7BTp4RVYSUUqcqHjmaSC
         n5YRn3ggYmIy93W76fHLOXRtV+T7FSyjakMtAXYIjQHfyqHyj0yTpPnpwYbOfkYVsw9Z
         zYrW/knglD3okyIyQ/iIQZ7SrkbKbUz2RIxyJa9rlbRsLbASoaoODE/GKJqcg8Kn9tAm
         H4tg==
X-Gm-Message-State: AOJu0YwuZv2ZQzzPBLBR2lGRwvDDvq1QOYWvDZP/7Mqhl5525hU3SpuM
        UqWT9i+0t9kFZPnMo0egQJifVfTYqMFQojoxI+k=
X-Google-Smtp-Source: AGHT+IG21+YPnBYYcWldFBAfFUJzLBR599msydhlLhyRFGBkuPTAG6cPeRBkjASPTWXnwyDxBVGb2g==
X-Received: by 2002:a05:6870:64a2:b0:1fa:138f:5419 with SMTP id cz34-20020a05687064a200b001fa138f5419mr14947863oab.0.1701152621834;
        Mon, 27 Nov 2023 22:23:41 -0800 (PST)
Received: from [10.84.152.29] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id f11-20020aa78b0b000000b006c31c0dfb69sm8227059pfd.188.2023.11.27.22.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 22:23:41 -0800 (PST)
Message-ID: <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
Date:   Tue, 28 Nov 2023 14:23:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Muchun Song <muchun.song@linux.dev>, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-3-kent.overstreet@linux.dev>
 <deed9bb1-02b9-4e89-895b-38a84e5a9408@gmail.com>
 <20231123212411.s6r5ekvkklvhwfra@moria.home.lan>
 <4caadff7-1df0-45cc-9d43-e616f9e4ddb3@bytedance.com>
 <20231125003009.tbaxuquny43uwei3@moria.home.lan>
 <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/28 11:53, Kent Overstreet wrote:
> On Tue, Nov 28, 2023 at 11:27:11AM +0800, Muchun Song wrote:
>>
>>
>>> On Nov 25, 2023, at 08:30, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>>>
>>> On Fri, Nov 24, 2023 at 11:08:11AM +0800, Qi Zheng wrote:
>>>> Hi Kent,
>>>>
>>>> On 2023/11/24 05:24, Kent Overstreet wrote:
>>>>> On Thu, Nov 23, 2023 at 11:32:59AM +0800, Qi Zheng wrote:
>>>>>>> + void (*to_text)(struct seq_buf *, struct shrinker *);
>>>>>>
>>>>>> The "to_text" looks a little strange, how about naming it
>>>>>> "stat_objects"?
>>>>>
>>>>> The convention I've been using heavily in bcachefs is
>>>>> typename_to_text(), or type.to_text(), for debug reports. The
>>>>
>>>> OK.
>>>>
>>>>> consistency is nice.
>>>>
>>>> However, this is inconsistent with the name style of other
>>>> shrinker callbacks. Please use the "objects" suffix. As for
>>>> bcachefs's own callback function, you can use typename_to_text()
>>>> to ensure consistency.
>>>
>>> That would be inconsistent with introducing a convention to the wider
>>> kernel.
>>>
>>
>> I don not think .to_text is a good name. I really do not know what it means
>> when I first look at this name. I knew you want to report the objects of
>> shrinks, so why not use .report_objects or stat_objects proposed by Qi.
>> Although .to_text is only used by bcachefs now, shrinker is a general module
>> which is not only serving the bcachefs itself. I think it should be better
>> to use a more straightforward name.
> 
> No, .report_objects or .stat_objects would be wrong; this isn't
> generating a report on the objects owned by the shrinker, it's just a
> report on the statistics of the shrinker itself.

Now I think adding this method might not be a good idea. If we allow
shrinkers to report thier own private information, OOM logs may become
cluttered. Most people only care about some general information when
troubleshooting OOM problem, but not the private information of a
shrinker.

So I thought maybe we could add some general statistics to the shrinker,
but adding private ".to_text" method is not necessary.

Also +CC Michal, who is reviwing OOM related patches recently.

Thanks,
Qi

> 
> That's why the convention is typename_to_text() - generate a text
> representation of an object of that type.
