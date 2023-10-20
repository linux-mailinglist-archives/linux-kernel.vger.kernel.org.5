Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD27D0B32
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376586AbjJTJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376523AbjJTJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:11:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53680D55
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:11:34 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SBdzy5X5Mz15NkJ;
        Fri, 20 Oct 2023 17:08:46 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 20 Oct 2023 17:11:31 +0800
Subject: Re: [PATCH v3 5/5] mtd: Add several functions to the fail_function
 list
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20231020064803.643399-1-wangzhaolong1@huawei.com>
 <20231020064803.643399-6-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <0f9dba22-973c-6873-9116-40f2aa381e74@huawei.com>
Date:   Fri, 20 Oct 2023 17:11:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20231020064803.643399-6-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/10/20 14:48, ZhaoLong Wang Ð´µÀ:
> add mtd_read(), mtd_write(), mtd_erase(), mtd_block_markbad() to
> fail_function list for testing purpose
> 
> - Specify the function to inject the fault
> echo mtd_read >  /sys/kernel/debug/fail_function/inject
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

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

