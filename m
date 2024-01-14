Return-Path: <linux-kernel+bounces-25476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9A82D0DB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84431C20B12
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D5623D6;
	Sun, 14 Jan 2024 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="U7647qrE"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074423B9;
	Sun, 14 Jan 2024 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9OTXhmlUSD48TbjcwLUi2IsKrA56n2HpZM7k51BlrDtNtItP7WaP2JKT14EexJpUP/V9Ysxssjgdi93czfEwZPDlT7Tm8JqlE+Za3r9CO46eJ6bqm++JxOP4/hEcjWA9iapxxyKPgmMqtJMUge5MD+Ts7ZkPqwGpQOez4HEgn4q8BiPoO8hc0ZnbunDBGyjSYoq0q7Jny+3W3yLBuu7lwGqePjPrw7yueFSuvRGH5RgLodwnUwGfLMJb7W1rJvKBirHrdl48965XlbRPNz6aPNERu2pU1S5qJWa+FGnj2rdv14XxSAPOJ5ldxdQn451lHcS+zkqLmKK7BhNdU5JfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLb6xBIzhHzYR2ENPgX4YkujFZAkxncSaSztqqZ47go=;
 b=nfq8kIjKH+5+O/WDZSR1Ywvvwv4+iY4aq+4uKZCa4zhmSbMBTnuN4RH+kvKC2gRsQbVCG/kEyFDUYv8JFR+5Fz9RhTkM0tMFo0S6+8lpHvf8yMYAK8/wMh1haoDFpuy/rRHs4ADBEzVBsTq/j6OFNM+DHNtzxw9xH/k8yspNj4jk/wwjOV9iDeWbPRb2We7gY4sJKi4jGwGoMhnzShfDgSwLh0SlvjWYcJOeYC4rv6MFvqESPB4vvcBVlafS0kKzaHdLmVo8HqqNeBc1HtpKA6ZhPogCIC/RohVJXBArsBUXSeDXfPlt15bTQuqmlST4t3QmAoU3lANO47Q4OtX/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLb6xBIzhHzYR2ENPgX4YkujFZAkxncSaSztqqZ47go=;
 b=U7647qrEjYCvMmWtzdNbj219Jd2eCJ/1sKFUoCr19xJ5IFthQ9lFZThXfNys+edwntwHwqdZnDKzBejoog3soDmGkI3jrZ3gkl0GBeERgnAkSw4Tg+QCVjJwVr+Ro/vmBR39uu0gQztnqt/49JE2kfQ3JdTOpL4xfOiJb9i6ACo=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PAXPR04MB8990.eurprd04.prod.outlook.com (2603:10a6:102:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sun, 14 Jan
 2024 14:16:27 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Sun, 14 Jan 2024
 14:16:27 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] arm64: dts: add description for solidrun am642 som
 and evaluation board
Thread-Topic: [PATCH v2 4/5] arm64: dts: add description for solidrun am642
 som and evaluation board
Thread-Index: AQHaRXqNRxBDBTIBFEOB99P14tzvurDWbMUAgALwy4A=
Date: Sun, 14 Jan 2024 14:16:27 +0000
Message-ID: <1656bf68-c3b4-476d-984e-f231541058f6@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-4-1385246c428c@solid-run.com>
 <60d78882-0ec5-4cd1-b68d-f75b73cb6cdb@linaro.org>
