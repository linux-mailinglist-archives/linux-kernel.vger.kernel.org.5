Return-Path: <linux-kernel+bounces-149532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574508A9286
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895391C20886
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A7E54BFB;
	Thu, 18 Apr 2024 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvPPjrqf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD2C4F8A3;
	Thu, 18 Apr 2024 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418821; cv=none; b=uo9GZmy4t0rpZN1MMjzf/b5cgJWGxGtn/3trHK1ZMuDqg5lsOLS+mTXi59kxCiKN15sFckFq/Q8/hJ0CY21zNyUjTB+VEOgScHC6snkWPfZzYVJfarl7oTe1L5+v7VMCVbajYqm88SpjpfnkISPRIP/ls9a0DFKjrthVDxQApQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418821; c=relaxed/simple;
	bh=Xn0RVWlvlTOyrRFUOOl8D91VYhROtu1vHRLvJ0eToUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaL24Fw+mnunphyZIJSkGgaVsai6x+uN3iGM2lcf1VpVpOOEENS3l+dCQeaCRkJS40HHFtRwIj7H/umSObmw13+IVQOEfHpM3eRsyIbUy7Bk9QDjK80eCYZ5B/Bu3T2xptXXR5XRPE/XP3i+6hLxJ5ibFZCTXupiS/uVP0JGMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvPPjrqf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713418819; x=1744954819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xn0RVWlvlTOyrRFUOOl8D91VYhROtu1vHRLvJ0eToUg=;
  b=GvPPjrqfIRsixVvuzPihn9TyFyZjfaOhvUg6ruG6V+A9SlG89+tyx/55
   gkbOHZrXFr9AEWGV24ETpy5DIrH5isu2Uc4MT3BigL9iOvvsz0WXgXFPm
   yLYHk0m2tpxum8UwuiFO6xW0qGqZ5hvbTcGlAXJ1p1s1Iw1KICC4pdiAY
   lzrS7rigL/ZwhaiVswqI1P5fUQws+4if//7L+1jR+RRMbcdWI/NyavKKm
   qMQ1gYWwv/8UEQYiFvWT3HnwGrb4T2HPO58Ce3Gr4YOLpqsUF1sbYJfZV
   zWqQlvPZirK4gNoG7NJbx4ftjJ+MoQHJZmj9vxA4KdZo0pETMPsIQcoTw
   g==;
X-CSE-ConnectionGUID: Nl67XlHDQWWngbY8Je8TBQ==
X-CSE-MsgGUID: /HSMS1PlSVuO9QVnTUQ3eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19549959"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="19549959"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:40:18 -0700
X-CSE-ConnectionGUID: hqK14G0XTG6g02nkkwNImA==
X-CSE-MsgGUID: 7ozkoNQSQKWrUEm/U+1dQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22958159"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 17 Apr 2024 22:40:16 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxKVI-0007Lu-0q;
	Thu, 18 Apr 2024 05:40:12 +0000
Date: Thu, 18 Apr 2024 13:39:36 +0800
From: kernel test robot <lkp@intel.com>
To: Sylvain Petinot <sylvain.petinot@foss.st.com>,
	benjamin.mugnier@foss.st.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: i2c: Add driver for ST VD56G3 camera sensor
Message-ID: <202404181322.l6Ajlqbf-lkp@intel.com>
References: <20240417133453.17406-3-sylvain.petinot@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417133453.17406-3-sylvain.petinot@foss.st.com>

Hi Sylvain,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v6.9-rc4 next-20240417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sylvain-Petinot/media-dt-bindings-Add-ST-VD56G3-camera-sensor-binding/20240417-213838
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20240417133453.17406-3-sylvain.petinot%40foss.st.com
patch subject: [PATCH 2/2] media: i2c: Add driver for ST VD56G3 camera sensor
config: m68k-randconfig-r071-20240418 (https://download.01.org/0day-ci/archive/20240418/202404181322.l6Ajlqbf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404181322.l6Ajlqbf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404181322.l6Ajlqbf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/st-vd56g3.c:1164:12: warning: 'vd56g3_runtime_suspend' defined but not used [-Wunused-function]
    1164 | static int vd56g3_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/i2c/st-vd56g3.c:1142:12: warning: 'vd56g3_runtime_resume' defined but not used [-Wunused-function]
    1142 | static int vd56g3_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +/vd56g3_runtime_suspend +1164 drivers/media/i2c/st-vd56g3.c

  1141	
> 1142	static int vd56g3_runtime_resume(struct device *dev)
  1143	{
  1144		struct v4l2_subdev *sd = dev_get_drvdata(dev);
  1145		struct vd56g3 *sensor = to_vd56g3(sd);
  1146		struct i2c_client *client = sensor->i2c_client;
  1147		int ret;
  1148	
  1149		ret = vd56g3_power_on(sensor);
  1150		if (ret) {
  1151			dev_err(&client->dev, "Failed to power on %d", ret);
  1152			return ret;
  1153		}
  1154	
  1155		ret = vd56g3_boot(sensor);
  1156		if (ret) {
  1157			dev_err(&client->dev, "sensor boot failed %d", ret);
  1158			return ret;
  1159		}
  1160	
  1161		return ret;
  1162	}
  1163	
> 1164	static int vd56g3_runtime_suspend(struct device *dev)
  1165	{
  1166		struct v4l2_subdev *sd = dev_get_drvdata(dev);
  1167		struct vd56g3 *sensor = to_vd56g3(sd);
  1168	
  1169		return vd56g3_power_off(sensor);
  1170	}
  1171	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

