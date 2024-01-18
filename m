Return-Path: <linux-kernel+bounces-29947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8448315A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703E72871ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C5B1D55E;
	Thu, 18 Jan 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SLT9bvWg"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004212E73;
	Thu, 18 Jan 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569790; cv=fail; b=ehwm3ioA6Vua0ZNBDQUKQmI+Btyy5fTkcSXUcqHK7omk2Hjpq4EnCCoQvsGsiSviQEOqlYwNsIn1txliw2UECypcK0VZWJy+Syi9jxaYyahFMLuDrppb73ML9Sldn+vbgVBlb2gmFI4HAgpSeCS855ekFQSxpaCboC3PcdX/t5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569790; c=relaxed/simple;
	bh=8E6AJKPpF72sEm96SK83P0OyD7bs3gEcPpBLkjfabhw=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=HL7y4NszeDPeUglr+Bwh8qSgkTfx/F0GmnLsDgBNadPDqT82nJAkVf3RodyuL98yqWAFOlrGjfetZCr/i2Rg7QvPSnXMPT1HRGKMrVU6o/JY10DwSP9R/KhqHR5PYb8wdPa2hXbkoVN7V6SF/rIcu+01OLrbAom0fmcK0BcGy40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SLT9bvWg; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJfsUQN5eIDkSRnnCnGzjgNhA2LU7/H1bEZeYrZNoxfsphWoZSnkmePpt4rUZZ2/OpItrQAhatQkt2r1u3ce8KaV5qR7LYi5QkLwzuTCB509+VZWQ/FqRdPOaObCJ37BJ+fbdg5aflEaQqE3DbM/lb81JHQUb2a8wWKIJCSZ2njkBybcB0gSWgv2hB9pwh5WfXcE43iPyCHl/BvkBZudYEiw1LS1tOl2cTlnaDUgDLNj+YZ1v/fYLll1vMu06tqPJVrgt/3JNyCWn7UkgixL5uRE9OpLWAs+oFKjGuRhqPDTUhMzsMkX8QrmNDmslKDL7VMIdkiT/9wu9PcfTw76rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8E6AJKPpF72sEm96SK83P0OyD7bs3gEcPpBLkjfabhw=;
 b=OUx9yeOEjJp+HV6wGmYU6qt4EWP3uUNk/v/GJeg8egqCf9jxCDABzo8nG2AdkmPjxHmqHPqmXSXT7FuFqQkCz5TiSu1Yf+i6PF+EkkEfDsdN5UbHGYThIhRPMz3fmvw9YMpc+chUJynvtLRqEhZEJoZ6OlqjSoCxIhoA6nINmvV129ZJWrmERwH2D0OLe3kCTZluayDqKJImOC+zNIn4xphGyBzQEzwYaJdLykcg794wQbQueiczBolRR4imwtnZZDl0TE36Rf4jTpjZF9Cdkq7ZLrrav+lMCIMJ52BmboXOJnwKJUbpK9v38nS1zpZOv8WOhNmuRGGtzh45/m7MDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E6AJKPpF72sEm96SK83P0OyD7bs3gEcPpBLkjfabhw=;
 b=SLT9bvWgrq1irxFip+k5SVAp4XbMtVm0QdkYiSh7FyYEJTK6i16ZUMIVeB4BBtnxU9e4xLezopo+2neHzkoCXK1TaKnVUjNm88AXUrdNF7NAdHMhzhxJ2IFyNMigcyUJvDZaACQrMIUNyngWHD6kWbaUSXJgLU7aWCLyBtmcuTo=
Received: from BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 18 Jan
 2024 09:23:06 +0000
Received: from BY5PR12MB4241.namprd12.prod.outlook.com
 ([fe80::c1f6:9417:a257:d081]) by BY5PR12MB4241.namprd12.prod.outlook.com
 ([fe80::c1f6:9417:a257:d081%2]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 09:23:06 +0000
From: "Cvetic, Dragan" <dragan.cvetic@amd.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"michal.simek@xilinx.com" <michal.simek@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 2/2] MAINTAINERS: Update sd-fec documentation file from
 txt to yaml
Thread-Topic: [PATCH 2/2] MAINTAINERS: Update sd-fec documentation file from
 txt to yaml
Thread-Index: AQHaSGzRThtElyDVREeaGSNQf2Fr7bDcjDoAgALCmmA=
Date: Thu, 18 Jan 2024 09:23:06 +0000
Message-ID:
 <BY5PR12MB42412281743CC35176C20D84E2712@BY5PR12MB4241.namprd12.prod.outlook.com>
References: <20240116111135.3059-1-dragan.cvetic@amd.com>
 <20240116111135.3059-3-dragan.cvetic@amd.com>
 <941aa7cb-a047-4c79-98f3-5fe8be84a752@linaro.org>
