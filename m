Return-Path: <linux-kernel+bounces-158454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B40B8B2063
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23DBB242C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F074E12AAE0;
	Thu, 25 Apr 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MR4BNzya";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y7PTT5h0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA112AAC7;
	Thu, 25 Apr 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045056; cv=fail; b=Cq+pcdomlIwN6M3dZFCEFcr7PTfn3Hczl4X0Y7+Ycw/0rNQCnnvOPxKWLOJQ+lpEE+Eb6H5N9cz5EEslGoJo8rHaFuDqYoUXG4H+Rsx2xzpDHcq0iaPMRej9fC2b7/BdzoaKdgYPGnMecxOA4doyX5sKZeXGZmX7WhPgYS2SOSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045056; c=relaxed/simple;
	bh=CNN5rxZQ5bCxdPwRoy7MsE9q+qqvTyOiAFFBQ2VdXq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rqe7lZZ5/WtPqz4hapP7DCIyLUC79M7AlZlI12pWRQ4s5h22DOMYhaC43eW7MpZVJy9CPLImhYQh/fMiIw//GG6ZLjduGXcf8LPEfNw7Xci3NMZBdi//2OsF1j1Q6Lrd7Wqix4sAkamDSqDxy+J0sFlGxDT+K7OnYK3PiUrZigY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MR4BNzya; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y7PTT5h0; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714045054; x=1745581054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CNN5rxZQ5bCxdPwRoy7MsE9q+qqvTyOiAFFBQ2VdXq4=;
  b=MR4BNzyablMhMa1jsN5kt7VeUgqk5JxzOJki3XQ6jHMw7K296kQl+kEu
   MVtx/NGFydgX1KgYCsjCexXB+P1HU4Ya/kAAgW/tRNhp3gQpmSLfSIebD
   AllGdjyAxIuDmyCvoii1cFRe3Aln0eEBTL7rDjgtSGgXoNb8zZlwOSuEG
   Yezs9eQcbHY0lHFUHajRStnjOULARJBiMYeGwFLU6tSK3qMOLXfhkhP9m
   07IakDS0at3n0h3PnLUKb8drRJp4FOwWGrCnEBsVqiQfC7u8OZ/sdKCFP
   V5yH338RKAEJRGMfjsVpYRK8krml9THPud2l+bGexjRj6PkJ3/kF7rfZm
   g==;
X-CSE-ConnectionGUID: aPrornjDQoeEPt7sDyuyTA==
X-CSE-MsgGUID: i2kXQd8uQSeLgZt0n1sjnw==
X-IronPort-AV: E=Sophos;i="6.07,229,1708412400"; 
   d="scan'208";a="23190034"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2024 04:37:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 04:37:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 04:37:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRDpRTo+IcJRr1C3rF6sfoCiq/NoOOnNSOTNoFk17v4n1D71wm+/HgEc33JgLMkfBg3IyMyCXD0MpiByUDQqMZhntynduKTRorvqpNONklDE36yK1/UkuiNLvkLiTpydiGfmwgEE7H/aN5/Q5BIUMzIHdSViLyaLhd7EmjgXSNqn9zi2vLYx3ZzJ1Yrtsuvkdef22FmeR5xFeikZtIXNVrb39dlRul1u1aKSL6Oc92uvLJgXchl2XYAUl5aqcJnxxsjFvK5FHDR96KLZLs/YN2bhb/wrQ9IHRMaJt75o9tXipJWuVtezUjTLkWxkbDW2cT1A+ulbPHRhHHsIMjKSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3lJlvlE5nDD26VCHDbuMlwEFLGxBSe1MkOFu7H9mzw=;
 b=gV1fW/txTv1zK9fd53aVLXqh9ZFh4gmYfu1/Kn0MiSdv41HVTV5WotUU/1PWmAglZCMxh/DcTu3pzS2/b4HiRUH2lhSZ8GpRH63cbNKwHNrF9KDqdOUiD1n6/JMrtV1/tKYnVh2n2r0mJZr3HoFpeQIehfyBlYI28eAXTN8XhaqV3iK8NQfVdjCrQTST2pTQ+A+SYsndBY0Ex8OmClsWRy+iKJHr+adidAfQFeUtI4ALu/DoSWzLkwLE4SdH00bPIOCZCJAaK2a3FdvFPvK/Wwg/5wfe5dIwjMF0Jn6e8Jig+9muxfDDdBODIRVf4pFrGtrY8bMCt/OWvShQkeQaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3lJlvlE5nDD26VCHDbuMlwEFLGxBSe1MkOFu7H9mzw=;
 b=Y7PTT5h0SvITS1n23gaY3iLiHsXXXMj5bwFxax2ZYj7+Lv9g0pLdvsmNS2HOY/0LBMBmScTmziq9a/3ZOCSDhLFWwEVAzlRxon0iezNQK32Vg2wYg5i8tFkGxZbwYYHh4582uiTDFDrOPUAhwpAy50HD8NcIunuUI2hjnF4tkHG4Fds5DJjI3fgIdLSvmsvqOlLv2PS1p+FAndqVYm/r39fhZsNECwD0OlHJIZxSJbYnYiAKebRYJDD977ikZS1AEPZlsHttq3txY/X2e9SoiOoagkrANIxAvgs9qLyD2DVwHhFHoYSayJ4/vNXceEg6l7P18f3T/oaF+RjK8CFdgQ==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by CY8PR11MB7133.namprd11.prod.outlook.com (2603:10b6:930:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Thu, 25 Apr
 2024 11:37:12 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda%6]) with mapi id 15.20.7519.020; Thu, 25 Apr 2024
 11:37:12 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when PHY
 does not
