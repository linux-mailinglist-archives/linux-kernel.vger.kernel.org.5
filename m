Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD0780F5E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376921AbjLLS7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376733AbjLLS7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:59:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5655E3;
        Tue, 12 Dec 2023 10:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702407590; x=1733943590;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jrdEfY3uuF6vSkgFVGrf+EwPdmEDdPA8toTdtfBMpWw=;
  b=VVo8MZQ086bZ9+DQst/d7DiWjoz90R6dXqnlejSSt6fS4ibqNJMUL/B9
   9qhNCVrk0nXzCq3DhBcO4Rn/4E46mA2d72/qrvcbBhn4y7T6t0UGtlIJI
   9CH9/nQR2GYlNSqQoM0beMjU0SdyHHxuATn+rwI6hin4yt3EST2qVExIt
   mXPoOWJdSUzQCMZ25EbcWgz7/IIjc0h+5DmsMK4lHOMqtUSnEYjbbgYZ3
   2zaDfwWZSnmJsEop4iZaxgDNAQW0+8zSJBs0/HZnO+KICUIdlzA9XDIVf
   wUd5v2pRWOPc6rOK3YqBInX8fccEkvO7gAnHRhLKa5HDZw1prMqi9prp2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="16407162"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="16407162"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 10:59:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="807873953"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="807873953"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 10:59:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 10:59:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 10:59:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 10:59:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 10:59:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhzyuECKuyslLMW3gjLBSFinzFkcoVbi03z6cisSseKyL03/cTe1KHaqt99iCLMRkTrqvNAwRghGE9rVpeTnQ5BuUmcvE5ZukAOKrYQtzYG781LUKTy0JMJo/1Oq2kLgqLeq5HIplXEb/w8UNBpcc6s8ZJK8qWcgh1UgUcT/01ujx+9rKHFiB/vbB2hXs0NRIopeD37Q+YuIGrXmfPcQ7hZEgnGFOMhx0KGBBu/FZI5dunXmv8PRfrVlKoxcwJz243pvN5XbOiNeJ/JFizsXUYQNn3h+GJ3VBSKoNok02qdyTi1POhlFVXP6gCi4ukZPpvp44uK+o/ThGijTP5cIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X//zcljmCoACtN2dJweF3WLZGHHm9Eu6B/U81fqpg3k=;
 b=Zciue/OtRg0h/VALfU0kumCYSHax7qvsxq/6v9pNJynycaG8UGk4ZTXyBFrKVk7a6HSquJdb5V6an/C/TlN8mCU/24DhzgDMZVBofwlJoMfBPFmY1QrR+51DEydS3sk4fZbXriXhv6oTbjibhiNLs40hq+urA/3i8KkyOhVoV54qm+2GiJnETJQ6n+oDzjthlPw0qXvciC/vKixdnDTxsVT98QZkgjllWswfOnZVPFNBGmJ/1ysFWr6XxCpMbP63trmxKy9Z1gYag2kddyx3J9VN7fgqJFa6XhKPDH1rLHJTcUmEj55XYEHdlOOvT+wuoN+XyV2kgEgjMJmPmvUQjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 18:59:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Tue, 12 Dec 2023
 18:59:44 +0000
