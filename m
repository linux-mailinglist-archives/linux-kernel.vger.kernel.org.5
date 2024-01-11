Return-Path: <linux-kernel+bounces-23897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF482B360
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD67B24E55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FE651027;
	Thu, 11 Jan 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="lIVNgVjz"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2139.outbound.protection.outlook.com [40.107.21.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308F50274;
	Thu, 11 Jan 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3sk+/OgtR1rr9hOYuCGQ7vlG/PeNc3+HguJPCh/854oAD8A6tiH0N41+nJDsBE/awYTbmBch1ijm91Q98pS2T+NZA5MktQnflLZAfNhZ63FRmerHHGDWx5+sOriKf8dI+2c63oy0iZ6UlLKiwQkGF2pdvf0TCs+2N+PfgBaOf/YeKo8xaQKnXEWACGkW8nJjU65Xtlj5PEHBNolbmTY4BZOxTZg3wUUduebVsTh2WQmbNXZ8Cpdq/9El5AWohehwehIVpZQPDwWjraLGxpv3lFB+2XK96S5xaT+5sNQTZPtf5ZchuHlAThREYjktsbEcU4/VybQRFF28aWGdl8+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LB9pJkm3CKoSI/QU3sLP4hkPmbhd5NBp9oEI5wyTt8=;
 b=CdNUXLsrHRAofx+4QPQ5yZ0fGogBVA22OoluAEpo7/OZnRLtM5itePyVCAxBoWECQC9lEsqbzaIRdU+FwrAFQ/KpofPHBVx+BN6kqeDv4y56X7lnimw5hf/26I4ICh1JIVAMg7UPo08NnXX3CtD2bHI/Ja2Ww7LmCWUjLwS2fW3qRjYuRRG5Ig3RMo1It/V66g2O+LJ8d3f2ejv2JR+wnIw3R91+pfHam0HDbgYPDs76lxo4lcLfR5TXR42nYnIwPitFF4nLgFfzwNu6lbU6ssoOATG+yeDcIVFvMcxcq7uDEVPQLPoIfyvw2ClB11/jSG51tgdVRyBJml3Z9Aohhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LB9pJkm3CKoSI/QU3sLP4hkPmbhd5NBp9oEI5wyTt8=;
 b=lIVNgVjzMO0iEOQuKJYsMyLa9zarfS/mikl6KXLbCAFA/C7llAb9NlmeQOrZsRmKmmsofCQY8zWtaW8DcmfOeY+bl0VYqrPYzHaWGtk3c8bA/5u3aKTSpezPQYmc+eCKWpmOh2mNDvFsXsc/jEfg221GSNA97gPo9iWsBlh4bF4=
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com (2603:10a6:10:103::23)
 by AS8PR06MB7480.eurprd06.prod.outlook.com (2603:10a6:20b:332::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 16:54:14 +0000
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039]) by DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039%5]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 16:54:14 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 3/3] net: phy: dp83826: add support for voltage tuning of
 logical levels
Thread-Topic: [PATCH 3/3] net: phy: dp83826: add support for voltage tuning of
 logical levels
Thread-Index: AQHaRKoXhlRiE8Hk7k6MCp5S4684SbDU0eeAgAACYQA=
Date: Thu, 11 Jan 2024 16:54:14 +0000
Message-ID: <2ead0e15-c00c-4f87-9f76-f6d329b89613@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <20240111161927.3689084-3-catalin.popescu@leica-geosystems.com>
 <0323cb84-14fe-422b-9423-3b1599f8452b@lunn.ch>