In-Reply-To: <60d78882-0ec5-4cd1-b68d-f75b73cb6cdb@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|PAXPR04MB8990:EE_
x-ms-office365-filtering-correlation-id: 5adc96d5-23a6-40b4-74b7-08dc150b65ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EQOnNwilIhzSOXYTlqOXwsfgCqZU7yl5dCCF0Io//90cGJUWIUOP+bPt2foDkomPEYGjJLKSNDWaDMISrvGCaxVuhwsnSIXWh8nOzuto789OcUSaR3ixEwz88cn6GxPyqsJjVg/J1c+M3aWY6WlqF9vdCFO/7i4Fz88BRsyAT4Z+oD0xMign49NxwzwlAK6GfcIZBArMXTRhxAHaJ4UuMwhoLCM1gVMu/xcclvgU7+iArL3Y0NqGApKYT2564qmtQai7pxDMstO3vR8EiOuC5/hRdaLu3rrLB5lpY9cMe3gc6oky6tJJHFLPl7yFihuc/H5gqjpotHYuOkZBGAOdZ7K9v91ImY8a3OZfY+mP7YKD5yuMnZAE2XEV+GLB29cClZkaauBVnvaPAAjHrMXYvLElf+y4xKKyV36tfKvS2EetsZLI42lCfQalBXdtYEbYs9bqOncnuvGJc0ZNbGCvsNSVNXgRDKy4WhHtiAHvyTJVKdGrESk0AwmzTx7tLPztcXSBmWq6lGwz6RDK+5P4pt3Lq0m5I/01r4JNY1D6mByJf9xm+HIn6vUvcHxenLD/5Pf0eAnhhiSaAljT/3u9sOxTWdwaAsHUUEfuYXobRLLkoMWSHhYU5Te6ZwGmYiJd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(122000001)(38070700009)(36756003)(38100700002)(86362001)(31696002)(31686004)(83380400001)(26005)(2616005)(71200400001)(478600001)(6486002)(76116006)(66446008)(64756008)(66476007)(110136005)(66946007)(8676002)(8936002)(316002)(66556008)(6512007)(6506007)(966005)(91956017)(5660300002)(2906002)(7416002)(54906003)(41300700001)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGw4Q3lFeUljVGVlV2x4ZmZnZlVnZ2M3NTk1N3ppc05WSnBFckVsdVpoVnRT?=
 =?utf-8?B?VUx2bzIvcFltZHVuOE0zQ3N6OERhZXFHM1RWWEVkcmFQbXNQK2ZhaEdJYnBw?=
 =?utf-8?B?VnRZbkFkYjQ3K0RQdmxSN3p1SkNsYXJRSVN0SEZnZDRHQ2pBVU9xM2JaZ09R?=
 =?utf-8?B?MG9JSkpwTkZJZTJCU2VpL3RwU3Y2NEkwWHk3ZkdnVXFhSCtkVXlJS1ZBTzFB?=
 =?utf-8?B?STN3V2RpcTRuc2dGMmxOUDZtelc5S1N6V3cvYjJ5TGZiWjVpSUtpMWFORFdH?=
 =?utf-8?B?cytYMFdpL055dUtGcURSa09GR3ZqanlUZW5jbVpMUktUa2xvRjI5TkZwS1VM?=
 =?utf-8?B?Qk0xemd5QnRidml0bjhFQXFFUmpIVG9aYjRPS2lOR3A5Rk5PQWFJODJNT0R0?=
 =?utf-8?B?TkdzZDJ2SEhNT3NzQ0cwaTA5YkwvamNrVEJ3cC9IUk5zc2VERm5aN1IrMC8x?=
 =?utf-8?B?cmRDUmFsQks5aWR3R2xxd1lVNys2cHg4c1lCQU56aTg4OW8rN0c1M01sL3dv?=
 =?utf-8?B?dmdNbjBPYmxLN205RVZrVmRJZ1lBVFM1NjhNY3pUMHVMSHJRcExXb01MMHhs?=
 =?utf-8?B?RlE1aWxuakoweitHbFJZa25KbGxVV3pRUmhFZkdUVDM2bjJLQXl2RjdjbDVs?=
 =?utf-8?B?bGh4YXhCZjdqNFNMV2g1ODc5dGhTOFNYdnJHOHhrVjJIVEJiQUxEYjhqNHhP?=
 =?utf-8?B?RmdPbzExZWFxeHMrZlNjQmRJQVpOV3JWUkcxWWpTZElhUUwzbXNoc2NaNGdP?=
 =?utf-8?B?L3dBMGlhQkpTV25Za1llbVc0am5RRkJmeDBITmYrN0JUMkh6eDJMK0pmS0Jz?=
 =?utf-8?B?SW9qT0grNWtRUzNwQ1A3c0w5cis4OVE3b1orQ2t4VWFaVFh4UENtT0pQdVNs?=
 =?utf-8?B?VDNUTzc0N1FYbGVhQi9OYm1Dc1EwQTRaUnFSYm10Y1hhZXBPb21GMk9EZlZr?=
 =?utf-8?B?NjF1MVN6WFNpaTdWWCtCVzVmUmludnlXRFdtZW1kWk1peFJ6WkhBU2VuVVdX?=
 =?utf-8?B?UWhYT2RHWC84bEpPWXdwWXo4dVNseldxbEZPdEV5UFVZUlI3TzNaYzBrcGxo?=
 =?utf-8?B?emJkR2VqNVlQem9UdFBsSU1aZDU5bkN5YWZrdFI2V2xFd1hDdzYvKzhUOG54?=
 =?utf-8?B?MW1HSi9tZko2SEx3WWRMaHlXSTl2Q0dMUHZBL3N0T2xvcytqZGVjbWJDSmxJ?=
 =?utf-8?B?VnlxSXhqS1NhTWk0MDZHL1NIY0VhcnhXN3RxQkl5NlFlaHVNanFBSkRnRWs5?=
 =?utf-8?B?WmkxQWhzKytrZWZVSUhMQ1BkSTVNN1RMSjBsWExmZ3RieTNHRzJnZi92UXVq?=
 =?utf-8?B?cjh2QXkrV0VrckZZalR2L3hHdC9IeXJ2RmNCTUhrbUNwQmtyRTR3NnlwNndq?=
 =?utf-8?B?Q05yUFkxcG5GYi9CUnpxVlRySndGcUZZdkdLRWJuT3B2NmRKSkdZT05pclFZ?=
 =?utf-8?B?KzVLN09NMzJqbzFEVFlXWWlpdFNJQlIwKzl5NU1xSVNUVHliYlpoTnVmVkxq?=
 =?utf-8?B?Sit6SUJ5ZGZCV1BZYklHUEZsWWdpMzZNODd0aFN1RElBY1FZZ0czSUpOeXFY?=
 =?utf-8?B?KzdZYkR0c0ZodU5WZ0tKd2sxQ2hRWW1qM09oNGprUm9CMXo5QUVXSnlzUDlM?=
 =?utf-8?B?c2JHYURUdlkvQ2NQbjdLdTNKUlcvcWRNQ1EraG5VVnhmSEFCbnJ0b2Jxc3B3?=
 =?utf-8?B?N0d1WUR6YVJFbHlvY28va0ptbXhyRUd0eVZnR2tYUnVtZzFjTllLbUZnbkxh?=
 =?utf-8?B?a3dzb2hxWWpCNVZjdVIxNDltMGQ5TzY3cU1nQ09EMkhKbGRpbTIrQUJVbzdu?=
 =?utf-8?B?T1dSLzZSa0dRMzlqcVkvN2w0d1A0Rjd0V1RmQkJQTEdNa2VtTGdQQlVLaWJP?=
 =?utf-8?B?REZyM2FyTzF3VUpKOEd2M1Vibk1yWG9hV203OHpjSDVNS3dKZzN0SUxmWnVt?=
 =?utf-8?B?cTlRYVlXeEIreDllQnFHLzVJVnJGZ3FkbDFOd29DWWs1VEwzb3V6NXdwdEJh?=
 =?utf-8?B?T0RLaFhtM1V0djJCWWM0TExWVzZ0YnpWRDZjR1NyV1dkWHlTcXFpVDRVRzgr?=
 =?utf-8?B?Z0xybUNqTkpGRG5JenhTQlkzd2RIdUZzVEtuNEVEWWRwODE4R2VoeGttYXlX?=
 =?utf-8?Q?qlUudvsl1OfaLArGetzdH5oj5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ABBA9807A09AE4DB8B9E7311CBCCA8D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adc96d5-23a6-40b4-74b7-08dc150b65ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2024 14:16:27.4331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qU0fdlqiYChaA89qNHjLQjy2iGxX9xSb0kO1bvYff9e6LPsY7wqHS9I7iphlLDhRoeDspbGWQCaQIdUw02gtzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8990

