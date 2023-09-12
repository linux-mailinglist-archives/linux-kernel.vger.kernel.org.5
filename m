Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A8079CB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjILJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjILJMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:12:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B827C171D;
        Tue, 12 Sep 2023 02:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6ZWU1dL+rl78FwBI/g25ARzqw7u5X6VRpovpgb8VsaCs/6YFSUD0UQh2AmSPiIP9ppSSpLoYIFrLJh925Gy4By//kO/TNJcvW2Hj47d7lqsQMgD7U5kRhlnyRo5Q9fQ9896JCJ8nDG4lvsWLgGS4kP2FgynLLJIlzKijwHP4kGEA9w62UC+3CYPKZAPX+Udqdr1iADsycz0xwGCAGPyrYc8VeMZwO0ZwTkUcVa4S7882oXgz2h8fF67I2A8RhuRypNYFc9Rx3kI2ZLXWUwMhgEUkplXhulWJi+hs8/QxYAWBeRq1DVzptO0v0trY5jZB7GbPkIE1HzDXFWa//OVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhDnZdHSVRun1hGRfsWHAhA8knhJ1aj6LFg0xsQ8LsA=;
 b=kAVTezuiK+3YelB+ClbEJq8B62BQeVb9Gn15JNDBGehCIKg/PDda+T3gKyfg/1WoTjzJtOBO1mOJmn05d3XUQ/0CGYjSHJ834xtYNGCtM7J91xUeuiNzW7iOhxZwIQk1W0bOjy2zgpCY0zFqfTcGWI6F7XuAmXenaL9r1Kamx+IsucIW41HVn86oI79MzQ5etEg84vLSz1vvAlZJCnJl6t7aXejBaxRgMQqMfDdQwcyCa1++GbeHLDUPaoNTRMTUFZnkiEo1maksvNcHYRgiuXEEW9V/7QVr49sW0oWW6/W8avT6mkseCrSjd9/v4MbXVvJveVJX+1dziSVHQT1YOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhDnZdHSVRun1hGRfsWHAhA8knhJ1aj6LFg0xsQ8LsA=;
 b=4gpyj9BYhdKxB8IfAQMacekfdi1qbEgwQNM3Hu6uXbK5TB1/pyo6X/v2UKP95tN9k0N+Kp7b9MpKAQgoLFWye/3oc56PM5drWc6J3b8QfLOxrkSTDgg16LFVg1JQCvVea0qJ8MTMUFIvrLasweTKeRC67Uc72ph6E1y2KLYVuMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 09:12:14 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a4ed:10a6:876a:10d7]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a4ed:10a6:876a:10d7%3]) with mapi id 15.20.6745.035; Tue, 12 Sep 2023
 09:12:14 +0000
