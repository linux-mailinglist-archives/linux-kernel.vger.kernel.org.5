Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC578E015
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjH3TGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242497AbjH3Iy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:54:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99EACC9;
        Wed, 30 Aug 2023 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693385662; x=1724921662;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Wg5Gxrl5wr58VmwBTR2/OFLyUCtlWaMu+gHod2nqnuk=;
  b=Uz7AnVBuvj4UeSpC9hjK+MgDs15QJxK3H56a1aSC9za1k0B/lxo8X6Qc
   yCf8tKQTfJKCQMAm68VIIJTsnSLBEG3qo707aRhqTLDYhAn5AuBGY8IXM
   r4l8t/1PtWKEXZ3zQblRtF+IjuN5GOsAG+ibo/yXE0mhHxgJabpILRiwb
   JqeuaWX+jYh/Mul/qBvbkUytq9594sqp2Jbc7gS5oM/x2NGNEi9Aq8nof
   jJoJ8Oe28lYbPXTv0Lq/Kn77vmbIyfwFY39S+eE+eIwgn10QbHevVgixK
   9k/ImAr1w+H3UAFetpRL+rhtZme4tvIZH7Z+U8gNZOYZk3mDEZ6QTH4kC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="441949612"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="441949612"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:54:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="985667442"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="985667442"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2023 01:54:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 01:54:18 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 01:54:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 01:54:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 01:54:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fgqh9EOdwzS/gtrsaSQVMpJcnVrqPaBb/xLh6SGW++goY8/cLArp22XryAFGLf/EurCli2WmW1/NglLHSTDvc3VK+Vg+tUGxroczyvOyJZ21cKEHpM/7NSYp0nx2zR+qz9+GyQyjMQpQMvix+OLMZHWbZz0EekVA3J1vwTxPJlA6ZZ0J6YWp3DcJK49eBayD7qLA2zNQ8gWjJsJKa2a1Gi0Ue4wdelBEk4J1TBDzPlgQa5L2sLBlx3jf37LQXS0avanz9eQEmRU3HU/ZnxvubH1K2ex/QSwU/hW7bcG+NNLy2/gnZYs2iA3TpafG5g39gcO5Uz6bhipA3hma77g8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh+YfU81QgYXHePp1lKAEGjsKJ5h/R9YcpHwwYyFQMM=;
 b=cJg8ywjMGfuxl58klE68RlC8hsCrWh80Mp1UR3TxMP1L34cBL0skn6M58bUDUIaLMJLvqgoQDuqyWBgSxykqooHWxfkvYRhDbH40V0I1oRunrXetWcTwsYaYgyX9QPuNrgOGKpFjC6pjGZAnKYT7OB5fTRCheLCd2dxkJiu1kARfAXcpLDh8yFpnOr1Qa8D2t5IExFkq5ebXIF+7jSlKmWAChVUQOUg2oC0Bd0naOmENXWwSwSnc0T4km57mGwaHaP/jURETiN7eyRO5dbH70k3C2xBkePCCm0Kb1ES0Cdzl78iyc2s9MZ19jgMrayxznWxmU1yneeOB8HAHgbC5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DM6PR11MB4513.namprd11.prod.outlook.com (2603:10b6:5:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 08:54:11 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 08:54:10 +0000
Date:   Wed, 30 Aug 2023 10:53:58 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
Message-ID: <bssbtlnjbytqoraiamg7igvawtmlnimzthud5mlacbmjotivhj@hrrabdpmkbjx>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-2-tony.luck@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829234426.64421-2-tony.luck@intel.com>
X-ClientProxiedBy: BE1P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::12) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DM6PR11MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: c8bc0731-7c52-414f-5d98-08dba936acf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gvNCmjBfKxVF5u7kxbhKVvbPwtJSzz2vEyLWaqajAyWMH2uRiDTAZQ8j2yUepGITPX0fiMwwZ2O0X5gNujeEXqGY37P8CmDOW+Qf/Nm8mBfOtrjx5vcb3JmB4K5Oq6FkvXjuJot9eVrqimxPfWFzum4mlYYeZvuIdcFIs5zq+t044+9xZypP5p06cYPRN9HxIXr7JrnoRgSCX+W+XcsLJ1WKuQ6Vo/7SV8cgjBU4IsjJJ+UQixJb3E9x2gcBv0IASaFscICO3HjWnA77HYXuZNI6yeRXfrFK/3eKcAwemBqI5uBYfcbh4Kzq2Ix6fIckj2TvCyNJ+IbLPJJ7+pzVuk7Vl2g/yuXGOArfJgvau0X/y8eq2niHzF151JfZrlJ3vlOm/ESO7SmpwYRW206D405Z41goR127QJD/m5M6+mo/FTMyh3HPC90/8DVNhtd8FdByhOxhJxVUOeZhGIvzMIW7PPSz5uvYhaYSfHS1uluCJ2GkE0h+uoumXO7+/tB90GQp+QvfytJc3Sa7OMmpZBi5sGRMTjNVGzYKjd78TgxYFWHRetPm2StdqbNnKDB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(39860400002)(396003)(346002)(1800799009)(451199024)(186009)(6512007)(9686003)(8936002)(86362001)(478600001)(33716001)(66476007)(53546011)(6486002)(54906003)(316002)(6636002)(6506007)(41300700001)(66946007)(66556008)(6666004)(5660300002)(4326008)(8676002)(6862004)(26005)(4744005)(82960400001)(2906002)(38100700002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0grj6J9ZqdyFUACjgDOdxrp/IROAdwWQqXY2CKX8091lOFgDtkE6EFjiLO?=
 =?iso-8859-1?Q?jpSalQKzfzqd51ScFAVsr8eIiGRUePn341EWAMCdIz08ZKtGUZQUYm6GAt?=
 =?iso-8859-1?Q?CN+jIcy75EbGUaQF+prLDU1wlgbuqkbHpwEOXqHsNZUYIoLlvnJCLDPSF2?=
 =?iso-8859-1?Q?XmKNxxW3RnLGDWLHCypP1Y5i3yPxjd4ypWcn1m2pF/YWr8WpBFLJFCb94N?=
 =?iso-8859-1?Q?iQrzDKapJ6PrDE8yIAmbsK7UT+onFyg8gI3kUqeuexQamQhR7Z5eubWFHW?=
 =?iso-8859-1?Q?RUv74Rzl3ldZjjvXbtFH36eegGoBl8zsJe9kDBFWV6/W+YiKNTWnJB09kM?=
 =?iso-8859-1?Q?zfYLHbBbun/p00RRDcwvTajYEb950PXAEXyu9CSGQo8iCrxbRF/aoxxHPN?=
 =?iso-8859-1?Q?vE+z/2YGN1NBq5joE8n0EXPA/VzOMLYrULf/rRabvHZVgFA5Wf6iby5lwD?=
 =?iso-8859-1?Q?4sxwJTbc7jFM8Y3p2+4YtqoFvv7KXInND8QpGn/LR0rxxfSqLiqmAxCQkh?=
 =?iso-8859-1?Q?CvZM1zi7xPVl3QqWwUxDLj8M5qN2ElvFQmnS57L8TotMvJEq3ZlKzRmMSN?=
 =?iso-8859-1?Q?7coYa9P3GhAvu4yELXCecH3T2NuU0xud7xKyW1zDtEPuphGpl8TRsZaWNG?=
 =?iso-8859-1?Q?qcBBh8sTk6Qiyvrct61eUXHc8CWj63IIxDDrvuu1RzcsV5OX1CQVOFOWqe?=
 =?iso-8859-1?Q?9Uw7vijz2I6HzXSFxpqOohXhJ+RhL5VF1XPjlh/LDNqJQV+5HjYg4+Ikf/?=
 =?iso-8859-1?Q?sqCWfwwZuXCc5gMHByU61sQiXdrA26bISLKQ6KMkHVIBUAdDD2npluqwE6?=
 =?iso-8859-1?Q?4TQBz3EvfkMgD+KX13BhlWbYavQKYieoksorzYKNU6h3IfZkCHIUFs3+sm?=
 =?iso-8859-1?Q?O5HsUtOtilAamcJDXtiuP11zNBmxahUnZGOAMHX1mIBhkvS6bZ/bvRcGs4?=
 =?iso-8859-1?Q?nAMGmUZ6S81vw52hS3za4Nmr+/ypmkpLteTZvZIvxSx+pPJI8JJJJIlZeu?=
 =?iso-8859-1?Q?RiG2EUVh+ZSnNxWH9Vkvan56GSWYCXPUBIGdAMvZs2p4h5uJQDcEGG0e+u?=
 =?iso-8859-1?Q?LiADzeFsVYK/b265b8tUE/JxrBotj+73zOyynLnoZzaTh1imf4Z/E1aRNT?=
 =?iso-8859-1?Q?74mN2mcrWhVYDfJVWkKcMECgVNY1A3H7RE91Bsc0gL6pvwfs/xOOLjslBo?=
 =?iso-8859-1?Q?xT0Lpdx1k7Es4zxWX6CueJ+Z8qVLw+kCEYJLp5GehEz0xBe2j/H4poGOLZ?=
 =?iso-8859-1?Q?qv1YRWZ74kyKvF1dwuUs/K7+/VaAc4x5YFHem3vd5PGVyl9x1SW5NMGO0H?=
 =?iso-8859-1?Q?ecbsw9OyCHi4P0/QnOyxW5wADBSEZvt+NDJ0T5KdZUAWST5baSe+ktptBv?=
 =?iso-8859-1?Q?F8uQbgKHCMTzG2WgbLFWOsOu/RLEzT5ybLNyCIDSGoim47PIkjIT0g0iyK?=
 =?iso-8859-1?Q?ctrTen4RDxIY8R0xRAsphNYEX/v9gTgMLmp7L0/2B0DvTG0VmkKNRv9Vhb?=
 =?iso-8859-1?Q?/PRBYgk4Ue7jcoSV11H7xVWkPoOHY/+6F1eiSGzSCO9oVMxAqWQ0qBEBkd?=
 =?iso-8859-1?Q?j9GjxfHdSMz7vSvOrfbOmn62/cojtP4dJodWBvIAyatjswjrfMXcslJyB2?=
 =?iso-8859-1?Q?2XvgBxitZyBorknYO9JSivVjCxOFdTs1r6o6PYGIX67oM/GmKZ0VCOHh6s?=
 =?iso-8859-1?Q?TMZ6jr3DMZEQtwEF40k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bc0731-7c52-414f-5d98-08dba936acf5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 08:54:10.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJuf/N7jf4Jdqvxz9jvh7SOVCeNaL+Qhx9W1wYJosCLAQTOlVpz/k8zsYjOGOPKf/X8zPqnDcYaMiq0FkAJHruyN35C6kNvfMrwIOjgdMgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023-08-29 at 16:44:19 -0700, Tony Luck wrote:
>diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>index 030d3b409768..0d3bae523ecb 100644
>--- a/arch/x86/kernel/cpu/resctrl/core.c
>+++ b/arch/x86/kernel/cpu/resctrl/core.c
>@@ -487,6 +487,21 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
> 	return 0;
> }
> 
>+static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>+{
>+	switch (scope) {
>+	case RESCTRL_L3_CACHE:
>+		return get_cpu_cacheinfo_id(cpu, 3);
>+	case RESCTRL_L2_CACHE:
>+		return get_cpu_cacheinfo_id(cpu, 2);
>+	default:
>+		WARN_ON_ONCE(1);
>+		break;
>+	}
>+
>+	return -1;
>+}

Is there some reason the "return -1" is outside of the default switch
case?

Other switch statements in this patch do have returns inside the default
case, is this one different in some way?

-- 
Kind regards
Maciej Wieczór-Retman
