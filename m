Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CE0792E13
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbjIETAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbjIETAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:00:00 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn0803.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::803])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE228CDB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:59:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcS6EfXmxYzfZdSs+yjj484IdkHgWzmTEr7ltsHDId636WieI4wWUXlk1ojI9QGjCLY/EObKpspMO2Iu7UfZg8K2U73ccMJDf2AXHFpjeYjyVlNQR4xItujkzqhPzgkpMHAuUusiGif9Cy8Pw25ErX8UYZzxxXw8m9qfpWddx67TnBZ7fUEcSy345fZPaLWQ/e9Mtq+NWI9+R1glHpdRgFmmSLQUkyeqVokSVp68awhxHlCwT2Ey05O9RXPDvWOOH263xnwsQCA0t6LcIGTUc66rdORkN/Jd/+tP5AEvbNkxR9h29fSOvK4BINUkJKBUxJB4g9SQM/hw/GDcBBxENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2nJlojxDbO/g6WeLpYr3xQaCYaYvkMVSUxmowO+FzU=;
 b=Efw4jj6L9C90pTg0gvodUJVmxGPVuMatSj6YV8pqpP7thMjlCveO7KZarsU+zSmwCke4ra7XUn0hKDNI6TaZNRtnTbih7T1R4oG1S+rgZVh//2JaWsIXnulmBrW3YuOwsJ5cEultKZB2aL0YJTq4gz83eRHON5FPeW6Y0mPnkzIboPzmcJceLN/v4NCZPGs4xRM5ACdPPxWzGGWvlUzZf56aP+ouSeuedheoGo9WXEEwu3cyzOc129/EJX7LTVAoSu/oJzF6Kb09y7FvF9/R8tzPbsbPsWrkwHNAKhoZfPaSd1XFJ39lC6jUHsr6xS6TLXPM7duPDaSnnjlWH98tig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2nJlojxDbO/g6WeLpYr3xQaCYaYvkMVSUxmowO+FzU=;
 b=J/O6HddLzd3O1HyzoaFFffBdc85S352pKGD77U+bElVS3bjcI3o+FUZbUB4bScKu4IYExV6U+tE9f+DvKIIAXvwVzP7ZQvcEyrF5ZZPiYrwDqDx4lMsji6wgncbYKTF1FOaK19kfqDFToN/u6dl+gWPj7wDTXPA8NuciZ4G/DTfqstX37PZtvVto0ZOnqWqLVt9zvEt+Xy3EhGitrNhdCWlslEkk4TIlfyvLY+cyj6hNdigNEhuvKuqAGKO215RVxw1PNUqy0TG3B5N8cySIZJp0ccIuWlQg/wWxjNhJoy4tTabWwbdX2Cul/GWTU4FT8nUVj5tZQdkIDfUOqf3Zhg==
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:323::12)
 by DB9P192MB1388.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:296::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:58:18 +0000
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::1293:a49d:9b32:afc4]) by PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::1293:a49d:9b32:afc4%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:58:18 +0000
From:   =?iso-8859-1?Q?Ywe_C=E6rlyn?= <ywec4rlyn@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Sv: c64s S i D is from the Kuran
Thread-Topic: c64s S i D is from the Kuran
Thread-Index: AQHZ4Bn3vmlUcB4H30S+wekg8VjNxLAMhY2a
Date:   Tue, 5 Sep 2023 18:58:18 +0000
Message-ID: <226d36c62c7f44d7999aad21ffaece36PAVP192MB2135455CB9DDAAE3E1B52716E9E8A@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
References: <PAVP192MB21353F8A49235D2B9D535457E9E8A@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
In-Reply-To: <PAVP192MB21353F8A49235D2B9D535457E9E8A@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
Accept-Language: nb-NO, en-US
Content-Language: nb-NO
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [uZQRnjPuQ/u0hNh7xItqtcOz1jSQFM4V]
x-ms-traffictypediagnostic: PAVP192MB2135:EE_|DB9P192MB1388:EE_
x-ms-office365-filtering-correlation-id: 55828ee3-5f59-42f7-e6d7-08dbae421158
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NHdXLOqcTCaOC0MjquFg7gNbfaA5/ROO7pWUSBefFTDYMq1PgchOok5hd0OONT0+F9BctsBCvW8RdnzGcoz10W5pYFYq9GzMvaRnDUPWpBpXnqLQKnirQ+wrgWRBlkLn6C02T8i+QCV5rKjRX5mNy+jApiW67FYGrEwudwYiPfDqaiJOCOdwdqKV2nH/SFjskRNnNWHWCm71qTpZ01DbwGP+BsV1SgGlhWJj5KLPZGSsIK40GVIMfbQYWHuN7pNbzvyBlUmAGavpZmi5WsNmxVf3G5HJDYOfm6nvKITTpqXF+G5X5IWHJu0VwE1c/KKOrzN8RVENw5U4kQvssJGZIKys1Av+cJWepYLHW5NmnL321m7ag2kIrTQNpIgUNKwm4LiNRIzl6YVFuglxqabhlwX2/JSgBMAKEfCv+ip9a8KSEnw0DTCV01oY/FNMdx3MvPaWcF/bEqWwsHkL5K/EtG4fP+gr2NS/2QVPYA05i82bjyR7i+pwbEL8C5wpZAMQ0YUBp1DxH8aiZc7Figzmb2BbyPuP2cGMuojhJ8s3ieGU5APqlEjCJwkyd+n3ojYf
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KbvpTDNPFpw6A16x5SgKN70gM70GVP9BHS+USQji5lpRXQvOfXzcH3LItH?=
 =?iso-8859-1?Q?q+TmKg8HNKc6n4yCLneCzrvlspq5gzX39DqQ8XAPUP9h49Lc7wK9/bEOnS?=
 =?iso-8859-1?Q?up7iXQoywKXztsH+lMYLTH1wQ/7irsCyegrxkUYUFYFw5Gj8Y4o1nIxQV0?=
 =?iso-8859-1?Q?0GjCwTFoNeiUVf1ZAdPkcm22KtaOJfjLhplMXK/RU5MZhI68fOspdtz6GK?=
 =?iso-8859-1?Q?MLvW8lyKhS3o/lb5IhYkmKVml6ATcZeuRgIjFojUUEBxD2kFkgEN6zPphx?=
 =?iso-8859-1?Q?c+PRT9YHlDQosjkRGxPWm9bkPEPZlXcxrLxQFq8hwDfswA3F4eCrs2LqGp?=
 =?iso-8859-1?Q?FeNOoCgZm653WLSlz8Nz+zt30K3F7SUt/DCe1l4SYLIotbysW/isON7D0b?=
 =?iso-8859-1?Q?v5R7hmw+QW1vvuKuYEZ0svcXN3io4WoL+K6EwdGOwLlV6NBqEPdyKn6DKN?=
 =?iso-8859-1?Q?Jw9SxCx5B97kYcfR5kAvulsvrnifKt987xSZ8l+MeAdCB/WK+VkCIXo916?=
 =?iso-8859-1?Q?Nz25SJHl1wP1C/duSNQayrF+VrJu73golA5Pr4C6XkB8GkGiX62qGvpGef?=
 =?iso-8859-1?Q?NRt1t0szJoBvEUlhdMjCd0quvK9Uzf3jKzsIdRAWkqpyVwqjfX/aN3h99+?=
 =?iso-8859-1?Q?5w4pt3YEjAWOeWH/8cQBE6ZQuaLPw37B9eL7bmfiv4Ps+Jp9ljN9rtGLD8?=
 =?iso-8859-1?Q?AdRVoUu35Ol+tYhVze+CHeqNnCrElWSYH0qSUCun1FkeHQVZN979PNNogn?=
 =?iso-8859-1?Q?YbJ26Ypr07bQmT/rUWOEUfTkqdW20OL5HrWlJ+eamw3aEeJJ9qZA/i+M5z?=
 =?iso-8859-1?Q?LuxvUxs7YxokzYuTcQPprLWZaUTzicKUGRBtTZp0BnZMS49Wb65xE4D/U5?=
 =?iso-8859-1?Q?tqYa9ollxRQ4BcFJr16Drju6jOXWp/o2gIxin4UvIGXP1BbuywcwEVdvRA?=
 =?iso-8859-1?Q?rpaifMDE1imelyMrv0uVD5UMWZ9ljNBszvnjJWFnBSSnlZRHy4s9ZLqSxi?=
 =?iso-8859-1?Q?m4Np8ffduG4dzu3rV3zcBaTvcx4qz/Hyv8GNH3EA2bBE3rZ3AMCd70MU+X?=
 =?iso-8859-1?Q?HzPDiP+kAj+nXMHkhE6DsyPJ/nbrALxT7HEfFMbR9nJgRo2/b+nqgwXkQF?=
 =?iso-8859-1?Q?rMPw4VzSSifRrdftB3Y7PHx0AwLo7ZzlpiOEP9IlF/ygcUn1qV5efdltt8?=
 =?iso-8859-1?Q?0pyGw144l/XUxUDD6HCkCMCb5AoO2G7BcBSFC2fW/ktXf3C74wKwK4e6Ni?=
 =?iso-8859-1?Q?hHDkpc8t5gfhN5Ekp2sg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0D2BB5C50BE52C469909EA736D87D2B1@EURP192.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 55828ee3-5f59-42f7-e6d7-08dbae421158
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 18:58:18.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1388
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
aSIN? =0A=
=0A=
And maybe 8 X? 8 representing TaSIN?=0A=
=0A=
Refocusing a bit, trying this.  Bit-8.net coming.=0A=
=0A=
Peace.=0A=
=0A=
