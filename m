Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584C07A60B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjISLH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjISLHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:07:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AD4E7F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695121628; x=1726657628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5kZItU4QIcdjDQRcui76dXHwtannf/DU6tqOo8ATvcA=;
  b=PAoZpnGPNLFG/cNyTZtvd+ImM8x80/dUEIbQ4dTZHJ1OzMXSs9xb4YB+
   0T2w4ACHuhLFESEaS9j1VQL/l62gar945UsXVMxhCfFLTBFyI0Pwyaekh
   871bbXhsUaN7XSVhiPCyCuWUE5IMdZJoPw/164F3lXVtEd62bT5rGEiKa
   cxIAflEznT+FUN4nYv8H2eGdbFW6BpmkfOv9Kp/MXC98nrW1gBSb46A0T
   NL0dQzy3UOYbm7MOuJLWYDxYm0uKbu5+X1+HNLSrzWtNbOskB+L5fTXvl
   dtkxrsuJBRDpbWKtZn+ybGdtztBEgJnk8Iyr2ZuUR5r8A/QJ9bKN7gmWX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446384873"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="446384873"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 04:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="836394700"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="836394700"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Sep 2023 04:07:06 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiYZL-0007Fs-2h;
        Tue, 19 Sep 2023 11:07:03 +0000
Date:   Tue, 19 Sep 2023 19:06:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sound/core/ump.c:676:25: warning: array subscript 'struct
 snd_ump_block_info[0]' is partly outside array bounds of 'char[20]'
