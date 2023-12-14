Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EAC8126D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443144AbjLNFPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNFPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:15:30 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A4D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:15:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyqwD9n50XbwaHHlQRQoht316OCNpSNDsee5xxSEHy7BRfKOfvVLzpNb99KniKJvp/ePvyHYn3JRRdjhjbwgCBIlEW2ab47ni9zcnxKUmO2L9/HLvLItM27Jjf8bm3BxNvFfn37dZDaL6wMuYPEG85oNNBwYTwX5HSq5/zMbeEJEgQRdQUXIls5zToOWeG2zAuuTJImUN05KL+aq4dRBc0535d4rHqv1+osq7010OfP6nbZ4pb/sU7MZbr6N92+gLDr9sDxqizCaZjQ/n8HQ98anvLwC/OVxUCk9xWtHLy16wEM2UOo8S/v0IfTe7GDm6WTzccNpUzvr38HRCY/M2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1gg5NvY1w7WNq2TzTMysupC7DOjmgif5VvXeMWR2j4=;
 b=I6sYohSb/zujeVUmMjDMLr+G2qUorrcOFfhWPxMIB1XgRYCMtQdwI/RgM7nLDCh7BQhUclz+19fNOQwghvQkMwcDLMfapqbbjiPMhCON1vP0vwZjFra5I8+gXtl4do4VbDtxJudKw5Vfb1M4MdmOUfJSHMZuokLBRV0wxJUxHnxJejtgu4jEbZG8dTd+VP/FqOGAGi21kgevFQI7niegpbDJcxAzgg1syoDykEbdHAvDp6gd2I6h3S4rzKl86Q+MWqJgfM2G6kRa1wPHjx/VGH7ynwZIIfFwfOpvRzuHOO/q3C9y0HW39KOSguE6rH81ZQWFImpiWFyVfB7uoUs2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1gg5NvY1w7WNq2TzTMysupC7DOjmgif5VvXeMWR2j4=;
 b=lhsDNPOfBaQl9eio9qCwoTfCJJO9kHtpKVdpQitq4kqdKtmXyCyOk2dmJ86bvnIuGiNWUBCSSK+zRUhye76HABNB5k3Av5zN5104DRdmg0ReB0eM/A0xwRA86R5o8up60+O6VX9f4iFkZSg1kTvFmlKxRRIeYSWoBuARYxQfQLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13)
 by CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 05:15:33 +0000
