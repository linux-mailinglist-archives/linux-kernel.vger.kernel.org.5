Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB9A766786
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjG1Iog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjG1IoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:44:19 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704F02733;
        Fri, 28 Jul 2023 01:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5HMrZLm3uuicreIeJEaGTTmezInb+pxkdMwqXoE5s08A34cD2Iph+ktQ/MBYUmR+ZAwLMXZYw5gpyHvDb0wv0OR4pudjpbeGgYD1R8ivjbO2HqpZtv0qS9r0oXfEk4EriULlnyZRhI6640qn9FayEC0J4XxHMaBg0K1nZ8Q2+Q/wHg7t3cukr0k+D8CWy/QQ1Q7d0AWc3Cip3uIUOAlkRRY3bU8n3ZTZKUJN2PH30yhvMDo6DGIGd501lIJq3Xh6DCj0ZQPnaxcFgOI1BVuYPdltG0YywC2Z5nfPFGBHM0eydtWV/q8PXd63T0GLBWn6FgnFrUMdmdu/yobZtbB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFuvP1LeGEJCYCmayUbyRwJj/7jUMbycUodXBueR1Wo=;
 b=R1c8WGdeg86wWEMHh3wNbUv4S/INpKAL/mSt85cpix7TyGDpJtQKdYE9Nftar8vCd4MGh8jtK7H2hFoa8wDsYN1xbWnm530pdbIxFjPMLKdG1UcqHv+WddLRo7HJ/x7E9r+JJrFJw79pUAQDcDHfW2AX5wDvXn9UuqKDtBGbk9X+m9INX05RAuqLRj1wvJSaAclwbLufRJx4+5lW2h4d6lVHVlMeKnIA0GS4gMx0hO7wdlUzfwa8/ZhlbmVQa2XaQNUViM2HRffEZlDQtrjbjr+mqLGdyqBFzz7FRQSbK0ovamR/qi59QpeTvQyIo1V7ZzYYE+E6AgQccWQUZySxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFuvP1LeGEJCYCmayUbyRwJj/7jUMbycUodXBueR1Wo=;
 b=QX/lerygkajrhMyIamkALutjXzXy0F/nd02TvcztXYUNocBgzLJQ2gZolouXaMWANu+O7aK2vRoa3W8Fhl5gev/ErxkuPtti0lJev2chmxHs0mIs+WVa1QSDZyas+loL2dY3WZ/I7mWd3Ize3Xzm5DlpDiv/sf59GjRr6gFrR8FgfgfmV7ms10ctlWu9lRrrYESTR3hytGuW2+Ngp5fHrxPMJpLrfV7ddh8I58N8yETmtUrZ1sRb30aBKVHaHcjwAy8dZnKlhAtRH6Izwtes0bgtoNQuRF9lnno2wnc2xumuCt58KkAMffOz5HOywPo/FkzfPnlO9KHjZi2gCEaKZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PAXPR10MB5254.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 08:44:13 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e66:8cbf:13f3:c61f]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e66:8cbf:13f3:c61f%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:44:13 +0000
