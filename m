Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E718786B21
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjHXJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbjHXJHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:07:08 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2082.outbound.protection.outlook.com [40.92.58.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404D51995
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AspGD3QaqKUagsXRekrrSlpZn07FCjJkhBrlLjC21/uDlWSzjE3UjUTRqnH1UWhWJWjsTa50oSm7q4TLEYtZWGsH4Nxx0qBYARAI0vXK/ku7tSvt/0suvxTzeW0iq23E62gWRZgSY98vDZDuxvVvGprXKMmW3+LIxU58NdGrkvytew/U5akx2IQ4LVY2X+AiRmFHoRsZyJoSbUTYK4geecUtvf03CH7pE9mIXPFN86TumfvhCKaDp21eL+qFVCb2sO8RxskQHRWo8ijI6l0heqvRqMWiOQuiWxzY1aTFrtZP7MlCgWiEf99vYLq1m4Bqmu9Ygbu1iecVjVQOBGG5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPNuaUBUdBLObYjva9aJgAROhzwVFdSxMbQKuDuSVok=;
 b=m3n506tAeHuf+OjjbbdM604pQn0IqHwpw7XlN4wZSsG1v31h/fAWx94gHI+iMBtvw3Xgn40mXoHgS1FD27/a3VMGbCtiRAYTNVDICj/jNIMnfQfWR8tUXSH3+6h0RImlpxxCZdFMNMU75WjEf0nKsFla1La0944S3BD0sJXQp7tSYlw3Fk6XQN+maGV5A4o85nKoR/Tu295XdZKb/YQ6gD+jv4tDald64AyXtCw8Yvd+t0Q6F76+yQTzmeMWPcmh3uow6AGHpA86Zn2UEwHT9lbdBWIGayaZxForgXPCMo2vtlxi00pQTPyGlgEb+F5TdFdN29sbytS35CvvugmR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPNuaUBUdBLObYjva9aJgAROhzwVFdSxMbQKuDuSVok=;
 b=k85OeBhGXikwsldRWvXgr05pMvNCebTW5vvPhL97+D57tvyejB6lQiKRBmAN/gJ7NPU4avNxNNeHZkzXppKpqz2oVW4MmefVeplnBo9gQJuUDWl6m5pHMP6JqKIqN7pfB2exSH0+i2dX5/mwlOkrjaf/xayDVSJaxpFXtO4oXUIZRPp5hN7g2MfebEbT915KfbMhbdW+5Ns5dpm35s9hGoYhEgprCs6OyYatUJzW02yaXpNeO4TzsHuR+oMjKOKqCW+mDHFWYzgwGCGn+zhGWKXXsgLeLH0wCZWOhl9Q5mtDiTJpeeX6YyuN/HcP8FKRq/5GeowgPU5FLOYHfwdcxQ==
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:323::12)
 by VE1P192MB0799.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 09:06:58 +0000
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::1293:a49d:9b32:afc4]) by PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::1293:a49d:9b32:afc4%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 09:06:58 +0000
From:   =?iso-8859-1?Q?Ywe_C=E6rlyn?= <ywec4rlyn@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Bit X low jitter kernel config/fair pay philosphy ideas, updates,
 corrections
Thread-Topic: Bit X low jitter kernel config/fair pay philosphy ideas,
 updates, corrections
