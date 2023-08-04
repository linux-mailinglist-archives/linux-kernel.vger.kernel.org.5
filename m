Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A17770B4B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjHDV6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjHDV6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:58:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBCD180
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPkfFnrRcGScQ3SRMJRSBiaSVfAU7FSZE4FQ7oi6WyOLnSMa6W2YcbOjI2sFldKT4CtvNCAVXQ6PY9oUYBbvUWXlLGUMWPLEx5BC7QRsGS8YnqG3syomjvHu8aIcXZYx+4twnFcYnpEAZJ3WUNMNiQwyLn3tMYQkhIP7l5ybitS+nbMzZDgqOZEZSLPXHxK/w+MFOrwSZ9bOfnoJuVXMPTkQOXjHKFzjY3XPmMUD2eIjjr5hkM6yWYORG+VBFG7QivrGiHCP/AAZB5EdnYqfJwbv03yDFb2YLBFPIWN7Kc4tR+z81nhIlC0G2wxgdNedx72ZZvPXFaHgVy6HFDAj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3dvFLKsUdFB6fs+YFw7Tpb6+8mu8nMDXv2Ba5QlR6Q=;
 b=aIPc9ABdTklND7JKledf6CjXJi6PuJdBYyY/0VKvNCBLKoZZMh/OSDpsvaEaEBdzX5NOHPWJ7QTO7+uOQxFAcFRUrTuxaT6ZNZQXSlvOmqqtZEdrUdGLMoX1hGck3DMs404xufV5Oefk3zQtFdheE0B1CX5FSCwMD7nkrGUfBrqBaD0euNjy+ZDao9R01Gx6LVTtcrI/8VPcryGwBHBHHEhN7p+DKRsvqg9rxC8XIPbFc08uGyrbzXVEczvKKQrJXc/z4pMby/21HG+dCVAliPfhfn/vpe/FdMu2RIsCryQlHXKjU1Bxz6oyLdkPeKydbkCu9ZfI0VyLHQ7df+SPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3dvFLKsUdFB6fs+YFw7Tpb6+8mu8nMDXv2Ba5QlR6Q=;
 b=QXnjCQTd3SAA0bYRXRqZBpF3DNl5k+qPJ0ULRyBin3GuPcznGeE60DB93Q2KesRfR6YTCH0GucZ7OCxk1phfFL2kNn2VkCPMl1GckDya9uT3NFNpQuUyYi4YnbPhsrFX8BBtnolDSIA/y2wGH3yWNR5+cdn1CW4//Sq5xnugSfs9OpImunpVdGcMB9+OQfbtS/Be1SzCeMpTRYGs82GLV4IC7lHm0tSLXydvH0uEOPfRty8wepk58DNWN7wPX58YY1eX2CDwzkDxomA4LeKcErMAPpAlyyLd+m+zmvZXnYGQKZ6fT3zXPL+3MdbHvUi/hxGqssPT3vBCdsZ3vEMKMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Fri, 4 Aug 2023 21:58:15 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 21:58:15 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
