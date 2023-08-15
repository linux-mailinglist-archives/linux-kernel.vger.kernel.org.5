Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC8A77CA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjHOJdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjHOJcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:32:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752511FD2;
        Tue, 15 Aug 2023 02:30:55 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQ5Wn2r3sztS6v;
        Tue, 15 Aug 2023 17:27:17 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 17:30:52 +0800
Subject: Re: [PATCH 04/10] scsi: libsas: Delete struct scsi_core
To:     John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dlemoal@kernel.org>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-5-john.g.garry@oracle.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <d03970a5-f2a1-30ba-4667-8c84f5148f9e@huawei.com>
Date:   Tue, 15 Aug 2023 17:30:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230814141022.36875-5-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2023/8/14 22:10, John Garry wrote:
> Since commit 79855d178557 ("libsas: remove task_collector mode"), struct
> scsi_core only contains a reference to the shost. struct scsi_core is only
> used in sas_ha_struct.core, so delete scsi_core and replace with a
> reference to the shost there.
> 
> Signed-off-by: John Garry<john.g.garry@oracle.com>
> ---
>   drivers/scsi/aic94xx/aic94xx_hwi.c     |  2 +-
>   drivers/scsi/aic94xx/aic94xx_init.c    |  6 +++---
>   drivers/scsi/hisi_sas/hisi_sas_main.c  |  6 +++---
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  6 +++---
>   drivers/scsi/isci/host.h               |  2 +-
>   drivers/scsi/isci/init.c               |  4 ++--
>   drivers/scsi/libsas/sas_ata.c          |  8 ++++----
>   drivers/scsi/libsas/sas_discover.c     |  8 ++++----
>   drivers/scsi/libsas/sas_expander.c     |  2 +-
>   drivers/scsi/libsas/sas_host_smp.c     |  4 ++--
>   drivers/scsi/libsas/sas_init.c         | 16 ++++++++--------
>   drivers/scsi/libsas/sas_phy.c          |  8 ++++----
>   drivers/scsi/libsas/sas_port.c         |  6 +++---
>   drivers/scsi/libsas/sas_scsi_host.c    | 14 +++++++-------
>   drivers/scsi/mvsas/mv_init.c           |  4 ++--
>   drivers/scsi/pm8001/pm8001_init.c      |  2 +-
>   include/scsi/libsas.h                  |  7 +------
>   17 files changed, 50 insertions(+), 55 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>
