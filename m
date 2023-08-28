Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F97F78B396
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjH1Ouh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjH1OuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:50:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F54DCC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693234222; x=1724770222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CJaFDSe5Dnl2Ek4C/Y+EdasV1PWmbhTMDDwYckecyBU=;
  b=QbqrM2+iy8pFlyXxjc9Uz5BoIzVVBBkt1AQkja7ITUPVIIuzd61t4yuL
   q9zw+oUIsIMMeF90Dp/MN8QJ0AoTNmVA8VjaSQya+gnDW/h4s/qr/yowu
   RVWZRSkMwhe0zxCcedGJl7wQ2rHDr62+2oH+fQEwSRBYX2LVpgriVrLZ6
   9Y+PqJ2c+W1Of71sxu5gx1eHxqvC2RFKUzxlGzUoodKt0KdIS9URum9W5
   enULzwild3PEx4lH4JIouM58ES241ong/uGCr9I+MhRHoOzdgUbI4rVov
   rcImgRtFmpcNYUq7rkqCztgNq97QKgDQaIyzPaPW+HMNvOXcyO2BwOGE5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="461495032"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="461495032"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 07:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="767713284"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="767713284"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2023 07:50:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 07:50:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 07:50:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 07:50:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 07:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMUa6yvD87dkLXUcBEGIDvic8J3yLbXcmxCWOefkhakFH/z9CjRByK2zlTl71T5ZZL3L2+MRXX22Jvno0OYn28nclOSlyKLz+Zest0SIMZ2/3oPW8iHn0Hw7n8L5lycrMFYx348YwInFYo7LpuWOYyT7wDz3+u3xA41enuFVCnsIcv06+Hi2QGofhCG/KUREapGiouzSKkRj+jHBUiWtS2v9e3GNS2s52G14mlYQCF7b1gt+QLeG46dzYW7DoF54t//camhNNNgQTfT7CMnvQ758JjIjXXeuEKUvoD+WNcHLygRPcAZhtX2BpMU5UuUDyc/nJz7jMW+KTID7fI3f/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxVnl8mxHPvRo3oY+1EzkLX1Q3FfQqhgOAub2BJ8/sY=;
 b=MDzrlSVYqP4v8n/HwK8QJiciSRmdRLJp9poWErXpBVQ5BCIQTNmk59y5rSHIxUrMdJd/Hdj2f1oRqzfxRWcVH72CitANNwtZwFmmZe5UxdXxxwx0yPZ079ztjKVyC73NMwXI+oS0ZKHptVv/xa60NUMD2w42w1sAAhCIT+JyZxia9qcrDhnewn11yQ7tHB4BfGyibgeM3D9m8kg+Yz/nsuTdWbKROdhgjIIFW8VHTLi2Fo6TG+m2cyPH+FQErrHfjNJhHdHI77maNHjQniJ5FiJ6E5R6VGyOruXAfz9Okgwan7d8KwyTyHjAvBvdfhY/wdy1O4LBh7KH5XQpvmv/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Mon, 28 Aug 2023 14:50:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 14:50:15 +0000
