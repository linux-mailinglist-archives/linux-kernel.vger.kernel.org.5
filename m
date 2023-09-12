Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D7279D7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjILRiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbjILRiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:38:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3276C1706
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsoLRQPWd2Xi5ZLm9CQ7362zbv9U7C1npJxXy0LymhlQMiXp1uyhIe7FWPul/G8bjjwo2Q564v1XAZGsmmu5BhILbuXFQeXcw48Two/Te6gfTIE8Im1as8xEdkK4v7WB3Q0s0emSYbrOawgezd3fOb5jRhh/cqP/FmjKu+upKnH49Ou/vpkS9PbO49883zhb2xEyDA9OLADfKxG1Z8nKgfyzAd7Xrm7gHoPiYw5U6DAoE1uXLcKBb5UjeEYMatoK7+XDuzkPpwQSxqBQOS+UrbeWLa2X4B5ekhPbM4sv/pHFpcbhU25tV1JNM8ka14Y3IW0SseUt5zdhrVwUM9cgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSYtICCXsM6RZsp2W8KaQFEEYnUhNDpw8SQJl5b4o38=;
 b=DE1kNoDzmFh6su4SoddBZCnJ79MhbpilNnQHd1Cm7RS1/bng8A8ZQITLooTmMEH0h/d4WpGF5ZCf6Xet/j37y6/tH2dasiRzO9+MSG0UFPSBMAgejXZv0hd28nS7i//Z5Ruf+vu6qyPHidhqgyTJlTCaJdjG0f2foCyS21OU7kOVNaYztQ/qOcaQ7lMruGiUFMCHNClpQd/0anb6CWCwOmSJyDGoarCCSU4ww7e/f//ANgcxWa1Nxa8SWTM/lQMkuLg+TntuMV8NbkI0IfsnS9Zuub8k6kfdzPR1cOsJj66kL+cupY2LD80kPK+esZ1D1dmrSzY9xUIDUVlCCDh0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSYtICCXsM6RZsp2W8KaQFEEYnUhNDpw8SQJl5b4o38=;
 b=XxQLIYjN8gKwv1zVK8voDm66dWZ6/INMnkv8hjxPwGbYESlFk8s6Eb73zFANVUgrdEAVWNx0YpUSaSLnTRKBqW4L/Lj+UEeDAs4B7Ir3GQ0hdSIVfDB1S88IBoL246huOrBZp0mqTCDJd9bDp5cNw/Y/Uz2t26h3JgXQoeA85xyF16NA1jYldbAefPuvDUkb97Z3nlFQH2JeG7dwT+zdgvJb5DpItRne5ueT0vUBirVELKXfAfKlElQIXPSBo+H81/N1aOEWK0mYKEJPw35SPgQ/VTcxn3o/eDyb9n+wKioaADBQch2mvSj1PFYLTTdyENp4sQivXWkCBkttqoQVCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.37; Tue, 12 Sep 2023 17:38:04 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Tue, 12 Sep 2023
 17:38:04 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 1/4] mm/compaction: add support for >0 order folio
 memory compaction.
