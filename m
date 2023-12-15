Return-Path: <linux-kernel+bounces-755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74A814594
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C224E1F229AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317A928E0E;
	Fri, 15 Dec 2023 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="OdJV0En2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2113.outbound.protection.outlook.com [40.107.13.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844225547
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDkskN+ZCCVjfC0dlm+mZCWrJkbr7k627J78HUl2+uyywQ99d2zdNsS7qjXP3ZKJOnL5xzahL93G+xlUZG4aX7tsoIbZng9Smwo+TGwXHPSiKSuObgTMqlGbMC6PoujkLEBojVceYZsOwjFc8cntcaLxRfMOSe2RWDdosJ7YIGAMzCL0LrCFa9B6Yjct7rREH/Jd7oCw0Ei8Ig0qHBbB2WI1FLIuHD9+tf/supxdRTnYX/kwWnJjJSW0FYTbl/QEGNOXVBgxs28+d7XrFQ0sconltiXk2mlA29MOrzbPdg1UPBaruppde67f0XfchKwbvTdM3M5Zr0z0jKJteJYXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXni0m8FpbP8lNq1L0KhE0O8Z+sqlZnUJLuIRNWe4aM=;
 b=AFxhKkhTC+49N34Psm+DyhPVOMi07PtU6P84RTQMOo1dyfWYCVd5JnuVU/uZTKWSRtLqj1a2b/sfjGKtDQgHYEonANyDblmLTF92mp0IOLJ5moPzYJtBe+yIj29fYH2Uli13p+sWNdpveg+jZKiWOzPIlfnnekxjiDtPsfZAOE/3NL3l9n8Xtv8se5Nc4vRHf4BfBQVo/xCl3jz6ifsOuA8GvDT6vCt/AfHPto8uTixZhjscrKFVgajzqzGuza3zbry0i6qW8Hnf88bxVFKe7+SZQrw70DJEWdBwphbj0dBjZfOkp0ka003BWXj614AL2PIanTkCu5SvGeJcd3SJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXni0m8FpbP8lNq1L0KhE0O8Z+sqlZnUJLuIRNWe4aM=;
 b=OdJV0En2ONAhfm/3Zin625Ei+AgFDH7k4AsgT3Nr7wL4qNmitqpn9NFJMWrBgxie4tP0yd+higu+S7UB3p66LryhXOpxrfUXGWyomU4pw63l9/Dyh8JXJ+S97+zxR1buoo8ZhMQlXlbtY+NMkyOooD2Twn39bRK4pUB0P4LJ7cY=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS8PR03MB7159.eurprd03.prod.outlook.com (2603:10a6:20b:2ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 10:30:31 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 10:30:31 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Joe Perches <joe@perches.com>
CC: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>, Linus Torvalds
	<torvalds@linux-foundation.org>, =?utf-8?B?RHVqZSBNaWhhbm92acSH?=
	<duje.mihanovic@skole.hr>, Konstantin Ryabitsev
	<konstantin@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] get_maintainer: correctly parse UTF-8 encoded names in
 files
Thread-Topic: [PATCH v2] get_maintainer: correctly parse UTF-8 encoded names
 in files
Thread-Index: AQHaLp83Na+SMbS38kC9fRju/prRC7Co71oAgAE214A=
Date: Fri, 15 Dec 2023 10:30:30 +0000
Message-ID: <45x65lwhzefxfe7muha6myfqb53ooxvhjpgeqadeiikl5nriws@ekwlxybd6ybp>
References: <20231214-get-maintainers-utf8-v2-1-b188dc7042a4@bang-olufsen.dk>
 <f7510474a007223811da8b04efabf13376e53728.camel@perches.com>
