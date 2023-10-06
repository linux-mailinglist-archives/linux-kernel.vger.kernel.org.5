Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB0C7BB117
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 07:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjJFFGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 01:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFFGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:06:01 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E93B6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 22:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmDj85VIgLEsyWnvQUcKe/1kWuow80JIUWkj/K2bUNStZ0mr7gNI35LK6S7WhrzRf4cq0AeQhoMo64++xVNPXE+I6C6EUpMVsZcm8FCKjiwpcDqeNdqRM2Cf7SmMsZzeMXPcez+NoRKjPQeM0t9p05CGHPx3Ivd6D0F3LOIoDKqCxAmoE57iqY0JCCbwrTlxfVOT0nSSXkQqrzOFWVOjsGjTU8JxxQmjhH8bgLHVL1IJEmtxccGLIuYSmCSLtg/MMJfkxWN/Zi+YKEKN5Jhch8OxYty/mHADbYEPcr5obwbpHv7oR30gUIRq9dCIZ6ZEVnT9rXzDhvG6pSoyjIVlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUvpePh6VZ0WaMB7EeY9q59Ivz84TIYfcZrqITEETv8=;
 b=ES5ywqwB8Fn+AzsUW6sC8I8+S731qUsm2yCyPHQ8qu4CXAU7lGQwFJVyNvE1QZbEx0v27QzBCZHkfX/OXGtzTT6sQTGVsiPx4nMwXFBI9t89iHdp0/ZaTnZmGS2dnlNgxbOwRYccsJkIQvP/Kpl0uWxTXV8HMJ8puL6sOXmEq7TOQbGa0SlIOVXh+Qtp7GynjF4jMfqt5mrNJZCpBjPsX6duWOBqvFi5TVYkIQAmh4iALaK9sCbSxMKEU7OAZCg8Tdr8I0Khq9cFtGgpRnP1HsiUrz8KWHvPqcyWrgaVK9qk/+P6o8feuKexHDy+n1aumcYla/n85rqD/dKvYljgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUvpePh6VZ0WaMB7EeY9q59Ivz84TIYfcZrqITEETv8=;
 b=pgO47TSd/cai1U1qGBpV19+jXh/gDYYztsp++vV05XyauW/WEcsuFsOhOkv0wi/aiUtq8jE2DhuQ54P8wzvGbouxodxkjqwMIrwk8YUpPaAB5WeQHzlFwX7ad7QUA0Ccu5bA08Se7OfxjyJ0fCbLUTF49p00ZZgNMmWTPdNlaqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 05:05:57 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 05:05:57 +0000
