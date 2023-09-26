Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD807AF803
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjI0CMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjI0CKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:10:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09231BFF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695772188; x=1727308188;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ALIsCihEjAusBPRhVXWFL0sGVqJD45g1iKveAbniZtM=;
  b=aqxM8k2jGMXPtd1u8lwnAa+4sGy+ub3841Y7neFU5s98GIdrne9gFCsW
   Tl3fRWAFRC/ZSUfRQR2cu7Jeq/+YqiZ6QplL3t6YV1q8tBq5RRZG9eSjw
   iRzp9ozpGQhdglGPWIE5lHBkgqrDfjoRfkXWifd02haydnN73aa0goUSH
   mUDoN6lw2YtiY28DkWOXJq25Q2uNOKF53QK6VdYZQ3td+L7oCFWAJoJpI
   zl8hvlI3MkWJG8e/+d3PUC6ctO6mPp2Hzn2QwBEwEIHlPbDE3XQMOuXmu
   +LRjMOneUt8pAlYBOuGhkRiJl5y3vg6O7xayiNh/NKENVuG4DDloUMp7R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381590822"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="381590822"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 16:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="698634049"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="698634049"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2023 16:49:46 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlHoF-0003Tn-32;
        Tue, 26 Sep 2023 23:49:43 +0000
Date:   Wed, 27 Sep 2023 07:49:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/sysdev/fsl_rmu.c:544: warning: Function parameter or
 member 'pw' not described in 'fsl_rio_port_write_init'
