Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2B47F6B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjKXEAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjKXEAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:00:45 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F99CD6E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 20:00:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNrR16/RqQnat68IEOStJd/eFzy7uqhWKD6jViLpyB35Va7WWP/phN2UzdsueoLkpISL9xv7ZXKvRm7VFj8ljYp5mRPWPh3hvlghIOrQAzkQSIeQ9YO67mO0Yz34r6Bhey+LX/3QKTsrDp0u5Ca7AVwcmHMjP1SVzIvWlBYLJd9s5UoDS2xmywNYnq9yRyd+75e5VVr4CjUtgwLUVXKW7NllQKB1AxtWrYPrHpBehNv/1qiBKsMSRvaTn7SotfL+Od8XQeldYrFBHhUI1xC1lfPkygIrwj35XA7BPUQh8WYlJYXCF490htFfLvD5KL82rUDAjCIyvTSwWFlLapdDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2y81vqj6/VHE3EzvfsY9coVLuiRP44PxHPx2gpKP4A=;
 b=KI8MRMa2ncGH47RuoLiCBvSc0LpngL99V8IzmPX183vCReL8fdP1xLvSAK6/GoMvWGWTkL4Z8XoiV2FanCrD5QquzBjjvrXaHZy7qdxGYoDRPpuqJ2dgwBe0vuyGMwAgsJ42aF9J5LdEXhPohN3+F1/PrprFkgmAadmEBQSLz6lNUhE7nBgN86a4dumzT3cw/bJJ4AhS8xGtiiaJtRwXozZF/o/7MF865GIeYod/gFqSEhs9y/VYyVcsR+OBUKg9HsA8Y6QeScs4PYgyxj1JacgVN3c8bkj62/uZiN3QkfoEiPqAK0r7PFhjbF0FPAjtwYZxMWJcjMHQxNL/Xbre6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2y81vqj6/VHE3EzvfsY9coVLuiRP44PxHPx2gpKP4A=;
 b=rGS5gpcyHHvKEck1pJj1ujd+w63ftg7n/PR5nmmjqdU3hty9caE7B+Wc/hZJCBTOQGnnaGpVBW+m7BoJ/w8YhIaJ1h7c9b97Aql1yqDKFkrB2Mhw0ff2kM+7I7OsQO6Q5UyWFrfOiymFWh0KhS1ZiiBVR+w05GfApDLttfX+LIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 04:00:46 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc%3]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 04:00:46 +0000
