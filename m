Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3877C5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjHOCh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjHOChj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:37:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20C1980
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692067052; x=1723603052;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eiAfC1orDP2SJFLtIRRPteU10bcxS37vnT8mn6NixbI=;
  b=MlFBoeVh4vBeU8z/k34y1XxoBg6ng3lD7GuzWa1XJW5z/4PVicRy4E8e
   9GBoI32+LWTstcHl0LibU2cpQ9/OFaDwsvqK0BK0um07jgQ9H1Rw+ieyt
   tz1h/ryQ4tkoJT/vdJVyRkCq81FwDQETtlfl4HdziT5C4e4eiOViTM0as
   +LTu9ORSoIZ/WE/+1rKo8CHDqpttvzQZHFBK3tU9WUXiZcHfAN1kSx/3r
   jPDZLX5rtgGcxL3SmIxk2n/fN+cnUYENymBE7YUxDDBeFBxj7R4Ygrtu1
   u2RtLQGpFn4bzVZJL8tkPy/T2Gddy4ifqsyxA/pqXhRgT79+hc8dFv5wz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372180519"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="372180519"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 19:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803657645"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="803657645"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2023 19:37:31 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 19:37:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 19:37:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 19:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ/iFQt6qvoXMnJ1RUmAv2BH7r2Z5LWvQNnx7cXxRRKRdQG0tczFDyFoDLpMAzHahVbT3id+qvu9qQe89Y+00/6hQ8yzFFdVSjdZG3u+oKyuf9ySqpWPtXRgpYdWF2/UmpffbGB+7CDbrf6CnBhSa2NMz/51UgJedxjNjKYgfUNdmeplLoN3R2nAgM71yd3FfLJ6xXmKN/jz1buhJMROJsuVk26tdpQiuzUKLNg1GfGObIIj4kajl4s+GDhegvjQOTzrb9UWF4EXIrzR98WS+/YEL7QTdudVFQm/XnOmNiZ72cpcldt30Wj1+BKxexeHQIjbWdPyZdJqPy+aQpyLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptwfzmhigJrncE5L6y8iYq43rBFuqxPQDktE9fKehjs=;
 b=FvDwRpoFO+TXOd3RRz0sKuV//EW1FQ14yR2gCiHfx0+mG6krExI/h1KrJA9e2hgDPBhKICy6MZ2CN68kUwDSGvhwt1bG3W4iiJQykY4MML3G7b5i+h1+vr4Pwm0CSdTuASabJ2uLfaM0SNcd/AE+d/e/a/4pcBQ4harcUbOA0NSi2znL2tTYGmxcq4Q8kgsuT8MQaXLnKYEj8SJoKV3Kpbwym8BWCjTSCB/dXUJiXmd/lSWQRvAYGerlGFhsPQB0qf/mmAE+Mzz7VAeX9aSXANRXPyZ9ryct9dLoiE0a0Ygss8dmT5qR/BQvQ/HETSB4ONjjVOXN/poMqjglcdHhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MN0PR11MB6277.namprd11.prod.outlook.com (2603:10b6:208:3c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 02:37:26 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 02:37:26 +0000
