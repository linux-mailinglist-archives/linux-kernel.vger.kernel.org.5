Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950FE79BD80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbjIKVhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244403AbjIKUXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:23:33 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD10185
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1BOk3YUy0vT2KuzqO0/qOOsabpJQxswsCbNL6pGn4+GF4vF52LwaLSBOsoi2G0uGPsFWvCO67GiaR8Vu22X5ziH/2rVlH/r8RSbJD5bF1uCjGAHeP/G1zLD5smTFvJysKADrMw/rweKRRZRR2hzp+vBzafGm+rGP1HvrofN/a6DcQNbMN+tfFvyfA7w1EYkq2Z0zIvk2YCJXdNmktpYcVg9Vlnd930NoD3bbEZysGliRMOcBLt5M9p/vWLN2T70q7t9p5KBygYP9X3tglgFGJ3jWDABkckbNwdbSY6peh9WLgozZq7g0sTvLFYQQNufqKe+pxupyVYGMO3LCaC7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2hrqRROx2+ZSQb/lprOWzCRSSo2aWxVQVa0yv7F//E=;
 b=oe3PoEOoI+h3UvS8zDOuM+Vum9IGqB3UJQdQS7qyxXucHcmRsmS9V9I5DSycA4ml+/BECMHmI+vOsJ/+XhjFJdmCz0PZsE2haey35LtMu84FOuBaWscWiozSyxLMbEJPRCRDAjBSVn0I6sUssBi9qbHtzH7nBfZUsqn00kLRLwpF2hP3UjMs59xMtwsOAbBNuOM+9PP8cnKlgIBdEaVMYFJ/qsEn5wn40SjIxuX6k9Hmr+t5e/pd2kWwIjQhrR5TB/AfMr9E2NbM8VaiNvFTJukVOmHgSwz1ADctvK4blMVDqQQl3SE0CDveJcOCbEm22jOIfnKB4BMhYKXU7g4ZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2hrqRROx2+ZSQb/lprOWzCRSSo2aWxVQVa0yv7F//E=;
 b=SopBqUgWewtyxz4qkyjmg9QKgcRQUJ2IvLgaZUATfH217sw6tTmMeDCIXYk6xzcxTWR47hLgmzqHMHRzaBlHkZK4hzKosbg9J8dMi83tupt5iMAOOHZd4VfC71KoQj7F14AQAzQaHXn8jQS9QUGZkXxLhS5lnmgbeNnmRYhQbhwbvdya4hbeolkxgPL1RAFgH672Z5b/AHl5+qFjai6RN2gI6v/wNntCZ4Rm8135WzmwzCQcnVDw/iBgQVTwsHUdf9/bRegnUbKh1Qr3yu3Tfn7fo6gXjo1AYSHpdrDfT6P79fw6DUhjoyZuqGWs9r0o7Xh7XLM3bQQbLBtT8ROw0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Mon, 11 Sep 2023 20:23:24 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Mon, 11 Sep 2023
 20:23:23 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] mm: page_alloc: fix move_freepages_block() range
 error
