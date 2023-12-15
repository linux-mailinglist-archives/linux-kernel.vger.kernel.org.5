Return-Path: <linux-kernel+bounces-672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99939814444
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF137B224D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A261C28F;
	Fri, 15 Dec 2023 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DyGareae";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sEYakVVt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580831A718
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b93533e29b2911eea5db2bebc7c28f94-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LUf/zao1tyQyA3Hd/0HgvMz61c0XTc3dOIQSqXn+tqI=;
	b=DyGareaez/p+UdruKHeUnDbH/vIbqpHIPiRq1jPiZ2fXBI/vWIS+0P1xZV2v31b5g2QQs9tzFhkjoh5Zv1KqmdM1D329mqT+KDAMBllx2WBnD0UbOENR1bZWhHZ2S0X8pjO/3tbjjpovVO3h7k4WR6vOpSM9+MYrrOi3Aj4/AHU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c596d742-47dd-4309-a13e-37ab50510692,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:891f37bd-2ac7-4da2-9f94-677a477649d9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b93533e29b2911eea5db2bebc7c28f94-20231215
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1410674426; Fri, 15 Dec 2023 17:09:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 17:09:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 17:09:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG5fNl1qpr9ytkba84PB5KCwKE2IvUurHDhtCY8cFx82HHcBPjfF1O1AaKUFCTnuxy1mQissxIavlqeOd/vJEOfZaoiGq9vbC2StzCjRRUQrWOxdS5y6BL7Ti+XN2BSWe4AjCExcjjAw4GQDFI6QKerYVb/GMslVIamBYw8XrLRNv1LylsRS1THcLJ4/76Sc8FzNoFakDBE90uVup5DwFxrGFPAXVRhabOMndUUMwATaXpVPJsMDQm0OcR9xPAj+zjVrAwfg9u8Q4LXoACEUWyQWHZlWeAUXIWFavfUlu9Brhx2Q/NLStSbaqWEhxN6bFjAHjIgpSE9SXiP+UTjSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUf/zao1tyQyA3Hd/0HgvMz61c0XTc3dOIQSqXn+tqI=;
 b=h8gGRC4uymGbStnK37gzG29fbDZo79Fgop0i5L84ZqiHJOzP4WUw4C63B/qZ2C00aLyH9YX2xKc17WkYO9mJyfOz4jtOuaHDKuetg5RtK+IsDaTRn6TawZDaIHQBtzuGmPqOrgLRbSDL+gHtrWz6tUvUGwzNDiayMt7sI6hg5Vd0sgtwmEuC5qlnCWTNk/lbsPQ7tV2kbsf8K5p7KV/+sH8RUKKpfFiczX616mAj1GS5FKrQEKHqxfih0PzLHLTLg7EIWqZCLjixo8oldhF1DwxQvcaPe+ZTSmONgIkUnzP54ZhqNdrEDJyHcru5MYZrcfWcJwFyalSoDSkMMzfENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUf/zao1tyQyA3Hd/0HgvMz61c0XTc3dOIQSqXn+tqI=;
 b=sEYakVVt1kJoDSj0Veo8fzWF0y5onp2rRhijFrp+4MreTJc+HmtwFwNCutIRLVy5Jg+wVdCM1UermVU5ZST9WdFqaN5YQGf+XBtXZkl+Mg3nQZhRPilFxJI2D6LowAvMIWQ4wmgqPtVfSwW3SdUMKKLwYTh6d6yI2/xiCWmDcS8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7075.apcprd03.prod.outlook.com (2603:1096:101:e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 09:09:55 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7068.031; Fri, 15 Dec 2023
 09:09:55 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "jkardatzke@google.com" <jkardatzke@google.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 3/3] mailbox: mtk-cmdq: Add CMDQ driver support for
 mt8188
Thread-Topic: [PATCH v2 3/3] mailbox: mtk-cmdq: Add CMDQ driver support for
 mt8188
Thread-Index: AQHaLzPzanX+hX69dUa93DsFTCQWsLCqDoiA
Date: Fri, 15 Dec 2023 09:09:55 +0000
Message-ID: <7f2d0d718397c599327e7a76a7b5b638f96133f2.camel@mediatek.com>
References: <20231215070026.2507-1-jason-jh.lin@mediatek.com>
	 <20231215070026.2507-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20231215070026.2507-4-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7075:EE_
