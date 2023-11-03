Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A3D7E024C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346544AbjKCLja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjKCLj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:39:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96781BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:39:26 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMJbm2LDjzrTXc;
        Fri,  3 Nov 2023 19:36:20 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 19:39:24 +0800
Subject: Re: [PATCH v4 5/5] mtd: Add several functions to the fail_function
 list
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20231103065536.3778940-1-wangzhaolong1@huawei.com>
 <20231103065536.3778940-6-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3a358dd2-a923-a55f-5803-7e97c1178dad@huawei.com>
Date:   Fri, 3 Nov 2023 19:39:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20231103065536.3778940-6-wangzhaolong1@huawei.com>
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
> add mtd_read(), mtd_write(), mtd_erase(), mtd_block_markbad() to
> fail_function list for testing purpose
> 
> - Specify the function to inject the fault
> echo mtd_read > /sys/kernel/debug/fail_function/inject
> 
> - Specifies the return value of the function to inject the fault
> printf %#x -12 > /sys/kernel/debug/fail_function/mtd_read/retval
> 
> - Specify other fault injection configuration parameters.
> echo -1 > /sys/kernel/debug/fail_function/times
> echo 100 > /sys/kernel/debug/fail_function/probability
> echo 15 > /sys/kernel/debug/fail_function/space
> 
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/mtdcore.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

