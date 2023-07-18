Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CBF757F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjGROaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGROao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:30:44 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5249E;
        Tue, 18 Jul 2023 07:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZflfxyYKeYAL+RcXSPMyc4WVY0IZA33fgsYA3t4KVScumgMPR0pv1kib7jzbrJ+c8OdOGfXTaMBuoEGv3qvUjiz2eQFPQDBnIWKNrClDufA29G1tAuTHE8e4ZXYWjYSk5UUs6EuW33/bxAlf7N7E4S9Tp2KhRglj1tmevpWbYQzbe2HsxHtuEesbXxVrNLYz9mwY+Y4w7ddMPcXSWs9I+dFS5SO86JZzpD63lyGc8PL2byCUtAWc9pSpeS63AxJJCwmubA1pB2Cl9QzG8W+esl6Cj78jLfZOp5Vb0jWFFCR+OlDoaFOrWL2WQrDHUvuYUu0sHRUhQzKyb2wLOIk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0mKSHWb89lO/1DRcKwd205+v5bFRta8/AUoqQYc2lg=;
 b=koWUVzAcsI4lnasYlT5KnQuFjWJakvNRkL8GOQ6OgyDA5HDJW+OM9op8tTWZMm0FB2imwGC4+W2b6kX0hRQsQbMk5QarA5Fu6I9+CVGyUVuDdHF+r/KPd4y+Ffvnax6w403tNUyLH9GoMay1xoxL4wOluzU3qt/wuTys4ycATL63GGvJnaWJYEJgVhpEDAOy8Q9kpwFqNB2MHs3+lgwsWNaVBoybpRGokuoKpcRWos8M0tW2Gc7N+PGc8klaI7TSKB3KAYCcsLbQIIaXfXdx86SimzAa1oy/CJjl1Rtrgm0MIjy83KsH06mMNOjpfy1A0USQQ3UTxdTJ9uV0nGPtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0mKSHWb89lO/1DRcKwd205+v5bFRta8/AUoqQYc2lg=;
 b=4HBAbCiMZkxT68Fv14gJOkTcNP6G3xJDAia15uUGjVjhADdTqQ1Rau4Yq8DrneeF8K6uIefLbmMzMhm9u8FqeE6urp5ve0LVp12qhx+3pCSaux1VkY1a4mp7BbOf9/xcDPdk2RNcoQ1bOohNyHZRB+NNuGu/6Ta4kfx2RRTX010=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 14:30:40 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 14:30:40 +0000
