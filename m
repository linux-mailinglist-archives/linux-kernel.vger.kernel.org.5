Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF497C48FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjJKFGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKFGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:06:39 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7509C94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPAftdHEi1uueAUfJr3xPH6hbV1SRTAtgRHjIkS+ndzu9gwqTjeKAM8t956X2Dxbd9vPGfoBpy79rDnhFA1Repvmk7Rb2rb9JafSiqnPEELo6wMk9w4bDpnAF7jgxVAt/qQtHGZYlyMMRSdKiIgZ9ikEGXFJJ2qHOBAs3iOnP4cVQWT1YbFbrpH02Rx4ftesGX+KpGEqy9j08ykRcO7ff+FfyNYqBUPC3HHkqayhqT3Tgv07Uul7uBIOqzqqhWKO2HHqCdtukuQ/a/DoCq6lvsuDj9zeFeTsuAt7H0u8CMhs9XWpIluYC3fAb4ciCpoF0xEEHViqU/0PNE2K1Ys/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn1iR4TC3IOjdvWD0ZRvVaB75OwlVP2t7vf2N7xn0UE=;
 b=aHtOz0o6x/g1DMdzPnTm2WAsgvJPXJeWZIWnldvtmAMd3KJ8OOYiiqMZcOu8DT9kPmxrmeAtTmr27RWXVBzFrqU55skchn/6SbZNUf44HpuVX5as5WO0+F+21Ww3+Omy9Lyz2G2d3B/dxNkw0mEruq15Zts9i4tUW8spBg4Xuj0XOWllzxOYSwf2f49Px2gyWcfKYQNlpnUUsYXxEhN9bCUq0/MWjke2sU1dctmLYpbfefxHS2YFFMseoShKD3pcz8twlCV5qQzmv1JC/fXV917UZPxbzc5GDOErFNaLCCWTFCd7RX2yynAZF/iX4H8Hf5rfLnPIQBqapwh+LhUYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=piap.lukasiewicz.gov.pl; dmarc=pass action=none
 header.from=piap.pl; dkim=pass header.d=piap.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lukasiewiczgov.onmicrosoft.com; s=selector1-lukasiewiczgov-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn1iR4TC3IOjdvWD0ZRvVaB75OwlVP2t7vf2N7xn0UE=;
 b=sgOXcFB5uYxikEDMXWFowExm/3+Ia2EIdDMC6Jj3EUZD8dTHBTtwGaB65PqvXPxVuejFHnaCPnSJ3qBRlk7htioZH77RxQDVIA1kof39LVLj7W8OTPXkhOctoWB9VKYCzNcfLzKU4TaJXpWDeLMEybDh2m0EsOF6g1gb7H7F+1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=piap.pl;
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:155::18)
 by PR3P193MB1039.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 05:06:32 +0000
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::1bd8:1a5d:e69:d1a7]) by VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::1bd8:1a5d:e69:d1a7%3]) with mapi id 15.20.6863.041; Wed, 11 Oct 2023
 05:06:31 +0000
