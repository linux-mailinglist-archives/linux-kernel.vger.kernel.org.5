Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1887929D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353863AbjIEQ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243958AbjIEBG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:06:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301FE1B8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfS9RjyuwVzIM4yJckJ1oPRftjrvwR0qxueWcqszFpFoRqDzPJEgZmsht0baW8pLv+G8bin85LWACTCeaqzN6gQuLRujxTh97WdLLTnToluWZ6cX15jm2lYP5U8itCVkz/H6jJGvZnkEu0ymkDtrrPGjVWbUAPJaS9WyOscG38ofcxKMFCvB8yIrQ6/TDCqh0Cbzw2cOT5Pxrg0vRaRYx2f1pGnLsqjlEaI2AHNekfu285QGdaL1OlOgX5bwPpl3LGVNlKJTI0U0UC81nME6L6e6C+BOCufDPQxgCTvNY6MKSlcOS75YOO6LEu+URyk/8yowJ/fYH/ehi8gy/korjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoJH8JQgoAvaCpVguMdRsk5d3DRN5W2yeRQ1srdY6VE=;
 b=Y9ZOG5CGUWPCMMrPPb+RENJ0TBto1A5CXjSneKlPeDUtTog65+Cr5x7jjH4xPR3QaRng3fy8KnEWzOV18Ac961SSnHAwG0VBTheRkEglepM6BHfi2nNbhsht4kRteJRU5dnUJ35NEa/m8gb+Qq4zbg73skBaskBaJN2E7huPM3jC7BnJuY3EMwojSq4Zx2/EIpulbXJh2LKbISq3cWn4FSaQo1mqnV6WtByyB43Nrmnc43Tcc5xy67Q4p71Pcn3I/WA60kT+vaolVbLhGOnSHeAAZxbwebtOYvHNssatKjdzfXd7p34Q6LlhhF6VlYigtD5ffU/Z1qSeWL1RWsPBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoJH8JQgoAvaCpVguMdRsk5d3DRN5W2yeRQ1srdY6VE=;
 b=IhuZn3TC6iu44SvL1uvT3yh11sVG+WL9o+iNpoO6Zb80OQk0sb9ITZnPm6a/VFl8JVyoeoX4f9nLDXs57HfnEwiR/dPwRPy5KM6Rs2RBS30Ny+wpgIQY65ooT0qJLZK9qE3CjN55D20JNze3bLXpqnIm38k2AYaMNSqCPzP1y/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 01:06:48 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 01:06:47 +0000
