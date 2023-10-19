Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391A27CF7D9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbjJSMBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345475AbjJSMBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:01:01 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2105.outbound.protection.outlook.com [40.92.102.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02709BE;
        Thu, 19 Oct 2023 05:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbZGxWg9+iuz6P+q7JCCoVbot1T3pqTlmbc11LoERjODqlISxKlxAaykWaGZZ6MO3H0w3vCrXRYGh4CRMKVKC70AmZeGetD5ZZU6HTrZA2DJ/bDzghfguaBruDbgn8FUCJD/njHpyTkg3hPFG3UEnMlypKozDSt4CI8MRPpu6xczTAvDPqxKtsBCNmStzudyW7ldTabDjMrpci7oDvA+GEVmvXUU8eWs2NCYo0tiHkQnF585++3aKTeWR0C2DUup0xjEMmvDmDgc85BToEX+5FtJxPSjpCyIqUuGQ8q3lExB+4RQ7tlGADrGlsf3chHimbqTc+SLEtYnzj4j36Bl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlzDjtdQVb+01Z78jPa66i6sQbaOtTLhQ2SHhg9QmrI=;
 b=SQc67bn4cOU0+/HoRkyMMTYJjFr0GdW0DQo3/24i3Pp5UhdruZiFCddW5IfzSisjMvBByboAc5IyQ6UMBVX/X4nn5ViU+U4fqCzyGSJtcigOncbD9PAQvfNl/ve0pVMb8WHBTLX2BgFIui+jo7UAnfa9+dhYzyGZMpnxXsdGAri4wG4x/Gs+9a5QF+iLbGwSDsn/jT2uokAuk0AM0MDdddhUxFQd2WG9hRW8oEorrqJFMxL9NBxBUofQx5yHSqbL8dpmwckC7X6qtITjRyBqUKA2HBucqJHaaCDVcVbippyALeqh7ItocJ/kl9HVu4OSsalg7N+bvJxgQl275SgRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlzDjtdQVb+01Z78jPa66i6sQbaOtTLhQ2SHhg9QmrI=;
 b=ic8xWZ126WsHTiKnPkUILFMijiAq/IgeLO8CHDxoMwBGXb7JNqdh+aITMCGZlEG0VpunFHmz1sUfHEd6Jkv7ANYOUb2a/o/C0rLjsvgXKL5b/6NRp26IbPw25O4U7q72H3dJTIyICt9YcFGzWrakCVOMUqIpZ/wmU1EEI8c3X7geaG9kmp1Z5VLHLufAjOFdiTlXy7WG47/aGZBhDhGon7aDenPfajrDv7bvsQyBiGej96hw1ClExIzZ92Mr9xFRMQQ0ks0iwpVs93N4QGsMETW1aIOp8xA/Qap+DZ6gMs3Wf6cPVGGX3CwBEypxRcTADcF/7H6CRT8TNEYBSjKQ1g==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN3P287MB1233.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:196::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Thu, 19 Oct 2023 12:00:52 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b66:61a1:8ed:cc6a]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b66:61a1:8ed:cc6a%6]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 12:00:52 +0000
Message-ID: <MA0P287MB0332DA4D8F57D0B15E8B9E10FED4A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Thu, 19 Oct 2023 20:00:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] riscv: dts: sophgo: add Huashan Pi board device
 tree
To:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49539882B957DF39AD77E539BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49539882B957DF39AD77E539BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [O61rarMArjJoywS/KcHN7cUD9ZRNcKLf]
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <c6655bcb-bbe0-400c-b9ef-ee16874d0bf4@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN3P287MB1233:EE_
X-MS-Office365-Filtering-Correlation-Id: c40c5b50-2c00-4599-e2d2-08dbd09b09a1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TErgvkGQVqXEcyuhiSezTOfFQGzlNrFDUrMUCC44yPA+HXfFx3p7kD20uabJxaExOduTtSh4+1hzhl+bXCI5nZ9b4VoK6MFwGzRNiDIpTlR0NC8HO767gDp70eO2BLCM5vvycfwdqk2jtBh4jN2rg9v3zTMsuOBAcENfEY7epfltCVYc4iEcIO2MwrGTgoa8+M/RnVIY6Q4fPvgPIPLMl04sTo9Rkka9NDR8w0qr9ERslGcZd8R4u4CV9wNFej2MLQCz3h0DeZuj9aK6nTgaf/aQZFeLpA0b+P5M3Y26jvOM/W6WLIJ6gCZ2x+PNrnmVQwZKQ0QaLHI2NbKJ8XEZEpx8RdseclnIOr75C+/hGrxea9fEdqLvl+BnRKGyH4YPn3bU/dbtwoCd1S14VoCe1h+vsbQKYfi+ouXyg2y5QrDjXYXFbYJ9u9nLvo/aLdCK4ebBFNlmk/vL1eiO+nBOi7HanbdLM9qC9h93dEt5mPT9w0lGEc4gk+ZiEEiPhBoqr7MCVpfW26bjJcoCkIkHYmbNYR00LM6vts3xBdgYMHZn/tT9UxmDGLrmfjtnwSDGOIowmuaCqJw7Ucv2ZLXwsUsrpjSGLj+2dPPzcKlzdx54uily3ew2qpGTQwIDbQX8gIJjfaCrMQVP8TUbj99AIQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBwUWx3dS9CZ2MxRnA3Z1BKdU5lRVhURnFYTFByZTUrblJJRERRNnNOd2JO?=
 =?utf-8?B?cmNMRUNqRi84aFZKdTBkU3NhMjlZek5HS0tpNUZCV3ppOGtPSGVpSWFUeXZo?=
 =?utf-8?B?S0VZSXVlakdIdHNickdiOWpSbkxVdk91ZVphTUc4QzUvMnk1T3Nnc2RSZnFz?=
 =?utf-8?B?eFFnVUs5dFFPaFdRK01jdC9YSmVNL3BweFJHS2ZxaVdmQjZ5Vit6Z1hTbjNy?=
 =?utf-8?B?SElaNFJiVlhTWHVjcUI1OURVTnI0R1BKNGo1R2JMSWYveWc3V1Axc0lwUWRq?=
 =?utf-8?B?WlVBYW55dWFwcXNPODJoMFQ0b0ZicVJqRTh3SFlOTkdKT25TclRKUmQraGhZ?=
 =?utf-8?B?UHdCSVhCYjkrVFgyQVYvQzBRNmlLbkM3VkZSTkhNcGNlTDVONCtwMWVNWUdD?=
 =?utf-8?B?cGRybXhsWWkwSSs1Nmo3UWJDZndCWEdzNHNKdVA2QlBVa2x6UnZOZWxyQ3VD?=
 =?utf-8?B?SDY4V2VBa0F4ZnNha0FiMFU2L3NHOTRYMGZHYUhZYzB2V0wxcXpiTDU0SVlM?=
 =?utf-8?B?TGV1YVU1NXQybGwzUUlsa3g3YUdES01oRk1Hek15Sm5oRzRpY245QXI0eEpK?=
 =?utf-8?B?dVl4eHFPM1ZxUFRqRXY1QlA1b2tuZzhjZk1DUDFOa240Mk4xc1FLeUtXWDh1?=
 =?utf-8?B?Z0hOZis5OE9henpxVWl2cUpEeGdIL3JDNTlEMGc4WE5hUkJIam03VFZRQjZJ?=
 =?utf-8?B?bXRsb2Rwa3VPaW1XTGNMTHgrdDZvNmRoS05qNG9ML0MrV1FlYW1zd1l5akZI?=
 =?utf-8?B?TGpqN0FHUTZXQSs4ck1hcEFaNW54YmdudjhkaHd0SW9lckljdHhKOStkTEVJ?=
 =?utf-8?B?N3UyNlh0djJmNUN6NEo2N3ZONU9ENDdhYWl3dUR3TjFMOVNkRUFKTzNjSFJI?=
 =?utf-8?B?QXRoblVjSUhMMHB6K1IvLzczZmtUMHNJTzIwd3pBdDVKK3VFY0dHTUVnVmpt?=
 =?utf-8?B?d2ZwRTFlYkdmZHpUVTFLVnZ1S3l0RUpPM0lpTWJ2SjdlYTNMazcrQTZnajVN?=
 =?utf-8?B?SHlqKzZMcTNtZHBoRmdPc3JmS1BVTXZic0lqZUF6NXZqQVVJbW9vaHM3Q0o0?=
 =?utf-8?B?V291UDZDTXdGTFZDRUJhNDk0NmVTc3ZiaDZHVWZFOUhzYWNPR1FRQUluS0pR?=
 =?utf-8?B?bm4ybEFEbmJnb0kvK0x6RUtsWmM3WDR5SHpuK1RKQyt2QmVhdmpIZzBTY1RM?=
 =?utf-8?B?NVB0Uk1tT2FsTkpIS0FETWJ1Z2dwOGlaYU04NXJUOEFBQTNpOUdIZXdDK0RP?=
 =?utf-8?B?NHoralFwT3QrbWdabm5NUXhpdnQrenZyRmJQWC9DeWNNSHkxZXphZG85d1M0?=
 =?utf-8?B?aGlqKzl0bzVjOVhwK2dQRk9KRXp5dCtPRXFGYVNRU3JTRVV0dmRNVVpCWWFv?=
 =?utf-8?B?U3JxajdVVFpXa2hMM05BWE5qUzRlckFSS0VZRE42RTNGeU1yeHV6RVU4NUZD?=
 =?utf-8?B?SzR2SEJLbmpZNkxKMSt4c1NQeWpZYlcrcjJMTEtsTlRWRUk0MjFKQm11eGRK?=
 =?utf-8?B?bWZaOHp5SjRRb08vdXNNaUVQeW0yRllSWTBqTUZiVlBkUDZFUk9mMWw3Zlhz?=
 =?utf-8?B?VWNoREpCZDBYb1l1NEN3UkxVQzVYM0paUk5yVCtWdjZpUnM1V3p0MDVmc1lQ?=
 =?utf-8?Q?Naf3f1UMfFNHNaAkb/c4P1D1JDgjFozHcPyTCzk5tJGM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40c5b50-2c00-4599-e2d2-08dbd09b09a1
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:00:52.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1233
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/19 7:18, Inochi Amaoto wrote:
> Add initial device tree files for the Huashan Pi board.
>
> Note: The boot of CV1812H chip needs a rtos firmware for coprocessor to
> function properly. To make the soc happy, reserved the last 2M memory
> for the rtos firmware.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://en.sophgo.com/product/introduce/huashan.html
> Link: https://en.sophgo.com/product/introduce/cv181xH.html
> Link: https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/build/boards/cv181x/cv1812h_wevb_0007a_emmc_huashan/memmap.py#L15
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

LGTM.

Acked-by: Chen Wang <unicorn_wang@outlook.com>

> ---
>   arch/riscv/boot/dts/sophgo/Makefile           |  1 +
>   .../boot/dts/sophgo/cv1812h-huashan-pi.dts    | 48 +++++++++++++++++++
>   2 files changed, 49 insertions(+)
>   create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
>
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> index 3fb65512c631..57ad82a61ea6 100644
> --- a/arch/riscv/boot/dts/sophgo/Makefile
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
>   dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
> +dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
> diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> new file mode 100644
> index 000000000000..aa361f3a86bb
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "cv1812h.dtsi"
> +
> +/ {
> +	model = "Huashan Pi";
> +	compatible = "sophgo,huashan-pi", "sophgo,cv1812h";
> +
> +	aliases {
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		coprocessor_rtos: region@8fe00000 {
> +			reg = <0x8fe00000 0x200000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&osc {
> +	clock-frequency = <25000000>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> --
> 2.42.0
>
