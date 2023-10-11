Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DABF7C5362
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjJKMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjJKMPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:15:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BBFD5D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:12:23 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-694f3444f94so5665634b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697026341; x=1697631141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5IYPxqQPd/qz0RKP27Hw7lAiuNLcLfUQd2mLo0pHhfg=;
        b=E0V55ndEgt53VwiDhd/X5g7Yw80Oo2Na7re/QpbPPnEU0ks17/KhI+VFIxNYvI7mV6
         mj64YmO0u6tI0bGGL13RFU4VW3FZeU/XxMuz74ck1Ty2/ORpmfWnbXjIWQsUSKiBkms1
         RvtMqkw0NnnYHG+ujp/plIGUzhSbqh5+nnrYnG7E96BHtiiyhtOarY2amXDtXJhxE8uZ
         WHsxRGhtJVmS/Bv4yjWgiQpYK6kTjVPvV55eAXTUU3DaXCe9ZJ7XYdED+2xe+z22ZxE4
         vq8qAAPVEnTDv+oAykp7HZxF1s/GPwUe0KySJzcfgKa8yV1z5oxgz/xvYu/y4brACQZo
         KWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026341; x=1697631141;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IYPxqQPd/qz0RKP27Hw7lAiuNLcLfUQd2mLo0pHhfg=;
        b=QqtYgSV5DjnCYT2aQtsM0bQwm2kqRgRGtJ3Ru3/0tfKxALYn68MEKBPg6D/q28WHzr
         QRvIFQbQKwYuXmJOMSHQiJdeSaKK47HwaVpZ0ErLgoxsbTfXNDFTMDlOcA8jmeHMYUE6
         JpPc6ozog1gCuJENoWSo1Wa8IVRbP9hiVbxzFx7yMqR3kiw+RNMwyYkP0yVnR6KN1X8w
         /2qmZFqifJuI2vSkAlGw8HBr4fym3qCN4orNwzCeVz22k/En8CUmknPz70dANjFI7oJN
         emMcIfyumh2ZgteHepAJlPu18m/YjUpIBCdXFzpxl9tkohnw2MDsQiiS7vFbJtW6R7gX
         ObZA==
X-Gm-Message-State: AOJu0YwUCYFa9N9H5EJNOmc5rARf3L6J7ykuwqzGSspD46+LfzGo+Sax
        1rXU/66Jc3yHjU7TZjLbE/IUIQ==
X-Google-Smtp-Source: AGHT+IEo1oHe7b8VwYzNA9yeOWRLbizr8P75O0AnzXHdlRm6f5HpuPmK3uZwwsS6YsmZOjHz8r3sTA==
X-Received: by 2002:a05:6a00:15ce:b0:68e:3d83:e501 with SMTP id o14-20020a056a0015ce00b0068e3d83e501mr26764689pfu.13.1697026341266;
        Wed, 11 Oct 2023 05:12:21 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id q25-20020a62e119000000b006933866f49dsm10335345pfh.19.2023.10.11.05.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 05:12:20 -0700 (PDT)
Message-ID: <6b606049-3412-437f-af25-a4c33139e2d8@bytedance.com>
Date:   Wed, 11 Oct 2023 20:12:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Abel Wu <wuyun.abel@bytedance.com>
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
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
 <20230531124603.931005524@infradead.org> <xm261qego72d.fsf_-_@google.com>
