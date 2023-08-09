Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81AF776C46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjHIWhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjHIWhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:37:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81758DA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620669; x=1723156669;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jkkhfyw0rkDnW644AKI2tdNis6PE4JNYAg30RDGVr9U=;
  b=NY6H7MV1yT1Ci8s+JX1kqaRPz9KPcNSuo2iOa2sxhK7jz5URWk8WVmqo
   9hhb2UtDR7+aBPqLP/7KrdB9mHa486Rch3LYfOg96PXu3LndB0L8w6lw2
   Uldo7fWfkb26JTXVBaac5SQACz5187G/cWCMaLFNLSO6PEr9wq/9e6Sfu
   uGwDnTAF/GhLyyItuzjPBJ4YTFBxNGSH46aJ6gfpHyhgHOL5jjZkpr6SK
   DgeYub/PSePmhDrkg5xKdoILGIji5HqSMZXrWGr36q131cceBfc1ZJHIn
   8tn53zJzhogkHySAl1U5WJKxzCPyJhMXd0hsbMC0ABjZU2iefiPN2wxF3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="374961756"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="374961756"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875461712"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2023 15:37:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:37:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:37:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:37:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqHY+6gc6EvNxLs3sLuMa35f21BkzJ6z78EeGrqJTfzvJ4/2VjS1clxJAgTJQIIIWqn1zY05rtDZVIcm4lrJbQgc85+NHMmpp96ZWocpu/fI0mMM4VBNTMSEeJ4uwHteCbnNEUy83yd8gcjgRI9hEACRmnlXnw9pmwcpcRu6I2kN2LkCC1IJEH5jPn3yIDfexsj5hUCxALnhntO5l4INFxGRlTgFs05qDX8pOHyWfJPbl4VsPPYelXiamtjwvaNGJwQ4tgl3tsDoj68Ms3bJgZoZ8dsWe2iaJCkikuLt2V2xHT8HKJFxhWF5sqQTFc9ryWYVovX1poKxlWUXAkrTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bt9rEzlLIwArkJ7PTvY4E+WijKtq0ePh5m4GWH5sB/w=;
 b=X6lfv9Yv1gyPSpPdgvBuJc1Qz3SQhrEGCYUNMQ6GE4N3TwFn7mlqxG6RZVa7dBhMh7mSqD1reb7J0iekxnjJMF+Z/jxTSlTGuqivuXSdFmVay71/87g306RYcyJ3a/NdZxgjn02Os23NQeLpw+Wfhewx6G5BY8/bXMZriyEQYGXV39B6i8tjMSZqDw2hh+K0H+63QOYMCbPi1HoS65g36fIesyRqvuqmB7sBWd+y+g4iVXZGLpm9K1k05A7S9FcLzXR8fcsl9TQtFdMMRuiJ/XD0dhR1leDjQ/wHPglWHIorWnQP9pueMNmPg4s7Dn4eVS2BwCk5VB2E0TBRc51LZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 22:37:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:37:35 +0000
