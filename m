Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6191176F0D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjHCRoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjHCRoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:44:04 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B255A10D2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2iqujxSTyU1JJRe2ha7dCChoId5FocBfvUNfM4uVOylBZOC2bm2j+FSOQDwVmhoIU47wkBzk7UD6Ea09LX4gjL5AWxnSTNjM51zuR/fhGmn0U0d1Jy8CUPJEcfdigkKug3cdo7CDWsX3TnZKuVQFdVAx/QQqIjPK6FVyHgsb/ylXXsg+7kyrUONYKK+oAnJmxam3jMSz+WXulopxCkCyp2X2AvfmDT86ZfqF9mPnyQ+O417iVprRyjs/UHIhshFOhWIK0r0zvGiPktAA2SjfFzREYNUxQSNEqR+BzVt+hbOmRGevUXncBiftMKJbGF376UGpfE8RkNOMBMrUK4J+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsvTkuAMJAwwCT/cxSbcM1S1gxh+7hn4AfpxRU6wSZA=;
 b=RMQRzDeLpRHw1SAWA6RVVo79KN0uDoLaL/Koeezc6nFEiu2oByRL12SpawveWeNSM8MgtTUU70knf+/zwVcYHp9zYZ5OxlfGmlXSqaJi4u/4TXJRXfNKGhcvR8+2nqD/+raQmcqLcCTEhG44lyghO2zBowBiJsCsfJMLvdT04/uDmRKnM/NpntT2r6QknWkXSd4b2mnHJ43LtOU6rx6NSpA/+cZa7Ja+dsR68N8rig3/QLx30iDQbF2+8UOuT7JbXIJeYxDoZf6v/AadW+SDK7nGM4YSHN3HG/Rx//5ZfBGY5Zrb73zZF8vFXMCw9cy8Rvtdk8fnJ+IDxomM/bLDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsvTkuAMJAwwCT/cxSbcM1S1gxh+7hn4AfpxRU6wSZA=;
 b=A5VcYWfYCP/iLvcz3AyLkBT5TLOTGiARE1A4QSzWNxZ7G3Kt5auxLg0Aiuumj/FcRN9rUZkOpczG+LIEgEWPgpBWjCHMErPHVAcukfQHC8pBcrLZ9wfxuhCF1AG4wfpghXhJbdFlc084gv6p3mT/ylfGdImbNi2l+JarxgDB/8nSN2UVZNyh4ABrcCtEZ2P5kYLxhVRdU14ONgNv5OzznI5j9xVnDsm5DHPUgm9niKn73sjq2+rSFNiY7cxnj4sfYGktnlPJhLtI0gFgOqe5DPG/XHWFgAeF2nOplZa8RoopiF5NwE8YiVKz9sBDo3c3Ly6L3R/FtL9VR6Ylnicbyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 17:44:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 17:44:01 +0000
Date:   Thu, 3 Aug 2023 14:44:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
        nicolinc@nvidia.com
Subject: Re: [PATCH v5 2/6] iommu/arm-smmu-v3: Keep track of attached ssids
Message-ID: <ZMvnYAYXvDYbYgvV@nvidia.com>
References: <20230803101351.1561031-1-mshavit@google.com>
 <20230803181225.v5.2.I8db07b9eaef3bd5ef9bfc5c8c6d44768a4d95293@changeid>
 <ZMvKzwx2IhgXO+F8@nvidia.com>
 <CAKHBV27q-KdcoKZu7TeFdRWGvKkU7C13yOdxRNZ5cGEEbPumCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27q-KdcoKZu7TeFdRWGvKkU7C13yOdxRNZ5cGEEbPumCw@mail.gmail.com>
