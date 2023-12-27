Return-Path: <linux-kernel+bounces-11765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6AD81EB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830FF1C2215A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744042107;
	Wed, 27 Dec 2023 01:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="h+awIaKd";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="SUTOS0i4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982A21FA3;
	Wed, 27 Dec 2023 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7c0ac4c4a45b11ee9e680517dc993faa-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xS9fbGw9LvoK5+uhW6K1TGrvLwrSLO4nf0Ie/Ul75tc=;
	b=h+awIaKdRpwk5gYoJmXioS9L31TXjt1xNUu3s/1GSB+gfY0yWaejU+rPlLbhRCqK/WoeuhYkJtczJF6py6+0HTndGEgMrG8nFbhfB+MF2MVCfC2ybAed9pdKrn26c6HVygPgB1v5PVR7vM9sl3HZw5DAEK8ZdKOO9GQTw8WCblM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:8dbb1ba9-a46b-4b1d-a590-c28df631d632,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:aede3382-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7c0ac4c4a45b11ee9e680517dc993faa-20231227
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 771129657; Wed, 27 Dec 2023 09:58:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 09:58:50 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 09:58:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7uokhQtqBFihmG5YAh9fsyEqdKQjdDZd9MyJXcrwP857CtfPLbrDaTR1kE25VBLFxQ+WUYNY8/0F8mMWZKL/3qC66Hh7Nis/7H04zlK1NTX4MQhHdbRYfdpD6dgnIN12bXrvnVByInAQmZmsUtR1ibBRCSPrWhexwEBXwAfmCc9hCJz0oHm9PQdtCV0PxVwf6mYzmNCKA5SyLw5kDABQnQxIGiWLto45qrSvTHOWNi+9GFsKIMXgY+ls+1oprFmoYy8sbBhA7yVciJOMaf/azYf24neLjzmw2J1aRyWG12/vyxXJnf9S7GKk39kMBmOwGo3MXmzI8mc+/TkoUw57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS9fbGw9LvoK5+uhW6K1TGrvLwrSLO4nf0Ie/Ul75tc=;
 b=Mj4lk8ulrpo9jZwwDwgfwu/i9s+wvJJ1otcHDHXpf1zQo3UWnugjV2CM+KYWm2UgnouoHenBOIx/CEQWLnnhfa2Uq4Cbbn7egEoER6CQ9Z6JZ01eYCKTGtAVu+h/8yt9JiosYPXzF5YUiFeBXT26cGJKaExW6uafFj85HFwAylbVYn/7bapLDpwKVPeBkBJibkJs8QIZ8bjY9exmLFG64EXwQ59QyJ8aE8yMbj3E+3B0/7HQe1HP9lYHrdUsRHs3OrulX2BDTquImBmKeNw9BVKrxLnI/U4RW5UZiHDmXjQH8wVBOb+qeMXadogqfeOosCj0bEcs9Bq9qzf2tlpovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS9fbGw9LvoK5+uhW6K1TGrvLwrSLO4nf0Ie/Ul75tc=;
 b=SUTOS0i4KwLqc7tjvXq5rGi66vYBNvHrmWj2ZHRy4VdceyuA78SAc9RCfWmrcbf1fb39J4HtYqJ1eCvsFDI4A4lhgTadpvQ1VonGELxiSo3yksihctTk3B4cz2hLk4E7j8oxzV4mMOjgA3zID3BP9JfwnTKKcdXDpRHMq69pzBk=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by OS8PR03MB8962.apcprd03.prod.outlook.com (2603:1096:604:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Wed, 27 Dec
 2023 01:58:47 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 01:58:46 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "mathias.nyman@intel.com"
	<mathias.nyman@intel.com>, =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?=
	<Eddie.Hung@mediatek.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 2/3] usb: xhci-mtk: fix a short packet issue of gen1
 isoc-in transfer
Thread-Topic: [PATCH v3 2/3] usb: xhci-mtk: fix a short packet issue of gen1
 isoc-in transfer
Thread-Index: AQHaMvB1wD6q/z4TXE6LXtv3GtSB6rCxrREAgAq9gQA=
Date: Wed, 27 Dec 2023 01:58:46 +0000
Message-ID: <0268aecb00fc4d77858d5eef644d30b4e3fb4a0c.camel@mediatek.com>
References: <20231220025842.7082-1-chunfeng.yun@mediatek.com>
	 <20231220025842.7082-2-chunfeng.yun@mediatek.com>
	 <2023122033-footprint-impose-9989@gregkh>
