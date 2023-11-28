Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34B7FC167
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346562AbjK1PFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345934AbjK1PFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:05:02 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A1619D;
        Tue, 28 Nov 2023 07:05:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlcilxPmQMQCuIoDuhDD+ub8dhtEZzuydp7bpXijH1xXo657ALCacUieo8tBczTGi5sPwbUBgKgUf0vkWVol5lkryRGHuHdMRxcsktfDhilKAAbQn52IAqq3OmTUu9gQu2v6yCa8KGtian1osA0LwcoIwgUCnLxgc/tgVPs5gWNGAX/zoHE7T0fp5bmRb3VuG94ceuDrPkNOwp5O5PBHczgYwzV5AskoRXypJb+qPAgWGbh9gRfuEmaADCLy04b3UEkG/MIP/dnrctaC4/OhUxcLSgNl/D7DYrb/1ZZ98PTZ25H4RIT6qkW8aaRMMrZ+pY5xmt0IdrJFZegezgdnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wzIOcCZeO9IpaRl2wpSh3E3KRrju30P0TqHeAuIecw=;
 b=JTl2zx+fAQP3J1vrqOFVbXva4TaCw8wDc/lH0TAvtrSzwsABgJzMg64Q/+1hQMntYAR5doRrfumhlbgo03oLG4xMN/mVo+NMtTf+XFN0hV3UXTH+j1IQiZL5TNtP0SKstAVcwxW7GEyAH/chEqapz+hTtmaHOwh2vNrfJ2XDdgemRv/5ywI24MR5L5mNVThpI/I9w/qATtnzo6fHrbZr9Rn5FxVWzePB9gyjOabQuhPohZ7uYaUUexn1dfxinkCFwwlFKVDjOIhXjfGT58tBgsmLzpQJkwOF3aCsz6MmmxEXxFqFd4h/FjLPHbQOTZulEkId4qNrWLMMppACRG0IwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wzIOcCZeO9IpaRl2wpSh3E3KRrju30P0TqHeAuIecw=;
 b=p1l4fT5TrQjflyGFWCDDqLZ5X8nQSXWGUBi8Wicfs8/AbqEa48kvpaJeJb1fCq5y5a6WOZvVkqV119NQdSy3N+G9EDwtKVtsmCc09yY9gEBS71iW4tSvAwteAQSskswOaQit2XDqEE9zgl0dVc5oXw8RQEyB7BncrBW4PJBgphHCuxQPXTn4Og6h8b1MLCvWoUtrSohK9cBBQitMdP+IszqC3IbvnKeR/qTORU5hPjctzyL+VpaIMEnMR9+PNPtLPZYbhsLhWzkJqu2gDEgsB3jw0Ayvk32ZwGg+O8zoGrTkgWIWgntKnnN4ITyxLtCFouoNsN7ShhxHk3TS1psfgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by PAXPR04MB8672.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 15:05:02 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14c8:fc35:a9ae:9c9d]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14c8:fc35:a9ae:9c9d%4]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 15:05:02 +0000
