Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FE0786057
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbjHWTIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbjHWTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:07:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C067FE7B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692817669; x=1724353669;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jh5ebtqv+2Cu2wgskvc7jiC1VIKGd/qjQeqYKk+d0ag=;
  b=YfZ8RmRf+/AYvQJjbNkanlDaHT2uvSALNXuqgZJp0bGYEfakl5rZVr1m
   o9G1N5QMQP7I86ULC3SoUHS02YPOI72aY8zPUDpmU6YLNHDAKUaocCx+r
   1IhfyAaVHmUEjrlqhRp85nZ3NjFA6ZgELCGoB75n1dcq9y0tCyGsZG+yC
   kwi9OkLm88bMBz9R48AWxfq8nBTQgj56uy2n2U+hkysJth0v8Hu5PTYsj
   eL6XOvD/R8WrWdNBjdOgk62XvnTOiPQAKfWhbtb0x68bAeD8mD1aH3Kf0
   GvYgIKop5NWWH4Gg/FgsfgSwF3+Kh72ydkNhEJ1piOkW6KWysb2tAcsxK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="359233949"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="359233949"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="771828584"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="771828584"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 23 Aug 2023 12:06:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:06:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:06:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:06:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/LUBEsvCVYWUNzwsK10yoHG3le9RiubdvVUh1Yxo9qJARIyq77Cv16zFqaHsAMSTvWHe807/F6llznpjsLwqvax78rX5tLzko3uoIKRUEhiB/7GtoHOlkbv9iyH+o1CAx+/4LA/lyLJzi9DwBrz+61ii/+BZlZ+z56dLsPQpGX03QhqxF6SxYbM6Tx0LsqfCX9LFle+sw1uNROhkXtO3P/OGWWl1u+pzllwM0ZIRmV9CCbEowNWBkJqtf2pTEHue/8rRk5H1U9ibpd7N/5HjWNS4jQT8O8Dskql0z8FDwR8spshaXYUHfcrDQZoKmCZaljJP1I5bEgqA5MDfk5wgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SDrt9qZVGd5PA59+HQAIJZftRIuWp7waIM+SbbSMeI=;
 b=SqFGBgW8XPLTU0iwXnrX47GvVrkT0/8o1/Bbw/JaiWv3f5qJhyD5gF7zs902AbB0TWutzi67GQoKk18GPrU2Poepkjcn4BnBlCKaIEeI1ik1Z6eeNDM+uhUYD5ITPRO+DqVs392fNC1p2VQ97ZUu8kj+TZRcWhYIr4wHj4BSJx6pdRoDx/k9sRp7RTzEu5fW+H3WY4tTTZmEJytQQzsawF3D+8g3Vu35nxkPbpFZXaTYp/gJZFZuvfkJEVBV0M9z/xsz+tX/EB+A9o74jqmiWVBhBNSzixS8DMuUoGed4x2C25h4jagAoPVNIYu/FyDB1qZjMyjAn+2wiGHNKnt5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Wed, 23 Aug 2023 19:06:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 19:06:49 +0000
