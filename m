Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226CC80BD3B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjLJUiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 15:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJUiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 15:38:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118AFD5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 12:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702240687; x=1733776687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XFXPO+n/Lu8tJ0UlCah9YtoT3mlmYBBj3N7+CPKuZN0=;
  b=VLOLHKX06IG1WB0CvTnPdWpmcqTN5i+XqoJaCNqNIz9YFmWpUTKMmINl
   ++7qflLKGybtDoIMg1bvgvtM5AF5TcUZVC3m+jWLECXyy87k0d9nWvd6v
   ZUDoLTnuG5z0aXnYHFv0VDRE/VRXq6XX2d4m6H/usStvQ3uZkq6iP6jZX
   rWqqUj5KYbfd13vNOy3jI77PWbX+/Eqptkzzr2xKq7nJYnxKlSY3AXO1w
   k/Kk5OLW//gonTCxyTFzOfrCe1ojJhLRTIemFW+QBf+UEOEtzZLUBBp7y
   4L7chKKp4xu70kiGFg0J0w5V2+xRCunPqPMNttt0yGAmfPTF26kWhj6/6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1384242"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="1384242"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 12:38:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="772784450"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="772784450"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2023 12:38:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCQYs-000HFq-3D;
        Sun, 10 Dec 2023 20:38:03 +0000
Date:   Mon, 11 Dec 2023 04:37:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: drivers/virtio/virtio_dma_buf.c:41: warning: Function parameter or
 member 'dma_buf' not described in 'virtio_dma_buf_attach'
Message-ID: <202312110445.z6bDltrY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a87498869d6d1e7347cd01f337a77984604eb5e
commit: a0308938ec81cd0dca9d75833ec0dd1b8708917e virtio: add dma-buf support for exported objects
date:   3 years, 4 months ago
config: parisc-randconfig-m041-20230821 (https://download.01.org/0day-ci/archive/20231211/202312110445.z6bDltrY-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231211/202312110445.z6bDltrY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312110445.z6bDltrY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio_dma_buf.c:41: warning: Function parameter or member 'dma_buf' not described in 'virtio_dma_buf_attach'
>> drivers/virtio/virtio_dma_buf.c:41: warning: Function parameter or member 'attach' not described in 'virtio_dma_buf_attach'


vim +41 drivers/virtio/virtio_dma_buf.c

    35	
    36	/**
    37	 * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
    38	 */
    39	int virtio_dma_buf_attach(struct dma_buf *dma_buf,
    40				  struct dma_buf_attachment *attach)
  > 41	{
    42		int ret;
    43		const struct virtio_dma_buf_ops *ops =
    44			container_of(dma_buf->ops,
    45				     const struct virtio_dma_buf_ops, ops);
    46	
    47		if (ops->device_attach) {
    48			ret = ops->device_attach(dma_buf, attach);
    49			if (ret)
    50				return ret;
    51		}
    52		return 0;
    53	}
    54	EXPORT_SYMBOL(virtio_dma_buf_attach);
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
