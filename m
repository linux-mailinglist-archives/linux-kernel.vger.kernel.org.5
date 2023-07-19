Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DEB758DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGSGYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGSGYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:24:21 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B51BF7;
        Tue, 18 Jul 2023 23:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb6VLY4LP5r5oAp6nTUKaGTGjCpWlhuZbLjPm8Z2Iv6WEBq0hV7vo+7HO/XuR7ik09YhTl/M2VgJTd0rlhky9ghys8k8EGOnjGdtIU2Ah7Ymnq4C/FhJDBNMnzzhFOVvaLNTB9cKxwCCqxMiF6K2IGWlPlIdHPuXQJIJ+YYAd/gLhYBpMVcppvbYfGgIwjW1fpNtPDWSRMvDrlARyl/NPvjkGiavh+0TFE9SJEEPcLfl6sNWxb4/ZShIaHtz68YG7lyZBpL8wvMAeJwTdG/vHiWb4G4T9QN65lVtpc50x66Dhw7a4eXiTQxTYgg564yVm60QjI9MPeRWX5yJJuk8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIQ6zBe7wX/gByigQZR40Zil/vFVYDi2CE1gDcqriDc=;
 b=oP2adJBpuhfBmfe2Cu2upIXndJvhh5ijMO14FYaVdY8NOabn6MC0waZ8x2J2LN7AfUIVm2gvxuJu+cCJDwwzWz3Q1pG2u4P5k78IIT8vHyQqkHOKi8W7UP3qwoPOL0jfKCQ6OvZEqji3rExkIaX6iEO08vAaXt6tUxSTGgGDL3TTRcDqAB9GnC2HRxxZOUFVP2IosjfxhVyNy9lguUrMtazkhxxHaLfspXSyWZnvKdg5IjuMAhSSzcdjsaE2+2je3wqdNSlzREf4ORxUxJa1v8DXxb6DB5yHQ/Bg1z1vh8PdZQygfQ98B5IZtCRDusA4YSR9kN3tU2pZiJ+TX0KqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIQ6zBe7wX/gByigQZR40Zil/vFVYDi2CE1gDcqriDc=;
 b=K/Sm4JLabs18j+gQvKtU3AMb16UNZV0ToozKnAltVoYL+YpDPgrCIZhIytsCWAAhJ7z4YLdzIMyiJ95P9TQABGTLC4nvvi4dZKYCwrvDs69AstgAXmNpqAmx8mF71M07GwSzY9atzBnHpZkazlxRwNI9BwxDmJUajsaj6k/9N7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 06:24:15 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684%3]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 06:24:15 +0000
Message-ID: <3f76ff03-963d-fff8-b512-abce447da7d0@amd.com>
Date:   Wed, 19 Jul 2023 08:23:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
 <ab0fb666-e370-cb07-367b-f3b88e18fba9@amd.com>
 <a12286d2-f929-ed6d-c0f2-4dad5ce6b388@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
