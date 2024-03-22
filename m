Return-Path: <linux-kernel+bounces-111171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7F8868AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E212A288C66
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1611C6AB;
	Fri, 22 Mar 2024 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Th072qmU";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QUhB8t8Q"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF818EB9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097846; cv=fail; b=K00odSyQlxZuMpDcl3yf+GncQUKKX2qRBVxYyU1rtKgZd8Tbj5RKow+4d9i0m4cCKgSf9u/sWrc16JTc7BZyIiJwb7shCYwcExNmnvUYUa0SMATMMvBIVoocn2wUSwN7M3aZS73f/CdmCBllq+j3lNs4GAt6GtIlIO16ygcGrf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097846; c=relaxed/simple;
	bh=y93COKfMsv04qr+QQZMP+3e90TGCw0CQgDGRJywz/q4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NuZGuaM8Plphusy2qNaE3e1Tyw0JEZrOWyNRJkemg4Ze9VpVzSFEy1jZWzMX7uoGIXbMFqRiRyjQCYqvuwXtyF3ilsQGozrO+jI+FsE8UoEFO4HzDl1DCeP0+25qeDm+zYI4rlqQ3TgSzORJaJ0P7GtsQ0YR10QChxIQPRNVYd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Th072qmU; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QUhB8t8Q; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2ff7939ce82a11ee935d6952f98a51a9-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=y93COKfMsv04qr+QQZMP+3e90TGCw0CQgDGRJywz/q4=;
	b=Th072qmUnZtm91vJLFc/VRnNghUtlDpvIcmf+ySItzVL7DzBMIBZsY/S4EMrsXG7j1sBOuFeE4tNNuFrtmcA7ZTKpq/baasYIL4iX9P+MZlyzEAav5Inf3C33QhGS9+JNGH51/uB1Oo2D35ntBAIz/WHo7zWMKjQ6k5fE7foD8s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:49810c5b-a684-4fab-bde8-ce4eeb9138d0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c5ec3300-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2ff7939ce82a11ee935d6952f98a51a9-20240322
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 388366145; Fri, 22 Mar 2024 16:57:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 16:57:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 16:57:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f44j1q7JTjaq9Hh6FVGvF0dguO0jASsdlBnszU2Smy8eOutETtlfguAh7wYeQbABp2GH4hMDFC69qYz9QFPtz2+hcMOcBLiCdvyqMGu6u6Bem6rNJ9gs+VVONQiNfp3Trg5UXEmmP8U3P8Cqv9+RRBanxlkFuyr7y38w3ckE6sAyW/qK1Yq8+V1heJHti8vQr7yqeELtnzjlFEfM7if/rmIKFolBMvDMzk+GFD2uw2veirTSfub7pzFLVQxpMHioqC7c1rcRAmv4WGfkh6F0jC0xPoNg3gnrfR7R4VWBx+IJvte2uchqjcrg5Zz3g2xVyZmibJevT4Bcr6tcwJ5XSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y93COKfMsv04qr+QQZMP+3e90TGCw0CQgDGRJywz/q4=;
 b=Kc4koqe4TNw1/sDbKbYj9VIqILZr4MTH5rgsKbkn3dmswdgp87JMQ4zbQYduq09e+2tnwHcFuY4Z6pfYRrfzeaUiwkowGgsv92Bqt6KgSmEeJdBizy9S1jkdZZyQYbeMN3MB9drAXJDjv3ymKCO32Kk74eNqqH6FqMbPe+/+TdD9sGcA1NeGlW0pLCdv/fvYLhYQy0qu+fUCeDsHBixBzbnCqP/52fejkWjnDdL5OtZmubBNZ2YE3g66+mfXCT96Gmkl2vGU/gP/PzkzPdDSVkdcUYGp+RCkW+bSfYPf2Dx+HNiuo6BSU+LxC+QXAGPs9dXX6MWWhmUWyqdadODVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y93COKfMsv04qr+QQZMP+3e90TGCw0CQgDGRJywz/q4=;
 b=QUhB8t8QPhFFFB1GRko/731+mzWNTdTNeOJ0SV5WbeA2noV+NmG+lmnu3jYCziFtemiusDl2cL5/7x0DfZ6A+925SP8WwT2VjiI97VtkJKF4z+wQBmzRISczNSoNclBYDXCuyxuuh5ClWiEXjRepvzs5HXWk/7hCaMqydDZ6n4M=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB9096.apcprd03.prod.outlook.com (2603:1096:405:db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 08:57:14 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 08:57:14 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "kernel@collabora.com"
	<kernel@collabora.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	=?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/3] drm/mediatek: drm_ddp_comp: Add
 mtk_ddp_is_simple_comp() internal helper
