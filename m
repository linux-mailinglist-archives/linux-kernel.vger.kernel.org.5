Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D187FAF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjK1Ba1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjK1BaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:30:24 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141CA1BD;
        Mon, 27 Nov 2023 17:30:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOD0TYzmC4KnVQLRIXvUftoiy8Qok4M2N1m/Plv7FCZvSLIQI1ZGGwn5TomBO78HF7Yay6KvZRo6ATJHH+vehMOTuhYNIdoZODd8Z7XJ1XI994fsMUNuuCC6P7SWKjYnjoiQUOy7TOy99hSKKvqW7YnvKqyX4M3Iw7IqxiUX70DLoegVLe3999WNuyRF+/2IevHkGWZN8NAZF5mIULVqYhSGi1q8wgSn4jNltj2rB8Yhnugpq1/MmVPGN07B9/+WT8qJ8KdIdzE0IzCD1LxUauQ0cYLi/AtxEebcJHByZv9oC8/mAawFKdUbtV1krSjlwtG23Eh2AP8ZwCAAwjM2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPO8ZTW7Kce7So/mDZ+XpN0ANNJtiHYC1pkP7m4caF4=;
 b=bHo/zqZffHqxDocYEPgrKcJ3XL92XupAPGRa87WYrJUTYBVqOKBJMZlLyWsepMQaEf0NMFQsrg815kHrrRKyGrgMsq/aQDjQTVKMwcnjm4maeLCiWBc2c2YmESYZNTyewoi7c3f/7pgdUtNAMhCmyXKECSkUvLFxXfLdNGn40L4omDjdc781vOWaFQyVdj6crfGT+K4odDKYgy23+ld4W1AugiNgq2UItsOdya8YhJyd/S1O6Z6xsbpAGnB3MPgBNbqQNsi31TYIELNojPTB6gJNDion6BkQrsJR+qJKtZTv6qXd/8RsyjQQ9OfknX5GNBuhpFS9B/djPVg7Y6qsZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPO8ZTW7Kce7So/mDZ+XpN0ANNJtiHYC1pkP7m4caF4=;
 b=CSxTxet4ICLbe10xiVDW9jiyrNMR4fTKW71gkeXp1KVCnw2FMFz7nX7qE+yNE6BjeQOpTL2USGfOTo1Kkp0m/P5jOc2J+EcTzdG25NiGHuQosYlZapgKXtDm/dcKW+MYrMP20lraINyOoMlc/b1ohE5hFYMEPeXgOe9lXwbgpj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 01:30:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 01:30:28 +0000
Message-ID: <000161eb-a6f7-4715-b8ba-7c2f4758d0f0@amd.com>
Date:   Mon, 27 Nov 2023 19:30:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: disable USB0 hub on ROG
 Ally before suspend
