Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E655779BE86
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbjIKVWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244319AbjIKUFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:05:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590B3185
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694462736; x=1725998736;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=grWHR54GnkJ2ckarcpvccGtBGKPMhnP12HuQT3G5RDA=;
  b=XaNhquKAQ6Ykr4q6hKVZ/f5Dw/FzI8s4Z/MEJcSzo8t7vSzo5s20auKp
   PxCXhvlMz0+oq4w9PqWyEFdJVs7NKLQ1qGJAcnPRuL1qhHZdYvy0VmUbY
   ukyDOrEtf8uxbUcPLfBmgRBNfjm08Mb6c0yvuI96m9JOxO/walykfaHbt
   Oc9TL3wI3mFZeRMWkWk731QJLlGTDr+wFwTs3W5jnk7GrQ/vvFxsNKCCL
   Co4VngiLdxKM18r+a2tQTwQiXlaMIDHFHM+BCNJy9qhUsJM+VnuYIgeYy
   SfnqeosYUUcH5JhhG4S0CvGJEU7fZkY4ZYOOIc1PYyOH69CVIOO4bbAQs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375530913"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="375530913"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:05:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="808941563"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="808941563"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 13:05:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 13:05:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 13:05:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 13:05:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 13:05:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpMjl1EuhWtjb49RSMZvqKvGE6F4W2wlJ8wNKWxgJqrhAdbVrYbIRpVglUhZiKh5a953PnmGWjz4qzzyHTfgYv+SxkKBvDE9L2/miTqpZupHzDhuZEzfv0x7VU8+MVET9Vxq5sMWDCyHCS2ieHceNQPozkCpd9fAlSHMqgPzBz7JB5x4s/GC6gvhsk45JAlkgsPCJtURuQlUm+vXC1CojvRLBjHH/JtiFDBcptoewGh5A5C71/p7s0oPPd5Untwnub2wTZF7YCml+eTy6sMlCJ5irRZe6HRxSfxiHmTTaQvyuKuEZaBj8Gq2QODeUccBf1+XzkgcCWbhhcWsZjznHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM/BtHrZeNnWsSkMaFAmW8/GYoPuOGUklpZcWbimLFg=;
 b=jFU1jPx6kpbbv21se74mUiH/W64c/lDtxTJ1nxXxbDFWk9aaTbOEznHgk2coYdUpAPhjNBNxWXP1kIE4n75SLGFCBqsqRa3ibo52JJKphIohejgK3tQrnKwEEKKY/B0traaQ0OTndtNh4aMDXE4xmFfZXT5tSp10sWVw0wmhMA7F2CM75AiS3tB/3vfZbtRPXV5dBlX3zPqwqRoMkpGSVTFLR/BQ3uEZaS/KJury2ne0JSQ48fMyaTlqC5FZMmUEIhCh0VGgEodTIKWCQ/+PeNBApZXO4FO8goHNKoIcULJuK2htCRhx4qno221nF8hC14yHkz5h3m2x/fm/v8Rx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5891.namprd11.prod.outlook.com (2603:10b6:303:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 20:05:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 20:05:33 +0000
Message-ID: <6b172280-7dbd-9d97-4e00-ce231f084904@intel.com>
Date:   Mon, 11 Sep 2023 13:05:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] x86/resctrl: Add sparse_bitmaps file in info
Content-Language: en-US
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>
References: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
 <27fc083358bc215676354818ad5a7abebd00e332.1693557919.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <27fc083358bc215676354818ad5a7abebd00e332.1693557919.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:303:8f::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e37ba32-2ada-45d0-cd62-08dbb3027480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xT4VcfVowIwhr/TI6WjY32M0po1aqKrKC7eD8K0XSHwHSP0h+9I2Up3u/A7KAMMUT7DFvKZg6L/rvDbIdeIZJLfW+jVylO1HhwKkUkbwZQdCDJzCpYKT3+7tt5xlDj18Jpl1Hc045NjIrLvvVVYDRTWj/dAdMujTtE8SZJAWR73IdQnMSvXo7o/r2HFUpkYCQ/tBC9XE7TGqWwrb3WI35jdRBmhlFEzDrAWaGVL+p4kpltaFD+N6XzynrT7g1ALoNuk4eE6gNHv3Odru0SzuA2W6OubUb3Z4Ou98HGzrBr6VbacSRl5c98l5VUopmAb8MPrRlI64P3cA5qXri6hEmhsS0GV6zQSAc1SeEx4q1bb0N8YS0ymfpv+zOqfwffYX3yVfVi2K3OSaCVCaQC4SNDiZ1otj4+x8a9S99Ef/+LsYRBCxKg1/77sDPMmmbcU7DcdVtwz3xJBLBDSULG0ZNLXbErbqJ9100lqCSfRcfYgIgRBY4cI9uHs/RAdeuIOG4NQy+Bh/wUzGMH0ywAdOYveBNEBq7okgrreB1/ZCzjK3MwI2Lbt9mA2c7+Ojbd4JRdQ46hpxLUk2Im88WsIPWpILWcgVGHWSiQx+xGJOJKEkP7fxNrvJzxpgbNRI2bSNFTWCmDsaRRz3rInqaoe5Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(186009)(451199024)(1800799009)(36756003)(8676002)(4326008)(8936002)(31686004)(6506007)(6486002)(53546011)(82960400001)(31696002)(5660300002)(86362001)(38100700002)(2906002)(26005)(66476007)(2616005)(110136005)(41300700001)(44832011)(6512007)(66556008)(478600001)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVptQS9xY09nUDdLR3ZEbzRyS2h2OE41U204UkFTcmJPSlRPTVNXNGNqdysx?=
 =?utf-8?B?U2ppQXN6aVBwcTRYSzJ3OUFvNHU0ZDIxN0xNYVl6NkF6VllIbnpacUZsUXZL?=
 =?utf-8?B?ckFQQ1JzaHVrWTUwL0dGTDJrZ3J1SllTd3RmVkZrdWVtckFTTUttMTRxeStk?=
 =?utf-8?B?bjhXVks0MjlQa3lPQVMvTCtqaDg3b2NyRkdYVVl3Nlo0akV6Z2FtZGp2UVEw?=
 =?utf-8?B?eVpmQys2NDFmdTV5U2NFTGRYN2pHYkVMai9kRGFzWlNITU92UVJFK0RWTDhD?=
 =?utf-8?B?cjZSRlVpcFZEWEIxczJJT21RdUZXVUo2eVZxNVBZOGMrTFlkUGJJcTd0Vll3?=
 =?utf-8?B?RWpHY2llMHM4ODk4L3hWd3B3cklWQ0trTGhkY1o3M05iL1k0ZE8zR1BQazdR?=
 =?utf-8?B?YWFkRGJlTUdoVkdBWFZoMzdHQnRpQXBnemJSRnl4YmVaaHFZaVFqK2lPakhU?=
 =?utf-8?B?NlVrV3pvQXVWMEl0SjJwYkpnKzJoL2JlSVRpd0Z5YmlXV0w1aEh1ZjhWeWJK?=
 =?utf-8?B?UFZZWHQrM1pLZTErWlhEOFUvclBLdmR0ZFQ5Y2M4VGd4S2FPUklsN201QkR5?=
 =?utf-8?B?NG42SzhiNUdCZnhXMjR1ZURjdkU0d2ZVM2V1TERaN3NZdjYvQ0N3djlNdVAy?=
 =?utf-8?B?RnZwRlFwQWVnZzNtSWttOFBQQXFPSVYxNHNnb3FZQU1oN2F6Ui9TYngxWkR2?=
 =?utf-8?B?a05DTFVEcUxwLy9pdXQ2OW1sY0FVS3U4eEZ0cERiaGtsejJtWUR3OUFkYjlZ?=
 =?utf-8?B?Qnl6Wm1xd2M0MktHNmhlRzRidkcyeXY2WFhLM0RFZ3JsMkJZR25DdFZ6ZjEy?=
 =?utf-8?B?a3VKcFc1RXZkZW9BaVVQYTNFYlI2Rm5qZ25OVlpHZjFzVVdXSVIyMittNjVS?=
 =?utf-8?B?RHBXSnoxSWtia0Y3SW82VGFPSnRzMnQ1a0RGYnhmbWJ5bVdndFpyK1p2Sk1u?=
 =?utf-8?B?bkhzS0ttOWk2elFiSFYwNy9hbExISEFOKzBSUUcyRXFQZFJEZEswaE5xTkl1?=
 =?utf-8?B?UUt2b3NYdHFuMis3UGdvYy9WaE96VnNGeXNGZngvRUQvUU5BTXBrY292MnVK?=
 =?utf-8?B?NEh4b0Ura3hIL3Z2S21GV011bXFiN1g3OGhvakhNUTFKRFNlc0c4QmtnK1VX?=
 =?utf-8?B?YmRDdkc4ZDh1UGxlU0krR1h2dlF5akRQbUZrWE40M3h6QUlGUkJXZ3hTVCtJ?=
 =?utf-8?B?Y2d0b282Yy83Y0RuaEJmaWJFc3o5ZDdBL2g1QzNSRkRNRHlpajA4ZWJLQ2NJ?=
 =?utf-8?B?TDJEb091QU1QVDEzMmRwU2JjY0k2NmZRV1NXLzJvMlRFZFJ3blV2cUhPYlBJ?=
 =?utf-8?B?MFVnai8zaC9IYVhFYVRXU1BXd2RhR2NCak9OaHdJdWYzQTRVY2tIQ1U1RHlS?=
 =?utf-8?B?WVZwQmd1anE1d1MrSVBXL0NPRy9mTWdhTTM1RTdyeEYrMGFzZ3RRazV5UTV4?=
 =?utf-8?B?NXdPcE1NQ080Nm1rbFZ3alowK2FFR0RyL25oMTArajRnWVduRG5jRk1pZ0NN?=
 =?utf-8?B?ZGtFNFovUlpvbTZiWnE2bFpEZHZoYmRBKy9LM2J5YUhXZVp0UWZ0dEFJK3dL?=
 =?utf-8?B?TlhIQm9SZFEyUG0yV0lua2szMEhvYzlzNTJ1K1A2ZVUxanluVEt0cjZzNmJt?=
 =?utf-8?B?OEs4NzBkRVFlSVIrN0NsalZTdDU1amljcTgwTGk0Syt0S0huYmE3UjFGZ1pK?=
 =?utf-8?B?NHh5bXQ3bVB5SzVTdG4xK3ZTMHZ2RXIyTjZYSlRRelFQS3EweDd5eUxSLzlj?=
 =?utf-8?B?YUZJdVJuQUZidTJFUnFaZFNkQnEwM1ZmSkpNUURsbGF4R2JKMlRDZjJueUQw?=
 =?utf-8?B?ckRBOGx2RDlXdlFaVDVhb3h3ZHFTMzBlZnRSVEJYbGhwY2hucStWcHRKNXBJ?=
 =?utf-8?B?WGlkL1poWllJMXNrMy9URjBxRWxlVzJZcExjbXdJMzFpeTdQdnRTSlh5dVBI?=
 =?utf-8?B?MUIraDJBWUNFVkkvTXpSNDVHRlZtL3I4bEVSVFVDV3B4RnFENlYxdndrQlo1?=
 =?utf-8?B?bGIwUjlQdVR3UWt1aHVRL2ErTzNWR3YrdDFISEtaanNndFVXZi9VVXR3Z2VV?=
 =?utf-8?B?cjRqM2ZiSjZabmRVOW8xTnhXUTZTQzY4R3RqMUNPYit3UUkvNlJ0ZnBIZnNw?=
 =?utf-8?B?T3hSYWhCdEk1SHVCeUs5Nm1WV2d2N2d3aVBwY3hUYUZsRXhiVVZudUk4VG9I?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e37ba32-2ada-45d0-cd62-08dbb3027480
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:05:33.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFbPYkbg6EtUxOHEmBsdcugLr8UO9Y+GTDOXQlkCApzP/T05GbgtpLdKT1PTwUrGp62Wu0lTqTF9JVWBiGyyOSyKGw/DeHzF6NKfJhi8G0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5891
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

