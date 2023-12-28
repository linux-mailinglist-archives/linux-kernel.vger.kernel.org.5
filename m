Return-Path: <linux-kernel+bounces-12491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C15881F591
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA832B22516
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B55233;
	Thu, 28 Dec 2023 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gD8+ROtP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nV0mZ1oQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E863D1;
	Thu, 28 Dec 2023 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f1533830a55311eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QRKmzCQksvN9wmTCJjqJ7MhvOTbOED5kzoTECHj6qnc=;
	b=gD8+ROtPo5RTBcf3ypLPJWTG+HWR8I3+WNCHFbMXoqVyYJGyMiELFTNoffYT4gGsg2XA7LABDmk4I8fU8JToL6g1f83MnEvDo/uOyMpE1WvSZkyTEGkXk6SKuHFA3mxyRLBqyeQtko+6xmFBmybqbVw+qu5THTgYljswNBNnqFk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5378a021-c489-4835-9a48-8288990f4196,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:5f8dc17e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: f1533830a55311eea2298b7352fd921d-20231228
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 685209148; Thu, 28 Dec 2023 15:37:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 15:37:23 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 15:37:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgdBdSf6QkezvZ2uzW9391XeRyaPclD/KLVgDlR+119rOGy9jvRI/teBGOVVvMTI7D4lNTTID4XuTPnB9UrKC2iMYUXfYenMxNp4eJgTAuKVtLL54EQPR/sAcSHCbD1fBIHc7kimhzB1FxqqTv3TkyCShgNLwDsPNJfkHOHd1qi7fC60B332H9dPYJylLXBQPYhz+RxEHxLI/yaBNQtdq2kIcgkoi6wKRkPsz79RuBRMuZAygAh2QVO9M9R6IAJJgNYTSfdXdC+os+q3rUsCwXEfcQlSd7EXdietde5ja/9I6Y3QI9/F/XZnKuVGPHPkzZtGIZ9cS9TwuxgfIvKGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRKmzCQksvN9wmTCJjqJ7MhvOTbOED5kzoTECHj6qnc=;
 b=GKWsWxjUcGBlxaBLPvPHT/qtagIMR4dER8gLg1qchxJeYWnVn2FzJP9Q0fOFZeYLnGwp5OC/4YG4dwglgcltrtxw3H0GZX4Fu3fBVYD46O4ibQGvFZ7LUfRO0OUQznGXbwZjTdlj3rgwt+iK2+Vx6yP7wc/6I0x7QKvjNxLy5eLsG+TUKOLIoZczEWKTwv8cnkWVq2I3gRAHBKlnhsdrC2gqdZ5CXrhfrUaLqaVkqzY9aiuphWH3O9KsKoEAxfsqey2sF3xGDoH4UI0BXrcc22K9MZbGneZRtnN8o0un9d7+0iw80pLIyMew1jEcIvWOaGYi9W84H/Fjy9b+D2h/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRKmzCQksvN9wmTCJjqJ7MhvOTbOED5kzoTECHj6qnc=;
 b=nV0mZ1oQ+z4oGx+/egckuZCESSSluw9AZSlRfGL8SobQRT4QSsdgxqbN0w7jb+ADwQT7DrWwGmzmSM74B2FhtNdOMCVA2uoz/fNdGu4JMpn/xeKwA8CalvB4gQiW3NeC1IWHSlHFXpbiMYJByLijalv7r2axTTAgGRX6EmWgXjU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7683.apcprd03.prod.outlook.com (2603:1096:101:14a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Thu, 28 Dec
 2023 07:37:20 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 07:37:20 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Topic: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C+WDmA
Date: Thu, 28 Dec 2023 07:37:20 +0000
Message-ID: <c33745a4424777df44efe811dba060700f0009f0.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
In-Reply-To: <20231222045228.27826-9-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7683:EE_
x-ms-office365-filtering-correlation-id: 4436d201-dc28-43b9-b0fc-08dc0777d30f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aLdgxEb0HlMZAMCfKBiQn5QzypkT0Z8UX7dYpPzdQmShEdsYB/dksLVbv+68Pira+oX+Nsjs3XRwQPYqIf3OmMqia4Z5XfnjaAy0OPq3GLgzoul/PZXw7ikBnFQzeAxyjVCfr+7djTMsi8NOcM3mCzoOFljIqxDaZQKX6dA3/W2A8JfM1EjibO08mVtOjGbirhsPFXYumCKLKmIiOYaXhiTt7UebawBQn64ePxbw0W0R4DxiaqzsIO7WNnAMp9Y5aqBcf2q3sT6BdueT7ER9KyLQILmp0ocq4kgUtSg9M9HBT2hOnzj9OkWun+vlSmnbEULLxU5gx4WZUUeJNADlanA6DfMWlVfuR5GOwclvCeuoEnii3cgbcHbxDGfxrZpQKm1TAm9x2KIMYvAqyvGTl0N9rOTkXyzs/MdX+0AY46MMir3d5duJsSSKyuMYTNo0SLWMg+11zcGsPO7xgO9IjXwSqNuNDnVEMfIzElImBTrKodbbmaxjM9uq0pTZy9+eSZaj84swR1MIO4YFX1oIvCGpX1G++J5Xa2Qvd8QnKTrT0yUCQfWu4X/Nryv0KolJ4arAUuvrfnzZO8tD5Ck0ZoPk45mM0WmkAS4vhxHGgjjPi6LNMi1EC521Hk3/0xTooXQGUxriDZGBFVs+GAw6NzFGLuKvezrddv7JWB/PbKg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6486002)(478600001)(2906002)(71200400001)(8936002)(122000001)(15650500001)(5660300002)(64756008)(85182001)(8676002)(7416002)(36756003)(6512007)(6506007)(4001150100001)(66946007)(66556008)(76116006)(66476007)(66446008)(38070700009)(110136005)(4326008)(316002)(54906003)(26005)(83380400001)(86362001)(2616005)(41300700001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWNWZ3daNlF4bHF0UDM5elNtZnpGUi9pRmpudzcxbWRLWElqazQxNW90N0wy?=
 =?utf-8?B?N1NsSUFYVlY4SlZJejVkbWFKcDZPZ1p6ODk4Y2hpQ3BZNzlWVDd0Z2lNZkRX?=
 =?utf-8?B?OVErVExjT2NFRU4yWXlhVjNxdXFJQXBvTEF6UG5YOXd5TW9JVk1YQXNHZ0Q1?=
 =?utf-8?B?Um1tdms2R1VnSmFsYjZMNnE3WVhKdDV3V3NDc2FTOFp0WlVaN1N5b3ZVcUxn?=
 =?utf-8?B?MHRScVRaY01wNFIzNllaSnNwMUhnRVowOEEyT01teFdsdms3MDdQeG85S1FC?=
 =?utf-8?B?c1d1ZlIvSzIrTjI0clliakl6cjNKSVhxSWRpcDg5Rm1LMTRDeExvdE10ajg3?=
 =?utf-8?B?MkM0V3FNVWR4R2VMbEJQUHRaeGxsaVBvaUNXUThSb3plQ2QxbFQxMGxBUjd4?=
 =?utf-8?B?RTdDV1oyUVRPZDZpSmZoRlRSYlRuMDgzUE1FajUxb01rdXJXdHRkckorTWFu?=
 =?utf-8?B?L0QyeXdlTFdldjRUTjhNRjNkUTk5VllUVTMvRjVlYWtKS3dTcW9WYzlLVG85?=
 =?utf-8?B?QTlEaFNOVlcxOXlBQUkyWGhvU3Q1YlJEMXdGTzcrUTEyT2NCTHFwNFdINWVs?=
 =?utf-8?B?OVhGN2tESlFjRlUvcUIwSG1qMXZmTUJDSVlOU1BXQy90aWFqd3NKS3Q5YTd6?=
 =?utf-8?B?TUZla3U2Y0NvMjNoTG9NcnlhTWpJVTRrU0F0R0xqTU5tMGt4QzdoZWZ1ZGNp?=
 =?utf-8?B?SEh3VVh1WFNTWnhOTWN2bXM3S3NBWlVkKzZEcERMQTVFV1lVd1BQMW1zOHdw?=
 =?utf-8?B?WFU3Nlc0ZDRPTExNbG5nS3N5WXQvbUxaRWNPOWNBY2d6QTY2eVBBMTFGbERj?=
 =?utf-8?B?OVZJek9XQ1VVdXlWblBuTjJvOXl5cDVxLzhqbE4wOC85azc0Qll0WExOY3Nk?=
 =?utf-8?B?ZDZ3OEhDa0c3WkxxcHR0ME5NSmdHVlBkdkRoNzNkZTRFaG96TTFNbGxJNktF?=
 =?utf-8?B?OGpIeFByWHZlaG1QUXFGNnVYaVduaVB5eFZJUUl4VStVZzMyUmc2NjZlRjVp?=
 =?utf-8?B?MUJkRVEyTkoydUJ4WmVuWnJwWWpFWUl3SXNIRjRuWTZFbVdZUHhsQzIvKzhl?=
 =?utf-8?B?WmZWMDJJRkZDVWlFY0UwWm5BcUU1ZFlBNjA1VitNbEhpVUFxNjhjYmc0VFVy?=
 =?utf-8?B?TlNxQnpDRGNZNFkwTGoxNUhDcHRKOFVVY2t1MklyRiszWk5JeHErYk5ielpv?=
 =?utf-8?B?dUJzMU94ajZoKzZNUWlmeE1TUGptWmdTZmtSVHVyTGJOOXYwSDlXYzk0ZVNr?=
 =?utf-8?B?QThMVHBsS3lDVU94UXBqOWFXNmlLcWJsUjlRSVV3VkNYdEN1QlF0U3VyNEhD?=
 =?utf-8?B?amF4YmlxcGdsWVdnUkJLOFZyUkhUWTZ0NXRHS3hWN1FxL2VkaFZNYlNqYnpv?=
 =?utf-8?B?T0grSktRQk5hczNSRU1NSGhFV1RhOVJsaUc4Z1VYZFVKbFBOTllGSXpUK2Jk?=
 =?utf-8?B?NGlzVTRqWXdSUFFsSWI5WWFablA1WWRSa2ozTTBjd2Z4bStGYlUwdVZJcnMv?=
 =?utf-8?B?VnVMUW1BOTRZY3RjdExSc1dUa3pJMmhMVk9iQ1ExTW5uc25UMll0amRuNXhW?=
 =?utf-8?B?amh2L0hOeFEzT3dlSzFURmxZQjBtbE9XTERnZGZnd0ZsUFprZFc0T1dWbWxR?=
 =?utf-8?B?bWt2VzFUd29HK0llNGFIMUxsRkJPZkprRHppbUpySW14b3hJejdrQWhhaHJu?=
 =?utf-8?B?NllQOXZESHZFMUZ3b2FvKzJkclZMSDhoSE16Q3hPM2V1VVE4aEI0NHFMMlIv?=
 =?utf-8?B?ZEpzRW9CRFdINkMwYTZOU1QyWGttSFQzK2MyMVQvb1hLNzlJVi81QnZoaHVB?=
 =?utf-8?B?UlprRkowakc3WmxLcC94SzlHQ3NteHBEMzRQcGlLUm1rMUpTYzNNSWxWcUhq?=
 =?utf-8?B?K0dwNEJHb2tlQ0lYU1ZHc3dpUU9BOGRuYWV5SHVmZjZYcHB2dk14MHR3elhj?=
 =?utf-8?B?eUdWdjN4MExNMXpGZlN5YXk4NUw2MFpVNG8xbWtJN1dkL0ZsdWJxWHRJcy83?=
 =?utf-8?B?QnBKU1pqK2VXSVN6dnBIcWYwdUFxNVZ0YnpQMXVZZGUyZHhyTzY2WDBlUm9V?=
 =?utf-8?B?NElodERPSWw0MStmYTVwWXpleDZlSEovR3kxaE44bGcwMjVWV3pwdXdPOHhv?=
 =?utf-8?Q?sKhVq4rHa4DhK1lapMWy0ZywE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08F9A52BDF5D644C8A28F7EAEF2842C3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4436d201-dc28-43b9-b0fc-08dc0777d30f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 07:37:20.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4Cv9s6ozv7bSGTt/7l3jC2dlW32bhQAUxqRlSAja2gcUkvXcczx2CyBJ/SsW5tXabC874hhClTlRhsmfuvZCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7683
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.458800-8.000000
X-TMASE-MatchedRID: QW5G6BKkLToOwH4pD14DsPHkpkyUphL9qQ9UezeTkThu4FknyqyshF1Q
	po5pNysMe29pTfBhqOY7b3Js3F6vVD1LciJB3541o65WJt1k1O8TbU1KYGoQp3vsbfoZixUTS0e
	iOsrXcTiPAnyTT3ugzShfOC8JC4nFydSy/G+xHpIcsSroYI5AVgpxE3/U/O4WHMKI0y89bBKs9H
	kZwywsHv+cwEGCDjTv4epXsF7qjUEiXL+V+zm5iSYRREGYqtmUxKAxBgoYewlnuv8pVwMzSaPFj
	JEFr+olFUew0Fl/1pHYh0PvnvUH8FZ0V5tYhzdWxEHRux+uk8h+ICquNi0WJKANfIBYewm0SmuB
	6ZWSZeUcd13mreZllhJ60zCPLzzVftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.458800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5E53AC2A0B5FECB971D560962F70765EDFB1046907F9528EAFE16634B08084362000:8

SGksIEphc29uOg0KDQpPbiBGcmksIDIwMjMtMTItMjIgYXQgMTI6NTIgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBmZWF0dXJlLCBHQ0Ug
aGF2ZSB0byByZWFkL3dyaXRlDQo+IHJlZ2lzdGdlcnMNCj4gaW4gdGhlIHNlY3VyZSB3b3JsZC4g
R0NFIHdpbGwgZW5hYmxlIHRoZSBzZWN1cmUgYWNjZXNzIHBlcm1pc3Npb24gdG8NCj4gdGhlDQo+
IEhXIHdobyB3YW50cyB0byBhY2Nlc3MgdGhlIHNlY3VyZSBjb250ZW50IGJ1ZmZlci4NCj4gDQo+
IEFkZCBDTURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xpZW50IHVzZXIg
aXMgYWJsZSB0bw0KPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1cmUgd29y
bGQuIFNvIHRoYXQgR0NFIGNhbg0KPiBleGVjdXRlDQo+IGFsbCBpbnN0cnVjdGlvbnMgdG8gY29u
ZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
bi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0K
PiArDQo+ICtzdGF0aWMgYm9vbCBjbWRxX3NlY19pcnFfaGFuZGxlcihzdHJ1Y3QgY21kcV9zZWNf
dGhyZWFkICpzZWNfdGhyZWFkLA0KPiArCQkJCSBjb25zdCB1MzIgY29va2llLCBjb25zdCBpbnQg
ZXJyKQ0KPiArew0KPiArCXN0cnVjdCBjbWRxX3NlY190YXNrICpzZWNfdGFzazsNCj4gKwlzdHJ1
Y3QgY21kcV90YXNrICp0YXNrLCAqdGVtcCwgKmN1cl90YXNrID0gTlVMTDsNCj4gKwlzdHJ1Y3Qg
Y21kcV9zZWMgKmNtZHEgPSBjb250YWluZXJfb2Yoc2VjX3RocmVhZC0+dGhyZWFkLmNoYW4tDQo+
ID5tYm94LCBzdHJ1Y3QgY21kcV9zZWMsIG1ib3gpOw0KPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
DQo+ICsJaW50IGRvbmU7DQo+ICsNCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmc2VjX3RocmVhZC0+
dGhyZWFkLmNoYW4tPmxvY2ssIGZsYWdzKTsNCj4gKwlpZiAoc2VjX3RocmVhZC0+d2FpdF9jb29r
aWUgPD0gY29va2llKQ0KPiArCQlkb25lID0gY29va2llIC0gc2VjX3RocmVhZC0+d2FpdF9jb29r
aWUgKyAxOw0KPiArCWVsc2UgaWYgKHNlY190aHJlYWQtPndhaXRfY29va2llID09IChjb29raWUg
KyAxKSAlDQo+IENNRFFfTUFYX0NPT0tJRV9WQUxVRSkNCj4gKwkJZG9uZSA9IDA7DQo+ICsJZWxz
ZQ0KPiArCQlkb25lID0gQ01EUV9NQVhfQ09PS0lFX1ZBTFVFIC0gc2VjX3RocmVhZC0+d2FpdF9j
b29raWUNCj4gKyAxICsgY29va2llICsgMTsNCj4gKw0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnlf
c2FmZSh0YXNrLCB0ZW1wLCAmc2VjX3RocmVhZC0NCj4gPnRocmVhZC50YXNrX2J1c3lfbGlzdCwg
bGlzdF9lbnRyeSkgew0KPiArCQlpZiAoIWRvbmUpDQo+ICsJCQlicmVhazsNCj4gKw0KPiArCQlz
ZWNfdGFzayA9IGNvbnRhaW5lcl9vZih0YXNrLCBzdHJ1Y3QgY21kcV9zZWNfdGFzaywNCj4gdGFz
ayk7DQo+ICsJCWNtZHFfc2VjX3Rhc2tfZG9uZShzZWNfdGFzaywgZXJyKTsNCj4gKw0KPiArCQlp
ZiAoc2VjX3RocmVhZC0+dGFza19jbnQpDQo+ICsJCQlzZWNfdGhyZWFkLT50YXNrX2NudCAtPSAx
Ow0KPiArDQo+ICsJCWRvbmUtLTsNCj4gKwl9DQo+ICsNCj4gKwljdXJfdGFzayA9IGxpc3RfZmly
c3RfZW50cnlfb3JfbnVsbCgmc2VjX3RocmVhZC0NCj4gPnRocmVhZC50YXNrX2J1c3lfbGlzdCwN
Cj4gKwkJCQkJICAgIHN0cnVjdCBjbWRxX3Rhc2ssDQo+IGxpc3RfZW50cnkpOw0KPiArCWlmIChl
cnIgJiYgY3VyX3Rhc2spIHsNCj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2VjX3RocmVh
ZC0+dGhyZWFkLmNoYW4tPmxvY2ssDQo+IGZsYWdzKTsNCj4gKw0KPiArCQlzZWNfdGFzayA9IGNv
bnRhaW5lcl9vZihjdXJfdGFzaywgc3RydWN0IGNtZHFfc2VjX3Rhc2ssDQo+IHRhc2spOw0KPiAr
DQo+ICsJCS8qIGZvciBlcnJvciB0YXNrLCBjYW5jZWwsIGNhbGxiYWNrIGFuZCBkb25lICovDQo+
ICsJCW1lbXNldCgmY21kcS0+Y2FuY2VsLCAwLCBzaXplb2YoY21kcS0+Y2FuY2VsKSk7DQo+ICsJ
CWNtZHFfc2VjX3Rhc2tfc3VibWl0KGNtZHEsIHNlY190YXNrLA0KPiBDTURfQ01EUV9JV0NfQ0FO
Q0VMX1RBU0ssDQo+ICsJCQkJICAgICBzZWNfdGhyZWFkLT5pZHgsICZjbWRxLT5jYW5jZWwpOw0K
DQpjbWRxLT5jYW5jZWwgaXMgdXNlbGVzcywgc28gZHJvcCBpdC4NCg0KUmVnYXJkcywNCkNLDQoN
Cj4gKw0KPiArCQljbWRxX3NlY190YXNrX2RvbmUoc2VjX3Rhc2ssIGVycik7DQo+ICsNCj4gKwkJ
c3Bpbl9sb2NrX2lycXNhdmUoJnNlY190aHJlYWQtPnRocmVhZC5jaGFuLT5sb2NrLA0KPiBmbGFn
cyk7DQo+ICsNCj4gKwkJdGFzayA9IGxpc3RfZmlyc3RfZW50cnlfb3JfbnVsbCgmc2VjX3RocmVh
ZC0NCj4gPnRocmVhZC50YXNrX2J1c3lfbGlzdCwNCj4gKwkJCQkJCXN0cnVjdCBjbWRxX3Rhc2ss
DQo+IGxpc3RfZW50cnkpOw0KPiArCQlpZiAoY3VyX3Rhc2sgPT0gdGFzaykNCj4gKwkJCWNtZHFf
c2VjX3Rhc2tfZG9uZShzZWNfdGFzaywgZXJyKTsNCj4gKwkJZWxzZQ0KPiArCQkJZGV2X2Vycihj
bWRxLT5tYm94LmRldiwgInRhc2sgbGlzdCBjaGFuZ2VkIik7DQo+ICsNCj4gKwkJLyoNCj4gKwkJ
ICogZXJyb3IgY2FzZSBzdG9wIGFsbCB0YXNrIGZvciBzZWN1cmUsDQo+ICsJCSAqIHNpbmNlIHNl
Y3VyZSB0ZHJ2IGFsd2F5cyByZW1vdmUgYWxsIHdoZW4gY2FuY2VsDQo+ICsJCSAqLw0KPiArCQl3
aGlsZSAoIWxpc3RfZW1wdHkoJnNlY190aHJlYWQtPnRocmVhZC50YXNrX2J1c3lfbGlzdCkpIA0K
PiB7DQo+ICsJCQljdXJfdGFzayA9IGxpc3RfZmlyc3RfZW50cnkoJnNlY190aHJlYWQtDQo+ID50
aHJlYWQudGFza19idXN5X2xpc3QsDQo+ICsJCQkJCQkgICAgc3RydWN0IGNtZHFfdGFzaywNCj4g
bGlzdF9lbnRyeSk7DQo+ICsNCj4gKwkJCXNlY190YXNrID0gY29udGFpbmVyX29mKGN1cl90YXNr
LCBzdHJ1Y3QNCj4gY21kcV9zZWNfdGFzaywgdGFzayk7DQo+ICsJCQljbWRxX3NlY190YXNrX2Rv
bmUoc2VjX3Rhc2ssIC1FQ09OTkFCT1JURUQpOw0KPiArCQl9DQo+ICsJfSBlbHNlIGlmIChlcnIp
IHsNCj4gKwkJZGV2X2RiZyhjbWRxLT5tYm94LmRldiwgImVycm9yIGJ1dCBhbGwgdGFzayBkb25l
LCBjaGVjaw0KPiBub3RpZnkgY2FsbGJhY2siKTsNCj4gKwl9DQo+ICsNCj4gKwlpZiAobGlzdF9l
bXB0eSgmc2VjX3RocmVhZC0+dGhyZWFkLnRhc2tfYnVzeV9saXN0KSkgew0KPiArCQlzZWNfdGhy
ZWFkLT53YWl0X2Nvb2tpZSA9IDA7DQo+ICsJCXNlY190aHJlYWQtPm5leHRfY29va2llID0gMDsN
Cj4gKwkJc2VjX3RocmVhZC0+dGFza19jbnQgPSAwOw0KPiArCQlfX3Jhd193cml0ZWwoMCwgKHZv
aWQgX19pb21lbSAqKWNtZHEtPnNoYXJlZF9tZW0tPnZhICsNCj4gKwkJCSAgICAgQ01EUV9TRUNf
U0hBUkVEX1RIUl9DTlRfT0ZGU0VUICsNCj4gKwkJCSAgICAgc2VjX3RocmVhZC0+aWR4ICogc2l6
ZW9mKHUzMikpOw0KPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZzZWNfdGhyZWFkLT50aHJl
YWQuY2hhbi0+bG9jaywNCj4gZmxhZ3MpOw0KPiArCQlkZWxfdGltZXIoJnNlY190aHJlYWQtPnRp
bWVvdXQpOw0KPiArCQlyZXR1cm4gdHJ1ZTsNCj4gKwl9DQo+ICsNCj4gKwlzZWNfdGhyZWFkLT53
YWl0X2Nvb2tpZSA9IGNvb2tpZSAlIENNRFFfTUFYX0NPT0tJRV9WQUxVRSArIDE7DQo+ICsNCj4g
Kwltb2RfdGltZXIoJnNlY190aHJlYWQtPnRpbWVvdXQsIGppZmZpZXMgKw0KPiBtc2Vjc190b19q
aWZmaWVzKHNlY190aHJlYWQtPnRpbWVvdXRfbXMpKTsNCj4gKwlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZzZWNfdGhyZWFkLT50aHJlYWQuY2hhbi0+bG9jaywgZmxhZ3MpOw0KPiArDQo+ICsJcmV0
dXJuIGZhbHNlOw0KPiArfQ0K