From:   Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
To:     soc@kernel.org
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Deepak Saxena <dsaxena@plexity.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] IXP4xx MAINTAINERS entries
Date:   Wed, 11 Oct 2023 07:06:29 +0200
Message-ID: <m3ttqxu4ru.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:155::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0685:EE_|PR3P193MB1039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7574f98f-69a4-4e9e-1e9a-08dbca17d4c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LdqnbVP89PQ71LMZbbdkQsORyNdPjQ6nuIBzZHNBuCd5ND7Kc73HqgiFt1ccddgHNrPMGF17v9XlZwwVtIH+blp8BwOfO7gCWWAW1UNzjPgcNGVn8tpOtU9aqjPq9soAS3wyEPVVcajCVyimMVckiopMkd+yqwfDmzqUFgeMu8yuh6z/TMAw1LbnjUURlE5KJ64LO9ah+h+PeGApnuKxk2lY24/l4ETaIqPdIwKABCsYBmTVWuA1FI7d6kJpg3NpahuIIJh4RRfz06FNwgaWHaD/q6RyiI83YW9kpBDNl7ang/FKVfVgTvfIw+jdthQXiLORtU+S89Q94Ge0xA4Ip/HShVg7AHPMKmrg0mhm6/1pWVKSU2t/Q6Qn+ZAIXl81Aw3w2uGpcRD4/b1PtH/yesyZYOz0pqEjMN0pgzkcAssduHVVmsgVECjo5Dlx6A3exPfPt1ogsr3spYvIBsgQ98pZ+NByYgqybFDtapT523+tAda1HedA0iLmK4SWiDX/SJ48VIyPGVAWpG4PtyN+pOHXTOjljoKUkWWI+s0Q5X4JLTTQGCfXPQBX68qOx7A9AbZpzWCVhQXMLRUVTwWI7wyfLjZjU3qQEAHaFOmNG6uFQgnykNFnGhRU645tvY/Sg3bS9mUaRxfpafgF6g+EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0685.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(1800799009)(451199024)(64100799003)(186009)(2906002)(83170400001)(38350700002)(38100700002)(6916009)(66476007)(54906003)(41300700001)(66556008)(66946007)(316002)(786003)(52116002)(6512007)(26005)(478600001)(6486002)(6506007)(66574015)(8676002)(5660300002)(42882007)(8936002)(83380400001)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGhtU3Y0SlkyVWsyQjRpK1VPUDUwY1BodFFLVGpkZlFqNU5ib3ZqVVoxWVhy?=
 =?utf-8?B?eTE1Qk5WN3BRK0k1dzIyak5QWGRvd2xIcy9zMFNIYzJ3djVzWHh4YXpFOXAx?=
 =?utf-8?B?L2hiUk1JbFJacTJ2SDJFSTc3eGdsOTg4MnJ3QTVHT2ZnQW5vVWJCMzZlQllm?=
 =?utf-8?B?UXRKS0oycHU3TmVESEtCMWpLck5aRCtCYnlTR3ZWcFFQblpxT0NKbGdVN0I4?=
 =?utf-8?B?QlFvOE02RkZrUVQzczRWMFNtZFZOTmJ5VkorS1QvVGxPaDFSVUFxOU1MSnRT?=
 =?utf-8?B?QlZTcWNZNXZaQm52TWhEU0p0d0t6bXFYWFJ2VHlDazhUaTlIM2ZFc0psSGoy?=
 =?utf-8?B?S2ZPenFMa1JycWUxY1I1YUorbUh4S2doUVlOZEtFa3FwREc1LzFNbWxtaVRU?=
 =?utf-8?B?bzhXb3JuQWpaZmFTeTdvelVzY2J0T1N5N2M3MW5LZEt6eExEaFprTnBzMldl?=
 =?utf-8?B?TklQblE5S3RMQmdQTnNsMGJkaXFFRndxMWVuWXJsRW8yNDRhYlVEV1ZBdW1I?=
 =?utf-8?B?V29nNi9OWkY5NitFTndESTJTSHladGcwMTNxMlVhK2RScC9BTFVhSjBOZHNB?=
 =?utf-8?B?MkZhS1lYR3d1RThnM2Y2bEJNdWlqMzN3bkdaUGlwbDlESVlFWUxxdEpZSmhS?=
 =?utf-8?B?UzJaY2pBWEV2UytXWnZJeEFSS3FISENpd3d2dS9PWTk0Z2FFQ09xeG5la2E4?=
 =?utf-8?B?amZpRVV1U3NrYThleG43cWZ3d3crdXVPNXdZRmZ0OWFhNVZXNmY3dkZzd0xT?=
 =?utf-8?B?REtsdDZmUEc5a0hjNUZPWUFPVmZyYkdQenpNNW1WT1JlL0x5eHhVQnIwQmRZ?=
 =?utf-8?B?Q0NmenpzT2R4ZG4zWmQrTUh3Z3c5d3FhZkpjenV0NHF5a1NKSWRoeGRFdk9t?=
 =?utf-8?B?RmZXVWRFRHFxcGc3S0JjbGdMMnUwZGZiSXdVL09wa2QyczFqWnZJSVZiUHd4?=
 =?utf-8?B?MnZoY0VJYjNQLzFZN3kvVXo1U2ZWcHlVL2RzbUtCclB5ZXB5ZVZjWnlsZUt5?=
 =?utf-8?B?MlNwbkZNaFpMOGt2VDBuQzRoLzNUc1hyU1E3Sk5ZUTZPeTFodERUL2o0NCtp?=
 =?utf-8?B?VWx2bUt5VlVrUHJleEpCSFpLeW1kc2xvMVZBMWE2eExwL3hpSUxRZ1hoOXNi?=
 =?utf-8?B?aFlscjcxQ0pDaEoyRkV1WmVodnRqNTlMdUdmejMzTm1HS1J3WGJ2a2NkNXAw?=
 =?utf-8?B?Z3BIdThrTTdMZjQyZkRociswTWdMT2NRYkE2dzYva3VQREhobEplME5vZHdz?=
 =?utf-8?B?aXFkaHl4MTRCNE1kdFZxK0JxSnNmdXlwS1cvVDdvTC9zVWxpenJpeHRpa3lP?=
 =?utf-8?B?bmd4N3VaRFJSRGtCU05TS2hNbStBQUY4SEJJTjR4UUJYZ3FEZGpxV1VFSVhi?=
 =?utf-8?B?SjZ5YkZxVzhCMVo1TG9obHVXdHZYSmRvSU5jSkVvRmVvZWRJR1NHb3ZiT3l4?=
 =?utf-8?B?NmdxZDNJVWhBUU1heTE4STc3K0FESGszRmpTeHFWNGZEWFZWM1I1Uzl3VHR5?=
 =?utf-8?B?VUFCaGtCT0xpMjlmNkFEOUlXSjdMcmlETEpFbndSa05pN2dOVVdDTXJYelZX?=
 =?utf-8?B?R0hOcDNralR5M04zUHVKdmVadVRIR1hocDhFcTRpUUZoaDNuWlZVa2cxUmhZ?=
 =?utf-8?B?bi9CWmhRdlpzaXVId25VeDRnQnR6cVdSRkUvQkZDczNoUCtWWklJMkN3RlpU?=
 =?utf-8?B?TG81c2xIdGw4U0l3S2U1a0VSRlFSREcraWpMQlVCZDlTVy91TE42Z0pqbEIw?=
 =?utf-8?B?Y04xUXRGV0tkRnRsSjV5cHBaMTRiSHpnem5kbkpTTVgzVFRMY2cxcjlIZE1l?=
 =?utf-8?B?UnVRUmJNRDRtRzRUZ1g0QTBtbkdlbG50QzhwaklIblNJQnYrRDdaVmpNZnBL?=
 =?utf-8?B?UkYvUWw5b21RVHgybzZTRjQwRFFsbDZiaUJVSjdLWHdjQ0t0WW1PUzFaWlNo?=
 =?utf-8?B?Y1JDdHZpS0ptTFR5RkdsaGtLQkYzWFcvTnRlNjA1U08wWHBXN0xTdVIrSURt?=
 =?utf-8?B?WHdwMGVHcHp5ck5sUk1kTGJhTktrNitwZVFiMzdxSDkyWWs2K0wvYkc1bytD?=
 =?utf-8?B?eHdQUTlFSC81L2xJdjZlejVCYU9tWDBJcVdscVp2SngzVEFZQnRyRjRCdG1D?=
 =?utf-8?B?Wi95SE5Cd2NvMzQxd0RpRkNLWmdnSmZ4eVlRQmRmdldTQzZNNHJyTDlGOW1z?=
 =?utf-8?Q?/Ari1INAJPPPOvuQOH2vljWxQtmUT0JE9brPABactG3B?=
