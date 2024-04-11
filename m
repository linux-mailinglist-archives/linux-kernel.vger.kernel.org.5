Return-Path: <linux-kernel+bounces-140457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4DF8A14E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A464F287B04
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CBE64CE9;
	Thu, 11 Apr 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="g7tOCxun"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356371EF1E;
	Thu, 11 Apr 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839553; cv=fail; b=eM3/tMyjomwSLsuG1FEJcpSI7N1sx+e9KntMs7JvxADLBPMADxpUkQZHK46xRhjob0Y1xkWUjcszIql7FDZt/WeRtLANqpWDh421wq8ocJJSYPY5nwjXo/HLx8bxyp4TrW0IMsieb72XvA+t5Zn1xTY4kgWPY294lHTDQyyWpGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839553; c=relaxed/simple;
	bh=ZBsbXmEMVyI4778S6FfQnpji3+hp90u8b8Ai8QRw3To=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CBovBmBx1XqrgAjhW2+UXo17e3fpB9RaqphHfsmQCiFuxsMYymf91mgQx+qj8fdFb1ecI+yIO85ySHnUtuHg36IgGEE6JVGhH6UlCjow4/+0MGGJ3EgadpPnyWLLmGvoMJ3SsBg2JDF+mIPU7rliF4yW1VhYFmZHbzRD1alD5HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=g7tOCxun; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B5uXDF031981;
	Thu, 11 Apr 2024 05:45:38 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xea5f3pq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 05:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzphuzgiTqbl3QTQcq3rMG3yUqNzeBj2WM1Bsb0NbPYRpJwkBb3lMnzmyDY9HXYaTpINSfeVuF0FyWt1tIh9WcqX03T8+I9cBxWXyQADkVHPoUlmlXBmjKNCUY+3q+wKD/9mvoCyBMvdkFLPAtc9kKfYMgQENodyuAeX35U687AFhpse3tTm1F9qJHCgVGe+bEQF1ol0T9LUCL5ZP+3O3zw/Wk6wDzKEFSVHsjihHXNf3C3ct1geihTJduyj5mwMLPYhLKeAfCt2OSlNuEgBgM5Nb0VPjfbHcBxvNSE2A3noGyQnKlHcJI1D8kU3LtfaDr7TNviELb2zuMfdWDvUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBsbXmEMVyI4778S6FfQnpji3+hp90u8b8Ai8QRw3To=;
 b=ZGRn4cn6GqbL7NbQnHvveIXaFTSpbh0eCbMNReVMT7frHw8xqsVq/qEakIVwfmSY7rrsP20x1tpxah+7PPhEUR5T7TkOROg8Q9ERaLAg7FGCuJHcrP9VSSNEOpEKCIOeTElP2z/+lvX0em4Lal6b3BwcfQkMMgeVUNnoDsyxjVrg7w9SYgqLIJR+/5KvSbG4JulD20fw53jaYH/SAJRwhHi/5ab9fYJ2eunZZ1xoBa7ino9J9I4BXKdDi6kQhKu8ckiEqdpTubAkrEI6Z6mwwSjG8fVnoamNHbAN6GWxUcXw0mY0wlrzpWSI/WRh99joNmc8hCLhW+s0CNQB0tzrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBsbXmEMVyI4778S6FfQnpji3+hp90u8b8Ai8QRw3To=;
 b=g7tOCxunDvqf7ekgKtYQgFF9v12tu0b+RXG868ziBSyQlvyT92zgTQ/FFBqmI+vlXHrgrMVojJ+jud0sMru9EmOjC2rqjov0B0RBidv/PfDLq4BPQj52wcnkVpKZPhNxCU04uZJAAU38j/6YkP1jvzGe00RtHuCJszCeDcYMTJI=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by CO6PR18MB4417.namprd18.prod.outlook.com (2603:10b6:5:354::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Thu, 11 Apr
 2024 12:45:34 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7409.049; Thu, 11 Apr 2024
 12:45:33 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH] octeontx2-pf: Add support for
 offload tc with skbedit mark action
Thread-Topic: [EXTERNAL] Re: [net-next PATCH] octeontx2-pf: Add support for
 offload tc with skbedit mark action
Thread-Index: AQHaiYYdopsytK77a0qkTSyQTUeNQLFf2cyAgAMuvwA=
Date: Thu, 11 Apr 2024 12:45:33 +0000
Message-ID: 
 <CH0PR18MB43390D633115E7843BB781AACD052@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240408072638.26674-1-gakula@marvell.com>
 <d9fde608268413dda70bb6ef328b8d823d568f74.camel@redhat.com>