In-Reply-To: <941aa7cb-a047-4c79-98f3-5fe8be84a752@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4241:EE_|SJ2PR12MB9116:EE_
x-ms-office365-filtering-correlation-id: f46fb297-e93c-424f-a3ea-08dc1807146a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yILddItSp0S8s7hTTnBLVU1X8qBgoty/4rIpsKWZ3J8ue2qUbdKR4Ma5wTUobGwK5/1sPUZDLALitZN7jz7IPKI5xRfyElYp93jYQnc8oeEVMSUkD6XEgfveOb4ZTs6jnkqyuGwdlSLWVbKG3h50jN7kWq22sgkN8dTR6CpKemqcscYnQGf+yGDvecRSNjqD2bRmSz5Fu8o1LINd2BnF+5lIOGRsFv/qwyfrlXI5a8ncDw0xf7Rh5ZMZ9Re1GhCYzHKoJA8BzxqEtIPLIU5kEvpDnSIY7ehKia53NCFKiBZN4b+w/ff0ma60RY4m/lDzLITDIP/sQlfxF9ndnGVVospl8rG7Y7Y1AyvP4byw+nn/Ra4OpwDijDTYF5kqJBLZY0syaLSIm+gztTBcdidoHIjujDDCWjs92xgkhnMTZH0m32BZ9hdx/Iq68i5h8u81tdfM3yMcgksKLVqqbYcO4lhRsnNnZ/ejYk+oIuQw6mXv7XLsJXKeYjM2QA+ArRFY0Usota0Ofofm0DfQ9pqMcUlCBo/j2VmM4Cz4klMAEPGuW5wfQOAJfGWpFZgiITo+7P2pFdmu9c72Spao3jOwRo0zVixM4EiYF2u17mCri6Q0kE8LTGXPuL6+OsJ+tXwh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4241.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(26005)(4744005)(5660300002)(15650500001)(38070700009)(86362001)(41300700001)(55016003)(33656002)(122000001)(316002)(54906003)(66556008)(8676002)(9686003)(53546011)(6506007)(2906002)(66946007)(52536014)(110136005)(8936002)(4326008)(76116006)(66476007)(66446008)(64756008)(38100700002)(71200400001)(7696005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVJOdm1DcXFDazlWZmF3ZE42MGFkOUY1S3hSbU5HK01CZjZNTDRKdWttRmpR?=
 =?utf-8?B?b09NTEQvd1FwVWZaR2Nub0svZVl3U0pNMThMUXZMQkV1WmdzeG15LzFQZWNP?=
 =?utf-8?B?czJGMFJEbmN1aU52TmtpaEp4ZXJGczJWMVFZVW5FQjZzamxZUlNHSDgwTHRW?=
 =?utf-8?B?WHNtWG82SXRzWmFqNjRwZ3NBNnlhUXN2RWgxV1BlV3VJdElqT3lCWnBDVGpC?=
 =?utf-8?B?ZmpEcUxGd3ZuTDVmTUNucnhPMnB1ODRPc20ya0paZmgvYTV2RThnNXM1T3VV?=
 =?utf-8?B?NHQ4MFREenBDVENaa3lUM1pMWS9kK1VWTHNCKzhWczh5ckJhTlhGTWY0R3hv?=
 =?utf-8?B?d2hVYXdVZWN6L0dWS1RHZmpXZ0RBY2srZyt2M1dyYWRiekZiOFhSdVc1bWtD?=
 =?utf-8?B?M00zNEIyT2RrZ0FoaCtrSGdGb29INGNyYkRIYzFOeEJieHdrcHVRVWtxQldM?=
 =?utf-8?B?ZVEzSWt4RUkyUlRpRHhQYmZKT3FBWi9rcWZQa2lycHRmZzBQVzlEQWQ3UHo1?=
 =?utf-8?B?eE1yTnBaZ1k3SFhEUkJWMERiN1RtTXBCQkVsaFZBOTBGM3ZYODZiLzZpTWVH?=
 =?utf-8?B?U09oTkJ1alV6V2RFYnF0REZrRnhKZVY4NU9BSGZGTjZ3M1pVQUcyNnA0RDFE?=
 =?utf-8?B?OHYxR0xNRVoxM0YvWGRNaUh4MUhkeEFScTYvSVJ2VExCU1Y3TTd6clBWR0Ry?=
 =?utf-8?B?M21ONWNwNUJ5eWVrU24rWUg3Z0JrVU42M0xONnQ3UVBIOFRxSDZyUmlwd1Rm?=
 =?utf-8?B?Vi9YeUVoSm42Y1k0UE9MMzRDRXBZQjZ2RmNXNUNQNUZTKzJHUGtzdytjMXlv?=
 =?utf-8?B?d1V6eDgvSFdha0o2a0QrNG4vZWt3VEhydUx2cWJKVS9xU1BxTTdlcXZFcFNs?=
 =?utf-8?B?MWRJZEIvU3BPWlBubmk3a1Fmckpwa0FzQy9CVDY3cjA3MlpKRUdudGI1bVlo?=
 =?utf-8?B?R2gwNkdDelNtcTlvSC9GM05xL3d0NEg3SEhkQ3ZpYlNQU0w2Mkd6bG1reVBk?=
 =?utf-8?B?bXdBcXFzV3FvUzlWbnQ5TmdGc2dXcTRIU3BxQkpyNDNwTHdvZzdXL051S1Nu?=
 =?utf-8?B?TlVZd0RGM09OQ1BrTThOV2lzSExiaXMrR2Y1ajZwODFYQWt6Z3dtUlBtS2lv?=
 =?utf-8?B?bmxxS2lHRFBVMEVDSENRdytYNE9oOUdjZ0lrK09xNWhwQW53cWdPZjEwRUt5?=
 =?utf-8?B?d3FhMW01RHk2M3hFMkh1RWR1Sm8zelprN3Z5R3A0cnREYVExVCsvekZHajFE?=
 =?utf-8?B?aEJDL3g5U01NS1dtVUk1Rm9ReDlYTkQvekJMenRuZFNHb3NYbU1XT0tCQjJT?=
 =?utf-8?B?cmxHQkEwbUZzdjhFYjV1VndydUJyQlpvSmoxRHo0cnVCRkVFaGtuOThTZW04?=
 =?utf-8?B?Zjk5dUY0bjNRRWRVWFFnZEpwdHZrKzNHK2dsNnp5TWxMZUxCbFJyM3hURWJH?=
 =?utf-8?B?Zm11Y25rbVAvNXdXYWVSOWJ3L2RsaFRhQWNVc1lwTDJpUDRUaXFaWjg3U2FM?=
 =?utf-8?B?S1A1emp0a01tNFVGMitibkJVWnMvWTc0SFlzeVg3T2FQMFRLSHlQdWVuUU5H?=
 =?utf-8?B?N3BvcjJsMW9neTc2QkxMcS9oU1BMeDloSDM2LzFoUHRnVk9jR3BCT04zSHVU?=
 =?utf-8?B?N0ZyRGUwWGdYa1VUMncrQVlIditVNC9lSURYVG1iS0w5UVduSE5PdDlHM1JS?=
 =?utf-8?B?cnBZRllEMTh3ZXIxSjlrUmRFZzgwU0kzM05YemgzWlNqZ1I2VDhNcWMzakdP?=
 =?utf-8?B?dWI0N09HUURjdWw3a25FYTlKUE1UMXBRZGdqeXFqLy8zU3FHTU9hc1dhMFE1?=
 =?utf-8?B?MXNiL1ZSV09WODdMWlRvMHNhRlE3bE5PRmtHMHFJOFRxcFpKWTdHR0NaZk5k?=
 =?utf-8?B?QUd3UHBWVnZld1V4T1hBR3BHV2EzMXBZc3hhc21RZDJJUTd3VTh5NGdRQnhj?=
 =?utf-8?B?a1kvT255dFE2NjFheUJXM0ZsTEJ0YXFiRDZuVmk5TE1GOTdrZ0s5c1FUWGVD?=
 =?utf-8?B?MkNBQ0pWRFpzNitNVE9ZOWh0YUZLMzVxbWNEQWVDTXNMNDQ5MnduUzdwL2Nw?=
 =?utf-8?B?U1FlbmtuR2lRMGJrSlIxTWRBbllHakpYTXhkSE00cGdjTVlRcGJ1U0VjMGNN?=
 =?utf-8?Q?Swt4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4241.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46fb297-e93c-424f-a3ea-08dc1807146a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 09:23:06.5736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVqD8wN5Z4FUa203YLa8Twh+dXuPqV5jOR3C2JAtnZLiRD0G+ZLzFbJeRRAGStBw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBK
YW51YXJ5IDE2LCAyMDI0IDM6MTMgUE0NCj4gVG86IEN2ZXRpYywgRHJhZ2FuIDxkcmFnYW4uY3Zl
dGljQGFtZC5jb20+OyBhcm5kQGFybmRiLmRlOw0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
ZzsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAyLzJdIE1BSU5UQUlORVJTOiBVcGRhdGUgc2QtZmVjIGRvY3VtZW50YXRpb24gZmlsZQ0K
PiBmcm9tIHR4dCB0byB5YW1sDQo+IA0KPiBPbiAxNi8wMS8yMDI0IDEyOjExLCBEcmFnYW4gQ3Zl
dGljIHdyb3RlOg0KPiA+IFRoZSBkb2N1bWVudGF0aW9uIGZvciBzZC1mZWMgYmluZGluZ3MgaXMg
bm93IFlBTUwsIHNvIHVwZGF0ZSB0aGUNCj4gPiBNQUlOVEFJTkVSUyBmaWxlLg0KPiANCj4gVGhp
cyBjYW5ub3QgYmUgc2VwYXJhdGUgcGF0Y2ggLSBpdCdzIG5vdCBiaXNlY3RhYmxlLiBBbHNvIGRv
ZXMgbm90IG1ha2UNCj4gc2Vuc2UgdG8gc3BsaXQgaXQ6IHdoeSBoYXZpbmcgaW5jb3JyZWN0IHBh
dGggb24gcGF0Y2ggIzE/DQoNCkFjY2VwdGVkLg0KDQpCZXN0IFJlZ2FyZHMNCkRyYWdhbg0KDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

