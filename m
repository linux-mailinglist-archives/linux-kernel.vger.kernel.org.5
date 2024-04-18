Return-Path: <linux-kernel+bounces-150336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC828A9D91
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAC01C21B05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EB8165FCD;
	Thu, 18 Apr 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pyAyBKEn"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F79165FDF;
	Thu, 18 Apr 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451797; cv=fail; b=A/J0hi7mx1j8BsknwS+n89Mzx8IdQfctUu3OM+j3584n1hLGjS1r8armouNRqpTClXbJEuYgDWIKTwcgCYVdkwnPB46LXb39E/V23O3ya0u3ltOYtL8Hye8LWeA0uDjHlY/GhHvRoABCQo00/ObI3mots9004AFLTB0+YeU+Zbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451797; c=relaxed/simple;
	bh=PuI4q06l9GfInNr/rz6p4DOFl2fNRhv/MiZZ6iOEgRo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RU7WIrbTKRoMkUuYxBTW3q3jiGJbbsP1XtgUfoZz8x0GmMYwTsOMtffaDKXV9F7eM7ct3ZI+xdKzsMDFSt2rNsYUP3IGnpxc2sn5zMQmUvga0XLVieecRI3Svaq2rgrk13wlNxCGIENndhUcT6CxXass0gx9DSt7See3bzC3wro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pyAyBKEn; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYyc+S13cpwNZAg8UXyd/yA8wUCWQPOez+7A13ZCH7qacpOIt4kc/XcpTreaAw+0OCwtTEp8vwg9IBwrqHPBHP7XzK7i4qlJWi6UakuUyskd1AuXyv5LHsqLY0Xi0tOfKC/Adc5J1V6tXqnJsHgPoTcyb4SzGkmJFuXykUF6PWGgTQBjPJWt5ETwvEyai665L55H6PXL6KtxiiXn4ZTfkRjDX1b3aRmO5vH/NqNTocTnoqwxcI9mwjAuqK9Vg891jnzZUIuT12Ibezsk43ZsyhuK8A/uxPUEid9OmP5RlBA+i0bx7Bh/qVivuAE3DZ+L+obTr6EfZR75V4A06l0rhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuI4q06l9GfInNr/rz6p4DOFl2fNRhv/MiZZ6iOEgRo=;
 b=FiZc2Z0QRKLss0q9wHkM2LLR2RPFdbUZH7RIh0atCjJNQbli/86j+gXoizjvovVlaTuDO/k0iTF0a8hMht2Yj01IJadRcYPp7zavbs4NUkV+FhNXWDG2iHh1d5vT/1yKUqnVd++c2pe2xj3Je3O4hgiLhubsBGMPesNrprgwYNUkokPY5DfhQ9lJiPGgholb6fM7c35xLK6VjhoGaUeluBWwlodYnYv5WEoNMSbT+jQk/wRC5JxVG9hXcTwmTcYTnQY4MBRz/MCAzB7xTlldLzxeMtZhEl5uktP+j0k5NANxC2tEHGL8sB8wzr+q2l7rgRk6hSAUJ8GwWeIa0NPz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuI4q06l9GfInNr/rz6p4DOFl2fNRhv/MiZZ6iOEgRo=;
 b=pyAyBKEni10p2P2L+4opfdtLhInDSlpGRk86dMEBpbFOLx3nJHjsCLAUiogR9Egueb2xVz8hz0v+CWO5cKcnBfoPG4o4+DTdqS3Pjwt8S6r9rS/vxiED32Ve6bjyCz4ckKZGQlb6oPi4Rd34IR7FA24sXeD3ndYRVqKsDcgLnYY=
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10)
 by VI1PR04MB9955.eurprd04.prod.outlook.com (2603:10a6:800:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 14:49:52 +0000
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::ead1:809:aa83:c1e2]) by PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::ead1:809:aa83:c1e2%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 14:49:52 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 1/2] caam: init-clk based on caam-page0-access
Thread-Topic: [PATCH v3 1/2] caam: init-clk based on caam-page0-access
Thread-Index: AQHaj7/kSDBJfz5C3UOolJ/lAZDEtbFuH9YA
Date: Thu, 18 Apr 2024 14:49:52 +0000
Message-ID: <a4143756-e046-473c-8507-d638c5ee0442@nxp.com>
References: <20240416053303.421259-1-pankaj.gupta@nxp.com>
 <20240416053303.421259-2-pankaj.gupta@nxp.com>
