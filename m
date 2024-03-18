Return-Path: <linux-kernel+bounces-105684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9695487E297
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1981F22030
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC1A1EB4B;
	Mon, 18 Mar 2024 03:33:58 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2121.outbound.protection.partner.outlook.cn [139.219.146.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08F210FF;
	Mon, 18 Mar 2024 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710732837; cv=fail; b=SzSUDxRkDBB4lwCu86kjms6LBFktPJWk8gFw8tekoOH+qiKRfAmgq2EJqHLIMVRQ1sY2o4tKgNq1QD1uQH3W+Fq+8uM2Mc2DqCBkt72ATn8m3jCZktW5nJv0SNklwax7AbNNV2IqVsptx67P5KVR4CLppNbnjLDHpL3hCNbLmuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710732837; c=relaxed/simple;
	bh=OSJP5u3Pk8qaIUlWf81Q3RCvSVxFICT0A0pykKckW9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SkOmXtg0WoJIFUWgpgFzITChxSEHAPnNSRmlFMWkvwMNAE+x8k6B037EEcju+2DDdhE86yj/lrgNs55y+ZQ2gP8z52AsiJd/OFGN7mjWbl/qdeuiOsZsg7l2QOUr9Dk2WlKwD2SHvLeukgxbhwwMFrK7Ju74nIiFYCaXPUDxpyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPAVVsb4vJp6y4deapWFS7INgLgq3C7rjbvZ5GPsscmwzAtmEqEQaIkZGqmmiGroH/dSNW7AYMUvu9IgW2XL6NpS5q7GVvJHbXMLD2A0A5kOJN7BmxrRpjAiBHy9vSGbFRau9LeJok0fbIm9hce+pfS765O2qga/b8IqMse+w+M3FPao7qlxdGuiv43esjHzck1i2dDQsjaWHbVUMEyp3bANCCe670gL/fcyqzFCJTICEmVxe8SkxyQYnnNz2UP/DofDjePnUHxVo+T2/AidcvCzwH2EPGo+aRDb28tNnIpfV2XVdz55DQ3iCc3AFej6tZKsd6tzoY479/XUfafy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSJP5u3Pk8qaIUlWf81Q3RCvSVxFICT0A0pykKckW9A=;
 b=HlZFvhPsWO683S5gLyI2rWN8+XE65JDTrKj4F3GLI70NhyVxq9QUwMdEIYcKvjOAZyy/q+uu59inPcxTHggVfIK6GqDMtKnp9dir0sRy3bJjkuThFccOiHyKZRrMO94zDCaVnCHsl5NmsSKtAb69jNwfa1OtxuHyCJcZQB8Kex144t5K6vKxxqapZ83GHm0vfJOfiUeQujIkLl/Z5/ce8/zGoxzWDCNjtnCCyy7NZXYKhjaF/JFHyRD0Wc99j/RwH+S7RpQ8Gabosndxnarjb4jt/V4hAXDJbbQ5j/3WRdn5wSLS5gVFQR0DE7Aen6U1QLscLouG596ap6/Kjbikgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB0957.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Mon, 18 Mar
 2024 03:33:49 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::d810:3fdf:422c:75d2]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::d810:3fdf:422c:75d2%6])
 with mapi id 15.20.7386.016; Mon, 18 Mar 2024 03:33:49 +0000
From: Shengyang Chen <shengyang.chen@starfivetech.com>
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, Minda Chen <minda.chen@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>, "rogerq@kernel.org"
	<rogerq@kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>,
	Keith Zhao <keith.zhao@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/2] Add JH7110 MIPI DPHY TX support
Thread-Topic: [PATCH v4 0/2] Add JH7110 MIPI DPHY TX support
Thread-Index: AQHaa3cya8U9IZqdqEmG+IUhyVoY+LE87ZbA
Date: Mon, 18 Mar 2024 03:33:49 +0000
Message-ID:
 <NT0PR01MB10706AFC0649D479D26DDC35EF2DA@NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn>
