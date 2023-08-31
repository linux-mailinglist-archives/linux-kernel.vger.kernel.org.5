Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7639578F078
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244559AbjHaPiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbjHaPiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:38:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AD4A3;
        Thu, 31 Aug 2023 08:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRgJE2me49p/7z26e3XFEAG1+1HSGW0BRNw2cQPuN/24YvaBPlJEA6zr7VnyfJ3OlPhWsGR0Uoc1khCUI7SxyNj1qWO1ZHxif1KXI+o9n/jKUvBrlXdBPZNAbsYzMrn3euqBz/4chEJLuQkWIZHr648oNt9hxo8SnpLWKUO9sGmeXHXg7JMFlcFhNJJc5NWY7TXQykRpdGn/vPOpj7MqVpeKFaV+4D7tTAlFBIBkXo+MWHo8/WVAymMnAiHBciyEyt++4sQW37fZJE8Xba+KVrVw5PaE/vNNrHKiqP9Qcz54vs+Y7nVhO6Czc5fno4oQfZnTl9Bto8M9/cxDKOEkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7+sQOShBlsYiBmCvJLI5CgGUC2BooNsA2tDlc7nXUM=;
 b=YBW0nWSJk8rfLAuGjJcsfEJ3ocknVfkjhKhcOZUNSbJw+2S6QlgYQSTef0Ez1pKKk4IHBHNJKvPXkvjKYPh5G89k9r6c/vlFqZXASmF4ylwa2Uf8pnzAnq0Uyzxg3PoUD+eQrgMq98KWxAo0PTPD7grdfhwg17kcKaA9blXew6jtYtQoEE1MwmGTgrW85Fx27xjYv3KyWp8ZjZtfr/SjEIj2b4n2pjI28dQc1Z2VxjrAPt62gI7+gO09rkOOtcPNhqCSchAdAClbMvbGLPTqE4KWMfC6Dd2A1ZYsln6xcBsmT+0q2W9u1pmxtsNQt3Q5uj9s4mQmsLDmwJhT3Ap7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7+sQOShBlsYiBmCvJLI5CgGUC2BooNsA2tDlc7nXUM=;
 b=Ce8GXhlZk2dRPEydFAFp0vA9oqwkQJ18jsp+Un/oWLJZwf+T1Wnwg8rrGzbzAFZv4NfVF+2D+pdMYebgODj9lzlX2F4IgggAzB4B35EEH441nFwDF3dxW0NAVjuKuxgAv57FnKKGBaM9o80CCR1SQj9PwIltB9lsULZPHDZ/bTQxVUjmq5qiPRQVIW1Vk9I8hdg1SWFXP1FGgxJKWUl+e640Ln1I5/Ziu6o0CuMuhfSxWC16J6sPCMYbUdQKe7p/Z2QmJVAF6plvnQioQv4GdndgfI8QMUg979pg8JRjM5PdWTxP/pkJEuSHDJpNVKZWiTplcwGrncYNLEVN5VtLvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 15:37:57 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%6]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 15:37:57 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "\"Mike Rapoport (IBM)\"" <rppt@kernel.org>
Subject: Re: [PATCH 1/3] mm: use nth_page() in place of direct struct page
 manipulation.
Date:   Thu, 31 Aug 2023 11:37:56 -0400
X-Mailer: MailMate (1.14r5978)
Message-ID: <31F029DA-E93C-49B5-9062-5010B0F5ADB5@nvidia.com>
In-Reply-To: <A40C2788-050A-4A1D-8804-5B718B72E879@linux.dev>
References: <20230830182753.55367-1-zi.yan@sent.com>
 <20230830182753.55367-2-zi.yan@sent.com>
 <A40C2788-050A-4A1D-8804-5B718B72E879@linux.dev>