To:     Luke Jones <luke@ljones.dev>, Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231126230521.125708-1-luke@ljones.dev>
 <20231126230521.125708-2-luke@ljones.dev>
 <30293382-2287-45a2-9269-55d547432085@amd.com>
 <F1VS4S.MV0FEK6EB3K22@ljones.dev>
 <e583fd64-2cff-4595-a559-a675c6f5ad0d@amd.com>
 <fb8ebdfb-fc53-4343-8df3-96f04b405ace@gmx.de>
 <1J6T4S.AGCT3HWF4DTB1@ljones.dev>
 <75db5770-fe31-4569-bab5-1f259223506e@gmx.de>
 <3Q7T4S.YETEEQF4KQOU@ljones.dev>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3Q7T4S.YETEEQF4KQOU@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcf955f-0d04-4d8f-d557-08dbefb19a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BECFi+rZRGMRfDTqJPOqMt4ZCKdNXMWpDM0d5LBcayPbIZEiS0CoXLTlIRU5ZLKMMjzkQI/tKaE0g3RJaYK7HqEENWP5OFhzjJQbHXp60kN9SLaQrBkA3T4BEllORhE2NOAMNFGXi8NHvO8IDM95TZE9myeTaXPQiluQZrkgTNVf6XvPWBBK6D9r96/wzwnS71B/5Q6By+rISiVu5yv18vKKhHYWrI1Ub3ZkeHeCa/NxUJMWBhydY/ilU6+H/sUgG0RzyP4h4pK/eYUAQ/BwvDRLx5aj5a9DR3s/wmQlQwTypOc9kCtsm2Z4DEmJTEDJYzZueLBrY1Gmr0gdP0+BeQSKY8gns4ICkVGXawk+qaX1OFDRrsNGsUjHeC0quEvDqRO5C2F04T94g3KNCkkU/kREDzJKACLr5E5TwbRHdk5562hBdYzVZ0+u8zyswWL2K6wtK44K0FZ0zd5LY0bLcIj/uj8PhFXtnDvTMfR8JJZTXk9wahHfQb21KxBYwHLfJNU4qSWT1YLsN4ro43AdgpiWHzP//UDJOeRxi3AuY+87+khRFNbirU3uwWKXdfaq062vdQBvCNQ4SccpLaBMG0ML9opXO163WSRtCnI123VnQ6UDXUym9J1V8sWwkY7UJo+mdMBBSH4rq91oHt6RXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(316002)(6506007)(53546011)(6512007)(31696002)(86362001)(2616005)(26005)(36756003)(110136005)(6486002)(38100700002)(478600001)(66556008)(66476007)(66946007)(44832011)(5660300002)(2906002)(4744005)(41300700001)(31686004)(4326008)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1UyNDhOS3pNRFFCUDJWOXhHYWpmOGQwVU9GeFAxV0ozRzZKcmlJU0I5SHpB?=
 =?utf-8?B?bWFJWWpRbUJzeld5bjA5SVJ1Q29ZTnZDZnlFMjlaam1kUnB3VFV1dkQ3ZFNm?=
 =?utf-8?B?SnpXc20vRHZmUzRhc1Q4UytSRVQwNjd1WVc1MGYzSG5BR09tZG5OcUZqUXgw?=
 =?utf-8?B?NmQwekRUTGVLeW82OXBSWUtNYTl1VGZZRVl6R0cwL3YzU1dES2x4MlhjKy9T?=
 =?utf-8?B?OVF6WVdWTU1jUWlCQmRmUitSNTNYUHppQVJDcGwrdzNxQVAzd3NleHJTbWtt?=
 =?utf-8?B?NUk3VVhlc2k5WXY1a0N3VmdXdlVyYUhGbm9USUVrRmJjcGF1ektNUnZsb204?=
 =?utf-8?B?MUp4RUI0aFh2Z1VkS21Ed0p5U0RlMTU3ajFuZ1ZXRldzNEt3RkMxOUZjQ2VI?=
 =?utf-8?B?K1NRVG5XRXpVUlo2SEVmZE95UTdnczlIdmE5WHFmZXNMeDUrMEpKUm4zZTN1?=
 =?utf-8?B?enFCYlUvRDRwYlNVTFdpdXY3cDgrWXZNVTFrWkJoWVc5MExaMGkzQmF6aEVm?=
 =?utf-8?B?QlVUUDBIbUUvZVdLeFpYU2FRY28vcUhyWStIUjhGbmIxdjMvRVVHY1p4STJI?=
 =?utf-8?B?WHFOUUs3bnVwSnhoNVlJalpIT1o0dm5vZkVsOU1sK3YyTDVjNUhkQ2hPZEpy?=
 =?utf-8?B?ejRpQWJ5dDQwSjJLUndNODhuWDFjQUVlS1BhVHpaYlIxZGRERjQ4akw5bnFn?=
 =?utf-8?B?emY5ODJhMkVUVndPclV0eHhjY004OERRTFNNenJ3UjJxbG1keFNwU005clIy?=
 =?utf-8?B?dnVSVUdoc3VhM1ZiNkxDeW9iN0gvNnN2a1Vsb3RIYXV5YXpKcksxQWRwODcz?=
 =?utf-8?B?Z0F5MnYrQTlEWWwyL2VrazlvYTg4UzRyWHBHQS9nRUNURjdkdXBPOC8vVkhs?=
 =?utf-8?B?UHFydmh4SUQxb0N2cjFxdVN4Z3Z6NEhDVlowa1lXMFV3OXE2WDQ4cGo0ai9t?=
 =?utf-8?B?OEdSTXA4TkViWGZYR05QLzkrRmZBM05TdlVUNEIxMmNJYTRwcVhIREwzWlVw?=
 =?utf-8?B?SWpUSThka1ZKVEVodGI5WmpRbm43RTN4RlFvK3dOT25YcHVUWVBldnN6ckgy?=
 =?utf-8?B?ZzJLdWNMQXMrS3RRU05NYnN4ZjZ0ZTRYeURKM3VUTDZlYUcxMlFwblAxSXVY?=
 =?utf-8?B?elgxTXJXbHlpZEw1YUFMNFN6ekVUQlFPSDRHS2RPaXZpV1JnNUk3RlJQbkFR?=
 =?utf-8?B?TmxXZUdndTBnKzlVZjJFTkpWWGROL283Q2JBcmF2Qy82UyswVVUzSDNQWHNI?=
 =?utf-8?B?amYzN3RCcUw0Mk9hT0dVTHcxdGYwYmVDbUtmUFRuT3JpdFlYeEk5MTRPZWE3?=
 =?utf-8?B?VmJFb1M2YjV0NE5NbGtqS3pWYnBidWJJaWxoUXJCKzIvK3pCL3BSYTM4WWFN?=
 =?utf-8?B?aGVWYWg0ZUJvZW9jcjB1UEdaUkJNUmIzVWIwM2F2NmRFZUZPNkJvUENBb2ZK?=
 =?utf-8?B?ZXB5cmNKM0hjQXA0ZWFQa1NBcGpwYkxCU1ZncnRONWEwNkNUSis5alJZdUUx?=
 =?utf-8?B?cXJUUW13YkM1Q3orT29wMkF5Zyt2UUJWNWZhaEpJbXEwZlJBSElZRS95T1A5?=
 =?utf-8?B?cjVSODVqR1hNYlhTYmVDaTVud0dKN1JsbXV6aUp3WWNNdURQUXVDSVlrTDhR?=
 =?utf-8?B?ckJsMHArRTU3UGlsS1RML294d2JHaXZnR21vamI2ZFM2V0pzTlpCUUJpcmRq?=
 =?utf-8?B?U3dzYzh4OS9uUkptY05kZEsxaUgvbjA4QkdycW5OK01Wa2djc2pNT0MxdFV0?=
 =?utf-8?B?SEZveE5mbGV6QzluNVFwN0RMSnpxMnNmcE1sanJSOUx3bVByWkVlOWJncnpv?=
 =?utf-8?B?NFl6NlNZakJXV3pGcmVPVnd4OGxZaW4xeFBZOEhrYkR3N3ovVUZUSk1TZU1P?=
 =?utf-8?B?WUYzNUZuYUx4eE0zemYraXcwNUxpaW1ZNDY3ZHo0dkJDZG81TUI0dEs5N0dU?=
 =?utf-8?B?dG91SnRpbnMzemRhRDFOdGhtVkdVTnV2RlEwZ1hBM2s2WXZiTnZRYS95eWcz?=
 =?utf-8?B?V0Zaa2cwSTFqQTBQNnVVNnVJM0Q1a2RQOXZpRTBpWmE2V1ZpOHdrNDExR3k5?=
 =?utf-8?B?VU1HT0MwbVFWMnZEY3psb0tMUGh3Yk1GMkNQa0dOdkUrYU1OWUowN1pIQytw?=
 =?utf-8?Q?Ds59eO+xnqnuOGCr/6wNRyPle?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcf955f-0d04-4d8f-d557-08dbefb19a46
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 01:30:28.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN7YZNnujKu+IJ779835CX0Mh+1y2nHLiulQD6bXrNtGorfXMV42aL3e1AIYTL/S437Gp3jNbsAFIt85A/YL5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2023 19:20, Luke Jones wrote:
> 
> 
> Okay i understand now, thank you. I'll make a note of it in my next 
> response to ASUS.
> 
Another thought here - could they be doing this MCU on/off control as 
part of the ACPI power resource on and off methods for the USB 
controller and embed any required waits there instead?

I would think this could then be "invisible" to any drivers on any OS.
