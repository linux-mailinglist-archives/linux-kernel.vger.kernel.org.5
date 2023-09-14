Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D572D79F7D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjINCRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjINCQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:16:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F2D1FDE;
        Wed, 13 Sep 2023 19:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNhbQS8A8fgMlywM+j4OUcC9l3ta2R/7VurkJ5InNYdXAw8x6qe2DuC/QjSXp4bGKN4gcDLNJduQ03/+QVx3PYqZ/++TcU5EHQ7A4QWVYcXBk7A8DCTVnoQwrNb2AKv81Ucji180Bf/yqmotH2BNKheT+UuF/1VYEQPzTQWVrPwgvU+prVJgEJTWIdtW3Fw+6JgIm6xFtKSD/A8ySkzqxRDlyCmWgW2aGKSz8zVCAu6CqcWWIja0uA9L13JW7nyocAY3qxEOhbuXW5htlrTPMQJGVVKxkrwUWL8Ah2vKj+DDL1S9I4Rl4vAYfOPZmppFDeQNDaQFfplyePTXYCNFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqwLYI4OPz3GyRE+neijs7Rg9DPIfKCaHoIbMY5vE8c=;
 b=JrI6Yi7Zeta099ULTfkbOcGhjs4phJHqR32+ZQX9TKfDS8mBVAGEQeTy68+6PwISVrysxofHWqvDI5/8BMFdiyDLZM47mEuwNKdXKcAlDcGHvj0X5KmhAdSbvvOAB5VhU3fvPRX8ZQXs7R3R9RB0y9jYsyutn5yG8idCZN8PAT/xxfR0abwn1F9WpvL9ylhCrPfG3joNycgBKtZHnDTNH+NpKBcCpQUVALxNvYHl5RIR2gsZ7x/fZ2DbAY04C8wTi8J1tVTVKV9bBgo4sw8Ehqf3eqm6HBPqgG5kbp54GdV/c2goPfpjgUcvdZk1D8s87ScuIH7NHAuOU88jFuTNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqwLYI4OPz3GyRE+neijs7Rg9DPIfKCaHoIbMY5vE8c=;
 b=AK0fubgJ/0qCUVMOHujmOjrkayCvgZ2bJ00XBBq7pfKxLGFw9Uzd4QdCsBV5JrnF1E5bJY66EC5XSD3GcnzLqPZe7LfeiSqhUG61t/0gy0AsE+pGVcOprDIxy5awGzgMKxMpv76iSlpd2Q199fUhv8wyEjRC7tLOr7fBl1DFec7bv4QR9zf0Ji+HRIclTSKuyq1vN46+U1pC9uRaJkHGHuhi5ODS6QkzQJGjbnfyL63hnEicBLezUCTe6CZC7jj8vAoEEt9W+Qe5UBB44+IMu53JIEmnK9qpEITXY2dkuOoYDHYYj2TULgFpb9afCgMDdHAIKuvUKaA640SrOtTbdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 02:16:49 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Thu, 14 Sep 2023
 02:16:48 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "\"Mike Rapoport (IBM)\"" <rppt@kernel.org>,
        stable@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v3 1/5] mm/cma: use nth_page() in place of direct struct
 page manipulation.
