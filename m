Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40977BC775
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbjJGM0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbjJGM0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:26:10 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2014.outbound.protection.outlook.com [40.92.102.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F280B9;
        Sat,  7 Oct 2023 05:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buG4SKw1ckSfwXosY8jONBlbt2B4I5jVw3ypX9caHp3KgKtrTi9KNzBQYO/v3jZz8rie3Ab4362NLMq+gcWaJfAf6LJ+OElv8wkl611s4uHpL6yEWkb3mynh+YP48vpTx5X/QODcbuEUBWIWuINR2EXFOPC2eG/WZwpLWsyTZCi09hNbZlEOwpuRFIFd0FpRfnYUVcPzCQsqlx4G6lc7SeboaCJiPbCmJUAWhgfzEj7M9s6XSde1XJ2hEUMGGe7UshGcTFLHlzzutvLMtfdzQfx9L7fcaQlVg46Pj8f+IYPHOGJDYo2hJkDXeUWxg6SFIRUWagmtlCTO1n9L4bb+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7Qq/K8WDJfv22UBjEtfIsKqtkFE+NNPzMZwhbqRwDc=;
 b=oFmTKmVqTTs6yvoiAHYuufFlDoFx2nGqr/bamIokPAvH3+5BzPd1JjoUVPZIRPqwyymre8wWNCUn6fR+3i6bIamqG4UNouVbUMZV1PcTYAyiJkFVZCoVk6vaCqqK8HPw0oZiCXm/+MN1NJh0bPrJqx7jRinzXOEsYzDzbi+aaxaI6Z5AXup0LAs7LsgJ7FMuit5EdSBIFV/iRS8pz4it2D7m6G2WPpsfaYYoDSaYUlkbUtkusdJi4FggcnWXMF/zNkPyMAIBC3MRDAOiP/0dK3eeuW/m38gFncXMXwB9mxlQVN2/fWhSc+YJrzwi97fGZPtF0bNPVKj3GbugFxIx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7Qq/K8WDJfv22UBjEtfIsKqtkFE+NNPzMZwhbqRwDc=;
 b=AaBf+vp5yEoLb5BcHhh8j6HvRavoT2SQRw76+v8C2Davld3Rlckp2ADa2EsbLo1dXlXdVIpijxMbDmERiQOgBtBMpzqvQAQgcKhrKo1BXAk/3jJ/AGS3YI4XdMVxFkKWoCXXHqq1Oar1dM05a897vbGaMS1mHSZ9RtwvH4Nk0NWGWUWeeTEQtv0Nqx9/KYqd8ZsMj5/g+E3l42Q098cSROg4t+qsokaUhnPGmPQnXcNNzJhB4juK11PLLKkslxzoHVcWkmbVzhh7SCtXEtj/27JmAbCWvDm8gi5ToLAHDs4lZIhLJD2yocjffcTixCXbj7NPBHewChUq2DdwSgM+lQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN3P287MB1978.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1cf::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.41; Sat, 7 Oct 2023 12:26:02 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 12:26:01 +0000
Message-ID: <MA0P287MB03329460B9F3B79B1148A6FDFEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Sat, 7 Oct 2023 20:25:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] Add Milk-V Pioneer RISC-V board support
To:     Conor Dooley <conor@kernel.org>
Cc:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, devicetree@vger.kernel.org, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
References: <cover.1696663037.git.unicorn_wang@outlook.com>
 <20231007-grasp-retake-0463858c13df@spud>
 <MA0P287MB0332F80102F534CBD7412ED3FEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <20231007-kennel-lustily-59b0a9867aaa@spud>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231007-kennel-lustily-59b0a9867aaa@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [mYef3Mz2ZHNtBgJJXJe7tFy+ItH7wngV]
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <8ee1cfcb-6ef0-45ec-9ac1-31f17a1ee920@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN3P287MB1978:EE_
X-MS-Office365-Filtering-Correlation-Id: 2385e4d3-2926-4954-5cd3-08dbc73090f6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30RS6KtiZm/mtWi4m4bjT7oDG3K0wBbm8vvcTzpf9ngYTR/MCn2JgIRnME4wzocCPml3Wvm9wsQaBkhFErKn7NsKgP1NfIuBXaKsiXKVgx8Rufb9RfoOk+8Ju1bAKbPz4JnZSDFPmJk+kHcW8gI79c0uXTB0iPRg0GPHqifW/6njCgs4/rao2bTX/XMPghdapdISwIzfowk8wROWHmPJsD10URrMdhKynqIV7B/p8sbRA8OACxyRfLTGAATpAoRmOCCCTnjbsFR/L/7vJF4AHrxMbbtloI4IapWmkKwpPcEwOVpMNzxrYQmS+b/fhRSgApT9nVUyQQxijVlOIs1Rp5vdta5CB+ekVOO7ljkvC0Uounjh6GeoIb5ix9AvQMFIXwQ7+Aoh7R2GhXE29X0G/r2csLRF7ChL0u23bLz1LhJ2llZ8cYlj/Df536EN6lsW67xa4zpfn4rRdiBSwza+YWkofZaPY81YYgJBVKzVJQYyQE3yVi4xuFrHuuXuvyqf2j3O5C/woUDb19p4oCzdWbmbZ3oqhVZQ1+9iTriN+5QsM+FEFG/hiF/ScDfAfx/8VOH9n5820RctQI9Hb0QINZVcWMufGwQRhhi6QxglnZk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnNqenpxQjVnYlczdlNYS3pmL3BYTE1Pam9yK2V4VVh4cytkcjliY0JzdWFw?=
 =?utf-8?B?ZzhLQWZZcGVGNzhtNkhoSmZ3a25uUDhId0J1K1BXV1Q2eElaNmhSeW5haFJw?=
 =?utf-8?B?K0tCTTZGMkhXaUk3QzRrWFBtV3BLc1MwUUxHK2ZMZUFyRERZOHgxVzB1bU9w?=
 =?utf-8?B?WG9HTTJvd3pVWllNYmlQbFJYamlETzlsd05jSUFPRk14ZGlnUmNyRlhTY3dL?=
 =?utf-8?B?WUlHaFF3dGpvM3E5c1M4cUNyemRESS9tQWMzUEZ3TkhhdVpaL3Y5MU4zeFg1?=
 =?utf-8?B?Y2pBVERyR0hMcnFGbkdOSkhOdGN5WUh6ZmFQMXAvUTh2SFlDS09QZVQvSGRx?=
 =?utf-8?B?a1NvdGxpMm1mOGFSS1FsWHMxdzZJSjloS3dEcDREMjdMV05wWlNObjlQR2tJ?=
 =?utf-8?B?NS96UEFLTnBZV1p5cnBBZHVGT3N0SlgzU0Z4QWdvL0ZsdWJuTHVDNWhtZzl0?=
 =?utf-8?B?VzlvVEl5U2kydjcwUExwU2RLMEdZVU1HWmd3cWZVR21NNE9zOUp4bTNjSE9P?=
 =?utf-8?B?UnB4VUdxU0FiUllkTjhRWi9xMnl1RXBDMWpScW9EQXdRTlorbk04Q3JLYnFR?=
 =?utf-8?B?Z01lcllaMGl0cGd0dXpsZTVweTJKcTJ5RHE5bWU0Zmh3VEQ2NjhqR3FndXlm?=
 =?utf-8?B?ZG1rNTM3UVJuVnFRUlZVRENianA3bmhhdHBDZHRKbzVSWWhvb3llU0NBWUFE?=
 =?utf-8?B?dWplSFl2OTR3S0tUWWtudEtYTUpMTzJPV213TTE2SnJRbllZMU5jV2F3RWN4?=
 =?utf-8?B?Q3hVbVJYK0FpTnhmdnczSjJaalFlNVd3SmhuK1FjaXZ0QjRLQ1YyTTdFN3o3?=
 =?utf-8?B?aXU3b0QvMXlqc2MxMjNtT2FtUy84NkNFakNOMmFybjRMaE9mZFNOSXRoRm9W?=
 =?utf-8?B?bGdzb05iOUs5S3FHZzRBMkI2azRISzFWZ3FvUWZKY2JuN0dqSU85czVMYXgr?=
 =?utf-8?B?ZFlWdXdRamRxWTlXYWtrUG5yTzFXc2xjSW1qenF2a2xiNGhYeTJhcDhRK2RX?=
 =?utf-8?B?WmtrNEN1VjFlcHpLUjI5RkMwU05oT1pkK1laU3g4YnpySUpIcFFtMlY1R1JR?=
 =?utf-8?B?c3c5YjV1dDNJb2U2K3FiTmVJeXkvRXdxVXZMcXBGQWxkblIwOTN3T0NtSGg1?=
 =?utf-8?B?WGIvNUVJS2Y5WjhTN0FvY0pwVlRObERnb2NSMDNXamRrS3pFRXR2Yjg0a0Nu?=
 =?utf-8?B?eTVRY0RZNzNVZHFUN0s0cFloSjNxQUEzeWdNLzMxSXRTWmpDdEtBbDJzNGV1?=
 =?utf-8?B?U1hrWDMvWTI1V1hLdmF2elc0bTVvbUhGZFd2eU5OUUs0UFIxUUE0WCtLSjlM?=
 =?utf-8?B?NnBnMkpOYlppN25PemhudERLM3RNREt3Nk9CQXZicW1vTnBtdEYxZmNpcXBV?=
 =?utf-8?B?OENIVmVURWlkbHZTV0FYR0FIWU0rbFl2TjRUMXpHSGE1QVc5K0NuYVp4b3hC?=
 =?utf-8?B?Q2JlZFUxejFhVjhURlk5TFkyRzRXNC92akRPS1JBK2xoVHRiMUM4dXVkZ1ps?=
 =?utf-8?B?eldjUjRtTWRkNkVDb0FBRVVFR0JqYkxxcitEOFdSR1NZcm05clRvYVYvbWt4?=
 =?utf-8?B?MktMajRiV0tLSmVBNkRqVXlMNkY4Ky9OZ24yS2R5Q3JueWV5bEtVYUtFOFJh?=
 =?utf-8?Q?gBBcPAk/bbtK/jODQuwCNlrPWP3CRncF+6oriyFB4XHY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2385e4d3-2926-4954-5cd3-08dbc73090f6
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 12:26:01.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1978
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/7 19:04, Conor Dooley wrote:
> On Sat, Oct 07, 2023 at 06:58:51PM +0800, Chen Wang wrote:
>> On 2023/10/7 18:17, Conor Dooley wrote:
>>> On Sat, Oct 07, 2023 at 03:52:04PM +0800, Chen Wang wrote:
>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>
>>>> Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 [2]
>>>> in a standard mATX form factor. Add minimal device
>>>> tree files for the SG2042 SOC and the Milk-V Pioneer board.
>>>>
>>>> Now only support basic uart drivers to boot up into a basic console.
>>>>
>>>> Thanks,
>>>> Chen
>>>>
>>>> ---
>>>>
>>>> Changes in v5:
>>>>     The patch series is based on v6.6-rc1. You can simply review or test
>>>>     the patches at the link [7].
>>>>     - dts: changed plic to support external interrupt
>>>>     - pickup improvements from Conor, details refer to [8].
>>> Did you? I only see them partially picked up. I'll just replace patch 8
>>> with the patch 8 from this series I think.
>> Yes, only the patch 8 of this series(v5) is updated for plic node. For other
>> patches, I just cherry-picked them from previous "sophon" branch.
> But added my signoff? I ended up seeing my signoff on the patch where I
> disagreed with the commit message, which was confusing to me.

Oh, I used to think I can keep the exising signoff and I didn't mean to 
add it. Anyway, I agree your suggestion to create a new patch with only 
one change should be better, I will follow this in later work.

Regarding your changes on sg2042 series, I have acked in another email : 
https://lore.kernel.org/linux-riscv/MA0P287MB0332BA73D0135CC73CAEA16DFEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM/. 
If anything else required, please feel free let me know.

Thanks,

Chen

>
>> BTW, what I did this time may be a bit redundant. I would like to ask, if I
>> encounter a similar situation in the future (that is, only one patch needs
>> to be modified, and the others remain unchanged), is there a better way to
>> submit the patchset?
> You could have sent the plic change as a incremental change on top. So a
> new patch with just that one change in it.
>
> Thanks,
> Conor.
