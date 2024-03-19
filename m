Return-Path: <linux-kernel+bounces-107057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6F587F70B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30811C20FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E991747F69;
	Tue, 19 Mar 2024 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RUq8JWSn";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ckOqq0GJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC58446CF;
	Tue, 19 Mar 2024 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828034; cv=fail; b=DlEeH4KVFzwgBmELgP1TzBBIvAEor6tfqt/fGwcAfpsR0EW5Xby9l866JEs6CQ82PbJwBNoAkSZMA2r2eNbtjPVoXkrXzhC1T6pnKrct2SfZdjesJ+OnyOp3PxrQGqI/ajFrHayUDd+7ma3PRZnfnYb3Dyvxj1m9nSBiuAh4bG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828034; c=relaxed/simple;
	bh=U1/P4eT0GeMCt3qenxcvyS3FbL7tfXNG+tYtVYqQPWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KTUifHVTAoaMmGUYZgn2wjsxSWMoAI+SdpOg1FswEFdp/938V9c2WcNTfqzL/OM9n9zu9us1CoqJ/h948HrFbpmKG/R3+1argX0blbUugIuhdK4tWTNePAIzTh+Pl7mUDdX1bnubvJ6DlUBpVUHGIMJef4aiWfRxlNUiEKIT0wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RUq8JWSn; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ckOqq0GJ; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710828032; x=1742364032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U1/P4eT0GeMCt3qenxcvyS3FbL7tfXNG+tYtVYqQPWs=;
  b=RUq8JWSncbJsQb4GqNvuoBhrLOR2xN6eRvsDbwgsUcM8EK82QpHM048t
   PoqPxWGWDyxSfEvCmeGrbPtgngBLnVYtJAz+mCFo5yo/rIHF5IO6O5gGK
   bSCHUTM2fuChZhKlaMLvlQgk/ITLY64U/2d2I55rD3/Dbn/E5wiP48FbT
   9jW/DqCC/C78vVA6gf3qzQghNWaM1KgEY0e7HK1O8sv7LQ5NsnhRRwndo
   4NkMqPFgoROg8fdebVwtnGBmeQWz0yATJly3i2ufgJFCDPQZ1MbG+tZR0
   S0oNWxFUq4GX1m0rpPmXhulr2GgDWCg3pscZPN7pdAC0nHUg7x5h7k+KB
   A==;
X-CSE-ConnectionGUID: YcpnPzZhTPu2FehmpPt9ZQ==
X-CSE-MsgGUID: zb7SCIthT0iJQfZHr/m+Og==
X-IronPort-AV: E=Sophos;i="6.07,136,1708412400"; 
   d="scan'208";a="17793955"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2024 23:00:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:00:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 23:00:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h02so+nym6YcWs8RS7Xs+N5lUD1v39R8ExX/ssfZ2OyEov4okr5cnfCQXfmZWnRm1yrP1T5wt5k75dCY6Ef+GQ9G0wEijN2S05ER/VBms0uYdfwfecPXQMqszUu3Wl7lEDjP9hCwx503H7ysm2W6GCEsAtjyEuKfMTKq6aJcElkX5SWWH8NUgVUPo4pgXkzCfSBMVOt5AYyxB5L2/aMEwnFnuQ7WLZrJgfKH0+FizhcBS4vq2FIpLxhk5Eeg3Mh3gMlBnD2lsShJDSAyUa7nCC8KjmGkOMM6uSXiJ94h9Z0Wu7Jt42s4JXknnNK+7zo9FFjpfqXfYXzn1hjHrzuGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEov+DrYb0AlfVtirCVGZxJ5W5t8GmYmjI/iOXvdQyQ=;
 b=i+NTG5h/JeLquPvHiOLre79e2sbpKQwRz5Ggy2cc+3U2WmJbNA4YP6tgLu6VAnEw/YI31wDFqeQENh34+DihNkkUN8ExmfwjuKqClQqx9LgHfMZo5vYxnxaC8QC9+gcPj/my8WnaxGIK8zE/SRw3hkP94G16CdNxMqJky6E3K74SJ8FQyMfi8BiU1Fhejb7Ndp7aHFdzvfKICy+J6D+R/vNSzPr/1rdeR8QcoFxIYboGI7siAX5CSWcqR0T4X7AEhttsXS4SLuXY4LL/qk/l8RanT5o7hdl6sVFRrWUvO5IL589fC2IP4CnhsihFETBD4DoloqDlR8a4OuAS5fme2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEov+DrYb0AlfVtirCVGZxJ5W5t8GmYmjI/iOXvdQyQ=;
 b=ckOqq0GJX9EYlCOOTlvlxHw/cphoxH3S2dw3RcRqyMu/fO/d490t9iHfj6Ay7sivCpSrjwXX9gXK8549CM3ZLojyqbib5i6PkC1lyMLOrSsKWt3ZAeetL0AiLSo8nhHYhgKRodDJg6WNGrvbssrTOVf8EYSmjZBWbNXGBH+DZZ0Qk90wbzkGTbmiFNjC31k884K046fq/Fl0bauOljkmjDUw9ArWXLY+2HOWGyn98eBGYWEIc1urmEQeFrYTbqfeEnuTfN/wTL/qGUmSLyeW6Ni/iHX8RXdnDxu/Q5U1kf6w8CrpFP5mxPn/QrMS3yDD+5TTunEIHXb90rAm1bIQOg==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by DS0PR11MB7532.namprd11.prod.outlook.com (2603:10b6:8:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 06:00:15 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda%6]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 06:00:15 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net V1 3/3] net: lan743x: Address problems with wake
 option flags configuration sequences
