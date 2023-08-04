Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD497709E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjHDUl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHDUl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:41:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81709E48;
        Fri,  4 Aug 2023 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691181716; x=1722717716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Drbn5QbZBY9IuLl6zmDuC0rx9F13fX0n92z40w/1vxc=;
  b=c9Kq9exDwYEQptKowSz25tQIY8qdFPXQdkXpo4BCBjSw+TILOIj+zKb2
   T+dnt1jUl4u1CN9S1auExJQhqHqpoGtuj+J9910xmxo3jd8L00HlY/d0G
   qHSWbQlDOt58cauJWKDX/E3iADPh9I8ShqIlKmo63/fnjyXtB7+s+3O5e
   eM77x8BXx6MqkYzgkPAM1z87MTPULs5xfg2ihWX6sZrt/u5uV+wQoxz3i
   WnFftpHZhfAt8XXTmivIoLw3xRLuMKm4fRxvq1xAuxUaOztzwftlihxOZ
   Pt0Xxj+VyrfugyaQ0lFLRa1mmVwKbU/VuJU+nUvKEOoxdFJyC5ZOszssE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="360303068"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="360303068"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 13:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="730192290"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="730192290"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 04 Aug 2023 13:41:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 13:41:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 13:41:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 13:41:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 13:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb3dXAlcaXtdJauYt6KF4ABTbK2dX+mJjxIw+bJxPRF4RgUxUxCpXGnXlavdapnKu2IXADmc/cVEOFa/gAV+3jBARgXC0As+sw5izrAvJ/vIUtKF9gZCM5g4dHBjR6ry49I4pJBeAG2qaEnoBJl8Wh/fAOwFmFQeaPgdPMVS41NOylDWpBP0it9K64Z7Lbi5hFh+TG+7rbV+RWL3u5WrikSKr6JAvYx4wUrndqU3E23RmeKfT4y0kOidxYx5RD15OPypaWtwvU568owqCwPynT9qetRCARmyLW0iGBtzmf3nkwOo1dpOzaEgB3PPzHY+NehmB8BkqOBKWLUa3t8NoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnB/vDvlkxITGn9WJ3tMXYO+tGTbtovm9x2ay+EGBOc=;
 b=dNWxcG1DE1LCRHM60xmzEVd3acYmtFiPjC/9AFiB1nRJpTqo0brLU25qEQqW4a1p/bnuMNMHL15TS9Fgt5+jARwX9G6CcMcKfZsXp/HuUQsSmIgP65FVr4GmJOMEE47S6Rxt+WuEcKf2GB0NoXC4ZUMcpqhO+0+J3vRQxN5xyUuF6N4hG9Mbe20z3rE5zVSKkYYaS8iR8sWP50ngNOG1rckKk9hSbx/1UjPXcXEye1rx9xwDB/DZBnf0OuoHS6yBH1Q1pLDQEEWcrIPt9GF17kkeY5Kb7CtVI3FhECbFJacOBRYxDJrkh+pXcDz1Odc0BpBmvMNIP8ie6GkaW2ZMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 20:41:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 20:41:51 +0000
