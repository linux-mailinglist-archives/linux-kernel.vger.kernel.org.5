Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E180294F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 01:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjLDAOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 19:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLDAOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 19:14:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC58DB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 16:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701648885; x=1733184885;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aA6lEOPZwR+70IIOOhJxxtylG//TYzEI5gEK6WvRkkg=;
  b=EhGegBE+jR8jtFYNv8pFjL1z+Lzvk7ObjSH88a173yTtwoJsmLB2JI2o
   kajXk8wfO4ZHNjAL86hK8kTdwoIpLfqXpZuy6+FimAXD2XtGcUBhO3VUC
   ac79RcT5Ur7TAhO5A7xSCGyDpVWUkBTWhm1dj/yh4tuCW/MZeKrH7Ck+P
   lJmejTYkkv46PZqD+JCPQXmleUiTJru983MkANCY7B6i7GEXtwldvX4vd
   P5wq1PKBvLeAWOVgdVC/UrhFZct5YL8znV4rrUfFpEXifgsM/NRzYFIsb
   CPUM1uo0gg5GwtD+a5Q2he86h3tNKxNmeCgeOo/QpuaCBRk2JUQ8cdb1m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="547753"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="547753"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 16:14:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="774093439"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="774093439"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 03 Dec 2023 16:14:41 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9wbf-0007HQ-0K;
        Mon, 04 Dec 2023 00:14:39 +0000
Date:   Mon, 4 Dec 2023 08:14:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/fuse/cuse.c:318: warning: Function parameter or member 'args' not
 described in 'cuse_process_init_reply'
