Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526B7799284
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245564AbjIHWym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbjIHWyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:54:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B711FEB;
        Fri,  8 Sep 2023 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694213677; x=1725749677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eUm4yl2BAMHBo03g5Rb/N9p2aZICoAAK9LpFQ7u8z4s=;
  b=nvQumfgrSPipWhhM71C8qAHiBqZ8fptuv/w2RFau6bt807L8Pkp9PNrC
   sn8xK/V1KdLU3M9jox/EhCEsirNNESOIlBP3FtiV1Xz74qCmR/TQn0vco
   D2M6dtf9aCyBqruUXy1GN1N+ZvAkBjm0HBNtdEyGdzhreiJUxZ/i08iML
   4erdnxYM80SDPU5qsO7RgyxopWvjx0YDtX68kOLba+amj8Gy4SQAYcUSW
   28LrxPOH5Sl+AekVf3OfkQrVyZNrmcQb6JUbaCtv69Y9n4AsQpXvqGW2u
   TT0wulhcDCuh5bo9kNADBDTcUKb5wwW1tJEjFPih3zJb3F240+Eu7DbsP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="358066923"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="358066923"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 15:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="742667451"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="742667451"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Sep 2023 15:54:34 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qekMy-0002hP-0h;
        Fri, 08 Sep 2023 22:54:32 +0000
Date:   Sat, 9 Sep 2023 06:54:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alfred Piccioni <alpic@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alfred Piccioni <alpic@google.com>
Subject: Re: [PATCH V2] SELinux: Check correct permissions for FS_IOC32_*
Message-ID: <202309090600.NSyo7d2q-lkp@intel.com>
References: <20230906115928.3749928-1-alpic@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906115928.3749928-1-alpic@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alfred,

kernel test robot noticed the following build errors:

[auto build test ERROR on 50a510a78287c15cee644f345ef8bac8977986a7]

url:    https://github.com/intel-lab-lkp/linux/commits/Alfred-Piccioni/SELinux-Check-correct-permissions-for-FS_IOC32_/20230906-200131
base:   50a510a78287c15cee644f345ef8bac8977986a7
patch link:    https://lore.kernel.org/r/20230906115928.3749928-1-alpic%40google.com
patch subject: [PATCH V2] SELinux: Check correct permissions for FS_IOC32_*
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20230909/202309090600.NSyo7d2q-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309090600.NSyo7d2q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309090600.NSyo7d2q-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/selinux/hooks.c: In function 'selinux_file_ioctl':
>> security/selinux/hooks.c:3647:9: error: duplicate case value
    3647 |         case FS_IOC32_GETFLAGS:
         |         ^~~~
   security/selinux/hooks.c:3645:9: note: previously used here
    3645 |         case FS_IOC_GETFLAGS:
         |         ^~~~
   security/selinux/hooks.c:3648:9: error: duplicate case value
    3648 |         case FS_IOC32_GETVERSION:
         |         ^~~~
   security/selinux/hooks.c:3646:9: note: previously used here
    3646 |         case FS_IOC_GETVERSION:
         |         ^~~~
   security/selinux/hooks.c:3654:9: error: duplicate case value
    3654 |         case FS_IOC32_SETFLAGS:
         |         ^~~~
   security/selinux/hooks.c:3652:9: note: previously used here
    3652 |         case FS_IOC_SETFLAGS:
         |         ^~~~
   security/selinux/hooks.c:3655:9: error: duplicate case value
    3655 |         case FS_IOC32_SETVERSION:
         |         ^~~~
   security/selinux/hooks.c:3653:9: note: previously used here
    3653 |         case FS_IOC_SETVERSION:
         |         ^~~~


vim +3647 security/selinux/hooks.c

  3634	
  3635	static int selinux_file_ioctl(struct file *file, unsigned int cmd,
  3636				      unsigned long arg)
  3637	{
  3638		const struct cred *cred = current_cred();
  3639		int error = 0;
  3640	
  3641		switch (cmd) {
  3642		case FIONREAD:
  3643		case FIBMAP:
  3644		case FIGETBSZ:
  3645		case FS_IOC_GETFLAGS:
  3646		case FS_IOC_GETVERSION:
> 3647		case FS_IOC32_GETFLAGS:
  3648		case FS_IOC32_GETVERSION:
  3649			error = file_has_perm(cred, file, FILE__GETATTR);
  3650			break;
  3651	
  3652		case FS_IOC_SETFLAGS:
  3653		case FS_IOC_SETVERSION:
  3654		case FS_IOC32_SETFLAGS:
  3655		case FS_IOC32_SETVERSION:
  3656			error = file_has_perm(cred, file, FILE__SETATTR);
  3657			break;
  3658	
  3659		/* sys_ioctl() checks */
  3660		case FIONBIO:
  3661		case FIOASYNC:
  3662			error = file_has_perm(cred, file, 0);
  3663			break;
  3664	
  3665		case KDSKBENT:
  3666		case KDSKBSENT:
  3667			error = cred_has_capability(cred, CAP_SYS_TTY_CONFIG,
  3668						    CAP_OPT_NONE, true);
  3669			break;
  3670	
  3671		case FIOCLEX:
  3672		case FIONCLEX:
  3673			if (!selinux_policycap_ioctl_skip_cloexec())
  3674				error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
  3675			break;
  3676	
  3677		/* default case assumes that the command will go
  3678		 * to the file's ioctl() function.
  3679		 */
  3680		default:
  3681			error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
  3682		}
  3683		return error;
  3684	}
  3685	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
