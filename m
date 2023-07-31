Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD407695CC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjGaMOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjGaMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:14:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C8810F5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:13:59 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RDxsw0JkVzLnhq;
        Mon, 31 Jul 2023 20:11:16 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 20:13:55 +0800
Subject: Re: [PATCH V2 4/5] ubi: Reserve sufficient buffer length for the
 input mask
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230718085119.3885747-1-wangzhaolong1@huawei.com>
 <20230718085119.3885747-5-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <412c027f-a96c-6de3-f493-749566e8c3ac@huawei.com>
Date:   Mon, 31 Jul 2023 20:13:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230718085119.3885747-5-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/7/18 16:51, ZhaoLong Wang Ð´µÀ:
> Because the mask received by the emulate_failures interface
> is a 32-bit unsigned integer, ensure that there is sufficient
> buffer length to receive and display this value.
> 
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
> V2:
>    - A 16-byte buffer is reserved, as implemented by other interfaces.
> 
>   drivers/mtd/ubi/debug.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
> index 016a861c5029..1c3f1a2436e5 100644
> --- a/drivers/mtd/ubi/debug.c
> +++ b/drivers/mtd/ubi/debug.c
> @@ -332,7 +332,7 @@ static ssize_t dfs_file_read(struct file *file, char __user *user_buf,
>   	struct dentry *dent = file->f_path.dentry;
>   	struct ubi_device *ubi;
>   	struct ubi_debug_info *d;
> -	char buf[8];
> +	char buf[16];
>   	int val;
>   
>   	ubi = ubi_get_device(ubi_num);
> @@ -400,7 +400,7 @@ static ssize_t dfs_file_write(struct file *file, const char __user *user_buf,
>   	struct ubi_device *ubi;
>   	struct ubi_debug_info *d;
>   	size_t buf_size;
> -	char buf[8] = {0};
> +	char buf[16] = {0};
>   	int val;
>   
>   	ubi = ubi_get_device(ubi_num);
> 


Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
