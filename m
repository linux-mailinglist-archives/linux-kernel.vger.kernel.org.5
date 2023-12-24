Return-Path: <linux-kernel+bounces-10807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420EC81DC0B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 20:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6255C1C20C08
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D7D523;
	Sun, 24 Dec 2023 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRC4QwIu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4BD2EE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703445513; x=1734981513;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=INvis6ethGb0ekbzhTfxSdcXVsR0zFycGoks0/1uzjQ=;
  b=lRC4QwIujHqqzX/uNxDc4OrAZ9M8NMAyP67rfYrDwy6xieh1QcywaSQz
   E4PYIjPjwJ6TWNR8t5AMqV4NVO37ErvPq7/2JLpZXBBPSemRxNMeBf1Ib
   4NGID4zZj8fPZCeLYd7RWcHXwsPCXHC2MoxxZlx40PABBfcGyAH0OH1dq
   q99tFUqzJpDZgimO0c9Y/u8zQjj9bTp4OoMPyY4b8Yn6zwjxrSmldtWwy
   98kSvwnWleZycpuHcKzEF16rHX1fqDdhTAhrgDCtGgowSX75wOjxGXGyr
   v1yyMRKG1IDS/oOkr9MWx6v0rMOnzKboGOr8sOsqvHiB1PPUZKYxB0diy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="400072289"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="400072289"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 11:18:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="19281266"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 24 Dec 2023 11:18:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHTzR-000CYX-1w;
	Sun, 24 Dec 2023 19:18:27 +0000
Date: Mon, 25 Dec 2023 03:17:23 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Igor Russkikh <igor.russkikh@aquantia.com>
Subject: drivers/net/usb/aqc111.c:606:34: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202312250354.xeVTLITE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: 361459cd9642631f048719169da9ef14cbf4a932 net: usb: aqc111: Implement RX data path
date:   5 years ago
config: x86_64-randconfig-x001-20230717 (https://download.01.org/0day-ci/archive/20231225/202312250354.xeVTLITE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312250354.xeVTLITE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312250354.xeVTLITE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/usb/aqc111.c:606:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le64 const [usertype] *p @@     got unsigned long long [usertype] * @@
   drivers/net/usb/aqc111.c:606:34: sparse:     expected restricted __le64 const [usertype] *p
   drivers/net/usb/aqc111.c:606:34: sparse:     got unsigned long long [usertype] *
>> drivers/net/usb/aqc111.c:629:45: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le64 const [usertype] *p @@     got unsigned long long [usertype] *[assigned] pkt_desc_ptr @@
   drivers/net/usb/aqc111.c:629:45: sparse:     expected restricted __le64 const [usertype] *p
   drivers/net/usb/aqc111.c:629:45: sparse:     got unsigned long long [usertype] *[assigned] pkt_desc_ptr
   drivers/net/usb/aqc111.c:724:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __le64 [usertype] @@
   drivers/net/usb/aqc111.c:724:22: sparse:     expected unsigned long long [usertype]
   drivers/net/usb/aqc111.c:724:22: sparse:     got restricted __le64 [usertype]
   drivers/net/usb/aqc111.c: note: in included file (through include/linux/textsearch.h, include/linux/skbuff.h, include/linux/if_ether.h, ...):
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   drivers/net/usb/aqc111.c:20:12: warning: 'aqc111_read_cmd_nopm' defined but not used [-Wunused-function]
      20 | static int aqc111_read_cmd_nopm(struct usbnet *dev, u8 cmd, u16 value,
         |            ^~~~~~~~~~~~~~~~~~~~

vim +606 drivers/net/usb/aqc111.c

   585	
   586	static int aqc111_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
   587	{
   588		struct sk_buff *new_skb = NULL;
   589		u32 pkt_total_offset = 0;
   590		u64 *pkt_desc_ptr = NULL;
   591		u32 start_of_descs = 0;
   592		u32 desc_offset = 0; /*RX Header Offset*/
   593		u16 pkt_count = 0;
   594		u64 desc_hdr = 0;
   595		u32 skb_len = 0;
   596	
   597		if (!skb)
   598			goto err;
   599	
   600		if (skb->len == 0)
   601			goto err;
   602	
   603		skb_len = skb->len;
   604		/* RX Descriptor Header */
   605		skb_trim(skb, skb->len - sizeof(desc_hdr));
 > 606		desc_hdr = le64_to_cpup((u64 *)skb_tail_pointer(skb));
   607	
   608		/* Check these packets */
   609		desc_offset = (desc_hdr & AQ_RX_DH_DESC_OFFSET_MASK) >>
   610			      AQ_RX_DH_DESC_OFFSET_SHIFT;
   611		pkt_count = desc_hdr & AQ_RX_DH_PKT_CNT_MASK;
   612		start_of_descs = skb_len - ((pkt_count + 1) *  sizeof(desc_hdr));
   613	
   614		/* self check descs position */
   615		if (start_of_descs != desc_offset)
   616			goto err;
   617	
   618		/* self check desc_offset from header*/
   619		if (desc_offset >= skb_len)
   620			goto err;
   621	
   622		if (pkt_count == 0)
   623			goto err;
   624	
   625		/* Get the first RX packet descriptor */
   626		pkt_desc_ptr = (u64 *)(skb->data + desc_offset);
   627	
   628		while (pkt_count--) {
 > 629			u64 pkt_desc = le64_to_cpup(pkt_desc_ptr);
   630			u32 pkt_len_with_padd = 0;
   631			u32 pkt_len = 0;
   632	
   633			pkt_len = (u32)((pkt_desc & AQ_RX_PD_LEN_MASK) >>
   634				  AQ_RX_PD_LEN_SHIFT);
   635			pkt_len_with_padd = ((pkt_len + 7) & 0x7FFF8);
   636	
   637			pkt_total_offset += pkt_len_with_padd;
   638			if (pkt_total_offset > desc_offset ||
   639			    (pkt_count == 0 && pkt_total_offset != desc_offset)) {
   640				goto err;
   641			}
   642	
   643			if (pkt_desc & AQ_RX_PD_DROP ||
   644			    !(pkt_desc & AQ_RX_PD_RX_OK) ||
   645			    pkt_len > (dev->hard_mtu + AQ_RX_HW_PAD)) {
   646				skb_pull(skb, pkt_len_with_padd);
   647				/* Next RX Packet Descriptor */
   648				pkt_desc_ptr++;
   649				continue;
   650			}
   651	
   652			/* Clone SKB */
   653			new_skb = skb_clone(skb, GFP_ATOMIC);
   654	
   655			if (!new_skb)
   656				goto err;
   657	
   658			new_skb->len = pkt_len;
   659			skb_pull(new_skb, AQ_RX_HW_PAD);
   660			skb_set_tail_pointer(new_skb, new_skb->len);
   661	
   662			new_skb->truesize = SKB_TRUESIZE(new_skb->len);
   663	
   664			usbnet_skb_return(dev, new_skb);
   665			if (pkt_count == 0)
   666				break;
   667	
   668			skb_pull(skb, pkt_len_with_padd);
   669	
   670			/* Next RX Packet Header */
   671			pkt_desc_ptr++;
   672	
   673			new_skb = NULL;
   674		}
   675	
   676		return 1;
   677	
   678	err:
   679		return 0;
   680	}
   681	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

