Return-Path: <linux-kernel+bounces-122356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AD88F595
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8616C1C2493B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA310225D0;
	Thu, 28 Mar 2024 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hCWsCaPa";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iBJxC04l"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AC2A944
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594376; cv=fail; b=jsp/vQHXJjJ5bbftTAQIuz0zr9dPpfKqXcq+yUeMKm5/iY99/2SnnbV4pxz4LBXNpRA7uCtZfgtTkk8x2YmBg+vI3IVMjdWikfQVO9j4xkrXeLs5ihpmdLsA/k46QtuWQUgx/DmLMDDrVkydHDMIquRIveHXYAD7X3x+bXcd4As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594376; c=relaxed/simple;
	bh=b+QnnWoNN8lN2XdEvwkfpFM+MzDT+9PfJIuKxcTaPkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QVcUCxLZjy/31cJwx6+b92fsGvMHyeqKUFm3WAe1YMf1C1t/E2Yxg41MsmVuCu6mjKsP/tXYuOcQmlUrGXU/GQ+cEiOknD+dGUVntvpxox4CqdRZmhSnvgYpPnaN9IdzNwPLd5SVXxWXDJeyaaO1d1MyA2NsuhQ/25Ii4TQ/n0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hCWsCaPa; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iBJxC04l; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4417d0e8ecae11ee935d6952f98a51a9-20240328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=b+QnnWoNN8lN2XdEvwkfpFM+MzDT+9PfJIuKxcTaPkc=;
	b=hCWsCaPaFHf60AOmo+rGDtIKNYjgZQLOzfb5TwxOD80mpV9EF5UqjAPyVd76a1sQmDU5KIKc+sRUvl6xlzZ5tXtgGw3nUmAPflAggterxkQ3BFIMRDxYqsF+tK8QzgDvoa7SXAYyaqNgQTbE0Ty0qlj+IvGIzeEZ1wASalsJtV0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:274a1270-8715-4567-9f1d-2e308f385cb0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:109e8585-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4417d0e8ecae11ee935d6952f98a51a9-20240328
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1198741759; Thu, 28 Mar 2024 10:52:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Mar 2024 10:52:49 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Mar 2024 10:52:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWeO9syU8SYPgjlnPjL4YcG/HN5Y34TybRcMmxSynUL865sEDQ5i5Eb6aqQ1LWH9suP1vivCIobJ8UWAW5x5zuZoHnX3tN+S3C76rvq/A6zZryP2/KNoLIOlLCU4YT12c2GiTAYf9PldhAGpU06biHr8MgNi6oBkkcHN104sEWuvh8gIwVl00PdwhnddBCqYpPBVtjhgDihv6EY3G9i1hdvzo3Qi+m/J1Lt2R1f7rmdlk/rTHCnPBKrqoruBpOl9FJgLLv2R6Pbe8r4gyh+f/7qYsB6L2u82SkkbllVhUlyYepVASAWD5dDNBQk7W8ms7wgalEc8pobwprOKXTUcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+QnnWoNN8lN2XdEvwkfpFM+MzDT+9PfJIuKxcTaPkc=;
 b=CGIrfcOIwh3q0joEKZgtzSFgYDfZCvo8FKm5zojUy6hHRWD8p5xI2/t6dCsmOTmxKjDTEnzN1y1LHKPKYqZUP8bDk1eRUN9lRle1xbG1n+hUFWHuidj95Nbc3RgwiHvku2uai3e9EYX8Viwl5u1j9Fmym/2BS47CcgcNxZy3RNiTv2fpL1i/NmY9VtTej8lOJnnDrH8re+Tjfo7G3IU+B4TNVHuW3GIBcEes3eMXepryPZnWLyOaOOEe7qiyC0dQG0YCB+QftpjxptSnKDVEDhe9/zguVtYkHHD+BPp5dudf2Yo/Lq/Ln0eJkUQgpw9+sKSsvJ+JbabwOXgx7yNB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+QnnWoNN8lN2XdEvwkfpFM+MzDT+9PfJIuKxcTaPkc=;
 b=iBJxC04lurbG7w0KHMAn8czgiphUsYV3OX8gQkcjgqOReS8klC50rSIVyez2fgSy6sNtG6k4Sdv3r7cMLZgzRWNT2dC75nUGC6rkOnnwX8KvYW/2QXxcqzQqaGetIYxZ+ZV55iKX26bL29Gz9YK3x9EWxftRwhj4LXPZiqUQqD0=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB7674.apcprd03.prod.outlook.com (2603:1096:400:426::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 02:52:47 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8031:ae41:afdd:d0a4]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8031:ae41:afdd:d0a4%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 02:52:47 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 07/14] drm/mediatek: Support alpha blending in display
 driver
