Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6E87CB7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjJQBUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJQBUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:20:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE42A7;
        Mon, 16 Oct 2023 18:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697505647; x=1729041647;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dmBq3AeZKxpcEx+sQCf6lSbMtYjq4/rdgEWJg/KOnIM=;
  b=NTxMa+CCs29jB9J4n/f1ebe4JndkPsqaQRk6fgAdrw5+Qy7x/0dO3SMv
   Tdq2GxICt6fMYonA25IBqxI8bwzG/PmNfCwTjUEGK3yKsJzabMEg+v0x2
   HLLd18PGLB1hev/gxJvQye3/itAxmEB/bk27MnrC4hwD/fdl/mrieICqT
   0X1FkgMkPQWTkffmHKHsUjrPZJH3n/izWTa0krMVcmhi3oTvAxgCFFGTm
   1I/UK7S98MJzvvIj5Vj6AKsvO71dEG9jCW2bk0I2ot/hMcnSvhfVKZ37R
   EmvkZXwg9mG5uyrSTnCNGsYOGoGjwdzl7oJvYk081uIaRF9GpvZN0wku/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="471895327"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="471895327"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 18:20:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1003165195"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="1003165195"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 18:20:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 18:20:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 18:20:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 18:20:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 18:20:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LofusAth0BchEGWz8eSfZVi+Xc/bLXE1zMEfgBpL9z8QN7SGJnLWoDw/dWUpxBMJanZCJFAIZgnPxXK6cJKaMCQCcaC8qxNY/shfJxtqNdolzd/jEyColTWUzL4il6011vHtI9zUZbkXhJQIabHXWQ9OOSgonxqFUS1yW3l1zPwzfnGGU3UCe73k5EPi6Tjj5PRqPoig1toy/p6DABENoqhvP/NTKnbnEcmbJ39+mkzN2U0ZpM/wi10mbIiVVKySLnyeGotYfR37HT/LciHVjFhtQlb/d4vbsPrTD7L7S/nc6CunYCWLZE5nj7JHEItjRL2dPqv4ddGouu5eui0LvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OtJ17UfhBqpSYp3RWGgXRHEXzAa8wxDtt/5B+71f9s=;
 b=RWuiDZt+PskdRXSbdCdcaPiwShibKXRY0qOO4XnEZ2yaixpTDrfHshx/+EdXiNiYR7NJjNWHjP1a5+fVohHviAIZ/CJTzIKu2AwEQi2TuPVFFY0x7pKhggUJM95tVZE/GX/4HIV3TLX6PtJQPqcdCAXw7F8GRN5K6BrUcS0SrUyve/r8XhJw6yanD5V4ckI6/BmH08WGVhE3/+dpieNmgxtH/dpYU9Lk4u9Gzh1CI8yiu80WNxBEvb5n0btSm71LsqHnP4/PB1vWTW/qshf/IsATjk07eznkru2Jee95O16M4BuBWOUq88m1tQo5DsXu/uhh32LAm/DN5jgQwWEA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3728.namprd11.prod.outlook.com (2603:10b6:208:f4::21)
 by PH0PR11MB5579.namprd11.prod.outlook.com (2603:10b6:510:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 01:20:42 +0000
Received: from MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::4286:c28:4465:752]) by MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::4286:c28:4465:752%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 01:20:42 +0000
Message-ID: <916aa2dc-ea1e-4f23-a958-fa36dfb66af9@intel.com>
Date:   Tue, 17 Oct 2023 09:39:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
 <SJ1PR11MB6083A23BB89F4EE0F44B2794FCD1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <233e17ac-0ae5-4392-a5e4-ab811a155805@intel.com>
 <20231014101850.GAZSprCtc6QYEiGedU@fat_crate.local>