Message-ID: <8f09a4bb-5310-4d49-ba50-cb945f94319c@intel.com>
Date:   Tue, 12 Dec 2023 10:59:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] x86/resctrl: Add new "mba_MBps_event" mount option
 to documentation
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
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20231207195613.153980-1-tony.luck@intel.com>
 <20231207195613.153980-4-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231207195613.153980-4-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:303:6a::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV2PR11MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 5636f26a-e2a3-4983-07a6-08dbfb4480d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVE+zQZnjVWMQdDrY0kZ5MfbumeLd6eDYWpnsz7eMaTOZpVwxQTjMqnUD1TxV/kB92ZiVwKdaTYq/7psNAuDWfCOPNgmq3/5ABUO/3JraPni5wbu54CNxM/sK30F3D+B3cGCgvbGrVn2DJDsbDh3Rb72YWatS7SxJbNwsgnz8MLiYqx9Kmq5gx42GECoWq0EqCzLHqaR7hnWOqF5P3zKr2rU4SplWdCEP8O/5XxoKGctmKMmYneykhccY3kQJVvEdzjoDZW6274r47QoVT41CamX4qG3xgs68dsUoZaWwZlQu2NOiO+qGSk4mZKEqvRzFmMQVaViTESSx7++9ZywDQpCjHaawXr13XcgQQo4QqF8T92U0CnLk6V+JlVSRcG2QQ6o3AKR55JwcmHKb8iUNqv4t/XU2WoNyJL6jNMja3BM7PoGbbRsqaXMadjb4CZOWAiMkX82BqNCNQq1kg50RhVZLKIp9v+WD58sRFr8oaK47bDa+qJBkQQIPmB95IJm3tTqtGGh7NDPhG8X0crAF+vgwkjq1Jb+eslfellmCbssy5Hz2mg/nQn8dLO5DFVIWV2p9g/9HPrmJfbCPUhU01XgbZWZuQRiYhI3AfaJxQKvpPfFix6w8r2OIlmcuVFeiuvhdwCMIUuXSl6LOgZhlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8936002)(8676002)(2906002)(31686004)(4326008)(44832011)(316002)(7416002)(5660300002)(66476007)(110136005)(66556008)(66946007)(54906003)(478600001)(6486002)(26005)(36756003)(6506007)(6512007)(53546011)(41300700001)(2616005)(82960400001)(83380400001)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXV6U3ZaR2hwc0JySnhPdGxMOU5pR0dWQmFOQndKM1NIdEtpeVd1dUpGdDgy?=
 =?utf-8?B?UFlRL2lBejRFampPa3FwVWxPaGpZLzBSV0ZjRDkvQno4WERHck5PSVphV3dn?=
 =?utf-8?B?SUd0NmtrS2Njek9PYVpVcEFnVHppTlJ4YldvSHhoTGdiRWIxUjZjOVlwb01q?=
 =?utf-8?B?OFN4K2VwMEozZjVzOVZsSnJMRVI1a3g4Um9vMUJvbUpVcTN0Mzc0RzFYQmNw?=
 =?utf-8?B?NWNZZ0dxZmNvMktNL3Y0RGxnMm5seU5obUI0ZVBFdE1xd2NmdDV2YWhwMU1y?=
 =?utf-8?B?cHRmOFdIUjBXSXpnTjdESlR0b0dSWWQwZmRXWVoxRGtreGQ5T0dBL1FKM2JW?=
 =?utf-8?B?L2h1ZEF2dFhyczlhNnUwZ3E2ZVlIeWYwaURWSjZPYzBDQVc5b2xDaWlISmFx?=
 =?utf-8?B?NmppZHBSZ2t3ZFNZT1lIdzRORFYxbmxvaG1DRlRhNzh4aWtucFZWZUNZVHFs?=
 =?utf-8?B?c0tNb0JnbTQ0bUNHbzUyK1hwSDZ6b2FvaEh1d2F0ZWJRKzNHOENkM1VENXlN?=
 =?utf-8?B?R0VOVGtublN0TkhJZ3NaME1hSFBuNlpQcXAxamgwaThUelZLc2F2Z3F2TzFy?=
 =?utf-8?B?MFFrK1lxY1grWmtlRTZQdW5UMXNrdmZFZWRERmIwOVoyTnJ5OVVUQmdWaXdJ?=
 =?utf-8?B?cUVHZWYxQ0VxUTEwUUJ6VmZlWVE2ald6VnhWZkdody9ZUXR6c3lldXhQT2Rr?=
 =?utf-8?B?T3ZTMjdpejlRQnZtc2xFdDhZSDEybmkvYUZRL1lNcndCM2NVbzJXSUZLbzFo?=
 =?utf-8?B?VXVnMEhKVjZoeDVJb3dKWmRKd29qaitOMk9UcWNFMzFORGtDckdHR2dHRlZK?=
 =?utf-8?B?d3NvZlJMVHJYSTBhU3Y1TlVZZE4rcC9YWnhzclhhbmM5YmlTQUpKMU1oK1hy?=
 =?utf-8?B?em96aXlvNHc5bWpUajJtQ3J0djRHaDJ3WEEvR0E4TG5VOEhpSExTLzFNUVNr?=
 =?utf-8?B?dGg3NkIrVXd5UkVtekxPS3h2NjlsZ2ROUlIxNFNZR1ZZREwySXphNktxSVFn?=
 =?utf-8?B?RUJsUHBJS2t5azNkVFd0QTF5QXczd3dYcmZXTW54UlpZb0pOTDRMdDVRNlhw?=
 =?utf-8?B?dFAyTWgyMlV0Z2N6R2c2TjBaQ2ZSVmU5bWQ0bk4rd3RLTDQ0VHhoVElGZVh3?=
 =?utf-8?B?TU5TbVFwMVJXdnBYbmRVdlp4MWI1MXNyYlU2WlRvbDNyTDViMmloTmVodnd5?=
 =?utf-8?B?YUs4alFnT0VyN1VHK3NHallLZ01hSFJIWjdsbmhod2Y2a1RHaVVKWWlOek9Y?=
 =?utf-8?B?VUFWTHBETVAvUzdnVlVtYzF2dy9IVU5nRzlhS1doZVlBN2lJWXVUOWJLMC9r?=
 =?utf-8?B?QStUa2htcnVScHlrYWQ3SEtuMjhQbTJTTk1RQlFyWHUyYTlQOTljTG1LeEhR?=
 =?utf-8?B?Qy9kVHBaNnlLUnc0eWhXdy8zSWVSV09raldWeGtiSEM5b3VVbTRtaHF3R211?=
 =?utf-8?B?dE1YNERWNGlKU2VndlBBWFFheFVNc3FzSS9zWTBsdEJlR0hJZHM5OGJHNlFV?=
 =?utf-8?B?QkFqR0Z6MW9mV3p6MEZ0ZGh2TzR2YlRzU2xiWmpsRnJodVdQdGNacWhKeHRV?=
 =?utf-8?B?cjNVRy9aUlhmTzVodXVUTWJwek9LbXF5Ym85YWNpUC9XeC9DN2FXQTFYNG5a?=
 =?utf-8?B?ZStBZHFLaXZlZTJlc2UvK0tIQ1llRWlHWThGVENyTkgwZzVZdTdkeEpRZUs3?=
 =?utf-8?B?ZUhBQUNxT0JOWWxON0o5aW5NcHdpY1RLdmIyQUNXOHgwRTJsbXJ3czI5Tm1t?=
 =?utf-8?B?Qy9iYWRUelVVN2JaZi9MRFNrelN3L0tGZVZtSnhtbTNZLzdBZHJqaVJLbjd4?=
 =?utf-8?B?OEdrMlQvNWVlU1lGb3Fac3A2SHdwcjZtUVNtd3NOTmFwQWMwdjR3aWhTakt5?=
 =?utf-8?B?V0x4cHFTM3JOY3pPd0lwTFl5b0NWakJHZUlwQ3JVbjVyRUNoNk1wdDNPTSs3?=
 =?utf-8?B?NVljRlFyTkZ1RDVJK0c5U01VRTljZi9Yd2tNM0J3SWdEUkFtcFA4OU1YNFl4?=
 =?utf-8?B?bjFGRnBaVzdvMnp0TWh3SEE4Mko3bGljUHZYK1h4blgzbHNCelNub0FWNjJT?=
 =?utf-8?B?UUJ1L0pMVXBvM1p0bGNZWmlYaUVJUWNPNG5obGMrcUkwUitzd1RQdDJQbndt?=
 =?utf-8?B?N25SNEoweG56Sk03M2RUSVNzTzYvSUpHL1p3dWVzekxmUHAxUCt4bmZmYTVv?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5636f26a-e2a3-4983-07a6-08dbfb4480d5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 18:59:44.2079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50dXs/EZijw6osc0c8jxF9pKDUFZLbxYXowBwq2GuVpqXRgc3bH5k27EjSQ5ADTPgFsxS6qbFrSX9QFDaRHRLegAmeYBkOADohKZ/k6WI/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 12/7/2023 11:56 AM, Tony Luck wrote:
