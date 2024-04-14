Return-Path: <linux-kernel+bounces-144094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE558A41BA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57ECE28199B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE41124B29;
	Sun, 14 Apr 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="fIYDoXSX"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489B218AF4;
	Sun, 14 Apr 2024 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089401; cv=fail; b=PhEiNDcrBRQ+qQFHM3BFgTG0oEZ9duxLftnU58pe3ngNkzeqOcVEwf1lX3xANixyXXg/pod2mMm364+qUmqxh+3J67cUYQAB+x3P742E3u6IAx5R77j0JqM9DacJ+jc8IpCl4tQNXzebXs4I5aT84M6t9DBAdY4lYm7buETvS9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089401; c=relaxed/simple;
	bh=VavTB5beKyf7KLMKtSMZJPxiMzoXBigaj9Co9mVK73Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZiJnAveiqIK775fMlsIWB3hgaoUjw910hysK/ox3I3VyLhlH1nPEeA+HEWUz54MwMv4sc4st3L2Chmk1p9AnTJjyj8/TULbCuRfQx8IguYXZV2BuIqYAm3kyPh23+/VXj3phlrFDkpXKoj7uNGvHRObZ/IUiHNQAVxohx2vWtN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=fIYDoXSX; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EA01pe004996;
	Sun, 14 Apr 2024 03:09:46 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xfsjg1rdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 03:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8mLfRGiz2xpE24LBrPjfHEBZkoafgwR6D3CQaHRE1ZeuDGP/agq/PUGUZazPP0NVfijb7dmNwqIE9Ta+Kzk1EYdepAYlJfD5KG+1USUDPXfObNb4wo+ctBFSG1fgi5POn2bxhYLQJ5wH4QnhKapFCEC2Q/AUImh/fsXed8jVWkU/JSOpJMnEdc0GeuQr9n7jV0lbfkm3J3LZARbkfHckdRYjRQ4KX6q3dvLI9rmdiVlaOVdv6yCGo440uowX0CWFJzEvUXKNu5YoqVcDHpHKpgJ8SmvzhVfPXs5wZC5VtdHMKACgt8iYEI5eEcettChHuLFToIhD/ymAR4FgP0kmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VavTB5beKyf7KLMKtSMZJPxiMzoXBigaj9Co9mVK73Y=;
 b=m4svmrc5ii/ggVTFfKKUo9yoQt1axeNr8dudmAYOhTK1icSJKk7KFeIpy6d4+C9iuXpiCnrpJObMSWUuAnd7WY1Y67gOS7wC01pkZ0bEgITfPGKYKEnDST4uipzuubt55Gmu8iB3Pf1Xbxnn1DhTAqoXeW6Bu9mU+upYlL6uh9farhdt9mJ7GUSjd3Mkj1Yyg7R5aSnHajQq+J0eLTOWuSZY/IMnzBAj+QfWpHgsSPibkuWPaCi8IxabJfKVZZi8aRq5Kq4gOvEVmnRoV0uCGK/WKE+CJ4kpIMcjyr0BalkoEJ1ON+q873VO6VLSnoX4zfls4Qes9U3P3fVEymDTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VavTB5beKyf7KLMKtSMZJPxiMzoXBigaj9Co9mVK73Y=;
 b=fIYDoXSXa/zM4vojKUn0Tgs2pYLVNJiP1ww7Ydbmt7iq6Yse8ZkCeKU5dStrGJwoztWgEGQYhjtI6QOCtzYZYS3EMd7Th+iVuyZAqm0zGKvwmwUpMy3vSjwmhKWuCM8glk0gFBmVmbRV89bGKyuuYpRp8wYz4mtstVD2J2S6REg=
