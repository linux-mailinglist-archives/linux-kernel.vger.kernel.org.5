Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8077F277
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349118AbjHQIv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349170AbjHQIv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:51:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA40F1BFB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692262283; x=1723798283;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G+sD21mSO4RQ/MWPZoiuurSIscQTO0adfME4a4DPXt0=;
  b=F40yTc616MLutjjIy87swK00zSj66Aexn3LHNon80TuyDl1k4s6kHZHw
   LUbvcDfG1wGoHqfEPpNFuxZXlEM5KXyUPSzi9VNMykvgReT+EPhJkXfQ/
   VMerIPmy6e16JndqB/lJ6IRKrf3hwau9cXpFMD55MChr+g4vGF00KchKV
   otnHfE7Ao7cRF1RzvN/0akXRphWUzyfqb9ElAtkv+L+ctNbKDG6MaMTbI
   NcyvO9s5AmBNFdtA0uT2+MVrFC2HEdvgKG9B7PIvQvxE0/wRUK48bUzpc
   mpPqKM0sIq9ZLJvLvSiS0t45DOVyIm7GIPODEZ5aQ35Hw0Xv96NiXEXL6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357718460"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="357718460"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:51:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804552162"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="804552162"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2023 01:51:21 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWYiu-0000y9-2K;
        Thu, 17 Aug 2023 08:51:20 +0000
Date:   Thu, 17 Aug 2023 16:50:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/ac97/bus.c:192: warning: Function parameter or member 'drv'
 not described in 'snd_ac97_codec_driver_register'
Message-ID: <202308171657.J7S4SHI3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 5eab9265759e2fb042aa452931c3d06ab7ab8dae ASoC: PXA: make SND_PXA2XX_SOC_AC97 user-selectable
date:   7 months ago
config: arm-randconfig-r012-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171657.J7S4SHI3-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171657.J7S4SHI3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171657.J7S4SHI3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/ac97/bus.c:192: warning: Function parameter or member 'drv' not described in 'snd_ac97_codec_driver_register'
>> sound/ac97/bus.c:192: warning: Excess function parameter 'dev' description in 'snd_ac97_codec_driver_register'
>> sound/ac97/bus.c:205: warning: Function parameter or member 'drv' not described in 'snd_ac97_codec_driver_unregister'
>> sound/ac97/bus.c:205: warning: Excess function parameter 'dev' description in 'snd_ac97_codec_driver_unregister'
>> sound/ac97/bus.c:351: warning: Function parameter or member 'codecs_pdata' not described in 'snd_ac97_controller_register'


vim +192 sound/ac97/bus.c

