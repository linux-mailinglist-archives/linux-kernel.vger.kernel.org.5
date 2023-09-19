Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82667A5BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjISIHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjISIHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:07:04 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49DD102
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id+mUo0bN6/5aoK1t7bFcRWbSW7yr/ai95RSeCl40WEx0qtlFzrNn6dJ44HziWPCpTXp3V2FDBs35qJoIaWDerBcbpg0DZoulVx1VxAy/JqDjSPR1BYjZ376T6Zk4QyQ3d1M0eJksLZnoPcYjrnL7s7KiaJioBi3f3j7ewcwhjF8T7BMMQFJzwduxYr/LgUHU3okNLirsrPncY3zs+3BxIto3yEhekngMLoweNSlWASNDIVA4dMS5ij0NjrKnWPa00ZIQzWfb3Ty765O+RDUEtBiOXsBicuZJNgzrCtXbvGrn0n/jGo8sLC62+2lr0PxYrdqgfOnZ2riemH+3LRfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlFTLIaSN/dWB3xSAzFO2WYMZQUTXXeNl4E+WI3O6Vc=;
 b=HSA+Jq1OyLlQnypFA2+/QTiFb/aoiNlWQoPuo03HWe6DCjTAAv4Lga8Tc2DzRi5pf98+NqtPQqWHJFjWcbGk6usbKd+xj8X2n4ITOm2WzYwYk0//zpmIfc+m1JCsYMA/bZRXgk5rnLm5X2jy++o81N7KK0lYTPgBGO+zPSStIoX6JyqPpJNb5MCk9NeCMvM+6ZI3l1tVK5oRJzVnumwPnCthNdrizGdg6gXp/k8RDQjr35VTBAnJzulSrAPUbOtCdayCZqe/SHZvhd33MNXwaOar1mKXnO0hPTjAXxY3OnehaPnecZCmIbBbiuW7FN5+RMV2nPmLxIslz1WSYAh7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlFTLIaSN/dWB3xSAzFO2WYMZQUTXXeNl4E+WI3O6Vc=;
 b=K76dwJImNHYsaB0Il5Xh4mQZSdNprhMiFPi0N23gMdEo8DMTk7/BQSkkS54mCI8qtt2go7U1Jbqe+f5ZEGr3QPlva+X3gl079LBBFxZxawkaaSFnrNL1yr9M353Gr3j5woxOOuvAmTVBP785ePDdeCdJN6ZPS1L+AX47E07kCBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 08:06:56 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 08:06:56 +0000
