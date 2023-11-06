Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32367E19D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjKFF60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKFF6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:58:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7773FFA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 21:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699250301; x=1730786301;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q2ZmzQBpNtwpAvMD47i1PzF5TIpTO6N+xz9imvOpa4Q=;
  b=bfdVpWe52GoNsmvBF8TjVZazy1pbhvj7T8Cixa22cjM/a3GF5CjCyfVi
   pWjQWRsl+ifjvIPpTx9QU8DXCU1nDUI8mAg8KhzGhyDpwbRY2Nu0zIPts
   vVNs5bXhUqZDArEPunwkQto83r6VTUYKerB2UXXHzrXsR6Jf3uzCenmZ7
   sSLZb3Do3h0OX596Ga+Ybg9K/hO+Kpz0gl/S4J3eLbienCRwrS+l+lFk3
   60Oxk0ST1du7MG7rfzuNdCUsUW1CJZ25VixlsVd0EKsTQutZOke3pdCls
   10kpK3Z/Z5rREMTzLoN7jqIFjyDBXVAcR6dygAuG+UbxS41ltWFnVtK70
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="369418559"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="369418559"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 21:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="10347041"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2023 21:58:19 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzscq-0006AK-2X;
        Mon, 06 Nov 2023 05:58:16 +0000
Date:   Mon, 6 Nov 2023 13:57:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Tesarik <petr.tesarik.ext@huawei.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: arch/powerpc/platforms/ps3/device-init.c:771:12: warning: stack
 frame size (2064) exceeds limit (2048) in 'ps3_probe_thread'
