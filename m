Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF597A491F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbjIRMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241960AbjIRMCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:02:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AF91BD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:01:27 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38IBOmKw007675;
        Mon, 18 Sep 2023 07:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=yL2E826Vt1q+57J
        6jFRsHwaJbh1oPSMB7gsPT2ALWLw=; b=VxsOrqxcUhvq1TrMD7bom8fHUlFColE
        DzRdG1gT2UI9wZZntxgBigQeVipsUBP6pC93Rho2dAkouo8KOXSyVOllvtP5DzDu
        LsKZRSDAPlKBUTDCLHKAyE03WQKksnSWevBSjEG6hQf4TM0pZA41rfWoxDttzCBc
        qrzOkqwfkfnliNJP3YNTkHKxCoGzQpbDP5JCqiESMd2t6uVGyuLfnvdjo3tFKse/
        OvCLXYAvHmUimK1AEbBOgxgszMcoJEfU0uHJnhMNFC1CKmsAj/NvOIXeVcgHjErB
        Ayl51DCiPUOrtkhGKoXTNGGrNl4skGeP4MD62UdoOYc9O1cc0Jng8qg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t58shsqy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 07:01:05 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 13:01:03 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Mon, 18 Sep 2023 13:01:03 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7BF713563;
        Mon, 18 Sep 2023 12:01:03 +0000 (UTC)
Date:   Mon, 18 Sep 2023 12:01:03 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     kernel test robot <lkp@intel.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Lee Jones <lee@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: drivers/soundwire/bus_type.c:126:30: error: implicit declaration
 of function 'irq_create_mapping'; did you mean 'irq_dispose_mapping'?
Message-ID: <20230918120103.GZ103419@ediswmail.ad.cirrus.com>
References: <202309150820.6zuErL12-lkp@intel.com>
 <bf1bd8ee-b102-47e5-82c7-e190a43d984c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bf1bd8ee-b102-47e5-82c7-e190a43d984c@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: vQTv1IexqBbMf-B4FUwi2tm4c0BGjZ9X
X-Proofpoint-ORIG-GUID: vQTv1IexqBbMf-B4FUwi2tm4c0BGjZ9X
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:14:52PM -0700, Randy Dunlap wrote:
> 
> 
> On 9/14/23 17:26, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   9fdfb15a3dbf818e06be514f4abbfc071004cbe7
> > commit: 12a95123bfe1dd1a6020a35f5e67a560591bb02a soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
> > date:   4 weeks ago
> > config: s390-randconfig-r031-20220110 (https://download.01.org/0day-ci/archive/20230915/202309150820.6zuErL12-lkp@intel.com/config)
> > compiler: s390-linux-gcc (GCC) 11.3.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150820.6zuErL12-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202309150820.6zuErL12-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/soundwire/bus_type.c: In function 'sdw_drv_probe':
> >>> drivers/soundwire/bus_type.c:126:30: error: implicit declaration of function 'irq_create_mapping'; did you mean 'irq_dispose_mapping'? [-Werror=implicit-function-declaration]
> >      126 |                 slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
> >          |                              ^~~~~~~~~~~~~~~~~~
> >          |                              irq_dispose_mapping
> >    drivers/soundwire/bus_type.c: In function 'sdw_drv_remove':
> >>> drivers/soundwire/bus_type.c:179:37: error: implicit declaration of function 'irq_find_mapping'; did you mean 'irq_dispose_mapping'? [-Werror=implicit-function-declaration]
> >      179 |                 irq_dispose_mapping(irq_find_mapping(slave->bus->domain,
> >          |                                     ^~~~~~~~~~~~~~~~
> >          |                                     irq_dispose_mapping
> >    cc1: some warnings being treated as errors
> > --
> >    drivers/soundwire/bus.c: In function 'sdw_bus_master_add':
> >>> drivers/soundwire/bus.c:173:23: error: implicit declaration of function 'irq_domain_create_linear' [-Werror=implicit-function-declaration]
> >      173 |         bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
> >          |                       ^~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/soundwire/bus.c:173:21: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >      173 |         bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
> >          |                     ^
> >    drivers/soundwire/bus.c: In function 'sdw_bus_master_delete':
> >>> drivers/soundwire/bus.c:217:9: error: implicit declaration of function 'irq_domain_remove' [-Werror=implicit-function-declaration]
> >      217 |         irq_domain_remove(bus->domain);
> >          |         ^~~~~~~~~~~~~~~~~
> >    cc1: some warnings being treated as errors
> > 
> 
> CONFIG_IRQ_DOMAIN is not set in the .config file.
> Should SOUNDWIRE select IRQ_DOMAIN?
> 

Probably a reasonable fix, but I wonder if it might be better to
make my new additions optional. Since SoundWire isn't strictly
dependent on my IRQ additions.

I will have a look this afternoon at what I can get working.

Thanks,
Charles
