Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B987B732B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbjJCVQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbjJCVQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:16:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FDF83
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367787; x=1727903787;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hTRAKMKDVmzDWHGoeh2PNB0ApdodZA+4cGIYQ+yx4jU=;
  b=IyFscooeciJbLbeqTAvNxq1yGWyjWnd5ikIthGxBe7EWu2RZru6ziu5y
   Qxx6IhQQFnYR1T0cb3t/VqgBQiqBu7ypCZi/wA3tz85kNo0BpI7yNJfZN
   l+9ItX/nqMkIwThi0WuXVocMeHYRnJfNG+tg/dIwDkRogffXLh+X8riah
   PJqA+ltbEpxXF2ixit9+zgkIXfA3TgCl6qZpcpmHUvBnkS21bKaPpOlC1
   mlT37ezkuvuDgICIvsB3mjyZ6giBlAUp57KTA98c9wT7i7jqvxyByvoXu
   2eNn6rFi/Ku5e6sdZGZgQPM9JOk6PKfWHwmztgZf7+jk6hSxKca+fBCOF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381854267"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="381854267"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="816853000"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="816853000"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:16:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:16:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:16:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:16:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM9WA6TLph1El23RT4H/YJ/3J4cyO/Cj0fUDoQxXcQ/jgLDMpV4PJGixrpTMY0+ICJHzLuPyAt8fgfkElqu2QiufUrPrrn3gHzKsazZ3N50mUEMvJzUzGBTokCyqR4z2q6b1UL1RYVG6Dn/otRnU0WaZ8BoSF+7WM4hadslfy/3oylKn2fMKA3C9zipKJWrD+Vui6ESCS81rRlOrFIgk7L7jdKryBwFbSVJ8dkbHKHeM1ZaeFbUTbk8CHZczp8vCu2lg/KhiAbPHX11XhUsHoGVT/QZYmoOjHOswB+QELEa/jS1GwJ31OmztgMxwwKYihTv+Q5gBltvh2mXSEQIp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFpTRXNdXrBDfgSMFTsBP7XLTJ9l2W5ROOjmn916Tx0=;
 b=hTpvmo9HWaUZxjDV6W05etkVnXck+bYxoePsOK4xViXtTR/GMDsh8JJGJwq2Oe+rM35X35IxjYwmkvJq3/dgPizI+curolrS7iPuEb/6a3sO61/85trVb5Xq3cJwAwBrl9nbDm7GxY25yNhmKAC5t10BPkEaBhZQZOT0UHIUTILIkYAgRw0gkF4GNgdAhbGhJXAp/+N2oYrFnwnBUPVKC/nJtOfukqiOj0CgKZJGbzMl3F6CSGHNcLGJJjIO9yImw2nQ83tDJ/bG6ZP+XJgIdfV/pZoaXOfcFQ4IDuSRH32ZAgnrRKRUdGTT8XpGxCEb6lytZPmRUSKViq6bnL2A/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 21:16:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:16:02 +0000
