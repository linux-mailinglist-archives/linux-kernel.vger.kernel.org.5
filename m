Return-Path: <linux-kernel+bounces-162604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDA8B5DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D46B21DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B68F82883;
	Mon, 29 Apr 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="IQJ2KnlB"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B577E0F6;
	Mon, 29 Apr 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405231; cv=fail; b=NetuTRJY/z/srXKBLBJPtMPxxSS0jVokVqdEdDBh2XMwal5qq2MSPh8RorfMOCTymAX01qxg9DmSPKf/Q2LG8knlQ7kGO4T6Sh3RnjDsW9v/QuvEfIoQaayfhioY5DQsbzDzi9UvbTClzsq5TtJTuKJGGJronI+CsndutzJTfGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405231; c=relaxed/simple;
	bh=JSndvQyneWvFR1yNAtCJU3ZhOg9xOg9xYqblNXaIpcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WZagEmAuZLKAfn4ekJOoBcuMY+O5vI68kZ15O4RQHMoaLSh/I8xLoWhaPoH+PCtpaF00SwXzQgr9VmH7hQr0qzF2nzh3R0fqhZIvElJ7Sfe4eFHhyzoh4dHmwSSq9nRSd2Q07k/n1g9a+wkKDpYWjWa+OtDF5thozGNB8bWyId8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=IQJ2KnlB; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TEVips000904;
	Mon, 29 Apr 2024 08:40:24 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xtdcn8qxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpgI68lxURimSgnWj9RnA9NggOTNG5kdAEavxj2hl/B6Byop1TSUpQ98lXP7y+IG42ekVtlep3lphFRDYZAJy6WL8pIZpvOtiGXXNm/STEQMxVb7vrc1YVvkjX9Y52lHLV19MN7bVL4H3Ii3X8QlTc+RkdRoPzOquVsmpt8hSYpgm4EUj/z2zmJ9djDtgV/JNVwLa8qqbEyClKeToYfKxtkxVokgvCyiSkh92VJnl2KdsmPYFGYUWk6kHJwznucp0i1qysSdyWuBbab2YvF4PNc1y6A0r48jorMsWrZQ33EAMOXsXog3OI65D+JUTyKEkvVtW6En5siQ+vczQcOr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSndvQyneWvFR1yNAtCJU3ZhOg9xOg9xYqblNXaIpcw=;
 b=L+LtmmjEnq1uuycAmSRKKRG7zMnnFhH8PY6iZq0jsu4tTv/fGfGbWNDXAH7x7ApTzjq0glsJ/yy10ee/R4SVqrs6Hgn8FvO+yTeQNp8w+FGY72C35FcGAD6r/CJGuRl9iMjvmxfuMqi6boFYYn1599w3LzzlVGYZtSNrJLPtM1Gu/5YDinKwOBmuoQqfxlp90+ha424Jnpq3sGhsRtmDNzM2fTCYou02KON2G66AnhsaX+B1xIQWuragaiX9t/Uh9mQ2Pk1jUOwIOfFMweaiMBW4kEDQxOrIExncoHV5bABl0ESwMxQwRnkWDbabF4iahJXYr8F3POSZCixmKZdatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSndvQyneWvFR1yNAtCJU3ZhOg9xOg9xYqblNXaIpcw=;
 b=IQJ2KnlBF6wHfmCfYlxZLuzoXu1mVNDa2kkzrWxkj6eGBwdusRhpqeW7NPBX5f8ex1q54e/AyoTrDlMCTnAZ4h9EW9i//R2pOFPypd5I/shgsClgUuLbwM1xqZ2ujipfDkZ7WW41pPBuXisVtpaa+BDC+qDQu0A4xvUVthPlx8s=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 IA2PR18MB5964.namprd18.prod.outlook.com (2603:10b6:208:4ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:40:21 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 15:40:21 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "pthombar@cadence.com"
	<pthombar@cadence.com>,
        "konrad@cadence.com" <konrad@cadence.com>,
        Wojciech
 Bartczak <wbartczak@marvell.com>,
        Wojciech Zmuda <wzmuda@marvell.com>
Subject: RE: [EXT] Re: [PATCH 5/7] spi: cadence: Add read access size switch
Thread-Topic: [EXT] Re: [PATCH 5/7] spi: cadence: Add read access size switch
Thread-Index: AQHZE7g60GtlBEsuAUyswFZXRR8b2K51hIAAgwzq8QA=
Date: Mon, 29 Apr 2024 15:40:21 +0000
Message-ID: 
 <CO6PR18MB40988B339F9FC8599B7D438CB01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20221219144254.20883-1-wsadowski@marvell.com>
 <20221219144254.20883-6-wsadowski@marvell.com>
 <Y6Cqavt/wT2sQfRU@sirena.org.uk>
