Return-Path: <linux-kernel+bounces-76020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D14285F204
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A627284CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1632B1799D;
	Thu, 22 Feb 2024 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iLWThMK8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QGqbkB3h"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029F17981
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587845; cv=fail; b=iTddle1ZlxLBFELrnIDjtswxrduradjDEVHMo67/iH9lVNNM2Rokif/uQk4xfCwgG2TiHmd6MNpRAhnRAiY0ZX8Nesw1xWyOuGztAszOZZEsGxZyfBddkKidsZwSbvDdk1J1YwlVEpVG9H2KwY8nw+XvcCmMDOOMNXsst9SovDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587845; c=relaxed/simple;
	bh=vOObQk3YPsUyPAR5SCXb41T3zFtdxfVqgkIO/86RkBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j7G8TIy4HuamaEKDxk4NNAm0dKA8s5TtNTdWS0QTuiggN5jx6l37wjyfociTF0inXcDASYQgCCHLugps7JWEb5VXZ5b3QgHQoU4ucYss67/T02rBSRlti0QEZwzvj4DBsOfixfFGU7/vhWvRIQ7+VJfUrOAJuxZltEjMzbYUHSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iLWThMK8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QGqbkB3h; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2100885cd15611eea528b71b88a53856-20240222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vOObQk3YPsUyPAR5SCXb41T3zFtdxfVqgkIO/86RkBA=;
	b=iLWThMK8Iln7a6flzzMo3F+FZyK+JotKaKph3iVoii222+MD5iKaVwebKOK8qK54d7m+pzN/txc/ClvQaQcvGbExkW/SJZc0jROdyMlyZiXkTdK56tUE0TY7nesEssUpnE+tBTqYLOcRcIWs6oh6ZLSvHTiDXNBv8vytx6UrEx0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d4fc3560-11aa-411d-a4db-80cf7b20cef5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:63b813ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2100885cd15611eea528b71b88a53856-20240222
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 581464033; Thu, 22 Feb 2024 15:43:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Feb 2024 15:43:53 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 22 Feb 2024 15:43:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSeDAq0eAB8GWPsiPRmHsogPJCpRCJL0r58HtO2vLak2YY7iP03VrzHtnIptjsnz9eNtqrNJD1LKr6Pe4w2H13tiRKEg6nvbfe6kOMVo3ZTVF/JEwQp4ebHi2PHC4e7ANrvs0sLMbgQ5sa4CLnELn0IEISDoHe6hMqTFhSnyy4YHVh0LcFdMnGhhcRcW2ZvGRPTzIWd0mb2Rg94nFLXljTo0aHwXb1IYHF9mzxh4nJnTHSwuRE9BP2aYm1O+jOZJRRRMwzu1xgqERQ56VI7wOs/8ICw6ZZiQjIhc/MsfhCqb0WgwEpucqSAIj33aPtbEDFF8IyUiZuYLzOPnln6zLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOObQk3YPsUyPAR5SCXb41T3zFtdxfVqgkIO/86RkBA=;
 b=iCAfOrjNdy5XZmBj6FWLfvet/Q2OjeGNOpF/12NuOb6FRykmdddksy25tu0Tu8VxnSD9SjpY5FsQUeY6tWOHvZuribESPrHc32fbgxoS5H/vCWxhsqalODYLP6BXHwILGrQ9r9yY9y95nqDlSFnzUMs+62yfhsuWjZReI6Xp/cUs0AMlzuefwDHb3MNq01ir9PpaMwonqj1aiyYX6xI7yqS8TKIXS6no++rymgpZFDGNuB1jNSwthdMgj8tPXwFCvZb4zIq+KG0Zd7SJWrsk3SMD6MS8iK5rzXC0oiG9jnPy5pKNy7ti2YyNB5FGKhsqY7QYqvZHoWxZZEYLQQbbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOObQk3YPsUyPAR5SCXb41T3zFtdxfVqgkIO/86RkBA=;
 b=QGqbkB3hf2fupyFM61otPQBrqmCuPZ3MAu4uyuLEKLcwGXxTnKaa8nhqq8TgWGvg/9Ik32zH3QFoaDiGf3JU7yz/HmONLlhkXiQszvDC1nkBo1ubQ+M792lq0iBf+L0GRsEBVqMwStrJrtTSd424+Btu8T382xo8028pwDXu8nE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7801.apcprd03.prod.outlook.com (2603:1096:400:47a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 07:43:51 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7292.029; Thu, 22 Feb 2024
 07:43:50 +0000
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
Subject: Re: [PATCH v2 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Topic: [PATCH v2 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Index: AQHaV/eVzqRhxdMZlkypH21h174pubEWFdAA
Date: Thu, 22 Feb 2024 07:43:50 +0000
Message-ID: <715a89642e1412a199ba07539666950794922faf.camel@mediatek.com>
References: <20240205055055.25340-1-mac.shen@mediatek.com>
	 <20240205055055.25340-3-mac.shen@mediatek.com>
In-Reply-To: <20240205055055.25340-3-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7801:EE_
x-ms-office365-filtering-correlation-id: 9899cecd-bc53-497d-e223-08dc337a0301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QaXVVveP/hMjEwsPhf1VTHIUI2RhJyYkWIHlSleo+rk2GkyfAMJv6j3qEnS34aT9cTTW8CCahXz7ApXTs6zGA4vi31/6/DoHk+qZHFDquNhuZYFNULSHzHubNgnR8FBFP/YpDSLPXKjEwcbKcHatLFIpsRpO/vHPnJZUE+AiNOqgAy4xggFN2KYLodq5xURLwsaql9F3j37wNg7649LHs7NVmVthlVL3D1+OprH+WVw2nxrmpM7eG1vOtltyypOd5+ham4PQZQSYzOxRH7fL8QWpfN4aV3fDsX1H/qx6yYhsyrULObSnt1LA9edxG/W0Wamfv7z98yu1ORYeA4T1ccjPqDNVbp6or+JC9xNk4Ws1itchECBrgCJchoN2yqIdi1dU2Lp3jcRfsdF3siFU54RqcKDXeswkRMJ9abr3HTZUcbQHNPRdXF6463e5glSt3yUe2gdd47n4wsbl/h1J97uuKOY5nsVYkdFpZG13EL+FAXfqSi/QmVHmL1WoTZvPAUTKG8sPPMurbY1BYyVksbgxzijRDYgiNH4GAfCcua6TM3NQs0WyojIRqQdAY4c45VWR9cW2MLJYdJu8V5A+5Rh2FEe0bvxRKkCzNcUvF+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTIwdlI3YkJ1V04xamRMdy9haFEvL1FnRjB1b0Rwb25YSkNIaTdRZzJMbUZz?=
 =?utf-8?B?M3NVcW9qeDVwWGRiM1BWbzlkSlNpeHd1cFNSRm9HSTBjeXhMMG80SW85SFdi?=
 =?utf-8?B?RGZ1TGVObTFFZjY2cDBYNDg1Zk1IUnVjdkJ0TFFaa1o0RDRQYWx4MG51ZExM?=
 =?utf-8?B?NmdGL3pTN05nK0dqaTNIQzBNY0lHSE0xSWdGMDJFaUtnNG9Sa0pyNU8wM1J5?=
 =?utf-8?B?UW1PMi9lK1VOblhZaDVOK2VOUWxHQnY1UTZwakVLenFtSmpremtjaFFaZGF2?=
 =?utf-8?B?UWxCeEFoVGt4RERyRUp6Mm5WdHhOeTV4SUVoWXJ4NFA3MkRLd2FZQmMydmM0?=
 =?utf-8?B?aE15QndiV2VKUjFWZCtwYStnczd5eWkyUnAvM0NXWENpc3YyRElkMWdJWC9q?=
 =?utf-8?B?N1lISXJGNW5LTG5Fc3NscWNiKy81cE1GN2dROWJlSUJRbHVjeTlRNDdkVklJ?=
 =?utf-8?B?Rkt6SEprcEVYekVWaW0xdE1Lb3RmdDVnTzhxQkNmbkxtc3FOdGovd2ZVRlpJ?=
 =?utf-8?B?NjF2dGpmanhlVG8ybXl0WUlVV3Vabk9VZkVXUDJuaVNreDdLbjc1VHFUZ0J5?=
 =?utf-8?B?dnJ1MFFCcjRmMkZVbDRveUNQS3A5NTNSNjAySnR0czZrcUZyaVBhUlZOdXVI?=
 =?utf-8?B?QlJCaklSWXBoakhuUUQwVDdPUkwyWlhxZ1NwTko4dm1qYjZqellJa09SR2dD?=
 =?utf-8?B?Z203VXl4UEU1UzZXenN5MmJFMVFjTS9kWjhwT1R0S0dIeVd4a0pkbHcxWGd2?=
 =?utf-8?B?UlFKY21rZjFMeXhrNUI2UmlRMGpNWDVnSzJOb1IrMCtmRy9GRGc0UUZWL0x1?=
 =?utf-8?B?bnVyUFYzNFd1ZmRhdEUyblFhUEpxb0dsQlpxckpqMEpIWW9WTFRDUzdaMU5l?=
 =?utf-8?B?UFVCT2tzNXljNXBSbFQ0UlR1NEQwc1BlQzlteGRXNHJabW15emtBKy9mdVdP?=
 =?utf-8?B?NmdzWlpGTHl4VHJyNW1VUmdGM0V5Wm5hNzdkcXVDTDJwakRzcStBRExRaDdH?=
 =?utf-8?B?R0JxMWJSemVEakJJNUZSOHgzVDk2cnlxTUU0NmRxNTg4bkJhUEl4MWFZc0Y3?=
 =?utf-8?B?cG5RMVBWKzcvYjFZZncvZlZFNmsxb1FNWC9rZzYyY3JaTGdJcEhWdnRaREYr?=
 =?utf-8?B?YzU5cFlVRDhwSk5ZU2I3Um9Xb2tjM1VwM2lCQVRYRTc2SUZEZi9wZjNHZ0Fj?=
 =?utf-8?B?SGUybm96V1RzK0tRODhlcDRvWTNETzE3QUtDWVJKOE0zRmwwNDRrU2hMQkZY?=
 =?utf-8?B?ci9oQkcxMFg2RGc3QWU4ZUN4N2djSktMV2Q0bzdDT0dGNXZVamphRlJ6dDhR?=
 =?utf-8?B?d0ozVFU3S0s3bnV2UTBzN3owZE8xeEFhWVFBUXdidUl0dUp4YjZLZnpMckUy?=
 =?utf-8?B?bE0vQUVsL2VoZTErRWlGMktlWlpmV2dJUUo5MVVPb2JrVW1zanM2N2llajlw?=
 =?utf-8?B?TU9FTlpzU1lLVEdsVVBNZS9nL01SWXBnVVNENWg5OFcwTUJOTHc3aHN5SktK?=
 =?utf-8?B?VXdyaU04dG5sVDUzM3VRSThNMm5xYUx0ZTRtMndYekpCUVZ2SmhvRE5rWllT?=
 =?utf-8?B?dGQzSlRGMWVoRjc1bXVxM09SMXZocGFuTU1DWmtxZERubC96NXBUVzE1QzFX?=
 =?utf-8?B?MGUyWU5jUWFmVHVCSUxtYVFyU0tKb0Q2ZWhlZXJRVm5QMHdMck0yOFZpTTR0?=
 =?utf-8?B?dzR2czlnMXZIb2hZc1M0K1pHSnBqQUtOVVZTdDBoKzY1eHR4Mk8zNDBzWkI3?=
 =?utf-8?B?aURxaDR0ZkJLWFpJSGhHRW8rQlBSWXFscWxyVC9GYjF0K0NYeUw4NTRVbWlN?=
 =?utf-8?B?R2wyNDFCeEFqb0ZvZk9lOHVuM1ZYQ3lCc2NqZS9VT1JUL2FIQUdkU1hocStM?=
 =?utf-8?B?WjQ1cklvQjFTV3hzV1NNQWcwQU1ReEkzNnlPLzIzSE9oSmRFajJpSUxER2Y4?=
 =?utf-8?B?QjZPZ1JweDlBUjdaSlRvekxwdzU4U2lIeW52SUxrblZxbzROSDRFZGlZNldw?=
 =?utf-8?B?MUV2d2prQjUyUFozQzJSTEFVSGduY05hVVJCUGRhc1duRkw2N1IrdlJuZG1T?=
 =?utf-8?B?UmR0YmpuWEhYaVVCcXpCNUtmd09JMkdWU3NWUHByRkJzbzlhbis4K0hTa0gr?=
 =?utf-8?Q?+l/gNMKIopuAOk5ru4Xd9zBwX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C80466E407FF74438822B93AA2500443@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9899cecd-bc53-497d-e223-08dc337a0301
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 07:43:50.8879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jxl1OuxLiMudasG7qjx+9qrUHChK/ckatkLeBujHYEd70/KCiGgymfxJjf3xpL0JC2LavUo+7pQnUSfUoKGJNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7801

SGksIE1hYzoNCg0KT24gTW9uLCAyMDI0LTAyLTA1IGF0IDEzOjUwICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQWRkIEhEQ1AyLnggZmVhdHVyZSBmb3IgRGlzcGxheVBvcnQuDQo+IFdoZW4gdXNl
cnNwYWNlIHJlcXVlc3QgdGhlIGtlcm5lbCBwcm90ZWN0IGZ1dHVyZSBjb250ZW50IGNvbW11bmlj
YXRlZA0KPiBvdmVyIHRoZSBsaW5rIHdpdGggQ29udGVudF9Qcm90ZWN0aW9uIHByb3BlcnR5LCB0
aGUgZmVhdHVyZSB3aWxsIGRvDQo+IEhEQ1AyLnggYXV0aGVudGljYXRpb24gaWYgdGhlIHNpbmsg
c3VwcG9ydCBIRENQMi5YLg0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSByZW1vdmUgc3dpdGNo
IGNhc2UsIGFuZCByZWZpbmUgY29kZSB0byBtYWtlIG1vcmUgY2xlYXINCj4gLSByZW1vdmUgc29t
ZSBkZWZpbml0aW9ucywgYW5kIHVzZSB0aGUgZGVmaW5pdGlvbnMgaW4NCj4gICBpbmNsdWRlL2Ry
bS9kcm1faGRjcC5oDQo+IC0gdXNlIHRoZSBzdHJ1Y3Qgd2hpY2ggZGVmaW5lZCBpbiBpbmNsdWRl
L2RybS9kcm1faGRjcC5oDQo+IC0gZG8gSERDUDIueCBhdXRoZW50aWNhdGlvbiB3aGVuIHVzZXJz
cGFjZSByZXF1ZXN0IHRoZQ0KPiAgIGtlcm5lbCBwcm90ZWN0IGZ1dHVyZSBjb250ZW50IGNvbW11
bmljYXRlZA0KPiBwZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC84ZmZmNTliNTU2NzQ0OWQ4MjAxZGQxMTM4YzhmYQ0K
PiA5MjE4YTU0NWM0Ni5jYW1lbEBtZWRpYXRlay5jb20vDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBt
YWMuc2hlbiA8bWFjLnNoZW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCg0KW3NuaXBdDQoNCj4gKw0K
PiArc3RhdGljIGJvb2wgZHBfdHhfaGRjcDJfd3JpdGVfbXNnKHN0cnVjdCBtdGtfaGRjcF9pbmZv
ICpoZGNwX2luZm8sDQo+IHU4IGNtZF9JRCkNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2RwICptdGtf
ZHAgPSBjb250YWluZXJfb2YoaGRjcF9pbmZvLCBzdHJ1Y3QgbXRrX2RwLA0KPiBoZGNwX2luZm8p
Ow0KPiArCWJvb2wgcmV0ID0gZmFsc2U7DQo+ICsNCg0KSXQgc2VlbXMgbm8gY29tbW9uIHBhcnQg
Zm9yIGVhY2ggY2FzZSwgc28gSSB3b3VsZCBsaWtlIHRvIHNlcGFyYXRlIGVhY2gNCmNhc2UgdG8g
YW4gaW5kZXBlbmRlbnQgZnVuY3Rpb24uDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJc3dpdGNoIChj
bWRfSUQpIHsNCj4gKwljYXNlIEhEQ1BfMl8yX0FLRV9JTklUOg0KPiArCQl0ZWVfaGRjcDJfc29m
dF9yc3QoaGRjcF9pbmZvKTsNCj4gKwkJZHJtX2RwX2RwY2Rfd3JpdGUoJm10a19kcC0+YXV4LA0K
PiBEUF9IRENQXzJfMl9SRUdfUlRYX09GRlNFVCwNCj4gKwkJCQkgIGhkY3BfaW5mby0NCj4gPmhk
Y3AyX2luZm8uaGRjcF90eC5ha2VfaW5pdC5yX3R4LCBIRENQXzJfMl9SVFhfTEVOKTsNCj4gKwkJ
ZHJtX2RwX2RwY2Rfd3JpdGUoJm10a19kcC0+YXV4LA0KPiBEUF9IRENQXzJfMl9SRUdfVFhDQVBT
X09GRlNFVCwNCj4gKwkJCQkgICh2b2lkICopJmhkY3BfaW5mby0NCj4gPmhkY3AyX2luZm8uaGRj
cF90eC50eF9jYXBzLA0KPiArCQkJCSAgSERDUF8yXzJfVFhDQVBTX0xFTik7DQo+ICsNCj4gKwkJ
cmV0ID0gdHJ1ZTsNCj4gKwkJRFBUWEhEQ1BNU0coIjIueDogSERDUF8yXzJfQUtFX0luaXQgIVxu
Iik7DQo+ICsJCWJyZWFrOw0KPiArDQo+ICsJY2FzZSBIRENQXzJfMl9BS0VfTk9fU1RPUkVEX0tN
Og0KPiArCQlkcm1fZHBfZHBjZF93cml0ZSgmbXRrX2RwLT5hdXgsDQo+IERQX0hEQ1BfMl8yX1JF
R19FS1BVQl9LTV9PRkZTRVQsDQo+ICsJCQkJICBoZGNwX2luZm8tDQo+ID5oZGNwMl9pbmZvLmhk
Y3BfdHgubm9fc3RvcmVkX2ttLmVfa3B1Yl9rbSwNCj4gKwkJCQkgIEhEQ1BfMl8yX0VfS1BVQl9L
TV9MRU4pOw0KPiArDQo+ICsJCXJldCA9IHRydWU7DQo+ICsNCj4gKwkJRFBUWEhEQ1BNU0coIjIu
eDogSERDUF8yXzJfQUtFX05PX1NUT1JFRF9LTSAhXG4iKTsNCj4gKwkJYnJlYWs7DQo+ICsNCj4g
KwljYXNlIEhEQ1BfMl8yX0FLRV9TVE9SRURfS006DQo+ICsJCWRybV9kcF9kcGNkX3dyaXRlKCZt
dGtfZHAtPmF1eCwNCj4gRFBfSERDUF8yXzJfUkVHX0VLSF9LTV9XUl9PRkZTRVQsDQo+ICsJCQkJ
ICBoZGNwX2luZm8tDQo+ID5oZGNwMl9pbmZvLmFrZV9zdG9yZWRfa20uZV9raF9rbV9tLA0KPiAr
CQkJCSAgSERDUF8yXzJfRV9LSF9LTV9MRU4pOw0KPiArCQlkcm1fZHBfZHBjZF93cml0ZSgmbXRr
X2RwLT5hdXgsDQo+IERQX0hEQ1BfMl8yX1JFR19NX09GRlNFVCwNCj4gKwkJCQkgIGhkY3BfaW5m
by0NCj4gPmhkY3AyX2luZm8uYWtlX3N0b3JlZF9rbS5lX2toX2ttX20gKw0KPiArCQkJCSAgSERD
UF8yXzJfRV9LSF9LTV9MRU4sDQo+ICsJCQkJICBIRENQXzJfMl9FX0tIX0tNX01fTEVOIC0NCj4g
SERDUF8yXzJfRV9LSF9LTV9MRU4pOw0KPiArDQo+ICsJCXJldCA9IHRydWU7DQo+ICsNCj4gKwkJ
RFBUWEhEQ1BNU0coIjIueDogRFBUWF9IRENQXzJfMl9BS0VfU1RPUkVEX0tNICFcbiIpOw0KPiAr
CQlicmVhazsNCj4gKw0KPiArCWNhc2UgSERDUF8yXzJfTENfSU5JVDoNCj4gKwkJZHJtX2RwX2Rw
Y2Rfd3JpdGUoJm10a19kcC0+YXV4LA0KPiBEUF9IRENQXzJfMl9SRUdfUk5fT0ZGU0VULA0KPiAr
CQkJCSAgaGRjcF9pbmZvLQ0KPiA+aGRjcDJfaW5mby5oZGNwX3R4LmxjX2luaXQucl9uLCBIRENQ
XzJfMl9STl9MRU4pOw0KPiArDQo+ICsJCWhkY3BfaW5mby0+aGRjcDJfaW5mby5yZWFkX2xfcHJp
bWUgPSB0cnVlOw0KPiArCQlyZXQgPSB0cnVlOw0KPiArDQo+ICsJCURQVFhIRENQTVNHKCIyLng6
IEhEQ1BfMl8yX0xDX0lOSVQgIVxuIik7DQo+ICsJCWJyZWFrOw0KPiArDQo+ICsJY2FzZSBIRENQ
XzJfMl9TS0VfU0VORF9FS1M6DQo+ICsJCWRybV9kcF9kcGNkX3dyaXRlKCZtdGtfZHAtPmF1eCwN
Cj4gRFBfSERDUF8yXzJfUkVHX0VES0VZX0tTX09GRlNFVCwNCj4gKwkJCQkgIGhkY3BfaW5mby0N
Cj4gPmhkY3AyX2luZm8uaGRjcF90eC5zZW5kX2Vrcy5lX2RrZXlfa3MsDQo+ICsJCQkJICBIRENQ
XzJfMl9FX0RLRVlfS1NfTEVOKTsNCj4gKwkJZHJtX2RwX2RwY2Rfd3JpdGUoJm10a19kcC0+YXV4
LA0KPiBEUF9IRENQXzJfMl9SRUdfUklWX09GRlNFVCwNCj4gKwkJCQkgIGhkY3BfaW5mby0NCj4g
PmhkY3AyX2luZm8uaGRjcF90eC5zZW5kX2Vrcy5yaXYsIEhEQ1BfMl8yX1JJVl9MRU4pOw0KPiAr
DQo+ICsJCWhkY3BfaW5mby0+aGRjcDJfaW5mby5rc19leGNoYW5nZV9kb25lID0gdHJ1ZTsNCj4g
Kw0KPiArCQlyZXQgPSB0cnVlOw0KPiArCQlEUFRYSERDUE1TRygiMi54OiBIRENQXzJfMl9TS0Vf
U0VORF9FS1MgIVxuIik7DQo+ICsJCWJyZWFrOw0KPiArDQo+ICsJY2FzZSBIRENQXzJfMl9TVFJF
QU1fVFlQRToNCj4gKwkJZHJtX2RwX2RwY2Rfd3JpdGUoJm10a19kcC0+YXV4LA0KPiBEUF9IRENQ
XzJfMl9SRUdfU1RSRUFNX1RZUEVfT0ZGU0VULA0KPiArCQkJCSAgaGRjcF9pbmZvLQ0KPiA+aGRj
cDJfaW5mby5oZGNwX3R4LnN0cmVhbV9pZF90eXBlLCAxKTsNCj4gKw0KPiArCQlyZXQgPSB0cnVl
Ow0KPiArCQlEUFRYSERDUE1TRygiSERDUDJfTVNHX0RQX1NUUkVBTV9UWVBFICFcbiIpOw0KPiAr
CQlicmVhazsNCj4gKw0KPiArCWNhc2UgSERDUF8yXzJfUkVQX1NFTkRfQUNLOg0KPiArCQlkcm1f
ZHBfZHBjZF93cml0ZSgmbXRrX2RwLT5hdXgsDQo+IERQX0hEQ1BfMl8yX1JFR19WX09GRlNFVCwN
Cj4gKwkJCQkgIGhkY3BfaW5mby0NCj4gPmhkY3AyX2luZm8uaGRjcF90eC5zZW5kX2Fjay52LA0K
PiArCQkJCSAgSERDUF8yXzJfVl9QUklNRV9IQUxGX0xFTik7DQo+ICsNCj4gKwkJcmV0ID0gdHJ1
ZTsNCj4gKwkJRFBUWEhEQ1BNU0coIjIueDogSERDUF8yXzJfU0VORF9BQ0sgIVxuIik7DQo+ICsJ
CWJyZWFrOw0KPiArDQo+ICsJY2FzZSBIRENQXzJfMl9SRVBfU1RSRUFNX01BTkFHRToNCj4gKwkJ
ZHJtX2RwX2RwY2Rfd3JpdGUoJm10a19kcC0+YXV4LA0KPiBEUF9IRENQXzJfMl9SRUdfU0VRX05V
TV9NX09GRlNFVCwNCj4gKwkJCQkgIGhkY3BfaW5mby0NCj4gPmhkY3AyX2luZm8uaGRjcF90eC5z
dHJlYW1fbWFuYWdlLnNlcV9udW1fbSwNCj4gKwkJCQkgIEhEQ1BfMl8yX1NFUV9OVU1fTEVOKTsN
Cj4gKwkJZHJtX2RwX2RwY2Rfd3JpdGUoJm10a19kcC0+YXV4LA0KPiBEUF9IRENQXzJfMl9SRUdf
S19PRkZTRVQsDQo+ICsJCQkJICBoZGNwX2luZm8tPmhkY3AyX2luZm8uaGRjcF90eC5rLA0KPiBI
RENQMl9LX0xFTik7DQo+ICsJCWRybV9kcF9kcGNkX3dyaXRlKCZtdGtfZHAtPmF1eCwNCj4gRFBf
SERDUF8yXzJfUkVHX1NUUkVBTV9JRF9UWVBFX09GRlNFVCwNCj4gKwkJCQkgIGhkY3BfaW5mby0N
Cj4gPmhkY3AyX2luZm8uaGRjcF90eC5zdHJlYW1faWRfdHlwZSwNCj4gKwkJCQkgIEhEQ1AyX1NU
UkVBTUlEX1RZUEVfTEVOKTsNCj4gKw0KPiArCQlkcF90eF9oZGNwMl9maWxsX3N0cmVhbV90eXBl
KGhkY3BfaW5mbywgaGRjcF9pbmZvLQ0KPiA+aGRjcDJfaW5mby5zdHJlYW1faWRfdHlwZSk7DQo+
ICsNCj4gKwkJcmV0ID0gdHJ1ZTsNCj4gKwkJRFBUWEhEQ1BNU0coIjIueDogSERDUF8yXzJfU1RS
RUFNX01BTkFHRSAhXG4iKTsNCj4gKwkJYnJlYWs7DQo+ICsNCj4gKwlkZWZhdWx0Og0KPiArCQlE
UFRYSERDUE1TRygiMi54OiBJbnZhbGlkIEhEQ1AyX09mZlNFVEFERFJfV3JpdGVNZXNzYWdlDQo+
ICFcbiIpOw0KPiArCQlicmVhazsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0K

