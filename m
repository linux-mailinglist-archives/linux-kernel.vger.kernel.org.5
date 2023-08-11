Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92420779627
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbjHKRck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjHKRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:32:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A43D30CA;
        Fri, 11 Aug 2023 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691775157; x=1723311157;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P/5JBFwFZnf3edj8Eqwz6VeoMeozVL+tknRmRZaYecg=;
  b=Z2yJxiYsn36JNcz8NEwjZNtRKgVq5V7+8XU2X7SycrJ9h1S6jNK8N3mH
   0MlNctehWG5K+wjD7W+tgpX45cdG2M2hcYlErwtv5EzRFBXqwt91E1Ar5
   fhVRu+8AukVV2v/9gC2EWeR0MCHv34VpCqz6LlinLS1iuaAn8s2ZkZbLN
   wx3TNNYjWkYw65FHXazPanbra/B8n3ckeaoBFZ4mylmgQMEY0s1YSH/9c
   Y0yIXrAkGKul3B/aVBYiOLhuQi4Qd/QFbD5lP6g34czazkJwu/5bbK+dk
   qLoePlwv3H5h0fZaK38fAP5Ccn8fNSLAUAR9qyHqdIY7rZFcNvBkhd2WF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="458096854"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="458096854"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 10:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="798112003"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="798112003"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 11 Aug 2023 10:32:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 10:32:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 10:32:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 10:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkY/BU0D4XgjUs+zC9MHHjO22Z3M6awTUVCULr5t4pS4xm9qb329jM6rpGFFWHwifLOKLOUt+g2ce+WN52IzvGLUlfmErzMSZT1jf2XbG/ipr5sbNOSktnKnOsWvxbhs1jGYGDKU8jT/ZcpYOF6Gofc5AbBB1vKH0uyRPluWRmTrQPTxWS6jCa8fJBnj2AAGNGd6XkVrUn/Nsd4orzo/yRV7xDwIdj9bcri4W51phlpotJPiKKN0813APNnRJmTt8zWK16niqEUelKXgcTPrbJkc3/5aK1eTvh3l8oUxD0mPDqx0CynZ+S92Xm44Wr34y13AIjfNkzJXnN1XR726fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkxBQIhklqQisX+UEQQssQVgfDKXHRbXByqUQSum/7E=;
 b=BuxNQOSHqXuFv0UA2JdlvfFYH4exnRArDNzmJRcmRV9IidHtny+VrN+vmXs8iZT9hhQFsbIjnZCSEjwFHVC46vQHzU8cLB4veaAXFxe4KxT08mHKlr0uWHAXZOWj88qEvpgShB4FVFETUvT4h3fLHoUE6bwJrIay3sp3nzsjSZ96+/Am1gC5jNKXU4plViAudpP4J2Iy979NPsToGlq86gKq2k7pZt7ODe5xMPn205B5tJNAbui1PZeYp8MWaHA92hDm3lO5Y9EWorlXdDwNQz64wwkwycy14oiPrpKT1CEEFv8Bh4Jm3wF6fZNXET5WWF6LLFRxF8KdgoC7WKyv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5609.namprd11.prod.outlook.com (2603:10b6:510:e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 17:32:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 17:32:32 +0000
Message-ID: <7c8650d5-eb69-dd28-81fc-7a97d45f9bfb@intel.com>
Date:   Fri, 11 Aug 2023 10:32:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 5/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
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
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-6-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230722190740.326190-6-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 07853ccb-1bb0-4355-bd6f-08db9a90f166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ggk9dwECNpvbMUfX4zAdpoqXpR+TftakmuICpAj4Au8t/WztndheaUY4pfCmByn8f8aZ8okE7mf76hFBwqO6Da1DGAx4Pt1PhaAaso/LXDJoBmqI57ZIox1vXyV8vBcJY5ZAU0GywENCHIhQG67DMnJeoKESxYcNIBKNFzbxnWbHMiRmQV1PJ0i0lTd2CAC4RSrKUB0Wt8CAuLhAvSk5tTowummJTdvE8e9Qf2I5rxc6W0uKq5crwhbB0v+8fVg4LKOVJkeHqBbznUqIhw108bjG78bEk7h2bF4D+HuUWdS9ize3xdYa/513lDCE5+lv44DC0gKYQZoBxfntxb+Q9K+ViweXPkggqIuqMDJYSVUVPYgtEeQ2WdmPuhBd9LK++gYEHO9GQHx9s2RQtV+//xBFBoyd8gRO9vPQq9O8O2unUwSxk/kFve0eNoEKM1lwJbx3ZKddkEYeTIU/alM3pn+MRqb+1iZOum8poMMPUptE8cV+50HElSPXu2jq4rxuyLiBN6DdPpHTi4u6VmkJMivDb5M3CK3eS4WW2BfRY4wO8TvVnhEMJ7dTayNizEwsJyqCwttzTD1Hjf+iYfRW8/PmnD0McoxdfM8Pr/NnDcJq1LdlqsL9mtWPYfdjlMmYM1qn0M5YDgz7wnOb+ZvKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(1800799006)(451199021)(186006)(36756003)(31696002)(86362001)(82960400001)(38100700002)(31686004)(110136005)(4326008)(30864003)(8676002)(8936002)(44832011)(6506007)(6666004)(6486002)(478600001)(6512007)(83380400001)(2616005)(26005)(41300700001)(53546011)(2906002)(7416002)(54906003)(66476007)(316002)(66946007)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di8xOUJDQmdUVUJPam0zbGJ6MFVmVzVpR3M3YnIzWFlRSC9xWWp4T2dxaDNI?=
 =?utf-8?B?RzVLMm5GR1pzSFZhcDNTTmE4em96cjBoYmdDbEUxUEl2RjlJVGtpV3VXUC9Q?=
 =?utf-8?B?Q1BrTUMxdEFXbk9XNFBObjVWRGZiNTA2eU5yOUJ3TzRzRURTK1c2ekFtM0FJ?=
 =?utf-8?B?RHNoMkhkYkNiOEZKK0doMGw5YXRmYmRpN1RUcTdWaVBsYkN2VzlRNG1FTVhL?=
 =?utf-8?B?aVQ1K293TlY1U2FuUnlpRXZhWjVpMFk4c1VpWGp5Yi9QaitWZkZkZnNTZFNZ?=
 =?utf-8?B?L0RnRjdHbWFJMHFFZG13YXMrQW5pRC9zREt4emY4R2xkcmRWYXhLTlJrQ01p?=
 =?utf-8?B?NURFWTlUOFJuL1AzbXp3aWhKS0ZxZ0txQmFQTkgyS0NFSDE3Q1RUSWpKeWpx?=
 =?utf-8?B?TG9TRllJNCtCaVMrQWVFYjZmRUtaL2pYU205Nk5CU2lCOUx3V01tbUlwSTZG?=
 =?utf-8?B?SFhZT0VNcTlndEd6QVBkUTNLRmJuZ0xZU2R5Q1VqeVo2OEkyeGtWQW1HS1BR?=
 =?utf-8?B?dlRJcnA2RGlJSCtJOG9GNS9sUzVwcUFYYmMyajZtRUNVSmRqQm12VHRjUXdB?=
 =?utf-8?B?M0pENS9ncEExanlBSmhGdW9KM29hQ0JCQ2pzSS9vd0FkN05TVGNFZE1TcnZh?=
 =?utf-8?B?VjB6Smh0TlNPbS8rZWl5UkR1bVV6aitEM0F3anZxaVk5bWlFMnNBNW5mdmlN?=
 =?utf-8?B?bDhBWWFRRmltVnVFdHpGZHhmMm1vd3gzV3JHNjNEblU0ZDh4MGhYLzFyRXhQ?=
 =?utf-8?B?eFZuUVVRWkt4STJGNEhmaUJHY1crVVhZOVAzR3VZSzdKMlZnVktCOURVaTQv?=
 =?utf-8?B?T3Qrank0Qm8yTHpJU2JhaGowVWIxd2E2bEFPeHJsdGR4TEI1Q2d1ckVKSWow?=
 =?utf-8?B?ejMyR2prZi9DeUk0S09wdmhDUDRoSCswcFI5bXgycW1ZZEFoN01reFNtL2Fu?=
 =?utf-8?B?eDkxclFTRDNMQlYvc2FLeVdsL3hPMlhNK2hTZ0FHQnZRSUdaZnAvTmxEckpS?=
 =?utf-8?B?cXJPUThNdVVHNXVscDhoMk9BNit4S05wditzRlVvQTMzNjVqR29nRE1GTjZ3?=
 =?utf-8?B?MDZvUWV4dktVTDl0WWo0aGw1SExvTy9PWkQzcXMrOE1pelhSVDRQUDV3bWln?=
 =?utf-8?B?UkFRMjN0bGlFaGIrYzV5OFEyYXBpSTFKOGJMaTZRTVZSZTFVWE9uV00yZ2ts?=
 =?utf-8?B?WTVML3pBS1pKaXhYSDY5VWhmQWFjWExHNEJqSHRFT000TzRjNHIvUURiSDdJ?=
 =?utf-8?B?Z21QY2NvTGdsTktndWFKNlJwaVQrV1psNDJLZ2MxZEVJY2ZxTDcrQmt3Vjlm?=
 =?utf-8?B?MWJ4clRkRWZvTkgybWI2aXlYcUUrNFlNUURMVVhlcVU2S2V2cGxxRkFBQ09m?=
 =?utf-8?B?ZnBySzg1UDJxSTVBNUFGMDVPczdrSjd2NzdSZUVUWC9TZ0tTZWFqSDd2Njky?=
 =?utf-8?B?dnZUelRtcFRubEZra2xMOVEwdkx4dXhaOUNZdGlKMHh0b1NHZlFpdHFVay82?=
 =?utf-8?B?RjNQeUY2T2Q3N0Z3a3hqVllDMVUyc3VIUTRsOGNsUkNWN3BYOGRJNkN0YUtz?=
 =?utf-8?B?NTFiNzJzUzZaUGpTWUNqdWtzSlJ0amVwQ0pGRlBId3A4QnlVbER1WDhGYmJZ?=
 =?utf-8?B?b3h3UEZUck1aa2F5TTRQOHdqRDEyU055R0luRmNiWWc3aXRzeklCR2sybnY1?=
 =?utf-8?B?VVhlL1krS3IvdjJvSUcxQk5udHpaNHM4QTNtU1BmZlNjWGVIYU81bW9XU1lr?=
 =?utf-8?B?TUhTcnJaWVF3blBxc2c0Lzkxblc1NVRHbFRtdnFqRE1iN1NhUUJOUTd0a3VH?=
 =?utf-8?B?QWtvQ3FPcTF5Y0ZhemFLMnh0aiszK0R2UmdOdGxBT1lCYXRnRmZ2b0tRVzFq?=
 =?utf-8?B?M3N2OFEraC94QVRUT2JPdTNTb2VEVmxWUHVEODIvR2lHaFFidmFBQjBrdU93?=
 =?utf-8?B?bDdwb2gwMTI3bng0ZEF0SHVoSGVTY2o2WFphcDM0bGJxaUw3bUliWTlGZlgv?=
 =?utf-8?B?WWR3SlpTQ2FRLzU1TWwzYnJwRGlNc2FFUUlUb0J4SGM3ZDdUTE51allGR1Fo?=
 =?utf-8?B?K0NCMkdIMHd4b0V3TTVFbU8yWmdzSHRoK0VUR1VMMDdzTmg0MHAwdlhseGpM?=
 =?utf-8?B?WmRqcVdVeDFQeTlORW9URHdrYjJQbnI2dEl0OFVYd043dUpHN3FLQyt6VVdI?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07853ccb-1bb0-4355-bd6f-08db9a90f166
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:32:32.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PMHQGsOmH7FmMB8tL4UX+ZTB0ZxV9MfJIHj+oI+wFmS00LB9WOIhbHbnpYSAqkiuKwIXPJxM9WqT4al6XHfof9u+SbmNNwdG9dbmXPhm0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5609
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/22/2023 12:07 PM, Tony Luck wrote:
> There isn't a simple hardware enumeration to indicate to software that
> a system is running with Sub-NUMA Cluster enabled.
> 
> Compare the number of NUMA nodes with the number of L3 caches to calculate
> the number of Sub-NUMA nodes per L3 cache.
> 
> When Sub-NUMA cluster mode is enabled in BIOS setup the RMID counters
> are distributed equally between the SNC nodes within each socket.
> 
> E.g. if there are 400 RMID counters, and the system is configured with
> two SNC nodes per socket, then RMID counter 0..199 are used on SNC node
> 0 on the socket, and RMID counter 200..399 on SNC node 1.
> 
> A model specific MSR (0xca0) can change the configuration of the RMIDs
> when SNC mode is enabled.
> 
> The MSR controls the interpretation of the RMID field in the
> IA32_PQR_ASSOC MSR so that the appropriate hardware counters
> within the SNC node are updated.
> 
> To read the RMID counters an offset must be used to get data
> from the physical counter associated with the SNC node. As in
> the example above with 400 RMID counters Linux sees only 200
> counters. No special action is needed to read a counter from
> the first SNC node on a socket. But to read a Linux visible
> counter 50 on the second SNC node the kernel must load 250
> into the QM_EVTSEL MSR.
> 
> N.B. this works well for well-behaved NUMA applications that access
> memory predominantly from the local memory node. For applications that
> access memory across multiple nodes it may be necessary for the user
> to read counters for all SNC nodes on a socket and add the values to
> get the actual LLC occupancy or memory bandwidth. Perhaps this isn't
> all that different from applications that span across multiple sockets
> in a legacy system.
> 
> The cache allocation feature still provides the same number of
> bits in a mask to control allocation into the L3 cache. But each
> of those ways has its capacity reduced because the cache is divided
> between the SNC nodes. Adjust the value reported in the resctrl
> "size" file accordingly.
> 
> Mounting the file system with the "mba_MBps" option is disabled
> when SNC mode is enabled. This is because the measurement of bandwidth
> is per SNC node, while the MBA throttling controls are still at
> the L3 cache scope.
> 

I'm counting four logical changes in this changelog. Can they be separate
patches?

> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h                |  2 +
>  arch/x86/include/asm/msr-index.h       |  1 +
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>  arch/x86/kernel/cpu/resctrl/core.c     | 82 +++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 18 +++++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +-
>  6 files changed, 103 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 80a89d171eba..576dc21bd990 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -200,6 +200,8 @@ struct rdt_resource {
>  	bool			cdp_capable;
>  };
>  
> +#define MON_SCOPE_NODE 100
> +

Could you please add a comment to explain what this constant represents
and how it is used?

>  /**
>   * struct resctrl_schema - configuration abilities of a resource presented to
>   *			   user-space
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 3aedae61af4f..4b624a37d64a 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1087,6 +1087,7 @@
>  #define MSR_IA32_QM_CTR			0xc8e
>  #define MSR_IA32_PQR_ASSOC		0xc8f
>  #define MSR_IA32_L3_CBM_BASE		0xc90
> +#define MSR_RMID_SNC_CONFIG		0xca0
>  #define MSR_IA32_L2_CBM_BASE		0xd10
>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 016ef0373c5a..00a330bc5ced 100644
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
> index 0161362b0c3e..1331add347fc 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -16,11 +16,14 @@
>  
>  #define pr_fmt(fmt)	"resctrl: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/mod_devicetable.h>
>  

What does this include provide?

> +#include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/resctrl.h>
>  #include "internal.h"
> @@ -48,6 +51,13 @@ int max_name_width, max_data_width;
>   */
>  bool rdt_alloc_capable;
>  
> +/*
> + * Number of SNC nodes that share each L3 cache.
> + * Default is 1 for systems that do not support
> + * SNC, or have SNC disabled.
> + */
> +int snc_nodes_per_l3_cache = 1;
> +
>  static void
>  mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
>  		struct rdt_resource *r);
> @@ -543,9 +553,16 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
>  	}
>  }
>  
> +static int get_mon_scope_id(int cpu, int scope)
> +{
> +	if (scope == MON_SCOPE_NODE)
> +		return cpu_to_node(cpu);
> +	return get_cpu_cacheinfo_id(cpu, scope);
> +}
> +
>  static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->mon_scope);
> +	int id = get_mon_scope_id(cpu, r->mon_scope);
>  	struct list_head *add_pos = NULL;
>  	struct rdt_hw_mondomain *hw_mondom;
>  	struct rdt_mondomain *d;
> @@ -692,11 +709,28 @@ static void clear_closid_rmid(int cpu)
>  	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
>  }
>  
> +static void snc_remap_rmids(int cpu)
> +{
> +	u64	val;

No need for tab here.

> +
> +	/* Only need to enable once per package */
> +	if (cpumask_first(topology_core_cpumask(cpu)) != cpu)
> +		return;
> +
> +	rdmsrl(MSR_RMID_SNC_CONFIG, val);
> +	val &= ~BIT_ULL(0);
> +	wrmsrl(MSR_RMID_SNC_CONFIG, val);
> +}

