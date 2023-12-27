Return-Path: <linux-kernel+bounces-11767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B238A81EB66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCC91F22CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E815323D7;
	Wed, 27 Dec 2023 01:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NXitGqBq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DitgeD7O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D33C30;
	Wed, 27 Dec 2023 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 902b63d2a45b11eea2298b7352fd921d-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iAVlSmvtFvCzE7fpJkSSwFJlFUKXmD2998I4dprv54U=;
	b=NXitGqBqV3pcf1n1xj351dcShz6EL0CyOY5TLezSRMBNmfaEXFCmZLkaAVbMRkOCKH7wcoyuFKkcHx+pAb7uls5ioEwoydajTzDra9eRcqfNjsqbY8AMOQJfELrp1lTvxcnaC6Q68DtbvPpMBipTJ+dtGrSR2/eDs8bAZaTV1QI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:632cbb22-ff97-4367-95cb-a07f9ee4ac8f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:a92e852e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 902b63d2a45b11eea2298b7352fd921d-20231227
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 483264528; Wed, 27 Dec 2023 09:59:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 09:59:24 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 09:59:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFM/+uzAbDNx4f5wzSKwV7x68aWutKcHw58bcXMWBD0R/6kD4ygV/im5k2Z7xAuNctPrMAuq26zGZAWvCu4b6g9mU7G5k2HM5415xUjbwcUZ1Tury281PM/IhJP5KRJ9x3AJ8P3s4HCpaMe6XmeePDFbLnBNjB5Ykv6zjGdTWsS9zRW5/yg3Gg3C2t4r354xCD9HQEwzoqMkS3g/PSBlK04olzFIYxqYtznkfdPcT3h2zgSdySVyaDmf+s9Lux0hFTw/J28EtJjFLNzKzhCWTrPtDbRoajYnJsjVVMbXVjxZsP76/B8nVRnQzVkXEOcwGQjKmP2ElNU5uwoQHYANFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAVlSmvtFvCzE7fpJkSSwFJlFUKXmD2998I4dprv54U=;
 b=NqfTiL5KR/yV+sR5Q4KE609NA3uChJTEM2ohMfjkdMj7JhU/r04zl5lIFuti/yfTdAOkuCaKnwR2oMQYjdXvY6npNs/rALdz5dmQdBgwX8qw2WXLyUMNkJxtgzL1sQQ3SHTBzBIn938daHDrmQ2yQtTHX6NP6yaLKbpUCsfNmwMmS97k+Yhqve3CQW7BoPtKPkgr9snVAQ2Y3QNndSvNvBb31ufQqOlGYMdsn7pzTkupzWqnHfLF2vimVtV4cYl7mu05md9IOgALCCgiAiIOTnogZ1aHip6sIkXYcLlTTbKSN7LR8nrclqmJnwIqtmduyiW2uDO4FrYvH3gnhA+jUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAVlSmvtFvCzE7fpJkSSwFJlFUKXmD2998I4dprv54U=;
 b=DitgeD7OH0XmVEuYZh3Zqbcqtpb/qJ/TYhdqesc2i12VyGF44502HBJCV0K/DUzmbAIcs4DmKyBivQKw3/xiBr0W4Ax/amV7lQi8AlYwwKvjFv8qLHX8AgC7HScs2YKim88lChaHe4mZTjrzVaEpU6nL6+hgyAozgEwsgaWngkc=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by OS8PR03MB8962.apcprd03.prod.outlook.com (2603:1096:604:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Wed, 27 Dec
 2023 01:59:22 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 01:59:22 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>,
	=?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= <Eddie.Hung@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: mediatek: mt8195: Add 'rx-fifo-depth'
 for cherry
Thread-Topic: [PATCH v3 3/3] arm64: dts: mediatek: mt8195: Add 'rx-fifo-depth'
 for cherry
Thread-Index: AQHaMvCNIT+k2tloM0CwSYlOK7y8UrCx+UQAgApxeQA=
Date: Wed, 27 Dec 2023 01:59:22 +0000
Message-ID: <9d335e9e1cc859ea296831d7bf9e5d8e8f6a3876.camel@mediatek.com>
References: <20231220025842.7082-1-chunfeng.yun@mediatek.com>
	 <20231220025842.7082-3-chunfeng.yun@mediatek.com>
	 <d1767b1d-0b80-4ece-8a35-18eed52a3f6e@collabora.com>
In-Reply-To: <d1767b1d-0b80-4ece-8a35-18eed52a3f6e@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|OS8PR03MB8962:EE_
x-ms-office365-filtering-correlation-id: eba40700-3c44-44fa-9410-08dc067f724f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z+1tnUOCLXHXt9RMdsG3AFMbG2iiCS0Nn4Ll2xwKqdSlW2QUmQsPoQYhLnMWVH1KgWa7ZtjUCHDtAOSyi+yfMyQTMDvvlKxeuJDo3Y3uolQ95XbtXos+clFMbDQLfF2i2VY1VjSmt6Uu8Mo/SwY4Pqqk6NBD+B9AB95Y+AsalCB8irEFLVaKJGRD8h4MgLQtCEuPojQ5YkQU7e+uNut49EWbvoavdoIrve/PURNoYyVsB9RLIjZGQLARB1s3uqBGEXbOfcdupORd9YQVnd5J5h1+VEtMGu9Igf8k2L2ZPAmw3UT0IdRIKxUNWL8ei9+mmcixKEy4A5Qpat/JiUKVDzoHwe49LopgyDSg4eUDqiBRW+rtpvL7M9yKQulh3gHh/7pUYK7m2yAoV94ITo576qe3IMAWe9lwO7vLNuqw1fG5zsNmw6TiAaIy2pOT+T3tjCk9Z0e40PWRElQ284QtDATvtvWu7cWA3LX2H2iIKqM2b1GjtG7HYhSgLtsefzJDEN2sLPTAzyNSdscCg+xCwLr+3K/4hd8DRQbvrzQLZYXoqNUC8VnVjkQNqSz7mKPjvdobV783cvdkHn1bYWCjlxoIVu5PZITODPdCJQHgdg7iMtVDIj2L01qzGUnW2p37rayVB/eoqB6qu1qCJnKv+hJh1/x7yuoRQRXgF2PFu6JvVvAHJ8dkY9bEOKeXEK2M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(8936002)(8676002)(71200400001)(6486002)(36756003)(478600001)(86362001)(26005)(2616005)(6506007)(6512007)(85182001)(122000001)(38100700002)(38070700009)(41300700001)(110136005)(54906003)(91956017)(66556008)(64756008)(66446008)(66946007)(76116006)(66476007)(5660300002)(4001150100001)(2906002)(7416002)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmRxRFdoSmMxTVByRUtCaTkweVdzVHNuODRHNTZGOVRLTUZleW9ZZWRJMUJE?=
 =?utf-8?B?RVVVaDEzUDVnWFcrUER4cXNreUJTeXdCK3Y2NHZURkVCRXJyL2ZlWTk2YVho?=
 =?utf-8?B?d0JScFhMakkrMHh6UGtreFo0aU10am5SaFQzbFM5YzhYSG1OVVpJRzVVcVJw?=
 =?utf-8?B?WFY2WHVOOG81Um5jTGx6bXBMNiszOHd6N04xRXhBVkNVdnZ3ZjZjRUVkNnp6?=
 =?utf-8?B?VTk3c2dENzBpb0JYeUd6Mno5Q0VhS3Zla0YveExVRVd5dURnKy9MRkV4Y0Fp?=
 =?utf-8?B?cXo3OVMvWHpXVjJNbStrYTRqMmt3SUdQQTNpbU1TYWtmZUxxL2VsZmZ5cCty?=
 =?utf-8?B?cUF6NHBiM2d3ckc1V0Zxc1F5ck55LzllaSs5bXN6S1hSNnBOdlhmczFzdExM?=
 =?utf-8?B?S2VLeWNteW4rclliektnZ0RFNEVjSkZ5Vmg4TXljOWdaWmZOOU1QS3E3QWEw?=
 =?utf-8?B?OHNSUUVnZEJEbHd0VC9NWFc2dUJMaFlzRWJqdzI2VkZkaFI3d0NkUlhmc0xp?=
 =?utf-8?B?dW5tTGlodkpxZE5HRWNnVURla3RUdGJxYkJWZVpLZ3pNeDFiN0tnQktrYndz?=
 =?utf-8?B?SnZDMVNkR2lDK085aUNCdkh6a2VTTXlmQjh3alphWXVtZWhtL0lHN25DMUtM?=
 =?utf-8?B?N0pFUFRwQ2VPTDFjKzlqNzJveUdnVTF6aHVTYWQ5ZlRlKzNEOWlRNmhuTjFt?=
 =?utf-8?B?MlB5Q2dJSmFyOWhLSzZRUWZ2cHJWRERKbUtjVklQQ1crUTVMMGNldThmYmhE?=
 =?utf-8?B?VXM2K0pLM3ZmZVB5d1hQTFZPRWRqREM4Tk5YUUNwWmdHTHFNeGVBU2hLdVZy?=
 =?utf-8?B?ZURxLysybWpDWU10aWFCMUdmMzBmWHZuQXV5L2QwT0JzemhSTUxBMlpVWVRW?=
 =?utf-8?B?OHpTSzMzdWdJR0JQODI5aUtZYnppSkNoallJTTIwcDBxcjFHSXJpa0QwRzRU?=
 =?utf-8?B?MXVRaEJIMDVVS3VtR0dEVmUwSEZ0eC9ZeUI2bVEvbXRvcDFTNFlKNFYrYy9u?=
 =?utf-8?B?cG9xUjMwNDFCQUl3ZmtvV1FoVjZjS0MzSVJGOXYrM3hBOFlsSlN6OWo4THNt?=
 =?utf-8?B?Zk51NitMMzNkLzFuQWJrdHBpeHNMblllemNTUHVPNUQyNmROZEhpR3NVT1JO?=
 =?utf-8?B?ZitLdTFrdVhZWEQ1ZncrYXJBUGZ5Z05pSktIOG1WYk85SVJ2Mmh4bDZTSjYy?=
 =?utf-8?B?UkptMExxeEVEd1NrQkRpZmNMZGllNVgrNzRQYklHUlh4b3h0OTlwZzNybXU1?=
 =?utf-8?B?TVNpTFI4d2NpaUVTZk0rVXNhKzZTQlJxVkRocFEyQStsY0V6b3JHY29FZ1lk?=
 =?utf-8?B?WHlyRUF4R1BWSkMrZ1Y5QmJxOG1iMm1UcWVnUEYvbmZXU1J2RHU4Z2hXT2hP?=
 =?utf-8?B?aUlIQ1NLOWIvQmRRcnFlZjRJYjFqNzNvMjkvQTNQNzJNd2dmeGhCQnE2NW93?=
 =?utf-8?B?d2dWSnB1d1hVOE1VdlNBYWpKY2JGMmttYTNXS1pVWDNsRUdtS2VjOTBYTy9X?=
 =?utf-8?B?cjBDWFFUWlpVY1k3aUtxYVRhbTZCdkdXSyttUXRhRngyOCtyNG9ZQUFCVktG?=
 =?utf-8?B?Nnloa1owNkU4dXRyc2lDeTk3Z09TSUxhOGdVMHdCU1RvaGR2dzZvdjFJVEdZ?=
 =?utf-8?B?VktDTEZKT1FmL0J6UzNQMWJjMU9TSjVPWGNKV0RxRVY2SEp6SndmZWcvclQy?=
 =?utf-8?B?Z05JazlZaWtFenZRUDZQV3Zsd1M2dTR5bU9aL1NCNTNXYXltdjZUd1ZPL29p?=
 =?utf-8?B?ZVFBYWorQVp2N0VxcGluZFdOU1JwR041cU4xSFljUkVMTWs5VzZRZ3ZWMHN3?=
 =?utf-8?B?S2t1U3hoaHhTQ3JaL1dmeFBvcVJHWE5hV2gzMHRUWjFvc05Kcjh0T2ZQQzBC?=
 =?utf-8?B?cng2dVc2dUdpZVFpcUpERXVRT0kvWUxMalZSQUk5NVUrMlBvQlZzU21OdWNl?=
 =?utf-8?B?WUlsL3dFbWNieUpxckl3NlZRY0VyeVhGSVhLZTRaZnJRM2ZqbG81QVV0MUQ4?=
 =?utf-8?B?a2FrbkFTRHRJVE83K2IyZHg2b3huUGw0cmR2Tkg1bXBNTVEvUEhTVTNBZTBs?=
 =?utf-8?B?SXlRUlZiUFhXMTVQUUdTZGxSK1pURDY0b21hKzg4MzE0WnkzZmc3SkVrOXVo?=
 =?utf-8?B?TFBxdDgxRkJvM3RsVGtKcnNGYXoyc0o3Rlg5KzNzL3I4MkhIZGd6UXBTUzJa?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BF2DF7065A9CC49B6C5E8890D2273D1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba40700-3c44-44fa-9410-08dc067f724f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 01:59:22.7589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohygtSRTsBSoC1Ys/38gR0XzNPPTGK1ndBv736PMgGIV9kLqXmXlGp9kmmaQsQUre+it3BE+9ETxcgWsl8ejBAeMNfm9suLuwrqDnIBpjiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR03MB8962
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.283200-8.000000
X-TMASE-MatchedRID: F7tLedRt7ifUL3YCMmnG4qfOxh7hvX71YefZ7F9kLgsNcckEPxfz2Dd1
	jBj8QIzhsMXxKM0XU+H89WDKQGB2LkaWGOeKmQYQR/j040fRFpIZKp0SZ4P+dRBVEcLcHoVgV96
	QsW8/xRVC3bjvSDu95ypJxlCwtEWkh0zWQXCZZ8izI1v7J4hECl1tpWYE7OpsN2WxgvaD/zsRZc
	CYVXElTiya+v8M/JfcNoSXlo1jMIOPaFHMfVTC4NIFVVzYGjNKcmfM3DjaQLHEQdG7H66TyH4gK
	q42LRYkznhgTJheXSpgXMi+rc7wdnXV6VPudzl8kCR0aZVjJFR+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.283200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	821E6C6B69845C2D84EFF4187DEAD338A33D7451DD04231E8F5F8B3DC96FEA4B2000:8
X-MTK: N

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDExOjMwICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjAvMTIvMjMgMDM6NTgsIENodW5mZW5nIFl1biBoYSBzY3JpdHRv
Og0KPiA+IEFkZCB0aGUgcXVpcmsgcHJvcGVydHkgInJ4LWZpZm8tZGVwdGgiIHRvIHdvcmsgYXJv
dW5kIEdlbjEgaXNvYy1pbg0KPiA+IHRyYW5zZmVyIGlzc3VlIHdoaWNoIHNlbmQgb3V0IHVuZXhw
ZWN0ZWQgQUNLIGV2ZW4gYWZ0ZXIgZGV2aWNlDQo+ID4gYWxyZWFkeSBmaW5pc2hlZCB0aGUgYnVy
c3QgdHJhbnNmZXIgd2l0aCBhIHNob3J0IHBhdGNrZXQsIHNwZWNpYWxseQ0KPiA+IGZvciBhIDRL
IGNhbWVyYSBkZXZpY2UuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxj
aHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHYzOiBjaGFuZ2UgdmFsdWUg
YWNjb3JkaW5nIHRvIGJpbmRpbmcNCj4gPiB2MjogdXNlICdyeC1maWZvLWRlcHRoJyBwcm9wZXJ0
eQ0KPiA+IC0tLQ0KPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUtY2hl
cnJ5LmR0c2kgfCAyICsrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1
LWNoZXJyeS5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS1j
aGVycnkuZHRzaQ0KPiA+IGluZGV4IGRkNWI4OWI3MzE5MC4uNTg1OTMzNDhiODEwIDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LWNoZXJyeS5kdHNp
DQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUtY2hlcnJ5LmR0
c2kNCj4gPiBAQCAtMTE4NSw2ICsxMTg1LDcgQEANCj4gPiAgIA0KPiANCj4gQ2FuIHlvdSBwbGVh
c2UgcGxhY2UgcngtZmlmby1kZXB0aCBiZWZvcmUgcG93ZXIgc3VwcGxpZXM/DQpPaywgdGhhbmtz
DQoNCj4gDQo+IGFmdGVyIHdoaWNoLA0KPiANCj4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hp
bm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29t
Pg0KPiANCj4gVGhhbmtzLA0KPiBBbmdlbG8NCj4gDQo+ID4gICAJdnVzYjMzLXN1cHBseSA9IDwm
bXQ2MzU5X3Z1c2JfbGRvX3JlZz47DQo+ID4gICAJdmJ1cy1zdXBwbHkgPSA8JnVzYl92YnVzPjsN
Cj4gPiArCXJ4LWZpZm8tZGVwdGggPSA8Mz47DQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gICAmeGhj
aTEgew0KPiA+IEBAIC0xMTkyLDYgKzExOTMsNyBAQA0KPiA+ICAgDQo+ID4gICAJdnVzYjMzLXN1
cHBseSA9IDwmbXQ2MzU5X3Z1c2JfbGRvX3JlZz47DQo+ID4gICAJdmJ1cy1zdXBwbHkgPSA8JnVz
Yl92YnVzPjsNCj4gPiArCXJ4LWZpZm8tZGVwdGggPSA8Mz47DQo+ID4gICB9Ow0KPiA+ICAgDQo+
ID4gICAmeGhjaTIgew0KPiANCj4gDQo=

