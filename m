Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C544D7B9F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjJEOYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjJEOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:23:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7733025733
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 04:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEt+v/fc70NtB2EWglWDS2J2xWWu7z/rxdN5BgtkWB4ye3/T7fTQZIvGdja9QOIA5qC5rtQ7h/mxR5TlGUwm7CQj6myyEyF/0byHiiEf9EhBPa1STEiFKgqqNRILFHsuqSkGqvYhLRwMMF24g6Yo5i848WVTDf04eLsV38pwixvkeNcojghq25j3Kx8G+4gcCP+iwV4th6KRLFLuPINxrZUPeTF+X+bHMNamtzazs7pJPxIoeyR+0KnZMk4VlOVsa8+7DZGekA3c++8CPb22J43gtlCSoc4dL8An52v1DbgeJ/bLHgjGugA6AM3sK6Dse1Ik8Ez3DlkDKOOLSQ1qrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4BNXl3fllD67JGT4Pm23PqmxLD+SCJe6R/Y6fW9wMM=;
 b=ERYm60k0fUwP9ZTWtKBZhk8KvBuk9NRH0XCizWLPaxFf82qPkbULpzDGfBkE3DuttVuf0pc2kYETs8Mmufg1hIRLO+Z3obc7PbGfK0yuQSQDsiKT5yvAFHKalJZilJ4fPOYFErYDIO8xwJ+c/ROt/mjWaDBUZE6o1rNXjRY4HlaGb6MtexlfjndRaFO1JR+iI74mvs/2rfRXspPV6nvqunY6rhgxzC67yV+fv8XTlF4XpfCrmXyFKB7T+yQTt1/L4aGtR0zMSyANWui8d38bLAv4bfWMyM42Khr3H0aGd3Cj8EmU5hWjUouTt/8VUhVkQQfvu/aAEXwNPrK/36+MUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4BNXl3fllD67JGT4Pm23PqmxLD+SCJe6R/Y6fW9wMM=;
 b=PfVxDhW5nGQewThYdyyij6XKh6Za9WrABMnowefYv6KPYg6ZSPapcXVuX2oxRVr44ui33aJ5hubGcXQEyj8T6bW+Kx6SAv2uSZvlHpcEdP7EB1TQKbJ7R2TMpgXuDMx1YiZ//nzZbJj74agGr/H81ZBklt36nK9ZVPB8W8gPGii4zYAA39FZzxKaVHuB/mhuxSVwWZbpx/z9oLLfdKMdyp+TXwVdhdi1ePnoLYp1zmeUfIVFN4+tLxP2qkJa3m8a3Qavsx6pjSUJzGfWDnyych+Weyn2cUITMFZZdoz4drR+CyFVFBmA1qLOPYStuJ0fO6u34//znuw5y9rGrngCCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 11:56:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 11:56:33 +0000
