Return-Path: <linux-kernel+bounces-24215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B8082B935
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD15B1C26004
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733401117;
	Fri, 12 Jan 2024 01:44:52 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2052.outbound.protection.partner.outlook.cn [139.219.17.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF10EA6;
	Fri, 12 Jan 2024 01:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/oSZ+g7+fQjO38nCMXus09Dqv2kb9vb5esANm+XumcPmSvKK5zOk+bUmWfbLonbjFGXqAtwqZjXUh2MQnuH6aXQ8Ex6UWY32m2BJUpbPS9EowQep5njqPUbfDzAb2P1TDEvla7gxxz/HjKs/Lkil8yh7JjTUqe3gKHIVq60zhJ5SeYlsZGNAxCo0fho0NsV0NooCuzvQDXJhS/Ff5yLzWEiz2pkPeuB0TY32wzZbVy/bKnlkQbmDlSfagVmaD9bJkdahyfQQPOWst5HmbQ2F2xfpFY2DsVG8nDv1nDvJjXRuTPvVQ4CB++oY/6MbgRkOkRqJQeY4kWuOwIJpgWZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nh5bWaQxD5DY1lH3foTGDG1DiLXWPHYZSjcbAWAU+E=;
 b=nD84AY5ujw6KvOH+bThhu0Nf+6xGtCFZbiF1UQqsXNXjmlzqzqtNEjEZDsp0GD7DApCfI5l+KlMka+IGC4vmJR/AuLUTsVhVYaqoGdSzzhMyzB6PfvrPRov27qye/SOm8z1ImtzQ672wIjT+7P+oJJKQgWUmclsq3SEsOzkUvLoa6BQacCb3gq8S/83TB5LCqQZYc8sNvvNHBt8ITjAic1nZeQRiNVauSGeY4Ep+EhyosJcaXDpi4JE1ooPm8r3ZGhYYWfpGmjLpBsYPVVpsqFkqPy8n1XzVIuW28B6ZD5Ryr85pjtODxFlWiS0MxkQUCVgfaAVPUYR07mVSDcgU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Fri, 12 Jan
 2024 01:30:34 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Fri, 12 Jan 2024 01:30:33 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Hans
 Verkuil <hverkuil-cisco@xs4all.nl>, Ming Qian <ming.qian@nxp.com>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Nicolas Dufresne
	<nicolas.dufresne@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Tomi Valkeinen
	<tomi.valkeinen+renesas@ideasonboard.com>, Mingjia Zhang
	<mingjia.zhang@mediatek.com>, Jack Zhu <jack.zhu@starfivetech.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYyIDA4LzEzXSBzdGFnaW5nOiBtZWRpYTogc3RhcmZp?=
 =?gb2312?Q?ve:_Add_for_StarFive_ISP_3A_SC?=
Thread-Topic: [PATCH v2 08/13] staging: media: starfive: Add for StarFive ISP
 3A SC
Thread-Index: AQHaRGn71f6F/u/Orkyp84TvJxn/QLDUcy2AgADvhsA=
Date: Fri, 12 Jan 2024 01:30:33 +0000
Message-ID:
 <SH0PR01MB06677BD8FAB7F5977D29EABDF26FA@SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn>
References: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
 <20240111084120.16685-9-changhuang.liang@starfivetech.com>
 <a761d936-4f46-41c8-b6f8-c1761eddd42f@moroto.mountain>
In-Reply-To: <a761d936-4f46-41c8-b6f8-c1761eddd42f@moroto.mountain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0667:EE_|SH0PR01MB0634:EE_
x-ms-office365-filtering-correlation-id: 4bc7e664-0945-47e5-7ba7-08dc130e124c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 V7R1TZxL/g650XtiuRu7Rp0pSuDs3opWckYLIIR49JCUbaDvBBxEaTBf4blKdpJ+fQSHMVrB9IiNUmig5g/U89sCAwVPO1yHib5D2/bOTMIvqNerwwGSzMuR5s7/rhcdaPLXxh/wE8l8Dkr5Tz9p5StaBUOvANewA4aqrguKRRVLY3XRYYwotvDcOU6kmQWrpZW4NGUDX7ZN1OoR4CJeMUdPpwpH7UwD1JPHHZmTyqL79iSI8l3i59m2PPQWtxbDuOQ6PUS8r/NMm983qPQrbks+DS39SzV/cYCejEHppjxeLN4+JgKQeI52Ydnn1i2fQVZkaIO2wodjJU9/7cPm95PFh1pJLc2QuKZMS3HCdaMTkajpgLp1/3h3s5C2sgZSR+09/ukZnsN5TzTyQJPL6HZ3cslhLih03liMEL73apYG5lVucoK/ZrQNADoUCQdR2QuC/CREMrRh8AwRhGDgw0VeNEcciS1SA/1zFA3KiMI5TujqTbrDyn14bsbB3M7a8VLKVbthmkyCfh+coNoc+WPXeOrDrWhJ/6fGSErsCCpAzaiTvgscQKEEGtCdyJph
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39830400003)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(40160700002)(41300700001)(41320700001)(224303003)(38070700009)(86362001)(9686003)(54906003)(508600001)(7696005)(66476007)(66446008)(64756008)(66556008)(66946007)(76116006)(122000001)(33656002)(55016003)(40180700001)(26005)(71200400001)(5660300002)(7416002)(2906002)(44832011)(38100700002)(6916009)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aWUzK2dlVnVyL3lFSzB0aHdkbFc3L203akZIVlpZeXN2TjY3ZE5xMkNKSExx?=
 =?gb2312?B?cjh0VkFPeDNIMnZacHBGR3N4S3BGNGh5RDJVSWF0d3NHUTB6bGorMy9ibHVo?=
 =?gb2312?B?TmtVUHlCYmRBdVN4STZuTWR0U0NmM2xLekN5UDdORlNxb1M2RDl2bkhxV01B?=
 =?gb2312?B?Yy9VWE5KNGM0QmphTHNDMlJsQXA0SVRyRmtrQmRnQjNjZHJUZ3ZmekhZNkYr?=
 =?gb2312?B?MkxsT2VRMHZaQ3lZOU5HRFNycG9ZM2FZYVlRWlhWckZnY3ZaRXpqYzNzSlVE?=
 =?gb2312?B?MTNTYkg3MnQvdkZGeThhZ2VFeWNVOVl1bldjTkZwaDB6Q1l0R1M5ZU9oRzA0?=
 =?gb2312?B?bDU5clA0NWpNRGMxRU1YSXV2S2lINzVSRHMybE0rblZNbG9Ccy9GN05lK3RF?=
 =?gb2312?B?ZlNlZXEzZEwzK3hyaGc1OWFFWWsxbXYrcWVLRE1ZWUpxWCt1M0MyOTEyQ3F1?=
 =?gb2312?B?R2s2R1NVQU5KOXhNd1A5aWRHNlNQYmJqbHZiOHkwOUI1N2lxQjU4c29NYUY3?=
 =?gb2312?B?cjhsZ2E5ODVBVGJvSm51OVBXYUdKMjUwZCtMRHFSZEFOZVZzNXVNT3FrWjNp?=
 =?gb2312?B?YzVHek8raVN1ekM0YjlZVGZqYmJQbHpaSTUvZ2dXLzY2dDhJbkhiM2UraDUr?=
 =?gb2312?B?QW13QVNhV0F1ODNIZDVKMy9KNlhrUzcxdUsxdThIdWYwclQzWnVDejR2RHpk?=
 =?gb2312?B?MWV3TWxqUStseEZManYzSVkrNC9Za3gwa1VUL205eWFOOWtUeUl0NUNXMzdW?=
 =?gb2312?B?VHVHNm1VZldkMy9ZSy9WL0QxMnZIc3A5U3NlZVlDZHhHV0ZBNW5WNGROTEFx?=
 =?gb2312?B?RXVOT1lnaVRCeGZ1Wk1hYVozaHE0cEk3SU5Kb2xFb0xaeWd2K2N5RkhZeEJG?=
 =?gb2312?B?bnZPekJyWWxzc0xGQ3JQL2w4akxxMDIzWFFiblB4R1pmTXhxUW1OTU5jZ1pO?=
 =?gb2312?B?OXRDMHhOeS81VEJqbmpnZ05ZSWwvMmdWMzZhTnZQcDVhSXBwMmQraFdtZGd4?=
 =?gb2312?B?amJQMFB1N0tmbHRCWTB4akJLQkdZZ1loS1pnblB0NEFlcG1WNUtPN2lxbUVy?=
 =?gb2312?B?NVZKTzE1TGMvZXZrd2R5NWhDaEl1Sjg0bVZEbjBDS1Vibm80Q3pVNVEwZk53?=
 =?gb2312?B?SU0zVnVLQUF5Uyt0QWlmNFZyd2FCdS9YMXgzL3NuUEhVRkRHcVRXWG9yMHlo?=
 =?gb2312?B?V3FFUG5TNGZBSTVITFhJNkdVZ0NoaGl0TldjOFpwVFBMQjNBUnBFRm1zVXdn?=
 =?gb2312?B?Slc1RWhsakxYd3FrWXZvUzBkV3F1eWJNQkhTcC9YQzFtZXNKRFhFWkJOMFpJ?=
 =?gb2312?B?Z2p2dDZFYlVYdHEvZkhIY0RtOEFleVVVRjQ4M0tlMU9tcDZaZ1lDWXduQ1BN?=
 =?gb2312?B?RllIMlN2aFJGVjZienZUTVM0OWdWUkNpaU1TTVNIcWhTNWJ2dkRObnFwRGgx?=
 =?gb2312?B?MElGWWJiTk8va2FHU1E2cmVzdEVhTGZDUGZhZjBIc0FsWVhIbGIvNmhjVnJD?=
 =?gb2312?B?bjVNVmRvUllrYklWSzNVekpCTmQ2QnpZMko0eTVjQTJFQ05KelRCNmUyNUpX?=
 =?gb2312?B?VnhlRzdqRUlYakF4YkJYOHpKbHh0NHhFcjlxSElSMHp1MUFQelNCV0hUNDZh?=
 =?gb2312?B?UnpUUW94VlR6TVQvK09EUWc2RzExZDY0MGRiY1RYVXVXMEw4eXEyY2lMU1U4?=
 =?gb2312?B?MFhFMURhL213QXlLZko0QXUxYnBxenlpWTJvK0dmR3FMK0RoNldkeGVEWWYx?=
 =?gb2312?B?VFBrb0wxOVp3L2N1WUhIcEpFWFhpSm1oQzJBOXZIM2hvK1YyQTFKM2tXWUVt?=
 =?gb2312?B?V2RjSWY4LzZPL1ZYVFZuMkUyK3RRZWdEY3JiZUlHTm9oNGx2OVpzR2RLUnNn?=
 =?gb2312?B?cDFOKzd0aG10TmNHdFBVcmxzTmIzNXdDeDFGWHVVUjBSK1VpVURDL2RkaTNL?=
 =?gb2312?B?MzJmLy81MzRJaENRTTQwQW9mbldtMVBHQ25scEVyMmExREF2a015ckdqenJo?=
 =?gb2312?B?YTJwYUwxN0kwVmRRVnBlWmYraVAzUCtoS3B2NEJzUi9ER1JDNlEzNUwzQy9Z?=
 =?gb2312?B?NUNsWnJnSlFsdXNzZ2dpeE9Kbk1lOXY2VnpKN2grbTFUVnp6OWJ4cVB1NHhH?=
 =?gb2312?B?ak1xM2R4MlRFQjdiZ1YxTk9zLzFEWitpZ1pjVW8xRXAvRGRiM0ZqbmIwQ1NO?=
 =?gb2312?B?T1E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc7e664-0945-47e5-7ba7-08dc130e124c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 01:30:33.7184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IK2nzXyqyVdyIGrW07rcueYRytGhPtPXnGMJp5qA3ewi8gbbEE73QGdzaxiCHzqTysWSAzikLOvNrw4nXY8T8lJe6n3MuCbHbN+CQlpw1xgZBR2xTOwfmiMKdfjc5O+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0634

