Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D107B0C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjI0SfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0SfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:35:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2328F;
        Wed, 27 Sep 2023 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695839716; x=1727375716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JzIrenj2FSmEzpKf17qv/yrw+/oAq8aAJlH8p9m2TrI=;
  b=R2n+8jrz6HYoi4vySFE3+ua9GRWYC/Y7ouJ/qIPrL3ti4EsE6tm85Ff6
   0iLVu6/KmD5KuRf4GR8FbKgI3Lh+6/hChqZsWCFPmjLSLnqYceZF729Cf
   sCdg95o06ZkMLnZG+q2t4hnWNFAP58WKA7dTE4dnf1sjAk+/S7HDrH1et
   E5ihACVMJg9VBLGul2/NY+QTC3JBTJcF7AkVsdkzwqhVg5EfLlDRXZF7N
   zhsRQe2d3gB9+LJAoV8VDmEJX/kclOQl6YJ5aoxVxEs+ofWZ4+u8v2wEz
   ijsf89qYf0rmqDUw4d5JaisYUSzoU9/grjFuqSHC+HpUIBzNLdgdkaVIR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="385764072"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="385764072"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 11:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="819542785"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="819542785"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 11:35:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 11:35:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 11:35:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 11:35:13 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 11:35:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSANRNV3AXQy+crrNXeoRoWmexy9Izv6RSWMFoPbGzjl7agnrbvF6KVPZx6NhI64UsS7TnQegmvWp9QDewDICfXWmpzBVjndmc/f7AYnhh4DlopP+RVMBfQFk9EUzo5OIpO5qY/LapU2Xuz6ijpt1ve6xVN9BDBfQCXD7drfmSWvlrvKB0+T1lLx1Zh4sal6FXbmInmI01l3s8ppd8TSzPAfBSpsmq2pk56WE5WxDjghS1D2W6C9dkI1qKRwXISMrUe0hq72LK9yhKDWXe3svJcqyEHtq6LBGOVxEk2Lr6W+F1EOw2+14Wfg4GRLxZ5QPcXZoG92xzjily4VhWGz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7q/u0mHE0GasAaZPSQnuXiY6Ru/3z5I1CbgI20heMw=;
 b=FiHPiKQA1XdRPbR87yB9bGkF7XTOeZqYZiXiyu4f+h0s7O/HaOCBB415EkUSMrVqmMIQLld/Z5iEYoM+frtGXm+mtaT+38yE3uOBCKf612V0loAeMnx8R2TvVVjqO3gCgHFWGOCEs1zhFuGbod/fUXNaLuwmfcXrwglvEvgKNvYzSvfdGG40zqVDhWdxAWL7o50WknzJONCJwxLLv+Or3O0KumAiQHQVNOQahb0Du/pKmG1vcTzrxja78mzh4Kj5bxEkAI+Ztm4DZwhkrVs/VQZQEkPb32EM5ci+WtSqvWN0WsTUhkxUbfRlJnK22LjGQwUIOMOhfhNLJhuHXJhZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8375.namprd11.prod.outlook.com (2603:10b6:806:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:35:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:35:07 +0000
Message-ID: <031ef099-a7d2-37ce-eb97-c4f7d76a12c4@intel.com>
Date:   Wed, 27 Sep 2023 11:34:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v10 09/10] x86/resctrl: Add support for the files for MON
 groups only
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
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-10-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230915224227.1336967-10-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0033.namprd21.prod.outlook.com
 (2603:10b6:302:1::46) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: c14c00b3-a115-4fe8-1c90-08dbbf886e18
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7kn8fYlrSQIVr2mkyrn4SfyHItYAQTxeVW459SqX+CL4C9TS3ruBd244Z8qMzgog7TgADmA9Vy9yXHFM2paDuUyg0w2Jjk01Hx1i3yNeAstbfLOyx2v2rT5ooVPXBrkrReMBZztLtm98bGWNdNrNR481zXXnPDkkT/z01WkSafb/p+zpJtKOei50JzrYy41G0N8yW1t6eTH1fngLCCCeYzPE0oRCUbVoRyoLHIvdvPnRVWce3THpewWY4TXl+43JqjmpEvZZ4H6P4fmD0f1cSpBM7xiFhM0jEVRDMVrK+/LiYfqzM5g43Nc9N7K78cvJTLDdq+S4h6RZ7XAa/c6FC22NtH6CEbuAChcU7Ayun73cVTYvLRvdI9UIBg9PUnPw/3b9sL/lgwjcGGoS14BFeJIKyJQqrOCTsi3j0CIC7pW7dtB430IdBJaNJ+9Bodfv3mU0A2SsdbjC6bJUGv/9UEEqO8j3/7h8D6EOfgBDsxou8n6uiK5PlMDX7wS58GdrEsOQVvXaVP4uN6ODH4eOGk6dMF6CWIMO+dX15cCjtUw/Ws5txDCFuS/CCQl/KyGNI3mAxL/9vyqHl+EZazseZ6HZ+23ps5G0IJIHQacKS8UjwcZ9ooCBdYolP6uX4v1DLcCLWqLlVXcJncQGweocA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(31686004)(26005)(4326008)(8676002)(8936002)(66946007)(83380400001)(5660300002)(44832011)(2906002)(82960400001)(7416002)(38100700002)(2616005)(53546011)(6486002)(6506007)(6512007)(66476007)(7406005)(66556008)(316002)(478600001)(86362001)(31696002)(41300700001)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNpTEVvSzBrL2Q1SWlRQWplT3MxUUhYbG9kbU5SMzY3aEV5TERZRVEveDRP?=
 =?utf-8?B?M1AyeXo5TXRURkVhdjc0L2kxTHM2YlNEak4zcXVkTWdKN0xodHBlSW9EOE5E?=
 =?utf-8?B?MjhFdGNSaEE5RzByRXFVK2s4OWhDREwyUmttLzB6RDVpdlVzT0dGSUZqaEQ0?=
 =?utf-8?B?c2VMWVE2NDgxK1h6cm9HSjJLczFYWTV6RE9tdkZEMk5aWUo0ekt2aHB1cW5K?=
 =?utf-8?B?ZEVzQUsvMzJsUlJveEgveXZzT01tQlJ5Um0rbkNBOXN1cllnbi9aUFdrSDly?=
 =?utf-8?B?Qlp1dXk3cEc3cy9NZmdvRzRaVkZOVFAxZ28xVGVMM1QwQmVVNXo5QWFicWV6?=
 =?utf-8?B?Yk9iVU5nNGtLQ1BZMDF0SU9SYlYvd1VLbXQxSENTZ2RmNG0wYW9uQWsyL3l1?=
 =?utf-8?B?T0M5eU9lVWxRSzRPb3hDNkxQZGxLbzQ0Wkc2ZmtiR3VBVmdNeWZqdWwvNk1t?=
 =?utf-8?B?M29yekdSa3loRExsZjFwemZlZjhKN2VXVU9XN1VYc3hNbWhEa1U4cUo0VjF6?=
 =?utf-8?B?QXpKSG9DUlBONWNUMVFWN0R0c2ovK0FJWTBaYXVWK0Z0NEd2YXRyZG1Xb2VF?=
 =?utf-8?B?QmJmaXU1WGtYS0hNbmRMR3RSdnZyajJNNE5ocHpldTRrMG1JdUdhZUpFWlpr?=
 =?utf-8?B?anZseGErZzd5YkZBbzJQOW1OaWVyb29RK1hWOWVFMVkxdGh5UHgwWENkNlFk?=
 =?utf-8?B?MWNnMEc4cnBpd0l0d2tJMTlBTnh3TmNPUGx5TDVXM0VsNDNiMTBjN3pHanAy?=
 =?utf-8?B?MmV1RWRVRGN4eG8rVExvZGxkU3lXQU1ibGJRalp1Vm1CQ2hydWtEWnBoVWYw?=
 =?utf-8?B?U3NyRlYzU0NUcWlrd2JaS2xZcGdXZEc3TmlqdXFLSEQzZUJkbmdJZUhHQ3dj?=
 =?utf-8?B?ZW04elplaEk4Slo0clRoWldURWhoRkNLQzZtc3ZTK0VjUi9MejZKemRsZEhR?=
 =?utf-8?B?b09TdU1NSUJOVC9TOW1pblVhRk1QaCt5T0xEemU5OFFYbStySmMrckVibHI2?=
 =?utf-8?B?MGR4VndwOENLeW1KZW4rYmhtdStIK1JrdC8zaGdlUiswQllGRnAwSi9DU3lH?=
 =?utf-8?B?aHROZ2RHUEF5RElBQjhkeVk0a3M5VjhOSVVnWko3ZXRsWERaeE9ITk8wNXZp?=
 =?utf-8?B?RmZEOU1aYWZSd09rQlVsc0pwb0lhTDZUc0hXSjhJVHhwajBkelZVK1FRa29z?=
 =?utf-8?B?OVpTMUl4Ky9rMjhEbVZ1czhvZGkrNGZEOEI1dWdMK05XRVVTaGRMTFlKZGI2?=
 =?utf-8?B?LzhPRUIvTC8wNUlac3BuZE1kZ2FrNWdnU0g5ZVg2QVJjM1AvekgzZTQ5ekhV?=
 =?utf-8?B?T25wTXNYWEx4Y3ZqbFp6ak1nSE1TQW1lam1MQ3BDKzZSWlJxWUFPQ1RDTkQ3?=
 =?utf-8?B?M1lvcWJ1cWtYUjlBWGRvTE5DSGZOaGZiQ0hSYjF2ZVBIL1IzNk50UXMvMThi?=
 =?utf-8?B?MWM0ZXhLZWJtNnY4MHBGbXVyZXV0Lzl0SVpPVWZpcytzVEVnRXRiOUEzTVcx?=
 =?utf-8?B?OWFsZSs1VVo0b09aVC9FS3JCSFd6Sm5mTVo0SEk5MjAwb2U2aEtuemJzcWFv?=
 =?utf-8?B?WUdqRGo5R1lDQmhvWHhSN3hobnlOU3o3T3pRWlBMcW5jbmJNMXJGOGFncW52?=
 =?utf-8?B?NERLU2RSWXVyeG5FbnVQZ2pTK2NZYzFBK1hUM3kyMGxyaDN3K2lheUNtNk5Q?=
 =?utf-8?B?ZHJpYWUzKyt1NUpKTmpocmc4YjZ1UmVHdFFnVllEUFdqa3B2aVJZeG9aYmJG?=
 =?utf-8?B?TDk5Zm5oeUZRU2lRYmJsd2N3VHpZK21BS1JQTEgwSTI0L1V0eGEvYi9OSS9N?=
 =?utf-8?B?T2VOaTEyUTgzMUNua1pQaGlMc2M1L3g2VjJQQzNkUjF0MmsrRUtFelQrWGZy?=
 =?utf-8?B?aGphWXNUdExPNUtNNW03dXo1ZlB0V2xhRnZyaDdzcC96cFZyYUcvNHNOOGtr?=
 =?utf-8?B?T0FnWVhVRFVqQ1JpSmFUZGZsY2tVQURwZHFrbEFJQjRVaEFwTmhieUxURTRh?=
 =?utf-8?B?Y1BRYUZtS3l5NXVNVVdITVU1RXN4MWhrMWgwUThUcEk1R1BjcDVPNHVld2gr?=
 =?utf-8?B?d0ttS0doYkJOcHJ5RVA3Z2ZDSHo2UVhPMWsrc09YNlFVNFBrcEJnVWMyaGU2?=
 =?utf-8?B?Zkl1dE0xNGF2NWFpRUg2cUl4dUV6dk5rYktUNW11Z2RuQzlFdUpNS2FzTlNi?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c14c00b3-a115-4fe8-1c90-08dbbf886e18
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:34:48.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPmLahtsamS5P3Yq/qLnWa7oFpKYKhP/GDNhWp5j9phqYxVVmbw3IHB411VOPWjeOgcsnH8fJFJ8UPQCIywEWs6Dik+j2wMwzMOdMiAZ1n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8375
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

