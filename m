Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2E57DF175
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345524AbjKBLnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjKBLnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:43:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0262B133;
        Thu,  2 Nov 2023 04:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698925379; x=1730461379;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fpt/Pq/vfo683zpPCLGrfA2dVXxzHLeBeVpFHZxcQJ8=;
  b=epD/ehx/iTeyH+Yr2eohsThPO3iZJmErjnxsLTJPHXkUy1RKQXtfEeA7
   EFBNwo9uXhqsZ8udzk3bu6FMgltash8dYkq40GBrP4SOrocJ8cRmtBneh
   wIwzXU2xZOAqNtMcPz9oba2vCgV13BXuQ6EZAOvmasl87ny+p2BIeVqyX
   uI3i7p9aaeMraj2t717aDs5wXzy0yp6+dmH98qm98tQEg35CO86CQ9yld
   F57j4Gp8ESYFXdYjXTAWAkJPyLa7YykR61ZlgDfZoyCZgcjqFWOTusfCy
   cuCBwJL47RfL5CKxukbEZ5jrbvxbD91mnMS6Y7GCHBXmu1yKWVeNhjPnB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="10224212"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="10224212"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 04:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="761271212"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="761271212"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 04:42:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 04:42:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 04:42:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 04:42:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzKGNVn8PPDBWbiD+wJ85seHq54L/GV4OLZGYjXLTxqUAnFJKI5jYn4A/Yq9IbP8MbGpXJHRRL5YQTSl5oQYxIYTmozhxuhkF7QjXqALVZw2raMtMUIHrtFkeDV3SZR3QUSH3MyDn2QqhQgJeG+8uAPnxZsmIjoX8n/SzeKzMqcjskBgw2yzN3q3zybYwgQmUYdPRItWuunhHQmuMy2v4tV1kd4EeDW60cXmDa39St5olSNUcRs8GCk+Hd946QUsKlolYNhHI7Dis4emJCpGwn7f0exSQLwS5+YV/W4wj4VF9WuEYzlS04n8BbKqJiBsRRb/+PWqw6SoVtzn/JNA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzP9Q2OEbiuI2FkvbvQPOGk/r4qyjM2aJugwNs6zFtQ=;
 b=TtXFMfmM+U30SfK6PF97UD+pnHogkPX6rN2hRioGFeMgP0SDUwemThYkV34MDy7Cj5qrSHB6xNNzokgh6i0tkeIzl/OYvbEXpJqhrK0Ui6uCT+p4D8c6vwTdSmGcuaD1TkfbX1LjT5jLMZ9TnUO8qU83udLqq+BPT+i5zjc/Ii2zzPHGiWls4ckykjULwqpgymhre1dt22Z+KAgViMLQ1p38lg9Ec28mPQ4kf/x2vuzcNmBm2tlFi+2nrZIOHCott7W4FXnId/vo3V4JNd8UHJz5wpJogrHQSZVAdQ+k5eAC599imffnKX41PcToEOfMlpNPzi41DzCZc8Y2QNjgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB6606.namprd11.prod.outlook.com (2603:10b6:510:1b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 11:42:52 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 11:42:52 +0000
Message-ID: <0ee1daff-903e-4630-a4e9-6e3b39458186@intel.com>
Date:   Thu, 2 Nov 2023 12:41:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the bitmap tree
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
References: <20231019170106.4159eac5@canb.auug.org.au>
 <ZTFSHqjkHLM5iAqH@yury-ThinkPad> <ZTIBESMp9qsRdVja@yury-ThinkPad>
 <20231020155113.31acd611@canb.auug.org.au> <ZTJzi6OM9w/hYL1v@yury-ThinkPad>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZTJzi6OM9w/hYL1v@yury-ThinkPad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 671d6901-8396-41a4-f580-08dbdb98d903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FrF4594oW9l6vpVk0zv9qEx0hynlZb9I/eIFdn/4X8lLEhXTVc1bMmeSmToHAK7diEyHi21zg8gMtFK5c8/XiZfsOZilUikHtyvuLKtVLd46tsbYfB1uGQUvl4BqwfjmtHmggj0dYaa09rUP7TMRizcEWwGyW5FwMNLvNNXqK5es+s2twQ8DJD83NvFVyuCA7wAsOLFaItUYqO3cLS+Lh3sq81j17WaDVJWzRBbvxefyjBmTpFSkLQf/uao2FdELY7uyj2mdRDs27WEZzDcg2eP+voDkbjpemS94K8jHly6SGwizDAaI7bGwd3T46bNEUuDS6N8sWOeqa8o2Wy7j9tj1d14CeaFldEBKUK7ynOjIK9GXQ+FEC1lhSzsFfYrBxbL2hDHFOg/lYcNu4CPSy9I9LZ9jS/qWW8YRizDnyNDA94NfL5gZ3HHi+R6X5y+fQcRKECJL1pS9ov+rYW/vG9iff2R8gUx+BIzG/AprKtj2zoF6bBScRW4giQlFPWBwVn13xORAikVlXmQev1UPjv8AEwF6fVajv7NpoMJibXAMW6G94d50lQVxXa5jLL9Ig0LBDbYWnkwmHFYW+iYxVOOIJsJ2BxWWry20xBtCIwcJ4axAy28ZBq+Ejbom/x2bgCPvPGzYwcLAp7XLrwL+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(66476007)(316002)(54906003)(66556008)(66946007)(110136005)(6512007)(6666004)(26005)(6506007)(2616005)(38100700002)(36756003)(31696002)(82960400001)(86362001)(478600001)(5660300002)(6486002)(31686004)(8936002)(8676002)(4326008)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME44UkxVcHF4WXI4Y011NE9vbW1qS0puVlNEQTJTRHNGUFMwTTJER2p3dnJv?=
 =?utf-8?B?TW9Tcjc5WVRyNmIyRFZsSjZxai91RXVONnNCT21jemZOOEhnTVJuQWIxUWd0?=
 =?utf-8?B?ZkJuRGdQWnFYVERhSGVYQXJrc0x3QmZncDhpbzczQVZsR1JNWFVLMnZXQmVJ?=
 =?utf-8?B?YWVuaDdya1FzUEJ4MWIxQUpqWXVESlBNNlY5cXBtdlIwMC9uV2IxVkZrOGha?=
 =?utf-8?B?TmVkOGVKZU1CbEVtRGJuSzlhZjlOeHpmYzJIQmMxcjVMZkljUDVZV3B4MDIr?=
 =?utf-8?B?MDYyWnhTS2U5OWZVS0UvM1VBR3NYWlNERndTVzNKbXZuS3V4UDFxTCtJRDF1?=
 =?utf-8?B?dmVUMW5Lc2VhU05CWFVOUVJFL3pGeGJPdVRiTkFQUmMwbmFYS3lhdUFHSEVy?=
 =?utf-8?B?MXJiY1hqYXV3dVBkTkVvQUZKYTBhQ2JxUG5VRkdkRkZEQ3duSWJNZ0d3NjRh?=
 =?utf-8?B?YUsrVlMwa2QwU2IzVTlsTDlqaDB4azk0cVVZUjFPYmVaK3R3RjdubWN2bEc4?=
 =?utf-8?B?Rm9JRUtxRzk5ZkFBNGRJbXlCWlc1blk2RzNsQUkvK2xzenIzR1F0RjZtVi91?=
 =?utf-8?B?YlM4aTdnN1hwU1A5cnM4ZEhETmZkbzhCMnNTYzhxNkdFQmgydG04L3dnVXp1?=
 =?utf-8?B?N0MvcUVPYUgwWWNMTHI2RWVkNDJpODZPVEdHVlhUUGNxaHJZQzJveUZoUktV?=
 =?utf-8?B?dUxFdWRkZkRVR3lKVTJ2Sm5FcjFQWEdmcUVmSEJsMHE3bVZTcFIzeXJ1UnNI?=
 =?utf-8?B?K2g3N21Nc092Tk1pZUxzV0w5aFZ6TThBcFdWdmJlcmFSZ250bjZ6alpDaGFk?=
 =?utf-8?B?RzBFN2FLZHVFcXFhV3RPMnNIYzU4L1RPemFLOTQvYmVPK1FpZ3hlK2dSZnN2?=
 =?utf-8?B?clU4S3B3dVpRN09selk3WlFlWWhINzIyQWNiOEFXenZCck5lUFpnckptUElD?=
 =?utf-8?B?S0VCZkpwbWtBQVVNS1g4bTk4bXRDNTRuL01INm16aDRPeDY4VHFTZFRhcTFW?=
 =?utf-8?B?L1hEZk00ZXI3cGxONTRvSVJPNnFnTW9IN05UNVV5aGQvbmJnUEJ4M0J3NHR5?=
 =?utf-8?B?SW9UMThEMkhMeXpRMjRULzlpdWVrR24yMjlxMGFRb0ZCR200SjVJeG9pWjYz?=
 =?utf-8?B?RGUzc1kvdi90emI2VVluUGpmWmY4T2Z1bno5YStRMHkzejV4ZytsYU44R1lK?=
 =?utf-8?B?bS90cWZINmlGUEk5S3hDUXJGemNxSmYzRTJDSCtCdEhNc2ZhMjNzekRNeXE4?=
 =?utf-8?B?U0FWM29oQUxPQm9sTEdxUHoyRkZtQXIxYnI1ZTh0dWx1dlhUNUp0Qi9zVFFY?=
 =?utf-8?B?cGpZZzFpQ015UlU4dXJnaTl3ajJSM1N3dGYrcUZLdUZ4YlU4KzlYek9ESHl2?=
 =?utf-8?B?R3kzM090a0N5MWZUMzhjWmcxSkd2em03ZEsxSDNGclhrdlQvejlJQ1ZzMzU0?=
 =?utf-8?B?eXNxVk9ISVZ0TXUzZkNnSUNjM3JtN2kvUEhrQlBUM2IrVDRrYXNEZXI1Q2NT?=
 =?utf-8?B?MHcxNXkzam5UaXpudHdoZmhFTnNjdWlSVGs1Q1ZIOGxmdmw5TzlmQnJvY2pt?=
 =?utf-8?B?VUVSa1hRdXJCUDVwTU16RTlXb1lkS2RhelU1dVcyTmVpbWF1MmpBUDc0UGJM?=
 =?utf-8?B?WXUzd2swUVl2bm4xOHR6RkYvRnN2bGJ2UWpBTjFGajJjT01PMW5EeDlUVlB0?=
 =?utf-8?B?Yk9CYVcwdGZ2RUNGSURDZ2YreVpqUDBMd3ZDOGliMjN0T2VZUURxYjl4NVYy?=
 =?utf-8?B?eW5Tc0lGa0VBRWZJc1hJcEtscVNUMGJCdU9UQTNPOVNKMTFHWDdLM1FueVNU?=
 =?utf-8?B?d1d5NkNxMzQwb3NMYmZydFA2djBaL1VxYU1GTkpub1VheGRVamhPdk9HR1BV?=
 =?utf-8?B?QUZCWHowdG1wU2pDOHZtdTA1L1Rpak0zZC9uZit4ZERQa0s5cGRSdlRhR0lI?=
 =?utf-8?B?MTJKVkxWZlkyS0NJbEEyTk8wNk8xcmpjRlFoNFZTbHJnL0hDRUJBSkdmdkI1?=
 =?utf-8?B?N3FKOFo0RXRxUFJmSmcyZlpFaVEvWHpHcS9ONk9jdVBSeDNQb1FkU01oTkJF?=
 =?utf-8?B?ZWRiSlROVzZVTDlpT1lPSnVUOFFoUlFDRllJYnNwbFFmN3A3YUdSUzV6d084?=
 =?utf-8?B?UFFZazF0WnZQN3l1akNia3RlM095YUk0UjdiNjVGWkcyZG05aG1mQ3N6cjhW?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 671d6901-8396-41a4-f580-08dbdb98d903
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:42:52.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3i5nN+3YqjA7a22KHP/N6x1jOYonQ2RvGxYAjjB0PCzvTK8R0PplbJGRq1PiLLKJPcm6RziodGSdUk6YvWJH6DOFU6fcJotNXzFMFraVN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6606
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Fri, 20 Oct 2023 05:33:15 -0700

Sorry, was on long vacation :z

> On Fri, Oct 20, 2023 at 03:51:13PM +1100, Stephen Rothwell wrote:
>> Hi Yury,
>>
>> On Thu, 19 Oct 2023 21:24:49 -0700 Yury Norov <yury.norov@gmail.com> wrote:
>>>
>>> On Thu, Oct 19, 2023 at 08:58:24AM -0700, Yury Norov wrote:
>>>> On Thu, Oct 19, 2023 at 05:01:06PM +1100, Stephen Rothwell wrote:  
>>>>>
>>>>> After merging the bitmap tree, today's linux-next build (native perf)
>>>>> failed like this:
>>>>>
>>>>> In file included from /home/sfr/next/next/tools/perf/util/header.h:10,
>>>>>                  from /home/sfr/next/perf/pmu-events/pmu-events.c:3:
>>>>> /home/sfr/next/next/tools/include/linux/bitmap.h:5:10: fatal error: linux/align.h: No such file or directory
>>>>>     5 | #include <linux/align.h>
>>>>>       |          ^~~~~~~~~~~~~~~
>>>>>
>>>>> Caused by commit
>>>>>
>>>>>   ed46ac8199f0 ("bitmap: introduce generic optimized bitmap_size()")
>>>>>
>>>>> I have used the bitmap tree from next-20231018 for today.  
>>>>
>>>> Thanks, Stephen. I'll take a look and let you know when it's resolved.  
>>>
>>> So the problem is that the patch "bitmap: introduce generic optimized
>>> bitmap_size()" adds reference to the linux/align.h, which doesn't exist
>>> in tools.
>>>
>>> I removed tools part of the patch entirely, and now tools/perf, for
>>> example, builds OK for me natively. The tree doesn't touch tools at
>>> all now, except for moving BYTES_TO_BITS() from a source file to a
>>> header, which looks safe.
>>
>> Almost - see my other email.
>>
>>> Can you please try the latest bitmap-for-next?
>>
>> See above.
>>
>> My "native" is PowerPC 64 LE.
> 
> I tried arm64. Anyways, it's clear that the series is not ready yet.
> I'll drop it from bitmap_for_next. Sorry for this mess.

Sorry for that, it was working for me. I'll resubmit once the window opens.

Thanks,
Olek
