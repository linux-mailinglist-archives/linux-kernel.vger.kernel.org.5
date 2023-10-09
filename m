Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28887BDEF4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376604AbjJINYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376490AbjJINYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:24:52 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E08894
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afRvZ+9ZP7y5lU5HlbmlCL2l1kN+n1iGcIomxr+vKJL+QrS6h4T7yCOGj9pDUTqiyqpD/arKsHQxeBeU7XJsGiLQ1ks7ZARm7avoZ4MwAYYT8JeZX3hTSiOcVP43P1VFrogmJFN++nqpnhdFz316bnX0P1kTkuRCiYHJzezjfBwS04sY9RmPgv8e+n8O9lDm/6W1DgFz1V4urzAnnS5aRT1vlF/YND/BVgBi9Mtra2CvgLvQMDPMk/dtrzFxf99MR0CbwDjO3XKCMcKIzYfBScb9KlpWJzqjC1BqjyDXc23bvDJDTbpkPpT396VDBmvhyzuYy90MOhgX+q/3Ec5KsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY/1yVhz6efmAIwoHbuYerBOKnMFD5nzOH0AhKpHGQg=;
 b=UnZtHpUJJTI0aQijpZ/hBxhFMNHpzg4/Wd446QMmHKo5tTTjNW91Cwzqtz0g4pgXapoA3BZdEpF8Uef4qez8VDYRxAYCEAu8ChYkZb9ytjgLZQc2jwri+KNuedlwmI1aOU/rCxfBojgJXoFCgPSbAH8pDl49UwqjEJ+J7Y8nxEph7UXO/vtTXNIEmGAEqTdZVKhTrctzpfSID+hy7YSnWfs+wG5A90z3VsoNtF+O7DjkjplZxrTtpJcEFZGgLp2jWplXo+OM/Y1h9JssH4j6MxbGqaF3CFufbgZlPO7TfzCLBbbXgV3Ktctb7H49YheNP4DYZGfBiVSY++okQmr6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY/1yVhz6efmAIwoHbuYerBOKnMFD5nzOH0AhKpHGQg=;
 b=WwymO2X1+QtrqlHyADiFu4gB39V2sGWCkfm0KN9oFH51NdRwYA2voADfgllDEt7LO8sIU3nZU/YPtCTXg942apHKLAvEa/QfHI4Ivqn7Kp+du1dCw9MZoTzoDx3db66yLy34mO6Bm465XPsowsQ8Kf0SDyV/PdKmfiZOR7xywxW1/sgw1rqbsIt1GgxSCfDga5KF1ffFLlFcx2CzzkajDknSekjGvoj4ebWW6mB3FwvFiSHlHcdZ/EdJmlBMG5D0tz2FnMIHetld0EnSC+tKglekgYf0xROmjMxqf1dgi/wVuYksdXu8phDfAEckWRUuwiIuhkAPVvQAxoMKoXFWwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 13:24:47 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 13:24:47 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 0/4] Enable >0 order folio memory compaction
