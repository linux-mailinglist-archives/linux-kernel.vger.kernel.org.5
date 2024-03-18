Return-Path: <linux-kernel+bounces-105654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8F87E21B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1781C20B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FC91E896;
	Mon, 18 Mar 2024 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M8ClY8DS"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81D1E864;
	Mon, 18 Mar 2024 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710728461; cv=fail; b=IRpbByN+fmyOEgSdbUEdkNwohWgLhlyY4sQEYrSYGFigf2SNWaVOBycnk9fw7appPe+H0Co5kKDfDI9jpC7zKvDHhOATI9XQNDAKM3xdMh7eE7FbwhvHdiVqCD6LYQgAmqDkUUOPAZpEw0iH+9j18Cb/URroAlQb6xx/XMZKTsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710728461; c=relaxed/simple;
	bh=kTvOnOq2VxYc0qnVCau9u8QQGX51e+/gPaK8PF2AW7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UO72WBcmiobqN7Cb3k4Jf+063ka4Cw181A/qLKOAQcOa3zr5WCRjJvq9aXOJxxEvuF98+mDw+TN+AP/cX6jmi6zdPnpR2351NLGSGzFzYwGw4k7DfjuZeGWz07KsqxH/HvGlAMILYqNPsdoZ7DeiDQ+46P9t+bqHqwgy897hE/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=M8ClY8DS; arc=fail smtp.client-ip=40.107.6.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHiKRzzf1/GR0y8mWvevkz/RMmFewKorS7WDZAz9ZBi4NC5QXjl8c0V3igicwnzuR7jJ8M69CJqU6ivCYqwC+tWcylwGeFlTShkm6EC3hBIAxWoI6G8ZvYFb4eqBSda+5ASPClppjEGPJmrylm1bxga7iTb5/hXjR9B1wK1atp01SCIfkONCRk/F/rsK8h5tK7riWeKt9T+xGN3/teTyM3Hjsm8bzcUgOf0SR8YRamMjbo7IfzLTuUVZps5t9j78LlZLv24fVkVvcAUpT8myDqoIlCkWuptO2/5vhqKz6dcGG3T9IQ4GMpdKKn5MDVHWvJaK4sDARgGn+vc2iWL80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTvOnOq2VxYc0qnVCau9u8QQGX51e+/gPaK8PF2AW7E=;
 b=ZiRx9azQPlK7y5/kYKTjqBxjBR6GohPYh7j1CBcxj/cNuAzRr33kzHzsWzdsXSC+wKYWds/6hIZ5Ag1Ky1YrVI7ehqqEQhEDO8FSYx0TKzhGlEZjocSrIdpbBbUfeuxqBh4g1j7j1yq5aPQtCuku+RizDwvOcyM4wkBOxCgsLh4hNdukB1TzBmwp2/TkJobwoDDtXAerw8utMFj9HIrMiB6HL2k0qkoaM+ToXiIUsI4K2HfsHDMeMLXOTMdPRM6mKRiUCmJNzjLcLsTOtTL5YxhfDbkba37YeL4kIE2piwAH9QlvxWVRiPMBDwD9HpEQ+8CpVamNx09S0dXqruR0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTvOnOq2VxYc0qnVCau9u8QQGX51e+/gPaK8PF2AW7E=;
 b=M8ClY8DSn3Fo2Z/QAM6UyYomidvYA3IMjU3FOoqOBFqNuCinhE8Ld+rBegounKB918i4/bwD2f8lVSTmz7R7tl8cG2HT+IjNpaIpbHG9w2eN10aL7cmyI9K9uMTnHaPluj4EdzYn2sc6Mypu8MrhdvXBm4JELygnfp7Tpx7ydIA=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS4PR04MB9291.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 02:20:56 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 02:20:56 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, rafael.beims
	<rafael.beims@toradex.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHab2onJLj7by1TDUGmc5gbcJq9YLE5jRqAgANHPyA=
Date: Mon, 18 Mar 2024 02:20:56 +0000
Message-ID:
 <PA4PR04MB96388A076FC16CF4C76F661AD12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <ZfTiz_fhzPwRk4Xb@google.com>