Thread-Index: AQHZ1maKKufEruhIvk273lrveZR8Oq/5JnDi
Date:   Thu, 24 Aug 2023 09:06:58 +0000
Message-ID: <PAVP192MB2135E0C71E5896C3F042DE30E91DA@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
References: <DU0P192MB212276A380B4ED0F29C72229E91DA@DU0P192MB2122.EURP192.PROD.OUTLOOK.COM>
In-Reply-To: <DU0P192MB212276A380B4ED0F29C72229E91DA@DU0P192MB2122.EURP192.PROD.OUTLOOK.COM>
Accept-Language: nb-NO, en-US
Content-Language: nb-NO
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [1RxVJMN7f249DUFuRti7joXkjdzMPVFs]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVP192MB2135:EE_|VE1P192MB0799:EE_
x-ms-office365-filtering-correlation-id: 0a5ed964-6132-4328-a63d-08dba481787d
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnjIM6tH8ACgQPqIvtoRaO70eKYzPol7jQNwjGZ/XzVq0matuNjnniEj905dXre0KPkv4W7c7OqAaQSsJimQZHuxgD0NltoI9uyp9CZEb0CZS985H9BBPJyF4wlFTlFRMsedsCUH6TfxwCKZlhUEKJq8oTk5YrAyEuEHkdGQLiwMkzHGbcsnS+c+YInjygUh6nmf9Mz5ZavWgrsy+MdNRjCztBbs+84Sq/fCIKcJA3Nzvy30piQsIU+WTO5pGwEIIgqQdc4Z1VVsYtm+iffAz1vsfO6UxjmrCCfOMmUS2xXrqPoodyJLgS/MIKDuWqCapT6c8FyPZJqLPgp+Am9cYcivgVxDPm75fdo5jZpUX44K3JZ/KZBGj8wl5qyv7jYcvPkA0mjopxaQlbN3HyVCu8axa+WCU7QrJb2gFL3BLNsrlyRgG3AmrzeRHB7/8UbDCiYYHnfxXwowPPo59tW5WG3jSQPfx6aTRohE9iRhwFYyvP6y0Vrff4+CARtEc/4lYAFFEhNJjOO+O2+HFdmAULSCA3IIEjZLoA3ygYyC+ODFq92FcsR0iME/s1/GpBnn
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hNhYvCcH/WWI/JNIHm7LqRBOAs6u4GN3xG1rC/h0mFxTY0lbhKY8MVgDal?=
 =?iso-8859-1?Q?0sbDIpzMFRuHocw1q5xlJQTfRUWQ+CyxQxiFdOgv4ygiaXEtXpp6nsRFIJ?=
 =?iso-8859-1?Q?DYBAm4rlEcLrHN4ARQq+18mNaYuD7SI+P/D3oE/0l/CWGqB6uJNOHIEGyV?=
 =?iso-8859-1?Q?p9LJ/9swehD+mEJkXF7WxIUOeo4R0qc8ITTH9KXNJW8270VV8nLQhnEbZ8?=
 =?iso-8859-1?Q?1wilGuELe+dLYO9tZvgqDhDTDOeqnLPzQLkK7RvIKpCl70PG0BJ3KM2ys1?=
 =?iso-8859-1?Q?02iSwETexiOvxP74eaO7r0qL500BVe1tGn0S6tW19NnD/opjDb6+n3h13e?=
 =?iso-8859-1?Q?HegOcrohactE8+WNeTiYumBfxSPlL2oZpKOvD6QZiVsljAgGt7bmKUwZS6?=
 =?iso-8859-1?Q?u4nQS7jULCWwC4jHYQKrOMYbvAZdPaSYm7jHSk2OOa8ZttYOCkVGU19R5Y?=
 =?iso-8859-1?Q?gCkdHvCGaAcX5V3d/u5B9hYPhui7EfkaaDxe3sSZ/qnH/zhl+JUsqV2Iiv?=
 =?iso-8859-1?Q?JTu+qO/0OEGNzJ1KbU5QVERdnAznWGCH9wu8SdzDxbxgIyGD9UyAIpmJv8?=
 =?iso-8859-1?Q?Pn+LsY1unqpZMa7sC4i1Jk+WV1K+othP5iSXx7ZeuTU05s/G+QqE1IuJFg?=
 =?iso-8859-1?Q?QzhQtXvBs6y6I5nfnA1ZRt9nGU6q/93QXwiI0hX0Uczv20rrEwDSDOMLbs?=
 =?iso-8859-1?Q?/jA17Ry5wuoE+nOveY/NB0CLkrMku3PLLWlIVq7ddX55R1xrXSLrIkTJdD?=
 =?iso-8859-1?Q?KJ1J/rJozEgFw6TAk3jkA1cHz04ny9rOthcAP05ji6w/SRTWdoSiwuPK1T?=
 =?iso-8859-1?Q?3qaRbXS/Os+Bbr9y4r1AYky5n9sY9BMJrv6sTWyJJJxN/MenjEHYVH9pc4?=
 =?iso-8859-1?Q?Dy23hW8OaGoBbkuZ1Bv+Vu1GDIsSh9pgM9HfxhGQcFUgM7V2/HKop0QjV5?=
 =?iso-8859-1?Q?Vor8sVSFsQuXHC3z1WsscbCg4B0F3N9YQPnIgZ6aUWIIXsWqawYgfqTqL5?=
 =?iso-8859-1?Q?dk6J6gsSjU2tJ3uNqJn3W4WzAafY8ej90J3Wh/TBhkb8Th+speAOpHi4ri?=
 =?iso-8859-1?Q?98jXocHA2VcPJZiRxjAIXzhhUDlM8BQYks8W48NXgSgZ67RMn+PIQIrPUG?=
 =?iso-8859-1?Q?Esfy+gljDV3vRVQu3a3tXpJpEvZkmysnGMrs6swrzv3+F0La9dravCHP6a?=
 =?iso-8859-1?Q?ZVoox6opapHA4zct4z4cOb5dDc+8gJj3KESi0VMbitPpezRLjEWtSDzr+7?=
 =?iso-8859-1?Q?9W+e52OCv78GB05B1I6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5ed964-6132-4328-a63d-08dba481787d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 09:06:58.2079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0799
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
Hello.=0A=
=0A=
I wrote the list about some of my ideas. Some of the stuff may be a bit ear=
ly posted, so sorry about that. Its mature now.=0A=
=0A=
The low latency config I did worked very well. It gave excellent performanc=
e on Doom 3, many years ago. Phoronix benchmarked it in 2012, and unfortuna=
tely he did not have the tools to benchmark framesmoothness and actual fram=
es drawn on screen, so it only showed good figures in=A0PostgreSQL tests. W=
hat I saw myself though, was that all jitter was gone, from this demanding =
3-passes pr. frame OpenGL game, and full 72.7 (low psychovisual noise refre=
sh rate) hz updates. (This required renicing X aswell, and a kernel timer o=
f 90hz at the time).=0A=
=0A=
I also tried 0.33ms latency audio streams. It was CPU demanding then, but t=
hose codepaths could be optimized.=0A=
=0A=
And in these days, I guess things are perfected with the EEVDF scheduler.=
=0A=
I remember 200uS OS-Jitter being close to optimal for desktop use.=0A=
=0A=
I would call it the Bit X Low Jitter Kernel Config, and if an OS was based =
on it, it would be Bit X. Everything is about streams now, and it would sui=
t such a thing perfectly.=0A=
=0A=
Ofcourse as things like Bitcoin grows aswell, one would want a good fair pa=
y background. And I have advocated non-sectarian Islam for this. As a regre=
ssed Bible, and retrofitted regressed concepts of the Deity are unsuitable.=
=0A=
Now using Ra, as the translated concept of the arabic Deity, which works we=
ll in latin alphabet, to my experience.=0A=
=0A=
The problem for Islam is that sects have taken an idol, a halfmoon symbol, =
and this is a wellknown symbol. And sectarians emphasise books like Bukhari=
, that are pseudoteachings only. This I want to state, that this is not wha=
t I mean by "Islam". But rather something like the "Kuran Alone" directions=
.=0A=
=0A=
A little update from me.=0A=
Peace.=0A=
Ywe.=0A=
