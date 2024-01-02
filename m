Return-Path: <linux-kernel+bounces-14112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90C8217F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC741C214D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC3420F8;
	Tue,  2 Jan 2024 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OyzBsL0E";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="v4nw1XrB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086520F5;
	Tue,  2 Jan 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 29e8834aa94011ee9e680517dc993faa-20240102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Jbo/jeyoBJSx7fMrGvB54oiiUnqmfQ11KXUv6xNbxjM=;
	b=OyzBsL0E9vgZ8Thye/jeWSsliYOebYp9W1ElkuPzwtEXUM8LwIBnlluusXYG9kg9i1CSFE3UJ7EOOym9BQ0qPjTtG6q8BpAdGeekaG8fgx/YUfzLuQGiMD9fTGd21uMOtKj42ySYeLnuc6OCbcvCKCdgimIKlRRp2xBV8OdytB8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a2f9e817-99ef-4783-8de3-3033d8ba7ec4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:02e9cb8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 29e8834aa94011ee9e680517dc993faa-20240102
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1171522851; Tue, 02 Jan 2024 15:25:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jan 2024 15:25:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jan 2024 15:25:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KArURi7NUb8cYzihbhyOkjQn00yEi2YAjdmgR2gpIieVTnTqPI+VwHsZ/OLGW//PKjdGIt9PO8oqlvACT57vX23w/LKIPyN/CftGQDqTPF7Z+trS4x7wUFCuJjUUZn6yP/jVAtiq7zsXo3nxKNeK4p5SKRc3F/Y6I2MLjpt7BQJ5jhCTHijwBOcD9I928JQlcPuAxIYowNakdj/QgsxeH3ZQyUg/b648VejGj0pO8HheCTKBzkbX8b0aatotLryrm4mnNxjfT9IClwAqOYsnlfiUSvR6UgfR+EEqyiSvS2a5+kqVuz/doXtkn6q/4RSeih3vQ5APbsoFZx25RpV//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbo/jeyoBJSx7fMrGvB54oiiUnqmfQ11KXUv6xNbxjM=;
 b=PfTrrB/zP6dBEPjwTmxld8i+c+MxI3bKDC+KIZpAQea/bcH8hY8tq41eaKvUSssaEJAix5a1IfGE9nqb/6GWiGYDLsGXj1c26xhrfE5oy69UMWjAFSkQ7xJy1tWD0NqtWnbPjwzqQgvoKM1QkziXHLjZLRSO68m4+Jx76YuZYctUFmCxFe/3xRPf73sUJkoBzHne3dsnt2OvRXpGmH+mJI1Sl2JwEpnshFegRvD7CS9kCipuKn9e4hM9yCFBVScEAAYSmFwJW9HIu5EB0F9bQdLg/x+SgZfdzFxAgeeer4elHt+zHDb1jOyC55NaoWMnwIBy1iauZP/e6WIdP454sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbo/jeyoBJSx7fMrGvB54oiiUnqmfQ11KXUv6xNbxjM=;
 b=v4nw1XrBeVx7BoEd/2Su6lgJtJ8JihZX6QFafgX2Qh1wRpv/oskDElVRFxzhMKqvXCbT8KRNt3VmWRhfl+Rslg4+eAHvD9RHTtoP4/jw6csEjABBsGpz94K/SLG/L/5FUcTL2s28ckXkLKtFLGySz968/OxmOu8x4sLIR9sgkR8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7417.apcprd03.prod.outlook.com (2603:1096:101:10e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 07:25:50 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 07:25:50 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "wenst@chromium.org" <wenst@chromium.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "sean@poorly.run" <sean@poorly.run>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "fshao@chromium.org"
	<fshao@chromium.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 10/17] drm/mediatek: Support more color formats in OVL
Thread-Topic: [PATCH v4 10/17] drm/mediatek: Support more color formats in OVL
Thread-Index: AQHaLPWW+zEKDNlfN0myBwFlVXsDjbDGP+aA
Date: Tue, 2 Jan 2024 07:25:49 +0000
Message-ID: <a09a124668826ae8a3282c21d15bc739632f15c3.camel@mediatek.com>
References: <20231212121957.19231-1-shawn.sung@mediatek.com>
	 <20231212121957.19231-11-shawn.sung@mediatek.com>
