Return-Path: <linux-kernel+bounces-1103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AECBE814A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25700B21A57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1C3173A;
	Fri, 15 Dec 2023 14:25:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2077.outbound.protection.outlook.com [40.107.117.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD8F31A67
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4QoMqsuWws+fcr9rHEsiRCSA1gZgoSeSJX8Bx7K0LH6kBMBN63cOP9K+op4C07jgqFWfO3+RWSdQYeSiElsR4dFthbheocjnwBIw9GGQuV9exekyRz/kAutVeR2odG5dgEpHJC5z9FPH4gPB/O1qAwPXuQNhzTuiaCYjPtyRY0gLPVkZ57y7WDI339OhHh7RCwhhjHK2laarEGpwxO0XY900O3PAisIomtJapepJOBosv6JDYZS4NbC0rnR/Yo9pWL+KwsWalpgK4Lm7SZuJl8Vq2a4ObhM0NDkS7m4noUTScvfooA84l/Pj+XRxsdTSF1v0eRuZ7XP8WVVIlp6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cudtAc0Vm5MplQDNlsggLjYKwoBfUr3XvW5TysJnM0M=;
 b=Zn14X5jC+CJTk443QGent5+d6/4fSWm1JLcuBvjqMRl5WnEs9tulZz1Hw/kcE20GqU/DxnAINBPCwCx184M67Ck/TS62DADk4azlUQcbEFicJefigWTR+9hVnqQDR5fEfERB7HoOEWIb4abeF/TxicedD01O/N6MJiE6Sm7uniSiSsUVg8JLI8ENN3w3yjT46fFTxfA579byk/W3yydtY8RGZAGvXIl25B+y1TcGTl5m3Tb3R9wGKyXzMzHVNLv+FCl124wvfxqk0bsvxl3ka5mdFlDN4Mny8gwE0A+xHOm/8ycfyFuEjH0+qvYD2KljbJdkoXx++RU5uTqOBnF0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5)
 by SEZPR06MB6551.apcprd06.prod.outlook.com (2603:1096:101:187::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 14:24:49 +0000
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c664:8a1e:66d6:4e62]) by SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c664:8a1e:66d6:4e62%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 14:24:48 +0000
From: "Joakim  Zhang" <joakim.zhang@cixtech.com>
To: Christoph Hellwig <hch@lst.de>
CC: "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>
Subject: RE: [PATCH V2] dma-mapping: Set dma_mem pointer as NULL after it's
 freed
Thread-Topic: [PATCH V2] dma-mapping: Set dma_mem pointer as NULL after it's
 freed
Thread-Index: AQHaLmcky1/MaAD/QUerCOizXimNM7CqN/MAgAAuTiA=
Date: Fri, 15 Dec 2023 14:24:48 +0000
Message-ID:
 <SEYPR06MB62784DFD5EBBA85361C80A068293A@SEYPR06MB6278.apcprd06.prod.outlook.com>
References: <20231214082526.1212264-1-joakim.zhang@cixtech.com>
 <20231215113226.GC6479@lst.de>