Message-ID: <2b79ab3b-56e7-926f-49f0-4c2584f6a72b@amd.com>
Date:   Tue, 5 Sep 2023 06:36:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/9] x86/clear_huge_page: multi-page clearing
Content-Language: en-US
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0231.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::7) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d0df79-4755-48e9-b4e4-08dbadac6078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARec9LdQ3LVf79o3z6PvocZZHhsW1sQw4MPZK5uDHZdMcolObdr8u44nWVeCaBFULLAQc76XpDJ2VZg9Bbkow2Fwh7Rz4ACOPTxpF3/Ra1LLQQkp/DNOTmv0O4vptN/wGi1asjyQQ4BHqVLYUIew2leaxI5iWTqw9qk+DT509ySOAsqz6FOZbHvKGsKaBDXOnvWji8BAVsfEhZLj3BPStz9zfxoEgpUpKejj/UyAIct/+JgC9ASYsKgl0FNV4oyB+WwpVdQhtbtURfkLwTAQC/aQUYiUZbIJuCKrOZ0WPEF6QmL97BWmvy9cLrqVyCb5blp7X7fZG3WCpPQwMsb8IuBYohy5M8sdAnWXM6njaTqdJEngn0riReRP6+wfcohv8f4zVxolF2p1jvPVtnuHcYPycrwuveRUV6VTJY/eXbEf53yJ7l+Br/2YdmSGGmmtbqNNNBHFTZoO6ghzC816zHahmFDMBq+GNb9kYCdav7FlTWjXW15s9CR9tyHKaC62DG/EAA1s0tx6ost6KbRgNIhksZ8Oo13FYgTlbSxVlKk8JvUAVK8jMrzTcoCUCSpo537O6BWdtXj2iqVtP5l/wdsQ1mrng9ZYvSfYvhOqXzcyegOqSrydwrS2dRo6Jhg93S/ShV3gczHQqXECQe+fMxYTvgA4D7PHpZI74qTwirU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(1800799009)(186009)(451199024)(31686004)(5660300002)(8936002)(316002)(66476007)(66556008)(36756003)(2906002)(66946007)(4326008)(8676002)(7416002)(41300700001)(53546011)(6486002)(6506007)(26005)(6512007)(38100700002)(6666004)(478600001)(2616005)(83380400001)(31696002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVNiRGhyM2xqbWFCb1ArZEtwRE1xeUl4d3hBWUVmNHRTbUJxejJVR1R2ZnYw?=
 =?utf-8?B?YkNGY3c3SzFXUkpxSllXMFJ5Y3VwYVdheTNXU2Vnd3NGZDUvdzRjL3huSjRl?=
 =?utf-8?B?NE9JNHVnUFRzc0dwQXVLMkhoUnR2ZXorakw1Z0RaU3Rya3BvNGdjbVV1U3pk?=
 =?utf-8?B?cmVTY05ZcW0rMGcvNkwxRGxBR2hTN3RyVTRDN1cySFQ3czUxOFI0RzI2YW5k?=
 =?utf-8?B?MHNhcHBjVGYxT2RJUmxVQW10UWlhR1p2TFFZc0dpN05lMGZ0eTZBRjVlZ0VJ?=
 =?utf-8?B?NXN1dFduRUtqTzNCWXIxaFdWbTYvSytRK0dBcSt6VUszT2wvV3BFUmZzVmls?=
 =?utf-8?B?bXJOQ1FHT1lXdERBUXlsczBULzQ5YnFRVU4zTnFBbjMwQ011VGV0TU5sNzlK?=
 =?utf-8?B?WmhiK3pMclFvSHArblJneEI3SzNSWjcvYkNEZzdDQjNCYVplWnVqciswcmNx?=
 =?utf-8?B?bTNqb2dBZ2ZlQXJGL1EvbFUya1U0cEE4UStZelBwSTVqOG5OamJhYXJYdzNm?=
 =?utf-8?B?REJEZHY0VEhKQXRHQWxpd01BLzhxcU9nL0V1ZkYxWGtvWlh2SkVycnZHNFlX?=
 =?utf-8?B?Q25NcHhVbnVDbnhzTFg3SW91aDJnM21GRTVvRTZ6R0lOVWhjRkZReTA0NEp1?=
 =?utf-8?B?U1dWdm1nejZ5Qks3VmRLVmlVM3VtU2srQlpIK2w2ekVGckE3ZFgybkpIaGxq?=
 =?utf-8?B?S0lHK25ScDdmZGVIK0wxbmJCajJQOEE4L29UM1EzMXJETkhtMFlhVUR6ZnNI?=
 =?utf-8?B?S2dDWFFWMkFrbEcrZWdCL2JFanlLUFBZY1NRMzF3SWhFV3h0TEk4ZUhleDdS?=
 =?utf-8?B?NFhWdERJUXhtUURjaGhTWUNxVmpKSE9ldDNtUC9vUHpDaU12N21uT1k5NVR2?=
 =?utf-8?B?aDBGRE5mMkRKZDRrc1hpOWhnVDFQWUw2ODZ3dXBla29nZ1l5c0tScXVHMTlR?=
 =?utf-8?B?WCtTM2YrT2dVZU5LTm9FNnJoa1BPcWM4TGZXd3lUVnVlREVHTHR4eTY5Q01G?=
 =?utf-8?B?VnJVYXNxSGtJSXRESVJSLzJMNTZlMmV0TW5yTzQvdkIxTms2VjI4QVpZdXBM?=
 =?utf-8?B?UWd2QlNKbUtxbzJGUTJjY0plUDYzYUsxM0dmZGRBbHlkdHFvQzE1SDJXZkFD?=
 =?utf-8?B?cVE2cXJ4bzdFeURBVE9Eb1BpSnhyUDhHQy84YllWV0pFUitIS051cGs5S0lQ?=
 =?utf-8?B?U1RteHdvQmg0RWMzUWJMZERRRmpsYUNBeCt2OWFOV29pcG5ReXBCdlZEYjg2?=
 =?utf-8?B?MytpU2RqVEx3cEdTTitEN1VMS1o4RUZvQWh5V2xteDA5U212b203ODFuSFJk?=
 =?utf-8?B?SjBCTmxodGI3WVJiUE9PdVRNckZ3Z0lZMnM4SmVGZjl4bExTUnZWTTkrUi8r?=
 =?utf-8?B?OEptVm5JZjJwUDRPWXhDU3VQR2NTSmp1WFVXUXJKQzFxRGRMODlKY25YR2JI?=
 =?utf-8?B?TE5JaG5FZEdGSWRMeVk3dllkU2pNSmRLMEc4bWk5cXliOG8zT2w3RDAyYURC?=
 =?utf-8?B?blJybVFnLzU2MFZ5NHVZZWlIdEtXKzBPcksvWUpINWY3UmtKTWo2NXJlQlJ4?=
 =?utf-8?B?TVdBZi80K0p2bGVQYjJNcXZReEc3M043Mi9aVmNHOE9za0Y2THdlc3ZDNmZ1?=
 =?utf-8?B?dzIvdElteStlK1NXVDZBSUl5eUpVb0U2ZE9XcUJBWHM0U09Ya1NxTm5aZ1pP?=
 =?utf-8?B?czlJbUxyVVlReFJaZ1VqdjRYeEN1bHllZ1dWRU9lMEtSTEJ6ZUllTTRVRXUx?=
 =?utf-8?B?M2psdEMzL01Iek5oQWtXWlRhQ2JRdVErOVJsVEVSZk1OcXRCdzNPSHA1bEs1?=
 =?utf-8?B?aEs4TXNGb0lveFhYcHRmUG5yQ25kcG95M1M3OU5tT01KMkJXbEJveHR4dHUw?=
 =?utf-8?B?TE1ldmVDUTJCMXhPY2RydGtWaWJka3hySExya3UrSlpoLzNmblAxNUhBVWRl?=
 =?utf-8?B?WVVQMlZTWTVnd2QrU2xGd0xWTldhcUp2Qk41YzVxMnUwT1hPOEJBUDJ2VWdi?=
 =?utf-8?B?bW42T2xvY3JHZU9iUEsvRmlvZ3FoSnhncFdPUXM3TXg4bmQyWHJRNmxmTEJp?=
 =?utf-8?B?cks1ay9uOG9sTkFaS3lEZjZpNEQwc2NQSCs0YXZ2NVlrUXBhMU85aUg2TXRY?=
 =?utf-8?Q?gsvsZV9zuaIG3+blUWUTNS0FB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d0df79-4755-48e9-b4e4-08dbadac6078
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 01:06:47.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRG7/CovZdp+TKGZgxllfbcVwGcRpgdR7k/I+LnAiGAzj/WDIYX6hRZjHUibcKDa9D2+dbQTHhbxT6ODOJLjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2023 12:19 AM, Ankur Arora wrote:
> This series adds a multi-page clearing primitive, clear_pages(),
> which enables more effective use of x86 string instructions by
> advertising the real region-size to be cleared.
> 
> Region-size can be used as a hint by uarchs to optimize the
> clearing.
> 
> Also add allow_resched() which marks a code-section as allowing
> rescheduling in the irqentry_exit path. This allows clear_pages()
> to get by without having to call cond_sched() periodically.
> (preempt_model_full() already handles this via
> irqentry_exit_cond_resched(), so we handle this similarly for
> preempt_model_none() and preempt_model_voluntary().)
> 
> 

Hello Ankur,
Thansk for the patches.

I tried the patches, Improvements look similar to V1 (even without
circuitous chunk optimizations.)
STill we see similar 50-60% improvement for 1G and 2M page sizes.


SUT: Bergamo
     CPU family:          25
     Model:               160
     Thread(s) per core:  2
     Core(s) per socket:  128
     Socket(s):           2

NUMA:
   NUMA node(s):          2
   NUMA node0 CPU(s):     0-127,256-383
   NUMA node1 CPU(s):     128-255,384-511

Test:  Use mmap(MAP_HUGETLB) to demand a fault on 64GB region (NUMA 
node0), for both base-hugepage-size=2M and 1GB
Current result is with thp = always, but madv also did not make much 
difference.

perf stat -r 10 -d -d  numactl -m 0 -N 0 <test>

time in seconds elapsed (average of 10 runs) (lower = better)

Result:
base: mm/clear_huge_page
patched: x86/clear_huge_page

page-size  base       patched     Improvement %
2M         5.0779     2.50623     50.64
1G         2.50623    1.012439    59.60

More details:

  Performance counter stats for 'mm/map_hugetlb' (10 runs):

           5,058.71 msec task-clock                #    0.996 CPUs 
utilized            ( +-  0.26% )
                  8      context-switches          #    1.576 /sec 
                ( +-  7.23% )
                  0      cpu-migrations            #    0.000 /sec
             32,917      page-faults               #    6.484 K/sec 
                ( +-  0.00% )
     15,797,804,067      cycles                    #    3.112 GHz 
                ( +-  0.26% )  (35.70%)
          2,073,754      stalled-cycles-frontend   #    0.01% frontend 
cycles idle     ( +-  1.25% )  (35.71%)
         27,508,977      stalled-cycles-backend    #    0.17% backend 
cycles idle      ( +-  9.48% )  (35.74%)
      1,143,710,651      instructions              #    0.07  insn per cycle
                                                   #    0.03  stalled 
cycles per insn  ( +-  0.15% )  (35.76%)
        243,817,330      branches                  #   48.028 M/sec 
                ( +-  0.12% )  (35.78%)
            357,760      branch-misses             #    0.15% of all 
branches          ( +-  1.52% )  (35.75%)
      2,540,733,497      L1-dcache-loads           #  500.483 M/sec 
                ( +-  0.04% )  (35.74%)
      1,093,660,557      L1-dcache-load-misses     #   42.98% of all 
L1-dcache accesses  ( +-  0.03% )  (35.71%)
         73,335,478      L1-icache-loads           #   14.446 M/sec 
                ( +-  0.08% )  (35.70%)
            878,378      L1-icache-load-misses     #    1.19% of all 
L1-icache accesses  ( +-  2.65% )  (35.68%)
          1,025,714      dTLB-loads                #  202.049 K/sec 
                ( +-  2.70% )  (35.69%)
            405,407      dTLB-load-misses          #   37.35% of all 
dTLB cache accesses  ( +-  1.59% )  (35.68%)
                  2      iTLB-loads                #    0.394 /sec 
                ( +- 41.63% )  (35.68%)
             40,356      iTLB-load-misses          # 1552153.85% of all 
iTLB cache accesses  ( +-  7.18% )  (35.68%)

             5.0779 +- 0.0132 seconds time elapsed  ( +-  0.26% )

  Performance counter stats for 'numactl -m 0 -N 0 x86/map_hugetlb' (10 
runs):

           2,538.40 msec task-clock                #    1.013 CPUs 
utilized            ( +-  0.27% )
                  4      context-switches          #    1.597 /sec 
                ( +-  6.51% )
                  1      cpu-migrations            #    0.399 /sec
             32,916      page-faults               #   13.140 K/sec 
                ( +-  0.00% )
      7,901,830,782      cycles                    #    3.154 GHz 
                ( +-  0.27% )  (35.67%)
          6,590,473      stalled-cycles-frontend   #    0.08% frontend 
cycles idle     ( +- 10.31% )  (35.71%)
        329,970,288      stalled-cycles-backend    #    4.23% backend 
cycles idle      ( +- 13.65% )  (35.74%)
        725,811,962      instructions              #    0.09  insn per cycle
                                                   #    0.80  stalled 
cycles per insn  ( +-  0.37% )  (35.78%)
        132,182,704      branches                  #   52.767 M/sec 
                ( +-  0.26% )  (35.82%)
            254,163      branch-misses             #    0.19% of all 
branches          ( +-  2.47% )  (35.81%)
      2,382,927,453      L1-dcache-loads           #  951.262 M/sec 
                ( +-  0.04% )  (35.77%)
      1,082,022,067      L1-dcache-load-misses     #   45.41% of all 
L1-dcache accesses  ( +-  0.02% )  (35.74%)
         47,164,491      L1-icache-loads           #   18.828 M/sec 
                ( +-  0.37% )  (35.70%)
            474,535      L1-icache-load-misses     #    0.99% of all 
L1-icache accesses  ( +-  2.93% )  (35.66%)
          1,477,334      dTLB-loads                #  589.750 K/sec 
                ( +-  5.12% )  (35.65%)
            624,125      dTLB-load-misses          #   56.24% of all 
dTLB cache accesses  ( +-  5.66% )  (35.65%)
                  0      iTLB-loads                #    0.000 /sec 
                (35.65%)
              1,626      iTLB-load-misses          # 7069.57% of all 
iTLB cache accesses  ( +-283.51% )  (35.65%)

            2.50623 +- 0.00691 seconds time elapsed  ( +-  0.28% )


  Performance counter stats for 'numactl -m 0 -N 0 mm/map_hugetlb_1G' 
(10 runs):


           2,506.50 msec task-clock                #    0.995 CPUs 
utilized            ( +-  0.17% )
                  4      context-switches          #    1.589 /sec 
                ( +-  9.28% )
                  0      cpu-migrations            #    0.000 /sec
                214      page-faults               #   84.997 /sec 
                ( +-  0.13% )
      7,821,519,053      cycles                    #    3.107 GHz 
                ( +-  0.17% )  (35.72%)
          2,037,744      stalled-cycles-frontend   #    0.03% frontend 
cycles idle     ( +- 25.62% )  (35.73%)
          6,578,899      stalled-cycles-backend    #    0.08% backend 
cycles idle      ( +-  2.65% )  (35.73%)
        468,648,780      instructions              #    0.06  insn per cycle
                                                   #    0.01  stalled 
cycles per insn  ( +-  0.10% )  (35.73%)
        116,267,370      branches                  #   46.179 M/sec 
                ( +-  0.08% )  (35.73%)
            111,966      branch-misses             #    0.10% of all 
branches          ( +-  2.98% )  (35.72%)
      2,294,727,165      L1-dcache-loads           #  911.424 M/sec 
                ( +-  0.02% )  (35.71%)
      1,076,156,463      L1-dcache-load-misses     #   46.88% of all 
L1-dcache accesses  ( +-  0.01% )  (35.70%)
         26,093,151      L1-icache-loads           #   10.364 M/sec 
                ( +-  0.21% )  (35.71%)
            132,944      L1-icache-load-misses     #    0.51% of all 
L1-icache accesses  ( +-  0.55% )  (35.70%)
             30,925      dTLB-loads                #   12.283 K/sec 
                ( +-  5.70% )  (35.71%)
             27,437      dTLB-load-misses          #   86.22% of all 
dTLB cache accesses  ( +-  1.98% )  (35.70%)
                  0      iTLB-loads                #    0.000 /sec 
                (35.71%)
                 11      iTLB-load-misses          #   62.50% of all 
iTLB cache accesses  ( +-140.21% )  (35.70%)

            2.51890 +- 0.00433 seconds time elapsed  ( +-  0.17% )

  Performance counter stats for 'numactl -m 0 -N 0 x86/map_hugetlb_1G' 
(10 runs):

           1,013.59 msec task-clock                #    1.001 CPUs 
utilized            ( +-  0.07% )
                  2      context-switches          #    1.978 /sec 
                ( +- 12.91% )
                  1      cpu-migrations            #    0.989 /sec
                213      page-faults               #  210.634 /sec 
                ( +-  0.17% )
      3,169,391,694      cycles                    #    3.134 GHz 
                ( +-  0.07% )  (35.53%)
            109,925      stalled-cycles-frontend   #    0.00% frontend 
cycles idle     ( +-  5.56% )  (35.63%)
        950,638,913      stalled-cycles-backend    #   30.06% backend 
cycles idle      ( +-  5.06% )  (35.73%)
         51,189,571      instructions              #    0.02  insn per cycle
                                                   #   21.03  stalled 
cycles per insn  ( +-  1.22% )  (35.82%)
          9,545,941      branches                  #    9.440 M/sec 
                ( +-  1.50% )  (35.92%)
             86,836      branch-misses             #    0.88% of all 
branches          ( +-  3.74% )  (36.00%)
         46,109,587      L1-dcache-loads           #   45.597 M/sec 
                ( +-  3.92% )  (35.96%)
         13,796,172      L1-dcache-load-misses     #   41.77% of all 
L1-dcache accesses  ( +-  4.81% )  (35.85%)
          1,179,166      L1-icache-loads           #    1.166 M/sec 
                ( +-  1.22% )  (35.77%)
             21,528      L1-icache-load-misses     #    1.90% of all 
L1-icache accesses  ( +-  1.85% )  (35.66%)
             14,529      dTLB-loads                #   14.368 K/sec 
                ( +-  4.65% )  (35.57%)
              8,505      dTLB-load-misses          #   67.88% of all 
dTLB cache accesses  ( +-  5.61% )  (35.52%)
                  0      iTLB-loads                #    0.000 /sec 
                (35.52%)
                  8      iTLB-load-misses          #    0.00% of all 
iTLB cache accesses  ( +-267.99% )  (35.52%)

           1.012439 +- 0.000723 seconds time elapsed  ( +-  0.07% )


Please feel free to carry:

Tested-by: Raghavendra K T <raghavendra.kt@amd.com>
for any minor changes.

Thanks and Regards
- Raghu
