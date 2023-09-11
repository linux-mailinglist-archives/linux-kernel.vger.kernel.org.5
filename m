Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E3F79C281
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjILCP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbjILCPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:15:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E1CAA54;
        Mon, 11 Sep 2023 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694473612; x=1726009612;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZSUUoCBGxyvBYaQ50Ne9KldJBmzkj8kBziyfb32/eno=;
  b=h6+Sx3Pb+R60KVYy3i+O8Lj1yYWIOIMjXXfDkC/gWB5OTZgMjtI9HHcb
   uhwJBW8i1Tte56EXvDEwELZbINcMg8fWHDn17ZGH5XBQFRBfCCaEHhNkl
   +/lfseQYc6KDQdw0vzM+tIjcqaM75S8YuEQiTLWZ2SvqSiW1YqyGDzruG
   7wn86nLWYydD2IjNvIqF9WGZFn7qfA2j4jJ7cGbfMThiEktk8wucKmzZ7
   MsNoMcClEooEqwHxxVO76ZQNTjxRRmxgDivd7XCNcsmsJFGYV4M0jce7v
   AWrD+KODjYqqeh8pFIVkZp4h5OEA+jSo/AXVCarljmO/4CLHOYk7tgUF0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="464598446"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="464598446"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 16:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="693258180"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="693258180"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 16:05:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 16:05:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 16:05:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 16:05:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 16:05:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYNzJkEAuzVN0XyRStafTLSJtA+U6p24dmmVw3vhH7QVo8ZHzcfu3kk7v+fBk30poHem980kU9YSdV4YUr7xuWcSF8TxjlzK6VdlvJYfk+kIg+VAxD6uLO8sNZvwOIuHiMwUP+ro975lLSX0tmbDSCur7UCuv5Cp61Jx5R14Gto5qHyTQ9Uk2Gx/3725Nfp4sbmztvGaBZIiqfIcUNSSeWhCLrRTqp8sPbzka09MdIzgfZvfoqTvZBzxQ5wAYLUuYEH8BySruC8fHg81fRuOKrguH/wlGfOmOZzQKThwNy1P95xtXe4Va72uZ+sUV4+xoxBDkzs9r/uc/DT1KAOIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2CIHQVAAnOEyyUoCFEJEDP4eR8yO9jJpXc7pBvMW1Y=;
 b=DsNMW0RREJBpOO5w+F04/7KnYvoDGYM+flmxo/uonFjs8rOA3zHcuEGy5R1SpNxOuZXtR+w4BE1cpvbaMtHWJ+cgxvdjhvESfEJEHIH5tQKQxkxTrM341vt+5+MMz0u7a17+yT97CK/evLraNXIXfI4RZON/rMAG0qcPOkGnSKfQpVObVMUMjtF50qeNO+i3Y2rRjOS07LhBVV1PfcODS5GdQd/WmssvM66MaQ3H4NesKqVdEPd9j86Vl8fofWEGkYEN4MUD0Y3q5pE8XnszhMg5MgqxE/Y/YEpp5rTFMzmOZ20iLfev+VcIvYs+iExWWXjrBGzYU4DFeFN+ouf9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5516.namprd11.prod.outlook.com (2603:10b6:408:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 23:05:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 23:05:17 +0000
Message-ID: <d23cd6c1-17c1-57a0-a1fb-2d3516e3ef88@intel.com>
Date:   Mon, 11 Sep 2023 16:05:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v9 6/9] x86/resctrl: Move default group file creation to
 mount
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
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-7-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230907235128.19120-7-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:907:1::43) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebb3855-155b-4fe3-9d1d-08dbb31b90c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yeCDCwkXC0TJHOVsrgZZBILi6yBk/iNVz0oO3rFak6XcCltfeRRhTN/BZn5zQIk9iC0ocdpLURzo9XM+rq4/x7NR/ojbveS7OR39gE+kAGqXcZAMc4l1QRzJO9aRaqtsTYuCVmvYwgFZ1gBsf04zo7G8kDTSAC+/CWM2kCxxpThDqNjaLHxzm4mr9vurhTCOy1H66KyzT3WZSPq2NyJmFxKyGFsj0XU6ayDCu6sb36FE6WU5Egcu5KZP2fMNZCbSlCp0bjATZf8lKXu2tpDChjxDsWMfCzi7RMgbH16rRg6T9zYhwjc/OslTgJ+WpxeA0a0xyta4tXx2VmbFfpjWXjrnMEpl0ftbLajpXUMhZWRzumrshnO3iCXLF8P4dWRPS+s+HwuBAhMA6fKWV1ufrq0XbYSUD9css0v/ZAjwVDNr2SY6gx1xw8Wpzo8HCIXoLOPmC00cae/BDwLOkT9i1wJ7SPT6dbihefHzqfI37PuX10oei5sswDHSV8ZorJDzFStC18pq/Nmeq9aQGApObYbd8QkAXyeYLloS+JMYrX9LzT6FZ8q0R/h/Z2dIFm6GIJH5/FoBduVkdibIvAxM6VVxosLm6jaZfQkEwPtItuPSerxaHv+Qou7sQW3ld5s4nmIexnHEHkvTuQTuneg6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199024)(1800799009)(186009)(31686004)(6506007)(53546011)(6486002)(6666004)(5660300002)(41300700001)(36756003)(86362001)(38100700002)(82960400001)(31696002)(2616005)(4744005)(6512007)(83380400001)(2906002)(478600001)(8936002)(7406005)(8676002)(4326008)(26005)(7416002)(316002)(44832011)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRuczVFRlNXY0ltSDAzRmRhdHJRbTg0amZlWlF0RkJ4UUk2S1dIOGxVZERK?=
 =?utf-8?B?dFhDeHdGN0t5WGhQa0RUcExqT2dLVHFocUpJTkpHWVU3TVJzNjZiWUhhU1RI?=
 =?utf-8?B?OGRZeWYzVWZVL2Z1M0s5c2V0V2QwVXM2bG5PVXRCdFRaYVR3ZXV2WGZUKzZa?=
 =?utf-8?B?Z1lSUFE3b2Q3K1BCUno0Nlo1THhOU3J0bzFxM1ZFVXlNSTdFdXZkYk5WR282?=
 =?utf-8?B?S1FDSitQSjBlVlRhNG91b1NXQldjemhuenpmYlVRSncybUp1MVhsK0EzamFq?=
 =?utf-8?B?VVRkeUlZWjJFQk8raWhGOXUvNDVjU2lzK2JqeWR5ODh6K01UcGV1WkxleEtM?=
 =?utf-8?B?MjJQaDRzdWF0cExHUHNibG1Zd3ZHRWdhaEpNSmZkS3dzSHNMeEF0TkdOQkdL?=
 =?utf-8?B?K2xEckhXMEJsYi9hRFV3TGR3cDAzUzF6TWFEWTN0dEhEalhZVk1oWVZmM2Rn?=
 =?utf-8?B?R3c3QTZSaXlRWHNuMTZ0L2t6SzhXWjFFYjdhZzgxS2crY2NSYjVvTlgxSXVm?=
 =?utf-8?B?RW91Wk5FNnFmQnRmNDhqeXBKR0pvdlNYUjhYYUc5c2N5NVorK1lpcWh5OHc2?=
 =?utf-8?B?dmdkdDhnbmdiNFMzU1FBMnFRMDlzdllLblBTZVBCc2xGUUJlRG9pSVFnWUVJ?=
 =?utf-8?B?SWRHaGRpZlBrWiswWGE1N0QrNkhvTlJUQlIyWGsyR3JUVzV0YURSVU02eUIz?=
 =?utf-8?B?MXcxaXJqbWs5cUh5bzZCeElVcU9tOUkwd0RlK01Ucmo1aGc0QldqQXFUSEdi?=
 =?utf-8?B?MTdSWkRycnhJSWl6Z1BXT2J4RFJQZUUrUEk2ZHZ1TEhRZU55SlZ5WE4rYUdX?=
 =?utf-8?B?UlZBdWk3RU9HWWVWRnc3WkJVYTh6Y3FlYzVqVC9wYUUwbHVjaVdaaE1PRzF6?=
 =?utf-8?B?a2lxbWczclJ1R0syMzI1UmVnTW1NbnlSQkNoVWNscndkZ3U5bHVRYldnNDNh?=
 =?utf-8?B?RE5IYUpCNU4xQXZ1UUtpRlFHNGE5WTdMbWprRWRvVDBGZWxvR1FBeXFRWjdL?=
 =?utf-8?B?YU53bDNFZ3lNdEpuNm8rMlY4NVJqdkVSelU5UXRNNjMzQnFRK1JFMUVMY0hT?=
 =?utf-8?B?SE9ncVJZUmkwVlo5T1BzWk1YVWgxTFllQlhvMnhWZVNuMVJrRHAxYUdJUFEx?=
 =?utf-8?B?ZE00R3J4VWJyZ1JvNGVLYXdxcENmbHc5QnJ2UVIvMUJIN1I3c3dkWUZmeGs1?=
 =?utf-8?B?TExCdUJXbnlKN0hjdktsK0Y2MW9jbk9Na29wcHpMWkl3cHc1d1VVN05sQlJi?=
 =?utf-8?B?RHZJeHovMFBJUG9Fb3VxZkhxbWZFTGJqZnI1Mmd3VFErMzA2WHR5Ui95T092?=
 =?utf-8?B?NE1ENlJ5aUpMaWcxR2JLY2RjVGVPNkN2L0N1aFhsUlA2K25tbytobWhFZkx6?=
 =?utf-8?B?eHlFOTJXaDBwNU9OTXEzVDhKV3hyOGZONjhPd1RzY1ArWWJrQjMyYktvN1lj?=
 =?utf-8?B?UStQV3hHbmlzT3ZhTnJPbFBiSVhRWmdnTlZRb0UzMDJva0l5dGFTSFJCRlhT?=
 =?utf-8?B?YmNoRHVvUk5Udk5XQ2hhenl4UnlCNFZkbU40bVMxUmJ1cmNXcUtWVmpOTG42?=
 =?utf-8?B?aHlqN2kwQUlIVXhZaGlkRjNLRjBFZk9EbzNJRkpPUk50UVBzZ0w4ai80T0hy?=
 =?utf-8?B?anJCYk90aWtuOFVJcDFPQkpFWUFkbjRCNDJTdmVNWWFlRGFuU05iTUVvZFNQ?=
 =?utf-8?B?d29VN1pSMzFoTk1yb2huODM1TS9KZHJWaHVSRnU1NXJlVFg1NXZIbFE2TEcx?=
 =?utf-8?B?YUdMVTErd2pDZ094R3E1TjhvVFdtT2NENnpmNTVHNzBUUHlRMGhuT0p0QnN0?=
 =?utf-8?B?ejB0emdIVHdmc0NDdUlyTVZFV29sSUdTc3RUTGszWE10MU9XWFU4eGhndEJK?=
 =?utf-8?B?bDl4RXRCTk1GakVkdkVmTit4NkNBMlk0L0NybWZvTGZibjdtRzZLaDdySHpj?=
 =?utf-8?B?MXVxaWtUaW9RZTBENEt3NFFaR09jTVpPWWlqOFlHcjNFMlR4UXVDV08vVnlw?=
 =?utf-8?B?SzhDYkJ5UjBxN2QxcTVaQmVhZGE2d2VyaVB1bGljSkV5SGFHSFJ1aGZEdkFT?=
 =?utf-8?B?V3lhckRmN3AvMG52KzlVQ3ZvZ1BsbUZVSTNsN3dnbTNhbWlHdVBlUFlZUVdP?=
 =?utf-8?B?RUkxNFR2MXZLNVFvTlF3Y3c4NVd5ZkNCbE5mODAxY2Zvd05jYzVTbWQrUjhs?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebb3855-155b-4fe3-9d1d-08dbb31b90c4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 23:05:17.8882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZA0QuQK3T00U5E1EmDuk5s0X0IUB3IWTZdi64gva+7DmCdYR5sfYeNP0kluQqPA9r59UKy+K6Rq7EVfD6tip8ktMKakORC68XvZ8ZLlwH3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5516
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

Hi Babu,

On 9/7/2023 4:51 PM, Babu Moger wrote:
> The default resource group and its files are created during kernel
> init time. Upcoming changes will make some resctrl files optional
> based on a mount parameter. If optional files are to be added to the
> default group based on the mount option, then each new file needs to
> be created separately and call kernfs_activate() again.
> 
> Create all files of the default resource group during resctrl
> mount, destroyed during unmount, to avoid scattering resctrl
> file addition across two separate code flows.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
