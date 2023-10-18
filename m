Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15737CDD16
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjJRNVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjJRNVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:21:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33AC106
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:20:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bcef66f9caso872988b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697635244; x=1698240044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsB+lRYTRRvaUitJgzAnKBU70t8lyjCSo9aQyw6SOfw=;
        b=bzVmGH78e6pka91YRvIYgBqGSRTR2ONDbeEcFDlO52AJPxv3T2+ps3moO9z4fyqB0G
         GD7LkmbvTvYDkKBpQk4VF1N9tZNzE7vutLcobSiK8IsxSkfB8TwzqRniJy4v/57jqK+O
         gdJulyepI+tsOSFnltoaY1UbNcV3HOat5KbF8wbpwhw+knLQhFyBJ+fDxm9dgQSgXykp
         fwYsP+jv0aRDb/oh0OlpMAqA5qOSUXP7CWD5ChSEtKB6KknGnuEI7771ViyL7FoaOxkB
         V8hi25YHwr6fcwC+XuuP6RzBQOGpigaj6R5biu6eo3nzR/tRnwDxb8464B4J73KyXe0R
         ffzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697635244; x=1698240044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsB+lRYTRRvaUitJgzAnKBU70t8lyjCSo9aQyw6SOfw=;
        b=gwjq6CbkcarR5WpaOCOKS88jJBDt6xJJAWVwz+01O7/gk+UwML5O/emy25OOW1Uwjr
         jj8dgSxrbehCjVaWGAIvD6uX+ploh5TyRq+g8NO7BWUy746B9Z/c9Bta7LEAVN++cmh8
         qRRitVjYLO1ek7brPtOL+XlEnwkeC44v8nZUGNH+J8+P+2wuR073wwMrvyZQDRbdTUqW
         Vn2gYS+jw0mV79NJ/lIR4QM5xdjxBxsA5HCKMUhpg7UTRD88If0+tvX8AdYbVW1gXuWX
         wnbJO3sfyaM88e483awNpjNJrkjEUGMja98eUje83ZtQgAyfSLxcK7brj96/TA7HQIJ0
         3E7A==
X-Gm-Message-State: AOJu0Yz0+mHfC6kVLHG0j0uT/o03MIeEilZPmqt91nhXyrDNIwzoatXg
        DfDFqAfq539b8b49XSKZEhTnDg==
X-Google-Smtp-Source: AGHT+IHJWMqg9DynKVfw+VevW/0B2muzXXfJF3DYtTbWzeIlrB3r7fqD0vMtrfHgsqLSQdZp0sycLQ==
X-Received: by 2002:a05:6a00:1d12:b0:6b2:51a0:e1c9 with SMTP id a18-20020a056a001d1200b006b251a0e1c9mr5330389pfx.1.1697635244153;
        Wed, 18 Oct 2023 06:20:44 -0700 (PDT)
Received: from [10.84.155.153] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id q25-20020aa79619000000b006b76cb6523dsm3294388pfg.165.2023.10.18.06.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 06:20:43 -0700 (PDT)
Message-ID: <35bd1d51-35ac-3ee6-e068-f50dff7774bf@bytedance.com>
Date:   Wed, 18 Oct 2023 21:20:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] x86/mm: Drop 4MB restriction on minimal NUMA node
 memory size
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231017062215.171670-1-rppt@kernel.org>
 <ZS+2qqjEO5/867br@gmail.com>
 <605cc166-e731-e7d1-25d7-b6797a802e6f@bytedance.com>
 <ZS/TRNf02Un8IOTK@gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZS/TRNf02Un8IOTK@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 2023/10/18 20:44, Ingo Molnar wrote:
> 
> * Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>> While I agree with dropping the limitation, and I agree that
>>> 9391a3f9c7f1 should have provided more of a justification, I believe a
>>> core MM fix is in order as well, for it to not crash. [ If it's fixed
>>> upstream already, please reference the relevant commit ID. ]
>>
>> Agree. I posted a fixed patchset[1] before, maybe we can reconsider it.
>> :)
>>
>> [1]. https://lore.kernel.org/lkml/20230215152412.13368-1-zhengqi.arch@bytedance.com/
>>
>> For memoryless node, this patchset skip it and fallback to other nodes
>> when build its zonelists.
> 
> Mind resubmitting that to the MM folks, with the NULL dereference crash
> mentioned prominently? Feel free to Cc: me.

OK, I will resend it if no one else objects. :)

Thanks,
Qi

> 
> Fixing hypothetical robustness problems is good, fixing specific crashes is
> better. :-)
> 
> Thanks,
> 
> 	Ingo