Date:   Fri, 04 Aug 2023 17:58:12 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <60070B7E-5DC2-4CE1-8089-1A05DDDABA4C@nvidia.com>
In-Reply-To: <0d502268-ebdc-8462-d88c-e6a41578d9ae@redhat.com>
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
 <CAOUHufaHH3Ctu3JRHSbmebHJ7XPnBEWTQ4mwOo+MGXU9yKvwbA@mail.gmail.com>
 <5e595904-3dca-0e15-0769-7ed10975fd0d@arm.com>
 <b936041c-08a7-e844-19e7-eafc4ddf63b9@redhat.com>
 <CAOUHufafd4GNna2GKdSyQdW6CLVh0gxhNgeOc6t+ZOphwgw7tw@mail.gmail.com>
 <259ad8fc-c12b-69b9-ba16-adb9e3e6d672@redhat.com>
 <CAOUHufbbrDrSv2Ak0tyyaw7qrekkQ-p2vjCqWsXFG7b-+EP=5g@mail.gmail.com>
 <0d502268-ebdc-8462-d88c-e6a41578d9ae@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_41026AE8-6077-4A88-AA5B-62AA643DF619_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR0102CA0008.prod.exchangelabs.com
 (2603:10b6:207:18::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ee39f1-2e07-49a4-d8f8-08db9535e748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/2uy1vX5r0Ulae3sW/KMd4sMTm7RBwhNT/tI5NOt2wGm+by098f+4QnWj1nBrgTJvjgDIgaAIvlfNBrDVgVtnKO52/bkCe7cUvfqC4YLk1Jr3dYdj/XIUDBLVR38hnpCkh1Ocx3AOqrXPTVSJePRVDt2Yd4yqJD0TwPBTNXusMse9dI5C2hqfuW8I6sCv/XoUagUeKMrDsfFowfrdrK3UP3zv0IFSpvVBw4VR8LJGj6/xuQrCMMdIE0zCLlQgs6US/5r7kn2ISgkQ3Nd151Ffky0kGYFK4LAm4Qx04HzXOUcfm/hcgiojL+sRDis7b2oQJmPzKUjZIwj4oCYK/CO/BlOfooEIx0RvXpibLm6cfLXRVqE9HlsSyrJeQrVOd3ZLXMoQnGrKBDsJNJTmjb66XslFg+P60g828CdRObK0aVZEA9LJkhF+MsDbc4PYEJdiBbsAHUwGUqcad93pmO60hsyWaDVMtdjdI5MCJBSoYOc9k1iD060zrItBb4oGmMx/H5E96gTGkvS19jdFTe0YKr32zO6FLSKyf9l6v1cFJ4bqSEaNJN0OZXj37drY20eIYASL0MSnwfOL6Go1tBVVtaXTFTXR+BH5RYqd70MIgNaraIbgoV6pw3+hTyoprGhyVF68xJVo2qbT/zh/Spsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(186006)(1800799003)(451199021)(30864003)(2906002)(7416002)(235185007)(66899021)(5660300002)(66476007)(66556008)(66946007)(8676002)(83380400001)(41300700001)(8936002)(4326008)(316002)(6666004)(6916009)(36756003)(33656002)(33964004)(478600001)(6486002)(6512007)(54906003)(86362001)(2616005)(38100700002)(53546011)(26005)(6506007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0tESm05NUdFSlp4aHVQd2FPbS9FTDNJZ0czd21KSHJSQmFXQUJ0ekhsRHRH?=
 =?utf-8?B?aEZlNlJqZG54Y0RHQWF2MXM1WlRNU1NHbDFvcC9jbGpTeTBJY2h6cWVSc3Vn?=
 =?utf-8?B?aSt6eDIwVmZxc1ZaclRQeTBYQlZzTGZOdWhyTXFiUTZFaHB2VFdCbGR6Tmtu?=
 =?utf-8?B?VWVFUXZ0VEp2N3F1NDgyZ0tUYWFaNmgwZ3VvS0c2VlVjVmhqTy9RT3Zzek83?=
 =?utf-8?B?b08xL21iSU9HN0V1eFdIOEJnZUlmUHZBb2pOWkVtQmNrbkYxZjZZQy9zeFNU?=
 =?utf-8?B?bjArMS90S0pLU0oyN2JMM3pDWTkvMkN1SW5uYmlKZ05VNStzWit4eEp2WHRU?=
 =?utf-8?B?aWtuWUZkcU04d2hlWEQ2ci9PNWx0WW4ySEtOMGRTQUtiYmx1bEJtZUxQK0pw?=
 =?utf-8?B?dGk0bmFJakNEUEl4a0JiU0lwMURVVEgraExadTRVMXR6NEdabzVQVDA3MFo1?=
 =?utf-8?B?ZjQ0emE3NWhDMHJNSmw0STF0RDdyMUViWFUzYWVDUFVBM1lORnJVQVRtcGVW?=
 =?utf-8?B?S3pkQXpwb3JpcVVXM1o0VXo2WU8yQUZSdW1xR3pEVlMzcS9qTFl1Nko4SG5W?=
 =?utf-8?B?MDlhN0krZXV5Z1JnQXp3d2lBaU1NOGVUVjlOckhCa3ZGekRkaGQ1cFVTVlJk?=
 =?utf-8?B?aXRIWHhkZDJjeENuZSttY3lYcG50bFplWVBPalN6cmlvTGJqZHVCa09RckIz?=
 =?utf-8?B?SnJHR2dneXg0QkR6WHFJRm55YlFTQlBDSHBWKzlIYVZWV3JDbnBQWTdtME5F?=
 =?utf-8?B?alBrQk44bHNvcFRENVdCaWZFbEp4cXMrQSs0M3ZieWNGNjRlNHd1UWpWYjg5?=
 =?utf-8?B?TmNZUWtNVUZmQ3o1ODNTOUdlZ2lQc3NHUVJNVVc1MnNvWExUWVBKWHFlNEt1?=
 =?utf-8?B?d0lyZEszdnFEUGRmZE5Cd2lTSkZXYW5RRjdzUmoxYml1OXZUb0xJenl6WDdv?=
 =?utf-8?B?V0Q1SUtKZHFlQU9GQTVvNGlhQXk2aWNxTHNsZmIvd1E3L2RkRHorNm9idGYv?=
 =?utf-8?B?eHVlVWFzS0dqM3FaVlRyQWNudnFYSjZnY3RmWlA3WFF1UWU2RFVkcXhKbjFL?=
 =?utf-8?B?d3d5aUljaXJrWEh2QXZ3Mmk5YTY1cWt1RDgyayt5TU1VVWhhMTdkVVBIQXlH?=
 =?utf-8?B?TkxDOStBTVF3UTRGd3pDQzdkL3lIeWo3Y0NrMHZ6Zkx5di9aV09hVUFsYWdw?=
 =?utf-8?B?S0wwemt5NXVKdjRtWlJ6T2IrWnZMVXlWMlVTSjYwUC90YmJHWHh5K1ZPSTB0?=
 =?utf-8?B?ZXc3N1pVcjVwdFQ1czN4TzloU0laY1ZFVXJPdVFPTGk5eE9QaUZ4N0RCL1d2?=
 =?utf-8?B?ejBTekhsWGhhV0MwekZlWGtaSjR0Y0lPSFBEN1JVMHZWSHJnRER2TDJaMGsy?=
 =?utf-8?B?dGhsMWtxVklxMmowZm12eEJ0L2lVLzIwN0NQTGtHeDNGMjNIRmZoYTZzTm93?=
 =?utf-8?B?cVMrVFZNRW1KRENmc3hRcjY0MjFyMW5aL0VSa3NpcVRxRlc4ZEgxeVhYdWJi?=
 =?utf-8?B?c25sN1ZKSlBMTTVvUmEvMU1DdERNZ2ZUbzAzTzRmRllRRnBVZDRmYzVKcW5q?=
 =?utf-8?B?ZnNmTVZ2ZFdvYlBFVVd3S1ZzTk13NzBKQlUwdjhMd1BLekxhRmRqZHJvTGVV?=
 =?utf-8?B?WkZKR1NWVjY1c3lsQjFORXRySUtTbTRQa0U2QlJGL2NJdWZXY0VlNmxscDFE?=
 =?utf-8?B?aXlsM0xJOFpxeXJjaHU0aUtCNFphWkREM0l6UW9RUFozMzF5emdQSEtCOUdQ?=
 =?utf-8?B?dGJTL2J0SnBnRjBvZmNzcHFZOFBVdkN0OG1sSDJTejdEd3R2bnRsR0FSeEtm?=
 =?utf-8?B?UStBRGxwMVBCNUJrUFVYeTlZZWFMMUVBYVMyMTg4M2tvWHNBRlhZU3pENCtF?=
 =?utf-8?B?dFN2NmdjcCtqOUhLU0phQ2pZRXBMNGwzMnFCUHZOY1hjUkhuVmJBSkpQZE9i?=
 =?utf-8?B?NHhJZGxWb0taTGJxcE9oMTVHcHd5N0lEbGJTY2w4ZDZpcnB3aFBTTTlpaTFH?=
 =?utf-8?B?N3NxaXB6K1Z3L053MTRQSXEvUjgzZEV5VlBEZ2JHazVsdEFUdE9kSXE5ZWt4?=
 =?utf-8?B?ME56a0dpalNaNmg0d0RMQWN6dWVLYm56cmpuamtJVEFoNERIMFN6aU5pOVNK?=
 =?utf-8?Q?0kWk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ee39f1-2e07-49a4-d8f8-08db9535e748
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:58:15.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+KqhOcTYwMp+YROCwG0a6xiRKIt7uRml+UY2rBV5nLDPEyQ6Gkjy41b73K6dzP+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_41026AE8-6077-4A88-AA5B-62AA643DF619_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4 Aug 2023, at 17:30, David Hildenbrand wrote:

> On 04.08.23 23:26, Yu Zhao wrote:
>> On Fri, Aug 4, 2023 at 3:13=E2=80=AFPM David Hildenbrand <david@redhat=
=2Ecom> wrote:
>>>
>>> On 04.08.23 23:00, Yu Zhao wrote:
>>>> On Fri, Aug 4, 2023 at 2:23=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
>>>>>
>>>>> On 04.08.23 10:27, Ryan Roberts wrote:
>>>>>> On 04/08/2023 00:50, Yu Zhao wrote:
>>>>>>> On Thu, Aug 3, 2023 at 6:43=E2=80=AFAM Ryan Roberts <ryan.roberts=
@arm.com> wrote:
>>>>>>>>
>>>>>>>> + Kirill
>>>>>>>>
>>>>>>>> On 26/07/2023 10:51, Ryan Roberts wrote:
>>>>>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memo=
ry to be
>>>>>>>>> allocated in large folios of a determined order. All pages of t=
he large
>>>>>>>>> folio are pte-mapped during the same page fault, significantly =
reducing
>>>>>>>>> the number of page faults. The number of per-page operations (e=
=2Eg. ref
>>>>>>>>> counting, rmap management lru list management) are also signifi=
cantly
>>>>>>>>> reduced since those ops now become per-folio.
>>>>>>>>>
>>>>>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kco=
nfig,
>>>>>>>>> which defaults to disabled for now; The long term aim is for th=
is to
>>>>>>>>> defaut to enabled, but there are some risks around internal
>>>>>>>>> fragmentation that need to be better understood first.
>>>>>>>>>
>>>>>>>>> When enabled, the folio order is determined as such: For a vma,=
 process
>>>>>>>>> or system that has explicitly disabled THP, we continue to allo=
cate
>>>>>>>>> order-0. THP is most likely disabled to avoid any possible inte=
rnal
>>>>>>>>> fragmentation so we honour that request.
>>>>>>>>>
>>>>>>>>> Otherwise, the return value of arch_wants_pte_order() is used. =
For vmas
>>>>>>>>> that have not explicitly opted-in to use transparent hugepages =
(e.g.
>>>>>>>>> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), t=
hen
>>>>>>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichev=
er is
>>>>>>>>> bigger). This allows for a performance boost without requiring =
any
>>>>>>>>> explicit opt-in from the workload while limitting internal
>>>>>>>>> fragmentation.
>>>>>>>>>
>>>>>>>>> If the preferred order can't be used (e.g. because the folio wo=
uld
>>>>>>>>> breach the bounds of the vma, or because ptes in the region are=
 already
>>>>>>>>> mapped) then we fall back to a suitable lower order; first
>>>>>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>>>>>
>>>>>>>>
>>>>>>>> ...
>>>>>>>>
>>>>>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>>>>>> +             (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) -=
 PAGE_SHIFT)