In-Reply-To: <a12286d2-f929-ed6d-c0f2-4dad5ce6b388@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cce5991-6cc2-4dc3-bce7-08db8820c624
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKMmVCf28a+6eG4k3q9ZAANOeH2XKwzv90eFPNIUA1z8HG7kGoaHCtOJOnDnjKIikTkCtx4ToMQ/sUiVDqklrgXEoc2X81oVP5rSYO0eTn/QbAVgxBW0allNRZthLnD/8YY9vujugmZecdTk8uJvEiU4VPQ5fazcIMSdyxw098XONAlgHXNslPQy4ifKrCVvbj6bTnoNJJBiAk/naLXDhd833jJjcS2z2BuOapA0oM7MUzlNpCBb87L2K75nAIP9nKQCLiBbLS8nNCvAIksgq33s9qFWo39G+0Fo972R4SY//uIeEqSQUmoNVk6GWONrnJkFoDo7GUKoMvX546K7DcPYQGjcsZCW2xz+fDKyxHao7KOusFHZgyL8mpf+FD6kpOAs4r24+qCXoNac7QEiQ4kIVJLO+BHC4yP0brgjUbW2+0018zvfxaTqHChdJ5q4pguK47NfrDIHgWpt2nfHXfIVIze0BOFT7PuDhXYgaQjG+FWBAUBF6xLZatVI79PtJZwJ8PVDHvsluTknSIB40p5IXdSL+xsNGXAIrJwewIVLQGVlLs3nBxpvp4yP5krnsykUXhuCNhTY3m+L9uWd2yF9yymMtuKh4Oy75kZpVBN480JusJSeGy02XbZ5l6//lnxTHUweE1tl5lWaFmWxgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(86362001)(478600001)(83380400001)(186003)(38100700002)(41300700001)(15650500001)(26005)(31696002)(110136005)(31686004)(316002)(53546011)(8936002)(6636002)(8676002)(2906002)(4326008)(44832011)(66556008)(6512007)(66946007)(66476007)(6486002)(6666004)(6506007)(2616005)(36756003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE9mZXhLd1RxTEVZVXFoaGlPMngyM05ER0xSd1M5aW9sV3lJUjR2cUhlRjkr?=
 =?utf-8?B?a3BXdFUvRjBycG8wTmhzaW01N25UeWE4NXhVUk1yNnlQVjBOclVCZkdqZjRn?=
 =?utf-8?B?K1dSclB0ZmhGTXJHMmdBZ0VaOU0zYzZCN1M5NFRwSXFPd2xqaEFnZSt1K1U4?=
 =?utf-8?B?NTNtVTlRYUFzc1B6WisyTG9ZNG9yeXgxSGZEcjk2MVRNSHNBYWhUY1BGUFdW?=
 =?utf-8?B?V2ZRa3NlM29zZ1pnbmx5NFdPbUVVS2I1ZVgremdOVVd6bEw0NnZhZnhhd0V6?=
 =?utf-8?B?Q1hvTXJlK3ZMSHArY2hqMTFkZUkvN3hvMExsbnBaM1dkZFRNU0pXa3lSbDZi?=
 =?utf-8?B?MDlkRG5ITGZkY0greHVNQ0p3RXIzTU81UHhBMDNFZmNIUnBQeGE1QTFCQ1JO?=
 =?utf-8?B?VjhKWWtTOXFzS1BXNWdwaVZIMi9xTE1iVnlURCtvRVFHK3g3SHRIcFlWdzBp?=
 =?utf-8?B?TFNUd1h4RjlnQmlmSUI2dXo2d2lsNjI2ZW5qWWN5Qmd6Qi9zWXB4UzJvazFH?=
 =?utf-8?B?V2VEcWtEbW5kTzR0UGxKSXM1dVVhZ2VnRjhHc0ROY3JRRzRGd213RmZYNjFN?=
 =?utf-8?B?a3Z5Sjc1Q0RvcEVkVDVjV2xEM2V4UG0zSm1rMElyUjBObFVodTdFRk10eENC?=
 =?utf-8?B?ZkNZVE5kbDdsMjltMzBjaEtnaE82VURWVXZhWEVTUzE3OVlxU2NXUTNZZXBJ?=
 =?utf-8?B?SitqZUp2NWgra2Z5V0NMVk8zYlQrUnZ2UHlLNE54Z1hGcXBTSEZLWXlxWGx1?=
 =?utf-8?B?TVdDeFJxUlBobjJZVGw2MGlYbndvVGR2VEY0b0RHb2k0bDZDNGo1Zkh2SENi?=
 =?utf-8?B?dzV1cGlHQjVYbkpBT21Vd2xGMHB6Zjg4ZTd2NGcxSXJoS0Mva2RCMkdBMDBi?=
 =?utf-8?B?YjMyeGt2V091UFFEN0NoWlVZcnpVYVVRV2hmeHA3YUhxdFNFSXFxUlgyeWR3?=
 =?utf-8?B?SlBKRS9GV1dHNm9vZ0lzUGhtQk40NzlVL1JYU0NpTzFyWjA1MVIwMXluaTFM?=
 =?utf-8?B?UG43YitIY1oybzJIS3duTjVZUGllaTFqVzJOeXZsT25JMUhVQlA5L3RNNWRV?=
 =?utf-8?B?ZElMSGgrSFdkSXd3QjJnOFY2TURYTURMNElweXdxcVRNcHRxOHRRa0x2blZa?=
 =?utf-8?B?RUp4WFpIeEhEMGUrdGdwRDZKb0FGR2dlaFp6dHdKVmtMUVBFSE9vUTE2VFho?=
 =?utf-8?B?Y09ka3lEYlVHT2tBcEUvbjVlbWc4OE9weWI3d0szY1VYMFVKcmFLU0VjTXAz?=
 =?utf-8?B?WTgyY0dtWkhqMmxYY2R6Z2FldU5CTTJ6dHBKN3RCTTRYNnYxbGhXQ3pGN1Bh?=
 =?utf-8?B?WGQrNitScTJCTzdHdEp1RVQzM0huMlRxSm96VlVtYUIxNUdmQTBtbk01UnZH?=
 =?utf-8?B?UjBKeGFtWm1VeHFQTGdYWmhZUlVkc0ZRelBjaUFDdnZDdlhSSFExYjh0dUhj?=
 =?utf-8?B?cXlyRm9Ham9EMERrZ25OcTVvSjZSOUdiVXVGTFFXRVowR3dnaUY2ZngxdTlB?=
 =?utf-8?B?ODZod085TmN4NkJxVmdpWGhVc2s2NENLSWxLdmhYc2VxV2k3SDlJUWF0L2ZB?=
 =?utf-8?B?VklhK0dNRVpkekgzVVMycnlqalIyMFYyQXBmVlRiV0d5UGlDeHpIaS9JdHB3?=
 =?utf-8?B?RjdaMEFjS1cvYTFYaVBLSmNWc2xicE9CMXZCM0NlNjN2S1JlT0VKYzc3TTUz?=
 =?utf-8?B?bmpMK25mNWZUbVJDQ0trdFJoVnVsdkFLeWJwaEZpeHgrNUJzUEtrS25MWEUz?=
 =?utf-8?B?L1JOcmxOcXRST1F6UWdjeERQWnBybVo5c1IwOVZNeW5YMnBHeXF0d3FJR21T?=
 =?utf-8?B?QnBPdUljVk50aXZmVVIwS3FxL2pMOVJqY3k1bnkvejVvbmdHMFZMVnB0czRX?=
 =?utf-8?B?VGlYOU5uSGFyWlpvTWNSb3ZnR3ZsVEdYRlRydVhGeW1LWkRSRUxsWFUrYUp0?=
 =?utf-8?B?eXI5aE5XNExQcTBpelZ0TVJXQ2ZKelZhMmppUjUrMmJ1blQ0ZTVuaGpkSnhK?=
 =?utf-8?B?dUw4SWs1UWREUFFKTjBjS0QvTlZkS0VVYWM0Y0x1cWh1UTBJTElneFdDZUZP?=
 =?utf-8?B?SnpSVXlxSWcxV1V6VVhaOVorUkxzajlwQWFEM1BUMEV4enlheEswRFdiS2tV?=
 =?utf-8?Q?L5nMuhIs7tydF7zPqQu/nhlNL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cce5991-6cc2-4dc3-bce7-08db8820c624
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:24:15.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19AGRsVqqx0io/fbpu1dbNbrTBRHQD5WX7NjN06KyCEC7K0ko1Yc1m4ADb+DoMUp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
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



