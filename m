Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB80792D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjIESrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjIESrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:47:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2082b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D81BDD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAu7Fq/+Rdp4TVQ0ODtnLu1XRcumniR3qeKlRXoXkiurTu67ir6E5ho7Xgk4dfAYfMVNbGYHEdbM4GcMVK0PTIVrVm0ekibARcYrEI+GSF5gEBLgxW83pllYpsqihgEXgV0mk4Nm0TCpz407kcfMpe57U5LOS8DveqwBIjotBV1t0I0Wk/CERhGwapqdjFdN9uEQgTWTalNfIkla/D1AONobOUso7JKLeNQ7j+x2zpqhfbtcpfORT4ZuTbcdbGPzghf0YJxMy34Sjd/1kJV+ad8HWD8FzVLTEf/JQPJUfpVp1YEKEhbABJ/7U4045guvUYnCIl5AFpr9M9/dY+hP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdHOsL0S+zkNZ9kOW3saA7NoPONhkqojuHIi24VAWxc=;
 b=XwC1tBriUmmulZcKLHc7kpOfrpav3bGnJF5I4ZMM+1pmjA+1XBy91sL/+Bger1r0gdSNCz23r9gtW4+Y4dqbrVWJoUDicRuUtTGoQkpNpDbHUiJIipvi/y/OeKE0BVfms4GRgOKYBXKKcCo2f6B2azQwLZXJVU0HykhDd/s9trrFyC+nPHoYGEyCZEVzqPht/rrmzeoL8ZFQ3TNGrSlzZ/7I8aDu9u9y3Q9rNBs3xzQTzduw6fSQVQ1jGfg2eFI84NDH2dDGlEniOH34/+/jYVa3uea4DKzfrkhAmbsdiYCd8ZcTW+xK2p7CSZFHdhdixkPpadHIs9QiqmAZQgamZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdHOsL0S+zkNZ9kOW3saA7NoPONhkqojuHIi24VAWxc=;
 b=KVE9ohkNA/MtX2kiCOjqSClcfZol0nkvhLDeXPcSBkjwSXIBn7CxXgUK3cMtYuo1VRcGnX+Kex36XS6i31iky6DnK3AkDJJGNRAoY1tdp/Tn/3gK7+JIbivD1MvYs33Ltq1bma/ZtEjQGis5EZLjhv5qyAgLJF/v+qWuUlGOshY9hoU2Kz6Wd24/AQteEcpR+lZCkrlNrJw5R2FROQuIp5GMbuPLtwqUM+n01dzpkIapnYfZ4qY9YUV3zQr8bIvRMOHvMCttFTuR4G8w+obAJerS3g+I5xlu/vnMl+uHG7Jpicm4eE2zvWjt/6OGzQHFbKOIim/BnK3Qxy81Vf3amQ==
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:323::12)
 by PAWP192MB2150.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:358::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:33:19 +0000
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::1293:a49d:9b32:afc4]) by PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::1293:a49d:9b32:afc4%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:33:18 +0000
From:   =?iso-8859-1?Q?Ywe_C=E6rlyn?= <ywec4rlyn@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: c64s S i D is from the Kuran
Thread-Topic: c64s S i D is from the Kuran
Thread-Index: AQHZ4Bn3vmlUcB4H30S+wekg8VjNxLAMhY2a
Date:   Tue, 5 Sep 2023 18:33:18 +0000
Message-ID: <f32f79588a6442d38c63ded9cefeb43cPAVP192MB2135455CB9DDAAE3E1B52716E9E8A@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
References: <PAVP192MB21353F8A49235D2B9D535457E9E8A@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
In-Reply-To: <PAVP192MB21353F8A49235D2B9D535457E9E8A@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
Accept-Language: nb-NO, en-US
Content-Language: nb-NO
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [AmMZfKwwIFoAZQJk89X2recGfYIjKQRw]
x-ms-traffictypediagnostic: PAVP192MB2135:EE_|PAWP192MB2150:EE_
x-ms-office365-filtering-correlation-id: 53ae97b7-fe03-4489-be4d-08dbae3e9378
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8aww/w5RHQBqtOGxw/xikV5I/lsL9MgRj8VWtSoDN6742lDyAUqsSUDKcNlDPlN6O1VcGQK7JBWTFI+Lp13GH+s//Zo2V06OiHrEBExAbhtwxBUfChvwLo69YtxofnWeDEtAuT1hOx9y4VFWSgsFY4VLvoKaqLyspuJ09wlbLR/U8dOmtcNuDv3oyjJRN9UzSgTjo+5poKRv7icF9k08dGGSEEggN9YvwAtU1wAq8nuCAiixE226G/uT++uSJEYFK9UYEFWpm6B/6kczbLGsQxr3P4qc8Bkh/wcLOL2Dql1e4eXtPIvuXY3eLcWg2lTHhMwG64l7WOH8vUeBbGX3TovUIAAeIWw2LnnsFRJKyuotQIgRn/tUCDSYHjd1XJ3ekmn3K4YCSyakvJ9XPWHRwRA9virv1dOJ4lTo11jToyOUmQq4yxTtQy94yqqvqgEouv9Pcr5YtVoITItigYc0T5F0cQYIr+2uL1Ngbvc5t5tYWWydE87dhylxpR1d9RZgxw8nqtw7QNYO122xWWaO5PRTEpcx7dhKR2CGRStLE5vGwpFV8ypRaOEndnbVYBIC
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lN5wUKokRW9LlH2GxY7VgE0yO0PtWHhYbFj0Gma0MkaEYsTA/3xUOW4dXX?=
 =?iso-8859-1?Q?kEv6MgqbKAu0YXHg9SGHsBOCLDKvfVU6Q6DUti7aZhucyhdxrgoGe1SRHk?=
 =?iso-8859-1?Q?fZ0s54BAWKmAwGKDu8kjCjUqNcUFMBG7fjb8Zbo4S5uhX35cTMrA/CJAu/?=
 =?iso-8859-1?Q?slGH7RDLE6ww8z9sSskES8M9W+zgUkGTaG5AnYZrgP+TgDI98Vxna6Xbxy?=
 =?iso-8859-1?Q?yw+TeFw65B4flQcK2Kf97/unsB7/abJutgDwNxIdRkphw7ghDfAWiTmMfv?=
 =?iso-8859-1?Q?xS8rC+YBFEVvvKSdbRTuzCFgT0KDzjHtsTfi8XmlCsaZ39KtmNSxSiBDML?=
 =?iso-8859-1?Q?K/7W8ICmeybankCwXPpVviJXa3lVH3TiUpsxyLPsKeBIkthH7gRM+DaGXb?=
 =?iso-8859-1?Q?P72cbbUWFIYoL8VNNn8qG/VtMgXGJHwhw2lnK+5vL6pdqItJZWxeJTMlcE?=
 =?iso-8859-1?Q?05ePJTYx0Xuk1pWLkXKpgQw9Fmqcc2VOSQQ/affRG9wlSnRi7cj8Dss9+Z?=
 =?iso-8859-1?Q?TNJJqCU5bq+G/ySEOHOussnQNn3h5y0JzKh9eqV6w9Rvzaon6a5gCW/ZL7?=
 =?iso-8859-1?Q?8mm6PC66a2VOp6l2ZhviZUr/YtZsfqEPZWrhgaM8uv1Ro8t1cn0hhZTy9e?=
 =?iso-8859-1?Q?aADXEr11MPzJKRsVukPvj55lQgzdquUVDXlF8V2/xHo4Z9uV0K/d5gujlJ?=
 =?iso-8859-1?Q?dqM8Xo9k9ErSsQb57xQYmludZVVgvoYmtXzWys10S63D8poJsVVRHxubJS?=
 =?iso-8859-1?Q?Nt8zCthbazBwimqBBLfavfnCv3mW1sxY9JikDD8QP6HscY+SYzSTMTEu0D?=
 =?iso-8859-1?Q?FSiNcaBzTapyuTTxDAn5wRTesHuGT9spHHjvGWq78fbyvPFEwQoLIGXS6E?=
 =?iso-8859-1?Q?wfwMYoJvAfwWfD41iiiEUlyRe8H+LcARyWszN4INjjjCCLBZ5+dkbcJ5wp?=
 =?iso-8859-1?Q?r77R0myhZlPn/eAhmrv9h9mSBk2zkbxeDDAXhW7+9dQFldNNSDlHcuEPnf?=
 =?iso-8859-1?Q?HVFPWmZjyJ6Ragc+EGX0uFfuGnLUFWjmbTtUTssz64sa2RiKqIWcMWFfrF?=
 =?iso-8859-1?Q?wca8+ciqsVZyqiwqE25WdWAg98nbirnRXZtt3Il4E1gYZx2DuGxh79x6rM?=
 =?iso-8859-1?Q?l9+ylwGsuwOpUoYSa6UKY8lWyoCpbJHRNZztKIAAPctYYol+JJFfqDBoMj?=
 =?iso-8859-1?Q?mMArePIkVHIDQJr1Cvze7Jty9hzQ5d0hB/d7owoVS1Q6UQpqiZeh8DsQKg?=
 =?iso-8859-1?Q?Jainyr7dxRcWPUZLHUIA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0D2BB5C50BE52C469909EA736D87D2B1@EURP192.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ae97b7-fe03-4489-be4d-08dbae3e9378
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 18:33:18.7908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP192MB2150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Or why not try and combine electronics SIN, and homecomputers S i D, into T=
aSIN? (updated post).=0A=
=0A=
And maybe 8 X? 8 representing TaSIN?=0A=
=0A=
I think I will refocus and try this a bit.  Bit-8.net coming.=0A=
=0A=
Peace.=0A=
