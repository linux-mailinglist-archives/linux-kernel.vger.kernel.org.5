Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0322C754649
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 04:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGOClE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 22:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGOClC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 22:41:02 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2148.outbound.protection.outlook.com [40.92.62.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F563599
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 19:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrrLa3MEAXeK4LqlG+pqg45hjjapvVCyBHFhoYwVv+BT25ySrqCMrGG4ZqPPDC/BbkbCS33VvxWiql6T1iwUPZ0AWZezOdwCB8UDVBx804sPlpVmHdKmycOXOFedCM0yHusyoMK0z2kCCzwXI00vqy1n6+Q0WI1vTOJ4E2ZOW8LXzeTbaywvTbAmx49gdJqs+BZ80dkmNZqPfGd4wJXenDeDDeXaPhai8BVA5ARGvbEeknAdGWJZdHWLm0JyDdWI8w1smUyyDQi9cEVDGUQLB+MRpEmrbhojJK3kd4QGPK1A7qDjOph62La7/2kbEYdunirSZ/6IjXBtn7tJPPS6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP360f4nC/GmuJ6VGeTm2O4mNsLDCYSHa9yeb4u11cA=;
 b=ZlA7yopZuUyhH1OAQ8m39oFw4w7nJjFqUgfzgTop2bO5nQNQ9YXC1m3xGHBeHE+mxaPXiaz+ZKxKLkCnojhVgc/01dELOS9Zw52fo5lviVYaFUzU3SrdNMFRxBGaKUarEqK3oqLpstCq3imiSqX303SS13MDtmXtdVtKebPZzq5S4RUGQXyuOTEXcC8MegVA0FhAAU0hQ0TqOnI//dbwZSgio2VJyR0Q4J3hlomNes3lDxqvfpoSm23R5QF6sqC0roD01UdYTI2J990kgLY/88zHhqbAzqgamdjYdGdTA5yW7tCcK2cDWTOnX2ba1C80JNvhhA2ue+pHsNoyKcCOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP360f4nC/GmuJ6VGeTm2O4mNsLDCYSHa9yeb4u11cA=;
 b=Jy/vHfD7EyxzUdJ5dahRERdAoPK/l5zwg9elV0wX8Pacpw3Y3Y4InKnHIBbcrh0c5ZdfzNAHsRnxIZGf8XZSPlV4xgjUm5CfKayBlAmuM0tL9G6ThELwIB5a83C8xFILBq5uhQkILbbj27Kpglpe1Mgrpz8fgkDfOY4UfeiGfEMXv+6xxmLIHLK+qm+01EWYXaauzwGjZj7nLx1Qku0TU/+rwsSe6h0YfFqXT7+Np4UyomAlfcbly8TAx/I2o99+aB+cqzRSm5YejELCG62SgFpVzA7OIO27k4nTZ4ndAY9CvgjkFGonKWGA7YUQNqoZGM6i3Q7IHqfEaLp+7x4IUg==
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c2::7) by
 SYBP282MB2400.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:113::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.28; Sat, 15 Jul 2023 02:40:54 +0000
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8302:9e75:933d:b45]) by SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8302:9e75:933d:b45%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 02:40:54 +0000
From:   David Xu <xuwd1@hotmail.com>
To:     luke@ljones.dev
Cc:     alsa-devel@alsa-project.org, andy.chi@canonical.com,
        david.rhodes@cirrus.com, james.schulman@cirrus.com,
        kasper93@gmail.com, linux-kernel@vger.kernel.org,
        p.jungkamp@gmx.net, patches@opensource.cirrus.com, perex@perex.cz,
        rf@opensource.cirrus.com, ruinairas1992@gmail.com,
        sbinding@opensource.cirrus.com, tcrawford@system76.com,
        tiwai@suse.com, xuwd1@hotmail.com, yangyingliang@huawei.com,
        yangyuchi66@gmail.com
