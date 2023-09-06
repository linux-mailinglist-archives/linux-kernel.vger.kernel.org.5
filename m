Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C77944BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbjIFUtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjIFUtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:49:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B131B9;
        Wed,  6 Sep 2023 13:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694033339; x=1725569339;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KHHqdxPJWpJSNubcwbzNj+57PZCZSHtWrB00HGUtOaQ=;
  b=MPmxAyx4oR0qqzaQCvJ0W98fFuHKPoY8r4c0SknqjCIAMJoJS75ooxmY
   LCWxLvfy1+mQeFMP6GF7wJYa9SPmD0VRMGh70JM5OATtZQn5xpr/8Rpyx
   ngYYZhlWo+hi7Goe9t/vGBQ3Yr9WDF1aMlcLbbRac5foQ7pVnBDNTKRtY
   iIeck7f8V4xLwdKAheCiE6RAO7Adcv2qNcqSrGMC000PAkSPFlL5akT6s
   1rE0fqWD51LLwTvgpTtzQgk/2SFim8KPsa7ZFpbWe5brQtK0Ve2Q21Pv6
   Q5Yqfi2TQBMlSfrMF2rl0ILJlU/VkNT+P1lPxhSgbsbN5PejKFYEhrlDD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357492641"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="357492641"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="770956947"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="770956947"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 13:42:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 13:42:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 13:42:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 13:42:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 13:42:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij4uCO3hWK2aq+4WI15ZLgI7CzY3clHPRglEGo162B2uQon8ntAYCTT7f6M0n9yZgpD5mplRXogbij4SljE6DYLvpDHQhMvd//SodwdrwQaZeqqZV+7BCdKq96tFiXScMFoOKwiGtNGsJH6N4P8zXI6Bx0AwE5lD4arZmHCdyO6WnUQ4AhwgNk5k5fREJQKEH/osxvC2vvdJVyNCLNLjPxPlS4gMUhiZfxYK4scO7zjz3L/aTdPM6yBjDNASzVy+n/vYU27CvOTK5krZ5dTcodFFcnbf0H/1FqoMRGpv7q42agr1FKBfwVL/PJsVSciWSYP59M+3CIQVtbnlc6/I2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewTVsMw6T1HM6wv9PRp+qMvFvntvmDKDySlb+bOFfM4=;
 b=S2+/JoK2WG/T2qdEtOfI1KCj0tiAd7i8tTDdFu+gYRnQt/nITGhDK13x4KCq7UE6vdgmHRwAB4DOe83Sn4k1mX/7Q2nbQLKnRVgK176POaL+cPtfksgR3x/XIOR2VFYZLxD3tz+BtaSB34DXJuD2L2Px2WpRNZvaCnR7Rg60g4OTbFHRZDqO/EDmbPzUDXhR5XVEeNQjxvWNPoBh6rJhgkfYhIcuNIT8SJ60TmkQOvLKl+0wEhBg18VOFmd5C1ofrfvJK3C/Phhbm4r+9ccWqJttEJ7sVig94lNnIFguppkveez1W0xgqld8hbuqbWumlKranb5PnxZQLBc740w94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BL3PR11MB6388.namprd11.prod.outlook.com (2603:10b6:208:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 20:42:42 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 20:42:42 +0000
Message-ID: <80cad07b-27e8-ab80-24f2-c6befa5db710@intel.com>
Date:   Wed, 6 Sep 2023 13:42:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 1/8] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-2-babu.moger@amd.com>
 <a59be218-350b-b88b-2b02-be9c1d2bf797@intel.com>
 <fda1fea1-5e39-8a54-ab97-78d182c54801@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <fda1fea1-5e39-8a54-ab97-78d182c54801@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:a03:333::17) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BL3PR11MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fa0e99-3e4d-4fe0-4079-08dbaf19d10d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTpQaENveNPixrwis2sJOeS3jizF1i/L4f1zmjHAT44WIpi/I9f9b45OkV5vKl2b4a+eI6x12Jag0+xYiSllipsWTIVjHI9LOq9Q+jOuVFpdLn1zBMjnwOrNDQyWvXmoSBaMSCXlWe8zdqvYEBowk4q4RK53b2MzIUqVF+W4lef8r1atBLjWF4PXSA/XhUnEjTGNMy/r1DeVSDTFWBTmh4cRmloTN7hrcBV1DqJdi+b1SxAWSoOKPishjP7zBHpHv2nKAqA1MHDilskUN6VYL0n4z7JkRdLnldYeEF4L9g4ph0jFcfOexQVlqcihA6gwVofFTYiLq1CV7L9cH/4SAoF1l/km2dfE6Rk3g4ThJtIaLZ8Td7AtoYJVyNEtnlhPrlKXn/mF02pqJA2587yBc2wOUTlBrHxOXNcKFhT0pRbPsEwDNJGeV8HFuoTFKnQY1pLk1oeU1eGVEl/7ZaociyqjA3nWP0XeNZJFy5AfqZpHAmpwCI2TeqjyQaqEJrEamzlED0ELe/MxepqJAHFYROa2wX6Qclmz/jKU+tSymvVPUipOwlnguGCHvFR97tyrWPDYiOMlxkuByxoSFpcRhf5oun7v83aU/Z+veM9UhRtPpbDSd+hJo6XdBFtH2rskV7E3lkemydF26W3bblXTpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(31696002)(86362001)(7416002)(966005)(7406005)(478600001)(66946007)(66476007)(66556008)(316002)(2906002)(36756003)(41300700001)(5660300002)(8676002)(8936002)(4326008)(6486002)(53546011)(6506007)(6512007)(26005)(31686004)(83380400001)(44832011)(2616005)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVgxNlRLRGVrd09RS0ZJQm9RNVdBM2RUaGhwN2V0RUZYRGdhSVEvRndCdGZh?=
 =?utf-8?B?RWVtcUo0Ry9JdVJRN3pES2FIQ3ZCd2xQU3Y0dSs0QXJqeS8wNElyaXIwMWdR?=
 =?utf-8?B?ejNBWlFUR0RLQkt1MVFwQUdHci8yZWgrcW5NUnJhbGF6OGpzelpLVFhFYTZE?=
 =?utf-8?B?bHY4YjhhVTlZUFVGR2xTc3ZnNlUwSW5BYkRjUVh0MFFHNVIzbHV6MktnanE2?=
 =?utf-8?B?aFdqTm5kejRsbU5vVTJzc2wzSVNMOHBDREFSWEZ1citJTzBoTzNiMStNb2pT?=
 =?utf-8?B?bkZ4RFVnWFlrcUJUQXJHN20zOXVoWUJsME9sVkdMNjNHbEpDK3RMWFczYmVQ?=
 =?utf-8?B?bFNqL0lndCtpcE10VWw2T3FGQWU3azJwc3E3eTk1bFEybXdPMERsWlcxMTJO?=
 =?utf-8?B?UU1oRFNSckpzanNyOEZlb0lOdFc3THc5Z24xMTM0VkIzUlBzTTdSSm5TQ0Jw?=
 =?utf-8?B?OTRTUW00VCt6dm0xZVpFNitDT3lMcVRvdWFHc3VJV0hPYVQrb3ZDZlZrZkxO?=
 =?utf-8?B?QjZHREFERURWQ2tkZFJzeVFQRVNyYmx1UnB4Uks3ZkZjKzhOTVZ5RjJrQlZL?=
 =?utf-8?B?SUVnejRpNy9EOUZjSW1Gc05mekZhY0NvMTFocDNwSlM3c1JOc1A4QjN0aDd1?=
 =?utf-8?B?TlNsL2plQjZKQUdhSm5FZmpKTTVrLzFpNDRWSDB2eWZJRG50V2ZXWXBuUkJQ?=
 =?utf-8?B?UWgvczdoa3NRc01Tc3FSOTZRUnFIRWZHMklpK2J5ZWl2eFlxVDB0QmtXVTBl?=
 =?utf-8?B?bW05T00wRVdxWlp5RnJGWTBOeWltWHE2NDVudTZ6UG9DL1VoQzBPTGF6V2JF?=
 =?utf-8?B?d2U4dUZuTG8veHJGcThWVE82dWRQbjFpWlZOZ0ZLK29pQWpHcVd4citrUmZv?=
 =?utf-8?B?b2hnZ2o0QVJXVmlKM3ZFZkFIbE8xU1hOT3VEamR6YWpsUGdLMVJvcGlaOGFp?=
 =?utf-8?B?WE1jZnN5bk5mc0FJZ1pvdHhCWHVGNVh3Qkt3QXJJVnE1ZFJkUmlWRkVjRlhj?=
 =?utf-8?B?cm5mS1p2NDVqc0FOZTl6UjFJYWdqUUVNY1BLNEdwSlBxTkVQanZybUk1R2FV?=
 =?utf-8?B?MXlhVjFUbWQxaVRJOVljMzNwblF6KzQzem5TWitkNEJTeEIyNHY0R1hORzVR?=
 =?utf-8?B?bUdacEgyZXQ1L1FNR2ZFUGh2ZFp4OHRHS2l0VnFJakNzZU51RW1RbTJEUWN1?=
 =?utf-8?B?dXIvYklENE9sM3daejFXTDhydFFINXZZZjE5Q1k1TnB3NEI1NXVybnl3QWJa?=
 =?utf-8?B?cmN5UzVacVdDMEsvRGJzWm5KWTNrd3NTS2JNeXM2NkJJOExrVnVjbnpmQzJt?=
 =?utf-8?B?UHYwSHhrN3hNUG1uZ1ptSmlaMUlQU2Vtc1dXWWMvT3hkU09TZmNVRTVmcDZR?=
 =?utf-8?B?Rmh4alJ1NVV5U0ZCNlJScWZWYm1rcklIRVlNejBhS3JyY3JqVXl2bE5xN0Vm?=
 =?utf-8?B?azc5M1hiTWYwNWNQME1Wenl2ckVzQitvbHBSZGFYWmF0bmRndlB1aGtodjNS?=
 =?utf-8?B?a0RFbXdndC9tVGRkSW5veUNocmc1Zkh5WWtYay9xU0hRcG0wS3lZZ1pVQVJO?=
 =?utf-8?B?QXNIcWsyZ255Ykw4MGJ3bkhBRFRhSGFoV3lveE40YTNnZXJLQmY3SmlZc09M?=
 =?utf-8?B?RjBoTW9YWndlbm5rUXc3RG9WOWkvSE1FNlREcGtyTmttK3JDTXBqWDQ4ZDU4?=
 =?utf-8?B?UWcxM1hSbFJTVHVTYUd1ZFh1TXY3bG1yL21TdXc4bU9SWVJjU1Z4M0VyWTRW?=
 =?utf-8?B?bGhGVWMvNHN6Sk9JNk1RQmpMeUN1WXNuTGowWG1LTXlYKzUyZUhVTVZnMS90?=
 =?utf-8?B?djdMalN2cHR0cUo4aUhobENXcmVnUjcvcnlIUGsrdUZ4RUxwZ25Na3JsR1Zs?=
 =?utf-8?B?b3VKdTJmenlObzcxaC9EQ2lTU2dFWkxwdmpQSUJwWkVvQVR2MTRoazl0bFR5?=
 =?utf-8?B?MVBoMzJVUFBOY1R3U3F5TVBRQ3FHZG1mYTFTSlQ0MllOMGRvTE5kUEVGVDZv?=
 =?utf-8?B?SHRxWitFL0RvejNPVkR5U3ZEZWllZEVFL3RQdE9mTi9XYzhuWWhHeFRmSXZa?=
 =?utf-8?B?d0NFWlMzMTFUMFhUTHJYS3FHZm1jNHpNenJCajBWbkVyOW4rY3l4U1lSUkpo?=
 =?utf-8?Q?Sa5l7xV3zFbRmGFexO0uyg2Bx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fa0e99-3e4d-4fe0-4079-08dbaf19d10d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 20:42:42.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKRWrjTDiemF7oMD6YDGQBYMsvpnVPGBK9c48jsNaHSacBsYuVZg1DIoLMh1aSdJQxY9O7IZsDzWdsiBp/qWMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6388
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

