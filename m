Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED99077FBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353481AbjHQQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353513AbjHQQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:08:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A7630F3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692288507; x=1723824507;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ttBalqkOXYMogPywRg1G1pE1m/4PXY94GKAQr0TvrsU=;
  b=iUSBEx400KZFkvd118nCLYiXl5Yr4PTugqoGyj2uWfXo/Qjk9DGK8hoR
   8uSRaxycYfnRrNv9ScUa80EIoWqAMs9c01/EGjl5paIXzJh2wzFbsWpfi
   +SzCHFzvW67KCQ3JOlyPG8NGb6W/wZ3vP0chDW1uo1nlvSa0nFZMRhiSF
   aBfFcy8z7ktjGHv3uefmgjEjPFN04rMUExYuA4GWMB5UhV9SnVnbjiJBy
   fyzXO1SQFFzFyQJKdbPqyka+VHJs+9mK2XZRdrbCuYK40w24yiaoHhKR/
   c7sn6OKf9B41TPX0/3nS4FPrHwZuFnupKAG8rtnJLaBsKXHpP1vqb1sto
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="372843093"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="372843093"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 09:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="769706290"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="769706290"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2023 09:04:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 09:04:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 09:04:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 09:04:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 09:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZKAflWSHYYJ5rYUt2n2NbrVNipLnmVZ2eOUOquDEFAfDPgSyB10lB9FOAnjn9ZjsQzDDq9QpKWmsUXXBv6lWyzqoPawIXWeGAkESaYBOiAIYUxeLHrLpB1xMjHUTFsuZy3M9PxzdgdAqEMXo+0rKWXjZjowNbZashnKfqq5abGGP0fOn7uzpTlEI8kAtR3qlMgY1y+OU1XNx0gHNa1/HD37Q3YaovKA/WydbZvw/xR+QaH5yEJ/yhHvWwtHWDCsJTHY1HufjRFQeoi59J7Bw0aEbldSEbh/eQuaFha90+WZ0A3NbbCsdGobidJi1GjJFZu2iV9Rh1abdRRShsfTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEdjGV0sNPetFit4I4muSve3mjOxYWTuUepS/sShhjY=;
 b=LbTikCvgoMiMmB74wLkQddH9hflq1SIiHvbfC2sBaZ7+8vuW9D0cvP0e4rmYSya2qTE1Gm7FbYVJrkMEfMkMb+RmCD/kN0i4fb61LQT6Wa1e1IJ/MEPEu+T71wpW1POKyUdMdn5NQouhl0kqmtxdr2VNtpuZRwTfLEADZLhEV7tp4VL8HzZtEMLIYdxMQ4eRUElkrdRafupQfDDXJgok8Hg3e9APG+mKp3ifmmDR9xudb5BRK6jUSgkxPNcKFvyl7v6Zsj7ro6ckn8YivucwJjSq93AESHR0EH5d3/lZiXdJ4EUcJR2nv0wo8hIWelfnVr1HzCtk0qmT5N+i9hKqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Thu, 17 Aug 2023 16:04:49 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 16:04:49 +0000
Message-ID: <0744195e-181f-2e96-b18b-98c39985cfcc@intel.com>
Date:   Thu, 17 Aug 2023 09:04:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] drivers: nvdimm: fix dereference after free
From:   Dave Jiang <dave.jiang@intel.com>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
References: <20230817114103.754977-1-konstantin.meskhidze@huawei.com>
 <cb36ebb0-6220-c3d9-0772-bfcbd16baa77@intel.com>
