Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5960A76DCDC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjHCApw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHCApu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:45:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA902D4A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:45:47 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4055bc3cdd8so2936071cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 17:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691023546; x=1691628346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GrMEgIpkm4DOHGO7jkt8EZd96GkcH4rGkdwb4adkLh4=;
        b=j7CTXFrnyFko0+2H/M8nyAfarmrhDwmXt+n4w1bxjxq7ssdjRIzyoNV1MTFDwz7GLY
         ijN47+5abnB1LdeMxVLJNF94q0+dTvXR1nqut0q5GcfbzLZ6fVCfEcLOEocZy8pW2cBr
         isfOWiXkCNZ8KGrfwq2GsoPlxyRX1j61IIA4kcW9kUybk8vASOMRsxi3HWAKPE1317Um
         Zxw8JE2YWRZTuSMK1CD8WVt6AasrDWt5oykDdVP41NGRkyySoI/PsU3g7CB5urTSf0Yz
         JhW1eN2s0tVTVXC0TYqGnGtAhBBp4o/yuvfZObgtneSWG4dVwh+Wa1x/xZ/xBS+smfog
         iK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691023546; x=1691628346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrMEgIpkm4DOHGO7jkt8EZd96GkcH4rGkdwb4adkLh4=;
        b=EZg5W6YHwwnju/fOSfhYtn1a9GVFrrfR296pVXbdd7E2Foy6LcCW76HqhmpVU3/2rK
         mMDOLt+aeO4CGeMETKGfZg1whBTw2Ky9IjVUVJfOA8VbF7JZAAh1x+GtezFQrKzpT3JJ
         F5/nayonmabi579XNnw+WJHl+JzmMDkQ4Su1z4VaCa6+aedJCStdC2tcgRze0vIVJDqT
         prG+CzeqKnmnATVtKGTshrmJ3iLLsmxE3BRzmDChgZPEejBT+KchaDBy+BxYVRS97u1M
         cZKmp4m2adlI5I2j8A3veTVBedZL2kwzKiLkm1XKnv7Qbs1ioH+o+9atJPFKCz2Nu8wb
         VN3Q==
X-Gm-Message-State: ABy/qLb+9xzAX/vMB1oUH2lCaqOuV0j/0GQvDiinStf41fomtGhC301E
        /zaOhxnHjzwyh3JfzGj4Oe4=
X-Google-Smtp-Source: APBJJlFeJ5QHYsTLYvciZrfmRwYH5Do4DFRCqMp05HjanrOhz1z506QNy3sHJ0LayCmbrXV9OuDe/g==
X-Received: by 2002:ac8:4e4c:0:b0:40c:82f:b66c with SMTP id e12-20020ac84e4c000000b0040c082fb66cmr19106129qtw.34.1691023546451;
        Wed, 02 Aug 2023 17:45:46 -0700 (PDT)
Received: from localhost ([2607:fb90:8de1:d00d:8c37:1fd4:e9e6:8e5a])
        by smtp.gmail.com with ESMTPSA id j13-20020a37c24d000000b00763b94432ebsm5430212qkm.18.2023.08.02.17.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:45:46 -0700 (PDT)
Date:   Wed, 2 Aug 2023 17:45:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, rppt@kernel.org
Subject: Re: [PATCH v2 2/2] mm,nodemask: Use nr_node_ids
Message-ID: <ZMr4uBfjKY9dERl2@yury-ThinkPad>
References: <20230802112458.230221601@infradead.org>
 <20230802112525.633758009@infradead.org>
 <20230802193616.GC231007@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802193616.GC231007@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Linus, Mateusz

On Wed, Aug 02, 2023 at 09:36:16PM +0200, Peter Zijlstra wrote:
> 
> Just like how cpumask uses nr_cpu_ids to limit the bitmap scanning,
> make nodemask use nr_node_ids.
> 
> Since current users expect MAX_NUMNODES as the end-of-bitmap marker,
> retain this behaviour for now.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
> Changes since v1:
>  - updated and reflowed the 'borrowed' comment some more (rppt)

Hi Peter,

Thanks for the patch! I wanted to do it sooner or later.

Can you mention the commit that you used to borrow the approach.
Maybe suggested-by?

