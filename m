Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD37A764517
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjG0Ev2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjG0EvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:51:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169042116
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:51:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fdfd4c749dso239665e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690433480; x=1691038280;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1Ute6iBbqVT/NSgBzzkRk5skKEfY8jIz6YuSiDKH5I=;
        b=MNeYcNehmGJA2SDH2q6aPO5seBoH5Jy4Zl4tk7g82zXZ2TARjwNJouyUFTqkFCuTci
         urLJFj/1vw/iAH6Ab0kqyVz4d+Wc2cpVxtdiQuhR6IvCaKxzunYnMfXuKP/9sTKfk6sQ
         jq8BrNapmxySwt/3aOfN4bH8ofEctQp+km68uMfhSEVOu+/4WbO72z0Qe3HD3KeOFrHp
         L5cjgb/atVi80+itYQo6Oe96vhg141pnT+QjXDEJgg+iBO+l46Wf6P4jgGJy0rN/izcM
         1SBJbW2JB/GUr+ahKkAG3vhkZEQVgzfR69jBLcg1GLmM8Dqnmu7qoXQNnLm3FYve4OwD
         WEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690433480; x=1691038280;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Ute6iBbqVT/NSgBzzkRk5skKEfY8jIz6YuSiDKH5I=;
        b=AKE1KWzkN0xt7tzRDW18BR7BtqiR0CtqxXC2mUHxAOaRiWG49RO0Kkgbqya9gM50PK
         C/c/Zt6ApQ2JUxmxWm2h65R6aY3QCqD/WlzZPqIDgra8z/x6YU8L2Ac6th8m35hoXiQi
         TnL+CAL/2xgJHIbNZY8I6SEHUvANv8XNCcC1XLEnXiPnTcRv86GH8oBU2maimM2D3jaT
         usZ0gEmd16jDXlEw6fac3u3nvuq+fHqaVF8T2MgJ1w7/5CNCK/QXI08xrzYRLAAK4fWo
         8GroMxxzQ5NzFBg941ShjoE/z2TKJbPxQ/pCx9/5AzfjztcrSgPYzDUEgV0jZJTgrL8g
         1L6w==
X-Gm-Message-State: ABy/qLaSSpJoP7GVS8pGAKQR9NnASgzqt9dWBSDig/Vqdiltme28Es8n
        sZWBO4o8Co15qjGdsYldwKRWhA==
X-Google-Smtp-Source: APBJJlHd8QwKGB4kXOLDOoZOa5Og9OXxJUfDYAG5FBHaYIcg5xig7rziVSHOJK+b0y0M9dfDSdJ5Uw==
X-Received: by 2002:adf:ecc5:0:b0:317:6efd:3a6b with SMTP id s5-20020adfecc5000000b003176efd3a6bmr571635wro.24.1690433480188;
        Wed, 26 Jul 2023 21:51:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b003fb225d414fsm3556541wmk.21.2023.07.26.21.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 21:51:19 -0700 (PDT)
Date:   Thu, 27 Jul 2023 07:51:16 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Marco Elver <elver@google.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: mm/kfence/kfence_test.c:287 test_alloc() warn: use 'gfp' here
 instead of GFP_KERNEL?
