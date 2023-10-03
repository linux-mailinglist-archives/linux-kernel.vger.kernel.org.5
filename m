Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0347B732F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241183AbjJCVSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjJCVSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:18:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8445083
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367888; x=1727903888;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EL64EuvG4HV43bE5FYSR/HUEYzej9gD5q51FImP4WJ0=;
  b=EWdXkr1ds2O8eT/cAwEOcae10tNPi59ZE0PJkyduTLC1Q6Rgr8zMhymj
   aEQ4LgML7lKArXiY3jcFgK9iYvxGZPJK/iwRZbAbGoMVy1linK46FeQSh
   19BTEqT9u4xNrscVwbQg9kugiz685HGvQ/TFlHJJ2kOwX+chDveDHc/3V
   EVbV503KDCR6Mi0td8qfuj01yqLgMcBhXCYtvk0KowTD/etps84zxy2qd
   QkvgsnJV6hhINg96J5QYLQjNDXlv88dY/QPQXGINysZE5CjdggoRWdCP4
   ORDHi5g/VbqeRa5/72Q0DcTJWCmN3qZ8Lg/lnzfPnQfcRgzaKKx2vLi6b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1576888"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1576888"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841505117"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="841505117"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:18:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:18:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:18:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:17:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:17:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLpFOQ/nCEh/5dipVK9O3gIqt+FQQlq4HqeGdp3hzgRApi4hDiQvQlX6+F881rQ+DqtDhEZ7lXxjNr0Q0WLOozXEZPlKkfprfT/WavX1U4/9AXtC//xlWYLPtTclsTqaJQo0Iq4l0j2x2dQw4fm33ixKD+c7CDe8V+RLNUMJRPnkuOHZcogKUTu70hnFjVVdZ7enwn88/l570QfoD0dQgfMxHkrfo20FssFb8IWa1clQILqFgPZ6scmanPHrIK9VC6JObTUfUQwEuduPHJlwnD8XLJ1s6O5hd39dTd5qVKcTuoqY7ujNNXSut1+cExQBjbDqUtINpkOwVLZ4JMVnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPKbIDuFEu6CecvCbKTNfV09gmzegrwKjNMvTP6OW1A=;
 b=QfC2MKvPF18L4XAYdvfZ1QM7hZzfRj8RyJW4IlldYy0aiMMR/+Cgqtx0mhrbK+n/eyWAgxVLTAFKSICEyAVxyU+qpABVFNyZxOYIhl95n0REhugzg5BBspXUE4j1PKfi05TioDEmoSpXHvdziEu/4GKxAdCMupO22E1QtwWYJLuk2ltxIKGwQtHVIQIl471bYxmAb1gNmfVb04aPjN0brJMVFmKdQhsqAOatUsLCDi5O1UnXSM2YaB9fjs/dSMUtFZHWSBEI/PykbOZ/FrUFeqq4K98tauPitnrLLEvyB/gzvN/URD8JnDt7Fqc90slKPMfQLCJxd3lWgP6MV89XKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 21:17:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:17:55 +0000
