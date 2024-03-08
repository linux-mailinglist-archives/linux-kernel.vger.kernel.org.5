Return-Path: <linux-kernel+bounces-96641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05123875F50
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735051F235A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5ED524CB;
	Fri,  8 Mar 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="06Gxd8YT";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uhzvUWlR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36942C1A2;
	Fri,  8 Mar 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886062; cv=fail; b=hNuE3C9Xx40YrwRAEF+CkgXX2w8HB8ywXEUhs3FjXefkCVKpPK/JTs9oe9HAb9uF+3i51LIoYWmtJDkFORzyzOEV3S5ryI3tgA0EO5/HWZWKdarPZzqyLNOW4f5CS5lrTWmtpRXdmlzm7MPPTsXTVJSvAAl7Q4psJrCSy0/ZECk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886062; c=relaxed/simple;
	bh=shGfC6ovW3GcePjyfCjCzBnHpmeQ4X7tqp2yrWBwyNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GhiBF9ylbkF2H+yhcqmjBAOUt8n5ZVbkReiIP3zEt1LNQyxy/azBVTHnS3V7NYmNTC1SLFCYfhh83TPs8PNu+lh52P+ZR7VPdGLEqmjGRt+PerfmIFCre788hlQ43NsEfV7MrypMMVY13/KlcCzZcDYXP8EFKxh8las8RXGC5Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=06Gxd8YT; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uhzvUWlR; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709886060; x=1741422060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=shGfC6ovW3GcePjyfCjCzBnHpmeQ4X7tqp2yrWBwyNg=;
  b=06Gxd8YTuRsQM4ET74QMV22uxxJG4eOQ2/puN2Zqx9c6TGmCbT7UsRgZ
   RSRbG3yOxz1MUSOYaD2/br698TA9RayfTpx5ffnrEYzTrG3b6xAjV9RXE
   48E+Z94z9q1vsjBXKnSXX+yGSpNhMvJjSreYxkXql6Lou1cxx/2iYdKOa
   2xrdCLx/d2XCJr8PaaBo8UCXE46HmvGibzWPJGaWPwpWhz2DLKPjmRxxR
   MYbJNSHadyRryTm9fkAXggoeI3VP94nZMNX7KZCe6ennBIuddfnuBO40M
   Zl05BEXnfKGBNMvddZizJRZinG0h2TXjRQJ157EWfGH3tsM4/2f77yGFk
   g==;
