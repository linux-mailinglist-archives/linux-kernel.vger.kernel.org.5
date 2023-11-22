Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F157F4380
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjKVKTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbjKVKTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:19:00 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D27C112;
        Wed, 22 Nov 2023 02:18:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YK2mjABfm956X2fjCx9zfiYqAWt9qToiV/PGP1O3pR1BQSqNmsQVKByUg3BYvc3b5jLXHnRnjsdyHpPSjMzIbmc3B+DkMCMlbnkKyV5DoswRwEiy0vGJc5YL6ZghshpmFx4IMJPgM6yBRWPAy3xKhNHzKqVxEggH6+0UTKLfPEHK/Fa5N1ulafAvOtZTCNT75HZaPIov0nalceXHvtEI0C0pitYhxd+Wk7q+n/6JEhlUtOymbW9AdyssFJPJdjLia0uHZlNAzviAmTgkbKkYfJxqusHFjICGnDMCE/JEHYEsrbPamrwLQrZpF9WbYPbI6YzBLh7ydSyWxhDZjGJ2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7JRt81xfgI+bUuQTiHMQQrBEzzv5Q5GL2RuKDFKoAs=;
 b=do4X3KDz7N2bslFU5YJRnToQcbzo4UYdwsUXzRl7ghMJZPSflbDcQDPGtDKEQQmbrO/WYe7FqK/dJFxnLm0agiDTi4T09svyU9N9uWmvwA+5z3k334Pm+c61MI2F4aIxavyC8VIklr05W58yAD7gIPlLbGTuePlItHeqcZY9soS1NGCBN5qOKUIludvNj53nUu5bv/FoGVV5NhoI8IUSEMhCcjprN+gi0odzeuIPzw+bzHy4Le+8zveighYHG0wnaTezRvtVsKEyVTKn0GZQ1cKDEbVZaTl0RjbBfK4n4rRy4Tzt2MDRO1Gg71VKZdOTGS3DE7VxaMegPni1glx0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7JRt81xfgI+bUuQTiHMQQrBEzzv5Q5GL2RuKDFKoAs=;
 b=XH60hMwMAZKg8PSig8Cj6B+wIyh+n7DhUhuPIsJLUtoDsPnsZNOHOKEmftZkvV3kuHagqbIDrzQRV0DlU/f9OlIjsh4PgDu6oUgpQe6e4X5qZmbanevv+XkTWQIktUnNDY3ZLDe4d1q0EkAdT7+BWUUt7hMn5tAZV0oGZwrwZA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 10:18:51 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 10:18:51 +0000
