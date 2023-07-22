Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCBB75DBAA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGVKPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 06:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGVKPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 06:15:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2097.outbound.protection.outlook.com [40.107.21.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37B12690;
        Sat, 22 Jul 2023 03:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihkTOhcMaD89bhpsTkEZ7eorX+SvYOK7PYwuO+eehxP+PbXBP2kvzhhh5jrJkIHeL+YsVyOk8xiAg02BbzgtlzXgOpO57FtbjvzWLHn6WMgBLqPIgNSodJCehDuakz49SeNQvwmWZT2fWlbUI4XQBbxJIbFiQFQM+iSST/JgD5aO2E3f8fZaxvHE0VGeNOfECHrFZJo4+/gbngcgWLmc8yuR3OZuJJaaVUg73nFZgncOfYYRHSYCHlnvYbseBj5OfOOsTg9rCtpLpNSnHQpZtMGX/8Y7z3zx+INY3V2emUEvNa83pKmf0Pq5pFzh2Tab03ZVMV5s/QydqgqFVl1qCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ID8g/4GihUEfYy8+4BMq32EKdxxl0nq4WMYvfeX7ezU=;
 b=PZ8iTPgs7gijASE0rMgZ24Mwb8FmVYuNCH9eivsQm4XJkLO+QXkhki69mD7rwFtIGQzX62N/MznsAdLHPMWv38EhTZG+TBlcmetaPP/yNeiH6gQLjbPn2kpHXx29750d77N/NoEJcSSnbdISDOKluj2Ix2hm3554hnK6D3dfI4+tOUJSn2H2mhsx9HWG4YLqVfywYWC9/5s4/6CHcZ0Ix6kjl524HQWv88xEA5vJ8JYSbDl5961RyFnOxIMQ2q9G4/QhbRi3KJN5a0Un3nrIJymQJoSFuK9doPJM1bu70kddXs0oaesYaj8iGN0QfLdVx9G1FSa9IZ3p11Y4XVI3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ID8g/4GihUEfYy8+4BMq32EKdxxl0nq4WMYvfeX7ezU=;
 b=EpMJeoOU2ta9VrP4KdyAK0lht19gm78LkwBC33TlSMPjj4AyocS9zf1eIpBuSBqmq9Ba9B+mcxOE55wJkEW/6kQB8IiDJfQE/RcsE2okYNFaxng1UgEi/GLLXSJFfYhYi9Rn7qfi1/jbxSMpl2MTifvOnAywZSX+j0EYLnu5tk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AS8PR02MB8567.eurprd02.prod.outlook.com (2603:10a6:20b:54c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.22; Sat, 22 Jul
 2023 10:15:26 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::2a6d:c845:6c5:2aad]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::2a6d:c845:6c5:2aad%4]) with mapi id 15.20.6631.017; Sat, 22 Jul 2023
 10:15:26 +0000
Message-ID: <0ace9a06-8f45-c13e-03b9-23bc85a3bcd3@axentia.se>
Date:   Sat, 22 Jul 2023 12:15:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: Use local header for SERDES MUX
 idle-state values