Message-ID: <6114c8d0-97a1-be54-3e43-30348be38683@intel.com>
Date:   Wed, 23 Aug 2023 12:06:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
Content-Language: en-US
To:     Amit Singh Tomar <amitsinght@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <f0e10f31-8571-baf6-6665-b077af067777@intel.com>
 <MW4PR18MB5084D5EEBC450BD66E8063E3C61FA@MW4PR18MB5084.namprd18.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW4PR18MB5084D5EEBC450BD66E8063E3C61FA@MW4PR18MB5084.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f6b045-83b4-41ee-72f6-08dba40c1a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaFsk9tTt9bxpJRrgpLk8W0RY+UdDaNYVYap7/A6ki7eZ/c6Od8OSzTjyUpoc1nQQDiTa48le0S6XqbV2M/BPD1E5IyZu6dTD3VCQInKtUNc9IDdLQJFtPdg+CHeu1m3Oatyp5uA5uaVXxB4wlR5mjBv3QNnx8ps70P6bleU2tUsG8D6Y34BEGfKcf4S4yA9yvBQDTmH7Sm+SotCirys2NnRE0/EOx7zDy84+c/2awrLhW9BMx6UOhAsjXrnHArvITSjAWpPZ3J8T167qPOA0NHodEhmokNA7tNB2L3C6aGQHpx+Vuapnk6rIOEt/LqOe/fiJZ2L5HebJc4Vz0kpWteZyazbK9oA3cww0VtkGVCecnXBNadgAhSgUUeaogSrDO5xUofsa73h2oxDjJvrC6I5cDiLYJLbtzn+wyZjTBiEfu6yj/u6QEayb/49P713/fXjnJYxvrsb5wr5rZTtQLyrAu/zFI8uVdrXaJ75+6PyclkehzP2agxpF1oRLXy888Bqsjawc/ANcs7Ve0Vmx2OeBEFv8eTMrpyjd/Zp8yUaahAkINaC/w2I86Sw0U1tn35/VCO60oocHelEtiBqpk9C/9SFSddY5dITCj8e8Gjs01W6F1NkR5Ji8T3eb3Kc7shy1N6T/e6GWqrKW9NCMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(66556008)(66946007)(66476007)(54906003)(110136005)(5660300002)(44832011)(107886003)(2616005)(41300700001)(316002)(2906002)(31696002)(478600001)(86362001)(31686004)(8936002)(4326008)(8676002)(38100700002)(6666004)(6512007)(6506007)(53546011)(82960400001)(6486002)(36756003)(83380400001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWZsS3QrdHFVOXpKYnpXWHhqaHpKcGNVbmErektGOXc5Qy9WbFRSaWo0Q0hX?=
 =?utf-8?B?Q1pydC9NajFHb3FGTUxPSExNOUl3MjUyeVo1NEUyVVAydkxwWFUzV01VbzJv?=
 =?utf-8?B?TGJ5ZnVnemljNWpPSTgrQ1FCZzR4aHlhRjVjWVpEc2RMbEdpZW15RVppRk5x?=
 =?utf-8?B?Z0FodEF2SzJ4bGJpZEEvYWJRZE9BcVlSc2ZNano5am1CREFmem9acktLMGgv?=
 =?utf-8?B?aG9odFpncExCUkkvNlU0enhzUk1zekZYaGdwNjRldGZVdGN3SnczUS84N3hK?=
 =?utf-8?B?YjdqemFqQ2k5b2Nub0o2dW9jbUF5Tm0zZjRlVDhSSTdGcWtBNUwvSy9Fby9h?=
 =?utf-8?B?NTNsQkZZYmJmVkU4R3lxdTB3WmFxN05lR3E1NWNVenB2cGY1UkhkZ1pjU1Na?=
 =?utf-8?B?SHlWL2oyQWd2d29YNzFPVkVJVFdKMmUxZTBwTHdFZTZZRnhHVzczSWJDNlIz?=
 =?utf-8?B?OW1pcDJSbXd6YmR6ZkFJMXgycS94ZVNadzUyWmV3MS84NU5Eb3lFU3E2eml0?=
 =?utf-8?B?ekNqSkppOGFQL0RTRXZmc09HdzM5WWcxMTlwQUJBOXFZbTJkS0l4bVJwd0JN?=
 =?utf-8?B?emNkRDNxbWhic2hGeVQ3ejFIWW4yNlBzR1d6MEp5RGh1SDF1WmxPTTBTZUxO?=
 =?utf-8?B?bk9VUmU0U1JldXZhYjVaWFdwQ2ZPaXdmbzFJdzNLNE1VUmUyN3BpazUrUzE3?=
 =?utf-8?B?RThxd3BxOURPa0V1R2hLWjNtZlZYMDM4Y2trVUxFQjZGdW95aXNyNlptWXh3?=
 =?utf-8?B?bktyeld1VTA1b005bm1LYTZxcjlWK1pYS29SRDdBWEE1Q05JZzQ2aUVZMjBF?=
 =?utf-8?B?dkFCSGg0d0xyVmhqZElEV1NkMnoxcG4yMFdYb2M2T2Z0dXoxOEU3MlFUTkp1?=
 =?utf-8?B?VHdwa0lzM0h4dmtQS3AwVjNLak5ZZUJVelQzOGhxbHNUUUg4NS81V3llME84?=
 =?utf-8?B?NkhTVURtb3lOVjJoLytNWm9tK3dzSnh2SHJRakVBemVVNEhxeGJqWXZNSkZp?=
 =?utf-8?B?VTh5UjRZNjdnZ0IydnlMRTF1VE12SVFMQ1M4VTU5Z0VTeXlyMzlxeGQ1K0Ny?=
 =?utf-8?B?VWIzSm5XZng5cFhjSkxtZENkd212Vk00cnR3N3JjaW5jMEVtNE5VWm1aM2la?=
 =?utf-8?B?ZE8zTkxmSHZ6UEdZd2dBU1FlQWY2dGJNOVF4NGxoaGlkR09LNHZaZXRZYmUw?=
 =?utf-8?B?NVpjWGhZZTBVaTlqcUVLbGxFZklVTXNuMHBQWCtzMU9LdG9SUmlSQ0VJeGxF?=
 =?utf-8?B?VXZXWnZqY0NuOUgwQkh2Umhucm1ZdkJkTC9xZXRDN0VEOERQYXhvV3dHNjMy?=
 =?utf-8?B?S3RFcCtCdmp4NHFFaFBSUGF1VG1KYThCUHdidEx0OVJNRHVldS96ZTA4cjRO?=
 =?utf-8?B?aHQ5QlRwZGloeHZqYWdkSUlqL0VZcFFTTFpXZnZEdGlRVHZ5VEFjS1FpVjV3?=
 =?utf-8?B?L3FjUStlOW1GdG1WdFdIeHhPOVBHNlZHQkUzVnBLeFBXbGgyQjlVempEWnFC?=
 =?utf-8?B?WmFSWUxLVE5QUXorOEdVWUtvZ05PZ3VKU1B5UUtIWUszZlYxMlJwVFQweDEw?=
 =?utf-8?B?YzlIL01PSTlrOC9helI3UXN0clRYaDZKVk1NeExCRW5UOGU3V2dKOWo0OFR2?=
 =?utf-8?B?a1hiek9SOWlHcE1zazlIZVJBdW9aWnRSaWhMOVZjYllmR2dBYm41eDFjTnFw?=
 =?utf-8?B?TzE4bnZEckl6YWROeVVRUGo1WkhxZnNvd2pyS3llOTNvcjh5Szg2WHdzdHZz?=
 =?utf-8?B?Mm1STlVaTUtoSnRVclA3YW1QbUVJam5oV0U0ODFxSHZ6UDJGaEZhYlVJY21w?=
 =?utf-8?B?ZVFmR3B3QUsxdlIyVWdSTThGS0VqdEp3SjlGVklDM0RwaGNENmt6UTBQTWd3?=
 =?utf-8?B?MlpBTmdDM3lMUzAxeVpqYXRORzFzaEdaSHczWW9udUxEQUpIRGtuY2tMSEo0?=
 =?utf-8?B?SEloZE94T1R6VWVQZHc5SW1wY0tDSTNodzdENVEvZmVJbmFLandROHhveWRy?=
 =?utf-8?B?SE56TktYeCtDYXV5WVh5U2pyWkVDbm0vMmZoTVJFVmc2M3lWc3pWMTAxbnE4?=
 =?utf-8?B?SHMydXdhVkRVM1FIYlVjTkJ2VEVJL2NKYVd1V0t6dzJud29tMC9YTlJrZkYx?=
 =?utf-8?B?aXRkMGkwWWY4TDFOd3Z4M015UHNrcjNQREpScDdnbkVEK3kvVG0vc0J5Q25I?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f6b045-83b4-41ee-72f6-08dba40c1a88
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:06:49.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LT+W4w6Nvk6V4cTYZyOoBzkD6E14pBJCrTvUTZFMdbx1219VqL62QnQR4Lpf6V7g3PCsjeIJI9ssC18PuPlhZwUEm24c1TqV1YFisvKrOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6043
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 8/22/2023 5:44 AM, Amit Singh Tomar wrote:
> Hi Reinette,
> 
> Thanks for having a look!
> 
> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com> 
> Sent: Friday, August 18, 2023 12:41 AM
> To: Amit Singh Tomar <amitsinght@marvell.com>; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: fenghua.yu@intel.com; james.morse@arm.com; George Cherian <gcherian@marvell.com>; robh@kernel.org; peternewman@google.com; Luck, Tony <tony.luck@intel.com>
> Subject: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority partitioning control
> 
> External Email
> 
> ----------------------------------------------------------------------
> (+Tony)
> 
> Hi Amit,
> 
> On 8/15/2023 8:27 AM, Amit Singh Tomar wrote:
>> Arm Memory System Resource Partitioning and Monitoring (MPAM) supports 
>> different controls that can be applied to different resources in the 
>> system For instance, an optional priority partitioning control where 
>> priority value is generated from one MSC, propagates over interconnect 
>> to other MSC (known as downstream priority), or can be applied within 
>> an MSC for internal operations.
>>
>> Marvell implementation of ARM MPAM supports priority partitioning 
>> control that allows LLC MSC to generate priority values that gets 
>> propagated (along with read/write request from upstream) to DDR Block. 
>> Within the DDR block the priority values is mapped to different traffic class under DDR QoS strategy.
>> The link[1] gives some idea about DDR QoS strategy, and terms like 
>> LPR, VPR and HPR.
>>
>> Setup priority partitioning control under Resource control
>> ----------------------------------------------------------
>> At present, resource control (resctrl) provides basic interface to 
>> configure/set-up CAT (Cache Allocation Technology) and MBA (Memory Bandwidth Allocation) capabilities.
>> ARM MPAM uses it to support controls like Cache portion partition 
>> (CPOR), and MPAM bandwidth partitioning.
>>
>> As an example, "schemata" file under resource control group contains 
>> information about cache portion bitmaps, and memory bandwidth 
>> allocation, and these are used to configure Cache portion partition (CPOR), and MPAM bandwidth partitioning controls.
>>
>> MB:0=0100
>> L3:0=ffff
>>
>> But resctrl doesn't provide a way to set-up other control that ARM 
>> MPAM provides (For instance, Priority partitioning control as 
>> mentioned above). To support this, James has suggested to use already 
>> existing schemata to be compatible with portable software, and this is 
>> the main idea behind this RFC is to have some kind of discussion on how resctrl can be extended to support priority partitioning control.
>>
>> To support Priority partitioning control, "schemata" file is updated 
>> to accommodate priority field (upon priority partitioning capability 
>> detection), separated from CPBM using delimiter ",".
>>
>> L3:0=ffff,f where f indicates downstream priority max value.
>>
>> These dspri value gets programmed per partition, that can be used to 
>> override QoS value coming from upstream (CPU).
>>
>> RFC patch-set[2] is based on James Morse's MPAM snapshot[3] for 6.2, 
>> and ACPI table is based on DEN0065A_MPAM_ACPI_2.0.
>>
> 
> There are some aspects of this that I think we should be cautious
> about. First, there may inevitably be more properties in the future
> that need to be associated with a resource allocation, these may
> indeed be different between architectures and individual platforms.
> Second, user space need a way to know which properties are supported
> and what valid parameters may be. 
> 
> On a high level I thus understand the goal be to add support for
> assigning a property to a resource allocation with "Priority
> partitioning control" being the first property.

> To that end, I have a few questions:
> * How can this interface be expanded to support more properties with the
>   expectation that a system/architecture may not support all resctrl supported
>   properties?
> [>>] All these new controls ("Priority partitioning is one of them) detected as resource capabilities (via Features Identification Register), and these control will not be probed, if system/architecture
>         doesn't support it. From resource control side, this means that users will never get to know about the controls from schemata file. For instance, the platform that supports Priority partitioning control
>         schemata file looks like:
> 
>        # cat schemata 
>            L3:1=ffff
> 
>         As oppose to when system has Priority partitioning control
>         # cat schemata 
>            L3:1=ffff,f
>

Right, but my question is "How can this interface be expanded ...".
Consider a future L3 resource that has a new and different property
("new_property") that is independent from "Priority partitioning". 
If "L3:1=ffff,f" means "Priority partitioning" == 0xf, how can
a value be assigned to "new_property" if the system's L3 supports
it but not "Priority partitioning"?
If I understand correctly the proposed interface is a positional
interface and "Priority partitioning" is always in second field ...
but a system may or may not support this property so does it require
an empty second field to be able to use other properties?

(fyi ... the quoting used in your response does not make it
obvious what you are responding to)

     
>         
> * Is it possible for support for properties to vary between, for example, different
>   MSCs in the system? From resctrl side it may mean that there would be a resource,
>   for example "L3", with multiple instances, for example, cache with id #0, cache
>   with id#1, etc. but the supported properties or valid values of properties
>   may vary between the instances?
> [>>] This is really implementation dependent but we would expect, if multiple L3 instances
>         across multiple dies implements this control, it should be uniform across, but let's take a case
>         where L3 MSC instance on one socket has this control, and other L3 MSC instance on another 
>         socket doesn't have this control. From resctrl perspective, one would see this control
>         only for L3 instance that has this control, and programmed only for that L3 instance.
> 
>        L3:0=XXXX,X;L3:1=XXXX
> 
>        And as per proposed format:
>    
>        L3:0=XXXX,PPART=X, L3:1=XXXX

I'm a bit lost ... what proposed format?

>        
> * How can user space know that a system supports "Priority partitioning control"?
>   User space needs to know when/if it can attempt to write a priority to the
>   schemata.
> [>>] At the moment, we label only the resource class, and would like to propose we should
>         label newly added controls (under a resource class) as well so that user can easily identify 
>         which control to program. For instance, the schemata file with this proposed changes
>         will look like this:
>         
>         L3:0=XXXX,PPART=X
> 
>        where PPART=Priority partitioning control, Similarly, if L3 resource class has one more capability, say cache capacity partitioning.
> 
>        L3:0=XXXX,PPART=X,CCAP=X
> 
>       Very first control always be CAT/CPOR (with no labels)
>       

Is your response intended to be read from bottom to top?

> * How can user space know what priority values are valid for a particular system?
> [>>] Supported priority values are read from one of the MPAM Priority Partitioning register, and in the
>         Schemata file, it is set to Maximum value just like Cache portion bitmaps or Memory bandwidth allocation.
>         For instance:
>    
>         L3:0=ffff,f, max priority values is f, and user can program/set from 0-15

Doing so would require user space to (a) be running from the
time resctrl is mounted, and (b) maintain state about all
resctrl resources, properties, and supported values.

I think that this is risky and places a burden on user space that
in some scenarios would be impossible to achieve. Consider the
scenario when user space starts running after resctrl has been
in use for a while or if user space loses its state. The
info directory is where information about enabled resources
are located.

>       
> 
>> Test set-up and results:
>> ------------------------
>>
>> The downstream priority value feeds into DRAM controller, and one of 
>> the important thing that it does with this value is to service the 
>> requests sooner (based on the traffic class), hence reducing latency without affecting performance.
> 
> Could you please elaborate here? I expected reduced latency to have a big impact on performance.
> [>>] To be clear, by performance, it meant Memory bandwidth, and with this  specific configuration/test
>        We see priority partitioning as a utility to guarantee lower latency. We are yet to explore its affect
>        On memory bandwidth side.

Please be careful about claims because the above sounds to me as though
this work claims to not affect memory bandwidth but it is also
states that the impact on memory bandwidth has not yet been explored.

Reinette
