Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228247A28B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbjIOUyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbjIOUxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:53:50 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036A635AE;
        Fri, 15 Sep 2023 13:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTjrzfMkH0MbvHO23y5w7CRy6jwaEMe4YMFh1RHOrMh/503rfTghbfMREFVJW1F22IPkuMUxrUHASeXa1kB1/pJ8I/a4f/kyWtRt3rA565fvjvnWiD6Z8lXLEAmL4EgDJsa6Uh24cs5Rebi62lOqjknYIg/oiHQRQhP1jNjGmYERjwt/t4bwO0PT1lZUyK9VVKugZlzh2RlKXFYRjZwpWha1DpgtQFw/+Xca3yB3PFUE7FR2VynsqIESA37/67Cp+99A4Ty6KbIayK6jtiRZ4MlO9KP+0ZaAF559NLktdxRfMoy72CArCgHb95DEF9vT4O3AHWozsPw+Jupjdi4L6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbklQXNCQHhXkM9BOCQiEmUcGD/Sfth1XSNr0qq6uEg=;
 b=QLpOAZ4nKZ+a2rwusWLPfYKhGwQIku5ZvvbPUVeELCMGff7tUFMlRvGmTNj6H3dA+WrfSXBNvj+fTgW0p6GzETUbdxQT/mPGL1yCA7CV9iZERMAYs0I3on5a6v3sUC6KpGdVYEpAEAj64pkPj4zTiQ0uDoT8VBbMXG9nnYJYRkIbMHnTRcCxcjk9Sj0s9h0hRGALDoaugmjG1Fh89ni3JkTD8bHMuApvwuz7H5zM88wm+PTH4HAazJ5jxj9XwurP6TuvtGoYvLRMQadvZzdaxrkkWQDjU6Hv3veGp5EelHdXqSWGNnwiQ3W4C3Hf2A/JJU7iyba2mI2qVdEohmtXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbklQXNCQHhXkM9BOCQiEmUcGD/Sfth1XSNr0qq6uEg=;
 b=GLaPW7i/XmiE5xdrWMB22yKfr15G6tlriAyCdvooYlSBEAQoAQG6M+W6XcxVgDcn8PUYuSAL9QkALpmPnUmrF45moyxUxGzUpPh/CcTQ0SsxpY/mWXljtnjTRh2cw+xYtYq9PRoxXRjW2i9vO/mJu16Uzjgyar4KSRLSnE+AL+pto2cvwRFtFaMQzmyUAVlKebeAqMAoLVmwelxUfbVkiYXYWYLS6uHZI4jFtgYE/JaEjWYuiMdrOMd5VRV4Sh3Fh6/VD3ti/V6WgJ7nYiKN7rXOsXP4wmeWrZosc5qGt6IwuRQDhA0oFmWvD8qG6CdrSXXx3Un3oqzoeBc5fifbCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 20:51:36 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 20:51:34 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/3] HID: nvidia-shield: Fix the error handling path of
 shield_probe()
References: <cover.1693070958.git.christophe.jaillet@wanadoo.fr>
        <87msxns3nv.fsf@nvidia.com>
        <d083215e-e9bf-860d-6d04-d919a9b90752@wanadoo.fr>
