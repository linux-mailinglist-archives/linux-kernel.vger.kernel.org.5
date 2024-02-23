Return-Path: <linux-kernel+bounces-77606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E79A860801
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B164B24058
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916BB670;
	Fri, 23 Feb 2024 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="I0jJ8eKQ"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2124.outbound.protection.outlook.com [40.107.128.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC848F56;
	Fri, 23 Feb 2024 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650377; cv=fail; b=pmBUdh8bSkmEqIoZnJUcyvmWuIXMwOFgPVDvJNw45s27q4RyN6slVorakCmQQWulDGsheFLDi4s59piQLK9x+g5WeEjzxiiUiXxeu2SqyQXBrQDx8iV3QBqEIw2EfePqMpvGGagBOfnquQklx7awwEiYPOIhVDzHJjYMa1wYBiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650377; c=relaxed/simple;
	bh=kzK1bD6qwYnbacm1q9FvtlVANC5PIrNWLnbpexiT3KA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XDDZ8h2E2dnNzoENHZkZXJTJ1YFcqfRKabRqGXMijjwMw8Rw+gUzoqywDsa/so1NRPti2KXfYEvqshs1S9+QdzKrIzDzN2Wh/tCsjBGEImWAZiJUEoss1hORjLCSgYREsgDWQlcBMOReSeZf3g+7gOs6iTf6L+ox9iIfR5H4nQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=I0jJ8eKQ; arc=fail smtp.client-ip=40.107.128.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/b2Gp+gNyVSI0LxEwgW4ixl1T7o+2jKDUILLyr1qMparHjssqJk0Ww9WFImox9aWnoHgqzLkJZO/zgTiseKf++p0unCqe90Wb/hjhSfZlpNlJXFrH1OFldAki3Vg4eDwpK02mmQmnl/Ww1YRfsZVz82fvpTtMS6Reu5yCbavYWaLrllgPmAmNt+YfAs5BS711jaCiEVF3OZss6qka+PVpD8dG9msZEPZvrIivKWFBmZwz2tjR3Dn8QKubq4vW8hydsd+IH+heOgF2Eax1yfm/r0qmOufGDvEIRvWC5vEH3TMupjbP8npRxNnfOh+dd8Id7N8MRim3Cl8NP+GQIKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzK1bD6qwYnbacm1q9FvtlVANC5PIrNWLnbpexiT3KA=;
 b=B/7LiO6k//gllzdvwAfhSHW51wxfyjlLyFC/HknbTNU3AetPV8d7cs/A0sZ4w/kRbOZ6z3h/4MMEqVd6YhwmLJYxY+rB1PzllmSeJG8N48n7BZnisjgK0LDqZf0/3qwYqtXvpl2/vr0FzFX3yEs9C8kN9898oN7QlXIIpaFujcOm8Tfx/2WfOVmkuhtJJiIYmt0roIOb6SdW33KFwXHZUujZJiumHMJYBWQuhvBWEwmyEGfn/rAgWXb6snQcbcoqVVL5REBxhSq71Z+Zrmmie236gizxBmNJKayymH//DiucR+py5ACDrwAHhOQQ9JVajuJyiOo09oqUtQoyoVMSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzK1bD6qwYnbacm1q9FvtlVANC5PIrNWLnbpexiT3KA=;
 b=I0jJ8eKQBgfhWcd/AIrcAAzmOW6iD8TkIN2o8A0oA/4vKP8J0wk7KaSZBwxGhFLCEZn9CIBkMI3RQAEL2C3l8ctgs4ovXp66Dk2zq4BP8m9DLoU+5EAAa38T9/S+AnLmjY5+OEZioZ/GitCXrMsqNhYjDKgcn/cy7NYvMPFrc6g=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SL2P216MB1868.KORP216.PROD.OUTLOOK.COM (2603:1096:101:fd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Fri, 23 Feb 2024 01:06:12 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 01:06:11 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>
CC: lafley.kim <lafley.kim@chipsnmedia.com>, "b-brnich@ti.com"
	<b-brnich@ti.com>
Subject: RE: [RESEND PATCH v0 3/5] wave5 : Support runtime suspend/resume.
Thread-Topic: [RESEND PATCH v0 3/5] wave5 : Support runtime suspend/resume.
Thread-Index:
 AQHaU+Uid+HuTFCkjUijNbL5+y2RebD/P2SAgBHQXMCAATtsgIAAegowgADy1gCAAHVl8IAA35UAgACpZjCAACRFcIABIH2AgABFpmA=
Date: Fri, 23 Feb 2024 01:06:11 +0000
Message-ID:
 <SE1P216MB130310210B09C0EBE3B901C8ED552@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
	 <20240131013046.15687-4-jackson.lee@chipsnmedia.com>
	 <efe24b949a60034bf618eb3b8a8ba82e8a5dc99c.camel@ndufresne.ca>
	 <SE1P216MB130326E2C4BA7E723A8955C9ED512@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <20489b01f1ac9ab3e434ea4c17b4e0ccd84afa36.camel@ndufresne.ca>
	 <SE1P216MB1303CEEF6DFAB5FA7C69D645ED502@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <d5546b48ea829316a8dbd2ecc27bbf05e70e8188.camel@ndufresne.ca>
	 <SE1P216MB1303932A0D3FC399179115D9ED572@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <be5ce95b023bcff24f53fdae55763bf4a3f6b1d7.camel@ndufresne.ca>
	 <SE1P216MB13038F3890F8B4597465B394ED562@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <SE1P216MB13035B8E53454881C87059B9ED562@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
 <060d634c4c707c9ed93f0d97816407b0195daace.camel@ndufresne.ca>
In-Reply-To: <060d634c4c707c9ed93f0d97816407b0195daace.camel@ndufresne.ca>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|SL2P216MB1868:EE_
x-ms-office365-filtering-correlation-id: a5d5d0bd-0678-4afb-5129-08dc340ba051
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CKSrr0SHTjw3TcuEnLDu/DlT3EUjWeM5iPVlzuh4XyM5e0hO2i/WDsqfCAktS0tudmGpIyvRcismxCJ5omwrGM7kPBdgVo8/ZJYbUAaBLpDLLxM6bJVvYiVi4M2alx4BlOtUJoW5Iraah8ktrqdhWiDZIR/cjReZaEWsvZgLR80eA7jY9LcHlsSO6/+ZRH52/u5IcYUhSswZxL/QKYzABOX7bG00oA6wLOMBZCJlpDEwFu4fIN5jwHyfSvRx7Kampeykmm0wNIWKXOctK7kRNPSPWZX7EYmHf7ktmv4jiWY7KwYjCYxje6SvAJd2XmwnxliNKqrkXWCz4rljW0NEc4ehhxS3ezWe4sgt+DnALifdGZL90zukiNukr01VM6fyk0IJVfL2bwAcfgX7cfjPuaZ3M/GVNM9jEEpgjhgna830nW4Gfzqg3JQO3bmYyRTHbGNkvlf/s6KQcQh8Il+yOtODz9gNYXmHBScwoFKhYfv01csSnrYs68sEgRw9HsWFQEZjPK9RCRbXkrf96XBJ1oBretFg3CVEuv+bRiL3P9OSj6yTqyoUI8WaHQwY67A+C3gfc1w+csKDddcUT7qMNA8Td28xAqfq4seg00uvhrI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mVAfu0bkx/0XvbpRGCltHvooMfNuY/ZENqscmT0p3bgsiUXZ9ngfXp2Vl0US?=
 =?us-ascii?Q?Hk7SMMhkYDRlJhGvnK3JDC5uRWMcCDGaWwex2rdb2j1Md8iiUJxe0cCBqSnq?=
 =?us-ascii?Q?YjuIRF3OG+V/nje833LM7XHCVMjxFcZKjk7U9nrjyGKEkXyC5+SlMlKaHYa7?=
 =?us-ascii?Q?q8vopvCsiQvXE3hYt5iByc0qbOFodpeDg31rkxNCd0S7hCjMxtaGZqwnJMq/?=
 =?us-ascii?Q?qrjLiZIzRoPx5d/rCUd6C7kJbK1nfbpwbFqv93RpKGYu5Wpy+wCN5v0tJJUo?=
 =?us-ascii?Q?nP46SwFZe6PXJ4wOmzs6DGYP2GgkO7jzpAwnB+TJeBAU/sMQBWo9pVyLfjO/?=
 =?us-ascii?Q?GFV5uWTNhdVLgmL8W7ior/KBm3xMFGNe0tlh5H3jk4zXnwekXKpKS/kYYnoO?=
 =?us-ascii?Q?xcuW8WibJf3G4viiDKq+pYSGjVE7guEQPDkpNg2cQFvwV6MDI5spaFUzU+/g?=
 =?us-ascii?Q?OKMJx2GgseYKIwNwU76+0zNGGqolUZMzDiZChrvuS8LD2+gERGmT6vKwzf0u?=
 =?us-ascii?Q?aketdZ8bNvLm3GrUIBM/LkKLnH6U3xM6vfiwPBxZC0M2hD40TnSaRqkzwqmH?=
 =?us-ascii?Q?4/qz6L8A55RH94/vZGX4g/3g3e5jcGTI2LoLIjnWRvQtVURItAZ0dVctTSIl?=
 =?us-ascii?Q?yspEiBbTQrLIhnJxLOkTz8RvbiEACDYY+LXX0LY9j2sKmn97KCTklwxRyHAX?=
 =?us-ascii?Q?gY5PWCecozrKom4Irt6hiGwrv6XaCFSovCQYdueJtOZEyeaKNP0UU+bXcOor?=
 =?us-ascii?Q?Mn+EEYtQW6d7eOegWH6PQAWLkiNB16T8obruBoPXBwRSrKDz1RV5MnK38Vkn?=
 =?us-ascii?Q?94Gdp+dNFKs4SvLgTYTIJHbCdPOn7mil0+YtDmKTtdBqJRD65NraJ/eImdNJ?=
 =?us-ascii?Q?IW8Le/T1VJ9SF3zXyovr3gpIAUTCL/AT1g2URTZ1Uc/e8qfBRMb3yXhvuxz6?=
 =?us-ascii?Q?UxiPv9s9CVBPDQO2AAt2Gks1D5WAWc1S1nx5zJC+59p8Prue4srgUaqsp7Dv?=
 =?us-ascii?Q?lEHRDZEBFdiLMIyY+pnDiWVrrDl7TOMLyAeHto+WW907WavBnmIniTL7BVlE?=
 =?us-ascii?Q?k9edMkv/Fp7GjYLRk0z+udlrkbcotxXYKLlwQpr1W2rHdrErTk5AD347YL3W?=
 =?us-ascii?Q?ZNpV6B3dR6qX9j/R6+TFTyDsfOjis2HARZKBvF4j4YrFsePnPX7KF02lQT5j?=
 =?us-ascii?Q?haKwiNXPsnI3c/UFioqbRmq4+yIdhgFyhCTDsXvrQndU4A2ZAY3WKy7e2hhx?=
 =?us-ascii?Q?Ufa0WJlyNev7149PICZQFYpeSv+FHbv/dEJGYY8hUCoFunrhfr15T7VNfyCd?=
 =?us-ascii?Q?5lcgl2nnHj8Zbr026qaPmY/4VG/n3w+or9w9AmobvM+MYcAOL17iq5QrH5mP?=
 =?us-ascii?Q?cjV9AmnJRBJSy5KYz+/pqSvqBDn9D5Bi57ZzjW/MMOSj8Weoo4OUfyJOL8Qk?=
 =?us-ascii?Q?mgOImv7EJ9Znhd0lYSO6/39k/ba7mFxXnJk6Uu5GN8vL1lhILQrNLbBNXEAN?=
 =?us-ascii?Q?M92IH2qSoVe8An+RcRp33jHwa/bZBJHFz6S3xBvSvXbGqKtQ1suihB8ZpMHH?=
 =?us-ascii?Q?3dk0BB1Ly6TwpUFY5uY5s4kvoKyQpUBynRuOieXS+EXaLtIQvxXipw0zSXLM?=
 =?us-ascii?Q?aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d5d0bd-0678-4afb-5129-08dc340ba051
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 01:06:11.8217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIfIRr26vfj82lbgUWdnU7zizvUx+4wqXAAGLhY67MobkdssVfqaZO/eJI2HTlnKqt9GGntOkp+eoMKqCEpdqHW64KnpLy5p2TfGUBSxXs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB1868

Hello Nicolas

There is nothing in your reply, can you send us your comment again ?


thanks

> -----Original Message-----
> From: Nicolas Dufresne <nicolas@ndufresne.ca>
> Sent: Friday, February 23, 2024 5:56 AM
> To: jackson.lee <jackson.lee@chipsnmedia.com>; mchehab@kernel.org; linux-
> media@vger.kernel.org; linux-kernel@vger.kernel.org; Nas Chung
> <nas.chung@chipsnmedia.com>
> Cc: lafley.kim <lafley.kim@chipsnmedia.com>; b-brnich@ti.com
> Subject: Re: [RESEND PATCH v0 3/5] wave5 : Support runtime suspend/resume=
.
>=20


