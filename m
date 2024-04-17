Return-Path: <linux-kernel+bounces-148162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B56248A7E82
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199A8B2220F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D1A8529D;
	Wed, 17 Apr 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="acdKyXmR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DJHMs5ON"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15B1EB40;
	Wed, 17 Apr 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343315; cv=fail; b=T3FO3/3Zjg1ftksXbwNgYffOGC9HZHdqhvKoMvuCioF0z7Uuj1t5YR/WBcnRQFoVJi1tLY8c2TePf4PMSZ92FGL9RggmM+QjJHv0tmlI+B6BSzM0YiaWHv/DmedXFnM5hweaKz3e+6uvZohXnRDPhOFDkMiF5O62zS74hAobaVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343315; c=relaxed/simple;
	bh=k0p9M1Lmx2k7T3+l3RB0tBZQwg7ipw84ZLPxkVR6sv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ju6V4AfL2qJLKgBHQe4tHAKUR5Qe+a/noZPvxfJfMKCb/GARxSK8naWcw6c8jPec7OkfH9R6hsjnyR21DmWP9thsYperTwPaKWYa8fbJ0ZdlsjiHxKCHvQFHJ95HArj7hDWqy/+hMpU+vYMXeCnRI/3VrZoS9Om59Ec+QITjD2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=acdKyXmR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DJHMs5ON; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 54427aa2fc9611ee935d6952f98a51a9-20240417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=k0p9M1Lmx2k7T3+l3RB0tBZQwg7ipw84ZLPxkVR6sv0=;
	b=acdKyXmRCv8wSY27ik1tWdYg8l149RijvFLc3tHVAL0/FdmTo2d1o/9CppvtkGlih6R3vtHUfyoUdpOhx4aMKvYFC0ZqJkimlVfyYmFSTqeh/o+8auSs0MDFXaOKtwpr2Z2zextcaLmArW7Q5nypATCZyMuCQuF3NYL9UXb8EBY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:4c5cb8c3-d749-4ccc-b4e9-077b27f182a6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:8e88c782-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 54427aa2fc9611ee935d6952f98a51a9-20240417
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 816804365; Wed, 17 Apr 2024 16:41:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Apr 2024 16:41:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Apr 2024 16:41:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YURAB4QEnRmVPS/9/vWisGhKnYHJgcfvADaywZSbQXYCBF1n0w+zf/mbvd7QAPQ8ZORDaPmoaY9bQzUiwB0La7JHu7RA+swNcR7lCvMhS0QppDvCtCxJpowHzpld07x+hDR6h2FmsqFRUs1oJBOUQwHoEQgNEDenD+AR7qnMQktKpriDahMgfEi1mMMH/IxrYq3axoXGt+yPHV042WmHsuhl28yW8SHBQwvTVysKZ2M0hyX2rtEnBHyDbPHuqvZ1R/2E7rY1K2K6eWtFFIO3bT9Tx7HGJxS8SZjDTUShcsghbtuWjXEDhxeY7kGeRd5IUwj528S0YHvkeKdUOTTqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0p9M1Lmx2k7T3+l3RB0tBZQwg7ipw84ZLPxkVR6sv0=;
 b=mePBQeCuX51LCjVmZsMMIQ5P5dgFGyI5560rGi/9UpRms2quiIqnC6jWzxpqnyciO1QmxnB2DHI4YL+WdehN06nXuiidair1ZzC9uhhwYI9N02udJwLD7B0iBFkrLz/NmiCpmreaVeZja3FoqcQctFkRy3mJCBhVl/iQRdHWj4Yk66FL/rVOzaieNTBEd8BON6jSlrvDS2ybe1u9b4ierzP2jF9iMd8xLMrpJz84HOAG1BEeKPkVZkg2Sj28ACnHa516ZQgP1sGYggx33w24QOp6nDbAGPNsRzgmVidCWuwKWRlRRXwXD9qWTJgZ7vIuLe8pGSsxcSNM2oD6n1sZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0p9M1Lmx2k7T3+l3RB0tBZQwg7ipw84ZLPxkVR6sv0=;
 b=DJHMs5ONr0+XHrNKMYsK8qAn8s/0B2XvCKSgKZoHx3uABLAiO7R2SxJEBCfTZj9DiBnRgGO2vnj/JrZ0QqolIo9qnMM6JYnR3l7xRI6YGgIkDM19w95tJ7FFGSNk+dZtVRkb+AQJEMR25k6XJJmXdDUaBbny2BL/OOr3rq70z84=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI2PR03MB6807.apcprd03.prod.outlook.com (2603:1096:4:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 08:41:44 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 08:41:44 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jkardatzke@google.com" <jkardatzke@google.com>, "nicolas@ndufresne.ca"
	<nicolas@ndufresne.ca>
CC: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, "mripard@kernel.org" <mripard@kernel.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 1/9] drm/mediatek/uapi: Add
 DRM_MTK_GEM_CREATE_ENCRYPTED flag