Message-ID: <6ede20b4-8535-b173-9782-eb8dc7f58509@amd.com>
Date:   Tue, 19 Sep 2023 13:36:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 0/6] sched/numa: Enhance disjoint VMA scanning
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <cover.1693287931.git.raghavendra.kt@amd.com>
 <719f0729-d28f-d12f-cff4-ab8115861d30@amd.com> <ZQlKfgk8Wvcd1Kbr@gmail.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <ZQlKfgk8Wvcd1Kbr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: c5aadd49-7ef1-4f42-a17d-08dbb8e76340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gj45Olljf0WtWmw09Icqso4ht/S9WRIEh0qUORk5nZhdA3hLLfy1DJxvzS6M/WK3+TGtNFvW1oflCCiNpFZoiPgUAYyhUeGoFVOn2/Aj/z2ex4/vs1ZjHY/JxSBkt+xbEeC40cShJrjaNRuFblMcCXSlOEQ1OAr36Am1DJyayHqXuiOKCrcCSYji0jiSmK116fLdGHRIl34y4/DmF0mmAlYV6j/KeazF6NuJ+4oKAE6D6QWXjjGszLwIr02bKC5Xp8tW3/luI2BBeuCYoBftNXJxQdUSzc+tSX1b1QPFA1wOrOnE1bCj/NTB+Ih5WN9fGZdmHBEsK200LGj+dtwYlXHhrYZcI9i2eTuR8XolcNw4v4VkvKH5SonNIqkwWOA+DPPQ99LT93a2or1jjwfJH7nrg6jsCNIfWjgre4vZGOVx1PRX4lFbteX7SPXx/jpPDtKgtghDKunpmxpmXffgOfaSaRVKJae8QRRqa8ZMxyPgPm/BL77YzjUUcl8nG9ZzZFCuD6lnEUib+ExdIoRXXK1PDq24z3l9qygLQh5iceWMjo/TuufQHrkybmoKkGF5aiZmt77v7hBtbl511MPGv2MnTA+UkDFk6zBM/e3f3JgiJsirKo3Nh7ugSK4StO+/PYrBrhKE85G0ugQVJ21FRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(1800799009)(186009)(451199024)(83380400001)(6512007)(6666004)(53546011)(6506007)(6486002)(36756003)(4326008)(41300700001)(2906002)(31696002)(66556008)(66476007)(316002)(54906003)(6916009)(5660300002)(66946007)(8676002)(8936002)(7416002)(38100700002)(478600001)(26005)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUU4bCtoQndRWTBNMkVMbGE0dHdsVDZab2o4WjdHZ3V3Q09sMzdJL1ZhUGV3?=
 =?utf-8?B?TndSRzZzMUtoZCtnT0J3cVlSakZTTHQrK0VLSWlIektpaWdoWGZUanN5Wm5F?=
 =?utf-8?B?WHFlZzVaZ0paNE1OWWM2SE5OVTJPS1RFVVZ4SmNCbnJLbTdjL2VndUVQdjNw?=
 =?utf-8?B?ZlNwTEdEY0F1c0FQVWFSRUNadTVHbGQ3VlA4cGtJNlZhZldkNHBjOXg1S2Js?=
 =?utf-8?B?SncvMmRTbllzbjdySU9IdldrTlJzdlh3ZE4xaG9vVDZQVU90cXlBWDloYXNT?=
 =?utf-8?B?cjNXTEp2UDRCWnQ5UE9VOUJoMDVZdm5jUUdyV0VtTnpXWWRCblBCUUlnMGZ0?=
 =?utf-8?B?NXV4b3lmdDYyNUx5Uy80ZVRPaHhEa094OGl6VWxIZGowbzBtT1NmTEpLVmRL?=
 =?utf-8?B?M2h1L0cwY1gyMjJiZ0hSRS9Dcy9JbG5kdUF3bC94dXpXLzBQak81U1E0NjFT?=
 =?utf-8?B?OUdUeEZOYjVUUUl1S0w1OXNyeGRoZFlkM200YXhNdXBXYXFrOVZFYnFrcmxy?=
 =?utf-8?B?dGFsOVRIR2paVnc4djVvMkJqWllCbU9yY2prYm50NlRYQmk4eXJjRzlja21v?=
 =?utf-8?B?bk84cEM5Ym1kdVZNT3FxSVJGNTY2Y2c3OXB0VFVPVHlFSVlFS3p2cU0xVVF1?=
 =?utf-8?B?em1XNTRBcGZTYmhsb3lxajhmMjN1dnJyWjBwR01zY0FXN0Z3dmc4QUpyU1dO?=
 =?utf-8?B?WlcrUDBEYmNTTHpDQmdXMGgxZFNOem1PVkhYbnFhdGlML3FHcHVZVTRFVHJE?=
 =?utf-8?B?aVhIY0tCQ0lrbFZCQWp6SmFnaFlUZ0hLODdpOFA5WStPdlpqYm96UTlzd3Ja?=
 =?utf-8?B?VG5ZOXRBNG02b2hDbVQxUlFwQmNNREc2eGd2d0lUWmRmTFMxZVBDWjByK3Q1?=
 =?utf-8?B?eGUxQm14TTh0VVRrcURWZXBFV3FHV201S0Y3VXZxMHV2ZnZobEdwSWgyZUNX?=
 =?utf-8?B?b3lWZmYxOUV4aEUwM0xkK09lTXVWblN0cXRQTEh3UkdOaHE4OUF6engyaStv?=
 =?utf-8?B?NmQvTHIxaUxEV0UzWTA1Ti9VdnNlZlRLSmM2YUJITC82c204VndITEhFcytP?=
 =?utf-8?B?bnFXRGpVREFMM3Bjc2lHODFyTXZhb0FaQkNkeElTaVVUbCtuT1Q2b0MwOG85?=
 =?utf-8?B?dTBWdlEweXVCdTA2cmpVV0w0akE0T1N2WHZGU1JhcEpaekxhbXpVVVZkSkNM?=
 =?utf-8?B?TnNhcm9PbWgwbnV1amdRbUVrOGl3anlxQlpMOW9HYlczMUc1TktMaFRXKzhX?=
 =?utf-8?B?Ti9LdElOV0twUG5Ia29Sc1JBQVJwaVZiVE85bVgrLzRJM29XcUxvRzBDQmdJ?=
 =?utf-8?B?SCtjVENickhxbHF6d1pVL1REakRDMjNnZ2lCL3dtOTk0WWlCUGtKMWNFTnh4?=
 =?utf-8?B?cXcrVmR6UDBZU08xakorMVVVRTdKdGtLTjlUM3ovSnlZTGNDWDgrMm5lbkR0?=
 =?utf-8?B?eWtXNzhEMGxDZ0hWK0dISkRuU08vK3RpNGJKTHVKVTZGWGV3eEdFbmxpN1Uz?=
 =?utf-8?B?WHZWTnpHblBPVThtaXVHQ0xjTmJCVXNlc2RVN0YwRmhBTG9JWGR1ZzVMdlU5?=
 =?utf-8?B?N1dlNlRyOEF6cEdHOEU5MGkrNGdCejlqb25pejE3bnErdFhpNWVKazBEa1lE?=
 =?utf-8?B?NmRnc1F1UUYvMVhBellEM0RRMFdWelpzQ2NwUFYwWFJSUjhnNlM5TWMrc3I3?=
 =?utf-8?B?Q0NDb3FEZzYraHZIRGxPSmdPRldCMW1waDA4ZEROUmxwTmhIMDhuSnJVT08z?=
 =?utf-8?B?OWxJT05BMjFxcWQzNXF4dG1INGFVMVNGSXNBNjVzQnluR1VFZXNYdE9QZXZI?=
 =?utf-8?B?TStZWlhQS21ZNks4RzVuT0REUGZzNmpnQlpacUFlQXZ4ZUg4U1ZDTUJaSUh5?=
 =?utf-8?B?d21LNzZZTnFKUlpaNnlTZDVyeHdGcEdndTdReC9WUC91eVRnNWNkNmZZZmxs?=
 =?utf-8?B?anRhVFYybllQUU5MVkplS0VmMTBwOHR4QmZkd2gxZS82b3R5Q2V2R29MWkNt?=
 =?utf-8?B?Y2FUcENiS3lxK1JNM0ZGNDZ0TnA4SVY5WWlSNTkzMFJub1lsN2E1Uys5bExm?=
 =?utf-8?B?bTRlbVhad1E3ZXFHQXFtT0JOT2p6TzBTdEVoUkZ3VWFFcGoyTnNtQzlYUFZL?=
 =?utf-8?Q?rixEqTal2qN6WTHndEO8zH4lb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5aadd49-7ef1-4f42-a17d-08dbb8e76340
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:06:55.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccxk/Nr0JrBKcViibtDRFqcwlhVteGLDibbT8gTbtYNvzy2pHjUQ/pGa+9LzlVSQtBklV42WoCeUIfjp9X4qig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2023 12:45 PM, Ingo Molnar wrote:
> 
> * Raghavendra K T <raghavendra.kt@amd.com> wrote:
> 
>> On 8/29/2023 11:36 AM, Raghavendra K T wrote:
[...]

