Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A31B7B6EC4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjJCQnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjJCQnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:43:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9E0AF;
        Tue,  3 Oct 2023 09:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7lFvIKIR1cGiK5Npqu27THopybmVFw+V5tERthrDNw2jcCP18yNIbWj3Qi2m1igvNzmZQh74qwnQ6GbfBZelyHLAxiyDBtrfGamNdAWU3fyOh9H/VzvFwQCgPGGCmJ/J+2m4qCFcbBe6Jvot/CpLhsDoZ4B8ltIvZDT6YPQWUnZlNkW7u9a8anWa77h6USqGY+siKZ6qXzg3TY/WZP8yZ7sWwEbhTem3EzEgdbbz7ESmYxn0WG2HeJp3rgMcDM0kkAZZfFVjL0pIXkzcMhkwmGNGDqccGy2c9fp4gBS2Q+2eET4rN64XSvZ4dV6kpQwJHfk9c7IBLQt3ysFOXpOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3GBdxjYDM78aBukJk8fCRK18/JE9sALd7to+oLj1eE=;
 b=QVyUSlenEi1P46o7JR3fAb+tOs0TB/Zj6Yw/3j0z65v8a65atlz9Gthm0nV4HtByjImnI4vYQr40IzF/ZjsKi2+zLBb5Xvu1+mwzTQsbcw8a2J3Q2p3t4kobJPKe1g+v/QTk97dbgalnWa3UcA3Dah2ZRo/gUuDvzw12AmUkQ8zoqpAEvrFLqEE27VnHITtMsRNHOcdaDrQ+lGEBSBGvqzyYLkbUe1R6HZCG9IuIB/xIl4rkgbeKmmAw8mWoixFMdREj/5wq5syqeGDor8cXs3b3OVQDSv50E6FfdCTCT7h9ZvvCyiPlfKkJddajiuyFP46pWR4FjffPCVtYMxqgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3GBdxjYDM78aBukJk8fCRK18/JE9sALd7to+oLj1eE=;
 b=nxV0iPDwwEf/KtBVbFH3mc3D9MofIz3HPK/sPPNUMQxtXd7LZE1dcl1WDwfdl8XwXgvXIJmYP91ROfJxmk23CZpB7ofFosAz74eIsw1u6ErlBAKK3i9zxXhRYU/ET6MAUltdW3DC5OVJPcr7BJ6gDdF50rKbUQKGn24dX9+YIXQC5fL8j5QTprNiU096tB7HIoKww16xXvDcRGInZGr1CwaAVYXt5iLSkoOlJNKXhHaxeows20/1GJyqwxGAYwvScPln54unhVT0g0cBywh7l2go2gDQgLXbpnYKJQqB/FWepQbCpyFnfEXcd0WqinVDorh730Yhx0JH8wU7A7IKiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 16:42:55 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 16:42:55 +0000
