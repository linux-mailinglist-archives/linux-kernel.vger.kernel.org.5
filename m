Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858F478E562
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243423AbjHaEV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjHaEVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:21:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1364FA1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z63Y2D4fUfTwYPsX2MmiAjp7W/rV5fivUF1TGN2SA6+yx9sziG6+ymT3ZP7nls+gLegPTX6YYESi59obJj61Jm47VDj/iUqL35NytEaY+MbDIyDIT+8XS1Dl/yq1JOlKPhPhoRo505Av5iosgsqVdQMm2QFAau91lpdZjCnv76MmO6EQ9UokMaiOpDtc4p3vvYj/Kz9oCcUT+7rY+JTIxp0zMvLbmMnePTHW6QQhoiv2QIt8qUuSOhSkuI35jP9XcK5Qrcq/ew2oweo2fhQ3w3IgqXzpnUN8LD6Fgm2tb9gPEEaLpgqoMFhV5nT2R1vryxkFiGIGFsLQGH4XBgQs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odZvZRpx8qqgpPKyvazDOMoDoLoex18OxDrpXwJvqvY=;
 b=DYePCLCIONqYI2VjItan3vQA4XnPSuGwb6fY4sgEkUwB+9rh+ZfLOMCK+5XEX/AGQA8R16iEjsFrwmOAGOt5FlQs9+PLyzSsFzVc5cZg+TRGwPl+Jrlc3jG+ndVZjSCzLjwPKRaE6xT39xpG6BmfuiLFEishBGYezxN1gBUY+pnPnxjBMbdEn01sEHeeK7IgOVHZZfRX8kboOCCVx3bte5ZDA48n1eJqm6EpfltILQHQKVCXBvzwA+XaHkwYL4I5g3BQKcMyiMRXAHVR9Uo95llapltJN8ZV0csJLstM94LG+mvKohaBSQZVsfnmtLzIktK5LzsuaAeK1rWo2JJwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odZvZRpx8qqgpPKyvazDOMoDoLoex18OxDrpXwJvqvY=;
 b=sVrx+TTSreuWOSLEvlCPyJI87+OB7Rq8Ko5tZ44c+t7oUm7/NemQfa3wKxr3fXIwT1SNqN19AFwCXYTKW+tXCsUpmJxy+pX4A1obpbGIOYK8jKWxjN++QmKyTyDngkaOsQkdC5JdqROCbgZk/Z7uJ92vIwg5S6wy+J9mcBQDY9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Thu, 31 Aug
 2023 04:21:15 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 04:21:15 +0000
