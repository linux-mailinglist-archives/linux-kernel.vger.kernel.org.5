Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2447C56C3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjJKO1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjJKO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:27:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4D090;
        Wed, 11 Oct 2023 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697034430; x=1728570430;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YmqL9AhZ7R/36m8kgp7UwMmG8dYOn8UHNlLQ9MosfxA=;
  b=DMBEdsbrQhrbe68R8T1fkHAIRiXwqVWocwVN/aC+ozyGtme+C6IDpwrA
   6KRWjIIIaj5g9aeduGYajcse85nhGx7RNJM8UDJ0m1IGOKVV95i3B08mc
   zpZg+nUuUmqWzoACE2+3vzybb+aKbjotgAd1yO8GRzc16PHjeiMQFLOh1
   hYsINNcHk94nugJhK+C/AG04hOeqfNyBSt3Q4wkdN0Y8leyoYB5aCazxd
   7lfkQWP2fIsY2C//AcI8tcfnRs3p5J34t+P1w15RclQ1CTgRrpDm0Ix16
   VFAaQN8KniWfnm6fM56mNKn9Ohq8nJ87OmgNKtmD+dX0HkxzUyH41MMIR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="6235367"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="6235367"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 07:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="1001124812"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="1001124812"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 07:15:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 07:15:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 07:15:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 07:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTKzdM/tUtotxSgLTbbj9PFz6GIzAUlD+YF92DVmCiIGTV0YaC/WsLoI8CNtH7+3ryZWj8M5CHibGy1QS0YAesJfat+RaLuA3gnRTLmmB9dutUVxTzK+UsSwIIGBdi7mRCo2dzBSeHUPCa2pXdjOwntG8p7P24H5Juc+PpnEspotIOdA/FmHv2p0LfH3bVBfaTUdoR1Gu9qJ608ihU+4txabF1Gf2H2gf/789gxckh48TKeaJRyUx1RGV0n8kx3bAeZChj6crjeU7wP845xjY22x31qu9eU3BNAS8efXW60kZkJF7sdNq/MPWR60X8QPARFscoha9DqkWm3oc0pJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V2i3rmUyiLADDKT7qfkLJDHUlOXGWBnlyNiRTOdq50=;
 b=BgYOL2qq3r3IPBBBrWowwl5KmBiOZu31aR+cGycO/INDJnyQ1BW1PGK6LYutwDeBk8djCPG0cylyGgjlypZqon9ND6JusD1W9mVlLH3YHpVJODTKyyCREOYa5/O/2C269wbDpn7BqsAkEEv5KSJWANoaahQBORYy12AUBtGzd4pH3A6jD0av79YKE7bGuX6NVc63A4DihVCXtU+D/+A58z495W9FMbAH3REOZOn/YunQ79SNQhZXRHuktT4bRE7kyYr3835y6d1wu8Eiqsuye7rn1HgFyxsmZ4fya8GpJ9/aIsIMwsfEMTEASSytsCsAwCVbwBZozBILPlqHd2Vj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 14:15:04 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 14:15:03 +0000
Message-ID: <348c239f-243e-405a-a0ee-92433626b682@intel.com>
Date:   Wed, 11 Oct 2023 16:14:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Fix memory leak and move to modern scope based
 rollback
Content-Language: en-US
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     <rafael.j.wysocki@intel.com>, <andriy.shevchenko@intel.com>,
        <lenb@kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>
