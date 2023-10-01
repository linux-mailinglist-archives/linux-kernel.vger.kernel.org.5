Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637EE7B4877
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjJAPrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjJAPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:47:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17295D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 08:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696175238; x=1727711238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZhaV8IMatqxRTpJcJidOJ++oo+kPQ59O4WDBqvf4QXk=;
  b=BHRGcwVbkH0g8E+DCVli2+R44WYUF8PNkdluK24tXK36etP+3NaU21vJ
   lqKRSkZ+VQLNOdlDIP/Lq0utK5SmIQToUYdcXlq5LYuXCSZ/GaVaRB0Vl
   X89biASWLBGWnLU0QtYKqsyyAwqGUA+3DELrTfw86RyJHQGENA1cErvhB
   x6wBjFxVz7uitM4iqaVYZsiYnexyZ5zun07u13ESBRA0vZrWvSRnPiCMb
   iOVm8o35DRRxZyNCK3BVib7H623P6Y2mTauVb8jmcmc3EdgHc06UwqN2S
   EAnj71qHDEe1HJnG3zRdyDaAHO2Q5ycxU3ykgIQh+aK1VaR5tj0JgJyBE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="361912501"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="361912501"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 08:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="1081426495"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="1081426495"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 01 Oct 2023 08:47:16 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmyf4-0005BR-0l;
        Sun, 01 Oct 2023 15:47:14 +0000
Date:   Sun, 1 Oct 2023 23:46:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/nfsd/export.c:737:1: warning: the frame size of 1040 bytes is
 larger than 1024 bytes
Message-ID: <202310012359.YEw5IrK6-lkp@intel.com>
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

Hi Chuck,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e402b08634b398e9feb94902c7adcf05bb8ba47d
commit: 9280c577431401544e63dfb489a830a42bee25eb NFSD: Handle new xprtsec= export option
date:   5 months ago
config: x86_64-intel-next-customedconfig-intel_next_rpm_defconfig (https://download.01.org/0day-ci/archive/20231001/202310012359.YEw5IrK6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231001/202310012359.YEw5IrK6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310012359.YEw5IrK6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nfsd/export.c: In function 'svc_export_parse':
>> fs/nfsd/export.c:737:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     737 | }
         | ^


vim +737 fs/nfsd/export.c

