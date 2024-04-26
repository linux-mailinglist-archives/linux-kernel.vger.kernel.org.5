Return-Path: <linux-kernel+bounces-159720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB7B8B331F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09191C20C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045E13C3D2;
	Fri, 26 Apr 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="hSVw943M"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892926AFC;
	Fri, 26 Apr 2024 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120824; cv=fail; b=lesvOZptpBONKc4vqcWvcJngki5RqmEJXWXvEp12vBZy38475iNp/imTjVhWTtD7lif5hjQ5H+HexOhpbKPoT2AqArJnuIFYt8kZ7uvBFdKyenswgdpkxa4s1cOJn0ewrIcvpvOQttM6yKy5+iJpCrY+7eAFaKjKf+bYc/av8Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120824; c=relaxed/simple;
	bh=f3WndK38rL/bf9sq3/m0e7o5xxAQp8siVa7QYjOcn3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aThHlF2+1VtbVQ0MrNJ+qOpOM/3bMpGFQrm/7+ZF1TCjiBPUkyQB7Txw89H7x6WoIlW22bO1wbU4+OvGLD/sVBZ2zn60wuBxRE13EtzwKFDN0FORX/9y8ctEIRLhkP0tG4zFQZkti22UTwmdys1B/Xzo7glF3a5tROJ/Mg9qndE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=hSVw943M; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q6DFp4016504;
	Fri, 26 Apr 2024 01:39:59 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xpxn1n4cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 01:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYvVMH9OyLTZ2cBAj1HrENJbvvQFGQ+cLYOkKuFFAj1V0zyxjAt99GSAhhV8Fw6MFWQ0thmgQ3rOgzFZfvW7wUIML1iB7IJcYpoHcYo3th3FQn2e4KUOLdRcGdhnQeSXo374Ssb/SxLGU7jsXjk6fEKF9RRmFumWYcQFsmBtN4nwIzNNLuLnlS58BVPPy1/jyha31KC2lQ5c4WgGOT/HyhAgTLgEv4DEAqEwF3XigAwoDa8kSmDl8TcjOgRSTbaUY4P1VpZDrNcnZ+rv7BbmRvwYWQRDNrAV3Kk/q35o7/GaJwW3rau8nj9zKqFUi/60qoft368ukvfoR+fMLnWwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv9pXVdN6HXSrcM2qSG7/ZGjbf+v61WQVt3Z+hIgKZ4=;
 b=gvXVmG4LzAhYy58FszGJ8IfEMAC51v6wJ+ee/fT/Z5GxP2TEQDsVNo1tg+GggTs+JEeHzujrwWwmjDPhBWSHkkQHAvDMpy98b6I/cdkZrT7SZdeoyTp7W7RMj+6V4NondTB3TWJNBvyr55OapWUO1dwKzjKIDStxPGXoTx5Q+1IJJSxXVCszMAzBihxVAj8A7fGxmULvbjIo42IjGw5c+gWVSHpPqlT+njT8Rbq4FSm0ODFJeOgWw6tShfus3wrCUWtZGP5T5R1VluRwpleMdGpJmym87l5kxziu6VV77X6FyGXq3DXeCcbnMau68bYlzBBaVrwutvMY4em9USWjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv9pXVdN6HXSrcM2qSG7/ZGjbf+v61WQVt3Z+hIgKZ4=;
 b=hSVw943MChmB1r7+PGb0IYCU2IJnC5Qs+88gjtvuROLk/LQw83w4HzNBFtFTEEwGi3xDGbV1fBmnuBYXkgNR2K5RBK9jY574cP53A4O7hygCNT7yBzQO8wHX/7oXLK20ECU6cL9bcEawyWen+5oR5CkVR9U0Ya9soUWjCSjI0OY=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by LV8PR18MB5914.namprd18.prod.outlook.com (2603:10b6:408:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 08:39:54 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Fri, 26 Apr 2024
 08:39:54 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Slark Xiao <slark_xiao@163.com>,
        "loic.poulain@linaro.org"
	<loic.poulain@linaro.org>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: wwan: Add net device name for error message print
Thread-Topic: [PATCH net] net: wwan: Add net device name for error message
 print
Thread-Index: AQHal7VPPuJz502WMUWsNz7J4sAgag==
Date: Fri, 26 Apr 2024 08:39:54 +0000
Message-ID: 
 <PH0PR18MB447473BBD688DC4771435822DE162@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240426080733.819633-1-slark_xiao@163.com>
In-Reply-To: <20240426080733.819633-1-slark_xiao@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|LV8PR18MB5914:EE_
x-ms-office365-filtering-correlation-id: 837e5f9c-5858-4c9c-eb7c-08dc65cc725b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?d+2oFyBw26xG9uRM6CEvb9whjLq3CAuGij+jiuDp7Ij6245WRCkCf7ybNxkK?=
 =?us-ascii?Q?sR1JrARBjqVCTiGQtbQFw5SAsrPdkQd9Ykzp5T1cA89CKSOu4NHPeGQOm/nj?=
 =?us-ascii?Q?QqjBsVi2tHAdl3EvXKSDq2u6RJM1d8C/0XtUjSNLY6N5kVZ8TJHNTzQnuiJ+?=
 =?us-ascii?Q?glydS1fXCHLzzpCRmFfi9QPTrXlRZFsBVJeGAkc0nMSkct0ZeOQTbwIsVj06?=
 =?us-ascii?Q?KX2izE3PiNXoVkHcEXTerQYiT+/J/8Tmc3F9FFg+FvavfcB2z7hUwxyQSmiK?=
 =?us-ascii?Q?fPLauqIhXFjEan+9nMUKWYFn6RbHeJM4Yn2Cm8SXXcnDSntBhQeUoOHxdGPh?=
 =?us-ascii?Q?XvmvWERIMrZrcd3wLIPnYU0zb2CPtwF1L05UZ6PcWOUgfQzfuHkuErv74WGy?=
 =?us-ascii?Q?JA1c2IyKhKvg0mQsVOrwTwSfMdgx2igKpOYn/cXH/RgaA9jNTSGarvjjRll5?=
 =?us-ascii?Q?F+4/W86L7JzvkxJVdCU0JuJgyEBfcf0E/qbXwoKDdrCvuXXm5YNEumPsnpWs?=
 =?us-ascii?Q?lwu62g+OTLE5j6+OpZUQqocC2z9KaIAWtW1z+Kcr5h8LZLgduz1WK9+pMqXH?=
 =?us-ascii?Q?fGkPgnnZ5yRZOPbX6RNZgT3JAWsCjkLFzqfIouQ0/Vh4tYs7XutbgDvFXJbB?=
 =?us-ascii?Q?deCaZRbpF5dYZRB8bzeiaybOErQrn7tVkpVuePEvxputNU0dANxzsp2AcfOb?=
 =?us-ascii?Q?QrFqKfFb64nKv8FwxwfCWiYRhuzAwRMnZleIetKJ6hG7CToP/L9xWn4a+TnP?=
 =?us-ascii?Q?EBrbcLPynvGqBqcAtzy53/IVrWrY93QDvXJw6HKa7yr+EM6wTMCdythTxu4b?=
 =?us-ascii?Q?bZ9+ImCEO6GZvzV50xk8LcGDyvtEZAkPdCmg1hzbP84TwXwgi3F8EwEPDwdY?=
 =?us-ascii?Q?Ezc0Hsmih9tpOrMjKl+p+JtcyMUbfS93gAzWKbU8SRqHXWFar6hHvOUImNws?=
 =?us-ascii?Q?OR/fWGuJ5z1HjKSSPuJJUV8lX5GRPq6hIL7tHUXeS+eLUiTr8Bw8eb77rrwx?=
 =?us-ascii?Q?RI3NjOtw7efG95xRuNR3BZw2uRZVMmPj8VIiVXqnqrYMWoA4VE5C7KUlovLy?=
 =?us-ascii?Q?Wn8glqNWirSC88YZLtQGjcu4DaxL0kI2Yj369ZcYaftmB+Q/wA6E/YKFHROT?=
 =?us-ascii?Q?2G62pFGEF2tST6sQ7XcWSGOZd7yKY6SA1hgWA1Mnag0jaolPEA2BtOMwsyDk?=
 =?us-ascii?Q?Ja/Kvy6P27PK+aFFNh+JtGVPE51/CD+hZx0x8V4H9NvEBpu35zSyYyM5nTmJ?=
 =?us-ascii?Q?V5b0N57G+b5HD36uUAWpbZvrVTsI4SJQcj7qyAl5qrJxNNCPnT1vW499SKel?=
 =?us-ascii?Q?U/dp53RCBaV1vP4GU7Itct2b5xrm40TeG+gxtoh1aJfTuQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?TB69PAsMzhz8uUZZAawDUQiQCMFhhRL+vThkc369GWPu+0EGlloI8i+7MKhf?=
 =?us-ascii?Q?UzUekuSYI4SELBYPtkJSKp+IqKQwBVnkg34ukaYkdfGSoNwSB1ZnGqwFqYLD?=
 =?us-ascii?Q?OvG0P5DZtn457V00N62leGV1zmlP+5WOs817nQhsXkeWznjwVf4Y1qxB+nfa?=
 =?us-ascii?Q?hxVbzbWxDAqCRJu4qCGeGvrn3JR3dBwFGSpIY2cOMuV9aQJsWdxXEZfALvE0?=
 =?us-ascii?Q?j8csEl3e0FY/FMUfwcuaFDTvuUsOzLFUXEKpkAMR0M12WjbxMrLkjDsDMyoI?=
 =?us-ascii?Q?6D903yIqypBL5buqZ5BFaqMKY1wvMNm4CsV/VlbsK5GlIT2QCrNkc+ULhU6S?=
 =?us-ascii?Q?88dESfsNWJRgoXG2X3Im/U7k+M8wKHGp4rTuOa23R5S9AW3sacV2SUARavr7?=
 =?us-ascii?Q?xKxeQ4Qz0DOu959eovuxPjbJtFEB73FJiFq4sMuSa2Ky59liT/7zwxIYe2YK?=
 =?us-ascii?Q?oaAcyGu26CSaXkqsBUDJ4IVzZIf+SPcFPjw9ZndBoS8i9zTJwrkeO3AkXUmo?=
 =?us-ascii?Q?/9z/n0PU+sE4j6Mdk4Hp205/T5Fs65HF/iMQHLNXRzeBIqXps19DhQPg8m3z?=
 =?us-ascii?Q?luSeIpGhOUE8HpeclWkqG4EeiB6yf5gN/eTUDTwC0PsMmDT4MW23YnYHI9S1?=
 =?us-ascii?Q?O9kR2nklxd75UOxDyAvoh+EgTbwS6s402UWck1X1xRW9TRGJV2C+3oP+zo8M?=
 =?us-ascii?Q?5BzHvNpfX0IJGXexRunbpMEmGDVi53pEhKx4/JmVcp6rzksTy+kFAaL89LPP?=
 =?us-ascii?Q?84fohlHZSUcAja6cnIEy1orKWMWyzp/vHdGK/OVPIl/tUancmXiYeFGfXg7I?=
 =?us-ascii?Q?l0ajHtbmGwAjtAw5+e98Y7tw91fmH69bEyhZdmAj2e89KPKgNNZXplsRsOUp?=
 =?us-ascii?Q?eIDyiSgPRMzwRgcJSoTu8wpo56J8qU+hu1b0xuh4S8TREj6ovFQxSxTSnFz1?=
 =?us-ascii?Q?jCuaS7UPexH8vT4J+i9PsoBlgCQ721Dhv2Dlk/XtGdlY1XWC/RRoQdGYlZI+?=
 =?us-ascii?Q?kq1y1jcDc3p0UFyQSLeteI7VAUvRIYxVjY0vDz6WpZlocrzeSHmms+2+RJY2?=
 =?us-ascii?Q?jw7QIVmrAJ4m/jUDz6cUpwQ/n7r278EHqCEgJFofZ67P9m+7HzmsRlUMGxzh?=
 =?us-ascii?Q?4nj09vhA6R7zHmwQCDLEImGrIKsR1aF9l+Vz9vsiwgbbQJQwtzwOPnvuY53U?=
 =?us-ascii?Q?5hX7NMThFBHJegFWJLbEe1bbJaBnEgn4O6BIvgqrlcJgv7f6bBNIs9jnAMwF?=
 =?us-ascii?Q?E/k2e6NAklwsoYl91pcT7QBJ6wOR9oIGQ7TGP/zW4OGN1acsek0JaO3qD5UQ?=
 =?us-ascii?Q?WBwJMYNTVPvfoa/KkPDHJoUGCx8oc2Lp6mi08ZC05MtmPOZUsJN0CKXhyjGI?=
 =?us-ascii?Q?o/hRKwe3JjR9rJbOeB+ceQ7D/StXHSv7O/WXmadCUkZiwrefLvsxRQVXKEja?=
 =?us-ascii?Q?0vlZGMLNkQ4pK7ZWFTuijCN5iTxXp+MRK+qt3BSyKgVL99o1nY+thAEazafX?=
 =?us-ascii?Q?sejyety/nVNIqsCxFxwQB0opeHOmUxJQOzCEAGxVtbBSR1hzfZoi1ncDHO6v?=
 =?us-ascii?Q?aNBzr/0kEsJKsJW+E/c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 837e5f9c-5858-4c9c-eb7c-08dc65cc725b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 08:39:54.5900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHT5w7ktfip2Zehe3j77cGSyyLeZ0GbE+oYPtNGst0jAEuagaYl800wGTFBLL2KK/gSoN22xUHcCcWcdZCVGZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5914
X-Proofpoint-GUID: gnEiDZnif9HKPV1lo0QXTQbT0cuCCGVt
X-Proofpoint-ORIG-GUID: gnEiDZnif9HKPV1lo0QXTQbT0cuCCGVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_07,2024-04-26_01,2023-05-22_02



> In my local, I got an error print in dmesg like below:
> "sequence number glitch prev=3D487 curr=3D0"
> After checking, it belongs to mhi_wwan_mbim.c. Refer to the usage of this
> API in other files, I think we should add net device name print before
> message context.
>=20
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/net/wwan/mhi_wwan_mbim.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c
> b/drivers/net/wwan/mhi_wwan_mbim.c
> index 3f72ae943b29..6cefee25efc4 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -186,14 +186,14 @@ static int mbim_rx_verify_nth16(struct
> mhi_mbim_context *mbim, struct sk_buff *s
>=20
>  	if (skb->len < sizeof(struct usb_cdc_ncm_nth16) +
>  			sizeof(struct usb_cdc_ncm_ndp16)) {
> -		net_err_ratelimited("frame too short\n");
> +		net_err_ratelimited("mbim: frame too short\n");
>  		return -EINVAL;
>  	}
>=20
>  	nth16 =3D (struct usb_cdc_ncm_nth16 *)skb->data;
>=20
>  	if (nth16->dwSignature !=3D
> cpu_to_le32(USB_CDC_NCM_NTH16_SIGN)) {
> -		net_err_ratelimited("invalid NTH16 signature <%#010x>\n",
> +		net_err_ratelimited("mbim: invalid NTH16 signature
> <%#010x>\n",
>  				    le32_to_cpu(nth16->dwSignature));
>  		return -EINVAL;
>  	}
> @@ -201,7 +201,7 @@ static int mbim_rx_verify_nth16(struct
> mhi_mbim_context *mbim, struct sk_buff *s
>  	/* No limit on the block length, except the size of the data pkt */
>  	len =3D le16_to_cpu(nth16->wBlockLength);
>  	if (len > skb->len) {
> -		net_err_ratelimited("NTB does not fit into the skb %u/%u\n",
> +		net_err_ratelimited("mbim: NTB does not fit into the skb
> %u/%u\n",
>  				    len, skb->len);
>  		return -EINVAL;
>  	}
> @@ -209,7 +209,7 @@ static int mbim_rx_verify_nth16(struct
> mhi_mbim_context *mbim, struct sk_buff *s
>  	if (mbim->rx_seq + 1 !=3D le16_to_cpu(nth16->wSequence) &&
>  	    (mbim->rx_seq || le16_to_cpu(nth16->wSequence)) &&
>  	    !(mbim->rx_seq =3D=3D 0xffff && !le16_to_cpu(nth16->wSequence))) {
> -		net_err_ratelimited("sequence number glitch prev=3D%d
> curr=3D%d\n",
> +		net_err_ratelimited("mbim: sequence number glitch prev=3D%d
> curr=3D%d\n",
>  				    mbim->rx_seq, le16_to_cpu(nth16-
> >wSequence));
>  	}
>  	mbim->rx_seq =3D le16_to_cpu(nth16->wSequence); @@ -222,7 +222,7
> @@ static int mbim_rx_verify_ndp16(struct sk_buff *skb, struct
> usb_cdc_ncm_ndp16 *n
>  	int ret;
>=20
>  	if (le16_to_cpu(ndp16->wLength) <
> USB_CDC_NCM_NDP16_LENGTH_MIN) {
> -		net_err_ratelimited("invalid DPT16 length <%u>\n",
> +		net_err_ratelimited("mbim: invalid DPT16 length <%u>\n",
>  				    le16_to_cpu(ndp16->wLength));
>  		return -EINVAL;
>  	}
> @@ -233,7 +233,7 @@ static int mbim_rx_verify_ndp16(struct sk_buff *skb,
> struct usb_cdc_ncm_ndp16 *n
>=20
>  	if (sizeof(struct usb_cdc_ncm_ndp16) +
>  	     ret * sizeof(struct usb_cdc_ncm_dpe16) > skb->len) {
> -		net_err_ratelimited("Invalid nframes =3D %d\n", ret);
> +		net_err_ratelimited("mbim: Invalid nframes =3D %d\n", ret);
>  		return -EINVAL;
>  	}
>=20
> --
> 2.25.1
>=20
Nit: since this patch submitted to "net" , add fixes-tag

Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