Date:   Mon, 09 Oct 2023 09:24:44 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <3430F048-0B75-4D2F-A097-753E8B1866B2@nvidia.com>
In-Reply-To: <5caf5aee-9142-46f6-9a04-5b6e36880b21@arm.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <5caf5aee-9142-46f6-9a04-5b6e36880b21@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_99860CF5-63F5-49A8-9B4E-3ECD591A589D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR0102CA0059.prod.exchangelabs.com
 (2603:10b6:208:25::36) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 500e6ddc-56ba-448f-0793-08dbc8cb1bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AICBcGjZBvKm2RcCDAsNqTnz1VdcJDdHo0mhRsg2OFz0G68dtQE97ZRfrMXNmFpXOIAS56Ori1xzSBUWQKSzJYHmnTR96fbG4mDFMlFlnSd70VKRnm1IJtOmVQKh+z8oaCmOroye9SUL1w2OgC3NOmQzR/GypWTQz2WGKb22exq8R3kX6G9FFh+ZcAz1+LIR3to9fhoUYrb5hplNXqGuMbVKcaTbt+JDnAvl/jLlxKaW54KTMruh8R3/9ZwP2nn/Wob7mWisvrzhHBF8CO6rueT2nQpq/82iOeAIcWAiab0sGr/Mi6etqITEJEOjK1BoG53zxk/ZYmXH32yXH0ua1y6AAVabpf5ddWrDoiNy9txgJhFALSeiXTQQWodu+rI2Z5bVzMvTGyi3IUqWCEilWzfnkoYa34n7IAGZsuOWYoQTDOZZcqEu92pVpdL6/XZPo7+MstXl6sJMOF6TUSHh3ya9LAHTuk5aVugpXwtQE0OAaXhdBronBKanwl6tGRLRnJTT8LFcRS+MxRxzUKDG+hsbI6bm++r7uLriNyaoniKpRF/hoJDGcTiiDIHGeHbz9Y8bPWlo5w+FRKqxEEb1P29D5tdz3Ylg0WGlkg0LhD8eaElic0TZSMVehyeuNiY7xx/7CjX5S0i24oa7rsFwy28f0OaY8QyzJ2bCCY5IBDQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(33656002)(53546011)(6512007)(2616005)(26005)(86362001)(107886003)(6666004)(36756003)(478600001)(6506007)(83380400001)(38100700002)(2906002)(6486002)(66476007)(66556008)(316002)(6916009)(54906003)(66946007)(4326008)(8676002)(8936002)(41300700001)(5660300002)(7416002)(235185007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dy6MhHwx5Lt5uxGkMn6qJLHJHMHuJgSfIjPsijG5Ecytf4/oXd7JOfxZn/GC?=
 =?us-ascii?Q?n8X9hoq9ags/5hBGBEtB9OQ4V62fZdqvT2tcIqtCSYg7ehBC+4RhbqviyChl?=
 =?us-ascii?Q?HtxBxuPfEciEdne4JxMyVSoROgCietQGqyv/DWSSTGVFw2VpVVQRRV2EQ1f/?=
 =?us-ascii?Q?psGw1nFGprmfC4IbOmEGDCI8FFRJo6u/U43ix5JavFma06j2QZlI2ap3agTd?=
 =?us-ascii?Q?Vh/dXr95okTNCI7WYloznn14JLJXq8n2JQ0SosaQzKxyUOIYYXw8BeplSEYY?=
 =?us-ascii?Q?yYxQMSGEDRcwJArRnIgSrRM5PVJlvEqPiazOAY19EeSCjUXTPe8VlhhD8xlX?=
 =?us-ascii?Q?fZG9r7ZhTl357cg5ys3D/KX0he70sFnF0iZmB8wh/Qv0harT9PmiJ4ENfq60?=
 =?us-ascii?Q?W5UraHlBN77l3SElmBIvizpIFBXiuBzAGPmppJSLQCFfaBwIv3z4CmE1jjwh?=
 =?us-ascii?Q?iNSE40TXUf9U7ViVR/3BG9WmwAGxyvo1oC6g4t2u42sDGLMV87e+nrkA11KL?=
 =?us-ascii?Q?TYLM+sIh5QJ5uh8nwDI2xu44FJSdZYVkXb+1sYQgEPHFgyaT2NNPd031rqX1?=
 =?us-ascii?Q?qQIkV1MxMvzBe71IsnrSBUZAloNROaIy9wTvnjKD4kbR2dYFAb+ZWW6FaNYw?=
 =?us-ascii?Q?KndZYYCHj2h4fxth4yS3pPMkjQ8wf91Fc6r9x50810cuouK6wcp6wLFY34Zw?=
 =?us-ascii?Q?HVc5+rc0YQWATMMogAKU7Zk3r2Sm+ipOrEMQzNc/4aNCTc/YjlnlejSS/UPj?=
 =?us-ascii?Q?VLUY9ZAahqD8N3EyxEMFPXa/wGa86AvtTlFjfY2lLQQQY6BXEH+RfjuP3QcV?=
 =?us-ascii?Q?9ioH0gK8UNSLN+MgZvyd3KNiRbG4Qx5phP65Aj29iU86jCiItcZpLULXYED6?=
 =?us-ascii?Q?DEU5LegbgQ+T5kles71+Be0KhpaXHJEu7rnk0XKYlkLWiKlq6zKRw50Tcave?=
 =?us-ascii?Q?YC7h63HRa5NGyQjQldDiajAGg8CGA6PV3lkFDlU0cUX+C6r8lqwwkzK75Lz9?=
 =?us-ascii?Q?VPSO8q9C8j6dm62By2IkdMVJ6RRCE96HjiboGVBRBKid5A94pflfRkXD4ZKQ?=
 =?us-ascii?Q?op3vsD3q6HPm/gO/ck4EPYtjR+lEI9xXw/zKeIRkY7/rK09N6l3FgRGeFQNv?=
 =?us-ascii?Q?5DkmcCrVOs/tFweDJvyyaCI68YLzGAfFUBlUwFoVaHenNVum/PdRZOnhz/k/?=
 =?us-ascii?Q?GUkuXItacHUax4JdoI183hPuLND7GS8RBpXCHJNsfithMg5eHBxuZPgg9WwR?=
 =?us-ascii?Q?8NghrXtSmva6zEvg31M9GwfvFYfZsOyDcvAem1Eo+sMagAMRQeAQsg2XAWDk?=
 =?us-ascii?Q?CHtewcZt7W9wneqGgR3eRBmZqNOTdbZnoynd5DX0RRmLAkqK4g7m54FEDNJK?=
 =?us-ascii?Q?L3Cl8m6GrprCT20h88eXNWijeivNGF9Lp/WDVkaVME7n+9SkJvs4SWqY7YAy?=
 =?us-ascii?Q?SgaOQPvWMCyNnZicUmbzgl3Qku6aZNWj+qWTksD82i14R4bVIvVU7HbmWVbx?=
 =?us-ascii?Q?xvvQVsMx56ye0URmYOMPqMYusKi6BiVzUnwUaHrNg9mr7IG0woyqFvV77WrE?=
 =?us-ascii?Q?rdKZ+iSddALgNzD+tGU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500e6ddc-56ba-448f-0793-08dbc8cb1bb5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 13:24:47.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYsn38MDuYvlNzQrqN8voXTrmNqojQqlkKz2sMaGmJWSn6plgGejSzMHlAOH1QPt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_99860CF5-63F5-49A8-9B4E-3ECD591A589D_=
Content-Type: text/plain

On 2 Oct 2023, at 8:32, Ryan Roberts wrote:

> Hi Zi,
>
> On 12/09/2023 17:28, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> This patchset enables >0 order folio memory compaction, which is one of
>> the prerequisitions for large folio support[1]. It is on top of
>> mm-everything-2023-09-11-22-56.
>
> I've taken a quick look at these and realize I'm not well equipped to provide
> much in the way of meaningful review comments; All I can say is thanks for
> putting this together, and yes, I think it will become even more important for
> my work on anonymous large folios.
>
>
>>
>> Overview
>> ===
>>
>> To support >0 order folio compaction, the patchset changes how free pages used
>> for migration are kept during compaction. Free pages used to be split into
>> order-0 pages that are post allocation processed (i.e., PageBuddy flag cleared,
>> page order stored in page->private is zeroed, and page reference is set to 1).
>> Now all free pages are kept in a MAX_ORDER+1 array of page lists based
>> on their order without post allocation process. When migrate_pages() asks for
>> a new page, one of the free pages, based on the requested page order, is
>> then processed and given out.
>>
>>
>> Optimizations
>> ===
>>
>> 1. Free page split is added to increase migration success rate in case
>> a source page does not have a matched free page in the free page lists.
>> Free page merge is possible but not implemented, since existing
>> PFN-based buddy page merge algorithm requires the identification of
>> buddy pages, but free pages kept for memory compaction cannot have
>> PageBuddy set to avoid confusing other PFN scanners.
>>
>> 2. Sort source pages in ascending order before migration is added to
>> reduce free page split. Otherwise, high order free pages might be
>> prematurely split, causing undesired high order folio migration failures.
>
> Not knowing much about how compaction actually works, naively I would imagine
> that if you are just trying to free up a known amount of contiguous physical
> space, then working through the pages in PFN order is more likely to yield the
> result quicker? Unless all of the pages in the set must be successfully migrated
> in order to free up the required amount of space...

During compaction, pages are not freed, since that is the job of page reclaim.
The goal of compaction is to get a high order free page without freeing existing
pages to avoid potential high cost IO operations. If compaction does not work,
page reclaim would free pages to get us there (and potentially another follow-up
compaction). So either pages are migrated or stay where they are during compaction.

BTW compaction works by scanning in use pages from lower PFN to higher PFN,
and free pages from higher PFN to lower PFN until two scanners meet in the middle.

--
Best Regards,
Yan, Zi

--=_MailMate_99860CF5-63F5-49A8-9B4E-3ECD591A589D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUj/xwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUwoMQAIOCck6FKz9tzwsohLkx/2wuS0AL6vn4T7xH
VdxR/K32S2avBQn07rtiEFgFi6ztwSg4CaNqXcRdZaf/PiGS8ffS1mrJB5sO00Vu
E0k5xCcahBUlkFrfnAi0sfq1LWVuUESxZOJotq+ZRhBghKryOqjbFm7dAwelcfi2
MsjTYdpENZLhTC5axy0Dofir5/gpa+dJ7gy5ug3r3Uy1KU5Pt2kPNPn+9pkHeaT6
gx8NlKXCTglEBsdv6BA4Ua1vOkY5IayO563xGdf62t0VplR76gNCqe1d8kr2pZri
/tRqMqjOTcuLwA28nDbrvV0Jue1qTfKdNsI3cOrve1gNy6I5reU6+AWTPzHrUGjl
zu1Wn8KFxbnatX6n0VlvOPgKFkfMPxi/HupuMBFBMzukoXvysdL+wBIMPpp9chWs
EPcCYWs9bW+q6RKOeLASmyDOvTwMB+puDk7CYKObqdz2rZ3eElV/FvnhDz2PrKdy
60S+cTH4wU8ADgN8GRrc/5xWkjZVN9i3jtdEpNoDCA8Sa3l4X0LGvVVjPaP+vDy1
PxhmWyRAOEL0OY/HGx4wUAPDGcFoP3yy2UAxfKEbm37XF1drc6BbioaHGeepFC+x
jI0czWYxnR6lhBZQBBYoz55ObuoJwJXj1H0QTLKKMiEu2jtgVQxzc29RPYKAnaZ7
e2vcaQat
=3o4U
-----END PGP SIGNATURE-----

--=_MailMate_99860CF5-63F5-49A8-9B4E-3ECD591A589D_=--
