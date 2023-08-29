Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9D278BC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjH2BUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbjH2BUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:20:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF66B13D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:20:18 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RZTzj1Z5gzLpCP;
        Tue, 29 Aug 2023 09:17:05 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 29 Aug 2023 09:20:15 +0800
Message-ID: <38f79e2d-45a6-2377-9ad0-ee32461bd9d7@huawei.com>
Date:   Tue, 29 Aug 2023 09:20:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH v2 0/2] iommu/iova: Make the rcache depot properly
 flexible
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <john.g.garry@oracle.com>,
        <dheerajkumar.srivastava@amd.com>, <jsnitsel@redhat.com>,
        <joro@8bytes.org>
References: <cover.1692641204.git.robin.murphy@arm.com>
From:   "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <cover.1692641204.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/22 2:22, Robin Murphy 写道:
> v1: https://lore.kernel.org/linux-iommu/cover.1692033783.git.robin.murphy@arm.com/
>
> Hi all,
>
> Here's a quick update, cleaning up the silly bugs from v1 and taking
> John's suggestion to improve the comments.
>
> Cheers,
> Robin.
>
>
> Robin Murphy (2):
>    iommu/iova: Make the rcache depot scale better
>    iommu/iova: Manage the depot list size
>
>   drivers/iommu/iova.c | 94 ++++++++++++++++++++++++++++++--------------
>   1 file changed, 64 insertions(+), 30 deletions(-)
>

Sorry for the delay, I got some trouble with our performance test 
environment. I had made some performance test for this patches, and the 
result looks good.

Thanks,
Zekun
