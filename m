Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1087D9719
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjJ0MAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0MAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:00:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00AC4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:00:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so16223855e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698408004; x=1699012804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a9cIfPve8bX3kbsNYr25FMmZBwtdZULnf7hv7IF5bwo=;
        b=p1BKzR8mJQEOq8Egt6DZfZq3luxSaGLsbm4gpLrvHdYLmsSTX7Qoee/4uc2lIXsy1g
         Leg7JDKiz9V2gkeMrlRnePozZPz4w65PrQEyQNuX2jpxHEKc9JKSM9SSQatPJbMraMJR
         JBlwSXLel4ZzIY6o/Va9JP2OvNvr+BKdqfTUqWky08sCweeqoI55VBTlNiSxYlXiltRz
         YGTw/ddj/sNjCzZErbngpVrlwnF+h3ZNr1mbi54WfbATCP292RaB6KQv6j2FuBz/K9o4
         7FviHFLZSOCB4HoMd0hbA7iEA8VsSbjw/MvoqGIMEHpIqKhCtKwtchgqC7ipAWAnmX/M
         YAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698408004; x=1699012804;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9cIfPve8bX3kbsNYr25FMmZBwtdZULnf7hv7IF5bwo=;
        b=SZiTjvkT9e0pLFg+au2X1nuTz+ibMQLV8Twsn6wpuY/jiUYt8oYDvcJBjN6HxBuhVU
         gt2X/QN/wGdIaM6rqN8d5xFkjJ7xG4WK0A5gCWBynWaTM/5v1Q/NEKtVQzu3drCRCKid
         NmBRE9A/KAdii2nxtYBhDne3zsBU3ZYdd0Aov5g+mgXmEb7OyhKJNpikYfqaZVqEraTQ
         O2DEscqHBX61+XNT067U2jChmMA7HCZTB2euENlmELjLE8Yj8+9yArpvN7D72HkB4f/u
         nYyPcYO+8orUPysSs2gZjLblmNv93PDiitJBnChYtPvK1dE17MCRsfDduJtTnmo99imn
         4rdw==
X-Gm-Message-State: AOJu0YwvFeIDQRU5rHpWXig2thrqHmlENnOWvVUBtff7UDQ6Fts6lxEI
        ZJkZ+7Q40Fm7Xnqmc0yWZgVBZg==
X-Google-Smtp-Source: AGHT+IHii6I8orNSOerYFraSp9Jk2OXuvfyPcTladSeEU8veRpMNThCbiQQ9asQw1PQJjTZHE7JKuA==
X-Received: by 2002:a05:600c:4708:b0:405:40c6:2b96 with SMTP id v8-20020a05600c470800b0040540c62b96mr1988384wmo.3.1698408003855;
        Fri, 27 Oct 2023 05:00:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c431500b003fe61c33df5sm4882107wme.3.2023.10.27.05.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:00:03 -0700 (PDT)
Date:   Fri, 27 Oct 2023 15:00:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Joey Jiao <quic_jiangenj@quicinc.com>,
        linux-modules@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        quic_jiangenj@quicinc.com, quic_likaid@quicinc.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] module: Add CONFIG_MODULE_DISABLE_INIT_FREE option