From:   Zhiquan Li <zhiquan1.li@intel.com>
In-Reply-To: <20231014101850.GAZSprCtc6QYEiGedU@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::30) To MN2PR11MB3728.namprd11.prod.outlook.com
 (2603:10b6:208:f4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3728:EE_|PH0PR11MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: fa94fc6b-0121-48da-709c-08dbceaf47a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUQg1Qb398TmLsAgx1BWfMgzq+i6irM5LdVIWRkt4pSJyui/KJmOtC9Qh31GeejLedIuUIBbvVIymS1gzB24EQ7S+NQ6XkrtSg1SfjDWKaxEE9ZM5Y0v1GK9uAEbKit7qOk9LaWkfRPeqS6m6weLIqAn/XcVZfOTsQpiSmbPzL6bobtmYPc85J4oMcVIIDa2ggBeprErH0jIR0wPdNAxr5pzasN7EZhS6rcZ4VO8mbb01wBTnMNvBKSJmDNxHc/cdl0ZSiyP61lvGsC+4pLfCu1rshc6ZJ0kLINMo99BD87fwJFMg93dNVl2tjzgPczPVTWDOX77k6KzOmBZhVFHhWa5qladE1vZQ98DW9VwkpuRhaV/OAy8Pd5a0mUIaEQThj5vVe3oKkZgHMoTJgiWsBlzE/OkTBqG9vmaudvd9hHFQXnPmQ6I0BAZPEkL1iOtN1PLB8/NNKJ/tIQTWlHnFAJE8iv5MyeG6LqXJeIEZN6OL28XBK9/K0hjfIlIg93S38+xRVm3F0S21woG6qASmFVwMhqjPDSfq4tkakcwTX5aJwrv7m+vbEZksOWR8ON7Q/C5tst+lch5KMfaavzYcxQNhRSBBAw7IcQHPGFFta3ke8HE+a5IuuKoXAQxnME97MDqYgmUqxbYjKMuOzV/ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3728.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66899024)(31696002)(86362001)(2906002)(41300700001)(4326008)(8676002)(8936002)(54906003)(66476007)(66556008)(316002)(6916009)(66946007)(5660300002)(36756003)(2616005)(26005)(82960400001)(83380400001)(6512007)(53546011)(38100700002)(6666004)(6506007)(31686004)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXhaMnArajR1bzZZbG1QVW5hUmtwMXljL0R0ZkIvMmxGS2VYcHkwY0o3OHcz?=
 =?utf-8?B?NW54dW95a0xjM3BDbmhPTmxsYmdnSUNZNGFGeWNEZnFiZU9pQk5ndEN6TURn?=
 =?utf-8?B?NHdIc1A3UTBBNGwySTMzN1RBcWN2dnhTWFNwZ1V5T0Y5cEI2RGErakw2S21L?=
 =?utf-8?B?TXMvM1JhQzA4blROY2JDK04vVkU5cHY1VWVwaUlPbmtCODhMUUQ3ano0R2kr?=
 =?utf-8?B?T1ByeW1GU2lBeFRZNjNReEhadGdxUTlLTXN3RXl2c1YyNFY2ZEFUN0tPejla?=
 =?utf-8?B?dFZsUW5Xem5wUW9jVURFRzFSZkI3QnJISUltc1hISlJVcUM4OXFVaUp3UE9Z?=
 =?utf-8?B?NzgvVWZXNnpmOEJHRlg0RUxBNHh0Q0k4KzVOQVdKclZKNU9EUWViLzZZeE5i?=
 =?utf-8?B?dWxxeEV4T3N0M3B1MnVEc1RGK3lBckIrUVdHcWVhWFQ2Ri9wMEtmQ1lNNnJQ?=
 =?utf-8?B?aVpnNEFlNi9EbG45UjBjYlRoeDU1V3Z6cWdjRWFtK3hUdDRVSVZHK3c1V2Jt?=
 =?utf-8?B?T0NBNjl2YVkrVDdNUjB4dU5pVGNPc3FHaHBYVHdQTmxoMkFZazJ4R1licXdT?=
 =?utf-8?B?Ukp6T2dJMDlkNmMwajE0cFZCazA4a1U1eHBDbHozaHk1Qmpla3lEa1ljYzFR?=
 =?utf-8?B?SGg4ZUZmL3plcFJlWWNYdExJcDJMQk00N2ptRjc1RmF0aVpNSWp1dndlME12?=
 =?utf-8?B?NmFZRE83L3ZVSUFKZmZ5aU5EdkFOM3lrb25aQ3AxcW83azdMQTNqdHVmMGQ0?=
 =?utf-8?B?enF2VmhkemhnVVBMUTdCNG5CUVpaWW4wcDVFZTNKc2phbWVWUGNKV3ZCOG5U?=
 =?utf-8?B?MTF2YkxKdjkxelU1aEdiNEorTXhCZHBZUVdtOE12a2NSREhlQUtIbUdLclR5?=
 =?utf-8?B?M3JYLzNwWkJxT2s4TzRJQ25BY2ZVQ2xjc2hwVzhBUjdWelpJem5DNUp4cytx?=
 =?utf-8?B?cWttbnJHNGlraFJvd2FXUUE2bVdBZVJiQzFzR3lOKzFOUFBvancwMzY0UHlp?=
 =?utf-8?B?aFY2VTdZZHB6a09uWXJuSyt5azU5aS9PcUM1c2R0Z0tTZVVqdHJKSjgvRHIv?=
 =?utf-8?B?aS9Zbm03cTFtemcyNWNmN1BvSjhvd0ZYVnkwczVPdSt6aDFUUnR0MWxCbnVX?=
 =?utf-8?B?c2YrclFtbXJRdUw4Vy9IU1daTEFGL04zakd2eStUb3hiNVBsQ3VzQkRpcU4v?=
 =?utf-8?B?V3NvM1QwU0U1ZHpxWkY3V0phZCtDcXJoenlLYldLZGVmMFBmSTg4d2xWcnA5?=
 =?utf-8?B?bXFqanJja2xRSmhRcTB2OGNUbjZhbEhUcUFZdDhGa0M3cVNxM1RJT1c4YTl2?=
 =?utf-8?B?YXlNNnVxeC80QjhBcFFjU1dIdUExSDNSZUQ4SS9mNUJWUVBTUnhSY1R2Vk1E?=
 =?utf-8?B?ZlV2UHdHeXErQUI3V0NUSHpHbEtTY081YUxzblNqVkV6Wm9kd1RDUGtmd2tF?=
 =?utf-8?B?VnkzeFRROUkwZ05KQ1pHRFJIZWxzRTNtbHQ3VjhkZkVlczUrRkNFT2lGajkv?=
 =?utf-8?B?a3ZDbFI1eUZpU1BmbGJYS0RvVkdjLzZKRENoejF0enZhMUZIN045S0xJQnAv?=
 =?utf-8?B?RmQ4cTNQUjlRc2hHcmhZMHFzd1BCNVd6SmcwV28wdEhrVExnYVh5ZUY2UlBm?=
 =?utf-8?B?VVBQd1RFN003djVjR2paS1QydDFkdmFLWHFJRWI3NkhBSEpjeXJaQjl2UWhT?=
 =?utf-8?B?Nk1oZVR5NlVndXgvbzZaRS9IWC8xL1FSb3J0R0lnQnRVZzJaNTVLeGZjdnU4?=
 =?utf-8?B?UlROY2Z6NWdqeTZ2Snd1M2VBd2ZyKzdaUzlObnZPYkVqNWpUZm5CL1RPYVpS?=
 =?utf-8?B?bTlUQ3pFNjBzbWkwQW9wZDhJRnc5QUJucjlWc1lTT3Z6dDU1OFpMUW80ay9w?=
 =?utf-8?B?MjViRVVPTlNnZzliYU1ZZk1FSTBIb0tSK2JFYWZTVGRFMkVFNEhzSEVpWno0?=
 =?utf-8?B?aXNTSEVhVGduUFlQWWt2Y2ROMlp5RFFneThJc2o2WmdycmhVMEFuTlFYdVJW?=
 =?utf-8?B?OUV0UWNVVDJPMXRwTHRzRi80S3ZRSVdBRlpTZGdyNm54WGxSQlRZRXVwdVNa?=
 =?utf-8?B?cUYxcEtsaS8wMzdYeGxmOXNvVjVuZzRQNk14NmRrQ0lWNkkzK1c2OFpORjRu?=
 =?utf-8?Q?nSycMPaD8rsjPt3j1FlFGg2hq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa94fc6b-0121-48da-709c-08dbceaf47a3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3728.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 01:20:42.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hxA39xgHb+I7NkTDIDguahQJ600Ebws4vXUyXciVFRmgaem3a0n/gmKPSxWZ2VfQo47jQXYWizMo04p34bZ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5579
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/14 18:18, Borislav Petkov wrote:
> You should slow down and take the time to read the document I pointed
> you at.

