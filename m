Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C94772D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjHGSKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjHGSKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:10:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EDD171E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwI8xVaR8Zq7SEDiVRUVHTm+k7iPhwvzD10dnarwXT4QmkFB62QCYrLXeTdrwkY6STYW28lMk+ZuigMbDIEr+Cn8uNuRBEXlBxrHcsGR8sSKarG5Mv2VrSGyqNpFp/di56R6evqR3a1EHA1MGFFyy0fmG+mgz1lC+lyOMvjQ/S6qbCqQcCySMG8hF9YgCK2ooioyTTvz8WIu+G2nv5vNPqS+v6L2CXh8FwDub695nIliCPeaOKdIHaM1lAh0RDsU8lnZ5a/pg3bj4BJuXXk0RzZQIfG870ltQbLIf+UU+0qFns7Z227Q7hS18TAP7+eDQo7SUFeO3XlM45nToVxe9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j922tchteBBfjegCaiznGaJgK5iGXRUc9YEmqMJE/iE=;
 b=UCQoG1YFaaDDMimflNSvsoVqTfsqA8Zz7/ZaLEU+KTQixgMNdw83nYsinoZxvg5RiRvIDJwWvkLgdNOlkjjFARR2ybsO+po/tZHjofvNyiD7pqANe3fX32R6DI+16xYp983wgkDJfbHl37Pp8Pz0/3nIzMYpJPvkrICnmvzOhf0HWU7H2q8xX2pQyklXwWlfFN7xKL+O/hBeqZ7uuCtp18DxT0Ih4u7hutsw3A/Z8ra8TsnK/SrNQcJshVYBLoCkWptERLBnMsyvsAxRxL0PSFdH1rJAajKgNk3MPCWA4c9+7l9EXlFRruFFgrtV8DSg+skRERUPTmnBtdQA+S4yvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j922tchteBBfjegCaiznGaJgK5iGXRUc9YEmqMJE/iE=;
 b=lx+s7zX62mBWQYNzJspR8MOjmK1hyWef9xcAcvOBKMA+nm+n1NYPb0qQHuKflFX/XGvh5jFdfqiTD45apKpLIppicrdnc24qC/aJrrsFi8iNLo1V4AycHxqf2fkK9DoPllEWLYS6jR3KjtuG8Jl6yw7T5NSU53OkU1TykEhfBOcBydN2Dyak9Z1PWh0zruZ0oibNQ4yUvSwpZn2n4plC+C0QoafPQOz4xdPq0kEc/ZjLUBN3IDtcYg2mwPa26BiKIB2xuIQGaFp871ez7b8OG+TSej1Fovsm3XwY2JsdTElae6DC9xGzxmYLmA2m9/74HDHS1DOJWZjyORiFlCT3yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.26; Mon, 7 Aug 2023 18:10:25 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 18:10:28 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
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
Date:   Mon, 07 Aug 2023 14:10:24 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <26024E94-5CC2-46A2-A6AA-6CC9440F97BB@nvidia.com>
In-Reply-To: <9f27bf92-baab-11e2-0618-6fc6f5da1d38@arm.com>
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
 <60070B7E-5DC2-4CE1-8089-1A05DDDABA4C@nvidia.com>
 <5781b962-9e0b-1f61-7eb7-9621ace76d90@intel.com>
 <9f27bf92-baab-11e2-0618-6fc6f5da1d38@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5B692EBE-5150-4F0F-AB90-F134C256CD55_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0437.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::22) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH0PR12MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: e8229016-e6e7-4723-cac4-08db9771945f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJGmvM/bqiKEPKZL0nVwpeYs+NjJRYXy/uuXQi6r8c0u6c+6bMTV1DDo92jQmlGQZXdbzQq1Arva+inhnYw31vcWo7v+ua9oxImGrXvP6NLi01hWChT/qCktHvAsJ0H3yKxuVvv00Uz/khWhXc0YwdUdI+gwwRPB6YHIKN80KwSrmZLIyO5Mwp7BPu4tOKKPb0XuK14NVxRWdeZ0z8ecSfSQWH0zKjN5JNK7yvlJnuyJkXg0tPDkpwP4Sex0rZepkO5ab1m4fvW+fbByBz8ioquvp7Vnm9GsjJP+uM282iJiZkTUWhpCpOi9EatYKrtPvx8OwWlizvhFaR+iY2nQdSXRRZFCaCdKK347g9itSHHf+oDGAvj0mLo7z0pbs9shOz6mZEoVNP78w4mHJ18OxsdjQhsRR9V3f3oVxc+E400Ld3q0mBz4A7jCnI/Ki00SjyDnRyMugPnCsrR3hLXQdSeH/F/o2JzAMAZJIWG0G0nXWS0mShvdxzrvBx6LLD7H1OR26lj0AS25ejNz5c/JmiiZhEytDbGZfuBWyhdLDyfHjm9+JZfiFzy2Npsx49hiJbMKj4kgF7V4Uh4FSyicZEK140+ZEMFb2R+pyKuuGZzy/abPlT6uOHZShYcOSu9BAuMP0T50L/191FP13gak2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(6916009)(86362001)(38100700002)(54906003)(66946007)(6666004)(478600001)(66556008)(66476007)(6486002)(33964004)(33656002)(53546011)(6506007)(41300700001)(26005)(235185007)(8676002)(8936002)(66899021)(2906002)(30864003)(83380400001)(7416002)(5660300002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RCtRYmtQTWF2V0dta0ZIQXlMdmQ5UHhKM1VLcFJUMmp6RHRQc0JlNTF4eXhq?=
 =?utf-8?B?NUpUcVkvZFMxSVMyZW1lK2RFV01ublYvSGsrMmpHTWFmSVFUbGdNaWhtZDlF?=
 =?utf-8?B?bXFiRFVlaDBuSzJJNy9VQ1gvVmNjU2FmUWxFOUh1Tmw3SXhoM0o2dXNyaFNV?=
 =?utf-8?B?Q0dYdURxQTZWTG9WMHc2czVkYU1xNXdKY2NseTIzbXFUaTR0bGNSYWNBcG5a?=
 =?utf-8?B?Nk02TmZkRHg2RWg1TFVxT1B2T04wMTR1d0tFYldOeTdUY1lMa05OMngwQ2Zn?=
 =?utf-8?B?SklORi9KQmhkL2ZVem81Y2F2MkM3Um9HN1VSUnJDZ3BZVS9UMjJHcVFzZmV6?=
 =?utf-8?B?aXZjSTdGYWhMdnVZWjhWQmxwb0Zpb1JyWWhOeTNlNTVhMW82c0xtVzRSb0tM?=
 =?utf-8?B?a0ZRUUFxbzNmNGVrLzBBSW5sQ3RDKzlmZEpmUkZpbEFoMk5VMldBNWZzZlF2?=
 =?utf-8?B?cDNsd0d5RDNRNG5rRUttWGQxRVpqZS9ZM1Rja2xRT2MzSjAyVkl5T0kybzAz?=
 =?utf-8?B?MmxQMzRqTENmaHlnRnZGSzQrbEVheWxWRTRsOGIzRzBDSndXQzBQaXlteW9N?=
 =?utf-8?B?aTdtUlU5QkhyN0dQcS81U24vemdpRklTc0RxN2tHOHZXTFZvbjAwUGdFSnk2?=
 =?utf-8?B?ZEpaZkdXM2hRZFhBVDg1YUNXSUpldUxQbDU3d01qZ0N3QW56RGJ6WWZWakdK?=
 =?utf-8?B?eU9nbk0waU1xYUpabEZxTUpOa3V3L2QvKzBGU3oxbUdGMGlESXk5eVlYcWJW?=
 =?utf-8?B?RTZ1VnhxMTFpcGlvYUloUVJha3VSUW81YWRIYTJVbzN5T3ZEenpYRUtRQlRB?=
 =?utf-8?B?WTEyV2lMTHFOVVpjdmdMZld1c3JGWlBsZlBrSks3VUtZK2NuSTFHeWFwSmpa?=
 =?utf-8?B?UlRRWUgvd1Z1STF3OXY0NThXaFJKMnVtYnZZdHBnalJGdHZvNGVzOHNlQjFE?=
 =?utf-8?B?eVlSdG9NdjBrdExRQmQ2elk1NUQ4V3BPMXdJbDJDK0dXMnBDdHpTQkVJcHRK?=
 =?utf-8?B?cmtMYWV6TVZiL2txd0NOM0hHZXVXbkFhQURyVFIxdUduUFBKYkpqVC9TREFK?=
 =?utf-8?B?SXIweUNYVzhxTjlZeWFheE9xOGNtQm84RTd4Slc1Sy85ekQwSnB1MXhDb3Z6?=
 =?utf-8?B?S05WQWJZcXFzL01pNmsvZmVXVmYxWmpGZUgwaEthSkNzZUtHWEpsRzgwUUFr?=
 =?utf-8?B?cmFZbHdleWxZQlM1a3A4dHNBdW14akJ3S2kzNXdGSGZOenF1RWV5UmozQmRj?=
 =?utf-8?B?MzkxS2g0Q2pYbW12VUFLTjZJYk9TTVpmbXZjZnJjQkVxT0xzN0IrZG1zNG5P?=
 =?utf-8?B?TlpCVStrM2VkMVpWMHRxVkx5c0J4OE5ZL3BWWWlUSmlKSHNRZVJVSk5udG9U?=
 =?utf-8?B?Q0tZek5rbEtsUTdQM2l0ak93aitMVkVDemtLWGw4akJxTndyckwzZGJwT2Ju?=
 =?utf-8?B?K0R5U1gwdFBQWnlybWdPck11WXJmK3U3R09QcHhDbVdMcURZWkd4cHRDaWpT?=
 =?utf-8?B?R1hKc0I0OTk1c0FUbHpRMWRLMDVHR0NRaTYyblVZcEVjTXRJN29SRnZwaVJW?=
 =?utf-8?B?RnVITlBvR1pJa0d4QUJyc1hTUEpZREltb1h3bDhISU5xblByTW1lc1U3VFJ4?=
 =?utf-8?B?OFZNRDJjOWFzS2RhU01MYTlFU0duZnQ5TWlIUjNIRzBoR2t2Q1krVUpuVmY0?=
 =?utf-8?B?dnJPazFxWUNDUmFiMHQ4SG03VVlJQ0VycFI0SHcrcWJhV21YRjE3Y2UrY20w?=
 =?utf-8?B?bUVRWjk5cmovb09ycDU3TUE5bmw5aGc5Z1JtTFBWMUNaNXJJT3p3T2RENWRP?=
 =?utf-8?B?U1NxOE02ZlM0QVRacmRaY3o0U3FUWVhKakMwY1FkYVNPN0NCUlZCSUZzZGpC?=
 =?utf-8?B?TTcvZGtQbmpPY2dnMDNMWWFQclVRbHV3b3MzMzBzRFJab0JjdldPdjNPL0FM?=
 =?utf-8?B?ZFN3ZWRaU3NtZ3BaWjdSeEltL0VTZTdydDg3S3RweEFpMWJHRGdzNHdja0hY?=
 =?utf-8?B?K2V2NXFGcVAxY3NhSGpFcVJOUTVOb0hDeGhoTHR2ODV5TnR5VUNIdlBxenla?=
 =?utf-8?B?MEZ4SjdOeWNMblgrWDd5OTlXL3hOWjV4QVBiZ0k3c3N0cDNOeXg4RGhoUWM1?=
 =?utf-8?Q?GDTU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8229016-e6e7-4723-cac4-08db9771945f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 18:10:28.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWyuzT+yoK+dXFbjKToRW6BXe3yxu5aR1DLqkEmdDpfCaBW0azj9E7phKSGoFZzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5B692EBE-5150-4F0F-AB90-F134C256CD55_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7 Aug 2023, at 13:45, Ryan Roberts wrote:

> On 05/08/2023 03:50, Yin, Fengwei wrote:
>>
>>
>> On 8/5/2023 5:58 AM, Zi Yan wrote:
>>> On 4 Aug 2023, at 17:30, David Hildenbrand wrote:
>>>
>>>> On 04.08.23 23:26, Yu Zhao wrote:
>>>>> On Fri, Aug 4, 2023 at 3:13=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
>>>>>>
>>>>>> On 04.08.23 23:00, Yu Zhao wrote:
>>>>>>> On Fri, Aug 4, 2023 at 2:23=E2=80=AFPM David Hildenbrand <david@r=
edhat.com> wrote:
>>>>>>>>
>>>>>>>> On 04.08.23 10:27, Ryan Roberts wrote:
>>>>>>>>> On 04/08/2023 00:50, Yu Zhao wrote:
>>>>>>>>>> On Thu, Aug 3, 2023 at 6:43=E2=80=AFAM Ryan Roberts <ryan.robe=
rts@arm.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> + Kirill
>>>>>>>>>>>
>>>>>>>>>>> On 26/07/2023 10:51, Ryan Roberts wrote:
>>>>>>>>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous m=
emory to be
>>>>>>>>>>>> allocated in large folios of a determined order. All pages o=
f the large
>>>>>>>>>>>> folio are pte-mapped during the same page fault, significant=
ly reducing
>>>>>>>>>>>> the number of page faults. The number of per-page operations=
 (e.g. ref
>>>>>>>>>>>> counting, rmap management lru list management) are also sign=
ificantly
>>>>>>>>>>>> reduced since those ops now become per-folio.
>>>>>>>>>>>>
>>>>>>>>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO =
Kconfig,
>>>>>>>>>>>> which defaults to disabled for now; The long term aim is for=
 this to
>>>>>>>>>>>> defaut to enabled, but there are some risks around internal
>>>>>>>>>>>> fragmentation that need to be better understood first.
>>>>>>>>>>>>
>>>>>>>>>>>> When enabled, the folio order is determined as such: For a v=
ma, process
>>>>>>>>>>>> or system that has explicitly disabled THP, we continue to a=
llocate
>>>>>>>>>>>> order-0. THP is most likely disabled to avoid any possible i=
nternal
>>>>>>>>>>>> fragmentation so we honour that request.
>>>>>>>>>>>>
>>>>>>>>>>>> Otherwise, the return value of arch_wants_pte_order() is use=
d. For vmas
>>>>>>>>>>>> that have not explicitly opted-in to use transparent hugepag=
es (e.g.
>>>>>>>>>>>> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE)=
, then
>>>>>>>>>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whic=
hever is
>>>>>>>>>>>> bigger). This allows for a performance boost without requiri=
ng any
>>>>>>>>>>>> explicit opt-in from the workload while limitting internal
>>>>>>>>>>>> fragmentation.
>>>>>>>>>>>>
>>>>>>>>>>>> If the preferred order can't be used (e.g. because the folio=
 would
