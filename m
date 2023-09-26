Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7B47AF790
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjI0AzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjI0AxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:53:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B7F93F4;
        Tue, 26 Sep 2023 15:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695766485; x=1727302485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=caz7/tC7rOobkBGGqDTpY/LDudW6QnKOwHJ6w5igPnY=;
  b=Fv+o/1ocNQoPq9CCciQcK7uddYs8eR7QO2l9sZV8q9l+IoVUFXOeTZkX
   hLECj80QU/CoJtBhKipv6IfQAJRQy3Jp1mKFBeQbmRIOVNvoBZ5MPI4Jk
   PTjc5sHcMHhj9t4G3ZrWehk28DgtjMYj2sSzow51rqBX2LR0QocOFQZrK
   vzB8bEpfDHzCJ89MEUrxFHED/eGvf74fpoi+JkDdUpZJziya+K8CUdLUh
   aLJRxUv8Ul21e0gVopD4o7/AhJOyPD6DCI/65vSDfoaBeeInPxrSf+HNp
   eOzLOe4v/+tvKkuH4PXxu9JqfCv0AGGShXBwstebmRyxjcdK4/SOrXpRh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385530720"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385530720"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 15:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778298823"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="778298823"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 15:01:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 15:01:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 15:01:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 15:01:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WV62Xu2kkz3Rww13R9byIK42teBVltobAygS2GEHA8mCn9XhW0XQFZFhEWlr/8qX1ap6vW7i4sAp9GmXQNBZ0V4ijnif4Put+gucCv9aEZ43hwfIPcrTeZZ1iiJAZaE1X8g5SH2rbQF/gbDzJqVi0Ns+l4bXKylP+EwFRFQ8fsEYWXX5QPmD2DxpvcdVEO0WgWlGcrDGCFrKqafFGoE08M4g0Ss9DX1gz3mLJ7DoqY3QfonnxSXw0zUkViVTqc98Bzha1FXASo65PkfRJ+rCgFDkECRc+zJf6v1rMgE0mou/zf2u69VxPxJPw7ctyR7d911XyR/Xqi9L/bec6YCL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4G7+LQRPzqu4vqk8t16CjMbJJin8N4ios/K6vPLFyQ=;
 b=H/PwRbbyOJF+HWm0PRk8esygBaESdCw3uzVQhrhk+//DgI84kIe3aRsJgUq0J0CF5//5CAGtURti90c41e57X1El6KK+ePiK98a8Jkd2b69SvkS856AYpVLYn+fTZXLBUcWk83XesFVYeE27EE0V532vwss0hE2EjpgrudbR9TQKLmbM7hkorhWE5Ldh7nABed0gUovqu3Lx4ePGkol2mE+U3xm0q/2xYayI978kTln0P99h1bksspuSrXSN5qADIumgqHXdhFn5g23Ve61K1ixIlweFgc/wzyCUAq11dV6b3EBdXZEX/6XMVAQYZgwSzjGjozdGERYkwBA+6BFXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5538.namprd11.prod.outlook.com (2603:10b6:610:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 22:01:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 22:01:01 +0000
