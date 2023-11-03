Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BA57E078E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjKCRhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjKCRhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:37:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8D3136
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699033033; x=1730569033;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7KJooKNsl5xSOp/w9r0lHX9FUUzG2PkGtQPfNPAX2J8=;
  b=iWjS1FWVtO7/zL1Tq1z1FEMY4ndf8rF3fnwa01M9/8Fti7W8M6cw9JsU
   CeVSdsK/xKJlA0+qA6k9N0wrSaZxJ6JKOH2MwQjYipjv4Wz9LvVi8tjiZ
   ngf7v3a4e0N6W8sC3KTCmQyLcCqzsO7iyR1QCp7CYEEQb+y5BUa3x3UUl
   IpE9cFRxJa2wZofVCBoFwLhR0scnVEKosid+o06dqtwVPzPDQjgbYAfVT
   WJvhP15i4DgA6BWvuak6vaC39YyGM5S+4V4t4tEQcYn7IvpXmC4DSgs+Q
   8fbzOFtT7iHx9kynLsdhV3rSeU4Df/nk/Zk2asrviBpnrq3ctELVpHcxp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="10524249"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="10524249"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 10:37:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="9809121"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 03 Nov 2023 10:37:11 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyy6W-0002lx-2x;
        Fri, 03 Nov 2023 17:37:08 +0000
Date:   Sat, 4 Nov 2023 01:36:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:40:17: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <202311040149.o3KPXEV2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
commit: 57cbdbe65e5f9ba9bfd67b66bc3ce24ef1c54643 drm/nouveau/kms/nv140-: Use hard-coded wndws or core channel for CRC channel
date:   2 years ago
config: x86_64-randconfig-123-20231101 (https://download.01.org/0day-ci/archive/20231104/202311040149.o3KPXEV2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040149.o3KPXEV2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040149.o3KPXEV2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:40:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:40:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:41:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:41:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:43:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:43:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:44:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:44:17: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +40 drivers/gpu/drm/nouveau/dispnv50/crcc57d.c

    12	
    13	static int crcc57d_set_src(struct nv50_head *head, int or, enum nv50_crc_source_type source,
    14				   struct nv50_crc_notifier_ctx *ctx)
    15	{
    16		struct nvif_push *push = nv50_disp(head->base.base.dev)->core->chan.push;
    17		const int i = head->base.index;
    18		u32 crc_args = NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, CONTROLLING_CHANNEL, CORE) |
    19			       NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, EXPECT_BUFFER_COLLAPSE, FALSE) |
    20			       NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, SECONDARY_CRC, NONE) |
    21			       NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, CRC_DURING_SNOOZE, DISABLE);
    22		int ret;
    23	
    24		switch (source) {
    25		case NV50_CRC_SOURCE_TYPE_SOR:
    26			crc_args |= NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, PRIMARY_CRC, SOR(or));
    27			break;
    28		case NV50_CRC_SOURCE_TYPE_SF:
    29			crc_args |= NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, PRIMARY_CRC, SF);
    30			break;
    31		default:
    32			break;
    33		}
    34	
    35		ret = PUSH_WAIT(push, 4);
    36		if (ret)
    37			return ret;
    38	
    39		if (source) {
  > 40			PUSH_MTHD(push, NVC57D, HEAD_SET_CONTEXT_DMA_CRC(i), ctx->ntfy.handle);
    41			PUSH_MTHD(push, NVC57D, HEAD_SET_CRC_CONTROL(i), crc_args);
    42		} else {
    43			PUSH_MTHD(push, NVC57D, HEAD_SET_CRC_CONTROL(i), 0);
    44			PUSH_MTHD(push, NVC57D, HEAD_SET_CONTEXT_DMA_CRC(i), 0);
    45		}
    46	
    47		return 0;
    48	}
    49	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
