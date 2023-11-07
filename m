Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259617E3AC6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjKGLI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjKGLIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:08:25 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8ADED
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:08:22 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so3733456a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 03:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699355302; x=1699960102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBqo9TF/S61UWjmmVVHRjPfWcl+uBVe9APQAT7TlPKE=;
        b=JJErv5oetbtw8vN2WSKHUnweFNylQAQdI7mI0IG/AKmwwXRzEJ7bAP18j427KsVgBU
         E4wUu94OmvA+DujNgCeLP7OMFwpNCwLZ3tVDwsi7YrrL8CHTlA0b+xQHDJ65lYKgWiTN
         VQm7bdpH6OSWG9zTioyb2YtliDBDFqPP88xi0cQJfj3gtSn+D3RT6kFctRd5e0fyWm0J
         fy/FL6f5aDZMVyPw5T/RHTvP7nTm7UYv/7CXjLuwVa9Yocr+5wLnXvQVBVMozpi00oeu
         T5n1Zs6xIdt9vU0wlucGQ+wSS2jGBlR9SzA6TcOai4OvCa22ORUwDdbLlMWlL7mwvIum
         kcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699355302; x=1699960102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBqo9TF/S61UWjmmVVHRjPfWcl+uBVe9APQAT7TlPKE=;
        b=Pi5GPxyQFDNJBBZu+tHC5Uf0KrA/+yUjmiMnLVW4xbLufhHJeQIEVB6CmrKuDHQztd
         6BN17HMMDwEeoYgE4B8Rx51EJ4fsrZ1fAG3xNuqqwuDyOgV/xcDJSO1XUDn9Tb9rm1e0
         /XbVDr4xtEIrf4YNE9N4RJon3qTqb3hJJwlBRFRck/+rY+OULvwFW3LvA4BxnZglJ5T7
         T8lqIE+PmVltriAUEol+wwvTbbffiZS0ps5LXX+L0Tx50BBinw0zVC/GAew/T/fYqyMS
         0djXZWjYsTZnZvAdvbGpiqiHuTNEPqbA8Cn1eJcupx4OPCKjX77Sp4SogCEHxx9jHc4f
         L+2g==
X-Gm-Message-State: AOJu0YxKIV/kv2ehTbUBY/8Iy7IhXXNBqAqbVAt2GFSHJPqbJyFcb7VM
        V1nzS4kqBlGqEENA0NMKWreU/Z259TQMeaOO03g=
X-Google-Smtp-Source: AGHT+IFg2UCqpksYTuyw9llS5M/sJxKc3KfQU785slm2oIpq6gH6nZxocPk3pI9+wLC+o7/fNqeDrA==
X-Received: by 2002:a17:90b:4d85:b0:263:1f1c:ef4d with SMTP id oj5-20020a17090b4d8500b002631f1cef4dmr8200923pjb.10.1699355302273;
        Tue, 07 Nov 2023 03:08:22 -0800 (PST)
Received: from [10.84.153.152] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c34-20020a17090a492500b0027768cd88d7sm10146476pjh.1.2023.11.07.03.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 03:08:21 -0800 (PST)
Message-ID: <0c56cbc5-46a7-446c-b861-906fee0d4de1@bytedance.com>
Date:   Tue, 7 Nov 2023 19:06:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 2/4] sched/eevdf: Sort the rbtree by virtual deadline
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Barry Song <21cnbao@gmail.com>,
        Benjamin Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
 <20231107090510.71322-3-wuyun.abel@bytedance.com>
 <20231107110327.GU8262@noisy.programming.kicks-ass.net>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231107110327.GU8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 7:03 PM, Peter Zijlstra Wrote:
> On Tue, Nov 07, 2023 at 05:05:08PM +0800, Abel Wu wrote:
> 
>> Sort the task timeline by virtual deadline and keep the min_vruntime
>> in the augmented tree, so we can avoid doubling the worst case cost
>> and make full use of the cached leftmost node to enable O(1) fastpath
>> picking in next patch.
> 
> Another very good patch, just a note:
> 
>> This patch also cleans up the unused max_vruntime() and adjusts pos
>> for some functions.
> 
> There's this thing about saying 'this patch' in Changelogs, per
> definition the Changelog is about 'this patch' so saying it is a bit
> redundant.

I see, thanks.

> 
> It even gets mentioned in the Documentation on submitting patches
> somewhere.
> 
> But what I care about more is this patch doing extra unrelated things,
> this should be split out.

I will fix this in next version.

Thanks,
	Abel
