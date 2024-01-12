Return-Path: <linux-kernel+bounces-24271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FB982BA12
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FE01F25E69
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345A1B27C;
	Fri, 12 Jan 2024 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahAI5YMT"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9F31D53F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705030959; x=1736566959;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CuuYkBmsdRja5u/ji/Jq4F1RUtbjNxmNuj3bZseYFic=;
  b=ahAI5YMTAV3Z16xlYHYklG9/LmEveH/Q64IqiJK8vu2pBm/IgIH8YhAI
   gFeMNrPHkhZ0orYpF7VE5dxeu5rQVk4YLxMqj0Hp1zoB70FbeqEpxmSdy
   Nw5B/liaxdEvi3e8u7xfjzmQYGiHjsSQXXK0+1ZHHePTx8DQluBiTXWac
   DBm6LhKksbgn8QOvrTyyLflh8hcfqILb73XIzt9JwuJGxJx/JvJZmYK7t
   baA9tgDD2wcm7f3GRXUXeIbG/n9ulooKqlotHNn4SLSFpJmPMrUibxVp9
   0+qR/VdNH9A4sUfqcI9LOOkVFmSRp0XfrkcLdUmGdju0Z5P4UXycMIHlX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="402846886"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="402846886"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 19:42:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="782897429"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="782897429"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Jan 2024 19:42:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO8RG-00091a-2i;
	Fri, 12 Jan 2024 03:42:34 +0000
Date: Fri, 12 Jan 2024 11:41:50 +0800
From: kernel test robot <lkp@intel.com>
To: SeongJae Park <sjpark@amazon.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: drivers/xen/xenbus/xenbus_client.c:134: warning: Function parameter
 or member 'will_handle' not described in 'xenbus_watch_path'