Thread-Topic: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Thread-Index: AQHaen5pA5HIVZmbdE+YwqVuzvYGF7FBPcYAgBgZppCAAKxcAIAbyhwwgAChCICAAqOYgA==
Date: Thu, 25 Apr 2024 11:37:12 +0000
Message-ID: <LV8PR11MB8700D54F5E03440681BF0D449F172@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
 <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
 <LV8PR11MB87003ABBCA98F00F3EEA9AB09F032@LV8PR11MB8700.namprd11.prod.outlook.com>
 <fb5a6f19-ae4c-443e-babb-cbbcf6ba5fc6@lunn.ch>
 <LV8PR11MB8700A34520EA2521BC5F59EF9F112@LV8PR11MB8700.namprd11.prod.outlook.com>
 <9c4f8fcd-ae95-4874-b829-d381928c5f13@lunn.ch>
In-Reply-To: <9c4f8fcd-ae95-4874-b829-d381928c5f13@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|CY8PR11MB7133:EE_
x-ms-office365-filtering-correlation-id: d2841c66-1888-401a-fb7d-08dc651c0ca6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?tkgRnLm2PwY3nvhnu2B9eyZrPyFDagtlvpX283Uz7exx2FMAgpMWZsr4CFbj?=
 =?us-ascii?Q?OjioqOzH/raRXkj5/vsq0a+O9RWENGpxC8HgsrBXeGWQOv1+5zTVqVjCD9BE?=
 =?us-ascii?Q?BgdfvTwIDBn1+ikpsC7alRC36Xmhcyw1mj3m6jzTPa3hvvzwixrqzBvmdAUd?=
 =?us-ascii?Q?kRUWKdoplRSDlm5dC+mUDItgZ/vl3thPvMl+kOISwPdBbPjOum6Vzi05tUwv?=
 =?us-ascii?Q?4Ev+KRQnUOGXz2UUeszXBTymGtTJrGkojOPsKir36sAytkm3afbgit54xWm6?=
 =?us-ascii?Q?CAR7LIxHa5ReHRZexh5vgJsPn9EeEfhZzlHfhU2Od3ex5bkh6bCcmm4MffhW?=
 =?us-ascii?Q?b6ADqDDD3gL4uNAKBRIYZogQSAioaORJZwLdtlDWWABODcJLWRoW0Zbb2HBN?=
 =?us-ascii?Q?UVKwhhoa/vyTGZTv0BDPdw2rZhSF1ZHUi3P1gH4j3ymygcOO7rYiPb/iQn2K?=
 =?us-ascii?Q?o29Gqhd9V7Z0qgg0j/TvA3VgcP8N5GRNsaaLr9y617vxohDyQjN7JY4d/KFV?=
 =?us-ascii?Q?oHvdWzrnhpx3iVIUZXh1KzFeqzQWFaFft4/918VeqW8NaMaFaimfD2U3SlHv?=
 =?us-ascii?Q?hZoFAu2ch36e8P/Y+1EVBP7ku76x94EkkEbiDvZFlHXUfzLxok70BE0x7IpF?=
 =?us-ascii?Q?TsDMwtcJj8CGEnEXWcJC+6imXxXQTIjww5S/uMWqPpyf3mq8P0QCj3IUs1bw?=
 =?us-ascii?Q?uFkGNf+UVF24UuUaBMSpy279E/XARrGWqcCtQ8/dTgKGimI7BtZeBgroEJdx?=
 =?us-ascii?Q?OFNTF9ZqBnXCJHT288jJuhnVgQQsILCkOUJtdE21ztJ3G8P1+R5L2xFBbyNg?=
 =?us-ascii?Q?/LtthaMqj3lBINf2um/zi2UJiEC+uoIJ7RF3/H4XxlzYpTgovxaH8iNkxCSs?=
 =?us-ascii?Q?RCOdl5C7Oy7pjJk9Dsi+EmtoGVbaRQ3r4RdaiMG8PgKMDfJ8PIUZU2Kou6fd?=
 =?us-ascii?Q?fpkkCaDl95B3Mee/v2rCUcGyKIS4I4SVAILhoROhG6NQv7gL11Lf+AFVw0bH?=
 =?us-ascii?Q?PPBLt/R83CvqdVpOkiWfs1TAC+1aBEoiq9034cnCp/3VdTU2vNo11TKzKFEk?=
 =?us-ascii?Q?w+ninYOm2hIpFT6kNmTwlLR3DjIceleiFZHjS2CC1qyYeZJJQO1T386AgJDQ?=
 =?us-ascii?Q?sb+6Q3Wt9WBG413kjHm6KqJ4YkMZG2oTmlIcx014TZrnhIReJq56cRY0+T2p?=
 =?us-ascii?Q?9GyuAkz7hfSlQJv7/ZjnkrXDPHDsJyEuUZEyTQVnM++BFtkjHPn9/6N2iaru?=
 =?us-ascii?Q?1OCAyi7OZStjPnrUtxV7qpK5bPxSucuuIdYBYXVavQNdfo37Mo4cCNK416ZB?=
 =?us-ascii?Q?km27NetqmVzzk8jYyr0ibbVkAryxo5ae4lDBNRVE66+2Hw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yky+1aVQKPtNLyqMO3s5t07Rx6thLx6LVZsXJznM67MznxbCi2/rKOCHTzSN?=
 =?us-ascii?Q?/MQ/YGK2JOZWOu25WuH7TIG8okm3WtX62PPVJkhKFKGkYlR75l+0bL5oZ2a2?=
 =?us-ascii?Q?5ZoGPPtE6gC2XzK6o6iikqo96Rayf6349yXtuocMKOKkOhshwoRFNN6Qlb5w?=
 =?us-ascii?Q?bcz+NZQgZXkUf+atLWVBQcmp2FzoKwVbEU5rXufMrFOYoF7mLZY9qxPYMC5m?=
 =?us-ascii?Q?u3/YgxfEsbgrWIzNFCeOPMDjg/r92wT7VXuYt/cu8CWfTfwvQYVy6lLH06bH?=
 =?us-ascii?Q?Knl9fKBg2gXnXGhDbae8T1SVbFvARdlNUMz7gFltxO/z5Ns1VKGRKy6mahc/?=
 =?us-ascii?Q?GlBaOLEiOCjOQNT61wms4BVFfx7t/ikfu5Aope7vpAogrp37GrL8cKAi2aty?=
 =?us-ascii?Q?d9EWWY+/fKaTyn84u6PUsQBsJmU3X5nf1JXYAAF7hq5b710FpDIHCV7Mh95S?=
 =?us-ascii?Q?dUba41p9VLFhN9l5Ggj8EmcNmqp9RhlgxbSdNViGJQBkDrqVLfckgM0jL/ai?=
 =?us-ascii?Q?BxZYmG9/rqPhDwnlY2Bx1qaelg5TREoO5q1/nSK4uY90LNSzLQwIjSpNJNbQ?=
 =?us-ascii?Q?lkYgr5opyRYCq+FqxaHOh/imipaKnhfaeVNxZo7/Evmp7hQZTXVdt8t4EbuR?=
 =?us-ascii?Q?hrPL9z8w/7bOfehNOLwNk92V/Mlo2vSjWTE2eSfRhu5wiAniFhcOIuL/4Cie?=
 =?us-ascii?Q?jjjkIvQLFMQ+O3E+ypMdXAWa132EQeZo7tckZsKtzQ8+TmD93pZvz7sVDBkv?=
 =?us-ascii?Q?CLypZX09jEmpX8oOLkrD/p2xbA1jz/6XOou4jv6tYgmYzSIh1UPXpD73OYzw?=
 =?us-ascii?Q?Ky4DpQl6re71YgEkAkjpohi8dblEAZfeX5YeMrcUpayYD1qEnzrxv5Azzpmc?=
 =?us-ascii?Q?Ia1VmYmnCaBaMi3Ikioh5xhIgnWkCG6Sr9pjUciffo4sqJuOcyjOsmkyLE3y?=
 =?us-ascii?Q?GA3gBgwZ0TO4XKZk1u+h1dbulsMJY2l55nUSkQ+RJHhXR9tyygn6odRLloGV?=
 =?us-ascii?Q?zV8koEvuHgwNGKNwZbmoRa/ASEgUISaVNpkwWLrXuW7H/h1TIOZNLibbVF2W?=
 =?us-ascii?Q?tYqDMX9XhgveAEEMMd4C93aDkNUz1LHYgFN8WJb0kyquVcCC9NePai1V5cwU?=
 =?us-ascii?Q?blVoJ83i6m27+0CpyGBKxngQ66EG325x4Go3466eHmgWkocL9C5ugHWR86ou?=
 =?us-ascii?Q?DGZXqE/+euzRcivL/AhWkUhPLTPYfsPwPbP812Z02MrPr7knGlCziJtLWSxV?=
 =?us-ascii?Q?zPMdVDu5QUlvTS10fHCRjFWr2c8Vac5xnigIRNWVs0dMB0kjY38KgUWqbvMn?=
 =?us-ascii?Q?dFH3Whi1K6Xn5UNm1pZTK+fjzmn5Kc119CWIUkzIVw1HACUdTYfflo3NpHVC?=
 =?us-ascii?Q?5mVX0nEgiZrYUmimixj5PCqvAL8JCe6knptQ7yLbKxwI7vW/DwCTBj/XdD/E?=
 =?us-ascii?Q?IEjfDi20v6VQuQAnfE3jmCJz16OJ3rfIQAlzGT7HwzncHcy7BoUmpIPtZhbn?=
 =?us-ascii?Q?dlw+MvVLHB8VUTzlyXCb1UM2E2iDn8/lMV1jRXy7PQLvsfmWlMvK53U3B8kK?=
 =?us-ascii?Q?jZy//GXRia1LWw0+OKux7/nHlQqy/Ot9KRbaneImPj3UMDjF+h0H+P19pAxE?=
 =?us-ascii?Q?mg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2841c66-1888-401a-fb7d-08dc651c0ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 11:37:12.5173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVRiW7XpySkuIYg0pgx0+vtSg3faMiCThnr1IOQL4PXaeCvXiwn+QEPPKKq+UammplA6LuxfYanBCwMjfwG6WOR8Q1Z/ahbEK0Ka3S+Xd/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7133

