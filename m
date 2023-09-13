Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A89079F3B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjIMVVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjIMVVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:21:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4F61724;
        Wed, 13 Sep 2023 14:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnVgnNdO5Aw5NFtZG0UFWuNnSJTaYrjVWgUYNhgQX4gDXvBZyUBSuOZGEjfDevxAlLDiGVCaFfRS1n74g/2BpQiETbtIoLpjrF4jssZhKmezUZJYGfi6r1Fy6gpgr6VIiGWPcYuDWKqvYMXMMWHPiJ/Jq4Hfe4pBnqiouITy1MzeDNcOilk8fb55Fk7oVqnNrjNGAxL2QU/o8j5nlfhXqdy8ai/v50N5UZjNi+TggK0Rdon5cFe32mBC8oK5h9hgP/34NXIqk6TxwEjUd6hc2P4O+XlNUwhB0Efx7IO18hiYwNk2+N7/xKajLCMMl+lkHcMu73nUl9FZWXrC5hjVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfPAXJ3SJbU6deoUYq1VwO5pAP9wxEbx5gaCQiZHAag=;
 b=e2RrUIgGUJ3TTIfCUJzogFHrXa4/16Q7xeIir0p4oT3jn1nccKx62Cmt9gG7vEpYdh1rt987ObBTG00J/9zX2RvDNEMI4ul0YmWBv5IMMFkVNIB3jGZdSaYJxxwNAiOODC2ulOoxerr9/0sHkv/ofaPN5S3QloMd25hSLgGaHiOxjbd/igfSXNoJDkPoxG3QSg/lIbcZqmm20kFQKPf+PGSAyPtCacyhbTZQPOrIbYCF5I5+APyEsH6CdsudFu5nU7lOrzWB0hL08OpKkmieX1TGzdCxAU7TRnH4d5Slw8kVVsRaa9tnR8KV6rV1uztMzHLH6/JnZUcseDBE5w5hsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfPAXJ3SJbU6deoUYq1VwO5pAP9wxEbx5gaCQiZHAag=;
 b=muIFj2T0X+K/hbpea2XsM2iW0MWJq82goML6ktYFVz8rk4vXs1dU/8WmgK3/QrwJgavuVJT8KQ9So2h+4qltKRo7iW0JfSNfYYyKFoH/o86Vdpq1/ItyxaCvrNofh78DlaAh6Lh2UNEwxZnIEfIzIP889yFYZA0BQ0WXJh3IyIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Wed, 13 Sep
 2023 21:21:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 21:21:07 +0000
Message-ID: <0522393f-9f0c-4c59-b961-9b8d865a645d@amd.com>
Date:   Wed, 13 Sep 2023 16:21:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pinctrl: amd: Add a quirk for Lenovo Ideapad 5
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        regressions@lists.linux.dev
Cc:     Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lucapgl2001@gmail.com
References: <20230829165627.156542-1-mario.limonciello@amd.com>
 <20230829165627.156542-4-mario.limonciello@amd.com>
 <1d891d34-053a-368d-cf47-bcaf35284c79@redhat.com>
 <07353676-bad0-44f8-a15a-4877f1898b6b@amd.com>
 <811225f8-c505-7344-ac18-882472ee0348@redhat.com>
 <d232c11d-901f-4ebc-b408-bed042ed8da9@amd.com>
 <6734c409-89f1-89a1-3096-4054be29faf1@redhat.com>
 <f0ceff1c-ba5f-4c6b-ac0e-c4195f477500@amd.com>
 <CACRpkdYGxreyD8NVuKs2G44htR8EixdvGr3+ma=HrxHUP3NDQg@mail.gmail.com>
 <4246946d-40e3-7df7-3fc4-9aa10e1dee10@redhat.com>
 <b9f879d5-55b8-401d-b154-8066cb66d20f@amd.com>