Thread-Topic: [PATCH net V1 3/3] net: lan743x: Address problems with wake
 option flags configuration sequences
Thread-Index: AQHaecHQxa7+9A3Z0U+Frq/k0pXkjrE+kJyg
Date: Tue, 19 Mar 2024 06:00:15 +0000
Message-ID: <LV8PR11MB87002847609196ABF0D0568F9F2C2@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240319055110.764002-1-Raju.Lakkaraju@microchip.com>
 <20240319055110.764002-4-Raju.Lakkaraju@microchip.com>
In-Reply-To: <20240319055110.764002-4-Raju.Lakkaraju@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|DS0PR11MB7532:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fP6I0qzKrVcZ7abhMEOFiUs05wZBaFDZA9Fns5LK5HoyH5iQdpuQjPTh0VRBLRmPr5pBQSImkcbPxucL1VNwPHImHqhC+QlZlbEKjf1NN5RemwUfuXOmewTElX6X0DKSH5BRG0rUXhgsLRBO2lQYJvVZ/DI2S56dOsOrJ4bfD3+HimJ2X/u9BAX8gt2SNCogZnA15fg6k7dixvRGjv01+O39HCvrczL/f4F25vwAtSdAlxfVEnhQgfVC/YoJ7sdb0Yq7Tn4G2+Ep2niiX+2KRr34MX2Q/pG3x5cfT1G+FJQKTHLJslT+h5T1VV5+/mifg/gelA6tGdoxRTbUj97xKkKdz3U076XcTM59MI4S8nLKVzpxzzq83OJpsBm1ksJkE3iFS/76BYQIRH2P3G+wS0XGGBFSUwAj3wn7yPex1JfMqVcblmBxWXEZ3i/Wbb51AsNwmRL5SC/4dCUVl2k1SJYAyDyOk96UBXiO5iPrb/Z/qjtugKfucRiX4yw4Mt6fz77TOVNQYTWAYU1z26fUDhWE0XRLlnQ1zWxapMuDP6UGaJXK+Y30IktiC5H6VFBy54g5ir7oHQZjF+gvZ8Ilr1TVVwaFn3qDjZDWKWM2lxS0EiCy5u0+1nyEVMima8/SeEv4hqV6lwwtGeIGsAg/Hm1MEbnHhMlU+8vVNYRKoJ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+7nzg38Qh6RMBxb6MHzzUpJu9/q5a56d2ZRrj9VdrvZpNLxD9dReYDQXNjq3?=
 =?us-ascii?Q?fGard9JJUbMA0mw+7yljYL+pXC1wwww0qmmRwUTar5YupMvfz8mFfshS7B6B?=
 =?us-ascii?Q?8QD3M2rPEIvHsroIbqIEQ9/CEPplrIBGuGQhHrcviP+hTSmqPGHaP3KlI8/k?=
 =?us-ascii?Q?lv9J2abKSkOrKswD587hqRrkhj86b1su1HN9LEP38YxNPU8RCGTY34oUNZGy?=
 =?us-ascii?Q?JvVJPuWTmAq5S1N1hNP8Vgi97yfW2MzVCiK+pHXuNSf91LqLBSE0HRWmjjIb?=
 =?us-ascii?Q?iRgpd9Tz8VUiGbcDqtkF/FC2rL2mSMNzo1XExCse6c/9KjWAcwYP1RD4zHdg?=
 =?us-ascii?Q?CDGGZoXrKtSlhsuNmGmy0vBZBKefu1oK32EoX/thZjtRiDEja8QHPN9FCe/p?=
 =?us-ascii?Q?R83Rv1pkZEdwLWxaCCcXyceaaOxZ8ORAcZpLQvnRQyNnOLf/z6eGi0lUk8Vb?=
 =?us-ascii?Q?ow0Qes/FJBEvvntYsgif6rTBwpLzbmW2NuWIcU+8xSJU5bvPZFB9NTFnLOLn?=
 =?us-ascii?Q?CVFy82uhtgotcvA7buiR9LkpWetg24qzvcgGdVCqKJ17MAw1g3LJySPXP2z9?=
 =?us-ascii?Q?2NDkNTdFxARNmUvNew6IhzLYOzA8XV+OdJ4AKMxzNTHe+hzdyjmJMPY+iJFL?=
 =?us-ascii?Q?XcevgmUtBRezgiPgABSglajtrB2U3ql3a84hmcFxWzBVyGLvmWncHEMl+31A?=
 =?us-ascii?Q?fNG/Tqp66Ky1aagIRhD32EbZQRBSzQ2GPSFwoYYsnUi1VVTZQpdhlwJBANth?=
 =?us-ascii?Q?X4KbrdLUr09Tk8ZxXUCDvPAMU7BZi4vTg3B8xXJAIx0V4oPVz+Dlo58M1X/0?=
 =?us-ascii?Q?pZ7PLxXeZ1Hr/L7YrxpTJvWu6w+bMBIn+0itsZ8ppE/TIiblR+iHsiDwFeYZ?=
 =?us-ascii?Q?a63qpY2ok4YemUCopJWshPbHiZtLC03fiNmcowTE+jG2RG15lA0YdrIs8Kgw?=
 =?us-ascii?Q?KYz2Z0ROv2Bw5SCQel1hQBSY0qDf4GwaV509bdjSNSM24Kd8OETlhTQ/fY3y?=
 =?us-ascii?Q?oBwbxR9YeRGNpoAiGW0IuvFn7RoEgRO2TAvZnNaLuZxTpMtLpa0w/gqUHIBZ?=
 =?us-ascii?Q?TVsWO6YOWUac6jvyVegG1NbN6yJ100udfJvSDaUT/ClEo/tw9VhaMTJKHIig?=
 =?us-ascii?Q?7yvmaatZrOLwZ8MGYjOqbB5G8XfMVyJcghECLmSgVERii8zdqyv25GAGrjer?=
 =?us-ascii?Q?cd32TiV1B77OeaOae6hbWEkj7ak9jSjmoK9Axz+jsT2/jMYOKXWGOFBn4FIl?=
 =?us-ascii?Q?fj3xbAHsfXpPnaFKdtzyHlqToHKElNCT6a6sa1XTYTGwju+dgby+mnanhrGJ?=
 =?us-ascii?Q?Nw2NziHzeh9WIex63MQZ6oDze530vXjmUc7owPymzWk4UrVyLwqaAlyIF+rF?=
 =?us-ascii?Q?mwmOvbX/4aJZ+x/ZCA0j1UsUp61vvCR49IZi7staIJ4bVIwARogal1zg2UJc?=
 =?us-ascii?Q?srXcxvcL4xDpanEzPADkDN8x43rVeNaVTH0ON5+jiZQNfG7qa4d8XiZkZPjm?=
 =?us-ascii?Q?kGM5Nuegyu+5tZtoLKvP7X/noBVopXVtfcrpjuWvI5cMfjNw0d0+VuiMtMEv?=
 =?us-ascii?Q?aHnf6cXy1iA4jVhDjWnvzgM1TbIJziXR3pc+zDFfXbVSWo9AskCLGH8K6Yr8?=
 =?us-ascii?Q?yA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f436ce-8b22-4cd7-6df5-08dc47d9d92d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 06:00:15.6496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUleY4OPn9bVQN7ozE0jRcQnkTLn6gHVqSq1MCsWhoZ9QJKZeHtYMi2hakYN/VXF87DU3Ie0yYuRwqh2u3xfLAiIb64OFSQ/xxV5+yof+YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7532

