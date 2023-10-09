Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E257BEE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378899AbjJIWYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378857AbjJIWYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:24:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D89F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gub1T+gE0/Aoij8+NJxkppiIk3JknX8sf8vqt0xflqc5rTOwW2llTRE+2Q40Hjqqnv1DCOZBPIuYqTnGIRwoICVt75jkpb4LEydZbx+jf80ooA3e2wnC9IPYXkHf+2xbAcHsDTM7p6caa8Ur9/OqJj8gW69cVL0GhKBzjrZt6YrXe68lTafGJKGebttKndknVkObhXsLZsOtj971A9eh9YySOjeWGhS7/ApHRrCtWYQ4SXRnaH/HHOeRs7yYp2Zv+QP7VT7XhnJnddlNSVz8IcOhVTzLFcLA/ZqZJ6GXEZWM3cw9dqhgFF1E3Bm3wMzGbAruVVQ+B3RryIotSHpEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uFbBO9aqB7cHIUu+UHHDSMpAqbgczCXBAqRAfATJ94=;
 b=AEBc97UdbbmHTRN4Zl3V2RhzQCWRTSiqiud0iwZK7EdgD9kRx5KOEQglWLISmEkYY7ok5SQtzR/GVeOa6bl5SxKeK/YSKjaml6uACjeHN+E2WcZCadzPO8pIiNqb15cSVZ0UEGJ3gADf009Y9Khg9KZO67LaHgd0B2ASUBR5cPGEREij+mNGNbdeMA0XHNQEvRJPu0CQkiKWd//0vJ4sAL8Ox9LWfBtZ79TJ/X6UBp8GGurh7w6QbOYv+BTGT30vFU1aYx43MUxJSXyTLpYFQrKQK+ukTjeuU0pqf+GlcxTIMzNMVbUJUtmFSUPbrXkx3Htl2fYS/SnogCC/miHxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uFbBO9aqB7cHIUu+UHHDSMpAqbgczCXBAqRAfATJ94=;
 b=VG6XShKtr+abtlI0evBp6LHVQJTnItPCGtRgolleoz9wzzsXxlMBudpLHkeadyruEvQhx7Uljk5ShtMkuAo8z21rojfR8NctfYpKZOrs7HloRUVk8RqOUtHZBFJPWCzQJeul72qZuAO8UaqhXK581Ab9Wk6Hjaq24Dagr9astyAWzfMvch2qkjjS/oWcJoPbVcR5DRxRpl1y9pu1LX+J3ax4JvdI1Jh/7NVaOP+tnLyY0J4FJZx7EywKWPEbFhKoqqpUEElPA5JbL0Dk4ghZ0iThVI8UKA6Kzix+Ykd63A8UsCTc37m4NpSXu50ILzUk34BRNaPTu/QrUASeY34ZyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 22:24:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 22:24:05 +0000
Date:   Mon, 9 Oct 2023 19:24:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] mm/gup: adapt get_user_page_vma_remote() to never
 return NULL