X-CSE-ConnectionGUID: 0/qjvn9kRN6kFqJGeJ/4jw==
X-CSE-MsgGUID: ziq6ayKkTiK1B2fUZF+qQA==
X-IronPort-AV: E=Sophos;i="6.07,108,1708412400"; 
   d="scan'208";a="17928132"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 01:20:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 01:20:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 01:20:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCxYPspsc84Fisic2Z1LvNU3L2JixIaA3cGmk7RtZ+ZINeJsVIc2XQ7mlbG+9CBm+Q5jsj9L+SJtcae64KtVF09AQsagOF59B5DytU+7KzrK+ggKk45dAqY/+53iLcPtCAzAGc/ZgiRgfqXNXmm90hxBXQIDdQ7maukYJdxdNq3zYjHocXIo+abbJu2YkZSQZP5SYAjGQQsOX17fWvA70+HH1iCSljBO89vVmdCFS+2jNvINqsd48NCNN0FCLI3gbVmxlUXZhLbWevMz6ikS9Nt36xRk543cZkImT+OSyvyKR8bzHUwW/KKjo21jm5ra4kOAWx4iFeEd6sKtKZp4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4eCrPoJkBgBnPnz7yTWvWHDqW4NsDsE37ysV8ND4cI=;
 b=mKejoV36LDeGZpwiQTNPEnjlf3M07/Ua+DyVWfOCQ/H8sUN2UU5HfuCti8BY0KSTzZX3v2RubTxUy5ZE+6TK1+Nf1898wOtxgjeQ5MvpsTNCpgX8FqM65ESMKxz68uxOF6u83hMcNhWdYUp6hkXaD0cj2BBi7K0TFSfNT4bzYkr+i0oNdptEdICFRCayPu9aEv99cYo22pQ01TG+1/ZNXFD1OsNNghGrkLa+w+f1O5bFsoqeWQcjGVsGiXK3qFMFGkTx6iqDHm7abZSdCdhYi7WZcJs6ezGz+pQc8u6iOMwxJDmDLXrQB8L5wFFmRy7myeojv/c5wC5zc0lyJsRWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4eCrPoJkBgBnPnz7yTWvWHDqW4NsDsE37ysV8ND4cI=;
 b=uhzvUWlRWpEi7kt+jGKYUGxjwO5QtJl5wjrwMd6qIXEsRaX05He1hVRSGNOdDEGZw5Aif73FYpXDIC5zZ8GnjbJ79XNwe9MkSA3/3H1ZjkjYIkA3ijNu2lloJ45xhBvRHtEnnVl9yyAtNELW1mZEuk2SyfVd9bHt27XpOY/wWOBunQrHymB59nZNEsfwJq9hHzMWS88CbmDv+cK2PHDg/Mrw1vhVUZed8dqHE12SbyCQ+EMojlI1Au/RjP4ufuX66uaiU4Toqa6vby2d5LJUVmxphrnyz7mxwv9XxvR/5YlcQE87idHIrwuodPDncr1Xk9er6NdPYLjhIIzA8Lg5Zw==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by DS0PR11MB7213.namprd11.prod.outlook.com (2603:10b6:8:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6; Fri, 8 Mar
 2024 08:20:51 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda%6]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 08:20:51 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <Bryan.Whitehead@microchip.com>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Thread-Topic: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Thread-Index: AQHaaIt96K5hsZSvW06kwmptrB0k3LErcdiAgAIeqGA=
Date: Fri, 8 Mar 2024 08:20:51 +0000
Message-ID: <LV8PR11MB87008454A629EE15B9CE14099F272@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
 <78d7e538-9fa0-490e-bcfb-0a5943ad80c9@lunn.ch>
