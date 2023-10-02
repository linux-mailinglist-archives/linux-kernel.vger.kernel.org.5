Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562AC7B5B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbjJBTgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjJBTgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:36:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE95A9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRqRF+br3S4nQE48hv/JO6p3EM+SHr09ojY5D1JosuWDAWKNJ1bHrLA1XnIVmQT/uVSddGVTLY1wPS0q4L4jVQfvyZu8HYfMlA/SqHnPLUUk3celEUd5xq+mMFlSTI6x5i2uESDMb/8dk8XEDFHbZ9D0H81hnwMXSXzfDcjtowzuxlN7IyUhOTEU3gwd8NzENroJUKhbVWxtoQzNZdwKn8H0gussyTeKJgC6qMz/esXM3YlUYjSJyjWG0484b9kUVBYycMBKhIxFJ+rEpWpH0Ybag3bp9mD/MYxnxHcyocGKZofmzQFdg/RSibJROxtRecSw/qLeDW4pLxK4URfx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4mr54O4TnA1H0/uR+xUO2Hs8GCumrOGRb4t2eO7qvg=;
 b=hO4ipsTKBxyEWRf1cddwJv7XUFBuPMKyJP8nmisX5GnkExiXkz+bQBNaRQ+UorD8DPBMg5ajMxPLYEzwGU6v5PLsK8STrO4itjNl8WbFeBIRGeDRjPYQbp0J/O9jn2e5+vdPjFZfuZIZMMf5bHqtPTqlg+22o1nyLUuEBNYz59E7WBxnv8vHncX7Gm1tcu45tjGPhXCTyaoo9a6GgrcJCRCNjHGI9awtX+WS4yv+/LE9UvpZhxGivDJmt2lp4WQt6S1DMfS1eculfU072afSti2gmZrphUlCxVmk15NQC+8a9N7SO4J+/TuQS6eucVDWXfC1POq0FCXxy7ZS47ahTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4mr54O4TnA1H0/uR+xUO2Hs8GCumrOGRb4t2eO7qvg=;
 b=bADBT6D43sCzLrDlTHswoqcmoibIiHHv736csPqPwUejYNuOzGjSQbkj3SwWmR9r/wc9NyEZWGgbXaU7vakSpT8kmfAoILwWlHen+1S91rfvyS75921lPPYh3/XE5KW4AVMvpvV3P6l6dwRxynnzAwWYMbu0+sZyAVU10bRCG4zFoJ3pM6jlg1Z6p6EJoJtKg+Bov6qgwYMDk6yHjjuyF0yf0HXTtwzssvShI/B+ESmYfuYNMDjd/8U9+Pl7+Yn1XlSqnepJcMTBrC+SpH0Ddk/H57BeGPWRscF+IxfzAavXcUvf3wh3dcGqEwSYVjsuoLSAvC0FziNXYNrY+pKx6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 2 Oct
 2023 19:36:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 19:36:14 +0000
