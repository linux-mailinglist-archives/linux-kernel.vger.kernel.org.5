Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EF375A572
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGTFXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGTFXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:23:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48658110;
        Wed, 19 Jul 2023 22:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhPjpMImemH+6+9KtI407UaOfJyw845E4+JAIViTBDDhDU74D19ZMA/UfbUHEgNENFdz3IE2Z3TqmevFJxJhkbUPQjar/l85VRIlAnjJSkgI8HYRrmejQHJHQgyBZNrFLBUav5r26YEbyWkArGgvRrhfJtWqpnGe1GbafUj4+V5v9/Ix1xGtjPQo2Kf8RSw+82fD4jvE3fUO6fFI+i12jDMe1l1u6NIdo5STTA8r7JMdKkwr03Hiru1k7/UbJ7boVCkXYsawfDT72HDhAR483GBPkQEIw4lzWAF4h802bA325ma0aYLQr7qrFmUV4AfUd0RQQv0JcNyOrwrdIf9RjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VH8kNJQoWZnGJvJ3Ujq9xB6KfKUzhbTqT9UF8LJigc=;
 b=jcvPaUwf+wuM9NQL69mUcgfiz4G2/fjKW6/c4BFxMTKlTHM9t3NNub9MYHYDo/mjv9nlY+8XuOrqxRAJnqx+aJHmVkgqmbqq3MfsQ1E69n9PJV+KkI1nWcjB8O8tTTDY7rVhc5cqnU5k1a4AQl5xrwYWa26BXF+qH6ySj650Vgl46YOkDD5yMQZQui0WmHHU3hk+AEiKm7WiYn8cbVj7nGOm0LjXQMAZsdns/7X/fm1wuAfaYcSAXBffOwEE5Hks5zKGOkuQc9ax4H1CXnGPZerrDB4bVofj50x4I24vnjoCK08L/0P7qbaDlOOZFAjbm/yYZQOHQP+O13efM+ZKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VH8kNJQoWZnGJvJ3Ujq9xB6KfKUzhbTqT9UF8LJigc=;
 b=cxVtVS9s9oqAF2d7sh5hwrjbHootpct/fX/caVECRSIp+MJwVmH8Y1SS1jmD+bTR6Z289d9XzbcUHdPXU45qL3b45yohH4Tm0IIf6GBdXCUsLgry7gIsKGMJgUt4fhFmzhV+GUoThj++3liavfF53wy4f9fXUq3C1fvhhJ4eEcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM6PR12MB5519.namprd12.prod.outlook.com (2603:10b6:5:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 05:23:23 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f535:4eb5:f7a0:ebac]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f535:4eb5:f7a0:ebac%5]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 05:23:23 +0000
Message-ID: <fef0492b-60c3-70ea-c7f1-370bf2734fc3@amd.com>
Date:   Thu, 20 Jul 2023 10:53:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] perf vendor events amd: Add Zen 4 memory controller
 events
