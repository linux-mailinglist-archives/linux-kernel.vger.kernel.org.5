Return-Path: <linux-kernel+bounces-37672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E00383B36A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FDD1C2290F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14B1350DD;
	Wed, 24 Jan 2024 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="c9gPN6PZ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="FjyMDb3D"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F90811E4;
	Wed, 24 Jan 2024 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129919; cv=fail; b=LgSXoe8kRO0f5O/v/tqT79CLSBkKeTQmD1qpciOh1VhKiTb5R5DfePzNUaMM86JctF1fJc9C0AQZ4kknabdDKrvTyoXMfolWrDmkKppDW4PJSjfCi8B1cHopoCmAa7lxrv6lWQazNaICpkc17KsEIVOpA9uiBApB4es767Ddgd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129919; c=relaxed/simple;
	bh=r46MLdp91hgxlOoTFtcYrfrSFKoqP3Z/Qf+ujiQpZ/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nlPo3a4+mDR9ntOvDwtvTtRb0whJfPLCO9/wmDxPc4XW7p86pZbYsgz/F6lTFJxY6kAJTg98/ZO02jE6SwcLVydD4DiXGhVwdMlONUNqADAneYsETHvVvmssXksmk7sUOm9ck0s/NfTPvPaYEoC3ByCUWSMRk4581UoagRoQuNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=c9gPN6PZ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=FjyMDb3D; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O8MvfZ030107;
	Wed, 24 Jan 2024 14:58:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=PODMain02222019; bh=r46MLdp91hgxlOoTFtcYrfrSFKoqP3Z/Qf+ujiQpZ
	/Q=; b=c9gPN6PZufmvdFn8rZGXlBgaHCrAjdwiT9wxsXhuMgNZm2GXJLwkHPYzz
	3TexlFrst5X988lruEpY5KuWpt7IpCsyI2c1RjNB2IAkhWAw1fAmiPwIlsjjrbXf
	cmqhCcpbwbysaB2bWzmUycQSnJhstb5uTMKGk+x0lJwAFpYPWH4uLY9bM1pbQHgN
	1KWJRy2JAbF331TA2ZP8M1b3aDdpMAoXn3l2TZ9nO4EYw+m2CQALCE47OA+Pb4Y8
	klZi/Mm8Dhf3NSME8LecLpN2vviQl5g5PErX7Nn+jIM8IHPTNso8B/EEzdYkm+r1
	T/ifydGerbqPsb1a7cgbiqwtKly/w==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9sdd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:58:31 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMv61Zj+RRQ2JE9R02tSl4T3WUXT7zbECaRwIzoys9PKeYxyo7b9I98pxUcLk+7ctYCf19nbR1tauFFuiLWrSUoinYZkCnIWrCo7VjbK2ZN/nm+hB211/MvgTajJxh700mKC6yOowLFM4dnFcnVCB3RT6wVZmTEeKK4T4UY/zNK39X0P531Mir9ydys33iht8I1Cc3y3fQ+eMdnHqDuk8GOyEAhdhYTHtZmgEJSgLtzPqOZE3jJLSLrpDQ2jpwjckca0sYxXplDHjdo8Vj5Uwg8MCA4YTq60KQvxHm6+qmgYUZh8vuHHyAmHjvGr/2I7zh8WK6jNKQxtJ9v/cvsEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r46MLdp91hgxlOoTFtcYrfrSFKoqP3Z/Qf+ujiQpZ/Q=;
 b=FyCO+FDYBSESZY6nAUCNMzVOCxQLyygJg9KGWP11mGR0O09aYuus/Tp++B2pjDKnE8p2aNuTsYmdGyZSlZieLQSVi3ohu2G547nsltoC8xRun006SsUnw7I5Z2uL+i+/1XwUXLuYeUBjaYIzLblJ8gwEJC1hTxvTfdF6cW5/xo/lHqXgYn7XL3V6Fpn6TYRbiC5fs8MH8K+S4YHe0XT//DWBBlHVK3PGjKdrw97O4b7ZgwvsQHjht/qDi25L+ueU2O+pqNSfDDPAWcPYNwPB1ixMj6vWtXNOE/SrUxip+EXStkeLtDu/w2Kc3cpv8Vx0krDAKcplRcofl5m5t4cnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r46MLdp91hgxlOoTFtcYrfrSFKoqP3Z/Qf+ujiQpZ/Q=;
 b=FjyMDb3DmuDd7uAWtCFmd1iAkmWiIyfrWi20KenHsEXupYiKzWmNPFv/KDoTS3l/R6SzzKc0z4p8vndtsyVucdRdZjblpJbirOAPFiEmqw3aTT6kcqlOXEJMtM8YkhuOMlwrSXph2kG+dasqYj7f6/3ObAEvty4lv2+9/9zeLyI=
