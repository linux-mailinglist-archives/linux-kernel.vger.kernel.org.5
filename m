Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5117C555E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346813AbjJKN03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjJKN01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:26:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01469B0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697030785; x=1728566785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rcBleJ58OWcdYLHT1lATLhPFfdagacvSel+Ah7FnFMc=;
  b=M4hq6HwtgIiOrwOq7LCIerFtC9J0gGX5CDWSTL9xdnyxq4roQHxkXR7C
   PchAR1dJ1u4ArivgyHJa6rbTJsYnC/mD1YYB/NduIf8btUtk7/viqMsAA
   i7N8Q8MZ9Hbh6ZB63oG98PlA59UHGDd7+CCMS5ScWB6rVFxOEEI78ubHx
   bc/ATgpYghQzxUtymLHOTR5ZI8Ix2gEYF08q91JbmcZCiS1+ZxqGuY1+2
   sEItu8UiHxAQjPcNUnGcj56b8KH1MrZyp9GO0Jj7N0jq8AMBeGztvse+P
   gH+8OtllUv7jr9uTWyauAAoSrPCjg+HCy+lBmboGyPiFC0T1/TjKU3v9h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3249735"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="3249735"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:26:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="897624030"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="897624030"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 06:24:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 06:26:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 06:26:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 06:26:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 06:26:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZwpiAfzm50+wrHwTD21nuk/qNA9At39RSlICkrHpa/b11+ofx8q55KLLusCCCW7Qd63E2jJmu30wWNQurtfHuMEzwT8gp66GMcBZzfDChV8p9Rfk5ddYqI8GEpoOOGtRoSZTosChJ9FMMlals/zHHTdj1WO1jLN286AB+D1EGQIMik3K616nkBpK6LgoGZUvRI6l5NUda+wn/xErSITJ3qdhLvQQeQlurQSIUzFn0dR76p0GuZFXL7VuueejIE5pN5ZK5+1U4srkpoba1NoZjLFo4XoCy/fzkZnxI6nNp3YjS2fuMvvPOJTs8K5TCKjU0oLfMaem3wYmC1PUdX+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTgMR/dlxOAoW71/WNmzCHTeU2/SDEdK3kz3ObeaJns=;
 b=CFUFq9Qsz4rveI2W7OrBKh6NSOwlzxconpcZpVHiEZFt2G6pQ2YZGEoJf8+LaktuAXH938s/wNGTodq6VkvZqfIXVFDu3DT4Aey9xMhNGtnEdkubxfKdN87Y2Mwwpza4cykrMYNLSxNdDjJVf1jkjKbveIM0XmLpALlCkN8wQskhbaCTC9sehIh8uK/MxrHUKGkke8KDkw86WCxAUYyzYBgGON4D2pb4IvBRHvesflgZdF1weUIPRUTskD+mL+4zR4nnCc0m9gs6PgWeBRmcyEGQybgggT4+XVOdbgyA6QQKs0cGWA2SRo+v4aT6/NKJ0WRrzKHqIPrTNjBHrMU5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SJ2PR11MB8568.namprd11.prod.outlook.com (2603:10b6:a03:56c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Wed, 11 Oct
 2023 13:26:20 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 13:26:19 +0000
Message-ID: <ba9ed927-0672-4252-9cfd-c43febf68d49@intel.com>
Date:   Wed, 11 Oct 2023 21:26:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 PATCH 4/5] iommu: Support mm PASID 1:n with sva domains
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>
CC:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
References: <20231011065132.102676-1-tina.zhang@intel.com>
 <20231011065132.102676-5-tina.zhang@intel.com>
 <20231011123910.GD55194@ziepe.ca>