Message-ID: <202312040745.aXNIDAPv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: b50ef7c52ad7c954b743cd1cb181e9bf03537bab cuse: convert init to simple api
date:   4 years, 3 months ago
config: x86_64-randconfig-r015-20230805 (https://download.01.org/0day-ci/archive/20231204/202312040745.aXNIDAPv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231204/202312040745.aXNIDAPv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312040745.aXNIDAPv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/fuse/cuse.c:271: warning: expecting prototype for cuse_parse_dev_info(). Prototype was for cuse_parse_devinfo() instead
   fs/fuse/cuse.c:318: warning: Function parameter or member 'fc' not described in 'cuse_process_init_reply'
>> fs/fuse/cuse.c:318: warning: Function parameter or member 'args' not described in 'cuse_process_init_reply'
>> fs/fuse/cuse.c:318: warning: Function parameter or member 'error' not described in 'cuse_process_init_reply'


vim +318 fs/fuse/cuse.c

b50ef7c52ad7c9 Miklos Szeredi 2019-09-10  308  
151060ac131442 Tejun Heo      2009-04-14  309  /**
151060ac131442 Tejun Heo      2009-04-14  310   * cuse_process_init_reply - finish initializing CUSE channel
151060ac131442 Tejun Heo      2009-04-14  311   *
151060ac131442 Tejun Heo      2009-04-14  312   * This function creates the character device and sets up all the
151060ac131442 Tejun Heo      2009-04-14  313   * required data structures for it.  Please read the comment at the
151060ac131442 Tejun Heo      2009-04-14  314   * top of this file for high level overview.
151060ac131442 Tejun Heo      2009-04-14  315   */
b50ef7c52ad7c9 Miklos Szeredi 2019-09-10  316  static void cuse_process_init_reply(struct fuse_conn *fc,
b50ef7c52ad7c9 Miklos Szeredi 2019-09-10  317  				    struct fuse_args *args, int error)
151060ac131442 Tejun Heo      2009-04-14 @318  {
b50ef7c52ad7c9 Miklos Szeredi 2019-09-10  319  	struct cuse_init_args *ia = container_of(args, typeof(*ia), ap.args);
b50ef7c52ad7c9 Miklos Szeredi 2019-09-10  320  	struct fuse_args_pages *ap = &ia->ap;
30783587b0f318 David Herrmann 2012-11-17  321  	struct cuse_conn *cc = fc_to_cc(fc), *pos;
b50ef7c52ad7c9 Miklos Szeredi 2019-09-10  322  	struct cuse_init_out *arg = &ia->out;
b50ef7c52ad7c9 Miklos Szeredi 2019-09-10  323  	struct page *page = ap->pages[0];
151060ac131442 Tejun Heo      2009-04-14  324  	struct cuse_devinfo devinfo = { };
151060ac131442 Tejun Heo      2009-04-14  325  	struct device *dev;
151060ac131442 Tejun Heo      2009-04-14  326  	struct cdev *cdev;
151060ac131442 Tejun Heo      2009-04-14  327  	dev_t devt;
30783587b0f318 David Herrmann 2012-11-17  328  	int rc, i;
151060ac131442 Tejun Heo      2009-04-14  329  
b50ef7c52ad7c9 Miklos Szeredi 2019-09-10  330  	if (error || arg->major != FUSE_KERNEL_VERSION || arg->minor < 11)
151060ac131442 Tejun Heo      2009-04-14  331  		goto err;
151060ac131442 Tejun Heo      2009-04-14  332  
151060ac131442 Tejun Heo      2009-04-14  333  	fc->minor = arg->minor;
151060ac131442 Tejun Heo      2009-04-14  334  	fc->max_read = max_t(unsigned, arg->max_read, 4096);
151060ac131442 Tejun Heo      2009-04-14  335  	fc->max_write = max_t(unsigned, arg->max_write, 4096);
151060ac131442 Tejun Heo      2009-04-14  336  
151060ac131442 Tejun Heo      2009-04-14  337  	/* parse init reply */
151060ac131442 Tejun Heo      2009-04-14  338  	cc->unrestricted_ioctl = arg->flags & CUSE_UNRESTRICTED_IOCTL;
151060ac131442 Tejun Heo      2009-04-14  339  
b50ef7c52ad7c9 Miklos Szeredi 2019-09-10  340  	rc = cuse_parse_devinfo(page_address(page), ap->args.out_args[1].size,
151060ac131442 Tejun Heo      2009-04-14  341  				&devinfo);
151060ac131442 Tejun Heo      2009-04-14  342  	if (rc)
151060ac131442 Tejun Heo      2009-04-14  343  		goto err;
151060ac131442 Tejun Heo      2009-04-14  344  
151060ac131442 Tejun Heo      2009-04-14  345  	/* determine and reserve devt */
151060ac131442 Tejun Heo      2009-04-14  346  	devt = MKDEV(arg->dev_major, arg->dev_minor);
151060ac131442 Tejun Heo      2009-04-14  347  	if (!MAJOR(devt))
151060ac131442 Tejun Heo      2009-04-14  348  		rc = alloc_chrdev_region(&devt, MINOR(devt), 1, devinfo.name);
151060ac131442 Tejun Heo      2009-04-14  349  	else
151060ac131442 Tejun Heo      2009-04-14  350  		rc = register_chrdev_region(devt, 1, devinfo.name);
151060ac131442 Tejun Heo      2009-04-14  351  	if (rc) {
f2294482ff65dd Kirill Smelkov 2019-03-27  352  		pr_err("failed to register chrdev region\n");
151060ac131442 Tejun Heo      2009-04-14  353  		goto err;
151060ac131442 Tejun Heo      2009-04-14  354  	}
151060ac131442 Tejun Heo      2009-04-14  355  
151060ac131442 Tejun Heo      2009-04-14  356  	/* devt determined, create device */
151060ac131442 Tejun Heo      2009-04-14  357  	rc = -ENOMEM;
151060ac131442 Tejun Heo      2009-04-14  358  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
151060ac131442 Tejun Heo      2009-04-14  359  	if (!dev)
151060ac131442 Tejun Heo      2009-04-14  360  		goto err_region;
151060ac131442 Tejun Heo      2009-04-14  361  
151060ac131442 Tejun Heo      2009-04-14  362  	device_initialize(dev);
151060ac131442 Tejun Heo      2009-04-14  363  	dev_set_uevent_suppress(dev, 1);
151060ac131442 Tejun Heo      2009-04-14  364  	dev->class = cuse_class;
151060ac131442 Tejun Heo      2009-04-14  365  	dev->devt = devt;
151060ac131442 Tejun Heo      2009-04-14  366  	dev->release = cuse_gendev_release;
151060ac131442 Tejun Heo      2009-04-14  367  	dev_set_drvdata(dev, cc);
151060ac131442 Tejun Heo      2009-04-14  368  	dev_set_name(dev, "%s", devinfo.name);
151060ac131442 Tejun Heo      2009-04-14  369  
30783587b0f318 David Herrmann 2012-11-17  370  	mutex_lock(&cuse_lock);
30783587b0f318 David Herrmann 2012-11-17  371  
30783587b0f318 David Herrmann 2012-11-17  372  	/* make sure the device-name is unique */
30783587b0f318 David Herrmann 2012-11-17  373  	for (i = 0; i < CUSE_CONNTBL_LEN; ++i) {
30783587b0f318 David Herrmann 2012-11-17  374  		list_for_each_entry(pos, &cuse_conntbl[i], list)
30783587b0f318 David Herrmann 2012-11-17  375  			if (!strcmp(dev_name(pos->dev), dev_name(dev)))
30783587b0f318 David Herrmann 2012-11-17  376  				goto err_unlock;
30783587b0f318 David Herrmann 2012-11-17  377  	}
30783587b0f318 David Herrmann 2012-11-17  378  
151060ac131442 Tejun Heo      2009-04-14  379  	rc = device_add(dev);
151060ac131442 Tejun Heo      2009-04-14  380  	if (rc)
30783587b0f318 David Herrmann 2012-11-17  381  		goto err_unlock;
151060ac131442 Tejun Heo      2009-04-14  382  
151060ac131442 Tejun Heo      2009-04-14  383  	/* register cdev */
151060ac131442 Tejun Heo      2009-04-14  384  	rc = -ENOMEM;
151060ac131442 Tejun Heo      2009-04-14  385  	cdev = cdev_alloc();
151060ac131442 Tejun Heo      2009-04-14  386  	if (!cdev)
30783587b0f318 David Herrmann 2012-11-17  387  		goto err_unlock;
151060ac131442 Tejun Heo      2009-04-14  388  
151060ac131442 Tejun Heo      2009-04-14  389  	cdev->owner = THIS_MODULE;
151060ac131442 Tejun Heo      2009-04-14  390  	cdev->ops = &cuse_frontend_fops;
151060ac131442 Tejun Heo      2009-04-14  391  
151060ac131442 Tejun Heo      2009-04-14  392  	rc = cdev_add(cdev, devt, 1);
151060ac131442 Tejun Heo      2009-04-14  393  	if (rc)
151060ac131442 Tejun Heo      2009-04-14  394  		goto err_cdev;
151060ac131442 Tejun Heo      2009-04-14  395  
151060ac131442 Tejun Heo      2009-04-14  396  	cc->dev = dev;
151060ac131442 Tejun Heo      2009-04-14  397  	cc->cdev = cdev;
151060ac131442 Tejun Heo      2009-04-14  398  
151060ac131442 Tejun Heo      2009-04-14  399  	/* make the device available */
151060ac131442 Tejun Heo      2009-04-14  400  	list_add(&cc->list, cuse_conntbl_head(devt));
8ce03fd76d3235 David Herrmann 2012-11-17  401  	mutex_unlock(&cuse_lock);
151060ac131442 Tejun Heo      2009-04-14  402  
151060ac131442 Tejun Heo      2009-04-14  403  	/* announce device availability */
151060ac131442 Tejun Heo      2009-04-14  404  	dev_set_uevent_suppress(dev, 0);
151060ac131442 Tejun Heo      2009-04-14  405  	kobject_uevent(&dev->kobj, KOBJ_ADD);
151060ac131442 Tejun Heo      2009-04-14  406  out:
b50ef7c52ad7c9 Miklos Szeredi 2019-09-10  407  	kfree(ia);
151060ac131442 Tejun Heo      2009-04-14  408  	__free_page(page);
151060ac131442 Tejun Heo      2009-04-14  409  	return;
151060ac131442 Tejun Heo      2009-04-14  410  
151060ac131442 Tejun Heo      2009-04-14  411  err_cdev:
151060ac131442 Tejun Heo      2009-04-14  412  	cdev_del(cdev);
30783587b0f318 David Herrmann 2012-11-17  413  err_unlock:
30783587b0f318 David Herrmann 2012-11-17  414  	mutex_unlock(&cuse_lock);
151060ac131442 Tejun Heo      2009-04-14  415  	put_device(dev);
151060ac131442 Tejun Heo      2009-04-14  416  err_region:
151060ac131442 Tejun Heo      2009-04-14  417  	unregister_chrdev_region(devt, 1);
151060ac131442 Tejun Heo      2009-04-14  418  err:
eb98e3bdf3aa7b Miklos Szeredi 2019-01-24  419  	fuse_abort_conn(fc);
151060ac131442 Tejun Heo      2009-04-14  420  	goto out;
151060ac131442 Tejun Heo      2009-04-14  421  }
151060ac131442 Tejun Heo      2009-04-14  422  

:::::: The code at line 318 was first introduced by commit
:::::: 151060ac13144208bd7601d17e4c92c59b98072f CUSE: implement CUSE - Character device in Userspace

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Miklos Szeredi <mszeredi@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
