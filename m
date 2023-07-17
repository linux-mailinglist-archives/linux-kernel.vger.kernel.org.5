Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275577562BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjGQM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGQM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:29:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D7BE1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyqsASYSPSJvlQdGXc2Z7f8VLtjns4Za8YRnbvvUZOFWLC4d69ZVSXAyn67AaY5V2uGftaXwhRi338NT6N8YEprccAz0MIkLXBBvEcn9U4Gjm5Crhi8tm1y3OqVz8KoiDNvj2B1ZgdzczwC2AZVLXNIi4HpRACorpNcy/iFkyjUQBV69rpxS0ldVC3zCY0S/Em/68PAQCOl9S62KMh0LLd75b+Zag2dubf8/Ai+x8yyq5UnlhmcvL117vn+TJJ00JLcky26TGui1N2yRdLh4PxYBWE9MS21nW/w/A59UmE7HNImOWoJN5hzon5RZLNL/u7D/KrpR7GXn7p2y5W8Cig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esIpGah8yMx3HJl8dTbgIHHV3UpoD9bop3bNtdBpgms=;
 b=jOqSKmZtk/kmTdIoFYetGnQg7x3MkI1ZDvDTIgZRS8CVMzY0RExtB1+NFgvzmwdK0xA92FqZYU6lG93ae4y3Qf4nsrYL+OGbLmryIkd4R75Dfsf4dt2cx+TB2OyhIBq6H0bAaKh91qjwJ2sEaVUOLJjHQfNw50blCDEcJDk/IRBAC2YWmOgiI1uyKbFYRpcy81JRrK1SsNYjvoSxLQYSkwn0/9YSMiQbhev9DsDMkx6vRQNvdeOkMF/fFuNu9gKgWDeGA9hpjt1Y/TykQHD4m4s/jqXbSrDVx2JWJUy+6aEz+hNC2cWvz1EWvxK3Jvfrrik/dlvrmjCi7dLGbmqjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esIpGah8yMx3HJl8dTbgIHHV3UpoD9bop3bNtdBpgms=;
 b=XrSeyKqPPgVOhcM8XT2z7FAOiHrEVhawHaAaLOXfDyYiFMYf2rOzRBa1XTwjCz9N+4vWh+6YPMUaQdvy0NrQgeLARKimIERstmwoe9gSNo6V5sEhIC3BfR34c23thJ+gTmZACJVMqt56e6o1KdrvtqtCNo/giG1dsJb31rbVOuAklYiRSdw2DHsd7Hu6I6zkMUP1yNJ8+GRHnEcfPjauLo8kmKMEKGB2biSjC4G7gCQaQsKWss7QwbKZQnlF69JyG0cpZ8FYeUdbrWLNEVur5H8Y2mKfq9OBQUEHjH0ivuDFEdyDcshki/fXmE1pxnjd4tlePv4nNP9q7fp7Evbn2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 12:29:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 12:29:24 +0000