Could you please document snc_remap_rmids()
with information on what the bit in the register means
and what the above function does?

> +
>  static int resctrl_online_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
>  
>  	mutex_lock(&rdtgroup_mutex);
> +
> +	if (snc_nodes_per_l3_cache > 1)
> +		snc_remap_rmids(cpu);
> +
>  	for_each_capable_rdt_resource(r)
>  		domain_add_cpu(cpu, r);
>  	/* The cpu is set in default rdtgroup after online. */
> @@ -951,11 +985,57 @@ static __init bool get_rdt_resources(void)
>  	return (rdt_mon_capable || rdt_alloc_capable);
>  }
>  

I think it will help to add a comment like:
"CPUs that support the model specific MSR_RMID_SNC_CONFIG register."

> +static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
> +	{}
> +};
> +
> +/*
> + * There isn't a simple enumeration bit to show whether SNC mode
> + * is enabled. Look at the ratio of number of NUMA nodes to the
> + * number of distinct L3 caches. Take care to skip memory-only nodes.
> + */
> +static __init int get_snc_config(void)
> +{
> +	unsigned long *node_caches;
> +	int mem_only_nodes = 0;
> +	int cpu, node, ret;
> +
> +	if (!x86_match_cpu(snc_cpu_ids))
> +		return 1;
> +
> +	node_caches = kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_caches), GFP_KERNEL);
> +	if (!node_caches)
> +		return 1;
> +
> +	cpus_read_lock();
> +	for_each_node(node) {
> +		cpu = cpumask_first(cpumask_of_node(node));
> +		if (cpu < nr_cpu_ids)
> +			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> +		else
> +			mem_only_nodes++;
> +	}
> +	cpus_read_unlock();

