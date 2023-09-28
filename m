Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62E07B26E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjI1UyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjI1UyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:54:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E621B0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695934456; x=1727470456;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AoEEnflBcjrR1SRd8AaKZv6bfW6bXmsQLKcveXzc2Ew=;
  b=g2Kb+xmxczxR2q0aIfLSSUNEAhqQko1mk5IEihjXB6KkdvofdBAiL5+R
   mt/7LDoiPII36BrZZPrmosudFzXXhsoWyH+z6L9iOGnrh2O2Kvgn+z6bF
   yegtDuglfYCuK+gIZuYmU+IAiFSyD2XicYKXXUVZ50P8Gy2H+WxNuMdmT
   KHwGSO6sLCVDexwU66cv8WvhgilpDjv2NP36uTaWq6HWg1IeIAFXTL1L7
   yhGmmZK16OB4aPi2BWC0oPAsLhsfjdYCHeVO96r3ERBWdcr0svOyTSsQn
   +0S0ebFOwRVJTu83hKTaLEQY6cvaXNiz3pJQaHEJvVI8M+lRr361pQ7Ir
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="381061895"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="381061895"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 13:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="923387932"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="923387932"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 13:47:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 13:47:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 13:47:53 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 13:47:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgOmHt6byAb5KgRVslraWRtrm7zYpJXDyvg9yoZWlpQuMDQkVWBqmPFODjYKhD46xprS99pJUbPTO0cOb4KYIoUlHOrsuLiBYn5fFstm25GIsRw4T0Uj1GfMiYLHS95QCx8+XLwPlja3rbpOBwWc3DjpbFsoNisSGYn3i1InpzGFijfL3LMw5yl9iI+q3zdikDA3UFhKvvJc5nkE9yPnNSuLlyBX2pH1vXjuTql9Nvisc1xHvFoMsLEzipWE7XrN14EHGJEk8oKvdaQVwlpmNE0eFv9xS8i10mYaFxPpZd86HsZE7yilwt4SmFxNx9iHIeU5zel9pPVSuIIB7nPv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0qwR79oeajwXuBAIhAduBgX+YtK74Bp7poXgeKGyTE=;
 b=SMWlSB2aWJdXTgXw86f5rj3P3CBvzd1N4/iQUwxwOjs9BsM/AVspBqESgwl8qBMMA1pI4iivpsjvHcjaVyUj6Q2qe1BIrT64rrqxkIGpJv7jfLhWBz6zC9GfmgT2kWGu72rV9uyywt1u6Edi8H9GoQ9o80FTyUYzFob8rSZcqWLZJzxUyNuvSvWrXJXWw09BpgDNO9/i8MuHYIq49Ik6i5ZakvZ6LpeXm3z/NdQUxrxnXRAtCBqpB7yCCR592o3Z4YNaFV/+QPycJmDvMHP2x6fQTkHslA1EvD8lB8uMVxxVmwFKrij1yRAcBiGuNAkfqgYVCou4Uu5JG7cCgYjRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Thu, 28 Sep
 2023 20:47:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 20:47:51 +0000
