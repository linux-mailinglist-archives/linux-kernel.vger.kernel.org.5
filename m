Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDFB7BC5F0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjJGIHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjJGIHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:07:20 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2045.outbound.protection.outlook.com [40.92.103.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73194B9;
        Sat,  7 Oct 2023 01:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2EQYcMfR9KJ8J2AvW3jkfJSKPbpYrUQtjR5bMEgNG3ckMeLd91lXtVvKLY7kG7ivmgDr+1kg2926+EutvBwoNRgnsrVso4IOJ1w4hFGSREgA/COMUfWSB3xTGK5N9+jkWtjiyp4ayi4ZgSUdE2l6bcpy6HnxZgTQDaz6LFEd2tQ+vZgawNEv//caYWCVIvF77O88eHB9TaQM+7N8rcYk5ciQcSxTa6pvugY4yIiUot9aWTJW7hpRwo7YlCB6FwI5Vv+ylBQx5yprDjb/u4LmRxQlSS1o63katCojmTtvHJkk0u9JUoZXgvwbYcB+bn+5utvVOzx4sG0Q/x0TcT6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E5dQBOQxXNNKjYvQobEd+Rd3Ti7uwRQJ53NUQj71z4=;
 b=g67d161II1FIO+pNVpcmuAs7AqRvoqXtG2XRsM3GEm/fexfD3zSM9VAShfKdF9OKK/moqAAni/qE6eVakaIhgN+Bsg1yaGX2CTzNEQd1gq57fqBnnFNoJbI6avyi1hEIzg4qR6Q08meefPUi8Qe+ycZ71TVrJgsPJOMsm/+CKGrwy3ZJRqda9DhlcuSSfFvUdxkg+CU7pfF0TW/fJ/AQCRQTTcFkUYaXZwCIe6JuXAZ8wVO3QBFgQB/mrplsjIA2+N6IURsxcg4mS779bMPMOZR30Zu4bu5VMLWPj71vnlxoBY8fqW5TDuO3MDtTGOHv6j9mScidW8xW9Z2PLUFC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E5dQBOQxXNNKjYvQobEd+Rd3Ti7uwRQJ53NUQj71z4=;
 b=j7xkHc/H3DTzXRBXETFGMvxxCHsBUzLYNNP1IhosC2RaQVzNM2+j8zK6Jy7U4jXt2TLtanK8oFwzDB0hJfLdgbqLvlr48pKNOzroaVVYCwx/5GfYSeZpUnIpSjI0uleiAG6WAGQwW4rP2AO5VUvEZuGtoZ5PMVjTJ+XiFepQ+wA+IJ6Iap4z8Ijk+BEHi96hdJbortTyPlLt6O3V/yQ5pAUxU2vNESUHbb/S5p4l3hEdrjmev6Z57ZMY0lUsfHsZkQshhxpCHNjFaDmuXzjkTuZzNG/pH2Q67d1wMtDfke77HWwuVWjumzZsIhioIpTzzX7vBbcnCaXXEZYuMqBEgw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MAZP287MB0437.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.41; Sat, 7 Oct 2023 08:07:09 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 08:07:09 +0000
Message-ID: <MA0P287MB0332BA73D0135CC73CAEA16DFEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Sat, 7 Oct 2023 16:07:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v4 00/10] Add Milk-V Pioneer RISC-V board support
To:     Conor Dooley <conor@kernel.org>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, devicetree@vger.kernel.org, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com,
        Chen Wang <unicornxw@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>
