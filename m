Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0EA7884FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbjHYKdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbjHYKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:33:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EA12116
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/q5OYWhLNjF4IMf6T6a3vjxLVccDT2/TITsSzXgEjEbBphJWpHdH3LKnoacE3nr7akPsZSdQgBKn85jh8VZGgGqZ3NVCdIfJyWPgpYZCBKL1zV6c049WCRbTlVHSRc0NpuiXYCba42AK1tWqyAGkGW+VUoQD954Hfhlrghd+UYJFSNLulzva0zTxYVR1IxaaS8scvNvevQ43shOT3UILp9tcNsRcuzcPmzYn3AC2RifZk3cr0yUplEO8Sz0jSgNGseJP4khsxNg9LZyPAodR3r6JdboUNW9A7WfZ3yeA8D7hV8plrjAvw0wCcN2NvOf/BesWu/GTtpKEgFG6H/iwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsjLCVXtqx4b5eMW5zAA0gQF1LedLnM+zGFK3JFfXQY=;
 b=Vd/RpuFEsrlJl/JnQgE9HSIjnFLXApS5QgGf4nq+PiaYrmVwHTLTxv6ZwXLxMD+F9Q5qTvcLMAeAODiLc+fxrzauOJJt5Jvm+PKmIKX9hwu5VQRMHWQGcozAgcZko2zboWRE/KTfXbNt+bjK2e6sIONRAjUyEuwd8tEXu5KLrN4rnPV5H4dGVe6DDHex526SBLUMEwwf0xi4AJO+c3Y/+dQLMWRxKRzTqOpUl/qrBCPUkN2ZPUK1vwuDIOmEm+K/kfBJZN+oYPWLjQaTQ1ArLbonVJQqEcMMpsc2Rw05WSx5WPqiw8a4+Yv61AVcO+AqWcKLDTCqpnJAxvavVKSvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsjLCVXtqx4b5eMW5zAA0gQF1LedLnM+zGFK3JFfXQY=;
 b=y2YNwgJ6n6+eXl5Xo/hIUyKi1KRl07So1eR0mHIajey12/amm27Gdw2A767yxeQ6e7XP/mI21V9DWgzmK9pk901xBu/ud+pN9qEjNjG65PEWePDddLJpexcDvZMHSgaVxtNSXr7qvrDTt170suJCxSZswxWviuQ3GvF5oNVy6NM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 10:33:36 +0000
