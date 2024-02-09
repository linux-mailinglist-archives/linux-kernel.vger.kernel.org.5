Return-Path: <linux-kernel+bounces-59506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CFB84F825
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E27282745
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F7A6F07C;
	Fri,  9 Feb 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="EK4MnqSv"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF812E3F9;
	Fri,  9 Feb 2024 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491229; cv=fail; b=u5WQdwBMifb2BH6w+olsNzxfJc4WYK8CArOUb5khiVg2R91XQOnvrzSiRkn7x0c4qoNOpXu9vOr8KUf9j6AboQ1ExLV8umQ+Ulw/zhFuM/KJKG2DMgELi1JmwcnxmLHyOUhIxOi/kavL8Z9ftqMy5mxjrXwyKFodpzOjnrqJ+rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491229; c=relaxed/simple;
	bh=xDwckFIN9iDp8naPw+gtmsC0ARTPz69H9httfZO4wlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JEZmI8JWY2GlIJ0lxa/fkBE2l3Frni3w/TCTpyUoCyOS06U3QMW3Hh5jVqroWwCPwnKD1fPo0UHqPYweX3h97hcuZ2BlAJtQEvdv4x5C+XGiD2UAWX5tCUUiDIhvNVGUQVDhPbYcxjOJHehaQ8iELr0OPicR2vIH/dJXQHamu5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=EK4MnqSv; arc=fail smtp.client-ip=40.107.247.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7VHIhRS1DkpIBUt5WIVxVmQFZBDh2hteUsCE9Zd+Glc/k4XmM3VerYV4doL2AsWZmIDh/8oscIRB3+XHYGKtYTqu3yzk1YsxG89sYcRS6agarMdOLE4IuKfovJRMD3zOnVCp3EBjYYlxyEude6LjV1H75K/olQZbS3ymTyvuyIYB162QuI+TKXsh/IB9rAhzYn5Dc+noYRVsArof4D3eqHM92HP+lP9OroYbc2GHWMnH68uKw84qHikmKWqPo7+qbfSiN/YBBTmx5NmP11OANw1dX6dkf4KppqLFbp63NuTD9hfY7PbKP4ZLHMvxPbZL30kO+Ag6CUMdPUSS4wE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDwckFIN9iDp8naPw+gtmsC0ARTPz69H9httfZO4wlY=;
 b=hab9fVNtshRYI+aNzaGBNlr/Qw2DuvXGvUz8nTa+o9eH1nL/1kzRLlfGDGC8fCpklkK1TPjCGlxUbxTr550Mh7wIE2fSJhI17ZkbFAMJ13NFal9pusk7c6qEn9Kfges8HQuFX/Zoc4dlMJBASjMXvuDrUWH/oAgThTFef+CEknjjH+nH8yT5qpRbospKFxbb2ub1qS9KjtRInMeq4q4IBYA1YnTfSfy1O29MhQo/mdB3WofkLXFnp/wrolJUJJfQsVKaxkbjcetiTbQC4MRbIQbnVl7daAxIC7IZ5BQSF/c+P/ugHDrAAC5pvVuRJgZma8oQofIOO+Pn/7p5DJXCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDwckFIN9iDp8naPw+gtmsC0ARTPz69H9httfZO4wlY=;
 b=EK4MnqSv9I5yjfBCmaEVpq0ie0K5iRZbsTTGGIHaIonAtggox5Frg2uVvytAEPTePghlryWV7XzZi3S4cqrualj4dqj5D/yWdunafNHs10Nq2v79Vjv3EcJOGPZKJTHpFM/eDXpztwb2XbqPYUBev+SnwQGw9eHHMoTsz5vBknY=
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com (2603:10a6:20b:59::18)
 by DB8PR06MB6394.eurprd06.prod.outlook.com (2603:10a6:10:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Fri, 9 Feb
 2024 15:07:02 +0000
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a]) by AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a%6]) with mapi id 15.20.7249.037; Fri, 9 Feb 2024
 15:07:02 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v3 2/2] net: phy: dp83826: support TX data voltage tuning
Thread-Topic: [PATCH v3 2/2] net: phy: dp83826: support TX data voltage tuning
Thread-Index: AQHaW1ScMUJTYtBN+UiGrobW/ra5ALECC+4AgAAQrIA=
Date: Fri, 9 Feb 2024 15:07:01 +0000
Message-ID: <5a15d8eb-d6e9-46cf-9b33-d0a04e01b365@leica-geosystems.com>
References: <20240209123628.2113971-1-catalin.popescu@leica-geosystems.com>
 <20240209123628.2113971-2-catalin.popescu@leica-geosystems.com>
 <00691961-d516-4338-b7e8-203625e561ee@lunn.ch>