On 7/18/23 20:01, Krzysztof Kozlowski wrote:
> On 18/07/2023 16:30, Michal Simek wrote:
>>>>
>>>> Please correct me if I am wrong. Description about ID should be removed from
>>>> commit message because it is not necessary. And
>>>> include/dt-bindings/reset/xlnx-versal-net-resets.h
>>>> should be added when we merge also DT for versal-net SOC.
>>>
>>> No, the binding header is needed only if driver is using it. Adding DTS
>>> will not change that - still no kernel driver users. No benefits of such
>>> binding. If there are no users and no benefits - don't make it a binding.
>>
>> But header in board folder should be fine like these.
>> arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
>> arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h
>> arch/arm64/boot/dts/mediatek/mt8167-pinfunc.h
>> arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h
>> arch/arm64/boot/dts/exynos/exynos-pinctrl.h
>> arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
>> arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
>> arch/arm64/boot/dts/freescale/imx8mn-pinfunc.h
>> arch/arm64/boot/dts/freescale/imx93-pinfunc.h
>> arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h
>> arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
>> arch/arm64/boot/dts/tesla/fsd-pinctrl.h
> 
> Yes. If you want to store some constants (register values, firmware
> magic numbers) and use in DTS, this is the way to go. Most (or all) of
> examples above are for register values.

I did small grepping over Linux (reset only) and I found that all of these files 
are not used by any driver/code. They are included in binding document or dt files.
Based on your description above they all are candidates for removing from 
include/dt-bindings/reset/.
On the other hand that files could be used in different projects out of Linux 
where that values could be used by a driver/code.

What to do with it? Should we remove it, deprecate it or just keep it and not to 
add new one? I just want to know how to properly handle it.

Thanks,
Michal

altr,rst-mgr-a10.h
altr,rst-mgr.h
altr,rst-mgr-s10.h
amlogic,meson8b-reset.h
amlogic,meson-a1-reset.h
amlogic,meson-axg-reset.h
amlogic,meson-g12a-audio-reset.h
amlogic,meson-g12a-reset.h
amlogic,meson-gxbb-reset.h
amlogic,meson-s4-reset.h
bcm6318-reset.h
bcm63268-reset.h
bcm6328-reset.h
bcm6358-reset.h
bcm6362-reset.h
bcm6368-reset.h
bitmain,bm1880-reset.h
hisi,hi6220-resets.h
imx8ulp-pcc-reset.h
mediatek,mt6735-wdt.h
mt2701-resets.h
mt7622-reset.h
mt7629-resets.h
mt8135-resets.h
mt8173-resets.h
nuvoton,npcm7xx-reset.h
oxsemi,ox810se.h
oxsemi,ox820.h
realtek,rtd1195.h
realtek,rtd1295.h
snps,hsdk-reset.h
stericsson,db8500-prcc-reset.h
stm32mp13-resets.h
stm32mp1-resets.h
sunplus,sp7021-reset.h
tegra186-reset.h
tegra194-reset.h
tegra234-reset.h
xlnx-versal-resets.h
xlnx-zynqmp-resets.h
