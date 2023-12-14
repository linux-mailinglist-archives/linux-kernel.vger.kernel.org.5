Return-Path: <linux-kernel+bounces-168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03193813CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854651F2288C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F009E671F7;
	Thu, 14 Dec 2023 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="aRr8Ci2X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2093.outbound.protection.outlook.com [40.107.114.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DEE671EA;
	Thu, 14 Dec 2023 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WL/itNtyzS8J3jyopofFi8czneAOaaNkQzvjTdDcacKVHe9YWea0HPWmJqKIPb51Fw5Qz8mWt6fxax9ZTZ5IHIE/whhmAqgPPG3mL6YSKDHEe/OOM3PuArXBhaLFKRj4vHfn+L3E7NFX8Qaac6GCn2w4a0inWbpUUa9Noqqlqs1uDH04hDA2vEE5Rqk+j5RVAbuf8vGRgkmsGBmelFg2SuLKe1QCPASNxIkimssj38wI4aGGyWUgsf0a4MjyntN062EDnZG9H2s1K3BZuGZvZWXyXpG0bhanK7uuzsQANDZiRvwKR3XeT5rtq1kgNv8K37ofLg6DfryIM570awLZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt0ySPLuv7x+NarhIiBaBnHTEMAPOWrx+zYWGximUNQ=;
 b=fsnuO2koOTHuTKaJEAZu8zvw6YWTMThjFtu3kfWCSU5DzRaa+4f4ZzbwqgpW0qz4Ue7vz+Igl06GD0I05oetaW8eq9V4v8mRuwC40qjRTjh8/5Ne953KqXHigGBhzAGD+lYQ/M11k0GCcWkCACwJjTp/YjZ4CiaGjvng5ES4JlwDOmLGCS6gxbMJQpkpyOW1SQbb8k526l53jbHelBvSxkVXWLuJWYyXYW06LAzc6R67LpK65vJEqVAduRnpTt5+WEiJrLwKJPud0t0IBPhsKzqO76vQ1TplEN6I3XxHrIKQo3ynAQaQgRDrUSXF+Vq9F0HossL5mS36WZ79HmayOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt0ySPLuv7x+NarhIiBaBnHTEMAPOWrx+zYWGximUNQ=;
 b=aRr8Ci2X7lgHQV5I7hutk19Irg/KXM7rgOiMlr9oITLv/0ElBKXWOzwWcTAsBlRwben0J+PppYbev38NJHz06NEVmraUjNpW5zgoXh+afjzV5Z1BVals1vtIgrwFtqjUfTQjZzY1WKq1tTOfAZnKLp39MIWnKJNsSQx+7wayGfU=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by TYAPR01MB5641.jpnprd01.prod.outlook.com (2603:1096:404:8054::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.10; Thu, 14 Dec
 2023 21:59:32 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::15f6:e7cb:d89d:7926]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::15f6:e7cb:d89d:7926%4]) with mapi id 15.20.7113.010; Thu, 14 Dec 2023
 21:59:32 +0000
From: Min Li <min.li.xe@renesas.com>
To: Richard Cochran <richardcochran@gmail.com>, Min Li <lnimi@hotmail.com>
CC: "lee@kernel.org" <lee@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for
 the measured external offset
Thread-Topic: [PATCH net-next v3 1/2] ptp: introduce PTP_CLOCK_EXTOFF event
 for the measured external offset
Thread-Index: AQHaLqu4zF/H/JuJMUiXzZhTdhcRD7CpHDoAgAA3tjA=
Date: Thu, 14 Dec 2023 21:59:32 +0000
Message-ID:
 <OS3PR01MB65938570774AF540C6BFD8F5BA8CA@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References:
 <PH7PR03MB706431C1C25954AD76134FD8A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
 <ZXtLvOfS0uYxESQm@hoboy.vegasvil.org>