Message-ID: <1ef98b4e-80da-b524-3a01-bdf3b85f1db3@amd.com>
Date:   Thu, 31 Aug 2023 09:51:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 0/7] sched: Implement shared runqueue in CFS
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com
References: <20230809221218.163894-1-void@manifault.com>
 <ZN3dW5Gvcb0LFWjs@BLR-5CG11610CF.amd.com> <20230818050355.GA5718@maniforge>
 <ZN8wfiAVttkNnFDe@BLR-5CG11610CF.amd.com>
 <ZOc7i7wM0x4hF4vL@BLR-5CG11610CF.amd.com> <20230824225150.GB6119@maniforge>
 <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831023254.GC506447@maniforge>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230831023254.GC506447@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::21) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 972fe650-feb3-4f49-f1e0-08dba9d9b726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWhVdL8iggqyp+K2RKw+PoyyqDtHFr+J9ipr+vNz4xqetPz88avOjqQ63texAMo0Zt5j//SN8GJWCaCMtsOVx9bUwpWlRPrUnbHzAqfhu/V+cjWo4x7gnXYHFwNJZwyAl28G7QNArCM1U7FNdbFN800YpfF6fjgnOP2gUKbppMK3QXo6xYx0ayNcOhDFmgOuKDzVmy03kNlmJVRpxNiAEiEtCETewPcSfp+T7tNLSQy94QB3qDlR7V4bERVfWmzP3yphbY+ZVrvgHb7E/jKtjK2phPOrM8eqNsn19F0W3Ft8XR9fn3TM4bNqkA6a3nfr24VQjeSNnuhic2+gyFJawpfEL+3xnh/0HWNHZTXr2FUZSV8TXkEfy0jnkmIkXjoyigzK7tzlsDDKOF/ooEnSbaRzjRe5wCYJUkaHKoR701I07GWbLL1acfb7F4MUp5sZ9ysQ2cSba3kenXUxKpCHjf0tJ/NbwHYtLDZ54JyIFQJiu6MDdU2LuI/cLwSY8+JvUciHGFkOut0KFTpc91MWNfwAF31VLvio2OPwpUIt+YhkAo/bQRP+Q7eWvgsb4NfoValteMY601r7nMX9SpWorA1U8iWqjuDUfL4J4oXXHGJqoYdpo7R0/PTWuSCAgVbm796o47C56yEIdZO1NsJ2OlTXmaHBTDQTkH0cLk98R8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(186009)(1800799009)(451199024)(4326008)(6666004)(6506007)(6486002)(6512007)(53546011)(966005)(478600001)(30864003)(26005)(8676002)(6916009)(66476007)(66946007)(316002)(8936002)(41300700001)(5660300002)(66556008)(2616005)(7416002)(36756003)(83380400001)(38100700002)(2906002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRqTkxFbmdjQ1l1eFkzUm9zcGZqMFoxQjZxcjdaVTNQZzJMOFNoVkVQTi9G?=
 =?utf-8?B?K0dtZnVWMFk3Z0N1MzA1eHRSdFp0bCtoWmtxRHR0K3ZpaDd6cHV2UzBjcTZL?=
 =?utf-8?B?aTd2ZzlvS3djbllwLzU5b3JVbVkvaHBTSncrNGdud3pQVk03Rk9sTkMzWUhO?=
 =?utf-8?B?b0RCRFZkSjFBQUh2eUhmd1lLaTFKVDBDNytobENxcEdHMUtEeFhNa0Iya1VE?=
 =?utf-8?B?WHc2cFJXOXhMYlVucDFlOTJmcy9IUFFkTnljWkJKZlppKzdCVDNaMzV0eW95?=
 =?utf-8?B?QkE5SkwyN3dtcnB4bFM5c2xyc0E5SWpDZ25MWjJ1bno4RHBoalNidUlxQTJP?=
 =?utf-8?B?Unl2RDZPZUVHMUtlUHdLVlMxMEJORXVDREtJaFpFaUpUZ3NCdFNyUVVFdmRs?=
 =?utf-8?B?OE4rRC9wRjlkWTM5NDdQaStGdURVNFhZeGlTengzTkpqS0NNZklaSEpHZFFF?=
 =?utf-8?B?QmM0MEZvSmlwemgzeEI1dWRPZGZmaUtSQjdKR0JNeFdnb3I3U3pwam8vVmEw?=
 =?utf-8?B?RngxZnErSS82MXBlY0VIU3UrUWhld3BEUFBjWnh5RlNRR3BDVFhLSlR2KzhQ?=
 =?utf-8?B?dlFnNUIzblZXZFBiM2NnS2VoY3lQY1EvQXFJVDM0L0NPWVltWXZPOGlkeVhq?=
 =?utf-8?B?WVltRVQ1SjZBaER6ZzJha2NETUtLRmt0cDkvT2FCM2RpMy8xRmlCUjFNd2Nl?=
 =?utf-8?B?SjRGNmt6TnR6M0tPY09sTmt4bmZRYWNBK1BlMTBCT0QwWXl3S3piZjkzUk40?=
 =?utf-8?B?OXZkdlUwcVZOeUVOcXQ2em9QQTh4ZHJENmNId091cXB6TTlDZkhYYmpKRWF0?=
 =?utf-8?B?bGdPckVBaDM2d2FrTUVwd1dZa0xjNEVvN3NUUDJJeUFpQU5mdThOdjJDcEFK?=
 =?utf-8?B?MTRDc3p3cEpvdTJ6Nkx4OHVEcHltOE56cG9sejNPaEIzUXBrSjB5OEhDWnVa?=
 =?utf-8?B?YWxnZ2t5TkFZZE9wdkZQYmo2anpCUnJPbGdWaUVhSVlIOGVKMkg3RmxtblJt?=
 =?utf-8?B?RDdLY1B5UXN3RGs5M052Q3YwQzhWem0rNUxUUStRa0U5d3dNY3ZhbTNURUVG?=
 =?utf-8?B?cmJHbDlGZE9aTVp1Rk9KUi9SMExKT1VmaW5OblREYmJaRmdHanZyRGRQZjY1?=
 =?utf-8?B?MTN6RjJSYVZSaTBUcldlbUFwRG1Ja1JWMGtzM3JuMStqeWdiTmlSMSs3VkJ0?=
 =?utf-8?B?WFhKaGllaFZMZnNlMEpIdHBrd3RXNkF2eVE4TkhTZmdyNGpyV2tDUmp0MXQy?=
 =?utf-8?B?Y1hONE1xS3pNTUxwSHVjeGlMOEQ0SjYyY244MmRxcGo3cW9NckNzenl0WEpV?=
 =?utf-8?B?NGg3TEZkUTFvdVJ5ZlFJbkZob0p3QktiOVlCcFptQThqWFVnYVBWdmtWTE14?=
 =?utf-8?B?cGtzTVVwY2hrZmIrbTI4dTNZUVhTZjRQYll2NFJiZjkreUFpMSt2LzVTOXFQ?=
 =?utf-8?B?NktKd056Y25SSTRibDlIbG5DN1JDRk9QL1FNbmhnV3lZVUwrc3k2OXF4TFJn?=
 =?utf-8?B?Zk55OHI0cTlSM056ZlJXVjU4YTUyU0VyVzV2ZklUcnpjbGt3U045T0NzOHBy?=
 =?utf-8?B?d0RiYkFQNFlpUmRxTGdacjRuRGRxYm9xTUdmSmV6Zm9mMWVHWkR1aDNMYWFw?=
 =?utf-8?B?a3JLeVBjemtMZkFpU0xyL1RaMGNnUXBndUtrdUFrNEVHcDRsVHRIZnRWSUZo?=
 =?utf-8?B?ZmdpUGZWc2RtVTVPZWtsTFhrNGw4Q21NNFBlRzlDUGExMGtHVGlUZFRPN0JF?=
 =?utf-8?B?RFNjS2J1RXdjRDE1aDBLL2xSVG12d2plbVhUSUprNzluWTBvKzJnNURnVVN5?=
 =?utf-8?B?cFFGNVZJVXdIemVlOFZ5Zy91Z1E2SG9Ia0h0RDVOa1FRQkZCQnJENEJ0Q1M5?=
 =?utf-8?B?U2ZEdmF3ZGxFVlNGLzlPbytLS1pPb2Q4VExxeXVUUWhqd29PU0tmL0hXT1A0?=
 =?utf-8?B?ZzVIcFVBMGRHK0tyTkw2VzZhUld6UWdvQVhQdHVsQ2JZMFQ5SGhibnB0amVp?=
 =?utf-8?B?WHRQMGNGUnh0TW5ZOXhCb2IxYlgxcTEyYXFBaDNSdVpjWWhNTk5iRW1PQzZh?=
 =?utf-8?B?UW1aSFJ5SWRyaVBEdnVMS2dlakFEbGZVZytNZ01qQW1FdUdycHRmTzRPbXZl?=
 =?utf-8?Q?t2yfkfP61CupVPp1kCMiUfP0C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972fe650-feb3-4f49-f1e0-08dba9d9b726
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 04:21:15.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bqj8NjRe/cHm/2euuPxfFuFd+aPKTT5l3jjP+b1WZs4hO7Tbo5EtrYEe8lT4U8JDt3+yTMkMg8HVBkBRDepMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Thank you for taking a look at the report.

