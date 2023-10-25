Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB67D5F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJYAtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYAtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:49:09 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2032.outbound.protection.outlook.com [40.92.102.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77319E5;
        Tue, 24 Oct 2023 17:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNGUkXorBQgPR3XIoQvuQwdSIMDWEh1rL7YGBwT2SagSdjRQkiwlzVClBRq+oG80M5tCEXXnCO+dACXvCcwpbfd90wCKDtXnKGc8zqTqcN0djcGs+5QNu+VZRJfA3oL4Cd21uE60Qf8vcpinqA9O0KiOWXwd3o3sOsI+3AH9muiFjBi4cmd9oBMjbvUdcIU+r0Tu4OPv0uFqk/dH0LY/nl31N7NFp/RzrswfHKxVig8oxQ/+0vLNKTcczHSt9qHkwswaA8MfX1nfp5mcNMEX/VTCLN8sZcTPfmcex+80AU/KNw+Xx2AhdnwFhoLdXKzGxEDaHKDT2nBBIWF1PEviGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnRXckoE8o5ieiYWdmKmvUktpDSfNXWX/dVI+emY/DI=;
 b=BQ4L5AMZJYw5/nJyXEXpbvU+wXOx5lY3HMYpyJ7lO3lfTG2KGIhS4oUlKoe9D4FKLl4MJDC0eQjt6s5lKqcMFKa2BQ/dEXg69TqrP4VwrOYay7jM7Hkeco30RThADMvlNhfz2IKOrGqydIGTXEmjHXSKmRw2oQfs/m4V1vGOCxQUXt0X1FcapDMza8XQ90Mqsn9VGcbwA5ZJQD0nmeJLbsRNuYm55zsOtkE07cB5xHa5QFq3YhzIaiIkLH9lMnCKCPw4FNQ6bsHUMzDfB2lH/hZVbwITI/WbXbnf9wsrVjFQ23lt4XVF6uHhdr1yhZ6k93k9sjIzFZPwKkgllZjI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnRXckoE8o5ieiYWdmKmvUktpDSfNXWX/dVI+emY/DI=;
 b=FHxePgVzJWDZEeWO96yCL85a/vS+6zM1HNMblVWr9gpNKSgkBv9RPdB+TZPWyq0Ln5kdunjDtXtuAmgDHHyW/hkl2W9TPLDq8/DSMFMWSgUdn0pLHQy7opKG3SUP7rWx92K1SoGq+4BjnZrKAy2LQMl2gNFew7OOeHsSJR+OYBmv5tNjyJoUsUyK3cizGo6bNPgxfpLl2foUOB3snegwWjEb4gAfK3wJRBH8nW2ea0c1fOMULw9OH+cc3C/gRXYRCYXLSccQdIILzFDftOMRybl+cOudHfc2El3T+B8g7JzwUTkbooPA80eIQqaKnhThk6QVh4Zry5lEtv8R0rM3Xw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MAZP287MB0519.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 25 Oct 2023 00:49:01 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::d479:bebd:2f6a:caf0]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::d479:bebd:2f6a:caf0%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 00:49:00 +0000
Message-ID: <MA0P287MB0332C00AB091FD7139560E25FEDEA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 25 Oct 2023 08:48:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] riscv: dts: sophgo: remove address-cells from intc
 node
To:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231024-maternity-slang-fd3dcfb211c0@spud>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231024-maternity-slang-fd3dcfb211c0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [KrLksE9OeS3RxoMfgpTIYAzV/Gr/mtBh]
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <6781c916-69b0-4eaf-b8a1-ba77d3fbaf25@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MAZP287MB0519:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c16334-07c2-4cb0-1471-08dbd4f42d5d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +UOu8zsMzzZLITwIOab9geEBQYYVEqcQL40YgjwPiHy9cPtivydwEDOS8CIVum4bXzfuqF0yizICumr0cItmnIQk3U4pZTixvJchWK2CWMaOWFRLF5alFby/lK1saxEAVCA+pehsUH92at+g97IZgPYo7M1R3Ifta2qILBjd6XFtFfGLqns0YKLF+SMb0U8rnYK/pQJEkKtW5bvfrrHVw6jHJ8coJTaotM+DDhOW2e4BmEfsfGt/SHoPcuZHMbv7mIqJBGv1VZ1NcnR3L/G9nxNZqRy30/3LbKzt9j+Rew82UxYGOAJZL4DpjM3X33LE5yWVW37MY6wnqMp40pXWjSIrwX4/uFuY44MnWNlaAv6750Jf4K+S80KrrfMBaa3/TkhwSFYTPC4IEUBdSC7FIYWJBnqXDuIEqJYQEHlWKF7X7hyrp3ruC78R8DFrz6kucfRDSyq4ml1obiwkM6eHvb56nkmwjMO6jnC89a+vTKHZRi7cz1BKyZvkZUzNph0K7cV6ZOXiwLxkshYEXRQII6sN+M1IHalT/Tcmh2W/nvOI3iWSopA56Qmp/hHeRZo4FdeSlTbTkpklp4D5JeJBQLqls7a3waNZ04DbdeS7vu0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhFcTV0YzVHTEJ4QVpDb0l2SWQxNlJJeDZFeFd5LzdOajRQWmFZV2tvSmY0?=
 =?utf-8?B?dHFzTzhsVmFPZDNZaEFveWwwcEtURCtOdjdJaWtOMFpFT0x3MlJBeWx4Tklj?=
 =?utf-8?B?a29VcEwwM3F4Znd6Z3hXMzRMSnhGVlQvUTg0Q2xyOWNIQUtUcHo4ZTNJY0NW?=
 =?utf-8?B?TjlwQXh6ZGVlYW1OU25uMi9vQmJBaldZc1ovdy9qQUFKWnJHRjBCTTZLVEU1?=
 =?utf-8?B?VG8zcVVRY3hNMUpab01JRFkweEw3MmZoNm9VZzcrbml4dEEwekdNZFRjM3hl?=
 =?utf-8?B?dHdQRytOZzdvVi9uTTBnaXBKZER2SGFPUStLcXFMWVYrcng5MUZtNFY2aTM0?=
 =?utf-8?B?TGhyMlBtTlNoSVAxa3JmdnRoQmJBYTJjbVBDYUNCamxTdndkOW0xcW9lcUlN?=
 =?utf-8?B?b01zUm9iaTBXdjBaSVk2ZHRWUVowRkM1ZmF3VWJDVUVwS1lReU4xVmM4blRy?=
 =?utf-8?B?dHU2UlRQdWVGWHQwNXZ6Ky90eGdJYUMwMHFud0R4bGJvOGNuMHFGTHFaMU1u?=
 =?utf-8?B?Qkt5RGp4TGpnVWdmK0xDWllVYitCVk9PNU1KUjQyRW1sb2RtL0ViRTM4YW9x?=
 =?utf-8?B?TlN4clZkclA2QTVTNzUzQzE4OEk2VU5CSVRZL0I3K2w0aGRLUFNUcW1mcFFL?=
 =?utf-8?B?dEVsTzNOV2R6Sko2VW5nSTl1blY3MWRhV2lTeHk2Mkwrb3IwdEFBM2lNcThu?=
 =?utf-8?B?MDYvSDlFQ0lWWEZ3dERDYkFGZmdwMnlUUzVZQmhPdnA1QXorRTFaSkJjd24w?=
 =?utf-8?B?cDNReG9CckZSWWJmclltU0tNQ3FJS1RhdEdHbnkyVmd6TStxaFZKRG50WkpC?=
 =?utf-8?B?U0ZvSTc5V3BScENkT0lPVEpGNWdUQjNUSktjaTVPRmttSGJvUElmRS9wZ0U4?=
 =?utf-8?B?cC9vYVdtTGNnTlBEdEFUTFcrQmlEYWtRQlpZWlB3QWZ0VXI1WTErMThpc2NB?=
 =?utf-8?B?YzZ6ZnNEOW16T0FzakxabzcxRldrSGQxcytvVVdpcVlTV09mZnd3bzY2RThN?=
 =?utf-8?B?SGNwdzUzY0YzZEdicVlDTDBpQ28wZFppTGRwUzZPUHBiZ25BYWdXVC90YjVi?=
 =?utf-8?B?dVlLbDFkU1RibmFGWkROQlBsUlhYaEpEMStLOU5YNzlScHJMNVcwdWxsWUJE?=
 =?utf-8?B?QmdkU3FYdjZILzhZRis0WVMwRkFUckZ4UXo4Q292TTVTd2dFY0dZSyt4N25Z?=
 =?utf-8?B?akxxa2QyTFZNeFRiQnVrTjNUb1pRWnJ6N3ptcHAwblM3T0tsNEJhRmZ2WmFG?=
 =?utf-8?B?RG1scExZa3dhakJBaURiTU5LcE1BWGxmOXBPc2hETzdReHNJbmU3d0VJMFpX?=
 =?utf-8?B?bVNWS0RFWGsvZDRaNFpGOC9yeDBxV1ZUd1pVcFlIQ3ZYbDQwV2MyVjQ2TkVp?=
 =?utf-8?B?LzZyQnhNVWtZU0NVY2k4ZHFaVXNUMnM5SFp5Tm5zRzQrcHNCT2pTRWVrVVFL?=
 =?utf-8?B?SWR1Um8xcnU4SCt2Z3lGSHNZWE50b3V2UnNQeWoyVFNhcXlDN3lWSk9CVnJR?=
 =?utf-8?B?UW9zbjhVYUNVWlVsYzV0Zk5sYk9UVWRhMGdvS3EzM3ZlZHZBVkE1RzcxRHIw?=
 =?utf-8?B?QVV3SVo2S1U5YkdHV0dvNWcvd3kzMSt1UXB6dGNTSU96WU5DUzZWWHFHaURj?=
 =?utf-8?Q?/iJDVHzr/sLm5cRE9rtfyeAzHMwO7tIMOfIzNTG2m7J8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c16334-07c2-4cb0-1471-08dbd4f42d5d
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 00:49:00.5536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0519
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/24 16:20, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> A recent submission [1] from Rob has added additionalProperties: false
> to the interrupt-controller child node of RISC-V cpus, highlighting that
> the new cv1800b DT has been incorrectly using #address-cells.
> It has no child nodes, so #address-cells is not needed. Remove it.
>
> Link: https://patchwork.kernel.org/project/linux-riscv/patch/20230915201946.4184468-1-robh@kernel.org/ [1]
> Fixes: c3dffa879cca ("riscv: dts: sophgo: add initial CV1800B SoC device tree")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Chao Wei <chao.wei@sophgo.com>
> CC: Chen Wang <unicorn_wang@outlook.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: devicetree@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index df40e87ee063..aec6401a467b 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -34,7 +34,6 @@ cpu0: cpu@0 {
>   			cpu0_intc: interrupt-controller {
>   				compatible = "riscv,cpu-intc";
>   				interrupt-controller;
> -				#address-cells = <0>;
>   				#interrupt-cells = <1>;
>   			};
>   		};

Acked-by: Chen Wang <unicorn_wang@outlook.com>

Thanks，btw, will it be merged in 6.7?

Looping Jisheng who is working on Duo/cv1800b.

