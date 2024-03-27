Return-Path: <linux-kernel+bounces-120781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5904B88DD00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825FA1C27A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F2312D1E9;
	Wed, 27 Mar 2024 11:58:24 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2110.outbound.protection.partner.outlook.cn [139.219.146.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585712D76A;
	Wed, 27 Mar 2024 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540703; cv=fail; b=G3JRW+D4jeltlZ2c2/v85IQZ5EK4J9oCOR8kmfIoGNwTM2FoowDvtvjl1JvHb//NGdx6TssP9dOpYCJbi5mFn/YYSFVU6G+xhtCQaVtOGPqpD69T7FLRuwy+6X/ssWXM1v23Jwm+k3CHUkKEJkwthO9avVaaFqIjWT5Tl9DL/xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540703; c=relaxed/simple;
	bh=6J0PYnuS6gxhttxtvWE+UEk5sZj0VbUrlVeD8hI/aMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qN3BHfXM6/WRp9LhSalejWt6eUgv0hfT8aB7ev4WanT6gV7FIcP/SnN8Ra4+jQyZi7cCKb6ndXkpX+Kh3dmuAZGkFwvsaIaCpedwOYbfmeIYKuEZYuwlLtZoFICSHaJFTFueXmsx122hKfppxv566+4XfeEcQy2RKQXeBDJavaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnQOqffD8Ux8TGv9cQdoDSREreROee1v0xel3r6c/Z2lu0GUlLlEISPnoMYgPSd0DhndJcI4A5vt7exDi631m0hrSVB+s8SPW+Dyzc1ISpuA9vTYJT/VemdvnHrTLGXZlyBV21U9q4PUbKQHV8cqpxrJQlqIbizmIUWxrGVSMa8qjXyFogjwjTubzsEeZGJP6u+bFdzET6yu3ZPOb5wzzfs1HC1NgZMtT3wm8ev3rXjbU0kuSLhyuazjPPZ20a2yYlXwbySfZ31shyo+AaPJ5QVzaENIB31H1GFasaY5OTo+MQGPlY7CRkUnZ0k2mFwQ20P8Iq7pl+1WZUVlGLEZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J0PYnuS6gxhttxtvWE+UEk5sZj0VbUrlVeD8hI/aMI=;
 b=PJQwc2SuDyYTqLoxXdenlFoui4XxuKx0XBCYTNJfkZb/31FiiRn8YAmsEJq0z39gx/llx25SDB7Ul3XF8V6HEmMWOTpYCa8nqkTNEpwqKonwHpaC1hFUNhrsPevbBwqgTqc8VJsp+atAXzEOm9bnRy/eb5BpQJZES8Hi4ZU6d2ovEUg0xODMyNI6uo4cW/ae8HbzRF8ZoYsDKSo0eBNq2d6bQgGkT5col118P89SatK/A+IM0Gxs9G/BKlQB1UHGvsYaqtHmSIcXghtvcOQQDDarjmxVFYTWtvGN546ZoG2xb4LwLu/94Dl8aYysLhO1j3NEhDzn054mDapxa7P2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9) by ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Wed, 27 Mar
 2024 11:25:52 +0000
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 ([fe80::feb4:a4b4:1132:58f4]) by
 ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn ([fe80::feb4:a4b4:1132:58f4%5])
 with mapi id 15.20.7409.031; Wed, 27 Mar 2024 11:25:52 +0000
From: Yuklin Soo <yuklin.soo@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, Hal Feng <hal.feng@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, Jianlong Huang
	<jianlong.huang@starfivetech.com>, Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Drew
 Fustini <drew@beagleboard.org>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100
 pinctrl bindings
Thread-Topic: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100
 pinctrl bindings
Thread-Index:
 AQHaM+jQtC6UubUli02XCaS05iYu97CzXL0AgEsU8LCAFM7OgIAWPmKQgAAmLACAImWhwA==
