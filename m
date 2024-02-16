Return-Path: <linux-kernel+bounces-68094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB38575EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F0FB23227
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB91426D;
	Fri, 16 Feb 2024 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eUvKXJNe";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="asV+PrXA"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C7134A9;
	Fri, 16 Feb 2024 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064474; cv=fail; b=Qj8l3c1WsXDC8rSw0/3JBJUOcErz7QcSTI+lOca1fbwCboTSDa0xEXKNUQ+jMdAtEaZ0CBPd4IznUrEaapJcCi/2fF7i3SJo+vVnTRbdNILgIZgol6u5vB3QvtsfWHsn98vfav+hKziHgpM5bF2mYL/nfmgHd3uTBN2cXymNRSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064474; c=relaxed/simple;
	bh=pe6S+Er9bxnbj4aPVndwuz53Bw9FH72w16LnF8mqNdQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jN1n6ZfdgiiUhRaV6S7ZJODEOgZT+waHBnzXa92cVXJ28yFPEke7aCiRq9Cd1/rvpazIwSwGxzVuXSacdcSDM0VUOnCacY7GnMbkXWs0QxBSxDH4EmoJWaDGoFwD5po+vYNBQUmqKfMoD22tQHSE8e3lSBn8KHqoatZA3PLUaXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eUvKXJNe; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=asV+PrXA; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8daa5c2acc9311ee9e680517dc993faa-20240216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=pe6S+Er9bxnbj4aPVndwuz53Bw9FH72w16LnF8mqNdQ=;
	b=eUvKXJNenBtB2Xqafr7GP7lkL0yp4xTOaJuIeoL26HG6/nzQu0xSB4za+Uu1qOXZIOEWEzXEeihskzNORLp2ql2Rz4Ik6kxnu5SPBVlxB0x1y8Vmvo6M4UU4Y89H24/qDWDKc9v5uMI5bHUNipTbZH4nXQ9gGBMDfNPd7aSjbVM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e34124b5-f06f-4346-b42e-fe62b7771635,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:e0467380-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8daa5c2acc9311ee9e680517dc993faa-20240216
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <moudy.ho@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1090280551; Fri, 16 Feb 2024 14:21:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Feb 2024 14:20:59 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Feb 2024 14:20:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDMb/UKHLXnP26ZlTUTrkAYkRNpss91brbYHMvmse41lH+Sj/rsf3WW7zzC/JZAO/DzkJTE52/C1nH/FH+eD91XR03/tkIyNRhezOiCQkbIvqLpfHKmHzbH/dZjfzSeEy9s5MctPxXYbXMK8BMPfkK3/pdoscG5oQM3CSROiG/8haNhmH+MbKgS012Uvcapy6x0T+JUvxQYbhXZZFWpgHTl2/t5MOboPhl+Ftwjq+Mnbr4onLKEEJIfUq9T/JXMBSc2g5Yp7L7FHT4O4x6F7iiNxX++NnDLNjlNVC6jAlCuFODuFpI02xodRKnM7sTBkWFDDy9d9yyG15POa9D1W9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe6S+Er9bxnbj4aPVndwuz53Bw9FH72w16LnF8mqNdQ=;
 b=ITKM9xJBvuupWpj5BQOFIlc0U1wEMTM5IneGrAUg/jlc+/gYP5p9KjIQaPJ6ueZmQmSEo+yRe6Zf/gqsfS/mTvO4WinI+5HFjFfL2ljzK7c266bYq2xx3UFUZAHZwOLZGeIKxx6OCCn4iK5smoV1hv+YcAjPa+wLWwC8UrnIGhNvmPDv1RZslCU4LORedL4b0Ze23sqvtGt6HCC7HkF23bJni/yRF9DTXE9whMfkoxvzxe0tkNgvGX4oeB6pnJ11U4pZDTWnQFMoE9Zw1mnRP51ysVziojoP7ok22BP1mRW10aCqA78rveqt1I+QxWUJzKBAyMvjOw06Uwu4sKiT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe6S+Er9bxnbj4aPVndwuz53Bw9FH72w16LnF8mqNdQ=;
 b=asV+PrXA78Eaw9aUWFZwO4Op/9z1KEQ7vTumkBhv247t7ssBmKp+C5OZ/YRb4khyCVImiHSIyEH8yQGZs0A8ag4YG6YDGg9izBbPKZFzA6O5HcQ/95ptqh/H5k/SQj5ZMNM+NHqxTWCAjdIFM2DdlWqPomeWv4B11hFLGA2tYbw=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by SEZPR03MB8831.apcprd03.prod.outlook.com (2603:1096:101:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Fri, 16 Feb
 2024 06:20:54 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::1cfd:c5ba:517f:87ac]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::1cfd:c5ba:517f:87ac%7]) with mapi id 15.20.7249.035; Fri, 16 Feb 2024
 06:20:54 +0000
