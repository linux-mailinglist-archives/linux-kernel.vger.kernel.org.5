Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F317C6648
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbjJLHFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjJLHFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:05:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB03C90
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:04:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690d8c05784so532245b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697094298; x=1697699098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eL4VjJLskxlAdTgwWpaabtBM5ugjnWmCA/fqQTXeKrc=;
        b=IH1YXK5HlzBuugT8yBCsATHUfpVrREkRm2Daix3fV6B0DMP9fqTCSDtCxn+tEs98qC
         /SEkSznn6iwIigsO3AkEuSjQQg/EwbIgbjTkHhdCEP5iVhGm+hp6sPrxm0/MduYEkrgr
         Zwtz/hZ5C2fQdAW5qQjaXOOVqUlOopnpM1oW+Ug5VNU85QZEeBkaMupw2DW/lFHUGpzm
         YGRhu5cv2vyYXNsN6z2M89w7Ktv6Z3e/hmnhbWn6s/kQwRXfLelj+lNw/9HqCVUaDvB1
         Bel5qt+laF3STl9HucQBZPuX5Axl7R5gLQcf4pK1RECUen0CfyoKzsuLqlg4dMTxJnTk
         XI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697094298; x=1697699098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eL4VjJLskxlAdTgwWpaabtBM5ugjnWmCA/fqQTXeKrc=;
        b=BmPie5t9c648zayxLruftufJuMyoK7Sip0GQJfvQB15bi1b281IZ7psoo8Y3RBdSE9
         w4eEbFAJ8XFVy2TeN03Ytb1fD6cllfDonKb8/YBDPaCk+m3r2150xun6046X1w4YPDai
         dGI2wy4E5asN4KRQ8PIrq+4SDxwTLXmPkdizu74N+wdzYe8bXIz+dzTwa5w1se7/VQCl
         57DeLQOVPdenulE+tIM8LxNMwWxpekVyAqBQB8mwkClAtWLnzhW0hK/8F8ulC5o8ZQiq
         P8uNejDVBESZUF7fw7XbJotmJaPCyQgFTtKqC79MftYChG49HDoQwcQ9SutM6R7zMJTI
         rjJA==
X-Gm-Message-State: AOJu0YwgFnAJJmqgwS0DmXLPOAPm+AhTnQgTOvoWHFvN5NiLbczqq5EV
        Ac6DnM5bGZX2Ese/hc6nyIsaxQ==
X-Google-Smtp-Source: AGHT+IFTyXOuTpdhbv/qWfSUZjHo0TV9Knlg1Bb5d1x6HoOsPt586luDoTwa8SkSgpnk15Jhpz6v1A==
X-Received: by 2002:a05:6a20:1590:b0:13a:e955:d958 with SMTP id h16-20020a056a20159000b0013ae955d958mr22757934pzj.7.1697094298356;
        Thu, 12 Oct 2023 00:04:58 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090aca0100b0027b436159afsm1088573pjt.40.2023.10.12.00.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 00:04:57 -0700 (PDT)
Message-ID: <57c6d8c8-380e-45d9-b9d0-690662fcd6f4@bytedance.com>
Date:   Thu, 12 Oct 2023 15:04:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 03/15] sched/fair: Add lag based placement
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
References: <20230531115839.089944915@infradead.org>
 <20230531124603.794929315@infradead.org>
 <87f1feec-1be5-4d24-a206-e30238072ae1@bytedance.com>
 <20231011132456.GO14330@noisy.programming.kicks-ass.net>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231011132456.GO14330@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 9:24 PM, Peter Zijlstra Wrote:
> On Wed, Oct 11, 2023 at 08:00:22PM +0800, Abel Wu wrote:
>> On 5/31/23 7:58 PM, Peter Zijlstra Wrote:
>>>    		/*
>>> +		 * If we want to place a task and preserve lag, we have to
>>> +		 * consider the effect of the new entity on the weighted
>>> +		 * average and compensate for this, otherwise lag can quickly
>>> +		 * evaporate.
>>> +		 *
>>> +		 * Lag is defined as:
>>> +		 *
>>> +		 *   lag_i = S - s_i = w_i * (V - v_i)
>>> +		 *
>>> +		 * To avoid the 'w_i' term all over the place, we only track
>>> +		 * the virtual lag:
>>> +		 *
>>> +		 *   vl_i = V - v_i <=> v_i = V - vl_i
>>> +		 *
>>> +		 * And we take V to be the weighted average of all v:
>>> +		 *
>>> +		 *   V = (\Sum w_j*v_j) / W
>>> +		 *
>>> +		 * Where W is: \Sum w_j
>>> +		 *
>>> +		 * Then, the weighted average after adding an entity with lag
>>> +		 * vl_i is given by:
>>> +		 *
>>> +		 *   V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
>>> +		 *      = (W*V + w_i*(V - vl_i)) / (W + w_i)
>>> +		 *      = (W*V + w_i*V - w_i*vl_i) / (W + w_i)
>>> +		 *      = (V*(W + w_i) - w_i*l) / (W + w_i)
>>> +		 *      = V - w_i*vl_i / (W + w_i)
>>> +		 *
>>> +		 * And the actual lag after adding an entity with vl_i is:
>>> +		 *
>>> +		 *   vl'_i = V' - v_i
>>> +		 *         = V - w_i*vl_i / (W + w_i) - (V - vl_i)
>>> +		 *         = vl_i - w_i*vl_i / (W + w_i)
>>> +		 *
>>> +		 * Which is strictly less than vl_i. So in order to preserve lag
>>
>> Maybe a stupid question, but why vl'_i < vl_i? Since vl_i can be negative.
> 
> So the below doesn't care about the sign, it simply inverts this
> relation to express vl_i in vl'_i:
> 
>>> +		 * we should inflate the lag before placement such that the
>>> +		 * effective lag after placement comes out right.
>>> +		 *
>>> +		 * As such, invert the above relation for vl'_i to get the vl_i
>>> +		 * we need to use such that the lag after placement is the lag
>>> +		 * we computed before dequeue.
>>> +		 *
>>> +		 *   vl'_i = vl_i - w_i*vl_i / (W + w_i)
>>> +		 *         = ((W + w_i)*vl_i - w_i*vl_i) / (W + w_i)
>>> +		 *
>>> +		 *   (W + w_i)*vl'_i = (W + w_i)*vl_i - w_i*vl_i
>>> +		 *                   = W*vl_i
>>> +		 *
>>> +		 *   vl_i = (W + w_i)*vl'_i / W
> 
> And then we obtain the scale factor: (W + w_i)/W, which is >1, right?

Yeah, I see. But the scale factor is only for the to-be-placed entity.
Say there is an entity k on the tree:

	vl_k	= V - v_k

adding the to-be-placed entity i affects this by:

	define delta := w_i*vl_i / (W + w_i)

	vl'_k	= V' - v_k
		= V - delta - (V - vl_k)
		= vl_k - delta

hence for any entity on the tree, its lag is offsetted by @delta. So
I wonder if we should simply do offsetting rather than scaling.

> 
> As such, that means that vl'_i must be smaller than vl_i in the absolute
> sense, irrespective of sign.