X-ClientProxiedBy: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5d5c22-5d68-4e65-aa35-08db944938c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNUo1FXqoVlgEqtSw+PMdyRtMNh+AziVpW+qP7SACoHT4fSvr6KcyOilnX2b67ecp7CguUmN3pMZlm1hTK+950j/c5X2NNMZuYmHHD5ymqz//PJBrC/6EJZntYBTOnufa6IIL/5Qk/gSt+quBcH7orI6nfBRe6Fr+D7Kh4qdUjquORKFPhiJvDA6+TEm7vQyNBMkMuDAcvpBRqrSvLvPVF2LI8ExK8rpHWAoGoB9HMQCRXgxAIILG4UvKOwVTLrfmsE4gDccmUU3xatIMSTVynTjSEtSbreg91zU47rUIDdc5G576ZzzIN+4uuI5TKSrzp3HSAPCK1Ck3H7OHHnCM+Uk79BQ6tCfKwEchxqsZFO3CdXDcr/1x1EoavbmCgPn2xBoreMa9tGSppwglvDA3dJG2oJhW7zIdy4ZnzgMhnLl/s9q1KiPG2Bsfg/YXsM32LlkoM0cv97bDM93gCB2rBwtaKPDlAC/lBCffxGVEGcKNumMO3ZIOyLuEgGCGEG4De6qOat41av3eS9SSNaldftsPMud0R8srHfmF5Ll9ccQpBnZ2EbEBsmZi1FMXWTh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(2616005)(107886003)(53546011)(6506007)(186003)(83380400001)(26005)(8676002)(66476007)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(8936002)(41300700001)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlJ3MHN6OUZOdUNOVWx1UmRxd05sTjkvUDRSeCtHdVlnWFUrdmRzM3VZNzBz?=
 =?utf-8?B?Vk5WWVdETWwvc05LUE1vam01RUhzdGJ2d0FVRlQrVE5YMWdsS2tteDBRZG9V?=
 =?utf-8?B?SEp1b3cxelIvRnV0YnFDUUlPT1A5aEd4NmJNTWhCRlMvV3E3dXNrWE9kbXhY?=
 =?utf-8?B?azdGNkpGUk00bW90MjFxcUNGSnh6V2VXRk15UFFSNGREeFdvWUtpOWNSK1Jx?=
 =?utf-8?B?UnRzS2d0VE9qaXNDNGovdmNvK3l6NmtKNys1aGx6UWx5UTcxRUx5Y1EzRzdn?=
 =?utf-8?B?NHZYV2toQnMyNGswUG5uODFXTjVyM1g0Szg1SWxVZ01kNEdpL2ZhS2l3Tmh2?=
 =?utf-8?B?ZmNwc3pVcDdlU2QyVjdoMFhsYkI3ZS92ZVgyM1BjKzF4R29vZEI2ZVV6cGVW?=
 =?utf-8?B?WEpMeUR1Z1puRmIxZnFvWkhPbk1kSmZjYWFwZ2xQWGduaU5uNnRTS1M1VCtU?=
 =?utf-8?B?RjdoMEFBdEVmak5pUGtFdkY4UndYL2ljc2twU29qUWtmK05sNzBRWm5EYjUy?=
 =?utf-8?B?WmI4emlUcTF5dUJrVlhaSGZxL2ZudE0vUlpRNDZ6WFozMS9lVVdCMUNlb1l2?=
 =?utf-8?B?MUEyenhWblVIcGo3cHMxc2lBVjNuRFRpekxFSktNRngwUDhnS2MwSzJ2RFVj?=
 =?utf-8?B?aDZSOUd5elRwNFlzVVc2MHVZd3NmQzlQdzQwc1d0TFcwSHBEQjN6WHhRd0Z2?=
 =?utf-8?B?eUV2RE9xSnZmRGhhRW43MGU0di9wOUliQm9HMURrR3RXNXFVM1lBREx4WFIy?=
 =?utf-8?B?djcyOXNSYzNRRUZZQ1RrejkrSGhoUFp6dDlabU9Kc3NGajh3L3JsMXg5U1N4?=
 =?utf-8?B?di9PQXVOM1dJWW9Nd2NnNkZGajdFY3R2Rkc3QkxVaTljYyttUnlDNlZKVnNu?=
 =?utf-8?B?WkdiM01ENERlMFlORXgwaG9jZzUzWXhzZEx4ejFPMXZBYk5pOTJGNHpwUVdx?=
 =?utf-8?B?Y1BudHBwMHRGZy90cytGTGY1amJ3c3ozRU1ZS1JhWEU1RlZlb2EvUlRqQmF2?=
 =?utf-8?B?ZEVld0pVSEo5WWhDZ0VpYjIxMFpmSmVxUlhkMEtVajlaRVNxbHowK0Vzd1JP?=
 =?utf-8?B?endWODJ1dWtGMFpOWFdBYWVIbTg5dFpyM003QW1IU1ZRQUlCSERKd3paZmhQ?=
 =?utf-8?B?STRvek8zZjVWTTI4cUZGQVNlZWg5RlNjdkltaEV0Q1dld2dIUEpaYkZFVEN3?=
 =?utf-8?B?WXlIRE1FR1RSdjA5Qk5qSmFTaloyRDhET3A5UmNQMVJ5ZGJFSGpoTitabDlE?=
 =?utf-8?B?SWJoMTl2RXBSNDNOdDVkOTUvaVVFRWxqbWFmZ09oSHVIRUFENU1ab25BU0RS?=
 =?utf-8?B?TG9EWWRQL2h1NmhzKzdFaDFvSHdIYlhCbkxQc1JGQ1cvN2NoNGg3bi95cFk4?=
 =?utf-8?B?M05lZTlEamd2L0VHb2ZIcVpubkVGT3Z6SzJmUzFrbW1EaHBPeWJrZ1VGMVFk?=
 =?utf-8?B?RlJLeDBJaktkM1pEMUNEbWhYc1RtdFFqU3BORWY1L1Z5V0tuN2I3bGIyMXV2?=
 =?utf-8?B?UlJTdEFJditxekJWQkNQK21kSjBkZW9EQStKUUdpRVRCdzd0dE0xT2hDOHVB?=
 =?utf-8?B?Z0xDWGFtL2g2M25YSjk2RTRuaFJjMHQwS2tDSkpaK01ybiswcnlvY2dQMGNF?=
 =?utf-8?B?UkM2MHVZQ1Y5Mmk0c0UyTlU2bVBPeVpQUnFHNlNIZENBSGkwRU1YN2xTeFJJ?=
 =?utf-8?B?aUwyUCtvczV1cm1TR0d6KzVITFlnNXhWVTlqNUFiNSt0bzRLK040cmhhV3Q1?=
 =?utf-8?B?WjZtdFRtaEJyd3NiZlVVaTZ4MDFnSzByT3JFS3JIV2pMdW9sUnQrcWtQV0pO?=
 =?utf-8?B?R2Z1VEpKd2QrQUtHNGg2bnRwL014ZjV6UFpOMWYwQ3pNaW5IaERKaEx3WENk?=
 =?utf-8?B?VWlFZFRNdk5jUFQ0eWFtYVRPNXIvNU9LakUvM0M1WnY4eVZwWmNscHQ1VUVM?=
 =?utf-8?B?YXdPSjU0ZEtUdjFNRGc4SThjdWJuU0YzZHRHVkNzSUlWRllTU25wUmZHc0lN?=
 =?utf-8?B?R3h3YmpVaUdNMVI1L2cyZG9kanFOd0Nub0FEc3dqeWdUcVpDVThTOEt4L2FQ?=
 =?utf-8?B?cENIWVdEdUM2WkRVUWQ0QUlwUGJ2cUtzNWJMNUMreXdWYXZZZm9xN2daMHdj?=
 =?utf-8?Q?10rY8EupDJV4EmOo2ImU7DrYF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5d5c22-5d68-4e65-aa35-08db944938c4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 17:44:01.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txArfI1C3Zi1dQGsPmRdH7aRpFCsGxYxL3KpgDyyyGVXwinvKw7WZCZffeqb1+b6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 12:32:08AM +0800, Michael Shavit wrote:
> On Thu, Aug 3, 2023 at 11:42 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Thu, Aug 03, 2023 at 06:12:22PM +0800, Michael Shavit wrote:
> > > The arm-smmu-v3 driver keeps track of all masters that a domain is
> > > attached to so that it can re-write their STEs when the domain's ASID is
> > > upated by SVA.
> >
> > Wah?
> >
> > A domain's ASID shouldn't change, why does it change for SVA? Doesn't
> > SVA use CDTE's only? Why would it ever change a STE? I'm confused what
> > you are trying to explain here.
> 
> Urh right, I mixed up CD entry and STE here. Before this patch, SVA
> keeps tracks of all the masters attached to a CD domain, and updates
> the CD entry 0 in their CD table. 

Because it assumes that if a domain is returned from the ASID lookup
it is a RID domain.

> Now that a CD domain can be attached on non-zero SSIDs, SVA can't
> simply update slot 0 in the table; it must know which slot(s) this
> domain is attached to.

Yes, so why are you passing in 0 as the ssid argument to
arm_smmu_write_ctx_desc_devices() for the ASID change?

I think your commit message is trying to say:

The SMMUv3 driver keeps track of all the iommu_domains that are
assigned to an ASID in an xarray. The SVA code needs to re-use the
same ASID as the CPU's ASID (presumably only for BTM mode?) so it has
a mechanism to reclaim an already used ASID from an existing domain.

