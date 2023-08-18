Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21348780502
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 06:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357801AbjHREGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 00:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357808AbjHREGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 00:06:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848DE35BF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1c4Ws4H3uSrzxn9QajBg3Bzv/na+oF8C6MFyBjfEE7sEdxdG2OZm4d8gLOg9QQczq82gnCrrEAx6OOnYO0OiIkWjwTj2YziwHAM0kRkz9V8D1XYMHYqaTcxl7SBpG9JQNp9BEh98NjtmbGPgV95ThRxcmX19/xDSMP+Ajq7eMneR+bD5OtUGVE+FvQbVPaasZf7VRWFP2qAlZsNSR+tp2U+qcS75Fr1gLsBRjibw7gDBUB7vj/r+AAA5L0RvTzEPOWEjfqU6I0mpX0GuNoOQqhBvIK637h2AMmGDaNNT8GtJUPo7LlVMpijI8zNIgirgQQ3kKAYwbKTwsyc3MH+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EystElpwwkPBhtxQE5mDtr7vgp8jqY4reUgc7xj4+r0=;
 b=aj/mNfk5wOjNpR1ZHvnDq4VTlONH91WMzTq1+gRsk46EYx7qRlUIkU0ro3NCVTw0KC+Qky4SdZruU9SyNt4obRDx7rYpUzK0bcMDN8ge22NzUi2QzzTyqsSDPGXdQRiKXOP0ibk8bovm1XlSyU+1+eXHDrA3UkcLYYwVLC6JPWp6k3SXCXa36v2m95XEH94imFR6lZ7q3zFTHga02v/x+P9kP3jowkG6GJ68KmVqYINvcH0eVrIyCKYkE8P74bE3Z9jO6Z4wVK9JD21oQun8Nwrkfm5TJeyR8MAoIDErURQEvl6i5cPMfXfbdM5cvWoqS4GRA+cg29gASVrw1RbXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EystElpwwkPBhtxQE5mDtr7vgp8jqY4reUgc7xj4+r0=;
 b=bksSa5c4LNa+/QX+DnPwvRl1siA2fwRnbrrxxF+IHPSzBvoU5xgpFwi9Lj2OPlVhffSVLebcW+140rNOuQpVTldolzS/cLcgWqqEtHF2utIo6noCQ6fJ3Zl8YTBXEuHyE+EcYLP3ksvgd5zt8ncxOYodMJ+hogilJujJ0RZRsNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 04:06:07 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6678.022; Fri, 18 Aug 2023
 04:06:07 +0000
Message-ID: <bf4407c1-890b-6a77-1e2a-d3d988f660ed@amd.com>
Date:   Fri, 18 Aug 2023 09:35:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Content-Language: en-US
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, jiangshanlai@gmail.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com
References: <20230519001709.2563-1-tj@kernel.org>
 <ZNGYxBCtaMclAl8x@slm.duckdns.org>
 <94da0dc0-a30d-33d5-b3d5-784bbd59c549@amd.com>
