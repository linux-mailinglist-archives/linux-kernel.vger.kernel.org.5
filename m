Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D1E75AEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjGTMnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGTMnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:43:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A802135
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:43:37 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R6C2Q2gHMzNmWD;
        Thu, 20 Jul 2023 20:40:14 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 20:43:34 +0800
Message-ID: <ec39e8e2-be33-583c-d685-c088f427e9f2@huawei.com>
Date:   Thu, 20 Jul 2023 20:43:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 0/2] soc: hisilicon: Support HCCS driver on Kunpeng SoC
To:     <arnd@arndb.de>, <sudeep.holla@arm.com>, <krzk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <wanghuiqiang@huawei.com>, <tanxiaofei@huawei.com>,
        <liuyonglong@huawei.com>, <xuwei5@hisilicon.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230530112746.2767-1-lihuisong@huawei.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230530112746.2767-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Now I add HiSilicon SOC maintainer Wei Xu attributing to Krzysztof's 
reminder.

Thanks for your review. All comments have been closed.
Could you please kindly confirm my modifications for your comments?
If it is ok for you. In order to go on smoothly, can you reply?😁

Best regards,
Huisong


在 2023/5/30 19:27, Huisong Li 写道:
> This series add HCCS driver to query the health status and port information
> of HCCS on Kunpeng SoC as well as document all sysfs entries provided by
> this driver.
>
> ---
>   v3:
>    - replace "using_status" with "enable" attribute.
>    - fix some comments in codes.
>
> ---
>   v2:
>    - Document all sysfs entries provided by driver.
>    - drop 'pcc_type' and 'intr_mode' in struct hccs_dev.
>    - using _CRS with PCC GAS to get channel ID instead of _DSD.
>    - replace readw_relaxed_poll_timeout with readw_poll_timeout.
>    - use sysfs_emit() instead of sprintf().
>    - drop ACPI_PTR in hccs_driver.
>    - drop useless log during the probe phase.
>
> Huisong Li (2):
>    soc: hisilicon: Support HCCS driver on Kunpeng SoC
>    doc: soc: hisilicon: Add Kunpeng HCCS driver documentation
>
>   .../sysfs-devices-platform-kunpeng_hccs       |   76 +
>   MAINTAINERS                                   |    7 +
>   drivers/soc/Kconfig                           |    1 +
>   drivers/soc/Makefile                          |    1 +
>   drivers/soc/hisilicon/Kconfig                 |   19 +
>   drivers/soc/hisilicon/Makefile                |    2 +
>   drivers/soc/hisilicon/kunpeng_hccs.c          | 1288 +++++++++++++++++
>   drivers/soc/hisilicon/kunpeng_hccs.h          |  196 +++
>   8 files changed, 1590 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
>   create mode 100644 drivers/soc/hisilicon/Kconfig
>   create mode 100644 drivers/soc/hisilicon/Makefile
>   create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.c
>   create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.h
>
