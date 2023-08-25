Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2380788455
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbjHYKL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbjHYKL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:11:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604B52109
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhbHn4xnT0S/1kaAuMb2DzTFNyLRLlhHnmuRdHmO9DqzAkpFxvA1alsNIumL4UFBknJdgy/APEMDr/ckyl2QQf29Q1M2PvGt1P+ggpEbLn3gFtC6KHOKUBlGVv37Cu5ZsLacdnPvS1HSppS0mxkmxgImpOgpVYGmvmlAIHfp10N0rldzS/g7KXVRlIUWjWLzUd8vG5vuOx1LIhzG4V8nvR/jv8LgF0zqHG/YplyeaSIpyJJEXTURIvQRlrMrWfwTOD/of9D5hgQy8+J2tF/6eQFiB9h/gX5dmVxU2LTUKReFPCpJWeHnZRAlRchYv4++GKyqbZQOoJ2qKhWmfvhHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltj8rcqA6FaRHs2NKRZ5L6c2SyNy0UrdFs0k4xAawps=;
 b=bXFVfKsKYXH2w2cjrkPo2wA62QQV4g1K1uOCK6y9Y8a2AL2fPU5XqDnzg4uaW0BYmtvNk012j3vkh7rDwmhgjlVWQ0YG8bMyjjzw/16+WC+yukuRbNtCBz9FvnIdiKUixzUPxWzzAopSqpg/x0/vXHUhRp27aB6h7Gd0D5PeNS6vZBxNqZYspP34GMypAg5iG8NDBQFpbc+RR/wezqHSD9JWBiDkatYNeBLW65fdaJCtMC9m0p9Zaj5VMFj3I1aF6x8jKHoY3gwRzafqhgS8NcTXDcYQkr1abC3ZyuwK+mOUiafGQqtkEo+QERN4ikoPx2WDyzT5GHNCOab2WScxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltj8rcqA6FaRHs2NKRZ5L6c2SyNy0UrdFs0k4xAawps=;
 b=pngJJ9ubKlSR625QY9l1JzBu6M31RGNhyGHdNxLmoYDu62r4VpQZ6+yQyrG8y1Y6yuyK4X/0HgXXKvih84MHo5oCsaxJMqsXAW5EpjrpxZiSUjknxZPkObFu+KZf/Is2ajTSspCcDR/oaPQJbQpsJHOrd8t5FBcq5ZdTjySE+UM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 10:11:22 +0000
