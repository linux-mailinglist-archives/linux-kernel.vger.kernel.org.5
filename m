Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC237AE230
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjIYXYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYXYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:24:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E00CC0;
        Mon, 25 Sep 2023 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695684240; x=1727220240;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qSBiGRQfynI/9ztyWZySmZooLFR8UX1HTSsadr+C1GY=;
  b=U0zld3Pf7Q8fR2TfR2cCXRByOXxNCnRQOvq+AAAPQjHHgVz5xW4GTdrk
   Y2KAOwulRmCXeaQXqnmf4BWKRt6bQpp30i7KxlrRXzaSG2Pba18ppyTpJ
   I6XEbN80kcpjW5SpZO5jM4YnS+/J1/+F/h3PMx2igSPkG03m293Y2vYI5
   j3S+vqkanqHwRpPGRmCHIl6zz/8LBuHLrK/ukRgUjP+Eh2TZO82YckAm1
   ouBPh0sd1ewXtdoGugpJCBCRFnAup6v9JlNIkDSn+ROtAb3hdkFHu4dGm
   MY0yZr0lVuGymMleKacZHrTM3vq1KkioB/krxw7g/yMS7g6fG0JTBBla6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360815393"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="360815393"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="891962738"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="891962738"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 16:21:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:22:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:22:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 16:22:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 16:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/q2nOkRhC0iByi0QWE6GGSuqGr1ZoPkT2Tp2Dv3uw1feeUDi51tOiwBve7F1PSiGFy3IAnCqrsknBtvfY2djfnUnQbJrgbPEIoh4wDs2peBK80cKdHbzfot7nJysHv/aQvNTQaV4PW5u684FhLgF9Enk49oUT7JS46Ud4Oov/qxJ/sxSzKLsg5uJcwWTGTR0c2VNnfKVcQkNRuTrHMsi942WqEK6dcjhGqxeV9M5yU23JQjZ2Ljpn+Qtzb6X0LG9A9+RtBcZ8amWjtSqhdsA2SJNpWWppWPc0jjECFnwzSufagHRfJzzuOWMFPnvP5MeZh6PIR1DBKtDSA2sLWP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJZ1ECswjW2ZWwk7aBxwAjc3wEI5N9jRB1vPHHil7hc=;
 b=Y3ebeGH+ZsRCzqY4EjwRq76rXWmD5tY7Iul1T9avNmxcMa/DUSQjvStEJ54Auj0iAzgwVpwiRgEqWStbe0OmL6L8zgcw2mj3QpxGmFEsbtJPsEzvF210899AdiZy8yNzKaN3+nJnQAnL4CeHhKO9GfU3n0AMvrYls086MrSTCZRHUmBw4GNj30euEhG4uM0Vmp3YKP1Uc4sdtn6m0Z07z2792nVrmPtJYTxxP+TQKnUaYhX6AAHvUD2wmoHcUF2NSuyEOvrnfxCod9zEkNyoiH6JZprBb1YOZxZJv36CNKH2ITARFkdtOO8/uk2UXxnvRNoCQ+cryc0MlpT4xnGXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 23:22:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 23:22:32 +0000