Date: Wed, 27 Mar 2024 11:25:52 +0000
Message-ID:
 <ZQ0PR01MB117607BB48221711F0DA514FF634A@ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <20231221083622.3445726-2-yuklin.soo@starfivetech.com>
 <3b9201e0-e1d9-463c-aa1a-cbbedd1f8907@linaro.org>
 <ZQ0PR01MB1302FD75082E80DFDDF81E82F645A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
 <2236948f-bd68-4476-bc2a-814c46c99334@linaro.org>
 <ZQ0PR01MB130288F0EC3C17147A46E4CDF622A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
 <58a62c7b-3348-4252-91be-ec30d5b723b6@linaro.org>
In-Reply-To: <58a62c7b-3348-4252-91be-ec30d5b723b6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1176:EE_|ZQ0PR01MB0982:EE_
x-ms-office365-filtering-correlation-id: a92be53d-5763-4017-c6d2-08dc4e50a927
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OgB8nTvfIu7nIEkqTeoe5iM/s5pesn98ccB37q13lPfTCKttO3zDBKvzO2ZODKbnpzRLfEQINlAFogsxxINdukjQjTb/gVCcjgSNoenw2SqTkN0ai4e59dXcUnHpExRf/MN8J2J2AurxGXDCBjNt1pZoItABZJaWwhFM6lh+3Z1RourLCwyS0mZu3CyWsRxdA++8iFrCCvC54BHDTtNaVq9Mt/7KtVlzN0YAUmQy7nV0mplwuhSYcZDpE+rGCK7aVVERx4lnN80KzG8CQgX2ltk3sJEuQuVIuYYSxcg8lHToonwUHQE4q7fm3zz0GDQ/KwOqvu9INuPOKQZuhdDL7LSbiBU7futVsrgS0PR+AHq7a1wofLRYnyZ6xvuazrhiVYJsRZBoI2JyG6tw/NQPff5KJJ2P3pBBCW1ilYLkYQMEufZ7CHpywBMynSnYX96lIAV8/Mo/Tzs5okTuNr463kAEuehbesFFNzDcZdGwlwBOiLvQ/tMOSAuD9SYZ5p7uM331xnQmGBwi++ZhNn0X430yZR9xUduxXOxFAvonXAfW0S7PZpzQwL8qHCEfkF9poJkanxEcXFAB/wd3ogoiQf8EKozMpB+0AERSAQq/unAkZtJyMIbALYIM2pZUOTCDVJfFiy9zZgk2m1oumKWMbw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(7416005)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0JCRXluK0xrNnF1OVBHdU5EYVluTFRvWWtWWkFlbmJKZUh0QXJZYWQ5eDIx?=
 =?utf-8?B?VmdwajUxOWVpTGk5MjByai9CVTFiUHJWL0x0UVdJVmw1ZjNQeTMwamJQWXVk?=
 =?utf-8?B?S0pFT3REOUNxdCtaRUk3MStLQm94R2NURC9FVzNJR2pSV0hmYnM1ZzBqVjNz?=
 =?utf-8?B?L29UOFRROFVWT3NXbmpRWnhNa2ZRTnFXdyt5QmdMSVVIY2RWQm5GSU81V3hh?=
 =?utf-8?B?Tnhzc1g4NGRLc25yc2lVenJsUjI3OFJIRSt5RlJRUTFSNVJ0V2hySWpGdjFo?=
 =?utf-8?B?a3djREVEdWRFTldONTFlRFVRbXhXTjZaMzBPTkRNR3E3cnVtdThiR1l1VFJY?=
 =?utf-8?B?SFBGSTByK2FSd3k5SExmcXo4VFEySXpvYkR0ZWdQSFJBdE9YN0JDd3FISjBH?=
 =?utf-8?B?dGVESUorM2cvVVBPdlVpVTExcGpnYmZwZVBaQlAzRktNYzR4eE51ZW9oTWd3?=
 =?utf-8?B?OTE1RXBhOW4yam40RVFlT09jNXRtLzFIdVE5d2hIL3hVUDVCS25Gb240ZXJT?=
 =?utf-8?B?aFhoMEFhSnR0N3drTlFRcCs3SDZaTHVKU0NRWEo1VkMrNjVTdnZZRmlYS3hv?=
 =?utf-8?B?S2hOU2FXSFYydTIvT0R3VkZxSWFmSFdzb0psT21FazJ6M2NlWklXZWNBMWpl?=
 =?utf-8?B?M21LeG5kenZodzRGeWJ6UnNORExadnlkUTVUM25xTmVDaWFTSi9zTm42eGZt?=
 =?utf-8?B?Qi9aUnFTZjkwbVVpR21YanpMbCtWNHc2clJTS29qZFJXYnk1UEFzU2dhVjlL?=
 =?utf-8?B?NnV1cUp2Ulp5b1F4ZjUrUXY4Ykx1em5LbEw3bENMK1ZPM0JlQ1ZlVHFuVm1p?=
 =?utf-8?B?aGNxTVVENGdJNGFaSnhqcHBNT0VrS1EycFlpcG5MalNqeHJlTHEzRE1jbzFS?=
 =?utf-8?B?RXQ0NXVCRUhjT1VPbmhpeHpGWVRhUVpPK2dCS0JacjhsSTNLRFE2M3VSdzhR?=
 =?utf-8?B?UHBVSjFhNUN1NmlUNlNCRGdGZENUK1l0eGJQR2pmY3lMREMrdEY4R2dYaWQ1?=
 =?utf-8?B?UkF2bTU5YktYVmpsUVBwVGhjSjhORmNUNmZSN2l5a3FZT2tCWEE2VGkwYXRn?=
 =?utf-8?B?cTkvOE5VTlBwaGNXczlkVDNVc1U2ZzFqMEloeGQvQWlDS2ZoOEQrcWpuT0Rx?=
 =?utf-8?B?amZsRWdmSEEvek10OXN6S1hyNndXd3l6L1lNVGt4VlQySHlZUjV4eXVkcXRt?=
 =?utf-8?B?RjVMdFBnUmdLcWFPbThWZ2w2MnprYUIrUzN1bFJNNzdJTjl5ZEpDbCtWSy9t?=
 =?utf-8?B?UUt5UVFqbmcra1NvcEFIN1Nmb0Q5dSt5MG9qYW1xWHRVdDJBa1hsajR6OVJS?=
 =?utf-8?B?NUdGWk54WHduelMybzlFOWxpMzJCM1JLT2ViQlZRTUorR3ExVGVvVWV6Mk9x?=
 =?utf-8?B?T2xsMXVRbkpPbWVMWEVPZjJnMzRxUHd5QU8zTzZNQ2hMZ2VlTnNlTDN2Uy9P?=
 =?utf-8?B?NDdmaUJ3UW9FR29kNGU3UEhwa0JxN3haWithaFNseGhlL0g1WEtFdnMvUDhj?=
 =?utf-8?B?ZkpITENVVXQzRy84eXg3cURXWC9nYlAvOGordFlERk50MWMvNlIzYVJGK0ZU?=
 =?utf-8?B?THN0MkgxMTVIWnluMHZqdzdFTEpLL2NWTnhWVU9BN3JwdmxiRFVhUzZGWkJP?=
 =?utf-8?B?eEZzR2xwVFJNVFdHdlpHcWJNUzNvV1F0cEx0MHJBSGkyWHY2MW13anNlbzJU?=
 =?utf-8?B?ODRlK0tVOUVKU2xFd3RrSHVxMCsyajhJbFdkbXJ6M014dE1zSE9sKy9xdnBF?=
 =?utf-8?B?S3NLWlVBbGY4aTB1UHVnbndQVURGdndld3krQjBPVHlnSUVFZ0l5eDY1YTZK?=
 =?utf-8?B?ektLb25LWjJadTBkTmdydjhOWVVZalMzTndIWTdvNVRUTzZRdUlueS9neWMr?=
 =?utf-8?B?N0NvTXRJZmtGc1RESTAzZGJWbVROaWlsQW4vM1I4SDhvZThPNVpKRVhBQWVR?=
 =?utf-8?B?ZXFvTnJKdHVENWw5ZGlXc2pxWmtFWnNIeXJhVEtyNkdiVHF6RTRFTFpjMXhL?=
 =?utf-8?B?OG41SlJnZlFoMTMvSGN4b3g5blJJZGxJdFZpZlhBaTNJUlY4RjYrb2xzWjNI?=
 =?utf-8?B?OVROS1FVWkpNTzRqR0hVeTM0bEtFY2dSY28wY3lBVGpTcElUcEMvTFZERnBh?=
 =?utf-8?B?V3dLcUVqTVpwQ3pmTitNa3AxaFBycU42eXBqOGRTMXNlOUpLVjVmaG5rZFVt?=
 =?utf-8?B?d1FXQ3F5aXJnMkxiZ2xrSVN6S0x3aGN3bHNqTkdTY1BSYWhlaTVocEpPU3RK?=
 =?utf-8?B?Ujg4TkJNRUxrb2xoeGQxbDEyNitnPT0=?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a92be53d-5763-4017-c6d2-08dc4e50a927
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 11:25:52.1514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3sJHr8TmaV4J8gQJt9o4pgpTcreHe42XRiS1SkGOCP7CNzXLGeAZkWo0a0reHKLVZkGoT3F0aP8gB7rrnFc0tn+M2NjvMe82uLEd7VssGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0982

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBN
YXJjaCA1LCAyMDI0IDEwOjA3IFBNDQo+IFRvOiBZdWtsaW4gU29vIDx5dWtsaW4uc29vQHN0YXJm
aXZldGVjaC5jb20+OyBMaW51cyBXYWxsZWlqDQo+IDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+
OyBCYXJ0b3N6IEdvbGFzemV3c2tpDQo+IDxiYXJ0b3N6LmdvbGFzemV3c2tpQGxpbmFyby5vcmc+
OyBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47DQo+IExleWZvb24gVGFuIDxs
ZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPjsgSmlhbmxvbmcgSHVhbmcNCj4gPGppYW5sb25n
Lmh1YW5nQHN0YXJmaXZldGVjaC5jb20+OyBFbWlsIFJlbm5lciBCZXJ0aGluZyA8a2VybmVsQGVz
bWlsLmRrPjsNCj4gUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3ps
b3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9yIERvb2xl
eSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+IERyZXcgRnVzdGluaSA8ZHJld0BiZWFnbGVib2Fy
ZC5vcmc+DQo+IENjOiBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJpc2N2
QGxpc3RzLmluZnJhZGVhZC5vcmc7IFBhdWwgV2FsbXNsZXkNCj4gPHBhdWwud2FsbXNsZXlAc2lm
aXZlLmNvbT47IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBBbGJlcnQNCj4g
T3UgPGFvdUBlZWNzLmJlcmtlbGV5LmVkdT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMS82
XSBkdC1iaW5kaW5nczogcGluY3RybDogc3RhcmZpdmU6IGFkZCBKSDgxMDAgcGluY3RybA0KPiBi
aW5kaW5ncw0KPiANCj4gT24gMDUvMDMvMjAyNCAxMzowMCwgWXVrbGluIFNvbyB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2Vu
dDogVHVlc2RheSwgRmVicnVhcnkgMjAsIDIwMjQgNDoxMCBQTQ0KPiA+PiBUbzogWXVrbGluIFNv
byA8eXVrbGluLnNvb0BzdGFyZml2ZXRlY2guY29tPjsgTGludXMgV2FsbGVpag0KPiA+PiA8bGlu
dXMud2FsbGVpakBsaW5hcm8ub3JnPjsgQmFydG9zeiBHb2xhc3pld3NraQ0KPiA+PiA8YmFydG9z
ei5nb2xhc3pld3NraUBsaW5hcm8ub3JnPjsgSGFsIEZlbmcNCj4gPj4gPGhhbC5mZW5nQHN0YXJm
aXZldGVjaC5jb20+OyBMZXlmb29uIFRhbg0KPiA+PiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNo
LmNvbT47IEppYW5sb25nIEh1YW5nDQo+ID4+IDxqaWFubG9uZy5odWFuZ0BzdGFyZml2ZXRlY2gu
Y29tPjsgRW1pbCBSZW5uZXIgQmVydGhpbmcNCj4gPj4gPGtlcm5lbEBlc21pbC5kaz47IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+ID4+IDxrcnp5
c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29sZXkNCj4gPj4gPGNvbm9y
K2R0QGtlcm5lbC5vcmc+OyBEcmV3IEZ1c3RpbmkgPGRyZXdAYmVhZ2xlYm9hcmQub3JnPg0KPiA+
PiBDYzogbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1yaXNjdkBsaXN0
cy5pbmZyYWRlYWQub3JnOyBQYXVsDQo+ID4+IFdhbG1zbGV5IDxwYXVsLndhbG1zbGV5QHNpZml2
ZS5jb20+OyBQYWxtZXIgRGFiYmVsdA0KPiA+PiA8cGFsbWVyQGRhYmJlbHQuY29tPjsgQWxiZXJ0
IE91IDxhb3VAZWVjcy5iZXJrZWxleS5lZHU+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IDEvNl0gZHQtYmluZGluZ3M6IHBpbmN0cmw6IHN0YXJmaXZlOiBhZGQNCj4gPj4gSkg4MTAwIHBp
bmN0cmwgYmluZGluZ3MNCj4gPj4NCj4gPj4gT24gMDcvMDIvMjAyNCAwMzo0MiwgWXVrbGluIFNv
byB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+PiArICAgIHR5cGU6IG9iamVjdA0KPiA+Pj4+PiArICAg
IGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+Pj4+PiArICAgIHBhdHRlcm5Qcm9wZXJ0
aWVzOg0KPiA+Pj4+PiArICAgICAgJy1waW5zJCc6DQo+ID4+Pj4+ICsgICAgICAgIHR5cGU6IG9i
amVjdA0KPiA+Pj4+PiArICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+Pj4+PiArICAgICAgICAg
IEEgcGluY3RybCBub2RlIHNob3VsZCBjb250YWluIGF0IGxlYXN0IG9uZSBzdWJub2RlDQo+ID4+
Pj4+ICsgcmVwcmVzZW50aW5nDQo+ID4+IHRoZQ0KPiA+Pj4+PiArICAgICAgICAgIHBpbmN0cmwg
Z3JvdXBzIGF2YWlsYWJsZSBpbiB0aGUgZG9tYWluLiBFYWNoIHN1Ym5vZGUgd2lsbCBsaXN0IHRo
ZQ0KPiA+Pj4+PiArICAgICAgICAgIHBpbnMgaXQgbmVlZHMsIGFuZCBob3cgdGhleSBzaG91bGQg
YmUgY29uZmlndXJlZCwgd2l0aCByZWdhcmQgdG8NCj4gPj4+Pj4gKyAgICAgICAgICBtdXhlciBj
b25maWd1cmF0aW9uLCBiaWFzLCBpbnB1dCBlbmFibGUvZGlzYWJsZSwgaW5wdXQgc2NobWl0dA0K
PiA+Pj4+PiArICAgICAgICAgIHRyaWdnZXIgZW5hYmxlL2Rpc2FibGUsIHNsZXctcmF0ZSBhbmQg
ZHJpdmUgc3RyZW5ndGguDQo+ID4+Pj4+ICsgICAgICAgIGFsbE9mOg0KPiA+Pj4+PiArICAgICAg
ICAgIC0gJHJlZjogL3NjaGVtYXMvcGluY3RybC9waW5jZmctbm9kZS55YW1sDQo+ID4+Pj4+ICsg
ICAgICAgICAgLSAkcmVmOiAvc2NoZW1hcy9waW5jdHJsL3Bpbm11eC1ub2RlLnlhbWwNCj4gPj4+
Pj4gKyAgICAgICAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4+Pj4NCj4gPj4+PiBX
aHkgdGhlIHJlc3Qgb2YgdGhlIHByb3BlcnRpZXMgaXMgbm90IGFwcGxpY2FibGU/DQo+ID4+Pg0K
PiA+Pj4gVGhlIHJlZ2V4IOKAnC1waW5zJOKAnSBtYWtlIHN1cmUgYWxsIGNsaWVudCBzdWJub2Rl
IG5hbWVzIGVuZCB3aXRoDQo+ID4+PiBzdWZmaXgg4oCcLXBpbnPigJ0gKGUuZywgaTJjMC1zY2wt
cGlucywgaTJjLXNkYS1waW5zKQ0KPiA+Pg0KPiA+PiBJIGRpZCBub3QgdGFsayBhYm91dCBzdWJu
b2Rlcy4NCj4gPj4NCj4gPj4gSSBhc2tlZCB3aHkgdGhlIHJlc3Qgb2YgcGluY2ZnIGFuZCBwaW5t
dXggc2NoZW1hIHByb3BlcnRpZXMgYXJlIG5vdA0KPiBhbGxvd2VkLg0KPiA+DQo+ID4gSW5pdGlh
bGx5LCBJIHdhbnRlZCB0byBhbGxvdyBhbGwgcHJvcGVydGllcyBpbiB0aGUgcGluY2ZnIGFuZCBw
aW5tdXggc2NoZW1hLiBJDQo+IG1pc3VuZGVyc3Rvb2QgdGhlIG1lYW5pbmcgb2Yg4oCcYWRkaXRp
b25hbFByb3BlcnRpZXM6IGZhbHNl4oCdDQo+ID4gYW5kIEkgdGhvdWdodCBpdCBtZWFucyBhbGwg
YWRkaXRpb25hbCBwcm9wZXJ0aWVzIG91dHNpZGUgdGhlIHBpbmNmZw0KPiA+IGFuZCBwaW5tdXgg
c2NoZW1hIGFyZSBleGNsdWRlZC4gVGhlIOKAnGFkZGl0aW9uYWxQcm9wZXJ0aWVz4oCdIHdpbGwg
YmUgc2V0DQo+ID4gdG8g4oCcdHJ1ZeKAnSB0byBpbmNsdWRlIHRoZSByZXN0IG9mIHRoZSBwcm9w
ZXJ0aWVzIGluIHBpbmNmZyBhbmQgcGlubXV4DQo+ID4gc2NoZW1hIGFuZCBub3QgdG8gYmUgcmVz
dHJpY3RlZCB0byBvbmx5IHRoZSBwcm9wZXJ0aWVzIGRlZmluZWQgaW4NCj4gDQo+IEluIHRoYXQg
Y2FzZSBkcm9wIGFsbCB0aGUgcHJvcGVydGllcyBhbmQgdXNlIHVuZXZhbHVhdGVkUHJvcGVydGll
czogZmFsc2UuDQoNCklzbuKAmXQgdGhhdCBzdWZmaWNpZW50IGp1c3QgdG8gdXNlIOKAnHVuZXZh
bHVhdGVkUHJvcGVydGllczogZmFsc2XigJ0gPw0KDQpUbyBkcm9wIGFsbCB0aGUgcHJvcGVydGll
cywgd2Ugd2lsbCBiZSBsb3NpbmcgaW5mb3JtYXRpb24gYmVsb3c6DQoNCiAgICAgICAgICBkcml2
ZS1zdHJlbmd0aC1taWNyb2FtcDoNCiAgICAgICAgICAgIGVudW06IFsgMjAwMCwgNDAwMCwgODAw
MCwgMTIwMDAgXQ0KDQogICAgICAgICAgc2xldy1yYXRlOg0KICAgICAgICAgICAgZW51bTogWyAw
LCAxIF0NCiAgICAgICAgICAgIGRlZmF1bHQ6IDANCiAgICAgICAgICAgIGRlc2NyaXB0aW9uOiB8
DQogICAgICAgICAgICAgICAgMDogc2xvdyAoaGFsZiBmcmVxdWVuY3kpDQogICAgICAgICAgICAg
ICAgMTogZmFzdA0KDQo+IA0KPiBGaXggeW91ciBlbWFpbCBzZXR1cCwgdG8gd3JhcCBlbWFpbHMg
cHJvcGVybHkuIFRoaXMgaXMgdW5yZWFkYWJsZS4NCj4gDQo+ID4NCj4gPj4NCj4gPj4gQmVzdCBy
ZWdhcmRzLA0KPiA+PiBLcnp5c3p0b2YNCj4gPg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCg0K

