Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE018064B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376648AbjLFCCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbjLFCCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:02:21 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2035.outbound.protection.outlook.com [40.92.103.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0289A;
        Tue,  5 Dec 2023 18:02:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQzBvVV5gHFfDbmJHQ5kmNEAO+8wgkYr1QYoz2sshbhr+3xRBgXNYFFx0ExG9wslmMPq88n35R4uSL8LrwOA1D9+WOrz8KiD8ilFdDvW/DUqBMhrTx1vV/av6kltk6RES1lFXlPhOcmnNcgsxJkELbU4zSR9ee8/Pf5PkBApt6jWm5psi70I3zvDgrAjETvorzzQtGzve3ZZm/31lV1BA7poUB4t4QPh+rIOplb+fHuD9LBVBOPHVO+o9fVoskGWjXyJPnvOhr384tqZ4YwUWUdnaN33u5/OnfW+MOaICZ1gi44MLfIZxOzzqk3sN5Ss0fjsR/HuxUI6Kw+x/CySeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aPblhJcMNdpclNbsPyiLTLGeMS8jyeuY59AbdMswxk=;
 b=i0TXYtZ+g9PpxH0LkSysta0MbLw2kfltx7tBCOjXtuM2Un7Tvyy5os3Mee9um4QxHKJjykf4wnd6fGmqAOAZXutQ/NO8cuL7eyZMOOhSmLx62JJYyirymC5Xw/ILjRyLtSe3dU8J7TSs3EwwERKuNqOyQ451dRKCGiw3rUAgccLcRb/1rpKWNffJb/LjqHg+fL1WmLGZBuK1ZwvTjYO0WTTfgQ0+RVYw6Y90+iYFEzbRKI/gIy+3MbkOApWwsBY3hYAmMxwUv9ETpOxmfr1K44nXs/0z4XDdRVM7S/YBzw55w+vB4kO+WQw1sB7YOP7ukSX73WBDDcmDjwJ8Cs6xLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aPblhJcMNdpclNbsPyiLTLGeMS8jyeuY59AbdMswxk=;
 b=oU66daJHkACp2jb+g5WXNhEvgK00/bR7kN8twEc8VtS+r1LaqI3s/nezDlCmF5BuuoOzCjrQLE3b75jhTG01wZfCrf/HB6MyViR/THl9PveE7OG4X9+uscdS6SVdO8Cju5yVKK4PZLVesRRgWYcWw3CaFT9bRAB47T/nusuh+nlbfCKgSbvQTTQNZZgGkYCM6XhHqoemAaxqcdJBwmhTssNvQ5TRKZfoucJyAoE5jASKgZB6H2ihyArieywxBzqx2zwAHCB6Y3PdnQ08yCeT83CvhI+AxF1iBSokwecM5+CdIUT9xxjZGY0qAIbrXgKLz/5X9hE8FLQcgtghISh4KA==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB0096.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Wed, 6 Dec 2023 02:02:20 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 02:02:19 +0000
Message-ID: <MA0P287MB03329157B1914F38A3485402FE84A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 6 Dec 2023 10:02:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] clk: sophgo: Add CV1800 series clock controller
 driver
