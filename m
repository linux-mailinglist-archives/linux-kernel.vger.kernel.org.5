Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACA27A68CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjISQYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:24:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5454592
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695140651; x=1726676651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PUVy1PR0nyv03Pw1GTWCN7KaNtCsUv6IL7fGAoAXD2I=;
  b=LO7JEEFCTxIVSdK8N/bSIJdcBkStoIeGpz5zjOK7Wxl3baD34u+KdHdm
   aDaZLsGv3WDm9pWGJE6WFAXaUfvCSpg3xLtTLFFpMeqMw/k0yXT4NekHf
   IimN9wRdZh4jGpaG9IUjRVVgm+dMC2RqJqM1yx8vQt5p1IlZU4J+6CYBi
   ojthmf7f3mLqzIMgTnxkB9PFl2Mfn/U+Cs7ZdfhTAyN+gFXUSNAnVPvrE
   +iiEmx9v/EIldA1zuakoBty4heCnQBIBgCVlTAyNdbCNoZBegjhOAP7bZ
   J2sn5USa6BG15+sgwz4pd4ptqhQFOruErTXWeAQMAq5Hp3yDJ7E25rD47
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="446457256"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="446457256"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746301784"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="746301784"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2023 09:23:58 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qidW0-0007dS-04;
        Tue, 19 Sep 2023 16:23:56 +0000
Date:   Wed, 20 Sep 2023 00:23:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     WANG Xuerui <git@xen0n.name>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: net/8021q/vlan.c:235:46: warning: '%.4i' directive output may be
 truncated writing 4 bytes into a region of size between 0 and 15
Message-ID: <202309200044.5VZF1Ufb-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: 3f301dc292eb122eff61b8b2906e519154b0327f LoongArch: Replace -ffreestanding with finer-grained -fno-builtin's
date:   4 weeks ago
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20230920/202309200044.5VZF1Ufb-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309200044.5VZF1Ufb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309200044.5VZF1Ufb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/8021q/vlan.c: In function 'register_vlan_device':
   net/8021q/vlan.c:247:46: warning: '%i' directive output may be truncated writing between 1 and 4 bytes into a region of size between 0 and 15 [-Wformat-truncation=]
     247 |                 snprintf(name, IFNAMSIZ, "%s.%i", real_dev->name, vlan_id);
         |                                              ^~
   net/8021q/vlan.c:247:42: note: directive argument in the range [0, 4094]
     247 |                 snprintf(name, IFNAMSIZ, "%s.%i", real_dev->name, vlan_id);
         |                                          ^~~~~~~
   net/8021q/vlan.c:247:17: note: 'snprintf' output between 3 and 21 bytes into a destination of size 16
     247 |                 snprintf(name, IFNAMSIZ, "%s.%i", real_dev->name, vlan_id);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/8021q/vlan.c:235:46: warning: '%.4i' directive output may be truncated writing 4 bytes into a region of size between 0 and 15 [-Wformat-truncation=]
     235 |                 snprintf(name, IFNAMSIZ, "%s.%.4i", real_dev->name, vlan_id);
         |                                              ^~~~
   net/8021q/vlan.c:235:42: note: directive argument in the range [0, 4094]
     235 |                 snprintf(name, IFNAMSIZ, "%s.%.4i", real_dev->name, vlan_id);
         |                                          ^~~~~~~~~
   net/8021q/vlan.c:235:17: note: 'snprintf' output between 6 and 21 bytes into a destination of size 16
     235 |                 snprintf(name, IFNAMSIZ, "%s.%.4i", real_dev->name, vlan_id);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +235 net/8021q/vlan.c

