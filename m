Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8D87E1D07
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjKFJLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:11:23 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EAFB3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:11:19 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso6980615a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 01:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699261878; x=1699866678; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJ31m0TsVDUq2R/F21AGORoI9bPFyvlysbTWLK5sAv0=;
        b=l10lxqnReFfxP9+pXgTqsLFyVHd13Ve0szFCZ0Fxi1oogYxOlqlDtslsryoP2hJB0t
         EkA6mO3t4OTSuyOfUe8jvmGdWdgqotBpFzKUXdZL53bm7Qwe3vMPgSTEMW4iKq7n7Vvo
         I9yZjVqdTY/Kz7eiZ8fykoJoJqbEEszRY2EDJjwg3G2SH/oJY7fteqsWkAM2bSNfXKVa
         sEJtux3Gj+ZNScIujsbL9s+WojgjC3z+t8fjQ4HBuBvZvGkLNXzcfqoMelBMg1cBnlpQ
         c+U8axsaLBU+FeFC/UNzfG0ge3rQK8ngGhrlKKI5n8nLWHFZpqOYznumvt+qzPwqals0
         cZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699261878; x=1699866678;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ31m0TsVDUq2R/F21AGORoI9bPFyvlysbTWLK5sAv0=;
        b=gFV4gvd22EsFQUPpm8cGd039ZqYeQRbYEUTpV4eqDmJpphz3DzieHKwTqMybH96rKf
         VOb58skjUz5sT0MZcWFMWNUSKfWKYVSM43YvDfr94Jo7GZmzkXo7dCKrJhTmB9jsmuiJ
         b1jWFYPqgT+yVbor2hJZjNOvRh4IgXyqvRn7ebpN0+wAd4ZR0CugikHn+Bll6dcjyZFW
         ZxEdhaMimlzWbI0qtP3bk6YgZOZ3kx+ZjdCg6UeNJUlTgMc/td2eyfRBRYNqVDs9ZF+8
         bpALoAe1eb3vDnCeiSU/8YGh0As/tCN8khgd3GyEuG9IwsYe82060f2iXyk70WDCNWuC
         ul8A==
X-Gm-Message-State: AOJu0Yx6q8yhbJ7xw5GfF/vaUuXfONS5zh29LRJKFBVwFZiExWKjOb4b
        FTEEM/1Uda1MSRh3f+MfHHFuRw==
X-Google-Smtp-Source: AGHT+IGvbbZQHu8gzGhrcpZBBp31NAm5pt4UOYI9KXb62ZsaDJWCxOWnUJ4ob6F2n2rGGnbCJsA3SQ==
X-Received: by 2002:a17:906:d555:b0:9c4:67f:3ef5 with SMTP id cr21-20020a170906d55500b009c4067f3ef5mr12688099ejc.50.1699261878032;
        Mon, 06 Nov 2023 01:11:18 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709063b0a00b009ada9f7217asm3869359ejf.88.2023.11.06.01.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 01:11:17 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:11:15 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Coly Li <colyli@suse.de>
Subject: drivers/md/bcache/btree.c:1511 btree_gc_rewrite_node() error: 'n'
 dereferencing possible ERR_PTR()
Message-ID: <a754f8a3-cbfb-42bb-b776-94ecac062daf@kadam.mountain>
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

Hi Zheng,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: 028ddcac477b691dd9205c92f991cc15259d033e bcache: Remove unnecessary NULL point check in node allocations
config: x86_64-randconfig-161-20231102 (https://download.01.org/0day-ci/archive/20231106/202311060857.2jHVe0uk-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20231106/202311060857.2jHVe0uk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202311060857.2jHVe0uk-lkp@intel.com/

New smatch warnings:
drivers/md/bcache/btree.c:1511 btree_gc_rewrite_node() error: 'n' dereferencing possible ERR_PTR()

Old smatch warnings:
drivers/md/bcache/btree.c:1527 btree_gc_rewrite_node() error: 'n' dereferencing possible ERR_PTR()

vim +/n +1511 drivers/md/bcache/btree.c

0a63b66db566cf Kent Overstreet 2014-03-17  1497  static int btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
0a63b66db566cf Kent Overstreet 2014-03-17  1498  				 struct btree *replace)
0a63b66db566cf Kent Overstreet 2014-03-17  1499  {
0a63b66db566cf Kent Overstreet 2014-03-17  1500  	struct keylist keys;
0a63b66db566cf Kent Overstreet 2014-03-17  1501  	struct btree *n;
0a63b66db566cf Kent Overstreet 2014-03-17  1502  
0a63b66db566cf Kent Overstreet 2014-03-17  1503  	if (btree_check_reserve(b, NULL))
0a63b66db566cf Kent Overstreet 2014-03-17  1504  		return 0;
0a63b66db566cf Kent Overstreet 2014-03-17  1505  
0a63b66db566cf Kent Overstreet 2014-03-17  1506  	n = btree_node_alloc_replacement(replace, NULL);

Needs some error handling.  I don't know why the zero day bot is
sending repeat warnings today but this one is still worth fixing.
I guess the zero day bot sent the previous warning to the wrong people
last time.

https://lore.kernel.org/all/bab6966d-3f96-44a0-b666-ddf976179eab@kadam.mountain/

0a63b66db566cf Kent Overstreet 2014-03-17  1507  
0a63b66db566cf Kent Overstreet 2014-03-17  1508  	/* recheck reserve after allocating replacement node */
0a63b66db566cf Kent Overstreet 2014-03-17  1509  	if (btree_check_reserve(b, NULL)) {
0a63b66db566cf Kent Overstreet 2014-03-17  1510  		btree_node_free(n);
0a63b66db566cf Kent Overstreet 2014-03-17 @1511  		rw_unlock(true, n);
0a63b66db566cf Kent Overstreet 2014-03-17  1512  		return 0;
0a63b66db566cf Kent Overstreet 2014-03-17  1513  	}
0a63b66db566cf Kent Overstreet 2014-03-17  1514  
0a63b66db566cf Kent Overstreet 2014-03-17  1515  	bch_btree_node_write_sync(n);
0a63b66db566cf Kent Overstreet 2014-03-17  1516  
0a63b66db566cf Kent Overstreet 2014-03-17  1517  	bch_keylist_init(&keys);
0a63b66db566cf Kent Overstreet 2014-03-17  1518  	bch_keylist_add(&keys, &n->key);
0a63b66db566cf Kent Overstreet 2014-03-17  1519  
0a63b66db566cf Kent Overstreet 2014-03-17  1520  	make_btree_freeing_key(replace, keys.top);
0a63b66db566cf Kent Overstreet 2014-03-17  1521  	bch_keylist_push(&keys);
0a63b66db566cf Kent Overstreet 2014-03-17  1522  
0a63b66db566cf Kent Overstreet 2014-03-17  1523  	bch_btree_insert_node(b, op, &keys, NULL, NULL);
0a63b66db566cf Kent Overstreet 2014-03-17  1524  	BUG_ON(!bch_keylist_empty(&keys));
0a63b66db566cf Kent Overstreet 2014-03-17  1525  
0a63b66db566cf Kent Overstreet 2014-03-17  1526  	btree_node_free(replace);
0a63b66db566cf Kent Overstreet 2014-03-17  1527  	rw_unlock(true, n);
0a63b66db566cf Kent Overstreet 2014-03-17  1528  
0a63b66db566cf Kent Overstreet 2014-03-17  1529  	/* Invalidated our iterator */
0a63b66db566cf Kent Overstreet 2014-03-17  1530  	return -EINTR;
0a63b66db566cf Kent Overstreet 2014-03-17  1531  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

