Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C6A75DBB0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGVKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 06:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGVKTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 06:19:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2095.outbound.protection.outlook.com [40.107.21.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D2D171A;
        Sat, 22 Jul 2023 03:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OonKMSeyV7ySomftVXOJuBP89EdF6cVH22goFcD15nfgskCC0okzfTQzZGVuJkBq+dIgTu0SaOTH/IWz2Mv3h/rjww5EqrANCnctD/P2YBxpJcKrXqhUiCfuYa7JbdSPA7VGU2EycH92IMY7gTBIUnnKefslF/BQn4hIB3JLm048+/WjpJysqRDGW2ag4b1a0/4r4+IQz/N6tpEDw9z/hU4039NIANt1u2/y1GuzgNJltz6A42wK+ZawfLuaMZrboxp9rpIPYIi8IkekAfGTonAR85fxbStVftA8bvXeeuCcMrDvywLWT5hN+2uqIzCUzdvdb0qChb+e6ynmeMlVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIl9jbGQ4vro7nmyLn48K40BoewkhSFLAGOK1ySMzys=;
 b=Amkg20hT0tkC5kKfIzPA89518L+ytwTwINmpkDyiq0+ViUhwupgXMy/E6QRWu0oXE6zjh85khsGUr8NeoiV7EEKbYGHCL5QCi8w4SQrZtwT8+EipMbLJ4Omw3G+ACySTleY/8E5MX/WVDQ6/TZVlEEe4o0ynh00Rb9XTKm/p4gh8US2TX6T3ih7agdQoqEoCNqyB4HUFzUuL9GjfGdc0hQE1N4U6djawQ/+VwNdtIw/MCVq9WQ7ibOpg+GW12ZUYbC1N9QWMCJ6nOAQrWtt3xedGaKdSuWe1K2G3+jEkp7h16YKyoLfAAx9Kurm00OJzahiMShy2afHgSWH+AIupfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIl9jbGQ4vro7nmyLn48K40BoewkhSFLAGOK1ySMzys=;
 b=kTbxwwmiq3/rvE/+nCJp7kDnv4fgahcvriS0nw5AxQb6BiTSwUK7Dn4vRA0qLb2CLSmOZFQgCa1oDMLR/2Bvms8v/fR2kaznT8MEjUSpSvzZgcBvuGZF8l4MOR2+PLwuDPxn45kzFJhZ1Irg1MIX/LGCThAQBt/04qb5rRGw/q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AS8PR02MB8567.eurprd02.prod.outlook.com (2603:10a6:20b:54c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.22; Sat, 22 Jul
 2023 10:18:58 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::2a6d:c845:6c5:2aad]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::2a6d:c845:6c5:2aad%4]) with mapi id 15.20.6631.017; Sat, 22 Jul 2023
 10:18:58 +0000
Message-ID: <c1a68e10-6530-d0d1-663f-61b3b01e8834@axentia.se>
Date:   Sat, 22 Jul 2023 12:18:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] dt-bindings: ti-serdes-mux: Deprecate header with
 constants
