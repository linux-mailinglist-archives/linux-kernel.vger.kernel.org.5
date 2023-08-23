Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEF0784F26
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 05:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjHWDPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 23:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjHWDPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 23:15:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5AACE8;
        Tue, 22 Aug 2023 20:15:44 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVrq15kHGztS8T;
        Wed, 23 Aug 2023 11:11:57 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:15:41 +0800
Message-ID: <1b87e5c8-ceed-9b7a-4137-89d085e6c959@huawei.com>
Date:   Wed, 23 Aug 2023 11:15:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ethtool] hns3: add support dump registers for hns3 driver
To:     <mkubecek@suse.cz>
References: <20230818085611.2483909-1-shaojijie@huawei.com>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20230818085611.2483909-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/8/18 16:56, Jijie Shao wrote:
> Add support pretty printer for the registers of hns3 driver.
> This printer supports PF and VF, and is compatible with hns3
> drivers of earlier versions.
>
> Sample output:
>
> $ ethtool -d eth1
> [cmdq_regs]
>    comm_nic_csq_baseaddr_l : 0x48168000
>    comm_nic_csq_baseaddr_h : 0x00000000
>    comm_nic_csq_depth      : 0x00000080
>    comm_nic_csq_tail       : 0x00000050
>    comm_nic_csq_head       : 0x00000050
>    comm_nic_crq_baseaddr_l : 0x48170000
>    comm_nic_crq_baseaddr_h : 0x00000000
>    comm_nic_crq_depth      : 0x00000080
>    comm_nic_crq_tail       : 0x00000000
>    comm_nic_crq_head       : 0x00000000
>    comm_vector0_cmdq_src   : 0x00000000
>    comm_cmdq_intr_sts      : 0x00000000
>    comm_cmdq_intr_en       : 0x00000002
>    comm_cmdq_intr_gen      : 0x00000000
> [common_regs]
>    misc_vector_base    : 0x00000001
>    pf_other_int        : 0x00000040
>    misc_reset_sts      : 0x00000000
>    misc_vector_int_sts : 0x00000000
>    global_reset        : 0x00000000
>    fun_rst_ing         : 0x00000000
>    gro_en              : 0x00000001
> ...

Hi，

We noticed that this patch had been stuck for several days.

Is there any problem with this patch?

Jijie Shao