In-Reply-To: <ZXtLvOfS0uYxESQm@hoboy.vegasvil.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|TYAPR01MB5641:EE_
x-ms-office365-filtering-correlation-id: 54d45d4f-1ccd-4208-fe6d-08dbfceff3de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DKbJHAstfV4OxWafiHU52YjLsMuS9KlX5s2Mr0hf8oHK3+ghznvFefhqQCZOGouMhcxTxhMCvf2w0ZDmQQqOw/hWWPsqzrrvH7/nM9SZMex1wsaUUdgfs1wF+ClCKj3KI51Wsswcx5psLOIZt/gwxY1kzM9dtfLZQkP/eCITJjD56/pUP9p8Fdi6TUiwg7/diSGKopEB5bOyfPqrkt/5JuglzmSjj+BXhVLTsg7prNw/UipzKERwEASkHcfu5amXLUgqF2qtqYmBUUTX4xAjlg9+xaScUkoNT5G9lUXphGUTklqFY+3KpVPZBsQh32jn3PDx34S92ocPGosNi7HOi0YQCQZc/8Ar7RGDBQkzA3wWfSaXP3ArKOe/JwS3ZtkbmZzzZ8D4Vw+VUKDkFVYHQcx1FZAk7T+LmwtEPULUHxXQTfiSTWVbKDwjxqCfvXXH0f1kffkjf0eNxaBuescI6i+dF4RM+Rb7bJeb5CM3A5WBL6dY0xcqnuNtsvtIrRVcgvx47WRm9Qul5D+zyezyC1+2TiExvS5FrPJ6eP0MHabp42nwZx4Fs8b5+F5z/ge8jIwx9G5YSp7+HL+VLNowjRJcWCYugkaZuKHZpjuT3p/rTkSwDPRCccb5cjCWcO/B
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(26005)(7696005)(6506007)(33656002)(38070700009)(86362001)(38100700002)(122000001)(83380400001)(4326008)(52536014)(5660300002)(55236004)(9686003)(71200400001)(76116006)(110136005)(316002)(66946007)(8676002)(8936002)(66556008)(66476007)(66446008)(64756008)(54906003)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xgiIqZsuWo6Cb1XmH3wH2ljgzuoJ28ynznnYxiAiZWkLydOwIaCcNgId4aGC?=
 =?us-ascii?Q?p/1M5vIFO/GJsIF7vnDasIAEktC7N3g/WJ5ojpsQiKg1OV+ZG7uSFBUsI0ZG?=
 =?us-ascii?Q?rHEw+oTyEAi6dQcPSwhxtj+YPoeNh8b8N5e5spH3oUEYccLlO+KdAecDvL6N?=
 =?us-ascii?Q?aTURdG4/7kUCz/UFJK1Mvq7RbBNqnpbW4z/qYo70bHw7orGZeefOtWgzQnzR?=
 =?us-ascii?Q?M3x94CyHHELeZ+yENeqmUuQuEjEVWmAD3iMgZ0mhyHJJ/vmHtY1/B1VEF3NX?=
 =?us-ascii?Q?ddKN1jSbFzeu8BxqPeK8IEVH8a3Up4KcaPOrOJgxfWx9o1mCuuqHTIHngcGl?=
 =?us-ascii?Q?rJFO2UErjLOkOc7ZdfFiixZOHY7PU2WZeWSPvMRC84ww4pBCOoksoZ5HeWTk?=
 =?us-ascii?Q?GYUscjvxzTjoKE1Oj62JrpumSroWohA8/j0VT/ZD+dUs5ie1ks5OUPjcwnRN?=
 =?us-ascii?Q?Ld/jbzm5UlVdUhMTJuUlZs5iUZQ6LwVUDfpkTBVWJc4lgVPk3m6ewT+eO140?=
 =?us-ascii?Q?rz0EQwrmK06Q/5ui6waPRFqZnDRvROmcS6uBngBVVdPrqHqtriOPg2FHkrdZ?=
 =?us-ascii?Q?E2XcnC88aHYExPojy/zaAmUEBiwqvL0l8Aqw5yAZg9hvnM7sq2tdYXExeSD4?=
 =?us-ascii?Q?d5Tpg8u0rL9EnDW0eiYq/pqStUoBog17xPddhQNwihGL/brD6Wpg/oEeJQBV?=
 =?us-ascii?Q?n+SRMH4BAF8t4HXUL3Fak0L+hsrsQKDdz+V1QaWrva8mYvH7Tqa7R335/MXB?=
 =?us-ascii?Q?JJgAxnvSva1CEww3nPLc2ESgm9ZtbIelBKMtcw8HDjJAU5ntK/RBM30XICHz?=
 =?us-ascii?Q?WH7vPVt5J2uUIcDVsLPIuhjEnb23yHBEzdvFVOnwvDC5s7+qbcjSXL8SReda?=
 =?us-ascii?Q?ti5n02IFBZGtkPoX6UQJ1KGhU8ZqyJKGx6WGYqNJf7SV2Lcsefvlvz5FMBGb?=
 =?us-ascii?Q?eHf3MelIjkekRdKexYtkvwYDBrmObIaqiyqUFXg2TJBBGRuCxj4PDl8hGtLW?=
 =?us-ascii?Q?39VPWYVPyPZWW5en1tvP0AuDLTllLVLe9hlXZozwi+p0HeJbEhIPff/bHC7Z?=
 =?us-ascii?Q?a/M2cy/3uyOxqSVcT+vu4DGKXFECYhpZ7c0lVvsikGxd9ZWKJgovPVn+vvmk?=
 =?us-ascii?Q?n/I5OaqsDD9es+MxAoqUoqdMj8+KdXNH8i6CwHyZ4DJ1rar0VklDp4Hatp0s?=
 =?us-ascii?Q?tZE4QGlgsSATWTD/VV3roA2bXDPElds2rLGUTpQAwXPM+jiYOAjTNcr94jQn?=
 =?us-ascii?Q?S/neE7OuUnxxB3rWqXzk2rj962zrwjnKokCNFCSt/bI+HiIEsG9ytdl1JZUz?=
 =?us-ascii?Q?rs/W9+kuk7TniBjG1OHv6g0OAb6Tsfhyqx1WQfqY8wIq5cNDz+lG+Aeek0Ku?=
 =?us-ascii?Q?v/JdGTFgkcmxFEl4QxFgYDM2KR88b6mYchKNy0vtKtY/R3WjHEiD/PhXQAGf?=
 =?us-ascii?Q?0vr+vilJr7S0hjlqE2kBQ8iAM0+RaEv5vkteaX1pIT1BegbeGQSxy3qYMRsI?=
 =?us-ascii?Q?qLxCohyidu+6/2JCT2ClsFDjBfsjA9xqnIEEkkt+esysxCGzb1f216ukH0PS?=
 =?us-ascii?Q?SMOIHI60t4mWYZodpMcxsvcBbjchK33qrjQYhM5Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d45d4f-1ccd-4208-fe6d-08dbfceff3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 21:59:32.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OH8Xb+kBMX79ZA1zmFR1vuZuFrjcfTvW/TuDGOj393aZw+ps3pRrMnv/62lBnHH1SNt+2xVgO81ZkzfsnV8Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5641


