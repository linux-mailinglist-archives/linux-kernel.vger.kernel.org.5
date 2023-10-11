Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF77C48C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 06:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbjJKEP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 00:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjJKEPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 00:15:55 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBDC98
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 21:15:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-565334377d0so5127216a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 21:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696997737; x=1697602537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M/L+oFX73I1DLhNw5xKbWrJ8qK6cX/HW2W4SIIqYKO0=;
        b=i+id32y/pKEaxyCVJc+wFKN8tEUFzJ8f1ZcEomPBBPJ3VsUvSpzCiqjK1Iwrkd8YF6
         yy157tFNg5HUOawHS5P8PxsXHjIEThvSX7WYGtXw18UVOcknB1XpzCZzL3l4kpnzDy3A
         b39ai0S7/XoGVuVNVNabDk5IZm4KVRQQJk9r+Hp6Z/q/w6ySnnhq6QtgIiUjfK3Yvhau
         2tszKjCJHGYwlXeepdPaFVFEu7KPC2LEuZ5oQDDMESCHW2vs5HSDn7YgOjSoxc/4W6Gk
         AlINASi6+PP2seUXHFhMPZNzkScCrlXgx65eD1wWn/io1RyM4HMJL1hYdQ2dqJ1pE9z8
         BKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696997737; x=1697602537;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/L+oFX73I1DLhNw5xKbWrJ8qK6cX/HW2W4SIIqYKO0=;
        b=btYlVf1lmzJyT4Xxi2vAwlI45OuWNjOMK2khMU22Q+I4E0ZFp0M0yOUNJFoViP1owB
         0S63FBDvAbEgUF+VJNlE9fos0F+Bglng72olGH3rbcq56ZpaBeEvvfz4UYoVYDTCsUyV
         D3J4mCxCFL9+6LgZHZlDZ2bLAUHdBLM3PrL0ivstjjMwckEYd10cjjeqYECKsrm6RT05
         7KjmFRp749K/AGxpO16t0Lp9r2rnOtmKdSRtTko9leS3/MyxnJhbJ2sUB0T+OkAhq3aY
         q2Ak7Kk382G38tcDsdhCATdvYKXNVXdg2tn+lWF2P0/nF9F55gDrr+PZvbpIg17Lt2X6
         FjBw==
X-Gm-Message-State: AOJu0YzeXFVuLFLDv6ciXHYTpHpqgMEmZ0iadprSJuJIZAZyTYIclqqn
        RoYclFFD9rzJmY+kDuX+o1YYqg==
X-Google-Smtp-Source: AGHT+IGP4km4wqnYfIR4n30yirje1NaDctWTgWFBBZpdl/jgj8uYCj9LElP2KGivvGQvUY5SYzWwuQ==
X-Received: by 2002:a05:6a20:3cac:b0:15d:9ee7:1816 with SMTP id b44-20020a056a203cac00b0015d9ee71816mr25479752pzj.10.1696997736975;
        Tue, 10 Oct 2023 21:15:36 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id iz18-20020a170902ef9200b001b8622c1ad2sm12688695plb.130.2023.10.10.21.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 21:15:36 -0700 (PDT)
Message-ID: <75adcb1a-c02f-4d7c-bd9c-ab4f403af3e8@bytedance.com>
Date:   Wed, 11 Oct 2023 12:15:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Abel Wu <wuyun.abel@bytedance.com>
Subject: Re: [PATCH 01/15] sched/fair: Add avg_vruntime
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
 <20230531124603.654144274@infradead.org>
Content-Language: en-US
In-Reply-To: <20230531124603.654144274@infradead.org>
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

On 5/31/23 7:58 PM, Peter Zijlstra wrote:
> +/*
> + * Compute virtual time from the per-task service numbers:
> + *
> + * Fair schedulers conserve lag:
> + *
> + *   \Sum lag_i = 0
> + *
> + * Where lag_i is given by:
> + *
> + *   lag_i = S - s_i = w_i * (V - v_i)

Since the ideal service time S is task-specific, should this be:

	lag_i = S_i - s_i = w_i * (V - v_i)

> + *
> + * Where S is the ideal service time and V is it's virtual time counterpart.
> + * Therefore:
> + *
> + *   \Sum lag_i = 0
> + *   \Sum w_i * (V - v_i) = 0
> + *   \Sum w_i * V - w_i * v_i = 0
> + *
> + * From which we can solve an expression for V in v_i (which we have in
> + * se->vruntime):
> + *
> + *       \Sum v_i * w_i   \Sum v_i * w_i
> + *   V = -------------- = --------------
> + *          \Sum w_i            W
> + *
> + * Specifically, this is the weighted average of all entity virtual runtimes.
> + *
> + * [[ NOTE: this is only equal to the ideal scheduler under the condition
> + *          that join/leave operations happen at lag_i = 0, otherwise the
> + *          virtual time has non-continguous motion equivalent to:
> + *
> + *	      V +-= lag_i / W
> + *
> + *	    Also see the comment in place_entity() that deals with this. ]]
> + *
> + * However, since v_i is u64, and the multiplcation could easily overflow
> + * transform it into a relative form that uses smaller quantities:
> + *
> + * Substitute: v_i == (v_i - v0) + v0
> + *
> + *     \Sum ((v_i - v0) + v0) * w_i   \Sum (v_i - v0) * w_i
> + * V = ---------------------------- = --------------------- + v0
> + *                  W                            W
> + *
> + * Which we track using:
> + *
> + *                    v0 := cfs_rq->min_vruntime
> + * \Sum (v_i - v0) * w_i := cfs_rq->avg_vruntime

IMHO 'sum_runtime' would be more appropriate? Since it actually is
the summed real time rather than virtual time. And also 'sum_load'
instead of 'avg_load'.

Thanks & Best,
	Abel
