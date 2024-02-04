Return-Path: <linux-kernel+bounces-51461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB6A848B87
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7CE1C218BA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6407E79D8;
	Sun,  4 Feb 2024 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U8r+822b";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TpST2Zi7"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D6B651;
	Sun,  4 Feb 2024 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707028496; cv=fail; b=q/sRZnLH5BMT7fc9DjAgp1K/8n0p/dhmuHEH6KNT0nOU8mNxtowh/KuzwrgsYR+Dd7Z3JJeTZP3yWopDo0xW7XCj34KnwDgkM2YpDvLN2l9SxoZ161St0llOvjPSe41cEHjMtICzA641UbfYGCzootlgTtWScYxcl0IzGp09bE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707028496; c=relaxed/simple;
	bh=rMO2g7caZhXKrq78Qu+GNqSQb11xY4fDZ1TSKSQEyqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fhQJFPJoQt5YAj3d7D5IXoBeuN6p/7sts5qNHfrvmyOLziF2enOXRSP0Rie0uIy2IEW+Ugyo9gfP9Zr2xhZO/XI2pkYW7HcFisWkriaM8flA5iY2dMnftpAqP8/0D1XSKa0XNHwlBZhP4BujUOcmA1oKssSTelVQfvFds3RsPBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=U8r+822b; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=TpST2Zi7; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7df15baac32711ee9e680517dc993faa-20240204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rMO2g7caZhXKrq78Qu+GNqSQb11xY4fDZ1TSKSQEyqw=;
	b=U8r+822bmSQ53OVrpX7kEShsX1u/BX04a6iiZnz1+XNcYQpwb+NjDSlVDdTtqXHdfktib+XcCgYlwEnqX4RkqQE9FlzlwHYx7v7Pccp8ll+2OuJuo0KGb8hQLHfi90iQ4lHxFuuBXCiJQiB8VY3ztcLApV7t+7ezlcGFcjoA9Yw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:cc993bf5-346b-4abe-bdd9-3c3592f968cf,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6e16cf4,CLOUDID:79f37cfe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7df15baac32711ee9e680517dc993faa-20240204
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 391852303; Sun, 04 Feb 2024 14:34:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 4 Feb 2024 14:34:46 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 4 Feb 2024 14:34:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJTbBhOxu27uQWgCaxzGBM1xwBvvxuFzcNHVg60iLDXjNf67uJ6hr9+0DQUAErFTmwZqukfFx0UdgKFoFmKhbGC9568lewjhi5ATCojd4nmsuF5SRKmaqNAwa6c1keLdzv35Zvgr5VIqUDhyfLLDaWyjz1MeOPOZjAnG6+y/6dPZTntacqVfAIqQHrgF5lolq3Q+8klAzPNCn580CgsgzN8j47QL7FFVBmvbItgZot5qVdmsBhNcufSziUH48q68s/GNpm00QjJDLsnLpzqkavRCcCv87KOAOtcezunSx9hCbNpBRiIN5BX2tFmguZcAwM/op13YPW1sbeTUk3cnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMO2g7caZhXKrq78Qu+GNqSQb11xY4fDZ1TSKSQEyqw=;
 b=NE4yZvLNa3k3aoMasSx3S4UlRIgTfz8hqnaHt9rsmi017O8zs+Q7SBq9CKPflFz2NSnAv1Zpn2S3QdzurKNGF1y7nV2cYioG4kagWAREeuuHoMy8yy9aVzcRCxQ3YrBYaXt5hEojLv2R1ah8QOrfFKduD9NnMvZ+7aqN5P+/CwoQu64gyuH/8Llwlmx9ufOB9HUKqh1bPLdUhccMtAxT2Ae7Ei9hMbGwTR2FwUfIg92IwGTy4dBKB2tbXr56HIPfPKmPPfoSGeq+IPwN5bt7+R+U5jH6Ks9xGCJDhNoh7JPDlPr+xYC6jCA3OZBKfkAipRV2xm3UNzihcRwQw17w7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMO2g7caZhXKrq78Qu+GNqSQb11xY4fDZ1TSKSQEyqw=;
 b=TpST2Zi7ky6ku/FZ7EDhhC3jSnBelP+cS3GshotvhcboaV/6Mp4s54UGim1wNYgMzrMcqsglG5VAoJ9JvR5unWRfWfo5w5+jdIx88XKTD6XwaQSwgqO+/L5K7LM0q93BhysGnuCiC2MdEsAS0l01TSq4j+Sb8n3WIEyc7Rh4cuU=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by SEZPR03MB8140.apcprd03.prod.outlook.com (2603:1096:101:17f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 06:34:41 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::33a9:162c:3c6e:4a0d]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::33a9:162c:3c6e:4a0d%7]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 06:34:41 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "mchehab@kernel.org" <mchehab@kernel.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
