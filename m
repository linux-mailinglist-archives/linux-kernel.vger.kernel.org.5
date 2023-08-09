Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEB6776C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjHIWcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHIWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:32:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2188D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620336; x=1723156336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RNI5mnoPiRoVvvh1Y3MWvCSD8zyNK3tPiwC5viFhnZk=;
  b=Lcd0r1VxoRTTo0qtNPEhhidFiqEvtGr0C8b6g/b1BAeqBnPhkFyqEZ1c
   gLF/6NHoRDIB0PEpCgoXyEilN7SbxylILuMy9EyNr8yPeb//6PyWVQQLZ
   JCLA9nCNPJLotTT2Ey3h0ZYDwUUF0JsSkk0enQKONL6lyu8AqnlUlmI/D
   fQvD8/w0q6fMjVUL8xTRPDZX4MbbcTjPKGzi/TiovvUjLU5YyRCiv9wfU
   8GRpzEFAWjNJQlEqWAT3Xn7vlrXUhtlDBhfk0t1qoJoh+H1qcgrp87BRc
   fW7TOUTqe4eBMvbFKMLtliGOaDaQd1tvm0G/uchGbGp/D+p1p0W09v2Mm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="374029127"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="374029127"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="978564827"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="978564827"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 09 Aug 2023 15:32:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:32:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:32:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:32:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5TCHDmQECTIF7h6Kw2H9NotzraHG3xRWFckCwdkRTQ1FCn0hsE7JP9QvBgKjL9Et8OHSnI93tTkRoaQH5+a4ZbKeles/WHnhrLjHYye0gyOCsR6SnM8RyIOZCSZu5SFWaZ9rg17Z01/FcaMhIJwEaRmh0OOTuknjD3JDz+jBPFsCqY44TH91+YfB9dbNgNKhc8E4QUPe4qwFDSmiuDeZZvKHKv2cSu3/ISjKsvLArdY7gC13kEyVAjcRSCuY7dSlHoOy1pWG9bsL7lNz5HlYJN6NJycyT6Wu3rEq0gUnfSVGaudzKCRA9gkNvXHduBNA2mLpsUVjGJsjF07blXTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbRVDp9GSYRh6NtXWIpPAELO7SAvpiJsSSqIk/wyH7M=;
 b=IYcLDzfBkwflyiBfMXBGnWW0Z/fKkUg4J62tOMWz8RTUQFRYMYBUWPs2LGdRaSMVDBj2Sl1A82FwX6TSHZ6qNOd+oi/RrjddE2LdvN7ETYXur70aEuvqPTRG92TPD/k0G9CsbLYdJ8sptqAIfQ9LNrSqNG1P4jwzAUeeGZhOUADHNyiYPFizihQc/ENrXWyITXh0gPAQy/xDUVORS1yJnzGWnXM6Ij4iBpUmWnaGF9m9oh718jyU7DpQKBQ2ti3x4mlP7OFQCgYQC21n8P6IZdJir1DVlDgE4ZSTP/fKyMEDmXxuGIpdxGSDATX3L1vCiVAvokqIDSeELAmWD0mrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 22:32:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:32:12 +0000