Thread-Topic: [PATCH v5 1/9] drm/mediatek/uapi: Add
 DRM_MTK_GEM_CREATE_ENCRYPTED flag
Thread-Index: AQHahbGbJAQJP2BTyUuB60+FvPVWmLFrA/WAgAA1AQCAAQHMgA==
Date: Wed, 17 Apr 2024 08:41:44 +0000
Message-ID: <0a4211070f1c895d776e3d9dee9ae3113de8c976.camel@mediatek.com>
References: <20240403102701.369-1-shawn.sung@mediatek.com>
	 <20240403102701.369-2-shawn.sung@mediatek.com>
	 <70733fe5c919527796bd3d9735ced522bcdd7a25.camel@ndufresne.ca>
	 <CA+ddPcMWein69X6U46pZbDy51gFHHxXV5d+6BvFq7ma6n0E22w@mail.gmail.com>
In-Reply-To: <CA+ddPcMWein69X6U46pZbDy51gFHHxXV5d+6BvFq7ma6n0E22w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI2PR03MB6807:EE_
x-ms-office365-filtering-correlation-id: a1787847-57eb-4afd-f7ba-08dc5eba3618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?NlBCYmV2N0hYYjh6NCtodTBmdDd2WmpPeTNpenRQdWlneXJyZHVpYWxJbktl?=
 =?utf-8?B?REpIOGNNYldYVzBiUUY3TEsvY1JGRmFKQWJtRWthdEN3SVFMYUoyRXZCYjBx?=
 =?utf-8?B?MnJ1NTNGU0lpZXI4SDBycEJyb0wvck9XajczaHdoUHFRTU9KQ3hQZml1S3Zw?=
 =?utf-8?B?SnVYRlZqZmZpYTlXVm9YckhmR0NMYVRaL3lzclY0Yng0UGc0OGt0R2hyd1F2?=
 =?utf-8?B?cWJLTnVHV2dsUjdpZGVtZFp6bDVZNmNFV3JJQUFpOTNLMW85RmNYSXBHVTdB?=
 =?utf-8?B?dm1xMjZhNm55QXczYktkalhMMnU0TWtyR085bVdhOGdXM2FXWUd2UFkzNmhW?=
 =?utf-8?B?V3VuVDUxeTlYVFQ3MXc0VGlqK2lIN1F5VnFPQm8rd2t1UHlkUnlwdXFFdDRC?=
 =?utf-8?B?ZjZwVlVnZFd1ZUhGUWxkSFJxZzdBZnlxZDJ5UFRWdUthWVhodHhoamVOeDYx?=
 =?utf-8?B?WkxWem11OWI4TmFBaFB5czFKVEI2V3B4amZBblEvb0FWRDR3eGJ3Ui9DR0Y4?=
 =?utf-8?B?a2Q0bDFlYUY2Y1FUWjcyNGZNSDFPenF5a3BoRTdjeGJvVmpPNzkrcDlreHp6?=
 =?utf-8?B?SytQVG9SakpQODZRUVVuS3lXVVoxUklSYWxFY0E3L1FtcW5zeTF6WFBwZEJR?=
 =?utf-8?B?S3FCY0duUW1FWFBRRUo1V0ducjVaL21YLzZ3VzJxN0tSdlA4NmRCWnBYa3la?=
 =?utf-8?B?QXpBMnNUZlpRU01NL0FJT1VJVGtWQ2hWczFsa2VvR1R5bzRVYWxRaEhYVk5t?=
 =?utf-8?B?V0JGdmdWQnlvRzhWUTU2YUkrNjR4MVlIQXAxK3MxYWhPRDF0aHdhaFZYMUQ2?=
 =?utf-8?B?MS9UeFBLdE53MjRMV1ZxZEJmbFlCZ3ZMcUtFV2JVRzJzRzR0WmxNUEpsQ054?=
 =?utf-8?B?ZE80RDVOUW05bWh6aVFQbzljQnhiOWx4V1FrZXZMdm91NlJxeGlZNnJSQjNt?=
 =?utf-8?B?VWVUaFI5aTFJVlcxQWl1QkkxcXI0R1FCZjdYbmZQTUt5VGt5K09YbWZuZ1do?=
 =?utf-8?B?TVpaNEFvSW9NSVBHaytYdGFnQTE2WlhDUDBMRVo1TktMRlhsZkZGanJJVzBh?=
 =?utf-8?B?NFc0amRtRStVV0p0eE1MNjRBbVgvYVExdVpQbzNDV2Y2YnQxSzVscjZhWXVT?=
 =?utf-8?B?amtPNUVYTTY2ZlBUbGFnRFA5UElSY2wzTXNNOVlVTzFrYWxaSnNvdHNoNmVZ?=
 =?utf-8?B?d1gxNk1UNEd2a3lTcEx6TlU1czFvV0dyd2ZpZFZHV1FCQjh3WE5xQVpBYXNv?=
 =?utf-8?B?Qlh2NnpENS9zMm1Ub0VyZXlOVlo5cGNZYlBSSjVmUjFFa0pQeW0rKytyKzhT?=
 =?utf-8?B?akNGTnYyd2tkVmlhMlZoWEpHbVZ3S01DRkRiYW1EaFBMTUdYTWdhQjRCMElv?=
 =?utf-8?B?UjhWT3g1WXdaTkNVZEFaR2FzNkZRSTJXa20vdEMvMnNKNkNrS0dKbnFxb1M4?=
 =?utf-8?B?NE1xTGtEMkpMMWJxVnJ6WStObnB5WmpCTFNFOFdnYjU0V2ZjWjdBTEdKLy9p?=
 =?utf-8?B?cW8vczZBYUZEeUtNZG9MWElKcVFYa2laVm5vWVVrTEdXS0pxV3k3RzI5T3lZ?=
 =?utf-8?B?Y3dMVm9lYnF6V2ZEVzF2TS80aERTNUt1VHQ0cXFwcElKdkgwcWp1elMwaFB2?=
 =?utf-8?B?ejgvcFJNVU5sVThObEU5Q0MwWUYyUHRtbm9RN1FkR1RKZTZSTlpsTE5ibGpO?=
 =?utf-8?B?bG4yOGRTUndyaVNtZmpEYjBZbzAveG9nQk1lM0M0bUhoZnJCMURkc0VSNjVF?=
 =?utf-8?B?Z3hnZlVRbFpuNGp3WmVPK0JMeTdBOVBieVVCNERRNmt0Y3hZSFNadFZHcFR1?=
 =?utf-8?B?WDdjdDRmV1pkV3lVTEM5dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3R3c0ZmTTJNMHp3VkJWVnVuc2xjbW80VFdUdFJRTVZ2c0dsYmhmOWxsR1JN?=
 =?utf-8?B?Uk5NYVFSeHJESUlZdHoyVHBpU20wTGNoNU1aWm9Uc2RmYXVQb0FYS2hWZ1FR?=
 =?utf-8?B?eDVwelVKMzZKM1JxWUlEZGR2aDRUemZneVdwZE5mbHBsWFhZQXFKK3Z6Ulha?=
 =?utf-8?B?d2dxNmJJZU9DZ3NHVVE1OEtIZ2tGeVUzMHpqVG5TdTZaTFlVQm5TME54VXl1?=
 =?utf-8?B?QnVnTzFmUEtUY1lyQzhET3hKS0QvQzFXRXlyeU1WUjlnVnRzYjMwdk5VRnVE?=
 =?utf-8?B?eHF6dGxuVElORERxWEo5a2VnVjRWcXB6cUcrdzljODNXV2preC9SdDRxdFBM?=
 =?utf-8?B?WDJlaEc4YTJ0NnN3OFBSM2V1ZXVjQWNqYktISUhBU01xWkFsMWpHZWt6alRN?=
 =?utf-8?B?VWpISlRhdmdXNzNtWXBIQTRWVHBYMG5OUm54ZDM5cVdUN00zendvR3dwR1Rs?=
 =?utf-8?B?MHpNaFI1cEtEbVh6NndIQkx5OHZVTzR2disvT0Q0YW1sTVF2c2Q0YzdBL29m?=
 =?utf-8?B?dVNvcGZEM0U3M0N4VFl4b1pKSXZSMFdnMG8vbS83TkYyQ3pzRTVvNUdBRmZx?=
 =?utf-8?B?QnVKVmxBZ1dxNGRtUURhN0djNUFIY3V0Y25wblprM3NVblpxMXRzbE5hQVRt?=
 =?utf-8?B?WG5PZUk1b0lUN2d3Y0psVmxEYWJ2RnFmU3drdTNwUGZHZ2ZtbFVFb3VxRDRp?=
 =?utf-8?B?UTRHRUpNZlcwVkxPV3FOY2xOMVpQaGI4cGtIR09hclZtUk91SDJpS2xiK2x6?=
 =?utf-8?B?TlJaZitRYlN1N2dNakVpZ3hPbG9JZVgwUC9zUnlCQzhIMzZYSDhVdGJnRWZa?=
 =?utf-8?B?NmhBVW5PSXVQNEJkbks3bEhWY2JrQVVEL0l0L0tOUzU0c2NpRlpwd2ZXdEs1?=
 =?utf-8?B?emI2K3UwdlZQbWQrVENWbW8vcGFTajVKYXVFNTVuVG5BZjZLQ0xKdldhTTZN?=
 =?utf-8?B?RGJvUTBrMU50dTBMKzZMaUpQL3Y3eGZ0UENCUmRVdUxzc0xyZ1lOa0wxU0pV?=
 =?utf-8?B?VmR6d01RUE0xY3BCZUsvZW1pdFR6YXZMNVhwRXQ5SWZyK2dsc2V4TEltZmNv?=
 =?utf-8?B?ZVJGSEo3L01ET0tWWjBzakpUMVNENjFrcnVIOVNVSXU1c2NNVkN5bkRkYlY0?=
 =?utf-8?B?L3dka3MrWTE2NWp3WHh3YjVadS9vNlNGZ3RGNnQ4TkhZMFR1NkcwV3ZBblYx?=
 =?utf-8?B?SmIrNTVzVHkybUgxVDNwK09RczJQR1BWcDRXREJzVGtjR1U1NWVkb2VVWmxM?=
 =?utf-8?B?aklkeG90RXBXMXJ4ek9GUDZndFJPWjhXeXdFbXpTV2ErRTFFYUNuYkxnMTVM?=
 =?utf-8?B?MGpuUytVWjZsZUhwWDZkSmpLTnBPNFNCMUJCanRNclVUak9vc0RHa3lxNXhp?=
 =?utf-8?B?d0RhSExGL3dFUll0N2FTbHBwMVZ0UVliTC83K2RrOWx0enVYdXNKYk9rZXkw?=
 =?utf-8?B?SkdWSzMwMmNQUUV3cW1QdENqMGl5cTVGSmxFWWI0TDBHVzNtLzh3aUF1S1BC?=
 =?utf-8?B?MzZFaE1ScVRIR3hKSVRjZ0lqbDY4UnBJM2NmSUNtTFlPYzByejVzTkZzRzNt?=
 =?utf-8?B?Wi91cWVHYk16TkZCUXB4UnpEZDV1RzNkWnRWN2RIY29tcVNUdTZ1VEx1MWZn?=
 =?utf-8?B?OTY1NU9MK1IwM0lrQ1JuVWxoRndVK2NaVVVSNVUrd1orRi81dDRRcU5WdHlx?=
 =?utf-8?B?b0h5WGZnUGUzMnpERldPeCtLQnJ4dC9RcW5EWkdvd0pDaGgyL2RMQ2FmSnFn?=
 =?utf-8?B?MHpHR29FQUxubFRNdmZGdDBMT0NvN2ZELzVZVDBxUWp0Z0NkZit5YzJJZ3ZP?=
 =?utf-8?B?eG90TzRsME9hOVU0ZHFtSHNob2tsNWhsVDQwRzlKYXV2RmovTDNyZTMzSkF0?=
 =?utf-8?B?MDdJa2lRbSs2UzhWbGl1ZUtOSE5oSjI5NXBsWi9aQTJGbTl3L29Ob1ZuUFhO?=
 =?utf-8?B?SDJYZUlvVU1ENzYvQWVOMS9sTm10OENmZlJaeVNYUytzdUZRbzZqU3p6dDNa?=
 =?utf-8?B?d2plSnlycUFMZjRTRFlKYmhGZEMzTjM4c1hsU1VXUnpVRmZFR1FMRklvNEhw?=
 =?utf-8?B?Q0JjZjYzaHpITDI3MUQwdVR5aXpHQmRTaXBwdW9VeEQ2SXU3TmtFUE4reXFy?=
 =?utf-8?B?K1ZrcDM3Y0hudjU2dkVzMW14Wkg3dmJ4eVdDbnlscXB5OXFkWU5BcjViWDht?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B1682843AA8F24EABE0CB8A6011FBF9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1787847-57eb-4afd-f7ba-08dc5eba3618
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 08:41:44.3895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2+0s1jIOOpWtbcirA0VdtWRea8jUQDHcooBevZT9YIhbvtE5fqStV+CK0X2ehr4WgU25FNRikcszDXEnSkbqCHxb+0RBl/GH4vCcTzohpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6807
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.245100-8.000000
X-TMASE-MatchedRID: oTBA/+sdKaYOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0pk/kY+bkVG0f+j7mX1lKC+6vGX8vR+hqh+Mk6ACsw4JlwpnAAvAwazwiv
	HhowI6vy3lheBgSpbdEauycBzvzre5yEf9QnkHo8CNMj/7qB/g2jb0AoQdda6CIEg4p7AOmzVOC
	IlEhiCO9YuKEikEh+ZvNvKIykSdg30GGSQQaBfERuZoNKc6pl+fS0Ip2eEHnylPA9G9KhcvZkw8
	KdMzN86KrauXd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.245100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4BD88C9336EA0E33E73A4F36028061CA84190C72E2187230E3B7D25F44AD3D912000:8