In-Reply-To: <ZfTiz_fhzPwRk4Xb@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS4PR04MB9291:EE_
x-ms-office365-filtering-correlation-id: 474d044b-9949-477d-4ea5-08dc46f20b02
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LhLKJOlMDORpbxeloZtxdF8UKlafela/lkDZ2Z2LoYPxcgb6VeTC8CJqzlrDL5ApuIHbxiJ8xgA4e7lo2U1JPZoFMXVNjUgHxRhUYC+bsD2DbdYYh6+f487eCO81nAX9F7TpLRSeRXB6KBjnm7XAk2if4TJtscrEEjpX/545ji/RVaF07mHBmSnxYqEw+zKzqZWghKZLtsK96v8LgRz3ISUC3C+MhesUZdxQBapSO6w5fk+OEM4FPHfaZAjYdhIvnK93bNFh0x3J4GlKJeI/nt3V0/RRoFRAO0Unb7GXbc58sJ6OJ8uG7QCn0ygl36N3Op3o1BCcI1YkO620Dfyf54BOF/dOt3S8In7cAtoUE0ZWRqquQNJPG/DiKgEGi5skYkBAQkA+5Xf4hWU90OMkG27qrnkw5U3LyUw5x3qz+ORU/V4z5VHyZXCQ69ao7S8Ae5Nr9/8KRJOZqEyVptcQhehQdc6SkuWTMGO2F+iVrXCZOJPGK03foqicMqsRzxquv0PSf2w7SUQJsRmQRYEkgAMSRkYrmQl+YQVt2W2jXvW0un4YFaqvCEq2KMX9oeyGFva2eCQ7LlaGWfvDCA+vtBz5zqoll33YzinvxYWuwjdRMd3q5RNaeQmsjA7h7UNkEXBRKv5mTJTJ5fdCfvFMPc1YrqVKZ63ioi7jbeAt6Jlqt943i3QuM47Cztp3SFpTTAlbmYg9oeSdPV4hRit0Sq4TwHHrte//FJZ86XVUFwA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?raJgGy18o9v2zY74p8X63h13xyC6ZamrZbIvWx/O7BOBslcIr/oeeeJc1meY?=
 =?us-ascii?Q?0dCr3bCruvAqrCExqErrvS8YHvblmjPohZBV1lK6dTNrbzKHkHhe/rYrD8TG?=
 =?us-ascii?Q?Xk5Qiat5XTqkwXe7z/JH43b32cTtcBvAiAyyhc7SQYopHX3TRsGecIYAyiu1?=
 =?us-ascii?Q?fm88/fKfIyzkf3PB8yznkMr6N+P744jSpX1kOU5tdcJa+ektiEX0WRy98/T3?=
 =?us-ascii?Q?9h24+vCp5dYW7GmKwYSO5/i3RI/oCSotDefSnaH4RUeBTym+mXyhSXeRu/Be?=
 =?us-ascii?Q?9JJfjoPWSWQbM3OdiOGZQ3n4wbXDCixjDkW0t4WdXLKOXDGKmmwRE4PtD4TU?=
 =?us-ascii?Q?aHCEMpUP8zYMZnp3SlU5MtvVrsmJ9oexBNpdwdDtdk8Ro8mz9YMCGixSddYw?=
 =?us-ascii?Q?8qrmkKDmI2PUVCewIDwKocxFnVYtF1/md53Lt0FM35vlebTgNxkSIFbJDriV?=
 =?us-ascii?Q?KlAJTvWLVDBaegM2wYFNdFWnqI+a4pyhl6Dc7VvyJsPgyxMZkhCrYi3gKH5k?=
 =?us-ascii?Q?yyXHeHD9hfnhFwkrMq0kpSAnQZMSlLKvIkkUlbHRZveUG3xSAI93w2ZbZgDL?=
 =?us-ascii?Q?NsjtrX6tZlDOXLPFoW3+oqP6yQv6qjs6JX37x2L2z63sI1QdQN0e7ycBjSi0?=
 =?us-ascii?Q?BxcC9dUMyK6JNUwQNRKy1CQR8njXRYcos8IQaKaeqtvTSzmhqVqsffJQyIvJ?=
 =?us-ascii?Q?066oTkspqxRu+XZzBKtwgYc2LOkbmpDyeTBQY0Nv4Dk0Lv4pnOVe8mbCf9+v?=
 =?us-ascii?Q?DfOLIvJTAWIV5F1/mBWlVEcJpXb/BpmtOw8TqVcKV3LXu/Gpd40NVHSFctwv?=
 =?us-ascii?Q?WB9N/k3kkwJmvtAuG99TgLM+DhTdQMdTunRJ8QIbBrJZH8lI+fk/G4QZ9XOk?=
 =?us-ascii?Q?hPBRQFpou5yMcLrdPLRgpoujHpS0YA1XOiVNinHeBdOeAliZCUs6BRGGfu6J?=
 =?us-ascii?Q?HdCwHwaacevgtnIx9DtISXTaLg5kEkhcjXBacDTXAfkxgD3I2kIvozoYN/zy?=
 =?us-ascii?Q?oIwx75vD3+7NLxm6lnH+9f555ZU4pBjAX8UoWC/na/azxFjcN8z+L80SXuY6?=
 =?us-ascii?Q?KLPjCmOUI2c948nKmMEVRF8+h/s+2EVFPvseKT8WEY+UAaPhfCsgHq2p6tsr?=
 =?us-ascii?Q?ZIA1vlzWrjOUGUrLhXd6QadtpmLzWRkxKz+z5iIYC7k95NIzdPkgbViYowEE?=
 =?us-ascii?Q?te/48tFX3r1HfiSxXQR+kee9SG6my9tuYhgvyz5HLm7tp6elY17fVLkIhXNn?=
 =?us-ascii?Q?93ccpDDzS5KbrsFoluXRK69vgQ76gDP+O7tuAILZrqHacOfr7d7UMg/uP40W?=
 =?us-ascii?Q?t6BirK6c7cklgLI/EnJGUIbnfJEtM4pgnHcrkVFxIk+zF1yINGIcTe+Xf3Xu?=
 =?us-ascii?Q?LarA7QhUNfEkxf5o4K6cXq9DBBGZD5PxECux9hTxeFWkAcWSMiEpG5c84D1m?=
 =?us-ascii?Q?tb3gxXxmOceyuY6zxaL1JNTWTqOBAfrOETDWH0zXXnRE0k/LP5m3gbyd3FJ7?=
 =?us-ascii?Q?GLG+LtTbVo1XasOiJaFShmUidaxXAb6jZc3dinNE035b2ZQD52rLZnE0smgn?=
 =?us-ascii?Q?ffBF/88VT132gnAg7oIFHsnrpmob7ja/kaRo6NTc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474d044b-9949-477d-4ea5-08dc46f20b02
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 02:20:56.0325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: De3rMDSeyUYfzAiCUl8WC2UKR2HlbSDV7HnFEiqX2CFIsqR6o3tTa2I+iglAcKuRhxRVbciGzPc1WjY9cSk89A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9291

