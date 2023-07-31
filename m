Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32517689AB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjGaBoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGaBon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:44:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0547E57;
        Sun, 30 Jul 2023 18:44:41 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RDgxm2Pw0zrRww;
        Mon, 31 Jul 2023 09:43:40 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 09:44:39 +0800
Subject: Re: [PATCH] scsi:libsas: Simplify sas_queue_reset and remove unused
 code
To:     Wenchao Hao <haowenchao2@huawei.com>,
        John Garry <john.g.garry@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <louhongxiang@huawei.com>
References: <20230729102451.2452826-1-haowenchao2@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <27bb586c-af75-c2da-1b07-02bfb08e5891@huawei.com>
Date:   Mon, 31 Jul 2023 09:44:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230729102451.2452826-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenchao,

On 2023/7/29 18:24, Wenchao Hao wrote:
> sas_queue_reset is always called with param "wait" set to 0, so
> remove it from this function's param list. And remove unused
> function sas_wait_eh.

I did not find any users passing '1' to sas_queue_reset() in the git 
history. It seems it is never used. So It's ok to remove it, I guess.

Just one nit, there should be a blank between "scsi:" and "libsas" in 
the subject:

scsi: libsas: Simplify sas_queue_reset and remove unused code

Otherwise looks good to me:
Reviewed-by: Jason Yan <yanaijie@huawei.com>
