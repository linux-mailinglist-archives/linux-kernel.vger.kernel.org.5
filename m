Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D2877E95E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345695AbjHPTIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345740AbjHPTH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:07:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFEF2705;
        Wed, 16 Aug 2023 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692212875; x=1723748875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tM/E8hcsmjfm0Vkji4kG0md2az7FeqpLqsvOHx7Vjyw=;
  b=nda751YIwMs7fUN09rGVGt0qwTyIg3o1tJcJpt9apHQWSc8jgnYMtohk
   KDdC/dKuscO/2BNioVcsCjhHfUSeTqyjOhBEmWIkOmgiQUr0fe/oeRj5/
   Pb9ejeWTLlApbOoUygAO83B0PtnhgQ87eec89ke89/t6+lsrpZAhCyiuR
   lP6UQSaqrrVB3uQqV6pz+gd81TCZpvwHf5JXWD08d0IpghMLEwc4zT4ie
   wefiUulmSp34VVvjO1Dln4stxyNd1u1zkoPLWk6agMzgaOrKSOsd91VVk
   YtcTJfYXIsokXdOSy3tbkeHAH1zy7ix+ZxcAFFEzh99/tbKBKEvki47e4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357585470"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="357585470"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 12:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980833693"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980833693"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 12:07:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 12:07:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 12:07:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 12:07:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZYD/w9nBGaB4AJe9OPZLUCxXUdxdKyK9aoshy/zrv9foBknShsJWd/qsxFoWN6pTQyo64J+AToFPK/aF6OuWosTFTLPD+a5WqR5s5PqhW6UX4Hf2xJdcZoiRGyMn3Ddq+jx81hi+3KLgNK9tdrPykSqEPXGVw2J7Ibz05Z7aKzqBzTeTPPP912KDz5kg+7RQ5cZXu4G9NTuNxxiGPo9Vj+cU5v5AjihUod6M4+SNq7lXUU3qSfFnqGdFlzST26vd120Pol0zgKMWcFXQe3CVYgxrR1ODKfdeUXOeNuk3S2UL8g6Q6xnWsN5rU88cAJkh66zwqz24amVA7sdNcm+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAt3J8etU6SowibViAQOrvIN8LvoYadhAN9mBcC+FAw=;
 b=GGLoc2zvRLL8tZZHCAMO/HpLV7c0RFTmFuREVhMjlyHnvNawGZWCIyg2PIh5kko4F5/G7Zi8bY6shZraRwFLnx70K9DetfnVwMNl2SQ6vaSqvtKgLUUZn7SkZnyaXLESon3Feb6hooXuig6Kqf5AC3qPTanosH/G50cCqD7gGOvDDoyA8dtNJPfDqKFrXIJReDNeUswxaansnXaYEvW1DENe1SJw/tSZPWGWPMUVXre+eqbyXf4OeO+aI20ivBdUYGHWW8s3RkoKDa2nmwx+/HSGc74A26nv02uLhJ2MjSog6BPhrDidxZxF7EQCxdOYzBqjPN2BLM9tvRNq1pqiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7073.namprd11.prod.outlook.com (2603:10b6:510:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.23; Wed, 16 Aug
 2023 19:07:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 19:07:48 +0000
Message-ID: <a8a9bfc6-1574-1a75-7cae-87e5349e94e5@intel.com>
Date:   Wed, 16 Aug 2023 12:07:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 5/8] x86/resctrl: Unwind the errors inside
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
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178459367.1147205.14975628669652538089.stgit@bmoger-ubuntu>
 <42d034d1-1fed-8d3f-a2aa-b9dcc5ea1243@intel.com>
 <1178bf68-f355-1509-0849-b740d2906bae@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1178bf68-f355-1509-0849-b740d2906bae@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 573d7fc2-1074-41fc-6f64-08db9e8c1493
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PL8TTSWLWxekLlkIFxWy5PBRWcHs8IpQc3QMVz6e46QvOh2STXeTfSydDiHKJtILL0FTXa62w/mStnFnFZ67uiToE6qe5xJV5Spk0Wrl0g6Wz9VN2uHkUiDcdSyTkFvtxEEhqFRc/7cv4q48ncrS3C75QiZ9YHPdBkCte73YN1xFaifdS8A5ngSa0xlvdd0+qn6JfK7ZpU/VIFGw9CRWloQFpmqe/SgkcrSAu31oUT2r8oHJuE8oPAZCJ9xwkKQBO8ofZUSpsSVMPbrgcyHjjWjSTZSIV/i6IB6COGiFodWkw2pFncNjJTXIgdRIswevPcA4uyYEtyDiGgcRrUnPRPkVBcPeZ4gBz5LqVN2W+2kphowg6MGMEOmKDIWJwb6VUQ4rtIK3QuDOKeKVcoHV2fGmH1y5oGy755IY4SLSdSaZ2eOFZuz5h9J4JKjzEBnqD5bgtJ0LvxpEPAgUt6yCTMVyw+nqt8tTgtZhm2S92A7b96qJx5iEtm+aEws4XfKKzYbM2+G8mUNdpxoh7Ykmxbs/BvaXGk5t+/b7u2zW4ZEg9TE1fbbQbrWiM6wTJvD0oRD4A0ocPnyg33G8Yz3vnE5q+eiDwRMa2m3t6xTp/exp2F/CnDd7OVuanOR9to2jPQy+/bOfigx0GIrDGlXNBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(66946007)(66556008)(66476007)(5660300002)(41300700001)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(82960400001)(2906002)(4744005)(83380400001)(26005)(478600001)(7406005)(7416002)(86362001)(53546011)(6512007)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRYSDRWZXNNV0g5VzN2UmNFSDVGSFFtS09hTUxwOFF3UkQ0UGZqL2E3emVZ?=
 =?utf-8?B?Z2tPR0pFYjlsTVlwK1AwR2pjbmpzTDRVQUUvZFZSSXg3dG1IVFdwWFVoRk1m?=
 =?utf-8?B?KzRsU1J1YU5CcW5YQTdJNGVodVhHSUU0QVk4S3hyOE9PaEliSkJQdXJVUEU2?=
 =?utf-8?B?ZE5ZZzFjZUZGMm1QZ01TMDFuZ1Y0SDQvNTlyVFNqUWdIbThRSTMrcksvcjlz?=
 =?utf-8?B?c0cxdm50Uzk4WXhHSHpSa1BTcXd6OFNLVVNKK1FKSDhhdmxJck5KWEpWR0VM?=
 =?utf-8?B?TXptQkxPT09saXplMmZPOTAwZGFyc0Rtcjh5OUl6Ky8wSnpSc3N2M3V6V3FB?=
 =?utf-8?B?NFJ2ZWpYYVI3Z3VObDVFMnFQNkU3NisyRmRtWlprWnN4MU84OEFtNnhRclpB?=
 =?utf-8?B?bmZJMHlIQk54MERBNkFWREQyUWRhNXBOTHN6ZldtWEgyZVp5QXk3Q042NWNL?=
 =?utf-8?B?RGZJKzgwLzFVOEtkdjFNeDY4azl1UnpnbkZ1K2l0eFlYYyswQmV4eFpsY01J?=
 =?utf-8?B?K0NZd013LzhjN1FaREQ2YW92OVJTZ3RVSC9McnNkU09nZldBV2lKRXBLdkdo?=
 =?utf-8?B?TVNKUS9qS0ROcFJLWnVVci9veFE2UDhJOGlocGN2WCtUTkladlBUallCdTk4?=
 =?utf-8?B?dG1PTHI4UGQrNmFQQzhHem1uOVkvRUlLOHBsc1hXeXdHdXRLTkhDWHYzQ2py?=
 =?utf-8?B?aHIzbDFMZy9Obk9hR3psMXRJRTZ6aWRxSFh0OWIzY280ek9rRWtuS0V5cXZN?=
 =?utf-8?B?SFprSEFheWpoUmxjR3ZlcWdoNTN0eGp1dXVuNzBsSFVGd1BONzZOZWgwcW9B?=
 =?utf-8?B?ZzBpUVFFTnlnbjBzd2MyQjRVM0hoZFlqdStpWkhMUUkvZnpHRkJGNElsZi9E?=
 =?utf-8?B?Q3pEcmhDdzk5Y3NzZHhFUWZ5amxvalZJMDZ5YW03TWhZWUtWZE5takJ5SmxF?=
 =?utf-8?B?TjMybW9HRjhoMEQwbzRocXZLZGhSOTNwWFlvM1RtK0V6NkpnOXNFd0NqYXg4?=
 =?utf-8?B?eHE5aHB0ZTRFZnAvSjM4Q2NPMXVyTGpQMWxpams5Vi9RY0dtZDJVclZQVk9M?=
 =?utf-8?B?cHhqU1lIbEJmRWdOcC9uUkNOU1ltOUhuK25nODFmRXVMdHpsTStpdXFwSjNS?=
 =?utf-8?B?SDlKUzkzK05ody9pNkM5UnhRc1V2RlBrWVE0TGVFM3JQUjJBdUJQSzhUZTNm?=
 =?utf-8?B?YVJQcUl4MDBrakFwc3pkWlQ2SFZEenQwNENVQnBzRnl6WmNIRERFelpiRWNK?=
 =?utf-8?B?MCtIblhlYXFucHIvejZUVzhHdXhvd3JaOVdyc2d1d3FUTTJyUTcrWTRaYzlS?=
 =?utf-8?B?czlYbFpUK0s1b0NOcmVOeGY1NkY4SFByQ0NXNjRzbzQ5UVlVeS96QWdGNHI1?=
 =?utf-8?B?M1RTUldqSnU0eUNraDk5TVhOQW55M1I4TFc4ZzM0bEZlUldHTWU1MlgrL2xO?=
 =?utf-8?B?d1dPMnNoQVBMc1JSaGZFbElFUWtERWJBMmN3b3A5dXZtd3h6L3VVRjRyUGdK?=
 =?utf-8?B?eUVJRmdaeVMrTWM0UjE5a2tBTHl1aERFaDJEV3hCL1MyQUQ4TXlZUWJCeHFF?=
 =?utf-8?B?MFhaaDRnK0VZaW9VRWxFMlI5VUNhMTFPZHZwR29NUndXSGtxczFaa0x5ZWZG?=
 =?utf-8?B?Q2ltWHlLTThrQTFzZHpoVitUUHNVZXNjeHBjOTRwL2d5TVpQYzZpdE5SMlo3?=
 =?utf-8?B?SE5iWU9EVy92WVdoSXliNFBNNGw5UWpnUGxEbXkrMHlhZ3MrZXNLdWcwY0xU?=
 =?utf-8?B?Z2pqSE5mVTJsRUFPWFFIR2gxWW56NW8rbUJoQm8wamkwc1NDQnFZVGtZNmtE?=
 =?utf-8?B?SjkrSVFYUFBXM3AwSkMvY3EyV0VMNjlFVHhNYTdqQjJOQ1BoeG96emVXenRs?=
 =?utf-8?B?eTA3N2pEQ2hsUGRZN2lzOGJmMW4ySmVGRXZ3L1hvODd5bFVrMTFmU2JyU2Vs?=
 =?utf-8?B?N3hlbXBCZ1FuTGYvMndxcXVzd0pvZnhUTnJ3Vm9jR0FnTFRxTXA1NzlUZmhX?=
 =?utf-8?B?S25UcCs5KzUvU2RxNDdsb2s0WG9YUUQrQ0txdVd1VGFMM3Mwcyt5WGwyQkRy?=
 =?utf-8?B?aVgwQmpLZFJ1UWk5R0dMYjFOTGV4NDlpTUJ5d25rRXhPdzVSUzhMVytmY0VI?=
 =?utf-8?B?YURwUWdRQXJ0dDBUQ2poUmNNSkxMNERQSngxYjVDYSsxZnlYb3hZcnhPQzNV?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 573d7fc2-1074-41fc-6f64-08db9e8c1493
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 19:07:48.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ac4kEFxHw1F0CpwqAGommXF+UKVvdmzkBv1Ty3qAxCKaa23lCqJ6O/Gju060uBBbE0lpSy/rvIyakS4GZ22qVOMnlIXA6oB7LrC83Dl6bxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7073
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/16/2023 11:17 AM, Moger, Babu wrote:
> At rdt_kill_sb() the fs context is already freed. But, we can call
> rdt_disable_ctx() with no parameter. We will have to depend on other
> parameters to free the enabled features. We can use the same call both in
> rdt_get_tree() (the failure path above)  and in rdt_kill_sb().
> 
> The function rdt_disable_ctx will look like this.
> 
> +static void rdt_disable_ctx(void)
> +{
> +       if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
> +               resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> +
> +       if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
> +               resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> +
> +       if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
> +               set_mba_sc(false);
> +}
> 
> 

This looks good to me. I think this will end up making
cdp_disable_all() unused so it may be candidate for removal as part
of this change.

Reinette