Message-ID: <b2b20956-d80e-462c-8261-a41802996197@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013062711.28852-1-quic_jiangenj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joey,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joey-Jiao/module-Add-CONFIG_MODULE_DISABLE_INIT_FREE-option/20231017-115509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
patch link:    https://lore.kernel.org/r/20231013062711.28852-1-quic_jiangenj%40quicinc.com
patch subject: [PATCH v5] module: Add CONFIG_MODULE_DISABLE_INIT_FREE option
config: x86_64-randconfig-161-20231026 (https://download.01.org/0day-ci/archive/20231027/202310271751.28pKVu4K-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231027/202310271751.28pKVu4K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310271751.28pKVu4K-lkp@intel.com/

smatch warnings:
kernel/module/main.c:2608 do_init_module() warn: possible memory leak of 'freeinit'

vim +/freeinit +2608 kernel/module/main.c

c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2517  
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2518  	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2519  	if (!freeinit) {
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2520  		ret = -ENOMEM;
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2521  		goto fail;
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2522  	}
ac3b4328392344 kernel/module/main.c Song Liu         2023-02-06  2523  	freeinit->init_text = mod->mem[MOD_INIT_TEXT].base;
ac3b4328392344 kernel/module/main.c Song Liu         2023-02-06  2524  	freeinit->init_data = mod->mem[MOD_INIT_DATA].base;
ac3b4328392344 kernel/module/main.c Song Liu         2023-02-06  2525  	freeinit->init_rodata = mod->mem[MOD_INIT_RODATA].base;
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2526  
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2527  	do_mod_ctors(mod);
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2528  	/* Start the module */
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2529  	if (mod->init != NULL)
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2530  		ret = do_one_initcall(mod->init);
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2531  	if (ret < 0) {
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2532  		goto fail_free_freeinit;
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2533  	}
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2534  	if (ret > 0) {
bddb12b32f90c5 kernel/module.c      Andrew Morton    2013-11-12  2535  		pr_warn("%s: '%s'->init suspiciously returned %d, it should "
bddb12b32f90c5 kernel/module.c      Andrew Morton    2013-11-12  2536  			"follow 0/-E convention\n"
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2537  			"%s: loading module anyway...\n",
bddb12b32f90c5 kernel/module.c      Andrew Morton    2013-11-12  2538  			__func__, mod->name, ret, __func__);
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2539  		dump_stack();
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2540  	}
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2541  
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2542  	/* Now it's a first class citizen! */
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2543  	mod->state = MODULE_STATE_LIVE;
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2544  	blocking_notifier_call_chain(&module_notify_list,
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2545  				     MODULE_STATE_LIVE, mod);
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2546  
38dc717e97153e kernel/module.c      Jessica Yu       2020-11-27  2547  	/* Delay uevent until module has finished its init routine */
38dc717e97153e kernel/module.c      Jessica Yu       2020-11-27  2548  	kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
38dc717e97153e kernel/module.c      Jessica Yu       2020-11-27  2549  
774a1221e862b3 kernel/module.c      Tejun Heo        2013-01-15  2550  	/*
774a1221e862b3 kernel/module.c      Tejun Heo        2013-01-15  2551  	 * We need to finish all async code before the module init sequence
67d6212afda218 kernel/module.c      Igor Pylypiv     2022-01-27  2552  	 * is done. This has potential to deadlock if synchronous module
67d6212afda218 kernel/module.c      Igor Pylypiv     2022-01-27  2553  	 * loading is requested from async (which is not allowed!).
774a1221e862b3 kernel/module.c      Tejun Heo        2013-01-15  2554  	 *
67d6212afda218 kernel/module.c      Igor Pylypiv     2022-01-27  2555  	 * See commit 0fdff3ec6d87 ("async, kmod: warn on synchronous
67d6212afda218 kernel/module.c      Igor Pylypiv     2022-01-27  2556  	 * request_module() from async workers") for more details.
774a1221e862b3 kernel/module.c      Tejun Heo        2013-01-15  2557  	 */
67d6212afda218 kernel/module.c      Igor Pylypiv     2022-01-27  2558  	if (!mod->async_probe_requested)
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2559  		async_synchronize_full();
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2560  
ac3b4328392344 kernel/module/main.c Song Liu         2023-02-06  2561  	ftrace_free_mem(mod, mod->mem[MOD_INIT_TEXT].base,
ac3b4328392344 kernel/module/main.c Song Liu         2023-02-06  2562  			mod->mem[MOD_INIT_TEXT].base + mod->mem[MOD_INIT_TEXT].size);
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2563  	mutex_lock(&module_mutex);
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2564  	/* Drop initial reference. */
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2565  	module_put(mod);
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2566  	trim_init_extable(mod);
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2567  #ifdef CONFIG_KALLSYMS
8244062ef1e545 kernel/module.c      Rusty Russell    2016-02-03  2568  	/* Switch to core kallsyms now init is done: kallsyms may be walking! */
8244062ef1e545 kernel/module.c      Rusty Russell    2016-02-03  2569  	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2570  #endif
444d13ff10fb13 kernel/module.c      Jessica Yu       2016-07-27  2571  	module_enable_ro(mod, true);
93c2e105f6bcee kernel/module.c      Peter Zijlstra   2015-05-27  2572  	mod_tree_remove_init(mod);
d453cded05ee21 kernel/module.c      Rusty Russell    2015-01-20  2573  	module_arch_freeing_init(mod);
ac3b4328392344 kernel/module/main.c Song Liu         2023-02-06  2574  	for_class_mod_mem_type(type, init) {
ac3b4328392344 kernel/module/main.c Song Liu         2023-02-06  2575  		mod->mem[type].base = NULL;
ac3b4328392344 kernel/module/main.c Song Liu         2023-02-06  2576  		mod->mem[type].size = 0;
ac3b4328392344 kernel/module/main.c Song Liu         2023-02-06  2577  	}
df3e764d8e5cd4 kernel/module/main.c Luis Chamberlain 2023-03-28  2578  
607c543f939d8c kernel/module.c      Andrii Nakryiko  2020-11-20  2579  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
607c543f939d8c kernel/module.c      Andrii Nakryiko  2020-11-20  2580  	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointer */
607c543f939d8c kernel/module.c      Andrii Nakryiko  2020-11-20  2581  	mod->btf_data = NULL;
607c543f939d8c kernel/module.c      Andrii Nakryiko  2020-11-20  2582  #endif
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2583  	/*
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2584  	 * We want to free module_init, but be aware that kallsyms may be
0be964be0d4508 kernel/module.c      Peter Zijlstra   2015-05-27  2585  	 * walking this with preempt disabled.  In all the failure paths, we
cb2f55369d3a9e kernel/module.c      Paul E. McKenney 2018-11-06  2586  	 * call synchronize_rcu(), but we don't want to slow down the success
1a7b7d9220819a kernel/module.c      Rick Edgecombe   2019-04-25  2587  	 * path. module_memfree() cannot be called in an interrupt, so do the
1a7b7d9220819a kernel/module.c      Rick Edgecombe   2019-04-25  2588  	 * work and call synchronize_rcu() in a work queue.
1a7b7d9220819a kernel/module.c      Rick Edgecombe   2019-04-25  2589  	 *
ae646f0b9ca135 kernel/module.c      Jeffrey Hugo     2018-05-11  2590  	 * Note that module_alloc() on most architectures creates W+X page
ae646f0b9ca135 kernel/module.c      Jeffrey Hugo     2018-05-11  2591  	 * mappings which won't be cleaned up until do_free_init() runs.  Any
ae646f0b9ca135 kernel/module.c      Jeffrey Hugo     2018-05-11  2592  	 * code such as mark_rodata_ro() which depends on those mappings to
ae646f0b9ca135 kernel/module.c      Jeffrey Hugo     2018-05-11  2593  	 * be cleaned up needs to sync with the queued work - ie
cb2f55369d3a9e kernel/module.c      Paul E. McKenney 2018-11-06  2594  	 * rcu_barrier()
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2595  	 */
36022a47582048 kernel/module/main.c Joey Jiao        2023-10-13  2596  	if (!IS_ENABLED(CONFIG_MODULE_DISABLE_INIT_FREE) &&
36022a47582048 kernel/module/main.c Joey Jiao        2023-10-13  2597  	    llist_add(&freeinit->node, &init_free_list))

Let's not allocate freeinit if CONFIG_MODULE_DISABLE_INIT_FREE is not
enabled.

1a7b7d9220819a kernel/module.c      Rick Edgecombe   2019-04-25  2598  		schedule_work(&init_free_wq);
1a7b7d9220819a kernel/module.c      Rick Edgecombe   2019-04-25  2599  
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2600  	mutex_unlock(&module_mutex);
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2601  	wake_up_all(&module_wq);
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2602  
df3e764d8e5cd4 kernel/module/main.c Luis Chamberlain 2023-03-28  2603  	mod_stat_add_long(text_size, &total_text_size);
df3e764d8e5cd4 kernel/module/main.c Luis Chamberlain 2023-03-28  2604  	mod_stat_add_long(total_size, &total_mod_size);
df3e764d8e5cd4 kernel/module/main.c Luis Chamberlain 2023-03-28  2605  
df3e764d8e5cd4 kernel/module/main.c Luis Chamberlain 2023-03-28  2606  	mod_stat_inc(&modcount);
df3e764d8e5cd4 kernel/module/main.c Luis Chamberlain 2023-03-28  2607  
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16 @2608  	return 0;
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2609  
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2610  fail_free_freeinit:
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2611  	kfree(freeinit);
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2612  fail:
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2613  	/* Try to protect us from buggy refcounters. */
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2614  	mod->state = MODULE_STATE_GOING;
cb2f55369d3a9e kernel/module.c      Paul E. McKenney 2018-11-06  2615  	synchronize_rcu();
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2616  	module_put(mod);
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2617  	blocking_notifier_call_chain(&module_notify_list,
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2618  				     MODULE_STATE_GOING, mod);
7e545d6eca20ce kernel/module.c      Jessica Yu       2016-03-16  2619  	klp_module_going(mod);
7dcd182bec271a kernel/module.c      Jessica Yu       2016-02-16  2620  	ftrace_release_mod(mod);
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2621  	free_module(mod);
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2622  	wake_up_all(&module_wq);
df3e764d8e5cd4 kernel/module/main.c Luis Chamberlain 2023-03-28  2623  
c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2624  	return ret;
34e1169d996ab1 kernel/module.c      Kees Cook        2012-10-16  2625  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

