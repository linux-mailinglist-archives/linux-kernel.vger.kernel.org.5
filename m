Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D244F7F0B00
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjKTD37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjKTD35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:29:57 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3DD1A1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:29:52 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SYXvg0j31zRj3H;
        Mon, 20 Nov 2023 11:25:35 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 20 Nov 2023 11:29:49 +0800
CC:     <yangyicong@hisilicon.com>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <dietmar.eggemann@arm.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] arch_topology: Support basic SMT control for the
 driver
To:     kernel test robot <lkp@intel.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <sudeep.holla@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231114040110.54590-2-yangyicong@huawei.com>
 <202311152356.OWWDpFRB-lkp@intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <0ef6d426-1b35-5455-5f97-b2f03b042560@huawei.com>
Date:   Mon, 20 Nov 2023 11:29:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <202311152356.OWWDpFRB-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/15 23:23, kernel test robot wrote:
> Hi Yicong,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus arm/for-next kvmarm/next soc/for-next linus/master arm/fixes v6.7-rc1 next-20231115]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yicong-Yang/arch_topology-Support-basic-SMT-control-for-the-driver/20231114-120544
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20231114040110.54590-2-yangyicong%40huawei.com
> patch subject: [PATCH v3 1/4] arch_topology: Support basic SMT control for the driver
> config: arm-socfpga_defconfig (https://download.01.org/0day-ci/archive/20231115/202311152356.OWWDpFRB-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231115/202311152356.OWWDpFRB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311152356.OWWDpFRB-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/base/arch_topology.c:32:12: warning: unused variable 'topology_smt_num_threads' [-Wunused-variable]
>       32 | static int topology_smt_num_threads = 1;
>          |            ^
>    1 warning generated.
> 

This variable needs to be protected by CONFIG_HOTPLUG_SMT, otherwise it'll be unused
if architecture like arm/parisc selects CONFIG_GENERIC_ARCH_TOPOLOGY but not
CONFIG_HOTPLUG_SMT.

> 
> vim +/topology_smt_num_threads +32 drivers/base/arch_topology.c
> 
>     30	
>     31	/* Maximum threads number per-Core */
>   > 32	static int topology_smt_num_threads = 1;
>     33	
> 