Message-ID: <25dae76d-9e8e-9381-066f-7eaeadb85dc7@intel.com>
Date:   Mon, 25 Sep 2023 16:22:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-2-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230829234426.64421-2-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d900db-6a54-48f6-0ad1-08dbbe1e4b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jgq45iX9WzBYcFJA5xvzcGq3QJ3WLZaY2OihwzR/KiAX87IBjDESQOavv78barDySIQ4XduYONZoFQPBtq389E0xuO0LDt487ZDZqNMRV2bCC4/txIwylbzeX0MuiusjJ7mNUjYw/+DjWuCB2GT+2E7embexKPHa4ZNkoHkm+uD5V5ONy7JEuWy6Kig4p5wlTOJP5puYwP3W8K+wsbYFE+AlarjYOYBfP7nurnMiaOnsrsYkbIlUZXRFP3QEoVGx4/MeHUHfLVvss+bPZH+BslgY2KxBXGUju0b8YTH0zoUSdiX57J6p7TdZFNEiFROmOHpDaAorGGSGzsj05mukvUaeC8AGhCSgNkMlQvLMQboaxindMiJ4j9S/Px5ChK+VUmugRCmA9CtyMNwx0rT0C1Y2cQ6C9NLOm7Pj5AxxE/aDWkthJcKwukrGX6LepL6cbcSEYi9WQuOFW2dcR0wOxJNPBNbdh0zExQzQkDRNJnGl+khL9KW+iml8h1QWWRE3EZEuoXDx0f36H8zyrBB+EXLiXrOqSZndMdf9olHAqbg6ibUO8BbYlL5ziYP5IdEXw9bL9CK56CWo6kElyGzqAPk0h8EQ7fnDx/COMTStn3HN2N3L8akyKt4viXInMOKs7s0f8IjJjRwR/A+gHrjw9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(31686004)(2906002)(7416002)(5660300002)(110136005)(66476007)(44832011)(66946007)(66556008)(54906003)(478600001)(6666004)(6512007)(53546011)(66899024)(2616005)(26005)(6506007)(6486002)(4326008)(8676002)(8936002)(316002)(41300700001)(83380400001)(82960400001)(31696002)(36756003)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2dCSGlnWkprbnEwNHZmdE1EMTQzcXpXcDVVWUVFdXgrbWhySDhzU24rS0sx?=
 =?utf-8?B?Y3Z4dEM3dDhqU3NpbFNIRVRkUzgzOXZnVkR1WHkvTXFOWGlYQlVuS0lvNU9O?=
 =?utf-8?B?TTdsdkVaNFNOQUZlSVV0N0N3R3pxbHl6YXIyRnEySE1Za3hDMEhQMnhNZ0ZQ?=
 =?utf-8?B?RDFjcGdxSGtuWHZDTzBpbWpxSE4wVWJFeHlzc1krTHB3TnR2c1NMQVIramxV?=
 =?utf-8?B?Q0Z4Y1hSWUx6NmhaUDNZdFJza3dRU1ZmZnZrb2xJN0M1eDVSNjFJNEhZL0h2?=
 =?utf-8?B?YlVsZ1cwNkpSREdjTE80enFrTUUxVjBxdG1YTEcyOUVVaXM5Um92SjMxVmRE?=
 =?utf-8?B?MjRPTkw0c21IWVp0b045QWNXcUlYOW5TekRSRzNycnBxSUZqVkRPZ0ozTG5r?=
 =?utf-8?B?d01qRVNETmtjSzh4K2ZsMm42ei91L2VSanFSUW5BRER3N2hsM1pmYmtJTWJE?=
 =?utf-8?B?T1ExQm42U0F2N3dRQkl5TjFWaThOdHNqdk9wbFQ2UTJFKzQyWHpTWjY2S1NH?=
 =?utf-8?B?OWhmbElCOXlZdGYwNE9MS2wzVlp3NHdDSnFIcW9TV1NVL082MGVwMTZVeEhX?=
 =?utf-8?B?WkprOVRsM05LdEZBTWo5UDBPd3BPalQ3eFA0d0lpbmVXUDVBOUloNEhzOHkv?=
 =?utf-8?B?Ynl5ejNSSGI2UFF1UnJvdUkzaW0zVG5pRXFFbER5c1F0MFBPNjNlMHZKMDFl?=
 =?utf-8?B?R3M1QlVnQmxCeDZndWZIa1lMZmdaK0JKMmJob2RIVGlQdmltL21PQmU2dkR5?=
 =?utf-8?B?MFM0NFRSR0t6K2ZmeURNamxSUXl4ci84cHh2cmQyOW1JcUtRelA4WFNNVXFq?=
 =?utf-8?B?QXhhbk1DNmJHaU5naVFzMURqWHVMVG9IWGV0WXErOEJyYnV5YzJ3Z3JwZEFK?=
 =?utf-8?B?Vk5nQnhkYy9hQ1kxOW8wNGQzc1NSZWZhUlV4cTcwM0FQMS9tQ0FpL2RjczZh?=
 =?utf-8?B?Rm5OMkhZSlZvaGxmOG1ycmd0TlZMMDZFWEk2TW9zK3JNUU9RdjZPbE1hR0cz?=
 =?utf-8?B?NmQ1RUh2akFoYnh4YTJQR3E5RVhpRFliQ1NVSUxFWFlUbE1GUmk0dDl3SkZQ?=
 =?utf-8?B?NnpJcFlFVTJBYWFYZml1cFNFVVZRNTh1by9iaEJ0SjEzNVZCWkpkemdRSTlj?=
 =?utf-8?B?R056OXM5YlMxdTVrNkpXNGR0dWc3QTdua1JyWTRTNlAvREhnTCtncUgwUTBK?=
 =?utf-8?B?NENTbW5seGxFRXdXZ3VaNnNDTmtraXpYb1h4L2UxODAvRVpoREpZWXBDSTRn?=
 =?utf-8?B?NGRMMnA1VzlPK1VsMURaRVhlMWZHSFAyQXh3UW5mTG1wK1llT0JaYlJ0b0VT?=
 =?utf-8?B?QjVKbFF4UnlDWjZUZlMyWE9VNlhSZVk4K1FFS1VPa3hJL0o3dXUzcUpaSDg3?=
 =?utf-8?B?QnF2NW8waXg2eXRYRXgyYWpQSkUwQnFFWjVOUE5ucWpUZDlFcTNNNFI0TzBs?=
 =?utf-8?B?dSt6UDAzODdvTWRqU05ENEpkaU55aC95SzI4SWQwaWR2clVpS3RaNlNOeG9s?=
 =?utf-8?B?S0hOOW9mNGNaQUNROU56QUlNUjd4S1djUGxUTVBiamI0amV3WjdZcHZqeHJ1?=
 =?utf-8?B?UDZ2Qjkwdm1ocGxHUjRienlpR1hBaWxFSUJsRVZmdHp5TUxpS3QxZnljSTF4?=
 =?utf-8?B?QWRBdUdQQjE0WUNNcVE3cHZhOVloQVJ2K0IzVkM4REpUTXhXcWdrbnVDM2xO?=
 =?utf-8?B?RWszaDB6ZDUyWklZSzVZNnphWExEcG9ySHcydHNWVjNyS2tvMVl4WVRBVG1v?=
 =?utf-8?B?Nm5JbllBd3VERDZVUWdDT2VMbXNFdHZYWEJJaGkyQ01mZk5saU5meVEwL2VM?=
 =?utf-8?B?blh3dis2Sy85OG1IbHZaVUV2L2tKa3p0TENScnNmZDVLaU5RaFg5LzMraFMr?=
 =?utf-8?B?azJOQ3NiaGliNWZoMndsakpyNEQwanpVbGV3U1lrc1pFb3VSdzdQNkdJNTZG?=
 =?utf-8?B?b2p3Qi9TUU53RlNscFdXN2lQeE11YUhlVVEvTm91SHNidm5GOVFmVStNQ3lu?=
 =?utf-8?B?dTZ0MmozM1MwK0UrSk95YzRPbWdESmpRUXFnMG5HbmZpU0w4L0hJOVJWMWdo?=
 =?utf-8?B?eTVVcDdmVGpKQ0UvNnNtMkJ6UDVIU2UrbFJHcWZET1VPYW53Ni8vTlB6Y1VS?=
 =?utf-8?B?b0pNVC93YU5QVHZhMmJFcXlrZjBYdjNKemVJN2l0azU5ZTBRSHpHQ3paN0Vh?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d900db-6a54-48f6-0ad1-08dbbe1e4b0b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:22:32.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJCxq+gXRaC6KBf79OyzG51lqZuqGW/40gQOExTEsRizoYZvCYdyQbeyIju9qp5Co+8OiWPYnTcX2W1CLErAsyLDtU3jF5Bh+/CQpFfrw5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8033
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

