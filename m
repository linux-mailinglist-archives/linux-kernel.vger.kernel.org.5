Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4577A7DC1D2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjJ3VW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3VW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:22:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC863E1;
        Mon, 30 Oct 2023 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698700943; x=1730236943;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=beaknvNbcz8KYKE7sgB3dNPFyXmuSq7ASiWnReebFLE=;
  b=R3li25bPrptaVdSNDuFm5Knto+ZYUYiD/uK7ge9ka1EpI7h2pSbDIrd8
   YeUz/SMCDNhAZNUfjXUcdc/lRBFJCb8Y0/QcUt9UtST10cFnggxSy6N4P
   97yPn7f/voB09l17vUbi5smELydqjEeeC3A72Jqx/sEs3SWLZ3YZs2SPK
   hN5cZV+R+13aml/U0xDPIvk0DS+BCiv85nEjrsTFFfaeRLqyYZLkUz0We
   B83fFUE7X9yEViehkiWE1xWyk0x+V0NENGGrejIEPIrWzHZ08omwzIGY2
   PH+47v09ydDdN9jolrOImv4JNCRpZJ1tyFIyvx7j4b51jPxm84nJfKRXF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="474407191"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="474407191"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="826180645"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="826180645"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:22:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:22:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:22:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:22:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLVf1TOHPiUx9NZzO8XyXW0TKWz+asQJ5iqwz02Zu+ygWl3MvP3qxEQ5wqMs0xk16PdMU+HEvAIsw33zk0Buo8hRbdkAEzs+rzOXSUIyEM3/nBKH+yXKFylf7ZDclFW8aRL+oltUPyEhoMdjDzIyVas/e0IVovKDjl0Y0gIbjwy1Fp9GOubyuGxfDczGwVULOs+CXowhPHedq2Sw6wSfDFE7H0Gi707td/9ms7bzNdnicW6WfccpmA9HBA+21L/FsuBXViD3kj7GsrSkIjfphzz6LPdN8/j3sxGFHUT7+ys/TK8yPXiypfeGs9WLjC8piWv2YTCcfyjjJcB8NzjStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyqGoxE+xJlF5fU1rheRD+TEMzXVQGkMzmpKc4/6I80=;
 b=gu5fKKt9uEA8fU4otpIbHFI7+i5v5PNBPb84W1xlIdPUZx88/UYHAB3x1DN5txwyIsjqtNWi/CNrj3wpRz8f8PqzbTek0n6haUlzNhefQccZZwMtNhByNVUCptJX3cst5f8lvvhR2Sgq6fJS6yXFkjF0pJJfTYNXGs1j3vtq1I8QvTWP7JJ0oMHwZ6a/tzm1Xom+whOZwnRnpwhG8NW7Y9q0qTpg6n8biYODXglSh4heaOk/LxfljfPKMsPQ7fpDu2nqt2BDnXgVxtWMxQ6e3BmbTzSXyvLg1UyklECS+KytZg1/Y+6b6FPmTt2mHoaKRTHlYPKvcN3JTOCpdxYnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8136.namprd11.prod.outlook.com (2603:10b6:8:159::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 21:22:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:22:19 +0000
Message-ID: <0871b932-cce3-4ab3-a2ba-2f1a2d27f2c0@intel.com>
Date:   Mon, 30 Oct 2023 14:22:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] x86/resctrl: Introduce snc_nodes_per_l3_cache
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231003213043.13565-1-tony.luck@intel.com>
 <20231020213100.123598-1-tony.luck@intel.com>
 <20231020213100.123598-7-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231020213100.123598-7-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d96405-1dd0-44b0-1e84-08dbd98e4cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzDDD3p7tj4KSzrwjNi7b3SSgJbHv8lUHOJtViUTzm7vula3+0F3EIA2jVVskMiAuDLjmYosICBpWMBn36gXcteir2xByIl285lGDKZOu93MXReW2ez02tdyQ2natfM0CKPRblskznqwmQuyM7TZsjoDCAeSU9GJ17tsMgGIHObuQxx0D2Or2PLVnQpwgQAHS8i4AFBptlT5b3ibn12J2VbxxbRHTmu3Rcif/fVKYe662jous5bP2OLGGzlPVJHwEzzMtfeENK/aTmI+YDJM05ooou0GBs4UyfPdY9yKpHtnEcTpJSrUaQqG/m5P+ebR17FtzZ+F3VbNyo0gIslf1xLEYEQsB9tulo8L7bgKf9XD3N1Az7xymZoeB6gabPt5uLfuU3J6cufqBOaggLe7W0Z38AKjwaFD8AWh3LcmpFnHXLaQqirRj/fGWOsnut86zjojdLM2VYFk1KZ7hTV6WSQ3htipA079F0wb8qHg6mNnJpzUNu6vl7b5j9o8rHLonevND5i3UpQsGXZvuJkyXce3rVNPiNuFAV+6VizwT4fQyy1Jyx5jvitmUMDU0H0M0Zd1MgHPAa8zLb0jJiodDBImN9Y9oG/0hahvyfjU77Gba5P2y5DgnClsWh9dvAuDUbSN9qhEWXVvrQmamASjjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(478600001)(110136005)(6506007)(966005)(6486002)(66946007)(82960400001)(83380400001)(36756003)(38100700002)(2616005)(41300700001)(66476007)(2906002)(6512007)(26005)(66556008)(53546011)(44832011)(86362001)(31696002)(8676002)(8936002)(54906003)(7416002)(4326008)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi83R2dOTDVQelU0ZUJLUXVDNXJ5NDNQWGlxR3dxb0U3NHJZNGJIcVZhNWxa?=
 =?utf-8?B?VzkxbXljYmNnUEc0R2ZKNUVhQ2MzQ2JvejhoTDFsV1lpL1ZuOC9GTExLNVNl?=
 =?utf-8?B?ZkxXU3craFlHbDg3ZEdKdnNqT3E4MnhlV0E4K21QKy9iUkc5MHBWL0M0Q3Iy?=
 =?utf-8?B?NnFIT1lvbzJwZWp2cy9qSkdSMDB4VTVqcUxJTmpta1JrQ2ZFanRncmdOZFcr?=
 =?utf-8?B?Ui9BQWxoa2o5dG44UHhhcEJlcjNiNllLZE5jS1ZxNXE4azRkcFk4TDhUcFov?=
 =?utf-8?B?Z0VFUDFRakx6bk1WTFRyV2RmdldZOGFxYlNHMDZRQ3VWakdRazArTWtMcytH?=
 =?utf-8?B?azJvY1BWTHVQWVB6aGlqWTVPV0srbVprYjdaQkZDOVQyTzJzZFVTZERhL1ZD?=
 =?utf-8?B?cEgvSmo4VzdMMDhqR0daa0VnRDVtTTN4NGZ5bFc2MVhNYVY0WGtlQ1ZoUGZj?=
 =?utf-8?B?MlpSaTlzMGU0SlZMV1YxVlpwcENKZHcwZ2k2UHI2a2xkeXZCM2pkV0VBZEZR?=
 =?utf-8?B?MEVKdGlrSWlobGg3UWxZQVhaWk5HdDNnREpiQVFkZGo1Tm5OQlBhMU9aa0hL?=
 =?utf-8?B?N3Q0eit0akpzUWdxd1JFM0dmN29DNVA4UWxWeWVnZ3Evdkpsc3dvSy9RaWo5?=
 =?utf-8?B?cTFEZ2ZSUDlDc0g5YUw2UU1KZE1CdEVWRmtQVW9YZ3FJZGhZUlFwYllvU0lq?=
 =?utf-8?B?ZHFNTjVOUk1LUlFLNVoyM2lOeDVPajl6dGl2N1dVWWRkelIzSVVGWjVQWVJt?=
 =?utf-8?B?Tzl0NVl3dmo1QWdSbWg1L3I5RTVNNk03NEMxSjBEaXNqUzZFM1MyQjNBa29S?=
 =?utf-8?B?L0dPcEp1M1BHQWt4V3p4OGpBL0pDejRaY2VjS0FCU1FsSy9UNWIzYTdJd3Z0?=
 =?utf-8?B?bWkyK2pXUFdReU9vRjZhU2tqU2FrbEZ0Z2hIMVJ4M1A0ckd4OEFLZWgvaGVV?=
 =?utf-8?B?bklJV2xsTUZWbTkyM0Q5QjBua2N3NHZ5SVlydHRHY2NpNHBDeExuSGYzVDFs?=
 =?utf-8?B?cnNtd0wybXZhdDNOVEU3MVU0aG9SR2ZlL0FvNUg1dENLV250TUs1WkJLRXJB?=
 =?utf-8?B?cTdybXRQTFFUeHhCZmNTT0lmT3NPVi90SDZzM1A0UU04d2xVZVBkQ2tDOXA4?=
 =?utf-8?B?VGNlTzJmNXpFUFZHeXp3NE9jWlhxaXNXako1TDZMUmVBOVFqTlE2WGFRWlZJ?=
 =?utf-8?B?OGRCVm5zQ0kxRjQ3SVB3Vy9FSFFXT0RNSDZWS2RGb0c4RnlwNUlSWnczaTkr?=
 =?utf-8?B?VHBzNGZpVVlHREVFNGJkOTFaRVhSMHlaTHlpbWJtUlhxeGo0K1RBNUN2Z2wz?=
 =?utf-8?B?cVFUc1BqeVBPT3FMenhJTm9mU0ZqbStMZEN0QXVqanZtRnlZeUw3VGVBM0pz?=
 =?utf-8?B?QlVLNFkwek5SMDlMWnFsLzV3Y3pMRWZtTTRacVhkMGdmUW9iaWFJMGQ4UUV1?=
 =?utf-8?B?Uk9mUlhjeGtYT0lObTdSU2NZbW5pYnJXSUlMb3FHL1lTbnB0TC9pZkRNcjBa?=
 =?utf-8?B?a0tMejhRVmhFbDdJZVJadzVRQ2FMWmJidVF3aVl5QlRuSnFaSTV3YWJtUmFm?=
 =?utf-8?B?L3Z0T29wMGVUQ1NvL0ZqR0M3QUhlOWZ5VGpBYkptOVpkVlpIdmlnRHNxYVBD?=
 =?utf-8?B?Z21IV2NVMjdRWXkrcmppeHZKTERVcmZxWS8vc2dKVlFDbWhyRXAvRFR3SHE4?=
 =?utf-8?B?MzY5UmEzQkxhQVNXdFp5Q09FamdhTVVnU3RXRE45QXNkTEN4MnhGYTBPbHUx?=
 =?utf-8?B?QlB0dUZYc1dnaWJqL05oUDlVUHFJeXhhbFI3M2R3SnlYTkt6UUJoU29LakhY?=
 =?utf-8?B?YlBaUU9OR05GR0s1OTZKTFlYallSc2RqbVRXWjdtVWxMVU8zRVMrSUp1YzVj?=
 =?utf-8?B?MHR5VVVJT0ZzWVRJTzM0Y2xlVlBCZXlMT28rWU40Tm84cks1ZThHOHVBbWx3?=
 =?utf-8?B?TTU4SUpWb2ZicUtwZXJ6NzdhdC9JVFlETGhQS0c4MmFVU2dZWmJzZCtyL1Js?=
 =?utf-8?B?OUhMWjR5OEdET2x3V1hvdG1hQnlzOC80MGRtYTVhelFBZnFqelROTU0rZzRw?=
 =?utf-8?B?TDJJWTNPcjNZUDl0NmtjcGtrYzhHbnc1MmRGd1FrMXVZL1VXcjF3Z2pzekc2?=
 =?utf-8?B?K0dEVmwwSDFiYitzVllRZStZeWZNb0V2TlI3MWNlV2pDVTV4d1VhblNXUnRZ?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d96405-1dd0-44b0-1e84-08dbd98e4cad
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:22:19.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rj57jYwWzq+/Hq9P24OHSILFDTnF1air+2wLEt+Dj2gEDihWJRZ+K+35FqSaN/G8vbwZ1YrADUv2ZODq/bQI0saXVPRlNwPvcEg3rhMTesM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/20/2023 2:30 PM, Tony Luck wrote:
> Intel Sub-NUMA Cluster (SNC) is a feature that subdivides the CPU cores
> and memory controllers on a socket into two or more groups. These are
> presented to the operating system as NUMA nodes.
> 
> This may enable some workloads to have slightly lower latency to memory
> as the memory controller(s) in an SNC node are electrically closer to the
> CPU cores on that SNC node. This cost may be offset by lower bandwidth
> since the memory accesses for each core can only be interleaved between
> the memory controllers on the same SNC node.
> 
> Resctrl monitoring on Intel system depends upon attaching RMIDs to tasks