Date:   Fri, 15 Sep 2023 13:51:23 -0700
In-Reply-To: <d083215e-e9bf-860d-6d04-d919a9b90752@wanadoo.fr> (Christophe
        JAILLET's message of "Fri, 15 Sep 2023 22:14:18 +0200")
Message-ID: <87msxnupmc.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e66b28-d089-467d-c0b7-08dbb62d8c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nZ720OTTzAGaoqoBKtR+f8Dne6iKfTlkd6xUpGAhBFEfOSS3zw742dgAl4nWmClRCPlaV42WNLMRInLP9ivRa/u9NMKrRWcCeyzE9xPQvyfnILa67aUlbeteT/09PaqVWpZNR71lqETpQxHWaH0OT5gs62Yp4UDvMAiiSzGxqfx8SNZqLtw23CaizWT7X2fJhjURxdz1Ecigu8a9ebw4XZ9svv0IexVj7B6p4gAa5ZpM7klyc8C1X8x+6CoZYB6UCgu+K+kdHVEY9OF2JJ8k13batMqNtFAcQUyv5rmA0tLhVTMjmMnFVTT0rz1A8CkRZxFNaB2O+G9yG8LcthmzYSS/CprBUaJmIBF2dp8Hg8yx6zOgZYTH6yRFexZnN7i8vbTVbrX+i4An5njd23oE5jTfy1aj3KbKywobcyg4MnEZ40IdbpErYynjqsgDXI5kSdo/WDZga9tDdj1sQ71IDp3w/mLmsgDQ7FGaKr7knEUCTzGeWOB6cEb6BQjlcyGHWHQKXvHQleBOuJqAIp/iMiZMch9uH4WaxkNUOFS9MLYb3x5djl2/hpfZH0cxPp+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(186009)(1800799009)(451199024)(2906002)(86362001)(6512007)(26005)(2616005)(6666004)(478600001)(36756003)(6506007)(6486002)(38100700002)(83380400001)(66574015)(8676002)(4326008)(8936002)(41300700001)(66476007)(66946007)(66556008)(5660300002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elI5NUd1dXYzcnZ6YWppNGxDdWVqcVc5ejZQV0U3ZXhBMU8zdVFuZUZXZFJB?=
 =?utf-8?B?N3pmN3ZWMnBpeEhCWERaVUpMU0RQWHMrUlVWZDgxdHEwS1F3WVJqT2tiZ1k0?=
 =?utf-8?B?QWNBMUxmaTlFYVNlWTdVbWVEVThKUGN3YzNEcURLZkVjMkZTSm55TUdpYXk2?=
 =?utf-8?B?UGZqZ0V0dSt0eE9qdnBzdzJENWZNQzJIVzJUOGx3eEhKZTFJYzRWTURWSkxQ?=
 =?utf-8?B?UTlXdTVyY2hjV3YyTU5Pai90WFR0NUlHakl1TmlYVkVmNUZXeTZ1M0hmdUhM?=
 =?utf-8?B?N2h4YzI5RUo4S052TW9rMkJpVnR1QVVMRjNXWFM4Z1NSUS9EZXJJT3pkOW5t?=
 =?utf-8?B?VGRKNWY0WlNjN3FDbGsxTDFLbkpLL3BzaFpyNTE5UkcvaFkvNTRZUlFxSFNz?=
 =?utf-8?B?dTlLOTZIc1VnMjF5ZW1udnhENWxJOCtFcXVsajdFeVBrZGhGWk9KRjF4OEcy?=
 =?utf-8?B?TnlJVTBPZXVOb0V2aEVPUHZTS3JER2xYQ29YVzBOVk5mZ1dEZ0RXV2xLTGIx?=
 =?utf-8?B?dk0zbW5BbnhWaTluQTJUU2xGaDRqSkVkdmRUcThXSldYWVRWVFFlR0Q5QTZX?=
 =?utf-8?B?c0tzQVhtOUpmY1Q0djhBQVRNRnBsTkQ2OGxRNUx2YzFuMXBER1JQeko0ZFBV?=
 =?utf-8?B?ZUtDL083cHM0L2NwNCtDU1cwajRJOWY2bkVyWVJnR2N6aGpzNzdiZ0tRVVJ6?=
 =?utf-8?B?WFRxb08xQUpZMmRJbHpJZXNQSVJtRFBOaG1majVYOUhwaEdaN2w5Z3YzRWdt?=
 =?utf-8?B?QnhqS1lHOXByZVR3bERUdTNQM2NvK01vTm5kY1FlSW9OSC85aE0rZzNIb3VR?=
 =?utf-8?B?KzM0dEgvZ0g5R3AyZTFvdklCWlFURDk1bnFENzd0M3lYQmFqNXhoaXVuek03?=
 =?utf-8?B?UjZPbTg0dHhjNHMrTWJ2UWYyMHR5WTRSeUlvTWNzRkJWNWFQRFNpRU0rMnF6?=
 =?utf-8?B?bUY5VWE1MCtQVjIvNDNpaVg0c1I4Y1p0cU5BdnkwSzJEbDM1RGhoWmd2eTA2?=
 =?utf-8?B?WElGZ29XQXFPSzFoY0w0c1M3UHRXU3h0WVRxb05BekVDWnhLdU8wMEM1Y0g3?=
 =?utf-8?B?Wm0ycFdSUFJISkVhbWJYN3RiUnlweUhTV2ROcU5ub2lDUGNGcFpabCtBRXZS?=
 =?utf-8?B?YlFqajF5MlF0NWRzT1FYWWw1S3hFL1J1TkRDRnJNWTkzaHhCS0ZHbmxCL2tu?=
 =?utf-8?B?ZUM5UVVYbFBCUTFmQVhCTGQ1TWFCTXRueTNQYzR4elBGZStvWW9ad0JaaVJl?=
 =?utf-8?B?WmdTSS9iNTlxekx3WFRYZjZuOG9pQ3ZRNGdGOGJqSlJsZnA0aStNVm5PSlMr?=
 =?utf-8?B?bkd4YW9rM1FYTmJSV29MS0p1RU84aGxlVEVTdDdZMkxQTE1jdmlwbDhjZ2NC?=
 =?utf-8?B?aGdEbzRXU3ZnY0RBSFJ5cDlCUHdGckx5OERIYnJVUi9rSVhpbVJuRmdQRzQ4?=
 =?utf-8?B?cFFYdVk2c2RuOWVyUVRxNkR3RE5LMDlCKys1U241N1VLVXN0QUNLdjlRcUty?=
 =?utf-8?B?SXRnRnJqTVFzS2lINWY2YVYrZnk3aFJMd0tLSWFXb2l3b1BVRmVBclUxN2hE?=
 =?utf-8?B?N2IyTHY2a2cydEcvR3owVUJVcEhUbWhTN05UUkpSdDRtZmlDcGM3cVpTYmtF?=
 =?utf-8?B?Y2paWVp0ZnFPWHdCZmtvQnlGc2lFV0VucnVydVNYdER2ZGVJcG1IMmZubzZH?=
 =?utf-8?B?cmFCRGRhRkFGOERIckIvYVR6N1FrUm5mSDRTclVpSVJUenhXVGZCRHRKZTdp?=
 =?utf-8?B?aDk0am1ZUHJLUThEd2trY0tMNXlaTFFFZXVuVGdwNE82T3BnR0VWVDd1VW16?=
 =?utf-8?B?cXpKVlYzNGw1WUhMQWwwR3FEa0g2ZW10SDc4YWJrOTdseUZRTDFqRkNLQWR6?=
 =?utf-8?B?d0pxbGo4S2MybFBub2IzdVMwZnpSZzBFSlVTSEtscFlZbENXNnJNTUU2ZW5S?=
 =?utf-8?B?d3FuWERnOUFkTjBZaFVHRDZSYVlzdzdmNS9VcDVPQVpqbTNvMks0Qms0KzZQ?=
 =?utf-8?B?cktGemltaEpxTkFWYXpNTnVScFcvdmlNdzhuYzhZTkl3MmR4UmlpOXF4RDRP?=
 =?utf-8?B?M1dYd2pKZHBob1hMdUdDYm1YdEpneFNCMnR0MFdMSlhiRU41QjAwNGRySTBQ?=
 =?utf-8?Q?1MxhPgB48TtMEylEniwf9NfLw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e66b28-d089-467d-c0b7-08dbb62d8c53
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 20:51:34.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8amMLDtzQYbCIr4fS8AzH4Hfg8QUF8hWVnjiMlfY+ga4XCHzfkzmK1mc6ILSpBUyYYTV5FbHslrxk8IB5epwzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep, 2023 22:14:18 +0200 Christophe JAILLET <christophe.jaillet@=
wanadoo.fr> wrote:
> Le 15/09/2023 =C3=A0 20:16, Rahul Rameshbabu a =C3=A9crit=C2=A0:
>> Hi Christophe,
>> On Sat, 26 Aug, 2023 19:42:16 +0200 Christophe JAILLET
>> <christophe.jaillet@wanadoo.fr> wrote:
>>> This serie fixes some missing clean-up function calls in the error hand=
ling of
>>> the probe.
>>>
>>> Patch 1 and 2 fix some similar issues introduced in 2 different commits=
 (hence 2
>>> patches)
>>>
>>> Patch 3 is a proposal to be more future proof.
>>>
>>>
>>> *Note*: I'm not 100% sure that the order of the functions is the best o=
ne in
>>> thunderstrike_destroy(), but it is the way it was.
>>>
>>> My personal preference would be to undo things in reverse order they ar=
e
>>> allocated, such as:
>>> 	led_classdev_unregister(&ts->led_dev);
>>> 	power_supply_unregister(ts->base.battery_dev.psy);
>>> 	if (ts->haptics_dev)
>>> 		input_unregister_device(ts->haptics_dev);
>>> 	ida_free(&thunderstrike_ida, ts->id);
>>> This order was explicitly chnaged by 3ab196f88237, so, as I can't test =
the
>>> changes on a real harware, I've left it as-is.
>>>
>>> Christophe JAILLET (3):
>>>    HID: nvidia-shield: Fix a missing led_classdev_unregister() in the
>>>      probe error handling path
>>>    HID: nvidia-shield: Fix some missing function calls() in the probe
>>>      error handling path
>>>    HID: nvidia-shield: Introduce thunderstrike_destroy()
>>>
>>>   drivers/hid/hid-nvidia-shield.c | 23 ++++++++++++++++-------
>>>   1 file changed, 16 insertions(+), 7 deletions(-)
>> I was wondering if you have time to address the comments in this
>> submission. If not, I can re-spin the patches with the needed changes in
>> upcoming days.
>
> I can send an update tomorrow, but I'm only working with -next, so should=
 using
> for-6.6/nvidia (as said in your comment in #1/3) be a must have, then it =
would
> be more convenient for me if you make the changes by yourself.

Luckily, it does not have to be on top of for-6.6/nvidia to add the fix
I mentioned with regards to the led_classdev flag for not trying to
power off the led when unregistering the led_classdev. That should still
merge nicely on top of for-6.6/nvidia. The main reason I mentioned it
was due to the commit living there with regards to the issue involving
unregistering the led_classdev without the mentioned flag.

--
Thanks for the patches,

Rahul Rameshbabu

>
> CJ
>
>> --
>> Thanks,
>> Rahul Rameshbabu
>>=20
