Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74987A0BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbjINRbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbjINRbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:31:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1524E1FF0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694712681; x=1726248681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d3n/EeRcWzJoJ5+J1W6vDGIsyPxJg8LslPtM/DbzNVE=;
  b=oIi8HeTm1lX4XwwLWus1Bfqz6GUGZPgr7lHqigBIq5J70Rjydat+bdM/
   4WBwcOwupMsMVgq/+qj7vXgvUb+2iSr3CrNNmTK2WKCSoVvO1OclKwks0
   wDNpEeaPp73K4PJSePSd09BeYSWlxBb3uPziaQGuZBh/m12KLAl/pTXsI
   FmzAOg3YmG1rjVGzFA364uC4RAGfftltX2+HT9/OGYA/NN/0aoeOUhmIG
   LGnl+rXKXscwoVKnbxkJv8UpbXnZjxL4Bdpxh3gX1xZLpkBN06emQlxXC
   gAfhfqRNOAaVnwjFHj2i5CkjqNCIviUgQCxsbdzDiTCotIiBotpSJ9P8U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369322671"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="369322671"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:31:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="773962735"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="773962735"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 10:31:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:31:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 10:31:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 10:31:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIKSjykjsZuRxv35OqwBjkZCjdQFHa/7pi8s1ZTHG6EQLq3PBD1EuA1UnNtH9QgIXMI1c7Vhr5V/iWyXCv7Z7M0N0KpGyeX+p87hg3+jkVXR7p6Sr+20k3q99ackhdAa4ED6oyyJbl9enrDwKvzbnS8Y+znyZn2ij7+fbt1fbRiif4iv3GMM2gJlEjx55xFlgacw5q6RVvEhE+d6QnfLxkQUOIHJUSITfXYhF9xUbwTGTpszx3I4h7B+Hi+S4VaUJx8HGUCfTASQe+D8s80+/4Fg+KT8KeEY3mwFGhgLtpLfGgd2Ty3vztKZsKYw7brBi5SM7QBIZbgeVwRn7YYj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z09VK72ff2i8d/xIiGR1WB96zGs1F5rSWCsN1sh0EAI=;
 b=LsbLPfV0V3VZFQFHQar8V4l37xpfl5RDz7hMiTFvK6xi8JzeSta27/LRcO20ncss/ttZQaywRPecqUCWZebLGVHnsesIcbfpElV6a2WsQgHDz9jNyLEbHfXAhEaqpAgPZqSKf4tzXR4kBfY4020YVkSf1lA8tbn/0M9oUWD1WngluYvTZyjxxasrQAnMplBCL7PN2U1KffXCduit4iP5XBi3aeajSUtFDXH5naTTO0kY7I2nOKrex1iF6P5ZhyXHuVlILJsVtGE4gaUgvO0oWQbHiwJzCp5VAwfUUrm4uVTaQlSVSSlFzf5jm/oehBQ8FXK2h0lLFcuBbotdYpu0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB7325.namprd11.prod.outlook.com (2603:10b6:8:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 14 Sep
 2023 17:31:14 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 17:31:14 +0000
Message-ID: <48c50e4a-fc86-f5ff-f7f6-8c1200286e68@intel.com>
Date:   Thu, 14 Sep 2023 10:31:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH -V3 3/4] acpi, hmat: calculate abstract distance with HMAT
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Yang Shi" <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
References: <20230912082101.342002-1-ying.huang@intel.com>
 <20230912082101.342002-4-ying.huang@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230912082101.342002-4-ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: c7843d36-debe-478c-b7cc-08dbb5486555
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SO83I1suEc7xdHnq5bXH+kEv/B26sF2nhA44p5+f1DDKqINrWWsJteObTRkWkoNdZOt4Vt53/JBeldRHD2Ot6kMoeXvHt+sPIfmctqu8xpxel+su2tOx3oMJUZ62qzkeq4Kw1vhUm2yZO8clTy2QU4ft5SDDnPJFt6SVnZgtQA1UGSIWJ+5pP+P6n06zfNqsoMeFuV5ttLaSPRdy9qLLJEq51UAG+O4ZeNcbmXFqXqpNNUPcZS/XqkIaohwes8H2GaiAfuy7aWYuum7DdbsP2+Db+VN+kSPMSDg3S+Il4LlfYhQMfQSd9+8CnIohgHqPkZ4aejz19bjhU/2jmJJUGIncPQdI/PX4owUa7z+WRHAmxls4pU2BuBXXn7C1wfrK4kCfy8r1lW17DDA168xgYCrUnRCrlzQa0OXvbgBugkXaUq4OTiTfOMT2hol9jQ/Yfrop2/HoSreGD35BPrSGusGn3Ouedqe+bHBIqhjj1RhOppLrjRVcf4GX9fjeM9nv4VAIYL8v1EExxPF4KJEPjR6Rl4EyhZ4K1LD0EGpW23oqhUAd4ei8VMDuNi5dYI2V+WmzIf7tZdm3m2gKLCKwxVz1KbXYA/oacOCMKbCKalc6WaUnQLdE2mOyqgAIIKYWMTr3zkGLFKLyoplaJJ5oIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(186009)(1800799009)(451199024)(2906002)(316002)(41300700001)(26005)(107886003)(7416002)(31686004)(66556008)(66476007)(66946007)(44832011)(478600001)(8936002)(54906003)(8676002)(4326008)(110136005)(30864003)(5660300002)(53546011)(6666004)(6506007)(6486002)(6512007)(36756003)(2616005)(31696002)(38100700002)(83380400001)(82960400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRjRy9hUFJRS0Jja1J6dGNOOFVQZnNEa0dXUzN1N1k3cnJyTW02MTZsbXZ0?=
 =?utf-8?B?WGRLTHJoTStiNDVxU2M5c2hhVmZJeWZQYVZDSGxXV05BYzY0V0lGOS9xMmtz?=
 =?utf-8?B?bGh5Wm5kYmdha3ZLbzcvRW9oaXZFU1VWZnpoRWxqMVkyWHFZT2s5dXdyK215?=
 =?utf-8?B?cnkwamZMU3Z1OXZlUkNrYUI5SjhIdldaaWEyaFZSSjZUSWhrYm90dEhGUDQv?=
 =?utf-8?B?NWhaVTlucm53cGVwak5lWjdqRnZUK3p3YS80NER0N0oyUU8zZU5idGhobElo?=
 =?utf-8?B?UzVQS215V3IwVm1jQnRBeVZYVGE2K3RseWs3STYwTFVjcy9UbDBlNFBnL25B?=
 =?utf-8?B?V05oSHBQdG9qdlU3UUpEQUQzcUcxWWhGWkZiUk9sLzROQ0lzZ3BoaUxmTnJy?=
 =?utf-8?B?YkpmdkY4RmNFdkhQK1ZveGV5ZE9jYmh0TzRWdHFwckZVWUlPYThOMUp4MzUv?=
 =?utf-8?B?dHFCczhaTDYwWW90N2ZSaTRFYy9ySm9SNElMRm5HaHVuV1hUMEpzcnFpaktV?=
 =?utf-8?B?Znl5V3lDWWxHM0N0N2Q4WEVMUGhYREt1RzEzeXN1T0tvL3Yvb3RrTmNIWnlY?=
 =?utf-8?B?YVZtU2R5djZkdmdaYUxMc2ZNOVo0UDA4S2RIZnhsck5pbHN2WVd5Zm1mUytU?=
 =?utf-8?B?S2tYSDBhL1pYWmVzM3dCOTUrVVFSaFNVRUIrVnBxc3EzdnFTSnRPc0taaVht?=
 =?utf-8?B?Qjc5OVNhRW9MVXBzdzJBOUMwODRpaGVMaUtkWlRBeUw3N0JoK3BmUGpQYlp4?=
 =?utf-8?B?TGoyT0JkVnM4V1V6OEpYN2lmc1VHcUUzUmQzRkhKN2NHRmJpT2pXZWNTMFFw?=
 =?utf-8?B?aWZkUE4vUC9oNEdkd0ZESkl3TlhlSDZLN0RNdEFPSE5FUk5ZRlJPeitpQkQv?=
 =?utf-8?B?NWRrRUY3UFZ1RzE4bjdIbGpoTFd0SklEU0NQK2FmbTNRVG5Ea3dqd2xWV0pr?=
 =?utf-8?B?LytwQlIxUjNtTGx2S2pITEk2SzlTN1dxVXByYUtQRHNRSW1aTlhNZHNYWkdO?=
 =?utf-8?B?VllNZnN1b1RCWVBmazJsd0lUYmFzNlEwUzVpVlBzKzNUZDBpb2tRUU5kVldv?=
 =?utf-8?B?Tk82NThFUFJxUGkxN21pL20zeUY5Y002dTN4YVVWRU5DVVZxWUFsL2FreDFI?=
 =?utf-8?B?WFdKNU4rbG0rYkVUdWhreXc3YTI5Y2k4cVlFRlU4aHdYNld5SFFDeVhWRUdo?=
 =?utf-8?B?Nk9lL3JIa1BHaFRRTUVOMmorVzBXTWxWMDF3Q25zQXFrcWt5bEpGQ1prTlJU?=
 =?utf-8?B?T2p6YjFxdGREYjkwc0RoOWxjaWpWMCtPQ0o3Y0prV1ZHdCtrUFFBQkdpa0dO?=
 =?utf-8?B?anU1c2ZuV2U2WGZQbU9HdEhYWXlIbmJVODVKNGtvSHdmVmxrZ3VpQUNSazN6?=
 =?utf-8?B?b0tISmlnM0g3NzRKNDNUTXBvbHBsQVF3VDY4UENYdlBBT2xiYmxmL0lNOXc2?=
 =?utf-8?B?WmFRVmtTYnBtcGhPMjBVN1pGazNqRnJlbW03UW5VQ2hrL1pZWnJjQ2p1dnRo?=
 =?utf-8?B?VUV2aXV6S0pqcGg3SHhESDdEbGJLRlhWYTRPUTdYZkJFM3VsUzJqQk8vWjRz?=
 =?utf-8?B?MG51WmVrMUxXbDNtdjdiZEdlb1FyZ0NyMEo5WW1MQTNvOERvRUNLYTFheHRN?=
 =?utf-8?B?WU1saW1WdDdsMlc3RmtVaUNJb0FJWE9YbkkreElQaUtqVEsrNERPZDZ6N3NR?=
 =?utf-8?B?YlFaUkFaWE1rc21JTUpyWE80OTFSTnVHMEl3Vjl4dVhjUzRNOVdIMU5kY3Nj?=
 =?utf-8?B?QkhZQ1F6Y0w3YU5kYjMxSklUSjVadGJUWllXQXFDTTJES3kzQ1d4MGlBMnVX?=
 =?utf-8?B?cGoyejd3bFdBbzJPa3RGUGFPQnhjdXBLZjZEQ0NHS1ZqRm9aV1ZvdG9xU2Nl?=
 =?utf-8?B?aVhpc3VQVkYvU0xjSkFHZXhiODVNeXdvcndlYm8yem5wOE5tVGlqajZMREV3?=
 =?utf-8?B?SWgxUko0Rkd1ZjdLeWJzMDRkanRnYXVQa09LcGtzRDJXcjB3Z2xUa0l5K0x1?=
 =?utf-8?B?ejM1UHBxYmY4UTJydlVzZEdUV0xKMjRIN2QrMTRQTEl4NUoxV294QUozNzlY?=
 =?utf-8?B?Q3NQUG5ldmN2YlNsc21FV1R2MHdOZm9Ob0hkVVNHSXZTeEpZMmQrU3lTZ1R3?=
 =?utf-8?Q?gjHbl1ulpwjhbVEpwm/HIvykI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7843d36-debe-478c-b7cc-08dbb5486555
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:31:14.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyiRt5HdmQDwtbhb1R7Im8AwStAS7B2rBFlOuh8rhl2dTaBjxy3EVl0PiF50cVw1uqE/LhlT1V9INYQx/lGGFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7325
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/23 01:21, Huang Ying wrote:
> A memory tiering abstract distance calculation algorithm based on ACPI
> HMAT is implemented.  The basic idea is as follows.
> 
> The performance attributes of system default DRAM nodes are recorded
> as the base line.  Whose abstract distance is MEMTIER_ADISTANCE_DRAM.
> Then, the ratio of the abstract distance of a memory node (target) to
> MEMTIER_ADISTANCE_DRAM is scaled based on the ratio of the performance
> attributes of the node to that of the default DRAM nodes.
> 
> The functions to record the read/write latency/bandwidth of the
> default DRAM nodes and calculate abstract distance according to
> read/write latency/bandwidth ratio will be used by CXL CDAT (Coherent
> Device Attribute Table) and other memory device drivers.  So, they are
> put in memory-tiers.c.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Tested-by: Bharata B Rao <bharata@amd.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/acpi/numa/hmat.c     |  62 ++++++++++++++++++++-
>  include/linux/memory-tiers.h |  18 ++++++
>  mm/memory-tiers.c            | 103 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 181 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2dee0098f1a9..64c0810d324b 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -24,6 +24,7 @@
>  #include <linux/node.h>
>  #include <linux/sysfs.h>
>  #include <linux/dax.h>
> +#include <linux/memory-tiers.h>
>  
>  static u8 hmat_revision;
>  static int hmat_disable __initdata;
> @@ -759,6 +760,61 @@ static int hmat_callback(struct notifier_block *self,
>  	return NOTIFY_OK;
>  }
>  
> +static int hmat_set_default_dram_perf(void)
> +{
> +	int rc;
> +	int nid, pxm;
> +	struct memory_target *target;
> +	struct node_hmem_attrs *attrs;
> +
> +	if (!default_dram_type)
> +		return -EIO;
> +
> +	for_each_node_mask(nid, default_dram_type->nodes) {
> +		pxm = node_to_pxm(nid);
> +		target = find_mem_target(pxm);
> +		if (!target)
> +			continue;
> +		attrs = &target->hmem_attrs[1];
> +		rc = mt_set_default_dram_perf(nid, attrs, "ACPI HMAT");
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hmat_calculate_adistance(struct notifier_block *self,
> +				    unsigned long nid, void *data)
> +{
> +	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
> +	struct memory_target *target;
> +	struct node_hmem_attrs *perf;
> +	int *adist = data;
> +	int pxm;
> +
> +	pxm = node_to_pxm(nid);
> +	target = find_mem_target(pxm);
> +	if (!target)
> +		return NOTIFY_OK;
> +
> +	mutex_lock(&target_lock);
> +	hmat_update_target_attrs(target, p_nodes, 1);
> +	mutex_unlock(&target_lock);
> +
> +	perf = &target->hmem_attrs[1];
> +
> +	if (mt_perf_to_adistance(perf, adist))
> +		return NOTIFY_OK;
> +
> +	return NOTIFY_STOP;
> +}
> +
> +static struct notifier_block hmat_adist_nb __meminitdata = {
> +	.notifier_call = hmat_calculate_adistance,
> +	.priority = 100,
> +};
> +
>  static __init void hmat_free_structures(void)
>  {
>  	struct memory_target *target, *tnext;
> @@ -801,6 +857,7 @@ static __init int hmat_init(void)
>  	struct acpi_table_header *tbl;
>  	enum acpi_hmat_type i;
>  	acpi_status status;
> +	int usage;
>  
>  	if (srat_disabled() || hmat_disable)
>  		return 0;
> @@ -841,7 +898,10 @@ static __init int hmat_init(void)
>  	hmat_register_targets();
>  
>  	/* Keep the table and structures if the notifier may use them */
> -	if (!hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
> +	usage = !hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI);
> +	if (!hmat_set_default_dram_perf())
> +		usage += !register_mt_adistance_algorithm(&hmat_adist_nb);
> +	if (usage)
>  		return 0;
>  out_put:
>  	hmat_free_structures();
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index c8382220cced..9d27ca3b143e 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -31,8 +31,11 @@ struct memory_dev_type {
>  	struct kref kref;
>  };
>  
> +struct node_hmem_attrs;
> +
>  #ifdef CONFIG_NUMA
>  extern bool numa_demotion_enabled;
> +extern struct memory_dev_type *default_dram_type;
>  struct memory_dev_type *alloc_memory_type(int adistance);
>  void put_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
> @@ -40,6 +43,9 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype);
>  int register_mt_adistance_algorithm(struct notifier_block *nb);
>  int unregister_mt_adistance_algorithm(struct notifier_block *nb);
>  int mt_calc_adistance(int node, int *adist);
> +int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
> +			     const char *source);
> +int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -64,6 +70,7 @@ static inline bool node_is_toptier(int node)
>  #else
>  
>  #define numa_demotion_enabled	false
> +#define default_dram_type	NULL
>  /*
>   * CONFIG_NUMA implementation returns non NULL error.
>   */
> @@ -116,5 +123,16 @@ static inline int mt_calc_adistance(int node, int *adist)
>  {
>  	return NOTIFY_DONE;
>  }
> +
> +static inline int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
> +					   const char *source)
> +{
> +	return -EIO;
> +}
> +
> +static inline int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist)
> +{
> +	return -EIO;
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 76c0ad47a5ad..fa1a8b418f9a 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -37,7 +37,7 @@ struct node_memory_type_map {
>  static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
> -static struct memory_dev_type *default_dram_type;
> +struct memory_dev_type *default_dram_type;
>  
>  static struct bus_type memory_tier_subsys = {
>  	.name = "memory_tiering",
> @@ -108,6 +108,11 @@ static struct demotion_nodes *node_demotion __read_mostly;
>  
>  static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
>  
> +static bool default_dram_perf_error;
> +static struct node_hmem_attrs default_dram_perf;
> +static int default_dram_perf_ref_nid = NUMA_NO_NODE;
> +static const char *default_dram_perf_ref_source;
> +
>  static inline struct memory_tier *to_memory_tier(struct device *device)
>  {
>  	return container_of(device, struct memory_tier, dev);
> @@ -595,6 +600,102 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  }
>  EXPORT_SYMBOL_GPL(clear_node_memory_type);
>  
> +static void dump_hmem_attrs(struct node_hmem_attrs *attrs, const char *prefix)
> +{
> +	pr_info(
> +"%sread_latency: %u, write_latency: %u, read_bandwidth: %u, write_bandwidth: %u\n",
> +		prefix, attrs->read_latency, attrs->write_latency,
> +		attrs->read_bandwidth, attrs->write_bandwidth);
> +}
> +
> +int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
> +			     const char *source)
> +{
> +	int rc = 0;
> +
> +	mutex_lock(&memory_tier_lock);
> +	if (default_dram_perf_error) {
> +		rc = -EIO;
> +		goto out;
> +	}
> +
> +	if (perf->read_latency + perf->write_latency == 0 ||
> +	    perf->read_bandwidth + perf->write_bandwidth == 0) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
> +		default_dram_perf = *perf;
> +		default_dram_perf_ref_nid = nid;
> +		default_dram_perf_ref_source = kstrdup(source, GFP_KERNEL);
> +		goto out;
> +	}
> +
> +	/*
> +	 * The performance of all default DRAM nodes is expected to be
> +	 * same (that is, the variation is less than 10%).  And it
> +	 * will be used as base to calculate the abstract distance of
> +	 * other memory nodes.
> +	 */
> +	if (abs(perf->read_latency - default_dram_perf.read_latency) * 10 >
> +	    default_dram_perf.read_latency ||
> +	    abs(perf->write_latency - default_dram_perf.write_latency) * 10 >
> +	    default_dram_perf.write_latency ||
> +	    abs(perf->read_bandwidth - default_dram_perf.read_bandwidth) * 10 >
> +	    default_dram_perf.read_bandwidth ||
> +	    abs(perf->write_bandwidth - default_dram_perf.write_bandwidth) * 10 >
> +	    default_dram_perf.write_bandwidth) {
> +		pr_info(
> +"memory-tiers: the performance of DRAM node %d mismatches that of the reference\n"
> +"DRAM node %d.\n", nid, default_dram_perf_ref_nid);
> +		pr_info("  performance of reference DRAM node %d:\n",
> +			default_dram_perf_ref_nid);
> +		dump_hmem_attrs(&default_dram_perf, "    ");
> +		pr_info("  performance of DRAM node %d:\n", nid);
> +		dump_hmem_attrs(perf, "    ");
> +		pr_info(
> +"  disable default DRAM node performance based abstract distance algorithm.\n");
> +		default_dram_perf_error = true;
> +		rc = -EINVAL;
> +	}
> +
> +out:
> +	mutex_unlock(&memory_tier_lock);
> +	return rc;
> +}
> +
> +int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist)
> +{
> +	if (default_dram_perf_error)
> +		return -EIO;
> +
> +	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
> +		return -ENOENT;
> +
> +	if (perf->read_latency + perf->write_latency == 0 ||
> +	    perf->read_bandwidth + perf->write_bandwidth == 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&memory_tier_lock);
> +	/*
> +	 * The abstract distance of a memory node is in direct proportion to
> +	 * its memory latency (read + write) and inversely proportional to its
> +	 * memory bandwidth (read + write).  The abstract distance, memory
> +	 * latency, and memory bandwidth of the default DRAM nodes are used as
> +	 * the base.
> +	 */
> +	*adist = MEMTIER_ADISTANCE_DRAM *
> +		(perf->read_latency + perf->write_latency) /
> +		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
> +		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
> +		(perf->read_bandwidth + perf->write_bandwidth);
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
> +
>  /**
>   * register_mt_adistance_algorithm() - Register memory tiering abstract distance algorithm
>   * @nb: The notifier block which describe the algorithm
