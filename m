Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2C77A2464
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjIORNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbjIORN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:13:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8092D44;
        Fri, 15 Sep 2023 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694797993; x=1726333993;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rWk/6gll0fJoQiQwPLkaXKeuJGMSxySPoHoO23QV9uk=;
  b=OKxOYT0k6wV2/eVJxAOmkMTKd92+tij1m/osfT31koYn70YCcJ8Rrd7g
   70O1r7uGqaADwGSNAw8M16xAy9HhaW/SB1GNOan8MLTVWND7eG0Zqgtxr
   vUxlHT/mskgGC82PeTXCCn02lM4IkPt8e07VimIRwNg5XE7ffFxBL5sJw
   Y+MjCEMUdnsQKqJdd1R4EHfpSUOxOKv5JM6gG/z99dN4GMOMnTg8BIct0
   CBxmqG2ygnmktIenfUz3vfUPUItZ7htjCIsfFuF/DD7o2EaPQsWQsBVce
   VZpwAsSH1eYDUlJ1PxAKhX5WyQM7wzQ4br7BPWD4+uMRYNkynBzjkO2to
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369619299"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="369619299"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 10:13:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="774385974"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="774385974"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 10:13:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 10:13:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 10:13:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 10:12:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqZ7sXXYdMzhnz5pPPEXGQ8t3g9NFTzDqqY7OJ4iENw50rHU3Z6/rSj80uy2ZHBAYa5011vkP+V5hqedxQhyAFIGXwxYJ3G/sxUcoMZoPHxj41t/rfXgZSum9NazasKfaS++B+VQk/FSBjQF7JdqH0SBefwT2tZ0+l2b9SlR843GxLcfHEOwy7AwJKLlRSx/T6wRtxYaKcOU+2mi+rdQsr4krAPOE07k/FMhU1B0wT8HZFY79wuol8SCtzO9MvMvXaAqsraMMnozNq6y7YU3xZey8+knLG/TDwGUXihHp98g69IBdu6Mnax1lr+0yup00yAous+62FHozCv0oRMCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7VNpBtk+Xzi1QQfZNE0EBW+JXuz/JGYyRQ8Qig1dZg=;
 b=hYZ17VaDZdQyObEYhUA1jreZq6p1dFgLqEh1hRHOI0DdW7AFvMmhu3JNbXtFoCp0j4FRiE0bQ9Os/7aGvLPoCVOIfUA54KuD20/Q6qEPaHJJu2lyQfixA0mejqI68XVsk4KITiZO9AkD90anNdr1hDteJWae5T+ZO6SL8V/XKNc9pScT9OnGydMw9/B1MdAkaAUK0M3JxgM3EiURcf//3GBGuNcbXSsBmy86hZ+Nzq7c25geepHjcd2clJacWKWWiW8IUMELRVPzH+9xVdYxksxicluvC7I/JX/UzwtEMfrPfGg+wdQOser4zPMwqh2GSZH4wtzFLHV4tJ/ZWDzK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by SJ0PR11MB7153.namprd11.prod.outlook.com (2603:10b6:a03:48d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 17:12:58 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 17:12:58 +0000