In-Reply-To: <d9fde608268413dda70bb6ef328b8d823d568f74.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|CO6PR18MB4417:EE_
x-ms-office365-filtering-correlation-id: d0a84d97-e16d-4a9f-8b5a-08dc5a254778
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FIV6/hG6hkuji1xmCdiukfcrzVpOw52C4CTBt9W5NkCdPX51O3SoQ+wAMv23en+ClRlIjmc1zBAxPzBU5+gKgK1YUSyM3fd+i0a3uALT7yvV/w+X//5Wcji+8GpfZSclxjotvgg3CGL2Nni4j0f+kDbvC4r5ptAboakdE3oTOT4Op5vfLQFhKOswRUjrpI9yNU7LnPdNcJkoybXNwdKkf6M5x7Kq4vGfbEWzLSi+fixQiPcFIcUbTNTXNiTQnpVME3UHwisLvwjel+EZDDc63dGtlSzvSMLAOdBOHTYB9JfU9oZ4rOeV3cocbdnaD20ZzUzc2pI6swe7FqpHwH4V/4Kg5q8AAfUznqWtC9boE3v7PYdxAPUAkaHKqxu/B2zXNt/j5E+6N2gDaxHJho1Bap2RwZSde3Y88gfgv6ur/kS2kL6PbsRb2K3hHDRDBLdMH/qyQ7B25DsERfwgFHAih5HRyByVE+o/y/+FI+4im4ii71mnAAGJX3sd9XF040ZYGkWGwbW9GoaTZIhNvqI73a934w6CvuJ3Vpkr+s0R+l4AS7Jto3kqd1J96VDmonXBJ+waSyNlMXH+lENCenDkcuKTIPgHdrVMkR9kC3HL7WGyJgO/Aigcztm+YhCBXzF9ibCVlmw3mLlykamaU4SxdErjOr6tKzTTdiHWql+BUCMVGt2Ojq5O9geCgjKu7BBV16PwY1D0hsIn8EDuIiXLeahYGyDykAI7FDMhug2j0OY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TGdrOFVROTAwNU5UOEk3MjQwc0FRSFZuekZnZXVObTIyNFZ5KzEvREx4cXRi?=
 =?utf-8?B?MDVFZWtCcHRCbUt6MXBWZFZCU0NhbW1zMk9yRTBEdmdBb2hMY2hEbjhiZkdM?=
 =?utf-8?B?Ti84ekxWV3hJQTNpMk5SNWZ4RGlSS0NMck5saHpyUmtVMTRYd0svUkFpWDFk?=
 =?utf-8?B?Y2lITGRRSGJ4SVBNZUVEWlBzNFF1ZmJENnZ5eUp1Mi8zVDkrRUp2Z243NWFq?=
 =?utf-8?B?MllCSUprK3pTazBTRmZ4RVgwSjhXZGxzSHZGL1ZCTFRJcXIzUWpvTHhjUUVo?=
 =?utf-8?B?bVdqM1p5bVJraEc0WG45QURoOXZENlEvcDdkbDZxelJLSFdxSkJsMml6YkZG?=
 =?utf-8?B?Zk4zeVhCWlcrd3BCUjZqZkU3eGpIMWUzNi8zVDdHMVVvbWZobWRUSmdaVVov?=
 =?utf-8?B?MjNIK0VTSXhBUkYwc0FGZmMyZkRKVU1RSXVPbms4QzQxNzZBL1lpcXgreGN2?=
 =?utf-8?B?MVcvNkkwTTJ2dFJ2TjIrUEdPWHJQa2pQYnpuYlp2QTRDQUdwcUFsQWRFUE5w?=
 =?utf-8?B?NlNlTkEvSU13MDB2S3lxM1NDUlppWEtkY1ExKzM5UncxRDhTSlFTa1hjSlZq?=
 =?utf-8?B?czY4SEhncElSYTlkMlU0MkZHUzZMU2tMeUdMT3hhWUVBaDVieGxtTnRlMU1z?=
 =?utf-8?B?eTRGKzJHbDZ0Ti9pVVpIQmJ3bkFVU28wKzRScTZwODE5RVhRWVp4cjhBbGNh?=
 =?utf-8?B?REVHY3hyTzM1S1doT1JjajZpWDdsTUZ4VzVOZ0Uxa054WXZMNGhsUUE1ci9G?=
 =?utf-8?B?VE1tMWNRVXpWQmYrRmo3emtNdUp3djFBME45c3dqRGdscnhQUHBEaElPVGpz?=
 =?utf-8?B?VVB0N0RlNWc5TmhNUlYzZTJOZVRPMFBjZTA4WnlheXB3TVFlVXZmSzY2OXAx?=
 =?utf-8?B?RjliWlVvaHN1L0JUQjQ2VEFYbXhkL0Ewa0hXdkwycnYwT3ZmN0k2Y3RGbzQr?=
 =?utf-8?B?akRUZ1BSZGJZTWdkcjl0VVZYVXBnRExXK2lKbXQ1dWszb2Fnemw2dVNLelI0?=
 =?utf-8?B?WHVmeDlkaGdUTE56MFVDUUhxeVZQcFF1ak81MGFpWER1eXpYTWFJai80aGxJ?=
 =?utf-8?B?Q3E2VXVrWUtQNWhTeHNEaWsvVlFOd1NlMUJEQjlmYVNsQmJaZHdmWDd1NEly?=
 =?utf-8?B?ZnBINWZDcG5mSG5ySWR5aDNrRWhGWk1YMXJmY1puN1c3aVdPMTR6a2NaN2dP?=
 =?utf-8?B?S29Ja3ZMajhUOGMvRlB3dXdndk5wdDZEbWVVUzY3dmMraFMzMmVmUWhWTDU1?=
 =?utf-8?B?ZFZrQm5SMHBhdUQwWXQxcHg3OTE3RkQ4cEx3M2NRdFBkb0U2Y3BPQ0h6RFlx?=
 =?utf-8?B?dWFXU1JNQUZYVC9LZUVHamhaVWg1MHBSYW14dldQODBFK3ROeDFOdjFMV3RO?=
 =?utf-8?B?WkwyU1UyaUtyZ00zSDRGOGp2TjFBSnFPOW9SYnY1Uld0YWNXREtwMlBuY2Zl?=
 =?utf-8?B?bWxaQVRKTHFjTW91cHN0ejU0Tzl1UVJkVmI0aEJCaFVERHl0MStuVDdYYnAy?=
 =?utf-8?B?SFV4UkkzTWQzRm5xY0Y2SnVGdy9VaHBtL1JrL3R1ek9ENXhjY1lpV2x2ZGty?=
 =?utf-8?B?Z2ovb2JudDc0K3hJQ0NGcjlpaENaUm1mSGlibU1zZFlNK3BKVTJXVzdNV212?=
 =?utf-8?B?QXFRQ3BHcmhEclUvaWFWVnVFUHpZbzRwaHB1UXJpcDdCQ2sxNGxFck9QdmIw?=
 =?utf-8?B?Q3JLMVZVZnhrNUlyN25NNzdJWG9NRUc2U2d5NE5vaW54blN6YUs3UStBNEZT?=
 =?utf-8?B?SUJJZHZpK1hjbDJSamc3SHRZbFJDZEJtM093Z0pLMG93dlRobW9HVmQzVnhN?=
 =?utf-8?B?bG0xMWliaUJwTkRic2I3TGIzOHFtVEg3ZGNONmU3UkZ2N0d4UHA4bjJHL1hm?=
 =?utf-8?B?YiswcVhqNXNxT1NkSm50QnZsajJMMlJYbnBKWVdLRmsyOW5IbHJwRXdwTzRC?=
 =?utf-8?B?SGNMNjY2TThXa01mTittSnVNMjB0aXY2UCtvRjZZUWVqUkhRMml4Q2Y5bXQz?=
 =?utf-8?B?dFV1d21QYllDdytBeEt5MVVvK1RpTDdkNkJoaWh6SDdOL2xBVzVDeWk3a3kx?=
 =?utf-8?B?NHY1a2ZPMjNKS1o3dlRzQTVZa24wQ2NRWUszeFhsd01BcEVJalVWM3pUMUNl?=
 =?utf-8?Q?5LdQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a84d97-e16d-4a9f-8b5a-08dc5a254778
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 12:45:33.8594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAZPus2BWXKNMI3oAlOd6FGhvuTa+iq0p8m9ZkuFqeJ6bN57N0YEmKYhZPZPI4qZlJRjppacaUcXDMpDm5n01g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4417
X-Proofpoint-GUID: KVJppL3B7AhceN0kiSCH_DpN1_uw6nyJ
X-Proofpoint-ORIG-GUID: KVJppL3B7AhceN0kiSCH_DpN1_uw6nyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_06,2024-04-09_01,2023-05-22_02

SGkgUGFvbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCA5LCAyMDI0
IDU6MzcgUE0NCj4gVG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+
OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBrdWJhQGtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdv
b2dsZS5jb207IFN1bmlsDQo+IEtvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+
OyBTdWJiYXJheWEgU3VuZGVlcCBCaGF0dGENCj4gPHNiaGF0dGFAbWFydmVsbC5jb20+OyBIYXJp
cHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
UmU6IFtuZXQtbmV4dCBQQVRDSF0gb2N0ZW9udHgyLXBmOiBBZGQgc3VwcG9ydCBmb3INCj4gb2Zm
bG9hZCB0YyB3aXRoIHNrYmVkaXQgbWFyayBhY3Rpb24NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBPbiBN
b24sIDIwMjQtMDQtMDggYXQgMTI6NTYgKzA1MzAsIEdlZXRoYSBzb3dqYW55YSB3cm90ZToNCj4g
PiBTdXBwb3J0IG9mZmxvYWRpbmcgb2Ygc2tiZWRpdCBtYXJrIGFjdGlvbi4NCj4gPg0KPiA+IEZv
ciBleGFtcGxlLCB0byBtYXJrIHdpdGggMHgwMDA4LCB3aXRoIGRlc3QgaXAgNjAuNjAuNjAuMiBv
biBldGgyDQo+ID4gaW50ZXJmYWNlOg0KPiA+DQo+ID4gICMgdGMgcWRpc2MgYWRkIGRldiBldGgy
IGluZ3Jlc3MNCj4gPiAgIyB0YyBmaWx0ZXIgYWRkIGRldiBldGgyIGluZ3Jlc3MgcHJvdG9jb2wg
aXAgZmxvd2VyIFwNCj4gPiAgICAgICBkc3RfaXAgNjAuNjAuNjAuMiBhY3Rpb24gc2tiZWRpdCBt
YXJrIDB4MDAwOCBza2lwX3N3DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHZWV0aGEgc293amFu
eWEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbnBjX2ZzLmMgIHwgIDIgKysNCj4gPiAgLi4uL2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2NvbW1vbi5oICAgIHwgIDIgKysNCj4gPiAg
Li4uL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90Yy5jICAgIHwgMTMg
KysrKysrKysrKysrKw0KPiA+ICAuLi4vbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25p
Yy9vdHgyX3R4cnguYyAgfCAgMyArKysNCj4gPiAuLi4vbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0
ZW9udHgyL25pYy9vdHgyX3R4cnguaCAgfCAgMyArKysNCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCAy
MyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X25wY19mcy5jDQo+ID4gYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbnBjX2ZzLmMNCj4gPiBpbmRleCBjNzU2
NjljOGZkZTcuLjYxODg5MjFlOWEyMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbnBjX2ZzLmMNCj4gPiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbnBjX2ZzLmMNCj4gPiBAQCAt
MTE4Myw2ICsxMTgzLDggQEAgc3RhdGljIGludCBucGNfdXBkYXRlX3J4X2VudHJ5KHN0cnVjdCBy
dnUgKnJ2dSwNCj4gc3RydWN0IHJ2dV9wZnZmICpwZnZmLA0KPiA+ICAJCQlhY3Rpb24ucGZfZnVu
YyA9IHRhcmdldDsNCj4gPiAgCQkJYWN0aW9uLm9wID0gTklYX1JYX0FDVElPTk9QX1VDQVNUOw0K
PiA+ICAJCX0NCj4gPiArCQlpZiAocmVxLT5tYXRjaF9pZCkNCj4gPiArCQkJYWN0aW9uLm1hdGNo
X2lkID0gcmVxLT5tYXRjaF9pZDsNCj4gPiAgCX0NCj4gPg0KPiA+ICAJZW50cnktPmFjdGlvbiA9
ICoodTY0ICopJmFjdGlvbjsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmgNCj4gPiBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2NvbW1vbi5oDQo+ID4gaW5kZXggMDY5
MTAzMDcwODVlLi44MTVhZTEzYzM3MWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmgNCj4gPiArKysgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9jb21tb24uaA0KPiA+
IEBAIC0zNjMsNiArMzYzLDcgQEAgc3RydWN0IG90eDJfZmxvd19jb25maWcgew0KPiA+ICAJc3Ry
dWN0IGxpc3RfaGVhZAlmbG93X2xpc3Q7DQo+ID4gIAl1MzIJCQlkbWFjZmx0X21heF9mbG93czsN
Cj4gPiAgCXUxNiAgICAgICAgICAgICAgICAgICAgIG1heF9mbG93czsNCj4gPiArCXUxNgkJCW1h
cmtfZmxvd3M7DQo+IA0KPiBTaW5jZSB0aGUgYWJvdmUgZmllbGRzIGlzIHVzZWQgYXMgKHJlZmVy
ZW5jZSkgY291bnRlciBmb3IgdGhlDQo+IE9UWDJfRkxBR19UQ19NQVJLX0VOQUJMRUQgYml0LCB3
aGF0IGFib3V0IHVzaW5nIGEgcmVmY291bnRfdCwgc28geW91DQo+IGdhaW4gc2FuaXR5IGNoZWNr
cyBmb3IgZnJlZT8NCj4gDQpPaywgd2lsbCBzdWJtaXQgdjIgd2l0aCBzdWdnZXN0ZWQgY2hhbmdl
Lg0KDQpUaGFuayB5b3UuDQpHZWV0aGEuDQoNCj4gVGhhbmtzIQ0KPiANCj4gUGFvbG8NCg0K

