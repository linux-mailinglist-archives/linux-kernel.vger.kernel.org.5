Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD727B30E0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjI2Kxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjI2Kxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:53:30 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDCE199;
        Fri, 29 Sep 2023 03:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwIJmgbDcYXSXDDCUvAFu/3EmuVAnfPr+tLlNnEOp/87cWDjiAGRF2/iST9j79w34PfG1zDENqIKOICOgpeFz26vR32hdF4PHsr/9D1Z7H3rCO2uiHvqVEM274Xu2UgN6cMmnNqnhdgMKnX4bVLkZvzJ81g/Jgv47ZyYoxMWJPpsyUsSGiLUz6boNSKb7xbVbYwr8+bM75eKHm+Kq6+o95xwO4pbgcotSmFfNB9iIUURlvpy8G0lUnR6rgNuaQW8ZMRJ/78a5C6UHYM/vQacKwq/rjJmMDeFSfjRUzPMsaKbR2Qv4ivGDYU7gNP0JFIcMjmNt411xeohcSny9JtEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHsFNsct1g0Xvyyg+xsSlwt88Xj3EJnzFzk8XPbJARM=;
 b=HqhtDvO8Jrj/3T/Kx90rsrP9XHdXicYtC1SmX3XaPU1s2FbyFP6dUhfR3O0jdRXhJMgaopJjyQrQLtzTKJ120z2RTKEKv8FmVsFM/DZXkAOLojGnDlwiJdDxCUhOCXCyAMHfWr1yWc6yED24+7eapuUw5jA4h3g7pIVvSH3Z67N4Oygxn/ezNU96gND4+C04Ym1vNljImQTzHKm3PCkMdpDvJ+2VTqn2InqroZtKgudJtxiwKUp4ApQQJT/MdoXnP1B3SvTGIK+KzkbDlyG3KGfcNL1qvABKMYTZZnJSa1j9u4GE3p7wT4464Oxt+iKVNoMmIw5mmlWPEQUcsi+Pjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=piap.lukasiewicz.gov.pl; dmarc=pass action=none
 header.from=piap.pl; dkim=pass header.d=piap.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lukasiewiczgov.onmicrosoft.com; s=selector1-lukasiewiczgov-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHsFNsct1g0Xvyyg+xsSlwt88Xj3EJnzFzk8XPbJARM=;
 b=XH+gocSUvCkywLTbbqAuLfS7tfyhk6rJ5ZkqXnV5LiBQOqC/XLIRHB8rH3AIJiZhH3Y7rNG4WbDioDNZLhjF6oMQNCnL1YUQ+Wz/pkqBLQQ7tIggxpK5x7yJKcnuvkzXc6k+nOZe3PWILDy7rv08UXLhr315ocixLSiXc3oFYjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=piap.pl;
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:155::18)
 by PR3P193MB0848.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:53:22 +0000
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::579b:2:bf1f:24d]) by VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::579b:2:bf1f:24d%6]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:53:22 +0000
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     linux-media <linux-media@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Sony IMX290/462 image sensors I2C xfer peculiarity
Date:   Fri, 29 Sep 2023 12:53:21 +0200
Message-ID: <m3y1gpw8ri.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:155::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0685:EE_|PR3P193MB0848:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c67392-6a8e-4712-b65e-08dbc0da4c4d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVaBdjAdDXBJnS9zplVw15f+LrQYJkJbskZDUJ02vqjwVL1aUGl/+vD1QR+hcY5pqls0z6WNGGbacerBMBtFQEIdaj3EQ5d6zd/C10DR5GHK/uOw7umPhDa6BAPgipt51N9aiJ0XGowvkAereZypP9WSH+LVBlow2rSUlYOT+SaPwP053KpyrzehsalkPaGmJpyGHsVMwN/ivCEgizXs1xrC9C9CYGo26or11E0m14b+9gBOVOorOkmbTo8OpE5+YmTOf2zfOEyJPQADC++PHAMtSDUkxZNkSO99XJIs9eSm4Bfgox+kmrtBA6mx4ekTaE7fIm3fJaLt4tIgiZ+dQz/UC5dzSyBL6sd3Q2NmkIVPQkHUDbodyukQhroLyTz+pka5UQiM4eU9T/cD8YVxwJ5ID4sggRjnIaIrAPCRf+Jplas0u4voX4iTOpLqjtVgDsl3ebDqjS5Imq21bcz9zw+4CUcZ08zijGeCBf8YsI8WEyUx0IAyR1s0ITqLE7sxV/vrnul+7of8GLWfjWSwpCdcV6d5t8axtyHhIDqYmhdJgwQTSYlmVZNRxREKpT1lcJgWRnapezU3xGDQrgg4lOsArSrc3R1wxUKovpaQeqRz3LTEraxrYVZPSwU18/TB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0685.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(64100799003)(451199024)(1800799009)(186009)(316002)(786003)(41300700001)(26005)(2906002)(5660300002)(8936002)(8676002)(450100002)(66556008)(110136005)(66476007)(66946007)(478600001)(6486002)(6506007)(52116002)(6512007)(66574015)(42882007)(38100700002)(38350700002)(83380400001)(83170400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3FoTjlTVWNobldYYXZwMHJsWEhJTk5pUW1NRU40REptMjNFLzJqcFJPYU1J?=
 =?utf-8?B?NTUwOXNiWWdXTDZvM3hzcTVkdVQxS0pTc2hwbXFMb2h4SGNGSUxQbWkzMWtv?=
 =?utf-8?B?ME9JZE5QZnRqTk5nak81YXM3eE9DOGRYcFR6YlRBRlN2YTBpVjNkWmhVc2Rh?=
 =?utf-8?B?V1lXYUNvejdXT09hTkNHNVJNcUF6ano2MEduYW1SZk55T3NxZ1ByTlJsVVJI?=
 =?utf-8?B?K2dtdktnb3IyeXdPbDF5bGxod1YzV2Q2NisrM1M0UlRsdWp6VVRQV2pKbjEv?=
 =?utf-8?B?TG5IM25tZlBHQU5DckdTRU94ckwzK0Zaa2NSVFRDRDBKYmdZSzBBbUNKUkJa?=
 =?utf-8?B?dUEycnRMaG1yNmc1cXZXQ1N6aitVSHpXdmdZNHMxRFhXamVLZWNwMFJvd3Fv?=
 =?utf-8?B?ZUlRU2pvQWVFT1JRNTRCRVRjbkxUYjRkMHBGaXZiL2YvYnhZeVIwS3pYQm55?=
 =?utf-8?B?WnB1NzRSdUU1TWJuLzBTQTh0OWdRdWNTeCtacXp5U2NQWUNQKzE1Nk5nM29N?=
 =?utf-8?B?Zjg2Q0ZiUkR2SUlQRnBGK3JQMlpCRVVPeEdyUk10aVYvemNUSzRPbVdLdmpz?=
 =?utf-8?B?cEJEUG84WWVFUzlXUU9PS2NpUldXRnVjYUlybzdSNkVVOUo2TENENmFUeDZ4?=
 =?utf-8?B?VnJXeTFjL0FleUQ2bUJBMFdnQXBvdnExQjNLVnNDWTN1K2pya25FVUVwc0NV?=
 =?utf-8?B?bHd1YnFZT0xFbGNuMkt1NVJVWVNTVzRxb2Vaci83eFF3c1Q2QXA1TGVPMWM3?=
 =?utf-8?B?ZnpLM05MSzFWWGVxc2dTOUFuS3RCOWVpdTBGWHl6czl3UTJRRS9kSmxxT3ds?=
 =?utf-8?B?S0JkMHpUdkxLTlVEN2pxRjAwQXVPTzdhaWM3N0RQM2dURTBCS2lWQ0JSbGhC?=
 =?utf-8?B?TXU5ejN0cUZnU3Z2aEJ1ZlFMd0R3d0pIL3VwM1JTNzJzMnlEM2loZjMwUzRM?=
 =?utf-8?B?Q2NRckhmd3h3QUlHNHd2UXYvOHgxOVRVblVidzJkb0ZQM3hwTWZnNi9sTHkz?=
 =?utf-8?B?SnZKQnFoa3RJSTZlZThra2tzOFkxdTEyYVVzMjZJYjFkb2ZLSzI3QTBxSE9G?=
 =?utf-8?B?MFhZbmUwLzJIM0QrYlkyaVo0QkZ0ZnNCT25zZGt1a1lUSXlOV2hmZi9taG9u?=
 =?utf-8?B?UUJrejY4NHlsampQTzNPT2JCWWo4Tld3ZzdMZjNtUmJVOGtYTmw0dXFYakY4?=
 =?utf-8?B?T3NCRlplbGZvVHNVZHFDcEhDRmM5blN6dmRzejJhdVlGNUp5ZWdGK1NWaVZV?=
 =?utf-8?B?N3dWVDI2dFl4Rytnb1RlQk80RHErZFltOGQ5RVUvVEUyVURkL2xFVllFbjBm?=
 =?utf-8?B?dmZUdFl4Y3l0V0NGV2l0VWdFVzk0Yjl0ZWRZcUd1VVVwUGpDMGZpc01ZNGlm?=
 =?utf-8?B?WGoyYVpQMTN5eEhCSHBMbnY1NExER0FRZFh2TmRZRStqMERaKysvVjl0dWo4?=
 =?utf-8?B?d09PUklkRDNmVktBQ3A0cGlML3RTTFh6WktWWEdQdkdHWVBLMVZuWUZkSUpa?=
 =?utf-8?B?K3E0NnBnUURQM3RRV2NXNllyN0t1SGtEMWUzMkhPdDZtaXkwRWMwRUoxMzd0?=
 =?utf-8?B?QU0ySDN0YnRVc2czTytrQittVkhTNDgrUGwySDVFMFhJbTE0Um5NY1JRRjVs?=
 =?utf-8?B?U2ZBV3dOdEUvSjFTdGdCcDNmUitoeVkrVXNDTWlzSDZ3TFJDOXVFbFFJdXhC?=
 =?utf-8?B?WFl1cEM3SCtuaHoyc3ZObnZKWG5GRXFFY0RMd1MzaEhobldkam9jRjVVN3Rv?=
 =?utf-8?B?NUVyMHA3SXNzMWYyUENXZ1V5S2JoYllGUk5xZnFDMEVaQWYzSEdoNHptNHpD?=
 =?utf-8?B?VGhaWlRoRXdEbWFDbEEwQTBleTQ5OEw3NDJiajlmN0lmMUtiOXpGcFhNMW1m?=
 =?utf-8?B?eWpKUWZ3WWtuS3l0TlB4T0YvK3dDb2FBSC9LU0lUTll1SmhQN3ZqS1NEUXlK?=
 =?utf-8?B?MjR2enViNVpXVU1KNzc3ak5aZHFjM280WncvVmVGekprMW00MFZqSVpUYkRm?=
 =?utf-8?B?N3U1cHlpK1VkU0xHQUJMVm9RdUxiWEVOSU1uUmgvMFhoTVI2VUxkQVJFYlk4?=
 =?utf-8?B?L2JzVXdzRDRNZFZWa2VubnNFeDYvUzNQTk5wVmxaVG4vVnlnRGpmTGtVd1lr?=
 =?utf-8?B?NTVWazhJUkVGOVJrZ1pGUlRLR0pNc29VTmVyekxtWDEzMXVDdlJqZFdKN1Rn?=
 =?utf-8?Q?4NWODorU5bAwLLy57AJ5z/K/AsI8wIq3AHAh7ucRV8l9?=
X-OriginatorOrg: piap.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c67392-6a8e-4712-b65e-08dbc0da4c4d
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:53:22.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e05b101-c6fe-47e5-82e1-c6a410bb95c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBaG5mFuZ8jnem/0hPkYqsI3PSVng7GTzfHLkE4K/sx8Mb9U1k8/4qBGFf3f5Qx3hsOCZg5aM+NGJdp4anE3ToCReLGciQWa4elO6aSFuxsir2cc0Z6xf2duu8cmkzCKW0EugEjdA5aicWDiu9MFLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0848
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am debugging certain IMX290 and IMX462 I2C failures on an NXP
i.MX6MP based board and there seem to be interesting "feature" here:
Sony IMX290 and IMX462 image sensors apparently terminate I2C transfers
after 2^18 of their master clock cycles. For example, with a typical
37.125 MHz clock oscillator, this means about 7 ms. In practice, I'm
barely able to read a block of 128 registers (at I2C 400 kHz clock
rate).

I think the sensors simply disconnect from the bus after 2^18 clock
cycles (starting from the first START condition, the repeated STARTs
don't reset the timeout). This means, in case of a READ operation, the
data read by the CPU after the timeout contains all bits set to 1.
i.MX8MP detects arbitration losses, so if the SDA change to 1 happens on
high clock value (but not on ACK bit), the whole transfer is aborted.
Otherwise, the ending bytes are simply set to FF (and the last non-FF
may be corrupted partially).

The problem is 7 ms is a short time and on a non-real time system even
a simple non-DMA I2C register writes can take as much time. This causes
driver failures.

Needless to say, the datasheets know nothing about the feature.

Any thoughts?
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
