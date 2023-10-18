Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFF97CD585
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbjJRHdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJRHc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:32:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E1F101
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697614374; x=1729150374;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+837YnDY33XgIGatupnlHB0ZZsk54La3FZv1b3heWbU=;
  b=PSbV3KtyplGWzqLUATT/iDXRiAXmRDLQiJyUrFUzSvqA/5qANrsjgwoV
   wdujsZVR+4QA6srqUe+hELINAbzibvw8plXny/n0HneLkzpw5cO83eIzP
   h9VsVxM/biD8CFUdUUg5TgDseac8Ia3XXTKZvTEMQP5fYJwCGeaxUyQdj
   WBrrUA+USZr4qalgmcY+76oPIOYey06YxVJB72ZEtuJI1zJolKFa8XioD
   5zhxHraNMS/+r+GxMQaHfX9FwI//zAf4SuDmjEh0BwGXrCSs7FB3ylMON
   1hU1KQYqyM90w2R4lMY99Ap3S3GDiARsQqYxSG/aZXZ5rfBtZpbtirIgE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388822006"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="388822006"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:32:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="706331963"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="706331963"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 00:32:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 00:32:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 00:32:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 00:32:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 00:32:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4nErrsqp6tiIT56W85DTHtLDxMm/bIR6Q1WGA5EizWcGnSzQrDn+F/2RwrGNnopuu0mdmU+ls3ba4WINic8K0RyFtSGBYqbmuIuMcf1mwXQr2txneb3JfTTWthndbJKfhRX6Nh7Q35uQU+oGfMpJG4KcrutLvUHLF0BrdNtFVD8e6nbBZE/snfIIY+OogvXdnVLCBdm3YvRQ/b3kc165o7K1GaVrrttpVBm3mc/QrxHasBE2P5fD7vpcSDf5SWlnyMIZVk7gzNHJ/e/ANZM//iwQ/cOCb3l47V/uKlSHgQacXWUB4NI9Qm2+iEQWUdJWR1JvRjEvVxwaAITLGFNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7Gaf2TYCSEqhqMiKFSfBl/975ytscqkXwn+eseCq34=;
 b=LeB2oXyuv+2lTuQa+nQHkXpeoDLk7yOZnTBhdMYHuRMtzvs7taITLTk4xORI4aMoe5fC0OnWFs+o4mgC85GpI2jZYK4RieFQye2B6Z5pkVt9B3vOfDuN88VT2aNa0w9uCZkyYDqYTjyPpNv4Q+orWiK2FbWOf0+VaHxabiLQKYAFNXZ2MrHKzFCdoMb5YM3O/ySJU37t2KUoHasFGzJGVBMqmDUy3XyrN4RVoXFHM7Kj+vDMAO0sgKyKpd1nWbGiODg40bzVLZDRUNU/+I7qaYQn8nOWiQsoTwB8pUulM9tOCZScmcoHZPggnLGitOb1pLcmUe9oM54SF2gHwjKH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 07:32:42 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 07:32:42 +0000
Message-ID: <1118ec6d-e1e7-79f3-08e4-9a79c996eed1@intel.com>
Date:   Wed, 18 Oct 2023 09:32:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: rts5208: Replace delay function.
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
CC:     kenechukwu maduechesi <maduechesik@gmail.com>,
        <outreachy@lists.linux.dev>, <shreeya.patel23498@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20231018004300.GA3189@ubuntu>
 <7bc719c4-459f-3d8-7ed-b1e1adf158@inria.fr>