Date:   Fri, 28 Jul 2023 10:44:04 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        "xingtong.wu" <xingtong.wu@siemens.com>
Subject: Re: [PATCH] platform/x86: simatic-ipc-batt: fix reading in BX_21A
Message-ID: <20230728104404.0f7e4ef9@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230728083651.19747-1-henning.schild@siemens.com>
References: <20230725093113.9739-1-henning.schild@siemens.com>
        <20230728083651.19747-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::28) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|PAXPR10MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: f5005126-21ba-4982-ad6b-08db8f46d1b0
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSqCL3DbFIQ1TxOWMCu5kQmJqmDpn2EMUVQHphUoIPKYeedTXEDZLjzLtEi9eWA+xY8E4OUTWYQ/XlQy/Za0ITseLNGzx7mOSBdivsMbwOiyCWxIM1A3eBWDlJlYXv3ecfseIXaXx+bfU7KuyhLaLxhxjga8eCxPlfgWf1yU1H4PRQFHEgv2mXEt8Dnyf+4y/Dvkk+KxzlFGFy2roAJbPGR7h4hyOKiTJHLlPE4J/S+WjtU1y/7olqhzawzJaMpnGdxmFr/4j+ffmHNnyJShv8rWq6D/ZdMFNWXiYcS/8RzAS41huEnveRtMYUQkAYgKbIQXN5Dw98bQNuJv7CQsKJewdj2riu7SNb/aqabviaH4+AHGew8rrHBMinZWbDXK1ccvQ8FOkKDgVtejrh2jkvsTBITmLU5IYfYUnYYtTqFI/EsGzKW9JWfLiEnMZeURqVrHHekMRFNW80QBqwwP6Qz8Ph548O2zCTC+cB8bsATSqlaOV4U7hrgWoYoIn1F1f6vYYSIqUcm4dm+9MgJ97SfUU5axZGBpvQoJzmmao5CRd4OQkbnkUQ5w94v33she
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(83380400001)(86362001)(110136005)(6506007)(54906003)(5660300002)(8936002)(44832011)(8676002)(6486002)(9686003)(6666004)(478600001)(6512007)(4326008)(66476007)(66946007)(66556008)(316002)(1076003)(186003)(2906002)(26005)(41300700001)(107886003)(82960400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gDiVjVqIrgGPFY8QdBO8HgujrZ81BOvNKPshuBNfq2X/wlmnml/nHFk+dxBu?=
 =?us-ascii?Q?WIcTw2l+5c4l6KjDr7Bvc6VexVtmnGUDtZKrjIlrg6700KuHDWxwHHEhSCsu?=
 =?us-ascii?Q?3aHcNWX6rxrpSrFM64HYxIzB1C+cNeTjHcj3P9mxeIb4esp9xNFOJSAdbL51?=
 =?us-ascii?Q?2XOCjfb7cT7bYRYgIsQVKovgyFF2nbcWTKZoSegjLImEXkgByhsCa6hpDyqf?=
 =?us-ascii?Q?Mz7OUUKX20fmzWunMKHAWBUnoGNwoZjjDbldxTQStbGHvk4TraqeK6HPxNdh?=
 =?us-ascii?Q?tKNhLm0FDaBUXeJ7CIgvVYy8Ab7DHbzKWrHA3Jcc4h0/lzPKB7Ji5jfgjywK?=
 =?us-ascii?Q?C8ETuGdja3UT31B2y/HOGTlwr2bDdKi+tx9FTnjeDG9nmRT2YPk2Sx27uGe2?=
 =?us-ascii?Q?Gle520ZXbM3kszc4pefw5vMwWPoVPochSS7mhEdwQhP+T/1mqXndxaZPeuaI?=
 =?us-ascii?Q?0IoyBdOki5eYWIzxcE4ouFvB36mLSaSMHWyPoG4OybWqUaF5WgKA168npT51?=
 =?us-ascii?Q?6Ei6RRm+68QGGEyfBHTiuSR7mkgd0Zuic27eGLxBjTYV+nyF7bX82puorxMT?=
 =?us-ascii?Q?fFte1h1oM0GA2XYsVeT74MIbdumSiMRCn1dNNE0auWBqWwIfhHcUJcV7hK+o?=
 =?us-ascii?Q?XIeJdpntM/ISufhE6lY4z3cl09acmMzOVUtagNkMNFWUzLg0TyY9WVLSh1Lv?=
 =?us-ascii?Q?D3mexXZO0dk4aDZsuk4Q+DJxeNdUixgXsLFM97IkquWGgFxwhaanDRSlPtb7?=
 =?us-ascii?Q?G0o27w6qECRLGvE77oVqFKyOE8m/QisM2ef3OafT4/fnlldS/Xn1nVy3K5ic?=
 =?us-ascii?Q?2+SJMal6PiDZVisbL0iXKLrhoISuugeaPiXVG2JTCzK+TYOYF9vAjnUC1ny/?=
 =?us-ascii?Q?6HlmvEi6jkj7cEayXkNGwohZOCCSbmauQdpXPFKOs+LN90l4MwdwaGevgVbU?=
 =?us-ascii?Q?zDgqxggop/0gF6Aij4pfunF3yp8yt9toOxjsxmJIZPHbmn0zLBgsBFVvXBVJ?=
 =?us-ascii?Q?rdo9jtKwnYKIuzkRX4vfsUONNivqiPeWq+KdKlMWMB1xT04Ap2E6EJgkio+b?=
 =?us-ascii?Q?23IvFSsqvMYbZMdpEFPl9BRZMukexCS0YMtQN4dk5KbGK1M0ySSbG3VxYTZK?=
 =?us-ascii?Q?igrS2Km0Qlc71Q2g/ckBEPKjKtaRplLR027BCs2I095x1oBkk3gBqYZVMyQs?=
 =?us-ascii?Q?zPKG7f0pRZ3RQe32/Hee8qsyDeSQB65SXItUoSeMmZXpKG/r2CrxXrdj0UBL?=
 =?us-ascii?Q?tB3gS5an5U+zEG3+afHXCOUJfTlDtTHTZkhQ6fclN5ZY+8dHhM5jtAGE2V3I?=
 =?us-ascii?Q?cb0axv5J20p1g3MpReXF4lkLnJKd9UQa7mo0uvKnBOQu0xUnxZTtfTwnfwgf?=
 =?us-ascii?Q?tAR6P+Z6D8qzODo05o+o3sCe802yYryIPNylDhmzLpgs3FqOsscwxCML9My2?=
 =?us-ascii?Q?5JiYI9bdIBUvKyebiOkNtGptAxUyKGTPtsJKOTjnyr1PKyZg2iXh1+kKznEL?=
 =?us-ascii?Q?VcKa3EzOZCjHeecZcMrei9DtXzuwCp7Rrs2Dni2a/cxvZuf5SO0kIZgucn/w?=
 =?us-ascii?Q?XrK1Z34chx3+iTdpJxvORog1B0BSYLM0JRToEpsAeOma3uKgkZe9+4bwpFAL?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5005126-21ba-4982-ad6b-08db8f46d1b0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 08:44:13.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIOsIgtrRqXCy6WXULld4KOvNQo8N2buIflWoar6yMSZyL1SvZf4iur39ix40OpsVFTRN17kHh+TS3Km0ofbkMM2mwFJ2ke4UrvA19MrAlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5254
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is in fact "[PATCH 1/2]", it needed to be send again because it
somehow did not make it out into the archives correctly. Sorry for the
noise if you received it multiple times.

Henning

Am Fri, 28 Jul 2023 10:36:51 +0200
schrieb henning.schild@siemens.com:

> From: "xingtong.wu" <xingtong.wu@siemens.com>
> 
> There was a case missing in a switch statement which lead to that
> model not actually reading the GPIOs. That switch statement got
> simplified now. Additionally on that model we need to initialize one
> pin differently. As a drive-by finding also add a missing newline.
> 
> Fixes: 917f54340794 ("platform/x86: simatic-ipc: add CMOS battery
> monitoring") Reported-by: Henning Schild <henning.schild@siemens.com>
> Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  .../platform/x86/siemens/simatic-ipc-batt.c   | 21
> +++++++++---------- 1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c
> b/drivers/platform/x86/siemens/simatic-ipc-batt.c index
> d2791ff84f23..e34417ca9e13 100644 ---
> a/drivers/platform/x86/siemens/simatic-ipc-batt.c +++
> b/drivers/platform/x86/siemens/simatic-ipc-batt.c @@ -92,19 +92,14 @@
> static long simatic_ipc_batt_read_value(struct device *dev) 
>  	next_update = priv.last_updated_jiffies +
> msecs_to_jiffies(BATT_DELAY_MS); if (time_after(jiffies, next_update)
> || !priv.last_updated_jiffies) {
> -		switch (priv.devmode) {
> -		case SIMATIC_IPC_DEVICE_127E:
> -		case SIMATIC_IPC_DEVICE_227G:
> -		case SIMATIC_IPC_DEVICE_BX_39A:
> -			priv.current_state =
> simatic_ipc_batt_read_gpio();
> -			break;
> -		case SIMATIC_IPC_DEVICE_227E:
> +		if (priv.devmode == SIMATIC_IPC_DEVICE_227E)
>  			priv.current_state =
> simatic_ipc_batt_read_io(dev);
> -			break;
> -		}
> +		else
> +			priv.current_state =
> simatic_ipc_batt_read_gpio(); +
>  		priv.last_updated_jiffies = jiffies;
>  		if (priv.current_state < SIMATIC_IPC_BATT_LEVEL_FULL)
> -			dev_warn(dev, "CMOS battery needs to be
> replaced.");
> +			dev_warn(dev, "CMOS battery needs to be
> replaced.\n"); }
>  
>  	return priv.current_state;
> @@ -163,6 +158,7 @@ int simatic_ipc_batt_probe(struct platform_device
> *pdev, struct gpiod_lookup_tab struct simatic_ipc_platform *plat;
>  	struct device *dev = &pdev->dev;
>  	struct device *hwmon_dev;
> +	unsigned long flags;
>  	int err;
>  
>  	plat = pdev->dev.platform_data;
> @@ -196,7 +192,10 @@ int simatic_ipc_batt_probe(struct
> platform_device *pdev, struct gpiod_lookup_tab }
>  
>  	if (table->table[2].key) {
> -		priv.gpios[2] = devm_gpiod_get_index(dev,
> "CMOSBattery meter", 2, GPIOD_OUT_HIGH);
> +		flags = GPIOD_OUT_HIGH;
> +		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A)
> +			flags = GPIOD_OUT_LOW;
> +		priv.gpios[2] = devm_gpiod_get_index(dev,
> "CMOSBattery meter", 2, flags); if (IS_ERR(priv.gpios[2])) {
>  			err = PTR_ERR(priv.gpios[1]);
>  			priv.gpios[2] = NULL;