>>>
>>> Peter Zijlstra (1):
>>>     sched/numa: Increase tasks' access history
>>>
>>> Raghavendra K T (5):
>>>     sched/numa: Move up the access pid reset logic
>>>     sched/numa: Add disjoint vma unconditional scan logic
>>>     sched/numa: Remove unconditional scan logic using mm numa_scan_seq
>>>     sched/numa: Allow recently accessed VMAs to be scanned
>>>     sched/numa: Allow scanning of shared VMAs
>>>
>>>    include/linux/mm.h       |  12 +++--
>>>    include/linux/mm_types.h |   5 +-
>>>    kernel/sched/fair.c      | 109 ++++++++++++++++++++++++++++++++-------
>>>    3 files changed, 102 insertions(+), 24 deletions(-)
>>>
>>
>> Hello Andrew,
>>
>> I am Resending patch rebasing to mm-unstable, adding results from Oliver
>> and Swapnil.
> 
> Just for the record, a final version of this series should be submitted via
> the scheduler tree, not -mm.
> 

Thank you for the clarification Ingo.. May be Andrew also wanted me to 
rebase directly to
scheduler tree. Last time patch series (numa scan enhancements)  had
  changes in mm/, but this time it is mostly fair.c.

I hope I have not missed anybody who should have been in the list from
sched side.

-Raghu
