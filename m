Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3538F7B7325
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbjJCVOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbjJCVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:14:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB35DAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367670; x=1727903670;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=az5gj7/3SGSlcXhT6tHFmEVlXUZQFcyYFSoNcWYYLpU=;
  b=kDZl2PzzYcusBt+3xZtETkStMWHryMmoJboQFGuQ5WwLzPbBuwhugtkW
   FKBOSYXLr/AlLoI7Z3JhTWpRHtXSLHSPrMC95wFDEaPj/kWMaiabOz7X+
   1PWp77B4S6TxKAv7vWaGnWOv3u1OQIQBzSng73PZ4Hdt4G6BFbyEt+Egd
   vrWfnPA/HeV42BVjbflDIQzc+gvQXGXFCx9/1jdr/roeUgjaMzDPrU5DB
   r809Imcjb0FHKUqXepdPXPITdxAvS0L3U+EbkB43Yotp1RmdBvhjVS2C5
   3JBBDZcO53ECoGvnWvNruea3whrrpgJ4xZyDWGcKhcBK3SshM6NRXHLdm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449473345"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="449473345"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="821400224"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="821400224"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:14:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:14:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:14:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:14:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM7UmY5wNZi3gY3gnmjFXtBQAVhiSb1YGD+c/sbxSTbmcbWqrUL99ZuEv/exBdkPhCJFecfQjJz1NOqdCBeeGp21DyV2a2R1v6xTTXJkrSCyfZLuh2ccoHwNYZxJ00xVrHcZ8xpmtLJsqJy+7PvtkTPLrX4beDCsHMmKy+nFeBHLLaF4eajoFY44fOGJj2gNnNPTIca4Fn7EQO3vEUPNF/RtQVk5ZUD4AZZniXDM2bb6lZ4n+4N1q0RjWazlGuf3GGuuVPiC7/Yc6TOafCAj5fmJCg4OIQ8VqAmSN25u8LuSEyKSb+dFF2a/1Ygin7Tw+lPlXB9QHcePLkSClLCdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cFd/0tM7uDTJUwnZPBM23dO+wHxwhCrJbc5ARNAPaw=;
 b=aWjyQgo3hOh6jZjKY3Z75UxUkl4iDc5qm3gClfygq01S2ZsU6Dta98xgOftjeeTygCH9sd3i1xaXOAL4fUJAjR37O0ejQe9Tb2s8D0quH6c56+NzwtRoBwt/aSCccqtb4nXKXswTohfwh5r+z3ypIjW/RCe9JpNke++cLJy1TWQiE1QE6Sd177R9+i7dDWQpg3g77tjtpmkt2THE/emwcCb4sxHYh/XcOJkY9KQ++jqUT4lIQzEKBmlVEzileQUlIEJZSaLrTcHDP7VBHDWNZkfAeneY/IEC8yT9Hby/taKBju2AWXIQQetixvIS+UhJYrMvQgaUiZAzwhT4bBAX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7132.namprd11.prod.outlook.com (2603:10b6:806:29e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 21:14:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:14:26 +0000
Message-ID: <efcd11ac-f037-949c-6563-984684f9bc57@intel.com>
Date:   Tue, 3 Oct 2023 14:14:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 09/24] x86/resctrl: Use set_bit()/clear_bit() instead
 of open coding
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-10-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-10-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3f2d17-b1fb-4323-ab74-08dbc455b923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZG+WjS9Ltm0feboA7xMT4Ii6EuX922yAZF6I3S/SeupSysyA4oApOd5WQ1H92v6iJcJXC+0gyGviLUroH/3ovHXZ88wpFG+WGtH/YGLO0MWy2l3xuwsDln5rx7QzW6Ie4l/Y8jWTeAcYzBnEFgZzZJwPCc5lemt7Br92Ktptx8JTJv2bYkoT1XddQZa5vpJqKpnHKoulZIKR2jYRlr+LXOMZuXoD22YWkg8JKcU+VcbQEZEidG/XfIIRN4KI7pXveLBYiAA0IehsKn1EXuizYAzkkzDXAA5tGCcxU9p+rtxblc1xdxnlv2av9zKbJ/YAeYGpFzyDc8Y4IabLXMhtMQeRCG4yRbt0KmmzjTvxoMkGhSS5HeFfT8lzruv4RwLzySYuNI+Dcwenwrdl4MtnZ2VPxdrbh/FWp4k5IeKezytSffXQu+A2YgQs7rvA83r3SmRPOpSEYKKl2RwFDZUxocE3/YVEdmeDOfvQbqNE3YK/uY/CAaVtaysxvYRFO5wqSeWUjovtH1FP8u3WK9NH2ScL1myYJsTxWkuH3aAc6cNe8BQh6FVCvcnJwIMGm1n95d/7w1FFiXGsE2ELSfxwtCH6fLUJ7Ad1xAwkOMR20Eh5tuPqNi9Ns49mjFsqolvQ/NWTXQO6Y2dgzidLz2DwNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6486002)(53546011)(6512007)(6506007)(478600001)(2616005)(82960400001)(2906002)(7416002)(83380400001)(26005)(41300700001)(316002)(44832011)(66946007)(5660300002)(66556008)(66476007)(8936002)(54906003)(4326008)(8676002)(36756003)(86362001)(38100700002)(31696002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejRqclBlYjNmcTMzK0dCTENPSDdydWRjdnVQSlZxMU1VcVptdHZjVzhvRkRs?=
 =?utf-8?B?Sy9vbTROd0hYb0hTdTJoQ1NCcjJlcUQzT2tZUGMvdC91UHdMZ0trU01kdFB2?=
 =?utf-8?B?UE8zL3VWYzJIYmtNcXNsb0k5LzNudm9mTlA5azFuY21zbmZpZlpGc3RYcEVz?=
 =?utf-8?B?YVl2ZjJqNVZEbWFHMTZKUGRZRTBSNi8zVDY0Yk41RmhCK0x6dGZKZk5aMXFp?=
 =?utf-8?B?YkZGYzM5QmdMMWpTT1pUdU1mRk9qQXZQNnp2NVB5NXBTY0hZcTFMV3MxdytB?=
 =?utf-8?B?eHoxdHZlbllrT1JUcmJuYzl1akd2dzFPWXVBZUJsNDBRWGhJOGYvV1hlRVN5?=
 =?utf-8?B?dkpLSFRkb0REOE9sdEthYmxOQWJ3cTB6MlRRcVV4eG1mbFdzV3ZGSUVIUEU4?=
 =?utf-8?B?bGkxemgxa21zUmpwTW1nT3J0TXdlTDJQaENYb2FHMjV3bmd0QjB6VTBXKzhG?=
 =?utf-8?B?UXFrVWdPZ0dNWGlvNElMN01ncmxjOTd3SFh0ai9GcEZLekVwNjRMZlF0NkRv?=
 =?utf-8?B?UXBHN3FGNndPSFQxak5BNm1qQ1VtbXVraVZCMUhQWHZ2dnVwWWlLcXYvUTBr?=
 =?utf-8?B?REJ0bTNkTWFILzEweHNJTHNEc2FaNXJCRmV1RW1oc056UHhVUkdLNGM2OVU2?=
 =?utf-8?B?RWlyVzc3YitJeHNjYTVEcnhycXl3UGRDRHNYUVQ1Q0JROVZzVmFNVzJNZ1pQ?=
 =?utf-8?B?ZTMvSzlnRENrVUc5aHVBY3U5ODl6OHNRVERzTGpEck1Tb0JKOENEL3FLS3hB?=
 =?utf-8?B?UGNCVEF5bXI5N3JoekVRaVlEb3FBcUpLam9Ma2dtOEFXbk5yYldqTkV6TXF3?=
 =?utf-8?B?Ly9TRVFpdnVqNk9lbmVwVmVQR3MyVmFmQVIzTXZ4TTRFUmdRU0d5MXUyQVVJ?=
 =?utf-8?B?d1FWTWxPdlNzbEZFMTYvU1VlOHRBNlZrSEtDamF1MTlHVm84RDZyWCtiTjFa?=
 =?utf-8?B?a2J0MHFoOXVQNVVpb2txOVVJNEhrQldyVExVYTNST2YyN2ZPc3RWMlRrU3Rz?=
 =?utf-8?B?Y01MaDhKYjRXcHIyMkpJbXRuNk9EWUxWR3RYRno3MG4zYTJIMHlRMUR0Tm4y?=
 =?utf-8?B?T096bDJWMmo3TWp1VWlSSjhXbFB6ekhBbE9KQVFKZU41enFsR2daRWV1WGtX?=
 =?utf-8?B?d0VXbnY0by9oYkQzdkpYMEk1emFrdDc3ZDR5cSs2Nk5iVW5YMDd6alI4UVA5?=
 =?utf-8?B?NEN2Kzdrd1k0cjRGbGdHRCtnZ3BnYStMTS9PN2dMZmNGQ1RkMDdEOWlmS1BJ?=
 =?utf-8?B?Wnd2dHZpZUFveEJTeUNIZGlXcDFhVVBZNmJDV0FTd0EzZXl0WnVranQ3a0ZR?=
 =?utf-8?B?V1hsOWt3akpLYUp4aTNlNFdtV0dUNFV1Rk5udjlmTUZZZUJGN2kyZExISjh0?=
 =?utf-8?B?ZmdnRXJCdFV2TmcvalVVUmo1ay9VTGdnU2ZBbS9Cbmh1aEtMeXdZZ3hmR2xY?=
 =?utf-8?B?YWxaVW00c2pSRUttVUxjT3d5RnJ3U3ZYUWw4OUErbEd4cnE4dFlHeDJxVjlo?=
 =?utf-8?B?eldkT3JrRXljeVp5bEJkT2QwNllKYzVyYXIzSzkzUHdlVDB1Y0tCeE5xNUZa?=
 =?utf-8?B?bjQ4UG05NUNsTTE4TzBUaEdSRXFrMzduTjFOYStjQkh4cVduOFFscks1bmt0?=
 =?utf-8?B?KytnWEdVZnhYRFRSamUyVXMxQ1JMK2g5cUtCWlB4d2JmSHRhM2h6Tk9FVXdI?=
 =?utf-8?B?TytzWVlsNkF2UmxWOSsxakd1RFlhcWx0S29KWllyT1pSK3EvbjJYK085dWFt?=
 =?utf-8?B?cmhMTENBdm9RK1h3KzZsVk1FODZSR2RMcFpyTEYwejNFdnZjVUgwMHc1eDJR?=
 =?utf-8?B?SFVwMU82RGhoQi9SajlJdE1WMllVNVFBTlNiUzI1bGVuWUtYZ1gzS3Npa3p5?=
 =?utf-8?B?anBpTTE3WFBoTlNENXRlM0MrbEJ5UzRHajVjM1huYU1sY1FlM1lFZXB1b1dr?=
 =?utf-8?B?STZMTFd0WjRLbzVsQ1RxYVp0YzMvQXp6c0FCbzhVbEl2YldNTUQ3VXNZSUtp?=
 =?utf-8?B?K3pGdytFZzFSRWltQU01T3RXNUFsYlp2Sm9Ed2hpd1YzUHE4YzRHM3JzU2cy?=
 =?utf-8?B?bnhhWDNnK0J5SzNHOWRtbmY4aFpqRmFuZG56MWtDK21FSG9WVllibHRNbG0y?=
 =?utf-8?B?QWdOaDI2YU5saGdyRHlGMlM0cGtyUG5HY1dlZ1d4K1lJKytwdFlYSURWMVVx?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3f2d17-b1fb-4323-ab74-08dbc455b923
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:14:26.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACp9ZW0GPcLcOPaNGw4KZQ/8Wdk2ngb7zXZHe2JGcuy5hPQHuaihFexANUmQwLHd/jmr3EwgF5r6CX/f3EJktFKrq/pzrbb0AJ0+r6mODp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
> The resctrl CLOSID allocator uses a single 32bit word to track which
> CLOSID are free. The setting and clearing of bits is open coded.
> 
> A subsequent patch adds resctrl_closid_is_free(), which adds more open

resctrl_closid_is_free() is not added in this series.

> coded bitmaps operations. These will eventually need changing to use
> the bitops helpers so that a CLOSID bitmap of the correct size can be
> allocated dynamically.
> 
> Convert the existing open coded bit manipulations of closid_free_map
> to use set_bit() and friends.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index ac1a6437469f..fa449ee0d1a7 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -106,7 +106,7 @@ void rdt_staged_configs_clear(void)
>   * - Our choices on how to configure each resource become progressively more
>   *   limited as the number of resources grows.
>   */
> -static int closid_free_map;
> +static unsigned long closid_free_map;
>  static int closid_free_map_len;
>  
>  int closids_supported(void)
> @@ -126,7 +126,7 @@ static void closid_init(void)
>  	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
>  
>  	/* CLOSID 0 is always reserved for the default group */
> -	closid_free_map &= ~1;
> +	clear_bit(0, &closid_free_map);
>  	closid_free_map_len = rdt_min_closid;
>  }
>  
> @@ -137,14 +137,14 @@ static int closid_alloc(void)
>  	if (closid == 0)
>  		return -ENOSPC;
>  	closid--;
> -	closid_free_map &= ~(1 << closid);
> +	clear_bit(closid, &closid_free_map);
>  
>  	return closid;
>  }
>  
>  void closid_free(int closid)
>  {
> -	closid_free_map |= 1 << closid;
> +	set_bit(closid, &closid_free_map);
>  }
>  
>  /**
> @@ -156,7 +156,7 @@ void closid_free(int closid)
>   */
>  static bool closid_allocated(unsigned int closid)
>  {
> -	return (closid_free_map & (1 << closid)) == 0;
> +	return !test_bit(closid, &closid_free_map);
>  }
>  
>  /**

The patch looks good to me.

Reinette