Content-Language: en-US
In-Reply-To: <cb36ebb0-6220-c3d9-0772-bfcbd16baa77@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS7PR11MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e498af5-05f6-45d2-a8c1-08db9f3baf29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5VEwsv+ZMjlqhcbeZPMy4EIJcUHJ2vfkFMVta1ki6OSjQcGaNCxraqm2CZFSuB0a1YBQSxCOq6q4jAwClq6Y/W+PaF54tCZu99jwsIrzQKieIpBxrCmv6USJN4rTnj6dSUgbi0xbN5gEJpZAxtymhIR1q5z5/3mq9HJUz6SKa4PZSz/rF4uowK1aYTKuum4T7kwl3FAw+agGteamgmrfVR/zhSPa4uWnjKzzJvHT06MTLNa1X5Hm6bNZ2iAv56ic8xk8EeZuvqoje/hc1LIEGLyg+/kiv4wpt+OWbEji4M/1rmR8RAss88Xl6wzZNSfZZv0c6EoKENU+8mko21GmqMgXptieHeFfPDEjkPqsM2BMqwDjp8F9ZOfpg8EG2AoRbbL6kv7KJTrzuqQmTmEOA9A6MlrtNOdur/eD2Q4tJ6sssPKproVpErnUmbQ/P8Sh/JGL2LuQi6kJc/i2IlDApOgvwLfdi3ivpTHjfC+j1lSGB8NMWm/EOIkW1hah9fo8yUDyuTJfPVRAQFKf3gk0MhMDM7Zvm5KGUa/J6z/ItSXiSwwTK7T36Tfw/FvIeXva6DbYPE4OFb2+fL56N5Y70v9FMNbaFEHcsDnwC+1kcn0lj8znuC6mxHtJAU+LGBZFS+tmXjaWQu9elwz7AP71w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199024)(186009)(1800799009)(316002)(6636002)(66946007)(66476007)(66556008)(31686004)(5660300002)(41300700001)(44832011)(38100700002)(8676002)(8936002)(4326008)(82960400001)(66899024)(26005)(2906002)(31696002)(83380400001)(478600001)(86362001)(53546011)(6512007)(6666004)(36756003)(6506007)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ptZ0dGRXkzbkNkQkc1WEc2OC9CdWE4VjlVOEVTbXkzM0VPYkw1UUNCUGpF?=
 =?utf-8?B?OTlwVTBubDZ5RVAwK3VRcGhPcUpxOS9KTXluNnlUTkZrTFI2bkFTNG5wdTFq?=
 =?utf-8?B?YmxPUGwvdEo3cDRKVlM1T21HcFRPRnBYT1E1U2MxZmM5ZzdYczBnaDRWc1FO?=
 =?utf-8?B?WWpHQ094TGZzK0NiQ0NWOE5MRXBkVzkwMnFvVExFSHh2UjZmRjdZanh6N3RJ?=
 =?utf-8?B?OStNVFZhWWlnRzRLTkI3cDI4ajgwbkw2WXB5cXZYYWlyek5LeHhhZ1VvWWxo?=
 =?utf-8?B?RTJlUklnbFVCN3N4VGlGWU5uNE16QkFhMEQ3eWxjeGJYK2QzMW5rd2JhcHl3?=
 =?utf-8?B?WTFWSy90cTBkeXg0QXJ4RUpIclllTEdkRjc4UkcxSkcyejA4SndyaXNaZzFU?=
 =?utf-8?B?aWI1OVZFU1MwaGlJQ3JxYklYbkVUMktDVllIUXhwZlRtQkcrejNOY2JLNHE1?=
 =?utf-8?B?YTRLVWlDYWt2NjUySTVKNWxyOGZ0Wnp2RnRadllLSHlZYW9panErb1h4bmZP?=
 =?utf-8?B?eFROT2pRY3ZadEwrdnVKVG1JUUZhb3pPLzkzZFM3RytSOVFOMUlzRTRKdHVr?=
 =?utf-8?B?TFF5TVBVMEsvZSttTHJqSXNUK2s1aXhnRnNOREdCd1BEWDkxYkZnSjlERFlx?=
 =?utf-8?B?UkFOQURkc1Mzam1IbVd5eC94UDRwRTB3djMzb01haGkyUnpLRno3Zm1rZjR1?=
 =?utf-8?B?UStGYU54RFA0OVpiNU1qbkVBamdtOUFTQUR6cGQ3Y3pRWDZyZGxrMHMyV2NR?=
 =?utf-8?B?L1NPVlZHc09wVjg3ZkN0eXdWN2YrWTFVWG5kVnd4OWF2dlMrOTUvL0g5ekhu?=
 =?utf-8?B?SnZCMDdZQk5pMk1SNlAvMHFnNzE2Q2txTzIrWitWOVNZY2paTE5BRWlCaFJT?=
 =?utf-8?B?SFI4MlFtbmZ2UGVJdmVxRExVQXBESTE0bWF6RkRNd3FmTGJaUmVUd3BZT25D?=
 =?utf-8?B?SUJmVVFYSk8yWjJsT0c5SzE4UWxLWlpnSEZ1QTcvWFU1SXcyZjFFaE9IQnRI?=
 =?utf-8?B?S2FRVndZOEo0SFQyUlpDQWIzZWZ6TjZiYit2TjhFWGtja1E1U2pXTzV5ZmQ5?=
 =?utf-8?B?RVkyZkVqUm5HbjBVYTJRaUd0RnVialh1cnh5ZkJ2MGYxODgxWGVnTWphM3Jh?=
 =?utf-8?B?cmVsbTBjV2M1SktsdHBTWitLWWFHOHdqWkh4eEtkSUlrK1Rvclp2V3Q2TG9X?=
 =?utf-8?B?bWU5aG1qbm9rbWpVMkFkWEhIWjRzc214azBEckN0dVZHYVRDZGw1eDBscmhi?=
 =?utf-8?B?a1hYNVkva0h3R21TVFdNYXJhRzh5bjJWMzZoVXZ4RG5rWS8rd1pINGRtcE1B?=
 =?utf-8?B?MVdOWWFucWVkWFpHNk5qM25TWGlPcUp0MkZYMGFwRzRWT2VWZWRwei90N3RZ?=
 =?utf-8?B?UGJXOHFxU2RNN2g1L1VqMmlHQlZhSXZOc0t5anJmdWtPdXRSZGI3U25WWDN2?=
 =?utf-8?B?TFlOUzdENTFWazZ3enMycGtMUzVaSkh6R1RjaXJQWjI5TVNHWU42UWFnYitT?=
 =?utf-8?B?RzRCNGw4Z3RLMVR2R00rTmsydXdha09MZ1ZWTjdkZFdXbFIyNERBbEZ6Mjkr?=
 =?utf-8?B?NW9lM21QRXFXckFDa0ZRdXVSUEc0STRIckQ1NWxDd3RqSU5Vc2I1d1RNWU1n?=
 =?utf-8?B?M0dhV01zTzFTNE1XaUFvYUNpYlpuRTFVd3JsTXB0L1FidU9PU0l5RThyOE02?=
 =?utf-8?B?K2RBVnVFSHZaNENDOTJGZ1gydCtLckVqQ29sMklZckEwYmZ5YkZnK1Vock9m?=
 =?utf-8?B?NFNVTVR0MEdFZFNTUzNYazFhRjIxcHNweW5jWGNvR096Y1poTy9Ib1hOcmN1?=
 =?utf-8?B?blpkWjJOK0RVdEhKMjA3VWVEQTZ3ODNkYlg0akg4aHJiNndBQVUyOFRRdmdX?=
 =?utf-8?B?Zm5oVVlIeGwvUW1aTDFhZldDTjBlV2lRWVhQUUJEYml6ZDM3a2dUcVZYSVZM?=
 =?utf-8?B?RSswSE9PSm55VmtaMVBKeStjbzZXaTlFZHlpQk82U0xNMHA2UXRiYllxVGEr?=
 =?utf-8?B?MnNwQU9tUWxhTjYyWnZ2U3p2d3NGRzRiT3R6RUV4RXoyazZwZFl1MmQ0Sk1Y?=
 =?utf-8?B?aXgyWHpJbklncXVINlFxRjA5WTJqVFRJRlNFOEh0RGZIWXpTMHh1cnNiYXlI?=
 =?utf-8?Q?he6ZlBkHPiB/TKr3ZTcBsYNcV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e498af5-05f6-45d2-a8c1-08db9f3baf29
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 16:04:49.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8WHKY3to4nr0gd7H20TfxonrvMqYHmVR3w1aWvtzJfqX+8lCZ3sU+BROZXSLWnPdOpzSuTZtizcwqQJ9lQCfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5966
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 08:45, Dave Jiang wrote:
> 
> 
> On 8/17/23 04:41, Konstantin Meskhidze wrote:
>> 'nd_pmu->pmu.attr_groups' is dereferenced in function
>> 'nvdimm_pmu_free_hotplug_memory' call after it has been freed. Because in
>> function 'nvdimm_pmu_free_hotplug_memory' memory pointed by the fields of
>> 'nd_pmu->pmu.attr_groups' is deallocated it is necessary to call 'kfree'
>> after 'nvdimm_pmu_free_hotplug_memory'.
>>
>> Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
>> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> 
> LGTM
> 
> Does this need a Fixes tag?

Applied. Modified subject to "nvdimm: Fix dereference after free in 
register_nvdimm_pmu()"

Also added Fixes tag:
Fixes: 0fab1ba6ad6b ("drivers/nvdimm: Add perf interface to expose 
nvdimm performance stats")


> 
>> ---
>>   drivers/nvdimm/nd_perf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
>> index 14881c4e0..2b6dc80d8 100644
>> --- a/drivers/nvdimm/nd_perf.c
>> +++ b/drivers/nvdimm/nd_perf.c
>> @@ -307,10 +307,10 @@ int register_nvdimm_pmu(struct nvdimm_pmu 
>> *nd_pmu, struct platform_device *pdev)
>>       }
>>       rc = perf_pmu_register(&nd_pmu->pmu, nd_pmu->pmu.name, -1);
>>       if (rc) {
>> -        kfree(nd_pmu->pmu.attr_groups);
>>           nvdimm_pmu_free_hotplug_memory(nd_pmu);
>> +        kfree(nd_pmu->pmu.attr_groups);
>>           return rc;
>>       }
>>       pr_info("%s NVDIMM performance monitor support registered\n",
> 
