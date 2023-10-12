Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14417C62B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjJLCWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjJLCWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:22:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882F898
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1W1yw0cSg5xWTjhq3wer6JrIB67uYyzXHRjqIXjt8t81KRYojxe3IXln+igdFA0WXC24xnPkbCMleGEJyrDB3I25sS8SJUqP99E0RsaEcOrlEk9mznxRPZTB2E4PKe/VketGYfj0av+I9zL4ldAUMRX0Lv9TCc1hqEw0FHxDCcyh8cUDtiZ49bW5MAiveaBXqaJDfjgnoqx4XxqRGty8auOCgoHEAbNQXIo+uvY/g1od6Iba5eex2ykhmvJbBGz9pDV8UZV10ZdVHWdEkd6A3msOKz0SR00mosXpU/rcNTeXbU9t6WyJE9c3KQv7Q5D+q4if0lKbV+4I7HuihQDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ8N3efu4z6KpSd/IL5f+OrZWndcKtSOSD0yHwHY3SE=;
 b=OTtFMu9ololHibOYYb37HLf8FUc2Jmo3TiJftlT8heHVx4dZIPKatsyWdgzVCuShwiz6ivODjtQf72gFxu5bDAmenPTBEn8z6Xu1VDCxPxTyAAuJYhMY8GDXoENiA7Cc8tWL+poZ3CecB3GpJIhiodzHy3pltvZ+jZ8gxydClNAosku4+bTRA62nRkQuqQk2A/9HLWIPCun4fDqQP/Ktl/1lo3VhkCfzdGTUAy8d/AUysjthWTQ+iEB8NcXobmY9wkV8bEjXF3Iftr54yqSnWUY+X9JbWOad0U8e871CqThfNEM9iZs7/S/7wREJLUYVA6c1j6UiDtfuC92AtoNKow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ8N3efu4z6KpSd/IL5f+OrZWndcKtSOSD0yHwHY3SE=;
 b=K9rJkDa1gAYFZ1DlCVwyGefVBdlXxrZ+/+CufsOHc6W4hZ1fP0t/H9FhDsXiO17aD1VCLPvhNlVgVc6IPUk8CRrDHSI3KlR/MR6zPgde6sRFgY9327Rk6BE+zevv+3o/WIdO34IcmVueXNnuUZRiDjDrzUupcR2uYQASdE61jgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BY5PR12MB4968.namprd12.prod.outlook.com (2603:10b6:a03:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 02:22:25 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 02:22:24 +0000
Message-ID: <28563e2d-6746-e2c4-7d21-4ca39a82edc1@amd.com>
Date:   Thu, 12 Oct 2023 07:52:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v8 00/25] timer: Move from a push remote at enqueue to a
 pull at expiry model