Received: from SJ1PR12MB6172.namprd12.prod.outlook.com
 ([fe80::8ff0:3f26:2697:d8d6]) by SJ1PR12MB6172.namprd12.prod.outlook.com
 ([fe80::8ff0:3f26:2697:d8d6%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 10:11:22 +0000
Message-ID: <f6dc1652-bc39-0b12-4b6b-29a2f9cd8484@amd.com>
Date:   Fri, 25 Aug 2023 15:41:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v3 0/3] sched: Skip queued wakeups only when L2 is
 shared
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
Content-Language: en-US
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::18) To SJ1PR12MB6172.namprd12.prod.outlook.com
 (2603:10b6:a03:459::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6172:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 49117525-6abc-4c5d-1cb7-08dba553a1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeUU4G3lHPHvUU08UCBJSKqlXiiEeiXwLbdwSEamahcnCHbBRojRy4W1fcL+xKaGMkc5NRfRlGj2ZHHfw7bblbHJR2RMODKrBJAlRdzvnclhHNPnz1R4Y+lZOsV3Yj2xZMA9Npw2JEHiFtm98/zvmwgtyivcwetuaKwAMypLEe2Zl5BbIBezJyk2p1uj4nvjQryb8uSEM6tPRrzBiBaXqAlv0sdisRKgfsnT8PQhYsGf/jVwHKmi6EcI8qsL8GbiJsXjwUUoCI7k0qR6c8bV+5FoL8wztowlJTafDygE8BTmGS/6q9kq1vntIpY9rS+P4vRYImZzA6OmNFIITd73+/Au0go3jvH8QdI2BzHGTqqG44MjMqDvFZZUzCPmBnTQHuVFwU0QRLdT5bnTp0SIttO4QwmOU58q1LjwaPAC345V5dPWcmw5DjsdFdkSTqVUx21k3N6yRSEDsrRlGm2esO2H9ihf3iZ+wY6SMruAhh3ReN7QEmI+wY0ZjXvAZSuIePH1/oqbZ4Ujc0OA2Wyfv3kL4hg9OlRaqOvS1jaI3lFXGhydtglosJK425fqviHresHQVbYIsI1ee7mb58xVNZC9mHc/WK8XRKMtBkf6eZsi3Cuyzkj8FQwLxtgWggEh3odldjRoy+kDDJMX8nl7vLbBpHIZ7XRnyu02U9RljYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6172.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199024)(1800799009)(186009)(38100700002)(66899024)(8676002)(4326008)(8936002)(54906003)(31696002)(41300700001)(6486002)(6506007)(53546011)(6666004)(316002)(36756003)(66476007)(66556008)(110136005)(66946007)(86362001)(6512007)(26005)(478600001)(83380400001)(7416002)(31686004)(2906002)(30864003)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pZS2F0dXBIVTROYUhPdkhwQXZiYit0UG8rdTcxR2hhcE80ME5CVUYwZVQy?=
 =?utf-8?B?UmhOUy8xZGc0d0JSVGVESmZ0SGJNMktvTXFodlJpb0lycUczdk8zTXNZWEdC?=
 =?utf-8?B?UTVOSU5pdmh0aEQrelB1cU5XRGM2S29WbzcycWl2MzI4YmREb01ZVkdpVW5t?=
 =?utf-8?B?WW1iVzJlQ1IzdnhpaWYyeUROK0svSGhvYVBvUmEvR1pHa3lhYkZBd3Z6L1B1?=
 =?utf-8?B?Y3EzRWJlckpLR043UUpES1Q1Qlh0ZFp0Wisrb2xXQ0RiMFR3NmtDZUhsR05Q?=
 =?utf-8?B?MkhoaDZNYVh0SjZqL1lldXhXdEdPUnRoNk1OTW9rS2pPVEJkVHY5R1JDcXJH?=
 =?utf-8?B?eE5GZDh5MDdIbUVpRndZUjZpUm85b1hQQmx0WEVrNDJFY0M4RkhzWkJhRGgr?=
 =?utf-8?B?NFhmeXV3bHlwS3Y2VHdDMXAvLzBXN25NQ2k3cUJ1a2tST01Pais5L2JnNS9h?=
 =?utf-8?B?dlgyOVI5MWNSSDNrRGNQdUxMZ2hRMzRGV3dYek1MZ0JNb2pyRTFhSytoZUVa?=
 =?utf-8?B?eFBTNHc0TGlNTEsrRmRIam92aEdUWFlGa24vWml6VWZmS3dUWU56UVBBdzFk?=
 =?utf-8?B?dTFXUTd5aVVmSjRwOHorWllQRUN3TGNEUGE3cWVYakRGZ0hWMUVBOS9LakUv?=
 =?utf-8?B?Rm16cUExSEpzaUdOU0hvb1lyOWRSNEw3SHJ2MUhNamd3bzlkT0dRRDRsRzFZ?=
 =?utf-8?B?YWhWeXEzY1EvTWh2TDMvNGVxVnFUSlg0empnRjlNVmc5b2xjWnptYVNCcUky?=
 =?utf-8?B?VG0rSlczeFV6Mmh2ekRUZmFhVE9JODhIb3E4M09LaTJHZS9ScG9lOWZvanhk?=
 =?utf-8?B?QlRYV1N0RVduc3BtaTRWRzFVYmtYNnMzNnMyVU9YTktoNW9sMmVwV2dERFpS?=
 =?utf-8?B?bnVrV2VOeS83eTN6Ky9aemFVSjYrRmlBZUE2SFlLLzZQaGdveCt5QlBtWkZR?=
 =?utf-8?B?Y3JBNlRGekJMeFE4cVRoNDZDN1ErOXQwTkc3cTlRSUxRSXB5UXFHdjVmVFph?=
 =?utf-8?B?aG9WTUNEWS9oaG84eXB4NG9LanVna0h5OHBNclpGNjlrTzVWS05sZzhFcmt3?=
 =?utf-8?B?ZjV6UTNHeVV2eElkUFlhcTEwOG00dmlOVFoyOEw5TU9pZnRCNTJwZlI2NkxH?=
 =?utf-8?B?bldxVVQ5WVJ4MDVBUkZiQ1I4K3pZWnJvR2U4bU9tdlJESTAvd2RqbGs3Sm1B?=
 =?utf-8?B?dnorbTJCUlNGckRXZEJpRS8wMTRYS2xTVHhQd2ZDMEZXMCtuQmVRZFdGMXBP?=
 =?utf-8?B?QXF0dzNDQVk1cFNsZWpkbk9zQVVrOUxOZCs3Q2lNcTBTZG5DaFE3UzIxRGRY?=
 =?utf-8?B?L0JEdjRiVjI3UVVDU1FaK1BxS0lWdktZOVYwV0d2citCbTh2SFB1Ni8rMHN3?=
 =?utf-8?B?emphblN2SXkvRW5hcDNDdTZXN01kdkt5SlBKWmZkYXZSTXRWeWxUR0RUOVBs?=
 =?utf-8?B?MGh0aGU1SHNxTVF3ZjZpN092R1FoOHlHSmFWYzRKaU40bGx5clBHdXZnd2NJ?=
 =?utf-8?B?N1I2cE1qR3Q0eC9sdk95MG1VOWdWeUgybEd0WFRuTVJOOU45SHhJRHdkSnpw?=
 =?utf-8?B?bnlwYm9NeXAwcFV3ZW56ZXc0bjhsNzBNcDNTMzVENEk0czlpaFk0VnZ4Rks4?=
 =?utf-8?B?Z0s2VlFtamJ0eVBLMzRqTmJ2elB5c3Y3clBEbm9IbnQ5RytBL2NvcUJkNVZ1?=
 =?utf-8?B?WXArZUJxVlJNR3NqTDMreEVkQzl5cVNkcXAzdzBiL1ZMUUtLV01vcjdjejZW?=
 =?utf-8?B?L0NWdUIzYi9ETjZucDQzV0NJdUJYUVpId3UwUkN5YmtrdWFFa1c1eXYvUjhY?=
 =?utf-8?B?bFdDNjZ2ZExPZ2s4bVp1cFh5QjI4ZmJnQ250Tk1EZzJmUTEzOHRVOWVWaThr?=
 =?utf-8?B?cTVEZHFLSmY3QkJ2eUhwOWVnb0dPTmMvR1g1TGtPUG1BYlZGK2FuWU9VRUNZ?=
 =?utf-8?B?bmtZd2tvQzRaN3FTUXpPbndKTTVmQWZFYk5RZGMyQkxiZjVaaFhXWUg0Mmpt?=
 =?utf-8?B?azNqbndWRmJRT1g5TEdjaHhZb2lIbWQ2K3pxTHFva0JTRmUwT2wycnFENENu?=
 =?utf-8?B?QmllNkNEUU9IMm9PUE9ZVHlKcEFyYm9DOGtGUzVRSFNKQm5XNXF3cjVtblBO?=
 =?utf-8?Q?9s8dfG52o2ibPo+4C6JlJUw17?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49117525-6abc-4c5d-1cb7-08dba553a1ca
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6172.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 10:11:22.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTMI9au4dyhwD6uqbP6DgBW3zidZbN2ZloDR4FrhrGEa7T7sXI4WHKONNMYJFm+sfNItHi4LYmCvhT5OFhGzoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