In-Reply-To: <f7510474a007223811da8b04efabf13376e53728.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS8PR03MB7159:EE_
x-ms-office365-filtering-correlation-id: 4aed27d7-f91c-4076-2586-08dbfd58dcfd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FneLwrsYm++NZnLJiVvG8l3wxMV6inXVz0O0CZd3mBhVKthXKT/AHrn9prKsrRb0dXyYgcazld2y28MWJqz+anAH69iuepTGXG9R9SMEvFbcI9NcmLz8Qn7gRxM9yJzTOrUMq2T11PzdtUHiIuw6agkZ2olWtiT0BiZHzn9I+xaoMs/VRM15sp2IGhlPIJjq8PpYVW4SHKElslXiLAdwImLfXd8xit3100HMs+kPKcQtQ6WIUi+jsertcEyOAgU75o89HLcsXGUVlLLmaijqplsv4elBbGkQ3IS14YmEKMUqrmvx5bC19cdtEzhT5uRR58+C3LQm9crnjmL/PY4/xsUOpQ336R2hasewC26n5LdnLYhDfUCidS0HvTz7IaYiJrLj+xJePYeLopfOUABTAveJECkJJ6oTevWMpegaLZDerL3ElDBRmCLIb4UH7NJp+ocryjcQTx6fE1L8uSVOe9xu7fYkO55OyKWoglmzr98ttjWHYt9otgPys/A2uGO+mtY3Ud8lRxH1AGsMzv2YNIl+MczLHKNq+VsE16Uqe1AMmqiCw31LU7XA6E/jAzNaC4zSYL0JDdWVe8PNhb9at/uqwaqkMQxeJhgJS+pDTig=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(39850400004)(396003)(366004)(376002)(451199024)(64100799003)(186009)(1800799012)(6486002)(86362001)(33716001)(6506007)(9686003)(6512007)(26005)(85202003)(85182001)(4001150100001)(38070700009)(966005)(478600001)(71200400001)(2906002)(66574015)(83380400001)(8936002)(41300700001)(8676002)(66556008)(64756008)(66446008)(54906003)(66476007)(76116006)(91956017)(6916009)(66946007)(316002)(5660300002)(38100700002)(4326008)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWpWMk9YN0gyQ0xpYTdDUk8wWFZ2aE5hdzFydVM0RWVneDB6VHY0YzhmWHdk?=
 =?utf-8?B?VUVJbWZTK2RDU24zckxLdTI2dVJHU1NxUnlhTSt0eTQvVnVxTHcwTHg5em5Z?=
 =?utf-8?B?TlZQb09pZGEzaWVDTXM2TFVWdURlZy9OOVdQUlRuUkYzdkJENTdHTDdoTmx0?=
 =?utf-8?B?MGh6cHVJWXBLby9jK3lvYlVmYWhwdWpuajg3TWw3ZlhhMThrN0Zrczc2anpN?=
 =?utf-8?B?MncydzZBRjdQRXFrNnV6VXVJWGtHY0JKamh2MzRaYnExenZVRGV0cnFLUm1u?=
 =?utf-8?B?dlVMNk04SW03a3ZWU2Zidy9PSENZNDAxMEFzQzBuVXpMUHBZNGtmVFVWQmlZ?=
 =?utf-8?B?YkxEb2pxOW85czhGRTB3NWVyT3hjK1NJeU9CRkdSV1E0OWo4anlFdDZoQTU1?=
 =?utf-8?B?Zk5WaVBWRDdPa0ZONmpJaWpLY2k4SmlsVjV6WEp5VU5tUFRGVXpiM3pHN2xq?=
 =?utf-8?B?YS9Fb3dyWmFFZU4wR0FXeVFpRE5lV3FiMjNOcnBsVkNQMFBVZ09oQmIyRkxk?=
 =?utf-8?B?cDNEcWc4Zng3Tm5vSDZjazhPWndSeWx5Z3FnTmNuM0tGRFJPaXJwLzlDOFph?=
 =?utf-8?B?WmJTeFB3VVBSeFFNbDlxZUltbXI2WVlXdHl0SG5teWNuNW9WWmNzOUV3S2Iz?=
 =?utf-8?B?aUhrVjh1L2VRbFhJem9xWjJ1Nm5JOFFtZnltTkFTM25zQXdzNnhQTFU0Q0Fl?=
 =?utf-8?B?S00xSDAzbmtRRTdmZGlQaS9TbmhaMUcwdWp4YW1GU1ZIVTkxaUZUYkhTZnZX?=
 =?utf-8?B?L2tuS0FTUXdDa1pwYVhPa3pBUlZFREtvaGJoR0FTOFVEdG4wbG9xV0RRU1dT?=
 =?utf-8?B?ZkZ2MU9SaHBScDlpc1p6akhYRytmNUkzdzk5SHNZQnBNQzJLV0dzS2x3bnpB?=
 =?utf-8?B?WDBlYnk1eUdtOEtsQ1A0MC9lS01yeitYQUp5bmQxZnBFb3FZK2ZZKzZoeWZW?=
 =?utf-8?B?TjZVVDJ5Rnk3L3JsUGF2WHMvdm1oZ21XYll1ZUs5S0tiVkRGeVlHampGSXBu?=
 =?utf-8?B?Qm45Rjh6cjN3OWpYTXNrSUduTkJQMFhrNXhDa1h6TVIrOUhwL29YVkRpclRX?=
 =?utf-8?B?cEg1QWJnSFNzVEFRTTFYeGN0Sk00dVBLUU5Ld1UyNkVhQUlWeFJYTHZUbGVZ?=
 =?utf-8?B?UE9tVjI2Tm9hdUhWQXdtaGUrNGJGeFdhNXZMNTNIT1NuZ3YzRkNBd3huY0lI?=
 =?utf-8?B?alNZSzNsL1JxVlVFZWtTelRtNkoyU3pQWUQrckxmWXBzc0NNajdlK2pvemlx?=
 =?utf-8?B?L3hRakZDaUc1eUdPMEF3czBYNVpBK0JPQlBuK20vemNpZ1BDdkE2Uno0YjQ5?=
 =?utf-8?B?WGt3MUFEWVp4UDl5ZlBEdkhSWDZTUHVuQU1ZVE1oQ2EvUHFHZ01rNHZGOXQz?=
 =?utf-8?B?eU1rVU1WWGhQQUdNOCtCKzR3Rk5xWlgyV3dWSFREYWZVdUxxSW5NN0NhYk9B?=
 =?utf-8?B?MkltOTVjdU1wTFc3a1pPSkQ4cUp1b0EzNFFUS1IwVGlvWTNXbUc1Ny9RQlEx?=
 =?utf-8?B?S1hFVHlOV1BTV3lCeGNzUnZUMDVIZHBhdUFiUGNIRURLV3BZb2wrZVMrMFBY?=
 =?utf-8?B?VDhxZkFmc1QyeExzUWIreDF0b3VrdFIwV3g4RWdnbXBMeExPeEdBK1Z6RVdO?=
 =?utf-8?B?NFVvT3Nic2g4dnNZRmtjVE1sZjVYK2Roa3B3TEVVK2xoYVU1R3RCNjdvd3p0?=
 =?utf-8?B?RENZODNoS1J5NzR1dUw5Ty9ENHlzQTlxcWVhYXRCSGgrdVNNb3RtZVg3VmNU?=
 =?utf-8?B?M1lmeEdGcVQxcXZ3aVBMdFhvVjh0VTlxby85dGh1cU9QdHJPeVJCeUVRSDVu?=
 =?utf-8?B?TVFiTFArUzB0TEV3QzdiazRqTlFRRHJtMnhlMTVEVTFKWEd3UEtKbkE2cXRG?=
 =?utf-8?B?Nnc0V08yWW9SNXRkR0MxdzNtOVU4TkdNT0xMSHMwekxMZ3pMUDIydDIzOTBI?=
 =?utf-8?B?QWw5aStXQVdhR05tUnlwNzZHQVZOY0VvN2JjZnM4NW90cXNvSnc4MEgyOHRU?=
 =?utf-8?B?NThoMjN3SmhmRWV6MFZZTitKQ0drZXZwOGZWMUl4S2VETnJmTjZrbFB0V09y?=
 =?utf-8?B?MG9oYzdQWXNDb1N0M1IzeUpiME43M1ZEZzM2OFZiNUVZeDh4QyszbkdweUJt?=
 =?utf-8?B?Y2ZOcnF0YitOeTA5ZGZGTWJmU0tZOE1YY0MxaXZGRnFaaFowNlBtVnpvYzFi?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC78513A5FE11D48A4D8AC402A2A0609@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aed27d7-f91c-4076-2586-08dbfd58dcfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 10:30:30.9326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8O7hwwK146H40sXxP8Ry6XMeAfDRXdqNEGTnghV7v36Abth/sUmt9z6xk6k5KHjTAQAAYncZbmp292hjB+mWPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7159