Message-ID: <453bd95c-932d-c60a-bd7b-96f87bc7779a@amd.com>
Date:   Tue, 12 Sep 2023 14:41:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 0/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Yang Jihong <yangjihong1@huawei.com>, acme@kernel.org
References: <20230904023340.12707-1-yangjihong1@huawei.com>
Content-Language: en-US
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230904023340.12707-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::33) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 30642c5e-42f5-4750-e9bd-08dbb3705a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gC3872es1baflGYLCgL9YnOJHrFX5Otf6pXh5z8xq5j+R3omt7CVuv3cb/DCFX1OwQI3SZO/Rn4uGiJsaAXhnQqexvEFDLJBDQ0//JckplGq7n7PNfBpaetUoRub1iqqY+SXOV2Syly3KbTJY0fW8t1NidACv3mmwTPg6M4CE5QuLFU7+yrJgAvEwuF+BhMIPrSP6SInEuRQ3HWJMKNKO/F58wHJZcGuFF6JgoJuCAYMPRUEJ6gJXfteR7iYGlsWob+PE/OFu/IlFDT+LLHP3RN55PV7hMkgkQKECl2wrai53jwj/WZrd5kxSoYOVhalTKesx2OhWhRG/H9qGKf04WOedHFmolDqZs39CXiNNSZ8gzkiH5yUus9crPae24i6UByUINp+pl99B3/EIKu5LhFVOvCPuD7EWETYUVeNp4+dOFQQt3CRISTCmixeacXd9ZNfe5kkkl/Q+ex+zX+GS4U52GVCfaJEbV9bH2iMhufJQIc42ztjY0oTxH8KUW9yWGsQHs/1j9IvcjdMH8hT5DPrLhp20TNFKhyH5Mu60aAWpMHtqSbDZNGr2ki79nX/8oQLM51Ypj4bYqlmCr4WXbOduleRYNWi5G0CusdM6DyHNMTHcJiRSlTj8+zycJJV6dHP2ICj+oVqiKlmVBbXMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(1800799009)(451199024)(186009)(6666004)(6512007)(53546011)(6506007)(6486002)(2616005)(26005)(86362001)(2906002)(38100700002)(7416002)(44832011)(8676002)(8936002)(4326008)(5660300002)(31696002)(41300700001)(36756003)(66946007)(66476007)(316002)(66556008)(478600001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDdpK29kRkloUkR2blk2M3QxamNqMDcwZDlmeWVtVkJHRCtGdjN0V3luTjFh?=
 =?utf-8?B?THVyYk5PNnVaZWpjRlVUQlNQNVE3U2MzSnM0aXpDY1FZYVN4TTM4SUZ0N1N2?=
 =?utf-8?B?SGNmQmRnRHF1SHlGTlFTYjIrV3pjY0V3UXo0Njd0Nmo3bzNsa2xwcjVQVm9V?=
 =?utf-8?B?YjlKZ2U2aHJjSGFzMjRta3FmVjQzbHRIMWQ1WlpqN0RzUkhNdnFSK1YxRnN1?=
 =?utf-8?B?cUt6bXRDMFh1aHJ0bGNHZU9JY0hUdWdIVkhxTEJtaTVPdW5KWk1TY0lNdXk1?=
 =?utf-8?B?Z1EwSHArQ2N3UGNpcVAwVlZQSGxJbTVqNGxIRUErUU93M3Y1ZWpobU9BTlZC?=
 =?utf-8?B?NTJIUWlUMlBBVTdSNEhuV05DY1pqMUQ3eksrQkZ2MWxKcDhsTTNnNjlmcloy?=
 =?utf-8?B?Yi9DSkhiMk9yUSt1TUdVL21OMlBkQzZRY01HbUJUMy9WWDBwRWNVd21uYm5K?=
 =?utf-8?B?cXB1elhyUWV6OXQ4bXdzV3NZSVZLaDN0TVJKeDBYMVR1M1c0aDM2N2VUUDRw?=
 =?utf-8?B?Z01zMjhoTEJsdWUxeVFYSngwZGxZOG1RYWxOYjkrTmRXRlZwT0RLS1YxN01m?=
 =?utf-8?B?dG41bUx1S2pVaDc1aXVYSkdGQ1NMMDBZWEJQOG1HVzRtUFduUzFKRVM1MjNG?=
 =?utf-8?B?QUlmQU1sb2MvRUtQQjhqOVpJbGhpTUdqdWJON1JBeWxQVmpkU3FQV2UrNlox?=
 =?utf-8?B?MHFLckZxQUtJenhZRXN4aFBaYXJJem9yNmV6bG4zVklML2p3TzBmYWVoNzIz?=
 =?utf-8?B?dWR1R2JPa2FxODQ0aTZXclgvWjZqakxDSTI2bXNjQk10cVBMaTRqalVuaVhR?=
 =?utf-8?B?MzZUTkJFYm5SR2s3b2JQeHpFWW8xWElzWjNjalhrVW1RQ3pjYU9ncTJwWUJn?=
 =?utf-8?B?a2loaXBkR3VOSU1XWE1LZHVHblgxaE1EOGhqME1GU3djNFZOWlB0dDk4bzEx?=
 =?utf-8?B?U211cE9SVlBWNTVTczdacE4yQ3N2eTkzbXFvcTYzQmNSV3lmb0lyWWVIRWE2?=
 =?utf-8?B?UFY2K1dFNnNWYlF1cVMxbXg5bUxSRzZJTi9NZkhERkdMbTNUVzFRaGJLNHdW?=
 =?utf-8?B?MnRyd0tLRlFWOURNMmljUy9IVytpVE9uTXJvNHR1by9ZUG1GQ2h6d1NSejFE?=
 =?utf-8?B?T0RoOXcycjNGSXQxbzYxcmNTdjBoSDFxaW4ycE1rVUdqbnl2dmtWSnFLbk44?=
 =?utf-8?B?Mm81TSs0NUlteFM4UGNEMkRKZ3dKbmlHbVRyVnRwZkhwdW5ELy9tQzV6L0Nz?=
 =?utf-8?B?dTZiL20wSHM2aFpiTXQxRFJySTc0aHNScGptV05nS3ZQNzJWT24rL3E3Ui81?=
 =?utf-8?B?WWp4TDZ1YWpxRk1pZU9URVNzNjV3UHNHbmJCcCtOUTlhR0hhNUZxVmd3bXZH?=
 =?utf-8?B?QVgyVXUzUDlCQk5YR3NBeVplQURIcWIxV2xBaEZ3bkVCNFJRaDdQWEtGTGEr?=
 =?utf-8?B?VTBVNEVlUGJQQ012R3JPVmlRZGVzK1Q3NFJxajZrT1Y2ZkZMaytvNXp6cC9y?=
 =?utf-8?B?SmtoUGRzRW5QSktEWm9Va0E4YVo2aHB5Y0dUM0RPNEgwbk9UN3hySU1WRE5M?=
 =?utf-8?B?VXg1RG5tbHVMa083ZU1mT1VrOXVRODBKRWVvdGpoNVVXVExIL1hoc0pNeVdQ?=
 =?utf-8?B?QW05OE1mTTNaN2pZSGNlZ1I1S3prVkgydVU1NzAwbmp1cnZqRXhtU0pHNFBw?=
 =?utf-8?B?aW1QOHlBeHdjWHBNSklCdE9hbk9kQ1JMOUY0WFE5a1NscTlaQ0U5czQ5aWZv?=
 =?utf-8?B?YXlVV0IydnJ2bnpVN3RSVGtpZGFtaFBwTjZ6elZGeER3SjM5YVdFSDR6bEJj?=
 =?utf-8?B?WXFTUmxkenlVU1BIWkIxOWEwOFA1a3psMXpibkFldUowRG10WHdCS1dYWmxt?=
 =?utf-8?B?bzFhby8rQW1SNFh6dTFkZEZyY0FXUFFmbk5TV2UrVVdvUzUxQjQ5Myt3WUVu?=
 =?utf-8?B?K2N2TUwzUUtBcTIwaVArbzBtck1MOElGRGFxZnpuVS9LY09sdHQ2alJmVGJi?=
 =?utf-8?B?czV6NVQ1b1BUUE9UcWR2bnBia1VQZzlocHYzS0dmMitmV3NkQnRFeDRLOVJn?=
 =?utf-8?B?TDA4NkVCbHlKbkxXRXhtNTJRRmVqdjFJeVVoWjdCcHFBMWhxRUFwQXhLTlg1?=
 =?utf-8?Q?ty2RPVKFz4h+lEF9i4AwwCFDn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30642c5e-42f5-4750-e9bd-08dbb3705a72
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:12:14.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgzjKlA6dEbtxt9pAisVuncnl/Z+Gq9bycc4Ps5RWVCAcJUM4050QuO6COt86jD3UZCrMtWP6GBR+qChL0HTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-Sep-23 8:03 AM, Yang Jihong wrote:
> User space tasks can migrate between CPUs, track sideband events for all
> CPUs.
> 
> The specific scenarios are as follows:
> 
>          CPU0                                 CPU1
>   perf record -C 0 start
>                               taskA starts to be created and executed
>                                 -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>                                    events only deliver to CPU1
>                               ......
>                                 |
>                           migrate to CPU0
>                                 |
>   Running on CPU0    <----------/
>   ...
> 
>   perf record -C 0 stop
> 
> Now perf samples the PC of taskA. However, perf does not record the
> PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
> Therefore, the comm and symbols of taskA cannot be parsed.
> 
> The sys_perf_event_open invoked is as follows:
> 
>   # perf --debug verbose=3 record -e cpu-clock -C 1 true
>   <SNIP>
>   Opening: cpu-clock
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>   Opening: dummy:u
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0x9 (PERF_COUNT_SW_DUMMY)
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID|LOST
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     mmap                             1
>     comm                             1
>     task                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>   sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>   sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>   sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>   sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>   <SNIP>
> 
> Changes since_v7:
>  - The condition for requiring system_wide sideband is changed to
>    "as long as a non-dummy event exists" (patch4).
>  - Modify the corresponding test case to record only dummy event (patch6).
>  - Thanks to tested-by tag from Ravi, but because the solution is modified,
>    the tested-by tag of Ravi is not added to this version.

I've re-tested v8 with my simple test.

Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
