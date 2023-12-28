Return-Path: <linux-kernel+bounces-12866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F19B81FB66
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 22:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7611F2406C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F721094C;
	Thu, 28 Dec 2023 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iSKnTIKi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AB2107BA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9ZtCyndgwg6VqRt6pyO5vCnNT0g1dhWZhPvXBpXlCwZhmcuhmu1Sul2Bir+h7C+mRVlcEgmwZvbdbGPiBv8/ZBINlB/+kGmosz6OF3FEKVHqH3B01QUCX44tdEMTwdklPqoXBW9SPJZ+jbr7kuFQaI/HTFsM6Ho4wel/PWj4LlF2JzGkHUrSWvZo7BmEbH7IMcvr4BJkn+SxNvXdA3FCz5HyVoI76zPnc6WTd0HdaSZEPib09dFcMJZvBNZVo1SNNLbl2dB9yRC8biKd6hmG7IFCt4U3eROClIMvUrol9qMxljXx2ytrJu0VzCaObkFGPFKg5B+J961pcIVPaSt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28yIvzybJeqZ+k4jckTJpVo8/su9pNAHrU08S7EcTXU=;
 b=XFP+dzeV3mngIxDCzII6T1bl/3diUt8qPfUEseKT7KjRmfP8ej/rDo6B3rH0aruYCdPygEiAe9FInZilhcD/kcG6GfCkGesGwuZqPcfvRdKrB1SLum8sQ/c1Yk8u8qwG4WLYkagFb7MJfqxFIo56d/8ZX9OjJF67yI39NmCWN4izR67u5VCSwAQjdM+SeqYQw0Etp7Pm94vzzE/LMTyElYNTPcTh6F6GoaNx0GQpM/EK4NGas8H1BItepGXbG+qThlKJz2QthvodG5TIOfp9UgJJBjB/FoaAcWR3CdIjxaE4w+unlGWaegG4szKkixyWlf86YWJoBqsbqJaZLmE3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28yIvzybJeqZ+k4jckTJpVo8/su9pNAHrU08S7EcTXU=;
 b=iSKnTIKih4d9egGsV2QrFMYPQaYQYiy57Uz7Ar8GpmifNuRyn2ljVYIUwrBtQIxlQOGeo18FuG1mhnLgGpW3Kqw4rd8ok8N9XCnS9OXfMaw+MIOvgwtrXAn6VJaiVKoSuPzVrTgT2TOe1qvpzxut6y+cp7HDzqhLEbG1OSqMHODmYzyQJaQhqqkDAUXHNq327meXAVADhMeRND0QLObgy6UWUym8snq/BKLb0URBUacGTgObeq+rzkHM0JDq+TlzQL7zihoY8fxKCJ3OXSPdocbmJGnRpZhaSzP8155VVasi7G1YpTIPxjN1OlS3uHmJ2Zlic3BUEItx5wAAIZfeTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.20; Thu, 28 Dec 2023 21:32:07 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324%5]) with mapi id 15.20.7113.029; Thu, 28 Dec 2023
 21:32:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: "\"Kirill A. Shutemov\"" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH, REBASED 1/2] mm, treewide: Introduce NR_PAGE_ORDERS