In-Reply-To: <20240416053303.421259-2-pankaj.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9709:EE_|VI1PR04MB9955:EE_
x-ms-office365-filtering-correlation-id: a59cb9bc-df2c-412a-e7ab-08dc5fb6ce09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lt1oqwihZRUbm319RSqBoElbpsGfn5cP4pYILnEqRMnBaNk24ozYtHbWHNVAvc78mZ+4tV9vj9zqr4wChNulTI2zUxSqpXmqjSd/7ZdYeJ1py9rZQwFrInZcdAydV8dx1sZqp/o7qwmgWrt9ZhL2lhlcMyrEBmGFzmK9nvFgwbKZQkQyb8jRR2yyFAfONKxf+gMoiEcBDX7gNmeiOJYKADH3WqviutUtFzv37N68o1ZM4wn3eepv1nAOORkhWc9CL5rtTM6/itnHLUbj1KIpRncjo5zEZgUJYDaorAT7kl7eeyo1lk9fo9J9Z/jwtG+W7cLJYrXau+RSN3hL0QrP1ImAfOqibqNE16innLa52wGIN4bD8c37hvEasLEU11IgkFDch5Y64C0Ye/Qhxj9A2tv/b+lrMAZNUHNYbNVW9NPnrg9HVf1/7jFJ+wIYMVpqYrOABqbmNanbFdxQSJ4wGR1EZ5WtRaygDBaqahPWh/EUbWUlxWUCja7fptxFI4Umq/MlHvhBzd5KH0suJSMyVXBrmzyg/WvQax3U4uJGU5tqliTVgfA65DgfB0ChFWji3mOiJdmOiziIah3c2tGj3K7MVnb9UohY8WfoSm96o8CFUE4yyjDobkyqzAibOg2R3b1SXL9RjBefzCeB9+74hITaonJcWpPgUFvPSPDQ/0tJOzlGNj929yiaW90UOCnnOFTNJAOXXkO54fkvSiOyE/ioKJfw37wRShlqVadF3Og=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9709.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1hTN2pLYkViUDFRNW14MnFUUmV2YU1hK3ZIMlBlZ3FNWlQwR3RpakZQblJQ?=
 =?utf-8?B?RTMwdUQrYU9wY0tlWGhtckJCSGtQQjFIT2k5cmJYSnRVcmh2UVZxRWNSOW1u?=
 =?utf-8?B?WklER0VOVHhoN1FUbVQyOWxsZ1lac2hsWUFjcG5pbC9DdGtIL0Z4TzdsNXpn?=
 =?utf-8?B?cENFSVM3Z3FzRm1IckVWTnJPZDA0WEVLRHFsalJzWDFxcE5rdWMzNHIvdGdY?=
 =?utf-8?B?Y2NmNGNnMDNzUFoxeGhVTG9iZWNmNWw1UHZKTFErdGFJR0orbjAxZHVCamFM?=
 =?utf-8?B?ZERaODVOT040OFFmallxWkFEMXhmaUd4Q1ZLcDRrd1FJZGNMQ1ZXZ0dPZytr?=
 =?utf-8?B?bm02NVh6bEZURlcyZ2pEK2lCVzlJSDFVeWZPcERWTFdxdUZldFVIOEhreTZu?=
 =?utf-8?B?SUF2S1JGVWVUNGcreDduN2VtVEY0M0haYU1WQlRVeEhUMnFmSXVCMncwT3hm?=
 =?utf-8?B?V20yU3dmRlJWaDlRODJLRW4zY05JbGt2Q256RlJOeW5tbENWS1g5ak5Ed0ZY?=
 =?utf-8?B?TE9KNGpkNUNUV0xDc20rWStOb0owc2l2OTJTazFhYU4yemFaR0l3Wk5RMk9C?=
 =?utf-8?B?Uzl0Wnk2eVNXLzNBcWVXWERaOTNqU3V4THRXZHVCUFIxOVlVaWpZSjBiRkJy?=
 =?utf-8?B?bVhIYzlBZk1sTG1KUXM4RDQwK1FUOE5hNXhUcld1bU4rMVBmbGI3UUtFcjR2?=
 =?utf-8?B?TzZoSm5IdXZWQWVPbnQ1d1VtdDVZQWhqVGs2UTRSUGFUTTgzMm52QjlZSklN?=
 =?utf-8?B?Qm81dFpFQWw1RGRoeU1vOWxZZ3IwZWdmZjVOdHNWTFNUQ25vaWhSM1pPMTNU?=
 =?utf-8?B?bHdrZUZ0bmd1TW1kbld3MHovTW1sc1ZIbzh5TVlucUhQVk5XNUMwOWFGWjNU?=
 =?utf-8?B?TDF3SnN2WVFVM2ZVVEhXUVZCMlJTOStxN2poNnBkNzJUU0RiZTJzR0kvMGVI?=
 =?utf-8?B?UHRmZmJHSWdoS3lQenlCYmFYMUZUQ1lleWFtRVMwREVTUXBIY3ZSWkFIY2sz?=
 =?utf-8?B?VldWZEJ2eURsc2dQMnRnUTllV3g1RTZJU3lnNVBxL21XOVlNMkk4MitYdndk?=
 =?utf-8?B?LytyTGlKd0wyUzJPUVVSaytrTXY5b0VIWitRSjhiWlp1d1YyNWlGZTQyWmRo?=
 =?utf-8?B?aEppNXcvU3NQRjVpMjgrZmtCUlRGMlE4aHRYbXNNY1ZZTUhsd09uVXVLaDhC?=
 =?utf-8?B?S2t0bWdSVERFemt6UHVLMWt4QWJQeVB3V0lSdHVqM1BiL0FSQlNVU1V6TmVC?=
 =?utf-8?B?bWJZL0FIVU93Z0x5aWZ6bkxNTVBiL0FTRG5ac3RJODRjL2o0U3Q3bExjaU5T?=
 =?utf-8?B?V3lmYVUzZ2hUZm9DY0JJK0xCQVliUWtXZnB6b21IYkV4YTRKR2VGdS81R2Vh?=
 =?utf-8?B?Qkl5eHYvcXRUekFpUnRTcnMwc1hBcGlCVDcvYjdvRk1JeDJjRlNXalNqYnJG?=
 =?utf-8?B?Z3poaW5TV3h2c01XWXZsejVzaHFaWGtYVUVjYkxkOGVSNFBGbVc4Q25odnpB?=
 =?utf-8?B?TWJnejBZUWpLTDBUdGdkdHRrWHh5Q2ZPMG53anRod0RkdXA2Y0lTK2gxckJG?=
 =?utf-8?B?d3dpRmMyRk9iOWpzY05odjdhZ1h5alpyNHpFc2UvZFBiSFpkUEN3T1VnczZz?=
 =?utf-8?B?RXAwV2RNblJuSGllSlgvenFKUVNTV1kxdExVTUpub0x3V2w4MHZBNVJlRE9U?=
 =?utf-8?B?eGdOYVhzM1dkMnRCSXFaUFc5SW1UdklsVC9tZWUxN2xhdGZsQm0xVTlpVFIr?=
 =?utf-8?B?TU9UZFRaMGtBdHhqQWk5M2F3K2pnWE1LazdiSEhmL2dmaUg1ZEhLL0d5dW1I?=
 =?utf-8?B?YUlJaTBJYjZ6cTFESThINHBwdlpjeFVnZkFqalVReUpwUGlBUWFMbU9SVHVE?=
 =?utf-8?B?cmYxZE0zVC9CUzgrcU9VTGNZeGFlQTQ0YmkwVEtvQlRXc3VKL05WZ0srWG8y?=
 =?utf-8?B?YlFzNURYWjY4QjhKK01kN3lVbGd1T0l6eWUwdWJxWFBzelhhaUk1aDFmbm9v?=
 =?utf-8?B?RHg3Mm9hQ2xoNmo3U0krdU9QUU0vRnFYWGg2Y2NZc1lIOER6SzhaT2xGeEVj?=
 =?utf-8?B?WnQyZ0hobEx0UFpuS2E4WHJYVGZIVkloWkVWaVhqLzFDM2xMUFhLWXlFRG9z?=
 =?utf-8?B?S0UwNnNDZDUyRi9IN1VoZnlWSEdmaTN3Nzh2eDcwRjNGdi9XTWFHejArQm1l?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D10629E2C8DAA4EA85C29F058D729FE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9709.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59cb9bc-df2c-412a-e7ab-08dc5fb6ce09
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 14:49:52.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5GourM81zSyWcpAP3ZucHP1iWa/OBjQJIrIJMBq/CFpms1vRqEl7gAtik+Quc/Kg85jCPpVg7R/+NY9/amlfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9955

