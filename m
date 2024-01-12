Return-Path: <linux-kernel+bounces-24411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CE782BC34
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6CE8B24E61
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894D5D75B;
	Fri, 12 Jan 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FgTQsiKf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="k5GtEtYE"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB985D73E;
	Fri, 12 Jan 2024 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f52e51eab12111ee9e680517dc993faa-20240112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6lbmgbTAS7XJ67sF4PQV1B73RjbDtxh++4IhiQvU5mE=;
	b=FgTQsiKf5IQwGUL8Avr9TSJzWSRkZQQvZJ9dpFf/j5rJkxOAzMOZiLt9R8Rxm/oxbPj1qsgCle49RhjcaoJ6gctMDJlht2nUL3r5iyHUA7pO5v7v7fTX6dSbOiKPyhAVYBQjlX0Hr+AxKh561UPIyEW4VL5ELk6rc+Y+/eLkoW0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:3a5314be-f765-4d81-9312-9dc1e29c9a82,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:7c8dc682-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f52e51eab12111ee9e680517dc993faa-20240112
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 50760231; Fri, 12 Jan 2024 16:09:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jan 2024 16:09:48 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jan 2024 16:09:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Prguz68q3LjCG9MqgqPWdGPbNzCBn2P/2gZm7uQceYxMUXRMsv+wWmfEM95BW7dPArAvhOWXeP8j8jGMqplXGZd+HC3IMhpPkouj5rq3zkuJXAWRlC38gSKrl/V+NElUY8RJw5IGuxCyTtVFQiAzzIvR8RXmGqh1ypZdIU8M/s7Z7EUEF5KPG2YjuMF7i60IFPeGxEqYzMNkHwEKxN2/L1Ezwa+Qsw1InPaCPiSU82bDl9cFxW6LBzdeZqiC2aGYepw2vTT+RnK92yoOtlgJtw++BsbY8zK6TVBk5/8wauUQRZetJQGz5o6l3Uq+b4rHdOnSmXlMAZ5b+omTB15Jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lbmgbTAS7XJ67sF4PQV1B73RjbDtxh++4IhiQvU5mE=;
 b=Ukaapa/0QWAf/0zrnLasg/hXlrXIBwI5yp6rrke+3mCPo9wJj7ysDF9frZhUVmHR6ew3VWx5DYEO2kvfBKPY/UfqQCjRf9/sFePRjvyaqTy9owktiJDf2QUI2Yfxad4+yb8YET0mns/qsrcFn0Ob+14IANfIc22kCyqZCmd3sebnKbWKWYfJ3YyGpz2hHZlwEoWvnVjL8UJ+0RKTjV2Wr5khvtZGlHbPvVpAa1hHdjTELn9EI8+guhXMBlMIo6A1exUQoSWjHOD2F1GLl7ojRzEKeTMi+5k+6ixjiOgCfYvVebCE/v/Yi/xXIf2/aBV99xmnBgC4r8Vs3m4kRLJfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lbmgbTAS7XJ67sF4PQV1B73RjbDtxh++4IhiQvU5mE=;
 b=k5GtEtYEtDKb4meykYgne0n5c6RltrINbbh/hsxQujPExJMDm0mwc3gcRIt/xNGqzt/sRUnZTQ0JDHAGOBca0W8p1EaRZShP7mcB38KJep+xWvhZcNEjA13+ffNJHfAYdGCwU5h8bOuVQpQlr7drjzC4Vi0m8BTMX+9q82hE7h8=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB8120.apcprd03.prod.outlook.com (2603:1096:820:100::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 08:09:45 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%5]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 08:09:43 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: mailbox: Add mediatek,gce-props.yaml
Thread-Topic: [PATCH v2 1/4] dt-bindings: mailbox: Add mediatek,gce-props.yaml
Thread-Index: AQHaQ49X0JF8UrUl6UiOk1onHkz4dLDVyIqAgAANuwA=
Date: Fri, 12 Jan 2024 08:09:43 +0000
Message-ID: <8e77cfc85ec9b6da9794f988ddc3736cf299388d.camel@mediatek.com>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
	 <20240110063532.14124-2-jason-jh.lin@mediatek.com>
	 <f9301f2c-8996-41ee-903a-372411e1d6f9@linaro.org>