I'd like to revise the tag list as below for next version, and reference
rules are following each action.  Please correct me if I still
understand the rules in submitting-patches.rst wrongly.

	Co-developed-by: Youquan Song <youquan.song@intel.com>
	Signed-off-by: Youquan Song <youquan.song@intel.com>
	Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
	Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
	Cc: Borislav Petkov <bp@alien8.de>


1) As the author of the initial patch and the person who submitting the
patch, I put my SoB following Youquan's tags per below rule:

	Notably, the last Signed-off-by: must always be that of the
	developer submitting the patch.


2) Remove Tony's SoB.  I had confirmed with him, he needn't
Co-developed-by: tag, so the SoB added by himself in V1 and V2 should be
removed.
In fact, I'm not sure how to deal with such SoB for "RESEND" case.
While resent V2 I retained the SoB to reflect the chain.  According to
my understanding, the RESEND process emphasizes "not modifying".


3) Remove Ingo's SoB.  Because a new version means a new review cycle,
the SoB added in V2 should be reset to reflect the *new* real route,
unless Ingo needs a Co-developed-by: tag. Relative rule is following:

	Any further SoBs (Signed-off-by:'s) following the author's SoB
	are from people handling and transporting the patch, but were
	not involved in its development. SoB chains should reflect the
	*real* route a patch took as it was propagated to the
	maintainers and ultimately to Linus, with the first SoB entry
	signalling primary authorship of a single author.

I missed this point while I sent V3 :-(


4) Keep Naoya's Reviewed-by: according to below rule, because there is
no substantial change in V3.

	Both Tested-by and Reviewed-by tags, once received on mailing
	list from tester or reviewer, should be added by author to the
	applicable patches when sending next versions. However if the
	patch has changed substantially in following version, these tags
	might not be applicable anymore and thus should be removed.


5) Add Cc: tag to you per below rule :-)

	This is the only tag which might be added without an explicit
	action by the person it names - but it should indicate that this
	person was copied on the patch. This tag documents that
	potentially interested parties have been included in the
	discussion.

Best Regards,
Zhiquan
