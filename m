Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8BF7A248C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbjIORVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbjIORVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:21:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C452D48;
        Fri, 15 Sep 2023 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694798459; x=1726334459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qsVR3VACqP8v63A7Ab361OlKDzn/9mxxad3XUsHCdvs=;
  b=fCxvGe0kmlK3qcocmlgvY5Pdf1nnxQaP4GIFjU2npPN8j6JmkpwAlhDI
   TM2AY4Rv0UBLUUrZdsAXT+kSfKjqA33lv+sUHY8XemEz7yk47ORMsAFwt
   kZbKc8xGqLqzIahWilk904JQ+jAuq10AQkwfw9bgKJm40prHZcskOh3Au
   tzk1Qw2bcY0nblbb2YO4JDBQYKO+ZyVG35DMTw0vEBJ0/UoQiSFL6u0p+
   p5b9ZvcbeWHA/KhRQQK30rCTH28Pi0BwK00JONHEOzWIjtrZdsm6LR5/e
   of75dcHNBREEai1wGrg9Q4f2RPuAMc1z82Q49dTUstcnPznEuQmbuLY6y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369622199"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="369622199"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 10:20:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="774387902"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="774387902"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 10:20:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 10:20:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 10:20:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 10:20:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1s95AMyTmGmc0eSWFREY5iHZ+WdgRPufPLy0xpvsWdbiNbt0xaTrdYYNY1nqGQ1wdhgLKWIhPDTOUu1SGD9yUpBdlbP4akgbeHM8UCf+fkHszodSkoIhfQfLJ1dhuEKc5huX1r43KIHlIOqpQ2wNfYPkAYYAMBk2yLLGhcedgqMgoIAXj1WTvx1iLbiSC9reaJd4I1qdpb8odN61UhFjiZUPzpqc6ID5nz5St1nE8iZ3JqD03g6N9YHlgjADG6KJ+Op/ew6VC5LY+SeGZU0oqSI/k+/KHIgtY3CfD4JMlGZQQNcqjVBhylN/H2YwXCmDRNiJ/wbwLShmfY9rUouLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sNDR8Xqfn3BfCB0GSz/zLSN8JeKN7c4lqDDu6kQUms=;
 b=jCc3F6K65df7E8NcFpzW6X7R0uhGwSvZedsqdgFA8P7QYucsWx71WQMnJazuVkCns+Oxg4Puk7DPRzWAgAtrRCu4lHV69YzwyKoQuMje83zmcFlip9RyXQYvAJNKGDXS1Kjj4rpp2rgd9HVi7GDzcGQe1lxZo+J1mp6/nUlmbts5zUIEVrh/s2XeQ8uk8dTsDI8IZJuFTEJxr4eZe73+Sf0To1Q4QTy82LTVpyzgM5THP4l2XxuKglEhL573y9SEdYE9A241znI6JF7/5hjunyo6STxxftf7gncT9zP0J73tI+Er6FkK5hgbQ69Hsn2wioKm2J572WBdQZMgjolVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by CH0PR11MB8215.namprd11.prod.outlook.com (2603:10b6:610:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 17:20:56 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 17:20:56 +0000
Message-ID: <e084652a-91a0-0c16-7acb-d51a3d2f7ed5@intel.com>
Date:   Fri, 15 Sep 2023 10:20:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 03/10] platform/x86/intel/ifs: Image loading for new
 generations
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230913183348.1349409-4-jithu.joseph@intel.com>
 <ba753b39-1819-35ff-1248-6ce2c2824ae9@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <ba753b39-1819-35ff-1248-6ce2c2824ae9@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:303:16d::20) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|CH0PR11MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: bb70d699-77f2-4cb5-a40b-08dbb6101f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9h3B8wKy5tNbe4XY+Va5GgKF3SBq1X6yvFz7aLudkH7Y1M94tPfbcM2Twysx8cY6Y6A6NdI7gVm2V3gJT86Y7wtIy8n9Q7hYb9VaoyR5YE+CG4igaFPQ+d2/VpKFaVs3bq/0kBCsYddQQobcv9tczzaVYBdKJpfe8ksioIfIsOs+JPDESDptkmBxqAAs5xvFuM79J4pkT9F3l5wAWjrAN1x6ywHUN6noyf959uvxoCGK7UZlNToD+pIU7+yxJ9YmvyR4BgaWZHHFAGaWWa7SVIEnrBzULtcafRGJyFCM93ar4c+Lv6m/TB2lbUXBK1mqhMScjd8ho9gcuRIiEtw0SPGyYj06l0D+IFrZ6YLw6xxOkhNCFNpDnbrznX9qQ5GGDPiKw2i+pFNmonOWSsyQ/wAuZsNVAg0WXh463/d6egi6oh0oGGHLSikBs6xzc+dX852FoXgSq38X+VS8EfwFbdBRMnNGvm2m028XrpblJB/uaFDxZ7AQGVT+/U8ZxzcuwbVp6jAWfXtyzwBuesQoM3XMRhkeBXu9B6BzUz/hAefgZJcZ4mO+KIwBLPtSIjCDIHpwLA4Zs2roFbjKvsA66q8XvVnJuIzolnbirxVoZ06y4MDSjY9Aao9GoBURw2hRCHKiEBQrYu6b44Zqs+y4Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(31686004)(6506007)(53546011)(478600001)(45080400002)(966005)(6666004)(66476007)(66574015)(6486002)(38100700002)(82960400001)(7416002)(83380400001)(6512007)(2616005)(26005)(2906002)(316002)(36756003)(86362001)(31696002)(66556008)(6916009)(66946007)(41300700001)(8676002)(8936002)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJqVURRWHV5c2kwUExLNDg1bDNBVUwvQlE1S1lUTkF4akIrNVJuakJRTW1Y?=
 =?utf-8?B?ZG04cm9YZTVPOTlYZjk4enFUZVJNWGY2bXZpS1pjUG1MWWdsaXdhOEJKeFlv?=
 =?utf-8?B?Z25yZG5kY3hRVE4xb3VpcWFHYm9hN3pGeWlPQ0NIOStxTGpkOTByaVNEV2Vu?=
 =?utf-8?B?b0pCZWxUVlNlTStMYkY0SFVTWG5RZnR6NzczQUtWRXNTSzFISUw1cUZrUHkx?=
 =?utf-8?B?TDlTMGlnaDQ1RXFURFE2ZkhhMzh4WjI3Nk43SjJqL25GNGFSWGk5UUk2YUdm?=
 =?utf-8?B?aU93SE43V1BBM3dRSGVvb3Aycm1vT3RhQmlPWU9UZjhMd2ROSjZ3WThYUU1G?=
 =?utf-8?B?SGprL1VOaHBDL3hRWW5hT01qbk14ang0OWxhRlNYemFza1I5S0pseitqb0cr?=
 =?utf-8?B?WjUybEU5OTdLRHNrUGdQSFlQMitvNllEQ291cmZROWNQdytseEh5ZDRUUmNE?=
 =?utf-8?B?bjViTXk4M1htRkxQMTFoanBJN2ZYUHB4bkJvdytxTzI0R2xtbUZ0aGszZ0VB?=
 =?utf-8?B?QndGVi9JNEptejVzR3VSVnFVYzA2eUtoNDZOS3MrUU1FcHdUK3phY1Q2aDUv?=
 =?utf-8?B?a0JpTkU1cHYxMG1ZQjNBRHlYL3Zoa3VBSllQelVUeGl5bGc1YjBha3E4a3ZB?=
 =?utf-8?B?bzN6YVlJUVZzS1A4U3VIM3Y1cnp6UUZMUGZhU3RkVFhhd0JCVzd6RXFzeTZN?=
 =?utf-8?B?VU5rTjNMNytsb3ExeGVzaGJxOWV2YkxtM2lpMXQ1QnFlcDFZa1A2OU1tNngz?=
 =?utf-8?B?VjAvd0x5V1JnQWI0YjBqQXNxRFNiSlJkUnc2TUtMNHovYjAzVGhFR1FDeHBp?=
 =?utf-8?B?eGNaQVNFU2FabEthcWkvNHlKMjA3MGlPOWppdVdrY3RXTFFOUXByaENkajNv?=
 =?utf-8?B?OTNvVG5NLzNURkJjVjhwb2laR3B6OSszbFdReGdKbFJCSG9FaDdNZTdJMS81?=
 =?utf-8?B?VVhPZDMyNHkxVU93OGpqZ0lxWHFrMnNGc1NZT2xlNGd5VHVYMXcyTWNicmhK?=
 =?utf-8?B?bUJRcEg5Y1FDK0Nka2diQm5ORkxwN205a05aU29TL0xUMWtobVJBanVHNGN0?=
 =?utf-8?B?WC9KUm5vVU9kOFo2Y3RYNWVIUVVEM1V4dTEvVWQ4bWV4WTVQbnI0Mkg5SnIz?=
 =?utf-8?B?ZVNJUUprdElRS3E2b2NmSTk3bm5XVk43Y2l4VkhlS2VTWFowT0FxOEdRY0pP?=
 =?utf-8?B?QlA4ZmkrRUdDK3ZoMWprVTZCVUw1Vzd5dHNZeU82Vkl5b3k4TkwxSExGWERQ?=
 =?utf-8?B?V3E1WXlDRVFGU0g1TExLaUdIK2dlTk9LNUxJOW8xYzl3enFxc3ZsN1ZrQ3FZ?=
 =?utf-8?B?elh0MHFaU3FLbUhKNzVPaE5ETXpSSkQzVUVQdlJLd25CaUNZN1hXYm9FcXlZ?=
 =?utf-8?B?KzN4UnVjc0p1dWt2UUZCMGJ5RCtOM1J5TVVrR01SM08rNTZYZk9oQ3BqQWh2?=
 =?utf-8?B?WDdXQjI0YkJHNHlVWktRQVpUT1lvSHFSTUNwb3dncjJwZENPcGVWbVpIRk0r?=
 =?utf-8?B?Y2tXYkhpTUozWmhmMnB2UGRQN3ZKZlBRUjRmc1F5bjcxS2p3WnYzSnFBWFM3?=
 =?utf-8?B?TDRxa3hqRHpCYlJ4NVh4ZU8xbmVDODZ3VUZQbzhHdEJQYTFEMGJsUGV4UUhh?=
 =?utf-8?B?MWVockFsU0xNVmFwd2UvMTRZRFU1RzF4N2FoOE1MWU1JK2NLRjc5enF5TG1w?=
 =?utf-8?B?QkttVzVqY0FSdW9BNkx6QWFldGdESGFwMHRHcGhvbVBUcUFETTBMRlFSTXhq?=
 =?utf-8?B?SEo5dEpqallKcU5RSGFLUS8xWEIxcWVnNHZ6VTczbUx5VThKaDdsV1c0R1kw?=
 =?utf-8?B?bzJ4NlRIWkN6TFdTcXdIdVVsT0VvNGtCN2tvNnpPaVpiRHZXMXpEZFdFUnlU?=
 =?utf-8?B?dUcwWXZYNWhqaExGUnNpUUdqTnVRd05oS2gxTHFXc01Kdno5OE1LUFR1bGg3?=
 =?utf-8?B?cmRrd3dCTGRSNHZjWDlxN0xvMWNNRitQYWtaRHowTDNadkp1ZVUzeUdhMy9F?=
 =?utf-8?B?bFJBRHdnbm9yYVZqRWF0MFRUS2w1YjFCbi9JdHVQYVNpMnZmNVRzb3pnUEZN?=
 =?utf-8?B?enY5ZmJ0QWZHSERVUGRFdk9vK1FQZU1MMkpGZDlVbzNtRHkyVmk5eWI2WWdR?=
 =?utf-8?B?YWFhR01oR0pCd3MwVXlhYlFET0ptU0Q2azUxS3Jzd3FaamgxMHNpYmVqMEZv?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb70d699-77f2-4cb5-a40b-08dbb6101f12
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 17:20:56.1884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iwh0lDecHwLNWuOZhPUj0s5Rk1WKZFVx2ucrxT796mFnWx4E9IJc3oteMB43bhrlIVzyobpt4D7lH/uBt+jYnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8215
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2023 9:46 AM, Ilpo Järvinen wrote:
> On Wed, 13 Sep 2023, Jithu Joseph wrote:
> 
>> Scan image loading flow for newer IFS generations (1 and 2) are slightly
>> different from that of current generation (0). In newer schemes,
>> loading need not be done once for each socket as was done in gen0.
>>
>> Also the width of CHUNK related bitfields in SCAN_HASHES_STATUS MSR has
>> increased from 8 -> 16 bits. Similarly there are width differences
>> for CHUNK_AUTHENTICATION_STATUS too.
>>
>> Further the parameter to AUTHENTICATE_AND_COPY_CHUNK is passed
>> differently in newer generations.
>>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>> ---
>>  drivers/platform/x86/intel/ifs/ifs.h  |  27 ++++++
>>  drivers/platform/x86/intel/ifs/load.c | 113 +++++++++++++++++++++++++-
>>  2 files changed, 138 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
>> index d666aeed20fc..886dc74de57d 100644
>> --- a/drivers/platform/x86/intel/ifs/ifs.h
>> +++ b/drivers/platform/x86/intel/ifs/ifs.h
>> @@ -137,6 +137,8 @@
>>  #define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
>>  #define MSR_ACTIVATE_SCAN			0x000002c6
>>  #define MSR_SCAN_STATUS				0x000002c7
>> +#define MSR_SAF_CTRL				0x000004f0
>> +
>>  #define SCAN_NOT_TESTED				0
>>  #define SCAN_TEST_PASS				1
>>  #define SCAN_TEST_FAIL				2
>> @@ -158,6 +160,19 @@ union ifs_scan_hashes_status {
>>  	};
>>  };
>>  
>> +union ifs_scan_hashes_status_gen2 {
>> +	u64	data;
>> +	struct {
>> +		u16	chunk_size;
>> +		u16	num_chunks;
>> +		u8	error_code;
>> +		u32	chunks_in_stride :9;
>> +		u32	rsvd		:2;
>> +		u32	max_core_limit	:12;
>> +		u32	valid		:1;
> 
> This doesn't look it would be guaranteed to provide the alignment you seem 
> to want for the fields.

To Quote Tony from an earlier response to a similar query[1]

"This driver is X86_64 specific (and it seems
incredibly unlikely that some other architecture will copy this h/w
interface so closely that they want to re-use this driver. There's an x86_64
ABI that says how bitfields in C are allocated."



[1] https://lore.kernel.org/lkml/SJ1PR11MB6083EBD2D2826E0A247AF242FCD19@SJ1PR11MB6083.namprd11.prod.outlook.com/

Agree to the rest of your comments ... will revise them as per your suggestion.

Jithu
