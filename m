Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AD8112A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379182AbjLMNT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379161AbjLMNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:19:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE54D8E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:19:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3333b46f26aso6262253f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702473569; x=1703078369; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EsdXhQ9stE2bZqdJRy9zMQjkiZsUKWSWLUwA06lYnkQ=;
        b=yAE1hnDXZOItJraYG0BDDrzpQn8JoZEnYxfUdiNPpfBjMkdSZ9swWgjldwzPgl6dzE
         T1D/h8fu1PFZALclaxwurVeisfKTf18BKB9VXU+yHXg9yjaZShLUYOhjmME+29b3Rc7g
         S0WZv0+fYAVZLjKdB7xxLjHrRvG4eBm8j0xJDNEfoCosclGxQWTjEQ6+1aAIfjOzggqa
         CYdTQz/RQl8ey2419xYicYX/6fxAgSeg5yQa4UGVRmsjxR8ozcJQlzdgYsBJPyfDFa9o
         6ToFfTmhe444RwMgWasDODtL1uilfaDY8byj83Wqr16/e63FD0ZyiCfPr4eBhF5S2D7E
         QnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473569; x=1703078369;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsdXhQ9stE2bZqdJRy9zMQjkiZsUKWSWLUwA06lYnkQ=;
        b=OoBfglx4km6YACCjkIhT7n3CNH56Frc5ikJ0CT3KRj2sbiXs+Fd51DBdLWmG6Bj4Wy
         8M775mRtRwW2/btXavNPi9oGchW4Fkvacz3dB2uNK87wtyHAaEMGK+x3x9YngBGxaWjX
         lUcNOoJy2J0gxKIROzAuitny81wYwaI7yJsh5nvLA9hH2Bvh/nICgOapzBJ0cq8SU8/h
         8kLhBPBgg0WExUo95P18eImlfNotMKVb96MhzeVGNUH3RyEEH6A7NGtQWI+FWirvbZVw
         rMIKL0+dViLT0UmWNpSzAkN3kGTHCGzOp8xl4Rp+ipb8dYqJjHesq5fqTiFMjDz+5kxJ
         Whng==
X-Gm-Message-State: AOJu0YzdgO7OJmTLx1pW/9aiimOSahDuI5n4Tj5u8J/0jHqC2mJFt4G2
        dTBBWt6wmmSDWcljLh2wVPnLFA==
X-Google-Smtp-Source: AGHT+IFFLrs9vM6knyPmGlPn6dej6ZlQgDhZz3Yaa7EHmjE5r/WWjNkPTiPL5gEmvXZiHuAy1OYpCQ==
X-Received: by 2002:adf:e28c:0:b0:333:4a78:c5ee with SMTP id v12-20020adfe28c000000b003334a78c5eemr4118334wri.48.1702473569381;
        Wed, 13 Dec 2023 05:19:29 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id p18-20020a5d6392000000b003333a216682sm13263376wru.97.2023.12.13.05.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:19:28 -0800 (PST)
Date:   Wed, 13 Dec 2023 16:19:26 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Charlie Jenkins <charlie@rivosinc.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/module.c:727 add_relocation_to_accumulate() error:
 dereferencing freed memory 'rel_head'
