Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F037477C41B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjHNX6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjHNX6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:58:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8FA2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692057497; x=1723593497;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yMwaqXAjjhjYC6Jv7Re6t+7PhdHJWtPPMWWEnEND0d0=;
  b=ZArQEy1LxYzRm4YpxzzuMun8hrbIFG8nrjQbilc6XZuM26KpHBcLIf5L
   AvvQIfAXMkwpEeGzmdcvSxhoFCzsPWCDwTLAxHQJ367PKmtdaNvgm2GyA
   BqJ78p+0qGFBBe1UAeQ1CAZ9A2Fa3AxUDYLdE7mk6glahhEbaoOm+N45H
   ucbf84Dw7ps+xQFjSwQlS8Uz08EbR0drfTUPOqHPnrvOEaKUJS89C8NWe
   pTZmCKtvA3HbdwRbHCblinnWLnKb6gjoijeT22rVhz4M7w91Kps/8LGMM
   Gud6+doMUwlg6R4L+dzOVgW7WbCSd8SpvdsQFACCAluQpQu615Ot9HXC9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="403144648"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="403144648"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 16:58:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="980196314"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="980196314"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 14 Aug 2023 16:58:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 16:58:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 16:58:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 16:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmiPAx5RdT3ovhxDntjjiGMsT3Au65W3hgL/2tQydpA4yy+4KpuW9+AYLfkGmk7ItENkY90OqIVDPGCZEmMMo8TooC6JCDE+TCU0NU2mZ8TvWQ3fEeFkgUFBac9gpIH3nugvmA3YidcbI80LOtfI2oFRIwa21AXuceGunsq0MeSpRW2TnU8PC1liS5P8IXAtTdmI97T/cxmL6MRyG6BXlhVW5VAbnvJD6qbxOhLpTlMLIYuVdsWIQMxCfVsyDBHjcNDH0RI7hIwrA3HrlGqOe1Lv5Id7oVExHU4qBSoSAaUen41PlP72M06GWH9LuYL4dZ3JznmCyT5JBOWoy0D1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj0CSU2G5EyffN4RpBdxDCvHhwsE34MKB37KgbBzbIo=;
 b=Ey7vQzcgSWoG6WZ7nfmeCOjef6HkEhsIT+IJdbRIWF86qedLrgpmntjwioDeoLmb40hxmMTvtgaV0hgj65bRQ5kMCbh6dmFuN5rnsv0V4trZ1c7wYAhO5V1cA9qn8JfZzcyDeUiGR99jh4m4xCrivt7E/JzolQIBthArnVhYk229rAlpUp2e9nsDE7efEzxl3NUoKZ85JLKDaemrML20hgngniuv64aqtl8vT5RvsrwIXfirSjntEGt8UnvN+cCBfDEI0pEZgA7IHEbh7OdFdd3d2mxym11S/bJ0w8nPlV0D9ToYo4I8kWXR3kv0kysuTr9K7WrDH1+EV3CXcu+hSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 23:58:12 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 23:58:12 +0000