> On Thu, Dec 14, 2023 at 11:36:24AM -0500, Min Li wrote:
> > diff --git a/include/uapi/linux/ptp_clock.h
> > b/include/uapi/linux/ptp_clock.h index da700999c..66f4dd73a 100644
> > --- a/include/uapi/linux/ptp_clock.h
> > +++ b/include/uapi/linux/ptp_clock.h
> > @@ -32,6 +32,7 @@
> >  #define PTP_RISING_EDGE    (1<<1)
> >  #define PTP_FALLING_EDGE   (1<<2)
> >  #define PTP_STRICT_FLAGS   (1<<3)
> > +#define PTP_EXT_OFFSET     (1<<4)
>=20
> This isn't going to work.
>=20
> If user space enables time stamps twice, once with PTP_EXT_OFFSET and
> once without, it won't be able to differentiate the two when it reads a
> ptp_extts_event.
>=20
> Thanks,
> Richard

Hi Richard
Would it be Ok if I use the flags to differentiate extts events from extoff=
?

 struct ptp_extts_event {
-       struct ptp_clock_time t; /* Time event occured. */
+       union {
+               struct ptp_clock_time t; /* Time event occurred. */
+               __s64 offset_ns;         /* Offset event occurred. */
+       };
         unsigned int index;      /* Which channel produced the event. */
         unsigned int flags;      /* Reserved for future use. */
         unsigned int rsv[2];     /* Reserved for future use. */

