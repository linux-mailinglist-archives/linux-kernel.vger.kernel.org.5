Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379897B64BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbjJCIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjJCIyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:54:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE6AA9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:54:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40572aeb673so6803475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696323256; x=1696928056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMBF6CYv/Ij0N24iNy1D3Ro9xhDGvt8mVDekKClPklY=;
        b=GktZi4J1VGLvhtm+qyAwU7xNh8lXZLYTGy1bGJswyZy3L3Pq6/0QK2yMufVhG23+YB
         R1k5f2FsNzrM6M55Anv+0f7vPLGCsRiUhLEOhBxbV5FwQhqwaDyk5vKQF6qxYTOBtQOO
         Xzk8LC8UY3gVIhIujKKYGIkZ7TejVNV7F6pdUZ8GCxeLHj/6kQgz0IuayS/CFCeCuWWi
         LqfZ7cFHOJMiqUJOWShg2LQQry4zzm85eXjcDBN+ITB4kYKz0SlE5EYCUicV41Wq3UHJ
         06dxCotTpuCU0JrIwGscp2XzEyCo0FMa712YwqS59lFviAO8MCmBzX5yeYPqs4RxgTU9
         SVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696323256; x=1696928056;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMBF6CYv/Ij0N24iNy1D3Ro9xhDGvt8mVDekKClPklY=;
        b=q/e8IoBQjVfLzO6/ybBwlihLAeNE2Aqt5fuf98MnU+S9P1ca5jQnBwrAYRNzKvZIUi
         lOPMULovnu6DX9O7bVH+z3wPxmnMxW0pRn69gBFPZQWvUN1YLRRXxbKbI+WfdBphBKGb
         xAtm84Ps5KguxiZQxuSCUSj0Hf5v/6JycjKfUnUjc4LV7yG+GdHXceLZByurPt7RqrHn
         JVZY4NCb9lTdIzTMKO/YDUrq2w3Eweoe5NyTP4MK4sX97GCaODmPkoct1h9k1nsM+dDQ
         HfQV9b43XgRl/r+qzQ/Lziafo4ojAoWaPJocL4hM167VRrTzvOegZhANwoNBqBybgWQW
         TBhg==
X-Gm-Message-State: AOJu0Yy1WoUVqL7MkULsCvx16sB/J7jhIDR9S7mSqM4kcrd17FXKV8iQ
        ZXknIrM01dSeSA8pl0d0LUK9/w==
X-Google-Smtp-Source: AGHT+IFhwd3cGvrHeY4f/x4a+od0nlW+pzGUHUlr30eX3ZoH56Y2bkm3f8dsAUKIPk6FTODm19vusg==
X-Received: by 2002:a7b:c3c1:0:b0:404:7670:90b8 with SMTP id t1-20020a7bc3c1000000b00404767090b8mr12175904wmj.27.1696323256592;
        Tue, 03 Oct 2023 01:54:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x23-20020a05600c21d700b004051f8d6207sm767778wmj.6.2023.10.03.01.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:54:15 -0700 (PDT)
Date:   Tue, 3 Oct 2023 11:54:13 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn:
 variable dereferenced before check 'peer_device' (see line 587)
Message-ID: <ace247b3-1a4f-43bb-a0ca-49665a1bb410@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ce36c8b149873b50f2a4b9818eb3dcdd74ddd5a3
commit: 0d11f3cf279c5ad20a41f29242f170ba3c02f2da drbd: Pass a peer device to the resync and online verify functions
config: x86_64-randconfig-161-20231003 (https://download.01.org/0day-ci/archive/20231003/202310030935.6F0FaCJy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231003/202310030935.6F0FaCJy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310030935.6F0FaCJy-lkp@intel.com/

smatch warnings:
drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn: variable dereferenced before check 'peer_device' (see line 587)

vim +/peer_device +588 drivers/block/drbd/drbd_worker.c

0d11f3cf279c5a Christoph Böhmwalder 2023-03-30  585  static int make_resync_request(struct drbd_peer_device *const peer_device, int cancel)
b411b3637fa71f Philipp Reisner      2009-09-25  586  {
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30 @587  	struct drbd_device *const device = peer_device->device;
                                                                                           ^^^^^^^^^^^^^^^^^^^^
Dereference

44a4d551846b8c Lars Ellenberg       2013-11-22 @588  	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
                                                                                                   ^^^^^^^^^^^
Checked too late.  The zero day bot sent this warning earlier and I try
not to resend warnings but no one responded to the first one.  The
peer_device pointer comes from a list_first_entry_or_null() so that
suggests it can be NULL.

b411b3637fa71f Philipp Reisner      2009-09-25  589  	unsigned long bit;
b411b3637fa71f Philipp Reisner      2009-09-25  590  	sector_t sector;
155bd9d1abd604 Christoph Hellwig    2020-09-25  591  	const sector_t capacity = get_capacity(device->vdisk);
1816a2b47afae8 Lars Ellenberg       2010-11-11  592  	int max_bio_size;
e65f440d474d7d Lars Ellenberg       2010-11-05  593  	int number, rollback_i, size;
506afb6248af57 Lars Ellenberg       2014-01-31  594  	int align, requeue = 0;
0f0601f4ea2f53 Lars Ellenberg       2010-08-11  595  	int i = 0;
92d94ae66aebda Philipp Reisner      2016-06-14  596  	int discard_granularity = 0;
b411b3637fa71f Philipp Reisner      2009-09-25  597  
b411b3637fa71f Philipp Reisner      2009-09-25  598  	if (unlikely(cancel))
99920dc5c5fe52 Andreas Gruenbacher  2011-03-16  599  		return 0;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