In-Reply-To: <2023122033-footprint-impose-9989@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|OS8PR03MB8962:EE_
x-ms-office365-filtering-correlation-id: 0c3abcdc-f964-4d19-d76e-08dc067f5cd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /4j9jRwCbkS6aKMuWho0Uj82AxMsx0qasWxTqHul0zuVPjjtZZ1XCCOXdAYpm6oKMfeDfPpglNtDoLdLqIg2hPeQUBWzjgXbKEwgtChULGsCZyFThyocxPyUWwzgJysy8kaHVI9e7q51E7QLIL0pN//dmm0qxtCn6zwn1wGrmYsyeDOopRJIygrJnHdWFARzKq5Rg9uyDZny+6u1p/ORSpvsJcV1f+YOGW3IeV/cdHyaFge6YvThOKqc5XHvD4vbZhw2lqT0/svbnHMNAK2YVvyE6MfoSrR09Ga9XcFTUCnqaBGQc6hZ0ZLO4G5sMCCn/aQrEx8Fun34ekDsiL+0T+J3TePmNRHE/bjPwTsLDcpOr+NjMT6fBF4ijUzbOnEBO+pCq733Yti9yiJR6ew42Tvjqw4e0yR7jRAJjI/DwGOd6wSxuUmnvo91T1XGJmIE1zGtehNHEk5xNMiwEe6Zt1QV8bbS7GGJG7fdurHxBJ8mntH1jaGmr98byJGczRh823rB0lgGW31Yu0eEJ80oCzYXm35Iik00gdlhQkXjGdhm6KuGDnRAtmF2HntUA8pbHcEHuXYWs+zbY0dEn4D0s2uM+dfZgcE89AkcfBJrCQychUkSZukPN/GIDSDg8u4gS6vd+wpqrzT06g0SIRNGfAwudzKszhy0IY8pQ4cQceoyueRGUn/ruYhBTHvLkXkvLHrmbij9Vn9q00VthdoZtsG9ps6VdhrMBUgJhl7pTOU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(8936002)(8676002)(71200400001)(6486002)(36756003)(478600001)(86362001)(26005)(2616005)(6506007)(6512007)(85182001)(122000001)(38100700002)(38070700009)(83380400001)(41300700001)(54906003)(91956017)(66556008)(6916009)(64756008)(66446008)(66946007)(76116006)(66476007)(5660300002)(4001150100001)(2906002)(7416002)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUlxT0dCNGtuVkJCanRlcHduYXdDWFpVYSszaERBYzRwcmNhdXRQSHRNLzkr?=
 =?utf-8?B?dzJCbTd6czhZNDhFd0VXSXNLS0Z4QUtheXVYQXQwUnpKVFZqb25UbHZCWU5R?=
 =?utf-8?B?S1FacmZmRXJkSVRYTkgrYlFkVGJGaW9BdXlBY0ExY0NIR09xSk5EQUhTVHNL?=
 =?utf-8?B?RGZ6c0hKcnJETkJmOWJNV2YzQXRXcEJRUFloVmROZi9yU1VzeW5oZGdqQld5?=
 =?utf-8?B?VERKbWlwVzhLa3o2OGdmK3JWZWs4R2VydUh6YmRlVGdpN2ZPSnhGcHJuY2Vt?=
 =?utf-8?B?TWJUNVoyNkgzOWVXcVArSGRha0dPMDFMZkVNcUNna2lkUUthYXp3RHRRQXdV?=
 =?utf-8?B?dDJDbzJSZk94dmJPYys2T25jaUp5MlZleHA0dnZXSU5seDg1N1BodUNScWY1?=
 =?utf-8?B?d1YwS0Fibzhhc08yYzE2V3V4di9rVExqTmZpbmM1MFczOEpWc1hOemFEalNv?=
 =?utf-8?B?M3FLUWlrdGlLejkxVUd3Y1BFYkJ0UEFTcThUM0VQOWo3bkVVQm9nNHVCQk1a?=
 =?utf-8?B?R2ZReDZIRUE1Z1JTYVJsQTBRMXc2dG56SkR1bE0yY2lUSDJXdXV1dldjN2t5?=
 =?utf-8?B?b0tHOWYvSTNaanplNklDdTBxZlE5Mk5IZjc2MG84OXV3VFA5S0tlbURnSEhQ?=
 =?utf-8?B?RnU5Y2RTTzIxQXlDeEFva3d6Mzdmbmx2a0QzRU5kWXdYVFljclhhZFdoMjdH?=
 =?utf-8?B?RlZ4Q1hBeFFhck52eDBqNTVxeG8vRnpWcXozQnlRY0xrZmpiaEZEeDEvYlFX?=
 =?utf-8?B?TnBjL3BNN3hEb05TSllSVmdWa29ZYUFrcmpIbCtOYXNpbmN2czJva3AvTE82?=
 =?utf-8?B?NEdRL1FFUWh4aHVrTjlsU0I1YmtZb1VvYTlBTDk2NUdZbm1SL003SEFRbTZC?=
 =?utf-8?B?YTBTWFZJbm9KSzF1bFM0QTcyblF2clg5aHA2aitzeGNOV05yUWo2WDlqSkRG?=
 =?utf-8?B?cUthdjFMbGNGWnhjcG1hc1hwZ0kwdjZYcWFUWkZRTDhJOHBRRWtxenVZMS95?=
 =?utf-8?B?aGhSUDRodnl0aExXR1JyU3VzMk9neWVLUitRZzY3ejZGQ0RqeTZrL3JuWHBL?=
 =?utf-8?B?MUlHeW5YMUlnckdsRFQyK2FRUjBLODdVVkRzdndVVm11bE9WbHlQZlRDcW1S?=
 =?utf-8?B?R0x3V05wakpZU29kcWFHaG1TNzVsczRlTEg0QTk3ZSt0am81U2FkaFEwcHRa?=
 =?utf-8?B?TUdPM0RMWnc0ZFNIdEhTeUJ4dDdhTDNQVGZXRkF3RnByYmROUzBhUlFaWERX?=
 =?utf-8?B?OWVqMkdSeUpUZ0QyNFVBNlVQTDhENVQ0L3ZSNHpHMEJob09OSWhyOWJ0SkJj?=
 =?utf-8?B?SzFDVVdaNEpzSXRSdTRtS2RPb2xsRjdveFRFY3grOGVORGhUR0Jxc0lXZU1K?=
 =?utf-8?B?eitjZGxZQXhDVGZMRTR5NTFUTGVnc2RPUFMxQ0RHNkhxL2VsQmtiOVduNXpG?=
 =?utf-8?B?YkdiN01NUUZaVUVBSWU5TEhhMU1WZkJxckdkT29GbG1yUm1LcnlEOExqdmc3?=
 =?utf-8?B?R0NWUHZJcUI2OEFoM2RHZ2FFZDhJOW9NRC9yZ3BDRFdtbE41Z2k3WE1jZmlz?=
 =?utf-8?B?S0krd1QwUTZPaEMyM1JTWEJvekw5NzZSTW5UeXFVSG84Z3RKVmJ4SE5iMmpV?=
 =?utf-8?B?NFgra0IyT0pBZ2lEK2JYNTIyUEtzVnN5UnJ6NGdOTjJRNEFLQnJPRVhkODZt?=
 =?utf-8?B?bktoU3lhb2N1d1dVWm5wZ0s2TWlEbCtKTysvMk1hNWJIZU93eHkzdldVV0k4?=
 =?utf-8?B?RWVUUWRjVnY4dDVjZHJWa2p0djJFa1hhWVlYYjlQNWxmbWE4azM0M3RiNGx5?=
 =?utf-8?B?Q1dzYnFaaWxtUDlERnRid3NpeGZJK3ZnZ1I1OUdmNENKM1VvWHJHckg2SG5J?=
 =?utf-8?B?OUZPU3FiRDFQc0N5c0p6UkdvVkt4NkVsNXBIQkZ4QTBsZGhSb3ZQZnMyS29Z?=
 =?utf-8?B?b3VzaDVHcDFGYkxsMno4bXI4QVY5dUdEZytVQkY4QmNiK21xSmlqa3JyVG1i?=
 =?utf-8?B?WlRUZEhlM3FhcXdVWlZRSkNYRnVpTGdLTlM0dTNCTGhPbEk1OTVvelhtY1Yw?=
 =?utf-8?B?clg0T1IzeGpjUGIzRHlSd01xZ240Qno2QS8vLzdBaTVkSkxnZGp5L0piRjF6?=
 =?utf-8?B?T2YyUEJOTFhWM1BpWkR5MjM4dmZrbStTU0djYTFkNDc0ZFFqR3NFNTZRWm5n?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE819193752A184C8B514B27FEAB2BE6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3abcdc-f964-4d19-d76e-08dc067f5cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 01:58:46.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bh4Lz8jv/pnHPj+b8xkBQmGKM/p/XZmKgenqmO89Ln1wF16Aq78KlzsDA97JDOcR44SGdsGXAmwaiuj14YP9xLnn+Mwr7IZaSnVkLu7uYuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR03MB8962
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.586100-8.000000
X-TMASE-MatchedRID: gIwa0kWWszLUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCs4D9nSCoJCSmlaAItiONP1fFPlyDwr+135h6y4KCSJcuS/
	2QS3wecpC3bjvSDu957hjJfLddPsSWQuzT0yb1JTHt9VUPuskRiTbbsi+pqSFGlBTV/lBcoB6RD
	UHk3VV1jEE7iuwc84wMepjPHgGLYbr/497FfFvZhIRh9wkXSlFzW2aB1gHHZOUvX/ci5TjspVDZ
	sT0rYWCISf7n2qaXhKRk6XtYogiatLvsKjhs0ldVnRXm1iHN1bEQdG7H66TyOk/y0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.586100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CECCE83361BAB4B27590C374E03CF7318F8E0F90A84A3431B1F34B858DDF68F02000:8
