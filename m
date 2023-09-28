Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B7B7B16BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjI1I5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjI1I5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:57:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2054.outbound.protection.outlook.com [40.92.98.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533EBAC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzRJiyPr2/6RxInOQWvH+MPr1Ku5nxBLyQZIJK9G5tusW3qvdcflRTr7zTIiLodRpC0ralYN8fBmA2Kwb1UBfx3B8KdQUfD4g1PdEq8e85PgwRSyqkwha1Gqqt5QfnM8XKMY7KRsbdy0IAWXcDf9+sih46L59vRctfQlBNcOpzU9REF2C8RLfNLAlbbwv+9UkWT1JbxP8C60ihpFZvtOy1EOT1FNMs3TN97NXg9q3exQz2VDh8IjT7YOwT6Fd/tfMJAvlnYssI/IQgr30GyNB8uR0m3J7IuEBoXDbm9yK8KUe/BsjYEpuhHvUJe0nSWpn0wYm2oiRVcT3QCWq2FGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRrzZtzDlpyt8syrS8a5cC50D4ragwSFhBiAG44r1N8=;
 b=aAXqlo2C6N0KsQOV2Fl7GeBBIpoz/4pdihEitbKJmH/nCNkREGGpC3lYulbz6Ef/sv6W5lDR9uC3err1zvY7r/mrR+JdOaqNcStXvIA7FbQK0g3n3Fn9p8CItltOB3Rdea0tXJLUkv7FwAm1CJtObNOXP4CI37cCRAickD1j7mPwsiT6hZTiX/vW2EQrVGPsJ/ze37TLLpOSKjMaXTE9ig2jV91zZRYVjGPDyiKspUP9ShVztFkkGK/XNwpdAL1tIaNg3sM0PEOZHnk4Pjzx/1+NO3fWmiNUiUVY5tQixAh30EU1OvBDErKSXt4D2R4QQ11ftUL/ai+PH584M7aXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRrzZtzDlpyt8syrS8a5cC50D4ragwSFhBiAG44r1N8=;
 b=I9Jqnqphjgybw6f2Jv7CMqjAVtxevg35YqULveIY8rw0cWpVxrB7FJ1pIW5P0eBXSQ//EuF6Vkag8SZSsl71PFxCXjahEYPvi2l96MVhVZN4YfFcFGixc71dkieiJI4OpCrzNO1MeRv+LRa+6P6BnnEblURyg4IlqCIcaRs1ohD9wT+EprGbrq9CitnAyZTDDxUEElFxKTkUF+YIr7d2cnYTghBheRbKLqwJkWDz1vLazmm+0LolUuz7ETvalbpRt/fpiPg5/DXTooROCZ/1V8ywDS4imt4oiduMbplhd02EHmNk+YpmYy7ybrDSOA6O5EGoY/iyRxE6OraMjKoufw==
Received: from TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39d::8)
 by TYCP286MB2336.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:18c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19; Thu, 28 Sep
 2023 08:57:40 +0000
Received: from TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ee22:5eba:da74:7c25]) by TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ee22:5eba:da74:7c25%7]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 08:57:39 +0000
Date:   Thu, 28 Sep 2023 16:57:37 +0800
From:   Dawei Li <set_pte_at@outlook.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Sanity check on param list for
 iommu_get_resv_regions
Message-ID: <TYTP286MB3564BA78F5ED7E8FE4DEEE93CAC1A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
References: <TYTP286MB35645FDEF45FDFC91D35CE1ECAC2A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
 <7c7b8981-022c-2fa8-7ee5-9c97d8e17862@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c7b8981-022c-2fa8-7ee5-9c97d8e17862@linux.intel.com>
