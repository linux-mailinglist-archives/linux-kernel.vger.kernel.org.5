Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741607B0502
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjI0NNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjI0NN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:13:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AFA10A;
        Wed, 27 Sep 2023 06:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAipCKZE6sQnvDsxrGmERKG9HWnOdMKLedcxiwXka04d6BOUaUwlkCjVDOw4NReRyt7qwpCS8f6soq1ppC4Z870URIr3Y7ZEKukMIv70jk5FPYus4rqhfKfSRbt7iIM9fpJf9X2K3zj2GTtMiRF39L/UCt35kykN4rOLPqSp0fmL5bDWrw/vuvDJyjChES/JXZuwTqJuioYwLpLXhcHQk0iVs7ZmcDFnFlqajaknBYmAkQJ90PQa98FIKaLIOD6aGbqMuz6QA6zjbwtb2pN7lzq9eROSpffspGQVfIedDWKuX173II0rTsoLgL14b4he4RabeCmTLVIeRnai0v2xLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9A8k0/EEs1QcYY9TRA4PkWlzcU29nDQhADFQLrtBrU=;
 b=d82otQrhjHJzKHI6BljXvYFagohHdC5uPG5PaO/BTW8ZYbBz+JrXGbth1QHdewRR7QMm7UQr15m+u6ycTBrrZY1Df5VGeSd83v2w0iBaVP3pDclLrti4ugbKjdWyYQ9nNP7sclO3Y3aklOkNyp6hnx9dqqJGFHDWM7O9YgUmHNepDdXfIfLTuv23d3RVX2hbYJ+xjfjlNDwPYZUvc4mf4J0QQ1Jx4WY92JfPaL4EV62gRMjw9CTWO4TBlcV11AyChF7V4q0wL6PTGKAmBttj5WtRxcXVx2mDbp9AE88wEdnfAB+iPAuhXKRPo73unUgLoCrLDt1mdDRIIsvFxkglDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9A8k0/EEs1QcYY9TRA4PkWlzcU29nDQhADFQLrtBrU=;
 b=zlVaCdJn/caMmfPggsaURvOpmr1RE6rgyrosVqZ9PIqBa7ZHhKE2dvqthVWzFipDgMIuklOPPwIZWW/Ti28lDomGgoe1Wq+ciCizYMXdSZVFBSzGI4Y6FEYr0TH131Od6q3+NVMxGf6Jf8ao01dJlvYU/evCJXSeG/SVCJYo2+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 13:13:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 13:13:23 +0000
