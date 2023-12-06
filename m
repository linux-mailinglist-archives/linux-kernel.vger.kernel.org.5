Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBD1807971
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379511AbjLFUfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLFUfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:35:20 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C7F181
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UA6r0udznHhGJgACyBdbrBYU69S2zUHN7arwQmxPcyk=;
  b=LA+1FNZNcseRI82S+cz8l+vJfTOsUvtCL0Ge6utC+jC4FGMfU88eV7T5
   RbwoZLmpaUcjxxWQ9x/02NUhtonbeBMucn+Rhi+gUBAtZA8SHOp4DiE87
   3Mo2BxJ/OIbtWPBToA/6gHwYTpQJOAJ80nXFS8J7a0UcBHspGNR+lLIxI
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,256,1695679200"; 
   d="scan'208";a="140710281"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 21:35:23 +0100
Date:   Wed, 6 Dec 2023 21:35:23 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Jinjie Ruan <ruanjinjie@huawei.com>
cc:     Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
Subject: drivers/net/ethernet/intel/igb/igb_main.c:7895:6-11: ERROR: invalid
 reference to the index variable of the iterator on line 7890 (fwd)
Message-ID: <alpine.DEB.2.22.394.2312062131290.3364@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On line 7895, entry cannot be NULL.  If the list_for_each_entry reaches
the end, entry->free could be some random location.

julia

---------- Forwarded message ----------
Date: Thu, 7 Dec 2023 02:50:54 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/net/ethernet/intel/igb/igb_main.c:7895:6-11: ERROR: invalid
    reference to the index variable of the iterator on line 7890

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Jinjie Ruan <ruanjinjie@huawei.com>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Jacob Keller <jacob.e.keller@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Simon Horman <horms@kernel.org>