From: =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 6/9] media: platform: mtk-mdp3: drop calling
 cmdq_pkt_finalize()
Thread-Topic: [PATCH 6/9] media: platform: mtk-mdp3: drop calling
 cmdq_pkt_finalize()
Thread-Index: AQHaX/ntDQq5VQBcE0uaYWmBKXbf4rEMgKMA
Date: Fri, 16 Feb 2024 06:20:54 +0000
Message-ID: <af4bfdd52f0ca022730aedcb456bb1a0b105ae3e.camel@mediatek.com>
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
	 <20240215004931.3808-7-chunkuang.hu@kernel.org>
	 <4dcfaf49-aaac-4980-a149-02fec3109f31@collabora.com>
In-Reply-To: <4dcfaf49-aaac-4980-a149-02fec3109f31@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|SEZPR03MB8831:EE_
x-ms-office365-filtering-correlation-id: a1ccc13d-e832-454b-4ba0-08dc2eb76e74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /aQ/gqzPDkqy4OiTXzdEHpnp760WRsONujZkl25b6L8LYdhBYk3TT1FWcob9+HIBXinwJU5XyveclgpiuAbcxxF4f4/6vLAQG+m/qFYdefp78m7gM9X8iYF7eVPlyaBk03YCc0P7k8qdn7gvNmmWpwVmETKLZ33qH9En8+yz64C5I8I2mmwdAErCYBTYzctjIb5d1uaCYQsbt2ExkPI6V1LxaLFXG4Uzc5ni099+R+srLSTQn0EwIiQPqyZEVgJ+eVIh5/dj8uuI9PxmGmz1GVG6H/AeYl/g7rQc9Rtn+w2E1+EaZTHUFKF3LJ/uMwUGtfESU8YjbJ8PMHzlM4fO55CMxGTzzRQgCDl6cpGIKKg1nWd7R2W/oYlQQD+SW8zw0T/jKMvzZnEnpUY7mfILUMkREa8Ws7ZcSnhUUZphz3FzxPGaCKQ9VGsnMxvUYXSC22hd4vpNbacRmXBMbv9AfubmXUsUuVaVei9o8LD+iNcDCfNKc2HvD/TjKLps4ccCecJlLio5wxAOui1YzCYfHThPJmAaUc+u4adicnCnXj9gvPCN0tfKLNOyJweQR2e17zZquIJDVJs9Pdj8pjhhC7l2L5KpXh0ACXs6Q7u6pxgJg2O1t+PFr5/V1NI4wRAX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(36756003)(85182001)(38070700009)(41300700001)(6486002)(110136005)(71200400001)(8936002)(6506007)(86362001)(2906002)(8676002)(478600001)(5660300002)(66946007)(66446008)(64756008)(76116006)(66556008)(316002)(38100700002)(2616005)(26005)(83380400001)(122000001)(66476007)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmsrOGM0NiswcHBNNU9IV1Bnb2JwOWJHUVpCY1VrZVMzWDRmR2hSd2UrS2xG?=
 =?utf-8?B?WjluRnBpN2pPZlg4NUFpRE1pTHllVE1ERGhjcHJzQzRMZUwyZVRxRXNETENM?=
 =?utf-8?B?ZFJucWRXVEplTDhYd256dkxjaUlvTmV4SVo4b09sbnZvOFpBSHdQT2ZCVzBN?=
 =?utf-8?B?ZlVhTktIMjl5NWdKLytGUmRQNmxKOWhQTS9zL2w5VTlrM3RaaWRQQmQrUlBJ?=
 =?utf-8?B?TUQvOFcxNzZuMnRhSXdCdlQwVWNNaldOZnJKbzdRZE9ieVRrZk85MTNwWTQy?=
 =?utf-8?B?R1N3bjg4bCs2Z1ppbkxINEtNS2dXS1BOWWhDN3ZtUnhGMWtLMHJkb3NOWnBt?=
 =?utf-8?B?ZzE2NTUzelZqWkxjM3RHSDgvRFhDRlRobUFJQllBWWVySjc2MFFVZ0RxTUVL?=
 =?utf-8?B?TFBNSlpWR3pkK0NyTDduNTBkRzNPVkpIV0xjem1EUGRFbXhUT0tnMW92bWd3?=
 =?utf-8?B?YktHd0JkUWE3VUdWZjZZOS93NnZndGVNaTBMRk9GbHE0NGVweHhqNTVhSm4y?=
 =?utf-8?B?MFgzTlFLS3lGdHFhd3E4a1VoNENYTzJuRTNUZ2c2SjZPUHFPdnh6Y0FQVFh0?=
 =?utf-8?B?MnVSK3RjcVh6WTVtcXRHL0lVeTFQTGVVY2hDRjhvZVMxVXpiYVY2SkdZNUNw?=
 =?utf-8?B?a0xuWEwvSW5PVjhnNzNrTXVBTDhxRUIzdGdVYnhabjJmQmZLVktQTGcvcnM2?=
 =?utf-8?B?amVTMCt6Snh6SGdab2swZitCZHVCU3FSdkNnOG5SeEhwNjM3RHd3ZXRUekJh?=
 =?utf-8?B?WWRWWk50UW9SMWFEOUh5OTk2M0xwZUFUNldRdkcyY1ZZb2tHbjFmVHd0Mith?=
 =?utf-8?B?Z01RZU5oeFBLeFZlUGY0b2JybjNBWldFMHRtRDVTcVFaa25xRENTbGRXdnJx?=
 =?utf-8?B?K3BoRWFlMWk5WGlMV2xyZXlGY2t2ZktKZlZKMldxVzEyWHlLL2R2VFZGMkJr?=
 =?utf-8?B?QmJZdmU1V21oYlBwVzJtZ1dOcXdXcDYwaVpNcE1zcDFaUmtTc3YwVys0SWMr?=
 =?utf-8?B?RWxhakZOYzQyWFRtY3YzSXIyOSsrZC9KRUhPc0pYMWFLanp1cTZxVWdLSW1Q?=
 =?utf-8?B?SkhaakcxVUllOGpxNzU0OFA5ME9XNHlPWDViOFlHUlIwQzhSYk51SG5CRGNG?=
 =?utf-8?B?bUJGVkhtZTNnbFZ3U2pYaHRTeDhKMUJBQnRmRjhFRlZudktWbU1QcTF5SFZv?=
 =?utf-8?B?YTE1SXFwUHNxWFdQTU1YczIyUUdXejNiRGN3OFFycm9iRnY3NnJHMFVacnd3?=
 =?utf-8?B?UFVScWh0bHZSQ2RXL2Y4NXJSOGxUZzRhdEhuTURZbVJGUUFHUGovU1Y1eGVy?=
 =?utf-8?B?NzhzQVFCOXlBdGJKMVZMUHNyemlqbWZDcVNwZko3VExER0xWQVBPQlF6cHVF?=
 =?utf-8?B?THFxV1VkczNKSTloZU5XREhkZlgvcDJrZXNadGkwbTNMcXNzL2lQTmhNYklL?=
 =?utf-8?B?SENuZ2QyV1ZkMlUxUE9OUjk3OWUvck44UnY0K0dWUDhBWlQrU3dZYnVCSDBI?=
 =?utf-8?B?c21hYnEwcmUzb2c1eWJrdUo3Q3VQUmJjMlQwMzAweTlXRTZ6VXJhVkNLMGZx?=
 =?utf-8?B?c3p0TWhvTmtwK2tUMnRleXAvbVh3anloVy9FSVJ6Rm9MVy9zMFdHc1N3UStV?=
 =?utf-8?B?T3NnL1o4d3BzTk96STcveEJsWUkrODV4eVc0M0dXRnN5ajZMeHArVjlINzdX?=
 =?utf-8?B?ZlkzUFJYUGJOcEhtdG51UkpCYVkxNG5GVkJZNGM5V2ZLcjRzTWkvSTY4VWtQ?=
 =?utf-8?B?Q1pOQ0RNcTF4S0ttM2tYM0Mxd3AzeFpEb21mNnZaVTZNU2lDUGlpT04yVzRl?=
 =?utf-8?B?VS9yOU5iZDJxUFl0cTg3amZIdzZpY0VrZXpVQS9vTUZ2Qi9wdnk0Rk1CamxK?=
 =?utf-8?B?bjdCTzFYNHQyanVKaDAwZkNmamV0U3ByRUpsUHQ1UG1NYmFaR2R0dG5XU2x5?=
 =?utf-8?B?YXRHNEZtN2prYlIyRk5Cc2JlTjJrenNSeEFjeVhuSEZPUmtXeUU2M1Y1VG5J?=
 =?utf-8?B?dGVKWGxuaWdPV3B3ZDlnb1lUenJhWlF5b0dneEMwdVlLTzhYc0tha01YTDFa?=
 =?utf-8?B?RkRCejFKaTB3VGZ4a1ZHZVl2NzdkVGY0eFdVUVFtbm1UdWlBRWhaUlVMNENs?=
 =?utf-8?Q?fM5hvUUSaEY4cbe7iK3FT4btB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <635D13E34078824CA8263D75B3C285E7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ccc13d-e832-454b-4ba0-08dc2eb76e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 06:20:54.6712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRsaeBOkRbsmgquYo2hRQoPHtQ+J2LYex1fiSpnoK13kyT9ExZBV7iN3ZYcC36ZAMunqEwnK/s+RZVF2wsnJ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8831
