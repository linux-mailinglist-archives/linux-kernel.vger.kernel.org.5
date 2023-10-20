Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024957D0811
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbjJTGC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbjJTGC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:02:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F87CA;
        Thu, 19 Oct 2023 23:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697781776; x=1729317776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OFcORb9kBXdYN+vup1rawQo4ra/q85nGcGOYP0JXJag=;
  b=MVRyvb5Pv1WjEBptbh9KuZLpKboS309CrsjdIWBVKqEXo+ywKVFK+B1a
   +9O/bi3xzDD/na7HEZclPEL74LTU5jriQceDVATIRfiN1I38YZL7sYMp9
   Dm51IgNEU6pwlnTz7JrFCKdM5XDUqyXNhJHkZlYfDH2oRyR/aN9/fPCuf
   mTSh9gRLylWPT5mxcS47kLjiALTqFOa+wX2ZJl/jtUwQoDvisR1Bv7rNb
   aNP13HHpdhRb1Xx1t4pQzw2Yhq+gLbeKXJK+KkTMYqPl2M1gL+hRjwdQi
   qEO1YgCbasyjC+i2k+RsK9rmTl+M1m0PNkImlt/U6hCyCzPrecTM0dW0M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="371507887"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="371507887"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 23:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="757338898"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="757338898"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Oct 2023 23:02:51 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtiau-00036Y-2k;
        Fri, 20 Oct 2023 06:02:48 +0000
Date:   Fri, 20 Oct 2023 14:02:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: [PATCH 03/12] usb: dwc3: qcom: Merge resources from urs_usb
 device
Message-ID: <202310201318.RPa2yUmS-lkp@intel.com>
References: <20231016-dwc3-refactor-v1-3-ab4a84165470@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dwc3-refactor-v1-3-ab4a84165470@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4d0515b235dec789578d135a5db586b25c5870cb]

url:    https://github.com/intel-lab-lkp/linux/commits/Bjorn-Andersson/dt-bindings-usb-qcom-dwc3-Add-qcom-sc8180x-dwc3/20231017-160323
base:   4d0515b235dec789578d135a5db586b25c5870cb
patch link:    https://lore.kernel.org/r/20231016-dwc3-refactor-v1-3-ab4a84165470%40quicinc.com
patch subject: [PATCH 03/12] usb: dwc3: qcom: Merge resources from urs_usb device
config: csky-randconfig-002-20231020 (https://download.01.org/0day-ci/archive/20231020/202310201318.RPa2yUmS-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310201318.RPa2yUmS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310201318.RPa2yUmS-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/dwc3-qcom.c: In function 'dwc3_qcom_acpi_merge_urs_resources':
>> drivers/usb/dwc3/dwc3-qcom.c:795:17: error: implicit declaration of function 'acpi_dev_get_resources'; did you mean 'acpi_get_event_resources'? [-Werror=implicit-function-declaration]
     795 |         count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 acpi_get_event_resources
>> drivers/usb/dwc3/dwc3-qcom.c:803:17: error: implicit declaration of function 'acpi_dev_free_resource_list' [-Werror=implicit-function-declaration]
     803 |                 acpi_dev_free_resource_list(&resource_list);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +795 drivers/usb/dwc3/dwc3-qcom.c

   763	
   764	static int dwc3_qcom_acpi_merge_urs_resources(struct platform_device *pdev)
   765	{
   766		struct device *dev = &pdev->dev;
   767		struct list_head resource_list;
   768		struct resource_entry *rentry;
   769		struct resource *resources;
   770		struct fwnode_handle *fwh;
   771		struct acpi_device *adev;
   772		char name[8];
   773		int count;
   774		int ret;
   775		int id;
   776		int i;
   777	
   778		/* Figure out device id */
   779		ret = sscanf(fwnode_get_name(dev->fwnode), "URS%d", &id);
   780		if (!ret)
   781			return -EINVAL;
   782	
   783		/* Find the child using name */
   784		snprintf(name, sizeof(name), "USB%d", id);
   785		fwh = fwnode_get_named_child_node(dev->fwnode, name);
   786		if (!fwh)
   787			return 0;
   788	
   789		adev = to_acpi_device_node(fwh);
   790		if (!adev)
   791			return -EINVAL;
   792	
   793		INIT_LIST_HEAD(&resource_list);
   794	
 > 795		count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
   796		if (count <= 0)
   797			return count;
   798	
   799		count += pdev->num_resources;
   800	
   801		resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
   802		if (!resources) {
 > 803			acpi_dev_free_resource_list(&resource_list);
   804			return -ENOMEM;
   805		}
   806	
   807		memcpy(resources, pdev->resource, sizeof(struct resource) * pdev->num_resources);
   808		count = pdev->num_resources;
   809		list_for_each_entry(rentry, &resource_list, node) {
   810			/* Avoid inserting duplicate entries, in case this is called more than once */
   811			for (i = 0; i < count; i++) {
   812				if (resource_type(&resources[i]) == resource_type(rentry->res) &&
   813				    resources[i].start == rentry->res->start &&
   814				    resources[i].end == rentry->res->end)
   815					break;
   816			}
   817	
   818			if (i == count)
   819				resources[count++] = *rentry->res;
   820		}
   821	
   822		ret = platform_device_add_resources(pdev, resources, count);
   823		if (ret)
   824			dev_err(&pdev->dev, "failed to add resources\n");
   825	
   826		acpi_dev_free_resource_list(&resource_list);
   827		kfree(resources);
   828	
   829		return ret;
   830	}
   831	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
