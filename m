Return-Path: <linux-kernel+bounces-24601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B982BED4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D111F259F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564B35FF04;
	Fri, 12 Jan 2024 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="vHGT53lb"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2103.outbound.protection.outlook.com [40.107.20.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43DC537F1;
	Fri, 12 Jan 2024 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5evMHfI/ZRVPbimyUd536FqVP7bNH63+h5ii4API4aqXW5lfoVXr70vbE/R382LAMthOAd6N3mK6REViKEEDgDchkoC3f6/fkSUtXMwoJZ51BVKqEb02Cr6Tp7oLRy/nc+RvpqY57+I5RZm0bxJymaet1fIEA5Xof2sbPGZRquCvQKVoTpdEfif48WaDdqkA3ECj3zRFNhGTpx09L0vUBJD3tHf1jCuM65L/6ruZNpFbEFSdC6jBlID6UixKrHX3RZDn9htyyTlXr7tJmZoqzkspWDpTAl6qqb5WUiUNw1jwzWh3XH4WV/1EcoXw6+pcSVkq7tqeKcOdbyvylyMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+bv0CdOHS9sGPmFhWyB7Q5tUfruL2Pl6O47VEFZop0=;
 b=ffrnDtKCFI4rsrJNeRtN4Ri3rA1SozscuC+24kw7jmYcMQLb7coBYRwBSF/9W6Az9Iud9PhLgBCIY6Or89BzRI0a9q6B5dklVu9Rq7ZLeDnQYHHkHo7LJWCY7yaKb2nVSrngNssqmxH56RQ6YPzw0gfzr1AQhz9nkBWVl5bN57lByOhbAAJSXTUdp29fLhRLGSxgboxmmJerqhvhYuO7m+RualM8BHAjGUtF8mX4sZNrYcR4UkW96IDdPs/mVOK5Qnku97obJa+i6XVr0pEjjH+fw0KXEkcHC4gmcLZFyeXNkb4L2ZcZHXl/SUgnsiEBsYP9JkhHeWWdWvYkZwnCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+bv0CdOHS9sGPmFhWyB7Q5tUfruL2Pl6O47VEFZop0=;
 b=vHGT53lbI+PfTRw3PDWj3fLa2RaaQ2updL2nsOd5NSBBLWngKhl71E6EG/NWShbFaWe2ft/DObyisniHK0J5mWO/HSe2tXM0c04DU40KOexH9EM6F8HtOsJZQs+/yvHG6k3hZpmR55oMenUA1Jc/qOqKoJrJtVyXkxeipdCGyFM=
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com (2603:10a6:10:103::23)
 by DBAPR06MB7109.eurprd06.prod.outlook.com (2603:10a6:10:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 11:02:29 +0000
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039]) by DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039%5]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 11:02:29 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Thread-Topic: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Thread-Index: AQHaRKoS6UQg1dt3TU+QGYO25gfEa7DU258AgAEot4A=
Date: Fri, 12 Jan 2024 11:02:29 +0000
Message-ID: <d04ed7c7-32ee-4f8f-be20-6e3f89a2062f@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <b6bc84f9-2ff6-40b6-8c1f-90a12f8d9149@linaro.org>
In-Reply-To: <b6bc84f9-2ff6-40b6-8c1f-90a12f8d9149@linaro.org>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR06MB6332:EE_|DBAPR06MB7109:EE_
x-ms-office365-filtering-correlation-id: 842900b1-bdbf-4b95-ab4a-08dc135df853
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Glruu4SmAbebD42xpHMNJ2XrIneHXr8JGQZVFnu213C8iZeCHXqQ4nRo5t3AP8vjruhu2wo+oWSA8u8a26WPG2+HWNOkQc1e7OOjydz0UIZoGOVIz5Hho6ojJy0wIRasrw9+Gx+PAK2CwRqdB9+uZHEVVceEOYgDGM7gOxONLwuqCbzIHUlyeHuxCwPHO5UMVPhu5PHYqQPmpDxOaUfhjhwUS73oiyIxicurFJyQnl7XUFUkbvSCGUqATrnfhGmm/mzSrC+5mA1UrsmMkWNwXbg0rKCihb35qwhpNF/TV7rI4oGriUq5oC1NVpG7RCW3B05+e9GTwoTNAoJKLDghzS8qplZJtRxMmPpkQsVG7+vfRCzth6GTdpGADRAhK03x1T7LmE/AXqrynTxnW6FbD2mtb6IMiIjBIap4CGUDQFvF951JBdsJdUgcuaMpZSdPvYeXybmz4sAcS383N8pOQWLAR0NwfHLzQ6I993t30FpQbx0cWhhZmSHcZkpdmFZTOygHOY5OgTrhpEau1NWqGLRQxL8o01ybv6HAZ7zV5ne8clXdMJ2FRP7owIFrlUqudMq/euYen2C0XXCwFhn0pcBsJtJzAiTbWC9Ay1qPJgFgYVUKGw/hN7ul8fNhb1KNUOMcxhuRfpnJF6jGga0LCvltdcTZx3/Oxa+bcfL/+RfTnEHmmt+4b654ziXkG/It9W7AA1/3c76AVBvPl/ll7Xx9SeUdB5V0p0AlWnDt5eRGEUmQg2IO7xMWzB+skxxb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6332.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230473577357003)(230273577357003)(230922051799003)(230373577357003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(64756008)(66556008)(76116006)(66446008)(66946007)(36756003)(66476007)(110136005)(8676002)(54906003)(8936002)(316002)(6512007)(6486002)(38100700002)(4326008)(45080400002)(122000001)(38070700009)(91956017)(2906002)(31686004)(5660300002)(7416002)(921011)(41300700001)(86362001)(478600001)(966005)(71200400001)(26005)(31696002)(2616005)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFhMWElhcXZqTkIyMVVBZUNvZUt2Q0ZZdm82YktYZkt2QWVMUnpBOUtJZm1F?=
 =?utf-8?B?c3pjKzF2YWNjeXloay8wTk4yTThQYnpmbnF0cFN0L2hvb0c4Z0RZRFFVSWtT?=
 =?utf-8?B?ODR4ZlN6STd6ZUt4MU1ncC9aeGViRmJmZWZtRk5aSW9tWXQ2T2QxcWZ0OE90?=
 =?utf-8?B?R00zK0I3Z09MclNhUG9zNE4yS3lwemh5N3VxTzlvVHNNdGFtQkV2TFg4c3Vo?=
 =?utf-8?B?NFpSUUxZT0owZEVqOVlvN1JTa0hIenpjUUVSZ3J0Vjd0WnkyMlVXYXY3TTVy?=
 =?utf-8?B?Q0dBUklkR3JJaXcrY2VTUS9PZjBYa0FKZDh2NTREVUJEUnZWWlRNZEcvL0Ju?=
 =?utf-8?B?bVNTa2ZqcGNvclpSM2E3MnlZcVNKMnB0SWFyc0I2N0hrdk9qMnVsSWQyS200?=
 =?utf-8?B?TVFNVDkwd21IRy9zeTFuaFNmK3U4TENKZmJ5K1RGb25UczdXV2xUNzFGRnJr?=
 =?utf-8?B?ZXdxOUJKTStncUlHR2Q4bEtRUzliOHVGWDduNHZrdFhZdUkvQURpUDVCSVQx?=
 =?utf-8?B?UjR6d3I2a3h6dTlFREpkNHZJckhFR2FWM2loeW1udE5kMkRaRnVIS2ZvTW1x?=
 =?utf-8?B?MUkvaHFvT0xpUlp3SXpRTTExa1VCWHZvQ0szOVZLV0kydHV4Z0tvTS9tdmdL?=
 =?utf-8?B?TXBvNmZGOUJaVDdOUXNLVVBHdUdHS0x0RmN3N21QT1JCTHIxblRLeVpzWjlt?=
 =?utf-8?B?L3pEaUpqbTVnOUlSNFlSWENWbHZRd2xpNlhYVUQySWM4bnNYUlUrb1c3eE5t?=
 =?utf-8?B?cExERnF6Z2hzNUwzbFQxUmVtM0NsWU9QR2xOcTA1bVRmdzM2MTJXeWZiMU5V?=
 =?utf-8?B?aTNpcE9YZmdIZTRvcGc2RFZleTZtZWNPRGwxdXdyOCsvYWdVRE1LVEJrS25q?=
 =?utf-8?B?OFhrV3V5bDA2RzJsOVJYZXFMcUVLK1d4U0NEYitKR1ZJWXg0ZHdId05yWklC?=
 =?utf-8?B?clBGdGpUcW5UZXc1R2djUkNqWnRKaTRNWVo3dlZ6SXFIRVo3c0owWCtpL2N1?=
 =?utf-8?B?NUplaDJZWktQUzV6RE1rdVdmN3grbHFkVmhXQ0ZycXFRNEZPUHhCYTl0QU8r?=
 =?utf-8?B?TGd0SXB1a2FzQ3VzSTNRUXRsd2xxaHA4MEs3aUJVN2RCbTdOL1ZRdzhheHdY?=
 =?utf-8?B?N3FmbTFpN21QYnZrZG95T1J2NkY3cGJWRk0yUnc4Z3FtVjVwZlFUR25hajBm?=
 =?utf-8?B?VE5SSTM1N0pPcDdmeW9BNXFuR1BZbEJQS2N6Nzhyd3FaL3NQcWJVaUlucGZ6?=
 =?utf-8?B?SHV6WUkvWG5sdHlZUWY2dVluMTA2bThEY096ZFJ5d25teXptRnVROVJvZHR5?=
 =?utf-8?B?d1E5dSs2K2YxMkQ1c2tLT2IvZlY0WVdmNHlpeVFPdlBQbHBkZXBWOGlrN3dY?=
 =?utf-8?B?WnlhZGNRc0ZaeUtoQzJla25zU3NtZGcvZlB0QmVOd3cyVnJXa3dvanU2YmJw?=
 =?utf-8?B?UVhjTVBNOVAwZGJDbUlLSFpML2tEVU5nR3Rza2poTktjT0kyanhEL0J2UWhj?=
 =?utf-8?B?R0c0d3lTblk0VE5vK1NXMXQ0ckNlQU4zelpxREsvQWpUZFg2Y3dsMjYrRVFC?=
 =?utf-8?B?aWk0eGpLQUFZbEtoY3c4SU9CWW1zR09ud1dKNVRuSTRIdCtxMEw5YmNVSTQv?=
 =?utf-8?B?ekdlZEtISW5VQ0ZLUjB1WlNOck9sOGpWWmliK1E2Wjh6bjV3U3owWG5YOVpC?=
 =?utf-8?B?NnhHd3dJQnVVNTIxSDBCM3phT3pDdFROL3V3d3hjYllDSG1IOHFqNUs0dWd4?=
 =?utf-8?B?MTFueU9jaVAzb1hyMlRQaGxmZTJMR0RXSHhNWUVkeXRGbGVFRjdDajRHbm1E?=
 =?utf-8?B?WlhDMEhDeGRTUnlyZTNYV1NsMEM5Z2V3NHhaZzgxVTRHY0xuS21pSS96aGZl?=
 =?utf-8?B?eVdzcHhzczl0ME5nVkFYemgvQ0FvQnh4UHBrTVo2ZDRrSWxuNWw1Y2daUzhD?=
 =?utf-8?B?dFBFS3dUeVZHU0Q0SXhTa0s2eGswVXUxV0dWMkhCZmdQdHY0UEhab3J2WWJx?=
 =?utf-8?B?djZqWkV4NnV2SlV0ckw4STNzOUFrRU9ITm9RaC9IcDJGZXhYZGdyMXBVSWNk?=
 =?utf-8?B?RXhrMjdheFdOTi8raHBmY01oaldGdGJPZDl1VGZ0TWJCVDZVV2czVGhoWkhO?=
 =?utf-8?B?Zlc0T04raGkrSE5Jc2pHTnBmVnhXT3VYK2s1alg3b2cveXdMcXl2Ni9mZG1X?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07DE16BA8852EE449C459BCD97C35E6B@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6332.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842900b1-bdbf-4b95-ab4a-08dc135df853
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 11:02:29.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SjsT85uUImUN0OLaXPa7C4T+HaJpQpV7opeE9irPsB6JQ08PS/quy2bj73LCsECmFKZoeqKdt/46xLj+wIa7rkbx5krUh1fo+L1AI3ZpuIV0NC5SF0pTMHuoNf1sFxE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB7109

T24gMTEuMDEuMjQgMTg6MjAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IFtZb3UgZG9u
J3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20ga3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnLiBM
ZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNl
bmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u
4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2lu
ZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4N
Cj4NCj4NCj4gT24gMTEvMDEvMjAyNCAxNzoxOSwgQ2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPj4g
QWRkIHByb3BlcnR5IHRpLGNmZy1kYWMtbWludXMgdG8gYWxsb3cgZm9yIHZvbHRhZ2UgdHVuaW5n
DQo+PiBvZiBsb2dpY2FsIGxldmVsIC0xIG9mIHRoZSBNTFQtMyBlbmNvZGVkIGRhdGEuDQo+IEEg
bml0LCBzdWJqZWN0OiBkcm9wIHNlY29uZC9sYXN0LCByZWR1bmRhbnQgImJpbmRpbmciLiBUaGUg
ImR0LWJpbmRpbmdzIg0KPiBwcmVmaXggaXMgYWxyZWFkeSBzdGF0aW5nIHRoYXQgdGhlc2UgYXJl
IGJpbmRpbmdzLg0KPiBTZWUgYWxzbzoNCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGlu
dXgvdjYuNy1yYzgvc291cmNlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zdWJt
aXR0aW5nLXBhdGNoZXMucnN0I0wxOA0KPj4gU2lnbmVkLW9mZi1ieTogQ2F0YWxpbiBQb3Blc2N1
IDxjYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vvc3lzdGVtcy5jb20+DQo+PiAtLS0NCj4+ICAgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwgfCA5ICsr
KysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IERvbid0IGFk
ZCBwcm9wZXJ0aWVzIG9uZSBieSBvbmUuIEVzcGVjaWFsbHkgaWYgdGhleSBhcmUgcmVsYXRlZC4N
Ck9LDQo+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC90aSxkcDgzODIyLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L3RpLGRwODM4MjIueWFtbA0KPj4gaW5kZXggZGI3NDQ3NDIwN2VkLi4yZjAxMDMzM2JlNDkg
MTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3Rp
LGRwODM4MjIueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC90aSxkcDgzODIyLnlhbWwNCj4+IEBAIC02Miw2ICs2MiwxNSBAQCBwcm9wZXJ0aWVzOg0K
Pj4gICAgICAgICAgZm9yIHRoZSBQSFkuICBUaGUgaW50ZXJuYWwgZGVsYXkgZm9yIHRoZSBQSFkg
aXMgZml4ZWQgdG8gMy41bnMgcmVsYXRpdmUNCj4+ICAgICAgICAgIHRvIHRyYW5zbWl0IGRhdGEu
DQo+Pg0KPj4gKyAgdGksY2ZnLWRhYy1taW51czoNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+
ICsgICAgICAgRFA4MzgyNiBQSFkgb25seS4NCj4+ICsgICAgICAgU2V0cyB0aGUgdm9sdGFnZSBy
YXRpbyBvZiB0aGUgbG9naWNhbCBsZXZlbCAtMSBmb3IgdGhlIE1MVC0zIGVuY29kZWQgZGF0YS4N
Cj4gcmF0aW8gYmV0d2VlbiB3aGF0IGFuZCB3aGF0Pw0KSXQncyB0aGUgcmF0aW9uIGIvdyB0aGUg
YWN0dWFsIG91dHB1dCB2b2x0YWdlIG9mIEFPSSBhbmQgdGhlIHNwZWMNCnJlZmVyZW5jZSAodGhl
IGRhdGFzaGVldCBpcyBub3QgdmVyeSBjbGVhcikuDQo+DQo+PiArICAgICAgIDAgPSA1MCUsIDEg
PSA1Ni4yNSUsIDIgPSA2Mi41MCUsIDMgPSA2OC43NSUsIDQgPSA3NSUsIDUgPSA4MS4yNSUsIDYg
PSA4Ny41MCUsDQo+PiArICAgICAgIDcgPSA5My43NSUsIDggPSAxMDAlLCA5ID0gMTA2LjI1JSwg
MTAgPSAxMTIuNTAlLCAxMSA9IDExOC43NSUsIDEyID0gMTI1JSwNCj4+ICsgICAgICAgMTMgPSAx
MzEuMjUlLCAxNCA9IDEzNy41MCUsIDE1ID0gMTQzLjc1JSwgMTYgPSAxNTAlLg0KPj4gKyAgICBl
bnVtOiBbMCwgMSwgMiwgMywgNCwgNSwgNiwgNywgOCwgOSwgMTAsIDExLCAxMiwgMTMsIDE0LCAx
NSwgMTZdDQo+IE1pc3Npbmc6ICJkZWZhdWx0OiINCj4NCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBL
cnp5c3p0b2YNCj4NCg0K