Content-Language: sv-SE
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rogerq@kernel.org
Cc:     s-vadapalli@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721125732.122421-1-j-choudhary@ti.com>
 <20230721125732.122421-2-j-choudhary@ti.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230721125732.122421-2-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0006.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::11) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|AS8PR02MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e470b03-31fc-4fdb-8005-08db8a9c9184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmLxGM2k4cAzlwaOLybRRiWfbDJ/690NoguX7gXcG3qRRx0llRmD3Aj+OyMqIvyhqUropSvLQ+hk7aUN2CvFZzXBsqxBY0FD6Q4VbMZSyCGSziHKlfwYGuUcRNGWkw/oa6p4IiUD4lD7+u7OZCDBIX9NAoMvzvfYoZGdC+v5nyZ2X96z+i0Lnv7PW9tg1bC4mQEP1TiuQWPDV8OL0g+GK+ttShf5ipsCaEV0Ignt+QRIHbLc7mjTUyzl/ID3z+EVlk5n9TNP8+DTJ+rQsdL5k7qLv85viMifMv+LHTf4vwKkZa4STaF52CG+NiTUHVAGADjYdd4K1j9yCv1mNRdLjF/2sX/N7SGNeGVlrd1E2rZaqfI6y5ab07uRrgaaI3u8XCcwlX/xC+UkDNNXLLH4h0yR6Tb+ocUQIsRQTO81kwk66/iTy5plU9AoetCRTL6VJcojQlto2bKAgqAmghjUDlYJHdOqwF5Pv3+uFnvw7R6FAxStscn+Sba9wXYgGY6TtNOQq9CVxEVFQXfYjK6nparw7QhYYVro7ZE+0t6uoxakXDHnhucmzUTKyO5iEZNViyaJoesOG0qcV87kUmo5e2gYSwUS/SRRq0+ieLqiKtIovYQmWuv5t4qddeRw40Pe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(346002)(376002)(136003)(366004)(451199021)(2906002)(66946007)(66556008)(66476007)(4326008)(6486002)(6666004)(478600001)(86362001)(31696002)(6512007)(966005)(83380400001)(36756003)(186003)(2616005)(26005)(6506007)(38100700002)(30864003)(41300700001)(7416002)(31686004)(8936002)(8676002)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1cvM2lLT2MzNTgxWDlVY0lFcThvSTl3RGRGWWhBdTB5THNtSEdRQktYbVBT?=
 =?utf-8?B?ZXpyT2g0Y3d3OEZNcXl2bmVuVWx3QldjNnBkUDJBdVZUS08yL0xlaXhZN3NZ?=
 =?utf-8?B?R2ZZeWNocVdQRWRzMytWYzhzSUQ2Ym51QmNaNWVPdXgxZktpc0Znb0hSMjla?=
 =?utf-8?B?Mks4RGNFZWxSdkdQbVdDYndnblVXQ3FrVHVOTmZ5R1YzSDV6bHFtWERwNjM2?=
 =?utf-8?B?WitzNHorUnlQWnJWMGRJdTdObmU3M2lEeU92dWxMUzh1UE9wQ3pWQ3dRVFo0?=
 =?utf-8?B?L2R3MktMUStmc09OT2ozSUJaeUQ2M2pTYnRrVTdBSk12c2h3eG5udGlwMDIx?=
 =?utf-8?B?TWxyaEE2SkxTS3V3d0EwSlYxeEEvNnpLOWpxQ2VnSXdEdWdzRGVBamdOL3hK?=
 =?utf-8?B?bEhtc0xUTW44WWZEN1FPSzBCbmorckxOdk5MV1R1L1ZXdVpLWDVzNkI3NFQ0?=
 =?utf-8?B?M1NXbWZYUlJudWY5WWJuTVAvUFdjbFpmLzhEaUxpZ2RZRkdpdzM4M0lCNU92?=
 =?utf-8?B?K2w1TTE0Ynp3VHloRmNOVE4vZ2VOUi9UZ3BVK3I4TUc2Smo5Z3QzdGdiZUU1?=
 =?utf-8?B?RG5oaTBFSC9LQ2pJR1drVU1TdkY1K3lsUjFSdTNQNTh5d0NQencvbW8ra3Fo?=
 =?utf-8?B?djVYZEZ6RVVjMWwwaE1ndmlPTXBRWFErM3ZSNDdLeHNvTzNELzFpb2hqZWFU?=
 =?utf-8?B?YWdBeVpKZWd0V0NFVHJNZ3pubi9tbkZTYXZoQ3pjMFBhZWY3SUcycHNxSVZu?=
 =?utf-8?B?TVA0ZU9tWWZ3WHU2QmovS1lKa3BuVFBvNlozQnE5dng3OWtEaGZPdTlqUkpG?=
 =?utf-8?B?ZDJtSjNQTUtSUytYaFJqUmVHejc0ZGIySzVJcnJuanJMNzlKRUs3dkhlT2pH?=
 =?utf-8?B?QnQ4QU1DM2xlOXlva1FyWGQ0bGkxUWhFQWcrcVFmVHJNOElza3U5K05QVUJH?=
 =?utf-8?B?UHBCMXBJRWlXdTVaOUt0VDJhdXd5K1VEdnpwM3ZFQzF1VWJpVmFOa0dNZDNL?=
 =?utf-8?B?MnV4ODgrMjZrcTRNcUJRTEh6cFRPU3NzUjdoaGFkWGJYZ2tWZExIQUtpVld3?=
 =?utf-8?B?MFlTSnJ1UlRPbTZnaW9vZjl4UTh3eUdzU3p3OTIzZEYrRVVsanJWS2JRMGkz?=
 =?utf-8?B?VkduazJ1OSttZ3dxOG44MmtlRVJQczEydTFFSjF4Q2cxMmlkSnB0YWVRYjhP?=
 =?utf-8?B?WTVqcjdlbHJzZWtod0c0bEI4U3JUc3ZvYWdEenAvajBNZTQvR29FUFdOTjdn?=
 =?utf-8?B?RWJMTnd4aGV6MW5pMjBhcFBvc3pHd3ljY2FlYzNqWklxZW45aDlKWUhzUCs1?=
 =?utf-8?B?SEpPVUo0OTVUL0pHS2F6R2t4aTFpb3ZMYnF2TXZibHUwZWhZZmlEK2UyNGVN?=
 =?utf-8?B?ZDVtNThFbmJkTnhtSDhCTnRLSkg5cm8vV2wyOWpuMUhXeUM1cHQ4Z0hTV25W?=
 =?utf-8?B?MnpuSzd4R3MwdDd2dTJBQmZPTHd5ZGZtQ2xUZ3J4MHJPL2pmaC9YYjVHN1lV?=
 =?utf-8?B?WkxwNktLTlAzZkM2L1lFcTdCUTM0TEJBa1gxV3lmQTliSG5yR3pkWmkvdVB0?=
 =?utf-8?B?djlOc2hiVlNPYzVIZng1OWJ5ZzY4L3hKMVptbU5BZHR6MWF0NU5qcTJXQnh6?=
 =?utf-8?B?Mm9MQ1ZoY3U0dzBIcEFXeHRvS1RsalNlSjJiYTFLWGRrWnVqUmQrYjFTN2pX?=
 =?utf-8?B?NWliNzdsMlNXazRGT2JiTXRoNmt3emV5NWJwSmN4NG5JTDgzYVJPV1ljblhu?=
 =?utf-8?B?ampYbzZoYk10cmtmVE5ZZlhUbjgzZVY4YmcvNTN6a0JHOGdYeUJUcTdCakJ1?=
 =?utf-8?B?R0owckRMZFF0dFd4MVZkMitZbkFxblNoeVJMTTB3c0JNb1JxSjh4ekxLQmdv?=
 =?utf-8?B?bTJTTEwxa3l3MDVOSElFUVo5TTI2ZEdCRTZPa2dEYU1MQW1kREovWFZUYUZa?=
 =?utf-8?B?aldVQmxhb00rd0VLeFc4R0g3N05NR05Idldzck5wUUlheDR2RTIycS8ramNX?=
 =?utf-8?B?WU45MFBUQmtwZzVWMWJJcHNVNVZoeU5vOW15bXptbEUyY0NSczBkQ2lBKytz?=
 =?utf-8?B?RDZYMUo2eXdvdVkydVpSNnByT0JiM0dndTNSbjhOSjlVOGprUEwreFRMWnli?=
 =?utf-8?Q?zd+Bx9ELbcTc6J3e7XaZkqGxQ?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e470b03-31fc-4fdb-8005-08db8a9c9184
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 10:15:26.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBIOUtQj5VL10ljlFGZ2NY9FtrfAArudKZ+Imvu6cD1yu0TPkanFPNVBK3yF9OGJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8567
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-07-21 at 14:57, Jayesh Choudhary wrote:
> The DTS uses constants for SERDES MUX idle state values which were earlier
> provided as bindings header. But they are unsuitable for bindings.
> So move these constants in a header next to DTS.
> 
> Also add J784S4 SERDES4 lane definitions which were missed earlier.
> 
> Suggested-by: Nishanth Menon <nm@ti.com>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Suggested-by: Roger Quadros <rogerq@kernel.org>
> Link: https://lore.kernel.org/linux-arm-kernel/b24c2124-fe3b-246c-9af9-3ecee9fb32d4@kernel.org/
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Roger Quadros <rogerq@kernel.org>