>>>>>>>>>>>> breach the bounds of the vma, or because ptes in the region =
are already
>>>>>>>>>>>> mapped) then we fall back to a suitable lower order; first
>>>>>>>>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> ...
>>>>>>>>>>>
>>>>>>>>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>>>>>>>>> +             (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)=
) - PAGE_SHIFT)
>>>>>>>>>>>> +
>>>>>>>>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +     int order;
>>>>>>>>>>>> +
>>>>>>>>>>>> +     /*
>>>>>>>>>>>> +      * If THP is explicitly disabled for either the vma, t=
he process or the
>>>>>>>>>>>> +      * system, then this is very likely intended to limit =
internal
>>>>>>>>>>>> +      * fragmentation; in this case, don't attempt to alloc=
ate a large
>>>>>>>>>>>> +      * anonymous folio.
>>>>>>>>>>>> +      *
>>>>>>>>>>>> +      * Else, if the vma is eligible for thp, allocate a la=
rge folio of the
>>>>>>>>>>>> +      * size preferred by the arch. Or if the arch requeste=
d a very small
>>>>>>>>>>>> +      * size or didn't request a size, then use PAGE_ALLOC_=
COSTLY_ORDER,
>>>>>>>>>>>> +      * which still meets the arch's requirements but means=
 we still take
>>>>>>>>>>>> +      * advantage of SW optimizations (e.g. fewer page faul=
ts).
>>>>>>>>>>>> +      *
>>>>>>>>>>>> +      * Finally if thp is enabled but the vma isn't eligibl=
e, take the
>>>>>>>>>>>> +      * arch-preferred size and limit it to ANON_FOLIO_MAX_=
ORDER_UNHINTED.
>>>>>>>>>>>> +      * This ensures workloads that have not explicitly opt=
ed-in take benefit
>>>>>>>>>>>> +      * while capping the potential for internal fragmentat=
ion.
>>>>>>>>>>>> +      */
>>>>>>>>>>>> +
>>>>>>>>>>>> +     if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>>>>>>>>>>> +         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>>>>>>>>>>> +         !hugepage_flags_enabled())
>>>>>>>>>>>> +             order =3D 0;
>>>>>>>>>>>> +     else {
>>>>>>>>>>>> +             order =3D max(arch_wants_pte_order(), PAGE_ALL=
OC_COSTLY_ORDER);
>>>>>>>>>>>> +
>>>>>>>>>>>> +             if (!hugepage_vma_check(vma, vma->vm_flags, fa=
lse, true, true))
>>>>>>>>>>>> +                     order =3D min(order, ANON_FOLIO_MAX_OR=
DER_UNHINTED);
>>>>>>>>>>>> +     }
>>>>>>>>>>>> +
>>>>>>>>>>>> +     return order;
>>>>>>>>>>>> +}
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Hi All,
>>>>>>>>>>>
>>>>>>>>>>> I'm writing up the conclusions that we arrived at during disc=
ussion in the THP
>>>>>>>>>>> meeting yesterday, regarding linkage with exiting THP ABIs. I=
t would be great if
>>>>>>>>>>> I can get explicit "agree" or disagree + rationale from at le=
ast David, Yu and
>>>>>>>>>>> Kirill.
>>>>>>>>>>>
>>>>>>>>>>> In summary; I think we are converging on the approach that is=
 already coded, but