X-OriginatorOrg: piap.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: 7574f98f-69a4-4e9e-1e9a-08dbca17d4c5
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 05:06:30.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e05b101-c6fe-47e5-82e1-c6a410bb95c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEx4pACR2Wa60dg+2ceTIct3kVd6vin7bXuI1bpto9gxNEyM3giMElmUiM+YfDlksKv3H9CZ10y6Cgp7ndUXzV8S++c7X2Kgt4hHNDaXptxXHMbsf7eT4ros2P2KwGNS5FTXkiWd3mQgEUUDwntGqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB1039
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MAINTAINERS entries for Intel IXP4xx SoCs.

Linus has been handling all IXP4xx stuff since 2019 or so.

Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c4cce45a09db..6d1c4e8d1ff8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2210,21 +2210,28 @@ F:	arch/arm/boot/dts/ti/omap/omap3-igep*
 ARM/INTEL IXP4XX ARM ARCHITECTURE
 M:	Linus Walleij <linusw@kernel.org>
 M:	Imre Kaloz <kaloz@openwrt.org>
-M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
 F:	Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-int=
errupt.yaml
 F:	Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expan=
sion*
+F:	Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
 F:	Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
 F:	arch/arm/boot/dts/intel/ixp/
 F:	arch/arm/mach-ixp4xx/
 F:	drivers/bus/intel-ixp4xx-eb.c
+F:	drivers/char/hw_random/ixp4xx-rng.c
 F:	drivers/clocksource/timer-ixp4xx.c
 F:	drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
 F:	drivers/gpio/gpio-ixp4xx.c
 F:	drivers/irqchip/irq-ixp4xx.c
+F:	drivers/net/ethernet/xscale/ixp4xx_eth.c
+F:	drivers/net/wan/ixp4xx_hss.c
+F:	drivers/soc/ixp4xx/ixp4xx-npe.c
+F:	drivers/soc/ixp4xx/ixp4xx-qmgr.c
+F:	include/linux/soc/ixp4xx/npe.h
+F:	include/linux/soc/ixp4xx/qmgr.h
=20
 ARM/INTEL KEEMBAY ARCHITECTURE
 M:	Paul J. Murphy <paul.j.murphy@intel.com>
@@ -10619,22 +10626,6 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
=20
-INTEL IXP4XX QMGR, NPE, ETHERNET and HSS SUPPORT
-M:	Krzysztof Halasa <khalasa@piap.pl>
-S:	Maintained
-F:	drivers/net/ethernet/xscale/ixp4xx_eth.c
-F:	drivers/net/wan/ixp4xx_hss.c
-F:	drivers/soc/ixp4xx/ixp4xx-npe.c
-F:	drivers/soc/ixp4xx/ixp4xx-qmgr.c
-F:	include/linux/soc/ixp4xx/npe.h
-F:	include/linux/soc/ixp4xx/qmgr.h
-
-INTEL IXP4XX RANDOM NUMBER GENERATOR SUPPORT
-M:	Deepak Saxena <dsaxena@plexity.net>
-S:	Maintained
-F:	Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
-F:	drivers/char/hw_random/ixp4xx-rng.c
-
 INTEL KEEM BAY DRM DRIVER
 M:	Anitha Chrisanthus <anitha.chrisanthus@intel.com>
 M:	Edmund Dea <edmund.j.dea@intel.com>

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
