Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90697709DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjHDUkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHDUkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:40:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974F1E48;
        Fri,  4 Aug 2023 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691181599; x=1722717599;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qSLBOa1OHd9QCbGIGv7NyZvn/MZSKoyA07kmG+c6M6Q=;
  b=jtYK7TEOFwshFIkoiV1tiH+D6T0mx8nNK9B7Wj2o1S7ra0NLHPSuNpBe
   TLeCnFh2oAE0Fgb5eJ6hct6AxXEKi4nQMHl+iBGnsB6KGQz22Hvs8G8Ju
   VW4B/VT5k4GTkDSeYY0DrjuVZ4uxYvT1qtHiDVE29rlsExqj0Epxg8xEw
   Ypt3GH4Nq+26r1my8ge8JNju8C01hf2RVJK0rUct1EnoJZH8nZW2ji8tW
   +On0/EHo4Da33oJPapbWsteeYosZ5wxXbKVpT7uwtvmzZfnaYZwI2dREe
   2xtnIBJhGe/VofkvC/fFpbL2YUedtNSABI/tOWekzvO3z18Xmp72mV+n7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="355171500"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="355171500"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 13:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="800196842"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="800196842"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2023 13:39:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 13:39:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 13:39:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 13:39:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 13:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoWQpTVzhZ6vn6Kb3QObEUEJy9FiEsfULHRam+0yGLeh4mUYHOwzVGVzWZx2B9zWv75cAbOZKI4KU5VtH8pKhP0RQ5ZqDUeYbxbvYiIUYwcaYOTVZ2Tr1JIrd8kAYRYWdeoqVOKCxEnmXvOJmF3YXV52WuZld2uthDpyk1/QGKT9KOXQACFWMnl01wmkx/ACUwIWanxR6FykODXbdYFxP778YyCizMpXSghNCppfER2yg+3eTzGhOcSFx6qs95nE0orIrjDUHmKWJse3p0ybCEVnp1Q+2epE1bPae4wzdHrfPpvklAZ9IvNZ5qsBQt4aOsDnWvZ6ZSpZP92kuQV0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+1ZzfeCdgPpjwMtjiNvOxDbIuVgquOCEaq2CNKH7E8=;
 b=hQmiss89t1SNrCkYufF0TQxP4jUkN6pfjjBHe7RyKuDrj/lyWbkPN5c9l0ftIrUmES7+H/Ixzk0TDSNW8B7SEa5XuC6F3YiggNQ7D7pQBuSNye7YXi4hy/7nETanzyEwxhIfVnBA74HvEtQcU3/iYnxI3CTc1NnwLO7QJlC/4ofEBUB6iXkdn2/Snzn6AMQD6Jxrmw63FFjDZZJAv0WOGxwY+SCJiEmZIkgXkAjNQWhOt6L/4jhV1SEf+LfZISdmjWvbOMWdw+8gC9PUxQIlxR6Q2ipEMoCyfcq/JwcDsg7bJoI0Idpdnwp0aXlIFL5BHKCh6K9WKFPaDB4QS3f9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 20:39:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 20:39:52 +0000