Message-ID: <9615bc4e-262c-4d76-800f-f359349ae01b@amd.com>
Date:   Wed, 22 Nov 2023 11:18:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: xilinx: Move xilinx.yaml from
 arm to soc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        conor@kernel.org, linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, robh@kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <ef58475a717c62bc86aeea5148d5b88cdc0cc106.1700644418.git.michal.simek@amd.com>
 <891349b7-f023-4c77-97fc-33cfd48eda23@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <891349b7-f023-4c77-97fc-33cfd48eda23@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0298.eurprd07.prod.outlook.com
 (2603:10a6:800:130::26) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL1PR12MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: bf069984-89fa-499d-105d-08dbeb446c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gvp8j9HW9hGjsSTpTPbZ0KijGoAJmlUIMRBL9kv6kZjpKWt+9DvASFj+iQY/k04ErlRerl99r4PdlUVsYGSkSjYpDmVUmsnIkDZn+YBIOGMPtA4KniL1oI5ebq7xCgzblIGujkrt7uRIsv9SaUVMxwklbiiGSbco1wuUofMqh3zLbilM+ZGEBQhmDVZx/OVqudH/0NpNvVyil4hiUzx+WJHxRloI1rMjN0KB7maVNv+55arUI2QrNeldCzc3S5Aeb9uhg3RavwwltqRi7pV9MK2XlcOwTGX9GyNJhAAnRv+xEj0llej9X2BVxRWZS3oOxc/ZmQ/WTsV/HeS9hYrgvLdEaOQmLLyxcPgvt1aGN8ncDyzGwEHCSnIi5qo9QMMg+8uGSHADkAiGuiOIdOUd97IJB4HJ6E9RAxN20uL/J7bqXK2kDJCf0TlrQIF92w5ZE31kOTOQDlEuHWlQ+6gQGVMrVTaElVUV4gyfS7ChFq2bv33i9gHwa04hzDECAEC/3WnGhSWqxIpuP9FnNFKaWLUJJMfCgB92IEoZLu5txsCpS5hH7tmkObvoipCZCXuX6+eR/XpFTMsjG62jxh+NpcVBw6J75MSL2l2bNygSQFT/GZe8yzug71cizrXnwykNryPGiJ3kPkJqo7fKKArSFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(66946007)(66556008)(66476007)(54906003)(38100700002)(36756003)(86362001)(31696002)(26005)(6512007)(2616005)(6506007)(53546011)(6666004)(6486002)(7416002)(4744005)(2906002)(316002)(478600001)(5660300002)(8676002)(4326008)(44832011)(8936002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlhBNnc2RGNJbkEyeWxTUElOTThZWXlmbDFQU01IcklZd0NHZktLTU81Ny9h?=
 =?utf-8?B?RkdyaCtBaHdva05xRmsvNHZOeEZwbHNpbm1wUVJFNzZvOHArN3R2WXBvNTk4?=
 =?utf-8?B?K09SZnM4UFl0QzhmMlkxNmxsa0syUXdVRitoRWZYNURINnlKMTVZVEhSOWYv?=
 =?utf-8?B?Uy82V24zUzNCd3VCODJ3SEp6aVRxOEhibDhvZWZGWThLT1VTbnEyclAvQm44?=
 =?utf-8?B?bG8zMldpRDhpdGs0OHJkVngrWEQ3YkV3QnJWOTVDUXFWTHErc2pPMDR0QlZv?=
 =?utf-8?B?NTQxd0p1dklXWE1BRmc0bWtWazVUeElaYUNoc05BUFk3TVhPMnBmNnRIMjBY?=
 =?utf-8?B?S0k3WjM2ZG55YmJkMjAxeU8zV1BoSWF5YXJJSklIVCtEalJSWjRTaWtuRHlL?=
 =?utf-8?B?MGhJWll1b0ZQanJhcFE5RFZTM3FQTWQvb3lRcDhnUEE2d1RxOUQ4UnVHTTky?=
 =?utf-8?B?YzdnRlc1SncveGVRbFlYWUVaTjVGMThaWVY2dG5VY2Fsa1ZvS091dHdPZHYw?=
 =?utf-8?B?eENHZjFkQUJmS3NzUVhDWUxTKzZtRmZ5QkF0RTVaS0daQjQ3Qmt0UjNEUERC?=
 =?utf-8?B?cGthRXorSzBPQ3NKNmlCc3ZDNzhYUXd2QStvVGl0RGJxYUt4UEU0TWR1U1ZY?=
 =?utf-8?B?UktvZEM5VHY5ZlJUUU51Rk8zdm9qamdhdVZPL0E2ajJnWGxlN3ltdzlLelZN?=
 =?utf-8?B?cnllY1ArR092MXlMazBJeHNsN2t2a2FJWjVIK0M1RW12SVRNc29SQ2FyejQ4?=
 =?utf-8?B?cEhVdHpmTWg1MzdhTEZ1dEJIRnpTMnpybGRuV1NqQ3FFbEorOXV5TVlRMHQy?=
 =?utf-8?B?aTV4dW13aDk5WnhkS3N1S2pMeXBUcmF5b3l1MHlXemNSSWV0M2xPM1R2bjhs?=
 =?utf-8?B?UHMrTlVlU0pTL25uVGh5T2Z3bjN0c3hFbWMyLzcvMWZBUmZWTjhaNi9EblVM?=
 =?utf-8?B?OG1pMTMwcEtUejAxY0V0OGRiN0Z4NnlVemI4NzNGanA4cVBOMEo1L1RPb1J2?=
 =?utf-8?B?amp1bkhCUk4vNmFJTExTUi8wR3N4RE1IYzJhV21qN1FSYXkzZlJQTHlzd1Rj?=
 =?utf-8?B?eDJxQTYzZVlmdEREOEFWczBxMDZ0RjRScGpFc09NOTV4VXhDSXR3YTJnS29T?=
 =?utf-8?B?bzlQRU1JSCtPNjdPYkRuTEVXOXpvTE9yS1JPVmpnU3FwcXZ4ZlBiblB2QlVj?=
 =?utf-8?B?ZmxNQ2RweTRZaEQvbmhsNm9ycVdjSFN1NEs1VGdBVEZhVGRIbmlJSG83TXpC?=
 =?utf-8?B?MklSQzV0Ykt4T1VVUkcxcDAyUWhFc2I3MFo2N2tzT0NyYXpINVFyUjRTcFZR?=
 =?utf-8?B?NVBNQU5waEIydUg5MUIwaFBnTnZTOHZ6NUtZeU9lcVJwUjFQUlJxdEx4MUgw?=
 =?utf-8?B?TS81U244bG9iRzV3bFVJTHFHY3BNN3lhSmcvYjkwWjk4SEVFSTlVKzZodkt1?=
 =?utf-8?B?S2FtQXdra09kTE4vRmxWU3NDcUFsemxodW5iWlRFOC83R3BEbkVQRW9XeEhw?=
 =?utf-8?B?ZXhNdVNNOEZNcFExQ3VtaTZvVGFZelJpaFE3K0xWbzJ3ZlcvWG1HR1hGZGQ4?=
 =?utf-8?B?MDVjUlBHUXFxT2xXNzU0eHRnZW1NbkJvc25JZ3pDZEdTUTcxeS80V3VSZ0Rt?=
 =?utf-8?B?UWM5cFRvRVFURm9qNlh0OTVYSXVOT1FUdUxJeVpiY0xsVjQ3cXNZTjNGNElU?=
 =?utf-8?B?NHhCdFZhcmtPQW8wNlA4YVBxNzRvVGM0VEFsWXdPSmJFb2VMSlRuUDVkTFla?=
 =?utf-8?B?MlhEKzVxU1J6VUpSOWZxSS8zazM5UW1lbTYrMVN0OEt0UXRtK0g4YytnQzJ2?=
 =?utf-8?B?bEVZK2RSSHpnNmZrNmlpK3pCc1YvbFdPSDEzOURESmlSU0x0TDlwd0NxSDE2?=
 =?utf-8?B?dEFiZVk3eGpSblRod1BmdmFxMEpyRUYwc1NpN3Z4bHJIV3R0S015YUJJcXdZ?=
 =?utf-8?B?dlE3UjBNZDlTbnU2MXdhWUVndTlNa2g3M0lnMzlnVEFQcE9Wazh0eVBINzA1?=
 =?utf-8?B?bE1jamZZbGFzUmx0NFFWcDJ1SE5TTW92ekpYeFFENkF1TWVyYXZTVXJCWUNG?=
 =?utf-8?B?eHEvZ2E1UWI5bjI1bW91WFJndkF4UUpWb2VnVVhzaTNVUHRQSFlyeHRxWlBj?=
 =?utf-8?Q?RPdCTuhgXU7kH5LVjMCQBOG6U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf069984-89fa-499d-105d-08dbeb446c86
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:18:51.7452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5iQRFvsX+h5nNyVfIZpyZB+UqZHk2VindbeMsCSd6A3BOMZ1aegU26IIlaqAHh4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/23 11:06, Krzysztof Kozlowski wrote:
> On 22/11/2023 10:13, Michal Simek wrote:
>> All Xilinx boards can hosts also soft core CPUs like MicroBlaze or
>> MicroBlaze V (RISC-V ISA) that's why move boar description from arm folder
> 
> Boards are cute, but boars are cutter :)
> 
> s/boar/boards/

:-)

> 
>> to soc folder.
>> Similar chagne was done for Renesas by commit c27ce08b806d ("dt-bindings:
>> soc: renesas: Move renesas.yaml from arm to soc").
> 
> The reason for Renesas was that otherwise same compatible would be in
> two places: arm and riscv schema.
> 
> Are you going to have the same case?

We will likely never see any upstream DT for it but yes that's the same case.

Thanks,
Michal