Message-ID: <4d8773f7-4219-0bc5-e7df-1be81cba05e7@intel.com>
Date:   Mon, 14 Aug 2023 19:37:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 06/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-7-james.morse@arm.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230728164254.27562-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MN0PR11MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 685f4b2b-3809-4c4b-9b63-08db9d38900b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T74O0Vmp26GxmEr4zV0edyDdBxQCUbEh9e2pQJgKIGliqTzR8oONvseaK8gxUAmkfTxQoDs9+8x0xB1l9H9Y8jI1UJ9aYFuya6BMBat94WUYY9NjaYA1d2LNz0IIO5usxdwUNfJfhjJR4mf/v9aOpid+79SqYoT+9NibyKqiFuefdNbNFVYzoBSeulDFD9E5AiS13sxhMI5p46ZI/evduO74OcJir947O+zuDlgS8kBKYOxj4myjPNJlJf/aXh3uxE9WHEU/I2wGlx5TWbYNXzNH9i1pITA+1PQQ9S7wxJVO280GL7xI2cTOcUFoORcfEYu0Fj3WVkIRtC50DmJKEfLp0/sjbaiYjEvxpIHx1kkfU409eb1Px+EH/8xl4CEgggq0e4nrPf4CGHvTnqjphz0g84Dil19H6idycw1TJNJzCbFYModucWNJEHHgIdh/zl0WwRW67ZjSCML5sTnmoTBtw5LZRK+nWZ2coFy3fLIT/jCWPLy6DA+jQfqaZnvXJE/d8OO+ddBpfuCwivrbO6/To+2NsBmKvmsHwcKyZV6xM4ZVe+S7zTwMkg2dT6bJr0W2AqFlfXuVprbw25GozGhindTaYmiS8iroQiAwZ7UgqDYde/g9Vvl8L4OEOyWkQQUU8hwgLLhR+S2UaGL7nl+n3QqGWn1K+9RhY/pirlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(186006)(1800799006)(36756003)(5660300002)(7416002)(44832011)(2906002)(31696002)(86362001)(31686004)(83380400001)(66556008)(4326008)(66476007)(54906003)(38100700002)(66946007)(41300700001)(316002)(26005)(2616005)(6512007)(6486002)(53546011)(6506007)(6666004)(8936002)(8676002)(478600001)(82960400001)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGx2SDBrTSt2YU93Q2t4TEg3bkRONTVraCtwTnhLOGFTYVZqSHhzM3VlSHM4?=
 =?utf-8?B?UExRbHlHa3NwWmVWWXp4bFpFN1JpdkhQYU9FWXF0VTAzRHR5UWRzRld0L09u?=
 =?utf-8?B?eDAyaXNrazRDOG9qalorRmhtRHBzVGE0QWp0SHY2WXpIWU1xb2tMbnNTYVZ2?=
 =?utf-8?B?ekxuNE90a1ZQelUyQUJQS3RTemQrQmdNYlpvNVZWZE5oZUFpa1FqMjNObVpF?=
 =?utf-8?B?TzcrUzF5Z3JoY2dYV0VBSUpsWkUxalFCcUZ3VS9WL1hSYmZhK2FJSVM5aExJ?=
 =?utf-8?B?bkVIai9XWlNQZzRyUDNCWTZMYmRFZXNZUjFYSGxBV3IrTkdxUDhudG1LbmpE?=
 =?utf-8?B?SVoxMURqMGl1TW1BR1FNcmd1L3h5R29YNGJ4S1lrQVlISHV1Z2lHN1ROaWJC?=
 =?utf-8?B?TFM3aXpSc3JnNVJiRVNrM2o1Q1A1SEdQMkEybDdhakFjc05vQTltaGhEbnhH?=
 =?utf-8?B?MTJOQXcxeWFzVEZhOEc5bzZwVWVUSVBVZE42UEt1bVAwU0NsVWhsKzlwV3Fu?=
 =?utf-8?B?VUNaYmNIWmJwdWFvdU94T3JVamUxemNTQ1ZNQUFDUys3emJMUGlqYkV0dUVl?=
 =?utf-8?B?Z2RQd0Yrb1FOd2x0OFFpaGI3c3c4bFpvcEdveTZGUU5LeDI4bi92TUNjZ1hv?=
 =?utf-8?B?c0twbnhiS0FUVXJVSHl1ZWFkbThCMU1yNnV1YVV1cm9NR2F0U056akFHWExu?=
 =?utf-8?B?OUNHSC9JQjZGZ3RmYzcrcVhoTnZZZVgwbitmVloxTUpPMDAyRDdNVldPVzJQ?=
 =?utf-8?B?b0doZml6MTk0RTZyaGlQbUhZY3NvSHJ3UmhhemFXSGdkdzZZclRYc2xXSyti?=
 =?utf-8?B?T0swcTVvTkY0Yi9IWDdvR1Z5YXJETnlrWlhwMjRqMFU5Mi91K0RpTFlPWWRh?=
 =?utf-8?B?bTN3R0dsUXZRbUtDRHNhN1hGVU4zcCtCWFdWMW9xNk1sRE1vblN6czRZOXNS?=
 =?utf-8?B?UjRZMHlmMWY1KzZxdlVnRHZNblp4NUhvSTFjMk85Z0NEbnNuYVVzbC8yayth?=
 =?utf-8?B?S3FmTkdtdncrUHoyLzlpM3NEeGZKZnBoaGhtZS8rcFpzRWhWbXFQOGZ3cXpo?=
 =?utf-8?B?b2UyZVNLekRqU3AwM004aXBDTyt0UkRiWnFEWjYwNTVvSTNZM1dDcHF0ellj?=
 =?utf-8?B?SUlxRHFramxiRlZnVUs0V3dKK0M0S3BLNjcvWS9GMEhBSE5WcUIrUnZGUzkr?=
 =?utf-8?B?ODVLdEtZdC9TaFN6TGw5WlNxWnY5aU9ORjNjbElZYzRGdU9kRTJvR0hBcStv?=
 =?utf-8?B?OFpOVm92VU5EYnRTTGUyaG5IWHExbWJuZjF0WXBYZHdqMUttSEtWbDhtdm8x?=
 =?utf-8?B?STN4RlNuM2E3ZGFjTlRPMVlCWG9HdkZkb1UrT2VQMmZoYmFjdFoxZHdpVEZO?=
 =?utf-8?B?a1MyZDlKV1NRbmd0c0dsRWlzMUozS1NGVUZOdm5sUHVQNnpXTE14QS9yL0l2?=
 =?utf-8?B?L1gzc0swMUtXWU9ETlloWWJhM1p4ZWQvRmhpemdEM2Q3Y1RTcG15NDlmRW1i?=
 =?utf-8?B?bE5ZVWdwNzQxNi8yWHQ5TXB4cUEycjhRZkRhcGVpdzUwWTArYUZEVkdTcG9h?=
 =?utf-8?B?VFNKMGVkNi9iVmwwRU1wQURxRENJMWFXT1dvNXg0UlZjN2ZBbDRJM0JGZ2g2?=
 =?utf-8?B?YTVleDI4UFljTjE3OThjdnE4WDVSTEluOCtDSHF2N3luZjJiYmxOWjd3cU1T?=
 =?utf-8?B?WU9aSXJPT0x6Ukx5ZmMvcU0xMWRkd0IrNGE0alNLMllYKzBVZ2Z0bzc2aFVF?=
 =?utf-8?B?dGs0TVRQVVNzbTRXRzlYazg1dnVIaDVBWUh1MjMvV3IrbVV1UHVEZXpEbEh6?=
 =?utf-8?B?RFN5aEptYm9ISTFycnFQRHh4Ky9FQUFnSVoraGZrS25PTmwzMFhXUGZXWTdJ?=
 =?utf-8?B?Ym9aS2ZLZFJNNU9aTzZmMnJQaEhWNEJ1RTRUanhUWlBFVmNyR3lXR2M0TGRB?=
 =?utf-8?B?bmJ0aGppM1c0dTdnbG1WcExJUEgzNHU3NzV5TWpES2VDSmFuQ2lWVmlKK3dM?=
 =?utf-8?B?bk5NZWYyU2REdzJabnA1V3Yvd0FyV2czQS9IS3JGd0J6SnlLQXVXU3VLSHBB?=
 =?utf-8?B?ZUR6ZXl4ZTZUUkZhREFIZyt6MWE0YUEybWYwRkNWbVlTN0FCeE1nR2dVUUth?=
 =?utf-8?Q?PTHXGb+4670J61wiKCVhJCZUo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 685f4b2b-3809-4c4b-9b63-08db9d38900b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 02:37:26.7154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdOWEdc6DEQpTQNr8JgzYnMFJH8334IsVjCdqeKNB9DAnTGIs8GLIWnVZimZfHnpgD51CIz8TCYpslOmS8rwwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6277
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

