Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA77379F1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjIMTZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjIMTZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:25:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF2E1999
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694633100; x=1726169100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2riCU2MuRiKv5KzWGqh8XLuGMfVgNylN3CPlHBkuvbs=;
  b=l4bZyZQFxJVKDsAixl7Au2/SOVf/p3whZUV8039Fo42VAHFC54rEJVj2
   Jf1s2YEdHPRNrmvYNhp6uELLvI3UAXmSuiEIqWug/eSBMBKl98LIhTMXU
   0wmJ2KrNRjUJ0UeHC/TcD8x+BI94m43EvHXg5sHkZuZnIkvBnl9iwadte
   lUHzG29AKO55iP2H/MLsEZQ/tWOlPjj/IToIscaUEiJ0GsWQM5t2oQ0bc
   ZF5QOR+dxMHxqJ849XExs+DIoa48RypSbVLX6SGI6h8ToxWxQBn+v4tYQ
   5ocy98HspPF3T+VIDkYPRez/C/8DwZpef2l4XyAJnFZ6v49llyo1rmlLG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="376100064"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="376100064"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 12:25:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="737646238"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="737646238"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Sep 2023 12:24:58 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgVTs-0000W1-2S;
        Wed, 13 Sep 2023 19:24:56 +0000
Date:   Thu, 14 Sep 2023 03:23:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: drivers/gpu/drm/nouveau/nouveau_fence.c:210:45: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202309140340.BwKXzaDx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3669558bdf354cd352be955ef2764cde6a9bf5ec
commit: 978474dc8278f661930e02e08d292a45a45fa01a drm/nouveau: fence: fix undefined fence state after emit
date:   2 weeks ago
config: i386-randconfig-062-20230913 (https://download.01.org/0day-ci/archive/20230914/202309140340.BwKXzaDx-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140340.BwKXzaDx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140340.BwKXzaDx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/nouveau_fence.c:210:45: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct nouveau_channel *chan @@     got struct nouveau_channel [noderef] __rcu *channel @@
   drivers/gpu/drm/nouveau/nouveau_fence.c:210:45: sparse:     expected struct nouveau_channel *chan
   drivers/gpu/drm/nouveau/nouveau_fence.c:210:45: sparse:     got struct nouveau_channel [noderef] __rcu *channel
   drivers/gpu/drm/nouveau/nouveau_fence.c:418:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct nouveau_channel [noderef] __rcu *channel @@     got struct nouveau_channel *chan @@
   drivers/gpu/drm/nouveau/nouveau_fence.c:418:24: sparse:     expected struct nouveau_channel [noderef] __rcu *channel
   drivers/gpu/drm/nouveau/nouveau_fence.c:418:24: sparse:     got struct nouveau_channel *chan

vim +210 drivers/gpu/drm/nouveau/nouveau_fence.c

   206	
   207	int
   208	nouveau_fence_emit(struct nouveau_fence *fence)
   209	{
 > 210		struct nouveau_channel *chan = fence->channel;
   211		struct nouveau_fence_chan *fctx = chan->fence;
   212		struct nouveau_fence_priv *priv = (void*)chan->drm->fence;
   213		int ret;
   214	
   215		fence->timeout  = jiffies + (15 * HZ);
   216	
   217		if (priv->uevent)
   218			dma_fence_init(&fence->base, &nouveau_fence_ops_uevent,
   219				       &fctx->lock, fctx->context, ++fctx->sequence);
   220		else
   221			dma_fence_init(&fence->base, &nouveau_fence_ops_legacy,
   222				       &fctx->lock, fctx->context, ++fctx->sequence);
   223		kref_get(&fctx->fence_ref);
   224	
   225		ret = fctx->emit(fence);
   226		if (!ret) {
   227			dma_fence_get(&fence->base);
   228			spin_lock_irq(&fctx->lock);
   229	
   230			if (unlikely(fctx->killed)) {
   231				spin_unlock_irq(&fctx->lock);
   232				dma_fence_put(&fence->base);
   233				return -ENODEV;
   234			}
   235	
   236			if (nouveau_fence_update(chan, fctx))
   237				nvif_event_block(&fctx->event);
   238	
   239			list_add_tail(&fence->head, &fctx->pending);
   240			spin_unlock_irq(&fctx->lock);
   241		}
   242	
   243		return ret;
   244	}
   245	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
