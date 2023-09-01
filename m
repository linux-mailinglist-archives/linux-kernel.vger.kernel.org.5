Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42257903B6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjIAWo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjIAWo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:44:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD645A3;
        Fri,  1 Sep 2023 15:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693608264; x=1725144264;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IqdqYS5od+qB1ATxKC6xlr0KSo1idgxOz8ygSrCqOvk=;
  b=ISaHJePrcA/idrHSDWfxokxjOHQ3jHI92NBXqayB8+Tbd6YnZYHKR3PS
   w8Ye9FiZ9tALo9Q7kdd8H7iWpE2TvLOz4Xfup71hpVnl/hFi06kRKtIXl
   Q1DYWM31Yi2BEEaQ/rPjTmaOWHVzMCdOkEzDXjdNBCdiwCeuy5+mnVmoF
   9y4qoxeNZ+pe0/+10SIYTdu0cgwSpORF1kOzkz/kVpQ9VxfaCK8xQgTSA
   UB8p2v8TNoI8lFDPSBi6hxmnUVrp+9s3/mHCbC/2bMpt0sjyX2IyahmDY
   uFpVZWjstUY39NaQC/uoM5/V+NqovHLtvHrvSm2/MPalPk5+zHVvcFewp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373717028"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="373717028"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986836645"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="986836645"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 15:44:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 15:44:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 15:44:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 15:44:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wtale6UMltceFKzOTeKZOmjMoXosKvsrZST9znvgAvURNszLqAf6yoG6YCzwRPPlJmx+YuEO2JQYn5nCN3RVEkoV1ijBwRgedOhpkadfeXPLNG0WsMpeFUZc7IoEH3ZuinK3+WOjQSfWuqKullW0CXVKzp5uvJoVylC/3KTvkT16LqN0/ioLmBGxHseAXEVYI6aYprLoVcbFlcq2FuBFrC1SmZR05jHJScbtaF5uRM6PVJ/TamWQ2RUoejxAVGxzAdCiHd76freZf0nvVCqMUcFMr04jpwQe2J6GTlGb+P3ddbgraM2L2heHvQURdA19rEYSRTNwfpMWg347R+xs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmkvA9M9n3ZAtZziSUUXd5wVjWaAdi9jpQCGAIeyQS8=;
 b=SHNmYWh2CKOw0sINZhhbLNpROHH54qfHQH1XuXSpU3gLn/qGNkTrT+eRNIq5gXJHOawUC8Glg6iuZhhP++TaQVFcD7kyd2czHOEJqO2XVvaHWk50Gm2h52xkdqV9zabjvPRzFcbtZtactnSS3/gucusRhzWu9FXqMuNFOJiN+boRzHoeXkBI/CTbjE1InvGOYw/Cf8bR6547r9KbIi8vThuRuYEK7EOhaStajxoGjeEr72zVO8CUcsXoGRKBf191tF43VilSH7ZdabqUv4zX05LKE8iXkKd0CQElbMnKVmVkcNe2wBtd79zRMVLGvFLpT30h3HjCXsVSBYkdar/nZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA2PR11MB4826.namprd11.prod.outlook.com (2603:10b6:806:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Fri, 1 Sep
 2023 22:44:19 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 22:44:19 +0000
Message-ID: <1e4c1894-fc38-3f73-4b6a-151096656713@intel.com>
Date:   Fri, 1 Sep 2023 15:44:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 8/8] x86/resctrl: Display hardware ids of resource
 groups
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-9-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230821233048.434531-9-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:a03:60::49) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA2PR11MB4826:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e6d450-896d-4542-e254-08dbab3cfa4c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: td19dzHWBMsOnj/jaoSYlh1NyZkiJ4KHihn1V82j9P6gr4Dd6wd1GbyzA+xetjBAFNPGyhMxqwA2JBhmOnVqW/KFrSwazk78REsQwFoFXJAifKQATNYlScBl2Sx6D8pwf8EO13GGNL7VcOJ1asSyhV5IzdERqjP0jqcUrqZDoqo6DWhP/Iz27S4oy7N91YYuhIgitrGDaguyX6MsX374HoM3lVAtjEw2TZAPsAJblurHGrLVaGhWoAErSBr+oPY9+ATFxQT/pbyvGBo62qYmzRXkmbaki3ZUsUDSNva4XWb6VH/vM9B9kRtnfDNLbD5y96tSi1WW5pLDz0jmkWqAMx88iGdh2057lV/0uNiINDP3fKszOZM+MQio679cdfIqqrPlIW9ufCYjCNB7pyA6/SLnWJV2/YTXXVQRBq31VCCEYWFtb52oryb27G5MuTOSsX3TJuXbK8Mmu77gLBCYsWqKF1SMI9qu7LUXfGgqJ28yFyagUPIospOqsiW/EFV/5rPUNQAk0jpVDdEv0r3u5yWTDOuWW61GCGkCM3xRQrOo/yM/nDxWJsVcaTmsPCTk7RYm4nLlRr1ytNZijVQyWFawYKaFd3Y+m7FANk5FIU0bd3i6YGP1SYAXbx4ZpM+oZcFE1bpxL+WbPgmf5gO8ytFwEMupTN3LaPyNN7e0XORWgXDxRGVS5e2DT+nzj7xpGVcjAWowsjngLqyDxBlZTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(186009)(1800799009)(6512007)(38100700002)(41300700001)(316002)(82960400001)(7406005)(4326008)(7416002)(2616005)(2906002)(86362001)(36756003)(26005)(5660300002)(4744005)(44832011)(31696002)(8676002)(8936002)(6666004)(6486002)(66476007)(66946007)(66556008)(6506007)(53546011)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFo3N0hNdW5XUHptS0c2bzk0S0hpVGNYR3d2QjcvcHcwd1F5d0NIbEw4Y1Rn?=
 =?utf-8?B?ZFlhL2FXNzFmTzBiN0xOc09qbnlPeFc5UmNhSDd1L2JlS1Rmb3BkdERsSkRM?=
 =?utf-8?B?N1dmUW1oRTllQmJwQmkyS3F3V1RpSHRpcGEwdldBZVlmN0NNc0ZRNEt5UWww?=
 =?utf-8?B?UDNxbkFocW1nMzN6RFEzbXQ4dXZ6SEZ4Z0lXWFQvL3NnejkzejJycmhnWUNx?=
 =?utf-8?B?WTYvbUNVY3lDVzhYenIvVFkrVisvWGVRZUFLcUVQcUxsYUFrQUxBNy9FN2hi?=
 =?utf-8?B?d3lLdE9QYjlac282djR5SFdvalBIclliWjF6R2h6eVJBamZpK3JRQk5lZC9I?=
 =?utf-8?B?QWprZU8zSHJpMzFiMHNsdGJUMm03Qyt4TVgrYktSUjFIeEdBa3NaN0YvSnli?=
 =?utf-8?B?L0NDRFVETmF6MG91SlFnZjk0Szhpc0w2OExUOVlIaHFpdFY1SUNxVjlBZWJE?=
 =?utf-8?B?c0M2Z05MWmdsUWhSL2kxZm55Sm5ENUJzeXdhczlRcTlVbVZFM2I2cWJmeXlw?=
 =?utf-8?B?dlhlY0VoMm54MEx5S0E4YTNrOGJDamVpRGxHWkhIZDJGZHZhc0JnTUpGdHNJ?=
 =?utf-8?B?N2NFeStYaXA0bDF2ZkFlWVJsVjYwU3pSQjZjV0tWenA3YksxMHdLVUhXbU1E?=
 =?utf-8?B?R0JLaEdGVkJ1SzlQU21mLzc5OExCc2JQK2k4aWJoUEFKQ3g1bFBaYndIZ3RU?=
 =?utf-8?B?Tkx0R3VwK1RIbGJDMmhsQk5LeHlNYUFxOGdrVFNOcDFrR0RoeHZlNGRmSDZK?=
 =?utf-8?B?RVU3TGg1MktmYkpnR1lBOFR6TU1nRitwYy92Y2dDWlF4UWdWWHlLYkxNZkt6?=
 =?utf-8?B?aUJ1OXhqdkRKR0pNblVNODAxeHRxVVV0V0pZc1BjYnhsdmxKQjJmRWw0Vlg4?=
 =?utf-8?B?Y0ZFbEJmSzFaWGtrTWV1azFQRG9IL1g0UXRWeXZpcHp3cVBOUnJSbG1hSmFh?=
 =?utf-8?B?WUxRaDFGZklUeXIyYWFHd003NTRHaGlyN0UvUjREZEhkaERmazV0QUJ0eGRw?=
 =?utf-8?B?a0NaNm1Qc0N5ZWx0dTlPOWJkeEhtU3RUQ01Wa1AyUEdhL3ZCRmNVZDZOQ0I5?=
 =?utf-8?B?bFRGYWFidWFWVjFsVjQ2MGcwU0pGUVd2K1NjWjlONzhaYklBcHU2RGt6QUpx?=
 =?utf-8?B?elZzdmNUOG9KWklRMmNDSE14NjZLRGJ6LzNJc2VsanRhREl6Q3greHZ4SkRJ?=
 =?utf-8?B?NFptY3lGbmlKamZXVnFYWi90UGlGUFpERGEvd2NjbW5mendsTEZqSHRIcnJx?=
 =?utf-8?B?NjdtclRGTUxxUjB6dXdLYnlIWXlPeGJOcURaMmVYM3VtTDR0TytBVnAwL0tm?=
 =?utf-8?B?eTNVR1FORm9IUDBSaWhTYnVOanY1NWl4Qll4MnFQYVRZZnFiS3hzQjI2bEJy?=
 =?utf-8?B?blNrcTBYaFpuYVdWRzQwaUpYZE5GbUtaVmVXQXNFWnpzbjdMeTRlZzZ4YjVT?=
 =?utf-8?B?N2ZGalZObml1aS9lc0plU1FDWGJLYS9hbVpRTFNXWVBWaGJOelFiMVQ5OENB?=
 =?utf-8?B?M0NHRjRaTzBlQ2pYOEswZ0kxeGgrei9XaU5NWS9kV3VvRUxSWVBydEtLMS8x?=
 =?utf-8?B?bmtkZld2bFlGQWhnclI0MERPMVJIeTlXTlFWeENQL2Z2dmh0MnNCZ1N4L2No?=
 =?utf-8?B?RGM3ZWZzN3kzc3Q1MFZ3T3EyZzNrNm5RbjdVcytQMGw5Z0ZrRkg5T3lUSHVs?=
 =?utf-8?B?bWNDZnZwRDdJQy9tVGFlV090b2NHN09xRHBhbittMEFtVUNiZ0VXR0cydmpG?=
 =?utf-8?B?Z01TQTQydEZQVU9PdVJtL29RejFxVW4wOWtTa1dMYU9wZkxkVnFJTGpjSkpG?=
 =?utf-8?B?eHlsWWJOK1lFS1VPSXRSOGVuR2NZYkpYNUlUOGJiYW9oa2MyNWpCbytMbGV2?=
 =?utf-8?B?L1ZxK1hWeS9JcGRnOXdld1hBQ3J5U0RhRG0xUjNPdlEyaC9DaXZ2SElaSUJB?=
 =?utf-8?B?a1dneElqWHk3SWxEMGI1eG1XZXo2WkpXOC9veU1VUmc5cjhmS3luVnB1SGFS?=
 =?utf-8?B?U0pzYXpESUZ1MnNDaXZtSHJNM0RFU25Ld3FKZW5Rck92MjNlbVFYL1EzaFJ1?=
 =?utf-8?B?SEpsMnd4T2JibTlPLzh0NjVVQlhBT1lNZDcyb0NRQ3U3NnExV3NWdFRMTDda?=
 =?utf-8?Q?fnlk4SgHsGuJGOZkNlGA919wA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e6d450-896d-4542-e254-08dbab3cfa4c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 22:44:19.1007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFIH0WbcWymJymLmmtGrJ3mvDTUo+ni532eZIYC9ORNrwmezIZJDYgjLDulI+9oDIl9l7Vb8VrRG6ENRwvybpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4826
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 16:30, Babu Moger wrote:
> In x86, hardware uses CLOSID and an RMID to identify a control group and
> a monitoring group respectively. When a user creates a control or monitor
> group these details are not visible to the user. These details can help
> debugging.
> 
> Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups
> display in resctrl interface. Users can see these details when resctrl
> is mounted with "-o debug" option.
> 
> Other architectures do not use "CLOSID" and "RMID". Use the names
> ctrl_hw_id and mon_hw_id to refer to "CLOSID" and "RMID" respectively in
> an effort to keep the naming generic.
> 
> For example:
>   $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id
>   1
>   $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
>   3
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
