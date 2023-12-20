Return-Path: <linux-kernel+bounces-6415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74181988B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99CD28889F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E711CAB8;
	Wed, 20 Dec 2023 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cl9K3VdZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B41C69D;
	Wed, 20 Dec 2023 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN56ocHuf+uQSRcomWAaNZGKCHcSjIVWjS1zx+yqNPFlEt1IZ8TFKAAEPRLh2Yq7poPmJtlNvN4uiV+c2pz75tReHS6l+R9gBP3V70iktsEWt7qPdmBTS+YFgGBItiulQ/XmMgCXTrzifu2WqWt3GfjKf0RAGbjMz8qy7SLgZ5PYzdZmFSUIZqLB84XqipNSC0tr9oWaBK3gDCyPut2enYykatnnpoqt5dkPQrItaDBM2ZtH3CQWzYVDVcbDAJSVM40vaAoNPQgV9NjG0W7WDu24ruXkWu5VZw4+TrtGSS14orASKUFbRAp7bhx8NxMw4bGaWw4GXL4zhUWow9XdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3lLzKe8bPxDifaPzUcB18zRCVD04ey0+kpjsyxtx4E=;
 b=lAxTSBQRwgn0bCduVUx9V3xBz1qBoyIMLyQDYBMI/XsZbJYSNlCzBN/CvzpKwS0QfPJg36pMe0N+1trqDF2hsmh3NBLCUUJftch5emrwzkhez36glp+V+jLyO4xq/1FbYmDYWW+mrQCvlq021QgCNzQ9QMajFBllMWv42r9MXV99yWdB0ONHfF4iCiFscHiZPDEhllOt78jjoj4jYMKrrpb3cix1+w76KdnVbOiUlFBbxY/Urffj65BM3wUjfmfQHzbsVaMvQBz1nDVIKM+H/zR3wW/wKKHYyG1/iVB2lWO8raxRKgCaDIGVFP3mdlBiM2/AJxSfIheWSrdj1UdnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3lLzKe8bPxDifaPzUcB18zRCVD04ey0+kpjsyxtx4E=;
 b=cl9K3VdZTxt3ry4oB5bZ8kbuokilumovuHC11b5DktCWBnw8061hnzRXc7rSGIEJ5WFe03NND07tt74XTJTd2MvnmjNL9ljK8f91CHK/QDFKPrwrciCvO69jaJ4canFZdIMgUr20QNUAAb65mP7Oi1v1siO7GjX7i3qH2JgZut88Xe7ANIWnUut0i3I7MaisEczQMawYZQZ522Ge60DtUQcdvq5wd60ND0L41qmQ5RWhx4SLc3d7EZ+q3efpBBQIu5fpj2ZGrA1L6ctdvZmvnDjc/PUUjJNF4/HT5YCWZMa5+VeTChEf1ZEjwn8MBm3V4aOhxtLO0oJSyFD7xc0tdw==
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 06:13:24 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::5946:7329:29ae:994d]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::5946:7329:29ae:994d%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 06:13:24 +0000
From: Kartik Rajput <kkartik@nvidia.com>
To: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry
 Reding <treding@nvidia.com>
Subject: Re: linux-next: Tree for Dec 19
 (drivers/soc/tegra/fuse/fuse-tegra30.c)
Thread-Topic: linux-next: Tree for Dec 19
 (drivers/soc/tegra/fuse/fuse-tegra30.c)
Thread-Index: AQHaMs+6hlV9Xp/yuUKRbZnHIfwpm7CxsaIA
Date: Wed, 20 Dec 2023 06:13:24 +0000
Message-ID: <ad24207b11d27466aa84328d1f91a34fff8540ab.camel@nvidia.com>
References: <20231219154103.0ade50bc@canb.auug.org.au>
	 <e7529a79-73d1-48be-9f98-aed9793b2bc6@infradead.org>
