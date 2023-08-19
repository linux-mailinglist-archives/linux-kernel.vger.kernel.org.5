Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1AF7816A3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbjHSCYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243838AbjHSCYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:24:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEDB4220
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 19:24:07 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RSMsN1x7GztRhh;
        Sat, 19 Aug 2023 10:20:24 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 19 Aug 2023 10:24:03 +0800
Subject: Re: [PATCH] ubifs: fix missing error code err
To:     Ferry Meng <mengferry@linux.alibaba.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20230818091848.108186-1-mengferry@linux.alibaba.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <0acd50e2-8b0e-0529-9b58-4c92678ab2f9@huawei.com>
Date:   Sat, 19 Aug 2023 10:24:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230818091848.108186-1-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/8/18 17:18, Ferry Meng Ð´µÀ:
> Fix smatch warning:
> 
> fs/ubifs/journal.c:1610 ubifs_jnl_truncate() warn: missing error code
> 'err'
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index dc52ac0f4a34..ab837b73d4b9 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -1607,6 +1607,7 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
>   				ubifs_err(c, "bad data node (block %u, inode %lu)",
>   					  blk, inode->i_ino);
>   				ubifs_dump_node(c, dn, dn_size);
> +				err = -EUCLEAN;
>   				goto out_free;
>   			}
>   
> 

