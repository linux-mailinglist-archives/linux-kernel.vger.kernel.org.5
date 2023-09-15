Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5987A27C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbjIOUKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbjIOUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:10:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E76F9;
        Fri, 15 Sep 2023 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694808637; x=1726344637;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n0s871FA9U7MchMjXk/KAYVdZilKclZt7Tvr7C53GvE=;
  b=GoLcurF82AGyRNiTvC9X1XYfhWMWtDXqoQw3m9vEsijPc4mlxQGg31Zv
   aNCH2kEaanmjKhg2tgJsvLYB3YRh6golbQTLEtHyKF4G+VN/6mVWjYZEc
   8aWumKfVEGVPpoYlF8X60SmVUM4STfLECARJy6Ebl0pP91VnrOTpZwsLj
   wa1H0RG5O7mm6c7puOIHlzkEMvcP7wMgmwxxVNsXMUVC9CdWIryHWgXI9
   4BysmRVlDfeftfmK0n/ntjCG5Y4d8iFk+vGuW1vg/pXWNR0T+QeHIBOjm
   mjGGjLdX/8c9gi31oOVhqnLQkCUV9x+CSWIa8qjxwphMezTWs/wmXMkEu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="378242891"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="378242891"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 13:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745119923"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="745119923"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 13:10:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 13:10:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 13:10:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 13:10:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 13:10:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3o0lPw2zFXOceieP8BhWXQe+HFz7t27nygzzOeIr7k8ZPkHp+TJcjjL2+IUc6C+w/UlZYIMVLfVgD+jwr+WeNlWEYT/DqIvKZ4oK0j8gzrEBhADEajdCPCAysc9ihIwhuyNkmF3z2oIW+KC/ugUyiDDlI+qsTA7e4EELm8aMYSc4ctEKFf6NZOBpuXoWdwgXPKfow6nVPZTZnQn0MVY4PFWGy9wQh+5MWqA87WnwjjnK+UXAYWF1XdRe5WViiMG8x+JL3EMMNYWLf6Du8rxFV0IN/N2K4+ecTxPpS8dPXvWBGtUyaUEY2Tc2Z6H2KqYZOX0oOMTQPobY4fptdXbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLZULy8rxk19cImEzcdvAbTptZHP+U/jZacrBc3Odrg=;
 b=Qt3dkM2rH8n1Vjv9o0sgY01ymG1sBIVBUbIHPCixJB6mx08e3gfYWfaUQtHUUeb97nI8LKTz82d1IU3fAMuOOUDZXlJ7HRQZtZ8RyX+3vbmWV2L/n1KpK0o7wobX310zc520bELMH/LbZRuyzo8Ps04Ua1L3z+wx8hDensMEsUopjnlZvWdhVqlPn+0xRt9g8tyI6aPhuKD8iIcdgM8HVavRdlR4JEJONLg1nuyrK6A66AEhtwlVo6dsrHCDEe+Nips/GOjRtfygfG2nuTTwIW+OVasxwB/xvqHEgXHC566BZq3RkgWVYUCcDuk6kTxvzYCzMrkhI6VWTBDCbwisjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by SN7PR11MB7090.namprd11.prod.outlook.com (2603:10b6:806:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Fri, 15 Sep
 2023 20:10:33 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 20:10:32 +0000
Message-ID: <5a66a02d-3504-ab5f-5373-789c8789557f@intel.com>
Date:   Fri, 15 Sep 2023 13:10:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 04/10] platform/x86/intel/ifs: Scan test for new
 generations
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
 <20230913183348.1349409-5-jithu.joseph@intel.com>
 <74882e91-f41e-7672-3835-d74f1364bbdd@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <74882e91-f41e-7672-3835-d74f1364bbdd@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|SN7PR11MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a451d27-a52d-4992-78c6-08dbb627d0b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpvFF1yN7PBj70HqUvF6OCCmhlIooyvxIiWDZYSmIXaA4ork1lkm3ALeaN3UvXqbkVctw1eFo6x0lanm84PCkypSMPFyv/jSGMPBBbPrjknOItq8HZrtso+jcX2cdu8wAJE6U7mrv1f3WF1RDl5weU+A36391/gPGmZXUHTbAStuZXP/8eqgAOvuC2euSDRXUcLnDn3vFNVdxCFmtdQhjs41lfFrcN+vGwbzxYwzv9KZm3AaTni+60UT4LEZ9qLLNonhn2LQqGjDEKu6lq/4wsfukr0prpEooP+1wlqWv9z542v8CL3TpQkoSRbc3vVbHQjlhR9NwsmAhlTbtodjXphorV5HuX/NrGTog2ykgx45/JpRe6RjPWpSUcfugwJJK9n8b4TmjAgPxpBVOZvhNVvHxVs4VWd7VTXawt1IWU1PfU46MZiWJ71Wtm9o621oYePALMnkFm5RPACK4wOJh0iSaOCoG2sT9RE+1G6jiLztuxdF5guy/wVxcFHi2cypSMb0tjSZ09QC9AJo/doO/s3eOj0m/14QKSic/QzFnbWT0OEV+vVL0pnGLDNMyC03a3OuCJhNdYnae8+rePkWyK+jVXZLyVpcI0lF0VNgzDYFo8kTdcu++QcYPoWdwkQruJNOz31sL2ES8k8leXzQ5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(1800799009)(451199024)(186009)(41300700001)(66476007)(66556008)(316002)(66946007)(6916009)(478600001)(7416002)(38100700002)(31696002)(2906002)(36756003)(86362001)(5660300002)(8936002)(8676002)(26005)(4326008)(66574015)(2616005)(31686004)(83380400001)(6506007)(6486002)(53546011)(6512007)(82960400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THVWREdTd0R2Z0UyRUs2blg1cG83bXRYZTVaRmNuNE8xMFlIeStpVFIyc2NO?=
 =?utf-8?B?ckJxWE9RRXBsZ21yYU8va3FvcnlMUjR1NjJGcGx2U0dtSDVhNklJcytkdFdT?=
 =?utf-8?B?dU9aNHVXdWZHVVRqY1A1YzduK0JPZWJmbTFBZ3RWR20vNnlHRmJJck1MS0p1?=
 =?utf-8?B?YUtoY0dNcUtHbmc4MC91dUNoZlNEMkZIeWlnYWNnTTREdzdYditzKzlPTUdt?=
 =?utf-8?B?UmN5L1RIeTlka2ZTblFSYmlHSnVSaE80QXBzaWw5OFlpdVlVcjNlclVTaWg3?=
 =?utf-8?B?RWhBNkZaaFJQU1NYN2YwQjFSY3M3clI0YUFROFJ1d0N1cmM5N2luSzBKZjR3?=
 =?utf-8?B?TjNHL0M2MkRyTjlsbUFLbDhJN3IrQStXNHd4ZVdGWWluR3RUVW5VU1R0R2hZ?=
 =?utf-8?B?NmhWR0d5bXI2Z2lKTjNHazk0aXhEZ2xPSmFQbkI1Sk00L3BZbWUwYWhHRGo0?=
 =?utf-8?B?cHhSOXoxK3hnUnpIelJhS0Nwb3Y2Q1ByaUpXVTI1alpRRVNLS1pGdG81c2Vl?=
 =?utf-8?B?VDFmUlpLdytudzR1VndGREFPdUJMV3JVc3l3QVg3UGFjS3JMZG91d0U5b3pR?=
 =?utf-8?B?K0JYOHlXNFdkbU5xSXdNWU1iZitwSEc2ZUdLMjJ3UVlPVXFDSmk4OXkwaDBD?=
 =?utf-8?B?Y0Y2c3hFT3J1ZnpRTmx2QzlBcTAwR0tSY25JRmJXYWd5T3dWU2dCY2VENk5Q?=
 =?utf-8?B?eWdQbWZUYVQzZGJtM0tvZjBleENOQktRSWxBek1teUM3ZE5QbENTOTR0MVRG?=
 =?utf-8?B?WlJpRHB3a0ZCUWRxSm1YSThKeWpDakxsLzY5bUluN21HTG5Eb094MllMMkwy?=
 =?utf-8?B?MmNQYWt3MlVYTUxPN0RVUWMzMjVmcUh4OEhHRWJyZkpCSytjN1dtZ0ZVUklC?=
 =?utf-8?B?a09Lb3AwS3QxYXQxNGRsUUxDbkxvM1NpQStOaXU2QXg1SUJQcXdzOG9IUmoy?=
 =?utf-8?B?SmxNNFpQQ3FLTXlPa1hCM1pKMDlUOFNPM0IvSzR2L0FZK21VMDIrZTU0UWdN?=
 =?utf-8?B?QjZuZDJMVnI1cjhBV2hXREFzcCtDLzhwdmJJemJNNHpMbkxQZnpPdTQrY0Rw?=
 =?utf-8?B?aVEyODh4eXFNOGtNTUlSMnBHYXR0bi81TjU5azk3a09ES1NoQ3g4ZDJHa0Jy?=
 =?utf-8?B?UmV6Y2RKZWh2S0tzQjhIQXp3MWh3UUFFb2xLQTZOTXZucng3ZlNjeVJFeHU5?=
 =?utf-8?B?WTNtS1luMzdUMFROMGpLNWM0OVIrRkFYVDYwY1pEUnNWR0RyL0pKK2xCc1pi?=
 =?utf-8?B?cjN2MGE5VkUvV1U4SVd3Zy9IMFBRM3EzSjBxbmtTM2E4d2Y4Z2RXSStEL2NE?=
 =?utf-8?B?dzIyUjZqeWJGY2RwU09oL3BCTHRlSmk4MTNCTzVkQmlvUnhrbmJESXdwRDlR?=
 =?utf-8?B?OGZ3YUthWUNpV0FZTW1CVGhYWWdTTUJUbmd1Zi9PM3J5UHZzM3BJeWwyRDhv?=
 =?utf-8?B?VGw4T1o4VHFjbHQ0MXZndFErSHJkV0xvMFlFRzBXSnNOa2MxbGJiN2pMUGgz?=
 =?utf-8?B?Q1JKb2piQVh1M2VxV2ZhUmhoS3Vqdjh1SFBrTytLT1JVeUxkdWNNQ0thZ3l0?=
 =?utf-8?B?YmJtbG9MWVpZZWVDQzVraW1tMHVXM2Yvc1hSWm4xZnRsZDF1dkNsV0N6NXJY?=
 =?utf-8?B?YzZTVFFhSmtYUFc2N21NZGJWUUo0aGVqdlA3cUZBM0lEZ0JXSDRVVm5jbWJK?=
 =?utf-8?B?QVVweHRxUUVOM2tkMWM3S3lEQnU2SDhhYlljVlJOb0NmT1VtWjFhK1R4M1lV?=
 =?utf-8?B?VElPbGpFSUJjelVNeTNhODdkYXJRZmdkLy96NHRMQStKcUZPQTl1ODhUVTNN?=
 =?utf-8?B?Mmo2WmdZZk92ZmQ0dk9hdlVBZ1BlOEkyc2pjc2ZlSWdVdWprTmpnd0xXeGwr?=
 =?utf-8?B?UUgxcm4rYmlZb1pLZTZRUkxMSUk4STE4QUNkdkh1VHhuUVNyd2pyOEFZakds?=
 =?utf-8?B?SWNOL1BHNCt0ZFJnMEFXaE91U1kydmpObFdZNEZWR0R1eFFXU2RNU2p4NUYz?=
 =?utf-8?B?NVY0RzN0MWZzdjVnR1NkdFFqeEVnNGxMTzY2TE1seHdodTFjdmhYM1A2ejZ2?=
 =?utf-8?B?VW4rbGMwUjRKRElLeFViVzJudEpyWnpxWXJvQ1JYa0haamxES0RTcWVycWpv?=
 =?utf-8?B?ZndZSFQvOGtFZE5OdzZsYkpCQjZ6MUo3amJ4dFRjK1l3cVhKWVhFRnREekVj?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a451d27-a52d-4992-78c6-08dbb627d0b4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 20:10:32.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjbNZk0M7ByevNp14MsSVqlRB3RP7N0w40pbz7nKcG3/eF7kFKamYgqXsVbZskdYAcktV4+d08nJ2C7OQNhXJA==
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



On 9/15/2023 9:51 AM, Ilpo Järvinen wrote:
> On Wed, 13 Sep 2023, Jithu Joseph wrote:
> 
>> Make changes to scan test flow such that MSRs are populated
>> appropriately based on the generation supported by hardware.
>>
>> Width of chunk related bitfields is ACTIVATE_SCAN and SCAN_STATUS MSRs
>> are different in newer IFS generation compared to gen0.
>>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>> ---
>>  drivers/platform/x86/intel/ifs/ifs.h     | 14 ++++++++++++++
>>  drivers/platform/x86/intel/ifs/runtest.c | 23 ++++++++++++++++++-----
>>  2 files changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
>> index 886dc74de57d..3265a6d8a6f3 100644
>> --- a/drivers/platform/x86/intel/ifs/ifs.h
>> +++ b/drivers/platform/x86/intel/ifs/ifs.h
>> @@ -205,6 +205,12 @@ union ifs_scan {
>>  		u32	delay	:31;
>>  		u32	sigmce	:1;
>>  	};
>> +	struct {
>> +		u16	start;
>> +		u16	stop;
>> +		u32	delay	:31;
>> +		u32	sigmce	:1;
>> +	} gen2;
> 
> I don't like the way old struct is left without genx naming. It makes the 
> code below more confusing as is.
> 

Given that less than half the fields (2/4 in ifs_scan and 2/5 in ifs_status ) are changing across
generations(and rest are common) , I felt the code would be more readable if the common fields are
accessed without generation as is done now. 

That said I don’t mind changing if you feel strongly about this

>>  };
>>  
>>  /* MSR_SCAN_STATUS bit fields */
>> @@ -219,6 +225,14 @@ union ifs_status {
>>  		u32	control_error		:1;
>>  		u32	signature_error		:1;
>>  	};
>> +	struct {
>> +		u16	chunk_num;
>> +		u16	chunk_stop_index;
>> +		u8	error_code;
>> +		u32	rsvd1			:22;
>> +		u32	control_error		:1;
>> +		u32	signature_error		:1;
> 
> Again, I don't think the alignment will be correct in this case.
> 

I hope this is clarified in the reply in patch03/10

...


>> @@ -211,7 +222,9 @@ static void ifs_test_core(int cpu, struct device *dev)
>>  			}
>>  		} else {
>>  			retries = MAX_IFS_RETRIES;
>> -			activate.start = status.chunk_num;
>> +			ifsd->generation ? (activate.gen2.start = status_chunk) :
>> +			 (activate.start = status_chunk);
> 
> Misaligned.

Will align it to start

Jithu
