Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991AA7A1282
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 02:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjIOAsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 20:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjIOAsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 20:48:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63C12700;
        Thu, 14 Sep 2023 17:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694738890; x=1726274890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/Y8tr6+72dx/dGIQEQzCuenUy3CT3AAuLaoi6w6Aa4=;
  b=Zze053DIteOK2ZbYjrABB5HX8yASziIOCb/AM7YnwjthxDnojQ31zRhM
   DE2S7PmA9GFDeETF3H6v2GptCsu3UCQyX4hTXBJL6UZPvj7ywVt3b6IoG
   zwuaXoE5eSFMVlRgK935qs1M+APgW9smEc5n5+V3u4kxQNn771HjDvzVq
   aWmw3cQnsVqyn0xM1QhbaAboyFz1tQXfzKBMMQcH/1HGKAIUJSopXWYQ/
   ZBQzZjHz9rG9+dvNaTTGivfSD/lZTmpgNFnzJFJXFS3sncL7Cjdf/rAro
   Mu8J9dUNHMhM3B8k5z4unSFvapXstZ9VAZuAQNntIdeOTNoQfPmK/Utib
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="410063856"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="410063856"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 17:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="859950717"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="859950717"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2023 17:48:06 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgx07-0002Dx-2Z;
        Fri, 15 Sep 2023 00:48:03 +0000
Date:   Fri, 15 Sep 2023 08:47:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v7 45/49] media: core: Add bitmap manage bufs array
 entries
Message-ID: <202309150835.kxjWQyEU-lkp@intel.com>
References: <20230914133323.198857-46-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914133323.198857-46-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc1]
[cannot apply to next-20230914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Rework-offset-cookie-encoding-pattern/20230914-221757
base:   linus/master
patch link:    https://lore.kernel.org/r/20230914133323.198857-46-benjamin.gaignard%40collabora.com
patch subject: [PATCH v7 45/49] media: core: Add bitmap manage bufs array entries
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230915/202309150835.kxjWQyEU-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150835.kxjWQyEU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309150835.kxjWQyEU-lkp@intel.com/

All errors (new ones prefixed by >>):

   samples/v4l/v4l2-pci-skeleton.c: In function 'queue_setup':
>> samples/v4l/v4l2-pci-skeleton.c:170:15: error: 'struct vb2_queue' has no member named 'num_buffers'
     170 |         if (vq->num_buffers + *nbuffers < 3)
         |               ^~
   samples/v4l/v4l2-pci-skeleton.c:171:35: error: 'struct vb2_queue' has no member named 'num_buffers'
     171 |                 *nbuffers = 3 - vq->num_buffers;
         |                                   ^~
--
   drivers/input/touchscreen/sur40.c: In function 'sur40_queue_setup':
>> drivers/input/touchscreen/sur40.c:851:14: error: 'struct vb2_queue' has no member named 'num_buffers'
     851 |         if (q->num_buffers + *nbuffers < 3)
         |              ^~
   drivers/input/touchscreen/sur40.c:852:34: error: 'struct vb2_queue' has no member named 'num_buffers'
     852 |                 *nbuffers = 3 - q->num_buffers;
         |                                  ^~


vim +170 samples/v4l/v4l2-pci-skeleton.c

926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  145  
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  146  /*
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  147   * Setup the constraints of the queue: besides setting the number of planes
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  148   * per buffer and the size and allocation context of each plane, it also
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  149   * checks if sufficient buffers have been allocated. Usually 3 is a good
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  150   * minimum number: many DMA engines need a minimum of 2 buffers in the
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  151   * queue and you need to have another available for userspace processing.
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  152   */
df9ecb0cad14b9 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2015-10-28  153  static int queue_setup(struct vb2_queue *vq,
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  154  		       unsigned int *nbuffers, unsigned int *nplanes,
36c0f8b32c4bd4 samples/v4l/v4l2-pci-skeleton.c               Hans Verkuil 2016-04-15  155  		       unsigned int sizes[], struct device *alloc_devs[])
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  156  {
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  157  	struct skeleton *skel = vb2_get_drv_priv(vq);
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  158  
5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  159  	skel->field = skel->format.field;
5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  160  	if (skel->field == V4L2_FIELD_ALTERNATE) {
5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  161  		/*
5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  162  		 * You cannot use read() with FIELD_ALTERNATE since the field
5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  163  		 * information (TOP/BOTTOM) cannot be passed back to the user.
5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  164  		 */
3130a28a1568b1 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-23  165  		if (vb2_fileio_is_active(vq))
5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  166  			return -EINVAL;
5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  167  		skel->field = V4L2_FIELD_TOP;
5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  168  	}
5f26f2501b8119 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-04-11  169  
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14 @170  	if (vq->num_buffers + *nbuffers < 3)
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  171  		*nbuffers = 3 - vq->num_buffers;
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  172  
df9ecb0cad14b9 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2015-10-28  173  	if (*nplanes)
df9ecb0cad14b9 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2015-10-28  174  		return sizes[0] < skel->format.sizeimage ? -EINVAL : 0;
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  175  	*nplanes = 1;
df9ecb0cad14b9 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2015-10-28  176  	sizes[0] = skel->format.sizeimage;
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  177  	return 0;
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  178  }
926977e0ae7556 Documentation/video4linux/v4l2-pci-skeleton.c Hans Verkuil 2014-03-14  179  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