On 8/31/2023 8:02 AM, David Vernet wrote:
> On Wed, Aug 30, 2023 at 03:26:40PM +0530, K Prateek Nayak wrote:
>> Hello David,
> 
> Hello Prateek,
> 
>>
>> Short update based on some of my experimentation.
>>
>> Disclaimer: I've been only looking at tbench 128 client case on a dual
>> socket 3rd Generation EPYC system (2x 64C/128T). Wider results may
>> vary but I have some information that may help with the debug and to
>> proceed further.
>>
>> On 8/25/2023 4:21 AM, David Vernet wrote:
>>> On Thu, Aug 24, 2023 at 04:44:19PM +0530, Gautham R. Shenoy wrote:
>>>> Hello David,
>>>>
>>>> On Fri, Aug 18, 2023 at 02:19:03PM +0530, Gautham R. Shenoy wrote:
>>>>> Hello David,
>>>>>
>>>>> On Fri, Aug 18, 2023 at 12:03:55AM -0500, David Vernet wrote:
>>>>>> On Thu, Aug 17, 2023 at 02:12:03PM +0530, Gautham R. Shenoy wrote:
>>>>>>> Hello David,
>>>>>>
>>>>>> Hello Gautham,
>>>>>>
>>>>>> Thanks a lot as always for running some benchmarks and analyzing these
>>>>>> changes.
>>>>>>
>>>>>>> On Wed, Aug 09, 2023 at 05:12:11PM -0500, David Vernet wrote:
>>>>>>>> Changes
>>>>>>>> -------
>>>>>>>>
>>>>>>>> This is v3 of the shared runqueue patchset. This patch set is based off
>>>>>>>> of commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
>>>>>>>> bandwidth in use") on the sched/core branch of tip.git.
>>>>>>>
>>>>>>>
>>>>>>> I tested the patches on Zen3 and Zen4 EPYC Servers like last time. I
>>>>>>> notice that apart from hackbench, every other bechmark is showing
>>>>>>> regressions with this patch series. Quick summary of my observations:
>>>>>>
>>>>>> Just to verify per our prior conversation [0], was this latest set of
>>>>>> benchmarks run with boost disabled?
>>>>>
>>>>> Boost is enabled by default. I will queue a run tonight with boost
>>>>> disabled.
>>>>
>>>> Apologies for the delay. I didn't see any changes with boost-disabled
>>>> and with reverting the optimization to bail out of the
>>>> newidle_balance() for SMT and MC domains when there was no task to be
>>>> pulled from the shared-runq. I reran the whole thing once again, just
>>>> to rule out any possible variance. The results came out the same.
>>>
>>> Thanks a lot for taking the time to run more benchmarks.
>>>
>>>> With the boost disabled, and the optimization reverted, the results
>>>> don't change much.
>>>
>>> Hmmm, I see. So, that was the only real substantive "change" between v2
>>> -> v3. The other changes were supporting hotplug / domain recreation,
>>> optimizing locking a bit, and fixing small bugs like the return value
>>> from shared_runq_pick_next_task(), draining the queue when the feature
>>> is disabled, and fixing the lkp errors.
>>>
>>> With all that said, it seems very possible that the regression is due to
>>> changes in sched/core between commit ebb83d84e49b ("sched/core: Avoid
>>> multiple calling update_rq_clock() in __cfsb_csd_unthrottle()") in v2,
>>> and commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
>>> bandwidth in use") in v3. EEVDF was merged in that window, so that could
>>> be one explanation for the context switch rate being so much higher.
>>>
>>>> It doesn't appear that the optimization is the cause for increase in
>>>> the number of load-balancing attempts at the DIE and the NUMA
>>>> domains. I have shared the counts of the newidle_balance with and
>>>> without SHARED_RUNQ below for tbench and it can be noticed that the
>>>> counts are significantly higher for the 64 clients and 128 clients. I
>>>> also captured the counts/s of find_busiest_group() using funccount.py
>>>> which tells the same story. So the drop in the performance for tbench
>>>> with your patches strongly correlates with the increase in
>>>> load-balancing attempts.
>>>>
>>>> newidle balance is undertaken only if the overload flag is set and the
>>>> expected idle duration is greater than the avg load balancing cost. It
>>>> is hard to imagine why should the shared runq cause the overload flag
>>>> to be set!
>>>
>>> Yeah, I'm not sure either about how or why woshared_runq uld cause this
>>> This is purely hypothetical, but is it possible that shared_runq causes
>>> idle cores to on average _stay_ idle longer due to other cores pulling
>>> tasks that would have otherwise been load balanced to those cores?
>>>
>>> Meaning -- say CPU0 is idle, and there are tasks on other rqs which
>>> could be load balanced. Without shared_runq, CPU0 might be woken up to
>>> run a task from a periodic load balance. With shared_runq, any active
>>> core that would otherwise have gone idle could pull the task, keeping
>>> CPU0 idle.
>>>
>>> What do you think? I could be totally off here.
>>>
>>> From my perspective, I'm not too worried about this given that we're
>>> seeing gains in other areas such as kernel compile as I showed in [0],
>>> though I definitely would like to better understand it.
>>
>> Let me paste a cumulative diff containing everything I've tried since
>> it'll be easy to explain.
>>
>> o Performance numbers for tbench 128 clients:
>>
>> tip			: 1.00 (Var: 0.57%)
>> tip + vanilla v3	: 0.39 (var: 1.15%) (%diff: -60.74%)
>> tip + v3 + diff		: 0.99 (var: 0.61%) (%diff: -00.24%)
>>
>> tip is at commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when
>> cfs bandwidth in use"), same as what Gautham used, so no EEVDF yet.
>>
>> o Cumulative Diff
>>
>> Should apply cleanly on top of tip at above commit + this series as is.
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d67d86d3bfdf..f1e64412fd48 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -198,7 +198,7 @@ struct shared_runq_shard {
>>  } ____cacheline_aligned;
>>  
>>  /* This would likely work better as a configurable knob via debugfs */
>> -#define SHARED_RUNQ_SHARD_SZ 6
>> +#define SHARED_RUNQ_SHARD_SZ 16
>>  #define SHARED_RUNQ_MAX_SHARDS \
>>  	((NR_CPUS / SHARED_RUNQ_SHARD_SZ) + (NR_CPUS % SHARED_RUNQ_SHARD_SZ != 0))
>>  
>> @@ -322,20 +322,36 @@ void shared_runq_toggle(bool enabling)
>>  }
>>  
>>  static struct task_struct *
>> -shared_runq_pop_task(struct shared_runq_shard *shard, int target)
>> +shared_runq_pop_task(struct shared_runq_shard *shard, struct rq *rq)
>>  {
>> +	int target = cpu_of(rq);
>>  	struct task_struct *p;
>>  
>>  	if (list_empty(&shard->list))
>>  		return NULL;
>>  
>>  	raw_spin_lock(&shard->lock);
>> +again:
>>  	p = list_first_entry_or_null(&shard->list, struct task_struct,
>>  				     shared_runq_node);
>> -	if (p && is_cpu_allowed(p, target))
>> +
>> +	/* If we find a task, delete if from list regardless */
>> +	if (p) {
>>  		list_del_init(&p->shared_runq_node);
>> -	else
>> -		p = NULL;
>> +
>> +		if (!task_on_rq_queued(p) ||
>> +		    task_on_cpu(task_rq(p), p) ||
> 
> Have you observed !task_on_rq_queued() or task_on_cpu() returning true
> here? The task should have removed itself from the shard when
> __dequeue_entity() is called from set_next_entity() when it's scheduled
> in pick_next_task_fair(). The reason we have to check in
> shared_runq_pick_next_task() is that between dequeuing the task from the
> shared_runq and getting its rq lock, it could have been scheduled on its
> current rq. But if the task was scheduled first, it should have removed
> itself from the shard.

Ah! Thank you for clarifying. This is just a copy-paste of the bailout
in shared_runq_pick_next_task(). I see "!task_on_rq_queued()" cannot be
true here since this is with the shared rq lock held. Thank you for
pointing this out.

> 
>> +		    !is_cpu_allowed(p, target)) {
>> +			if (rq->ttwu_pending) {
>> +				p = NULL;
>> +				goto out;
>> +			}
> 
> Have you observed this as well? If the task is enqueued on the ttwu
> queue wakelist, it isn't enqueued on the waking CPU, so it shouldn't be
> added to the shared_runq right?

This is a bailout on the retry logic. Since the shared_rq could contain
many tasks, I did not want to retry until the queue goes empty with a
possible pending wakeup. ... [1]

> 
>> +
>> +			goto again;
>> +		}
>> +	}
>> +
>> +out:
>>  	raw_spin_unlock(&shard->lock);
>>  
>>  	return p;
>> @@ -380,9 +396,12 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>>  		curr_idx = (starting_idx + i) % num_shards;
>>  		shard = &shared_runq->shards[curr_idx];
>>  
>> -		p = shared_runq_pop_task(shard, cpu_of(rq));
>> +		p = shared_runq_pop_task(shard, rq);
>>  		if (p)
>>  			break;
>> +
>> +		if (rq->ttwu_pending)
>> +			return 0;
> 
> Same here r.e. rq->ttwu_pending. This should be handled in the
> 
> if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p))
> 
> check below, no? Note that task_on_rq_queued(p) should only return true
> if the task has made it to ttwu_do_activate(), and if it hasn't, I don't
> think it should be in the shard in the first place.

