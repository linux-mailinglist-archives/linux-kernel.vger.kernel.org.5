Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DF975BDF8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjGUFtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGUFsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:48:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3668235AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 22:48:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so1284873f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689918485; x=1690523285;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCeTB4WM/pt8WD+mQ9GMGSXARlfwN0bp+sUlEfBZ9K4=;
        b=biujymmCVqezxC27EiBBzYXIN5oU95W6+D1hcOAhHmhO0cf6u6gYJxdopCzzIty4k+
         CySOJBUc94S18RLgTxNhVO6OoHm/+lguSRl/aD4hRIjl7Xrig2RB4BSd2Pjah8UNvVqM
         iAI6x/EX6RmozBEPGHoELvPRpyWYyju8nHPqRvyiN53wjpKjKWTU+y0lcYa7a0WyDQ8Y
         5kHU16JhzWAXe1mjg1/aExF9mQu/RtUBNC7QZPPyxVxDoWZmrlPlIGs22CnFWhi14piz
         jlaB5+XMuyNXVewyWz0NevQFI9EiqKSMd3BF2LkBp1dim0FzPIgasfxOoQrVnYdUJE/g
         2FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689918485; x=1690523285;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCeTB4WM/pt8WD+mQ9GMGSXARlfwN0bp+sUlEfBZ9K4=;
        b=k+YxFHPipOa1cca+eas9/4HK/PLGsBhuAQ5oPaI55dpMYPlSfYhuawkhOI50GC82R0
         NHzGHSjAJZqoH0ulE7RtJgeCj5VJIDhf/gV3OGcfk0O/s+724AW0wmA1dJ76IvHpILZZ
         qy5B1oV1h/gtYPnQT6iItaWCCjF3G+dTaZ6ewOt1JJ4KN6h9VcQdF41v/SzPDgoi+06r
         a78kLTP+61FD8HwHalO/UKieqCyM2/3pCxqmeVZML9WIGO8Yk8f9EQsJ405p86Lt8Wu5
         JszC54hXUj+arbBFEcKz8aJgpSVPvJc7KJwa6pxelWZWMPu5ZiMMC3AYJavo3KerPk2B
         KB+w==
X-Gm-Message-State: ABy/qLavktnFoFx/r8gVz1kkqcYfOXMFQOb4Fci+WBnptSkfqZdhZlC3
        OPTsjSzO3z43BXVLJaq9QqUGgr87zkwtWh3GAxE=
X-Google-Smtp-Source: APBJJlFWfZwIjZU6Q8aKC0H94OzMfm0NaC9oWbBE3+J65qfgvBGAiHVG/P6KFMfEoiscM41eOkf2hA==
X-Received: by 2002:adf:eb4e:0:b0:313:f5f8:b6d2 with SMTP id u14-20020adfeb4e000000b00313f5f8b6d2mr578491wrn.48.1689918485587;
        Thu, 20 Jul 2023 22:48:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u1-20020adfdb81000000b0030e5bd253aasm3174633wri.39.2023.07.20.22.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 22:48:03 -0700 (PDT)
Date:   Fri, 21 Jul 2023 08:48:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn:
 variable dereferenced before check 'peer_device' (see line 587)
Message-ID: <73062d38-1008-4593-9d1a-ac673b99ae05@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   46670259519f4ee4ab378dc014798aabe77c5057
commit: 0d11f3cf279c5ad20a41f29242f170ba3c02f2da drbd: Pass a peer device to the resync and online verify functions
config: parisc-randconfig-m041-20230720 (https://download.01.org/0day-ci/archive/20230721/202307210201.NF8Ro2N0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307210201.NF8Ro2N0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202307210201.NF8Ro2N0-lkp@intel.com/

smatch warnings:
drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn: variable dereferenced before check 'peer_device' (see line 587)

vim +/peer_device +588 drivers/block/drbd/drbd_worker.c

0d11f3cf279c5a Christoph Böhmwalder 2023-03-30  585  static int make_resync_request(struct drbd_peer_device *const peer_device, int cancel)
b411b3637fa71f Philipp Reisner      2009-09-25  586  {
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30 @587  	struct drbd_device *const device = peer_device->device;
                                                                                           ^^^^^^^^^^^^^
Unchecked dereference

44a4d551846b8c Lars Ellenberg       2013-11-22 @588  	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
                                                                                                   ^^^^^^^^^^^
This check is too late

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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