Message-ID: <57554be0-5be8-ee03-a9dc-88deaac43453@intel.com>
Date:   Tue, 3 Oct 2023 14:17:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 13/24] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
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
 <20230914172138.11977-14-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-14-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0220.namprd04.prod.outlook.com
 (2603:10b6:303:87::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b28cd46-7d08-47ba-8495-08dbc45635c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvLUG+lmC5x3VqrSnwK16MCQsdtMoh+g0Ep4ZTK+uwWF6l0zMsOteksXu599YKi2NwUImZOETdlbEZYSMLPuyJOLLC6KGHhuAR6Ltk1Gd1oZqolpcpVjWXqEeqhEmkCPWJd9axMkt856B/bz8rJKf3xBGgpoopSo/GlWuow4xe0sFw6AsE7BJjjoU3S0wDKwxsRwL/djW7ulooMLJ3ZawMxn7Z4erdP4z2xvdMxZHhB8gTmrXFaC0wMUFuRY/w/M9RKHgoVGSwbLC9DuX8Eol9iGVC7SZZ3p0917Byy9WtE8r4UiPtMCTBjqIWvUG71jAKfEwH3e39eat7amqns2x5+283H+HNnQogljnXiNu6nSxI0kHnZdoFQyj2TjWsnIkBmih+4d+BE7FvbS5hP5rlK+KzGtbi37gL0EWe3iwNHhFbNFh81fNkt/ef9EjqIqoLfvzY0mt8zRfRg0bOZjv3jbKgziexKlvvihp2AfsYZafImCuZaYoieOvQZ4ZFscLqOTRbCVynuvE1tnQw32XRUn4q+lq/evpbY/OFLT7CZL+KT57tC4X6LCdouuvknid+3wbYnpeqcIYvDNUcxwbHI5TwiuSnDmwUfA0QDGZFJBh+Ymk9DZFkIivJjsxtFSQBaobtwqV1AZqF9yKeH5tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(66946007)(8936002)(44832011)(5660300002)(54906003)(4326008)(66476007)(66556008)(8676002)(41300700001)(6486002)(6512007)(478600001)(53546011)(31686004)(7416002)(6666004)(6506007)(26005)(2616005)(316002)(83380400001)(82960400001)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmFLMTJvMWZyNmFtSkM1cXFKNm9HUy9pQVNZOHlBUmxrMzNXVFlZQm5mVmpw?=
 =?utf-8?B?TjBwZmlQalNwTzUxekNBcW02aGI5MHgzaGxaVklQSkxNc0JsWEJEc0lIM2lI?=
 =?utf-8?B?Ujh2b3Jhb2VmY3lJMlozaC9OdmhPRnJRdWFCOTlGYkdObVVjMDJXa3B2dkgw?=
 =?utf-8?B?UTMrS3FIZlMyUW5CNVJyc1BLT2x4SE9oM0UxQVVoTUQvUkVIMGtSaytCZmdv?=
 =?utf-8?B?Ly9pZWtkd1YrTTJWY3dzQlJLdTEraHlaV25CUUxWenFWL2RZekdTUTlpK2FE?=
 =?utf-8?B?UVU1WWcweGx1c0hLOUkrM1FBYm9DRzgzMGNucE9STmhmblJYL0pGSW5JMGJk?=
 =?utf-8?B?Z1FsY3FWTmM5aDRvVDViSTh6eHZYRGI4TW01UFM3TTkzVGpQb29uR3JTL3lG?=
 =?utf-8?B?QWZMSTFpVE9FQmNtNUc3MU5HM2I1ZzJjV0YwKyt6ME9hZXo3THVVQUMwRkpu?=
 =?utf-8?B?em1KM3hRT2p4ZDVTUDRIMHhqQjdkWTl3Z0VVQ0k1bGsyM0tvWW1KNWZCRlp5?=
 =?utf-8?B?Zmdnc2c1ZElqZ0VlaWh2ZDRUeWI0R210ZThkRzRoN0ViNlR2YVlvTUx6YVFJ?=
 =?utf-8?B?Tjlvc1FSU29HZlNmZlhQUEdEeStXYXRzZ3NvWHJrb0JNWnFzUGxiMkJWVnNK?=
 =?utf-8?B?RWpzRHFjL3N4K2ZTVjlkcjlkR09Yb1lrOEladnpLMXdMR3BEYVllbGR6dm1V?=
 =?utf-8?B?TE9tZDZVV0kzZWhCOUx0MjQ4Y2xFUTU1MVl1UnZMREh3ODBtMTVwM2Y4SklN?=
 =?utf-8?B?cFQ2N3VlSE5LN1pwRnhiZmdCRGdRLzhVaXhWMUpUUXlwd0RQNHBwbG96cDll?=
 =?utf-8?B?ekFSYnlSbUFuKzh3STRtTjdwcFMyeUM5T3pmcEtWVloxL3prck9LbDZDeGRB?=
 =?utf-8?B?NVFmUEJzZTNlM084bEpRUVBhdWo3N3BhMWtQNXpEVjdlMU5JdmtweTA3VTVY?=
 =?utf-8?B?RlFxWWUzTjdCRStqODBFenVQM1FmSWcwL2U1bi85OWhJUjh2TDUyUmNURlQw?=
 =?utf-8?B?SlNOSS9JcVMzUVl0WGVqN09MV1B3TzNrQUc2ZU95RTgwSnlscDdicldKek1s?=
 =?utf-8?B?WXNZd1h0elF6UE9JUTJ5SVVqL1BDMU8zdXBJVjdSUlFuQ1E5Ynk0c1Zjd2Vs?=
 =?utf-8?B?WHM0cWNWaHgyVEorYkxXa2NBOWVMNGlwdVJBdkFSRzI5REN6OHNQbnBvOTJW?=
 =?utf-8?B?UmMvUUNzTFN2cnlCaU1TQ2FWdXUxYTZkSXJWR3hXZVVzSXBQbERzRVV5R0Jv?=
 =?utf-8?B?eTlEOThsa29DOHdLTGpDYk9venIzREZkZTFONjI3QWtXVFZBWEhTZXV2SzJm?=
 =?utf-8?B?ak1NZ1J2V3lxYTdCSU1LdnVreE8vc09DbHNZZEw1RU9aMkxFU09HVUtId29Z?=
 =?utf-8?B?a3RqMXBXakE4ZGhGVjRqY2tnWW96RURrSzRudG40OXZyd3R3bGQzbmhZZ1hV?=
 =?utf-8?B?bkhQNE1zbUhJSlh5eVJDNzVuQ1JEdUNybC9XOWNUbldsem16dFdQdEV5bEJV?=
 =?utf-8?B?UUMzRzdWY1g4S25sYUhoNXpheTRGVTJMQnBTOFNJVTEwdjRoZ2VYbHJxWmxZ?=
 =?utf-8?B?UDZIYUg5THBvaUE1cW1OWS8wRlVkZTYrNyszU2tpUDVZZmJvaGxkSHVSOXJ5?=
 =?utf-8?B?eEs0Z0NJMmhDU2hhWFIzZ0dHaGV3Z2JobTF4T1crU1ByZWpCSjZHdm9WVm5R?=
 =?utf-8?B?MmxhNDVWSXczU1lWdE84KzhPVkxUYWJkbzA1UGl0TERBUThBOGp0VVFxdGZB?=
 =?utf-8?B?WFNaMzg1Nkh3SXpsajdaOHdkdEV4Z3Z1eWRNVWhFS2FaQ05rbDlNZUlERTBP?=
 =?utf-8?B?dGFpVFZQN2FDVUpLM09JUlRrelhnM2dLR0JadXhsUENucmVMS3JNWEY0enNF?=
 =?utf-8?B?dWNEMmIxbjN4ZzQzSlIzSnhRV0ZMbVRYbVlPZjV4S3RxRUtWRVpFeks2K0xD?=
 =?utf-8?B?aFM1Zlh2Vnh0eXJJNVRnRU56NmQ2bzV1c3Q1WlZyQVdPSDNtNDFtaWFDTlJE?=
 =?utf-8?B?ZXBwZHY2Z1pGaW96c1YvZG1hdWY3Y0w3SjdGZmpaMHk3R2l5NWVRRmRta3BV?=
 =?utf-8?B?cEwraWF6Qks5cHRNcjVPdDlyVVRsZU5OMjdVQXJQRmJoallxMUdteExkUVZW?=
 =?utf-8?B?Vk42dzNZcHNOS2NOTTJMWEdPS0J5Y2locFpFeGdEalQzOG5uUFFBVG9Sd0hz?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b28cd46-7d08-47ba-8495-08dbc45635c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:17:55.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKVTftuAzXbg+WDApkUsTTo3u+/sTdwrmdyQbeMSHx9kc+42fy6SD10h1sk1bmlSLa+D53Bmq9D0mZX3tCqgSIrLGscs3MpPxPDf/Hxg0sc=
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

...
 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index b44c487727d4..bd263b9a0abd 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -19,6 +19,7 @@
>  #include <linux/kernfs.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> +#include <linux/tick.h>
>  #include "internal.h"
>  

Please keep the empty line between groups of header files.

>  /*
> @@ -520,12 +521,24 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int smp_mon_event_count(void *arg)
> +{
> +	mon_event_count(arg);
> +
> +	return 0;
> +}
> +
>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first)
>  {
> +	int cpu;
> +
> +	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */

This comment is not accurate at this point. It should accompany the code it applies to.

> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>  	/*
> -	 * setup the parameters to send to the IPI to read the data.
> +	 * Setup the parameters to pass to mon_event_count() to read the data.
>  	 */
>  	rr->rgrp = rdtgrp;
>  	rr->evtid = evtid;


Reinette
