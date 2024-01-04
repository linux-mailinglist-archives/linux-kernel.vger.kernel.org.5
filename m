Return-Path: <linux-kernel+bounces-16984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB58246DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2E4B21305
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5B32556E;
	Thu,  4 Jan 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mqISRTRf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2128.outbound.protection.outlook.com [40.107.114.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2592555B;
	Thu,  4 Jan 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQH4GCPJurcDuAZEF9BVGTIh1vLEm/nYzXStkmyzC5Yw7NXhm+LNIL9/CqUuNNKLeFIeTF4UsXAjepxDDbR4R57oP9WoI0fcVswTo6iNjwIpvrlO+ZxJdoWaUzv3GZuuVJtz/kJoj7yXA7mgPblegVWSKRPZG0rHJp+AsgXJp4XwI8kPTXsOxIRR9yRBaPA1gdpxrKcevrHPa564wvfxlKqc8UkKceiyKKK2jmu7AoODLeojhxFHmJMaCKZ+NfKg6gK/7AvK8xpB3Rs9EtNp+UreVZjfvtCbRcmqMEX3tj74nEcj06NeNGjhLRjlRx0Sc4UtclO1rM+8ZU6AlqAPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNmilb/7KkyKv07Xx7JUAYvFteiUdGXypgv+zDcwYo8=;
 b=J3HYmT5xNa1lB+7RDOO6V91emXnoZpeRe5nY1XKQZNgPpZitwaVmmWERphdOL6JK55NLX199QtS7OEkgFdGg42HBclwjf2Le/X4PnOPgMug55ImBAkszwL6eAwoRL1Z7d75GToA+Wj/H4cAcqpNemzSm9CJRVDOBXaii0bk9upc/mvmR/6pOWhYBqp6+c30Dv1G/fO/KaBzfuPFfkh4oWVEGg9sJOGLu/rArWCjFDwIEYC99EKQf0rzYyr+RjWXBFG06Yc+DF/iz/NCaYQeZsDtrM3Z1EacsyyaqqUyTzRs08o/hZceNcaIbF+JE1C5n1s5h8XbEW4zce8vp7XLapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNmilb/7KkyKv07Xx7JUAYvFteiUdGXypgv+zDcwYo8=;
 b=mqISRTRfBVm++/C37Le/WzYQjz0lf7LJvl9B2SpQKDTkclQmLnEd92cMZOadk+Dyoc65SGGgm/asOlLh7RV/wcGNrYfwGdy9baqAtffbAucknYCfcY9ZGK8UyCaWX0MGIotBYUe9yG8jvp8k5Ysg1w7VjGDvC8MS+Z3gSEx5/K0=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by TYCPR01MB12058.jpnprd01.prod.outlook.com (2603:1096:400:448::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 17:06:51 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6b76:59e:58b9:4a5a]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6b76:59e:58b9:4a5a%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:06:49 +0000
From: Min Li <min.li.xe@renesas.com>
To: Lee Jones <lee@kernel.org>, Min Li <lnimi@hotmail.com>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v5 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Thread-Topic: [PATCH net-next v5 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Thread-Index: AQHaM1UqSeCl1VZK/0S9Jut3Zk6ROrCz61MAgBYNamA=
Date: Thu, 4 Jan 2024 17:06:49 +0000
Message-ID:
 <OS3PR01MB6593208C1466417EBFF2F878BA672@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <20231220145917.7076-1-lnimi@hotmail.com>
 <PH7PR03MB70640D32D7AEC51BFE83A02FA096A@PH7PR03MB7064.namprd03.prod.outlook.com>
 <20231221161604.GP10102@google.com>
In-Reply-To: <20231221161604.GP10102@google.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|TYCPR01MB12058:EE_
x-ms-office365-filtering-correlation-id: f2bba24e-0c5a-422d-9483-08dc0d478a7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pU44rk//H8MDb/wa20CZ/Ers99X1PNF+X8hvWkKek/pJb4cRt/S9AKjnHq1WmOQ8PZOpt0bD48wcVx6PZwHMsd6/lvWpprzrUhAOYtUno2XFgsLpcwdewpnQUuyNByey4/4hQE6fvVNJ1wvoU0rEQWCG5v1g9cEg8JE9R06TcLdaq7wvmWG/Htp5AC5FTjQinj2bwNPoro3o66GWUjYqYYE5ujVT7le+gH0qWhykA8BMsYob/wpv6pHKK7s/ZMJefLABAIam/AFk5iA9b98a1phSt2f3aGSogALQ34UY40Mh9pMzWfFBqZICuuY7c9+YYQlF9jESqr2xzaQVStDPvaCamC6kGouYfrCcNAZs4F7ACnSXgKTuAadIKGYni0hcpuYWQBs1gcuGPdMJJUq6Ft1T05A4hShQ19ba2H8ROTiZSFI2yWIDEsEGQJWRf05Qif6BAgjHIXLfYrQHu2ckkHT6N0GdzBmiFl6aEIOFmr8PDUsELQcwTX26iPeeZ1wiur4Bi1v1ofPUoEgPJCOhmDHrPHB8ntfhd1Sd1Ludsx7tE7aFIZiloRqFsYyFdCEm8Ylv6bdbgZzKJ2DuleX1YE1cN5AUr9H6Xsdefaxk2R0MdJYfbKqfoHmh9RihSq8e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(122000001)(38070700009)(55016003)(86362001)(26005)(4744005)(316002)(6506007)(9686003)(7696005)(110136005)(54906003)(8676002)(478600001)(71200400001)(8936002)(66476007)(66446008)(64756008)(66556008)(66946007)(76116006)(33656002)(52536014)(41300700001)(2906002)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEFNUVErSnMxT3VYSVZzQURBU2tyRkp6MlNoajJZMFlrVGxKa0FvZ2FJOThm?=
 =?utf-8?B?cHAzVDJCWGFBeGdFWFRTaHB5QTJpYkE2QXgxU0thcGtLcmd1L2s5M3JvaE1t?=
 =?utf-8?B?MXhteXN4d2R2ZFZIUXF5SWxEQ1lLM2ZmQ2RrQWpaSTBDZ2Z5eUJpTHcrV2lD?=
 =?utf-8?B?T1JXT1JCMFZVN21yVzFRTUtvRkQxMFRodHdBMTkxRGhlNTY4SFdLZ1NBNFBI?=
 =?utf-8?B?UVp1R1VmTHhwN2lYYmJmeG1jT1dVRit0ckxtYUxyTTJRU1B1WUhIRWVkMU5C?=
 =?utf-8?B?Zk9uYXlFU04zMlVEb1JvTjhYRW5mTmlCcTVWUEtqTG82aWl3K3dKa0szY0xt?=
 =?utf-8?B?bmkrV1dHQko4UFIzNFBETE4yZkx1eXY4c0RSejd0U0pQWVJiN0ova0xlbnZN?=
 =?utf-8?B?Sno1eHp2bk5SdEE2TzlMalpRbGlDaUZVQzVVWDVmYVo0TURUNHpvU3VybzZV?=
 =?utf-8?B?b2VheUlMKzh6UXVVNmtLR0VrTGlsNjZQUlJyL2wyTGNncHY0VHljMjBuemZ1?=
 =?utf-8?B?UVFtY3VCMHZOZkdwWVlCU2g4Y3gzTllIQnZHSEpmcGV2dldycmtrVGNlVEw1?=
 =?utf-8?B?K0NkV1ZRbHpobjljdTBkMHdkNHlXRDhEUEFxbmI4TEdVZFIrTmxjekwvVXJN?=
 =?utf-8?B?S1FaanVSbmVuWHRmbjdkOVVqVkNvdXpJT1hZcS9RV1V5bjZkSzdqMnluS2Q0?=
 =?utf-8?B?VC9IWmo3NTVtdDdoc3ZUUWdyMGpCUUlSNXl4TSt6Q1RXK2M5a2tPSG9reDlx?=
 =?utf-8?B?RE5PZkVQNElyYkFCdlkzV2pjeG16V1cyZVJFRGZzS0JPeUN4aWxjYklaVVJI?=
 =?utf-8?B?K3NEaTRkNkJtNTJPWkdUOUh4RHUxMHBhSXFSZ0tyMWdwMUg5OEdyVWx5UVNM?=
 =?utf-8?B?djUrR0orV3VFdVVLMXptNFVpWGZNZzlyZmVod1lWam9SZlVMMHBOY1VjSFFR?=
 =?utf-8?B?aDFKMmUwNStRemgrYlEyUk5zVldvRjUvckpXTjFCWDdEVThDZHlYdjlyZzBT?=
 =?utf-8?B?elJNVDhiZXoxZGJCWGp6Q1AwUzc2Q2lnRUhWcXc2M0xkaVpYaXA5N05vaTZX?=
 =?utf-8?B?TnVDT01nQU9ab3MrenZrcFhtaGUxL2JLMVFEa2NoL1pPbVlMSXhzd2xMTmxs?=
 =?utf-8?B?Q0lLeTAzMnRvTXgzTzRBd2t1c0U2aldBNDZtb1ZYL2JWbXluRklvWlVPQXRF?=
 =?utf-8?B?eW5KcnhkMnJFWUdaRlR6M2tJOHBSV2FvQnUxd3RxdGIwUWExbXZUWVl5M1Uz?=
 =?utf-8?B?Z0xTWGFqN3l0ZWZDenZpanhCZEY1WjdNWGd3UVZCV1lqL2xOenlXMXhMcXU4?=
 =?utf-8?B?ZFJtS2xCSlV1K3BwY29YenRlVHpWR2lIeVd1aDE2NlBBTGNpNVI3a1hxOEdy?=
 =?utf-8?B?WlZoMkZaQjJZUXNhS2ovcWJIUC9wQkdWaGFKdm9BaDhheWhtbnp4QWh4dTQv?=
 =?utf-8?B?NGlVdDJwY1p0WitDZjBvZkdTQXBOMzBqdjhUUEFiajhqKzVFK1JlUFZrUnM4?=
 =?utf-8?B?OWk1Rndncm04SDcvaERoNllNeFRCSWVTclpkYzVCMVZLMXB4ejNRWm1UcnpY?=
 =?utf-8?B?S2RPL1JpMmcxUHZSL25nditEWUpGNGhQTlh5WmxhY2hrVTdvTlFFNnlXZDNn?=
 =?utf-8?B?eDJLd0JBOGN5K3o4bmFGUHdyWHY5czFwMlZRYWZielVFa1pGYXl2WXBZR2o4?=
 =?utf-8?B?TW5qOVFvMHl6NkVaazZvUmJWbTBsZHZpRjlkdDkwS0lyUC96Y2Z3dFcyNGha?=
 =?utf-8?B?SVNzYXN5RGV5QnljVzE2eVU1bTU0N3ZsLzM4M01CY2FNOXl4cGNSeWh1Ly9X?=
 =?utf-8?B?Sld1enJZTVJGVEdjU09GWnhsU2JLU3VnSy8zTk8xYzhYSVk2dlV5YWk1VDdE?=
 =?utf-8?B?S1ZFSDRMMkwzRDNFOStnb0l4N2QyVTEwYXJMNnRjcitncTN3dVpvQmNnWXNz?=
 =?utf-8?B?amFZSUEwTzBFck1qU01mbmpFQnZENklqc2EzTnhZREY3eENvTDZKTThNMGY3?=
 =?utf-8?B?NkFVZ2s4YjJDeEdzQit3SDBrcVF2MGVkUGx3ZitheC90L211QVZEY3dzazIz?=
 =?utf-8?B?ckh2Vjh1UHFzeUI5QU9vQmpubFN0V1Q1dngwa2VPTU5WQkswR1EwNHZNYmh5?=
 =?utf-8?Q?dUAkMHxbmF5QsMu3LdgvVAMom?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bba24e-0c5a-422d-9483-08dc0d478a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 17:06:49.6654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vRxmn81/v+XOOSFvzos5/bvoSw5DMe1XVGLQhUM3c+B2PfK5g5Tca8bnPOdpEyGGbVTDRvm+lZmQ7dyk1IUuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12058

PiANCj4gQXMgYWJvdmUuICBXaHkgaXMgdGhpcyBiZWluZyBzaG92ZWQgaW4gaGVyZT8NCj4gDQo+
ID4gKyNlbmRpZg0KPiANCj4gLS0NCg0KSGkgTGVlDQoNClRoZSByZWFzb24gSSBwdXQgdGhlbSBo
ZXJlIGlzIHdlIGhhdmUgYW5vdGhlciBkcml2ZXIgdW5kZXIgbWlzYyB0aGF0IGFsc28gbmVlZHMg
dG8gcmVhZC93cml0ZSB0aGUgZGV2aWNlDQphbmQgcGFyc2UgdGhlIGZpcm13YXJlLiBXZSBoYXZl
bid0IHN1Ym1pdHRlZCB0aGUgbWlzYyBkcml2ZXIgdG8gbGludXggeWV0IGJ1dCB3ZSBtYWludGFp
biBpdCB0aHJvdWdoIG91cg0KbGludXggcmVwbyBhbmQgZG8gbmVlZCB0aGUgaW50ZXJmYWNlIGxp
a2UgdGhpcy4gVGhhbmtzDQoNCk1pbg0K

