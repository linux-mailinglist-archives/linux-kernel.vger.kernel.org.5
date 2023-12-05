Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9836D804D43
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjLEJLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbjLEJLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:11:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51FE4B0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:11:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85C88139F;
        Tue,  5 Dec 2023 01:11:52 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE68F3F6C4;
        Tue,  5 Dec 2023 01:11:03 -0800 (PST)
Message-ID: <4615fe3e-7f11-d8c6-596b-32833db458d2@arm.com>
Date:   Tue, 5 Dec 2023 09:11:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] coresight: Make current W=1 warnings default
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     oe-kbuild-all@lists.linux.dev, Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20231115162834.355598-1-james.clark@arm.com>
 <202312050158.FKpxuafP-lkp@intel.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <202312050158.FKpxuafP-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2023 18:37, kernel test robot wrote:
> Hi James,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on atorgue-stm32/stm32-next]
> [also build test WARNING on linus/master v6.7-rc4 next-20231204]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/James-Clark/coresight-Make-current-W-1-warnings-default/20231116-004818
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
> patch link:    https://lore.kernel.org/r/20231115162834.355598-1-james.clark%40arm.com
> patch subject: [PATCH v2] coresight: Make current W=1 warnings default
> config: arm-randconfig-r131-20231117 (https://download.01.org/0day-ci/archive/20231205/202312050158.FKpxuafP-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231205/202312050158.FKpxuafP-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312050158.FKpxuafP-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>>> drivers/hwtracing/coresight/coresight-etb10.c:840:17: sparse: sparse: Using plain integer as NULL pointer
>    drivers/hwtracing/coresight/coresight-etb10.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>    include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
> --
>>> drivers/hwtracing/coresight/coresight-funnel.c:395:17: sparse: sparse: Using plain integer as NULL pointer
>    drivers/hwtracing/coresight/coresight-funnel.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, ...):
>    include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
> --
>>> drivers/hwtracing/coresight/coresight-tpdm.c:242:17: sparse: sparse: Using plain integer as NULL pointer
>    drivers/hwtracing/coresight/coresight-tpdm.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>    include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
> 
> vim +840 drivers/hwtracing/coresight/coresight-etb10.c
> 
>    834	
>    835	static const struct amba_id etb_ids[] = {
>    836		{
>    837			.id	= 0x000bb907,
>    838			.mask	= 0x000fffff,
>    839		},
>  > 840		{ 0, 0, 0 },
>    841	};
>    842	
> 

This should already be fixed in V3 here:

https://lore.kernel.org/linux-arm-kernel/20231123120459.287578-1-james.clark@arm.com/