T24gNC8xNi8yMDI0IDg6MzUgQU0sIFBhbmthaiBHdXB0YSB3cm90ZToNCj4gQ0FBTSBjbG9jayBp
bml0aWFsaXphdCBpcyBkb25lIGJhc2VkIG9uIHRoZSBiYXNpcyBvZiBzb2Mgc3BlY2lmaWMNCgkg
ICAgIF4gaW5pdGlhbGl6YXRpb24NCg0KPiBAQCAtODg5LDE3ICs4OTUsMjUgQEAgc3RhdGljIGlu
dCBjYWFtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAkJcmVn
X2FjY2VzcyA9ICFjdHJscHJpdi0+b3B0ZWVfZW47DQo+ICANCj4gLQkJaWYgKCFpbXhfc29jX21h
dGNoLT5kYXRhKSB7DQo+ICsJCWlmIChpbXhfc29jX21hdGNoLT5kYXRhKSB7DQpUaGlzIGlzIG9i
dmlvdXNseSBpbmNvcnJlY3QuDQoNCj4gIAkJCWRldl9lcnIoZGV2LCAiTm8gY2xvY2sgZGF0YSBw
cm92aWRlZCBmb3IgaS5NWCBTb0MiKTsNCj4gIAkJCXJldHVybiAtRUlOVkFMOw0KPiAgCQl9DQoN
ClJlZ2FyZHMsDQpIb3JpYQ0KDQo=