Message-ID: <ab0fb666-e370-cb07-367b-f3b88e18fba9@amd.com>
Date:   Tue, 18 Jul 2023 16:30:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
 <20230717112348.1381367-2-piyush.mehta@amd.com>
 <20230717-explode-caucus-82c12e340e39@spud>
 <ee81e955-32be-66ea-377b-263ee60a2632@linaro.org>
 <e8f48a30-9aff-bc2f-d03f-793840a192c9@amd.com>
 <694a1314-0b25-ff5e-b19f-5a0efe07bf64@linaro.org>
 <cae162d0-843d-ca1f-80d3-5a0dfe1e3d0f@amd.com>
 <22e7dc73-2411-5cb1-6cef-daa5f2af8297@linaro.org>
 <5df3e976-9fc2-19af-e6b4-e2bea0d64623@amd.com>
 <4c932cbf-19db-2c88-2558-aa42c5338598@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <4c932cbf-19db-2c88-2558-aa42c5338598@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: aff5b2e6-3681-43a7-e595-08db879b8f67
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkdSQg/SLImpLJrzVtwG3lFNXDSLe2Smhz2CCjam2cBqOwOIYzooI7rQ7nWtsI6s7JDX0NCL6qcDQ4dubYRplqSwg5ruPKx8vpGtQ0/yR+yr3H+d6kEYUHHCg+D1LOlvHLFpAPON2DUd+wNGOyZDxlcrM2QZY/XnaKUylxR3s/ZSlRexVgsRIYUzHxz7yrutYyg+3KiHWF1URbQ7VoRzfRoPq+yvSCTcyJ6CpbRU4g1bxZVhOq6S1lIXADHc3cnajYspVljY/62ZQJPrXlUmruslGG+GPOSLIlE3dbWlRzTUqxwZxB6FppCUohWh7D6PrZfDgiAaDjNHue2CfRWrnlJu20UqvvCvBfJzq4dd5KsOWXEJ7ty3QxhOqjUYM06YLD/+gKSpWFm44ivwuRjEZ8qrd2XYKmXXb8Wl4bjro0vRuP3UPGywwKvIx1z0of/wOF1C3aeehaApQCan2VJxSu9GiRYa+A5qwWb1yH9nd9GrPmahtOQovVQFvu0cMo1bhfdwiWpCxWl+uwF4OPPPIn9gq3mKBF82ieT5VA1dCqYFXDEYTPp2ND0fiHh786futzulUdeLl5wyypReE5SmYHe0mqNPcPb3shCBZlzEVklBD1Sm9fwlJfkZ/Qpjy/McjDRnxeB9qzmzwlJFp26f2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(6486002)(38100700002)(6666004)(110136005)(41300700001)(8676002)(8936002)(478600001)(316002)(66946007)(66476007)(5660300002)(66556008)(6636002)(4326008)(6512007)(186003)(83380400001)(2616005)(6506007)(26005)(53546011)(86362001)(31696002)(36756003)(44832011)(15650500001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RC9oQlBpNDFTSGRZR09ZaHQ3bWY0bGxLZjFPQWNTUjNIWXJYMEk0RDQ3QXFR?=
 =?utf-8?B?bjRjUnFEbWozdzh2YWNDM1ZUUW1MS0JCZWV0c1FWa3VGNkYwa1d6aXFqS1hk?=
 =?utf-8?B?c0hVbjdIdmpQYno4SkpsMkI4OEtpa0dXVG9SdmlxdjBnMlVET2RSVjJ0NTVW?=
 =?utf-8?B?K1BSWGVhR1lBdk9kb1VGb1pMeWRwMzFjOXhjYnVTZk9hU3dIbCt4VjBtR1Jr?=
 =?utf-8?B?QnNKNHNWd2w3blJFdmdqdzA5MW1HdWd1NmpoKzVneVNRZmpGRjZFUi9rMFlx?=
 =?utf-8?B?T0JBS2RuYVF2d09kYkFtQmhYb0xBNm5mcWRNVHBDYkl4elpFeUNtYzVCaEM2?=
 =?utf-8?B?Tmh6WWh3RHZucUF0OTZzbjluTzdTMVo1OFYzZTJOUS9pVWlocGNRaG8wTFMx?=
 =?utf-8?B?SHFQT21QNk96UkZPaTVrdkpabVdIcytyY2lXYTVzMkRnOWFEd01zdW5SdHY5?=
 =?utf-8?B?MG51OG5CNTYvb0ZhZDNYRk0vcWVaOUZnSXE1T0w1dmxYSE96V2FlbEdWUXd0?=
 =?utf-8?B?dXNCaXowblVEeUxKYWR4TTI1WVVydUZmc05kL2N4eUc3WWhpZFJtbVJHVHJj?=
 =?utf-8?B?SlJZT0pIY3VMelgrYWlBVE5sdmdQNWFHZ1JFM3ZlUFM4aDJqMnExTlYzNCtV?=
 =?utf-8?B?VVlRbmhWdjExc1VGU1JFT0RpcExCZ3R3TlRFamlrdmhXQ2Nia1U0VzQvdW1t?=
 =?utf-8?B?MTJQYTRVeXVJK2FCcHFrTTZsTXpBQml2RnZmT1hRVEVVditZTWpuT0ptcUlP?=
 =?utf-8?B?c3lEK09Eb0VyU0xBYURhNHNPTGtkQ0hTSVdVMW9aUHgwcHlEd1dTTVdEUDYw?=
 =?utf-8?B?Vmc4c0krR01oN0I5Z3VYWWY0ZmlCbkxvdlFRb00zWnZ0NGo3MGFBQlJhVVpL?=
 =?utf-8?B?Ny9Id3p0WlFNdkprclJIOVRXNDVWWVZ6K3dWN3JYOW9RN1h5YWZyOFhobzd1?=
 =?utf-8?B?ZzIwQ01nRk1GdE1LalB4QXRvK2hjSzV0K2V6emt6dkxnU2d2Qk90b3VvNEFF?=
 =?utf-8?B?cGpnREZKbGFXMGNaY0paRUptajBPbGFmU0dIcGErQXhBcU5veE04RGlzS0Rs?=
 =?utf-8?B?dFBKN2pVQlhILzUxUmFPd096RkVjeE1ydG5Rb28rMjZYbzNrc3VuUTYyZ1Zl?=
 =?utf-8?B?aW9kUnh1UlQ5ckM3SjdWYnBEVTBSdmlsKzFzbXJ0bmxLS2ZQbXhBUEF2b1NK?=
 =?utf-8?B?MHpVQzFCS1c1TWxIOThGc3g2QktPMFBLd3p6NXV2NU9SWTFSUEJBZkJQQXJC?=
 =?utf-8?B?b01YTDV4ZHlubzRCVzRBRTcxSFpSbllMcC9aajZoWW0rTG1lWERxb0NLYnRx?=
 =?utf-8?B?QTlmRDVPcnE3elQxQ0lQb2xVcjBpcmRUTTh5Yk9ueW1xVHhBa1AvMjZZZnhJ?=
 =?utf-8?B?Y2xvTGJtRlROcXpDOHJmMTg2WE90WmErZU9IV2NJRzZnMlo3UklPOFdGOFc5?=
 =?utf-8?B?aTBZZUwvQ1ZCUzd6aWJoWTVyNm5TbnJhdmNIRzkwY0RWWnQ4eEQzblpBVzdF?=
 =?utf-8?B?cWwwUE44Q2FhcnAwaHdwMEh1ZW5sYjI1ckVxY3FzeUs3RjRudzRDcUtEMjdN?=
 =?utf-8?B?amxjWGgvNXdNVCsyTnlRL3E2MnJIR2dDTWVrVVN1RXRzTWxzTHpJT1FQejdD?=
 =?utf-8?B?TEFSRmd6MXJMVitPM203emNTTHJkNlhJTzU1aTd1SHMwQTdraGNyWmdmTldO?=
 =?utf-8?B?cHdmNnQ1aHZSaDliOXh3L2t6U2NsdEpKVDhFYmVtS0VvUnB3Ti95Q3NFeHNJ?=
 =?utf-8?B?bC9LYy9zamtMRU45WktuQjd1OTJkSlJrUGdVb05iMjhDSVVac3hxQjRpeWtl?=
 =?utf-8?B?YXoxRnJGRnA5Q2dOd3pxQ1gyUUJhS0VTRjFvU3FaUGRCWjhuV2k4V0MrTGJj?=
 =?utf-8?B?OW12MmZLdHdTeGs2TkV3Z0w0cjZ1MVNIWldvQnhEQUd1MGNiNnlqS01qWmU1?=
 =?utf-8?B?L0cza2lUNEZFMTJxMGxaWDUrMU5uQjYxVzQxYXR4L3hXNzRLeU5mRHNrUDFl?=
 =?utf-8?B?dEtEdEh2K3lVZjgwWXMrYTVJbHhKQ1FkRUF6UkZjL3NIYTJsdjZqbDhpTHFi?=
 =?utf-8?B?M05Vb05jNlJNemdEZFQ5RTUyZE9HM3JSSFAzK3U5N25RcVlPN1phMldKQlZS?=
 =?utf-8?Q?mE6hGuE5TY3xzLK9ODt4ckZ2P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff5b2e6-3681-43a7-e595-08db879b8f67
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:30:40.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SygcuqnCYtHZbPC3HDfF6EHIk9fRMrOprthX/0R51vffNFTR9xDAQk8EjNd49o6e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/23 16:04, Krzysztof Kozlowski wrote:
> On 18/07/2023 16:01, Michal Simek wrote:
>>
>>
>> On 7/18/23 15:20, Krzysztof Kozlowski wrote:
>>> On 18/07/2023 15:11, Michal Simek wrote:
>>>>>>
>>>>>> That numbers in DT are virtual no matter if you use ID from 0 to max or random
>>>>>> values it is up to code to handle them. Checking nr_pins against ID is done in
>>>>>> core but it is up to drivers.
>>>>>
>>>>> No, you confuse "virtual" and "ID". IDs are not virtual. IDs are real
>>>>> and have representation in Linux driver. You do not need to define
>>>>> anything virtual in the bindings.
>>>>
>>>> Not sure how you define ID itself. But HW doesn't know ID. HW knows only
>>>> register which you can use to perform the reset. It is not really 128bit
>>>> register where every bit targets to different IP.
>>>>
>>>> And this is SW-firmware interface like SCMI reset driver.
>>>>
>>>> Firmware is saying that ID 0 is QSPI, ID 1 is MMC.
>>>> Their Linux driver is asking for nr_reset via firmware call which can be
>>>> different for different SOC and that's fine and I have no problem with it.
>>>> But only SCMI server is dictating that ID 0 is QSPI and ID 1 is MMC. Different
>>>> SCMI server implementation can map it differently.
>>>
>>> Sure, and all this points to: no need for bindings.
>>>
>>>>
>>>>
>>>>>> In our case that IDs are coming from firmware and driver itself is just matching
>>>>>> them.
>>>>>
>>>>> So they are the same as if coming from hardware - no need for IDs.
>>>>
>>>> It is hard to say what hardware here exactly is. From my perspective and I am
>>>> not advocating not using IDs from 0 to max, it is just a number.
>>>>
>>>> If my firmware knows that QSPI reset is 0xc10402dU then I will just pass it to
>>>> reach my goal which is reset QSPI IP.
>>>>
>>>> If you think that we should use IDs from 0 to max NR I am happy to pass this
>>>> message to PM team and we should extend any SW to do translation between.
>>>
>>> When we talk about IDs and bindings, we mean IDs meaningful to Linux.
>>> Whatever is ignored by Linux and passed to anyone else - hardware or
>>> firmware - is not a ID anymore from bindings point of view. It's just
>>> some value.
>>
>> Please correct me if I am wrong. Description about ID should be removed from
>> commit message because it is not necessary. And
>> include/dt-bindings/reset/xlnx-versal-net-resets.h
>> should be added when we merge also DT for versal-net SOC.
> 
> No, the binding header is needed only if driver is using it. Adding DTS
> will not change that - still no kernel driver users. No benefits of such
> binding. If there are no users and no benefits - don't make it a binding.

But header in board folder should be fine like these.
arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h
arch/arm64/boot/dts/mediatek/mt8167-pinfunc.h
arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h
arch/arm64/boot/dts/exynos/exynos-pinctrl.h
arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
arch/arm64/boot/dts/freescale/imx8mn-pinfunc.h
arch/arm64/boot/dts/freescale/imx93-pinfunc.h
arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h
arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
arch/arm64/boot/dts/tesla/fsd-pinctrl.h

Thanks,
Michal
