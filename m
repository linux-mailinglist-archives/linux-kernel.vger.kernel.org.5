Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29107B3A16
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjI2SeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjI2SeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:34:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89697193;
        Fri, 29 Sep 2023 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696012446; x=1727548446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ONxLarUEE9Jc1X4IEB4oLGRLGgaMdo6KTjunaKBj8cQ=;
  b=nVw3EMUEtbIpCpyI7BeHWkL9gj7VWa9jXR6hByF/Y0z7PZ+Q6H5KOGCX
   GDuC0ckO/XY8zrvOnZ8pZWsNu0X7FbT6sCc+IWOI4S8zs5gLGgmCE9UJU
   0r4OP4OG3x3do4uFFZ3YadL0awrkW5DDr8BZs6DVzmJMmZG2Xl8pm2MN1
   bKv6DItWektbcTUcW7fNKT0G8u3lhxo9rtObWFbsB6J2Y78+o7gYMpQcs
   1H4KsvvHkIadOwgS1r6qeNp8+n5fE5t9a1mlzUrZ6JhFpoIKuBBr4gK/+
   EEmjQxe8SWU8gxvImkCx8pKwhU2laEAKtFwHO1i+Ceirab2ni79QFbMrR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="382259852"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="382259852"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 10:35:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="753452990"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="753452990"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 10:35:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:35:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 10:35:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 10:35:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGc7zJHqnBI9ZYMC6/npU5Qr5CUAdzOyE9bPTjTNMvnFpVhJgUSilloKil/Ii5WJqfm5Zk0znXDD1zGhn0dOouWmpfJOszY0VsQCKW8+nhICnblHZRGlRjml9OSXE5eWROsAiyjWkoSNPxJUO5WfnHgUiHFqJ165nHiM88ZTkZ+y0zT3GYQeoCm5zHSCxAOZMgvshWHVw6f3HCIDEzmS5nNDT63oBDulBOgF6433kJK2Sqh3IhvGVFeDPZg6s4t8A5FAj00LgcahM5B/LkMYLKkt8UUwWPtPXHYoFM2na4S6l2l+0Pk6tUlweT/VkP1zjOSVj9EYgDVwntaSKg0HEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLqYDLgsAy2n3c8ZuYjEAvJgY5ItbBxgwAKMXFBD7Aw=;
 b=GPBx/QslleChmkgvMo034DbsilIsoAWnuuMXpBAhSJFdbATDWwUz5jBu8d7Nhs3AvWenLiknFbFv03kagmviDwLtv1FoMe88uiNv1/gTNLLz6RnwHx6hlJC18XfAG1XuN88qFP7jLRjC1SFBmK0dllsdHD9KP+zfjnKqBAkK0dbusJJgkDuhPAdGNiruVTlSuJ2Aeblv0Ic+t+HFz6+/R0cUUkd+96OZ6895McRrZ2ziwS//y2PCbjR8t/Ang3v9mtcSKuPl8knMJqJoFqSG5OeL7uVbePW/udR5m6cvIv/QKMIb4UM5bfoJAtwSykQDyRkOuWSPKrSToD0MjWpk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN0PR11MB5694.namprd11.prod.outlook.com (2603:10b6:408:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Fri, 29 Sep
 2023 17:35:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 17:35:17 +0000