In-Reply-To: <Y6Cqavt/wT2sQfRU@sirena.org.uk>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|IA2PR18MB5964:EE_
x-ms-office365-filtering-correlation-id: 68af1d58-d294-4158-608a-08dc6862ae0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?B5wlp/ekDONCJ1vUrvJAc5EU6j8gWN6GCTHFYMWY8FoOPYDMCdJxM7PD6b7O?=
 =?us-ascii?Q?jIp7wi560V3fKTSojvUtwt6+8TESTXvHcO4lkTTSH9T2N2DUF5imYTK/0eyT?=
 =?us-ascii?Q?zAS7nDiJhavDNyRikvMr5AvsyOXU3gVYEi5km8t1NTFJuNyd2FQL0sSkAOIj?=
 =?us-ascii?Q?xLT2x43IYtTou9pPIemONHAchtbuEprwJ7mTOlcbDxxieTP04afe4Vqe0J0c?=
 =?us-ascii?Q?RmbZWABHLHAkluULEU4Wkew8RLFzSxXn6NZlualzGA4uD0qh6MP5KkXoY1vy?=
 =?us-ascii?Q?J3PLAaDRCS0XM8hZeE8ZzI1EOrvwnqf45M2n6QJodx4YAq+RLnHuIvv8ySYs?=
 =?us-ascii?Q?U0wkOa/ToDwYXzrGnHFOU694mdcKfOO38bWWw73WgWM8ec24cpblS8TffqY/?=
 =?us-ascii?Q?gpiu2WxBB9UZ5q2yr8phCX9rfAE47VVu5WMeSbOVe6iVWHOkch/Mxk50Uz9L?=
 =?us-ascii?Q?VKsi79xSS6NiDxP/hC5X8BfHlWQGKfMgMSB4w3k2hkBVWtaIjEu4GX1IE+0W?=
 =?us-ascii?Q?lDMwx9CmHYpoKk2W0jEJF4vydQoTQSe7Sal/spUGNWHcDh6lbXRVykL1+/8C?=
 =?us-ascii?Q?iLvBJa0GfJuaRFWbApYCOMNjrvbZrzyU916ROSKWOtO6OX5hCZfeASI1poln?=
 =?us-ascii?Q?NrCZmQjBkjnXly5q9lUGjnG+aHQzadKOAvSb688jCukiDBzdKR6ort0+6baT?=
 =?us-ascii?Q?lTV/1w20Khr3+b6i63X4/gySr+q+wfAGlEe4vIdbKxVCjblw+fJX6wIS3qzJ?=
 =?us-ascii?Q?2AYTpU3GQYmTOlkE282KWlQK18qcB1dD9dgSv5tqCz0V6igR9IK1l+NRa7eq?=
 =?us-ascii?Q?u9Efff7GTJEgfzLY+vzb9wtdOQRkhTiSQdYI8sp4lXTMTlqZN1yJNWknN5TU?=
 =?us-ascii?Q?0+GxlcXb97RmYaFguNnFwxIkpIa7ODtr6yCYJ0G0d3rFpzcnNIqIkUlOO389?=
 =?us-ascii?Q?YSKKVt0dztt6THsFKXhTedI/uDlvlfvw1f963jRzkQMIy7f5yV+4BouXZsww?=
 =?us-ascii?Q?a99cCOBfkBy2tXv8EOdXsGluQ4fYHA0n9bwZRuEA/Nj6Wcp413sKJxKbck3k?=
 =?us-ascii?Q?Y0whvNd7JgNuTYpcqn+Cj/cu0IDWXIXZDiyWrZfE3ZzyqhY7IYaOA6QRybLo?=
 =?us-ascii?Q?s12zjimPCNzKwgl0mBMn69stOB82vTmocGvufYgknd60Dq3pt4QwL/ndvbZl?=
 =?us-ascii?Q?w1KLdOBUb9XpKC7Gjzb/5Dp0y8X7XhSshUHNpneAPKarn25ow/uNqtaisba9?=
 =?us-ascii?Q?W/aQkvawKfBcGfUOPOqalnaLJkJrCvHTLa265AeRmOO64C7frFgGdsos2Um0?=
 =?us-ascii?Q?wZp2HapIZsKWVq07nH2J+mLVZuX/UhSlQuGk/RzFLWIBAQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KP11FbnMmfuWlg4/iGor3zEbBgL2YcIKlNmyEIsC4Tv7BJZUebnMW8qkTO6r?=
 =?us-ascii?Q?3SVO5NFsM56HCV0wifyqHHgzo1bsnnzITC4wiZ4EfgI+oh2gbplK2OeYWJia?=
 =?us-ascii?Q?azH0+58kKIc5BDL8+quZywPMk307ID1wvn16oUNEpaNHcqMVUQSBT6ezJUHv?=
 =?us-ascii?Q?CtiRwipOSssARhLDsoPoW44szKwDDjneck5bb1QwejyZ0UY2dcBIY1AUcz6j?=
 =?us-ascii?Q?lh6XH9/7yr146GE+xPmqqDzZqOWWTRIqh96iraV3f8iCXgsPzhIErEICVqkZ?=
 =?us-ascii?Q?WV+FZ0FXkECy9hbdMEVFLuchZ0fPQfG6mZgeI6SQ2m4C5sCxCelDXhgVXXXK?=
 =?us-ascii?Q?Q7Ates3uGhVQQzh9AySdhGNQrH7OY2GhRC6lfsWS131d9SCW77GGLFsZXBto?=
 =?us-ascii?Q?inHXRxa7FTQJZr/wum87Q1UeVUrc/cN9Tqh2FFH5LrMI2GAAQjRDnZsj8TjA?=
 =?us-ascii?Q?HvuvjJ6bhOuykGItdD5iW9EXrbI1B+QaOrTKBvFwJtvD/Qr6aLvI99gPiVOc?=
 =?us-ascii?Q?+vOC3BWByEmkEaKhiJVlM8Yqf4Kz1NlA654CHMLM9sA9adH04fjf1sHVgkQ0?=
 =?us-ascii?Q?wc6oWD8jaxSeBVcg4ean6i2QsJEBBXlG+8IeKkkU1SB9wkT2w2fszpiD97Gg?=
 =?us-ascii?Q?KhrYbDNAE0xZSymomQr3pIJ6JukqJ7i6tDdIYWI3mdfJKyuV+lMS9F+meinw?=
 =?us-ascii?Q?46oHq6tMsX3DaZEUEtDVMQVTiWnApTlQ4hncJoDvEHKLG07Mp3lHFAqcTjLS?=
 =?us-ascii?Q?HNYj++pDai2prJm8ObYonUnX7vgJUMGYTH/AG2/J2a8PL6RnN/VPATa4ArpM?=
 =?us-ascii?Q?mVWu0orwOObPSGXv8Ub7NfJB/1UeuYr9YhmVP498270UJgIp3r4aSn8itjU3?=
 =?us-ascii?Q?sSCGJltERohvAHP8Dn88yYyik97ZIUHVfhpuy6IlRsOV6aLt+kNFesDCtQHI?=
 =?us-ascii?Q?7O822niSgXKoLSmnkwYgDhgH8GqsJlIQm642csrxB1w3fd8dA2ZPnzbHT5Q0?=
 =?us-ascii?Q?LcMRYKq3V9ReAquh38ECysf4vR/9WxI19X8DEqlQiJmOhg8z2lTz0I2wPifz?=
 =?us-ascii?Q?GsgZuvpUTQmYhBMFbVBDt7mpCMrN7aNfE6nz3cG0ZoxYKP5RWGn7U9k3Gl/A?=
 =?us-ascii?Q?v/AAQR8uiBe7mMI18PuXBIFaeTFDQc1WxNpAd3MvqeI9Bt/ZBn4wpfkGIqX2?=
 =?us-ascii?Q?KQ0nq4rNCIxYWOTzk/rA3C0vqJ0TlcS4SNkHr5GIEkO8ZAVvYcl/FC8jPt1a?=
 =?us-ascii?Q?qg6dTTRhSz2O9CMA1TAiFmcwuJ88JVn/voAu0r4CfQUT5MiFFsL9uPZqnFvS?=
 =?us-ascii?Q?Ehd/HSQ9jBKEcNWyx7089kJXItV00NXu/2e++oklvv7jhyGQraQJVEzdkoRb?=
 =?us-ascii?Q?xdmmcjw52u+R9eLGSF3JcXXMmat+A7W9U3b5v1W4cTNK/cucqfFLHvVrR4Lw?=
 =?us-ascii?Q?xDdw0wgY1G/Qiw5Jdvl132zsV4WxKRF60QCmCK6ti3zCXUtxbseqZ8HV3X8d?=
 =?us-ascii?Q?q2WM6YvGqAET/34mkmgbB7L+NCYnxOVin34Y/7QKBrn8s6ulRu94Xy8NPL3M?=
 =?us-ascii?Q?1yGFOtmYmbzPaJhgj8NZnap3/Y7M9B3oZ4QB1ok6?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68af1d58-d294-4158-608a-08dc6862ae0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 15:40:21.5645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ye5+BtJBouTQpNTmdGZ4ijS1kE/WGnA4tI+Q9HVSkScPG/2k5VvZp6wSw0GGXjoLthFLf1EODpL5DWJXTacrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5964
X-Proofpoint-GUID: rwRRbEhj5hyBe6QgpfvCfSzGimsPQlWH
X-Proofpoint-ORIG-GUID: rwRRbEhj5hyBe6QgpfvCfSzGimsPQlWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02

> ----------------------------------------------------------------------
> On Mon, Dec 19, 2022 at 06:42:52AM -0800, Witold Sadowski wrote:
> > Allow to use different SDMA read size.
> > In Marvell implementation of that IP each SDMA access will read 8
> > bytes at once, and is not configurable.
>=20
> If this isn't configurable then shouldn't we just key off the compatible
> rather than having a separate property?

Done, will be selected based on compatible property.

Regards
Witek

