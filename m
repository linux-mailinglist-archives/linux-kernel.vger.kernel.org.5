Return-Path: <linux-kernel+bounces-21412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0A4828EC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A28E1F26EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC24B3D997;
	Tue,  9 Jan 2024 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6+vsaXM"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3B3DB80
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704834836; x=1736370836;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6+QWP6DIpXUdQ1e9U+hc6eMNWtvhHNZCqn4JCU2Z2/M=;
  b=M6+vsaXMTPrP+yqhW4805g3VnARI/OLd5ZwPdfD3zbUS0LKGt6GJfhH0
   HmhJMi5GDHNgvkRqGBhit1+5YNYkl0MZ+yVz/M58hWKLkECp37cy8npwP
   kLfWAD0gFU/O5wNy1IbB8kTQ1smOQ5T0LEKLYGxlSge0F7VzNcfcRdE9Z
   zG1mYbfJi+v4rS8GHbHAKl24FvGGblCRyQl7aIRqgK5De4I5GQ9b8rUDY
   gRqlcp4kIFjbEZi463IQDOqSf1JibnV5sUCHJjeLNPy1RgUU8D28rRLfi
   o5MY6FRJCtiqKuORjhntmkrkix9f1kJRaYK3myEcmp96+1WgS2qOJLfzx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="464726740"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="464726740"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 13:13:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="16408481"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 09 Jan 2024 13:13:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNJQ0-0006Gs-1C;
	Tue, 09 Jan 2024 21:13:52 +0000
Date: Wed, 10 Jan 2024 05:13:03 +0800
From: kernel test robot <lkp@intel.com>
To: Martin Habets <habetsm.xilinx@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: drivers/net/ethernet/sfc/siena/mcdi_mon.c:458:65: warning:
 'snprintf' output may be truncated before the last format character