Date: Thu, 28 Dec 2023 16:32:05 -0500
X-Mailer: MailMate (1.14r5994)
Message-ID: <76DD70AA-1394-4E98-BFAE-94DF22506DB5@nvidia.com>
In-Reply-To: <20231228144704.14033-1-kirill.shutemov@linux.intel.com>
References: <20231228144704.14033-1-kirill.shutemov@linux.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_20E676BE-0EF5-4451-AD81-941849FF7239_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:208:a8::32) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: a467a26e-fbb2-4aee-7aa9-08dc07ec7167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FE71mU7H78agH5u/3t5Fll6LNcmMPwDIXFebmkuwrjoBnJdBdzyXkwSODhJ4AIniF2JCJcrchIbdK4XP46Fl0d4TK1UEhHTyMGTHiZ9hK+gZCTRuCfABx4WMUeh6azrqshQGQjmiSXNmNVdHf9qxCfPtkZOf6GXfBB5fiAqW1NGqiuBM6uf3EIY071rm2vqAcQvvEVYJB2KGviRv3dR9670WDTfWYB+UF3TGb7vhHBhqvL2Onmaxgp+Pfy6YJtdb/at6OopGlF6OrayT1GtAXYzEFa3UOJDFJTJoDnDTA0aDyuPVxFqLfKMaLhSj0obcBOVfLoMaRmwW+GZVlzQvN3I0FoiSxXI05xErF5VfXt/f6qpDuSw/80gYbs5EDAmXi3yLS+pViQu/FbsjQDf5msF8m2XOlM1mBb4mLrqHCAntmmMNMkAUHqu/Uz5ilb9EKhcDXN9WgEId81RnCJUgCH0sT2NmqZcpervTuHMdUQWn2p0eQeXeDLpqBy6y8b0vstyAaPHz4npOMymZlgbQEIYFcJPt2Be/hABKJLQLmNoV1dtuXDc5Nb8Uy/lLkpJYEJ5dWCGMcEXUWqpNX+MNq2gucoqeemtsJKI8AVVeQW2rn75ZpumqWBzh2+AviPzo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(86362001)(6512007)(6506007)(83380400001)(478600001)(8676002)(4326008)(66476007)(66946007)(66556008)(6486002)(6916009)(2616005)(54906003)(316002)(26005)(36756003)(8936002)(53546011)(33656002)(235185007)(41300700001)(5660300002)(2906002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D+vkuTVT8N5gnJjALbS6D3CLu1CK9wJumsWdfoWTEdAyKCPVHVKfDZtdE/4z?=
 =?us-ascii?Q?Ya2TWIrGLr57b6B/G/3vnX5L0zM7uiqi5RBC23KPRSVcnAUoeZZ0QhSOpsAn?=
 =?us-ascii?Q?RvurmpKcXejIo3yTKBxhXa4Pirg01kDRpQNGfMnhV7RXIgTsAoxpiB8vyKIx?=
 =?us-ascii?Q?SWuHb5fHgvWekCJJlWaYZRrNibV6AX5kFy8gASLYi8v8nXcnDtFdXDblA6Hu?=
 =?us-ascii?Q?GLKxivv7A0Qv73gUNpXcLCRgOyGSPiadRGWb46ajy41faUXnQa4a3wa2eZak?=
 =?us-ascii?Q?zgLk0G8ynQeJZHBlqo9iB5tVPcsaV571UkqPKvUpdhtyv5PaotjCoG3s8PWo?=
 =?us-ascii?Q?Twu7Vi9VAFWSiYcyEwwBM8BC/xPoeq7STPWKinCjN3Gl3E5fOBGrO6ZgvfYl?=
 =?us-ascii?Q?J5RmRJSc5xB91MHgpdJW1O1mGBsgWVSngjUGGtKPhA6qSxbJychbdr6J8hMO?=
 =?us-ascii?Q?htBPMY5CdjVZVbqBShoMVoRM4RdRpEmr4F28rx1W1lClR1sIU+SCLQXWPBpC?=
 =?us-ascii?Q?AU2JtePvZhd/x/kd27h6R5vSiFGkhelGRHzBrhqHIOb6xS8JYv0sGHGdGjFW?=
 =?us-ascii?Q?JdqhP7P2xZrWALQh9LiI8tALrClcVsa5jqIjGQofJALtIJpBApVcxcy11IIy?=
 =?us-ascii?Q?aoF70XetQtCjpzINBUsMzrRqsYiTMzCo40WH9gv8nNAsyvUXu6HMcxyBcWdB?=
 =?us-ascii?Q?oxufQBVSf7rJZqHGMR8lxRHNrQSecyil75t1aEvj/cpu+GqK5jcZrhVGmIZV?=
 =?us-ascii?Q?6SYSRdquCwLk2QzFRpcSeXSoaqceFxA6cVMQjqPZERkzdVdO1ybYanXPDgAA?=
 =?us-ascii?Q?4h47X/7g541Tdq1vtiYE8ILbvIpqaz1Akhfpu3hv0glnZ6iAvUDZZbIpotoc?=
 =?us-ascii?Q?nvbFdOL9ZM6aB5cwuzWPxZI6SlicQw2lx9YByBnHaKra+f93f17nxH00yYvG?=
 =?us-ascii?Q?C/YxDh7TsUFdDdtziyIkjg01v7VYfdjYqdiheDeDAPjnrVdOXm0ylu+1zOeU?=
 =?us-ascii?Q?TSopLB54TaLEGf7wMB+wE2tM7jURad8qPtdQTfYPIGpPtbpyg+XVorF4KLyc?=
 =?us-ascii?Q?a4Id14MEAPwODUj0e1III99FzowOrrmfRZ5chpoje1KvjJz0KlrjQFUYtGYN?=
 =?us-ascii?Q?J8xwZHBtOk0zSw9DOAmnFcZeVnwuVjEy/NWj9AEmwHP8qiBSAOneq1a+FlVX?=
 =?us-ascii?Q?/qdM+0TlIOyAV86UmEMvJZn8ralpTz5nkyt3Mt1r09ZTygPPK043PicmnhVn?=
 =?us-ascii?Q?MxfPG2x2zaY27yCJsx8Jcxln4+zFcARFqXBOpiBloWhGwxWTw7++XXrcg1z+?=
 =?us-ascii?Q?eMlfTq5oaNKNWufJ7fh3lieV064npfpktgBZ1tQYTXuQctjtC2yQ4xg7d9wn?=
 =?us-ascii?Q?Ho4CnFlqEr9sDbYX5hr6Npzke75gRYBhoNJa37v2uRoMusIp4Rr92Cz610fL?=
 =?us-ascii?Q?BFU9V66UFZYLhk2CITT12ukAvYfx3nmygLcA7aMPbOK0B48Dwf6mQ0feUqwo?=
 =?us-ascii?Q?fnnLpT/Xsa+XQGe0lTvLGcw29LAcwzdrc1xJWoRpcoIsY6iT747DHktuoGxf?=
 =?us-ascii?Q?b4deiHG4/KNpbLv8XwPTAELkErQM9yKkVkrWHxgg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a467a26e-fbb2-4aee-7aa9-08dc07ec7167
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 21:32:07.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUmLShvWqdpXP780u9oEQgnEcO1oH5QOvX+Lfv35crvqs4Y/h4FSnErD/eU0vzmE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108

--=_MailMate_20E676BE-0EF5-4451-AD81-941849FF7239_=
Content-Type: text/plain

On 28 Dec 2023, at 9:47, Kirill A. Shutemov wrote:

> NR_PAGE_ORDERS defines the number of page orders supported by the page
> allocator, ranging from 0 to MAX_ORDER, MAX_ORDER + 1 in total.
>
> NR_PAGE_ORDERS assists in defining arrays of page orders and allows for
> more natural iteration over them.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  .../admin-guide/kdump/vmcoreinfo.rst          |  4 ++--
>  arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  2 +-
>  arch/sparc/kernel/traps_64.c                  |  2 +-
>  drivers/gpu/drm/ttm/tests/ttm_device_test.c   |  2 +-
>  drivers/gpu/drm/ttm/ttm_pool.c                | 20 +++++++++----------
>  include/drm/ttm/ttm_pool.h                    |  2 +-
>  include/linux/mmzone.h                        |  6 ++++--
>  kernel/crash_core.c                           |  2 +-
>  lib/test_meminit.c                            |  2 +-
>  mm/compaction.c                               |  2 +-
>  mm/kmsan/init.c                               |  2 +-
>  mm/page_alloc.c                               | 13 ++++++------
>  mm/page_reporting.c                           |  2 +-
>  mm/show_mem.c                                 |  8 ++++----
>  mm/vmstat.c                                   | 12 +++++------
>  15 files changed, 41 insertions(+), 40 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_20E676BE-0EF5-4451-AD81-941849FF7239_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmWN6VUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUkLEP/3OzicrNIO4hZVQ7ReBQ7JfYfGJwwopPBADR
E1dVdJn6WqQyGdQST8EmWmOgY+mnuAb09Mme5nIr6MrXGPtPwuUPZuZZURr1eW8k
k6WDJP/tioNogcKWFgHUGW12ICK0nVfAbSzCyE915hk4Qwwy0v/7UmfwEru7UUBQ
htYPnB/UojieX5vevNjstqKduN8qneEb3w2e5YCOgMR+OnWDlv1LQ76i+KfbLrkD
5Obk+jy8YkxDg/ldzB6uxjBQlpOHylbQE64u49sk5EzMXDpD1uVe4kWNCDSKwpLI
ElMCCftkyICTGbYxurGK7OPBtEOhlb+u+dMynoFk233TLJSIBAhVlfaSj+BgEMqz
NlUejwiAD0uNE+tR8QFNgfR6ysB1GEXFEkhdMWG9RFYddbUR9GAlMiRTie4gvj9p
oTlQ4bBjMN6U2xKukdu2qmSu0pfuI4PwjqJXQjD/AiykogZS0mp72dR+3qGyjTYJ
1THaUlK0fzcrw3H8nI3/Be5yfFY9ZOwfgttCywnPX2Gfyox6c//aZQsdCJY2eAfM
dfblvXZ6vXCMgHQs2WaHuYP17TyPpPCNgkyBpMG5Mpae2nhDvSWIfrmsY1PxKlb5
cMvcV5N/fHxnGjZ3P5x03B7zvngpUZbxxxzEhOFBRTVSBhYSdHyJbPkLIUTCgk7e
KVdAz0dM
=FgGt
-----END PGP SIGNATURE-----

--=_MailMate_20E676BE-0EF5-4451-AD81-941849FF7239_=--