Subject: Re: [PATCH 1/2] ALSA: hda: cs35l41: Add fixups for machines without a valid ACPI _DSD
Date:   Sat, 15 Jul 2023 10:40:36 +0800
Message-ID: <SY4P282MB183523435D04E3075195C003E035A@SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <KY4SXR.AVPNR1Y9HZSE3@ljones.dev>
References: <KY4SXR.AVPNR1Y9HZSE3@ljones.dev>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [C4yBfgeOSlwPagAeqnPz1p0THeTF6R6B]
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:c2::7)
X-Microsoft-Original-Message-ID: <20230715024036.23307-1-xuwd1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1835:EE_|SYBP282MB2400:EE_
X-MS-Office365-Filtering-Correlation-Id: d318b6a7-6932-4d87-6c7a-08db84dce8b1
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TUvI142j/OdUPzgxVEMj/IKEpMjh1p+Ll+EhRo02RkpYl8+IYvgKJVC0H2VJOFXXlZaZoRvz5DOzeROmWIPNVafAihYhloyMcYMAqiF4H+fauDD+EwvMDI7Soxan5KMWsZokisgxj5uIbLJ/u/NY8aocNoZXPq4fWYD+X4ChQKDlVYjOjedsz93wFo2zUaufvqaea4NCJCpWEQ/PZj+uNHWc0QrFgxcJB9KuBPgVkmATDNjninQ9RIc2Yow4QWJbEMLFxUuAU+R1inNgZnnhjfagAYJrLK+fGWyBBm/BlLSIU7/a7UHUAshTbvldHYvnwablArIsWWZVzpwura6KZ4oIr4KqQh/E3WqH9irK6AcuWT1PAXypakvwDFotWujv/8UA8tECFkIGNtB7bfJ3lwi76FnijN2D+u8IwJFtiZWH/uNrarV+FSXugStxdCLE8VCz62hDgXjdNDLONDccsngAM9jqVi1xCi/TvpxzHjpRZrdweSIHRGr7wuZIgR/jQ/wFW9uifQJEc/1U0cWqb69kv5foREbI6HhFJnJhrsKI92HehUKlFaitFXbbzx+Fh6yRTluKmKOwN+6M8khM3sRttlRoCBxbV1cKzbfP3l2ZY5nYtXUyIX/PCWtSE7L0YapcOWe01mJdQdxs2/ROH+VX0okmSzuiFJvbFZSmSkNvR+F3YEUinR89D8dbWKg0f9+1IR4uFEk/TxngdUMCchqqCKp3JUMab7FBCJfIMSD7iXhPpICZiMB1jHaDhuVVZXLqpabyTsj+LyLGQznYiceVcwMr8WrXz8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QeL9NQchLzHys8NW+yb+VCLPf/67Y6fxQjZuBih9nE76I7hR8IY1IbxjmBH8cTZQkhhley2EgL/NZdaAVJpfYLcn5qRq4SKd3UFfv3UfpAT62QOgA5KwIzqrd9TO3hHpFM0Ar+Lm4QtngJr0DOBAQiNDgdYDUWDw1C744C5thlSrSZ4KUeVai1eWNMpr+tRB7HpJi+72SF5Q0GqT4dgqonMII3GpQuY8n/tZWmhJhbHyOOVxvB4Bc+He8NPAsxOzY7z2LfEfBLnPm2+LMIxIQmeiEEAPnMdqxV5+Nh5Z7UQHLAiBVtsk+vc58BjiBrvUxumLJ0sZj9rCK8tEXFQKUTrAW5VVYdcLfYgUigSzhp9FOGwOVtM1z1E4fqmIYlJzeKCimDfB3Gvf63LRo9F1Al7eI650yh5hCxk1oJ9T0WVk2tOgMGrWNQIw3h+ERcly3apbCY3o0cwtMkZPvxEG++NHthUUqYACw5z4spjupSpk1ilPosR789dnpo1mhDsi3lGQp+of6hVmPhgmd3mwED2qTfXEeqiysZLYi8XjR6SC33+syTWi/I3GyW0Bz4/ncYd5i6WPm576CGJ81aHNpJeNay6pR3cf5Y47HAb6S6XnZztd7Hq/HKojuR55UVx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDu/h6jbq38Bbj89+Ibtr8NbRc4sOfETzgxCZ+uOc4Fe65vqBAnBkpo9W6oP?=
 =?us-ascii?Q?IWcQKA8xnP7ID0jAlDWjEXhO5RFDQ7S5/C0CmW/gEpzP2PfK6XeXVf+p0uj/?=
 =?us-ascii?Q?i9UhZXs33mZWVZ0D911Flty2xYbo7AqVH50COIOpasMyBteKXP8UuvYIrk+r?=
 =?us-ascii?Q?y6mtWDMoc5ps/DbRm7YMaEb9x360/u44idBNqQS3NWYBz1+04jI5F29cAVEi?=
 =?us-ascii?Q?yho1gzpL/Q/Gl8ADhAfXBFMudW8gpoRzpxmDQc0a3GSWLhzSHXA11xwMdxyc?=
 =?us-ascii?Q?evZhBkFQnh7juajJkNMd2qpVL72ptvinwEMWNiVfZyV5FxPYKBznbimmnKEj?=
 =?us-ascii?Q?BjRUSaNnG6o5DCq0lxduEtz2aTaqrXzAMBTacNav7Oiqw3TuM7jRRPa3gsg4?=
 =?us-ascii?Q?Rb9DwFkOL2XK2rrdV+Yxq0Bcea3P8p6kZnFIMs+vmmk6UfBE3nnMr+ltR9XJ?=
 =?us-ascii?Q?jOttsiclEtQKt9OyQieA+Zk8DZrrQnMpIOhDBNulq/zPLaYxbdaWzanAIX/X?=
 =?us-ascii?Q?DE9vSBXxswDxNF+GPGRGUuxU7PLXa86eK1yiiwNApUU9d6wiOXwl0Sb7UTfG?=
 =?us-ascii?Q?b/Mc0J/0dUV8QgYWOAzM13fSASNP60cTyf2JkEowwixsbTzd3X1os9hO4FrZ?=
 =?us-ascii?Q?ycsKgg4HyXtyrPE4NIL4vjfA7K/Y+P9W9/zu9pJ91MBVUw+BVemIPBU6FhSh?=
 =?us-ascii?Q?PYsg2G1tGJgleN1zAArUIYWWbaC3fwaMA9bMOBcZ9brOCngNm4tlDqyEsXMo?=
 =?us-ascii?Q?ZmMVX+MZkEGii2hbRnYXbV1m6EsIv3MYNhgSY2199NDV6iOIscLngfedlGKA?=
 =?us-ascii?Q?S7pAspLph7p0bMBcFh/DHy6ddlkur8q2U34+KrQqDPo9AqypaFUZWGiQvp8o?=
 =?us-ascii?Q?tGaehma96fDTb+UV7TOcffwMVfcSzhZPAvxRlJVVYRdjlhiNwcMS3wTSBNZ0?=
 =?us-ascii?Q?VP+nKdHHMht1xu6MvDIrDo+rGc2IpXz3rVGhqgXTLbL/SN4HzwQge1QXVlDz?=
 =?us-ascii?Q?lMKzLvz5CfIV3SmPw7pSPh9PU/je6yzSyvMe/bvvJF7dci6DSJOrHhx9VybA?=
 =?us-ascii?Q?Ex2G19GTB0qayZJ9KMyg7kg50U6VSQBQkwcsOBr2gF4QwnqS/f/x5TB4hsr2?=
 =?us-ascii?Q?73TLYcjxIGWk2rdS98DRMrw5sJ6ZA3VW4sUrhl16TmL2DJBtjUlsO3d/IUfE?=
 =?us-ascii?Q?O8V1qm56SVi84RBa3Fhrw85HyHwzsu3EaG9xfA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d318b6a7-6932-4d87-6c7a-08db84dce8b1
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 02:40:53.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB2400
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

