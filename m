Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4037AA6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 04:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjIVCJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 22:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjIVCJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 22:09:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5535FCE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 19:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695348573; x=1726884573;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jn5idO+tQ9Ce0b+MQLwD7oGv/aU+2LwZvXVAEzw8zos=;
  b=gRaXXMvUkARUn54O1p8YxsL4ad8dg0Hh8X0EdoIu4J27g2Spo4aHh481
   n4JosQax7yKwDLKcxVmTfmD+it0jYcKF8I/D+SMwkcHotodifMDf9NNHI
   ybi2OqI5/hT8I7UmhaOOqENEYahdobHtjOFT8rRGGXyiIECnhtu/QTaTr
   t8P+IrO1PYH1UTBC8zvf4pPLZgTN8rMwYYXvfIpFcVtwYIh9LdrCtjOac
   hSI5V2R9rqAXdCx3iPb4lMHWC8XcaIFSI5VImqpkCGKdamtOgdo99DG5h
   18C0Es3ILeJ5TrTbXHh62OvClTq48J5ioJetzu0Ak6iJ0z3GT4qVUT5fx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="365779741"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="365779741"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 19:09:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="724003396"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="724003396"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 19:09:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 19:09:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 19:09:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 19:09:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 19:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn0Nsn3LUI3AcevSqZLMX1onDTHBT87ujTGQItg7GZJqN+1VoLKm21+lpoA9n9CUeIWkWaK85EY0Xk6a8lICZOMO3KdlhX7e3mFKLMrOL49QyW4eW+KCkub2/TNPJ6UTzGabe390kgYb/+wDzt8b6FLJdS8Q2RzxZM4KdqAP7D6NXAfuNaKv+W8OywE5rWg20G7LDW9pFuzKX42P9H35KgAC9GIhMIbgU3z8xUNPalNUoJcTFs6U9+YOLEyr3V8wWCJiSlKd+L9rAgwo0scDuS+7dGINWpJ1dObyrbDT+78L2kCrqgo8JHcq2/mklxp7QNxqSRdK0nky2hV3ssRoag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0ueHF1XY1PA/dw7b08aktm3Rn6AkjOapsIAe4foZgQ=;
 b=Oam55yUUnBA3MzWDDoZPdgudYxelX4kd707A/YOychCOhDX6drokKa2bXQGDBULomksBXttNXx6GCxp0raw4m0nCIcWFX2wy2hf9w0Bap6r52hfBeo6IFJoMp1xN9Qs0RBHJdyQQgt4m3TtvyegzCh9XyqBAZjfJEpZVrqmDg+XdCKgA0uo+w9aMCdQHM78ZqZPTma761ja8Zq7DKEkpSZKexJxG9mUMiQ6o54caAJzBbjaAFJi5G5DBh9XhBDbh3x38pMOUg021zRXz/Kswjid4DHj6BLv9u2En5gUw4nGCw8F+tN3b+BLMBWEJDVec9T0VjCo0HE057t73hhIRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 02:09:22 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 02:09:22 +0000