Message-ID: <202309270747.cirkf8k8-lkp@intel.com>
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
head:   0e945134b680040b8613e962f586d91b6d40292d
commit: c265735ff5b1f13272e2bfb196f5c55f9b3c9bac powerpc/85xx: Mark some functions static and add missing includes to fix no previous prototype error
date:   5 weeks ago
config: powerpc-randconfig-003-20230927 (https://download.01.org/0day-ci/archive/20230927/202309270747.cirkf8k8-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309270747.cirkf8k8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309270747.cirkf8k8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/sysdev/fsl_rmu.c:544: warning: Function parameter or member 'pw' not described in 'fsl_rio_port_write_init'
>> arch/powerpc/sysdev/fsl_rmu.c:544: warning: Excess function parameter 'mport' description in 'fsl_rio_port_write_init'
>> arch/powerpc/sysdev/fsl_rmu.c:1028: warning: Function parameter or member 'dbell' not described in 'fsl_rio_doorbell_init'
>> arch/powerpc/sysdev/fsl_rmu.c:1028: warning: Excess function parameter 'mport' description in 'fsl_rio_doorbell_init'


vim +544 arch/powerpc/sysdev/fsl_rmu.c

6ec4bedbf153a8 Liu Gang        2011-11-12  533  
6ec4bedbf153a8 Liu Gang        2011-11-12  534  /**
6ec4bedbf153a8 Liu Gang        2011-11-12  535   * fsl_rio_port_write_init - MPC85xx port write interface init
6ec4bedbf153a8 Liu Gang        2011-11-12  536   * @mport: Master port implementing the port write unit
6ec4bedbf153a8 Liu Gang        2011-11-12  537   *
6ec4bedbf153a8 Liu Gang        2011-11-12  538   * Initializes port write unit hardware and DMA buffer
6ec4bedbf153a8 Liu Gang        2011-11-12  539   * ring. Called from fsl_rio_setup(). Returns %0 on success
6ec4bedbf153a8 Liu Gang        2011-11-12  540   * or %-ENOMEM on failure.
6ec4bedbf153a8 Liu Gang        2011-11-12  541   */
6ec4bedbf153a8 Liu Gang        2011-11-12  542  
abc3aeae3aaa5c Liu Gang        2011-11-12  543  int fsl_rio_port_write_init(struct fsl_rio_pw *pw)
6ec4bedbf153a8 Liu Gang        2011-11-12 @544  {
6ec4bedbf153a8 Liu Gang        2011-11-12  545  	int rc = 0;
6ec4bedbf153a8 Liu Gang        2011-11-12  546  
6ec4bedbf153a8 Liu Gang        2011-11-12  547  	/* Following configurations require a disabled port write controller */
abc3aeae3aaa5c Liu Gang        2011-11-12  548  	out_be32(&pw->pw_regs->pwmr,
abc3aeae3aaa5c Liu Gang        2011-11-12  549  		 in_be32(&pw->pw_regs->pwmr) & ~RIO_IPWMR_PWE);
6ec4bedbf153a8 Liu Gang        2011-11-12  550  
6ec4bedbf153a8 Liu Gang        2011-11-12  551  	/* Initialize port write */
abc3aeae3aaa5c Liu Gang        2011-11-12  552  	pw->port_write_msg.virt = dma_alloc_coherent(pw->dev,
6ec4bedbf153a8 Liu Gang        2011-11-12  553  					RIO_PW_MSG_SIZE,
abc3aeae3aaa5c Liu Gang        2011-11-12  554  					&pw->port_write_msg.phys, GFP_KERNEL);
abc3aeae3aaa5c Liu Gang        2011-11-12  555  	if (!pw->port_write_msg.virt) {
6ec4bedbf153a8 Liu Gang        2011-11-12  556  		pr_err("RIO: unable allocate port write queue\n");
6ec4bedbf153a8 Liu Gang        2011-11-12  557  		return -ENOMEM;
6ec4bedbf153a8 Liu Gang        2011-11-12  558  	}
6ec4bedbf153a8 Liu Gang        2011-11-12  559  
abc3aeae3aaa5c Liu Gang        2011-11-12  560  	pw->port_write_msg.err_count = 0;
abc3aeae3aaa5c Liu Gang        2011-11-12  561  	pw->port_write_msg.discard_count = 0;
6ec4bedbf153a8 Liu Gang        2011-11-12  562  
6ec4bedbf153a8 Liu Gang        2011-11-12  563  	/* Point dequeue/enqueue pointers at first entry */
abc3aeae3aaa5c Liu Gang        2011-11-12  564  	out_be32(&pw->pw_regs->epwqbar, 0);
abc3aeae3aaa5c Liu Gang        2011-11-12  565  	out_be32(&pw->pw_regs->pwqbar, (u32) pw->port_write_msg.phys);
6ec4bedbf153a8 Liu Gang        2011-11-12  566  
6ec4bedbf153a8 Liu Gang        2011-11-12  567  	pr_debug("EIPWQBAR: 0x%08x IPWQBAR: 0x%08x\n",
abc3aeae3aaa5c Liu Gang        2011-11-12  568  		 in_be32(&pw->pw_regs->epwqbar),
abc3aeae3aaa5c Liu Gang        2011-11-12  569  		 in_be32(&pw->pw_regs->pwqbar));
6ec4bedbf153a8 Liu Gang        2011-11-12  570  
6ec4bedbf153a8 Liu Gang        2011-11-12  571  	/* Clear interrupt status IPWSR */
abc3aeae3aaa5c Liu Gang        2011-11-12  572  	out_be32(&pw->pw_regs->pwsr,
6ec4bedbf153a8 Liu Gang        2011-11-12  573  		 (RIO_IPWSR_TE | RIO_IPWSR_QFI | RIO_IPWSR_PWD));
6ec4bedbf153a8 Liu Gang        2011-11-12  574  
446957ba512714 Adam Buchbinder 2016-02-24  575  	/* Configure port write controller for snooping enable all reporting,
6ec4bedbf153a8 Liu Gang        2011-11-12  576  	   clear queue full */
abc3aeae3aaa5c Liu Gang        2011-11-12  577  	out_be32(&pw->pw_regs->pwmr,
6ec4bedbf153a8 Liu Gang        2011-11-12  578  		 RIO_IPWMR_SEN | RIO_IPWMR_QFIE | RIO_IPWMR_EIE | RIO_IPWMR_CQ);
6ec4bedbf153a8 Liu Gang        2011-11-12  579  
6ec4bedbf153a8 Liu Gang        2011-11-12  580  
6ec4bedbf153a8 Liu Gang        2011-11-12  581  	/* Hook up port-write handler */
abc3aeae3aaa5c Liu Gang        2011-11-12  582  	rc = request_irq(IRQ_RIO_PW(pw), fsl_rio_port_write_handler,
abc3aeae3aaa5c Liu Gang        2011-11-12  583  			IRQF_SHARED, "port-write", (void *)pw);
6ec4bedbf153a8 Liu Gang        2011-11-12  584  	if (rc < 0) {
6ec4bedbf153a8 Liu Gang        2011-11-12  585  		pr_err("MPC85xx RIO: unable to request inbound doorbell irq");
6ec4bedbf153a8 Liu Gang        2011-11-12  586  		goto err_out;
6ec4bedbf153a8 Liu Gang        2011-11-12  587  	}
6ec4bedbf153a8 Liu Gang        2011-11-12  588  	/* Enable Error Interrupt */
6ec4bedbf153a8 Liu Gang        2011-11-12  589  	out_be32((u32 *)(rio_regs_win + RIO_LTLEECSR), LTLEECSR_ENABLE_ALL);
6ec4bedbf153a8 Liu Gang        2011-11-12  590  
abc3aeae3aaa5c Liu Gang        2011-11-12  591  	INIT_WORK(&pw->pw_work, fsl_pw_dpc);
abc3aeae3aaa5c Liu Gang        2011-11-12  592  	spin_lock_init(&pw->pw_fifo_lock);
abc3aeae3aaa5c Liu Gang        2011-11-12  593  	if (kfifo_alloc(&pw->pw_fifo, RIO_PW_MSG_SIZE * 32, GFP_KERNEL)) {
6ec4bedbf153a8 Liu Gang        2011-11-12  594  		pr_err("FIFO allocation failed\n");
6ec4bedbf153a8 Liu Gang        2011-11-12  595  		rc = -ENOMEM;
6ec4bedbf153a8 Liu Gang        2011-11-12  596  		goto err_out_irq;
6ec4bedbf153a8 Liu Gang        2011-11-12  597  	}
6ec4bedbf153a8 Liu Gang        2011-11-12  598  
6ec4bedbf153a8 Liu Gang        2011-11-12  599  	pr_debug("IPWMR: 0x%08x IPWSR: 0x%08x\n",
abc3aeae3aaa5c Liu Gang        2011-11-12  600  		 in_be32(&pw->pw_regs->pwmr),
abc3aeae3aaa5c Liu Gang        2011-11-12  601  		 in_be32(&pw->pw_regs->pwsr));
6ec4bedbf153a8 Liu Gang        2011-11-12  602  
6ec4bedbf153a8 Liu Gang        2011-11-12  603  	return rc;
6ec4bedbf153a8 Liu Gang        2011-11-12  604  
6ec4bedbf153a8 Liu Gang        2011-11-12  605  err_out_irq:
abc3aeae3aaa5c Liu Gang        2011-11-12  606  	free_irq(IRQ_RIO_PW(pw), (void *)pw);
6ec4bedbf153a8 Liu Gang        2011-11-12  607  err_out:
abc3aeae3aaa5c Liu Gang        2011-11-12  608  	dma_free_coherent(pw->dev, RIO_PW_MSG_SIZE,
abc3aeae3aaa5c Liu Gang        2011-11-12  609  		pw->port_write_msg.virt,
abc3aeae3aaa5c Liu Gang        2011-11-12  610  		pw->port_write_msg.phys);
6ec4bedbf153a8 Liu Gang        2011-11-12  611  	return rc;
6ec4bedbf153a8 Liu Gang        2011-11-12  612  }
6ec4bedbf153a8 Liu Gang        2011-11-12  613  

:::::: The code at line 544 was first introduced by commit
:::::: 6ec4bedbf153a8ef71aeba99a40efef556b57798 fsl-rio: Split rio driver into two parts, RapidIO endpoint and message unit

:::::: TO: Liu Gang <Gang.Liu@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
