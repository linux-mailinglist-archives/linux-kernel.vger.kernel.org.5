Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08A76B5E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjHANbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjHANbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:31:10 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCB3199D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtFsCMwkL86id7uY1D9JH6P9T2cuUQ4hhNlI+tVQyZItkbDSLCeHu1v6EzYzkqE2pF9LC6RDdNKPUJjwb9K4VQ3txqUw10JmqwD4+kRQme+m5eCqSiKFqbYNIP+6DxAnGn5t2cY5VkKg6srabumRNsHzjR4G8b095AvvfBVCyhse5JBFSzfezUtk52qWmyyY9AhLpGQjuc57ZsGZOm+5tQIPAMv5tB7dg4Ao14aRwXP7lDekbaYgzHCLO+wRDzJQ48DnU7MoHjtLMZ3fIbDAQdTwBGT/RiPoCQAcGdoG9kzsVtKqTpjEPP0zg64nL6U9pXjzDwNo1MGwTogz5SJ+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKi1mmLa3jWkqGsPaoRrV2+GGpU8ccU6ITyTq/AQhxg=;
 b=hm49FLi4Z5oedgDkmxDxQ8drC5IV7CMHWWIni9vzBuymMDKHozmus6HVcGwxb4d/W+416QRXn5SVv7zLgfoxz4yHTzj5We37caAGquNQ3YtGHvoHa+RJztAuV0LNZI1uJmMadn40AEwOw8tVLIvTKhlJbeA5luFqNHGZ10i90jozd0P6cTXdyu7ul9baHQtAcQNjjTCg5DyAYL1FS7WFhsDfUOQrfF5iizbtvAFUduls5K/LWk4la+pfJokjrr5O+38NQ03/9nFeqa5PDLb75LtkiWyXaLiO1J95omZfd6Wiwfw38g0t8lRUZajtkH4xTkZG6aHxf6SjgA0fHMFZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKi1mmLa3jWkqGsPaoRrV2+GGpU8ccU6ITyTq/AQhxg=;
 b=pIYxTIR6+5pFCgPSLIGYtBQh2R8Ipkzt4s7d1k/ke2hOa8vH2XBmU3o0zPOAFsNKFaBxvaHMplvEBtscsGbUyb0sQAshaAKVY2dRHppwnNSyyr+w9IssBHw5MApDpvv6kEU46XyA5jC0ZsaZ+LVf34Nf8F652DjvWtnOmNluUAk0DrBrv7+t5MFyZLGimFmgmXFSmQxvrYeb8ADH00hK7aufYSXHpJehI6P+CkeiQ341NOdO7egLuiNSN+DOmfD17pH4Tyn5n2xmijgby76TyRuBTILI/cQ85z0eo1qZhqCgC2zxarrZgoOgeWfsKgMsMGBKYdqrKFxZAGCf0d0qVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 13:31:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:31:05 +0000
