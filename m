Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804337A144B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjIODV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIODV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:21:58 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7772711
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYZckDQjKcPiPBfb5JP2cGAjR9s9udTVtRN6lLc9LUZHbdpdXVzk0fvwi9YdYhlEgNO9bi1bEdbdkG5SxXT6kSpvh4QDHunMC667unTaWQfkSKKAW/7KLPVzkzmunV/gZ4bYt+GX3BOqXC+9o/jUqMPb8z38zFTRw5UgJVgIU1Akx8UKj+tu0/WPHWEnL837Q1pns1ewLcBt94+LfLdsuqPr0wc4N3ZE+KX2/Xsqaahq6qKFtX1k6endSvyx6ArWA28qSuIVIaRBC2QvP7CyB5EsIsXT56/GONP4pNoMzvOIMBtx3KQiwlbSKqcnJUUoFwXxvPR3UCUKcsukXtVkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhuLvk/kkb3jWSesFCWJ+ISl31eP/PyR7Sa40s37Egw=;
 b=DX3njPpvvm97Du3Klyyz8yqC1b237pEVD0ePwBZT3Qo9+9Fc2bx+o02Ex+iyypMJ0x/ACkFxZljPuEAmEfqzsknNAuSSuG5ZJ0yHc+5qfGUiLJHiUKER8JX3FgmXh6CZe1keFpoZu2Gkd1H7BUieWjrSMa4usGMwG40pQKQdbobLDKleCytsFyTJiMoJuQCvvkIqDctsBSMoEfVW99TtkQCOT24KLdATqz8+Z3WJxoQ1iZ6AkWHVUoNRIb3AVrr9bmgWI4LYk2RqzRFBRlL2uJcFO6IMe7tDW2xYHFKnaBt4y8Dr32/M1LO/FvQcFMUvofKMdxE5rDCw5TV7w245Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhuLvk/kkb3jWSesFCWJ+ISl31eP/PyR7Sa40s37Egw=;
 b=1ArSFhrpuc9vQbRaLNIDmq1pbTlRrNXT3IFDri1RVAqlOSIdcxaVo5IrXbmIszS+SfKQ8rmrWYUiZgxswYkSNQmJq3EvXmMzUXe2kbbFr771MlY8q/1paVdnUGFCa6PURBPIkYIwK20hgLJ4HBRPpeaC+ZofW3tR7VzTCqgoR+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 03:21:51 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6768.036; Fri, 15 Sep 2023
 03:21:50 +0000