Message-ID: <cc656e8e-e652-baf9-7724-4507a9f7786d@intel.com>
Date:   Tue, 3 Oct 2023 14:15:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 12/24] x86/resctrl: Add cpumask_any_housekeeping() for
 limbo/overflow
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
 <20230914172138.11977-13-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-13-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f30b19a-4ead-466f-79ea-08dbc455f260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o02xdMYYCluVOLXwUYgwh49IZ9gnlVKg+Wr1Ifa4e4CfCHLvMvAHbasHwfzHLGGhNnHlzdIWL31qPzX1NWsraoYLcT8HB4QRJBMsh9jmE5LghYWuNgJtXMX4VmRUdXgw1/Un0hvRtbNTmzmHWhRpAZGjrfgrOi7yGef4vrIFa59NM1xIfuLjf6mzIuzS2nv+J8hqaV142nUnmLOGvT2SEZxyTfGZlB5eYTcWTg/Tt3kOEXhWWTq4ltVop+p/rHqf+vtdotGm7heARfc1AxqjB4yvvp0OrN82/a5HTPh+SVxV93okbAlEM5zleKfvNzuaIMFb6UDW7SGeM87neYec6OUiLgUzAXBELtnvFr9q1yxhVkfIDGpD9kW/eJ29DNrOKNgBwUDat1QjOycG/kP6x85qM0n8TcK150AvAA1IxDpKeM4kfi+34aP8wObKi8T/MQb122vdv28TzK8wMmpuKHYWMwB7/Beyt6PiR+Fvb1LGZ8J+dfkC6OsxHo7delB2erR60XkGIFQRpQm4URqKE9htURD51KjaCP/qcuPcQCv3c8s7O9sFpfOBzoAZNO+Mig3YKwMQZrie6IiyYpfrJHlD/FcQNH1B3PgbjBdBP+ZAAm6XZC1y+8lZogBzbcajJuPugy/iOJYomCMva2koSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(66946007)(8936002)(44832011)(5660300002)(54906003)(4326008)(66476007)(66556008)(8676002)(41300700001)(6486002)(6512007)(478600001)(53546011)(31686004)(7416002)(6666004)(6506007)(26005)(2616005)(316002)(83380400001)(82960400001)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUQyMkhRYzZOS2J2b0w2YzRVa2k5aG5jcFU2RFJFNm1yTEFUbGxFUUVWL3dN?=
 =?utf-8?B?RHFDQk12aEFQVG5NMXlwRmFEbEJPamhzYVRMUXNCY1VXRVltdW52b2wzck4x?=
 =?utf-8?B?QzJidUN0V2N1VS90ZXMwS1BRVWVBTXZGT0haTyt6aStNYkhOaVFoYlpVY2Qr?=
 =?utf-8?B?bk5BUDdJblg2VWtCT2thOGErWFZmOVJKemNZTGh1STdLNHUwQ05hNnBxa0Nw?=
 =?utf-8?B?U3RnTzlRVkliUEJManYzZ1U1dC9NZ3EyeXhCbVNwcHgxWnRaNkplbm5UQkNt?=
 =?utf-8?B?ZzFGVFpsdVFPVFAyaVpnWE1WMVQ2UTcvLzlmQWtUNjQwUU5KSUxFelJpSUxW?=
 =?utf-8?B?UE9TcGw3ZkhCOFg2MmdYeDVpZFZ1eGtYVzlJTGpZK2RrbXdnK1plSDhBRGh3?=
 =?utf-8?B?NTdtUGhTWFJla1U1aENmSzBnbG8vVk9jZE5WdnEyU0tjcUs0Uys5ZmFiKzkr?=
 =?utf-8?B?TDVpSWpBRFRUOHpCTzltUEcvbklLNllaYnd0US9mSXBOY2laRkQ2VVBKYXpS?=
 =?utf-8?B?M2FMWnZzd2lIOG52MEpJOHh3TTloYnBIaUZaYnByQkZrcnNoVEV5YitmaFFj?=
 =?utf-8?B?RVA3UW1HVTEvSEc4eVA1cXN3MmprT3gySWo2Y3dBZHJsUmo3NmMreG0xZU8z?=
 =?utf-8?B?OFRrek5NZW4zTTRHVGVHNDhOV1JzWTlBZzArZEZZaTNORDRCR0xUeEUrKzdE?=
 =?utf-8?B?cnJhSStQTGR1YWs1Z0NYSWZsendNdVlnQVVWclBZbENtQWVwTW5NY3NhK0Uy?=
 =?utf-8?B?MkhNT2dFMU9UVUE0bjNjRmx5YUloM2hhc1lGMThQd0NaczlnVDR4aUpNNUNL?=
 =?utf-8?B?OVE1dXp4ZGhTenc3R3l2SzBlajhVUkNJRUxOSm4yN3N5clMrSkprazZFcFM3?=
 =?utf-8?B?c1VNT0REbnFTeVZHcVJXTk0wYkk4MXY5U056bU5laEQrK2FGWU9DUEpqL0RO?=
 =?utf-8?B?Q1RabHRaK3M5WElzM0RhVEl6L0pKTDFtcWd1YWVRaW9kU2p4K21WRGxwVE9F?=
 =?utf-8?B?ZGIvYjM4NVQ4TmZ3ZFNVS0YyTzlGT3ZSby92YW9ZSHJnazdrRTZkV1Faa3di?=
 =?utf-8?B?RmtrVWQ4OEZGNTFSZ0l5cnpHZ2xkOForbko0b0ZYVzBrK0Vxd01WZjM2QnJ1?=
 =?utf-8?B?cVRweDJSWjRRRUlEV3pWUVlrcXJoY1pmdTVjWllnSmtGeGo5RGtIVlJwZnZw?=
 =?utf-8?B?Y2ZMcDg4MVNxZ25PRnlZOXBQU3ZETG4wdEQyY0sramJHUTFHSlY2YkFVTFhX?=
 =?utf-8?B?dXF6WnlWclExZTlMZXlFWEw3RXN4L0pabk5zUyt4NE91ZHBmdVRmK1EybFJO?=
 =?utf-8?B?b2lzK1pvbWY5Vk5JSSthV3p6ci9RTjZXcWt0T0FjdHV0dnpiakNjSjdQV0hZ?=
 =?utf-8?B?cW15amRkWExqVWZXb2JiRkl3RzZQMVZyWWQwV1luSys3OUhleVRkUkw1bnZ2?=
 =?utf-8?B?MEU3T0p5ajZKZ0d4ZlJrd2RFSXlwRFBKQ05QWEd5RmZia0IxdVZqOFo2UkRP?=
 =?utf-8?B?aTBINnY0azhXamtvZDFYblc4RmZCOURhemZPaG40Mi81Ry9wS29HTUFBTXNz?=
 =?utf-8?B?aFRuTDlXdGJQOVptS2hEMW9BVjVDRVIrelkwUVczakY0UzRpcDhiejhia0NY?=
 =?utf-8?B?dm9UMEVVbWppaU91R2NaWW13YkgwTUhOUi9wUVNsL0VIUkhkTHRLQnMrVXQ4?=
 =?utf-8?B?WlE5WjFRWE8ydVhYb3VjeWw5UTV3Tm5lbUMyKytrN0s4aGMzVHdtSzJHVzlz?=
 =?utf-8?B?L3lEZFBicERvNGZyRHhUYUlaVDRlWkhxVXgwTjlzbDVkekRhNXFjQmJyaUwx?=
 =?utf-8?B?c081N2tlT0NVL3pCNWRhK2tDQ0dhc2pkYXQ1QXdrVWgxclJZa1JYeHdYV1Q4?=
 =?utf-8?B?SUJrVDl0am0rTjJNTStkUWxXU2djbWl6YnNhVm1OZTVqSlhDYVNhWmYzeC84?=
 =?utf-8?B?SzRMRnVTWFZ2Z0NYZGIxWjQyeTBxMDZlcG1YRE54ajBYS0RaeEZQdThvdFpw?=
 =?utf-8?B?Mk5OVVM1bEJUV2NWOFdxZTZaUEJlMmE5eWNreW5KVFlGcENicnRYeml2L25k?=
 =?utf-8?B?U1BHcHYzVE4yRW9yRWZZWlFQUWg0Rm5TRE9yVEhCajlUajdLbkgySTJPejZ3?=
 =?utf-8?B?ZkJTTUlMbmYxbktsZzJ0N1lwSVF4bmJsam1sa2JIWHZKeVJHSE9Rc1dwSXhU?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f30b19a-4ead-466f-79ea-08dbc455f260
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:16:02.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xy/l9lLS4/bIxBIAv2h1AyR3ummGWguq148BmWVnvFrFurfXlou1XErcrWuZNibLHz3wTTOAfpicq674q2SMt5ORWwwNKYqj7qGrcg12Pas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6059
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
> The limbo and overflow code picks a CPU to use from the domain's list
> of online CPUs. Work is then scheduled on these CPUs to maintain
> the limbo list and any counters that may overflow.
> 
> cpumask_any() may pick a CPU that is marked nohz_full, which will
> either penalise the work that CPU was dedicated to, or delay the
> processing of limbo list or counters that may overflow. Perhaps
> indefinitely. Delaying the overflow handling will skew the bandwidth
> values calculated by mba_sc, which expects to be called once a second.
> 
> Add cpumask_any_housekeeping() as a replacement for cpumask_any()
> that prefers housekeeping CPUs. This helper will still return
> a nohz_full CPU if that is the only option. The CPU to use is
> re-evaluated each time the limbo/overflow work runs. This ensures
> the work will move off a nohz_full CPU once a housekeeping CPU is
> available.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v3:
>  * typos fixed
> 
> Changes since v4:
>  * Made temporary variables unsigned
> 
> Changes since v5:
>  * Restructured cpumask_any_housekeeping() to avoid later churn.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 24 ++++++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 17 ++++++++++++-----
>  2 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index f06d3d3e0808..37bb3de37a4a 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -7,6 +7,7 @@
>  #include <linux/kernfs.h>
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
> +#include <linux/tick.h>
>  #include <asm/resctrl.h>
>  