Date:   Tue, 1 Aug 2023 10:31:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org
Subject: Re: [PATCH v2 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd
 table
Message-ID: <ZMkJFnIHFKxtbvmh@nvidia.com>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
 <ZMiJ9Cg5wfbxMZ+W@Asurada-Nvidia>
 <ZMiPjRtch1c06F5Y@Asurada-Nvidia>
 <CAKHBV26C17_9VrVC0ZESC9FF3TheNifVx8w97ig2qeMFHFfKjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV26C17_9VrVC0ZESC9FF3TheNifVx8w97ig2qeMFHFfKjA@mail.gmail.com>
X-ClientProxiedBy: BY5PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:180::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ae1245-e5f9-4b42-f9c6-08db92938e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MuSJhoJKfcaVxsn1v3lAM77oNeVCehUy+Q7PRBUyc83zS296QumwbxhfV9ZVqIIIZEVP5GrsSU/qwxAuwg+zZOMLsEvdf2l1qEYyz/rSaeC719n+a+Pb2sbiw8oQe+bt/aZ/J0RtWR9Ml8s7eMDu5KvQWpdOdZUYJOXRzejBEp2MEyrh1QwlPTNf6SviCHfHbwHWVRqtq4pIkmusi71+LzuWEg39Svv1ilwsz+OngCw6d+LoYI2P2/cHnIbNOGSdmNakRm41Xfq1Xxz6146AicNVZv6/zA+AApTCKNJ65++GlUwjaReJN6SObwEqcuYEYHSlVSgCZzibmI/ZgTiCHJ2SSnoPunAVS19KoSCUWkJvsgOZRrjht9Xf2PMeXjhIN//7DjMj9Y1oZbdVT35iAYvClsEX5mOChcIFKaQJJTdgVyuLRyOyJdQUngQLrowOxSAV/uh6DkAa/1TnMj7L8+//TULi0FeY4V2lxHsgMHJ5dGs+LTKyPnz0Joq7Yu5kYs1Q1l7/dX9r1Lko7c6gDpWnVWkJJDmZPc/2fpTXZJ4BiG9MWtrcMvUf7QUtu9z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(2616005)(5660300002)(38100700002)(36756003)(2906002)(316002)(26005)(478600001)(4326008)(8676002)(53546011)(186003)(6506007)(8936002)(41300700001)(86362001)(6486002)(6666004)(6512007)(66556008)(66946007)(6916009)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkpJVStmYm80L1ZMUzAzbWFEaXFGV0xWQ29zakhjemNsTUZveXgyZ2JhSWsz?=
 =?utf-8?B?NjY4cXNicW1Bb2FSTnJTUU5PTTdDR2g3a1ltbExGTjMxMldHTVJzNUlocTF6?=
 =?utf-8?B?Z29haWI0M3Z4WGdlT1RLWGhXTU9Ka1QrVVlza2xwTGFyZFJ0R0wvSU13WXR1?=
 =?utf-8?B?UWh4UUgrUWl2UTM3T3lqWjJQbmsyNHRMajl3ejlRcG13R3AzeEc0bms2aW8v?=
 =?utf-8?B?WkpuWU90SEs1MnUxUUNMdHY1L3k1VXB4NysybC9IdVVtZTJDVVp1L2g0dFUv?=
 =?utf-8?B?bnNZQmo4RjBCVERVZUxIWmVGd3VoUWN6Y0J1K2FMdWZENjg0bzFiSk9JeGpq?=
 =?utf-8?B?emdVeVBCU3NaWWVLU3dleGpoSmhUQUVZWlVGcDdFSWhtb2ZmcS95Y056OWds?=
 =?utf-8?B?bmpFT0xFQ081NGZvZFFpaUpWYWx1cHZITWNXd3gxcVZnTGVaNGxXRjk3bGpY?=
 =?utf-8?B?b0NWVi9GZnB5NkZsb05wcFBZYnphUmExdzFvNmswakdWbnU4dElXcGgvN3gw?=
 =?utf-8?B?YmpMUzNVTUZsNDhSS09RSjBLdkg1dHBPaXhGaTU3cXF2d1BETlhCaXRoWVRh?=
 =?utf-8?B?QmZXTXhnZENBblNkbHhibWF3NHpCckF1K0VIR0p2c0pYaHc5emo2WSs5TW90?=
 =?utf-8?B?UmdIRFNrSURoa0E3RnNjY1hvZ1B0WThwai9ZdGVyS2FmLyt1bXVhaFhwdi9m?=
 =?utf-8?B?M3lINEp6a1dIb3U3T0pUcUk0a3Z6RGc1MU8zc0Q5RzRHWlJBb2JpUFIvNnYr?=
 =?utf-8?B?Rk1HNTAzVmNwWHRocVloMEx3M2wyd2pJUmlHR1hPNSszL2hMUFJFTEw2SDE1?=
 =?utf-8?B?ZjBYUlFrQ3d1TTRkdWwwK2I1N2dETlFuY3FsbEk0akNiZVFCU21FRVVSZmd0?=
 =?utf-8?B?aHJjUGt2Qk82NzRBOWdPVERqSHVsQjFhWm5nazJNeFlLWjhtdXlOS1E4YkQ0?=
 =?utf-8?B?MEtoRXBnNUNEVitlR29qalFBYnhRaG1jQWxSZGJ0RXlId3l6Nmx3aHB0ekxV?=
 =?utf-8?B?T1dWYTlUZk1vMEFOR1RBVDNiMWJkckZRakRtendIUW0yQ3ZpZ0svQVZpWnh4?=
 =?utf-8?B?bzJwWmxsdzhqb05kRXNrVy9qdUxuR2pKVnB5WXcvVlFQSzJMRTZqbmo3eWw1?=
 =?utf-8?B?NDRBU1B0cktkRDN2dngyQ3liUllTazV0cDZHZzdMcDJqd2F0cytZZ20vaWdF?=
 =?utf-8?B?TXByWjYyVVJSSFV1Q2ViMkRncWE5cVU0ckRRU0w2V0ZtTVJ3YUVYSDlwUE83?=
 =?utf-8?B?dGs5TExkL2M2ckJHRUVMa1BrV2owYnRNVE5VUzEvM0M3RUtKbzFaZU9iY3BE?=
 =?utf-8?B?YWNoZVQ1UGFzQUtDVm1VK0NDUVBISU9sUE9XRHlsM01OenBLdnJqOXNzRXk1?=
 =?utf-8?B?REhYMXg2elNjK1V6a1V3Y0lGYXA3Z2VTQVRyTERkcTM5MTlrUVUrSkd4K1l1?=
 =?utf-8?B?SGZkOW10OS9ZQnB2aDRVaHdhcmVRbk4zODFNbEwyaFVtTUZmODJXWjFxNzBY?=
 =?utf-8?B?byt2eVVsUG5WMVFqdWRzMmlONGR0ZnppNDBuVC8wejVLaHBIZTYzNzhoV0Qz?=
 =?utf-8?B?eDNRdXh0SUdVRmhnSVIrMGl3OHhuTzlaVmFpQVE4V0tNZ0JreFFQa1FmMFdu?=
 =?utf-8?B?ZldiL3BydnNEOTFRU1drR1dEbko0ZC9BcTl2WDMwZ0FPaStvVzRXd1liVkFI?=
 =?utf-8?B?eXVobHM0cDcrcTNoSHJOU21vV3Y4bWNjVERVbzlTSGdxZU9OVGs1NkRXdy9n?=
 =?utf-8?B?K05BMklvYmNuT0ozNGFuME51c1BXY1E2eGplRzBLWHM0UHYrZ216Y3lpa21Z?=
 =?utf-8?B?SlJ3MHNMQ210cmw5dHk0dGdaR2xLOWYrcGVVc1U3UEFtNHdIOUlqNVNoQjBr?=
 =?utf-8?B?blNpeU4zOEtNVitUcnNzVDBKOHJ5R3FaRmF4aTdLUmwrUytOcmIwdUNseWll?=
 =?utf-8?B?alloMmZoYm8wbTkrRzF4WSt4OHNlU1puL1FzN2FuRUxBNzlqeUxxc3JNODhh?=
 =?utf-8?B?NTB1NHd3UU1jRE9DTEYzTndYUlp2eXlQQWhsWE02c2hYL2Z3dTR2VjF2akRB?=
 =?utf-8?B?SEpVQVZWMzN4eHp6amlVdkgzY1hLVG5pUERuTFYwOFhMb3RTSndaa0l4VG5p?=
 =?utf-8?Q?7xyVnjA9z0Sxb/6b1OdB7N3O5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ae1245-e5f9-4b42-f9c6-08db92938e7b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:31:05.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQsZxaz4jTeNp74M7gRfR2eTCTvXMirrE4NNC3H134fVLmBe3c5g24BuIByhk0tT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 04:09:52PM +0800, Michael Shavit wrote:
> > On Mon, Jul 31, 2023 at 09:28:40PM -0700, Nicolin Chen wrote:
> > > This cd_table->stall_enabled comes from master->stall_enabled, and
> > > cd_table will be in master structure. Also, struct arm_smmu_master
> > > pointer will be passed in to arm_smmu_write_ctx_desc(). So, there
> > > seems to be no need of master->cd_table.stall_enabled in the end;
> > > just use master->stall_enabled directly?
> 
> Yes it's correct that this change isn't strictly necessary. Thoughts jgg@ ?

I don't have a strong feeling here

The stall bits in the STE/CDTE should be set only for masters that
operate in stall mode.

I would hope a a single domain should be mixable between stall and PRI
masters?

If the cd_table is 1:1 with a master then keeping it in the master is
logical enough. If we ever imagine a CD table with multiple masters
then we'd need to have a bit in the cd_table too.


> On Tue, Aug 1, 2023 at 12:52 PM Nicolin Chen <nicolinc@nvidia.com> wrote:
> > Actually the stall_enabled might still need to be per-CD/domain.
> > If a domain is attached by two masters. The domain->stall_enabled
> > is initialized with the first master->stall_enabled. Then, the
> > second master->stall_enabled would be required to match with the
> > domain->stall_enabled. arm_smmu_attach_dev() has such a sanity.
> >
> > So, I think we might not need this patch.
> 
> But why force domains attached to different masters to have the same
> stall_enabled setting? Whether stall is enabled is strictly a property
> of the master, not the domain. IMO the fact that it was stored in
> domain and checked in attach_dev was only because the previous design
> required it, not because it's more appropriate.

Yes, definately remove stall from the domains, the faulting flow
should learn the faulting mode based on the master that triggered the
fault, not the domain that received it.

Jason