0d63790c365852a Kinglong Mee         2014-05-23  591  
^1da177e4c3f415 Linus Torvalds       2005-04-16  592  static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
^1da177e4c3f415 Linus Torvalds       2005-04-16  593  {
^1da177e4c3f415 Linus Torvalds       2005-04-16  594  	/* client path expiry [flags anonuid anongid fsid] */
^1da177e4c3f415 Linus Torvalds       2005-04-16  595  	char *buf;
^1da177e4c3f415 Linus Torvalds       2005-04-16  596  	int len;
^1da177e4c3f415 Linus Torvalds       2005-04-16  597  	int err;
^1da177e4c3f415 Linus Torvalds       2005-04-16  598  	struct auth_domain *dom = NULL;
c1a2a4756df01d7 Al Viro              2008-08-02  599  	struct svc_export exp = {}, *expp;
^1da177e4c3f415 Linus Torvalds       2005-04-16  600  	int an_int;
^1da177e4c3f415 Linus Torvalds       2005-04-16  601  
^1da177e4c3f415 Linus Torvalds       2005-04-16  602  	if (mesg[mlen-1] != '\n')
^1da177e4c3f415 Linus Torvalds       2005-04-16  603  		return -EINVAL;
^1da177e4c3f415 Linus Torvalds       2005-04-16  604  	mesg[mlen-1] = 0;
^1da177e4c3f415 Linus Torvalds       2005-04-16  605  
^1da177e4c3f415 Linus Torvalds       2005-04-16  606  	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
c1a2a4756df01d7 Al Viro              2008-08-02  607  	if (!buf)
c1a2a4756df01d7 Al Viro              2008-08-02  608  		return -ENOMEM;
^1da177e4c3f415 Linus Torvalds       2005-04-16  609  
^1da177e4c3f415 Linus Torvalds       2005-04-16  610  	/* client */
^1da177e4c3f415 Linus Torvalds       2005-04-16  611  	err = -EINVAL;
c1a2a4756df01d7 Al Viro              2008-08-02  612  	len = qword_get(&mesg, buf, PAGE_SIZE);
c1a2a4756df01d7 Al Viro              2008-08-02  613  	if (len <= 0)
c1a2a4756df01d7 Al Viro              2008-08-02  614  		goto out;
^1da177e4c3f415 Linus Torvalds       2005-04-16  615  
^1da177e4c3f415 Linus Torvalds       2005-04-16  616  	err = -ENOENT;
^1da177e4c3f415 Linus Torvalds       2005-04-16  617  	dom = auth_domain_find(buf);
^1da177e4c3f415 Linus Torvalds       2005-04-16  618  	if (!dom)
^1da177e4c3f415 Linus Torvalds       2005-04-16  619  		goto out;
^1da177e4c3f415 Linus Torvalds       2005-04-16  620  
^1da177e4c3f415 Linus Torvalds       2005-04-16  621  	/* path */
^1da177e4c3f415 Linus Torvalds       2005-04-16  622  	err = -EINVAL;
^1da177e4c3f415 Linus Torvalds       2005-04-16  623  	if ((len = qword_get(&mesg, buf, PAGE_SIZE)) <= 0)
c1a2a4756df01d7 Al Viro              2008-08-02  624  		goto out1;
c1a2a4756df01d7 Al Viro              2008-08-02  625  
c1a2a4756df01d7 Al Viro              2008-08-02  626  	err = kern_path(buf, 0, &exp.ex_path);
c1a2a4756df01d7 Al Viro              2008-08-02  627  	if (err)
c1a2a4756df01d7 Al Viro              2008-08-02  628  		goto out1;
^1da177e4c3f415 Linus Torvalds       2005-04-16  629  
^1da177e4c3f415 Linus Torvalds       2005-04-16  630  	exp.ex_client = dom;
db3a35326362624 Stanislav Kinsbursky 2012-03-28  631  	exp.cd = cd;
9cf514ccfacb301 Christoph Hellwig    2014-05-05  632  	exp.ex_devid_map = NULL;
9280c5774314015 Chuck Lever          2023-04-20  633  	exp.ex_xprtsec_modes = NFSEXP_XPRTSEC_ALL;
c1a2a4756df01d7 Al Viro              2008-08-02  634  
^1da177e4c3f415 Linus Torvalds       2005-04-16  635  	/* expiry */
cf64b9bce95095b NeilBrown            2023-03-08  636  	err = get_expiry(&mesg, &exp.h.expiry_time);
cf64b9bce95095b NeilBrown            2023-03-08  637  	if (err)
c1a2a4756df01d7 Al Viro              2008-08-02  638  		goto out3;
^1da177e4c3f415 Linus Torvalds       2005-04-16  639  
^1da177e4c3f415 Linus Torvalds       2005-04-16  640  	/* flags */
^1da177e4c3f415 Linus Torvalds       2005-04-16  641  	err = get_int(&mesg, &an_int);
4a4b88317aa02c8 J. Bruce Fields      2007-07-31  642  	if (err == -ENOENT) {
4a4b88317aa02c8 J. Bruce Fields      2007-07-31  643  		err = 0;
^1da177e4c3f415 Linus Torvalds       2005-04-16  644  		set_bit(CACHE_NEGATIVE, &exp.h.flags);
4a4b88317aa02c8 J. Bruce Fields      2007-07-31  645  	} else {
c1a2a4756df01d7 Al Viro              2008-08-02  646  		if (err || an_int < 0)
c1a2a4756df01d7 Al Viro              2008-08-02  647  			goto out3;
^1da177e4c3f415 Linus Torvalds       2005-04-16  648  		exp.ex_flags= an_int;
^1da177e4c3f415 Linus Torvalds       2005-04-16  649  
^1da177e4c3f415 Linus Torvalds       2005-04-16  650  		/* anon uid */
^1da177e4c3f415 Linus Torvalds       2005-04-16  651  		err = get_int(&mesg, &an_int);
c1a2a4756df01d7 Al Viro              2008-08-02  652  		if (err)
c1a2a4756df01d7 Al Viro              2008-08-02  653  			goto out3;
e45d1a1835b8896 Trond Myklebust      2019-04-09  654  		exp.ex_anon_uid= make_kuid(current_user_ns(), an_int);
^1da177e4c3f415 Linus Torvalds       2005-04-16  655  
^1da177e4c3f415 Linus Torvalds       2005-04-16  656  		/* anon gid */
^1da177e4c3f415 Linus Torvalds       2005-04-16  657  		err = get_int(&mesg, &an_int);
c1a2a4756df01d7 Al Viro              2008-08-02  658  		if (err)
c1a2a4756df01d7 Al Viro              2008-08-02  659  			goto out3;
e45d1a1835b8896 Trond Myklebust      2019-04-09  660  		exp.ex_anon_gid= make_kgid(current_user_ns(), an_int);
^1da177e4c3f415 Linus Torvalds       2005-04-16  661  
^1da177e4c3f415 Linus Torvalds       2005-04-16  662  		/* fsid */
^1da177e4c3f415 Linus Torvalds       2005-04-16  663  		err = get_int(&mesg, &an_int);
c1a2a4756df01d7 Al Viro              2008-08-02  664  		if (err)
c1a2a4756df01d7 Al Viro              2008-08-02  665  			goto out3;
^1da177e4c3f415 Linus Torvalds       2005-04-16  666  		exp.ex_fsid = an_int;
^1da177e4c3f415 Linus Torvalds       2005-04-16  667  
af6a4e280e3ff45 NeilBrown            2007-02-14  668  		while ((len = qword_get(&mesg, buf, PAGE_SIZE)) > 0) {
af6a4e280e3ff45 NeilBrown            2007-02-14  669  			if (strcmp(buf, "fsloc") == 0)
933469190ed5915 Manoj Naik           2006-10-04  670  				err = fsloc_parse(&mesg, buf, &exp.ex_fslocs);
0d63790c365852a Kinglong Mee         2014-05-23  671  			else if (strcmp(buf, "uuid") == 0)
12ce5f8c5c56fcd Christoph Hellwig    2017-05-31  672  				err = nfsd_uuid_parse(&mesg, buf, &exp.ex_uuid);
0d63790c365852a Kinglong Mee         2014-05-23  673  			else if (strcmp(buf, "secinfo") == 0)
e677bfe4d451f82 Andy Adamson         2007-07-17  674  				err = secinfo_parse(&mesg, buf, &exp);
9280c5774314015 Chuck Lever          2023-04-20  675  			else if (strcmp(buf, "xprtsec") == 0)
9280c5774314015 Chuck Lever          2023-04-20  676  				err = xprtsec_parse(&mesg, buf, &exp);
e677bfe4d451f82 Andy Adamson         2007-07-17  677  			else
af6a4e280e3ff45 NeilBrown            2007-02-14  678  				/* quietly ignore unknown words and anything
af6a4e280e3ff45 NeilBrown            2007-02-14  679  				 * following. Newer user-space can try to set
af6a4e280e3ff45 NeilBrown            2007-02-14  680  				 * new values, then see what the result was.
af6a4e280e3ff45 NeilBrown            2007-02-14  681  				 */
af6a4e280e3ff45 NeilBrown            2007-02-14  682  				break;
933469190ed5915 Manoj Naik           2006-10-04  683  			if (err)
c1a2a4756df01d7 Al Viro              2008-08-02  684  				goto out4;
^1da177e4c3f415 Linus Torvalds       2005-04-16  685  		}
^1da177e4c3f415 Linus Torvalds       2005-04-16  686  
899bf2ceb3963b0 Christian Brauner    2021-01-23  687  		err = check_export(&exp.ex_path, &exp.ex_flags, exp.ex_uuid);
c1a2a4756df01d7 Al Viro              2008-08-02  688  		if (err)
c1a2a4756df01d7 Al Viro              2008-08-02  689  			goto out4;
9280c5774314015 Chuck Lever          2023-04-20  690  
6f6cc3205c5f101 J. Bruce Fields      2013-09-13  691  		/*
6f6cc3205c5f101 J. Bruce Fields      2013-09-13  692  		 * No point caching this if it would immediately expire.
6f6cc3205c5f101 J. Bruce Fields      2013-09-13  693  		 * Also, this protects exportfs's dummy export from the
6f6cc3205c5f101 J. Bruce Fields      2013-09-13  694  		 * anon_uid/anon_gid checks:
6f6cc3205c5f101 J. Bruce Fields      2013-09-13  695  		 */
6f6cc3205c5f101 J. Bruce Fields      2013-09-13  696  		if (exp.h.expiry_time < seconds_since_boot())
6f6cc3205c5f101 J. Bruce Fields      2013-09-13  697  			goto out4;
427d6c6646d868f J. Bruce Fields      2013-09-13  698  		/*
427d6c6646d868f J. Bruce Fields      2013-09-13  699  		 * For some reason exportfs has been passing down an
427d6c6646d868f J. Bruce Fields      2013-09-13  700  		 * invalid (-1) uid & gid on the "dummy" export which it
427d6c6646d868f J. Bruce Fields      2013-09-13  701  		 * uses to test export support.  To make sure exportfs
427d6c6646d868f J. Bruce Fields      2013-09-13  702  		 * sees errors from check_export we therefore need to
427d6c6646d868f J. Bruce Fields      2013-09-13  703  		 * delay these checks till after check_export:
427d6c6646d868f J. Bruce Fields      2013-09-13  704  		 */
6f6cc3205c5f101 J. Bruce Fields      2013-09-13  705  		err = -EINVAL;
427d6c6646d868f J. Bruce Fields      2013-09-13  706  		if (!uid_valid(exp.ex_anon_uid))
427d6c6646d868f J. Bruce Fields      2013-09-13  707  			goto out4;
427d6c6646d868f J. Bruce Fields      2013-09-13  708  		if (!gid_valid(exp.ex_anon_gid))
427d6c6646d868f J. Bruce Fields      2013-09-13  709  			goto out4;
6f6cc3205c5f101 J. Bruce Fields      2013-09-13  710  		err = 0;
9cf514ccfacb301 Christoph Hellwig    2014-05-05  711  
9cf514ccfacb301 Christoph Hellwig    2014-05-05  712  		nfsd4_setup_layout_type(&exp);
af6a4e280e3ff45 NeilBrown            2007-02-14  713  	}
af6a4e280e3ff45 NeilBrown            2007-02-14  714  
4f7774c3a055852 NeilBrown            2006-03-27  715  	expp = svc_export_lookup(&exp);
6a30e47fa0c358c Trond Myklebust      2020-03-01  716  	if (!expp) {
4f7774c3a055852 NeilBrown            2006-03-27  717  		err = -ENOMEM;
6a30e47fa0c358c Trond Myklebust      2020-03-01  718  		goto out4;
6a30e47fa0c358c Trond Myklebust      2020-03-01  719  	}
6a30e47fa0c358c Trond Myklebust      2020-03-01  720  	expp = svc_export_update(&exp, expp);
6a30e47fa0c358c Trond Myklebust      2020-03-01  721  	if (expp) {
6a30e47fa0c358c Trond Myklebust      2020-03-01  722  		trace_nfsd_export_update(expp);
^1da177e4c3f415 Linus Torvalds       2005-04-16  723  		cache_flush();
4f7774c3a055852 NeilBrown            2006-03-27  724  		exp_put(expp);
6a30e47fa0c358c Trond Myklebust      2020-03-01  725  	} else
6a30e47fa0c358c Trond Myklebust      2020-03-01  726  		err = -ENOMEM;
c1a2a4756df01d7 Al Viro              2008-08-02  727  out4:
af6a4e280e3ff45 NeilBrown            2007-02-14  728  	nfsd4_fslocs_free(&exp.ex_fslocs);
af6a4e280e3ff45 NeilBrown            2007-02-14  729  	kfree(exp.ex_uuid);
c1a2a4756df01d7 Al Viro              2008-08-02  730  out3:
c1a2a4756df01d7 Al Viro              2008-08-02  731  	path_put(&exp.ex_path);
c1a2a4756df01d7 Al Viro              2008-08-02  732  out1:
^1da177e4c3f415 Linus Torvalds       2005-04-16  733  	auth_domain_put(dom);
c1a2a4756df01d7 Al Viro              2008-08-02  734  out:
^1da177e4c3f415 Linus Torvalds       2005-04-16  735  	kfree(buf);
^1da177e4c3f415 Linus Torvalds       2005-04-16  736  	return err;
^1da177e4c3f415 Linus Torvalds       2005-04-16 @737  }
^1da177e4c3f415 Linus Torvalds       2005-04-16  738  

:::::: The code at line 737 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
