Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB807B0C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjI0Sfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjI0Sf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:35:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BBAF9;
        Wed, 27 Sep 2023 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695839725; x=1727375725;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sSnqKwznZ643tdWp7bKokf1XL8PGHFesLHbNZE3xMRs=;
  b=l77gC86/aFh3+6YezXPBLasQvL9j4EBVyELTNQdK4nmje9JFE4MX8VXG
   Pj8h6ZdII7+zzWvVcc4y8FZ8fIYhcOD57t2xq1wbQ3IlhJ8odG9wTK9bQ
   yCf121YejAR/XugnxrSTAi9mWfxCJusMolmtSFGNhGYYJGmZba7o6NwG+
   LkEAF/uat1XTkaN9ksixTklcVUW3VaHKIeBZOzdhJ1gH2YANmBtYYVkTl
   xBbTcUFVBddKc5W1DDZQbn9qiAsMCOu+b4lD4GLWQfcFYsq9CcBaVAU1W
   kYoxqLx6UygO8lm1sa4oCcXCsdovjLNjDqxx9hUpSSsiPCqv9CG1fZK2G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="468183572"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="468183572"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 11:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="725924688"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="725924688"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 11:35:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 11:35:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 11:35:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 11:35:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 11:35:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWKSYf44X9qgt932gz5JWv2xwjWlYQp5rmGO8sDU/Ni/9FHOLGjtnJKCpj6VX5GTqTyNUSHehP+NzaZ1MnEb1XA52/LkCH7SR2RidBL+smHuyNh4Q5/1S7Z6k0g36dgF/t49qw45hiUvnuEoZJBQKUtK2KRu1iVIWYgbH+59bdjaA0U9M1QqgOwbkZEM9dCPkXANtERPFgShA7V+bCQg6YCyXPzfnNYw3BYoQfeG8fvO7Rv0nP5Nnjfh/dl0I+D2by383701mt4AvPdwQgSg+L6LACK2PuI8pKqjIyLwZqqo8UTSX/RLBqiShFJxLJx15JjxcrjBVsHd4jGr6ZSovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAWKxSMHDir0y6CCD4783t8De5x2DtDaecih8nlc7UA=;
 b=HmIHUKqoK+XxAhbeT77IB+EDL8AU64WHls4BoaUIGEEDaVpHN39DlbP5p0mMFagIchUWaMwZ+wgaRzft79fRXOatuFYeS98Lz/CnupLOCFsHEnC1w/TUeiLA9vW1Q7dwk3qO9VbJItoMLckrQ5ZSABv3l0c3FDdwTLmOLJWzWG61aJti3kpXk/27Z2MFLy6RBEq7bXZO3T88SUhDMpJEdkIFnfBNwb8VnNGDIYELp/fAkBI9sbA4PDwOjuqWM5EKPgWB2CNgKLH2es+gSXQoBSYk2O3g/oWWs9oxVD0/uPtAZe/LE4sux4uUe0uOzs99mabZtb5VD8Zv0T0Ih0T5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5240.namprd11.prod.outlook.com (2603:10b6:208:30a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 18:35:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:35:18 +0000
Message-ID: <5305cedf-80e7-aa87-1566-d1cc102c5cf5@intel.com>
Date:   Wed, 27 Sep 2023 11:35:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v10 10/10] x86/resctrl: Display RMID of resource group
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
 <20230915224227.1336967-11-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230915224227.1336967-11-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:302:1::38) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5240:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b868d3-586c-4755-3503-08dbbf887fc9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1B5QI6XI+VLYBsFDT8hCiG1D5+eh24JPpZmvjzXiXbPQ0atJfuK/IoLb0qK4xVlyArAQ8AE5F6UuT4DBxDLRPnLwv0HtCQU7mXkiuOw4xqx08DxlTwKTuenoCJjhqMuxP+h+Vz00zmXeYzrMg5Lxg6wBFGAzYJn28ffbIs8ZY/L6MUHlgYrxi4llI45RFLWhmjbi+A9gQ282N8iZhUd3KtfxRT1DT7tpLDy0vdJUPhJ3SbX6crnLYo6aKfxDbYjySp7LSVjoCkGeKL1jiaxdaYtPDfQxufBrz+Fk8YI7zIvvgAuOtFUbqRhpQlf5NWiuKO+165rxBYpapAM8S8/qKCdFDKD7Dyp/adiS1aTwDoewKmc4WVO72hVGcBa1oW+neFFDNrh21Q5eEEka5MyaSr2PWcaRDSU4PoJ/kjTqCRwo+I4OkGUotp63AnFFv4kQINEuhUDnZe71vTSUCYTx1+Vf9p4/eWLxePSg/kJMCtybIYdO/LVjYbqxzkhBMVzEWNdKZn0TVKpLAzlrGvQRrAoBGJEOmfHUovjL9+UOfWKeSodmC3rm+bI+k0ggxg/qxg0b+ck12HBODRpZvTx8RinVCoY8T5E4DmMJU6BSLiiFw3XPfs17cvgr5zWNyHNy6gBBcsP5kBaaBYhFQqIzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(31686004)(6512007)(41300700001)(4744005)(316002)(4326008)(2906002)(8936002)(53546011)(7416002)(66476007)(7406005)(8676002)(5660300002)(44832011)(36756003)(478600001)(2616005)(6506007)(6486002)(31696002)(38100700002)(86362001)(66946007)(6666004)(82960400001)(66556008)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU40MFdpV3FNSVBsRVdPNG9JaThuNkt6Vys2MFc2OGhwOGN4TWxLaXkySmVp?=
 =?utf-8?B?NFBQd3FIdGZWZDVhSEtnQ0J1SGwySVlHZWpubzZCMFl4d3o5OEd1c2dIazkr?=
 =?utf-8?B?Y0tzVzZxb1lMQkJyTWZPWjdWb09YQ055MHl4NkY0eU8wcnhkM291eGROL1Mr?=
 =?utf-8?B?bjNleFlqUFB4SzUxOEE1M0JlMktuNEJzQUlXTDRwS3dnVWVPMGYyMlFzNjdk?=
 =?utf-8?B?MmZ0U2VwQTYwU2dWNGVTbXBXdVNBNDFKTElrbTNmSDlacVNZQVRmcGZ6QXdy?=
 =?utf-8?B?aldDajk1VDJzTjNmbCtLOXFRWG1FcGdjK0pneGJqUHdFdHYyaHVMbE92a0Fr?=
 =?utf-8?B?dWJWNG9WYllHa3p5L0dxUjdMWUwvM2FlTkhxUDBYU2QrOTlFN3Jwa0dHSnlT?=
 =?utf-8?B?QjZYb21qNDdQeTk2WkxGRy9EOVM4ak96bzZSY1dOR2c1ejk0ZWdLWG5SRzBZ?=
 =?utf-8?B?S1haS2tEdFM0ampGYkcycjhvdUN2c1ZnQ29LbWcvbGV2NndpWTVnRmpsUFIr?=
 =?utf-8?B?NDI2cklKWkdNQ0lvL1ZsQ1l6SlBWVGJBc2dCUDhnR0RvNlBIQ1VOK1ZUNXdT?=
 =?utf-8?B?bmpibXVMR1VBaU9mb2FKWnhtZDMybjc4TTBUb3NCaXZEYWJkejB1eUtTeFhw?=
 =?utf-8?B?MEpJUFJCc3JpRzdicDZpRGlsdnVjRHNQV0dxeWVoN2NwUzhSRnV6SEc2Wkdj?=
 =?utf-8?B?amRXQmZjamJlY0s1RWgxbVpKVXNCREMydmViUHcydW9jN0Zwek94NGVUZ0xZ?=
 =?utf-8?B?eFEwcDFqdDREUjl5TFhzc3kvSytPdnROVWhIamd1cjRpZzZLaDV6SXJ4NlVT?=
 =?utf-8?B?cFVpRTJKemJIblhTK0ZVdzhKODdtV1pNZUs0VGZEUzNCUzFWZDdMR0d1bHF6?=
 =?utf-8?B?U3FTZGt5TmlEdjdIQTRWZXJZTFEreUk3SDJxUmtFbmZnZ2lqYUh0eHhqZWhQ?=
 =?utf-8?B?MnQrcDgvc0NJaVZ2d3gzcUd4N1FobjlWUXY2QWM4aXgzMGxCbHVoeTREc1Uv?=
 =?utf-8?B?L2R0YXk5eFVsZGNkM2tTRWlwL0d1dm0wRmlwNjZackpZVHFra29IMm52Vng5?=
 =?utf-8?B?KzlObjljTUxaRjVQTUZDY3JxRU45YnM3R09yMUZBazIrWFA5NHM1S1lDNGY2?=
 =?utf-8?B?TVREUTNpTDZGMy9ab3hndDlHVkh6Y29kV3VqOVhRWVRsc3hiTUZsRXNrMVBn?=
 =?utf-8?B?VmowaDVCcmxETVI2Z1l0c25NblVOWFZTbXlqMzlCU3VVdXZIeUF4U2ZJMGlB?=
 =?utf-8?B?Z3h6ZWxVVW9uYVVjU1hjSEVuYlB1RFgrc1gwTCs5aE9zamFTOWc0eGpwbWMy?=
 =?utf-8?B?RWlMVGtJWTBSVkNlVTFwVVpVWWVRczEyTnhEenFPaERudHRZcGc1TFplYjdK?=
 =?utf-8?B?Mk1mVnNaM2FOTnJKb00xQ25RTjNqR1FyN2hNSk5LSXdra294dHNGVTdwTW1s?=
 =?utf-8?B?TmtqZE9ma1JlNTFBeGJReTBSaFRVdjhqL1ZmNncvV0U0cXV2Z0E2RllxNkVG?=
 =?utf-8?B?TU5tY2NPN1IxeE5oRVlvcmZWREgxbndsMTVrREVxaUs0L0tBNFNKNVIrK09x?=
 =?utf-8?B?aklCdk9kZk9zek80Ui9aeENOdVhYd21HdWZWMWg1K0dCemQvYVBNQ09ObG5M?=
 =?utf-8?B?VTg5TG92UDJHelluZjVoODhlcFFkenlOZTc4aENxcUx1VVVMSFFqU0l0b0Fy?=
 =?utf-8?B?THZWOGU0N1Q0R0hQRXlpbWNLb2R2NUx4Z0xPQzVUckJjZnpVTm84Si9NU3Rr?=
 =?utf-8?B?TDFSNC9HbkV4WnMxK2UzOUpYUDlyVkVVN2ZFRzZpYVZJQjdnRTFqUnQrdW5I?=
 =?utf-8?B?TkFnRjlDRHU3d3VXYjNPanFaTHNWa0NYdklIeEFzTGw2ZkhkdE9QN3JUQVpm?=
 =?utf-8?B?OURpTGN3ZVV3U0x1bDN5S0R3dlF0aFJYVjVxOFFnSHMwVll4clNuSnZpYjE0?=
 =?utf-8?B?dlVjOTR3S2E0ZkV0Yzk2bmdJNnlVSVBCK2o2akU3bmgxYkJHVHVWanVQNzFo?=
 =?utf-8?B?VE1zRmV0UW92NUcvaGJQTFUvcDc4MVpMd2ZaYU04UHRKYmFrYnE0VlpVVGZq?=
 =?utf-8?B?bXFlL3lWWnIrSFJYaE5vNkpTV3NYYTNVNzVld0F6MklNeEJIYzFyclo4U3dR?=
 =?utf-8?B?VlgwS1QxbVhmNTZJZEhaT3lQUG1sVTZEZkJ0d3E0SEx6cVVtODFwTHBBdU5z?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b868d3-586c-4755-3503-08dbbf887fc9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:35:18.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIi7OGJi+XgB8zKgNyr4CgHNf8I55SZy9F7b9h6F+nbdXBOW3muSjUHhBac2bGaGbgCGqrW4yhfVeE7y+4G8SefRgnlk0pr9xMQJZSBs6bA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5240
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

Hi Babu,

On 9/15/2023 3:42 PM, Babu Moger wrote:
> In x86, hardware uses RMID to identify a monitoring group. When a user
> creates a monitor group these details are not visible. These details
> can help resctrl debugging.
> 
> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
> Users can see these details when resctrl is mounted with "-o debug" option.
> 
> Other architectures do not use "RMID". Use the name mon_hw_id to refer
> to "RMID" in an effort to keep the naming generic.
> 
> For example:
>  $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
>  3
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
