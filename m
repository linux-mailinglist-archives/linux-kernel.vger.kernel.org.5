Return-Path: <linux-kernel+bounces-72649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC0A85B6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A3B1C23CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDFF5F542;
	Tue, 20 Feb 2024 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hv6BVufJ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ggdJ+Zcn"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B3E60DC2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419987; cv=fail; b=ph9QxDt48p/4vhM2+w7uzZZRkAXs3wQUzWxZYi211K8rhPFWCrV+81wuds/9+EhjAcMInlhg0JpgOFUJwtvC/ZLtU7n9iEWS9O76tc4bejX3Z54dUj7qhi6P/TmvZEr9TgLBfJTVdAfC0rT3NBvuV5Fa9+P0KGAywa4UNLRXRHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419987; c=relaxed/simple;
	bh=hxqne2YxIPMHKHdav8UIDdX4zWx1ORLQ7yiedgLeI6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rTopmQ0itTJcp3s5HO58NMB/JZ44NZmYZAVvnD7edvd5pyLpZ0xuuVbP2PNTOyKTBXv0lylkA7CsMBrPqUh/edDw73rL/LgSWo6fU8RZbyGbWRU0E6kZ2u0pz3ztBUxDAWl9zhyEmBas9VDIESuU3cxFk64SvLnyN8ou6ZU4t2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hv6BVufJ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ggdJ+Zcn; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4bb45e44cfcf11eea2298b7352fd921d-20240220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hxqne2YxIPMHKHdav8UIDdX4zWx1ORLQ7yiedgLeI6c=;
	b=hv6BVufJGNvHCrPtNSxNCz4xPefbxEIwsar4uj+i735TnYELMYo/meIiWv0yslSw36lH4UXkxxkg54SiCVeHF6by7yHMzIEntN18OvaXHZyw/j7/Vb8gPvvWsTjs09uCB9eeopZ0zvI4HVit6N4msC3ozAhVnbjCmKUgPj0okCA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3a7b7880-7749-4b96-9757-5a50f83bc4b0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:9d281984-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4bb45e44cfcf11eea2298b7352fd921d-20240220
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 337137840; Tue, 20 Feb 2024 17:06:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Feb 2024 17:06:11 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Feb 2024 17:06:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3kImmG9+u0QFvRhkTa89wbnJK9WCpKHePTPKybI+iuRt+cVD/tE7yqx/N1HPncgin6q9hRhfRagWx+rpkyvIHYxM6s7WfpSPplmHkOjx0bGeaV2I0q5bwc+DdUAXOvmSH8EcNM92Ug9prxcTrC9IUlPGGZNhJFPxjELhGW18z9CKIqjyptd0djZ/Ulon1AeVXlqewZLl62zD4qSlkMg8SKai2fw4Q2I48THDQCC0phn2hgpZxL3jIxjoh3FMe42Z4Nbs5VvwthsidfOyuOaDY2LrdYtgfUdJt6sjSE9wOGtJMCD4HpU4HAaqHchfuOU1U+vuXpeqM9b7qwzbl4p1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxqne2YxIPMHKHdav8UIDdX4zWx1ORLQ7yiedgLeI6c=;
 b=Dro34M0xY9qQpXKMX6Hr3AhHE5EBYz+VpdzlzQQrcbecPoPYgMHHD935KGbrHISGp5OqAd13BgzY4ayrfDY4lcckV0fKqZVzEBgw2RmlGSwcsC32Gn3ogp6KeAcZt7rjYyMUMlRyjT4gKrdeciFELRy4HF5jk3VolcwkR2/MVTRrgOKXiIKHogvqysTVdpgxxYBlxML/K3oRCGkos+KLFIGwlc3yBz5wmWQxzN+eAs+fzb/ZvBHIoe9aTaiAGuatp+i6BEKEO5UVOP3mWjI9EtwUpW8ZvisNC+MfFX1OgkyJHyOagkdcp6eYXzx1iVYepFgE96tBHZORGiNNpM/SYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxqne2YxIPMHKHdav8UIDdX4zWx1ORLQ7yiedgLeI6c=;
 b=ggdJ+ZcnCCp2NJQQiajX0GYIVeMXxUs4+SgaUDY5h3SJg6czt3+lFonox1dZhg7fn8V4R+gJaUD2ydPKXDsIly388hbeQFT6r07N3GuPONqXSXlv7R2RRgZUn53jjqoDtI9bQFIHCKXYjWzuH0k4h6JreCFs8WXVbAPPf5i7wGM=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SEYPR03MB7048.apcprd03.prod.outlook.com (2603:1096:101:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 09:06:09 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b%6]) with mapi id 15.20.7292.026; Tue, 20 Feb 2024
 09:06:09 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "shawn.sung@mediatek.corp-partner.google.com"
	<shawn.sung@mediatek.corp-partner.google.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "airlied@gmail.com"
	<airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/1] drm/mediatek: Filter modes according to hardware
 capability