On 8/22/2023 5:01 PM, Mathieu Desnoyers wrote:
> This series improves performance of scheduler wakeups on large systems
> by skipping queued wakeups only when CPUs share their L2 cache, rather
> than when they share their LLC.
> 
> The speedup mainly reproduces on workloads which have at least *some*
> idle time (because it significantly increases the number of migrations,
> and thus remote wakeups), *and* it needs to have a sufficient load to
> cause contention on the runqueue locks.
> 
> Feedback is welcome,

I ran some micro-benchmarks as part of testing this series. Here are the
observations:

- Hackbench shows improvement with this patch and Aaron's patch with
   6.5-rc1 kernel as the baseline.

- tbench and netperf shows shows some dip in performance with highly
   overloaded case.

- Other micro-benchmarks shows more or less similar performance with
   these patches.

o System Details

- 4th Generation EPYC System
- 2 x 128C/256T
- NPS1 mode

o Kernels

base:	                                6.5.0-rc1
base + mathieu-queued-wakeup:		6.5.0-rc1 + Mathieu's patches [1]
base + aaron-tg-load-avg: 		6.5.0-rc1 + Aaron's patch [2]
base + queued-wakeup + tg-load-avg:     6.5.0-rc1 + Mathieu's patches [1] + Aaron's patch [2]