>>>>>>>>> +
>>>>>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>>>>>> +{
>>>>>>>>> +     int order;
>>>>>>>>> +
>>>>>>>>> +     /*
>>>>>>>>> +      * If THP is explicitly disabled for either the vma, the =
process or the
>>>>>>>>> +      * system, then this is very likely intended to limit int=
ernal
>>>>>>>>> +      * fragmentation; in this case, don't attempt to allocate=
 a large
>>>>>>>>> +      * anonymous folio.
>>>>>>>>> +      *
>>>>>>>>> +      * Else, if the vma is eligible for thp, allocate a large=
 folio of the
>>>>>>>>> +      * size preferred by the arch. Or if the arch requested a=
 very small
>>>>>>>>> +      * size or didn't request a size, then use PAGE_ALLOC_COS=
TLY_ORDER,
>>>>>>>>> +      * which still meets the arch's requirements but means we=
 still take
>>>>>>>>> +      * advantage of SW optimizations (e.g. fewer page faults)=
=2E
>>>>>>>>> +      *
>>>>>>>>> +      * Finally if thp is enabled but the vma isn't eligible, =
take the
>>>>>>>>> +      * arch-preferred size and limit it to ANON_FOLIO_MAX_ORD=
ER_UNHINTED.
>>>>>>>>> +      * This ensures workloads that have not explicitly opted-=
in take benefit
>>>>>>>>> +      * while capping the potential for internal fragmentation=
=2E
>>>>>>>>> +      */
>>>>>>>>> +
>>>>>>>>> +     if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>>>>>>>> +         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>>>>>>>> +         !hugepage_flags_enabled())
>>>>>>>>> +             order =3D 0;
>>>>>>>>> +     else {
>>>>>>>>> +             order =3D max(arch_wants_pte_order(), PAGE_ALLOC_=
COSTLY_ORDER);
>>>>>>>>> +
>>>>>>>>> +             if (!hugepage_vma_check(vma, vma->vm_flags, false=
, true, true))
>>>>>>>>> +                     order =3D min(order, ANON_FOLIO_MAX_ORDER=
_UNHINTED);
>>>>>>>>> +     }
>>>>>>>>> +
>>>>>>>>> +     return order;
>>>>>>>>> +}
>>>>>>>>
>>>>>>>>
>>>>>>>> Hi All,
>>>>>>>>
>>>>>>>> I'm writing up the conclusions that we arrived at during discuss=
ion in the THP
>>>>>>>> meeting yesterday, regarding linkage with exiting THP ABIs. It w=
ould be great if
>>>>>>>> I can get explicit "agree" or disagree + rationale from at least=
 David, Yu and
