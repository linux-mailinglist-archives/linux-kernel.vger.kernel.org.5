Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C617C4E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbjJKJKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjJKJK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:10:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8459394;
        Wed, 11 Oct 2023 02:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNTHMit2AZTygELs4yPCav/YeRgCMMWfLAj9DgeNv/rF338+c9AdgZLSOD7XNElsCv7lozwD6Vv9yTSRn1WfjTj5W+Jjj9TuNuIIzZXs9auSUQF6+Y15KANf3uWKjPiugIoy+WHFXYZXn/M/pWF21Rb/6/pQGpWOTuMvRINAr9rNz1W3/2Wa5YpeSUv12kqzyUs7DyOakjNjppv2VEKAKvwYEdBDMhYy2/pmH7Rc0ejA45FNGyFX+5r1cp1Jw5Qx0nsBsbSWzioRz7M9UEeyN05aXfPWH9DSU41nZnTFkJR2xDd0Jf1dhAVgV/xlPlLZh4fsqp5JeVJ7ommq/eiQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdGGHPBjSSNHg/upVv6hExLMwdEQgD6j/22W5/NgLJA=;
 b=C5ESDnwvdpMQKQCKWZRg+jw67lMSBDOQwOj0NaWxqAnFtC0RhJjEYK1kAcyvVOBbiTFgxL/limMtqjoOS8dEhF31wmgd0ZphYsA935AzxZ8OkMR04fQMMXe9sULNqFihJkvMJDXYijEWfP7OFSueGV0zYcy5OCY1RPMBkRk21yv/0lHqXQmIU3INbn44oodCshMO8K62We13ZokzzhgGgKadJVQJ75fK0DS5g7DTo0BXMAXf1w2ZtwwMjka+ZDDQcLaKP0HimiSFuDATw+HQr4DZVLRYakV7c18WcQXTpd6xUJJEi+okxO+Bf8D3YNCiEiCo3PZWhL2W+Q2hicgRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=piap.lukasiewicz.gov.pl; dmarc=pass action=none
 header.from=piap.pl; dkim=pass header.d=piap.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lukasiewiczgov.onmicrosoft.com; s=selector1-lukasiewiczgov-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdGGHPBjSSNHg/upVv6hExLMwdEQgD6j/22W5/NgLJA=;
 b=yGPSWK1jiQEXZEdYTha39ZR4NnMwrEdQL99Xra85P3ezRIKTw9Qvl87xrinwvy9v8lXB/3jBQYzuPmEtLd7UP40wfzmYX+N4DdpPdEY+OKnGQJnI8os1hMl5mJXezNI0WBDYgamPL1kxTuoV3lI+/wCl6NHN1utltfpPpek1Z9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=piap.pl;
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:155::18)
 by AM9P193MB1047.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 09:10:21 +0000
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::1bd8:1a5d:e69:d1a7]) by VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::1bd8:1a5d:e69:d1a7%3]) with mapi id 15.20.6863.041; Wed, 11 Oct 2023
 09:10:20 +0000
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     linux-media <linux-media@vger.kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: Sony IMX290/462 image sensors I2C xfer peculiarity
References: <m3y1gpw8ri.fsf@t19.piap.pl>
        <CAPY8ntASwh3AcRqE+2zF4Df=u+=wJ5K9icAeOrXTMJGDd1+caw@mail.gmail.com>
        <m3o7hfx3ob.fsf@t19.piap.pl> <m37cnuvmhn.fsf@t19.piap.pl>
Date:   Wed, 11 Oct 2023 11:10:20 +0200
In-Reply-To: <m37cnuvmhn.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of
        "Tue, 10 Oct 2023 11:46:12 +0200")