Received: from PH0PR18MB5002.namprd18.prod.outlook.com (2603:10b6:510:11d::12)
 by DM6PR18MB3508.namprd18.prod.outlook.com (2603:10b6:5:28f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Sun, 14 Apr
 2024 10:09:41 +0000
Received: from PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0]) by PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0%7]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 10:09:41 +0000
From: Linu Cherian <lcherian@marvell.com>
To: James Clark <james.clark@arm.com>,
        "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Anil Kumar Reddy H
	<areddy3@marvell.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Subject: RE: [EXTERNAL] Re: [PATCH v7 2/7] coresight: tmc-etr: Add support to
 use reserved trace memory
Thread-Topic: [EXTERNAL] Re: [PATCH v7 2/7] coresight: tmc-etr: Add support to
 use reserved trace memory
Thread-Index: AQHacECxPyWnte/kREqCV8A8RzaH07FknyeAgAMnmXA=
Date: Sun, 14 Apr 2024 10:09:41 +0000
Message-ID: 
 <PH0PR18MB500263D63DD07EF1C28017C8CE0A2@PH0PR18MB5002.namprd18.prod.outlook.com>
References: <20240307033625.325058-1-lcherian@marvell.com>
 <20240307033625.325058-3-lcherian@marvell.com>
 <3c5c85d4-8657-4ee0-88fa-ee47dce4cc7c@arm.com>
