Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1BC7E023E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjKCLeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:34:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A19D134
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:34:01 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMJTV467CzrTYC;
        Fri,  3 Nov 2023 19:30:54 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 19:33:58 +0800
Subject: Re: [PATCH v4 1/5] ubi: Use the fault injection framework to enhance
 the fault injection capability
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20231103065536.3778940-1-wangzhaolong1@huawei.com>
 <20231103065536.3778940-2-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <1662c6dd-699c-1fae-a10f-037f6ab26ce0@huawei.com>
Date:   Fri, 3 Nov 2023 19:33:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20231103065536.3778940-2-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/11/3 14:55, ZhaoLong Wang Ð´µÀ:
> To make debug parameters configurable at run time, use the
> fault injection framework to reconstruct the debugfs interface,
> and retain the legacy fault injection interface.
>
> Now, the file emulate_failures and fault_attr files control whether
> to enable fault emmulation.
>
> The file emulate_failures receives a mask that controls type and
> process of fault injection. Generally, for ease of use, you can
> directly enter a mask with all 1s.
>
> echo 0xffff > /sys/kernel/debug/ubi/ubi0/emulate_failures
>
> And you need to configure other fault-injection capabilities for
> testing purpose:
>
> echo 100 > /sys/kernel/debug/ubi/fault_inject/emulate_power_cut/probability
> echo 15 > /sys/kernel/debug/ubi/fault_inject/emulate_power_cut/space
> echo 2 > /sys/kernel/debug/ubi/fault_inject/emulate_power_cut/verbose
> echo -1 > /sys/kernel/debug/ubi/fault_inject/emulate_power_cut/times
>
> The CONFIG_MTD_UBI_FAULT_INJECTION to enable the Fault Injection is
> added to kconfig.
>
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/ubi/Kconfig |   9 +++
>   drivers/mtd/ubi/debug.c |  68 +++++++++++++++++--
>   drivers/mtd/ubi/debug.h | 142 +++++++++++++++++++++++++++++++++-------
>   drivers/mtd/ubi/io.c    |  10 ++-
>   drivers/mtd/ubi/ubi.h   |  15 ++---
>   5 files changed, 202 insertions(+), 42 deletions(-)
>
>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