x-ms-office365-filtering-correlation-id: 08bbde2e-6d2b-4d0b-5f45-08dbfd4d9b06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mQXRsi7QjXfu8KleXr25p4kn5csHtJEMgbhdICnaE1PG78reF+SN844UT8tne3OuSAE0sYFeY5KVQw97kfM8Ahd3wQ/XvqyAX4XUNCiQprtohLVayAqG09KZC926SpnYF7iyzt2Rr/SF2Y+RmileP/QBucRCLiU3uEmUuK1aBcYIuEzgXaVRS1dThDt6596g0kg4vM7xQ7isHodxJvdXKByCY3bMUvToKch+EyMDOyv5NRhfzhNlrgitypsxnj4gnWBXTgIpV6T51bxkp8wfSdIJEZXTCG1qTKCHstn7oF1uV1cUNnzEGN6ZPWWYH4PUu/AW8v5x6YMYiY0B1UE2o0iNnCM5ZcI2XFhoThvcUOiRQSGdAEg/PSBz4UVDGDyYj6bUZDt6niu/GzfNcPVDuNXLGQNpqNlxSO2Oeo6sZqtDfWuyreReuoFO2spcQGPkVuYV2ugCWR+PUb7wQ+Q1WY/tCzmFu+gyACKE7LPb+jmkfl3JnbQBYbtRaSi9fZ0S43QcMPAfsRa3eYbZu2R4wz3zpyK2tmtZypeG/ayOtEhNxkomjEWpHxGjO9zP2QhKcyow+SDu1wu9+9EzhN/2Dxhru0MhyVCFCK/jilcYrlr1Cys4Jt8sFpVX+sXku0WKggTRX18iKX6lEwgzmHfqtpxY0IcZBApghMAGW8aW6UU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(15650500001)(4001150100001)(86362001)(4326008)(8676002)(8936002)(5660300002)(38070700009)(85182001)(41300700001)(36756003)(478600001)(6486002)(83380400001)(2616005)(26005)(6512007)(71200400001)(6506007)(110136005)(66946007)(76116006)(38100700002)(122000001)(54906003)(66556008)(64756008)(66446008)(66476007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlAvcmVuQVdjQUNHNUgwYlBoUVROc1k1cGduRmU0eStxblo1cUlQK29leWRF?=
 =?utf-8?B?V2tFN25ZUGlxZXh1UmpZVXBXMFdNeUtNdVMwN2dxdHVoTkY1dzJrYmtxTTdl?=
 =?utf-8?B?MGlwblMxU3RrMEtaNnhhQk94dVM2UUJ6cThjMU5FVU5iV0hHY0JuZVBPeitS?=
 =?utf-8?B?c3BrcGJMMGlVaXpmUXd1cFJNRVRLc2VqV3JBS1U5V1B6YTRJUWF2NHAvRXZD?=
 =?utf-8?B?eVRNUnkxTzlnR05xTGFmb2x4WkhIU0lhMXdKV0dsKzE1SEIvejJCUENZUXZn?=
 =?utf-8?B?UlFMTHVZY1JkTC9lQjdOSFpUYm5JQnJXODBsOFhWNUFpSUMzNytJeE1vT1Vt?=
 =?utf-8?B?RlUyanVUdXJwSFhRY09wQ2U3UlVMWHZpTDJqVUxidDByNysxa2oxYklGYkdj?=
 =?utf-8?B?eTltQmJzS0kydCticjBiRTYzNjN2clozUWpubzZNOUZiN1Jyc0thWW5PdVBl?=
 =?utf-8?B?RU1wVks5Rjg4ckJJdnROOGJtK3djVVp4M3dKMjBDanFNNjdtTmdUWVErTEg3?=
 =?utf-8?B?RUZmMG1QbkJSaFBrV3g5N3R5Sm9XNXFaN2VIK0pBRGxFYWZKNGxyMHk0eGNH?=
 =?utf-8?B?K2lOTnNiNVEvYjNESjRESjVVZ0dUSFI3RGw1MnRaZEhsZzBmTHQrSmx2MUg2?=
 =?utf-8?B?Q0p2Rm4ycGdxVFQ4N3EwL2J1anI2NzBwcWhGNmQzT2hGblJGajNCNTE0OHVM?=
 =?utf-8?B?aTNmbGVMQTdGUmQwOFVVdllzN09CRkxTWUZCMUhmdWRBbEUwdDJ1dHF1TTNn?=
 =?utf-8?B?RzY1VkFUblBOUXBEd3NoUFdta3BtelVyaVc5dUZRcUpWaFcxamx3M0ZRV0Jm?=
 =?utf-8?B?Snd0RHFTanA3b3cvQ0lZTWJPd1FiYUdvRWoxRlBJSWxvY0FJSGgxRWd0MTBU?=
 =?utf-8?B?QjhReExJdlJMUUk3TVlGenM3ODkzOTZvYjNhZittRVFRcXRvWmFoRnZ6U1Nv?=
 =?utf-8?B?SWNqcGUxY1lxQ2ZjM1JzR3RTSkpNNWdNWkxNalJDTnZOOTYwencrM2RMSnpz?=
 =?utf-8?B?K3hvWFdOVkdTdG9JMThRWUdQS0ltQzhUQytpd3BzTDBvMWNGZC8wcHdhUW5Y?=
 =?utf-8?B?MTFQRWsvR3hUbXVCT2ZTOWdnT0U0N3Iwd0tiYkdSeVZiM042TTdYYmJESlcx?=
 =?utf-8?B?elEyTFJVRmNEQXBIWkhpbmlKTnNHMjRoS21iT0szNGptTGVBRTVRa3l5V2Uy?=
 =?utf-8?B?QlkxVmlvQkd3K29GVjMwMEFyL3hvbUhzNlQ2VVZ4ZzhaV3QrcmNxNllEK1No?=
 =?utf-8?B?NW1LM1hJUzRNSWk4RDFuZU1jcnhJUlU4NE1sZDFTcEJzd2RZWkNWWEp5RUxl?=
 =?utf-8?B?Umx2QmJGUjVVRVU0R1l0RUc0ZEJoeUlVc1A1V0syTUtMWnUxYnZRQjFRN1Np?=
 =?utf-8?B?WHJZM2VFUVFWN3BpdXhEbEFMQk16ZkkrZlZLaDljTzJPOFA4c1JyYmU0M3c1?=
 =?utf-8?B?cm1xS2s2bCtXVHBISTJlSjJjTjFleGZ5SlVqa0lPbGJSUnJsRUZBd3pBTGhh?=
 =?utf-8?B?a1Y4VWpHbi8xTW5TVWtFMlk1SjM1VnMwTDRZY1plc0ovNXpNZUk1QWJPSlk3?=
 =?utf-8?B?WmR1dlBiTWVnVm5FL3o0UFN0SDBOVlZ4TGJ4WDFRVHpZNG53T3V3QTNsRzlZ?=
 =?utf-8?B?QUZ3djU1OHFaTG1RaFVWMkpTTG1BWVk4ZVZDVkl0T2FUTU1uT0o1dkd3NVcv?=
 =?utf-8?B?SzZSOVRzYlJPR1lzTW8xeXJ3NkwrRm85cjAvN0lwcEp2bDBhVHJ1Yi9HQ2V0?=
 =?utf-8?B?TmY1R1puVjExM3ZCb2l2WVhyV0J2Z2tVRHNWeWcvdm9Oa2pKT0Mrb244clhw?=
 =?utf-8?B?RDFWSVJ6cVR3aVZiV2dzUFVIR2lyZmFFVDBFNVJrZkFUYUVJenJpb0g0RlBz?=
 =?utf-8?B?Umg5ejhDcXByOHNkSlFOZDlCcE12aytiTldsakVmdzMyNnNieWtCUDVxUjNL?=
 =?utf-8?B?TC9NV05UZVVpVWwxK0FUbUl4QkNlU0dGZ1U4MUJtMG5JcFRsZE41L3B6Z2dG?=
 =?utf-8?B?WWo2WE5Gd0RNMjBXSjVwVjRZN0dxYU10cURMaW1nTkZUV3pPNlNPemFhTldW?=
 =?utf-8?B?Vk82NHZFSFBYUFVKTU5FVVBpNnVKNWUwUTFVOExuR05xVUhRT0tWSWwvNWRl?=
 =?utf-8?Q?Ym/SXgL3lvUo4dymLQVxZX3jH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FBDE881FE655F479C3C6758CCF04F2A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bbde2e-6d2b-4d0b-5f45-08dbfd4d9b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 09:09:55.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+S82uboYkN+3O6XTtvSLYg3HHqPUBJFsMfPA5//3McbCibW8TvoX6DZBOraIX0eW+qnVQ6b98iGgVNQ4LlyiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7075

T24gRnJpLCAyMDIzLTEyLTE1IGF0IDE1OjAwICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+
IEFkZCBDTURRIGRyaXZlciBzdXBwb3J0IGZvciBtdDgxODggYnkgYWRkaW5nIGl0cyBjb21wYXRp
YmxlIGFuZA0KPiBkcml2ZXIgZGF0YSBpbiBDTURRIGRyaXZlci4NCg0KUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpI
LkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jIHwgOCArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMNCj4gYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IGlu
ZGV4IDM5YmYwNjZkMzc2ZS4uMjdmZjNhM2NjZjJmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMNCj4gQEAgLTczNSw2ICs3MzUsMTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBn
Y2VfcGxhdCBnY2VfcGxhdF9tdDgxODYgPSB7DQo+ICAJLmdjZV9udW0gPSAxDQo+ICB9Ow0KPiAg
DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGdjZV9wbGF0IGdjZV9wbGF0X210ODE4OCA9IHsNCj4g
KwkudGhyZWFkX25yID0gMzIsDQo+ICsJLnNoaWZ0ID0gMywNCj4gKwkuY29udHJvbF9ieV9zdyA9
IHRydWUsDQo+ICsJLmdjZV9udW0gPSAyDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGdjZV9wbGF0IGdjZV9wbGF0X210ODE5MiA9IHsNCj4gIAkudGhyZWFkX25yID0gMjQsDQo+
ICAJLnNoaWZ0ID0gMywNCj4gQEAgLTc1NCw2ICs3NjEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBjbWRxX29mX2lkc1tdID0NCj4gew0KPiAgCXsuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxNzMtZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF9tdDgxNzN9
LA0KPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZ2NlIiwgLmRhdGEgPSAodm9p
ZA0KPiAqKSZnY2VfcGxhdF9tdDgxODN9LA0KPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxODYtZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF9tdDgxODZ9LA0KPiArCXsu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZn
Y2VfcGxhdF9tdDgxODh9LA0KPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItZ2Nl
IiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF9tdDgxOTJ9LA0KPiAgCXsuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxOTUtZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF9t
dDgxOTV9LA0KPiAgCXt9DQo=