>>>>>>>> Kirill.
>>>>>>>>
>>>>>>>> In summary; I think we are converging on the approach that is al=
ready coded, but
>>>>>>>> I'd like confirmation.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> The THP situation today
>>>>>>>> -----------------------
>>>>>>>>
>>>>>>>>     - At system level: THP can be set to "never", "madvise" or "=
always"
>>>>>>>>     - At process level: THP can be "never" or "defer to system s=
etting"
>>>>>>>>     - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
>>>>>>>>
>>>>>>>> That gives us this table to describe how a page fault is handled=
, according to
>>>>>>>> process state (columns) and vma flags (rows):
>>>>>>>>
>>>>>>>>                    | never     | madvise   | always
>>>>>>>> ----------------|-----------|-----------|-----------
>>>>>>>> no hint         | S         | S         | THP>S
>>>>>>>> MADV_HUGEPAGE   | S         | THP>S     | THP>S
>>>>>>>> MADV_NOHUGEPAGE | S         | S         | S
>>>>>>>>
>>>>>>>> Legend:
>>>>>>>> S       allocate single page (PTE-mapped)
>>>>>>>> LAF     allocate lage anon folio (PTE-mapped)
>>>>>>>> THP     allocate THP-sized folio (PMD-mapped)
>>>>>>>>>          fallback (usually because vma size/alignment insuffici=
ent for folio)
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Principles for Large Anon Folios (LAF)
>>>>>>>> --------------------------------------
>>>>>>>>
>>>>>>>> David tells us there are use cases today (e.g. qemu live migrati=
on) which use
>>>>>>>> MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explic=
itly faulted"
>>>>>>>> and these use cases will break (i.e. functionally incorrect) if =
this request is
>>>>>>>> not honoured.
>>>>>>>
>>>>>>> I don't remember David saying this. I think he was referring to U=
FFD,
>>>>>>> not MADV_NOHUGEPAGE, when discussing what we need to absolutely
>>>>>>> respect.
>>>>>>
>>>>>> My understanding was that MADV_NOHUGEPAGE was being applied to reg=
ions *before*
>>>>>> UFFD was being registered, and the app relied on MADV_NOHUGEPAGE t=
o not back any
>>>>>> unfaulted pages. It's not completely clear to me how not honouring=

