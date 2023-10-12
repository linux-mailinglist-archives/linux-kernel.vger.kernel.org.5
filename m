Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DFA7C6E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378597AbjJLMx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378561AbjJLMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:53:53 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2049.outbound.protection.outlook.com [40.92.102.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF8BB;
        Thu, 12 Oct 2023 05:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQgLVb6aR4emIbxZw1Rmdzmx3GzITOYtk385eTAkvf2nhx9EXA6Za6cuMjZnU/1S/HpXTHU/jtllUG4PaGpsM67BzAY8tYqpx9fOUyHxbMsmmzZ2U2f74r7yHW74H5QNfUL54mrxefBc1TsU5m1RlooXu5waXXcrat5kpVj+P5m/0HYwvAlIIXNu0erDy0dHkp1DgXEtF0Suff0JRl4IUl1aWOeR0ouX2wpp0Kzh8R32jAiyU0jNwSlw0G+hkKe2VD/Tik1DR/dEII3P812sJMgwqu0+w7CW7dHucvQzwpBd7hW7wwJcLkz4005oHJZg/Qhmx9DS4LwE10LHTfua+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yeBQI7gvIukwfXkqS6YAkwbM7WgxDh/8LcW8tFee98=;
 b=D/XWnYGydCuPArymSccOoGvBFO/w2LQ9yijTOhLYyWbbTRR1YDQMv76WTyAwd7mv4LKgZ9z7EzekupE7LSDCi+GUx2lbRR5FtIaOKXjYXRT+jQmt8ohqwxCJ34ZWrHV2sipCxZwLkeE26B7hlnlnDkfuKKiqJt+jFS4uYu0JNFpzOfkFEbPMAZuuW6DB+by/5kKMytC/FvFqs6OIVtJDXlWbyMeLR/dk5U4vK3qF492XXOHc/lElSK5cKmmi1sOOWcCTp5cUhv0DhNd5OjErn9Oigy1A+O4BFEcoyC+CHNz4YeSiHkT5ZiktNW4eJXRCXbSI2mVF3HaNbUjnzKgwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yeBQI7gvIukwfXkqS6YAkwbM7WgxDh/8LcW8tFee98=;
 b=Tdp23qBaZM2wCbQp8kJ86gI+tMwzpDZo3F6h1b5JYjgHhkSzveoDwdxcIqDfWciT9+48VZEM7G7Gn2EPIvju5IUSzGiD9ltQz+RO8LGFg/ALgnoD9iMKTE0iPBEmgXZAc0yowCTKwyHI13gp9DtAzeRj++ttd4p/kdxhmpJWcsiGTnYlwXJGljOOAEpFqhoIukeZqNunMOQQtruWtw+BxKIzwV0PJYpCbn+l8z6IFGKhDNBODyOqZ49RE0Ff/ZyFnXNUXSenWzzr0k+/9c154oIyBsJCucrIdRkQnGFPx5OdTFTEfFNrvI4h6uDZCDW8YXsVLW1C86JBypZL3J4JUg==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MA0P287MB2452.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:129::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.42; Thu, 12 Oct 2023 12:53:42 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 12:53:42 +0000
Message-ID: <MA0P287MB033258A24899AB56D2A13590FED3A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Thu, 12 Oct 2023 20:53:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] riscv: dts: sophgo: add Huashan Pi board device
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
References: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231009112642.477337-1-inochiama@outlook.com>
 <IA1PR20MB4953857AA6B541C1C3218F66BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953857AA6B541C1C3218F66BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [KIOPBmNMXL6m+h7BUbuweKl25XvdOm9N]
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <d0a6569e-dd5f-4aa7-9299-fcf33a4fc17f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MA0P287MB2452:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef49d67-07b0-406f-3628-08dbcb2242f5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJs007FoccCSB6n6osfZ1SOJXHFEQIGbvoygbUQSI3ZLModHrmpxtqTbVSqtiBmBb01gZQk3je9Gs9oN+3RTGk/DxJ9ZcR0YhcNq2yOxYSleyE1MBk6GB+j/wi5Odj0zxDkDujhk9f1QhM6GIWcuFu9B6FFpaKSGgJ5AE1awuM9xD01kHW7FZjTBIgLVep4z6LqCNaDZ4WQcqCY/+6i5t+lLatXjXV4s67b76o1+jtH7RbShCUSOQ07x7g3fVUI7DxJ/9Y9el+8+AiZn3yehECCBQeYZUR0Qc5h4s1W3LvUGUyHiYJgXAJVe1z1Ubq3w4yL3h8sn73qgeuGXcyBH/FD0AYYU8EQXWqLjA+eDyo0mtYlYNu3PXZaXcy1Kh0imqbzfP7Erz8FUsDpjIuYSr+8sqhwts3JBmAiWicAVe7eLdgr7P6OVzvzsL7FB0DdYngHL9GH0gxbalFE8JyrQSeT0s6w7pm0/8zroYraCd613CE7uj4uRfVdb/nQgWEUXb9pNMvb7VENPSQuaMNiRgwhiTdBK2DlbFVyulQiDlC0xlkLplAeBEh4Bg17YL21GpkqRgN5D0DhcLynq7WgWXaB1T9zrBUHSl2oLYSS9zaQ8HygoPwwZS1rJM56m3l2BO0VoOGlnb9oJI3uSrvmmWA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3BMNFJkTlp0NXhLcHhjR2NzekRKcVl0ZHVBaDJLNk9xb2VLd0crRU8yWUYv?=
 =?utf-8?B?WUlEUDJneHRWeU5CandraCs3NzZ2Q0xIUDNTQ1VBMmlHVEZIelNzS1YyYzRP?=
 =?utf-8?B?WjQ1bkNsT1BDSytPY3IyRlZZSzNQa1NSNEFvS28vTlRwVmNTSHJaelB1QnRa?=
 =?utf-8?B?bE0zejk3dXdudk01WTI5dVpDRmlacm1KMFUzYXpkaUJoMlVJSVdnV0RHb29j?=
 =?utf-8?B?OGFXMVpMb09nR0htTkhCOXZ2bXMxRzd6T3BTQ1plTFJBNmkrQXhLaVFBbU1V?=
 =?utf-8?B?cFRiYzZvaGJZbU1Xd3FpQ2R5cVRIYnBLUkQ4RWZTL1M4bUxGWm1YYSs0TFNw?=
 =?utf-8?B?a1JUYXFkbmtKTkQ5ZnQvOFE4a2hYdm1ZZzhNQXJDdEZaRGJzRGoyUGtTN2ZZ?=
 =?utf-8?B?SklpUGhSZm81SFdKUDJMeE5SSVRjVjhNblFub2s3MnNDUmtVcnlpMXM2UlJa?=
 =?utf-8?B?WmljUE5qTit4T0JhNVBtQyszd0hWdlhRR094bVV3aEhud0JFYWlFUmRnNG5T?=
 =?utf-8?B?aXdLK2d5ZzZyMTEwVFk1R2R0SUsrUWswa1RKVFd0VFczM3VzTEZIN0tTY1Fk?=
 =?utf-8?B?c0huOGJZMzVTMjBpckh2ZFRHT09sWjMvYnNINGJhMjdJQWpoUHZZVFlUUW02?=
 =?utf-8?B?Uk8rVzZMWThHdU1HSTBhMnZLQldVcWpaeGsrU0ovSE5HeXVQbkU5NFRQMU1K?=
 =?utf-8?B?MUxURk40eEFOMElZeUt3Sll1b3pwUVVOQTlNZzlSSXNWSE5mTmRlc2pva2dn?=
 =?utf-8?B?elVLNENzMjBjZnhaTVNkNGliV0pIQUVHU3AxTTN0bFlEbGNKOFFUQWE2ejdK?=
 =?utf-8?B?SlJmSHpvbFhFUElCd09HUCtRRlg5RllETWNVWlhsVGNWZVhwNDZiZU16dmRp?=
 =?utf-8?B?UUhhSktlRGhabGlvMmZ2SlQxeEJZcG1PZmNSeWQ0MHJNQUJnVnB4ZHhsMWJU?=
 =?utf-8?B?NUxFdGwzeEl1SEFLck55MDAyNTlBdG81Sm4zQmZpZGZQUUhLeFNJMVNqbXZr?=
 =?utf-8?B?bnlqQmRHRlB0c3RhamgvZjByc05HRmtHTVViVGdmVW1iTHFrSDFDVjBIV1NZ?=
 =?utf-8?B?Zy9FVWoxM0JHdW5sWG1jUjFjNlhxb1B0V1ZDU1VYck1TMEdUdjkwb0ZhNG9n?=
 =?utf-8?B?QjB0dG9YbHYyS3JmU0hoajdLbUkrMVo3cUlTd1phOTY1dEJvZmFVU1VDaVZw?=
 =?utf-8?B?VlI4U1dXWHVoWFVjSHNsUEE1UU8wZHdWMGk3ZWNWN3A0azdUZXJYdEtBcGpu?=
 =?utf-8?B?TkY5TEdvUUpTajlxVFJjdEhzS2g0d3cwelFrRzBDQ2xtZDN1ZEE0OU1uaFVN?=
 =?utf-8?B?bHBqUXZ1Z1F5UkFnY21qZGRCTUd1R3hlUks5RXhZSlNMaDIzd0tOZWRzc0s5?=
 =?utf-8?B?eGV2c05la29DWFFEQTI2ak9HMzNoYURGWTQ2OVNUS2V0MnI0SEVnMjN0bXRw?=
 =?utf-8?B?TVdwcHFTRjB2QUNVbnZCeXdRSkVRVlB5UkdQR0NabElzMEQ2dG1Cd0RhT3BJ?=
 =?utf-8?B?TExBVk1maWFKRGJsbWFHTlpRR2pnV1RLME9ST0hnU0lmSTlpcTk4UVcxS1JJ?=
 =?utf-8?B?Mnc2UDU5ajFZbXBsSFJ5dkdSME1EeW41TlI1elluUlVBQmtnbWkrekRDNWdE?=
 =?utf-8?Q?JJloKULydOMFUxlTfWWLCJZa7er29VrRO1qQ+KE2aRkc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef49d67-07b0-406f-3628-08dbcb2242f5
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 12:53:42.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2452
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/9 19:26, Inochi Amaoto wrote:
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
LGTM

Acked-by: Chen Wang <unicorn_wang@outlook.com>
> 2.42.0
>