Hi Maciej,

On 9/1/2023 1:55 AM, Wieczor-Retman, Maciej wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Add the interface in resctrl FS to show if sparse CAT bitmaps are

resctrl is intended to be a generic interface so modifying it
with a vendor specific change is not ok. This is not what the
patch is doing though so the changelog can just be modified to
not create the impression. Perhaps just:
 "sparse CAT bitmaps" -> "sparse cache allocation bit masks"

> supported on the platform. Reading the file returns either a "1" if
> non-contiguous 1s are supported and "0" otherwise. The file path is
> /sys/fs/resctrl/info/{resource}/sparse_bitmaps, where {resource} can be
> either "L2" or "L3" depending on their support in the CAT feature.

No CAT here. L2 and L3 are the hardcoded cache allocation resources
so "depending on their support in the CAT feature" can just be removed.

> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 725344048f85..4d27354f3f30 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -895,6 +895,17 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static int rdt_has_sparse_bitmaps_show(struct kernfs_open_file *of,
> +				       struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmaps);
> +
> +	return 0;
> +}
> +
>  /**
>   * rdt_bit_usage_show - Display current usage of resources
>   *
> @@ -1839,6 +1850,13 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdtgroup_size_show,
>  		.fflags		= RF_CTRL_BASE,
>  	},
> +	{
> +		.name		= "sparse_bitmaps",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_has_sparse_bitmaps_show,
> +		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
> +	},
>  
>  };
>  

I think it is essential to use consistent terminology. To help with
this I reviewed the resctrl documentation and found no mention of
"bitmap" ... yet many instances of bit mask and even a clear official
term of "Cache Bit Masks (CBM)". The user interface is thus already
established and using the term "bit mask". Looking through the
AMD and Intel specs I also only see "bit mask". I think "bitmap"
sneaked in via an Arm contribution as motivated by their spec's
use of the term "cache portion bitmap". Since "bit mask" is already
in the user documentation and also in the interface via "cbm_mask"
I'd prefer that we stick with "bit mask" in user interface instead
of creating fragmentation with a new term.

Considering this I'd like to propose "sparse_masks" to match existing
"cbm_mask".

Please review this series to be consistent in this regard. Note that
patch 2 refers to "bitmaps" and then patch 3 switches to "bitmasks"
... patch 3 already uses the term "sparse bitmasks".

I think that it may also help to add a patch to this series that
renames arch_has_sparse_bitmaps to arch_has_sparse_bitmasks.

Reinette