Message-ID: <46816f54-72b3-efd0-c8d8-9778e4b3c4b3@intel.com>
Date:   Fri, 15 Sep 2023 10:12:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 01/10] platform/x86/intel/ifs: Store IFS generation number
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
 <20230913183348.1349409-2-jithu.joseph@intel.com>
 <e7f8136d-d07a-1668-2667-d2836c7112a@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <e7f8136d-d07a-1668-2667-d2836c7112a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|SJ0PR11MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: c881e41a-d10a-41a9-a81e-08dbb60f0214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbZTVJdDmDg/DpO2zE57FgSSsSIgF9hdoJgRe+AjeAMydSwPKVkhAjil1MwH48bR8p6Dbmy7fTHsZOYIIfMvdjo/lXXdQ+EvnLN72IOUPwewYmsylVijNwdm26hs0o2fb00ubRN5ZBbFPQrStDBIlZcpV0zXDtrE6aBO+dT6OwjDzlWP0FtDR4iAYsxq6d8E2ugc0dn0h5gAuQy8Hxtyj3MkuGyO778f0AkjRWNIsGKmejcVERtXzmHNoRSPVYTQxACWNrtsadd7zk0f5f5D+3AFFA+x/qXmzj76LhYepjy78oR9sqaz9VVJFBsZN/mtmP+epjl9uTNjfRR8fFOJde42yEgMdgWidS/lsOTFh0WJ4Q9MCU8OKarZt7WJZn6Jo8jV/f5jBb2UZ9Cer3hjdEjTDyMULN7d5XW+RyP9YVtMu7U/6M73qLoSAnZfJvJYnEtGs9jPl7w/0jD4CVk8RroZdFNont+oUKj0uJMJPM5mMv/DEA2XqRbi1t4CgM/+KIQmyLgEyAND0qBnWgYe/7AAf5HA1wpWE+XX4EDuDZKJONYjvTF7SgFz6zW91wW/omjSwo4UgMD/qzWn0jtVkKMy5Q67y9I/tfs5Rut2zX2nyFcmQ713u2lejXuP68oH1GNjH/5dzwuUziKJergCHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(41300700001)(4326008)(8676002)(66476007)(8936002)(66556008)(316002)(66946007)(7416002)(2906002)(5660300002)(6916009)(2616005)(66574015)(6512007)(83380400001)(53546011)(38100700002)(31686004)(26005)(36756003)(82960400001)(478600001)(86362001)(6666004)(31696002)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjVpRWhBdWtVWlIvZE1VbllwM2VEZ1dTUHRCMDdZeWxQY1JqVS9KTCtrUFEr?=
 =?utf-8?B?ZXlUMG5QUkVHMEF4VytFZGJzbm9IeTY4aiswTW5kUWVjTHlqaDJnV0RVd1p6?=
 =?utf-8?B?MkNGN253cmRVUkhHLzIrYmhiVk1maDdpVzRhMTdKS0w0OFVNakpMYW1PMDNa?=
 =?utf-8?B?d015bStNdmZ5c291RW5jOXQ4WXlTOEhVQWxMZE1HVWZZQ2x3Vm9Vd01RenNV?=
 =?utf-8?B?NHVZMXVJQ0JGbE81R0RQSVp5ZVN1NytQbnVHalB1V3A4OC9HdFo2UTE3cTMx?=
 =?utf-8?B?ZTFXaCszRHM2N0tiQWtXY25FcldaRVMyUFIrbm1OaUhGUDBTc0VtVVVxbXdH?=
 =?utf-8?B?M3BhY3lBWDdiM254QUs5YjdYNVJJekIyc1dkcjlONytVTm00VHE0alJKWkJl?=
 =?utf-8?B?eDVNcDhRRy85UjdmVlhaOTBLKzNGRjFJNXN2S1dQeS9wK0Zqd1VuQkwwWjFv?=
 =?utf-8?B?OWpSVTJIMmtvSWR1cDZZaDBZeVFOUWR3MGdjUDNreG52MFRZMm9HMEIxby9v?=
 =?utf-8?B?K0luNVdWWnhsTENWeW5BTGpIeGVnbGpkYXVmMHBUdDZLMWxOYTJtOFUzOVpm?=
 =?utf-8?B?ZFIvVDRwZFNlMHlITURCakZ5d0tpZVBsRU43eTVQQlJubTlPRmI2NzlGMnN5?=
 =?utf-8?B?MVJZOWVpQXpvLzdMdjRwMEhnUUkrbWx2M1c4OFlHbjE5V3A3Qm9xeTI2eGUz?=
 =?utf-8?B?b0NndzZCK2t6WSswT1MzNGlGRDZzM1ZTSFdFY0JZTXFCeXdVV0pHcnBkWUda?=
 =?utf-8?B?RnBkeXZSalNGVlVOR1hmMmoyT3NjQ3FEbDdVUGJiSjB4YWN3WmVrS2pUdXVp?=
 =?utf-8?B?Ym1YR1dyMXpRSUpFNzMrcnFQc3lRbnUvbUNyeDkxeFJmUjdhNE0yY2NOdWV2?=
 =?utf-8?B?cUF1NzRWRVlLQ2JPSWh6Um5HdTFpektud1pyVHBXWHpJNDJEdmowNVAyOVA2?=
 =?utf-8?B?N2JBeHhMVE1XNGF2N2p4ekdkcWI3bzUzWElDZ09vbitZb2ZNM1RIVFlzbGxm?=
 =?utf-8?B?ckx1UWF6eEpoOWNlcm1XZUpHWGQycWVMajFTdFlaelRXSk9CU0huUlRZV2ta?=
 =?utf-8?B?T0xCUDllOW1ISW4vQ1hGMFZFUERmUnpSYTMwcC9OdmlhcjNmR3IvQ29Cb2J1?=
 =?utf-8?B?UVJOVmhZVGZFYyswYkZEeTQwcDlzR09DZEFiQUtsSXRpSFNKaUFvdHhTQmhj?=
 =?utf-8?B?WjFUSjk3YjBOdVI3bEpiaHJwWndGR0NocHkzbThBQWRWNTU4d2NjSUlTU3hC?=
 =?utf-8?B?eVpVNHV2alM5QVI2Y3Q0bk1reDZMcGhtS09UKytnbU5ieW1Ga0FrcS94TGMv?=
 =?utf-8?B?U24vYThESkoyTXRVN1lPaW03NW5XZVJDSjhQWGJNVnU1UWxSRzNYMTF4NzUy?=
 =?utf-8?B?WS8yV3g5WkNPaHQ4RkJESzZNT3BEN0xGMklZWnVRZTczb0pVRHhwWHN3eHR3?=
 =?utf-8?B?TUV2WlorOS9JMlNvUnMyTVg5U0dDbEMrZ3JtUGtKaEI3UEl5VjFTamdZUW03?=
 =?utf-8?B?cE8zT20vMnZrZGhodFFTaWJxQ2NUZjBEK0FyNlo2UjN5UE9ETkRrdHJtWk0x?=
 =?utf-8?B?L2x4VERnMndIbXlTV01EVzU3Lzk4Y3JkU1dEME1qMEt5c2xGTXd4bForV3cw?=
 =?utf-8?B?a3NKdmtFbkVZbGlYN2dDcE9EQm9NLy93OURyNWNMaDNWSXkxOWdNcTlaWG9I?=
 =?utf-8?B?Z1RwSlk4OS8rcExEVlJ5eFd3aVMxd2R3VnVzWlJTTVdQMlFXK0xGNnJBRURR?=
 =?utf-8?B?UVhhc1ZYeG1YQVRuZzIxOVN1bTZ4VjdEeTlzcnFqL2puMklESm1JNWgvWGlZ?=
 =?utf-8?B?MDhDSlozTjFmY3RTZm1MMkJXRDFQL2VKTTdCZU5jWDFJRUh0UkdvUVZ2aGFw?=
 =?utf-8?B?SHkwdHdWRXlRb1VzZzhROHVBR0dIK2M0clVRSUxPSmMxVGtBSmdhUVBGejh6?=
 =?utf-8?B?eHJVMEUxc3BHRnFPdlB5em9tTEpxUmk4UEw1NlFVYk5LbmM0bUl5bHF3emtO?=
 =?utf-8?B?eW9lWGowN0YwdlZZTzREV3F5eW9telMyb09tS3B6NjdRY2QvLysrQ05HQVNM?=
 =?utf-8?B?TmFuSUcrL2FDM2d6Wmx4dzlEUFg0SjRrb3F2VU9RSnpWSmxKVGUzcFNFK2ox?=
 =?utf-8?B?Tm9XWXN0VkFoWTlxczVXTlZqLzlXdmVYeHUvNUpCdXNVNFJEcVUyZVkvbkor?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c881e41a-d10a-41a9-a81e-08dbb60f0214
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 17:12:58.0413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4v9h3OzXEyq6C7ZDkI5H3Q7Vh1PtgE0chfb7DXjeWhQZ86j4NW47CrRzOYtbOCHHX7uQr6P04Bd59FUElU95sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7153
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

