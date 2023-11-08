Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EDF7E5E71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjKHTPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjKHTPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:15:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F30C2110
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 11:15:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc921a4632so60889815ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699470938; x=1700075738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fk2SgBlDMug0ur7gOE+m38c7YXlyPUQhIZMixH2AHvU=;
        b=IGJdKFeop74669yJy64I3QG8Onj9t9YV3ytgKNakyWBpFArA4VnKttL2sRx9UxnpN+
         OKPpZvjPiT0RLDajwfPXHGtNRXJiJ1ekzsOClkZxlw/xdytsQ8j4+2+PUHuztAnHvbnM
         xtiwi5M33rATQqbqW4f1kDVMX2drFhlrFhTxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470938; x=1700075738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk2SgBlDMug0ur7gOE+m38c7YXlyPUQhIZMixH2AHvU=;
        b=o6xoghwBY0zwFiK8p8M/aLYwqHHThDCcOY4LWx1BaQVbgdAH4elcNBW28jl+WVmz8U
         zziitF4C8Aw+yFCrRz8N0mZULomvdGxAy73MOL3kuwcxWaPjEfVjvLc2CCwW6mUTQJzh
         oUO1i2+MCUpmt2dlcZOGlUXoNvNGej/93NSg4Kjq1m6fJ3wgB4EVVPmg2kFy3T7i9rv0
         HXN6x7H4QPlIoD0mqKWSQydNod/Rge1vQGTVlbpYWVqX2xNiTe/AoTrgBZWnOJHiHGNy
         G2ReuIrCwP7KFUJ6cbViAWGcy39sJSh7Kd5Zlf54P9vXWYSeUH+J3L0+fS/RTj3CaLPc
         2eSg==
X-Gm-Message-State: AOJu0YwDq/PEo6Fkbycl3hKaIdXkidTDkxo/VmN5TmOOgDVXZHmUVLml
        6HPKS96nAiOC2OXLFmheHH46Ww==
X-Google-Smtp-Source: AGHT+IESgcwRWJ2lh3WkYRPb5CrL6xBbAcBks+GW7V1pK2sL8gXJOEmDfrXsuJVvR9ev9cFJBs+dbA==
X-Received: by 2002:a17:902:db11:b0:1cc:3c2d:128e with SMTP id m17-20020a170902db1100b001cc3c2d128emr2832441plx.7.1699470938492;
        Wed, 08 Nov 2023 11:15:38 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001cbf3824360sm2101295pll.95.2023.11.08.11.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:15:37 -0800 (PST)
Date:   Wed, 8 Nov 2023 11:15:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Thomas Graf <tgraf@suug.ch>
Subject: Re: [RFC PATCH 71/86] treewide: lib: remove cond_resched()
Message-ID: <202311081114.0F15C1FB9@keescook>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-15-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107230822.371443-15-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:08:07PM -0800, Ankur Arora wrote:
> There are broadly three sets of uses of cond_resched():
> 
> 1.  Calls to cond_resched() out of the goodness of our heart,
>     otherwise known as avoiding lockup splats.
> 
> 2.  Open coded variants of cond_resched_lock() which call
>     cond_resched().
> 
> 3.  Retry or error handling loops, where cond_resched() is used as a
>     quick alternative to spinning in a tight-loop.
> 
> When running under a full preemption model, the cond_resched() reduces
> to a NOP (not even a barrier) so removing it obviously cannot matter.
> 
> But considering only voluntary preemption models (for say code that
> has been mostly tested under those), for set-1 and set-2 the
> scheduler can now preempt kernel tasks running beyond their time
> quanta anywhere they are preemptible() [1]. Which removes any need
> for these explicitly placed scheduling points.
> 
> The cond_resched() calls in set-3 are a little more difficult.
> To start with, given it's NOP character under full preemption, it
> never actually saved us from a tight loop.
> With voluntary preemption, it's not a NOP, but it might as well be --
> for most workloads the scheduler does not have an interminable supply
> of runnable tasks on the runqueue.
> 
> So, cond_resched() is useful to not get softlockup splats, but not
> terribly good for error handling. Ideally, these should be replaced
> with some kind of timed or event wait.
> For now we use cond_resched_stall(), which tries to schedule if
> possible, and executes a cpu_relax() if not.
> 
> Almost all the cond_resched() calls are from set-1. Remove them.

FOr the memcpy_kunit.c cases, I don't think there are preemption
locations in its loops. Perhaps I'm misunderstanding something? Why will
the memcpy test no longer produce softlockup splats?

-Kees