Date:   Mon, 17 Jul 2023 09:29:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <ZLU0IZJr6WSjknHf@nvidia.com>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia>
 <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com>
 <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com>
 <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
 <ZLFLyh1b+wiqb7Ql@nvidia.com>
 <CAKHBV24zQ+4waZgsYV08LzeMkjze1gTcwvEv5uL8RM1GcBgrzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV24zQ+4waZgsYV08LzeMkjze1gTcwvEv5uL8RM1GcBgrzg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d671bb-1a94-41b9-146d-08db86c17427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMikb3p10b9G41ulKLgHLQIf7TcvlmhE7tHE7anp4Koe4gz6P234PKGH0GlrcovM8xJ9v5pAKeoTrQY8nU9kO8lf1zum0Iwy5Ai+lUMHJ+dZ5xu5gIYNyE9AUKWYCJCN9CvCLqA9V5tDxoTOa9evRlsi4AWQVUTMIpBXYlgDLFguwfRZeaCTz3H0K4U2pOoUO9mVC+HZ+G16kJzGlZJdEDkr3Uk1cVxX+/B5okwqcDtOYQYk98THeweKwGuaeos5E+Jj2LXn/wlpD435ZxblPbF3Gl59yWEiegOkRsfclB1STEMAPDB0PZcG2oDI++jjg9KwxML8/Mj2kGHhgS4dkDG9Ps4GOY6fTa4vfhrCH17vct7eK0Q+7CasoL0KF76/ZyE5Xqs1g7sFDKyqcL8v0aKPqrttZkziuTHLhLeVewjL/07ybmjaqWGMNLbA2XUMSD4x5OR0M2fpFHLYmPtppnHZckE87h1JCy9jMRm5oeu/ZqQNwlvud7wbhq1MCrGHX/rXGAS5Tm5nAvN4mRvtnHer01mc3mVsS5o28j6W9fYEiO74fJomi5gERxmKUuXcUBugEKkJ1EVac81los0naf5sdLB3KkTMwHvMOxF36eKnUvrPL9fRqpungYvAkUhvL+2DktvSyLvFdL9f1BvdhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(6512007)(6666004)(186003)(83380400001)(36756003)(86362001)(2616005)(53546011)(6506007)(26005)(38100700002)(41300700001)(4326008)(66476007)(66946007)(8936002)(8676002)(6916009)(66556008)(5660300002)(316002)(2906002)(478600001)(54906003)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3JFQXdtWFp6L29LVEdGR0x0WUdDNGxJRzhnU3M2UUlYRm1BQ3k2WEhtTlRQ?=
 =?utf-8?B?OUZhTlF5ZTU5d2ZkR2NHUUV5OWlGVE02RGFpaWNObWVFaVkrV0c0b2h1QVFB?=
 =?utf-8?B?b3FvMVJVbFlDcDRQeWo2SnROVEIvNnhhcXhKaEFnaU1GK1V2dWV6azBWV0Jh?=
 =?utf-8?B?NE5UQ2p2WDIzWS9xYllRclZwODhpTXZoTnNnQUhVK0ZpSTZqeWxNYlIwWW9z?=
 =?utf-8?B?WVE3N3dBVUZieHRnQTRjazBHcmlrRE53V2g2SGc3Yi9rMmZKK0hIaXNVZFVa?=
 =?utf-8?B?Mk5Dc3dLL09QUkUzdGYrZTU3dDNTOUtzenk0bFJqdGZYcy9MNHpZblZld05S?=
 =?utf-8?B?c0JGOFpNaG1jczVoT0pZdEQxYUQ0ZnZpSVRpMzR3eHlmNW5YUDNxZ2drN3pN?=
 =?utf-8?B?b2J1NFBNUHZCMXFtQVRQK3pBcklwODI2T0hmUTR3YTNwOGJJOFd0MnhrMmFK?=
 =?utf-8?B?T3dJbHMzUDh0aGVHWFF3L0xQc3J1anZvU0dsbHpaRFF1K3FjOHk2Y0tQLzZQ?=
 =?utf-8?B?dFR2L3RRSGhzalZ6QmlZdWx6N3Z1Znc2Tk1rcjVDUnBmWGRGK0s2T3pDc25t?=
 =?utf-8?B?enJZVW42L2tpTi9rVG5PNkFlbUlUT0srQ2VIOFFybXdmbVhJSHdPL2RSOXdp?=
 =?utf-8?B?YjVhWitwSWNBU3k5ZXB3amZTdG9VL0llaUJWUUpnclFoaXJZcEFmdjlSS0FL?=
 =?utf-8?B?RnNnWThFYWZoa2lkc3IwRXZJZjVZNGlWRWF1enErdGNQT1U4VUxWYjk2NlFV?=
 =?utf-8?B?dnI5Wlc4ZXpOUDIyaUhYam45UjU1eUozVW9aMzFWVU9MYUIxQUlVMk15OHpk?=
 =?utf-8?B?NlZGUEh1WEJhanFTakJJUHlxaHdqaGpjYjRrY01ZMmNQVUYrdSsxYS8wSWRU?=
 =?utf-8?B?WXVRNElSK05VNElFSU1mdG9LVDZkcmM2enQ0KzNGUVVHZHhhZE01dkhPUGMz?=
 =?utf-8?B?bjJ6RW84aURrZldEK0RUTHhROExDUGkvUzR3c1dwTFdPN2JCWTFnQnBGQzla?=
 =?utf-8?B?OTk2aG9hWDI2eVk2Z3pvSGVSV2RJV0NMd2J6WWRyMnZsYlFiZ2MxWWxheGFw?=
 =?utf-8?B?QU95eDBUWWRhcExlU1BmL0JVSCthdHI2OGxyZXRhR0lrT2VIbkVqek9rWjNr?=
 =?utf-8?B?UGRJLzFtWW9XRjhZWTdNTFhsb1BBQ244VENacjNQakNnU1BOcXk4SDd3WjdW?=
 =?utf-8?B?WTZ2UlMwUVl5Z3Z2aXVvM0ZGV2lQTE9TTVlxYkNkT2JTWFBwWTJjREk1VzdP?=
 =?utf-8?B?T0VXbHRDSXZNYTlEUTVEVnRnbFdtRmd1VHN3eGdmTVhtZGJjQ090RTRtMXA1?=
 =?utf-8?B?TFZ5VXJhaXFlU1VZaDFuS0N2OStnWVIxZDczTVFyWkRxaVZrYW1UWlE0NHY5?=
 =?utf-8?B?bVVCelVWN3psVDJaRHhNZTVuUWN3ZUJ2OEJ2TzRHcStMcEFiVGdtSFlLaW5K?=
 =?utf-8?B?Q2k4WVJldnR4WmVjWkQrMjFBQjVHWDVqcXk0Z1Bkd20rWXJiODlKbW16bUl4?=
 =?utf-8?B?dGg4MFdLSWY1cHRQWjk4OU5PZzNpQVM4b282WG85R2dCVU0yU0NjaHgvZGE1?=
 =?utf-8?B?YjRPNHl4MjNBZGliSkQ0bEpVZFJ2WFVQQ0JqaGhCT2lQc1MrbDlWYzJZcXRl?=
 =?utf-8?B?Q1FnblRaUVJ4Nm01RVFHTTZWZ0RPZjBHRlNtdDlNQlEwcllUTG1GVEVWN1E2?=
 =?utf-8?B?MUVIWSsvYldEKzdkVU9odkFxRG9UcnVsVFBKanBiUXdDYXJuTlVkS0VUM0lr?=
 =?utf-8?B?WnVMZllJUXRmK1dteWswdTdib1o0SDR0YVF6elViZEF1c3JnUVcxSWlhRkRZ?=
 =?utf-8?B?V0JWZi84cllHY0M1TUUraWNuQ21YZVpFa1hkckdiOThGb0VWb3lXbzNJMzF3?=
 =?utf-8?B?NnlzZUNUZjlHSEFDZzhXckMrYkhnUHpoWDhWQjFtNFdVakhCdWg1TE9tNG5T?=
 =?utf-8?B?dkFoTzlyUmpCWXo1VnBTMDNXUWY0Lzg4VnNzVVBEMGdrTzM2WitEQlArYlpj?=
 =?utf-8?B?ZVZYbmpKN1AvSi8yREJPb3J2NUEyUDNDMkYxT3VmaVZjZnVQcXF5L3U1UDFZ?=
 =?utf-8?B?Z04wRUxFZndEWjNab3Boa1UrRkU3a3c4VUpsdzI4Z2R3S0g5bHlMMm05U2t5?=
 =?utf-8?Q?hEBsWbfFakrhpusn/SaV92lRH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d671bb-1a94-41b9-146d-08db86c17427
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 12:29:24.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1K69I/pJOG8XUieCW9v6L3Qo9xP7hFjlPHrJLQTgjUdUEmZh8qu51fo23z8QP10
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:06:19PM +0800, Michael Shavit wrote:
> On Fri, Jul 14, 2023 at 9:21 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > patch 2 should delete arm_smmu_s1_cfg and just put
> > arm_smmu_ctx_desc_cfg directly in the master. arm_smmu_ctx_desc_cfg is
> > a weird name for the contex descriptor table, but it is much less
> > weird than s1_cfg. As you say s1fmt/s1cdmax are redundant.
> 
> s1fmt is fairly trivial to replace but s1cdmax requires inversing
> previous computations. I don't really buy that getting rid of it
> simplifies anything, even if it's technically redundant.

