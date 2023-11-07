Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB07E346F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjKGENN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:13:03 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59843ED
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 20:13:00 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9d267605ceeso773334166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 20:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699330379; x=1699935179; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeE66KaENA4L5aP9jLk1oNB7zVNeskbpx3MnAnk/aFQ=;
        b=iul0McFf1J5VlEqdZRYohbwDWZZHNIRj2DBkpUXWB4IchxxymEv9FcZ67Zz0pUbHfb
         VbF5aSKx4lEThoTNX0JwQLMg772Y0isFF6JILOva92pZHfXkRH+ArxylpCS+5y+ob5GQ
         HaZWnkAXNmAX5TJmvsPBSIqQY66y9ClaaNcStZvw08E8UbZ2X8DuNKERGPLxmoNZ4GEn
         rQilT2pZSj+UyzIHd9ess+fUTJDEm7RbvI3jnZg8aO3JcAijKJj/9D0vD00rupsoJE1A
         plA63d9uvi5gNbkTtOdTG51v+A0EbxE3rSs9Yph/EgR7/VjMVLPGpgvEgola5DELDmgt
         3akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699330379; x=1699935179;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeE66KaENA4L5aP9jLk1oNB7zVNeskbpx3MnAnk/aFQ=;
        b=WTmZDuGvlnyyJW/kLFtJ3Gm13L/JM/3EVoOlmF8fBjqYz8npgzO/kt82tmxrZOqR8P
         BujHl3WtC5F2dUHWAWZrKiNYWW2XoA3hVab5gg43x51+CyQd4k1CjO1adodBeuHcX278
         F2xPfxH79ICeMTEiH14YKzKRRmSJyYEO5r9EfwmLmpRMHVgmwIIOcTqJtez3HnkHQXK+
         0Ga48BTQBa5bCYwAxZjcGfeC5tWqVz4N1KsCgOXHmlj/Vhg0ePHocbqdgPLr9VC7K4+7
         eHctFGoo8WxUShb9VQPVuXJ14dMMzPTTXoY+v1QQ0sublxdUsISPlvutDX3MlxFP58pp
         gYEw==
X-Gm-Message-State: AOJu0Yw9KchRLIfJeAgP747MoJxGqB/2IiAZIYhDhJuyXGb5k9YI3KOb
        ly9wnuFL54G/SV/INPXstbDWIA==
X-Google-Smtp-Source: AGHT+IHz/cQgmYb+/jcOoaJNIHYKNiETegjHqBZhBvzCYxqsvvt9qI6Qn9IXF/o3RTjqUvGLuczBhw==
X-Received: by 2002:a17:907:36c5:b0:9d2:bf19:88aa with SMTP id bj5-20020a17090736c500b009d2bf1988aamr15395586ejc.59.1699330378771;
        Mon, 06 Nov 2023 20:12:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ox11-20020a170907100b00b009dd949b75c7sm551938ejb.151.2023.11.06.20.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 20:12:58 -0800 (PST)
Date:   Tue, 7 Nov 2023 07:12:55 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Kent Overstreet <kmo@daterainc.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: fs/bcachefs/six.c:283 __do_six_trylock() error: uninitialized symbol
 'old'.