Message-ID: <202401100509.U4prhh6J-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e
commit: f62a074525de47fe748ce74b81b95ea05f97b25c siena: Make HWMON support specific for Siena
date:   1 year, 8 months ago
config: x86_64-randconfig-003-20240107 (https://download.01.org/0day-ci/archive/20240110/202401100509.U4prhh6J-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401100509.U4prhh6J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401100509.U4prhh6J-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/sfc/siena/mcdi_mon.c: In function 'efx_siena_mcdi_mon_probe':
>> drivers/net/ethernet/sfc/siena/mcdi_mon.c:458:65: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     458 |                         snprintf(name, sizeof(name), "%s%u_input",
         |                                                                 ^
   drivers/net/ethernet/sfc/siena/mcdi_mon.c:458:25: note: 'snprintf' output between 10 and 22 bytes into a destination of size 12
     458 |                         snprintf(name, sizeof(name), "%s%u_input",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     459 |                                  hwmon_prefix, hwmon_index);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/siena/mcdi_mon.c:489:57: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     489 |                 snprintf(name, sizeof(name), "%s%u_alarm",
         |                                                         ^
   drivers/net/ethernet/sfc/siena/mcdi_mon.c:489:17: note: 'snprintf' output between 10 and 22 bytes into a destination of size 12
     489 |                 snprintf(name, sizeof(name), "%s%u_alarm",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     490 |                          hwmon_prefix, hwmon_index);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/siena/mcdi_mon.c:496:65: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     496 |                         snprintf(name, sizeof(name), "%s%u_label",
         |                                                                 ^
   drivers/net/ethernet/sfc/siena/mcdi_mon.c:496:25: note: 'snprintf' output between 10 and 22 bytes into a destination of size 12
     496 |                         snprintf(name, sizeof(name), "%s%u_label",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     497 |                                  hwmon_prefix, hwmon_index);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +458 drivers/net/ethernet/sfc/siena/mcdi_mon.c

d48523cb88e070 Martin Habets 2022-05-09  302  
4d49e5cd4b095c Martin Habets 2022-05-09  303  int efx_siena_mcdi_mon_probe(struct efx_nic *efx)
d48523cb88e070 Martin Habets 2022-05-09  304  {
d48523cb88e070 Martin Habets 2022-05-09  305  	unsigned int n_temp = 0, n_cool = 0, n_in = 0, n_curr = 0, n_power = 0;
d48523cb88e070 Martin Habets 2022-05-09  306  	struct efx_mcdi_mon *hwmon = efx_mcdi_mon(efx);
d48523cb88e070 Martin Habets 2022-05-09  307  	MCDI_DECLARE_BUF(inbuf, MC_CMD_SENSOR_INFO_EXT_IN_LEN);
d48523cb88e070 Martin Habets 2022-05-09  308  	MCDI_DECLARE_BUF(outbuf, MC_CMD_SENSOR_INFO_OUT_LENMAX);
d48523cb88e070 Martin Habets 2022-05-09  309  	unsigned int n_pages, n_sensors, n_attrs, page;
d48523cb88e070 Martin Habets 2022-05-09  310  	size_t outlen;
d48523cb88e070 Martin Habets 2022-05-09  311  	char name[12];
d48523cb88e070 Martin Habets 2022-05-09  312  	u32 mask;
d48523cb88e070 Martin Habets 2022-05-09  313  	int rc, i, j, type;
d48523cb88e070 Martin Habets 2022-05-09  314  
d48523cb88e070 Martin Habets 2022-05-09  315  	/* Find out how many sensors are present */
d48523cb88e070 Martin Habets 2022-05-09  316  	n_sensors = 0;
d48523cb88e070 Martin Habets 2022-05-09  317  	page = 0;
d48523cb88e070 Martin Habets 2022-05-09  318  	do {
d48523cb88e070 Martin Habets 2022-05-09  319  		MCDI_SET_DWORD(inbuf, SENSOR_INFO_EXT_IN_PAGE, page);
d48523cb88e070 Martin Habets 2022-05-09  320  
4d49e5cd4b095c Martin Habets 2022-05-09  321  		rc = efx_siena_mcdi_rpc(efx, MC_CMD_SENSOR_INFO, inbuf,
4d49e5cd4b095c Martin Habets 2022-05-09  322  					sizeof(inbuf), outbuf, sizeof(outbuf),
4d49e5cd4b095c Martin Habets 2022-05-09  323  					&outlen);
d48523cb88e070 Martin Habets 2022-05-09  324  		if (rc)
d48523cb88e070 Martin Habets 2022-05-09  325  			return rc;
d48523cb88e070 Martin Habets 2022-05-09  326  		if (outlen < MC_CMD_SENSOR_INFO_OUT_LENMIN)
d48523cb88e070 Martin Habets 2022-05-09  327  			return -EIO;
d48523cb88e070 Martin Habets 2022-05-09  328  
d48523cb88e070 Martin Habets 2022-05-09  329  		mask = MCDI_DWORD(outbuf, SENSOR_INFO_OUT_MASK);
d48523cb88e070 Martin Habets 2022-05-09  330  		n_sensors += hweight32(mask & ~(1 << MC_CMD_SENSOR_PAGE0_NEXT));
d48523cb88e070 Martin Habets 2022-05-09  331  		++page;
d48523cb88e070 Martin Habets 2022-05-09  332  	} while (mask & (1 << MC_CMD_SENSOR_PAGE0_NEXT));
d48523cb88e070 Martin Habets 2022-05-09  333  	n_pages = page;
d48523cb88e070 Martin Habets 2022-05-09  334  
d48523cb88e070 Martin Habets 2022-05-09  335  	/* Don't create a device if there are none */
d48523cb88e070 Martin Habets 2022-05-09  336  	if (n_sensors == 0)
d48523cb88e070 Martin Habets 2022-05-09  337  		return 0;
d48523cb88e070 Martin Habets 2022-05-09  338  
c8443b698238fd Martin Habets 2022-05-09  339  	rc = efx_siena_alloc_buffer(efx, &hwmon->dma_buf,
d48523cb88e070 Martin Habets 2022-05-09  340  			n_sensors * MC_CMD_SENSOR_VALUE_ENTRY_TYPEDEF_LEN,
d48523cb88e070 Martin Habets 2022-05-09  341  			GFP_KERNEL);
d48523cb88e070 Martin Habets 2022-05-09  342  	if (rc)
d48523cb88e070 Martin Habets 2022-05-09  343  		return rc;
d48523cb88e070 Martin Habets 2022-05-09  344  
d48523cb88e070 Martin Habets 2022-05-09  345  	mutex_init(&hwmon->update_lock);
d48523cb88e070 Martin Habets 2022-05-09  346  	efx_mcdi_mon_update(efx);
d48523cb88e070 Martin Habets 2022-05-09  347  
d48523cb88e070 Martin Habets 2022-05-09  348  	/* Allocate space for the maximum possible number of
d48523cb88e070 Martin Habets 2022-05-09  349  	 * attributes for this set of sensors:
d48523cb88e070 Martin Habets 2022-05-09  350  	 * value, min, max, crit, alarm and label for each sensor.
d48523cb88e070 Martin Habets 2022-05-09  351  	 */
d48523cb88e070 Martin Habets 2022-05-09  352  	n_attrs = 6 * n_sensors;
d48523cb88e070 Martin Habets 2022-05-09  353  	hwmon->attrs = kcalloc(n_attrs, sizeof(*hwmon->attrs), GFP_KERNEL);
d48523cb88e070 Martin Habets 2022-05-09  354  	if (!hwmon->attrs) {
d48523cb88e070 Martin Habets 2022-05-09  355  		rc = -ENOMEM;
d48523cb88e070 Martin Habets 2022-05-09  356  		goto fail;
d48523cb88e070 Martin Habets 2022-05-09  357  	}
d48523cb88e070 Martin Habets 2022-05-09  358  	hwmon->group.attrs = kcalloc(n_attrs + 1, sizeof(struct attribute *),
d48523cb88e070 Martin Habets 2022-05-09  359  				     GFP_KERNEL);
d48523cb88e070 Martin Habets 2022-05-09  360  	if (!hwmon->group.attrs) {
d48523cb88e070 Martin Habets 2022-05-09  361  		rc = -ENOMEM;
d48523cb88e070 Martin Habets 2022-05-09  362  		goto fail;
d48523cb88e070 Martin Habets 2022-05-09  363  	}
d48523cb88e070 Martin Habets 2022-05-09  364  
d48523cb88e070 Martin Habets 2022-05-09  365  	for (i = 0, j = -1, type = -1; ; i++) {
d48523cb88e070 Martin Habets 2022-05-09  366  		enum efx_hwmon_type hwmon_type;
d48523cb88e070 Martin Habets 2022-05-09  367  		const char *hwmon_prefix;
d48523cb88e070 Martin Habets 2022-05-09  368  		unsigned hwmon_index;
d48523cb88e070 Martin Habets 2022-05-09  369  		u16 min1, max1, min2, max2;
d48523cb88e070 Martin Habets 2022-05-09  370  
d48523cb88e070 Martin Habets 2022-05-09  371  		/* Find next sensor type or exit if there is none */
d48523cb88e070 Martin Habets 2022-05-09  372  		do {
d48523cb88e070 Martin Habets 2022-05-09  373  			type++;
d48523cb88e070 Martin Habets 2022-05-09  374  
d48523cb88e070 Martin Habets 2022-05-09  375  			if ((type % 32) == 0) {
d48523cb88e070 Martin Habets 2022-05-09  376  				page = type / 32;
d48523cb88e070 Martin Habets 2022-05-09  377  				j = -1;
d48523cb88e070 Martin Habets 2022-05-09  378  				if (page == n_pages)
d48523cb88e070 Martin Habets 2022-05-09  379  					goto hwmon_register;
d48523cb88e070 Martin Habets 2022-05-09  380  
d48523cb88e070 Martin Habets 2022-05-09  381  				MCDI_SET_DWORD(inbuf, SENSOR_INFO_EXT_IN_PAGE,
d48523cb88e070 Martin Habets 2022-05-09  382  					       page);
4d49e5cd4b095c Martin Habets 2022-05-09  383  				rc = efx_siena_mcdi_rpc(efx, MC_CMD_SENSOR_INFO,
d48523cb88e070 Martin Habets 2022-05-09  384  							inbuf, sizeof(inbuf),
d48523cb88e070 Martin Habets 2022-05-09  385  							outbuf, sizeof(outbuf),
d48523cb88e070 Martin Habets 2022-05-09  386  							&outlen);
d48523cb88e070 Martin Habets 2022-05-09  387  				if (rc)
d48523cb88e070 Martin Habets 2022-05-09  388  					goto fail;
d48523cb88e070 Martin Habets 2022-05-09  389  				if (outlen < MC_CMD_SENSOR_INFO_OUT_LENMIN) {
d48523cb88e070 Martin Habets 2022-05-09  390  					rc = -EIO;
d48523cb88e070 Martin Habets 2022-05-09  391  					goto fail;
d48523cb88e070 Martin Habets 2022-05-09  392  				}
d48523cb88e070 Martin Habets 2022-05-09  393  
d48523cb88e070 Martin Habets 2022-05-09  394  				mask = (MCDI_DWORD(outbuf,
d48523cb88e070 Martin Habets 2022-05-09  395  						   SENSOR_INFO_OUT_MASK) &
d48523cb88e070 Martin Habets 2022-05-09  396  					~(1 << MC_CMD_SENSOR_PAGE0_NEXT));
d48523cb88e070 Martin Habets 2022-05-09  397  
d48523cb88e070 Martin Habets 2022-05-09  398  				/* Check again for short response */
d48523cb88e070 Martin Habets 2022-05-09  399  				if (outlen <
d48523cb88e070 Martin Habets 2022-05-09  400  				    MC_CMD_SENSOR_INFO_OUT_LEN(hweight32(mask))) {
d48523cb88e070 Martin Habets 2022-05-09  401  					rc = -EIO;
d48523cb88e070 Martin Habets 2022-05-09  402  					goto fail;
d48523cb88e070 Martin Habets 2022-05-09  403  				}
d48523cb88e070 Martin Habets 2022-05-09  404  			}
d48523cb88e070 Martin Habets 2022-05-09  405  		} while (!(mask & (1 << type % 32)));
d48523cb88e070 Martin Habets 2022-05-09  406  		j++;
d48523cb88e070 Martin Habets 2022-05-09  407  
d48523cb88e070 Martin Habets 2022-05-09  408  		if (type < ARRAY_SIZE(efx_mcdi_sensor_type)) {
d48523cb88e070 Martin Habets 2022-05-09  409  			hwmon_type = efx_mcdi_sensor_type[type].hwmon_type;
d48523cb88e070 Martin Habets 2022-05-09  410  
d48523cb88e070 Martin Habets 2022-05-09  411  			/* Skip sensors specific to a different port */
d48523cb88e070 Martin Habets 2022-05-09  412  			if (hwmon_type != EFX_HWMON_UNKNOWN &&
d48523cb88e070 Martin Habets 2022-05-09  413  			    efx_mcdi_sensor_type[type].port >= 0 &&
d48523cb88e070 Martin Habets 2022-05-09  414  			    efx_mcdi_sensor_type[type].port !=
d48523cb88e070 Martin Habets 2022-05-09  415  			    efx_port_num(efx))
d48523cb88e070 Martin Habets 2022-05-09  416  				continue;
d48523cb88e070 Martin Habets 2022-05-09  417  		} else {
d48523cb88e070 Martin Habets 2022-05-09  418  			hwmon_type = EFX_HWMON_UNKNOWN;
d48523cb88e070 Martin Habets 2022-05-09  419  		}
d48523cb88e070 Martin Habets 2022-05-09  420  
d48523cb88e070 Martin Habets 2022-05-09  421  		switch (hwmon_type) {
d48523cb88e070 Martin Habets 2022-05-09  422  		case EFX_HWMON_TEMP:
d48523cb88e070 Martin Habets 2022-05-09  423  			hwmon_prefix = "temp";
d48523cb88e070 Martin Habets 2022-05-09  424  			hwmon_index = ++n_temp; /* 1-based */
d48523cb88e070 Martin Habets 2022-05-09  425  			break;
d48523cb88e070 Martin Habets 2022-05-09  426  		case EFX_HWMON_COOL:
d48523cb88e070 Martin Habets 2022-05-09  427  			/* This is likely to be a heatsink, but there
d48523cb88e070 Martin Habets 2022-05-09  428  			 * is no convention for representing cooling
d48523cb88e070 Martin Habets 2022-05-09  429  			 * devices other than fans.
d48523cb88e070 Martin Habets 2022-05-09  430  			 */
d48523cb88e070 Martin Habets 2022-05-09  431  			hwmon_prefix = "fan";
d48523cb88e070 Martin Habets 2022-05-09  432  			hwmon_index = ++n_cool; /* 1-based */
d48523cb88e070 Martin Habets 2022-05-09  433  			break;
d48523cb88e070 Martin Habets 2022-05-09  434  		default:
d48523cb88e070 Martin Habets 2022-05-09  435  			hwmon_prefix = "in";
d48523cb88e070 Martin Habets 2022-05-09  436  			hwmon_index = n_in++; /* 0-based */
d48523cb88e070 Martin Habets 2022-05-09  437  			break;
d48523cb88e070 Martin Habets 2022-05-09  438  		case EFX_HWMON_CURR:
d48523cb88e070 Martin Habets 2022-05-09  439  			hwmon_prefix = "curr";
d48523cb88e070 Martin Habets 2022-05-09  440  			hwmon_index = ++n_curr; /* 1-based */
d48523cb88e070 Martin Habets 2022-05-09  441  			break;
d48523cb88e070 Martin Habets 2022-05-09  442  		case EFX_HWMON_POWER:
d48523cb88e070 Martin Habets 2022-05-09  443  			hwmon_prefix = "power";
d48523cb88e070 Martin Habets 2022-05-09  444  			hwmon_index = ++n_power; /* 1-based */
d48523cb88e070 Martin Habets 2022-05-09  445  			break;
d48523cb88e070 Martin Habets 2022-05-09  446  		}
d48523cb88e070 Martin Habets 2022-05-09  447  
d48523cb88e070 Martin Habets 2022-05-09  448  		min1 = MCDI_ARRAY_FIELD(outbuf, SENSOR_ENTRY,
d48523cb88e070 Martin Habets 2022-05-09  449  					SENSOR_INFO_ENTRY, j, MIN1);
d48523cb88e070 Martin Habets 2022-05-09  450  		max1 = MCDI_ARRAY_FIELD(outbuf, SENSOR_ENTRY,
d48523cb88e070 Martin Habets 2022-05-09  451  					SENSOR_INFO_ENTRY, j, MAX1);
d48523cb88e070 Martin Habets 2022-05-09  452  		min2 = MCDI_ARRAY_FIELD(outbuf, SENSOR_ENTRY,
d48523cb88e070 Martin Habets 2022-05-09  453  					SENSOR_INFO_ENTRY, j, MIN2);
d48523cb88e070 Martin Habets 2022-05-09  454  		max2 = MCDI_ARRAY_FIELD(outbuf, SENSOR_ENTRY,
d48523cb88e070 Martin Habets 2022-05-09  455  					SENSOR_INFO_ENTRY, j, MAX2);
d48523cb88e070 Martin Habets 2022-05-09  456  
d48523cb88e070 Martin Habets 2022-05-09  457  		if (min1 != max1) {
d48523cb88e070 Martin Habets 2022-05-09 @458  			snprintf(name, sizeof(name), "%s%u_input",
d48523cb88e070 Martin Habets 2022-05-09  459  				 hwmon_prefix, hwmon_index);
d48523cb88e070 Martin Habets 2022-05-09  460  			efx_mcdi_mon_add_attr(
d48523cb88e070 Martin Habets 2022-05-09  461  				efx, name, efx_mcdi_mon_show_value, i, type, 0);
d48523cb88e070 Martin Habets 2022-05-09  462  
d48523cb88e070 Martin Habets 2022-05-09  463  			if (hwmon_type != EFX_HWMON_POWER) {
d48523cb88e070 Martin Habets 2022-05-09  464  				snprintf(name, sizeof(name), "%s%u_min",
d48523cb88e070 Martin Habets 2022-05-09  465  					 hwmon_prefix, hwmon_index);
d48523cb88e070 Martin Habets 2022-05-09  466  				efx_mcdi_mon_add_attr(
d48523cb88e070 Martin Habets 2022-05-09  467  					efx, name, efx_mcdi_mon_show_limit,
d48523cb88e070 Martin Habets 2022-05-09  468  					i, type, min1);
d48523cb88e070 Martin Habets 2022-05-09  469  			}
d48523cb88e070 Martin Habets 2022-05-09  470  
d48523cb88e070 Martin Habets 2022-05-09  471  			snprintf(name, sizeof(name), "%s%u_max",
d48523cb88e070 Martin Habets 2022-05-09  472  				 hwmon_prefix, hwmon_index);
d48523cb88e070 Martin Habets 2022-05-09  473  			efx_mcdi_mon_add_attr(
d48523cb88e070 Martin Habets 2022-05-09  474  				efx, name, efx_mcdi_mon_show_limit,
d48523cb88e070 Martin Habets 2022-05-09  475  				i, type, max1);
d48523cb88e070 Martin Habets 2022-05-09  476  
d48523cb88e070 Martin Habets 2022-05-09  477  			if (min2 != max2) {
d48523cb88e070 Martin Habets 2022-05-09  478  				/* Assume max2 is critical value.
d48523cb88e070 Martin Habets 2022-05-09  479  				 * But we have no good way to expose min2.
d48523cb88e070 Martin Habets 2022-05-09  480  				 */
d48523cb88e070 Martin Habets 2022-05-09  481  				snprintf(name, sizeof(name), "%s%u_crit",
d48523cb88e070 Martin Habets 2022-05-09  482  					 hwmon_prefix, hwmon_index);
d48523cb88e070 Martin Habets 2022-05-09  483  				efx_mcdi_mon_add_attr(
d48523cb88e070 Martin Habets 2022-05-09  484  					efx, name, efx_mcdi_mon_show_limit,
d48523cb88e070 Martin Habets 2022-05-09  485  					i, type, max2);
d48523cb88e070 Martin Habets 2022-05-09  486  			}
d48523cb88e070 Martin Habets 2022-05-09  487  		}
d48523cb88e070 Martin Habets 2022-05-09  488  
d48523cb88e070 Martin Habets 2022-05-09  489  		snprintf(name, sizeof(name), "%s%u_alarm",
d48523cb88e070 Martin Habets 2022-05-09  490  			 hwmon_prefix, hwmon_index);
d48523cb88e070 Martin Habets 2022-05-09  491  		efx_mcdi_mon_add_attr(
d48523cb88e070 Martin Habets 2022-05-09  492  			efx, name, efx_mcdi_mon_show_alarm, i, type, 0);
d48523cb88e070 Martin Habets 2022-05-09  493  
d48523cb88e070 Martin Habets 2022-05-09  494  		if (type < ARRAY_SIZE(efx_mcdi_sensor_type) &&
d48523cb88e070 Martin Habets 2022-05-09  495  		    efx_mcdi_sensor_type[type].label) {
d48523cb88e070 Martin Habets 2022-05-09  496  			snprintf(name, sizeof(name), "%s%u_label",
d48523cb88e070 Martin Habets 2022-05-09  497  				 hwmon_prefix, hwmon_index);
d48523cb88e070 Martin Habets 2022-05-09  498  			efx_mcdi_mon_add_attr(
d48523cb88e070 Martin Habets 2022-05-09  499  				efx, name, efx_mcdi_mon_show_label, i, type, 0);
d48523cb88e070 Martin Habets 2022-05-09  500  		}
d48523cb88e070 Martin Habets 2022-05-09  501  	}
d48523cb88e070 Martin Habets 2022-05-09  502  
d48523cb88e070 Martin Habets 2022-05-09  503  hwmon_register:
d48523cb88e070 Martin Habets 2022-05-09  504  	hwmon->groups[0] = &hwmon->group;
d48523cb88e070 Martin Habets 2022-05-09  505  	hwmon->device = hwmon_device_register_with_groups(&efx->pci_dev->dev,
d48523cb88e070 Martin Habets 2022-05-09  506  							  KBUILD_MODNAME, NULL,
d48523cb88e070 Martin Habets 2022-05-09  507  							  hwmon->groups);
d48523cb88e070 Martin Habets 2022-05-09  508  	if (IS_ERR(hwmon->device)) {
d48523cb88e070 Martin Habets 2022-05-09  509  		rc = PTR_ERR(hwmon->device);
d48523cb88e070 Martin Habets 2022-05-09  510  		goto fail;
d48523cb88e070 Martin Habets 2022-05-09  511  	}
d48523cb88e070 Martin Habets 2022-05-09  512  
d48523cb88e070 Martin Habets 2022-05-09  513  	return 0;
d48523cb88e070 Martin Habets 2022-05-09  514  
d48523cb88e070 Martin Habets 2022-05-09  515  fail:
4d49e5cd4b095c Martin Habets 2022-05-09  516  	efx_siena_mcdi_mon_remove(efx);
d48523cb88e070 Martin Habets 2022-05-09  517  	return rc;
d48523cb88e070 Martin Habets 2022-05-09  518  }
d48523cb88e070 Martin Habets 2022-05-09  519  

:::::: The code at line 458 was first introduced by commit
:::::: d48523cb88e0703055c1b33e61eb644a7976f92b sfc: Copy shared files needed for Siena (part 2)

:::::: TO: Martin Habets <martinh@xilinx.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

