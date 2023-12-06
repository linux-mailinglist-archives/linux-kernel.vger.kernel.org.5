Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148A08064CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376410AbjLFB0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjLFB0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:26:12 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E29D62
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:26:17 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SlKTr24ggzvRhL;
        Wed,  6 Dec 2023 09:25:36 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 09:26:14 +0800
Subject: Re: [PATCH] jffs2: nodemgmt: fix kernel-doc comments
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>
References: <20231205173222.12575-1-rdunlap@infradead.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f0a0eb5d-7cdf-89a1-3017-2dd048d2a0e4@huawei.com>
Date:   Wed, 6 Dec 2023 09:26:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20231205173222.12575-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/12/6 1:32, Randy Dunlap Ð´µÀ:
> Update the end of one sentence where a comment was truncated. (dwmw2)
>
> Fix a bunch of kernel-doc warnings:
>
> nodemgmt.c:72: warning: Function parameter or member 'sumsize' not described in 'jffs2_do_reserve_space'
> nodemgmt.c:72: warning: expecting prototype for jffs2_reserve_space(). Prototype was for jffs2_do_reserve_space() instead
> nodemgmt.c:76: warning: Function parameter or member 'sumsize' not described in 'jffs2_reserve_space'
> nodemgmt.c:76: warning: No description found for return value of 'jffs2_reserve_space'
> nodemgmt.c:503: warning: Function parameter or member 'ofs' not described in 'jffs2_add_physical_node_ref'
> nodemgmt.c:503: warning: Function parameter or member 'ic' not described in 'jffs2_add_physical_node_ref'
> nodemgmt.c:503: warning: Excess function parameter 'new' description in 'jffs2_add_physical_node_ref'
> nodemgmt.c:503: warning: No description found for return value of 'jffs2_add_physical_node_ref'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org
> ---
>   fs/jffs2/nodemgmt.c |   24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff -- a/fs/jffs2/nodemgmt.c b/fs/jffs2/nodemgmt.c
> --- a/fs/jffs2/nodemgmt.c
> +++ b/fs/jffs2/nodemgmt.c
> @@ -49,28 +49,31 @@ static int jffs2_rp_can_write(struct jff
>   	return 0;
>   }
>   
> +static int jffs2_do_reserve_space(struct jffs2_sb_info *c,  uint32_t minsize,
> +				  uint32_t *len, uint32_t sumsize);
> +
>   /**
>    *	jffs2_reserve_space - request physical space to write nodes to flash
>    *	@c: superblock info
>    *	@minsize: Minimum acceptable size of allocation
>    *	@len: Returned value of allocation length
>    *	@prio: Allocation type - ALLOC_{NORMAL,DELETION}
> + *	@sumsize: summary size requested or JFFS2_SUMMARY_NOSUM_SIZE for no summary
> + *
> + *	Requests a block of physical space on the flash.
>    *
> - *	Requests a block of physical space on the flash. Returns zero for success
> - *	and puts 'len' into the appropriate place, or returns -ENOSPC or other
> - *	error if appropriate. Doesn't return len since that's
> + *	Returns: %0 for success	and puts 'len' into the appropriate place,
> + *	or returns -ENOSPC or other error if appropriate.
> + *	Doesn't return len since that's already returned in @len.
>    *
> - *	If it returns zero, jffs2_reserve_space() also downs the per-filesystem
> + *	If it returns %0, jffs2_reserve_space() also downs the per-filesystem
>    *	allocation semaphore, to prevent more than one allocation from being
> - *	active at any time. The semaphore is later released by jffs2_commit_allocation()
> + *	active at any time. The semaphore is later released by jffs2_commit_allocation().
>    *
>    *	jffs2_reserve_space() may trigger garbage collection in order to make room
>    *	for the requested allocation.
>    */
>   
> -static int jffs2_do_reserve_space(struct jffs2_sb_info *c,  uint32_t minsize,
> -				  uint32_t *len, uint32_t sumsize);
> -
>   int jffs2_reserve_space(struct jffs2_sb_info *c, uint32_t minsize,
>   			uint32_t *len, int prio, uint32_t sumsize)
>   {
> @@ -488,13 +491,16 @@ static int jffs2_do_reserve_space(struct
>   /**
>    *	jffs2_add_physical_node_ref - add a physical node reference to the list
>    *	@c: superblock info
> - *	@new: new node reference to add
> + *	@ofs: offset in the block
>    *	@len: length of this physical node
> + *	@ic: inode cache pointer
>    *
>    *	Should only be used to report nodes for which space has been allocated
>    *	by jffs2_reserve_space.
>    *
>    *	Must be called with the alloc_sem held.
> + *
> + *	Returns: pointer to new node on success or -errno code on error
>    */
>   
>   struct jffs2_raw_node_ref *jffs2_add_physical_node_ref(struct jffs2_sb_info *c,
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> .