In-Reply-To: <94da0dc0-a30d-33d5-b3d5-784bbd59c549@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|BL1PR12MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: ca71b0af-e337-49ab-fc60-08db9fa072a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryHNLm4YKqdAqe1RkFTGdZx9gw2Eh+IDr3Akl2ignNwUBI4Fn3p939uyqULbGgX4bXrq6FAvzTJcgJxv4FpDUMhbg7IMJgtSzLMtzKlFG/nPhmcgzeaTJqThc/thhOLZpHotC10LKyFoXiD/E1CjvBXteUqlK8sabIJfO9Jxniy136HA9bXiRbVFuG+jl/m/zWVYrOmbE7WhNdodIPKHEWYTL5/VNLitN86z4HnNVFFg6j8OdLzLSJoWs+K92Sy4nnMHPcliiIbwrqN/cO4ehZjj+B+qyTQIKSCTUqXxMWZbZTm3FQK0MLze9PSPzT2HFUR0cr6eIXdSZwgPUFXxa+YUgYh9YWx2RmUPi2Logn97tBh2QYj4j2w3Mx4u/IFi6MaaTvIcVqWPUHjiUCiECFpVn1N6ioHQnm+9bFbaeJ4jZB7hHgTrXul8GySpl5APh2nXe7puDhbvqB4STHErG2YkyeySBedmJgQVsg3yV3eqD1D+fEB1mWe2haNn8iGmgH+1d1HBBqdrOAP0cz5IBrcFgT5hkt+RfCiTOv5vqeLrTEswYtqUElrw/CmoG/tmClJAli/gexLpx5IIQZvJT+a+GCgWoXrBXyT11VghtNzjnrSmNLpLj6z6qn/a01cfULu6l/iIQBv6S2nRkS3dOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(186009)(1800799009)(451199024)(36756003)(86362001)(31696002)(31686004)(6916009)(316002)(66476007)(66556008)(66946007)(478600001)(41300700001)(38100700002)(6486002)(6666004)(6512007)(6506007)(53546011)(26005)(2616005)(8676002)(4326008)(8936002)(5660300002)(7416002)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW53cDNUY1ZKTjhjRllFRjFGaDFhQVFTc0Nhd3FJQnYvZVpmQS9rV3ZhVkR1?=
 =?utf-8?B?NmFpT0prYkw3a0t0TjBsY05DdWY5ZnJmTFlhRzJreldTaXBYUlpYS2NJcklP?=
 =?utf-8?B?ekJCZ1ZSUFRUbTJVbU5pYWNrUUE4MWFubFpGR3p4NUFLRExST0JPbVRTTWhK?=
 =?utf-8?B?L1Ftc3lla2QxWGJqd1oxcWp1Q2E4bW9nb1NJNnhRNGU5OWc3Q1VvYkRDL0w5?=
 =?utf-8?B?MGQ0TXE1Uk9kZzRRMkp3eGorZG9YYzdPMEVZMUs0WFZnb2Rmb1UwQjhZSmtt?=
 =?utf-8?B?TUhKSUQwNVFBdlpWdWNwNHdEcGFOUDhEeFlSNmVKMUJSNGNuQmlSRW9oVmN1?=
 =?utf-8?B?T0Z3S21LVTF0clA4dUpmWUlWYS8wOEx4UGdPSFZwZEZwT1BibkI0SzREa3F2?=
 =?utf-8?B?RkZtdGQ1QjhhOXYySSs5VUNDcldDVXQrT1dRNUw1OUZSSldVNlAxc2M4VDQz?=
 =?utf-8?B?TG1QbWluTTQyczBpUzNJNHVCbDN1eTdwb2pUWnVWcUpnMVVuNXY0QWV1bWVT?=
 =?utf-8?B?aHBnRE1ORXVRbjNnalNnUVRodVY2M256Q20wcXlyS2s3aW8xV2RVRDlCWmk2?=
 =?utf-8?B?Tkdtam96dmdUOFpjRXU1RkNVanlMYzIvT0NGZVJTc2NBOWRTMElSVEJhR25t?=
 =?utf-8?B?Y0lBSU92eTlqTngyQ3BmdldNK3ZYSVRBQWNLbG8wcE9tSGZtL0ZLOGRZV1VH?=
 =?utf-8?B?dEdhU2taZjhBZ3RxeFBFbjFGYWpaZ0pYOTZpMk04STN5VXh6dTE0QWpTcSs0?=
 =?utf-8?B?bCs4eHJ2ajhCQnZ0YWV4RnhMVnVZSnloSDNhaHFxT0tlTFduRm5JQjJMWDQy?=
 =?utf-8?B?bXJCSFdPTFNmYkJuT0ZFRFpZaEtxL0M3eGd2S2drZmhjVGdtOStrTHdWMFZz?=
 =?utf-8?B?K3lUdndYR0tHeE1ieTMxN3paT0xQUVNBUDZ2akU1UmlVSTJxRUFNSTVVOWNO?=
 =?utf-8?B?U0Fqd2svN2hNcnRNSFNpMm1Ld0FyWjBUdkdqVG0xZW85QzRrdlU5aWp3ZU0w?=
 =?utf-8?B?bHd5enNXSno4T3Rac3RNM1BXZVZmRHZsQkFxMnVIY0lDZ2VYak1mUm9LZXc3?=
 =?utf-8?B?ak9TeGdLWGhOM2RxSmc3RUxleTVnZFF1Lzc2cko0MUVtcDRvUUNmNGtUaGVH?=
 =?utf-8?B?aVpPQ0h2a3FmeEpBUDN1Y0pCb3BqUlY4UGFiNkZFTlZvc1RvNFBmc0hvYnRF?=
 =?utf-8?B?SStFYXdjNjZXODlYUVV2bE41MGM4eVBpY2d6ajI3Ykdtb0FZU2JteXVVTTha?=
 =?utf-8?B?NTFrMHpWcWYyTm5CbEtUenN5eEV4UHdDblN5SmxtWXhQWWNEVzlvVnlZR0ZC?=
 =?utf-8?B?MjRXOVdXeFRHWkFLMExpZzA1aW5PSjM0SkVYemdJeW5RY0VHTzZ3SkF3OENn?=
 =?utf-8?B?N0s4SFRXNjQvYzNIaGxyR3JYSVNJU2hlTFlLVTZyZjA2SGhrYTBHUlA0TGVm?=
 =?utf-8?B?YUdlS2MrWCtYMTAwYmF3ajBpVTU5WHFBRlA2MEllbGRYZFZYdG04RGZVcHJj?=
 =?utf-8?B?c3NkVmJNUlhrck8zMWZIVlpBemJ1WUZRL2RQN1hPNWlRYlNBZzltZ2FYamli?=
 =?utf-8?B?M3lSQVoreUtUK1NZbzBMQlBiQ09jMk81ZDM2VjZnVEpnYkpDUHliV1NuQmdY?=
 =?utf-8?B?aS9RazRoTGtOY0lIU09wazJYZU9zSUJ6QXg2aHhQc25QTGhOZUQzOTRXUzha?=
 =?utf-8?B?dkhPQ3pyMkVMTUlseUUyVC93SUh2TGpvbnZKdHR6L2xoR2xMUlYyYnZVUThS?=
 =?utf-8?B?REtmYWtIWld6OC9VT0JpbzY1OStsYzdoczhFYzh2TlpSdnVqbkpXcFNRTTBi?=
 =?utf-8?B?VWVqN3lqSFdFRkRDdjVZQjl1ekZJSUEyTjNCQ1o5WWZXVVZta3Zvb2YvSzk2?=
 =?utf-8?B?ZVVXWENPWGdBZEw5TFJVdmZEV1ZKOU0reklmVnU5TkJXRHRpUytJdDY3U0Fr?=
 =?utf-8?B?elM4ckJLbTBiSlF4Z3IxMW1ZNFA4dGhrdW1UV2Zsd3JEMnVMTnhPK1NyMTMy?=
 =?utf-8?B?b3RpZHdKNk1WUkFZdnB0eTVrQXhsQXJjMWNJQW11N0RGODNuaDl2MkJkQUg5?=
 =?utf-8?B?bnhSTDhWaDI3RWhBQmZsYnN0OUxZRmFYODJQU3RsYlRjSnc3MTl0bEovc0tQ?=
 =?utf-8?Q?RWwapyZ0yLwFBto1XQEl6oc3+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca71b0af-e337-49ab-fc60-08db9fa072a4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 04:06:07.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sb1dGHME0pzolwGOHrVIe1oMn05BL+LnlleNjaQHkndmgJZ2hTBuuhsfHQeYR1mztJsJrswX1+nZw0OrjyI4rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 8/8/2023 8:28 AM, K Prateek Nayak wrote:
> Hello Tejun,
> 
> On 8/8/2023 6:52 AM, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, May 18, 2023 at 02:16:45PM -1000, Tejun Heo wrote:
>>> Unbound workqueues used to spray work items inside each NUMA node, which
>>> isn't great on CPUs w/ multiple L3 caches. This patchset implements
>>> mechanisms to improve and configure execution locality.
>>
>> The patchset shows minor perf improvements for some but more importantly
>> gives users more control over worker placement which helps working around
>> some of the recently reported performance regressions. Prateek reported
>> concerning regressions with tbench but I couldn't reproduce it and can't see
>> how tbench would be affected at all given the benchmark doesn't involve
>> workqueue operations in any noticeable way.
>>
>> Assuming that the tbench difference was a testing artifact, I'm applying the
>> patchset to wq/for-6.6 so that it can receive wider testing. Prateek, I'd
>> really appreciate if you could repeat the test and see whether the
>> difference persists.
> 
> Sure. I'll retest with for-6.6 branch. Will post the results here once the
> tests are done. I'll repeat the same - test with the defaults and the ones
> that show any difference in results, I'll rerun them with various affinity
> scopes.

Sorry I'm lagging on the test queue but following are the results of the
standard benchmarks running on a dual socket 3rd Generation EPYC system
(2 x 64C/128T)

tl;dr

- No noticeable difference in performance.
- The netperf and tbench regression are gone now and the base numbers too
  are much higher than before (sorry for the false alarm!)

Following are the results:

base:	affinity-scopes-v2 branch at commit 18c8ae813156 ("workqueue:
	Disable per-cpu CPU hog detection when wq_cpu_intensive_thresh_us
	is 0")

affinity-scope:	affinity-scopes-v2 branch at commit a4da9f618d3e
	("workqueue: Add "Affinity Scopes and Performance" section to]
	documentation")

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:          base[pct imp](CV)    affinity-scope[pct imp](CV)
 1-groups     1.00 [ -0.00]( 1.76)     0.99 [  0.56]( 3.02)
 2-groups     1.00 [ -0.00]( 1.52)     1.01 [ -0.94]( 2.36)
 4-groups     1.00 [ -0.00]( 1.49)     1.02 [ -2.20]( 1.91)
 8-groups     1.00 [ -0.00]( 1.12)     1.00 [ -0.00]( 0.93)
16-groups     1.00 [ -0.00]( 3.64)     1.01 [ -0.87]( 2.66)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:  base[pct imp](CV)    affinity-scope[pct imp](CV)
    1     1.00 [  0.00]( 0.47)     1.00 [ -0.21]( 1.03)
    2     1.00 [  0.00]( 0.10)     1.00 [  0.00]( 0.45)
    4     1.00 [  0.00]( 1.60)     1.00 [ -0.18]( 0.83)
    8     1.00 [  0.00]( 0.13)     1.00 [ -0.26]( 0.59)
   16     1.00 [  0.00]( 1.69)     1.02 [  2.05]( 1.08)
   32     1.00 [  0.00]( 0.35)     1.00 [ -0.36]( 2.47)
   64     1.00 [  0.00]( 0.43)     1.00 [  0.45]( 2.54)
  128     1.00 [  0.00]( 0.31)     0.99 [ -0.82]( 0.58)
  256     1.00 [  0.00]( 1.81)     0.98 [ -1.84]( 1.80)
  512     1.00 [  0.00]( 0.54)     1.00 [  0.04]( 0.06)
 1024     1.00 [  0.00]( 0.13)     1.01 [  1.01]( 0.42)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:     base[pct imp](CV)    affinity-scope[pct imp](CV)
 Copy     1.00 [  0.00]( 6.45)     1.03 [  2.50]( 5.75)
Scale     1.00 [  0.00]( 6.21)     1.03 [  3.36]( 0.75)
  Add     1.00 [  0.00]( 6.10)     1.04 [  4.23]( 1.81)
Triad     1.00 [  0.00]( 7.24)     1.03 [  3.49]( 3.41)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:     base[pct imp](CV)    affinity-scope[pct imp](CV)
 Copy     1.00 [  0.00]( 1.98)     1.00 [  0.40]( 2.57)
Scale     1.00 [  0.00]( 4.88)     1.00 [ -0.07]( 5.11)
  Add     1.00 [  0.00]( 4.60)     1.00 [  0.23]( 5.21)
Triad     1.00 [  0.00]( 6.21)     1.03 [  2.85]( 2.55)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:       base[pct imp](CV)    affinity-scope[pct imp](CV)
 1-clients     1.00 [  0.00]( 1.84)     1.01 [  0.99]( 0.72)
 2-clients     1.00 [  0.00]( 0.64)     1.01 [  0.53]( 0.77)
 4-clients     1.00 [  0.00]( 0.75)     1.01 [  0.54]( 0.96)
 8-clients     1.00 [  0.00]( 0.83)     1.00 [ -0.21]( 1.03)
16-clients     1.00 [  0.00]( 0.75)     1.00 [  0.31]( 0.81)
32-clients     1.00 [  0.00]( 0.82)     1.00 [  0.12]( 1.57)
64-clients     1.00 [  0.00]( 2.30)     1.00 [ -0.28]( 2.39)
128-clients     1.00 [  0.00]( 2.54)     0.99 [ -1.01]( 2.61)
256-clients     1.00 [  0.00]( 4.37)     1.01 [  1.23]( 2.69)
512-clients     1.00 [  0.00](48.73)     1.01 [  0.99](46.07)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: base[pct imp](CV)    affinity-scope[pct imp](CV)
  1     1.00 [ -0.00]( 2.28)     1.00 [ -0.00]( 2.28)
  2     1.00 [ -0.00]( 8.55)     0.96 [  4.00]( 4.17)
  4     1.00 [ -0.00]( 3.81)     0.94 [  6.45]( 8.78)
  8     1.00 [ -0.00]( 2.78)     0.97 [  2.78]( 4.81)
 16     1.00 [ -0.00]( 1.22)     0.96 [  4.26]( 1.27)
 32     1.00 [ -0.00]( 2.02)     0.97 [  2.63]( 3.99)
 64     1.00 [ -0.00]( 5.65)     0.99 [  0.62]( 1.65)
128     1.00 [ -0.00]( 5.17)     0.98 [  1.91]( 8.12)
256     1.00 [ -0.00](10.79)     1.07 [ -6.82]( 7.18)
512     1.00 [ -0.00]( 1.24)     0.99 [  0.54]( 1.37)



==================================================================
Test          : Unixbench
Units         : Various, Througput
Interpretation: Higher is better
Statistic     : AMean, Hmean (Specified)
==================================================================
               	 			base                affinity-scope
Hmean     unixbench-dhry2reg-1      40947261.77 (   0.00%)    41078213.81 (   0.32%)
Hmean     unixbench-dhry2reg-512  6243140251.68 (   0.00%)  6240938691.75 (  -0.04%)
Amean     unixbench-syscall-1        2932806.37 (   0.00%)     2871035.50 *   2.11%*
Amean     unixbench-syscall-512      7689448.00 (   0.00%)     8406697.27 *   9.33%*
Hmean     unixbench-pipe-1    	     2577667.42 (   0.00%)     2497979.59 *  -3.09%*
Hmean     unixbench-pipe-512	   363366036.45 (   0.00%)   356991588.20 *  -1.75%*
Hmean     unixbench-spawn-1             4446.97 (   0.00%)        4760.91 *   7.06%*
Hmean     unixbench-spawn-512          68983.49 (   0.00%)       68464.78 *  -0.75%*
Hmean     unixbench-execl-1             3894.20 (   0.00%)        3857.78 (  -0.94%)
Hmean     unixbench-execl-512          12716.76 (   0.00%)       13067.63 (   2.76%)


==================================================================
Test          : tbench (Various Affinity Scopes)
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:   base[pct imp](CV)         cpu[pct imp](CV)         smt[pct imp](CV)       cache[pct imp](CV)        numa[pct imp](CV)      system[pct imp](CV)
    1     1.00 [  0.00]( 0.47)     1.00 [  0.11]( 0.95)     1.00 [  0.23]( 1.97)     1.01 [  1.01]( 0.29)     1.00 [  0.07]( 0.57)     1.01 [  1.36]( 0.36)
    2     1.00 [  0.00]( 0.10)     1.01 [  1.14]( 0.27)     0.99 [ -0.84]( 0.51)     1.01 [  1.05]( 0.50)     1.00 [  0.24]( 0.75)     1.00 [ -0.29]( 1.22)
    4     1.00 [  0.00]( 1.60)     1.02 [  2.07]( 1.42)     1.02 [  1.65]( 0.46)     1.02 [  2.45]( 0.83)     1.00 [  0.36]( 1.33)     1.02 [  2.37]( 0.57)
    8     1.00 [  0.00]( 0.13)     1.00 [ -0.02]( 0.61)     1.00 [  0.14]( 0.57)     1.01 [  0.88]( 0.33)     1.00 [ -0.26]( 0.30)     1.01 [  0.90]( 1.48)
   16     1.00 [  0.00]( 1.69)     1.03 [  3.10]( 0.69)     1.04 [  3.66]( 1.36)     1.02 [  2.36]( 0.62)     1.02 [  1.61]( 1.63)     1.04 [  3.77]( 1.00)
   32     1.00 [  0.00]( 0.35)     0.97 [ -3.49]( 0.62)     0.97 [ -3.21]( 0.77)     1.00 [ -0.24]( 3.77)     0.96 [ -4.08]( 4.43)     0.97 [ -2.81]( 3.50)
   64     1.00 [  0.00]( 0.43)     1.00 [  0.20]( 1.66)     0.99 [ -0.61]( 0.81)     1.03 [  2.87]( 0.55)     1.02 [  2.16]( 2.31)     0.98 [ -2.32]( 3.63)
  128     1.00 [  0.00]( 0.31)     1.01 [  1.44]( 1.33)     1.01 [  0.72]( 0.46)     1.01 [  1.33]( 0.67)     1.00 [  0.38]( 0.58)     1.01 [  1.44]( 1.35)
  256     1.00 [  0.00]( 1.81)     0.98 [ -2.10]( 1.05)     0.97 [ -2.50]( 0.42)     0.97 [ -3.46]( 0.91)     0.99 [ -0.79]( 0.85)     0.96 [ -3.83]( 0.29)
  512     1.00 [  0.00]( 0.54)     1.00 [  0.37]( 1.12)     0.99 [ -1.33]( 0.44)     1.00 [ -0.19]( 0.94)     1.01 [  0.87]( 1.05)     0.99 [ -1.08]( 0.12)
 1024     1.00 [  0.00]( 0.13)     1.01 [  1.10]( 0.49)     1.00 [  0.47]( 0.28)     1.00 [  0.33]( 0.73)     1.00 [  0.48]( 0.69)     1.00 [  0.01]( 0.47)

==================================================================

ycsb-mongodb and DeathStarBench do not see any difference in
performance. I'll go and test more NPS modes / more machines.
Meanwhile, please feel free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

--
Thanks and Regards,
Prateek