In-Reply-To: <78d7e538-9fa0-490e-bcfb-0a5943ad80c9@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|DS0PR11MB7213:EE_
x-ms-office365-filtering-correlation-id: 7b69500e-7218-4633-2fce-08dc3f48aad6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HenGR9fIlkdDAi8ADp0ZuyneNb5ko9vBB055lxOh2KwqB+8tQGE4YpGpU4CTZ8ijxI2dW1zazhcyJjGV6iYt+ytARYcdNdMen3BiVXmY9jtxNpcSK6wPnXu2d1ayU7sTDdpKsAnTsyxvl8KzA5xn+4UM7MrvY8EygTlpeeZBFWbCHf8mud8z57ZeVt3Ke6gcO1WUKKBkly7zGyVA3n26b/8oP+sw1L6Jx6H8tcBjYgbIlMHiK/EMe4xXVa6qxIzKLoAWwxk+5aUrL/CYeXwhCc3tu6OYrwkzMq7oZi+d4hLaibxT2CqwVui75hwUopiaoyrtcAOc3qDTCDq0K3juWvhbDcyTmWObeZRTuvqK2G5hM+ixlJvMBni7GIfNkl3LZoKsfhQupwYCNfiBHRqkCmPf+Q37MX8h0Y8ytFetUJnvZvT57zsRVzioF7ZJvm2bX4GFVWgkn8ADjq1U7A27f4qX6jrJq3r8K09rwQgiaJrHsY4UJg8dDqxbPb6VCFEzGNAQe3oSKH4+/PILSBcJGqi3NgYJ8BwCbeG/KIXoI2pDqP+RD95nhNGYcpjq8TD1pf5yo4Asd7bLQeQOmmwKiq6nl4PVoFzhyJVlXX/l1buu2qxB3fXNOo6QZF1bsbBgvrvNNpfdqnmxRO7InufWAvvm3N9ePINODeeKgRpCNoLwr2vXZ07Xdeq4qL4CWrwp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cMhQVJhbBD60p8KuaK6oLuSnH0MK1Id4Ex394pL9CRV8yZo/nu5fbr8pNHwG?=
 =?us-ascii?Q?Fq5GLVl4nVQzB53jfkvIB0jTlMUPwVQvA9WAS6DXKGzjVKZ3H9IQK8I824e7?=
 =?us-ascii?Q?+KDZI9Q7Gbe8RCpYdETEt2sqP7GUmOZQHplblFkIDiTimMyx9aCA71Gk7u0f?=
 =?us-ascii?Q?tQDZKRSwGCT5W5o4d3qCectwhtEtm44BcV8TDAcnZ8AFREwkpijTrv77X9hF?=
 =?us-ascii?Q?K8w+/6lIngjOD7fDh6brwlGiF+GkvwA5NsPhfalcM83M9mQn/5k9qcP/UUUD?=
 =?us-ascii?Q?gWewYjQCs1sANv0elLz8D681URhIIinOUZoBc1lc4RT0qj6XPVLrdh/3xMwU?=
 =?us-ascii?Q?L4FhIPsBa62ysr8YIOp5YYf3MSgWdpzOpSBBif672vYs1GM5JZdel1dl65VG?=
 =?us-ascii?Q?ZCEUlBXkaZCiG504fagreYx61UQIMq8IntmUv88p7zoSiwI4PqtzquMMkzFX?=
 =?us-ascii?Q?EuvezGLi25MIWDuHm6slsm6CPkRdAKsAttALxOkg3nWARXMRLEkF4XzmXMWc?=
 =?us-ascii?Q?3TdFgvnNhGZyxY3iCvSZhD7Ubgh2KYLyTSbwmOUl40XvBwWsn9rMiaw2K9yG?=
 =?us-ascii?Q?7mO8Vsr5ubJSP7WX/gsIbl17w10vnLMlZJtOyYM++fe6xubDFFpTYTsvo7zF?=
 =?us-ascii?Q?StklFXN91r9D7+zcV5ju1N0QvXP2QrQcHfU4XXAfzdmZbHXFjJBOAoU1FXpL?=
 =?us-ascii?Q?AYu/UoXr9zFD4m+y3rmVGF0/Xeb+E22Jtpr2Ug+sabd/eMmg4SnVlyR8JH4G?=
 =?us-ascii?Q?uiJjv2eFtA/SQ3GHT6Lig5htVNEqdTq9wTZVTf2OuIXHmr9zMTG9Wkg342LK?=
 =?us-ascii?Q?mHk4RyBYAxfGBo+ygLjr0LcMTnu6S3NxcSg2zam6yQx/Ae2TaZPjpIQ3FB4f?=
 =?us-ascii?Q?TIXkQ78XNT3hpKYXfgVqUqBoHbXpPjzv2FMtfpGItrDd/IoBmQE6aTAbVEdf?=
 =?us-ascii?Q?+Aflwin69KxUA6q5QhSBRv1ip5KHnYOL8IGuIgee13R4SoA7Tym31i/Zn2o5?=
 =?us-ascii?Q?G7uZ6mVGiSaEP8Y189e3jbc7VONIB0HEnJcN9ptENoa3mInkZ8TKNRaCxs+0?=
 =?us-ascii?Q?QlRylkWbWz/xsYVAZa8zytB+GjizLwhC6X6BcMJhZZ1RWoIyrE54QNGD8lFh?=
 =?us-ascii?Q?LJdgcZ3sX/5ahkf6a/RX3NAAUGtc6zke+Qo5NH+47lg5A0t94vOYLwDGqEe1?=
 =?us-ascii?Q?FLMRtgoeIrhK3eCLoa67x2jEOlE6tDnD+98MuOLNJ1I/Ee+X2mScFP7dUhZS?=
 =?us-ascii?Q?gROt19ABXxsbozJBTYV5vaS2VwCO027eRE+d2Jm1HXLf2Qn/g88OA0QWmYrt?=
 =?us-ascii?Q?y0l5On00Y5xb1MfYS78ipzXWWYBW2r0+1PBUw1UhRIs/vHGZZUhg6AaVoXvQ?=
 =?us-ascii?Q?l8g/ciYjXz1YupW5ETFkc5qHALtmojXQzflCjFyY4ENgTI6kDI7m+Jp+0okq?=
 =?us-ascii?Q?mOIxvCsRHwM7WKgbgIy5ef5odoUxfBgQFe83mi2P1sziNDfDDOBBkHj49mwA?=
 =?us-ascii?Q?3oMEgHOdh+8z1hCjCvVsesnxEj7vCOvePw3MPibgBRvekX9mPIsXAWIPqnH9?=
 =?us-ascii?Q?aqNPfnvMDpzVWKLWu/lzFM1Ao+XSrxiw/p3QtlY2WgvrN0xyzjGz0PCqz9jb?=
 =?us-ascii?Q?4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8700.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b69500e-7218-4633-2fce-08dc3f48aad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 08:20:51.5611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kc0MI4GE6KoLy4basn4uoSnMQ33SmTZvknixkX0g6JnhQ3DKZquiUKZjY8KNPHZK4Z4/8QFn9njNw3UnvXhIP4zzxpMaxzpWDZjv82WJELs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7213