Date:   Tue, 12 Sep 2023 13:38:01 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <6CE0050A-96A4-4AAB-8B59-52D079857AF2@nvidia.com>
In-Reply-To: <20230912173238.GB34089@cmpxchg.org>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <20230912162815.440749-2-zi.yan@sent.com>
 <20230912173238.GB34089@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_B7E36759-7373-4F14-AD47-F738FBF4BB43_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:208:fc::27) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: e3460e67-c1af-4c7d-e16e-08dbb3b704de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKBrwKU7rBIAqrF5ZMEvHIBzgRsdbuBKzUUIlIR93gEGmzo95p1uJYPpJ6UXHHC5X2xAZ/95kHGlbBeXB2okpJcVI78k7MU+0xffOtaMhs2J0tjLmCMwClN9Slo6jffjny/7ZKitc2TvGAuwXLPPJ9FXysH7TSXBV4lKqcrhDxBoGJm9fTt7CHc3M8XIE7R35sY+yCfyteeArLT+CtV+ufJu59rAF2CcajeZT1bFvUlgjDdE7negRWCiBSAAIKWXgkfPpSLQ7UcdskfCAEbwmS4bhc5QcLKLcwk3kFUr3SYLcr/vTBoexFt0I/VZvRxM2Nhdn4wmqVWv4s7dfDwdX4Jlfr4hdAjR1JG5oAtyNR/iIfORgvCdbLBa9TQ8yvsMt8JtkNgmLjZzILiBos/No1gSIr+Dm6nLgbzdpab7ZLDjwR6mbsN8921tN4Hs62OMI3zgjDEkJz4G/uPg42NwKrPFWdf2uQ/yRlMS8uTNvE1ker/g54mUecTUryflIIop0heM1e2cOa2H+sSfkQ+vjw6S+gkBe4uBhp7Mb7vksI7vlgF5jd0HuIlLpCaiG257dl5gVicm3LGEv0N9na+zU0m10sw4UW5jc7mQDQXERyBugrALc+vs8FjHe7gEuFG3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(186009)(1800799009)(451199024)(38100700002)(86362001)(33656002)(235185007)(4326008)(41300700001)(8676002)(5660300002)(316002)(8936002)(66476007)(66946007)(6916009)(54906003)(66556008)(7416002)(6512007)(2616005)(478600001)(2906002)(53546011)(83380400001)(6666004)(6506007)(107886003)(6486002)(26005)(36756003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q667gpLUSMd+J53c51jbwoxnwhKq+/rznkNCb0WVBwjE4tsZZc6mHd/9DEOM?=
 =?us-ascii?Q?jipmtJn9CxaGtCUjVZfbjoluBrNwTOBKfABoThowQ656IiHHeKnAUO6m3GOw?=
 =?us-ascii?Q?NqI2RksoHMt7J9OD/JBw0jV0LLtubKd9NMEKVFuiGKY1u4QyJ87JufXPY4+8?=
 =?us-ascii?Q?Cukmh3jmrqy6XLmUjqGCgL+IVjtgmYRDfo09RsaWBd/nFTx5EzDT0mCswyA4?=
 =?us-ascii?Q?jHt9em9xNjJzryOphE++WnOrAF5ZX5yu8uglcb2Fhzk4owAuv+YhoCWLpRNM?=
 =?us-ascii?Q?M4zFTJN+2dkeyOHZHlsoNAMhanudx/JL3FpEs1+Wnb5rIymhAJG9D+E8vCFy?=
 =?us-ascii?Q?uPBh8MzxLMPo1M4JgQ+s6koChs1r5J7CzmDAAbEgkWzo/Yg/1cZh7ijF8Er5?=
 =?us-ascii?Q?jtSg1wedd9PgJwDiGZGuNu92fqskGOMQW/2GvNJa0f/Lrhp5VGO8zS9FTz47?=
 =?us-ascii?Q?k4pMIuY3acrEEGIfe8FFH8e440j+xJC3cA/WiiJ5VfM9vw4FVCwZhvNBCNqv?=
 =?us-ascii?Q?YPUUAN5Suw10VLTgxZv/83eehas9pGDUHZRUKBhuVquntQVFEGZOPxqiZj3s?=
 =?us-ascii?Q?mZq2YjhEovg2XsCZto5N/Qj2/UG45qE6wV5f35tmKAoyQNRJh8scCdxElT8d?=
 =?us-ascii?Q?deuh5Q4pEoSFzYBaefxIzfGCP3f85YefPE4NbNCH+OdfqrMvUj34kjsjfwAG?=
 =?us-ascii?Q?zgewSqmRbR2bZ+1G3b9ogTW2RXdYhoyc4UrEZd48sUJyEz+A2FuqMuK4O48N?=
 =?us-ascii?Q?sGVLqfEB9ukq1gtjW7nQSZT9RWGl/Ib5Y5pFecnjNYtEemfQ3fTe1JYJI+6D?=
 =?us-ascii?Q?ra4xTRZ0RZh7+fNQj4v2VoHULvIZsUAHoldBdLKEAeumDGgJLAP93L35XCaD?=
 =?us-ascii?Q?j2xK/R9wkjpQPIk/zQkVUpLH45CB5jT9I6bijOjGZIQA6WPqdte0+GQAkWxU?=
 =?us-ascii?Q?lyO7EK0A4yMx34Qr/ogWxfHqhdx29WgIS6pEzo/Fen9vClU7rO86htNxfZZz?=
 =?us-ascii?Q?nGIGJ/OjPRZb6U7rPNV275jnLvfOa9uaD1JkKZz0HQp5FXhU4qnDS0g9UTkj?=
 =?us-ascii?Q?bLuOEU98TP/w812jbpyFq9qO8gYf2CQtqATwiVMgvs4noxWtUPovkunswJwl?=
 =?us-ascii?Q?Ei9aFj9PrveSJZUU+IXrLiZkuUTI825mA/+cXYfb8E9pTyXjuqFGnPLfemo9?=
 =?us-ascii?Q?D80AoPJ3zO87mPIgILXKpY73BIOAuE74OXLgbLqHLxUR549rKVM46OF9YsXa?=
 =?us-ascii?Q?070gVV2NztT/uRDC244ZEZGr640vBg+tk+ZtkxOQKZ/e4AOAVFNvSaGtp/Yv?=
 =?us-ascii?Q?nTDBbA5a3XlSUS00WeiFojpCnTvRtdC7I0l1TSdO7YXt6bxATZoUPVwciQA4?=
 =?us-ascii?Q?U4OsqsOIsu/zuOinhOVg+lrNfm7LKAoOb0Eflfz+J5PEW4pXmTcBkH7yb+tP?=
 =?us-ascii?Q?Z38kGdLDQ82avZ/hupzPot8xNoE0Bgx402v8GCjYFnRacCPKo71T/TsG9rY5?=
 =?us-ascii?Q?0x13ZihKfguJa52wKYtBvAgkCQa8/m4QsXtqLfc/EZxls00BMAQRbGGA7WTN?=
 =?us-ascii?Q?G8FVia2EJ9f1kjJB9yI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3460e67-c1af-4c7d-e16e-08dbb3b704de
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:38:04.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alovku3c/DqYv7bZvmW3MvTmuACXn4DQocV+7YVLMT72KrDSga03C118lGbbFjfN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_B7E36759-7373-4F14-AD47-F738FBF4BB43_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 12 Sep 2023, at 13:32, Johannes Weiner wrote:

> On Tue, Sep 12, 2023 at 12:28:12PM -0400, Zi Yan wrote:
>> @@ -1439,7 +1478,8 @@ fast_isolate_around(struct compact_control *cc, =
unsigned long pfn)
>>  	if (!page)
>>  		return;
>>
>> -	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, =
false);
>> +	isolate_freepages_block(cc, &start_pfn, end_pfn, &freelist, 1, false=
);
>> +	sort_free_pages(&freelist, cc->freepages);
>
> Can you make isolate_freepages_block() put the pages directly into a
> sorted struct free_list?
>
> AFAICS, the only place that doesn't technically need it is
> isolate_freepages_range(). But that's then also the sole caller of
> split_map_pages(), which can be made to work on struct free_list too
> without notable overhead.

