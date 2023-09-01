Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0F878F6D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348078AbjIABuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjIABuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:50:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7ACE6E;
        Thu, 31 Aug 2023 18:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693533019; x=1725069019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z/IUJxs1mc3hfH7hCTKbpZvonJnzNoHHAzpaCom1+88=;
  b=EKbgcUoN0VpEhPRCN8i7wMAVDAtpKllj7I4moASuL6w+qDN6ItRv1rX6
   bApB+nNyhI/727FOgi9G2XSGpWcHkQqAV5Qk/KUd8308GVwU3g38LxQco
   E3WDh1eH2EJKZOnkSGYYluGDUBwcMApdrN5VFbOHiqT/NOAtj8COu7hpQ
   mCVBF6+SEEZ8TxWoocPfp2s5UBJ09hqa21dd8l4ZlL6Sjt7ppPOLCR/tt
   DK+VhzT88j4Rjw65SU43WajXFBWXXEjGNe8H/WvJeNHHFzoprZdWYX39r
   eV4Y50fEPtej5f3Wlp5+jt3x8Il9IfHOJFIGxinw2sfq+glmPes6Mq+/M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="379898124"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="379898124"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 18:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="809886470"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="809886470"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2023 18:50:15 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbtIb-0000kd-2k;
        Fri, 01 Sep 2023 01:50:13 +0000
Date:   Fri, 1 Sep 2023 09:49:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH v1 4/5] misc: fastrpc: Add support to save and restore
 interrupted
Message-ID: <202309010926.bLqVExVs-lkp@intel.com>
References: <1693499292-19083-5-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693499292-19083-5-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ekansh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ekansh-Gupta/misc-fastrpc-Add-fastrpc-multimode-invoke-request-support/20230901-002929
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/1693499292-19083-5-git-send-email-quic_ekangupt%40quicinc.com
patch subject: [PATCH v1 4/5] misc: fastrpc: Add support to save and restore interrupted
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230901/202309010926.bLqVExVs-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309010926.bLqVExVs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309010926.bLqVExVs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/misc/fastrpc.c: In function 'fastrpc_context_alloc':
   drivers/misc/fastrpc.c:663:29: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     663 |                 ctx->args = (struct fastrpc_invoke_args *)invoke->inv.args;
         |                             ^
   drivers/misc/fastrpc.c: In function 'fastrpc_init_create_static_process':
   drivers/misc/fastrpc.c:1494:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1494 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_init_create_process':
   drivers/misc/fastrpc.c:1627:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1627 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_release_current_dsp_process':
   drivers/misc/fastrpc.c:1710:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1710 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_device_release':
>> drivers/misc/fastrpc.c:1719:42: warning: unused variable 'n' [-Wunused-variable]
    1719 |         struct fastrpc_invoke_ctx *ctx, *n;
         |                                          ^
>> drivers/misc/fastrpc.c:1719:36: warning: unused variable 'ctx' [-Wunused-variable]
    1719 |         struct fastrpc_invoke_ctx *ctx, *n;
         |                                    ^~~
   drivers/misc/fastrpc.c: In function 'fastrpc_init_attach':
   drivers/misc/fastrpc.c:1856:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1856 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_invoke':
   drivers/misc/fastrpc.c:1887:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1887 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_multimode_invoke':
   drivers/misc/fastrpc.c:1928:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1928 |                 einv.inv.args = (__u64)args;
         |                                 ^
   drivers/misc/fastrpc.c: In function 'fastrpc_get_info_from_dsp':
   drivers/misc/fastrpc.c:1958:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1958 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_munmap_impl':
   drivers/misc/fastrpc.c:2061:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2061 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mmap':
   drivers/misc/fastrpc.c:2159:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2159 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_unmap_impl':
   drivers/misc/fastrpc.c:2240:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2240 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_map':
   drivers/misc/fastrpc.c:2309:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2309 |         ioctl.inv.args = (__u64)args;
         |                          ^


vim +/n +1719 drivers/misc/fastrpc.c