Noted! Thank you for clarifying again. 

> 
>>  	}
>>  	if (!p)
>>  		return 0;
>> @@ -395,17 +414,16 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>>  	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p)) {
>>  		update_rq_clock(src_rq);
>>  		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
>> -		ret = 1;
>>  	}
>>  
>>  	if (src_rq != rq) {
>>  		task_rq_unlock(src_rq, p, &src_rf);
>>  		raw_spin_rq_lock(rq);
>>  	} else {
>> +		ret = 1;
>>  		rq_unpin_lock(rq, &src_rf);
>>  		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
>>  	}
>> -	rq_repin_lock(rq, rf);
> 
> Huh, wouldn't this cause a WARN to be issued the next time we invoke
> rq_clock() in newidle_balance() if we weren't able to find a task? Or
> was it because we moved the SHARED_RUNQ logic to below where we check
> rq_clock()? In general though, I don't think this should be removed. At
> the very least, it should be tested with lockdep.

So beyond this point, ret != 0, which will now jump to "out_swq" label
in newidle_balance()  which does a "rq_repin_lock(this_rq, rf)" just
before returning.

I'll check if my surgery is right with lockdep enabled.

> 
>>  	return ret;
>>  }
>> @@ -12344,50 +12362,59 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  	if (!cpu_active(this_cpu))
>>  		return 0;
>>  
>> -	if (sched_feat(SHARED_RUNQ)) {
>> -		pulled_task = shared_runq_pick_next_task(this_rq, rf);
>> -		if (pulled_task)
>> -			return pulled_task;
>> -	}
>> -
>>  	/*
>>  	 * We must set idle_stamp _before_ calling idle_balance(), such that we
>>  	 * measure the duration of idle_balance() as idle time.
>>  	 */
>>  	this_rq->idle_stamp = rq_clock(this_rq);
>>  
>> -	/*
>> -	 * This is OK, because current is on_cpu, which avoids it being picked
>> -	 * for load-balance and preemption/IRQs are still disabled avoiding
>> -	 * further scheduler activity on it and we're being very careful to
>> -	 * re-start the picking loop.
>> -	 */
>> -	rq_unpin_lock(this_rq, rf);
>> -
>>  	rcu_read_lock();
>> -	sd = rcu_dereference_check_sched_domain(this_rq->sd);
>> -
>> -	/*
>> -	 * Skip <= LLC domains as they likely won't have any tasks if the
>> -	 * shared runq is empty.
>> -	 */
>> -	if (sched_feat(SHARED_RUNQ)) {
>> +	if (sched_feat(SHARED_RUNQ))
>>  		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>> -		if (likely(sd))
>> -			sd = sd->parent;
>> -	}
>> +	else
>> +		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>>  
>>  	if (!READ_ONCE(this_rq->rd->overload) ||
>>  	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>>  
>> -		if (sd)
>> +		while (sd) {
>>  			update_next_balance(sd, &next_balance);
>> +			sd = sd->child;
>> +		}
>> +
>>  		rcu_read_unlock();
>>  
>>  		goto out;
>>  	}
>>  	rcu_read_unlock();
>>  
>> +	t0 = sched_clock_cpu(this_cpu);
>> +	if (sched_feat(SHARED_RUNQ)) {
>> +		pulled_task = shared_runq_pick_next_task(this_rq, rf);
>> +		if (pulled_task) {
>> +			curr_cost = sched_clock_cpu(this_cpu) - t0;
>> +			update_newidle_cost(sd, curr_cost);
>> +			goto out_swq;
>> +		}
>> +	}
> 
> Hmmm, why did you move this further down in newidle_balance()? We don't
> want to skip trying to get a task from the shared_runq if rq->avg_idle <
> sd->max_newidle_lb_cost.