The motivation for the original patch was that the following test
revealed broken small_const_nbits() optimization for cpumasks:

  On Fri, Mar 3, 2023 at 12:39 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
  >
  > as an example here is a one-liner to show crappers which do 0-sized ops:
  > bpftrace -e 'kprobe:memset,kprobe:memcpy /arg2 == 0/ { @[probe,
  > kstack(2)] = count(); }'

See:
https://lore.kernel.org/lkml/CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com/

Can you make sure your patch doesn't brake the test for nodemasks?

>  include/linux/nodemask.h |  121 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 89 insertions(+), 32 deletions(-)
> 
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -99,6 +99,48 @@
>  typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
>  extern nodemask_t _unused_nodemask_arg_;
>  
> +#if MAX_NUMNODES > 1
> +extern unsigned int nr_node_ids;
> +#else
> +#define nr_node_ids		1U
> +#endif
> +
> +/*
> + * We have several different "preferred sizes" for the nodemask operations,
> + * depending on operation.
> + *
> + * For example, the bitmap scanning and operating operations have optimized
> + * routines that work for the single-word case, but only when the size is
> + * constant. So if MAX_NUMNODES fits in one single word, we are better off
> + * using that small constant, in order to trigger the optimized bit finding.
> + * That is 'small_nodemask_size'.
> + *
> + * The clearing and copying operations will similarly perform better with a

Copying will not, because there's no nodemask_copy(). :-)

> + * constant size, but we limit that size arbitrarily to four words. We call
> + * this 'large_nodemask_size'.
> + *
> + * Finally, some operations just want the exact limit, either because they set
> + * bits or just don't have any faster fixed-sized versions. We call this just
> + * 'nr_nodemask_bits'.
> + *
> + * Note that these optional constants are always guaranteed to be at least as
> + * big as 'nr_node_ids' itself is, and all our nodemask allocations are at
> + * least that size. The optimization comes from being able to potentially use
> + * a compile-time constant instead of a run-time generated exact number of
> + * nodes.
> + */
> +#if MAX_NUMNODES <= BITS_PER_LONG
> +  #define small_nodemask_bits ((unsigned int)MAX_NUMNODES)
> +  #define large_nodemask_bits ((unsigned int)MAX_NUMNODES)
> +#elif MAX_NUMNODES <= 4*BITS_PER_LONG
> +  #define small_nodemask_bits nr_node_ids
> +  #define large_nodemask_bits ((unsigned int)MAX_NUMNODES)
> +#else
> +  #define small_nodemask_bits nr_node_ids
> +  #define large_nodemask_bits nr_node_ids
> +#endif
> +#define nr_nodemask_bits nr_node_ids

We don't need nr_nodemask_bits. In CPU subsystem nr_cpumask_bits
exists (existed) to support dynamic allocation for cpumask_var_t
if CPUMASK_OFFSTACK is enabled. And it apparently caused troubles.

In nodemasks we don't have an offstack feature, and don't need the
nr_nodemask_bits. Just use nr_node_ids everywhere.

[...]

> -#define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
> +#define nodes_setall(dst) __nodes_setall(&(dst), large_nodemask_bits)
>  static inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
>  {
>  	bitmap_fill(dstp->bits, nbits);
>  }

When MAX_NUMNODES <= 4*BITS_PER_LONG, this breaks the rule that all
bits beyond nr_node_ids must be clear. And that in turn may brake
nodemask_weight() and others. Refer to this patch for details and
correct implementation:

63355b9884b ("cpumask: be more careful with 'cpumask_setall()'")

[...]

> @@ -452,7 +511,6 @@ static inline unsigned int next_memory_n
>  	return next_node(nid, node_states[N_MEMORY]);
>  }
>  
> -extern unsigned int nr_node_ids;
>  extern unsigned int nr_online_nodes;
>  
>  static inline void node_set_online(int nid)
> @@ -494,7 +552,6 @@ static inline int num_node_state(enum no
>  #define first_memory_node	0
>  #define next_online_node(nid)	(MAX_NUMNODES)
>  #define next_memory_node(nid)	(MAX_NUMNODES)
> -#define nr_node_ids		1U
>  #define nr_online_nodes		1U
 
I like how you separated the nr_node_ids from the other ifdefery, and
changed it to __ro_after_init. But I think it's better to fold this all
into the 1st patch.

Why don't we make nr_cpu_ids to be a __ro_after_init just as well?

Thanks,
Yury
