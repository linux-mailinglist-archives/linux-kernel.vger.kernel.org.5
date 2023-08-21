Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA77782AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjHUNuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbjHUNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:50:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE989CE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbVIDBRF1fq/l/VlxYpBHAC1wRNCreRBFNATBC1+l2IOTnZlMvLJCFE4hj3RSpp+cEXlPy3LB5PYRnXylrzNkuC35UKshBlljyUL/Nj9tcR99s5LmSkwgLiU/9meuSMSe+38gw57yHaXh5Xj8WRI0OoR1xo1dOaejH55UJflIFTyL3AlTBTeBjl/bsHXT+VEwRsWrl618KvXzgEP6o8hIli+sGAQhN5FwTZzymVzf2D45Mf2u3AQjhpJC3B3OA/klU8+jaXz34KZpFI2NJ5LhIw71NWnBlNQtajMzbla66Kr3OfwcAvWCNxAf6N/Nnv/cadGqXneu3Siet2R2E+kPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiTFDJUb/Oiur5ylRf7zJNhdYPXmsI7JvGU8NB3RvPw=;
 b=JwyPKXvqCmoGsrfjIsiYneH9BEi6lsvF1uw742gXsUv8iB+NMlgP31uWsrNo9ywn+7URiBuuTCf6rDWGIKAShqgZxbK14qcP+Xh1UtyCJgZHFOKmO+600Op7OCaE0j01cjFwS9mw7Ma6QAM8m/gBSGN5xSkswG4z62D7NAUTBcMKkakTBr2UGXmpwSiiXECNtJwdqqCeW+J0ciCOzyiFT1kID8ENzmPPuU7/PopRVROwXgywatf5XpzQ1th6N6HnkAafQbU5d3sJH3yKcDIARhmj4Ngh1QvMJRKlTMFEy5cQtu73xVenMFLdbThWU/2OXWmSDso0d+IfQ2TXdpZ+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiTFDJUb/Oiur5ylRf7zJNhdYPXmsI7JvGU8NB3RvPw=;
 b=OD6nQmneL2BRSUepF8kS7dwTrb+1Q4ercnAgO2I0y0sj/T383EZbKAEv9vxAPz19cJ0Z0czGMg87Le296SExeQq1lBel9gbXPF6dFApaAa5Kv6vYrZJ5I0Trn0YyfTZzGVxm/QOxSMPWBLBm7mf6jNLor/lezj3QvFrIx6KJ+Y6Ym6+lW3M1nJf7IrU7iW2kqlq9TtHGGM9J/zVqSwBe9+tQkUScGhcZ9yqihdFOiBsOlyyFczW4QAYKiQICZh3NpQ4uuJ89Nrd2TzqLhZAviNnVDC80NMaaR5pr6gfz3U+MEvb5nrZAyNeZeGK+zPGohyVZ+vDehC6PDqlaL8/2SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Mon, 21 Aug
 2023 13:50:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 13:50:11 +0000
Date:   Mon, 21 Aug 2023 10:50:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com
Subject: Re: [RFC PATCH v1 3/8] iommu/arm-smmu-v3-sva: Allocate new ASID from
 installed_smmus
