Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98E7792D55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjIESXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjIESXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:23:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D09F4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXwxyvusqyXUlNNCcAMp+PzU6JD1GpQ7s/8fXmrnA5+qdsbhVNLHVa7cKcH0aeaWeu1blYZZiMhzKot/9cg19K2gVHvcxBW5UxBQV8CU0eUqYZ+UPEUUFVKQQ9iMP6ZC6/IBPexw2x3ejz/bCuj8Rp5zKOwgSS+ppVb4RjRYID/+UNYe5+L0HTZUQMvy2/PmrclT88Plfs70Q6Ipfr7swNUipbmYx6z5fV+3hlbH+144ninX3kn9+zoOMtuO6bpDmEtecrb0U4t4NgBwLaJ2H8ZUWyfIssMbl0xlHOTVIBt+8rKZv57sIhE41/QmWspbjWfSXy8x5OjtcU68iCB7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vvV8wm1vSKHz99xVamWmW8KiztyvbWddvhV6iD2t9o=;
 b=Z9+p1e/tz+bNVqL6NgEmuvHz3+SrT739Wzw0XLYLNtqseH0QMXzPAhivZ1pEkMAmIRNIA1VW/uAZE/bo3B670TrIgRNlKZ0HBxv1uLyMOUf7rik9hmIni0IsNoHq+C8AVMMyruoo9Jntw2g2d/eM0DBptsehBEqcrsFQEV0XIXcBW/HO3HTAeMtLZJsHkMzV48+1t8CnQulg/ie2S+IFb4+jFfuoH7NWxBmTZ+vc31beIfFw04j2x5XHLRelDwXuehOnaSGar+6Mvs74Jrw9lDB0Mvz3cvThxiw4oZAVHrx6aDgfkendvngt501aqw3cvENkVZkFBZditkpSdWJ/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vvV8wm1vSKHz99xVamWmW8KiztyvbWddvhV6iD2t9o=;
 b=lQFO15B3Lb2yQMCjWCmNXystsL2uZ63JgM8DTiZy53sT3hiz/DhJ5YsBZ3OLRqyxuyW6d1W4LBt0TbzJvina5Zd4zqk5Y1qT1sv66nVD1UK27f+iimXUZmj25E/fhrwFg5Ds4DsazIegKGo3lun6NuaOghZJaDfVRLGpdGzvjxh3uE0poE516V4wWadfSh4VJ1gQC1almm9e+M/tM5z4MqbXZpvDqrWBhClc3pwrAqLXhgGgIU80Thf83kH1TvlOBHJpfyszxi4tJ4JGEQcfnl5Qnb67EdA+5rk/qWz6xjFHPAT3fqGTaLAyEXLr0zU5ZXl9cZhQos7MN5aamGcNkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:16:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%5]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:16:52 +0000
Date:   Tue, 5 Sep 2023 15:16:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com,
        jean-philippe@linaro.org, tina.zhang@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v1 3/3] iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