Message-ID: <202309191806.9xysweCr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: 4a16a3af05712e7fd5a205f34e2908055bd9fb5e ALSA: seq: ump: Handle FB info update
date:   3 months ago
config: x86_64-randconfig-004-20230919 (https://download.01.org/0day-ci/archive/20230919/202309191806.9xysweCr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309191806.9xysweCr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309191806.9xysweCr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'fill_fb_info',
       inlined from 'is_fb_info_updated.constprop' at sound/core/ump.c:699:2:
>> sound/core/ump.c:676:25: warning: array subscript 'struct snd_ump_block_info[0]' is partly outside array bounds of 'char[20]' [-Warray-bounds]
     676 |         info->direction = buf->fb_info.direction;
         |         ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/ump.c: In function 'is_fb_info_updated.constprop':
   sound/core/ump.c:696:14: note: object 'tmpbuf' of size 20
     696 |         char tmpbuf[offsetof(struct snd_ump_block_info, name)];
         |              ^~~~~~
   In function 'fill_fb_info',
       inlined from 'is_fb_info_updated.constprop' at sound/core/ump.c:699:2:
   sound/core/ump.c:677:23: warning: array subscript 'struct snd_ump_block_info[0]' is partly outside array bounds of 'char[20]' [-Warray-bounds]
     677 |         info->ui_hint = buf->fb_info.ui_hint;
         |         ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   sound/core/ump.c: In function 'is_fb_info_updated.constprop':
   sound/core/ump.c:696:14: note: object 'tmpbuf' of size 20
     696 |         char tmpbuf[offsetof(struct snd_ump_block_info, name)];
         |              ^~~~~~
   In function 'fill_fb_info',
       inlined from 'is_fb_info_updated.constprop' at sound/core/ump.c:699:2:
   sound/core/ump.c:678:27: warning: array subscript 'struct snd_ump_block_info[0]' is partly outside array bounds of 'char[20]' [-Warray-bounds]
     678 |         info->first_group = buf->fb_info.first_group;
         |         ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/ump.c: In function 'is_fb_info_updated.constprop':
   sound/core/ump.c:696:14: note: object 'tmpbuf' of size 20
     696 |         char tmpbuf[offsetof(struct snd_ump_block_info, name)];
         |              ^~~~~~
   In function 'fill_fb_info',
       inlined from 'is_fb_info_updated.constprop' at sound/core/ump.c:699:2:
   sound/core/ump.c:679:26: warning: array subscript 'struct snd_ump_block_info[0]' is partly outside array bounds of 'char[20]' [-Warray-bounds]
     679 |         info->num_groups = buf->fb_info.num_groups;
         |         ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/ump.c: In function 'is_fb_info_updated.constprop':
   sound/core/ump.c:696:14: note: object 'tmpbuf' of size 20
     696 |         char tmpbuf[offsetof(struct snd_ump_block_info, name)];
         |              ^~~~~~
   In function 'fill_fb_info',
       inlined from 'is_fb_info_updated.constprop' at sound/core/ump.c:699:2:
   sound/core/ump.c:680:21: warning: array subscript 'struct snd_ump_block_info[0]' is partly outside array bounds of 'char[20]' [-Warray-bounds]
     680 |         info->flags = buf->fb_info.midi_10;
         |         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   sound/core/ump.c: In function 'is_fb_info_updated.constprop':
   sound/core/ump.c:696:14: note: object 'tmpbuf' of size 20
     696 |         char tmpbuf[offsetof(struct snd_ump_block_info, name)];
         |              ^~~~~~
   In function 'fill_fb_info',
       inlined from 'is_fb_info_updated.constprop' at sound/core/ump.c:699:2:
   sound/core/ump.c:681:22: warning: array subscript 'struct snd_ump_block_info[0]' is partly outside array bounds of 'char[20]' [-Warray-bounds]
     681 |         info->active = buf->fb_info.active;
         |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
   sound/core/ump.c: In function 'is_fb_info_updated.constprop':
   sound/core/ump.c:696:14: note: object 'tmpbuf' of size 20
     696 |         char tmpbuf[offsetof(struct snd_ump_block_info, name)];
         |              ^~~~~~
   In function 'fill_fb_info',
       inlined from 'is_fb_info_updated.constprop' at sound/core/ump.c:699:2:
   sound/core/ump.c:682:31: warning: array subscript 'struct snd_ump_block_info[0]' is partly outside array bounds of 'char[20]' [-Warray-bounds]
     682 |         info->midi_ci_version = buf->fb_info.midi_ci_version;
         |         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/ump.c: In function 'is_fb_info_updated.constprop':
   sound/core/ump.c:696:14: note: object 'tmpbuf' of size 20
     696 |         char tmpbuf[offsetof(struct snd_ump_block_info, name)];
         |              ^~~~~~
   In function 'fill_fb_info',
       inlined from 'is_fb_info_updated.constprop' at sound/core/ump.c:699:2:
   sound/core/ump.c:683:30: warning: array subscript 'struct snd_ump_block_info[0]' is partly outside array bounds of 'char[20]' [-Warray-bounds]
     683 |         info->sysex8_streams = buf->fb_info.sysex8_streams;
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/ump.c: In function 'is_fb_info_updated.constprop':
   sound/core/ump.c:696:14: note: object 'tmpbuf' of size 20
     696 |         char tmpbuf[offsetof(struct snd_ump_block_info, name)];
         |              ^~~~~~


vim +676 sound/core/ump.c

37e0e14128e068 Takashi Iwai 2023-06-12  670  
37e0e14128e068 Takashi Iwai 2023-06-12  671  /* Extract Function Block info from UMP packet */
37e0e14128e068 Takashi Iwai 2023-06-12  672  static void fill_fb_info(struct snd_ump_endpoint *ump,
37e0e14128e068 Takashi Iwai 2023-06-12  673  			 struct snd_ump_block_info *info,
37e0e14128e068 Takashi Iwai 2023-06-12  674  			 const union snd_ump_stream_msg *buf)
37e0e14128e068 Takashi Iwai 2023-06-12  675  {
37e0e14128e068 Takashi Iwai 2023-06-12 @676  	info->direction = buf->fb_info.direction;
37e0e14128e068 Takashi Iwai 2023-06-12  677  	info->ui_hint = buf->fb_info.ui_hint;
37e0e14128e068 Takashi Iwai 2023-06-12  678  	info->first_group = buf->fb_info.first_group;
37e0e14128e068 Takashi Iwai 2023-06-12  679  	info->num_groups = buf->fb_info.num_groups;
37e0e14128e068 Takashi Iwai 2023-06-12  680  	info->flags = buf->fb_info.midi_10;
37e0e14128e068 Takashi Iwai 2023-06-12  681  	info->active = buf->fb_info.active;
37e0e14128e068 Takashi Iwai 2023-06-12  682  	info->midi_ci_version = buf->fb_info.midi_ci_version;
37e0e14128e068 Takashi Iwai 2023-06-12  683  	info->sysex8_streams = buf->fb_info.sysex8_streams;
37e0e14128e068 Takashi Iwai 2023-06-12  684  
37e0e14128e068 Takashi Iwai 2023-06-12  685  	ump_dbg(ump, "FB %d: dir=%d, active=%d, first_gp=%d, num_gp=%d, midici=%d, sysex8=%d, flags=0x%x\n",
37e0e14128e068 Takashi Iwai 2023-06-12  686  		info->block_id, info->direction, info->active,
37e0e14128e068 Takashi Iwai 2023-06-12  687  		info->first_group, info->num_groups, info->midi_ci_version,
37e0e14128e068 Takashi Iwai 2023-06-12  688  		info->sysex8_streams, info->flags);
37e0e14128e068 Takashi Iwai 2023-06-12  689  }
37e0e14128e068 Takashi Iwai 2023-06-12  690  

:::::: The code at line 676 was first introduced by commit
:::::: 37e0e14128e0685267dc5c037bf655421a6ce2ea ALSA: ump: Support UMP Endpoint and Function Block parsing

:::::: TO: Takashi Iwai <tiwai@suse.de>
:::::: CC: Takashi Iwai <tiwai@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