Message-ID: <17fcf691-e184-4542-b095-bbb4084d031f@suswa.mountain>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88035e5694a86a7167d490bb95e9df97a9bb162b
commit: d8792a5734b0f3e58b898c2e2f910bfac48e9ee3 riscv: Safely remove entries from relocation list
config: riscv-randconfig-r071-20231211 (https://download.01.org/0day-ci/archive/20231213/202312132019.iYGTwW0L-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231213/202312132019.iYGTwW0L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312132019.iYGTwW0L-lkp@intel.com/

New smatch warnings:
arch/riscv/kernel/module.c:727 add_relocation_to_accumulate() error: dereferencing freed memory 'rel_head'
arch/riscv/kernel/module.c:792 apply_relocate_add() warn: unsigned 'hashtable_bits' is never less than zero.

vim +/rel_head +727 arch/riscv/kernel/module.c

8fd6c5142395a1 Charlie Jenkins      2023-11-01  717  		INIT_LIST_HEAD(rel_head->rel_entry);
8fd6c5142395a1 Charlie Jenkins      2023-11-01  718  		rel_head->location = location;
8fd6c5142395a1 Charlie Jenkins      2023-11-01  719  		INIT_HLIST_NODE(&rel_head->node);
8fd6c5142395a1 Charlie Jenkins      2023-11-01  720  		if (!current_head->first) {
8fd6c5142395a1 Charlie Jenkins      2023-11-01  721  			bucket =
8fd6c5142395a1 Charlie Jenkins      2023-11-01  722  				kmalloc(sizeof(struct used_bucket), GFP_KERNEL);
d8792a5734b0f3 Charlie Jenkins      2023-11-27  723  
d8792a5734b0f3 Charlie Jenkins      2023-11-27  724  			if (!bucket) {
d8792a5734b0f3 Charlie Jenkins      2023-11-27  725  				kfree(entry);
d8792a5734b0f3 Charlie Jenkins      2023-11-27  726  				kfree(rel_head);
d8792a5734b0f3 Charlie Jenkins      2023-11-27 @727  				kfree(rel_head->rel_entry);

Swap these two frees to avoid a use after free.

d8792a5734b0f3 Charlie Jenkins      2023-11-27  728  				return -ENOMEM;
d8792a5734b0f3 Charlie Jenkins      2023-11-27  729  			}
d8792a5734b0f3 Charlie Jenkins      2023-11-27  730  
8fd6c5142395a1 Charlie Jenkins      2023-11-01  731  			INIT_LIST_HEAD(&bucket->head);
8fd6c5142395a1 Charlie Jenkins      2023-11-01  732  			bucket->bucket = current_head;
d8792a5734b0f3 Charlie Jenkins      2023-11-27  733  			list_add(&bucket->head, used_buckets_list);
8fd6c5142395a1 Charlie Jenkins      2023-11-01  734  		}
8fd6c5142395a1 Charlie Jenkins      2023-11-01  735  		hlist_add_head(&rel_head->node, current_head);
8fd6c5142395a1 Charlie Jenkins      2023-11-01  736  	}

[ snip ]

e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  773  int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  774  		       unsigned int symindex, unsigned int relsec,
e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  775  		       struct module *me)
e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  776  {
e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  777  	Elf_Rela *rel = (void *) sechdrs[relsec].sh_addr;
8cbe0accc4a6ba Emil Renner Berthing 2023-11-01  778  	int (*handler)(struct module *me, void *location, Elf_Addr v);
e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  779  	Elf_Sym *sym;
8cbe0accc4a6ba Emil Renner Berthing 2023-11-01  780  	void *location;
e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  781  	unsigned int i, type;
e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  782  	Elf_Addr v;
e2c0cdfba7f699 Palmer Dabbelt       2017-07-10  783  	int res;
8fd6c5142395a1 Charlie Jenkins      2023-11-01  784  	unsigned int num_relocations = sechdrs[relsec].sh_size / sizeof(*rel);
d8792a5734b0f3 Charlie Jenkins      2023-11-27  785  	struct hlist_head *relocation_hashtable;
d8792a5734b0f3 Charlie Jenkins      2023-11-27  786  	struct list_head used_buckets_list;
d8792a5734b0f3 Charlie Jenkins      2023-11-27  787  	unsigned int hashtable_bits;
                                                        ^^^^^^^^

d8792a5734b0f3 Charlie Jenkins      2023-11-27  788  
d8792a5734b0f3 Charlie Jenkins      2023-11-27  789  	hashtable_bits = initialize_relocation_hashtable(num_relocations,
d8792a5734b0f3 Charlie Jenkins      2023-11-27  790  							 &relocation_hashtable);
d8792a5734b0f3 Charlie Jenkins      2023-11-27  791  
d8792a5734b0f3 Charlie Jenkins      2023-11-27 @792  	if (hashtable_bits < 0)
                                                            ^^^^^^^^^^^^^^^^^^
Can't be less than zero.

d8792a5734b0f3 Charlie Jenkins      2023-11-27  793  		return hashtable_bits;
d8792a5734b0f3 Charlie Jenkins      2023-11-27  794  
d8792a5734b0f3 Charlie Jenkins      2023-11-27  795  	INIT_LIST_HEAD(&used_buckets_list);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