Thread-Topic: [PATCH v2 1/1] drm/mediatek: Filter modes according to hardware
 capability
Thread-Index: AQHaWWuNektmgAnup0aSMByZf9QVLrEMxQmAgAZANAA=
Date: Tue, 20 Feb 2024 09:06:08 +0000
Message-ID: <2025e0ddff85a3bfa1f8894587b5e26ba3cfd65b.camel@mediatek.com>
References: <20240207021510.24035-1-shawn.sung@mediatek.com>
	 <20240207021510.24035-2-shawn.sung@mediatek.com>
	 <d8bb9f158e03c41d2278545e1a5ef657943f7be4.camel@mediatek.com>
In-Reply-To: <d8bb9f158e03c41d2278545e1a5ef657943f7be4.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SEYPR03MB7048:EE_
x-ms-office365-filtering-correlation-id: 222c2551-2f75-4a62-f026-08dc31f32d86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +x3M1XFpnDf3u1oGtFHxIXCuOUY4X3esHITCv8WFmCdWIGq3ZBNrp83UF8xINAk6q/M5zFX3dmvcr6TEKkhkdTSnK1lfIkczHpy/Kop+4ywyUALlpHK56lUWrCFHReZlxfgG1tMQm//j1D/q+I5CG/H1hsgLe+MGbrW8fDkMf/V+znP1e/sLz6I7X6cKkn3YubAI7jpDY3gRch4HU8JAtGzV1LDyNFIu0ygveQ+37q/Z7dxROMv9TGbF4jleegCyoerZvrPqdQDAXuuIJL0V2mkQPvg9yftCLR6YgETFE2ORsktvy/5BNk4EGol+YhFATdHzdQbt2oI2mXmRMU73BJvOMQXZ37bknACidzNxKpiqYaI1d5SPb/wRUl8kuQ6xc4GGV3o3JAxS/SIY6a/gijwSNiVYc4zornbzvys0lBpbUx3hdczeUyrZhOz/SffROV+V1f7q4/nvghtoIScrDJeTKQotzlqtELlgWRmRVTbWAtLUKTow7KBY1Tel+NBWxkqWd7qc44n0B2VmHAww3LgrI17qo9sFvEF1F/MkwgowJzrF7IcSzOWPhQrH1OQyTJi45RqPBMCvvdBBAJwFwU5O1nLXw+4fldE7TyWBs/OU0dcpTLQSXYKKGficC3tD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qi9pU3Jra1pVVmUzZDd0ZE82WFJpVXZFSmo0NjBlemszbGtzQnAySHByWkRs?=
 =?utf-8?B?b3gzZ3FBMEh6eGFYd3pSMW5pc3pTQmRnNmsvVy9jeU9XbldPOUxaVlZzamd1?=
 =?utf-8?B?RUhnZ3VaMXJtOExxdHRkL3RDQlFHVEpnaFlBRHpRK0UzUnc1cFIxYUJnWkhG?=
 =?utf-8?B?TGtGelNVWXUwUTA5Vk1vTC9kTXlKK1FZOWVZekxrOUpaNjkzazdORzZwZ1Bi?=
 =?utf-8?B?WFQ1NmprK1YvMExpU1E5S3NyZVBYejZ2T2hSdjZlUU9JM09kcjJDbW5qQWRN?=
 =?utf-8?B?d1drcWdNOFZnVzMzRUtoUGxXOE9Cc3RXcTNpbU1WZEY4SzJlaXdqZGxPUDhi?=
 =?utf-8?B?elM4aHkzbXdYbmxHOWVUTE1WMzBKSWZzdlJhVXRucUNCV2hYQlZtUCtORHBZ?=
 =?utf-8?B?TEJ1T1FnbDhqMERmTWYyYWV0MHRrOWg1QnFiaDNNQWtYenhlSGVnUHNFdTlJ?=
 =?utf-8?B?NnBPc25XSE5mOU5QdkdodTJZMTJmMFBVRFcwUm1CWVVRUnRFUmhCZGl0aURI?=
 =?utf-8?B?REZMSkdWMFFxTHdaZ2RGYzV6c1ZMVzczMi9pRGdvTFVCbTMva2U5dTc0VU1Z?=
 =?utf-8?B?K2F3UGlYYWhUZFp1QVJQcHJ4QjJSUVV0TUN3clpGZlhYU3Y5U1N6OTVLdTRI?=
 =?utf-8?B?cVYwOGxubVo3b3k1RjI5dzVac3J4cDk2ZXV6TUYySVVHZEpxUmU2SmhSd2hh?=
 =?utf-8?B?bklXVTNHRFgwMUUyL1d3MTVCZGdwZDlvbFJlcnMvVEMyQVB1N3U2L3hnY25w?=
 =?utf-8?B?VEJBelRKYk5Xa0JzazJvRTQ0bEVob0VTYTJYd3dkb1kvNVZac3AvemxuVmV3?=
 =?utf-8?B?MjI4TFJXanB1UnV2SUdsbXk3amlyUW1IYXMvOE4wYTluUUN5cGx6czI5NzJR?=
 =?utf-8?B?Z3ZDVnN6UmZtM3hsenBnQ0FjeWNacld1cHZlRVBsOHkxL2d1OGZPaTUvUUpl?=
 =?utf-8?B?WXl6Znp0d0RpSzdTZkJUMVo2L3pzTEhPdkE1RWVHOXNGNVZINmc1d25McjhH?=
 =?utf-8?B?WEF2RnFTRmNkRU9RUnlIUlEwRlJCdUJ4Mnd2dm54dURhZGZMeXZIQ3c1b1Jj?=
 =?utf-8?B?YzJxR3Rwd3hXdGgwYllnQWNMaWhtdUo1VHI4b08yTUlJeTluaVlQQ0lhQTNp?=
 =?utf-8?B?RjJiR0hsczg1L3VHQlljYk94R1l6OU5VUUhCMW9GQ2s4YzVDK0JlVmFMMTM4?=
 =?utf-8?B?TEdCZGRWbUFxaWxJYjhrcFlXd2svNDZ1Q1F6K0lGb2pyWEJkc3o5NU1Fbno2?=
 =?utf-8?B?dG45K0N3QUZrN1M4QUl6dkpKRmZ0MWsvbmVPczV5bzBocXUva0JxTm5Qak9J?=
 =?utf-8?B?eHJSR2NURmZCQ3dvMVZuVDZ0a1hLc2NseHB6QkhlcU5BeExySndKVEFPQ3N2?=
 =?utf-8?B?ZHZTNzVLVlZJVEZGejlramZEUkNjWlVRSjBZTE53dktUeVZNSFpkZjM4NG9w?=
 =?utf-8?B?VEZQNXpLK2F1VTE2VEt4N1IzVndnTkNBOExiNlo2NG1CdkpSa1BmbkQ1Njdh?=
 =?utf-8?B?ZDlrOGNTdTZnZk9LS3laNkFXa0w0ZnVRMU9rQ0FYckNnWVdtL2hNNEwzZkxz?=
 =?utf-8?B?ckdSRHpwSUdyVCtjQWlPZFU1ZDViNzlYakNJZHlNU0oweWJVK3B6d0VXMXVV?=
 =?utf-8?B?cVFpc05yUGNLSDI1R2JoZG1FRGNERnVPRjgwSCtzM25nYnJ6azVjS3ZvSHor?=
 =?utf-8?B?SDJMYkcwU0JkUEN2NDhlR1JBUXcrSElWMDBVeE12SWRTUDJ1MHRuQU0wazhu?=
 =?utf-8?B?RG5VeW9VLzRhWWFhL0QxTVRObVh5RnlZVVBZMEd0ZUx6dHVHRXFpVTJEY3lI?=
 =?utf-8?B?VDlPY0tMVzdpQ2xNMHZaZThxRzZUTTVncGZqSUo1dmJnZ2VxVlpYWHBCOGMr?=
 =?utf-8?B?ZHJwZURrQzRPeXNxUEJiNVVHaDZRcndPMGI3dlJxY0g5ekREckNaMDlSNVo5?=
 =?utf-8?B?eWpTWnZGMjB1UHZZMjJEU2NHdnROL3NLUEIvZ0RsZGZPejI0YzhMYVRzQUs5?=
 =?utf-8?B?TTNveHZDbUIxU25zbXY2Tk5kaFF6c2FZSDlsc1NZWUxyZFZmaFlHeWlyWCtX?=
 =?utf-8?B?R0hGeWN4ZThWdG54dXUzWHJ0TWlYaUk3YUVnMTgxYm1lbnNpMTduaWNLY3Vn?=
 =?utf-8?B?SExXalM2SDhzWjF5NmtPeGJoNVIza2N6TDE2WUtXaDlOcFBselowVkdkMUVH?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1941DC68D9FBD948A54F5EB851AA89E9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222c2551-2f75-4a62-f026-08dc31f32d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 09:06:08.9943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOGK6B/G0vK8TOoz7Zs8i+FQsDOtxpn+xVhtAqD/IidZQqPbVSD5P16fttdQBIvMHwsVxqbPdqKOnCgbrXTt0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7048