> 
> [1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net> 
> Cc: Kees Cook <keescook@chromium.org> 
> Cc: Eric Dumazet <edumazet@google.com> 
> Cc: Jakub Kicinski <kuba@kernel.org> 
> Cc: Paolo Abeni <pabeni@redhat.com> 
> Cc: Thomas Graf <tgraf@suug.ch>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  lib/crc32test.c          |  2 --
>  lib/crypto/mpi/mpi-pow.c |  1 -
>  lib/memcpy_kunit.c       |  5 -----
>  lib/random32.c           |  1 -
>  lib/rhashtable.c         |  2 --
>  lib/test_bpf.c           |  3 ---
>  lib/test_lockup.c        |  2 +-
>  lib/test_maple_tree.c    |  8 --------
>  lib/test_rhashtable.c    | 10 ----------
>  9 files changed, 1 insertion(+), 33 deletions(-)
> 
> diff --git a/lib/crc32test.c b/lib/crc32test.c
> index 9b4af79412c4..3eee90482e9a 100644
> --- a/lib/crc32test.c
> +++ b/lib/crc32test.c
> @@ -729,7 +729,6 @@ static int __init crc32c_combine_test(void)
>  			      crc_full == test[i].crc32c_le))
>  				errors++;
>  			runs++;
> -			cond_resched();
>  		}
>  	}
>  
> @@ -817,7 +816,6 @@ static int __init crc32_combine_test(void)
>  			      crc_full == test[i].crc_le))
>  				errors++;
>  			runs++;
> -			cond_resched();
>  		}
>  	}
>  
> diff --git a/lib/crypto/mpi/mpi-pow.c b/lib/crypto/mpi/mpi-pow.c
> index 2fd7a46d55ec..074534900b7e 100644
> --- a/lib/crypto/mpi/mpi-pow.c
> +++ b/lib/crypto/mpi/mpi-pow.c
> @@ -242,7 +242,6 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
>  				}
>  				e <<= 1;
>  				c--;
> -				cond_resched();
>  			}
>  
>  			i--;
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 440aee705ccc..c2a6b09fe93a 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -361,8 +361,6 @@ static void copy_large_test(struct kunit *test, bool use_memmove)
>  			/* Zero out what we copied for the next cycle. */
>  			memset(large_dst + offset, 0, bytes);
>  		}
> -		/* Avoid stall warnings if this loop gets slow. */
> -		cond_resched();
>  	}
>  }
>  
> @@ -489,9 +487,6 @@ static void memmove_overlap_test(struct kunit *test)
>  			for (int s_off = s_start; s_off < s_end;
>  			     s_off = next_step(s_off, s_start, s_end, window_step))
>  				inner_loop(test, bytes, d_off, s_off);
> -
> -			/* Avoid stall warnings. */
> -			cond_resched();
>  		}
>  	}
>  }
> diff --git a/lib/random32.c b/lib/random32.c
> index 32060b852668..10bc804d99d6 100644
> --- a/lib/random32.c
> +++ b/lib/random32.c
> @@ -287,7 +287,6 @@ static int __init prandom_state_selftest(void)
>  			errors++;
>  
>  		runs++;
> -		cond_resched();
>  	}
>  
>  	if (errors)
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 6ae2ba8e06a2..5ff0f521bf29 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -328,7 +328,6 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
>  		err = rhashtable_rehash_chain(ht, old_hash);
>  		if (err)
>  			return err;
> -		cond_resched();
>  	}
>  
>  	/* Publish the new table pointer. */
> @@ -1147,7 +1146,6 @@ void rhashtable_free_and_destroy(struct rhashtable *ht,
>  		for (i = 0; i < tbl->size; i++) {
>  			struct rhash_head *pos, *next;
>  
> -			cond_resched();
>  			for (pos = rht_ptr_exclusive(rht_bucket(tbl, i)),
>  			     next = !rht_is_a_nulls(pos) ?
>  					rht_dereference(pos->next, ht) : NULL;
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index ecde4216201e..15b4d32712d8 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -14758,7 +14758,6 @@ static __init int test_skb_segment(void)
>  	for (i = 0; i < ARRAY_SIZE(skb_segment_tests); i++) {
>  		const struct skb_segment_test *test = &skb_segment_tests[i];
>  
> -		cond_resched();
>  		if (exclude_test(i))
>  			continue;
>  
> @@ -14787,7 +14786,6 @@ static __init int test_bpf(void)
>  		struct bpf_prog *fp;
>  		int err;
>  
> -		cond_resched();
>  		if (exclude_test(i))
>  			continue;
>  
> @@ -15171,7 +15169,6 @@ static __init int test_tail_calls(struct bpf_array *progs)
>  		u64 duration;
>  		int ret;
>  
> -		cond_resched();
>  		if (exclude_test(i))
>  			continue;
>  
> diff --git a/lib/test_lockup.c b/lib/test_lockup.c
> index c3fd87d6c2dd..9af5d34c98f6 100644
> --- a/lib/test_lockup.c
> +++ b/lib/test_lockup.c
> @@ -381,7 +381,7 @@ static void test_lockup(bool master)
>  			touch_nmi_watchdog();
>  
>  		if (call_cond_resched)
> -			cond_resched();
> +			cond_resched_stall();
>  
>  		test_wait(cooldown_secs, cooldown_nsecs);
>  
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index 464eeb90d5ad..321fd5d8aef3 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -2672,7 +2672,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
>  		rcu_barrier();
>  	}
>  
> -	cond_resched();
>  	mt_cache_shrink();
>  	/* Check with a value at zero, no gap */
>  	for (i = 1000; i < 2000; i++) {
> @@ -2682,7 +2681,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
>  		rcu_barrier();
>  	}
>  
> -	cond_resched();
>  	mt_cache_shrink();
>  	/* Check with a value at zero and unreasonably large */
>  	for (i = big_start; i < big_start + 10; i++) {
> @@ -2692,7 +2690,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
>  		rcu_barrier();
>  	}
>  
> -	cond_resched();
>  	mt_cache_shrink();
>  	/* Small to medium size not starting at zero*/
>  	for (i = 200; i < 1000; i++) {
> @@ -2702,7 +2699,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
>  		rcu_barrier();
>  	}
>  
> -	cond_resched();
>  	mt_cache_shrink();
>  	/* Unreasonably large not starting at zero*/
>  	for (i = big_start; i < big_start + 10; i++) {
> @@ -2710,7 +2706,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
>  		check_dup_gaps(mt, i, false, 5);
>  		mtree_destroy(mt);
>  		rcu_barrier();
> -		cond_resched();
>  		mt_cache_shrink();
>  	}
>  
> @@ -2720,7 +2715,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
>  		check_dup_gaps(mt, i, false, 5);
>  		mtree_destroy(mt);
>  		rcu_barrier();
> -		cond_resched();
>  		if (i % 2 == 0)
>  			mt_cache_shrink();
>  	}
> @@ -2732,7 +2726,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
>  		check_dup_gaps(mt, i, true, 5);
>  		mtree_destroy(mt);
>  		rcu_barrier();
> -		cond_resched();
>  	}
>  
>  	mt_cache_shrink();
> @@ -2743,7 +2736,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
>  		mtree_destroy(mt);
>  		rcu_barrier();
>  		mt_cache_shrink();
> -		cond_resched();
>  	}
>  }
>  
> diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
> index c20f6cb4bf55..e5d1f272f2c6 100644
> --- a/lib/test_rhashtable.c
> +++ b/lib/test_rhashtable.c
> @@ -119,7 +119,6 @@ static int insert_retry(struct rhashtable *ht, struct test_obj *obj,
>  
>  	do {
>  		retries++;
> -		cond_resched();
>  		err = rhashtable_insert_fast(ht, &obj->node, params);
>  		if (err == -ENOMEM && enomem_retry) {
>  			enomem_retries++;
> @@ -253,8 +252,6 @@ static s64 __init test_rhashtable(struct rhashtable *ht, struct test_obj *array,
>  
>  			rhashtable_remove_fast(ht, &obj->node, test_rht_params);
>  		}
> -
> -		cond_resched();
>  	}
>  
>  	end = ktime_get_ns();
> @@ -371,8 +368,6 @@ static int __init test_rhltable(unsigned int entries)
>  		u32 i = get_random_u32_below(entries);
>  		u32 prand = get_random_u32_below(4);
>  
> -		cond_resched();
> -
>  		err = rhltable_remove(&rhlt, &rhl_test_objects[i].list_node, test_rht_params);
>  		if (test_bit(i, obj_in_table)) {
>  			clear_bit(i, obj_in_table);
> @@ -412,7 +407,6 @@ static int __init test_rhltable(unsigned int entries)
>  	}
>  
>  	for (i = 0; i < entries; i++) {
> -		cond_resched();
>  		err = rhltable_remove(&rhlt, &rhl_test_objects[i].list_node, test_rht_params);
>  		if (test_bit(i, obj_in_table)) {
>  			if (WARN(err, "cannot remove element at slot %d", i))
> @@ -607,8 +601,6 @@ static int thread_lookup_test(struct thread_data *tdata)
>  			       obj->value.tid, obj->value.id, key.tid, key.id);
>  			err++;
>  		}
> -
> -		cond_resched();
>  	}
>  	return err;
>  }
> @@ -660,8 +652,6 @@ static int threadfunc(void *data)
>  				goto out;
>  			}
>  			tdata->objs[i].value.id = TEST_INSERT_FAIL;
> -
> -			cond_resched();
>  		}
>  		err = thread_lookup_test(tdata);
>  		if (err) {
> -- 
> 2.31.1
> 

-- 
Kees Cook
