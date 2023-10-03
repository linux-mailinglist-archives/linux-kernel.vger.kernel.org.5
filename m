Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EC67B6AF2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjJCN4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjJCN4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:56:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B532A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696341409; x=1727877409;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N9TsAGjBtJE7cCoYaKS9uLsr8E/7jL1XNBI84wBtwK8=;
  b=bTowgfT9XhrIEXUrwhOzlFM9HAVCjMK7N/T2nrzxlMxvB8kwuITzsnQO
   EwwVBkl0suJV3gJn0JUw07JP0cQ7R+WkKNKcxKHAgXoLu/mR2oWnqtBMM
   q2erzdDd4tbIutdkhpF5SEuRvYvIws5iqbQvMZ2iLudrd6NRojO30TfQm
   PuR5G5RkNrt8xkIhE5dSWPGAwIFxJlwLNz+m1a3ACV9Gg1EbTWKgpYW7i
   w4vruuntm5lcwIrq/JTqZNf283Ctuvjuqb9i6/H/GsHaZmnZEn2/4zVdp
   2Xt5HDn09cnMkJA9HDHcoSQ1IYcUNOwYK9jWVBsRZn7KLpJps0cMTD9uu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="469154454"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="469154454"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 06:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="924656379"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="924656379"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 06:56:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 06:56:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 06:56:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 06:56:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 06:56:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFzsSZkyoxI/kpM8dccA8WoJtB/+2gBSgNlfY2lO8cnXG0Iu8bDSOGpV6YTQNUWqqGJWo3PzxcOa/zwxLsMftf8tdVwX/cTUw7KCYQaxEtJFezTzLlJq/9A8KzWjqNwxmdDY2mrl5MEacJOrGZxnmZddCGNNswFjxMxgSksWu2wEnSEp7nhIJO9h2AQSrW3EWxgr2lXjNgIhChk7tzSa1RikDOdlTcSMxq6KInPCnrP1olz7C/96E0EifuS667ICTMtVBeI1aPhwe52bPA8mU9FRgz1U2Uexofe7o6JRXBbTq9jfRApw8uOvvyHkithwjm+PVVVNwgJ2OARlmE4zHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c119Ipri7lKMvIkc+xqWj8WWJy44QVNeVvj86wdRBgw=;
 b=EqS7o3RZDUsVJTqo7qqfyoshkWTvozqz6KUrWJ/abX1LQ0Yko0CdZvK7lOt8cSm78GB6cB2DwdzmAPoA07lPx13TYK5ORzzEAnlj5WbmvLiTkNB/sDBxOM0t3sdywhd2NbS9iUdMWYaSl/5q3XIif6qf5RYrCs+oJzQDiCW2/2V9zeFy3MCbjzIdL/O8o+hjvF0bcAEGSjMRcYtztHHOHke09Kx7YxNHtwsC/WGfp5swtdyyR94+pqdzhjoekwQpKA3PpAVkCIqRisX7fZi1efgLGyYvBbMuztpW6UDOjMaS5Jyb42gvQZPJ/2/PlKvmJIH8cjpy1ymTJOCfWHQ64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 13:56:44 +0000
Received: from BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::8fdf:3169:b475:cd83]) by BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::8fdf:3169:b475:cd83%6]) with mapi id 15.20.6838.027; Tue, 3 Oct 2023
 13:56:44 +0000
Date:   Tue, 3 Oct 2023 21:56:31 +0800
From:   Yi Sun <yi.sun@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     <kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>, <yi.sun@linux.intel.com>,
        Dongcheng Yan <dongcheng.yan@intel.com>
