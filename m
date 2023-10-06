Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1739A7BBA65
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjJFOgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjJFOgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:36:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94364A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696602972; x=1728138972;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S47BkX2z6FnQmVdjoT4GqLgXPb9+PqegTfKVM/7+zgI=;
  b=GalPX3CAE/NxhZ7jKoGAyZDFc9Z9C3k7ksWvFa9M8Qwj9aJwRBm+CA90
   MAW++K17gYpjV+EgvueN+kDInm/rugTLQIP6N0dDnOCGAOZm8KdbgQ9Ru
   0BI02XrNaz0nkqd46EfYXcsPPWWKDnqnG5LflKkGR6zrrb53LMcQSwpUn
   SBTkV7AN0Lgd7Goto8VI538KkkvexaoUjE0pRyU75dqUply6S8aWTz4OZ
   8gDvUccv95DI5jfFpUrqBXT6uSH5Nixnqo9OekKnRZotToP01SgHszpvq
   ym3GLzMVOmC3I/3XrlUzeLNSINJG3ngah0ZkSHNsVQt0EpM1S2QyopXJt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="368837104"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="368837104"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="818018574"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="818018574"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 07:36:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 07:36:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 07:36:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 07:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ9/Le7Tduvry8zsLaAcu4EGIjfy+6JZDp2yhI+68TI/0FMO0jYUdcvH124rjZ7Cvwvhif9cjx6Gb80kzYNcQZK7G5m6Di7rQgljfCWssFI6W8Mffw7hxxUn4xMYWRlZqDxy/VtBgm8lrHQkN1obi5DdEHKakh48H12tEHWA85a/bJq2lruwthnN9jPeSVButEeoauVy79si8y+y1JvOJrWNBKC+Gp25M3cG1LkP4ubMo5rs72k1ugXJ/VFPTmK/bu+gkfiJVSLSmKMRBjr+VdlxImTgoUhfVHAw5H1v7c3nwhT7YhA8H3yleQPE4rxaDaiD+WaLyueOQoODqPV4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F64GaSBY/doSdA6o53juiu9jb8qnTvqaAQ3A+Z9EDNM=;
 b=Bf3w3SPXEObMVn+FuT9opI4e4YbV/2rUZAQki8C5iDAdsBfF7G5ms2YB3eosvRT1f8VeyV5zxnqyLw1rU/SIQM7TjFMnfrgQIP7xhFwshAbHo39LHcAhfjL7GVGzN8LQliaatQZ0rjb8fo6tS+SRbXpqAu+BHxEPilzj1I7naLlnwGFvn9u/ApBYdpOZjtZ7JFJK4CtJVz0UbSXr5+tWpzJdy5FlvjwoDt2j4o9RbZtYNEao2BBeEsbRWZv7hKvOgZM7yEVS+zQPRYPSaQ56Zo1L2aynh4toJCEQ97ppSVXgfjUm/WnPkTfloTOPswBFI6xSNhZJWeCIykUzrFarrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
 by IA1PR11MB7854.namprd11.prod.outlook.com (2603:10b6:208:3f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 14:36:04 +0000
Received: from BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::f6c2:449c:7191:984b]) by BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::f6c2:449c:7191:984b%3]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 14:36:03 +0000
Date:   Fri, 6 Oct 2023 19:09:49 +0800
From:   "Sun, Yi" <Yi.Sun@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Su, Heng" <heng.su@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yan, Dongcheng" <dongcheng.yan@intel.com>,
        "yi.sun@linux.intel.com" <yi.sun@linux.intel.com>