I'll check if only rd->overload check is sufficient.

> 
>> +
>> +	/* Check again for pending wakeups */
>> +	if (this_rq->ttwu_pending)
>> +		return 0;
>> +
>> +	t1 = sched_clock_cpu(this_cpu);
>> +	curr_cost += t1 - t0;
>> +
>> +	if (sd)
>> +		update_newidle_cost(sd, curr_cost);
>> +
>> +	/*
>> +	 * This is OK, because current is on_cpu, which avoids it being picked
>> +	 * for load-balance and preemption/IRQs are still disabled avoiding
>> +	 * further scheduler activity on it and we're being very careful to
>> +	 * re-start the picking loop.
>> +	 */
>> +	rq_unpin_lock(this_rq, rf);
>>  	raw_spin_rq_unlock(this_rq);
>>  
>>  	t0 = sched_clock_cpu(this_cpu);
>> @@ -12400,6 +12427,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  
>>  		update_next_balance(sd, &next_balance);
>>  
>> +		/*
>> +		 * Skip <= LLC domains as they likely won't have any tasks if the
>> +		 * shared runq is empty.
>> +		 */
>> +		if (sched_feat(SHARED_RUNQ) && (sd->flags & SD_SHARE_PKG_RESOURCES))
>> +			continue;
> 
> This makes sense to me, good call.
> 
>> +
>>  		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
>>  			break;
>>  
>> @@ -12429,6 +12463,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  
>>  	raw_spin_rq_lock(this_rq);
>>  
>> +out_swq:
>>  	if (curr_cost > this_rq->max_idle_balance_cost)
>>  		this_rq->max_idle_balance_cost = curr_cost;
>>  
>> --
>>
>> o Breakdown
>>
>> I'll proceed to annotate a copy of diff with reasoning behind the changes:
> 
> Ah, ok, you provided explanations :-) I'll leave my questions above
> regardless for posterity.

And I'll refer to answers above ;)

