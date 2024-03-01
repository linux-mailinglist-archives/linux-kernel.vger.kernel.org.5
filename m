Return-Path: <linux-kernel+bounces-88032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0686DC65
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC471C21F35
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EBC6995D;
	Fri,  1 Mar 2024 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ShwkDEph";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="U49UX0eZ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478AC69958
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279484; cv=fail; b=HI4qRho+QJp9MppsdGVzAtBn37OfIsqWPwkxcjKjGKYDfeh7CV48mjHu0lcDUMS7UrZ52BW8MLnoYLoFYpPf/RhIDqHU1TnDCznXVNGywOmnGL1Lm9awG8Rh0khsmnowTexjufFXNfacBp8jlClOm4goAJotdz300RDOTR2rxlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279484; c=relaxed/simple;
	bh=0R/UxT8j8Q64OC4MD+YH7Mv/e/vMIuKgz3LdhhXrOdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dbfwhh5aqmAUIjjrAQTqjUVwoWItL1sUQHS6y8dYA4Kq2xCmOrVeu39UuDszLKsEQh0Hxfjrph721PMS0KtAVgrkEnDIFzRoQzChHaSrlQrS23Tb6l4WY+rmMqkxgTtHdbmSrxKk7ktPxIGOhUlG2MFzOHJeeIW5Js0kFG/k3tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ShwkDEph; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=U49UX0eZ; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7b30b2c0d7a011eeb8927bc1f75efef4-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0R/UxT8j8Q64OC4MD+YH7Mv/e/vMIuKgz3LdhhXrOdM=;
	b=ShwkDEphkV6SH8lPF+sd1XvdLPdd1a2rLZeU06eGz11UE7Asmggh8IsZodT4HTq6LtUlEXJQMpjMIPkaBepE6iEUSzCxlJ/ywPqkpCewhu1bANMtmx8oKISUcs5jjiXZHjiwNDnQOdckFhipMbjMF738Ffs6DcmTRaVb14DiKHc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ae9bd675-66a8-495a-abec-2a0d4f29e09e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:08087e84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7b30b2c0d7a011eeb8927bc1f75efef4-20240301
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 937733496; Fri, 01 Mar 2024 15:51:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 15:51:14 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 15:51:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZz4rtFwLJ9h/MZy0Z+NPgfOaR+ZeZYk6WKGZUCqg2jRA70s4xsVK9r7S88DvXef4WC6UvXdE2yZz+eYrRMW4fn4VAEhtN+kzC0mWDD2Cl9/wrQ8sxzBj4OhoG950QoLLLDWJ7lnIkZjLZYzn4oDpCz6TzqQSan0EfOQz3KykH0/D3VKFbmIC7J0hCJHlLXoUBI4IlPniRl4F5o7Vg1g3f7t/4aBORKHpc77YaMa+MTZ+56+0r9Wnhc2iK1QP3zbFYt/HZ5AQ+4oUy3gqbQcZiN6wMxVmUFlNxI3FWPnrOP9VrF+6+AUh5n0LvlwWWffLvHmDes3XFmDNXd/hxkmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0R/UxT8j8Q64OC4MD+YH7Mv/e/vMIuKgz3LdhhXrOdM=;
 b=VY4cfuRNoq68tHQ4TjxBA84ATG5N3Hon8UCTPn08t3EorqwaaayzYmnb8tvQB/a7DDRi0taU8gcjVQSSEHpcmjGcSgetUf5R3kw2imwwFgBEtSQiLbU/qZ80TDBoH1cjqyI3Rl7zCmDC/wz89SrWnNCb+u0doM40PxIWOazory/x9eiArsvGQJ3L0d7hg02ZDCCVnzGhyx/sO9katgu4xewb8DNzUcNu0LwsmVhpJM5zlJ4NftEGe6SNiyW/WAg+0z6rgmiXcxXO1G6wVNxJJYhl775ewjC8gwL1ankjSOhdJAKVxezYp9ZrHyyG3MspiEjMMxyaTCUsXZmctRmsWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0R/UxT8j8Q64OC4MD+YH7Mv/e/vMIuKgz3LdhhXrOdM=;
 b=U49UX0eZwCE8trwDit7kB5ATQMu6jRsQDGkvd7GQN7/xyf/VJI+VfOI+LBBjuwAzGac64K0yoD8cXVCBUH99asmeaoI8imNOkIGCornlC4b8jLR52pnvPy5doBAumDzhMOQw/MQStACGiDGSK5+l+euMYN05SjiMA3iWxWcUaFQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI6PR03MB9236.apcprd03.prod.outlook.com (2603:1096:4:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 07:51:12 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 07:51:11 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "seanpaul@chromium.org" <seanpaul@chromium.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>
Subject: Re: [PATCH v5 06/13] drm/mediatek: Turn off the layers with zero
 width or height
Thread-Topic: [PATCH v5 06/13] drm/mediatek: Turn off the layers with zero
 width or height
Thread-Index: AQHaX/dYZgeAgBFvZESouybYjCpgWbEimoWA
Date: Fri, 1 Mar 2024 07:51:11 +0000
Message-ID: <dc7569baf040a0cf2ba9d176ea69e250dddfabdd.camel@mediatek.com>
References: <20240215101119.12629-1-shawn.sung@mediatek.com>
	 <20240215101119.12629-7-shawn.sung@mediatek.com>
In-Reply-To: <20240215101119.12629-7-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI6PR03MB9236:EE_
x-ms-office365-filtering-correlation-id: 9a9cf524-5500-4bc9-9ac1-08dc39c45d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4CbF0Df4cx5OSJmPF5Zz3HU76S+0jxnGPNfoR123nMLW4Oml6a+vUQOpM7wOpA6J0FtaSZ1/jkfCLvlzVH0mO9Lgb8jaFSgcAWeVeusXzli7F/B7MXo9CIJCX9MBm0sXP5yFd476mKlmkea0y5MiX0SSDsGQO/tBln2ttk7WelSusOoHpGnHgi8trnhr3XnD/4Spcuoreoi78nG4vJ9GMsNBOuZoccPcXdlA10EIPtR98TDWCwfZGbLwGaulg8DIIlo9B/mxqYd0PPGfzxNzv8xI3MmuoZLgDQ1r7RsZbKh4WLNn3vP7sSGNQHweTFgCrrp/nzC0o45kdrAjGqW+5hnBPDQnzUUsM1x4qAJbMr69XLeNkrhNkaHUioPCjmBVFtMQNCw+6i/0kKAc131X2csG+elnX4eVXUHZrfFKm6uzVGr9JI8Z97xSa6wIEUkn85ZuJwf/XcTmjJn9IE2KkowlfwuOslXYwTryTox8vGrSdxrF+vquSzQLjt5UUrAY3ZZh2kV/+5P92buzszw+Eececk0mQBEPDK7owbXmmr4LgW7gxSYNBDB/Kke1UnhqPEiYslRnha1dkQyCp5vJ9zdid6qYnts6GweOITaVUJmMMIfSDf5QLi06le9X1mN0EdCcM2+F/Z2972qsoggy1rj+ae3JRdiDPGvsbtrsTOb3qSz9hYNAHZvdzR8eOoYOc/XyQsxguK00jxJxqsuFow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDVGb3B6bElOWDJrdUJDTXZaKzJhM24wcW1iNkNKQkNmdXh5bXhob0V5MlJR?=
 =?utf-8?B?NXV0c3doZjJxR1EySVdBRXJtU0FPSDlOL2UvZTZQUzk4ME1qck9jejFrbzJl?=
 =?utf-8?B?cW1TSXdQeG5VU0tNQkUxZy95aUpGY0YwMkJwc2ZWQThtYXlnbFJMZGFaMnNT?=
 =?utf-8?B?RzMvZDF2SGZ0RzFoTU1pbmRLZ3Vwc2REMnlpdmRjSEtLejlOYm9BVklJTlFx?=
 =?utf-8?B?bUxlV2lhby9DenVTdFJlVTZvZHkwUWllTjFTeXRiYng1L05IbUZWMDVteDRn?=
 =?utf-8?B?R1d2eUY5cUE4SzZTU0ZMa2JmdFNkMUZINGxaQzhhcFBQK1U4bGdYcDRPcGgx?=
 =?utf-8?B?T0t1OGgreVRpRUVuM084QXNsSEt2UFlaalNFUlRBRXpENy9ENE5NNlQxbHRS?=
 =?utf-8?B?cS9BdWlON3cxZGQrelVHb1BOT1hBTUN4UlZHSmlubTNMSDl3QlVqUmJtVTha?=
 =?utf-8?B?ZXJtL0ZFdjROK0QwZGRIV1VJMXVLVHpBZUFkazNTSUc0TWQ4WHdkM3cyOE5F?=
 =?utf-8?B?Sy9wcUNUUHZaVVpLaG5oV0poUEVOTHRRZDV5MGRBdWxubndMbVFqeEZCUDlX?=
 =?utf-8?B?aXRCTVAvV3I3akp6amxhbUVIR0ZSUjNBZFhWRENDM2xQMUJIVGtBY3V4eTNs?=
 =?utf-8?B?Vlc0QzVLQmNUM0gyWTVMdlJWczk5L3VUN3AzR0NES3V1bHVJTi83dVhZdnRh?=
 =?utf-8?B?LzVUZWdNSG5xbVVDakdRZFowNWlPdm4yUE8vamFDRHI1ZjBEaU54K294Wkhj?=
 =?utf-8?B?bHpaQXI1Tkk0Z2F0TjRvcXRWQXIwTldDQ2pJZHBRa1BnWmNBcEFBL1NCWGdy?=
 =?utf-8?B?MkxwajkvUUp0akZVUjYyYzIvTDVPbVpIZUVibmFNQjQ1UmQ0RE9wWFJpVity?=
 =?utf-8?B?bzNXd2dmcjZnR1pCNHFndllycnpoNTUzcHhUajNCTzlZQnlJMnZVUmdseGxr?=
 =?utf-8?B?SU9zdWFvb2NzQWkyV2RTRGRTQlNoYUtEU2p1NDhkTkxEcXZ4N1hINEswVS9Y?=
 =?utf-8?B?MWRQRHBVeXhNTzZzUU1RcURCR1lZNXQrOFViQzlLL1lVRE1UZGtwWDBRRlpJ?=
 =?utf-8?B?Ky9jblYxWlBNRUJjaTlwejBVRDI1RktLQVAwQWNmODU5cmwxcXpVUmlscEFX?=
 =?utf-8?B?N1dyZE1GdkwrcDRNMFlzcnJUcm1pSnJqTzFlSkx6dlpiVFV2alhoSW5lVmdv?=
 =?utf-8?B?UXBxbjVjME5ickNYOWxrZ1VzWFNtWUs0L0hTVWY2MUNHc2NqYVM5WHVOR0Zo?=
 =?utf-8?B?S2M2NE81S25DSWxkQWRWRzdNMzNFMk9GRjl5TjJzc0lWTzU3S2tlOElzMEYw?=
 =?utf-8?B?RWduaGNEWkh6OExxMVNSUWVtUG14azVhN0J0b2I4TlFHMXE4aDFSRVZSdk9v?=
 =?utf-8?B?RE9WMHY3bmF6ZElvWmdtWDlpbUs0L01YSzFhdloyWnp4Yzkxb2tIZ2NNVWlw?=
 =?utf-8?B?SWhsSURPSDFqaWd2b0hkSE5lcWdpRE5yU2p2cWdmN200SWsySmN2VlpiTFBM?=
 =?utf-8?B?WTdMRnZlVXk5elZweENsVStkWjUvaSthUGN6Sk5ueEIzVWFTakR3Kys0d096?=
 =?utf-8?B?YmR5THdjTlFZZTRXaC9vZXB4MFdTYk5OUmc0bVJSMWRaQ3pqWDJ5VDZRTUZa?=
 =?utf-8?B?VUFjL0hQQ1EyQ0Vzc3NWYlgwNGRqbVVhb29neWFLZ0c2cmY3Q2NHUjA0L0c0?=
 =?utf-8?B?MDlaM1VvdGJUb3lCYUpKQ2M5V29WYXNoZ2FkUHJpQkYwS3BtdzBUTXlBQjBl?=
 =?utf-8?B?KzZ6Q2JwdnhNQWpocTk0T2tqUmtuMjdLY0svMlB3N1RYVG8vMWp4UXVGbkpm?=
 =?utf-8?B?dnJyZ0creDJpY0d1ZUkrb1JTT0hsYXJERlM4MngwcG5vL2VHWGJMVkViMmRw?=
 =?utf-8?B?VkFlUDZWTTZQUXM5N3U5MWRhWFM4T0kwb2phdU5OZFd1TFRycXNGVWl6aEV1?=
 =?utf-8?B?bFo1dVMzcXBUN0ZueStucUJlZnRTd05tKy9KVFIxbHVSYkx6WUgwd0NhNytN?=
 =?utf-8?B?YWdQMThkL1RVcDBncThMM2pNdTNlMENwYTJ2dmhLWVBCc3BHc3hTMWsyVVZj?=
 =?utf-8?B?c2tWYml4ZURqcjlSb1MzWW0yR1haeENlRmlhajR3Zk80bURBRWloTmpIQ2JR?=
 =?utf-8?Q?wrbK6qwyMpV+O9+rMeAxH8maH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0162D233976694E83EB794F1F3392D6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9cf524-5500-4bc9-9ac1-08dc39c45d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 07:51:11.8585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1ws57hJmEvTsr36qaGbR5IxtusovyF6XRi+raGiYBYMQdALydyQYoy8Ordzmw/d67FOmAwYjO79QZ+W4F4ZnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB9236
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.690800-8.000000
X-TMASE-MatchedRID: scwq2vQP8OE/XHdICuW5rya1MaKuob8PofZV/2Xa0cKOUV82NDH4AlU1
	mKBqgGzKxLXSu8yTUJprDRXfw8gpTTajbKvQDWp/Y1bQMCMvmn64vBuE2X0HleQIoW+okd7JASS
	25Kb4JAKMZBHIGOaSwOKOmN63egZIbn83JMqUbr2HZXNSWjgdU5KLNrbpy/A0FLXUWU5hGiFHdE
	c8dOyw1fWjlKSodAPqPdHjjly2GDoM8jMXjBF+sNIFVVzYGjNKWQy9YC5qGvz6APa9i04WGCq2r
	l3dzGQ1ssOcArzi9zmr7rxEWL5Lz96zW3K1Ch3efXvBVamN/zgaB75N/QjOchb+U31CofkCL06m
	Urak0UaSPRYAfWdVjFFKsN+E2SHGVRHgklYfjug9XGVRM/cag7sCWxFv9DtZChiU+c//xP8WW1i
	V/cL+I0MMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.690800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	2775F6B6D88A3E1E849EBA7B9AE12FA4D9AC59D19B2B9BB3E8862533EFA3DC422000:8

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUaHUsIDIwMjQtMDItMTUgYXQgMTg6MTEgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFdlIGZvdW5kIHRoYXQgSUdUIChJbnRlbCBHUFUgVG9v
bCkgd2lsbCB0cnkgdG8gY29tbWl0IGxheWVycyB3aXRoDQo+IHplcm8gd2lkdGggb3IgaGVpZ2h0
IGFuZCBsZWFkIHRvIHVuZGVmaW5lZCBiZWhhdmlvcnMgaW4gaGFyZHdhcmUuDQo+IERpc2FibGUg
dGhlIGxheWVycyBpbiBzdWNoIGEgc2l0dWF0aW9uLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNr
Lmh1QG1lZGlhdGVrLmNvbT4NCg0KSSBoYXZlIHJldmlld2VkIG92bCBkcml2ZXIsIG92bCBkb2Vz
IG5vdCBoYXZlIHRoaXMgbGltaXRhdGlvbiwgc28gaXQncw0KYmV0dGVyIHRvIHBvaW50IG91dCB3
aGljaCBoYXJkd2FyZSBoYXMgdGhpcyBsaW1pdGF0aW9uLiBUaGF0J3MgT0sgaWYNCnlvdSBoYXZl
IG5vIGluZm9ybWF0aW9uLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gRml4ZXM6IDc3N2I3YmM4
NmEwYTMgKCJkcm0vbWVkaWF0ZWs6IEFkZCBvdmxfYWRhcHRvciBzdXBwb3J0IGZvcg0KPiBNVDgx
OTUiKQ0KPiBGaXhlczogZmE5N2ZlNzFmNmY5MyAoImRybS9tZWRpYXRlazogQWRkIEVUSERSIHN1
cHBvcnQgZm9yIE1UODE5NSIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5n
IDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyB8IDIgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZXRoZHIuYyAgICAgICAgICAgIHwgNyArKysrKystDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IGluZGV4IGQ0
YTEzYTE0MDIxNDguLjY4YTIwMzEyYWM2ZjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IEBAIC0xNTcsNyArMTU3LDcgQEAg
dm9pZCBtdGtfb3ZsX2FkYXB0b3JfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UNCj4gKmRldiwg
dW5zaWduZWQgaW50IGlkeCwNCj4gIAltZXJnZSA9IG92bF9hZGFwdG9yLT5vdmxfYWRhcHRvcl9j
b21wW09WTF9BREFQVE9SX01FUkdFMCArDQo+IGlkeF07DQo+ICAJZXRoZHIgPSBvdmxfYWRhcHRv
ci0+b3ZsX2FkYXB0b3JfY29tcFtPVkxfQURBUFRPUl9FVEhEUjBdOw0KPiAgDQo+IC0JaWYgKCFw
ZW5kaW5nLT5lbmFibGUpIHsNCj4gKwlpZiAoIXBlbmRpbmctPmVuYWJsZSB8fCAhcGVuZGluZy0+
d2lkdGggfHwgIXBlbmRpbmctPmhlaWdodCkgew0KPiAgCQltdGtfbWVyZ2Vfc3RvcF9jbWRxKG1l
cmdlLCBjbWRxX3BrdCk7DQo+ICAJCW10a19tZHBfcmRtYV9zdG9wKHJkbWFfbCwgY21kcV9wa3Qp
Ow0KPiAgCQltdGtfbWRwX3JkbWFfc3RvcChyZG1hX3IsIGNtZHFfcGt0KTsNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0KPiBpbmRleCA3M2RjNGRhM2JhM2JkLi42OTg3MmI3
NzkyMmViIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRy
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+IEBAIC0x
NjAsNyArMTYwLDEyIEBAIHZvaWQgbXRrX2V0aGRyX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+IHVuc2lnbmVkIGludCBpZHgsDQo+ICAJaWYgKGlkeCA+PSA0KQ0KPiAgCQlyZXR1
cm47DQo+ICANCj4gLQlpZiAoIXBlbmRpbmctPmVuYWJsZSkgew0KPiArCWlmICghcGVuZGluZy0+
ZW5hYmxlIHx8ICFwZW5kaW5nLT53aWR0aCB8fCAhcGVuZGluZy0+aGVpZ2h0KSB7DQo+ICsJCS8q
DQo+ICsJCSAqIGluc3RlYWQgb2YgZGlzYWJsaW5nIGxheWVyIHdpdGggTUlYX1NSQ19DT04gZGly
ZWN0bHkNCj4gKwkJICogc2V0IHRoZSBzaXplIHRvIDAgdG8gYXZvaWQgc2NyZWVuIHNoaWZ0IGR1
ZSB0byBtaXhlcg0KPiArCQkgKiBtb2RlIHN3aXRjaCAoaGFyZHdhcmUgYmVoYXZpb3IpDQo+ICsJ
CSAqLw0KPiAgCQltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCAwLCAmbWl4ZXItPmNtZHFfYmFzZSwg
bWl4ZXItDQo+ID5yZWdzLCBNSVhfTF9TUkNfU0laRShpZHgpKTsNCj4gIAkJcmV0dXJuOw0KPiAg
CX0NCg==