>>>>>>>>>>> I'd like confirmation.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> The THP situation today
>>>>>>>>>>> -----------------------
>>>>>>>>>>>
>>>>>>>>>>>     - At system level: THP can be set to "never", "madvise" o=
r "always"
>>>>>>>>>>>     - At process level: THP can be "never" or "defer to syste=
m setting"
>>>>>>>>>>>     - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
>>>>>>>>>>>
>>>>>>>>>>> That gives us this table to describe how a page fault is hand=
led, according to
>>>>>>>>>>> process state (columns) and vma flags (rows):
>>>>>>>>>>>
>>>>>>>>>>>                    | never     | madvise   | always
>>>>>>>>>>> ----------------|-----------|-----------|-----------
>>>>>>>>>>> no hint         | S         | S         | THP>S
>>>>>>>>>>> MADV_HUGEPAGE   | S         | THP>S     | THP>S
>>>>>>>>>>> MADV_NOHUGEPAGE | S         | S         | S
>>>>>>>>>>>
>>>>>>>>>>> Legend:
>>>>>>>>>>> S       allocate single page (PTE-mapped)
>>>>>>>>>>> LAF     allocate lage anon folio (PTE-mapped)
>>>>>>>>>>> THP     allocate THP-sized folio (PMD-mapped)
>>>>>>>>>>>>          fallback (usually because vma size/alignment insuff=
icient for folio)
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Principles for Large Anon Folios (LAF)
>>>>>>>>>>> --------------------------------------
>>>>>>>>>>>
>>>>>>>>>>> David tells us there are use cases today (e.g. qemu live migr=
ation) which use
>>>>>>>>>>> MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not exp=
licitly faulted"
>>>>>>>>>>> and these use cases will break (i.e. functionally incorrect) =
if this request is
>>>>>>>>>>> not honoured.
>>>>>>>>>>
>>>>>>>>>> I don't remember David saying this. I think he was referring t=
o UFFD,
>>>>>>>>>> not MADV_NOHUGEPAGE, when discussing what we need to absolutel=
y
>>>>>>>>>> respect.
>>>>>>>>>
>>>>>>>>> My understanding was that MADV_NOHUGEPAGE was being applied to =
regions *before*
>>>>>>>>> UFFD was being registered, and the app relied on MADV_NOHUGEPAG=
E to not back any
>>>>>>>>> unfaulted pages. It's not completely clear to me how not honour=
ing
>>>>>>>>> MADV_NOHUGEPAGE would break things though. David?
>>>>>>>>
>>>>>>>> Sorry, I'm still lagging behind on some threads.
>>>>>>>>
>>>>>>>> Imagine the following for VM postcopy live migration:
>>>>>>>>
>>>>>>>> (1) Set MADV_NOHUGEPAGE on guest memory and discard all memory (=
e.g.,
>>>>>>>>        MADV_DONTNEED), to start with a clean slate.
>>>>>>>> (2) Migrates some pages during precopy from the source and store=
s them
>>>>>>>>        into guest memory on the destination. Some of the memory =
locations
>>>>>>>>        will have pages populated.
>>>>>>>> (3) At some point, decide to enable postcopy: enable userfaultfd=
 on