Subject: Re: [PATCH v4] x86/tdx: Dump TDX version During the TD Bootup
Message-ID: <ZR/q/VaR8gF1CdOg@ysun46-mobl.ccr.corp.intel.com>
References: <20231006062855.875631-1-yi.sun@intel.com>
 <9db9a874e5b7ff62e9cb419f51279047438c30ec.camel@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <9db9a874e5b7ff62e9cb419f51279047438c30ec.camel@intel.com>
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3094:EE_|IA1PR11MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0773b1-e0ab-408c-54d6-08dbc6799160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdAQZvilYExoHxphirHm6OjuQIvpuzNiNO1RGgACnb6zwgwdz+/gas+XsQVfdFYor79IP1zoZStY/82OPMVehFBH4/vE2NfPFgFuMWGUVXRIF6VsaJzXw3kM45FgMpbn7O4xMU8URT6CeFZPurAWgMgkiW38EZQtWtnLuO5Ne9wQWeaDOuqrKcCpEGQcAJkjqZ2l+Bag4aPCs3ezmtbBtgrB38xM2sL+yLrEzrBIS/wrLjzBQ5VTuAxeUV3sITd1o/e+nBNR3oaS+Kl8JoP1LjIP0Es2aTEePd5gS9qZWCw1wte1JZDOTB4ixIIaCffVF1kjaL8hZWTMjRQmZ0AZ8OHZEV6YrBenWmPKaweB3aNCfQ1yV5XHZ0rsNrmYf5Q77DqXDHqcQvlkRReVUTjgy0HuVnS3h/XbGALr1qGGrbPLRUCsBHfhxcZQtHtKEI5nRI3SrcxBbhAL3f2XStw4019gKd1oGax3G7JVI/HdTxOCIykOV4TWFhujwSIfpZ+e4Hmkb3InqUXhvuHWQCdabI0C412iJ8c2hQOIo3kT+LTZwiLyU5+BjKyFkYIu8Tsq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3094.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(83380400001)(6512007)(53546011)(6506007)(6666004)(478600001)(6486002)(38100700002)(86362001)(82960400001)(7416002)(2906002)(26005)(66556008)(66476007)(54906003)(66946007)(5660300002)(41300700001)(6636002)(6862004)(4326008)(316002)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1Y1Z040bUFiN3ZiMHVRYVJldEE4L0Z5bHBkRmhtRWkyNFdPQmNMU0U5N1M0?=
 =?utf-8?B?UVBoMkY3NS9QTHlOV3pGRHY4M3p0RHpJaGFiSmZBd2JiWDRIWDlLS1BvY0tP?=
 =?utf-8?B?VjJ4c01ZTVZvN0IwNVY2SFB4ZDl0ODdqQVR4N1hjcmRLM252WXV4d2ZOZW01?=
 =?utf-8?B?Sm5BRlUvR2ZVQS9Pck81d2FKM1dRVzh5cGdZaE96L21vWit3R0JqZDV2M3pJ?=
 =?utf-8?B?TUQ4OGZvd3FneThhaGdiR2dsdy9seGNWNlo2eTJWd0FnRmlSeUgrVFJhMG1H?=
 =?utf-8?B?WHU4VE9OY2lMazFXQitKQ3ZPUGlkL242WElvMFJTSmQ3bXp3R2pEWHJNR0pK?=
 =?utf-8?B?VDNPTFkzb3BEYUJ4cnJqQmtQZUM1THl4cW8vYTVhMElxWE5UMzVrVm1JWmdQ?=
 =?utf-8?B?M1JjN1VjeVArYWl3Z1VOVUZsU3htbFF1WHUwUXBPZ3Nua3Z3djFveFFvcTcz?=
 =?utf-8?B?S0V4OVh5cUdYY0tqYkVFL3F2TGgzaHBKVGQ3WmZ4NGZDbzA4b3F4QkwzdzVX?=
 =?utf-8?B?UnNlMzBKdHc0cHhEalRlQmxCNW04dHEzU2xSaHhuekpSeFppak1STWlKNVZW?=
 =?utf-8?B?QUk3K2xFR2pSU0xwVTlvVURxT2Z6YWFEU05RUFNpbWxzaUhmRnJ0SUlGODJa?=
 =?utf-8?B?YURQckg0OExqZXdGMEg3R2k3UWR4RGpyU1o1QUY5bk9nd1NrenNVTmVMUkNh?=
 =?utf-8?B?bWFGb1BMZGJlODY0c0Y5eGJpMWk3ajFxNWRIczBRcmhrNkNoaDU4cVNraXFE?=
 =?utf-8?B?cnNnbEthWWtaWEJ4T25SYk5mdWk4Rm9SY1hJVVo0dHdIdkdBMi8zb2toMUxX?=
 =?utf-8?B?K043ZFVSSFFCQU9IYmhCZDdsL2V0bXh4eGVreDZlM3ZOV2xvUXVDUXJkdVl1?=
 =?utf-8?B?R3Y4K2xSWnlxYXhIUGEvMGI1RXFHUWlyZE8reDU0MHIyOEZIZGY3R1FlMTRp?=
 =?utf-8?B?SWhXKzdGRkJtZEMrOXhucWJmbmlrWC9UV3ZINUdIaDRUMndPYnkyL0tuclpS?=
 =?utf-8?B?ZTNwQkNaRzcrNDU0RTRLSFVRM2dGeTFYTEtZZjVmdXdoN1hIUmExWlV2dlI5?=
 =?utf-8?B?N1piTTJURnVYRldPUnY3aWpwU1c5aVdVeTdXMjZZZTFvbHQwVnBFWDlRR0FQ?=
 =?utf-8?B?NWVuZ0dSQ0w2cDU2eG9iWmRtc3d3bStrQnNBTDVsR2prZzlmKzlLQjRabGJp?=
 =?utf-8?B?V0xzSzBQKzgyVDJWZldVVDZzV1FWam9wZ2lYS2k5ZkZBRHdpdHJMMHdyUnVC?=
 =?utf-8?B?YlU4ZGZ4ZENDQWR6K3o1U2wvT1VQb3FqVVBtZi9SYTZtYUZsZEVzVzZUSTRK?=
 =?utf-8?B?TS9JQkdaazFhMGtXeVlJUVRRVHJRbkNuRVdkTUxSWHBvVXJpdlhNalROUTlP?=
 =?utf-8?B?MldldXlTNW4yU0pVdzlXb0NqaHY5dEE4V2hDRWFBUWk3OWEzLzVqa3VreFdN?=
 =?utf-8?B?YVhlZjRhK05mYUpxbHFqUGhlaW9rTnk1ZllhMnVhektYdXdEWWZXRFBFdEpq?=
 =?utf-8?B?bEo0VFhhZWF4T2d1ZXNtZGNDSEptY0F1VlZuSXJvRHZKb0tsUDc0bDVrNjlL?=
 =?utf-8?B?WEpUNkZCcmU3ZElHRkxoMXZjdjMzdkh6Zy9ndXJ0VDRqOFA1Z2hKTmpXRE4r?=
 =?utf-8?B?UFYrR3NlcEFHQmFkQWxIMXBjVncvUjdaOEVvU0ZCeWE4R202Umh2eFFoMzBD?=
 =?utf-8?B?WU1GZnFkY2N5MXhxRHV5SHF2MFJJVWhMYnBmQmN5Z0l0M0RmUjJTeG9raDcz?=
 =?utf-8?B?MmFPNEhCQmdaTHJXeERuNkJadkNuZlZ6UDNJV0Z5TGphcHJWMVBzUk00RERl?=
 =?utf-8?B?bG5tdWlOR1g1cVRtNloxbzFvSnk1NnBCL044cmJEZzVmZlc3S0lHNmFheUY0?=
 =?utf-8?B?YXhlZUNQLy93VS9GSER3OGZkTkIvdC9va2p4MnNmeXg1SmFWamI3cE8vek1j?=
 =?utf-8?B?d3c5U2FONlhaQ0FTTUkxSkdKT2lBNGNlMkM2SXlRUTB3K0VyRFBGNHJBN3pu?=
 =?utf-8?B?UEp0UmdGc3RoQ08wSVZobU0ySURkRy9iTXRGak0wRHhVdDlDUWFDY2dPcnZl?=
 =?utf-8?B?U25CWnRPYk9OcVBGblJpemtPNTdCa042OHY4eCtrbDNDdy9CbjhQMjNDNGxZ?=
 =?utf-8?Q?MhMkYBg1IrSItSYbe9Pk6kSD3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0773b1-e0ab-408c-54d6-08dbc6799160
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3094.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 14:36:03.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jNo9/dlLQtMK/x6OnFRhLJBT76SQqHaemeUlV5392ob32eDQmV1WM7wBrVOOObrebWAYji45sNVy0txfSH/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7854
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.2023 17:48, Huang, Kai wrote:
>On Fri, 2023-10-06 at 14:28 +0800, Yi Sun wrote:
>
>
>It's better if you can maintain the code change history among different versions
>so that people can see what changes have been done:
>
>	<your SoB>
>	---
>	code change history
>	---
>	...
>
>The "code change history" will be thrown away when the patch is applied.
>
I'll refine commit log and the change history.