> 
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d67d86d3bfdf..f1e64412fd48 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -198,7 +198,7 @@ struct shared_runq_shard {
>>  } ____cacheline_aligned;
>>  
>>  /* This would likely work better as a configurable knob via debugfs */
>> -#define SHARED_RUNQ_SHARD_SZ 6
>> +#define SHARED_RUNQ_SHARD_SZ 16
>>  #define SHARED_RUNQ_MAX_SHARDS \
>>  	((NR_CPUS / SHARED_RUNQ_SHARD_SZ) + (NR_CPUS % SHARED_RUNQ_SHARD_SZ != 0))
>>
>> --
>>
>> 	Here I'm setting the SHARED_RUNQ_SHARD_SZ to sd_llc_size for
>> 	my machine. I played around with this and did not see any
>> 	contention for shared_rq lock while running tbench.
> 
> I don't really mind making the shard bigger because it will never be one
> size fits all, but for what it's worth, I saw less contention in netperf
> with a size of 6, but everything else performed fine with a larger
> shard. This is one of those "there's no right answer" things, I'm
> afraid. I think it will be inevitable to make this configurable at some
> point, if we find that it's really causing inefficiencies.

Agreed! For tbench at least, this did not lead to any problems.

> 
>> --
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d67d86d3bfdf..f1e64412fd48 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -322,20 +322,36 @@ void shared_runq_toggle(bool enabling)
>>  }
>>  
>>  static struct task_struct *
>> -shared_runq_pop_task(struct shared_runq_shard *shard, int target)
>> +shared_runq_pop_task(struct shared_runq_shard *shard, struct rq *rq)
>>  {
>> +	int target = cpu_of(rq);
>>  	struct task_struct *p;
>>  
>>  	if (list_empty(&shard->list))
>>  		return NULL;
>>  
>>  	raw_spin_lock(&shard->lock);
>> +again:
>>  	p = list_first_entry_or_null(&shard->list, struct task_struct,
>>  				     shared_runq_node);
>> -	if (p && is_cpu_allowed(p, target))
>> +
>> +	/* If we find a task, delete if from list regardless */
> 
> As I mentioned in my other reply [0], I don't think we should always
> have to delete here. Let me know if I'm missing something.

I overlooked that condition at enqueue. I'll go back to original
implementation here.

> 
> [0]: https://lore.kernel.org/all/20230831013435.GB506447@maniforge/
> 
>> +	if (p) {
>>  		list_del_init(&p->shared_runq_node);
>> -	else
>> -		p = NULL;
>> +
>> +		if (!task_on_rq_queued(p) ||
>> +		    task_on_cpu(task_rq(p), p) ||
>> +		    !is_cpu_allowed(p, target)) {
>> +			if (rq->ttwu_pending) {
>> +				p = NULL;
>> +				goto out;
>> +			}
>> +
>> +			goto again;
>> +		}
>> +	}
>> +
>> +out:
>>  	raw_spin_unlock(&shard->lock);
>>  
>>  	return p;
>> --
>>
>> 	Context: When running perf with IBS, I saw following lock
>> 	contention:
>>
>> -   12.17%  swapper          [kernel.vmlinux]          [k] native_queued_spin_lock_slowpath
>>    - 10.48% native_queued_spin_lock_slowpath
>>       - 10.30% _raw_spin_lock
>>          - 9.11% __schedule
>>               schedule_idle
>>               do_idle
>>             + cpu_startup_entry
>>          - 0.86% task_rq_lock
>>               newidle_balance
>>               pick_next_task_fair
>>               __schedule
>>               schedule_idle
>>               do_idle
>>             + cpu_startup_entry
>>
>> 	So I imagined the newidle_balance is contending with another
>> 	run_queue going idle when pulling task. Hence, I moved some
>> 	checks in shared_runq_pick_next_task() to here.
> 
> Hmm, so the idea was to avoid contending on the rq lock? As I mentioned
> above, I'm not sure these checks actually buy us anything.

Yup! I think skipping newidle_balance() when rd->overload is not set
itself reduces this contention.

> 
>> 	I was not sure if the task's rq lock needs to be held to do this
>> 	to get an accurate result so I've left the original checks in
>> 	shared_runq_pick_next_task() as it is.
> 
> Yep, we need to have the rq lock held for these functions to return
> consistent data.

Noted! Will fall back to your implementation. Also I did not see
any perf improvement for tbench with this alone.

> 
>> 	Since retry may be costly, I'm using "rq->ttwu_pending" as a
>> 	bail out threshold. Maybe there are better alternates with
>> 	the lb_cost and rq->avg_idle but this was simpler for now.
> 
> Hmm, not sure I'm quite understanding this one. As I mentioned above, I
> don't _think_ this should ever be set for a task enqueued in a shard.
> Were you observing that?

Explained in [1] above. Let me get rid of that whole retry logic
because I see it leading to shared_rq lock contention at enqueue and
dequeue already.

> 
>> 	(Realizing as I write this that this will cause more contention
>> 	with enqueue/dequeue in a busy system. I'll check if that is the
>> 	case)
>>
>> 	P.S. This did not affect the ~60% regression I was seeing one
>> 	bit so the problem was deeper.
>>
>> --
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d67d86d3bfdf..f1e64412fd48 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -380,9 +396,12 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>>  		curr_idx = (starting_idx + i) % num_shards;
>>  		shard = &shared_runq->shards[curr_idx];
>>  
>> -		p = shared_runq_pop_task(shard, cpu_of(rq));
>> +		p = shared_runq_pop_task(shard, rq);
>>  		if (p)
>>  			break;
>> +
>> +		if (rq->ttwu_pending)
>> +			return 0;
>>  	}
>>  	if (!p)
>>  		return 0;
>> --
>>
>> 	More bailout logic.
>>
>> --
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d67d86d3bfdf..f1e64412fd48 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -395,17 +414,16 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>>  	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p)) {
>>  		update_rq_clock(src_rq);
>>  		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
>> -		ret = 1;
>>  	}
>>  
>>  	if (src_rq != rq) {
>>  		task_rq_unlock(src_rq, p, &src_rf);
>>  		raw_spin_rq_lock(rq);
>>  	} else {
>> +		ret = 1;
>>  		rq_unpin_lock(rq, &src_rf);
>>  		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
>>  	}
>> -	rq_repin_lock(rq, rf);
>>  
>>  	return ret;
>>  }
>> --
>>
>> 	Only return 1 is task is actually pulled else return -1
>> 	signifying the path has released and re-aquired the lock.
> 
> Not sure I'm following. If we migrate the task to the current rq, we
> want to return 1 to signify that there are new fair tasks present in the
> rq don't we? It doesn't need to have started there originally for it to
> be present after we move it.