Content-Language: en-US
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20231004123454.15691-1-anna-maria@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|BY5PR12MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aaf8a52-8af8-43f9-9341-08dbcaca1237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgtMyTXuwvVjVyRYLXbak3utz98cvkxkkuHCJ5Mi6EZJBhLuKGblElIKCNKGpOb3FX42cncg0aCOlydkKj+4MU1ffpoJmXxnt9qsYl74IA5x9gKP7T2zLqAyd4ll863oRo4IfCK7zZiSZbNxsKGmx24uFxkCqIbiugbShMuhW9suLwI4FTZE+dDXb0XeGpExlMebhWQbbQZQCzW9a8RIw7DgaYQW8m99FDtR1rDehnKI2kuqevaUPD77PCqXaZ4vzqMqpZ9JqY/dhAgI4+Au2CdvqcSgW8qgWzegp3KzdFneMnN3smODDkPIUmY2uzZbUT7Dz4c3tZQJZB72rbNHX7y9zC4QAw3t9rUOaTOKps5TBPie0cvNUJMqe8PL7Xo9ckADErmdbV+md1atv0Viev7OzIju28L0dS0HpLwA5ZPR5XuKor1IjWb3jrYlV8TqTFbDi5hgTvOhT1xmlPcKkZLIJsocAhhEABCwkuRMG4P+6WXT0HXgkdZlfLrHHogtuHCYirBKhHk5Qqdd3JUnKqYEXxXdv1CpcqqAMG7dtN85vy+9ubCktELj4DDMBGOgWKoQz1/Nx0gsV+57strQ1KazNvk6BLV/N/uzfMlLleyZJJBxxsdj++nrH6XTo7QM23DCsxe3VuzuPQlppabMhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6512007)(478600001)(6486002)(86362001)(31696002)(6506007)(36756003)(7416002)(53546011)(6666004)(4326008)(38100700002)(5660300002)(8676002)(8936002)(54906003)(316002)(66476007)(66556008)(66946007)(2906002)(41300700001)(26005)(31686004)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkNTckV3QUZPY0hMUlNLTXNQMVdZR3ZBVTMwYVYxU0FhYTVpeWNrVGVNeXRh?=
 =?utf-8?B?dGliQzJzbkJycHBSV0ZZVHAvdG03NEpDNStVcmVaM0tzOTJVQkNWNVc2NkFE?=
 =?utf-8?B?WFh2RXk3cnpVMnpWeGtzMURSREdIWTV6MXo2d3NGVWlNSnZweHZmblhhdzVi?=
 =?utf-8?B?VHlUVHQ5Z2tTMHcvZ3RvR3pDd0V6K1pGUlU0bW1YT3hzRyswa2hteWJVNUxw?=
 =?utf-8?B?ZmM2T1B1U3F2QjVPeTFiRUt4MG5IQjF3YVA3SkkxNkVYVWFoMVozWmZhZ1FD?=
 =?utf-8?B?NDV2RzZ6N0k4ZUJ4cEFMNFRqaU9xSmkrbUtXcEVrWW5SVitlclNBR3BsdGYw?=
 =?utf-8?B?c3pqZVdiVUNaVEtNRUEyTkJ1WnR3NXQzQ3BHTGwvNVhLbjhZZFZKZ2VoZTE0?=
 =?utf-8?B?MGpaNzgyREpCcVFrWGtvZGlEc1kvZXRwaCt6SjB0Y000T1NtYVRDa0NsSmlr?=
 =?utf-8?B?V2RmUTE5NFNteXorNm9ESGN0ZC8vRkR1bTFlODhEajJ3SWtwTGdueUdSeTJK?=
 =?utf-8?B?L3JCVVRlMnNmVUIveFVnTlQyVWRxbHRXRWlXVVhkL204L1crR0lwWWhBb1Rl?=
 =?utf-8?B?RHNFeVh0K2I5NEZMRm5GRTFyUnZjbmZYVHp0TmM1RFRtQUdLNThnZzJyb2Q5?=
 =?utf-8?B?YlVwQ1JRcTRuVFZnbExwb0ozUXErSzlXY1hlSldSNmxtM0dwZWdLanBjR2pO?=
 =?utf-8?B?cjRxTVd1Zy9MUC9XWlFaM2d4SHBUaGMyVFlwUUs0cCtQbHlZdXRHc0FtaTRo?=
 =?utf-8?B?WUhIQ3VGa2pwcEY3SnJjZHBJQ1d3cU44UXprWTY3OGRNaUl2Q2hrcEhxRCtP?=
 =?utf-8?B?ajVjQXRwRVY1aG1XKytZLzBYUnBneWg2Nm1zSkF6MCtZcndENTNIeDBTSjNu?=
 =?utf-8?B?bkYxOVd3cFRySEVoZXJCVzhXa1VueDVqZUpiSnJsdzRhc2l6Wnd5R0NFR05D?=
 =?utf-8?B?QTMzU0huSFN3MFZCTWR1dUtDNVJYditpa3RsTEYrQ1ZZZHZMVVk5enN1NEdS?=
 =?utf-8?B?S2liRk41YkdqekZPazR3bUNWRW8xMDg0dE95Q2hoU20xMTRaQmVZVlZZM2po?=
 =?utf-8?B?azdRWGl0bXlmU3FsN0k4TUloRHVISWNXNmdORTl6Vlp0ZVFuT0dZVzVocXA4?=
 =?utf-8?B?cWpXdmI2bGVYZ3NjejR4K0htbnUzK3REQlZ0cEhqV1MzMDBwYi9LSVB6eDgw?=
 =?utf-8?B?VDlVSS9JMXQ5K0tCK0ZjaCtYOHlTR2VoejIvWmRNcnpqQldpZXNBT3ZPWnBT?=
 =?utf-8?B?N01jSk01OXZyWlA1eURsOG1KU1MwV2pLRDhDVlJycUxVcjJxRHNuc2lqZWVs?=
 =?utf-8?B?Y0xBZGdWR0owR2VSaUNEVmltSHhEYk1kQzRXc2RjRzRCQ0tJYjNtQk9tTkt3?=
 =?utf-8?B?OUhKakdhSTFFUktoZkRjdjl3alp1S2F2anRXZzBxb2lSRGVlME95SmpKOTlM?=
 =?utf-8?B?c0FqT1ZuTnd5M0FtcVA1MkEySmFTSGZsT0pqM2xrNy8vbTdqRDFFWTIwVFJn?=
 =?utf-8?B?QVNDa2V2alJDWkE1dkhkT0tCQkQyTkY0MCtJTFJ2TVBzY2crTGNHQ25sL2d0?=
 =?utf-8?B?dm90SnJKdDJNZ2ZJQTRPRGVEYU5QWjJaZm5IMmxNL3p1c1o0ZnVOYldSR2RX?=
 =?utf-8?B?eC8xTEZ5L3kyYkoweC9LbGhuM3k5L3NveGhlMFh3OEsvc1ZJRmxpMW9jYWRq?=
 =?utf-8?B?OCtGQWdlQTFGVkt2bTA2Y09TUFVKbWo5UmVGWlp1citpS1BMVmt2VWk4cGlr?=
 =?utf-8?B?cW85bkdsK3FNU0Q2M3dTRzh5aWwrTHJjQ1gvRkg0bTMzQ3p1WlQvWkZTaGRE?=
 =?utf-8?B?K2hscnpuTkphK3ZlZ1FWUnB5YkxQZnVOcVdDOFlGTys0c0JLM2J3a0NUczBs?=
 =?utf-8?B?MTB6MWp5bi85RUNTZ3pYT1pzSkFNRWFLQUQwblYxeU9HakZwenFYb3R3aFYx?=
 =?utf-8?B?bW8weU5aQVpNMkovSW5xbzd1NnZUbGEvM2ZyMmJRR1Q0OEZIQmsvOG00Nnh1?=
 =?utf-8?B?WGhURWhyNmZtNW0wcXpHSTJQTGdiNXY2bEdhMktielI4YnJCSmFwTmZZSmh0?=
 =?utf-8?B?ZnVrck1wV1k4M0FpRk9ubnk3ZW5hNFRMVU5QTm5DbktIT201eTE5T2R6cnBx?=
 =?utf-8?Q?mTxzhFn9mXZX6+bXPDAya1nNH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaf8a52-8af8-43f9-9341-08dbcaca1237
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 02:22:24.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFq5FYkIw1WoK44yP//+RRbH75infHqvlRrjm4t7qIuROcpV/TPXzB9p07TlW3SA4I6bzL+VW4jtAvKm1vkmtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4968
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anna-Maria,

