Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276D4790403
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347407AbjIAXdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjIAXdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:33:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF53E42;
        Fri,  1 Sep 2023 16:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693611228; x=1725147228;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=89Pd4A0V3Jx3ddg9ujSZ+nvfPqr+8BqFRyYiqLP/hYc=;
  b=AGGKD3OendmNzeOmZMe9xLPPSuwpm4AaJaT5Ss6HZPV1stV3oF7M59J6
   rUhUkpFNxByhDg+dcWKwiDyYF6jPQ/Pgq5zf/SeiOpL+wgJvcPKl53zh5
   v8UW4pItu9Y7r2gxB/rNJ2xCgjErA73D5ymHhhHhF2sf9ec9W72T69pTV
   9cY28JkfrYvIGYX7G9kgj8k6by6xpqRgnhv+smiG+Ghd9921UJ8k25VkZ
   umnrPrsDSCsyWtJqZP+a+YbAem4B1K2QuDLhNFHCUiZrdeI1nkfHJtwQN
   Ac5tWKijBJW7dw6Uw6VmtjdbyEgR4cORi3j2sfqg/Fi2O2MIGhrGxt469
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="379050126"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="379050126"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 16:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="689916841"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="689916841"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 16:33:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 16:33:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 16:33:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 16:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTZXe/o5CmxFPnau85kXwil8mlGEOuoYn/zwbBOmHZ9SFi5qDFmPXlGf6NPgEk3DwU1Hev9mzJd/dgmGi7U9ysZaSfS+hyCHKOOFpkOCI2p8esc6fJ3WviqyWgx49oUm/UUxpk1IXrvPsGK9bzKY/VwyFWuzscYD6ML25NpViImBUT/nypC98GvLwk9XMHvLAoj0aMU1HzNX0uXePnmeqAe7DJ6dJI9egY08T4l7iNpK1LehCkWmzVd21jAZPQ+w/2M7XuwFiM+S+e6TSHsObSAf9BdVM/4lS0XPhVUmOtFzphuOYYtVsF7h7ORiHH0gSl3IJGwcIzKisZhSq11/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk/yECTdDJtNpe+Mq46lWIs6DAC0/wtBgA+qjR8OpFc=;
 b=atmzrN6vlwB9PtRNMOdZbLBNXpot9CrPY9QOXDT3EcEkNnhXQspl+nYVz7k7I8Ehm7pOG8HxQN2lk05VOxdzl7LQY6sGJnzrGN+80d5MIxdOV0H4FxGTqWRw6VFvQCll7Fj7zgCS3YxPKTUy1sief1rLUz34eLqop0O59SE40EqeQXYTe+zi9Wuzb2WSNdNC1eqfgbZ3gBg53G4MqdnI90GGhVsSg1lhqc5n7YKyvHL0jvldtUqBqGV/CnKeghjT/DRVKw4kQfiHHjEPWGotRF4wB3XJ0Y8P880e8NWrKNVN+BlRaAzTFMW7U3oElS0SMljs4TD1Csk+FRWfEHMbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Fri, 1 Sep
 2023 23:33:40 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 23:33:40 +0000