In-Reply-To: <3c5c85d4-8657-4ee0-88fa-ee47dce4cc7c@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5002:EE_|DM6PR18MB3508:EE_
x-ms-office365-filtering-correlation-id: 2084e9e5-f519-4cd9-72aa-08dc5c6b0036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +o+l2aocjHk5/qPLQv9FO0VR8quXgBw48dJ3MIYwdXNTIoQa1ZRaBDpcEoVowI7uPkvnD7rmvtYafZnAhc+FFOgx6sYrEjUA6BENRYA+miRalnHSeRc3ESe0lZuh0DOlUC6nrKNK4Exd8cOYKufPMJYb5Xo4Enx5ctWF8gl5Bt/Jc5rU2O4pwz4j8qmEJjHBWjZDFGEG6MfoEyNUc/wNNbI8xc5BKAdh5o0G+BlR8Nr3/HriQfGLN3Qt4miiN010u6GoJ4+VotWsj7IfjaHDgkh0yzMH31SMBOjPClKbvzsER2d8n0WAYk7hTi2AhnxT3kWgDc/rNobP+orFMMNFzSw/FR8Tqvr/xT81k5SiibQjkDAaMYT7KohQi3liRWNndJECEyZqEVo48Q3P64/7zHHT9XN1FmUrQAgCQ54JD6ZBW1ihcjho01+cRwQRQIYKqVY47Hvr3t2e1D8oxw+aRQ7m0IYCQ8ayNI5Tm02p/A1+aGpuYIQErTEmPn1DtClriPjq/pYmKahkFRR/hqnGWCH56XawN4UZm+q1Wp720FxKjRsLMpQFocPxXLwoOTPog5oR9U68Tvc3fFnCJSMU4390hiq8M1I2sysCHCQ/G4s9mZF8X6WJe930fiPKh0okuFGnTngE7spPEmJms0FQXqeQy9FVe3kcnFMVmqkN0MbKjt5E8K1UmTt5LghEO3mKoYjAhZP1XXMB5zSP7PI6V5t6Fniz/aD0s4/t+TW8sZk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5002.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VnM4MWwxZGZ6WHdwOUNlOXNhODBxVzY5NjFVVWVweUtpd2FEZjhCRXFFRzB6?=
 =?utf-8?B?TTJNNnU5eVRYeGVENTE5Y0FvbkhVUG1aSGU1aHRSRU5FZ0VwSGpUdTgzWVRw?=
 =?utf-8?B?cngxN29xWFBaQ0doMWVLckp6M3N2VFpzSlU2cTdaZTVtcVJseGpYSVJuemRm?=
 =?utf-8?B?QzJOWTNId1VQbnBxOTRtSk9JQTRNL3l6WDQ5VzBYQkRHZ1BrMzl1b2g5eko4?=
 =?utf-8?B?WW5XS2wwRmFZekgzeUFRNFprbDlqMzl4c3FXVXd0NUwzVUFEcENEMG1sbFRt?=
 =?utf-8?B?TmNVYnBEc0dBZEt3NnpGTGxhODZDNURrMDJzWDFpM2ZJZ1FlcmNQRTNxL2p0?=
 =?utf-8?B?MDB0bG5VSHpzUCtCZExDcjdzbHYrUkt4YmkyWmVYZElrS0dLWkZkdjlkekNv?=
 =?utf-8?B?UDl1K1hNQm5SUFV2Y2x2UG1rUlJlOXlWUG9OZkNnOUNGbjZGQmw2SFBXV1FT?=
 =?utf-8?B?dHJrdmdnSHV0eFh4UzZadFJkcEczQVhEUUZOTEpQN0xLUGNEYklZeHYvTnBN?=
 =?utf-8?B?UENVclRKbjZHeElMM09pMzBKQXN2ZUN5YTliUjY4b3MyOEJtQnlTa1V4azEr?=
 =?utf-8?B?cGVkU1RhcUpQcEs5dGY1T05wZGFsNlVYMFJKQ241UzdtLzBMY1psYjFNZFFZ?=
 =?utf-8?B?TnVCdVBVU3B3eEFMdDhxOGNpYUhOM1pCY25qV0l1em1hSFArdnY0RzdhQW0x?=
 =?utf-8?B?RjFMNVBrYklKNlpBL1NrUm14VjBqSHJDUUN4NmJTVHJXNjlKQnFIU29IdU1U?=
 =?utf-8?B?SldUVEhxa0J3c3lJVS9UalUyOEJpSTY0TkxlYVZOYWowbVc1NjlDWnlybkFH?=
 =?utf-8?B?dWxrWGNxays1RTB6dFZORHp0MDJ6U0FxN3dtWU1PSjdpQ044ZmVpOTc0dm4x?=
 =?utf-8?B?M3Q2elc2Wldjcy9kLzM5RFo3c1lBM2NmMkhDcUFydEZXQ3lESzB5T01LNDdS?=
 =?utf-8?B?NEYrOThhVWo4a2JQb0pnbFkzUHhRNlVNbGQ3NGpnR09aNXhRSzVQK2FRQXR2?=
 =?utf-8?B?a3ZoamtETnJvdmFoa1Y2cE9oZzV0amUzZHpqSFlCOGFUUVY3M1Y3L3NLNFRE?=
 =?utf-8?B?R3lqWWZVelpYSzljTGpGQStGdStxcFJjQzhHYW9lOHdNWDQ4STJXN3JrMGFB?=
 =?utf-8?B?TmtZN1FjckVVbXhITUxmYmNXeEs1QTRsa1p5Y2ZneldRempaNkhtTkgwTDg1?=
 =?utf-8?B?c3UwUEdjYWY0eHhEYXVGUjQrNTlERU9FaHhhcEFLTTV3REFYU1htYVlJanl4?=
 =?utf-8?B?cnRFd0pLdTFZMDFMcWdwN0hoODdkVDBXWmVSUTllSzRYUFMwY2ZlZXBRenlB?=
 =?utf-8?B?VXBQdzJ3SU9IZzg3ZXNLZlNqdHhSMEZQKys0ZzNVMEp3dGFZWlJDZXdQYzV3?=
 =?utf-8?B?dkJnV2h5TTFWK3NRMXE1R0U5VEhlT1EvZVdxMjVvUGNlMnNOd0NIYTNkamlF?=
 =?utf-8?B?WXhEMTVxaDZ3U08zTWd5VWZ3ODNVOEE1TGw3aXFubWtZWU5MMWZsdlNReHJU?=
 =?utf-8?B?RDZwVWFDYk5ibjczay9wMlNnUUtCZmxSS0NvQkszV3BMZVFLVm0rREpwaWxk?=
 =?utf-8?B?eXhzZUFsMCtHTm1mK2RYcjJyU2QydE02TDRPaGh4eFlFbmpMNFJOdXdOK0RK?=
 =?utf-8?B?am5xdlJMaFNGcFpIZTF3Q0JNL1dkMlRjcklkdjNHOEM4aXh4bWhHeC9EUkFS?=
 =?utf-8?B?bzd0SFR3WFB5ekdhMWI4Zzd3RXNFd3RRdjNuSzRxVll6dXR5Q1o0NU1uUmZz?=
 =?utf-8?B?dW1uYTZlUWNLQVE3SzdDV1U4dW9zblV4RHVSWHdDSmpWc1ZUWm9hQlZGS2Zs?=
 =?utf-8?B?Qzd4aU0ySWNCaFpyQnR1ZFZVTUN5S3J1TW90WmFacWJCV3htWE01Mm5kTVp6?=
 =?utf-8?B?cW1tMzdvckRlNFZwR0U1Ymd3aHp5d0ltVzBTNWVHMHpRNDVMSlpSKzVMTHNN?=
 =?utf-8?B?eXpBNVpjWDBSTHVhTUk5V0FVQ0NsMENCWjArRjVtWFI0TDczbWVwRG84VjNN?=
 =?utf-8?B?WU1nYlpiN3Q0MWlKUjU3YVQ0b3ZHMDhKUEJTd0UzcEtncm42ZVY5NURROE5u?=
 =?utf-8?B?Sm1idUN5aFY1ZGg1OFduSHA3OW92YlF1WHBObkMxTXpxMXZrbTlZRE9abXZ2?=
 =?utf-8?Q?ETayiQX/t8wQuW8JUjWbw5vUw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5002.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2084e9e5-f519-4cd9-72aa-08dc5c6b0036
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2024 10:09:41.4182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKYtVKVprpCzIfRxj3RNXluoqaYKmutyl83pK9nj1tPD3XniYjnCl2IzTtWV3peTrYOXz3+hMT3AvkidsuHyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3508
X-Proofpoint-GUID: 1tNlyHCW5VDwQ4nPLDFjcxm6SAF1oZrf
X-Proofpoint-ORIG-GUID: 1tNlyHCW5VDwQ4nPLDFjcxm6SAF1oZrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_11,2024-04-09_01,2023-05-22_02

SGkgSmFtZXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMg
Q2xhcmsgPGphbWVzLmNsYXJrQGFybS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMTIsIDIw
MjQgMzoyNyBQTQ0KPiBUbzogTGludSBDaGVyaWFuIDxsY2hlcmlhbkBtYXJ2ZWxsLmNvbT47IHN1
enVraS5wb3Vsb3NlQGFybS5jb20NCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgY29yZXNpZ2h0QGxpc3RzLmxpbmFyby5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2kr
ZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IFN1bmlsIEtvdnZ1cmkgR291dGhhbQ0KPiA8c2dvdXRoYW1AbWFydmVsbC5jb20+
OyBHZW9yZ2UgQ2hlcmlhbiA8Z2NoZXJpYW5AbWFydmVsbC5jb20+OyBBbmlsDQo+IEt1bWFyIFJl
ZGR5IEggPGFyZWRkeTNAbWFydmVsbC5jb20+OyBtaWtlLmxlYWNoQGxpbmFyby5vcmc7DQo+IGxl
by55YW5AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjcgMi83
XSBjb3Jlc2lnaHQ6IHRtYy1ldHI6IEFkZCBzdXBwb3J0IHRvDQo+IHVzZSByZXNlcnZlZCB0cmFj
ZSBtZW1vcnkNCj4gDQo+IFByaW9yaXRpemUgc2VjdXJpdHkgZm9yIGV4dGVybmFsIGVtYWlsczog
Q29uZmlybSBzZW5kZXIgYW5kIGNvbnRlbnQgc2FmZXR5DQo+IGJlZm9yZSBjbGlja2luZyBsaW5r
cyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiANCj4g
T24gMDcvMDMvMjAyNCAwMzozNiwgTGludSBDaGVyaWFuIHdyb3RlOg0KPiA+IEFkZCBzdXBwb3J0
IHRvIHVzZSByZXNlcnZlZCBtZW1vcnkgZm9yIGNvcmVzaWdodCBFVFIgdHJhY2UgYnVmZmVyLg0K
PiA+DQo+ID4gSW50cm9kdWNlIGEgbmV3IEVUUiBidWZmZXIgbW9kZSBjYWxsZWQgRVRSX01PREVf
UkVTUlYsIHdoaWNoIGJlY29tZXMNCj4gPiBhdmFpbGFibGUgd2hlbiBFVFIgZGV2aWNlIHRyZWUg
bm9kZSBpcyBzdXBwbGllZCB3aXRoIGEgdmFsaWQgcmVzZXJ2ZWQNCj4gPiBtZW1vcnkgcmVnaW9u
Lg0KPiA+DQo+ID4gRVRSX01PREVfUkVTUlYgY2FuIGJlIHNlbGVjdGVkIG9ubHkgYnkgZXhwbGlj
aXQgdXNlciByZXF1ZXN0Lg0KPiA+DQo+ID4gJCBlY2hvIHJlc3J2DQo+ID4vc3lzL2J1cy9jb3Jl
c2lnaHQvZGV2aWNlcy90bWNfZXRyPE4+L2J1Zl9tb2RlX3ByZWZlcnJlZA0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQW5pbCBLdW1hciBSZWRkeSA8YXJlZGR5M0BtYXJ2ZWxsLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBMaW51IENoZXJpYW4gPGxjaGVyaWFuQG1hcnZlbGwuY29tPg0KPiA+IC0t
LQ0KPiA+IENoYW5nZWxvZyBmcm9tIHY2Og0KPiA+ICogUmVtb3ZlZCByZWR1bmRhbnQgZ290byBz
dGF0ZW1lbnRzDQo+ID4gKiBTZXR0aW5nIG9mIGV0cl9idWYtPnNpemUgdG8gdGhlIHJlc2VydmVk
IG1lbW9yeSBzaXplIGlzIGRvbmUNCj4gPiAgIGFmdGVyIHN1Y2Nlc3NmdWwgZG1hIG1hcCBpbnNp
ZGUgdGhlIGFsbG9jIGZ1bmN0aW9uDQo+ID4gKiBSZW1vdmVkIHRoZSBzcGVjaWFsIGNhc2luZyBm
b3IgRVRSX01PREVfUkVTUlYNCj4gPiAqIEZpeGVkIHRoZSB0YWIgc3BhY2luZyBpbiBzdHJ1Y3Qg
dG1jX2RydmRhdGENCj4gPg0KPiA+ICAuLi4vaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQt
dG1jLWNvcmUuYyAgfCA0NyArKysrKysrKysrKw0KPiA+ICAuLi4vaHd0cmFjaW5nL2NvcmVzaWdo
dC9jb3Jlc2lnaHQtdG1jLWV0ci5jICAgfCA4MiArKysrKysrKysrKysrKysrKystDQo+ID4gIGRy
aXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQtdG1jLmggICB8IDI3ICsrKysrKw0K
PiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE1MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiA+DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiAgc3RhdGljIGJvb2wgZXRyX2Nhbl91c2VfZmxhdF9t
b2RlKHN0cnVjdCBldHJfYnVmX2h3ICpidWZfaHcsIHNzaXplX3QNCj4gPiBldHJfYnVmX3NpemUp
IEBAIC04NzQsMTMgKzk0NywxMCBAQCBzdGF0aWMgc3RydWN0IGV0cl9idWYNCj4gKnRtY19hbGxv
Y19ldHJfYnVmKHN0cnVjdCB0bWNfZHJ2ZGF0YSAqZHJ2ZGF0YSwNCj4gPiAgCWlmICghZXRyX2J1
ZikNCj4gPiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPg0KPiA+IC0JZXRyX2J1Zi0+
c2l6ZSA9IHNpemU7DQo+ID4gLQ0KPiANCj4gSGkgTGludSwNCj4gDQo+IE5vdCBzdXJlIGlmIHRo
aXMgd2FzIGxlZnQgaW4gYnkgbWlzdGFrZT8gSXQncyBub3QgbWVudGlvbmVkIGluIHRoZSBjb21t
aXQNCj4gbWVzc2FnZSBhbmQgaXQgZG9lc24ndCBzZWVtIHRvIG1hdGNoIHRoZSBkZXNjcmlwdGlv
bi4NCj4gDQoNClllYWgsIHRoYXQgY2hhbmdlIHdhcyBieSBtaXN0YWtlLiBTb3JyeSBhYm91dCB0
aGF0Lg0KDQo+IFBsZWFzZSBtYWtlIHN1cmUgdGhlIGN1cnJlbnQgdGVzdHMgcGFzcyBib3RoIHdp
dGggYW5kIHdpdGhvdXQgYSByZXNlcnZlZA0KPiBidWZmZXIgZGVmaW5lZCBpbiB0aGUgRFQuIEkg
Z2V0IGxvdHMgb2YgZmFpbHVyZXMgd2l0aCB0aGlzIHBhdGNoc2V0IGFwcGxpZWQgb24NCj4gTjFT
RFAuIEVURiBzZWVtcyB0byB3b3JrIGJ1dCBFVFIgZG9lc24ndDoNCj4gDQoNCkFjay4NCg0KPiAg
ICQgc3VkbyBwZXJmIHRlc3QgLXZ2diAiYXJtIGNvcmVzaWdodCINCj4gDQo+ICAgUmVjb3JkaW5n
IHRyYWNlIChvbmx5IHVzZXIgbW9kZSkgd2l0aCBwYXRoOiBDUFUxID0+IHRtY19ldGYwDQo+ICAg
Q29yZVNpZ2h0IHBhdGggdGVzdGluZyAoQ1BVMSAtPiB0bWNfZXRmMCk6IFBBU1MNCj4gDQo+ICAg
UmVjb3JkaW5nIHRyYWNlIChvbmx5IHVzZXIgbW9kZSkgd2l0aCBwYXRoOiBDUFUxID0+IHRtY19l
dHIwDQo+ICAgQ29yZVNpZ2h0IHBhdGggdGVzdGluZyAoQ1BVMSAtPiB0bWNfZXRyMCk6IEZBSUwN
Cj4gICAuLi4NCj4gDQo+IERtZXNnOg0KPiAgIFsgMTkzOC42MjIwOTFdIGNvcmVzaWdodCB0bWNf
ZXRyMDogVW5hYmxlIHRvIGFsbG9jYXRlIEVUUiBidWZmZXINCj4gDQo+ID4gIAkvKiBJZiB0aGVy
ZSBpcyB1c2VyIGRpcmVjdGl2ZSBmb3IgYnVmZmVyIG1vZGUsIHRyeSB0aGF0IGZpcnN0ICovDQo+
ID4gIAlpZiAoZHJ2ZGF0YS0+ZXRyX21vZGUgIT0gRVRSX01PREVfQVVUTykNCj4gPiAgCQlyYyA9
IHRtY19ldHJfbW9kZV9hbGxvY19idWYoZHJ2ZGF0YS0+ZXRyX21vZGUsIGRydmRhdGEsDQo+ID4g
IAkJCQkJICAgIGV0cl9idWYsIG5vZGUsIHBhZ2VzKTsNCj4gPiAtDQo+IA0KPiBXaGl0ZXNwYWNl
IGNoYW5nZS4NCg0K