Happy to report I don't see any regression with this version of series.
I'll leave the detailed report below.

On 10/4/2023 6:04 PM, Anna-Maria Behnsen wrote:
> [..snip..]
> 
> dbench test
> ^^^^^^^^^^^
> 
> A dbench test starting X pairs of client servers are used to create load on
> the system. The measurable value is the throughput. The tests were executed
> on a zen3 machine. The base is the tip tree branch timers/core which is
> based on a v6.6-rc1.
> 
> governor menu
> 
> X pairs	timers/core	pull-model	impact
> ----------------------------------------------
> 1	353.19 (0.19)	353.45 (0.30)	0.07%
> 2	700.10 (0.96)	687.00 (0.20)	-1.87%
> 4	1329.37 (0.63)	1282.91 (0.64)	-3.49%
> 8	2561.16 (1.28)	2493.56	(1.76)	-2.64%
> 16	4959.96 (0.80)	4914.59 (0.64)	-0.91%
> 32	9741.92 (3.44)	8979.83 (1.13)	-7.82%
> 64	16535.40 (2.84)	16388.47 (4.02)	-0.89%
> 128	22136.83 (2.42)	23174.50 (1.43)	4.69%
> 256	39256.77 (4.48)	38994.00 (0.39)	-0.67%
> 512	36799.03 (1.83)	38091.10 (0.63)	3.51%
> 1024	32903.03 (0.86)	35370.70 (0.89)	7.50%
> 
> 
> governor teo
> 
> X pairs	timers/core	pull-model	impact
> ----------------------------------------------
> 1	350.83 (1.27)	352.45 (0.96)	0.46%
> 2	699.52 (0.85)	690.10 (0.54)	-1.35%
> 4	1339.53 (1.99)	1294.71 (2.71)	-3.35%
> 8	2574.10 (0.76)	2495.46 (1.97)	-3.06%
> 16	4898.50 (1.74)	4783.06 (1.64)	-2.36%
> 32	9115.50 (4.63)	9037.83 (1.58)	-0.85%
> 64	16663.90 (3.80)	16042.00 (1.72)	-3.73%
> 128	25044.93 (1.11)	23250.03 (1.08)	-7.17%
> 256	38059.53 (1.70)	39658.57 (2.98)	4.20%
> 512	36369.30 (0.39)	38890.13 (0.36)	6.93%
> 1024	33956.83 (1.14)	35514.83 (0.29)	4.59%

