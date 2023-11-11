Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C7A7E8CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 21:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjKKUyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 15:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKKUym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 15:54:42 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9DC1718;
        Sat, 11 Nov 2023 12:54:39 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3ABIwgCF004764;
        Sat, 11 Nov 2023 12:54:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ordwmaGaN94s7qDEMrl0I5rc3d4XfczvqDf1X9OPSJ0=;
 b=ZGzgFAQeq7G7+c7vhTI/log9H0YeFZUf3k42datoDUSnEUMbKqsWdONW8Kz+ZkSvbANH
 x2hlT9cpprGskzutubd0DDWQz7wn0o2AIYek1246ir1KIroH/SCOJiLgwYiSzTAVD5JG
 8H+Ecl2mWHrhxcnw/2SAHvyApHZ3Iz0K6UyF7IavXBP+BaKK6gECfFu3xSikaZufqk0I
 i+Jd81Q6JM+SJM3MpbEo+XeOnhv/pQLwptqvJ+2d4rAkyso6b3FApcYc2NAgCyuhoPPc
 D9zmRpARlbWKXTNFg32lO9fhyHn2hoimjKa6j+uY7QhKh+WrX6/Sjh+emWcT9S/AO1SQ Gg== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ua662aae3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 12:54:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxUEqcRPOtL/19gt2SVMzue0TEld4tg+nFpK/nLxaUVXu/PQlMYRW6M6SfeeKGIKFYphmtJfi67eMh7Xw92py00MBXyvvD3KJmmC0jiKhA+0m/VVgMy4hmlzCzA7ypQwmsQ7QxdCM2Bh7LuRTbSAziboBjN0RVmPoj7jt1AGEypo+WnukrEi3xZMhvexcXEtZ5+jQ3dyOvH0+vDP8LJXk5cQKiytYFDMtTAgym77gCvLTJ043XlXsYHW97se+ZVb6tj8hs7L+E6+geJElwz6dXsqs6NfKCi6HGHUMzvECjOAfRPhaxFN15pXlpmA9O/Hhg3PSl7ANfRnFbkjy9A+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ordwmaGaN94s7qDEMrl0I5rc3d4XfczvqDf1X9OPSJ0=;
 b=oSF9WbtEAO6AtPSsolZ3xGaH43EzabkZ8Xm97tjOzsqsmp/zDcMfy5mgPEpHVfXkVp/npQ2QJGWQ0rnSETofkas70n1fqcYvo/qnsdatgNwyATjxk2gqFYxhVaTsn58l4yH/z5pthh89lIuek4Rpb6FFCgiGx0+vvtB0tb7lEETCIsCw6WNKtrmAicabAF1F2ncPV5YZStTaa4B8YBPTs6558iK1EH7OB+FWZdFamv61Te1tCjWfzYPgsBeQra92G5hcJivAQ3eUVm7h/qyhD9MuRd7kewOpjWbGfsHzOF3g3GKNlSKFeMTz1xLeosoY/NgPrGz7taqZpuLiyIkz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM4PR15MB5565.namprd15.prod.outlook.com (2603:10b6:8:10e::16)
 by LV3PR15MB6435.namprd15.prod.outlook.com (2603:10b6:408:1aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.9; Sat, 11 Nov
 2023 20:54:16 +0000
Received: from DM4PR15MB5565.namprd15.prod.outlook.com
 ([fe80::2d9b:2b79:d3d3:6542]) by DM4PR15MB5565.namprd15.prod.outlook.com
 ([fe80::2d9b:2b79:d3d3:6542%4]) with mapi id 15.20.7002.013; Sat, 11 Nov 2023
 20:54:15 +0000
Message-ID: <f4209b29-6f91-4f4e-8c4a-6cae140ab89c@meta.com>
Date:   Sat, 11 Nov 2023 15:53:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/10] perf: Remove get_perf_callchain() 'crosstask'
 argument
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <f2c5130322a419ad04ea328a22fc2908487a1e25.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chDdw4tMx9Vqw_P5D5K32pptHr4ncv8kQJr-bko6RLoBw@mail.gmail.com>
From:   Jordan Rome <jordalgo@meta.com>
In-Reply-To: <CAM9d7chDdw4tMx9Vqw_P5D5K32pptHr4ncv8kQJr-bko6RLoBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To DM4PR15MB5565.namprd15.prod.outlook.com
 (2603:10b6:8:10e::16)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR15MB5565:EE_|LV3PR15MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bcf4fd-bdc1-419b-d1e4-08dbe2f85290
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofLdKyleDK5yu7oWeZNeFcIIods+XQGhavH7xqzIxLe9SFWAIZlqKGZgrAuItKNrU0nKQjJzrE4TW8KERotfN8+MvOgXKq7kPn3qV1P00P82U3iJ6EfD5cUuUxSNm9ER7CjjDzjoZ5Mgq3x3JOkM+7hC6oqaZcqgK6CmDXLXgJS0M/ThO24G1HEi40Yxd5pQK3SMhHQMRXvLDCg/6XUiOx+F32OHIWqkOZ8kIKAoXdeb0M0wpTzUTLnaRMz3l+MQ1xnVCX4ffTgCxoc0Z0EXi3LEtFSkhTCqjaFYHLGgEbq+SzQrOFiq+sriWva8ds9AyVjm/fYgoVCTdIUMO1jxwkeqFVUNk+XmTe9Q5kw6sCuPu9pz5DfbpY37bTFaTlrhm5ILxZmpl2erWfHEHTBrYsRdvhM7Gf1CcToJwnfqGMGpRvgBHYQ5G6pZ219Qh0y20IHW7b+Z8Rf3pT3+MrCTGUCsBMKrqWndsCDgTUkkqwsSNilMbF+kc6ZncLwWYMx/SE9Rur+NXZ1xDepjS+xbO/YBW0/YvMOxGVlclbQFJVcRoSUUTKQeRCksxaBNfgZ5AcW3L5oS5hUAuGBKPpLxLvu+98095XBGc/JuPv/KH1zU1ArMYaOT2ldeDIVdmJdpHfPc/ODS5BBnsXv1PON8ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR15MB5565.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(36756003)(8936002)(83380400001)(316002)(26005)(54906003)(66946007)(110136005)(66556008)(7416002)(2906002)(966005)(66476007)(4326008)(5660300002)(53546011)(478600001)(6486002)(8676002)(6506007)(6666004)(2616005)(6512007)(31686004)(31696002)(38100700002)(86362001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzRqOGNIdHkwNGU3Rk9Cbkxidy9ncFJYYkRkYTJWTlhnTTBUdWZiY1VLbkFM?=
 =?utf-8?B?Sk1yTVJtTHFDM3pXYStra1psRUJvYStqenNhVjJzNThwWmFQbFZvZUVDdzds?=
 =?utf-8?B?RUlTK0VGNzFwY0VPU2pGZHlnZGJadU1XTFduUUlHc3k4bEpaMUdESXEydVdZ?=
 =?utf-8?B?eUxoOVdDQ3c2NzNWS3I2ODZpWjUzNXhZTzBGTmplQi9SV2RLODEyZjhpY2lK?=
 =?utf-8?B?QVB0YTFjUlBwSGxsdW1wYlBxYk5uRzR4dGladm1PeWcvUkc3aVliZXpuVFYx?=
 =?utf-8?B?SGx0Y3dMbDJzWEpXbVZHQUJzQnlaaitRQ01jQnZZUUxiZUdKU1FpZmxCQTlH?=
 =?utf-8?B?bkxCTm5xUlFTbGJOZzcyQndkR0RLWi9BVjFTc0hDRmJjM2YvRFBxOFRibmsy?=
 =?utf-8?B?UmNTTUNLV0oxU0pTQ3BDTkZ3VmY4M3ZQU0JXMkdZMzJCV01lazMwbDE3WTg2?=
 =?utf-8?B?eHZmRklGT04zR0gwMzBnbXBJMzk4SUJZMTYxYnFjSzZjWmhPNHBRYm02dGhL?=
 =?utf-8?B?Vkc3cmE5SXRZTEg4bk9DMzJXWGV2SThPVTI2VitTWFNDRTduSlMwSHhzNDlS?=
 =?utf-8?B?cElLWlRNSkkrd2VQelAvODJjNTBnN21QZFl0WHZmZW9uZE1mNm9QeldBa2RH?=
 =?utf-8?B?QUJrakFpRHIwZGhoVEZxQ1VJcTdGeXhaL0FqWVczV1pZOFRtMU16TEJiL1J5?=
 =?utf-8?B?NlV4V3RqbzRTZ3FEQk5QemR4ODc1Q2wzTmpvczQ3aTQxNnYxMnJ4MGtIU1hz?=
 =?utf-8?B?TWxuTnVrL3BTWFM2NHNQYmw0YTh5UWM1M2hGSE8vTEpvb2gxZWFkblhiNlF2?=
 =?utf-8?B?RHZFOXErRFl3bEl5OTIrSVFyNDI1OGpSVHFvRzBHR2JYbVM5Ui9Pckd3OUtD?=
 =?utf-8?B?R3JzRXRvN2Yvbzh3MjN4THcrY2pxS3hsdG81czEzc1gxZlR3OVcyZ0FGeUR4?=
 =?utf-8?B?V09abzRYR29UWFpyY2FNNTU1bVhUc2NtU3pIKzJFeldaMWtrQ3A0c0F2QUtx?=
 =?utf-8?B?NlNRUkk4WEN1M1VRcG5vMUVDcWdzK0xZVnJ2NFM5aTdrSXpZdi9zb2tLdEsr?=
 =?utf-8?B?Zk1JZmN4cVBMcGF5WDJ3a01iQWo2cXlWMU5pUjl5clJYL1BYMnd5eXFRdThU?=
 =?utf-8?B?Sy9kOE1ZcjkveDlTWFFlL2hibnFwbmFHTy9NbWw3Y0oxa0NGYXFBRlAyYXpM?=
 =?utf-8?B?cnJFdHpVeWY1U3JNenkvVU42S0NNMVZOdVhKZFA3MXRKTkZBbEtHaFVKT2RH?=
 =?utf-8?B?R2MxWFhBQzRkdy83VTRMWmM2Sk5iRXVrU1dXWmtyUEoyNzFZL2RERTM2NFEx?=
 =?utf-8?B?YUszTUZjS201WmZPVGtCdkEvZzkrMXdXUDVSWFNVZUlycXlNNnV1aEE2L0Fa?=
 =?utf-8?B?TElGT0xrSUltTDZqSlhDdnc0UWlEY3ZqU015RkZjQXBlc2hyQmlJbFl0cWQx?=
 =?utf-8?B?OUFMcDhld1RzK0lHUHNRUnlCYXhzNktrZTdYNGIwNjRNaUh6THZiaHZSVEZV?=
 =?utf-8?B?UHpJRnZXMUo5Z3YvQzJmRVhVTGdoeVRDcTMrN3luclp2K0U0RGwrWEdLUzBn?=
 =?utf-8?B?RXhmQ3lLbGlDOVB6ZGVmaWlQYjBNRVJ6Z1hteExTQXZrVVN3bTdFUFpNTlFV?=
 =?utf-8?B?WlVrdEZQbjFzMlJ6MEk4ZzN3Y3VYYWpSWXBrNFNWd2dRU2FrbjBEUXFVWVo2?=
 =?utf-8?B?WURQRVFheTk5KzladVRlWG9NRVA0c1hLcEczZGF3NFBLSkhFa3dSdzI3dWND?=
 =?utf-8?B?VGNTVDFsQVoxT09QTzh0aXNCbHZtU2RrNFZxcXJEa3ZTRk4wTVhOTnQ5SzB3?=
 =?utf-8?B?SmhFZEEydWQ4eUlTdkJobGg4SmlnZ1huSU14NnMwbW1jZ216SStqL3NMeWIz?=
 =?utf-8?B?MldoMmNSU1pOcUwrUUw1eU5QZmZMbit0czYrZlJoNUsyREw3M0p2aExjOWE3?=
 =?utf-8?B?MDNnZ0VQWVdRNE5DWDFNZEVMZjQ0U1VZR2ZuTnZWMUtNdXZoZ0MwM0xRaVVJ?=
 =?utf-8?B?SnJIdjlkZXNpSGo1blAvMFUyUmNZQ1I4U01IYXNaNXVxblNZT05XSW9yMWhp?=
 =?utf-8?B?NE45V09uWlJGY1NyVys1MWptd2lSRmh4dVhmTFhJNnIzd05hODhVM01QczFw?=
 =?utf-8?Q?iSSVbvyMHFY/dJ+VdoKCfHgBB?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bcf4fd-bdc1-419b-d1e4-08dbe2f85290
X-MS-Exchange-CrossTenant-AuthSource: DM4PR15MB5565.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 20:54:15.5806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LotVWZkRB5eE960Bek82335c5nD8bqB8oQ2rl1uqgjV5Q1V1j4WGGX5rUhT9IU8tT/ydA+ocoXDMiPcPOKB+xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6435
X-Proofpoint-GUID: EvQMz7ne53pecu6Ooq-9yVQn-yrFocG4
X-Proofpoint-ORIG-GUID: EvQMz7ne53pecu6Ooq-9yVQn-yrFocG4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_17,2023-11-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/23 1:11 AM, Namhyung Kim wrote:
> On Wed, Nov 8, 2023 at 4:44 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>
>> get_perf_callchain() doesn't support cross-task unwinding, so it doesn't
> 
> For only user stacks, but it seems there's no place to get cross-task kernel
> stacks too.
> 

There is bpf_get_task_stack in kernel/bpf/stackmap.c. This can be called
inside of a BPF task iterator, where you can get the kernel stacks
for every task on the host. But as this change points out, this doesn't
work for crosstask user stack unwinding. I have a similar patch that
just exits early in this case:
https://lore.kernel.org/linux-perf-users/20231111172001.1259065-1-linux@jordanrome.com/

Though I'm not opposed with just removing the *crosstask* param
entirely as a similar check was just added in the bpf tree for
bpf_get_task_stack:
https://lore.kernel.org/bpf/20231108112334.3433136-1-jordalgo@meta.com/

>> make much sense to have 'crosstask' as an argument.  Instead, have
>> perf_callchain() adjust 'user' accordingly.
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
> 
>> ---
>>   include/linux/perf_event.h | 2 +-
>>   kernel/bpf/stackmap.c      | 5 ++---
>>   kernel/events/callchain.c  | 6 +-----
>>   kernel/events/core.c       | 8 ++++----
>>   4 files changed, 8 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index f4b05954076c..2d8fa253b9df 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1534,7 +1534,7 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
>>   extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>>   extern struct perf_callchain_entry *
>>   get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>> -                  u32 max_stack, bool crosstask, bool add_mark);
>> +                  u32 max_stack, bool add_mark);
>>   extern int get_callchain_buffers(int max_stack);
>>   extern void put_callchain_buffers(void);
>>   extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index b0b0fbff7c18..e4827ca5378d 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -294,8 +294,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>          if (max_depth > sysctl_perf_event_max_stack)
>>                  max_depth = sysctl_perf_event_max_stack;
>>
>> -       trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -                                  false, false);
>> +       trace = get_perf_callchain(regs, kernel, user, max_depth, false);
>>
>>          if (unlikely(!trace))
>>                  /* couldn't fetch the stack trace */
>> @@ -421,7 +420,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>                  trace = get_callchain_entry_for_task(task, max_depth);
>>          else
>>                  trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -                                          false, false);
>> +                                          false);
>>          if (unlikely(!trace))
>>                  goto err_fault;
>>
>> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
>> index 1e135195250c..aa5f9d11c28d 100644
>> --- a/kernel/events/callchain.c
>> +++ b/kernel/events/callchain.c
>> @@ -178,7 +178,7 @@ put_callchain_entry(int rctx)
>>
>>   struct perf_callchain_entry *
>>   get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>> -                  u32 max_stack, bool crosstask, bool add_mark)
>> +                  u32 max_stack, bool add_mark)
>>   {
>>          struct perf_callchain_entry *entry;
>>          struct perf_callchain_entry_ctx ctx;
>> @@ -209,9 +209,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>>                  }
>>
>>                  if (regs) {
>> -                       if (crosstask)
>> -                               goto exit_put;
>> -
>>                          if (add_mark)
>>                                  perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
>>
>> @@ -219,7 +216,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>>                  }
>>          }
>>
>> -exit_put:
>>          put_callchain_entry(rctx);
>>
>>          return entry;
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index b0d62df7df4e..5e41a3b70bcd 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7592,16 +7592,16 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>>   {
>>          bool kernel = !event->attr.exclude_callchain_kernel;
>>          bool user   = !event->attr.exclude_callchain_user;
>> -       /* Disallow cross-task user callchains. */
>> -       bool crosstask = event->ctx->task && event->ctx->task != current;
>>          const u32 max_stack = event->attr.sample_max_stack;
>>          struct perf_callchain_entry *callchain;
>>
>> +       /* Disallow cross-task user callchains. */
>> +       user &= !event->ctx->task || event->ctx->task == current;
>> +
>>          if (!kernel && !user)
>>                  return &__empty_callchain;
>>
>> -       callchain = get_perf_callchain(regs, kernel, user,
>> -                                      max_stack, crosstask, true);
>> +       callchain = get_perf_callchain(regs, kernel, user, max_stack, true);
>>          return callchain ?: &__empty_callchain;
>>   }
>>
>> --
>> 2.41.0
>>
