Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7417D7880
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJYX2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYX17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:27:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2597F129
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:27:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ba8eb7e581so62187b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698276473; x=1698881273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovpAP5+hWly+cU72J7ewL3F/4BY3qoRuufHFrjaSnmo=;
        b=EbA82wsu7H/apA1+2qn+WUHZAVi7b/wd3iPGdCZ/vGtacLW26oXCc0y4m0FOG8IvaO
         uoqtuai2VCK4QwghG4A6QgJ5qGj13gIGDP5blF8F6jQ/rHO/IeUN/LegjybVqboBlNz9
         GZBU7WANPrMsmQTwPqtlIO3EIY5wH0mkMYDQopGtRvi8BaE7GeAnZoXYKOwdgs1vse7m
         Y+eKnsIhbyWBnWee7s+xBxaeZmYCj4lO3IuWyz7YIJ7IpUIdLQ5YyTCGdLJRSfgqZ6zu
         CNxGHXk7XwKH+O43ir/0pZHoo2sEFj4dJyITMPMcWVtjG7dTInFvNrYsDFNrBNlxzu6/
         ut/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698276473; x=1698881273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovpAP5+hWly+cU72J7ewL3F/4BY3qoRuufHFrjaSnmo=;
        b=GBpidcgTvuBGrCa8hTSKWLtklL3L2nBquRblciGP9gr046+mPoU7tr3WXKNN4UdGUj
         bluKaGL0bdtBIPWIJ9zLpCIufoQ5rzW1/0KIgK3C8/RDX28TaWHaJTCeFk0HxOAkiQQ2
         FOO19Fy0u14XGjt+yI7k9jgeYX7aX1ZX4VB9cBwh8y36PlSKONxmTxma8FSgVhEb1Pg9
         tS9bH0XXje5tXMKwDQxXbD3SVpNiaeBmyiL03qJOOzZ7tihkHRtdSLkEOdVG1IjaBNOW
         bX5yjBDBpDXS1u1UM78DIh5q3/ChlV5bODl+MdnJS1sWlNuWXXyxAwRjTbIq2nFlxMgI
         2O/A==
X-Gm-Message-State: AOJu0YyaqK1kuZD5yjE/BUTlUoqAGKbfpaNLK+WY+qpmw9eL0VEhvVHW
        PIaeetHdJe+E7eQs5/TfIbo=
X-Google-Smtp-Source: AGHT+IFGO6qAQ/ms3YMtIflofUb/LNTTkFW6HNjBUfNP74iVVQyA9Lg8fqQ2kuSPnnvYLaD+XYPUUw==
X-Received: by 2002:a05:6a21:1a2:b0:171:947f:465b with SMTP id le34-20020a056a2101a200b00171947f465bmr22926716pzb.4.1698276473541;
        Wed, 25 Oct 2023 16:27:53 -0700 (PDT)
Received: from [192.168.0.152] ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id u7-20020aa78487000000b00694fee1011asm9886327pfn.208.2023.10.25.16.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 16:27:52 -0700 (PDT)
Message-ID: <c4688c53-4206-4d54-aed9-f877697e8073@gmail.com>
Date:   Thu, 26 Oct 2023 04:57:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixing warning of directly dereferencing __rcu tagged
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     brauner@kernel.org, surenb@google.com, mst@redhat.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        mjguzik@gmail.com, npiggin@gmail.com, shakeelb@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231025222811.855336-1-singhabhinav9051571833@gmail.com>
 <20231025153807.8db950f1db82b2c9ecd03758@linux-foundation.org>
Content-Language: en-US
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231025153807.8db950f1db82b2c9ecd03758@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 04:08, Andrew Morton wrote:
> On Thu, 26 Oct 2023 03:58:11 +0530 Abhinav Singh <singhabhinav9051571833@gmail.com> wrote:
> 
>> This patch fixes the warning about directly dereferencing a pointer
>> tagged with __rcu annotation.
>>
>> Dereferencing the pointers tagged with __rcu directly should
>> always be avoided according to the docs. There is a rcu helper
>> functions rcu_dereference(...) to use when dereferencing a __rcu
>> pointer. This functions returns the non __rcu tagged pointer.
> 
> Seems sensible.
> 
>> Like normal pointer there should be a check for null case when
>> further dereferencing the returned dereferenced __rcu pointer.
> 
> Why is this?
> 
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -2369,7 +2369,9 @@ __latent_entropy struct task_struct *copy_process(
>>   
>>   	retval = -EAGAIN;
>>   	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
>> -		if (p->real_cred->user != INIT_USER &&
>> +		const struct cred *real_cred = rcu_dereference(p->real_cred);
>> +
>> +		if (real_cred && real_cred->user != INIT_USER &&
>>   		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>>   			goto bad_fork_cleanup_count;
> 
> The old code assumes that p->read_cred cannot be NULL and the new code
> does nothing to make it possible that `real_cred' can be NULL?
> 
> In other words, I see no reason to add this new check for NULL?

Thank you for the response!

I thought it will be better to have check before accessing it, just so 
we dont have any segmentation fault in future.

Also I just noticed there are two more places where direct dereferencing 
of __rcu pointer is done in this same file. Should I do those changes in 
this patch ?

