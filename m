Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0717709F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjHDUnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHDUnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:43:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A984C3B;
        Fri,  4 Aug 2023 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691181784; x=1722717784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YttPd2HaE66vzdeoxJTwJK+ofxeucL4fxAtyTnjA0oc=;
  b=Qn/yOyphezbCYpDvxHBoDVJPLM9bFHBsTXRTdvi0aH/DGgDCkV+ewYSx
   TYY9oeAw6nEB/eNzUyWZutJWonaAgFLq4jJa22pBz+vNYvLkb9ulL0Go/
   Aw3qeBhRdiv1a6llbHi/u6OLz4zgrD6ynOXYC149NdOkZE3YImslKdPLL
   hvfJJ1/P8XPD2+AbtO377sMf9+EzJlRE8+beQbNE4kXUmE3sVgTTcGUzW
   fdseZ4tyYdSgQLgK+Kts7GHRjyArEKjBXE167yfSTjA9vmLMQ1OuzvFED
   JsKZ7GpA3/b/mKE6qS+5QT49OlrFlFIK7iorDXnHuDFyfhSwZEPyDrXWb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373896742"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="373896742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 13:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759705465"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="759705465"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2023 13:43:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 13:43:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 13:43:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 13:43:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDb3Y1QK/zRDlYr+r5Udk6zkbEOPv+jLaC7KfQn448IGfKD6FqoNsTPKjRet38kKgZwBeG3Ny58xM8XnsHXTJtxJkCiwyvp8QPudlvhUG2gSTiaPMgJ8eFRs3oEZISiJZYFwCMNHDsB0UiAozVkzkxfCzd15HX88z0OBbYBGvNL4RqQMF/5ONBu9P+P/chZA8xcOgTFt0Xbo4XMb3Vv9otmOpVX9ifGyRXxZWjnAZWwYbfIeq526BBGca/mfsf8eJW0+XK+qrNIBT27LbuomoDVFIwYDe3yaT7Uymx2R4m4XlCsMdp2ORGfkZuZ7WQXQTeIBWScyQr1rJgH1vEBWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQwtxoClcfF+1t7Nos6SdG0SfzonLALEfw4CaqebJO4=;
 b=Uo9KlbKpgUSFD9XkjZlEnc1fXtbdOF1eXtYsZQnqy+E5vbDvA7UEhohh4gurlqCCFCO9ZrZbIGF8I8u+qK5zwghjuXHXygsyyGaIe612WXy2yr2ePVJnkFjdigMPqMjKEEiYGRcjcaFatFo6zQAls0wSxx/PZxBd+URL8/HmEMkWXvfb40u3sN7Du3j3abuPxtvCDafx2MeaF1PMIf3mShWIgLjOR6LQhycoRFWBfc9jpmdL7DGB5DqiNp5BH2HwmZokpG9s5V3HmtSTPYnpHM/xitVQqssfMgDVJdjgSzCcry1kDlP5fIFH0xIfiFXMHighu1visv28EIzRO8lBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 20:42:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 20:42:52 +0000
