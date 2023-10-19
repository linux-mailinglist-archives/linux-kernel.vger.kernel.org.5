Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1437CFAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345878AbjJSNXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjJSNXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:23:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59B7115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ba2BHu9k4dw5Ynxt1J1l6Cf5KJTisKcl8ObCSOVAIcP79mY7uLhG42nfOMs9K3HeCXPVtN5Q8I6DVnI6J6oz5e+v0o0g3rHEEL3sFAC4czsoa20r6XQseAX6cHN1RwCd0KBREGHBNTkx9blfr2S7WGCmgjD5O7+DyrPERK9+T5QFBXsPhH5E9lbLv7E6SuWxh/v8KXAOCNAG+47VwQf7kAbsuvARNPJSg3iAP8D/4eJ0QEIFhlG6BAKo7KMdz26efZzBr2y1t3vsjMqIJtf3sAhdh3GNNmxbCcHFAzoKcyuK8LbHatfg7K3neq495zuovvhw3K7/o1dZGPpzDdLXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8o6Z7hcBYBPDaUUpp1hKoH/RYGfbRPSclZJnb6FUiPI=;
 b=L8ozc5e7euNESwg/ecG4RRrIYvzOqhxX0ImQGpxmVJP21lGnj9UYqzlbqVCm8zAh1KgjcpPP+IOSmdyrRKPuXKzOwUhs46t64kdlrkTY4Ep8oeUTESlIgiJmZy+lQyXtp29scotVcm2kL48ge2ObmkvfXrxhoYV+EbsW0GI8mU0eZpJrBw9EOhU4VWCkRbx5Sxx4gy2Va68Nn1likYUw20U00fYrPQctXpfYpAtClLOMFoyk5AH8qQ+1NN/5WiCTKNabAdIyyyVzG/jG7yYzefR6KPLw3m7SZ2DtAj1XgZRxfr6gBSAbfO/AwuFTsH8pzZIRMv/tMa6ANTXkc80oHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o6Z7hcBYBPDaUUpp1hKoH/RYGfbRPSclZJnb6FUiPI=;
 b=T8q6iPEKwhPlt+6OCghLxPCbsf82G3Qdw5YnL4Ny3DUTqBstQzQpFXsA9scdWYiH13YrjLwJC57QETfN0VzWiTtw5kXrZwfFqowH7lNW3ZMq+PwnqGH/XjIJ51WAkIDg2BcIa585azh9MYvx09H7KMybCMOu80soyBn/XWSD+tXaQu4L5+PGZNE7OMvRLT9x+0KQAbA6Hj484YjEZDiiNdDTidh33cbJDww/c2/2/qXYh0pYs7jIhptR/bhQRNyLbJhBvqWuWCllAsEXAn43kCk5OSaM5/yfiXBd3XU/XclDfL426FUu8o+pgjKjWegkXFulOonQ3LXCIQrrPCwcag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CYYPR12MB9014.namprd12.prod.outlook.com (2603:10b6:930:bf::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21; Thu, 19 Oct 2023 13:23:04 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 13:23:04 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "\"Huang, Ying\"" <ying.huang@intel.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        hughd@google.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Fengwei Yin <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
Date:   Thu, 19 Oct 2023 09:23:02 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <D07298E1-7929-484C-A513-4DCE1DFF8AE9@nvidia.com>
In-Reply-To: <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
 <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com>
 <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C3D22CED-A1C3-4FB6-8E80-BA389C6608CE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::35) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fb78a6-5fad-4591-4cd8-08dbd0a686ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+CfdsyXEkxQ8LFq+SaTZz6RRhwoHevrBRGmH/1SsKMrq57Cwq/OeLtIygSAYd7KF/Dk+aZLMmBCec8juWaF9625jkcQw/kodViXQtZgKbRWYQ8sAyocARfthsCR+mFsZSkvZwz6agdcS9kZwVFGY276W5/Bs9l29RR4hyYA6lyu6U+8O7ZUg16ZYrL1ERErMjrDGNrX7JPZ21ycLZoC34cJ/IPIoGTjWuz3WpQ41sqMvPHIAvIpUiIHi/WkRUAU8N8qZVnfNEEpv39e02YLXCqm9ae4rCwCpXRyyDD+3sj80uO82hSdv2rs41J4/JpkDDdeWtWZMIMWSaZg/SIHW8IvdyE7G9qHDvm+7iIbK75hZvwR2QUDnVH+Wl9lxk0SRsLWhB6tW8iU1RineaGaZPupJPR8BIFB2NlHMpBLVP/UtxZfIIL+ixkZEG8cHqoh+79fR4hR7t4XfrFNJb8eawQ7ArZFzer7LeuuXG2LD7QureOZzHs6M5XOPoQaETDcadGIN1AmbS9FZBapqqHBTJUKq1l2XjSskG4kk88z07O/6/X0NpxwrUhtteDjiEqJUZSsLgiesAduERJrfGprnRpGMmw0VCwIr+YSbcdOswogKyNR8WrHbokOGYajrTjV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(235185007)(33656002)(4326008)(8936002)(8676002)(38100700002)(41300700001)(5660300002)(86362001)(2906002)(6506007)(53546011)(478600001)(6512007)(66476007)(6486002)(36756003)(83380400001)(66556008)(26005)(54906003)(2616005)(6916009)(66946007)(316002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qI3M/ZHAflrNZGyKhkFu/J8amhx8SzuUVVY7Niilo1gOFC/4np+8PyIJHB4K?=
 =?us-ascii?Q?EfkXPKXRhETOs/KlRxr2KNpdvGx6O3kx1UDsmw99rTuRnvdZevKzHHV3WFw8?=
 =?us-ascii?Q?1y0mNinyruS1psywjCbLlCN9fBYNtV8BXGKYw8F2bSbBh6yFiUPTBtNJ6Ikt?=
 =?us-ascii?Q?QCbYgmOefD8Bj+nXf8Gih4BGO7OodrNFaXmMQrJB3qaHotADx8tl/it3cG60?=
 =?us-ascii?Q?yDlVB+KMEHVvO7s4o6a8yzOY+N2t8zlmVILhy6VX+stty/QiKuIKusVx9qUE?=
 =?us-ascii?Q?b5/9D2VOeW/T+DKufOPUMdZ7H1d2ZC7fKonP099JtHQRkvcrENGag5OTHHxu?=
 =?us-ascii?Q?PXTCxCWxcbRKOxgEKFjCOVAKd9HO52A/OTJA+YiB7t8fyCT1xkwq1+Uwb1GL?=
 =?us-ascii?Q?cdrk+hCBuupV/pxe4n9pxVd/lqqBp0jQaaUG9tOaY7zhqYBk68hif349xuNL?=
 =?us-ascii?Q?LnPzmVv53itbOM7Ve8tv1V8KUGEXzaV41557gTRsF4yIApfSi4rs6fZSMk7n?=
 =?us-ascii?Q?br/FJug5ZFOp0rVNRRK0i7bE7ebEMjIj2mnGQddN09LUZTF+fHN3WzFkFKjk?=
 =?us-ascii?Q?izBg7zHSybW9D0DK8JDZQAdpWtpHTSlb92PD/+NGf17bFdC/UsJyUDXicDtA?=
 =?us-ascii?Q?QC8IxVLCl+BqqGFiqtfzpxV9VRV71PypyXdf8aQWjnUA0fKlSAw+dZlyc5m3?=
 =?us-ascii?Q?ibzX+KZ74EXeMaHoZ8xLiUT2aN7eW091ToCivZd6zA8Z3p+cJeqsrqtB6EUX?=
 =?us-ascii?Q?eq4Ezxe41vUUQE13DoE3dUDzGlFa1Q3RQx0Sg8XbPS2osNLLJbAvYVXyZ0OV?=
 =?us-ascii?Q?ES0DmklDk2ST7TsqAvV7an5sjNqPdQuJCt0vHX1LAVniJTevIf+ssGxEreOk?=
 =?us-ascii?Q?qPpLi+UBZpE7IpBVPRI3vAViyA0I79BltV9s9x7FX8gwgzHNTwn+/KDSPfR7?=
 =?us-ascii?Q?TiSWplaDrM261etCbsPqnESPCcYzFyTNxNzpokf4voFKGINhkDXSQ1snJxLJ?=
 =?us-ascii?Q?jLvGOAundcMxz8E4mCCd35FM6fucNNxfAPlpHYhXxkPdwdReJgTOiVqQLhNK?=
 =?us-ascii?Q?kOr2Bm2IvFCeE0AM80Q0yBMvl7RxqCgEpR2HOrRQxczGt/Fy05T+t88vJ3s9?=
 =?us-ascii?Q?HggWrxIMW23eJ8xfLeobb/zlOOtaGXULhsJjULWAKnGfsQVQFXwb1EYqL342?=
 =?us-ascii?Q?J8fsgba5neW4IePw9KEnGEXGqLP048/2/21IbFLerbntGduxI0RyySAoCQ+l?=
 =?us-ascii?Q?U1Ci7q5V3NPBoYQjhzIg2C4vW3b12qaU3YM/4sH30/lddHDypi9w1BQjWf36?=
 =?us-ascii?Q?XD5yUVU37UZV8CZnCptsd5JTiimYcLJ1/QV7i9DGHtxMV81eDMSKsX2IbMwp?=
 =?us-ascii?Q?38mtJBEXCS97hBPpK8byqXi4HLQwrWJxhePEvdU74HoPx7hyP7WDxyFCXq8f?=
 =?us-ascii?Q?yoQ9idmpBf7a9phB30kk9zOIeJ9yVkIbFQ62s0D9d6EjeWcihZ1/3DeB1d0i?=
 =?us-ascii?Q?OvkFOd2t0MLikYIuhM+vafBGjNufiGfNIT3XlSFBxKeMli3JLIxxAOKRNVfa?=
 =?us-ascii?Q?teL2Q61ROlVXfF4vSKg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fb78a6-5fad-4591-4cd8-08dbd0a686ab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:23:04.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIiUEzbPHC2sYcozwjqFvbC8Ws7GmzUaAhMDNL2dKcJLMDAhFqjKnRKeTVuvRMjz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C3D22CED-A1C3-4FB6-8E80-BA389C6608CE_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Oct 2023, at 2:09, Huang, Ying wrote:

> Zi Yan <ziy@nvidia.com> writes:
>
>> On 18 Oct 2023, at 9:04, Baolin Wang wrote:
>>
>>> When doing compaction, I found the lru_add_drain() is an obvious hots=
pot
>>> when migrating pages. The distribution of this hotspot is as follows:=

>>>    - 18.75% compact_zone
>>>       - 17.39% migrate_pages
>>>          - 13.79% migrate_pages_batch
>>>             - 11.66% migrate_folio_move
>>>                - 7.02% lru_add_drain
>>>                   + 7.02% lru_add_drain_cpu
>>>                + 3.00% move_to_new_folio
>>>                  1.23% rmap_walk
>>>             + 1.92% migrate_folio_unmap
>>>          + 3.20% migrate_pages_sync
>>>       + 0.90% isolate_migratepages
>>>
>>> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
>>> __unmap_and_move() push good newpage to LRU") to drain the newpage to=
 LRU
>>> immediately, to help to build up the correct newpage->mlock_count in
>>> remove_migration_ptes() for mlocked pages. However, if there are no m=
locked
>>> pages are migrating, then we can avoid this lru drain operation, espe=
cailly
>>> for the heavy concurrent scenarios.
>>
>> lru_add_drain() is also used to drain pages out of folio_batch. Pages =
in folio_batch
>> have an additional pin to prevent migration. See folio_get(folio); in =
folio_add_lru().
>
> lru_add_drain() is called after the page reference count checking in
> move_to_new_folio().  So, I don't this is an issue.

You are right. I missed that. Thanks for pointing this out.

>
>>>
>>> So we can record the source pages' mlocked status in migrate_folio_un=
map(),
>>> and only drain the lru list when the mlocked status is set in migrate=
_folio_move().
>>> In addition, the page was already isolated from lru when migrating, s=
o we
>>> check the mlocked status is stable by folio_test_mlocked() in migrate=
_folio_unmap().
>>>
>>> After this patch, I can see the hotpot of the lru_add_drain() is gone=
:
>>>    - 9.41% migrate_pages_batch
>>>       - 6.15% migrate_folio_move
>>>          - 3.64% move_to_new_folio
>>>             + 1.80% migrate_folio_extra
>>>             + 1.70% buffer_migrate_folio
>>>          + 1.41% rmap_walk
>>>          + 0.62% folio_add_lru
>>>       + 3.07% migrate_folio_unmap
>>>
>>> Meanwhile, the compaction latency shows some improvements when runnin=
g
>>> thpscale:
>>>                             base                   patched
>>> Amean     fault-both-1      1131.22 (   0.00%)     1112.55 *   1.65%*=

>>> Amean     fault-both-3      2489.75 (   0.00%)     2324.15 *   6.65%*=

>>> Amean     fault-both-5      3257.37 (   0.00%)     3183.18 *   2.28%*=

>>> Amean     fault-both-7      4257.99 (   0.00%)     4079.04 *   4.20%*=

>>> Amean     fault-both-12     6614.02 (   0.00%)     6075.60 *   8.14%*=

>>> Amean     fault-both-18    10607.78 (   0.00%)     8978.86 *  15.36%*=

>>> Amean     fault-both-24    14911.65 (   0.00%)    11619.55 *  22.08%*=

>>> Amean     fault-both-30    14954.67 (   0.00%)    14925.66 *   0.19%*=

>>> Amean     fault-both-32    16654.87 (   0.00%)    15580.31 *   6.45%*=

>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>  mm/migrate.c | 50 ++++++++++++++++++++++++++++++++++++++------------=

>>>  1 file changed, 38 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 4caf405b6504..32c96f89710f 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1027,22 +1027,32 @@ union migration_ptr {
>>>  	struct anon_vma *anon_vma;
>>>  	struct address_space *mapping;
>>>  };
>>> +
>>> +enum {
>>> +	PAGE_WAS_MAPPED =3D 1 << 0,
>>> +	PAGE_WAS_MLOCKED =3D 1 << 1,
>>> +};
>>> +
>>>  static void __migrate_folio_record(struct folio *dst,
>>> -				   unsigned long page_was_mapped,
>>> +				   unsigned long page_flags,
>>>  				   struct anon_vma *anon_vma)
>>>  {
>>>  	union migration_ptr ptr =3D { .anon_vma =3D anon_vma };
>>>  	dst->mapping =3D ptr.mapping;
>>> -	dst->private =3D (void *)page_was_mapped;
>>> +	dst->private =3D (void *)page_flags;
>>>  }
>>>
>>>  static void __migrate_folio_extract(struct folio *dst,
>>>  				   int *page_was_mappedp,
>>> +				   int *page_was_mlocked,
>>>  				   struct anon_vma **anon_vmap)
>>>  {
>>>  	union migration_ptr ptr =3D { .mapping =3D dst->mapping };
>>> +	unsigned long page_flags =3D (unsigned long)dst->private;
>>> +
>>>  	*anon_vmap =3D ptr.anon_vma;
>>> -	*page_was_mappedp =3D (unsigned long)dst->private;
>>> +	*page_was_mappedp =3D page_flags & PAGE_WAS_MAPPED ? 1 : 0;
>>> +	*page_was_mlocked =3D page_flags & PAGE_WAS_MLOCKED ? 1 : 0;
>>>  	dst->mapping =3D NULL;
>>>  	dst->private =3D NULL;
>>>  }
>>> @@ -1103,7 +1113,7 @@ static int migrate_folio_unmap(new_folio_t get_=
new_folio,
>>>  {
>>>  	struct folio *dst;
>>>  	int rc =3D -EAGAIN;
>>> -	int page_was_mapped =3D 0;
>>> +	int page_was_mapped =3D 0, page_was_mlocked =3D 0;
>>>  	struct anon_vma *anon_vma =3D NULL;
>>>  	bool is_lru =3D !__folio_test_movable(src);
>>>  	bool locked =3D false;
>>> @@ -1157,6 +1167,7 @@ static int migrate_folio_unmap(new_folio_t get_=
new_folio,
>>>  		folio_lock(src);
>>>  	}
>>>  	locked =3D true;
>>> +	page_was_mlocked =3D folio_test_mlocked(src);
>>>
>>>  	if (folio_test_writeback(src)) {
>>>  		/*
>>> @@ -1206,7 +1217,7 @@ static int migrate_folio_unmap(new_folio_t get_=
new_folio,
>>>  	dst_locked =3D true;
>>>
>>>  	if (unlikely(!is_lru)) {
>>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>>> +		__migrate_folio_record(dst, 0, anon_vma);
>>>  		return MIGRATEPAGE_UNMAP;
>>>  	}
>>>
>>> @@ -1236,7 +1247,13 @@ static int migrate_folio_unmap(new_folio_t get=
_new_folio,
>>>  	}
>>>
>>>  	if (!folio_mapped(src)) {
>>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>>> +		unsigned int page_flags =3D 0;
>>> +
>>> +		if (page_was_mapped)
>>> +			page_flags |=3D PAGE_WAS_MAPPED;
>>> +		if (page_was_mlocked)
>>> +			page_flags |=3D PAGE_WAS_MLOCKED;
>>> +		__migrate_folio_record(dst, page_flags, anon_vma);
>>>  		return MIGRATEPAGE_UNMAP;
>>>  	}
>>>
>>> @@ -1261,12 +1278,13 @@ static int migrate_folio_move(free_folio_t pu=
t_new_folio, unsigned long private,
>>>  			      struct list_head *ret)
>>>  {
>>>  	int rc;
>>> -	int page_was_mapped =3D 0;
>>> +	int page_was_mapped =3D 0, page_was_mlocked =3D 0;
>>>  	struct anon_vma *anon_vma =3D NULL;
>>>  	bool is_lru =3D !__folio_test_movable(src);
>>>  	struct list_head *prev;
>>>
>>> -	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>>> +	__migrate_folio_extract(dst, &page_was_mapped,
>>> +				&page_was_mlocked, &anon_vma);
>>
>> It is better to read out the flag, then check page_was_mapped and page=
_was_mlocked
>> to avoid future __migrate_folio_extract() interface churns.
>
> IHMO, in contrast, it's better to use separate flags in
> __migrate_folio_record() too to avoid to pack flags in each call site.

I am OK with it as long as the parameters of these two are symmetric.

>
>>>  	prev =3D dst->lru.prev;
>>>  	list_del(&dst->lru);
>>>
>>> @@ -1287,7 +1305,7 @@ static int migrate_folio_move(free_folio_t put_=
new_folio, unsigned long private,
>>>  	 * isolated from the unevictable LRU: but this case is the easiest.=

>>>  	 */
>>>  	folio_add_lru(dst);
>>> -	if (page_was_mapped)
>>> +	if (page_was_mlocked)
>>>  		lru_add_drain();
>>
>> Like I said at the top, this would be if (page_was_mapped || page_was_=
mlocked).
>>
>>>
>>>  	if (page_was_mapped)
>>> @@ -1321,8 +1339,15 @@ static int migrate_folio_move(free_folio_t put=
_new_folio, unsigned long private,
>>>  	 * right list unless we want to retry.
>>>  	 */
>>>  	if (rc =3D=3D -EAGAIN) {
>>> +		unsigned int page_flags =3D 0;
>>> +
>>> +		if (page_was_mapped)
>>> +			page_flags |=3D PAGE_WAS_MAPPED;
>>> +		if (page_was_mlocked)
>>> +			page_flags |=3D PAGE_WAS_MLOCKED;
>>> +
>>>  		list_add(&dst->lru, prev);
>>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>>> +		__migrate_folio_record(dst, page_flags, anon_vma);
>>>  		return rc;
>>>  	}
>>>
>>> @@ -1799,10 +1824,11 @@ static int migrate_pages_batch(struct list_he=
ad *from,
>>>  	dst =3D list_first_entry(&dst_folios, struct folio, lru);
>>>  	dst2 =3D list_next_entry(dst, lru);
>>>  	list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
>>> -		int page_was_mapped =3D 0;
>>> +		int page_was_mapped =3D 0, page_was_mlocked =3D 0;
>>>  		struct anon_vma *anon_vma =3D NULL;
>>>
>>> -		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>>> +		__migrate_folio_extract(dst, &page_was_mapped,
>>> +					&page_was_mlocked, &anon_vma);
>>>  		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
>>>  				       true, ret_folios);
>>>  		list_del(&dst->lru);
>>> -- =

>>> 2.39.3
>
> --
> Best Regards,
> Huang, Ying


--
Best Regards,
Yan, Zi

--=_MailMate_C3D22CED-A1C3-4FB6-8E80-BA389C6608CE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUxLbYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUm4YP/3Q5OzRoQNkKlOBUuXXHejU0B5mAvY3LKxe6
QHRboW719Yfv0zcpe1gGsb6xpQpgK4eI4YLSykyiv48+pMJkf2oPbbGSkqLFuypH
fPEMyiy9dXr2e8WHW6fcF2W5Gy9bE5SV0eyLpnFoVc/9RZhbaJcgZJjWoRqmcDGC
xvvO0Hx9lC5oI3dXBiD3UgAF/aSVkSfWq5c3j4t2ZaJbcd1IxUbjkjTIKJ3OPXya
4dVtoMJyyCQqf+ZXJxnKZdkws5wvA5KGkv+e1pHXmFdT3tUFKhfDwwfUPEwCBRLR
22YFgRaAoJXhe4vBjUhgJPLPeZ7ajk/xEqQb7JUJWWyE2Vi/CpLgTFeD13rsHvqz
i1cLgULVLt8IXO81G9dFkiCPCepawnMwwqiSraTSllXfs/C7xFdsxUM2mWwnFVSW
pN7a0bw2lvKW7CtUfwR+D00nEoss0YEqAY+veWQ/nWCLK0t6eXK65ims5XylBxrJ
OcHqYbhh+VokYZnbAHVBoRixFK1RggCX7CHGzAvgtHaJrp0e9lPggZxclG3ZcyfW
iMutdgr1Iu7zFN1ccsL5JqJ4NNxNDXCqTe8Gj0lrg44s2mD4wibVjkoAWAiaaVgv
7JmGSqh83+mMlHkJxblroVk7QkPEd+NOuX6LWZFxmPVFfL1FzDC4FN2IHstIK+3Z
inB6Rnlv
=rtVU
-----END PGP SIGNATURE-----

--=_MailMate_C3D22CED-A1C3-4FB6-8E80-BA389C6608CE_=--
