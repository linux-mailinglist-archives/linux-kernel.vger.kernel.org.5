Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09D178E690
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjHaGdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjHaGdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:33:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD3DA4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+tEZ8AA6uDEYu7y+Ant9arnfG06SEuG5wBCEjm2BOnXq40pVfrTe0PK6j2H7lQU4rfvZnX49wzvci6eUE9DWBtNQfF6VLIUw4N5CyywXnrUbglgsbt1TzSRzwxiYc7j6EQtxdwdxvjHQYsAfSa34K1/uR1z6cZv+20wuXXssqS9FBwf35B8bGubqkdwXDbHZ0PiS9sfX2bTf5Pf0YsyrmhJ6Vn8GSsUof5WoJKVipqbPaIMTsWEailH6rF8I3KXzkDxiBpfU3FlgdGHseX+TT+OEECFw5jgbIJWkg796WNEo+RvxXB7SVgl38E2IDm5AokXC3zSXxulSjVnlVBpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS2xQQnETMuATWC6gh6AUjimibaHirF4zL4Iffg9Bgg=;
 b=cQUHGkjSbr4G7V00Yr/Igqv35f7ga/NGLB6yaKLZ2AqEZkvjjbQbhWOPP/8xPQbTQaqkS503sKOBR0mZElCNAkFa8Q2wbWIHXVJa7cXPytikaUhBF9kYp20gtpzEcwuXgkDZMC14WSudPNHJzZGnaK0GmOP3oOQI81w35sU0yswEczHyElvvtSid3FRVOtrdy0J1+JGilHJ9AJPWV66adARkIf3jtiBnr8Uknd9LTyeoXxwEE4DtMayJeIrJlU2mKtaHnckItzEWhpxlSsJ4A5HeEM1QWYaM5Ck9XN6/VfYO5wa0UCypQ15Zxhxg+IYYlAWcCLuBpY55vbaOOfZ2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS2xQQnETMuATWC6gh6AUjimibaHirF4zL4Iffg9Bgg=;
 b=G1pUsOEcTFWsavzyynrjEJUBcSI+1teaO3COo9xPkV2W4LyheoUP6gdUJ7ZVN8C9fJKr+aK9xuAUzZJ2j35VilDG8usyeH3PQjAZ6oQkYv8YvgGbwcoKGOU2FsTeKabvYU5Ad2IZVVp06QXpFm5yxrZUuLNVlOPtMAllsmzQY0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.21; Thu, 31 Aug 2023 06:32:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 06:32:58 +0000
