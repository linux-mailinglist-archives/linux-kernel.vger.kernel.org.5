Return-Path: <linux-kernel+bounces-6494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84E48199A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B681C220EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91BF18637;
	Wed, 20 Dec 2023 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P7++SjMr";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Rv/AZ9EE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4E1775F;
	Wed, 20 Dec 2023 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8228b7e09f0a11eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WtYjAXFT0eXBVhrZ1wmxOv0sZVtsLm28htNzWpMoA20=;
	b=P7++SjMrqvF2uC9fgJ7qFuRDyH/DBZUK2kBZ8bCI1Glzox3L4s3k1FZ6e/zEFJtgMrRjjdwjsD/qSUyLqrnlWKarDTz48zaTQI1Himxxn1Dsxrxyi6bBMTEjRNvzkPDLDUmFM4JBmgr0Zljpj1yZhbS5hbTcBJ58XWKGtCUNxwE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f1d531d1-9d84-4055-9165-cce80743a5d7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:8ecdf881-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8228b7e09f0a11eea5db2bebc7c28f94-20231220
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1382449833; Wed, 20 Dec 2023 15:36:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 15:36:36 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 15:36:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOLBPKfpJIUgCl7faIzyThsR8oiRvTaMQGNWUA8RstgJRPJ0RK0v75Xwy3sVgOj/u8bWbvmjIYwaCXp65U56Le/gTTEKByhfsNpSceo7F/eaWc5efOeNbpRegWWdVs7aE5igx4S7UbP63nsvoDSpHqqw12zTkppmML3Ka4ANmu+sRZ4C5GVGEVqXpe7QMPQWe8/I6OWzGmU1D2YWmskF+DxKc6KNlsSr77e8sClPr1idSnkEuhICxDjDUp4x+Dm8dzH+QUNLrs9qQD6HiYYPXqfmuyaJ91G9FakZsBz8anRh9nddawDBbUlJax2gIZGdka6b+LWOmM9fPkv9iXzaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtYjAXFT0eXBVhrZ1wmxOv0sZVtsLm28htNzWpMoA20=;
 b=QY2Pgmwj9Rlvu9EEtcAnNYZ3+uJkPFsK4AtYONiV89a8LYXH4yauhyKpZo8NjFB/JKykDAqexUKCSt92Lg/JF2bOrvyGbdgMKfLoLz1ORsLKC8RB6NktsrkS8bGFTOugBoMwd1YW33Ad8KsJXguqRFde4CVTJBatEC8L8sYC1hzA97dUIL09DeB35syHT85tTz7O9Uc5Xk+H+24+m48MpcShUG//U3HHS7EmJHwXlVpSDuWf6th5v6ntYnh8m9CfF4E1EzMSaYGkADdMryO8nfzEDYneKfshf8A2HTWIpd0srzoPojitet30wdOKqM5nx5R3M9yt2nH3LqlE11wYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtYjAXFT0eXBVhrZ1wmxOv0sZVtsLm28htNzWpMoA20=;
 b=Rv/AZ9EEKXSpp3laB+hqpgfJB07srjSVQaVKnp8LoXUeVOu3WVXELEe6bipqp7Qhhp1A/8nTo9217wVRSupjS3NBalIVqucfFFxNG00EyA4bvfL8JxWgtvCuhT2b9ddPEwYRIp793UbeX32+Btj1EsOa4K7ivm26mB+qq8k7ky8=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB7434.apcprd03.prod.outlook.com (2603:1096:101:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 07:33:31 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 07:33:31 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
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
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: mediatek,gce-mailbox: Add
 mediatek,gce-events definition
Thread-Topic: [PATCH 1/3] dt-bindings: mailbox: mediatek,gce-mailbox: Add
 mediatek,gce-events definition
Thread-Index: AQHaMY15yDyroEGuI0u0q/zk1UgcpbCxw0yAgAAHQQA=
Date: Wed, 20 Dec 2023 07:33:31 +0000
Message-ID: <c74f9c3418fa89eec6e5925573e3f846163c346f.camel@mediatek.com>
References: <20231218083604.7327-1-jason-jh.lin@mediatek.com>
	 <20231218083604.7327-2-jason-jh.lin@mediatek.com>
	 <cafae4ec-337a-4134-8545-d86c4c61c858@linaro.org>
In-Reply-To: <cafae4ec-337a-4134-8545-d86c4c61c858@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB7434:EE_
x-ms-office365-filtering-correlation-id: fb9ffe79-21af-4a19-bba5-08dc012df762
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2hvNrWIlROdgIDNO82oLMOi0+a7hOZnw1bEpfAim/LOT7Kr21BI7wcFRw/KiamMsTiXfUpuLUOR15UnQW3O6UnLIFfMcWJQ0AFNVd5rDfUhzWWG1Q/zB8YBOkHEQtHIdLDeb8udhuhCQlhjnkpqvcDyXN7h6GxTrgga4U0F0I2r+8Jk4hba0yrsRhOL67NIiE6QsndrbNIFwE2nKCkQN0uUIsQCjRsMSISFzyiEhgnw4Ux4aK/vY5vggJzK43VBJjZ6MLuntaSlrg995sR9dquMwzGDM98cQtCAaQXg2v2RNhyKdv5QDH2FPFmngHbBD1of7RWC4UIEwfdV8o0+SOC5rZtbYQVc79UDNXRM2VQbYD/83D2UsoR9f1X6zENLEcND0mPvXvIqF3MyKln32O4ZWM+7tSi3JnVGbeI9Am+NVm90taYMRnIXey2GhszQVRHLfZeDUw3XW/l7ykj7lECT0OoIqOHgobjNSwjyMH0wPvydSFeA0XTC74V6cpVrYV+/uZBo5DeIpkqoVX721DhOt4TFGwBRe90dxNqjvv05oHjOE/f7+8HEHE2o9gMQHUKBsV6LjwDRy2wWrQpVuTQnq902KO3ReWLVQkCpgYCQWlLtVb4yNdeEtxl1JmxkpMmp8gj6ytdF46+AtOwVZ3YDquJIZV4D2p55RzkxP7Bl0o/16FG4VxPIkmbNmKEmgrUXQbwUAK9q2MbKlMKRfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(76116006)(110136005)(8676002)(91956017)(36756003)(85182001)(54906003)(66556008)(38070700009)(8936002)(64756008)(66946007)(6486002)(71200400001)(86362001)(478600001)(6506007)(4326008)(5660300002)(2616005)(6512007)(7416002)(53546011)(66446008)(66476007)(316002)(2906002)(4001150100001)(15650500001)(26005)(83380400001)(38100700002)(122000001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk55SGdXb3MwOFpIOEx1TGFGeEdxMlprZHVzYjNKeWZESDlTaWVvQytOZ0M0?=
 =?utf-8?B?eWx6bEJEbS9aQlZBbk9GK2p4ZkNKTWtuY0NuV0VMY1dlRHJJSDNOdlgvSks3?=
 =?utf-8?B?ZHFyY056bjFxQUVialBrUnd3elVrd0NQbVY5eG1LaTNhQUdjYktOMUZDWTI3?=
 =?utf-8?B?NzRDYVJQd1NhL0ZXVUcvR0U5ZUxMbGNnY0djMSswc1J0Nk1FeGlETS9PNWwr?=
 =?utf-8?B?b2xxd1BoZlROVkV3WkYvOTlDQW43Mm5nTExoV2xxTTZxMU1SaGNObXhIbkhv?=
 =?utf-8?B?S29VTzEvSUp6bURERzlCZ1hsR1F3Qk5DV01WTWFxdE1jUjB6RjJNV29jRG5z?=
 =?utf-8?B?aGREUEFTSEhyZFBsZzExWUlUVFVpRkE1WlpuRjUrRytIMmRBajZlK1llM0ps?=
 =?utf-8?B?WjNNWmRhbWU5aHVhWjNWUVBLZzF3RnN2YmswL0J3ODAxQjJubnc0Vk1pQmRL?=
 =?utf-8?B?K1BrK3FPUklCWW5taVd5L3d5RnNacWdOaWZWclU0QjFVaEk4NjI5WStKL1lK?=
 =?utf-8?B?Nm9vdzBKVktzVlNzOThINkNpMHVVSXNrMXYrRlpveE0wdjl5RFg4cWJ6a3dq?=
 =?utf-8?B?dGNpWTZpdG1XRmlqNWhKZU9nYkFVQTF3M0drRWdacDQ0by93N3YxRWJHS213?=
 =?utf-8?B?RjlWYU5WQzhCMGx4RC9zZ1R3aytPVnM2V2tuRG9PamRWbmFCWDZQd05aYlZ4?=
 =?utf-8?B?SFRSeVYrY1BOUnRnU3JkZHhwMUZHdlBSeWtRaDU0bnVRcGMxSDFhaWRGYjVT?=
 =?utf-8?B?VUd6YXpyN015L0l6K2FxVXZUd0NWQU05eUo0U3NVeWRKdktRUVlDN3VvRFRR?=
 =?utf-8?B?VHp6cUFoTHA5SnJDQnhpVDdNWXJ1SXlkVGJ0STZzdHhMTWJCMDMzeFBoN2Vn?=
 =?utf-8?B?QU5KMGorZmhlcXkzSVJONzdiaFdkY2xIbTQ4WmQ1VDIxcjhmdTRkWU5Va0k1?=
 =?utf-8?B?VHpITmFSa1pFSVoyNVVqS2lYL0E5Y2V6U2duNHM3ekh0UHo4Q1F2WFE1cUN2?=
 =?utf-8?B?S1lBbnBMeXRuMHRGdHFiNDA2UlJVVnFreDZNUWF5VWtJdzAwUzFxeTFNTG9k?=
 =?utf-8?B?bldFV0VVUFc0TU00Zi9zU1FMVjl3Y3JjbFIrWk81RG9OZ2lsQkFuQUhFbjdk?=
 =?utf-8?B?WHBKU2pXYi8xVkNYbWRieTJWa1hweXR6N0dFeHVyU2tpK1dySVBOKzZ2QnA1?=
 =?utf-8?B?QlVMQldUTTE3QlRWS0NqWUFxRjVwZGdQWlUrTWZ2N1BkYXFUejlQS2lqVnVs?=
 =?utf-8?B?ZzF6aDBLdGZNb2JPaDAwNXJ0eWZiNGdIdzB0WWcvOHRxejR4QUdTdHVaL3lE?=
 =?utf-8?B?cXM0d3FqYlNZbkEwVlY2VkJWV1dhWFYwZWFlSlB3VlREamt4ZlVkNS9XRXcx?=
 =?utf-8?B?OGcremR6c1pMUmtRZEpsMzJrR0FmcGhXRFpxM01TNlNUSUZ6bnVkUVZUMHJx?=
 =?utf-8?B?N3NENXZKZWk1VWh5UGR5MzU2RWJ3TXJFWE9aMUVQb3d1UXk5VnJjbjIwUjkw?=
 =?utf-8?B?UE1za0ErYzk0bFlGWjVkZWViTGRiRThGakpaQjY1d242UW1EOHIzZjZGOXdx?=
 =?utf-8?B?czV1d29nZzNKc25VdFJ5WnhFY0JhS09zS2VBb1pGS1htTXk3bnZ2Z0VEVi9U?=
 =?utf-8?B?dElpd1BhQWpvQ29zVDAyRHJsZGxiRDN2b2NxK1V4QWlPbjdUNGVFTFZkS0Nw?=
 =?utf-8?B?SFhTLzk1ajkyT01qQU1JRmxFcDRSOWNNVWlTQUhGV0I3VVhSemFpT0Q1OFV4?=
 =?utf-8?B?V2E4VU1EM3NiaGJpd3FGSVRFeFBwc3VwdWZZMmFTUndKSWhkcnZtUml0UWZG?=
 =?utf-8?B?UWlXcjdoTW9MdThCMVJ4WFlHcWhIM3JYTUxHQ3RnQVg5NnJkWFdKbkVDTFFl?=
 =?utf-8?B?b2xDM1hWa0I2U3RDNHNNZnMzTC85T1F1NmZoVGJMN3M1WGJEVVpMd1owYmlm?=
 =?utf-8?B?Rk1QenF5dVJPcmVURjh0eCtFYWdzK08yZlovcVdZTGNmSVIyalJ6WmgxempI?=
 =?utf-8?B?K3JvQzIyTlRDN0FFck5xQXgwaENNNURvQURoNGdGUzJKeTd4bUZlRDdjdkd0?=
 =?utf-8?B?UEh2UnV0dTNzTlFENFVQL0ZtY3BxbUxOVjlrTHRQb1ZkcVZtNnR3RUdPV3ND?=
 =?utf-8?B?RXorNnpObFlnL1BLN3lITWhzbCtsVEpMNDMxc2t5d2M1S3Rjc0k0VnZCaXg3?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B779149D564A64EAD510DD313E138D7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9ffe79-21af-4a19-bba5-08dc012df762
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 07:33:31.5074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oD1STE7zLtqPrbuFek5Rph0i9oe7MyT6VTjDZSu26o+oqSskm3UzHSGXZO+ZHG4Q71K1h4fBBMdOGZ+4JFO/F4eQkuPLaK8kAvZ98pGp40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7434

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBXZWQsIDIwMjMt
MTItMjAgYXQgMDg6MDcgKzAxMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiAgT24gMTgvMTIvMjAyMyAwOTozNiwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IFNp
bmNlIG1lZGlhdGVrLGdjZS1ldmVudHMgcHJvcGVydHkgaXMgYSBIVyBldmVudCBzaWduYWwgZnJv
bSBHQ0UsDQo+ID4gaXQgc2hvdWxkIGJlIGRlZmluZWQgaW4gbWVkaWF0ZWssZ2NlLW1haWxib3gu
eWFtbCBhbmQgY2hhbmdlIHRoZQ0KPiANCj4gV2h5PyBOb25lIG9mIHRoZSBiaW5kaW5ncyByZWZl
cmVuY2UgaXQuIERpZCB5b3UganVzdCBtb3ZlIHByb3BlcnR5DQo+IGZyb20NCj4gb25lIGRldmlj
ZSB0byBjb21wbGV0ZWx5IGRpZmZlcmVudCBvbmU/DQo+IA0KPiA+IGRlc2NyaXB0aW9uIG9mIG1l
ZGlhdGVrLGdjZS1ldmVudHMgcHJvcGVydHkgaW4gb3RoZXIgYmluZGluZ3MgdG8NCj4gPiByZWZl
cmVuY2UgbWVkaWF0ZWssZ2NlLW1haWxib3gueWFtbC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLW1haWxib3gueWFt
bCAgfCA3DQo+ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWFpbGJveC9tZWRpYXRlayxnY2UtbWFpbGJveC55YW1sIA0KPiBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS1tYWlsYm94LnlhbWwNCj4g
PiBpbmRleCBjZWY5ZDc2MDEzOTguLmU0ZGEwYTU4Yzk0MyAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2UtDQo+IG1h
aWxib3gueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
YWlsYm94L21lZGlhdGVrLGdjZS0NCj4gbWFpbGJveC55YW1sDQo+ID4gQEAgLTQ5LDYgKzQ5LDEz
IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBpdGVtczoNCj4gPiAgICAgICAgLSBjb25zdDogZ2Nl
DQo+ID4gIA0KPiA+ICsgIG1lZGlhdGVrLGdjZS1ldmVudHM6DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjoNCj4gPiArICAgICAgVGhlIGV2ZW50IGlkIHdoaWNoIGlzIG1hcHBpbmcgdG8gdGhlIHNwZWNp
ZmljIGhhcmR3YXJlIGV2ZW50DQo+IHNpZ25hbA0KPiA+ICsgICAgICB0byBnY2UuIFRoZSBldmVu
dCBpZCBpcyBkZWZpbmVkIGluIHRoZSBnY2UgaGVhZGVyDQo+ID4gKyAgICAgIGluY2x1ZGUvZHQt
YmluZGluZ3MvZ2NlLzxjaGlwPi1nY2UuaCBvZiBlYWNoIGNoaXBzLg0KPiA+ICsgICAgJHJlZjog
L3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5DQo+IA0KPiBXaGVy
ZSBhcmUgdGhlIGNvbnN0cmFpbnRzPw0KPiANClNpbmNlIHRoZSBHQ0UgSFcgZXZlbnQgaWQgcmFn
ZSBpcyAwfjEwMjMsDQpJIHdvdWxkIGFkZCBtaW5JdGVtczogMSBhbmQgbWF4SXRlbXM6IDEwMjQg
aGVyZS4NCg0KUmVnYXJkcw0KSmFzb24tSkguTGluDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCj4gDQo=