In-Reply-To: <20231212121957.19231-11-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7417:EE_
x-ms-office365-filtering-correlation-id: 0d9f65b5-2d86-4b97-9632-08dc0b640ba7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rAV4oONzt28R2WJMnceAy4RNbQvkAu1jJxID8jXBIlakbPut7VenhxHv595ghMs7BMfJBp84eiKQNd8GWmh9ictKQLHqJFA79/5oEfHSCjI4Vl2tJRpG3TR++fidOyHfHTejgDPvsnlefSEu2fJFl3ZER8GwgCWOk9Mm8IXFQocHE/cqBWxatCb8W0LaJw1Rr7BL0InfDWZpgXfQ3IfiDqI44YZreP/Bx3VlkGWZUkCxK1Mx2fyaStcDvQN1iBaXzUeKb0B0xiGgMCNV06k5R/hHmBNIqQ+BXo4JMaYyl7MOMlS6CuS/Hawthv7+C0g2lEiqGEN/vfHmx8cK1T/wr6AENviUruowCgddzhHYDRQIH9Y9vAh0ZVX4VgSs2HKKv+znq2rFxQqTsmqKaYynSSAzkEr3TD8YyC+Qqr3twRi1WzAcS0Qdg0mHsLNMnLuWi45uPIPzyIQofImPMOJaasfnzQZ1fkHLeicR26seXfUbGwNZv2wbChtojnx4k3d5Rp+uM2tz1hQ+TabnbSPLa6TZcFvEqa4CnZZbXo9pLOY2GLpzOKgrsLjuTPqY7MxcOzL0qP6m6QlSJgc3XvFMcplfuU4tCelXRXm/prkyfry1IfbMwwCf8hDuwxO5mQxfh7vFfNj5UZdWDPE8e2olnVndnIEA80vx/2J65beriY4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(85182001)(36756003)(66556008)(66476007)(6506007)(66946007)(6512007)(64756008)(66446008)(76116006)(38070700009)(86362001)(6486002)(38100700002)(41300700001)(122000001)(26005)(2616005)(2906002)(4001150100001)(7416002)(5660300002)(71200400001)(4326008)(478600001)(316002)(54906003)(110136005)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXREVkFKRFJPM1pVN2FzTU9RMUw4Z0RWVFIvTkRtV0d0Z0ZOaURTYUF3dzBU?=
 =?utf-8?B?YkxUUFhScnZhdDlqY0JGbzVqUkZJUCtNQzZsSDRIbUEzeGxUSFMxN0I3Tlcx?=
 =?utf-8?B?NTF2Q3RBeE9mNHlsSjN1U2VFYldjZGVJVE1ORndiMGlPV3BzR0E3cVNHS0lh?=
 =?utf-8?B?d3EyTExTcnFZNDByRTIvNERCMzYyM2xnRHZ6L1Fzeld3cWRlQ0o1TjQ2Q0lS?=
 =?utf-8?B?TTkyajU1cjNBVDMwMGtzRlVyYWVlWU5TekFsRk5vTWVyY0FqaUVESlpQOVJt?=
 =?utf-8?B?TnByUXN4K1RXeXJsSHRLMVRsODlHMnJPZkxvTFUya29hM3JlcVdMcDB0cml4?=
 =?utf-8?B?aElyK1Q0Z0FDM0thVTJnV1k0OWRQaUtVTXN4a0x4Y2REZFVMV2RDeVE3d0lv?=
 =?utf-8?B?ajBkL2ErZkozYlI3eko2Ti9OdFJ5aUsrNmFTMWxLdE9UN1ZCa3k3aVRSM3pB?=
 =?utf-8?B?Z2VaZTdTUFNETFRFZ0E0UnBRS05yL2l1KzcvVXJtMXpoOU5OZ0ZQeDgrc3px?=
 =?utf-8?B?cDhCby9EM0ZkSmtLR3ZJSlNUa0lZMG03MDJoT1d3MlJUMm03Z015VVg4ZXNx?=
 =?utf-8?B?N2RGZTFXWDdDUXpkTXNJTlQ4UEZmWEZST242NjI4R1NDU2k3ZlRBenROajJy?=
 =?utf-8?B?K3J3WWRnSVUxMjhoQ254SXNmeWxzUmlsaDVmWXNEb092MnRENE9JWHk3REY1?=
 =?utf-8?B?VUY1MXJaSVNMVUpsZmJuWDdkQTZKak8xdlM1ZGlCVXVTMEJDbVEva3ZTSVBE?=
 =?utf-8?B?dlp3VkROM09RRHNqMnUzZkVDMTYvTmt1dWw4bURPbTJaUHNGWGQ3THQ1eENS?=
 =?utf-8?B?cjVTRVFyemlpNkJXRlNVS0pZb0hINGtpajlsMEZsWjYyS3FYblNXeXRtMmVT?=
 =?utf-8?B?WHZEeHpyVThCWXE2NnIrR2VsQnV4SUN4UlNpUjJiMHlvZ1J1NTh1bHBVemtE?=
 =?utf-8?B?RjFhbFVIemVxZ09ydHFsKzhZenIyMkZreUNkcHdGOC9pNmVLdUlPVEhZL3Ja?=
 =?utf-8?B?eVh2U0pscjlCQlZEREplVlRkZmtyTUJRcExvMHgzU3p3TkpEMkRrZ0Z3dnVT?=
 =?utf-8?B?MDVJL3hidWRKQ2V5azhyb3BLV01iT1dHS1E4aXI2MExCUy84c0pwLzF1enNO?=
 =?utf-8?B?T0t1d0N0d1ZhQjBlOXRXTmdubVNHOXBORnJYcklWUTdqVEdyOSt5TnJJNzYx?=
 =?utf-8?B?QmN5RDFlL0JJOExoOGw1ejZEaE9ZcFptTVFIR0ZCQ3k3aEdNS0tGL3A4NkRo?=
 =?utf-8?B?d09EVG5hTjdjb1dmQW9id0k3RXdIVHVkU2h1bDRqSUJnWTJZK1l6TGhJK2pC?=
 =?utf-8?B?QnNGbGY4MjVVQng2ejJDME5TY3hXYzhsRDhuSHdSalVzNFZ2N3BCd1BjUllW?=
 =?utf-8?B?OWFrZXRsSzExL1F5SkZUVFM0dTJxcVdLSWFqekppOUxLUXcwRXpWRlBldkZR?=
 =?utf-8?B?OUhQRTVCb1ZlQncyUnlpRUNhTVN0b1I1NStqNUdqT1cvTG51Z3lIZEtQYnR0?=
 =?utf-8?B?eXNsVWJiZVh5Ykl6S0twMHdsbnV4SE1MNUlhYThCTzV5L1p3bjJvaDFsNHYx?=
 =?utf-8?B?ZlNnbklseTZCME5qVFc0eWl2ZGRXYUhjWlRWakJ6U2crM0VqYUpMcVFsMUNx?=
 =?utf-8?B?cm5LY2NNMmRhUmFXem5sUE54QmVHZzk2SXNVbnkrWWt2OTBuYjJXeWFvZjFT?=
 =?utf-8?B?ZGRWcDJzWVpnRVVSZjB4NDV2S3JGUWczOEZMUXZpelNwckhQbVZaQjQvV2xy?=
 =?utf-8?B?WWh4T3RNUmdvT3lZelZZN3Q5cU9vYzJTVVJxZWJCQ3RzclRhNGNXOEV1YWZn?=
 =?utf-8?B?OUFHQUVyekpsZjVwWlFBRDVqcU1RYXNRQkdkOHFwWG8xcmpNd2w4VnBJeHVl?=
 =?utf-8?B?Z2pOcGtlT0tEWFEzaDAzOE1idmEwRGV3c3VObFcxVUtodXlVRkZmYytsSW5o?=
 =?utf-8?B?UkRoVUoyUU9zUU5Zc3dRMzdESkQ4QXB1VVVhYnFTTlZBbTlnODJnWEM4blZI?=
 =?utf-8?B?dHVQV0ZXajViUm9ITTN2RGN0cGkrK3V5M01Va2NBb01pc0FTcDFNZFYxZlpl?=
 =?utf-8?B?dWcvRUl4THdoV0ZXd0ZUQWExVmhiOFFJQkQrb2tHamtjNE1TL0Q1MDY4VW1N?=
 =?utf-8?Q?J6MrvOXa3DlbLWBV3TAi80Mde?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D35DB69802BBF47856F3BC9C62D83CB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9f65b5-2d86-4b97-9632-08dc0b640ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 07:25:49.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXydNEFPZj3fNgafoiU/jTwCNwAqC1t151cPj0ol8DKCyBUR8FvdhEGL/nmWQM0YhN59A0c1vSDVCblaLCscsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7417
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.157100-8.000000
X-TMASE-MatchedRID: fgYTp5XatxY/XHdICuW5rya1MaKuob8PC/ExpXrHizyPaLJ/Ca3STyxA
	BN2geb1lo5qw/iFKtvYBtjkcfRMmqbmn1oDITWC57spMO3HwKCBLxPtqS8Bm55soi2XrUn/J+ZL
	5o+vRV7yhMIDkR/KfwI2j49Ftap9EOwBXM346/+zGLrXabRd0oKUYBnYEOOqh7/sYebc7m6v6rA
	iBkuaeexUOCiBlZnVD
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.157100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AD911ED8304FE2AA6808B5FE6FAD39F7965B97521DD4D7F8F1D0BAC43A6D09062000:8

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUdWUsIDIwMjMtMTItMTIgYXQgMjA6MTkgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFN1cHBvcnQgbW9yZSBjb2xvciBmb3JtYXRzIGluIE92
ZXJsYXkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5n
QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3ZsLmMgfCAxNiArKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9vdmwuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwu
Yw0KPiBpbmRleCA3ZTIxNzE0MmQwYzQuLmEzZjE2MzBhZjVkZiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBAQCAtMTMwLDEyICsxMzAsMjAgQEAgc3Rh
dGljIGNvbnN0IHUzMiBtdDgxNzNfZm9ybWF0c1tdID0gew0KPiAgc3RhdGljIGNvbnN0IHUzMiBt
dDgxOTVfZm9ybWF0c1tdID0gew0KPiAgCURSTV9GT1JNQVRfWFJHQjg4ODgsDQo+ICAJRFJNX0ZP
Uk1BVF9BUkdCODg4OCwNCj4gKwlEUk1fRk9STUFUX1hSR0IyMTAxMDEwLA0KPiAgCURSTV9GT1JN
QVRfQVJHQjIxMDEwMTAsDQo+ICAJRFJNX0ZPUk1BVF9CR1JYODg4OCwNCj4gIAlEUk1fRk9STUFU
X0JHUkE4ODg4LA0KPiArCURSTV9GT1JNQVRfQkdSWDEwMTAxMDIsDQo+ICAJRFJNX0ZPUk1BVF9C
R1JBMTAxMDEwMiwNCj4gIAlEUk1fRk9STUFUX0FCR1I4ODg4LA0KPiAgCURSTV9GT1JNQVRfWEJH
Ujg4ODgsDQo+ICsJRFJNX0ZPUk1BVF9YQkdSMjEwMTAxMCwNCj4gKwlEUk1fRk9STUFUX0FCR1Iy
MTAxMDEwLA0KPiArCURSTV9GT1JNQVRfUkdCWDg4ODgsDQo+ICsJRFJNX0ZPUk1BVF9SR0JBODg4
OCwNCg0KWW91IGRvZXMgbm90IGNvbnZlcnQgRFJNX0ZPUk1BVF9SR0JYODg4OCBhbmQgRFJNX0ZP
Uk1BVF9SR0JBODg4OCB0byBvdmwNCmZvcm1hdC4gU28gZHJvcCB0aGVzZSB0d28gZm9ybWF0Lg0K
DQpSZWdhcmRzLA0KQ0sNCg0KPiArCURSTV9GT1JNQVRfUkdCWDEwMTAxMDIsDQo+ICsJRFJNX0ZP
Uk1BVF9SR0JBMTAxMDEwMiwNCj4gIAlEUk1fRk9STUFUX1JHQjg4OCwNCj4gIAlEUk1fRk9STUFU
X0JHUjg4OCwNCj4gIAlEUk1fRk9STUFUX1JHQjU2NSwNCj4gQEAgLTQzMSwxMiArNDM5LDE2IEBA
IHN0YXRpYyB1bnNpZ25lZCBpbnQgb3ZsX2ZtdF9jb252ZXJ0KHN0cnVjdA0KPiBtdGtfZGlzcF9v
dmwgKm92bCwgdW5zaWduZWQgaW50IGZtdCwNCj4gIAkJcmV0dXJuIGJsZW5kX21vZGUgPT0gRFJN
X01PREVfQkxFTkRfQ09WRVJBR0UgPw0KPiAgCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfQVJHQjg4
ODggOg0KPiAgCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4Ow0KPiArCWNhc2UgRFJN
X0ZPUk1BVF9SR0JYMTAxMDEwMjoNCj4gKwljYXNlIERSTV9GT1JNQVRfUkdCQTEwMTAxMDI6DQo+
ICsJCXJldHVybiBPVkxfQ09OX0NMUkZNVF9BUkdCODg4ODsNCj4gIAljYXNlIERSTV9GT1JNQVRf
QkdSWDg4ODg6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0JHUkE4ODg4Og0KPiAgCQlyZXR1cm4gT1ZM
X0NPTl9CWVRFX1NXQVAgfA0KPiAgCQkgICAgICAgKGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxF
TkRfQ09WRVJBR0UgPw0KPiAgCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODggOg0KPiAg
CQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4KTsNCj4gKwljYXNlIERSTV9GT1JNQVRf
QkdSWDEwMTAxMDI6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0JHUkExMDEwMTAyOg0KPiAgCQlyZXR1
cm4gT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODggfCBPVkxfQ09OX0JZVEVfU1dBUDsNCj4gIAljYXNl
IERSTV9GT1JNQVRfWFJHQjg4ODg6DQo+IEBAIC00NDQsNiArNDU2LDcgQEAgc3RhdGljIHVuc2ln
bmVkIGludCBvdmxfZm10X2NvbnZlcnQoc3RydWN0DQo+IG10a19kaXNwX292bCAqb3ZsLCB1bnNp
Z25lZCBpbnQgZm10LA0KPiAgCQlyZXR1cm4gYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVORF9D
T1ZFUkFHRSA/DQo+ICAJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9SR0JBODg4OCA6DQo+ICAJCSAg
ICAgICBPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODg7DQo+ICsJY2FzZSBEUk1fRk9STUFUX1hSR0Iy
MTAxMDEwOg0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9BUkdCMjEwMTAxMDoNCj4gIAkJcmV0dXJuIE9W
TF9DT05fQ0xSRk1UX1JHQkE4ODg4Ow0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9YQkdSODg4ODoNCj4g
QEAgLTQ1Miw2ICs0NjUsOSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG92bF9mbXRfY29udmVydChz
dHJ1Y3QNCj4gbXRrX2Rpc3Bfb3ZsICpvdmwsIHVuc2lnbmVkIGludCBmbXQsDQo+ICAJCSAgICAg
ICAoYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVORF9DT1ZFUkFHRSA/DQo+ICAJCSAgICAgICBP
VkxfQ09OX0NMUkZNVF9SR0JBODg4OCA6DQo+ICAJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9QQVJH
Qjg4ODgpOw0KPiArCWNhc2UgRFJNX0ZPUk1BVF9YQkdSMjEwMTAxMDoNCj4gKwljYXNlIERSTV9G
T1JNQVRfQUJHUjIxMDEwMTA6DQo+ICsJCXJldHVybiBPVkxfQ09OX0NMUkZNVF9SR0JBODg4OCB8
IE9WTF9DT05fQllURV9TV0FQOw0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9VWVZZOg0KPiAgCQlyZXR1
cm4gT1ZMX0NPTl9DTFJGTVRfVVlWWSB8IE9WTF9DT05fTVRYX1lVVl9UT19SR0I7DQo+ICAJY2Fz
ZSBEUk1fRk9STUFUX1lVWVY6DQo=