Message-ID: <3d70b52f-2042-328c-6dc7-37fcbb3510a2@amd.com>
Date:   Fri, 24 Nov 2023 09:30:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf/x86/amd: Reject branch stack for IBS events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230602194513.1589179-1-namhyung@kernel.org>
 <c5a40920-0b14-b9b5-19ee-48c965bd12e3@amd.com> <ZV9lfJyyC7xawHBC@kernel.org>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZV9lfJyyC7xawHBC@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed6504a-a923-4997-fb48-08dbeca1eff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iu45DdkrgzbX0Y7RHxWVFZhUJ2xMQ2GjtUJoLQduHl5yh0dtHFQKQ8969Kt0Vemc1QWN7Ek00WDYBirQyGrd0NacZFRPqO6Yf+53Wy4de0U9AMZhdUXhXrF5jCS1oaEc3iEKUUg9D9keWmFRnKQfG+U3YkOUWCKhLqXOoh6qdD48KMm7Hh48G7IcQq5De8LrYD7tGsvmErO2g7U+BtTA6Z/qN/Ps/c4lqjZln/59Ef7L+wfQJfMcZvboobJXyKUoNyQIWTD+FEKqd9aIHzRBYb4zCTriy4i5PcAYMCXby4owvbq7RVLLiEhzKprirtwiM5LXdxzwQx/JGSbm/VxVhJPX0VKzkWn6fi42Vgff3GHXy4eQrmknOlQKyMMRNJRteI/1LEBFp34ojaSVA75G/A3tNKiGq03UTqtRevTxYS9zI0FO1BKEFxe9oz6z38eAteVrOqSOcuoC/IZdXEvIl1Aq5UxECH80kAE/7R8fCjj5cXsWcqPUVdd1P5D8Duo0Zij5Iso6F//xBlBG2Z4WveJ0jDSYw9flG1BbndNL507JmhI7YPwUqEBpHGP7J+FT7Tn4zIwTH82IP8Zag4Mhb7wAjMN3WZRu66BfMuR9F2MNRuZ2BETd9Q4i/u28MU2bDNxT9+zwypMaSMcBz9iEuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6666004)(53546011)(26005)(6506007)(6512007)(8676002)(110136005)(316002)(66476007)(66556008)(66946007)(54906003)(4326008)(31686004)(6486002)(2616005)(478600001)(8936002)(38100700002)(44832011)(86362001)(31696002)(4744005)(2906002)(5660300002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3M2aHJVU3ZHZ05hVUY4d3JsWFlHN01YSVRYUWNZbEF0a0dmMTVTVU9DVUdh?=
 =?utf-8?B?OEpGTGJVekpRN09MeU5wQng2bTRrdWVDWkFFV29UV2VuSE1OM0tLMjFvWmND?=
 =?utf-8?B?STJDQ0o4SjRxRkxwV0JORjZWQkMwMUp3aDAzQzZBK0UyVVNNOFBDK0doTjQz?=
 =?utf-8?B?aStFMy9va2F6UFNjMmJwQmgxd1Rka1RGT2lHTGRkeXRLSDIyOVBENHlXc1hK?=
 =?utf-8?B?QUdoaDkwZDl4ajRLMEZkVFkxNzRBNVRjR2laeXNoVlBySlFkVUtLZVJmMW5Z?=
 =?utf-8?B?dlVvcVNjRVBUMC9IVktZT0RsU0lFcHhWcUY5SU9HQWlJUGJtRVpLVzBBM2dZ?=
 =?utf-8?B?c01hblhtaitlMEpMRW5zS21Dbk5hRmFEcElCV1ExSit2b2dYQnRIcWo3ZXVT?=
 =?utf-8?B?VDhtbmdXZTNHR0w0UnJkQXY0Sm9DR1JHQ25VS3dvYlNVVEFCb0o0ODVYWEdx?=
 =?utf-8?B?blVFbHNqOUx0OGVobGRCRW83Q3ZGN0xWUFl4RWtmbFg3Rkd5Z010TUI0MjFD?=
 =?utf-8?B?bHJ3bENDaEx1UXI2YnRKSmE2K3I4L0Z2NlJ6OHpXVmNGM2pCcm9mZXJhTFli?=
 =?utf-8?B?WVN6a01qM20xbDJxcFNJR1F6NDBBL2pjZEc0WjY5TzQ1SHYxUU5YbFlOQXhT?=
 =?utf-8?B?Rk5FeTN2YVU1Lys2OCtmMm4xVGs1aXZvVUlYVTVLeWdqZ1hIeUFrSitLeVFv?=
 =?utf-8?B?UDFrQVpOUGo3cTBvY2J0Y2tJSm0xRXdwZnpvcUdpMmwzbDRlR3UzcU42U0k0?=
 =?utf-8?B?KzBVSVpKeVUxNERaY213alA5MmF4RUM4aEd1WlpCTGtyVWdmUE91NnBHZ0dV?=
 =?utf-8?B?bWlPTjdIUUhsSCtMWTZpN2h5SzBBMTVDVnNnWDIxKzNyaFY0V2tHNnhnWEVj?=
 =?utf-8?B?UTFUaEhtdEdNc21XeS9INDRGTldUY3FKbW9iMXVqemFweUVvMmlvb1U2Tmk0?=
 =?utf-8?B?MnRrenN3d3FVWW45TGFUbnlTbHVtejJON1ZMM0RoYXJOTkJ3N3REU0FzYUhV?=
 =?utf-8?B?V3RMeXR4RzRDb1hENjZRSm1ZaCttSE1wNFV6STdROUNURUNiMkNXVUNwNVpZ?=
 =?utf-8?B?TTA0OUEzZkRVblhBSzI3TERuUDJKQmxvSnJBZEVUa1dtS0lGWWxBZmpLamhZ?=
 =?utf-8?B?YkFMdTVoYWd1VmVjckxNd1VEa3kyemRWamwzeEFYb3NDRWNVbzI5VzlRTFRR?=
 =?utf-8?B?THpONC9WejRXbHhnSFV5WVlYUGpqVGlTREhSSCtNc1B6M21nYTYzT1hDNXMr?=
 =?utf-8?B?OGVzWW1oa2JKTCtTR3JIck9GQ0ZvbHNSamUzakRQbDlWN2VLZWxjSXNsQm5H?=
 =?utf-8?B?M29WOTB3d0dsZDQzc2JtRTlsWkViVElTdUtkZFcyWEp4RVFUWmdvb0gyNy9R?=
 =?utf-8?B?V0Z6SklGVmZCZVhkUzNtUEsxaUdQL3Zwb2QrR0FvZ0FFL3A5cC9pWkFrY2Zl?=
 =?utf-8?B?WDZLUmtxOHBpUVk0alptMDJVenh6UmlIM2pJRVhpZFBWU2tyTkFzN1I4UkM3?=
 =?utf-8?B?NXNUM2JiVytiQzdYOXU2dFRhaHlyQTZ1Y25PdCtEVUNpSm85eitYSGZ5UHJI?=
 =?utf-8?B?TktqY056ODBCOFg1UWZLVmRPMW1mSTVDbHhqeWtvUjJKeGZZMmMxT1Y3ZVFO?=
 =?utf-8?B?Ti9TQmxzY2pSVFIxNUZqRTBQcjQvT0FzL3hUeWgrTEIveVkvYXZndVpmZEc4?=
 =?utf-8?B?NnFMdUdXUjVnL2JKT05VMHJDeGt3ZzBOSkpGVkJDQW93aEVYT3VuckUxZWt6?=
 =?utf-8?B?MDVOd2pkS0w4TVFyY0lFZFRwNjFjUmdPNDZoRE1NTVB2aXBtaXYxSllaM0xZ?=
 =?utf-8?B?S0ZybFJzbHRKclBUdzVUTzFLc1JZS3dvRkhNc2VSRzM1Qjd6UnFkeTQ5Zk5y?=
 =?utf-8?B?ZExVSU1RZXU2OWxsbjlpZnFzeXE1UklpclEzRDdtU3RLaXZKd0pBVE9EUVRO?=
 =?utf-8?B?SnpxWlpPeFZ0MTBIWGVNRnp4SS8wZUY2VlpKY0dtVUpkeEt4aU1oOVBxeHNG?=
 =?utf-8?B?WVdDOGxuVkZiWndrb0tDVDFHRkFVMGxYb0xaSDYzYVNvbHgwdE1Gb2lRV0tJ?=
 =?utf-8?B?MHBhQjhBYit3dlNBczNwYWVuUC8wclovUlowMDFlUmNaYVNHdGdBSDNCZENK?=
 =?utf-8?Q?8pTJR52iAIxjYs5mX/byLOqq1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed6504a-a923-4997-fb48-08dbeca1eff9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 04:00:46.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL1EDhS1YEnbxblIoAh2CfRD9OcQPFsIem8GScAZF727cgnDWGBfFkR+/k/SSZWkPSooX3b+xVLO4d1H9JmYtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Nov-23 8:15 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 06, 2023 at 10:08:43AM +0530, Ravi Bangoria escreveu:
>> On 03-Jun-23 1:15 AM, Namhyung Kim wrote:
>>> The AMD IBS PMU doesn't handle branch stacks, so it should not accept
>>> events with brstack.
>>>
>>> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>
>> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> It seems this patch was not merged, can you please check?

Right. And it does not apply cleanly on peterz/queue.git/perf/core, since
surrounding code has changed.

Thanks,
Ravi