Date:   Wed, 13 Sep 2023 22:16:45 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <5C626EBA-B115-4A95-8D55-5EE28C872419@nvidia.com>
In-Reply-To: <20230913201248.452081-2-zi.yan@sent.com>
References: <20230913201248.452081-1-zi.yan@sent.com>
 <20230913201248.452081-2-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C2A8DF3E-1036-4587-83EB-DD708647DBC0_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:36e::12) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: adf80782-0357-431e-aa7e-08dbb4c8a68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtyjjRYGUBkTnUHKcg7RBXmQa235o9A2iKREbv1ITXupAS/YaxWjH7O53l3JaTF0sshjQHN7pTVWZGi/j38cFIsH8evwMHCv2Q6mIRjg9mDovdfiMkbHRiEAWag6/skxIQ4EHzXXpMvbyCGZIUPPMlhEgFwElmOROc4SVgmDfH02QWf4hQTKr55OfbjcPnkBwWIWwtrrlsE3djrIi8O1UlhkETiUdVftJIfy9nihEHxSpZ3JJWRaT7SkGUQY+Xz26udFAEvDIiYJ2Nj/e2tTlX83un5w00ijHANtMfudpbMWsaqNvdd0ABEif7cWYyL45P45+kD9NhkgdtqiYv0qb9bMB5nfI5e8GTWgvRBQcyFAB+FfOwB2fZcWJctQ5VAL6EeB9GlKJRmH4uBaB3JXDcbebMmP2ThP8NqWOD3G+/OE32J2kcmoPYEdO/B3z5MCyuNKi4bIyOrSFb3CJ+Xhvc3WD2tGVaSw6BBtW7kXk0X/0HvYx1CUyElb1UiAger7yqoa/ZUGevPZi/waLtkSSJIFxLsfZoCshPyskRuZUMhUd0jxHYRcOjMGOK/2MU+Yzio3uZm2K4wpvuo/FwbpgdXRst1lE0H4DeqgyMX8miWlNb83o8ZLCJH4kqX2zdiD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(186009)(1800799009)(451199024)(66476007)(478600001)(6666004)(6486002)(66946007)(6506007)(26005)(66556008)(6512007)(2616005)(2906002)(54906003)(8676002)(8936002)(316002)(53546011)(41300700001)(4326008)(235185007)(86362001)(36756003)(33656002)(5660300002)(38100700002)(7416002)(83380400001)(66899024)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v/nlA+ZFmQm2qW9soX4D6MMuFkJJUxlCgmj3E9eo/g8Y50AW900PIz6pXjNk?=
 =?us-ascii?Q?MuYKNxzbK9bnp5BDqs9B3W2G4uO7AOS6ow2sgJ+wj+NKbTo9QIUzMQ9yGFTj?=
 =?us-ascii?Q?p07rafj+/X1Q7tIyItfATXV7kc/XYeWXnQeuUuuwxM4Oy4EbUnv3sMhJYHSA?=
 =?us-ascii?Q?8Pe5yjDraJt+qtB6UF8wHk8YEOnL0mP6YAVIXBgw5SvxmvcCQa2w3OhS69Kl?=
 =?us-ascii?Q?lhs5oofDDatWCbDft2gfBcl/HdQFNRmsdZOPvu0j1pUgPwCQxPVHGzftYwjV?=
 =?us-ascii?Q?JPSgVlYakZDn5/nD39mVG+F3Wz1naAdjDCU6sNTP4BOtE7srAUI9zgdaqEAc?=
 =?us-ascii?Q?Ae9njlZ+Sij7Me0Hn0zoz1nHVpPycdP9nFQfC0nloUTsNA3dAybQlLxRi8Sx?=
 =?us-ascii?Q?gHavb+gwlGY58pxKpgvsXqdd8hCAmzeLqdhyl3lFMop3GVHOLArwxwSJ9yCl?=
 =?us-ascii?Q?4RvyGSdKY6I+043bHmyGmv6EzfRppZvgEQVEUYSeonnpRhruN2PQyKDqdid+?=
 =?us-ascii?Q?9awazwOMRzGvqBKPFa+X+sGMwoXvI6++NSuu93ENinBjBs6qQAH5JR/DNXAk?=
 =?us-ascii?Q?nbnGXRUPx4znb+2PDHFWnUY40t6Bp8W8PDbPiK9N4Q/oIphA9Au+aA1r8nVb?=
 =?us-ascii?Q?5FGAn3xN7DO2DsCGtC55LdpoKmnkJXixFulCNTXIUAdZTTAVASi7mRNfAV2Y?=
 =?us-ascii?Q?OtT4jmQz/+7RqurzeFmlWnz8aZ1cNTlbQgsENoyc11Bw6EWB7EwKID8adyJq?=
 =?us-ascii?Q?tIV3Y6GwjQprZGfVQtVPTjf+gfxHEt5UbZCquP+VbIDKwvjomEqPBn0lgEnd?=
 =?us-ascii?Q?mDyQTf5UTiffk7rLifmJNZkFR0Cis2Fxuk8BuhQ8mqnh9Bmqt6ymDpZAKNt7?=
 =?us-ascii?Q?4XcEc2gUqbTu1O7BPmZk/QmC+hDnH9psySnoefBsJsGj1JtvGKl7z6zm+zvc?=
 =?us-ascii?Q?78REuMXLJ871qD5VX5JPvgrJsm8x2fYnFrS92BGTnGmPCLptXSYZ/9wdUiQr?=
 =?us-ascii?Q?75DKkQQHlt5rzfZ7uCEPN/Izvbh1R1MUdENIp2/TW3aJ+wjhhqyMPslm5rVO?=
 =?us-ascii?Q?QtLVoPr/paJtOoUTj8MlSrf5xkuL8V+eDNl7Y963YNpl/wC53tibRIWwy2Ew?=
 =?us-ascii?Q?xJu4YnyLkM1RnD0kvftY0fMWtHaNbIlvk7NJnWfHLZ/lAln41pMZWZ7q+jeB?=
 =?us-ascii?Q?zzYHeLjAlAZW6Hvi3Oy65PwscfTDnJbFcpSP753Ef6KW5tPG8wPq/3tycFgf?=
 =?us-ascii?Q?7xIT9+GIadaSJdVY1U2KBlBJ/882spwRSJoR5iVZdr+sdgmI19q/Cbeb+f9v?=
 =?us-ascii?Q?FmJ0knoMrTPeAIKhXGkPTKK9wP79dj4JUkwx9CzCgIEjlOK49KzkVeEBy3tl?=
 =?us-ascii?Q?Zilny4xOoA2XK5k6fHfnRAyRlkEMydc9cXJyw+moXyVsAC1ICtU8YD41x6E6?=
 =?us-ascii?Q?ZjertcWqgpVUdtoNE+a81HxvX9dt0HZiZbknRxOmfJU5gG/29TxtolVo5swL?=
 =?us-ascii?Q?GW7IrAMU4G+NQ9PG4QbFG1q+9WmlOP1Z0k/vRBlRdlrEOA38ajgpcAorlmF4?=
 =?us-ascii?Q?45fGKPCzoUjDYKFJcFw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf80782-0357-431e-aa7e-08dbb4c8a68e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:16:48.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfNyBEFxVVyD0kcUK554j3aXwRLZSFc4jIi0eUFylcDWS3Br8r6gI0fM1nZRX/nm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C2A8DF3E-1036-4587-83EB-DD708647DBC0_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Sep 2023, at 16:12, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> When dealing with hugetlb pages, manipulating struct page pointers
