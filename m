Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083AE78BDFD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjH2FiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbjH2Fhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:37:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71564109;
        Mon, 28 Aug 2023 22:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltthbg23CqgHU8kaJlaGRb2U7h3YNjUczZkkOlhY7Qm4WligGlTIiNLt40ZeDtmeNLSd7bAlzpowZi68gr/glXRtYs0gnnYEKZ2aV7ouBhqj+TieO6DfBeohgVgjMvbf1ZQ6LaXPt3T8vEjDnrTqdgvzhLf3sm1PVPTqgWAN6Nicko2XiKm9UB3sB9uohLyoKi51egBxA3x4N7oJSElUvF1X3dSEV7f40rvTIe5GjhdESeXrVVcnEtU3ezBwXGZxtO+3xGENqojfWEQ7FxSbZB2dfMcd85uwYseix0FugVsrhMEVLn6mppgmo1oByE3e6pT2NJm2qMxV76Ueox1S5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXXKFtFsylI1dB7j/q3ne0urc1wlsMKYtKt3DzfYADY=;
 b=c7bQfBOt+531qIIv1U0QMa5RVJ96yIyrMqa+/twF+DfRC/So6ZioB5Fu1FhXL2yG06X9VoSfe0ZD9cW1e81xJ/ITnfJbh0FOHHWnQMy/bKSfjL/HfGAsPnPCtRNuNLA1LizyyK0FsdPAXURHo29ZFUy6H2ITBqEjo5QlZWevyvubiYW2iPq4Ouez0B2voOvTLEL8RNTpt6+clb6dqck+2Lzed2qbZbXOZJwDdp5nqpTFUjiYacIN/nQfoMzhKgEe+J0pCFwyZZMuaN7O713VYjHpueNFzg+JG6ZfOi2sjUKio3W5OgoTjde/MN25UqrOJ2Nyv6sp+TqDk8sBzg3n4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXXKFtFsylI1dB7j/q3ne0urc1wlsMKYtKt3DzfYADY=;
 b=BrykRFPpN90CB1rf73c7S/twIeuRlSlXCaGW88cbmS3vwuRsE0yJTeRY5T6ZlNOpN6G6IyTuzDxlhlDJzW8uvaI/ZSeRj8fU7i4sLsaAqZGxx9rHsY43thBdMndfMx3Jet9NSKPE2YLTP1ptT0hYkBeuMqFSSzyUpvOeL1eXxQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 05:37:31 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a4ed:10a6:876a:10d7]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a4ed:10a6:876a:10d7%3]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 05:37:30 +0000
Message-ID: <bcfabb85-4dc1-e642-4a82-f3b8cc009b0b@amd.com>
Date:   Tue, 29 Aug 2023 11:07:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 0/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, acme@kernel.org,
        irogers@google.com, jolsa@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com
