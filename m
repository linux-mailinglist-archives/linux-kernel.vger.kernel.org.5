Return-Path: <linux-kernel+bounces-54557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9C184B0AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14EC285CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554FB12E1D9;
	Tue,  6 Feb 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TGJAXWGo";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="M33H4w4R"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B212E1CE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210080; cv=fail; b=IZCFp5XqD8JoNwiBCv6JTDvf9Y/ApkjVBsnuhN5UzzJ/8TD3xrRp3uF61Mqa6yEZEBd2SiXIn+lYu4cNGGQ0qBapWBAjrzTM0nfphuQPTNJUsL3gjEd4ve1JjGXqQDMfKafmd1Mn/7Fl+BOhg4PyIRbPVUwvoTdic7jd8VVXKNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210080; c=relaxed/simple;
	bh=6J11GH0cAfwuuH3c8FnWF/x+fWeYuMyOAPesslnx8Og=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GYJvYqegMRVcMPIMosVjvpzUV9/8O6ntaP8p6r3V+h2bL49rD0eLJv2ACXYCM/UB+cuc4ZD/7z6Z51QbotSNe2uqoijmvdine7MrmLpOaX7337fxUcRRVupToU4PkboSTe41Cc6n5vOvhMHr+fjIMEJuHDjmJnL4CkxV/FjiZLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TGJAXWGo; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=M33H4w4R; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 464a61e4c4ce11eea2298b7352fd921d-20240206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6J11GH0cAfwuuH3c8FnWF/x+fWeYuMyOAPesslnx8Og=;
	b=TGJAXWGoufzNFFFy0Olpohs8ClX0Vhj3EyB/hc6434ZN7VdWpNJs8X4+Tt2IU4k9QhC/82Pz9/X5gVmwI1Rctxr5dSGkjxf/+rWfl7zmUH+NeDSxGIuWDaB1Cp/aO3ts5Fe7B/UpY0oR59JCC4F7MXLAPApNoEUTsZIXD7c7XD0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3f59a088-c831-4714-8bbf-a21e1dacf315,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:f3362d80-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 464a61e4c4ce11eea2298b7352fd921d-20240206
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 711349573; Tue, 06 Feb 2024 17:01:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Feb 2024 17:01:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Feb 2024 17:01:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF9vegIhQ2U/TRkfEVzNp94a1SREkwOybsW7aD9YxDT3gFG52rGQUyr/RnSPXy/3u/fnXUVumPujPAW3GEL7Eo1KZD6x+gWHBwzZYtT7Bc7RPDhB/yomBVK+MRe/Gka6VfitQTEGrhfKNj8wu2bVEuD5w928u7QxI7JcOhV7t/ZGGS3RRxIroOuuZKQ2f1mrUBqEs4TXdSZpnTH238dXi87PVguqT0+g2adQUQ6qEBiOtI6X5xNxiVX68CzJgdSV5Ul3vy3jvA4VYu+Q3jYsgL3SuAmh6dBYbuEPzVW1I/dgPKN422AUfDsxRSDnWkxYc3minPF2VwGmXLz25pW0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J11GH0cAfwuuH3c8FnWF/x+fWeYuMyOAPesslnx8Og=;
 b=VyJa2/nmsyhFRomRwG2eoscBydhRYaD0IZXiIorNGEa5e+3LBvWJYid7Vm6D38+cN//XErz9URU82tnmNfxS6W2xJvdhFMmzLNX2YmnN1jRS6nGoDOcSGFWgT19Lu/z3GlJWA6WjsTBXzvLzOJYii/r7H+vtlzXcsK7+eAGPJOajHM1ZFNaCbiS4+7pEBw+z1E1AiG9GT595VMMjbR9p5OPVKyq45YB63VGyDr9g/DejxF0noPUfS6l+qqD5AaJDlosfS7Dny/B9VRi3Xxy6JpOPcXkBFbjtYULYzt4LoR0T8TVlBTI1U42FHP31bQWuGF6WhORaSq1SxREcoZnd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J11GH0cAfwuuH3c8FnWF/x+fWeYuMyOAPesslnx8Og=;
 b=M33H4w4RpzkyAGttxAA6qR86FGAgvbVw6p4ojj7mvmW1bYl3cFQAD4m6247osq5BMD5n83qH1uN3CB4fSSBBZo1cbw5gTpecyc4CE1soVDWrLKWAVeFQP2NdWEZlcblQcCOWUt/bVDi+sFImVd2nQGvtawh1N/nJ2bUChkcz6fY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6217.apcprd03.prod.outlook.com (2603:1096:400:12d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 08:57:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::2a01:4518:f0b1:281]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::2a01:4518:f0b1:281%5]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 08:57:08 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 1/7] drm/mediatek: dsi: Use GENMASK() for register mask
 definitions