Message-ID: <63942acf-1b93-af19-4345-1d859ce5bbed@amd.com>
Date:   Thu, 31 Aug 2023 12:02:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
Content-Language: en-US
To:     "Zhang, Tina" <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-5-tina.zhang@intel.com>
 <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com>
 <MW5PR11MB58811372039BED21EF588C1B89E0A@MW5PR11MB5881.namprd11.prod.outlook.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <MW5PR11MB58811372039BED21EF588C1B89E0A@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::28) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff6c494-6caf-4041-fda1-08dba9ec1de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCd5FHY7CXExV53/T+na3tGLByVfjHHdeQ9jN0fxar8YNoXxJHY+ZaJlfyx7DSuU8L6SZybikKOWsyfu290N4EfknSvQXuNdwKZWxdhrIzCRfzdEBGq1ArqdtHjP44MsBiZmdGR3GShW0LQY/GBb2AOv4t3b7Z22gZ9YBHEDJVtKtAK0IDKauYV7UcTukyIamY0msf0HywcdQg1DKximLtqi2t/kFkt0Qrt/r4FYAJ0MWvxXW/1cvNUGU6o14HAI/A0I99hoO9c00wk0ce2YhlQURF1+DK2TEGGabjjPLLe5vVmBAR2RGFZ08EgFT6J6h3FbR9SL7FqA7w7rDcH/8crH5NMtXT/2a8zTYX2iMF21ZIYgq9NBWwQo+x5ZFMjmDE/AvMv8ePbyNOjj/w7YwbT8uxkftVkGUhUMou2hhSsl75eF6Yk1+pvh3rvUVoBqc3nF2/s1V2/R+iKKIxWzdo3S1daCPCDlpBNGDpQrv44SOu0T2koPz7j2a2aC3UtNOtwGtn5AvetZHRVZlKhW2u1WEsKV8FCo8RsylUWuy1HN+F8cb5pV65KACMa4Pa7gfPhs2k9Ly3WHbw9CZAappqEjfvnypify4t6SkINkc2Nr+Oc2AX97guL5hVNoaiiY4QWU6jbFCoVyQuOb1DViMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(1800799009)(451199024)(186009)(31686004)(6506007)(6512007)(6486002)(6666004)(36756003)(86362001)(38100700002)(31696002)(2616005)(2906002)(26005)(53546011)(83380400001)(478600001)(110136005)(66946007)(41300700001)(4326008)(8936002)(5660300002)(8676002)(54906003)(66556008)(66476007)(316002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXIzTHU1YXIwV01jU2dzNHBtempKbXhVM1lJbmRRQkpjWnJxY3Z5MU9CcnY4?=
 =?utf-8?B?cjF6R0hBUit5QlhickNlYUJNTXJpSzh0U09NL2hwQVFVNG5rVzVOQ3NmNlNN?=
 =?utf-8?B?UHZ0Q0Q3WE1ESk9rU1JINVRxRnBlZ1RUR0ZlejFPQVBRdVBCRXpieVU3eDVK?=
 =?utf-8?B?d3A3dE4yM3VNdkVyQllxQy83Q0huVWRHWlJzb2d0TXZBbjFSL2NYcGV1Sk9t?=
 =?utf-8?B?cUlwcmlUd2hyeDN2ZWt0QkdGK2VmVlQrZ0htakg0cjFUUDVzOTJ4bjlvTmM2?=
 =?utf-8?B?U1JPdUY5SUFISmlBbUlNei9XelIwMzQvNXVLZEZReGlFdG5aQmJ4SEJsQ1ZH?=
 =?utf-8?B?RGRIa0VYdWdUSGpEdGtEUjd0UkpaM3Y2YWVXZjJiOVRIaWQ1VlBmdDV0ZEo3?=
 =?utf-8?B?ZE1mRnIyRDhoSnlmRDJiQ0txRXZ5VVdXemlEMS83RVpNT29LL0JHVUM2alNs?=
 =?utf-8?B?VE5YWmdaUjNocnpJNmIvOHlJM1B6a0hQWEVPWDRmd1F2cmppcmI2bUtwd25G?=
 =?utf-8?B?UjNKaFVqMVlLNDJDMGxaTlJKTlFiUjFDM2J1WDBveE5zclpqZ00ycnBYU1pS?=
 =?utf-8?B?VjRzTGlqanNvZVk2dEtTcmdLYTJ2YTNrUEZmbk1zQnpIVmR4OE13Ym9zR2VH?=
 =?utf-8?B?R3ZkbDhoRmNlMTlWeWtCNW12ckRWb2ZCNmsrcDlZT3FCRk5XQXNtcFdxL2hH?=
 =?utf-8?B?ZWc5SmFRNEdzWjQwQ1hWRVpJM1J2NXNGYTd4VjdrL0ZjdFk4Y0EyYndaUTg1?=
 =?utf-8?B?WXVhc1crNnJsZVAwRlBhWnA1VEJYY0U0di9iMkdZS3F1Tnlzb2JqZXNuVmp5?=
 =?utf-8?B?V3MyNG4wc2YrR1F0UGZCNTE0RSt5S1hKSzQ5QjlxOUh5V2g0RStMVCsvcDBu?=
 =?utf-8?B?a0plSTBtNjlyWEtpMmNZdE5SaW14ZVk0Uk01c3M3STZ1RkpqL1g1OHRmbWE4?=
 =?utf-8?B?M3p5TVFXL1UyajRXUFp0M3BtdDl0dVprOU9Eb1B5WHdyTkcyQ08wMVpNeDht?=
 =?utf-8?B?ek1NZ0lNcWc3SVQxNTRYYk1HSlJLQ1dxVkRQQ0ZqWWNZMGhuLzhMa2xxTE1E?=
 =?utf-8?B?aG8vRE9DM1pRWUUwenV1Yk1CaTU2MkdHWGVORDAxMWQ5U2tYRkQ3dzlXQko3?=
 =?utf-8?B?OXZFVGEzdS9IOFA2Vm15UU1wQ0RwSDNMOXA4aEg4RlZTdTUydVdSVVZMVnpj?=
 =?utf-8?B?UHFlRHFzTEMrUXRybGhxc2t0QzVEelo4UmtRdjJuaE5DWDB5aGRxSnl3dFBK?=
 =?utf-8?B?a3lab0xwc0FUNjNvVkFsNEFCMjRqYjRiNlNiYWhuZDZQVzJZRDJHOHRPZXpp?=
 =?utf-8?B?Wk1OZE43QVZCVkxNdWJsUHZucy8wQVVtaGE5Y0hncDl4RlI2NjlVaFp2REth?=
 =?utf-8?B?UmxVM3VEQkp1enVYNnB5VmxnUGgxSmFhQUhwMy9uRjZNRytDTWxzZ1J3WEx1?=
 =?utf-8?B?ZDN0OXFHSjdFcFdKMDlvRUJxT0IwNnZEdkxTL0hNaFZTbFpra09PRTIwc3FK?=
 =?utf-8?B?cFFBdUVXNWl5WmpWMVBJNm81U3FOS01ESmtMRU5yaXpOdjZ1NTVDVTZ5MkxB?=
 =?utf-8?B?Tkd4KzRQWDlrVHpFVzZCT3gzTXJJOVFHMEIweWRQdUtBa0p0dmEyQ3duYnZ6?=
 =?utf-8?B?NlhhaUxCSU9zUzdwNFlnK0hsdFUrdEJUcXRFakZ3a2toSHdYSHl2eUtGc1FM?=
 =?utf-8?B?MmVhY29ZVTRLdXEyZW5Rbzd2OTlXandGK2lYS0s4NnN4UzhmVmJ3b0ZINGh5?=
 =?utf-8?B?bVZQaTUwMnBPVVVpNnJ0VjRVTHVhUHBwcEk2WGZGWHNadnhDcXpUVllVaVNo?=
 =?utf-8?B?T05jWDU1Y290bm1LYmdMeHJYR1JxSVl2WW1zS1Y0TmFId3U4NHlvaGQvcWY5?=
 =?utf-8?B?UXFnUWtBSjdEZDR4NTgrYnpzcHd6S3hXRWR5L0oxQmZUYjFaWHc5STlma1ZZ?=
 =?utf-8?B?STZGTlpxemRycEMwVmcxL21YRnpmNUs5enVzcXFOYVpiZlJPajZncUNuR0xq?=
 =?utf-8?B?Ynoxb3VMT2FZUjdXU2ZCT05lOVB1NWpjOHEvUnRtQVpQQko5S0F6c0xqYjA3?=
 =?utf-8?B?VEZrYzBmSVkrbUtnMWh0MS8yemZpMDRDZFFmWlJyMDJ4VDNRUGd3ZjJ1LzNO?=
 =?utf-8?Q?Vflygtyv/14aZcel+jfJOQCk3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff6c494-6caf-4041-fda1-08dba9ec1de8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 06:32:58.6089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF54UCggP0+iD7ZlKkXSpImCNwuqBIiAJqPEEe2p9Cd+5SXXSSRwePr+fc1SmBVTMCtrwtZxXcqBygmywDfgIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tina,

On 8/28/2023 2:40 PM, Zhang, Tina wrote:
> Hi Vasant,
> 
>> -----Original Message-----
>> From: Vasant Hegde <vasant.hegde@amd.com>
>> Sent: Monday, August 28, 2023 4:33 PM
>> To: Zhang, Tina <tina.zhang@intel.com>; Jason Gunthorpe <jgg@ziepe.ca>;
>> Tian, Kevin <kevin.tian@intel.com>; Lu Baolu <baolu.lu@linux.intel.com>;
>> Michael Shavit <mshavit@google.com>
>> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
>>
>> Hi Tina,
>>
>> On 8/27/2023 2:14 PM, Tina Zhang wrote:
>>> Each mm bound to devices gets a PASID and corresponding sva domains
>>> allocated in iommu_sva_bind_device(), which are referenced by
>> iommu_mm
>>> field of the mm. The PASID is released in __mmdrop(), while a sva
>>> domain is released when no one is using it (the reference count is
>>> decremented in iommu_sva_unbind_device()).
>>>
>>> Since the required info of PASID and sva domains is kept in struct
>>> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old
>> pasid
>>> field in mm struct. The sva domain list is protected by iommu_sva_lock.
>>>
>>> Besides, this patch removes mm_pasid_init(), as with the introduced
>>> iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
>>>
>>> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
>>> ---
>>>  drivers/iommu/iommu-sva.c | 38 +++++++++++++++++++++++++-------------
>>>  include/linux/iommu.h     | 10 +++-------
>>>  kernel/fork.c             |  1 -
>>>  3 files changed, 28 insertions(+), 21 deletions(-)
>>>
>>
>>
>> .../...
>>
>>>
>>>  	/* Allocate a new domain and set it on device pasid. */ @@ -105,6
>>> +113,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>> struct mm_struct *mm
>>>  	if (ret)
>>>  		goto out_free_domain;
>>>  	domain->users = 1;
>>> +	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>>> +
>>>  out:
>>>  	mutex_unlock(&iommu_sva_lock);
>>>  	handle->dev = dev;
>>> @@ -137,8 +147,9 @@ void iommu_sva_unbind_device(struct iommu_sva
>> *handle)
>>>  	struct device *dev = handle->dev;
>>>
>>>  	mutex_lock(&iommu_sva_lock);
>>> +	iommu_detach_device_pasid(domain, dev, pasid);
>>>  	if (--domain->users == 0) {
>>> -		iommu_detach_device_pasid(domain, dev, pasid);
>>> +		list_del(&domain->next);
>>>  		iommu_domain_free(domain);
>>>  	}
>>>  	mutex_unlock(&iommu_sva_lock);
>>> @@ -218,4 +229,5 @@ void mm_pasid_drop(struct mm_struct *mm)
>>>  		return;
>>>
>>>  	ida_free(&iommu_global_pasid_ida, mm_get_pasid(mm));
>>> +	kfree(mm->iommu_mm);
>>
>>
>> I am not sure whether I understood the flow completely. Just wondering why
>> you are not freeing pasid in iommu_sva_unbind_device().
>> I mean once iommu_mm->sva_domains becomes free shouldn't we free the
>> iommu_mm->pasid?
> No, the sva domain and the PASID are separate objects with their own lifecycles.
> The iommu_mm->pasid is released when the mm is being released, meanwhile the sva_domain is released when no one is using it.

Thanks for the explanation.

-Vasant
