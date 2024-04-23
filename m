Return-Path: <linux-kernel+bounces-155670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C104A8AF56C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B551C23F42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3A13DDD0;
	Tue, 23 Apr 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="Q+AjP4oF";
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="VRvtQIJq"
Received: from mx0a-0068d901.pphosted.com (mx0a-0068d901.pphosted.com [205.220.168.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CAB13D287;
	Tue, 23 Apr 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892996; cv=fail; b=Cx5mN3J9qhbr4Bln/piMig3J1szlykF7Ye4PJ+X65x4/5hQ+P6/7EJkLl0PP6STe1S/oL4dJGN6P7G2EuC9Q3uwGcP/x0a2cOBHVmo+j79tuG5YGH9depW+9cTWDPyl0Xa428iZrsQE/zGsuvwsCPW/HA7Zai963XvtAS/od0fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892996; c=relaxed/simple;
	bh=AHo9+NclCiC4zk9gVpGL3qYs/xX+ylkQvOfGpZ7MuEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GXFy+HlE5WE7ho5faAT2Cn3rM0MiG2WhjM2piuKFSooZbn/QO4MbY3G+FJNqrDHj1a8tbvQHIGNxEIbEZZUZMw92xhsYITeATfU1ph7dwD/6cn8rRNnHp7J2Bxm7qF6GZn31EqCMHqj6VoRflqlNiO2xVpP9kQrFiQ4e/YmWaMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=Q+AjP4oF; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=VRvtQIJq; arc=fail smtp.client-ip=205.220.168.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278264.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NBJO6k025708;
	Tue, 23 Apr 2024 10:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	proofpoint; bh=a8X+ZRbjlnGg2B1YQQtEbUCjNWlb9UjmmNA4UL3FP1w=; b=Q
	+AjP4oFcrwnkFWUYUJESLAKPYFis3C4YbtYiC/BBiklPAhBVJxgHqmx/ay3XQ5gL
	jBUpzaa+DPAM4i42cCA262DRYu7EC/w2NBzwJvoanJxS57u8nTGLxwJnniTexeO5
	phCg/7SASEjylnKFFZcJsnbvpuVmtXON30uUNCGVdos4Iojv5R/WKm9PSlvkldGN
	FVQpQsCkqpktdEhl/S0KXUBjoYP3K4UKktNIsINXcPof6CdK44T820f3k8CGgZuo
	Rc947c1jpCxeUnmIJcZ+6W4eLXAv+FNYYuV/3vHc4qhg5bXj9gZCnUYssY51oB4j
	cp6NsvyMtBLWtmIVVVzgA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xmcrg26kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 10:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn1masC61iBwVWrWHvtU4ep1FoIG3EnoE+kcF7eoKUkOkzo/mgeNHkT0svWMgP+luhyrz1zJtXGOubM1FMIeIOaL7qKVlzA4771+hbrO3bnygt/WtyZo/cTEgdRwyy/PiUeUYjLgPhBj32yYXC8ubPGRPxp9CDiCC80LC/vhJqF97af0ZM43e+x0IK8RJ3qVnA7Wk25KBT0OvXXf8zvzhyZEORf4ERpdbgGivYG/N2fBUkGw6d6MafKAvt+Lu8V1b5S2bV4QYn/Xr6dp+16P4bTJ2OPXkPpN2Q+BRUmyvRe+YLCzpNdrQmZnd8erGTduqUioMQ3GnjEmcNysT3SDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8X+ZRbjlnGg2B1YQQtEbUCjNWlb9UjmmNA4UL3FP1w=;
 b=jBTdpTd1w+YL6IsH6UjpjLi53UXpY+JDlE2ReABBlSD55Naz7kqWbRyeHYcE1JPsbnqnLIm5n79XHFF0DTzYeO/7/xJYSOAl2SG/m4ZQ+AumOT2TRT4mE3LCeZgjN+JqZUOS79IdiiHKwYKT0Z1IrG7U+5BeRO8bukN/Nmu2yPZ5kyP398ibDtkv/zCiBL6+Xj68aqhjLlSYSxBPEQ1dIJxxSGjtnPv+YDdzPZl2mgneCdAICcKkU2z+KIq5XDJNE3VHF4nnFblGC1rQSlqp9KeVBIqAPFT0NCdwBCkk3MwtVu9Z2U4Ad7uIsV9t4oCdsHTxWA6H5ZzTlroiO0On5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8X+ZRbjlnGg2B1YQQtEbUCjNWlb9UjmmNA4UL3FP1w=;
 b=VRvtQIJqHGXIm0vTOeJ5H7+H64Bv5gCYBIEb4Ru7AvaIbnCLhEPUTQe9SGupgMxcm4XBw413dhEQavS0wbK7MrkSWUqOhhtVL3D0RSB6qBKNf85v5Rp9OvH7VxztMAk7iMpsG83ZrGzLGkzejSXF1YD6bY0Y5GNEfJtBUHqEWZ5OoU/DczRJkCoa5503oi696AvIF0vuygbRA7in7QzBUr1otlBhFCcU8z1gZhnuGBrqPJWr1UxCWTqxMea6gGTgmwl70i0DyAaIBq+rEJJggfI5IhFgS7qKSX4k2+B/Qh3PQAjaEFKOoWGq1/mSKc/9dj5wKOXjyzTAO0IMHwCy7w==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by LV3PR17MB7303.namprd17.prod.outlook.com (2603:10b6:408:273::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 17:22:53 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 17:22:50 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: Pavel Hofman <pavel.hofman@ivitera.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Gruber
	<jimmyjgruber@gmail.com>, Lee Jones <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] usb: gadget: f_uac2: Expose all string descriptors
 through configfs.
Thread-Topic: [PATCH v2] usb: gadget: f_uac2: Expose all string descriptors
 through configfs.
Thread-Index: AQHalYdWgtu02BG/fUykcYHBF1kPmLF1/Y0AgAAPjZs=
Date: Tue, 23 Apr 2024 17:22:50 +0000
Message-ID: 
 <CO1PR17MB541989646698286B2B13CF23E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
References: 
 <CO1PR17MB54195BE778868AFDFE2DCB36E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
 <c9928edb-8b2d-1948-40b8-c16e34cea3e2@ivitera.com>
In-Reply-To: <c9928edb-8b2d-1948-40b8-c16e34cea3e2@ivitera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|LV3PR17MB7303:EE_
x-ms-office365-filtering-correlation-id: 11d35c98-b866-4425-4df1-08dc63ba00c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?qj8QkpRAUMtXkCKGw4i31dcfannvrhXJmzYao7m6Vu6qCSeSj2uEIcnUpo?=
 =?iso-8859-1?Q?QMd6XonwB/xa3WxcXMjs7S5b8UiJo0MNRv/bAQmBgs61BLEnlbvGAPzLqZ?=
 =?iso-8859-1?Q?miDhswCt5AGW06m+LhffCubx+Wu0r5M007HL9HV65Agz5ToUlIon5m23R4?=
 =?iso-8859-1?Q?RkyhTLFdGFkmh8RbboEfuZH5AkF+66XyGtO2KzQFX/GdDpNFW2TlirZ1qr?=
 =?iso-8859-1?Q?2RXidYfQ75wW4zPx98HPKW+tiO95/LTFKu2DISY4xnEp/PSIWEHOmdUbAp?=
 =?iso-8859-1?Q?hrgZP9La2pjCsaRyQtlXIWfsaPwlkcXWGuxiUq23j4ANlNCwy9QZWQkf9D?=
 =?iso-8859-1?Q?bJ+SxyLxuqCqvk6r+3uJUhVYp/1irjC47SS8wzBj6DM7blLIxQhI/S+RmF?=
 =?iso-8859-1?Q?muojE4+yz3U5aMnFQ9YzwDo3A9Asgeh14hA5fOF/pcx0BeMNO6MoRQQVTG?=
 =?iso-8859-1?Q?cZ8dTNvlsIM8MVCdDUJUh2Z4utM0d4XMQx1apPffjEFukJ9Afr3zduVfA3?=
 =?iso-8859-1?Q?qEU11jtVKKGX3yeK11q6eo6EQGstmYg466Qcr3KftbEE6VauYXozOPjA5T?=
 =?iso-8859-1?Q?alqb9zPNAJEW3SwMsU69xGnjCzbJxUiigmUt6G7mPGoBIjXA2ZKZhBDbi6?=
 =?iso-8859-1?Q?RJV78yO9Y/VXl0Lliikq2runP1q0ejUQGK7CpreybgozlrWtR9pSX6xgNs?=
 =?iso-8859-1?Q?o91znuYusUZpOvYWmnonawEoQkRyy49dTLIzocdmeigEyCrUdTcDC3jxKf?=
 =?iso-8859-1?Q?Jhr8927G9Jzh7ZTaTBoPUa/X95N4fBs435tlkpHlxP8l8mKQuFuNCFIvVl?=
 =?iso-8859-1?Q?si2CcFmC0DXWtpnIg/2mrNaT2ykURMQvuY9X7C7pM6NJyR/5fIBx4YXQMr?=
 =?iso-8859-1?Q?Uvy2xSJ046lJo/y7PbDi/hvrmHwdqdARjo4XN6gIJvLqLYsoNCipm8WDoC?=
 =?iso-8859-1?Q?EWPbmZzFIkCBaJ3QWiFztW3uqGu+YLWoh5FHkHFcgSXMk9yjb+vefNpvh9?=
 =?iso-8859-1?Q?7L1tna60fp2Rw0cCFKts2/n6yqaMfgzltZhM85ktnFNWLUYhWLMDAQebjp?=
 =?iso-8859-1?Q?g15Edh87Nc6ECvf4sTsQnoXbXFi4QiZYsxOK120T/zPtYAZXM2EYHm0xll?=
 =?iso-8859-1?Q?kL1Uv8BfRS6Xb/5iM1cOS4Cea8v3heiLb9VXAwam22WIMzhyJTDB7a3HWy?=
 =?iso-8859-1?Q?bCgmBNmvPo/XXp+8PN85ExwoyvaXZimQNkODledTHIog8drJKhibd5iXjp?=
 =?iso-8859-1?Q?4j4av0OG6/5grda+0N+oiAIEBk645xrUJmzYUifCAIt1kgfjqj4h3oL6ad?=
 =?iso-8859-1?Q?ShBc0jH3X39+pcpEQX8CBPSZL0kN7UoMW4BgoczvN+T7HqyFaFUNfP/yn7?=
 =?iso-8859-1?Q?8cnxevuAuJqiSgQsQ9wRDTjOurpWQGpg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?NmxNZHXNTO9r6WLqueFTvhhuOZEjxXp+K1HLsbXhcBhB3XyVRlL0gQ8Jc7?=
 =?iso-8859-1?Q?XyY2jyYhDTQZhUzI6OM1XbD09ReUir9yIvb26XkD6XAr0SY8Zxyx6BZr5i?=
 =?iso-8859-1?Q?ycrm6/OvtEEwBQb9Yr2tAxPxPDctfPRAhdB2Yf+0gFnjuy0tFZiWb2xQgq?=
 =?iso-8859-1?Q?j3uNqD9CFDlLbRI/dOhDitD5Tcljc5KrUC4dD+w2XgTgdf3uLdkIsuMSTc?=
 =?iso-8859-1?Q?nDj8BmaJbam2pjZn1cKl5WiJtQGPgqMt5R049+PuKdjCi3Gm0rn2i/XHAR?=
 =?iso-8859-1?Q?APfsVNR/Fmya79tWWJ5T/wQIoNTVDWd/vVbE/KCnnY4NQ007Cy0FvTF+sa?=
 =?iso-8859-1?Q?lbjmhFwn+4EP7QMM2RZSTCuF9zaW62mI7Mnr8alSRE1qwmMyjRVClWzV2/?=
 =?iso-8859-1?Q?t6A6fXMpvQ1YZn1M9IQWbxUOTlhfNR4y+slvx4OGmMs1bf0tGL0+LWNVn5?=
 =?iso-8859-1?Q?oM5YdOM6fyBypjbuP7u5UCdoPfpP4kNR8Hc0zJsjkCJ20nhgUvxjT76S9W?=
 =?iso-8859-1?Q?NsU7mk7oDLXCR4+aYKsx6LftHgL+Vv0e+VtLk5VIWxW5r55gZBAydZfpHp?=
 =?iso-8859-1?Q?iTdRauK3JFI2JvgnwPvP/9kG74YYAQVcJkZ5D2UT78CLGfckoUaTLw8aUs?=
 =?iso-8859-1?Q?n1LJHMGNloERaHeait8Xip6tCzJe9/D7hhQLzBdGyV/Elw1v4iT/nDfTON?=
 =?iso-8859-1?Q?DrtXK4rSuLNfn3xLWglaGW4holk/i4k8Cv/8wqVac6/SxadK9M/jJNlUtM?=
 =?iso-8859-1?Q?Ne8TIERhujcZbOPtGC4pY/cwcQtAh6hS3SaVmDe5OQWD66Yt1Es57WyZIx?=
 =?iso-8859-1?Q?h6lOIl1EfF2wTv7qF/4oOuGcZ5IzCsF/gDtG2DBwkjudx/BLPG+SGNE3WS?=
 =?iso-8859-1?Q?BQs0mbBIlxXyFnKxLJk547cFp+uT+aX0myAPGhK+3ZTNB80ZFlfm4qfGN1?=
 =?iso-8859-1?Q?CMK/hk4r78QY+htYJrQqxQdo+Qq5fFCP6RYYXAyiPZVs+iRBBjlVQJ9syV?=
 =?iso-8859-1?Q?R/hLTsQLTfIms5Yeqp890nRH8xkddERRgEV5tjMKClSAy7XtQgn4nVE3hT?=
 =?iso-8859-1?Q?vzKvT8vTW6qngS0nDjAc6ZXi1QMCD4YUeaeY//kHzDc0Zmd7lB9Moh6X/j?=
 =?iso-8859-1?Q?OYjE8w3L+56gnS5Lx1hgc81A6T0h8/nUc2BrXZd8EA5OKTG/xwF+hStX9v?=
 =?iso-8859-1?Q?E4v3uIrqbltrSEO2PTtrV68ecr8imiB0UPLik/R+Bd6Qqhl3u56TzAyUmL?=
 =?iso-8859-1?Q?LjtYGh2y9BBjf93i+AIiC1JmbjrDyhqKUCZHjHmC9uZOGKj4S8Ah8fJru4?=
 =?iso-8859-1?Q?5bFA6QVnb3bGHT3cA5reLu/JvCQhlzEZd4Ss/kpV3IIUI0832mpWjRe8y5?=
 =?iso-8859-1?Q?9Tt3rhAozu4gzRe6MjJ9trK82liREsQCD2CmHnovRAiAMabPT4riT7+dOL?=
 =?iso-8859-1?Q?Q9G/qqYMzaJcw0KGcir6n49k3g1KOXMniqLk/f0HcKJHEiycwB1WoZKdDx?=
 =?iso-8859-1?Q?V0a7eZ701h7wQ2Ky978Oh3x8ORox1OwfImxLZUNu7P57nY4zqalJo4go8e?=
 =?iso-8859-1?Q?DsFwIeV+X6FaDyItYVux2Wq/XalRolKk5yaKLnJgQjXn3x72wY0okBHE1B?=
 =?iso-8859-1?Q?OgQk980zC1Sgiiif6ECKWs0It63Rl93Prx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR17MB5419.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d35c98-b866-4425-4df1-08dc63ba00c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 17:22:50.7524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcsnQCHEI38UXMevJamOEyNqHh7bETXlCy4oBEytu+eS9UETHhogrmBrD3y7W7ACBoTaYTYkrm/lJOOWeqcf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR17MB7303
X-Proofpoint-ORIG-GUID: TK7_NdA9eFfkJmAi4LkTxF2Dh0U0Q90d
X-Proofpoint-GUID: TK7_NdA9eFfkJmAi4LkTxF2Dh0U0Q90d

> From:=A0Pavel Hofman <pavel.hofman@ivitera.com>=0A=
> Sent:=A0Tuesday, April 23, 2024 11:38 AM=0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_it_name=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 playback input terminal name=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_ot_name=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 playback output terminal name=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_fu_name=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 playback function unit name=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_alt0_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 playback alt mode 0 name=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_alt1_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 playback alt mode 1 name=0A=
>=0A=
> Nacked-by: Pavel Hofman <pavel.hofman@ivitera.com>=0A=
>=0A=
> I am not sure adding a numbered parameter for every additional alt mode=
=0A=
> is a way to go for the future. I am not that much concerned about UAC1,=
=0A=
> but IMO (at least) in UAC2 the configuration method should be flexible=0A=
> for more alt setttings. I can see use cases with many more altsettings.=
=0A=
> =0A=
> My proposal for adding more alt settings=0A=
> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/35be4668-58=
d3-894a-72cf-de1afaacae45@ivitera.com/__;!!HBnMciuwfVSXJQ!TYg7j7-fh3eZAzPfi=
ONi2lo54mf2qsWtpG0nwdaQwSqd1nGdKkTDN8o6_lSIWlWPtHoc-2Nz1KCbRhiXJnzXO8Ku1w$=
=0A=
> suggested using lists to existing parameters where each item would=0A=
> correspond to the alt setting of the same index (+1). That would allow=0A=
> using more altsettings easily, without having to add parameters to the=0A=
> source code and adding configfs params. I received no feedback. I do not=
=0A=
> push the param list proposal, but I am convinced an acceptable solution=
=0A=
> should be discussed thoroughly by the UAC2 gadget stakeholders.=0A=
>=0A=
> I am afraid that once p_alt1_name/c_alt1_name params are accepted, there=
=0A=
> will be no way back because subsequent removal of configfs params could=
=0A=
> be viewed as a regression for users.=0A=
=0A=
I have been thinking about this as well. The alt names are slightly differe=
nt than the rest of the settings=0A=
since they also include alt mode 0. I was thinking p/c_alt1_name could be e=
xpanded to the array so =0A=
that the entries line up with the other settings and don't have an extra en=
try for alt 0. Perhaps a different=0A=
name would make more sense.=0A=
=0A=
Along those lines, I didn't see any gadget drivers using an array of string=
s for anything, which is also why=0A=
I didn't try to do anything here that merged alt0/1 names into an array. If=
 we were to do an array of strings=0A=
I'm not sure what the best separator would be. Maybe ";"? The rates array u=
ses ",".=0A=
=0A=
This patch only exposes the existing strings to make them configurable, but=
 I don't want to do anything=0A=
that would preclude a nice interface for extra alt modes.=0A=
=0A=
  -- Chris Wulff=