Date:   Thu, 5 Oct 2023 08:56:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, will@kernel.org,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231005115630.GL682044@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR6IZwcFNw55asW0@lpieralisi>
X-ClientProxiedBy: BYAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 919c0aaa-f4a6-4fdf-cd51-08dbc59a1e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiIEC4uvcZ9/thDznSA/O46XxTu6yDBuiytvzLXzlIKUOmPAd7+g/GibAgpAQGpcqOnthkWchssf5Mz9fGOfdijIY+jviMmcVTb2t0wFANEJUB2mcivj0540vxp+HxoqRgWQCUYAwv9B+oEkaSuhWBHUiPtzgeT5N5ZoOnO1SxvwYPYSrkO0cEjNwlMrS//H3C/zauXkcq8s9IgwLmpzkJGWRcIjt2fVQAHnJ9xOB58uZSqhLOMh6ZccaulhCbr124CAhhw7AuHS3pKiPMy5Ci5gVpPOIiiJkpx4xulA6+17R6fKMEbaEc5VH+4x+PnaMdOyWwuDATYyizgWs24y93Nqz60MJsvQsvCyUQZUIgMm0BSgm4OutvxBIkuTeU356OTuZSsleFj+u5UhgcaRgekx1SM9I9KBCPKJ4b2IoBmm2UtPLUq5Xw+bw06iFf9Q6t4FKQzi5baj0PRSRy480t0R6MQAfPsFlpORzeDiX3RGy68+Td7n1FsidVzm6SBh7OXEG+HSKDdUj6ssnFm8707SVnWv29leUrjqV68y96xuo2qgMh21u+ROZmSrzwvD71d8mQTkgJNWoDIzS4YEQJsYpwDJZl/oiZOJ1p3LXazUrCqIEBHt27iR7g0f0Dqi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(4744005)(38100700002)(2906002)(83380400001)(86362001)(33656002)(36756003)(316002)(66946007)(66556008)(6916009)(66476007)(6512007)(6506007)(1076003)(2616005)(41300700001)(6486002)(478600001)(8676002)(4326008)(8936002)(5660300002)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kTgYDXCfd16gXmiMvRyO2WmYoW5n6RqngCB+RzLT/feYBdFiZW5n1IohQYfB?=
 =?us-ascii?Q?4dPW1PLlfmhh7ISXS3X5gnwdVJAxLD8ALlx/LyassOvxeU74KO6Fegva7Uud?=
 =?us-ascii?Q?V10hATiraYLmXblRELvqDIxqYCNX5XhCbpa8F7DOKfJicYP634yNZKK58mYq?=
 =?us-ascii?Q?4bEBw15zQz2xEaaxbGoOYPUBFQWtubqq/9JAnn7GwMPMkh8JCFQcRfKc3pjv?=
 =?us-ascii?Q?Dh2+g3TWJrPvzkNG657xB8gAlLCwB5pXgzwZb8pgQWNrkYns8PoFD1l63L/k?=
 =?us-ascii?Q?Uk84GxNzC9HO2yrM7rJnWKni7DU1evxbaXzIgiZgri8aAfa1PUx82XHQhcgW?=
 =?us-ascii?Q?5NYVLDBAmcItP/4h1N5hja94aOTRr2SUfb/bMaDa+OgZrURxGj55HtYr816t?=
 =?us-ascii?Q?1f4u7jTQyNjkDeTBeAetB/bRKY+ZEYllH0y/2mcLQyNY3YMt8B41XXKkDAjJ?=
 =?us-ascii?Q?2We/AIo4/Lmrvj8F8GRnG+ej9l8SqsfM90lQIxfS36tJFUfX3MpMli2mztxQ?=
 =?us-ascii?Q?KsAV4eqJUtH8UjUUddkopMftH4OhdKaRpMXbxMNhTgVCkGzReKRwCZoRCaQT?=
 =?us-ascii?Q?w1xX7fMZGZYRlPSxEJTIriv2FZMYKCaG7SESxmYtuULYNPX+5wJk6l+2bWF8?=
 =?us-ascii?Q?Yv9mXR8zejrgcupuqzRMnDEY/6Ur4N8U/2Ivg7tGboyIt35Yq67JJQ6L8SxE?=
 =?us-ascii?Q?v84TlmYj0TdvAL3SMUVy0vOkHX9/zZiUQ3H10VhJVz0y6XOSrazMYouyk0LM?=
 =?us-ascii?Q?1DPacv2h5wg2MJNDKpGeT/IDnuAZoMQkPdZmCmFq30+mFREt8MU6I+hGl94B?=
 =?us-ascii?Q?3gMJneDrJlmeFjkHVXDBIJqQPmv2agjIC/hMfDDuKzkb1z0mhxfJSNDjOouY?=
 =?us-ascii?Q?/AJk6duybhnt5ipsxQj9MmLpJc6DiDF60+2UCeKWNiG5kcVKVV23z0ZSA2Di?=
 =?us-ascii?Q?g84+WdQqa8l24VA+5cXkPV5wbn0mncgjRhs2LIW2ax4pe4X6HgWuZZVGNWUN?=
 =?us-ascii?Q?+OOAaiUuyRQvjp8BvSUXt0heNmbHTv0KzYRX0SQD0sZ+Os69OpR6lTpySWyK?=
 =?us-ascii?Q?N5/0xfifj2UXH7ENZCXJN2f76CxKCW59Lx4kFMcF9MDZ9z0OkF1YrhkpI6FA?=
 =?us-ascii?Q?UdRXjA++CoOycoA4stz5WlYtkBIIPmn8kRZNL1ihjXLe2X2kcZIi+zy1NiIT?=
 =?us-ascii?Q?lNec6W3YR93Y0fASjge5XdUmGxZcn6xkb/1+Tz+cQhqWFSs98nbJC6Lw6o89?=
 =?us-ascii?Q?9TRjFbTueRX6/0CdpVSN42aLrz6P05mwfRikYLpfndtoT03Zpx01x7jwoySq?=
 =?us-ascii?Q?7F4XzevwN3dHW8L/C/KqfouQY7GrEkVJzBL+lXu4JRcf/DFfBfnAupZAHELx?=
 =?us-ascii?Q?e8UNN0zFq8H2q5Dt97TzviMpPyK1eyED8/IgHuT/1ZLEjUlF/arTOmswMj52?=
 =?us-ascii?Q?AgAqjCsCBd+tHKWIbgt446YL5jYCpXxSv1BHq2koeIz7OkbiLafK83oaB7CG?=
 =?us-ascii?Q?HnWAhuJYX9CAYGJHg2CkmRpj/7A6SxW/+sfbiOSzyzrzE3sXVTEsKwxJfNDS?=
 =?us-ascii?Q?Q8T6mRCdqKUI3ZK1M0PD3bSNmATw8krHwqDASu2T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919c0aaa-f4a6-4fdf-cd51-08dbc59a1e76
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 11:56:33.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXJ7qb9IhcbfluWdBsfgrPPDzNYtfmF+n5fvsP2H+Pal03+fV+uckfBtkBLWb2Zh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 11:56:55AM +0200, Lorenzo Pieralisi wrote:
> On Tue, Sep 26, 2023 at 02:52:13PM +0100, Catalin Marinas wrote:
> 
> [...]
> 
> > Anyway, the text looks fine to me. Thanks for putting it together
> > Lorenzo.
> 
> Thanks !
> 
> > One thing not mentioned here is that pci-vfio still maps such memory as
> > Device-nGnRnE in user space and relaxing this potentially creates an
> > alias. But such alias is only relevant of both the VMM and the VM try to
> > access the same device which I doubt is a realistic scenario.
> 
> A revised log, FWIW:

What is the plan here, do you want Ankit to resend the series with
this text?

There were no comments on patch 1/2?

Thanks,
Jason