Content-Type: multipart/signed;
 boundary="=_MailMate_AD232D40-28CD-460B-97D1-737B695604EB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0045.namprd20.prod.outlook.com
 (2603:10b6:208:235::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 1438e55f-490d-40ba-4e1c-08dbaa384015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gwnc+YaKUAkyOnRMs1naIgASGKk0pBr/YF3wp4jR4FTy/T/Eb5pJMfGLSfkRVNC2U/aVlsinhO+Hvhr2+eVZ9jbvJZ0ovuwQrX9yE9i/FOOfNVUqVxRS/zowhuZtSYRnqdjgderRvtJq/jXoZyGS9wAkviJ4/5PrQFumGWQozOT0wcFdHPIEljXzvsTjfWrY19L8pP3obynLyWDGSI9MgQhn9+K6XdWkjg0w/bbpiyaT6a5oGK6gmW5wAoJ7IIshL8hzOUGpQfCSR6nS304vWp4LOOzdA0ha1NavVAGT8r9QnHE0u4pihxa3iYjZQAIoExAqEZeSOqtaRD9IPj1zapjBGMvex/nBD5A5MYMYxF0tCfmeFV+7db2oHeANBiG4CV83Y/NTHqUrNaIZ/5scpS0jMm3PQXaEgfJ1qR3nOKzFIegABcEFWMIK0aHo9vQbRb4tox7u+M8OOveJRXXRAQswBQv2RsOfO6CpIxa2b4H/w9l+ym+CIXjQGBFc0pXJzIIjhKdxz+wxmjyZV0P1LJskMPbtt2PftYiuvZbBX3RJhrzWsJaHGB6uCgoCk//H6EkVU3AUEzKeWkW3iK4wfl9N9yZsbQ+GnXsWyovJFty4iL3I1NXuC4njoFg35xWq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(1800799009)(451199024)(186009)(41300700001)(8936002)(66556008)(8676002)(4326008)(478600001)(66476007)(6486002)(66946007)(6916009)(316002)(2616005)(6506007)(26005)(53546011)(54906003)(6512007)(2906002)(38100700002)(5660300002)(33656002)(36756003)(7416002)(86362001)(235185007)(66899024)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SphgHXEPSaIGwUlNPD4T2DSiBazKQbI9PcA0aYtFQF7pQCpMIsp3oKbfuKQg?=
 =?us-ascii?Q?Ap7uJACKll2vG6N19ubj0kBeTuDqDvVjsafzpVgu0Sv5kw8DGIxvzb15w7Jk?=
 =?us-ascii?Q?V7hiY3Xj/q0S134HjRLrW06pz2ZjFgRV0p/ICwOeu0dZ6ESSsmBrPyhWfW8+?=
 =?us-ascii?Q?4NmPQK6AJoTIxriVp8TpYTQzIkETVkR17jG8d6Co/AjTq+PbY3JO5zco+9YH?=
 =?us-ascii?Q?I3MAGx4vDpBNvsKCnSeO9kYMQohp/bm1yKN4jIp7MADNKrHi/VsKFWlH5QeX?=
 =?us-ascii?Q?N4vYj/VP4bbOQtwEggt4T3HdNZhfTp0YVBBaz9YPZVXbYN5DL6fJKFwgJsnJ?=
 =?us-ascii?Q?tw3q61QZm65II0lzEpm+F2ZipAaC0ao8Klqb83bX/l1JuJ9895jr3klTicnc?=
 =?us-ascii?Q?tr/+FIBS947By9V6UttgLY0nhJXGjJ6xIwS7IVafDSaZT0YW665xPmyiXMlR?=
 =?us-ascii?Q?IrfJ6GKutt+qMAt/c4/cqn2r2r2OZOUTFZUZSo0f6u4QG1zt2MueeUAlGjmJ?=
 =?us-ascii?Q?lWxivryQrN+R9P88r4/LPZL+0oQyO4F5+dAqQ1MEgZ38Uyt3xyuexCghX9Ue?=
 =?us-ascii?Q?6a4TFZFKKkul0NR3ch5P/ii5yfHNDmQXSkCRjyRTTvqxLG7Kd03SdyV7guQ5?=
 =?us-ascii?Q?JeJanvIQjYXDJyZFczqyz3tc4dUf5AHug7JIYq+ksyGkbtO/wkORBsrmyyhM?=
 =?us-ascii?Q?aSwnIQD+oX/BzdQ9w+cQvqWhK6+IHUwW6aSP9rh5BGYnPqQhSXY+UCf5pxNL?=
 =?us-ascii?Q?1NGBw6kl1N0DkSHm9C1eHYj0s2ITuYVbGcHpC0vFEO028bLi9CFpXgcs3HZ2?=
 =?us-ascii?Q?Rvpl6KVfmcKk1SVYmPz2ixa6iGOny5cvb+E/ERR08uWBOCrKUZd1K893+xf2?=
 =?us-ascii?Q?VCpWlLjs8Lgh9tx7gU9PABe1nIRzZTJRJNCubJZw8xVRln8doszo/uN1tbEz?=
 =?us-ascii?Q?P4mqme9lzBivhMVKU9jkEg6NhFv4Pl/XFNH2KMiknHKVtMbOLbUENGpVZ0kq?=
 =?us-ascii?Q?jIK+e9mtMUidldjEYdkkA0Ow3EU78RytArX6J11mIKtXM9FANn8uQ6MiwMJl?=
 =?us-ascii?Q?1N1Welfrqaoz5CcrSNUOsULoUzl070nI7VMKtgqQ/8att7NICMc0/sXlgXUX?=
 =?us-ascii?Q?hD85gdxsN1mXMaOORUAyYJPOgnyd2UIPvGip1iL78Xjl5lycViM0urRrsAkK?=
 =?us-ascii?Q?pOdndyL4ss/0djaer02qMosUVDmPbAc8StbCqJRly6SaSyupgxFLCL86/+eL?=
 =?us-ascii?Q?tFs4uuQT1gqucZxo26RHC8Gtl3dbLiAKS+dt/0iYbW7z24vljhoe115faPjj?=
 =?us-ascii?Q?yfe6S+BJ/7g+myX29IS591wIiVnz5DiSjiKNvPhlTu0i2gMkaWcpvw3adGYi?=
 =?us-ascii?Q?CuqvAJVv3fKLYpRQ+4KxAMiAbvQ/0vmzb43re0i253eURBmdjZpDpwg/mfeZ?=
 =?us-ascii?Q?CAoHKhz7p1sqHcGyoeyqv6l2kyK6tPULjMM3qZG9T52UapzYN8udtPvSS1Vs?=
 =?us-ascii?Q?ixzkQdUUmcIwQPazmL+7tTXKJ/MLTeFoEiNjTqbeIoeehcREJQ2p7evAMCRY?=
 =?us-ascii?Q?Y6/Q1gFyGnKXu8RoE6yNL8k+3QQwmM5gCQ/rSntD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1438e55f-490d-40ba-4e1c-08dbaa384015
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:37:57.4554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLiAIXy4zzqT3f6j1EMisLgs/2Ord9Eh1HUVRVYoQ1MjEBj3Z4E0zt8Biw/EUJvC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_AD232D40-28CD-460B-97D1-737B695604EB_=
Content-Type: text/plain

On 31 Aug 2023, at 3:14, Muchun Song wrote:

>> On Aug 31, 2023, at 02:27, Zi Yan <zi.yan@sent.com> wrote:
>>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> When dealing with hugetlb pages, manipulating struct page pointers
>> directly can get to wrong struct page, since struct page is not guaranteed
>> to be contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handle
>> it properly.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>
> Maybe 3 separate patches would be better for backporting purpose.
Sure. Will split it and add Fixes in the next version.

--
Best Regards,
Yan, Zi

--=_MailMate_AD232D40-28CD-460B-97D1-737B695604EB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTws9QPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUwmEP/0BOropLaALkVh94JnDAPDOptxDXmFXZ7y+M
sjfFor0lOuC2AFP30XDDjgXa2pkwSEJI97fapIPDZ7Uj+vGTBLAPqqCsHP1n768i
EPtzXDDiMz4YNQv2MjwPElpQTDb1AYLFFpubYc4UVGE/zRo+bP9s9+BN1Phfx5Kz
w9kcDeDWj7rbGpGUJwclu5kLtiyrnz4fMaT0RUCvdci3f1RNObIaX7FiHQYt7mNV
6ePZ5vUJ30/zA+izmRONnIdCMVNTw1/UZyfyBhAmd1aR15BtgAzItK+tW0PrabdD
9A7nC2fe8JEZU6FOItdSBgtvZDML7wxQIwY2wcP9Y3R6oxJ8DlX3wyCvGw8NfBVk
Cr0iij1ePXzR80VJbGoIY0QT3KvxqBGKsgTgs5m9//prjQ/WzZUP2T+mY8OCmVjs
9ATUcNTSHie5lKKq7C6GMRO4e8TE2S1yiL9h2/gr9a9I/4w1fJmCkwvysI9WbBFs
Eqms/mx2YZg6+qMjHIWmzBYJuCaMU3n0hiITLr7m7IdGhywfzDoGXR2kbu4OHO08
ghJruh0+jjzs5+cz+6SwIc8FllZxjyWWvzL5BgzX9JTo5wos+PS4zi+fBrmp4lhU
431yhNK3R2eh/zbWAbn8n+JhAbaPZ09x2VVq0AO8RukocDi+TwCLkzUSQJ2Jno6o
nKwdqn3X
=Ecd1
-----END PGP SIGNATURE-----

--=_MailMate_AD232D40-28CD-460B-97D1-737B695604EB_=--
