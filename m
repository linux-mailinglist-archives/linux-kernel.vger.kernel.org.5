Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD827E3243
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjKGAdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjKGAdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:33:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2FED7D;
        Mon,  6 Nov 2023 16:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699317184; x=1730853184;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BPwtme53baVQJ3mfFnetNlKYM4bJ1OJVwKlHl/ZLG0A=;
  b=AH8EtYrAjixpUWidqdeq+FVlw0oyQelf34ZL7wG3669YlF4/IMxYH73z
   Ftfh4aWMZNRbmH0ViBAHHNXuJaVE4t6uvEe4qDYoHeE2nHtgVww12jYFS
   +Udm2qz4r9LVaEwhPS1tYqaXDzuNY1xi0E0V7+leuaxvhvLpYR4Bp1Qav
   hT6IkEvJhlegyM85/pzppiT1nBTvK3EIWj4i81feUvRJM4quX84Mx5ZA0
   qhVZaRsuibpBMEKg4HfoHptIUttbua4WzXoORtaVosTGgyMhpMh8hL9iJ
   fcsW3PU+RYDpZ4vOu8O+hr5ECDBnVWLsEFpStqwSsMsqAM2L48j3L5rgn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="420507743"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="420507743"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:33:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="756010017"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="756010017"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 16:33:01 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 16:33:00 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 16:33:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 16:33:00 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 16:32:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmI3ml3KV6z84ZBAhoZquiKrkLhS9D+XnxalPWiJh46uFdvsjSks86K44Om02ODWPSIndjSlP/vxqu/luEVNyY8ZtdURc6zACJg1pDlaVRIs6EPl3LcIbEL/3kRzVVGIulZMFLadQHFe7KdnwNEJWWIA/DEE3RRUjc5c3l4IWllMRZn3JoDiao/pqMVnldrV3Sw8Vr8juFukcH8W8EzxjcSAi9cEXpVqXO3iSQynul384v4MKFqlydTCDRe9ul75PNB8L2Gvyvj11fVYfRpUypKCrrMkTDB+/prMIbEBudKJSmrrzB4foLyKuteIM25mk3P0aKw9E7Mt78RSbSM/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/ufMzw6BfcR4FfIKZZzdxn8Mu/S0q/rparoAztGUPQ=;
 b=ob5zYjYnkrTmPI+kAS0odGpFxiqbUNQGoqZLg+Mk1CW1TEVF10ivjM+iwwSs80jQ/EVEvfOs/VQwgwphs2C6h22Zfqd9MD4FGxatV2lSmfSPUzqJhnAFL4TYjUqy9n/Xe/DOsdvZU+nvHSdf7FGQJxYCWa0pX7D3m0Kh8h3Pu5My9FNGIf3/EUqkQgPFgdRNtZ9U1fWLW0zA8W5auanI9rpLPqQKdf2zmLyT7pBnNWBbny8o2+evDLcxUiRrs0hbfvvWNI/iIZtRUrupi4fSOM8YmvuOMgMhWfrChtSmvPRieIttcy1foURmFnk26J/IkSlKBsKU/Ns9ip98CHttmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7614.namprd11.prod.outlook.com (2603:10b6:510:28f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 00:32:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 00:32:57 +0000
Message-ID: <51332bf8-d641-4a89-bcec-60b849fc6a34@intel.com>
Date:   Mon, 6 Nov 2023 16:32:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/8] x86/resctrl: Split the rdt_domain and
 rdt_hw_domain structures
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
References: <20231020213100.123598-1-tony.luck@intel.com>
 <20231031211708.37390-1-tony.luck@intel.com>
 <20231031211708.37390-5-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231031211708.37390-5-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b8cf89-63ce-4681-884f-08dbdf291700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z924+IRefsVQcHBqel5Ew7sw7BFQjLw+bcpkT63ZoxEfpzIqPwYI+4kJtQCaC0tPgZdLKGQKFQ9xQdEj6kdaHWk8pGbRRDVvu0B5uvIN1OWF0Tr1FwP7WN3tUoNDg4xFC2VTfh8Z9ikIhWWxpd7EDtzu+FaOYMlU+NrAzSoMKu/9mvh7fWNv/Ug37IqA2F44j6FEDvG5euENixQsEQez3wecl0KqTiCUTC21MHS7pmG8b96Xly1W6AupkfwJHQmxkZ9M2h/0pKNFafMZ5dboyQR8Ap6cbb2XX8kXAzsmf+yt7j8l2bEDTJBGe1/bfqAFczvkYRo1iW/mnXw1N+K7R5dcNI+9w3Kj7aibnWrq0dNV1M7Yaz+lpxGlSmQoFCq1Jg1atlLzsSLAiyK9Op9H0/ihjwZaxbg733zJaIORcokiR5Rwoh0inoCxj+QWLn2Ll8DVlK4qzibQknnU+Sa9AEC3fnrxdA3uVl90Gke38lSezW7/XeO7urV9S3PU/g1+e7oN7PgTBvq586VQvCFNcA3RhQyYQtU28fMfe2jVH4GZxMK2jV4GTJRwLpvh/8a2Sq2kYNPuCTecdpzb1G6Ih00UwhLLOiGGx1Yxd3BVMytUB4arvjINQPgGK+G/evTI6c6VbjTtEjEtdMX1HIqitw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6512007)(6506007)(6486002)(478600001)(2616005)(53546011)(2906002)(41300700001)(38100700002)(36756003)(86362001)(82960400001)(31696002)(5660300002)(54906003)(66556008)(66476007)(83380400001)(66946007)(26005)(7416002)(8936002)(44832011)(110136005)(8676002)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRIR0pxR0hJWDN0NUlncFVDcU9uSk5zUlQ4NkxqUEtXRHMybmkrS1loUzN2?=
 =?utf-8?B?MjRYNy9KR3BkRHM3c3NqTVdYN3dycVR1Z1dPN3QybXZkbFRXNWdCUjJPenR5?=
 =?utf-8?B?NnJyT0xNdzNGb0ZzWWlCUUl6QjJpL1NjMzRKVTduK3BKdWErN2loUzdmdnpF?=
 =?utf-8?B?aEVtU1ZHSUlVaElaU082RjRzaGh2aFVlUlgzNFh1RS9jTko2MlBORkZRQnZu?=
 =?utf-8?B?WVVneTRzMFRoR1ZEWGVhNk5nTDArelN6TUcrVW1lSGxjTVRLZUtkWTlxQmpJ?=
 =?utf-8?B?WjAzTDZ6Z0RIQmxVNGJVNldxQXpZcis1bnh3TE8vK21qb1RGL0JGMmRhSzl2?=
 =?utf-8?B?cFV6VFlIeWg4MXpnMlVZVU9lUm9nYkhNZWl4RHd6V0hkY0tqTGIwaGY4SlZh?=
 =?utf-8?B?WmF5NVhlUVZyWWViUHJvZDlxUTUvdGh2N3lXZTNoRjhSa05mZ05oTTRIZDFS?=
 =?utf-8?B?c29VTGRZQk9aUWJGSmpVMVpMd29yQUxlZjA0UkJWa25HWG1ERk5RUTZMczQ1?=
 =?utf-8?B?UThFQVU5bEVTOHB1SVRQMks0UHFEMGNmV3Ixd2p4blVBNjJkZ3Erbmtuczhn?=
 =?utf-8?B?eVRER2liNitvN2NqYkN6MlB2TnRFSGdFRmhaVWJ4YWwyRlpSUmdCR2pyblF1?=
 =?utf-8?B?L2VOeHY1S3lZUUFJaEVpaXRDM2ZWSnhlbE1McG42KzFBSkIzUmJEL1Z3OHZI?=
 =?utf-8?B?cVVSNS9SczJFaUZ2d1lpZFNSMjNUNmdySURRcWg3OURFWFhJWWIySlI4VUFh?=
 =?utf-8?B?V20vMVZ5c3VpV0g3SUVlZGZBRGJraGp1V25VeUswOU8zL0NmbW52THNRU0NC?=
 =?utf-8?B?UVNvUk9TY1Z6U1drMkQ2c3hQU2lhbGdUbEloRzRpSkpEUWxkRWRlVFY3UWNQ?=
 =?utf-8?B?emdPVzJJY1hIaWFXdEJxamdCU2R1RGZpajdpQ1ExcDRRUVVEbSt6a0Z1MXpK?=
 =?utf-8?B?dnZHbDY0SFYrb0V2bTduUDFuSzc1OElHZWlIZTlXekcwYjlOK2ZsY3dyOGlP?=
 =?utf-8?B?ZnVXWGtTUmFVVUJCNkg2MlNBRk1HQjN2Ni92a0VPMmJyeGtDZ29QOXhPYWsz?=
 =?utf-8?B?UUtma2lmeVNiUmtNZjdqNmFLWFV2b245YVNhYWMwRnU5ZGNPNk9JckJBNTlz?=
 =?utf-8?B?Z3h6eTFIRDgxZVJoQXRHcnUxYVNueU8wd2FlQ1NiRk8vMXN1VGN4amg2TFJ1?=
 =?utf-8?B?dVAvVklJc2t6aXZteUl0RlUxRWhrbmo1QjNCS29uRHJNdGwwSmI1MG92Y3Y5?=
 =?utf-8?B?M2d5cXg2czlCTXBGakpRL09uVVh5WWNnNmU1YTI5VTZ6THhiMVNFRUs3NUQ5?=
 =?utf-8?B?bDZ4VUF0NkpWWkwwelhXMjYxRURLOElsMlFubTVkTythYVo4QlRMNnJHV2dp?=
 =?utf-8?B?a1VLVkRLZnBrQ1Fwck4xU0lWUWt3S1J6c0JaYVQ2NnYvTERkUHd3TnRuOWFL?=
 =?utf-8?B?WjE1ME14MjRYNnJkaWdhKzM5SXZUTGZENXlucTVVbHBkUC9HM1JpdUNCZ2lM?=
 =?utf-8?B?eFloS3JzQmlUaTVNaE82Wi8zMnVRcTU1N294YnB3R3VDRXQvbmlSb1l5Uis0?=
 =?utf-8?B?RFZwSGpicFE3RHJxNHp4bnNGTEM4TURXTmxxYklCWmRIa3JOYVBhOUFJa28y?=
 =?utf-8?B?dVdlN2NBOVhmd1dDbFh1MWptMmFuOHBDaTJnUjViY1kyU3R6V0hKbE0rbVJS?=
 =?utf-8?B?R1lUb01oenEwUE8zdXJ1cW5vTFRZM1FucmNldDd4R2dkUDdtNTBYTWgzUFF1?=
 =?utf-8?B?bW1uRjFSOWRrSWFyZnZJTDczU2hlNTRzSS93dkQyOXVMWmF1RERMTEZocDA0?=
 =?utf-8?B?ZnBKcVVER3FmeTJNQTM1a25KQWxkWjgvbEJaWUVjbk1EM2I2TlpTODlIT2dx?=
 =?utf-8?B?K0kxZFZBNVJZSVVDVjBVZTFJMmY5QStVdkpQQkFRanljdVJYSDdKTkU4OXly?=
 =?utf-8?B?OXNNU2tTQlliUlM2L2tibHg1RmVLekFZcmEwNkZFTHg2SnI4YUdqUlRxUEpk?=
 =?utf-8?B?TENrTzIydE5hRUdKV2F6QXBZYkx3Nzh6VDE1YmV4bzNQWitPdXFDcXUzSDNx?=
 =?utf-8?B?M0RUMTIvY2NIa01SWDlSQkY4eDZtcWMyUDNqUEowcXk1N016UGY1MHZFWmRY?=
 =?utf-8?B?RG5iR25lZ1ptTWxVc2k1Q0d0OGp2VlJFNnZGam9vTmtrVnpvaU1aOVZWMDNB?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b8cf89-63ce-4681-884f-08dbdf291700
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 00:32:57.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5kaz7SqIszUuHd8yh++DBky/9c3dH9HoqqpdV8/ejMmdcEIILeCUh1YeOzizmmPQef0pOOvc5mL3lrk21q/ELbsdQCo38wkl4pqyRviOyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7614
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/31/2023 2:17 PM, Tony Luck wrote:
> The same rdt_domain structure is used for both control and monitor
> functions. But this results in wasted memory as some of the fields are
> only used by control functions, while most are only used for monitor
> functions.
> 
> Split into separate rdt_ctrl_domain and rdt_mon_domain structures with
> just the fields required for control and monitoring respectively.
> 
> Similar split of the rdt_hw_domain structure into rdt_hw_ctrl_domain
> and rdt_hw_mon_domain.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v9
> Comment against patch 4, but now fixed in patch #2. cpu_mask
> is included in common header.
> 
>  include/linux/resctrl.h                   | 50 +++++++------
>  arch/x86/kernel/cpu/resctrl/internal.h    | 60 ++++++++++------
>  arch/x86/kernel/cpu/resctrl/core.c        | 87 ++++++++++++-----------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 32 ++++-----
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 40 +++++------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 62 ++++++++--------
>  7 files changed, 184 insertions(+), 153 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 35e700edc6e6..36503e8870cd 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -72,7 +72,25 @@ struct rdt_domain_hdr {
>  };
>  
>  /**
> - * struct rdt_domain - group of CPUs sharing a resctrl resource
> + * struct rdt_ctrl_domain - group of CPUs sharing a resctrl control resource
> + * @hdr:		common header for different domain types
> + * @cpu_mask:		which CPUs share this resource
> + * @plr:		pseudo-locked region (if any) associated with domain
> + * @staged_config:	parsed configuration to be applied
> + * @mbps_val:		When mba_sc is enabled, this holds the array of user
> + *			specified control values for mba_sc in MBps, indexed
> + *			by closid
> + */
> +struct rdt_ctrl_domain {
> +	struct rdt_domain_hdr		hdr;
> +	struct cpumask			cpu_mask;

This patch did not change what it said it changed.

Reinette
