Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606E27BBE13
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjJFRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjJFRzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:55:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFDBB6;
        Fri,  6 Oct 2023 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696614951; x=1728150951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iuKA6zyJDho9kCNS2+GvhK54BYkGXvd/nkcWgSB+dpM=;
  b=D7Fi04b7ppudMU+3hTIfHxQ6lqjU9B43rWQsLI9iDJ1Z2CRoV2SIpdfu
   dxZiwGICR8pNsd3U6nZWXzh0Y+YEiFmk03G9TOFTSSytlL/xWg+WxOwVf
   s9ZcyPNmVe6Tpq2awq0KLOTY1WrW2H5pzoA5rU+4k+aALeTVAxg42zH0G
   7bVjxzLelIpvrUorD1wBb7DzTRRl/q1QRnEFA1rwmy4doKXlJhZm7HCz9
   4TFbhyXEfl2RfkH6MY5S9Pcg89bT0jNiPMktD6j4LLsyrDAxQmkJBLNRa
   9beKTnRz7zWfQANNfWfz5duF+pe4A/vHewaLSQPkHKvTRkw1c9ekC33+n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="386625076"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="386625076"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="728917956"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="728917956"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 10:53:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 10:53:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 10:53:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 10:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjNZPmq5ctM7JIK/vAhAq1MUsUPG1OL+UrZix2xvmgeNvmrmadiVkdxQPzuAHoAevQhW314xwvblE+nxPSEAFcPlV6M15BrRvPP58yMHxQHrcyRUuC1kWMcj5olpN4mMiFx/BPB6kWB+m2k9FF4QPB1ezOgRs6QSNmZnG6VZ/vaC5UzoSce8sOPmjwz36zlohWSpQSIDNUbFi3bPvgqYVjRgSCegOTfV4BnaljGdDhkf94jbruLamoh7bYnaIp8XKCa7pUwhgJnyx9Py/KYlWBigSmocMk78x1BgD1ZT53j5qiWwKCVxDh7L3J6PonhKqla7eudbzvYrk18ciL5FcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUQatUPc7Q3bpx2KaJPi4hgdA/qa1vXGuSEwfdBdlSI=;
 b=ccM3LmTS1l1PKMsrTH4HwsndXBj6G3Q2wiw7WIUsd2rH0+GDkvn8dibxi3PXzZlUUcTW95Fg4ZXbxvqGRVMj9TrXFcUSlVC41VkOrFwx+mMDvcI+GTXwdA1hAUtRPTi2DeKOP/SmD3330aGlZiiZwAgmCCfTQ3hGN2LP+OhfapdozkO0mHrkKHEXSd12uQQyHrdZ0f1TlIh78VK/JJ0z0d9Xn6zv5CvKYNt533SGtk8gyLqHOpUhvYz7j+WSf8fAtwThPe0Jne8E6nnBieCYoxTPRczdG+J9/4FvfyvHLlj+DssmDcSQG9IQ3ty2ActAMJd5S4GhI1Ad4COj6H/FrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8116.namprd11.prod.outlook.com (2603:10b6:8:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 17:53:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 17:53:10 +0000
Message-ID: <b08ebaf3-6fe1-4677-a4d7-2c0e530153fa@intel.com>
Date:   Fri, 6 Oct 2023 10:53:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/10] x86/resctrl: Add support for the files for MON
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
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-10-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231003235430.1231238-10-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:303:dc::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 0959f965-0331-483b-273a-08dbc6951a46
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltsB249U/a68q1DUU2SyM2GqR/wtyxxbQ4tcUYKrfXtl1N2C0CSpuWuZCbPshfLcXslkRRQggDPEwGIwSB3QaFujgcNdlLjikpdE/H07ZLSEsNWhzd5oa3f2M2yxwX5TypsXpce1Bz0Kk1i1D196l1/80pF2Ju5xIxL8zK/Lsyz6ljSaJWPS09wAJRICfE94GR4QDpis+JsXRsrOXdN7VZVX3r3Q9ovy9jtwJtAAB2aoDtXcD3GQDl4B9F0czmjevTWamEdaQPPpiag9s8GC/+8x7X2Csb3rf0Lk+bWsfzAr8oTCKjxE4uzYW1rgUIzulLy5sQGbr3tsUDPgawiyTVUU6cuJFniLmLadkPybnHKOEhQfyhFfsQ4bhhZ6c1crXIwBpCKJ1dV2iTGgItfjv8NHKUj4nM64wMPjwGKYkDCXYXQdRardILwWYqH71DJhG5TchI/vSs2oNzoBwXnXc3kkC6Ce0VPgBb2vxYv+QoJxF02OodvB9OGtc4tV0XHfgEgJgf9p5nECgYmYbd/fBg1D5h7e8qSFvlDTkcPIvLqjJMRGNTw0zd7cRf7ls22oLoZn0NPG7vP2gTZv3pLEe5dHXhIjS7LXroCqicC74BGIVRDri45ODunX7xN2yzg/a/ttYCmvEJb3bXVyZNgqZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(7406005)(31686004)(7416002)(44832011)(5660300002)(8676002)(2906002)(4326008)(8936002)(41300700001)(2616005)(66556008)(316002)(66476007)(66946007)(26005)(66574015)(36756003)(6506007)(6666004)(53546011)(6512007)(82960400001)(6486002)(966005)(86362001)(38100700002)(478600001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0ZNd2FCTytjZERydENsTkhMVlpWUk5iOXFJU2E0Mit1ZnhMM1VKYS8xS0Nl?=
 =?utf-8?B?WmQwanovZWFCQ0kvcTNmSXpxM2tYZlJyY1V6TEN5WVZnRllYOFlSK05OT29l?=
 =?utf-8?B?a3RiMGFmQlRFVG4weHV6ZTVlVi9ZR0FuWDgva3V6N0hVMkJyd0FHc3NXZjFO?=
 =?utf-8?B?MU56WGV6ZTBGUW9oU3ZwR2hPWmVFV1orRzJnK0RTVUYwK1VORVJYd25XMncy?=
 =?utf-8?B?Q01aK2dudUhZRElHWEJ5TGp4cnl4Y0ZKbHBGMGdYTjNGYXI2VUx6ZnA0QTNw?=
 =?utf-8?B?VnZlTVpKWmZpeDFSQVNWVVppTHZyVDhqVGJVcHFKaVZaY2dvWDhHQS92Z2hV?=
 =?utf-8?B?KzVKVkpBU0pHTUpyQUgzM1dmWHJHejZEdjAzaGFUUGhCem9TcVBPaTNKSCtZ?=
 =?utf-8?B?N1VUN2pkVGs1U2txaG04cC9nRmhqY0ZrbkZkdDRnRWpmWUlWOTZyY01pcFhX?=
 =?utf-8?B?L2U1VHRiUVhVMnRPdE5ONkRlaWs3MDF3OUNhY0c5ekIzcjZ3SE4ySWFLazJZ?=
 =?utf-8?B?R2hFU0lPQ3AyZ2J1ckFXM2JENkNTWTMzbjZGM2pWVFB1cGdrTENON1p3NzFX?=
 =?utf-8?B?Y0VvVGVIZ1EwVUIrcEF3U1hqZzVSejNmYktRZHYreW14TUdTL0hmZlpuaDhi?=
 =?utf-8?B?NW5oMzBTaGUyNVB2aUhYUDNCd1NsYTM2V3pFQzRnc1NGeUY5Ykl1VVJwZmtN?=
 =?utf-8?B?WEN4L3BnVnVRdm5GQnJmNTJPd2UyQks2UWZyNjFrcGRtd0UwRFZyN3U0NnhG?=
 =?utf-8?B?WVNKZ3FTaWJZNjE1ZmJyQmh0WU9pMHVJWUNHeHBUVWxDTWtmSjlyOHZZU3ZN?=
 =?utf-8?B?aUlKbEFuY2QyK1NUdGlma2g5enVpRCtaWTRtbGxaK3UwTTRqdjQ2d2lwdmZn?=
 =?utf-8?B?eDU0aTRYdTREOHVndHRnbTJiVnJ5MjJHM1FlL002ZWF2blpDN0dUVWpsTC9D?=
 =?utf-8?B?TkU4aERMWlJ1Z1AyVm9Ea3ZNQzh2Mld6aFZCbTZRMmNqSjg2UEdnM3U4SlUv?=
 =?utf-8?B?N3hwQmNGdjZ3eEZhQWcveFFmcmIySkF4d2dtNkhwQUJ4aDBMK0hvUXpwSGRG?=
 =?utf-8?B?ZEl3OGh3SGpCeE03NDhyQXVnbUpTbXJJN1labjBvMzlHMHVQeStBYWVXOEpC?=
 =?utf-8?B?bTlvZlNGeUorZjZZZThEcXlwcDFDMDRtNTh5TWhxRmpIc3VXNWJKSVUyM3dn?=
 =?utf-8?B?RERRbGRJL2NZU3VmejdweXl6cHVORGhhRG43bGJ5MHNmZ1NtRjVaRnlCS1lt?=
 =?utf-8?B?ZVhuRE9QeFZTNzg0eW5rVXJqNXVKbWFBaDRtSFN4ZDZlbkg0cEREVTZpSXVL?=
 =?utf-8?B?RHhmM0tiSGlOYkZMakIwNzR3YmlTUmxzb2xLb1RPLzgwV2tuN0xaY1ZIem9o?=
 =?utf-8?B?WDBLQ2tIeHp5R241b2dxNkQvdjhaYmxxL0xZaFozNW8zL21CZ2srY0FMSXV1?=
 =?utf-8?B?alFTbzJvNTU1M2FMdnovRUR2ZTNtMVJHNFhrT29abWFpSEVVZ1lRd0o1UGs5?=
 =?utf-8?B?ZkRDWTZTV3BIVXFIcWtPNDhaL05BSHp2NTVReUdSdlZhOXRSa29saExGSnVX?=
 =?utf-8?B?WDQvakNsNjByTVBGSkllYzR3elk1L0ljVkI4a2dFdFAzODRWQ2laUThmblV4?=
 =?utf-8?B?a0hhQXpkYkVHc1JFa09ZbWlnTUhSOElLQ2dSVjF1ZWFMdUNzdEIrdmhLNmhw?=
 =?utf-8?B?a25QeDM4YlZEQk9vTWljRElCaWpsMVdpRmxQY1VzbURqdEpPWDdSK3FUV3BX?=
 =?utf-8?B?dWNEY1FhMXR1MzJxbDZEbGtmM0s0QWM5QU1zOEZFRnA4K0RkVHdXQnpQWGFF?=
 =?utf-8?B?bnptM3FyVUJYTHV3L0ZKUkJweG1HZmJ5RUJjbjZGTmpJenBqbnhPRGd3c1A1?=
 =?utf-8?B?d3hZZ256L3BUM1ZoZzVhdVhWdzhqQ2VLMXp6NlMycFpOSzJSNEpTZTN5eUFU?=
 =?utf-8?B?OUYrRkZ2WkVLd3h0RGVPc3l2U0xJSEZGWlovRUd0WWpBcmtyN3NBd2REYWtj?=
 =?utf-8?B?Q1laZnAwMnhpZnNWZnhLd21oR01kUzdpQmlmYlVtN0kzQ2x5clhkK1dDeHEr?=
 =?utf-8?B?V250TzJxRVNNSGg3VDZWbVR1Z3BQTzJvVWxwNG11TUt3b3lsOW9DdGMvbSsr?=
 =?utf-8?B?My9zMGV6VVRiTi9pUm9oRFBsVVdHQ3pjYmt0MTMya1Q3eEdic2tXeUl3a2Nk?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0959f965-0331-483b-273a-08dbc6951a46
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 17:53:10.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4c8VntecsDgrHw80LHCY6G/vxXoPjkLx8qRjaFBsvmK+H3+53IqrwZxj1lyzv1DMBM174pLyJIdmXfTKpGCfS7Gfj1LCFZu9MEIwa78/gc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8116
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/3/2023 4:54 PM, Babu Moger wrote:
> Files unique to monitoring groups have the RFTYPE_MON flag. When a new
> monitoring group is created the resctrl files with flags RFTYPE_BASE
> (files common to all resource groups) and RFTYPE_MON (files unique to
> monitoring groups) are created to support interacting with the new
> monitoring group.
> 
> A resource group can support both monitoring and control, also termed
> a CTRL_MON resource group. CTRL_MON groups should get both monitoring
> and control resctrl files but that is not the case. Only the
> RFTYPE_BASE and RFTYPE_CTRL files are created for CTRL_MON groups.
> This is not a problem because there are no monitoring specific files
> with the RFTYPE_MON flag associated with resource groups.
> 
> A later patch introduces the first monitoring specific (RFTYPE_MON)
> file for resource groups. Ensure that files with the RFTYPE_MON
> flag are created for CTRL_MON groups.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

I believe this series is ready for inclusion. There is a conflict between
this series and Maciej's non-contiguous work [1] that is also ready for
inclusion. We could wait for outcome of next level review to determine
who will need to rebase. It may help to provide a snippet of the conflict
resolution in anticipation of Maciej's series being merged first (I will
propose the same to Maciej for the scenario of this work merged first).

Reinette

[1] https://lore.kernel.org/lkml/cover.1696493034.git.maciej.wieczor-retman@intel.com/