Received: from SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::3f45:f356:9284:d31]) by SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::3f45:f356:9284:d31%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 05:15:32 +0000
Message-ID: <5fe8b838-ffe6-8f5d-e23d-61c58bc7f6b3@amd.com>
Date:   Thu, 14 Dec 2023 10:45:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 00/20] Proxy Execution: A generalized form of Priority
 Inheritance v6
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Metin Kaya <Metin.Kaya@arm.com>
References: <20231106193524.866104-1-jstultz@google.com>
 <c6787831-f659-12cb-4954-fd13a05ed590@amd.com>
 <CANDhNCqcviNOZTi2G9R21K-p32uM0U_LLiiEBjveJ4gikk8wrQ@mail.gmail.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCqcviNOZTi2G9R21K-p32uM0U_LLiiEBjveJ4gikk8wrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0201.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::13) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2381:EE_|CH2PR12MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cec9207-5ab9-4865-d273-08dbfc63b16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfTmioCyMDDpveVgKPcjnET/BPMlkLOIR9pB61JRTP6nP6INPldhzSqYOW+x+pmSOe+UrBLSADihFkmEz/i/PkznKrYTMMU94JCxO/efzMaQ2Qe+SIB5qBR5wnzMhA+GDqmW+oI0Si/+R31T3rYGt7QISgXgLvLyAGpvh7AvU8lBEWRxTeAshdkytJD9gsjUjuDVYSSSa1DyjibxuHkaGTNSZULou5xSNiIC1OpgAbZG8XvXmFPWkp4q2sKckTLVDqzbw1WKURpem+XHkrZPAmGowg7gKTw5kjkX2AysICG3j70V5w1cCy0l5XztqquMVXgxG423Jp1nGqkBS2rJjd+J1n/S7mKLQTT0Kxt0jUsLrO67JFdNxKG7ms59+BArcw3OWW2Bgl5OKOKLhmKd/vMQR+UrDhwlFx7fofusyWBwpOnwWmocoDyNLfc0tkhY/oLzYJ8pojB1COI+V6N7+swEu4N11a4RwxALxgNePGBT/RLsEcagFPrl/yMbTaEayluvo5ttsje4dlVu5xErI6FTEbGDnlrUC0RUm450YGjnab+qEvTzPuhskAvFCSW4f54gVrs7XBe03ENdpAHs5T4mgh9b0SuzqGvpucODL9LHxWZIBwTDfiUc1eHh4eOhLifLrtCMR4lPnf2F1NjcDOHlo7+8hDTAqiuMUW97J1izIs8saXT8DN7PsAmQLCLiMAT7vmRon1N+m0nSsNOiuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(2616005)(6506007)(6666004)(6512007)(53546011)(83380400001)(5660300002)(7416002)(41300700001)(4326008)(2906002)(478600001)(6486002)(966005)(8676002)(8936002)(66946007)(316002)(6916009)(54906003)(66476007)(66556008)(36756003)(31696002)(86362001)(38100700002)(31686004)(218113003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkJkWkVHNEFpTGNuQWhYeVk3NEtzSG91dlZ2eWlKaWNsWmQyTWtlMzAwZFly?=
 =?utf-8?B?cTM0V1NBMHcrZHVPd0EwU2JmWFZwUDh3ZEZWTU5KelNXdkhoenJoTVdFNjN4?=
 =?utf-8?B?YXB1aE1ua3Q4NUpBdzYzWUNCYWdQeHpkUW1TdWpIUXBXK2NYbnVjZW5EaXpU?=
 =?utf-8?B?bUxNc0ZLaWFWZHpscVg3NVJyT3lxTVF3VUlxWnMxL2JPbHVjdDg4c1A1RHhh?=
 =?utf-8?B?czVCT2Y4dDlZQWtlMGZwWkV5SFZDOGxGVUNDaHhFMTBoTW16dHBBUS9DeVNJ?=
 =?utf-8?B?cmFtMGRCcEF2TzBUNkdGcXJPZUtqZ0E1VjdIWCs4UnArRXBGVEVqZnpzSHVt?=
 =?utf-8?B?allNQ2VkVUF4ZmxtZWcyRStUL0V0MUc1Q0hGT09oMGE3VkV5ODB2eHBQSHk2?=
 =?utf-8?B?SGxENGdaekl2SUprblJkd0xjQmdrbTNzZThoU3BsM0lFNXhSVHpocU4yY0Zk?=
 =?utf-8?B?ZUQvVkV2U252Y3RVK1ZsckJGODJtdjNPZ2lPRjZEQWU4TjBEdG54S3pZTFha?=
 =?utf-8?B?WHFMREpjNkV6TWxKTHpBdVljRXgxdlk3cG1mZXU0Tlc3dm5qRVc2Sng4WmFV?=
 =?utf-8?B?WVFHUTdJbmhYZk9EUXh5VjZTU2dzY1Zxd0tsb3pTczB5VTVmM3d6QWJqSko3?=
 =?utf-8?B?emtPTlJFYm9aaGx2N2lPRko4c2pETThXMFVXUDdIK0R6eitrQU9CNVhKY1M5?=
 =?utf-8?B?R3NLQjYySjJpdi84SHMrZ0tNUTdkVW16M2YzRHM1ck5BR292MFpNYjNYTzd0?=
 =?utf-8?B?dThnNjEyNEtrNUlWRWhUVXUxVzI3VTdrV3FhYlAvU3hmamNEN01hVEdRbjJ4?=
 =?utf-8?B?Y0Q1OTNiRUJEOW5veGl1WTlMWFJUMUZVeTg3MWdzTDFReTFZL3lQUjhFL1c5?=
 =?utf-8?B?ejRiZEw3dDc1Q0E3eE83TUZMa2UrWkxDZGp5eDY5MzEwTFBQSlp1OHA3TDZT?=
 =?utf-8?B?QTlKL29GYzZRSjBuRXIyejZ4SWh2cDZ3ckYxYkFZOGZVendrdWtZSnB3MTZk?=
 =?utf-8?B?SE9RR0Q0dWd2ZTBVRytYYTNlMWRZbE9ETlNXVkhBd2VGNG9XRThWN2h3RkZQ?=
 =?utf-8?B?cDBUenZrN1dxMitNK3dwbDh2bGZWYlFKWEJ2KzR3ckF3Q1p0bHRlZmE2L3Vn?=
 =?utf-8?B?YWxGVWYzUGU3YkJxd0JyTXNxbkY0VVFxYXJ1bUR5aHJuSG9ZOXQxQllHSVF1?=
 =?utf-8?B?dmhKaUQ1OGFZTW9GZ2NjSUtlTjJZVS9qbFFPaWs4VldqN1Aya0IzYnU2eTU3?=
 =?utf-8?B?dTNpV0MwbGhFMkRUc2pFV2NYQUd3UUpoNkxCOG12SEs2RmVWa3VmWGxOcCtj?=
 =?utf-8?B?SlhhTy8zbUQxZHhWQldnWnprZlg0eDZ0bGd1OTR0UGFrclIyN3FWS2x3WWZx?=
 =?utf-8?B?Y0NybUxvZU96WTNadTlBZjg1SmhUdko5cCtoZ2JlYjk4RjFIQ0RjajZManJs?=
 =?utf-8?B?TnRVQUhrVDd4TXdzcllib0hMejJBMFAxUGRrTGFIczFWVlliVE9WbEdMdHY3?=
 =?utf-8?B?YVVHck15VWxyVzZiQlJ3dUlRam16Y0ltWGJLM2JacFlRWm9GNEI3cFVLZ08v?=
 =?utf-8?B?TWQxRmlrTTZ0NE9LMklKSDlhWTMyU3IxNCt2K2oyN0haN3gzWTBIVloxcXVT?=
 =?utf-8?B?TUdJVlZTeU5NSHhqcFZ4NUhjWHliRlFrcGM2QVEzTHNseGwzSWc5RTFWZG5O?=
 =?utf-8?B?d1BreFNOaHZ3aHFHQlVuZ004V0FpUmJPYzdITjBEeVovT3dvUTA1VlVhT3N3?=
 =?utf-8?B?TmtEcy9aNHIrQVEwVk02VEZ4a3JabGptaEI5S3B3bmFmSEVaVTNoUXZGSjlM?=
 =?utf-8?B?d29qb3BCUEFjQ2Y3ak0wMGd2TDh4d3had3ByRjV0dktLVjRNRkhVVnFPeitU?=
 =?utf-8?B?SFJUVEpCRWV0TmgvdEdIdGVoNWNhTjFkUFAyTEpIRmt6L3pmSzdmVWxONTRM?=
 =?utf-8?B?UnBDbkRKZ3NtazdGdzlKZ3llU2hkV1FrS01XZHR5eFBxNkZUdThLeGJWZ1lt?=
 =?utf-8?B?QWJFNXBOWG5ZU1ROc25VMExPdnlhZUxFQ1pSMU9hT3VHU1lrOVdnay9UbExN?=
 =?utf-8?B?QWRnT1Q3NStQanJkMVdSZHIvNE5aTmhkL1FzeG5oNHltTFdOOUdraW1peHBE?=
 =?utf-8?Q?FIsTefkFUC9KQqjVT/zXg8M/q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cec9207-5ab9-4865-d273-08dbfc63b16a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 05:15:32.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RE/QSzpARTjj17P8P7leNJPwPIqcxBgllkS9k1zDUCZD5fY1nUCqIS31AFdj+pjv37hyLrswEGFSs5UtKfjkBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4969
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello John,

Thank you for taking a look at the report.

On 12/14/2023 12:41 AM, John Stultz wrote:
> On Tue, Dec 12, 2023 at 10:37 PM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Hello John,
>>
>> I may have some data that might help you debug a potential performance
>> issue mentioned below.
> 
> Hey Prateek,
>   Thank you so much for taking the time to try this out and providing
> such helpful analysis!
> More below.
> 
>> On 11/7/2023 1:04 AM, John Stultz wrote:
>>> [..snip..]
>>>
>>> Performance:
>>> —----------
>>> This patch series switches mutexes to use handoff mode rather
>>> than optimistic spinning. This is a potential concern where locks
>>> are under high contention. However, earlier performance analysis
>>> (on both x86 and mobile devices) did not see major regressions.
>>> That said, Chenyu did report a regression[3], which I’ll need to
>>> look further into.
>>
>> I too see this as the most notable regression. Some of the other
>> benchmarks I've tested (schbench, tbench, netperf, ycsb-mongodb,
>> DeathStarBench) show little to no difference when running with Proxy
> 
> This is great to hear! Thank you for providing this input!
> 
>> Execution, however sched-messaging sees a 10x blowup in the runtime.
>> (taskset -c 0-7,128-125 perf bench sched messaging -p -t -l 100000 -g 1)
> 
> Oof. I appreciate you sharing this!
> 
>> While investigating, I drew up the runqueue length when running
>> sched-messaging pinned to 1CCX (CPUs 0-7,128-125 on my 3rd Generation
>> EPYC system) using the following bpftrace script that dumps it csv
>> format:
> 
> Just so I'm following you properly on the processor you're using, cpus
> 0-7 and 128-125 are in the same CCX?
> (I thought there were only 8 cores per CCX?)