"on Intel system depends" -> "on an Intel system depends" or "on Intel
systems depend" or ... ?

> to track L3 cache occupancy and memory bandwidth. There is an MSR that
> controls how the RMIDs are shared between SNC nodes.
> 
> The default mode divides them numerically. E.g. when there are two SNC
> nodes on a socket the lower number half of the RMIDs are given to the
> first node, the remainder to the second node. This would be difficult
> to use with the Linux resctrl interface as specific RMID values assigned
> to resctrl groups are not visible to users.
> 
> The other mode divides the RMIDs and renumbers the ones on the second
> SNC node to start from zero.
> 
> Even with this renumbering SNC mode requires several changes in resctrl
> behavior for correct operation.
> 
> Add a global integer "snc_nodes_per_l3_cache" that will show how many
> SNC nodes share each L3 cache. When this is "1", SNC mode is either
> not implemented, or not enabled.
> 
> A later patch will detect SNC mode and set snc_nodes_per_l3_cache to

Please remove usages of "later patch" from this series. For reference:
https://lore.kernel.org/lkml/20231009171918.GPZSQ2Frs%2Fqp129wsP@fat_crate.local/
Please check whole series. For same reason I expect "earlier patch" to
need removal also.

> the appropriate value. For now it remains at the default "1" to
> indicate SNC mode is not active.
> 
> Code that needs to take action when SNC is enabled is:
> 1) The number of logical RMIDs per L3 cache available for use is the
>    number of physical RMIDs divided by the number of SNC nodes.
> 2) Likewise the "mon_scale" value must be adjusted for the number
>    of SNC nodes.