Date:   Mon, 2 Oct 2023 16:36:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] iommu: Switch __iommu_domain_alloc() to device ops
Message-ID: <20231002193609.GB650762@nvidia.com>
References: <cover.1696253096.git.robin.murphy@arm.com>
 <458dd0ed839541693a49da33239b33cf4c48b8ec.1696253096.git.robin.murphy@arm.com>
 <20231002141615.GA650249@nvidia.com>
 <a4078085-4061-2b52-daba-1cd642f0cf9d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4078085-4061-2b52-daba-1cd642f0cf9d@arm.com>
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d7bf02-f2c9-4741-ef33-08dbc37ed6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TrOEmKiv6JsUszInJv8zIyoqOhpvqIX+yDkToPc+j5hM6SMgAwtWzgr4SJQBtuFH7YylX/CXmSAQkro3Gd2SFZf793lW+C2QvfCU0z0Gri6BCAqO4tUbTAjfM5W+t5ak6K2ak1iXX0pK6pcHloSDmGyecpASaCnvKHIBPm2c6aaK9UIr668rNfisevIj3B6g0fjdu/g+EvfXxrMCqtklIm7AyheH2rdGzTUZRCs0x9rgMSHETLNsA7S/nmVi1HVQvjyL0vVmQ/VU3NXrusuvZfgfLWQgo6iJPyk/vV8kXJ5n/9uTDeMsBXkZXGy8YsRkQyrSlcbFJTvaxH5Pvwh3abgklAS+U2Dnx7/lNCAtjsnQfwHMH868kO3BaRwimQ59A+Jre6MyQep4ZKmGHJe30RAZoQuJiTnJiCmw67DGm7ApBR4TULRKTTVKrrtd7BXv0tcu0PVCTFw5/Jy2FxvCjcPAxFkHQkXAHmGPe70bEjM6C4nA1YCTHfZLo4frmwS38732XvJ02szO+O6GGPnw4K/zVYhbP43qSxgZ95KLN7u8i6HOWyCXg5LAHo5V/TR+/dp7d5DEgz7phKm/K5vfd4/A0tCGBJgUoi0B1/5Ma4cgQ4UMibzscnJtpM0Ej+f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38100700002)(41300700001)(4326008)(316002)(8936002)(478600001)(6916009)(33656002)(2616005)(26005)(2906002)(86362001)(8676002)(36756003)(5660300002)(1076003)(66946007)(53546011)(83380400001)(6506007)(6512007)(66476007)(66556008)(6486002)(6666004)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqCvCscCkf35hOTEMg20AWbBwz48AoopM4aATq3dH+RtkQhtNj6Ak3y1VA/D?=
 =?us-ascii?Q?heXGj063aXD5e7u3NyqpmTcLywHq4LNvzELIZnD0m1cDdVirkm9SrA18latd?=
 =?us-ascii?Q?sXZZTK9ADQtm4vCCrVE4YvH85KJ18s8ycxDgY39mxdsf08ZVh49Sj58qTt7M?=
 =?us-ascii?Q?39ElfVtOYq8nC8NbsuNetqpKw0O95QhpXFc8fHBTjMT5RkE6exX1mdE6ICwB?=
 =?us-ascii?Q?wwDUYP3HLRbNORU4PR93aznfvMU4vE86JU8ta2AYjQ4cZMaX55fdz0Ih62tq?=
 =?us-ascii?Q?u/qhr0EKKknzp7NiQZlpnEclaXHwMGj8FSwpfrZd92VjoJ8BwwPgEiZbXeRB?=
 =?us-ascii?Q?PcXasEW2aPdp3hqBmtFP9p2sX8ifRzlAIZKjErUnEUxhS2JvJEZ4BealHi45?=
 =?us-ascii?Q?gR6titAatoc7e0fWazodZ2dxQqp0SVwunBdkDSZgSVXTN40pxfEWBdstP9qN?=
 =?us-ascii?Q?gE+6/T56qMg06EZAPaZQ2Wrr4kYpOPedBxTR2IH0J4Z4p4wNyOeOHOgL34Yy?=
 =?us-ascii?Q?Q6w8DsRbT7AFusoFQ7U4jal6fG9ljKxln42cb/y/p/8jNPJlSOCh1wYVUo/f?=
 =?us-ascii?Q?yezGAuOJhZQirO7ANMY6TgZ2Np2otnfywugPqTUCQ+X2UWDz0rZHz/TXzXA0?=
 =?us-ascii?Q?h8FufPin1paWGM1vQrFLh3InmomUPt8Zx5DcifRyeR9czfrxjigC3624+/v3?=
 =?us-ascii?Q?MNTzTFJWqT0+W28Qqoa8A2VR+OE/bGhnFf5c+CPfueweKN5ijb5b+PiswpAB?=
 =?us-ascii?Q?35gR2q/FuhL4QAr9BD2kAgl4jUhwMnkN0CNhE2IsqRMgWhXEzfMgvJDjfSZf?=
 =?us-ascii?Q?F28rzzag9XVxbnPP17Ta3DdIWrxnDOQc/VsRWNhYWid4GqfC1k/YtvTIYB9Q?=
 =?us-ascii?Q?7vCKRAiYixYvX7DX151RIj1vA9Oy1pxraBGdqfzEu0v64MZwp5u5Z/PxouTe?=
 =?us-ascii?Q?ksB9oGVZWmjCvRaWies87dSoNTAl8Kt26KfndpiyPYtfehIlzAD9XaxpUTN4?=
 =?us-ascii?Q?LU/9rKQQGKifI7GVFUGuHYy0WFvZWIvwKpV57OdVsKIz1Rio8cEUTujOrKDr?=
 =?us-ascii?Q?GDwDzSwSAFx1pyDpANg8d/MR01PyoRiALVTYk0kzhRks6omlSk4itlytfPip?=
 =?us-ascii?Q?SQPemGbJYndSBk1b/C4Gb6GaXFVs1SqLmB5prpPk0TOZQoJ+UEnAtwrYhiIs?=
 =?us-ascii?Q?Z4vXSAdOkoyhEVH9bPeP4SqhhOwIjZhZ1XKmoYmbXRxQyIrix2s8Cn54k8BR?=
 =?us-ascii?Q?HXFMYd7JuPbxWbMNrnTXPD4YB3MKIgUwXtaALSk1jE5Ho1+5e6v5qCRe9VlP?=
 =?us-ascii?Q?17AY0e7fpjEzGxUH9FCY2PsodotNLAsy4/Nw2yStVUofhm2lwJRms2UeBKEl?=
 =?us-ascii?Q?OWRQ5s3diSVukAeEJkZ7CuoWqAxpGuUID1/Clvy1ZeL5Ni3NlN+AXNuhMdxy?=
 =?us-ascii?Q?20HtHJcCs2UjQkslJXqdFZN2vSLyyZa5BBa4HM4UeZ4ovbjX8tOO5pZwq/M7?=
 =?us-ascii?Q?/Lc5ZVOPPbxPfeo1MGQy3yZuCJID26nNhwGd9hWr/PoVpK8vvPu/HXcKRdSM?=
 =?us-ascii?Q?GJZBYaqIejGG9SS6J0p46wKay6knqewe0vRX/8WV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d7bf02-f2c9-4741-ef33-08dbc37ed6f0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 19:36:14.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taDoxQbX5iooRjChItFpkH7kr9mWwk8LK06bv00cHe3U1MfrhiN+o61OOQsgAjim
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 08:02:23PM +0100, Robin Murphy wrote:
> On 02/10/2023 3:16 pm, Jason Gunthorpe wrote:
> > On Mon, Oct 02, 2023 at 02:49:12PM +0100, Robin Murphy wrote:
> > > @@ -2120,20 +2120,30 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
> > >   	return domain;
> > >   }
> > > -static struct iommu_domain *
> > > -__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
> > > +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
> > >   {
> > 
> > Why?
> 
> Because out of 3 callsites, two were in a context which now needed to
> make the iommu_group_first_dev() call itself anyway,

I don't see it. Why not just do this?

static int __iommu_domain_alloc_dev(struct device *dev, void *data)
{
	/* FIXME: This is not correctly locked */
	struct iommu_group *group = iommu_group_get(dev);
	struct group **alloc_group = data;

	if (!group)
		return 0;

	mutex_lock(&group->mutex);
	/* Theoretically we could have raced against release */
	if (list_empty(&group->devices)) {
		mutex_unlock(&group->mutex);
		iommu_group_put(group);
		return 0;
	}

	*alloc_group = group;
	return 1;
}

struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
{
	struct iommu_group *alloc_group;
	struct iommu_domain *dom;

	/* Only one driver is supported with this interface */
	if (WARN_ON(iommu_num_drivers > 1))
		return NULL;

	bus_for_each_dev(bus, NULL, &alloc_group, __iommu_domain_alloc_dev);
	if (!alloc_group)
		return NULL;
	dom = __iommu_group_domain_alloc(alloc_group, IOMMU_DOMAIN_UNMANAGED);
	mutex_unlock(&alloc_group->mutex);
	iommu_group_put(alloc_group);
	return dom;
}
EXPORT_SYMBOL_GPL(iommu_domain_alloc);

(and ++/-- iommu_num_drivers in iommu_device_register)

One patch, it's pretty easy???

> Um... Good? I mean in 3/4 cases it's literally the exact same code just
> factored out again, while the one I've added picks some arbitrary device
> in a different way.

Sure, but the whole point was to make it obvious that there was no
direct linkage from the various dev parameters we have in places and
what dev will be passed by the driver. Everything passes through
__iommu_group_domain_alloc() and at the end of the day that should be
the only allocation API.

Jason
