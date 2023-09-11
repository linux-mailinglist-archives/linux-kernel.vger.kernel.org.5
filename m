Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C409A79C37D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbjILDAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241334AbjILC7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:59:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AE649D2;
        Mon, 11 Sep 2023 17:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694479660; x=1726015660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jyRHiFiNogjeIY0fzNoFl/X6bONEhijt7e2y7QA9UMM=;
  b=mA3L4mM3xyN+t6XcKqg40IkBKnL27hmrnsGc50jM+2bsZ1jpBW8NapmM
   pCN41g2gjaY+2Sea8EuIncv+9ChOJFZ8MXzH5oZ1tatyCAl8/pTTR39xt
   gSxx7Ab7tm71fKYnmR1lekjdiet4osGrZqy/q8CctNm78nkQYKZljndl0
   w2YVBEPPeY1xGQ9iSBIyEBzjLjdL+IiQ0ifDVZ4fnss9i1f6d/xJIrL/3
   HSmYOtf2QYW3Kzzj1v8e6JyED2KQG2vJsMIY8gEEJCp77figpMXn6zZWw
   N+gEmel+9ribua2bJ6gNViBYmroqQPRTyLYq5Rtx436eunJeTWhZayEAq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358509485"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="358509485"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 16:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917209507"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917209507"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 16:08:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 16:08:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 16:08:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 16:08:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nozZo56+jSW8sVg5Jd0PSGtkLrAKSMx0GwLq++NUQ/Cc1OnyziCPRYJ73/6NCy/2Ku/FmL6swfuYWVjtU8GEeivgg1edx+g4Fya+0UpcdzvDhROMGO/jbwWUcKbgn3p3V1TgokedcLhG3BhY32K3t5tJdFxwgNv3BRJS280ANVrgo/ms8vO74TWvz4AlKh5++rB9RoJIyv8IqRVOE7AXPv4CXUhFSmzZwOZK9LOM/Hx13hkbp7Pm14TBWuNvVi6WVQr91ameZfcnFx7L3uyyVj1EsHPjZ5Fvgp1IC4J52+Jid0cEymTXb4rYvelbtwTTijJi2R6domJk1/CUgofy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Rkx5CZ/0hAgkE6A518yVZvbIJLRpFWm3dCOTZwWO7I=;
 b=YMgQrRo2CQPy78fAyEwv19cm6KVast7OI3zLMj3glhlmMEerpl7e4u59l1shKwcXFYn5igAsrYd+nBgSzzAbHjpCHVTljuaYJEHGG3PjQ8KcFkESnF/TrsVaFT6LiL8H/dhDyf6xo5lILsuUZ5W3+nqAur8CbcI+H4SB5nSbetoo7o3dGY09QHrgMISpFZRaHTr0IYYVGOf49Sx9i172VkbnF42zv1BnJuwTRSsuS25B//AO1YkOsBU9baH8z70cQjTTR2BQx2224bOn46VI/YViY+ZKT+LBtS+BWetDL39iUZHT+s7S4x8NSQApiSqrGWxo9Tc7asz3bbp6wp19sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5516.namprd11.prod.outlook.com (2603:10b6:408:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 23:08:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 23:08:11 +0000