SGksIERhbg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudC4NCiANCj4gT24gVGh1LCBKYW4gMTEs
IDIwMjQgYXQgMTI6NDE6MTVBTSAtMDgwMCwgQ2hhbmdodWFuZyBMaWFuZyB3cm90ZToNCj4gPiBS
ZWdpc3RlciBJU1AgM0EgImNhcHR1cmVfc2NkIiB2aWRlbyBkZXZpY2UgdG8gcmVjZWl2ZSBzdGF0
aXN0aWNzDQo+ID4gY29sbGVjdGlvbiBkYXRhLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hh
bmdodWFuZyBMaWFuZyA8Y2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0t
LQ0KWy4uLl0NCj4gPiBAQCAtMTUwLDYgKzE1MSwxMyBAQCBzdGF0aWMgaW50IHN0ZmNhbXNzX3Jl
Z2lzdGVyX2RldnMoc3RydWN0IHN0ZmNhbXNzDQo+ID4gKnN0ZmNhbXNzKQ0KPiA+DQo+ID4gIAlj
YXBfeXV2LT52aWRlby5zb3VyY2Vfc3ViZGV2ID0gJmlzcF9kZXYtPnN1YmRldjsNCj4gPg0KPiA+
ICsJcmV0ID0gbWVkaWFfY3JlYXRlX3BhZF9saW5rKCZpc3BfZGV2LT5zdWJkZXYuZW50aXR5LA0K
PiBTVEZfSVNQX1BBRF9TUkNfU0NELA0KPiA+ICsJCQkJICAgICZjYXBfc2NkLT52aWRlby52ZGV2
LmVudGl0eSwgMCwgMCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCWdvdG8gZXJyX2NhcF91bnJl
Z2lzdGVyOw0KPiA+ICsNCj4gDQo+IERvbid0IHdlIG5lZWQgdG8gZG8gc29tZXRoaW5nIGxpa2UN
Cj4gDQo+IAltZWRpYV9lbnRpdHlfcmVtb3ZlX2xpbmtzKCZjYXBfeXV2LT52aWRlby52ZGV2LmVu
dGl0eSk7DQo+IA0KPiBhcyBwYXJ0IG9mIHRoZSBjbGVhbnVwPyAgQWxzbyB3aGVyZSBkbyB3ZSBj
bGVhbiB1cCB0aGlzIG5ldyBjYWxsIHRvDQo+IG1lZGlhX2NyZWF0ZV9wYWRfbGluaygpIGluIHRo
ZSB1bnJlZ2lzdGVyIHByb2Nlc3M/DQo+IA0KDQpZZXMsIEkgd2lsbCBjYWxsIGl0IGluIG5leHQg
dmVyc2lvbi4gT3JpZ2luYWwgY29kZSBpcyBtaXNzaW5nIHRoZSBjbGVhbnVwDQpwcm9jZXNzLCBh
ZGQgSSB3aWxsIGFkZCBpdCB0b28uDQoNCj4gPiArCWNhcF9zY2QtPnZpZGVvLnNvdXJjZV9zdWJk
ZXYgPSAmaXNwX2Rldi0+c3ViZGV2Ow0KPiA+ICsNCj4gPiAgCXJldHVybiByZXQ7DQo+ID4NCj4g
PiAgZXJyX2NhcF91bnJlZ2lzdGVyOg0KPiANCj4gcmVnYXJkcywNCj4gZGFuIGNhcnBlbnRlcg0K
DQpyZWdhcmRzLA0KQ2hhbmdodWFuZw0K

