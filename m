Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC7F7DF696
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347622AbjKBPgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKBPga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:36:30 -0400
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E65F11B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:36:24 -0700 (PDT)
Message-ID: <4eb1d4cd-c327-4514-b709-b98dc9e6af3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698939382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xd5f/LwH7lzrxpiqhzHYsAN7wJYWEdJ8oVA1ZRW1SwE=;
        b=avck4VK3WPdgM9+jS7MVO8KCxbG0vp/uuRoX4jabxGGRJPjF1fW9Fiq2yWCIjVKkLI2/Ov
        Hh9nV2Zcqagzh6tB1RMhNXaQOOabxxtrnQmWKPzcmM/3J9LQ4bmGLqcYyeDqwBO+Yx+iLo
        SbzbKqpUnijUmuY+endvFfM+TZS6jIk=
Date:   Thu, 2 Nov 2023 08:36:16 -0700
MIME-Version: 1.0
Subject: Re: kernel/bpf/helpers.c:1905:19: warning: no previous declaration
 for 'bpf_percpu_obj_new_impl'
Content-Language: en-GB
To:     Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
References: <202311021613.I5dZri9c-lkp@intel.com> <ZUNmpE2OTpuKcxjW@rli9-mobl>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZUNmpE2OTpuKcxjW@rli9-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/2/23 2:06 AM, Philip Li wrote:
> On Thu, Nov 02, 2023 at 04:42:39PM +0800, kernel test robot wrote:
>> Hi Yonghong,
> Sorry, kindly ignore this report, it is similar one as https://lore.kernel.org/oe-kbuild-all/202309241550.JnHcYTZh-lkp@intel.com/,
> and we haven't fixed the bot side yet.

The fix is just pushed to the bpf tree.

https://lore.kernel.org/all/20231031215625.2343848-1-davemarchevsky@fb.com/


