Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370597E0243
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbjKCLgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjKCLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:36:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E68134
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:36:42 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMJXc0k0rzrV35;
        Fri,  3 Nov 2023 19:33:36 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 19:36:40 +0800
Subject: Re: [PATCH v4 3/5] ubi: Add six fault injection type for testing
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20231103065536.3778940-1-wangzhaolong1@huawei.com>
 <20231103065536.3778940-4-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f4f9fd14-23a6-0ce1-fedc-7428123a63f3@huawei.com>
Date:   Fri, 3 Nov 2023 19:36:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20231103065536.3778940-4-wangzhaolong1@huawei.com>
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
> This commit adds six fault injection type for testing to cover the
> abnormal path of the UBI driver.
>
> Inject the following faults when the UBI reads the LEB:
>   +----------------------------+-----------------------------------+
>   |    Interface name          |       emulate behavior            |
>   +----------------------------+-----------------------------------+
>   |  emulate_eccerr            | ECC error                         |
>   +----------------------------+-----------------------------------+
>   |  emulate_read_failure      | read failure                      |
>   |----------------------------+-----------------------------------+
>   |  emulate_io_ff             | read content as all FF            |
>   |----------------------------+-----------------------------------+
>   |  emulate_io_ff_bitflips    | content FF with MTD err reported  |
>   +----------------------------+-----------------------------------+
>   |  emulate_bad_hdr           | bad leb header                    |
>   |----------------------------+-----------------------------------+
>   |  emulate_bad_hdr_ebadmsg   | bad header with ECC err           |
>   +----------------------------+-----------------------------------+
>
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/ubi/debug.c |  30 +++++++
>   drivers/mtd/ubi/debug.h | 172 ++++++++++++++++++++++++++++++++++++++--
>   drivers/mtd/ubi/io.c    |  76 +++++++++++++++++-
>   drivers/mtd/ubi/ubi.h   |  30 ++++---
>   4 files changed, 287 insertions(+), 21 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

