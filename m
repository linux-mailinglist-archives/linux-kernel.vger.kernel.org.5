Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52E279B9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354039AbjIKVwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbjIKL0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:26:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84540F5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2H8QCV/j0uSxDH2/Ht5pM/Mv8+rLihIVoezUDDPWNOO8ybfrGy+8RRTNeHp1cjLx9q9bBOStNj+ZkfsH1mKDmh9cKB7SaGBfdjMtFeXArqTTnMhLeQOgiicxoFTzaQ+tlkMeBS0Rf8aKvR0qkYWb0oMhJy4elpPJXZkB1A/CfDUOvoKssodFaAhLdGaV3xw+QfF5xVE6cAVIUGFYDkVdnlfdsAOJns38jeTv/T1+oHZFOusM3WTsY65cSOOi6JYiIGE/B9cMQ5CQE0KMUegbEg9VDF4bhXT6TVlnDXOWU1wteVNP4RaZIm709Rg2n6vj4CNudf8DuSz32/Jyxl9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bp855TAvyMiJ5lJCW7YLgwQAQGre+vJ5cybQD9ZNEA=;
 b=mr4FjAcSWPCLQuIlDXBvGjepUsCAlU0xpUUyQNNR6e1H1X/ydgityF9EAdgpHt4CWzqEwmhlyFv48FuTpdA1798qUyplTcaSlzJ6KmXm9cu/InaE5jFHrnO0Ke76wLw2b5w6boxa4W7dRVTl8KZ9GyA3U0LhUkuSSaThPyPoYWlFLtX8ktnLKg4x73e+HIHaN3jiW5xhoNVcmwTPovs2uK8tJuAc/5dYiwxbOOX26+6LjH9BxByTUtU2VH8kDeSZ9dRU3DsksxCMLwfvpvmpkMRLmaNOwWXDBvDFHGgBIbXcfac9ELNTefHzJW0jsUQ0GjqXmiGHAjZ8ZucsGojGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bp855TAvyMiJ5lJCW7YLgwQAQGre+vJ5cybQD9ZNEA=;
 b=zhnwqjXSKKZQvolSaTJWkwawmt0Z4oKBPtY4brtRfIOh96W8cI24V2ukxq61VczsSn01Z1mLOk1dVXQvV/dY0wWs/2sRkxd6qUFBcAfztRjFSWsPMxoX8xhedjs9QSaKM+NCi9fPvoXommxOcP3oEn0DPqMoJxW5RHfpNyPo1+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 11 Sep
 2023 11:26:13 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 11:26:13 +0000