On 7/28/23 09:42, James Morse wrote:
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
> 
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
> 
> Keep track of the number of RMID held in limbo each CLOSID has. This will
> allow a future helper to find the 'cleanest' CLOSID when allocating.
> 
> The array is only needed when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is
> defined. This will never be the case on x86.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v4:
>   * Moved closid_num_dirty_rmid[] update under entry->busy check
>   * Take the mutex in dom_data_init() as the caller doesn't.
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c | 49 +++++++++++++++++++++++----
>   1 file changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index de91ca781d9f..44addc0126fc 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -43,6 +43,13 @@ struct rmid_entry {
>    */
>   static LIST_HEAD(rmid_free_lru);
>   

Better to add:

#if CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID
> +/**
> + * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
> + * Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
> + * Indexed by CLOSID. Protected by rdtgroup_mutex.
> + */
> +static int *closid_num_dirty_rmid;
#endif

Then the global variable won't exist on x86 to avoid confusion and space.

Some code related to the CONFIG also needs to be changed accordingly.

> +
>   /**
>    * @rmid_limbo_count     count of currently unused but (potentially)
>    *     dirty RMIDs.
> @@ -285,6 +292,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>   	return 0;
>   }
>   
> +static void limbo_release_entry(struct rmid_entry *entry)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	rmid_limbo_count--;
> +	list_add_tail(&entry->list, &rmid_free_lru);
> +
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		closid_num_dirty_rmid[entry->closid]--;


Maybe define some helpers (along with other similar ones) in resctrl.h 
like this:

#ifdef CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID
static inline void closid_num_dirty_rmid_dec(struct rmid_entry *entry)
{
		closid_num_dirty_rmid[entry->closid]--;
}
...
#else
static inline void closid_num_dirty_rmid_dec(struct rmid_entry *unused)
{
}
...
#endif

Then directly call the helper here:

+		closid_num_dirty_rmid_dec(entry);

On x86 this is noop without occupy any space and cleaner code.

> +}
> +
>   /*
>    * Check the RMIDs that are marked as busy for this domain. If the
>    * reported LLC occupancy is below the threshold clear the busy bit and
> @@ -321,10 +339,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>   
>   		if (force_free || !rmid_dirty) {
>   			clear_bit(idx, d->rmid_busy_llc);
> -			if (!--entry->busy) {
> -				rmid_limbo_count--;
> -				list_add_tail(&entry->list, &rmid_free_lru);
> -			}
> +			if (!--entry->busy)
> +				limbo_release_entry(entry);
>   		}
>   		cur_idx = idx + 1;
>   	}
> @@ -391,6 +407,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   	u64 val = 0;
>   	u32 idx;
>   
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>   	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>   
>   	entry->busy = 0;
> @@ -416,9 +434,11 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   	}
>   	put_cpu();
>   
> -	if (entry->busy)
> +	if (entry->busy) {
>   		rmid_limbo_count++;
> -	else
> +		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +			closid_num_dirty_rmid[entry->closid]++;

Ditto.

> +	} else
>   		list_add_tail(&entry->list, &rmid_free_lru);
>   }
>   
> @@ -782,13 +802,28 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>   static int dom_data_init(struct rdt_resource *r)
>   {
>   	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
>   	struct rmid_entry *entry = NULL;
>   	u32 idx;
>   	int i;
>   
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		int *tmp;
> +
> +		tmp = kcalloc(num_closid, sizeof(int), GFP_KERNEL);
> +		if (!tmp)
> +			return -ENOMEM;
> +
> +		mutex_lock(&rdtgroup_mutex);

data_init() is called in __init. No need to lock here, right?

> +		closid_num_dirty_rmid = tmp;
> +		mutex_unlock(&rdtgroup_mutex);
> +	}
> +

This code is also can be defined as a helper in resctrl.h.

>   	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
> -	if (!rmid_ptrs)
> +	if (!rmid_ptrs) {
> +		kfree(closid_num_dirty_rmid);
>   		return -ENOMEM;
> +	}
>   
>   	for (i = 0; i < idx_limit; i++) {
>   		entry = &rmid_ptrs[i];

Thanks.

-Fenghua