In-Reply-To: <b9f879d5-55b8-401d-b154-8066cb66d20f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:5:100::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ab804d-258b-466b-2ddf-08dbb49f57e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1gb4jLBBnKJNIsX7t4SDOmJR5kybB0AUWps3aa+LRO1gGYjtOc+QgoIS/mt9LEF067wkRQbk9TQJQks9wzFP7z8/n3nWbhCBCgkXw7sRlvTSy/n0ORoTPJnO7jynJgkojAj6WfyAXqr6hvU1dgKQTXtxJkMBu00bmIm9BZ9no3naYHUaEKrElvrS/gjLoMxNQNaGMKyymr5B5xOGiotDxxiNSUWLH9wPczXeWQrnk1rxHNjHkwdMrNaMeszdlnC/a0AAO0/IvkTRFKC1yZGGGq3vsgh+dnh2zBT42eFo7W1z0E3HVX/qh+WoPdrXwg8FKQdO4ythLmze3qJ5VtqzmobMpK1NtKxlW0FKP1xLAAuzEAlaCKeNYh572wUMmAUxI0sukkCCVeDVOcysuN5VSzvHwJ3tUF7SuDt9Ro7F51iF7vim8hrPTtHK9zPOasRVNRGKVDY47Agwa+Obee0BT382SFlE4wjBHWaHX+IpJ3KKDvPJPSqS0za4qdkeReCX3rU1tsthrPrL1fNz07E9JTpfyU+pqpEpphewfkKUD4JMWNQyxkamf88EDMGibbRzq07R+JH3Lx63gttI5H+mHuKIiQ9SEVuF+me3nK/leIl5yLPOgdZwpwprb+kVlayjsXKFbM6E0U/uhpDQBbWHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(1800799009)(186009)(451199024)(6486002)(44832011)(6512007)(83380400001)(26005)(2616005)(316002)(110136005)(41300700001)(66476007)(66556008)(8936002)(8676002)(2906002)(6506007)(66946007)(5660300002)(53546011)(478600001)(4326008)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGJPZUh0OVBDS21zb2hRQSs0bG9MMmRYYmFURkMrUjJzVGhmTGNsMmJUVURt?=
 =?utf-8?B?aktsM29HaUx3QmpScDMzSjhlaXVFMW5neENETjhuVlM5OGxCNVRaVlpDYzBm?=
 =?utf-8?B?eGVBMWVvMHhtRGl5RGdha010YzRyUEpCQUdZOGU1SFJicm9tU2xqZHdBVG53?=
 =?utf-8?B?Y3dOY1pnZEV3VnBvUEJPODIrMHVDMUZNYWE3bG51M056TXN3OVd5SmlOaExS?=
 =?utf-8?B?S1NtU3BHcGxybzFZK0pXQjl6Q1VnK2huTTN4TDRzeEI3K1AvcitMbjFQM2ds?=
 =?utf-8?B?NXVnaXRScmdDQ0Nmc1c0anV1eFBwRFg2cW10Qk5VbjluVXFVajBWSHJ0WENx?=
 =?utf-8?B?MWQ3R3h1b0lYVmlsSEdZRXdsMVZCOGhoU29HbHVTQUJiWjNPRUg0Qm1wekt6?=
 =?utf-8?B?V3dMZUxuMzF2b0VIcmIybzJFdWxyY0NBMU1Ja2c4SzhIc3RJR1lkMnpvZ0Mz?=
 =?utf-8?B?elc2Q0NRNy8vZ3BCVWNLQ0NwOG1vVzBSL0VRWTBMVkVvODFXNzZldVFTUng2?=
 =?utf-8?B?NjRLV1I3dWFHNzlTWjZ5cDlvRDQ5anhXakFMbXVwOEF4QUZOZjRhN3djeC9l?=
 =?utf-8?B?SXlEdlIwSFZhVnJPMlRYUEh5dzdXRnNmT2JpS1NBSnBTaFZPMG1HV2NvcDBV?=
 =?utf-8?B?aStJa2xUM0JjeTV1bnJRVjcxVE9FRWxaOU5RNlBsRFZaNTEzTlViM2h5RE8x?=
 =?utf-8?B?YlVCMkx5cm1vbDBsRGxEWUpqTEQwUkM2bytyaUdXY3JmRDV3dzFuTmdCZ0xL?=
 =?utf-8?B?Y3FGRzlmRFE1WC9rYzE2WDJDZitzNU1kU2g1QXVLcXRiMkVuc3RzTHhWZzRw?=
 =?utf-8?B?WFpRY1BXVE9YWm4vbjQ2V053QmNzSC9OZGVORGs2YXAydXljVURCbVZGN1FD?=
 =?utf-8?B?bG5tLzhXVURJVFcra2hjOGdHRXl2YjVwa3p3VEJmYUZOZWFYTExOZk54ejd4?=
 =?utf-8?B?a3pxVUtsc0Zqd2Fsa2ZSMW5tNXMxaGVJTUJHZXI3ZGxTVXhMbDZwM2NVUGRC?=
 =?utf-8?B?MCtXdzRGZ05XS2lIZ1A3OXorRDJxaFhvMkdMK1hYZTNzWG5iL1JjbmRGekM0?=
 =?utf-8?B?ZHRXeEh0dEZzeG5hcEZlNUtMZm9tSzNmNDNEZXFBVURNRFZWN3B0Z0tORit5?=
 =?utf-8?B?YnNYdHNydHppTmRrZGoyaXp2VzhwWkNEdVpqUmMvSzN2cXlRLzlsamYzMFJy?=
 =?utf-8?B?SWptNUJicVRTRlllczRCcEF6a1Z6MVF1ZGpUc3ZnNDNha1U1dDJORDgwWXhn?=
 =?utf-8?B?dm42OXY5NG10MVpDajM2VDNJT2Z3STJVVk0wRmh0L2xaSTI3YzQxWGFrWnJD?=
 =?utf-8?B?UDNZdzMwNFlPTUZicGZPRUxDZVNUU2VUT0xDQS9sc1Rmb3o3Rlg2SDdQaDZF?=
 =?utf-8?B?ZXprblRnNVd6ZUEyZ1Z1SVhvWGJwUGN1OUU5ejNVdTczaXdHMFYzeDFKVjls?=
 =?utf-8?B?SEZzc21LWElJQVlvN3FQY3kxMTN4c05Ra0ZBUERDS1RMeldybmxCczNvL2dP?=
 =?utf-8?B?R3hNTGw3SmFxMmtmZ0Z0QVVXMTF1WEJaR1pnYXpMVFVjMHRTbW13OWxwY2tG?=
 =?utf-8?B?Wk8wVDBWd1I1VDU1MVNRMmtFeG1EY2FGc2ZtSUFNclhpTG5lekdJVnFReWRF?=
 =?utf-8?B?b25uRWRVK3YyY2hmZ2dsSjB5UWlnYjF3d2JLSGE2c1RjSW4xYnFDR3BEczkz?=
 =?utf-8?B?U21qcDI0QXJpMkFLV1RKQklaTmJiYVNsQzB0WVRWTUNUODVVU2RnYzNEek0z?=
 =?utf-8?B?dTVNSTVnSGlmM1diTDBHcmlTakFEZUZ5ekRubEpkT21ZcjJ5Uk9mV3Q1WjdK?=
 =?utf-8?B?SUlrRVd4UENHMVdsejNocGN2Y2lFOEttUVpSSG1pclp4Qm5HYzhYbFNxQW5O?=
 =?utf-8?B?enpXVysrT2FieHlNNGhrUzh2ZGNGQkNFeTU0ejhvYW5DTEMwdlNoNmRHMTZ4?=
 =?utf-8?B?cEdUTGQ4Qm1sbHlhakJWZ3FpV0ZuT3dQeFZEZDY2T3ZQZWd2NGF6UkdGbU53?=
 =?utf-8?B?VmdvTm1rR2JMZXAvVkJyMC9MWGlkaEpSK2xEeHhxL25tYzVpY3pka1RjSVRk?=
 =?utf-8?B?VUMrNE5yK0UvMXZOWU82QXg1RzZlVDl5T29rbVNpeGU2Mmw3QUY1UU5HVEUv?=
 =?utf-8?Q?wMeEsguLisxm9H+XocSC2zBPl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ab804d-258b-466b-2ddf-08dbb49f57e3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 21:21:07.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEkY0BGDgd7M5xLgJYB0q/KZwdmO6MRAaCdq6wRFgW537QLYO28X6qqNtG6vl7w2w63noq4SdQ+0LPZv/tFNcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 13:21, Mario Limonciello wrote:
> On 9/12/2023 03:58, Hans de Goede wrote:
>> Hi,
>>
>> On 9/12/23 09:08, Linus Walleij wrote:
>>> On Thu, Aug 31, 2023 at 7:53 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>
>>>> Linus - please disregard version 1.
>>>
>>> OK!
>>>
>>>> I provided Luca a new series that implements this approach that Hans 
>>>> and
>>>> I discussed and they confirmed it works.
>>>>
>>>> I have some minor modifications to it to narrow where it's applied 
>>>> so we
>>>> don't have needless notifications and will send it for review after the
>>>> new modifications are tested as well.
>>>
>>> OK standing by, I'll wait for Hans' ACK and then merge it for fixes.
>>
>> AFAICT Mario has not posted a new version (yet),
>> so there is nothing for me to ack (yet).
>>
>> Regards,
>>
>> Hans
>>
>>
> 
> Yeah it looked like we were about to have a new version to post last 
> week but there are some inconsistent results that we need to understand 
> still, especially with comparing to Windows.

I've got two pieces of news to share on this issue.

1. In further testing Luca confirmed that the issue was behaving 
identically in Windows.  We were bug compliant.

2. In better news updating the BIOS fixed the issue in both Linux and 
Windows, no kernel patches needed.

So no further work will be done on this series.