Date:   Mon, 11 Sep 2023 16:23:21 -0400
X-Mailer: MailMate (1.14r5978)
Message-ID: <E360E257-B191-456A-8914-B5C75759C65F@nvidia.com>
In-Reply-To: <20230911195023.247694-5-hannes@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-5-hannes@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_AF023E0F-3702-455A-AF02-3736E6578BB1_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 0baec2fb-9aeb-40fd-2d4a-08dbb304f2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYEOHgJm4uXlcByHqZ2WaL38xcMQn50zaxaOB5AMRks4hV+B0qm8TVzn//QtHGeTMvjrbOv+LeQkwu6ZUQ/jLRSXb2Hqmw1Vh1tTJN8lRsRhcrM75J1tkzmsmjT6VYJBWwEDB1F/BOA3Os7lGJSeNURTsKnR+BGSrTXNK7k4BMcU3JLl2m2IcjpS5cdUmsyre7ga2erv6YyqP4ITYgiDl7IEbCPmBQVVFQSejMSAebmCGrSrKx4KbU6LTGtHS6352PdF2K7Ocj/yvOrupiigbYkT3DtCy0iwtqOXZhay5nNN1rYZp+NaFl9ICNYUdyHOZslHH04QXLPjoND2CCmONDrMcW8U8zgQp7DDq9mFZInR/0lLszues+45UqwJ9d0NaNJhBGPSIb/9bHW9JXQTdjiB/5zcAT6VtxxpKwhPCEXViF11zAQPrzN/rkkwfBNQO7HmMWlUcX//vnfbvOOWd11Vo1RxfHO/VAlMy37cteEMIIzuNM2SGuZoJPt+Gbcb4IriZmIjhzG0Cptc6sI3KvYOppwRWNypeAzAZT5W/fCwGTZTzImaBArsuyQMx4ewl27xRzp6QCQuTBIxPEA6jVPpuj+gRyZoi4gehqdJ5VC/ho+9JzGAEwytoagvyW96
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(38100700002)(86362001)(36756003)(33656002)(6512007)(478600001)(2906002)(53546011)(8676002)(4326008)(6486002)(6506007)(5660300002)(66476007)(54906003)(41300700001)(66946007)(316002)(66556008)(6916009)(235185007)(8936002)(83380400001)(2616005)(26005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LeiHCmmLvj3+aE0Lr1zbeXrGtbxXaPhJ0EVSdO0L9LIteNNpiqGmIgPpSWFC?=
 =?us-ascii?Q?JRFLZ6mk2x55/lzf0I4Hbt0Edla/6GOgReLJVdd1vUkVqaOyL0pC3+RtIXVc?=
 =?us-ascii?Q?gKqs4nF+tV0qvDiCOeqv0VEyEjHPZ1QswHG9fgAfH6Sl+Scu/5vePaOWiHom?=
 =?us-ascii?Q?CeNypwcKsoRW79+Nhwjd31q7AzYB+/YbkDdnhdPqP6mIcRfkCHNfPtcf1c+m?=
 =?us-ascii?Q?Ldlt8wUavE2X5TWmGKxHw6uU7jYkjh4UkmSz2mt19u0aGHIzHwPG2p36U5j6?=
 =?us-ascii?Q?TX84Pvn5nJn/D3CoP/Bjpbn+P9u82RiBP5PQK9uVy4zEjm/IlGs8iHIrLi8P?=
 =?us-ascii?Q?qJdpbs7wiCawRaB5OmMcVv+FrOrgndS2JATK4v+t/rK+fFvwMiUTiZ2G6fTe?=
 =?us-ascii?Q?fsAKGUzGHqaRLdhxb84ZqBWB8qjd7yn6qwCA33SftqMslWWku4u4XC8IRLOV?=
 =?us-ascii?Q?w2IVIHEYQpITq7Q5gHxARCpyEez9q2Snfzbbs1b3dslFabhncnknF+9wMF6K?=
 =?us-ascii?Q?mFUzms1m+/Sum1+Tc+4jZ0QHuORBQNy+wReUrvzlzKNoXBYur+Rb0ONu6Ecc?=
 =?us-ascii?Q?QMieVEW1PIb0ScF/eaC4byhMaz6LFldZVM/1M4i5Kohq4n5sVYlUp3TP47nY?=
 =?us-ascii?Q?r+kt4fFEhzfrZpMDiWTyAHD1Jlwilhde1KIoQY+T8C76sL2IgLPvd9jtEB8L?=
 =?us-ascii?Q?Wkrzp2w20PgBe2JL01wrQWfVCBCLr2II+JbQli2qBn5K01Qaqnvcfzdy4SiP?=
 =?us-ascii?Q?aVr9366KE0uMRHIp3WgzpSH7agigul3Q75QNzANtmsYfg8O0BimHLmkoJkZB?=
 =?us-ascii?Q?QCRqMSRKi6NXrHq/nqiiz45d2InIqiquEfnkqVKl01s2Ll3Nqd/YkiMKQoNn?=
 =?us-ascii?Q?c2mkbEkAkoT7CWi1C62IQW2oWW+kZt/8gAOeebWEPzcKW6WPXJXPumg5Erdf?=
 =?us-ascii?Q?WZYc1sMkeiTT2AA+u5KAM4VAA4TmLZ2fMg7Vuq+/bB2d+HevOp9mtTErznRZ?=
 =?us-ascii?Q?5kEenqg1oESGmDiwCnZ7IzLb38rFrtjqJUzSg9I8EQxtzoE1Eh0Q/wq1b3En?=
 =?us-ascii?Q?vJj9XlhYaNKr2XC8fKPrqUHVQKS71AqVwuYa2u87qjMz9F6b1LOoEIQQtLAt?=
 =?us-ascii?Q?0T3XrtgRKMzJ9Rh0TeuuxUThHThfraNdQcL+Q8+GVvwyEG9FfrOmDWq3uu+U?=
 =?us-ascii?Q?6ty7LsGW1icxP0Ob9S609CLoqPIQn4FN943XmqlYh5M0BPlzKhl1cUechIoC?=
 =?us-ascii?Q?96RmZGsWNutXlqHE+dp+QEs2d2ZEwop3+JzNwbCLL+G6jq9MSvRNRIR1X42S?=
 =?us-ascii?Q?HdO0hXZjs22VksPIJWwIn6BSUDt5G/5x0aEkrfobMZcakU9/KHVJfReJ5uUg?=
 =?us-ascii?Q?MHaRwoOn8LHehrji6japCD7bGnN2vxe900V2qZ0JRSNWl+UFiOQVc6K1Z/8O?=
 =?us-ascii?Q?ATKUrEzZdXZ1jmRGKEJlgodnjZ62mZI9iRGa2KX4UGhKzHlrg/pI8Y+Cb5iL?=
 =?us-ascii?Q?7sJa0gAvjrNKOcB9adMAwXEe7/egbjvmdnfgERhrkIlWgKpY+it2V+682gpm?=
 =?us-ascii?Q?99hUgU7jK1rHqWdP4kPgByTlQOqGp3dcOM0HsAWp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0baec2fb-9aeb-40fd-2d4a-08dbb304f2a9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:23:23.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXW929EZuHAw49s9tspOLkOyDfrUOnBydS2GQT4wr+5BxVS4fhnyCCkceETL9f3e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_AF023E0F-3702-455A-AF02-3736E6578BB1_=
Content-Type: text/plain

On 11 Sep 2023, at 15:41, Johannes Weiner wrote:

> When a block is partially outside the zone of the cursor page, the
> function cuts the range to the pivot page instead of the zone
> start. This can leave large parts of the block behind, which
> encourages incompatible page mixing down the line (ask for one type,
> get another), and thus long-term fragmentation.
>
> This triggers reliably on the first block in the DMA zone, whose
> start_pfn is 1. The block is stolen, but everything before the pivot
> page (which was often hundreds of pages) is left on the old list.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan, Zi

--=_MailMate_AF023E0F-3702-455A-AF02-3736E6578BB1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmT/dzkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU8wIP/1MQdY+SyJNM8MlAehjwwTP9iu/thDSXBNVB
I18xJEN4+GfUGrofZdRRK85F0a93sA6FQXwib0e4dORNPkdDQxI6uGRGXVrV7a9E
OjswNTkXDyg+sLhvIPKE5ebt0hbnLCQLEoeHFEfcWdtM4do5ZHCJXO1EUqlFNVFZ
2WsnSo4c1vLStPfcxpOKgPsYdfUt7g0FCpqVmf/nT86iUKEHva4u6fVoWMFkfxIK
1MsEOf+L+Xb6VOu+Bw1UOXjjlLU4Rdjql3mupRN7sGhkgF+IaLfAiVmKeIdK+WRJ
nv9kSK/M8fsf3X9tXGCZE7lFARV6j78VMcnME8WaMJGU1h0g7tUMGdcqt0tRTGQW
e5JP+77pgbK2wHwvKRenZWmPrQZVvMp2S6R1a9nXrFoo0/02OX5d7QU2ZqjOm0NS
eqe0d/w040gUmVi4Of10l+6QwA3oxGwkkXvmSwcrJTQkF7MlIZEYea/ia0qkicvL
U7Tc0QsK82PGNDW+tZvARpnNZ27mZhftOPVEjUizsjLc5ED7+xtPxoRg2aU/8D7a
HgBZKkk/p9T5HMaQ6tZkOR18S2iJ3ZdInffzrKTgwu2bBRjh/3GbbLMNPo6i62Wm
1EwVjFuJWPdLhUCI9ahSGLizIXIpUsKJ5AC/uedhYBw/Ha3vEngSNMa1kGL+11KC
WSKn2kEa
=LrAf
-----END PGP SIGNATURE-----

--=_MailMate_AF023E0F-3702-455A-AF02-3736E6578BB1_=--
