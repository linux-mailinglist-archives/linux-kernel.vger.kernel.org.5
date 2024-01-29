Return-Path: <linux-kernel+bounces-42392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B28400BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BAB1F23934
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE8D54FB1;
	Mon, 29 Jan 2024 08:58:37 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2076.outbound.protection.partner.outlook.cn [139.219.17.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5154BCC;
	Mon, 29 Jan 2024 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518716; cv=fail; b=BTaXqsHZrDRHZJ7aPMd3wqbmg9gxnuyK7loEFlhgNRVBgr0Lz30U/qVDT8mFlRC5Vqablgzv9lNODI6jcgbN0UxcocX8PKAOUA+kEHLPrVRcH0sTVS9q8oZvpVo9anNv0EJI/fU+xBiDTNGDWUXXoJFDDuzhDnF1bwpc9cI/1us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518716; c=relaxed/simple;
	bh=CVtLFvCdT8crO7VlP09Q3CVrRqm4UYb/YBNN5KbL5Jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kJWzPqnV38QC25JqaRDwo8LUAVB7ZgpYebHErrgTaPiTlyXKvNc9V0gQFTYz98bWIKKXrJEz9KwPmYIvm4JQUDj5U1XmTDtzWUtQ9k+1L7xuF2DS9bt+BWh2aN2SXRiKh7oEz5GKhseuxjlm8DpwKOoXcichEb2WA6/39aiHjbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rtk/2ozfDzAcXnOGXRe1kK/aGbG3vmaV0GvZn/7mc72RqxUPHINYBQIaknpFYI94hEo+eU9QPjekK6/weDotiLuLPuZBuAGLuYT9/m90Q1oTQJxwybHQ/yoOvMV72FF3vnHyLlOqhGWyulu0RQhFVp8h1wdqCceT4gGhZ8TqwMwcJreTbl+GO4ZVWlf2XicVsc/+YQcc5Suke9AYYAAU/MwrhVYNBkP9I5dkN4ZhSjeXtbco5x1hsywZC8NdIvq1T6gT8mtXIswPWveUlKWOAcddnZbmgKYfJnpJ2y875yJYnV4TN5Rv8ps0fmkvc92dcQlwpb5OUJyeVeD/DVcSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVtLFvCdT8crO7VlP09Q3CVrRqm4UYb/YBNN5KbL5Jo=;
 b=QbEt8ZrLLjQHi1btxsYI8rLjYkAIi2xTAiGWKLHRQqJV5pbe0noZqJisaLvCGoQ5QWEnO72nyK5onXrTOWWdaqdZlCCJKf8eD5KNOVmFT4Xabhk5CCbJNZVOTbZ/YUlI16bAmyeZSJ3z3aCzPuKst3S64dXYncdiAnEc6InuCfH9TnzNEaVMK8Q0/BxvfdsTsI1FtKoDskooTITKhbcI7235lL7Pci3sDoziQDTofte+Z+UU5XA5bB2woi6eqwcfKKu9xWFGIMENgI48HWMA7/sd/fAo4CmxPCy3/10LBd4AWRb7uhKMeKJUscYilEC92zx70Z051zHZ0Jz0BtW61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1064.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 08:42:40 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::a5c6:9ab0:d20f:cb78]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::a5c6:9ab0:d20f:cb78%6])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 08:42:39 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Emil Renner Berthing
	<kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, Wolfgang Grandegger
	<wg@grandegger.com>, Philipp Zabel <p.zabel@pengutronix.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: [PATCH v1 3/4] can: cast: add driver for CAST CAN controller
Thread-Topic: [PATCH v1 3/4] can: cast: add driver for CAST CAN controller
Thread-Index: AQHaUmEMq+DwLOsh/kmS8sjg/RzLjbDwdNiAgAADzwA=
Date: Mon, 29 Jan 2024 08:42:39 +0000
Message-ID:
 <ZQ0PR01MB12534763A8CE73F6A9D36E139F7EA@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
 <20240129031239.17037-4-william.qiu@starfivetech.com>
 <20240129-zone-defame-c5580e596f72-mkl@pengutronix.de>