In-Reply-To: <00691961-d516-4338-b7e8-203625e561ee@lunn.ch>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR06MB4705:EE_|DB8PR06MB6394:EE_
x-ms-office365-filtering-correlation-id: 639b2d91-9590-4374-54c0-08dc2980c51b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uMhKjPKe2lOXL9VPDX3dYjB98qeArtPINHyizUBT1Ct3cRFl69OsTj99cAAR4ZO1PDx45wBQHPtYlRwvn9tivDP3wP445EZY2PSsHwrsk+XOKE8w+uw2gvE6q8AgBmfCGhJDnwZY9nj8L6twobHYbVgrvLfco0Luc5pJKvz3HxNtea9tZbvCIhQ6SZoGNSilZi3ftmO2DF80ankiIaEw2SDBzR+JlYdV4jXco7hv0jo4bcqYtzgc2K05wLi6aijzEmA8O5fPTJ0fwWnjuu85ERsBOfbiB4OvkJDYMyz3XO9G3V0Z+33+PEYxc+v6EtCmQbxFIoqam8kuZ1qo/pgpyqUGE3XPeLV5xZUdiP5Nj7fZx5v5hHP6+sqLAVUKDrDDqA1AY26hAcPHWo1ieHFj3wWz11EPFonAVrQSate/PM9t/fcntGBTHzI3SIdfmLsntpIaJpdaCM/4wPetG16/dNamLb0Mi9+FY8/qU4vUOiRxJ0kssqc0fCEFtGz2ckiar1k582T3a2IBZ5zE8FS8Yt0iORrX5LDTBL++OFF/r7c2nfYhsbtnwLyzAfdDEI/UArih+zODZD7eDZ34dO3/KMnx6GoC1rnApmx3m+FsFdMFaWX4GxJwB/ENJebOHenm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4705.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(31686004)(41300700001)(966005)(6486002)(53546011)(478600001)(71200400001)(45080400002)(38070700009)(66446008)(6916009)(66946007)(76116006)(54906003)(316002)(64756008)(91956017)(66476007)(66556008)(5660300002)(7416002)(6512007)(26005)(2906002)(2616005)(36756003)(6506007)(66899024)(86362001)(8936002)(83380400001)(122000001)(38100700002)(8676002)(4326008)(31696002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTFsWnE3UDN6Y3Rya21SVmEzRHk1KzY3YloyMFhGNGc5QnJaRUI0NVc2Zjcw?=
 =?utf-8?B?eWlqbVhHd3JpbUFmdis0TUg5SklOekgwOGU1bkNxelUzdFdOZEcyZ1dZcmJu?=
 =?utf-8?B?R1lERm9jT3Nab0ZHeFVMWkxRdjh3MHRSMlNFdTExUENDOXpDSmtqaHVla2JR?=
 =?utf-8?B?dG1yTlNOVko3L2lQQmhDQmRNRVZSRXlKRU9nZm5OaE42ZVdwdGdxdjh3c0pt?=
 =?utf-8?B?bGd0YnBnWjBuQTEzWlVYemw5cG9CK3U1OVF6TWU1d014UnYySy9PYUI3ZFVB?=
 =?utf-8?B?T0hXRVpzTlVGSW11cUxpVDV5MUVmVVVZbkdmNUE4NERpdlhEYkg5VjhZWlJz?=
 =?utf-8?B?SmUySm1CZUVrUlFTVDFZRVdvTnB1U3E1UDFZSGFHTmJXeGE4ZS9pVWN4VnhI?=
 =?utf-8?B?dFE3OWx0Ti96RlRhdEhYM3hvVTRqN1d0eFZCdTJ3QVk0K0d0amhFQ25pSU9j?=
 =?utf-8?B?ejFZakFYVURBbEZpemo5bDFhdzBRa2ZSTmlKS21GVlRXKy9QUGJkUHlMTDlh?=
 =?utf-8?B?TTJQU1JKL21oMmNFYXFwMExTeWRoV21TRTJFWkJ5Mm5TZlFIVjhERnFiQzF3?=
 =?utf-8?B?c3Fybko0eUdmNDdvQWFOM0cxZUVPL092ZmVnRHRUY003WVRNbTRqSFFNNWhu?=
 =?utf-8?B?TklTWG5tQlNCVGVZdTlOL3QzOXFmWk1GWUdrbmNKa2NCRWluU0N0a3gxQS9w?=
 =?utf-8?B?SXpROThDQUlVVWk3S1R4MkoyRjRPSzFvQTVGd1oyYWs5QWxVTDJOR3FGZTNn?=
 =?utf-8?B?L1czMTdLaHFsS2JOUXpvWkhhTExQa1lxOGZyZE1jUURHcks1aG02NlNwektx?=
 =?utf-8?B?MzIwUEEwME13SWtxRHB4WDRoUWtnMEtJQzBPYm11Z2pxSmlCbGNBbHYzWlVy?=
 =?utf-8?B?OThoR0tzN3NhQ3J5d1RsSmVOUGZkc2l4NThoOUU2RUxiVHhkdFlxOU9VWEVx?=
 =?utf-8?B?ck1YY2RjWWt6a2tnVUJ2WGdLc2creXVPT0d5ZE1QSzZoczZnL01Ma1F6eVFL?=
 =?utf-8?B?UDl2bDVUbjh2ZUlmaldzQ3NQK0tHYVFGV1p2eVo4NjlUUHhkV2RRam5LTHNr?=
 =?utf-8?B?TmtyaEpnWmFiV1ltWUh6VitKaWlLVFdWbXVoUkNXb0t1eXNTTXpOUC9kbk1l?=
 =?utf-8?B?ZTFDc1RWTVpKdklwMHIzanUzMXdIZk0xM21qTHhycE5EWDZGalpGN1dBWTlD?=
 =?utf-8?B?Smt0aFM4aE5CSWxDR0RlRUlVN0g2ZStCRm15c05QREYwd1RWYVpUcWpaRnNG?=
 =?utf-8?B?N2t3TEpoRkdIK3VEbFkzamhzcmo4SHlZSWhXd0RLeitKWDczRWxQdld0eFUr?=
 =?utf-8?B?TmtXWDJ2K2trTnBwQjcxS0V1eVgwTzZJdjhFbFNVc1dhS2gvM0t3ZEUvSWIr?=
 =?utf-8?B?VUlnM0xoeVhXSTdTdUh0MjRCWDJtejBJOXZXUUtQcWJKc09uK3M5N3VsUElQ?=
 =?utf-8?B?cW9NR2hnYnArVXdDT0Q0L2Z3SzNMU3lacnhtRTdQVDU1Si8yS2dReG5lOEl6?=
 =?utf-8?B?RWJBK1RYQ2tNVGJYQyszOWFSeFpMU3lJS0xXN1BZZFltQTNTdzZlcU1JLzdo?=
 =?utf-8?B?alBYSi9qVmRzdWdZaXdIazRrbVVtZXZsVHFpOW13WjJzaEhOK0RJR2FkL0RV?=
 =?utf-8?B?ZmF5bk5VUDBkbjN0SmxkRDFzamtwbm13SnBJL0MvRWEvRlZNR1hpQ045NWJF?=
 =?utf-8?B?aUdaMWZvUmVBOVROeHF2OGRqT3hxSEJqVmFUdWo3TFJaa3FqWDlsMWRSdUxm?=
 =?utf-8?B?bXFVT25hb1JCQm8vRUhMcUd0WDJvbXN5NUljSklONmE1cFhiZCtKanI0WHRD?=
 =?utf-8?B?UXlPNk9oUi8rN0tlQklmcmVWVENhWThtNHc0QmdScHJlYU9ieHVjLytyYmxI?=
 =?utf-8?B?NmZqc3d5ZzQzSU8wd3kwb3hMN3R3eTd3Zmpkb256NHh2NDY2Nm9HbENCWjhp?=
 =?utf-8?B?VnFwUHhPamx0VXZlMkRMMDFEbnIvNFJKZTZYUW5JYXJIcmRxL0N0UGZtam5z?=
 =?utf-8?B?ODkxU21na1V1TmxQZjM1N01oVG5rVkxXb2VoeDArR3B5M3BQY05JNmxFR2U3?=
 =?utf-8?B?TERtOFJYOVZOaG5sSjNXVUVuK0pJam55bS9IVjM4SndzNXVNZ09uRWpMVmds?=
 =?utf-8?B?VU42US8rd2p6RXQwM3lNWXJSWFdkRWRrZjVYeER0U3BNbFppeFhBbG9PcEhG?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB12F6F393A9F14EAB16541B940130AB@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB4705.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639b2d91-9590-4374-54c0-08dc2980c51b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 15:07:01.8977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m74egEVvfjPQv/YAJdy/KRH16ZadK3j4PWPt37iajOc9juJe64pKJi/oJQI/ZwnHGK1/ZX1uUFEozAF2Yn9uBUt8N2OsHprx+YGD9cM7wX0Ar/rdauOf2d8IB5iJ0uky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6394

T24gMDkuMDIuMjQgMTU6MDcsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBbU29tZSBwZW9wbGUgd2hv
IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBhbmRyZXdA
bHVubi5jaC4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xl
YXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IFRoaXMgZW1haWwgaXMgbm90IGZy
b20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJlIGNhcmVmdWwgd2hp
bGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9yIHJlcGx5aW5nIHRvIHRo
aXMgZW1haWwuDQo+DQo+DQo+IE9uIEZyaSwgRmViIDA5LCAyMDI0IGF0IDAxOjM2OjI4UE0gKzAx
MDAsIENhdGFsaW4gUG9wZXNjdSB3cm90ZToNCj4+IERQODM4MjYgb2ZmZXJzIHRoZSBwb3NzaWJp
bGl0eSB0byB0dW5lIHRoZSB2b2x0YWdlIG9mIGxvZ2ljYWwNCj4+IGxldmVscyBvZiB0aGUgTUxU
LTMgZW5jb2RlZCBUWCBkYXRhLiBUaGlzIGlzIGVzcGVjaWFsbHkgaW50ZXJlc3RpbmcNCj4+IHdo
ZW4gdGhlIFRYIGRhdGEgcGF0aCBpcyBsb3NzeSBhbmQgd2Ugd2FudCB0byBpbmNyZWFzZSB0aGUg
dm9sdGFnZQ0KPj4gbGV2ZWxzIHRvIGNvbXBlbnNhdGUgdGhlIGxvc3MuDQo+IE1heWJlIGknbSBi
ZWluZyBuaXQtcGlja3kuLi4uDQo+DQo+ICJUWCBkYXRhIHBhdGggaXMgbG9zc3kiIHNob3VsZCBw
cm9iYWJseSBiZSAiVFggZGF0YSBwYXRoIGFzIGZhciBhcyB0aGUNCj4gUko0NiBzb2NrZXQgaXMg
bG9zc3kiLiA4MDIuMyBwcm9iYWJseSBkZWZpbmVzIHRoZSB2b2x0YWdlIGF0IHRoYXQNCj4gcG9p
bnQuIElmIHlvdSB0dW5lIGl0IHNvIHRoZSB2b2x0YWdlIGlzIHRvbyBoaWdoIGF0IHRoYXQgcG9p
bnQsIHlvdQ0KPiBhcmUgYnJlYWtpbmcgdGhlIHN0YW5kYXJkLiBTbyB5b3UgY2FuIHVzZSB0aGlz
IHRvIGFkanVzdCBmb3IgbG9zc2VzIGluDQo+IHlvdXIgY291cGxpbmcgYW5kIGNhYmxlIHJ1biB0
byB0aGUgZnJvbnQgcGFuZWwuIFlvdSBzaG91bGQgbm90IGJlDQo+IHVzaW5nIHRoaXMgZm9yIHJh
bmdlIGV4dGVuc2lvbiBieSBjcmFua2luZyB1cCB0aGUgdm9sdGFnZXMuIFllcywgeW91DQo+IG1p
Z2h0IGJlIGFibGUgdG8sIGJ1dCB3ZSBzaG91bGQgbm90IGJlIGVuY291cmFnaW5nIGl0Lg0KDQpJ
bmRlZWQsIHRoZSB2b2x0YWdlIGRyb3AgKG9yIGxvc3MpIGhhcHBlbnMgYi93IHRoZSBQSFkgYW5k
IHRoZSBjb25uZWN0b3IgDQooY291bGQgYmUgUko0NSwgTEVNTywgZXRjKS4NClRyeWluZyB0byBy
ZWZvcm11bGF0ZSA6DQoNCkRQODM4MjYgb2ZmZXJzIHRoZSBwb3NzaWJpbGl0eSB0byB0dW5lIHRo
ZSB2b2x0YWdlIG9mIGxvZ2ljYWwgbGV2ZWxzIG9mIA0KdGhlIE1MVC0zIGVuY29kZWQgVFggZGF0
YS4gVGhpcyBpcyB1c2VmdWwgd2hlbiB0aGVyZSBpcyBhIHZvbHRhZ2UgZHJvcCANCmluIGJldHdl
ZW4gdGhlIFBIWSBhbmQgdGhlIGNvbm5lY3RvciBhbmQgd2Ugd2FudCB0byBpbmNyZWFzZSB0aGUg
dm9sdGFnZSANCmxldmVscyB0byBjb21wZW5zYXRlIGZvciB0aGF0IGRyb3AuDQoNCklzIHRoaXMg
bW9yZSBtZWFuaW5nZnVsID8NCg0KPg0KPiAgICAgICAgQW5kcmV3DQoNCg0K

