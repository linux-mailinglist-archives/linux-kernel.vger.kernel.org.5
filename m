Return-Path: <linux-kernel+bounces-20040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C745982788B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70868284F87
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E63C45C1F;
	Mon,  8 Jan 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="hB8lkzfz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2127.outbound.protection.outlook.com [40.107.114.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379755E4A;
	Mon,  8 Jan 2024 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4FY0fRfUQ7VOHW10NXpzcJakrZlKBh5RDya8hCdQvCx1l2Ba3QCDw4pZIokPcFU06ij3U8mg5hT8veRTrIzvP631Yt3Fswt7qEYiD/NdmNXJMcphWdpil5DKhmGNr4msXbrWBx8quB47g5+4izCqSxyCET+5afqdK7x9+bcvTCWreIoX5joInvXyhsZybLE+rn7bJLX8LoacH5XrRBU64CaYdW48JJLgLo5zXdW1E8VqEg/Et0TEu3sAux5WYNAAVjxsRntRJmeXx4lEaJYa57DxKgjKTLfIHBzt3GhW7yccicBX1A+3+hCuPPSdwIxR/GvkgH1EcUy+t4P3Ky3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xjJzzI2iF2SRj7vKUx8kX/vl1bqO2SH2yf3KLCOP5Y=;
 b=e32FTLazE1SUuB+aaSe5NLp6DK4iwTYLjtg8gL7VvqLE76AYZ4hDNXrlxfoIqdE4/KCpBofw0huBCV3wmVq6Vad88pjjNcGSgvT+v90YyusV+hnvEWVeE1HxEyS1I0Jt94SJSGUNOPx8bpGC4t39c8OD+KgLI7kX9wMLYjFFc/QtLawI0dwMBu+2wl82QYm60+/pihVL5BsIz1fd3S+91K1kdx+23lOLnK2fi4W7xuSkrHlChENDNrKc8o6OPOy+eDejATPe4Dp/HReSGeXXRP5lzMqi05SbBBM8ZYTSfVnE6zWqx/nSLfUSYk0vxUlhrd24mNjfKdnOBq/A6ISLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xjJzzI2iF2SRj7vKUx8kX/vl1bqO2SH2yf3KLCOP5Y=;
 b=hB8lkzfzoq+nE2ORDFC6ohw0xAZDhjRDbBAfKThXiLl1U0bnay3h4htxEGNDugGCsw8bcCloQR5N1zkdyImBpeKYoJCwhrBoNkKbpv4A4Qe07E2Bi8OWjnxBtLJEGRbOAZNhl557pbSaC8oe3yGljL67GCIcwgf0uYIK2UyLXng=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by TYVPR01MB10749.jpnprd01.prod.outlook.com (2603:1096:400:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15; Mon, 8 Jan
 2024 19:27:29 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6b76:59e:58b9:4a5a]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6b76:59e:58b9:4a5a%4]) with mapi id 15.20.7181.015; Mon, 8 Jan 2024
 19:27:25 +0000