On 9/15/2023 3:42 PM, Babu Moger wrote:
> There are 3 types resctrl root files.

Considering patch #4, should this be "base"?

> 1. RFTYPE_BASE : Files common for both MON and CTRL groups
> 2. RFTYPE_BASE | RFTYPE_CTRL : Files only for CTRL groups

If (1) is accurate then I cannot see how (2) can be accurate.

> 3. RFTYPE_BASE | RFTYPE_MON : Files only for MON groups

Same here.

> 
> Files only for the MON groups are not supported now. Add the
> support to create these files.

This is not accurate. Files "only for the MON groups" are
actually the only monitor files that *are* supported. The
problem being fixed here is that monitor files are
not supported for CTRL_MON groups.

I made an attempt at rewriting this commit message but I am
doing it quite quickly so please do improve it:

	Files unique to monitoring groups have the
	RFTYPE_MON flag. When a new monitoring group is created
	the resctrl files with flags RFTYPE_BASE (files common
	to all resource groups) and RFTYPE_MON (files unique
	to monitoring groups) are created to support interacting with
	the new monitoring group.

	A resource group can support both monitoring and control,
	also termed a CTRL_MON resource group. CTRL_MON groups should
	get both monitoring and control resctrl files but that
	is not the case. Only the RFTYPE_BASE and RFTYPE_CTRL files
	are created for	CTRL_MON groups. This is not a problem
	because there are no monitoring specific files with the
	RFTYPE_MON flag associated with resource groups. 

	A later patch introduces the first RFTYPE_MON file for
	resource groups so fix resctrl file creation for CTRL_MON
	groups to ensure that monitoring files,	those with the
	RFTYPE_MON flag, are also created.
 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

I only have feedback about the changelog. The patch looks good to me.

Reinette