Hi, Babu,

On 9/6/23 07:56, Moger, Babu wrote:
>>> @@ -715,7 +714,27 @@ static ssize_t rdtgroup_tasks_write(struct 
>>> kernfs_open_file *of,
>>>           goto unlock;
>>>       }
>>>   -    ret = rdtgroup_move_task(pid, rdtgrp, of);
>>> +    while (buf && buf[0] != '\0' && buf[0] != '\n') {
>>> +        pid_str = strim(strsep(&buf, ","));
>>> +
>>> +        if (kstrtoint(pid_str, 0, &pid)) {
>>> +            rdt_last_cmd_puts("Task list parsing error\n");
>>
>> It would be better to show the failed pid string in the failure report:
>> +            rdt_last_cmd_puts("Task list parsing error pid %s\n", 
>> pid_str);
>>
>> So user will know which pid string causes the failure?
> 
> It was already discussed. Printing the characters during parsing error 
> may not be much useful.

Could you please let me know where printing "pid_str" is discussed?

My understanding is a similar thing is discussed in v3:
https://lore.kernel.org/all/167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu/

Then v4 has this code without printing pid_str. In v4, there is a 
similar discussion of printing pid, but not pid_str.

But I cannot find a discussion of why "pid_str" is not printed.

If kstritoint(pid_str, 0, &pid) fails, without printing pid_str, how can 
user know which pid string fails? e.g. user tries to move 100 pids and 
the 51st pid parsing fails. It's hard for user to know the 51st pid 
fails without showing pid_str in the error info and then it's hard for 
the user to decide to re-do moving or aborting moving etc.

Thanks.

-Fenghua
then