>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
>> commit: 36d8bdf75a93190e5669b9d1d95994e13e15ba1d bpf: Add alloc/xchg/direct_access support for local percpu kptr
>> date:   8 weeks ago
>> config: x86_64-buildonly-randconfig-006-20231102 (https://download.01.org/0day-ci/archive/20231102/202311021613.I5dZri9c-lkp@intel.com/config)
>> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021613.I5dZri9c-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202311021613.I5dZri9c-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>     kernel/bpf/helpers.c:1891:19: warning: no previous declaration for 'bpf_obj_new_impl' [-Wmissing-declarations]
>>      __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>>                        ^~~~~~~~~~~~~~~~
>>>> kernel/bpf/helpers.c:1905:19: warning: no previous declaration for 'bpf_percpu_obj_new_impl' [-Wmissing-declarations]
>>      __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>>                        ^~~~~~~~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:1933:18: warning: no previous declaration for 'bpf_obj_drop_impl' [-Wmissing-declarations]
>>      __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
>>                       ^~~~~~~~~~~~~~~~~
>>>> kernel/bpf/helpers.c:1941:18: warning: no previous declaration for 'bpf_percpu_obj_drop_impl' [-Wmissing-declarations]
>>      __bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
>>                       ^~~~~~~~~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:1947:19: warning: no previous declaration for 'bpf_refcount_acquire_impl' [-Wmissing-declarations]
>>      __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
>>                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:1992:17: warning: no previous declaration for 'bpf_list_push_front_impl' [-Wmissing-declarations]
>>      __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
>>                      ^~~~~~~~~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2002:17: warning: no previous declaration for 'bpf_list_push_back_impl' [-Wmissing-declarations]
>>      __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>>                      ^~~~~~~~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2035:35: warning: no previous declaration for 'bpf_list_pop_front' [-Wmissing-declarations]
>>      __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
>>                                        ^~~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2040:35: warning: no previous declaration for 'bpf_list_pop_back' [-Wmissing-declarations]
>>      __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
>>                                        ^~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2045:33: warning: no previous declaration for 'bpf_rbtree_remove' [-Wmissing-declarations]
>>      __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
>>                                      ^~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2101:17: warning: no previous declaration for 'bpf_rbtree_add_impl' [-Wmissing-declarations]
>>      __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
>>                      ^~~~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2111:33: warning: no previous declaration for 'bpf_rbtree_first' [-Wmissing-declarations]
>>      __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
>>                                      ^~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2124:33: warning: no previous declaration for 'bpf_task_acquire' [-Wmissing-declarations]
>>      __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
>>                                      ^~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2135:18: warning: no previous declaration for 'bpf_task_release' [-Wmissing-declarations]
>>      __bpf_kfunc void bpf_task_release(struct task_struct *p)
>>                       ^~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2224:33: warning: no previous declaration for 'bpf_task_from_pid' [-Wmissing-declarations]
>>      __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
>>                                      ^~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2265:19: warning: no previous declaration for 'bpf_dynptr_slice' [-Wmissing-declarations]
>>      __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
>>                        ^~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2349:19: warning: no previous declaration for 'bpf_dynptr_slice_rdwr' [-Wmissing-declarations]
>>      __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
>>                        ^~~~~~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2380:17: warning: no previous declaration for 'bpf_dynptr_adjust' [-Wmissing-declarations]
>>      __bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end)
>>                      ^~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2398:18: warning: no previous declaration for 'bpf_dynptr_is_null' [-Wmissing-declarations]
>>      __bpf_kfunc bool bpf_dynptr_is_null(struct bpf_dynptr_kern *ptr)
>>                       ^~~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2403:18: warning: no previous declaration for 'bpf_dynptr_is_rdonly' [-Wmissing-declarations]
>>      __bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
>>                       ^~~~~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2411:19: warning: no previous declaration for 'bpf_dynptr_size' [-Wmissing-declarations]
>>      __bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
>>                        ^~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2419:17: warning: no previous declaration for 'bpf_dynptr_clone' [-Wmissing-declarations]
>>      __bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
>>                      ^~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2432:19: warning: no previous declaration for 'bpf_cast_to_kern_ctx' [-Wmissing-declarations]
>>      __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>>                        ^~~~~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2437:19: warning: no previous declaration for 'bpf_rdonly_cast' [-Wmissing-declarations]
>>      __bpf_kfunc void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
>>                        ^~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2442:18: warning: no previous declaration for 'bpf_rcu_read_lock' [-Wmissing-declarations]
>>      __bpf_kfunc void bpf_rcu_read_lock(void)
>>                       ^~~~~~~~~~~~~~~~~
>>     kernel/bpf/helpers.c:2447:18: warning: no previous declaration for 'bpf_rcu_read_unlock' [-Wmissing-declarations]
>>      __bpf_kfunc void bpf_rcu_read_unlock(void)
>>                       ^~~~~~~~~~~~~~~~~~~
>>
>>
>> vim +/bpf_percpu_obj_new_impl +1905 kernel/bpf/helpers.c
>>
>>    1904	
>>> 1905	__bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>>    1906	{
>>    1907		u64 size = local_type_id__k;
>>    1908	
>>    1909		/* The verifier has ensured that meta__ign must be NULL */
>>    1910		return bpf_mem_alloc(&bpf_global_percpu_ma, size);
>>    1911	}
>>    1912	
>>    1913	/* Must be called under migrate_disable(), as required by bpf_mem_free */
>>    1914	void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
>>    1915	{
>>    1916		if (rec && rec->refcount_off >= 0 &&
>>    1917		    !refcount_dec_and_test((refcount_t *)(p + rec->refcount_off))) {
>>    1918			/* Object is refcounted and refcount_dec didn't result in 0
>>    1919			 * refcount. Return without freeing the object
>>    1920			 */
>>    1921			return;
>>    1922		}
>>    1923	
>>    1924		if (rec)
>>    1925			bpf_obj_free_fields(rec, p);
>>    1926	
>>    1927		if (rec && rec->refcount_off >= 0)
>>    1928			bpf_mem_free_rcu(&bpf_global_ma, p);
>>    1929		else
>>    1930			bpf_mem_free(&bpf_global_ma, p);
>>    1931	}
>>    1932	
>>    1933	__bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
>>    1934	{
>>    1935		struct btf_struct_meta *meta = meta__ign;
>>    1936		void *p = p__alloc;
>>    1937	
>>    1938		__bpf_obj_drop_impl(p, meta ? meta->record : NULL);
>>    1939	}
>>    1940	
>>> 1941	__bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
>>    1942	{
>>    1943		/* The verifier has ensured that meta__ign must be NULL */
>>    1944		bpf_mem_free_rcu(&bpf_global_percpu_ma, p__alloc);
>>    1945	}
>>    1946	
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>>