In-Reply-To: <0323cb84-14fe-422b-9423-3b1599f8452b@lunn.ch>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR06MB6332:EE_|AS8PR06MB7480:EE_
x-ms-office365-filtering-correlation-id: a5aa5ebf-d530-4c26-31db-08dc12c5f124
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4Nf5gk8+/BLCqjOv3242LPLs5Sl1/klbgntCNla+wF87ellWFKiE3715EaMdklEgfAGthhoYqFqzwwoK/MgmLg45vpuuW1R3VfsNTJAH5NTSshOh0n1n8zsymrnFJnsma4EViYBxOtPknngUatbsQJT72Q/HgsX21cVLjWiJcC4w9PajMVGbYgGuxJIeglyPsfmnlpopHC1OATt4Z1KHncmQ+T2uXo+gEn1YEoIDWNiA8Y9Y02JaBs3QTRwKNfPmMxvHj5Xl2RvhsFta+P6jo6iXWKdn0eO8g1FiMikn/Mwlfn3OZbulNh7TZ+S0v280D0c3UWDjNiEY/jcmW/Rxn2gWpFATRBX4hwMCXcdUzWsoz9Ol+B/5lXeeifcgBM4XJJ8nblytSed7005cDIKnkX/maiODXLj0Xa3AH6Lq8sJw5cnTnBL1JgAvYNyDIRaW7+2MxDB/ZkTTsWRz7zqde+k5I3AXHmrjeIal4/Ln3zwwRiyulIMirkW05Wqggmp1q/vpoRxXgu5JZULRliIfFROUr2YK9ZUfQ/7HR+ZQE8n+Q4S+gkQBSvQtXWc5cuDI0crLItfIa7ZlED+Dgmnklv2egpmppk4pEPwbaLnC8rFn68tBrw24UBu0F4Ur+jWjHCeLc0F4zr91FdkGzdGl9R375M8jDPp/Rt9BBvtd7BVQ4lhL0jpmTLaB1AZt79fAdY0oPJ6Dalar+NT2OU2KXaVAHsvWn9Lw1xyxbMzQz/4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6332.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(230473577357003)(230273577357003)(230373577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(36756003)(38070700009)(31686004)(86362001)(31696002)(122000001)(76116006)(107886003)(26005)(45080400002)(478600001)(966005)(2616005)(71200400001)(38100700002)(91956017)(6486002)(53546011)(6506007)(6512007)(4326008)(64756008)(66476007)(316002)(6916009)(66446008)(66556008)(66946007)(4744005)(2906002)(54906003)(5660300002)(8676002)(7416002)(8936002)(41300700001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TE11OFMwdzNQTGIxQm5NV1E0d0lGb0x6R2lXYU5PNGZ5Sk1jbkE2UTl6MnYy?=
 =?utf-8?B?d0lBU1Y5NEplZGNZUVpJemZOUnErVHZhZVI3NEtnWVNrSGlIWlMxcTFLRHFF?=
 =?utf-8?B?MWNYbW9QM1RmNDdIMkI4ZklpQmNlR2R2TXpRc1FsYUhNcWg3SmtyQTg1dzZv?=
 =?utf-8?B?cmNleVJKcWRiRURmSWJoZ210UG1mR093Y1dZeUExUG9LOHc4TStQL3RHV3lF?=
 =?utf-8?B?WStFSFFOOGRYZzFNYUE5eWd1aHlmT1VETUVqQjIwN1E5SXFsVzdSdU9NTEoy?=
 =?utf-8?B?NFpQR2orS1lQd0hWL3F6bjdxQm1TUTB1SnRCUThHVEJBaklRbHdCb0ljc2p1?=
 =?utf-8?B?R2UvNUVTcGlzbHJQTWlqSlhpT0x0aFBBdmhudlk2aW9yeFZyN0syYkZSNEFY?=
 =?utf-8?B?aGFJSFM5c1pmbzY3WWRyWEVXczNUMXQrMys5SnNPM3FNZTlRYjZsSnRzdXhv?=
 =?utf-8?B?MjlOek1LdnZMUFB2MlV2MDlZTk9Penh2TlJyREVjczZEVXZsQ1prZWJ4d1J0?=
 =?utf-8?B?SGJnYVd5ZC9NOHBOMmQ2TGtFeUU0WFduajNMRUYrNzdIQ1FJTVRTZUlVQTNz?=
 =?utf-8?B?VWxSVHpzemZHUEJwVWp1bjBFbkk1dFJjdmcxS0FmcjNlTUE3MkJnZ0Z1eW45?=
 =?utf-8?B?MjVwT0lSMVhTb2x6VnRhUHpwTVIyOGtZbVFOUlE3WnNpaGNMMXhRQk5GK0Za?=
 =?utf-8?B?UkRha25QSzErdnd0S0pPRE5hMEUrMjFDVjJncUx1MnlPZVJ2LzF1YWJ0eG5X?=
 =?utf-8?B?ckVlcTVETUpPK0oxRjRMeFBEaDNlaWNkUnVlclZiV1BTanJHNXAzaS9JQmZW?=
 =?utf-8?B?bnNZMmI0eG5TVzAraDNzaDZKTUFSbkkraXFJUktZOVEvbGpUbm1qYWdHKzZx?=
 =?utf-8?B?T3hNeTVCK3NJUitGTzNrTm1MTXBpQU5Ednh2MkxTeHJjRllNV3B6VElhaUJp?=
 =?utf-8?B?cnhkeEVMdndEdmlRNnVBTXUyNzEwZ1ZHNmw3NHRQODBRaVArSjRUR3pRbWNt?=
 =?utf-8?B?Nk00L2ZPVXQ5WXFYLzZlY1dUc3NTaFhtcnBIMWlRMWg3bTFHQXg5ak4zelZh?=
 =?utf-8?B?eDNkd1hFemZneGlWdWNBY0tRMDZYL000dW01UXlUUWl3R2xSczMzVWlVSjBR?=
 =?utf-8?B?cTBySEJ6MDVhRCtpTnlPSjZLT0ExeUpKMkdrOG8vaWRKQWdvS2ptcW4wUmxo?=
 =?utf-8?B?NldkNmhHNCtMclpFRVBvYStkMU93Y2J3VWoxY3cyeStFNTk0bG5GakhoWGJ0?=
 =?utf-8?B?cmhFR1NLanY1VWxmOTFodGxBQzZtaXVlbUFWOERaY08zSDUrL2JKVTVOL0Fa?=
 =?utf-8?B?MkRnSFZQUEFLYzJFY2dwR1N0T3JVandsOEswcDAvQkRWdXpVV1FIQ1JieUVV?=
 =?utf-8?B?b1pCRnlmOWRXdnplR2tCNTJwOGFyekxnWkhxOFRhMFhBQWNMdWN0QWV4Mnpr?=
 =?utf-8?B?U3N1UkVweEdxL2c4OVFSdEZOVEpEdnRsZlVUeHJxR1g5dk82WkhDNS80di9j?=
 =?utf-8?B?dmV4cXJ1MzFZV2VQb2JuQU45WXk0Yy91Zmg2M2FIRWRXek1TSmMwVzhNdERC?=
 =?utf-8?B?VGpNVy9yZWlBMkpOZHhDL0pNZS9vNTQxelNTSWlpWlNMM3JtT2FYSHp3bjMw?=
 =?utf-8?B?Nm5QOG14M0wzeURETDc5QWR6amVGSVI1cGwvdVNlSTk3QVRmMVRUdVg1Y0Nw?=
 =?utf-8?B?VXVvSjBJWkJPTml3bE14R2JidjBCbHJKeDlzbzFkTzVmUllnRkZCQ3ZWVVlI?=
 =?utf-8?B?R25taGQ5dGs4TitpMEJxc2xnMmtSSzNUT01ockxXUzBmOFV6d3JBV0xLRkJG?=
 =?utf-8?B?a0tqNUhDK2JCaVdaNWlndVM2b29aUGNWZjFPeC9MV2pSNHZyOE8yVGFSVDM3?=
 =?utf-8?B?SXBaeUhtMVZML2RyVmdqZDFFRDhmN0d2WWtQZTNQY3hCUUlRVHhhcUVUNmpW?=
 =?utf-8?B?eXlJTzdXbnZpUkpmeGU3QnpmS3ZiWU5VWHV2M0Z5Z2JMV3Jzc3lYV1pBUVlv?=
 =?utf-8?B?M2lvL3BSUFAycHpuYkhRWlllRVBjTnovbFVqeEVkcTZBeERCMm83Q1I4V1J0?=
 =?utf-8?B?TzFtVU5QR3NjdEwyelN4aWJOc1JKcjdLRktsQlNWVDBDeTdROEwvYzRna1N6?=
 =?utf-8?B?RC9ZalY1N0V0TUR6ZDZVbmJWWHA2QTFLUHh4U0lKSUpteWVZVzRTUEdoazUx?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38102C861F950741A7FBFBEBFAE829AD@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5aa5ebf-d530-4c26-31db-08dc12c5f124
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 16:54:14.2966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3Z32fHSWusloU/1NSVKAWBXB58uz+5wKjBePzhcZLeut2hxjK6K+EUfKwwQFExPsCLH5vAzQwTYQlzeSe3Igosv7p2fEtl+T89suw4X91PMaXOtQ/YQHl90FiONf0IJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7480

T24gMTEuMDEuMjQgMTc6NDUsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBbWW91IGRvbid0IG9mdGVu
IGdldCBlbWFpbCBmcm9tIGFuZHJld0BsdW5uLmNoLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRh
bnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4N
Cj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNl
LiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2ht
ZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4NCj4NCj4+ICt1OCBkcDgzODI2X2Nm
Z19kYWNfbWludXNfcmF3W0RQODM4MjZfQ0ZHX0RBQ19SQVdfVkFMVUVTX01BWF0gPSB7MHgzOCwg
MHgzNywgMHgzNiwgMHgzNSwgMHgzNCwgMHgzMywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgzMiwgMHgzMSwgMHgzMCwg
MHgyZiwgMHgyZSwgMHgyZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgyYywgMHgyYiwgMHgyYSwgMHgyOSwgMHgyOH07
DQo+PiArdTggZHA4MzgyNl9jZmdfZGFjX3BsdXNfcmF3W0RQODM4MjZfQ0ZHX0RBQ19SQVdfVkFM
VUVTX01BWF0gPSB7MHgwOCwgMHgwOSwgMHgwYSwgMHgwYiwgMHgwYywgMHgwZCwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAw
eDBlLCAweDBmLCAweDEwLCAweDExLCAweDEyLCAweDEzLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MTQsIDB4MTUsIDB4
MTYsIDB4MTcsIDB4MTh9Ow0KPiBCb3RoIG9mIHRoZXNlIHNob3VsZCBiZSBzdGF0aWMgY29uc3Qu
DQpJbmRlZWQuDQo+DQo+IEhvd2V2ZXIsIHRoZXkgYXBwZWFyIHBvaW50bGVzcy4gUGx1cyBpcyBq
dXN0IGEgc2hpZnQuIG1pbnVzIGlzIHNvbWUNCj4gc2ltcGxlIGFyaXRobWV0aWMgYW5kIGEgc2hp
ZnQuDQpXZWxsLCBJIGZvdW5kIGl0IG1vcmUgY2xlYXIgdG8gdXNlIGEgYml0IG9mIG1lbW9yeSB0
aGFuIGFkZGluZyANCmluc3RydWN0aW9ucyB0byBjb21wdXRlIHNvbWUgcmF3IHZhbHVlcyBmcm9t
IG90aGVyIHJhdyB2YWx1ZXMgdXNlZCBhcyANCnJlZmVyZW5jZS4NCj4NCj4gICAgICAgICBBbmRy
ZXcNCg0KDQo=