...

>> +	td_sys->vendor_id = (u32)args.r8;
>> +
>> +	args.rdx = TDX_SYS_MAJOR_FID;
>> +	__tdcall_ret(TDX_SYS_RD, &args);
>> +
>> +	td_sys->major_version = (u16)args.r8;
>> +
>> +	args.rdx = TDX_SYS_MINOR_FID;
>> +	__tdcall_ret(TDX_SYS_RD, &args);
>> +
>> +	td_sys->minor_version = (u16)args.r8;
>> +
>> +	return;
>> +
>> +	/* TDX 1.0 does not have the TDCALL TDG.SYS.RD */
>> +version_1_0:
>> +	td_sys->vendor_id = TDX_VENDOR_INTEL;
>> +	td_sys->major_version = 1;
>> +	td_sys->minor_version = 0;
>
>So the main reason that I think you can just print module version in this
>function instead of tdx_early_init() is because IIUC you are setting up some
>random value for TDX module 1.0.  Probably it's better to just print it's module
>1.0 w/o mentioning major/minor.

Actually, it is not a random value here; it is the fixed value for TDX 1.0
becasue there is not such version info in TDX 1.0.
I assume we can state major=1 and minor=0 when TDX 1.0 is detected.
This will prevent confusion for the users.

>As replied above, I think you can print module info in tdg_get_sysinfo().
>
>If you do so, perhaps to rename the function to something like
>detect_tdx_version().
>
>You can either still keep
>
>	pr_info("Guest detected\n");
>
>here, or remove it but embed it to the message when you print module version.
Get it. I'll do that.
>
>
>> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
>> index f74695dea217..d326509832e6 100644
>> --- a/arch/x86/include/asm/shared/tdx.h
>> +++ b/arch/x86/include/asm/shared/tdx.h
>> @@ -17,6 +17,7 @@
>>  #define TDG_MR_REPORT			4
>>  #define TDG_MEM_PAGE_ACCEPT		6
>>  #define TDG_VM_WR			8
>> +#define TDX_SYS_RD			11
>
>TDG_SYS_RD, please.

Appreciate Kai's detailed comments.

Thanks
    --Sun, Yi