> directly can get to wrong struct page, since struct page is not guarant=
eed
> to be contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handle=

> it properly.
>
> Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated v=
ia pagealloc")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index da2967c6a223..2b2494fd6b59 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -505,7 +505,7 @@ struct page *cma_alloc(struct cma *cma, unsigned lo=
ng count,
>  	 */
>  	if (page) {
>  		for (i =3D 0; i < count; i++)
> -			page_kasan_tag_reset(page + i);
> +			page_kasan_tag_reset(nth_page(page, i));
>  	}
>
>  	if (ret && !no_warn) {
> -- =

> 2.40.1

Without the fix, page_kasan_tag_reset() could reset wrong page tags, caus=
ing
a wrong kasan result. No related bug is reported. The fix comes from code=

inspection.


--
Best Regards,
Yan, Zi

--=_MailMate_C2A8DF3E-1036-4587-83EB-DD708647DBC0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUCbQ0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUoOAP/R8enmQLATpTVW91NssR7y5eb7jgf7nRJCTQ
I7P2dNHFBJnGy0209OyQklHCXI35WpX+i0ZO0b/4/BS+YK2kocTtNYIHOCHT/djF
0sZxG3ERA+lU7L7Uop9affKjSJVEs1kXAOQn/4I5ii75Bxl4Uu0fuk4l7HCL3ND4
ZcBpl+2+eBj8K+g6Za7iXrWASjJKAEQ+jU5mhDAh3D5muiaEk7Avein1SvTHMjTa
zA178z7t+sgGNFLG17bkh6tM9GzzZb+IWoOSKzHyzmBnzeQwBqM3Aq2xC76Kv1rp
CgVoSuyoT8Yl+s7XpztI+dPIf0OdoQ4Rbx/eXXi/fLcH9ewm5JCTqubOEiK964YH
4mOJGNltUEBDRdgAvuZoywhGWhivPfNjvkk5Hcab/D+x2Mtgr/tbLFjLvTZ1bQmK
ysZEPKdU/4U08cgE9QVnFs0WqiUhwszNJ9Thm3pKw+PAcTPxKlAQSZAy3hH/fyZI
iywWiim90PTVye02ES/w6aDH9SAHfAqIooPLhLWzYhRzwS//UUmgCkDsRiYTIZsk
IaA0viPWTZC07YoFfCPyY/5h8v3uwDw8hODJajEa0n7wd0grtD4wtAOL5070L2oJ
Dlt43P6amXkJYEogAkmdq72xWuA+fNnVtMw69I+TkbxdSqYeT6y1mRyIguMM9X6e
y9dIYd5Z
=cxb7
-----END PGP SIGNATURE-----

--=_MailMate_C2A8DF3E-1036-4587-83EB-DD708647DBC0_=--