Hi Tony,

On 8/29/2023 4:44 PM, Tony Luck wrote:
> Legacy resctrl features operated on subsets of CPUs in the system with

What is a "legacy" resctrl feature? I am not aware of anything in resctrl
that distinguishes a feature as legacy. Could "resctrl resource" be more
appropriate to match the resctrl implementation? 

Please use "operate on" instead of "operated on".

> the defining attribute of each subset being an instance of a particular
> level of cache. E.g. all CPUs sharing an L3 cache would be part of the
> same domain.
> 
> In preparation for features that are scoped at the NUMA node level
> change the code from explicit references to "cache_level" to a more
> generic scope. At this point the only options for this scope are groups
> of CPUs that share an L2 cache or L3 cache.
> 
> No functional change.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h                   |  9 ++++++--
>  arch/x86/kernel/cpu/resctrl/core.c        | 27 ++++++++++++++++++-----
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 15 ++++++++++++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 15 ++++++++++++-
>  4 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8334eeacfec5..2db1244ae642 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -144,13 +144,18 @@ struct resctrl_membw {
>  struct rdt_parse_data;
>  struct resctrl_schema;
>  
> +enum resctrl_scope {
> +	RESCTRL_L3_CACHE,
> +	RESCTRL_L2_CACHE,
> +};

I'm curious why L3 appears before L2? This is not a big deal but
I think the additional indirection that this introduces is
not necessary. As you had in an earlier version this could be
RESCTRL_L2_CACHE = 2 and then the value can just be used directly
(after ensuring it is used in a valid context).

> +
>  /**
>   * struct rdt_resource - attributes of a resctrl resource
>   * @rid:		The index of the resource
>   * @alloc_capable:	Is allocation available on this machine
>   * @mon_capable:	Is monitor feature available on this machine
>   * @num_rmid:		Number of RMIDs available
> - * @cache_level:	Which cache level defines scope of this resource
> + * @scope:		Scope of this resource
>   * @cache:		Cache allocation related data
>   * @membw:		If the component has bandwidth controls, their properties.
>   * @domains:		All domains for this resource
> @@ -168,7 +173,7 @@ struct rdt_resource {
>  	bool			alloc_capable;
>  	bool			mon_capable;
>  	int			num_rmid;
> -	int			cache_level;
> +	enum resctrl_scope	scope;
>  	struct resctrl_cache	cache;
>  	struct resctrl_membw	membw;
>  	struct list_head	domains;
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 030d3b409768..0d3bae523ecb 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -65,7 +65,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L3,
>  			.name			= "L3",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_L3),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -79,7 +79,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L2,
>  			.name			= "L2",
> -			.cache_level		= 2,
> +			.scope			= RESCTRL_L2_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_L2),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -93,7 +93,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_MBA,
>  			.name			= "MB",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_MBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
> @@ -105,7 +105,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_SMBA,
>  			.name			= "SMBA",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_SMBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
> @@ -487,6 +487,21 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>  	return 0;
>  }
>  
> +static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
> +{
> +	switch (scope) {
> +	case RESCTRL_L3_CACHE:
> +		return get_cpu_cacheinfo_id(cpu, 3);
> +	case RESCTRL_L2_CACHE:
> +		return get_cpu_cacheinfo_id(cpu, 2);
> +	default:
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
> +
> +	return -1;
> +}

Looking ahead at the next patch some members of rdt_resources_all[]
are left with a default "0" initialization of mon_scope that is a
valid scope of RESCTRL_L3_CACHE in this implementation that would
not be caught with defensive code like above. For the above to catch
a case like this I think that there should be some default
initialization - but if you do move to something like you
had in v3 then this may not be necessary. If the L2 scope is 2,
L3 scope is 3, node scope is 4, then no initialization will be zero
and the above default can more accurately catch failure cases.

> +
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -502,7 +517,7 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>   */
>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	int id = get_domain_id_from_scope(cpu, r->scope);
>  	struct list_head *add_pos = NULL;
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
> @@ -552,7 +567,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  
>  static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	int id = get_domain_id_from_scope(cpu, r->scope);
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 458cb7419502..e79324676f57 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -279,6 +279,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>  static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  {
>  	struct cpu_cacheinfo *ci;
> +	int cache_level;
>  	int ret;
>  	int i;
>  
> @@ -296,8 +297,20 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  
>  	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
>  
> +	switch (plr->s->res->scope) {
> +	case RESCTRL_L3_CACHE:
> +		cache_level = 3;
> +		break;
> +	case RESCTRL_L2_CACHE:
> +		cache_level = 2;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return -ENODEV;
> +	}

I think this can be simplified without the indirection - a simplified
WARN can just test for valid values of plr->s->res->scope directly
(exit on failure) and then it can be used directly in the code below
when the enum value corresponds to a cache level.

> +
>  	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == plr->s->res->cache_level) {
> +		if (ci->info_list[i].level == cache_level) {
>  			plr->line_size = ci->info_list[i].coherency_line_size;
>  			return 0;
>  		}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 725344048f85..f510414bf6ce 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1343,12 +1343,25 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  {
>  	struct cpu_cacheinfo *ci;
>  	unsigned int size = 0;
> +	int cache_level;
>  	int num_b, i;
>  
> +	switch (r->scope) {
> +	case RESCTRL_L3_CACHE:
> +		cache_level = 3;
> +		break;
> +	case RESCTRL_L2_CACHE:
> +		cache_level = 2;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return size;
> +	}
> +

Same here.

>  	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
>  	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
>  	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == r->cache_level) {
> +		if (ci->info_list[i].level == cache_level) {
>  			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
>  			break;
>  		}


Reinette
