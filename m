Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B57A78331A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjHUUPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHUUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:15:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7710BE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCRzMJ2f3YFv1dv6ZB6CN+VvZo+zDxIaBFyO4NI0uQm9uLIrk6visqlGWleg23vIwpxq/83+T5qOClLB7lfyVsGXRRmnslkskPdbqMMIBIuenZD30RNaXt8DdXK3X4alu7YUwGi9UwbiJnnbwCaDh2gQEncmsJx5T5x6F3hkX33qRbCdOYLQ2h7J8E11Dl4SNnRvpL3+R+VC1tNu3whKYUJ5z9MyJoqb3ynjwTiZmemt7O0j8AqaZupgyxq4at9DLIiq67FodQYKLBqLEI//7KznKcmGEdZtW7h0sA2+fgyGfmzLHT1XBXn9p94qNPbvAb5Tgg7vXXryphZmbujOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9l/T6w8+ESRNdq6PHh0oYHcjqTULIQDrgv2KgpYu5LY=;
 b=njakZuJ119kEaxfdoF1cN5+y7woiLQ+yJyIMlrIJaPkuM0a2OiMrwB5j7fP7NkC7/IIWmU3aAsZkWcgxmXMDzjBBSInE1tnlKxyha7wV2T5+tSMJH1BVDp+QG75I/VHZl+vOu+9fVUp0tGUrvjx+RKjsoWiVH9GCxDNH1zjXyGpXFnsoVPeLSJxQ6J/daO9TyhkXzER/HFxzKIkpUyK+A/YxErwmG1OgsCV6MgVeHCrlcXZ6KEqvpvpbcsc0mk7tnWWUI08wcnCuV9Qzio/hUdcJxbTm8eBkW6gNBcENCBEB153XwmtlM5oKcjJDL1KKVMRxArNAp8aTRoX6k9CKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l/T6w8+ESRNdq6PHh0oYHcjqTULIQDrgv2KgpYu5LY=;
 b=LPQNOznUbZUJDA7XpAAoySa9QLqgvoE65lxmey6ns62Z11opmtvapNhzl/2eqKL1OgBxLGKJFuS4PCKjpNAi0B0E5oC2NoEZfeTlnlJwSpK1VXRDz4E9KEjtgdAl8B2SxF5f3RIvYjl4MfgYPFr5JYRV5umijcG6mxGTDulZTw/cYNyZr+g1XZLFKvOXpFQtnY+T0dXs7XdFjTO4bPNurOG2hwWgBKp72MGe7o1/rq/pGazK9ik0nrhuGGwq7nsRTAvl0HzkVwbYVBY5dG1sNmGUJCKtYfQH9Z1FiMGiJNuJM8yCNgL0P1fCr+DnidjPKmhTK5mh44w3x1Vo49/JgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Mon, 21 Aug 2023 20:15:04 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:15:03 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: page_alloc: use get_pfnblock_migratetype where
 pfn available