In-Reply-To: <e7529a79-73d1-48be-9f98-aed9793b2bc6@infradead.org>
Reply-To: Kartik Rajput <kkartik@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5716:EE_|MN6PR12MB8542:EE_
x-ms-office365-filtering-correlation-id: d634e91b-8ffb-4d3b-f6ec-08dc0122c634
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oWyu8uW04aiWHb1AuPEwp977rfRR1Smpz/aoPjwHiMcsQ34OveVuHwpPlIeEO/IiYVbnmZ6G8j8+5Vkik1LAc9oa7HMFfZqha7Cv2Uk72Yl9Aj90PH5lLl2EHSH6BVO+FZmZ+0aV/Re18qJkScfhnrNo5/uCftquRjOtMR5Tljbb40BDghoX03U/Q5Pz6cnc1FZX78k/Jb76gOXPs+uG0z7maRV7prZQO6cA7zcI1joJFq56hbvn68+2ByIcLFjCOVujppkS0xRXJUdGHpK6XjWN4pCFJY4V4KOFZPRScZt7fO6RT/iISGEYY2MBT9FFG/7OipaueNDzRX7/zMnjEl1/XdXB6+RrvJteJgRzFVQvUEJN4vF+5ckqtjTC/7bvXBbh44GwjUgZ4jNjlVzM+OhclyHhKLfw9XM1E+O8NCf+MFEIc5hQnTEqfGrQqbEBVTFBCOj8B/x76KAYHv6vR9tYxB6/pEBG6BBFAkEAZmmFbtR49R3H9Bjxff0TePhFfow9X49tbMCqux33o2TzoDh9mRvQ1kM3VY74WFm3vE2NP0hO1MRcspd1pP0r8NaN9zlWawgFu3ACqfsVhyLeXg+6Zx87XvWtIXzuXMAQW3nEz1cCK/l7+wYjgmBgndWiuzUQj0KoUIgG/JoGaaUn8JLrH09WO1XTYGdEqXcBf7U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4326008)(8676002)(8936002)(4001150100001)(3450700001)(2906002)(5660300002)(6506007)(478600001)(6512007)(64756008)(76116006)(91956017)(66446008)(4744005)(66476007)(54906003)(316002)(966005)(66556008)(110136005)(66946007)(6486002)(53546011)(41300700001)(38100700002)(122000001)(86362001)(36756003)(38070700009)(71200400001)(107886003)(2616005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3R1TzBFOFljUE1KNFlzc1l0UFJQMjV0UXBFaFMrQ2xqQ1VZc2djdzJZOVY2?=
 =?utf-8?B?bnpLTXRvc3RTWjYwMm45Rm9aa0xZMlNrS2FNeEhqdWlQVVNWUFdwSHV4d1RJ?=
 =?utf-8?B?WWtWUnhvVkJCUXlhb3h0STgwYlJacjN6ODNWaHBmSnBEU2szQjlNSkpoTkRz?=
 =?utf-8?B?L2V1NURMeGdyR3lRNmwyZDFXNnhCaEVRaWlxeW5xelZIWXcyeEloYytqcm9P?=
 =?utf-8?B?NFI2Um0zdUNTWW1lUU05Uks4LzBEZ0k2WFRqV1Vub0ZqdW5XVVFyc1BaTlVC?=
 =?utf-8?B?NUx1NHRUam9GYmp2Sk8rdmZ5VWc5dXF4TWNLaWdNV05PRFJoTG1mV3BJcG1P?=
 =?utf-8?B?YzFvRExmalJXYUVhNHVSNS90MzFwS2EzaWNJVVljeG80KzlmS0J6NnVXcnhJ?=
 =?utf-8?B?S1JaUGFhRWVqcXZDK2VmQmlWakxVTUIvVGQ5aWdqd1EyZURURHRmaTQ0UE92?=
 =?utf-8?B?dGoxZitES3FkczFsQ3hkZUZHczg0Kyt1OXhxSFBRL0tlZ09UaE1oZUNOWjBm?=
 =?utf-8?B?UDJpOTlOZGpBSnRjQnpuL3ZiWVNTZGFRMGpDQjkvVEVJSk42bTYxUnlIMmc5?=
 =?utf-8?B?cVorcytPekdmSCtGbU5rd2xRSGZ3L2JsVWFWQmwvVmI3a0l5YUJDa3F0R2Fi?=
 =?utf-8?B?VHZlbklGTDM2WnViZmF2WTE1YWZJb2xXOFJEeXh3WnFXaDNVOE91YklpMjJu?=
 =?utf-8?B?emdSdUVDNUZtR04wR3JuR3QyeFp0TEpXcy9td1kyeGkzd1MrQm1RY0VVVGlu?=
 =?utf-8?B?WENsVmlmU2J1dEg0dUw1WVkwK2tabGtvcnEzYThXWFFxYzg2dDdtUHlhSFhj?=
 =?utf-8?B?Q2I3SDNmYUNXbEVPQ0dLVnlCYks0YlQwdUNYeWI4YjBkRzlTSVk2andBNzdQ?=
 =?utf-8?B?S1dENmdzSFpybzVsV1hQRjA0aUpET2NQWG5jU1pLbTREODVEM3NPK09kZlBG?=
 =?utf-8?B?SHlPempocmZYWEczV3NHb3R5THFSOEdNcVdPZEhVUUtJdFhuMjBxQzl2dlVl?=
 =?utf-8?B?d1VpYjEyTW1Nb0pZdGNTbHpOdENDdkVVMjh6U1NSTlQ1Yk9iSUhjV1k1ekhM?=
 =?utf-8?B?QjhRVVhWUkhidjVCWkxFUkZROXR0OGFkUElUZVNObWNaRkdlRFlFZVZIbTRS?=
 =?utf-8?B?RjkwOHYzYjBDeW5zQWxkeUpNcVZxVlM1cWFBRzladXArYjgzZ3R2QjFLenp2?=
 =?utf-8?B?bmlhU0p4dnUvVlovSlN6QnlBTGlTMVdtTUhQTnRJSUZ5NzQyRTBic3dhQnFP?=
 =?utf-8?B?OHRyYVZhV1dCSTJNYlM1T0lYWWVXSTFXWi9IMVlMUnpLdFI3VHdwTTdJcHQ0?=
 =?utf-8?B?ZEdXdG90MjdvVTRPeDRNQlgveXJlYnA4MVhsRTBWOU5GZzVadmtOL1JnNm1T?=
 =?utf-8?B?aU1kbUZ1VldWVk9iMi9qZnpwbDB0SU1yVy9vMm9UbmNsVldXaHVmZG8wRUJ3?=
 =?utf-8?B?VHgxeUdMbmxCZm9zQ2w1d25zSzB5SzBTSjJla0NXTHN5OHhvYUxPV2J3b0FJ?=
 =?utf-8?B?QThJOWRiOEFubmtFZEo1bU5WS3NweDdXMnhuLzFPbDVkbXMveGRpdjZUb2Rq?=
 =?utf-8?B?QjZ3emNTUXpXak1IYVErZXpiMFJkYlM5MCt4QXErZVpJRm5kZ1JNcE53VGV2?=
 =?utf-8?B?amhEK1l4eGxnQjREVWdMVWlOMzN6UWdSZUlvTlZSZzd4RXdWN2wzbjZkWk5n?=
 =?utf-8?B?cnkrY2V2bjFxbWJjeW50VWF6aEZHVTlqQkowSzBKb1p5eXh6SS85WDF6bUVL?=
 =?utf-8?B?LzlqOXRjRzJpa29UL1QzRElqQmpoNFgxOG42aTlwbDBCWE90MHhqQTNFM2Nr?=
 =?utf-8?B?S0ppYUN1SHdzOHJYNFJyeWJjSWNxTXg3L3AzYW5OMEdpdHZmZHZWZTdhWi9s?=
 =?utf-8?B?cFR4S3JuRWdrZ1BCK284eTNoU0lUZWpSejV2RkZjV2xNMnZycHlIdE9sYzVz?=
 =?utf-8?B?Q1k2a1YvVnduemlVUUUrZGJHS2YzWjBkTGNneTNLWDBialJMNG5iVmZQZ1RL?=
 =?utf-8?B?NkpDRFFReUE3OS82YVVsaGlma2dzV3VoUzdXeHMzRlVCNlN0NDNVdHZzcTFR?=
 =?utf-8?B?Y3ArWGtLc1NiL2JkdllnK0dqYXg5dlVjdVpTMXhzTC9jNXFjVkkvRzhPSlox?=
 =?utf-8?Q?H1b8UoIfomWz1IU+N5aDPAHMZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52D272150DE96742ADDC6B71A7BC001B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d634e91b-8ffb-4d3b-f6ec-08dc0122c634
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 06:13:24.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6y+0//9aI1x4ivdfx4A5Q7UStsBokcLchNLNbX0mhiAO5PbPINyppldOLxwfqJF2rrakUev6lYj1d0xBuqfCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

T24gVHVlLCAyMDIzLTEyLTE5IGF0IDE1OjA0IC0wODAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IA0KPiANCj4gT24gMTIvMTgvMjMgMjA6NDEsIFN0ZXBoZW4gUm90aHdlbGwgd3JvdGU6DQo+ID4g
SGkgYWxsLA0KPiA+IA0KPiA+IENoYW5nZXMgc2luY2UgMjAyMzEyMTg6DQo+ID4gDQo+IA0KPiBv
biBhcm02NDoNCj4gDQo+IC4uL2RyaXZlcnMvc29jL3RlZ3JhL2Z1c2UvZnVzZS10ZWdyYTMwLmM6
Njk4OjI4OiBlcnJvcjoNCj4gJ3RlZ3JhMTk0X3NvY19hdHRyX2dyb3VwJyB1bmRlY2xhcmVkIGhl
cmUgKG5vdCBpbiBhIGZ1bmN0aW9uKTsgZGlkDQo+IHlvdSBtZWFuICd0ZWdyYV9zb2NfYXR0cl9n
cm91cCc/DQo+IMKgIDY5OCB8wqDCoMKgwqDCoMKgwqDCoCAuc29jX2F0dHJfZ3JvdXAgPSAmdGVn
cmExOTRfc29jX2F0dHJfZ3JvdXAsDQo+IMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fg0KPiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdGVncmFfc29jX2F0dHJfZ3JvdXANCj4gDQo+IA0KPiBGdWxsIHJhbmRj
b25maWcgZmlsZSBpcyBhdHRhY2hlZC4NCj4gDQo+IC0tIA0KPiAjUmFuZHkNCj4gaHR0cHM6Ly9w
ZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCj4gaHR0cHM6Ly9z
dWJzcGFjZS5rZXJuZWwub3JnL2V0aXF1ZXR0ZS5odG1sDQoNClRoYW5rcyBSYW5keSwgU3RlcGhl
biwgZm9yIHJlcG9ydGluZyB0aGlzLg0KDQpJJ3ZlIHBvc3RlZA0KZml4wqBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC10ZWdyYS8yMDIzMTIyMDA2MTAxMy4xMjAxNzMtMS1ra2FydGlrQG52
aWRpYS5jb20vVC8jdQ0KZm9yIHRoaXMuDQoNClJlZ2FyZHMsDQpLYXJ0aWsNCg==