e89fe42cd03c8f Patrick McHardy   2007-06-13  210  
c1d3ee9925ca71 Patrick McHardy   2007-06-13  211  /*  Attach a VLAN device to a mac address (ie Ethernet Card).
2ae0bf69b716d0 Patrick McHardy   2007-06-13  212   *  Returns 0 if the device was created or a negative error code otherwise.
c1d3ee9925ca71 Patrick McHardy   2007-06-13  213   */
9bb8582efb5555 Patrick McHardy   2008-07-08  214  static int register_vlan_device(struct net_device *real_dev, u16 vlan_id)
c1d3ee9925ca71 Patrick McHardy   2007-06-13  215  {
c1d3ee9925ca71 Patrick McHardy   2007-06-13  216  	struct net_device *new_dev;
0c0667a8548ef2 Wang Sheng-Hui    2013-08-03  217  	struct vlan_dev_priv *vlan;
7a17a2f79f54a9 Pavel Emelyanov   2008-04-16  218  	struct net *net = dev_net(real_dev);
7a17a2f79f54a9 Pavel Emelyanov   2008-04-16  219  	struct vlan_net *vn = net_generic(net, vlan_net_id);
c1d3ee9925ca71 Patrick McHardy   2007-06-13  220  	char name[IFNAMSIZ];
2ae0bf69b716d0 Patrick McHardy   2007-06-13  221  	int err;
c1d3ee9925ca71 Patrick McHardy   2007-06-13  222  
9bb8582efb5555 Patrick McHardy   2008-07-08  223  	if (vlan_id >= VLAN_VID_MASK)
2ae0bf69b716d0 Patrick McHardy   2007-06-13  224  		return -ERANGE;
c1d3ee9925ca71 Patrick McHardy   2007-06-13  225  
33fa382324ebd1 David Ahern       2018-05-17  226  	err = vlan_check_real_dev(real_dev, htons(ETH_P_8021Q), vlan_id,
33fa382324ebd1 David Ahern       2018-05-17  227  				  NULL);
2ae0bf69b716d0 Patrick McHardy   2007-06-13  228  	if (err < 0)
2ae0bf69b716d0 Patrick McHardy   2007-06-13  229  		return err;
c1d3ee9925ca71 Patrick McHardy   2007-06-13  230  
^1da177e4c3f41 Linus Torvalds    2005-04-16  231  	/* Gotta set up the fields for the device. */
7a17a2f79f54a9 Pavel Emelyanov   2008-04-16  232  	switch (vn->name_type) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  233  	case VLAN_NAME_TYPE_RAW_PLUS_VID:
^1da177e4c3f41 Linus Torvalds    2005-04-16  234  		/* name will look like:	 eth1.0005 */
9bb8582efb5555 Patrick McHardy   2008-07-08 @235  		snprintf(name, IFNAMSIZ, "%s.%.4i", real_dev->name, vlan_id);
^1da177e4c3f41 Linus Torvalds    2005-04-16  236  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  237  	case VLAN_NAME_TYPE_PLUS_VID_NO_PAD:
^1da177e4c3f41 Linus Torvalds    2005-04-16  238  		/* Put our vlan.VID in the name.
^1da177e4c3f41 Linus Torvalds    2005-04-16  239  		 * Name will look like:	 vlan5
^1da177e4c3f41 Linus Torvalds    2005-04-16  240  		 */
9bb8582efb5555 Patrick McHardy   2008-07-08  241  		snprintf(name, IFNAMSIZ, "vlan%i", vlan_id);
^1da177e4c3f41 Linus Torvalds    2005-04-16  242  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  243  	case VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD:
^1da177e4c3f41 Linus Torvalds    2005-04-16  244  		/* Put our vlan.VID in the name.
^1da177e4c3f41 Linus Torvalds    2005-04-16  245  		 * Name will look like:	 eth0.5
^1da177e4c3f41 Linus Torvalds    2005-04-16  246  		 */
9bb8582efb5555 Patrick McHardy   2008-07-08  247  		snprintf(name, IFNAMSIZ, "%s.%i", real_dev->name, vlan_id);
^1da177e4c3f41 Linus Torvalds    2005-04-16  248  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  249  	case VLAN_NAME_TYPE_PLUS_VID:
^1da177e4c3f41 Linus Torvalds    2005-04-16  250  		/* Put our vlan.VID in the name.
^1da177e4c3f41 Linus Torvalds    2005-04-16  251  		 * Name will look like:	 vlan0005
^1da177e4c3f41 Linus Torvalds    2005-04-16  252  		 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  253  	default:
9bb8582efb5555 Patrick McHardy   2008-07-08  254  		snprintf(name, IFNAMSIZ, "vlan%.4i", vlan_id);
3ff50b7997fe06 Stephen Hemminger 2007-04-20  255  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  256  
c835a677331495 Tom Gundersen     2014-07-14  257  	new_dev = alloc_netdev(sizeof(struct vlan_dev_priv), name,
c835a677331495 Tom Gundersen     2014-07-14  258  			       NET_NAME_UNKNOWN, vlan_setup);
5dd8d1e9eb8b51 Arjan van de Ven  2006-07-03  259  
^1da177e4c3f41 Linus Torvalds    2005-04-16  260  	if (new_dev == NULL)
2ae0bf69b716d0 Patrick McHardy   2007-06-13  261  		return -ENOBUFS;
^1da177e4c3f41 Linus Torvalds    2005-04-16  262  
65d292a2ef2df6 Pavel Emelyanov   2008-04-16  263  	dev_net_set(new_dev, net);
^1da177e4c3f41 Linus Torvalds    2005-04-16  264  	/* need 4 bytes for extra VLAN header info,
^1da177e4c3f41 Linus Torvalds    2005-04-16  265  	 * hope the underlying device can handle it.
^1da177e4c3f41 Linus Torvalds    2005-04-16  266  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  267  	new_dev->mtu = real_dev->mtu;
^1da177e4c3f41 Linus Torvalds    2005-04-16  268  
0c0667a8548ef2 Wang Sheng-Hui    2013-08-03  269  	vlan = vlan_dev_priv(new_dev);
0c0667a8548ef2 Wang Sheng-Hui    2013-08-03  270  	vlan->vlan_proto = htons(ETH_P_8021Q);
0c0667a8548ef2 Wang Sheng-Hui    2013-08-03  271  	vlan->vlan_id = vlan_id;
0c0667a8548ef2 Wang Sheng-Hui    2013-08-03  272  	vlan->real_dev = real_dev;
0c0667a8548ef2 Wang Sheng-Hui    2013-08-03  273  	vlan->dent = NULL;
0c0667a8548ef2 Wang Sheng-Hui    2013-08-03  274  	vlan->flags = VLAN_FLAG_REORDER_HDR;
^1da177e4c3f41 Linus Torvalds    2005-04-16  275  
07b5b17e157b70 Patrick McHardy   2007-06-13  276  	new_dev->rtnl_link_ops = &vlan_link_ops;
42ab19ee902929 David Ahern       2017-10-04  277  	err = register_vlan_dev(new_dev, NULL);
2ae0bf69b716d0 Patrick McHardy   2007-06-13  278  	if (err < 0)
42429aaee5eb44 Patrick McHardy   2007-06-13  279  		goto out_free_newdev;
^1da177e4c3f41 Linus Torvalds    2005-04-16  280  
2ae0bf69b716d0 Patrick McHardy   2007-06-13  281  	return 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  282  
^1da177e4c3f41 Linus Torvalds    2005-04-16  283  out_free_newdev:
^1da177e4c3f41 Linus Torvalds    2005-04-16  284  	free_netdev(new_dev);
2ae0bf69b716d0 Patrick McHardy   2007-06-13  285  	return err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  286  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  287  

:::::: The code at line 235 was first introduced by commit
:::::: 9bb8582efb555521c7eec595ebd34e835ddc34b8 vlan: TCI related type and naming cleanups

:::::: TO: Patrick McHardy <kaber@trash.net>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