> New mount option may be used to choose a specific memory bandwidth
> monitoring event to feed the MBA Software Controller(mba_sc) feedback
> loop.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/arch/x86/resctrl.rst | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index a6279df64a9d..a0c521db6786 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -35,7 +35,8 @@ about the feature from resctrl's info directory.
>  
>  To use the feature mount the file system::
>  
> - # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps][,debug]] /sys/fs/resctrl
> + # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps] \
> + [,mba_MBps_event=[mbm_local_bytes|mbm_total_bytes]][,debug]] /sys/fs/resctrl
>  
>  mount options are:
>  
> @@ -45,7 +46,12 @@ mount options are:
>  	Enable code/data prioritization in L2 cache allocations.
>  "mba_MBps":
>  	Enable the MBA Software Controller(mba_sc) to specify MBA
> -	bandwidth in MBps
> +	bandwidth in MBps. Defaults to using MBM local bandwidth,
> +	but will use total bandwidth on systems that do not support
> +	local bandwidth monitoring.

This document is intended as user documentation. With this perspective
I find the above change to have potential for confusion. The first
(original) sentence is clearly aimed at the user, informing that when this
option is enabled bandwidth allocation can be specified in MBps. The
second sentence jumps into kernel internals mentioning bandwidth monitoring
(user may wonder - what does this have to do with allocation?) without any
transition or context.

> +"mba_MBps_event=[mbm_local_bytes|mbm_total_bytes]":
> +	Enable the MBA Software Controller(mba_sc) with a specific
> +	MBM event as input to the feedback loop.

I think it should be made obvious what the relationship between the
mba_MBps and mba_MBps_event mount options are. As it is written the
user may believe that both options are needed. The user is also
left needing to interpret cryptic information regarding kernel internals
- for example, note how "feedback loop" does not occur in this document. 

>  "debug":
>  	Make debug files accessible. Available debug files are annotated with
>  	"Available only with debug option".
> @@ -538,6 +544,12 @@ where as user can switch to the "MBA software controller" mode using
>  a mount option 'mba_MBps'. The schemata format is specified in the below
>  sections.
>  
> +By default the software feedback mechanism uses measurement of local
> +memory bandwidth to make adjustments to throttling levels. If a system
> +is running applications with poor NUMA locality users may want to use
> +the "mba_MBps_event=mbm_total_bytes" mount option which will use total
> +memory bandwidth measurements instead of local.

The paragraph is just appended to existing MBps documentation instead of
integrated with existing content. User is left to parse and connect the
different sections attempting to make sense of it all.

Reinette
