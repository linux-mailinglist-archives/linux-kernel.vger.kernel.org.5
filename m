Return-Path: <linux-kernel+bounces-156285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D828B00CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B495B1F24695
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18791552FC;
	Wed, 24 Apr 2024 05:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="W8GC4OTW"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2C13C82F;
	Wed, 24 Apr 2024 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935207; cv=fail; b=YT3qMuMZp5twurOZcs2Ur4jHTuk+0hr4qmzZptV7ockxgYun4k31mNB40P8nlE+9sVle/5VuFxz/toR/WQNq+9/9bX6Qu9a11tmaDn9oyuVzJ3lo35HUBSo9d19gytgWLYxKV9SPiiw4EIJSJvjZVm5Sv/Z+cJR5S4RQlr8Kr0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935207; c=relaxed/simple;
	bh=i0PY3rA6JBEHCIaV0CwgJ/FQqoq/xR91kYG3oFEu4uw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k+0kGRBTImb6MiHggnNDJTGWguF6vg8VRGcs+/jRpzupftgNvTP+cegp5ZKkUJni05+2CANZhWmWzNZJGbAb9MtVZ4Au7wqmZJWSH5HEJ62og9GVwSgJs4s/TDwwKzVRB26S7G7UjEeXocQjN234sxGjEzmTVsWnScz6PisZ+wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=W8GC4OTW; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0kp8v018704;
	Tue, 23 Apr 2024 22:06:22 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xpgpgtk81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 22:06:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W25HgdWM+frCylvIoo9gUUZs9Dz/WEuKFHc1CGcpoGfsvj7K3eoGTOMgQUNSuduscWQwincBv3LbFlyWnqc38qCtorcCU1/COqpwSrgbbjUT4PRwU36wtVZZLMr7iU5a8JcqiqsN9jXv1FFqpnytE2SjyMz34p2VmV5t1WDIURN/zbacbpuI/rREKbu3Ez06LVhDjuPTbk1AUWH8qVLnqMpu1254a4uq40tWAog6SvYo4XpNP2AW31c79etSRHaOykaa5L61D2XYZ0+2eGNdaOT5m7vVv5fIsLikoICueS+JPauryVYzGflNM+2OrVoIQymo1LGTR6jsxRu8VABweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YM3CgkV55Uq+JJuR2FgEUcWbrt9ORfUQ41htWKyN8T4=;
 b=RUdtgVPnw+jHxeqhfOCusASB3GNoCccdpnxJmYQwGRFDQZCybPMh772DKwUw9CL1a1bkC3poEk1Y33PWCVMhInQ9ESU2jWkZZL58ld6yLFkPb16WKVqWCPB1JuKXRGcXcBygEy4cjIl8D6SkwXEBHwqs53IkSIgbPe9YjiIJjlptgEOQ4JiMEgwuAFB+czmllMB8nWxy/h7xJASBodvxlG4v0Hato9Tj8K2eBlR7VQlacQuB+UfWdJ0pUqIuFs4zKoOy4Nq3r63MhZ/DC5h0AA6YYXn0wtCcdUhugv3iUy3ooXzogXhDI1lJbwIPqDw98zooTVKaX10GsYQs0RfHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM3CgkV55Uq+JJuR2FgEUcWbrt9ORfUQ41htWKyN8T4=;
 b=W8GC4OTWbAst4Xt2f4UTtcxScEYmtYXPSGwfS+W8cQM2mKrhZedRhfGTG5R6sGVgBD1ev3/PBWW6Wp/eNv0FmHerKNuwQObhYJ2d8MxTjsICp57gigOQljjwTBtARU2ObfEzDjOY8npgNjbYSrAJXRRT6sQZWBVq+NqGjlIN6V4=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by CO1PR18MB4572.namprd18.prod.outlook.com (2603:10b6:303:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Wed, 24 Apr
 2024 05:06:19 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Wed, 24 Apr 2024
 05:06:19 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Ma Ke <make_ruc2021@163.com>, "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jtornosm@redhat.com" <jtornosm@redhat.com>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "horms@kernel.org" <horms@kernel.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: usb: ax88179_178a: Add check for usbnet_get_endpoints()
Thread-Topic: [PATCH] net: usb: ax88179_178a: Add check for
 usbnet_get_endpoints()
Thread-Index: AQHalgUknx7HYzkMS0eaYian7Fw28w==
Date: Wed, 24 Apr 2024 05:06:19 +0000
Message-ID: 
 <PH0PR18MB4474AE468493AE97094D0002DE102@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240424011454.1554088-1-make_ruc2021@163.com>
In-Reply-To: <20240424011454.1554088-1-make_ruc2021@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|CO1PR18MB4572:EE_
x-ms-office365-filtering-correlation-id: 13a760a4-e727-4b08-0302-08dc641c46ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?MlNNBTFvbO3v3e2enkVcVDwA0JEc4ukgFkQ7xgkGFecGgBVo3I9syw61F3Yh?=
 =?us-ascii?Q?fsIUa2n//x7x0owtY0q8FByIGrLY8NxMT2e78cudcD2ukye9un17+DdIX0o/?=
 =?us-ascii?Q?ne0/GzSr3t54RcLiCtnGPIHl4WXQLLYAX3zQ9aAPC8qhd/K58TktWveJfxPL?=
 =?us-ascii?Q?dwmJVW33akyB/p1ZU9F274XPYa+BX+2RKDpeFEqIZSmi2VW0zFxn42fDJZvD?=
 =?us-ascii?Q?1ZSj3C6cxFUbayPVYHFDeJkKS6ehUL32HH7YLpAwoSFFChbCV5RW2AeLjq3L?=
 =?us-ascii?Q?JYAtQnLUSdkaBPfwedbtRlpboe2ZCWMjiZatG58Frw/kgatzNjWhJSTMNIXR?=
 =?us-ascii?Q?R3SEbrWQUw0mYkeG/7Qea3pRL0ewXzPQZydOC/LkvUd1EdDMZ/HeRDqRBzqP?=
 =?us-ascii?Q?nlZDrzoEuhX+v+Gx24cwcpwPX948K9eRW4LUtNOGw3eWrdhoks+94FAZtsK+?=
 =?us-ascii?Q?z414BG8erhSlqobJ1YvwAr0A0HaK+jEBGo4Geaf/Dqt9td7SPrGUGmSZ61YX?=
 =?us-ascii?Q?1wZwi9twTgwg8q/ta+6vhn6Aq1YJhsWdUUIu8WS65kxt6JPg7SDVaiRadwlh?=
 =?us-ascii?Q?NN3VHu0EUWJtUHlbRvkaJRl/zjLypWU9LOq19hqvmPAC0SkfKP4zf0YXYol6?=
 =?us-ascii?Q?eWQ9xYkWnJA9X65ISXYpAZHBmosD1OVc1fbM/xx0rH7HoQ5JwuvaS1MhbnSh?=
 =?us-ascii?Q?pMZrU/oMDFNGkT1b1lz4TEf0V8Ry3Y/IdIpgljpqQxez+mQQSRpTu5+AtfLL?=
 =?us-ascii?Q?2+bmX0wwL40EMCXK82Yn3gLn69Z0qELm7Bj/vVlzbZeiiiPPHzrePKSmBkcy?=
 =?us-ascii?Q?Mvpl/pTgP4u+YBhODHxWw3yldRU4YSZCvE2EXQwZJk7N94W+uoxcpiljacID?=
 =?us-ascii?Q?skVmiezpfy1MDM3yPzE4djtH6B0f0aK5nR0EN7P2AZzvjAbQ64b1JV8JZwhg?=
 =?us-ascii?Q?n0Ps+sGmPjaJhN1LEwP3aIFEq7H6wHJfYTBW1Ow4uT46mH94XmeL71CCvp//?=
 =?us-ascii?Q?pm1NMz+LqJkvsd4UJaxGYnycA2CG6ldyA6a7jmmRJRz480FA3K2KNHhENddT?=
 =?us-ascii?Q?cQodqM8Nx25+a8abMOpxR8QSzjn4mPXRuBeLx9CXpVtlfLSBwHUjxI6IlLRq?=
 =?us-ascii?Q?qWOl4Syj/wFGVW+iV2YJokgc18oRmLjA5XUqgAz24lNVgtMisbhKDOL1bR46?=
 =?us-ascii?Q?nNs0AX8GVpLj/t9KIhUijIRnpFOqfiREbvbc9OfkumKl7H6wsGK8QaVcJZ2Q?=
 =?us-ascii?Q?ABXthgBVACNGmWI3pCMvxwuo+08ZsvqFMR85HpoU10cxrGXrdGFv1n6ujEZS?=
 =?us-ascii?Q?0Vf0PhPuFa6wAwYnPvrQocu8EKbmbd5nK/cNEexWGQjzyQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?WJDPp5/shWxLojecQJvDCxtatZWhM3MfO519yFUAWhO/Hr1+h2irMjZ9EkyJ?=
 =?us-ascii?Q?aFcEu1fzVLwH1xrQbPelYX4yVzy/QyFAT7OU1tSMhAWjsCUSwLBBTp2Sc6Mm?=
 =?us-ascii?Q?KpbSJe6Ni2byRxT1UKFJ3uUWGkq/VEWMXmcc2FLVWplpgLLssUk1P9YkWTVV?=
 =?us-ascii?Q?m/BhZGzq/m0JnUccA2nD3vimNZnWd166MGee28aOJI1G6cHQTMaXcjpgcdSY?=
 =?us-ascii?Q?m7dIY+41xu7AeWqBRsseMwSM2YpReyVlGcN31KPGUnqpKyPfAKH5YyBI4EYH?=
 =?us-ascii?Q?QzIxoh4652VfmffWSJutL8QW5be4MtsyahYoqkDU1zsiVvEktutnuOO6EEWF?=
 =?us-ascii?Q?saNX2sMzRj0knhw1jvxz6B3oFZsikYMeT2Tm8EzCwzHgt8MdK0lurdOtF55U?=
 =?us-ascii?Q?Z9RmQauqNmAIFvpbKlg+qIrGIV8U88eCBZfqsqWIKHeWoxBaq+wmt+XgKwjA?=
 =?us-ascii?Q?pDw6x4lpHS2ewhk+RxXO5bIIFgIklF8cTn0kWKYxnRDNEIFVJK/OZ8FUpbX7?=
 =?us-ascii?Q?G5Wb0oOIfs9X0jY0PCGzAf+ng6IrSG3EMPjrIdFWH3nJmXVzvrF3GXPBYsQx?=
 =?us-ascii?Q?qvEbroAaJWFNmfmrHUkIrCm1sy/2PMU79sh5/25oWZM3s7Idv6cdCVAKbLCq?=
 =?us-ascii?Q?IYmi28gccgJRIwLyAvDnkHT58HLRMqFEQ6g4u17pqNQAelt/6KDoswHIIYbW?=
 =?us-ascii?Q?nqrYhGlCcAsaamBXsr2ftFCBEhUVT4QH1pJtpYVkeGes9TYMwE7Kx3I1DOTr?=
 =?us-ascii?Q?wVTnojt2g1YhAorV6Cp7gJY5QqMVh050jCeYiVcpmfnVqxorhpJqzM9OiDGC?=
 =?us-ascii?Q?B7o8TIFvDjp5JbwlzGbPHJA5O9mBlheNctWuuPaZNG32ySPvH5qs+aHamVSh?=
 =?us-ascii?Q?3QmNNQFeMxegFHx976MdycO8H5Yl9nhZYkIzov4tZG6RkgqzEbfbpvR6WiSp?=
 =?us-ascii?Q?u7yS+P1Yrjz88MiEDW/T16oFpDcWUrPUTmHbXTGPsenvLedCXmPwDtqF2xMW?=
 =?us-ascii?Q?O3cVLrVDxhFtXFPVNO69/JQ0nsFFD7rWKG9UcHBN7hBMS6HJh5R4mLoCiZzW?=
 =?us-ascii?Q?b3UFn1+0NoClF/nqxKxuVuOK8NPxamCv/8A32YnuTd+lA6I2Tx1iF3d0/XIu?=
 =?us-ascii?Q?vnc1LIoMsNdHxIRkb+6g3chz4SSiRXPULGLwa55gspxo2qEm8SxmJ6+eieXB?=
 =?us-ascii?Q?YptHvl2FyMTcIgMdfuanLfhA3Y+nHZOnZarpBFA36V6Ly22BhqvmYxpMzi2H?=
 =?us-ascii?Q?NbC7nDk3d1d4dSsHnwX9o5smr+WaK/JYrNHB/nZWs9W3gAgFzcPpaif6gc+U?=
 =?us-ascii?Q?p82h4GFs5ZUv3nWHvX3QdPJ+gidb5vl21ziizXhyCcaG8H3q3VBDwzacnxlb?=
 =?us-ascii?Q?lmIgEqi2aq0O98s95wThBgE68KjAdGDhnTJidX9BXW/8plduLKfvzmPYw5FL?=
 =?us-ascii?Q?G5IttxL+wILKKNhAKux7jqUMJIWnR+w82t3dJVHvEK0aGdT4rVrKx1BS37a+?=
 =?us-ascii?Q?VQLgCaCaUyyJYK2Cr04UjT9i7BNb1pdYkAZc7shHh8fq3FgJJ9cLsJqfUR2F?=
 =?us-ascii?Q?2t0NwxwVK89wAUkyecE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a760a4-e727-4b08-0302-08dc641c46ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 05:06:19.1274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDSQEgNkAFv3KLyZyDQlZimMSz7qPKqzookldZNnxaXHaWw9vZxHk0NkTHt/onSVaXnaj/Xuvbk+xos66sDd2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4572
X-Proofpoint-GUID: ma00HWd632RIxPpFC2-MV7z1-jjKEeH5
X-Proofpoint-ORIG-GUID: ma00HWd632RIxPpFC2-MV7z1-jjKEeH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_02,2024-04-23_02,2023-05-22_02

See inline,

> To avoid the failure of usbnet_get_endpoints(), we should check the retur=
n
> value of the usbnet_get_endpoints().
>=20
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/net/usb/ax88179_178a.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/usb/ax88179_178a.c
> b/drivers/net/usb/ax88179_178a.c index 752f821a1990..cf8d19584725
> 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1288,7 +1288,9 @@ static int ax88179_bind(struct usbnet *dev, struct
> usb_interface *intf)  {
>  	struct ax88179_data *ax179_data;
>=20
> -	usbnet_get_endpoints(dev, intf);
> +	ret =3D usbnet_get_endpoints(dev, intf);
> +	if (ret < 0)
> +		return ret;

Don't we need to declare "ret" variable. Did you compiled  this patch befor=
e submitting.
Thanks,
Hariprasad k
>=20
>  	ax179_data =3D kzalloc(sizeof(*ax179_data), GFP_KERNEL);
>  	if (!ax179_data)
> --
> 2.37.2
>=20


