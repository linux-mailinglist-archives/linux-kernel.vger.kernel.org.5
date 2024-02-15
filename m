Return-Path: <linux-kernel+bounces-66539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C70855E12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4F81C222EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3070917730;
	Thu, 15 Feb 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NU7dF+Jg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="th7hZltV"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602D17551
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989307; cv=fail; b=uZ1noN2plWBBDLFxmwKVByPKmPFIlMH6zoLXQP5xMJvD0ynXFTs1LvNJMfUCRHdmEh2SNklEd2KT9MNojo86xCDV9FL1uv28q20USmfn6zrwSN6gXtPda3LMYf1H13oAm3/nvLfbaVba8MCNc178wfE9O7ymrjq7NXXHhNDQV/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989307; c=relaxed/simple;
	bh=ZRyOQHObbl3PcgsTLFCi4yTeRV0NHwMHg53JvO8oUJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UVzyGcq1UuAemJZnVJA3ePcv9K5o9DlznsSWpuFigaRdaY3A3G7gFdg4DhTXmaS0gbLzB9Bwg9m6jJnTT+Blzyh25DLFnXzE6YMCpeAfGizqTHPy23PEFmEVByMjArC4/3ouYpEXc3a1D90RQqcumDBBy05JBpt3lzsbJa7gycw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NU7dF+Jg; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=th7hZltV; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8e2c7714cbe411eea2298b7352fd921d-20240215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZRyOQHObbl3PcgsTLFCi4yTeRV0NHwMHg53JvO8oUJg=;
	b=NU7dF+JgAdCJHcd20YVS6cvXNSZgzB2rs8QSJZiefC0UHcvDBJvvRNP9bmyh0pSCDeFLVeo+ZmgNtWeoIT0gMuSiHgh+HjJcEXz5U85ZifgVul8HGXlXJdhQXdFzhC9MNF2ewjEjU+DC6QTRM+7cJXSkVJfrkcdOj13jSLnqeDo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:04c57953-48c1-4920-844d-dd927c51e156,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:72fbcffe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8e2c7714cbe411eea2298b7352fd921d-20240215
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 708987260; Thu, 15 Feb 2024 17:28:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Feb 2024 17:28:18 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Feb 2024 17:28:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyY5YJXYudQSKMPfLVYH7v6BxlfgktUXJwDsX4EGckYwgh9FM/6vkc1b1yujR0Oj7yWyVdHHeHJfQ0CYUmL1KuZXHwd1nHL2HF5Q/1oh9EHb6lxrkj7BAir3y+3a3P+kU+F+6XEAip1A7ZPYAYlutcCCwk4J3spy9/hITE8f/qb33NwT9fbsISjVWb7zoT0vWTFrTC+w54uob0SwSTCExa4feIq173pokQmm9OV4M7kq3yDAxleCPRFx4kVWEObV7M0hClkAUN+NV/3mXruX0RDqA8v7rrxMkuo8Dsgk5503Djw8N4RJbShJ18X6980dEZB0YDvBwSZqL48fKDf/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRyOQHObbl3PcgsTLFCi4yTeRV0NHwMHg53JvO8oUJg=;
 b=Y4Mc0HEq4YrK9eURLBc2R2mZ+f03VIOxGxxQEU0R74RFjtSNEUqyD/h9UcHbhrDvna0Iv+TTMZ1DIH7CEy+L3/INan+KmuRfMX1dJD0YQssrQecQ/kRpbFVWs6dAVV7gGrYEx6/ES69sbGPFjlb7AMjVxd6KCeS308T27rUu9ac249p5ivbDCIBUpRGwUNCX4O/81o+XJzp2rvwFibp/Yzr5ADHxZR0eVjtjDTszWiVJjy5bZZvQxGXFfai/rC87qJP8/ns/vp5qefDhCK41ViJ2MWQwleFVootKk5JTdEbeI/aMYyHpVyOJSOHbhMI2+wCTibQuWZlcSxmh1CqACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRyOQHObbl3PcgsTLFCi4yTeRV0NHwMHg53JvO8oUJg=;
 b=th7hZltVVRQ2RF6LDVuPFq54PyR/b0eS5ILZb16bE/3e+FbYkOh/5Uv1cZpuNPM+IghEaSbFN99xYNGn/ViMYHr8F31BVUmDx2wJXtGM0oHLU6k1DkrDM5IDy8O52fT5yd8+h/Ihm7ZEBTNsiy8VpMpQ5kcWoySRxZDHoksswrg=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by PUZPR03MB6854.apcprd03.prod.outlook.com (2603:1096:301:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 09:28:16 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::afa5:be3f:bc79:48fe]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::afa5:be3f:bc79:48fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 09:28:16 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"amergnat@baylibre.com" <amergnat@baylibre.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>
