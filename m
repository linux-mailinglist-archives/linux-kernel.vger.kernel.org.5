Return-Path: <linux-kernel+bounces-152669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E99E8AC28D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE8C1F20FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E04C65;
	Mon, 22 Apr 2024 01:37:08 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2132.outbound.protection.partner.outlook.cn [139.219.146.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEC1109;
	Mon, 22 Apr 2024 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713749827; cv=fail; b=CAWnJ+PY6pxHslPvXZ0K9C5zrFwNVLRDrdHATUx0ORkKVhIaix9brbGoCpSqB4MP3glISCTjUgjquY0/R9Tn35Fq6ibWf6GOA51ysE9XXkJDhcFrFVPHNlGcXwUvLDKji4fZJ20iPwcbeQorAAMRBz6hcamoFa8RmDp0Ev4C0Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713749827; c=relaxed/simple;
	bh=m9EaUIsiOMcIGATi0/CEZAGAFl03tC15eaZdXjNMkxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ybzi80DubhYQat6kAdhxR/AazcK38qb3zYirzfMIgMoDJCU3YmATLX+fL1xJkixZrIqkfbttidByDG+Kl9BA6uDQjQ2Szhlyazl+zr7n0kok78LrjFi4AIqyLxnBmR2Uvmn1vbucT6HfqzEFXcpxRwvILwHMQ1XZOJr3mBaLLsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQjmbm4h7VJyLaXqWt65/ASdZWL5bczQr+P9qq63hRhNZPG4TzF0JEKf/o2/pmASxVpkBw77bCene+3uH5NFiI1snYVOzlZlTExFiSf15xWrX56cbxdhsWkkeOIsFl1ofnMnYGS/4oKKklbW26/e7lC/5TcK/hPDJSjJF0nZ8aG6m6/pnMJWExuCCFeLsc41JprW9DOi6oX8C718Tz4qbxn5kPhPZHSv3soC9FjE5YMGiPgiI7aoGVtR5BBinb1Zxvb20KsnxhoyYWV6DZ9qO+DR0wyp0KcKJfOCBcxTPY1O/g5Cq9d/PkcoOzpo4XNNtC12UUwluJynQJpX69ZPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxHlCI12nXeVMbEctzvS7WxO/8uLRaRlpA6GwNn1+9Y=;
 b=ZcYzj7NVy5souCUVgHxeL58aNdquV8/x5gRZoLUZBUxisme9HMvCHiBHN4Pk+IWzsyQBnA/RCIViMreLFoottLYVL2EG2ZM0Ig8hfWMQbybrKOr5xVICd1acDe0YLsPUX20BrvhqfXfI45dCtWFF4WIgS0XongfIS+lFqXp40kE0vhOBtGNt4IKa7QcI/vYvzYDOxRHnI5ZL3/CuVPrhh0cFIZgjYin3jWJf3mQewklNNl7l9cQvIosJtk8tdMbpV+MZHmbExqvV6b6IEjHyQUcrTTHWuC+xQJU6hOAddqsiRWybqavb9+oKuErZqq/aCIhaFu5NIW1kdELN8I1Tpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0736.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.41; Mon, 22 Apr
 2024 01:21:07 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::a137:b8e5:8a0e:ca9f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::a137:b8e5:8a0e:ca9f%5])
 with mapi id 15.20.7472.044; Mon, 22 Apr 2024 01:21:07 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Conor Dooley <conor+dt@kernel.org>, Thinh
 Nguyen <Thinh.Nguyen@synopsys.com>, Felipe Balbi <balbi@kernel.org>, Johan
 Hovold <johan@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
	"quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v21 0/9] Add multiport support for DWC3 controllers
Thread-Topic: [PATCH v21 0/9] Add multiport support for DWC3 controllers
Thread-Index: AQHakt5cTCGj6o4U1kO+Ia5MuXnVybFzgPUA
Date: Mon, 22 Apr 2024 01:21:07 +0000
Message-ID:
 <SHXPR01MB0863AA6AE7B391F26EF882ADE612A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