Message-ID: <a1070c38-5a06-479a-bd3f-35bd34ee9fe2@amd.com>
Date:   Wed, 27 Sep 2023 08:13:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: s2idle stopped working with 6.6-rc on Thinkpad T14 G1 (AMD)
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <0d84fb59-4628-4c7f-ab1a-f58889ef2c9b@leemhuis.info>
 <e556ae63-0539-4b34-b33f-5f5beb4183d1@amd.com>
 <e049aa41-b136-4071-850f-d06b47fe67a1@leemhuis.info>
 <5f753ef4-caec-479a-bff4-43c16fb3317b@amd.com>
 <e3cc6486-48be-46fb-9850-32add544530b@leemhuis.info>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e3cc6486-48be-46fb-9850-32add544530b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:806:22::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3e5a6f-87b7-43a9-a080-08dbbf5b86fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3QctND8UFl93KJucObtJdzDWgJlkJxiB4CHyZGa8kTim31Hm1FcelGH/eWmZ811FEpwAr7jJUrhtgsBFHfoBOxRu5dNiR0UXMTJ/5ervHt7qznClqmID18VO8bdODc/3PcIu5RSrGqnO+NdfnX8sfTvPFXlEA74aGoJF7Yn5E1UMWIkbSf+x3nJvl7S1eaXrKEnbWv9HLCAmednXHV0DGPGoIoJkh7fTsJ1A2Jaxjuh5veSI0Ktfckjm/5v/e3i10f5OEnt6ZELJlKZ6O2tdV+UqApaXock267ORffspDx3m5tvzrPdO7CV/bdf/zGDtPmQIEZ7pp3x3KQpJo/FjzAG9f19HzhMpjG3LUsIoNreZQ5CsUhrAoKdV1rDdFC1hsaxCO3H+yEq3G4KmhpFGgTo7sS0JR3mVqAt56oLwqe+QjYN8PzIB7g1TLXOD0jKc7sCHbL+lm1ZeRd44ziD7gpPDc9mITWFdFoIR6qIn4VWa8/nPl0QmEWxSFXDZBQxOKmjikoQlupD+JjTzxbvGBD22aR1v2ur+0XLgKbE3mJ8ODbWJ3DUS5WAiptB/kNtqoIsVp+fUqhR4b2H0/zFvGcsNXwSzoLchwBiwC7qFvmoEw1GAhh9w5eMrY+W1tokwsws1YOJLiEt+M3nVj7HDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(6512007)(6506007)(6486002)(53546011)(966005)(478600001)(83380400001)(2616005)(26005)(2906002)(316002)(6916009)(54906003)(66556008)(66946007)(66476007)(8676002)(8936002)(4326008)(44832011)(5660300002)(41300700001)(36756003)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVVMeldhMEEyVXdwcDNLWEVpZWJjdjQ0WTRoMjg4Y2JCMlROL3kzMndlb0VP?=
 =?utf-8?B?aFNMQlIzMDRVSC96TjZTUWUvTElCUDZWL0t2TnB4OHFibWhNRXkzdkl4eWRx?=
 =?utf-8?B?a1NtUWxMZDcwMzduU29aSmxJSHI4TEtxOG1zOVRpK0hGTzZ5blhNMERjNTVQ?=
 =?utf-8?B?Tm0vUEgvbHVndkJKaUp3ay9kZzhqbkFKWTMwOHFHbDJoczljZEk4eWJKekJq?=
 =?utf-8?B?ekEwdExDTVVJUDV6VzNGQ1BCMlUwQnprdG1SSmhPZHVJNHF4R0hoQy9VTjcw?=
 =?utf-8?B?TUVEa0dkYnhiNFdER0czZUc5bzdGa09CSkV1aCtCSXdWOWtRQUNqWlNHckUw?=
 =?utf-8?B?ZWN0Rm1KR1NoNUxHM1ZrNDNZOUpUdXhHdFhPSlUyMGVLNHdZU0FMWlpMbEcz?=
 =?utf-8?B?RHhwQ2d5aGJWenh3bEh5Z2NFQ0phbWlmVFNlQUdoZGdVYVp0RUNmaUgrSGZT?=
 =?utf-8?B?NnBLYU5zMFVzcndLWS9jY2p5Z3ZRYVBwOStsM2g0dVdlZFhUcUNMa05TMmkz?=
 =?utf-8?B?emY4N2hNZzM5akg2TVlWbzFxRVFDdUw3djR2a0ZDUFpaeThtNXRDQ1d4SG1V?=
 =?utf-8?B?eXVrSDVuMUZ2L04yNGdKUjRtRytuQnhET2EycEZIb0l4MTczQzJHV3VCM015?=
 =?utf-8?B?dWY4QU1TUGtwbHFLOGxXTWJHc3BCTVhKQ0tiVW9tZjg1eHhvaEp2WHE2R0pq?=
 =?utf-8?B?eXdmWm9wckJxTytmdUoyeFNPM2V4T1JVRUNOdmIzdzhQOGJJbnhNNHB4cUl1?=
 =?utf-8?B?b0lPcHllaU5ibXNXTE03SHI4VEM4ZmRkSkpTWHFieDJCNjB5TzZxWkxXSkVT?=
 =?utf-8?B?d1JKMFlSN2NleW55Qi9GUk45RWJUOUU4ckJrYVJDZm9xZTJtdlcvamdrZ2tw?=
 =?utf-8?B?ZUI3TVdONFNQZHJta3hlTVdWU2JjT2RWM0tGMjZLYVc1NjJxazdMOW5DYk9B?=
 =?utf-8?B?Z2N4WDFGa3Q0MXlONkZPcUxTWGtZMnc4YThDRkxMLytNWWZtUW41dStaYWRX?=
 =?utf-8?B?Y3BTdG1uVklEaFVGekQxaHFRVG1HWkU2ZWdkdmhNTlZSRUxTS0JoWG9rZ3hL?=
 =?utf-8?B?Skl4akU2b3hwNE5aQlJBRVhvUWRrTTFpb01DaW9ybTA2b0QyV0s3S214V1Rj?=
 =?utf-8?B?a2Qrb0NHRDZWRFUzZEtXdU1VNEY0ckhFMHcvVmJGWEt0MjBqUlkwK1E1Qk1U?=
 =?utf-8?B?VzlTUHhvZW5HSU41YnhSak1TSU1udG1WTW1POEFMU2hOOXdHQ1JxQzdjRUxS?=
 =?utf-8?B?cTRqa3FLTDZzR1YzQUhWb0t0dHNCdWJCQk9MdmR2amw0SzRwdytYb1gwSmZQ?=
 =?utf-8?B?bmczeU9lSXppSjA2QTh1d3RmUk1TdzV4Zkw3NUhSTlFaMFlySmRzOHZuSDA3?=
 =?utf-8?B?b1dmMGxaWklLTXUzVGhZRXMrZjRkSC9YTGVDa3dCT21FMFp1OU9IYjJ3L3cw?=
 =?utf-8?B?MnNoQ1RTdUxmZm96WTBVWVgrNThvcXltT0F2NDBqRURaeC9xT1lQMTF4M2VP?=
 =?utf-8?B?SHBpemVYdS9kVHU1VEcxVm45cDRVNjVsSi9qWnY3MGFJQThMYlNGdGQ4MzdO?=
 =?utf-8?B?eEtlTXRraTh0M0ZWSkNyMCtBeUIrbWtJZHJUZDdNdnQ3TUk5ZHNZcEJXMDRr?=
 =?utf-8?B?ZWtrS1BRY1Y3RVRHbkpJeHhGYzhRa2VWcUlKa1BLK1ZqVzA4cjZXSlBRdDhB?=
 =?utf-8?B?R3dLSzFmY1U4ODJtWHY1U20yOG04bU9oOVJkeW5MTFp4VEVRYTBSQm41WElK?=
 =?utf-8?B?aUhQT0ZXUmhsUmlwOVhlc2ZxcStrWjlGRmp3RnJOdTgydURtZjQ2UWNEdVhB?=
 =?utf-8?B?cVZ4Vk5KNU5wUmNkWlJRWUZYSnVpTXVyUVc2Tnc1UllYZXJjRVpXTEt5Yi9a?=
 =?utf-8?B?K0dkY1QwbkVzNjlHdlJOT2w4WmZSKzZ1Mi9uL3JuUzNXR0dva1lndWVITnZi?=
 =?utf-8?B?SnRpcm1Pc2srZVhPOWg2MkVEYXBzcG1LZDV1aS9ibFVHOVJxZEVOL1JPQ1NO?=
 =?utf-8?B?TmRZTGJyT01vOWtpSU1XeSt6Ky9qNjcySmlZRWc0czZhZGlpWTdIaVJpc3pz?=
 =?utf-8?B?M0I5OHZ2QVhGVG1hUnJmZEE4NHJNT2RYL0xNWVczV3N2TnN1N1I5VFNWd3ZM?=
 =?utf-8?Q?BUMJG2k4CtD0Ezl3aFIIwul8J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3e5a6f-87b7-43a9-a080-08dbbf5b86fa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 13:13:23.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3iAV3yijDsWOS7VIUvz/UrVroYFHYJ934d9qdtRb27+EVwHfsa4Y/ZPkRex9XFLsR/4J4drK0Zc60XaTzYbvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2023 03:57, Thorsten Leemhuis wrote:
> [one more time, please ignore the previous message]
> 
> On 25.09.23 19:44, Mario Limonciello wrote:
>> On 9/25/2023 08:45, Thorsten Leemhuis wrote:
>>> On 25.09.23 15:25, Mario Limonciello wrote:
>>>> On 9/25/2023 05:55, Thorsten Leemhuis wrote:
>>>>> Hi Mario! Did you by chance hear anything about lock-ups on resume with
>>>>> mainline affecting AMD systems? I'm asking, as s2idle stopped working
>>>>> for me with 6.6-rc on my Thinkpad T14 G1 (AMD).
>>>> You're the first report I've heard of this.
>>> Thx for taking the time and replying.
>> [...]
>> FWIW your email prompted me to double check the two other Lenovo systems
>> I have on hand at my desk:
>> * P14s Gen 1
>> * L14 Gen2a
>>
>> One of them had a Ubuntu userspace (20.04 IIRC) and the other a Fedora
>> 38.  I built 6.6-rc3 and couldn't reproduce any issues with s2idle.
>>
>> So yes; bisect is the next step, thanks.
> 
> Thx again for your work.
> 
> FWIW, turned out the problem is caused by 92e24e0e57f72e ("Input:
> psmouse - add delay when deactivating for SMBus mode"). Guess it's a
> timing issue. Reported it in a new thread:
> 
> #regzbot dup-of:
> https://lore.kernel.org/regressions/ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info/
> 
> Ciao, Thorsten
> 
> 
> 
> 

Sounds good, thanks for letting me know.