From:   Karolina Stolarek <karolina.stolarek@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <7bc719c4-459f-3d8-7ed-b1e1adf158@inria.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::20) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|PH0PR11MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e035b6b-6e23-40af-3865-08dbcfac698e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBgT7c15v64pX5qlAdYDsl7dXqRyHcWT+guyKLoP/XRE+PdphGZsYTpOJtzs/4PN0YImoQagdfHrVK4t3ouEQefSqi9RLf2hWFslKiLosmWKLHDySePfhTm1YWFJ5Vrgc7JV9guWoq0ylq9EmJxDL/fAmU+aQYEVAZOWmlXi9SgCOGO84K+c488kC1eVYNSVg4oW+pz7VnVP+CYXLPMarW9TL6RAMGkj/owojiwP20EK4tvHmFJ/t2mQbsYgEffXS4kHTy7R3hSIyA/hPYzGDkGuCkfbcgteTselSu6uSIaeHgMhg8KG0dO/130q3nP7+XI/+ZnI7chwA84vSb+Sd5dtcPeO9noqFXmbbDdKvey3Iw5tQchhhF5FvCLXCQ89TvGtfem+SIZhdD2Wtm8M9mXAgIxjcNsEKfwstCjik8j2RmfEoVBy0FmzKphsELmurc43WBbU+cIuCUhw3RVF/Sk1YSz97KefblVDERW34Jj0ejcSTuyuiKkElJXjSnwzgbBizNgNGd1HKFKzAZqdKsLk9InNgzSMiWKe2GSkk+8zFIq3bRnXTSzkHg7h7xrEO7hyFP3EV8TZ8OAosBGa0gEYNVva1jYYUI/Xpr84hBADtPqNs1ITE5Grb4IwttkJHFG0lo2AnNIsGC5RKg1A/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(316002)(6916009)(54906003)(66556008)(41300700001)(66476007)(44832011)(36756003)(66946007)(2906002)(86362001)(31696002)(38100700002)(82960400001)(4326008)(8936002)(8676002)(5660300002)(31686004)(6512007)(36916002)(6506007)(53546011)(83380400001)(2616005)(26005)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEZyS3NJVHYrK0hRSGFES1RFejE0M0pQMURqVzBxOXZLb0h1UjRDY3lRbTFl?=
 =?utf-8?B?Ni9uZGdyRWRlZDMxaHpKLzV2QnZkYzZUSVJuTlZpZHNJT0h2Q2IvZEhKR0JG?=
 =?utf-8?B?OCt5S1JxUUZoVG5BdFVJSVNtWGVTNVIzbDgzb2hJT1lrUno2aTBheUpFaXRn?=
 =?utf-8?B?eTEvcFIwQ0NpWUxoVzYrR0Z2TFVjdFh1VGNZTnFuV3E1VmdXbkRtdjNrN0FE?=
 =?utf-8?B?TlNwaUZ6RmJ0MXk3VTdmdi8ya1hSNFZyc200TVFjZWMvSTQyYmVEamRhQUs1?=
 =?utf-8?B?RzZnQW9sS1JCQndXOXlsYjRwNW1lS0FUSUNBeW8raklYeDhtTFZ3aUQ4dFI0?=
 =?utf-8?B?cVVvSDYzMllTNllPYjE4V1lPQ051dWgzTUdKVmM1SkRoRTFkSjRvY2JMWXJ5?=
 =?utf-8?B?RHBMdmI1YlQwbi9BQ29OUE10bkhseFJTS2JjV1NmQUJjekNCZGJiT1R2MHlw?=
 =?utf-8?B?VjhBTEI1STZmUXVrenJ4U1NVdlpIS20xdnl4SFFaZ04rV3ZDa0R1Tll3bzhR?=
 =?utf-8?B?K1NXdGpEQ2dOZkZGQVdoSVYvVWthVEk3bm9aaEFLMGcveEg5VDNzYWl6YXVv?=
 =?utf-8?B?MGRySFhjbkFoY0x3RjlNNUlzUjh4YWRGSkM0SWwvRzl0RTl2TnNwdEtsZnFP?=
 =?utf-8?B?SUJDNWMzM04yZGFGa2M3S1UrYVVtYVZqMEdtUnVaR3hPS1BtcWNPS3RGTXQ2?=
 =?utf-8?B?TktMVVJ0OWNuY2lUdm8xSkFSMHNLMk42R21Scm1hQ1N3V25ERWhGeVdqOWNZ?=
 =?utf-8?B?RjJ0aElIM0hxTUhxVGRQY0VyZytqU1NHY0JrZU1rbVlmRnpFUzdCd0NqNGhV?=
 =?utf-8?B?Z0w2a1Q4b0dOZEFRTnlsNFpNMDAwU1gzc0xNVzdHa2ZFQnpFZEo3SEl4TmdJ?=
 =?utf-8?B?MFhlZWVQZkxRNUJzMTBTNjFUNEVGQjZDblRrL2FaczlEblNVNzE3YU5JVldX?=
 =?utf-8?B?V0hoOTMrS0pZS1VTU1ZmNlIwSU91eDJrVm1WQlVyRkZKUElBRi9aRlV5aE9T?=
 =?utf-8?B?Mnk1aWVVTWVMQ2NKL3pxd240NjVNK2hmQWNrVlJqbmh4T2h5U3hJeHI0aUVa?=
 =?utf-8?B?cmIxd1N0VUIydk9BZE5pVGJ0MXdaRUNmK2UxNWd3T2ZwdlpyUzBnQUV3UU15?=
 =?utf-8?B?Q0FOb1BKcmJzWHZ0MmRqaEdHSDQ5U2w5bVZ1ZWZ5emlGRXd0RDZQTWw0VEtF?=
 =?utf-8?B?a090OVhSQmNHRUlWaTVOVTZVNkVncFF4bTRvYWN2cmFoc0tDZU1JV1YxcEta?=
 =?utf-8?B?Vko5QkY5dTZJUHhOV1picmpGNkhoUGoycXdGMWNEWjE0MVRwNnVlM3MvQTU3?=
 =?utf-8?B?emxVSlBmVHY4YXZmSXk2c0l1dDErS0tkSXl0RzFxSWxrcEZ5YW9vV1g0YVI0?=
 =?utf-8?B?MGtzT3lzRlQ1K1hEalduU1E0V2Q1TXN2cUdMV1Z3Nmpyd2J2T0lOU2t0bVpV?=
 =?utf-8?B?cG5hT0pDSWJQTmZMSE1mSFBUQkdNbEJuaWlSNW1CblhuOFpHNDJaNThFQWhh?=
 =?utf-8?B?QVBRUHBqcjZBUjZpbWl6K2ljQ2Q2OVFWWm1pVXR0MGdVcEh1YS96YWFJbFBN?=
 =?utf-8?B?SGUxbzBFZUd4dlVYSDB1bGZ6bUJ3QVpmQmdLcVRrUG5lZG52dnQrM081dy9y?=
 =?utf-8?B?YS9PTWx0ZnA2d1MyYlpUK2hqMmdzQTk1bzFKbnp2a2REMGd5cUROSXUxeEJ5?=
 =?utf-8?B?RE1wWjlrOHNhN245V21mRzB3VEJYYjJlNm10YmVMdjh0ditKemtGYm02SVAr?=
 =?utf-8?B?QWRpa3ZaYjd3QlR3WlNaVHkyd0hzWWRDbzByNUZDU1UwTmJvUm5jZVpabHRw?=
 =?utf-8?B?N1BxbE1kaDBLSjQ3SzBvdTJ1YUtEM3ZYUzFqcGsvT2Q1NWJaandKQnlXQzdr?=
 =?utf-8?B?QWZoVEpMWGRsRnNSdEx2aHdMcEdEdlVydGF0bEUxNXRmYlNvRzVPZ0dxOVpo?=
 =?utf-8?B?dWhNYnduWHNwMURReVRZUGtoTStteVBIRXR4YzVmSHFGUW5wdkVqOWh1WmhM?=
 =?utf-8?B?WUxieFh4dUxYU1VQQkZJQ3cvOHBXbzJWeGk5ejgzMmpVTS9Nam9RTEZnaDU3?=
 =?utf-8?B?UFhFTWF1MTh2blRHQkRCdm1EOFVyUjZRS3pDZnVjQzVxbUVFZ0EvRDVPbk9I?=
 =?utf-8?B?OXFIaEJHc0lETURpU3ZrVzRybVZWVkFwSXpYejZmbk1MTjNYTkZDOXdwamdy?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e035b6b-6e23-40af-3865-08dbcfac698e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 07:32:41.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+ARoHBBmAJ9eryE8Mqef/nq66P/K4LCBkxjgW0no198+DzosDpNBNYLjpTiuUDJxaRumToy4hGeTrrijRsykLHV8hEIucYuh+HM+ImxabQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.2023 09:03, Julia Lawall wrote:
> 
> 
> On Tue, 17 Oct 2023, kenechukwu maduechesi wrote:
> 
>> Replace udelay() with usleep_range() for more precise delay handling.
>>
>> Reported by checkpatch:
>>
>> CHECK: usleep_range is preferred over udelay
> 
> This message is typically not a good candidate for outreachy patches,
> because you need access to the device to be sure that any change is
> correct.

Could we add a paragraph on how to pick good checkpatch.pl error to fix 
to the Outreachyfirstpatch docs? This could go to "Find a driver to 
clean up" section, for example.

All the best,
Karolina

> 
> julia
> 
>>
>> Signed-off-by: kenechukwu maduechesi <maduechesik@gmail.com>
>> ---
>>   drivers/staging/rts5208/sd.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
>> index 74c4f476b3a4..059f99b0a727 100644
>> --- a/drivers/staging/rts5208/sd.c
>> +++ b/drivers/staging/rts5208/sd.c
>> @@ -865,7 +865,7 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
>>   						     PHASE_CHANGE);
>>   			if (retval)
>>   				return retval;
>> -			udelay(50);
>> +			usleep_range(50);
>>   			retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
>>   						     PHASE_CHANGE |
>>   						     PHASE_NOT_RESET |
>> @@ -877,14 +877,14 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
>>   						     CHANGE_CLK, CHANGE_CLK);
>>   			if (retval)
>>   				return retval;
>> -			udelay(50);
>> +			usleep_range(50);
>>   			retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
>>   						     PHASE_NOT_RESET |
>>   						     sample_point);
>>   			if (retval)
>>   				return retval;
>>   		}
>> -		udelay(100);
>> +		usleep_range(100);
>>
>>   		rtsx_init_cmd(chip);
>>   		rtsx_add_cmd(chip, WRITE_REG_CMD, SD_DCMPS_CTL, DCMPS_CHANGE,
>> @@ -918,7 +918,7 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
>>   				return retval;
>>   		}
>>
>> -		udelay(50);
>> +		usleep_range(50);
>>   	}
>>
>>   	retval = rtsx_write_register(chip, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
>> @@ -1416,7 +1416,7 @@ static int sd_wait_data_idle(struct rtsx_chip *chip)
>>   			retval = STATUS_SUCCESS;
>>   			break;
>>   		}
>> -		udelay(100);
>> +		usleep_range(100);
>>   	}
>>   	dev_dbg(rtsx_dev(chip), "SD_DATA_STATE: 0x%02x\n", val);
>>
>> --
>> 2.25.1
>>
>>
>>
> 