Above move_queued_task(), I see the following comment

	Returns (locked) new rq. Old rq's lock is released.

so wouldn't "src_rq != rq" signify a failed migration? I'm probably
missing something here.

> 
>>
>> 	Also leave the rq_repin_lock() part to caller, i.e.,
>> 	newidle_balance() since it makes up for a nice flow (see
>> 	below).
>>
>> --
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d67d86d3bfdf..f1e64412fd48 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -12344,50 +12362,59 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  	if (!cpu_active(this_cpu))
>>  		return 0;
>>  
>> -	if (sched_feat(SHARED_RUNQ)) {
>> -		pulled_task = shared_runq_pick_next_task(this_rq, rf);
>> -		if (pulled_task)
>> -			return pulled_task;
>> -	}
>> -
>>  	/*
>>  	 * We must set idle_stamp _before_ calling idle_balance(), such that we
>>  	 * measure the duration of idle_balance() as idle time.
>>  	 */
>>  	this_rq->idle_stamp = rq_clock(this_rq);
>>  
>> -	/*
>> -	 * This is OK, because current is on_cpu, which avoids it being picked
>> -	 * for load-balance and preemption/IRQs are still disabled avoiding
>> -	 * further scheduler activity on it and we're being very careful to
>> -	 * re-start the picking loop.
>> -	 */
>> -	rq_unpin_lock(this_rq, rf);
>> -
>>  	rcu_read_lock();
>> -	sd = rcu_dereference_check_sched_domain(this_rq->sd);
>> -
>> -	/*
>> -	 * Skip <= LLC domains as they likely won't have any tasks if the
>> -	 * shared runq is empty.
>> -	 */
>> -	if (sched_feat(SHARED_RUNQ)) {
>> +	if (sched_feat(SHARED_RUNQ))
>>  		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>> -		if (likely(sd))
>> -			sd = sd->parent;
>> -	}
>> +	else
>> +		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>>  
>>  	if (!READ_ONCE(this_rq->rd->overload) ||
>>  	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>>  
>> -		if (sd)
>> +		while (sd) {
>>  			update_next_balance(sd, &next_balance);
>> +			sd = sd->child;
>> +		}
>> +
>>  		rcu_read_unlock();
>>  
>>  		goto out;
>>  	}
>>  	rcu_read_unlock();
>>  
>> +	t0 = sched_clock_cpu(this_cpu);
>> +	if (sched_feat(SHARED_RUNQ)) {
>> +		pulled_task = shared_runq_pick_next_task(this_rq, rf);
>> +		if (pulled_task) {
>> +			curr_cost = sched_clock_cpu(this_cpu) - t0;
>> +			update_newidle_cost(sd, curr_cost);
>> +			goto out_swq;
>> +		}
>> +	}
>> +
>> +	/* Check again for pending wakeups */
>> +	if (this_rq->ttwu_pending)
>> +		return 0;
>> +
>> +	t1 = sched_clock_cpu(this_cpu);
>> +	curr_cost += t1 - t0;
>> +
>> +	if (sd)
>> +		update_newidle_cost(sd, curr_cost);
>> +
>> +	/*
>> +	 * This is OK, because current is on_cpu, which avoids it being picked
>> +	 * for load-balance and preemption/IRQs are still disabled avoiding
>> +	 * further scheduler activity on it and we're being very careful to
>> +	 * re-start the picking loop.
>> +	 */
>> +	rq_unpin_lock(this_rq, rf);
>>  	raw_spin_rq_unlock(this_rq);
>>  
>>  	t0 = sched_clock_cpu(this_cpu);
>> --
>>
>> 	This hunk does a few things:
>>
>> 	1. If a task is successfully pulled from shared rq, or if the rq
>> 	   lock had been released and re-acquired with, jump to the
>> 	   very end where we check a bunch of conditions and return
>> 	   accordingly.
>>
>> 	2. Move the shared rq picking after the "rd->overload" and
>> 	   checks against "rq->avg_idle".
>>
>> 	   P.S. This recovered half the performance that was lost.
> 
> Sorry, which performance are you referring to? I'm not thrilled about
> this part because it's another heuristic for users to have to reason
> about. _Maybe_ it makes sense to keep the rd->overload check? I don't
> think we should keep the rq->avg_idle check though unless it's
> absolutely necessary, and I'd have to think more about the rq->overload
> check.

Performance everywhere is tbench-128 clients on test machine since I was
very focused on that alone. I understand why you are "not thrilled"
here. Let me go check which one of those conditions is more relevant.