Message-ID: <85115845-93c2-9967-c3b1-749b62b22868@amd.com>
Date:   Fri, 15 Sep 2023 08:51:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
 <ZP7ptt70uF10wxlg@chenyu5-mobl2>
 <5b35ae2b-a401-2489-4b3a-a03e8284d138@amd.com>
 <ZQBaWRCmMOvIGmem@chenyu5-mobl2.ccr.corp.intel.com>
 <229069c1-3d61-53bb-fff7-691942c48d21@amd.com>
 <ZQElEM5GAn/Vq0tM@chenyu5-mobl2.ccr.corp.intel.com>
 <86f761a4-9805-c704-9c23-ec96065fa389@amd.com>
 <ZQLoAQcQJDCrdOGd@chenyu5-mobl2.ccr.corp.intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZQLoAQcQJDCrdOGd@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::19) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb9de23-7a95-44c8-f157-08dbb59ae5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8yrhoYdD6IBDa69wxAiiUbvUshN8yuyNvdr/KgSx/Bn/aqqHEu7l2Af7vTa+Wmvfymya3KFQqhJkm6z1unbfnSJrWdl8mav5dxekUKwzyr+3f/A5NCdSZXUyxQFTDNAfGnOc+6/LTRz+iS6ZJ8nlpXdLxUr2kJk6BiVWqYwCyX/AIdjXLaMDons0tFMuod5xqzUQjfEVz3bKRpsrb+RpD8/7+54zxuBxwFJSEt+ftBkEeziAWrW/rvIqMWcSMUqW5EFfIY+Vl1OyeKHwsgUnZs1uqebz5cD0bhEq3ivO/0r1D9oBzlVSW5BRk86+oIYNLn4RoNymvQy5Kgw/oBTeNsbv1jvuYEvZrjfro9GtDt4U38ggnYaJqnwBQTnvFpwC+FfFfQx2N/hJst4NRwxjCbBHRW7RJTMkxcRbOC4ju9X18ciwHIHGkUxC+2lw6guhFRE2tmTjXQS+1lF55tSHUdtHQrEva1tzN5bgX79cRpBT1UoBWiXSM3nxE+aF/8K6pWiQzkqUsWqlHtAcId6HLPOb7KiDyxmfsVW5vGucRMRusOR8o7EGnA3V3sjQ1Ya5JV4rVAoxjzq67/mBXeeKIq+6PQKW7rk/8A6gkOenvZ+MYgvS8NoYopmGTK8CCvYCLfaCby9ghnxwJhnzxxmhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199024)(186009)(1800799009)(478600001)(4326008)(8676002)(8936002)(6916009)(54906003)(316002)(66476007)(66556008)(66946007)(36756003)(41300700001)(5660300002)(31686004)(86362001)(31696002)(26005)(7416002)(2616005)(4744005)(2906002)(38100700002)(53546011)(6666004)(6486002)(6512007)(6506007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3Rlb1Q1ak5XTmtkVENSOENZWFBmQUJmN0paNVI5eEhuWTdzUC8xSGhGQzRL?=
 =?utf-8?B?bEpGL3dNbXhjTWh2OHZIZzgvenhjaHpteHNSd0dFeXBsNEIvT0t2SGI0Z3pp?=
 =?utf-8?B?akJycE1RZERYYjdEM3RjbkpGVVFmVzE2MytFRU1VYmRsL04yREI2WkhHVzZn?=
 =?utf-8?B?RFZCQzA1d0hYQm5wSHdORkRHeUk2SUtmcmU2N3hReDRSNlpwQkZnVWxkUGNv?=
 =?utf-8?B?ZDhZM0djNWJVakRRU0c4OWduUXh2Q3F6VC93WDVORkZnMDVjYVU1NEE3dGNi?=
 =?utf-8?B?azM5WGx5LzNiS2VLS20xMjR0cVNxdWR1MVI5K091cUZHOHpwY1ZOVmdCM3g1?=
 =?utf-8?B?Y3pZT3BrNlRpRjk2OUg2aEM0c2h4UjM4MjZKaHNnZ3BxYWw5K3ptdm93RUw3?=
 =?utf-8?B?ZEdsRlQ3d004Nm1YbTBKY1NaZWs3ODhPRFNBRVRKTXlDWm8yNTUyV1lCUEw0?=
 =?utf-8?B?WEdXWmVhT2NxanRKS2J3M0JXV2dSTUE5UWdIRTRCQ204dEpUWEs2Rm1saGcy?=
 =?utf-8?B?T1d6ZUhZRVMwWjhnTTg2dWREczJTQnZKc1NXMGpIVU9TWnVESHhvUzNrTFIz?=
 =?utf-8?B?Z2NlcXFCcmI0Zk5WcTJWT2pFTWpVcGpETXM4L3c1U0MyNmZUS3FrZHBnSVhK?=
 =?utf-8?B?SVFvdTVRb2FJWHQ3NjFtVFB0UWRlLzNLYWJKQ3F1NmpJRFNKVmVrYVlhWE5s?=
 =?utf-8?B?dHQrbWhCU0F3MUR1Qm1wNzJFYkF4dnI2ejRPS09rRlFTOGZyUjVBamFSSVRy?=
 =?utf-8?B?ZkE3alk5T1pEdmpKZUV6WGZmNUFlRk92aGQ0TGE5UTFlZ0ZjeW92ZjBQaGFC?=
 =?utf-8?B?a3VDN0RkQ2wwcFVtU3NuMlhYRGdZRDlWSEJBNjU0aWhCQ2dNeEV6MFhhMCtD?=
 =?utf-8?B?dGlZRlAwTnlWYkV6T2lwR1NaK093VjlTTG5hczJNbWc4TlVScDVYYkFGa05x?=
 =?utf-8?B?dWpieFEyZ2lJUjFOMXgrZGJVWE1FU216b2RUeGI0MzRGSVpVbndmc2JmMnls?=
 =?utf-8?B?MmR3QWhnREdPajJjMGtPaGJmWU9DdVJpdzdERlROWnNIZkNXdjdaZUllejMx?=
 =?utf-8?B?bnZCMGpiR3JyT3VGTWloM0VkN2dMRWMvWHVyNGpNanY4cHk0SUk4a2JjYjAz?=
 =?utf-8?B?Z2RnTThIYlk1UEs3WWVqWmd0aDhQMkJzVkRQaDdCdFh4UnM1Wm9uSFFSa1hw?=
 =?utf-8?B?VWZLRWpadUJxRjhQbVVoejI3R2NZbHhZTDZINlo1eFhKbXBrVEtTWVBwU1FM?=
 =?utf-8?B?TlJmM3FDTktuSmdOQmw3QUhxemVjUXNLNDZtUHlvT292b0xlWGZxQi85S0x4?=
 =?utf-8?B?YVZPZHhwU2x4SWdGZ1RINEdQSGRFbEZGNzhvR1E0SndSVTJZMWQ2VFB6clNP?=
 =?utf-8?B?dzVJdFpFakNsb2EwMVc4WEtrUnZXUG5oN3BTbzJjcmp6VWFPbXdFWmlDNVdK?=
 =?utf-8?B?WGQ0LzZRbjFMajBwY3hDbE5vTXluM2JSQ2JBd3ZzWG5OVk9mRkxURWd5bjU1?=
 =?utf-8?B?bm93a3ErYU1aMjNPdFc0WXpLOEVhOHFWWFVMbDBsNmswSXQzWXR1TVBRR1E5?=
 =?utf-8?B?eTJaVkpwUXlsM0E0U1ovWkF6SGpxWDRybnhtaGFSSExMdG9rOFh0YXZwNm1t?=
 =?utf-8?B?N3FsbGRlbEsrWExRb1BzVkg4RUpBWWFhL29ycGQ1RDg2a0xmTTR4Nk1hYzJL?=
 =?utf-8?B?bnNqN3N3eDN1T3NtVkhDcDY2bzdmQW5CL0FKcit3ait6c2l3bXJ4cEFzNHZy?=
 =?utf-8?B?SE1lNHVham9GVzF5N1dqNzlneW5wdi85SkZCSU9rSVNrdEplOGVkb2JYbm5E?=
 =?utf-8?B?L2RaTytxOU9kK0lRaitoN0t6OHFleXJvVlFjSHJvR0RaTXlCSk8wZitudHdn?=
 =?utf-8?B?bGtLNXlYYnZic3lRR2pxRWlOS2Z4eHlRYmU0cGpBRU93S1NrVFhzV1RYeU9R?=
 =?utf-8?B?OVI0RkQ0NVpSYjRkeTJxaElzWGxLa3dTbUhnZHV6WklESlNlL00xRmhyOGJ5?=
 =?utf-8?B?WWpxMldvaytsbksvNTFoaUZiOHd2SGtkOFVwYTFPZGc1Ym9mTEdrOGVvVFYv?=
 =?utf-8?B?RitiTHpDTlVGZFN3TUdSaDRkb3JWV25LbnFxN1pYVktDVWt3aVRuOUxDRERT?=
 =?utf-8?Q?kDQdGiPdcI2VtInWiEZl2Hgt8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb9de23-7a95-44c8-f157-08dbb59ae5f1
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:21:50.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HK0PoDptDspbQB3+iN5QPoeGVQFmWMBc4RmYN9Xg9mR9O2RjmPvOD6AvUIM2TCSsnrExoTSz6df5mMSccfdpcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

Thank you for taking a look at the report.

On 9/14/2023 4:31 PM, Chen Yu wrote:
> Hi Prateek,
> 
> thanks for the test,
> 
> On 2023-09-14 at 09:43:52 +0530, K Prateek Nayak wrote:
>> [..snip..]
>>
>> Meanwhile, here is result for the current series without any
>> modifications:
>>
>> tl;dr
>>
>> - There seems to be a noticeable increase in hackbench runtime with a
>>   single group but big gains beyond that. The regression could possibly
>>   be because of added searching but let me do some digging to confirm
>>   that. 
> 
> Ah OK. May I have the command to run 1 group hackbench?

This is actually perf bench sched messaging. The cmdline from the runner
is:

	$ perf bench sched messaging -t -p -l 100000 -g <# of groups>

> [..snip..]
 
--
Thanks and Regards,
Prateek
