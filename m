Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0826178DE49
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbjH3TAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344009AbjH3R5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:57:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC49B193;
        Wed, 30 Aug 2023 10:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693418230; x=1724954230;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qyGeGPU9mGAvruqmB0cdhRtrOjhf1i3sOWdPH/CPM9U=;
  b=FyV4ugXOEyrsM8zes/8V6v9fRTfMEoT5nHcTDTWXkxolJNNqgAOG55hh
   nUEbBkCOpx6tRYm4icVmPLW3HJ6mPISrzqpB+DnLvdgGERmSvDNcs7BW/
   g/Ttv/w4Zf7lRdj1rro1HZ434Bbg0v5RUjmfCI45Pb/FmRbKYBPyxE8vn
   mb20VgfDYGw/q12GbX77u9+MXMhn5MQRSg4XCMq39G2FgBGgYMuFC3aHJ
   I3F38A3pjPmoptHDql49mwWDGnifGsP1JXXkzuCvboWkFz9G/JMI6DqTA
   OUzq0MQYFvFMFDrFLBof9sRhmfkQVthJcIuKQ2Gd4ps7c8PQ43Cuyo5r5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="462088156"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="462088156"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 10:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="739173056"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="739173056"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2023 10:57:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 10:57:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 10:57:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 10:57:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 10:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwQaxsjO3yZozQdgxz1dbvi/mgTIEFBQAXII1g1OiF4hbeZEuB92XCKJIbzcTWhz/wuWsNom81XKyN1R37uItyi9SNenWCuKw6Rc9PXhSjMXZRrpeaH70ESaMARwEiqV6dTXgTIXf4MSYmaCmbdTZH9s9wPSiVpOpFuneKA3kdGpljfxXwbUFLJKnqjeIlLk9Az3g4xCcTuFAlXRoYVYI7ciJl7IZnsQH6JtfUh486Bropt9RQA8B1RjUCC9IkY703SufKoKjtclSrgAZL1ahjHjQjDJq3mg6Uv3YwaQd3j1ua8ZH0LMjQYdz7psvzBKnHW2pKUlgquLlYVc3IreiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkNYOFoS1dir0APkzu/LTiPjTSFT+1Kne1W/mPANsCo=;
 b=OZGU7tkgsGEOb3J3tXsFIgxNQyEjO2t7D2Vs+yBFmEOQLuswyxtF373qkZxx87VrWiOxEqqU2Ju/6lwLLofBejs2mUHn/ctXDwped6lrRADpAPCuEpg9UfaprOSqtOckPmS8UomQZubZVj0JQ3VXwTnokLkKVOdWLAAa+8ngMvhLtzrK6PTHiC6NXTWWPpPEm+vjxvkNupF1GhEMCxkxKpE8f0fhRW2t39ScjuB8cQTx6rxG2ttQkzgpHG/NEOK/tp+aIT5LlJsuEy8lG0GoBtZ5ZclpD53A/t3foOQ9eQqx/qY+EmT69SZaegJ0EaFdy6OTfxxd4t83J04LkWTyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6712.namprd11.prod.outlook.com (2603:10b6:806:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 17:57:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 17:56:59 +0000
Message-ID: <b48d2489-a5af-d9af-08e6-cbc2d5d8194f@intel.com>
Date:   Wed, 30 Aug 2023 10:56:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v8 5/8] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-6-babu.moger@amd.com>
 <343d12e8-9934-9194-cadd-7d133567396c@intel.com>
 <54236122-55d8-fd4a-1791-e6f96a61e3f0@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <54236122-55d8-fd4a-1791-e6f96a61e3f0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: abf83b76-c083-4973-6c70-08dba9828219
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DiziPyze8MPGs80fdlC9zTK0BFlB/tIU6c/fnRGFcI8DAL40ZDnWqzCk8QYrC2s6tPgYUVUYhmAXO1pZJdTQE+CKWUXnBSWguLBTgSCotucq0+MfpQGhZU+PWQpo3833wlxs7tvPMQnNJ7QaO10mdvtohmS8R4vtZ+XDlGgNxw8xi6LO7pMLVGRKgv3XPYtAiURN1iTp/Z3F+LJbzHEKcUrr3oX51KAHDGReEPKALZpRoGgoJToftf3WpNoOEhrqZolvT+2t+taMDXNlI0evp44AYfgJP8eUyMHtsdy29Dauta30CI5ncv1UttIj1GE/HVmDPubhAV0xYZKF6TzSyozRs2RP6nv4Eka+5QYKaA4Pce+uh3eTcdldey2iS1/mFMdTx84HYryplHHz6MdQuDJSzfNQdS2gYLBxdTCCWBbw7bx1jYl0mRtLG/qrGY9p8H51BjX2SmBLSNet8a7sUbJM2Z8asdAvL3AWpnPQpUihIYeFcBrQkEq79XkFlRno28d+3UMSMJXQqyAPNv5iFkU3xvON9MKGe6pETrLJhGj4DiEKhMX2nXXWITog5JZ7uCS7ch6nyCzwwLZcigolRcvg2y8BlL+a63YdoqgLZkxSnFh3EF4IY8PDZy8CgSkeWZv6P3ZV0dIpX5WyXafvsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(1800799009)(451199024)(186009)(36756003)(31686004)(7416002)(8676002)(5660300002)(31696002)(86362001)(7406005)(41300700001)(44832011)(4326008)(8936002)(53546011)(26005)(6666004)(6486002)(2616005)(6506007)(6512007)(478600001)(2906002)(38100700002)(66946007)(66476007)(66556008)(316002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K09zQitxc1p1c3gwamN0bmJpTjN5ODJWQ1ZPb01seEloYjVlbG1zdHkrQU5S?=
 =?utf-8?B?T1J1Z21zS2R2ZzNTcHBNN2JWQmNkbThMdlh6TUpXaERSczY2ZXRUN1VyT3ZP?=
 =?utf-8?B?TStKcGR5RzNwa3U0TG9xN29TMkJpWk5JVDhobmZhWFlHRUdwdDlRVU9GeGpp?=
 =?utf-8?B?cGQwSTNXMWZhZzV5aC9lclE3aXZOSWN4bXZqaDc1SS9Zc3ljRVdDNHMrNEVC?=
 =?utf-8?B?ZEQxOGpFUk8xOThLZUMwWTN3MlEvZk5rWVdKTUNBTkpiQW44SU1pdStOc3V0?=
 =?utf-8?B?Mnkwb2FHNitVSHdJa05YSFU4SjRrQjBta0o1VE83OGFudFJLRWtPdnpvYUxy?=
 =?utf-8?B?bWF5QlNpSjlPYmt6SlpsdzRTdTQ2Ylh2akFQSXkydDVqWm1XdkdCTDhvc0NU?=
 =?utf-8?B?WE1zdFd3UDlHamJDUDByZmhqaGhJL2dONVlKVXN5clRjeTQ5RytjRVc5cEJu?=
 =?utf-8?B?WlZ2ZTQ4SlBLRE1acG5lSFg0YlVMQk4ydUlacXdXYmxlNkF6SkpURkg3bi9s?=
 =?utf-8?B?bFVYSmVPR1JyZVdvS1g2N0I2dWphMCsyN2RaS3REcUJ3Q1VzVkVYcUpXMlUz?=
 =?utf-8?B?WC9NTHFnSmM3alZpM2VNMjdIWFVIdVY5V2dsdmZTRDc0ZDl1a1RPWUIvVDh6?=
 =?utf-8?B?QTBvcHlEWXZyamV4RGZ2SjBuNDVHeUN4R01SZDg2MjFPK3hvMEp2SnpEVVFT?=
 =?utf-8?B?Tnd1RXJRS0RQbGgvYWE5eFpEOXU0bndWSnpXOTZDNVkxNDRoMUlSdzNGQVMx?=
 =?utf-8?B?Y0FpZjNFMVJZQ0JtYXpLVTNjcEtHaXhzZFVXOVhXdkZ2anh4ZWRscUUySEFC?=
 =?utf-8?B?Rnd2b09KVFNoakJLNVFibWdvV0RCSmgyWXFEU3hwZHRvTC9KR2Z1MzJYL2R0?=
 =?utf-8?B?eHZTYTRRamVtRW9vWWFwaFQ4UDhlRXBSakR1V2NwSkh5NytUL2xvWkcyT01H?=
 =?utf-8?B?SlZjTUh2QzUvRVlhdFJYajV4VHpWSFR6bjZUMCtRMjdTYytEQ2Z0SEQwK21M?=
 =?utf-8?B?dHFTWFJxdDNKYVlrWVhGWHhsYUgrcXRTNDJicEord3dxbDVYOXFxQkwwODNN?=
 =?utf-8?B?cGtjajBPSGpmTVpST3dBWDFUaHhDU3IybWFNNXB4YmFsdnVzTURGVTIvWVBs?=
 =?utf-8?B?eEFId0d0cm5yekZWazlXZ2JTNWZlODNaQ1FNRFRzdTIybmZwUVZTZ2s1eWsv?=
 =?utf-8?B?MUNrZ3VUakk4T0dvcmFuSnRrb2F6dWw2Vk9IQnpBRVJHQ1BRWTVZVm8weG54?=
 =?utf-8?B?S1l4L2NhQUxHU0pCd0orYTB0bVFjVlpQRng0bUkxeXNkRTVLVGZMOHJXVFhD?=
 =?utf-8?B?VlJESzlyTHBodW9QQlZDaHp1NXBiSDNrZUNNcnU4ajRGaGMvRVVYYnp4YUMz?=
 =?utf-8?B?aU9ZVVU5NGhFODl6OWFvU0twWlM3VllVYWxmVzF2UXF1N2t6WlhKajZuR1p4?=
 =?utf-8?B?NncreVllYUdLOFVEa2VUOVlVS1pxWE1jdWtpUmNDaW1WVnRENDFhcGhDYmRS?=
 =?utf-8?B?clRNZHkydHZCd3hEc2kxQlFrRWFvQWRqTmhVc21YZUtCRW81d1UvcUoxY1Y4?=
 =?utf-8?B?NExMQjFIZFFLT0RtVytIYXdzaC9ibE9BWC9ZZmlGMWFEWm5IZXBkZTJZZmZK?=
 =?utf-8?B?anZ1K1ZXTkxrYklvcFNyblVkemh5TW8rZmdaTGdkdkFSUWZCUDgrNWRid0Zk?=
 =?utf-8?B?NGZ0VVppRXpLMjV3STZ0TUFxamh3MVZwcm1zeTJYdFJuZDJEOVRJSmhxZis5?=
 =?utf-8?B?SXg0M2xGeWFEeG1GVEVocU1PTE1pOWplbjBhL0Fsa1JUNWcyZTFJUUhhRk9j?=
 =?utf-8?B?VDhyZ2wwcE1JU3F0ODBZLys1Y1NPWmQ5d0hMZlk2ZnhTaW52L3dvV0gvdUkw?=
 =?utf-8?B?QThBN0kxbzFEamFRbVBUMlhRYjdGUUhlTXBOVlUxclpHeW1obFA2UXlCckNF?=
 =?utf-8?B?WnlEZ01wVUFRWFZ1MHFlaEVncmdmb1NLWEc2dS9ITlFaSS80allKYS84dGFK?=
 =?utf-8?B?WjM0VDdGTFRzQVpNQjFwTDRvMWRWQkE1eEhvK1FvanhmYjJKVmVsUkdGaHRt?=
 =?utf-8?B?clNMV3REQWZmR1BLT3JqRzR3Z0hGYTFqZEIvbzNIUll1SzROSmJmWGp2c0Ex?=
 =?utf-8?B?bVNxRFozYWlGNzNtdEp4bWd2VzJ1bGx4dW5WVFYxazJJS3o1Wktza2c5dDFC?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abf83b76-c083-4973-6c70-08dba9828219
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 17:56:59.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2z82lWGYlhFM6NAqLex8nKNdpcRrZQSnWECd+A8F63GrFw5SJ1SpoxM+GUADhKdCnP5oWwpvkcAlapsBWN497cMoEnwIm4KarndmJYOqdaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/30/2023 9:38 AM, Moger, Babu wrote:
> On 8/29/23 15:10, Reinette Chatre wrote:
>> On 8/21/2023 4:30 PM, Babu Moger wrote:
>>>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>>>  {
>>>  	int ret = 0;
>>>  
>>> -	if (ctx->enable_cdpl2)
>>> +	if (ctx->enable_cdpl2) {
>>>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
>>> +		if (ret)
>>> +			goto out_done;
>>> +	}
>>>  
>>> -	if (!ret && ctx->enable_cdpl3)
>>> +	if (ctx->enable_cdpl3) {
>>>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
>>> +		if (ret)
>>> +			goto out_cdpl2;
>>> +	}
>>>  
>>> -	if (!ret && ctx->enable_mba_mbps)
>>> +	if (ctx->enable_mba_mbps) {
>>>  		ret = set_mba_sc(true);
>>> +		if (ret)
>>> +			goto out_cdpl3;
>>
>> An error may be encountered here without CDP ever enabled or just
>> enabled for L2 or L3. I think that the error unwinding should
>> take care to not unwind an action that was not done. Considering
>> the information available I think checking either ctx->enable_...
>> or the checks used in rdt_disable_ctx() would be ok but for consistency
>> the resctrl_arch_get_cdp_enabled() checks may be most appropriate.
>>
>>> +	}
>>> +
>>> +	return 0;
>>>  
>>> +out_cdpl3:
>>
>> So here I think there should be a check. 
>> 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
>>
>>> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>>> +out_cdpl2:
>>
>> ... and here a check:
>> 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
> 
> 
> I know it does not hurt to add these checks.  But, it may be unnecessary
> considering  cdp_disable() has the check "if (r_hw->cdp_enabled)" already.
> Both are same checks. What do you think?

Yes, good point. Thank you for checking. Considering this it looks like
rdt_disable_ctx() can be simplified also by removing those CDP
enabled checks from it? Also looks like rdt_disable_ctx()-> set_mba_sc(false)
can be called unconditionally.

Reinette

