Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9AA801958
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 02:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjLBBLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 20:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBBLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 20:11:44 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2047.outbound.protection.outlook.com [40.92.103.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C0FD54;
        Fri,  1 Dec 2023 17:11:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMhC84lfg199/Lhgt2fOOcy6PlgNnxXfcVrUeYr3bBOyMnvuiRLvsvB236V5zQ2Qvkj2Es2tFRj1x6fHUcrnZJwzubn+rEOfV4vmybostcCwnXrs+QKNVhizaITItEua9e67cDqlfaQgTeHI2z/+7wJ78gDVWBh9iTVPZY1ft6eMCi8f15pEldQFYOqIeEcI8gH/jfgdwANYRTwUsOShfX4nR2fMfBxIjdf+U6FW6Vakd+A2MbNAUUriaW85SjI/Hrqvefavk7S0lqgncOGKmDUKTOn7AeNKUKj6sfzSYQcVWgyOrdKS2DrLX2RQCPnjSrVcQVYBtPfu07z7bs1W5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/xz0cjQoFaYfAbbc5zlMSgapLIlrdgQMm2WU6WIVf4=;
 b=G0QCBcYVqVZLC4hl3nMAVbV/0UMwK9RdFGIO1WMF9fkIDj+8pNZx/rhwzgMIpfEFAW6PI4x1xTHd0mn62tJaY/w5Tif9TDDhgtUPTp+cJK0V6M35LI332biu/bDrfUuZIRxuOll+jNVj2MVrUXHyI2B5/i3L5BWbs7dhSkFnfpn9eVEbtJuHzSp6ypHG0khNoaAKOSHk7By/MGGBbPNbk1ib9Ty/lr5v9GUVGvM1lk5idKt0iwyZaru6bUFuQg6w1LUF7E30mpRmW6TnkONc3/xkeLOAWzQyDgGxPz44gAMoALB240OqXSpvEGdOm+yfBbe9kRE9CXYLKB4m0CuMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/xz0cjQoFaYfAbbc5zlMSgapLIlrdgQMm2WU6WIVf4=;
 b=kIh0NEKJnxeqLk7NbLjfnZqqWySJc8Za2DsZFCKX90/dUwIFJSstT1aYe8BIqEIFN37UzQjE7GgqCZL0l1kpqdUd4xMZxLU9GOvmPKDMvWOMMAL5IJ+YkBvE93kVcW/yL2prOHhlTJ4sk1fHVU9pIWLTnstlmZJb77vV0AE5G3sowCbiyZeF61H5/F3ifQP/Tts1G0JgSkgNv2zS1OLe1ia6Cq6HWt/xbTrJ8OmyPcDaG5Cvdi9Pse+WFiMgidKXuV0ul3PG2BlRheJooHbEiY6H5E5RyhVoVmusfjTWwex/TG5C3d5QOj4ULw2bvCOuem50Gd4M+b5uJRIAMoEePQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MA0P287MB2448.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:122::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.27; Sat, 2 Dec 2023 01:11:43 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7046.027; Sat, 2 Dec 2023
 01:11:43 +0000
Message-ID: <MA0P287MB033290A6C8B15202E31E43CCFE80A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Sat, 2 Dec 2023 09:11:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Add Huashan Pi board support
To:     Conor Dooley <conor@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     Chao Wei <chao.wei@sophgo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20231201-strung-mandarin-110a322468c9@wendy>
 <IA1PR20MB49539E82E5C0B5CBFD889F39BB81A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231201-nutshell-uptake-48161193c6e7@spud>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231201-nutshell-uptake-48161193c6e7@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [EYvLaaxD3TkTRkIYxut0PHNqK+0UAeyn]
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <b769665e-c5b3-4921-8b64-9e560f47a854@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MA0P287MB2448:EE_
X-MS-Office365-Filtering-Correlation-Id: 4803afa7-e2a7-488e-ccbc-08dbf2d3a529
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNiLuw0/GS3QLMGa2oQ/Vtt15vNkJsU55TMdKOAZHcZMnZxZbN8UKafkmOD98gZ1AdAV2AEi+5pXhUh/BSgyMi1IZWD8yQs+dQ+TfWUVlQJs1BUY3oB/XwnL448iqImnbawX+dvfBG5efOOKB2JtVy0MAQnaG0xebRcQu4swRJH3g5Gy43QFIVCdDvA88X83Cyx0ucapp9JGyo2l4A9eRA3D0+h4ABhOUxmuOlonfSmPScUEpCVx0GgbniHsGkdJpZg4XVu2S9UHnWBwT0HHU6fIreCw/+3xnJCxIhVhyc+ZD2hPMnWbOtO3CSWhiIfl6pHuAM7yNW++idYxd/XON10TDrAZaWJIWznBuXErRkw4WewafnJPDGr6cmVMis6nxE5SAVD94vWSkpYLfX6jT9u6p+PHsze4lGr7leSQPNfPt7tZRxpA0ONs82rfWVAVd4KRyhLa3F0Hsr3MFXvAFCpUQkBFwDMWhCDArkmMEeuHBEYTV3CmZEU1f2wPKq4mEGcRQQWHzgHu4vYS5LbpkAYno6Fp+XlOHK+BZDtjwTwTPWp1pBuHF9/3ar6srAHGlkG+31ZmIMujNfwltN6FJKmZZph6E75zonxg4zL8aZNRE/mrfrdQoaNijKHtvCUd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmZCYmlETzRDb1RRODNqL1ZJSTVFb3BBazZ3ZTgyZE93UnA2bUZmVlNFYng4?=
 =?utf-8?B?WkdDZTVHM2xmR2Z4ZUFqVFoveE5DOE5CNmFFSDErS2didlhVRTMzR1BWOW1J?=
 =?utf-8?B?UWxsaGU0NWRNcTcySVd3RjhHNm1pcVFNK05hVjFiR3dMUnM4TUt1SHdscG1Z?=
 =?utf-8?B?UGxaWWc1WUljU3pwVnF4bmZiZDlNa0NEeDdWM2pnUi9CVVl4SVF3a0VndnJt?=
 =?utf-8?B?amtXaklkem8ybVg1OENjdlFpM0RpTmRxSlVYbkRlYWRQR0Z5ZXZaTXBqY1N5?=
 =?utf-8?B?OG85QkdFVWNMblJXcmxDcW1HdndBZHVPejlsU0tPNnVodkM3U0RLWWs5WGkx?=
 =?utf-8?B?M21wa2Q3Q00zL2I5ZXJvaGdLYzhkUXhqSGI3b1FCZUk0OVA5ckFrRFhSMTh4?=
 =?utf-8?B?Znk1QSt3eXdWTUFzVDlMREVVd09YR2tRaFl0cjJuTjFPbDVBcUNzK3M2T2hx?=
 =?utf-8?B?R0JxVGg4bXRFajJwcjdOdWtWekhNNmQxNUlORU9XcTJvMWE3KzdEem4xcWJ0?=
 =?utf-8?B?WVZLalJFVytYYTFFdWE5cXlYRlVDdkNQUDVpS2NYcDU1a2pmakhCWHNGZTEr?=
 =?utf-8?B?bVgySStra0tON1VSdkQzRmNKYjRncnV3S3pKc24xSnZnN2NMSGZMTVdyQUpE?=
 =?utf-8?B?TkROUEtHTVF3STRYbWNzeTV6NkplUGc4djVZRy9aY0YvdE53NkMyNFJZVkU2?=
 =?utf-8?B?VzQyTFFzMFd1OVVKWld5TEQ4aDI4QjhLZGxWR0JreHd2OUhUZzIxMVpNcm9q?=
 =?utf-8?B?cXdFcGdjU3J6Ny9IK2twcFdhUWowbFpuT21DUXZ4NDNyQnhXNXkvL09LTDdr?=
 =?utf-8?B?Rm5rS0RFVjh1Z3BONExFcWhpTEx5WDE4ckhTWHJaVWVURmNtNU9WaTF3UkxR?=
 =?utf-8?B?T0JUSktaYWlWOUR5OTU0ci9yWXloMGczQUtHY1hSYXF6cmdybDVXbGR1TTBB?=
 =?utf-8?B?OFlRR3NNdkxKbW5UMExibHdLYkhteFErWG5RS2VrSGZKRlRyS2l0L1lmWS9J?=
 =?utf-8?B?UzRpM0Z5am9CQ1F3c1d4a2I1NlhBS1ZhZDV3STM2cWdXckkwR3NBckl2c0F0?=
 =?utf-8?B?ZFVJN2tLYWIyNmZEQjNvMzFQVmxhTTRuTTB4RFhFTk5tdDk2eEkvVE9zK1Bs?=
 =?utf-8?B?UkE3dlpiVmo5MnppNTc3YWxEdlhITHBoVzRYK09FMTFadFBwcWkvc0ZEOVl2?=
 =?utf-8?B?U0VYclJLYzlDSVZrLy9oODhxUGpiWXp0TnI3dmNFSnNiTFBFWFZPT1NDc1gy?=
 =?utf-8?B?c2hhSzRlcEFhK0tZZDhVMUkvaUY5Njk0ZlBFd2R0RmMwVjI3cThzdnZtbUNo?=
 =?utf-8?B?ZmFKcklBSGRReWtoZG5XRHFMcUl3eUZ3MjgyWW82bFFTSko0WjVXMGhoN3ZC?=
 =?utf-8?B?U3JycjI4L2xMb0R0YkljZ0lqWXRRZWhtMDA4S0liWVl3TnBmalN4Nm1lSDhD?=
 =?utf-8?B?ejVYOEJCNDFHNDRQTzlMZHFIY25oSU1HWUwrRktMNnFndnlVNm9iTTQxLzky?=
 =?utf-8?B?QWN4S3NwS0dweGYvQjNKRFZSRCtBWmdmWWRQdEE4M3dZQTFrcG51SnpZN2Ra?=
 =?utf-8?B?Q1lWR2FSdkltWUFjUUY3SFNza0lSRUNTdWxQVDJvYi8wcnRBK0w2S3RNdm5m?=
 =?utf-8?Q?Ht/AW332YpXcwrmxCK/eREQW7VL3FAOmS+JlZjzNg/X4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4803afa7-e2a7-488e-ccbc-08dbf2d3a529
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2023 01:11:43.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2448
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/2 0:21, Conor Dooley wrote:
> On Fri, Dec 01, 2023 at 04:31:38PM +0800, Inochi Amaoto wrote:
>>> On Fri, Dec 01, 2023 at 09:02:59AM +0800, Inochi Amaoto wrote:
>>>>> On Fri, Dec 01, 2023 at 07:21:29AM +0800, Inochi Amaoto wrote:
>>>>>>> On Thu, 19 Oct 2023 07:18:00 +0800, Inochi Amaoto wrote:
>>>>>>>> Huashan Pi board is an embedded development platform based on the
>>>>>>>> CV1812H chip. Add minimal device tree files for this board.
>>>>>>>> Currently, it can boot to a basic shell.
>>>>>>>>
>>>>>>>> NOTE: this series is based on the Jisheng's Milk-V Duo patch.
>>>>>>>>
>>>>>>>> Link: https://en.sophgo.com/product/introduce/huashan.html
>>>>>>>> Link: https://en.sophgo.com/product/introduce/cv181xH.html
>>>>>>>> Link: https://lore.kernel.org/linux-riscv/20231006121449.721-1-jszhang@kernel.org/
>>>>>>>>
>>>>>>>> [...]
>>>>>>> Applied to riscv-dt-for-next, thanks! LMK if something looks not as
>>>>>>> expected.
>>>>>>>
>>>>>>> [1/7] dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
>>>>>>>       https://git.kernel.org/conor/c/21a34e63afcc
>>>>>>> [2/7] dt-bindings: timer: Add SOPHGO CV1812H clint
>>>>>>>       https://git.kernel.org/conor/c/06ea2a1968a9
>>>>>>> [3/7] dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
>>>>>>>       https://git.kernel.org/conor/c/d7b92027834e
>>>>>>> [4/7] riscv: dts: sophgo: Separate compatible specific for CV1800B soc
>>>>>>>       https://git.kernel.org/conor/c/5b5dce3951b2
>>>>>>> [5/7] riscv: dts: sophgo: cv18xx: Add gpio devices
>>>>>>>       https://git.kernel.org/conor/c/dd791b45c866
>>>>>>> [6/7] riscv: dts: sophgo: add initial CV1812H SoC device tree
>>>>>>>       https://git.kernel.org/conor/c/681ec684a741
>>>>>>> [7/7] riscv: dts: sophgo: add Huashan Pi board device tree
>>>>>>>       https://git.kernel.org/conor/c/2c36b0cfb408
>>>>>> Thanks for the confirmation. But I suggest to revert these patches.
>>>>>> Several days ago, Sophgo informed me that CV1810 series will be
>>>>>> renamed. And the Huashan Pi will switch to the chip with new name.
>>>>>> To avoid unnecessary conflict, please drop these patch and I will
>>>>>> prepare a new patch once the renamed chip is launched.
>>>>> This is a board that exists, that you (and possibly others) have, right?
>>>>>
>>>> Yes, of course.
>>> I dunno then. It sounds from your message that this is purely a rebrand
>>> of the SoCs,
>> IIRC, it is.
>> FYI, Chen and Chao. Maybe you know something more.
>>
>>> so since people already have these boards, I'd rather not.
>>> We should be able to support both since it's just a naming change,
>>> right?
>> I agree with this. If the above is true, we can just reuse the exists code
>> with a different compatible name, right?
> I think so? I'm not sure what the precedent really is for pure
> rebrandings of an SoC.
> I say for now, assume we can do that, and we can discuss it with Rob and
> Krzysztof when the time comes if there is no difference between the SoCs
> and boards.
>
> Cheers,
> Conor.

As far as I know, sophgo's SoC product names all start with "sg", while 
products starting with "cv" come from CVITEK (another chip company). 
CVITEK was acquired by sophgo a year ago, so now many SOC product names 
that originally started with "cv" are being repackaged and changed to 
start with "sg".

For the cv1800b adopted by Duo, Sophgo has made it clear that it will 
not change its codename.

But I heard that for other products, such as the cv1812h used by 
Huashanpi, sophgo may change their names in the future, but sophgo has 
not officially confirmed it yet. Looks like sophgo themselves are still 
in the process of digesting cv's products, ;)

Since we have just started to support cv1812h and have not done much 
work yet, I suggest not to merge this patch into the mainline, and wait 
until there is clear news before doing this to avoid introducing 
unnecessary modifications later.

Thanks,

Chen



