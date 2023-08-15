Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3FE77CA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbjHOJ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjHOJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:27:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077F5113;
        Tue, 15 Aug 2023 02:27:48 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQ5Sx5RX0zFqdC;
        Tue, 15 Aug 2023 17:24:49 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 17:27:45 +0800
Subject: Re: [PATCH 01/10] scsi: libsas: Delete sas_ha_struct.lldd_module
To:     John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dlemoal@kernel.org>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-2-john.g.garry@oracle.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <286d4e9a-8eea-74c0-926d-ace968cfa435@huawei.com>
Date:   Tue, 15 Aug 2023 17:27:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230814141022.36875-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/14 22:10, John Garry wrote:
> Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
> driver"), sas_ha_struct.lldd_module has only ever been set, so remove it.
> 
> Struct scsi_host_template already has a reference to the LLD driver
> module as to stop the driver being removed unexpectedly.
> 
> Signed-off-by: John Garry<john.g.garry@oracle.com>
> ---
>   drivers/scsi/aic94xx/aic94xx_init.c    | 1 -
>   drivers/scsi/hisi_sas/hisi_sas_main.c  | 1 -
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1 -
>   drivers/scsi/isci/init.c               | 1 -
>   drivers/scsi/mvsas/mv_init.c           | 1 -
>   drivers/scsi/pm8001/pm8001_init.c      | 1 -
>   include/scsi/libsas.h                  | 1 -
>   7 files changed, 7 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>
