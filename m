Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15807811EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442236AbjLMT32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjLMT31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:29:27 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6137B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:29:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c66418decaso3624009a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702495771; x=1703100571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuicOJq+0CXKSvfCBFTZjGzFOcAHcLQmjoNEHnmDvtw=;
        b=gnxuCNzIGd/TL4NEG2sFoTguX+F+FPKHZ+COVlDPUDKaHTFOCmc+ZmBGbU3KHKAGny
         8d4qj2tDTxsnB1iOgzU1xYbXrWPFoCx+MyB1t5Bkoc3Y4HmU3s0l2f1bVEnPdL+1fU4R
         YGZfURGV0RDElDu8PjGKluEUG2zVUstEJPwKKr+TcnCtL0U+SY3AfM6VamS8xAYH7iBL
         w4JGTicFBqnJ4+9Lifq60B6+Qpk9M7l1NMRNpxreICRc1SiqI611jsKlI1WcDPPEr41H
         4wnVR+8eYSpc+Y3reaXrTozc4NFLkYKwYmXNrMrwtccEIL9wLcHV8xKI0vvUPLOSEEUT
         6UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702495771; x=1703100571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuicOJq+0CXKSvfCBFTZjGzFOcAHcLQmjoNEHnmDvtw=;
        b=Oxx1+wxJaORcVSLF2BxzuWSE4+EomfrAMhkePyfjlga5b3hW5ihvLCCXMNwb+T1Ix6
         APSnx26d9lk5GJsMQCKc8RB/ywhznAFxON/XPbxON4hKeT/1RO0n82Ih2lyQnZvc4NBW
         7fEnfpjsxy2N2wWVMBwlfnsQpUYWVI/ct4KFGiuTIKbuWXklZYJubbKU/o4e3+MMC+2G
         yC3EWLI6GRf8uitC0hDs8gw8myURjRFxbL7F8CjrnG5otBmLn03YNfevMRTcb0CB4z7E
         1oCbUr8vN5ryUWaX6H/mIXwPVkuEddRr+F3ZqhlyiieV3wf+o0w2GMKkIdlgsFfAn/Rr
         Zd3A==
X-Gm-Message-State: AOJu0YxqLB9pDiRoyp66oS+28vSJuCTN0AW/WFIc81vCPD89IFzeIXEi
        pwNRyuc6QTO+h3pUwXvQdh7bAw==
X-Google-Smtp-Source: AGHT+IGz5OsdtCynJx1WCIqmZOcQ9Yb7PLpcW/7iy9u/CnYxi2T5L+fOPo7RTx3aq6cUMI9Sz2L8/w==
X-Received: by 2002:a05:6a20:320f:b0:18c:a983:a5f6 with SMTP id hl15-20020a056a20320f00b0018ca983a5f6mr3667843pzc.23.1702495771345;
        Wed, 13 Dec 2023 11:29:31 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id t2-20020a62d142000000b006ce538550bbsm10742898pfl.74.2023.12.13.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:29:30 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:29:29 -0800
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: arch/riscv/kernel/module.c:727 add_relocation_to_accumulate()
 error: dereferencing freed memory 'rel_head'
Message-ID: <ZXoGGcAFdbn+quq+@ghost>
References: <17fcf691-e184-4542-b095-bbb4084d031f@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17fcf691-e184-4542-b095-bbb4084d031f@suswa.mountain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 04:19:26PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   88035e5694a86a7167d490bb95e9df97a9bb162b
> commit: d8792a5734b0f3e58b898c2e2f910bfac48e9ee3 riscv: Safely remove entries from relocation list
> config: riscv-randconfig-r071-20231211 (https://download.01.org/0day-ci/archive/20231213/202312132019.iYGTwW0L-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231213/202312132019.iYGTwW0L-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202312132019.iYGTwW0L-lkp@intel.com/
> 
> New smatch warnings:
> arch/riscv/kernel/module.c:727 add_relocation_to_accumulate() error: dereferencing freed memory 'rel_head'
> arch/riscv/kernel/module.c:792 apply_relocate_add() warn: unsigned 'hashtable_bits' is never less than zero.
> 
> vim +/rel_head +727 arch/riscv/kernel/module.c
> 
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  717  		INIT_LIST_HEAD(rel_head->rel_entry);
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  718  		rel_head->location = location;
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  719  		INIT_HLIST_NODE(&rel_head->node);
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  720  		if (!current_head->first) {
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  721  			bucket =
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  722  				kmalloc(sizeof(struct used_bucket), GFP_KERNEL);
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  723  
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  724  			if (!bucket) {
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  725  				kfree(entry);
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  726  				kfree(rel_head);
> d8792a5734b0f3 Charlie Jenkins      2023-11-27 @727  				kfree(rel_head->rel_entry);
> 
> Swap these two frees to avoid a use after free.

Thanks for pointing this out.

> 
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  728  				return -ENOMEM;
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  729  			}
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  730  
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  731  			INIT_LIST_HEAD(&bucket->head);
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  732  			bucket->bucket = current_head;
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  733  			list_add(&bucket->head, used_buckets_list);
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  734  		}
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  735  		hlist_add_head(&rel_head->node, current_head);
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  736  	}
> 
> [ snip ]
> 
> e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  773  int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  774  		       unsigned int symindex, unsigned int relsec,
> e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  775  		       struct module *me)
> e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  776  {
> e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  777  	Elf_Rela *rel = (void *) sechdrs[relsec].sh_addr;
> 8cbe0accc4a6ba Emil Renner Berthing 2023-11-01  778  	int (*handler)(struct module *me, void *location, Elf_Addr v);
> e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  779  	Elf_Sym *sym;
> 8cbe0accc4a6ba Emil Renner Berthing 2023-11-01  780  	void *location;
> e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  781  	unsigned int i, type;
> e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  782  	Elf_Addr v;
> e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  783  	int res;
> 8fd6c5142395a1 Charlie Jenkins      2023-11-01  784  	unsigned int num_relocations = sechdrs[relsec].sh_size / sizeof(*rel);
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  785  	struct hlist_head *relocation_hashtable;
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  786  	struct list_head used_buckets_list;
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  787  	unsigned int hashtable_bits;
>                                                         ^^^^^^^^
> 
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  788  
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  789  	hashtable_bits = initialize_relocation_hashtable(num_relocations,
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  790  							 &relocation_hashtable);
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  791  
> d8792a5734b0f3 Charlie Jenkins      2023-11-27 @792  	if (hashtable_bits < 0)
>                                                             ^^^^^^^^^^^^^^^^^^
> Can't be less than zero.

I am returning a negative number in an unsigned function, oops. Since
the only possible failure in the function is an out-of-memory error and
0 is not a valid return, I will return 0 in the out-of-memory case.

- Charlie

> 
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  793  		return hashtable_bits;
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  794  
> d8792a5734b0f3 Charlie Jenkins      2023-11-27  795  	INIT_LIST_HEAD(&used_buckets_list);
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