Message-ID: <9fd70ef3-ca90-65e3-4746-7d574bdd159b@intel.com>
Date:   Fri, 4 Aug 2023 13:41:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v6 5/8] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx
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
 <168980892326.1619861.2405779251348138586.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168980892326.1619861.2405779251348138586.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:302:1::40) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 0878467b-9edd-4c12-f132-08db952b3b2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNWtbdG1EwxecECDmLxhO2TFwnnQYieVOpmHXC0fju/0vqksvKyHOqcs26rDdgrdwauvdeN39kgs+Z1YoJRGnkoYqZNLJ0wQztUO9HnGP5sCyFqzqFgvGbvpfo5Kgqe9zEEDvhNsvQlc1r7SEAjTLabpSRspc5GiAycNldD4+YFWAIwvXRTXDPYmtnTelTVMDJfVDHvWM8pDpkbiSqXu6F21oQZJyQmz8iwDLiqOPUcuxyCAZfF7Ffnw05kFsOSiU252COl3DrQbSEpbFQveT/FUnZv/5GWPlQXsVUJly8gDnBWRR11FnecN2XfQh4TCbPILi0wAmAmRvqGPowZyGh7YZb303KummIg43Vi2wR40GkNr2tY6rhDBz/gkcMKqVJWtWHXiUzL6AfCUE0B4SSCoIOLipWRIXkvoUcBXeGP3DPiScsVW5yScsfWSW3EEIzALutqgoDMFsY8TKP7oSSdgkB0shbYAvCTLFdEmGEhQ3j1fDzf+LLnhroyl9j1R4cllZAaEy0oqqC3Y8XQJwoC5UiLI2jalqByBVADYG68D4+nPpC4PPwO/Lfd2YSxAYOHYFidkoqTZSFfe1q1XSqQle/l6QQPlZ+XJjjGjGaI/a3aHFuM5DfizG7yqzlQY5syozUTsK1PY4qwqMJnwFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(39860400002)(346002)(186006)(1800799003)(451199021)(36756003)(86362001)(31696002)(31686004)(66899021)(478600001)(82960400001)(38100700002)(8676002)(2616005)(83380400001)(6506007)(26005)(53546011)(6666004)(6512007)(8936002)(44832011)(6486002)(7406005)(7416002)(41300700001)(66556008)(316002)(2906002)(66476007)(4326008)(5660300002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFQTlQ5UmZBYlJibGhhL3hpbWkyYWFNQzdvVy94RVY0aCtWeVBWem13eDJE?=
 =?utf-8?B?RE1sTDBsVzJndlEwVTRmYkpoVWJMQTZtVUZkL1FuaU5hU2FsRVFTQVhoQnNK?=
 =?utf-8?B?Q3VnaHV4UGJFd0o2TVpEbVcrR3Q2em1ZMFRRdllsNmJWeXErUWQ5L2k0RzRn?=
 =?utf-8?B?M1k4dm1BYWxCVkF3VDFNbmMyU1NlcTgwSXdlM1ZucWprejlnQ2ZaT2QwbHFF?=
 =?utf-8?B?WHNyeWIva0ZKWllIQmFOTU5ISGlleVB0ZkNDOVNiY0VUWGtTK2x2M3Brck5Y?=
 =?utf-8?B?NjgvaUVSeGdaOWZ4WGt6bkdSQ3pUNzl3R2hKSTc4Yk81UnZibG54WXZkRjZB?=
 =?utf-8?B?RTYyUmFYYUJYMDZQTUNjbWVuQ0NUdXV2UWV0MHRodU9CWXBtNGVhc1hoSjhj?=
 =?utf-8?B?cXhMRUMyZzNEb2lpTjdKZVBTOUl3djk5cVRacEFPc21RblIzKzFhWms1M1Zs?=
 =?utf-8?B?T01pTnhScUN6R2htb1R4aU1LOThoMktsRVFNUzhDQTBKVGRMMStaNUVJRElW?=
 =?utf-8?B?SHJzcU1iOFpCWFdZRG9qUXUra0JFMVUyN3JXNkowZXNtWVJVVkUyNU5FOGEx?=
 =?utf-8?B?eHoza1VEU2dQbWl2VTNBZXdQMTZiRGdnblVQQVBwVnVCZ3pxRk9ZY3RzMVVK?=
 =?utf-8?B?ZENCT0U3U0oxY3NyaThrdkQrQnR0V1BxeFYvbklUck04aWpVdi9ISjRMaTUz?=
 =?utf-8?B?eC9GcGpWZ2FtUEkvcGF2Q0w4a1VFL0NnZHFtNWNhaTZnTm5UdjZRaU92WW5a?=
 =?utf-8?B?TjBJbXl0VXRHenVNMjZVdzFJZTcyd2dXTyszMWtIekpRcFB4RG1XeGpoYWpk?=
 =?utf-8?B?elYvd3lJLy9rVklKUm94bzI3bloyMkxYaVlzeVByS2ZyWGpxWE9yUGs0bXlw?=
 =?utf-8?B?Sm5UVVB3eGp6SENnaGk1OW01MmV4VnZjc0RVMldkUXF6TzNBYkhDM3BGN1Uw?=
 =?utf-8?B?YU84SENwUjRuMU1RNlBUekluUjNRaXp2MWI0NmcvOVdFZ2pjSmNQVWYwbGJw?=
 =?utf-8?B?dGF3VFp0T0l4ai9ueER5Rzc3MDFZelM2Q2pwMHNPcXJ4M3czWEVIVDZjZHpn?=
 =?utf-8?B?L0JoQ2EzcXFlREJUeEtUNlBnazR5c3l0cjRnYk5Zd1ZCR2hhNzhLR2IxU3JS?=
 =?utf-8?B?aEZRdDN6UnZNY0hsc3E1SFRUdnhLM2lHVENjSW5mTGl4Y1MyNEl6MGNaaE8y?=
 =?utf-8?B?cnp4VHNsaUY2SFFnTlF1ZXVpNFV6dDUwQW9DMk51aTZFeUJvZnVPdXJnYkZq?=
 =?utf-8?B?VVFvWWlXVkw5RGRZVHYwaldpbFJ2bThGMFNFY2JCZDZ6QnBBaVB6SXJSMG80?=
 =?utf-8?B?OUVHUHkrLy83bS92M1FFeDIxekJVQ2N2Zm1JODMvN3JobG9DaHVra2tmTStG?=
 =?utf-8?B?YlVDL2FVUDdUb1NWMSs5QzR2b3dScHJSazg2ZFVPRk40RkpsVW16cWVwSkJa?=
 =?utf-8?B?N3hxcXJTZFh2UW5TRGNqdWpKb2h2TGhURzd1MkNUczVnN2hvVFY5MVcwN1hR?=
 =?utf-8?B?bG9RYlhRWVpWYnBhS1lsdG9ZaUZUUFhFdnh2K1pBdktQUWcxOEY5dEIyRGNV?=
 =?utf-8?B?VmtKeFJpRmNIT3RvSmhXUERlZ3NSZlM1aGVOaTJxaXJadExSSGtJd0pzSnV6?=
 =?utf-8?B?M3RsY09Zamtia2ZkRGtVU2s0V1FhTlpJSXNqS3YwOE9SejkxSmZjZE50dlBR?=
 =?utf-8?B?cG9sSVZHbW9iREJLV1FjeEhFRkNmV1ZISUFYMmlKZzNXN0NjMjMxVm5BS1hE?=
 =?utf-8?B?VnNoM3JvQkpZQU5udmRZR1AzcXllY01TUDZ5RFh3Y0RIU29NaTFmSmJ6cmd0?=
 =?utf-8?B?bFNWUjFHWTkzQ3Fwd21BeFltVmFjd2x4OC9XempCRXRWK3pBWjBqN21mZnFK?=
 =?utf-8?B?WWJUcFM4bGJJMyswTjZjUHNWK2F1VUllc1BKUDR4SmFtZUx0YnBSSmtEL1BL?=
 =?utf-8?B?QlRNVmhKSDg1eWV0Z3NyR3h1NVlyV1ZjZUVIM2VVYjFRY1ZmdXgzNFNJRHRx?=
 =?utf-8?B?d0kxdFFTOU5WMVduYmZwcU9FUURrMy9kbzZ6UjhVR3FGcnRTYm9IL2MvYWZE?=
 =?utf-8?B?MEp1Ukg2UWtNY1ZGRnFHMmlvYTNPSTByMENiZGpmNXVLcDloSmpOOCt2QlBS?=
 =?utf-8?B?QkFhM3lPRWx1K0dFNDJIdVRjZzY3cGVxb3N6Vk94TnAxcG93YmtPMmVnMWdL?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0878467b-9edd-4c12-f132-08db952b3b2b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 20:41:51.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQRSWwWSihooxE73RTZBP0t1OAqe3Q3nZRmJXwDvSe6kcxl43n0x9sB7ZM4GSxlmhoBC7eSN/uPl6nkaY/4HwtLBrBuEW0WP9Qg772jpBm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 7/19/2023 4:22 PM, Babu Moger wrote:
> rdt_enable_ctx() takes care of enabling the features provided during

"rdt_enable_ctx() takes care of enabling" can just be "rdt_enable_ctx()
enables"

> resctrl mount. The error unwinding of rdt_enable_ctx is done from the
> caller rdt_get_tree. This is not ideal and can cause some error unwinding
> to be omitted.
> 

Please consistently use () to indicate function names (in
changelog and subject).

"This is not ideal and can cause some error unwinding to be omitted."
is a bit vague. How about (in a new paragraph):
"Additions to rdt_enable_ctx() are required to also modify error paths
of rdt_enable_ctx() callers to ensure correct unwinding if errors
are encountered after calling rdt_enable_ctx(). This is error prone."

> Fix this by moving all the error unwinding inside rdt_enable_ctx.

"Fix" creates expectation for a "fixes" tag which is not needed here. This
refactors code to simplify future additions.

Even so, I do not think this solution addresses the stated problem (more
below).

> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 3010e3a1394d..9a7204f71d2d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2381,15 +2381,31 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  {
>  	int ret = 0;
>  
> -	if (ctx->enable_cdpl2)
> +	if (ctx->enable_cdpl2) {
>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
> +		if (ret)
> +			goto out;
> +	}
>  
> -	if (!ret && ctx->enable_cdpl3)
> +	if (ctx->enable_cdpl3) {
>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
> +		if (ret)
> +			goto out_cdpl2;
> +	}
>  
> -	if (!ret && ctx->enable_mba_mbps)
> +	if (ctx->enable_mba_mbps) {
>  		ret = set_mba_sc(true);
> +		if (ret)
> +			goto out_cdpl3;
> +	}
>  
> +	return 0;
> +
> +out_cdpl3:
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> +out_cdpl2:
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);

Be careful here. There is no dependency between L3 and L2 CDP ...
if L3 CDP was enabled it does not mean that L2 CDP was enabled also.
Similarly, if the software controller was enabled it does not mean that
CDP was also enabled.
Since resctrl_arch_set_cdp_enabled() does much more than just change
a flag value I think these should first check if it was enabled
before disabling the feature.

> +out:
>  	return ret;
>  }
>  
> @@ -2497,13 +2513,13 @@ static int rdt_get_tree(struct fs_context *fc)
>  	}
>  
>  	ret = rdt_enable_ctx(ctx);
> -	if (ret < 0)
> -		goto out_cdp;
> +	if (ret)
> +		goto out;
>  
>  	ret = schemata_list_create();
>  	if (ret) {
>  		schemata_list_destroy();
> -		goto out_mba;
> +		goto out_ctx;
>  	}
>  
>  	closid_init();
> @@ -2562,10 +2578,9 @@ static int rdt_get_tree(struct fs_context *fc)
>  	kernfs_remove(kn_info);
>  out_schemata_free:
>  	schemata_list_destroy();
> -out_mba:
> +out_ctx:
>  	if (ctx->enable_mba_mbps)
>  		set_mba_sc(false);
> -out_cdp:
>  	cdp_disable_all();
>  out:
>  	rdt_last_cmd_clear();
> 

The problem statement in the changelog was that rdt_get_tree() is
doing error unwinding of rdt_enable_ctx(). Looking at the above it
seems that the problem remains ... callers of rdt_enable_ctx()
still need to know all internals of that function to do error
unwind correctly. Could it perhaps be made simpler with a new
rdt_disable_ctx() that undoes rdt_enable_ctx()? New additions
to rdt_enable_ctx() would have more clarity where changes are
needed and callers only need to call a single rdt_disable_ctx().

Reinette

 