X-TMN:  [05TS865N56rjqv0pOy1IOsKqe36mAQI8]
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:39d::8)
X-Microsoft-Original-Message-ID: <20230928085737.GA28301@wendao-VirtualBox>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYTP286MB3564:EE_|TYCP286MB2336:EE_
X-MS-Office365-Filtering-Correlation-Id: 48eff0ce-16eb-4755-de5f-08dbc000f7d9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWMDtepiKjZV8JcZ8KkEkhfU6rLRiFkbShnSJzMVgRXjkd6FGK52itr/NDCHSw9uF3QS0DRpR8biJLZmvBVlJ1Ao3O7XTALPYxO7b7OqtdASCbhjt7MaFZFxXGaCMIelXbrolePfPZMg86cUavakyOwBLfBuXKLRWttqdZoIF0OjT2dHqm6QBvSAwaU4iRBJTB3waq7vkGci6eMhoBYZwzAMGEavfj8vpVhhmXNKrd2g8QG3S5W0ZWlBRuPYTNAevWoTGu+tXe+A8UV/caDCvUSql1CDtpfNOqDXBfiODLYxQxIu+3y1JQSUUSAsxTkbrK/YsPoPuM2hAf6uKwAbhcSEmIcQ5CPcn9IBD9DGItgr8ECjS9Ayra/4VWi3CAdax7MCqTl2gHoPwwj8qWI6c6qIH0aBdfGhAUyigMs1auJD5iNgja/rWSYaQZw1Jo7uyEr1N6bAjrzh2K8itYcxjuKkVIiIdWOhL1KFYcU+28LZcm3e8WlBLN+VfndZf5mR43cXw2nZ2iRBY3QoXtzibkIuuEbTlFA3/3DVJGFQG4pHCSehev+tIWDpAes8Vv6C
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WQgsJIBU+oJXXGJDEbKjLzN71CtnO1WK7bVc6gXToBYo4obsmT+xreZM9JHf?=
 =?us-ascii?Q?zo1VYodvH6hGAQ3XYitRwB0aifj1gKzdkPU0WTQk/y0abm6u5+QOZ1t5w8EV?=
 =?us-ascii?Q?LkWJPDDJBMPSpFQX9mnUw2lkG+kHoBaGC+LAbr4zIvXBPPcYoHo/pul++EXY?=
 =?us-ascii?Q?Rko2V580Thya37fDpc36F/CnP5aRSCXmX2RFKXLzP5+/z4hK+DmhEfdKgUJ6?=
 =?us-ascii?Q?ecnqwS+N6DkpH4SpdmKHm6ZgjiTo2Fny+w8aR1fg+NDkxjuecLiMB2AU5j5S?=
 =?us-ascii?Q?7luO+TIlWSHyOYI3OT6M88BEW7VQEf/tAaU0m81qCIqh0YEhhtsh3yBhiFQN?=
 =?us-ascii?Q?/oG6SRC8RQMMoYMG4LphIgFpYUPffvodjP6cBquuGQLHFt2RHfixxzEVu4Pb?=
 =?us-ascii?Q?+FjBdKbtpX4h+CGgVdinR5nEUZcN+4nBmYZSbmV5lPF7NEyDHRgINlfG3Pp4?=
 =?us-ascii?Q?h4PSsieoWvoky8tieMf4372rDNRTx/MJKmoGvpa3kS5u6HzfJH3DtwKZCTy2?=
 =?us-ascii?Q?FMC8RSuKMC/qvVdVBLLsG7dcbGTW055pHY6oPNx7yvsVOeKeTusSW0nrVYd3?=
 =?us-ascii?Q?m8CPhn2PWgNzJ9f/bYihwR1coyclLcyEI43fpWwyXKWewdb0+qbYpEZgp3dO?=
 =?us-ascii?Q?oeQ11k9X8UhjEvWqOZ7J1T4K1TmOFcaJqTAT40hOKeyY4bo0tskcup2iz+xN?=
 =?us-ascii?Q?Q5GbW21AKK5z84EIVRKEbzOF/JLIZdY24Zaq8PJazQo5sQEu6AyZ9ahPoUoq?=
 =?us-ascii?Q?t1rZUJzx8jrmmwxuKfjYpwM7VeTz6EMx6Z0laPd/ahjCciTTYc0BldKXdzC9?=
 =?us-ascii?Q?yUACYCHBZSeCj+F/qe7CsUr4qcYXjy7+WVO5l6OX58pfaUYMji+l41ldcZ2G?=
 =?us-ascii?Q?AqBo1f97/ggdDaATGw12jqeFKdWbE+GqUVV+1L5xDzm1WacNfm7cbFXlxGs5?=
 =?us-ascii?Q?IjciDKAAh8KDj6WXrP4pTXZlc4Ec269sHK/3BpXWhS2fjyD0bPHVmBWUbHuO?=
 =?us-ascii?Q?Y+HGKDiqcuZ6Sr2AnUqYSimC75torHpr7SSRmIr+iZITAfe80YW75eHXVmAM?=
 =?us-ascii?Q?uvDyisOGGlYlegTX8ZQ1VQrkt2BTIxJBqH11Vt3xj022+jQ7UhCIIjh9wdef?=
 =?us-ascii?Q?UEWXw5WW/LYbSg9TEn143h5UIt1TWVp4CxeYvRNgwXHsBL1rXRR2S/N/lMKO?=
 =?us-ascii?Q?jUSjze5wU0e7QoeKaHhtSrqHFRz9EmyNnDjI6Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48eff0ce-16eb-4755-de5f-08dbc000f7d9