In-Reply-To: <20240129-zone-defame-c5580e596f72-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1064:EE_
x-ms-office365-filtering-correlation-id: 68ee0bc1-7ecb-4f86-e192-08dc20a64083
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6oJzirT5ubecxLvWmZSuZSYoptmnMkX/Pzzu69koGuvfRXlhWshRacxFh6BcFkDlGL3apKq8xhebp8URtKewrvmbXCDnr9N0H1RzuTNSLROR68eF7ZaiBPEWfxg6FFJ0StVvQnt8GrmROrm/mg6e1SxWSwuzpzoFFvaYKSxdCGdFdsjU67c+B7KqS0M/YPQrTI0T/4nL9z67Y8dINIEXdeGdZKPg0Jyt/UplF+mL/Hxq51HAK1kgD9SF89VEEM28wdvIFb+kkgN98oxlm73JZBV/JG61T9b3Gk8008rMCY+v5diYuWMI5pxchoJTpq0mBRVnN4wa0pmgB54+IoFzwmIsSHRTYgjvuV85IP3i2KtkXXbKf+resS8HHCPO1CjcKMn3bopOE3DscRionw+zrXbHiZkU+LMOAMNcaBaPzSNxP8dVqnfWqPjL9kn+86KsoBngnV/9FzK7KbpF5vt4jhwvcLcODkj7znWhClXeFvCTXo/LB+gXnwgL/C9nOUFKKModBRSQOzBi7M73lM9INbFSAEVsn5FCjgG6PkVJ3kIySvNWQ0oSY6sAY8gy+aGq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(41300700001)(83380400001)(41320700001)(33656002)(86362001)(38070700009)(40180700001)(40160700002)(122000001)(966005)(38100700002)(26005)(66574015)(9686003)(44832011)(2906002)(53546011)(8936002)(66476007)(76116006)(54906003)(66946007)(7416002)(66556008)(64756008)(66446008)(7696005)(4326008)(71200400001)(5660300002)(6916009)(8676002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZW52Tkx6MU5Ob1RjTGhqTmNaa0ErYmh2ek0xck9HbXF1azF6c0tZaUJDOHRz?=
 =?utf-8?B?Qm41dUlwenhzRGlYdjJCcEhCYVc5QlVSbVdhbmJ4eWtUTEJ3cnBzbUJrcWQ4?=
 =?utf-8?B?RjJwYytvcXFpTXN5YThZUU9tajdEbnJyOXJSRERUVjlKbjRGaU9OeXo4L0I4?=
 =?utf-8?B?Rno0M0hOTFRoY251M25zaGlCK21GNDJsYmRBcHUwSlc3emRwRW5tRW91Nm43?=
 =?utf-8?B?aWRPNVZrWkIraDBtRnBHWi9xdmFLZWFBS2p5R3ArWHRnUis1YmVNZ0hsUWdR?=
 =?utf-8?B?Y3hNSUdFSFhRUVAzOHhndFM2eU1zREZsZ1QxMjloYWErU256Z1E4bHlFYVY2?=
 =?utf-8?B?OVowSjRNa0oyUmFZR0YwRWF2bXVHMHVCRUpoeUdPa1RhR3htclZ1ZFN3TlVZ?=
 =?utf-8?B?RFdBempzdTF1aHF5QllLRzRCaHVjMzRKc3BOVTZXVjFUMzZPS3BwdU80Nms3?=
 =?utf-8?B?eWd5Qm84VCswblJhWTFKMWhBdTQzREg2ak5GYzgySzJnRXFWcGF4UHdzTkd1?=
 =?utf-8?B?ZEtpbDIrdFloMllTUERMNExqUWRQdmxTNTVSeTZ5YmhoN2hLZytKclM1Q2px?=
 =?utf-8?B?UFZCSVdjT21iLzU3OU5rRHZJS3hyMU9EeHhnT1d2cFhFdU9rMEcrSWFicjNi?=
 =?utf-8?B?UGE1a2Myb2Joc3BjN2VjQWxGUTBlVW5PQnZLRVRRMVlxZmp0NWQvWHMvMk9T?=
 =?utf-8?B?MXAxRHNTaVlZV1BRekxuUFFybHlWZ2hrblFPd0ZCMU44Mjd5VEk5S29PdFVR?=
 =?utf-8?B?UmRXZmx6S2E0MjI2ajZKQ0ROQ3R4clVsTmhHY1hSb2hIbzgrLzlEMUF4TnRW?=
 =?utf-8?B?TXgzVmJGbE5peWwzTGNXMmNVa0VTOWJhRTB2bVRFKzZ0dUxFVmhXZjhlQ01B?=
 =?utf-8?B?U00reHViek9mWWxDaGNLeUV4azRhWlhmaVNmc0M2dW8yMHNMeDU3b3VtMTZu?=
 =?utf-8?B?blpVbE9GdUdOUC92UkJTNmJXV1BSK1lXUFJjcnFUZDkwa0JtVUZHbURhcTYy?=
 =?utf-8?B?NTcwOStIblVCZmQ4RDlSMnJWbUU3bm5qTm1DSHh2SStpYVFmbDcxSjZLNTBt?=
 =?utf-8?B?OXR2Tmp1TjFZbllXaDJYOHU0eVI0RVpyNWg0Vjg1TFNYNGM0UlA0cUlLZ29t?=
 =?utf-8?B?dWRwS01vbjZJSW10OGtmWGNDR0VlOG5rWHlYU0x5OEIwM0V2ZkRuSVBISHY4?=
 =?utf-8?B?NHVaeHg1MnBUd2tmang1Mm9LVWtuUFJQQ2s0Syt2M2tGUWdQWEwzRHY4bFV2?=
 =?utf-8?B?eFkyNjJHSmtpS25XUEwyNlhqYVVHMWxmV2FqMjdWZVpWek9nbWhJcnd2MVEr?=
 =?utf-8?B?bUVXOUIxUmEzNklJMjVBZURKWElKTkZNdUlGalpVVGJFQ1FNSGIzdVBCMEVi?=
 =?utf-8?B?Q2EvY3FaYjR1TVVXcnU5MjRpSVdqRnovTytOaEVHbmw0UGpScG9TOXhjMW5S?=
 =?utf-8?B?dFV4enlKWGVGUno1WFJKQWJRZmQ4OFg4cC85UUZ5L2xaWURaUlM1czBLc3Q3?=
 =?utf-8?B?VHlrdW45SHNSTlJRbzBhaEpBSVdMWHNTbzZVUHhHYWRXVmdiRERRQlhYVzF6?=
 =?utf-8?B?UnV6SFdpWElFYitqRnp0QTNqdlczMWlTaUhHUWtBenRKV0UxUXM0ZmFtelJp?=
 =?utf-8?B?Vit1cW9yc283eFBRQjczeTcxNmRyZ09yRWc4bFNGRlhJWU1OcmdpMU0wM1J1?=
 =?utf-8?B?NmNkWGdoeTZSWHZ4dUZMczRDM3lHcHMvbVNqMFpKNHpnRGpsZjNFN2dZYVZj?=
 =?utf-8?B?a3R0V2s5YUIwdmV1T0lFZU85RVBvVWVEQmozQmEwVHE3VXRZYjZyN1BBdk85?=
 =?utf-8?B?UVg3ZUFuN0pDY3o2RE1WUU1TVTlLdmFROWRReG43T21UWjByRjdINWlhWEli?=
 =?utf-8?B?OFo0dGhCTnM4Q0VueWNzUmpIRHNXZGVhVWRudVBNWVJoS2piQlJtSDRDN3dN?=
 =?utf-8?B?VnlxNXNnblhwM295SVdKVUtibWxmejlSR0cxWlJRWkpIWW5TNnRENU1sdDBu?=
 =?utf-8?B?V1VHZnBUYy83WTVvcFd1ZEVVN0JodXRFRmFtbUxpbWNQb0FzcG5XOHZOYXJ0?=
 =?utf-8?B?UE1ESGNKY0MwcXpHMStVWmJmUmtNMExrT2drTnQ4SjUzZWRFUmRlTHVMQllI?=
 =?utf-8?B?RzRHdTZJMTYzUkFCWUxibmcwMHNYWVlXOXZVeTkvMlpIZm9mRnFIVGZERjZq?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ee0bc1-7ecb-4f86-e192-08dc20a64083
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 08:42:39.8195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aimYNOPqh3uPVV/UmHG1LaGzGIbT9qegzjRp/NOpst/pegp7C80P6p/WaubJXSG2Oe2WKhJ4FEdfm7bUyNKfqHVYLeEiWcomJxjUch5ltPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1064

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0MeaciDI55pelIDE2OjI2DQo+IFRv
OiBXaWxsaWFtIFFpdSA8d2lsbGlhbS5xaXVAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gQ2M6IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1jYW5Admdlci5rZXJuZWwub3Jn
OyBFbWlsIFJlbm5lcg0KPiBCZXJ0aGluZyA8a2VybmVsQGVzbWlsLmRrPjsgUm9iIEhlcnJpbmcg
PHJvYmgrZHRAa2VybmVsLm9yZz47IFdvbGZnYW5nDQo+IEdyYW5kZWdnZXIgPHdnQGdyYW5kZWdn
ZXIuY29tPjsgUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT47DQo+IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9y
IERvb2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IERhdmlkIFMgLiBNaWxsZXIgPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBK
YWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8NCj4gQWJlbmkgPHBhYmVuaUBy
ZWRoYXQuY29tPjsgUGF1bCBXYWxtc2xleSA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29tPjsNCj4g
UGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47IEFsYmVydCBPdSA8YW91QGVlY3Mu
YmVya2VsZXkuZWR1Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDMvNF0gY2FuOiBjYXN0OiBh
ZGQgZHJpdmVyIGZvciBDQVNUIENBTiBjb250cm9sbGVyDQo+IA0KPiBIZWxsbyBXaWxsaWFtIFFp
dSwNCj4gDQo+IHRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24uIEkndmUgc29tZSBxdWlj
ayBub3RlcyBhYm91dCB5b3VyIGRyaXZlci4NCj4gDQo+IE9uIDI5LjAxLjIwMjQgMTE6MTI6Mzgs
IFdpbGxpYW0gUWl1IHdyb3RlOg0KPiA+IEFkZCBkcml2ZXIgZm9yIENBU1QgQ0FOIENvbnRyb2xs
ZXIuIEFuZCBhZGQgY29tcGF0aWJpbGl0eSBjb2RlIHdoaWNoDQo+ID4gYmFzZWQgb24gU3RhckZp
dmUgSkg3MTEwIFNvQy4NCj4gDQo+IFBsZWFzZSBhZGQgeW91cnNlbGYgb3Igc29tZW9uZSBlbHNl
IGF0IHN0YXJmaXZldGVjaCB0byB0aGUgTWFpbnRhaW5lcnMgZmlsZS4NCj4gDQo+IFBsZWFzZSB1
c2UgQklUKCkgYW5kL29yIEdFTl9NQVNLKCkgdG8gY3JlYXRlIHRoZSBfTUFTSyBlbnVtcy4gUGxl
YXNlIHVzZQ0KPiBGSUVMRF9HRVQoKSwgRklFTERfUFJFUC4NCj4gDQo+IFBsZWFzZSByZXBsYWNl
IHRoZSBjY2FuX2lvcmVhZDgoKSBieSBhIHByb3BlciAzMiBiaXQgcmVhZCBhbmQgdXNlIEZJRUxE
X0dFVCB0bw0KPiBhY2Nlc3MgYW55IG5vbiAzMiBiaXQgdmFsdWUuIEluc3RlYWQgb2YgY2Nhbl9p
b3dyaXRlOCgpIHVzZSBGSUVMRF9QUkVQIGFuZCBhDQo+IHByb3BlciAzMiBiaXQgd3JpdGUuDQo+
IA0KPiBUaGUgZW51bSBjY2FuX3JlZ19iaXRjaGFuZ2UgbG9va3MgdmVyeSBzdHJhbmdlLCB3aHkg
ZG8geW91IGhhdmUgT0ZGIGFuZCBTRVQNCj4gdmFsdWVzPw0KPiANCj4gVGhlIGNjYW5fcmVpZ2lz
dGVyX3NldF9iaXQoKSBhbmQgY2Nhbl9yZWlnaXN0ZXJfb2ZmX2JpdCgpIGZ1bmN0aW9ucyBsb29r
cyB2ZXJ5DQo+IHN0cmFuZ2UsIHRvby4gSSBzdWdnZXN0IHRvIHVzZSBhIDMyIGJpdCByZWFkLCBz
ZXQsIGNsZWFyIHRoZSBiaXRzIGZvbGxvd2VkIGJ5IGEgMzIgYml0DQo+IHdyaXRlLiBIYXZpbmcg
c2V0X2JpdCgpIGNsZWFyX2JpdCgpIGZ1bmN0aW9ucyBtYXkgbGVhZCB0byBtb3JlIHJlZ2lzdGVy
IGFjY2Vzc2VzDQo+IHRoYW4gbmVlZGVkLCBpZiBub3QgaGFuZGxlZCB3aXRoIGNhcmUuDQo+IA0K
PiBJZiB5b3UgdGhpbmsgdGhlIGRyaXZlciBhYnNvbHV0ZWx5IG5lZWRzIGJpdCBzZXQvY2xlYXIg
ZnVuY3Rpb25zLCBwbGVhc2UgZm9sbG93IHRoZQ0KPiBuYW1lIGFuZCBzaWduYXR1cmUgb2YgdGhl
IHJlZ21hcF91cGRhdGVfYml0cygpLA0KPiByZWdtYXBfc2V0X2JpdHMoKSBhbmQgcmVnbWFwX2Ns
ZWFyX2JpdHMoKS4NCj4gDQo+IFBsZWFzZSB1c2UgY2FuX3B1dF9lY2hvX3NrYigpLCBjYW5fZ2V0
X2VjaG9fc2tiKCkuDQo+IA0KPiBQbGVhc2UgaW1wbGVtZW50IHByb3BlciBUWC1mbG93IGNvbnRy
b2wuIFN0b3AgdGhlIFRYIHF1ZXVlLCBpZiB5b3UgSFcgcXVldWUgaXMNCj4gZnVsbCwgc3RhcnQg
dGhlIFRYIHF1ZXVlIG9uY2UgdGhlIEhXIHF1ZXVlIGhhcyBzcGFjZSBhZ2Fpbi4NCj4gDQo+IENv
bnNpZGVyIHVzaW5nIHRoZSByeF9vZmZsb2FkIGhlbHBlcg0KPiANCj4gWW91IGNsYWltIHlvdSBJ
UlEgaGFuZGxlciB3b3JrcyB3aXRoIHNoYXJlZCBpbnRlcnJ1cHRzLCBidXQgeW91IHJldHVybiBh
biBlcnJvcg0KPiBpZiB0aGVyZSBhcmUgbm8gaW50ZXJydXB0cyBieSB5b3VyIElQIGNvcmUuDQo+
IA0KPiBQbGVhc2UgZW5hYmxlIHRoZSBjbG9ja3MgZHVyaW5nIG9wZW4oKSBhbmQgZGlzYWJsZWQg
ZHVyaW5nIGNsb3NlKCkNCj4gDQo+IE1hcmMNCj4gDQoNClRoYW5rIHlvdSBmb3IgeW91ciBub3Rl
cy4gSSB3aWxsIG1vZGlmeSBteSBkcml2ZXIgb25lIGJ5IG9uZSBhY2NvcmRpbmcgdG8geW91ciBu
b3Rlc+OAgg0KDQpUaGFua3MsDQpXaWxsaWFtDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAg
ICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgfA0KPiBFbWJlZGRlZCBM
aW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlIHwNCj4g
VmVydHJldHVuZyBOw7xybmJlcmcgICAgICAgICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkx
Ny0xMjkgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDkt
NTEyMS0yMDY5MTctOSAgIHwNCg==