Content-Language: sv-SE, en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rogerq@kernel.org
Cc:     s-vadapalli@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721125732.122421-1-j-choudhary@ti.com>
 <20230721125732.122421-3-j-choudhary@ti.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230721125732.122421-3-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF000000CD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:6) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|AS8PR02MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: baf34fcc-ff6a-46e6-00a3-08db8a9d0fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/BR83BCF/XG0WyNSZ0BlXWouOwCzQKSeiYIUTW3RhcFvKyDxujIMj0+NVBsLTXv0jx5vdfRVnc5RWpteYfMFBksYwVQBo3uCcmdQg5xe4IlsJk6XaeXaB+5Z9SQM+eVsOTVy6kHaW5TnJlIxvSBNIh7uUQtfc7fv/fRhgjoudBitrVN7slFQSBJJuVt61mymSb3Ss5khGWQWE6tMY3YhzmuGW8qtKguON3ygUbygQ8IqWI9wGTyRbJC0H7KAS88+RdcdmmPdQPaYNKN8+n00ph0/a04jIjlSi91KxHDPUr1atx3bQQ048MTAE8EUTVU501k/Q7Z7BBCgE6c+XTr8MrHfG5vDjzkYIv/LfdgCj5MZ/SsV8d2EWFqIZ3JmAxQN3PJv2bHVrlK6NLHe6+OHNnDuP0RwPnLra5+jKDDHC3vG4fw6N9GkplpflHhAqilnlLbd4PGNpMP4nY/DED+oKhiHzvCLotDd0hB3wB7oRaBSBakzIXsZaiM2dPkbklvmvQSjQYsAy2NAIN8wDNMLm0k5gSgK6azie2um01Gx/ieIPQuB4U4kVP0bi4OPE19HkbVXHVVh9n/6THS0yiKsQ+uRZOkhO9n3bXeURxmZBdYaXGfTG1cGe8FbELAjOIIROfezzEd4p82PiiGW33lIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(346002)(376002)(136003)(366004)(451199021)(2906002)(66946007)(66556008)(66476007)(4326008)(6486002)(6666004)(478600001)(86362001)(31696002)(6512007)(83380400001)(36756003)(186003)(2616005)(26005)(6506007)(38100700002)(41300700001)(7416002)(31686004)(8936002)(8676002)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1JPU0lWTmtqc3k5SjJRSGxCdVRaWkUyME5haXN6SitZVStnd0xNUUp3cUJF?=
 =?utf-8?B?UWh5NStzU1FvdEVVUzFadEdOSWM1Zy9xdGNhaTlmajZMQTFCYUdxcGI3VDM5?=
 =?utf-8?B?WjlUZUVUQ2VYOWJ2MlByaUg0L09NMTNoNnArMm1DL21UOGRhalc0WFBZcEp0?=
 =?utf-8?B?akE5akVLTEI2STErZnlpSVVleVdSUE5WRmlUem52SGxnRU9UWnRPOUMwY3JI?=
 =?utf-8?B?bStTT204U0FLWmtXeXROR0RZZmZORTBOT1ppU214UDMwdnFlUzlUVTZJZkpj?=
 =?utf-8?B?TDZ4TlRBWWFVdUFJNnh4UGtwT29GYTJtbi9leTlFSmljaWZ3cEtrdVpSeVpV?=
 =?utf-8?B?SVdNem1Yamo2WnVONUl2YlBJWXNoVXhGOUVKd2RxTDVzTzQ2Q1V5SXRBNTkx?=
 =?utf-8?B?N0VOejQ5UnJsTHJ0TE1DUklWeUEzV1QwM0dUbkM5K1JaaXc5b2F1S0lOVVEr?=
 =?utf-8?B?VjZiTWdsVkltekd3MW42Y05sRHZra2dHZHBzL0RpUkljSzVHTk9LZTJBWmtr?=
 =?utf-8?B?QkVORlJJbXVPd0Zub2hscWFOZU4wMllOMEpVZkQ2MXdWc1MyK1k3amdhZlVr?=
 =?utf-8?B?RkJoZWs2Ri9BY3ZpRjgvbXdKaEpwNnRtK1BuaGt6ajBEWFVIYkZ3amR6WkJu?=
 =?utf-8?B?ak50azVYSCs5cHdSWWdhNUdzVnkvR0tScUdGU1pGUndMcm91MFZ0VVV2NFpz?=
 =?utf-8?B?R1QyVktybTl0bTNydGNpcmpoNFFWVENVZFpZcXNhVlRpTUFQYUhxTlRveWpU?=
 =?utf-8?B?aVRNTkZXUU1HTitZQmNyMkgvb3BTNVkxUnpNV2dqOXYrSlBDQThjSXdYZ1VR?=
 =?utf-8?B?aVZhcVRoVGJ4dTV2cldrb3VVeE9pTzdRUU80aEYzaEN2VFQwRGtWOWsxY3lK?=
 =?utf-8?B?eUF3WDBqbzFlNWNEdCtvd2lOSHYvNDEyc29FQlBZNXJmeVZEM3lyUXNtelgr?=
 =?utf-8?B?QTlyYWVGSnNyUU1rQnVpRkVrV2RmMDF0NjViR0FWM2E4VTlaRFlOd2JsWmpO?=
 =?utf-8?B?ZHJ6TTV3UC9mMTd6NTJ6bXpsdTRIZEc0WVMyeWhUYlVwbGFWclBhYVpWblhi?=
 =?utf-8?B?RmJzUERDUEQwUXdiYWhsQmkxVUpZQlpXSEFGb2hZZWpqajFweEYwbnNGS2FT?=
 =?utf-8?B?VW9abXVrK2h6ZnV5ZDRTeWl0NDVvaEdJb0M4ZkUrWWFmWkpZbXZ0Lzc3U2Vn?=
 =?utf-8?B?cWh4SWNyYTdXME5jN3JyWFI5ZlVMNWUvaU9SVGh0bHhNQ3NmTlk2cDgvK3dG?=
 =?utf-8?B?U0M3ZElkVnY2VEYxbnhueUYvRExVQVdxTksrcEVabUoxZkJ5L0grTTNLanB6?=
 =?utf-8?B?a0F0SENlSEFBSS9hclZyWG5wMkt5L1h0YU41anducDFHS2Q5a2dZcGNFWkty?=
 =?utf-8?B?K2ROUnZ2UXlKTkRBaGJqaTBCamlVVDQ3K0wwWjVKbUgwWG5ZeW9KNkNINkpE?=
 =?utf-8?B?aXVDdld3bDNRMUN0L1ZGQUZaaXZacG1OYVFzYUVYalVQQVZNUTRmRktZS09J?=
 =?utf-8?B?WlR5cUI2dTRiMTR3ZWdYQW0vdGp3dHpaMXhwZVdZUHpzZVdpeFoyT29aRVBj?=
 =?utf-8?B?YUx6SkFJOG5lUjBhYlFFN1dMQVhEdnJySXo5SzNFWGtRaHZvVVF4WUk3Ukh3?=
 =?utf-8?B?cXFxWjRQVU16V3B4SE5KdnJUcElxWUdyWDJMSWhCMEpHdTl2KzdnWWU5akh4?=
 =?utf-8?B?cWhVc0RDOVRHQ1FrajEwejU4eFNQVU1CSXYxRUZEOU5zNjFwY0EvSWExWEJu?=
 =?utf-8?B?dW1NbFpBSXFPcE1sNFdhWkI5dWRDeDlCWEtmWU83T1BrZ3VpekRWZmx3RG5t?=
 =?utf-8?B?enVSRUFpemlHZGVYZktDY2NCN0VpZWZsU3p4RkNQQlA3bnFuK1dCUVIycWtM?=
 =?utf-8?B?OEt6eEhiUWxiNExGT2crdnVmaDhzTHhNTWFMSmFwNk9BcmRZbWNMYnpHM00z?=
 =?utf-8?B?ZnhlR09QdGVCNFMvTWgwcXYxclVUV2wxZ2F0bE4zellPVWZtSmdXaTUwSzE3?=
 =?utf-8?B?b0dCMEJ4cWZGY1FOeE5iWkVXa2NoRDhkWW9Sd0R0TUNtVklUNCtNSE0ralgw?=
 =?utf-8?B?WFZlcmNVWkFkbStCUGlIOU5xK2JOaHVkamQyQzJpZE53aXF0cjExdENwMERB?=
 =?utf-8?Q?L+HVGYi6yMA6zpYo7fS9z0aNh?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: baf34fcc-ff6a-46e6-00a3-08db8a9d0fd8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 10:18:58.4464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whRRPuzE6WhIMKYL+xbQTP1tRUH0J5imqYEVm8ULCg//2ywxJY0KuUhutK532MYF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8567
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-07-21 at 14:57, Jayesh Choudhary wrote:
> The constants to define the idle state of SERDES MUX were defined in
> bindings header. They are used only in DTS and driver uses the dt property
> to set the idle state making it unsuitable for bindings.
> The constants are moved to header next to DTS ("arch/arm64/boot/dts/ti/")
> and all the references to bindings header are removed.
> So add a warning to mark this bindings header as deprecated.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Roger Quadros <rogerq@kernel.org>

Best to keep this patch together with 1/2, so I'm assuming they will
take the same path to Linus, and that an ack from me will suffice.
Thanks again!

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

> ---
>  include/dt-bindings/mux/ti-serdes.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
> index 669ca2d6abce..b0b1091aad6d 100644
> --- a/include/dt-bindings/mux/ti-serdes.h
> +++ b/include/dt-bindings/mux/ti-serdes.h
> @@ -6,6 +6,14 @@
>  #ifndef _DT_BINDINGS_MUX_TI_SERDES
>  #define _DT_BINDINGS_MUX_TI_SERDES
>  
> +/*
> + * These bindings are deprecated, because they do not match the actual
> + * concept of bindings but rather contain pure constants values used only
> + * in DTS board files.
> + * Instead include the header in the DTS source directory.
> + */
> +#warning "These bindings are deprecated. Instead, use the header in the DTS source directory."
> +
>  /* J721E */
>  
>  #define J721E_SERDES0_LANE0_QSGMII_LANE1	0x0