Message-ID: <1e8fcce9-fda4-7bf7-97c3-cb9e4a4d788e@amd.com>
Date:   Mon, 11 Sep 2023 16:55:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 5/6] sched/numa: Allow recently accessed VMAs to be
 scanned
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Bharata B Rao <bharata@amd.com>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aithal Srikanth <sraithal@amd.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <202309102311.84b42068-oliver.sang@intel.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <202309102311.84b42068-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::29) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4ca816-e76e-43b2-e694-08dbb2b9e765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKRDe2GUF2gMahRMbNRbZoA4CRSJhVBJlDng9mREHEOkg0TfOJByE+5ZldSH4s/3QHCxnHAl6BOlnl/ezor8f21BW4IHMIuv7Tq0SsGGjHOkJSgSxyA/9B6dKJEoaFtEj+A8IDlbFlLp7jPOXGjYd22lj+X+aky66YV8z8LqIRQ9BIStZCqvqYi6J8ET9qg0KLYwCyhacsiCV8/wpQ25cGu9CXdP1Ko7l2uwzXWzkJ9ius7F7L93UnyVRFNFSPKJ0+isi/jliaiR9Q0mlskbNeznSsuq6X2jfaIaGmZwG1Xcg36a6lTprJpDlM21jBsGTc+MymvAPb22tILHv1y6u0rhD+f1sfUsnMw9j1+SK8WPRyuDLoSoPEo4cBnDhBPsqOHPs3fWU7IrOUQdt22NT3YPnnZNTa+dkSkiMTPNHlkpbKO0gK/sRUW7MUDSQ3dy641Ei7bbcYWHLxecC8HakGDDsMTAoqQ6cUodGUtTnoLMMCZYY2u6iiILn6/mZoGrAsYXDoISl9Tyr+p9Ct28+iKfhTuILOp46xYeBkaaD7t+KmHHqlvsGfCX3VPcETBOfBu2htJwCYaM09p3pWabHmHPXgsliEUxgc4UbBUAn31rFLAz/vyS0uduk5VKxAy0D7z8zGK+C8nOHr2ATj3BoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(1800799009)(451199024)(186009)(5660300002)(54906003)(41300700001)(31686004)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(110136005)(36756003)(478600001)(6666004)(53546011)(2616005)(7416002)(6486002)(6506007)(26005)(4744005)(2906002)(31696002)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjN4T0YySTdiejhLSm9QRWxEYlJwckhtTDg4d0FwZU9yTHpHWVhkOHRtZTRz?=
 =?utf-8?B?dC9HbmdNQ0tOL1NaL2d3ZWY1RFBySGdqOW1nU1pqRXpCRHhNdXZlc3Rsd3Ny?=
 =?utf-8?B?UEZOMmlzMTFORm5HTzhhMHVaSEY2Nk9rVlc0ZDZhb3JlMWxiR1N0Q1VLTlk5?=
 =?utf-8?B?emVYaDZwcXNQVXlQQ00xRnBNbFgxSnNrM01oaWdjTmI4UmZiRWRXVVJaMTRz?=
 =?utf-8?B?ZnN4bzh6R1dEWXBVcWtYbnQ1YnVQbGhmRGIwbFFoQUwrcWRJWjBkV0c3TEh1?=
 =?utf-8?B?Ykk0Z01IOS9RdnpuU0t1dmFOcnQzajZPRWV5MmpDaCs1MUNUWFpkV3IxYlor?=
 =?utf-8?B?ZUl5NXc5OE9DSEVZaWczUVJuenI4NlY2QjRLaUFXRWFWR1hkV010dDcrVE9X?=
 =?utf-8?B?bThXQzhhRlJCUFpoY0dheW43TTlJZXk0VjRkaDZiZXBEZUpHMGNjdFVuT2tV?=
 =?utf-8?B?MUFKQWhEU2g3THY2Z2srNnNzT3RWTFB6L1A1aHdBSGR2R0trR2NWYjBVTzd1?=
 =?utf-8?B?U3h4SlZjWTBIVXZHY2VmVllxT1laNVBIeUpCSFVpU2JsVGxqTEtsQk96OHFr?=
 =?utf-8?B?NGFyL0s1ajNoUEdERGN3ZUwrTzNUR2JHdEdGTnpuNU9ZSk5MeVYyU1gzVG41?=
 =?utf-8?B?MlJYWEh5WWFQZjRORnc1U2VuNUJpWnlBUVUzYUliWWt5MVVSVXVSZmJOSHRi?=
 =?utf-8?B?YWFmcWRBMzNaZitSZ2c4NmxwamNuTU5RS3A2NzgwWEZmdEt5YUFLc1J2SHhz?=
 =?utf-8?B?eG1MOEtVcVRpYWxadzRlK2NrcVhDYTBtSktodkF5a2xZNEE2eXZZYkx2aHQ5?=
 =?utf-8?B?b3VpQUp5SU5sd2ZIcW54TWtBYmVSM2tWTmJkdStKTkszbnE0RDdCTFFPQlRk?=
 =?utf-8?B?a0NvcjM5OFdBTlBvRDF4V3RXanJET0FoSUliRk5ET1RMYk1EU3hCaHBpTDNO?=
 =?utf-8?B?WFE5NU96KzIxbjZrUWtkakhMOWNFcFZIQTM2QklaYkpHenNZRy9ONnU1MDlW?=
 =?utf-8?B?OEozNE13cTB4Y2JNNHJ2aUlydWRqQi93a0xzVjNyRms3MkF1dGtuTFhyd0RR?=
 =?utf-8?B?Rkg4NlBWcUJyeGR6bDFic1FNS2RhbHZTd1Ntdnk0dVhOSklMOC9zalpYWE1s?=
 =?utf-8?B?V2dsbDZueDI4ZDFkNVFpMDBITjdhbDJrVFN4RHV5REg3MjhvRWxrdktWNFJr?=
 =?utf-8?B?azlVcjh6Z1B1MEc5T3kyaW00bTlWUnUyZXQxZVRmVEpRWEo2b3g2MmlKQ0FQ?=
 =?utf-8?B?UkJzS2pLRXI0ZGs1SHo0NXkycUhuWGplY3MvQnNEQlNnMDZnZW04N2VvMjI5?=
 =?utf-8?B?QWNNNkNmUUpqK0NnZVNjMVBzNWY3MnRHR0R5SGpqR2FzVUVtZWx4VmJYWmlD?=
 =?utf-8?B?SnUwMnlPQWZwUHRQM3BKcXJEZkxwcy9MTUVETllqdkhnZVozekI5RTFrQ29Z?=
 =?utf-8?B?c1hVTWMrVDl1dlJybVZTQ0lwd2FjdXdUY1IwUzJyam93T0FPbTlUNmFPeTJn?=
 =?utf-8?B?QkFiSmluL1h5UisyclpibFFJS3pwRHhWZy8ySUNRWmFmKzNFYm1STmQyaHBI?=
 =?utf-8?B?bXU0dUpZUy9zQXpZMFpOdnFzUWw3VU9rM2g0MlIxQytpUzJQVVdoUEp4OFRz?=
 =?utf-8?B?TGRSMHRSS0hLcFM4aE11cGxVNWJEd1hMdm9CWTl1QVZneFo3YUhISHdUZEFG?=
 =?utf-8?B?R0xIZk1wc3NyQWJVRnl6eWtVOElSVG1EeUhDNzk5Q2VGZlNncWFDQTBNSGln?=
 =?utf-8?B?QjlJSW9xWWk5TGpVZWhlcDhyMHpSSTA3NlBXWk5iQXYzTEhocGl2S085SitE?=
 =?utf-8?B?TDdja0ZlTlNOa0h6NEFXR25HQnlEb3UyMWJpQUh0QWl6a1pHMjMrSUZhVkFu?=
 =?utf-8?B?TzF1YXNtaVRqVlQxMDJtQlZuc0ZxdFVZdHN0ZHFydll6VGdxcHJxQ1FjaWVa?=
 =?utf-8?B?YTY4b2M1TFYveHpLQ2lCSGIrOGNHSmtia3Vkbk9lOWVxbENSQjV4amlibTdl?=
 =?utf-8?B?TjNJRk85TnQrQUo3Q0xja1JDOVQzaVJvUmJ4emhxQ0htSWIrZDJtZk9EVUsz?=
 =?utf-8?B?TDh6d3BlSWFUa051ZkNNRVE3TnVOTXJKRzRCUXdvekU3MWM2QndTL0dyNTla?=
 =?utf-8?Q?xTwtX+UpZBCf7e6PRa1dOz+ds?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4ca816-e76e-43b2-e694-08dbb2b9e765
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 11:26:12.9667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nqkr8Utk9bSfn4Uv70UN5qDbhZNZojUjjF7HTQ1WbJXMjbI+BoxRl/Heb63Iofv+PMjmY2vCFkOyVKqGrdipUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/2023 8:59 PM, kernel test robot wrote:
>    341.49            -4.1%     327.42 ±  2%  autonuma-benchmark.numa01.seconds
>      186.67 ±  6%     -27.1%     136.12 ±  7%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
>       21.17 ±  7%     -33.6%      14.05        autonuma-benchmark.numa02.seconds
>        2200 ±  2%     -13.0%       1913 ±  3%  autonuma-benchmark.time.elapsed_time

Hello Oliver/Kernel test robot,
Thank yo alot for testing.

Results are impressive. Can I take this result as
positive for whole series too?

Mel/PeterZ,

Whenever time permits can you please let us know your comments/concerns
on the series?

Thanks and Regards
- Raghu

