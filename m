Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514127B7803
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbjJDGkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbjJDGkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:40:21 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2081.outbound.protection.outlook.com [40.92.102.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6AA9E;
        Tue,  3 Oct 2023 23:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ4AameLadOLiWzafHK69ECjYnoeWzUFCOsJo9DfOZgSPGE3eRXzz/qrDJ0CsiBznXUiC1k++Z8yt41f56AbqaB4iGcnFAT5cDGjVoWzsm+GaYHNDyEhOiFEFAuKZLSdIjzJqR7sC59H5dvCi7EUlzWczxV5YfLvk/NH6uby0sZfjLWV0VXyZpD1OxDqr6w5Banb7Ht3+iYgaldzq2jJbwlsJvxdLGPvEu+selwVKjrK1VVHJPd9tGimpgbBipeiwSkSM9S8chRYRkk8AWTnIc2lqcz7L4PkDqwBlEqOMayQ4GNkOotjVJITjdV3vG0XC4ifsqVqKyVx6IIUOOGl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkQNKlH9KweLWDtYFWaWJPJlhMUJIAvKHRSYWoLZYbM=;
 b=CLJo15FSNxj8rz0nkMeVAJuZiPLWJJVmHYNh0tGDSHJeDYIdYvm7oMxEKKe4Rbz7o5bZ6hpVYVmzCQJYV7dxD+66iWW4QQfrVmGkMhewlTo7XIEeHzIxA6xcwhrkFiPD6TC4/pt1xB7F7PnK9oKPoyOMKZgzscV6DfAONgkAWFpduy+OKHgXw16cC+F4RdMbb+buys4QvKB5bEjhYZCuvT+q6XZr2pPihdbEMKkKZYeRF8kbYNBf37rV55R5m0aPXdUvZ8IauHt2rGuEDwmjaFArWJszVJf8wpwFZQEWQukg+39JptgNOh1G3DuJTAThwDZh/L80hroYt9GNLFDNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkQNKlH9KweLWDtYFWaWJPJlhMUJIAvKHRSYWoLZYbM=;
 b=TDjAqMu87GQxQkMsiYTJr8IgIfZIDdB5BPjy72vVbXXPh/fqV/psjYzfTl26l230ig7EY6Ff8vvOQipDVCiqLp3P6I7oFzqYtxnkzA+ZmrcPUNVjUW27A6BQXbz0jQewEVQ25OMB6021WgyJcLAquJF1eTXTja0CkdhAAicARAIfhv5WW+N+lznYzrzuJiGwTw2PGypQbFTzdithbqPIDfo1IQrWP6eo/JDN7+t0Cp7ZzTjEyvDNhBjlN14HLllZbi+O6lPEERUS9YI7LoaawiB+a/cMaNeB9r/Y3RE3noyUGVoo/yLeU4zGGiP6Lp38enLA3ALb85ja46ArcGXhpw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MA0P287MB2263.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Wed, 4 Oct 2023 06:40:09 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 06:40:09 +0000
Message-ID: <MA0P287MB03329C86ACF8DE0610997FE0FECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 4 Oct 2023 14:40:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: riscv: Add Milk-V Duo board compatibles
To:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
References: <20230930123937.1551-1-jszhang@kernel.org>
 <20230930123937.1551-4-jszhang@kernel.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20230930123937.1551-4-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [HGqkbiE+mXm0MJZkX3+YozVKNwAWsIvp]
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <55b701f8-e272-4107-8cfc-195bef51d861@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MA0P287MB2263:EE_
X-MS-Office365-Filtering-Correlation-Id: b17ced44-133f-4696-5a0f-08dbc4a4c0eb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VjV5QIG3PQWv1HnVRB7Ts8UwaxmpnbxREMQWsrYnCc8vQh4vaq4DJ9GCM9ufJov6mkZ24UEY1Lq7JRnySiXxtxWXIRVbiEY2OXwjqaKrsUmKhPQwfPuTH1U72YFM7Je+fpQ79syhercvHxc6dAU+UZJjeboR4CCpxDVyEQ30WS8mrHpfNTsk5meefu9oo0OzL13FR4M5aUpV/k18/8Qeypi5opvGC7XgjsGZFA4LUPnxkMGGPgenhgv+oDW5MHO8rGTJJL8CNjPjA1l9T4UmrVmM5coEcpL7+RG0l6ctF/Vnvd+tkrhnsDDH8AY1fDDGV8EBZzTwM2xpOqFRNd4DteJ9M2ZSDr4PkseGbzx6An5AkQ0DZr6nXRQJhHeFE1gQjPKXhpu+cqd9UV6+Q5xP4+vul3EJi0DPSSQhILbSFFpoRb8pGGf0xnv2WXJxp/IfTR5j5Itn8VJ/fZGz1TgJWA1LE/ibcR4UE3+JmfN90gTj2DiAE4ZQU8qv7WqvQTkO0HOp/MgZh4HRAWPenu71++CbjXEXSzEq99rsqS3yZjRCB/VKw7iMxDiqp0ySOtEOsL9OrfXkoNlqOw7vgN2pDz913xsDGVrSkaGKh9ibSg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VnUUNQMGplcytmK3VONVF6WG50MlQyNFcwVzcrRnp5MFBBVlRxZWdyMENl?=
 =?utf-8?B?cFVISGMrTHBoVjdWSjAzZlduWkhkS09iNjZPaTlEVW9abXZvU1VNRUE0dTdm?=
 =?utf-8?B?TEE4aDltM1VwRHo3TUg2cHRhVlVia2hPYjhodDdqdERxamFXdHVwV1RiWFh3?=
 =?utf-8?B?b1V2dm10K3dUVFJLWHh2Y01JUFRKTGJXbUVOM0d4MG5vN0VQTitEY1ZudEIz?=
 =?utf-8?B?eHpZTDlEQTNSTXhBMG1qYXY4THkrMi95WTNZMXRvM2VFclB6d1c4ZWRmaXhm?=
 =?utf-8?B?OXJ5cFFkNTh2cXRvN0p3c2NKNFhhQXlINS8wWDBJd0IwZ3JHWDVKS1FyZExU?=
 =?utf-8?B?ZzNsbVZzZEN2U1lGSFdrTWorQU80c2cwSU81blo1N2NpYysxTEhjend2Ykdl?=
 =?utf-8?B?Mk1iZjc4d3laeEZvVEV0R1hpL25pY0ExNmNBMVAwelVWWGsrQm9jUVdYRmZW?=
 =?utf-8?B?bm1QSnJHdG4xRjByOXNxVy8yM0w4Tk9lOXFObnVSMi9aYWlLbmk4d0Z5OXVY?=
 =?utf-8?B?dXhRSGNaZktFN3hsYjhPNUs4ZEdOR2VVZFZUN1llY050YmFBOVlSeTZteCtp?=
 =?utf-8?B?dlZSTlQ2QUVOaXZxRFkxYkR0Y3hyTTg4WWU2M2NPVXhqSnpseGpkV0xoVldF?=
 =?utf-8?B?dStIY0xSaXZyZHo4MVBOaFd6M1NPc0trcjU3YVFrUlFOZ3lYbkFIOTNINkpM?=
 =?utf-8?B?R2ZCVE1peVVqTU5RZW1vdW9NMDZaM09aMHRNazg0ak43bUtRTVZWNElKaitV?=
 =?utf-8?B?Q0F1eXkzWmxJL1NaUXdEeFhqditXTUpXY0Zadnl6NjJkNXArTFExcXUyQktm?=
 =?utf-8?B?YVZzOFdPTEZnTmlUTWIrZGRXbnRISHNzSjFORm1NcGJTTGMycXhQZUpUb3lk?=
 =?utf-8?B?MGJ1OEhnTzdXUzlhdzVPU1NFRzg0RGkzNDRycXpNQmg0ZEZlN2E0R2tGS0U0?=
 =?utf-8?B?cVR5VHBsMG93M0dZVXZYT2NpNVl6YTI0TUdMdCtBTkwvTUZSWUM4cDBHUjZT?=
 =?utf-8?B?Umt2ZEtER2FoUTBUcnZDdjZpSVlkemNzVVkxRWtneWkreHI2NUNnamVkcnZr?=
 =?utf-8?B?Z01Tc3Z6djRGSkcxaitIR3V0dXczWEx1NkxyMEY0cWx5dFFLK0YwakNxUk1S?=
 =?utf-8?B?NmJuc1Q4Z3pBamJheS9RUTN4VlQzUG9ONEZpOWpYdXJRbDlWNExzWlpHN25W?=
 =?utf-8?B?VEc1L3BGZjNiWEdWTk1kNERGY1Fnd0E4SlFwTEhSRE1sQndLQUp4OEExaVdm?=
 =?utf-8?B?SUQvSjU2MXhJbmdsT01ubVA2UmllN2NRR0JnSE1XQ3JEb01OREtCbEhiQ2VN?=
 =?utf-8?B?RG12bUoxQzhSTXkwa2c0bU9MSHJrK2I0VXV2Y2ZYdE80QkVZbzlyZGV0NGIw?=
 =?utf-8?B?b2d5Zm11TjhFZlVwc0xJNXNrMXJlNGswcU5zZUF2d1lCVzJ3NFpoaEtxa2xs?=
 =?utf-8?B?M1dKejRuWEYzbGpQeHZiVjc2d3NqdlZKbnBBSlA5cjl3YXBqN21pd3FQN0pT?=
 =?utf-8?B?ZXYyQzZ1eG5PcG8xMXV2TWxyMjJ0bUJoTEVjS3dVVGEwQStlNVY1YndRT1lP?=
 =?utf-8?B?aWpmSDYvNERBMkNyakJrcmZkclhidTdXM3VYVjl2YUNpd0h5ckpIdVE1Zmxx?=
 =?utf-8?Q?j4YaBVGf2S4RaYgCAXTVeokkjCnB1j3XxVXGEUIdsgHo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17ced44-133f-4696-5a0f-08dbc4a4c0eb
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 06:40:09.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2263
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/9/30 20:39, Jisheng Zhang 写道:
> Document the compatible strings for the Milk-V Duo board[1] which uses
> the SOPHGO CV1800B SoC[2].
>
> Link: https://milkv.io/duo [1]
> Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   Documentation/devicetree/bindings/riscv/sophgo.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> index 4e8fd3c6a6ff..6db241c9d00c 100644
> --- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> @@ -18,6 +18,10 @@ properties:
>       const: '/'
>     compatible:
>       oneOf:
> +      - items:
> +          - enum:
> +              - milkv,duo
> +          - const: sophgo,cv1800b
>         - items:
>             - enum:
>                 - milkv,pioneer
Acked-by: Chen Wang <unicorn_wang@outlook.com>