This is currently hardwired with the assumption that a domain using an
ASID is only on SSID 0.

Add a list to the struct arm_smmu_domain recording each master and
SSID that the domain is attached to and update it when any domain is
attached/detached.

Make arm_smmu_write_ctx_desc_devices() follow this list when storing
the CD table entries for the domain.

Remove 'ssid' as an argument to arm_smmu_write_ctx_desc_devices()
since it is always found in the attached_ssids.

> > What is a "primary domain"? Why can't we fix SVA first so it doesn't
> > have this weird "piggybacks" or:
> >
> ...
> >
> > This patch is not making sense to me, the goal in the commit message
> > seems logical, but why is tracking CD entries introducing this concept
> > of a primary domain and doing special stuff for SSID=0?
> 
> I'd argue this patch isn't introducing anything the driver isn't
> already doing.

So this I don't understand:

+               if (ssid && attached_domain->ssid == 0) {
+                       ret = arm_smmu_write_ctx_desc(master, ssid, cd);
+               } else {
+                       ret = arm_smmu_write_ctx_desc(
+                               master, attached_domain->ssid, cd);
+               }

Fix this patch so attached_domain->ssid is never wrong?

Remove ssid as an input to the function.

(I'd ultimately expect to remove CD too)

> it. I do have a patch series in the works to properly fix SVA, but
> it's growing quite large and I was trying to get this feature
> out first. At a high level, the subsequent series:
> 1. Nests the list of attached masters in a list of SMMUs the domain is
> installed in. Updates SMMU-level operations (such as invalidations) to
> iterate over said list.
> 2. Checks the compatibility of a domain when attaching to a new SMMU
> instead of outright rejecting, to allow attaching a domain to multiple
> SMMUs.
> 3. Thus allowing SVA to alloc a single domain for the MM struct (which
> the series maps from multiple SVA domains internally, pending support
> at the iommu core layer)

This should not be hard for the core code

> 4. And allowing SVA to use the same set_dev_pasid implementation used
> here on that domain.

This list all makes alot of sense to me

> Now having said that, it might be possible to get rid of piggybacking
> sooner if we create an MM per master instead of per "primary-domain",
> but I'm not too sure about performance implications. AFAICT, the only
> downside might be for invalidate_range commands that could no longer
> be sent as a batched command to the SMMU (since each mmu notifier
> would be called independently).

I'm not sure this series leaves things in a better state than before,
now we have two parallel domain attachment paths for PASID :(

Jason
