Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F2480557A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376872AbjLENIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376771AbjLENIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:08:10 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969241A2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3hv4cBuDdyoMYcKslo29be47lLFWNQGOVVHt0RLVmIY=;
  b=I7LtOjSY4C/jCK96NJ3fInrUPyFJTm38Ma6IxIwZIKEU+xaMgghKCIOH
   pjLCTvfB/6uloawbxMoWoRa/qLzJzAGBpqih55kWwZzGS+aAYKznlwXVb
   ZB54VKWpnIsqfz21HuMcNE914Qt6vU3goKdg2BLwZ9kGBPnmQbDyjaHnN
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,252,1695679200"; 
   d="scan'208";a="73462616"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 14:08:13 +0100
Date:   Tue, 5 Dec 2023 14:08:12 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Kent Overstreet <kmo@daterainc.com>
cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        lkp@intel.com
Subject: fs/bcachefs/move.c:33:17-31: WARNING use flexible-array member
 instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
 (fwd)
Message-ID: <899284eb-ef1d-44dd-9d57-86cb9b72bed7@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Tue, 5 Dec 2023 14:36:13 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: fs/bcachefs/move.c:33:17-31: WARNING use flexible-array member instead
    (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-
    and-one-element-arrays)

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Kent Overstreet <kmo@daterainc.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 1c6fdbd8f2465ddfb73a01ec620cbf3d14044e1a bcachefs: Initial commit
date:   6 weeks ago
:::::: branch date: 9 hours ago
:::::: commit date: 6 weeks ago
config: x86_64-randconfig-104-20231204 (https://download.01.org/0day-ci/archive/20231205/202312051447.F7YFxmFt-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312051447.F7YFxmFt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202312051447.F7YFxmFt-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/bcachefs/move.c:33:17-31: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
--
>> fs/bcachefs/fs.c:437:1-7: preceding lock on line 351
   fs/bcachefs/fs.c:1559:4-10: preceding lock on line 1549
--
>> fs/bcachefs/journal.c:806:1-7: preceding lock on line 731
>> fs/bcachefs/journal.c:806:1-7: preceding lock on line 731
   fs/bcachefs/journal.c:806:1-7: preceding lock on line 767
--
>> fs/bcachefs/fs.c:235:12-13: WARNING opportunity for min()
--
>> fs/bcachefs/journal.c:624:20-21: WARNING opportunity for min()
   fs/bcachefs/journal.c:417:12-13: WARNING opportunity for min()
--
>> fs/bcachefs/journal_io.c:256:5-8: Unneeded variable: "ret". Return "  0" on line 263
   fs/bcachefs/journal_io.c:272:5-8: Unneeded variable: "ret". Return "  0" on line 288

vim +33 fs/bcachefs/move.c

1c6fdbd8f2465d Kent Overstreet 2017-03-16  20
1c6fdbd8f2465d Kent Overstreet 2017-03-16  21  struct moving_io {
1c6fdbd8f2465d Kent Overstreet 2017-03-16  22  	struct list_head	list;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  23  	struct closure		cl;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  24  	bool			read_completed;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  25
1c6fdbd8f2465d Kent Overstreet 2017-03-16  26  	unsigned		read_sectors;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  27  	unsigned		write_sectors;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  28
1c6fdbd8f2465d Kent Overstreet 2017-03-16  29  	struct bch_read_bio	rbio;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  30
1c6fdbd8f2465d Kent Overstreet 2017-03-16  31  	struct migrate_write	write;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  32  	/* Must be last since it is variable size */
1c6fdbd8f2465d Kent Overstreet 2017-03-16 @33  	struct bio_vec		bi_inline_vecs[0];
1c6fdbd8f2465d Kent Overstreet 2017-03-16  34  };
1c6fdbd8f2465d Kent Overstreet 2017-03-16  35

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