>>>>>>>>        guest memory.
>>>>>>>> (4) Discard *selected* pages again that have been dirtied in the=

>>>>>>>>        meantime on the source. These are pages that have been mi=
grated
>>>>>>>>        previously.
>>>>>>>> (5) Start running the VM on the destination.
>>>>>>>> (6) Anything that's not populated will trigger userfaultfd missi=
ng
>>>>>>>>        faults. Then, you can request them from the source and pl=
ace them.
>>>>>>>>
>>>>>>>> Assume you would populate more than required during 2), you can =
end up
>>>>>>>> not getting userfaultfd faults during 4) and corrupt your guest =
state.
>>>>>>>> It works if during (2) you migrated all guest memory, or if duri=
ng 4)
>>>>>>>> you zap everything that still needs migr
>>>>>>>
>>>>>>> I see what you mean now. Thanks.
>>>>>>>
>>>>>>> Yes, in this case we have to interpret MADV_NOHUGEPAGE as nothing=
 >4KB.
>
> I'm glad we have agreement on this.
>
> In some threads Yu has been talking about this series in the short term=
, vs long
> term roadmap; so to be clear, I interpret this as meaning we must consi=
der that
> MADV_NOHUGEPAGE means nothing bigger than order-0 both in the context o=
f this
> series and for the long term - that's behavior that user space depends =
upon.
>
> I think we should also apply the same logic to system/process THP mode =
=3D
> "never", even if the vma does not have MADV_NOHUGEPAGE. If the user has=

