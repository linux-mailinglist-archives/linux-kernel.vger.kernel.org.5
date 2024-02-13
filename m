Return-Path: <linux-kernel+bounces-63972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7287885370C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4D21F299F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626065FDAF;
	Tue, 13 Feb 2024 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="MxpR4BYU"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283D5FBA2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844621; cv=fail; b=usBfd+eRfjndkBJXiHatPgggTMm3jzOFShry0FvUEbn0iiXypUBiv+vNlNZReWJLkJKtkhFeOKqTnv5BAYQkU8V8rYfqvcbxuFWpM14MqfvwZKCwQ31DKCeoXi5vgFZkiEtbAT/0lGR2J9PDtZgrG/G1T9S9afQ8qquGASE2ty8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844621; c=relaxed/simple;
	bh=2+CMoqNYNu9V6kNu8xa1+tDx55jEEJQ8nqjKJdM4LrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VBRMsk+CdYSS2XqfFGh0BhuShiEFDqmqt73B7vB5uc3AW6TyVPDSf6fCECDsX8DLwL6Y6vJYbBdkdWqiA2+tEEumJjQfo8MBslm93CeZeb+Kc0QzOlq9XJW2V588ha7oXFNKF8hSYmumXH3PslXdW6Iz5JjDSfD78MgjYo4JoVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=MxpR4BYU; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355086.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DFc2OZ002769;
	Tue, 13 Feb 2024 17:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=2+CMoqNYNu9V6kNu8xa1+tDx55jEEJQ8nqjKJdM4LrI=; b=M
	xpR4BYUm22x4ynDDw9t9DTxX4nEscN3EmqYoqMgvoJ3ogscCw38kzADCriPQf0bd
	W8i8zfa00yfl1uetnZpbWAHRocoYn33v+ybGR3H8JM95k+Dd/5dRw+HxQV8ZBcFO
	QXf8NGhqM0CUckSS2A5SkUC4eH8Zikd7tdZ8uCK08p4/D7iKmmqed2cBgm5FL6tL
	dzspsimzm31okZETO+1r3RYueq9uxwYx+WuM2bWcQLF8VQnbSDlUNSUf7Vgwr1i2
	WpYt6hnPp70WVXyZDocnuBUO1g8cBdO/wsDrUFLJcxnThvu+826s2Fqi8+DF+w/N
	+iZCPmrVhSzFDZhHWjsEw==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3w7qtr1u7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 17:16:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhfO6kDCQ7DCoUAfcn9h2wrj+UZspn0oBZeJo6WUcl0hFtsXQT7d69jBdBGZitixUM6jt59Qp6DtqErjAYHq2EUDUZSHUGnvHmVD6MknNGskc6SFRqcSxIWOxCYrPQ1/5tBbZeqND1G1aImAnPt9Tb5K5Rj9EkML8U8nNvLXKpMq+3hkjrAw7yId5bC8VpxniKlZgmyrwXc7qgDsc3O/Nc/dqGCce4+H2aQ46aeQ01AihRPdHauh00Kb8ZUJb/sNUZ3/hXSq7OB1AFaKhp86cJenKhY7j/wfOY3qNnMOeOxTC0ByESRFRtnXaiAouzyJex5BHzWX4rR+yQjChTEObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+CMoqNYNu9V6kNu8xa1+tDx55jEEJQ8nqjKJdM4LrI=;
 b=ajy33CtPWaecNSXpmxkO+ioiL9U6REiH9sEl72dmkeTIW7B2Xv0CsqFYXCnZ4QoseMVJ2D1GKrN+OVKgxttqumx2XhFuJI5Q1VHKbC9FIUT1Uu11u5WDJ+zHK0adb+yZCdydipBqdW6t7xw18alZ3FAHSq6CwPCHEh/dOToq3hk4YBowM1ywdonptmMDH04zTECP8CUjz2SjHCYtNQiqvocEwA73qVO4et3VnTWE9VGuvn9zVVeBg7Flx1gX/mGTU3wOATUnE1FGf7CKNpXIQ4zam6D+UijXr9tB8nMVOF10gnv1N9Weykni35EYr73UVVh7SyZS8i74xib6ivq4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by KL1PR03MB5521.apcprd03.prod.outlook.com (2603:1096:820:51::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 17:16:04 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74%6]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 17:16:04 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org"
	<will@kernel.org>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org"
	<tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "shikemeng@huaweicloud.com"
	<shikemeng@huaweicloud.com>,
        "david@redhat.com" <david@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "anshuman.khandual@arm.com"
	<anshuman.khandual@arm.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rmk+kernel@armlinux.org.uk"
	<rmk+kernel@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gshan@redhat.com" <gshan@redhat.com>,
        "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Andrew Wheeler <awheeler@motorola.com>
Subject: RE: [External] Re: [PATCH] arm64: allow post-init vmalloc PXNTable
Thread-Topic: [External] Re: [PATCH] arm64: allow post-init vmalloc PXNTable
Thread-Index: AQHaXpaLs5c/UYyLVkKe7VBqh+veYLEIfpaAgAADJlA=
Date: Tue, 13 Feb 2024 17:16:04 +0000
Message-ID: 
 <SEZPR03MB6786975721BC2C6393731C59B44F2@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com>
 <2024021300-gently-ether-3978@gregkh>