I am not familiar with the numa code at all so please correct me
where I am wrong. I do see that nr_node_ids is initialized with __init code
so it should be accurate at this point. It looks to me like this initialization
assumes that at least one CPU per node will be online at the time it is run.
It is not clear to me that this assumption would always be true. 

> +
> +	ret = (nr_node_ids - mem_only_nodes) / bitmap_weight(node_caches, nr_node_ids);
> +	kfree(node_caches);
> +
> +	if (ret > 1)
> +		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = MON_SCOPE_NODE;
> +
> +	return ret;
> +}
> +
>  static __init void rdt_init_res_defs_intel(void)
>  {
>  	struct rdt_hw_resource *hw_res;
>  	struct rdt_resource *r;
>  
> +	snc_nodes_per_l3_cache = get_snc_config();
> +
>  	for_each_rdt_resource(r) {
>  		hw_res = resctrl_to_arch_res(r);
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 0d9605fccb34..4ca064e62911 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -148,8 +148,18 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
>  
>  static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  {
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int cpu = get_cpu();

I do not think it is necessary to disable preemption here. Also please note that
James is working on changes to not have this code block. Could just smp_processor_id()
do?

> +	int rmid_offset = 0;
>  	u64 msr_val;
>  
> +	/*
> +	 * When SNC mode is on, need to compute the offset to read the
> +	 * physical RMID counter for the node to which this CPU belongs
> +	 */
> +	if (snc_nodes_per_l3_cache > 1)
> +		rmid_offset = (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
> +
>  	/*
>  	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
>  	 * with a valid event code for supported resource type and the bits
> @@ -158,9 +168,11 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
>  	 * are error bits.
>  	 */
> -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> +	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + rmid_offset);
>  	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>  
> +	put_cpu();
> +
>  	if (msr_val & RMID_VAL_ERROR)
>  		return -EIO;
>  	if (msr_val & RMID_VAL_UNAVAIL)

Reinette