74426fbff66eea Robert Jarzmik   2017-09-02  181  
74426fbff66eea Robert Jarzmik   2017-09-02  182  /**
74426fbff66eea Robert Jarzmik   2017-09-02  183   * snd_ac97_codec_driver_register - register an AC97 codec driver
74426fbff66eea Robert Jarzmik   2017-09-02  184   * @dev: AC97 driver codec to register
74426fbff66eea Robert Jarzmik   2017-09-02  185   *
74426fbff66eea Robert Jarzmik   2017-09-02  186   * Register an AC97 codec driver to the ac97 bus driver, aka. the AC97 digital
74426fbff66eea Robert Jarzmik   2017-09-02  187   * controller.
74426fbff66eea Robert Jarzmik   2017-09-02  188   *
74426fbff66eea Robert Jarzmik   2017-09-02  189   * Returns 0 on success or error code
74426fbff66eea Robert Jarzmik   2017-09-02  190   */
74426fbff66eea Robert Jarzmik   2017-09-02  191  int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
74426fbff66eea Robert Jarzmik   2017-09-02 @192  {
74426fbff66eea Robert Jarzmik   2017-09-02  193  	drv->driver.bus = &ac97_bus_type;
74426fbff66eea Robert Jarzmik   2017-09-02  194  	return driver_register(&drv->driver);
74426fbff66eea Robert Jarzmik   2017-09-02  195  }
74426fbff66eea Robert Jarzmik   2017-09-02  196  EXPORT_SYMBOL_GPL(snd_ac97_codec_driver_register);
74426fbff66eea Robert Jarzmik   2017-09-02  197  
74426fbff66eea Robert Jarzmik   2017-09-02  198  /**
74426fbff66eea Robert Jarzmik   2017-09-02  199   * snd_ac97_codec_driver_unregister - unregister an AC97 codec driver
74426fbff66eea Robert Jarzmik   2017-09-02  200   * @dev: AC97 codec driver to unregister
74426fbff66eea Robert Jarzmik   2017-09-02  201   *
74426fbff66eea Robert Jarzmik   2017-09-02  202   * Unregister a previously registered ac97 codec driver.
74426fbff66eea Robert Jarzmik   2017-09-02  203   */
74426fbff66eea Robert Jarzmik   2017-09-02  204  void snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
74426fbff66eea Robert Jarzmik   2017-09-02 @205  {
74426fbff66eea Robert Jarzmik   2017-09-02  206  	driver_unregister(&drv->driver);
74426fbff66eea Robert Jarzmik   2017-09-02  207  }
74426fbff66eea Robert Jarzmik   2017-09-02  208  EXPORT_SYMBOL_GPL(snd_ac97_codec_driver_unregister);
74426fbff66eea Robert Jarzmik   2017-09-02  209  
74426fbff66eea Robert Jarzmik   2017-09-02  210  /**
74426fbff66eea Robert Jarzmik   2017-09-02  211   * snd_ac97_codec_get_platdata - get platform_data
74426fbff66eea Robert Jarzmik   2017-09-02  212   * @adev: the ac97 codec device
74426fbff66eea Robert Jarzmik   2017-09-02  213   *
74426fbff66eea Robert Jarzmik   2017-09-02  214   * For legacy platforms, in order to have platform_data in codec drivers
74426fbff66eea Robert Jarzmik   2017-09-02  215   * available, while ac97 device are auto-created upon probe, this retrieves the
74426fbff66eea Robert Jarzmik   2017-09-02  216   * platdata which was setup on ac97 controller registration.
74426fbff66eea Robert Jarzmik   2017-09-02  217   *
74426fbff66eea Robert Jarzmik   2017-09-02  218   * Returns the platform data pointer
74426fbff66eea Robert Jarzmik   2017-09-02  219   */
74426fbff66eea Robert Jarzmik   2017-09-02  220  void *snd_ac97_codec_get_platdata(const struct ac97_codec_device *adev)
74426fbff66eea Robert Jarzmik   2017-09-02  221  {
74426fbff66eea Robert Jarzmik   2017-09-02  222  	struct ac97_controller *ac97_ctrl = adev->ac97_ctrl;
74426fbff66eea Robert Jarzmik   2017-09-02  223  
74426fbff66eea Robert Jarzmik   2017-09-02  224  	return ac97_ctrl->codecs_pdata[adev->num];
74426fbff66eea Robert Jarzmik   2017-09-02  225  }
74426fbff66eea Robert Jarzmik   2017-09-02  226  EXPORT_SYMBOL_GPL(snd_ac97_codec_get_platdata);
74426fbff66eea Robert Jarzmik   2017-09-02  227  
74426fbff66eea Robert Jarzmik   2017-09-02  228  static void ac97_ctrl_codecs_unregister(struct ac97_controller *ac97_ctrl)
74426fbff66eea Robert Jarzmik   2017-09-02  229  {
74426fbff66eea Robert Jarzmik   2017-09-02  230  	int i;
74426fbff66eea Robert Jarzmik   2017-09-02  231  
74426fbff66eea Robert Jarzmik   2017-09-02  232  	for (i = 0; i < AC97_BUS_MAX_CODECS; i++)
74426fbff66eea Robert Jarzmik   2017-09-02  233  		if (ac97_ctrl->codecs[i]) {
74426fbff66eea Robert Jarzmik   2017-09-02  234  			ac97_ctrl->codecs[i]->ac97_ctrl = &ac97_unbound_ctrl;
74426fbff66eea Robert Jarzmik   2017-09-02  235  			device_unregister(&ac97_ctrl->codecs[i]->dev);
74426fbff66eea Robert Jarzmik   2017-09-02  236  		}
74426fbff66eea Robert Jarzmik   2017-09-02  237  }
74426fbff66eea Robert Jarzmik   2017-09-02  238  
74426fbff66eea Robert Jarzmik   2017-09-02  239  static ssize_t cold_reset_store(struct device *dev,
74426fbff66eea Robert Jarzmik   2017-09-02  240  				struct device_attribute *attr, const char *buf,
74426fbff66eea Robert Jarzmik   2017-09-02  241  				size_t len)
74426fbff66eea Robert Jarzmik   2017-09-02  242  {
74426fbff66eea Robert Jarzmik   2017-09-02  243  	struct ac97_controller *ac97_ctrl;
74426fbff66eea Robert Jarzmik   2017-09-02  244  
74426fbff66eea Robert Jarzmik   2017-09-02  245  	mutex_lock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik   2017-09-02  246  	ac97_ctrl = to_ac97_controller(dev);
74426fbff66eea Robert Jarzmik   2017-09-02  247  	ac97_ctrl->ops->reset(ac97_ctrl);
74426fbff66eea Robert Jarzmik   2017-09-02  248  	mutex_unlock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik   2017-09-02  249  	return len;
74426fbff66eea Robert Jarzmik   2017-09-02  250  }
74426fbff66eea Robert Jarzmik   2017-09-02  251  static DEVICE_ATTR_WO(cold_reset);
74426fbff66eea Robert Jarzmik   2017-09-02  252  
74426fbff66eea Robert Jarzmik   2017-09-02  253  static ssize_t warm_reset_store(struct device *dev,
74426fbff66eea Robert Jarzmik   2017-09-02  254  				struct device_attribute *attr, const char *buf,
74426fbff66eea Robert Jarzmik   2017-09-02  255  				size_t len)
74426fbff66eea Robert Jarzmik   2017-09-02  256  {
74426fbff66eea Robert Jarzmik   2017-09-02  257  	struct ac97_controller *ac97_ctrl;
74426fbff66eea Robert Jarzmik   2017-09-02  258  
74426fbff66eea Robert Jarzmik   2017-09-02  259  	if (!dev)
74426fbff66eea Robert Jarzmik   2017-09-02  260  		return -ENODEV;
74426fbff66eea Robert Jarzmik   2017-09-02  261  
74426fbff66eea Robert Jarzmik   2017-09-02  262  	mutex_lock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik   2017-09-02  263  	ac97_ctrl = to_ac97_controller(dev);
74426fbff66eea Robert Jarzmik   2017-09-02  264  	ac97_ctrl->ops->warm_reset(ac97_ctrl);
74426fbff66eea Robert Jarzmik   2017-09-02  265  	mutex_unlock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik   2017-09-02  266  	return len;
74426fbff66eea Robert Jarzmik   2017-09-02  267  }
74426fbff66eea Robert Jarzmik   2017-09-02  268  static DEVICE_ATTR_WO(warm_reset);
74426fbff66eea Robert Jarzmik   2017-09-02  269  
74426fbff66eea Robert Jarzmik   2017-09-02  270  static struct attribute *ac97_controller_device_attrs[] = {
74426fbff66eea Robert Jarzmik   2017-09-02  271  	&dev_attr_cold_reset.attr,
74426fbff66eea Robert Jarzmik   2017-09-02  272  	&dev_attr_warm_reset.attr,
74426fbff66eea Robert Jarzmik   2017-09-02  273  	NULL
74426fbff66eea Robert Jarzmik   2017-09-02  274  };
74426fbff66eea Robert Jarzmik   2017-09-02  275  
fa2e5a647ed2ed Rikard Falkeborn 2021-01-31  276  static const struct attribute_group ac97_adapter_attr_group = {
74426fbff66eea Robert Jarzmik   2017-09-02  277  	.name	= "ac97_operations",
74426fbff66eea Robert Jarzmik   2017-09-02  278  	.attrs	= ac97_controller_device_attrs,
74426fbff66eea Robert Jarzmik   2017-09-02  279  };
74426fbff66eea Robert Jarzmik   2017-09-02  280  
74426fbff66eea Robert Jarzmik   2017-09-02  281  static const struct attribute_group *ac97_adapter_groups[] = {
74426fbff66eea Robert Jarzmik   2017-09-02  282  	&ac97_adapter_attr_group,
74426fbff66eea Robert Jarzmik   2017-09-02  283  	NULL,
74426fbff66eea Robert Jarzmik   2017-09-02  284  };
74426fbff66eea Robert Jarzmik   2017-09-02  285  
74426fbff66eea Robert Jarzmik   2017-09-02  286  static void ac97_del_adapter(struct ac97_controller *ac97_ctrl)
74426fbff66eea Robert Jarzmik   2017-09-02  287  {
74426fbff66eea Robert Jarzmik   2017-09-02  288  	mutex_lock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik   2017-09-02  289  	ac97_ctrl_codecs_unregister(ac97_ctrl);
74426fbff66eea Robert Jarzmik   2017-09-02  290  	list_del(&ac97_ctrl->controllers);
74426fbff66eea Robert Jarzmik   2017-09-02  291  	mutex_unlock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik   2017-09-02  292  
74426fbff66eea Robert Jarzmik   2017-09-02  293  	device_unregister(&ac97_ctrl->adap);
74426fbff66eea Robert Jarzmik   2017-09-02  294  }
74426fbff66eea Robert Jarzmik   2017-09-02  295  
74426fbff66eea Robert Jarzmik   2017-09-02  296  static void ac97_adapter_release(struct device *dev)
74426fbff66eea Robert Jarzmik   2017-09-02  297  {
74426fbff66eea Robert Jarzmik   2017-09-02  298  	struct ac97_controller *ac97_ctrl;
74426fbff66eea Robert Jarzmik   2017-09-02  299  
74426fbff66eea Robert Jarzmik   2017-09-02  300  	ac97_ctrl = to_ac97_controller(dev);
74426fbff66eea Robert Jarzmik   2017-09-02  301  	idr_remove(&ac97_adapter_idr, ac97_ctrl->nr);
74426fbff66eea Robert Jarzmik   2017-09-02  302  	dev_dbg(&ac97_ctrl->adap, "adapter unregistered by %s\n",
74426fbff66eea Robert Jarzmik   2017-09-02  303  		dev_name(ac97_ctrl->parent));
74426fbff66eea Robert Jarzmik   2017-09-02  304  }
74426fbff66eea Robert Jarzmik   2017-09-02  305  
74426fbff66eea Robert Jarzmik   2017-09-02  306  static const struct device_type ac97_adapter_type = {
74426fbff66eea Robert Jarzmik   2017-09-02  307  	.groups		= ac97_adapter_groups,
74426fbff66eea Robert Jarzmik   2017-09-02  308  	.release	= ac97_adapter_release,
74426fbff66eea Robert Jarzmik   2017-09-02  309  };
74426fbff66eea Robert Jarzmik   2017-09-02  310  
74426fbff66eea Robert Jarzmik   2017-09-02  311  static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
74426fbff66eea Robert Jarzmik   2017-09-02  312  {
74426fbff66eea Robert Jarzmik   2017-09-02  313  	int ret;
74426fbff66eea Robert Jarzmik   2017-09-02  314  
74426fbff66eea Robert Jarzmik   2017-09-02  315  	mutex_lock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik   2017-09-02  316  	ret = idr_alloc(&ac97_adapter_idr, ac97_ctrl, 0, 0, GFP_KERNEL);
74426fbff66eea Robert Jarzmik   2017-09-02  317  	ac97_ctrl->nr = ret;
74426fbff66eea Robert Jarzmik   2017-09-02  318  	if (ret >= 0) {
74426fbff66eea Robert Jarzmik   2017-09-02  319  		dev_set_name(&ac97_ctrl->adap, "ac97-%d", ret);
74426fbff66eea Robert Jarzmik   2017-09-02  320  		ac97_ctrl->adap.type = &ac97_adapter_type;
74426fbff66eea Robert Jarzmik   2017-09-02  321  		ac97_ctrl->adap.parent = ac97_ctrl->parent;
74426fbff66eea Robert Jarzmik   2017-09-02  322  		ret = device_register(&ac97_ctrl->adap);
74426fbff66eea Robert Jarzmik   2017-09-02  323  		if (ret)
74426fbff66eea Robert Jarzmik   2017-09-02  324  			put_device(&ac97_ctrl->adap);
74426fbff66eea Robert Jarzmik   2017-09-02  325  	}
74426fbff66eea Robert Jarzmik   2017-09-02  326  	if (!ret)
74426fbff66eea Robert Jarzmik   2017-09-02  327  		list_add(&ac97_ctrl->controllers, &ac97_controllers);
74426fbff66eea Robert Jarzmik   2017-09-02  328  	mutex_unlock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik   2017-09-02  329  
74426fbff66eea Robert Jarzmik   2017-09-02  330  	if (!ret)
74426fbff66eea Robert Jarzmik   2017-09-02  331  		dev_dbg(&ac97_ctrl->adap, "adapter registered by %s\n",
74426fbff66eea Robert Jarzmik   2017-09-02  332  			dev_name(ac97_ctrl->parent));
74426fbff66eea Robert Jarzmik   2017-09-02  333  	return ret;
74426fbff66eea Robert Jarzmik   2017-09-02  334  }
74426fbff66eea Robert Jarzmik   2017-09-02  335  
74426fbff66eea Robert Jarzmik   2017-09-02  336  /**
74426fbff66eea Robert Jarzmik   2017-09-02  337   * snd_ac97_controller_register - register an ac97 controller
74426fbff66eea Robert Jarzmik   2017-09-02  338   * @ops: the ac97 bus operations
74426fbff66eea Robert Jarzmik   2017-09-02  339   * @dev: the device providing the ac97 DC function
74426fbff66eea Robert Jarzmik   2017-09-02  340   * @slots_available: mask of the ac97 codecs that can be scanned and probed
74426fbff66eea Robert Jarzmik   2017-09-02  341   *                   bit0 => codec 0, bit1 => codec 1 ... bit 3 => codec 3
74426fbff66eea Robert Jarzmik   2017-09-02  342   *
74426fbff66eea Robert Jarzmik   2017-09-02  343   * Register a digital controller which can control up to 4 ac97 codecs. This is
74426fbff66eea Robert Jarzmik   2017-09-02  344   * the controller side of the AC97 AC-link, while the slave side are the codecs.
74426fbff66eea Robert Jarzmik   2017-09-02  345   *
74426fbff66eea Robert Jarzmik   2017-09-02  346   * Returns a valid controller upon success, negative pointer value upon error
74426fbff66eea Robert Jarzmik   2017-09-02  347   */
74426fbff66eea Robert Jarzmik   2017-09-02  348  struct ac97_controller *snd_ac97_controller_register(
74426fbff66eea Robert Jarzmik   2017-09-02  349  	const struct ac97_controller_ops *ops, struct device *dev,
74426fbff66eea Robert Jarzmik   2017-09-02  350  	unsigned short slots_available, void **codecs_pdata)
74426fbff66eea Robert Jarzmik   2017-09-02 @351  {
74426fbff66eea Robert Jarzmik   2017-09-02  352  	struct ac97_controller *ac97_ctrl;
74426fbff66eea Robert Jarzmik   2017-09-02  353  	int ret, i;
74426fbff66eea Robert Jarzmik   2017-09-02  354  
74426fbff66eea Robert Jarzmik   2017-09-02  355  	ac97_ctrl = kzalloc(sizeof(*ac97_ctrl), GFP_KERNEL);
74426fbff66eea Robert Jarzmik   2017-09-02  356  	if (!ac97_ctrl)
74426fbff66eea Robert Jarzmik   2017-09-02  357  		return ERR_PTR(-ENOMEM);
74426fbff66eea Robert Jarzmik   2017-09-02  358  
74426fbff66eea Robert Jarzmik   2017-09-02  359  	for (i = 0; i < AC97_BUS_MAX_CODECS && codecs_pdata; i++)
74426fbff66eea Robert Jarzmik   2017-09-02  360  		ac97_ctrl->codecs_pdata[i] = codecs_pdata[i];
74426fbff66eea Robert Jarzmik   2017-09-02  361  
74426fbff66eea Robert Jarzmik   2017-09-02  362  	ac97_ctrl->ops = ops;
74426fbff66eea Robert Jarzmik   2017-09-02  363  	ac97_ctrl->slots_available = slots_available;
74426fbff66eea Robert Jarzmik   2017-09-02  364  	ac97_ctrl->parent = dev;
74426fbff66eea Robert Jarzmik   2017-09-02  365  	ret = ac97_add_adapter(ac97_ctrl);
74426fbff66eea Robert Jarzmik   2017-09-02  366  
74426fbff66eea Robert Jarzmik   2017-09-02  367  	if (ret)
74426fbff66eea Robert Jarzmik   2017-09-02  368  		goto err;
74426fbff66eea Robert Jarzmik   2017-09-02  369  	ac97_bus_reset(ac97_ctrl);
74426fbff66eea Robert Jarzmik   2017-09-02  370  	ac97_bus_scan(ac97_ctrl);
74426fbff66eea Robert Jarzmik   2017-09-02  371  
74426fbff66eea Robert Jarzmik   2017-09-02  372  	return ac97_ctrl;
74426fbff66eea Robert Jarzmik   2017-09-02  373  err:
74426fbff66eea Robert Jarzmik   2017-09-02  374  	kfree(ac97_ctrl);
74426fbff66eea Robert Jarzmik   2017-09-02  375  	return ERR_PTR(ret);
74426fbff66eea Robert Jarzmik   2017-09-02  376  }
74426fbff66eea Robert Jarzmik   2017-09-02  377  EXPORT_SYMBOL_GPL(snd_ac97_controller_register);
74426fbff66eea Robert Jarzmik   2017-09-02  378  

:::::: The code at line 192 was first introduced by commit
:::::: 74426fbff66eea8e8d1f42c8238c268d1e63a832 ALSA: ac97: add an ac97 bus

:::::: TO: Robert Jarzmik <robert.jarzmik@free.fr>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