o Machine details

- 3rd Generation EPYC System
- 2 sockets each with 64C/128T
- NPS1 (Each socket is a NUMA node)
- C2 Disabled (POLL and C1(MWAIT) remained enabled)

o Kernel Details

- tip:	tip:sched/core at commit 238437d88cea ("intel_idle: Add ibrs_off
	module parameter to force-disable IBRS") + min_deadline fix
	commit 8dafa9d0eb1a ("sched/eevdf: Fix min_deadline heap
	integrity") from tip:sched/urgent

- timer-pull: tip + this series as is

o Benchmark Results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:         tip[pct imp](CV)    timer-pull[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.11)     0.99 [  1.44]( 3.34)
 2-groups     1.00 [ -0.00]( 1.31)     1.01 [ -0.93]( 1.57)
 4-groups     1.00 [ -0.00]( 1.04)     1.00 [  0.44]( 1.11)
 8-groups     1.00 [ -0.00]( 1.34)     0.99 [  1.29]( 1.34)
16-groups     1.00 [ -0.00]( 2.45)     1.00 [ -0.40]( 2.78)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:    tip[pct imp](CV)    timer-pull[pct imp](CV)
    1     1.00 [  0.00]( 0.46)     1.01 [  0.52]( 0.66)
    2     1.00 [  0.00]( 0.64)     0.99 [ -0.60]( 0.88)
    4     1.00 [  0.00]( 0.59)     0.99 [ -0.92]( 1.82)
    8     1.00 [  0.00]( 0.34)     1.00 [ -0.06]( 0.33)
   16     1.00 [  0.00]( 0.72)     0.99 [ -1.25]( 1.52)
   32     1.00 [  0.00]( 0.65)     0.98 [ -1.59]( 1.29)
   64     1.00 [  0.00]( 0.59)     0.99 [ -0.84]( 3.87)
  128     1.00 [  0.00]( 1.19)     1.00 [  0.11]( 0.33)
  256     1.00 [  0.00]( 0.16)     1.01 [  0.61]( 0.52)
  512     1.00 [  0.00]( 0.20)     1.01 [  0.80]( 0.29)
 1024     1.00 [  0.00]( 0.06)     1.01 [  1.06]( 0.59)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)    timer-pull[pct imp](CV)
 Copy     1.00 [  0.00]( 6.04)     1.04 [  4.31]( 3.71)
Scale     1.00 [  0.00]( 5.44)     1.01 [  0.57]( 5.63)
  Add     1.00 [  0.00]( 5.44)     1.01 [  0.99]( 5.46)
Triad     1.00 [  0.00]( 7.82)     1.04 [  4.14]( 5.68)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)    timer-pull[pct imp](CV)
 Copy     1.00 [  0.00]( 1.14)     1.00 [  0.29]( 0.49)
