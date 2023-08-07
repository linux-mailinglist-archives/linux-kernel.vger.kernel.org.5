Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9FE772D95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjHGSRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjHGSRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:17:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B7D171E;
        Mon,  7 Aug 2023 11:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apQRxuWObKZqFnt9XjBmSgj8eBEM5aKDlq/d1v3/Yej6ZmtY1p0ptp2JWru7zCMFna+pwjgCCZ9FgdF6c9XsWMn6vx4tYeEDhHSf5E0qc4L4WWyGnH/QJh8j47kkMe/TT6+mVEZZVbJlAV/KEakr2UiThI0n20BIjkDnGMREelMn89ws066l+ya55RxNrB95tetSOZ11urEy6YK8lKxEYMYymj9D7CHXMAumXa2LvHbiEuTnqGvZo7bRRcsR/DhHZHaY+DlecNWz2OoNqfDwyzVUyEG0sy+MVSHrKp1CipZPkuoI1leU87+mZsxlIvoII2/D6YzbQXUTrXngUy5gqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaNg0VaIGbepA5WQ7OvxDDFFOReNVw5/NqUmJV/L6xM=;
 b=XZjZi9Xj4Ge3RJMaLj+yoOc3gQCq+lzhJ1zGLLHfaqfcHqDj5a/XlRKwPmej2IoVp71/vKkZeREBP9A1GTyL/TqsO4WV7UlRMj3BbX+E2qjrCyJ8NlIEnguSfxf6LfuaXK+QZdMbFnvjVg2hK5M/+Fxs/AfAJiQ11stFBZ9KApf+JlMnlGWdwbvo6Up71xsS4/48gYlkmo3tFYA7YSSRA3ffbF/Cw3OkBljjsGPj9rcfL6q57Qi380FNeiI8yj/FwRZGJ63hrcpVTI7bfY8B6jNO94lf33/2HoJA1Mi76NxZ9kwpBrL9XOm+0pQALRlx5i7ZAX+e3LkgpTg8I7Ksig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaNg0VaIGbepA5WQ7OvxDDFFOReNVw5/NqUmJV/L6xM=;
 b=VxblXnB/hO25/qDa7HF6o/OIff+5H6tJsEGK2WoqgUrsFLPsHu9Np4CZPeZq5QXfB8qBbul4NZv3dYLpX3NLPabCP7Hg41008kFME2DbXAZo9LU4eb5cKZfiAGS+XsFawDxCD2elENj32ZAD0kvbJV5tE+vATximiHezBMDC4QE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 7 Aug
 2023 18:17:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 18:17:09 +0000
