Return-Path: <linux-kernel+bounces-10624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0393081D78D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 03:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332831C2102F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 02:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B18D815;
	Sun, 24 Dec 2023 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIMB3k54"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E67EA
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703383760; x=1734919760;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Nc/1sLPZO1FsEg271bzSb8EQFPRI/cwYfBJp7lvfyMA=;
  b=IIMB3k54pYrM65wl67VmVnujmzNftu4Lz+5kJSg6NcfvB2WCmgDP5DXo
   zBGGC9nx/jAxhqnfp1qnmjieWK/218GPL285mFs9YOcR3N0TEg0T49qQR
   tsgnvaJoCaxFgKi01OUYneoJm/cb9+ceaEVXFn9lEuiu8x770+rJGNuYc
   whlidG+DSGR7NKZ9F/1WL62goQxf4w34ZaXDfxoOMQIsz3zn+GTVySJc5
   6unRQuWGwrwD18W3bSCF+ypKA+IOlLld9JMesU7/GpaIUQbasgBChHTkT
   NoyYRFYAUkLbc1rMaOIy3xxPN0ajdCSaTUFzBQ/EHcW3sdCZoA3g5G+8a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="3035542"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="3035542"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 18:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="19121988"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 23 Dec 2023 18:09:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHDvX-000Bl1-0Q;
	Sun, 24 Dec 2023 02:09:15 +0000
Date: Sun, 24 Dec 2023 10:09:01 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Igor Russkikh <igor.russkikh@aquantia.com>
Subject: drivers/net/usb/aqc111.c:623:22: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202312241027.pRt8ik6L-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f82f1c3a03694800a4104ca6b6d3282bd4e213d
commit: 4a3576d2bcc755475890e2db717cab0effb1f140 net: usb: aqc111: Implement TX data path
date:   5 years ago
config: x86_64-randconfig-x001-20230717 (https://download.01.org/0day-ci/archive/20231224/202312241027.pRt8ik6L-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312241027.pRt8ik6L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312241027.pRt8ik6L-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/usb/aqc111.c:623:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __le64 [usertype] @@
   drivers/net/usb/aqc111.c:623:22: sparse:     expected unsigned long long [usertype]
   drivers/net/usb/aqc111.c:623:22: sparse:     got restricted __le64 [usertype]
   drivers/net/usb/aqc111.c: note: in included file (through include/linux/textsearch.h, include/linux/skbuff.h, include/linux/if_ether.h, ...):
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   drivers/net/usb/aqc111.c:20:12: warning: 'aqc111_read_cmd_nopm' defined but not used [-Wunused-function]
      20 | static int aqc111_read_cmd_nopm(struct usbnet *dev, u8 cmd, u16 value,
         |            ^~~~~~~~~~~~~~~~~~~~

vim +623 drivers/net/usb/aqc111.c

   580	
   581	static struct sk_buff *aqc111_tx_fixup(struct usbnet *dev, struct sk_buff *skb,
   582					       gfp_t flags)
   583	{
   584		int frame_size = dev->maxpacket;
   585		struct sk_buff *new_skb = NULL;
   586		u64 *tx_desc_ptr = NULL;
   587		int padding_size = 0;
   588		int headroom = 0;
   589		int tailroom = 0;
   590		u64 tx_desc = 0;
   591	
   592		/*Length of actual data*/
   593		tx_desc |= skb->len & AQ_TX_DESC_LEN_MASK;
   594	
   595		headroom = (skb->len + sizeof(tx_desc)) % 8;
   596		if (headroom != 0)
   597			padding_size = 8 - headroom;
   598	
   599		if (((skb->len + sizeof(tx_desc) + padding_size) % frame_size) == 0) {
   600			padding_size += 8;
   601			tx_desc |= AQ_TX_DESC_DROP_PADD;
   602		}
   603	
   604		if (!dev->can_dma_sg && (dev->net->features & NETIF_F_SG) &&
   605		    skb_linearize(skb))
   606			return NULL;
   607	
   608		headroom = skb_headroom(skb);
   609		tailroom = skb_tailroom(skb);
   610	
   611		if (!(headroom >= sizeof(tx_desc) && tailroom >= padding_size)) {
   612			new_skb = skb_copy_expand(skb, sizeof(tx_desc),
   613						  padding_size, flags);
   614			dev_kfree_skb_any(skb);
   615			skb = new_skb;
   616			if (!skb)
   617				return NULL;
   618		}
   619		if (padding_size != 0)
   620			skb_put_zero(skb, padding_size);
   621		/* Copy TX header */
   622		tx_desc_ptr = skb_push(skb, sizeof(tx_desc));
 > 623		*tx_desc_ptr = cpu_to_le64(tx_desc);
   624	
   625		usbnet_set_skb_tx_stats(skb, 1, 0);
   626	
   627		return skb;
   628	}
   629	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