Message-ID: <m3o7h5tthf.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA2P291CA0044.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::20) To VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:155::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0685:EE_|AM9P193MB1047:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c4ad58-e5ee-4da5-b229-08dbca39e4f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txN5jWWxfBmjSBRbX5c1sQGVs9ZQSwekkh2sIU1swTjC5rnDJ00EeO9jDMAp1GHpr9YoDzth17bn0ysn2RbPNAYlE0yb0UwAwdk1hC2FjK8+Ut3I2kfjpwvanC3cj7FhlVZpiIRLbxAdMzLANEVBTy4EQ3Okb0/5hLC27znUt/uMtIozFkZHFrBSOjS5C1grp2jl5Xly4Zx5Rn9axs9Xc6NUpI3QgQpKDx9SfuW5P5yD1/zPuvLAf7R6qMTccHCQxiqvvhvUumm8hQbVmR+gr39MgX3onde8masi/b6YDpat2VbmhlxcOlS6UDWD88tsOxX2x1Hhap0cK7xai1G/mRowJEmYhSJfB8rVMdJ1OkvSt2jRROEqpXT40K+TZ9KTxisesP9XvV2wBCQkETf52gmceObAcpZ90gkrUXmFD8581cMHzgCvtlbmOd+Ff1KLnnyQgPpRmMXhg7+Lb0fZtEswuX7dwqFzH4Q9ct9jrU/zyYtGghB66Dpr5KVGSIYcv9DasQjFmKfxZOeHLlO8OqEg1H5pU2U/GZ9kBF33KYoD3MZxl2olkaxmkGio1lZTMlKYq9ng9cHTqUkoBklh9G0o5S6zqzcxdzpKpsqOl0yJK9IPtMFw9qB/NuPqV75p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0685.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39850400004)(346002)(1800799009)(64100799003)(186009)(451199024)(2906002)(52116002)(66574015)(83170400001)(6512007)(6506007)(42882007)(26005)(66556008)(6916009)(786003)(54906003)(66946007)(478600001)(316002)(66476007)(6486002)(38100700002)(38350700002)(83380400001)(4326008)(41300700001)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d090bndiZXpUOVRRaEl2QWVOc1QxVGFMTkxvcjZESUU2bW1HZ05rODV3bzZD?=
 =?utf-8?B?MnNMaVNOK3VWM05OaGpjeXVDc1ROM2FYcjBaTUNHNEYyeUYvUVpwQzNsR0Fv?=
 =?utf-8?B?ZFpjT2Fxd2pjK3FVM0Z3ajBId2dkTVVyYlQveWZ5ME04QzkrcUsrT2c4MEk5?=
 =?utf-8?B?WTNwK0IzT3IvNUJQM1diSHBUejhEb1RnZ2FVZ2FUZzJWWHNIN0NvMU1qUVhj?=
 =?utf-8?B?V0p3elB4eDBpWG15bmk5U2JiMnV2QmV4am1sRytMSElRMFQwc0ZHNmVXeE9a?=
 =?utf-8?B?ZUsrRXZtb2dTSDhpR1ZKcUtJb0YyN2VYUWMveTBnS0pod0RQRVhvMWNaTkZT?=
 =?utf-8?B?UVRWQllQbkQxeDJsOHh1YjZGbFdxZkJJS0RVa2RlKzVGSFM2VUhDM0ZucUJn?=
 =?utf-8?B?TFdWd2dhMDZsT1VUQml3SnBDajRhZlNBTXpBZUdQcHdIcFV2U2FEKzNZa0F5?=
 =?utf-8?B?UVlaL1M0L0NleGhiWkZ2YUh3MmdEbWZqbDFtTlFJd0Vab2ZhYzRSTk9icWt6?=
 =?utf-8?B?RjZhcmQvQmFucEFRanFzWlF3MldVT0FGTWZ2S3hhYWtCTy9qTlRqczJwaXNz?=
 =?utf-8?B?RnlPS0hiQVpNV1BWRTVpeXNab1c4dTRmR21iK0orMnJxWXg3MXQxeUU0OFh5?=
 =?utf-8?B?TVNVTFRUZ2lpRjVqTnhPSHlyN244T3QxUFk2SXJDWlE0bnhDcDdOcjZLVEtW?=
 =?utf-8?B?ODg3TGZ1Q3dGclQra284aXh2SThYTFROVlFqQ0xMYkpWZUY0bUlnRE5ReXdG?=
 =?utf-8?B?UUYrdUZSMzU0Y1l5YlE4K0tMQmZlbW96dWNWMXVnYkR3eS9UVmlRR3h5MHNt?=
 =?utf-8?B?SC9uNm40MXVuZWlGKy92ZVh1Y2hqejlmTlJEb0ZaTnpKUU5UZkN4UmdHU0Yw?=
 =?utf-8?B?N0xsMkpIWloyYXorakxvSkcvVS95c0dQMG85RW1oYUdjQ0lYM04rSEhoWFhR?=
 =?utf-8?B?M3BSaGxCWkVJYlJjZlhncGNVS2doblYyRTJlUHN3SjlzY1hRR0IwSlI2OWdN?=
 =?utf-8?B?d0ZDQ29kUXd6N05BVEhQVXlwWkFQN0dyamE3QVlJZFFGbzJLT2ZUTGFWSUFy?=
 =?utf-8?B?cms3RGw1TC8rWDRlQ0I3K3BiZC92bjh1cjFvZ1N1N0xISFVqZU1DZkQ5dFpl?=
 =?utf-8?B?UmFEVi8yVHZQcnF2ZDR4Tk91bTZhRlBuL2dTRGNmZCs2c1hBcm5zc0pEWE0r?=
 =?utf-8?B?clZZWWRUOVY4andwbnBXM21NUUNzQUhGdzhUZGg1dWZxVWJ1UU5hTlYzR1B5?=
 =?utf-8?B?L0lwRkpGaWJ6WTJ1aEFMSHFrdTdFVjBickF6NU1Xak9JOWhldUE2bjhYRGNs?=
 =?utf-8?B?dzRFL0x5Tm5sSUdiRmZqQTBtS2VXMkdpVjVmNVRnM3dKYnIweWN0MnR2YlVF?=
 =?utf-8?B?bllHRlE0bVYzbXFvVnZJVzZRL2FOZGdnREYySzZmTHk0YUFBRHprL1RhK2Fu?=
 =?utf-8?B?S0NaWlRVK0doMjJCQm16TTlkbyt6cVBjSWg4aUJaaWo3NFM1SlgxK0ozUDJj?=
 =?utf-8?B?bjRSeWZxQ2hVbHlWaFJhZEpvZXJ6Q3VmQVJYUmNrdEFmK1BML0pHU3ZoVWlJ?=
 =?utf-8?B?c1FmLzdyalY4bmpaVUVhRWk1SkdGMFlrL05DWXJhVE1rblJ6VTU2TXhyUkJ0?=
 =?utf-8?B?bjdWSEtHdFlOei9XcmVTZWdjVG9BdDd1STljTENMT2ZlMU1LU0cybE80OE5N?=
 =?utf-8?B?aEVJcVh0Qk5oU0V6dDdPYXVDQWxBcUk1cGloQTgxczdLcU8za1l5eUY4NnNK?=
 =?utf-8?B?Y1prVmRldmsxY3pTWUcwUlYzeUtRNVRKSmhpS21QL2Z5RWMrT2lpQm52azBh?=
 =?utf-8?B?L3hRZG5TOFZsVlFSRXRPZkZyOVNBS09QeTQ3K1ZvOG9PNytrUlpldGhrQXph?=
 =?utf-8?B?T3A5VURrZUVyakdZTEt5WXhnRUttbEoraytkSXdIcDZWR1RCTm84K2lsSHkr?=
 =?utf-8?B?dngwU2ZWUmdDNUFmT3JmZGlFMGFxMVZQRDZiOGVHUUVDUDZ6ZHBCWC9HN2Rl?=
 =?utf-8?B?ZmNnSTNwRkJOUEFkVDFjSWcxWGVYMW41VUJVTVp5WmtnY2liVnQzcGx4M2dY?=
 =?utf-8?B?UkFSZEVNM3Y3VCtYQnAxalJJYjZ4WVFGMm56YW5rVlBjUlo4TTlRUnA2NVN0?=
 =?utf-8?B?V1NJOGI5Ti9ZNW5XUm5tQjlTOGtVenk4d2hnSUlNSlZyUXRkeWNXOFduMFpa?=
 =?utf-8?Q?ICdMtveN/pY1Pg494MSfPzD84N3+QG1X4GSQn3jHwNBy?=