References: <20240301012406.92589-1-shengyang.chen@starfivetech.com>
In-Reply-To: <20240301012406.92589-1-shengyang.chen@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1070:EE_|NT0PR01MB0957:EE_
x-ms-office365-filtering-correlation-id: 55781783-14c3-4b92-df0c-08dc46fc399f
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Npo2rkCh/HF31H5dUZfY43u3Onr9vinSKqUwvUnzdAX4MJKltO8G7wU0VIfFKRmYvo3PMJNIvveOVB36XZUkj77cUDZ6Wn+zwfybVjLx9S/OC3fdQUBj4rKrjkLxfX6/eGrPHhCFkXg1hBxX+IP1bJF8QW3fXiGK0MH3FUehz9yoLfmzNpbJYJeW7nCfhm80Du20+Cbe3SovclJqQnFirefVhmmqHE9YURQpr7yii5IH7EnLaF7QwVawWfwMF7GvsQM/al34wluP8RpAwmkRuBpQ5fwuX5zywFM35M6EvpNZrQGG18gGWi5FguHbGQW41+QAtlSld4ZxVxqnDs/hpnLKqphKP4f3BOhJjS17unsFf+UafQ/px/9yqzTqSQJHfXQqHY8ytYKuLLs9Y533oU+EjeDkCNQXjRCbU6XdtvoH3Wi4PItrcsQDSnO3lqjOVvsQlpOXpfT5pvPTYgl8/ocSpgn5sWVXyksAJDq363Pl2QeW+7U4PLuEqtaBhMrhbGCDv05uf4Q/I5IU58oNRj85UKZJY3zEZ9K/NrrHz2awHrkXKZ10r2Q4IQAKHgdYEYh4kEgiUds+0zmcQq5pTH2B1R2aJpRwRsI03vOuzaKxUBVY0tck+Au5YbdYWe3W
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(41320700004)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cbZvzdrixXupdChA0LN7qhRfBST49WgC3ZRcOpOQX96oDIxhyJD6C/nnE1c5?=
 =?us-ascii?Q?/cHMt7A3RBolzzANNr71fWDHw/vJDkC3LXW7vEeGZ++mSqv/7i9w3UnHNOjy?=
 =?us-ascii?Q?NoaTe4MLAzbOh3VSJuZKCLSPP7+sMGzaPOxgx3HYo8l7jit7TFLyEGHMGc0a?=
 =?us-ascii?Q?tzD2lzRImzAagW2nBGXGcY762oZXOhGtUjDawIEf/n0CA/4koS+XiZJT9eJO?=
 =?us-ascii?Q?iPpJxaCq2fimjQfl0NB9UEXiNRPqtUZ9r/BGWFFFuYNYRcu55wqw9Axc5Uok?=
 =?us-ascii?Q?ZB8CDLJYzWzOONC8K9h+sCwW+3nl+lzaIEe/yG5s0LlNeyFIEB43CzKwbtDf?=
 =?us-ascii?Q?4ZEVhDQvyRNIz1RVZOU8jWEizl54iL4B7b6WXBKMYgo7sNSS5T6j0avjGua+?=
 =?us-ascii?Q?cVQ4PFv5yiXWRzJOTmLZCHd9NcSvGTFBK6LYlsArnrHfBUXO2KdhHBjyCec3?=
 =?us-ascii?Q?RKqpEvETpt/+mnO8WmWIi7IKCHujSwHHG4jlcMQa09ATi3AytWOcpxUOy76y?=
 =?us-ascii?Q?hDgTwA8a4Ovm8hANh4sh1ALibrXSad+JWDVDAS2EX5wOv2xu0VhZoqHrueLt?=
 =?us-ascii?Q?W1ilgRHqkzEMvYYrFsjU6IJroJ3w63CEg3MXwBt2rKPtkwf+xNqDtZrFeMOy?=
 =?us-ascii?Q?s+40H67lGQDglbfCE7QCihz63y0pRtdb5ZEjF3Hx8Q96wOTLFNYA/wo2FHN6?=
 =?us-ascii?Q?TXYTx5jkNoSTWe26DbJpn/LY7ORFw6puu5U52vI+WNcfEEeShCSfGrWYbbfi?=
 =?us-ascii?Q?h2Vukv1cCElqTiBIY4ujxPhZgh87d4/4HofIu20JwbtUnMqHI2rdSmdiwG5G?=
 =?us-ascii?Q?HXq3PiTQz7aJvlXufLaIzUlsuyJztiJwngYoIMJ2HTBDvQLaIlKoznk0Htu9?=
 =?us-ascii?Q?Ta2t8FO32GJjg93KWMx6qR+u4HG6ShShsJoVIhYmSx9X3NOlwmad+dB8MUiP?=
 =?us-ascii?Q?F47kWFtHVDWF0W0jf5KnsqkCnOP1GmYYdrZusAVwn8vRRKX6B5Xa9WnbG75c?=
 =?us-ascii?Q?pgmxgHfvXUAbg+oWaYXrTcL+T2wlbaXXuAsEQi7v/kpRJa16b12/2kLep91g?=
 =?us-ascii?Q?WssGnFO2BIthc51CChYjH2uik2uobXc+dP5wq8tc3ssrCooCvk2FGRlEKrYA?=
 =?us-ascii?Q?6lbtKdvzhNHXuQu8Ut0BUb3F6Ecny64iD2fdLDz+L2ISeyODrv4DabB8lqyn?=
 =?us-ascii?Q?muXY/C8sQRmZaDLajsY+4U95TDu7KzuVj6EYlQ3+nEWz+L3gqxyOC19YT3HF?=
 =?us-ascii?Q?pgQeJDALJFNoR2XR4nCQ0TYIKvDPHgHgHCA831NI+CsIPh6vyHP90R1A8jNh?=
 =?us-ascii?Q?Ccgyll5eDv6NPh+z+qIFyc+5ALIbfbGm2rCywY8R18PDEckJBawz5w3Vea/J?=
 =?us-ascii?Q?1QboxnY5FkiQ9x9nHF6oLC8QIJcc2wJ/hIVqysqkTp6XTa6roX1TNv15YjKl?=
 =?us-ascii?Q?Z6E6LmD0/GVK0aQXyt2vVNmHBWMuJstL7oEfNEL3H2TskZgwHjVsnDvFreR4?=
 =?us-ascii?Q?tkYc3UgDwnS9/AaFWwovyW7O3qLlCl6zYmcvdQj5k2ewQqQ5iVaq3yqOcvho?=
 =?us-ascii?Q?ArB80gnqRL2g6i6rnas7OIyWQ5/hqB1TPovlcLE5E1Z9qJLwgykjBNQfUbB9?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 55781783-14c3-4b92-df0c-08dc46fc399f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 03:33:49.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adAIFNQ88wXdhloLZcNXLMC5RjZuWwrqX9BEVS+LMpNqp9YpC8rr6tLQqCjCXYe19mcYKz0DAuVoQuO5vnboPnQDCykw+dDV9G2FKj7vP60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0957

> This patchset adds mipi dphy tx support for the StarFive JH7110 SoC.
> It is used to transfer DSI data. The series has been tested on the Vision=
Five 2
> board.
>=20
>=20
Hi, Vinod and Kishon

Could you please help to review and give me some suggestions
for this patch series? Thank you for your time.

Best regards,
Shengyang