Hi Andrew,

Thank you for valuable information.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, March 7, 2024 5:23 AM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org; linux-
> kernel@vger.kernel.org; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; richardcochran@gmail.com;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake opt=
ion
> flags configuration sequences
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Mon, Feb 26, 2024 at 01:39:34PM +0530, Raju Lakkaraju wrote:
> > Wake options handling has been reworked as follows:
> > a. We only enable secure on magic packet when both secure and magic wol
> >    options are requested together.
>=20
> So it appears unclear what should happen here.
>=20
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/bcm-phy-
> lib.c#L909
>=20
> WAKE_MAGICSECURE is a standalone option. You do not need WAKE_MAGIC.
> And even i you did request both WAKE_MAGIC and WAKE_MAGICSECURE,
> the WAKE_MAGIC would be ignored.
>=20
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/dp83822.c#=
L153
>=20
> WAKE_MAGICSECURE is a standalone option. You do not need WAKE_MAGIC.
> However, unlike the broadcom device, you can have both WAKE_MAGIC and
> WAKE_MAGICSECURE at the same time. They are not mutually exclusive.
>=20
> This also looks to be true for other dp8**** devices.
>=20
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/mscc/mscc_=
mai
> n.c#L318
>=20
> WAKE_MAGICSECURE is a standalone option. You do not need WAKE_MAGIC.
> Also, you can have both WAKE_MAGIC and WAKE_MAGICSECURE at the same
> time. They are not mutually exclusive.
>=20
> So i think your point a. above is questionable. Can the hardware support =
both
> magic and secure magic at the same time? If so, follow the TI way of doin=
g it.

Yes. I will do.

> If you cannot do both at the same time, and that is requested, you should
> probably return -EOPNOTSUPP. That is probably better than what the
> broadcom driver does, silently ignore WAKE_MAGIC.
>=20
> > b. If secure-on magic packet had been previously enabled, and a
> subsequent
> >    command does not include it, we add it. This was done to workaround =
a
> >    problem with the 'pm-suspend' application which is unaware of secure=
-on
> >    magic packet being enabled and can unintentionally disable it prior =
to
> >    putting the system into suspend.
>=20

Ok. I will try to fix in 'pm-suspend' application

> The kernel should not be working around broken userspace. But i also
> suspect this is to do with it being unclear if WOL options are incrementa=
l or
> not. Since it seems that they are not incremental, it does not matter if =
"If
> secure-on magic packet had been previously enable". pm-suspend is setting
> Wol how it wants it, which you say is plain magic. So magic is what the P=
HY
> driver should do. Feel free to submit patches to pm-suspend to make it
> understand secure magic, or not touch WoL at all with the assumption it h=
as
> already been setup by something else.
>=20
>           Andrew

Thanks,
Raju