QW0gMTIuMDEuMjQgdW0gMTg6MjIgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KDQo+PiAr
CS8qIFBSVSBFdGhlcm5ldCBDb250cm9sbGVyICovDQo+PiArCWljc3NnMV9ldGg6IGljc3NnMS1l
dGggew0KPiBOb2RlIG5hbWVzIHNob3VsZCBiZSBnZW5lcmljLg0KVGhpcyBuYW1lIGludGVudGlv
bmFsbHkgaW5jbHVkZXMgdGhlIG5hbWUgb2YgdGhlIGlwIGJsb2NrIHdpdGhpbiBhbTY0IHNvYyBw
cm92aWRpbmcgc29mdHdhcmUtZGVmaW5lZCBldGhlcm5ldCBjb250cm9sbGVyIHRocm91Z2ggY29w
cm9jZXNzb3JzIFRJIGNhbGwgInBydSIuDQo+IFNlZSBhbHNvIGFuIGV4cGxhbmF0aW9uIGFuZCBs
aXN0IG9mDQo+IGV4YW1wbGVzIChub3QgZXhoYXVzdGl2ZSkgaW4gRFQgc3BlY2lmaWNhdGlvbjoN
Cj4gaHR0cHM6Ly9kZXZpY2V0cmVlLXNwZWNpZmljYXRpb24ucmVhZHRoZWRvY3MuaW8vZW4vbGF0
ZXN0L2NoYXB0ZXIyLWRldmljZXRyZWUtYmFzaWNzLmh0bWwjZ2VuZXJpYy1uYW1lcy1yZWNvbW1l
bmRhdGlvbg0KPg0KPg0KPj4gKwkJY29tcGF0aWJsZSA9ICJ0aSxhbTY0Mi1pY3NzZy1wcnVldGgi
Ow0KPj4gKwkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+ICsJCXBpbmN0cmwtMCA9IDwm
cHJ1X3JnbWlpMV9waW5zX2RlZmF1bHQ+LCA8JnBydV9yZ21paTJfcGluc19kZWZhdWx0PjsNCj4+
ICsNCj4+ICsJCXNyYW0gPSA8Jm9jX3NyYW0+Ow0KPj4gKwkJdGkscHJ1cyA9IDwmcHJ1MV8wPiwg
PCZydHUxXzA+LCA8JnR4X3BydTFfMD4sIDwmcHJ1MV8xPiwgPCZydHUxXzE+LCA8JnR4X3BydTFf
MT47DQo+PiArCQlmaXJtd2FyZS1uYW1lID0gInRpLXBydXNzL2FtNjV4LXNyMi1wcnUwLXBydWV0
aC1mdy5lbGYiLA0KPj4gKwkJCQkidGktcHJ1c3MvYW02NXgtc3IyLXJ0dTAtcHJ1ZXRoLWZ3LmVs
ZiIsDQo+PiArCQkJCSJ0aS1wcnVzcy9hbTY1eC1zcjItdHhwcnUwLXBydWV0aC1mdy5lbGYiLA0K
Pj4gKwkJCQkidGktcHJ1c3MvYW02NXgtc3IyLXBydTEtcHJ1ZXRoLWZ3LmVsZiIsDQo+PiArCQkJ
CSJ0aS1wcnVzcy9hbTY1eC1zcjItcnR1MS1wcnVldGgtZncuZWxmIiwNCj4+ICsJCQkJInRpLXBy
dXNzL2FtNjV4LXNyMi10eHBydTEtcHJ1ZXRoLWZ3LmVsZiI7DQo+PiArDQo+PiArCQl0aSxwcnVz
cy1ncC1tdXgtc2VsID0gPDI+LAkvKiBNSUkgbW9kZSAqLw0KPj4gKwkJCQkgICAgICA8Mj4sDQo+
PiArCQkJCSAgICAgIDwyPiwNCj4+ICsJCQkJICAgICAgPDI+LAkvKiBNSUkgbW9kZSAqLw0KPj4g
KwkJCQkgICAgICA8Mj4sDQo+PiArCQkJCSAgICAgIDwyPjsNCj4+ICsNCj4+ICsJCXRpLG1paS1n
LXJ0ID0gPCZpY3NzZzFfbWlpX2dfcnQ+Ow0KPj4gKwkJdGksbWlpLXJ0ID0gPCZpY3NzZzFfbWlp
X3J0PjsNCj4+ICsJCXRpLGllcCA9IDwmaWNzc2cxX2llcDA+LCA8Jmljc3NnMV9pZXAxPjsNCj4+
ICsNCj4+ICsJCWludGVycnVwdC1wYXJlbnQgPSA8Jmljc3NnMV9pbnRjPjsNCj4+ICsJCWludGVy
cnVwdHMgPSA8MjQgMCAyPiwgPDI1IDEgMz47DQo+IE5vbmUgb2YgdGhlc2UgYXJlIHR5cGljYWwg
aW50ZXJydXB0IGNvbnN0YW50cy9mbGFncz8NCj4NCj4+ICsJCWludGVycnVwdC1uYW1lcyA9ICJ0
eF90czAiLCAidHhfdHMxIjsNCj4+ICsNCj4+ICsJCWRtYXMgPSA8Jm1haW5fcGt0ZG1hIDB4YzIw
MCAxNT4sIC8qIGVncmVzcyBzbGljZSAwICovDQo+PiArCQkgICAgICAgPCZtYWluX3BrdGRtYSAw
eGMyMDEgMTU+LCAvKiBlZ3Jlc3Mgc2xpY2UgMCAqLw0KPj4gKwkJICAgICAgIDwmbWFpbl9wa3Rk
bWEgMHhjMjAyIDE1PiwgLyogZWdyZXNzIHNsaWNlIDAgKi8NCj4+ICsJCSAgICAgICA8Jm1haW5f
cGt0ZG1hIDB4YzIwMyAxNT4sIC8qIGVncmVzcyBzbGljZSAwICovDQo+PiArCQkgICAgICAgPCZt
YWluX3BrdGRtYSAweGMyMDQgMTU+LCAvKiBlZ3Jlc3Mgc2xpY2UgMSAqLw0KPj4gKwkJICAgICAg
IDwmbWFpbl9wa3RkbWEgMHhjMjA1IDE1PiwgLyogZWdyZXNzIHNsaWNlIDEgKi8NCj4+ICsJCSAg
ICAgICA8Jm1haW5fcGt0ZG1hIDB4YzIwNiAxNT4sIC8qIGVncmVzcyBzbGljZSAxICovDQo+PiAr
CQkgICAgICAgPCZtYWluX3BrdGRtYSAweGMyMDcgMTU+LCAvKiBlZ3Jlc3Mgc2xpY2UgMSAqLw0K
Pj4gKwkJICAgICAgIDwmbWFpbl9wa3RkbWEgMHg0MjAwIDE1PiwgLyogaW5ncmVzcyBzbGljZSAw
ICovDQo+PiArCQkgICAgICAgPCZtYWluX3BrdGRtYSAweDQyMDEgMTU+LCAvKiBpbmdyZXNzIHNs
aWNlIDEgKi8NCj4+ICsJCSAgICAgICA8Jm1haW5fcGt0ZG1hIDB4NDIwMiAwPiwgLyogbWdtbnQg
cnNwIHNsaWNlIDAgKi8NCj4+ICsJCSAgICAgICA8Jm1haW5fcGt0ZG1hIDB4NDIwMyAwPjsgLyog
bWdtbnQgcnNwIHNsaWNlIDEgKi8NCj4+ICsJCWRtYS1uYW1lcyA9ICJ0eDAtMCIsICJ0eDAtMSIs
ICJ0eDAtMiIsICJ0eDAtMyIsDQo+PiArCQkJICAgICJ0eDEtMCIsICJ0eDEtMSIsICJ0eDEtMiIs
ICJ0eDEtMyIsDQo+PiArCQkJICAgICJyeDAiLCAicngxIjsNCj4+ICsNCj4+ICsJCXN0YXR1cyA9
ICJva2F5IjsNCj4gRHJvcC4gRGlkbid0IHlvdSBnZXQgc3VjaCBjb21tZW50cyBiZWZvcmU/DQoN
ClllcywgYnV0IGFnYWluIEkgY2FuIHBvaW50IHRvIGFuIGluLXRyZWUgZXhhbXBsZSBvZiB0aGUg
c2FtZSBzdHJ1Y3R1cmUuDQpJIHNlZSBubyByZWFzb24gZm9yIGRlc2NyaWJpbmcgdGhlIHNhbWUg
dGhpbmcgZGlmZmVyZW50bHkgaW4gZGlmZmVyZW50IHBsYWNlcy4NCg0KUGxlYXNlIHNlZSBhcmNo
L2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjU0LWlkay5kdHNvDQpUaGVyZSBhcmUgb25seSBzbWFs
bCBkaWZmZXJlbmNlcyBmb3IgdGhpcyBmZWF0dXJlIGJldHdlZW4gYW02NSBhbmQgYW02NC4NCkl0
J3MgaW5jbHVzaW9uIGluIHRoZSB0cmVlIHdhcyB2ZXJ5IHJlY2VudCwgY2xlYXJseSBpdCB3YXMg
Z29vZCBlbm91Z2ggcmlnaHQ/DQpTZWUgYWxzbyBteSBjb3ZlciBsZXR0ZXIgZHRic19jaGVjayBy
ZW1hcmsgb24gZG1hcyBwcm9wZXJ0eS4NCg0KPg0KPj4gKw0KPj4gKwkJZXRoZXJuZXQtcG9ydHMg
ew0KPj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKwkJCSNzaXplLWNlbGxzID0gPDA+
Ow0KPj4gKw0KPj4gKwkJCWljc3NnMV9lbWFjMDogcG9ydEAwIHsNCj4+ICsJCQkJcmVnID0gPDA+
Ow0KPj4gKwkJCQl0aSxzeXNjb24tcmdtaWktZGVsYXkgPSA8Jm1haW5fY29uZiAweDQxMTA+Ow0K
Pj4gKwkJCQkvKiBGaWxsZWQgaW4gYnkgYm9vdGxvYWRlciAqLw0KPj4gKwkJCQlsb2NhbC1tYWMt
YWRkcmVzcyA9IFswMCAwMCAwMCAwMCAwMCAwMF07DQo+PiArCQkJCXBoeS1oYW5kbGUgPSA8JmV0
aGVybmV0X3BoeTI+Ow0KPj4gKwkJCQlwaHktbW9kZSA9ICJyZ21paS1pZCI7DQo+PiArCQkJCXN0
YXR1cyA9ICJva2F5IjsNCj4gPw0KPg0KPj4gKwkJCX07DQo+PiArDQo+PiArCQkJaWNzc2cxX2Vt
YWMxOiBwb3J0QDEgew0KPj4gKwkJCQlyZWcgPSA8MT47DQo+PiArCQkJCXRpLHN5c2Nvbi1yZ21p
aS1kZWxheSA9IDwmbWFpbl9jb25mIDB4NDExND47DQo+PiArCQkJCS8qIEZpbGxlZCBpbiBieSBi
b290bG9hZGVyICovDQo+PiArCQkJCWxvY2FsLW1hYy1hZGRyZXNzID0gWzAwIDAwIDAwIDAwIDAw
IDAwXTsNCj4+ICsJCQkJcGh5LWhhbmRsZSA9IDwmZXRoZXJuZXRfcGh5MT47DQo+PiArCQkJCXBo
eS1tb2RlID0gInJnbWlpLWlkIjsNCj4+ICsJCQkJc3RhdHVzID0gIm9rYXkiOw0KPiA/DQpnb29k
IHBvaW50LCByZW1vdmVkIGFsbCB0aGUgc3RhdHVzIGZyb20gaWNzc2cxLWV0aCBub2RlLg0KPg0K
Pg0KPiAuLi4uDQo+DQo+PiArCWV0aGVybmV0X3BoeTA6IGV0aGVybmV0LXBoeUAwIHsNCj4+ICsJ
CWNvbXBhdGlibGUgPSAiZXRoZXJuZXQtcGh5LWlkMjAwMC5hMGYxIjsNCj4+ICsJCXJlZyA9IDww
PjsNCj4+ICsJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiArCQlwaW5jdHJsLTAgPSA8
JmV0aGVybmV0X3BoeTBfcGluc19kZWZhdWx0PjsNCj4+ICsJCXRpLGNsay1vdXRwdXQtc2VsID0g
PERQODM4NjlfQ0xLX09fU0VMX1JFRl9DTEs+Ow0KPj4gKwkJdGksb3AtbW9kZSA9IDxEUDgzODY5
X1JHTUlJX0NPUFBFUl9FVEhFUk5FVD47DQo+PiArCQkvKg0KPj4gKwkJICogRGlzYWJsZSBpbnRl
cnJ1cHRzIGJlY2F1c2UgSVNSIG5ldmVyIGNsZWFycyAweDAwNDANCj4+ICsJCSAqDQo+PiArCQkg
KiBpbnRlcnJ1cHQtcGFyZW50ID0gPCZtYWluX2dwaW8xPjsNCj4+ICsJCSAqIGludGVycnVwdHMg
PSA8NzAgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4+ICsJCSAqLw0KPj4gKwkJLyoNCj4+ICsJCSAq
IERpc2FibGUgSFcgUmVzZXQgYmVjYXVzZSBjbG9jayBzaWduYWwgaXMgZGFpc3ktY2hhaW5lZA0K
Pj4gKwkJICoNCj4+ICsJCSAqIHJlc2V0LWdwaW9zID0gPCZtYWluX2dwaW8wIDg0IEdQSU9fQUNU
SVZFX0xPVz47DQo+PiArCQkgKiByZXNldC1hc3NlcnQtdXMgPSA8MT47DQo+PiArCQkgKiByZXNl
dC1kZWFzc2VydC11cyA9IDwzMD47DQo+PiArCQkgKi8NCj4+ICsJCSBzdGF0dXMgPSAib2theSI7
DQo+IERyb3AsIHRoaXMgYXBwbGllcyBldmVyeXdoZXJlIHdoZXJlIG5vdCBuZWVkZWQuIFlvdSBo
YXZlIHRoaXMgaW4NCj4gbXVsdGlwbGUgcGxhY2VzLi4uDQpJcyB0aGlzIGFib3V0IHN0YXR1cywg
b3IgY29tbWVudGVkIGludGVycnVwdCBhbmQgcmVzZXQgZGVmaW5pdGlvbnM/DQoNClRoYW5rIHlv
dSBmb3IgdGhlIHJldmlldyENCg0KU2luY2VyZWx5DQpKb3N1YSBNYXllcg0KDQo=