> explicitly set "never" on the system or process, that means "nothing bi=
gger than
> order-0". Shout if you disagree.
>
>>>>>>
>>>>>> Note that it's still even unclear to me why we want to *not* call =
these
>>>>>> things THP. It would certainly make everything less confusing if w=
e call
>>>>>> them THP, but with additional attributes.
>
> I think I've stated in the past that I don't have a strong opinion on w=
hat we
> call them. But I do think you make a convincing argument for calling th=
em after
> THP. Regardless, I'd rather agree on a name up front, before this initi=
al series
> goes in - it's always better to be consistent across all the commit mes=
sages and
> comments to make things more grepable.
>
> The only concrete objection I remember hearing to a name with "THP" in =
the title
> was that there are stats (meminfo, vmstats, etc) that count THPs and th=
is
> becomes confusing if those counters now only mean a subset of THPs. But=
 that
> feels like a small issue in the scheme of things.
>
>>>>>>
>>>>>> I think that is one of the first things we should figure out becau=
se it
>>>>>> also indirectly tells us what all these toggles mean and how/if we=

>>>>>> should redefine them (and if they even apply).
>>>>>>
>>>>>> Currently THP =3D=3D PMD size
>>>>>>
>>>>>> In 2016, Hugh already envisioned PUD/PGD THP (see 49920d28781d ("m=
m:
>>>>>> make transparent hugepage size public")) when he explicitly expose=
d
>>>>>> "hpage_pmd_size". Not "hpage_size".
>>>>>>
>>>>>> For hugetlb on arm64 we already support various sizes that are < P=
MD
>>>>>> size and *not* call them differently. It's a huge(tlb) page. Somet=
imes
>>>>>> we refer to them as cont-PTE hugetlb pages.
>>>>>>
>>>>>>
>>>>>> So, nowadays we do have "PMD-sized THP", someday we might have
>>>>>> "PUD-sized THP". Can't we come up with a name to describe sub-PMD =
THP?
>
> I think one subtle difference is that these sub-PMD THPs, likely won't =
always
> have a single size.
>
>>>>>>
>>>>>> Is it really of value if we invent a new term for them? Yes, I was=
 not
>>>>>> enjoying "Flexible THP".
>
> How about "variable-order THP"? Or "SW THP" vs "HW THP"?

variable-order THP sounds good to me.

One question I have is that although Ryan is only working on sub-PMD THPs=
,
do we want to plan for sub-PUD THPs now? Like are sub-PUD THPs variable-o=
rder
THPs? And leave TODOs and comments like "variable-order THPs can be bigge=
r than
PMD and smaller than PUD in the future"? Maybe sub-PUD THPs are still too=
 far
to consider it for now. Just think out loud.


>
>>>>>>
>>>>>>
>>>>>> Once we figured that out, we should figure out if MADV_HUGEPAGE me=
ant
>>>>>> "only PMD-sized THP" or anything else?
>>>>>>
>>>>>> Also, we can then figure out if MADV_NOHUGEPAGE meant "only PMD-si=
zed
>>>>>> THP" or anything else?
>
> Based on the existing user space expectation that MADV_NOHUGEPAGE means=
 "nothing
> bigger than order-0" I'm not sure how we could ever decide MADV_NOHUGEP=
AGE means
> anything different? This feels set in stone to me.
>
>>>>>>
>>>>>>
>>>>>> The simplest approach to me would be "they imply any THP, and once=
 we
>>>>>> need more tunables we might add some", similar to what Kirill also=
 raised.
>
> Agreed.
>
>>>>>>
>>>>>>
>>>>>> Again, it's all unclear to me at this point and I'm happy to hear
>>>>>> opinions, because I really don't know.
>>>>>
>>>>> I agree these points require more discussion. But I don't think we
>>>>> need to conclude them now, unless they cause correctness issues lik=
e
>>>>> ignoring MADV_NOHUGEPAGE would. My concern is that if we decide to =
go
>>>>> with "they imply any THP" and *expose this to userspace now*, we mi=
ght
>>>>> regret later.
>>>>
>>>> If we don't think they are THP, probably MADV_NOHUGEPAGE should not =
apply and we should be ready to find other ways to deal with the mess we =
eventually create. If we want to go down that path, sure.
>>>>
>>>> If they are THP, to me there is not really a question if MADV_NOHUGE=
PAGE applies to them or not. Unless we want to build a confusing piece of=
 software ;)
>>>
>>> I think it is good to call them THP, since they are transparent huge =
(>order-0) pages.
>>> But the concern is that before we have a reasonable management policy=
 for order>0 &&
>>> order<9 THPs, mixing them with existing order-9 THP might give user u=
nexpected
>>> performance outcome. Unless we are sure they will always performance =
improvement,
>>> we might repeat the old THP path, namely users begin to disable THP b=
y default
>>> to avoid unexpected performance hiccup. That is the reason Yu wants t=
o separate
>>> LAF from THP at the moment.
>
> (for the purposes of this; LAF=3D"sub-PMD THP", THP=3D"PMD-size THP", w=
e treat them
> both as forms of THP)...
>
> How about this for a strawman:
>
> When introducing LAF we can either use an opt-in or an opt-out model. T=
he opt-in
> model would require a new ABI from day 1 (something I think there is co=
ncensus
> that we do not want to do) and would prevent apps from automatically ge=
tting
> benefit. So I don't like that model.
>
> If going with the opt-out model, we already have an opt-out mechanism
> (thp=3D"never" and MADV_NOHUGEPAGE) that we can piggyback. But that mec=
hanism
> doesn't give us all the control we would like for benchmarking/characte=
rizing
> the interactions between LAF/THP for different workloads. Ideally we ne=
ed a way
> to enable THP while keeping LAF disabled and enable LAF while keeping T=
HP disabled.
>
> Can we do this with debugfs? I think controls in there can come and go =
without
> too much concern about back-compat?

Is debugfs always available on all distros? For system without debugfs, u=
ser is
going to lose control of LAF. IMHO, the two knobs below can live in
/sys/kernel/mm/transparent_hugepage/ and could be in sync with "enabled" =
once
we think LAF is well studied and goes along well with existing PMD THPs,
namely when setting "always", "madvise", or "never" to "enabled", "laf_en=
abled"
is set to the same value.

>
> Perhaps 2 controls:
>
> laf_enable=3D0|1
>   enable/disable LAF independently of THP
>   default=3D1
>
> laf_max_order=3DN
>   applies to both LAF and THP
>   when max_order < PMD-order, THP acts like thp=3D"never"
>   puts a ceiling on folio order allocated by LAF
>   default=3DPMD-order

I think it is better to keep it independent of PMD THP. Just make
laf_max_order can never be bigger than PMD-order. Later, when we understa=
nd
the performance impact of mixing LAF with PMD THP, we can lift this limit=

to allow laf_max_order to be any possible page order.

>
> This gives:
>
>
> laf_enable=3D1, laf_max_order=3DPMD-order (LAF+THP):
>
>                 | never     | madvise   | always
> ----------------|-----------|-----------|-----------
> no hint         | S         | LAF>S     | THP>LAF>S
> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
> MADV_NOHUGEPAGE | S         | S         | S
>
>
> laf_enable=3D0, laf_max_order=3DPMD-order (THP only):
>
>                 | never     | madvise   | always
> ----------------|-----------|-----------|-----------
> no hint         | S         | S         | THP>S
> MADV_HUGEPAGE   | S         | THP>S     | THP>S
> MADV_NOHUGEPAGE | S         | S         | S
>
>
> laf_enable=3D1, laf_max_order=3D(PMD-order - 1) (LAF only):
>
>                 | never     | madvise   | always
> ----------------|-----------|-----------|-----------
> no hint         | S         | LAF>S     | LAF>S
> MADV_HUGEPAGE   | S         | LAF>S     | LAF>S
> MADV_NOHUGEPAGE | S         | S         | S
>
>
> This would allow us to get something into the kernel that would allow p=
eople to
> more broadly characterize different workloads under THP, LAF, THP+LAF, =
which
> would give us a better understanding of if/how we want to design ABIs f=
or the
> long term.
>
>
>>>
>>> Maybe call it THP (experimental) for now and merge it to THP when we =
have a stable
>>> policy. For knobs, we might add "any-order" to the existing "never", =
"madvise"
>>> and another interface to specify max hinted order (enforcing <9) for =
"any-order".
>>> Later, we can allow users to specify any max hinted order, including =
9. Just an
>>> idea.
>> I suspect that all the config knobs (enable/disable mixing mode, defin=
e "any-order"
>> or "specific-order") will be exist long term. Because there are always=
 new workloads
>> need be tuned against these configs.
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_5B692EBE-5150-4F0F-AB90-F134C256CD55_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTRM5EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUdCAQAJOZII6oZHSc+Xl3RXtVmF0yyf1GOjFczIBb
QEGICBvnf6LSKs2nwKv3zJfjXbiPKnc0//sltrHiWxkzry6QEd5bDSNxtMNgc1Eb
VRnkHGdp47jPd9RKfk1eQBASYy7yzqD3vJUTHHa5W0pneAZZLpNfn7P7IM2i/iEq
urD2ZAQgug01C3CrPwMakvpkSErP91XoYfrei9N7Z+fAHK6VFeeHOCZuieWiI2Ez
PPey+x1yoF2NGnr9hv6Spj179BrRF8vDEz4AxVFXgZw1pUpANSTAwUmDw0TZwXGm
F3FPMgQL98MIOdcLMbTEBFWTqsQgzCrZiAuvhEr5JRdIXAb/Vmj49Ik9RxWjfsI/
ca74W6T3J5MDb34YtGBemwtXH2lJA+K2x4qMvY5kCGOb4ON0ArubWW6/dfPSbFdO
F4AfigGXtI3hvCHIq3y3PuiorT3XF85Fbyk5MkZZypWJJ51KQYO71/FZVGHfJy+E
zGeMSsfvZTvw4Oe3wHnItSe9TZ//3ipwATrl612Fs6EI5M7Ohf6HSakfky+ufzqf
tS24TPmxNSPwi6bPTROdb9JL8gKcvYC/SF8abtbP/AMrm+xQLL5ywUIDVo23f2Qb
OqNjCu5ZV/Xei1cRm2OmWzfu6mM1V+z8fPWYFlZFQz+aR9f/1Ij8pJ9HxIu/y3XM
6wfI3wR/
=8CDM
-----END PGP SIGNATURE-----

--=_MailMate_5B692EBE-5150-4F0F-AB90-F134C256CD55_=--
