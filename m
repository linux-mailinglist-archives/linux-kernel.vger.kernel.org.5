Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0417ACDB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjIYBrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIYBrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:47:23 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86AFBD;
        Sun, 24 Sep 2023 18:47:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vsjo5EY_1695606431;
Received: from 30.221.129.66(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vsjo5EY_1695606431)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 09:47:13 +0800
Message-ID: <0b49743f-1e2f-f0fd-22af-b9f76068fa75@linux.alibaba.com>
Date:   Mon, 25 Sep 2023 09:47:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next v4 12/18] net/smc: implement DMB-related
 operations of loopback
To:     kernel test robot <lkp@intel.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, wintera@linux.ibm.com,
        schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-13-git-send-email-guwen@linux.alibaba.com>
 <202309250749.LB7ZUUGJ-lkp@intel.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <202309250749.LB7ZUUGJ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/25 07:29, kernel test robot wrote:
> Hi Wen,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Wen-Gu/net-smc-decouple-ism_dev-from-SMC-D-device-dump/20230924-231933
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/1695568613-125057-13-git-send-email-guwen%40linux.alibaba.com
> patch subject: [PATCH net-next v4 12/18] net/smc: implement DMB-related operations of loopback
> config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20230925/202309250749.LB7ZUUGJ-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309250749.LB7ZUUGJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309250749.LB7ZUUGJ-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>     net/smc/smc_loopback.c: In function 'smc_lo_register_dmb':
>>> net/smc/smc_loopback.c:102:30: error: implicit declaration of function 'vzalloc'; did you mean 'kvzalloc'? [-Werror=implicit-function-declaration]
>       102 |         dmb_node->cpu_addr = vzalloc(dmb->dmb_len);
>           |                              ^~~~~~~
>           |                              kvzalloc
>>> net/smc/smc_loopback.c:102:28: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>       102 |         dmb_node->cpu_addr = vzalloc(dmb->dmb_len);
>           |                            ^
>     net/smc/smc_loopback.c: In function 'smc_lo_unregister_dmb':
>>> net/smc/smc_loopback.c:159:9: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
>       159 |         vfree(dmb_node->cpu_addr);
>           |         ^~~~~
>           |         kvfree
>     cc1: some warnings being treated as errors
> 

It can be fixed by including corresponding header file:

#include <linux/vmalloc.h>


Continue to wait for other review comments and will fix this in the next version.

Thanks.

> 
> vim +102 net/smc/smc_loopback.c
> 
>      79	
>      80	static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
>      81				       void *client_priv)
>      82	{
>      83		struct smc_lo_dmb_node *dmb_node, *tmp_node;
>      84		struct smc_lo_dev *ldev = smcd->priv;
>      85		int sba_idx, rc;
>      86	
>      87		/* check space for new dmb */
>      88		for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LODEV_MAX_DMBS) {
>      89			if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
>      90				break;
>      91		}
>      92		if (sba_idx == SMC_LODEV_MAX_DMBS)
>      93			return -ENOSPC;
>      94	
>      95		dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
>      96		if (!dmb_node) {
>      97			rc = -ENOMEM;
>      98			goto err_bit;
>      99		}
>     100	
>     101		dmb_node->sba_idx = sba_idx;
>   > 102		dmb_node->cpu_addr = vzalloc(dmb->dmb_len);
>     103		if (!dmb_node->cpu_addr) {
>     104			rc = -ENOMEM;
>     105			goto err_node;
>     106		}
>     107		dmb_node->len = dmb->dmb_len;
>     108		dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
>     109	
>     110	again:
>     111		/* add new dmb into hash table */
>     112		get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
>     113		write_lock(&ldev->dmb_ht_lock);
>     114		hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
>     115			if (tmp_node->token == dmb_node->token) {
>     116				write_unlock(&ldev->dmb_ht_lock);
>     117				goto again;
>     118			}
>     119		}
>     120		hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
>     121		write_unlock(&ldev->dmb_ht_lock);
>     122	
>     123		dmb->sba_idx = dmb_node->sba_idx;
>     124		dmb->dmb_tok = dmb_node->token;
>     125		dmb->cpu_addr = dmb_node->cpu_addr;
>     126		dmb->dma_addr = dmb_node->dma_addr;
>     127		dmb->dmb_len = dmb_node->len;
>     128	
>     129		return 0;
>     130	
>     131	err_node:
>     132		kfree(dmb_node);
>     133	err_bit:
>     134		clear_bit(sba_idx, ldev->sba_idx_mask);
>     135		return rc;
>     136	}
>     137	
>     138	static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
>     139	{
>     140		struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
>     141		struct smc_lo_dev *ldev = smcd->priv;
>     142	
>     143		/* remove dmb from hash table */
>     144		write_lock(&ldev->dmb_ht_lock);
>     145		hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
>     146			if (tmp_node->token == dmb->dmb_tok) {
>     147				dmb_node = tmp_node;
>     148				break;
>     149			}
>     150		}
>     151		if (!dmb_node) {
>     152			write_unlock(&ldev->dmb_ht_lock);
>     153			return -EINVAL;
>     154		}
>     155		hash_del(&dmb_node->list);
>     156		write_unlock(&ldev->dmb_ht_lock);
>     157	
>     158		clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
>   > 159		vfree(dmb_node->cpu_addr);
>     160		kfree(dmb_node);
>     161	
>     162		return 0;
>     163	}
>     164	
> 