In-Reply-To: <f9301f2c-8996-41ee-903a-372411e1d6f9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB8120:EE_
x-ms-office365-filtering-correlation-id: 23e269bf-5000-4fcd-c354-08dc1345d5a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7CaU/TD+twne+Ox3snr1IX38Mec9BV/5YqSkP6MhP1EytXb2QA5QYInpt44akeDhueicIQhJ6iuRSzxq7GPhLq6Z/uh8r933StPKsZqFvXXw84pg/mnkv8oGGxIHuefb+RKMvT8GZZfhTdf7q8K3Vy7iaMJgLv4hNFOcmxNtElLz3TtU2wroZfTvESnH2f+ihCgikTvQdBYyhP++gENThOJ4DLIV/oyutYsJRqOEvwW7vVBm0gOFinl+ym6/urWirsfZ1kiCyrQEDOWCBU8+RGPH0TSoJJVyCKH/NRKIPPEIjwV/94z6DVhDBPGqk5bN6qcs1O13/qiBPSKwYgfr5mql3o1gnC5o8ju7GJ+qUyPlVC27IqAbKVj/ATZSh8E+9Doq8sFCcxc9RX6fEAOsR74BYdMzYXlkYC7r5YDFGYPQaL5F49W/98nmQoUNICGB6XkmGbr6t5vKGXePVY3XJ9kNDSf5RyLjMlIDLw5XUQqQ9o82IRkIRI24oC6+ikjSFSsonamqq0TZgVyQzeu/ixIJBnm8ptGpld8qRSgjnxyjFMhyEGOouBSWEmnwZ2VeoD5sZK4md5novR/lXQagJk/h4CEQy20zFYHFHXfr+iSY7W2YzykGIkqALHeTr/YNwn+NdoupxTAD7Pci4eJP+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(2616005)(26005)(71200400001)(41300700001)(38100700002)(66946007)(66556008)(122000001)(66446008)(76116006)(54906003)(66476007)(64756008)(6506007)(6512007)(316002)(7416002)(5660300002)(15650500001)(8936002)(2906002)(8676002)(91956017)(4326008)(110136005)(53546011)(38070700009)(6486002)(478600001)(966005)(36756003)(86362001)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0xuQ2htNXk3NHArbmdZcHdsS0w0M1NDcy9KTVJqbHdGNlRtM3dOK0J6OExv?=
 =?utf-8?B?Z2FQZmxucWtlUGF5WHVOZGV2U2xsajRTR3daQklwZ1k2UlVhY2doRzlUa3RZ?=
 =?utf-8?B?UU1rMk5TUUN5MkVWMmFoUEc0QVJjTU1nKzBXT0FzUXpZUWNrZFFXdG9yR1cx?=
 =?utf-8?B?YTY0TDBMMkNYRkh0eHpSYWJNMCtkS094dHRKZVg4djlrZ2Q4MThaS2JCSW5u?=
 =?utf-8?B?cWRzMVgrWU55bmd1N2RNVUUvVnZCWEFsTzJodUtEa0hwWEJEVHBIRzZKd05x?=
 =?utf-8?B?b0duZUI5dXhXMitKa05STmM2OGdtOVYvVStnZVhtRmM1ZVNIc0RqYVl6WlBJ?=
 =?utf-8?B?N2U5QmpSZVdxWXVNTFdzSTFwWENmeUtpdmNoTVd5Vm5XcWpkZlhWdmlNbHd1?=
 =?utf-8?B?aXhUTzU1MXRRU0FKL1pNRkd6aHQzTERSSXFtK0FiQWljWWIydkRjV3lVTVNo?=
 =?utf-8?B?MC9IZG1YaXlCRXRrWUV4YVU2eE0xOVN0Z2JGckFOejNxMVpWem16MWg0MEVw?=
 =?utf-8?B?czdoQ2p6M29EYXYwbkovSENBRmNUellVYWtwS1RTanJIdnh6WGFjV2cyZmRR?=
 =?utf-8?B?SUM4RS9lMDBINDRUZ3lPbXdnWTJGSzhjaDg1QUt4TVRXelVuTldyT2gxM0cr?=
 =?utf-8?B?RUNwOFNpbWsxV0p1VVhuRXRzWmc5OWdGWWZMbUUzSnBQUnhTV0RlNzR2L1Mz?=
 =?utf-8?B?YUk1WldSK2h0eUZVWGxFRG1QbFJuTWJWbGIrc2txMGg1Q3FBS1ZFOXk2bTdh?=
 =?utf-8?B?SnM0NWw1TC9tNVpDVDZ4WEV0WjRpYjcwR0c1a3pQT1k5V3MvcHVGTGFadW1G?=
 =?utf-8?B?OFR2UW5VS2p0cW4xTlZRUlBRVnFKbTM1MWlwYU9UWEszT1hlSURDdWd3Y2V0?=
 =?utf-8?B?K090NDZDYndNZjRZb0RyN2hvUGVEdEptV1hEaFRpL3Vya0kxdXdnV2JrQlBr?=
 =?utf-8?B?RDVTQTEvVVJWQmsvTTJYT0pZdmpDcXJXb25WejlidjlUZ2dEZ2Z5ODAybkZ2?=
 =?utf-8?B?TzhsWExKZkhveEV2R01nMm9mUjR6bWphdUJUNWlTOFFWYUpBeGJnZERIY2ZD?=
 =?utf-8?B?RGk5OHF5bnNPdWhaTTQxcE5PUUtWV1poV3JZVXR1MlNKeCtKUWhXK1JpSStC?=
 =?utf-8?B?U0lkOGduS2lpNHpXdUhsZWgvRUhZSHhlZHl4OUlYTHAwMW9UZjJIMVQ2RWo0?=
 =?utf-8?B?TnNQWVcxZGtBRnpXekxpK3lSK01vZ1IxK1VJTVZoUmVHN3FrMmxjRXdDdzg3?=
 =?utf-8?B?QThnREJZRGd1cmxrclltRzNwVllXVmY5Vk03eEFPL2x4K3VzWFFaSmI5N0du?=
 =?utf-8?B?M09pb2tBdkExNGswdG9xQmUrYTNKTTl5ejhaalJ1bFpFS3BTMWJLdjhsSHpr?=
 =?utf-8?B?dEI3QXNhUFJOa1FHRXB6K1VCR21ISm00ZndCeWpYVlJEa2RsTGRlTEVLUW5B?=
 =?utf-8?B?L2h6RkhqZFhIdldndGlneFkrNktoZ1lyemg1dWtEdm9ybmVuaDBnMnNwbW9j?=
 =?utf-8?B?Mnpidkw3aFF5dERoRXc5cXpWckpsQm5nazZQdW5Fekp6YU5XZVVtRUd6MW1w?=
 =?utf-8?B?dVptelF3enBBZHRlUm1Oa2pYRHpRMHhpOForWXFibytsRUtXM0hiRDdpWm03?=
 =?utf-8?B?UjkrV3dRZ1lIRitUV25SZ05iN05vQjVxY3lUc1BBRk5QY0E5dDIvZEZDREFt?=
 =?utf-8?B?NEQwMVVaSnJTbHJnbnZTUGhCbGFTczJsalVMdS9QamRWUzJwMmJyOVpVUEp0?=
 =?utf-8?B?RG9ObDgrUkJVYVF6NkFHTnlmdTlpMXczeFhaaEJJRjUwVVovU0dlTGkycXFt?=
 =?utf-8?B?OXNFTFZqK0NSRkZJUDIwNUVQZVkzN1NySGRnSG9pUk82bFVzZW1JSUEvZTJP?=
 =?utf-8?B?MmZCRjlTUXdNZnFJWG11WEtHUTFsZFNybGY4dmt3VWV5ZVBPTWFPLzFWSUZy?=
 =?utf-8?B?N1MzSlZIWFF1RlJUV2dRbTFkdjluS0M0YzRkRHRLY0RhTUdqR2RFd3Jpa25H?=
 =?utf-8?B?MDZmL1pIUEhkVVluaHdXM1lEQjB1Qi9FdUUrTkRoMWMrSStNRU5oUXlOaFFR?=
 =?utf-8?B?MFVnS0g2ZUlSSExDYXo3dEd2U3licVE1UWhLcUx0cU9XM1loK2s1VEkwWEdh?=
 =?utf-8?B?Z1piSmsvTGJqTXArcm1GZGh1UUFNcWVmZnJMYnViSVRqMGFHRVRmaUVKampW?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <819AE56B094F354A9217A99A194EA0B5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e269bf-5000-4fcd-c354-08dc1345d5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 08:09:43.7092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFO8HGXazLw/nAm6BqpgfiBQ65jwsANMGl9Q8xTAHWIPzfydl4YVLCn07L3gEEohFu2qsEUlDVG7oC6ex0OyB2VWx4WgFRzAI3FUbeJyajo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8120

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBGcmksIDIwMjQt
MDEtMTIgYXQgMDg6MjAgKzAxMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiAgT24gMTAvMDEvMjAyNCAwNzozNSwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IEFk
ZCBtZWRpYXRlayxnY2UtcHJvcHMueWFtbCBmb3Igc3BlY2lmaWMgR0NFIHByb3BlcnRpZXMgZm9y
IGJvdGgNCj4gPiBNYWlsYm94IFByb3ZpZGVycyBhbmQgQ29uc3VtZXJzLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwg
IHwgNDENCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDEgaW5z
ZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0DQo+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxi
b3gvbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2UtcHJvcHMueWFtbA0KPiA+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5hYWM3NzZiNzRlODgNCj4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21h
aWxib3gvbWVkaWF0ZWssZ2NlLQ0KPiBwcm9wcy55YW1sDQo+ID4gQEAgLTAsMCArMSw0MSBAQA0K
PiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNs
YXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IA0KPiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9tYWlsYm94L21lZGlhdGVrLGdjZS1wcm9wcy55YW1sIw0KPiA+
ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMN
Cj4gPiArDQo+ID4gK3RpdGxlOiBNZWRpYVRlayBHbG9iYWwgQ29tbWFuZCBFbmdpbmUgY29tbW9u
IHByb3BlcnRlcyBmb3IgYm90aA0KPiBNYWlsYm94IFByb3ZpZGVycyBhbmQgQ29uc3VtZXJzLg0K
PiANCj4gVGhhdCdzIHdheSB0b28gbG9uZy4gUGxlYXNlIG9ic2VydmUgY29kaW5nIHN0eWxlIHdy
YXBwaW5nLiBKdXN0DQo+IE1lZGlhVGVrDQo+IEdsb2JhbCBDb21tYW5kIEVuZ2luZSBDb21tb24g
UHJvcGVydGVzDQo+IChwYXkgYXR0ZW50aW9uIHRvIGNhcGl0YWxpemF0aW9uKQ0KPiANCg0KT0ss
IFRoYW5rcyBmb3IgdGhlIGZpeGluZyB0aXRsZSB0ZXh0Lg0KSSdsbCBjaGFuZ2UgaXQuDQoNCj4g
PiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gSG91bG9uZyBXZWkgPGhvdWxvbmcud2Vp
QG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFRoZSBHbG9i
YWwgQ29tbWFuZCBFbmdpbmUgKEdDRSkgaXMgdXNlZCB0byBpbXBsZW1lbnQgYSBDb21tYW5kDQo+
IFF1ZXVlIChDTURRKQ0KPiA+ICsgIGRyaXZlciB1c2luZyB0aGUgTGludXggTWFpbGJveCBmcmFt
ZXdvcmsuIFRoZSBHQ0UgaXMgYW4NCj4gaW5zdHJ1Y3Rpb24gYmFzZWQsDQo+ID4gKyAgbXVsdGkt
dGhyZWFkZWQsIHNpbmdsZS1jb3JlIGNvbW1hbmQgZGlzcGF0Y2hlciBmb3IgTWVkaWFUZWsNCj4g
aGFyZHdhcmUuDQo+ID4gKyAgV2UgdXNlIEdDRSBNYWlsYm94IGJpbmRpbmcgdG8gZGVmaW5lIEdD
RSBjb3JlIHByb3BlcnRpZXMgZm9yIEdDRQ0KPiBNYWlsYm94IFByb3ZpZGVyLg0KPiA+ICsgIEEg
ZGV2aWNlIHRoYXQgdXNlcyB0aGUgQ01EUSBkcml2ZXIgdG8gY29uZmlnZSBpdHMgaGFyZHdhcmUN
Cj4gcmVnaXN0ZXJzIGJ5IHJlcXVlc3RpbmcNCj4gDQo+IGNvbmZpZ3VyZT8NCg0KWWVzLCB0aGF0
IHR5cG8gZGlkbid0IHNjYW4gb3V0Lg0KVGhhbmtzIGZvciB0aGUgY29ycmVjdGlvbi4NCg0KPiAN
Cj4gPiArICB0aGUgTGludXggTWFpbGJveCBDaGFubmVscyBpbiB0aGUgR0NFIE1haWxib3ggQ29u
dHJvbGxlciBpcyBhDQo+IE1haWxib3ggQ29uc3VtZXIuDQo+ID4gKyAgVGhpcyBiaW5kaW5nIGRl
ZmluZXMgdGhlIGNvbW1vbiBHQ0UgcHJvcGVydGllcyBmb3IgYm90aCBNYWlsYm94DQo+IFByb3Zp
ZGVycyBhbmQgQ29uc3VtZXJzLg0KPiANCj4gTGFzdCBmb3VyIHNlbnRlbmNlczogYSBsb3Qgb2Yg
dGV4dCB5ZXQgYWJzb2x1dGVseSBubyBtZWFuaW5nLiBJIHN0aWxsDQo+IGRvDQo+IG5vdCB1bmRl
cnN0YW5kIHdoeSBzYW1lIHByb3BlcnR5IGlzIHNoYXJlZCBiZXR3ZWVuIHByb3ZpZGVyIGFuZA0K
PiBjb25zdW1lci4NCg0KT0ssIEknbGwgYWRkIG1vcmUgZGVzY3JpcHRpb24gZm9yIHRoYXQuDQoN
ClRoZSBtYWluIHJlYXNvbiBpcyB0aGF0IHRoZSBwcm9wZXJ0eSBpcyB1c2VkIGZvciBHQ0UgSFcg
ZXZlbnQgSUQNCmNvcnJlc3BvbmRpbmcgdG8gYSBIVyBldmVudCBzaWduYWwuIElmIHRoZSBwcm92
aWRlciB3YW50cyB0byBnZXQgb3Igc2V0DQphbiBldmVudCB2YWx1ZSBvZiB0aGUgZXZlbnQgSUQg
Ynkgb3BlcmF0aW5nIEdDRSBIVyByZWdpc3Rlci4gSXQgbmVlZHMNCnRvIGtub3cgd2hhdCB0aGUg
ZXZlbnQgSUQgaXMuDQoNCj4gDQo+IEFsc28sIHdyYXAgYWNjb3JkaW5nIHRvIExpbnV4IGNvZGlu
ZyBzdHlsZS4NCj4gDQpPSywgSSdsbCBzaHJpbmsgdGhlbSB0byBsZXNzIHRoZW4gODAgY29sdW1u
cy4NCg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBtZWRpYXRlayxnY2UtZXZlbnRz
Og0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIEVhY2ggZ2NlLWV2ZW50cyBpcyBh
biBldmVudCBpZCBjb3JyZXNwb25kaW5nIHRvIGEgc3BlY2lmaWMNCj4gaGFyZHdhcmUgZXZlbnQN
Cj4gPiArICAgICAgc2lnbmFsIHNlbnQgdG8gR0NFLiBUaGUgZXZlbnQgaWQgaXMgZGVmaW5lZCBp
biB0aGUgR0NFDQo+IGhlYWRlcg0KPiA+ICsgICAgICBpbmNsdWRlL2R0LWJpbmRpbmdzL2djZS88
Y2hpcD4tZ2NlLmggb2YgZWFjaCBjaGlwcy4NCj4gPiArICAgICAgQ01EUSBjbGllbnQgZHJpdmVy
cyBoYXZlIHR3byB1c2FnZSBvZiBHQ0UgZXZlbnQgc2lnbmFscywNCj4gPiArICAgICAgb25lIGlz
IHNmb3R3YXJlIHRva2VucyBhbmQgdGhlIG90aGVyIGlzIGhhcmR3YXJlIGV2ZW50cy4NCj4gPiAr
ICAgICAgU29mdHdhcmUgdG9rZW5zIHJlZmVyIHRvIEdDRSBldmVudCBzaWduYWxzIHRyaWdnZXJl
ZCBieQ0KPiBkcml2ZXJzLg0KPiA+ICsgICAgICBlLmcuIHNvZnR3YXJlIGRyaXZlcnMgYXBwZW5k
IEdDRSBjb21tYW5kcyB0byBzZXQgYSBHQ0UgZXZlbnQNCj4gYWZ0ZXIgc3BlY2lmaWMNCj4gPiAr
ICAgICAgR0NFIGNvbW1hbmRzLiBPciBDTURRIGNsaWVudCBkcml2ZXIgdXNlcyB0aGUgQ1BVIHRv
IHdyaXRlDQo+IHRoZSBldmVudCBpZA0KPiA+ICsgICAgICBpbnRvIEdDRSByZWdpc3RlciB0byB0
cmlnZ2VyIHRoZSBHQ0UgZXZlbnQgY29ycmVzcG9uZGluZyB0bw0KPiB0aGUgZXZlbnQgaWQuDQo+
ID4gKyAgICAgIEhhcmR3YXJlIGV2ZW50cyByZWZlciB0byBHQ0UgZXZlbnQgc2lnbmFscyB0cmln
Z2VyZWQgYnkNCj4gaGFyZHdhcmUgZW5naW5lcy4NCj4gPiArICAgICAgZS5nLiBXaGVuIE9WTCBm
ZXRjaGVzIGFsbCB0aGUgZGF0YSBpbiB0aGUgZnJhbWUgYnVmZmVyLCBPVkwNCj4gd2lsbCBzZW5k
DQo+IA0KPiBUaGVyZSBpcyBubyBmdWxsIHN0b3AgYmVmb3JlICJlLmcuIiBhbmQgbm8gbmV3IHNl
bnRlbmNlLiBQbGVhc2UgcnVuDQo+IHRoaXMNCj4gdGhyb3VnaCBncmFtbWFyIGNoZWNrLCBsaWtl
IEdvb2dsZSwgQ2hhdEdQVCBvciBodW1hbi4NCj4gDQpPSy4gVGhhbmtzIGZvciB0aGUgc3VnZ2Vz
dGlvbi4NCkknbGwgY29ycmVjdCB0aGVtLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4g
PiArICAgICAgYSBmcmFtZSBkb25lIGlycSBhbmQgc2VuZCBhIGZyYW1lIGRvbmUgR0NFIGV2ZW50
IHZpYQ0KPiBoYXJkd2FyZSBidXMgZGlyZWN0bHkNCj4gPiArICAgICAgYXQgdGhlIHNhbWUgdGlt
ZS4NCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQz
Mi1hcnJheQ0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArICAgIG1heEl0ZW1zOiAxMDI0DQo+
IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo+IA0K

