Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A21768706
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjG3SHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjG3SHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:07:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B42FB;
        Sun, 30 Jul 2023 11:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E91TtV78X/nNP96U2/wkwUnubPmAjZj8yqV8srGrwMiir8ZjVrdKB0rJ02k7uBUsMZg+Lofj5G2bipAZFY0v3Maz1PqJBmjDHt2ppRwdLArB5GxOYw0q+2z+VMG9+xbyiKiy4N1U3y2KS2WhZcT5YzYD7HFun1ZAyKyekk8uLA108xvymfPDpcRHveaMuMFWtvcBODUJHJb3AdQeKYwv0jdZ9+DWKqN+vLJK8WPjdTSrEFva8XbJp3oEOZqOrolhUNDXkTer5XoVy8RqcgCw/A+e7cakPLXbLPdYrajyiNWuxoDxLJdzczaxJLDFL26Ewd5aNoIYhTAJdBHnk77TnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPh0gxzj70QehHUK9sBYF+98j9MnUc4ioJ0QN2dJsCQ=;
 b=nUDIEQKEPX/DRc1jckNod7e3aoMZckVRl3p0E5DkzNvG3c2tmxqcFlHgEPyGxJHWwCf6W8XNw476SilHHm9GKrTqBLAE975yVL14t+0t+GDAoC4N6YM/oXOUEsENWnPyuiEmRZ70qgSW9S3R4XCVWQ3cbTj5B4B6pw2r25mqDx3rE8d7WNuFpnXDzucHLC8QY0yEvRJSHJQjAfPDnsLucDqB5yE8oJM4MjoQpXzRhvxSH6BSXowacnNd3uKK80MVX/S56ZoqpuxkC7Dy34MbLD0ZleU6+4ThuC1l6SUZ4YYQ1MJtIXRT6GYF1PJ96Lgw6Y9DKLg6FWxkR3nR7X4Wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPh0gxzj70QehHUK9sBYF+98j9MnUc4ioJ0QN2dJsCQ=;
 b=HYnLnMPdc96McYrXWjcp5OnPGr6x+rmvLRBXzo9hSYzGRRfbTot0HwiYwRAEucP1TKOSd8o3BSC91ZOK/F354KOBj3/NGtlMjWdvZMrK70Wi4bWQySmdWog1iP6LUPtBJGwX+xfcZ16RF+xcbgD+lB24iR3OTrQ675Ljeh3hxo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42; Sun, 30 Jul 2023 18:07:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.041; Sun, 30 Jul 2023
 18:07:44 +0000