Message-ID: <202311061349.D8RrGBz3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: 79636caad3618e2b38457f6e298c9b31ba82b489 swiotlb: if swiotlb is full, fall back to a transient memory pool
date:   3 months ago
config: powerpc64-allyesconfig (https://download.01.org/0day-ci/archive/20231106/202311061349.D8RrGBz3-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061349.D8RrGBz3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061349.D8RrGBz3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/powerpc/platforms/ps3/device-init.c:948:6: warning: variable 'result' set but not used [-Wunused-but-set-variable]
     948 |         int result;
         |             ^
>> arch/powerpc/platforms/ps3/device-init.c:771:12: warning: stack frame size (2064) exceeds limit (2048) in 'ps3_probe_thread' [-Wframe-larger-than]
     771 | static int ps3_probe_thread(void *data)
         |            ^
   2 warnings generated.


vim +/ps3_probe_thread +771 arch/powerpc/platforms/ps3/device-init.c

b4cb2941f85599 Geert Uytterhoeven     2008-01-19  760  
ffbdd246478693 Geoff Levand           2007-06-16  761  /**
ffbdd246478693 Geoff Levand           2007-06-16  762   * ps3_probe_thread - Background repository probing at system startup.
ffbdd246478693 Geoff Levand           2007-06-16  763   *
ffbdd246478693 Geoff Levand           2007-06-16  764   * This implementation only supports background probing on a single bus.
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  765   * It uses the hypervisor's storage device notification mechanism to wait until
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  766   * a storage device is ready.  The device notification mechanism uses a
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  767   * pseudo device to asynchronously notify the guest when storage devices become
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  768   * ready.  The notification device has a block size of 512 bytes.
ffbdd246478693 Geoff Levand           2007-06-16  769   */
ffbdd246478693 Geoff Levand           2007-06-16  770  
ffbdd246478693 Geoff Levand           2007-06-16 @771  static int ps3_probe_thread(void *data)
ffbdd246478693 Geoff Levand           2007-06-16  772  {
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  773  	struct ps3_notification_device dev;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  774  	int res;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  775  	unsigned int irq;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  776  	u64 lpar;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  777  	void *buf;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  778  	struct ps3_notify_cmd *notify_cmd;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  779  	struct ps3_notify_event *notify_event;
ffbdd246478693 Geoff Levand           2007-06-16  780  
ffbdd246478693 Geoff Levand           2007-06-16  781  	pr_debug(" -> %s:%u: kthread started\n", __func__, __LINE__);
ffbdd246478693 Geoff Levand           2007-06-16  782  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  783  	buf = kzalloc(512, GFP_KERNEL);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  784  	if (!buf)
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  785  		return -ENOMEM;
ffbdd246478693 Geoff Levand           2007-06-16  786  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  787  	lpar = ps3_mm_phys_to_lpar(__pa(buf));
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  788  	notify_cmd = buf;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  789  	notify_event = buf;
ffbdd246478693 Geoff Levand           2007-06-16  790  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  791  	/* dummy system bus device */
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  792  	dev.sbd.bus_id = (u64)data;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  793  	dev.sbd.dev_id = PS3_NOTIFICATION_DEV_ID;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  794  	dev.sbd.interrupt_id = PS3_NOTIFICATION_INTERRUPT_ID;
ffbdd246478693 Geoff Levand           2007-06-16  795  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  796  	res = lv1_open_device(dev.sbd.bus_id, dev.sbd.dev_id, 0);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  797  	if (res) {
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  798  		pr_err("%s:%u: lv1_open_device failed %s\n", __func__,
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  799  		       __LINE__, ps3_result(res));
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  800  		goto fail_free;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  801  	}
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  802  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  803  	res = ps3_sb_event_receive_port_setup(&dev.sbd, PS3_BINDING_CPU_ANY,
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  804  					      &irq);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  805  	if (res) {
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  806  		pr_err("%s:%u: ps3_sb_event_receive_port_setup failed %d\n",
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  807  		       __func__, __LINE__, res);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  808  	       goto fail_close_device;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  809  	}
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  810  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  811  	spin_lock_init(&dev.lock);
e21fee5368f46e Peter Zijlstra (Intel  2020-03-21  812) 	rcuwait_init(&dev.wait);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  813  
a3a9f3b47d12b5 Yong Zhang             2011-10-21  814  	res = request_irq(irq, ps3_notification_interrupt, 0,
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  815  			  "ps3_notification", &dev);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  816  	if (res) {
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  817  		pr_err("%s:%u: request_irq failed %d\n", __func__, __LINE__,
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  818  		       res);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  819  		goto fail_sb_event_receive_port_destroy;
ffbdd246478693 Geoff Levand           2007-06-16  820  	}
ffbdd246478693 Geoff Levand           2007-06-16  821  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  822  	/* Setup and write the request for device notification. */
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  823  	notify_cmd->operation_code = 0; /* must be zero */
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  824  	notify_cmd->event_mask = 1UL << notify_region_probe;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  825  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  826  	res = ps3_notification_read_write(&dev, lpar, 1);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  827  	if (res)
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  828  		goto fail_free_irq;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  829  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  830  	/* Loop here processing the requested notification events. */
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  831  	do {
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  832  		try_to_freeze();
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  833  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  834  		memset(notify_event, 0, sizeof(*notify_event));
ffbdd246478693 Geoff Levand           2007-06-16  835  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  836  		res = ps3_notification_read_write(&dev, lpar, 0);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  837  		if (res)
ffbdd246478693 Geoff Levand           2007-06-16  838  			break;
ffbdd246478693 Geoff Levand           2007-06-16  839  
5c949070c7a591 Stephen Rothwell       2009-01-13  840  		pr_debug("%s:%u: notify event type 0x%llx bus id %llu dev id %llu"
5c949070c7a591 Stephen Rothwell       2009-01-13  841  			 " type %llu port %llu\n", __func__, __LINE__,
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  842  			 notify_event->event_type, notify_event->bus_id,
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  843  			 notify_event->dev_id, notify_event->dev_type,
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  844  			 notify_event->dev_port);
ffbdd246478693 Geoff Levand           2007-06-16  845  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  846  		if (notify_event->event_type != notify_region_probe ||
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  847  		    notify_event->bus_id != dev.sbd.bus_id) {
f2c2cbcc35d47f Joe Perches            2016-10-24  848  			pr_warn("%s:%u: bad notify_event: event %llu, dev_id %llu, dev_type %llu\n",
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  849  				__func__, __LINE__, notify_event->event_type,
f2c2cbcc35d47f Joe Perches            2016-10-24  850  				notify_event->dev_id, notify_event->dev_type);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  851  			continue;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  852  		}
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  853  
972b1f040c8698 Geert Uytterhoeven     2008-01-19  854  		ps3_find_and_add_device(dev.sbd.bus_id, notify_event->dev_id);
ffbdd246478693 Geoff Levand           2007-06-16  855  
ffbdd246478693 Geoff Levand           2007-06-16  856  	} while (!kthread_should_stop());
ffbdd246478693 Geoff Levand           2007-06-16  857  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  858  fail_free_irq:
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  859  	free_irq(irq, &dev);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  860  fail_sb_event_receive_port_destroy:
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  861  	ps3_sb_event_receive_port_destroy(&dev.sbd, irq);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  862  fail_close_device:
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  863  	lv1_close_device(dev.sbd.bus_id, dev.sbd.dev_id);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  864  fail_free:
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  865  	kfree(buf);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  866  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  867  	probe_task = NULL;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  868  
ffbdd246478693 Geoff Levand           2007-06-16  869  	pr_debug(" <- %s:%u: kthread finished\n", __func__, __LINE__);
ffbdd246478693 Geoff Levand           2007-06-16  870  
ffbdd246478693 Geoff Levand           2007-06-16  871  	return 0;
ffbdd246478693 Geoff Levand           2007-06-16  872  }
ffbdd246478693 Geoff Levand           2007-06-16  873  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  874  /**
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  875   * ps3_stop_probe_thread - Stops the background probe thread.
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  876   *
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  877   */
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  878  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  879  static int ps3_stop_probe_thread(struct notifier_block *nb, unsigned long code,
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  880  				 void *data)
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  881  {
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  882  	if (probe_task)
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  883  		kthread_stop(probe_task);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  884  	return 0;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  885  }
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  886  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  887  static struct notifier_block nb = {
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  888  	.notifier_call = ps3_stop_probe_thread
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  889  };
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  890  
ffbdd246478693 Geoff Levand           2007-06-16  891  /**
ffbdd246478693 Geoff Levand           2007-06-16  892   * ps3_start_probe_thread - Starts the background probe thread.
ffbdd246478693 Geoff Levand           2007-06-16  893   *
ffbdd246478693 Geoff Levand           2007-06-16  894   */
ffbdd246478693 Geoff Levand           2007-06-16  895  
ffbdd246478693 Geoff Levand           2007-06-16  896  static int __init ps3_start_probe_thread(enum ps3_bus_type bus_type)
ffbdd246478693 Geoff Levand           2007-06-16  897  {
ffbdd246478693 Geoff Levand           2007-06-16  898  	int result;
ffbdd246478693 Geoff Levand           2007-06-16  899  	struct task_struct *task;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  900  	struct ps3_repository_device repo;
ffbdd246478693 Geoff Levand           2007-06-16  901  
ffbdd246478693 Geoff Levand           2007-06-16  902  	pr_debug(" -> %s:%d\n", __func__, __LINE__);
ffbdd246478693 Geoff Levand           2007-06-16  903  
ffbdd246478693 Geoff Levand           2007-06-16  904  	memset(&repo, 0, sizeof(repo));
ffbdd246478693 Geoff Levand           2007-06-16  905  
ffbdd246478693 Geoff Levand           2007-06-16  906  	repo.bus_type = bus_type;
ffbdd246478693 Geoff Levand           2007-06-16  907  
ffbdd246478693 Geoff Levand           2007-06-16  908  	result = ps3_repository_find_bus(repo.bus_type, 0, &repo.bus_index);
ffbdd246478693 Geoff Levand           2007-06-16  909  
ffbdd246478693 Geoff Levand           2007-06-16  910  	if (result) {
ffbdd246478693 Geoff Levand           2007-06-16  911  		printk(KERN_ERR "%s: Cannot find bus (%d)\n", __func__, result);
ffbdd246478693 Geoff Levand           2007-06-16  912  		return -ENODEV;
ffbdd246478693 Geoff Levand           2007-06-16  913  	}
ffbdd246478693 Geoff Levand           2007-06-16  914  
ffbdd246478693 Geoff Levand           2007-06-16  915  	result = ps3_repository_read_bus_id(repo.bus_index, &repo.bus_id);
ffbdd246478693 Geoff Levand           2007-06-16  916  
ffbdd246478693 Geoff Levand           2007-06-16  917  	if (result) {
ffbdd246478693 Geoff Levand           2007-06-16  918  		printk(KERN_ERR "%s: read_bus_id failed %d\n", __func__,
ffbdd246478693 Geoff Levand           2007-06-16  919  			result);
ffbdd246478693 Geoff Levand           2007-06-16  920  		return -ENODEV;
ffbdd246478693 Geoff Levand           2007-06-16  921  	}
ffbdd246478693 Geoff Levand           2007-06-16  922  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  923  	task = kthread_run(ps3_probe_thread, (void *)repo.bus_id,
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  924  			   "ps3-probe-%u", bus_type);
ffbdd246478693 Geoff Levand           2007-06-16  925  
ffbdd246478693 Geoff Levand           2007-06-16  926  	if (IS_ERR(task)) {
ffbdd246478693 Geoff Levand           2007-06-16  927  		result = PTR_ERR(task);
ffbdd246478693 Geoff Levand           2007-06-16  928  		printk(KERN_ERR "%s: kthread_run failed %d\n", __func__,
ffbdd246478693 Geoff Levand           2007-06-16  929  		       result);
ffbdd246478693 Geoff Levand           2007-06-16  930  		return result;
ffbdd246478693 Geoff Levand           2007-06-16  931  	}
ffbdd246478693 Geoff Levand           2007-06-16  932  
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  933  	probe_task = task;
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  934  	register_reboot_notifier(&nb);
b4cb2941f85599 Geert Uytterhoeven     2008-01-19  935  
ffbdd246478693 Geoff Levand           2007-06-16  936  	pr_debug(" <- %s:%d\n", __func__, __LINE__);
ffbdd246478693 Geoff Levand           2007-06-16  937  	return 0;
ffbdd246478693 Geoff Levand           2007-06-16  938  }
ffbdd246478693 Geoff Levand           2007-06-16  939  
ffbdd246478693 Geoff Levand           2007-06-16  940  /**
ffbdd246478693 Geoff Levand           2007-06-16  941   * ps3_register_devices - Probe the system and register devices found.
ffbdd246478693 Geoff Levand           2007-06-16  942   *
ffbdd246478693 Geoff Levand           2007-06-16  943   * A device_initcall() routine.
ffbdd246478693 Geoff Levand           2007-06-16  944   */
ffbdd246478693 Geoff Levand           2007-06-16  945  
ffbdd246478693 Geoff Levand           2007-06-16  946  static int __init ps3_register_devices(void)
ffbdd246478693 Geoff Levand           2007-06-16  947  {
ffbdd246478693 Geoff Levand           2007-06-16 @948  	int result;
ffbdd246478693 Geoff Levand           2007-06-16  949  
ffbdd246478693 Geoff Levand           2007-06-16  950  	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
ffbdd246478693 Geoff Levand           2007-06-16  951  		return -ENODEV;
ffbdd246478693 Geoff Levand           2007-06-16  952  
ffbdd246478693 Geoff Levand           2007-06-16  953  	pr_debug(" -> %s:%d\n", __func__, __LINE__);
ffbdd246478693 Geoff Levand           2007-06-16  954  
ffbdd246478693 Geoff Levand           2007-06-16  955  	/* ps3_repository_dump_bus_info(); */
ffbdd246478693 Geoff Levand           2007-06-16  956  
ffbdd246478693 Geoff Levand           2007-06-16  957  	result = ps3_start_probe_thread(PS3_BUS_TYPE_STORAGE);
ffbdd246478693 Geoff Levand           2007-06-16  958  
ffbdd246478693 Geoff Levand           2007-06-16  959  	ps3_register_vuart_devices();
ffbdd246478693 Geoff Levand           2007-06-16  960  
ffbdd246478693 Geoff Levand           2007-06-16  961  	ps3_register_graphics_devices();
ffbdd246478693 Geoff Levand           2007-06-16  962  
b163a256dac8ce Geert Uytterhoeven     2008-03-29  963  	ps3_repository_find_devices(PS3_BUS_TYPE_SB, ps3_setup_static_device);
ffbdd246478693 Geoff Levand           2007-06-16  964  
ffbdd246478693 Geoff Levand           2007-06-16  965  	ps3_register_sound_devices();
ffbdd246478693 Geoff Levand           2007-06-16  966  
ed7570022a42a6 Geoff Levand           2008-01-19  967  	ps3_register_lpm_devices();
ed7570022a42a6 Geoff Levand           2008-01-19  968  
cffb4add03b1fc Jim Paris              2009-01-06  969  	ps3_register_ramdisk_device();
cffb4add03b1fc Jim Paris              2009-01-06  970  
ffbdd246478693 Geoff Levand           2007-06-16  971  	pr_debug(" <- %s:%d\n", __func__, __LINE__);
ffbdd246478693 Geoff Levand           2007-06-16  972  	return 0;
ffbdd246478693 Geoff Levand           2007-06-16  973  }
ffbdd246478693 Geoff Levand           2007-06-16  974  

:::::: The code at line 771 was first introduced by commit
:::::: ffbdd246478693673adcfe1c34b29714cf25dadd [POWERPC] PS3: Device registration routines.

:::::: TO: Geoff Levand <geoffrey.levand@am.sony.com>
:::::: CC: Paul Mackerras <paulus@samba.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
