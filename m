Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF6D7BB47E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjJFJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjJFJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:49:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0092BF9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696585751; x=1728121751;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pet488w0Y0Swdj6OCTro3BCzAVuAiviO6uPaN1rOXWY=;
  b=TOyjk4IxJ4TWWmDKBaXiSEqt6uajorre/vfm5BiQh/eFSrKxbppiY9QZ
   3IfrsfaD1oX0sCXj7mPEiLsiQXILlNx5HUD97cBE45VH4F1DRzwRJ4vW4
   IJmltnKxeboUFCXBMsxJ+toM1ZW/415juq5TbSSeBSYYR/vBtfhh3Bgkf
   HlOiWwtcWQWTxfSTmo7LLFpcIYY3+YaeXFnP6AXceMMXpa2kUdTWTHG7q
   t5fZJdY762BfHF/j+UIsQbLWOfX0yvlyc720FR8w06atZTw7NFlT+itV6
   fyEHT4vvuvI/s2Py5brcd0qtmSS+o5ThjDXA1xdOkeGwJzg5nUAuNj6ly
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="469989084"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="469989084"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 02:49:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="822450220"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="822450220"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2023 02:49:09 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qohSF-000MTw-1z;
        Fri, 06 Oct 2023 09:49:07 +0000
Date:   Fri, 6 Oct 2023 17:48:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: drivers/char/tpm/tpm_ftpm_tee.c:218: warning: Function parameter or
 member 'dev' not described in 'ftpm_tee_probe'
