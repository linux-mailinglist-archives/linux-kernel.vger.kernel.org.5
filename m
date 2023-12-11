Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE28480CC05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344258AbjLKN4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbjLKNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:55:40 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC67C30E6;
        Mon, 11 Dec 2023 05:54:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIvHgVHxUSKDPmHnncLdJW7KyyrNJ0JFZDQurWpZ1LF+K1k2UW5UUTClnDnbpn6HT2iYG8I/I/tDau2Yvz98CcdSbg8B/gNTbt6IWvGxwqQoxUUuqtIsQzB0p1RpqRwmmo3gHQFHcSdJEmvZtpv5p6INovcLSdcDxJAe4Ayuk5252sJn2a2x+Yt4zJq03MK3Le1sTjKGy3rBR/TVEmfU4knkLZgPYzMf+EGfIUidhndc64Usp3W8kOyNqyjIvBleqOV0NEVgGJJjM4dmB6CekdopclsuG9sjMjawNkRMWjvVw6rAoqOtTVV12Z3oW8de9fej6T7kHJYtNLyaXlroYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHnCCUTB3LiD3ByAr7QSgwIZN+0XfA9kbG/Z8zsjpBQ=;
 b=MKi7DyqOuituthG13FG1AkMzviQ13xkOxhYJLoBRX64QNeyGre13S8nhv5BWCjWRiH1mi2x+gSpU2HYy04XblPT7nt5P7kIJs9ZmXOfr5UIYQPj0KjWawqSlaS7TkR/jiE/TQwqVtwAxiOKwRz7SheuAfk4gEZThVvXc9cS9MpRLsG+eVax0eiNC5R6Hy0BVIFvdgWrT3Eb/9Qa4izItHbVJaPW/GC5MX7ZtS5o5V4ckHJ8v9b1OgI758qAORjIoCx/tODpnWhAsuyH4do0f0FpT8bEzbgh1L3dXTSfj0LWo3n/ZBAmtOCGJLSzhDosSMxT6xJeJc/wbWiHIW5qs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHnCCUTB3LiD3ByAr7QSgwIZN+0XfA9kbG/Z8zsjpBQ=;
 b=sol71tJLWAOknjGaXQxoLlxhv7Qoi/g70FCijlGrW2hstEAN7sFqg2f/bghGqJ77ykVw+sCRbHh5OKhLwnJnRKasueT0VGw8oLNYvLnXRNnwK9pFxBJmqEdaImbx/tHEFU/Z5KuU67ETNzv/n6WYPDfB3flcZWX7GkTg3T6KW8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:53:58 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:53:58 +0000