From: Min Li <min.li.xe@renesas.com>
To: Lee Jones <lee@kernel.org>
CC: Min Li <lnimi@hotmail.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v5 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Thread-Topic: [PATCH net-next v5 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Thread-Index: AQHaM1UqSeCl1VZK/0S9Jut3Zk6ROrCz61MAgBYNamCABk2fAIAAGbZQ
Date: Mon, 8 Jan 2024 19:27:25 +0000
Message-ID:
 <OS3PR01MB6593FD73A1C98CAA6E8BB5BDBA6B2@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <20231220145917.7076-1-lnimi@hotmail.com>
 <PH7PR03MB70640D32D7AEC51BFE83A02FA096A@PH7PR03MB7064.namprd03.prod.outlook.com>
 <20231221161604.GP10102@google.com>
 <OS3PR01MB6593208C1466417EBFF2F878BA672@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <20240108171710.GC7948@google.com>
In-Reply-To: <20240108171710.GC7948@google.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|TYVPR01MB10749:EE_
x-ms-office365-filtering-correlation-id: d76447dc-37c9-46b4-5768-08dc107fd86d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WJZ3gFFjP3oxv3ygsZNy7KEfKZtGWROvk+/itAuGeGvBVm0GBUlRf0tm/L77c2RPuYVNb4vK26NNrcasBFyTk3za4oBzbXUfCdCU+ddBIXcojdrLRuo18L14n1PPID2rHZAdgUNGo6fhvpT+AFFmzSBvGACHGRDWTYyAU3GC/dDChA2Ly0cMlhmWiluYrOwK2MypzqmqGcQ8VES8GZ2aeYeqHknD7eIlYPybCRSKyB9Jq1F9BFNP5J1B/QEnhyAcu2Qe3XGYXmnlg81W5oWMQ2TcFKCmEo9aB72iUvbWwBaFCxx3CKJkuoymaNXeQnx6uFKn5xplXo80veHU3ksHF0Tc2GwA8Mbue/2/c6k5lehlBLOQZM79hGGyt6EwM2B4rUvR55mFmd4DYVWKjQ3vUo/wlHhYih0RUGxT8x8PeHIOwhtqxl1oFbfUYuA25B4V06z4UIIngkwnIafgN5/HKDr4S3BOLIYsmFf3F1HQlXAWwj9ppJEppiDkJV2eIF4BhgMYsMy4/X5nguCL+e+9fbm4KbbrgG6kw/TFHdMyk9ZWZKP8mzPfc1mU1X8n3C1R4pItkw/n91jBXW9+4zxynPau+QGif7oxZE4ZWp+7HJu9d92FjUFvQi/qd5ey2mf9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(122000001)(38100700002)(4744005)(5660300002)(7696005)(71200400001)(6916009)(66446008)(478600001)(64756008)(2906002)(33656002)(4326008)(52536014)(55016003)(8676002)(8936002)(54906003)(316002)(6506007)(26005)(9686003)(55236004)(38070700009)(41300700001)(86362001)(83380400001)(66476007)(66946007)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTE0RjRhUlR4eDZlT3NmNWRJTjMvMjJxbFBTelN2eWF1dlF0VzZ4VkZ4NCtk?=
 =?utf-8?B?NWthK3R5aUF0TnRvRDhKdUQ2eHpMSU5LU2YrQi9WcktQbnVvY0FpaEEzV1lY?=
 =?utf-8?B?MVI0dkhwL1NHR0sxdnhDc1MwM1NNbGlMeFlrQ1N1RFhXQUNaS0czUytXb0xn?=
 =?utf-8?B?aXRDd01BL1lvNVBzMlNaNnVNWW0wZ3FjNlVrWFJVWXo0cUlwWWtQaFhWRTVZ?=
 =?utf-8?B?N1NaOUp3WmNMa3ZGSG1tL1Rzd2pKSUhMZzNPOEx0S3d3ZlJ4cTJPNnBxekxj?=
 =?utf-8?B?RWJJMmJjU09NalRHR1dYSlN1bUc3cHcrOVlXVVJvK3gyVWVrczk3a0g4WVFk?=
 =?utf-8?B?aGRUU0JaK2RNck1oa291eng5OFVZZEc4Yi9sanNKQkRxY2tJRDQ5STRqa0Nx?=
 =?utf-8?B?dTZJb1hEQ2tMNGNwZzZaWTlhdERLdTVNM0hDSmpVT3pCYkt1NU1wREVKbDJq?=
 =?utf-8?B?VWdSL2wySmxLY0xqUEI0LzJTNjZPZ1BoOVpvZjRWdTNJMmtRd3psaFhKTHg4?=
 =?utf-8?B?WFpDSXFHK24vQ2gwVlExc2REenlTalp6ZlNDamlOdDNXNGxpdUpHN2RvbnFx?=
 =?utf-8?B?TjRyUnYyT0kzUS9HWUNGL0tBUnROUzBIa0FYejV1d1puVDh4M1NIU3U0MFNr?=
 =?utf-8?B?ekQ4bFVqNkVFZEN4QmFsK0xlNS9rYzJ1UzgvbW5tdzRpdUJrUlE3c2E3M3ZX?=
 =?utf-8?B?YjV0Q3R1eTNqc0l2azNycG1QcDAwdTcrU1JiN3hUMGZHczBXYTNlRFhNM0U3?=
 =?utf-8?B?blRBRkg4TmtCNFZnc1lQMkdLZ21mVWVjN3l4L2dsVWVLc0xNeFUxbm0yRVdJ?=
 =?utf-8?B?Ykx1aFU1TzYrdWhMdXVuTCt3L1hYR01WWWJXRkE4UVQvV3V2Zm5oMjdVT1FW?=
 =?utf-8?B?cWNGazhlTmpFM3JlWFczdVI5bi9YK05GQ3NYWjlKQWRYUVgyaGdIQ21Odkh3?=
 =?utf-8?B?NmVjejZqTFBQZnEyd1JtQnhpQm9yNU40MkFlUVNrVWVqcEdORVl5SFVpaGFj?=
 =?utf-8?B?a0k2MHMzTjJVNFB1VGl2ejd1eWhuSDh3S09GTHBISmVKZncxWVkveGxTamR2?=
 =?utf-8?B?T25YRHBiZVgxSTlsdXVxZEZKeXgxQ3ZLNG9MUFJ5ZHN3Z1I4OVBtd1Z5UStt?=
 =?utf-8?B?U0hNUXN3QkpOb29DQmRQNWRSNFpLTW80dzVuM2ZaV09PZmxlbm9TaC9lTkJs?=
 =?utf-8?B?MFpPd3ZUUWRueEQzS2cvOUYxRU8xbEk4SXp1MDBFZ1NUWVFUUTllc0w3bVZO?=
 =?utf-8?B?S0NaaTk5VVhBQnUzM2lhRVNsUy9KYnRwUUxJVkI5MGVrNmJtVmgzTmt1TENt?=
 =?utf-8?B?M1dZQkh5bXNSQ0xQamJPRG5zaUdnUThLU29NMmVlbzg0TUxhcDQ4M2h3eVBJ?=
 =?utf-8?B?K0hGamtKWVBBRzY2emNqazNMc2FpemdvWjQ5Q3JvT3luNFFNVTF5dUhEa1BT?=
 =?utf-8?B?Zkc1Nm01UlY3OHBiQ01jeSt5a1pTR3FnUjJhOXpRSklvSXhqOVdYZktGMjdU?=
 =?utf-8?B?aGwvQmt1STVtem1yUUJacURncWVramZmTTR1cDVIby9hZjQva0RYSkZzRWVw?=
 =?utf-8?B?SUlyZisrMzdLSUptLzIranhzNmo4QjA2U2kvVzE5MHluVGI1MlFJYVZMUTU4?=
 =?utf-8?B?ZEQ0Y0NrOU9XeDZ5MnZOVWpKUWgzcC9yamhSTGVDOUVyU1JCSm9maGtSekFS?=
 =?utf-8?B?enI3K1pqVkZRdzA5MHhnOE91ZmFVVzluZ3IzaHNYSzV1VlJQZ2NZSCtOZ2Rk?=
 =?utf-8?B?cE9sTy9tVzBueEVYbjdFVHdJOFVUcjQvR1JUZXFiaVhMdTBRRVVXbmt3S0No?=
 =?utf-8?B?RGp2VWUweWhMcEw2dndIS2ZFRFRzTjFKMjcvejhnaXVaM1UraHprbDFkTExn?=
 =?utf-8?B?NkNkSDFpWlcwdjY1ME9KS2ZoNGlxU3NadmNCeStpZlZQWUNlNzF4Q0h5OUNx?=
 =?utf-8?B?YXB6RXhWMzlocGNsUnNDaE1URXo5SVVENGVKdmhlSTIxcWI5clBTMWhTM0k0?=
 =?utf-8?B?RUQxSzhBeDJtbWQ0Q0NDVmVFeU84OUtiVXRIQzlodThjRmR5L1BMQUd2SnJP?=
 =?utf-8?B?eU9XNGhPY000R3dLWnJsSDRqYllLMXlWVVRCV3pFOEE1dFhwMVdva2g2NTJD?=
 =?utf-8?Q?OYKzl8RaaUQzlBrkDDOHI4Tes?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d76447dc-37c9-46b4-5768-08dc107fd86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 19:27:25.7426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzoOI3FMTNUXAJjAOYwfB84LGSJP2Ad6Ad2wfE5rg9LQ3RidK3St6JrQIrWqyCGdjaL6TvMzqkePpUsLtOZRKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10749

DQo+ID4gSGkgTGVlDQo+ID4NCj4gPiBUaGUgcmVhc29uIEkgcHV0IHRoZW0gaGVyZSBpcyB3ZSBo
YXZlIGFub3RoZXIgZHJpdmVyIHVuZGVyIG1pc2MgdGhhdA0KPiA+IGFsc28gbmVlZHMgdG8gcmVh
ZC93cml0ZSB0aGUgZGV2aWNlIGFuZCBwYXJzZSB0aGUgZmlybXdhcmUuIFdlIGhhdmVuJ3QNCj4g
PiBzdWJtaXR0ZWQgdGhlIG1pc2MgZHJpdmVyIHRvIGxpbnV4IHlldCBidXQgd2UgbWFpbnRhaW4g
aXQgdGhyb3VnaCBvdXINCj4gPiBsaW51eCByZXBvIGFuZCBkbyBuZWVkIHRoZSBpbnRlcmZhY2Ug
bGlrZSB0aGlzLiBUaGFua3MNCj4gDQo+IFdoZW4gYXJlIHlvdSBwbGFubmluZyBvbiBzdWJtaXR0
aW5nIHRoZSBtaXNjIGRyaXZlcj8NCj4gDQo+IC0tDQoNCkkgd2FzIHRyeWluZyB0byBzdWJtaXQg
aXQgd2hpbGUgYWdvIGJ1dCB3YXMgcmVqZWN0ZWQgYnkgdGhlIHJldmlld2VycyBzaW5jZSB0aGV5
DQpkb27igJl0IGxpa2UgdGhlIGV2ZXJ5dGhpbmctdGhyb3VnaC1pb2N0bCBkZXNpZ24uIFdlIGFy
ZSBjdXJyZW50bHkgcmVkZXNpZ25pbmcgaXQgYW5kDQpwbGFubmluZyB0byByZS1zdWJtaXQgaW4g
dGhlIG5lYXIgZnV0dXJlDQo=