Message-ID: <d5dc4710-6036-88f3-1081-0759aa956624@intel.com>
Date:   Wed, 9 Aug 2023 15:37:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
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
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-16-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-16-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:303:83::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: b5aae8f0-5d38-4210-94f2-08db99293a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8/hYZvftTSML/Y+GbsLbcC24YwT2AIh5ip7uLMuV0K1ptQhYENjzUN68TJk1CvkYVJQeZvQcisR3IAJtwh/jkntJqKGzelYv8M+vpaEMIy9QiVJTPLwppA2GruqUSQhV1ITn8tsYykzw1MSYq9f6Q4YI5tZ4A3qxqlvmO8320/iPIt1o8zmqXoeDNEKfiWBw8VKEjn/4CEq1woSEtmokXgaMe0Ya0Jvx/O/A9JC+akzfXqUuAPLBzmuWxoJIl00Qybs7YSD0MGkl8qwSAGvJfPRpO3SJGeVOD/nj/YXrfXt8KOWIDop3YkehYn4cNNmalI1KexmRSWPZ/yGSR3R1D18H5hoKM6oM05TMlavtBa0ZO8EvUSH4WRMwDA2TJ00oPgKJbMxMYlil56p47H/AnEBSgpNKqo7PDzija01TXIH4ds8GD1krPkUbFVRjFnqzc+YQtN2+q/Qe0RrjzyPmZbVAsKWNsCUvF7JjTVIqsv03YnnlcUtK1MhMUAweUW7ome2ZQJUhDGmGFhiHCj2dDQxr2IJdxjhlkcjOSI/SiiIqe3BYL2RY6nC41q1edbH7PgkB4gvcislF0TLpr8vPTEbTznogSgapzGGJmh6vazCbfLDcchNjc4h7FM65rQV2KEkN+DSLYNQYvnvTbpXQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(26005)(8936002)(41300700001)(2906002)(44832011)(5660300002)(31686004)(7416002)(83380400001)(8676002)(2616005)(38100700002)(316002)(53546011)(478600001)(31696002)(86362001)(66556008)(6506007)(6486002)(54906003)(82960400001)(66946007)(6666004)(66476007)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlA4dzdCaEpQZkFCV3Y2TXl0TGZDWFFLZlVicHVBcW1iR2dPemlMcjhzVkRj?=
 =?utf-8?B?SENWa290ayszUFNaeXE4Vk1jOXFBdEdnL2pmQUlmSUc2WXB4bWFPYkhydWw1?=
 =?utf-8?B?V09sZFVEdzBKc3pyckFGVmh0dkxlTHg4VWlQMnFZd0NxdjBZWVVWZGhWV21i?=
 =?utf-8?B?Y0k1TzlETFJ3SjlxczUzNWxvYUs2MmkxZ09BVTdWUVZTUldrWmdoWGdBQUFH?=
 =?utf-8?B?SndzYVF1b3JWZlVoaVEzNHNXSHVtSjM0bEsrVmlLQWhacGlTc2ZOK0UvTWR2?=
 =?utf-8?B?MmZBSnB5Q3VMejU3OGduMjVsd1JjSXpUeUtRS09yWGkzYTFUYTZrVW1nUWJB?=
 =?utf-8?B?dWd3bTJrcUlFRTN2bG5YMW9DdTNFZWxDZHc3a3lNckY0OFNNbFh5ZWRDQXpF?=
 =?utf-8?B?Z0ZNZlNneEI4UVBoODUyM1VTYnNKVjF3N01kcVBTOExJRnQ5RGdqd1hqcm9k?=
 =?utf-8?B?dTdTTC8rVkNncHNpUStZN2F3dms5WU5Tbm1RUnZiZkpKU0pnN3VaQUF2QVZx?=
 =?utf-8?B?eEtwelF0dGxUaHFWKzhCRGZuY1pFVEhjcHRCRjlBU2hsb1VJYllyRTNzRldu?=
 =?utf-8?B?Q3JOQ2lRQzMxNXd4cFZLSDBLbmVpVTY0c0k0TjRXYksrYTMxcGV3QnluQ3NB?=
 =?utf-8?B?NExTcTA4eWhEeUkzL29TV05EWVJGdkx6MjlTMFFiRTd3YjY5dG42MzFPRHBi?=
 =?utf-8?B?UVRyZlZ5LzdpVlVkbnBmRTJFN05xTUtuU3B4RjZRSDJac3A2NlVDU0h2dGtC?=
 =?utf-8?B?d3JrR1NsclhTZ2RtNG9LRThHdzRha04relNzQmxiakloa3lBNTZ2aEU0U0dx?=
 =?utf-8?B?N1RQSnFrSDZtcVpDKzNnVnVQM1VTZDB2WFRZek9HNVcvVG0xc3hwN01hT0cr?=
 =?utf-8?B?V2grdC93ejNraXRsZzFXY1ZFd25UYUdmcS90Nk5FcEZPV0RsdDltS2dsdlFF?=
 =?utf-8?B?T0hDRG02emxCTkVWNkNCUGdORW5yNSsxa3VKRVN6VjZnTXhXVFhTOFJHSG01?=
 =?utf-8?B?TzdGZTJ1SWlHWTJEMHhPZFpQMDFJRlpTckJIRjVNa0h0VnoxTDlKQlNWekY0?=
 =?utf-8?B?aXVuZnVoS2pSWDhGQlV1UUd1VGtpNGpTSUZLUW1ob2krSTd3MHRDN09zWGFp?=
 =?utf-8?B?VG52ejJ3WmxLcXg4U0tKUGFaSHVVd09xUnZZbVplbFkwbUpQM2lQL05DbjZv?=
 =?utf-8?B?a1NnUEFTREI1a1hCWXpSMksreElySk1IUWYvckN2bVBNWjlldDROMWFCQUtw?=
 =?utf-8?B?NWxvU3luRVo2VVNvN2V0MWU5VXBIRXJCbURoa3RXbFVNVDVCcnRpZXdURHUv?=
 =?utf-8?B?d1lBaCtHSjhXWk1uZ2kvOHJFUityT1ROdDN6ODNNb1hSV1JvVEVkSHNvcm1m?=
 =?utf-8?B?ZDNidlBFdWZtTDVQRzQ3SXNkWjVHd2tsei92TnQrVzQ4SU1uRkw0aElQM29J?=
 =?utf-8?B?MDZWZFhnN1hDbmFML2ZmY29rdE92RXllQ2NlVENLQytQVEdqQUliTGorUmxz?=
 =?utf-8?B?OFZVb0EwSm45NUFwQmp3M3hreUtnSDFXOVE4Wk41ZHJFTVVUaWNXSGEvbWVk?=
 =?utf-8?B?NWNzRjByaTl5eGlzRi9VclJVdkpvQ1J1dldveU5KR2t2b3A4VGdRS1dWbm4w?=
 =?utf-8?B?RjJLUDNxZU1SblM2cUxTTCtOWTd2b0VybVpYb0tiQjdVZU9QZHFhZ25CUytl?=
 =?utf-8?B?cnlBeU9yUGIyU0IxTVF6ZXBzbjlKOHExdlRlV1pBL1E5ODZpYVFHUjhVd1VT?=
 =?utf-8?B?S1dkSVVNSXBIUXdzcGlGclQzY1Y4R2VkM3RyUEsvdUhNVlVoRkZsVURXR3pJ?=
 =?utf-8?B?a091OE1rS3BlQmY5c3ByZUhNOG1oYU1YdGlPQVJiZ2Y0RklGQUpyU2I1ZEZ2?=
 =?utf-8?B?VWNFRXQ4bFhMM0R1L01XS09JRXhGWmtFS0JuaUx3WnF6SFJ5YnVpUkgweTlR?=
 =?utf-8?B?eGdyYlR4Nzl4T2c3NmluVjlxc0U3S1lMTkJYTDdFTVBOcElYR0ROMVpndHda?=
 =?utf-8?B?ZEVHVlk0d1Uxdzh1Q081UXlIMVFUZ0t2OEhCZFd0RS9QR2VXYlJMWGdWN25F?=
 =?utf-8?B?VkY0Nk1oamlPT1YrUFFFTFBIOWlWRitxUHE3MmppcnZQN0hQZmt5YkY4VDAx?=
 =?utf-8?B?RS9rVmNKL1pxUjZGM3ZCOGMwVHpweXRkcTY2QUxGNGJPUHRNcmVwQjhMc2d2?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5aae8f0-5d38-4210-94f2-08db99293a80
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:37:35.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z+nZi4Y7XiRwa1sO7rmQtNhfJaNI3BUoz+XMxi8laHEXzuv02q9HEq8xPL1bRub7dIl/kOtWjLym7/Tw5T+s2SkoGqHFTyaqPTJyvyLpU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:
> Depending on the number of monitors available, Arm's MPAM may need to
> allocate a monitor prior to reading the counter value. Allocating a
> contended resource may involve sleeping.
> 
> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains,
> the allocation should be valid for all domains.
> 
> __check_limbo() and mon_event_count() each make multiple calls to
> resctrl_arch_rmid_read(), to avoid extra work on contended systems,
> the allocation should be valid for multiple invocations of
> resctrl_arch_rmid_read().
> 
> Add arch hooks for this allocation, which need calling before
> resctrl_arch_rmid_read(). The allocated monitor is passed to
> resctrl_arch_rmid_read(), then freed again afterwards. The helper
> can be called on any CPU, and can sleep.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v3:
>  * Expanded comment.
>  * Removed stray header include.
>  * Reworded commit message.
>  * Made ctx a void * instead of an int.
> 
> Changes since v4:
>  * Used IS_ERR() in more places.
> ---
>  arch/x86/include/asm/resctrl.h            | 11 ++++++++++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  5 +++++
>  arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 25 ++++++++++++++++++++---
>  include/linux/resctrl.h                   |  5 ++++-
>  5 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 66d9e18cdc61..0986b5208d76 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -136,6 +136,17 @@ static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
>  	return rmid;
>  }
>  
> +/* x86 can always read an rmid, nothing needs allocating */
> +struct rdt_resource;
> +static inline void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, int evtid)
> +{
> +	might_sleep();
> +	return NULL;
> +};
> +
> +static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
> +					     void *ctx) { };
> +
>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>  
>  #else
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index bd263b9a0abd..55bad57a7bd5 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -546,6 +546,9 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  	rr->d = d;
>  	rr->val = 0;
>  	rr->first = first;
> +	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
> +	if (IS_ERR(rr->arch_mon_ctx))
> +		return;
>  
>  	cpu = cpumask_any_housekeeping(&d->cpu_mask);
>  
> @@ -559,6 +562,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
>  	else
>  		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
> +
> +	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
>  }
>  
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 7012f42a82ee..45db51280ff4 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -136,6 +136,7 @@ struct rmid_read {
>  	bool			first;
>  	int			err;
>  	u64			val;
> +	void			*arch_mon_ctx;
>  };
>  
>  extern bool rdt_alloc_capable;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 08e3307863c3..5eed8d0cbf36 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -275,7 +275,7 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>  
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> -			   u64 *val)
> +			   u64 *val, void *ignored)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> @@ -342,9 +342,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
>  	u32 idx, cur_idx = 1;
> +	void *arch_mon_ctx;
>  	bool rmid_dirty;
>  	u64 val = 0;
>  
> +	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
> +	if (IS_ERR(arch_mon_ctx))
> +		return;
> +
>  	/*
>  	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
>  	 * are marked as busy for occupancy < threshold. If the occupancy
> @@ -358,7 +363,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  
>  		entry = __rmid_entry(idx);
>  		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
> -					   QOS_L3_OCCUP_EVENT_ID, &val)) {
> +					   QOS_L3_OCCUP_EVENT_ID, &val,
> +					   arch_mon_ctx)) {
>  			rmid_dirty = true;
>  		} else {
>  			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
> @@ -371,6 +377,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  		}
>  		cur_idx = idx + 1;
>  	}
> +
> +	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
>  }
>  
>  bool has_busy_rmid(struct rdt_domain *d)
> @@ -544,7 +552,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
>  	}
>  
>  	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
> -					 &tval);
> +					 &tval, rr->arch_mon_ctx);
>  	if (rr->err)
>  		return rr->err;
>  
> @@ -754,11 +762,21 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
>  	if (is_mbm_total_enabled()) {
>  		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
>  		rr.val = 0;
> +		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> +		if (IS_ERR(rr.arch_mon_ctx))
> +			return;
> +
>  		__mon_event_count(closid, rmid, &rr);
> +
> +		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
>  	}
>  	if (is_mbm_local_enabled()) {
>  		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>  		rr.val = 0;
> +		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> +		if (IS_ERR(rr.arch_mon_ctx))
> +			return;
> +
>  		__mon_event_count(closid, rmid, &rr);
>  
>  		/*
> @@ -768,6 +786,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
>  		 */
>  		if (is_mba_sc(NULL))
>  			mbm_bw_count(closid, rmid, &rr);
> +		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
>  	}
>  }
>  
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index f7311102e94c..5e4b4df9610b 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -235,6 +235,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>   * @rmid:		rmid of the counter to read.
>   * @eventid:		eventid to read, e.g. L3 occupancy.
>   * @val:		result of the counter read in bytes.
> + * @arch_mon_ctx:	An architecture specific value from
> + *			resctrl_arch_mon_ctx_alloc(), for MPAM this identifies
> + *			the hardware monitor allocated for this read request.
>   *
>   * Some architectures need to sleep when first programming some of the counters.
>   * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
> @@ -248,7 +251,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>   */
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> -			   u64 *val);
> +			   u64 *val, void *arch_mon_ctx);
>  
>  /**
>   * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts

Looking at the error paths all the errors are silent failures. On the 
failure in mon_event_read() this could potentially be handled by setting
the "err" field in struct rmid_read ... at least then the caller can print
an error instead of displaying a zero count to the user. The other failures
are harder to handle though. Considering that these contexts are allocated and
freed so often, why not allocate them once (perhaps in struct rdt_hw_domain?)
on driver load with clear error handling?

Reinette