Hello,

Sorry for inconvenience. Please ignore this mail only.=20
By mistake it was not out.

Thanks,
Raju
> -----Original Message-----
> From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> Sent: Tuesday, March 19, 2024 11:21 AM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> edumazet@google.com; linux-kernel@vger.kernel.org; Bryan Whitehead -
> C21958 <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>
> Subject: [PATCH net V1 3/3] net: lan743x: Address problems with wake opti=
on
> flags configuration sequences
>=20
> WOL secure-on and magic packet configuration table:
> -------------------------------------------------------------------------=
-------
> | Ethtool Ops     | Send magic packet | Send magic packet | Send magic pa=
cket
> |
> |                 |                   | with password     | with wrong pa=
ssword|
> -------------------------------------------------------------------------=
-------
> |WAKE_MAGIC (g)   |      wake         |     wake          |        wake  =
      |
> -------------------------------------------------------------------------=
-------
> |WAKE_SECURE_MAGIC|    no wake        |     wake          |       no wake=
      |
> |     (s)         |                   |                   |              =
      |
> -------------------------------------------------------------------------=
-------
> | WAKE_MAGIC &    |                   |                   |              =
      |
> |WAKE_SECURE_MAGIC|      wake         |     wake          |        wake  =
      |
> |     (gs)        |                   |                   |              =
      |