Message-ID: <f7e9279b-a2dc-1980-4134-c6868b47b4ee@amd.com>
Date:   Fri, 6 Oct 2023 10:35:43 +0530
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
X-ClientProxiedBy: PN2PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::8) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 842b25fc-17d4-4e54-1a7f-08dbc629ec79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5aG7N7wNcpkjMXWiY69kfNjoF48Cu4VqZSDoV5WAUsxKe01Py0n6uFo2q6jP1Vlfe96ZPAe4KRK5pMCC3q4BnDw6+TiKvMaGrsPI8LAcGGWeNz7ZEXkQ29CGPRIAouzT7uhS2mRRPmKHRHfF0qb+MIHRwGpJyITzUW0eVuQdSDdUzfBDXZK6uMGmF2lzACjfHPtEjBzl7LnwYQ9eaWEIxFb2pJiARAgLIWK4aJnwyxJ8ufZRnSgG5Rm1oou5R5w4GA9v0czoB1RzPzmibeo6/YOmZvXZ4Kwl0ND/oKMpLkuMxGLq1rn2eqSDN2V60soMbLdK41aUpNEPYLvLVImBfHVoRW4DT/rIf9r0VpTm3hV3EJbNM5vtQ/oWTobg19AvclsBMjM+U3rrZUN6+Dlw5A2oxD48dud6GJNfvOJVb5KCrzwYhcjgV4jF8HQC+c81zFeqVusouXpj5OpYU0/qieipkgjD2sbiAbKHrmqTKzkORtQ+SnfVVJBYR2lEWQIT5Wdd3mPApKaTZuqQiiDLR8+C3QjFGilJdXM3G7dKaZAiGwJ/VgmxlkS51WlKtda7JA4prfx/CX1zEoom2SIzVHMn0q686FMp/IRZExRTjyrm3hHf/tAtgy6HCDiBIbo9R7TTxn1PSbPNr9KVO3KC1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(53546011)(6512007)(6666004)(6506007)(6486002)(478600001)(86362001)(31696002)(38100700002)(2906002)(7416002)(83380400001)(26005)(2616005)(36756003)(5660300002)(66946007)(66476007)(8936002)(41300700001)(66556008)(54906003)(4326008)(316002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWdybmUzQWpTV21tWE5rKzkrU1U4MVp1VUlTS2NoaGIzU0F2Z2Zkb2VZVEp0?=
 =?utf-8?B?NE52ZWllQVpIdGlxV0RsdnhBVlpRTVBHeTZzdjc4K1RBRkJDc0NGaGRqUFN3?=
 =?utf-8?B?TFlwUDdqU0lYZDFtYWNkUzRuSlFlbGtpR2FRSnNBVUdpVlFnamxta2kxSHV2?=
 =?utf-8?B?Ui9ndVhoQjFnanFwbVloUkNsS1NyaWNBRkg1M0lPd3F1RE5jVUZxR1BHK0V5?=
 =?utf-8?B?NVgzb0dDeVhyTmZ1VXlFZm9FZGhVWjROTHhVNld3ZE5ld2hkUDZGbGJWV3ZN?=
 =?utf-8?B?bk0vSWxkQXlYVzVjZTdkSjZJUmQ0c1NQMUdXUTcxY1lWTis4dGRzU25xYUox?=
 =?utf-8?B?WWZpUXFReHgxem5BQlFQUCt6Z3hBUlNYOHI5bUxFbHFTT2xRbWtZS3NXOWVa?=
 =?utf-8?B?NThtcENYa2doaFZXYklDZUtySEFKRHNWQTFmS2ZISDB2VHBnbDZBQlFuZjAy?=
 =?utf-8?B?d2dwemJRLzFZM1lFbHl0azBPN2Z0VDVPQ0ZCYXlWZHJRanZKczhadlNkdFhp?=
 =?utf-8?B?Y1lGMkVNQkZ2NmdFZlcvTnhQNlhYeUpKbUdjWlNjQ2kwaUlQTzlQUmRFMDVa?=
 =?utf-8?B?K2s1Y1J5RGZraFRKVUZrT1M1TE0xblM3QzUxU3BVd3E0V3FidFVqdm5vbGRi?=
 =?utf-8?B?NW9iejQrdE0vRW9ydVhwSnVWcFYzVkhQTk1TeHoxbVRLVnFUL2tqNXExODJV?=
 =?utf-8?B?MmF5MktqWTZaaDlTZm95SHo3dFZMYmtxK2JxVkphRitEWWNaVnlwdnJvLzNW?=
 =?utf-8?B?dmZuZmdHR05ObE5iV3BFaDRNQXBOc3ZQQzFUMlJubkZWelpaSWlLNlBpM1dO?=
 =?utf-8?B?MzJzY3hqMEZBVVFNcGtPcTh4TXM5a21ESGJzV3RwVEZZdU4zaXMvNFBLTVZH?=
 =?utf-8?B?Ym94dXZGVTV6aEY5K1BMemNiMFFkaFBvRHd5dmJ6OEhreUFoeXZLcnFOOS95?=
 =?utf-8?B?Tzc0a1czdzBKclgxR3RuQ2dLVEd4dEkxUkQybGhTeFRWZ1lYbnVxMWlBT1BN?=
 =?utf-8?B?RFBEM3VTWVJjQlNjbTIwa3VPSFNkTEptTmR2SjFQREZlSTIvbmZuNzlSNkFB?=
 =?utf-8?B?SDNwSGNVdE00TDJsQmZiOWVRdTJZRW1SQ0JyMW0zeEswV2RITzBWamI5VmJi?=
 =?utf-8?B?MzA3TEtveXFhcEJvb05aMzF2QktYcXFMYVRQSFl1VnZOaTNwdTA2VWJHOGEr?=
 =?utf-8?B?ZmFKRUg0TGxWdkFXSHpMSHRFcTJrSUFWSEprWTQyVDdvWDFvRjVHTWJGNzl3?=
 =?utf-8?B?MVNnYXdzV2I1b2NoZmcyc3U1MDFnaDVTTFFBbTNKSnV6RnZCWmpndHNScmR0?=
 =?utf-8?B?bFFmWlIreDgxdWlWU0xtRUMyaTMvTkpNVHFGcVZrNGxSYTVtMWZFZ0lzZFV5?=
 =?utf-8?B?WWt2NEQrbzJmY0dGQ2thTjhWM1ZjNm0rcXpHaG9CSDdSWTNJbDMxZWplTFFV?=
 =?utf-8?B?QlJwT2dSQmdVLzZvTTk3NXdiQUl2L3o5dWdNeGFwc1hBZE1CY0V0VzRvSFRJ?=
 =?utf-8?B?SU1SOFh1QkQrdkZGMWtTRDB5aXdycnBlc1BMREwvOEtEK3pBTEFaUUFGSWJi?=
 =?utf-8?B?UU85ZVk0aTNTdEFjbk5EcWlmM1BCZEhpZmRuSWdjVzI4c3FoZjl3VWY1RDVB?=
 =?utf-8?B?RHdwdTFyWUtWUXBNVDYwT1JzSkJMYnB4M0VBMTVtZ1VIMzJSdlFhVTBwdHhY?=
 =?utf-8?B?K0tRa3ZBSFZkK0JKdW5qbkpwQW5ZdnhEUHpIOVZ1dkVYRGtJeXk2UzJrT2Ro?=
 =?utf-8?B?WUp1TUZyWExPUFAwVXhzZTZCT2RmTGJFQXJwSmxyK2QxbHA1Q0pLcTNRR29a?=
 =?utf-8?B?M2szdUh4ZFJlNXY2SEtyUHY1WXFQOG1hR2lNMXlvM3U4Z2FqckZlQW96SFpz?=
 =?utf-8?B?L28rbFRYSEZMWVFBQTE1YThnbUpjYWRwQnhoanFwR0pNWXhJY1hMMDZJWlls?=
 =?utf-8?B?ZTBmZlJaYkNHMGx4aWdiempIREpDaWNjM2JFTWhLU2FaWmZyaU1yTllUcGYv?=
 =?utf-8?B?N3d1YnE3TGdYaS9jSFBvc2NwdzdSei9MY3NweUprdUxLdjIzci9tTmF2VWZ3?=
 =?utf-8?B?ZGxiWVpkMVU0a1IwSTVZeHNTYnZ1akNFZEVBUSt4Skpva3A3OE1GaTNnTS9n?=
 =?utf-8?Q?CoL77/9JatDLcX1bn8+Jaq5X5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842b25fc-17d4-4e54-1a7f-08dbc629ec79
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 05:05:57.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1xrSvcazxqUQJVvITt1OWm0VcyQ3QOegifHlNTi5ZD3yom6cbVf1LAbJSYcQolIxhiycPH/7wqpMZCtDURLVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anna-Maria,

On 10/4/2023 6:04 PM, Anna-Maria Behnsen wrote:
> [..snip..]
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

Regarding above, are you referring to "wake_up_process(timeout->task)" in
"process_timeout()" ends up waking the task on an idle CPU instead of the
CPU where process_timeout() ran?

In which case, have you tried using the "WF_CURRENT_CPU" flag for the
wakeup? (landed upstream in v6.6-rc1) It is only used by wait queues in
kernel/sched/wait.c currently but perhaps we can have a
"wake_up_process_on_current_cpu()" that process_timeout() can call.

Something along the lines of:

	int wake_up_process_on_current_cpu(struct task_struct *p)
	{
		return try_to_wake_up(p, TASK_NORMAL, WF_CURRENT_CPU);
	}
	EXPORT_SYMBOL(wake_up_process_on_current_cpu);

Thoughts?

> 
> [..snip..]
> 

--
Thanks and Regards,
Prateek