Then store s1cdmax in the arm_smmu_ctx_desc_cfg and still get rid of
arm_smmu_s1_cfg

The point is to get rid of "s1_cfg" entirely as language in the driver
*because it makes zero sense now*. Prior to your restructuring it was
sort of the STE to use for the S1 page table which had an embedded
CD. After all this change it isn't realated to a S1 page table anymore
at all.

> > patch 3 I don't understand, we should not add something called
> > s1_cfg/s2_cfg to the master. The master should have
> > 'arm_smmu_ctx_desc_cfg cd_table' and 'arm_smmu_domain ste_domain'
> 
> This was simply meant to be a more convenient way of finding the
> currently active cdtable from the

There is only one (meaningful) choice though, the cdtable is either
the master's default CD table or it isn't. You detect that by checking
for NULL ste_domain

> > My suggestion for patch structure is to start by cleaning up the CD
> > table object. Make arm_smmu_ctx_desc_cfg the CD table, remove the
> > redudencies, remove arm_s1_cfg, clean the CD table APIs to only use
> > 'struct arm_smmu_ctx_desc_cfg *', add the 'ste_domain' to the master,
> > and then as the last step just move the arm_smmu_ctx_desc_cfg from the
> > iommu_domain to the master.
> >
> > And that is a nice little series on its own - you end up with a shared
> > CD table in the master, and no CD table in any domains.
> 
> I don't entirely buy that refactoring s1_cfg is worth the extra
> effort, nor that it should be tied to this patch series. This series
> already makes s1_cfg behave as the CD table; whether we want to
> entirely get rid of pre-computed data useful for writing an STE sounds
> like a separate cleanup.

s1_cfg is a terrible name to describe the cd table. Please do the
tiny bit extra to get rid of it for clarity. 

Jason

