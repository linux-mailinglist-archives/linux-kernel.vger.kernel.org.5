Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BBA77CA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbjHOJck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjHOJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:31:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06D3A9A;
        Tue, 15 Aug 2023 02:30:37 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQ5Z45002z1GDXV;
        Tue, 15 Aug 2023 17:29:16 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 17:30:35 +0800
Subject: Re: [PATCH 03/10] scsi: libsas: Delete enum sas_phy_type
To:     John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dlemoal@kernel.org>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-4-john.g.garry@oracle.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <24bd3262-add2-6bde-44e9-0d1d7894b8bc@huawei.com>
Date:   Tue, 15 Aug 2023 17:30:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230814141022.36875-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
> enum sas_phy_type is used for asd_sas_phy.type, which is only ever set,
> so delete this member and the enum.
> 
> Signed-off-by: John Garry<john.g.garry@oracle.com>
> ---
>   drivers/scsi/aic94xx/aic94xx_hwi.c    | 1 -
>   drivers/scsi/hisi_sas/hisi_sas_main.c | 1 -
>   drivers/scsi/isci/phy.c               | 1 -
>   drivers/scsi/mvsas/mv_init.c          | 1 -
>   drivers/scsi/pm8001/pm8001_init.c     | 1 -
>   include/scsi/libsas.h                 | 6 ------
>   6 files changed, 11 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>