[References]

[1] "sched: Skip queued wakeups only when L2 is shared"
     (https://lore.kernel.org/all/20230822113133.643238-1-mathieu.desnoyers@efficios.com/)
[2] "Reduce cost of accessing tg->load_avg"
     (https://lore.kernel.org/lkml/20230823060832.454842-1-aaron.lu@intel.com/)

==================================================================
Test          : hackbench
Units         : Time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Test:        6.5.0-rc1 (base)    base + mathieu-queued-wakeup       base + aaron-tg-load-avg        base + queued-wakeup + tg-load-avg
  1-groups:   22.15 (0.00 pct)      22.46 (-1.39 pct)                    22.35 (-0.90 pct)                   21.20 (4.28 pct)
  2-groups:   22.76 (0.00 pct)      21.78 (4.30 pct)                     22.60 (0.70 pct)                    21.90 (3.77 pct)
  4-groups:   22.12 (0.00 pct)      22.02 (0.45 pct)                     22.22 (-0.45 pct)                   21.94 (0.81 pct)
  8-groups:   24.80 (0.00 pct)      22.36 (9.83 pct)                     22.99 (7.29 pct)                    22.00 (11.29 pct)
16-groups:   31.09 (0.00 pct)      21.56 (30.65 pct)                    22.13 (28.81 pct)                   20.60 (33.74 pct)

==================================================================
Test          : tbench
Units         : Throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients: 6.5.0-rc1 (base)    base + mathieu-queued-wakeup           base + aaron-tg-load-avg       base + queued-wakeup + tg-load-avg
     1    261.49 (0.00 pct)       261.18 (-0.11 pct)                     262.29 (0.30 pct)                   257.80 (-1.41 pct)
     2    514.08 (0.00 pct)       521.30 (1.40 pct)                      517.66 (0.69 pct)                   510.96 (-0.60 pct)
     4    1002.51 (0.00 pct)      988.81 (-1.36 pct)                     995.04 (-0.74 pct)                  987.74 (-1.47 pct)
     8    1978.74 (0.00 pct)      1966.60 (-0.61 pct)                    1991.85 (0.66 pct)                  1941.39 (-1.88 pct)
    16    3864.14 (0.00 pct)      3952.03 (2.27 pct)                     3914.80 (1.31 pct)                  3873.88 (0.25 pct)
    32    7473.19 (0.00 pct)      7602.38 (1.72 pct)                     7585.94 (1.50 pct)                  7423.44 (-0.66 pct)
    64    14335.10 (0.00 pct)     14313.17 (-0.15 pct)                   14474.67 (0.97 pct)                 14030.63 (-2.12 pct)
   128    27275.73 (0.00 pct)     25176.80 (-7.69 pct)                   28066.53 (2.89 pct)                 25045.53 (-8.17 pct)
   256    41688.17 (0.00 pct)     44373.40 (6.44 pct)                    43779.37 (5.01 pct)                 41427.00 (-0.62 pct)
   512    137481.33 (0.00 pct)    136466.67 (-0.73 pct)                  134824.00 (-1.93 pct)               141280.00 (2.76 pct)
  1024    140534.00 (0.00 pct)    141916.33 (0.98 pct)                   137008.33 (-2.50 pct)               126319.33 (-10.11 pct)
  2048    145378.00 (0.00 pct)    145479.33 (0.06 pct)                   138763.67 (-4.54 pct)               124471.00 (-14.38 pct)

  ==================================================================
  Test          : netperf
  Units         : Througput
  Interpretation: Higher is better
  Statistic     : AMean
  ==================================================================
                  6.5.0-rc1 (base)    base + mathieu-queued-wakeup       base + aaron-tg-load-avg        base + queued-wakeup + tg-load-avg
   1-clients:      59642.88 (0.00 pct)        61647.37 (3.36 pct)         61186.24 (2.58 pct)                 59099.11 (-0.91 pct)
   2-clients:      59349.65 (0.00 pct)        60896.01 (2.60 pct)         60582.49 (2.07 pct)                 62738.47 (5.70 pct)
   4-clients:      59197.37 (0.00 pct)        60457.29 (2.12 pct)         63042.52 (6.49 pct)                 60879.58 (2.84 pct)
   8-clients:      61977.66 (0.00 pct)        60389.92 (-2.56 pct)        62078.15 (0.16 pct)                 60314.65 (-2.68 pct)
  16-clients:      61518.83 (0.00 pct)        61143.51 (-0.61 pct)        60946.08 (-0.93 pct)                59388.78 (-3.46 pct)
  32-clients:      58230.81 (0.00 pct)        58653.20 (0.72 pct)         58594.14 (0.62 pct)                 58188.52 (-0.07 pct)
  64-clients:      58050.92 (0.00 pct)        57834.55 (-0.37 pct)        58183.51 (0.22 pct)                 57565.75 (-0.83 pct)
  128-clients:     54324.55 (0.00 pct)        54385.60 (0.11 pct)         54913.43 (1.08 pct)                 53917.11 (-0.75 pct)
  256-clients:     70155.29 (0.00 pct)        69390.68 (-1.08 pct)        70097.50 (-0.08 pct)                64410.66 (-8.18 pct)
  512-clients:     61511.77 (0.00 pct)        61480.99 (-0.05 pct)        54493.82 (-11.40 pct)               46227.05 (-24.84 pct)

==================================================================
Test          : stream-10
Units         : Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:      6.5.0-rc1 (base)      base + mathieu-queued-wakeup         base + aaron-tg-load-avg       base + queued-wakeup + tg-load-avg
  Copy:   353336.76 (0.00 pct)       352956.36 (-0.10 pct)               349583.67 (-1.06 pct)               351152.80 (-0.61 pct)
Scale:   353474.88 (0.00 pct)       354582.35 (0.31 pct)                350543.75 (-0.82 pct)               353275.74 (-0.05 pct)
   Add:   371984.24 (0.00 pct)       372824.87 (0.22 pct)                369173.72 (-0.75 pct)               370483.63 (-0.40 pct)
Triad:   372625.41 (0.00 pct)       278389.62 (-25.28 pct)              369504.06 (-0.83 pct)               369070.11 (-0.95 pct)

==================================================================
Test          : stream-100
Units         : Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:     6.5.0-rc1 (base)        base + mathieu-queued-wakeup       base + aaron-tg-load-avg       base + queued-wakeup + tg-load-avg
  Copy:   353476.35 (0.00 pct)       354954.50 (0.41 pct)                354614.56 (0.32 pct)                353512.71 (0.01 pct)
Scale:   353214.73 (0.00 pct)       354884.12 (0.47 pct)                355841.17 (0.74 pct)                353220.53 (0.00 pct)
   Add:   370755.48 (0.00 pct)       372292.72 (0.41 pct)                375307.35 (1.22 pct)                369917.77 (-0.22 pct)
Triad:   370652.02 (0.00 pct)       372732.11 (0.56 pct)                375718.85 (1.36 pct)                369926.26 (-0.19 pct)

==================================================================
Test          : schbench (old)
Units         : 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: 6.5.0-rc1 (base)    base + mathieu-queued-wakeup          base + aaron-tg-load-avg        base + queued-wakeup + tg-load-avg
   1:      56.00 (0.00 pct)        58.00 (-3.57 pct)                      60.00 (-7.14 pct)                   60.00 (-7.14 pct)
   2:      61.00 (0.00 pct)        56.00 (8.19 pct)                       59.00 (3.27 pct)                    60.00 (1.63 pct)
   4:      64.00 (0.00 pct)        62.00 (3.12 pct)                       66.00 (-3.12 pct)                   64.00 (0.00 pct)
   8:      96.00 (0.00 pct)        78.00 (18.75 pct)                      76.00 (20.83 pct)                   93.00 (3.12 pct)
  16:      98.00 (0.00 pct)        95.00 (3.06 pct)                       98.00 (0.00 pct)                    95.00 (3.06 pct)
  32:     137.00 (0.00 pct)       144.00 (-5.10 pct)                     133.00 (2.91 pct)                   130.00 (5.10 pct)
  64:     206.00 (0.00 pct)       210.00 (-1.94 pct)                     200.00 (2.91 pct)                   217.00 (-5.33 pct)
128:     348.00 (0.00 pct)       347.00 (0.28 pct)                      413.00 (-18.67 pct)                 366.00 (-5.17 pct)
256:     679.00 (0.00 pct)       669.00 (1.47 pct)                      669.00 (1.47 pct)                   675.00 (0.58 pct)
512:     1366.00 (0.00 pct)      1366.00 (0.00 pct)                     1442.00 (-5.56 pct)                 1430.00 (-4.68 pct)


==================================================================
Test          : schbench (new)
Units         : 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
Metric: wakeup_lat_summary
#workers: 6.5.0-rc1 (base)    base + mathieu-queued-wakeup          base + aaron-tg-load-avg        base + queued-wakeup + tg-load-avg
   1:      15.00 (0.00 pct)        15.00 (0.00 pct)                       16.00 (-6.66 pct)                   17.00 (-13.33 pct)
   2:      16.00 (0.00 pct)        16.00 (0.00 pct)                       17.00 (-6.25 pct)                   17.00 (-6.25 pct)
   4:      17.00 (0.00 pct)        17.00 (0.00 pct)                       15.00 (11.76 pct)                   17.00 (0.00 pct)
   8:      11.00 (0.00 pct)        13.00 (-18.18 pct)                     11.00 (0.00 pct)                    11.00 (0.00 pct)
  16:      11.00 (0.00 pct)        11.00 (0.00 pct)                       10.00 (9.09 pct)                     9.00 (18.18 pct)
  32:      11.00 (0.00 pct)        11.00 (0.00 pct)                       11.00 (0.00 pct)                    11.00 (0.00 pct)
  64:      10.00 (0.00 pct)        11.00 (-10.00 pct)                     10.00 (0.00 pct)                    10.00 (0.00 pct)
128:      11.00 (0.00 pct)        12.00 (-9.09 pct)                      12.00 (-9.09 pct)                   11.00 (0.00 pct)
256:     117.00 (0.00 pct)       162.00 (-38.46 pct)                     90.00 (23.07 pct)                  103.00 (11.96 pct)
512:     22496.00 (0.00 pct)     21664.00 (3.69 pct)                    22368.00 (0.56 pct)                 21408.00 (4.83 pct)

Metric: request_lat_summary
#workers: 6.5.0-rc1 (base)    base + mathieu-queued-wakeup          base + aaron-tg-load-avg        base + queued-wakeup + tg-load-avg
   1:     6872.00 (0.00 pct)      6872.00 (0.00 pct)                     6792.00 (1.16 pct)                  6856.00 (0.23 pct)
   2:     6824.00 (0.00 pct)      6824.00 (0.00 pct)                     6872.00 (-0.70 pct)                 6856.00 (-0.46 pct)
   4:     6824.00 (0.00 pct)      6808.00 (0.23 pct)                     6872.00 (-0.70 pct)                 6824.00 (0.00 pct)
   8:     6824.00 (0.00 pct)      6824.00 (0.00 pct)                     6872.00 (-0.70 pct)                 6824.00 (0.00 pct)
  16:     6824.00 (0.00 pct)      6840.00 (-0.23 pct)                    6872.00 (-0.70 pct)                 6840.00 (-0.23 pct)
  32:     6840.00 (0.00 pct)      6840.00 (0.00 pct)                     6888.00 (-0.70 pct)                 6856.00 (-0.23 pct)
  64:     6840.00 (0.00 pct)      6872.00 (-0.46 pct)                    6888.00 (-0.70 pct)                 6872.00 (-0.46 pct)
128:     12272.00 (0.00 pct)     12784.00 (-4.17 pct)                   13200.00 (-7.56 pct)                12016.00 (2.08 pct)
256:     13328.00 (0.00 pct)     13392.00 (-0.48 pct)                   13712.00 (-2.88 pct)                13552.00 (-1.68 pct)
512:     88832.00 (0.00 pct)     86400.00 (2.73 pct)                    88192.00 (0.72 pct)                 85632.00 (3.60 pct)

Metric: rps_summary
#workers: 6.5.0-rc1 (base)    base + mathieu-queued-wakeup          base + aaron-tg-load-avg       base + queued-wakeup + tg-load-avg
   1:     297.00 (0.00 pct)       297.00 (0.00 pct)                      297.00 (0.00 pct)                   299.00 (-0.67 pct)
   2:     601.00 (0.00 pct)       603.00 (-0.33 pct)                     595.00 (0.99 pct)                   601.00 (0.00 pct)
   4:     1206.00 (0.00 pct)      1206.00 (0.00 pct)                     1190.00 (1.32 pct)                  1206.00 (0.00 pct)
   8:     2412.00 (0.00 pct)      2412.00 (0.00 pct)                     2396.00 (0.66 pct)                  2420.00 (-0.33 pct)
  16:     4840.00 (0.00 pct)      4824.00 (0.33 pct)                     4792.00 (0.99 pct)                  4840.00 (0.00 pct)
  32:     9648.00 (0.00 pct)      9648.00 (0.00 pct)                     9584.00 (0.66 pct)                  9680.00 (-0.33 pct)
  64:     19360.00 (0.00 pct)     19296.00 (0.33 pct)                    19168.00 (0.99 pct)                 19296.00 (0.33 pct)
128:     37952.00 (0.00 pct)     35264.00 (7.08 pct)                    36672.00 (3.37 pct)                 38080.00 (-0.33 pct)
256:     41408.00 (0.00 pct)     41536.00 (-0.30 pct)                   39744.00 (4.01 pct)                 40896.00 (1.23 pct)
512:     36288.00 (0.00 pct)     36800.00 (-1.41 pct)                   35264.00 (2.82 pct)                 35776.00 (1.41 pct)

Tested-by: Swapnil Sapkal <Swapnil.Sapkal@amd.com>

> 
> Thanks,
> 
> Mathieu
> 
> Mathieu Desnoyers (3):
>    sched: Rename cpus_share_cache to cpus_share_llc
>    sched: Introduce cpus_share_l2c (v3)
>    sched: ttwu_queue_cond: skip queued wakeups across different l2 caches
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: Julien Desfossez <jdesfossez@digitalocean.com>
> Cc: x86@kernel.org
> 
>   block/blk-mq.c                 |  2 +-
>   include/linux/sched/topology.h | 10 ++++++++--
>   kernel/sched/core.c            | 14 +++++++++++---
>   kernel/sched/fair.c            |  8 ++++----
>   kernel/sched/sched.h           |  2 ++
>   kernel/sched/topology.c        | 32 +++++++++++++++++++++++++++++---
>   6 files changed, 55 insertions(+), 13 deletions(-)
> 
--
Thanks and Regards,
Swapnil