To:     Inochi Amaoto <inochiama@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB49532E1A3D8BA71FDBB444BCBB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953A1B906FE79B1FAEAD1D6BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953A1B906FE79B1FAEAD1D6BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [5Ny35QUpUk6Tf1TB0r1C5JYmZ/AVv3Et]
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <b9041bee-56a0-464e-a9c3-1cd8947ef226@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB0096:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d1d205-d3c2-4a0f-459f-08dbf5ff60ba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzfTS77LXI3uMQKqizWvRDTINegtzrm0cs78wvXyqDV23ZywwOD7MNTMfH/xpbcFMSYjJOE/E5MTcG5p5YaoPs2AsTPjnSISKBUdpgUBiACIAYQc8HKomhTC9UlxfyS3orU26DrrAfH+fqV4BNdNJzmCZ/Ij4b2aK3Z2B1saLY5EKwCxtHcHq+kZVmyknREshN3T8dTKIVytOaHmmg6fqs27IR9FNxlUhqOm/qHBTnj2LLR383k1kGBseLLJicHu5mu81dQ8VcXA2YivhlZIYmHzwPbG2BX0nvYATf6mwwQ489OvXoWnpgQ4kItRPmbVPFCGWVhavQCRJlgEP81aYLSufmBaRPMCnQgw7qyVU0rJJOxMXkLvOSDAMENB5bMcYiltAdFjh2KPSxuyfM0VHsavX9s/all1wtUArAOKk2mfYONoVAdglD0M+Q8rngGI9//G9BRy/sK2/x3OVBqVRtcPSydic3E/Or9H2y09O4Se8eAgETrXLrfMR2TXipsP66IZiXlobUc3CEdS6OGQAs/krrXEhc/QseV78IuIPyjF65BLJ8SCwpgPD/jhwa1bnXRUrC5sZWAAR/7vOdB/nDV5jy2g8XXKPfoXJbVPkO0FWtz2UgM4d5nRqSwi6j/ZGZ9J1yhoZM6Kk9fQI2Il3A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTNmTDBVSlFRRGhzbFB1Z0hHejB1MDVRUjJja0pwZEVBR0NndzFUNHk0clpY?=
 =?utf-8?B?QnZKdEE5TG5mVlBTaWlxT2lyTEltYy9KcndLSkVpT0RtK2Z6dG5pbHhyRDVC?=
 =?utf-8?B?OWtVeEFCR2dCeGxKSDQ0blFHYnBVVkdaNVVTV2RVWkV0bUZPQmhtTXNZcG5O?=
 =?utf-8?B?bHQ5QllPY0ptWmtnMG51K1BlcEVYSmtPQjZxSGdjTWVIREc5TTBhWnVVeXUr?=
 =?utf-8?B?SmdDUXBzYWo3UitMUHBLWnE0c0g2WWt3Ym5QcjgraDdDbzR1U0NMV0c4amk1?=
 =?utf-8?B?RERkS2ZjUlp3cXpHaDVkVmFnYVZYRjNFS0RTZTRMY0c1U1htWER0NlRKdDdl?=
 =?utf-8?B?dWx6RWd2MkxWclVWMDgvdVNUSDVBZXFqaFViRklOZnJiRExHNCt4TVBlbkRu?=
 =?utf-8?B?cHJWZnUvSUp5Nkc1Q0NHSWR1VmEzWXBDQVBFWnhjdGE0WjRLWlN2allFb09Y?=
 =?utf-8?B?OEFDS2pObkRZL3EyNkdHQmoxSmEyb0l4TVZQSExGUW1sZTJLeXhkRFRtVEZX?=
 =?utf-8?B?dFUvZnZmMTdFYUN6aWVZZ0w2aUk0T3FaT3IrUkZYYTZyL2JyQk54akVMNXYr?=
 =?utf-8?B?NmRHSzMvd0xSbjJtdnpFVUsxUENzaHgxdVVGa1hqVEN4b0ZMa3FtblN1SHJj?=
 =?utf-8?B?TkRVRHZaS21RRCtVdXJ4ZXRoQ1VMSSt3Y1MrWGduVEFXQkNlTnlGV01mYkdw?=
 =?utf-8?B?UENCN0Vzd0JKWnVRUk8xM3ZkT0FaYUQ5K2p0NTBoTGtvVHVzSHY2S1RKeUtu?=
 =?utf-8?B?MkJxaGVDU0c2ajRDNEFPM1BQZCs3ekFDdlZZRkhOUWE3Tk05KzZxbGRNNUFB?=
 =?utf-8?B?MEV6QzJ6MWRCVmRSckpNVEVIejEvcC8xMHhiZ2dyNWY2Zlo5clVwd1A1M3li?=
 =?utf-8?B?cklFKzlQY2kxRHBwYlZKcEhNTTVJeVhpenVVYnErSTJpak5MaHpwbUFzRG1H?=
 =?utf-8?B?dkVnTUdKUGllM2VGWlNRYm1GTVd2RFRrWCtKS08wa29VZXB6STltZnBZWnlk?=
 =?utf-8?B?d1lXdEtXSEZDNldYSkkvUHZRZmg5VHYxdDF5RXo4d1BBakttdWlqVmQxcGlT?=
 =?utf-8?B?UnRhN0xjN1RoQW9rakdZaUdmTmtPSysrVWNiZ1BuTVZENkErbnhkK01qVkxH?=
 =?utf-8?B?RGw4QXRSVDlXS0ZEd2swWW81YkRQZU1EdC9xWVhML3E5WGlKQ0t2bU05Wnp6?=
 =?utf-8?B?YWp5UjVEblpVWUJiSUkxMkRLSU9FMFlXVU9sTHRVZFRPZUhyRU94UEZrVEYz?=
 =?utf-8?B?dUxVblVWTFZqOVlENGxCUWRSUXdqV096RWNRVThWQUJlN2QwclZDWGVVMHZP?=
 =?utf-8?B?UERYaHM1cEZydU1jVVVJNThLVlFGK2J1dWZLYXEvQlJZQlQvRFdzY0lBWHVv?=
 =?utf-8?B?bE92bm9GdHl3UjZmc3NmYUZML1g3TDIxcjJmWHRNdVI2TDR3Z3IwVGl1cnpr?=
 =?utf-8?B?VkhGZDMzdUxkSW50WncydzVVOGhNNU5VaS8rOEFHQUhjbkRrNlk5QXFyMFY3?=
 =?utf-8?B?Z1lVRnFZZHFuVHRqdzY3MTdpazM4ZVg0dTRWWXVuRTNzbnhobnc1Sm1manRQ?=
 =?utf-8?B?d0lnU1BTSXIrMDk5NUZ4bld1ZncvdXBBMGJRN1ErLys1TkhaV25XeVRvaVJC?=
 =?utf-8?Q?i/i6ULPvmNRqsFTWN0Be4VxMtSQlwb39F1hNvqiM2ddM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d1d205-d3c2-4a0f-459f-08dbf5ff60ba
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 02:02:19.7293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0096
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/5 19:55, Inochi Amaoto wrote:
> Add driver for CV1800 series clock controller.
Add more clarification on your changes. Seems you add several files with 
different names for different products, what's your design idea, please 
add some brief introduction.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV180X-Clock-v1.xlsx
> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
> ---
> ......
> diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
> new file mode 100644
> index 000000000000..243d58a30117
> --- /dev/null
> +++ b/drivers/clk/sophgo/Kconfig
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# common clock support for SOPHGO SoC family.
Drop this comment line, moving forward, this Kconfig file will be 
re-used for more different sophgo products.
> +
> +config CLK_SOPHGO_CV1800
> +	tristate "Support for the Sophgo CV1800 series SoCs clock controller"
> +	default y
> +	depends on ARCH_SOPHGO || COMPILE_TEST
Suggest to add some help words for this config item.

......

2.43.0