Content-Language: en-US
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <20231011123910.GD55194@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|SJ2PR11MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 3116fd58-05fc-4f8d-d74f-08dbca5da72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u34tVPGjVwPksIbHjNFroDRTSfJJPrKo/FckxIKE5u1RtwOcV42SIcnYXNAxvqYXEVw5iLVlaA55zFmgpMmdXOVzXy2FuCyNK5EAKOCmP9mROnYE6oWAghisFfdVS9mVH8x0MWjzv60kNbD/16Mg0TxAHpUUgvEZC5bjxnBUEuUeoLTlwCE7dfXMnScJ9WAqUvtm94Av70eMudz8kr6Vzk+JXuVmYFaJ7DEJwTO5wldW39DuaMTBehZ/nzLHRD/T5ZEzKlrjB6iB7c19Cseqbq53vXfTXLvJTZXz9zJYZNR5t0YbKhEjjMX7qWIT9k0timCZFN/69RdFXWNlcduUIazZ8AZI5FbUI+SYuslfMnhrs3nxHHZxk71RF6U6HlVDQacH9X+AkdAqJTfkMcumWER2RTOblBYX6t/6NHCiuXB/FqwqCgWkK+dxFDtBGh0dFpX9fy9DZYYa0dxcjo2pwoESDlWkxHbsKd5RaLteqHqisBFNrbEfUL6GIMef/ONlQgUnag/mHjSsp8bi7ynmemFPj2JUtJRv/Bstv/LosG2v75lVqR39IZYn17gfK6eChKVQS3VmSxchnNZ+mHmbraxA4vn6Uj+4kGqthstmydm0FFV8dHhmCHWx7hgP0vI2rBxS+NOb1OQnE0NovqxNBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(41300700001)(478600001)(53546011)(6512007)(6666004)(2616005)(6486002)(31686004)(316002)(66556008)(66476007)(6506007)(110136005)(66946007)(54906003)(8676002)(8936002)(4326008)(5660300002)(44832011)(2906002)(36756003)(82960400001)(31696002)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzUwQWRZZG81dXFEQzBKUG03TXREb2ZyZEF3VkFRV25hMFgyZ3YwMzFBUkhk?=
 =?utf-8?B?bG5XRWlaWEhBUHJIb0owV0QycUxpWGhQdnVwU053dGpyRnBwcHBsZDhTS3pP?=
 =?utf-8?B?cDNDK2Fkdno4T01sNm5LYkJvL2xJWnViZUFkWStoUENXZnJhcU0zamxVck1p?=
 =?utf-8?B?dVlSZHlBYnN0bE90eVZ4aXVmSXlpZjVES1laRlAyU0hlUE5lNjVPV3dIcDhE?=
 =?utf-8?B?R0loa0hUaWczM1FHK1k4SjFnYTM3Ykw1bUxnYXJWSExzb1Jta2FNTnhvNUll?=
 =?utf-8?B?b096eG41TmNybHRiRlVPaGdETVZTc3pIcVBXbkRoaUpYaUpmYjc5dFJYQ0xQ?=
 =?utf-8?B?L215dkpjR25SbDVJMXh6dTZLbDBTYzYyV2RUa0V1WTlaOTQ1Ky9oVGlEa1JD?=
 =?utf-8?B?d0tBWmlna0s2akFVcTl4UGl3VlN6TUJRaFRoQTNCMG43R3NlR05EK0I2T2dJ?=
 =?utf-8?B?M0hCVFlGK3BhSkdsNjdDR2xLWjBZbk0rRTRjTmFDSVY1TU5ISXdPaWtlWmk0?=
 =?utf-8?B?c2tTNXdmSHpUdkZpaHV4RnBjQXd6Rm5zd1JWWGFGSzFQNWMwdjBvS2pQRXVS?=
 =?utf-8?B?NlRyQk13azlaclpBNDU1Ym9iWkdFdkJPK0pJbkdpZmZBMGJyaTloZk8yK3B6?=
 =?utf-8?B?MmRZYlE4Mk0yaXlWVnJHNjFqbC9nOEtRQlR6UXo1dTVuRlFOVW5sSVl1NFIy?=
 =?utf-8?B?cTQwNUlwK3BqYlBSU202R0ZWWk5zNWczYjRhcDdWeHIvOHowak9IaVBLekl2?=
 =?utf-8?B?bklCUkJYeHFVa25HNVVMTld3S21waFVrRnozeU5XakVLYXZGTHRFa0ZnOVZv?=
 =?utf-8?B?SWRCSUd5WkwzOXB3Y0tHY2NFcklXdWlhdEhMSkpkbW95U3IwOVNTblJvL2pC?=
 =?utf-8?B?cC9Od0FSeitPSU9TQ2xtLzFuUFkzclY2elR1cU1NNHBzRUJSYlhoUlFKOTRj?=
 =?utf-8?B?d1ZidzdWZkdnZjBYYlAzSnNqVmZ3a1JrUmErZWc5dTIyV2N2YTVXYjRsbEpU?=
 =?utf-8?B?a1hpK3JjemU4cnFudlVHeXRCeXQ5Y3YxZGM1VStSc3ZYSzdCaWt2UzU4TzV0?=
 =?utf-8?B?WkVkTzQ5dmt2alIrMU1qUU1JS21uQVJjd3JsUXFKb0RCWS9rUnFtbWJyRWlt?=
 =?utf-8?B?Z0JrZHhuRCtPdGlBTXZreEdYWjk4Z0xacC9TdzZYUTcwVVJaK0s1UTVUVG1F?=
 =?utf-8?B?K0t4VXZ5bmxGZ244SUlITi9iVDd6M0JmYWFoVTFOZUNOdWFySkFoN0FudWtj?=
 =?utf-8?B?ZVZNWi9ydUZSTTF4ckVWVmt6QzlQZUJwWDNab2VpWFdPdHUxeUFKdHdWV2N2?=
 =?utf-8?B?dnJRUXh2UnBjelk2V0tXcEVJVkZURnBna1o2TXhxcWpqSTJGbW1XanRkYzVC?=
 =?utf-8?B?N0ZXU3pmSFQzN3lmU3JYZkRvOGc0UzcrcmNUZ1hZbnNSYXR2alFEdzBLbjNt?=
 =?utf-8?B?MS9iYVpXNHI4MVd3Qkx2OTIvRGpMZDZRTStFYW05aXBjNVJVUzBJQlF0UDBC?=
 =?utf-8?B?dDdZbDd5WjA3Y0gvNURqQjBWOEI2Tjh6eEZ1NXJqdWNNWUp0QVJja2kxUnpM?=
 =?utf-8?B?bHRRM2o0RWV1U282WnNzZ2pZRkhCMG9jWmp1SEJvL3dDY1NzUm1EYTdmNEFs?=
 =?utf-8?B?a2tOZnFqbWw2YVdDWlhjOWE1QnVDY3hhNVdxeUNJdFpzaHZtTkVrYjlEaUQ0?=
 =?utf-8?B?dTJVOXJCYTQxV2JaT3dRRFBRVzBuM1V2QUFaRmcyZkh3MlZma29GKzZMQmZo?=
 =?utf-8?B?SjcwRWhiWmttblVmRUNaMkYwT1FMbDBPVHhEQjU5RmxnZUJpendaRHZISWpS?=
 =?utf-8?B?UWNLcm4xNlNINVhSdnVDKzlzMHFBN2gwa1VKK25WOHA3eExwYjA0T1grSWVz?=
 =?utf-8?B?eFRPTFdMWlFqUEN0WGlmcUVERkZubU42OTdPSkY0a05MQ0ZrRjgxejdhZGFT?=
 =?utf-8?B?ZmhtdzM3MHN1SFJBRDJiY0pYRWU3akFSVkZVS0JGYlQzYnVkQXk0U3FOTnA4?=
 =?utf-8?B?Ym9FWTZRdWtCdk1MMW84SXh3ZDhzNzlKL3dTdmFtQkxabEtuNHZ3OVZnaWdR?=
 =?utf-8?B?RzFUdW9VWVU3N0xIa1g4bFU5NjBxamhZM2tyQlBkeStUbHZydlhYVjUzSTlD?=
 =?utf-8?Q?aw6a8gcs1aFFkI16ClEvX2c3t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3116fd58-05fc-4f8d-d74f-08dbca5da72c
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:26:19.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVDlH/ZY75prhYci5E6fHBy8a/YRNgaK8GZQbTHwD3lNO+WJhu3oCkbMlr6kWDVn1FLEeWkCvdG+F+uXMjh7Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8568
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