Appreciate the review

On 9/15/2023 9:22 AM, Ilpo Järvinen wrote:
> On Wed, 13 Sep 2023, Jithu Joseph wrote:
> 
>> IFS generation number is reported via MSR_INTEGRITY_CAPS.
> 
> Please use more characters per line, the limit is 72 characters.
> 

Noted
...


>> +#define MSR_INTEGRITY_CAPS_SAF_GEN_REV_SHIFT	9
>> +#define MSR_INTEGRITY_CAPS_SAF_GEN_REV_MASK	(0x3ull << MSR_INTEGRITY_CAPS_SAF_GEN_REV_SHIFT)
> 
> GENMASK_ULL(), don't add _SHIFT at all as FIELD_GET/PREP() will handle 
> it for you.

Thanks, Will change
...

>>  struct ifs_work {
>> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
>> index 306f886b52d2..88d84aad9334 100644
>> --- a/drivers/platform/x86/intel/ifs/core.c
>> +++ b/drivers/platform/x86/intel/ifs/core.c
>> @@ -94,6 +94,8 @@ static int __init ifs_init(void)
>>  	for (i = 0; i < IFS_NUMTESTS; i++) {
>>  		if (!(msrval & BIT(ifs_devices[i].test_caps->integrity_cap_bit)))
>>  			continue;
>> +		ifs_devices[i].rw_data.generation = (msrval & MSR_INTEGRITY_CAPS_SAF_GEN_REV_MASK)
>> +							>> MSR_INTEGRITY_CAPS_SAF_GEN_REV_SHIFT;
> 
> FIELD_GET(), don't forget to make sure use have the include for it.

Will change


Jithu