T24gVGh1LCBEZWMgMTQsIDIwMjMgYXQgMDc6NTc6NTRBTSAtMDgwMCwgSm9lIFBlcmNoZXMgd3Jv
dGU6DQo+IE9uIFRodSwgMjAyMy0xMi0xNCBhdCAxNjowNiArMDEwMCwgQWx2aW4gxaBpcHJhZ2Eg
d3JvdGU6DQo+ID4gQEAgLTQ0Miw3ICs0NDMsNyBAQCBzdWIgbWFpbnRhaW5lcnNfaW5fZmlsZSB7
DQo+ID4gIAlteSAkdGV4dCA9IGRvIHsgbG9jYWwoJC8pIDsgPCRmPiB9Ow0KPiA+ICAJY2xvc2Uo
JGYpOw0KPiA+ICANCj4gPiAtCW15IEBwb3NzX2FkZHIgPSAkdGV4dCA9fiBtJFtBLVphLXrDgC3D
v1wiXCcgXCxcLlwrLV0qXHMqW1wsXSpccypbXChcPFx7XXswLDF9W0EtWmEtejAtOV9cLlwrLV0r
XEBbQS1aYS16MC05XC4tXStcLltBLVphLXowLTldK1tcKVw+XH1dezAsMX0kZzsNCj4gPiArCW15
IEBwb3NzX2FkZHIgPSAkdGV4dCA9fiBtJFtccHtMfVwiXCcgXCxcLlwrLV0qXHMqW1wsXSpccypb
XChcPFx7XXswLDF9W0EtWmEtejAtOV9cLlwrLV0rXEBbQS1aYS16MC05XC4tXStcLltBLVphLXow
LTldK1tcKVw+XH1dezAsMX0kZzsNCj4gPiAgCXB1c2goQGZpbGVfZW1haWxzLCBjbGVhbl9maWxl
X2VtYWlscyhAcG9zc19hZGRyKSk7DQo+ID4gICAgICB9DQo+ID4gIH0NCj4gDQo+IFJhdGhlciB0
aGFuIG9wZW4gX2FsbF8gZmlsZXMgaW4gdXRmLTgsIHBlcmhhcHMgdGhlIGJsb2NrDQo+IHRoYXQg
b3BlbnMgYSBzcGVjaWZpYyBmaWxlIHRvIGZpbmQgbWFpbnRhaW5lcnMNCj4gDQo+IHN1YiBtYWlu
dGFpbmVyc19pbl9maWxlIHsNCj4gICAgIG15ICgkZmlsZSkgPSBAXzsNCj4gDQo+ICAgICByZXR1
cm4gaWYgKCRmaWxlID1+IG1AXGJNQUlOVEFJTkVSUyRAKTsNCj4gDQo+ICAgICBpZiAoLWYgJGZp
bGUgJiYgKCRlbWFpbF9maWxlX2VtYWlscyB8fCAkZmlsZSA9fiAvXC55YW1sJC8pKSB7DQo+IAlv
cGVuKG15ICRmLCAnPCcsICRmaWxlKQ0KPiAJICAgIG9yIGRpZSAiJFA6IENhbid0IG9wZW4gJGZp
bGU6ICQhXG4iOw0KPiAJbXkgJHRleHQgPSBkbyB7IGxvY2FsKCQvKSA7IDwkZj4gfTsNCj4gCWNs
b3NlKCRmKTsNCj4gCS4uLg0KPiANCj4gc2hvdWxkIGNoYW5nZSB0aGUNCj4gDQo+IAlvcGVuKG15
ICRmLi4uDQo+IHRvDQo+IAl1c2Ugb3BlbiBxdyg6c3RkIDplbmNvZGluZyhVVEYtOCkpOw0KPiAJ
b3BlbihteSAkZi4uLg0KDQpZZXMsIHRoaXMgYWxzbyB3b3JrcyBmb3IgcGFyc2luZyB0aGUgbmFt
ZSBpbiBhbiBhcmJpdHJhcnkgZmlsZS4gQnV0IHdpdGggdGhlDQpjaGFuZ2UgeW91IHN1Z2dlc3Qg
YWJvdmUsIHRoZSBzY3JpcHQgdGhlbiBjb3JydXB0cyBteSBuYW1lIHdoZW4gaXQgaXMgbGlmdGVk
DQpmcm9tIE1BSU5UQUlORVJTICghPyk6DQoNCiQgLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBs
IC1mIGRyaXZlcnMvbmV0L2RzYS9yZWFsdGVrLyB8IGdyZXAgYWxzaQ0KIkFsdmluIMOFwqBpcHJh
Z2EiIDxhbHNpQGJhbmctb2x1ZnNlbi5kaz4gKG1haW50YWluZXI6UkVBTFRFSyBSVEw4M3h4IFNN
SSBEU0EgUk9VVEVSIENISVBTKQ0KDQpJJ20gbm90IGVudGlyZWx5IHN1cmUgd2h5IHRoYXQgaGFw
cGVucywgc2luY2UgbXkgbmFtZSBkb2Vzbid0IGdldCBjb3JydXB0ZWQgd2hlbg0KY29taW5nIGZy
b20gTUFJTlRBSU5FUlMgd2l0aCB0aGUgdXBzdHJlYW0gc3RhdGUgb2YgdGhlIHNjcmlwdC4gQnV0
IGFueXdheSwgd2l0aA0KeW91ciBzdWdnZXN0aW9uIEkgd291bGQgdGhlbiBhbHNvIGhhdmUgdG8g
YWRkIGl0IGhlcmU6DQoNCkBAIC0zNDcsNiArMzQ2LDcgQEAgbXkgQG1maWxlcyA9ICgpOw0KIG15
IEBzZWxmX3Rlc3RfaW5mbyA9ICgpOw0KIA0KIHN1YiByZWFkX21haW50YWluZXJfZmlsZSB7DQor
ICAgIHVzZSBvcGVuIHF3KDpzdGQgOmVuY29kaW5nKFVURi04KSk7DQogICAgIG15ICgkZmlsZSkg
PSBAXzsNCiANCiAgICAgb3BlbiAobXkgJG1haW50LCAnPCcsICIkZmlsZSIpDQoNCi4uLiBhbmQg
SSBndWVzcyB0aGVyZSBtaWdodCBiZSBvdGhlciBjYXNlcyB0b28uDQoNClJhdGhlciB0aGFuIHNj
YXR0ZXJpbmcgaXQgYWxsIG92ZXIsIGRvbid0IHlvdSB0aGluayBpdCdzIG1vcmUgcm9idXN0IHRv
IG9wZW4gYWxsDQpmaWxlcyBpbiBVVEYtOD8gSSB0cmllZCB0byBzaG93IGluIG9uZSBvZiBteSBy
ZXBsaWVzIHRvIHYxIFsxXSB0aGF0IHRoaXMgc2hvdWxkDQpiZSBjb21wYXRpYmxlIHdpdGggYmFz
aWNhbGx5IGFsbCBvZiB0aGUgc291cmNlIHRyZWUuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvZHpuNnVjbzRjNDVvYWEzaWE0dTM3dW81bWx0MzNvYmVjdjdnZ2hqMmw3NTZmcjRo
ZGhAbXQzY3ByZnQzdG1xLw0KDQpJZiB5b3UgYXJlIHN0aWxsIHVuY29udmluY2VkIHRoZW4gSSB3
aWxsIGdsYWRseSBzZW5kIGEgdjMgcGF0Y2hpbmcgdGhlIHR3byBjYXNlcw0Kd2UgaGF2ZSBkaXNj
dXNzZWQgKHJlYWRfbWFpbnRhaW5lcl9maWxlKCkgYW5kIG1haW50YWluZXJzX2luX2ZpbGUoKSku
DQoNCj4gDQo+IA0KPiBBbmQgdW5yZWxhdGVkIGFuZCBzZWNvbmRhcmlseSwgcGVyaGFwcyB0aGUN
Cj4gCSRmaWxlID1+IC9cLnlhbWwkLw0KPiB0ZXN0IHNob3VsZCBiZQ0KPiAJJGZpbGUgPX4gL1wu
KD86eWFtbHxkdHNpPykkLw0KPiANCj4gdG8gYWxzbyBmaW5kIGFueSBtYWludGFpbmVyIGFkZHJl
c3MgaW4gdGhlIGR0cyogZmlsZXMNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyMzEwMjgxNzQ2NTYuR0EzMzEwNjcyQGJpbGwtdGhlLWNhdC9ULw0KDQpJcyB0aGlzIHN1cHBv
c2VkIHRvIHBhcnNlIHRoZSAiQ29weXJpZ2h0IChjKSAyMHh4IEpvaG4gRG9lIDxmb29AYmFyLnRv
dG8+IiBpbg0KdGhlIC5kdHMqIGZpbGVzPyBCdXQgc3VyZSwgSSBjYW4gZG8gYSByZXNlbmQgb2Yg
U2hhd24ncyBvcmlnaW5hbCBwYXRjaA0Kc2VwYXJhdGVseSBpZiB5b3UgbGlrZS4NCg0KS2luZCBy
ZWdhcmRzLA0KQWx2aW4=

