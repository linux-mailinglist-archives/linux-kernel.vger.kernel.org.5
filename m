Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A66080571C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbjLEOVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345853AbjLEOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:21:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA4490
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:21:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F2FC433C7;
        Tue,  5 Dec 2023 14:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701786095;
        bh=i1tccxd+eeEBFdaia4vgRnGqbSydm2KGkprxYV81Cww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/1sMhDuwCzF2R1U8l9QkQcrlKg/XwJGUkDdhtEecCh2K0ZEq1AGgUDPqcLH8Mm+I
         4N4abTyCacNS/I/MevxRwM60PzEmr5Fu0U4OjRQ3FbMmEZb8PgTxNbVGwkDpfi1UQe
         WZ2CNHLdnF3CFF2WHBOhw9YtUPfMv9sNc+4z929tLNkVG9S6frWbW+AWOmKh4POWxm
         +8SZWYu3iRrD9G20XP0ylM+fhj74Feswty6fH1uh4y0UV2GTX5MrpM+EZdpmRISCFh
         FD0+0QBZa39GQUwrgCXxD+lzFLdTsU2pKgc0I1eZPKKJRkOhVV4BpoY55w5M47CUdd
         kGuBk/9ejUerA==
Date:   Tue, 5 Dec 2023 14:21:28 +0000
From:   Will Deacon <will@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, Shuai Xue <xueshuai@linux.alibaba.com>,
        ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v11 4/5] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20231205142128.GA18450@willie-the-truck>
References: <20231121013400.18367-5-xueshuai@linux.alibaba.com>
 <2d52f588-f584-4c01-8f41-227815a54e41@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d52f588-f584-4c01-8f41-227815a54e41@suswa.mountain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 10:06:39AM +0300, Dan Carpenter wrote:
> Hi Shuai,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/docs-perf-Add-description-for-Synopsys-DesignWare-PCIe-PMU-driver/20231121-093713
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20231121013400.18367-5-xueshuai%40linux.alibaba.com
> patch subject: [PATCH v11 4/5] drivers/perf: add DesignWare PCIe PMU driver
> config: x86_64-randconfig-r071-20231123 (https://download.01.org/0day-ci/archive/20231124/202311241906.0ymlLjyo-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce: (https://download.01.org/0day-ci/archive/20231124/202311241906.0ymlLjyo-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202311241906.0ymlLjyo-lkp@intel.com/
> 
> smatch warnings:
> drivers/perf/dwc_pcie_pmu.c:352 dwc_pcie_pmu_event_update() error: uninitialized symbol 'now'.
> 
> vim +/now +352 drivers/perf/dwc_pcie_pmu.c
> 
> 3481798a4ec51d1 Shuai Xue 2023-11-21  338  static void dwc_pcie_pmu_event_update(struct perf_event *event)
> 3481798a4ec51d1 Shuai Xue 2023-11-21  339  {
> 3481798a4ec51d1 Shuai Xue 2023-11-21  340  	struct hw_perf_event *hwc = &event->hw;
> 3481798a4ec51d1 Shuai Xue 2023-11-21  341  	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> 3481798a4ec51d1 Shuai Xue 2023-11-21  342  	u64 delta, prev, now;
> 3481798a4ec51d1 Shuai Xue 2023-11-21  343  
> 3481798a4ec51d1 Shuai Xue 2023-11-21  344  	do {
> 3481798a4ec51d1 Shuai Xue 2023-11-21  345  		prev = local64_read(&hwc->prev_count);
> 3481798a4ec51d1 Shuai Xue 2023-11-21  346  
> 3481798a4ec51d1 Shuai Xue 2023-11-21  347  		if (type == DWC_PCIE_LANE_EVENT)
> 3481798a4ec51d1 Shuai Xue 2023-11-21  348  			now = dwc_pcie_pmu_read_lane_event_counter(event);
> 3481798a4ec51d1 Shuai Xue 2023-11-21  349  		else if (type == DWC_PCIE_TIME_BASE_EVENT)
> 3481798a4ec51d1 Shuai Xue 2023-11-21  350  			now = dwc_pcie_pmu_read_time_based_counter(event);
> 
> uninitialized on else path.
> 
> 3481798a4ec51d1 Shuai Xue 2023-11-21  351  
> 3481798a4ec51d1 Shuai Xue 2023-11-21 @352  	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);

Shuai, any chance you can address this please? I think the event validation
logic means that the type is only ever one of the cases you handle, so
you probably just want to either initialise 'now' to 0 or WARN and return
early if the type is unknown.

Will