Hi Andrew,

Thank you for quick response and valuable suggestions.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, April 24, 2024 12:41 AM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; edumazet@google.com; linux-kernel@vger.kernel.org;
> Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even whe=
n
> PHY does not
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > If we don't enable/register the PCI11x1x's ethernet device in wake
> > list by calling " device_set_wakeup_enable( )" function, device power
> > state shows as disable.
>=20
> > PHY (GPY211C)'s interrupt pin (MDINT) connect to PCI11x1x's ethernet
> device.
>=20
> > When I configure the WAKE_PHY or WAKE_MAGIC on GPY211C PHY,
> Interrupt
> > generation observed when magic packet or link activity (link down or
> > link up).  If wakeup enable in PCI11x1x's ethernet device, System
> > resumes from sleep.
>=20
> This is the bit that is missing from your commit message, and maybe it sh=
ould
> be in a comment. The interrupt controller is part of the MAC. So you need=
 to
> leave MAC burning power, maybe even processing packets, because you
> cannot disable the MAC but leave the interrupt controller functioning, so=
 that
> it can trigger a wake up via PCIe.
>=20
> There are a few things you should consider:
>=20
> Call phy_speed_down().  This will renegotiate the link, dropping it to th=
e
> slowest speed both link partners support. So hopefully down to 10Mbps.
> Your MAC will then only need to pointlessly process 10Mbps of packets,
> rather than 1Gbps.
>=20

If PHY handles the magic packet or phy activity (i.e. WAKE_MAGIC or WAKE_PH=
Y), our PCI11x1x's MAC will handle only interrupt (MDINT from PHY). Not MAC=
's magic packet.
In this case do we really call phy_speed_down( ) ?

In case of WAKE_PHY enable and put system in suspend mode,  I'm seeing issu=
es with calling phy_speed_down().=20
When speed change occurs, Link interrupt occurs by Link partner which inter=
nally system resume from sleep.

Do we need to call phy_speed_down( ) for only magic packet (WAKE_MAGIC) cas=
e only ?

> See if you can disable parts of the MAC, in particularly the receive engi=
ne, in
> order to save power.
>=20
> Talk to your hardware engineer and see if the next generation of the
> hardware can separate the interrupt controller from the MAC, so you can
> disable the MAC and leave the interrupt controller functioning.
>=20
> > Please find the attached prototype code change (Temporary patch)for
> reference.
> > I will submit this patch separately.
>=20

Sure. I will do.

> Please just submit it in the normal way for review.
>=20
>        Andrew

Thanks,
Raju