Message-ID: <9e72b7ea-9598-415d-bc55-f2f42b7fcb3b@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18b44bc5a67275641fb26f2c54ba7eef80ac5950
commit: adf8e96a7ea670d45b5de7594acc67e8f4787ae6 parisc: Enable LOCKDEP support
config: parisc-randconfig-m041-20230726 (https://download.01.org/0day-ci/archive/20230727/202307270305.L19EfaJD-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307270305.L19EfaJD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202307270305.L19EfaJD-lkp@intel.com/

smatch warnings:
mm/kfence/kfence_test.c:287 test_alloc() warn: use 'gfp' here instead of GFP_KERNEL?

(Just included these for the LOLs)
mm/kfence/kfence_test.c:395 test_double_free() error: double free of 'expect.addr'
mm/kfence/kfence_test.c:671 test_memcache_typesafe_by_rcu() error: dereferencing freed memory 'expect.addr'

vim +/gfp +287 mm/kfence/kfence_test.c

bc8fbc5f305aec Marco Elver     2021-02-25  243  static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocation_policy policy)
bc8fbc5f305aec Marco Elver     2021-02-25  244  {
bc8fbc5f305aec Marco Elver     2021-02-25  245  	void *alloc;
bc8fbc5f305aec Marco Elver     2021-02-25  246  	unsigned long timeout, resched_after;
bc8fbc5f305aec Marco Elver     2021-02-25  247  	const char *policy_name;
bc8fbc5f305aec Marco Elver     2021-02-25  248  
bc8fbc5f305aec Marco Elver     2021-02-25  249  	switch (policy) {
bc8fbc5f305aec Marco Elver     2021-02-25  250  	case ALLOCATE_ANY:
bc8fbc5f305aec Marco Elver     2021-02-25  251  		policy_name = "any";
bc8fbc5f305aec Marco Elver     2021-02-25  252  		break;
bc8fbc5f305aec Marco Elver     2021-02-25  253  	case ALLOCATE_LEFT:
bc8fbc5f305aec Marco Elver     2021-02-25  254  		policy_name = "left";
bc8fbc5f305aec Marco Elver     2021-02-25  255  		break;
bc8fbc5f305aec Marco Elver     2021-02-25  256  	case ALLOCATE_RIGHT:
bc8fbc5f305aec Marco Elver     2021-02-25  257  		policy_name = "right";
bc8fbc5f305aec Marco Elver     2021-02-25  258  		break;
bc8fbc5f305aec Marco Elver     2021-02-25  259  	case ALLOCATE_NONE:
bc8fbc5f305aec Marco Elver     2021-02-25  260  		policy_name = "none";
bc8fbc5f305aec Marco Elver     2021-02-25  261  		break;
bc8fbc5f305aec Marco Elver     2021-02-25  262  	}
bc8fbc5f305aec Marco Elver     2021-02-25  263  
bc8fbc5f305aec Marco Elver     2021-02-25  264  	kunit_info(test, "%s: size=%zu, gfp=%x, policy=%s, cache=%i\n", __func__, size, gfp,
bc8fbc5f305aec Marco Elver     2021-02-25  265  		   policy_name, !!test_cache);
bc8fbc5f305aec Marco Elver     2021-02-25  266  
bc8fbc5f305aec Marco Elver     2021-02-25  267  	/*
bc8fbc5f305aec Marco Elver     2021-02-25  268  	 * 100x the sample interval should be more than enough to ensure we get
bc8fbc5f305aec Marco Elver     2021-02-25  269  	 * a KFENCE allocation eventually.
bc8fbc5f305aec Marco Elver     2021-02-25  270  	 */
8913c610014823 Peng Liu        2022-02-11  271  	timeout = jiffies + msecs_to_jiffies(100 * kfence_sample_interval);
bc8fbc5f305aec Marco Elver     2021-02-25  272  	/*
bc8fbc5f305aec Marco Elver     2021-02-25  273  	 * Especially for non-preemption kernels, ensure the allocation-gate
bc8fbc5f305aec Marco Elver     2021-02-25  274  	 * timer can catch up: after @resched_after, every failed allocation
bc8fbc5f305aec Marco Elver     2021-02-25  275  	 * attempt yields, to ensure the allocation-gate timer is scheduled.
bc8fbc5f305aec Marco Elver     2021-02-25  276  	 */
8913c610014823 Peng Liu        2022-02-11  277  	resched_after = jiffies + msecs_to_jiffies(kfence_sample_interval);
bc8fbc5f305aec Marco Elver     2021-02-25  278  	do {
bc8fbc5f305aec Marco Elver     2021-02-25  279  		if (test_cache)
bc8fbc5f305aec Marco Elver     2021-02-25  280  			alloc = kmem_cache_alloc(test_cache, gfp);
bc8fbc5f305aec Marco Elver     2021-02-25  281  		else
bc8fbc5f305aec Marco Elver     2021-02-25  282  			alloc = kmalloc(size, gfp);
                                                                                              ^^^

bc8fbc5f305aec Marco Elver     2021-02-25  283  
bc8fbc5f305aec Marco Elver     2021-02-25  284  		if (is_kfence_address(alloc)) {
8dae0cfed57357 Vlastimil Babka 2021-11-03  285  			struct slab *slab = virt_to_slab(alloc);
588c7fa022d7b2 Hyeonggon Yoo   2021-06-28  286  			struct kmem_cache *s = test_cache ?:
588c7fa022d7b2 Hyeonggon Yoo   2021-06-28 @287  					kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)];
                                                                                                                    ^^^^^^^^^^
I feel like using gfp might be correct but I'm not sure?  This code
is from prior to this commit.  Let's add Marco to the CC.

bc8fbc5f305aec Marco Elver     2021-02-25  288  
bc8fbc5f305aec Marco Elver     2021-02-25  289  			/*
bc8fbc5f305aec Marco Elver     2021-02-25  290  			 * Verify that various helpers return the right values
bc8fbc5f305aec Marco Elver     2021-02-25  291  			 * even for KFENCE objects; these are required so that
bc8fbc5f305aec Marco Elver     2021-02-25  292  			 * memcg accounting works correctly.
bc8fbc5f305aec Marco Elver     2021-02-25  293  			 */
8dae0cfed57357 Vlastimil Babka 2021-11-03  294  			KUNIT_EXPECT_EQ(test, obj_to_index(s, slab, alloc), 0U);
8dae0cfed57357 Vlastimil Babka 2021-11-03  295  			KUNIT_EXPECT_EQ(test, objs_per_slab(s, slab), 1);
bc8fbc5f305aec Marco Elver     2021-02-25  296  
bc8fbc5f305aec Marco Elver     2021-02-25  297  			if (policy == ALLOCATE_ANY)
bc8fbc5f305aec Marco Elver     2021-02-25  298  				return alloc;
f403f22f8ccb12 Kefeng Wang     2022-05-20  299  			if (policy == ALLOCATE_LEFT && PAGE_ALIGNED(alloc))
bc8fbc5f305aec Marco Elver     2021-02-25  300  				return alloc;
f403f22f8ccb12 Kefeng Wang     2022-05-20  301  			if (policy == ALLOCATE_RIGHT && !PAGE_ALIGNED(alloc))
bc8fbc5f305aec Marco Elver     2021-02-25  302  				return alloc;
bc8fbc5f305aec Marco Elver     2021-02-25  303  		} else if (policy == ALLOCATE_NONE)
bc8fbc5f305aec Marco Elver     2021-02-25  304  			return alloc;
bc8fbc5f305aec Marco Elver     2021-02-25  305  
bc8fbc5f305aec Marco Elver     2021-02-25  306  		test_free(alloc);
bc8fbc5f305aec Marco Elver     2021-02-25  307  
bc8fbc5f305aec Marco Elver     2021-02-25  308  		if (time_after(jiffies, resched_after))
bc8fbc5f305aec Marco Elver     2021-02-25  309  			cond_resched();
bc8fbc5f305aec Marco Elver     2021-02-25  310  	} while (time_before(jiffies, timeout));
bc8fbc5f305aec Marco Elver     2021-02-25  311  
bc8fbc5f305aec Marco Elver     2021-02-25  312  	KUNIT_ASSERT_TRUE_MSG(test, false, "failed to allocate from KFENCE");
bc8fbc5f305aec Marco Elver     2021-02-25  313  	return NULL; /* Unreachable. */
bc8fbc5f305aec Marco Elver     2021-02-25  314  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