X-OriginatorOrg: piap.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c4ad58-e5ee-4da5-b229-08dbca39e4f7
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:10:20.8283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e05b101-c6fe-47e5-82e1-c6a410bb95c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rg+SD6WIqPUvdJo0em5vJihs1ryRZ20oEVpm6/PH3msx8l6Zp6PPa0GUu0PpAMgUdYd3+UwJzscfhFf97d3+7b9imR2I9+fRoT+0AM+VzC+WakoBGuco+IVmccvXIcUKtzzIE6ijbmApvjF2qC+ehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1047
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For the record, I think I will use the following. This way reading
a register from Sony IMX290 and IMX462 image sensors (which behave
exactly the same on I2C bus) takes up to ca. 270 us, and writing
a register takes up to ca. 230 us. While still slow, this means the
sensor won't disconnect itself from the I2C bus on 7 ms timeout
(I wonder if the timeout is 3.5 ms on sensors running at 74.250 MHz).

The times are on i.MX8MP at 1600 MHz.

0x30a50000 and 0x30ae0000 are I2C controllers connected to the
IMX290/462 sensors.

Not very nice, but works. Obviously, long transfers (like reading 0x100
registers at once) won't work (0xC0 seems fine), but the sensor driver
only does 1-byte reads/writes (resp. 5 or 4 bytes on the bus).

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 97455283ef0cf..ffffb0d50ebd9 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -275,6 +275,7 @@ struct imx_i2c_struct {
=20
 	struct i2c_client	*slave;
 	enum i2c_slave_event last_slave_event;
+	bool			no_sleep;
 };