0871561055e666 Abel Vesa                2022-11-25  1530  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1531  static int fastrpc_init_create_process(struct fastrpc_user *fl,
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1532  					char __user *argp)
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1533  {
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1534  	struct fastrpc_init_create init;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1535  	struct fastrpc_invoke_args *args;
db2e49fb9bf108 Ekansh Gupta             2023-08-31  1536  	struct fastrpc_enhanced_invoke ioctl;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1537  	struct fastrpc_phy_page pages[1];
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1538  	struct fastrpc_map *map = NULL;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1539  	struct fastrpc_buf *imem = NULL;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1540  	int memlen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1541  	int err;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1542  	struct {
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1543  		int pgid;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1544  		u32 namelen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1545  		u32 filelen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1546  		u32 pageslen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1547  		u32 attrs;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1548  		u32 siglen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1549  	} inbuf;
7f1f481263c3ce Jeya R                   2022-02-14  1550  	bool unsigned_module = false;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1551  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1552  	args = kcalloc(FASTRPC_CREATE_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1553  	if (!args)
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1554  		return -ENOMEM;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1555  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1556  	if (copy_from_user(&init, argp, sizeof(init))) {
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1557  		err = -EFAULT;
b49f6d83e290f1 Thierry Escande          2019-03-07  1558  		goto err;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1559  	}
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1560  
7f1f481263c3ce Jeya R                   2022-02-14  1561  	if (init.attrs & FASTRPC_MODE_UNSIGNED_MODULE)
7f1f481263c3ce Jeya R                   2022-02-14  1562  		unsigned_module = true;
7f1f481263c3ce Jeya R                   2022-02-14  1563  
7f1f481263c3ce Jeya R                   2022-02-14  1564  	if (is_session_rejected(fl, unsigned_module)) {
7f1f481263c3ce Jeya R                   2022-02-14  1565  		err = -ECONNREFUSED;
7f1f481263c3ce Jeya R                   2022-02-14  1566  		goto err;
7f1f481263c3ce Jeya R                   2022-02-14  1567  	}
7f1f481263c3ce Jeya R                   2022-02-14  1568  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1569  	if (init.filelen > INIT_FILELEN_MAX) {
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1570  		err = -EINVAL;
b49f6d83e290f1 Thierry Escande          2019-03-07  1571  		goto err;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1572  	}
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1573  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1574  	inbuf.pgid = fl->tgid;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1575  	inbuf.namelen = strlen(current->comm) + 1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1576  	inbuf.filelen = init.filelen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1577  	inbuf.pageslen = 1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1578  	inbuf.attrs = init.attrs;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1579  	inbuf.siglen = init.siglen;
84195d206e1fbd Jonathan Marek           2020-09-08  1580  	fl->pd = USER_PD;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1581  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1582  	if (init.filelen && init.filefd) {
e90d911906196b Vamsi Krishna Gattupalli 2022-02-14  1583  		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1584  		if (err)
b49f6d83e290f1 Thierry Escande          2019-03-07  1585  			goto err;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1586  	}
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1587  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1588  	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1589  		       1024 * 1024);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1590  	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1591  				&imem);
b49f6d83e290f1 Thierry Escande          2019-03-07  1592  	if (err)
b49f6d83e290f1 Thierry Escande          2019-03-07  1593  		goto err_alloc;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1594  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1595  	fl->init_mem = imem;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1596  	args[0].ptr = (u64)(uintptr_t)&inbuf;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1597  	args[0].length = sizeof(inbuf);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1598  	args[0].fd = -1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1599  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1600  	args[1].ptr = (u64)(uintptr_t)current->comm;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1601  	args[1].length = inbuf.namelen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1602  	args[1].fd = -1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1603  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1604  	args[2].ptr = (u64) init.file;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1605  	args[2].length = inbuf.filelen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1606  	args[2].fd = init.filefd;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1607  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1608  	pages[0].addr = imem->phys;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1609  	pages[0].size = imem->size;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1610  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1611  	args[3].ptr = (u64)(uintptr_t) pages;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1612  	args[3].length = 1 * sizeof(*pages);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1613  	args[3].fd = -1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1614  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1615  	args[4].ptr = (u64)(uintptr_t)&inbuf.attrs;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1616  	args[4].length = sizeof(inbuf.attrs);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1617  	args[4].fd = -1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1618  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1619  	args[5].ptr = (u64)(uintptr_t) &inbuf.siglen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1620  	args[5].length = sizeof(inbuf.siglen);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1621  	args[5].fd = -1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1622  
db2e49fb9bf108 Ekansh Gupta             2023-08-31  1623  	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
db2e49fb9bf108 Ekansh Gupta             2023-08-31  1624  	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1625  	if (init.attrs)
db2e49fb9bf108 Ekansh Gupta             2023-08-31  1626  		ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
db2e49fb9bf108 Ekansh Gupta             2023-08-31 @1627  	ioctl.inv.args = (__u64)args;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1628  
db2e49fb9bf108 Ekansh Gupta             2023-08-31  1629  	err = fastrpc_internal_invoke(fl, true, &ioctl);
b49f6d83e290f1 Thierry Escande          2019-03-07  1630  	if (err)
b49f6d83e290f1 Thierry Escande          2019-03-07  1631  		goto err_invoke;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1632  
b49f6d83e290f1 Thierry Escande          2019-03-07  1633  	kfree(args);
b49f6d83e290f1 Thierry Escande          2019-03-07  1634  
b49f6d83e290f1 Thierry Escande          2019-03-07  1635  	return 0;
b49f6d83e290f1 Thierry Escande          2019-03-07  1636  
b49f6d83e290f1 Thierry Escande          2019-03-07  1637  err_invoke:
b49f6d83e290f1 Thierry Escande          2019-03-07  1638  	fl->init_mem = NULL;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1639  	fastrpc_buf_free(imem);
b49f6d83e290f1 Thierry Escande          2019-03-07  1640  err_alloc:
b49f6d83e290f1 Thierry Escande          2019-03-07  1641  	fastrpc_map_put(map);
b49f6d83e290f1 Thierry Escande          2019-03-07  1642  err:
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1643  	kfree(args);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1644  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1645  	return err;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1646  }
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1647  
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1648  static struct fastrpc_session_ctx *fastrpc_session_alloc(
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1649  					struct fastrpc_channel_ctx *cctx)
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1650  {
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1651  	struct fastrpc_session_ctx *session = NULL;
977e6c8d1d1806 Srinivas Kandagatla      2019-03-07  1652  	unsigned long flags;
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1653  	int i;
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1654  
977e6c8d1d1806 Srinivas Kandagatla      2019-03-07  1655  	spin_lock_irqsave(&cctx->lock, flags);
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1656  	for (i = 0; i < cctx->sesscount; i++) {
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1657  		if (!cctx->session[i].used && cctx->session[i].valid) {
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1658  			cctx->session[i].used = true;
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1659  			session = &cctx->session[i];
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1660  			break;
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1661  		}
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1662  	}
977e6c8d1d1806 Srinivas Kandagatla      2019-03-07  1663  	spin_unlock_irqrestore(&cctx->lock, flags);
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1664  
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1665  	return session;
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1666  }
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1667  
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1668  static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1669  				 struct fastrpc_session_ctx *session)
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1670  {
977e6c8d1d1806 Srinivas Kandagatla      2019-03-07  1671  	unsigned long flags;
977e6c8d1d1806 Srinivas Kandagatla      2019-03-07  1672  
977e6c8d1d1806 Srinivas Kandagatla      2019-03-07  1673  	spin_lock_irqsave(&cctx->lock, flags);
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1674  	session->used = false;
977e6c8d1d1806 Srinivas Kandagatla      2019-03-07  1675  	spin_unlock_irqrestore(&cctx->lock, flags);
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1676  }
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1677  
1d9e27a4779236 Ekansh Gupta             2023-08-31  1678  static void fastrpc_context_list_free(struct fastrpc_user *fl)
1d9e27a4779236 Ekansh Gupta             2023-08-31  1679  {
1d9e27a4779236 Ekansh Gupta             2023-08-31  1680  	struct fastrpc_invoke_ctx *ctx, *n;
1d9e27a4779236 Ekansh Gupta             2023-08-31  1681  
1d9e27a4779236 Ekansh Gupta             2023-08-31  1682  	list_for_each_entry_safe(ctx, n, &fl->interrupted, node) {
1d9e27a4779236 Ekansh Gupta             2023-08-31  1683  		spin_lock(&fl->lock);
1d9e27a4779236 Ekansh Gupta             2023-08-31  1684  		list_del(&ctx->node);
1d9e27a4779236 Ekansh Gupta             2023-08-31  1685  		spin_unlock(&fl->lock);
1d9e27a4779236 Ekansh Gupta             2023-08-31  1686  		fastrpc_context_put(ctx);
1d9e27a4779236 Ekansh Gupta             2023-08-31  1687  	}
1d9e27a4779236 Ekansh Gupta             2023-08-31  1688  
1d9e27a4779236 Ekansh Gupta             2023-08-31  1689  	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
1d9e27a4779236 Ekansh Gupta             2023-08-31  1690  		spin_lock(&fl->lock);
1d9e27a4779236 Ekansh Gupta             2023-08-31  1691  		list_del(&ctx->node);
1d9e27a4779236 Ekansh Gupta             2023-08-31  1692  		spin_unlock(&fl->lock);
1d9e27a4779236 Ekansh Gupta             2023-08-31  1693  		fastrpc_context_put(ctx);
1d9e27a4779236 Ekansh Gupta             2023-08-31  1694  	}
1d9e27a4779236 Ekansh Gupta             2023-08-31  1695  }
1d9e27a4779236 Ekansh Gupta             2023-08-31  1696  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1697  static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1698  {
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1699  	struct fastrpc_invoke_args args[1];
db2e49fb9bf108 Ekansh Gupta             2023-08-31  1700  	struct fastrpc_enhanced_invoke ioctl;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1701  	int tgid = 0;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1702  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1703  	tgid = fl->tgid;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1704  	args[0].ptr = (u64)(uintptr_t) &tgid;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1705  	args[0].length = sizeof(tgid);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1706  	args[0].fd = -1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1707  
db2e49fb9bf108 Ekansh Gupta             2023-08-31  1708  	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
db2e49fb9bf108 Ekansh Gupta             2023-08-31  1709  	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
db2e49fb9bf108 Ekansh Gupta             2023-08-31 @1710  	ioctl.inv.args = (__u64)args;
db2e49fb9bf108 Ekansh Gupta             2023-08-31  1711  
db2e49fb9bf108 Ekansh Gupta             2023-08-31  1712  	return fastrpc_internal_invoke(fl, true, &ioctl);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1713  }
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1714  
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1715  static int fastrpc_device_release(struct inode *inode, struct file *file)
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1716  {
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1717  	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1718  	struct fastrpc_channel_ctx *cctx = fl->cctx;
c68cfb718c8f97 Srinivas Kandagatla      2019-02-08 @1719  	struct fastrpc_invoke_ctx *ctx, *n;
c68cfb718c8f97 Srinivas Kandagatla      2019-02-08  1720  	struct fastrpc_map *map, *m;
2419e55e532de1 Jorge Ramirez-Ortiz      2019-10-09  1721  	struct fastrpc_buf *buf, *b;
977e6c8d1d1806 Srinivas Kandagatla      2019-03-07  1722  	unsigned long flags;
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1723  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1724  	fastrpc_release_current_dsp_process(fl);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1725  
977e6c8d1d1806 Srinivas Kandagatla      2019-03-07  1726  	spin_lock_irqsave(&cctx->lock, flags);
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1727  	list_del(&fl->user);
977e6c8d1d1806 Srinivas Kandagatla      2019-03-07  1728  	spin_unlock_irqrestore(&cctx->lock, flags);
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1729  
c68cfb718c8f97 Srinivas Kandagatla      2019-02-08  1730  	if (fl->init_mem)
c68cfb718c8f97 Srinivas Kandagatla      2019-02-08  1731  		fastrpc_buf_free(fl->init_mem);
c68cfb718c8f97 Srinivas Kandagatla      2019-02-08  1732  
1d9e27a4779236 Ekansh Gupta             2023-08-31  1733  	fastrpc_context_list_free(fl);
c68cfb718c8f97 Srinivas Kandagatla      2019-02-08  1734  
5bb96c8f9268e2 Abel Vesa                2022-11-24  1735  	list_for_each_entry_safe(map, m, &fl->maps, node)
c68cfb718c8f97 Srinivas Kandagatla      2019-02-08  1736  		fastrpc_map_put(map);
c68cfb718c8f97 Srinivas Kandagatla      2019-02-08  1737  
2419e55e532de1 Jorge Ramirez-Ortiz      2019-10-09  1738  	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
2419e55e532de1 Jorge Ramirez-Ortiz      2019-10-09  1739  		list_del(&buf->node);
2419e55e532de1 Jorge Ramirez-Ortiz      2019-10-09  1740  		fastrpc_buf_free(buf);
2419e55e532de1 Jorge Ramirez-Ortiz      2019-10-09  1741  	}
2419e55e532de1 Jorge Ramirez-Ortiz      2019-10-09  1742  
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1743  	fastrpc_session_free(cctx, fl->sctx);
278d56f970ae6e Bjorn Andersson          2019-08-29  1744  	fastrpc_channel_ctx_put(cctx);
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1745  
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1746  	mutex_destroy(&fl->mutex);
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1747  	kfree(fl);
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1748  	file->private_data = NULL;
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1749  
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1750  	return 0;
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1751  }
f6f9279f2bf0e3 Srinivas Kandagatla      2019-02-08  1752  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
