Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60D7BCE7E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbjJHNIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344794AbjJHNIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:08:35 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2041.outbound.protection.outlook.com [40.92.102.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9D4C5;
        Sun,  8 Oct 2023 06:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVkVzGr9d1MgUB9TF6taOfJ/Xx6tpqQG44IHpEbMWSnBF8OxQhzEHXUBQoCBseCEO/pcggJe8tmCj3zMr5o0AHQB27PJD1Pg7o29jCRCGmJCZ6iz2NHSNmr2J9OzGHAkITzPdVhwKb4/P1O7J8zTe87P97cJx/azdCEdAAxRszf2CHL7+8BwNYVZRYPqgCLrVgAiNx7vMI6oUh4wf66VOwkedmj6DX2O4RdMmWVRHkIjtN2qRiJyRaq2qtkEWZrN/SmCzGk6vARTqNc7Ocbk2Yebzc5XAgFUuA7WO5+/w/4MPZOfUVSA2rbhVfZ7HSzgEDbixvAFhlZS36pQDfqGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkXti9vLLgFwCJTM3ny1pcK++mrbqMhT4VmPuWb73K4=;
 b=jDm0akdEyNEWBYI7u+narlkIpM84yqlJ7L1tmQ+m4rKVtNYC5T5i2fBdBTEnBAH5qMnmiwAzLjQgWtlMHhuXd7pujJM8a2WuPRRkXtFuMzfUQIz2Jt4kPZfsKsLG5EWsXqoXNmrJc6tsTbQ0VOTm5QoENlPBBXoh+oBCJms6VxuJY06+Cgxix124l+AeV4s/rmSuyQ8f6pmzhNaJVl2nbvM3raa6+QDoMjZIA1AdlESDi8NloPn3SzAGxT6Id+65pB3z/Ot2ViQFlatYigTgRt9gXNfv/MNW6Oebom6NJebXGAOpnxpkkEDjuXQL4yofVaxSFMWIi7SInojCnWp0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkXti9vLLgFwCJTM3ny1pcK++mrbqMhT4VmPuWb73K4=;
 b=MtAtXbIIhUpJ8vUJXjeh4zkDgeUPjOv7Q/+xRw9E1OUTQeZZF95Ju4xjrUUBK6s86SgR183W1Tr3aW3nbkcgoOQ322Ty4ByHKuvaBW9flA3LO2wFdjrsnOVAX9NBfA2OjyA93mQrNNobnCAqlAMISYo0F2ZGcBs75ato1fl6yqIWehv7iO17GY36UBA3pY+V8WtC7t0Z05xf1RRCac6Xsdg55FEvcpF7eFTMComNdY3sRbosRptKA24WO68LvfaAhVIJHEiDMPPREz/OPATFDO+pGCxyq8Jg5pYKt8y4g2+E4VO6bMH/x9+m7g3MWxAvlzhKfFGAxiPPcwiLRYL3XA==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MA0P287MB1574.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:106::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Sun, 8 Oct 2023 13:08:27 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 13:08:27 +0000
Message-ID: <MA0P287MB033256BCF2898DC111CA52FAFECFA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Sun, 8 Oct 2023 21:08:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: riscv: Add SOPHGO Huashan Pi board
 compatibles
To:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <IA1PR20MB495337659E69ADA1A8B1596BBBCFA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231008111627.325468-1-inochiama@outlook.com>
 <IA1PR20MB49537E0C8B54A237B3472C6CBBCFA@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49537E0C8B54A237B3472C6CBBCFA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [YZBUxmPvF/6TwJd8IjTpxaE2odxgwE6d]
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <193f0a99-25d0-400d-aca3-2aad034b5ca5@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MA0P287MB1574:EE_
X-MS-Office365-Filtering-Correlation-Id: be636461-6e86-4380-62aa-08dbc7ffa8c2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXmcOT6ASlXNGkrXE2ssKu+YMkYPl47dAwu4cX/7kHJfIvZ6wtgHeBN+Jgxy374QPg9fbWNblAqrfBNlFzd7bD5xXS0A+UsyDbV9SYzltI0ov9T/WVGsiIG79L1uY3J494FMSTu8yDVBv9DgxmMqNkaY3ezqKahZmtV5ocj2hWPoy1S7oG3lAEskDGSn0YIDk99IU2iGbTuoCJb9jyIxPR82Fs0fG8YkL2to6LAAvD1kEcaKNNvLNtaPCal8jyGG3vZ+/JExitl04GPxsRvTlEkFHhE74Z44xZFic0s6o0/OAajZAShJjKWsZDWnolT3VOvHR69qnmTw1rpv6MzltVC0WjuV/pa5ZjGZ5d8CDWTzbgf6Wb+FPIogJJsxXkfym7WCZMsl3M2wjI/s0ywrKgFPZteuo/hfLJmxkoJ+ZKHexrmbvmFN//2NXVky8OvcoO2gDaqCGjYZ9uCAjTn1I4+NAqgyBjwqa9ljq9P2bt975PXZudk/8hBR9yVztkvST0h0DxbdpxNr2xmmQ6lr2aV9frRlsI++Cg1AO61k2eYTUtBilEW3cc1hzJKkUxBqT5/2tAWqBasrV4uTtxTa+8BJc4umvYEmDCf/RCs5NUVnV0N0QGUp7S3hyZRI7j4gcgdIaka5D9PuNHXJkZV+bA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFg5eWxKdDZnYW1CTEFNYnhYWUdsVm5zUk5ENktjR2doSnp4N2M1eE1KRHhH?=
 =?utf-8?B?NTdNU05WNDloOUtzMDlQYk1ubW95c3pBRElERVY3c2FzMWFDME9YTkduc09W?=
 =?utf-8?B?dUE4bTgwdjEySDRFUTB1bnhDKzczaHU2TmJsQm8xVXR2Y3V0cTFqb1RLNGJy?=
 =?utf-8?B?dWh1YUFpaEhGdDJTS0RUb1FFMms5ZUhYdUQ2b0djazdqNGkwSmYwanltMzRX?=
 =?utf-8?B?cmlmM3lvWk1XQU5GK3JMd3ZPUTdZS0hmY1B2QjNRSjRsZG8xS3JMbVJJc3Qz?=
 =?utf-8?B?VUhtaXdaZ3lESnk5QXdhOEdidG5QTS8vRWQyQVNyWTVuS2plVXZPMUk5WVVX?=
 =?utf-8?B?a3BkOUc1NnVlSkdsM1Y5WW5zeUxpc0hsdUl4MFJ6MWN6M21SeFJoYXFvT1BJ?=
 =?utf-8?B?cHcrZDVNKzFPSDZ1N3JrdHpjNjg2R21qdkE2YVZWRXFBekJSOFlKNld5Ni9U?=
 =?utf-8?B?SG43aGc0MHJBSCswSWo3LzFPT3J6NTZCMlFHNEh0SFlsOUxqRTNFSHJQckpz?=
 =?utf-8?B?NUxTWFptSWdxUHA5cGhBNXI2U3k3QUcvSnA2dHBPVG4yYm1zQVJWRGtVSHh3?=
 =?utf-8?B?d1I5aWdHcFhsQnJqTG1Sd1lleUVackQyL1Q0ZU9yZlg0M2FqbkJ3bUViVXRC?=
 =?utf-8?B?Tk93UWVGa2ZjVTVTQ1lEVjQ1cDRhQ3kya3ZlMTYrVTRvTVA5eTV6cWcra1Ur?=
 =?utf-8?B?NGY1bXJZa2t5L2M1NjRDeE5FOFdmbkNxbDlKUGJJSHZoRFh4WHZFY2RxUlhH?=
 =?utf-8?B?MUxVYnZqNVFtWFRPbWpIakpRT0NWVitjUDRZYVFNOWc1cEVOQ3NDcGkyQ1Fp?=
 =?utf-8?B?Umh3enpUV0ZRMGZKdEoyZkd4cGJJWHJZNXJEbmx6ZEdSUFVxeDVIQU5NeFNT?=
 =?utf-8?B?NGRrOGR6RXZydFBOejloVUdwQVJIUXptbG14WG5EQVVMa3FvMjM4eE9pU1NJ?=
 =?utf-8?B?bGpvZWpkM2tDUWZaQlFWaFBZRmV4TzRHWXoreE91OGFveGsxdEEzZkRaN0Np?=
 =?utf-8?B?MnBnOHN2aWtZVE41VlpxYWJwWUVHZWo5dHJ1dnFqbk5STkp3ang5ZlRaMXVj?=
 =?utf-8?B?NnRnZDZvVkg4SGRMZ1F3c0hsS3lXOUlEeEZxbDBVYUFocWYrazkxcDhpTFFV?=
 =?utf-8?B?TDZWZUptT1ZuWWZKbllUdXBqVStoQ1RFMW1Ia1d6ckcvVUcvamFrbEpsZFRY?=
 =?utf-8?B?QU9PZkpxN3hzZUN6ZlBaa3JHU2RKTnNMZXpHbGZyK2d6T3lnSzhmSC81OWpY?=
 =?utf-8?B?ZlNKM2xwdEwwNkV3UXFKaGNGcDZPa2pFclFZVFlmU1dSMzhlVHRCWk9kQzlo?=
 =?utf-8?B?VFkwbDdyOU1JenpSamdhNlJVdnZGSit3blNSMlJXR3hnaW1lczlEaEhCem0r?=
 =?utf-8?B?Rm9lNml1eWliM00yRGhXc0VwRVZ2Vzl1anZ1aEJ4THBIQVoycFdDOGF1OUF5?=
 =?utf-8?B?S1F0amNlTjd5SmpLVlhIeldEK1lsSEJqSzZ2UDVQczJ5NVlTWm5aRDFwaFJ4?=
 =?utf-8?B?UFk4dEFFTUg2NzNoNTVyK3AySjRXbUZZb1dXV0RYUk9zbldHemI5SXUzNFpm?=
 =?utf-8?B?dTZ5V2ZwbnlNVDhGeS9XdTJJZ09YQ1FGenpoSzRCb2xEaDg5VC83RkQwSExV?=
 =?utf-8?Q?RsNdhQTGtloQYgdQaOhsRvFY2DpF04WuYG5fdhPqemUI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be636461-6e86-4380-62aa-08dbc7ffa8c2
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 13:08:27.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1574
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/8 19:16, Inochi Amaoto wrote:
> Document the compatible strings for the SOPHGO Huashan Pi board which
> uses the SOPHGO CV1812H SoC.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Acked-by: Chen Wang <unicorn_wang@outlook.com>


> Link: https://en.sophgo.com/product/introduce/huashan.html
> Link: https://en.sophgo.com/product/introduce/cv181xH.html
> ---
>   Documentation/devicetree/bindings/riscv/sophgo.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> index 86748c5390be..9bc813dad098 100644
> --- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> @@ -22,6 +22,10 @@ properties:
>             - enum:
>                 - milkv,duo
>             - const: sophgo,cv1800b
> +      - items:
> +          - enum:
> +              - sophgo,huashan-pi
> +          - const: sophgo,cv1812h
>         - items:
>             - enum:
>                 - milkv,pioneer
> --
> 2.42.0
>
