Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0B808AED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443364AbjLGOoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443322AbjLGOoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:44:22 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E63C3;
        Thu,  7 Dec 2023 06:44:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ13j8xDIaAf3D/8s2dXvtz8epDkQQ/CdoLYAICiAM3PlAr6ov1ZViuXrVonJRevaf6pm4TnPN59nxSVFz3r2DySeFkjGLs61KEoUxGy2cwR62hYjTqnqwp98EjSG1OM3d+XQFZTaJDpL1eBBf+RxwD9ZldC3LUTTw2DIrSwT/0hHDQZdU1zpQtMgROfQ7CU4bw4eB4IOzEVrw2CBT7nYH44uydStY41CjIkqC3FlQwbuVQL2cV4hsRlWpx9/ACRXKFhhyWxGSPpiNUwQpYb63SSd6UZim7W5i6Lg7f4qLQ6maprmxKkRe+iRxdsTbgJIE9f63klFkHycjVK4udEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfCywKyh3g/ME3b8Tqtnoznm2qf6miFOaa9XsbN4viY=;
 b=brhpXuTHdfh2Eb3fkxLVxG16qZio0lO/ta/R+Z6UskUcj/kpQLsvr+fS0anN8XfzD4nJdtRyIvLw0Qtc0gCnxnYzBsaSYQU3R+kEqhd6mCQFnwhpDi48iKZ2dODCHDkmGupX1nB8qx8U1xK53mopaIwb0LvyR4PT9Q+MnY6DaQnpgE/s5LXLiObGL/4yhp+l/5jYmScqbJabUXV/qD2vcYxS60jyhS6LJSCd6odeoKQMgkyWD6LvmXinDFV4K1AlJAbzRrC1tYIUL7YXMRVySzZmFbx8siUfJARTBtGBR3JhTm1TwiKGqSadsDJJyL0APSlkh9SaM4rBpqEULgx+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfCywKyh3g/ME3b8Tqtnoznm2qf6miFOaa9XsbN4viY=;
 b=2zAT9YY4Tdo8T37XBNeKCKitjAtVXE1xZpXi5VLVGe4sdVdnlawEyHfXJZmhvR8D6wzNefzpN9cyAmHce+8DUOToy7MEqKZ+8clNCdnWG0lGtgXMTWPgxr69c/VJV4A9O7hBhK5YeYdtlIbykAxt0P+BKQ0fy9ewMzbhbKHvw38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 14:44:24 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc%3]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 14:44:24 +0000
