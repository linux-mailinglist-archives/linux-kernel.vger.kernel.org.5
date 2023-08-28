Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B62878B2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjH1OQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjH1OP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:15:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3368010A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcJlo8oMbb2SujiV4+C4uxHfewkk5QR+PNiO3G1zNRQJaVXlfdlwwgaJxSSwiT/qMUcDQsEclHE8SattLOobLm4QhTKi6D6wEVklhgnW+rWVgkbicVYHjCIFey4zUDlQE/tHP/lB8A4G+lKA7gXE1R5XO2NcUYrPsB4JgZa2d+9A/M5BWU/VYGo19jF3ROCAsQln2TQCcdErlzVVTFussJnwX0S1MxE0PcBsz/8uIjC/l0crveZuFG4yosKdSVVexAqO3te+Uq4bqI+TH+NPJE4PwAfp04+IruabYgLAj4RoXS7ex3u1e0ZeqQzVmu/XwUUU1wLxQHkgJXztQr/Ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o574cvxFie1rWXmc8yJB2f413Yex237TC1C1DyKa090=;
 b=adxI3ejU/0oaW/PFatnNFG/UgfN1ZxhuxGUpOvdB+3NsfxfL2e8IgqOYX8GYxsLKUpVTVbiLqBYJk8A4cWcPPkBQrMee3zid+jbD2qmCv3+ZUKhZm5RMxvoCOjQ7DzD2e6lvYfRYIcauY35z8DfhJshLNMIV+b6JJByLbwt3y2dg7agHCxERxCCufeQ4WlMFZhWwFHRxGMgNGXNSYliUPd/D1YkPF+B6vQ+9OcEd91So/y5q7+rJs2GRtAv5aX5HY+hm+s51Ic8s5+HE6HtYtAlZT2R4mqylQMnMWjaFKn1E8FRdPIvRnelfwVA04DxEUdBTCSyeEsl3iD5iNKrkCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o574cvxFie1rWXmc8yJB2f413Yex237TC1C1DyKa090=;
 b=FgL18VaBnxm1YAagPGvIuJ7D3M1sk4/+h4S6tp1qIAHQOVgbUspcZAVvtAIEyR8iVwNtgXd3I4ZL1lymF1/W3DKmxR7KjppHQINUnj4sn+7xgik96vUunt6iyW0e/uYPhtY2FuIat8naCl9ZeOD85QIb4RMsVp+e9jWztJNUKrVSDOyAXlif7kwTNFEzWWXPFlVvqNrP5fyBndz4Xtfvp/cg3vCjes1HdfRwI8uE4soY4h4NQMfM4rnwPUSoou1Z9fuGRXOZceRpBXZMu4CzslbF1PoY2r//E4eH1Rpy000aOYxLCyVACKfRveK+8mnRnbHludomvqiHglfudhFRmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 14:15:48 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 14:15:47 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, david@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, hughd@google.com
Subject: Re: [PATCH v2 7/8] mm: migrate: remove PageHead() check for HugeTLB
 in add_page_for_migration()
