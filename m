Return-Path: <linux-kernel+bounces-19092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AF58267D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A941C2182D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFED63A5;
	Mon,  8 Jan 2024 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V18xsgbe";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sUq9sq3G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE7079D8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 37f9fd42adeb11ee9e680517dc993faa-20240108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VaVIFxoZ5TdxKtDlI7RmdkHwjl6t/OB5E+Hh/79AkUs=;
	b=V18xsgbegR7jIiZP4gjr4A+zyzW4j2+6N9m9APwRppajoRvb0sU8O0mW5ADc3c/inXUuHOOuoRYWq7rCwXiRNEh3tFN2c9wRDrEpSNkLH0hNfVoYN+XskTlbfDmX+TIXgKNG1Rg31MPFENMXJ+la0VPCukK+P34JjzfPeBN4LK0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:d0e101af-2036-463a-bf59-b79d5c407b0e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:f443008e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 37f9fd42adeb11ee9e680517dc993faa-20240108
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 877660985; Mon, 08 Jan 2024 14:00:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 8 Jan 2024 14:00:24 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 8 Jan 2024 14:00:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5BPpfOpoUIqSuN+5UyJXxFcuu1MZTt+DdYXo5s/1oyZto32J0DpuqSPITC8zzk9QvB2e6aaqVmKPVH6Ug4j0OqManZoxTmw8c71Jfxt7cHGrZZZmbl6ncANT5LPXqeEX66VhPhepYHUH9vF/hX4ZPyo67hIYEu0u2IynzbSbSjvNkAP9eWwwI1lx3KHWz2SUEk6L9z7c8MGQB77ZMGaxt9U7moeteQfSvMUTki6pJOmtAJ4j8ysQmHfUMmktCTD9M5M0yIz6/pWjxyCYddoJQrnlg70nf5qFcHHrXHKDEBHeib4mtc5U3DNujtWlyDcHtL1taJWJtVEBG5vobSPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaVIFxoZ5TdxKtDlI7RmdkHwjl6t/OB5E+Hh/79AkUs=;
 b=QpEpTXo59M0Ngf8Ret+D6VN3NwmwQXLetDUZe8fOhxy0IqPAk+ZrLR8wvxOd7ajZl9MjtRSNmQwhw4EzzPcJDlfCvmiZ8TN7R0E5S9SQIBqTju3Asa/Nn0uMxuvm84p+1FZjQ1SxJDAf5jbi6CSXPRAtAHWN9h7SzIfmz9RK6XTs+Ry27Yf1pZfcqR4EUHRKp5MfuZTBStG74JTMOyBhVoT14Ev10l7fF+YVQOtC4mMSZzaWEg7QwcA5szRD+VLX7/HuH+mBYYcJw5rxAu6fb8aDtFSOjKri9IXHFXGv0v9fMc1DFC96TtTM+hC9Lcca/RAG77rPXcAcpEAJHwf3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaVIFxoZ5TdxKtDlI7RmdkHwjl6t/OB5E+Hh/79AkUs=;
 b=sUq9sq3GbApK7MI0o75chRtyILILivlAe083Lw+18Eh+LH2qFjgj57t+kIfJukdQAvTuPE7b9EEnTO9s+2dibU1zT9fv1R/FjuV/5PwCDEMlh1jXJAw9In3RnOcUg2EC2LoCr0zGvkE4YFI3i0iiFd8YLCT+OezdW/jEQSkewYs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8666.apcprd03.prod.outlook.com (2603:1096:990:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 06:00:21 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 06:00:21 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
Subject: Re: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Topic: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Index: AQHaHrPjdunoffcOCEGmErF8vNrJIrDPsoQA
Date: Mon, 8 Jan 2024 06:00:21 +0000
Message-ID: <93cc4d460198f848b7d8d25735a2d55f0e10a11c.camel@mediatek.com>
References: <20231124085346.26602-1-mac.shen@mediatek.com>
In-Reply-To: <20231124085346.26602-1-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8666:EE_
x-ms-office365-filtering-correlation-id: 36c340b1-db62-4fc8-9bb7-08dc100f194c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kkL0CK2KQb4baR6gLpw0zI0Cut9q78c8uCZIqPFDYYxE/HgH2W6jSsoPiRI4PR+z4sxpreCW4RPjCeA6eUWLuAHI1cnSziTDkA03E+UceM+AEAtyXlizY6Dk264cyT0E3CeRlaXoRicUT1yScZVqpBK1BohW5VpdDBEfa1C3c482Ri4rCYJ9fKSa7MNnFp+DUsjaKVsLaQLp3Q7CQ09QZ70h+4eb+puuTsa6Jr++qIVaEO0BL6oRs8rp95cUwcSx5kq1CKRvODRCUy5hS7XWnXUKUkL4srAbsa47bqr8Z5WpfEqK2PhGyL/mKTLfMgv6SBLv0n64fkxMnQSlWM3bgUkUZ74eKesRNtSidx2sPAgk2Hr6eq7GC4BYXbMnNnAOHKFYLIS2sXCtB1T8ra9jRLxeCZq8t46Cs6L+4mVBnY9Y1+FB+28NjgOUSf5VLQyW44X+NAdO4UVmP+sS+ACPX715hzmVJ1Z8e89fbtRffn/TytHebFayEbwT3mA3fXtNkywqrVqhj2cCSYBSC6nqYCvry+Fn8Z4PAnlv+vMfvwGErL8cr/Kj66nMW9iv+A1ZhVNU5dfweUZOY84RFiPMg6xvG3IradeN/y/AfeQekGk41GLijGL69DaY/S5wz5pJOPdsBJjsP+UNXcUbV1AVyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(2616005)(6512007)(6506007)(478600001)(71200400001)(6486002)(966005)(38100700002)(122000001)(86362001)(85182001)(36756003)(5660300002)(7416002)(2906002)(4001150100001)(41300700001)(107886003)(38070700009)(110136005)(54906003)(66946007)(66556008)(66476007)(66446008)(316002)(64756008)(76116006)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUNrd2I4cmlvTURaS2d0SDlUYkQvS3pQeTFuTEptMHl1TlBGOW40UlB5ZURK?=
 =?utf-8?B?bHVsQmZBaHlMQTlwSHZWSExUNkw3ek1WUjBUTzRVc1FpY3I3OTdhUDJXV0VF?=
 =?utf-8?B?ZjhTeUdPTEtla3d1ZkloUG00SjNTT1pLU21aVlJ1NkdhcUFmUHMxYUZEWUNy?=
 =?utf-8?B?VE5taFpNZGhFSHluMU9XZ0o0N3N5b0NtVmN2Q1Vwbzc4Q09ldHEySTV4K0Q5?=
 =?utf-8?B?OFFLME1ZVXBOVkx0dzdweUJGNWFzMCtDTzJESWhQekdMdjlBaVIvM2tmU0Jq?=
 =?utf-8?B?N2RvR0ttMTd6VkZBdVozVEFWeFMrUExLVXZMcXFUbjQwYWhMSXBVeGFvdkFa?=
 =?utf-8?B?eU5tZmd6TTR4YWxHS1dQT25PaDJEUHRGa3dxYmUra1hJRWhoNi8xSng4VjY1?=
 =?utf-8?B?cXVrVmtMQ2tBaDBmYVRDY0I0dExuQ290VXpOZlJxUXQxalpYUEpOZFFTQmh6?=
 =?utf-8?B?Ykh5c2hvcDNKSDJkSXpYb0JCd21nMld6VWx6cGlHRFR4RFhQRFhNOWNrSlJQ?=
 =?utf-8?B?clVDSngxZTU1WE95NlBaZkhmRDIrUTZJNC9aRHgyV2dxZTNndWU2Nm01NEd3?=
 =?utf-8?B?dHg1VkxveEFZVC9rN08yNElnY1J2SUZiNEhLci82SVFtc08zM3RydWFnK3Qx?=
 =?utf-8?B?SnMzRXFVM3dITXUvN2lCbjRQa3JybGQvTmg3d2U3V00ra0dnMnozOHZBUS9W?=
 =?utf-8?B?VHd0bUlKYm1qdnZVV1lIMjk4U3piQTJwMU9CYzJBbzhwbit2ZFkxMFI5WmdF?=
 =?utf-8?B?UkhHYk4vTndQL3k0aFdRUUxIT2YvSk5za0VFNzNsS1NUZ2NtZWd5TCtNNkVF?=
 =?utf-8?B?OFRXYkhUbmRLQlo5enN2aFVSSW51MWp4Y3V5amc1QURVTnFyTW9vSGsrZUFx?=
 =?utf-8?B?bVFRd2U4bHFBd2VPM0lyZjBFQTBtbkxTQ1VjaWVsWUxUWGkxZTEyYS9qSUs1?=
 =?utf-8?B?enp4Y3MyRGFqdE82ajRMWjFnMlhyak9tQjgvSlZoNTZ4eFo1eVF5cHZwVkJJ?=
 =?utf-8?B?MkJOV0NYNzkrOHZGN3RmcWpCVHNRbFZ5clFDYVV0ODVRTWxoeGF2MFFqV1k3?=
 =?utf-8?B?SHBrUXpHb1NXQzZUVzZwSW5LczkrdUhhQjh3djZyM0NCdU5CR04wZGVHZklw?=
 =?utf-8?B?bjVUNHBxVlNkdnJFMmR4TVlpckVmL3orVmlTWUJtVXdrK3puNlh2UUh2UFV4?=
 =?utf-8?B?ZDRjWEhRZThWNEZaUE5TbnJjSDVVc1NEMWw5Q0htKzB2K2NPbzJHRTRld3o2?=
 =?utf-8?B?UnRnWFdpU3NRcEliMG5ETFAzRk5yRVRLYW44S2FiWkxoRThSUTc1SVQ5Mis1?=
 =?utf-8?B?eEhFS2ZNc3BkVWtvbXdjTUhsWFF5Zy82eWlJeWhXb2YzdDB5cDQ5SENMSHBh?=
 =?utf-8?B?cHRRYUU3dFVhM3htQWZNNzdxMUVSQkZQYjFpY0RLemkwbHJ0ZU9zMkVsa2hE?=
 =?utf-8?B?SE9mS0pBNXlibkc4N3FsUEZzL1o2aWo2Z3hzN2JENko5SWlNU01YSW5MTTBx?=
 =?utf-8?B?a2p4VEU0TVFjbWk4SlFzNCtkRVhlQUFtVUUrR0x2UWNXZVUyMFl2VXlERGpa?=
 =?utf-8?B?QURoTlNQYnZaSjZYN0tSUjROc0tqSkVNOWJIMXdWdUhrRExIMFdiRSs1d3c2?=
 =?utf-8?B?OXM5YkJoK0ZYNzlvQ3c4Z2FOeUgxNXVLOEFibXNVSVk0YzdyRUV5QXVIZ0d0?=
 =?utf-8?B?YURoemlDeDhNTlZaU1laY2RzMXVod3Mzak1XbUIzclRDWWMzbk02ZS84aXZq?=
 =?utf-8?B?cTZFeEx6ZUswVlJNWEpUa2RhU0JxT25IeVo2NWF5NVFXZC9HSld5N3g2b0ww?=
 =?utf-8?B?bFMrT2VDelMyMHRiVGc1d1g2OThpR1RMYklwaWY5WUFNM2M2djRvanUxaDdT?=
 =?utf-8?B?WDE5TGVrZFJXdm1qbjRRb3FGWWZ6NmZ1V3BzMGxTdTNha2xVcVRCTUtuWjVv?=
 =?utf-8?B?UXJkbkdhVDg2UmVBM09wVW91ZGhoMXp3dTRHOFlvWEgyYjNLdmtZRVZ0N0Y2?=
 =?utf-8?B?QzlDalEyK3Y5OGU0eGtIMG5rZk9KZVRma2x4RXVkTmtCNDV4Q1ZTeHEzZzBi?=
 =?utf-8?B?RlRGV05iTUpQL2E1dTVxWXU5ejR5R1JMUTkvSnEreWlmNG5WMmpWRW9vdVN2?=
 =?utf-8?Q?WhM+qJGsglxnlOzSKbqmKWUvH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87CA46706AFF614C99BEF37B09922C45@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c340b1-db62-4fc8-9bb7-08dc100f194c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 06:00:21.4750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5G3fomrJJwUc7eEOPINzNDXtyZ98j8p9GocsmddsbVNnBcXx9nlOyDhm4Gh7SHJWscV8JIb/vpq4kLNevzgSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8666
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.685900-8.000000
X-TMASE-MatchedRID: scwq2vQP8OHPaPH51LTU5Ca1MaKuob8PC/ExpXrHizxcKZwALwMGs8uj
	Rkt05a7cM2MQQW7DL3i3pOSQRQ7xBU7em2d3oCOdR/j040fRFpJQCOsAlaxN71mmz7LVVfOpnpK
	jslo6wM5/tgNkpf3DpMAMGTVoZpwgVB55dkRMs8wZXJLztZviXABrY6dyM/UbjlFfNjQx+AKtbj
	X4EGqr78iWynuM+ENvdD+L2BnaxvMM8jMXjBF+sNIFVVzYGjNKWQy9YC5qGvz6APa9i04WGCq2r
	l3dzGQ1eMvoRhvgZqOAM5cRIFFF6a/siRH2T/F+sL6GE7m1hFLTJPb5maZ9fA6Jgu7JvCxeBzbE
	mzPXy1DRbjwPCjfdcuzkIlm1YXcK3BPylrkKOcs9XGVRM/cag7sCWxFv9DtZChiU+c//xP8WW1i
	V/cL+I0MMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.685900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7A63325049621DEE3820AF50493F9FD4D633C4438107F6EDA4D10B3F39F326D72000:8

SGksIE1hYzoNCg0KT24gRnJpLCAyMDIzLTExLTI0IGF0IDE2OjUzICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQWRkIHRlZSBjbGllbnQgYXBwbGljYXRpb24sIEhEQ1AgMS54IGFuZCAyLnggYXV0
aGVudGljYXRpb24gZm9yDQo+IERpc3BsYXlQb3J0DQo+IHRvIHN1cHBvcnQgdGhlIEhEQ1AgZmVh
dHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IG1hYy5zaGVuIDxtYWMuc2hlbkBtZWRpYXRlay5j
b20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArDQo+ICtib29sIG1kcnZfZHBfdHhfaGRjcDJfc3Vw
cG9ydChzdHJ1Y3QgbXRrX2hkY3BfaW5mbyAqaGRjcF9pbmZvKQ0KPiArew0KPiArCXU4IHRlbXBf
YnVmZmVyWzNdOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlkcm1fZHBfZHBjZF9yZWFkKGhkY3Bf
aW5mby0+YXV4LA0KPiBEUF9IRENQXzJfMl9SRUdfUlhfQ0FQU19PRkZTRVQsIHRlbXBfYnVmZmVy
LCAweDMpOw0KPiArDQo+ICsJaWYgKCh0ZW1wX2J1ZmZlclsyXSAmIEJJVCgxKSkgJiYgdGVtcF9i
dWZmZXJbMF0gPT0gMHgwMikgew0KDQpVc2UgZGVmaW5lZCBzeW1ib2wgaW5zdGVhZCBvZiBtYWdp
YyBudW1iZXIuIEFjY29yZGluZyB0byBbMV0sIHRoaXMNCmNvdWxkIGJlOg0KDQogICAgICAgICBp
ZiAocnhfY2Fwc1swXSA9PSBIRENQXzJfMl9SWF9DQVBTX1ZFUlNJT05fVkFMICYmDQogICAgICAg
ICAgICAgSERDUF8yXzJfRFBfSERDUF9DQVBBQkxFKHJ4X2NhcHNbMl0pKQ0KDQoNClsxXSANCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgt
bmV4dC5naXQvdHJlZS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwX2hkY3Au
Yz9oPW5leHQtMjAyNDAxMDgjbjY2Nw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCQloZGNwX2luZm8t
PmhkY3AyX2luZm8uZW5hYmxlID0gdHJ1ZTsNCj4gKwkJaGRjcF9pbmZvLT5oZGNwMl9pbmZvLnJl
cGVhdGVyID0gdGVtcF9idWZmZXJbMl0gJg0KPiBCSVQoMCk7DQo+ICsJfSBlbHNlIHsNCj4gKwkJ
aGRjcF9pbmZvLT5oZGNwMl9pbmZvLmVuYWJsZSA9IGZhbHNlOw0KPiArCX0NCj4gKw0KPiArCURQ
VFhIRENQTVNHKCJIRENQLjJ4IENBUEFCTEU6ICVkLCBSZWFwZWF0ZXI6ICVkXG4iLA0KPiArCQkg
ICAgaGRjcF9pbmZvLT5oZGNwMl9pbmZvLmVuYWJsZSwNCj4gKwkJaGRjcF9pbmZvLT5oZGNwMl9p
bmZvLnJlcGVhdGVyKTsNCj4gKw0KPiArCWlmICghaGRjcF9pbmZvLT5oZGNwMl9pbmZvLmVuYWJs
ZSkNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJcmV0ID0gdGVlX2FkZF9kZXZpY2UoaGRj
cF9pbmZvLCBIRENQX1ZFUlNJT05fMlgpOw0KPiArCWlmIChyZXQgIT0gUkVUX1NVQ0NFU1MpIHsN
Cj4gKwkJcHJfZXJyKCJIRENQIFRBIGhhcyBzb21lIGVycm9yXG4iKTsNCj4gKwkJaGRjcF9pbmZv
LT5oZGNwMl9pbmZvLmVuYWJsZSA9IGZhbHNlOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiBoZGNw
X2luZm8tPmhkY3AyX2luZm8uZW5hYmxlOw0KPiArfQ0KPiArDQo=