Message-ID: <ce642384-80e6-6d73-3d5d-97d125951245@intel.com>
Date:   Fri, 1 Sep 2023 16:33:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 5/8] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-6-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230821233048.434531-6-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:40::24) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA0PR11MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c32f52-6a91-4e62-eeec-08dbab43df09
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cd+vNOQcs9VBDq9wFUlIpt5bTt2dxjOfmUp0HAJivMCyOe5lwRCGT26iel07+z3wU5SrrYlvuJYHqejmFf8kFKpahhJUzyQpQHW8maGgQQYjq87bFuG1yaRsVSqHQAr9jgGd8Slihx8Nu3u+ny8ewbELiycLrqxDx1SF4MlRLk/BG52gHtLWjTQuGXz6wgtoZOFlcFRZyneMwZFbuobF5NmtdnFGfZynRbs658hjipMkKZQml9ZNpxG+8nZkYpsE8f7cR1v2mrYkkE1FxtGS+6cWI04KH4eZBp+FxYOLDd/34JMC/aW5esLtlIxJ9YKpQ9tvQGt3Y1EoAUXoY0FOrBTTnYuiTvOFnFbKDnsxgB6Y8Zn5dDN6g0mvMYJb94FnlzHzLr8wHUnnXCJ89A0k03EHYsD4degnBSoh8rzT2wLC+/KEE1sUhMYNcuyxTjYqcJEBMPoHNMmgncZjNR1MarSFBkF0o+7N01bw4SG6QNBJPSwjfjyXhg1WA91MyzRwQPMP6cd5stDHFUpzRVCOaA6uWp6ppuT3c5Kt8rwQxzzyAcOzKZ0g6kBy/Blh5pDfPIF7wMUTSRJkExa7hGjXDIqwSEAklMbRbfU99uiMPA2NLqaSd2ZtgawVFGMztE/MqH9B3dvdJNNjUmc2sQ9UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(186009)(1800799009)(451199024)(36756003)(41300700001)(26005)(38100700002)(66476007)(66556008)(66946007)(316002)(82960400001)(478600001)(2906002)(4744005)(53546011)(5660300002)(86362001)(31696002)(8936002)(2616005)(6506007)(7406005)(7416002)(6512007)(44832011)(31686004)(8676002)(4326008)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdib3FiN0VWNGFzdzU5SjR1ZWIwdXBIR1BZc1RKeHlrcnVjMDJvQkZ4cGxq?=
 =?utf-8?B?TnN6QkhHdHRvaks1amRJYlkzTUIrZFhUM3dlQk9yelQ4REttNzk1RnlGZ3Rk?=
 =?utf-8?B?QUIyNzBsMzN4TnpsRXh0U1ZvSHVEanNGc3lNN0lobmNWb3NjbGNTbUt1TitF?=
 =?utf-8?B?Sk5YMjZwRGZha281MWJWUEk4eDd1S3p4QVBXNEtXQ1djMm5JdnlFYlZvRHJP?=
 =?utf-8?B?WW5SSTJaOEJFTkV5VXI5ODd2cXpMQndKNFgrN0w3VlovNkR2Um5nc3NiOWhH?=
 =?utf-8?B?cU9OOGlnb2s1MVhJa3pha004Y3dqR1ZZc21ZNVRGbU1SdDNqVTR4WkgyWUlL?=
 =?utf-8?B?K2Z4ZFBhekJjenZiRE42VFU3L3FvNVBVTCtQZnVzMXl1SWdOb2k2NHhOczRS?=
 =?utf-8?B?Q3ZkSFlLQ2tIZ3MwUkVzUUQrVmptdm1PQ2EzK1NncURKcXdxcndtR3ZMbGk2?=
 =?utf-8?B?dE02eWxmMFZVZDdsRWhFYkc4T2tTVTdxckhna01MNXpnYTE3M01OMitBQkUv?=
 =?utf-8?B?RXVZeVBXNzNveTA1OVh1TjBXcVJxMjlkaXdIYm5kL29uc2NXNWUvYWw3REpN?=
 =?utf-8?B?ajRYUmEyc0d1NlBoVHZBbUt0TWNnS2lqUzc5c0kzRXBqeWxUc3dteDF4NlFU?=
 =?utf-8?B?WlV5eTF3VjFONlVoajBJeVhnR01yUVN3aXFEdzllMnRPNHc1aGQxQURETk9m?=
 =?utf-8?B?R0hRVXpDVUVSeGhPbzNUdjJIOHAzZ0ppUU1pMmVxUkhzY2tNYndYSTd3QzBT?=
 =?utf-8?B?b2NEVEpUY3lEankrZmxicnJtTWx6WEQ0SkJHVUVuUElwMUFZblIzbllpbm15?=
 =?utf-8?B?TXBBRkhyMTZvYUJzcVprSmtkVTE0dldLYzFqeHI4djdaa28ralp3V0xvZmk1?=
 =?utf-8?B?SkhZVElndys5VzJFR2thY1BpdzJsa3FOdThYTnp4VHpCNlZab2FhSTQzdEdE?=
 =?utf-8?B?OFJQKzJBd2ZiVWt2ZjFITGplM05ZYUt6ZExOSVJsN3MrNUc1L3lSdC9idkZZ?=
 =?utf-8?B?dzh0YUV4SWY2OHA5eHVweW0yWHM0SlJGR29wbjRWaTFUbFlzSzdxNkRnVFJ1?=
 =?utf-8?B?VjR3cFF5WHhwWkRvTFJYYmdUaXFrVTB2STVlaGNUbjdCeGxzcFR0ZWNvbmpK?=
 =?utf-8?B?QzNLOVNvbTFtVjZwU3JES0xsMjdFWlpDcUFPekpxTnJPdlFtakxRenZvdE5a?=
 =?utf-8?B?VmowbnlLY2lUQmlxQUJ5QXJKRUFLbFhjNG9UdFRURUlyK3VDTnBSUnZRNVFv?=
 =?utf-8?B?aldoaWpFV01rVzZUQ05wV1RtSWp1N3lsU2w2WGM3dEM4cm5mSkk1VjhrUXNz?=
 =?utf-8?B?S2RvS2pzNlE1c2dXNDdibHhkWFdvb1VDT0tmbXRlRjgzMVluck5ydGViazZj?=
 =?utf-8?B?emd1YzF1Y25US0pVcXkzRnZGU1ZINlJacXRrY2tMTVljSDMrZWx1dXhzVGVs?=
 =?utf-8?B?MWRuaWcrZE1nWlVWT1g4T0x1QnE5eVVOdm12cStja2J4YVlmMUw1dXVWcEVq?=
 =?utf-8?B?dGE3aE5VNndzYWNyc1Q2VVRpU3hGT21rMTJ4aXBzaUlncUZnVWhoVlRYWE5x?=
 =?utf-8?B?bUZvRmRxanBidHNQRHNUbDRwMmtKTDVlbkE0N2IvZjhDMGtYR3FkZWNxY015?=
 =?utf-8?B?SHdKTjA3TlhHN3JMQmFSVlRqRzEvZ0dQSHhlMFUzYWlWL0JTdDVPRE5BMkw4?=
 =?utf-8?B?NFZLOTRsUERaQzYvM1IvRzNaWVFtUVgvbklWa3ljQ1h5Q0h5dnY0SlVISEtY?=
 =?utf-8?B?aGJaN0xjZm1GRjc3SFZHeGRVS3pQdW5ycUwwOXJ1cWNZczA3cVNYd01sanRR?=
 =?utf-8?B?RnZFVVR4Y05oK01QeUVUVG5Fd3o0NmZrdXB1cVp1V3RJaURJcld2eEZMM214?=
 =?utf-8?B?WkpMVCswY2NQb2FlbjM3UVBMVWJXV3N5OTI0a05sQ2h6UUZoWUROT00xb0ph?=
 =?utf-8?B?TUcrRzFzSThVNHM3OVgwZzhNRGdpZFpoSmlOMXEwZWpnV1ZBYTFzbXEwU01p?=
 =?utf-8?B?RENiRG1MRG1ha1dJQUU3RXJSOXVvaHMvbFZQUnJSYTYxTVpQaXN4QWpnM0pZ?=
 =?utf-8?B?OFpMa0xXakhHQ1VCaEpyckIyTmRhdjMySzhQYjFSSGRRNnVTZWR0ZThKWTFE?=
 =?utf-8?Q?mlT7/KFR1nxzasWKsefe9prZy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c32f52-6a91-4e62-eeec-08dbab43df09
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 23:33:39.9172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9+f4ulF6aU5rxA2sAYF5/qX2NT2WSLTYWtEzmPoxWFbQ+6v4n9E6Onr9plNPD6nkOGLX8P0bbT2aBTBDAWZvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7283
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 16:30, Babu Moger wrote:
> rdt_enable_ctx() enables the features provided during resctrl mount.
> 
> Additions to rdt_enable_ctx() are required to also modify error paths
> of rdt_enable_ctx() callers to ensure correct unwinding if errors
> are encountered after calling rdt_enable_ctx(). This is error prone.
> 
> Introduce rdt_disable_ctx() to refactor the error unwinding of
> rdt_enable_ctx() to simplify future additions. This also simplifies
> cleanup in rdt_kill_sb().
> 
> Remove cdp_disable_all() as it is not used anymore after the refactor.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
