Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1110277D65F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbjHOWrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240475AbjHOWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:47:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A85FB;
        Tue, 15 Aug 2023 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692139631; x=1723675631;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w9bDqUvKnJLSojeEX9WsEjylUImKYrZc9CCaN7FxH04=;
  b=K5w3VWCOmkbTWUhJz7Wwp9aY3htc2Ny2l0rtVADcBD3XyHFimk+8beHM
   hPSCVaytWj3x7vUMGp01rseQSEWYQgeWgBrQgk3YNvi0gVOsQe6yWtQ0X
   /E2rppL2vD6foAV41FybmfbHGGIGpW/FZjG8KJgJS1o8ppeegTz668YVI
   c4oc9cWjrLcauRLstCe2KA24hkAiUEhn0MdS15/uVNzZ3MzyMJp9YwSM2
   qw9sNJDTCxi3fZ8k4oiU/imDnfnVv2V9AhsrSmeDn/eHlavHanKi9L4db
   wybLqECazSVmUgTwAa/kWsl85xHR1bk59QMc76ap8kw4OP051kxTRdEFj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="369867673"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="369867673"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 15:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="768980070"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="768980070"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2023 15:47:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 15:47:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 15:47:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 15:47:09 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 15:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldlQS84/CdO3eTBMgHp0jXM0qSyfemOJqnNv+64V0U42y9SFu/0YPeL2MGkUEpGdNGqZCgT7hmtemgMfIGgvtPIMtgpzM+m7T/IvroQF43j3m7shjwS6EKkvXtUeJdamOckFZJlx3OT9EaOfRPG3rsmjPlJMkasjQRyYdOA09I0Hzj2hAgtksodY2GhqUk7o3QZq36frJq2OB0njkZBJN9+DvaW4X9jrTAWamE7B1fZNILp4L/G1KsFqkH9IzkMwfcj764aGSFYd9TUTNR8rGimmtN6H692Pt1Aj/8noDg724gaKUTuIfqTx7z78am0yigNxWaxu/Ce+VpHAtjCV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfFLlOSLLEh0Xd7I9FmGZ4LuioP2kN4r8l+AJZBCmwc=;
 b=iY8LqBRHUG7g/n20Qw68gSvd0ehfs5ZRKFhe3BIYLW+zlxyjRhcFHFtIMyNe+x/9OhLhOSC8Gq138BYQx2PsTTB2SDtRWtAksR2tINb0+N+vE7Zyi1vEkWNffTCRtP9EivVBR3qPckH+xcWFAPUZ6LuB9Gq21/Kcqsq8sisnO69htTfhy2QKKQpAsGw1XUYt+w+VfZSYOQqof3VkdCllxeot+MxtUyEpaOyzikhmnBr4Q1BSLyuFpKcj7AekB37ow9wFOHz53SmJS85Lzw6s+7CxSR6Xvu8GoJktlbS3mHoQIbdIF3qa6UuaGicCKfOV2myafPoFaofF45hYM52HZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6124.namprd11.prod.outlook.com (2603:10b6:208:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 22:47:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 22:47:06 +0000
Message-ID: <42d034d1-1fed-8d3f-a2aa-b9dcc5ea1243@intel.com>
Date:   Tue, 15 Aug 2023 15:47:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 5/8] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178459367.1147205.14975628669652538089.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <169178459367.1147205.14975628669652538089.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:303:b6::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d6242c-5855-4f9a-e3b8-08db9de18d23
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37/HX0G+hyTS+zgkYRf8MsewCmkRKyY53ClNszZRBYUTjhZ6VN/ckBVXBMpJcsF+Q1TEr5mbi/EMbymPtt4XVN8hgskFBl1hHtLjo265AsEOGGlCYoIT7qPs4aOickImdUztRlZd1mbweWRCAaIVxmW0+FnYRmJvvkUXCEfjgKH1SUTGFjRvGPk9kmnnmR/p33LJnDJjDax8qWFotLU/xVMZ8l3e274guahz3VE9gbxzwdw93xSFWgLqWMuYrLOoKt0giQiC/4Olfn04djRrcujAtxhLzOVbiL0BQv1/Q8p0AyySZ9srmcViJLu6RDEURENaOU4TrDJIJGRcay40fvsM4LTA822XdNFUCOjYCxA0hXk8C7mw00NT2INbjOerFvRxIrjYBn5VrWR2NAzYAulKKO1dI+L56gaXEnYKJNLcQYB4T13AYYnQc0KjKcEwW4koClIIHKj0UQnwtomoNGJ5pdClnl4c9XpY/kTa9sFHynbmsOd93h1lRJ2iLUlWaC/npXmA7HWP0R/A3wsR2S6kBfEGOsrgaojNQYJKQP9t1HDGHtbm9c5HQYEUAq8LqSSLtfcstwbB15CnH723QaHWMuIfgnY4gPIudfuP4bk4ATdA+0oGBOfE8Spyh5S+2wtKSjzPcN8sFwnGZ5IPzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(26005)(6486002)(31686004)(6666004)(38100700002)(53546011)(7406005)(6506007)(31696002)(86362001)(36756003)(316002)(66946007)(5660300002)(44832011)(478600001)(82960400001)(8936002)(4326008)(8676002)(83380400001)(7416002)(41300700001)(66476007)(2906002)(66556008)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjNTN3c1Rk9USnJmd2YzQjRlWXVGeFptTitUYkxacDdPTUZYVUZCSlhrbHoz?=
 =?utf-8?B?VDQvU1hqbUFabTlKWTA1YjlFNmI5d2czUUZmM2ZzMFdOMHAzbnlhcnNWZFNh?=
 =?utf-8?B?Ym5CWEUxOUo5VTZXaURrQzFDSm5TLzc4L1E1TVgvdmk0eThrdHRzLzZXd1BU?=
 =?utf-8?B?WElxRkZ3TDB3M1pMZ2ZnbnViSXJJMXh4OFJwaTJHaXZOclVHUlh4R09VcCtE?=
 =?utf-8?B?UVFvUGR2S201WWNZcy9LY2xpNEQ3cCsyOFNlOUErUXBvZVFZRG0vOG1BeHE2?=
 =?utf-8?B?djJmcFBndTczUjVRRTM3R3Uwc0tEUnZ6L21WSWxUckZSNk1vaDJFRkhYNHhl?=
 =?utf-8?B?c2s1Rm9RSHlFeTJyY0p6azJReVkyQ0QvTGJlOHVSdkR4Vi9RaVM5cnhnTGhu?=
 =?utf-8?B?bTBoT2JRdldyNkdmWDZPWlBRbnpTUXJxY1pNQTRaaU1XeTVMZ3pZQnNiN0E2?=
 =?utf-8?B?WW16ZHRnR2owV1pEQTNBb0RFeTRxamdINytNeHJwUVlNeHJPZHpTckkwbmNH?=
 =?utf-8?B?SlN4WFJuUDZMelNYRUgvYjZINjdQZ2JEVkFKSm5CRzFtRUNFalhCRGI1cExx?=
 =?utf-8?B?YjNXYjN2aFE4dFRoSkZNS3dHaDIxenRLWkt3WDFzWWRFbFk2WCt3cVU0ZmIv?=
 =?utf-8?B?cFluV05QKy9qaHhBQVgzbFhQRlAzdnlGaHJucG5TZ3ZDNVIzYmtGbytQVjYx?=
 =?utf-8?B?aGYrd2xZeW8rQTlScXhHYkRERXFwS0s2QUpoTFgwTHVRUHQ1WkxBdnBlYTNP?=
 =?utf-8?B?b1IvTHFGaDdqNFdFNGduLzVXbEprejY4WG1vSyt1SnBkc3hxT2ZQeXFWYWgw?=
 =?utf-8?B?RmhQYTlhdWhBMFhUT1NGenNBbk5Gck9idC8xNTViZDZUdU1waU40cUxxL2Va?=
 =?utf-8?B?MWJMTVJuMDNMREQyeVhHbldtOWVYWVFja2VzZWx4UW8yVmNDeE45cVc0eGlx?=
 =?utf-8?B?Z3ZuM21ybzhQUXN2bFp6UjZZc0FxWDB6cWFoN05CT3dZR3drc0RIZGczVjlN?=
 =?utf-8?B?ZzQraEpnME9kckk0RXRhSnNBTmJIelhZSVVqb3BGZU56dk9oMGxid052V3lW?=
 =?utf-8?B?em0vaE9tK2hUUFl3Sk5BZ2lERjdISndKWUVkaDZ4anNtT0RJV1BLdnpuUzV3?=
 =?utf-8?B?V0QwVVZaQlBadzErQ1RGUzlXdVpWM2hZN2NTRWl6eVFpUGpKcDJNbjg1bm9T?=
 =?utf-8?B?c1dOMTg2VHZCdW0zUStZdG9BbUtnUkJVNW5QM3R2MmVVTmdENVlFRnd1Mnl5?=
 =?utf-8?B?STZ0N1IwY05FWFBxRzBFd3pNSWlleTJJSFduSksxTlJ6cXIwSXRvelA0R1dO?=
 =?utf-8?B?VkdhcEZJRlUxL21xVGJ1V0hjOEtJMXpaTWhVZ1lNdVo0WTFRTVR5eExHUkpt?=
 =?utf-8?B?eVpkYXoxeUZ1U1JvRjRrM2U0akR4Rk16Uk4zSnBZTk9sRGY0YUNPU05yNXE4?=
 =?utf-8?B?eWNwZGdrOTNGT09lTTl6ZDBnMEQzQzFjMUtPRkQ1TWZaaC8xaDBlV0dHa0VX?=
 =?utf-8?B?MXYzbW5oSXVtcDJxWjVhOHdSY3dqWTIwcTlmaHZQc2x1QlRtOEluV3ZMUXJw?=
 =?utf-8?B?R0FvV0pqTW1obldvK1pPUnhSVkhpZXZ5ajYxRzJWSHExWHRUS0RWS1R6MTNz?=
 =?utf-8?B?K1M4U3NDRmFwTUVrUnErcGFEc2RQRkRzUnFiUyt2RDdFb3A0OVdSajIyYmlk?=
 =?utf-8?B?WnYxK3JGZFk1Tk9FTzlXK2UxMVowNlJMbWl1U25EWjh0NWpNZmoxQVB1d0Nm?=
 =?utf-8?B?aFdraUdWVzNtaU00OVVzaDZhQnBOQWRlRjMxWWJIeXZSV0xZTHV3aUU5N3VG?=
 =?utf-8?B?WkcxY3BpdnZHbWw1K3hnaExnVUwyb2QwbWlOb3RrS1VSclpOTUF4aWhWOXBN?=
 =?utf-8?B?NU5aZXBnUVR3T0lVSkYrYkN0cVkwbjlRZUNSdmo5dTI2TVN2cDFhYjhtM2dn?=
 =?utf-8?B?bUY0U3lLVjJBamFobkxLbVdPTkVreTNYYnR6NllLMmpKRUdNbHpIZkRSZWJj?=
 =?utf-8?B?SEI0RmFReW1mVmx0SkJzVHVOZnpjWkRFa09FTGpvbk82ZWdMUFhJUWZXemYw?=
 =?utf-8?B?Z01IWUpDRDFHZnpqMTY2T0FrRndQVjJrWXJaYitZUlVOa2w0Und0UVhVcndo?=
 =?utf-8?B?SkxMeU1TM0ZJTFI4bjN6UnBZWUFmdDRpU085YUF6ZFBXR0VFSFd4bmR4V1Rh?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d6242c-5855-4f9a-e3b8-08db9de18d23
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 22:47:06.6628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dop7RsQJSl2uXfzNPY0+76+yLInQWX7B+Jb5Xv2nPYIb7bbgeVLAo6vN+N+m7XKqa9GIWMd6yjTBAjldifuzopxyjptosAb6v4wZtUsP1HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/11/2023 1:09 PM, Babu Moger wrote:
> rdt_enable_ctx() enables the features provided during resctrl mount.
> 
> Additions to rdt_enable_ctx() are required to also modify error paths
> of rdt_enable_ctx() callers to ensure correct unwinding if errors
> are encountered after calling rdt_enable_ctx(). This is error prone.
> 
> Introduce rdt_disable_ctx() to refactor the error unwinding of
> rdt_enable_ctx() to simplify future additions.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 3010e3a1394d..0805fac04401 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2377,19 +2377,44 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>  			     struct rdtgroup *prgrp,
>  			     struct kernfs_node **mon_data_kn);
>  
> +static void rdt_disable_ctx(struct rdt_fs_context *ctx)
> +{
> +	if (ctx->enable_cdpl2)
> +		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> +
> +	if (ctx->enable_cdpl3)
> +		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> +
> +	if (ctx->enable_mba_mbps)
> +		set_mba_sc(false);
> +}