Thread-Topic: [PATCH 3/3] drm/mediatek: drm_ddp_comp: Add
 mtk_ddp_is_simple_comp() internal helper
Thread-Index: AQHaVQ2pRdVwz+/UpEitDOuNRhxQxrFDw8GA
Date: Fri, 22 Mar 2024 08:57:14 +0000
Message-ID: <8de69b0bb56a36374a9dac87da9bbd6ea3143a7e.camel@mediatek.com>
References: <20240201125304.218467-1-angelogioacchino.delregno@collabora.com>
	 <20240201125304.218467-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240201125304.218467-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB9096:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYd5RPhhWoyqVRsB8iWUpy8245tC55V3TPwGDpUH8apgAG1/mqwNAAn5M66DpM4MoSRuXJKJ/SNDKgt5OFPr3NOVwlZy+UM+zCqe/zihHQPztfQ7VnJREQTWj9RZadpPzpzj01DzLRi/uQ5ANMaJ+ER0x9/tX/tjflqw0IFPSJ+eOsS4XFuVlDcIlW06mRwGyVcqbYWIuNflUClHGZLm0Pj0t8IkP6bPm7vjTekX2ogZpkXYwEA2EmwPAqzPvf6e61syD2XDA5m8E6RlTXhvYe0S1Y9UEB3ZOR/rYinjOsFlo1YcoflVwLJp4pKtdDtWRDTksjbrsidgTZoEFsdjEaLueSFw+2rHikOUu8EGum4MdBFeLBNH9tla19GwTMHz58p9XlzUG5WvmnNGFKllJcqoDwcKwCfrdXVH2xi5MUSZ4vWsgHjaUPE5QOv2NytoI5Xqkdp6JspBzV0MSsOs2yPSy11+47/TMhaTkZJzz5XXFfCFRoRuTFosk4wnktqdKsnEKfwTriEAiSSl1V7+pPrs/VU9eXgbDeyWyZvpkZJ0GQNPSCBiC+f2BXblg/kMEHKlwYSlN8UZw+kWDzYYizdV+3sRte2P93kww9iScA+GOc8jYTfKofac7pboLC0awnCwUakK/w2xq7meuo9AIMs+IOpk4aO4Lnh/doepMPg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjF1aDN4c1dqRHM0SmozbE1xMDZnMUE4SEdqY2RvU25RUjFjNC9Bb1FwWVhL?=
 =?utf-8?B?SDlaWWJVOTBpZVB6WXFpbTlQcmJPV2I1czQ3aG00U0ZzZzFKUUd6SGhEL3VV?=
 =?utf-8?B?TU5MTkpTZDNDc0ZUYnYrWi9WeFRhM0xUUVEvb2lGTkZZbWwwMGdpVFVHNGZ5?=
 =?utf-8?B?NUNzZjIyVjZSUXl0QzV5MXRkcmZLQzZVKzg4ZW1LV3pHZ1o3a2VSWnpQQlhr?=
 =?utf-8?B?V3hCdHZtKzJrZHQyMUgyRHdlT3NhT3JPNzVjVUpjOVdUelhpTEo5MmV5anJ6?=
 =?utf-8?B?VzJXNm02eS9Yc0Z2QjNiczNTYWhBbzJPZUF6b05mTmVGS1JzVCthZzlScHVj?=
 =?utf-8?B?U2U5RW5QQW5jVm1xVzdhWmtPTWt1ZkgyTndLeTk4NlhJd1N6dnVMZWlBTzIx?=
 =?utf-8?B?TU5LOVFDL2wrbGV4NmZEQVQ1QmtXcGdvMEpqVGZkdDhmdnhKdys4Y0NXMHc1?=
 =?utf-8?B?cE12Z0dnSGlQMzJYY0dWOGJlWmpoT0htS0gwNEF5SkFUV3NUQzBXcHJUOW9H?=
 =?utf-8?B?MC9UWHg4MmxVaFBEN3ZXbEYrVHhhazhJMUt3SGMwM05mVTJVOGRNdk1JbFpR?=
 =?utf-8?B?c0kzREJneE4vaHdnYVl5OVdhUXYzaGdENnRaL1NDQXg1U0IzbHFFMC9lMFpn?=
 =?utf-8?B?MEltZWRpUjdnUldyOERrbGNVN1laUjBweUh4MTllK3JiQ3lybzdRU1owbDVh?=
 =?utf-8?B?RGtrcFNDbDlBYklLdHgwbFoyLzlFU0FlQVVQVFBReFNwcmxyNzc0ZU5CdG9x?=
 =?utf-8?B?L1p5SnFiOUM5N20xRmN2d0M1bXByN25UdDByNFAwMjV2enlDaUR5VzZYS1hp?=
 =?utf-8?B?ZENvdUUrM204a3pYQi8xTjZtelAzNmpIc01xdkNtNmxjZ3VhRWR2SjdRQ013?=
 =?utf-8?B?VXMydXRDRXU1K3NLWlZhd2dMSWFnQWhVOVZCcm5kUzNXYkJ0TjlkYUhXTG1r?=
 =?utf-8?B?L1dya0pSbGt4RG8vank1VUI3ME9pakx0ZkptT1ljczVwTzVTZGdPVWhyYzgv?=
 =?utf-8?B?cjRDTTRxRGI4QWw0ZGs2S3NxMEFTVG9HRjliUkxNdWVaRG9SYXBFYVdqRjFM?=
 =?utf-8?B?alZ5OFF5QjNTNmptWHdiTW9KUFJDNXJzR1JPaHZrOUcxNFdXTStWMWR1Wldn?=
 =?utf-8?B?Y1J5cEhBMm42bjByWWluRHJsaGdEWjFEZFJ6N294cTY3aVdadFBYd1hnVGFv?=
 =?utf-8?B?SExBeStmKzIxSHF6WFNWM3lYSDFFWFQ3czJHcjJ5dDBHNnF5VDZBaURpMGpz?=
 =?utf-8?B?alZJWGNubTlnd2lFd1lkQjNWcUVxVXA3RUVNeW1SdkJ3YWF6RGloN04xNmVa?=
 =?utf-8?B?T3ZkYlUrRXV2bGI0Z0pIaTZlMkJKaHB3OVlJb293cmhDdURiRWZrN1p0UGdH?=
 =?utf-8?B?Z3pnK1dpYnlnVjVNNnpMWHN2YUhEWFpsS0VDOGdwNHhxckRzdnJHeXd5WjE3?=
 =?utf-8?B?OUZxN3pqUmZqVjJ3SmVLODMzNysyVUVQVVUwSTBjL1FseEQ3STNYM3ViK0Fk?=
 =?utf-8?B?WDhZK1ZYM0ZXZ1dNU3B2NG83SzluaGFpSHJvdHBKNGlScDFRSkZDN205bWpj?=
 =?utf-8?B?cG5uUmM2NFpHQ0RqNDZoT210YitFR0JIUlVYdzZNVUtkSFBRcXlyVU5qRmQ5?=
 =?utf-8?B?VWhVUXZNanZhQVNFYjJqbVZNc21XZVU3UlRGWDk4VHNKRGcralVaeDEvTnAv?=
 =?utf-8?B?RVR4Wkh0dU50bGd2dGVwcE9jQlJFR0dwQmQvaWkycitPNjdZbVZueGUwVTdM?=
 =?utf-8?B?RGVFeUE0WE9nYmNGT0lQT1c0ZEdxRjBMcHNuWWNvOFcxaFJTbndLZHhxNnQ1?=
 =?utf-8?B?MFZLRnU0M0xiQlBwdFdUMkVLbzl5WlN1bzN1cVlSZGZUVGd5bWJ3d3d5TkJS?=
 =?utf-8?B?SjZjeU8zRUNiQmh6ckhLbXJ5ZGc2alE2UmQ1SHFtSWhKOVFiQWQ1cFYyR3RY?=
 =?utf-8?B?akZYVjlGeDVYbmhmSlF2OUkwVXZVaE9qZjdIZVIwYXFzb2Nha3NlWDBiTCtB?=
 =?utf-8?B?b3Bsb1ZWMmJCN25pNHBlTEVmcVlvQmh0bU1TTTg0b3l2WUNYVDlWckJtWmov?=
 =?utf-8?B?U3hQYVhFc1ZoeDFIdXVaU082NHNrcUJySWFmVnM0K2h6Mk03RG50MElRTVc4?=
 =?utf-8?Q?wJLBD7vYYlRNX/jr5SA9Kut9Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <182986F103D6E247A7682C1DBE202EBA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069c673e-c4d1-4dcf-99da-08dc4a4e118e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 08:57:14.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEZdK8ZHcVv4/hELppoeZCGMLw3KoQPoJWCxrtB/VgahRG7Oc/rbZ1mnr6J19Gu6SJ+2xJ01lV68QhLSyvyD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB9096
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.889400-8.000000
X-TMASE-MatchedRID: scwq2vQP8OHoSitJVour/UD6z8N1m1ALjLOy13Cgb4+iUP5F9sCEMHWC
	d6QvVzbec7qzI+uYRDhc7/JU/kbLPiUtdpGicV4RA9lly13c/gEK3n1SHen81QqiCYa6w8tvgSk
	lFxt6Wp1TbZQcBI0zQonn/zXNcpP/sn/vLFz1kV/NkY5AMBHm58nlJe2gk8vIBlt4RZwvTdWvek
	lZ9sa6cQWTjR3U9Qe5H87q17mgoOqvvxILmKK/HNIFVVzYGjNKWQy9YC5qGvz6APa9i04WGCq2r
	l3dzGQ1FdpkPxxOT27DcOlGCl8B4CoTtL1M6a222OqjJjDGQc/RU+S57ZpPJw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.889400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	6F94DB207CC8949D1286B52A9DB71AD8109D018BDDD78B20406D23A8521B85D22000:8

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTAyLTAxIGF0IDEzOjUzICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTW92ZSB0aGUgc2ltcGxlIGNvbXBvbmVudCBj
aGVjayB0byBhIG5ldyBtdGtfZGRwX2lzX3NpbXBsZV9jb21wKCkNCj4gaW50ZXJuYWwgaGVscGVy
IHRvIHJlZHVjZSBjb2RlIGR1cGxpY2F0aW9uLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1
QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyB8IDU3
ICsrKysrKysrKysrLS0tLS0tDQo+IC0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRp
b25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBpbmRleCA1MzliNTI2YTZiMGEuLjRjYTJhMDJhZGEz
YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2Nv
bXAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5j
DQo+IEBAIC01NzUsNiArNTc1LDI5IEBAIHVuc2lnbmVkIGludA0KPiBtdGtfZHJtX2ZpbmRfcG9z
c2libGVfY3J0Y19ieV9jb21wKHN0cnVjdCBkcm1fZGV2aWNlICpkcm0sDQo+ICAJcmV0dXJuIHJl
dDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGJvb2wgbXRrX2RkcF9pc19zaW1wbGVfY29tcChlbnVt
IG10a19kZHBfY29tcF90eXBlIHR5cGUpDQo+ICt7DQo+ICsJc3dpdGNoICh0eXBlKSB7DQo+ICsJ
Y2FzZSBNVEtfRElTUF9BQUw6DQo+ICsJY2FzZSBNVEtfRElTUF9CTFM6DQo+ICsJY2FzZSBNVEtf
RElTUF9DQ09SUjoNCj4gKwljYXNlIE1US19ESVNQX0NPTE9SOg0KPiArCWNhc2UgTVRLX0RJU1Bf
R0FNTUE6DQo+ICsJY2FzZSBNVEtfRElTUF9NRVJHRToNCj4gKwljYXNlIE1US19ESVNQX09WTDoN
Cj4gKwljYXNlIE1US19ESVNQX09WTF8yTDoNCj4gKwljYXNlIE1US19ESVNQX09WTF9BREFQVE9S
Og0KPiArCWNhc2UgTVRLX0RJU1BfUFdNOg0KPiArCWNhc2UgTVRLX0RJU1BfUkRNQToNCj4gKwlj
YXNlIE1US19EUF9JTlRGOg0KPiArCWNhc2UgTVRLX0RQSToNCj4gKwljYXNlIE1US19EU0k6DQo+
ICsJCXJldHVybiBmYWxzZTsNCj4gKwlkZWZhdWx0Og0KPiArCQlyZXR1cm4gdHJ1ZTsNCj4gKwl9
DQo+ICt9DQo+ICsNCj4gIGludCBtdGtfZGRwX2NvbXBfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5vZGUsIHN0cnVjdCBtdGtfZGRwX2NvbXANCj4gKmNvbXAsDQo+ICAJCSAgICAgIHVuc2lnbmVk
IGludCBjb21wX2lkKQ0KPiAgew0KPiBAQCAtNjA1LDE5ICs2MjgsMTMgQEAgaW50IG10a19kZHBf
Y29tcF9pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSwNCj4gc3RydWN0IG10a19kZHBfY29t
cCAqY29tcCwNCj4gIAl9DQo+ICAJY29tcC0+ZGV2ID0gJmNvbXBfcGRldi0+ZGV2Ow0KPiAgDQo+
IC0JaWYgKHR5cGUgPT0gTVRLX0RJU1BfQUFMIHx8DQo+IC0JICAgIHR5cGUgPT0gTVRLX0RJU1Bf
QkxTIHx8DQo+IC0JICAgIHR5cGUgPT0gTVRLX0RJU1BfQ0NPUlIgfHwNCj4gLQkgICAgdHlwZSA9
PSBNVEtfRElTUF9DT0xPUiB8fA0KPiAtCSAgICB0eXBlID09IE1US19ESVNQX0dBTU1BIHx8DQo+
IC0JICAgIHR5cGUgPT0gTVRLX0RJU1BfTUVSR0UgfHwNCj4gLQkgICAgdHlwZSA9PSBNVEtfRElT
UF9PVkwgfHwNCj4gLQkgICAgdHlwZSA9PSBNVEtfRElTUF9PVkxfMkwgfHwNCj4gLQkgICAgdHlw
ZSA9PSBNVEtfRElTUF9QV00gfHwNCj4gLQkgICAgdHlwZSA9PSBNVEtfRElTUF9SRE1BIHx8DQo+
IC0JICAgIHR5cGUgPT0gTVRLX0RQSSB8fA0KPiAtCSAgICB0eXBlID09IE1US19EUF9JTlRGIHx8
DQo+IC0JICAgIHR5cGUgPT0gTVRLX0RTSSkNCj4gKwkvKg0KPiArCSAqIFJlc291cmNlcyBmb3Ig
c2ltcGxlIGNvbXBvbmVudHMgYXJlIHJldHJpZXZlZCBoZXJlIGFzIHRob3NlDQo+IGFyZQ0KPiAr
CSAqIG1hbmFnZWQgaW4gaGVyZSB3aXRob3V0IHRoZSBuZWVkIG9mIG1vcmUgY29tcGxleCBkcml2
ZXJzOw0KPiBmb3INCj4gKwkgKiB0aGUgbGF0dGVyLCB0aGVpciByZXNwZWN0aXZlIHByb2JlIGZ1
bmN0aW9uIHdpbGwgZG8gdGhlIGpvYiwNCj4gc28NCj4gKwkgKiB3ZSBtdXN0IGF2b2lkIGdldHRp
bmcgdGhlaXIgcmVzb3VyY2VzIGhlcmUuDQo+ICsJICovDQo+ICsJaWYgKCFtdGtfZGRwX2lzX3Np
bXBsZV9jb21wKHR5cGUpKQ0KPiAgCQlyZXR1cm4gMDsNCj4gIA0KPiAgCXByaXYgPSBkZXZtX2t6
YWxsb2MoY29tcC0+ZGV2LCBzaXplb2YoKnByaXYpLCBHRlBfS0VSTkVMKTsNCj4gQEAgLTY1MSwx
OSArNjY4LDcgQEAgdm9pZCBtdGtfZGRwX2NvbXBfZGVzdHJveShzdHJ1Y3QgbXRrX2RkcF9jb21w
DQo+ICpjb21wKQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gIAkvKiBDb21wbGV4IGNvbXBvbmVudHMg
YXJlIGRlc3Ryb3llZCB3aXRoIHRoZWlyIG93biByZW1vdmUNCj4gY2FsbGJhY2sgKi8NCj4gLQlp
ZiAodHlwZSA9PSBNVEtfRElTUF9BQUwgfHwNCj4gLQkgICAgdHlwZSA9PSBNVEtfRElTUF9CTFMg
fHwNCj4gLQkgICAgdHlwZSA9PSBNVEtfRElTUF9DQ09SUiB8fA0KPiAtCSAgICB0eXBlID09IE1U
S19ESVNQX0NPTE9SIHx8DQo+IC0JICAgIHR5cGUgPT0gTVRLX0RJU1BfR0FNTUEgfHwNCj4gLQkg
ICAgdHlwZSA9PSBNVEtfRElTUF9NRVJHRSB8fA0KPiAtCSAgICB0eXBlID09IE1US19ESVNQX09W
TCB8fA0KPiAtCSAgICB0eXBlID09IE1US19ESVNQX09WTF8yTCB8fA0KPiAtCSAgICB0eXBlID09
IE1US19ESVNQX1BXTSB8fA0KPiAtCSAgICB0eXBlID09IE1US19ESVNQX1JETUEgfHwNCj4gLQkg
ICAgdHlwZSA9PSBNVEtfRFBJIHx8DQo+IC0JICAgIHR5cGUgPT0gTVRLX0RQX0lOVEYgfHwNCj4g
LQkgICAgdHlwZSA9PSBNVEtfRFNJKQ0KPiArCWlmICghbXRrX2RkcF9pc19zaW1wbGVfY29tcCht
dGtfZGRwX21hdGNoZXNbY29tcC0+aWRdLnR5cGUpKQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gIAlw
cml2ID0gZGV2X2dldF9kcnZkYXRhKGNvbXAtPmRldik7DQo=

