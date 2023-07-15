Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D251754C0F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGOU6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGOU6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 16:58:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906E81A6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689454687; x=1720990687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4Mqwu2IxW2UaP3zgmqUXAP0DHmurSN6c8Z8/cPZtsLk=;
  b=G/3QOK6XSauEGfkiQWkQ+/b9g8qVocc4gTmz1LtSqVRAoibxNb8ImVZj
   Hq+pc9ZOaC+dg3QiUN4aZD9QtBDyG9poAI8lO37xlJVYMNCOXhVM2/vEt
   NYd09ixJkUrxe+TMJ/IHk8YBeap9vVLVaRxIu4dsLDQIOR1AigiP5KCpu
   2Iqixzb4O+xxZpUX2E4+nvQWlSeal08Db47SgksN6d4NhOb2TYiH+r2a0
   IbKWU9S7CGmDVsw/FczuX+0nN3ABePEjqZrwBIo565flh0a4hIytSwWsf
   cyVuWVoc4eEgDaSVPdksVOmYyClXqzm+OpVMSDk9e5xb24eKZcBLshS1r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="350565182"
X-IronPort-AV: E=Sophos;i="6.01,209,1684825200"; 
   d="scan'208";a="350565182"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 13:58:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="722766511"
X-IronPort-AV: E=Sophos;i="6.01,209,1684825200"; 
   d="scan'208";a="722766511"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2023 13:58:06 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKmL7-0008MH-1P;
        Sat, 15 Jul 2023 20:58:05 +0000
Date:   Sun, 16 Jul 2023 04:57:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202307160417.65ygNVzI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   831fe284d8275987596b7d640518dddba5735f61
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   11 months ago
config: loongarch-randconfig-r093-20230716 (https://download.01.org/0day-ci/archive/20230716/202307160417.65ygNVzI-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230716/202307160417.65ygNVzI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307160417.65ygNVzI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got int [noderef] __percpu *

vim +165 drivers/media/usb/uvc/uvc_queue.c

66847ef013cc4e drivers/media/video/uvc/uvc_queue.c Laurent Pinchart 2011-09-24  158  
a11a03e50b7323 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  159  static int uvc_start_streaming(struct vb2_queue *vq, unsigned int count)
a11a03e50b7323 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  160  {
a11a03e50b7323 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  161  	struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
a11a03e50b7323 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  162  	struct uvc_streaming *stream = uvc_queue_to_stream(queue);
ef33d901db3026 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  163  	int ret;
a11a03e50b7323 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  164  
c50c9c1e659d8d drivers/media/usb/uvc/uvc_queue.c   Kieran Bingham   2018-01-03 @165  	lockdep_assert_irqs_enabled();
c50c9c1e659d8d drivers/media/usb/uvc/uvc_queue.c   Kieran Bingham   2018-01-03  166  
a11a03e50b7323 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  167  	queue->buf_used = 0;
a11a03e50b7323 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  168  
571e70dbd42105 drivers/media/usb/uvc/uvc_queue.c   Kieran Bingham   2018-11-05  169  	ret = uvc_video_start_streaming(stream);
ef33d901db3026 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  170  	if (ret == 0)
ef33d901db3026 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  171  		return 0;
ef33d901db3026 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  172  
c50c9c1e659d8d drivers/media/usb/uvc/uvc_queue.c   Kieran Bingham   2018-01-03  173  	spin_lock_irq(&queue->irqlock);
ef33d901db3026 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  174  	uvc_queue_return_buffers(queue, UVC_BUF_STATE_QUEUED);
c50c9c1e659d8d drivers/media/usb/uvc/uvc_queue.c   Kieran Bingham   2018-01-03  175  	spin_unlock_irq(&queue->irqlock);
ef33d901db3026 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  176  
ef33d901db3026 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  177  	return ret;
a11a03e50b7323 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  178  }
a11a03e50b7323 drivers/media/usb/uvc/uvc_queue.c   Laurent Pinchart 2014-10-21  179  

:::::: The code at line 165 was first introduced by commit
:::::: c50c9c1e659d8de9c13441f243e7938413be6e71 media: uvcvideo: queue: Simplify spin-lock usage

:::::: TO: Kieran Bingham <kieran.bingham@ideasonboard.com>
:::::: CC: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