>>>>>> MADV_NOHUGEPAGE would break things though. David?
>>>>>
>>>>> Sorry, I'm still lagging behind on some threads.
>>>>>
>>>>> Imagine the following for VM postcopy live migration:
>>>>>
>>>>> (1) Set MADV_NOHUGEPAGE on guest memory and discard all memory (e.g=
=2E,
>>>>>        MADV_DONTNEED), to start with a clean slate.
>>>>> (2) Migrates some pages during precopy from the source and stores t=
hem
>>>>>        into guest memory on the destination. Some of the memory loc=
ations
>>>>>        will have pages populated.
>>>>> (3) At some point, decide to enable postcopy: enable userfaultfd on=

>>>>>        guest memory.
>>>>> (4) Discard *selected* pages again that have been dirtied in the
>>>>>        meantime on the source. These are pages that have been migra=
ted
>>>>>        previously.
>>>>> (5) Start running the VM on the destination.
>>>>> (6) Anything that's not populated will trigger userfaultfd missing
>>>>>        faults. Then, you can request them from the source and place=
 them.
>>>>>
>>>>> Assume you would populate more than required during 2), you can end=
 up
>>>>> not getting userfaultfd faults during 4) and corrupt your guest sta=
te.
>>>>> It works if during (2) you migrated all guest memory, or if during =
4)
>>>>> you zap everything that still needs migr
>>>>
>>>> I see what you mean now. Thanks.
>>>>
>>>> Yes, in this case we have to interpret MADV_NOHUGEPAGE as nothing >4=
KB.
>>>
>>> Note that it's still even unclear to me why we want to *not* call the=
se
>>> things THP. It would certainly make everything less confusing if we c=
all
>>> them THP, but with additional attributes.
>>>
>>> I think that is one of the first things we should figure out because =
it
>>> also indirectly tells us what all these toggles mean and how/if we
>>> should redefine them (and if they even apply).
>>>
>>> Currently THP =3D=3D PMD size
>>>
>>> In 2016, Hugh already envisioned PUD/PGD THP (see 49920d28781d ("mm:
>>> make transparent hugepage size public")) when he explicitly exposed
>>> "hpage_pmd_size". Not "hpage_size".
>>>
>>> For hugetlb on arm64 we already support various sizes that are < PMD
>>> size and *not* call them differently. It's a huge(tlb) page. Sometime=
s
>>> we refer to them as cont-PTE hugetlb pages.
>>>
>>>
>>> So, nowadays we do have "PMD-sized THP", someday we might have
>>> "PUD-sized THP". Can't we come up with a name to describe sub-PMD THP=
?
>>>
>>> Is it really of value if we invent a new term for them? Yes, I was no=
t
>>> enjoying "Flexible THP".
>>>
>>>
>>> Once we figured that out, we should figure out if MADV_HUGEPAGE meant=

>>> "only PMD-sized THP" or anything else?
>>>
>>> Also, we can then figure out if MADV_NOHUGEPAGE meant "only PMD-sized=

>>> THP" or anything else?
>>>
>>>
>>> The simplest approach to me would be "they imply any THP, and once we=

>>> need more tunables we might add some", similar to what Kirill also ra=
ised.
>>>
>>>
>>> Again, it's all unclear to me at this point and I'm happy to hear
>>> opinions, because I really don't know.
>>
>> I agree these points require more discussion. But I don't think we
>> need to conclude them now, unless they cause correctness issues like
>> ignoring MADV_NOHUGEPAGE would. My concern is that if we decide to go
>> with "they imply any THP" and *expose this to userspace now*, we might=

>> regret later.
>
> If we don't think they are THP, probably MADV_NOHUGEPAGE should not app=
ly and we should be ready to find other ways to deal with the mess we eve=
ntually create. If we want to go down that path, sure.
>
> If they are THP, to me there is not really a question if MADV_NOHUGEPAG=
E applies to them or not. Unless we want to build a confusing piece of so=
ftware ;)

I think it is good to call them THP, since they are transparent huge (>or=
der-0) pages.
But the concern is that before we have a reasonable management policy for=
 order>0 &&
order<9 THPs, mixing them with existing order-9 THP might give user unexp=
ected
performance outcome. Unless we are sure they will always performance impr=
ovement,
we might repeat the old THP path, namely users begin to disable THP by de=
fault
to avoid unexpected performance hiccup. That is the reason Yu wants to se=
parate
LAF from THP at the moment.

Maybe call it THP (experimental) for now and merge it to THP when we have=
 a stable
policy. For knobs, we might add "any-order" to the existing "never", "mad=
vise"
and another interface to specify max hinted order (enforcing <9) for "any=
-order".
Later, we can allow users to specify any max hinted order, including 9. J=
ust an
idea.


--
Best Regards,
Yan, Zi

--=_MailMate_41026AE8-6077-4A88-AA5B-62AA643DF619_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTNdHQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUluQP/26Vz8CILHMklnlPOrqgGNtCwW4T37dt8sTI
tSLFluXtYLyUYXTF5H4j/79kCIVFuDPTTr6/f9LlLLdt8hRad5HPNs/ALp5h0Ke8
negVBNkvNTM2k01XKNRU2sMI7XQTsG9LyRFPadLiCUI3cr8wKErc4fxYlmHd3VYA
3HM8LD6y0mVb2Yg56oJq995ArxVn9plaeZU0nDu0yvuuHDfMjnQUFmyBnYtkz82Z
41vf6Z2vdO4cPNeu4NEwjmycgn04XNZ0gwBhRIqZW9ZO8g8VOLylq7zKlLfUmIfb
Nm8SjffbAGNc8j5rDqZTNNtYFrnrX0cSf1K29qQzym0+0PF1gjIlyOqMZee5vXfZ
7MnDjQTHhKh2PN5N4BYFpQMpsgFb9ZhYKznY1lNO/20sM1M+82ziPah1Rx90TxAF
vULUE/J3tseNAn8nOoPMZjdCXI7spK2RlhW183G6L/R4bx9dy+/KdiiktWwvo0YS
WWW8ZHiwMZ5iA+ReNvYVBOQYLXnQrtExgY1y0vV1C7Od85FbtcsgN969+STkC6El
hpkP78mawNHuUWJ5I9GMbfY3NiUDbM68xgkUnh/4u2DFp9g/jvQ7bJsRddq3FF5q
vKmnNgYof37lyKTkoPhGsgZVHEzB5MPhc5pkXhqc/q03sM91vyVvF6jgYQwyIY0j
YhsGmQka
=9Iq/
-----END PGP SIGNATURE-----

--=_MailMate_41026AE8-6077-4A88-AA5B-62AA643DF619_=--
