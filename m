Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB507B5D84
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjJBXFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjJBXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:05:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA31AC;
        Mon,  2 Oct 2023 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696287903; x=1727823903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W+wHs3ShPE3V3vqCEk3iLvApEclOhjapQFsJWjm31Jg=;
  b=IqlKT3F50gxTOsmgc1FmJtslxpAIRfBf16udINfraIKqo0pymd8Z1z8E
   CdgYBISGw0tS6dglRas5bhgYbW3Sc2ETZR3UVBDRUXlhCqQZOiSyu0bXh
   RVpcXa/f2ZfqCccy8I8RFgEvoN8JlMB56wKW9rBAynhBnywCaH7Rxccnu
   nAaN6hHtnOh9fBFFpg9ONVjyY/GSnlOYWHFQEG8b4DMf/4aVMX/m/dGZ2
   2N3/2udN2fTB3RxEjja0pwHguZVpf0rWgXAhMHXsbIofEAepkolWOP/j0
   /GhfPzzM8zrMd3/Q1vjvXms9aGhXcaXn2VdaKCiFyQgjW9Zc04i8k8j09
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="385578736"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="385578736"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 16:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="821030060"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="821030060"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 02 Oct 2023 16:04:55 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnRy9-0006Ud-2j;
        Mon, 02 Oct 2023 23:04:53 +0000
Date:   Tue, 3 Oct 2023 07:04:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, minyard@acm.org, joel@jms.id.au,
        andrew@aj.id.au, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, aladyshev22@gmail.com,
        jk@codeconstruct.com.au, matt@codeconstruct.com.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mctp: Add MCTP-over-KCS transport binding
Message-ID: <202310030640.tYeSJjeI-lkp@intel.com>
References: <20231002143441.545-4-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002143441.545-4-aladyshev22@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cminyard-ipmi/for-next]
[also build test WARNING on linus/master v6.6-rc4 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Konstantin-Aladyshev/ipmi-Move-KCS-headers-to-common-include-folder/20231002-223632
base:   https://github.com/cminyard/linux-ipmi for-next
patch link:    https://lore.kernel.org/r/20231002143441.545-4-aladyshev22%40gmail.com
patch subject: [PATCH v2 3/3] mctp: Add MCTP-over-KCS transport binding
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20231003/202310030640.tYeSJjeI-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231003/202310030640.tYeSJjeI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310030640.tYeSJjeI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/mctp/mctp-kcs.c: In function 'kcs_bmc_mctp_add_device':
>> drivers/net/mctp/mctp-kcs.c:494:31: warning: passing argument 2 of 'dev_err_probe' makes integer from pointer without a cast [-Wint-conversion]
     494 |                               "alloc_netdev failed for KCS channel %d\n",
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                               |
         |                               char *
   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14,
                    from include/linux/i2c.h:13,
                    from drivers/net/mctp/mctp-kcs.c:16:
   include/linux/dev_printk.h:277:64: note: expected 'int' but argument is of type 'char *'
     277 | __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
         |                                                            ~~~~^~~
>> drivers/net/mctp/mctp-kcs.c:495:38: warning: passing argument 3 of 'dev_err_probe' makes pointer from integer without a cast [-Wint-conversion]
     495 |                               kcs_bmc->channel);
         |                               ~~~~~~~^~~~~~~~~
         |                                      |
         |                                      u32 {aka unsigned int}
   include/linux/dev_printk.h:277:81: note: expected 'const char *' but argument is of type 'u32' {aka 'unsigned int'}
     277 | __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
         |                                                                     ~~~~~~~~~~~~^~~
   drivers/net/mctp/mctp-kcs.c:507:25: warning: passing argument 2 of 'dev_err_probe' makes integer from pointer without a cast [-Wint-conversion]
     507 |                         "failed to allocate data_in buffer for KCS channel %d\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         char *
   include/linux/dev_printk.h:277:64: note: expected 'int' but argument is of type 'char *'
     277 | __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
         |                                                            ~~~~^~~
   drivers/net/mctp/mctp-kcs.c:508:32: warning: passing argument 3 of 'dev_err_probe' makes pointer from integer without a cast [-Wint-conversion]
     508 |                         kcs_bmc->channel);
         |                         ~~~~~~~^~~~~~~~~
         |                                |
         |                                u32 {aka unsigned int}
   include/linux/dev_printk.h:277:81: note: expected 'const char *' but argument is of type 'u32' {aka 'unsigned int'}
     277 | __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
         |                                                                     ~~~~~~~~~~~~^~~
   drivers/net/mctp/mctp-kcs.c:516:25: warning: passing argument 2 of 'dev_err_probe' makes integer from pointer without a cast [-Wint-conversion]
     516 |                         "failed to allocate data_out buffer for KCS channel %d\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         char *
   include/linux/dev_printk.h:277:64: note: expected 'int' but argument is of type 'char *'
     277 | __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
         |                                                            ~~~~^~~
   drivers/net/mctp/mctp-kcs.c:517:32: warning: passing argument 3 of 'dev_err_probe' makes pointer from integer without a cast [-Wint-conversion]
     517 |                         kcs_bmc->channel);
         |                         ~~~~~~~^~~~~~~~~
         |                                |
         |                                u32 {aka unsigned int}
   include/linux/dev_printk.h:277:81: note: expected 'const char *' but argument is of type 'u32' {aka 'unsigned int'}
     277 | __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
         |                                                                     ~~~~~~~~~~~~^~~