Message-ID: <20231009222403.GE3952@nvidia.com>
References: <cover.1696174961.git.lstoakes@gmail.com>
 <b57d5f6618818f2f781a664039ace025c932074c.1696174961.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b57d5f6618818f2f781a664039ace025c932074c.1696174961.git.lstoakes@gmail.com>
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 745729cf-60cf-4c60-1c3d-08dbc916726f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MA+YKneqMjhfr0C4rMMqRZK4QW3z8hcfOx6UVng7tzkhKooyIPRkDMVd4GWPUrf+CdwZUj+iNc1RvotiybUlBLeTK+vE5TcNo0oF/xq5daGOu0ILE0R7t4KybhfshpUcFtlw2ysFo+ZzESI2MmkLegDzhsZ+MJ4frLaAUmSWXbKujSfNYEJ9tcyks9DEdjdP4hpKonaJbI9/IFC6cYBh5YQyHpmccYVmRiEj4U++dzc5LL+ZwGbHw8FHIrtPgYJf4ZwzpiMfah7JAy/5M9prm/ifgBt1ESPCa7dTiArfxs9XleMkoCBEhLnT2NZFzq0rsyCDvk8jFw7c9RWdgk7WpwB2t3pcPsl12c8AZ/awUIsNTW1hjCoBty9ahQPt989clPQTBItvPoLP1XyGDxICPMSM6u1GEEBjyKqRERwyYNciU9NR2O8ws4FvuazTWtl1lLnoYYfF/05Hy4CFqLkQ6E1DtIpIdmtv4qwuaw13IpYQ6nReYPjISJpn1GVvNIUFtyU9BK8e5iEEFutfDBdP0ok2NzoHkOOc0H4AP3rfgQV+AJH87uLN9NLdqG/PPTUy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38100700002)(33656002)(36756003)(66899024)(2906002)(6486002)(6512007)(478600001)(4744005)(41300700001)(8676002)(4326008)(5660300002)(6506007)(8936002)(2616005)(83380400001)(1076003)(316002)(66476007)(66556008)(6916009)(66946007)(7416002)(54906003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3O+EBExzbkX8oYBbk3rVBUU7qzqhCyeI63Q8b9czge8KMJt8FnrD2RVFADBv?=
 =?us-ascii?Q?F+z3ncW2fVX8a0P7VIB1vzaQrarh/PJ9B3BLBJcCn86DL4El+MHIythm5Y77?=
 =?us-ascii?Q?OBx3+XFrFIUGrmoaZ91feX4cvmPXjacrC4lbVvkgSP64dNIBTvjr/RgPg9+8?=
 =?us-ascii?Q?9YDUrYXBXqCVRTh4PnKvGlxifjqi3RvsBjAcbG5QjCZ/8TShtc/+OkQcvZLA?=
 =?us-ascii?Q?QEYLC3eLPPjYMLe0xDqDHo2d5Ad9rrrHvpoBDQtduhr9QgcoUTEqKBsXFI+r?=
 =?us-ascii?Q?Ca5J0rNDPZTEbdLW6whjcxSI4JVX9EpLazH+1/5pz9sUnKgZkoJJcebzKa9v?=
 =?us-ascii?Q?9HWkjEpZjGVpZXrP4iWVWBS4fSmgOPUjnGLNEsKP9tc0b5Ld+g20a8m2a/FQ?=
 =?us-ascii?Q?zjMh6p9eBNXW4rpRvj5CK/udG2yoR6yAZUVxBLKdgL/Ke4uJg1KqVA5VgQmb?=
 =?us-ascii?Q?WrljzMWDRnIxoZhL1JTtTfvluXjo+rCzaHjy/aCkO3Q/J/SfWmjlx7WyrG+H?=
 =?us-ascii?Q?WN4QFNms/2FgoJDm4lyMq1ezk2ivo95jMkm49GzAzBA4CbQWBbI7xC31IJ7Z?=
 =?us-ascii?Q?enRzkk9WTUDGOT6HzH79l4E3YYirXN0YPloQgDds0/rQqPRsYGq8BENPmm8s?=
 =?us-ascii?Q?nw7Dgwxw7BVvgCrMSuQqDGphTmFGQkdtw3t5AlI3d+0PCertKm6Dwl3wUPD5?=
 =?us-ascii?Q?VFi1xdoBWMAdpp9W3ZwfpCo+5J6+t9zhaW8XgEIHAq3nvxlfNpLH/KkFtkI1?=
 =?us-ascii?Q?WTpZa/5cUdfh60EDFJ27KVPcBMO+RYSwbcnSLRz9RjCLa8pMWI02T/HUS29/?=
 =?us-ascii?Q?FISg2jhpuzbrJY7oEGhafRbc7xETtrQh9swutcAGSGYTkiMspwySsr/Vxwyd?=
 =?us-ascii?Q?N2slAG/VkpbnJ1vuQFd52FQIzIaq/qnkF19WKkj4QwDyNAvzAn4IFwImSB+a?=
 =?us-ascii?Q?Yw+NWUvQgOPrQ4JWlF/A/y5IziYyH6RTzkLkkfWlAuilvCojJ1i0oAJm1VLg?=
 =?us-ascii?Q?B+RbbseGjNXmA7+V5bkjCv3HNaHJOMeInCZg9k8mVPxcaas4jcA3EpnujtGz?=
 =?us-ascii?Q?q2shqQn82WJbeiKqZpHJbtINYLzzu3jVgptqTpPniF7TdwIe805aQvDdSpPo?=
 =?us-ascii?Q?fTTYk6dJIGsdW48OQohr0DD67iROQOvncmyhfz1mWYhlVW1lWLNBRtTmo7/N?=
 =?us-ascii?Q?9+1tkZcvkTyVWaOeoiG5O/rpuvG+QjDlZzf1lZEJ+hFTJnb8rptfqOlI7vY+?=
 =?us-ascii?Q?MS0Eb4PvDjiYrD94CsRcEj0VMOVgO95kOsCjsN/zVLi1iEmccZ24lyqrdjYV?=
 =?us-ascii?Q?ySjl8u/UMPBiYDUSiKAFff5rj579sYQWsnsbLMbMRXDUdtYiKapB8GX4SAIJ?=
 =?us-ascii?Q?5402b4Nd2s3eMlKU/dYNWwIVWcSsfewKyOfoJedt1/IU2yqQRlcyqbiAaunz?=
 =?us-ascii?Q?5XHW8ur5bGwAdSphN34A8229wADIt2KgY9lF97Ht/TKbE8ZPAM0cn/lVNa0s?=
 =?us-ascii?Q?GIN3jNOX5SJMkdWSJTJXgBOYRVjIiIQRaRSppoMKiGd5+Nam5qc24P0isGxg?=
 =?us-ascii?Q?5+dxMX90Kpp56zLI19c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745729cf-60cf-4c60-1c3d-08dbc916726f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:24:05.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7yA3kYbvH22HV/g8iULwxl8yIhi67Xm2j05mgp2WG/JNU2LVjAlHy2Y90VKhALj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 05:00:05PM +0100, Lorenzo Stoakes wrote:
> get_user_pages_remote() will never return 0 except in the case of
> FOLL_NOWAIT being specified, which we explicitly disallow.
> 
> This simplifies error handling for the caller and avoids the awkwardness of
> dealing with both errors and failing to pin. Failing to pin here is an
> error.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  arch/arm64/kernel/mte.c |  4 ++--
>  include/linux/mm.h      | 16 +++++++++++++---
>  kernel/events/uprobes.c |  4 ++--
>  mm/memory.c             |  3 +--
>  4 files changed, 18 insertions(+), 9 deletions(-)

Good riddance to IS_ERR_OR_NULL

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