Message-ID: <ZPdwkX3Yne0ahWIL@nvidia.com>
References: <20230905115013.1572240-1-mshavit@google.com>
 <20230905194849.v1.3.I211f2ab0ee241f53cdfbc3a8a573f14b8a46fb26@changeid>
 <ZPciLKG2Gi/Biovp@nvidia.com>
 <CAKHBV27=sTW3jXqqCJCPfMFRq=h8_S4JSrSAx61pfWqKrCak0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27=sTW3jXqqCJCPfMFRq=h8_S4JSrSAx61pfWqKrCak0w@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0172.namprd05.prod.outlook.com
 (2603:10b6:a03:339::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 466f5d99-82ad-42b3-2da8-08dbae3c475d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jmug9XN1dsUZsYRV2+cB5HBnXxtU7n1izLb1zrH1GrUKkOGV7KA11Jdvq2O/uHHte3N0PKZszusNuqiTfDktCzFTY70a4A3zqCCfElxAWPatLU3kNicC9c1oVvZdrIOj+opj4PsVIDIhv7FLVvZ2aRYjWp3CGMGMDPERSwYbGHesDGna/+8V+aO0vwDJJQMl7ALblsHFyxRfDagQjz5SdUmnl2+X3ON35zd0qFP8HntiQJVHBgOCm6p5IkPlWsY24RnDdsw5EIZ3K9Df9zNXs/MLgsHJokVMqIUNka2D8qGFlIhsWC+CewRCfOXWvsx7Mba9Fs6GSw7T1SeQJ/B4JhxYejJgusH/DWrwxj9kRHrOvfypCMRj3zAtHzF1mb8YHFpcEzej8BHy7FD+Q45jYDiHOfR1EO5cCnL6F0lxvmJwYT1c6gPNf/yCTlED2Gyq1jhGh9i+lM5L8kwTcQ98iHYo164xECj+7jZ3LoDob2faq6otLyhvPEUMHfXsTuthr5JDp8XuqmPnlsMa/nRjQoH6MyTvWWF/+We8yAYtRmdkV96DLi+PmWr0qVn9/TKa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199024)(1800799009)(186009)(5660300002)(8936002)(2906002)(6916009)(54906003)(36756003)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(7416002)(41300700001)(6506007)(6486002)(26005)(53546011)(6512007)(38100700002)(478600001)(83380400001)(2616005)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW1pQXZOTVhnNCtRR2oveWJnckN4NWxISEhEcUZRc2NxeFpvWHRaQk1BMTNC?=
 =?utf-8?B?SEUvdkNRUUh4LzlROUozS0FlUEwxUWNsTXFZeGpsZUZGTXNmcnVHUlBXUUY5?=
 =?utf-8?B?Si9uUzVXYjFTcXdTQTRxV01GeWthVUdtTkFDRXVoRURZYmQ5ZWdoQllQM3dM?=
 =?utf-8?B?SkVwTzJCTFVlbVY5TTNKQVhLMklSblVHaE9vZkUyL3YwOVRtYVFOaTlpUDN6?=
 =?utf-8?B?WHJBbTEzenlVT0JjM213eE1hbWdRbEV6QjN1T3pmcEVXaWlrNUdkd2dKd05t?=
 =?utf-8?B?dzQybnp0Z3FsR0U4QUt2Y0hSVzVpbytUZGhJWjhxS3JkbUpZaytVMTBBTzM5?=
 =?utf-8?B?SGJwTzVFaERKVHczWXpYdk56OG9zaEU4VCtlTE1WaHU4L3lldk9ZUHZjZXgr?=
 =?utf-8?B?NWdzNEJYSU9kK0JaSUpTT0JNQkR3NDV4T0ZXVlFkODVJam1sem9ySXZHckVK?=
 =?utf-8?B?cHVvYmxMNXUyQmE2S3JXdFh0WGpsTUJPM0dsMWFXN25DWXJGOWUxU0xIdHNp?=
 =?utf-8?B?NTZ0Z3ZacmxTRGdPK1NpWGkySnc5K0tyOHlFZFRCTyt3RlZIOGlrUm1PejJ6?=
 =?utf-8?B?dVdPOFhnRU43M2FOemF1RTBmbmp1QUlkalhlblhxczJ2Z05sY1lweDJRMEN6?=
 =?utf-8?B?WlBxU3JoT016RU91dGtUZXVLSlU1bTRGeTQ5SEU1VjZOenBSbUhwVUlkNDZG?=
 =?utf-8?B?ZVYveXVDelpOVmtZZVJDOXh3T2YxZDg0VGN4MU9WaU1FZEg4WGhJNlN3NTd0?=
 =?utf-8?B?a1VJU2hWeDFqQmxEUGt0MlBpeEQ4RmtBVmVkcHdIR1FsNHBUNW9yUjhRZjQr?=
 =?utf-8?B?elRsV1RWeGtqY3VpV0FVT2txSEFQdkNyRXU2SlVkT21nMXFuUWcvcktzeml1?=
 =?utf-8?B?YzBnQ1JSQzJuTTYvRlNJOTdSekRLaDBHdU5kSmVjaHZtY25yMys0RFVGUTEy?=
 =?utf-8?B?Mm4wQXppQ29Mek0vVnJKYm4rcGplbkhDbm1xTTF5aGF6Y25zbWJNdm82N0pr?=
 =?utf-8?B?OEF1aDd0RHpMVWU1aTNtU3krTEtzUGpDdDBMUmpjMmk3RkVEbHl3SkduZXpj?=
 =?utf-8?B?b0pJbS9MZWdUS1E2ZUtndUJrTWRPWVNOUWJSUFRBaUFWSnJKejZFRkxWNXBC?=
 =?utf-8?B?MGdZa2UyVVJLS2FvbGp1UVl2OHBMTkIxVmlrMG1rcjhKcXJ2NzFRM250SkIz?=
 =?utf-8?B?ZmJRR3JCSm5jd2dzZ2RaSm1BajNWQzlYUG1jWE9YZEZkV2kzN0xHYktneVR6?=
 =?utf-8?B?dTBwcjZMMEJxYTlNalJNUkU4Vms1bS8yY0h6Q3NwN0Q1TlVuOGRCWkRxQUJv?=
 =?utf-8?B?N3BmYkxGSzU0b1RmM3NNeFE3RXRMNzRqeFVqbmZwOFpPT1BWMzE0ZDhJUG1K?=
 =?utf-8?B?dkdzMkpML084NEhLUG5qRk5pM1hyK09pL3Z5ZGp0Q0Z5d05YNGFEdkpTNFdT?=
 =?utf-8?B?VXo4T0J0RU9TY0pHa3BQZ1QveHFTSXdWaTAyN2pveXFOS2wycDlwcEJkdXl1?=
 =?utf-8?B?a2VZRVNBOSsweElWNHJIVlRMOUhoMnBJZnROalBubnliUm5wM1J5LzVMVXlX?=
 =?utf-8?B?bFV0N1hZK1VmbG42RU96NnhnVTdXY0o0ZGFiNjByTHl4ZzVUVHpNVitQM3Rn?=
 =?utf-8?B?QkVVcC9mc2RXSnJtNnRzZWtkdWZRT0ZZUjBUUHVlOHVidzNDVCtyVmpSSklw?=
 =?utf-8?B?dHh5VDc1eUZDRUdoOTFjMWhVL1dyNGFFSUkwMkZSNE80eG1BNDkrcWg5dkxn?=
 =?utf-8?B?OGVxdEYvRVNyUVJ3R1dRUDFwdHN4eGl2NjNaL0dqWGtzR0I3U1F5SnhYalM4?=
 =?utf-8?B?ZnFJTUFXT0VDK1RweU5jL2tVTnBJUG5Wc2xsVGZnUVhuRVlEbVZZRVhlZlVj?=
 =?utf-8?B?UTBua0plMnhFcnFBeElUOW92OC9uMnM3dHB1ODVod3FmTHRQdFo5dUV3UGpn?=
 =?utf-8?B?RDBnbU9oVFQ4d0FQTmFOaEdCbk8yWHpOa1hrNklvZ1dVcEtud1FuYSt5bEJ4?=
 =?utf-8?B?TDlEb1lIVDJzSm1rTURvekVud3NqdzArSHFyeWdhZCtheGJHRUZkY3lTTVBN?=
 =?utf-8?B?dTc2aVZ1a3Mwa0o3NktpSGMxUGpIV2hmM1NqOHBoNkNYczFBWDFRdU5qWVB2?=
 =?utf-8?Q?+uACu59DN/hHQS7kHLCSJauE7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466f5d99-82ad-42b3-2da8-08dbae3c475d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:16:52.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcRotS1h0z2lyWXzsdEJYiJazSX3R1VexMdHbtWjKFQEyy0hiROD01im9zhLDqpz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 09:14:09PM +0800, Michael Shavit wrote:
> On Tue, Sep 5, 2023 at 8:42 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Sep 05, 2023 at 07:49:14PM +0800, Michael Shavit wrote:
> > > Create a new iommu_domain subclass for SVA iommu domains to hold the
> > > data previously stored in the dynamically allocated arm_smmu_bond. Add a
> > > simple count of attached SVA domains to arm_smmu_master to replace the
> > > list of bonds.
> > >
> > > Signed-off-by: Michael Shavit <mshavit@google.com>
> > > ---
> > >
> > >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 70 +++++++------------
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
> > >  3 files changed, 26 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > index 9fb6907c5e7d4..0342c0f35d55a 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > @@ -24,14 +24,13 @@ struct arm_smmu_mmu_notifier {
> > >
> > >  #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
> > >
> > > -struct arm_smmu_bond {
> > > -     struct mm_struct                *mm;
> > > +struct arm_smmu_sva_domain {
> > > +     struct iommu_domain             iommu_domain;
> > >       struct arm_smmu_mmu_notifier    *smmu_mn;
> > > -     struct list_head                list;
> > >  };
> > >
> > > -#define sva_to_bond(handle) \
> > > -     container_of(handle, struct arm_smmu_bond, sva)
> > > +#define to_sva_domain(domain) \
> > > +     container_of(domain, struct arm_smmu_sva_domain, iommu_domain)
> >
> > I'm not sure about this? This seems like a strange direction
> >
> > The SVA domain and a UNMANAGED/PAGING domain should be basically the
> > same thing. Making a sva_domain a completely different type looks like
> > it would stand in the way of that?
> 
> Agreed that's the eventual destination of all these re-works, but the
> stage isn't fully set for that yet. IMO this is a simpler improvement
> to get through for now, and I don't see it being an obstacle in the
> future.

Well, OK, you have the followup patches..

But I don't want to get in a spot where we continue to have "primary
domains" for SVA..

Jason