On 10/11/23 20:39, Jason Gunthorpe wrote:
> On Wed, Oct 11, 2023 at 02:51:31PM +0800, Tina Zhang wrote:
> 
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 3b6d20dfb9a8..985403a7a747 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -1277,7 +1277,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>>   	mm_init_cpumask(mm);
>>   	mm_init_aio(mm);
>>   	mm_init_owner(mm, p);
>> -	mm_pasid_init(mm);
>>   	RCU_INIT_POINTER(mm->exe_file, NULL);
>>   	mmu_notifier_subscriptions_init(mm);
>>   	init_tlb_flush_pending(mm);
> 
> Nicolin debugged his crash report last night and sent me the details.
> 
> This hunk is the cause of the bug that Nicolin reported.
> 
> The dup_mm() flow does:
> 
> static struct mm_struct *dup_mm(struct task_struct *tsk,
> 				struct mm_struct *oldmm)
> {
> 	struct mm_struct *mm;
> 	int err;
> 
> 	mm = allocate_mm();
> 	if (!mm)
> 		goto fail_nomem;
> 
> 	memcpy(mm, oldmm, sizeof(*mm));
> 
> 	if (!mm_init(mm, tsk, mm->user_ns))
> 		goto fail_nomem;
> 
> It is essential that mm_pasid_init() zero the new pointer otherwise,
> due to the memcpy, after a fork two mm structs will point to the same
> thing and one will UAF/doube free.
Good catch.

Thanks,
-Tina
> 
> Keep mm_pasid_init() and add zeroing the new pointer to it.
> 
> Jason