> -------------------------------------------------------------------------=
-------
>=20
> Fixes: 6b3768ac8e2b3 ("net: lan743x: Add support to Secure-ON WOL")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
> Change List:
> ------------
> V0 -> V1:
>   - Fix the wake option flags configuration sequences
>=20
>  drivers/net/ethernet/microchip/lan743x_ethtool.c | 3 +--
>  drivers/net/ethernet/microchip/lan743x_main.c    | 8 +++++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c
> b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> index 4899582b3d1d..442c52aa0b0e 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> @@ -1188,8 +1188,7 @@ static int lan743x_ethtool_set_wol(struct
> net_device *netdev,
>  		adapter->wolopts |=3D WAKE_PHY;
>  	if (wol->wolopts & WAKE_ARP)
>  		adapter->wolopts |=3D WAKE_ARP;
> -	if (wol->wolopts & WAKE_MAGICSECURE &&
> -	    wol->wolopts & WAKE_MAGIC) {
> +	if (wol->wolopts & WAKE_MAGICSECURE) {
>  		memcpy(adapter->sopass, wol->sopass, sizeof(wol->sopass));
>  		adapter->wolopts |=3D WAKE_MAGICSECURE;
>  	} else {
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> b/drivers/net/ethernet/microchip/lan743x_main.c
> index 5641b466d70d..43e8e35fe9d0 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3639,9 +3639,15 @@ static void lan743x_pm_set_wol(struct
> lan743x_adapter *adapter)
>  		lan743x_csr_write(adapter, MAC_MP_SO_LO, sopass);
>  		sopass =3D *(u16 *)&adapter->sopass[4];
>  		lan743x_csr_write(adapter, MAC_MP_SO_HI, sopass);
> -		wucsr |=3D MAC_MP_SO_EN_;
> +		wucsr |=3D MAC_MP_SO_EN_ | MAC_WUCSR_MPEN_;
> +		macrx |=3D MAC_RX_RXEN_;
> +		pmtctl |=3D PMT_CTL_WOL_EN_ |
> PMT_CTL_MAC_D3_RX_CLK_OVR_;
>  	}
>=20
> +	if (adapter->wolopts & WAKE_MAGICSECURE &&
> +	    adapter->wolopts & WAKE_MAGIC)
> +		wucsr &=3D ~MAC_MP_SO_EN_;
> +
>  	lan743x_csr_write(adapter, MAC_WUCSR, wucsr);
>  	lan743x_csr_write(adapter, PMT_CTL, pmtctl);
>  	lan743x_csr_write(adapter, MAC_RX, macrx);
> --
> 2.34.1