Thanks for getting these constants out of my hair :-)

I assume the patches will take some other route to Linus than by me?

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

> ---
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts       |   3 +-
>  .../dts/ti/k3-am642-phyboard-electra-rdk.dts  |   3 +-
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   3 +-
>  .../boot/dts/ti/k3-am68-sk-base-board.dts     |   3 +-
>  .../dts/ti/k3-j7200-common-proc-board.dts     |   3 +-
>  .../ti/k3-j7200-evm-quad-port-eth-exp.dtso    |   2 +-
>  .../ti/k3-j721e-evm-quad-port-eth-exp.dtso    |   2 +-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |   3 +-
>  .../dts/ti/k3-j721s2-common-proc-board.dts    |   3 +-
>  arch/arm64/boot/dts/ti/k3-serdes.h            | 204 ++++++++++++++++++
>  10 files changed, 220 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-serdes.h
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index 15c282c93467..d84e7ee16032 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -6,12 +6,13 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/phy/phy.h>
> -#include <dt-bindings/mux/ti-serdes.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/net/ti-dp83867.h>
>  #include "k3-am642.dtsi"
>  
> +#include "k3-serdes.h"
> +
>  / {
>  	compatible = "ti,am642-evm", "ti,am642";
>  	model = "Texas Instruments AM642 EVM";
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> index 9c418abd29d8..9175e96842d8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> @@ -16,11 +16,12 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/leds/leds-pca9532.h>
> -#include <dt-bindings/mux/ti-serdes.h>
>  #include <dt-bindings/phy/phy.h>
>  #include "k3-am642.dtsi"
>  #include "k3-am64-phycore-som.dtsi"
>  
> +#include "k3-serdes.h"
> +
>  / {
>  	compatible = "phytec,am642-phyboard-electra-rdk",
>  		     "phytec,am64-phycore-som", "ti,am642";
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index cbce43dbe3f9..963d796a3a97 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -5,13 +5,14 @@
>  
>  /dts-v1/;
>  
> -#include <dt-bindings/mux/ti-serdes.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/net/ti-dp83867.h>
>  #include <dt-bindings/leds/common.h>
>  #include "k3-am642.dtsi"
>  
> +#include "k3-serdes.h"
> +
>  / {
>  	compatible = "ti,am642-sk", "ti,am642";
>  	model = "Texas Instruments AM642 SK";
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> index d5889ba3fa46..21ad49cfa7ee 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -11,7 +11,8 @@
>  #include <dt-bindings/net/ti-dp83867.h>
>  #include <dt-bindings/phy/phy-cadence.h>
>  #include <dt-bindings/phy/phy.h>
> -#include <dt-bindings/mux/ti-serdes.h>
> +
> +#include "k3-serdes.h"
>  
>  / {
>  	compatible = "ti,am68-sk", "ti,j721s2";
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 3cf288128c3f..92a541491172 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -8,9 +8,10 @@
>  #include "k3-j7200-som-p0.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/net/ti-dp83867.h>
> -#include <dt-bindings/mux/ti-serdes.h>
>  #include <dt-bindings/phy/phy.h>
>  
> +#include "k3-serdes.h"
> +
>  / {
>  	compatible = "ti,j7200-evm", "ti,j7200";
>  	model = "Texas Instruments J7200 EVM";
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso b/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
> index 34a0747cbe69..32d905235ed7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
> @@ -10,9 +10,9 @@
>  /plugin/;
>  
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/mux/ti-serdes.h>
>  
>  #include "k3-pinctrl.h"
> +#include "k3-serdes.h"
>  
>  &{/} {
>  	aliases {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
> index 6f0adf591b98..d4c51ffc3d6b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
> @@ -10,11 +10,11 @@
>  /plugin/;
>  
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/mux/ti-serdes.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/phy/phy-cadence.h>
>  
>  #include "k3-pinctrl.h"
> +#include "k3-serdes.h"
>  
>  &{/} {
>  	aliases {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 6c9fe28b6de7..3acd55ffd4ff 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -7,7 +7,8 @@
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/phy/phy-ti.h>
>  #include <dt-bindings/mux/mux.h>
> -#include <dt-bindings/mux/ti-serdes.h>
> +
> +#include "k3-serdes.h"
>  
>  / {
>  	cmn_refclk: clock-cmnrefclk {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> index 092ab1e14ba5..02b7a559bdf2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -11,7 +11,8 @@
>  #include <dt-bindings/net/ti-dp83867.h>
>  #include <dt-bindings/phy/phy-cadence.h>
>  #include <dt-bindings/phy/phy.h>
> -#include <dt-bindings/mux/ti-serdes.h>
> +
> +#include "k3-serdes.h"
>  
>  / {
>  	compatible = "ti,j721s2-evm", "ti,j721s2";
> diff --git a/arch/arm64/boot/dts/ti/k3-serdes.h b/arch/arm64/boot/dts/ti/k3-serdes.h
> new file mode 100644
> index 000000000000..29167f85c1f6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-serdes.h
> @@ -0,0 +1,204 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for SERDES MUX for TI SoCs
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#ifndef DTS_ARM64_TI_K3_SERDES_H
> +#define DTS_ARM64_TI_K3_SERDES_H
> +
> +/* J721E */
> +
> +#define J721E_SERDES0_LANE0_QSGMII_LANE1	0x0
> +#define J721E_SERDES0_LANE0_PCIE0_LANE0		0x1
> +#define J721E_SERDES0_LANE0_USB3_0_SWAP		0x2
> +#define J721E_SERDES0_LANE0_IP4_UNUSED		0x3
> +
> +#define J721E_SERDES0_LANE1_QSGMII_LANE2	0x0
> +#define J721E_SERDES0_LANE1_PCIE0_LANE1		0x1
> +#define J721E_SERDES0_LANE1_USB3_0		0x2
> +#define J721E_SERDES0_LANE1_IP4_UNUSED		0x3
> +
> +#define J721E_SERDES1_LANE0_QSGMII_LANE3	0x0
> +#define J721E_SERDES1_LANE0_PCIE1_LANE0		0x1
> +#define J721E_SERDES1_LANE0_USB3_1_SWAP		0x2
> +#define J721E_SERDES1_LANE0_SGMII_LANE0		0x3
> +
> +#define J721E_SERDES1_LANE1_QSGMII_LANE4	0x0
> +#define J721E_SERDES1_LANE1_PCIE1_LANE1		0x1
> +#define J721E_SERDES1_LANE1_USB3_1		0x2
> +#define J721E_SERDES1_LANE1_SGMII_LANE1		0x3
> +
> +#define J721E_SERDES2_LANE0_IP1_UNUSED		0x0
> +#define J721E_SERDES2_LANE0_PCIE2_LANE0		0x1
> +#define J721E_SERDES2_LANE0_USB3_1_SWAP		0x2
> +#define J721E_SERDES2_LANE0_SGMII_LANE0		0x3
> +
> +#define J721E_SERDES2_LANE1_IP1_UNUSED		0x0
> +#define J721E_SERDES2_LANE1_PCIE2_LANE1		0x1
> +#define J721E_SERDES2_LANE1_USB3_1		0x2
> +#define J721E_SERDES2_LANE1_SGMII_LANE1		0x3
> +
> +#define J721E_SERDES3_LANE0_IP1_UNUSED		0x0
> +#define J721E_SERDES3_LANE0_PCIE3_LANE0		0x1
> +#define J721E_SERDES3_LANE0_USB3_0_SWAP		0x2
> +#define J721E_SERDES3_LANE0_IP4_UNUSED		0x3
> +
> +#define J721E_SERDES3_LANE1_IP1_UNUSED		0x0
> +#define J721E_SERDES3_LANE1_PCIE3_LANE1		0x1
> +#define J721E_SERDES3_LANE1_USB3_0		0x2
> +#define J721E_SERDES3_LANE1_IP4_UNUSED		0x3
> +
> +#define J721E_SERDES4_LANE0_EDP_LANE0		0x0
> +#define J721E_SERDES4_LANE0_IP2_UNUSED		0x1
> +#define J721E_SERDES4_LANE0_QSGMII_LANE5	0x2
> +#define J721E_SERDES4_LANE0_IP4_UNUSED		0x3
> +
> +#define J721E_SERDES4_LANE1_EDP_LANE1		0x0
> +#define J721E_SERDES4_LANE1_IP2_UNUSED		0x1
> +#define J721E_SERDES4_LANE1_QSGMII_LANE6	0x2
> +#define J721E_SERDES4_LANE1_IP4_UNUSED		0x3
> +
> +#define J721E_SERDES4_LANE2_EDP_LANE2		0x0
> +#define J721E_SERDES4_LANE2_IP2_UNUSED		0x1
> +#define J721E_SERDES4_LANE2_QSGMII_LANE7	0x2
> +#define J721E_SERDES4_LANE2_IP4_UNUSED		0x3
> +
> +#define J721E_SERDES4_LANE3_EDP_LANE3		0x0
> +#define J721E_SERDES4_LANE3_IP2_UNUSED		0x1
> +#define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
> +#define J721E_SERDES4_LANE3_IP4_UNUSED		0x3
> +
> +/* J7200 */
> +
> +#define J7200_SERDES0_LANE0_QSGMII_LANE3	0x0
> +#define J7200_SERDES0_LANE0_PCIE1_LANE0		0x1
> +#define J7200_SERDES0_LANE0_IP3_UNUSED		0x2
> +#define J7200_SERDES0_LANE0_IP4_UNUSED		0x3
> +
> +#define J7200_SERDES0_LANE1_QSGMII_LANE4	0x0
> +#define J7200_SERDES0_LANE1_PCIE1_LANE1		0x1
> +#define J7200_SERDES0_LANE1_IP3_UNUSED		0x2
> +#define J7200_SERDES0_LANE1_IP4_UNUSED		0x3
> +
> +#define J7200_SERDES0_LANE2_QSGMII_LANE1	0x0
> +#define J7200_SERDES0_LANE2_PCIE1_LANE2		0x1
> +#define J7200_SERDES0_LANE2_IP3_UNUSED		0x2
> +#define J7200_SERDES0_LANE2_IP4_UNUSED		0x3
> +
> +#define J7200_SERDES0_LANE3_QSGMII_LANE2	0x0
> +#define J7200_SERDES0_LANE3_PCIE1_LANE3		0x1
> +#define J7200_SERDES0_LANE3_USB			0x2
> +#define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
> +
> +/* AM64 */
> +
> +#define AM64_SERDES0_LANE0_PCIE0		0x0
> +#define AM64_SERDES0_LANE0_USB			0x1
> +
> +/* J721S2 */
> +
> +#define J721S2_SERDES0_LANE0_EDP_LANE0		0x0
> +#define J721S2_SERDES0_LANE0_PCIE1_LANE0	0x1
> +#define J721S2_SERDES0_LANE0_IP3_UNUSED		0x2
> +#define J721S2_SERDES0_LANE0_IP4_UNUSED		0x3
> +
> +#define J721S2_SERDES0_LANE1_EDP_LANE1		0x0
> +#define J721S2_SERDES0_LANE1_PCIE1_LANE1	0x1
> +#define J721S2_SERDES0_LANE1_USB		0x2
> +#define J721S2_SERDES0_LANE1_IP4_UNUSED		0x3
> +
> +#define J721S2_SERDES0_LANE2_EDP_LANE2		0x0
> +#define J721S2_SERDES0_LANE2_PCIE1_LANE2	0x1
> +#define J721S2_SERDES0_LANE2_IP3_UNUSED		0x2
> +#define J721S2_SERDES0_LANE2_IP4_UNUSED		0x3
> +
> +#define J721S2_SERDES0_LANE3_EDP_LANE3		0x0
> +#define J721S2_SERDES0_LANE3_PCIE1_LANE3	0x1
> +#define J721S2_SERDES0_LANE3_USB		0x2
> +#define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
> +
> +/* J784S4 */
> +
> +#define J784S4_SERDES0_LANE0_IP1_UNUSED		0x0
> +#define J784S4_SERDES0_LANE0_PCIE1_LANE0	0x1
> +#define J784S4_SERDES0_LANE0_IP3_UNUSED		0x2
> +#define J784S4_SERDES0_LANE0_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES0_LANE1_IP1_UNUSED		0x0
> +#define J784S4_SERDES0_LANE1_PCIE1_LANE1	0x1
> +#define J784S4_SERDES0_LANE1_IP3_UNUSED		0x2
> +#define J784S4_SERDES0_LANE1_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES0_LANE2_PCIE3_LANE0	0x0
> +#define J784S4_SERDES0_LANE2_PCIE1_LANE2	0x1
> +#define J784S4_SERDES0_LANE2_IP3_UNUSED		0x2
> +#define J784S4_SERDES0_LANE2_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES0_LANE3_PCIE3_LANE1	0x0
> +#define J784S4_SERDES0_LANE3_PCIE1_LANE3	0x1
> +#define J784S4_SERDES0_LANE3_USB		0x2
> +#define J784S4_SERDES0_LANE3_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES1_LANE0_QSGMII_LANE3	0x0
> +#define J784S4_SERDES1_LANE0_PCIE0_LANE0	0x1
> +#define J784S4_SERDES1_LANE0_IP3_UNUSED		0x2
> +#define J784S4_SERDES1_LANE0_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES1_LANE1_QSGMII_LANE4	0x0
> +#define J784S4_SERDES1_LANE1_PCIE0_LANE1	0x1
> +#define J784S4_SERDES1_LANE1_IP3_UNUSED		0x2
> +#define J784S4_SERDES1_LANE1_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES1_LANE2_QSGMII_LANE1	0x0
> +#define J784S4_SERDES1_LANE2_PCIE0_LANE2	0x1
> +#define J784S4_SERDES1_LANE2_PCIE2_LANE0	0x2
> +#define J784S4_SERDES1_LANE2_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES1_LANE3_QSGMII_LANE2	0x0
> +#define J784S4_SERDES1_LANE3_PCIE0_LANE3	0x1
> +#define J784S4_SERDES1_LANE3_PCIE2_LANE1	0x2
> +#define J784S4_SERDES1_LANE3_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES2_LANE0_QSGMII_LANE5	0x0
> +#define J784S4_SERDES2_LANE0_IP2_UNUSED		0x1
> +#define J784S4_SERDES2_LANE0_IP3_UNUSED		0x2
> +#define J784S4_SERDES2_LANE0_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES2_LANE1_QSGMII_LANE6	0x0
> +#define J784S4_SERDES2_LANE1_IP2_UNUSED		0x1
> +#define J784S4_SERDES2_LANE1_IP3_UNUSED		0x2
> +#define J784S4_SERDES2_LANE1_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES2_LANE2_QSGMII_LANE7	0x0
> +#define J784S4_SERDES2_LANE2_QSGMII_LANE1	0x1
> +#define J784S4_SERDES2_LANE2_IP3_UNUSED		0x2
> +#define J784S4_SERDES2_LANE2_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES2_LANE3_QSGMII_LANE8	0x0
> +#define J784S4_SERDES2_LANE3_QSGMII_LANE2	0x1
> +#define J784S4_SERDES2_LANE3_IP3_UNUSED		0x2
> +#define J784S4_SERDES2_LANE3_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES4_LANE0_EDP_LANE0		0x0
> +#define J784S4_SERDES4_LANE0_QSGMII_LANE5	0x1
> +#define J784S4_SERDES4_LANE0_IP3_UNUSED		0x2
> +#define J784S4_SERDES4_LANE0_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES4_LANE1_EDP_LANE1		0x0
> +#define J784S4_SERDES4_LANE1_QSGMII_LANE6	0x1
> +#define J784S4_SERDES4_LANE1_IP3_UNUSED		0x2
> +#define J784S4_SERDES4_LANE1_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES4_LANE2_EDP_LANE2		0x0
> +#define J784S4_SERDES4_LANE2_QSGMII_LANE7	0x1
> +#define J784S4_SERDES4_LANE2_IP3_UNUSED		0x2
> +#define J784S4_SERDES4_LANE2_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES4_LANE3_EDP_LANE3		0x0
> +#define J784S4_SERDES4_LANE3_QSGMII_LANE8	0x1
> +#define J784S4_SERDES4_LANE3_USB		0x2
> +#define J784S4_SERDES4_LANE3_IP4_UNUSED		0x3
> +
> +#endif /* DTS_ARM64_TI_K3_SERDES_H */