Message-ID: <6dda193d-53e3-44e3-8d3c-734ab8b50869@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: b60c8e9e7b082abac290ebdb9166b806e7d83fb7 six locks: lock->state.seq no longer used for write lock held
config: x86_64-randconfig-161-20231102 (https://download.01.org/0day-ci/archive/20231106/202311062227.0GUulHgD-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20231106/202311062227.0GUulHgD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202311062227.0GUulHgD-lkp@intel.com/

New smatch warnings:
fs/bcachefs/six.c:283 __do_six_trylock() error: uninitialized symbol 'old'.

vim +/old +283 fs/bcachefs/six.c

91d16f16d0fd4b Kent Overstreet 2023-05-21  199  static int __do_six_trylock(struct six_lock *lock, enum six_lock_type type,
91d16f16d0fd4b Kent Overstreet 2023-05-21  200  			    struct task_struct *task, bool try)
1c6fdbd8f2465d Kent Overstreet 2017-03-16  201  {
1c6fdbd8f2465d Kent Overstreet 2017-03-16  202  	const struct six_lock_vals l[] = LOCK_VALS;
84a37cbf62e044 Kent Overstreet 2022-08-26  203  	int ret;
1fb4fe63178881 Kent Overstreet 2023-05-20  204  	u64 old, new, v;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  205  
84a37cbf62e044 Kent Overstreet 2022-08-26  206  	EBUG_ON(type == SIX_LOCK_write && lock->owner != task);
1fb4fe63178881 Kent Overstreet 2023-05-20  207  	EBUG_ON(type == SIX_LOCK_write &&
b60c8e9e7b082a Kent Overstreet 2023-06-16  208  		(try != !(atomic64_read(&lock->state) & SIX_LOCK_HELD_write)));
1fb4fe63178881 Kent Overstreet 2023-05-20  209  	EBUG_ON(type == SIX_LOCK_write &&
b60c8e9e7b082a Kent Overstreet 2023-06-16  210  		(try != !(atomic64_read(&lock->state) & SIX_STATE_WRITE_LOCK)));
1c6fdbd8f2465d Kent Overstreet 2017-03-16  211  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  212  	/*
1c6fdbd8f2465d Kent Overstreet 2017-03-16  213  	 * Percpu reader mode:
1c6fdbd8f2465d Kent Overstreet 2017-03-16  214  	 *
1c6fdbd8f2465d Kent Overstreet 2017-03-16  215  	 * The basic idea behind this algorithm is that you can implement a lock
1c6fdbd8f2465d Kent Overstreet 2017-03-16  216  	 * between two threads without any atomics, just memory barriers:
1c6fdbd8f2465d Kent Overstreet 2017-03-16  217  	 *
1c6fdbd8f2465d Kent Overstreet 2017-03-16  218  	 * For two threads you'll need two variables, one variable for "thread a
1c6fdbd8f2465d Kent Overstreet 2017-03-16  219  	 * has the lock" and another for "thread b has the lock".
1c6fdbd8f2465d Kent Overstreet 2017-03-16  220  	 *
1c6fdbd8f2465d Kent Overstreet 2017-03-16  221  	 * To take the lock, a thread sets its variable indicating that it holds
1c6fdbd8f2465d Kent Overstreet 2017-03-16  222  	 * the lock, then issues a full memory barrier, then reads from the
1c6fdbd8f2465d Kent Overstreet 2017-03-16  223  	 * other thread's variable to check if the other thread thinks it has
1c6fdbd8f2465d Kent Overstreet 2017-03-16  224  	 * the lock. If we raced, we backoff and retry/sleep.
37f612bea5bd92 Kent Overstreet 2023-05-21  225  	 *
37f612bea5bd92 Kent Overstreet 2023-05-21  226  	 * Failure to take the lock may cause a spurious trylock failure in
37f612bea5bd92 Kent Overstreet 2023-05-21  227  	 * another thread, because we temporarily set the lock to indicate that
37f612bea5bd92 Kent Overstreet 2023-05-21  228  	 * we held it. This would be a problem for a thread in six_lock(), when
37f612bea5bd92 Kent Overstreet 2023-05-21  229  	 * they are calling trylock after adding themself to the waitlist and
37f612bea5bd92 Kent Overstreet 2023-05-21  230  	 * prior to sleeping.
37f612bea5bd92 Kent Overstreet 2023-05-21  231  	 *
37f612bea5bd92 Kent Overstreet 2023-05-21  232  	 * Therefore, if we fail to get the lock, and there were waiters of the
37f612bea5bd92 Kent Overstreet 2023-05-21  233  	 * type we conflict with, we will have to issue a wakeup.
37f612bea5bd92 Kent Overstreet 2023-05-21  234  	 *
37f612bea5bd92 Kent Overstreet 2023-05-21  235  	 * Since we may be called under wait_lock (and by the wakeup code
37f612bea5bd92 Kent Overstreet 2023-05-21  236  	 * itself), we return that the wakeup has to be done instead of doing it
37f612bea5bd92 Kent Overstreet 2023-05-21  237  	 * here.
1c6fdbd8f2465d Kent Overstreet 2017-03-16  238  	 */
1c6fdbd8f2465d Kent Overstreet 2017-03-16  239  	if (type == SIX_LOCK_read && lock->readers) {
1c6fdbd8f2465d Kent Overstreet 2017-03-16  240  		preempt_disable();
1c6fdbd8f2465d Kent Overstreet 2017-03-16  241  		this_cpu_inc(*lock->readers); /* signal that we own lock */
1c6fdbd8f2465d Kent Overstreet 2017-03-16  242  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  243  		smp_mb();
1c6fdbd8f2465d Kent Overstreet 2017-03-16  244  
1fb4fe63178881 Kent Overstreet 2023-05-20  245  		old = atomic64_read(&lock->state);
1fb4fe63178881 Kent Overstreet 2023-05-20  246  		ret = !(old & l[type].lock_fail);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  247  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  248  		this_cpu_sub(*lock->readers, !ret);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  249  		preempt_enable();
1c6fdbd8f2465d Kent Overstreet 2017-03-16  250  
37f612bea5bd92 Kent Overstreet 2023-05-21  251  		if (!ret && (old & SIX_STATE_WAITING_WRITE))
84a37cbf62e044 Kent Overstreet 2022-08-26  252  			ret = -1 - SIX_LOCK_write;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  253  	} else if (type == SIX_LOCK_write && lock->readers) {
1c6fdbd8f2465d Kent Overstreet 2017-03-16  254  		if (try) {
b60c8e9e7b082a Kent Overstreet 2023-06-16  255  			atomic64_add(SIX_STATE_WRITE_LOCK, &lock->state);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  256  			smp_mb__after_atomic();
1c6fdbd8f2465d Kent Overstreet 2017-03-16  257  		}
1c6fdbd8f2465d Kent Overstreet 2017-03-16  258  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  259  		ret = !pcpu_read_count(lock);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  260  
b60c8e9e7b082a Kent Overstreet 2023-06-16  261  		if (try && !ret) {
b60c8e9e7b082a Kent Overstreet 2023-06-16  262  			old = atomic64_sub_return(SIX_STATE_WRITE_LOCK, &lock->state);

old only set when ret is zero

b60c8e9e7b082a Kent Overstreet 2023-06-16  263  			if (old & SIX_STATE_WAITING_READ)
84a37cbf62e044 Kent Overstreet 2022-08-26  264  				ret = -1 - SIX_LOCK_read;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  265  		}
1c6fdbd8f2465d Kent Overstreet 2017-03-16  266  	} else {
1fb4fe63178881 Kent Overstreet 2023-05-20  267  		v = atomic64_read(&lock->state);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  268  		do {
1fb4fe63178881 Kent Overstreet 2023-05-20  269  			new = old = v;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  270  
b60c8e9e7b082a Kent Overstreet 2023-06-16  271  			ret = !(old & l[type].lock_fail);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  272  
b60c8e9e7b082a Kent Overstreet 2023-06-16  273  			if (!ret || (type == SIX_LOCK_write && !try))
d2c86b77de5894 Kent Overstreet 2023-05-20  274  				break;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  275  
b60c8e9e7b082a Kent Overstreet 2023-06-16  276  			new += l[type].lock_val;
b60c8e9e7b082a Kent Overstreet 2023-06-16  277  		} while ((v = atomic64_cmpxchg_acquire(&lock->state, old, new)) != old);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  278  
1fb4fe63178881 Kent Overstreet 2023-05-20  279  		EBUG_ON(ret && !(atomic64_read(&lock->state) & l[type].held_mask));
1c6fdbd8f2465d Kent Overstreet 2017-03-16  280  	}
1c6fdbd8f2465d Kent Overstreet 2017-03-16  281  
84a37cbf62e044 Kent Overstreet 2022-08-26  282  	if (ret > 0)
84a37cbf62e044 Kent Overstreet 2022-08-26 @283  		six_set_owner(lock, type, old, task);
                                                                                          ^^^
We're allowed to pass uninitialized data here because it's not used and
it's an inline function.  But the compiler is going to zero it anyway.
Just zero it and make the checker happy.

1c6fdbd8f2465d Kent Overstreet 2017-03-16  284  
b60c8e9e7b082a Kent Overstreet 2023-06-16  285  	EBUG_ON(type == SIX_LOCK_write && try && ret <= 0 &&
b60c8e9e7b082a Kent Overstreet 2023-06-16  286  		(atomic64_read(&lock->state) & SIX_STATE_WRITE_LOCK));
1c6fdbd8f2465d Kent Overstreet 2017-03-16  287  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  288  	return ret;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  289  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