Message-ID: <0597b44c-226d-1180-d55d-bcf9bbd2e03f@amd.com>
Date:   Thu, 7 Dec 2023 20:14:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] Clean up perf mem
Content-Language: en-US
To:     kan.liang@linux.intel.com, acme@kernel.org, irogers@google.com,
        peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, john.g.garry@oracle.com,
        will@kernel.org, james.clark@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com,
        renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20231206201324.184059-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cca6f57-e4b3-495c-5af1-08dbf7330173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQYbLhz6OfWRYjmg1yyQI2v1+HZ3KShnPjj9M6MfooK7IDMrEPP5t2+5jCf1+0uZ5Km7Y7GTN+lILSZzAecUV8NhW2iPZJl1w11tbOaO2aH9W+j7iUNI5DNGnxa9R5WbLbGFr2qaKvc9I3SS6jmDzXRL/1gOKWMT5/Pr8GOmQPWOa6Wo9gathvEe7+L7viCGKy3kQwXBri6UicJ9p5Xi8b6JYaAeCfyvzR7rO+KUk9Tm4DwR3gukepn8UNY6i0e840NlwsOu/HweQYkzVHBzB8nnASn/+H1ZeOLxDf0NbSi2fNkBc7wmlyE/cpUZAK79U/2jHwgv6oJfvOpTLv8Hb/qBMRBhmWlVbwdjgIGtPputQFFpwyIznWIF3Q4mtr8Llkot6qqRqRobvPTttgvVX+s6bFViFvs+fX6hJF5ygEelCMnrzS74ueuMtE7Nhvx36Q8dRPHq8T9flsMk7zBdACunHDDbPP/VwtGqf7ZTCVRxgxTG8zrJQmi9kmjI7ZVeVQIEl4BxWxXBp3QYPPjb/lludThT2U8CTgUKzEZL53TDQ0itOfeEf0fb0zAiol6ZqFEffnAQ8rRxEE6tn3p/ogzVneRnLmW39SHKxCKrbzZ1CVvxSg39MoHnvETnGE7+lJzjEyVSOy6VU3uq1jrwD8R5Rt1SzAnMRhCeLYRXDkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(6666004)(6512007)(2616005)(6506007)(26005)(316002)(66946007)(37006003)(66556008)(66476007)(921008)(5660300002)(2906002)(6862004)(7416002)(4744005)(6200100001)(8676002)(31686004)(86362001)(8936002)(36756003)(44832011)(41300700001)(38100700002)(31696002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFnMDVzSTRScGo1ZmVYNUpGN0hyNk9rMWEwV0c1dHdPeFlqWHl2VW5lbjF2?=
 =?utf-8?B?MjhrRDFFQVZPOWJjR05TUHlZNEpDV25KSGJ5L0NGWjV4ZEtlRGJkOUo1bldD?=
 =?utf-8?B?Zm01eW52WFVVbnEzSER4eUl2N0VjVW0vcUZ2TklQRlNMY1ZBM0J1QkJHT1B2?=
 =?utf-8?B?d1RxZlVMVFhnbGp3WEJTcVhEeHB3WVFUT1FibVFDTUphY3UxSnNzQVNQTXVR?=
 =?utf-8?B?cWh4dnRNc2ZEdGhwZ1JhV0xWWmhHQ1Y0WEhva2VES0tuaTRXbXdIZGhKclRu?=
 =?utf-8?B?WXR5dTNKWjVFVStsOGEvdnNqUEdKUGFnR21ORjYzVXdzRExRbVYyazdLVnRZ?=
 =?utf-8?B?c1FUVUxZN29naWlmS3N4QmZZRjZRS1pQdUwyZXhzSmdpTjZFZzRzOWkwWnAx?=
 =?utf-8?B?MkpLSnQ0eStJWG40NUhQUjQ4bXNoQ0ExVWdmZ05IbVJaVDgyc1NJWXU5Z205?=
 =?utf-8?B?dnJhdlNaVGRMK283UjhiOXRoakNZbE05alc0dWNDOUpSUXI1c0s5ck9tVFZl?=
 =?utf-8?B?MUNVUXJ5NTFSZ1hCZGIrRXdYMENmSUQwUWVjUFRVdlhyd0RzVXhuYU9FZXd2?=
 =?utf-8?B?WjE2MEhsdVp1bFMwendDeG5PR1o4Zmh3azJXNWVrdEJTUmV3YnhZM3RxalpH?=
 =?utf-8?B?Q1RQTzlLYkpFc0Vud2dxUTVEM1ZXMjB6QkZSYmc5OWQwMDhQb2xHeWxYMlZG?=
 =?utf-8?B?ek9pVExEMmROWko4K2VwYjFmVXdQU0lZbzQzRGl4anF2WFAyWXNkMGdyR09T?=
 =?utf-8?B?ekJTdmYxbTVpRjBoQVl6Nk1vL3BHeUkyTEZNeXpWOUhwZit5MUFSTWF3Mndv?=
 =?utf-8?B?Wm9FUkZBVFFXc0d4Y0xGY1hJVEEwRWFUQXptVVZYS2lGald2alJCRjVPaGt1?=
 =?utf-8?B?L2ttNVNPaEtlTXdEWUN5RnA2TzliQTVCOVdDQmhkSzE0K3J1ay8wV3JValFG?=
 =?utf-8?B?ZngyZXQ1MHFRZCsxd1JHSG5qTTVYdDNHM1pSdnlrNlloVFpPbkFMN1pmL0ZB?=
 =?utf-8?B?RXFMVm04SGcyUlhvU0ZMZGdHaTdJZEp2NFB3S0FFSStWdGt1T3Q3L3YvWllq?=
 =?utf-8?B?QzJaRXJMMW5vOWgwUGJRTmhNcHJkcjEyTlFQNGlsQUtzcmJ3bklUQUx0Sysv?=
 =?utf-8?B?NHVkQlZhUldYaTlCNklaL0ZrWFlJb1IzcHNNUTBMbXpvWFV3aUpKN3R2djc0?=
 =?utf-8?B?T0s4NVBaQ21wV2RsbjRITVA0OHJnSWxvNEk2Z09nZFlvdjZaQ1FaQUVweGpF?=
 =?utf-8?B?eWJvS21UKzhsNnZ4Q05XVUZ0Yi9VTU0yb3ozYkFNZUIzVjViTkh1QlFRMVRI?=
 =?utf-8?B?RmtRUk8ySkNJRkw3eGtJUktDWTc4UVBSc01QOHlvcnRmOGt2TkZOOE1iQ25P?=
 =?utf-8?B?ejBDL2dab3BpZnVFSENCMmMzSU04NGJnbmcvRy9najF3YzZFc1RORllQMU5T?=
 =?utf-8?B?MFFlMGJ4cmEremVKQ2M2WE1YRkVtT3ROYmJBWXcySXBMSmVMcUlMV2pLNDk2?=
 =?utf-8?B?MlRNR1pKdENhZVlleTdtREZDTnNZSlBzcUd6aXFyMUoybnBaVHZveURMVFFs?=
 =?utf-8?B?dGNCSVpraldyT1pXT0NheE9SeXVicDRkNFhNbDNZWGhtNUF3b2UwdHI1aEM1?=
 =?utf-8?B?eHluSjE0alNoOUVFWUJORnBvM1NIVlRoR1BscW9ZWGZqcVprczlIY2ZzM0py?=
 =?utf-8?B?c3lHTGJ1LzR4QmZzaXVIZGtSdlYvQ3l2Ni9HaE9uY2tsMGZSTG9iQ25UY3ll?=
 =?utf-8?B?ZTJOYzdrRFpBSEhkUVgxMEJpN0NwK0ZMZ0tTMjJaYjBYbFlob2hpTHlFN0lk?=
 =?utf-8?B?UG84T1VLdjZ4S0hzTmIzSXZ6RWZpTmh1VThmNVl2V2QrN0kxdlU5eUFqdXZl?=
 =?utf-8?B?ejZYVjBjK3FWbHpGUncwdVlIQ0U4bkxoeFl2ZXVzQmxlNmo3WDgrNkRwc255?=
 =?utf-8?B?TStvUlRTdkZVYjZ2NWh1T01sTEt2cGpkSzJaalN6RXdKSWVHZ1RMNXVuTWUw?=
 =?utf-8?B?V0JRNVAvOEQ0VndwTjN5UWdrNS9sQStRUW1WbHJOYWR4Y011Y2dFQWtvdkZC?=
 =?utf-8?B?bVY2TmdkdUVNeWpyMktvNmg4czEyakdFRmR3REtkR0FRamw3NWR4UEt0elB6?=
 =?utf-8?Q?2izXLMltKleg6Mp3HLdAGTnFI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cca6f57-e4b3-495c-5af1-08dbf7330173
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:44:24.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs8/27ME9Fq26cIhbI7qgoJPq54eCaGeczYTF2AWSiIGO/HlRlVQXMZgToE+IMfyEV1kj8AGb5p+Qhh1FTGxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
> etc. But I can only test it on two Intel platforms.
> Please give it try, if you have machines with other ARCHs.

I did a quick perf mem and perf c2c test, with the fix I suggested
in patch #1, and things seems to be working fine.

[For AMD specific changes]
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