> From: Brian Norris <briannorris@chromium.org>
> Sent: Saturday, March 16, 2024 8:08 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; rafael.beims <rafael.beims@toradex.com>;
> Francesco Dolcini <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host=
 mlme
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
> > With host mlme:
> > Tested-by: <rafael.beims@toradex.com> #Verdin AM62 IW416 SD Without
> > host mlme:
> > Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> #
> > 88W8997-SD
> >
> > This series add host based MLME support to the mwifiex driver, this
> > enables WPA3 support in both client and AP mode.
> > To enable WPA3, a firmware with corresponding V2 Key API support is
> > required.
> > The feature is currently only enabled on NXP IW416 (SD8978), and it
> > was internally validated by NXP QA team. Other NXP Wi-Fi chips
> > supported in current mwifiex are not affected by this change.
>=20
> Thank you for all the evoluation in this series. This looks much better t=
han it
> did at the start, and I appreciate the additional explanation of features=
et (HW
> and FW versions). I'm not sure if this has been asked/answered before, bu=
t are
> the MLME/WPA3 limitations exclusively tied to the firmware support ("V2 K=
ey
> API")? Or are there hardware limitations on top (e.g., some firmware migh=
t get
> "V2 Key API" but still be unsupported on a given chip family)? Could othe=
r
> chips chips theoretically get this feature-set in the future?
>=20
> In absence of a clear answer on this, it's definitely a good idea to do t=
hings like
> you have in this series now -- that you have a short-list (of 1) of HW wh=
ere
> where it's validated, and additionally a FW feature/revision check to ens=
ure it's
> running appropriate firmware. But I just wonder what the feasibility woul=
d be
> for adding to the shortlist (or providing users/developers the option of =
doing so)
> in the future, if people are so inclined.
>=20
> To be clear, this is mostly an informational curiosity and forward-lookin=
g
> question -- not a request to change the implementation in this series.
>=20
> Thanks,
> Brian

If firmware reported support of V2 Key API, then host mlme can be supported=
 without issues. There is a flag 'host_mlme' in struct 'mwifiex_sdio_device=
' to indicate if host mlme should be supported. If this flag is set, driver=
 will still check if firmware can support V2 Key API. If firmware can't sup=
port it, host mlme will be disabled.

Thanks,
David