Message-ID: <043cfe60-d881-365f-8257-c9b35677f6ce@amd.com>
Date:   Sun, 30 Jul 2023 13:07:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: 6.5 - 6.4.7 Regression : ASUS UM5302TA Keyboard don't work
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Linux Input Devices <linux-input@vger.kernel.org>,
        ACPI Asus <acpi4asus-user@lists.sourceforge.net>,
        Linux x86 Platform Drivers 
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Guilhem Lettron <guilhem@lettron.fr>
References: <bdc6cb4d-a853-72b2-b132-989b64740ad9@gmail.com>
 <8ee87fe1-684f-ad59-21c7-4401a4e70bee@leemhuis.info>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <8ee87fe1-684f-ad59-21c7-4401a4e70bee@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c936e92-d042-497e-c5fb-08db9127df24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwYzGf45eUbOsOIxyOMAcm+dgXO1uGxwFGCQlQZuJFkpN65QdivcCbSV9A4KcnXqLBaL+X2Soh08dLq4Do+KPdkjn7usMYZTjz5pWcBN65egluPEHX8Ve7fcFr5Re3Kye+JurNoIRLy/vEiUNUEv5MTHnmsUPZ9z7qMMiCb/BXg7O+JJGJTqI5cl+iRIan3vYcgeJfLz6u0jphEC5gte08H4YUuV8uUP78HqN+3d/TT8uIduYF30hPapOtqh7WjBRP9DLhdzITO3XX1LFCcBaC9N26nN0uWj26ZVMEhmzaQYpXM9jMBRKN4NRJ0P/BeWnnrAbjfLnSmJxMRaMRmXGMIJSS9zchY7SOIWXqIVHljLhE0elm1a/OhC1fuc+M/M79PU0MRv0zbg2W59YYAZodWtInvqTnlf2swX0kvKkApDLHYgIx8mo7AurR/yFRuGLPElQsFSs3xkVHvJwytria+pfGgYn8uckkjVLxxSozXc05JAOn7BbANY/ls+GWwNGBktWrp/2ZXlSFtasTPZu5qTXBdlc9mlu5RIfurPia8frK9bJYHF/NA1zvPBFHw2/U65rRaHmbj4GAArWwn9pGzRWTYnshZ2FvG3V1VvHya2zCg7SsQrKGi9Qj+Hh7bg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(966005)(6512007)(6666004)(6486002)(186003)(83380400001)(2616005)(36756003)(86362001)(31696002)(38100700002)(6506007)(53546011)(5660300002)(41300700001)(8936002)(8676002)(31686004)(66946007)(6916009)(4326008)(66556008)(66476007)(2906002)(316002)(478600001)(54906003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdzVEFjZFZLTEd4c0tvVm9nSXorbnZxc1BVSXBzMHFSTGEvM05uTXdacFZI?=
 =?utf-8?B?K2xoY21kTTd4T3dkNk1uazhycFJ0VCtXVHd6Z1BUcjB0bXZTVk9ZQ3dYWVJr?=
 =?utf-8?B?RG9LNCtJakhFMEh2VzErSGxucDQyT2VMZHEydWoxUEJMSWZwN0lqWWUvMXlF?=
 =?utf-8?B?VTNOSmovMzhvWTRGUkdEQ0JQZnBJZXJXUXlRNzZNWHFZYy9CdzlUaVplOHUr?=
 =?utf-8?B?ODlFTmd2bSt2VFlZMmc2OGorbHpPR2I4TFF3Ujg2Tk9hazl3NU9STDhkdUNl?=
 =?utf-8?B?NDA1cFVXdEV3MHQrQ256ZGpEZEVZQmlLZzBVLzByclFoSyt3aTF0Y25WbjNz?=
 =?utf-8?B?M2N2RHlVVmJCdTJGRzF6dHQwM2xkekRvOHlkcXhhV1R1ZWplaUQ3NFdHZHJo?=
 =?utf-8?B?K2pLKzN1T1pLVHA5TkRGb2M1QlVOT3ZQbzdET3pGV0szTDM1aENiYVF1NnRl?=
 =?utf-8?B?SStGemdjQkVLdjMzdjVSeC9SS1R4c2E4Z1pZMVcrTWREdHk2TVVwY3FwUDhK?=
 =?utf-8?B?UEN3end6Y094QkdHWURXNnk5TjlxUGhwekxUSnA0MVhUWGFHOU5ibTdJM052?=
 =?utf-8?B?NXcyNkxkbkpaWCtjUmhkM242b20zblk0YkZBdnQvaVdjMkw3K2o1ZUYyNnpS?=
 =?utf-8?B?T2JLaVpoeGxLTmwzL2xFZzJLMmFGNFp1OEwwTWY0N3UvTGdnejR4dldSOG1T?=
 =?utf-8?B?ZWx3aEZ0Q0NTZGd6Z1ZTMGl0RG9UdXNnUDJzTGZYQ0hTaElob0w2cEZIQXdm?=
 =?utf-8?B?QTdFL0VRV00zckhSL0N4a2dLYUtGOVNRV1hjVmUwQWNPa1NUdEIzcVJnK3BI?=
 =?utf-8?B?WEdZUFNSc2kzb0hiVmg5b1VIQUoveG5YbEVTem84ZnJpSXM0YjhsL2d3L1NM?=
 =?utf-8?B?R1B5NnpGUWJ6N0RZWWhyVTRRWUxJbXEwb3MxVndoNmY3SS9IY1dTSEFuWXc1?=
 =?utf-8?B?U3p5eFdscUNlSnlNMWpkTGdQZnZ6bmlSS1FwWk12R3IrekhuajcwZUVPOVht?=
 =?utf-8?B?SWNydnZxQ29DZHN2T1IzUFQ3WGRsakU1a011ZC9DMExMSGxsNURGRDRpTzgr?=
 =?utf-8?B?Y1VoaHFTREp0aGQzdk14Zys3UEtWeWQrYlBnR2Q3Y3p4cFhXUDBzakJoTTBh?=
 =?utf-8?B?NHhkTzN5UTN4S1ZwSUZtck5RYVZSdlBvQ1l1NnhodFAza09acXEvVTNYQ01I?=
 =?utf-8?B?QXQ5RWs4aEN5ZmVCKzUxeFM4NVp0NldmL1Q5YnpwR0pLUjdGeTdNa3NHZy95?=
 =?utf-8?B?MlA5anRKU0FhT2wyTENBaE9QVm4rM2VzM2p2dG44OTlvWFk0SExQWkRtTlZW?=
 =?utf-8?B?UmwwZWtBRi9YWHV6STRXS2xuZi8zTS82ZHZqalhGdVRBRTlBNGFncndKaElU?=
 =?utf-8?B?Y21Yb2JFOUtNQVV0VGhTTFVKeVRGYTBUY2Nqd0pWd1NudXNFcStsVHBEK0NS?=
 =?utf-8?B?VjczMlpPd3F6akhhREJQalBZZ3JybTZPQWg3QitUQmxxVzdQd3dobG5VejBS?=
 =?utf-8?B?ckNYakdReVJXdXd2T2dhbzFLcHBST3RacWllV0NITmxPaGxDbUo0bXZzUFpF?=
 =?utf-8?B?bkwwZXRvMWkwM2I1TE5WeFBTdTU1d0NUVVJJL3JkVDlPWUZoWW96UjFyN1pn?=
 =?utf-8?B?ejdHRS82SXd5ODU5cmtzVDJTVlRiUzZJQ0lzclBzOEhjUnBNRkc4Rkl3ejNN?=
 =?utf-8?B?YzBYVDNKVXJrelJmUWZFZ2U4aVB5N24zZ1VPK1pyVUsvaDhrWW9YbWx1Rk92?=
 =?utf-8?B?Z3J4b1NsM3UycFVkOW11TnBEb3RrSllsckc4ajBDUWdmd3QvRTRFMGR1UDJG?=
 =?utf-8?B?bHpEcUdNQldiYlh3YXAyZFFTNWl3TnpySEp0ZjhiSWJkMU1BR0t4Wlo0V05i?=
 =?utf-8?B?ZlY0RlBvM1FaalFLK3VZZXBhaWk1ZmxFYjlrOHg4WHBZcm9tWEgyR0cxeS9Y?=
 =?utf-8?B?dkRXZkkveWIwZ3RRQmFKMmU5U09ja3FUTW1JVk5rSjNraEN2dlpEZEszSEti?=
 =?utf-8?B?N2pUM1RUSXpJazdTdUxnajMzRUF2NG9ORkRzQjFBelpXRWMzUm1VWEI0c01Y?=
 =?utf-8?B?SGZTQzZNRHFPMVVGdzJ4SC9Fd01pS1ZIcWZaY0dDU3M3Q0xaVlI2VTAxNUND?=
 =?utf-8?B?dUtoNVlUeElieWt2MU44enREOE9Ca3UvMzlGV245TC9ZZ1RVMi9ZcWpWVWVG?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c936e92-d042-497e-c5fb-08db9127df24
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 18:07:43.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyPm5AFTl6vo+79vGsXIjdgfgfENimBwFaf2IC6kqWCx9PhGyZHNMWWH1W9+5Kv777iUcyM5HSCCtaW5NWLF5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/23 23:49, Linux regression tracking (Thorsten Leemhuis) wrote:
> Lo!
> 
> On 30.07.23 04:41, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> On a kernel 6.4.5 and less, the keyboard is working fine.
>>>
>>> Beginning with 6.5 rc1 and 6.4.7 any key don't respond.
> 
> That is a AMD Ryzen Laptop. And if that really started from
> v6.4.6..v6.4.7 then I guess there is a decent chance that this is caused
> by ```ACPI: resource: Remove "Zen" specific match and quirks``` from
> Mario. Hence adding him to the list of recipients.
> 
> Guilhem Lettron: if you have a minute, could you try if reverting that
> patch ontop of 6.4.7 fixes things?
> 

That looks the most likely to me too.
If it helps, I would like the artifacts I requested added to the kernel 
bugzilla.

> Ciao, Thorsten
> 
>>> [    0.668850] input: ASUE140D:00 04F3:31B9 Keyboard as /devices/platform/AMDI0010:01/i2c-1/i2c-ASUE140D:00/0018:04F3:31B9.0001/input/input5
>>> ...
>>> [    1.930328] input: ASUE140D:00 04F3:31B9 Keyboard as /devices/platform/AMDI0010:01/i2c-1/i2c-ASUE140D:00/0018:04F3:31B9.0001/input/input13
>>
>> See Bugzilla for the full thread.
>>
>> Anyway, I'm adding this regression to regzbot:
>>
>> #regzbot introduced: v6.4..v6.5-rc1 https://bugzilla.kernel.org/show_bug.cgi?id=217726
>> #regzbot title: ASUE140D:00 04F3:31B9 doesn't respond to input
>>
>> Thanks.
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217726
> 