Date:   Mon, 21 Aug 2023 16:14:59 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <21ADDEF2-A5DB-420A-BF0E-159D5FA253DF@nvidia.com>
In-Reply-To: <20230821183733.106619-2-hannes@cmpxchg.org>
References: <20230821183733.106619-1-hannes@cmpxchg.org>
 <20230821183733.106619-2-hannes@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_2D73D3F4-A435-4BB8-889C-A525DD98F6CD_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:207:3c::23) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: b647ce23-2e4c-4710-afaa-08dba2834df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m83cGbNa/g2wd8YK/mIo9wqQNuF3ND2R5PqjPhfWfv2FVsZL4d/xeKeKcuw9/e6YSVvwEMhIKmoLDp5/5RR75CevGjaL40EnrL+f2vDPjom53irbbmNylBsKUUBaDcx0vKdnZYLxEGPrsOnVVjWfzfOgzQgxRgo1nRysKt0fHwrWmxpGogZ4akB58VfAk8WwCpLFFmXSaN8Tbs1vt3PR+pVwO2SiYCsm7ER+S+KaLWj3dDkoQHX3NFOBVCLAcGi5IhIcVPxdPlToPWTQCTJJ4HbUfB9ZbOjDgu+8nZxvxqurg4INr9RLtfWfQP34O+o0RYzJhE2Lg6khHBpjr7oM3ZPzAa2DL1a9KL+Cb3t/VqMHQbp4pMBBhmF4obEbeZXpAWQxXyWHm3A1w1fCiCafPlimK+YgK+h/fQ3T+9mhyTEddFccZaQ8rVbhLksPccLUu+SgQgR6Ps176ajzw4uWcS0OQB9bOjlQMLKTyGCXVnBIMF9++Y1U8Jf2NeYkzugN+vsgotEyXdNR+0b/wOGLcO9kQCEab7PWh27ZE/8+cVUempSXFJqrCcfKyEcry81Mzfjymcw8fmGdinEvZZuD9rxzfSEz3sLGcw7xodr1C3y77JZhswkeVFw5HDk9xv7tY77BxB0bAA6PPktS/BkStQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(33656002)(36756003)(86362001)(38100700002)(235185007)(6512007)(478600001)(8936002)(2616005)(6666004)(66556008)(6916009)(6506007)(53546011)(6486002)(316002)(66946007)(66476007)(54906003)(26005)(4326008)(5660300002)(41300700001)(8676002)(2906002)(83380400001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/eMGZsoNh7dom8E3gdLJFD0JMw4g+kNZMKQRedk89KTXpz6iPuJm7WlnBMIV?=
 =?us-ascii?Q?Ynt1+6ylHhQzXR2WrQemHL7tyKdQXVywVAtia5knCWhU3yMj3+e+6ShfWt7A?=
 =?us-ascii?Q?T9xtHpx3HhXrHQMeP+majJc8uydy2Uoem1+NLPk3p0yS2KQkEfoyf3DiIRlN?=
 =?us-ascii?Q?3bj3F4yldt0+bGQIqbz0O4tsKzdoZGtpeYrrRGFWH+/to9Z7btnePcXB8AS6?=
 =?us-ascii?Q?HcwSsLkDhI76Tn9ikQ87EiNDl36vtwoE48iUdKt8Ny7aNeZtyDi6jZYfJfE0?=
 =?us-ascii?Q?hseZsZS4RBhxrBl73WLSJjMhcrqM5Nwy4YJEx9PhiX9BzY636K9kfh7eTgkx?=
 =?us-ascii?Q?NwwbonVZHy64XgUo/IaGebdXTtcfDNno2HSp08fMv668MxytxJyunjFGCv/H?=
 =?us-ascii?Q?xiUMc5d+q+vFPDzfJT6bYHUNu5beVoxTtb0KhydlaTFaos5nFe5RR2ov9OAb?=
 =?us-ascii?Q?V2ncoBUw0Q1q0vNjWviS1yh94Nh/JjECst4M1MI6r/ZxoXpt4xn1s4w35PGS?=
 =?us-ascii?Q?o8mnJMjoDp0GOoawtMtTHBHabZvGwwsd+0jjrnoo8s6rZdyQKrTtaJmUsasW?=
 =?us-ascii?Q?pmwJqRkeqd4PDKEtMqRYeb3IolVVtgWmqZ9tFaDyRUiX8HLc77eVl+CyQ9qx?=
 =?us-ascii?Q?Zj/1Egop/Pq9iqHgA1Y6jz4lMAy4F07HED9fz799It71/4SqLls9T5Cnc9tU?=
 =?us-ascii?Q?ZaTFYaqGIsN9NU4Sgh0qtfBh3aZZz57QGi21Wcruv4G1jrI+PbL1MHHwoi5o?=
 =?us-ascii?Q?hlLLcQZYtKbAWi70dltcj3TwxkyIXjFU8tFRvnvNiHyIA/ogVlgRrFyYLpwu?=
 =?us-ascii?Q?99nUs5M/YW3p2DiXoH/ROkscGcRlx4/kuyEExstIkAiU4XOQy2ZP4R3X5hpy?=
 =?us-ascii?Q?O12ODE7YlVh1I3Ww3SBArDafVXNrtZqHZUvkKXZulbQ9KpwNGLIrZ1PVgXg8?=
 =?us-ascii?Q?wH97I18ZUUkrMrcBvTx8Nc9Agqy4DDw8SXBa6xyhQWxrVNYYox5KYEy9jGux?=
 =?us-ascii?Q?FCZ4PMh4uPlpKSMWuLJHnT5rvkfRtWdAxmzT6tPTVreYhkvfSdpjvyR1/goK?=
 =?us-ascii?Q?L+ZliwfENdJS7QE7hvhIXXD2tRQQnSXwBxrHlqIjGNm9zgU7EksYbQ1gLS93?=
 =?us-ascii?Q?wNCU53lBE9lKmSA7uAX4HPNOASxbJ5kjet8L1RlUV1qv4+A3ZgH/BLzngK1N?=
 =?us-ascii?Q?kIeyfzAZwahY6kw67/yNhj3nFIfeUwKuocVvSJBFlHBv/SxucJeWqrnAe6PI?=
 =?us-ascii?Q?o27b9ihQ0gfhvEOWkHzEZ08cnH3V2Wl5ROSn5hcgH5TlM/ASVwg4+CLzcBeO?=
 =?us-ascii?Q?WZjQxjUgRaFcs1OTkFtUKNDtRYRQIbnvwY8Ff2ugzS1R3bc0j1V1UK2cwEvl?=
 =?us-ascii?Q?xBQ/cTNo43G/4ml50G56J0boP9mUp3rp7AkUFu4VNYgrW7QTrEmz3KrJwSX/?=
 =?us-ascii?Q?q3loGSRhfcaLqSpn/I78QpHmQcAnkSEHD07WrobC5yUsqMGtIoqYz2W3NvBM?=
 =?us-ascii?Q?JqIMW/Vdw+pepyJh+W9neoCSjSu/7V4IMZsXXLH5Zaz4vExcRpGsPJUwUzC2?=
 =?us-ascii?Q?WcGFDEzo2i4uRBPKUCs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b647ce23-2e4c-4710-afaa-08dba2834df0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:15:03.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYDrMQJx5npvavlgJnxwbuCodNRJjwL1iOojI+wVz5dMIRRQBX2HhjTNwimNYnhE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2D73D3F4-A435-4BB8-889C-A525DD98F6CD_=
Content-Type: text/plain

On 21 Aug 2023, at 14:33, Johannes Weiner wrote:

> Save a pfn_to_page() lookup when the pfn is right there already.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_2D73D3F4-A435-4BB8-889C-A525DD98F6CD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTjxcMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUr3kP+wZ3BIw0aB5Ulz1/g4GNVuOB38CNteNbYtr/
OM7eOPJtR8JAWfI/ZqOSXCjSQ/cyJO5WIIep3zmNaAFgZJAZIfGzCA2WspF18ykR
8yBuZk/b91aVTRetuan7Dr3aPUF7LOA4HAKybZfIi2Qf2zIGEJy5sytz2CRiNmvy
NmHfOEvHZKTEP9E6Nrgqk+Uae1lL70ij4I5PRJXjlitfNWn2hKcI/pU8PPgAtY+I
obFXJumrxHTY9Tw5RlR5jBjX1nOOzZSWrWKePly3c8ZykLXt7ybycp9sc6VT4/nj
XmhMWz5CxxQ702zrDw3KMJ/lY/5hbzd34Vb9Ban40kOmA6VlQQjc+IlieoP3R6uM
ba1FV0JtdX7X6F31eLyHr6FyPGr8M1keVt+Z3arVwLu1xcHJ/Do5UX2Bt/7Z6ZWW
p6d7xoE4cU3Fank2PHBsGidNqQ5VHChL1g2xSSqzZbBhrWNNgasxyU0U/zN4Kgek
09yrtg8bjxjfWre/sDpk+hZN9U63JrxmmDUk4niYRKql3QXA4qIRNB57+RK08uRj
al6eG7nBW1CKy3NXCDdyr6EB9c3qzYBGqaGW6tUprBrBVBAx9q0sVhnjvf8ETEfB
q1k9HhpbMkHri/N/SU8diG89UdF293PIqHu5AyksMFlLLMxlegCfy3k8Qt6etbWb
7KQdSTV8
=svHv
-----END PGP SIGNATURE-----

--=_MailMate_2D73D3F4-A435-4BB8-889C-A525DD98F6CD_=--