Please maintain the empty line between groups of headers.


...

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 0bbed8c62d42..993837e46db1 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -782,9 +782,9 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
>  void cqm_handle_limbo(struct work_struct *work)
>  {
>  	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
> -	int cpu = smp_processor_id();
>  	struct rdt_resource *r;
>  	struct rdt_domain *d;
> +	int cpu;
>  
>  	mutex_lock(&rdtgroup_mutex);
>  
> @@ -793,8 +793,10 @@ void cqm_handle_limbo(struct work_struct *work)
>  
>  	__check_limbo(d, false);
>  
> -	if (has_busy_rmid(d))
> +	if (has_busy_rmid(d)) {
> +		cpu = cpumask_any_housekeeping(&d->cpu_mask);
>  		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
> +	}
>  

ok - but if you do change the CPU the worker is running on then
I also expect d->cqm_work_cpu to be updated. Otherwise the offline
code will not be able to determine if the worker needs to move.

>  	mutex_unlock(&rdtgroup_mutex);
>  }
> @@ -804,7 +806,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
>  
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>  	dom->cqm_work_cpu = cpu;
>  
>  	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> @@ -814,10 +816,10 @@ void mbm_handle_overflow(struct work_struct *work)
>  {
>  	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
>  	struct rdtgroup *prgrp, *crgrp;
> -	int cpu = smp_processor_id();
>  	struct list_head *head;
>  	struct rdt_resource *r;
>  	struct rdt_domain *d;
> +	int cpu;
>  
>  	mutex_lock(&rdtgroup_mutex);
>  
> @@ -838,6 +840,11 @@ void mbm_handle_overflow(struct work_struct *work)
>  			update_mba_bw(prgrp, d);
>  	}
>  
> +	/*
> +	 * Re-check for housekeeping CPUs. This allows the overflow handler to
> +	 * move off a nohz_full CPU quickly.
> +	 */
> +	cpu = cpumask_any_housekeeping(&d->cpu_mask);
>  	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
>  

Similar to above I expect a change like this to
be accompanied by an update to d->mbm_work_cpu.

>  out_unlock:
> @@ -851,7 +858,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  
>  	if (!static_branch_likely(&rdt_mon_enable_key))
>  		return;
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>  	dom->mbm_work_cpu = cpu;
>  	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>  }


Reinette
