Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C6275772A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGRI4Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 04:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGRI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:56:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AFAFA;
        Tue, 18 Jul 2023 01:56:21 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R4t7N6L92zVjfM;
        Tue, 18 Jul 2023 16:54:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 16:56:18 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.027;
 Tue, 18 Jul 2023 09:56:16 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>
CC:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "alikernel-developer@linux.alibaba.com" 
        <alikernel-developer@linux.alibaba.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: RE: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
Thread-Topic: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
Thread-Index: AQHZuKLr8euEVepDckqwBEutSR/J0q+/F3qAgAAhwnA=
Date:   Tue, 18 Jul 2023 08:56:16 +0000
Message-ID: <597f481b0e5149dabe4821ca618af6b3@huawei.com>
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <ZLZEq0QBBW4rcxJM@lpieralisi>
In-Reply-To: <ZLZEq0QBBW4rcxJM@lpieralisi>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lpieralisi@kernel.org]
> Sent: 18 July 2023 08:52
> To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Cc: Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> sudeep.holla@arm.com; rafael@kernel.org; linux-acpi@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> baolin.wang@linux.alibaba.com; alikernel-developer@linux.alibaba.com;
> will@kernel.org; catalin.marinas@arm.com; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
> iort_node_get_rmr_info()
> 
> [+Catalin, Will, Shameer]
> 
> On Mon, Jul 17, 2023 at 07:33:45PM +0800, Guanghui Feng wrote:
> > According to the ARM IORT specifications DEN 0049 issue E,
> > the "Number of IDs" field in the ID mapping format reports
> > the number of IDs in the mapping range minus one.
> >
> > In iort_node_get_rmr_info(), we erroneously skip ID mappings
> > whose "Number of IDs" equal to 0, resulting in valid mapping
> > nodes with a single ID to map being skipped, which is wrong.
> >
> > Fix iort_node_get_rmr_info() by removing the bogus id_count
> > check.
> >
> > Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR
> reserved regions")
> > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > ---
> >  drivers/acpi/arm64/iort.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 3631230..56d8873 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -1007,9 +1007,6 @@ static void iort_node_get_rmr_info(struct
> acpi_iort_node *node,
> >  	for (i = 0; i < node->mapping_count; i++, map++) {
> >  		struct acpi_iort_node *parent;
> >
> > -		if (!map->id_count)
> > -			continue;
> > -
> >  		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> >  				      map->output_reference);
> >  		if (parent != iommu)
> 
> Shameer, I know this may look like overkill since the hunk we are
> removing is buggy but can you please test this patch on platforms
> with RMR to make sure we are not triggering regressions by removing 
> it (by the specs that's what should be done but current firmware
> is always something to reckon with) ?

Yes, that is a valid fix. Unlikely it will be a problem. Anyway, I have requested
Hanjun to help with the testing as I don't have a test setup with me now.

Hanjun, please help.

Thanks,
Shameer 