X-MS-Exchange-CrossTenant-AuthSource: TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:57:39.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2336
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for reviewing,

On Thu, Sep 28, 2023 at 09:33:29AM +0800, Baolu Lu wrote:
> On 9/27/23 10:25 PM, Dawei Li wrote:
> > In iommu_get_resv_regions(), param list is an argument supplied by caller,
> > into which callee is supposed to insert resv regions.
> > 
> > In other words, this 'list' argument is expected to be an empty list,
> > so make an explicit annotation on it.
> > 
> > Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> > ---
> >   drivers/iommu/iommu.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 1ecac2b5c54f..a01c4a7a9d19 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -813,7 +813,7 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
> >   	mutex_lock(&group->mutex);
> >   	for_each_group_device(group, device) {
> > -		struct list_head dev_resv_regions;
> > +		LIST_HEAD(dev_resv_regions);
> >   		/*
> >   		 * Non-API groups still expose reserved_regions in sysfs,
> > @@ -822,7 +822,6 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
> >   		if (!device->dev->iommu)
> >   			break;
> > -		INIT_LIST_HEAD(&dev_resv_regions);
> >   		iommu_get_resv_regions(device->dev, &dev_resv_regions);
> >   		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
> >   		iommu_put_resv_regions(device->dev, &dev_resv_regions);
> > @@ -1061,12 +1060,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
> >   					       struct device *dev)
> >   {
> >   	struct iommu_resv_region *entry;
> > -	struct list_head mappings;
> >   	unsigned long pg_size;
> > +	LIST_HEAD(mappings);
> >   	int ret = 0;
> >   	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
> > -	INIT_LIST_HEAD(&mappings);
> >   	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
> >   		return -EINVAL;
> > @@ -2813,6 +2811,9 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
> >   {
> >   	const struct iommu_ops *ops = dev_iommu_ops(dev);
> > +	if (WARN_ON(!list_empty(list)))
> > +		return;
> 
> I don't understand why the input list *must* be empty. This interface

Because @list is an output-only argument, which is supposed to be filled                                                                                                       
by caller(inserting elements into it). If it's not empty, it's an inputing                                                                                                     
argument, in which case caller will take existing node (in @list) into account,
and insert new nodes before/after them.                                                                                                                                            
Please lemme put it another way, if list argment is not empty:                                                                                                                 

Before calling:                                                                                                                                                                
list: head->A                                                                                                                                                                  

After calling                                                                                                                                                                  
list: head->A->B->C                                                                                                                                                            

It will confuse caller cuz it can't tell whether A is a valid returned
by callee.

> has already been exported, so please update the comment to explain this
> new requirement.
> 
> > +
> >   	if (ops->get_resv_regions)
> >   		ops->get_resv_regions(dev, list);
> >   }
> 
> Best regards,
> baolu