To:     Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1689748843.git.sandipan.das@amd.com>
 <a70b1ef6ab427b768f21401af280d235dd095412.1689748843.git.sandipan.das@amd.com>
 <CAP-5=fX1NQzus3MQapmBrdgEhDG4+XmawgytfugHHOKD0E-COg@mail.gmail.com>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fX1NQzus3MQapmBrdgEhDG4+XmawgytfugHHOKD0E-COg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM6PR12MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af4f0d6-612b-47d3-d2e8-08db88e16fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOJp+M0HezeNGQGBNj7BSHr9GsFQefd4Im3nCft2TDsjAw34OOhnt9KgJGxAFWbELFACwK5z9iFDxy5FoVz3cNVBOInE5yJtR8aOFk+Ly7Kq241EQcRkenIpU1WY3oVnhiHba4NwXGtFrelgECxBGSO+8cladcRUqPKu0LBOT87TxgvLmA0pziBEA+DE9Z3WLBw/CYipl0qHmMLUP3zOJXrd500zkrDIr56kWkjDq0BeK9J6Cku8rdxoeprbzsQLnthPjp1accB+UXijWAMiaUb7srGR/UV0+cJBOICGnR1rs2CQcjLDcUbVZLslWOR4jgtoCAwXPjBAYDgKjeoncn53jIAJrazDztHCWBDLywWnIDMrxDNOgZpJYN58ZPVRNH+QSGZCSpqeBxzfxke1POONhxK+1dhn4MrUbdvK+dEvTSoZYQNQHy6HFr/RLuSDYMqyPMc1pDh4vhnLid36/4ExZXZK5tLFA4ew495lXelz5jcJlguVJi7MqSccaOrSML3A8TH5raK9R61oojdivM5J5upXmxvAnElaNhL/IX0frmFTaT9zgfXspeJ3V2I8ZsicpuIBwRJfssyeGYGZi+KPY7VnWD11ZJK01XQFmJPU475GNCdbOBVNQJxKez2Q8PJeRW1K5P3DVzJLJHW84Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(31686004)(6666004)(6486002)(478600001)(6512007)(83380400001)(2616005)(31696002)(36756003)(86362001)(26005)(53546011)(186003)(2906002)(6506007)(4326008)(44832011)(316002)(6916009)(38100700002)(8676002)(8936002)(41300700001)(66556008)(5660300002)(66476007)(66946007)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTNLaTYya2hqU2MxMjRJVzFhWWJRWWVnaDVXb2czRUlLOTZFNkdFRzlGRjNj?=
 =?utf-8?B?YndYcVBzeWM0ZnRzTTlqQ2JXamQ2dXhZaGFoSUt4MW00bGVpbW9kTE41ZjNj?=
 =?utf-8?B?SkdXV1gxaVpQVTdTSUw5UlJXWjh2OGhIbHdQeU9ZaEtCNC9MNEJkaHVvbGNN?=
 =?utf-8?B?TXJQR3BaQXJlOEFBeUFWMzdVUHVEMGh5bGtLY29ZVmtLUGMxaFVqZGppUEhl?=
 =?utf-8?B?M3pncEhiNk80Q2NqTFp6U21hN1VkL1hDc3REam1INWhUQ1p2ZnZMYkhNL0RW?=
 =?utf-8?B?a0l0Vml4QnJ2emdaN3BEYlhtZkNZUWpyT09kR29Pd3F0dENITko2bytabDdP?=
 =?utf-8?B?dS9DTkJxUThORDgvRitXVlpFWEpPQTRpbW9GL1RGRjFYRmsxMXA5d0RWNkt4?=
 =?utf-8?B?MHR3eUMxckQ4ZHBKeEw0VkN4b0hUUnNxelcwRWJFUFJmcit4WDlpL2dMU0h6?=
 =?utf-8?B?cUhFRFlzaWJ1ZU4rZDVPZnA0MERxbThabDhpWEZFRWRKcDdOTTBKQUNNdWIw?=
 =?utf-8?B?TGVzRk45UEgzWUkzcVo5VFJycjRZYUFicTNPQkJpU0ZWWkI2Z3lwTGhxeW1X?=
 =?utf-8?B?d0pmczJWZ2E2ZXMrUGtqaTN6bng3dkJ6d1pJTm13UGhVeURvS2l5UnZqZkVl?=
 =?utf-8?B?azdsSkJBZG84R2d2T0kwK2JzM1dNSlAxek5MMUFPcjVMQ3VIekxFM0I0WnFS?=
 =?utf-8?B?Q0o4cTd1Sk9rYlVJZzFDNXhVb0lEQVdIc2RSUU1aT21KQkdWNEZWbkN6bFha?=
 =?utf-8?B?YS9nc0YyMmFHM2NPbVp0VllsekNBUTFrNnF4ZnhCM3J1L09VcGtPL2taQ3JV?=
 =?utf-8?B?QUZZWHl5RFo3VWpkM1lrWGh0YkF1RkZhT2hhaEtkVjNpNHU5Wmx0UVVuWjM4?=
 =?utf-8?B?b01hL3p2Sm82bnZqL3Y3Sk1CYnBaZWlkalJudUFKRGdYZ1NReEJNNFp2TmxZ?=
 =?utf-8?B?eEFNOTlkdWNBQVBMQ2tpV1oyemJ0NitaZmNBTmlKdnhoZm9VQ0VQZHVOa1RF?=
 =?utf-8?B?ZFpvOTJySVJyNitaMi9tYlVkK1dHYkM1VmN1VlArdWVQam1sT0dmTWpNVlJm?=
 =?utf-8?B?Zml2eTJ1VHd4akk4SUlxckNTcUFvNFZDVHVEaWpxMU1rTzhGWDErb0ZkR016?=
 =?utf-8?B?NDJ5UStpK2VnYTZ3YkZMUkQyNXNJRmdRQTBXSUhrMERTQ3NLT0wvbFRxY1ZL?=
 =?utf-8?B?S1I3WUQ2Qjg2ZG5ZV2hwS3hSNFYwSDBJZkdqelRZQytGZ3RyNEZuaFBBcy9Z?=
 =?utf-8?B?SGhqR0JvU2hlNVBXU0hvWC81WW9UODlzdmR3YS9naXg2UmdPMC9ybFBGRE5H?=
 =?utf-8?B?aUNaOEdSZlJNZ2N0ZnMrWHRqem54ODZpS2dvZDlTNFo3YWJ0cGdPUzFiRE9O?=
 =?utf-8?B?NU9NRVYrMlF0QlhRZjhGNWJXbEVCWVZDa2IveGM5Y1ZuUTU0dXRTMlQ2cE9K?=
 =?utf-8?B?SnpvaTZVUmVqUS91QzlKWXo0dzV0RjFHZDR4ajI3c0Q0bEU1emwydGw2TzlQ?=
 =?utf-8?B?U0t2bEVNRk9aNkJwL0xmQmdsTUswVSt5L2hhREwvVnE5SXJCaXhzM2MyL1Zi?=
 =?utf-8?B?NWdkR2N6SnAxY1VqM3o0a3hqZ2ZrempqWXJlSmNQNHBZUG10SElxeEJZTHA3?=
 =?utf-8?B?YkdWZFJDV3ZuclR4R2JRS2NiNkpUTktRNVhWOFY2amxEeWZORkFkd2JPajBP?=
 =?utf-8?B?M0lEdzVWczQ3VmJJNGFZQjl2b1FJU3dIc0FlQXp1SGNZeDljdE10YWxlV3k5?=
 =?utf-8?B?OE1tZk1LbnN1R2lOUVc5VFpBWkZyOU1iQjVMY29JY2VlbS8rRTNIS09xNUpE?=
 =?utf-8?B?aWtDNWp1S0ZIV3hPY2ZyQjllRnhBRDk1TENsdTV6c1dlWHNCVGNMV3lhcEp1?=
 =?utf-8?B?dFJQSGE2c202Zk80V3NPSWVyUEJOUVdvWHpkZEFaNkl1T1NrZ3V6ay9BWmJ6?=
 =?utf-8?B?K2tqcHRQWkJkTG1CREtzbFl1U09OZEJPZGh2V1dnaWMvSncydi9kNWRMSDBo?=
 =?utf-8?B?L1lJV2ExWElvRzBua3dxQ3BzRzY0LzQ5Z2ZJdjN6M2lYVlBNY3BYcXhodXY1?=
 =?utf-8?B?ek93dE1lT21FWWhVYTViMnhZN3hBbWFiVG1iSWk1YWhKRDdiVHJ5YVhJd09T?=
 =?utf-8?Q?7QGwFqhIAPK+uMO8OU9A9g7tL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af4f0d6-612b-47d3-d2e8-08db88e16fb8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 05:23:23.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QUk5nrMLG7JhvAa6cWWD7RzNhTfY4XRNcKNKV4HMx99m8oTUoiGB4Z6sXHHAgcVE3NO+vivWO/f94vo6dPDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5519
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/2023 9:42 PM, Ian Rogers wrote:
> On Tue, Jul 18, 2023 at 11:58 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Make the jevents parser aware of the Unified Memory Controller (UMC) PMU
>> and add events taken from Section 8.2.1 "UMC Performance Monitor Events"
>> of the Processor Programming Reference (PPR) for AMD Family 19h Model 11h
>> processors. The events capture UMC command activity such as CAS, ACTIVATE,
>> PRECHARGE etc. while the metrics derive data bus utilization and memory
>> bandwidth out of these events.
>>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
>> ---
>>  .../arch/x86/amdzen4/memory-controller.json   | 101 ++++++++++++++++++
>>  .../arch/x86/amdzen4/recommended.json         |  84 +++++++++++++++
>>  tools/perf/pmu-events/jevents.py              |   2 +
>>  3 files changed, 187 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
>>
>> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
>> new file mode 100644
>> index 000000000000..55263e5e4f69
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
>> @@ -0,0 +1,101 @@
>> +[
>> +  {
>> +    "EventName": "umc_mem_clk",
>> +    "PublicDescription": "Number of memory clock cycles.",
>> +    "EventCode": "0x00",
>> +    "PerPkg": "1",
>> +    "Unit": "UMCPMC"
> 
> nit: Why use UMCPMC and then rewrite to amd_umc, why not just use "amd_umc" ?
> 

I followed the convention that has been historically used for AMD uncore PMUs e.g.
the "Unit" for amd_df is "DFPMC" and for amd_l3 is "L3PMC". I do agree that its
simpler to use the same naming so will change this. If you prefer, I can send out
a separate patch to change the unit naming for amd_df and amd_l3.

- Sandipan