Message-ID: <53374e41-d1e0-aa8f-d001-5e89783b962c@amd.com>
Date:   Mon, 11 Dec 2023 19:23:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] perf tool AMD: Use non-precise cycles as default
 event on certain Zen2 processors
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     acme@kernel.org, kim.phillips@amd.com, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, changbin.du@huawei.com,
        yangjihong1@huawei.com, zwisler@chromium.org,
        wangming01@loongson.cn, chenhuacai@kernel.org,
        kprateek.nayak@amd.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20231107083331.901-1-ravi.bangoria@amd.com>
 <CAM9d7cgs9Wk0OFoea4jOote-drHjvCimJyt7GWdO2Giw=d7Jog@mail.gmail.com>
 <f42bf6b7-75b8-124b-c79e-ad7a9b706990@amd.com>
 <CAM9d7cijrZzp=5m+BcQ77WFOSHT7e5vO-RCUTUp5Pevmz2wbtg@mail.gmail.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cijrZzp=5m+BcQ77WFOSHT7e5vO-RCUTUp5Pevmz2wbtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0204.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 33805fe3-769d-45cd-540e-08dbfa509f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0IB769P2PqoHs179T6inn/Do7URX1m0Fq9Shj22JIn92UJKyajKepLOQZ8dHoZxrUlIyIUxIdxepFjSzE40lKUoYE4YQZavXiXwd8whVx+5al/WqdE7w/WFBisR6dVqyUJj/eq6LzfgDAjp6pCGu3El134HfK93cwiOgvurnC3X+GFYZOM4R7Ut36v3Iqxq9K+nSiqZOcPuADlDGVHxB/GhomlUUQot/07fz0W9HH1ZVHdi1Yjv9F+/NwBO6gxyaWYy+CfJlOrXa7CMZkJlBL/iEAnIchPk8P/1+aqwzMVAYrXiBsRaksTz+lFJlrDarE2DBp/zJ2YwhfON4Rwl6bV0wV5dUadV1EZQUtZKCt74g43LOkzqAg1CYzAfLOzF2sxqxngzdPXl+JO7mIHX9HeH1nsUtNOgKZJkpRY2nPt9SSkXgGPRZbIZP+SKWpGua9gTcjMw3gYl2tXHugHAVGj6z+X2BmqqpAz7jG2wU0ZP1mkE7yqJPEhvN7XLSbK1eR05W4WBP8cc4Bq9aLuNZNq0isiJcZVbmePpPuoIDxyClY1yZZ5esrmdTLHy4mRjKOgSeWECcmCz2E9RelyJEwIXYJlL1LVS+Ko+lthDb53lqb2r622/2tFVQrXjEDZFUG/ARnVl/gdSvRAQfTrV5Cluf1G7C955eevCzDgBXTxD2dlwk+zyBYqnvxy66jC7f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(6512007)(2616005)(26005)(6486002)(478600001)(6666004)(6506007)(41300700001)(7416002)(83380400001)(5660300002)(44832011)(2906002)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(8676002)(8936002)(38100700002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFREMG4rR20wUytIMVdCazJ6TGRRdTU2YTVSUithR0x1SmVjN09ON1ZWczhw?=
 =?utf-8?B?eHJuVUwwWmxGZktkVURmQUxaalloTm1QVHNKQUR3Z3d5NVhtVUQzMWRmNVVU?=
 =?utf-8?B?THhxWDZZYTRFTm11WVJ5a3poVXpRcHRGY2pTc1JVWmlzWVBBNXhxQ1ZxOVVV?=
 =?utf-8?B?aEZiaU91UnVZaG4wRklQelNtME02ZlVoRG1NYTd2QStHMUtWc1ZtTHljQ2VV?=
 =?utf-8?B?NjZNU3J1TC9UZTJKRjR2M2tTR0tmTnVtbjJmNG4xcVZoVXY5a3lsM2JOTktZ?=
 =?utf-8?B?eWNHdG9tYUc3N2lMQjY1Z08zZG40YnliOHVRWm5KeU5pSTQvNXdqUG5rejJl?=
 =?utf-8?B?cXRNT1FPVzE5VnBXOU1vRnNva2tydE9hRG1NaUNLVVNOMCt3SyswK3lCbFVT?=
 =?utf-8?B?RWFYeWxSeXFJanR1RVV5WmE3NHJ1RndYdFA4anhmOFU4RlhKVkMveFoyK1Mv?=
 =?utf-8?B?aEEzSnE4eWFzb0Fia2I0TUR4SmMyMWJvSm80L0hCdFBhZyt0dFdqOUcyZ3dK?=
 =?utf-8?B?RmVQOXBWUlgrdkdtL1ZDM0RzdmxoQVduSGJjSzZaLzArSy96VEdwT0pZbkJD?=
 =?utf-8?B?eUdJeW9xZnNWU1VHMkFRYWt3c1RvRHkrTWlUMlBXYW1xTndCTkR3VW9uRi9o?=
 =?utf-8?B?NmdjZitRVkNCZFNyeml1MjB2d0NVZnBKL1dGWHMxM1VRYkg1YmZtTU5LWU1W?=
 =?utf-8?B?QVlUMmZwK2doY2UwazQyeHBlN3k3a0RTbTIxZ3BzVlBDUTdNeEgwcDdybGEy?=
 =?utf-8?B?QS8yVjdxNElUWXB6R0M2QVlsZlljNmVJaVlUa3RzbzlpeUJJZlhtQnAvSkNE?=
 =?utf-8?B?ZGtjN3FicmxweFdTMmozMXgzaTdqS21jZ0dEZGh1SHpDMGU1UUk1Q1JUaU56?=
 =?utf-8?B?Y1A0VzBFUDVIazNjSzFlRWV1ZzF4MFN0UmNhL3FtN1VTVVppbEhsOXZtZGxN?=
 =?utf-8?B?QnFkbHAxTDZhcXpNblhOdE9aZVJ5QnRXb1FEQ1VDYjdUVVFqSDJCblJpYnND?=
 =?utf-8?B?aElCVFYxT0F6ajk4Y0tMWDFKTm1EVUIxc1V2YkNYMFRQcW9UTG42UWg5QTFR?=
 =?utf-8?B?c0tab0YvMkhveXlOdWNPYi83aFU3WERUMzhKTFlONmwzdTZJWjFBVHFrbXpI?=
 =?utf-8?B?QXBUWnRJaDBpRkxMV20xbkxGRFZqS2FmQ1NMK09VWVdVU0tOL2h6SU13K3Y4?=
 =?utf-8?B?bmE4QzJNZW5lZmdUL3J6b0RRMEhsRUtjem9GM2I0cXdLdlhMenFVSmxaQkR4?=
 =?utf-8?B?d0p2dXcxSjdHSmMxbWtCTUdBdVlrbVpEOGVOZEZKMHdIQlYwUzg5WHc0WXly?=
 =?utf-8?B?TG9sWjF4VVpQRnluUWdNK2hDTFl3SGVFNHo2bTlYM3M2TDJtVEZYZWlwR2pO?=
 =?utf-8?B?QmpWc0F6aDlrdzZTalA5N3dzejJLS1pHM01RS2ZPallFOG9wbG4vSXJhQ3FP?=
 =?utf-8?B?U1BLNVovdElDQVY4c21rNEZSNVI4VzM1Rk9HOTNtQmlxcFk4VUliUm1BcGRH?=
 =?utf-8?B?dTM3cUlwdGcxNTJvQWhyeGVPeDRZTVFyQlFZN1I2WGJ2MlBURDdQdGUwbzJw?=
 =?utf-8?B?UklkdEgrZ21LVDY1c1c4cWhuQStIb1VVQ1k0TDJGb0VDTWkrUWNET1lXK0Ey?=
 =?utf-8?B?S2pBUDVzR2pOQUI3QWVONW9KcTNQRGNoblJlTTlPUTVjRS9YTVBvU1hVLzYz?=
 =?utf-8?B?NVROTWw1b0c3WkpmK0ZTS1hVYnJPMmFyRXlGSmJEczJPS1lna0VzQkVGYnhy?=
 =?utf-8?B?TjR4Zm1zVm1Pcitxd0VvRFRRMDdkNExhRmFwMVVrT21xczVxQ29BRjJtdGFm?=
 =?utf-8?B?dGhzVk1xbFRqdnhOeGw3TkxmdnhQNG41a3JEbFJ5My8rUWljSkw4UDRxMkNN?=
 =?utf-8?B?N1M2dGxiNUVabmJhWHN3UWx3Vm41NjZNWHNIN29sLzYrMzVpdG5GRXozeElt?=
 =?utf-8?B?eTZkTjU2dGIwWDNmYUVMNko4VEc3RzFZbjZhTzFHeGoxYlFzTWorZ2JNZ3R6?=
 =?utf-8?B?Rmlhd2x2UTBiTXA0LzQvT2hWNUNaMVJ2UnNiVFc3dk1zMzJGWk1mR2ZvcUtt?=
 =?utf-8?B?MlJXS1RzS0JSUnhBYmRlK211KzJwSURpbERYek9DK0Zlb2xkckx4SEQvQSsx?=
 =?utf-8?Q?GrhsjjdQQpJwYcjGe09D8//RT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33805fe3-769d-45cd-540e-08dbfa509f34
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:53:58.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQ837/kM5ggKRzOczbynkKxSWuQZpEZUq7uk5o0wPQUidwGpudAfDBL3/DH4cOYCOXtfDVKKZK1IJXRXq1ljUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

>>>> By default, Perf uses precise cycles event when no explicit event is
>>>> specified by user. Precise cycles event is forwarded to ibs_op// pmu
>>>> on AMD. However, IBS has hw issue on certain Zen2 processors where
>>>> it might raise NMI without sample_valid bit set, which causes Unknown
>>>> NMI warnings. (Erratum #1215: IBS (Instruction Based Sampling) Counter
>>>> Valid Value May be Incorrect After Exit From Core C6 (CC6) State.) So,
>>>> use non-precise cycles as default event on affected processors.
>>>
>>> It seems like a kernel issue, do we have a kernel patch not to forward
>>> precise cycles or instructions events to IBS on the affected CPUs?
>>
>> I'm not sure how it's a kernel issue. User can use ibs_op// pmu directly
>> and might hit the hw bug.
> 
> Sorry for the late reply.  I know it's the user's fault when using ibs_op//
> directly but I think the kernel should not forward cycles:pp to IBS.

For all AMD zen uarchs, cycles:p is same as ibs_op// (man perf-list has
more detail). It's confusing if ibs_op// works but cycles:p fails on the
same machine.

No strong opinion though. I can prepare a kernel patch, if you want.

Thanks,
Ravi
