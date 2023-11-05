Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1807E1262
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 07:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjKEG2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 01:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEG2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 01:28:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2252C6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699165725; x=1730701725;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+LKQEk9O+MkTV2zkumezb88iLn+YR01iYjFlFf/BcI8=;
  b=dGRvnfQWowdRQ98j6uUrZmiwGGJxvTxx9gchuVg2eexJdKYywAgU0C9v
   p+VWH16NdqH/8M0BZyHt4RHDtDtsiuefi02XNpARTkxcvurIDIPCNu8Pm
   7aoSqGGHudo8Yq7uLmVW6kj2ROCzlYsFcrGpMpM/n59re0fYvstFrqhqY
   ZoopeV+N82EJYbUEMJvlw1cLixg/MQ/ND1xwgFCFpkgHx1Ow+Vwaw8C5p
   PkPoUnKXc6rl1qQkjxAUQ9j8n3NbMSOZXZCMHmKl4LJCoypNIluiSMdPg
   OTOwweRLA95U/6GyLsGc0gqYfYpI55InFiR0Lbx6DJN3nf6bPSvZv7AMb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="2101677"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="2101677"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 23:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="3138620"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Nov 2023 23:28:43 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzWci-00057r-0r;
        Sun, 05 Nov 2023 06:28:40 +0000
Date:   Sun, 5 Nov 2023 14:28:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/message/fusion/mptlan.c:1234:52: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202311051436.9rXlJjUh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: 4e2e619f3c9e3c49859f085995554a53e9fc0e02 scsi: message: mptlan: Replace one-element array with flexible-array member
date:   2 years, 7 months ago
config: x86_64-randconfig-121-20231101 (https://download.01.org/0day-ci/archive/20231105/202311051436.9rXlJjUh-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051436.9rXlJjUh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051436.9rXlJjUh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/message/fusion/mptlan.c:1172:21: sparse: sparse: cast to restricted __le16
>> drivers/message/fusion/mptlan.c:1234:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] TransactionContext @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1234:52: sparse:     expected unsigned int [usertype] TransactionContext
   drivers/message/fusion/mptlan.c:1234:52: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:1238:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1238:46: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptlan.c:1238:46: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:1242:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1242:46: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptlan.c:1242:46: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:1244:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1244:55: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptlan.c:1244:55: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:1258:38: sparse: sparse: invalid assignment: |=
   drivers/message/fusion/mptlan.c:1258:38: sparse:    left side has type unsigned int
   drivers/message/fusion/mptlan.c:1258:38: sparse:    right side has type restricted __le32
   drivers/message/fusion/mptlan.c:1260:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] BucketCount @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1260:39: sparse:     expected unsigned int [usertype] BucketCount
   drivers/message/fusion/mptlan.c:1260:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:964:25: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:969:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:972:14: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:976:15: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:982:53: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:986:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:990:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:1020:31: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:612:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:617:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:641:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:346:17: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:1492:27: sparse: sparse: restricted __be16 degrades to integer
   drivers/message/fusion/mptlan.c:1529:29: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] ethertype @@
   drivers/message/fusion/mptlan.c:1529:29: sparse:     expected unsigned short
   drivers/message/fusion/mptlan.c:1529:29: sparse:     got restricted __be16 [usertype] ethertype
   drivers/message/fusion/mptlan.c:1532:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/message/fusion/mptlan.c:1532:16: sparse:     expected unsigned short
   drivers/message/fusion/mptlan.c:1532:16: sparse:     got restricted __be16 [usertype]
   drivers/message/fusion/mptlan.c:745:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] TransactionContext @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:745:36: sparse:     expected unsigned int [usertype] TransactionContext
   drivers/message/fusion/mptlan.c:745:36: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:753:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:753:39: sparse:     expected unsigned int
   drivers/message/fusion/mptlan.c:753:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:756:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:756:39: sparse:     expected unsigned int
   drivers/message/fusion/mptlan.c:756:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:766:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:766:30: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptlan.c:766:30: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:775:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:775:30: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptlan.c:775:30: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:777:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:777:39: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptlan.c:777:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:784:9: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:819:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] protocol @@     got unsigned short @@
   drivers/message/fusion/mptlan.c:819:23: sparse:     expected restricted __be16 [usertype] protocol
   drivers/message/fusion/mptlan.c:819:23: sparse:     got unsigned short
   drivers/message/fusion/mptlan.c:919:23: sparse: sparse: cast to restricted __le32