T24gVHVlLCAyMDI0LTA0LTE2IGF0IDEwOjE5IC0wNzAwLCBKZWZmcmV5IEthcmRhdHprZSB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ICBJIHdvdWxkIGFyZ3VlICdyZXN0cmljdGVkJyBpcyB0aGUgcHJv
cGVyIG5hbWUgc2luY2UgdGhhdCB3YXMgd2hhdA0KPiB3YXMNCj4gc2V0dGxlZCBvbiBmb3IgdGhl
IGRtYS1idWYgY29kZS4gIDopICBCdXQgeW91IGFyZSBkZWZpbml0ZWx5IHJpZ2h0DQo+IHRoYXQg
dGhpcyBtZW1vcnkgaXMgbm90IGVuY3J5cHRlZC4NCj4gDQo+IA0KPiBPbiBUdWUsIEFwciAxNiwg
MjAyNCBhdCA3OjA54oCvQU0gTmljb2xhcyBEdWZyZXNuZSA8DQo+IG5pY29sYXNAbmR1ZnJlc25l
LmNhPiB3cm90ZToNCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gTGUgbWVyY3JlZGkgMDMgYXZyaWwg
MjAyNCDDoCAxODoyNiArMDgwMCwgU2hhd24gU3VuZyBhIMOpY3JpdCA6DQo+ID4gPiBGcm9tOiAi
SmFzb24tSkguTGluIiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiA+DQo+ID4gPiBB
ZGQgRFJNX01US19HRU1fQ1JFQVRFX0VOQ1JZUFRFRCBmbGFnIHRvIGFsbG93IHVzZXIgdG8gYWxs
b2NhdGUNCj4gPg0KPiA+IElzICJFTkNSWVBURUQiIGEgcHJvcGVyIG5hbWluZyA/IE15IGV4cGVj
dGF0aW9uIGlzIHRoYXQgdGhpcyB3b3VsZA0KPiBob2xkIGRhdGEgaW4NCj4gPiBhIFBST1RFQ1RF
RCBtZW1vcnkgcmVnaW9uIGJ1dCB0aGF0IG5vIGNyeXB0b2dyYXBoaWMgYWxnb3JpdGhtIHdpbGwN
Cj4gYmUgaW52b2x2ZWQuDQo+ID4NCj4gPiBOaWNvbGFzDQo+ID4NCj4gPiA+IGEgc2VjdXJlIGJ1
ZmZlciB0byBzdXBwb3J0IHNlY3VyZSB2aWRlbyBwYXRoIGZlYXR1cmUuDQo+ID4gPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRl
ay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBpbmNsdWRlL3VhcGkvZHJtL21lZGlhdGVrX2RybS5o
IHwgMSArDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPg0KPiA+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0vbWVkaWF0ZWtfZHJtLmgNCj4gYi9pbmNs
dWRlL3VhcGkvZHJtL21lZGlhdGVrX2RybS5oDQo+ID4gPiBpbmRleCBiMGRlYTAwYmFjYmM0Li5l
OTEyNWRlM2EyNGFkIDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9tZWRpYXRl
a19kcm0uaA0KPiA+ID4gKysrIGIvaW5jbHVkZS91YXBpL2RybS9tZWRpYXRla19kcm0uaA0KPiA+
ID4gQEAgLTU0LDYgKzU0LDcgQEAgc3RydWN0IGRybV9tdGtfZ2VtX21hcF9vZmYgew0KPiA+ID4N
Cj4gPiA+ICAjZGVmaW5lIERSTV9NVEtfR0VNX0NSRUFURSAgICAgICAgICAgMHgwMA0KPiA+ID4g
ICNkZWZpbmUgRFJNX01US19HRU1fTUFQX09GRlNFVCAgICAgICAgICAgICAgIDB4MDENCj4gPiA+
ICsjZGVmaW5lIERSTV9NVEtfR0VNX0NSRUFURV9FTkNSWVBURUQgMHgwMg0KDQpPSywgSSdsbCBj
aGFuZ2UgdGhpcyB0byBEUk1fTVRLX0dFTV9DUkVBVEVfUkVTVFJJQ1RFRCBhdCB0aGUgbmV4dA0K
dmVyc2lvbi4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+ID4gPg0KPiA+ID4gICNkZWZp
bmUgRFJNX0lPQ1RMX01US19HRU1fQ1JFQVRFICAgICBEUk1fSU9XUihEUk1fQ09NTUFORF9CQVNF
ICsNCj4gXA0KPiA+ID4gICAgICAgICAgICAgICBEUk1fTVRLX0dFTV9DUkVBVEUsIHN0cnVjdCBk
cm1fbXRrX2dlbV9jcmVhdGUpDQo+ID4NCj4gPg0K