Message-ID: <a1eedcbb-3797-dc0a-918f-eea8a58bbf52@intel.com>
Date:   Thu, 28 Sep 2023 13:47:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/4] x86/resctrl: Rename arch_has_sparse_bitmaps
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <e689caf9dbb7664c26515a980084b5f17cb0644e.1695371055.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e689caf9dbb7664c26515a980084b5f17cb0644e.1695371055.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:303:6a::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 0293a72f-2e37-4561-ec72-08dbc0642eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJpSvfRvBIDEjoYirfnxD3brGzQldpfqiYqjMxRsD4gMF66d093NoQ8T0UbMFDTVslZeOSCS9i7BOREnTf2wyh4WLS6fLLmD0YBI6Kj9D+XhAPrsnImD8whTpwZGlpilg+uYUNcjDxQj068SoKS2rigAeMBRMhEvAsNYN01LNMmor8SFJAcYBYLA6RCktCKymTuAb6/ddKKA/c4AVRg5+bwxZTG3R00Pm6n45Nu1e5tzFhCtfJ1dsNbvnFcEYrIEZXW0R6xYlsFLDIg9QKDJyjiwRvzbzgV50i399KLjcbuLYJYQ+ryjpbkn4tNlBXO1IGLTukfWkfMzI3s8GLqvW7sw+Z/94xfbtflB02r6A6TpWxTL6YTfbOD1z4TH1fbXrHAFE+dlb42kN0zDVPek8EdW/XBbHdnf+8vRT0lwF05+uHOIvDGzeRWnzqWiGiytp44rxX7nBVZgFEDGhLCj2/nAhPisKPhaF3SpYu+1fXtvyIvTSF3x3QF2DbsoOYN9yr9CumhGs1mdoiGyBv1RdyUxSz3DfXlhQayEos6KNIBr9L9npy6MdKht9vXDEhwtqG3kxohL2PGb4ABzaJGqYi9LN5kRumzHgBSY05ApQ72JCeP3xkRWHyAW3w51XxjLDyEIX9AZbwkbAHoLnrA7DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(6512007)(6506007)(38100700002)(2616005)(110136005)(66556008)(66476007)(31696002)(86362001)(478600001)(53546011)(83380400001)(6486002)(26005)(82960400001)(66946007)(5660300002)(36756003)(44832011)(41300700001)(316002)(4326008)(8676002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXNvNDRVMmFDOGNoOEgzWkd1WGIwK0IxZzlyOEVsWEVTUGtVOGFSV0toc0Zl?=
 =?utf-8?B?UlJYWWdZdUp6aHFlMTdCYkdndlVZTEVtdGZFN0Z5TFNIWTZrVnBaMldINy9U?=
 =?utf-8?B?N2F1bjdsVXlRSkNadENjZlgxNVFVTnQzZ2YzVDdJNW9jOEp5dU4zcWZIbXBt?=
 =?utf-8?B?Z2lPWjBGUWJ4SUkwS0JrVzhaZkhCZUIxNVpseDc2d083S3ZDNmFtN2VFeU9F?=
 =?utf-8?B?QlIyRWxId2tjR1BHU2ZHR3p4eUVTaXgyZzQ3b0ZOeEFMV3czVXZUTE1xTVFN?=
 =?utf-8?B?OHc3cXpWSy9xT3pJcWxReFdSQ1k5ZUMyTk5hbzdFZGVsTXVNZDVoaERxd3kz?=
 =?utf-8?B?aWZUQ0Z3ZnNGa20zTFdHSm9SRkNiVlJZYXdJVGFiSUtLdTNuSUcrMTZVVkpX?=
 =?utf-8?B?TkthRitjK3pxVkFWLzRMdmJOK3VPSDVKbml1OUVHUVJuSU4xMWRSZys1dzZ2?=
 =?utf-8?B?ejFwNmhlbFR1UklUOERsaTRNRXBTZFhuM0ZUV1VBeEs0VEU5eGpsSjZBVWkv?=
 =?utf-8?B?c0dScEJVdDlDZkt4Uy9nRi9ER2M5Z0JaczhadXdXUVFxeTVxTlhWVEFnL1pJ?=
 =?utf-8?B?MTRkZXR6MmRUS1lDVXZxOXVwcnJEV3J2UzBtNlZjSzVsZnZmaWNWV1RaUUF0?=
 =?utf-8?B?TnFiU0laMTE1R2tGRE5xNzJDTE1kTjN5OUZwNjdDcHAwRUF1bVh4SDVjTUJB?=
 =?utf-8?B?a1k5RGJOS2dBcHZuTHg3ZVNHak14cWdRcFVCd0R1SW1jYlJrc3NYekN5TWk0?=
 =?utf-8?B?M2F0SHBuTUo3VmRzeUtsL0dmTW8xL0I5WkJDb0p3U2tGQjhMQWluNXdJbFR6?=
 =?utf-8?B?SVZFK0FUOTEzT3dCQVBNVy92RWx4YWtLS0tqNnZ4dlpoWDVzb3VkSUVaSXlO?=
 =?utf-8?B?NEZIQXBONTZDY0RsYkhFQ2hwYUpQVlJHbENlRC9kSUV5OEN0a2h2VmRQVWRC?=
 =?utf-8?B?SHN0RGxVWGZEQmpIMjBKb3dieW9POHliYnI4OTRlMi9aSkc1QnFmdUpLUHZr?=
 =?utf-8?B?MjdzR2pFNE9jNHVTL3ZXNE9RNzR2ell1eVZtR3pPcmVHcE56Ujhnd0N4RW53?=
 =?utf-8?B?ZDNTbnZ2RFdaczZzcTdrcVgwTjNxWXJxbDRoUTQwWHlqNjB6TWMwTTlrM1pE?=
 =?utf-8?B?ei9tR2JPbnppZjNCWUFScUlSelN0VGRWY2xHUU1ydERQUzI5T1VtbEt0b3dS?=
 =?utf-8?B?MFRzUFc3TW5wTXppT0RUYXBFeEsyRGtTODg5aFkvcGs3ektwakJWb2w4SU9T?=
 =?utf-8?B?QWtYSndTcWxuYUgvNTVVbjExb0FNSWxSSjRYZ2F4L1hYWG9zb2I3YVFmdUNo?=
 =?utf-8?B?NlVNd1VObE1OenJqRkQzL0VQR3haVStTTTNwR3cxdnRONG9hR3k2ZnN6cDdS?=
 =?utf-8?B?ZE03dnJUekw2bTdhM05LRGhkZHpsRWtCSFR0NFdGQ002eGVxMkNwbW9HNmlH?=
 =?utf-8?B?QjJ5TUJoTmI4cGVqUDJWNzRETkRuYkcvU3BzMDBySXd3WEpXVVNnbWlQQUk0?=
 =?utf-8?B?TjVqSVA1QU83Y0VZY3oydDdTTVhWVkpzdnhXNUhVbUw4enM0TkdiOGdXMk5s?=
 =?utf-8?B?NG9qS1kwOEh1Y1o3N0VXMG1OZFZpampUcWRNV091UDNCUjhXcHlrNGpPVysw?=
 =?utf-8?B?T0dhZzdyQ1BGbUlHeGNOMitFZ0cvWW1iMnFHOU5Jc0srSnQrMXB3Y0w2NkN6?=
 =?utf-8?B?RU1jQXhtalY1ZE5EbUQvZVdqQjZDdHpEMzVmUUMreXBMTUZiR3ZQMzl4NER5?=
 =?utf-8?B?S3pBek1JRWJxbmNCOERWK04rbG1VZmtmdXJ4YW1RMWEyWng3TzhwM01IODFZ?=
 =?utf-8?B?USsvOGtTbmx4NW5aKytsc0tLM3ZucTVObWJMUlhacFVJZmFweDJFN21DeTVU?=
 =?utf-8?B?L3JNNjR4eTgwbzhwRGRmMDRGWjhNVGFuMXlIR2VFdUhOY3BGdDA5R1ZwMjRy?=
 =?utf-8?B?Nnc5WGdIQit0TDU2QUx2NEhoNlJZMWNLOTdDZEV4K3JoRUZ4UWpWb1l6MndL?=
 =?utf-8?B?V0ZNaDh0aXRGRklzNGlEQTd5Sy9mVTRnc0p0dTFIY0g1RXA5d3p4bkJsbGxy?=
 =?utf-8?B?MmxQNlFKcE1RNWtjMXZGQzZwTEF3Rkx1UDhLU25TMGpxTUdGcE4vUFExdGpC?=
 =?utf-8?B?cmthMzJ0cmE4c3dzZVp5V0NwSm82TVBVbUYvU3hXZ04xdXJ3U0k4ZWozWnJB?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0293a72f-2e37-4561-ec72-08dbc0642eb1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 20:47:51.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/yRjyjYwm2ck74DY5ghHg1BVcyAtKKc7DhPlA+Xl09YYKlGtTh07CleBvBpgoOhx6MpWjXr+ZOnI4t7+G3h+GzjfdAa5JKJ7EZJiglAWpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7458
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

Hi Maciej

Could you please move this patch to the beginning of this series?
Having it in the end results in a lot of churn with significant
changes to new code introduced in this series. All this can be avoided
by providing a smaller patch at the beginning of the series.

On 9/22/2023 1:48 AM, Maciej Wieczor-Retman wrote:
> Both AMD and Intel documentations use capacity bitmasks terminology
> rather than capacity bitmaps. Also bitmask term is much more widely
> used inside x86 resctrl code.

Since resctrl is intended to support many architectures and Arm coming
soon (and they use bitmap) I do not think we should use the vendor's
language as a motivation. For me there are three reasons supporting the
rename:
* arch_has_sparse_bitmaps is the *only* instance in resctrl that uses
  the bitmap term for capacity bitmasks, all other parts of resctrl refers
  to it as a bitmask
* bitmask is the established term used in resctrl documentation
  (Documentation/arch/x86/resctrl.rst)
* bitmask is the term already exposed to user space via resctrl ("cbm_mask")

Finally, why do the rename as part of this work? This can be motivated
with something like:
	A later patch exposes the value of arch_has_sparse_bitmaps to
	user space via the existing term of a bitmask. Rename
	arch_has_sparse_bitmaps to arch_has_sparse_bitmasks to ensure 
	consistent terminology throughout resctrl.

> 
> Unify the naming convention by renaming arch_has_sparse_bitmaps struct
> member to arch_has_sparse_bitmasks.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8334eeacfec5..83c2cbf7136d 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -57,7 +57,7 @@ struct resctrl_staged_config {
>   * @list:		all instances of this resource
>   * @id:			unique id for this instance
>   * @cpu_mask:		which CPUs share this resource
> - * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
> + * @rmid_busy_llc:	bitmask of which limbo RMIDs are above threshold
>   * @mbm_total:		saved state for MBM total bandwidth
>   * @mbm_local:		saved state for MBM local bandwidth
>   * @mbm_over:		worker to periodically read MBM h/w counters

Please drop this hunk. rmid_busy_llc is indeed a bitmap.

Reinette