Message-ID: <ZONrkVX6kZjX/wus@nvidia.com>
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZN5pK03Drao/egeF@nvidia.com>
 <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
 <ZONQgNh6qarqgA+f@nvidia.com>
 <CAKHBV26oTZLssq5bopePojqgrEJwukKHYEbhU02nAvHHVB13mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV26oTZLssq5bopePojqgrEJwukKHYEbhU02nAvHHVB13mw@mail.gmail.com>
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: fb39326f-ce08-4361-351a-08dba24d896e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTXuFwIRq4PxCBTJbmzsbOPyv87ABUD6yVVbcVg7QJCQYlbK0w2ymzljL8nnbOA1IqddF8JodIcVNGpi7kbFX5WYZiRLjEoZeGVxNQ9xQh4ootdFMSeDENntTUQUGj1/4stas/MU8MsyeTUk7DxMpJabSScF8yTCMS+kSrm0NyzMvInXmNLHdYy6YP7c/x4ypxfAjZI1X0Q9Oa/wqKvgnJdm969NGLucP59zDdIQEicVUWMzfTanRDSEdczCRSlRc/LjqbEEIEash20TEoPXUBxyeYmzXLuBYGbxJb0GBmSAn9Uhq7jlSs6S8PkWPhFCrHTSKyM0DlptpM8rfcnWNiGzKxJNGyR1rFQUy3h/t1rnW0xGf5+tX+sQryh8F/lRLVEMxY87DCMOjR4rmx7GCF9319f8NqitYm+m6qM6Cu1dG4AhOqjc9Z08qnPVaNnhmzFAn7In/RjYElB8+Ew9XjtgVqYfIwhXIA+zIO6WxPylnMHCHHIQnsvNAjw1ls0eHjTRhnJF0YY6zxJT8gdcfWv1OKZhCVJ5+7egNbt42Oe6PqFot0cX7+of15yMCIwj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(1800799009)(451199024)(186009)(5660300002)(83380400001)(38100700002)(316002)(66476007)(66556008)(6916009)(478600001)(2906002)(41300700001)(8936002)(8676002)(4326008)(53546011)(6512007)(2616005)(66946007)(6506007)(26005)(6486002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVVsODRqcVV4MjZqei9pWFFxdU5Ocks1UWJraUV0WDYxV2daS2R3T21hTGxw?=
 =?utf-8?B?Q3N1YVkzUXdLaDArYmFlNjZJWDRrazYzWGxucFlEOSt4RzBnYVhHRUpyTjRy?=
 =?utf-8?B?YnNQTDVwRVFwNEdkaDl3ODVFSUR5NmFWbTRTUGxRVG9IakVCdWJubjZFdWov?=
 =?utf-8?B?cUR4MHlDbWM1VzhsWlM3eWEwVUtPMTdWREZWTzZuSXQ1aXFvVlpBSFF0cEJJ?=
 =?utf-8?B?enhrTExYalp0YUtwT3o2MVZGRVRqc09ibnRNVGttTlRzejdaMG03SHh6dW9N?=
 =?utf-8?B?L2pQcHZNbk5DcVdOV3RYblpPdlZONHA0RkRxL0pjMEo1czcyVzdYYVE3bEsr?=
 =?utf-8?B?N05SeG1IdmtEU0NhRkNacFBCTDRCRFNMMnpiQTRwajNEL2ovWlRaTnhTRi81?=
 =?utf-8?B?Qzl4TS9xZUMyV1hpczZBS2VqcHV0T0UvZjBTdEhKWmt2SFVhL25ldmtSajFN?=
 =?utf-8?B?RkpLakhMMHFHdU5jUnkwd1NrSFVRc1kzS0dEQjFWZnNPL3JJWWdlRzA0d0ZL?=
 =?utf-8?B?d1BXRE1VTHIvNHVmQ3RZaVhRWkZFbXVGRnhVcy8yVXZvbGZCeWdvUzQ0d1E4?=
 =?utf-8?B?Wmx1bVh4UU5ETVcxT09VUDhlUzFKVUt5T2dpdUFoM1hROVQrNjZXeUNUZ1JE?=
 =?utf-8?B?SDdqc1lDWkhnNWFBcmU0Zm9EY3BtVUFXc09vMkxNdjgzTHB4Z1Vsd3VoSlhC?=
 =?utf-8?B?a2I5M0ZMUHhwaUhTVldXTUhDYkluZlFXOHFCc0RYMmFYejh5Q3BJdFpCY25t?=
 =?utf-8?B?SzB3SkZHM2FBaGlBYVhSMDlZMXBPVytOeFh0bU9WM0pMczlIZmxHMVliRFgv?=
 =?utf-8?B?WEtaampMVm1ybEZRYzNGc2JGRzR5VHJHTnJxQnlWT1Zhei91dTlQYTJOT1BF?=
 =?utf-8?B?QXIvSm5ZRXM2K2VpMk1YZDRxRkNyMWtsQXZ0TlNjS0J2QWdtOTdHMVA0R3lw?=
 =?utf-8?B?T2dyb0p2ZTVpVG82OXVGTmRrZ0o2QW5qcEcweVlCNVFGa0tUUEhVOFNRSmkx?=
 =?utf-8?B?RDNVRFJCRExVdmRtNGVzcXE2MnNhWmg3N0pzTzNwZGtlK3hudXptWFNXK2s4?=
 =?utf-8?B?aUR1ekhhWGV2K01PdmJyNGhMNjMzdnVHdXRSSzlPRHFjRW05bHVoVFU4dFFU?=
 =?utf-8?B?dTNqSUtzOFhkb2JRY3VZeHZ3ZVJFemhKYmY5NWVIL1FNYVdnME9kY0N2TElT?=
 =?utf-8?B?SlRlZzM5ZzJ1VHdPOWVGSzFMWkRNNDhXTzg4M3JiMDA3ME8vT1Z2amtrMTUr?=
 =?utf-8?B?SVVuSHNnNlZsMWdWUnFvbVFqdmhmYkIraWlZYVdGRjBOQk5HOEpZWExncXI5?=
 =?utf-8?B?bHN0ZFpTaXdPVTVnVlB6aU1yV0tOcXlFVXUrOWlaQ3d3dmRqd1FyZmR3dE84?=
 =?utf-8?B?em1RNThUZUc2dVNQYUNyek9pQmk2UzZkZ0I0VUZmMUE3TUd2L0V5VjFZcWNL?=
 =?utf-8?B?Ti9Tbm1OdmIrdGw5cHlGOE1yNzREK1hsMUpjbTFHeVNoV09ERklyUWV4VWI5?=
 =?utf-8?B?dUlvbXc5QzZVV3l6eWFmLzdPSmJFSFFIeUxQZlNkd2pXYmNhd21KbjNwWnhj?=
 =?utf-8?B?d2tIcGZDYmJOekNzWlNiSVVxeGo5VG9mZjFVMXZTajdIcDFWYW85RkEyQ1o0?=
 =?utf-8?B?VU4xU0NjYmt5UVRTWEdUZFhmVTRjK3ljOTdYUmpXK3JNaTlvSEpCa2N6cVBt?=
 =?utf-8?B?MEUzQUJiY092amFsVk96L1ROWEJXNkwxSW1NRVRNTERJVUN5bkNiTXpnVG1h?=
 =?utf-8?B?bXJnUlRkS0FremgweW5pVGNsTWsyRjZWUmlHRDNoTi8zd0N6Q2NOeVJnMTZB?=
 =?utf-8?B?eVRNWDFLMGdaeVdHYTF2czBHcGljSk5HOUpwWHhBQks1am10ZVdyTCtFWno2?=
 =?utf-8?B?ZjZhckt1bEZOOG1XdGxjd3dZanVQOXFxemI5dCtHRDBicTBFRE16ZEpwVmVI?=
 =?utf-8?B?ZmNUYTJnQU5NeThHMFFzcDFYTmFNUmN5STA1UHlMbzV2cGxmeW5oRHQvR3F5?=
 =?utf-8?B?amljZUN5WGtpRXd4MWF2RE04bTdJaWVuU3N0UU8yczJGRk40VFdzVjBRQ1Vw?=
 =?utf-8?B?TzhqVW1QZ2oyVHJaamVWOUprY1FVd0FRazNPbUJHVFlmTVppVzVUc2hxbmVr?=
 =?utf-8?Q?ius32ufL/VM/9PdU3o29hgeJE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb39326f-ce08-4361-351a-08dba24d896e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 13:50:11.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOu8BfkKPeKLVTSfF90vK8lDrRUovbFN27VvK2sf53PLLyGcTRAJUoF8vLn/2zoH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:38:40PM +0800, Michael Shavit wrote:
> On Mon, Aug 21, 2023 at 7:54 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Mon, Aug 21, 2023 at 05:31:23PM +0800, Michael Shavit wrote:
> > > On Fri, Aug 18, 2023 at 2:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Fri, Aug 18, 2023 at 02:16:25AM +0800, Michael Shavit wrote:
> > > > > Pick an ASID that is within the supported range of all SMMUs that the
> > > > > domain is installed to.
> > > > >
> > > > > Signed-off-by: Michael Shavit <mshavit@google.com>
> > > > > ---
> > > >
> > > > This seems like a pretty niche scenario, maybe we should just keep a
> > > > global for the max ASID?
> > > >
> > > > Otherwise we need a code to change the ASID, even for non-SVA domains,
> > > > when the domain is installed in different devices if the current ASID
> > > > is over the instance max..
> > >
> > > This RFC took the other easy way out for this problem by rejecting
> > > attaching a domain if its currently assigned ASID/VMID
> > > is out of range when attaching to a new SMMU. But I'm not sure
> > > which of the two options is the right trade-off.
> > > Especially if we move VMID to a global allocator (which I plan to add
> > > for v2), setting a global maximum for VMID of 256 sounds small.
> >
> > IMHO the simplest and best thing is to make both vmid and asid as
> > local allocators. Then alot of these problems disappear
> 
> Well that does sound like the most flexible, but IMO quite a lot more
> complicated.
> 
> I'll post a v2 RFC that removes the `iommu/arm-smmu-v3: Add list of
> installed_smmus` patch and uses a flat master list in smmu_domain as
> suggested by Robin, for comparison with the v1. But at a glance using a
> local allocator would require:

> 1. Keeping that patch so we can track the asid/vmid for a domain on a
> per smmu instance

You'd have to store the cache tag in the per-master struct on that
list and take it out of the domain struct.

Ie the list of attached masters contains the per-master cache tag
instead of a global cache tag.

The only place you need the cache tag is when iterating over the list
of masters, so it is OK.

If the list of masters is sorted by smmu then the first master of each
smmu can be used to perform the cache tag invalidation, then the rest
of the list is the ATC invalidation.

The looping code will be a bit ugly.

> 2. Keeping a map in the smmu struct so that arm_smmu_share_asid can
> find any arm_smmu_installed_smmu that need to have their asid
> updated

Yes, the global xarray moves into the smmu

> (on a loop over every smmu the domain in arm_smmu_mmu_notifier_get is
> attached to, which just at a glance looks headache inducing because of
> sva's piggybacking on the rid domain.)

Not every smmu, just the one you are *currently* attaching to. We
don't care if the *other* smmu's have different ASIDs, maybe they are
not using BTM, or won't use SVA.

We care that *our* smmu has the right ASID when we go to attach the
domain.

So the logic is not really any different, you already know the smmu
because it is attaching, and you do the same locking xarray stuff as
was done globally, just against this local smmu.

Jason