Message-ID: <fbf1f7e5-1a82-303c-3802-2f246505c8a4@intel.com>
Date:   Mon, 11 Sep 2023 16:08:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v9 9/9] x86/resctrl: Display RMID of resource group
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
 <20230907235128.19120-10-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230907235128.19120-10-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:303:dc::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b181fef-af2e-434d-f942-08dbb31bf875
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwZYNCNtXJdRYLzNrYBZ9ll35r+J89zaQiy6632qoho+9sQnzU6Xa8IzLbaPsX1B+/oOs0k9MhADrH14RbM/qle568rrJpVbI+hXCib66DgTZHBEaIrUmf9FziYtohXOewC4MCGWmTTcNKzXQzlnCkwMD3nhgf4yZPDiTconrIrEK1o4XKFU7eNfKeaufMGNwRdSrLrutAIIyq4KDcMO8jA5sGBDfGskHrbgkNizR2mo2Xoeu55XmuT4Kw0KAmYRv7x95cAW2Zf14RPfEQumUI+cTn06euE+WB+PotHCEy/RTptwzvrOWLVXicmS4rgz5hpRDTOI8WYx2Wf/QW1kwO6MNuI5aTbrJnX621pQ3tw/3yIP92x19M3OzOc3rSu1QfrnOsA5sVPxtUaxeZjyV649Q1YJDarWEf65DGSkuuF+bsqX6EZHam9S0bhquY6QnEqP02KD8IC8uXJuoTr4Uy2xntJ39cKF+ON9hLiGOdMYlVQXlrzbFLThyByX7Yp0TQk/MbbwIqzMoILM7V2d26zuTLDwp7dYq3c13e47Ik5Qs1psQTZazy+34RSsmXmxW6fTHhLJWzW/cZ152ygH2cOL490hfbI4gbZT5dXib9VdBEw4/0kCM+BMWuG6cAPMKmPTP03V1G9NvqpTsxfQRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199024)(1800799009)(186009)(31686004)(6506007)(53546011)(6486002)(6666004)(5660300002)(41300700001)(36756003)(86362001)(38100700002)(82960400001)(31696002)(2616005)(4744005)(6512007)(2906002)(966005)(478600001)(8936002)(7406005)(8676002)(4326008)(26005)(7416002)(316002)(44832011)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUgyUnRiRGUyNkVGcEdBOXdScVhpdHg2M0Rjb3kvMkpVRzVaREhEQVRyZmZP?=
 =?utf-8?B?TXp2c3ZDdll3WlNCVW1LZVg5UDhsWkNWbzYvSlRxelpLcjZsdER5QlJSR2l2?=
 =?utf-8?B?ZnBWWVpmTzZHdHhleitYNk9xN2JneEx3Rk41Yk5kZWZXU29yZ3hpM1pxMVVU?=
 =?utf-8?B?dEk5cjhkS1NWb0tTQ1JHL3p3RGxxOFZxV1RmOVViaGxTYjJST1FRL1k5TE9T?=
 =?utf-8?B?QWp2c01RZlpQenN2MzZvSDNEWTlKZE5ySVRrZlM2UWVFTStDckk1Sko3Q3c5?=
 =?utf-8?B?djhmM0l4NnVxWXFvNWhRalZzcGZSQ0ZWa21ndEV0d2xOZFR6NCtwdWdXRHZr?=
 =?utf-8?B?S1JhMGdmT0FYRFdvalEwdEpSaG5wak1mMUVEcm8yMkRmSC9SSEF1cFIyejZ6?=
 =?utf-8?B?L2NkMFZVMXNpcDRRT0NuQ3FHOTg3clBvcEtQZGM3TWJCcHNIN2U3YkZUOUdF?=
 =?utf-8?B?eEJ5V21oNmMvMnc3eWZHMk53ZjNualFHRStqZk1IZWMySDd3b042WnFyOWVV?=
 =?utf-8?B?emU2Vmozdkx3c3dOZWlwTGhxTDkvY2VNUldJdTJoVW5RN01MTVRYOGhwTWdx?=
 =?utf-8?B?WWFWeklPL3QvVDFhaEF2QXdIeVlkYU9kd0hQcHlDOEJ1MlRGSE16QnNxSWdB?=
 =?utf-8?B?MmJFb1Z0alBCY3lrZU5JOUtrQXFFc3NjWWJvTThwaGpIZFI2WDV6MXl6WGxX?=
 =?utf-8?B?RUZEbmdPQWZvakRJbE82U0E2bWpXK1ltYkpCY1ZHZmFXOHRPTzNRUCs5WWVW?=
 =?utf-8?B?Y29QeVFBM1R0VVN4VHB0bXdMMjJDdm04eHljVHBMT1dRSnAyTUZ2TEUvNXYy?=
 =?utf-8?B?elExV0VBSjJNWTdYdGYvSGxyVDNPQlpLYzk0eXhYSkVNT3I2Nk11emRQV0NM?=
 =?utf-8?B?VTM2TWRXbnBiMUp2YkZIejhQQkxkY3FtK1ROSWZLNEg3UDFvemVnL2RLcy90?=
 =?utf-8?B?WmF0NC9ZUkovMHVVWnhMYmpoWHphUFdCYldKWE9Va1NjS2xERGV2QXpOR2s3?=
 =?utf-8?B?R2g2UGpweW9WTkVmaGFza3Bnc3BnQVR5UVoreHJsWmIza293QXB0azAwM29w?=
 =?utf-8?B?SExncTRJb012WHRVVG5pdnZBRm5mejRKSjFQamhmeDVmem9Rck9lODVHSmUy?=
 =?utf-8?B?K3lFRE5meWxWbVpPYkdUZmVUNkZOODNtV3VqZkxaSE5nYzdYVnpqZU5PSHRu?=
 =?utf-8?B?TEh2eU01ZVJQWVoxVXdWMHYwNG5Ib016djR2UXh6K0VXUlRIUDc2VWhITGEz?=
 =?utf-8?B?UFhqc1F3cTMyQzdnNFlNNVduQUE0M1cxUnpaUmp2ZG9PVC9kUExnc1RQQ1Z0?=
 =?utf-8?B?SW1aQUdMbDh5anNGUHRFZDF0d000Q1gwcnJZTUY5Qm5xTHhmWU5IRldoWlVC?=
 =?utf-8?B?dlZUekJRWm1hZWthSkx4Q1BQMTdxOGk0TllFbHB2bC9UcmxRaW1FMWxDcXl5?=
 =?utf-8?B?R1pxY1ZyTnl6T1VZSllYVWVCL0dUUGZjcHZqSFh6TklueElvUUdiY0JHOVRs?=
 =?utf-8?B?VkpLS21GMyszMndNbXJRRFJRK0dsbU91dzZ2VG5DWEFpVU1GUmprZFM2NXlq?=
 =?utf-8?B?MWk2VXlDNEJRZjhTMXRvaGluZzlpeDh5RllyMjJUVHFrL0ZmWThxVWJFaEVp?=
 =?utf-8?B?c09KSGJOSlJEenVUK09OVWJBVnJtb0hoUXJXUUtnVjJ0YVpNU1FmZUJWM20x?=
 =?utf-8?B?TThWQzBOUVg1VTNqSHFoWlYvN2I2aDcrREMwZzJYYXBieFRxb3RiNjhtZ0tq?=
 =?utf-8?B?aUcydjNVc3Q0dituOUplOTN3OTlEbmtORXM0bUxQeU5WVUd5STJianY5K2dC?=
 =?utf-8?B?R0IrdEN2eUVEU2RaK0QxNUlWOWZRbG9pa01ncUxBNytDMTJVdE5jWFI5ekJr?=
 =?utf-8?B?c0lUNnhiMkk5ckdVay9xcXB4L2o3MS8rSjJLZVdic2gwMUYvWlVGV0h4Tm5C?=
 =?utf-8?B?dW1FLy80YUk1VDBVMm4vb0pjSVp5c3VKWEFUREV5OUl6NHFCRUZzbzlObmJa?=
 =?utf-8?B?VUV2cUx0MmhLRHhPb0pLMExPTFNieTFkSXM0SzRzb09jTlhwK0xpYlJyNUp6?=
 =?utf-8?B?T2o5SlA5bWxGcDkxMy9qMEM0S3NVcFgzVlBwMkpsaHdIZG5FdGwydGRaaDFE?=
 =?utf-8?B?dlAyQVgwN3BON2RNaVJoREVyWFFUM0dzdzJQQkZmOWoxa0VTNzhWc21YZjNm?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b181fef-af2e-434d-f942-08dbb31bf875
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 23:08:11.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HF9CYAhIFDAHKxTprlBYq0WzwfIOVR2wD84+3Rlam7/qbS7oHRoUlupZR3WrNRNI0DtjTwUPFa+KzAv9l0dYqeIqCNxfi+m2wGrXw0X2EOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5516
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

On 9/7/2023 4:51 PM, Babu Moger wrote:
> In x86, hardware uses RMID to identify a a monitoring group. When a
> user creates a monitor group these details are not visible. These details
> can help resctrl debugging.
> 
> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
> Users can see these details when resctrl is mounted with "-o debug" option.
> 
> Other architectures do not use "RMID". Use the name mon_hw_id to refer
> to "RMID" in an effort to keep the naming generic.
> 
> Add the flag RFTYPE_MON_BASE, which contains the files required only
> for the MON group.

As I mentioned in [1] I believe adding support for files with RFTYPE_MON flag
to resctrl needs to be in a separate patch. With the core support added a file
with this flag can be introduced separately. 

Reinette

[1] https://lore.kernel.org/lkml/2feb3e01-96c7-fdde-a0d2-509fa1527243@intel.com/

