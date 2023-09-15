Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7DA7A27D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbjIOUOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbjIOUN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F6E2721;
        Fri, 15 Sep 2023 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694808809; x=1726344809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Emx6TQqTBKAVjvt36D8c38wnuDjmgpbdla30Nh8cSPQ=;
  b=GH7muVXCffu2e/Hz629+QuqU9Sam0GW3LVyZuYyb+rgfiTjjcKe7fjc0
   HtqCFIT8NjLHLuWoITtpgJ6lBAl//d/W7BK8xGqneTo1mpbox7Mokh71l
   ZKlqacErNey5hSynDZJxGE7OcxNJIYSXX3KcCI0oe9+F8ytYnLyymn+Cs
   68WmROf0exTf1+94wv6N7G6D7ehOJZpu58ODePjkKs29PCCdFsz65ZaK9
   3KnZeORHSh7u7CAH5hPsMZfbWAeY58WzO1hIv2OIGJWTcrgkhDEzEGXAt
   Jryw6+kNu9CwZXlT9reoO0Z5/ljRGAYlCpLVtp9yTqkIYFRFZli6q3aSw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="378243259"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="378243259"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 13:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745120734"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="745120734"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 13:13:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 13:13:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 13:13:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 13:13:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 13:13:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AksA877j3ejTIBHfbQB8kuQEA3ECg6aELoHzYeY6hVA/4j7tUBz/EB+RI74lorrTKjCRNNhCMzKxIGnOHFZ3MDRYFoP7tjQimemujqZ+RDuVjsfJMXLjjzSt2dRR1GEsV7QKd3wp3xyaM8B5fhaUXl1/kCZkoT8bog8ex85ojbRpDJc51d7UW2IKdLtZwUDX97CdZ+jPjiOzRsBfk4v5pLXgpK5uNbut5TfJAyxSKAzUclPyM7iWDSXDMLgOeYg7dxDAlHUNjLMMnFnxUnjE/1jzBlzmkO1A2pbTgiwmGd/eCWtLvBAhshW8YCwnIP0memdFP1Rwymgc6bxv422PXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/Nt/vQi1yI8Z7sBWmwABhqrEBWwPrUb97lXhpKV6Yg=;
 b=a/nYF1qDQBptsDKohazKVuJtmsUBpJDgxnS0lQiGPGquKJlUldSd0gKMzFJxTsPS1XOMXWN5SVI9igHDwuUYQoKt+mif6AjXdeLzn+DysTQqR/2fmIp1VsiagXPVMp9veHptovour7VTK5/+A9Q0jH56NLxKChuwWgqMO3dFE6MtYN14PUNoecsh01DrrtiLscjcDm6PT4fTGQI0I7AUhzSMMZJrGW0WsAUlUrpEIMohjXkkHyARlT7aEkRzs60NGvwmbNrX90o9BWzdRNjgvyphkn+gAIcSBXp7Pu/z7mQeaU/ys0wpojgqyxUEfG3bgK2QT/4m1tnTzJWD10CVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by SN7PR11MB7090.namprd11.prod.outlook.com (2603:10b6:806:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Fri, 15 Sep
 2023 20:13:25 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 20:13:25 +0000
Message-ID: <dae23faf-577a-182d-537a-70acb9e0dcfa@intel.com>
Date:   Fri, 15 Sep 2023 13:13:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 10/10] platform/x86/intel/ifs: ARRAY BIST for Sierra
 Forest
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
 <20230913183348.1349409-11-jithu.joseph@intel.com>
 <cabbda89-f89f-aa75-d661-c8d5f6cc5d93@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <cabbda89-f89f-aa75-d661-c8d5f6cc5d93@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::32) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|SN7PR11MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d645b7-81ff-4f02-89a9-08dbb628376e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMj0Souf3uBww8gTo/rIVOpBXM5t/XAb13//Tu9J5n2Fyu5n2KWu2WbdhgJHDWugjYj9xhYdeBh9l0mQ/jNO4J8ztFISTNqjgQZ8V9fLGg1Ek6+5azkpncygWbfgcjAy4x8j4r3Ho/EkzCvOrU4eIlTn3olrKiidPyw2Qn8i7UgqCBFG7mG/65OTNtpy82OQVzJOltCLfcwdvy+NGhO+of61g0DqTOdWZgV1bMPhhg6t0hcyOHXxh38xMIjpqRR0aZ4mtruMNI81hydsPeCfhSR5X3wNzFwlMfoD8IrvaajO35fT7Epv5LiCzw7Gv3eJG2Q3W2s8qYsasPoEi8bDHtQez4EQ42Yq7hEquaL/jwFqsNynGyUlY55T+VLBq/tlS6vsBVjhBYITSr0kyzVKujHUoSZZzTdqjobo6RYQx9nGO3uldcVCCJWysYMphK1ms4xre0hD5ibYNLSZNonuAbntav0qACyj+igtZpK8qDFcI4GB74WH15KwRxXhumnnFT7eHm0JFh/OFwjTks9cMZ6/VPPGeFI6umEz62Q/oS5L/uM680cV9br9OWiIiQ+SJGVwRJM4uT9d061yTy/rIr4FoZ4NE96MAQYRdBNi9nYJ7tu4gYb/l+BzOLK/HV4ZcUOBNvpsy7/ZguRjcwDdCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(1800799009)(451199024)(186009)(41300700001)(66476007)(66556008)(316002)(66946007)(6916009)(478600001)(7416002)(38100700002)(31696002)(2906002)(36756003)(86362001)(4744005)(5660300002)(8936002)(8676002)(26005)(4326008)(2616005)(31686004)(6506007)(6486002)(53546011)(6512007)(82960400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUtTZGloeTdlSXlNTWQ2U2NEaDB5ZVV3Q05HRVF4dW5ZanVBV3NrZTJWL01x?=
 =?utf-8?B?SG5sMDJSY1lXWUc3cmp2VERVZTJreG8rSG5pNlRGbEZLNmpvZVlMQklRTURh?=
 =?utf-8?B?TXRRNzNOUHpsN091aVErNzVXVXVSbXhKRDNDTTVkaGJ1L1pVYUJoK3lIMWo3?=
 =?utf-8?B?UU9PMGJ4NmhLT1pvcnJBQzZTeCszWSttK3RYdG5zZlk1N1plK2N3TEJpQnBz?=
 =?utf-8?B?cXB1QUg3TkdwVUNwN1hsL2t5QnNvdGF1Z2JKYzgzNlBEbzl6ZWVQWUJxQkxN?=
 =?utf-8?B?bWthZU5CaEk4dnhBU3NXcVZsZGJVbGxGUmI1ZzhoVWdzMWI2dXQ4VFlteTdZ?=
 =?utf-8?B?aTdoU0FwblY4OTYrRWdDS1E2NU5ZaWlRUG0wbFZ3SEN5NElmVlIrYVh2MWRJ?=
 =?utf-8?B?UlJMZjk4MjUwM1hhUlNGWGlJb3R1QzNjekM5L3dvRUpGQnJoeTY3cExhZnRl?=
 =?utf-8?B?MTl1VWVqbFRrUjV5VlU1eWZaQk4vV0JjQUJSUElOeDVJZkJIYTlUQUV3NXJ2?=
 =?utf-8?B?aTcrYXcydWlOdFZsdlZ2YnpLYTUxZnFjaGVjd2IrbzEzTktYYkdoMmw4d2Ey?=
 =?utf-8?B?aGdPMnpPK0xqbHJKTFVuVVdMdC9LU2R0YVRCK1hSR3ZyOTE0Tk5sTTQ5L0h4?=
 =?utf-8?B?a2NJU2tuWW1YODBLdk00aDBtcEU0dzBLdVd2WWFjVG53SDNFRCtISWtCdElJ?=
 =?utf-8?B?N2Y5WDd3TUhBeHRtVTVJeUJHd09LUTZwYTg1SGZjT1c0N2FDK0RSQmF5Q1Vu?=
 =?utf-8?B?VlJheTZyYkxDdFkyVTM0dkoydzBBemZrZGhTeC82T3ppcVRwWUYvc3B1WFhi?=
 =?utf-8?B?S1Zyb3NSM2ZSWWR0UWw5Uk5oT2JTOEZLN2lnTnpyRzFyM04zRUhyWGFESy9M?=
 =?utf-8?B?Q2lQMWh4RkdXTVlnZ21PT0FPL2JlV2dMdFZnR1QrMzUvTWNkL1ltbDAyc1VK?=
 =?utf-8?B?cWVWYitMb1FDOXIrZ1JSN0d0dHF4aEVaY1Urd1d2SVZWSy9adHAvb0tEYnl4?=
 =?utf-8?B?Y0FBRzVxK09jazIwMXJWWFpHZ1EyOHZIYzhGUkVGZjdQOTk3MDk5Vm9USzJ1?=
 =?utf-8?B?MGdXaEpNaHZUSlpZaDJpZnZNTXlCMDcwYzFYUkJBejhnV0pNakU2MzlqcXN2?=
 =?utf-8?B?WDVES2w1d2w1dXlTV0tEbUJVTmlReHlQcS9TN2JWdU5NNERQcWxmbHVJZ01T?=
 =?utf-8?B?Y0o3KzlMcDFlU3JUWVNSSFF1N1BVUjVHbko2ZjM2a0FMSklCb2J5OTV1RlNH?=
 =?utf-8?B?RXY0NGtUTGw3NldrMjQ3dTJkT3R3U3puZWgxaEdnaXMvTlQrYjUycXJQa2ty?=
 =?utf-8?B?bmtycFVlQXlJZlZwQldnYmdCUy83cU1rMVlaYUNNOXphK20zR1o0QXNpNm85?=
 =?utf-8?B?NnBrQkZvOExDQzJrcXNEU2dwWUpWdHZMRHNKeHJMQXRVeVdvUE5VQVdrbGwx?=
 =?utf-8?B?NUhFY01jVU1tNEdTTWlZVUc3VW5yN2gxYmN6dFhndGM5VjNHd2NTMzhjTVJN?=
 =?utf-8?B?aWVVVlRkMm1xTGIrVFhrcytyUmowVkYwYldxckRka3RvQnhRTTFwZnpFelhW?=
 =?utf-8?B?U1lUV0ZlVHdQa0VBNm11V3cvVE9GaXYvUzM5bjZTOHhBMGR4NVo2WU0vSVNj?=
 =?utf-8?B?RklPV3ZNdEJhQkVUSXB5UFkwc08xNDhXSUdwZlQyaGs2KzBQUEhpbllTcVh2?=
 =?utf-8?B?RmlwYXpYaWFkMFJoSy9oUW42STgxaytRNHJlNkFVWjhoMjZYYzRFSlRLVDM4?=
 =?utf-8?B?NTJ3VFRSNXhSNHhNNTlqWWpQbnFxeWFFRGkwbUxiM0tsMjFGb0ZqSXNzQ1Rj?=
 =?utf-8?B?MkZzcFplM1kzemtFWVkvR3E0THNGQ2lMaHUrbHV4N3FBN0RpQjBsQUN4RE5F?=
 =?utf-8?B?SVNneXB6V243T1kwOXUrTHRpRjRObU5tWG5JQU83QWI2cFJxYkFhcFNjYjhm?=
 =?utf-8?B?MzlyZC9LTURuMkVUcGNReHdBR2lheHBrUCtJdHdJLzZYeDZpKzI4a3ViUC9r?=
 =?utf-8?B?VER2ZER3NTJmbHllSUwrZG5FNE9vTTZCelhyeTdSYTNYSmZvdVNqZS83Tm12?=
 =?utf-8?B?SW4wWktUdTFnQkVnOFFTMk9XZjJvZTVVT09mMjFJMy9Qd1ZQdll2L3FOaW5m?=
 =?utf-8?B?RytEVUJBN0dSZ2ZSemFURGc2cUZIZjZjREsxL2dYeFM1dzdPbUluY250T0pk?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d645b7-81ff-4f02-89a9-08dbb628376e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 20:13:24.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjwO4wZmMumryGw+upBlrjW9kNxVulvZbUerFUcAZhKBridKTfP4DNf7CvDMSlSII/p4AM+61GaqkVlZWtCmoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2023 10:04 AM, Ilpo Järvinen wrote:
> On Wed, 13 Sep 2023, Jithu Joseph wrote:
> 

...

>> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
>> index 997d2f07aa0c..9cfd5c015cb2 100644
>> --- a/drivers/platform/x86/intel/ifs/runtest.c
>> +++ b/drivers/platform/x86/intel/ifs/runtest.c
>> @@ -327,6 +327,38 @@ static void ifs_array_test_core(int cpu, struct device *dev)
>>  		ifsd->status = SCAN_TEST_PASS;
>>  }
>>  
>> +#define ARRAY_GEN1_TEST_ALL_ARRAYS	(0x0ULL)
>> +#define ARRAY_GEN1_STATUS_FAIL		(0x1ULL)
> 
> Unnecessary parenthesis
> 

noted

...

>> +
>> +static void ifs_array_test_gen1(int cpu, struct device *dev)
>> +{
>> +	struct ifs_data *ifsd = ifs_get_data(dev);
>> +	u64	status = 0;
> 
> Just use space instead of tab.
> 

Will do



Jithu