Message-ID: <53c3da82-35d3-cdc9-f5d9-be6cb904a163@intel.com>
Date:   Wed, 9 Aug 2023 15:32:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 01/24] x86/resctrl: Track the closid with the rmid
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
 <20230728164254.27562-2-james.morse@arm.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-2-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:303:8f::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbfead3-3211-4a79-511f-08db99287958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/eMb8+aA7V2wv543gOxIQD0UDfcD8pdmpkKD41nSWjP6O9jjSVIOFBKu/wu+zaNBH6UpB/WaetzxLyOJUtgRKN75jAlpzCxJ1p1RyKAPZakg4gCiAfLs2UlhsIo530pFqNfSBDC9X5gKQofTiBVa5NySBoR9dQSZkUuukPx0/C+y8xvgSqu72/cePJ36aFRNBv2EGXnvVf7w0aBHUoYoWn5gnbdc9PyfHcY1kDd9n8w2/UmacDmsIVW57RrggHwNoglLmv9leenmN2o1S0Zl0yGlbFYw+NCxbl9jeO5SKfqagLhDyvRPA/REkBDYw2lBx3l+jZTuuB3cPPKeSuRxI6xvadQhX9lRKcwCtBzW/reg7jqKXF5+CEbbCaZk8bTOmgvTYRbGOqAUxrjUxLNlIsk9KLQZcZ/+pUXAllfmbH1SAIILaYqgcT//5HBXrAPL9KfyMmCUjHcfuf6+k+Xw52RmKJUcgdavuYFdctp2He203oWGDmmIWe52g74HPz0KGKUw/P9g4PnxzN3rb1TBVR4ebcAfLf7OMyhusOJ2gvd6b/2fIbvAtr5LYpmEGGYEhZ/KcABm7kI1wG5wTVcYJi84nKilnzVLcOnNI7JyQGkwQqTmz5695iFTDuj7AoN9DJWeZPDAx0BpnTH6f6k+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(26005)(8936002)(41300700001)(2906002)(44832011)(5660300002)(31686004)(7416002)(83380400001)(8676002)(2616005)(38100700002)(316002)(53546011)(478600001)(31696002)(86362001)(66556008)(6506007)(6486002)(54906003)(82960400001)(66946007)(6666004)(66476007)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2FpYlZiS1RSZ05wZVNqUmkwNzhVNkhqaVJWVlZpSUVtQWE0WDdxSjNIa0dx?=
 =?utf-8?B?SVN3U1Q4Z0J3Y3pKVXJ5QXFzc0dVM243NHpEYnNCUE1NNGd6MTdGRTlkYlRO?=
 =?utf-8?B?a2Q3TXc2d0N1ajVwM3U2L1cyWmlydnhsNnhKeVRuWkgyWXBzL3k1OGI3YThH?=
 =?utf-8?B?ZmJCYXdBbE5VSlN2N3U2RmNJcE8zQndvOFNGRkNJc0ZBSSttZDBieDJzR3pN?=
 =?utf-8?B?WDBBYXM5UTlSMHg4SzhsTk5xTFY0azJnNlRYSWN5VEhQZVJJVjgzQll2cHhv?=
 =?utf-8?B?QmpCSE5UYjVoSldDSVJCMHQvOVVybDZQczZQSzlMZGhQRVFaZGUyckNFL25O?=
 =?utf-8?B?cWRKeDg3SEJlTzRBOFB6VGVkQzFXYVBhSnQxK0lMMDJOd0NpaWdSbGFFcFls?=
 =?utf-8?B?TlZaYUtMVGpjUFJTcFJGcVVtRmREM1RwSTUzVFgrSXdTdEVpb3JxTFIwcGU0?=
 =?utf-8?B?VE9LZXAwMXg3ZklKdUJsTzM4T3BEWFY2TGhHaWJuVWZPSjhPUU9vTGs3eXJI?=
 =?utf-8?B?WmVwdUFaNll3Y29oNG9oTTZ3blROU1d0M0owU2NXNkZaNGlSQ1NuR3hJOWNT?=
 =?utf-8?B?ZTZQSERnZE1BM01BVFBzWkhnR3B5ZEpzQTJiU2lReHJIa0JFaWY2c2xrNDhN?=
 =?utf-8?B?YTVCbG1Va1JHUUd5dXF6Q2FORnhuT0pYZml1K3B2cjlRZmM3R2tYMHQ3MkpM?=
 =?utf-8?B?TVNCZm83OW1MN01VeDAyVUFrcTZKdUc4aGZQRHV4VEdtQXJOeDd3Tjg3aUNS?=
 =?utf-8?B?QmN1ODRHS2JURjNkRkdJZmhKTmlNNFpPNXBsMWlLNVRqLzArNFNjR0p3VitE?=
 =?utf-8?B?T0VmVXZGVmRtRXp2WFBQak0wdnlPdHlBVHVXcDJNemxPd2UyZ3ZYV3VYWDh3?=
 =?utf-8?B?aWFjUEJjeHFlc3I2N0h1a3lwMHBpMStpZDhrNFcwVXlQeVgyblZzVm5DN3Ja?=
 =?utf-8?B?UFdYWFhxRjUvdDBLSkVtZkR1MjloNWlDYnZsZzNHZ0FnWFB5VmxMSVVoSnBy?=
 =?utf-8?B?aWZQUjVDNnl5Zi9nVDA2QkVHOTZ6bzRSNkNYbzRZLzdIM0NteTJnYnR2V2J6?=
 =?utf-8?B?YlRkM1hNb08rN0t1bUxRUkpEK2pON0xGNUtvSFFqRDFwaHRyZ25kYlBOY2ND?=
 =?utf-8?B?WFUwUWJrcC8zeWM5UkVydC9WUjZJZHVaY2Zyd2VkR2x0NDFEQ2g5bW9PYUFP?=
 =?utf-8?B?Tk5tWC9XaWlpUzZSZHM4K0ZIcVEyS2R6elFRQ2cwVTU1a1VFSnJxUWhTRWdt?=
 =?utf-8?B?bzFLdGhjUDY4cmg3Mm4yTjBxR0xvVThBNVY1bjBuTEIvenZjaThBZ3VxNDJK?=
 =?utf-8?B?Z2IwVng4QVM3K2Q4Uld2K2FkQ3gvK24rZnZSVWFWRXA1MFZndUNRY0lsRDhh?=
 =?utf-8?B?RGlSOVJKV2kxWngwNUU3NW81SllMazRxaTV5Vlp3N0podDR4OTA3cG5FbmtE?=
 =?utf-8?B?aUttNGcvVUNKdmFLNmJBSU1uRjBJSXc4Z3BSZGNPL0gyaU5kSVhnWmcxWTFY?=
 =?utf-8?B?WVhWMXRFR2gyczd0Y0ZNUWV0TkZMbTRwb1RuNmRhRVZjZkE4amxSSU5pSUVQ?=
 =?utf-8?B?ZzgvamR3dXY5dHg3clpJbURSNjRhWkluNmJvM3RiOEpsZDFSRHFEdHVMeDAz?=
 =?utf-8?B?VlJid2NzWlJIZXJGNEk3ZVNVVlZ4WW10RGNxTzU0RFRuVFF5N1RnNTBFRGZV?=
 =?utf-8?B?NXQxWUdEYnVJRDFDSVE3WUtnSTc4aURKS3d5S2JOejBOaTc2QWxhOWF1Q3pO?=
 =?utf-8?B?a0k0b0xFV1ZYZExleXVQV3hjYzFPWWVTVHN4WThMZ2g2UERESFdmMHMzVU4r?=
 =?utf-8?B?dWpnU0kxaEVVeGNCYVFPNE9LRWJPeEpwdG1BVjFzWWphb2V6elJLaXRaM2JZ?=
 =?utf-8?B?SnczMjc4R2d2ZUlIM2xOWDNsaHVyQW9vY1Q2NGdEUnE0UHczMEE2alNzKytw?=
 =?utf-8?B?OXArNUxCNE9od08xT0NPYnkxM2RtcjFWbkJhMEJvZmJ1Zi9VYklZWDJHbHJH?=
 =?utf-8?B?VWtMRGtGTEdqOW0wRmJmWTA3SmJkVS9wNng1dEVaWG9tSHNBYVRRa2M4ZUhj?=
 =?utf-8?B?RCtvWlduTjZySjhsb0FFVTBlN1ZGTEJTUHp0MVFvaGJ3RlRwbld4OWRWTXV1?=
 =?utf-8?B?RThlS2RUREFueFdqbWNzQXZxQ1k2ek1uUXk0SktIUEZuVTV0TjJUMUl6RGU4?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbfead3-3211-4a79-511f-08db99287958
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:32:12.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Szq8HZkUF4IEs4CvNwTLJPTQDvMglv4P0V3qtRDfxEI/liU9bcebjr0YGYZJXs9srZz0SZK/iuludfCxrfKQ50ujQlk/hlXOG1j3bjlBnck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index ded1fc7cb7cb..fa66029de41c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -25,6 +25,12 @@
>  #include "internal.h"
>  
>  struct rmid_entry {
> +	/*
> +	 * Some architectures's resctrl_arch_rmid_read() needs the CLOSID value
> +	 * in order to access the correct monitor. This field provides the
> +	 * value to list walkers like __check_limbo(). On x86 this is ignored.
> +	 */
> +	u32				closid;
>  	u32				rmid;
>  	int				busy;
>  	struct list_head		list;

In Documentation/process/maintainer-tip.rst the x86 maintainers ask to avoid
documenting struct members within the declaration. Could you please use
kernel-doc format instead as is requested there?

...

> @@ -429,7 +439,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>   * __mon_event_count() is compared with the chunks value from the previous
>   * invocation. This must be called once per second to maintain values in MBps.
>   */
> -static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
> +static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
>  {
>  	struct mbm_state *m = &rr->d->mbm_local[rmid];
>  	u64 cur_bw, bytes, cur_bytes;
> @@ -459,7 +469,7 @@ void mon_event_count(void *info)
>  
>  	rdtgrp = rr->rgrp;
>  
> -	ret = __mon_event_count(rdtgrp->mon.rmid, rr);
> +	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
>  
>  	/*
>  	 * For Ctrl groups read data from child monitor groups and
> @@ -470,7 +480,8 @@ void mon_event_count(void *info)
>  
>  	if (rdtgrp->type == RDTCTRL_GROUP) {
>  		list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -			if (__mon_event_count(entry->mon.rmid, rr) == 0)
> +			if (__mon_event_count(rdtgrp->closid, entry->mon.rmid,
> +					      rr) == 0)
>  				ret = 0;
>  		}
>  	}

I understand that the parent and child resource groups should have the same
closid, but that makes me wonder why you use the parent closid in this change,
but later in the change to mbm_handle_overflow() where the monitor groups are
traversed you use the closid from the child resource group?

> @@ -600,7 +611,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  	}
>  }
>  
> -static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
> +static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
> +		       u32 closid, u32 rmid)
>  {
>  	struct rmid_read rr;
>  
> @@ -615,12 +627,12 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>  	if (is_mbm_total_enabled()) {
>  		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
>  		rr.val = 0;
> -		__mon_event_count(rmid, &rr);
> +		__mon_event_count(closid, rmid, &rr);
>  	}
>  	if (is_mbm_local_enabled()) {
>  		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>  		rr.val = 0;
> -		__mon_event_count(rmid, &rr);
> +		__mon_event_count(closid, rmid, &rr);
>  
>  		/*
>  		 * Call the MBA software controller only for the
> @@ -628,7 +640,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>  		 * the software controller explicitly.
>  		 */
>  		if (is_mba_sc(NULL))
> -			mbm_bw_count(rmid, &rr);
> +			mbm_bw_count(closid, rmid, &rr);
>  	}
>  }
>  
> @@ -685,11 +697,11 @@ void mbm_handle_overflow(struct work_struct *work)
>  	d = container_of(work, struct rdt_domain, mbm_over.work);
>  
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mbm_update(r, d, prgrp->mon.rmid);
> +		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
>  
>  		head = &prgrp->mon.crdtgrp_list;
>  		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> -			mbm_update(r, d, crgrp->mon.rmid);
> +			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
>  
>  		if (is_mba_sc(NULL))
>  			update_mba_bw(prgrp, d);

