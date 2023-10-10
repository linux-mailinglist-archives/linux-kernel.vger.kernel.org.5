Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6B07BFA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjJJLoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:44:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE298A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZqrZJvWl1Jcd1bfm/E/xFmjPEH6MdiV6ZGg6xcuVmkMDPbSDlj6z6R63mjRXnPYkHnD2ExxD1ww+/UDNWIRkS6vEXzlrN/h3jrNn2Ss5WVEvq6yvG2cIYS1Fjl9hzQ071Zc+Lxlxvx+Syi8py6/dJXASrOKlFsSqwFgYTBWKTnmhqVA0oJax3V6eNgoF/Mr1HsbeuUl2FEOhHPa+HiPf3LtP8fi21zT7QVnNBz2fe6fVFrTMiEEaT5554GYdG9QqTa3sTNRIOMPJPysqPfbgjx1RXR9hC2JZ9SryybGTE/b7NSbQMBGmIOJxAR4W4ar0ahcSHouiZpCt1cOaUcQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuOH3SnGHx5e0FAKZ5SqcKQ77MjbMxkMx9uSgkzhihE=;
 b=oZ3Q5po2IV1Vb4E0faB4pheNGSpIJahWGZmSKo0kbuaG2fxsQZbzHduV2MFoxQAh0ee6b9/4A8Xs6hKzohSmymX4ePlW9TP35lncpNqUU3XRWz0wiFBmfMieSqnBtDlDhYVGTjeodUEDMB99cV94zyP2HeY8CXczU2QZic6d5cv0soewNj83aehlcvVj2ur2M//TxvbRl/F7TDYdWPGPJgaJYtddglazA5AuKA5c+mskdXjXsB8vBxhQ4SudXD3XUOiUkOMckZr3zJc4RZUvF93WAjVPVDZ7uuiyLTVufmdKtyJSy1rjFZm7+OFHfPNa2wYJvQX8I3qe25gDUUZEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=piap.lukasiewicz.gov.pl; dmarc=pass action=none
 header.from=piap.pl; dkim=pass header.d=piap.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lukasiewiczgov.onmicrosoft.com; s=selector1-lukasiewiczgov-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuOH3SnGHx5e0FAKZ5SqcKQ77MjbMxkMx9uSgkzhihE=;
 b=Fhl4gdEBmgfXggUpfyO00UjLlBBakI7MgOd0VXybVQ8UL1Ua46n7Wu2jP0AGhYyohXWK4YoHto624+McNYN20sJ4MWYflUNqTKPf19ILCnroVOneofyTHun2oEMxaQDYY48dxpnEHiVqJxErMnm6vx7rs8SIRmX23oIFRqyC50A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=piap.pl;
Received: from DB8P193MB0680.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15f::18)
 by VI1P193MB0606.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 11:43:58 +0000