X-MTK: N

T24gVGh1LCAyMDI0LTAyLTE1IGF0IDExOjI5ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTUvMDIvMjQgMDE6NDksIENodW4tS3VhbmcgSHUgaGEgc2NyaXR0
bzoNCj4gPiBCZWNhdXNlIGNsaWVudCBkcml2ZXIgaGFzIHRoZSBpbmZvcm1hdGlvbiBvZiBzdHJ1
Y3QgY21kcV9jbGllbnQsIHNvDQo+ID4gaXQncyBub3QgbmVjZXNzYXJ5IHRvIHN0b3JlIHN0cnVj
dCBjbWRxX2NsaWVudCBpbiBzdHJ1Y3QgY21kcV9wa3QuDQo+ID4gY21kcV9wa3RfZmluYWxpemUo
KSB1c2Ugc3RydWN0IGNtZHFfY2xpZW50IGluIHN0cnVjdCBjbWRxX3BrdCwgc28NCj4gPiBpdCdz
DQo+ID4gZ29pbmcgdG8gYmUgYWJhbmRvbmVkLiBUaGVyZWZvcmUsIHVzZSBjbWRxX3BrdF9lb2Mo
KSBhbmQNCj4gPiBjbWRxX3BrdF9ub3AoKQ0KPiA+IHRvIHJlcGxhY2UgY21kcV9wa3RfZmluYWxp
emUoKS4NCj4gDQo+IE5vLCBpdCdzIG5vdCBiZWNhdXNlIGNtZHFfcGt0X2ZpbmFsaXplKCkgaGFz
IGNtZHFfY2xpZW50LCBidXQgYmVjYXVzZQ0KPiB3ZSB3YW50DQo+IGZpbmVyIGdyYWluIGNvbnRy
b2wgb3ZlciB0aGUgQ01EUSBwYWNrZXRzLCBhcyBub3QgYWxsIGNhc2VzIHJlcXVpcmUNCj4gdGhl
IE5PUA0KPiBwYWNrZXQgdG8gYmUgYXBwZW5kZWQgYWZ0ZXIgRU9DLg0KPiANCj4gQmVzaWRlcywg
aG9uZXN0bHkgSSdtIG5vdCBldmVuIHN1cmUgaWYgdGhlIE5PUCBpcyBhbHdheXMgcmVxdWlyZWQg
aW4NCj4gTURQMywgc28uLi4NCj4gDQo+IC4uLk1vdWR5LCB5b3Uga25vdyB0aGUgTURQMyB3YXkg
YmV0dGVyIHRoYW4gYW55b25lIGVsc2UgLSBjYW4geW91DQo+IHBsZWFzZQ0KPiBjaGVjayBpZiBO
T1AgaXMgYWN0dWFsbHkgbmVlZGVkIGhlcmU/DQo+IA0KPiBUaGFua3MhDQo+IEFuZ2Vsbw0KPiAN
Cg0KSGkgQW5nZWxvLA0KDQpBZnRlciBjb25maXJtaW5nIHdpdGggdGhlIGhhcmR3YXJlIGRlc2ln
bmVyIGFuZCBwZXJmb3JtaW5nIHRoZSB2aWRlbw0KcGxheWJhY2sgdGVzdCwgaXQgd2FzIGRpc2Nv
dmVyZWQgdGhhdCBNRFAzIGlzIGNhcGFibGUgb2YgZXhjbHVkaW5nIHRoZQ0KTk9QKGp1bXApIGlu
c3RydWN0aW9uLg0KDQpTaW5jZXJlbHksDQpNb3VkeQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IENodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+ICAg
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLWNtZHEuYyB8IDMg
KystDQo+ID4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1kcDMt
Y29yZS5jIHwgMiArKw0KPiA+ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAz
L210ay1tZHAzLWNvcmUuaCB8IDEgKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLWNtZHEuYw0KPiA+IGIvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLWNtZHEuYw0KPiA+IGluZGV4IDZh
ZGFjODU3YTQ3Ny4uYTQyMGQ0OTJkODc5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1jbWRxLmMNCj4gPiArKysgYi9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1kcDMtY21kcS5jDQo+ID4gQEAgLTQ3
MSw3ICs0NzEsOCBAQCBpbnQgbWRwX2NtZHFfc2VuZChzdHJ1Y3QgbWRwX2RldiAqbWRwLCBzdHJ1
Y3QNCj4gPiBtZHBfY21kcV9wYXJhbSAqcGFyYW0pDQo+ID4gICAJCWRldl9lcnIoZGV2LCAibWRw
X3BhdGhfY29uZmlnIGVycm9yXG4iKTsNCj4gPiAgIAkJZ290byBlcnJfZnJlZV9wYXRoOw0KPiA+
ICAgCX0NCj4gPiAtCWNtZHFfcGt0X2ZpbmFsaXplKCZjbWQtPnBrdCk7DQo+ID4gKwljbWRxX3Br
dF9lb2MoJmNtZC0+cGt0KTsNCj4gPiArCWNtZHFfcGt0X25vcCgmY21kLT5wa3QsIG1kcC0+Y21k
cV9zaGlmdF9wYSk7DQo+ID4gICANCj4gPiAgIAlmb3IgKGkgPSAwOyBpIDwgbnVtX2NvbXA7IGkr
KykNCj4gPiAgIAkJbWVtY3B5KCZjb21wc1tpXSwgcGF0aC0+Y29tcHNbaV0uY29tcCwNCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAz
LWNvcmUuYw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1t
ZHAzLWNvcmUuYw0KPiA+IGluZGV4IDk0ZjRlZDc4NTIzYi4uMjIxNDc0NGM5MzdjIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1j
b3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRr
LW1kcDMtY29yZS5jDQo+ID4gQEAgLTIzMSw2ICsyMzEsOCBAQCBzdGF0aWMgaW50IG1kcF9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4gKnBkZXYpDQo+ID4gICAJCWdvdG8gZXJyX3B1
dF9zY3A7DQo+ID4gICAJfQ0KPiA+ICAgDQo+ID4gKwltZHAtPmNtZHFfc2hpZnRfcGEgPSBjbWRx
X2dldF9zaGlmdF9wYShtZHAtPmNtZHFfY2x0LT5jaGFuKTsNCj4gPiArDQo+ID4gICAJaW5pdF93
YWl0cXVldWVfaGVhZCgmbWRwLT5jYWxsYmFja193cSk7DQo+ID4gICAJaWRhX2luaXQoJm1kcC0+
bWRwX2lkYSk7DQo+ID4gICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgbWRwKTsNCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAz
LWNvcmUuaA0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1t
ZHAzLWNvcmUuaA0KPiA+IGluZGV4IDdlMjFkMjI2Y2ViOC4uZWQ2MWUwYmI2OWVlIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1j
b3JlLmgNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRr
LW1kcDMtY29yZS5oDQo+ID4gQEAgLTgzLDYgKzgzLDcgQEAgc3RydWN0IG1kcF9kZXYgew0KPiA+
ICAgCXUzMgkJCQkJaWRfY291bnQ7DQo+ID4gICAJc3RydWN0IGlkYQkJCQltZHBfaWRhOw0KPiA+
ICAgCXN0cnVjdCBjbWRxX2NsaWVudAkJCSpjbWRxX2NsdDsNCj4gPiArCXU4CQkJCQljbWRxX3No
aWZ0X3BhOw0KPiA+ICAgCXdhaXRfcXVldWVfaGVhZF90CQkJY2FsbGJhY2tfd3E7DQo+ID4gICAN
Cj4gPiAgIAlzdHJ1Y3QgdjRsMl9kZXZpY2UJCQl2NGwyX2RldjsNCj4gDQo+IA0K