Sure. Will do that in the next version.

--
Best Regards,
Yan, Zi

--=_MailMate_B7E36759-7373-4F14-AD47-F738FBF4BB43_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUAofkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUdNcP/0rJ09JTQPKlMfy8z01ocXab1YcmVOivHzui
ddpV/HsgpL4TGNB3jrqRfcSoBdMkG/0MwQEakUXgjWqxUjA/j3hInRO2K6XG2ln2
fqwByvUyzLKhAkGCnt5R7cUq+EVq+DdWg8QzfF/PXfhFRxuE8oWSV9fdGiF6CmdB
IwvTXGg5hF72MUCsX6POGOxttNP8LO/nFpPcZXCTW3NY96QqMY6ynzIicuw/F3ER
r6INaLOP1KcJR9RbKc8m+nb/M/EdJNRt8kySJc1h5BopxufW1ZcDz9cAM0tPnbvI
sF+AEHaq7vO4v52fBX0dcEFkQlTUkuRcM5S8e6rfOnVRy62/iJz/alQ9xXIr4vwi
mVc/luW4UGefEFfJt7CMNudRppqrZxkIuY0ZR1TnBVvlxFM6FxHqzJpQIKzehnQq
MV0bkveHaeXXHNOoQuIKTrw5HizpzNBOQLQGKPJzLg17KKc4UnKwniXnrZdMC0oF
PqtPqTyqXS4XZ9C//ir12TNh7pXlCafg+BDmewxRM21HLf7xUWxHB1xHx1noYNHG
Sou7OtEXtP0/yHt0FhiJjOscEfpL0OoKU/bGshKN5LdDgXXTwRuIHzNYyfVwn/il
iyv6m3CEO6wSRYfXxiAgedHwGL+f5HEf49skBJxpvWrd9wBMoObkdq/sIo7sSJQ2
uZE+WH13
=jp7u
-----END PGP SIGNATURE-----

--=_MailMate_B7E36759-7373-4F14-AD47-F738FBF4BB43_=--