Received: from SJ1PR12MB6172.namprd12.prod.outlook.com
 ([fe80::8ff0:3f26:2697:d8d6]) by SJ1PR12MB6172.namprd12.prod.outlook.com
 ([fe80::8ff0:3f26:2697:d8d6%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 10:33:36 +0000
Message-ID: <20e21145-4fef-33b5-f41c-5bfd66a0281e@amd.com>
Date:   Fri, 25 Aug 2023 16:03:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/1] Reduce cost of accessing tg->load_avg
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
References: <20230823060832.454842-1-aaron.lu@intel.com>
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <20230823060832.454842-1-aaron.lu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::33) To SJ1PR12MB6172.namprd12.prod.outlook.com
 (2603:10b6:a03:459::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6172:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e6d6cb-e4c6-404a-b702-08dba556bcfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kX7RLdjVjRqxfaylUNvR2kMpXqZvlrPrtZ0au3F+OQ9DaCFRuQ++Ob3iVkU5vtvJGQDwk3QS+uS7EtsbbdEpL6O4daE1szS0rQf+6w2sthUQmtGmNNGU36S+YmAPx47KPHFzkskUFbs39R7pq3YdGbKI9d4jKKGd4Rek1EdYT9WT+6KwG5vy+0gY6fVbZ7jequoVWWSlcZlp0Tq2d71uVxJjJkgnykVxcyPsnLp8M8x8f6/wt9uAkM8Dz9k1/mYJbn6J/ysM+yDge3bGRBbtm/qmuT/NGBqSuVdTJUpY1qR8cwfuezTxfN+zWH3KMBk0jMJ6CHXkGuXlBj5IvCC9g/NZ4m6rEHcGITv2UAnDPMn7XWSYjKYeGjq5Vyi3cQ0nOXb+Jf6AcJMpgtQczqo9MP6IvvTUfLfbNIxu82L9OR2i1blj+565N76lPvUK7RyL0UDUC6/9PrjUlNWxYKqDm97f2Opv1EUSQUnh7k1p230uGysfW/q9Rc+lRaM92MIQSOdljH/Bo5kX7JZQVvq2xD/vM/IGjYvZ4JVs61+yk4b6810qhMAWjbnPPqe/qV5bLM2971/au7g0Qwq/BECYppzQ1SLYGiqgaN/LFS8F0LNozeVrYEw1MelOuivGP4pk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6172.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(7416002)(26005)(38100700002)(6666004)(66556008)(66946007)(66476007)(6506007)(54906003)(316002)(110136005)(478600001)(966005)(31686004)(6512007)(53546011)(41300700001)(2906002)(86362001)(6486002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xxRmRoWE15alo2ODR4MU1mZUFqaG5Bc290Qm5ZODNmcjY5b1Q2ZXZJdWVE?=
 =?utf-8?B?S1Q0YjFMZDdJRWdIZHR3ZDlhRmU0dE1rbzg2ZkFhV2xyTCt2VDJYaDk0ZjZJ?=
 =?utf-8?B?WmVacHdTd0ZxSDdYaE13Qk5DTUpFSWxRUmtRWFNrN0N2cUJ5MUEzcmVuUU9t?=
 =?utf-8?B?bVFYRDNWSHdCU0tTZUdxczRtRXhDNkU3UVFjeThPa1V5OGI2Rmh6UXlzUjF1?=
 =?utf-8?B?K3hodTlSaGMvdXl0cTQyYTJpd1JxWmZRSlhPYmF3T3JRTHZXOG54YnJjRnA2?=
 =?utf-8?B?NHNLWkMzSGtVZHVUQ0RkTjU2RkR0aU5OZ3FqYXVlL3ZxdDRhU0FSL0c5ejc1?=
 =?utf-8?B?cjBuMExTZXZST2tNWWNaU0E0NFVBY1AwU0kyck0yRzZMb1ZpOS95K1NmWFlT?=
 =?utf-8?B?bG43NEJyQ2p3V0RJM0RXYUJWWHVYeW9YaGJYYVlUcWpBVG9BZkM5UGRqbUQ2?=
 =?utf-8?B?VldCMHN6bmhvK1A4VTJWZmFjekZCaE1IakJNUG9jUG9pcDVqWHF0YVErdlAx?=
 =?utf-8?B?ZkJta1NudzgzbjE5Z2RYZ0RhQTBZZnBYb1NzMktwUXhlbHZzVnlPUm9rUk84?=
 =?utf-8?B?d3c4Y3dnR1lFMCswUEVhRERnMFZxV1RSVlpibEVsOW1jSGs1NENNc0tyb0x0?=
 =?utf-8?B?RmZLUVlId2hkd2tYcW5pT0daREk1QUJraVpmTjZTdTljMHBnVmVNVHk0RHRh?=
 =?utf-8?B?TkhSREtoYkxDdzBJOEFQcGpsdWVySUs5WStwb1pqWk5LUURuY1ZldmhVRkdP?=
 =?utf-8?B?bEJLRllBNzRBTlEzRSthaWJZOUJGT2FUbFR0Z1ZKMEk0ZWpJRGRRejF6bDJT?=
 =?utf-8?B?U1pIQlRrcVZ3OWx0MDdPbzhsbHJQZTBpY2ZicmNjWjlRRlZLQURjdy91bXdt?=
 =?utf-8?B?MUQ2YzdTamh1WXZGenhUaHByS1NDejNISE9ETm0vSHpXQ2NRZ0toS2Yxb25E?=
 =?utf-8?B?ZUxmOHBZdXk2TVJBSHgvaEtUV0xSQWd2clJObkowVG0zL0tKZCtaYjhtc1NP?=
 =?utf-8?B?V0J2M0JzZ3VTY3ZwR1hGNVF5czhaa2s2Y29xaU8zTERJZ25nS2VUMXJYQ01t?=
 =?utf-8?B?VzArajVFeFFrYVBHbVp6Sm1rU2tENWxhUkozU0ZMcWs4aFB4ZjF2ZXNVWWZE?=
 =?utf-8?B?TGxxYWd1ZkEvckxDZG9kbzZFYlRldjRwTy91dnp2ZnI5RWp1YXRyWE9NbHpE?=
 =?utf-8?B?emJZU21DSkpmSU5hbzJsc0FJcUNiTEY4ejNHQmlnODZJekdKMnJvSVFOQzNV?=
 =?utf-8?B?ZUFEYW9ROXdoc1I2V2Y5V0NlRzhkNVRQTjl2ZFpUcUVxdGxyZlNoRTYyZ3gy?=
 =?utf-8?B?WVhkalQ1cmYyeG01QWxpTWNqREI5VHB4dEpyTUVxaVR1TDZKVTVhQnEzTm1v?=
 =?utf-8?B?WDRiUDFVbFRCSHJOR0pIZE11NllJemdPK2pmZXAwOHNtQ2lUV3ZadkI5SHlG?=
 =?utf-8?B?eThrNVJOVVE3WmZlaWo3QlJPdU1jMnlWbGpwcHFCd0lGVGZwWElMdyt5eWJa?=
 =?utf-8?B?RXpvMjA0dkZGMlp5dlgvY0lURE9BTE93MnBLbmV4dnVYVFpUcGhKWXozOUNK?=
 =?utf-8?B?NDNLMnN3TUJGSXRsdFd2UURONmszZGEvMHpBbEk2NDk5ZkhCdDU1N2xLdzlH?=
 =?utf-8?B?L2Yyb0hndTlKQjNCWG1MbndCVFA4TS9HckFrMk5OK0pGVDFBcXNaYkR2V1Ru?=
 =?utf-8?B?cmgxakZKeDVoRTNPck9DQWp6TlNySWZNQU5VSDhXZWhqSUJTcjV0SmRXaHdk?=
 =?utf-8?B?Y0hCdzRzNWYxbjlVSUs4YWkyS2ttby93VCtWTkxFWGluQ2dtbnEwSnBHTmpk?=
 =?utf-8?B?d3ppc2ljUVRSRVZZUStlRVI0cUtNMjdVYjdlZFloVHI3MDlvcGZVb1VMNHo5?=
 =?utf-8?B?MDdxckJhaEFQcTM4VC9pRWp2OWtPSWdQb0RZS0lBSUdkekdVeGgxNkxIT3Jk?=
 =?utf-8?B?NWZxVloveUZaNTd5bFJpRGdKdWFRaHF4QUJocXZ1QUtWaUcxRVJzdnpWSXJ6?=
 =?utf-8?B?VDZXNmJzaHM0T1FlTnZPUTkyTi9TUUVaZGN2eG4xZEZrc2VwNURTUXVOcGxq?=
 =?utf-8?B?SjdhOEt2VTJRRkgxZ282UWdGTTBrbDJsV3JYSWowWkhwK0lEZUFUck5FZDU0?=
 =?utf-8?Q?T3kwhjh3+thLqmHctSroOPgMR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e6d6cb-e4c6-404a-b702-08dba556bcfa
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6172.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 10:33:36.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofhRv4XEJT/QC2Mx0bv1rR8ASF2UYyk5za2SSFOnWU5tTUnyKYBq31BfMcypehWdzAUcyGBZLpEYGdZeGnb67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Aaron,

On 8/23/2023 11:38 AM, Aaron Lu wrote:
> RFC v2 -> v1:
> - drop RFC;
> - move cfs_rq->last_update_tg_load_avg before cfs_rq->tg_load_avg_contrib;
> - add Vincent's reviewed-by tag.
> 
> RFC v2:
> Nitin Tekchandani noticed some scheduler functions have high cost
> according to perf/cycles while running postgres_sysbench workload.
> I perf/annotated the high cost functions: update_cfs_group() and
> update_load_avg() and found the costs were ~90% due to accessing to
> tg->load_avg. This series is an attempt to reduce the overhead of
> the two functions.
>                                                                                                                         
> Thanks to Vincent's suggestion from v1, this revision used a simpler way
> to solve the overhead problem by limiting updates to tg->load_avg to at
> most once per ms. Benchmark shows that it has good results and with the
> rate limit in place, other optimizations in v1 don't improve performance
> further so they are dropped from this revision.
> 

I have tested this series alongside Mathieu's changes. You can find the
report here: https://lore.kernel.org/all/f6dc1652-bc39-0b12-4b6b-29a2f9cd8484@amd.com/

Tested-by: Swapnil Sapkal <Swapnil.Sapkal@amd.com>

> Aaron Lu (1):
>    sched/fair: ratelimit update to tg->load_avg
> 
>   kernel/sched/fair.c  | 13 ++++++++++++-
>   kernel/sched/sched.h |  1 +
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
--
Thanks and Regards,
Swapnil