References: <20230926184520.2239723-1-michal.wilczynski@intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <20230926184520.2239723-1-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SJ1PR11MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cad77b9-ec00-4333-5b40-08dbca6475fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9I0XoRzHeerVVsMNeDJXVxMEcyXvAtoy/e4SG9RRiy0/vIECG5yj9a9hyyai1uc+1bajysAEEuYuNM/Dm/ocWKJdGpkE3H3mibS7KbOFEtoJgQbadQcFWQfuWECK5vIlt7PBsBkgcY2O3sxEw7sHPf1GEix61aW4zNeGRA87POx6+bb3H+u7trL0YTrCFktZn8mJhId0PNHCFYTTwsZ5zrAlotTMesBwKK09EqRgTLUWzIEsESLidr2mkW0VEkO7C/RX4DL/Pok1OrOAmICnicjD0dxHaKNUOMT2RrIz+et8jKg/mF/0rMj/g/JBjDNv4m89YOgVLdHYEzKdsmzBmeRKY5JXMJPhF3wmdhbopFZy9oFabfLGzJ/obZsbK4Blt79a6/TQzN0/EpNg7GsaTjZD8bHTYSaWYEjS8qqbAQt0HH4N/O/zSORhTFWIVPFu8rHug6SwqTJPg6pUJD4pIueik/3vX1hdfT5lHfnAsU8aHg7LHOgmszg/EtGh72qVQqdNRHD94EZ7D7Ke+nzOR5HwpFUtcKIgs3TzDBbledy0IFEZ5UybwcBqBZmc0OA50yy56RaALn0jTPCPFT9VVjgDl13V8sD9ru1XWpyxSPrTfyvP4LTkVnvqtNw9SNx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(66946007)(66556008)(6636002)(37006003)(966005)(6486002)(41300700001)(4326008)(5660300002)(6862004)(8936002)(66476007)(8676002)(31686004)(4744005)(83380400001)(82960400001)(2906002)(6512007)(31696002)(53546011)(107886003)(2616005)(86362001)(26005)(38100700002)(6666004)(478600001)(36756003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29qRERaQjhmaEFQWlBMVWlsczFFazFQZWwvNUp5QjBlSzliZG9JK2ZERG9I?=
 =?utf-8?B?dHRJQllDQlMrblZqb3k0a3RBUGlWWm5UQ2owRzA4YXBkNEdQS0hPMlpOMFgz?=
 =?utf-8?B?SURBd3p6c2FlZTJtcUVCRDhoL1ZoT1B1ZnVadmVSZGhnQnQvU1kvQUp1MnE1?=
 =?utf-8?B?T3luOEFobTlzT3ZMNmdWbHdXL1ZQa25rZWp1N1lvUG5ya2FlQVJJZGN3bGdW?=
 =?utf-8?B?WHorZS9KWkVzNUc4M29OSXhtQUVoZXNQZ3JLQ2RqVDhYbFJuQmZWU1FyM1Yy?=
 =?utf-8?B?U2JpcUpaelNWT1hkNisyNzJYU1RUQTF2Nk9TOUNtWEJLQXpZZ2xxdk1JUk9N?=
 =?utf-8?B?L2I1cnhxaFhvaTNNTXlhRitXWlBnZDAvK1V5NHpTU2xma0VtUWhCSWNUelBt?=
 =?utf-8?B?L01WYjJyME5jU2lKUTQwVWxYcGpSNzNJMzJNbDRCeDdERWZiUHYxcFd3NWFs?=
 =?utf-8?B?M1BTTHByb1NJUjBJOVRVRSs0eG9jeUc5QUdDSVNyVkorcWdkeG9leWpySkxi?=
 =?utf-8?B?bzB3WjdlYXF0dDN1SDVORHlRVktOdmdoa0x1ak1pb3FhMEc1R0lZelp0bWxx?=
 =?utf-8?B?MmdkVXE3c1lsTGFRM2pKMzJqV3JtOWN1TUFmZy9BbENlWG1VRjIyM2U1ZWVU?=
 =?utf-8?B?N0Y1RHlxQ0xXNEd5K1lvQXc4WnMzakZKOUNZMnlLN3I0ZTV6S3A5dEZQNytI?=
 =?utf-8?B?NWxCdm83TjNIb0J4WnRtVnZVNnBjMjRMSnRDb0RtVVJBZXZtNUo3UFFUaFRD?=
 =?utf-8?B?ajB6eUpRRk02VUt4ZG5Xbi96K0Ywb0IwaURaQi9TbXhqWGZrcTR3WkZNSGhH?=
 =?utf-8?B?YUs3c2FVKzFrQnpheUZMeXBoOGIreGxvWjRKRjJlUWgvNWxwUU1XTmc5dGJO?=
 =?utf-8?B?djNrWW5GVU1LazNySXpnOTQ2UGxtdlNtRi8wYkxyQk9aaDM2cUlxaDRrcDBm?=
 =?utf-8?B?R3BqdVcvOVFpRG93UEcvRE1JWjFST0hISU44OXduK1BweTB5VmVzajQ4Zmxx?=
 =?utf-8?B?NUZnRXBLcGorSmxhODBEOXZjWDhnZVc4ZlV4OC9kcVU3Z0pPRlIzMTJTeWJn?=
 =?utf-8?B?M0pyeXdLT1VGaXVqY0UvU294S3ZjVmxxVm5ZSjFSRG9mUm85cDJML3FMckpz?=
 =?utf-8?B?Mlg4WmF5bjFucFNLZW50RG9UTEZQMkpBZ2xrbElXZEg1TVZMaHkvZS9PcFJJ?=
 =?utf-8?B?NmkrN3hGVDkxaDZLaG1HNHdJOHVVc21OS281Y29tZmhaVEplMW5sdmtiYWhE?=
 =?utf-8?B?SHBDa1VkdU5vMUMramtpL0xhTktKbW1oR0Y4RFJuTHNWWncxbXBKOHBoek5P?=
 =?utf-8?B?cHV2cHlTY2VpZVhzb1E1aXN1b3dWelFyb25MTm9jOGpkR0hkZ0U3YkM2cWZD?=
 =?utf-8?B?bnJpZFdFT1AwblhmN0h0L0hmeUlxNjFJd21UbUUwQ0JGeXhvdHVwRTJnNCsz?=
 =?utf-8?B?a0VLVG5qRFZBZWFQQjZKVDE5Q3Q4WXBXL05UVFBFaCthWmNLZGlqTGxRWkh0?=
 =?utf-8?B?RlVhQVV4MnhwUUd4RExtaFZvNlZIRlh6MVQxaUl6SWdBL1RSMHRRbmxXYjRl?=
 =?utf-8?B?azNZOWhqVlcxV3ZYUTQ2dHV6V2xUMGw5cFdxYm9ITVZGaUQ1Z1RkeW1sTlpk?=
 =?utf-8?B?K3hnM2dYNjNabFV1ektqRC9WdVByVkNJaDVuY2pHMHlKQzBGSTg3cW8raFlL?=
 =?utf-8?B?bVpLV1VuMHo0MWI4VFNQYUg4WnJNZ3VNSk5LZkREb282ems5SEYwMmtMcmND?=
 =?utf-8?B?SU9iZ2JUenBzZ1pEbmFaYzZLclhGN0NLWldZNlNhTkJtV3ZuV0hBd1VBVVRT?=
 =?utf-8?B?V3N4dE4vb0h5V3BteFl6SjQ3NGN2Q2JTUTNPUUtIZGlKZ3lGY3o2aXBmSExk?=
 =?utf-8?B?M25xQ2ltYWpocG5UaG1QUVNBYk1QVnpHZ3g4NkR0bzduT2xwbXZkR3A3SjBk?=
 =?utf-8?B?WS9WaDF6UU1MZDZnWkZrcUlmNWdHQlZ4clE3eCtqVGltZ3pyVENPYUY0NE44?=
 =?utf-8?B?ekVoTmFJbUhuZ2hyZmtYRUYxODUrZ0s1ZFo3U0JWaTJNWkthQ2lTeVFBQWJM?=
 =?utf-8?B?ZnZIMjlKRUZ6eWJNWFlwVFlZc2M3cGFaMXBhOVA1UlcyQkwwQVQwTVBkLzZG?=
 =?utf-8?B?SVhFbzE1TUdUSWNWcTl0UE5Pb2tyZy9kUFBURU5nK1dFRU01UTR4ODhyRW1u?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cad77b9-ec00-4333-5b40-08dbca6475fe
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 14:15:03.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKhavNLp/f3l9OsvfsG7oJItTKcrMkbrsBv3jMl6Hrk8KuSjxKzdRp2GNkerHYsfpg0w6CpwMw52BsUhvIyr9VWrvZebgNi0lFdsDBYK4ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6180
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2023 8:45 PM, Michal Wilczynski wrote:
> In acpi_nfit_init_interleave_set() there is a memory leak + improper use
> of devm_*() family of functions for local memory allocations. This patch
> series provides two commits - one is meant as a bug fix, and could
> potentially be backported, and the other one improves old style rollback
> with scope based, similar to C++ RAII [1].
>
> Link: https://lwn.net/Articles/934679/ [1]
>
> Michal Wilczynski (2):
>   ACPI: NFIT: Fix memory leak, and local use of devm_*()
>   ACPI: NFIT: Use modern scope based rollback
>
>  drivers/acpi/nfit/core.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)

Hi Dan,
Do you think this patchset is fine ? Would you like me to
change anything ?

Regards,
Michał

>