Message-ID: <202401121154.FI8jDGun-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   22d29f1112c85c1ad519a8c0403f7f7289cf060c
commit: 2e85d32b1c865bec703ce0c962221a5e955c52c2 xen/xenbus: Add 'will_handle' callback support in xenbus_watch_path()
date:   3 years, 1 month ago
config: x86_64-buildonly-randconfig-006-20240105 (https://download.01.org/0day-ci/archive/20240112/202401121154.FI8jDGun-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121154.FI8jDGun-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121154.FI8jDGun-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/xen/xenbus/xenbus_client.c:134: warning: Function parameter or member 'will_handle' not described in 'xenbus_watch_path'
>> drivers/xen/xenbus/xenbus_client.c:177: warning: Function parameter or member 'will_handle' not described in 'xenbus_watch_pathfmt'
   drivers/xen/xenbus/xenbus_client.c:350: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Equivalent to xenbus_dev_fatal(dev, err, fmt, args), but helps
   drivers/xen/xenbus/xenbus_client.c:414: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Allocate an event channel for the given xenbus_device, assigning the newly
   drivers/xen/xenbus/xenbus_client.c:443: warning: Function parameter or member 'dev' not described in 'xenbus_free_evtchn'
   drivers/xen/xenbus/xenbus_client.c:443: warning: Function parameter or member 'port' not described in 'xenbus_free_evtchn'
   drivers/xen/xenbus/xenbus_client.c:443: warning: expecting prototype for Free an existing event channel. Returns 0 on success or(). Prototype was for xenbus_free_evtchn() instead


vim +134 drivers/xen/xenbus/xenbus_client.c

4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  113  
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  114  /**
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  115   * xenbus_watch_path - register a watch
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  116   * @dev: xenbus device
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  117   * @path: path to watch
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  118   * @watch: watch to register
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  119   * @callback: callback to register
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  120   *
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  121   * Register a @watch on the given path, using the given xenbus_watch structure
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  122   * for storage, and the given @callback function as the callback.  Return 0 on
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  123   * success, or -errno on error.  On success, the given @path will be saved as
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  124   * @watch->node, and remains the caller's to free.  On error, @watch->node will
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  125   * be NULL, the device will switch to %XenbusStateClosing, and the error will
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  126   * be saved in the store.
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  127   */
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  128  int xenbus_watch_path(struct xenbus_device *dev, const char *path,
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  129  		      struct xenbus_watch *watch,
2e85d32b1c865b SeongJae Park       2020-12-14  130  		      bool (*will_handle)(struct xenbus_watch *,
2e85d32b1c865b SeongJae Park       2020-12-14  131  					  const char *, const char *),
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  132  		      void (*callback)(struct xenbus_watch *,
5584ea250ae44f Juergen Gross       2017-02-09  133  				       const char *, const char *))
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17 @134  {
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  135  	int err;
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  136  
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  137  	watch->node = path;
2e85d32b1c865b SeongJae Park       2020-12-14  138  	watch->will_handle = will_handle;
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  139  	watch->callback = callback;
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  140  
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  141  	err = register_xenbus_watch(watch);
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  142  
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  143  	if (err) {
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  144  		watch->node = NULL;
2e85d32b1c865b SeongJae Park       2020-12-14  145  		watch->will_handle = NULL;
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  146  		watch->callback = NULL;
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  147  		xenbus_dev_fatal(dev, err, "adding watch on %s", path);
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  148  	}
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  149  
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  150  	return err;
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  151  }
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  152  EXPORT_SYMBOL_GPL(xenbus_watch_path);
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  153  
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  154  
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  155  /**
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  156   * xenbus_watch_pathfmt - register a watch on a sprintf-formatted path
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  157   * @dev: xenbus device
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  158   * @watch: watch to register
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  159   * @callback: callback to register
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  160   * @pathfmt: format of path to watch
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  161   *
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  162   * Register a watch on the given @path, using the given xenbus_watch
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  163   * structure for storage, and the given @callback function as the callback.
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  164   * Return 0 on success, or -errno on error.  On success, the watched path
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  165   * (@path/@path2) will be saved as @watch->node, and becomes the caller's to
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  166   * kfree().  On error, watch->node will be NULL, so the caller has nothing to
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  167   * free, the device will switch to %XenbusStateClosing, and the error will be
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  168   * saved in the store.
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  169   */
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  170  int xenbus_watch_pathfmt(struct xenbus_device *dev,
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  171  			 struct xenbus_watch *watch,
2e85d32b1c865b SeongJae Park       2020-12-14  172  			 bool (*will_handle)(struct xenbus_watch *,
2e85d32b1c865b SeongJae Park       2020-12-14  173  					const char *, const char *),
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  174  			 void (*callback)(struct xenbus_watch *,
5584ea250ae44f Juergen Gross       2017-02-09  175  					  const char *, const char *),
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  176  			 const char *pathfmt, ...)
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17 @177  {
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  178  	int err;
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  179  	va_list ap;
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  180  	char *path;
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  181  
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  182  	va_start(ap, pathfmt);
a144ff09bc52ef Ian Campbell        2008-06-17  183  	path = kvasprintf(GFP_NOIO | __GFP_HIGH, pathfmt, ap);
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  184  	va_end(ap);
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  185  
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  186  	if (!path) {
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  187  		xenbus_dev_fatal(dev, -ENOMEM, "allocating path for watch");
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  188  		return -ENOMEM;
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  189  	}
2e85d32b1c865b SeongJae Park       2020-12-14  190  	err = xenbus_watch_path(dev, path, watch, will_handle, callback);
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  191  
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  192  	if (err)
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  193  		kfree(path);
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  194  	return err;
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  195  }
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  196  EXPORT_SYMBOL_GPL(xenbus_watch_pathfmt);
4bac07c993d034 Jeremy Fitzhardinge 2007-07-17  197  

:::::: The code at line 134 was first introduced by commit
:::::: 4bac07c993d03434ea902d3d4290d9e45944b66c xen: add the Xenbus sysfs and virtual device hotplug driver

:::::: TO: Jeremy Fitzhardinge <jeremy@xensource.com>
:::::: CC: Jeremy Fitzhardinge <jeremy@goop.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