=20
 static const struct imx_i2c_hwdata imx1_i2c_hwdata =3D {
@@ -1249,8 +1250,15 @@ static int i2c_imx_xfer_common(struct i2c_adapter *a=
dapter,
 	unsigned int i, temp;
 	int result;
 	bool is_lastmsg =3D false;
+	bool really_atomic =3D atomic;
 	struct imx_i2c_struct *i2c_imx =3D i2c_get_adapdata(adapter);
+	unsigned long flags;
=20
+	if (i2c_imx->no_sleep)
+		atomic =3D true; // IMX290 and IMX462 sensors disconnect after ca. 2^18 =
MCLK cycles
+
+	if (atomic)
+		local_irq_save(flags);
 	/* Start I2C transfer */
 	result =3D i2c_imx_start(i2c_imx, atomic);
 	if (result) {
@@ -1258,8 +1266,12 @@ static int i2c_imx_xfer_common(struct i2c_adapter *a=
dapter,
 		 * Bus recovery uses gpiod_get_value_cansleep() which is not
 		 * allowed within atomic context.
 		 */
-		if (!atomic && i2c_imx->adapter.bus_recovery_info) {
+		if (!really_atomic && i2c_imx->adapter.bus_recovery_info) {
+			if (atomic)
+				local_irq_restore(flags);
 			i2c_recover_bus(&i2c_imx->adapter);
+			if (atomic)
+				local_irq_save(flags);
 			result =3D i2c_imx_start(i2c_imx, atomic);
 		}
 	}
@@ -1318,6 +1330,8 @@ static int i2c_imx_xfer_common(struct i2c_adapter *ad=
apter,
 fail0:
 	/* Stop I2C transfer */
 	i2c_imx_stop(i2c_imx, atomic);
+	if (atomic)
+		local_irq_restore(flags);
=20
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> exit with: %s: %d\n", __func__,
 		(result < 0) ? "error" : "success msg",
@@ -1627,6 +1641,7 @@ static int i2c_imx_probe(struct platform_device *pdev=
)
 	i2c_imx->adapter.nr		=3D pdev->id;
 	i2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
 	i2c_imx->base			=3D base;
+	i2c_imx->no_sleep		=3D phy_addr =3D=3D 0x30a50000 || phy_addr =3D=3D 0x30=
ae0000; // IMX290/462 hack
 	ACPI_COMPANION_SET(&i2c_imx->adapter.dev, ACPI_COMPANION(&pdev->dev));
=20
 	/* Get I2C clock */

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