Message-ID: <252878a3-bcea-5810-dd94-951c266b8549@intel.com>
Date:   Fri, 22 Sep 2023 10:09:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/6] iommu/vt-d: Remove mm->pasid in
 intel_sva_bind_mm()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-3-tina.zhang@intel.com>
 <20230921185648.GY13795@ziepe.ca>
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <20230921185648.GY13795@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|CH0PR11MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 600151eb-2f7d-4477-e1c9-08dbbb10efa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inE0dqqhy+ereM55Dm3aHHlojW59Hhys5AGN87+HJwiuyPJaLhqOPwEGL25B5yCcVi4mfKst5MVDQQ9UT6rOvUp9U9CedTvlDxjfx+pB4nZPBQE6mXRr48D4HhuiV5EcLWVU/L2L0TO1M6nq6+MaDZDEf8NHoYN3Ef5eyO2ZUucqLDdm3MgUk2vaebT1CFYio+RkifhdalDk73lYDusZOuljOoAKpOnJCo7GTXTY9RA/e+egd8s8k/PzqguZihRmyCeedoeSsXJmHWb9JTdIk56xEKL4UHq6tmNWKMJ7kM31rtehAH/znWbv/EGC4/ACAqgQtNTj5/4DsUoUQBzmI6aOQlv9wbkNkx1npml3JVoUTxZQu4/jKxdjO+JYMPtWRJkGH5l3zBCkXSeGYahPt/bzbpDKGeLv9jRA0pNUxYSBEgPYmN7yC+mL6a42ulZ6bNExZRGA40pldTC50D3Qb7trRbmkcret0L28pAZM/Aw4Vx6u8nzqc0CQg6VxCmXUfsN34IYk47fty6Y7ke/l8EILRYvAmRclZ2tynSXmEgm9ddtpeCkQI9EXu6pfNvhxmnd9G32p9UtRePrO+VXZfVa5kV6A8UUiMq06Ev7WfkV1oLvZvSRATg7H/o74ZI78zEblRZFgtbVb+EDoHzX52A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199024)(186009)(1800799009)(83380400001)(6512007)(53546011)(31686004)(6666004)(82960400001)(478600001)(36756003)(41300700001)(6506007)(2616005)(38100700002)(6486002)(316002)(66476007)(66946007)(6916009)(26005)(54906003)(66556008)(8936002)(5660300002)(4326008)(31696002)(86362001)(44832011)(8676002)(2906002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEpiQ0swdjlRVmE4RTJVYVp4cUpFMlRReGtrb202eVJZbmtzc3VudkpLOEZz?=
 =?utf-8?B?VjJ5TDZSdC83YUg2dnlOTTc2K1MyMDdyazdGTWMvNE9hVTVzOU02QkIvbklp?=
 =?utf-8?B?Um9xOVlFamxkeUNLZ21xd2Z5ZEJ2Z05yR2tmTE90N00vL1lWRHZYenpvM2lG?=
 =?utf-8?B?U2FKMU5wVnhUYzhnNFF4VTh5eTJ2dW5CWDd1MUNWbmozdTBQVmtjTitiWlZa?=
 =?utf-8?B?ZnBUekV1dGo3clhNRzNwMS9HRVBraUFpNzd5Q3BrSmhIcGtSUjlmWVNFanVS?=
 =?utf-8?B?YnZuRlBQTlVDaG1iVFJhSy8yVGdNVTFyYXFjUDFpbE1hSmhZVG1tZUk1eVps?=
 =?utf-8?B?cWtTRVlvWWU4cXNoOUVVZXJEaElsaXZ1S1RWM1NNTEl3VmQ1RXhOUzFqS2t1?=
 =?utf-8?B?cVlUNzBDbUJFVVhXRWU0bUxhTGczSHVad25LUk1hcmFZOGZGM0NJNHZvZ2hD?=
 =?utf-8?B?UEFYVWFaNGpqZ1oxVGVmbnlXQnJzSm44eWQ3eVhhOG1yQUZmSTRqaHB6VXpz?=
 =?utf-8?B?cjBVUENGZ2tvNFdyTENwUXlBbWxKTEpFbU93NGt2U1prUHNqb2NLWkZQSGhD?=
 =?utf-8?B?c2s5dmRsR2FyajJmZUk4N3JDMytRWHJmUUljWHJtWkNKQzVCSnNqb2lvOXN0?=
 =?utf-8?B?WmZTTkRsTEJSRi8xdGw1ZDNUUHp1R2w2YXp2VENZWE81bW45SmVzLzJTNlVB?=
 =?utf-8?B?Ukg0QTIwaHZ2cE1VdzdqY24reTlaY1FyczVmMjZlcWJFOGxKTDlMcUd6YUlQ?=
 =?utf-8?B?NmhkLzU4QmY3UE9ka2tMRXJRUnNBTE12K0JWK2RmVjc4ZFlpby9QL1FhVU5W?=
 =?utf-8?B?WjRIQ1Y0Z1M2NVFWZjF0cEo5VjhNMStscUtpS1Zrek83QUhOWHNtSWkzNm56?=
 =?utf-8?B?ellDMG80a2dybWJHV2tIdjRHek5jWFQ2UXVOTnkwL2ZQK2h6Ylo4bjhMajlm?=
 =?utf-8?B?aFNyd0VNSi9Lc3RjRytxYW1JbzZ3MVdtRWorYVVmclRGbHhhYS9wSGFDamhY?=
 =?utf-8?B?WXhGc3lvK013SC9hbjNRR3VBa1lzcWRkbTNFcmNPUm5TZlRvWWdxaGpPSFdk?=
 =?utf-8?B?SWFmNjZkNkFNTXpVWEVvN05WcC8rT21EOEVZUmRwZ1RyaVI5VjdVbWJWc25m?=
 =?utf-8?B?Z3JiM2JuSkVsbC9YRitxUU5QeElhRzl2MUFFd0J6TnUzL1kwU3VWR1Zvdkgr?=
 =?utf-8?B?NWdJd3ZDejRRV0xSdmtHQXFlVG9Vd0E0MjRiZktMc1RwZ1VPbHZPVXhHRm9t?=
 =?utf-8?B?dHpTcHdwM3VycFZmM2tTK2tBcmVSUFNqQVdWVU9FcHM1cmFCOUE2dnFSU3Vi?=
 =?utf-8?B?SWk5bmIzelFkLzVkQk40OEhBUHFrOGF6NnBUbHhiSmZBdkRFQWVSQ3pEcy9X?=
 =?utf-8?B?VVd1STFhUTNFYSs5T29FNjVmYzlLMWlUR3A5N2ErSkw5Mk5qV3M0VU43WFdK?=
 =?utf-8?B?TVFvc21ZYUNzUVlSMEN3dFJCSC85eUJVOVp4UDhqOFRNMDRwYzRzMVFEMnd5?=
 =?utf-8?B?cm1IQXlzejJ3RjE1VWxvb0k4cDRaZmp0SDExNmhoemJrNllhWElpZ2xvbDRu?=
 =?utf-8?B?R2psZFpuVUZ0S3UzOUw0bSszRzNQNjZOanFvZnBHWmNBSy9wQXArOUhpZW0z?=
 =?utf-8?B?T1hZRXVOeHRpUmRrRGdneVhiRThoc3NxZi9wU1JvR3ZYK1FEOW5TWHlQS0dp?=
 =?utf-8?B?RW55UG5TS0hyWDdoNUxuWmlTTldSamhTcUJicnRNL0U0WmhKeEdOb3g4WTF2?=
 =?utf-8?B?Vlk1UDFoNkxWeC9NVHNxUmhxMGlqMkl2WUwvbExvNTl1UW1lL1dEWE4vbDl0?=
 =?utf-8?B?RUZwTkVBMzdSOXJESklnaGoxMXhHeUEyVkJsZFBRSVR0U2MzWllTMVk1WFlt?=
 =?utf-8?B?SXIwSEdkUzVJRGlXdjZMU1M3eGRoL21Rc25DLzBjaDRORSt1bkZ1TEk3QjJP?=
 =?utf-8?B?M3dIc29kRzBoRFRQQm9sTStENytjTlBta2l6YVNHeVVLeGNRQjZxcUd0NGRv?=
 =?utf-8?B?V0JkaW91Vk1vMVVoRGYvbUJxNHU1UmREMk9CM3lybmpRWC9XdkJYWjNPbXpQ?=
 =?utf-8?B?em1PVThFcm90R2dKcERCd0tOdW83ekFpY05OZXdkTG5LeVpZQW54dFRrc1FZ?=
 =?utf-8?Q?fcW9AUjiXZF/lJCbeccw16FEb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 600151eb-2f7d-4477-e1c9-08dbbb10efa4
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 02:09:21.9957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMNrX3F5ZI5WUQwv47xNrOKyvTH0++o+Aaia3Mo/GXVUIW2neTPSxcM3WR/9kquQZyllMI//vqXVv6kaGB8dgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 02:56, Jason Gunthorpe wrote:
> On Tue, Sep 12, 2023 at 08:59:32PM +0800, Tina Zhang wrote:
>> The pasid is passed in as a parameter through .set_dev_pasid() callback.
>> Thus, intel_sva_bind_mm() can directly use it instead of retrieving the
>> pasid value from mm->pasid.
>>
>> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
>> ---
>>   drivers/iommu/intel/svm.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> I would order this patch first in the series
OK.

Thanks,
-Tina
> 
> Jason