vim +/dev_err_probe +494 drivers/net/mctp/mctp-kcs.c

   481	
   482	static int kcs_bmc_mctp_add_device(struct kcs_bmc_device *kcs_bmc)
   483	{
   484		struct mctp_kcs *mkcs;
   485		struct net_device *ndev;
   486		char name[32];
   487		int rc;
   488	
   489		snprintf(name, sizeof(name), "mctpkcs%d", kcs_bmc->channel);
   490	
   491		ndev = alloc_netdev(sizeof(*mkcs), name, NET_NAME_ENUM, mctp_kcs_setup);
   492		if (!ndev) {
   493			dev_err_probe(kcs_bmc->dev,
 > 494				      "alloc_netdev failed for KCS channel %d\n",
 > 495				      kcs_bmc->channel);
   496			return -ENOMEM;
   497		}
   498	
   499		mkcs = netdev_priv(ndev);
   500		mkcs->netdev = ndev;
   501		mkcs->client.dev = kcs_bmc;
   502		mkcs->client.ops = &kcs_bmc_mctp_client_ops;
   503		mkcs->data_in = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
   504		if (!mkcs->data_in) {
   505			dev_err_probe(
   506				kcs_bmc->dev,
   507				"failed to allocate data_in buffer for KCS channel %d\n",
   508				kcs_bmc->channel);
   509			rc = -ENOMEM;
   510			goto free_netdev;
   511		}
   512		mkcs->data_out = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
   513		if (!mkcs->data_out) {
   514			dev_err_probe(
   515				kcs_bmc->dev,
   516				"failed to allocate data_out buffer for KCS channel %d\n",
   517				kcs_bmc->channel);
   518			rc = -ENOMEM;
   519			goto free_netdev;
   520		}
   521	
   522		INIT_WORK(&mkcs->rx_work, mctp_kcs_rx_work);
   523	
   524		rc = register_netdev(ndev);
   525		if (rc)
   526			goto free_netdev;
   527	
   528		spin_lock_irq(&kcs_bmc_mctp_instances_lock);
   529		list_add(&mkcs->entry, &kcs_bmc_mctp_instances);
   530		spin_unlock_irq(&kcs_bmc_mctp_instances_lock);
   531	
   532		dev_info(kcs_bmc->dev, "Add MCTP client for the KCS channel %d",
   533			 kcs_bmc->channel);
   534		return 0;
   535	
   536	free_netdev:
   537		free_netdev(ndev);
   538	
   539		return rc;
   540	}
   541	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