Received: from DS7PR19MB5688.namprd19.prod.outlook.com (2603:10b6:8:73::14) by
 SJ0PR19MB6631.namprd19.prod.outlook.com (2603:10b6:a03:47d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 20:58:28 +0000
Received: from DS7PR19MB5688.namprd19.prod.outlook.com
 ([fe80::8a3d:eb18:7201:9c8e]) by DS7PR19MB5688.namprd19.prod.outlook.com
 ([fe80::8a3d:eb18:7201:9c8e%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 20:58:28 +0000
From: James Ogletree <James.Ogletree@cirrus.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: James Ogletree <jogletre@opensource.cirrus.com>,
        Fred Treven
	<Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles
 Keepax <ckeepax@opensource.cirrus.com>,
        James Schulman
	<James.Schulman@cirrus.com>,
        David Rhodes <David.Rhodes@cirrus.com>,
        Jeff
 LaBundy <jeff@labundy.com>,
        "open list:CIRRUS LOGIC HAPTIC DRIVERS"
	<patches@opensource.cirrus.com>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK,
 TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Thread-Topic: [PATCH v5 4/5] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Thread-Index: 
 AQHaP17EFm09wiwp9km197ze4eTGobDNm1eAgAR1GICAAAfzAIABDb0AgAEakwCAAhwmAIATNIWA
Date: Wed, 24 Jan 2024 20:58:28 +0000
Message-ID: <2A915018-D0C7-4109-8CAC-177D87A76863@cirrus.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
 <20240104223643.876292-5-jogletre@opensource.cirrus.com>
 <ZZoFUwOEF6NByIp2@google.com>
 <564A2601-4933-4BD7-B4E6-C973A585CA61@cirrus.com>
 <ZZ3JNuLp-ZfGOQRF@google.com>
 <42A07166-6569-4872-B5E0-6D71C6F3656D@cirrus.com>
 <ZZ-YhtIulqrSFc3R@google.com>
 <F1282174-6152-4EC3-BF53-2EDAA3CBB838@cirrus.com>
In-Reply-To: <F1282174-6152-4EC3-BF53-2EDAA3CBB838@cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5688:EE_|SJ0PR19MB6631:EE_
x-ms-office365-filtering-correlation-id: 98c895ca-d19a-453c-5f28-08dc1d1f36f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lFwmIwp3Wyv8/yNL9Zypmma08G5mtasyShczJTufmLolnYkfUTu1JcsIxGTxy3lAE6WvsjfLEhe1Xr8LqUS19c0Gc/epAbdUaRAcCfKqNuktx62BS+LzxkucJp9a9JhiBTUUScW9y+3tHrJl0NEvMRvE5n80cgshSkCKCATv7TeHOaxEs71MNEUG0lMKSeJ16dW5Vrd3Cyq+SM8fP7FqRk2utKLtKo0m6v1lHct3Zl2k0Phwcp9q6Bufv4bRfIdrXdCt9KV4nX0py6g672akZ3muU+CGSWJOQjThVR1xkWjQPHJ02///D1CVXmLX0qCOEIRZoJHJlOS56JV+hpA4KZ8ySSOaco/+DDvJKADYhcEueqO8rSjXMhb9Ue2tOkqIEIYMALXvywTpdKHNRvF8g5ev46npyBY3UUjDm/8cuznqfGia5AndjsDBY02vfZMTmljxQkhOjKJxWCaqrFD5ctNInwwDJhe1c5jp6Sj/KW07TCNRnCIYAWnwLTNS7NMIRUR3Eb0rTLjTZtmLOdJLrFuyMskRIUQp7mWLxEewsrvh0rkyk2ULa9vYwE7bbyRXHsmvWgtc6mcJV/doaYxbRPsLtnTayBXLOVw8KhZh5HElCMd6Ymhxzq8Q59wqNQgbpwFc+zTD2Vq0kB2taRiO8w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5688.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(396003)(376002)(136003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(91956017)(36756003)(86362001)(33656002)(38070700009)(41300700001)(6512007)(66946007)(26005)(122000001)(38100700002)(6486002)(2616005)(54906003)(76116006)(53546011)(66446008)(66556008)(64756008)(316002)(71200400001)(478600001)(6916009)(66476007)(6506007)(5660300002)(4326008)(8676002)(2906002)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TEN1cTNQNUZtaVlkd3hPUXNpRjhjcDFNWFV2bXk2ZjVaRG1xc2N0dlhhZ3FP?=
 =?utf-8?B?UStWclhvclpLVVM3TkRkNjQ4ZXRQL0RyUzI1cGY0aDlDRmFseU9wb0Nmc0pv?=
 =?utf-8?B?SXVjUFRJSnUydW1XYVhBQVQ0R1Z2MDZHN09JRU5JSmMvOVBCRlduWUZLeWQ4?=
 =?utf-8?B?K1NlbWVTQnJzMmhLYm5LcWN1QWZFa2F2RXh6aldIVDk3YlRyTHB5REZpNm81?=
 =?utf-8?B?MFpock1GYnRzL09BZUNhbVplN1pTcFZpOHhOdk14S2NNQnU5OWJWUXM4cUJN?=
 =?utf-8?B?Q3dhZjl6azVHWG5jS1FLZ2V0ZVdGVnZnTFNoN0xQZFBtdktrRStPVWttbWts?=
 =?utf-8?B?UW5FQkk4Y013KzFOVE9UcmNPckJIN0VHZ3k2VUNubTZwRCtBcWs3Z29SK3pw?=
 =?utf-8?B?UU9rdUxkZEhSZDhjYVJxdEhxYkdReXVhUUh5ckZaZlptcml6SDZtVms0RHVO?=
 =?utf-8?B?YktDS01JWkU5ckt2UE5teFBEaFRHc0hNcmtGMG1GcDhoclMwRnVGd1p4eVR4?=
 =?utf-8?B?cFhyWElBR3A1UHR4aWxua21uSzltWHJ0dXI3Vi9KbXg4WWk5RVlwTUNJeFJW?=
 =?utf-8?B?RkI0TUtBL3NFTDQ3YVZzRDNaTCtFcEJycGVZOEMzYTR3aDZDaGF6VEp1L0dt?=
 =?utf-8?B?SGNzb0F4cmVUcU9IZ2p1R1FTQThxUENFM2ZneFJycUlnV21pWjc4b3hRY1Bv?=
 =?utf-8?B?REtTYUxleHhCU0VPRXJvNS9TUVl5MjBIRHFQTmdWR1JLSHpDWC84a1FoeHhu?=
 =?utf-8?B?N3lHU0g3ek1Odkt3SzNBREprNlVHQmUrcWQ0TkNMb2JmQ1h1T0lCV0g3Tm83?=
 =?utf-8?B?YjBkRno0c1pVSnVWMHcwYUJoWGc2SXhrSTF5UnFSWWcxbmR4MUVXTU5hT29X?=
 =?utf-8?B?OHhhMmcvR2RXeHFWTzc0SjUrUDgzVXRpcHFEU1paZERDeXY4UzV5U1lGdTZS?=
 =?utf-8?B?TWxSQ2Y1T0tZSlYrYmE4Uk1zWE5rMHFmczlxcm5Bekl1SHJ5Tm83MzNIK3FI?=
 =?utf-8?B?dkoyZHM1VnZ2TGtubTI5M2VyOTUzYWxaVFFveEpyK1o2bW84N056TDgyU3Q0?=
 =?utf-8?B?akxzQzlMdjFVbDBTblpRN0ttTFBiRWo4aFQ4Y0RHMTFrcFpxSHhsUHppdjZv?=
 =?utf-8?B?T3AwRXR4TE1EcmpDTUJ0NHFDakd5MW96R0dMY2VBMmhBblRGZHZKN2c5bjVp?=
 =?utf-8?B?bm1WeHE4SFdXL3lGMkdIMFhNQ0hDNVdocjVudmN6K3l0bHcvS2lGNVRjemNo?=
 =?utf-8?B?SitvdjFrOGo1Y1A4V3psTkVaR3hQc0lrSG42SEtzK1NTOXBOY3N0VnRLSi9U?=
 =?utf-8?B?R2d0dDBDQ0JGY2xURWFxamlOS0VFa3IydHd4cUVhNGlVWitEcW12ZHlUWUV0?=
 =?utf-8?B?cy90UHVBTm41N1F6UGxENytzbVZoaVJ6UmdqWkF5TzhUeWh1K3VZRzNBOTRx?=
 =?utf-8?B?aklpMzVvdTFBR0ZuRS9MVHZ4bDh0SUF3Q2g3eUJiMldxMWMxTDFENmFlakIv?=
 =?utf-8?B?MFpTc3cwTitGaElLaklCRHJTcUR4WnQwOWlLNE8xZ280Rkd2OVJoaEQxdC81?=
 =?utf-8?B?bTRDN1VsMnpCTHh0RzErNm5pQllhcDlscEJNVDNOcHJZSVRiWGZPVkVackEr?=
 =?utf-8?B?TmtaL1F1a2gwRE1KUU43M3lnWDQ5U2ZiY1YxeThHZ3ZoM292ckROTXhjYWtl?=
 =?utf-8?B?dTUzN0NsdWNRekVTeFFjQ0dqQkxFV0JVcUljZlROSTg1VHliNHpHS2ZHV2hD?=
 =?utf-8?B?Wm40V1FqZ29kVmdra0VKT2dRckRwWXk5RDJlRzJaYXZiSTlxbFpRNzFZRVV6?=
 =?utf-8?B?NEt4cmZJSmRiaEtzVkhlYUQ3OHRiMlppVFQ4VWNUMlVhRk9HYklVWUh6UVNt?=
 =?utf-8?B?NzNEWlNkaTNCdXZFYlhlYWxzSU5GcUZXUDVHRHF5ODJDdGlOWGFWU2pMNm1K?=
 =?utf-8?B?NWFEMnNJRXdMd2ZYV3pvVFNlblpUNzY2TXVmZVZVY0poVkR2djluM1ZxbEZQ?=
 =?utf-8?B?MmJ5MGJEZVhuTklodm1ieHdqaXV3SGlYMmpKQjdTTm9UR21Hbi9SWUVTVVNL?=
 =?utf-8?B?K0t4VzVLQW93M2g0L0xIU0RLejNmTEpsOWIvaDR0QUJFY2xKZ29DbmVTRUJE?=
 =?utf-8?B?aHFhZjFmdy9oWnRVNEpPR0UyL0N5Q2c3VjJTVGdJTUMwN3cyeGxNNGdQc1lI?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5889E8686147E41ADEC81E7DF48ACEA@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5688.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c895ca-d19a-453c-5f28-08dc1d1f36f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 20:58:28.2801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsZlq6/on4KU4GE6G+2jczbgjagEgn89kH0MFnyJaRmgWZFCtcW9Q7ElZ8XqX6Ii0MQ85VQ9h6lW5ogezDP0xPtNTlgEjafSSkfaheFp6ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6631
X-Proofpoint-GUID: Kw_1lCaNBJE8KNs5xQPyxUsMFTAvtxsc
X-Proofpoint-ORIG-GUID: Kw_1lCaNBJE8KNs5xQPyxUsMFTAvtxsc
X-Proofpoint-Spam-Reason: safe

SGkgRG1pdHJ5LA0KDQo+IE9uIEphbiAxMiwgMjAyNCwgYXQgOTo0MSBBTSwgSmFtZXMgT2dsZXRy
ZWUgPEphbWVzLk9nbGV0cmVlQGNpcnJ1cy5jb20+IHdyb3RlOg0KPiANCj4+IE9uIEphbiAxMSwg
MjAyNCwgYXQgMToyOCBBTSwgRG1pdHJ5IFRvcm9raG92IDxkbWl0cnkudG9yb2tob3ZAZ21haWwu
Y29tPiB3cm90ZToNCj4+IA0KPj4gT24gV2VkLCBKYW4gMTAsIDIwMjQgYXQgMDI6MzY6NTVQTSAr
MDAwMCwgSmFtZXMgT2dsZXRyZWUgd3JvdGU6DQo+Pj4gDQo+Pj4+IE9uIEphbiA5LCAyMDI0LCBh
dCA0OjMxIFBNLCBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+IHdy
b3RlOg0KPj4+PiANCj4+Pj4gT24gVHVlLCBKYW4gMDksIDIwMjQgYXQgMTA6MDM6MDJQTSArMDAw
MCwgSmFtZXMgT2dsZXRyZWUgd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4+IE9uIEphbiA2
LCAyMDI0LCBhdCA3OjU4IFBNLCBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFp
bC5jb20+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IE9uIFRodSwgSmFuIDA0LCAyMDI0IGF0IDEw
OjM2OjM3UE0gKzAwMDAsIEphbWVzIE9nbGV0cmVlIHdyb3RlOg0KPj4+Pj4+PiArIH0gZWxzZSB7
DQo+Pj4+Pj4+ICsgcXVldWVfd29yayhpbmZvLT52aWJlX3dxLCAmaW5mby0+dmliZV9zdG9wX3dv
cmspOw0KPj4+Pj4+IA0KPj4+Pj4+IFdoaWNoIGVmZmVjdCBhcmUgeW91IHN0b3BwaW5nPyBBbGwg
b2YgdGhlbT8gWW91IG5lZWQgdG8gc3RvcCBhDQo+Pj4+Pj4gcGFydGljdWxhciBvbmUuDQo+Pj4+
PiANCj4+Pj4+IE91ciBpbXBsZW1lbnRhdGlvbiBvZiDigJxzdG9w4oCdIHN0b3BzIGFsbCBlZmZl
Y3RzIGluIGZsaWdodCB3aGljaCBpcyBpbnRlbmRlZC4NCj4+Pj4+IFRoYXQgaXMgcHJvYmFibHkg
dW51c3VhbCBzbyBJIHdpbGwgYWRkIGEgY29tbWVudCBoZXJlIGluIHRoZSBuZXh0DQo+Pj4+PiB2
ZXJzaW9uLg0KPj4+PiANCj4+Pj4gQWdhaW4sIHBsZWFzZSBpbXBsZW1lbnQgdGhlIGRyaXZlciBw
cm9wZXJseSwgbm90IGRlZmluZSB5b3VyIG93bg0KPj4+PiBjYXJ2ZW91dHMgZm9yIHRoZSBleHBl
Y3RlZCBiZWhhdmlvci4NCj4+PiANCj4+PiBBY2ssIGFuZCBhIGNsYXJpZmljYXRpb24gcXVlc3Rp
b246IHRoZSBkZXZpY2UgaXMgbm90IGFjdHVhbGx5IGFibGUgdG8NCj4+PiBwbGF5IG11bHRpcGxl
IGVmZmVjdHMgYXQgb25jZS4gSW4gdGhhdCBjYXNlLCBkb2VzIHN0b3BwaW5nIGEgc3BlY2lmaWMN
Cj4+PiBlZmZlY3QgZW50YWlsIGp1c3QgY2FuY2VsbGluZyBhbiBlZmZlY3QgaW4gdGhlIHF1ZXVl
Pw0KPj4gDQo+PiBJbiB0aGlzIGNhc2UgSSBiZWxpZXZlIHRoZSBkZXZpY2Ugc2hvdWxkIGRlY2xh
cmUgbWF4aW11bSBudW1iZXIgb2YNCj4+IGVmZmVjdHMgYXMgMS4gVXNlcnNwYWNlIGlzIHN1cHBv
c2VkIHRvIGRldGVybWluZSBtYXhpbXVtIG51bWJlciBvZg0KPj4gc2ltdWx0YW5lb3VzbHkgcGxh
eWFibGUgZWZmZWN0cyBieSBpc3N1aW5nIEVWSU9DR0VGRkVDVFMgaW9jdGwgb24gdGhlDQo+PiBj
b3JyZXNwb25kaW5nIGV2ZW50IGRldmljZS4NCj4gDQo+IElzIGl0IHBvc3NpYmxlIHRvIHNwZWNp
ZnkgdGhlIGRldmljZeKAmXMgbWF4aW11bSBzaW11bHRhbmVvdXMgZWZmZWN0cw0KPiB3aXRob3V0
IGFsc28gcmVzdHJpY3RpbmcgdGhlIG51bWJlciBvZiBlZmZlY3RzIHRoZSB1c2VyIGNhbiB1cGxv
YWQ/IEl0DQo+IGxvb2tzIGxpa2UgYm90aCBhcmUgdGllZCB0byBmZi0+bWF4X2VmZmVjdHMuDQo+
IA0KPiBCZXN0LA0KPiBKYW1lcw0KPiANCg0KSXMgdGhlcmUgYW4gb3Bwb3J0dW5pdHkgaGVyZSBm
b3IgYSBzdWJzeXN0ZW0gY2hhbmdlIHRvIGRpc2Fzc29jaWF0ZSBtYXgNCnVwbG9hZC1hYmxlIGVm
ZmVjdHMgYW5kIG1heCBzaW11bHRhbmVvdXNseSBwbGF5YWJsZSBlZmZlY3RzLCBvciBpZiBub3Qg
d2hhdA0KZG8geW91IGFkdmlzZSBpbiB0aGUgY2FzZSBvZiBhIGRldmljZSBpbiB3aGljaCB0aGUg
dHdvIGRpZmZlcj8gT3IgaXMgdGhpcw0KYSBtaXN1c2Ugb2YgdGhlIHN1YnN5c3RlbSBpbiBzb21l
IHdheT8NCg0KQmVzdCwNCkphbWVzDQoNCg0K