Date:   Mon, 28 Aug 2023 10:15:46 -0400
X-Mailer: MailMate (1.14r5971)
Message-ID: <B847C18D-984A-4811-A25B-CBEDBC769759@nvidia.com>
In-Reply-To: <20230821115624.158759-8-wangkefeng.wang@huawei.com>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
 <20230821115624.158759-8-wangkefeng.wang@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_AF280DB5-F780-4304-9519-23726690697F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:208:23b::34) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b88d70-11d1-4ab9-ed2a-08dba7d1468a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvjRpgQFPJDuYQ6DXhlvfN8vtf3mirHAsQvSWCTNAaNqxEluaAllMkVDrriFG1o3DOCjDrnNB7wU1XgGrnlzAiWQX04twWve3sUrfBoQ6OZcFUYm3X1Ay+8WC37eWWrD4w6EqHxa5LVo2lzMVBiCfsCwE5BhoMA+6S33tDcRoTpBr8h0nnRGhA7ywC71sXTYz3CixCpWl4B6BNHDfd7V3Hgjc0gUPTOtT3spv/5hNb3KkgMJfFJOzkwuzbltgU7MPiZB7l+YKNF0+D1H/Vi4iygnu7Q0GW83oAKhoE/WtVLnJQ7xAqRxuLrrsqbO4aqAVvhIOk7RfWSp53x9SX3Xz4Zc/G0EzGxw06ESHOSpFmuO9ZJ5XqpM/Jb0jnN6ERcrsJzkhhKVinLZIksbgd8QYB2CXWCCJPh92iVHcvM5WoSSsSUrLv0ytT2FiBMMa+mdPHZgTOu/hHZxl54FFTdNIEtuVeutAmazt7k7/fj0NXOfp/e9kj1USuzsksgGTX3iCZwExXtdYgEWJtwQlxtkI8sq2xBZHQmFjBURN0Bmk6jlt6f2rzWgk0T+piCXUFErWr6oJbgIfRU7MHca7NoHp+BApPGTKoChpJQfHNIC9rXGpWtaylccLd7h2CIhZJfihID89UzHZ3WATS48E/1n05XkDMZd/ObxB3KZzye2rc8d/kcEst3Yn43h1YI0k7oi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(38100700002)(86362001)(83380400001)(478600001)(966005)(2616005)(26005)(6512007)(53546011)(6486002)(6506007)(66946007)(36756003)(66476007)(54906003)(6916009)(2906002)(33656002)(66556008)(316002)(5660300002)(8676002)(8936002)(4326008)(235185007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1hQ1b7w2yu2jbH09Ht4oAejTdmnCixTC0RyTRHNJ7vterO2dy3znahODPS52?=
 =?us-ascii?Q?9YvnJ9C30Njb0xXUYosn26CV8q2Eza5CnQ6LK41X2qT/HgoYmlCQYLJ7WNrr?=
 =?us-ascii?Q?vd1YTfPW6JM5ZBZJmLlkDE/44JSnIxaqb8RTa0bSDw6lNf4jbikc2Tt3BY3G?=
 =?us-ascii?Q?6ZYk/MmqRvN99ZCuMAd6CRSUXxELzGDX03unFLnrKk9/DIDWB3beVVjNnySq?=
 =?us-ascii?Q?xxINn7ZFO1fiPacynKemQKF7XbVUHPdd4uz8MhmjLr83ON+SD0JHqQV7fbYo?=
 =?us-ascii?Q?Z2rjXIM3tJLJEAuR+hrXA4ewBOSfniACl1wLSgY8JIrzxXPkHn+WkJelFehj?=
 =?us-ascii?Q?2uJQXKU8EKrly1P1m1QrSsMI0QjRbMIXg1P94jDUMMwNopPxTU3J2FqMQkso?=
 =?us-ascii?Q?TaVa4GTTLhLGr6nyxcuJ8fDdguG9t6z5iZokNytzh1c6IDKDJ1bzSCYvgrcw?=
 =?us-ascii?Q?fSm33Nj335pDN+esYOyDQ+A5HIbw1P1kv1HwcznhrPaEDFTE8ki+9TZJYloa?=
 =?us-ascii?Q?wNktx/8exiUTVjYmuErLlm5JmIv50AxusE7Df/jhFSHRfGsJeNUAkCEyhdOw?=
 =?us-ascii?Q?0YmISojLeQaXtC5xJbP+2CNMAUShdVXUG/fOgiyg5E6Bf2NrP1+NFhIVdT9N?=
 =?us-ascii?Q?tznerGdxadp6p8aXtWddr2qIhjQQmbtkKeAB50J69Ockuo4QNocZXaf/JrzM?=
 =?us-ascii?Q?LDRfJAuIlQh91Uuz3CKkyRcA0Y4PlNoyR6XMfrFgdt+07LdhRGdK8grux2pf?=
 =?us-ascii?Q?Aa2uBvkr5+S0PlsXc3dNsqWVUcYaTU5ZrOGg8YrHGr3ahO+n1r6QukLvydVz?=
 =?us-ascii?Q?lcm3eMVcujX1fJqn8+8xbnTOOz3gn8d6bnXAIN4kj7a4d4otX583QZ+ifq4W?=
 =?us-ascii?Q?cte8LsLCypK3CEWi83djUy9pKRZ7dZlxD4ke8LNebl5vJk8xNMU0F6heaZ7u?=
 =?us-ascii?Q?FxU79CplqI98a6DzUTjhxR43LniZPdIJJs1FpDR3JMGYQ3IG2GHGdWL7XVlW?=
 =?us-ascii?Q?9U+3ukWnijh8d7G6WlYgfvVoKjOT28sJOloGmjd7RXPv1Tqru7tugh/ULMQx?=
 =?us-ascii?Q?Nmq6Ih0sWrKNgRtkhT7VgpuoklgqKu47CEcOHX8zsSxaoHmkl/+joj/fvNO+?=
 =?us-ascii?Q?3zXmie+xiCNpxllFHB9jLhTT9bQN4MI2x9tN8cWCqNyCs8rPO74D4ARuiT7d?=
 =?us-ascii?Q?qe14CDxHoYstNO+No3YoOAWLMIIkyJc/ERdTSRLJZVey1siIS2xHtaS8zXL6?=
 =?us-ascii?Q?97RfQxc/LkW2Pfk8bghuXJHvD2c7MmZFRHF32YjcNTC8UN94tZj8r8I4ecD7?=
 =?us-ascii?Q?KgKhvpg8Qi51g0/2eq9KRZfUPl0TrgtZxUNDUZT+Khx6FsZbqlfdyHICREwN?=
 =?us-ascii?Q?A6m7FPSyS3NwpH2uUZVhvSy+duIO82L/DRAmQG+u2TX43fvDqEoLl6mg77sH?=
 =?us-ascii?Q?V60aqNQs2oGHm059Uvz7TFyip8/Qx+yfFzSJLkveVbejOc3dvfbKpV/lJLK6?=
 =?us-ascii?Q?4VvgY7MAxTYKyiQS+4zhfyuFcTG6xPspdbPfuCKbCSg2oGfGvRvW66C3GryY?=
 =?us-ascii?Q?MVZe38ls9IdoEZV789E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b88d70-11d1-4ab9-ed2a-08dba7d1468a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:15:47.8507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbOTzDJNoEExTbYIG1jYDyuy1ETiD5YCDxPR8PgHuVgDdGYDg/p988mK+B4j9GI1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_AF280DB5-F780-4304-9519-23726690697F_=
Content-Type: text/plain

On 21 Aug 2023, at 7:56, Kefeng Wang wrote:

> There is some different between hugeTLB and THP behave when passed the
> address of a tail page, for THP, it will migrate the entire THP page,
> but for HugeTLB, it will return -EACCES, or -ENOENT before commit
> e66f17ff7177 ("mm/hugetlb: take page table lock in follow_huge_pmd()"),
>
>   -EACCES The page is mapped by multiple processes and can be moved
> 	  only if MPOL_MF_MOVE_ALL is specified.
>   -ENOENT The page is not present.
>
> But when check manual[1], both of the two errnos are not suitable, it
> is better to keep the same behave between hugetlb and THP when passed
> the address of a tail page, so let's just remove the PageHead() check
> for HugeTLB.
>
> [1] https://man7.org/linux/man-pages/man2/move_pages.2.html
>
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/migrate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_AF280DB5-F780-4304-9519-23726690697F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTsrBIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUhfAQAJr4DYxVGQHRi9ZgQtlJw4LKsyagvHxfsZdg
3lDPbn36ggd+udHUFNEGZMFFP1aAyWaZ1SI8De7I7F8J7CpOHPqJF0amBgKHsE8Z
bu1FHrXt75QAH124ZmjEVmPwX33VfbqK1bUvKCXN4cVcWMaSIvSCIH5TqFyYAGPO
TQdqQlDdLhuyoCwF4QLmQ/6hy4h0kZXTY3ng/VavfueEdNlZ4+WsluvFmHLeB2Ek
JWTkR9mvcEmuzAtMtfMTCR7EK96cOn0u/KYq9vpB7ATnnw2pRW1D+rAvHmOaBB67
wXPyBALyug/0uIZTHmKw2ngOX0mCoZ8s3UPabLM0oqOQBD1TJ6Y71Lg1oXpdII/i
qzkGO3qL/vYpLLpu4QKYwAkbDrdfshCJNLRCipChPbqq9zwheslK4vfS9oPI32cp
8frcLxQqn5IymEDNF1IXABs7+eE1AOY9tIm8t2ljgJZ/OuvlooqT/4oAK0Z4JAMg
RmkBY4JWO09BG+3/dKQM2WZ8IlUJPSRN0EVmbPbjDlHIOfL12If/4dan74H6SHLy
DQqh2lSpKFChwUgl7BY1EWyoV2MsyTO3IhZQJ+yA0LrQ3NADXg06wQOkD8eBS5uG
EgAf2xq3lmhPJNJQsjQ1v3GnULE/nlMkOJaLcxS7LGGNjgXY+veINpoxi6I8rs8a
eYbWLB1R
=n2ni
-----END PGP SIGNATURE-----

--=_MailMate_AF280DB5-F780-4304-9519-23726690697F_=--