References: <20230826032608.107261-1-yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230826032608.107261-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: e71dbee9-9b96-4a4a-5a0e-08dba852098a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVzpsxoTjMvuAHkGJrZ63W1Ve2f9ZcjwRGJ7swmZuas9lVpKw4Qc0xMAMQxqEX0eyQa5MbYLAyg36OE0SepTzC56E+FGBVdWkdYbGJNBaHR6NLicrlFfag1C96Kc7vkwk5HSAhwgQJDdgMcNvNeAzU8pEJWHbgW/2jtg+s7Hv/JVGYltqWwyRXy6N8+RKZJnpSfknX0hhiXV0jd5XZ24y2fQ1hkSz9gaCP+8GpQfQj+fQzDHBJ9hl8Rg2SqbA82gwGb0Mij6RlMlXqjZ7uKEwLyV9vy1cxbXbaRNCph8gsoNLj1eNOL4+bxGFdpPqWYvCEDBo6hzHkpA3IYU3qL3wrbQgc7vIn8UlNYh/8/NZUW6x+xk+Okcj2p8pO7A2oX4RQWS00defPXek0ToVtnngwwQ9vYJDkD7YYRTcqrGcVcxjw8iOiMEuJZYHQAFtAwVRI9dtCkyuG7SWVjNwa9Vhnwu2roqyzudWy3J2hq7718fmwP8ORkWV/EMkgB1EioSLYyy3GOHntFHS0tduCS0YfbVFeDHqKW7i0ygY8jM/pnEELhj/UTJ2Tw0p3beJnIJppFrt4Ya6j/uu9+xtW96yX0XPlrHTwUMdZCc03LUSPgN7grDAEyUYUg73gIFF/YZP1dSMITS2ZzLaqp9rMfpSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199024)(1800799009)(186009)(31686004)(6506007)(6666004)(6486002)(6512007)(86362001)(36756003)(31696002)(38100700002)(478600001)(2906002)(26005)(53546011)(41300700001)(66556008)(66476007)(4326008)(66946007)(8676002)(8936002)(5660300002)(44832011)(2616005)(7416002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0wvUUU5UExhWDVCa3hvS0NoV3pBT0FFTWw5b0NKc2Z0RERQNkRZRS9KQXBn?=
 =?utf-8?B?M1pXMmMwalVSZDFzMmdzVWlEU3lKWmkzNlB0QjFaYkhSRC9XM3VJMjhnNkZI?=
 =?utf-8?B?aFRtelE2TjlPWENuNjVNTlV6UXBkL0JsTDFjMEFITVlwMVNrcTdGTnl1MTB1?=
 =?utf-8?B?QWF3a3kvd0pNYXBhNWFQSlIvR1hFcnFlNUdUeENUakVnaDlSTDQ3ZmhycmJE?=
 =?utf-8?B?by95SFVJQUN0Z001dmZ5c29HaDdFVUZaUU5hcFBzVURQNFZkbTluT1JHZFJ2?=
 =?utf-8?B?MXlKUHRRYlI3KzJYN3lFQkRuNy9WZHpRdnYyMm1VakxLTWFpeE5wdkJnMDVi?=
 =?utf-8?B?VGpIK0VJc2JkN3FHZnBsRUpnYmxnSGlyN2pJelJYUXF3cG9FYVBPQ09mT2Mz?=
 =?utf-8?B?R096c1k4V3NxTDgwRXFoQzRxN0szdXFyWXUxNC9pYTFROWs0VCtBWXlOd2Vv?=
 =?utf-8?B?Rm9nYW8yVHF2ekIxOFFQb0RwUXhvRTZQaGl3QXZBZDVia253L3JMejdHUElU?=
 =?utf-8?B?RWZhaHJ3T3MrbllUT0hQY0FSbXBhNXpNV1JrK0tmNmtnMUlRMjNIUjVTMmkr?=
 =?utf-8?B?eldqNjFqNTltL2h4VWRKdFVIcjZLY05SMlN0R2JtUlNYaW9zcGIvenRwdS9q?=
 =?utf-8?B?M1Nod002N1FRRnRhd3RtaXA3TUx4ZnJ0NkVoMkc5a2xRaU5ycnpNeW9xYkxv?=
 =?utf-8?B?QVdTWHY0cEp2VUU0eTliWjd3Q01RSTh4cEkrUTljQ1JVK0FvaldRc0t3TS85?=
 =?utf-8?B?YTUxSFBZaU41SGxRdTY2TnhOT2tXclJITk9ZbEErZXF5K0JHaFQzUUVvVHZQ?=
 =?utf-8?B?M1lQdEhYbWJJMlEyNGNoUWRMbWp5Ym4vSnh3WXI1Wm9JYzZTbkllYVN3b1hy?=
 =?utf-8?B?MnBZRDVKR0JJYWhNRnRDQ1FvV2wydUw3RkE5bXpCbWJZSVUxd0UrZEFyN285?=
 =?utf-8?B?V2s4QjZSL1NuOEZRQW1hTmljS0pzU0tvQlNoajNUS3pOdW1hRVBiM2E3aFp4?=
 =?utf-8?B?S2l0S0IyU1pXa1BWYndpN1NXMDVDTTVhcE0xd0gzYmJRZXNkVEI0djMwZ0NL?=
 =?utf-8?B?UngvR2w3S3gyM2ZPQWdUaEM0Z25uUllORnE4YUk1ajRmZjZwaE13dFZFUXYr?=
 =?utf-8?B?d01aaHN4U2tQSXJ4UGNTUVlHR3YwWGQwZitkbnUvN2hyNURqWVNmM2JSV0hl?=
 =?utf-8?B?L1dwWXlxVit2WWEvM0g5SUppZFV2VC90OEZPRGlxZ1JoQVdwbDNBNlBjOGhC?=
 =?utf-8?B?RVVEYW1leURwSERKTmJGOStHMks2OThrZFRUb3pMVVVkcmVDSE1oRytWRDhY?=
 =?utf-8?B?VURvYXB4cS93bVBDcFEyYk5SeUlOaU5sbFJFVThXYytPQk5RYWtlUW9TVy84?=
 =?utf-8?B?VktONks0d1pac2ZBbzAyenE2SFdLdG9BMTJQVHJJRURLaU0zOUlDbHhyY2xr?=
 =?utf-8?B?bEMzbVE5SGVwNkc0dnpMbkR2b3FsRnp4Y1pJV0hOS3dlekljYlVKRmsvWWtW?=
 =?utf-8?B?Sk8vTjZkZkhERTVCcjhPdWhURjdkT3ZIZ3I1WUZ4eS9aQjZxNGVOYnplbG00?=
 =?utf-8?B?NUhWT0dWOGVVVDBqam5EWkFTbXdyb3NzcGF0RnFGa3Jyei9hQmZWSjNoSklG?=
 =?utf-8?B?WUo2WDZIWWxEZVJpMEFsVnhPSm5zSVczYUJVeUxLMXh2YnMwOFkzM0wwNVNK?=
 =?utf-8?B?QkdKbHZwT1hta3Fad01yd2ZiVHV6SE5IUTVKMml5QjFLTklmT0NKYkhka0Vt?=
 =?utf-8?B?Rndpci9Ea3JGTWdIeVVCeDhEb01iOHIwN3ZTM1g1OVRqUVFramVLMkdFZE1E?=
 =?utf-8?B?SlNVNHpHd1ppa21laVJkQ1FTMmRvUDA0UGVUbmlScnd0UmN0VEZkbTdnazRP?=
 =?utf-8?B?Sk5reTE4V24yTlo3eG1jaHozNStnL3crRWZPdXAxSUVOQTFQZkZoQzZSbnFM?=
 =?utf-8?B?MlBNM00yYXFWQU5IZFNVbUJ6SkFNelNmV2gvZm5WYXRxOHh0QkpYQUh0WW9R?=
 =?utf-8?B?bTUxNFdoQmFNK0dONGQ0Nmd5eXBTc3MwZ0ZXVWV4a0gvZGoxMTFrL29JZElp?=
 =?utf-8?B?QTVHZTB4Z3BmTms2aXlhd080VEhuUGU1R1V5YWdJdXd2TmFmRm9DVytJbytv?=
 =?utf-8?Q?LMLoktOBxT2DYfSv2rAaz2V2P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71dbee9-9b96-4a4a-5a0e-08dba852098a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 05:37:30.7735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIwkDUrOFTrFRzVBBh2f6cwvrvY0PQ1MbpUsfSEHB764Q8wSSiBCSgwItsZ7iMbLwJSiN6UH4Y2JgWlRA/dPqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-Aug-23 8:56 AM, Yang Jihong wrote:
> User space tasks can migrate between CPUs, track sideband events for all
> CPUs.

I've tested this series with simple test program and it mostly works fine.

Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>

Since we are recording sideband data on all cpus, perf will endup recording
lots of unnecessary data, esp. on large systems. E.g. on a 128 cpu system:

Without patch:
  $ sudo ./perf record -C 10 -o perf.data.without -- sleep 10
  $ du -d1 -ha ./perf.data.without
  3.0M    ./perf.data.without

  $ sudo ./perf report --stats -i perf.data.without
  Aggregated stats:
             TOTAL events:      47011
              MMAP events:         51  ( 0.1%)
              COMM events:       1549  ( 3.3%)
              EXIT events:        105  ( 0.2%)
              FORK events:       1544  ( 3.3%)
            SAMPLE events:      38226  (81.3%)
             MMAP2 events:       5485  (11.7%)
             ...
  cycles:P stats:
            SAMPLE events:      38226

With patch:
  $ sudo ./perf record -C 10 -o perf.data.with -- sleep 10
  $ du -d1 -ha ./perf.data.with
  15M     ./perf.data.with

  $ sudo ./perf report --stats -i perf.data.with
  Aggregated stats:
             TOTAL events:     160164
              MMAP events:         51  ( 0.0%)
              COMM events:      12879  ( 8.0%)
              EXIT events:      11192  ( 7.0%)
              FORK events:      12669  ( 7.9%)
            SAMPLE events:      38464  (24.0%)
             MMAP2 events:      84844  (53.0%)
             ...
  cycles:P stats:
            SAMPLE events:      38464

Number of actual samples are same ~38K. However, the perf.data file is 5x
bigger because of additional sideband data.

I'm pretty sure we don't need most of those additional data. So, thinking
loud, should we post-process perf.data file and filter out unnecessary data?

Thanks,
Ravi