Message-ID: <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
Date:   Mon, 28 Aug 2023 07:50:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: resctrl2 - status
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "George Cherian" <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
 <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <ZOkU+d4AsLGSAG+y@agluck-desk3>
 <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
 <ZOlRNTq3lE7VNHjU@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZOlRNTq3lE7VNHjU@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0262.namprd04.prod.outlook.com
 (2603:10b6:303:88::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6356c9-9d9d-4b82-5b78-08dba7d616eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2clNWThVURNbHPKIWPR1p6BKd4VNucdENft3ICjxdikqGVjnW3e308um2GBWveegf0lIXBnbtd75bpRGVdUqkdzWyuC3gkJkAvcuk2HwoznCaf3u98OC09yO1Vz7lBBffHy0aisdVKaV1tZvGTXFSkTfzR9uDsrz+54Cp2bVtZdiMkninpRvTTrJfpLEwfSZITqILoXYlgGl87+AUf0SiUKF+M6e+QAQIs5+BsO5UvlQ3hKC0YdGU6JvPBMUGEEhlDYAA+J6OXe7KLsNXx2/fWeR4t5ap+ZE1sFO7xeh30rSwMTqDiiyLYacsBS5G2T8wZbQhGDbr0DTEM3Gouufyi+9VbdPsN84OdtUgWX0Pcb1irfkefc1YsDYb/33EJqg59/SNhKENAK/7mhyAw4KksB5WNMYY3/g4FiIJ4Q44+XKX/q7bJna1Sk/K5jBptJQDtfz9MrZddc4Tjkg0nou/JYUyKDvCyidLDmAEa1kQBHv97IT5puN9RdQFtjAiTVuwoicrMMBKpPMF+PQFWoZNPnhvEh56qQYag1Y39w5f4HjbL6fTrh82k/tf2TaF4RloYYhHBGHGzApWMvG5lVbGUjK0z88ifMjQztuxtEu3d+ClBwfXtcG1/GgbBZQG++G2j+eU4HxwJrDXav8kfIdTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(1800799009)(451199024)(186009)(2616005)(36756003)(26005)(86362001)(82960400001)(478600001)(83380400001)(8936002)(8676002)(6512007)(6486002)(53546011)(6506007)(6666004)(66476007)(66556008)(37006003)(66946007)(6636002)(31686004)(316002)(41300700001)(54906003)(6862004)(4326008)(44832011)(66899024)(5660300002)(2906002)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdzSVhzejNEVDJUdTZiVis0S1hEWEFSVXFMbmV4cWM2NVVOQjVEOEdSQ0hi?=
 =?utf-8?B?YUIveWJpZHc0bG4zbThCd0ZqamlpVDFjVmlXeldBR0dTTmZRM0dDY3orNGFL?=
 =?utf-8?B?cTd5eTA4V2xKRytYY1czR0NiUy9nTDFibEliYTN4WG1qcUlTUkR3a1pRT3Zs?=
 =?utf-8?B?cXVNZFNJb0ZUdFpHWXdQRjhUK0tWUU5CamVzRk5wdGhFREs1NnNkSHNLU0Zr?=
 =?utf-8?B?Q0lKVEozOXlKczdkeFFjS2VkMXlDQ3gwd2ZMNXR4MTVCWXN3MDhmZnp0RnFo?=
 =?utf-8?B?V1Zxc00yN1BWdVJmdjZjOVRPSlNwNjdpRFNlWUUwTXdwRlZ6SkQxUmlsY1lx?=
 =?utf-8?B?MnZHM0liNkcrV3hOOXB6V2ExN000amRKMzBpYTFlOTVxaHVaajExZWN6MERs?=
 =?utf-8?B?eTZ1QXJNSmM2Qmg4LzBaZXFhRFZQa2RxOHVXL3pwZmZGUVYrOW5VaGdDalQr?=
 =?utf-8?B?RHJGa0xkN0Q0THMwbGhpSFBDQjFKMVlneHRrQVRGTlUrZDdlZ3FHekFGaGdD?=
 =?utf-8?B?cHEvUFZrV1B3bXdNOEdGQUxnb01ENzlEQS9IWmRUTE55aHZiOVQzS01KcWE3?=
 =?utf-8?B?YWc5dE9Yc3EvZnhRZFUzbE5vVUF1bFZubHl4U2dkSXIxL0Y4ZW5IaFdkRTl2?=
 =?utf-8?B?VTZIRGlWcWt3Qml6MVl0Rm4vOGdHQWg5TEJ5emYrdllnc2RpS3dxWEFCc1Vn?=
 =?utf-8?B?bkdid2RMRnBuRGE1ckliQTNpU0ZwODRXc0xBMlhpTzdoK2RnVnVZLytBcVFy?=
 =?utf-8?B?TjZ1eHkxQ3NPeUM4TEhSSHZtQ1pINjltK3pZWXlYbW9aWjJsWTBzODBycm5s?=
 =?utf-8?B?dXA4Sk5keC9RN3E3RXFJNnV6MDFOdzlmeHU0RFdPcUFYbkZLQjNsOW5xQWVk?=
 =?utf-8?B?VWlCekxDQS9mdFFhdnFkQnprVitxUFhzczUyU01wZUxuMGZ1RCt3Q2IyZEV3?=
 =?utf-8?B?UWtneHk5MXZQcStMWGRCUWIyeEF3TUNWUnRuL1R6ZVJyZDY1RTJ2UFQzdElK?=
 =?utf-8?B?elVkcUhRQVV2dE1MUG4rdXdJV1luME5kelR6UXpHN3VQNjlTZEEvanFUTUVQ?=
 =?utf-8?B?OHoxQlhXQmhBL2VQL05wY3V6WHRJNzhiSFJJSWppaDV4elpIem1GY0hyMFZy?=
 =?utf-8?B?UUxxZm5OdmQvM3pkcUpjTzBrYmJkbTgveUdVbWxKeE5mektqNDM2UmFtWDBZ?=
 =?utf-8?B?MDdqU21va1pnRCtWVHBORFpMQU5uNGVGRkRMMU5qQjlKYkhzWmJYSW81NUdy?=
 =?utf-8?B?OG9CUHRxMWNZUVdVanU1RCttSnNNYXl1Z2NHTE9KbDdraFhyZGRmMWZSYUFp?=
 =?utf-8?B?TUlRVUNxaWk0Rmg0amtTb1FTR0w3THVQNG91ZVRxRlZsU2JBajBNRjlUL0g4?=
 =?utf-8?B?SXpOSVBUOXA3ZytGNi9DZ3RnUkptTVEwdGdCOFI5REVMSXZraFBiUGxCbHpB?=
 =?utf-8?B?U3lUVmlwd3ZUTWZhMVF5Z1ZxcnZTSXBxM2xDNFVERTh2R1lpandBQlZ3a0Iz?=
 =?utf-8?B?VUZKMVJXWm9uTFJEWmtabXFNMW5MdFFoN29OR0NuVUFmMDRXSW82Vlh2dmxB?=
 =?utf-8?B?VE9XNStRWWVEMi9Zc01YaE5vVFcxa3ExZ1pRdVhJekpFUllFT1JqUEUwUFJM?=
 =?utf-8?B?VHZZa1dMY2h6ZjdZT0JlUkFTV1dqalc3U2UxMDk4cFAxb3NkZ2RJQkp6TU5T?=
 =?utf-8?B?dEtmck9lUnB0WXAwYysxMWUvd2M5Y0o5N0M4VFV2VjhMb3hRUzVtWWwzUjFD?=
 =?utf-8?B?dXZaVjNVWERrTW5YQkFKaXFSQVJrRlF3ZUg3TGtybG1xSnhwQzJiR0UzaXcx?=
 =?utf-8?B?WG1LZnV1NEtxeHdOcEtpSExwK2gxV0xmdVQ3NGd3R0F2M1ExQ0NaMVY5RnFE?=
 =?utf-8?B?c3hhRHlETTlIc2N6MFB1NzhjTFFEUG40elhWYXI4OHFGQ2N0a0lacExFNElO?=
 =?utf-8?B?NnRVM1ZkUXRVMlJYeUQ5NlkvTkdtUEpia2hmcVNRcVhWZmVMczJCeW5pRGl1?=
 =?utf-8?B?bWtQZjhIcGRubVZCVytTN1p4OVpDd3FKeWc1OTVpY2R1VVF1WkhFUmNFcjM4?=
 =?utf-8?B?enRDaUhuc3dQNTFSakFXeDlOOWJyTXdOZEg1bnQveTJ6NWdMeGttVTJlNVc1?=
 =?utf-8?B?alVMZ3hnZ1l6WlpVRVkxZGVoRDdSWk1wSno0bzZNWnh1ZWJXWDQvemVxNE9t?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6356c9-9d9d-4b82-5b78-08dba7d616eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:50:15.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgP6TQ1DTyJuakrokrACP7J019iCaidRY92ACOmC1PwlU6snQdL1XyZcja0r4sEVLKnt2/d4PG5pBxAjtNjR939GwCEx4u308pZgbxdSsyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2023 6:11 PM, Tony Luck wrote:
> On Fri, Aug 25, 2023 at 04:08:21PM -0700, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 8/25/2023 1:54 PM, Tony Luck wrote:
>>> On Fri, Aug 25, 2023 at 01:20:22PM -0700, Reinette Chatre wrote:
>>>> On 8/25/2023 12:44 PM, Luck, Tony wrote:
>>>>>>>> Alternatively, can user space just take a "load all resctrl modules
>>>>>>>> and see what sticks" (even modules of different architectures since
>>>>>>>> a user space may want to be generic) approach?
>>>>>>>
>>>>>>> This mostly works. Except for the cases where different modules access
>>>>>>> the same underlying hardware, so can't be loaded together.
>>>>>>>
>>>>>>> Examples:
>>>>>>>
>>>>>>> rdt_l3_cat vs. rdt_l3_cdp - user needs to decide whether they want CDP or not.
>>>>>>> But this is already true ... they have to decide whether to pass the "-o cdp" option
>>>>>>> to mount.
>>>>>>>
>>>>>>> rdt_l3_mba vs. rdt_l3_mba_MBps - does the user want to control memory bandwidth
>>>>>>> with percentages, or with MB/sec values. Again the user already has to make this
>>>>>>> decision when choosing mount options.
>>>>>>>
>>>>>>>
>>>>>>> Maybe the "What resctrl options does this machine support?" question would be
>>>>>>> best answered with a small utility?
>>>>>>
>>>>>> A user space utility or a kernel provided utility? If it is a user space utility
>>>>>> I think it would end up needing to duplicate what the kernel is required to do
>>>>>> to know if a particular feature is supported. It seems appropriate that this
>>>>>> could be a kernel utility that can share this existing information with user
>>>>>> space. resctrl already supports the interface for this via /sys/fs/resctrl/info.
>>>>>
>>>>> I was imagining a user space utility. Even though /proc/cpuinfo doesn't show
>>>>> all features, a utility has access to all the CPUID leaves that contain the
>>>>> details of each feature enumeration.
>>>>
>>>> For x86 that may work (in some scenarios, see later) for now but as I understand
>>>> Arm would need a different solution where I believe the information is obtained
>>>> via ACPI. I think it is unnecessary to require user space to have parsers for
>>>> CPUID and ACPI if that same information needs to be parsed by the kernel and
>>>> there already exists an interface with which the information is communicated
>>>> from kernel to user space. Also, just because information CPUID shows a feature
>>>> is supported by the hardware does not mean that the kernel has support for that
>>>> feature. This could be because of a feature mismatch between user space and
>>>> kernel, or even some features disabled for use via the, for example "rdt=!l3cat",
>>>> kernel parameter.
>>>
>>> Agreed this is complex, and my initial resctrl2 proposal lacks
>>> functionality in this area.
>>
>> Why is there a need to reinvent these parts?
> 
> Perhaps there isn't ... see below.
> 
>>
>>>>>> fyi ... as with previous attempts to discuss this work I find it difficult
>>>>>> to discuss this work when you are selective about what you want to discuss/answer
>>>>>> and just wipe the rest. Through this I understand that I am not your target
>>>>>> audience.
>>>>>
>>>>> Not my intent. I value your input highly. I'm maybe too avid a follower of the
>>>>> "trim your replies" school of e-mail etiquette. I thought I'd covered the gist
>>>>> of your message.
>>>>>
>>>>> I'll try to be more thorough in responding in the future.
>>>>
>>>> Two items from my previous email remain open:
>>>>
>>>> First, why does making the code modular require everything to be loadable
>>>> modules?
>>>> I think that it is great that the code is modular. Ideally it will help to
>>>> support the other architectures. As you explain this modular design also
>>>> has the benefit that "modules" can be loaded and unloaded after resctrl mount.
>>>> Considering your example of MBA and MBA_MBps support ... if I understand
>>>> correctly with code being modular it enables changes from one to the other
>>>> after resctrl mount. User can start with MBA and then switch to MBA_MBps
>>>> without needing to unmount resctrl. What I do not understand is why does
>>>> the code being modular require everything to be modules? Why, for example,
>>>> could a user not interact with a resctrl file that enables the user to make
>>>> this switch from, for example, MBA to MBA_MBps? With this the existing
>>>> interfaces can remain to be respected, the existing mount parameters need
>>>> to remain anyway, while enabling future "more modular" usages.
>>>
>>> Lots of advantages to modules:
>>> 1) Only load what you need.
>>> 	- saves memory
>>> 	- reduces potential attack surface
>>> 	- may avoid periodic timers (e.g. for MBM overflow and
>>> 	  for LLC occupancy "limbo" mode).
>>> 2) If there is a security fix, can be deployed without a reboot.
>>> 3) Isolation between different features. 
>>> 	- Makes development and testing simpler
>>>
>>
>> From what I understand (1) and (3) are accomplished through things
>> being modular. To transition smoothly it may be required for all
>> currently supported features to be loaded by default, with the
>> option to unload afterwards by user space that understands new
>> modular interfaces.
>>
>> (2) does not need a module for each resource and feature supported
>> by resctrl. A single resctrl module would accomplish this and I
>> would expect it to be something everybody would like. James also
>> mentioned it being on his significant to-do list.
>>  
>>> Sure some things like switching MBA to MBA_MBps mode by writing to
>>> a control file are theoretically possible. But they would be far more
>>> complex implementations with many possible oppurtunities for bugs.
>>> I think Vikas made a good choice to make this a mount option rather
>>> than selectable at run time.
>>>
>>>> Second, copied from my previous email, what is the plan to deal with current
>>>> users that just mount resctrl and expect to learn from it what features are
>>>> supported?
>>>
>>> Do such users exist? Resctrl is a sophisticated system management tool.
>>> I'd expect system administrators deploying it are well aware of the
>>> capabilities of the different types of systems in their data center.
>>>
>>> But if I'm wrong, then I have to go back to figure out a way to
>>> expose this information in a better way than randomly running "modprobe"
>>> to see what sticks.
>>
>> I always start with intel-cmt-cat but I believe that the burden would be
>> on you to convince all that existing user space would not be impacted
>> by this change. If I understand correctly this implementation would
>> result in mounting resctrl to have an empty schemata and no resources
>> in the info directory. Without knowledge about how to enable resources
>> the user space could be expected to interpret that as no resources enabled
>> on the system.
> 
> Reinette,
> 
> The basic issue is that my module based system has become less user
> friendly. Requiring extra steps to get basic things works.
> 
> Luckily there is a simple solution. Make the modules for the basic
> functions autoload.  E.g. for MBA:
> 
> +static const struct x86_cpu_id mba_feature[] = {
> +       X86_MATCH_FEATURE(X86_FEATURE_MBA, 0),
> +       { }
> +};
> +MODULE_DEVICE_TABLE(x86cpu, mba_feature);
> 
> Then immediately after booting the system looks like this:
> 
> $ lsmod | grep rdt
> rdt_l3_mba             16384  0
> rdt_mbm_local_bytes    12288  0
> rdt_mbm_total_bytes    12288  0
> rdt_llc_occupancy      12288  0
> rdt_l3_cat             16384  0
> 
> And mounting resctrl:
> 
> $ sudo mount -t resctrl resctrl /sys/fs/resctrl
> $ tree /sys/fs/resctrl/info
> /sys/fs/resctrl/info
> ├── L3
> │   ├── bit_usage
> │   ├── cbm_mask
> │   ├── min_cbm_bits
> │   ├── num_closids
> │   └── shareable_bits
> ├── L3_MON
> │   ├── max_threshold_occupancy
> │   ├── mbm_poll_threshold
> │   ├── mon_features
> │   └── num_rmids
> ├── last_cmd_status
> └── MB
>     ├── bandwidth_gran
>     ├── delay_linear
>     ├── min_bandwidth
>     └── num_closids
> 
> 3 directories, 14 files
> $ cat /sys/fs/resctrl/schemata
> MB: 0=0;1=0
> L3: 0=fff;1=fff
> 
> Thanks for pushing me to search for this solution to make things
> more compatible.

heh ... sounds familiar to "To transition smoothly it may be required
for all currently supported features to be loaded by default". It is not
obvious to me how this also closes the other opens.

Reinette