Message-ID: <1451bb44-661c-d18b-c4bd-b3c363bba06e@intel.com>
Date:   Mon, 14 Aug 2023 16:58:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 06/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-7-james.morse@arm.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230728164254.27562-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::34) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 25faaacf-45b2-4bc1-71e1-08db9d22516d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cky4g3J+1BemUcSaWCI/ItEq4jphVZLEq6iVWQl+8npQMAgrKtPkTFG1FrCOYtyYWAkwZreP9UifR/nCKVCMWJv4YBlS3a2nqrjIGdd/ALzuut4Xs2Wx9u0GD9TPvE2PZhgTc4a0N1mahm8bRRgEqfiVRN63qJ2ZXF0utN1q3yHapSWukQNl6FhSTLv6AP71mvpIY7/siabZj76qNO4flwUPhBj3N1Wt/FXQawtaIVwjXSEfTOTFZHWu1dgvFsRx43tCEZyklmIHRezWUp561V1Fh9lSxhN6QvQ2U8bT3jDl1h4Tv7IGTJq0uEDKNOpX90GctJc5fVKYAZ+s77oT3mjpoOpqKm1BFqEPgNaLO2xQ6CiZlF8EmKbvKuqvT5+cLrHGocTAjtCH7neNLgXKpA3xXqyC2ZF5DsAevDvdxUq923tV+8ZgBpfdZf+cmbhPuUF6dQlM63swZH5iNnP/pGZQBWFgQNjVBHRfMk0g5REkok4rFtBJaM2IVvvXnGeD4kfjHtZcaNvyZOa8No0VYC9TzQmJR7Tc6SvedscMLohA0Ym88PRiKzOo/4ZjTG5kZoU786fIC6+qcByZauR3CjcO+ALragf3C0i+p/7tns1pnz3dKQ6iRkOI6FE52BSpXGFJelPiRgwkzRxj2jRiEtecnS00Z3qOE3ejlD/X6yo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(366004)(39860400002)(1800799006)(186006)(451199021)(53546011)(26005)(6506007)(8936002)(41300700001)(66556008)(66946007)(66476007)(316002)(8676002)(6512007)(2616005)(83380400001)(31686004)(6666004)(38100700002)(6486002)(478600001)(54906003)(44832011)(31696002)(36756003)(86362001)(4326008)(82960400001)(5660300002)(2906002)(7416002)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJVenVZSXN4R205ekdCV1JtMG84bElJRWlJeUNoeEJQL1pLUjNLTFkwdWdu?=
 =?utf-8?B?S2t6OEc1VnNpNWdMdTQvUGtJZDN6OU9LTVJTSm1TaVBYQ2E3a1JvQkt2RUN2?=
 =?utf-8?B?a2NFMXhoeXpVWWxEQ2RaQU54NDZVRU9ueTZaSmhCaXZuYjRZaUM2MXRZZ2lJ?=
 =?utf-8?B?RDFhSDQ4WjkvRDNzajcyTnRNN1VwZVN0VGxqR0hkRDY0WGdQOWZhUXJuSEdJ?=
 =?utf-8?B?endNbGxvb2xENE5Ra3RXOW9ZREFtdXdEY1ExY1c4RE9Vc3M5ZkdsK005V1k2?=
 =?utf-8?B?ekdJTzJyZE1KY2NzaStQMDNrQUpGYldiditVSG1CSE5XdnNyQk9iRUZOOFBq?=
 =?utf-8?B?UVNNSWFzTWQ5QlRXeXBydm5OYXpnODZaK1h5R2paMG5qeGE2ejlZbFUrOE9w?=
 =?utf-8?B?Qkl1dlhnTXduWnVFWWxjRUY3OWlKRHdUMzMwdlpDQkZLcHRvYXZuVGxWK2gx?=
 =?utf-8?B?QWNycXN1YzhFWGFyQTJNQW9NTzRRM0ZHTmQybXlrczloSndWa0c1MVVQbHpt?=
 =?utf-8?B?ZGFLS1pEK1grcWQxM08ycHRabVNFa3Y1bFZDN012dXJkK1RPOXU2bUxpNDhQ?=
 =?utf-8?B?NTZ0dE91UHpxaWRMSXVXZS9hc2lMeDIzT2tBazRqS1M5eUZ5NUsyRjhEU1Uy?=
 =?utf-8?B?eEhRbkw2N0h0TjRzRkpsMXR5OXhjSUZjUnVlQnJ6R2F4ck1aNWVQVWdOTktk?=
 =?utf-8?B?NmMrT3NUOXZlNlNMUTVkSHZ6bW5BQkYrZzFIL20wbVAxOFFOWmwvYW9xOGl4?=
 =?utf-8?B?SFpXaXZjVXVCOFZmUjdtNFFkbzVNRXlVMEphQjJZcE5Da2dBemhiTVJQTlVK?=
 =?utf-8?B?ZW1JQ2ExTllqVTNGbngvTFBiR1ZCZVk5Z0lPeDVsZGIrcUNxRjRwSTFWUWxp?=
 =?utf-8?B?U0JaZUVpVlpFbkNGUG4ydTlZTmJyNml3MW9GMTRIL0hreVAvNnlSdk1GaE1r?=
 =?utf-8?B?bUZWQnhhUnNZNE05VnhWZ1dLdVlLb1BwQ1ljL21QVzFlQWNBV1IwS3l2SlZv?=
 =?utf-8?B?UEpldzV6Zkxsek1rNFJRRXdNT2FBWDVZTE1aT0xmSS9LRWh3Mzd1Q1o0ZHhv?=
 =?utf-8?B?cGxrdittR3BZSnV4b2cwQlNJZC9lajhMTitrbUxwU3lSTEtDaVBFUFRldk5a?=
 =?utf-8?B?YkpjV1h5L052a2dSdVQrY1lhaTVkWFFON2JLdk9NSVRjUXBQUUw2aVJKK3ZF?=
 =?utf-8?B?R0d5K0o3RHN2THVDVk1ib3d0UVpySnNrRWtWVGJzS0JWK3hsdnJ2Tm1lVHBX?=
 =?utf-8?B?dmRwRkF0UFBPRTlVRE40b3FmNHZPbjNhQnRNREpDY2ZSS0l2RmZxNndPN0lk?=
 =?utf-8?B?eHQ0aUxIclhTRjJWd0g3QmpwcGZZV3hvYVQvakJFeU1FdUZPaTFUaTY0S0o0?=
 =?utf-8?B?L1NIN1ZscmN4Ri9zek5CUUpvWm5uVmNVQlNFTE9SQ3NQUE1yM3VLMFE4b3NB?=
 =?utf-8?B?K3BhMWZ1NzZ6aFY2VHlsRkYrNmVDTHEvZjlOUjMvTDNMSnVZRVlvZWtRVlJQ?=
 =?utf-8?B?bnpkNWgwbzZadXBPeWY0dHJNN0x6bmJzQ2gydFR0QllBcXM1b2t0SjdzaDkz?=
 =?utf-8?B?a3ppNXo4S0Q5dzd3b3lyTmhRZkNCcmJmcG4vZGgzcXZpZzlKTGx6dlBkS0lG?=
 =?utf-8?B?dHExSFZmNTdHaXE5d3Erb3hrVGZTa2dwbXRNaTNSMm1EQkNBVUd1QmY5RHhQ?=
 =?utf-8?B?RDFwMjFEUGpBMHBXS05udFB5YmVMTHB2ZzhuQmxlTWRYUTdjM1lFVEdXTDRo?=
 =?utf-8?B?WnU2YXNobEdUeVlCcVpiOEdHQWlRdE9Salpqc0dHZXBmeW9TSVdTWS93a3Fz?=
 =?utf-8?B?amt4YTdsUmJRWW5JVHUyWDJXMmxtd1NSc2NIdTJuendOYlNuTWQzRjg0a3ZD?=
 =?utf-8?B?eFl0VHFxdXQ2QUF3YTA3Y1J1dGtjWUd3b2pQYmxLV0V4MjN2OGRVd0pkWnVD?=
 =?utf-8?B?NkxwQmZ6cGczc0RxQUdUdnlhOGFNTVpoUGJ4SnBYb0VpNkl1SnRSTWlYRlFh?=
 =?utf-8?B?VUxYR3lMRXdVc0NXb2dEVTRJZm1vNUFNd0cxM2RuR1k5Z2xUcStsTGd2blZP?=
 =?utf-8?B?SFYyVGFvL2xLZ2RUeHBsM2Vlc1JxSSt5Qm5GaGZZRGtLUGxpc2cyMDhDRlRT?=
 =?utf-8?Q?Mn2wPNxw3SxMb0VoY3ujP6UBx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25faaacf-45b2-4bc1-71e1-08db9d22516d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 23:58:12.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tb8zlY7y2GZfh3Zi8KkDKXcx+PM+RGBPQXGVcdWdEgUFBy2tA/XBoshzwil4vJkqwk3XjPjnACzEHMQjGii7og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