Thread-Topic: [PATCH v6 07/14] drm/mediatek: Support alpha blending in display
 driver
Thread-Index: AQHafBntLyISVSK1Jk6jUuOtPIloGrFDgMsAgAj9CIA=
Date: Thu, 28 Mar 2024 02:52:47 +0000
Message-ID: <8ace5f5e5039b8f0a314f92ed083baff7021c379.camel@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
	 <20240322052829.9893-8-shawn.sung@mediatek.com>
	 <d170ccc1b2e6275cfc6df32f90d2c1b11295f019.camel@mediatek.com>
In-Reply-To: <d170ccc1b2e6275cfc6df32f90d2c1b11295f019.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB7674:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kwjmH0LqnQh970w9XTAYRiEU8e3WdYZvqO3l8jXKadfveT3F8iLwsG+wM3oFa7ePPUz8pD5nMlI+gcWqxYjNZjdvWvVgzdOlCi53ARhMNOF832zHuczKXlN1QqZ2lqHFkkLwibGuEVf63QWo3062MRwYPichgrgtdKr2OzLkFbNM8O8zl9q/wbh1CSQDkLKWN75BD/OI8q0cphuZAdFpCmJpOE+yfHK0riGMTW9sVN6iIU4Arr+DyVnbwgjgY/pRouzFbzCaMhSZZh0bHFtib+Spk5wJRchJONGs3nbcFsZ3Nv7kS3ZAleh+W22JZMiBM2+lLlPfsqgy9ArFhDBJXw7fVBTP+NSzRYmDe1bGGPdDctoKVcuPEGSfHrRh/Ne8RPbERV723Cw8E8U8XM9E3i7t0+LrlBpPqsd20UB/1hYbsmMhW6VJmtggXrT03XB9BHTEOfwNVcF0v9JNK/UeDv2fsQUd2spqCkvl2zSfgwkg/ry91aodzKzhlunzRtRxKqe4VH/12SjzTYrP2h92upTrbG8DxzEu/CUbln2nviy0OL+Wi/O4jGvgvdqMAd/hBUE4Lcw5KwBHp/kyti2CW8Tx7JMxnVKyYv34HMxdgqhmvl4ntn5+wM2l1OMts0VeS+t/NUr0ftCpzxlpMKT9GWQrd8qUMJVZagT+oOuGiXI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWhmSWlPWWRjN0VYelYzRUdLOERJbHRrN0NFVHFyVkZhNk1GOTBUZnhVYm1J?=
 =?utf-8?B?VS9SQVl6d3Roam5iSGtTSWdNYkFRTFBqQ29sM2REMXJBOFVhVFpoc0pDRGlm?=
 =?utf-8?B?ODl5bFNoTXh6dEo2UHpTNXE2L0Zmc0Y0WDNGSVlPNVVmTGkyaC9tODFIOUZL?=
 =?utf-8?B?c1Y5R3U2U0NGWDRjOXVkdFpCMEx3enVOc1JZUitOMnN5WU02VC9pSEhidE5D?=
 =?utf-8?B?U2h4cGV2OEZrU0lTSEMwRkhLV0NKOHh5UHIvbzZKN1RSZkpZS3JMeEVBcWdo?=
 =?utf-8?B?NjVkOGhESERaczBBUDF0K25OQ2RDL2hTN0FXMXpJVUVkdE12MHFWNXJMdlNv?=
 =?utf-8?B?NHNwSktzTGtGRFJmajd0V3Q2RlJ3MVdET254ckt6clo0Q2VYYkpwS2xGbWVG?=
 =?utf-8?B?QmtadWxJQnVUZFRVRFNnS3VkREV2RU0yR2ZjNWF5OW9qUVMwOU5CYW55cWFH?=
 =?utf-8?B?RlJHYlEvNldtVmZiUXY2a09EbUhWTWVURnlpNC9udE0za1Y1WHhjUnlKYkUz?=
 =?utf-8?B?WTNoVkowVjJBMkRQbUlodkJWWElGeUp1K013TEtlZzJ3dUZCYktPcUtXMytI?=
 =?utf-8?B?OGhZRHlLZVk5NGljbDk3MFdkY2FMRzlORUIyUHZBMDI1Ym9GSk05QWFtbU0w?=
 =?utf-8?B?QlRLV2ZZeWx6UzAwWkdUZUdDWTdiRVJKQVFxVlMrb0syZU1uRVJWbzlFY1Bn?=
 =?utf-8?B?UHBHRjB1WTk3dGNvdU1KWUVXMndvSlVteXJ3aWJGdDZubHE2VE4xMUZmbkpY?=
 =?utf-8?B?enN4d0NQQUlreDNLSkx2dnRDdS96a2NwZmRTNVlQVGJENFhWTDZUUU9lb3Jr?=
 =?utf-8?B?T1hnR2F2NUpLZTQ0WFZGZHI3dnFwaUxQZVl1S0RpMktVbVJmODhCNEIxK2ht?=
 =?utf-8?B?SnJpWFlqVWNZRjJkWGlDWkxMODJqOVZlZHhxcHJjTHI5cVhrd2lSOWxSek5m?=
 =?utf-8?B?WFhaWEJUZUpWN1ZaRHNZU21vY3NqdWdYQXk0MSt0NVI2N0o2VEtSUzNZa2wx?=
 =?utf-8?B?aEVSRXBhVWtNWU1ySHZLZXUzRi9WamVneW5mOUthLzg4S053NCtDWHNYK0Uw?=
 =?utf-8?B?ZGhmSWloaUUxUjYreVJLY3dzQmNlcVZBbDdGUllPNE05b3NkS1RnbFNJMTly?=
 =?utf-8?B?ZktaVVVyMnBtMGhsTUVFclIybUpqVVJuMWo2T3FlejIzVzRrQlFRQ0tUMmg4?=
 =?utf-8?B?VjJLRHlxaS81UU9yT05qSjJvMmZ6bEc2VjJYcWxrVXpDOTVNeU9Camx5b3d6?=
 =?utf-8?B?dUM3clFXTDBTa3BpMUtCc1R4K2tobmxMTmNzRXJhMHJRVFE1b1BoQk9yaEJm?=
 =?utf-8?B?OXZNOGl6azA1Z3ZIc01BaXoyRXhVYzJyTzFYbHp2OEpZN3lKcS9XYWxPano4?=
 =?utf-8?B?TUExZ0p1Y0FyaFpMbnNwZFFuL3RtRnJnWHFRVGNiQlYxQTNJUXFWUlBRMVBX?=
 =?utf-8?B?ellQTk1rTVpYOHBnMlNSMTE1cnd6TW9lSXJGZjBuVEZuRnc4YXc2cmcwSnJY?=
 =?utf-8?B?UFo1TFRTWUdRdVg1Sm5FYXJQOE9Cd3VmV3dobUU4d1VDWmdjV1pGUkVnVWJy?=
 =?utf-8?B?SHlrbk5CNzhJeURBdG51Yk9LbW5mdUE4YktnTVNtOGYzM29ZbkdDa1drZ1Vk?=
 =?utf-8?B?OC9hWWUxeks3RFR6ZUlqT3hEcWxjb3ZTNEdCOVlnNEhUL0JBL1pTUE8xWUU0?=
 =?utf-8?B?eUhmTEJXRVNPYVB1elZ5cWtySHo4amI1dldLdjNNQTlzbWFaUGl0bkF4UFda?=
 =?utf-8?B?Qk5YYkJkQzFJdWVhOW11YjJqTVdEdHdkcGhwcHdVaE5iL0h3dGxjYU5UZ2xN?=
 =?utf-8?B?cHpXRFB3MWxPSzZIMy9wRkw4aUJkU0x0aGJjN3YzMmErRGNCUVM1cUF4QUJ0?=
 =?utf-8?B?Yk9PRENuZEhSS2Y3QXBTZlJUby85emswNEtmWStFZ3RoZlpnODUzRHNva3hK?=
 =?utf-8?B?QUZldHJJMlY2NVZCekxwVksyVDVacGt1VDdrM05nSmUzT05zU0NCcnJXVW9N?=
 =?utf-8?B?YW5WaWVhZG1BcXBDcEhuMzcyUkZueVdUY0p3NDhlNjhTRTdpMkF5WG9TOEpn?=
 =?utf-8?B?L1BaZ3FKaDMzY0NvSmpNMzZKR2s2dHRKeHZtSVFzK1hCcUo0UTgyLy9XL0Fh?=
 =?utf-8?B?TkVjaVRHYjNOZEt4OWJtdnQzd29mT3hwZ3ZON2hzVUtCUTI4RlB6emtvV0Zr?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E38DE9230EDDBF46A9699629595B5FE8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112c8a8f-6e75-4e46-7751-08dc4ed2268b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 02:52:47.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOewYkaPq09PaYEJPMqWSLYuqeEmGz45/uPUFpjOSelwbO9lqym+IZDUu8llcid/q74ym2naiBbfmnhnqxqidg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7674
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.980200-8.000000
X-TMASE-MatchedRID: BFQSNthdAqLUL3YCMmnG4ia1MaKuob8Pkd8i2lgND8vYgrGDwuFJdtn7
	b/+Y15Iv2aE5ctzxluC0hbf/1vHT6irtEu4khs6L7spMO3HwKCAL8TGleseLPPt592eq2xoTyU7
	XgTs6W4IhJ/ufappeEpGTpe1iiCJq0u+wqOGzSV0LbigRnpKlKSPzRlrdFGDwnZPujXTsnepB6T
	6eWjOMszNNXhysVCCe3qURIMThdjvIWq6FUoB6/A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.980200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	610308F26FEC8D2CAA2F0CC3654FB64251BFBCB1805B42B17511860DC54BDFDB2000:8

