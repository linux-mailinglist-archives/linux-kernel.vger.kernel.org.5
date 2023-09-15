Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B19A7A2557
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbjIOSJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbjIOSJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:09:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E992121;
        Fri, 15 Sep 2023 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694801338; x=1726337338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HdSzUtpy5M5Tq517nXY7rW6N/8gbsekiRenlUGhvAPs=;
  b=Z3sn1DCsJ4GJhLCkpvvMeQV44BM+/cQzGSYcLDxqzZlG+7VB0Dg/aFgD
   EmHkeFPCLQVvwBcH141H5wQQ2K5wXXmdSJIWnw2d2SYKhVmonN3xuggSt
   uV7bkTM2gYWQYPgOhRVN0zGH6Hz3CnpMcZf+sIu270yFNjuPJwsnDm0QT
   TmuQTfR8/L2BUlXWviLvh/AiFX/6aQumMHvMbR9dwXCqcFrCMG9VL/OoN
   O3dNI0sHhD+P5qXBT2RvABkcpVjG3L0b4Q5SunA55WPp+d9Kl6OycFVlX
   2sp809SioPUCuMk6RNW2NlGqGhlg2zySroajHA2TXQHL2wHEb+S8ma9sp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="378223572"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="378223572"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 11:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="748286083"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="748286083"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 11:08:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 11:08:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 11:08:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 11:08:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 11:08:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsOKO8yhx0+OAsB1QXhLeErb+SRRQVMJ85vY1/F6uRZKM3muuxNufquWApbf7S/WgI0GibiqROR6mean9Lifiay5BTWGgsL8BRDnFB0Egg6ncnMhN0fGb/AZdaMy3JE3RT3Fx9Rb5lhIgud6aUQq/f176Pl8EBpwQVsy73y9a0XoV5gpZr/hv5Omk/xzZ4xGUHLvE+Z2jRWeCD2eSExC1OnJFq2DXQHwYAmw5384RALGwjOYDJwHRVou2RwgGQRbp6DLpp/mtbWx6tjT6kieazJzJgjTv4nrcjHxaQlG75DGEYI1EuewL+QU6ggJKjJeYUr1+HUadB3kgK6efB3+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1Hy3Crzik92SFqwjRPGPB6rkHWUHtHNHj0Q2ouYpZE=;
 b=HXdV+Wd8WZtw7cac8fDBQuOnACN7jzCEFOahJjZGDoX3Z62HrEsYXHN/DF2KjnVor/cqS2i0f59nV2gbEDc55SmN8fZvBYCHaMSIkx4Bs2+Z+2ECXMAkvTfMNBp0rf6PjPUf/s8Q9qUR1JsOr4Ngm6tHDg+WvU34GEsiNki/3LtFAVgcF9m5y7HB5zedKU5yyxScbzGthGLVTBEnM3GAJZfxEoegz91d4IKO3jXpgnR2iobS++3PNWioO9fEUsR9MnRaNu39gxyAbR6udhP6j/+UknV6j1oZF7Q4SK6Af1iBXmZIMaq8nIEZvPUgbH3JyAYkSTHc2o0DdZILcHMzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 18:07:40 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 18:07:39 +0000