References: <cover.1696433229.git.unicorn_wang@outlook.com>
 <20231006-empathy-unrefined-ff1168095093@spud>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231006-empathy-unrefined-ff1168095093@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [wrpVuWGb5dXERBpFm9DNjYDWWTO24biH]
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <f0a0bc8a-a615-4e0c-a8a6-f00e7d1e777c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MAZP287MB0437:EE_
X-MS-Office365-Filtering-Correlation-Id: 574b2723-0c42-4bfd-8f36-08dbc70c66b4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYVK/55hVejaD5DOiISUXnYuZK0BFD3F7GWFfcBpNX5O02nUoIS7HVWAx0r/wWVl82Gkwy8QYI/F6Jk4kau7G/erZ6aVkkI5Luoj3xmlAdu+QuB6Z4pxxNBPF9xPEoINi0AWy6sEXCi3o/lbpgnepJmM8u6eN6723cEMxiuD9DMeJ2CeGZPezi3/bSQIj/3OwjIudS9r+kSfET2ANC0xg1BFgAmPEqfG2nR61o+Fm6NwfXQmU2idNac2c2B60mCcnR/lmKMHwMNht1K+IigbOhw3j0jm8U6JQxPcHg2+tVlN95blbJmmmWjYKCJAYmlgO/9yeRQu9FV2XEnRuXFcq5nvFOEk+bLL8VwC90ssbAL8nbyKGESSwdnJOuKAd6GwQHU72Ob4K2BNCQfnWiE56ZtaJ8mOZc9wYLClhzWlS7JeA03l8anepAKuOkZotf6nvrBJsNhVaITu2rXeS+JBw41jkLHrEJorfsd0/93TbykKVY89x5ZtZ5WDJ2qZdJTt136Qiyfu7dc+LM+T4vqyssL2z82IIJ8WpRNeanpuoB1dfTNVxfyaHzt7Qwo0ZfOSKqF8iea84aGf6LK7dIiDcD9ihbTN/GbXI6NzyAMeNZk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWF3cUphUjRkMkpmc2tmYzZLN3RXajQzbU9heDAxQy93Mit0Mzd2SGswb2hk?=
 =?utf-8?B?OWJGYi8xNWpkTDNxbUNNTWtpcUF1N25sQXdnVHMrUENFR2lBNzRvcTRQVEdM?=
 =?utf-8?B?ZVVHd2JRaE41cldCTEs1bGNKZUowOTJWMzBGWGdsbEtWd2QxTWhqaDJDLzV0?=
 =?utf-8?B?K0x0bFFwU2V5YldRbWg5cXp1WUxxeW1DQ0hENVRxaU9VUFdnVzJ6UTYwRmtk?=
 =?utf-8?B?VjQ2YndHaENOOHBwbzlpcVI3eG8rRkVOWk1IZ3Bud0FNeGk2UW9zMDEwOU9s?=
 =?utf-8?B?R29zZVR0cTR1UG5YUGFmS2xWUzAyQ2Zuc0IxaGRKY3JZZk1lNDQ0MElocCtD?=
 =?utf-8?B?a1FidDMxMWlkNFo0K0xtK0dTWXVUZHdkL1JxMUFCcUZjSjhYQzhTME1mSkZ5?=
 =?utf-8?B?THB5WnV2dkg5ZytsL3ZsWHpYMndXSXplV2crNXp2YVgrK0l6UGI4cHB3eDk0?=
 =?utf-8?B?K0lFTnZZYzBGbEF1MXdJUFUybzI2cE1sdkQ5R2oreTArWW82c0NUV2JYb2tm?=
 =?utf-8?B?OXc1TFVCRmhYNVhWeElJYklJVEJNdWFNTnpOUHVLSWZ4MVZ1a3V1OXZJUkhI?=
 =?utf-8?B?ZlY4UE9URmUzT29ubUkwZFVKSGdIOHRQNFJ1aUFZZENLdVRiNEZZSXRxWHFa?=
 =?utf-8?B?UkVqYXlrK1NQTWFFOGd2UXFCR2tFRE5QZ0ptUFJvMHI4ekVRUzNwQ2NpWkFu?=
 =?utf-8?B?UTJpTUNrMXgxaHczRG9RWm1xbCtKS05sSWUyRTBPZDBJMUxRSGhjcEFuTlUx?=
 =?utf-8?B?eFh4MDZHWDA3a1NyUHcxSnltWmtteDFjaVNocWpMZUZUSERZWGhQNzVtSjNq?=
 =?utf-8?B?OUVVT0lhdUJkYXN3LzVpa3lPaVZhZVZkT0ZiQ3RUQWluc292Wk9CMFBzNkZw?=
 =?utf-8?B?UkdadUxJMmx5aEUwQkllYUk3YzNidXhYSmUxM21aRXZKUEdIKzlMNVhEb1Rl?=
 =?utf-8?B?T21pZ0lnRHg2NFE5SnE2WkNGQ2gySEFGZTRndG45bEZpZ0M0aCtRYzR6bnlB?=
 =?utf-8?B?NEN5NTg2blM0a0JMelFheXhPY0p2UWMrNjFCK2kveHVSMWtKbG1Wbm04cFpz?=
 =?utf-8?B?ZGoyTTN6T01UT2N6cFE0R0lLNzZJVmFOOUFIeUI3TFFBNVNqYkRjY25YU0Vz?=
 =?utf-8?B?YlZLaU8rOFlaS3UwWGRsTWkwcStxL3BmWWY3bS9TODlrWWlyT1c3TkV1QzdH?=
 =?utf-8?B?MVVlWUMwYW8vanZwN3N0MCtURVNyei8wYjhtN1RRSndyVEp0M2h3Wm1zaTdU?=
 =?utf-8?B?QUF2U2ljMU44aEhJaXBMNlE0azVxVksyUUJtL21ncTRmYlYvVjdoQ3EzSGlY?=
 =?utf-8?B?djJyRkZqSXBnZjVVdExBanNrTGZMRERGbFlHVkdQK3ZJYlU3dDZzMjBZc3lW?=
 =?utf-8?B?ZlQ2aWN5MjRRYXlYSG9DNlp6dUtlQktjN2VSdDZmb0JZZFJzQXN5RlNUNW80?=
 =?utf-8?B?aDF1SVBQeUtoenpYSHk1NWJiUEpWcEIwOVVKdm5ZRzlBdlEvOU10Y2ZBV0tY?=
 =?utf-8?B?L0pFSngyS2xIQzFHd3U0S1hDMDVuOGhFakRYa20vdDAramliRDZtUDBLSEZx?=
 =?utf-8?B?QUpOUi9nMDZvNGF2MU0vTUdlbEVaM0c4VWVlalZOMUEwL2lORW1iMml2Y25N?=
 =?utf-8?Q?+rKjh1Ftb/WsW07DNv1qBRLlx/lD/RHSSPedJfkz5FCc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574b2723-0c42-4bfd-8f36-08dbc70c66b4
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 08:07:09.1403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0437
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/6 22:31, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> On Wed, 04 Oct 2023 23:37:20 +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 [2]
>> in a standard mATX form factor. Add minimal device
>> tree files for the SG2042 SOC and the Milk-V Pioneer board.
>>
>> Now only support basic uart drivers to boot up into a basic console.
>>
>> [...]
> [10/10] riscv: defconfig: enable SOPHGO SoC
>          https://git.kernel.org/conor/c/a4bbe6e3d9f6
>
> b4 is confused, but I applied the whole series, temporarily, to a
> "sophgo" branch. IIRC I asked for the defconfig patch to have
> savedefconfig run it it, so I did that and amended the patch.
Thanks, I'll pay attention on this next time.
> More notably, I changed the commit message for the aclint patch, to
> drop the discussion about incorrect use of the sifive,clint compatible.
> That meant that 90% of the commit message vanished, so I'd like you guys
> to take a look and see if the new text works for you.

Yes, it works for us, thanks.

> If it is acceptable, I'll merge in both this series and the milkv duo
> stuff. Acks on that series from one of the folks added as a maintainer
> here are still appreciated and will be applied.

Acked-by: Chen Wang <unicorn_wang@outlook.com>

Due to commnents from Jisheng, I want to continue changes DTS on plic 
node, I have submitted v5 patchset, can you please pick and merge with 
this? v5 also contains the changes you have made on "sophgo" branch.

Thanks,

Chen

>
> Thanks,
> Conor.