Message-ID: <77037ca1-8116-4bc6-b286-67059db0848e@suse.com>
Date:   Tue, 28 Nov 2023 16:05:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tracing: Simplify and fix "buffered event"
 synchronization
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231127151248.7232-1-petr.pavlu@suse.com>
 <20231127151248.7232-2-petr.pavlu@suse.com>
 <20231127124130.1041ffd4@gandalf.local.home>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20231127124130.1041ffd4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0052.eurprd09.prod.outlook.com
 (2603:10a6:802:1::41) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|PAXPR04MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: b8fb948b-4c06-433f-7999-08dbf023659f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jdewN64Z0fpMWG3lx03Ubr0INhvUKkdyvW/kRrL4/kjSkgrydRwEGhOq7T42gwT6bYx0e3O1usGHHAHuOgQ0Ei2WRHwXe2reUrKkCpFdN77XxRPNqh6TD8wo2HfpqphxiE8TlH1T98gGIAwn3ao1FlK7cIyvp2W5y+4CqpzVaLfRsXNpf/nrt4SNXlKqmqxTGz3ImfitfFMoicoo55+gTSorrj5j0H1jUR2+0U/ZbV3mvSHToqT35/uVODbxL7dNonwWGP2E9wFU+nl8gY0ZAalJYhUX8sFTLYO4fB7IvpwAvf1uMyjCopt2YsrBb96U38AqRBqSSwtsVDL2K46zNbNLs5TCHy+SBtHPWi54UN/0ItwsQ6i1CzlweUMidJhVjDNv629O6gdSGEJyq1if59hwbX6YcEIfW1Cmm9wz0Z+OUfqV/A/xN6hMwTx4kgGnQAm1oy4bjCgNBqVLktwH+zLwbk2QdeOMO0ffCGCMKNti0dGffKpZD/aWKp5i/q+W3q/LJtNQkIEQawX5aW+VWTvsA2D1LKNiJYaPhWJI1fGZoJiD+JOyNTSifx0rww7L6UmPrgwLwkEmOorwGpWug9gGpdNZBwW5EX7s+LtYd+jCG3TiBZHmOomJCfrt8ZB1+G8ilqHM5AWHwb7po80bRkfxUPmyZDJOIEMbSodF7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(86362001)(31696002)(2616005)(83380400001)(26005)(53546011)(6506007)(55236004)(6512007)(31686004)(36756003)(38100700002)(316002)(44832011)(4326008)(66556008)(6916009)(66476007)(66946007)(478600001)(30864003)(6486002)(966005)(5660300002)(2906002)(41300700001)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azR6Y04ra0t4WVpYZG1KZm15Z2NJUEFwWHR5cERhSk9rZDIwVlRzSlQxYnJx?=
 =?utf-8?B?QjZVYm8waGo1VGRlTVFEdGNZaDV5U3YwNUlHa3ZDMno5YnFJVVhveEZVVFJQ?=
 =?utf-8?B?dmN6YWZaMmZvZDNKWWtZMzZJNmU0T2VKbk5zMGhWV0sreW9xRUthbTVQQVdl?=
 =?utf-8?B?d3hYdm5pMW1hRmJWazdWWjVzSFIrTGFkNHp1UTArT1hSbTA5ZWN2cy8rLzNu?=
 =?utf-8?B?ODR5VlJ5MzFXK3JuUk15QWZGNU5LWGQ1ODR0bFM3WDhLSnJCcEdYeGlOT0Y4?=
 =?utf-8?B?Zm9DbnVLbTN5SGxrUlk1dVdxcWJCQ0tXSlpNR1R0YXVQcWYwc0NuMkFTcDRW?=
 =?utf-8?B?UUxyR3grczE0cDM4VnlYZGt4TmQ0YzlOOWNQSGJ0dkJteEJtNkxJTS81K01y?=
 =?utf-8?B?Nmo1aGI0TE1aaVhpTGpjS3FDTU4yc0IrY2RKNC9pdkVSZG5MdjNQMUVKN3I1?=
 =?utf-8?B?VDlGQjloY3laallsTlV2Tmp1dC8zMHBJWTlQUDFreThCK3RzUFdnODBMMFhl?=
 =?utf-8?B?NDFFNmZ4aWY3V1M4U3NITjJWb0hraWJEclpQcnI4a1NkazV1eWlXRUdndldR?=
 =?utf-8?B?RnZiTWppclBxZ2c1MU5TdkJ0MmRhWVRrS2M3OXZGOElXc0RkaFZSaExKZVlr?=
 =?utf-8?B?TEhUQVhoODE3WWVxbWsycy9MRWdncGZjUjdRN2dCNlVud0Vjc2JVWGxnVzRx?=
 =?utf-8?B?RytwM1g2V2dXdzJvaXhlVmxkMlFXR2JrNkYrMTZyNlZ0ZFVEdjQ5T1Q0L202?=
 =?utf-8?B?c3pzd2E0SGM3ekg5RWlaekh4dmxTMzlIL2hiOGZPbEJ4VjRhQUtiL2VLSDNQ?=
 =?utf-8?B?ZjNHQjZsNStDbmUveUFpQ0VIMTRMT0ZWUEtzTmUxSFp5VHF4YUZQREt1bjc0?=
 =?utf-8?B?Z1Z6VEFEWUN5UExYalZUN3pMUWRqWDQ2dGZ5dE5RK1VPWVpLSU8wRVdEVTkw?=
 =?utf-8?B?ZkVuKzlZYzJqZEVUQVhGa2x3SHdFUmlCYVA2TUNOejVReEI5bDNLeUlKZGti?=
 =?utf-8?B?MllWaXJBMmQ5V1JQWWllbGNBQTgrNi9UQ3hyOFFnL2dTbTIzZ3dnWUJZcE9X?=
 =?utf-8?B?WHdjZXRTSFh3OU9KeWVxYVhTYWh4em9EUldoSHBQNzlHaDl0UlFoQVpxMVBH?=
 =?utf-8?B?dGo4cUwrYWw2RDNUNUpucC81Um5tZ0VqOVVwbzBvQXA2SkhqRWFleHpScmR0?=
 =?utf-8?B?dW90azN1emxxblgrK1ZJbXNldUxTV3pDUWVZU3B6RjZqa3VITWlWTk9XTXRU?=
 =?utf-8?B?KzdIZ0tsMUI0K2ltNUJuTi9BSHJpT3pkTjFsekY3S1NkcTlISzRWNmtLSGRQ?=
 =?utf-8?B?eEUrSjZHY3htTFJKRGJJZDhyR1hiZ05nMFlxY1pqcFQ3eVlwb2dGajZIZGV6?=
 =?utf-8?B?eHE1VkFNWXJFN2VWdHFPOXhrVDVpeHJGSFFBZ3Q2Qys2S1lzK1htc1BDV1Ja?=
 =?utf-8?B?eUVwMDl2S1dJMVl4bWtTbERkUWlLQ1Z3RGFjbDNJRXRxV1hJNWFEL2JIVWxv?=
 =?utf-8?B?ZWVTeEY3dmt2Y1JPSUFpYzhNUW5ycWE1S3gwTERMY2g4a3NZL0YxTFY0d0dz?=
 =?utf-8?B?Qm1KR1VUTXdDU2RVUWFTWUdWc1gvRjlISHA2MFRSVUdIcGRXZkxYekNlU2x3?=
 =?utf-8?B?ZXREL2swVHNyaUE1dFppbFpORCtic0lIdWM2d1htTmJHdlZTWVpzYWIyYWsz?=
 =?utf-8?B?VUpNa0x3dFZtR05kZDVwSEgvcDdxRUx0aTlVT2xjeVB4SDM2STRrbUdXbzVk?=
 =?utf-8?B?WGNzU1RLWHBuUGdOcjZFbDR2UlNOSTk4MWYyamNUZUJQZEhuWGF2Y2RKUU5h?=
 =?utf-8?B?NkZaUUwydjMrdmJTbzlNV3VIaTI5Z0tVOWRVWDdDbnVJY2E4YVdDRnlsT3dT?=
 =?utf-8?B?ZENMMGd2LzdQaWVKTURXRDFxNCtEUTJvUE05QVRaUGJGK1p2QUdST2t4WHQw?=
 =?utf-8?B?V2JsNkZtcDlpSGptY1J6ZlptVmFsNnhkQXhha2xUeGt5M29Ta253RFpTWDgv?=
 =?utf-8?B?Qm4vcUFtOHdLUXZRL2NyN05rUWZYOFkxK2pJSzA1RU4zWlVTQ1hsZmJKclZv?=
 =?utf-8?B?L2w0UnZ2MHdjMEsxbjdDcE93dE9RMC9rckFONi9ENk53TDlqWmRVaGxPZTM5?=
 =?utf-8?Q?3HGMTXTGbsDr50lGEpdjE2izA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fb948b-4c06-433f-7999-08dbf023659f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:05:02.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpxX5fGSC9fRzXWufLRSJyBpXay4oDJ5w21WUC+o41+InPOviTwgjYGwVd2DWKQlQLozTYdzMtFBUiUBr1TtVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 18:41, Steven Rostedt wrote:
> On Mon, 27 Nov 2023 16:12:47 +0100
> Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
>> The following warning appears when using buffered events:
>> [  203.556451] WARNING: CPU: 53 PID: 10220 at kernel/trace/ring_buffer.c:3912 ring_buffer_discard_commit+0x2eb/0x420
> 
> Hmm, I don't have a waring on line 3912, do you have extra code (debugging)
> in your version?

The series is based on 2cc14f52aeb7 (tag: v6.7-rc3). It is the following
code and RB_WARN_ON():
  3895  void ring_buffer_discard_commit(struct trace_buffer *buffer,
  3896                                  struct ring_buffer_event *event)
  3897  {
[...]
  3908           * This must only be called if the event has not been
  3909           * committed yet. Thus we can assume that preemption
  3910           * is still disabled.
  3911           */
  3912          RB_WARN_ON(buffer, !local_read(&cpu_buffer->committing));
  3913  
  3914          rb_decrement_entry(cpu_buffer, event);
  3915          if (rb_try_to_discard(cpu_buffer, event))
  3916                  goto out;

https://github.com/torvalds/linux/blob/2cc14f52aeb78ce3f29677c2de1f06c0e91471ab/kernel/trace/ring_buffer.c#L3912

>> [...]
>> [  203.670690] CPU: 53 PID: 10220 Comm: stress-ng-sysin Tainted: G            E      6.7.0-rc2-default #4 56e6d0fcf5581e6e51eaaecbdaec2a2338c80f3a
>> [  203.670704] Hardware name: Intel Corp. GROVEPORT/GROVEPORT, BIOS GVPRCRB1.86B.0016.D04.1705030402 05/03/2017
>> [  203.670709] RIP: 0010:ring_buffer_discard_commit+0x2eb/0x420
>> [  203.735721] Code: 4c 8b 4a 50 48 8b 42 48 49 39 c1 0f 84 b3 00 00 00 49 83 e8 01 75 b1 48 8b 42 10 f0 ff 40 08 0f 0b e9 fc fe ff ff f0 ff 47 08 <0f> 0b e9 77 fd ff ff 48 8b 42 10 f0 ff 40 08 0f 0b e9 f5 fe ff ff
>> [  203.735734] RSP: 0018:ffffb4ae4f7b7d80 EFLAGS: 00010202
>> [  203.735745] RAX: 0000000000000000 RBX: ffffb4ae4f7b7de0 RCX: ffff8ac10662c000
>> [  203.735754] RDX: ffff8ac0c750be00 RSI: ffff8ac10662c000 RDI: ffff8ac0c004d400
>> [  203.781832] RBP: ffff8ac0c039cea0 R08: 0000000000000000 R09: 0000000000000000
>> [  203.781839] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>> [  203.781842] R13: ffff8ac10662c000 R14: ffff8ac0c004d400 R15: ffff8ac10662c008
>> [  203.781846] FS:  00007f4cd8a67740(0000) GS:ffff8ad798880000(0000) knlGS:0000000000000000
>> [  203.781851] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  203.781855] CR2: 0000559766a74028 CR3: 00000001804c4000 CR4: 00000000001506f0
>> [  203.781862] Call Trace:
>> [  203.781870]  <TASK>
>> [  203.851949]  trace_event_buffer_commit+0x1ea/0x250
>> [  203.851967]  trace_event_raw_event_sys_enter+0x83/0xe0
>> [  203.851983]  syscall_trace_enter.isra.0+0x182/0x1a0
>> [  203.851990]  do_syscall_64+0x3a/0xe0
>> [  203.852075]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>> [  203.852090] RIP: 0033:0x7f4cd870fa77
>> [  203.982920] Code: 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 b8 89 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 43 0e 00 f7 d8 64 89 01 48
>> [  203.982932] RSP: 002b:00007fff99717dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
>> [  203.982942] RAX: ffffffffffffffda RBX: 0000558ea1d7b6f0 RCX: 00007f4cd870fa77
>> [  203.982948] RDX: 0000000000000000 RSI: 00007fff99717de0 RDI: 0000558ea1d7b6f0
>> [  203.982957] RBP: 00007fff99717de0 R08: 00007fff997180e0 R09: 00007fff997180e0
>> [  203.982962] R10: 00007fff997180e0 R11: 0000000000000246 R12: 00007fff99717f40
>> [  204.049239] R13: 00007fff99718590 R14: 0000558e9f2127a8 R15: 00007fff997180b0
>> [  204.049256]  </TASK>
>>
>> For instance, it can be triggered by running these two commands in
>> parallel:
>> $ while true; do
>>     echo hist:key=id.syscall:val=hitcount > \
>>       /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger;
>>   done
>> $ stress-ng --sysinfo $(nproc)
>>
>> The warning indicates that the current ring_buffer_per_cpu is not in the
>> committing state. It happens because the active ring_buffer_event
>> doesn't actually come from the ring_buffer_per_cpu but is allocated from
>> trace_buffered_event.
>>
>> The bug is in function trace_buffered_event_disable() where the
>> following normally happens:
>> * The code invokes disable_trace_buffered_event() via
>>   smp_call_function_many() and follows it by synchronize_rcu(). This
>>   increments the per-CPU variable trace_buffered_event_cnt on each
>>   target CPU and grants trace_buffered_event_disable() the exclusive
>>   access to the per-CPU variable trace_buffered_event.
>> * Maintenance is performed on trace_buffered_event, all per-CPU event
>>   buffers get freed.
>> * The code invokes enable_trace_buffered_event() via
>>   smp_call_function_many(). This decrements trace_buffered_event_cnt and
>>   releases the access to trace_buffered_event.
>>
>> A problem is that smp_call_function_many() runs a given function on all
>> target CPUs except on the current one. The following can then occur:
>> * Task X executing trace_buffered_event_disable() runs on CPU A.
>> * The control reaches synchronize_rcu() and the task gets rescheduled on
>>   another CPU B.
>> * The RCU synchronization finishes. At this point,
>>   trace_buffered_event_disable() has the exclusive access to all
>>   trace_buffered_event variables except trace_buffered_event[A] because
>>   trace_buffered_event_cnt[A] is never incremented and if the buffer is
>>   currently unused, remains set to 0.
>> * A different task Y is scheduled on CPU A and hits a trace event. The
>>   code in trace_event_buffer_lock_reserve() sees that
>>   trace_buffered_event_cnt[A] is set to 0 and decides the use the buffer
>>   provided by trace_buffered_event[A].
>> * Task X continues its execution in trace_buffered_event_disable(). The
>>   code incorrectly frees the event buffer pointed by
>>   trace_buffered_event[A] and resets the variable to NULL.
>> * Task Y writes event data to the now freed buffer and later detects the
>>   created inconsistency.
>>
>> The issue is observable since commit dea499781a11 ("tracing: Fix warning
>> in trace_buffered_event_disable()") which moved the call of
>> trace_buffered_event_disable() in __ftrace_event_enable_disable()
>> earlier, prior to invoking call->class->reg(.. TRACE_REG_UNREGISTER ..).
>> The underlying problem in trace_buffered_event_disable() is however
>> present since the original implementation in commit 0fc1b09ff1ff
>> ("tracing: Use temp buffer when filtering events").
>>
>> The bug is simply fixable by replacing smp_call_function_many() by
>> on_each_cpu_mask(), but the code has other issues as well:
> 
> Or by simply calling the update for the local CPU as well as the many:
> 
> 	preempt_disable();
> 	/* For each CPU, set the buffer as used. */
> 	disable_trace_buffered_event(NULL);
> 	smp_call_function_many(tracing_buffer_mask,
> 			       disable_trace_buffered_event, NULL, 1);
> 	preempt_enable();
> 
>> * Function trace_event_buffer_lock_reserve() reads trace_buffered_event
>>   and trace_buffered_event_cnt in reverse order than they are written in
>>   trace_buffered_event_disable() and without any memory barrier. It
>>   could happen that trace_event_buffer_lock_reserve() still finds
>>   a valid pointer in trace_buffered_event which is being freed by
>>   trace_buffered_event_disable() but later already sees the decremented
>>   value of trace_buffered_event_cnt back to 0 and incorrectly decides to
>>   use the provided buffer.
> 
> Not an issue (see below)
> 
>> * Function trace_buffered_event_enable() initializes memory of each
>>   allocated trace_buffered_event to zero but no memory barrier is
>>   present to ensure this operation is completed before publishing its
>>   pointer for use in trace_event_buffer_lock_reserve().
> 
> Yes, a wmb() may be helpful, but as the reader will see either the
> allocated page or NULL, and can handle both cases. I decided not to add it
> because it really doesn't matter if we do.

My concern is about the earlier call "memset(event, 0, sizeof(*event));"
in trace_buffered_event_enable() which writes the obtained event page
prior to publishing it via "per_cpu(trace_buffered_event, cpu) = event;".
I think another CPU running trace_event_buffer_lock_reserve() could see
already the valid event pointer, write to the event page and only then
the memory could see the memset() write coming from
trace_buffered_event_enable(). The event data would then become
corrupted.

> 
>> * Calling function trace_buffered_event_enable() normally requires
>>   pairing it with trace_buffered_event_disable(). However, the function
>>   has no error return code and in case of a failure decrements back
>>   trace_buffered_event_ref. This results in underflow of the counter
>>   when trace_buffered_event_disable() gets called later.
> 
> Not an issue.
> 
> Even on failure the ref count will be greater than zero, where 
> trace_buffered_event_disable() handles it properly, and the freeing can
> handle no pages being allocated.
> 
> That is:
> 
> 	free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
> 
> would be the same as: free_page((unsigned long)NULL);
> 
> Which is perfectly fine to do.

The situation that I have on my mind is the following:
* The counter trace_buffered_event_ref is at 0.
* The soft mode gets enabled for some event and
  trace_buffered_event_enable() is called. The function increments
  trace_buffered_event_ref to 1 and starts allocating event pages.
* The allocation fails for some page and trace_buffered_event_disable()
  is called for cleanup.
* Function trace_buffered_event_disable() decrements
  trace_buffered_event_ref back to 0, recognizes that it was the last
  use of buffered events and frees all allocated pages.
* The control goes back to trace_buffered_event_enable() which returns.
  The caller of trace_buffered_event_enable() has no information that
  the function actually failed.
* Some time later, the soft mode is disabled for the same event.
  Function trace_buffered_event_disable() is called. It warns on
  "WARN_ON_ONCE(!trace_buffered_event_ref)" and returns.

The end result is only an ugly warning but I think it is still good to
fix.

>>
>> Instead of using the per-CPU variable trace_buffered_event_cnt for the
>> exclusive access during the disable operation, introduce a new variable
>> trace_buffered_event_enabled to reflect the current state and
>> appropriately adjust the code. The variable indicates whether buffered
>> events are currently enabled and trace_buffered_event together with
>> trace_buffered_event_cnt are ok to use.
> 
> The current logic is perfectly fine. The only bug here (which you found)
> was the missing update to the counter of the current CPU.
> 
>>
>> The updated synchronization mechanism fixes the mentioned problems and
>> avoids also sending IPIs across the system.
>>
>> Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
>> Fixes: dea499781a11 ("tracing: Fix warning in trace_buffered_event_disable()")
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
> 
> Let me explain why it works.
> 
> In trace_event_buffer_lock_reserve():
> 
> 		preempt_disable_notrace();
> 		if ((entry = __this_cpu_read(trace_buffered_event))) {
> 			int max_len = PAGE_SIZE - struct_size(entry, array, 1);
> 
> 			val = this_cpu_inc_return(trace_buffered_event_cnt);
> 
> 			if (val == 1 && likely(len <= max_len)) {
> 
> If val == 1 and len <= max_len, then this is going to use the "buffered event".
> 
> Notice that preemption is disabled.
> 
> 				trace_event_setup(entry, type, trace_ctx);
> 				entry->array[0] = len;
> 				/* Return with preemption disabled */
> 				return entry;
> 
> And we return with preemption disabled!
> 
> Everything after this does not use the "buffered event" and is not part of
> this code.
> 
> 			}
> 			this_cpu_dec(trace_buffered_event_cnt);
> 		}
> 		/* __trace_buffer_lock_reserve() disables preemption */
> 		preempt_enable_notrace();
> 
> 
> Now, on commit (when we are done with the "buffered event"):
> 
> __buffer_unlock_commit(struct trace_buffer *buffer, struct ring_buffer_event *event)
> {
> 	__this_cpu_write(trace_taskinfo_save, true);
> 
> 	/* If this is the temp buffer, we need to commit fully */
> 	if (this_cpu_read(trace_buffered_event) == event) {
> 		/* Length is in event->array[0] */
> 		ring_buffer_write(buffer, event->array[0], &event->array[1]);
> 		/* Release the temp buffer */
> 		this_cpu_dec(trace_buffered_event_cnt);
> 		/* ring_buffer_unlock_commit() enables preemption */
> 		preempt_enable_notrace();
> 
> Preemption is finally enabled here. That is, this could not preempt from
> the time we found the "buffered event" to the time we released it.
> 
> 	} else
> 		ring_buffer_unlock_commit(buffer);
> }
> 
> 
> Now lets look at the trace_buffered_event_disable():
> 
> void trace_buffered_event_disable(void)
> {
> 	int cpu;
> 
> 	WARN_ON_ONCE(!mutex_is_locked(&event_mutex));
> 
> 	if (WARN_ON_ONCE(!trace_buffered_event_ref))
> 		return;
> 
> 	if (--trace_buffered_event_ref)
> 		return;
> 
> 	preempt_disable();
> 	/* For each CPU, set the buffer as used. */
> 	smp_call_function_many(tracing_buffer_mask,
> 			       disable_trace_buffered_event, NULL, 1);
> 	preempt_enable();
> 
> The above will up the counter of all the buffers (after the bug you found
> is fixed ;-)
> 
> That means, we just need to wait till all the currently running users of
> the buffer are done with it.
> 
> 	/* Wait for all current users to finish */
> 	synchronize_rcu();
> 
> The synchronize_rcu() also synchronizes preempt disabled sections. That is,
> after the synchronize_rcu() completes, all users of the "buffered event"
> are done with it, and because we upped the count, there will be no more
> users.
> 
> That is *there is no race here*!
> 
> At this point, there are no users of the "buffered event" and we can do
> whatever we want without locks or memory barriers. This is RCU 101.
> 
> 	for_each_tracing_cpu(cpu) {
> 		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
> 		per_cpu(trace_buffered_event, cpu) = NULL;
> 	}
> 	/*
> 	 * Make sure trace_buffered_event is NULL before clearing
> 	 * trace_buffered_event_cnt.
> 	 */
> 	smp_wmb();
> 
> 	preempt_disable();
> 	/* Do the work on each cpu */
> 	smp_call_function_many(tracing_buffer_mask,
> 			       enable_trace_buffered_event, NULL, 1);
> 	preempt_enable();
> }
> 
> 
> 
> Now, the reason you found the crash was from the first issue you mentioned.
> That is, we didn't disable the current CPU and if we migrated, things would
> get really messed up. The only fix here is to make sure all CPUs have their
> trace_buffered_event_cnt get incremented.

The potential race that I see is the following:
* Function trace_buffered_event_disable() is called on CPU 0. It
  increments trace_buffered_event_cnt on each CPU and waits via
  synchronize_rcu() for each user of trace_buffered_event to complete.
* After synchronize_rcu() is already finished, the situation is that all
  counters trace_buffered_event_cnt are at 1 and all pointers
  trace_buffered_event are still valid.
* At this point, on a different CPU 1, the execution reaches
  trace_event_buffer_lock_reserve(). The function calls
  preempt_disable_notrace() and enters an RCU read-side critical section
  but that is not important because all RCU stuff is already performed
  and completed in trace_buffered_event_disable(). The function proceeds
  and reads a still valid pointer from trace_buffered_event[CPU1] into
  the local variable "entry". However, it doesn't yet read
  trace_buffered_event_cnt[CPU1] which happens later.
* Function trace_buffered_event_disable() continues. It frees
  trace_buffered_event[CPU1] and decrements
  trace_buffered_event_cnt[CPU1] back to 0.
* Function trace_event_buffer_lock_reserve() continues. It reads and
  increments trace_buffered_event_cnt[CPU1] from 0 to 1. This makes it
  believe that it can use the "entry" that it already obtained but the
  pointer is now invalid and any access results in a use-after-free.

Thanks,
Petr
