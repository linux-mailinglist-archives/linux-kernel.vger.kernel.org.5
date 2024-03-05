Return-Path: <linux-kernel+bounces-91601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA0871423
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B68283898
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302B82942A;
	Tue,  5 Mar 2024 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f7GmPePo";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CmvawFuN"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652B17C6C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709608190; cv=fail; b=um5nTdsrRaxQSQkWN3Y7KmwE097xEmV/YSpMGsHsqrtyQUO2aGDaWaa8gR/7szH3Y5MnulhazlWxX7OjztniJU53dgznk4jRSn0OujOW+BoliheOokoYO2EPJOsELrBfX/xpaBTgzHEyJrMO2RuIqVq6RRom9YGWLFfyUIqhoeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709608190; c=relaxed/simple;
	bh=GSi36JKjSljUf0ezfMpN/+CtnHI+w081m0FauCK5wqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ltryQrJxw2mwjCaNXoHHE9AuQF7a3s/lDofeK2BFoQIV6Vm8IXUJ9e3u7AVB0ckbOMvAQ+n4Ue3gRUMVbYDGHhJsKG2wSLblb0HFaCxv4YK9HLmcfJnZzStGS3JyBMBkOoJ5JeN2XpxFw40J+THDQW29bYEUAx5HIiE7fOt7w5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f7GmPePo; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=CmvawFuN; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cbbedba4da9d11eeb8927bc1f75efef4-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GSi36JKjSljUf0ezfMpN/+CtnHI+w081m0FauCK5wqQ=;
	b=f7GmPePo2uZDUNo2RKAYBVYjfyOCUT553CBeT5IsULKjd2WmlyWhfwc1b2DqBWrgHB8xoNd15mvjEDBX133TKVSar/jD+eHUZPxNlWduFXY4hIXtDIKDDfm/YOJTSD8ohFJLhJoZ87yCW4z2UmbQNmiL7sq8oee2sObeK1Yq0AY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:7bb3ffec-19bc-42f4-9eec-27d76d4d230d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:dc991d81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cbbedba4da9d11eeb8927bc1f75efef4-20240305
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1405186171; Tue, 05 Mar 2024 11:09:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 11:09:34 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 11:09:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfXFrWEPbEpgrPPNvkAEKJdRVTUNc40KzY54Lj5uuTTKubr/gK2u3dCWkbDvW5QuJc77GOxN0yEisOis/VN1/nmPFPZ86JAMwRg1337uHnu7lCPYPqUoW39cHfOy51wqwx28IW6X9DVo+qBu2cjlN8zQzI7GMN9USkNLh9aiKnW+24GlwabbJ65JfoHrzNnvVboghcMpfVurW0Lc4kluc2uYFr2SwhXkTWjAxCkc4epPtRNEBhMx62kdLnVPqHzx62PLi0rw3vYW+2Ei5sfWTFbeftrU1+DL75MbrKBuznkdY3ESIA1atCkwsgDE2QEkm4CRFPvudw2J4Ah64Yqlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSi36JKjSljUf0ezfMpN/+CtnHI+w081m0FauCK5wqQ=;
 b=X9CR6tG24Le2zuiokbeR1Vc9bwz3zMN4i/9Wv/v6QCUN2a08j29Y/VwG3U2nRhFeaJhnjAfwyiUEbrevoVTwuv0q+J8mwmfzN/SBE9Mv/ViaRPeVChZSVFIDQ0es7JGdpoYjDb1wSmJmWKVHM9wXxkD52cIrCeTsHw0F7+37K4YrE0SDuygUServUkr928TM7VD+Gam4UKxrf3dmUGpTGGD1tEYwwXDsrFp2EyDd1fWl10R+IkDCfRdTy7LD+dXAGSKTUJBV9KUbW/uTefl71KYVQoPdAVUkDk4t1LTN8tKKMKlh5n7QyfACLQ0reI3/1CpPu2FQa/o12UF+3Q52vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSi36JKjSljUf0ezfMpN/+CtnHI+w081m0FauCK5wqQ=;
 b=CmvawFuNYCIgIZS1xGbrijVCAO2t4KBTD/LqRP0tbeu5qkOErYRkpjPb9QkhefqVjeN1AeK8oN6Vy3YORcrY2VdwGGTtyIwN8rnjaZhaiGs9elomqNDni3zO1CXIaO2tJX6ITiyULKnF5N8+pM2mNe3qL8zas/Ty1g6bg6kQZBk=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB7463.apcprd03.prod.outlook.com (2603:1096:101:144::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 03:09:32 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 03:09:31 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get and set
 GCE event
Thread-Topic: [PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get and set
 GCE event
Thread-Index: AQHaa8lZXQCoYjZqiESGNrd8JcO7v7EnX40AgAEd9AA=
Date: Tue, 5 Mar 2024 03:09:31 +0000
Message-ID: <35b6915dd195abba009dab64dc6002362292351c.camel@mediatek.com>
References: <20240301111126.22035-1-jason-jh.lin@mediatek.com>
	 <20240301111126.22035-6-jason-jh.lin@mediatek.com>
	 <298c13ff-25a7-4d9c-ab51-4c22c07c245d@collabora.com>
In-Reply-To: <298c13ff-25a7-4d9c-ab51-4c22c07c245d@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB7463:EE_
x-ms-office365-filtering-correlation-id: f28c081c-7f17-45ef-a0d9-08dc3cc1ada2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H+Lms893EV6sUAJdU6Z/5rkRQkk03fGtbkGLnUKnTLkgeU50gpiIShE9lFfvggm511leyUXV4gi6uK7eZmonhRTkxqzCNV6aZVQgGbSALvao58rd7gQ8yH4UNSc2DvZ/AiCMNggEKaKyP7NKfmSEctJ5GoaSmxyFoMLuy3HqwN42RrEFL+/C9g9W23qOAmI34u88S5q8zl+C4SfeuzkWRg1zZZXoX++7/DO8RsZ0hcEB4mDYtHGdmPl3/Vv0aTFqslgwHguvjVjYkulStYq/zFvn+hbpYwjlpesPSqy/6jEza6RXF0ryLRyI7NEYdm+jaLlICH3JBkBJry+uzlZdogsFwS3/2v4r74DViGsvsod3tpugvqHxTZUEA4FC3Z8xgNZSNaWaHb6PvAkwQjeVwOdcREqI5Q3v7BWoiVcbs1F6cU9IbBgrt1WRCuqY3K5WSxwUySco/eDT/5FicCt2sum78yWa0l4GujRjZmvRnhxj0hpsBLmGCZU4xcygtnTZciJ0P5llzR2EEFrW/uuWihflD6p9tdMhTAXO6PsFkMtvqrNHVwwTQzjTFl7tbSgHThgH7KfkheYSInFHOBfnO8SoafmyVN8RNvLSgkTWsWsJbKF5p5AkGVIIopFe1cAsTnZdtIGmAqif5+BzVyxN9m95sOd1pJ8k8TFTDPK61c/e0UXfsZPeXyEYtuAIFfdRTc+SRqxFavjBNWwUrRLF4xV1TCp9dEs0OHEfrq05psI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUFiRzkrTVhMWittYitmQURBZ3VoZEFNblVlcWhpYWJuVVRWanI2MGlYSTdR?=
 =?utf-8?B?amFhWVZDVWVDMTVZR2JTZnhpd05NZGJFd2hoKzdzMmpSelJxQTJWdkRHU3Zw?=
 =?utf-8?B?TDhQdjlvb1BnZkFQRWdySkM3d2t3cEoxVWt6SmZTZUFHZ0l5a1pMeGwrVGN3?=
 =?utf-8?B?RDlJbVBBeGxsb3U2TFZNaWxoU1BZSnpmcEhWMjliT3FjQy9uczEyZ2RkMVhl?=
 =?utf-8?B?WVc1cmorc1hwRjBWVmZhc1JmMEZFMS9MUG1kUElyd1Yxc2FzcDNNWWNhZm93?=
 =?utf-8?B?K09SYzM2MWMxY0xxc0piU2gvRjRqUW9USTVta0xjaFFKOElEejU3NS9reFBE?=
 =?utf-8?B?UFJsQnBZVHpLbXpWcjU3NEFrenBNbCtaRWdBR1JwVWpBQzNtQ3Y3UkxoRnBP?=
 =?utf-8?B?dC9jT0FadUFwYWVPMGU5Y0M0TEJ0dkt0MVk2L3R4V1I1N1F1WmR3YTZYRFB4?=
 =?utf-8?B?NnFrVmwySTBOb2dYRDJLT2ZpejNUbzN5TllBT0ErNVh6c1RVRTZwSDI5R2ZU?=
 =?utf-8?B?LzR1S29obmJVeTBpSjh6UG1BYzlWNXF1eVk5UE04cUpnMlVyeGJaSUpCVTZy?=
 =?utf-8?B?UGVHU0J6VzhVM0M4dDVKbWlBZUZGRkdyZUNFZ1pZeWZOL1I3Y2MvVWQ1a1VI?=
 =?utf-8?B?NjloUllRb1IvOEI2UlRaOUozTkcxMVQ1LzVzWnpDQ2U0a0tYQlNpUWlGN21N?=
 =?utf-8?B?cHJ0WkxwaXY3Z3VkeVVRK0Z0M1dNS3NLamdXOWRYbXkrL2tqRG5VR3ZNd1lI?=
 =?utf-8?B?ckd3enBoUklKeFUrSUMyOEN0U2dvbFNSaHZCMmYrWjFPaTJ4NHZYOGowK1N0?=
 =?utf-8?B?blluVktBUlZVa1AzSHlSZUV2NWs1YzlmM2RzNWEreXB6L3pRaGUzM1RlQzFk?=
 =?utf-8?B?K3JYL0VpWTB3cFVtTk91b0hWWmxQdnV4RmsyWnlzR2JQUUtJb3gvaE0yanU3?=
 =?utf-8?B?YlJSYkZrRnBHU2Y0dG1SSnRCdVlrdG9EenBvSmRJTHVuUFZWK1RNVXVnR0RX?=
 =?utf-8?B?eVg1VXR6RDZhQlhxcE1US3kydUVDcVhzeDgzU1NSRnVFOWZnUVp3a2tkb0NV?=
 =?utf-8?B?Y2tEdVJuQ2VJdlovQ2RBWDVHaTR1dEtsS3ZLWklVN01GSjBhTjlTbStQRlBG?=
 =?utf-8?B?djlXZEk2TTZHYkhhTC9CZ0pVaE1EMUxrY09ZN3B2Sk5LOTlueCtYQlEvcVlp?=
 =?utf-8?B?SHpuUCtZeHZnQkUxT3NJUEp0V3hzY3VlL1FLZElBZjY4YkZuVUNmdEdidSsv?=
 =?utf-8?B?YTFNaU1yaVFSMjRydmFRdkNhRXJIWHRYT0V1aUhtRUpKSVQyOUVEQjJZRm9D?=
 =?utf-8?B?MUU1dU9MYXVLWTAyR2ZYWk1YUHNOSHMreTFId2Rxd0NNNThZU04yNUF2UFVo?=
 =?utf-8?B?U2MwL0tlOTc4MWFocVU5QjFSUGx2aVdqcjM4RjhPSWJhdmNKMHZGeHB1cmdr?=
 =?utf-8?B?MURGeUsxTzVSM2ZWR0swU2hnM0Y0UUtMdjF6UCtObGM2VGUvb3hUT05uY05y?=
 =?utf-8?B?cDU2UEEybW1odkt1U2M2eWk1WXUwN3ZxWFR4ZVNWWmJ6SzRwM0RDUm1hK2dZ?=
 =?utf-8?B?VmNSRzZ6MFhqS1FXeTJzRExiQjNtTFpsb3FMLzJsbjFHTW5MamRMRUVtcDZH?=
 =?utf-8?B?WDJuSzhvSng0dDNPaUFHa01YdmZvQzh4cDN3VnBZTUZIU0h5NU0zVm55WGJs?=
 =?utf-8?B?Nkl6VnpZOTJyRnNVRklNK1B0N1ZJbktLczdyKzRtWTJNdUI3K0xydnp1SzBk?=
 =?utf-8?B?ZEpzc2h1U3RJM0dwL3JDUnNqNjJkU0NFWjlDazdpTG5RN29GZmIvREErMk1G?=
 =?utf-8?B?YUxDL2F5b005NmEvWkNFdC9iakNZd3lpM0FnK2g0WFRxN3pZcnYvVE5aU1Ar?=
 =?utf-8?B?bGovSldDNjJWUThUMWYyalU2ZXVMVGpoSHFvYkJIZnZNRWttMVNqWGdWQURr?=
 =?utf-8?B?eVF2U1NLVGVuZEYvaSt0UkxHUDR6VHFyQ3NWc3Nabm1wSVRKMEllU0doSXpQ?=
 =?utf-8?B?d0QydUU2c3IrUVEweGtZRHUydmZVdUQrTW9xMnR3VTlIdlpmNkZiUGlsR1ZY?=
 =?utf-8?B?S3phQ29yR2t6T2hYc3BGekpIbWNtWjZUY2hyc2FCbUlkSW5ZTWV5ZEFmZWFT?=
 =?utf-8?B?bEREMmdCcUtScmZRbTB2QmRYcEM3ZHpLK2FZN3VSMGVxbFd6N0FuQVF4eHpN?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <129BC9AF4659304D8303A9644203D1A9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28c081c-7f17-45ef-a0d9-08dc3cc1ada2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 03:09:31.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QT/TmmkwfqWvXIv0F774y7hezYrsqP0tuJw1BMcwkkc0JJZgPvPuFtg/+jgsamPnVmKLR3goZtkf+p6E1udM+5tWZ3avjf1t13UTjVMPYpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7463
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.554700-8.000000
X-TMASE-MatchedRID: QfHZjzml1E86yy6RAAEPc+YAh37ZsBDCA9UhA/EMrwPI0741P9lNrkUb
	nwDpGS5v1Fc61VCGvh0P3DFN6qmL8nYIQoHEix+qrDFtme53KvsxmbT6wQT2a7WZRTTpSHogSfS
	+N55v9tl1OEFvqvBNg1ijcb6u/Gs1b3gilrWi3GiQOktEo73GFIiuaoNXJrK/nQqircTOm4cwKY
	tIU69m3TQITkuctk/qWHRIOUYbrQzVFtf7bVfns7MjW/sniEQKgRykyfrH1xmXaXn+/c+l2lSSV
	/BYEi3V4vM1YF6AJbY9l7H+TFQgdY2j49Ftap9EkGUtrowrXLg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.554700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	310405566EDFFB92F7EBFA65E35A32CEF31E64A41F817C0CFA7584CA5631A0912000:8

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBNb24sIDIwMjQtMDMt
MDQgYXQgMTE6MDYgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAwMS8wMy8yNCAxMjoxMSwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gSVNQIGRyaXZl
cnMgbmVlZCB0byBnZXQgYW5kIHNldCBHQ0UgZXZlbnQgaW4gdGhlaXIgcnVudGltZSBjb250b3Js
DQo+ID4gZmxvdy4NCj4gPiBTbyBhZGQgdGhlc2UgZnVuY3Rpb25zIHRvIHN1cHBvcnQgZ2V0IGFu
ZCBzZXQgR0NFIGJ5IENQVS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4g
PGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gQ2hhbmdlLUlkOiBJNDk0YzM0ZWJjNWVj
MjZjODIyMTNmMmJjMDNkMjAzM2Q2MDY1MjUyMw0KPiANCj4gQ2hhbmdlLUlkIG1ha2VzIG5vIHNl
bnNlIHVwc3RyZWFtLiBQbGVhc2UgZHJvcC4NCg0KT0ssIEknbGwgZHJvcCBpdC4NCg0KPiANCj4g
PiAtLS0NCj4gPiAgIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgICAgICAgfCAz
Nw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaW5jbHVkZS9saW51eC9tYWls
Ym94L210ay1jbWRxLW1haWxib3guaCB8ICAyICsrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDM5
IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210
ay1jbWRxLW1haWxib3guYw0KPiA+IGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3gu
Yw0KPiA+IGluZGV4IGVhZDIyMDBmMzliYS4uZDdjMDgyNDljODk4IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiArKysgYi9kcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gQEAgLTI1LDcgKzI1LDExIEBADQo+ID4gICAj
ZGVmaW5lIENNRFFfR0NFX05VTV9NQVgJCSgyKQ0KPiA+ICAgDQo+ID4gICAjZGVmaW5lIENNRFFf
Q1VSUl9JUlFfU1RBVFVTCQkweDEwDQo+ID4gKyNkZWZpbmUgQ01EUV9TWU5DX1RPS0VOX0lECQkw
eDYwDQo+ID4gKyNkZWZpbmUgQ01EUV9TWU5DX1RPS0VOX1ZBTFVFCQkweDY0DQo+ID4gKyNkZWZp
bmUgQ01EUV9UT0tFTl9JRF9NQVNLCQkJR0VOTUFTSyg5LCAwKQ0KPiA+ICAgI2RlZmluZSBDTURR
X1NZTkNfVE9LRU5fVVBEQVRFCQkweDY4DQo+ID4gKyNkZWZpbmUgQ01EUV9UT0tFTl9VUERBVEVf
VkFMVUUJCQlCSVQoMTYpDQo+ID4gICAjZGVmaW5lIENNRFFfVEhSX1NMT1RfQ1lDTEVTCQkweDMw
DQo+ID4gICAjZGVmaW5lIENNRFFfVEhSX0JBU0UJCQkweDEwMA0KPiA+ICAgI2RlZmluZSBDTURR
X1RIUl9TSVpFCQkJMHg4MA0KPiA+IEBAIC04Myw2ICs4Nyw3IEBAIHN0cnVjdCBjbWRxIHsNCj4g
PiAgIAlzdHJ1Y3QgY21kcV90aHJlYWQJKnRocmVhZDsNCj4gPiAgIAlzdHJ1Y3QgY2xrX2J1bGtf
ZGF0YQljbG9ja3NbQ01EUV9HQ0VfTlVNX01BWF07DQo+ID4gICAJYm9vbAkJCXN1c3BlbmRlZDsN
Cj4gPiArCXNwaW5sb2NrX3QJCWV2ZW50X2xvY2s7IC8qIGxvY2sgZm9yIGdjZSBldmVudCAqLw0K
PiA+ICAgfTsNCj4gPiAgIA0KPiA+ICAgc3RydWN0IGdjZV9wbGF0IHsNCj4gPiBAQCAtMTEzLDYg
KzExOCwzOCBAQCB1OCBjbWRxX2dldF9zaGlmdF9wYShzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0K
PiA+ICAgfQ0KPiA+ICAgRVhQT1JUX1NZTUJPTChjbWRxX2dldF9zaGlmdF9wYSk7DQo+ID4gICAN
Cj4gPiArdm9pZCBjbWRxX3NldF9ldmVudCh2b2lkICpjaGFuLCB1MTYgZXZlbnRfaWQpDQo+ID4g
K3sNCj4gPiArCXN0cnVjdCBjbWRxICpjbWRxID0gY29udGFpbmVyX29mKCgoc3RydWN0IG1ib3hf
Y2hhbiAqKWNoYW4pLQ0KPiA+ID5tYm94LA0KPiA+ICsJCXR5cGVvZigqY21kcSksIG1ib3gpOw0K
PiANCj4gc3RydWN0IG1ib3hfY2hhbiAqbWJjID0gY2hhbjsNCj4gc3RydWN0IGNtZHEgKmNtZHEg
PSBjb250YWluZXJfb2YobWJjLT5tYm94LCAuLi4gZXRjKTsgKGFuZCB0aGlzIGZpdHMNCj4gaW4g
b25lIGxpbmUpDQo+IA0KT0ssIEknbGwgY2hhbmdlIGl0Lg0KDQo+ID4gKwl1bnNpZ25lZCBsb25n
IGZsYWdzOw0KPiA+ICsNCj4gPiArCXNwaW5fbG9ja19pcnFzYXZlKCZjbWRxLT5ldmVudF9sb2Nr
LCBmbGFncyk7DQo+IA0KPiBXaHkgZG8geW91IG5lZWQgaXJxc2F2ZS9pcnFyZXN0b3JlPyBJIHRo
aW5rIEkga25vdywgYnV0IHBsZWFzZQ0KPiBleHBsYWluLg0KPiANCkJlY2F1c2UgSVNQIGRyaXZl
ciBtYXkgY2FsbCBjbWRxX2dldF9ldmVudCgpIGZpcnN0IHRoYW4gdXNlDQpjbWRxX3NldF9ldmVu
dCgpIHRvIHVwZGF0ZSB0aGUgZXZlbnQgc3RhdHVzIGluIG9uZQ0KbXRrX2ltZ3N5c19zZXRldmVu
dCgpIGZ1bmN0aW9uIGZyZXF1ZW50bHkuDQoNCkFuZCBtdGtfaW1nc3lzX3NldGV2ZW50KCkgd2ls
bCBiZSBjYWxsZWQgaW4gU1cgbXVsdGktdGhyZWFkIGFmdGVyIGNtZHENCmNhbGxiYWNrIGZyb20g
Y21kcV9pcnFfaGFuZGxlciwgc28gd2UgdXNlIHRoZSBzcGluX2xvY2tfaXJxc2F2ZSB0bw0KYXZv
aWQgdGhlIHJhY2UgY29uZGl0aW9uLg0KDQpCdXQgYWZ0ZXIgZGlzY3Vzc2luZyB3aXRoIElTUCBv
d25lcnMsIHRoZXkgZHJvcHBlZA0KbXRrX2ltZ3N5c19zZXRldmVudCgpIHJlY2VudGx5LCBzbyBJ
J2xsIGRyb3AgdGhpcyBwYXRjaCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpSZWdhcmRzLA0KSmFz
b24tSkguTGluDQoNCg==