Above hunk is what I referred to above.

> @@ -732,10 +744,11 @@ static int dom_data_init(struct rdt_resource *r)
>  	}
>  
>  	/*
> -	 * RMID 0 is special and is always allocated. It's used for all
> -	 * tasks that are not monitored.
> +	 * CLOSID 0 and RMID 0 are special and are always allocated. These are
> +	 * used for rdtgroup_default control group, which will be setup later.
> +	 * See rdtgroup_setup_root().
>  	 */
> -	entry = __rmid_entry(0);
> +	entry = __rmid_entry(0, 0);

There seems to be an ordering issue here with the hardcoded values for 
RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID used before those defines
are introduced in the next patch. That may be ok since this code changes in
the next patch ... but the comment is left referring to the constant. Maybe
it would just be clearer if the defines are moved to this patch?

>  	list_del(&entry->list);
>  
>  	return 0;
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 458cb7419502..aeadaeb5df9a 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -738,7 +738,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
>  	 * anymore when this group would be used for pseudo-locking. This
>  	 * is safe to call on platforms not capable of monitoring.
>  	 */
> -	free_rmid(rdtgrp->mon.rmid);
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  
>  	ret = 0;
>  	goto out;
> @@ -773,7 +773,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
>  
>  	ret = rdtgroup_locksetup_user_restore(rdtgrp);
>  	if (ret) {
> -		free_rmid(rdtgrp->mon.rmid);
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  		return ret;
>  	}
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 725344048f85..f7fda4fc2c9e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2714,7 +2714,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>  
>  	head = &rdtgrp->mon.crdtgrp_list;
>  	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
> -		free_rmid(sentry->mon.rmid);
> +		free_rmid(sentry->closid, sentry->mon.rmid);
>  		list_del(&sentry->mon.crdtgrp_list);
>  
>  		if (atomic_read(&sentry->waitcount) != 0)
> @@ -2754,7 +2754,7 @@ static void rmdir_all_sub(void)
>  		cpumask_or(&rdtgroup_default.cpu_mask,
>  			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>  
> -		free_rmid(rdtgrp->mon.rmid);
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  
>  		kernfs_remove(rdtgrp->kn);
>  		list_del(&rdtgrp->rdtgroup_list);
> @@ -3252,7 +3252,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  	return 0;
>  
>  out_idfree:
> -	free_rmid(rdtgrp->mon.rmid);
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  out_destroy:
>  	kernfs_put(rdtgrp->kn);
>  	kernfs_remove(rdtgrp->kn);

This does not look right ... as you note in later patches closid_alloc() is called
_after_ mkdir_rdt_prepare(). Adding rdtgrp->closid to free_rmid() at this point would
thus use an uninitialized value. I know this code is being moved in subsequent
patches so it seems the patches may need to be reordered?

> @@ -3266,7 +3266,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
>  {
>  	kernfs_remove(rgrp->kn);
> -	free_rmid(rgrp->mon.rmid);
> +	free_rmid(rgrp->closid, rgrp->mon.rmid);
>  	rdtgroup_remove(rgrp);
>  }
>  

Related issue to above. Looking at how mkdir_rdt_prepare_clean() is called, right
after closid is freed, this seems to be use-after-free?  Another motivation to
re-order the patches?

Reinette
