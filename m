Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64C47C52CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjJKMAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbjJKMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:00:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9025BA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:00:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c77449a6daso58106965ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697025633; x=1697630433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iA1aCpGj4fxf5ryUQ+BYRYboYwfuHTQLEcEzkMXVGpk=;
        b=ezyx0+PwuoYdvM8zoawNaWcJKI7ux9fWTDXzhzn2XNaE29z9A8zRhmo0T9ZUk/Qu8u
         LZyHAeLHXxedSwfGKQoBniJMSFUrmKDmPV8MinE9BRSAjoB1Wo3aNWoGmwBTJ/NgBiSL
         fvpDctnhoeXALAesMQ5fyfIStmlLvNCjmWZiby+9qtga+O4NTwOMS2i6b/PrY6z1bCEx
         mOZ8kXg1iK1Mrpsu2WRyF2twRHGSwkqBhhUZYdBVA5TYm85ebOms5FoJSvJUPsXunki5
         TdM2CP4/3FrNH4llEcmB+B0l4cEJTaEPCC3V+EIcg69iuJqBS2+0SBXmd5J1cpy74zjw
         igmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697025633; x=1697630433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iA1aCpGj4fxf5ryUQ+BYRYboYwfuHTQLEcEzkMXVGpk=;
        b=cRzCcwEx34sVX+QboD2P6pF2hWKg2JuXJtNQ8O6nm4LQLHtnUZAbrb4A/kC3+033UO
         5Ei9EvqG3Bw8+dpT60DRUiRWFrl2dCDQY/qpIOzE/u/wQd+3ZyJIMRru3w3bEwloqF5b
         snHFt/KCBaKmx23XHcn6+scsskc8KnGjwTgrcQl2Iykpb7r1b7qHlvEuMdU0hRmkheVl
         px2n3hRGL4X+N7cKgEdjJ9PIUDfRRIGq5o5h4MeY4Q9/1yyjkk1HIxM7PVtQ3Aj+7xAp
         IZnt7SfKmqf5aUsZrtqIGDxFrtLRts7+78lN4lN/rxe0GcNIBoMqwA9w2oD/us/CGNPV
         VuLA==
X-Gm-Message-State: AOJu0YxhjxOQHe4Esul5oYn9GD4fFMNODlMr5GlTwqPsOHtlHkSGxwgH
        68zENw1bGiyDyisbTk0xV3Be3w==
X-Google-Smtp-Source: AGHT+IFYdnYumd5e6eub+Acwg16ONmwSYhNeAVpy8PqH0oHrEXkQl8QSjugBxuya8UbHsAcoGwIluQ==
X-Received: by 2002:a17:902:bd47:b0:1bc:2188:ef88 with SMTP id b7-20020a170902bd4700b001bc2188ef88mr18416757plx.3.1697025633211;
        Wed, 11 Oct 2023 05:00:33 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902694900b001c73eace0fesm13736264plt.157.2023.10.11.05.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 05:00:32 -0700 (PDT)
Message-ID: <87f1feec-1be5-4d24-a206-e30238072ae1@bytedance.com>
Date:   Wed, 11 Oct 2023 20:00:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] sched/fair: Add lag based placement
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
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
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230531124603.794929315@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 7:58 PM, Peter Zijlstra Wrote:
>   		/*
> -		 * Halve their sleep time's effect, to allow
> -		 * for a gentler effect of sleepers:
> +		 * If we want to place a task and preserve lag, we have to
> +		 * consider the effect of the new entity on the weighted
> +		 * average and compensate for this, otherwise lag can quickly
> +		 * evaporate.
> +		 *
> +		 * Lag is defined as:
> +		 *
> +		 *   lag_i = S - s_i = w_i * (V - v_i)
> +		 *
> +		 * To avoid the 'w_i' term all over the place, we only track
> +		 * the virtual lag:
> +		 *
> +		 *   vl_i = V - v_i <=> v_i = V - vl_i
> +		 *
> +		 * And we take V to be the weighted average of all v:
> +		 *
> +		 *   V = (\Sum w_j*v_j) / W
> +		 *
> +		 * Where W is: \Sum w_j
> +		 *
> +		 * Then, the weighted average after adding an entity with lag
> +		 * vl_i is given by:
> +		 *
> +		 *   V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
> +		 *      = (W*V + w_i*(V - vl_i)) / (W + w_i)
> +		 *      = (W*V + w_i*V - w_i*vl_i) / (W + w_i)
> +		 *      = (V*(W + w_i) - w_i*l) / (W + w_i)
> +		 *      = V - w_i*vl_i / (W + w_i)
> +		 *
> +		 * And the actual lag after adding an entity with vl_i is:
> +		 *
> +		 *   vl'_i = V' - v_i
> +		 *         = V - w_i*vl_i / (W + w_i) - (V - vl_i)
> +		 *         = vl_i - w_i*vl_i / (W + w_i)
> +		 *
> +		 * Which is strictly less than vl_i. So in order to preserve lag

Maybe a stupid question, but why vl'_i < vl_i? Since vl_i can be negative.

> +		 * we should inflate the lag before placement such that the
> +		 * effective lag after placement comes out right.
> +		 *
> +		 * As such, invert the above relation for vl'_i to get the vl_i
> +		 * we need to use such that the lag after placement is the lag
> +		 * we computed before dequeue.
> +		 *
> +		 *   vl'_i = vl_i - w_i*vl_i / (W + w_i)
> +		 *         = ((W + w_i)*vl_i - w_i*vl_i) / (W + w_i)
> +		 *
> +		 *   (W + w_i)*vl'_i = (W + w_i)*vl_i - w_i*vl_i
> +		 *                   = W*vl_i
> +		 *
> +		 *   vl_i = (W + w_i)*vl'_i / W
>   		 */
> -		if (sched_feat(GENTLE_FAIR_SLEEPERS))
> -			thresh >>= 1;
> +		load = cfs_rq->avg_load;
> +		if (curr && curr->on_rq)
> +			load += curr->load.weight;
>   
> -		vruntime -= thresh;
> +		lag *= load + se->load.weight;
> +		if (WARN_ON_ONCE(!load))
> +			load = 1;
> +		lag = div_s64(lag, load);
> +
> +		vruntime -= lag;
>   	}