Sorry about that! It should be 0-7,128-135 (16 threads of 8 cores in the
same CCX) The pinning was added so that I could only observe a subset of
the total CPUs since analyzing the behavior of 40 tasks on 256 CPUs was
much harder than analyzing it on 16 CPUs :)

> 
>> rqlen.bt
>> ---
> <snip>
>> --
>>
>> I've attached the csv for tip (rqlen50-tip-pinned.csv) and proxy
>> execution (rqlen50-pe-pinned.csv) below.
>>
>> The trend I see with hackbench is that the chain migration leads
>> to a single runqueue being completely overloaded, followed by some
>> amount of the idling on the entire CCX and a similar chain appearing
>> on a different CPU. The trace for tip show a lot more CPUs being
>> utilized.
>>
>> Mathieu has been looking at hackbench and the effect of task migration
>> on the runtime and it appears that lowering the migrations improves
>> the hackbench performance significantly [1][2][3]
>>
>> [1] https://lore.kernel.org/lkml/20230905072141.GA253439@ziqianlu-dell/
>> [2] https://lore.kernel.org/lkml/20230905171105.1005672-1-mathieu.desnoyers@efficios.com/
>> [3] https://lore.kernel.org/lkml/20231019160523.1582101-1-mathieu.desnoyers@efficios.com/
>>
>> Since migration itself is not cheap, I believe the chain migration at
>> the current scale hampers the performance since sched-messaging
>> emulates a worst-case scenario for proxy-execution.
> 
> Hrm.
> 
>> I'll update the thread once I have more information. I'll continue
>> testing and take a closer look at the implementation.
>>
>>> I also briefly re-tested with this v5 series
>>> and saw some average latencies grow vs v4, suggesting the changes
>>> to return-migration (and extra locking) have some impact. With v6
>>> the extra overhead is reduced but still not as nice as v4. I’ll
>>> be digging more there, but my priority is still stability over
>>> speed at this point (it’s easier to validate correctness of
>>> optimizations if the baseline isn’t crashing).
>>>
>>>
>>> If folks find it easier to test/tinker with, this patch series
>>> can also be found here:
>>>   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v6-6.6
>>>   https://github.com/johnstultz-work/linux-dev.git proxy-exec-v6-6.6
>>
>> P.S. I was using the above tree.
> 
> Ok, I've been working on getting v7 ready which includes two main things:
> 1) I've reworked the return migration back into the ttwu path to avoid
> the lock juggling
> 2) Working to properly conditionalize and re-add Connor's
> chain-migration feature (which when a migration happens pulls the full
> blocked_donor list with it)
> 
> So I'll try to reproduce your results and see if these help any with
> this particular case, and then I'll start to look closer at what can
> be done.
> 
> Again, thanks so much, I've got so much gratitude for your testing and
> analysis here. I really appreciate your feedback!
> Do let me know if you find anything further!

Sure thing! I'll keep you updated of any finding. Thank you for digging
further into this issue.

> 
> thanks
> -john

--
Thanks and Regards,
Prateek
