Return-Path: <linux-kernel+bounces-156574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFEE8B04BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76836B239D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCEA158A22;
	Wed, 24 Apr 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="XMEL7piG"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED60D29E;
	Wed, 24 Apr 2024 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948590; cv=fail; b=VZKwhxYHc+7jjH+S6FCxqt/riXCD11iKAghrpccnjk2DuqhMnwRwwWeASCT6x0tHLCscT+UIfifMGAEryPIf3GjTd6iOkEfYpa/T4vh1DTNbm4LznDT5gJNQZ0RgS6O4i0plD4GtUYk41ZnyaJDErn6eivbv9pSN5fW8eOU4kHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948590; c=relaxed/simple;
	bh=Ygq7oTPuF6G0m8hmLbkihgdybSHUR/1hNBGHrXOzSn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TnBHnY/RfvMBgf9AOsOzO+xI6pgpKshXEyBXem0WUI7y463BmKY4RzkSCAf8d94MKhLRORsuA4SCbWRS9tfbetCpjZXiVM2aFkOsx1Remanw1kIwrFUWfT2MxGf3H3OyBInpdcdz5c20uXZMuLnAOWaC4OhtmQenObjAkOuvPME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=XMEL7piG; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O8VvWB011632;
	Wed, 24 Apr 2024 01:49:31 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xpxn181j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 01:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz/g3AEPf8i2tKab+wLUM5reA9EPvGLtRgol+Sujlb5HowVMySrrKUEZqWX3TnwViSxm8chsX6euarPIPHjxPpGVHECs6k2TBwlKcQKMcVPeb27Bk70s5gbkjqZ3UkrOfnnfXdqLU8HVmwlO2bATXgKdON4VUK0QnOOExhEOI6so8RE0OG7OBLyZGNombjeVFp+xhsX3tKlbG18nlxvyYjNuoWIcmw30x408S6nSNv82Z4pqgnWElzz5VmyzX+8MvV4vXjz8cjKT4aBsQ7UJtvHKAKO34y+HLXKryLt1s1/NTU0CMpxJ8F2imDZ1dYJ0hgZpPQMlW06/1tFSiTJheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HepDfEbXVy7cf5oEc44ItWM3gxVLfLcoSZArE8YHjM=;
 b=LtaNACY4Ucjm/WNvHfqdCX7KNvlRQTXigPJZ2lOEvnJ8vO9oMvZCFajYjLmSMt848XOJNwHlMWl1RsXQooKQT/atMP3HFRHGOHLhcqta6YxqwhO11pfj6bQUlBKtn7Z+/d3dYMe+SM7ULFdM9JhLwgDzHd/saQG7/eZD5vsNWOtqMho425S4IZyWh24ONeVqsfr6YIMEWxsz9KmZerw3dUIgPmF1xF/tIA35ZFczJBQr4Lt0BumqdBDXShm9PQdEv/IaDBeq6GFFO6kY6sDbXDKWQYM2/Dpz/DcvbIGuilAHD9wqxFBAPeB+JhyGZcFxR2EUPYUE2wiJc1FGOi3msQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HepDfEbXVy7cf5oEc44ItWM3gxVLfLcoSZArE8YHjM=;
 b=XMEL7piGUVucUb9rJ75CR1cl038xjKFzaTJOEjMk9fuhCy70S2YQs8YEbjTcTdpeLgPnrQGn119NurJzgleG4ExJnb+XixTID5qNzsTGJcjP541bvkHOZ7buM0qtLI6N8v/jPEf0jb4kR5rjUNUlnbFYAAuHPzY/oF7q9jKlp+s=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by LV8PR18MB6345.namprd18.prod.outlook.com (2603:10b6:408:25a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:49:29 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Wed, 24 Apr 2024
 08:49:28 +0000
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
Subject: [PATCH v2] net: usb: ax88179_178a: Add check for
 usbnet_get_endpoints()
Thread-Topic: [PATCH v2] net: usb: ax88179_178a: Add check for
 usbnet_get_endpoints()
Thread-Index: AQHaliRRcDo5OyEMNEajq5TWcjfJPw==
Date: Wed, 24 Apr 2024 08:49:28 +0000
Message-ID: 
 <PH0PR18MB44743F344613BBD8D3E8398FDE102@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240424065634.1870027-1-make_ruc2021@163.com>
In-Reply-To: <20240424065634.1870027-1-make_ruc2021@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|LV8PR18MB6345:EE_
x-ms-office365-filtering-correlation-id: 4c3109e8-5d0f-4e44-93e6-08dc643b73db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?O+Nr/JA14fNi8XmI7xjDggjyBXr3dOTLePg4gBbpKm9LZQwyR2KvnvPS1Xqj?=
 =?us-ascii?Q?aMQxmhfyM5OOnGCZxwnu3/1HXNi3RCQ049wGchTl3HfSKAUpCfrDWgNQT4XO?=
 =?us-ascii?Q?dghY7/4a7Uq/euDwta/n1xGqh4pVNCEZdoS2aLURJ4tftRf4ov+F7LX74kqB?=
 =?us-ascii?Q?xbztId0UI+mPlJbNLSv13bo3QlwRmbfIkdrmLb06kufuZLwsaugzjPI4V45z?=
 =?us-ascii?Q?MW1awYVUaDJIJx+mDKrjV6onCVOtB970LNvOXcH9IFRFDzCu1GSnxBvh8Rwb?=
 =?us-ascii?Q?6Lm7M/1voadogM/XS3UHGQULFjVfna8uVHeVIAsI2uC7QcAzu28e3Vd2PIiI?=
 =?us-ascii?Q?zn9ctXesDhjyCB12l5ZyBcUYNvEHdkVmvCipjYWxNUBwApjl0S89WK0yoG28?=
 =?us-ascii?Q?qc9D5qjdWRAIC4jPIs7GQWvBKbaxCUKH6XpSuAPVtOwO7MQQt7kBafgIh3M5?=
 =?us-ascii?Q?4+bhzARLzV9WXdxeZvO9Ckrhxt6BRbdsyE9Dq8Dt4oGljGSnG74qKU6BjKsO?=
 =?us-ascii?Q?Ah/MbbHl1BeTlgkwRsOG4ojlfFDJz0fHV/mSwTQcQ2cOXFHj+vk5+6dR06uo?=
 =?us-ascii?Q?Lbyr5S6yODEg+zz2TXC6juWCrsh0IPeRyo6cqjNsRwxQDwXxSLeA1uS0zY6n?=
 =?us-ascii?Q?EJxlecQNjH22po9vwfrC9oW+6jX02yH13HcSwdRW/vlcRpoB0sLHnzyMUfiv?=
 =?us-ascii?Q?ZD2V3Fkud88rshK3UWHy0J1hW+vUKBgTEM9HJVKmcK3unmdBP9eq219Ocu3m?=
 =?us-ascii?Q?sXTGqXPcpjyCwNPtqjyuqOzkE+cWKOUeS4Wv9AopKePPTtcG12oOo/9ih3yJ?=
 =?us-ascii?Q?1R3DO/vYj9Zt26AnQYmHUxB2iUnhpnG+MsrHE0879LTK24K1K1aDvY4EUcyg?=
 =?us-ascii?Q?B5KKdEjCL+RBwcWw25vaUvlgvE8m5QKdUUnmN/jH6wca96mMzh5vP7DEHBw6?=
 =?us-ascii?Q?CaqlsbfzJAdEgsVJpBk+fdIpU9AS5OLDL5i8gA0D83p+5P6DfHLKmCwMHqU8?=
 =?us-ascii?Q?HAxRLSuzN0MWYuzMAWGAjNwIteoWVPFbynHAgGHMKeKMd6DJ65aQEd6oxXPg?=
 =?us-ascii?Q?KrGlNmoDsCX0nfH4AmWmtXmDPA9F43QS4k7CC/t4PoR1dzamzf8EvDnswXwt?=
 =?us-ascii?Q?wVNupP0W9oK5EUctAndEoh76NFyKjaXx+s7yaOnwsnqn6sW0dM9w23T5dXyw?=
 =?us-ascii?Q?VS+BeBTjBzPIU4MQHnz/Ejt2t2+YEfkOCbwkfwfBeGclNJ4t74gBuV6y0anZ?=
 =?us-ascii?Q?+Q4NU0Kn0ktKIV5I9ICdWsnNqNBqNpAOLfHhGIRWIpD9sFAV7H9jr2tqJzgf?=
 =?us-ascii?Q?ug5SM3k7PgRHA7K6tSZqQw2SuqoWah+Ys14GqQrjsOQFIg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?c+OHRP+uE1h+jGoBxpdP+ks6IQgBLGX43Ren81vQ+PZI5miugD5JPNm+9AgR?=
 =?us-ascii?Q?sXdbOibqK/6Q308hXBdTifgyNDTo2O+/iwIxxDp99f7F0SFDTXpTow2CU0Uu?=
 =?us-ascii?Q?2+3X+WkuxtCQaSKJIFcqx+7lHXmT1BTQIBDixH/7MczyVDZR/cutxDSVJCid?=
 =?us-ascii?Q?4xkEoqnad1FHwHWVUOzxOw50n6Tf4QMP8kIaw9wN65RR86YUzsCAjEOlh5bI?=
 =?us-ascii?Q?YfP2wtQ/OpduCxyBx1lWAIfLVS6BpihD+12KHcPavzm0I7NzBh8YtxHjK23x?=
 =?us-ascii?Q?Lcvupci9iKgNDygiVtJcEsHLi8COnO8Uk20jJRDcX8E+3H5CdRDZgueawAmy?=
 =?us-ascii?Q?MdZwImIu+O+/FkfG7ksC1a4Dqo+yAUN4toQKRusTVABH2wUXXLjMbu6UELMH?=
 =?us-ascii?Q?qS1pd8CDv/+cRXceYmMRVr9NK+JEMh2yK/EOzfvFov3mvP32qviRKwIP6e3h?=
 =?us-ascii?Q?ix4CPvDhjhqZn1XKpX606QogvGfxHEtpndcXNISWcr5Eg/6tuVuW5/luc94y?=
 =?us-ascii?Q?QnUkDwCDZybsaobv1CtnfW0EsEQ62oTXNDaUwZ7dswieU41CYr6asgy07aL9?=
 =?us-ascii?Q?ohiaNqhEm73U6LtpoeVTICFyD7NJqihfPWzxe0S9XKPuSQ5DBsxpKa8zOVD+?=
 =?us-ascii?Q?tXxs5TYrIfkp04cereHKs15ykt6N/OzFXGjLUEgRs8pEx7Gdo+iLIOhhU9z6?=
 =?us-ascii?Q?19DC70cY2/jsiPqrne2LA7ebOFxbuEJsbRf9bEJE8aGHq3Sy5frsrJ4diXM2?=
 =?us-ascii?Q?f8lkEUdK/SzlgqM8YzoBDBu5MOTRuDvetaqbSU3W6LIYZSv3Apj+ixyzcyjo?=
 =?us-ascii?Q?+9669oEp7qsVDNvPV6SkaFxAYon8NsmcVpWv6+U/lfCmgm05ZhMDtReSLY7k?=
 =?us-ascii?Q?HZSF22VzEZTUTZV3if+44yk5YBLEZMAJZl2qIREMf4uht5KCNwD/fI1p5gQl?=
 =?us-ascii?Q?m54OV8mrmsgoNf1jD73BeQGr1+4PwHFP5AhqVjm9vwdXRH9zCEyUtrDOrKp1?=
 =?us-ascii?Q?q3h7WXaekQn3/6PcHNwzmkJzZQUZLWTZU1YPPYoGIatRnVNVOFYnuwLKXs51?=
 =?us-ascii?Q?NdFFLUsRjcCTSihcIW8GglmTrdbcD3UXerG48cOaYomGzCFOGFSgZoiQwJwo?=
 =?us-ascii?Q?b1Y5DxuM1zf16snSJtdZy2m9VauLtC4JIdwEBEog9buPMBXvwvK2zI/nDVJE?=
 =?us-ascii?Q?3Pb53wjnTGfcoqxHFs0h/OtgJ9McfSelwQDNBLT5KArjeaYw5CBJ6gawG1jw?=
 =?us-ascii?Q?jz3nEoC9ZVUmQmVyYwNZGWZo2CaR4EY40bGKFjOP7jW/bwdVK9zkhIKhra0k?=
 =?us-ascii?Q?iWicPcX+0FJ5vLr4nuq8OT3NWoFl8eKKTYga6exxYYfn+MaL/dccdUXQEICr?=
 =?us-ascii?Q?lhMh1F9mviHXspYSAVGup8F+ESO5cz4kAXb6Fva0JNtptgEVdr8eCNL5Vaxn?=
 =?us-ascii?Q?Ef/UDuc5JC/z27ssEYj5ve5H7aoIqa6NEG8fijlTi1YycA41OxVkUG/xi3Cz?=
 =?us-ascii?Q?gOEsj2DYT5d/q8CdbITeeQ557SJ4KVvRNn1ErcM+kNKn9lcSvG7H/Vipo+Ct?=
 =?us-ascii?Q?llsKjgzUSzqI/ek8QMo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3109e8-5d0f-4e44-93e6-08dc643b73db
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 08:49:28.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hazs87SUytDiHvbeDgFnxgtWIQVCAxTv1DTVe599qY/RqL2Xl9xa9NCgiiIuuyVVsriLbbla52orATsIpX723w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6345
X-Proofpoint-GUID: CxpAUFxRb6CWYJCMKbAn9wfOeu7aSppC
X-Proofpoint-ORIG-GUID: CxpAUFxRb6CWYJCMKbAn9wfOeu7aSppC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_06,2024-04-23_02,2023-05-22_02



> To avoid the failure of usbnet_get_endpoints(), we should check the retur=
n
> value of the usbnet_get_endpoints().
>=20
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/net/usb/ax88179_178a.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/usb/ax88179_178a.c
> b/drivers/net/usb/ax88179_178a.c index 752f821a1990..388ea178c91d
> 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1287,8 +1287,11 @@ static void ax88179_get_mac_addr(struct usbnet
> *dev)  static int ax88179_bind(struct usbnet *dev, struct usb_interface *=
intf)  {
>  	struct ax88179_data *ax179_data;
> +	int ret;
>=20
> -	usbnet_get_endpoints(dev, intf);
> +	ret =3D usbnet_get_endpoints(dev, intf);
> +	if (ret < 0)
> +		return ret;
>=20
>  	ax179_data =3D kzalloc(sizeof(*ax179_data), GFP_KERNEL);
>  	if (!ax179_data)
> --
> 2.37.2
>=20
Nit: please include  patch change log, below link required info
https://docs.kernel.org/process/submitting-patches.html


Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