Message-ID: <5b2fd31e-3cef-3c35-7d17-411cea27502a@intel.com>
Date:   Tue, 26 Sep 2023 15:00:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/8] x86/resctrl: Split the rdt_domain structure
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-4-tony.luck@intel.com>
 <5f1256d3-737e-a447-abbe-f541767b2c8f@intel.com>
 <ZRMnCFWzcxa6Qa4E@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZRMnCFWzcxa6Qa4E@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ec9a39-530f-483d-97b1-08dbbedc06a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYjdCB4QeBM+8i4KZK6KSQFrOnA6kLPxRAi3QbGsCbNN574O0Bi+BLGss141G4GnX3YYGCaH29UMF9MIMbYv38l50qzQaXWl9uC8RQrVRP3+FJK76Ljvo+0FAUyhAsc6k2WCM/8DtgexQvq0R+9rlEEl7kj5tOb0gmhEE4q3cClN4HMLE48JsS/FsjZ9zjLw1Uf4hoBC7VuoheMiD5pPIbc5jIgpLRTpwsjtsn5SGmpOLfcSC9bW0oUWt0lG/1m6XYTwnL6nljMtdA+nP6J08JKocqqypzsOKALEzIsMIbK6WUZhxrwAhvenlVPPYNVLEnnbitwW2APuCSvYM+RiopQVmdY+qnV7+jmioOTBWJ/j1bWYeguAFQhvxISzBe7HS/JgNU2Q7LSYjxe4i8FZZAM8S+N5L6aMRoV2lHyL/xzx5Am7TvBwy6ajryzFIwsSgM2sFez2becIVfjSeAVHAHWcOqO+hn+NF7N1ZRLSBL+4luSBuZvd135CdVd9JMX5uO4ir5jvr5ymYDqi40KGi1VRdpeqLuih2KbIGEUKgrl2xlYuZ+8O/krvA+ZgZQFPkfqVkgXfLsm4vrL3VLdxluOI0PS89LuJ4PZAlekd9MBePKkOS/+IIcltWPtyThO+1O53GCWKvdSZsHDhJ4ZZAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(7416002)(31686004)(2906002)(5660300002)(6862004)(8936002)(44832011)(8676002)(4326008)(66946007)(66556008)(66476007)(478600001)(6666004)(6506007)(86362001)(6486002)(53546011)(2616005)(6512007)(31696002)(316002)(6636002)(26005)(38100700002)(41300700001)(36756003)(83380400001)(37006003)(54906003)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjZKWVlnMzY1dmdxRHUxOXNpYUxra2lzS0pnaTEvYUZ0d2ZpUHNHa1l4QzEy?=
 =?utf-8?B?TktlRUFMK2Vjb1BHM2JhUDlzKzJlNm5UMGdXd1hPTmRSTmNGT2tJZXk5Rldh?=
 =?utf-8?B?ODhEQUtNazFobFhQcDRvakJQRVZqRHBVL1I3Mzc4cUJwb0JOZkRKS3BSdzcx?=
 =?utf-8?B?U1VEd1FlNnQ1b3lQelBjOHd6V01kOFdCUWFER1JadE5pb1Y1VmdDbTdrR09q?=
 =?utf-8?B?MjIwd3J5YkJRdFNPL0FlOVIyZk1yVWZPUGRQMmhHREVONEZJNmFYcU41MXhB?=
 =?utf-8?B?UTk2aWE4TWhEakhIN1dUM3hSWDJQcHpuUVRBVzJaNExEd0xhUkZkTGo0NE1y?=
 =?utf-8?B?L25UR2wrUlNUVmxRWVFpUDRPdHhmYUtwN2FtSnpibUJLYURUTXZaSjBPLzE5?=
 =?utf-8?B?eDFsVHkyaDVQWlNvNDhGUnRibXd5YnQ5YXlYUzQ4YVdBL1JHdWdiZCtKV055?=
 =?utf-8?B?UGRUSkVYaUF3OWFvZml4TlZ0L1c1SWFXbEdjZW4yTk4wVnFCeHREK0ZPN0Uz?=
 =?utf-8?B?NzZKUWg3clh4ZGNYd0ZKUm1lcUNSMVFicVVpdm1SQjYyOUkzK3NLYmc4VWd2?=
 =?utf-8?B?Z0JTZ2ZLWVpqQ05NNGw2czR2b2wwbnhlL3JDNmJ5RjJHWnAzaWUwMUx6VXJs?=
 =?utf-8?B?NFhRUnA3eGtJaFZrUFc0MlNMYXlqNFFmeHVtS3k1WG1yeXRHU3FsWFlBNm5z?=
 =?utf-8?B?SURTSXA4bnJIU3F0SzF4em42aDE1cU5QL0RXdXJ5bnh4cXVGQnZCLzhKWFo2?=
 =?utf-8?B?Wkh2TFl3eFJTVTRqOXdIZW84b0RWZHlkUHhqcVo0cTRRT2N1MzQ4Wnc2Q3Zm?=
 =?utf-8?B?Rm9uaTc5K1Z6Y003dU1XMjFld0lQQ1pDYWI1UEpXTDgvbmYzWWhkM3lYNDl4?=
 =?utf-8?B?N01VRDcrUERmcnJIRFZuLzc1S01IcHJaMTJLMm1iRGE0NnVEd1Z3TkJLRkZE?=
 =?utf-8?B?eUZ0OGlWN3VhUmVUcndjQ09OQ3FLVitqU2pkTXN0ZHE5N0VlR2lKem9NeW5v?=
 =?utf-8?B?eFFzTU5ObUw2MVo1aDg2OWpSQjRrTmovbllGK2Zrb2JkOVpGT2JmSVdJM1Ja?=
 =?utf-8?B?WFVPbHVoTzRsK3c4OXVlQ3lJSUFLL3pEc2tGSitHTE1xa0RIYWVQNTZBM2ZH?=
 =?utf-8?B?a2pySndJaElyMFk3MDM2YncrTDhRUXJOaHpvUVB5RW1XT3lXYjJOcWZYVHhx?=
 =?utf-8?B?ZE9yUlBLM0Y0QWZFWEhXTTZwWDZ0eHBjR3JWbm9iY1JQTEtGQjMxK2lMUmlo?=
 =?utf-8?B?aUI2R0dsei95KzJGQkJ4bmk0ME15QW4yRTV6bmFmTUQ3L0JoMVNZdlE1cXV3?=
 =?utf-8?B?dVd4a1BNWkVGalUrNml2ajdWNk05YUZJZGpJU01mTGZvZWF1R2VQZVFhUUww?=
 =?utf-8?B?OHBwZEdsaFBqV2M0L0dhMnRVZ3JjL1JmU0R1Q2R5VnFiLzZJVjdpSmRzdjlC?=
 =?utf-8?B?cDREVjVqaXdWRW11RGMxVng0dDh2UlZOZ2RJdmNWQzRDaHlJV2JnQTU1eC9J?=
 =?utf-8?B?Nlo2T2ZtR2VVQVVSWXc3dmFqVVJSYkpiOUdCMG5HYUVuRFJxZWVSdXQya3h0?=
 =?utf-8?B?ZUJrRDNtQ3VuWXJYL1AzTnB4cHZIR2xOaHhKcC84dk1xc29nMjNydXl5eVhS?=
 =?utf-8?B?dVBoZDBQTFlJbzQrcktla1M1SWlGTGNSSmNsVjhvUFZMTlBHaWpDY09sMy93?=
 =?utf-8?B?Z1h1cWJCSWppWUZHeHVNcnhLYnc2bktiZ0Z4OXA4dkFFUC85cnJIRHI2amZX?=
 =?utf-8?B?ZlBTMGw4NU5VeXdzRjFYY3o0QmpGenR2WmtlbGRnd2lpN2NsempTaWVRTGxX?=
 =?utf-8?B?RzRYSExqM1BncU15K3hSTGpsZEhpNVV0cFZIdndUcEpoNUk4eHJzYTN5WnNH?=
 =?utf-8?B?UFFWRm1BdVJwMjk1dlBpbWVPQW9qYy9VMytaRlJMN3VSMWNBNUlhZjJ2dDFV?=
 =?utf-8?B?WGhNb1JzdFFQVDZtUkpsbmFUdGxZYWRXZmpFYXp6RlR4bHliUU0vTENWUzY4?=
 =?utf-8?B?d2pJU2Q5VWZ5OFE5SlpmSUZYaDlGM0RXcjdrNjdFdXRpZTdBck53Q2t4anBh?=
 =?utf-8?B?aUxwRWpCbXE4M2hQV0J5TTRUUkdURHpoa2hQbjVIWElveW1ocXk2aER3djIw?=
 =?utf-8?B?L0FBK2ZSakkrRVVLMHVLVXRsTEtKMmJwMXdISy9EVVNQR0lRSkphQWo4QkdO?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ec9a39-530f-483d-97b1-08dbbedc06a9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 22:01:01.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/VQaGwDFAfaD0jZtbJaHloMYmvUkHsDAT0La064o3WZVErRc97HXenNaiodP/GOt4FVOEoRiBf4ckbbpmT+f3tXhYCtoPuQzeL9kYYGSy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5538
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 9/26/2023 11:46 AM, Tony Luck wrote:
> On Mon, Sep 25, 2023 at 04:25:15PM -0700, Reinette Chatre wrote:
>>> +struct rdt_domain {
>>> +	// First three fields must match struct rdt_mondomain below.
>>
>> Please avoid comments within declarations. Even so, could you please
>> elaborate what the above means? Why do the first three fields have to
>> match? I understand there is common code, for example, __rdt_find_domain()
>> that operated on the same members of the two structs but does that
>> require the members be in the same position in the struct?
>> I understand that a comment may be required if position in the struct
>> is important but I cannot see that it is.
> 
> [Just replying to this one point in your message to get guidance. I'll
> address all the rest in other replies]
> 
> I'm wrong about the first *three* fields ... but the first *two* fields
> (the "list" and the "id") do need to be at the same offsets in different
> structures if a common routine is going to be used to access those
> fields.
> 
> If the "id" were at offset 0x10 in the control version of the domain
> structure, and at offset 0x20 in the monitor version of the domain
> structure, there would be no hope for a common routine to access the
> "id" field when searching a list that could be either control or
> monitor domains.
> 
> I'm looking at making this far more explicit with a new patch between
> 0001 and 0002 that pulls the two fields into a common substructure that
> will be included in each of the control and monitor versions of the
> structure.
> 
> Patch included below.
> 
> But this seems like it is a lot of churn to avoid having separate
> functions to search control and monitor lists. Each a clone of
> the existing ~24 line rdt_find_domain() with just the type changed
> for the return value and the list travsersal.

Yes. Sorry, I did not realize this implication during the earlier
discussions.

> 
> What do you think?
> 

It sounds to me as though you are advocating for open coding 
rdt_find_ctrl_domain() and rdt_find_mon_domain()? That sounds good
to me.

Sorry for the noise.

Reinette