Hi Jinjie,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: c1fec890458ad101ddbbc52cdd29f7bba6aa2b10 ethernet/intel: Use list_for_each_entry() helper
date:   10 weeks ago
:::::: branch date: 2 days ago
:::::: commit date: 10 weeks ago
config: i386-randconfig-054-20231206 (https://download.01.org/0day-ci/archive/20231207/202312070228.ehoA7Xpz-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20231207/202312070228.ehoA7Xpz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202312070228.ehoA7Xpz-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/igb/igb_main.c:7895:6-11: ERROR: invalid reference to the index variable of the iterator on line 7890
   drivers/net/ethernet/intel/igb/igb_main.c:7895:15-20: ERROR: invalid reference to the index variable of the iterator on line 7890

vim +7895 drivers/net/ethernet/intel/igb/igb_main.c

83c21335c87622 Yury Kylulin     2017-03-07  7854
b476deab8f412b Colin Ian King   2017-04-27  7855  static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
4827cc37796a02 Yury Kylulin     2017-03-07  7856  				 const u32 info, const u8 *addr)
4827cc37796a02 Yury Kylulin     2017-03-07  7857  {
4827cc37796a02 Yury Kylulin     2017-03-07  7858  	struct pci_dev *pdev = adapter->pdev;
4827cc37796a02 Yury Kylulin     2017-03-07  7859  	struct vf_data_storage *vf_data = &adapter->vf_data[vf];
4827cc37796a02 Yury Kylulin     2017-03-07  7860  	struct vf_mac_filter *entry = NULL;
4827cc37796a02 Yury Kylulin     2017-03-07  7861  	int ret = 0;
4827cc37796a02 Yury Kylulin     2017-03-07  7862
1b8b062a99dc76 Corinna Vinschen 2018-01-17  7863  	if ((vf_data->flags & IGB_VF_FLAG_PF_SET_MAC) &&
1b8b062a99dc76 Corinna Vinschen 2018-01-17  7864  	    !vf_data->trusted) {
4827cc37796a02 Yury Kylulin     2017-03-07  7865  		dev_warn(&pdev->dev,
4827cc37796a02 Yury Kylulin     2017-03-07  7866  			 "VF %d requested MAC filter but is administratively denied\n",
4827cc37796a02 Yury Kylulin     2017-03-07  7867  			  vf);
4827cc37796a02 Yury Kylulin     2017-03-07  7868  		return -EINVAL;
4827cc37796a02 Yury Kylulin     2017-03-07  7869  	}
4827cc37796a02 Yury Kylulin     2017-03-07  7870  	if (!is_valid_ether_addr(addr)) {
4827cc37796a02 Yury Kylulin     2017-03-07  7871  		dev_warn(&pdev->dev,
4827cc37796a02 Yury Kylulin     2017-03-07  7872  			 "VF %d attempted to set invalid MAC filter\n",
4827cc37796a02 Yury Kylulin     2017-03-07  7873  			  vf);
4827cc37796a02 Yury Kylulin     2017-03-07  7874  		return -EINVAL;
4827cc37796a02 Yury Kylulin     2017-03-07  7875  	}
4827cc37796a02 Yury Kylulin     2017-03-07  7876
584af82154f56e Karen Sornek     2021-08-31  7877  	switch (info) {
584af82154f56e Karen Sornek     2021-08-31  7878  	case E1000_VF_MAC_FILTER_CLR:
584af82154f56e Karen Sornek     2021-08-31  7879  		/* remove all unicast MAC filters related to the current VF */
c1fec890458ad1 Jinjie Ruan      2023-09-19  7880  		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
584af82154f56e Karen Sornek     2021-08-31  7881  			if (entry->vf == vf) {
584af82154f56e Karen Sornek     2021-08-31  7882  				entry->vf = -1;
584af82154f56e Karen Sornek     2021-08-31  7883  				entry->free = true;
584af82154f56e Karen Sornek     2021-08-31  7884  				igb_del_mac_filter(adapter, entry->vf_mac, vf);
584af82154f56e Karen Sornek     2021-08-31  7885  			}
584af82154f56e Karen Sornek     2021-08-31  7886  		}
584af82154f56e Karen Sornek     2021-08-31  7887  		break;
584af82154f56e Karen Sornek     2021-08-31  7888  	case E1000_VF_MAC_FILTER_ADD:
4827cc37796a02 Yury Kylulin     2017-03-07  7889  		/* try to find empty slot in the list */
c1fec890458ad1 Jinjie Ruan      2023-09-19 @7890  		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
4827cc37796a02 Yury Kylulin     2017-03-07  7891  			if (entry->free)
4827cc37796a02 Yury Kylulin     2017-03-07  7892  				break;
4827cc37796a02 Yury Kylulin     2017-03-07  7893  		}
4827cc37796a02 Yury Kylulin     2017-03-07  7894
4827cc37796a02 Yury Kylulin     2017-03-07 @7895  		if (entry && entry->free) {
4827cc37796a02 Yury Kylulin     2017-03-07  7896  			entry->free = false;
4827cc37796a02 Yury Kylulin     2017-03-07  7897  			entry->vf = vf;
4827cc37796a02 Yury Kylulin     2017-03-07  7898  			ether_addr_copy(entry->vf_mac, addr);
4827cc37796a02 Yury Kylulin     2017-03-07  7899
4827cc37796a02 Yury Kylulin     2017-03-07  7900  			ret = igb_add_mac_filter(adapter, addr, vf);
4827cc37796a02 Yury Kylulin     2017-03-07  7901  			ret = min_t(int, ret, 0);
4827cc37796a02 Yury Kylulin     2017-03-07  7902  		} else {
4827cc37796a02 Yury Kylulin     2017-03-07  7903  			ret = -ENOSPC;
4827cc37796a02 Yury Kylulin     2017-03-07  7904  		}
4827cc37796a02 Yury Kylulin     2017-03-07  7905
4827cc37796a02 Yury Kylulin     2017-03-07  7906  		if (ret == -ENOSPC)
4827cc37796a02 Yury Kylulin     2017-03-07  7907  			dev_warn(&pdev->dev,
4827cc37796a02 Yury Kylulin     2017-03-07  7908  				 "VF %d has requested MAC filter but there is no space for it\n",
4827cc37796a02 Yury Kylulin     2017-03-07  7909  				 vf);
4827cc37796a02 Yury Kylulin     2017-03-07  7910  		break;
4827cc37796a02 Yury Kylulin     2017-03-07  7911  	default:
4827cc37796a02 Yury Kylulin     2017-03-07  7912  		ret = -EINVAL;
4827cc37796a02 Yury Kylulin     2017-03-07  7913  		break;
4827cc37796a02 Yury Kylulin     2017-03-07  7914  	}
4827cc37796a02 Yury Kylulin     2017-03-07  7915
4827cc37796a02 Yury Kylulin     2017-03-07  7916  	return ret;
4827cc37796a02 Yury Kylulin     2017-03-07  7917  }
4827cc37796a02 Yury Kylulin     2017-03-07  7918

:::::: The code at line 7895 was first introduced by commit
:::::: 4827cc37796a02ece7097e01dad8e08f537ac815 igb/igbvf: Add VF MAC filter request capabilities

:::::: TO: Yury Kylulin <yury.kylulin@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
