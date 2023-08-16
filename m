Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F0177D882
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbjHPClf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjHPClG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:41:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001461FC7;
        Tue, 15 Aug 2023 19:41:04 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQXQ942vWzVjl9;
        Wed, 16 Aug 2023 10:38:57 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 10:41:02 +0800
Subject: Re: [PATCH v2 07/10] scsi: libsas: Delete sas_ssp_task.task_prio
To:     John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <dlemoal@kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
 <20230815115156.343535-8-john.g.garry@oracle.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <734d15a9-28bb-cbe8-c872-d0287b37db01@huawei.com>
Date:   Wed, 16 Aug 2023 10:41:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230815115156.343535-8-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/15 19:51, John Garry wrote:
> Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
> driver"), sas_ssp_task.task_prio is never set, so delete it
> and any references which depend on it being set (all of them).
> 
> Signed-off-by: John Garry<john.g.garry@oracle.com>
> ---
>   drivers/scsi/aic94xx/aic94xx_task.c    | 1 -
>   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 3 +--
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 3 +--
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
>   drivers/scsi/isci/request.c            | 2 +-
>   drivers/scsi/mvsas/mv_sas.c            | 3 +--
>   drivers/scsi/pm8001/pm8001_hwi.c       | 1 -
>   drivers/scsi/pm8001/pm80xx_hwi.c       | 1 -
>   include/scsi/libsas.h                  | 1 -
>   9 files changed, 5 insertions(+), 12 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>