In-Reply-To: <20240420044901.884098-1-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0736:EE_
x-ms-office365-filtering-correlation-id: 636e2538-c519-4436-6794-08dc626a7c4d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 J6IoKXT0XCmAwz39gPfxDeUmb4lH3UhO9oh/1633yqM9pmi7of4dM5P47FTBZyNO+6v+zMwshF8z1T5qfojR5+OYaenGLXhmfuPfo54HuNeG7W9Ye7YU9o6v6nd+byK17P0BMGHgq+9a8SZxcGRGPRae6Rwj0BRUksLew8uhpDXh650GmdyEvETzm7m3MqmIbyLpIC7yo3o8gc5mtUd2Ki+5Zppj18K6og2vO6WoC88HdR8/TTszjDioccJ+CLb9KxOZEUP/wNovPwtJ5GD4YZVyAf9cUxgh6CLAK1+afJPZd8R8NlLD/OA+Bvf3BcCZjD41jB7dj//LtU5ym1TxGXv0V50f85Qqighzqi87AQX9kRAgV2VvvETeOCeQCmolHOdp4oyQPhcA5co+XyJtZ+j1n2CO9z9uRvuRfJtxVkUyI3txT6c0gKV00QF+NyYZ8o+f+WiXiwFJWDdkxYbPSxyBx1mlrgDSxc+/e0LmPbwc+Hkm/AzgfUzqpX3miSwwNaSHgyvzEUruFS2GDwSho7x652u4f44kNdCbUUixbJU+UeYr3H+ZjqgkKaaC+u7yR+BcYl+YuftGnCA82NRql2wsFpaslSsrKcTlIQ1gkOSv87qdTkWpmqHQa2bbCpdIEDaxKnLXAkXaSZQ/75Cl7Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(41320700004)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QFNuAqupuMnInnESsjm7vCjx/ZfiLiMNtwZxm/HOd0Ow/tfMlQWRm5GNMlaY?=
 =?us-ascii?Q?F0FeLTBq+gGVwqo98VBo2aDax+wbziVW/5XFuKAofNw2v3P4e2guW3zYWdYg?=
 =?us-ascii?Q?OtTdJ2TklP1ZK/Cfvh8BdXmS0h2M3c9HGhoh0DLTjrIj99NeP4GFQQm0lA6c?=
 =?us-ascii?Q?329mGTEZUtPeJimdSKe5BZgQlLeayC9q7HBIwJ1+QPu1PIPrK7jCC6hN4IsY?=
 =?us-ascii?Q?Nni+Br24XZ4SueFBX+UvNzo0elBHIXkLPVjf+Z7Lt8mv1LVrZbLUP6oBEWWG?=
 =?us-ascii?Q?ITbOiGMxGR+wi4PoofZFMzWqxIggXyadt0Soafa8XwDgjmU4SrX4IMJE6NtB?=
 =?us-ascii?Q?pr4BkQMGuweBMcCOSZukDr+3ijBNGU7rzvwWPiVbK85F25VXme3rASOml4Ko?=
 =?us-ascii?Q?2mSIOv9VGTw1FnKUBjJJaCpddaPFU/yHDzjQS3OLaVsaK5nhrmC2E2CpUjwX?=
 =?us-ascii?Q?fgKrI62iv2NoUxBB8N6hYAVh5SWQF8Bm8f2W8M/BNOH8wm2iPh8DFm55gf4U?=
 =?us-ascii?Q?46MIBgXEQXQnc18h3anCUeGmrYv/h2y9I4CW9GJGOagvJNyCatUrHrFcCjeV?=
 =?us-ascii?Q?IfkgBTdzAmmvbg6kEWbBHXfjQ5SclZaiR5M351BjCCMQfIssJideqE2N5FVi?=
 =?us-ascii?Q?RaEINGcRKuChVK3zN27icQ4g7kuWo4IhsflXJEoS23K/wq4jCqKqSZHtHpjK?=
 =?us-ascii?Q?E5cyqP3gMuDZQMKviJcqvTfk2JEAaoapnDZl4tbBrJSOnvV+6NA/CzfrVr8J?=
 =?us-ascii?Q?BgjhCenPu0m45zHi6jnjSC2/Frc8zcYLMzz0AoOQ12Ach7lB0o4LdEHqVb4J?=
 =?us-ascii?Q?8xMAYkGgg3KV0Wy6lJodGlqc0TKrCBAfS4u9piFHfsUZYusHlKiy3UEeQMJR?=
 =?us-ascii?Q?kEhOu76gM6pBOtCGNG/2U6HBj2zzD/x6wi3qE6qe9gfTrnd27xhxtSxeuQgd?=
 =?us-ascii?Q?JHQaXNrlD4dk0riVCz9SM/MV1SqN+wmTX9V+jh7h87+6O0fwu1JCqx0drwAt?=
 =?us-ascii?Q?CeXGHNlHeg+UiGEZgcMctEbmcc+u3MX/m0bhW9rG73U1uBrToQaUp+kwSQiF?=
 =?us-ascii?Q?76OrCfwIWMPl9/aaNqSSW99JtMPPm8RsHWypCihfBgXLv4y4/YR0oe6Aymwm?=
 =?us-ascii?Q?DnTPCABCz9+evjAkUU2LqHKFgqMCru3sjKzTF19UREZ+MC4G5xh2kU6BwrgW?=
 =?us-ascii?Q?7ttwBK6ylHAljXpvU5u84YvEp0dDVB9VGJGb0P724dOP2SjmcvuAdMPKo8it?=
 =?us-ascii?Q?YQXwYDV2ChXDQhC953vMKKKS9L2f27s6ZUTqvQJckRukNx9nByU/eCeeYYYt?=
 =?us-ascii?Q?BU9q+1OpN2KzKez3UCWClCDNd5ZaSlYJAfMs6YJmL982ds1W16XXF/Wbp7Zk?=
 =?us-ascii?Q?C7uGZNXW9zmCMa2OJrtjKSpioE3Gn6gaBHMVSFXRV+zRo6rb/M1x09lWBmev?=
 =?us-ascii?Q?A3A38NNkYF2nLB3HdHAJAPwLEnfkg54+Ed86bWQgwy/8CZxD9XXxxC7ucu8w?=
 =?us-ascii?Q?ahgunKBXg64yvTyNKc6pbDoaDMo40oirQJELV9bkhHB6MLW43nsU/5ma4Qoa?=
 =?us-ascii?Q?A0cdsNYGA2vTlT4b2NkGMftG2eehivVrGYkd8v9/FFWpnZC+czQKa07GqjyN?=
 =?us-ascii?Q?ag=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 636e2538-c519-4436-6794-08dc626a7c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 01:21:07.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rg02vXBpY1MTOBP0Bq//MWwKI6z+EYiq0wP9qYDKSVY814loPDHRUJr6Oa/sys0DnBoNbUA+ou1UMMOfQHvmaAVUiOz3KLRPI3uQayBDBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0736

>=20
> Currently the DWC3 driver supports only single port controller which requ=
ires at
> most two PHYs ie HS and SS PHYs. There are SoCs that has
> DWC3 controller with multiple ports that can operate in host mode.
> Some of the port supports both SS+HS and other port supports only HS mode=
.
>=20
> This change primarily refactors the Phy logic in core driver to allow mul=
tiport
> support with Generic Phy's.
>=20
> The DWC3 controller supports up to 15 High-Speed phys and 4 SuperSpeed ph=
ys.
> The multiport controller in Qualcomm SA8295P is paired with two High-Spee=
d +
> SuperSpeed and two High-Speed-only ports. It is assumed that the N
> SuperSpeed PHYs are paired with the first N High-Speed PHYs.
>=20
Hi All, Thinh
Can DW multiple port host patches be (patch 1-4) accepted first?  Other mul=
tiport
vendor will use this.

