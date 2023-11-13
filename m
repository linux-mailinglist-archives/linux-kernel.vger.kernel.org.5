Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB567E9692
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 07:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjKMGFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 01:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKMGFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 01:05:06 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E32E171B;
        Sun, 12 Nov 2023 22:04:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogkMebXnNPuYK4DnrDAxAYoMq/1FDYpYhGMvqSReStOumo1RVtuBtOwFEOnihPch1SiOibAx8PRCrTm+ucFH15itgyMKZG7aTfja5J1cuWEuNJ33RUdUntFfMuPETLgxuzYGgnU0trtpVrVF5dooyMsQjTCbgleAW6Gsod7o0oF0nmijQCsgbI87zKe9VkcfQaKPYk/4Cnukq54IOQ6X+ECd6Pb4+RgFVpn6vf3bZl6wxI8WeO/k3n8uxRZmtu3FHBbQdUFTKfjhjXT5CFLdFwHqvFl8XT/adgNDa11jN9SaEOtffXq6ZkMaWtwQkjyOYjvSSau8Q6nhdS7TzdSd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYR3GdytbXA7c1mlGIoo4ZyLCDj+LxNwdWZrd+/5BU8=;
 b=JpuR3ni7VQIsnH3n68it/jb369aXLqmbVAy8CxOMhrFeNUOUsf9+ONLeGCpAk9G+pffd8zrlnFjD/Dz6fqgg1jxS81B4lpJmWY1VhymG6dJRs78FpsggjKxt5szaeQtf/CWv+umNGVPd1yULWi+5N9RkuuIu3mleIGYnKoEXijaEmG6Vo8amADJWGok2WZe9q1OoLO7m1I7ASfJbjnIgMl3q273/eMbrLqGq6EZV1OjJkSPf4yJZsfNnH3RvpEzMHcGrzSBwsVGH+6kb1jrhKRXHCfiQ87Qw/upqSe/c3iGmRCQ9UNgFKBAN1buf5lYoEsOQyH7YXxPtO3ik7+1F1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYR3GdytbXA7c1mlGIoo4ZyLCDj+LxNwdWZrd+/5BU8=;
 b=QlmY0mjmOp5AgTTraO0Wgk39ls9nlbjgD8aYZZdV18CqPqd9Iq0HpKZW1Buzm6ZZUI7Be2YLqyOgVZmShqR1x7U+qHrjjEe1lJ/Ea27RRJ+yI0A7qiuPKP/BQbYamii4SXdpZrAXNkT8esXWA2dVGR+ckyEZTcG3uFdl4s7y8GPv7WAMCBk2FsIcs1NCJVJkpt1BgYDJj9jCr2y8z69YhWT9vVvZ4Xin6ChdKvCAyhKjI46909tCzwV+WwjXsi3aBk324gDWQGLyIChP3wxrGawp7Pz/4IlcW8QjBFaopbL25jwzjCYnldHaONgrK3kET0HwYmCgCcVa/gJIWd8d/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEZPR03MB7220.apcprd03.prod.outlook.com (2603:1096:101:ec::16)
 by SEZPR03MB7753.apcprd03.prod.outlook.com (2603:1096:101:128::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 06:04:10 +0000
Received: from SEZPR03MB7220.apcprd03.prod.outlook.com
 ([fe80::f906:3d9e:af08:5aa7]) by SEZPR03MB7220.apcprd03.prod.outlook.com
 ([fe80::f906:3d9e:af08:5aa7%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 06:03:49 +0000
Message-ID: <a26f7b05-2ca4-41ae-9a93-07e4c2e3cd1f@amlogic.com>
Date:   Mon, 13 Nov 2023 14:03:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add GPIO interrupt support for Amlogic-T7 SoCs
To:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        hkallweit1@gmail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230913080924.3336391-1-huqiang.qin@amlogic.com>
Content-Language: en-US
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <20230913080924.3336391-1-huqiang.qin@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0078.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::18) To SEZPR03MB7220.apcprd03.prod.outlook.com
 (2603:1096:101:ec::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR03MB7220:EE_|SEZPR03MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: fc30ecc5-2468-4f34-5095-08dbe40e4e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67UCSGoddg82+2fOMyA+1T/EoNLa5QAQIww0SPv/XKrQxdAZ5DboTnBF3xi//XCXfOEQWnUV8091gzlxPD7EJv/qtoRMAypb9WodNSeigXq2aCuFf0MRBusNTSih9Z/spzJWGpztUtJhhYkTiVWyzrZ0KNsFdV4szfRn2ggWayA8TY2KEqqCW7dU77Mvyi5kmQN+d2JfqRIYyu9xn3JcaOsuW14kjsZ1huDzf4F9phlxIEfuHRU8hQUl0BkrEbjJNF24NDc/pTM1T5bR+MLcsmzKoF1enoIvJPfu2dDwRjHRduJedYByTL6ae84Nvf8Pake9m2KrCPPe2jnACvsdU88adVbj5AdtArBWUOhviw0Vf0DlU8JJ27pYiT2YgoTPw5nCWfdBoJzvmA1YlzEnuu2PSmKA6GItSBrho4izoV4byod3eKjPc1MFK/b9LlCM5zdsPNRBZMN3+/0usfA5yFU64uBIzg+jVU+U7hIn/68NMQyr8AhHgMsfogh6RxDShw4R9DodocSrsBZQu82eaYQMx6oEeFKeZHtAp85PoBnOzgY2ZtE4/TPwduyfbyFLwRzGbqahi7Ft0JCoVaB6B/4Pt5/O1PX925YLOgvaNA0SlveIwsfvZOCt1TSFET68oUEn3Y/lVyx0osA5qgdSvsXh+PjkgLl9elTMrzRZ8N9jfynAGDIOr1pluYNI4mibK4doUJ9CwTyn0aBwazpe8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7220.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(39850400004)(376002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(2616005)(53546011)(6506007)(6666004)(6512007)(44832011)(5660300002)(7416002)(4326008)(8676002)(8936002)(41300700001)(4744005)(2906002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(36756003)(31696002)(86362001)(38100700002)(921008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWpMZENuZUdEUzRtYTBQYlVwK1EwdG9mS3RQdWs0YkVlaTQrcTNKSjBEM3Vx?=
 =?utf-8?B?R1l0UEtVT1dIbmg2ZUFXeWF4QU9kYmJvOHhyTlNZckxCYUNiZDJWbEEvSy9B?=
 =?utf-8?B?L1ByT3lmbndyZ0tQY1FnTzVkcVNEUlN2ekVTNzhXRmpaOXcyVWg4K1RBYllo?=
 =?utf-8?B?cUw0Z3lxQUo1Z3JMVzRYQWEvYU5SMGNTTDBDUXU3QjF4LzI3andxWEsxODIr?=
 =?utf-8?B?c1EySHltcVYycUs5eG5mWGtUQmhCZW1Ud0NwQ0F1K0NjYjgybXNESEwwb1Qy?=
 =?utf-8?B?blRlQS9BMHhBRi90Z0RvTVhsNDBPazRBNklqd3dCOGpKTUk2ZFJpMUpsYWgr?=
 =?utf-8?B?Zmt1blZLL1d6RnF2TkU2TkJ3d1FLTHpHeUVCczFyWStVcGRBMGRFL0pDZ3h0?=
 =?utf-8?B?bnN0Y3dHazE5Z1YyaDNkUmt2N1BKdmwrVEU4Z3NSNXBwZTYzUE4xcHdBVjRZ?=
 =?utf-8?B?STNNcmprM1lTZzhIeDNsK2JGODhzcmp0Ri9GcEVLMXJhaDJKTkUzYzRKQjk1?=
 =?utf-8?B?NDR0NGRVT2diakorQ205VVRpOU1JNXAwTXlZQ3hNbFpRcHd2eDR5V29CN3h3?=
 =?utf-8?B?aXF4a1I4Z3N1dElYRFRQVjVIeCsvOVNBNEZPODdpUDhOaGN0dFROYjRWdTlN?=
 =?utf-8?B?c0JTdWdadjcrQ0pINE1XVEU2WTJRVHBnQzhhZTRzY05oanZTS25UbC81VDA5?=
 =?utf-8?B?RHpRcnRuamxsTFBIWStXMTNwVjJXWGEyRGZWenVObkZLcWFUMUZORjFydk1p?=
 =?utf-8?B?dzVkV0IyOE5XTWd3a1dUM3VFZmRHY1lNVGVVY01vQmxnZUNWWFJXRzAweDBZ?=
 =?utf-8?B?cEdWRlZXakY1RHBNcERUdWdPUGx2L01GUTJlOFQrbjQ4RHVXd2N5RitkYUVz?=
 =?utf-8?B?RjNSK21meHNldUQ2SVQ5eGVXT3lSbDhuWldpRER0YWRxUzA3UmJzaHZwbDEr?=
 =?utf-8?B?d1pSMG1ET0ZsWUxWWURYTUFoaGU5a3JJOXhlcDhha0NLamxGVCtKYUppbEJa?=
 =?utf-8?B?d1kyT0RlbURIQnhRcHJwOTVLTUk3R2JoYVlMMjhMOVJtNEhyVHEyZnFHMG96?=
 =?utf-8?B?WkE1dnplUDVHWHpONm8wVDFPL2hCamJzNlJRSGdyYW5Cb1A2WTF4R1ByUmI4?=
 =?utf-8?B?OGlaUjBoU25EbDBrM04yZCtoNFFxK1dXNFQvWTc1SjQzRXlUbkhSWkFzZ3Jj?=
 =?utf-8?B?am1aM0hKNjJqR1o3K2RseVFsQjlBT0FITTJjY2xLbHZ2ZVFVL21FUEhPZjRB?=
 =?utf-8?B?U3dKTStCWGJ4RGxuZXFNcWJ3dGsreWRCamVxeHpzdEVsWmdwdEF2VDJKUWhH?=
 =?utf-8?B?WllMTjVFa2dQTGk5MGJEZG82YzJkMUJkeHRwZXdHcjZ3bFVpR2ZFd3FyVmNP?=
 =?utf-8?B?SVJxTjRlSGhybGREemlHMGtIK2huTmdScmt1b2R4ZnlONXVjNU9QL0l1b3kx?=
 =?utf-8?B?M3RmZU1FVmd1dmxMUWFhLzJYaFd4Rjd5RmRCVFBGSERFV08zSGxXemUySDgr?=
 =?utf-8?B?N2dGSDRGQzRiN0NucFFQZlZ0ZEFsdHVubThEQ3J4dVdWQXFIRHJzalJMWXVC?=
 =?utf-8?B?UEovcUYwMzRNNUlScmk1WmYwbkNjOS81UUk4Z3NpeEVWWlRmd05HTDZNcU5x?=
 =?utf-8?B?WlhnMlNwdkFCZzdzTlZadldUYmNURWl4MHV3Nnl4TU8yZHhqUlNwZnBZd2dw?=
 =?utf-8?B?Mjc0MnlMNXlCbC9kOHNzeWZPUU9Nb1g5NWtuL2dpVkJ2bTNLWlc3QlZHbFZU?=
 =?utf-8?B?UFBvNi93OHJQZEpLMVFMK0h3K0I2QVFVYWZYQzZ3bnBUblVLNWdqclFiZnh3?=
 =?utf-8?B?K0hyeGQ3ZktvWmhyd1ZuaSt3Wks1RzBNUWdjTE5tMEdhTkFXV1IzWTNDdUZl?=
 =?utf-8?B?MWk2Y1RSb0tnSzBmUUNxYlpXdXdxZk1MNlE3MTZxM2YwYlJlaUhBVFF1RU9v?=
 =?utf-8?B?T2FpYTFoR21BSFZQNnpLbFJiVHk2cXUvUGlEemI5dzh0a2VUZkJadTYzUnQv?=
 =?utf-8?B?TXpnUzRqeEp0QkNYVWxtalJIelpUMkZRd2JRdzA1SU1IbndVS0dCRUhMRklU?=
 =?utf-8?B?SytBOVRZcEd3WVhxdE1LWEZ3S2RmVVJpY1NGMHBnZG1KeitDcXNZdEIyNGpB?=
 =?utf-8?B?a2V1WFhzSnJuUEJkVGJMLzZQN01DQlo5ckZoUHJHZVlUb1NrQk5JdnQ0d0Qw?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc30ecc5-2468-4f34-5095-08dbe40e4e17
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 06:03:49.5800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYiqjte4BGOzuj2FOEKNNREYKrVngtN/6iXF8mqk+4nfNBb7mY9QV0s6A9SCRYPzoPC34CaEr9wFCZ0NvuaTrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7753
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Marc

Friendly ping.

On 2023/9/13 16:09, Huqiang Qin wrote:
> This patch adds GPIO interrupt support for Amloigc-T7 SoC (A311D2)
> 
> Huqiang Qin (3):
>   dt-bindings: interrupt-controller: Add support for Amlogic-T7 SoCs
>   irqchip: Add support for Amlogic-T7 SoCs
>   arm64: dts: Add gpio_intc node for Amlogic-T7 SoCs
> 
>  .../interrupt-controller/amlogic,meson-gpio-intc.yaml  |  1 +
>  arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi            | 10 ++++++++++
>  drivers/irqchip/irq-meson-gpio.c                       |  5 +++++
>  3 files changed, 16 insertions(+)
> 
> 
> base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56

Best Regards,
Huqiang
