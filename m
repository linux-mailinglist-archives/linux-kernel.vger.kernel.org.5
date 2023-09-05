Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD3792D28
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjIESML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240165AbjIESMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:12:01 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn080c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::80c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9557A524
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYAgNeKwiIZiNWYpwMPx6PZQCV3BlQ7zTv6UTqYOw7PDn+d4PGFcvRuwr9dhfNsBg/y2M6oEMcAyVdSpCyFjwD2DKUDf+gMjtB+8w2txomUREt5uKf3Cc0bb98CgKJRpsf//FZ5XN8YZwHCl+TR80G+fETwFBU1hKg1jNSBNMY+LNJc/FfU8vvgtR5f5OdeWG4IQDKERfl0spj9GdA7cb2U9z/ioTjq9Fw8UiwyRH156OZ94joEA1SirH5LmcBN20MjPN+X9kBFAydOFulcaejYKx25V5yEcxMwyKtytU97jwxjg8blv4VhaNEkZ50mP7Xxv2beCWYAKI6zVLpUVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSREbZBMozpnad022viuYZtOUV9RqgCIi7ykp2XXUGo=;
 b=IG3Snyw7RJbvNIgRhFY4uttvKqP/bWOLjB1okhgURloxqPJ+Mn/6hFoDuQTzYY8Vt0pV98rHztYFUXAUODidmwrswTukIDuGqz88+gKGpjXc5hDLbPUu3o+Z6uVwe3qzdh1sHhx59LipyUPOgl6PFDZdHdSLKcDiJJoCh5xsrB5HTCNBQIVRLYbfyHYCGLmbN2MrGTiPNddeLZJBISoWVCmg4C7AJ09yn6eFTVdoGdIKtbem27WPrRuY+sqf4Fn1+aBg5p/aV1ZSF0SSNKp6nFVkJ3xWUS0siflYvSg2XrJzMZzXCRWknwy77B7Ygbrl+Vz5rRyDytKGw27LunBPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSREbZBMozpnad022viuYZtOUV9RqgCIi7ykp2XXUGo=;
 b=duNcXEX15Yy4py7n9/nRLlVd7s36pBaQVee2iN9upxX1PR7THL7Pgo6RlhNGoPLJHad/xV8XYwZ5MsnAeojejZ/uW7r3uwk8er5j+29PHibFsZHLafkejdsF6dCX467TTMhtQVGVuFRIcNN4JSdsn3chYO3ATxDwfkpHyf8y83kKdMvUFQ46TsTXtPoLD61tLozpYuw+pyfVi/TQvxAuF2mH21yBxuyT3n6Woxqs/3pTy0iVCzcZ2xuuLEy7+OU1ZjILkYRK3Pj87RyVc1b87nbUzCEQ6pS85273kXxoTBfP87JgvoKvEnjywSDw62uDxPGBgs95lr+ZSrxEPe7T0g==
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:323::12)
 by AS4P192MB1574.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:4b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 17:01:22 +0000
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::1293:a49d:9b32:afc4]) by PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::1293:a49d:9b32:afc4%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 17:01:22 +0000
From:   =?iso-8859-1?Q?Ywe_C=E6rlyn?= <ywec4rlyn@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: c64s S i D is from the Kuran
Thread-Topic: c64s S i D is from the Kuran
Thread-Index: AQHZ4Bn3vmlUcB4H30S+wekg8VjNxA==
Date:   Tue, 5 Sep 2023 17:01:22 +0000
Message-ID: <PAVP192MB21353F8A49235D2B9D535457E9E8A@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
Accept-Language: nb-NO, en-US
Content-Language: nb-NO
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [ky+D4A7+GpMdou1V4eWe8bNqs2c+EZnL]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVP192MB2135:EE_|AS4P192MB1574:EE_
x-ms-office365-filtering-correlation-id: f9dc2da5-bb12-40f8-2da0-08dbae31bbaa
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HamEKZaKQotF047GkOz+G5qAm/H0OeNyE67nfrtL42uqZhtof4KsmUBZNCn9PCI3qAusuhit9fbHQMQPTUtKofOCKj+2kei6WG3dYAy3PwL6H9hK22r+GXTse63T8n5bb9FQ/BFqV4QOQHzHyEptCdWiTqWzJc6OEnBzvMdx7m5EJKK0I5E/jbHEKrNyLdyJDiwTqY8uYNOQlTtU9PyviMDiNShFAM0suvsHCaBwhux7m+4cOYrIncJfREFm1Ize6lztyd1g4kZKgT4KvpCJAvWoC23Q0FhaYT+Hrc9SOQYRFJV0jJiTW2Kk2XZJNIMeWc+qwI60sQPlNia7D18ob8PPJhVUBe/DDEyiQUqy7p0+1BbtUjc255T1Pj7xZwZQy4h3iYB3PVF7ZvEbZB9FVRnhqbergFAYBp4uCApirBd5K5g5oZHD/uz+Mf0BHhhhkZ/6yburggvS2Y8YteB54u8xBFOKg4cB1V2EqV62xAE6sO2awAcgPEB7GJ39seXKVUcSepFU3bqIC9osidXAiCAj9SM/W7qUxxaIXpaPdkY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D5lPVWy+LaaGegoQik8OSyYJICZdWWkrQm68GhwqyBCadLRtqMee699teP?=
 =?iso-8859-1?Q?ud7sBXad+a4aHz9WQyY3uhl8hfJlkuj/akT+QZhBc12Z2s6y9N2TnaoE8B?=
 =?iso-8859-1?Q?f9wHe7BMDX1eKg4u20CgVnAiH89t2Xtuo+qf20XNT94Xo35HrfC2i8rVso?=
 =?iso-8859-1?Q?2W9etcWPbgrh34e+B8HOzeN3euIaET/6WmKH+GGZ+9AZVyITsJ9hqUAwpb?=
 =?iso-8859-1?Q?9HmRHzTYeV3fQSV2ofwtmnFnbiLOW//mgewXnbCuWTmujPIAjHcWh7/iWT?=
 =?iso-8859-1?Q?97LyDmWHtMgbut4+yrviM2L6blKfzWXZPIW/idTwSii9ZYy/ZwSIBY9LI2?=
 =?iso-8859-1?Q?jBugkBuX0ExjJsfUqZTqtoo5ogK76msA4qtA31uGoIn3aGEq14vKmEqpTF?=
 =?iso-8859-1?Q?uab1452Opr8eDC2OD+uCGxqWPJD7von3oVnIYTsg7rIvKU6jamrPnYPnBC?=
 =?iso-8859-1?Q?jOIJ10LYn+8hpo1ZWeOw28D03nq65k59E6CqBcgWu3bJGPC0w0d1SFFdXG?=
 =?iso-8859-1?Q?C0aiztNd0xL7RojO9BJTpa/uGV/tZ2BXPROAC+7jf9KORp6kweCEKXolVw?=
 =?iso-8859-1?Q?dhLjW/ZVMXql/gB9nuM6nwt2MaiHWchyO9PaOBzGyEQHKWGb88JRuj7lO8?=
 =?iso-8859-1?Q?ODKD0V0dx52Vn419BYbMrGETsF0YKKirTyRxkI0T1X5/Gyf7l2o7bt93ZF?=
 =?iso-8859-1?Q?h2gywCJkQCUzlRSD27XHFxHQldtO5R7l/Loago6LLKGG4GcMvTwe/Mo/0/?=
 =?iso-8859-1?Q?/Se1M93eA9bdb5XgIFT6fQezdhRc2I7d5+GxVWLoIIEUxEOKNn+QwgV4yW?=
 =?iso-8859-1?Q?K1y80MPwYD9GhBdmADZ+qVoZMfnWd07dX9EI+jEYZbRpEOuf9RUPONvPT9?=
 =?iso-8859-1?Q?mqxYUof6veRI+sncY6K4KvUbarvoCzhnZoEHiXhyvesNrOS/4JQwnQ4cw2?=
 =?iso-8859-1?Q?77Jao+curCIKSzN0mHxHrGgAEOCTeuoBzVa+Etw2P3D2zGZR+HI19fvXYa?=
 =?iso-8859-1?Q?6I788hyykxOuXOEsIdiFl6X9qAo7x/3d448Y2zsV0/b8nn0kVh0Z2iWAA4?=
 =?iso-8859-1?Q?S3aBYZqRbvQUI+wMirMYakr6bZcuJUW8TXdfr/FGQA/Syfyh2jUV1kN1mP?=
 =?iso-8859-1?Q?KEnif3R+CFtcRPBneQ/LQdJncOJxr8/JH+TAWaO3SLZIAfLKQGd4AL9HFz?=
 =?iso-8859-1?Q?MTlarFqmOV/OIp/YwH59ET1RKdlIooIGOcL+0q7uFo7LJWVd86+ZGZFtMA?=
 =?iso-8859-1?Q?1OosJDsy3ltLHUdh2Obw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dc2da5-bb12-40f8-2da0-08dbae31bbaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 17:01:22.7565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P192MB1574
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many have wondered what the retrothing with c64 is about, and The Amiga, th=
at also was about other homecomputers of the time.=0A=
=0A=
It seems it is S i D (difficult to latinize), a variant concept of The Deit=
y, from The Kuran. On the Amiga aswell, represented with a rainbow symbol.=
=0A=
=0A=
I have wondered myself what was the special thing about these computers, an=
d now I think I have found it.=0A=
=0A=
For enthusiasts, maybe a 6 X would be interesting? (6 representing S i D)=
=0A=
=0A=
Read also my blog post about the quranic initials. The electronic industry =
uses SIN for schematics aswell.=0A=
=0A=
https://qlahacc.net/2023/09/01/correct-deity-keywords-and-spellings/=0A=
=0A=
Peace,=0A=
Ywe.=0A=