Message-ID: <202310061753.IxfS0Pxh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b78b18fb8ee19f7a05f20c3abc865b3bfe182884
commit: 9f1944c23c8cb1c033b73de80cf6c612a2a80a2b tpm_ftpm_tee: register driver on TEE bus
date:   3 years, 3 months ago
config: arm64-randconfig-004-20230921 (https://download.01.org/0day-ci/archive/20231006/202310061753.IxfS0Pxh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310061753.IxfS0Pxh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310061753.IxfS0Pxh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/char/tpm/tpm_ftpm_tee.c:218: warning: Function parameter or member 'dev' not described in 'ftpm_tee_probe'
>> drivers/char/tpm/tpm_ftpm_tee.c:218: warning: Excess function parameter 'pdev' description in 'ftpm_tee_probe'
>> drivers/char/tpm/tpm_ftpm_tee.c:314: warning: Function parameter or member 'dev' not described in 'ftpm_tee_remove'
>> drivers/char/tpm/tpm_ftpm_tee.c:314: warning: Excess function parameter 'pdev' description in 'ftpm_tee_remove'


vim +218 drivers/char/tpm/tpm_ftpm_tee.c

09e574831b277a Sasha Levin    2019-07-05  209  
09e574831b277a Sasha Levin    2019-07-05  210  /**
1760eb689ed68c Pavel Tatashin 2019-12-04  211   * ftpm_tee_probe() - initialize the fTPM
09e574831b277a Sasha Levin    2019-07-05  212   * @pdev: the platform_device description.
09e574831b277a Sasha Levin    2019-07-05  213   *
09e574831b277a Sasha Levin    2019-07-05  214   * Return:
09e574831b277a Sasha Levin    2019-07-05  215   *	On success, 0. On failure, -errno.
09e574831b277a Sasha Levin    2019-07-05  216   */
9f1944c23c8cb1 Maxim Uvarov   2020-06-18  217  static int ftpm_tee_probe(struct device *dev)
09e574831b277a Sasha Levin    2019-07-05 @218  {
09e574831b277a Sasha Levin    2019-07-05  219  	int rc;
09e574831b277a Sasha Levin    2019-07-05  220  	struct tpm_chip *chip;
09e574831b277a Sasha Levin    2019-07-05  221  	struct ftpm_tee_private *pvt_data = NULL;
09e574831b277a Sasha Levin    2019-07-05  222  	struct tee_ioctl_open_session_arg sess_arg;
09e574831b277a Sasha Levin    2019-07-05  223  
09e574831b277a Sasha Levin    2019-07-05  224  	pvt_data = devm_kzalloc(dev, sizeof(struct ftpm_tee_private),
09e574831b277a Sasha Levin    2019-07-05  225  				GFP_KERNEL);
09e574831b277a Sasha Levin    2019-07-05  226  	if (!pvt_data)
09e574831b277a Sasha Levin    2019-07-05  227  		return -ENOMEM;
09e574831b277a Sasha Levin    2019-07-05  228  
09e574831b277a Sasha Levin    2019-07-05  229  	dev_set_drvdata(dev, pvt_data);
09e574831b277a Sasha Levin    2019-07-05  230  
09e574831b277a Sasha Levin    2019-07-05  231  	/* Open context with TEE driver */
09e574831b277a Sasha Levin    2019-07-05  232  	pvt_data->ctx = tee_client_open_context(NULL, ftpm_tee_match, NULL,
09e574831b277a Sasha Levin    2019-07-05  233  						NULL);
09e574831b277a Sasha Levin    2019-07-05  234  	if (IS_ERR(pvt_data->ctx)) {
09e574831b277a Sasha Levin    2019-07-05  235  		if (PTR_ERR(pvt_data->ctx) == -ENOENT)
09e574831b277a Sasha Levin    2019-07-05  236  			return -EPROBE_DEFER;
09e574831b277a Sasha Levin    2019-07-05  237  		dev_err(dev, "%s: tee_client_open_context failed\n", __func__);
09e574831b277a Sasha Levin    2019-07-05  238  		return PTR_ERR(pvt_data->ctx);
09e574831b277a Sasha Levin    2019-07-05  239  	}
09e574831b277a Sasha Levin    2019-07-05  240  
09e574831b277a Sasha Levin    2019-07-05  241  	/* Open a session with fTPM TA */
09e574831b277a Sasha Levin    2019-07-05  242  	memset(&sess_arg, 0, sizeof(sess_arg));
09e574831b277a Sasha Levin    2019-07-05  243  	memcpy(sess_arg.uuid, ftpm_ta_uuid.b, TEE_IOCTL_UUID_LEN);
09e574831b277a Sasha Levin    2019-07-05  244  	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
09e574831b277a Sasha Levin    2019-07-05  245  	sess_arg.num_params = 0;
09e574831b277a Sasha Levin    2019-07-05  246  
09e574831b277a Sasha Levin    2019-07-05  247  	rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
09e574831b277a Sasha Levin    2019-07-05  248  	if ((rc < 0) || (sess_arg.ret != 0)) {
09e574831b277a Sasha Levin    2019-07-05  249  		dev_err(dev, "%s: tee_client_open_session failed, err=%x\n",
09e574831b277a Sasha Levin    2019-07-05  250  			__func__, sess_arg.ret);
09e574831b277a Sasha Levin    2019-07-05  251  		rc = -EINVAL;
09e574831b277a Sasha Levin    2019-07-05  252  		goto out_tee_session;
09e574831b277a Sasha Levin    2019-07-05  253  	}
09e574831b277a Sasha Levin    2019-07-05  254  	pvt_data->session = sess_arg.session;
09e574831b277a Sasha Levin    2019-07-05  255  
09e574831b277a Sasha Levin    2019-07-05  256  	/* Allocate dynamic shared memory with fTPM TA */
09e574831b277a Sasha Levin    2019-07-05  257  	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
09e574831b277a Sasha Levin    2019-07-05  258  				      MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE,
09e574831b277a Sasha Levin    2019-07-05  259  				      TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
09e574831b277a Sasha Levin    2019-07-05  260  	if (IS_ERR(pvt_data->shm)) {
09e574831b277a Sasha Levin    2019-07-05  261  		dev_err(dev, "%s: tee_shm_alloc failed\n", __func__);
09e574831b277a Sasha Levin    2019-07-05  262  		rc = -ENOMEM;
09e574831b277a Sasha Levin    2019-07-05  263  		goto out_shm_alloc;
09e574831b277a Sasha Levin    2019-07-05  264  	}
09e574831b277a Sasha Levin    2019-07-05  265  
09e574831b277a Sasha Levin    2019-07-05  266  	/* Allocate new struct tpm_chip instance */
09e574831b277a Sasha Levin    2019-07-05  267  	chip = tpm_chip_alloc(dev, &ftpm_tee_tpm_ops);
09e574831b277a Sasha Levin    2019-07-05  268  	if (IS_ERR(chip)) {
09e574831b277a Sasha Levin    2019-07-05  269  		dev_err(dev, "%s: tpm_chip_alloc failed\n", __func__);
09e574831b277a Sasha Levin    2019-07-05  270  		rc = PTR_ERR(chip);
09e574831b277a Sasha Levin    2019-07-05  271  		goto out_chip_alloc;
09e574831b277a Sasha Levin    2019-07-05  272  	}
09e574831b277a Sasha Levin    2019-07-05  273  
09e574831b277a Sasha Levin    2019-07-05  274  	pvt_data->chip = chip;
09e574831b277a Sasha Levin    2019-07-05  275  	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2;
09e574831b277a Sasha Levin    2019-07-05  276  
09e574831b277a Sasha Levin    2019-07-05  277  	/* Create a character device for the fTPM */
09e574831b277a Sasha Levin    2019-07-05  278  	rc = tpm_chip_register(pvt_data->chip);
09e574831b277a Sasha Levin    2019-07-05  279  	if (rc) {
09e574831b277a Sasha Levin    2019-07-05  280  		dev_err(dev, "%s: tpm_chip_register failed with rc=%d\n",
09e574831b277a Sasha Levin    2019-07-05  281  			__func__, rc);
09e574831b277a Sasha Levin    2019-07-05  282  		goto out_chip;
09e574831b277a Sasha Levin    2019-07-05  283  	}
09e574831b277a Sasha Levin    2019-07-05  284  
09e574831b277a Sasha Levin    2019-07-05  285  	return 0;
09e574831b277a Sasha Levin    2019-07-05  286  
09e574831b277a Sasha Levin    2019-07-05  287  out_chip:
09e574831b277a Sasha Levin    2019-07-05  288  	put_device(&pvt_data->chip->dev);
09e574831b277a Sasha Levin    2019-07-05  289  out_chip_alloc:
09e574831b277a Sasha Levin    2019-07-05  290  	tee_shm_free(pvt_data->shm);
09e574831b277a Sasha Levin    2019-07-05  291  out_shm_alloc:
09e574831b277a Sasha Levin    2019-07-05  292  	tee_client_close_session(pvt_data->ctx, pvt_data->session);
09e574831b277a Sasha Levin    2019-07-05  293  out_tee_session:
09e574831b277a Sasha Levin    2019-07-05  294  	tee_client_close_context(pvt_data->ctx);
09e574831b277a Sasha Levin    2019-07-05  295  
09e574831b277a Sasha Levin    2019-07-05  296  	return rc;
09e574831b277a Sasha Levin    2019-07-05  297  }
09e574831b277a Sasha Levin    2019-07-05  298  
9f1944c23c8cb1 Maxim Uvarov   2020-06-18  299  static int ftpm_plat_tee_probe(struct platform_device *pdev)
9f1944c23c8cb1 Maxim Uvarov   2020-06-18  300  {
9f1944c23c8cb1 Maxim Uvarov   2020-06-18  301  	struct device *dev = &pdev->dev;
9f1944c23c8cb1 Maxim Uvarov   2020-06-18  302  
9f1944c23c8cb1 Maxim Uvarov   2020-06-18  303  	return ftpm_tee_probe(dev);
9f1944c23c8cb1 Maxim Uvarov   2020-06-18  304  }
9f1944c23c8cb1 Maxim Uvarov   2020-06-18  305  
09e574831b277a Sasha Levin    2019-07-05  306  /**
1760eb689ed68c Pavel Tatashin 2019-12-04  307   * ftpm_tee_remove() - remove the TPM device
09e574831b277a Sasha Levin    2019-07-05  308   * @pdev: the platform_device description.
09e574831b277a Sasha Levin    2019-07-05  309   *
09e574831b277a Sasha Levin    2019-07-05  310   * Return:
09e574831b277a Sasha Levin    2019-07-05  311   *	0 always.
09e574831b277a Sasha Levin    2019-07-05  312   */
9f1944c23c8cb1 Maxim Uvarov   2020-06-18  313  static int ftpm_tee_remove(struct device *dev)
09e574831b277a Sasha Levin    2019-07-05 @314  {
9f1944c23c8cb1 Maxim Uvarov   2020-06-18  315  	struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
09e574831b277a Sasha Levin    2019-07-05  316  
09e574831b277a Sasha Levin    2019-07-05  317  	/* Release the chip */
09e574831b277a Sasha Levin    2019-07-05  318  	tpm_chip_unregister(pvt_data->chip);
09e574831b277a Sasha Levin    2019-07-05  319  
09e574831b277a Sasha Levin    2019-07-05  320  	/* frees chip */
09e574831b277a Sasha Levin    2019-07-05  321  	put_device(&pvt_data->chip->dev);
09e574831b277a Sasha Levin    2019-07-05  322  
09e574831b277a Sasha Levin    2019-07-05  323  	/* Free the shared memory pool */
09e574831b277a Sasha Levin    2019-07-05  324  	tee_shm_free(pvt_data->shm);
09e574831b277a Sasha Levin    2019-07-05  325  
09e574831b277a Sasha Levin    2019-07-05  326  	/* close the existing session with fTPM TA*/
09e574831b277a Sasha Levin    2019-07-05  327  	tee_client_close_session(pvt_data->ctx, pvt_data->session);
09e574831b277a Sasha Levin    2019-07-05  328  
09e574831b277a Sasha Levin    2019-07-05  329  	/* close the context with TEE driver */
09e574831b277a Sasha Levin    2019-07-05  330  	tee_client_close_context(pvt_data->ctx);
09e574831b277a Sasha Levin    2019-07-05  331  
09e574831b277a Sasha Levin    2019-07-05  332  	/* memory allocated with devm_kzalloc() is freed automatically */
09e574831b277a Sasha Levin    2019-07-05  333  
09e574831b277a Sasha Levin    2019-07-05  334  	return 0;
09e574831b277a Sasha Levin    2019-07-05  335  }
09e574831b277a Sasha Levin    2019-07-05  336  

:::::: The code at line 218 was first introduced by commit
:::::: 09e574831b277a3f77d78ceadd08a3859a84fdb3 tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE

:::::: TO: Sasha Levin <sashal@kernel.org>
:::::: CC: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