Thread-Topic: [PATCH v3 1/7] drm/mediatek: dsi: Use GENMASK() for register
 mask definitions
Thread-Index: AQHaVDmU2FtMN8EVD0+Wt/KKUMsVbrD9DHmA
Date: Tue, 6 Feb 2024 08:57:08 +0000
Message-ID: <082bc4d9efd0746d7ec25eab0b3bf96018e997e5.camel@mediatek.com>
References: <20240131113434.241929-1-angelogioacchino.delregno@collabora.com>
	 <20240131113434.241929-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240131113434.241929-2-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6217:EE_
x-ms-office365-filtering-correlation-id: 59a2a66d-19f6-40a9-1705-08dc26f19984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDXZf0hwwxyg1yJaPpFQF6Gq3VXMIinO+Sr3/1Nbrfrumkmes9TOyQKN5keQaVsXRmjntgsrC+eJwfz3mlSKN6lhlY+GAf3DRdmdjryvRSWKyOWzgxXQAUpAtmu/j5lDNJ0btaZirvjewK8Rh75wdcu8uQduxdukf3NvCYLaOG7z0Kruef2kGnP5Gre9xue5vMIgaqO9yx7r4l+ED7oXXEUttR7uBuSyroPdfn85ugy0djV5HvlTW08snPWUnqwH4pFhSWCvODNmRt6YDThf0frVouKoxmD4vy6D1xAxcEm868s0Y4ku84qKDDj99RwF22yhgxrXXOyKrqBLGXHPEUP/jUuIG2mf7dEZ63MmJuNk25N/ntH/jShuUtZhpJxPXd+QAZhY9qCIX22zzXwEA7loc7Q/zB9MbryyhmcsuhUUTwwWLQKm2jdho3Yp5z61G5vhvjp/bnC6/V2s1MnQTNEbELD2B/9A4KXBybihkBhnkJNZsTj3ZJxTXN6zKkvmhGSa8xjwvSHSb8qeNrzPO1xeMfjrQDHdzyNcgVBXAXi88j1t5veUd4ze/DEmzkB+ddxFec4Uoy6ZEp10LrNRAWBEkn0a5fkvjjuYOdxqPS1zA3FMvvxt0WGho2KFbcKY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(76116006)(64756008)(110136005)(8936002)(66946007)(66476007)(54906003)(66446008)(36756003)(85182001)(66556008)(478600001)(6506007)(316002)(8676002)(4326008)(6486002)(6512007)(71200400001)(38070700009)(7416002)(2906002)(122000001)(38100700002)(5660300002)(83380400001)(26005)(2616005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU5qalMxV1E3U0Zvc0N5aFZDMFdYZzFnNjVnemJRNmF5WDg2eDRRYkw5bzRO?=
 =?utf-8?B?QWNGRDNFZWN1N0lzWmJKMDNXOWlSZ015eGpEN0F3SmJiT3A5aGpVbjNZQnZJ?=
 =?utf-8?B?VTQvRXpkbEErVUtjS0pzVEdFZUM1UjZBOEdRNzFCdHlhcnFSelhiU2VLZXdT?=
 =?utf-8?B?RUw2WWNmNjVsMTZIQ3pmeVk5WFJjYXJoR0dKdmwzMmZtbGFtTVRmTlU3UzdI?=
 =?utf-8?B?bzU4TGg3Q0plcjBGZDFGc3ZXRjFzWnhXR1hWckozcWpzaXdmR3dtb3Vocm5k?=
 =?utf-8?B?bStoTDJJbWprb29KMkxuNDVHeEpISkE3TnAwbmE2SmpCVzVRbys4aGVKMldp?=
 =?utf-8?B?Tm1mZWdZODlKaExjRnNUcHZMK1hkMHdoMVRvczBGbXRoRHBhQXVJS002QXgw?=
 =?utf-8?B?bGJGakN2YmFxSWptUHdCNXR3ZFNUUmxIUkVnZHdhMmN1cHRoTklkRHlFQ0RV?=
 =?utf-8?B?VURSZFFzUUtGOVMrOEtzdUJadnlJMy9TYTFEeGVxL3ZSUUhWUjFHYllDaFo0?=
 =?utf-8?B?TXlxOFlLMkd2SHZ4NDl6dFRjcFFSbzhwZE42Wm95ZUtvakpZT2VqUklCTkM3?=
 =?utf-8?B?RlJUdzBJalRPa0dhVmlTTDA1S0hyWG1ad3ZWODl1YTZZZjNiQjVVV1o2RjhH?=
 =?utf-8?B?dEpBbFE2SEg2LzhaaXpiRGRiUkRjMVBOWFRjYk40TjZESkFTY1o1angwN29O?=
 =?utf-8?B?MGFnOHVXSzdkTWlkWGZ3bjRESnZ3bFN3eWVyZGFtaFg3M0NGSnNPNTA0MDFZ?=
 =?utf-8?B?OERRRHRFeE5GSkVBVmpSZXlRUzR6QjhRYVZDcTd2KzRuQlc2bTlwcVdZd3R4?=
 =?utf-8?B?dEJGWG1rUmRuQ3UvdTJ4NmpONkVDZTA4bGhQU01zNnFMOVlRODRQL2tPd1Jp?=
 =?utf-8?B?SllOM1NWekhPT0JuNlZGOHR2dmIvd0xZVVNjb2RpS0VNeHZvSUVCREtUWlVT?=
 =?utf-8?B?SDU4QVozS3UvOStVdE45VUEvVGxXV25IUkpTU3RtRUdyODh3NVJpK3RZYnJQ?=
 =?utf-8?B?NUoxc2tIODA2d3ZUUVRNTC9EbzJTWThLSnppcmZlbmhIMVpEVlRlQUNaaitn?=
 =?utf-8?B?bHRFMEE5Y2phUy9xcGZUMURlVlNSSWxINEl4NDIxWUUxdmhiOEtlemRreXZQ?=
 =?utf-8?B?c1RrKzFldTBsSzBTRFhiRisxc2QwQnJrUUxPWGUyeVRFNFRMRTY2Ty95QkZz?=
 =?utf-8?B?WUo5ZUhjUDVFOWdjN1FDLy9maVp3MWZDUlpBWDJLTWtQMEM0TkdEOFBWWEFV?=
 =?utf-8?B?Y2pkK0lTbWZDdjRwa2F1RStLLzFJQjZjMm9IOHlPSFBHMGVGOVgzUk1JblV2?=
 =?utf-8?B?dkhaVUZ5N29xNnpMSk9tcFo1NCtGbmFSbUhRRENzUlhEdWVkSk43ZUJIcHZW?=
 =?utf-8?B?c25TT3JLVis0Nk9oU0FwN3haU0xWRGJ6WUNsRXdaN2djaEtBU2tlUG9pSGcx?=
 =?utf-8?B?YXczdE04eHUzdy9iNUJkc2NTNWhGdkh4dWRLOVlsc2s1VGE4OXVBd2l1ckNs?=
 =?utf-8?B?TUJ1c0JGaEdvR1dqU1cydjF0QXFXQkdZOEk4a1JaVTZCcjdwenU3a3BLVHFu?=
 =?utf-8?B?a2lQQUNCalUrN0ZpY3U5RC95ZnJucWJsU3AvSzROUGpEU3FGTkVGdE9qZmFR?=
 =?utf-8?B?WExmMWsyVHVEbU1uNlVnV09yaTlmam5zNW40aDBmeWNPUHNIemxaYXBYUlV0?=
 =?utf-8?B?V1gyRURINmFCYTRkTHQ5VlBHN1lLbW9RT1hsL0tESXcwWUVRY1ZyR2FCcWJZ?=
 =?utf-8?B?Q1ZoYnhsd2UxWEZtVGU5NUxONURnMWR4TkNGT0thLzIvMk9aTG9RODBFN3hu?=
 =?utf-8?B?dzZ5MVVMN08xc2F2UGpVTFlSRjFnZ096K2FXa2FkcUhqZ2lvNlh4SEVsbVoy?=
 =?utf-8?B?MnIyMzlvY2k1S3BRUlF0eFdBK2poSk5ocUFQWHpTOFJDcm1VVHFwdUpSeS81?=
 =?utf-8?B?aUoyOEs5VGV4QTUrZHhFM2t5elBmdTBtRzZkY2JaS0pDc1cwY01DYVdDQWZ4?=
 =?utf-8?B?cHFhdlJnWXZQMjM0S3duRkxITnc1ajNzbkt2Tm9nZ0lSajVrSWxubTQ4V1Fi?=
 =?utf-8?B?UXpQTHdLVlFsSWVFYm1SUnI2eUpjUEhRTk1vRTZUclRVTGdqUm1KdkJHZ0pv?=
 =?utf-8?Q?+eqXKEUvaAfNpfc+MYI/3+cRU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B45535EF843F22449A1885C58CC2926A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a2a66d-19f6-40a9-1705-08dc26f19984
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 08:57:08.4189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soyRr/5XbrRiVDQHwSoZfEVnE84Wt5lpA6ajQMCRIUSIu2wZOGyqJDksTN9wplXJ/hZXAKxxzKM9neU0PraFDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6217
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.208300-8.000000
X-TMASE-MatchedRID: O/y65JfDwwvoSitJVour/fGG8F2k2BBVYefZ7F9kLgsNcckEPxfz2Iu3
	renu5Y0wGvX6HjFuUydix2NkmtuoxSZM0GOuX4IBA9lly13c/gGuiRuR9mCauk1KG1YrOQW/Qkz
	RZrI7fzZRzOYs2dj5zLUeXVaVYVhISSOWVJeuO1DSBVVc2BozSlkMvWAuahr8+gD2vYtOFhgqtq
	5d3cxkNZd/mwLf2BVUxCr9OQEO4X2OIOybJdJq1+9URd5lk90cjwoXpTEK/WZgO21BQaodlQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.208300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3DFD47282DF4823C893CBE4B95825B7D03282B0DD2D94255282C0E8D48C95E7D2000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTAxLTMxIGF0IDEyOjM0ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gQ2hhbmdlIG1hZ2ljIG51bWVyaWNhbCBtYXNr
cyB3aXRoIHVzYWdlIG9mIHRoZSBHRU5NQVNLKCkgbWFjcm8NCj4gdG8gaW1wcm92ZSByZWFkYWJp
bGl0eS4NCj4gDQo+IFdoaWxlIGF0IGl0LCBhbHNvIGZpeCB0aGUgRFNJX1BTX1NFTCBtYXNrIHRv
IGluY2x1ZGUgYWxsIGJpdHMgaW5zdGVhZA0KPiBvZiBqdXN0IGEgc3Vic2V0IG9mIHRoZW0uDQo+
IA0KPiBUaGlzIGNvbW1pdCBicmluZ3Mgbm8gZnVuY3Rpb25hbCBjaGFuZ2VzLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2No
aW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kc2kuYyB8IDQ1ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiBpbmRleCBhMmZkZmM4ZGRiMTUu
LjNiNzM5MmMwM2I0ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kc2kuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IEBA
IC01OCwxOCArNTgsMTggQEANCj4gIA0KPiAgI2RlZmluZSBEU0lfVFhSWF9DVFJMCQkweDE4DQo+
ICAjZGVmaW5lIFZDX05VTQkJCQlCSVQoMSkNCj4gLSNkZWZpbmUgTEFORV9OVU0JCQkoMHhmIDw8
IDIpDQo+ICsjZGVmaW5lIExBTkVfTlVNCQkJR0VOTUFTSyg1LCAyKQ0KPiAgI2RlZmluZSBESVNf
RU9UCQkJCUJJVCg2KQ0KPiAgI2RlZmluZSBOVUxMX0VOCQkJCUJJVCg3KQ0KPiAgI2RlZmluZSBU
RV9GUkVFUlVOCQkJQklUKDgpDQo+ICAjZGVmaW5lIEVYVF9URV9FTgkJCUJJVCg5KQ0KPiAgI2Rl
ZmluZSBFWFRfVEVfRURHRQkJCUJJVCgxMCkNCj4gLSNkZWZpbmUgTUFYX1JUTl9TSVpFCQkJKDB4
ZiA8PCAxMikNCj4gKyNkZWZpbmUgTUFYX1JUTl9TSVpFCQkJR0VOTUFTSygxNSwgMTIpDQo+ICAj
ZGVmaW5lIEhTVFhfQ0tMUF9FTgkJCUJJVCgxNikNCj4gIA0KPiAgI2RlZmluZSBEU0lfUFNDVFJM
CQkweDFjDQo+IC0jZGVmaW5lIERTSV9QU19XQwkJCTB4M2ZmZg0KPiAtI2RlZmluZSBEU0lfUFNf
U0VMCQkJKDMgPDwgMTYpDQo+ICsjZGVmaW5lIERTSV9QU19XQwkJCUdFTk1BU0soMTQsIDApDQo+
ICsjZGVmaW5lIERTSV9QU19TRUwJCQlHRU5NQVNLKDE5LCAxNikNCg0KVGhlIG9yaWdpbmFsIGRl
ZmluaXRpb24gb2YgRFNJX1BTX1dDL0RTSV9QU19TRUwgaXMgY29ycmVjdCBpbiBNVDgxNzMuDQpT
byBib3RoIG5lZWQgdHdvIGRlZmluaXRpb24gYW5kIGxldCBlYWNoIFNvQyBzZWxlY3QgaXRzIG93
biBkZWZpbml0aW9uLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAgI2RlZmluZSBQQUNLRURfUFNfMTZC
SVRfUkdCNTY1CQkoMCA8PCAxNikNCj4gICNkZWZpbmUgTE9PU0VMWV9QU18xOEJJVF9SR0I2NjYJ
CSgxIDw8IDE2KQ0KPiAgI2RlZmluZSBQQUNLRURfUFNfMThCSVRfUkdCNjY2CQkoMiA8PCAxNikN
Cj4gQEAgLTEwOSwyNiArMTA5LDI2IEBADQo+ICAjZGVmaW5lIExEMF9XQUtFVVBfRU4JCQlCSVQo
MikNCj4gIA0KPiAgI2RlZmluZSBEU0lfUEhZX1RJTUVDT04wCTB4MTEwDQo+IC0jZGVmaW5lIExQ
WAkJCQkoMHhmZiA8PCAwKQ0KPiAtI2RlZmluZSBIU19QUkVQCQkJCSgweGZmIDw8IDgpDQo+IC0j
ZGVmaW5lIEhTX1pFUk8JCQkJKDB4ZmYgPDwgMTYpDQo+IC0jZGVmaW5lIEhTX1RSQUlMCQkJKDB4
ZmYgPDwgMjQpDQo+ICsjZGVmaW5lIExQWAkJCQlHRU5NQVNLKDcsIDApDQo+ICsjZGVmaW5lIEhT
X1BSRVAJCQkJR0VOTUFTSygxNSwgOCkNCj4gKyNkZWZpbmUgSFNfWkVSTwkJCQlHRU5NQVNLKDIz
LCAxNikNCj4gKyNkZWZpbmUgSFNfVFJBSUwJCQlHRU5NQVNLKDMxLCAyNCkNCj4gIA0KPiAgI2Rl
ZmluZSBEU0lfUEhZX1RJTUVDT04xCTB4MTE0DQo+IC0jZGVmaW5lIFRBX0dPCQkJCSgweGZmIDw8
IDApDQo+IC0jZGVmaW5lIFRBX1NVUkUJCQkJKDB4ZmYgPDwgOCkNCj4gLSNkZWZpbmUgVEFfR0VU
CQkJCSgweGZmIDw8IDE2KQ0KPiAtI2RlZmluZSBEQV9IU19FWElUCQkJKDB4ZmYgPDwgMjQpDQo+
ICsjZGVmaW5lIFRBX0dPCQkJCUdFTk1BU0soNywgMCkNCj4gKyNkZWZpbmUgVEFfU1VSRQkJCQlH
RU5NQVNLKDE1LCA4KQ0KPiArI2RlZmluZSBUQV9HRVQJCQkJR0VOTUFTSygyMywgMTYpDQo+ICsj
ZGVmaW5lIERBX0hTX0VYSVQJCQlHRU5NQVNLKDMxLCAyNCkNCj4gIA0KPiAgI2RlZmluZSBEU0lf
UEhZX1RJTUVDT04yCTB4MTE4DQo+IC0jZGVmaW5lIENPTlRfREVUCQkJKDB4ZmYgPDwgMCkNCj4g
LSNkZWZpbmUgQ0xLX1pFUk8JCQkoMHhmZiA8PCAxNikNCj4gLSNkZWZpbmUgQ0xLX1RSQUlMCQkJ
KDB4ZmYgPDwgMjQpDQo+ICsjZGVmaW5lIENPTlRfREVUCQkJR0VOTUFTSyg3LCAwKQ0KPiArI2Rl
ZmluZSBDTEtfWkVSTwkJCUdFTk1BU0soMjMsIDE2KQ0KPiArI2RlZmluZSBDTEtfVFJBSUwJCQlH
RU5NQVNLKDMxLCAyNCkNCj4gIA0KPiAgI2RlZmluZSBEU0lfUEhZX1RJTUVDT04zCTB4MTFjDQo+
IC0jZGVmaW5lIENMS19IU19QUkVQCQkJKDB4ZmYgPDwgMCkNCj4gLSNkZWZpbmUgQ0xLX0hTX1BP
U1QJCQkoMHhmZiA8PCA4KQ0KPiAtI2RlZmluZSBDTEtfSFNfRVhJVAkJCSgweGZmIDw8IDE2KQ0K
PiArI2RlZmluZSBDTEtfSFNfUFJFUAkJCUdFTk1BU0soNywgMCkNCj4gKyNkZWZpbmUgQ0xLX0hT
X1BPU1QJCQlHRU5NQVNLKDE1LCA4KQ0KPiArI2RlZmluZSBDTEtfSFNfRVhJVAkJCUdFTk1BU0so
MjMsIDE2KQ0KPiAgDQo+ICAjZGVmaW5lIERTSV9WTV9DTURfQ09OCQkweDEzMA0KPiAgI2RlZmlu
ZSBWTV9DTURfRU4JCQlCSVQoMCkNCj4gQEAgLTEzOCwxMyArMTM4LDE0IEBADQo+ICAjZGVmaW5l
IEZPUkNFX0NPTU1JVAkJCUJJVCgwKQ0KPiAgI2RlZmluZSBCWVBBU1NfU0hBRE9XCQkJQklUKDEp
DQo+ICANCj4gLSNkZWZpbmUgQ09ORklHCQkJCSgweGZmIDw8IDApDQo+ICsvKiBDTURRIHJlbGF0
ZWQgYml0cyAqLw0KPiArI2RlZmluZSBDT05GSUcJCQkJR0VOTUFTSyg3LCAwKQ0KPiAgI2RlZmlu
ZSBTSE9SVF9QQUNLRVQJCQkwDQo+ICAjZGVmaW5lIExPTkdfUEFDS0VUCQkJMg0KPiAgI2RlZmlu
ZSBCVEEJCQkJQklUKDIpDQo+IC0jZGVmaW5lIERBVEFfSUQJCQkJKDB4ZmYgPDwgOCkNCj4gLSNk
ZWZpbmUgREFUQV8wCQkJCSgweGZmIDw8IDE2KQ0KPiAtI2RlZmluZSBEQVRBXzEJCQkJKDB4ZmYg
PDwgMjQpDQo+ICsjZGVmaW5lIERBVEFfSUQJCQkJR0VOTUFTSygxNSwgOCkNCj4gKyNkZWZpbmUg
REFUQV8wCQkJCUdFTk1BU0soMjMsIDE2KQ0KPiArI2RlZmluZSBEQVRBXzEJCQkJR0VOTUFTSygz
MSwgMjQpDQo+ICANCj4gICNkZWZpbmUgTlNfVE9fQ1lDTEUobiwgYykgICAgKChuKSAvIChjKSAr
ICgoKG4pICUgKGMpKSA/IDEgOiAwKSkNCj4gIA0K