Message-ID: <87eada13-004a-4dd1-91fe-901cfdfd7992@amd.com>
Date:   Mon, 7 Aug 2023 13:17:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: amd: Don't show `Invalid config param` errors
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230717201652.17168-1-mario.limonciello@amd.com>
 <CACRpkdYoxoZ0G7QzQ7XV2FPh9gUJG-CKfpFY1xNQdbBcJOQ=3w@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CACRpkdYoxoZ0G7QzQ7XV2FPh9gUJG-CKfpFY1xNQdbBcJOQ=3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:806:130::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: d38ee38c-733d-4ba1-756f-08db97728398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9qOETDACSC+P6FWq7yDtABVS3Js67i/lVJ3V1cM8MULLyapUnQdQ5A9a7l2yxNCj8H6FjJdm6x4lB+G0SDupkJn3uAc9WOddmCwJSqKWN0dCAECADwSWryM/fPPwhaetCMLBHKkKIyGIvmtIx3FAkjRMzvzRRgRROnSLa3wlFECFVGoCPDb5cedf4bCGACKbErcowWt7H3cB0cRSRaqIDGGzcMdRPUVZC0WR/6ouC4d71/l7TP6D0ZLeNkk8l+qtskuY4cDipTNCwieTHA3sepbT6hM26Hc/SkCOEcg3RqAum+6XSvOR7drgxEJTzdXFhUgyvYGxswJ44HvFCnBUIidEEyu9EY6KgdiL5FW6fsDOxmbtPkx7Wz4BYXduHtrdyIlAoSPU7yedDQTcPEGd/lIPzNppip8UWYT9aZRd6aWAQHPGZvRTcLmyjAUApxfJfMpDo2LCIZRZDHBp4nMhhDo1t9MYKzcEuS/34OkZneTYjS2ztv6DzWeUPbrM/X997RTDf2cQWWY7BBehZipDAdEqu67wcATBlszneEQ/J36HoGOzZOxajavBHcpET2SKFGyqeGBFb+YoSEpVulY0E3HdRB7Tdr4bFluhlx7sfSzNT+apWMDX5HOEfrD9juaijpWD/Vf/svtqfsEexylNJa3SRz7Z58IM3MSZbgOjEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(186006)(1800799003)(6916009)(4326008)(53546011)(478600001)(26005)(6506007)(316002)(41300700001)(6486002)(6512007)(6666004)(38100700002)(4744005)(2906002)(44832011)(5660300002)(83380400001)(31696002)(86362001)(8676002)(2616005)(31686004)(8936002)(36756003)(66476007)(66946007)(66556008)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHU0VDg3VUtXR1hiWktQdmJyNnlSWUx0N2NuYnlkODI2eDR0TEREQWhmUE9s?=
 =?utf-8?B?Nng5Yy9ZRkVOMmNUYmo5alZXd1Y5S1BIcWZ1L1YwdUZyWUg4Q1dsMjBzdnpx?=
 =?utf-8?B?MDFDM3BVS285QWJrTWdDMVk5Ry9pS1o0OFlQU0dZUG5VTEdvb25xTjBNZThw?=
 =?utf-8?B?bG5ucEtROHdLaU9LcGR0T0Exem50eTlTc0d6U1hrTW5NdkpidXUwaUlhNkls?=
 =?utf-8?B?a0RZMUFreDBHY084M3FiVlZ2dTdkRXZNcEloaVNnWlpKN0kydVFsSzVIbjRo?=
 =?utf-8?B?MXN2d0MxQllheG9USDdSWUoxcTBNaWE3NDI5ckVWQkJ0ajkvSC9aTUtSbXZp?=
 =?utf-8?B?UnFMZGpkbm04M1NwNHh2SHExVjJMbmd5cm9vRVYwSHNTZ1hLSlc2aGFsbGJE?=
 =?utf-8?B?SEhvZGxiRklSOVhUblFrTTNvdEREYzVJVGMwdnlFVWhGZ0dHVU5OdVV3V2Fa?=
 =?utf-8?B?R1N0cGVWMDgrRmM4WDhqRGdQaE1EalFuRHp3Wkt2a1VpNkpRdlp5RFR4OHRk?=
 =?utf-8?B?QlBiM3RNRlFYZUZRaXFtb2Q5WXJiUDJkcEZ0VHdjV0hBSVNmczFvZGYyeHk5?=
 =?utf-8?B?RFptWnhHR2JnUmZBT2ZRRjJuRE5CMnZodlkzTzBpdE5MR3NkczR4YnprVjJ3?=
 =?utf-8?B?T2g5SFpVRS8xcXlHNWtLdlU3cFVNMUVBVDVLeFQwQ2dNVm1BQVplYTlrUVk4?=
 =?utf-8?B?RU9iQmJPN3RaT2ZNRk9tSEdGVUE2dytvMVNhd3FPYXk1enlmUTdHSE9oazlt?=
 =?utf-8?B?M0RWWVl3aDdOVVhjclBCUkFBSjI4UWU2aVRnV3lmMExrYTZWRmk5TzJTYzVS?=
 =?utf-8?B?djRTR1NKYnBNY1lUSStqajFnVnNCaXlCM3BrakxXaElPRlJDM0V2ZitJY1JF?=
 =?utf-8?B?OFRVeTVkOFc0QnBUNWs2YTdVODVnejRjMENZRzdIQ1g5SDZYZU1WM3FQTlJw?=
 =?utf-8?B?SEk4OE9zajdnZ2xYMWp6MnJodmNURnlJbFlFYnkvUUpwcVBMWEZOeHVibitj?=
 =?utf-8?B?REhNUjRmcWNoY1gyTDVBbFBuc21qbXRxWldxQ09HcWtpdFU2L3ZvZlhGbTVy?=
 =?utf-8?B?Y3FlWnFsUjJrMXUvaGpPYVpaSFJld3MwdHN0ZHFDd004TTM0eC9BVTNMUFRJ?=
 =?utf-8?B?VG4ySUwxdjR2UHQ0Qm5DMklQZTVmK3IvNE1NZ2NDZ1B5TlN6NFVQemYvMHQz?=
 =?utf-8?B?MDltWUNyRldCdllFZ3VZOGhvTnV4dXpQNUtRNUgxYktWU0YzY1BmdWZyRUJL?=
 =?utf-8?B?UlZRdUdCU0o1ZDgycFpTZHNTSjFjQTVMazMxMzhzM0t0by85amprblpOSDJi?=
 =?utf-8?B?VDB1RjA1bEsxanhoWC9zcVk5TE9Tc0dWTndjdERLNXI3elZTby9PMm9jSURZ?=
 =?utf-8?B?K2NSSmtSL1N5RGtwM25Rb0tySDdZM2QydEp6eXdnU2toNXdJYVEybU9nRlNB?=
 =?utf-8?B?RU1yRmdCZGZuZm5PSnBlQ0ozKytJWWNSYW8yWXFWbGYyeFFFWHFlZlQ2Wjgy?=
 =?utf-8?B?R2RueEFLQ2hiUWlUb3YxdVhoOSs4bFVzVXVGYm1DVVpVUXNmVnlMYW4rNklR?=
 =?utf-8?B?bVdMQ3VvRjc2Y2NBQ203dmYweldWVk5wUGtBNWRrbWh1aEZGZ3V6NnBzRUsy?=
 =?utf-8?B?c1FvT0htQUxuelhXKzM1SU15NXhoSVBudEtGOWxERS9BRDBqYXRkOERUVjFU?=
 =?utf-8?B?YnlOcEt3RUlvUWcyaGNaU2Y1RDVTZ1owdzgrNnRaVjlJTjk0K1haVmZmS3l2?=
 =?utf-8?B?ckFPaEtpUzJiY0ZPakgvTmpmUzVTaWl1UkNleENoV21kNjFiYzJmTWJZMnAw?=
 =?utf-8?B?OUcyaE5ndGQvTURPcENQRktmWGtqbU5YaGVQS0tDUlQ4eENMLzU2VU9pei9Y?=
 =?utf-8?B?UnI5Ykc3d2sxMXcwV2dLR3Z5K0pLL3NnN2tWU09rdUFhdlhBWlhDUlhBejln?=
 =?utf-8?B?Y0NLa0pDTjgrMElwdGZOQkt4YkRydFQzRWZHbkdMZllKZndkZllqdFdnZWpy?=
 =?utf-8?B?ZmFxZUk1bUZCOS84QWppcDJwQmZlRnZJL3JLWlB0NW1WeEwxSC9MZSt6TXM2?=
 =?utf-8?B?M0pMV29zem9tMEtrR1hDbGFVZWhxNkE5YUYvRC9zVVZidE9XR2ZoanV3OTg5?=
 =?utf-8?Q?gG+STfsLLdKCMF9Tlke9YPq/3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38ee38c-733d-4ba1-756f-08db97728398
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 18:17:09.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +D4JHpC3nHklZ0MjBgIb9Onmbhq1wvMDSNKKE0WwrH5xFidqCBI+fYx6LBLv6wS9g8TCW/xMx261RCJpxTyfLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/2023 14:41, Linus Walleij wrote:
> On Mon, Jul 17, 2023 at 10:17 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> 
>> On some systems amd_pinconf_set() is called with parameters
>> 0x8 (PIN_CONFIG_DRIVE_PUSH_PULL) or 0x14 (PIN_CONFIG_PERSIST_STATE)
>> which are not supported by pinctrl-amd.
>>
>> Don't show an err message when called with an invalid parameter,
>> downgrade this to debug instead.
>>
>> Cc: stable@vger.kernel.org # 6.1
>> Fixes: 635a750d958e1 ("pinctrl: amd: Use amd_pinconf_set() for all config options")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Applied for nonurgent fixes.
> 

Just wanted to check if you'll be sending this out for -rc6.  It 
backported to stable and a few bugs cropped up because it's noisy.