Content-Language: en-US
In-Reply-To: <xm261qego72d.fsf_-_@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/23 8:09 AM, Benjamin Segall Wrote:
> The old pick_eevdf could fail to find the actual earliest eligible
> deadline when it descended to the right looking for min_deadline, but it
> turned out that that min_deadline wasn't actually eligible. In that case
> we need to go back and search through any left branches we skipped
> looking for the actual best _eligible_ min_deadline.
> 
> This is more expensive, but still O(log n), and at worst should only
> involve descending two branches of the rbtree.
> 
> I've run this through a userspace stress test (thank you
> tools/lib/rbtree.c), so hopefully this implementation doesn't miss any
> corner cases.
> 
> Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
> Signed-off-by: Ben Segall <bsegall@google.com>
> ---
>   kernel/sched/fair.c | 72 ++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 58 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0c31cda0712f..77e9440b8ab3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -864,18 +864,20 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
>    *
>    *  se->min_deadline = min(se->deadline, se->{left,right}->min_deadline)
>    *
>    * Which allows an EDF like search on (sub)trees.
>    */
> -static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> +static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
>   {
>   	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
>   	struct sched_entity *curr = cfs_rq->curr;
>   	struct sched_entity *best = NULL;
> +	struct sched_entity *best_left = NULL;
>   
>   	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>   		curr = NULL;
> +	best = curr;
>   
>   	/*
>   	 * Once selected, run a task until it either becomes non-eligible or
>   	 * until it gets a new slice. See the HACK in set_next_entity().
>   	 */
> @@ -892,45 +894,87 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   			node = node->rb_left;
>   			continue;
>   		}
>   
>   		/*
> -		 * If this entity has an earlier deadline than the previous
> -		 * best, take this one. If it also has the earliest deadline
> -		 * of its subtree, we're done.
> +		 * Now we heap search eligible trees for the best (min_)deadline
>   		 */
> -		if (!best || deadline_gt(deadline, best, se)) {
> +		if (!best || deadline_gt(deadline, best, se))
>   			best = se;
> -			if (best->deadline == best->min_deadline)
> -				break;
> -		}
>   
>   		/*
> -		 * If the earlest deadline in this subtree is in the fully
> -		 * eligible left half of our space, go there.
> +		 * Every se in a left branch is eligible, keep track of the
> +		 * branch with the best min_deadline
>   		 */
> +		if (node->rb_left) {
> +			struct sched_entity *left = __node_2_se(node->rb_left);
> +
> +			if (!best_left || deadline_gt(min_deadline, best_left, left))
> +				best_left = left;
> +
> +			/*
> +			 * min_deadline is in the left branch. rb_left and all
> +			 * descendants are eligible, so immediately switch to the second
> +			 * loop.
> +			 */
> +			if (left->min_deadline == se->min_deadline)
> +				break;
> +		}
> +
> +		/* min_deadline is at this node, no need to look right */
> +		if (se->deadline == se->min_deadline)
> +			break;
> +
> +		/* else min_deadline is in the right branch. */
> +		node = node->rb_right;
> +	}
> +
> +	/*
> +	 * We ran into an eligible node which is itself the best.
> +	 * (Or nr_running == 0 and both are NULL)
> +	 */
> +	if (!best_left || (s64)(best_left->min_deadline - best->deadline) > 0)
> +		return best;
> +
> +	/*
> +	 * Now best_left and all of its children are eligible, and we are just
> +	 * looking for deadline == min_deadline
> +	 */
> +	node = &best_left->run_node;
> +	while (node) {
> +		struct sched_entity *se = __node_2_se(node);
> +
> +		/* min_deadline is the current node */
> +		if (se->deadline == se->min_deadline)
> +			return se;

IMHO it would be better tiebreak on vruntime by moving this hunk to ..

> +
> +		/* min_deadline is in the left branch */
>   		if (node->rb_left &&
>   		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
>   			node = node->rb_left;
>   			continue;
>   		}

.. here, thoughts?

>   
> +		/* else min_deadline is in the right branch */
>   		node = node->rb_right;
>   	}
> +	return NULL;

Why not 'best'? Since ..

> +}
>   
> -	if (!best || (curr && deadline_gt(deadline, best, curr)))
> -		best = curr;
> +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> +{
> +	struct sched_entity *se = __pick_eevdf(cfs_rq);
>   
> -	if (unlikely(!best)) {
> +	if (!se) {
>   		struct sched_entity *left = __pick_first_entity(cfs_rq);

.. cfs_rq->curr isn't considered here.

>   		if (left) {
>   			pr_err("EEVDF scheduling fail, picking leftmost\n");
>   			return left;
>   		}
>   	}
>   
> -	return best;
> +	return se;
>   }
>   
>   #ifdef CONFIG_SCHED_DEBUG
>   struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
>   {

The implementation of __pick_eevdf() now is quite complicated which
makes it really hard to maintain. I'm trying my best to refactor this
part, hopefully can do some help. Below is only for illustration, I
need to test more.

static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
{
	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
	struct sched_entity *curr = cfs_rq->curr;
	struct sched_entity *best = NULL;
	struct sched_entity *cand = NULL;
	bool all_eligible = false;

	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
		curr = NULL;

	/*
	 * Once selected, run a task until it either becomes non-eligible or
	 * until it gets a new slice. See the HACK in set_next_entity().
	 */
	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
		return curr;

	while (node) {
		struct sched_entity *se = __node_2_se(node);

		/*
		 * If this entity is not eligible, try the left subtree.
		 */
		if (!all_eligible && !entity_eligible(cfs_rq, se)) {
			node = node->rb_left;
			continue;
		}

		if (node->rb_left) {
			struct sched_entity *left = __node_2_se(node->rb_left);

			BUG_ON(left->min_deadline < se->min_deadline);

			/* Tiebreak on vruntime */
			if (left->min_deadline == se->min_deadline) {
				node = node->rb_left;
				all_eligible = true;
				continue;
			}

			if (!all_eligible) {
				/*
				 * We're going to search right subtree and the one
				 * with min_deadline can be non-eligible, so record
				 * the left subtree as a candidate.
				 */
				if (!cand || deadline_gt(min_deadline, cand, left))
					cand = left;
			}
		}

		/* min_deadline is at this node, no need to look right */
		if (se->deadline == se->min_deadline) {
			best = se;
			break;
		}

		node = node->rb_right;

		if (!node && cand) {
			node = cand;
			all_eligible = true;
			cand = NULL;
		}
	}

	if (!best || (curr && deadline_gt(deadline, best, curr)))
		best = curr;

	return best;
}
