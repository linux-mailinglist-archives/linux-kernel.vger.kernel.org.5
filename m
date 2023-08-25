Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F294788F28
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjHYTG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHYTGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:06:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277EE268F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692990362; x=1724526362;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YJJi/wemdxksBbsikAZ6LBPaPSymRL1BwFr09SiXHcY=;
  b=C3FiU92OeD0bKROf5yK/EqSPl06yZvwTotHdEazvoBl8ztc1KGQQc4tg
   CyJP0aqYQ41Q8WhHGDLs4s7TgeqzrZkLH7s5qBHu8l31IcTE9Vk2WUUcv
   IkqGsln8h4OLQNq7ZZYSIE8SZ1WSG9S2adGc/+ztCKlDOs22h4fPsZiLv
   OA4Ts9VCf5GSGMIuv6Jyo2xAHO29pka+w86QUndwbkWv+Vbzw5NXuJQGZ
   alqBPGT8yf73oRIwXcHZF2/gdrFQGkn/HXS/Cmh6pruQCmBhrZN6xa/Es
   Baib8A4ripakgRIHm1ItvLHEGZBlB88oaIkPz2O2MtwtVtL1ylrFVp7Vt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="461145630"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="461145630"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 12:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="772584200"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="772584200"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Aug 2023 12:05:59 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZc86-0003vF-29;
        Fri, 25 Aug 2023 19:05:58 +0000
Date:   Sat, 26 Aug 2023 03:05:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steve French <stfrench@microsoft.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: fs/smb/client/sess.c:160:5: warning: stack frame size (1152) exceeds
 limit (1024) in 'cifs_try_adding_channels'
Message-ID: <202308260234.njSK5nHi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4942fed84b98cfb71d3cdff1a3df0072a57bbdfa
commit: 38c8a9a52082579090e34c033d439ed2cd1a462d smb: move client and server files to common directory fs/smb
date:   3 months ago
config: mips-loongson2k_defconfig (https://download.01.org/0day-ci/archive/20230826/202308260234.njSK5nHi-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308260234.njSK5nHi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308260234.njSK5nHi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/smb/client/sess.c:160:5: warning: stack frame size (1152) exceeds limit (1024) in 'cifs_try_adding_channels' [-Wframe-larger-than]
     160 | int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses)
         |     ^
   1 warning generated.


vim +/cifs_try_adding_channels +160 fs/smb/client/sess.c

b54034a73baf9f fs/cifs/sess.c Shyam Prasad N  2022-01-03  158  
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  159  /* returns number of channels added */
387ec58f339b0c fs/cifs/sess.c Ronnie Sahlberg 2020-12-14 @160  int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses)
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  161  {
90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  162  	struct TCP_Server_Info *server = ses->server;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  163  	int old_chan_count, new_chan_count;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  164  	int left;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  165  	int rc = 0;
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  166  	int tries = 0;
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  167  	struct cifs_server_iface *iface = NULL, *niface = NULL;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  168  
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  169  	spin_lock(&ses->chan_lock);
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  170  
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  171  	new_chan_count = old_chan_count = ses->chan_count;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  172  	left = ses->chan_max - ses->chan_count;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  173  
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  174  	if (left <= 0) {
88b024f556fcd5 fs/cifs/sess.c Shyam Prasad N  2021-11-19  175  		spin_unlock(&ses->chan_lock);
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  176  		cifs_dbg(FYI,
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  177  			 "ses already at max_channels (%zu), nothing to open\n",
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  178  			 ses->chan_max);
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  179  		return 0;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  180  	}
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  181  
90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  182  	if (server->dialect < SMB30_PROT_ID) {
53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  183  		spin_unlock(&ses->chan_lock);
53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  184  		cifs_dbg(VFS, "multichannel is not supported on this protocol version, use 3.0 or above\n");
53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  185  		return 0;
53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  186  	}
53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  187  
90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  188  	if (!(server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  189  		ses->chan_max = 1;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  190  		spin_unlock(&ses->chan_lock);
90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  191  		cifs_server_dbg(VFS, "no multichannel support\n");
9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  192  		return 0;
9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  193  	}
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  194  	spin_unlock(&ses->chan_lock);
9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  195  
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  196  	/*
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  197  	 * Keep connecting to same, fastest, iface for all channels as
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  198  	 * long as its RSS. Try next fastest one if not RSS or channel
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  199  	 * creation fails.
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  200  	 */
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  201  	spin_lock(&ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  202  	iface = list_first_entry(&ses->iface_list, struct cifs_server_iface,
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  203  				 iface_head);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  204  	spin_unlock(&ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  205  
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  206  	while (left > 0) {
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  207  
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  208  		tries++;
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  209  		if (tries > 3*ses->chan_max) {
bbbf9eafbfdaa2 fs/cifs/sess.c Steve French    2020-05-30  210  			cifs_dbg(FYI, "too many channel open attempts (%d channels left to open)\n",
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  211  				 left);
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  212  			break;
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  213  		}
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  214  
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  215  		spin_lock(&ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  216  		if (!ses->iface_count) {
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  217  			spin_unlock(&ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  218  			break;
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  219  		}
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  220  
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  221  		list_for_each_entry_safe_from(iface, niface, &ses->iface_list,
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  222  				    iface_head) {
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  223  			/* skip ifaces that are unusable */
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  224  			if (!iface->is_active ||
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  225  			    (is_ses_using_iface(ses, iface) &&
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  226  			     !iface->rss_capable)) {
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  227  				continue;
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  228  			}
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  229  
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  230  			/* take ref before unlock */
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  231  			kref_get(&iface->refcount);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  232  
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  233  			spin_unlock(&ses->iface_lock);
387ec58f339b0c fs/cifs/sess.c Ronnie Sahlberg 2020-12-14  234  			rc = cifs_ses_add_channel(cifs_sb, ses, iface);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  235  			spin_lock(&ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  236  
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  237  			if (rc) {
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  238  				cifs_dbg(VFS, "failed to open extra channel on iface:%pIS rc=%d\n",
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  239  					 &iface->sockaddr,
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  240  					 rc);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  241  				kref_put(&iface->refcount, release_iface);
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  242  				continue;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  243  			}
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  244  
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  245  			cifs_dbg(FYI, "successfully opened new channel on iface:%pIS\n",
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  246  				 &iface->sockaddr);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  247  			break;
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  248  		}
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  249  		spin_unlock(&ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  250  
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  251  		left--;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  252  		new_chan_count++;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  253  	}
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  254  
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  255  	return new_chan_count - old_chan_count;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  256  }
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  257  

:::::: The code at line 160 was first introduced by commit
:::::: 387ec58f339b0c45e3767395f11fa8dd3772131e cifs: simplify handling of cifs_sb/ctx->local_nls

:::::: TO: Ronnie Sahlberg <lsahlber@redhat.com>
:::::: CC: Steve French <stfrench@microsoft.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
