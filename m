Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE23E7CC5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbjJQO0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjJQO0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:26:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF78AA2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:26:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4064867903cso63766825e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697552804; x=1698157604; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJE09Myjwgn14LfWOjq/jShnx1rrUt/BrGt0sKyb+3o=;
        b=IZbwcknaPTBUbnCTIzQXQEa5TFHyQZoZQQyjikG93jnQAlAruDS/IyH0RVTH30sZUO
         pxvaJY3MFmXgxSclGgDvrWV78G7qjtDi/njiFxvXv77XsDV7Ae9XYr1oNtBGNKRLU1ZY
         5uH8FCnlGAJM8UMzgg5Fi6TNZ+9odoqOhf2h2LUjviKd7tHQK/isNAsP3dpsT4w4ofU4
         Bv2drG+NzUaN+RRIvbYakoQx+pSuknpRjE0jz5Gt+FeFMNAbe93Zu50viiJRcrPhEQ8I
         AfaLpxQvsDk1GviEW29NeEN446T4zZLgqzZ0HsGNJb9u47lyR13GfSro4fh52zMrMCJv
         YUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697552804; x=1698157604;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJE09Myjwgn14LfWOjq/jShnx1rrUt/BrGt0sKyb+3o=;
        b=V+tW81FgWx7o2wjbVK730zNwSuqurGGEglb6DfZLb18zsnD0axmiNGAWgispCew4mS
         IQWS1yIiOZryZnh4mwmMjqqHaHKyhod56vxv5RoX4NyXI+MIWDZL0OhPOXIhwbn85/lO
         nYqBkWwgolU6ZGTKHAzFq2hQ4Laj0TZ3x+ndmEFzx1djh6h5mJ/LruO4hexihf4c+2bR
         pB8euoKdgEL4F4nxGl5GJdxGWu9kwDqRWDjNuBcGll+zh+6aCKxZzk9u1hkSQc0rNQ7F
         YRESk/pHHEjuKTpy5p/Gc367ZK7c+8SVZCleyaj9pLcYPlO3bxoZNQXVVqC3Kmw1nQ+k
         EjVw==
X-Gm-Message-State: AOJu0YyEtsTPvkd7DKoMaZ4fpNP40sACHVXmP9MZywnQB7627LTRO0XK
        Om+wyenQmRHwH2U2t/Sn/wH9Wg==
X-Google-Smtp-Source: AGHT+IF0GLdjOsGO/vLeu8WUMiLKOKj5CwsCC7dwSj2juz49+jxE5vpaDAlhZS+tkZmC1sBDsI939g==
X-Received: by 2002:a05:600c:4ec7:b0:408:3963:5be7 with SMTP id g7-20020a05600c4ec700b0040839635be7mr2119wmq.29.1697552804118;
        Tue, 17 Oct 2023 07:26:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c488600b00405ee9dc69esm9834754wmp.18.2023.10.17.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:26:43 -0700 (PDT)
Date:   Tue, 17 Oct 2023 17:26:40 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Baoquan He <bhe@redhat.com>
Subject: mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm'
 could be null (see line 3667)
Message-ID: <f82be227-bfde-439a-b339-1b4ee370d59a@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
commit: 4c91c07c93bbbdd7f2d9de2beb7ee5c2a48ad8e7 mm: vmalloc: convert vread() to vread_iter()
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310171600.WCrsOwFj-lkp@intel.com/

smatch warnings:
mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm' could be null (see line 3667)

vim +/vm +3689 mm/vmalloc.c