CC: "heiko@sntech.de" <heiko@sntech.de>, "gerald.loacker@wolfvision.net"
	<gerald.loacker@wolfvision.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yunkec@chromium.org" <yunkec@chromium.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	=?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "10572168@qq.com"
	<10572168@qq.com>, "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v3 1/2] media: dt-bindings: media: i2c: Document GC08A3
 bindings
Thread-Topic: [PATCH v3 1/2] media: dt-bindings: media: i2c: Document GC08A3
 bindings
Thread-Index: AQHaQqOK1wYnHrIeWE2SfBQ3G0ngibDRNgGAgCitLIA=
Date: Sun, 4 Feb 2024 06:34:41 +0000
Message-ID: <1abe92bbe6e93f119a735e41dfdc0eac7f0a5080.camel@mediatek.com>
References: <20240109022715.30278-1-zhi.mao@mediatek.com>
	 <20240109022715.30278-2-zhi.mao@mediatek.com>
	 <7dbe0235-43f3-4060-b7ac-4c429c5aff4e@linaro.org>
In-Reply-To: <7dbe0235-43f3-4060-b7ac-4c429c5aff4e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|SEZPR03MB8140:EE_
x-ms-office365-filtering-correlation-id: d2882f54-48f4-4b6f-ea31-08dc254b5e16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DjFw2pNYRee94JHUar9LYAGeO4taMuU/mI/F8ADJwWePO3IDrU8RygrZWLfuz9LOVhD21uu8IWFiFFDDRbu2tSTh5QzV9lIKhAnCVZXdZMXszWqpJZJQPuyHkzZVsY2t+EH9NY6KSGvcanP5uO/nLI/fQZ0YL46F104sab9w2L2W39YiiuIsQmoe9Bq+uLVpxSp+LQTOA5xKq0z1ko6hwMXSrLa5y/gCR+LExNHbErHCBkosPBJnyQ8Mj2nbDJI3AKrhrNGeeEqTwJ3DIai3q30MnJXQBTX6Qucq4AaUvhDsMdta+tki69Iwqv/dM28HeTtXqwBXkVqa5r6tDY2MA3r9TMmHg1os388XhXkyRVGBsSWCQ3GOT6TZN6Pu5u8ktPp51LChfDfNDKAB40vX1JoBOx11iRWpc0FytIHlilMWg2r/OrxDsq4nuNDLeciMmnRpWypBX+uv+Q+UltAHvQLHsMnz1Lsvhr8s7r33m6TTvWZV7OMdtsS5WKvWugW2SKc9IOVrdaa3QEMsax3mY964T0XklC0BfODKLvZgKzaEo391dsjpfTsSll8k4q1rWxvbAa/9oygWxKQq7apoFCjl1fM1PqlxPQMCEa1KhiI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230273577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(26005)(41300700001)(36756003)(38070700009)(54906003)(316002)(64756008)(66446008)(66556008)(66946007)(66476007)(85182001)(478600001)(6512007)(53546011)(6506007)(83380400001)(6486002)(966005)(71200400001)(38100700002)(122000001)(76116006)(7416002)(5660300002)(2906002)(110136005)(86362001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzlJSVlMbU54VlYyMmJlWFVYQllFcjZLd2hXbkE4eFU0WGhtb0NoamtuSEtv?=
 =?utf-8?B?OHRJREdXN3psUEhlRHF6WU1oYVY3RlZ3cWpIREswZTdEaWdWeXNaVmhlbTds?=
 =?utf-8?B?Ymt0a3g3K0lRMHlHODZZZUNSZzF2ckxHVDVHNndsZ2xoa1crM0lWMDczYkpk?=
 =?utf-8?B?dzROVFNRa1kzOFdxUm9VQU05UXdIeTVBY0h2bzB2c0tqcFNIV2NEbG9nWldZ?=
 =?utf-8?B?T21lTFM3cjU2YkYzWjZXcnBvS28zeGdwWmdPVXlhMHowVmJtMHJBYWcwQ0lm?=
 =?utf-8?B?TWJzcWNJN2NPYW93ampsWkM3b2xPeHMrRHc4azFHTkgrMi9XcTZWOUtOaXQz?=
 =?utf-8?B?bXEzWVNWWmpjcjlkZEVhZFgyZHpnckdUek4vby9laHlpNmVtQkNIb2lHUlFH?=
 =?utf-8?B?d1g1NDlMU3pnMFpiWUUxSnlrbSt5V1FEeGZpL2ZxMDhiTWsrL282VWZjdU0z?=
 =?utf-8?B?akYwbWtPUTdFTndQVW9CbUpZVFdIWXNMSi9Mdm5mTjlhUTFoMVMrMzRkWHJk?=
 =?utf-8?B?ZWJNZll6RHZpcHBSQ0x5enE1MWU3Z2ljMUt6OU0rUjBrYjgxMWFQL1lQcFMz?=
 =?utf-8?B?UnpZNVNIUVZVQ1o0YzBmdS9NWGVSWHMvMDdxVnZxbDVNR0FockpvQjczTTY4?=
 =?utf-8?B?cWtIam12dk9IQTBKcnJsdEdzTURvSWxjM0R3bDR0TW9qUCttendzNlUzclFF?=
 =?utf-8?B?b29uVThaaXB1T0txRVZwYTBxVENPenhyNVJDaVFDWXU4OHgySGRlUVFuOURF?=
 =?utf-8?B?ZXRoZHNVZ2Q0c0E1QU1tdjVSc2pVOG8zMlorRFhYQ0NHUDNXT211eENVQmxR?=
 =?utf-8?B?aHBhaGYxYVMySDRGandOZjV2L2NTS1Q0TXI2Y2M4VUdGNUY1aW1hbVA1eklo?=
 =?utf-8?B?ZlVQTkNxK3NSdDhTTnVwWHZqOWZBRGlwWDZ1SmU5VEp5N25yY1V1Sk5Ham5j?=
 =?utf-8?B?NFMzWDBXTjBiblVkdENKdTQySWRKRzNvMmV2OHlhZW5La1NrcThiUGFVVFYy?=
 =?utf-8?B?a3R6cnZMd2xrTkoyTU5JWUpRaFZXd3MveG9hbW9ZR2Q4TWdnMHp6K002VzlY?=
 =?utf-8?B?c2p6UlNmQzU4VmlycGRMVmJ1aHMvVjFxZTRNV0xhdnVBMHg4OUxncDFkY3Ar?=
 =?utf-8?B?ZE0xSzRpSUhhUGVudTVpbU00ZG5hTy9ZcDdNYjV6WVJHd1NCTSs4Wk5VaUJl?=
 =?utf-8?B?TU0xS1lnTDBCd0xQWkJUMzN2dGNRaHBXRGNVSUk5WnA0RUhiV2Z6eHhwSWpo?=
 =?utf-8?B?SW5ZUE5hUDVmSUhYeGpwbVhEUXdld2FzakNBYWxLbXppaEwzcVlWWkdGRHhZ?=
 =?utf-8?B?R3dCNzBPeldjb3dUMjU2NnNGYVhNMFBqREhJL2ZFZGFZbGl6VmgvYmpHTTh6?=
 =?utf-8?B?S3JpMWxJcCtRd2czc1BMUk90ZDF0c3VJWG5yUW1VOWZla1dUSzNBaDFVUndw?=
 =?utf-8?B?akhMTC9rZUZPYmFCMFhWN09kOHR3QUY1U0Y5YWJYenYxZ1RJclA5T1UxazQy?=
 =?utf-8?B?cnJLQVdwMGxGZTBDanNXbXBtS0RtS2pjckRPekh6ckRuRzlkcm0vYWdDSUFx?=
 =?utf-8?B?NEhRRUNNM0NkRkVsUlUyelpZTmhyWUV0MDFhaUE5MTFCK29ha3ZaS0EvbE9T?=
 =?utf-8?B?NEdVZ3Q0M2lGOTIwRysxbEtKZGgzRHJnNzcyWlFhY2lOZVZCWkVicDVMRFNH?=
 =?utf-8?B?aHpycEhaaVVTZlNxTklHcEVsM2JyRjRGcis1MFN1Z2tyaXlLR3VVTUxyS2kw?=
 =?utf-8?B?NlJXNEhLc3N2L3M4ZnVZSXF1QnFKY1BuUnhuT0hUNTFyYUFUNjcxUnBQdHFt?=
 =?utf-8?B?NlRWYVA2TGZZZi93bGtaTDlCTVdQYjdkK1FzcW5pa1c3VHU2ZmJRV1loKzA3?=
 =?utf-8?B?czZPUi9hcTE0ZEZocDNrVTJYR3hNYW5HVWk0U3pQV29qUzBGWDZwdG8wcVdV?=
 =?utf-8?B?Vk8zb0s5OVJUdk1EUy8xVUszcEtUT1E3R2xvZnVKNDV6K2NOZkY0VjJFeHhz?=
 =?utf-8?B?RWUvdkZOUGh3MHdqVHpVMnBXMkhkQjBqZ1hWTDRXZWd1azlMZXFNZUxGajl5?=
 =?utf-8?B?U3BkUWIzaDBwek85eENsUk5rdEJ6a2VWRkFNNUE0SWRON3ZUUGhOSmovd2tC?=
 =?utf-8?Q?PGNa4FB0Ys93b+vlBRg0h5Vqx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1607A3353F72504BBBF7057FA5DDB143@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2882f54-48f4-4b6f-ea31-08dc254b5e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 06:34:41.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTgeVwn4O+Rq0pbbsfYKn4vC7V9QXV/oiv7VpuEKRZERLfCpXVGydj2OcuQpQdpZ7ZFQ9bjYkGqvp1sQdkC3nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8140
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--22.053800-8.000000
X-TMASE-MatchedRID: GBgFBUqwD4HUL3YCMmnG4uYAh37ZsBDC1kqyrcMalqUNcckEPxfz2DEU
	xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+Cx+Mk6ACsw4JlwpnAAvAwazMG4
	kjAsJeaAIHarpPzq721KvRabv2Gdm717yJ8IcCtuEryjhqiyzyq6xL0KIHMvxArMcoUfMuwlxQn
	yuWxwbgm2haNW3VghmUuKX70Mhy8w1q9FqrlFgYJdc7I2df+msdsM3mpA5g7KbKItl61J/yfmS+
	aPr0Ve8oTCA5Efyn8CNo+PRbWqfRJBlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.053800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E802E4BE09EA2A73F8F5DBF073302036947A19064BBBFC87238285E892B09ADD2000:8

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQoNCk9uIFR1ZSwgMjAy
NC0wMS0wOSBhdCAxMDoyNCArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gIAkg
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+ICBPbiAwOS8wMS8yMDI0IDAzOjI3LCBaaGkgTWFvIHdyb3RlOg0KPiA+IEFkZCBZ
QU1MIGRldmljZSB0cmVlIGJpbmRpbmcgZm9yIEdDMDhBMyBDTU9TIGltYWdlIHNlbnNvciwNCj4g
PiBhbmQgdGhlIHJlbGV2YW50IE1BSU5UQUlORVJTIGVudHJpZXMuDQo+ID4gDQo+IA0KPiBBIG5p
dCwgc3ViamVjdDogZHJvcCBzZWNvbmQvbGFzdCwgcmVkdW5kYW50ICJiaW5kaW5ncyIuIFRoZQ0K
PiAiZHQtYmluZGluZ3MiIHByZWZpeCBpcyBhbHJlYWR5IHN0YXRpbmcgdGhhdCB0aGVzZSBhcmUg
YmluZGluZ3MuDQo+IFNlZSBhbHNvOg0KPiANCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xp
bnV4L3Y2LjctcmM4L3NvdXJjZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3Vi
bWl0dGluZy1wYXRjaGVzLnJzdCNMMTgNCj4gDQo+IFN1YmplY3Q6IG9ubHkgb25lICJtZWRpYSIs
IHNvOg0KPiBtZWRpYTogZHQtYmluZGluZ3M6IGkyYzogYWRkIEdhbGF4eUNvcmUgR0MwOEEzIGlt
YWdlIHNlbnNvcg0KPiANCmZpeGVkIGluIHBhdGNoOnY0Lg0KDQo+ID4gU2lnbmVkLW9mZi1ieTog
WmhpIE1hbyA8emhpLm1hb0BtZWRpYXRlay5jb20+DQo+IA0KPiAuLi4NCj4gDQo+ID4gK2V4YW1w
bGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bp
by5oPg0KPiA+ICsNCj4gPiArICAgIGkyYyB7DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKw0KPiA+ICsgICAg
ICAgIHNlbnNvcjBAMzEgew0KPiANCj4gc2Vuc29yQDMxDQo+IA0KPiBXaXRoIGFib3ZlIGZpeGVk
Og0KPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3Nr
aUBsaW5hcm8ub3JnPg0KPiANCmZpeGVkIGluIHBhdGNoOnY0LiANCg0KPiBCZWZvcmUgeW91IHJl
cGx5LCBmaXggeW91ciBlbWFpbCBjbGllbnQuIEl0J3MgaW1wb3NzaWJsZSB0byByZWFkIHlvdXIN
Cj4gcmVzcG9uc2VzLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=