SGkgQ0ssDQoNCk9uIEZyaSwgMjAyNC0wMi0xNiBhdCAwOTozOCArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBIc2lhby1jaGllbjoNCj4gDQo+IE9uIFdlZCwgMjAyNC0wMi0w
NyBhdCAxMDoxNSArMDgwMCwgSHNpYW8gQ2hpZW4gU3VuZyB3cm90ZToNCj4gPiBGcm9tOiBIc2lh
byBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvcnAtcGFydG5lci5nb29nbGUuY29t
DQo+ID4gPg0KPiA+IA0KPiA+IFdlIGZvdW5kIGEgc3RhYmlsaXR5IGlzc3VlIG9uIE1UODE4OCB3
aGVuIGNvbm5lY3RpbmcgYW4gZXh0ZXJuYWwNCj4gPiBtb25pdG9yDQo+ID4gaW4gMjU2MHgxNDQw
QDE0NEh6IG1vZGUuIENoZWNrZWQgd2l0aCB0aGUgZGVzaWduZXIsIHRoZXJlIGlzIGENCj4gPiBm
dW5jdGlvbg0KPiA+IGNhbGxlZCAicHJlZmV0Y2giIHdoaWNoIGlzIHdvcmtpbmcgZHVyaW5nIFZC
UCAodHJpZ2dlcmVkIGJ5IFZTWU5DKS4NCj4gPiBJZiB0aGUgZHVyYXRpb24gb2YgVkJQIGlzIHRv
byBzaG9ydCwgdGhlIHRocm91Z2hwdXQgcmVxdWlyZW1lbnQNCj4gPiBjb3VsZA0KPiA+IGluY3Jl
YXNlIG1vcmUgdGhhbiAzIHRpbWVzIGFuZCBsZWFkIHRvIHN0YWJpbGl0eSBpc3N1ZXMuDQo+ID4g
DQo+ID4gVGhlIG1vZGUgc2V0dGluZ3MgdGhhdCBWRE9TWVMgc3VwcG9ydHMgYXJlIG1haW5seSBh
ZmZlY3RlZCBieSBjbG9jaw0KPiA+IHJhdGUgYW5kIHRocm91Z2hwdXQsIGRpc3BsYXkgZHJpdmVy
IHNob3VsZCBmaWx0ZXIgdGhlc2Ugc2V0dGluZ3MNCj4gPiBhY2NvcmRpbmcgdG8gdGhlIFNvQydz
IGxpbWl0YXRpb24gdG8gYXZvaWQgdW5zdGFibGUgY29uZGl0aW9ucy4NCj4gPiANCj4gPiBTaW5j
ZSBjdXJyZW50bHkgdGhlIG1vZGUgZmlsdGVyIGlzIG9ubHkgYXZhaWxhYmxlIG9uIE1UODE5NSBh
bmQNCj4gPiBNVDgxODgNCj4gPiBhbmQgdGhleSBzaGFyZSB0aGUgc2FtZSBjb21wYXRpYmxlIG5h
bWUsIHRoZSByZWZlcmVuY2UgbnVtYmVyDQo+ID4gKDgyNTApDQo+ID4gaXMgaGFyZCBjb2RlZCBp
bnN0ZWFkIG9mIGluIHRoZSBkcml2ZXIgZGF0YS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBI
c2lhbyBDaGllbiBTdW5nIDwNCj4gPiBzaGF3bi5zdW5nQG1lZGlhdGVrLmNvcnAtcGFydG5lci5n
b29nbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfZHJ2LmggICAgICAgfCAgNCArKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfbWVyZ2UuYyAgICAgfCA1Ng0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgLi4u
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyAgIHwgMTcgKysrKysrDQo+
ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgICAgICB8IDE3ICsr
KysrKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jICAg
fCAgMSArDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgg
ICB8IDEyICsrKysNCj4gPiAgNiBmaWxlcyBjaGFuZ2VkLCAxMDcgaW5zZXJ0aW9ucygrKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2
LmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiA+IGlu
ZGV4IGViNzM4ZjE0ZjA5ZTMuLjRhNTY2MTMzNGZiMWEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gQEAgLTcyLDYgKzcyLDggQEAgdm9pZCBt
dGtfbWVyZ2VfYWR2YW5jZV9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+IHVuc2lnbmVk
IGludCBsX3csIHVuc2lnbmVkIGludA0KPiA+ICAJCQkgICAgICBzdHJ1Y3QgY21kcV9wa3QgKmNt
ZHFfcGt0KTsNCj4gPiAgdm9pZCBtdGtfbWVyZ2Vfc3RhcnRfY21kcShzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCBjbWRxX3BrdA0KPiA+ICpjbWRxX3BrdCk7DQo+ID4gIHZvaWQgbXRrX21lcmdl
X3N0b3BfY21kcShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBjbWRxX3BrdA0KPiA+ICpjbWRx
X3BrdCk7DQo+ID4gK2VudW0gZHJtX21vZGVfc3RhdHVzIG10a19tZXJnZV9tb2RlX3ZhbGlkKHN0
cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArCQkJCQkgIGNvbnN0IHN0cnVjdCBkcm1fZGlzcGxheV9t
b2RlDQo+ID4gKm1vZGUpOw0KPiA+ICANCj4gPiAgdm9pZCBtdGtfb3ZsX2JnY2xyX2luX29uKHN0
cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gIHZvaWQgbXRrX292bF9iZ2Nscl9pbl9vZmYoc3RydWN0
IGRldmljZSAqZGV2KTsNCj4gPiBAQCAtMTMwLDYgKzEzMiw4IEBAIHVuc2lnbmVkIGludCBtdGtf
b3ZsX2FkYXB0b3JfbGF5ZXJfbnIoc3RydWN0DQo+ID4gZGV2aWNlICpkZXYpOw0KPiA+ICBzdHJ1
Y3QgZGV2aWNlICptdGtfb3ZsX2FkYXB0b3JfZG1hX2Rldl9nZXQoc3RydWN0IGRldmljZSAqZGV2
KTsNCj4gPiAgY29uc3QgdTMyICptdGtfb3ZsX2FkYXB0b3JfZ2V0X2Zvcm1hdHMoc3RydWN0IGRl
dmljZSAqZGV2KTsNCj4gPiAgc2l6ZV90IG10a19vdmxfYWRhcHRvcl9nZXRfbnVtX2Zvcm1hdHMo
c3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiArZW51bSBkcm1fbW9kZV9zdGF0dXMgbXRrX292bF9h
ZGFwdG9yX21vZGVfdmFsaWQoc3RydWN0IGRldmljZQ0KPiA+ICpkZXYsDQo+ID4gKwkJCQkJCWNv
bnN0IHN0cnVjdA0KPiA+IGRybV9kaXNwbGF5X21vZGUgKm1vZGUpOw0KPiA+ICANCj4gPiAgdm9p
ZCBtdGtfcmRtYV9ieXBhc3Nfc2hhZG93KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gIGludCBt
dGtfcmRtYV9jbGtfZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9tZXJnZS5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfbWVyZ2UuYw0KPiA+IGluZGV4IGMxOWZiMTgzNjAz
NGQuLjZiMDY1ZWUyNTQ0NTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX21lcmdlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfbWVyZ2UuYw0KPiA+IEBAIC0yMjMsNiArMjIzLDYyIEBAIHZvaWQgbXRrX21lcmdl
X2Nsa19kaXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCWNsa19kaXNhYmxlX3VucHJl
cGFyZShwcml2LT5jbGspOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICtlbnVtIGRybV9tb2RlX3N0YXR1
cyBtdGtfbWVyZ2VfbW9kZV92YWxpZChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gKwkJCQkJICBj
b25zdCBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZQ0KPiA+ICptb2RlKQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3QgbXRrX2Rpc3BfbWVyZ2UgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiAr
CXVuc2lnbmVkIGxvbmcgcmF0ZSA9IDA7DQo+ID4gKw0KPiA+ICsJcmF0ZSA9IGNsa19nZXRfcmF0
ZShwcml2LT5jbGspOw0KPiA+ICsNCj4gPiArCS8qIENvbnZlcnQgdG8gS0h6IGFuZCByb3VuZCB0
aGUgbnVtYmVyICovDQo+ID4gKwlyYXRlID0gKHJhdGUgKyA1MDApIC8gMTAwMDsNCj4gPiArDQo+
ID4gKwlpZiAocmF0ZSAmJiBtb2RlLT5jbG9jayA+IHJhdGUpIHsNCj4gPiArCQlkZXZfZGJnKGRl
diwgImludmFsaWQgY2xvY2s6ICVkICg+JWx1KVxuIiwgbW9kZS0NCj4gPiA+Y2xvY2ssIA0KPiA+
IHJhdGUpOw0KPiA+ICsJCXJldHVybiBNT0RFX0NMT0NLX0hJR0g7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJLyoNCj4gPiArCSAqIE1lYXN1cmUgdGhlIGJhbmR3aWR0aCByZXF1aXJlbWVudCBvZiBo
YXJkd2FyZSBwcmVmZXRjaCAocGVyDQo+ID4gZnJhbWUpDQo+ID4gKwkgKg0KPiA+ICsJICogbGV0
IE4gPSBwcmVmZXRjaCBidWZmZXIgc2l6ZSBpbiBsaW5lcw0KPiA+ICsJICogICAgICAgICAoZXgu
IE49MywgdGhlbiBwcmVmZXRjaCBidWZmZXIgc2l6ZSA9IDMgbGluZXMpDQo+ID4gKwkgKg0KPiA+
ICsJICogcHJlZmV0Y2ggc2l6ZSA9IGh0b3RhbCAqIE4gKHBpeGVscykNCj4gPiArCSAqIHRpbWUg
cGVyIGxpbmUgPSAxIC8gZnBzIC8gdnRvdGFsIChzZWNvbmRzKQ0KPiA+ICsJICogZHVyYXRpb24g
ICAgICA9IHZicCAqIHRpbWUgcGVyIGxpbmUNCj4gPiArCSAqICAgICAgICAgICAgICAgPSB2YnAg
LyBmcHMgLyB2dG90YWwNCj4gPiArCSAqDQo+ID4gKwkgKiBkYXRhIHJhdGUgPSBwcmVmZXRjaCBz
aXplIC8gZHVyYXRpb24NCj4gPiArCSAqICAgICAgICAgICA9IGh0b3RhbCAqIE4gLyAodmJwIC8g
ZnBzIC8gdnRvdGFsKQ0KPiA+ICsJICogICAgICAgICAgID0gaHRvdGFsICogdnRvdGFsICogZnBz
ICogTiAvIHZicA0KPiA+ICsJICogICAgICAgICAgID0gY2xrICogTiAvIHZicCAocGl4ZWxzIHBl
ciBzZWNvbmQpDQo+ID4gKwkgKg0KPiA+ICsJICogU2F5IDRLNjAgKENBRS04NjEpIGlzIHRoZSBt
YXhpbXVtIG1vZGUgc3VwcG9ydGVkIGJ5IHRoZSBTb0MNCj4gPiArCSAqIGRhdGEgcmF0ZSA9IDU5
NDAwMEsgKiBOIC8gNzIgPSA4MjUwIChzdGFuZGFyZCkNCj4gPiArCSAqIChyZW1vdmUgSypOIGJl
Y2F1c2Ugb2YgdGhlIHNhbWUgdW5pdCkNCj4gDQo+IElzIE4gY29uc3RhbnQ/IEZvciBleGFtcGxl
LCB3aGVuIDRLLCBOPTMuIFdoZW4gMjU2MHgxNDQwLCBOIGlzIHN0aWxsDQo+IDM/DQo+IEkgdGhp
bmsgdGhlIGJ1ZmZlciBzaXplIGlzIGNvbnN0YW50LCBpZiBOIGlzIHN0aWxsIDMgd2hlbiAyNTYw
eDE0NDAsDQo+IHRoZSBidWZmZXIgaXMgbm90IGZ1bGwgYW5kIHNvbWUgc3BhY2UgaXMgd2FzdGVk
Lg0KPiANCg0KWWVzLCAnTicgaXMgYSBjb25zdGFudCBpbiB0aGUgcHJvcG9zZWQgZm9ybXVsYSwg
YW5kIGluZGVlZCwgaW4gdGhpcw0KY2FzZSwgaXQgc2VlbXMgdGhlcmUgaXMgc29tZSBzcGFjZSB3
YXN0ZWQgaW4gdGhlIHByZWZldGNoIGJ1ZmZlci4NCkhvd2V2ZXIsIGlmIHRoZSB0aHJvdWdocHV0
IGV4Y2VlZHMgdGhlIGV4cGVjdGF0aW9uIHdoZW4gb25seSAzIGxpbmVzIG9mDQp0aGUgZGF0YSBp
cyBjb25zaWRlcmVkLCB0aGVuIGl0IG11c3QgYmUgaW5zdWZmaWNpZW50IGZvciB0aGUgd2hvbGUN
CnByZWZldGNoIGJ1ZmZlci4NCg0KSW4gb3JkZXIgdG8gaGF2ZSBhcyBtYW55IGNvbW1vbiBmYWN0
b3JzIGluIGRpZmZlcmVudCBtb2RlcyBzbyB0aGV5IGNhbg0KYmUgZWxpbWluYXRlZCB3aGVuIGNv
bXBhcmluZyB3aXRoIGVhY2ggb3RoZXIsIGhlcmUgd2UganVzdCB1c2UgdGhlIHNhbWUNCidOJyBm
b3IgYWxsIGtpbmRzIG9mIHJlc29sdXRpb25zLg0KDQpSZWdhcmRzLA0KU2hhd24NCg==