Subject: Re: [PATCH v3] x86/tdx: Dump TDX version During the TD Bootup
Message-ID: <ZRwdj9mZz+Qt5FPP@ysun46-mobl.ccr.corp.intel.com>
References: <20230930161110.3251107-1-yi.sun@intel.com>
 <483ee0eb-cc14-44a4-9c3b-77a6d0860359@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <483ee0eb-cc14-44a4-9c3b-77a6d0860359@linux.intel.com>
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To BYAPR11MB3094.namprd11.prod.outlook.com
 (2603:10b6:a03:87::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3094:EE_|CY8PR11MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c510a1-3785-40a6-812c-08dbc4189389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSA7kM+aVZV44EMt8IAH6sYjCw/CF5rLbMRDWY/7Feza9Li9lq5SPuNIWvZeXm9KHp7XEx1JKeQ4vhLF5eocXJkNo7SgHi9xk6bZvMZyAMqlMJIBQQnC7nVKXYD67JysLeGvc49pnyPR/W/r+9LUPVDtN4A6yBzyUQsnhr+a5lvC+T/FsrAA7YTb5rZ0heItMx9EhS6o32pT0QFQf7z5m355P7AYxrRseKqHNW+mZC/1WrE2jxE2StFwJsWzZtpE9KDDTg/i95hzpCZkRRTaQZp1HTV7JGqOdk4qHpHfOEyt72rj/VpH1alO7iJ/uSoSzfpF5pA5PWau4EogHEOYO+2WuWXx/B0IDwAbul0bKeIOKL3Rd5lw1INwMfY8qaZFdh38DwvZVstMwqV0rkaYVrJTs9TDi0CH3sOwM3UHkz1TebuqyCncIL6L38BCYjUB6GdIUjmnYRVtmvdi5xsDtHY8ah29w+9F4t06ak0gxrZiRFsfhW0r4jCreCZy1YjwLzZFKeUdvjSqTotXxGeob8M8mOxa3aNw9Ttr8K4xAc6+kIAwVaXf1I8MVi5hPJjVWRonpM9VL9SkW5EQzZ5JNhLSe/QPHIy0vb5SyCnddC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3094.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(53546011)(6506007)(6666004)(478600001)(6486002)(83380400001)(26005)(66556008)(41300700001)(8676002)(316002)(5660300002)(8936002)(44832011)(4326008)(66476007)(66946007)(2906002)(6916009)(86362001)(38100700002)(82960400001)(6512007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTlPeVZuUWZkWU51YXAyYUdpTTQxMnRVVUFjb3JKNURHakg1UlNKTVhncmVh?=
 =?utf-8?B?dGRleXFlVUNDc3owa0hLRnk5LzFhMlo1TitkSVM0Z3RNakxveWE2dFdPeUhZ?=
 =?utf-8?B?SlB2MGZRUHRySkRkNXFpMm9JZUVCdmNnV1VXQ3QxaTdWbnV3ZTdFT2dtcWRI?=
 =?utf-8?B?WXNHVi9od0tVS3RzTWprWW96VkphUUJTNzJOa05QUnpXeTZyOWNZcGRjSUlI?=
 =?utf-8?B?a29LL004dVRKdFg3bE9DV3lFZ0RVUnFPWVlweVlYaENrbjEwY1V1dkpkTGVL?=
 =?utf-8?B?SGRialBsMXJtVTBWNlFrN1g4NXA5UVFqYVEvUE4xbVV4MkgzeXlCb3R1VXl1?=
 =?utf-8?B?OFJ4cGZWNEhVNFRIUXk0amo1V01QRHpHam93SHVKcVpUb3hkbHFUTmtLUnda?=
 =?utf-8?B?TDVKbHR3N0c4ZUk5V010Z29WZ09sc0FzTVNRWEFYTmhqZnZ1SFFQVTVXTUVF?=
 =?utf-8?B?RDhCdGgwQVhyT3lXbWpYeTRKcDFVNCtuSGpaWFdBY25ndmZQVTlwOE5EWEdQ?=
 =?utf-8?B?Z1JMSVZPY3Z3US9oMmVqLzZDeGRMTFFrMnhUZWdkM0JrQWlwNmdxUkdraVV6?=
 =?utf-8?B?OWVFZG91M0VGVGNPdXh3MGtQdFN5U0NHWkNCbWYyWkRDa0FYejhaZFlPeUJq?=
 =?utf-8?B?c3B0SGcrMDdVSEc0WFlnVWJJSE95SEdGckdpdlNzb3JYaFpwYm1ibDc2RFNZ?=
 =?utf-8?B?ZnoxKzlqODd4Rk1ONmFZRmRaVDJZV2VLVG51V2F2UHBtRTh1MktkN2ZSMlgv?=
 =?utf-8?B?MDBsY0pNUDFKdHR3d2I5dTR2ckt3NFAydlBlYzVEUUEyYTBSSFZYOVNhekVx?=
 =?utf-8?B?ZlpBS09LVjlQYm4rSmNmcDRaREZ1MWRIaFBENlZuNU5kK3BtcnZSRmo3WDRx?=
 =?utf-8?B?Y3NXOE5hZmJPTDhsWmowZTM5UHVtN040TEYyOWxrcXNNTThyUnNjUXFNNUZ2?=
 =?utf-8?B?K1BrelZsMk9TU3kzNWZSYkgzalViWHdpa0lWcDVvVGhBdmZKM1h3Y3pUakZX?=
 =?utf-8?B?bjlZejBUMVpGRUdJTG5Ndzh0OU1ONzBIeVlOU3dGRGNJeUxMMU5rbFB3enJn?=
 =?utf-8?B?cC9SVlg5WExkeXZ6S3VPZ3FoMHFlQU5Gb09hWWxuV1lGalZLZG5sT2NwakRh?=
 =?utf-8?B?NGpQSkFhTGhpd0JSeUJxblFsOFBLeFlGRVJveDdwN1ZjTk1nRVN0Ym1pc3BQ?=
 =?utf-8?B?d3NpQ3V2eG5vNHc0S3RHcnBMUFE2RXAveG5hY1A1UUVvVlRSY0ZRNEhvYTVN?=
 =?utf-8?B?SFRMaXFBTnQxUTRKVUdrNVpxdGt2bkU2NmhmQUh4bmE3b1RGN3hIRXlIVTVx?=
 =?utf-8?B?Rjk3NmIybFBCc0hCTUhkckFUbkM2K01vU2huMkFScE5oN09PSXhFbE0yUHRS?=
 =?utf-8?B?NGlFdld2NW0zTWE2b2N1YWlmeXdOZkNrNmMvYmRDKzNWdmxnQWJBSXpjb0wv?=
 =?utf-8?B?a21rSUYwaWYvWHArUnNJTTZjRnpGd1UzU3g3WnVCU1Mza2w0RmNzQXB5Vkdu?=
 =?utf-8?B?YkNGU09sVFhVTXBNTzZYa0lMNldpV0trU2Q4bWF3bktyaFp4K25uM0dXRXJE?=
 =?utf-8?B?UW00MTNKZFhEZE5LSmhxa1ZtdHY1RGZPampPRHZ1TG45QzdFVmxuTjJDQnhF?=
 =?utf-8?B?L3VvR2I4TkFid2IwbUluZzVoNkMwbjduamorV1FveFVkam9WQWF5YXdoUDEw?=
 =?utf-8?B?a0QyUFZadGJTT29kaFFQWjlFeEV2WnhSSUptdWo3WWoyYWJuYmRuTGgxYUQ3?=
 =?utf-8?B?M3ZqdWVJa2pjVmJEOFA5ZWoyOCt6MFBYWVA2OUdTaC9sSUM0MUF0QW1Lb204?=
 =?utf-8?B?OWhsKysrNVhJOHY1ZFBNYnBlb0ZzR0llMDd0Nm91eUp2eWlzYUFPWEFFa1dK?=
 =?utf-8?B?OWE3V0tJN0hLQTJKQkdsMEg1WUEzWHp0QndoUVU4QmFqbVp4alBwU3owcjJy?=
 =?utf-8?B?T3F0cXYxL3JvZDhjRlNRanNueTNsQXdEN0p6UjJkWERkTUw5UUtCQkt2d0xS?=
 =?utf-8?B?bk9oQUYvVU1JMFcyRUJsai9JNG44dkRFd2l5WEJ4eEozcHRMb0hkRUVnL0ps?=
 =?utf-8?B?TGlyYmZ5b1N0d1dlcVI2ZmZydjVoUmdrWVBySXVkYzNoNUlmdU9uU3pyKzA0?=
 =?utf-8?Q?IlCAtTNPOCg/sdayZfNlymi5Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c510a1-3785-40a6-812c-08dbc4189389
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3094.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 13:56:43.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT4BFbkjWw+8ZOlHb3uIL5uFuau3lguLVyIpVha9FNdTS3u62bftIsjclawmgNgvyMvNQXeLFPLgjXZUny1eYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.10.2023 06:26, Kuppuswamy Sathyanarayanan wrote:
>
>
>On 9/30/2023 9:11 AM, Yi Sun wrote:
>> +static int tdg_get_sysinfo(struct tdg_sys_info *td_sys)
>> +{
>> +	struct tdx_module_output out;
>> +	u64 ret;
>> +
>> +	if (!td_sys)
>> +		return -EINVAL;
>> +
>> +	ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_VENDOR_ID_FID, 0, 0,
>> +				&out);
>> +	if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
>> +		goto version_1_0;
>> +	else if (ret)
>> +		return ret;
>
>For this failure case, do you want to reset tdg_sys_info to some value like zero
>or some constants to specify unknown?
Yes, that would be better for this case.

>> +
>> +	td_sys->vendor_id = (u32)out.r8;
>> +
>> +	ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_MAJOR_FID, 0, 0, &out);
>> +	if (ret)
>> +		return ret;
>> +
>> +	td_sys->major_version = (u16)out.r8;
>> +
>> +	ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_MINOR_FID, 0, 0, &out);
>> +	if (ret)
>> +		return ret;
>> +
>> +	td_sys->minor_version = (u16)out.r8;
>> +
>> +	return 0;
>> +
>> +	/* TDX 1.0 does not have the TDCALL TDG.SYS.RD */
>> +version_1_0:
>> +	td_sys->vendor_id = TDX_VENDOR_INTEL;
>> +	td_sys->major_version = 1;
>> +	td_sys->minor_version = 0;
>> +
>> +	return 0;
>> +}
>> +
>>  void __init tdx_early_init(void)
>>  {
>>  	u64 cc_mask;
>>  	u32 eax, sig[3];
>> +	struct tdg_sys_info td_sys_info;
>>
>>  	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
>>
>> @@ -820,5 +882,9 @@ void __init tdx_early_init(void)
>>  	 */
>>  	x86_cpuinit.parallel_bringup = false;
>>
>> -	pr_info("Guest detected\n");
>> +	tdg_get_sysinfo(&td_sys_info);
>
>Why not check the return value before dumping the info?
>
I overlooked that. I will add it in the next version.
Thanks Sathya for your comments.

Thanks
      --Yi Sun