Received: from DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
 ([fe80::ee84:c935:8355:642d]) by DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
 ([fe80::ee84:c935:8355:642d%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 11:43:58 +0000
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Deepak Saxena <dsaxena@plexity.net>
Subject: [RFC] IXP4XX MAINTAINERS entries
Date:   Tue, 10 Oct 2023 13:43:56 +0200
Message-ID: <m334yivh1f.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:10:15f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8P193MB0680:EE_|VI1P193MB0606:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c9b5c9-8232-411e-d11b-08dbc986308b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8Hk/ji99EJlyVUziOkiSeMxYr4prBMJLjirhScRJ9tWa5dufZivHPp7jGfY3YcYycdbm6Vt24XiOXzIfXCOhF0QFFZU1sywk06ugIA2h31IIJ1pRyIU2y3o94u85O5DVmMWY8UIEI5mLln9PDkqOx7EDTSnnHvaWyy9kICuU2d5h0CNVa8y8ntftaNda9/I44kV3DjVTCF7+6v5gN9FP27OLp70aIc/4xm2Y+l23mVx8tyIFhswvgGsv/vmRTDga+vtBqCxbleEBksqStymzTM28+fg6I5WJCXORsiwbUHFS0UEvm3kDfxBkc5W/ItWxtz+4w5IN6auaOHc0lhMOjlVHeu42p498xx5/NwCiXpCPVqxNOB8KnJWqnOpzTHIbAmQK4MQ1qPeNrz8ofXJyz22eymITM1rgTPyQ+uOjdCc1Hz/9DKwjZp5KoGk+uo2dG1nXMgHeCpPUEVk7XkChb+V9db8VlssBH2ZsA5+BA6CO8ZwlJTXkfz8TT0D+M72HKbpXPDZ5mZ47XnTY+TqcdaEAVT48RZrfLuallne0QW9seRqm45a0GCjHJHP8b1Lg4DdJAl2rJDGB71mYUB5kvHYeY3efHR3bHkHUvMEKrg2Kv4WgOzFiZJNayg//wIT94KFZNN8zzxpKp1y/+JkRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P193MB0680.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(346002)(396003)(366004)(186009)(1800799009)(451199024)(64100799003)(26005)(42882007)(52116002)(38350700002)(83170400001)(38100700002)(83380400001)(4326008)(6512007)(2906002)(8676002)(54906003)(66574015)(478600001)(66946007)(6506007)(41300700001)(6486002)(5660300002)(786003)(8936002)(316002)(66476007)(6916009)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWJSdnF6aFc5NlpXdU9YclI4KzNncnZSU3ZIZVFuV3p3YjdtOUpERERnZ29G?=
 =?utf-8?B?ZGRzTlhOS1ZLRGVOdDlKd3p0bi90d1dqUmxWL1FlY0wxQ3FGMjZrbWc4dXMy?=
 =?utf-8?B?bWxWbDUrN0ZULy9EOHhvZHhLZWJHeVRSU2x1Y2U5SW4wQmxRWThGb2VOaTJ3?=
 =?utf-8?B?c1BpUW1vM2d0emxxS2tSVmhmWUVvSk1wYzArZ0pDQXNQNXJzVEdYQUkzR29p?=
 =?utf-8?B?eENtTDhScllBODViNEtJLzA3eTNvQ2w1ZXZjSGxDVWhTWUpxbkpCS3p1YTVG?=
 =?utf-8?B?RDIyWlNQY1U1WmhHaE03NEVtS0pHVTlGYi9uZFFodDZ4L211djQ1Tk5pb3Ax?=
 =?utf-8?B?MVludmpQakhJVVp2NlIxMjlFUzJtaFFGZWo1a0dVd0lycDFtb1VnNjZGWndE?=
 =?utf-8?B?a0xUZzYzODByYXdSQ29WcGo1dXUySSs2emZWRzR6djUwUmhJWGRTc2lHZ3Iy?=
 =?utf-8?B?WkE4L0ZObnZZT2tyaFVRRGdLWFdFMlBieHEvelRwNjlaVW5WUSsyTDlDWEty?=
 =?utf-8?B?cmVxWWNLOVgycUdkNUpkeWtsbnJXL3pydXcxenJvKzdYL2JZd1Q2TnlqaFhS?=
 =?utf-8?B?bjVVWkxyZGhiemVTRUhqcVI3ZUpwUVZ5Q29Ucm1FRmFtWFR2SFdoTWhMU3p6?=
 =?utf-8?B?SGpsZzhiTnk0NXFmU2JPWTYrb09lRitwc3dWTUNJK29qVnRYZGFZeDlJdjVH?=
 =?utf-8?B?ZHVtOHoxMFB0dUtDZmhuZ3Z1NmpWNS9GN01uOEp0alJ3MkpmSGIycEtxRHQ0?=
 =?utf-8?B?MU1qVmpKdC9pN0pnRnpoMVNZdUZNdzVnRTM2M2FuQjZaSmtrVStWMFZjdURJ?=
 =?utf-8?B?Mys0SG9DTWpUL0tuQVMvSjZudzNUSjFza2xVMHRvUXkyQi9RYm9EZUZSWTN4?=
 =?utf-8?B?dVJta3R1ek1UUi9hREZpNlV1SDlZRkhYSnlJUTJkRXlQdjNNaVdQSENoUE04?=
 =?utf-8?B?cUVvcStSYk05Znk5K2VINmFNSkhlUGhPSTduVElpaWh5by95dGw2bmRES29K?=
 =?utf-8?B?SkppM0lLMVByWDdZQmJhemhtdWh0UjlhNTd3YTJXVk1ZUzVMUm5EVk53VGNj?=
 =?utf-8?B?cEZiWWhOTytrK0NhamZXdUZONDRtMWFZMHYzNm9FZTZlNmxrNEpPS3RNcWk4?=
 =?utf-8?B?M2U4S0FmcC8vRG9uMmUveUJTdFMrOStDVDlEemZSWUVNdFhsQjFCaGJrd3Jm?=
 =?utf-8?B?bUtIOWMwV2VCOVBsMzNxdVdlbi8yMEJRWWQ5dTN1K01DVEVRYjVtbkxXR0R1?=
 =?utf-8?B?M0tTNTVSb3ZLVXpQeTNpWm5ydkZMTlJmYUR4ZGZHRHhoMmhHMElqcmJCVzdF?=
 =?utf-8?B?UFlLRi9nb212SEJxdzV0MG1jNzBSSnN6N1pCL3lFSkc1OUU5L2hJT1NNOFJa?=
 =?utf-8?B?bDlZSUhJemw2TUhHSW5naUJ3OUthclIxSndmS1ZHWmJBWnRhdHY0b01XM3NR?=
 =?utf-8?B?R3BIb2hlZGlCWXlnc0VNUUpscHpMZW9Ec0dJenpNdk5mM1g2V3VLY0NLOFhJ?=
 =?utf-8?B?RlB3M0dDN1RhYURWM1QxK24rRGZiTUhsc2JnTnl1WUpMdDQvTTBaUThQSXpw?=
 =?utf-8?B?bXRWc0thVG5ad1VHdis1U3Q3ZklYcmhxcDlpMWVkM01FSUhDU3J1NGhzSHdp?=
 =?utf-8?B?K0pYSWZETXdBT3gzSVBTaFNkWWppSkxWQlJ4MUVEb1A0blZSbnZLc3JqU1Jm?=
 =?utf-8?B?eEFiN0pxY1h6WTZwbVNsYmFJVzZ3Q0ZSK1pPVlFtM3JER3pFaFRpZy91UjFx?=
 =?utf-8?B?N3RTZDVSZ3VoK2NBSk9xM2p0V3lqeGdHak1KMGtjUDRYNUtoMFdRalFSRmVh?=
 =?utf-8?B?aXcrSXRydlVqNjQxeEtIYjZvbkcvaDZvV2hQL0w2MllwcjZQcjhDUmhEZWlh?=
 =?utf-8?B?R1ZUYW5nY2JNRDBJRDZMMkdMekcxbVpQUVZqeldQa3FHd1ZzUW9OUWttSWg1?=
 =?utf-8?B?SnkycDM0bCtKWkxvV3Urdk13M081eFY2VTQyVjBINXJhcmxBclB1M2ExVEVR?=
 =?utf-8?B?TTM5cVMvcXZEUnNZTWsxYnRWNDVBNmNVcjFJS2V4TGR4Q0VlajVnNHU0eWZB?=
 =?utf-8?B?YWREYitIMFJrMTVTcEtIVW02QzBxNGFCeldob0h2TVl4aGNtR0phNGJkRWlC?=
 =?utf-8?B?WERnb1NrTXJwdTFybTMzZlR1M09XUUtOUlZ0T0pOWW9WSjNMNktSSENjVG1Z?=
 =?utf-8?Q?jO4mBz6Y4Lu3LRaVkRC8TqnUEbsvsQ61GsBjrtBWDR5G?=
X-OriginatorOrg: piap.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c9b5c9-8232-411e-d11b-08dbc986308b
X-MS-Exchange-CrossTenant-AuthSource: DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 11:43:58.1305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e05b101-c6fe-47e5-82e1-c6a410bb95c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKbFJco4CDQh6obPK+bwASVTxKblvth4kN7j3729nxVNGowdYIcp/5W88PKJ+0I3iaUfF5gcQafr0Sdq2qrepIF3Jm+p5ZSy5KBih1Asr3Nd1hMR8Dbo3GY/x6XucLSbnx83phrl0OplZ70vp4BxBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P193MB0606
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Are you OK with the following?
If so, perhaps you can pick it up?
Or state your Ack, or something :-)
Thanks.

Here it goes:

Update MAINTAINERS entries for Intel IXP4xx SoCs.

Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

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
