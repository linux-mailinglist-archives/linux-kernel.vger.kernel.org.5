Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633897F3A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjKUX1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjKUX1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:27:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F0C19E;
        Tue, 21 Nov 2023 15:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700609261; x=1732145261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HyJyMoBDuxOGRbOeaJ9Qhm8C3JlvSS2xTGqn52Xg62Q=;
  b=Saq/Eh3EotVULo5/vRim97V/d8c3zEhQNaOl6BvKMJGK39sPWYrWUzUA
   pwc/q4/ojDUHYJl6KvFnvoSBFIgdUPTDWY143Zr9w6WH7Pqvo6xtAwUvt
   yWw/hoEbUYYtZ3aBeG3l5ACsXBOiMRmfdt3hhu+ghEt8nm0xhwU5hLYrm
   huWThp+f3r4jYJIcFuiLXD6jVGlP2OHVuTmgPd/N6ZwTsysxPDVsQDJe3
   wE4v6Kgidk1fVShXHjtfEwqxTj1vZofsy5RFb32Cerr8es8qErLQvqFEO
   1FphGaxmnxGRVPIVxTnFQuzmWSU2KZN0mGH6ZRa701ae0IwgeDrBNwq1P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="394781690"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="394781690"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 15:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="801708661"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="801708661"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Nov 2023 15:27:36 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5a9W-0008OS-1W;
        Tue, 21 Nov 2023 23:27:34 +0000