Message-ID: <d8c1b001-1908-7e8f-70d3-30f01299f09d@intel.com>
Date:   Fri, 15 Sep 2023 11:07:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 07/10] platform/x86/intel/ifs: Metadata validation for
 start_chunk
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
 <20230913183348.1349409-8-jithu.joseph@intel.com>
 <3dc5207d-37b7-52fe-954-889d5456192d@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <3dc5207d-37b7-52fe-954-889d5456192d@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:907:1::28) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|PH8PR11MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ce0e60-5bcb-4732-b0c8-08dbb616a633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMlTDQJkJ5VUGHTAH2NDX2e+d6Kvv6U5Ulqwxc77ml05FpVye40x09S8YFes9qYdWo6AL70UrCcwSJibUqAyUbDyhISG98liaJlEqsV1iYaF3hROncNt3tIOL5Qz+OgBjL17QjbbFwLMLWoq13kjrnB3pe6isFyfW+vfL7DBveDJlvwfXL2vWGIct4UTeIHjCHh+IdIaEKPAjfJ+VYa0dxu7dLhnwvtzu99miOv5FE4iNL4yNP2HREqhH/dlvbBB4eZsDjQf+z1XabWENp7w2/9WD/IQhx+sDjCndXlo/NUEskYPRWJw9uZUkGmZ4n60LdI9LmX/VNiZ44gie46DgS8LLYiEm9yFkBkbdmUrmM98qhbCsNvo/v0xMupVzcfqHz+SaYrC893a29epDzE8UXsal5tz4zZrgv8AVfvMHVkhGGfS2xLGGjOT7QubDBj84Npt7B+Kjf0SVOlfsqsBz4Fki97caBCi7J7FnigG/3SsHq/4Xn9pp2XwaIzUSjmYHMm2fgi7QnFmMurAgAEWcCfebdOXORMHFY0cjEDcMFPGMOo+qJpnjdMsuyRSWAI6wPSqb9uQ8ch4WMoPEdNA1nim9p8MkSSSkMsDtCxyb8wPb+8dYVGv6c9pfFFO9Wm/s0WvP9B0PU3DDqtTQLuBNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(1800799009)(186009)(451199024)(31686004)(66574015)(83380400001)(66476007)(6916009)(41300700001)(66556008)(4326008)(5660300002)(316002)(8936002)(38100700002)(478600001)(8676002)(7416002)(66946007)(86362001)(31696002)(2906002)(6666004)(36756003)(53546011)(6512007)(82960400001)(2616005)(26005)(6506007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVFHRkpJREE5OW1JUVNkOHNlR0RJamJPOFFSZDJZNXlrbVpvQzRGUHJOZm1N?=
 =?utf-8?B?RzZHbDV1STN1UnJnR1I4UkJHS1EvdkYydVljdk5MNzF2WmlmelFTa3g0dWJl?=
 =?utf-8?B?S2hsSDQ1Lyt4Ly9rY1BJLysrc05iaGN2dGJMMTFsZ0JCYytSZFlaYXZoN0Yy?=
 =?utf-8?B?bjF6V2dVNFkvd0EweDhpUERZRlBDbGlDam9iZDFNbFlKVkJkT0dHYUxmQzl4?=
 =?utf-8?B?d3ZNS2xJQTc1Y3VxOFdIcHlmRkpSSUUzRnliVzF3Z2ZZVFdibWNwVk11RDFO?=
 =?utf-8?B?MVlWMEtyYXgrY3hWVnBqeDRkQWxHK3lCWndTR2I0cmlFd0o1NXh4ZGt5QXFp?=
 =?utf-8?B?a3lEWXArMWhWSjdRNnExZ3k4bUV2dURzTGdQSFU5c0I2S0RFdU5scm9VTllE?=
 =?utf-8?B?clBPZkhGNVZnY0E1Qjg0dWlvaFl0WDdqUkp0OXdvZE52V0xOTEdMVTJKQ0xN?=
 =?utf-8?B?Y0RhUnNkcmF5NmNTeXNQaTQ3UTV3YlA2NGlBYitDZ2NWYlQweTRFcDJ4OXZO?=
 =?utf-8?B?ZERxNEhndXcyZkhUUU92Qll1b05sK3FOVFY4ajFIUk9rV2cvbXdBaGQ4MmhW?=
 =?utf-8?B?SWtnb0hIMmtqbEZCZ0w1QVN4SVZZYldITGRUQXZLZlY3UmNudUFWNmFFVUd5?=
 =?utf-8?B?YkRPbFZRU3JIMlIySW9OZlBpWWJUbVVWYjMrSzRtZnlGRWlpQWt4dVl6bWtI?=
 =?utf-8?B?bnFyM3FvSHROeVRhMnUvN09Gdk1LZzc0OEhuTzN0UmpFM0dEYzdtMFVTcC9S?=
 =?utf-8?B?bWxON1hsUGpwYTdiSE5sdzV1aEVZVWhMcHhmMUZVREJhT1YycWUwUElwVlBP?=
 =?utf-8?B?WVR3LzllSmdYNFFxWDJBanVqdjJvV05LQ2V6ZEd3RDg5QzFRb0E4K2loQTh2?=
 =?utf-8?B?RGt5ZEs5SGpKOFNwSGQ0ajFHUXo2TXU2U0N1RUZ6NXRBQ0JpamJTa2YxUzFp?=
 =?utf-8?B?SWptMXJHRHprRDJKeExxOXU0eHQ4UGFKc29ES3JCVXovMmlBcFh1ZmdnK2py?=
 =?utf-8?B?TWRjRVl6ZGNFSmphZnJyRHFDL2FmU3NJMDU4ME9xL25IRmpFemZTSUU3aVF5?=
 =?utf-8?B?NDZaK1JyRlFOd2xtRis2bVE5MjhNaEZpL1lhT0JFY2ZwRkY4Mm43K2E2U29C?=
 =?utf-8?B?cmp0NzZHYTNYNVd5RmUyUlBQSStHQU1SaytVV1IvZFpYSGJqMUVncHJjb2F4?=
 =?utf-8?B?RU56Z0Rhb1V3VCtFa0gyTlRyUjVUTWJFZVFackx2MlJkRTA4RmMxVUNDQVhX?=
 =?utf-8?B?K1owcHNwZWFQVnBzSHJLdWdVYnJaaFBXQmd0VzJ1NUJLTDNNQ0VXdUgxN012?=
 =?utf-8?B?YlBrT2tVZSsreXNQUWxlU0g2Vzc5ckdDdXpBbXVUUTFiOWNSL2Fja01HZTZt?=
 =?utf-8?B?Z2l3VnhuMFdkc3BUb0E5YVc3aUI5dzZIVUo2QlNCL1VLVVJYajJMc0hrNDA1?=
 =?utf-8?B?UFFXMEwvWmlBcEZhdm9HK0piVTAyYlRXTDh5MTArQkIrM0pqTnVPN2Y4ZzlP?=
 =?utf-8?B?MjAvZmhDZGNQS0pMZW9mTUt3L1hCbGI5RzBEeTZRc3hqWHZvWmxxdkhyaTFG?=
 =?utf-8?B?aUIxZHZIM0tDZVJXbStwYitZenhoZzlZMk1RRmNMNkFEQlpHUC9MTFoxUU1u?=
 =?utf-8?B?Z0hreUFWeWkya3JzTzRlRzBEUzBVbEZ0LzVlOUlOYjlYOVZlMzJrYzY3Q0wz?=
 =?utf-8?B?UStOZUs0Q0w5Zk9wYWg3RHF6T09zU093L2pwanNTak91d002ZTNEdEVrVDRo?=
 =?utf-8?B?NlFsYTlwM2RvY3d3UTdlK1VFSUxWZC9HbkZyckFjMThLSG9KWmN3K1BBeFR4?=
 =?utf-8?B?MHVmbGtmMFRKUWxqOERsUUVjNlVXL1RNQXk0eXVNRFJMRU5VK1R3S3BxSm0w?=
 =?utf-8?B?dEI0MVcvNWxIYndoRG9ZM3ZnRnBWN2ExcDc0bU1DaERXU0c2V3lZbzNycDB0?=
 =?utf-8?B?K2FQODRqa0QvbHRzQUpxb01XbTBLUU9zd2I0MlZQa3pHUnpFSHMvY3ZuSWww?=
 =?utf-8?B?MkVaVGhlZ1BLRndMM21WS1RpaG9RRmxCUXI4Zzl5MnBBYk4xaGFUUnNFYzkz?=
 =?utf-8?B?a3RvRUhkdTdTamNVWnBjOWkyREgwTk1kK1FSbFhDcHN6OG5aajFxaVJ1Vmh5?=
 =?utf-8?B?RHJNbXNlRFdxTW9XZUlic1hWOHRleGkycmpjZXo5VjFxSjFqZ056ZEZtNm93?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ce0e60-5bcb-4732-b0c8-08dbb616a633
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:07:39.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymqRX6Of8lXX+EtAw8rNZCorywdL0oTn+gYWF3u1rvnQ0E4gSOKiDCFf86EL78koAlnWWU0n087EmrmLrPjPBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
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



On 9/15/2023 9:59 AM, Ilpo Järvinen wrote:
> On Wed, 13 Sep 2023, Jithu Joseph wrote:
> 
>> Add an additional check to validate IFS image metadata field
>> prior to loading the test image.
>>
>> If start_chunk is not a multiple of chunks_per_stride error out.
>>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>> ---
>>  drivers/platform/x86/intel/ifs/load.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
>> index 778a3b89a24d..88630366a23c 100644
>> --- a/drivers/platform/x86/intel/ifs/load.c
>> +++ b/drivers/platform/x86/intel/ifs/load.c
>> @@ -292,6 +292,13 @@ static int validate_ifs_metadata(struct device *dev)
>>  		return ret;
>>  	}
>>  
>> +	if (ifs_meta->chunks_per_stride &&
>> +	    (ifs_meta->starting_chunk % ifs_meta->chunks_per_stride)) {
> 
> While this is not incorrect, it would make the code easier to understand 
> if you add != 0.

Agree ... Will change

Jithu