4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3619  long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
^1da177e4c3f41 Linus Torvalds          2005-04-16  3620  {
e81ce85f960c2e Joonsoo Kim             2013-04-29  3621  	struct vmap_area *va;
e81ce85f960c2e Joonsoo Kim             2013-04-29  3622  	struct vm_struct *vm;
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3623  	char *vaddr;
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3624  	size_t n, size, flags, remains;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3625  
4aff1dc4fb3a5a Andrey Konovalov        2022-03-24  3626  	addr = kasan_reset_tag(addr);
4aff1dc4fb3a5a Andrey Konovalov        2022-03-24  3627  
^1da177e4c3f41 Linus Torvalds          2005-04-16  3628  	/* Don't allow overflow */
^1da177e4c3f41 Linus Torvalds          2005-04-16  3629  	if ((unsigned long) addr + count < count)
^1da177e4c3f41 Linus Torvalds          2005-04-16  3630  		count = -(unsigned long) addr;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3631  
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3632  	remains = count;
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3633  
e81ce85f960c2e Joonsoo Kim             2013-04-29  3634  	spin_lock(&vmap_area_lock);
f181234a5a21fd Chen Wandun             2021-09-02  3635  	va = find_vmap_area_exceed_addr((unsigned long)addr);
f608788cd2d6ca Serapheim Dimitropoulos 2021-04-29  3636  	if (!va)
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3637  		goto finished_zero;
f181234a5a21fd Chen Wandun             2021-09-02  3638  
f181234a5a21fd Chen Wandun             2021-09-02  3639  	/* no intersects with alive vmap_area */
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3640  	if ((unsigned long)addr + remains <= va->va_start)
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3641  		goto finished_zero;
f181234a5a21fd Chen Wandun             2021-09-02  3642  
f608788cd2d6ca Serapheim Dimitropoulos 2021-04-29  3643  	list_for_each_entry_from(va, &vmap_area_list, list) {
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3644  		size_t copied;
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3645  
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3646  		if (remains == 0)
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3647  			goto finished;
e81ce85f960c2e Joonsoo Kim             2013-04-29  3648  
06c8994626d1b7 Baoquan He              2023-02-06  3649  		vm = va->vm;
06c8994626d1b7 Baoquan He              2023-02-06  3650  		flags = va->flags & VMAP_FLAGS_MASK;
06c8994626d1b7 Baoquan He              2023-02-06  3651  		/*
06c8994626d1b7 Baoquan He              2023-02-06  3652  		 * VMAP_BLOCK indicates a sub-type of vm_map_ram area, need
06c8994626d1b7 Baoquan He              2023-02-06  3653  		 * be set together with VMAP_RAM.
06c8994626d1b7 Baoquan He              2023-02-06  3654  		 */
06c8994626d1b7 Baoquan He              2023-02-06  3655  		WARN_ON(flags == VMAP_BLOCK);
06c8994626d1b7 Baoquan He              2023-02-06  3656  
06c8994626d1b7 Baoquan He              2023-02-06  3657  		if (!vm && !flags)

NULL check

e81ce85f960c2e Joonsoo Kim             2013-04-29  3658  			continue;
e81ce85f960c2e Joonsoo Kim             2013-04-29  3659  
30a7a9b17c4b03 Baoquan He              2023-02-06  3660  		if (vm && (vm->flags & VM_UNINITIALIZED))
30a7a9b17c4b03 Baoquan He              2023-02-06  3661  			continue;
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3662  
30a7a9b17c4b03 Baoquan He              2023-02-06  3663  		/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
30a7a9b17c4b03 Baoquan He              2023-02-06  3664  		smp_rmb();
30a7a9b17c4b03 Baoquan He              2023-02-06  3665  
06c8994626d1b7 Baoquan He              2023-02-06  3666  		vaddr = (char *) va->va_start;
06c8994626d1b7 Baoquan He              2023-02-06 @3667  		size = vm ? get_vm_area_size(vm) : va_size(va);
06c8994626d1b7 Baoquan He              2023-02-06  3668  
06c8994626d1b7 Baoquan He              2023-02-06  3669  		if (addr >= vaddr + size)
^1da177e4c3f41 Linus Torvalds          2005-04-16  3670  			continue;
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3671  
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3672  		if (addr < vaddr) {
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3673  			size_t to_zero = min_t(size_t, vaddr - addr, remains);
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3674  			size_t zeroed = zero_iter(iter, to_zero);
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3675  
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3676  			addr += zeroed;
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3677  			remains -= zeroed;
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3678  
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3679  			if (remains == 0 || zeroed != to_zero)
^1da177e4c3f41 Linus Torvalds          2005-04-16  3680  				goto finished;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3681  		}
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3682  
06c8994626d1b7 Baoquan He              2023-02-06  3683  		n = vaddr + size - addr;
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3684  		if (n > remains)
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3685  			n = remains;
06c8994626d1b7 Baoquan He              2023-02-06  3686  
06c8994626d1b7 Baoquan He              2023-02-06  3687  		if (flags & VMAP_RAM)
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3688  			copied = vmap_ram_vread_iter(iter, addr, n, flags);
06c8994626d1b7 Baoquan He              2023-02-06 @3689  		else if (!(vm->flags & VM_IOREMAP))
                                                                                   ^^^^^^^^^
Unchecked dereference

4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3690  			copied = aligned_vread_iter(iter, addr, n);
d0107eb07320b5 KAMEZAWA Hiroyuki       2009-09-21  3691  		else /* IOREMAP area is treated as memory hole */
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3692  			copied = zero_iter(iter, n);
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3693  
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3694  		addr += copied;
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3695  		remains -= copied;
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3696  
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3697  		if (copied != n)
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3698  			goto finished;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3699  	}
d0107eb07320b5 KAMEZAWA Hiroyuki       2009-09-21  3700  
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3701  finished_zero:
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3702  	spin_unlock(&vmap_area_lock);
d0107eb07320b5 KAMEZAWA Hiroyuki       2009-09-21  3703  	/* zero-fill memory holes */
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3704  	return count - remains + zero_iter(iter, remains);
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3705  finished:
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3706  	/* Nothing remains, or We couldn't copy/zero everything. */
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3707  	spin_unlock(&vmap_area_lock);
d0107eb07320b5 KAMEZAWA Hiroyuki       2009-09-21  3708  
4c91c07c93bbbd Lorenzo Stoakes         2023-03-22  3709  	return count - remains;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3710  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