Thank you for replying. 

> I tried with the patch applied and what I thought was correct setup 
> (in driver):
> 1. without my DSD table additions (in acpi)
> 2. With the CS part added (in acpi)
> 3. With my full DSD table added (in acpi)
> 
> all 3 instances failed with:
> 
> cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: OTP Boot status 80000000 
> error: 0
> cs35l41-hda: probe of spi1-CSC3551:00-cs35l41-hda.0 failed with error 
> -5

I see that you have some problem on making a working fixup table entry,
with your key concern being the three fields you pointed out:

> The key thing I am concerned about is how the values for the 
> following are gained:
> + .reset_gpio_idx = {0, 0},
> + .reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
> + .spkid_gpio_idx = {1, 1},

As I could see you have written an incorrect fixup entry when compared 
with the ACPI patch you provided:

1. For the .reset_gpio_idx field, from your ACPI patch:
>  Package () { "reset-gpios", Package () {
>      SPK1, One, Zero, Zero,
>      SPK1, One, Zero, Zero
>  } },
for your machine, the index of the reset GpioIo resource is 1, which 
means the correct form would be .reset_gpio_idx = {1, 1}. You could 
find this index by looking for the GpioIo resource descriptor that has 
a "IoRestrictionOutputOnly" IORestriction argument in your ACPI 
CSC3551 _CRS method, and I suppose this reset gpio should has the only 
GpioIo descriptor with this "IoRestrictionOutputOnly" argument. 
Besides, having taking this into consideration, the error you get is
probably due to a incorrect reset.

2. For the value of .reset_gpio_flags, it needs more or less some 
guessing: it's common for chips to have their reset to be pin active 
low and this polarity can also be checked by reading the gpio resource
buffer with kernel acpica infrastructures. Anyway, I think for most 
cases, .reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW} is good.

3. For the value of .spkid_gpio_idx, by investigating the CSC3551 
ACPI _CRS method and the driver code, my shallow thought is that it 
has 3 pins, with one being the reset pin which we have dealt with, 
one being the interrupt pin, which usually is declared with "GpioInt"
if the pin is connected to PCH GPIO and is considered to be one of 
the cs35l41's configurable GPIO, and another one configurable GPIO 
whose function is usually assigned with "VSPK_SWITCH". For the 
spkid to be honest I still have not figured out how it was designed.
I suspect that the spkid gpio is acually a reused funcion of one 
of the three gpios I mentioned. From the driver implementation, 
the .spkid_gpio_idx field should be the index of the GpioIo
resource descriptor in the _CRS returned buffer. However also from
the implementation of the driver, whether this field is configured
correctly should not be the major factor affecting if the speakers
would work, it only affects the selection of the cs35l41 firmware.
Anyway, from your working ACPI patch:

>  Package () { "spk-id-gpios", Package () {
>      SPK1, 0x02, Zero, Zero,
>      SPK1, 0x02, Zero, Zero
>  } },

you may try setting .spkid_gpio_idx = {2, 2}. If that still does
not work you could try setting .spkid_gpio_idx = {-1, -1}, and this 
would make the driver try to find the "spk-id-gpios" package from
the ACPI table. (however even though you did not provide this by
patching the ACPI table and it fails to get it, the driver still
should not fail.)

Please try to modify the fixup entry as the advice above to see if
it works. If still not, feel free to futher reply me, and I think
it would be very beneficial for me to help solving your problem 
if you could post your orignial CSC3551 ACPI table.