Subject: Re: [PATCH v6 9/9] drm/mediatek: dsi: Use
 mipi_dsi_pixel_format_to_bpp() helper function
Thread-Topic: [PATCH v6 9/9] drm/mediatek: dsi: Use
 mipi_dsi_pixel_format_to_bpp() helper function
Thread-Index: AQHaX+yb+eoYz1NseUCGotaFRh2olLELIsGA
Date: Thu, 15 Feb 2024 09:28:16 +0000
Message-ID: <fb9a5c679cae73b0784e792729395a07be0c65cd.camel@mediatek.com>
References: <20240215085316.56835-1-angelogioacchino.delregno@collabora.com>
	 <20240215085316.56835-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240215085316.56835-10-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|PUZPR03MB6854:EE_
x-ms-office365-filtering-correlation-id: 9f2250a8-2450-4e85-2d79-08dc2e08709f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXHSweI8attR9x4mT40S+fTYoVaCXjuvjdmkj6WEwhTSTHJU/IMSa2CmXuPfbOR5kR/aKbAYKZPi2gezYfimO7Eg6E5dtRyCasPX66O9U9apTZNLN/voH3vrz6wlX7ls7OswPpki0be9wQJegPne9jFReeHGY7FpgqHNLo5ER7XdHeyrtwM0o2b+EYsFVCaYO6JNiZR5MRRV29pXVA6usOZiH70DcE+128q/Z5bCQ86H7qj34MSGzpSv9Pco41QrUvBupPOw3e89yCOxM+6fI1f5lUqz2DVPCS3ZetSrSKATpYsoLr9lywOTMYk7wPSf6W2EYbbW/5HaZu1VlRcW1PKcjPfnS62zl+svgrZXsq803YucJ+Ha6SUMI4eskbqJn+NjMoiF8DxOt2182vT7Xj2JjbuMi2omES1iagsLdW6ITkyc9j1RW/OVS/79BPzm0MlrtQqR+JmLK73jXY5G5rPYja9LyHIMjhrI+TQlMJlcsN62MclYtKErk1WEHPWS2mPmqYw5XOX86rvnRP8x6eIgMrtItBmOmC/p+1Gq/fzWknIrh5tXnCgudh4JjGq50Sd+++wUQe9Fp7uvjmoIf5IIpTuE/hqXh2+Be/3DohNYLzGbIrraiuSzuOZRxa7z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(2616005)(8676002)(7416002)(4326008)(2906002)(6486002)(5660300002)(8936002)(478600001)(6512007)(6506007)(122000001)(83380400001)(26005)(38100700002)(85182001)(36756003)(110136005)(316002)(54906003)(38070700009)(41300700001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjJGckxWNnFDaVhvNllNYTk0VU92Z3hCUnhEdEc4OXBMK01FbUM3cCtocG95?=
 =?utf-8?B?K2prYTFSTld0blNXWmZPYTd2b255UHJRb29HY20xTjEveWEyRFF2MjJGRXVs?=
 =?utf-8?B?RGExRWNLWDVqZmJpejJ6bE1PRnNkckFMM3pDc2VnZThLL3pXZjI5WW8xdTR1?=
 =?utf-8?B?Ui9IYmt0djNaeTRWVlI3RGZXbVM5bkxyV0hPYVd4YlZ1N1RXOFFnUjJTeThU?=
 =?utf-8?B?Y05sRldrVEFhS1M5RHd6Z2VvZngyd3oxUVd1TTNxNllybFI4VkNYQlhZeVpT?=
 =?utf-8?B?bnpQaVloYnNpS1RPd1g2L0ljdmxHVnBEQ1cxeDFSeVhwZ2U5TXVHMm9ScUEx?=
 =?utf-8?B?N0hVbExxZ0cvQS9uNjZxelJsQTZJYUdaczl3MnBsUDNaQ3lreGtTS0grWjBs?=
 =?utf-8?B?NEJ2ZDFnaHRVUEtxVjIyRFFNVHQ4ZVIwV2dpa05odklYdDQ3d2orK0JnNnpv?=
 =?utf-8?B?azJTaEc3TlVYVnpXdm83dzBqMDdKamMwcnVkYUc3b1kvVm9zaWpmcjY1eitB?=
 =?utf-8?B?R0FGSGdqVml6azJaNnpGMUFlTHFkTmJmdWVDL1RHOWdmdmpDa3VJMk5TN25R?=
 =?utf-8?B?YkJEQVJnUUp3b01SbXpZTlJaT1pwUXFkOEVLZmRlelFxQWdnMTRjWjNZejY3?=
 =?utf-8?B?QVNFREFjR0VRN2R6UVQrdVpuR2YwODlHMFlkUlIxN3pBVERJV0dSdlBydWxX?=
 =?utf-8?B?WTdFSHk2UUlmdGdkZUxGK3BhQTBrNDFWa0FIb0RybTZnbXVvNFc4SnpzbFlZ?=
 =?utf-8?B?UFNhMDdSeDdpbFoyUDFZSVBJNEIrd2F3NTRPbGkzbHptai9FS1VDdFBtaW1O?=
 =?utf-8?B?UTFsbkZFQzVNMEJIalRJN0RrTkRGUkRITXdKZ0NJZklqRDJlVDRxbjZaNWdL?=
 =?utf-8?B?WmRDMGN4TWR3b0NGd1QrRHRzR1Z3QXJEcTBnUnpsR1NVK2gvSHNSYmpVai9z?=
 =?utf-8?B?NHpmdnBRRVNHYkc4TCtYZy8reGZWcjhPOVFSKzZRQVBKZnB6OFIxRFBUSE5G?=
 =?utf-8?B?Q3VPQ1YvaDRnQ0NydEtVM2JCaXpsYUQ2RVJxZHRYVzJHTzBaaC9RcmZ5Q3Uz?=
 =?utf-8?B?RHhFYm1YM2NSbHNwelFpZllZUUE2WWJDazNKMFYwTy9OMUtXY3hBWDdHTWF3?=
 =?utf-8?B?d3dzQzE5U29hYmM1VUxPTm5LejV6d21KN2RMTE1KT3R4UEpnTFZWY3FMK1d4?=
 =?utf-8?B?UGpUVVFsR0FSR3ZJZEdZc25xQStxZUVrdDNObnNCeU9lQVVMbVFsdXd1VlNl?=
 =?utf-8?B?Z1NDbDdRdDNsVWkyclVPTldiaEhmdlBDRWVibHBrSUhJaVY1SVNHV1Baelho?=
 =?utf-8?B?RTlhRW03aHRjcWIrSU9JRlVJbU9mZmJ6TzJHc0pqUzlMcjFQYlFUMExJSVND?=
 =?utf-8?B?MXlQWi9hZ0JOVGJSYk5WSGtxODByTktJb2Q3L3FxWmQ1UCtyS1ArZm90RzFF?=
 =?utf-8?B?OWtndUUzUDAwWW1WZ2JDb05HbGlBVjNCL0FGOVRrcGJ0M3EzSkV2NmZ0eDNw?=
 =?utf-8?B?ajdJNnVrUW1GdDg4cGQxM0huRHMrSlJGQ2ljc3Z6UjZMNjlXSFhLWDBEVGxO?=
 =?utf-8?B?Q0E5VjBaM1VjcEhKVUkwWjBUQWY4OWpITzR0Sk9sV3VnU1o2ZUxBUWtua3pp?=
 =?utf-8?B?VXVjMjRyaFdTQTg1aGRZRFNFREc0MUNGa0hQM29NcGVNKzU2MHNaUnFpVEpO?=
 =?utf-8?B?bjZiRzZaSFNRTnFGWEFtN0JwZm56dG8xMjE5MXlCVXFtd3ozelV2OVpKSDlN?=
 =?utf-8?B?aGZ5UkgxaWhnbk5ETVQyNkdHUDRpYlpJTWYvbG5pbWs0Z0hsZzlMUTRVYnoz?=
 =?utf-8?B?MlQycHdFOEUzSzNaRi9lK0hzRnF3Qk1BNG5RSUJTWmh2anZZMUxNSHY1cFVy?=
 =?utf-8?B?cXNqVDhNaXRydExpWkV0akFSRHIzR0xBUmpqRExRVTM5a3VJN2I5ZDBLeHc0?=
 =?utf-8?B?QTJKN2xhMGdCM01qbkc0UGRSUThhdE1EWnZ3SWFSK0dCbExLdHNBV2hSY1NU?=
 =?utf-8?B?NFZJMFhOTWl2MSsyL2ZiVFc2VjUrdzB0VHJHRjRsT0MvVjdRUWtOK1RwbE5n?=
 =?utf-8?B?NlBvdzVBTm5aM2ZTQ01zc1RxSkt1UTQyRkJDWitWK3o1ZzI4V2R0S05WMFp1?=
 =?utf-8?Q?WJCfuFifPyYCFVPxbeynMvD3J?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC650D547A0BB646ADD6BEAF1CF7154B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2250a8-2450-4e85-2d79-08dc2e08709f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 09:28:16.3386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tSDviHj1fWkvShocVEn1ZGDG+qn2piGpy1/l9Flp2K4dOH03bcq7qZ6vd1OysiXae+xp/MQ5LzbcL0kWwbl0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6854

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTAyLTE1IGF0IDA5OjUzICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSW5zdGVhZCBvZiBvcGVuIGNvZGluZywgdXNl
IHRoZSBtaXBpX2RzaV9waXhlbF9mb3JtYXRfdG9fYnBwKCkgaGVscGVyDQo+IGZ1bmN0aW9uIGZy
b20gZHJtX21pcGlfZHNpLmggaW4gbXRrX2RzaV9wb3dlcm9uKCkgYW5kIGZvciB2YWxpZGF0aW9u
DQo+IGluIG10a19kc2lfYnJpZGdlX21vZGVfdmFsaWQoKS4NCj4gDQo+IE5vdGUgdGhhdCB0aGlz
IGZ1bmN0aW9uIGNoYW5nZXMgdGhlIGJlaGF2aW9yIG9mIHRoaXMgZHJpdmVyOg0KPiBwcmV2aW91
c2x5LA0KPiBpbiBjYXNlIG9mIHVua25vd24gZm9ybWF0cywgaXQgd291bGQgKHdyb25nbHkpIGFz
c3VtZSB0aGF0IGl0IHNob3VsZA0KPiBhY2NvdW50IGZvciBhIDI0LWJpdHMgZm9ybWF0IC0gbm93
IGl0IHdpbGwgcmV0dXJuIGFuIGVycm9yIGFuZCByZWZ1c2UNCj4gdG8gc2V0IGNsb2NrcyBhbmQv
b3IgZW5hYmxlIHRoZSBEU0kuDQo+IA0KPiBUaGlzIGlzIGRvbmUgYmVjYXVzZSBzZXR0aW5nIHRo
ZSB3cm9uZyBkYXRhIHJhdGUgd2lsbCBvbmx5IHByb2R1Y2UgYQ0KPiBnYXJiYWdlIG91dHB1dCB0
aGF0IHRoZSBkaXNwbGF5IHdpbGwgbWlzaW50ZXJwcmV0IGJvdGggYmVjYXVzZSB0aGlzDQo+IGRy
aXZlciBkb2Vzbid0IGFjdHVhbGx5IHByb3ZpZGUgYW55IGV4dHJhLXNwZWMgZm9ybWF0IHN1cHBv
cnQgYW5kL29yDQo+IGJlY2F1c2UgdGhlIGRhdGEgcmF0ZSAoaGVuY2UsIHRoZSBIUyBjbG9jaykg
d2lsbCBiZSB3cm9uZy4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+
DQoNCj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4YW5kcmUgTWVyZ25hdCA8YW1lcmduYXRAYmF5bGli
cmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+
IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgMjYgKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGluZGV4IGI2NDQ1MDVk
ZTk4YS4uOTUwMWY0MDE5MTk5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMN
Cj4gQEAgLTU5OCwxOSArNTk4LDEyIEBAIHN0YXRpYyBpbnQgbXRrX2RzaV9wb3dlcm9uKHN0cnVj
dCBtdGtfZHNpICpkc2kpDQo+ICAJaWYgKCsrZHNpLT5yZWZjb3VudCAhPSAxKQ0KPiAgCQlyZXR1
cm4gMDsNCj4gIA0KPiAtCXN3aXRjaCAoZHNpLT5mb3JtYXQpIHsNCj4gLQljYXNlIE1JUElfRFNJ
X0ZNVF9SR0I1NjU6DQo+IC0JCWJpdF9wZXJfcGl4ZWwgPSAxNjsNCj4gLQkJYnJlYWs7DQo+IC0J
Y2FzZSBNSVBJX0RTSV9GTVRfUkdCNjY2X1BBQ0tFRDoNCj4gLQkJYml0X3Blcl9waXhlbCA9IDE4
Ow0KPiAtCQlicmVhazsNCj4gLQljYXNlIE1JUElfRFNJX0ZNVF9SR0I2NjY6DQo+IC0JY2FzZSBN
SVBJX0RTSV9GTVRfUkdCODg4Og0KPiAtCWRlZmF1bHQ6DQo+IC0JCWJpdF9wZXJfcGl4ZWwgPSAy
NDsNCj4gLQkJYnJlYWs7DQo+ICsJcmV0ID0gbWlwaV9kc2lfcGl4ZWxfZm9ybWF0X3RvX2JwcChk
c2ktPmZvcm1hdCk7DQo+ICsJaWYgKHJldCA8IDApIHsNCj4gKwkJZGV2X2VycihkZXYsICJVbmtu
b3duIE1JUEkgRFNJIGZvcm1hdCAlZFxuIiwgZHNpLQ0KPiA+Zm9ybWF0KTsNCj4gKwkJcmV0dXJu
IHJldDsNCj4gIAl9DQo+ICsJYml0X3Blcl9waXhlbCA9IHJldDsNCj4gIA0KPiAgCWRzaS0+ZGF0
YV9yYXRlID0gRElWX1JPVU5EX1VQX1VMTChkc2ktPnZtLnBpeGVsY2xvY2sgKg0KPiBiaXRfcGVy
X3BpeGVsLA0KPiAgCQkJCQkgIGRzaS0+bGFuZXMpOw0KPiBAQCAtNzkzLDEyICs3ODYsMTEgQEAg
bXRrX2RzaV9icmlkZ2VfbW9kZV92YWxpZChzdHJ1Y3QgZHJtX2JyaWRnZQ0KPiAqYnJpZGdlLA0K
PiAgCQkJICBjb25zdCBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSkNCj4gIHsNCj4gIAlz
dHJ1Y3QgbXRrX2RzaSAqZHNpID0gYnJpZGdlX3RvX2RzaShicmlkZ2UpOw0KPiAtCXUzMiBicHA7
DQo+ICsJaW50IGJwcDsNCj4gIA0KPiAtCWlmIChkc2ktPmZvcm1hdCA9PSBNSVBJX0RTSV9GTVRf
UkdCNTY1KQ0KPiAtCQlicHAgPSAxNjsNCj4gLQllbHNlDQo+IC0JCWJwcCA9IDI0Ow0KPiArCWJw
cCA9IG1pcGlfZHNpX3BpeGVsX2Zvcm1hdF90b19icHAoZHNpLT5mb3JtYXQpOw0KPiArCWlmIChi
cHAgPCAwKQ0KPiArCQlyZXR1cm4gTU9ERV9FUlJPUjsNCj4gIA0KPiAgCWlmIChtb2RlLT5jbG9j
ayAqIGJwcCAvIGRzaS0+bGFuZXMgPiAxNTAwMDAwKQ0KPiAgCQlyZXR1cm4gTU9ERV9DTE9DS19I
SUdIOw0K

