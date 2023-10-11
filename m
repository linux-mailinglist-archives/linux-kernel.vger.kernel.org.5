Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5A27C48B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 06:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbjJKEPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 00:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjJKEPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 00:15:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8648F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 21:14:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c60f1a2652so4647875ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 21:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696997682; x=1697602482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qH85XMv6q1Jdw5z1vx7UoLkEaTnNA8rFTTyIGAI3NFM=;
        b=D3KtOkMDfpmuBYmwZrpVK2a10mLlWxA1Q0Po8hDNoMhZCGIXVYNOV+wbdYYTLfll97
         igmJPufoDlKvsDS84+R8Rp4HCXJiHUPkHutUEQWTSh9Je/932VON4U2hRsG3xFQFGqB5
         rWzUR94KrQ6B19atohiEcvCduNVZWZak3nz9Ur4sk3ryOHDbLOlXUXsSWJd6C55DpU75
         otK38jLKv4Qm8lexapgbWqOeco+zGd4qLRg38ViMHsb8JXfcOax8kpm6llF6k9Jk7ec6
         q4WOsY7b68HEFwKqLTEKnPJzJEo4d+KF630qsFEEstDMq6X0VQdR6EQ+C+b9NOt2ETrY
         wqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696997682; x=1697602482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qH85XMv6q1Jdw5z1vx7UoLkEaTnNA8rFTTyIGAI3NFM=;
        b=uX8ZHXnIdBRYidSvdlJhXgddaWKBxRMsuHfzUXPEiJqKb9GP/cKjRVavD0eNXukezN
         NYVVchNVFKFwdVYmgapoNmoL1Zisg0Dw3IrIiDWNFh6sPS+do7qCrUUUfu3dgX/p6MKc
         da9OMfYmaVqLIvRwdVKZmAXaG78vY4pt0nWRksyQhlfUxrxFZyOd4MtDJEa7UySwmMnV
         lxTPRmdqsd8LzVJ87jsKZPCBCeiZsyAz8sij55dZVQaejxla5IOmhmOgTdZq5dtsR5aO
         02LwB1QLYbCGPHB69O5D4es2h2FVCFVlBN1OGPIrgaGp2GZ0ZLQDUHeNnku2oinQuOHo
         YnHQ==
X-Gm-Message-State: AOJu0Yyia05mDFXaVyuKoriutTiRZE/Xj7arbl/NY7+OG/WP8BKlRzb3
        yhHS2MAitmAY7rg1jHKlPydGkeTlUsBK5uC31kE=
X-Google-Smtp-Source: AGHT+IGyFavFi3q1xMOoJt0wiu6N1iEH0XseNxsIRIfatYatZe4DedXqQV0ld8qFgRKXVyRCdIH1Mg==
X-Received: by 2002:a17:902:ecc4:b0:1c5:c546:fece with SMTP id a4-20020a170902ecc400b001c5c546fecemr25441555plh.34.1696997681844;
        Tue, 10 Oct 2023 21:14:41 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id iz18-20020a170902ef9200b001b8622c1ad2sm12688695plb.130.2023.10.10.21.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 21:14:41 -0700 (PDT)
Message-ID: <a54a4ccb-9d56-4686-93b6-e9bbbe01f625@bytedance.com>
Date:   Wed, 11 Oct 2023 12:14:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 05/15] sched/fair: Implement an EEVDF like policy
Content-Language: en-US
To:     Benjamin Segall <bsegall@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
References: <20230531115839.089944915@infradead.org>
 <20230531124603.931005524@infradead.org> <xm265y3sodyo.fsf@google.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <xm265y3sodyo.fsf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 9/30/23 5:40 AM, Benjamin Segall Wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
>> +
>> +/*
>> + * Earliest Eligible Virtual Deadline First
>> + *
>> + * In order to provide latency guarantees for different request sizes
>> + * EEVDF selects the best runnable task from two criteria:
>> + *
>> + *  1) the task must be eligible (must be owed service)
>> + *
>> + *  2) from those tasks that meet 1), we select the one
>> + *     with the earliest virtual deadline.
>> + *
>> + * We can do this in O(log n) time due to an augmented RB-tree. The
>> + * tree keeps the entries sorted on service, but also functions as a
>> + * heap based on the deadline by keeping:
>> + *
>> + *  se->min_deadline = min(se->deadline, se->{left,right}->min_deadline)
>> + *
>> + * Which allows an EDF like search on (sub)trees.
>> + */
>> +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>> +{
>> +	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
>> +	struct sched_entity *curr = cfs_rq->curr;
>> +	struct sched_entity *best = NULL;
>> +
>> +	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>> +		curr = NULL;
>> +
>> +	while (node) {
>> +		struct sched_entity *se = __node_2_se(node);
>> +
>> +		/*
>> +		 * If this entity is not eligible, try the left subtree.
>> +		 */
>> +		if (!entity_eligible(cfs_rq, se)) {
>> +			node = node->rb_left;
>> +			continue;
>> +		}
>> +
>> +		/*
>> +		 * If this entity has an earlier deadline than the previous
>> +		 * best, take this one. If it also has the earliest deadline
>> +		 * of its subtree, we're done.
>> +		 */
>> +		if (!best || deadline_gt(deadline, best, se)) {
>> +			best = se;
>> +			if (best->deadline == best->min_deadline)
>> +				break;
>> +		}
>> +
>> +		/*
>> +		 * If the earlest deadline in this subtree is in the fully
>> +		 * eligible left half of our space, go there.
>> +		 */
>> +		if (node->rb_left &&
>> +		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
>> +			node = node->rb_left;
>> +			continue;
>> +		}
>> +
>> +		node = node->rb_right;
>> +	}
> 
> I believe that this can fail to actually find the earliest eligible
> deadline, because the earliest deadline (min_deadline) can be in the
> right branch, but that se isn't eligible, and the actual target se is in
> the left branch. A trivial 3-se example with the nodes represented by
> (vruntime, deadline, min_deadline):
> 
>     (5,9,7)
>   /        \
> (4,8,8)  (6,7,7)
> 
> AIUI, here the EEVDF pick should be (4,8,8), but pick_eevdf() will
> instead pick (5,9,7), because it goes into the right branch and then
> fails eligibility.
> 
> I'm not sure how much of a problem this is in practice, either in
> frequency or severity, but it probably should be mentioned if it's
> an intentional tradeoff.

Assume entity i satisfies (d_i == min_deadline) && (v_i > V), there
must be an eligible entity j with (d_j >= d_i) && (v_j < V). Given
that how deadline is calculated, it can be inferred that:

	vslice_i < vslice_j

IOW a more batch-like entity with looser deadline will beat entities
that is more interactive-like even with tighter deadline, only because
the former is eligible while the latter isn't.

With Benjamin's fix, the semantics of 'Earliest Eligible' preserved.
But since all this is about latency rather than fairness, I wonder if
there are cases worthy of breaking the 'eligible' rule.

Thanks & Best,
	Abel

> 
> 
> 
> Thinking out loud, I think that it would be sufficient to recheck via something like
> 
> for_each_sched_entity(best) {
> 	check __node_2_se(best->rb_left)->min_deadline, store in actual_best
> }
> 
> for the best min_deadline, and then go do a heap lookup in actual_best
> to find the se matching that min_deadline.
> 
> I think this pass could then be combined with our initial descent for
> better cache behavior by keeping track of the best rb_left->min_deadline
> each time we take a right branch. We still have to look at up to ~2x the
> nodes, but I don't think that's avoidable? I'll expand my quick hack I
> used to test my simple case into a something of a stress tester and try
> some implementations.