Message-ID: <e5ffec56-5512-1acc-b85c-ac0771634c22@intel.com>
Date:   Fri, 29 Sep 2023 10:35:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Content-Language: en-US
To:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrew@lunn.ch>
References: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0308.namprd04.prod.outlook.com
 (2603:10b6:303:82::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN0PR11MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b26614-630c-4328-8607-08dbc1127253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmiQ91XAxfjUr9pB9yUk76yOhjp8iLQ4CwHRwwBitb6OO7pXy4KjZYP+ayhftym9XuzTKy7BkFl6wz8JoS5Bt+nX7vSUOzPWXaEryVuvxf3kspqmMuxYUsjnUge1d6AvhGqFhWZ8X5olvqNHVkVpKZ1FkU1MvFK9tY/Wp7q4lLCANvwb9r8uSmxwfdS1FYYVQ4eUAnlluRM6L3oinCPjsjPlMzpSnJivjMViL/bfFqmCHQsAA1nReXpo1aij3BudnxtQoy42eoTU/BTvxCriTO1QeD14BWPSmcTF02sQ13bpRTrD2Nbcx0/7A89KCClG9a9/UCo11aPuzcRDW0UNyWdxs46qCF9FHtuGr0UmRRadypoK1/MhSvbizrGoZ/x3kRzqnW8NhWlA4VPChpSvqjRKMQ7DPYJ/tU4nvqG7afOunrW/F7yavX9xCGY8kYaUuSobsE5ibB2e4R+VY92TDu/zQMSw99KkSESt5r0+FOWhEkjg5lSYUW6UzDG71xVhGi4ajFZ4WD7fCtRsr3EpJZha1Jz7v599/QEEPVan6GZgrcguzTy6d5GnBbFNGmclFvhN95tkbAv5M0A9zUizXCu1w6L+HGpronuxqqNK+O4uTZGBBZqIoD58vqZQO0XqRRhiFLwTE2FXtAYSICMz7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2906002)(83380400001)(7416002)(6506007)(38100700002)(6512007)(478600001)(66946007)(66556008)(53546011)(4326008)(6486002)(6666004)(66476007)(316002)(8676002)(26005)(5660300002)(82960400001)(41300700001)(8936002)(2616005)(86362001)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym14OVVQejEyaTRiS3lkS3dBdEh4aU52bXQ1Y1pTeWFUTEZ2L1FQQlJpUVRW?=
 =?utf-8?B?RHk0SkhMaktPeDZ2QXJOeXpBcndybVlrQXVKNDE0MTR2WFIxNXNWbWk1RVBl?=
 =?utf-8?B?SWw4QllzTVlpNGNwR0R0bmJpTWF0eEo1emI5THk4UHNndG5VbzhvbWNoZisv?=
 =?utf-8?B?MFhudTBXM2FWbE1EZkprM1BHVVRPTmw4U0JaZWZhWEc2M050Q2NJOTFZRG9o?=
 =?utf-8?B?OGFhT1ZYSGpXT2x2UTE2RnU3azFjUHVIMkYxRHBvUkFKdGtYSkdFb1JwZkp1?=
 =?utf-8?B?NkUxZXFVeUNYU0RkN1J3Tlp3Y3FTUjV2ZFFEalhYVFF5SHoxZWN2Ynk3eGx1?=
 =?utf-8?B?RTJrYnp4MmxRbjBCYUJIQkw5bGhhUEZMTGFJK0RxUjk4RjZKekR0ekI0c0Uv?=
 =?utf-8?B?TWNVV2d2T0htSnBENmdlOXJoZ3Ixd0JMejQvTmJBOGhldUJmUkU2UzN2NWd3?=
 =?utf-8?B?YmNoMGxaUGlkSzlYaFJKemI1Rnc4Mmx5OEg5Q2dKWmcwaHREVEsyMXVLNytl?=
 =?utf-8?B?VmFjVnBzSGhNNHlEdGh5a1VYRm01VUFHUVF6VWQvSHh2b1o5emtRTVZNM2Iv?=
 =?utf-8?B?djRjZExmTCttMjJmS0ozTytRZjRvUVd4RVRpMVNCZUlKc1ZMQzhlNzBDVmhU?=
 =?utf-8?B?eXgxRUtGWlJ5ZDJDY01Xczg2WkNuV3k5ZW41emtMWEd6Y3NyZE1hd1EwK2hz?=
 =?utf-8?B?RzZRZW1TZmthalk4R3lqMmZ2bFNndmRlZ2dzZjBGSko0RU9jUmpqNDNqanha?=
 =?utf-8?B?QjJYdjdUME5sQU5ialhQZVRQYUJPSFFFSzU0NHRYYTZxekNIbmdjZmtnT1Nx?=
 =?utf-8?B?cDFWaUU3aCt6dyt6VXY5T2dtbmdXSENYRHFZWlVrTXBvMUU2d1Mwb0RON3k1?=
 =?utf-8?B?Umk5WVo5VXRmdEQ4N3pEYis3SkEyYzJEcW9xZ0ZKZllTcVdPZWdIYjhKbmZl?=
 =?utf-8?B?SDVNUmRXOGtwbnZtVGFpbC9DL0x6TmF3Z0hIdFhpbmZ5NzNHaFVvNG1Kb0FT?=
 =?utf-8?B?ZUtIREtoNk9Tc0FuR0F4dVlMT3NmMWVGbXBkRHJLOUUvVW1jY1hEVnZ0QWtJ?=
 =?utf-8?B?NW9FcTM3YWZZeEVNRzhNekxPcU0wK1M2QitkWUhDYzJzSksxeWpBWjc5dytU?=
 =?utf-8?B?YThNbWovWWxLRjhhZENsNitHWGlabG0yYit1WmFNeXRpdmhxeUY0MU16NXVO?=
 =?utf-8?B?VEowZlh3aVdCRGtuSi9pQ0dMWUQwRVVXN0J1YndLYW9oNGpOWDJYS2d1Q0ZE?=
 =?utf-8?B?aHNCdFlPTHlpTDZqNHh3a1RBZURJbFFGczlQVERwQWNzZnlVV0tyUlQ1Rkgr?=
 =?utf-8?B?enFkMW8yQUdPTXFHRlZacURwRE5QaWZhLzlXNUJ0UW9LY1VFUURjMnRNUDNE?=
 =?utf-8?B?THZ5eFp3b1VEaEp6YzZPblJkRzBrdmd1b0lKNEFpQ0NXSUNpRW9OSGNFQmlM?=
 =?utf-8?B?NElBTmlYbWpmVmN3aU16ZmkySmxoU3FvNjB6alQ3SFBKWjVRTUlGa2kvVWMy?=
 =?utf-8?B?NUt5ZXZsSXBnbEdFZXRhS1FKS1c5N0UvdG9pNkxsWnR1cjZJRnFiRU9QTVRM?=
 =?utf-8?B?eHVHU2lmYXFLYXZCVUh4di9PM2orK2o4YWFISzJ1SEZSbFJiQ0RkTGVjOXVG?=
 =?utf-8?B?dU50UVBVbGQvZ2kvMktDakRaVGpwMjZkV0N4UmRaa1VaNnFZRTZyQ2swWnNX?=
 =?utf-8?B?TG5wSy9NMlVIV0hBb0JWZlhUekxCYnBYUytoeFBJVFlPeGpKcWFnN1VFWXE2?=
 =?utf-8?B?aG1CRGN6cHAvOUphMm5RVGU0c1huVHllOGJSZW1SZlgycGl6N3JLcitJbmd0?=
 =?utf-8?B?MGZhVFZOMG9hdFYrSC83dkdlclFDWndMUGZqUURMZXlFMW9YaVUxZW13VUQy?=
 =?utf-8?B?a1lEa2kxeTNOU1Blems1TU1aTmZjMUdMR2pCTVlvaXY3NGlCOWs5bXZvWWQy?=
 =?utf-8?B?eloxV29rMUZTb29YU1Yvb2tzOTR5TWowTnhDQ25kQkgxZnV1VVUwRUx3Tm82?=
 =?utf-8?B?bXM2eE84OVh6dFYzRUtuSlFrSzI0bmJmQkZ2eG9JMHpmNmJKeHkvR1hCbXpL?=
 =?utf-8?B?UkZRZnhoa1dKYzhjRFhHaWFXQnV3Uzdwc0NENEVoUTlLNWRkZjJDbmJERE5C?=
 =?utf-8?B?WC8raFBxWGhJdkZvR2hCdlZrdlVoK25MQjZRaXpMZXpiV2ZoZHlhR1M1UGRl?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b26614-630c-4328-8607-08dbc1127253
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:35:17.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmY1Gd+7y9NV40YVL8AWVURYG2hHgS1U3tK6zDRSnNKcuOeV/Cx+SL1y37HOINFfxZbikT35Q4BgQGt7QF1NOcCu3YZ03LHW0SGF5o3km1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2023 4:16 AM, Vishvambar Panth S wrote:
> The LAN743x/PCI11xxx DMA descriptors are always 4 dwords long, but the
> device supports placing the descriptors in memory back to back or
> reserving space in between them using its DMA_DESCRIPTOR_SPACE (DSPACE)
> configurable hardware setting. Currently DSPACE is unnecessarily set to
> match the host's L1 cache line size, resulting in space reserved in
> between descriptors in most platforms and causing a suboptimal behavior
> (single PCIe Mem transaction per descriptor). By changing the setting
> to DSPACE=16 many descriptors can be packed in a single PCIe Mem
> transaction resulting in a massive performance improvement in
> bidirectional tests without any negative effects.
> Tested and verified improvements on x64 PC and several ARM platforms
> (typical data below)
> 