In-Reply-To: <20231215113226.GC6479@lst.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6278:EE_|SEZPR06MB6551:EE_
x-ms-office365-filtering-correlation-id: 741b85c3-313a-49a3-5b77-08dbfd79980f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AfyWoArNZqhOqQpp/H4KkOxgnBX7BYEnbaSIoH8tMvt+jIIsPfR+hevo0uRWoiyny4E0BZdevs0a/gRsWXGF7siTdkRkftjY6ZjwwjVZ35xhAhweSTh7RRhUDe3MYjSdQh+NCloYpH/XYw/mO0AfQPLwnsVXeE8F77FaLhhJrntUOQhw4iCKCQ7Igi5N/uoHDT9DxpVeLA2g4cTc5oxnwL108HFBj0OGpvM48PMCKq4AYhrrVEtqvUygGgUOm10xIYKnFB5cs7Y1s/jPxrUdA8CsRSpg+fqp7Ed3WDmolWaDEpzponAeeHRx1hu1jwPhas9OuXlfOuFkh6uR2dLui38gMCMzVWsQTN/UgdsCTcnNYRUiaa0J3ZyvH2m/Zs5/mfK6GWnzAWzbAMaL2YEU/aFiiSJgxzaN2l+TnDbh4lRnD4zpm40rXZyH4VxPspFN40HB2v8IqGriGXyRilk7wmLuScWA6hfMPxt5ApEw1GOu4cLUTxrrx6a+5OYv1qN93e3lXTXcXdIPq4MYyKbYIAemALzDUDwiSey5/AGLSzB11HXoxSrLpFkuGbWuUQvjhzdgRYqqjd1k0RcvWCX4whVfRwTYOI0oPBTzQxsQkP3fz9ygD6kQUZ9NaRgRBuJY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6278.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39840400004)(376002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(478600001)(38100700002)(122000001)(66476007)(66446008)(64756008)(54906003)(66556008)(316002)(71200400001)(7696005)(6506007)(9686003)(107886003)(55016003)(76116006)(66946007)(53546011)(52536014)(86362001)(33656002)(8676002)(6862004)(4326008)(8936002)(5660300002)(2906002)(4744005)(41300700001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g4/PJNUiKdim0GMG+Ti51ZbtO/PpCHsYPHFpqnXlBm4ntml3UOARTu7fsZvv?=
 =?us-ascii?Q?AszgJ2tvHtuT6AxAYVHL/aTPPjCZvMUe2kLMX8frRFQnWDghN1oCs6oelIrx?=
 =?us-ascii?Q?Mc0KzcJtqGtVW9QKiNaUjErANm1aKRQWNrTsXlMm+T9GgXYEJGznWBuyYemi?=
 =?us-ascii?Q?duk4r3inBSqoeBIurX6qbeCJceN5uDsxJufGpnphTbUa+u2noAx85xt86Ohl?=
 =?us-ascii?Q?WVREvaz5UG6azgrtB+ydqoOevcvwVEJydKtiLmQ1R6fD8L/tsksCoNr6sVWv?=
 =?us-ascii?Q?vLD7mSevprmyCphmVRb3jWNU48Sns4yH6fcGZY7bYziIhS9MtOSDfFc5apng?=
 =?us-ascii?Q?8iAeb1Sz0w2anpaCnpm7CvJ3/6muUdwlYSkt6xZX30QkVR9ZNwr/sI+J2rik?=
 =?us-ascii?Q?xJyl4rrTkTTP4Ri0dy3CDy6CQXXpQ5BA5pFI14EUZNRA6jCSujYDmaw3giVi?=
 =?us-ascii?Q?qXgUWEJ3uG/QuIxhLe56MrAzIgpc5T0qJ3qhmPM4xB0VjzwcjRityU+L0EWf?=
 =?us-ascii?Q?13MEh9PRe48IAscV8VVRYyJIYjx8MOOL8VblV0QgGvhr3aaUp7irq5EGno9m?=
 =?us-ascii?Q?4WAq56PuCRtjsKcLngBpgyAhsu/WPqzoudW6Obet50GPUaUUT8aMjzt2wA4S?=
 =?us-ascii?Q?fvw/p7tp8+rdKDeLNF7Pp1cj8tw+jSDvGp2ZJTrkCfTaZndZNKtgKXHFImpE?=
 =?us-ascii?Q?Who3ad5B29+U+RIQ0ltDMC4CePT0GHOr0i7tiPf9Gg2JCYzKIpNJL6JWRI0d?=
 =?us-ascii?Q?QKzMw+V11nGInQ352NsAFq8/DHPCd3nf9EWjsiB0S3yRx631kLBC3fWGfxim?=
 =?us-ascii?Q?RQlqs4qfTPYRmVyRiPh/Jr7LNkAlbc9RElsmvAYO8kX/Gd+GOpuqVnW15pPt?=
 =?us-ascii?Q?pCe4IHQUizuWaRwe2RGuw+t4sZXKRbLLh3biD3UxDoKU5sGAKikYDCANZ/+4?=
 =?us-ascii?Q?QH/IqEvfa96OVfmkEGTCs7SwDHm2jvVtVz/YdemD8bGJUPmvhcWWI1V9Momg?=
 =?us-ascii?Q?rbTj9jlM8woPuvn+xqUnRRNjH4uSy9kKFyy6iCMNQsJCkTZOqj54SIJypUfu?=
 =?us-ascii?Q?+p/K+7Z3Q6zHX6RGa3R4ZMk/4HUXrdgKkiEZGGEnOcL4l8hGDwLZwczEV48s?=
 =?us-ascii?Q?WryyuWutRwDSFau9u46VtN8GKKzwX14/scOT7DWpQB03ffSETt1cA20WbRKv?=
 =?us-ascii?Q?p3LevXofwrPWTbS2dYyc8giYWEWx0M7aBAGR0xipAAUcCh/Fm44ASv5jWOiA?=
 =?us-ascii?Q?uXxfTDbYfS5pDmK482dor9c13PbNLi6065Sqo8e0JBeJIw+CQ52PFjfuzKRa?=
 =?us-ascii?Q?uV/eETv5vDq7l8S5lEbnzzeBnXtAu2pSBAVQDBe/w7ZlwRoZ9BEeLo2+auxB?=
 =?us-ascii?Q?IODvwyLjkmQNeP/rOWwDh0KMjM9HocR8U6YDvfjeSr+ltMoRfC4pa1nL9MEN?=
 =?us-ascii?Q?ViA9RzfzKEbZBHC8zDeh0ySmzbq5YK2ekbMF8eiSccYtwPNE7R8hn028fU2t?=
 =?us-ascii?Q?+IiNM6GWUbCVxVEmrsJ5pK0tKxnpWMim7agBzi8SxUgwJEVV9q3Dk1wh/Kre?=
 =?us-ascii?Q?jm6fGeNKP0qhq85xuO2mgSRLC+3+ei0KtTqE0q9jqxILiQk97gbmIsjMaqSl?=
 =?us-ascii?Q?Cr8o73Z9XjFWK0tdmkq/1mc96wS+TBDTY8516X08PCnZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6278.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741b85c3-313a-49a3-5b77-08dbfd79980f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 14:24:48.6917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lv+QjsKfpZML9x66E2P9wEte/segBqGaIbbd7nAX0jdYQaNm7LZ0NbFWx+z+sMVnjG7RpqYAsgK5CYDgJ5HmnjpLA9JzufutJZDEMHLJPDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6551


Hi Christoph Hellwig,

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Friday, December 15, 2023 7:32 PM
> To: Joakim Zhang <joakim.zhang@cixtech.com>
> Cc: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; cix-kernel-upstream
> <cix-kernel-upstream@cixtech.com>
> Subject: Re: [PATCH V2] dma-mapping: Set dma_mem pointer as NULL after
> it's freed
>=20
> I've applied this after fixing the whitespace errors.
>=20
> But we really need to get remoteporc off messing with the reserved region=
s
> itself and retire this API entirely.

Indeed, I met this issue when debugging remoteproc, this API maybe useful s=
ince some system would not support device tree, but still want to reserve m=
emory in the driver.