Message-ID: <59ea74ba-b951-cf89-9d7f-bc7212ddb08a@nvidia.com>
Date:   Tue, 3 Oct 2023 09:42:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hte: tegra194: improve the GPIO-related comment
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230911094443.14040-1-brgl@bgdev.pl>
 <cd4df23c-cc02-6723-e36d-34ca03409e6e@nvidia.com>
 <CAMRc=MeWXapho1bsX9Si5uSx7MWVhpT2cqrv5S+qPo51Ko=Vtg@mail.gmail.com>
 <7766de61-a046-3e17-1322-28bd7f1e61da@nvidia.com>
 <CAMRc=Mfbt0iUbM42zR0ZrBWgbQkctQm3LxwiFFP5dXNuQC-EqA@mail.gmail.com>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAMRc=Mfbt0iUbM42zR0ZrBWgbQkctQm3LxwiFFP5dXNuQC-EqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: e648f742-8f27-444d-d21b-08dbc42fcaef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtzzSCNae3nTT9ICVZhMfqq5wIeJwXdk6HQFB45sg/i8oSu8diAHary+q+lIG+UBbg5ZTXxGkDbP+RLLTUX6CGW7qYzL49QJqgUCTDk30RoD9fsOv4YiclKwgaDSZYUeVmslubMH7ubjCTxCeYpcqcpaj1UWDNYE2v4zYgCjECL5Ob+xvui3cazFnER9EjXFi0pCGhScYcdbTobk5XSaJn3NRtxVzh4nP1fefndm54mgkLaoGi3FfJa5Ihc1zZZ9VtyF5yqgweJfetiITWFxDx7dBHkZqxQiIHQskT0poAw9N+AWDKdhRBOLOHMvn/a6ok/dwX9oLRts+cjUrkITDH4Mjaiq/d+tyOpHD6pOlsDzAq4INqJhMRy+2cUomGN/YNRMHmYsKlI+k3SV2BA7Aw0rBHgg/FyfOG461xkSoE+l7rV5JJAHDW7f5//TUV08PbEOLnoZB2tjevfnQjgX8ckpO5g3HjE2dROQ6iKZlbkwevQ0nYLsJN1cmnXPanEg/cNCnRmVTnsXeQekMx6deGfRn6NRi4QXf9YGIoCFJskHlks6zJzQLMven5/udTb/8avJaR2nGUaIaRGQ+RnagmvvJTpx/jeVLSI6sGVaj00Y425EgkTTFIns7Wp2To5+6PsuqeYAvuJqgRvZFqe2PBm8DJrDbqAGxSt4Yn9EdfJ2RksPaw9UrIagm2q8HirE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(83380400001)(66899024)(86362001)(31696002)(36756003)(38100700002)(53546011)(316002)(66946007)(6916009)(66476007)(66556008)(54906003)(6506007)(6512007)(41300700001)(966005)(6486002)(2616005)(478600001)(6666004)(31686004)(8676002)(4326008)(5660300002)(26005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXQ2bkZmb3puTlRaZk80a1BvOStwZEFmM0xsUmVEZkZrTFVaVmJzWlk5QUFY?=
 =?utf-8?B?WGdLYlh3N3NRcWdTUEx0WHQ4MGFMd0NZaVVybHU0VWZHNU1qNTBqQml4UHNk?=
 =?utf-8?B?bDNZZjR4ZGhQTHZ1UmZHbHRNTnJ0eG55V2hUL0JQenh0bFhmTFplUkp4L1M5?=
 =?utf-8?B?TmI2OWs1THp4dzNEOXJKTThQS0lwZjE0NXZGZU53Rk9UVW9iYnJNMEhsL3lM?=
 =?utf-8?B?cnZJUTAxdzUyZDlQdVJJN1ZaRnYwVS85c0twdGdHTllJRDFRUHhDbWdXeFo2?=
 =?utf-8?B?V3RrOVR4a0tWdDUwblFkRDd4QTBiZHB0ZE5kYnNDRUlFd1NhZG9ERlZEYkVm?=
 =?utf-8?B?d0dUUEF0cFlWaVFUSGd3MWs2ZXhmQnhiQktVMUJCK2JrRlZqakVyazRxM1E3?=
 =?utf-8?B?c2ZxUW9IOVoxR05XWlVvWVZld2FIR09ZVnR3QjZ3d01GZ1ZYcjlHdVgreVB4?=
 =?utf-8?B?NzI4ZHNsNHJWczBPYmMyckhlYjBKMnJYeTdqTVV6UzhUNzh5a2UrTW9kOEJU?=
 =?utf-8?B?YjZLSDJ3K2hZem1QMHkxL3J0SkEyMFRua2RET1NabVpicWRCczRLLzZMUGxq?=
 =?utf-8?B?SnhSTWEzSW9EOXlBK2Q3LzVidy8rSmxIUW5PcWFIaEJQdndyR3JzbjI4bW1I?=
 =?utf-8?B?M0plN2JiempNeitwdmRHQ0Y4Tk4yaG4yMDdVOWQ0T2ZkRXJ6RjVGWHFHQ1Zi?=
 =?utf-8?B?NlNTckE2dWY0SDdwc09OT2ZadlQvem1tSFA0VFpHeFhBQ3VmdDJITzZHcWRk?=
 =?utf-8?B?bXA0VTR4TUF6NjMxRW5tVmdvQUZ3bHhWaVNwUDdiSVgxTUo2NFhpaGlnL0Yr?=
 =?utf-8?B?czZLWnhmbGlKVnhVWjFVMXlkTU9FSjBPV09Ib1V6TWxxMTh2dU9QSm1Dd2VE?=
 =?utf-8?B?VTBBRkJuWTVyaU80Ujd5TkhweWlKanJJVVA3NXR0TFZtL0NyekFnTXpJdmx3?=
 =?utf-8?B?cjAzakhVUkhZSVZUbWk3cUIwYm0walp3WU40WkNwQjg1aUdQK0c1MGVBQUI4?=
 =?utf-8?B?SkRGcFVJSkdvanBOaHV4VTVGemtRSmJzZnNVb1pMbVRVcVRMcitUS1hpNWRR?=
 =?utf-8?B?Q1YwMTBHK2Q4Q2tpMDNlWHBBdGVWV2NkRkVpNVBNWmNOSldvOWJlTTZNQXhF?=
 =?utf-8?B?bkhVd3J0OTRNVTdMamlvdWR1bTh1OEw0UUsrU2ZaM3ZUZk11L2x2NHBNaThO?=
 =?utf-8?B?NlZFVzN3WUgyVVZuaW8zaVYxdE04WExpSVd3M1laY1lJMVJ3UDllVTQwdENk?=
 =?utf-8?B?NTBCdFBWRHVoUFhDb2RYUkRpOGJxODhDZ2dzekEzeG92eTkrakgzZVlkSUZQ?=
 =?utf-8?B?K3pGOVZRYld3eU5HU2hYU1grL3ppMVRsOXpuZThVc3VDNE5jbUhITDZZQk8y?=
 =?utf-8?B?clI5OHVJanZKOW1NOXpnSmQ3eHJWOTJjQU9YUk1xRlFKOVFkME9tdWVHSUxr?=
 =?utf-8?B?WExSQ0hGQ0xHUzVCNkxvOGIxbHpOT0c4di9Ta3Zaazd0ZlB2cTBtNWcwWDVE?=
 =?utf-8?B?MnB6eTNOakc4aHpaYnVUNnNwZWcxRUExa0o2NWRrU3VnU3FpTy9HQmFLdlNE?=
 =?utf-8?B?V0YxT1k0RHdLcHF1L0R6RGRJcmR1OVlvcVNPeGlwTlA3c0ljakxBbGhJVzhQ?=
 =?utf-8?B?eFdyUGpRSzRXcFhlNk9mTHhLZGtNdUVrRERFcnhoWU5WM3NYSU9maWh6T1JF?=
 =?utf-8?B?VmJ5SldCdlQ0MGJvN2lWWFd2VjdxQk9rSVhEeDgxUFgxQ2cxd0tqQ2xUMjZR?=
 =?utf-8?B?U1pSeExRdDhzV2xqZnNFYVB0Ri9iS0VFT1NpZXYyLzQ5eTZLZ3YrcFdDcGhQ?=
 =?utf-8?B?ZmNFVzFZY0ViaXN2akxwSU1IUHZ6MXBTWlZvb0dYeG9hTFQ0WDNjTUN3NlBr?=
 =?utf-8?B?MklnVUtZQjVQclcrMVI1bjV6cURCeWhZR2hjcmFORHB0Qm5qNk1RZG1RTmNJ?=
 =?utf-8?B?emRINUFMMFR1ZG10bzhuT3JYQ2VQaTZMZDNqR2pzR3NDY1pVQTAyeWQrcnA3?=
 =?utf-8?B?cFJ6aFdhdWxidmlwOUk3TUZIVmY0VFEySUlaVnJiUmVaUndrd0Z1M2lVWCs0?=
 =?utf-8?B?UDVROTZRVnRwZWpOeHpVZ3U5MlBTOU5wbHlycElNNzQ0NTBRcU5jUVhSbWRU?=
 =?utf-8?Q?ABj+bX7BmiGIuF450tPtb+Crb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e648f742-8f27-444d-d21b-08dbc42fcaef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:42:55.2283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOuxtdByW7SUNfW/gHVdm6qKcuAE5mORYFbWSj45kjd4z7NWtvH8mVf81SkXBJZ5pZM33IbQvN3gazeGmiQZdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 1:58 AM, Bartosz Golaszewski wrote:
> On Mon, Oct 2, 2023 at 6:27 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>
>> On 10/2/23 1:33 AM, Bartosz Golaszewski wrote:
>>> On Fri, Sep 29, 2023 at 11:38 PM Dipen Patel <dipenp@nvidia.com> wrote:
>>>>
>>>> On 9/11/23 2:44 AM, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> Using any of the GPIO interfaces using the global numberspace is
>>>>> deprecated. Make it clear in the comment.
>>>>>
>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>>> ---
>>>>> This was part of a wider series but since this is independent, I'm sending
>>>>> it separately.
>>>>>
>>>>>  drivers/hte/hte-tegra194.c | 13 ++++++++-----
>>>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
>>>>> index 6fe6897047ac..9fd3c00ff695 100644
>>>>> --- a/drivers/hte/hte-tegra194.c
>>>>> +++ b/drivers/hte/hte-tegra194.c
>>>>> @@ -407,12 +407,15 @@ static int tegra_hte_line_xlate(struct hte_chip *gc,
>>>>>               return -EINVAL;
>>>>>
>>>>>       /*
>>>>> +      * GPIO consumers can access GPIOs in two ways:
>>>>>        *
>>>>> -      * There are two paths GPIO consumers can take as follows:
>>>>> -      * 1) The consumer (gpiolib-cdev for example) which uses GPIO global
>>>>> -      * number which gets assigned run time.
>>>>> -      * 2) The consumer passing GPIO from the DT which is assigned
>>>>> -      * statically for example by using TEGRA194_AON_GPIO gpio DT binding.
>>>>> +      * 1) Using the global GPIO numberspace.
>>>>> +      *
>>>>> +      * This is the old, now DEPRECATED method and should not be used in
>>>>> +      * new code. TODO: Check if tegra is even concerned by this.
>>>> This use case is to do namespace mapping from gpio subsystem to hte. Few doubts:
>>>> 1. What does deprecate mean here? Does gpio subsys not use global space anymore?
>>>
>>> It does but we don't want to expose this to external users in any way
>>> anymore (and haven't to for years). This is what deprecated means.
>>> Users should deal with opaque GPIO descriptors not global GPIO
>>> numberspace.
>>>
>>>> 2. If yes, what GPIO number is set when it comes from gpiolib-cdev, as based on that I may have to
>>>> reflect in the mapping, tegra194_aon_gpio_map for example.
>>>
>>> Why DO you have to use a GPIO number though? If HTE needs just a
>>> number from some HTE numberspace (which in itself may be unnecessary)
>>> then why not just keep a local IDA for it? Do you have to know the
>>> GPIOs internal numbering scheme to make it work?
>>
> 
> Dipen,
> 
> Please set your mailer to wrap lines around at 80 characters as is
> customary on the mailing list.

my email client misfired, will make sure. Thanks.
> 
>> humm, overall, I just need to know which GPIO it is, for example, GPIO controller X Port A GPIO number 3
>> to do proper mapping.
>> Continuing from above example, the hte driver gets:
>> - GPIO Controller X from DT node
>> - the rest details in current code gets it from [1] and [2]
>>
>> If there is alternate method exists, I would like to explore. I think IDA will not help in this case as ID assigned
>> does not hold meaning in this context.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib-cdev.c?h=v6.6-rc3#n760
> 
> Here: any reason why we have to translate the desc to the global GPIO
> numberspace? Can we just pass the descriptor pointer directly to the
> HTE subsystem?
Sure, if from GPIO descriptor with combination of any helper APIs from
the GPIO subsystem can help identify the GPIO pin, we can eliminate the need
to pass global number (I assume gpio desc
can be only accessed/manipulated using GPIO subsystem APIs)

> 
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hte/hte-tegra194.c?h=v6.6-rc3#n421
> 
> I still don't understand why you need to know the GPIO base? I'm not
> quite sure what the role of line_id is in this driver. Is it only to
> index the array?
> 
> Please bear with me, I don't know this subsystem very well.

Sure, no problem. Let me see if I am able to elaborate:

1. Map arrays' indexes are GPIO offsets so to avoid having
the extra field for the GPIO numbers.

2. The HTE driver needs to know exact GPIO to enable corresponding bits
in its registers. For example, hte register bit 3 would correspond to
GPIO 6 of GPIO controller X. If gpio descriptor is passed here, I think
I would need to do some conversions to identify the GPIO to enable
corresponding register bits. In the current scheme of things,
I though it was easier to identify passing the output of the desc_to_gpio* API.

3. Since GPIO global space is runtime, need base to calculate the offset
where offset does not change. So in the above example, gpio cdev would pass
306 and HTE does simple conversion from the base, ie. 306 - 300 = 6.
Now 6 will serve as pin number as map array index to find the register.

4. Overall, I rely on base + global number to do namespace conversion
between gpio and hte subsys as far as gpio-cdev use case is concerned.

> 
> Bart
> 
>>
>>>
>>> Bart
>>>
>>>>> +      *
>>>>> +      * 2) Using GPIO descriptors that can be assigned to consumer devices
>>>>> +      * using device-tree, ACPI or lookup tables.
>>>>>        *
>>>>>        * The code below addresses both the consumer use cases and maps into
>>>>>        * HTE/GTE namespace.
>>>>
>>

