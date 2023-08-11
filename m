Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D347789EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjHKJbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjHKJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:31:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0422D7B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:30:59 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RMdjr0GLxzCrgn;
        Fri, 11 Aug 2023 17:27:28 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 17:30:56 +0800
Message-ID: <64D5FFD0.8060008@hisilicon.com>
Date:   Fri, 11 Aug 2023 17:30:56 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Huisong Li <lihuisong@huawei.com>, <arnd@arndb.de>,
        <krzk@kernel.org>, <sudeep.holla@arm.com>, <rdunlap@infradead.org>,
        <zenghui.yu@linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <wanghuiqiang@huawei.com>,
        <tanxiaofei@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH v7 0/3] soc: hisilicon: Support HCCS driver on Kunpeng
 SoC
References: <20230424073020.4039-1-lihuisong@huawei.com> <20230808023640.25263-1-lihuisong@huawei.com>
In-Reply-To: <20230808023640.25263-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.39]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huisong,

On 2023/8/8 10:36, Huisong Li wrote:
> This series add HCCS driver to query the health status and port information
> of HCCS on Kunpeng SoC as well as document all sysfs entries provided by
> this driver.
> 
> ---
>  v7:
>  - split patch 1/2 to make it easier to review.                 
>  - fix a wrong command code in hccs_get_die_all_link_status(). 
>  - remove unused code and fix a log description in error branch.
> 
>  v6:
>  - fix the new entry in MAINTAINERS file to keep alphabetical order
> 
>  v5:
>  - fix document format to eliminate warning of making htmldocs.
> 
>  v4:
>  - remove useless header and reorder linux header.
>  - use __ATTR_RO to replace __ATTR for port attributes.
>  - add MODULE_DEVICE_TABLE to autoload the driver.
>  - update the date to "November 2023".
>  - fix some comments about HCCS description.
> 
>  v3:
>   - replace "using_status" with "enable" attribute.
>   - fix some comments in codes.
> 
>  v2:
>   - Document all sysfs entries provided by driver.
>   - drop 'pcc_type' and 'intr_mode' in struct hccs_dev.
>   - using _CRS with PCC GAS to get channel ID instead of _DSD.
>   - replace readw_relaxed_poll_timeout with readw_poll_timeout.
>   - use sysfs_emit() instead of sprintf().
>   - drop ACPI_PTR in hccs_driver.
>   - drop useless log during the probe phase.
> 
> Huisong Li (3):
>   soc: hisilicon: Support HCCS driver on Kunpeng SoC
>   soc: hisilicon: add sysfs entry to query information of HCCS
>   doc: soc: hisilicon: Add Kunpeng HCCS driver documentation
> 
>  .../sysfs-devices-platform-kunpeng_hccs       |   81 ++
>  MAINTAINERS                                   |    7 +
>  drivers/soc/Kconfig                           |    1 +
>  drivers/soc/Makefile                          |    1 +
>  drivers/soc/hisilicon/Kconfig                 |   20 +
>  drivers/soc/hisilicon/Makefile                |    2 +
>  drivers/soc/hisilicon/kunpeng_hccs.c          | 1275 +++++++++++++++++
>  drivers/soc/hisilicon/kunpeng_hccs.h          |  191 +++
>  8 files changed, 1578 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
>  create mode 100644 drivers/soc/hisilicon/Kconfig
>  create mode 100644 drivers/soc/hisilicon/Makefile
>  create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.c
>  create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.h
> 

Thanks!
Series applied to the hisilicon driver tree.

Best Regards,
Wei