Date:   Wed, 22 Nov 2023 07:27:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH 12/12] iio: adc: adi-axi-adc: move to backend framework
Message-ID: <202311220748.T1FnZwoy-lkp@intel.com>
References: <20231121-dev-iio-backend-v1-12-6a3d542eba35@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-dev-iio-backend-v1-12-6a3d542eba35@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nuno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus robh/for-next linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Sa-via-B4-Relay/driver-core-allow-modifying-device_links-flags/20231121-182010
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231121-dev-iio-backend-v1-12-6a3d542eba35%40analog.com
patch subject: [PATCH 12/12] iio: adc: adi-axi-adc: move to backend framework
config: i386-randconfig-141-20231122 (https://download.01.org/0day-ci/archive/20231122/202311220748.T1FnZwoy-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220748.T1FnZwoy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220748.T1FnZwoy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/industrialio-backend.c:123: warning: expecting prototype for iio_backend_chan_enable(). Prototype was for iio_backend_enable() instead
>> drivers/iio/industrialio-backend.c:242: warning: Function parameter or member 'back' not described in 'iio_backend_get_priv'
>> drivers/iio/industrialio-backend.c:274: warning: Function parameter or member 'dev' not described in 'devm_iio_backend_register'
>> drivers/iio/industrialio-backend.c:274: warning: Function parameter or member 'ops' not described in 'devm_iio_backend_register'
>> drivers/iio/industrialio-backend.c:274: warning: Function parameter or member 'priv' not described in 'devm_iio_backend_register'


vim +242 drivers/iio/industrialio-backend.c

67915cd5ae2cc11 Nuno Sa 2023-11-21  114  
67915cd5ae2cc11 Nuno Sa 2023-11-21  115  /**
67915cd5ae2cc11 Nuno Sa 2023-11-21  116   * iio_backend_chan_enable - Enable the backend.
67915cd5ae2cc11 Nuno Sa 2023-11-21  117   * @back:	Backend device
67915cd5ae2cc11 Nuno Sa 2023-11-21  118   *
67915cd5ae2cc11 Nuno Sa 2023-11-21  119   * RETURNS:
67915cd5ae2cc11 Nuno Sa 2023-11-21  120   * 0 on success, negative error number on failure.
67915cd5ae2cc11 Nuno Sa 2023-11-21  121   */
67915cd5ae2cc11 Nuno Sa 2023-11-21  122  int iio_backend_enable(struct iio_backend *back)
67915cd5ae2cc11 Nuno Sa 2023-11-21 @123  {
67915cd5ae2cc11 Nuno Sa 2023-11-21  124  	return iio_backend_op_call(back, enable);
67915cd5ae2cc11 Nuno Sa 2023-11-21  125  }
67915cd5ae2cc11 Nuno Sa 2023-11-21  126  EXPORT_SYMBOL_GPL(iio_backend_enable);
67915cd5ae2cc11 Nuno Sa 2023-11-21  127  
67915cd5ae2cc11 Nuno Sa 2023-11-21  128  /**
67915cd5ae2cc11 Nuno Sa 2023-11-21  129   * iio_backend_disable - Disable the backend.
67915cd5ae2cc11 Nuno Sa 2023-11-21  130   * @back:	Backend device
67915cd5ae2cc11 Nuno Sa 2023-11-21  131   */
67915cd5ae2cc11 Nuno Sa 2023-11-21  132  void iio_backend_disable(struct iio_backend *back)
67915cd5ae2cc11 Nuno Sa 2023-11-21  133  {
67915cd5ae2cc11 Nuno Sa 2023-11-21  134  	iio_backend_void_op_call(back, disable);
67915cd5ae2cc11 Nuno Sa 2023-11-21  135  }
67915cd5ae2cc11 Nuno Sa 2023-11-21  136  EXPORT_SYMBOL_GPL(iio_backend_disable);
67915cd5ae2cc11 Nuno Sa 2023-11-21  137  
67915cd5ae2cc11 Nuno Sa 2023-11-21  138  /**
67915cd5ae2cc11 Nuno Sa 2023-11-21  139   * iio_backend_data_format_set - Configure the channel data format
67915cd5ae2cc11 Nuno Sa 2023-11-21  140   * @back:	Backend device
67915cd5ae2cc11 Nuno Sa 2023-11-21  141   * @chan:	Channel number.
67915cd5ae2cc11 Nuno Sa 2023-11-21  142   * @data:	Data format.
67915cd5ae2cc11 Nuno Sa 2023-11-21  143   *
67915cd5ae2cc11 Nuno Sa 2023-11-21  144   * Properly configure a channel with respect to the expected data format. A
67915cd5ae2cc11 Nuno Sa 2023-11-21  145   * @struct iio_backend_data_fmt must be passed with the settings.
67915cd5ae2cc11 Nuno Sa 2023-11-21  146   *
67915cd5ae2cc11 Nuno Sa 2023-11-21  147   * RETURNS:
67915cd5ae2cc11 Nuno Sa 2023-11-21  148   * 0 on success, negative error number on failure
67915cd5ae2cc11 Nuno Sa 2023-11-21  149   */
67915cd5ae2cc11 Nuno Sa 2023-11-21  150  int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
67915cd5ae2cc11 Nuno Sa 2023-11-21  151  				const struct iio_backend_data_fmt *data)
67915cd5ae2cc11 Nuno Sa 2023-11-21  152  {
67915cd5ae2cc11 Nuno Sa 2023-11-21  153  	if (!data || data->type >= IIO_BACKEND_DATA_TYPE_MAX)
67915cd5ae2cc11 Nuno Sa 2023-11-21  154  		return -EINVAL;
67915cd5ae2cc11 Nuno Sa 2023-11-21  155  
67915cd5ae2cc11 Nuno Sa 2023-11-21  156  	return iio_backend_op_call(back, data_format_set, chan, data);
67915cd5ae2cc11 Nuno Sa 2023-11-21  157  }
67915cd5ae2cc11 Nuno Sa 2023-11-21  158  EXPORT_SYMBOL_GPL(iio_backend_data_format_set);
67915cd5ae2cc11 Nuno Sa 2023-11-21  159  
67915cd5ae2cc11 Nuno Sa 2023-11-21  160  static void iio_backend_free(struct kref *ref)
67915cd5ae2cc11 Nuno Sa 2023-11-21  161  {
67915cd5ae2cc11 Nuno Sa 2023-11-21  162  	struct iio_backend *back = container_of(ref, struct iio_backend, ref);
67915cd5ae2cc11 Nuno Sa 2023-11-21  163  
67915cd5ae2cc11 Nuno Sa 2023-11-21  164  	kfree(back);
67915cd5ae2cc11 Nuno Sa 2023-11-21  165  }
67915cd5ae2cc11 Nuno Sa 2023-11-21  166  
67915cd5ae2cc11 Nuno Sa 2023-11-21  167  static void iio_backend_release(void *arg)
67915cd5ae2cc11 Nuno Sa 2023-11-21  168  {
67915cd5ae2cc11 Nuno Sa 2023-11-21  169  	struct iio_backend *back = arg;
67915cd5ae2cc11 Nuno Sa 2023-11-21  170  
67915cd5ae2cc11 Nuno Sa 2023-11-21  171  	module_put(back->owner);
67915cd5ae2cc11 Nuno Sa 2023-11-21  172  	kref_put(&back->ref, iio_backend_free);
67915cd5ae2cc11 Nuno Sa 2023-11-21  173  }
67915cd5ae2cc11 Nuno Sa 2023-11-21  174  
67915cd5ae2cc11 Nuno Sa 2023-11-21  175  /**
67915cd5ae2cc11 Nuno Sa 2023-11-21  176   * devm_iio_backend_get - Get a backend device
67915cd5ae2cc11 Nuno Sa 2023-11-21  177   * @dev:	Device where to look for the backend.
67915cd5ae2cc11 Nuno Sa 2023-11-21  178   * @name:	Backend name.
67915cd5ae2cc11 Nuno Sa 2023-11-21  179   *
67915cd5ae2cc11 Nuno Sa 2023-11-21  180   * Get's the backend associated with @dev.
67915cd5ae2cc11 Nuno Sa 2023-11-21  181   *
67915cd5ae2cc11 Nuno Sa 2023-11-21  182   * RETURNS:
67915cd5ae2cc11 Nuno Sa 2023-11-21  183   * A backend pointer, negative error pointer otherwise.
67915cd5ae2cc11 Nuno Sa 2023-11-21  184   */
67915cd5ae2cc11 Nuno Sa 2023-11-21  185  struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
67915cd5ae2cc11 Nuno Sa 2023-11-21  186  {
67915cd5ae2cc11 Nuno Sa 2023-11-21  187  	struct fwnode_handle *fwnode;
67915cd5ae2cc11 Nuno Sa 2023-11-21  188  	struct iio_backend *back;
67915cd5ae2cc11 Nuno Sa 2023-11-21  189  	int index = 0, ret;
67915cd5ae2cc11 Nuno Sa 2023-11-21  190  
67915cd5ae2cc11 Nuno Sa 2023-11-21  191  	if (name) {
67915cd5ae2cc11 Nuno Sa 2023-11-21  192  		index = device_property_match_string(dev, "io-backends-names",
67915cd5ae2cc11 Nuno Sa 2023-11-21  193  						     name);
67915cd5ae2cc11 Nuno Sa 2023-11-21  194  		if (index < 0)
67915cd5ae2cc11 Nuno Sa 2023-11-21  195  			return ERR_PTR(index);
67915cd5ae2cc11 Nuno Sa 2023-11-21  196  	}
67915cd5ae2cc11 Nuno Sa 2023-11-21  197  
67915cd5ae2cc11 Nuno Sa 2023-11-21  198  	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
67915cd5ae2cc11 Nuno Sa 2023-11-21  199  	if (IS_ERR(fwnode)) {
67915cd5ae2cc11 Nuno Sa 2023-11-21  200  		dev_err(dev, "Cannot get Firmware reference\n");
67915cd5ae2cc11 Nuno Sa 2023-11-21  201  		return ERR_CAST(fwnode);
67915cd5ae2cc11 Nuno Sa 2023-11-21  202  	}
67915cd5ae2cc11 Nuno Sa 2023-11-21  203  
67915cd5ae2cc11 Nuno Sa 2023-11-21  204  	guard(mutex)(&iio_back_lock);
67915cd5ae2cc11 Nuno Sa 2023-11-21  205  	list_for_each_entry(back, &iio_back_list, entry) {
67915cd5ae2cc11 Nuno Sa 2023-11-21  206  		struct device_link *link;
67915cd5ae2cc11 Nuno Sa 2023-11-21  207  
67915cd5ae2cc11 Nuno Sa 2023-11-21  208  		if (!device_match_fwnode(back->dev, fwnode))
67915cd5ae2cc11 Nuno Sa 2023-11-21  209  			continue;
67915cd5ae2cc11 Nuno Sa 2023-11-21  210  
67915cd5ae2cc11 Nuno Sa 2023-11-21  211  		fwnode_handle_put(fwnode);
67915cd5ae2cc11 Nuno Sa 2023-11-21  212  		kref_get(&back->ref);
67915cd5ae2cc11 Nuno Sa 2023-11-21  213  		if (!try_module_get(back->owner)) {
67915cd5ae2cc11 Nuno Sa 2023-11-21  214  			dev_err(dev, "Cannot get module reference\n");
67915cd5ae2cc11 Nuno Sa 2023-11-21  215  			return ERR_PTR(-ENODEV);
67915cd5ae2cc11 Nuno Sa 2023-11-21  216  		}
67915cd5ae2cc11 Nuno Sa 2023-11-21  217  
67915cd5ae2cc11 Nuno Sa 2023-11-21  218  		ret = devm_add_action_or_reset(dev, iio_backend_release, back);
67915cd5ae2cc11 Nuno Sa 2023-11-21  219  		if (ret)
67915cd5ae2cc11 Nuno Sa 2023-11-21  220  			return ERR_PTR(ret);
67915cd5ae2cc11 Nuno Sa 2023-11-21  221  
67915cd5ae2cc11 Nuno Sa 2023-11-21  222  		link = device_link_add(dev, back->dev,
67915cd5ae2cc11 Nuno Sa 2023-11-21  223  				       DL_FLAG_AUTOREMOVE_CONSUMER);
67915cd5ae2cc11 Nuno Sa 2023-11-21  224  		if (!link)
67915cd5ae2cc11 Nuno Sa 2023-11-21  225  			dev_warn(dev, "Could not link to supplier(%s)\n",
67915cd5ae2cc11 Nuno Sa 2023-11-21  226  				 dev_name(back->dev));
67915cd5ae2cc11 Nuno Sa 2023-11-21  227  
67915cd5ae2cc11 Nuno Sa 2023-11-21  228  		dev_dbg(dev, "Found backend(%s) device\n", dev_name(back->dev));
67915cd5ae2cc11 Nuno Sa 2023-11-21  229  		return back;
67915cd5ae2cc11 Nuno Sa 2023-11-21  230  	}
67915cd5ae2cc11 Nuno Sa 2023-11-21  231  
67915cd5ae2cc11 Nuno Sa 2023-11-21  232  	fwnode_handle_put(fwnode);
67915cd5ae2cc11 Nuno Sa 2023-11-21  233  	return ERR_PTR(-EPROBE_DEFER);
67915cd5ae2cc11 Nuno Sa 2023-11-21  234  }
67915cd5ae2cc11 Nuno Sa 2023-11-21  235  EXPORT_SYMBOL_GPL(devm_iio_backend_get);
67915cd5ae2cc11 Nuno Sa 2023-11-21  236  
67915cd5ae2cc11 Nuno Sa 2023-11-21  237  /**
67915cd5ae2cc11 Nuno Sa 2023-11-21  238   * iio_backend_get_priv - Get driver private data
67915cd5ae2cc11 Nuno Sa 2023-11-21  239   * @back	Backend device
67915cd5ae2cc11 Nuno Sa 2023-11-21  240   */
67915cd5ae2cc11 Nuno Sa 2023-11-21  241  void *iio_backend_get_priv(const struct iio_backend *back)
67915cd5ae2cc11 Nuno Sa 2023-11-21 @242  {
67915cd5ae2cc11 Nuno Sa 2023-11-21  243  	return back->priv;
67915cd5ae2cc11 Nuno Sa 2023-11-21  244  }
67915cd5ae2cc11 Nuno Sa 2023-11-21  245  EXPORT_SYMBOL_GPL(iio_backend_get_priv);
67915cd5ae2cc11 Nuno Sa 2023-11-21  246  
67915cd5ae2cc11 Nuno Sa 2023-11-21  247  static void iio_backend_unregister(void *arg)
67915cd5ae2cc11 Nuno Sa 2023-11-21  248  {
67915cd5ae2cc11 Nuno Sa 2023-11-21  249  	struct iio_backend *back = arg;
67915cd5ae2cc11 Nuno Sa 2023-11-21  250  
67915cd5ae2cc11 Nuno Sa 2023-11-21  251  	mutex_lock(&iio_back_lock);
67915cd5ae2cc11 Nuno Sa 2023-11-21  252  	list_del(&back->entry);
67915cd5ae2cc11 Nuno Sa 2023-11-21  253  	mutex_unlock(&iio_back_lock);
67915cd5ae2cc11 Nuno Sa 2023-11-21  254  
67915cd5ae2cc11 Nuno Sa 2023-11-21  255  	mutex_lock(&back->lock);
67915cd5ae2cc11 Nuno Sa 2023-11-21  256  	back->ops = NULL;
67915cd5ae2cc11 Nuno Sa 2023-11-21  257  	mutex_unlock(&back->lock);
67915cd5ae2cc11 Nuno Sa 2023-11-21  258  	kref_put(&back->ref, iio_backend_free);
67915cd5ae2cc11 Nuno Sa 2023-11-21  259  }
67915cd5ae2cc11 Nuno Sa 2023-11-21  260  
67915cd5ae2cc11 Nuno Sa 2023-11-21  261  /**
67915cd5ae2cc11 Nuno Sa 2023-11-21  262   * devm_iio_backend_register - Register a new backend device
67915cd5ae2cc11 Nuno Sa 2023-11-21  263   * @dev		Backend device being registered.
67915cd5ae2cc11 Nuno Sa 2023-11-21  264   * @ops		Backend ops
67915cd5ae2cc11 Nuno Sa 2023-11-21  265   * @priv	Device private data.
67915cd5ae2cc11 Nuno Sa 2023-11-21  266   *
67915cd5ae2cc11 Nuno Sa 2023-11-21  267   * @ops and @priv are both mandatory. Not providing them results in -EINVAL.
67915cd5ae2cc11 Nuno Sa 2023-11-21  268   *
67915cd5ae2cc11 Nuno Sa 2023-11-21  269   * RETURNS:
67915cd5ae2cc11 Nuno Sa 2023-11-21  270   * 0 on success, negative error number on failure.
67915cd5ae2cc11 Nuno Sa 2023-11-21  271   */
67915cd5ae2cc11 Nuno Sa 2023-11-21  272  int devm_iio_backend_register(struct device *dev,
67915cd5ae2cc11 Nuno Sa 2023-11-21  273  			      const struct iio_backend_ops *ops, void *priv)
67915cd5ae2cc11 Nuno Sa 2023-11-21 @274  {
67915cd5ae2cc11 Nuno Sa 2023-11-21  275  	struct iio_backend *back;
67915cd5ae2cc11 Nuno Sa 2023-11-21  276  
67915cd5ae2cc11 Nuno Sa 2023-11-21  277  	if (!ops || !priv) {
67915cd5ae2cc11 Nuno Sa 2023-11-21  278  		dev_err(dev, "No backend ops or private data given\n");
67915cd5ae2cc11 Nuno Sa 2023-11-21  279  		return -EINVAL;
67915cd5ae2cc11 Nuno Sa 2023-11-21  280  	}
67915cd5ae2cc11 Nuno Sa 2023-11-21  281  
67915cd5ae2cc11 Nuno Sa 2023-11-21  282  	back = kzalloc(sizeof(*back), GFP_KERNEL);
67915cd5ae2cc11 Nuno Sa 2023-11-21  283  	if (!back)
67915cd5ae2cc11 Nuno Sa 2023-11-21  284  		return -ENOMEM;
67915cd5ae2cc11 Nuno Sa 2023-11-21  285  
67915cd5ae2cc11 Nuno Sa 2023-11-21  286  	kref_init(&back->ref);
67915cd5ae2cc11 Nuno Sa 2023-11-21  287  	mutex_init(&back->lock);
67915cd5ae2cc11 Nuno Sa 2023-11-21  288  	back->ops = ops;
67915cd5ae2cc11 Nuno Sa 2023-11-21  289  	back->owner = dev->driver->owner;
67915cd5ae2cc11 Nuno Sa 2023-11-21  290  	back->dev = dev;
67915cd5ae2cc11 Nuno Sa 2023-11-21  291  	back->priv = priv;
67915cd5ae2cc11 Nuno Sa 2023-11-21  292  	mutex_lock(&iio_back_lock);
67915cd5ae2cc11 Nuno Sa 2023-11-21  293  	list_add(&back->entry, &iio_back_list);
67915cd5ae2cc11 Nuno Sa 2023-11-21  294  	mutex_unlock(&iio_back_lock);
67915cd5ae2cc11 Nuno Sa 2023-11-21  295  
67915cd5ae2cc11 Nuno Sa 2023-11-21  296  	return devm_add_action_or_reset(dev, iio_backend_unregister, back);
67915cd5ae2cc11 Nuno Sa 2023-11-21  297  }
67915cd5ae2cc11 Nuno Sa 2023-11-21  298  EXPORT_SYMBOL_GPL(devm_iio_backend_register);
67915cd5ae2cc11 Nuno Sa 2023-11-21  299  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