On 7/28/23 09:42, James Morse wrote:
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
> 
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
> 
> Keep track of the number of RMID held in limbo each CLOSID has. This will
> allow a future helper to find the 'cleanest' CLOSID when allocating.
> 
> The array is only needed when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is
> defined. This will never be the case on x86.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v4:
>   * Moved closid_num_dirty_rmid[] update under entry->busy check
>   * Take the mutex in dom_data_init() as the caller doesn't.
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c | 49 +++++++++++++++++++++++----
>   1 file changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index de91ca781d9f..44addc0126fc 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -43,6 +43,13 @@ struct rmid_entry {
>    */
>   static LIST_HEAD(rmid_free_lru);
>   
> +/**
> + * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
> + * Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
> + * Indexed by CLOSID. Protected by rdtgroup_mutex.
> + */
> +static int *closid_num_dirty_rmid;
> +
>   /**
>    * @rmid_limbo_count     count of currently unused but (potentially)
>    *     dirty RMIDs.
> @@ -285,6 +292,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>   	return 0;
>   }
>   
> +static void limbo_release_entry(struct rmid_entry *entry)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	rmid_limbo_count--;
> +	list_add_tail(&entry->list, &rmid_free_lru);
> +
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		closid_num_dirty_rmid[entry->closid]--;
> +}
> +
>   /*
>    * Check the RMIDs that are marked as busy for this domain. If the
>    * reported LLC occupancy is below the threshold clear the busy bit and
> @@ -321,10 +339,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>   
>   		if (force_free || !rmid_dirty) {
>   			clear_bit(idx, d->rmid_busy_llc);
> -			if (!--entry->busy) {
> -				rmid_limbo_count--;
> -				list_add_tail(&entry->list, &rmid_free_lru);
> -			}
> +			if (!--entry->busy)
> +				limbo_release_entry(entry);
>   		}
>   		cur_idx = idx + 1;
>   	}
> @@ -391,6 +407,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   	u64 val = 0;
>   	u32 idx;
>   
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>   	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>   
>   	entry->busy = 0;
> @@ -416,9 +434,11 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   	}
>   	put_cpu();
>   
> -	if (entry->busy)
> +	if (entry->busy) {
>   		rmid_limbo_count++;
> -	else
> +		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +			closid_num_dirty_rmid[entry->closid]++;
> +	} else
>   		list_add_tail(&entry->list, &rmid_free_lru);

Unbalanced braces in if-else. Need to add braces in "else".

>   }
>   
> @@ -782,13 +802,28 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>   static int dom_data_init(struct rdt_resource *r)
>   {
>   	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
>   	struct rmid_entry *entry = NULL;
>   	u32 idx;
>   	int i;
>   
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		int *tmp;
> +
> +		tmp = kcalloc(num_closid, sizeof(int), GFP_KERNEL);
> +		if (!tmp)
> +			return -ENOMEM;
> +
> +		mutex_lock(&rdtgroup_mutex);
> +		closid_num_dirty_rmid = tmp;
> +		mutex_unlock(&rdtgroup_mutex);
> +	}
> +
>   	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
> -	if (!rmid_ptrs)
> +	if (!rmid_ptrs) {
> +		kfree(closid_num_dirty_rmid);
>   		return -ENOMEM;
> +	}
>   
>   	for (i = 0; i < idx_limit; i++) {
>   		entry = &rmid_ptrs[i];

Thanks.

-Fenghua