(P.S. Anna-Maria did some experiments around avg_idle and tbench in
https://lore.kernel.org/lkml/80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de/) 

> 
>> 	3. Update the newidle_balance_cost via update_newidle_cost()
>> 	   since that is also used to determine the previous bailout
>> 	   threshold.
> 
> I think this makes sense as well, but need to think about it more.
> 
>> 	4. A bunch of update_next_balance().
> 
> I guess this should be OK, though I would expect us to have to load
> balance less with SHARED_RUNQ.
> 
>> 	5. Move rq_unpin_lock() below. I do not know the implication of
>> 	   this the kernel is not complaining so far (mind you I'm on
>> 	   x86 and I do not have lockdep enabled)
> 
> If you move rq_unpin_lock(), you should probably run with lockdep to see
> what happens :-) There are also implications for tracking whether it's
> safe to look at the rq clock.

Yup! I traced the path in code and it looked okay but this is just me
doing naive experiments. Lockdep should set me straight :)

> 
>>
>> 	A combination of 3 and 4 seemed to give back the other half of
>> 	tbench performance.
>>
>> --
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d67d86d3bfdf..f1e64412fd48 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -12400,6 +12427,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  
>>  		update_next_balance(sd, &next_balance);
>>  
>> +		/*
>> +		 * Skip <= LLC domains as they likely won't have any tasks if the
>> +		 * shared runq is empty.
>> +		 */
>> +		if (sched_feat(SHARED_RUNQ) && (sd->flags & SD_SHARE_PKG_RESOURCES))
>> +			continue;
>> +
> 
> Agreed on this.
> 
>>  		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
>>  			break;
>>  
>> --
>>
>> 	This was based on my suggestion in the parallel thread.
>>
>> 	P.S. This alone, without the changes in previous hunk showed no
>> 	difference in performance with results same as vanilla v3.
>>
>> --
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d67d86d3bfdf..f1e64412fd48 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -12429,6 +12463,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  
>>  	raw_spin_rq_lock(this_rq);
>>  
>> +out_swq:
>>  	if (curr_cost > this_rq->max_idle_balance_cost)
>>  		this_rq->max_idle_balance_cost = curr_cost;
>>  
>> --
>>
>> 	The last part of newidle_balance() does a bunch of accounting
>> 	which is relevant after the above changes. Also the
>> 	rq_repin_lock() I had removed now happens here.
>>
>> --
>>
>> Again most of this is lightly tested with just one workload but I would
>> like to hear your thoughts, especially with the significance of
>> "rd->overload", "max_newidle_lb_cost", and "update_next_balance()".
>> however, I'm afraid these may be the bits that led to the drop in
>> utilization you mentioned in the first place.
> 
> Exactly :-( I think your proposal to fix how we skip load balancing on
> the LLC if SHARED_RUNQ is enabled makes sense, but I'd really prefer to
> avoid adding these heuristics to avoid contention for specific
> workloads. The goal of SHARED_RUNQ is really to drive up CPU util. I
> don't think we're really doing the user many favors if we try to guess
> for them when they actually want that to happen.
> 
> If there's a time where we _really_ don't want or need to do it then
> absolutely, let's skip it. But I would really like to see this go in
> without checks on max_newidle_lb_cost, etc. The whole point of
> SHARED_RUNQ is that it should be less costly than iterating over O(n)
> cores to find tasks, so we _want_ to be more aggressive in doing so.

Agreed! I'll try to get a more palatable diff by the time you are
back from vacation.

> 
>> Most of the experimentation (except for rq lock contention using IBS)
>> was done by reading the newidle_balance() code.
> 
> And kudos for doing so!
> 
>> Finally a look at newidle_balance counts (tip vs tip + v3 + diff) for
>> 128-clients of tbench on the test machine:
>>
>>
>> < ----------------------------------------  Category:  newidle (SMT)  ---------------------------------------- >
>> load_balance cnt on cpu newly idle                         :     921871,   0	(diff: -100.00%)
>> --
>> < ----------------------------------------  Category:  newidle (MC)   ---------------------------------------- >
>> load_balance cnt on cpu newly idle                         :     472412,   0	(diff: -100.00%)
>> --
>> < ----------------------------------------  Category:  newidle (DIE)  ---------------------------------------- >
>> load_balance cnt on cpu newly idle                         :        114, 279	(diff: +144.74%)
>> --
>> < ----------------------------------------  Category:  newidle (NUMA) ---------------------------------------- >
>> load_balance cnt on cpu newly idle                         :          9,   9	(diff: +00.00%)
>> --
>>
>> Let me know if you have any queries. I'll go back and try to bisect the
>> diff to see if only a couple of changes that I thought were important
>> are good enought to yield back the lost performance. I'll do wider
>> testing post hearing your thoughts.
> 
> Hopefully my feedback above should give you enough context to bisect and
> find the changes that we really think are most helpful? To reiterate: I
> definitely think your change to avoid iterating over the LLC sd is
> correct and makes sense. Others possibly do as well such as checking
> rd->overload (though not 100% sure), but others such as the
> max_newidle_lb_cost checks I would strongly prefer to avoid.
> 
> Prateek -- thank you for doing all of this work, it's very much
> appreciated.

And thank you for patiently going through it all and clarifying all the
bits I have been missing :)

> 
> As I mentioned on the other email, I'll be on vacation for about a week
> and a half starting tomorrow afternoon, so I may be slow to respond in
> that time.

Enjoy your vacation! I'll keep the tread updated for you to read when
you get back :)

> 
> Thanks,
> David

--
Thanks and Regards,
Prateek