Message-ID: <41c166e8-d6a2-7be8-1d4e-6b2b1cc62f2a@intel.com>
Date:   Fri, 4 Aug 2023 13:39:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v6 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
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
 <168980891501.1619861.11056885467637617879.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168980891501.1619861.11056885467637617879.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:303:2b::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: f3bb1da7-efdb-4286-87c9-08db952af473
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMyFjPD4Tm1KhNpYwt+62DNGDUf05kS1Zrn+iEtCf7zSODG8Z09pw4sUi02XGesGTYIn2Xsy3Os9EA0O2c9gFhU+yCNGn7nWJkHj4RZU9qiKgj17vATCniWKQuYt4nOnANbdrNHLI1jCrGp66uq36J3Oq0im3TRSzmpw+U3H7gLhw/9nsKcTdHlLF09bF1DiMXkwGICPuHdHJTaq8/USRZe0s43ZQcQ6tSOOkGl+i+/q6YbslEEZsnucM3AKNAETjUkn1ixCgQRMsBX4NI+n3tdfYqOF0mrgoy3bk8U/cUVgzRwLCiqlga5ECAoEikDWqR4GJa+3ndPMcFwRM2LDoUY2Z/7lsHv2raeYt1/5DUIWTW61bXad3/RqCzBOSGkHVY0xqnboF520ODbnnJLmS27cm3GOffimP4oSKWsp/L0gwV+rV3mqQJNCU6NDUPE9WvGxrInRhMGWX9TbTVbV0TzG6A4evIUXMWzDnIR7eRV/W2QyzztMDEIe/H8f+b/Mp1i+RQcWzeUH+nrDGSLzdY6L4yNOjGok7/8k4fv0kzLIP63w2IECo8wQ/nKDy8aHGFlp/DDNcSvvGW/TyoPZhHGbfw0nMAHFtscca0tAfdubcubPWeelOFx0DpHOYKrB8VWpqfbr6N/Tlu3ovgOirg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(39860400002)(346002)(186006)(1800799003)(451199021)(36756003)(86362001)(31696002)(31686004)(478600001)(82960400001)(38100700002)(8676002)(2616005)(6506007)(26005)(53546011)(6666004)(6512007)(8936002)(44832011)(6486002)(7406005)(7416002)(41300700001)(66556008)(316002)(2906002)(66476007)(4326008)(5660300002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2MreDAray9MMzBtazR3clNjOWFSUGNRSmo5VkxXUk9qb1hEdzhSQWZDZy9l?=
 =?utf-8?B?dVZjMWcrNU5zNjFDQmJBdURPamRmK0FVTldlWXVEOW8wMTlZWXdSNThETXhx?=
 =?utf-8?B?SSt2WHJrT2xlR3pZQ1JzdjZsOHQxdC9LUkdFZm9CcElaZ29rcmh3VURFNCs5?=
 =?utf-8?B?KzRVYThxVUxZODN6aVdXY2RiM1U3aHBLaURKallJR29QVHlQUEdvcUdER1pG?=
 =?utf-8?B?aWJoOEhLcnloSkh3OE8wM0NMb0JRMVlwMUVtSHlrNXAvWC9kN2hHdWg0dzNX?=
 =?utf-8?B?R0lRYW81N3J4bk01TEdIN3NtSTBKSCtIZHZ5ekdrVlcxdndSZFEyYUtGTTBN?=
 =?utf-8?B?NHp6ZWYwemNWNVA2OEI1VkROQ3RXUE5YTzVTcnZpVXpIWTI0bEJMbE1NR3o2?=
 =?utf-8?B?SWdmSVJwbGViK3FIcVZOVDNVcHEzTE1RS0t0NmNrU0xYUHlmSTBLYk5XeVE0?=
 =?utf-8?B?SG1XYmt5VFVxQVQxL0ZvZmZkUk9kOEVwaVA2MUtLU3FlSTBySDNuaFIvekYr?=
 =?utf-8?B?NW83a2ZHWWo1NFQ4SlNSQk1DbnhERk5GRFBoWitNOWRNd2FDQ05PcXhENE14?=
 =?utf-8?B?dVNDVjB2dXdlYjMxdmZRd0ZxVm9kZ3dHMUZjUWl3SDB5MmVCdUltWlFSQnZV?=
 =?utf-8?B?NmNzYjZYNGdIa2h1cjJpY2dvOFpLaXlSdzJGdkdKVjZhNUc2cndKUFZlMHlI?=
 =?utf-8?B?UTR0Y0k5bmZ6WmJJNmNLMEo0Q0xpVEM4RHpLaDRUNlVtOGZNbGxrMmF6R3FG?=
 =?utf-8?B?VHJzdlRuTzZqVVBFNUp4bTR6d3dmSTIvYlVua21IeWR3U2gzM3VpRDI1NlVw?=
 =?utf-8?B?d2xSR2FNbzJRK0NVckhwQmZLaVo5RXJPcUVUWmJOYmZ0T0dYcjNDRWVBY0I3?=
 =?utf-8?B?MTdKeGNiSm8zUENxMVRXWmh1MTFpTjNGZDFVR01pOUhHdTlxTkRpTytnM29Z?=
 =?utf-8?B?ejVjU3o1Y2lRUnpKTVVybHA2ckpCbXZnYjNCTERqSTRMSnJxYks2dVRkVkNX?=
 =?utf-8?B?T1VuUFdaV1VzMnhGSUNmZFVjN01MQWs0MmVDTE95b0VaSU9uTjdxcHAvb1U0?=
 =?utf-8?B?USsreUZ6KzNGVEE5VzdvblFyekZmOUdYM0VBSmJDN3oyTXNEdy9pR3plT0tY?=
 =?utf-8?B?VUUwZFFoWDF3ZFAzL3JNNjI5MjZ4ak51MjZMMXNDbytpUGliMXBNdkZVV1JX?=
 =?utf-8?B?dGdwTCtYYWF3TVppbVhFbGc1SjFTa2QwV2t4cmZJaGQrTDRrSkxkbmJLS0Z0?=
 =?utf-8?B?RHFxWitVZXozQk82bkR1bzNpZFRMdTFZWUcraVJ2U0trUXVoNGxIK21uRXlY?=
 =?utf-8?B?VjB1VnNXT0VUN2tLa0pIeDFYYUFkZzBhTWV5UStrQmdmQjhJdXFGeU50bzVr?=
 =?utf-8?B?Mm1uMnV2MGNEWms2M0E0QVR1TXhnRENSZzVOZ2h0czRYSG9IUDhRTDczMXJn?=
 =?utf-8?B?eWtCWHRmcXF3TzBobHBTdU1QeU5XMFJtNFlNcCtwOEU0VTlhVnhCd2dOYTUz?=
 =?utf-8?B?VDRTOXEwekVCRXQ0UVJoMS9aZnBJbWVwZlNzWHZVMWU2Uko3NnFWR0VIa0lG?=
 =?utf-8?B?bjFOZDRzaTZobFFyRzE4aUFyeHduZ2xkalkyYWhveVd2WEZpVExYbHlsWlpn?=
 =?utf-8?B?bThxbkpadDRhQWMwbXBNM3lZekQ4dVhWSG5aV0piVW9Sd2g3aGYvVlhNMmVS?=
 =?utf-8?B?K3E3NlU5N3lBN01EeUxjNFkvTVJTaHBvQk9Rc2JyTlVIUkhYZG5QUEdFR1c3?=
 =?utf-8?B?dStSTzRwSWNuR0dFVmF6ZmNoR0wxT1lrVGJSeHVOaVYxWXJVTlJXZ29PYjEx?=
 =?utf-8?B?NTZiaUhrZkVNbzBvZzZCbURUTzdud2Ria2F4Si9vMk1UbVBjUUs3VDc1V2xL?=
 =?utf-8?B?OXhpSXdvYi8yc05ZcW1GUWtFeXZSUSs5eDc3ZmlUaUpSR3RPMWM0UGQ0TUlx?=
 =?utf-8?B?ZEhub1g5NUUvZWw1MjZsNFpJVER4U05ralBvMWgwTmROSDd1SG9MdGFVL09o?=
 =?utf-8?B?TlRZT3VqVmNGOXczRHI3Wkd4M1pQeElGbURaRUtyRllwcGtJWUMralpZMDBp?=
 =?utf-8?B?SU4xeWdpTGxhc3A3K3ErRCtmQmpiT21qNi94blo2U3c2N1ZuNVIwNk04WnZi?=
 =?utf-8?B?R3Y5bHh4QXBDa2ZEUWFDRXRzK09jaU1mRGhHNGFzdFR5QWdFN0o1T1lMS3pR?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bb1da7-efdb-4286-87c9-08db952af473
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 20:39:52.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUX3kFBELnYfTf/PYMIYC4F3i+hPHLknUpECfXsE17SVq2+Qz3SprbySkoCumjcNJR9jdI3HDZxvLqoY7q9ojzHP/BlZTDpDQH8UWWlYoCE=
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

On 7/19/2023 4:21 PM, Babu Moger wrote:
> + *	------------------------------------------------------------------
> + *	--> RFTYPE_INFO
> + *	--> <info> directory
> + *		--> RFTYPE_TOP_INFO
> + *		    Files: last_cmd_status
> + *
> + *		--> RFTYPE_MON_INFO
> + *		--> <L3_MON> directory
> + *		    Files: max_threshold_occupancy, mon_features,
> + *		           num_rmids, mbm_total_bytes_config,
> + *		           mbm_locat_bytes_config

mbm_locat_bytes_config -> mbm_local_bytes_config

> + *
> + *		--> RFTYPE_CTRL_INFO
> + *			--> RFTYPE_RES_CACHE
> + *			--> <L2,L3> directory

Should this be "directories"?

> + *			    Files: bit_usage, cbm_mask, min_cbm_bits,
> + *			           num_closids, shareable_bits

Based on the hierarchy presented the files mentioned here may be expected
to be associated with RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE.
For accuracy it may be better to move num_closids one level higher so
that it is only associated with RFTYPE_CTRL_INFO?

> + *
> + *			--> RFTYPE_RES_MB
> + *			--> <MB,SMBA> directory

directories?

> + *			    Files: bandwidth_gran, delay_linear,
> + * 			           min_bandwidth, num_closids,

Please remove space before tab for a clean checkpatch.pl run.

> + *			           thread_throttle_mode
> + *
> + *	base (root) directory structure

Since "base" refers to more than the root directory I think this can
just be "base directory structure".

> + *	------------------------------------------------------------------
> + *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
> + *	    Files: cpus, cpus_list, tasks
> + *
> + *	--> RFTYPE_CTRL_BASE (Files only for CTRL group)
> + *	    Files: mode, schemata, size
> + *
>   */
>  #define RFTYPE_INFO			BIT(0)
>  #define RFTYPE_BASE			BIT(1)
> 
> 

Reinette