I am not sure if rdt_disable_ctx() should depend on the
fs context (more later).

> +
>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  {
>  	int ret = 0;
>  
> -	if (ctx->enable_cdpl2)
> +	if (ctx->enable_cdpl2) {
>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
> +		if (ret)
> +			goto out_disable;
> +	}
>  
> -	if (!ret && ctx->enable_cdpl3)
> +	if (ctx->enable_cdpl3) {
>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
> +		if (ret)
> +			goto out_disable;
> +	}
>  
> -	if (!ret && ctx->enable_mba_mbps)
> +	if (ctx->enable_mba_mbps) {
>  		ret = set_mba_sc(true);
> +		if (ret)
> +			goto out_disable;
> +	}
> +
> +	return 0;
>  
> +out_disable:
> +	rdt_disable_ctx(ctx);
>  	return ret;

This is not the exit pattern we usually follow. Also note
that it could lead to incorrect behavior if there is an early failure
in this function but all unwinding would end up being done in
rdt_disable_ctx() because error unwinding is done based on whether
a feature _should_ be enabled not whether it was enabled.
Could you please instead have direct error handling by only undoing
what was already done at the time of the error?

>  }
>  
> @@ -2497,13 +2522,13 @@ static int rdt_get_tree(struct fs_context *fc)
>  	}
>  
>  	ret = rdt_enable_ctx(ctx);
> -	if (ret < 0)
> -		goto out_cdp;
> +	if (ret)
> +		goto out;
>  
>  	ret = schemata_list_create();
>  	if (ret) {
>  		schemata_list_destroy();
> -		goto out_mba;
> +		goto out_ctx;
>  	}
>  
>  	closid_init();
> @@ -2562,11 +2587,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  	kernfs_remove(kn_info);
>  out_schemata_free:
>  	schemata_list_destroy();
> -out_mba:
> -	if (ctx->enable_mba_mbps)
> -		set_mba_sc(false);
> -out_cdp:
> -	cdp_disable_all();
> +out_ctx:
> +	rdt_disable_ctx(ctx);
>  out:
>  	rdt_last_cmd_clear();
>  	mutex_unlock(&rdtgroup_mutex);
> 
> 

rdt_enable_ctx() is called in rdt_get_tree() and thus its work should
also be cleaned up in rdt_kill_sb(). Note how the cleanup you replace
here is also duplicated in rdt_kill_sb(), meaning the unwinding continues
to be open coded and patch #7 propagates this. 
Could rdt_kill_sb() not also call rdt_disable_ctx()? This brings me
back to the earlier comment about it depending on the fs context. I
do not know if the context will be valid at this time. I do not
think that the context is required though it could have no parameters
and do cleanup as is done at the moment.

Reinette
