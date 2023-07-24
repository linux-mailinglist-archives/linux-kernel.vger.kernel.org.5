Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2A75EF22
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGXJbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGXJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:31:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F0DF3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:31:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R8ZYY3Hz7z6GD5M;
        Mon, 24 Jul 2023 17:26:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 10:31:12 +0100
Date:   Mon, 24 Jul 2023 10:31:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Tanmay Jagdale <tanmay@marvell.com>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <gcherian@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>
Subject: Re: [RESEND PATCH 0/4] Add support for SMMU ECMDQ
Message-ID: <20230724103111.0000131d@Huawei.com>
In-Reply-To: <20230721063513.33431-1-tanmay@marvell.com>
References: <20230721063513.33431-1-tanmay@marvell.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 02:35:09 -0400
Tanmay Jagdale <tanmay@marvell.com> wrote:

> Resending the patches by Zhen Lei <thunder.leizhen@huawei.com> that add
> support for SMMU's ECMDQ feature.
> 
> I have tested these patches on Marvell SoC that has the ECMDQ feature.

Hi Tammay,

If sending someone else's series you are 'handling' the patches, so should
add your own SoB after the original author's one.  Also, given you've tested them, a
Tested-by tag would make sense.

Any perf numbers you can share would also help push this forwards by showing
why people care.  I believe Leizhen's numbers were emulation based, so
not as good as real hardware for making the justification for the added
complexity!

Jonathan


> 
> Zhen Lei (4):
>   iommu/arm-smmu-v3: Add support for ECMDQ register mode
>   iommu/arm-smmu-v3: Ensure that a set of associated commands are
>     inserted in the same ECMDQ
>   iommu/arm-smmu-v3: Add arm_smmu_ecmdq_issue_cmdlist() for non-shared
>     ECMDQ
>   iommu/arm-smmu-v3: Add support for less than one ECMDQ per core
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 419 +++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  37 ++
>  2 files changed, 448 insertions(+), 8 deletions(-)
> 