Scale     1.00 [  0.00]( 4.60)     1.03 [  2.87]( 0.62)
  Add     1.00 [  0.00]( 4.91)     1.01 [  1.36]( 1.34)
Triad     1.00 [  0.00]( 0.60)     0.98 [ -1.50]( 4.24)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:         tip[pct imp](CV)    timer-pull[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.61)     1.01 [  1.25]( 0.48)
 2-clients     1.00 [  0.00]( 0.44)     1.00 [  0.34]( 0.65)
 4-clients     1.00 [  0.00]( 0.75)     1.01 [  0.98]( 1.26)
 8-clients     1.00 [  0.00]( 0.65)     1.01 [  0.82]( 0.73)
16-clients     1.00 [  0.00]( 0.49)     1.00 [  0.37]( 0.99)
32-clients     1.00 [  0.00]( 0.57)     0.98 [ -2.05]( 3.44)
64-clients     1.00 [  0.00]( 1.67)     1.00 [  0.00]( 1.74)
128-clients    1.00 [  0.00]( 1.11)     1.01 [  0.69]( 1.11)
256-clients    1.00 [  0.00]( 2.64)     1.00 [  0.00]( 3.79)
512-clients    1.00 [  0.00](52.49)     1.00 [  0.26](54.13)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: tip[pct imp](CV)    timer-pull[pct imp](CV)
  1     1.00 [ -0.00]( 8.41)     0.59 [ 40.54](40.25)
  2     1.00 [ -0.00]( 5.29)     0.93 [  7.50]( 9.01)
  4     1.00 [ -0.00]( 1.32)     0.91 [  9.09](12.33)
  8     1.00 [ -0.00]( 9.52)     1.00 [ -0.00](15.02)
 16     1.00 [ -0.00]( 1.61)     1.03 [ -3.23]( 2.37)
 32     1.00 [ -0.00]( 7.27)     0.92 [  7.69]( 1.59)
 64     1.00 [ -0.00]( 6.96)     1.12 [-11.56]( 1.20)
128     1.00 [ -0.00]( 3.41)     1.06 [ -6.49]( 3.73)
256     1.00 [ -0.00](32.95)     1.02 [ -2.48](28.66)
512     1.00 [ -0.00]( 3.20)     0.99 [  0.71]( 3.22)


==================================================================
Test          : ycsb-cassandra
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
metric      tip     timer-pull (%diff)
throughput  1.00    1.01 (%diff: 0.75%)


==================================================================
Test          : ycsb-mondodb
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
metric      tip     timer-pull (%diff)
throughput  1.00    1.00 (%diff: -0.49%)


==================================================================
Test          : DeathStarBench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Pinning   scaling   tip     timer-pull (%diff)
1CCD        1       1.00    1.01 (%diff: 0.75%)
2CCD        2       1.00    1.03 (%diff: 2.72%)
4CCD        4       1.00    1.00 (%diff: -0.28%)
8CCD        8       1.00    1.00 (%diff: 0.20%)

--

Thank you for debugging and helping fix the tbench regression.
If the series does not change drastically, feel free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> 
> 
> Ping Pong Oberservation
> ^^^^^^^^^^^^^^^^^^^^^^^
> 
> During testing on a mostly idle machine a ping pong game could be observed:
> a process_timeout timer is expired remotely on a non idle CPU. Then the CPU
> where the schedule_timeout() was executed to enqueue the timer comes out of
> idle and restarts the timer using schedule_timeout() and goes back to idle
> again. This is due to the fair scheduler which tries to keep the task on
> the CPU which it previously executed on.
> 
> 
> 
> 
> Possible Next Steps
> ~~~~~~~~~~~~~~~~~~~
> 
> Simple deferrable timers are no longer required as they can be converted to
> global timers. If a CPU goes idle, a formerly deferrable timer will not
> prevent the CPU to sleep as long as possible. Only the last migrator CPU
> has to take care of them. Deferrable timers with timer pinned flags needs
> to be expired on the specified CPU but must not prevent CPU from going
> idle. They require their own timer base which is never taken into account
> when calculating the next expiry time. This conversation and required
> cleanup will be done in a follow up series.
> 

I'll keep an eye out for future versions for testing.

> 
> [..snip..]
> 

--
Thanks and Regards,
Prateek