I assume here the choice of 16 is to get the 16 bytes from 4 dwords?

> Test setup 1: x64 PC with LAN7430 ---> x64 PC
> 
> iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec  sender
> [  5][TX-C]   0.00-10.04  sec   169 MBytes   141 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.02 GBytes   876 Mbits/sec  sender
> [  7][RX-C]   0.00-10.04  sec  1.02 GBytes   870 Mbits/sec  receiver
> 
> iperf3 UDP bidirectional with DSPACE set to 16 Bytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec  sender
> [  5][TX-C]   0.00-10.04  sec  1.11 GBytes   951 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.10 GBytes   948 Mbits/sec  sender
> [  7][RX-C]   0.00-10.04  sec  1.10 GBytes   942 Mbits/sec  receiver
> 

Going from barely transmitting to hitting the line rate *and* improving
both Tx and Rx slightly is fantastic. Huge win just avoiding all that
unnecessary wasted PCIe bandwidth.

> Test setup 2 : RK3399 with LAN7430 ---> x64 PC
> 
> RK3399 Spec:
> The SOM-RK3399 is ARM module designed and developed by FriendlyElec.
> Cores: 64-bit Dual Core Cortex-A72 + Quad Core Cortex-A53
> Frequency: Cortex-A72(up to 2.0GHz), Cortex-A53(up to 1.5GHz)
> PCIe: PCIe x4, compatible with PCIe 2.1, Dual operation mode
> 
> iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   534 MBytes   448 Mbits/sec  sender
> [  5][TX-C]   0.00-10.05  sec   534 MBytes   446 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.12 GBytes   961 Mbits/sec  sender
> [  7][RX-C]   0.00-10.05  sec  1.11 GBytes   946 Mbits/sec  receiver
> 
> iperf3 UDP bidirectional with DSPACE set to 16 Bytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   966 MBytes   810 Mbits/sec   sender
> [  5][TX-C]   0.00-10.04  sec   965 MBytes   806 Mbits/sec   receiver
> [  7][RX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec   sender
> [  7][RX-C]   0.00-10.04  sec  1.07 GBytes   919 Mbits/sec   receiver
> 
> Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
> Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
> ---

Always fun to see a massive win like this! Even just the 2x improvement
on the RK3399 is huge, let alone 6x improvement on the x86 platform.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/microchip/lan743x_main.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
> index 52609fc13ad9..6dac6fef7d24 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.h
> +++ b/drivers/net/ethernet/microchip/lan743x_main.h
> @@ -1067,7 +1067,7 @@ struct lan743x_adapter {
>  #define DMA_DESCRIPTOR_SPACING_32       (32)
>  #define DMA_DESCRIPTOR_SPACING_64       (64)
>  #define DMA_DESCRIPTOR_SPACING_128      (128)
> -#define DEFAULT_DMA_DESCRIPTOR_SPACING  (L1_CACHE_BYTES)
> +#define DEFAULT_DMA_DESCRIPTOR_SPACING  (DMA_DESCRIPTOR_SPACING_16)
>  
>  #define DMAC_CHANNEL_STATE_SET(start_bit, stop_bit) \
>  	(((start_bit) ? 2 : 0) | ((stop_bit) ? 1 : 0))