vim +1234 drivers/message/fusion/mptlan.c

  1134	
  1135	static void
  1136	mpt_lan_post_receive_buckets(struct mpt_lan_priv *priv)
  1137	{
  1138		struct net_device *dev = priv->dev;
  1139		MPT_ADAPTER *mpt_dev = priv->mpt_dev;
  1140		MPT_FRAME_HDR *mf;
  1141		LANReceivePostRequest_t *pRecvReq;
  1142		SGETransaction32_t *pTrans;
  1143		SGESimple64_t *pSimple;
  1144		struct sk_buff *skb;
  1145		dma_addr_t dma;
  1146		u32 curr, buckets, count, max;
  1147		u32 len = (dev->mtu + dev->hard_header_len + 4);
  1148		unsigned long flags;
  1149		int i;
  1150	
  1151		curr = atomic_read(&priv->buckets_out);
  1152		buckets = (priv->max_buckets_out - curr);
  1153	
  1154		dioprintk((KERN_INFO MYNAM ": %s/%s: @%s, Start_buckets = %u, buckets_out = %u\n",
  1155				IOC_AND_NETDEV_NAMES_s_s(dev),
  1156				__func__, buckets, curr));
  1157	
  1158		max = (mpt_dev->req_sz - MPT_LAN_RECEIVE_POST_REQUEST_SIZE) /
  1159				(sizeof(SGETransaction32_t) + sizeof(SGESimple64_t));
  1160	
  1161		while (buckets) {
  1162			mf = mpt_get_msg_frame(LanCtx, mpt_dev);
  1163			if (mf == NULL) {
  1164				printk (KERN_ERR "%s: Unable to alloc request frame\n",
  1165					__func__);
  1166				dioprintk((KERN_ERR "%s: %u buckets remaining\n",
  1167					 __func__, buckets));
  1168				goto out;
  1169			}
  1170			pRecvReq = (LANReceivePostRequest_t *) mf;
  1171	
  1172			i = le16_to_cpu(mf->u.frame.hwhdr.msgctxu.fld.req_idx);
  1173			mpt_dev->RequestNB[i] = 0;
  1174			count = buckets;
  1175			if (count > max)
  1176				count = max;
  1177	
  1178			pRecvReq->Function    = MPI_FUNCTION_LAN_RECEIVE;
  1179			pRecvReq->ChainOffset = 0;
  1180			pRecvReq->MsgFlags    = 0;
  1181			pRecvReq->PortNumber  = priv->pnum;
  1182	
  1183			pTrans = (SGETransaction32_t *) pRecvReq->SG_List;
  1184			pSimple = NULL;
  1185	
  1186			for (i = 0; i < count; i++) {
  1187				int ctx;
  1188	
  1189				spin_lock_irqsave(&priv->rxfidx_lock, flags);
  1190				if (priv->mpt_rxfidx_tail < 0) {
  1191					printk (KERN_ERR "%s: Can't alloc context\n",
  1192						__func__);
  1193					spin_unlock_irqrestore(&priv->rxfidx_lock,
  1194							       flags);
  1195					break;
  1196				}
  1197	
  1198				ctx = priv->mpt_rxfidx[priv->mpt_rxfidx_tail--];
  1199	
  1200				skb = priv->RcvCtl[ctx].skb;
  1201				if (skb && (priv->RcvCtl[ctx].len != len)) {
  1202					pci_unmap_single(mpt_dev->pcidev,
  1203							 priv->RcvCtl[ctx].dma,
  1204							 priv->RcvCtl[ctx].len,
  1205							 PCI_DMA_FROMDEVICE);
  1206					dev_kfree_skb(priv->RcvCtl[ctx].skb);
  1207					skb = priv->RcvCtl[ctx].skb = NULL;
  1208				}
  1209	
  1210				if (skb == NULL) {
  1211					skb = dev_alloc_skb(len);
  1212					if (skb == NULL) {
  1213						printk (KERN_WARNING
  1214							MYNAM "/%s: Can't alloc skb\n",
  1215							__func__);
  1216						priv->mpt_rxfidx[++priv->mpt_rxfidx_tail] = ctx;
  1217						spin_unlock_irqrestore(&priv->rxfidx_lock, flags);
  1218						break;
  1219					}
  1220	
  1221					dma = pci_map_single(mpt_dev->pcidev, skb->data,
  1222							     len, PCI_DMA_FROMDEVICE);
  1223	
  1224					priv->RcvCtl[ctx].skb = skb;
  1225					priv->RcvCtl[ctx].dma = dma;
  1226					priv->RcvCtl[ctx].len = len;
  1227				}
  1228	
  1229				spin_unlock_irqrestore(&priv->rxfidx_lock, flags);
  1230	
  1231				pTrans->ContextSize   = sizeof(u32);
  1232				pTrans->DetailsLength = 0;
  1233				pTrans->Flags         = 0;
> 1234				pTrans->TransactionContext = cpu_to_le32(ctx);
  1235	
  1236				pSimple = (SGESimple64_t *) pTrans->TransactionDetails;
  1237	
  1238				pSimple->FlagsLength = cpu_to_le32(
  1239					((MPI_SGE_FLAGS_END_OF_BUFFER |
  1240					  MPI_SGE_FLAGS_SIMPLE_ELEMENT |
  1241					  MPI_SGE_FLAGS_64_BIT_ADDRESSING) << MPI_SGE_FLAGS_SHIFT) | len);
  1242				pSimple->Address.Low = cpu_to_le32((u32) priv->RcvCtl[ctx].dma);
  1243				if (sizeof(dma_addr_t) > sizeof(u32))
  1244					pSimple->Address.High = cpu_to_le32((u32) ((u64) priv->RcvCtl[ctx].dma >> 32));
  1245				else
  1246					pSimple->Address.High = 0;
  1247	
  1248				pTrans = (SGETransaction32_t *) (pSimple + 1);
  1249			}
  1250	
  1251			if (pSimple == NULL) {
  1252	/**/			printk (KERN_WARNING MYNAM "/%s: No buckets posted\n",
  1253	/**/				__func__);
  1254				mpt_free_msg_frame(mpt_dev, mf);
  1255				goto out;
  1256			}
  1257	
  1258			pSimple->FlagsLength |= cpu_to_le32(MPI_SGE_FLAGS_END_OF_LIST << MPI_SGE_FLAGS_SHIFT);
  1259	
  1260			pRecvReq->BucketCount = cpu_to_le32(i);
  1261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