SGkgQ0ssDQoNCk9uIEZyaSwgMjAyNC0wMy0yMiBhdCAwOTozNyArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfcGxhbmUuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5jDQo+
ID4gaW5kZXggMTcyM2Q0MzMzZjM3MS4uNWJmNzU3YTNlZjIwMiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMNCj4gPiBAQCAtMzQ2LDYgKzM0NiwxNyBAQCBpbnQg
bXRrX3BsYW5lX2luaXQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwNCj4gPiBzdHJ1Y3QgZHJtX3Bs
YW5lICpwbGFuZSwNCj4gPiAgCQkJRFJNX0lORk8oIkNyZWF0ZSByb3RhdGlvbiBwcm9wZXJ0eSBm
YWlsZWRcbiIpOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiArCWVyciA9IGRybV9wbGFuZV9jcmVhdGVf
YWxwaGFfcHJvcGVydHkocGxhbmUpOw0KPiA+ICsJaWYgKGVycikNCj4gPiArCQlEUk1fRVJST1Io
ImZhaWxlZCB0byBjcmVhdGUgcHJvcGVydHk6IGFscGhhXG4iKTsNCj4gPiArDQo+ID4gKwllcnIg
PSBkcm1fcGxhbmVfY3JlYXRlX2JsZW5kX21vZGVfcHJvcGVydHkocGxhbmUsDQo+ID4gKwkJCQkJ
CSAgIEJJVChEUk1fTU9ERV9CTEVORF9QDQo+ID4gUkVNVUxUSSkgfA0KPiA+ICsJCQkJCQkgICBC
SVQoRFJNX01PREVfQkxFTkRfQw0KPiA+IE9WRVJBR0UpIHwNCj4gPiArCQkJCQkJICAgQklUKERS
TV9NT0RFX0JMRU5EX1ANCj4gPiBJWEVMX05PTkUpKTsNCj4gDQo+IEFmdGVyIGFsbCBzdWIgZHJp
dmVyIHN1cHBvcnQgdGhlc2UgZnVuY3Rpb24sIHRoZW4gY3JlYXRlIGJsZW5kDQo+IHByb3BlcnR5
LiBTbyBtb3ZlIHRoaXMgcGF0Y2ggYWZ0ZXIgYWxsIHN1YiBkcml2ZXIgc3VwcG9ydCB0aGVzZSBi
bGVuZA0KPiBtb2RlLg0KPiANCg0KR290IGl0LiBXaWxsIHJlYXJyYW5nZSB0aGUgcGF0Y2hlcyBp
biB0aGUgbmV4dCB2ZXJzaW9uDQoNClRoYW5rcywNClNoYXduDQo=