In-Reply-To: <2024021300-gently-ether-3978@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|KL1PR03MB5521:EE_
x-ms-office365-filtering-correlation-id: d503c0d2-e1d6-4a74-79f8-08dc2cb775c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9JyAHdzjP3xwl0ur+eziOpGRz8shKs9K3PqSVd5Tx/+4yP6Rnqk5/xS5Zpi/gTxMLIv8EX874dPODgtaHCUVUHVlKKkrR61BnEGkMCthBsDORUDI2UgZ+ODkBcfY5OU8MYH9JK1fV2tPmLjk//9HhM4dZ6AYOQFmuf6BHbc+8DuZdJ4x8MljcdqSKD1utatEzFCv0FLfQt7IgHcLVmMV1v8jWKAa8gvZRyx4NYKtBR/71ODgb6BKo11gpFNsPTF3QmhEgC7hJqV/w3PJXaAewS1tMx5v2JFAnAZ11Fk3YQVg8oAqz9ACueL2iNKn1xRYK53tQp1vlkFbF9jIPnnjZTBhPsotV89oGNvXjKNJVGPagM8I3x2iQLCG67eU6eqd/sLine094oU5BxPYF9j3sh5BT2wWDIGOOaNYYsre1YFLUK3KPXzrRfPXNmgpdEdVARIJOJB3HQ/BgeU+oDARjpZkj0tK7SYy4vbHzb8yCLVKaqQDWSaAIi/6Veu+mq2J+FJMH/s75/7+n+791grCFzN/deBwwDQWUPKQKRLHb8b03kQLVcc+5qLmS1sucg5vHKQp4BJccFv6ilwGcWAEeKsL/3xhR7w3rYW4amTVhRoNgeIIT39QZe7eysT1bLeL
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(7416002)(4744005)(2906002)(76116006)(66556008)(66946007)(52536014)(4326008)(8936002)(8676002)(66476007)(6916009)(64756008)(66446008)(54906003)(83380400001)(38070700009)(26005)(33656002)(82960400001)(122000001)(38100700002)(86362001)(71200400001)(316002)(9686003)(41300700001)(7696005)(478600001)(6506007)(55016003)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N3BJZ0RJcE1XYk9Pc2V4Nlp3dm1JL2lQYmR1MEVRV2RkS3BwMmNzdzhSa1Rj?=
 =?utf-8?B?MHE5OGphMUg2azh1RXllRzAxOHQ1ZkdTeVNGdHNUNk9qN0x5eFZEaWhldk8y?=
 =?utf-8?B?WXo5OHpCVXByRS9GcXFSYkFGZExNcnhvUHVuclRwdTZmMDdyT1QxUGhEeXJu?=
 =?utf-8?B?RndyMVVLZ2hyblZXc0xnSG04L0ZxWVdOMll6ZkJVNVR6Z2MvQkFxM2wzRm4x?=
 =?utf-8?B?VkdLMFhUQ3pQSFhLT1hhQUtSZCtNUU5SbUNucVFOMFRCTmFqanFSQ1BTTDVG?=
 =?utf-8?B?b0lmb1ppbDE4M2tmZnBqWFJEdUJEcTF5WnNrNklIU1lFYzZMeUViWUY0dktF?=
 =?utf-8?B?SFF3RjNzTGI0SlNudFI3MEVwNzVudDVuUnkvQi80K3d4M0trajFRclB0RGU2?=
 =?utf-8?B?dTNybXFKRTBERnR5bjZPV1U4TVo0L1pNaXVOMXNMWFRBbzh5QWEwOElOajVi?=
 =?utf-8?B?Ukk3ejBvL2lGOUVoZTJ6dVhscVRnb29sUGRmZ1FUWjB6eW4rbUM2cDRKOXpS?=
 =?utf-8?B?NXNSNkdOaUJnblUrVmJ3NW9oOEpTcTZZYXh6RlBuYllod28rSExPbHFNOG9O?=
 =?utf-8?B?Z05QVW1GY2VIWUY1bUJ2TDU1eGYzVjd4SGNMN3hLd25WMWd0Z1NjSGdOUmhj?=
 =?utf-8?B?QmhURDhKQnY3L1pWUXJqK2NabzI0alN2Z1Zmc3IyZUNxelhRejFIYlpWdjRH?=
 =?utf-8?B?a0g5ckF1cktqMU5TZDVoKzU3TjdDelZjUGozTGpaVzRyUGJvSHNGVndva3Iw?=
 =?utf-8?B?MjFvbWU4aHVCSVRlaDVGeUUvWDRyTkl0d0xUU0ZsblltTVY3blVRMWtMamY3?=
 =?utf-8?B?WmlPZXF5VmhkenRqMkNXbmJLSnFQVisvYXN5RGVJQ0I5SHJrV1l3dGFNSzNV?=
 =?utf-8?B?ZUdhU09lUnU4a0JLQ3BuaS9pTWxScVU5OUVuQXExWnlKdHU2UkFBQWJwREl0?=
 =?utf-8?B?OWdZdmR2dkdsU2wyWTRSajlLRnd1M3g1cWpjTUgwVDF2VjRFZ252NExHVGN5?=
 =?utf-8?B?czN4TjRRN3JYcG56Nk13bmRzdDA0NEFCdHV3dk5aS3BiSnBCQlVqVXQ1MjND?=
 =?utf-8?B?cjZuT1UyV2tIdk5BNld1TVIwc28zQUNkRitnNGJHNFZEdUhTRi82eFZ3Rlgy?=
 =?utf-8?B?R3dsL2NkaXhtYjE1d28wdCt3RVdyclJjbTRFMUdVRHRXVFdudERUL29Cdmt3?=
 =?utf-8?B?YXdESnhFdGp0WUNqRUtRMXFzYzR1bWxBcHlPTUZnMm1rdWkyMGRCQkFGUnpX?=
 =?utf-8?B?b2VKZjMxblY4SDkxV2xLaFdQcVMyeUZQdDN2emhMY1grK0VoS1Y5ek5YMG9o?=
 =?utf-8?B?MWlsSVJHcmJBc3U2dmtmMFZHSFVQN3dRZFNvakgzY3NGYXhNUHBFWTFPT2g1?=
 =?utf-8?B?RnVBMlozU2Rlc3NGQXBCaVliSDJka0lmQldtWEJ4WlRFdEhVWlJ3YkFEbytZ?=
 =?utf-8?B?T250VFB4MXptTmJiK3NYMVlVUUpMN3RxTGtVTHpKTHkxK0E5VWprWDJCTGM0?=
 =?utf-8?B?WFNLQjdlUHprbEwzeXZSK3IrcEZsYUlxOUNxTFFtc3k1QWxENVhheGNhZXhN?=
 =?utf-8?B?VWh3TFdmQXNuVTgvY2xzd2NRa09XaWV4YTU0aGQ1T2lWRWJIUzNkb05nbDc3?=
 =?utf-8?B?WTdKOVc4U250NVFPVmNaWDFpb2JBak9VaW53eURHQzg0K1NhWkgzMjRsaVMy?=
 =?utf-8?B?SnlNVGw1blJzSy9zaXd5MWx1MHk4NmlwZ0RXYXNyc1hkNldBaVJna2pwQTd4?=
 =?utf-8?B?SHZiUGNCWlJTK1JDUTRmM3FuTGU5RWZKWGhWKzNSdGJVVnJkRDFueTgwODNi?=
 =?utf-8?B?U2s3cFRsZVBhSFdMci8vSkRaa1Y0Tm4ydW51elJxQWVTM0p3VUk3NGMycERZ?=
 =?utf-8?B?NmhwS0xQWmh0bEJBcnp0SExkeUNwb2Q2NDlNS3VuT1RQdkd5d2lKb1VxY21U?=
 =?utf-8?B?cElVVzA1QU1YaTJNTEtiN2E2STE1MXVJT2pGUDFwSUhPTFFUS1hyb21WMUVE?=
 =?utf-8?B?L1BaSmhCRmI4RWdzY1BxYnhDNE11OU0zTXM3ZHJ5Y1g4OHhuQi9wd2VzR2Zl?=
 =?utf-8?B?Z2tLY1lQbXhBc1g0YURkZit2OTlMZlhZMEd6TFlCN2xRTllVR2NIUyt0OWxL?=
 =?utf-8?Q?q2dQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d503c0d2-e1d6-4a74-79f8-08dc2cb775c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 17:16:04.5838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnpT/EkcHR5X+mn59Wcm2GAKQaWQRglqwW6LRHfJ1RIGizYdbRDWWcEUCQr/jr6SMA0G8OQmvpZO7nWf0IJ5Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5521
X-Proofpoint-ORIG-GUID: LgFzs8noz7ro3JHljEixeM3xxBJaQIDm
X-Proofpoint-GUID: LgFzs8noz7ro3JHljEixeM3xxBJaQIDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=974
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130136

PiBUaGlzIHNob3VsZG4ndCBiZSBpbiB0aGUgY2hhbmdlbG9nLCBpdCBuZWVkcyB0byBnbyBiZWxv
dyB0aGUgLS0tIGxpbmUuDQoNCk9oISBUaGFua3MhISENCg0KPiBBbHNvLCB5b3VyIHBhdGNoIGlz
IGNvcnJ1cHRlZCBhbmQgY2FuIG5vdCBiZSBhcHBsaWVkIDooDQoNClNob290ISBBcG9sb2dpZXMs
IEkganVzdCBub3RpY2VkIHRoZSBoYXJkLXdyYXAgYXQgODAuIEkgYW0gdGFsa2luZyB0byBNb3Rv
J3MgSVQgcmlnaHQgbm93LCBJIHdpbGwgcmVzZW5kIHBhdGNoIG9uY2UgSSBjYW4gZml4IHRoZSBt
YWlsIHNlcnZlciBjb25maWcuDQoNCk1heHdlbGwNCg==