Message-ID: <68d6d4a4-80e4-2aa5-409f-0e2744c20e88@intel.com>
Date:   Fri, 4 Aug 2023 13:42:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v6 7/8] x86/resctrl: Introduce "-o debug" mount option
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
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
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
 <168980893967.1619861.7249871216790436466.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168980893967.1619861.7249871216790436466.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:303:86::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b1ca22-3474-4c8f-ca1b-08db952b5f8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dMppbD2sBf5sKKblWHbYTMzz24AXXheshUVdlETpVpIQG4IMYndWkFRwkUmh3q7Kh6M6g9cbEtAgtSV3U77Z9r5XmylvtBrHF7iRHooL1qIPHRWWYmt73VkMsLUeo9qEH0AR14fweAdDNlz//tOXbangWphuJQgYGNQYE7+6ZW6GKSnhS7x0Y9Duw28bzGYMkfgfKMSKFImHTnRKlbw3w2yN0ihZRJcG5fc8jbhmOyCv7vAZIokqk1kZaPRMzTgiTZGUUKE3VmH2Y0pus+X27JPuTUJ9INzXAVsIrtJBR4Xb6e1lr00saCkbCKLM3c9bSY8aRcLV2Da3rybzc1x6aO32eM5GW4j6azBO/yfKs8zXFHQk+FyD4zFKbjXG0rfxyZVDjbY1afAgiprrtA+znfhp7o+sTV77TWzcUMCh46j11fIplKK/DP2FLbd+Fwa/KQjuMkyTDr4ftbwuPvwEXRTKfpLGdmUyvSbPr4qp4nL21cdxfCCDVTIyOh2/2yjc5i5ah3jz845KHqAGQHCgqwWjwt5Yd38hBK3FsSNs3XSeczcq0z4ro5OF+hGmG1S5hfLHCBg2xwWZ13eJrmaMiQkdlSzTQWb6sIH7I3qJ2FxsBMqHs4lBy2UajyUA1ktrKwTGfynk3cC/+NK5Sfe5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(39860400002)(346002)(186006)(1800799003)(451199021)(36756003)(86362001)(31696002)(31686004)(478600001)(82960400001)(38100700002)(8676002)(2616005)(6506007)(26005)(53546011)(6666004)(6512007)(8936002)(44832011)(6486002)(7406005)(4744005)(7416002)(41300700001)(66556008)(316002)(2906002)(66476007)(4326008)(5660300002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emdmQzlQRE5qT2laSVIwNWJJUmd1M1FNSjdwQVREbjNuTkdNMXYyczgrdnhw?=
 =?utf-8?B?NmFCZ0UvT0xCVmg2c1dmRTdFcE9TMFBtWm52S3NHQWU0UFJkMGJjVlVscVpP?=
 =?utf-8?B?emhJTVlJYVBrOUxuR1B2allHaHpBUVRVZFFIV0tuQkY1bDkrVkN4aVRPNHdy?=
 =?utf-8?B?cnZZL1N0bXpXZEp5dDhhd2tCMGFwRjlrVXBYemdiTGZJbVF6YzNSSnNnWjJD?=
 =?utf-8?B?WDh3VnZ0V0NWMGc3YmZVanBIQnN1RElVUlRCMkhIVGY2dEJYbzZnWk5ZMGw3?=
 =?utf-8?B?c3prU1JqUlgyS01UYUlNMW9mWFQ3Wi9LSzlvWDNJeVJNNEZUSnF6UStFRFZn?=
 =?utf-8?B?M3RZVUZKNjVxZUwzTFJJaTBDZGFtQ2hKT2pNZHhZSU1SZHVkNjdwaXBSN1lP?=
 =?utf-8?B?NU9VWVo2VnFpVjI4Tk5MMjVYaXZXb0JpUDZkTHpkcnd2VDZ2eHVTTlZRZVF3?=
 =?utf-8?B?Q2UzRUFGbTIwWmsxUytDT3ZzVlpDMm1xVSt6QTJqOFYyNWY5ZTFFdTRTd28v?=
 =?utf-8?B?T0NsRXR5TGxTbDJldzVFV040T0ZCS1VUOTdaZnh3VTJDOVQ0amx4aTBFUDZp?=
 =?utf-8?B?c05KOTZNaXdyZ2g1YSt0UC9TVmJnTFlIcTFlOUlBV1V5TjU5Qm55WWc3NjFp?=
 =?utf-8?B?eW5ndVpyYnR5eXZ1dE5OQ3grand4YjJHdjBvNzVMem5admJCSy83QXF4R0pa?=
 =?utf-8?B?dDFSTUp1Q2l4dndIRFg3T0ZSSEhJeUs0QVN5QStHUEZVNUdzeFhwOXZVSXVS?=
 =?utf-8?B?WHNMNVk2SnFxMTFLOWY4VDF1aThDS1lBRVg2YTM1ZENtQ1plY1BpRmt1WmRT?=
 =?utf-8?B?UjNaNk9CK2w4WWY1ajBWTFNWcmJCejFDcmo0NVlSV0VreFFXbDBoS1F3ay9M?=
 =?utf-8?B?Y2c0NTZOeU9WT3hHczlkc3Q0N0xBd3FYMEZmVWk1T0N5QWo1cVR4SFhHUVAz?=
 =?utf-8?B?UGs2SEhuNC91czJMYSs0ZWRoNnVBNUI1WkFZcklUdHhkRnpuc1JHa2tjTmxR?=
 =?utf-8?B?UTBuYngrdGE1Q0NSRHI0bE5oK2pMaWRteUhPekRZZ1dEcFZjTnZKQldoTU1C?=
 =?utf-8?B?VEpLNElmcmg0TFFMS3gxVC9jT3pYMHFkbjVvZnd3NkVQcWNqbHVLa1lQWnVL?=
 =?utf-8?B?Tk5oZDZVTnFWeEk5MU5ja1dFWXRvNTBXNzFPc2tiVS9oQVJRTG9Wc2V5M2Fa?=
 =?utf-8?B?cGlWSmJLQ2lvUThCMTZrWUFrSjI3anZ0SUNzVjNwL1Z5T00vWFgvYWRBdHE5?=
 =?utf-8?B?Qmx0WjZPQlNqaVJqZ0thbjczbVl5YjF4am9BTmdXQk9lYkhVV2JHcWgyL0dp?=
 =?utf-8?B?aTZ4UlJvdWNjWm5UdGlJV202TDdkMUdqcWord1M1N3BaMUZkUUtHSjRHakFq?=
 =?utf-8?B?NVRCNWpWaldFaVorR0JjMUVmUjBjWktmVFM2bXYwN0tTNWRBdE9PNEdKS1Yx?=
 =?utf-8?B?eGhTMTl0MWNmSUZxd2NRc0JzVkJ1bG41M3ZpSGMvS0RmbEkvY3RGYmEyenRh?=
 =?utf-8?B?bWRVSVR5L2hnTjJmdmdBZEk4YjgxeWo2WHRyeTJBT3pKb0pPalI4VzdwNnVY?=
 =?utf-8?B?eDY0eVNOVmdrSHRxUlp0Qmkva1FEMjJmM2VaK0Z3WGs2dklzRjJ5RXFiU1NN?=
 =?utf-8?B?WTN3QlluYk1va08vRzRnK1Ardy9ncGsweDc5S2FLT0M5cmlpSXpramJMOWh3?=
 =?utf-8?B?UHh6UGVmMGFDWWthMzhOaEo1RWtRQWVOWk5wZUVwSkgxd1RISWNVdzhNQnJR?=
 =?utf-8?B?YXRLU2xrbURxdUwxV01GSkNPUGR3MnUxbkR4V01YNzBPQzRVYmRQWHlLbUIz?=
 =?utf-8?B?WklkbXFQS0dpYkd0NHpLR0lPVllQOEl2OXpkdlB3eDdoU1lNWDVUMmE0MHps?=
 =?utf-8?B?elo5TFRXU0h6N3NRTm52SVExUDNHSnNtbkRIbGlzVHROV0Fkc2hTYWF5dEhO?=
 =?utf-8?B?QlEzS2ltaWlpTSsvSTFIUS9hZGpzcU5mVFJES042bWpRUnlLaUJmemsweGx0?=
 =?utf-8?B?WVloRkJkU1lJbUQ4K294a05wbzRHSjNlL1lkNmQyN3NpUWRkT1F0TDZQMGtz?=
 =?utf-8?B?a1V3ZHhaRG1ZcGRHbHFxT1Fwd2pKK0pjVElPQWNzMUFyYzNvL1VWbWtZQUZY?=
 =?utf-8?B?MVBjZ1FTeSt5Q3ZDc3JxN091cytaWE9zMk5GUS9PK2hvVmJOcnFLR1puS0FD?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b1ca22-3474-4c8f-ca1b-08db952b5f8a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 20:42:52.3838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2KlPA26Hy9/3ysOZXXMSqLD+OanWHe6SpVYh+Ns521A+mO2IGYsrDT3E3Vbge3F9dNmTTRJlnYPDwDTUc98oP9S8TVjVrl4Z5KDaappuHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 7/19/2023 4:22 PM, Babu Moger wrote:
> @@ -2591,6 +2599,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  out_schemata_free:
>  	schemata_list_destroy();
>  out_ctx:
> +	if (ctx->enable_debug)
> +		resctrl_debug = false;
>  	if (ctx->enable_mba_mbps)
>  		set_mba_sc(false);
>  	cdp_disable_all();

These changes are a red flag to me. Developers still need to
do what patch #4 was aiming to prevent.

Reinette