Can this be expanded to indicate how the value needs to be adjusted?

> 3) The RMID renumbering operates when using the value from the
>    IA32_PQR_ASSOC MSR to count accesses by a task. When reading an RMID
>    counter, code must adjust from the logical RMID used to the physical
>    RMID value for the SNC node that it wishes to read and load the
>    adjusted value into the IA32_QM_EVTSEL MSR.
> 4) The L3 cache is divided between the SNC nodes. So the value
>    reported in the resctrl "size" file is adjusted.

Can this be expanded to indicate how the value needs to be adjusted?

> 5) The "-o mba_MBps" mount option must be disabled in SNC mode
>    because the monitoring is being done per SNC node, while the
>    bandwidth allocation is still done at the L3 cache scope.
>    Trying to use this feedback loop might result in contradictory
>    changes to the throttling level coming from each of the SNC
>    node bandwidth measurements.
> 
> Reviewed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v6:
> 
> In commit comment s/redumbering/renumbering/
> 
> Move check that SNC is not enabled into supports_mba_mbps().
> 
> Add Peter's review tag.
> 
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>  arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 16 +++++++++++++---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  5 +++--
>  4 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 41a23556f57d..563e6203321e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -446,6 +446,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  
>  extern struct dentry *debugfs_resctrl;
>  
> +extern int snc_nodes_per_l3_cache;
> +
>  enum resctrl_res_level {
>  	RDT_RESOURCE_L3,
>  	RDT_RESOURCE_L2,
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 2c3975c9c20c..0e418dd14070 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -48,6 +48,12 @@ int max_name_width, max_data_width;
>   */
>  bool rdt_alloc_capable;
>  
> +/*
> + * Number of SNC nodes that share each L3 cache.  Default is 1 for
> + * systems that do not support SNC, or have SNC disabled.
> + */
> +int snc_nodes_per_l3_cache = 1;

Should this be an unsigned int?

> +
>  static void
>  mba_wrmsr_intel(struct rdt_ctrl_domain *d, struct msr_param *m,
>  		struct rdt_resource *r);

Reinette
