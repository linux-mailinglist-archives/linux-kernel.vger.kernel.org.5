Return-Path: <linux-kernel+bounces-130219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F6489759C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022681F28B76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CCE1514DB;
	Wed,  3 Apr 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="eKGMAGxW"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC514A62A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162857; cv=none; b=Gg1kH7fctXYbiZMgLEkFidseWry0B/L74wlI2VSIvm9mQp+RbfWy+8ZZ4tlpAyp0hL8BaqbJVoRCb4HO/jew0eLEhKfmOIteoo5//Zb2pDd0rR8SvqKKcaRy0troFqHh2wvCLq7f1hqC6sBaatQjl7SucVPk7SeWZIGPtnYIBUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162857; c=relaxed/simple;
	bh=U0zflQ/DUqAS1WmebiTHjCOmEJuKOBLxiWtpxcTaz0g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=BlzgtcTFt7f1k/W7tS2CPoAw0CaGcWY9a8Vez8QVCLjvTSH7MIZGigXqcg1BagwIcNlA/Am68GzWAXfZFiMVJwIPblgUgfgEFRW0H3s62cNa/wgOQ77jjXlwONR6Sy/SubVQrqWeHPRGh6SpFnuf6d+aCT3FxUxLV7EM8vO9W5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=eKGMAGxW; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=MRo1/HtqY+UvUOsLgmIiFjYWrueG23TAMQ7iEdx5nZI=;
  b=eKGMAGxWkras6xzraIN+dYrzgdr/0NKVixxGSy94OrjTmwQvIWc5l9Xm
   +7756Xbanm3tz3jazgAgNYGKvvEvR/9SD0h0tvaQ5Ua1WWp20de4IkkfS
   l9VJrV2bBVSahFzJdPrcZ1pKKi9t+qS8P/ZThikEtOw0Nrtaid6ROW96O
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,177,1708383600"; 
   d="scan'208";a="83808516"
Received: from 71-51-181-183.chvl.centurylink.net (HELO hadrien) ([71.51.181.183])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 18:47:25 +0200
Date: Wed, 3 Apr 2024 12:47:23 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Mike Snitzer <snitzer@kernel.org>, Matthew Sakai <msakai@redhat.com>, 
    linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/md/dm-vdo/data-vio.c:969:2-8: preceding lock on line 966
 (fwd)
Message-ID: <801d737e-f7c0-b853-d7e-63eb68c7fd7b@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello,

Please check whether the lock should be released before the returns.

julia

---------- Forwarded message ----------
Date: Wed, 3 Apr 2024 22:16:44 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/md/dm-vdo/data-vio.c:969:2-8: preceding lock on line 966

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Mike Snitzer <snitzer@kernel.org>
CC: Matthew Sakai <msakai@redhat.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e92c1e6cd876754b64d1998ec0a01800ed954a6
commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
date:   6 weeks ago
:::::: branch date: 11 hours ago
:::::: commit date: 6 weeks ago
config: s390-randconfig-r052-20240403 (https://download.01.org/0day-ci/archive/20240403/202404032212.NV7EJ2Zj-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202404032212.NV7EJ2Zj-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/md/dm-vdo/data-vio.c:969:2-8: preceding lock on line 966
   drivers/md/dm-vdo/data-vio.c:972:2-8: preceding lock on line 966

vim +969 drivers/md/dm-vdo/data-vio.c

79535a7881c0cb Matthew Sakai 2023-11-16  952
79535a7881c0cb Matthew Sakai 2023-11-16  953  /**
79535a7881c0cb Matthew Sakai 2023-11-16  954   * vdo_launch_bio() - Acquire a data_vio from the pool, assign the bio to it, and launch it.
79535a7881c0cb Matthew Sakai 2023-11-16  955   *
79535a7881c0cb Matthew Sakai 2023-11-16  956   * This will block if data_vios or discard permits are not available.
79535a7881c0cb Matthew Sakai 2023-11-16  957   */
79535a7881c0cb Matthew Sakai 2023-11-16  958  void vdo_launch_bio(struct data_vio_pool *pool, struct bio *bio)
79535a7881c0cb Matthew Sakai 2023-11-16  959  {
79535a7881c0cb Matthew Sakai 2023-11-16  960  	struct data_vio *data_vio;
79535a7881c0cb Matthew Sakai 2023-11-16  961
79535a7881c0cb Matthew Sakai 2023-11-16  962  	ASSERT_LOG_ONLY(!vdo_is_state_quiescent(&pool->state),
79535a7881c0cb Matthew Sakai 2023-11-16  963  			"data_vio_pool not quiescent on acquire");
79535a7881c0cb Matthew Sakai 2023-11-16  964
79535a7881c0cb Matthew Sakai 2023-11-16  965  	bio->bi_private = (void *) jiffies;
79535a7881c0cb Matthew Sakai 2023-11-16 @966  	spin_lock(&pool->lock);
79535a7881c0cb Matthew Sakai 2023-11-16  967  	if ((bio_op(bio) == REQ_OP_DISCARD) &&
79535a7881c0cb Matthew Sakai 2023-11-16  968  	    !acquire_permit(&pool->discard_limiter, bio))
79535a7881c0cb Matthew Sakai 2023-11-16 @969  		return;
79535a7881c0cb Matthew Sakai 2023-11-16  970
79535a7881c0cb Matthew Sakai 2023-11-16  971  	if (!acquire_permit(&pool->limiter, bio))
79535a7881c0cb Matthew Sakai 2023-11-16  972  		return;
79535a7881c0cb Matthew Sakai 2023-11-16  973
79535a7881c0cb Matthew Sakai 2023-11-16  974  	data_vio = get_available_data_vio(pool);
79535a7881c0cb Matthew Sakai 2023-11-16  975  	spin_unlock(&pool->lock);
79535a7881c0cb Matthew Sakai 2023-11-16  976  	launch_bio(pool->completion.vdo, data_vio, bio);
79535a7881c0cb Matthew Sakai 2023-11-16  977  }
79535a7881c0cb Matthew Sakai 2023-11-16  978

:::::: The code at line 969 was first introduced by commit
:::::: 79535a7881c0cbe95063a2670d840cc950ae9282 dm vdo: add data_vio, the request object which services incoming bios

:::::: TO: Matthew Sakai <msakai@redhat.com>
:::::: CC: Mike Snitzer <snitzer@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

