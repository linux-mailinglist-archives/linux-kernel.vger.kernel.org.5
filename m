Return-Path: <linux-kernel+bounces-21586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADDD829184
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD99288FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57858644;
	Wed, 10 Jan 2024 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsxzncE1"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9290383
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704847163; x=1736383163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6VSUhxHcVKYf8XcSqAKay5YGN0ehzbjWp+67JrBDyYY=;
  b=jsxzncE13hJrGEk1x13DzCpCKD/Y26ij1FLjIJDxQ4e8yjINTe9GbtJr
   QK8MLIk0c+5DS/WdZMobLCo8vGDrqaGcSE3aAdIEKgLW+/xblmUJfKl7Y
   O719JOxyZ74MH4a8h6vUZzU/SkWB31++2ItweJuLacUiOg2YEjnDew7hC
   OD1cVuFNgs0l1YUzd3vbV/QZz6e7AtrZK3yc4ZTTWfulPoOetWh8S6598
   Fb/Qvdq+CSsxjozX71CvcCR6LpmBxWDielT4g7gvaGu38qpFi2Fs74JFh
   9Sk9cr7iEndonJLDlxBYMz2jthG0D0og1sODkV3e1iQslwpB88ItbN/uX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="398059697"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="398059697"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 16:39:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1113257196"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="1113257196"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2024 16:39:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNMcn-0006Qw-07;
	Wed, 10 Jan 2024 00:39:17 +0000
Date: Wed, 10 Jan 2024 08:39:13 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <pstanner@redhat.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, NXP Linux Team <linux-imx@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: Re: [PATCH v2 1/2] drm/dcss: request memory region
Message-ID: <202401100801.1Wiy3ZEd-lkp@intel.com>
References: <20240109102032.16165-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109102032.16165-2-pstanner@redhat.com>

Hi Philipp,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.7]
[also build test ERROR on linus/master next-20240109]
[cannot apply to drm-misc/drm-misc-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/drm-dcss-request-memory-region/20240109-182239
base:   v6.7
patch link:    https://lore.kernel.org/r/20240109102032.16165-2-pstanner%40redhat.com
patch subject: [PATCH v2 1/2] drm/dcss: request memory region
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240110/202401100801.1Wiy3ZEd-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401100801.1Wiy3ZEd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401100801.1Wiy3ZEd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:17,
                    from include/linux/platform_device.h:13,
                    from drivers/gpu/drm/imx/dcss/dcss-dev.c:9:
   drivers/gpu/drm/imx/dcss/dcss-dev.c: In function 'dcss_dev_create':
>> drivers/gpu/drm/imx/dcss/dcss-dev.c:188:42: error: incompatible type for argument 1 of '__devm_request_region'
     188 |         if (!devm_request_mem_region(pdev->dev, res->start, res_len, "dcss")) {
         |                                      ~~~~^~~~~
         |                                          |
         |                                          struct device
   include/linux/ioport.h:306:31: note: in definition of macro 'devm_request_mem_region'
     306 |         __devm_request_region(dev, &iomem_resource, (start), (n), (name))
         |                               ^~~
   include/linux/ioport.h:308:63: note: expected 'struct device *' but argument is of type 'struct device'
     308 | extern struct resource * __devm_request_region(struct device *dev,
         |                                                ~~~~~~~~~~~~~~~^~~


vim +/__devm_request_region +188 drivers/gpu/drm/imx/dcss/dcss-dev.c

   165	
   166	struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
   167	{
   168		struct platform_device *pdev = to_platform_device(dev);
   169		int ret;
   170		struct resource *res;
   171		struct dcss_dev *dcss;
   172		const struct dcss_type_data *devtype;
   173		resource_size_t res_len;
   174	
   175		devtype = of_device_get_match_data(dev);
   176		if (!devtype) {
   177			dev_err(dev, "no device match found\n");
   178			return ERR_PTR(-ENODEV);
   179		}
   180	
   181		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   182		if (!res) {
   183			dev_err(dev, "cannot get memory resource\n");
   184			return ERR_PTR(-EINVAL);
   185		}
   186	
   187		res_len = res->end - res->start;
 > 188		if (!devm_request_mem_region(pdev->dev, res->start, res_len, "dcss")) {
   189			dev_err(dev, "cannot request memory region\n");
   190			return ERR_PTR(-EBUSY);
   191		}
   192	
   193		dcss = kzalloc(sizeof(*dcss), GFP_KERNEL);
   194		if (!dcss)
   195			return ERR_PTR(-ENOMEM);
   196	
   197		dcss->dev = dev;
   198		dcss->devtype = devtype;
   199		dcss->hdmi_output = hdmi_output;
   200	
   201		ret = dcss_clks_init(dcss);
   202		if (ret) {
   203			dev_err(dev, "clocks initialization failed\n");
   204			goto err;
   205		}
   206	
   207		dcss->of_port = of_graph_get_port_by_id(dev->of_node, 0);
   208		if (!dcss->of_port) {
   209			dev_err(dev, "no port@0 node in %pOF\n", dev->of_node);
   210			ret = -ENODEV;
   211			goto clks_err;
   212		}
   213	
   214		dcss->start_addr = res->start;
   215	
   216		ret = dcss_submodules_init(dcss);
   217		if (ret) {
   218			of_node_put(dcss->of_port);
   219			dev_err(dev, "submodules initialization failed\n");
   220			goto clks_err;
   221		}
   222	
   223		init_completion(&dcss->disable_completion);
   224	
   225		pm_runtime_set_autosuspend_delay(dev, 100);
   226		pm_runtime_use_autosuspend(dev);
   227		pm_runtime_set_suspended(dev);
   228		pm_runtime_allow(dev);
   229		pm_runtime_enable(dev);
   230	
   231		return dcss;
   232	
   233	clks_err:
   234		dcss_clks_release(dcss);
   235	
   236	err:
   237		kfree(dcss);
   238	
   239		return ERR_PTR(ret);
   240	}
   241	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