X-MTK: N

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDA2OjU3ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiAgT24gV2VkLCBEZWMgMjAsIDIwMjMgYXQgMTA6NTg6NDFBTSAr
MDgwMCwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+IEZvciBHZW4xIGlzb2MtaW4gdHJhbnNmZXIs
IGhvc3Qgc3RpbGwgc2VuZCBvdXQgdW5leHBlY3RlZCBBQ0sgYWZ0ZXINCj4gZGV2aWNlDQo+ID4g
ZmluaXNoIHRoZSBidXJzdCB3aXRoIGEgc2hvcnQgcGFja2V0LCB0aGlzIHdpbGwgY2F1c2UgYW4g
ZXhjZXB0aW9uDQo+IG9uIHRoZQ0KPiA+IGNvbm5lY3RlZCBkZXZpY2UsIHN1Y2ggYXMsIGEgdXNi
IDRrIGNhbWVyYS4NCj4gPiBJdCBjYW4gYmUgZml4ZWQgYnkgc2V0dGluZyByeGZpZm8gZGVwdGgg
bGVzcyB0aGFuIDRrIGJ5dGVzLCBwcmVmZXINCj4gdG8gdXNlDQo+ID4gM2sgaGVyZSwgdGhlIHNp
ZGUtZWZmZWN0IGlzIHRoYXQgbWF5IGNhdXNlIHBlcmZvcm1hbmNlIGRyb3AgYWJvdXQNCj4gMTAl
LA0KPiA+IGluY2x1ZGluZyBidWxrIHRyYW5zZmVyLg0KPiA+IA0KPiA+IEZpeGVzOiA5MjZkNjBh
ZTY0YTYgKCJ1c2I6IHhoY2ktbXRrOiBtb2RpZnkgdGhlIFNPRi9JVFAgaW50ZXJ2YWwNCj4gZm9y
IG10ODE5NSIpDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+
ID4gdjM6DQo+ID4gYWRkIENjIHN0YWJsZQ0KPiANCj4gV2h5IGlzIGEgcGF0Y2ggdGhhdCB5b3Ug
YXJlIG1hcmtpbmcgZm9yIHN0YWJsZSBpbmNsdXNpb24gKGFuZCBJIGFtDQo+IGd1ZXNzaW5nIGlu
Y2x1c2lvbiBpbiA2LjctZmluYWwpIGluIHRoZSBtaWRkbGUgb2Ygb3RoZXIgcGF0Y2hlcyB0aGF0
DQo+IGFyZQ0KPiBub3QgbWFya2VkIGFzIHN1Y2g/DQpJJ2xsIHJlbW92ZSBDYy4NCg0KPiANCj4g
QWx3YXlzIHNwbGl0IG91dCBidWdmaXhlcyBmcm9tIG90aGVyIHRoaW5ncyBzbyB0aGF0IHRoZXkg
Y2FuIGdvDQo+IHRocm91Z2gNCj4gdGhlIHR3byBkaWZmZXJlbnQgYnJhbmNoZXMsIG9uZSBmb3Ig
dGhpcyBjdXJyZW50IHJlbGVhc2UsIGFuZCBvbmUgZm9yDQo+IHRoZSBuZXh0IG9uZS4NCj4gDQo+
IE90aGVyd2lzZSB5b3Ugd2lsbCBoYXZlIHRvIHdhaXQgdW50aWwgNi44LXJjMSBmb3IgdGhpcyBi
dWdmaXggdG8NCj4gbGFuZCwNCj4gd2hpY2ggSSBkb3VidCB5b3UgaW50ZW5kIHRvIGhhdmUgaGFw
cGVuLg0KPiANCj4gUGxlYXNlIGZpeCB1cCBhbmQgcmVzZW5kIDIgZGlmZmVyZW50IHBhdGNoIHNl
cmllcy4NClNlbmQgdjMgdG9kYXksIGFuZCBtb2RpZnkgcHJvcGVydHk7DQoNClRoYW5rcyBhIGxv
dA0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==

