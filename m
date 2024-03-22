Return-Path: <linux-kernel+bounces-111156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7667886876
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684931F213FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052121863B;
	Fri, 22 Mar 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VAJ18TKn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="EyIWRfZS"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246113AC4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097348; cv=fail; b=OSPUygXgUeVca7n99/oXvlZtp7ZCrHmKPAhlUEqs7pcRF2MjhwUiTtGIy3V4OFsEaZdJNqIcrZlfgCkTPLxIEJmbk8E88lTB/cVdXzRFloZMu2ZzhnGe53lOlqASu2H8crser8jA5DZZLboXXtdixYoVpL+z8QdTshcPIupVhrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097348; c=relaxed/simple;
	bh=Xz7rznxGLbCt+ETqeRU8TMpn3HG8aBhUbNhlsRjDo1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FlYRHZifbmlLI5GFCG/zKY2iYe+JnbS1MYOYYBfmuUtT3RJLBV3tvNCG50SlxczWFKXc8m3k4bt1LIJDg9DSwPRIDTniuPRHeA+PZ8xufLuCGMPCJO9eUpdu0nfO4BVAE1aSiTjesIEEFPCY0lYhhNVJCS392sPICvraRrEVoxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VAJ18TKn; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=EyIWRfZS; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 05a77f0ee82911eeb8927bc1f75efef4-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Xz7rznxGLbCt+ETqeRU8TMpn3HG8aBhUbNhlsRjDo1Y=;
	b=VAJ18TKnM22m2oENp+8mN28vGsVlW0ZE2435ROrkZkKTTPUPBR4uh0H7tn7QTzKoRKPbeeOl5P4doRH3W/jcHVcKWP1bN3IyaolfAx5Tuk9vpSfWvKxFlvfNTRh1FFloFyHMid+sMNtbeCR81isx3iqlfHyAydAJlSN9I5aRQM4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:1a552751-4ef8-4308-a02d-9b56a0d8fac8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:d9434f85-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 05a77f0ee82911eeb8927bc1f75efef4-20240322
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 691402998; Fri, 22 Mar 2024 16:48:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 16:48:56 +0800
Received: from SG2PR03CU006.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 16:48:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2iI+uY7xckp2nfRtwaJLXKNGOi/wKvT6xbZC4XDiG4rmE4EluJL8XfRhASgmJA6SZFoBY9mTPYARCqkxGTxVAwHlQ6gzaWGGhO2V52YgLIj0pLMuc6KzLyQl9Xx9/V+XB1b0vcUiGdF8kWLlv3PN6QT6i9yEHX/Kg5hF4/7KWLRdORn9iAOLIzF5ibsFV3SpoTv1xS201XzQXpqOkQvolpuUkFAYj35rjYKuyhVguVnzEW9+m2x9YKbonUUUwJ5JXjHLBOJl54Kbgh3j6b6DWEJH/WbE5ZvW1IsPwbusMz33f8AHWLuJ7rTe6DsvUIm4MMYfciwWZ1C1lKE/21a+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xz7rznxGLbCt+ETqeRU8TMpn3HG8aBhUbNhlsRjDo1Y=;
 b=Yh1bnaN4t8tsWXAK2TcB0ycgaVlUTsRF7yUL+Ko5nnwwEt5TndIMU/jaXPr1qzbtzUvYA9qdI8gFbKoFMXZSu79G4lSaebpJ1HljEqEJySO8SPUOZ7IInuRY+A/Lv+AgqBDFGIsarL90IMfeaUphKsLaZqIAQNdc8jBBgyatrgWd3PJ9XDkLfGMDzXIiZ6EQ3ketR/de/uq1UtFEMu1RlIfFHSR3YZXrkDOzj0H3LCLZo9V45JoPR4Zofx51D9yEgHs/JcGdJzMpSCcULa6m7OO/ptSc3U1O76aw51o50R1zfbwm5uJxbPjZJr4nhRfddVY82U+5CIanTqhXF7ltLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz7rznxGLbCt+ETqeRU8TMpn3HG8aBhUbNhlsRjDo1Y=;
 b=EyIWRfZSCk6a1pj5ihweTAvp6UOXNiQqJ6oZIYRVnU7MCKJiyTGCbAxJrnWuR14tLfIjU690MyFzFQg+HTFKsG6P9rt34eNV+GkxbcL6TeeC50Ud1h7pBbkOdn6DNAa4bQ91oRQgFeH5GSBTFCgbbSSe/gVNsbSKtmt1r2JmIuk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8806.apcprd03.prod.outlook.com (2603:1096:405:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Fri, 22 Mar
 2024 08:48:53 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 08:48:53 +0000
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
Subject: Re: [PATCH 2/3] drm/mediatek: Perform iounmap on simple DDP component
 destruction
Thread-Topic: [PATCH 2/3] drm/mediatek: Perform iounmap on simple DDP
 component destruction
Thread-Index: AQHaVQ2oM95wEItPMkWi9kS/tGuFoLFDwW2A
Date: Fri, 22 Mar 2024 08:48:53 +0000
Message-ID: <4b5d172c9b169313aaec777158e2db697fe447fc.camel@mediatek.com>
References: <20240201125304.218467-1-angelogioacchino.delregno@collabora.com>
	 <20240201125304.218467-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240201125304.218467-3-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8806:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uLLZjF1cdTdz/dTFRvNrMb+scxovbA17a1ky08lU91AJp+5iJRT7CtJLX0lFppDXiO95ftl7p846k009itt/9XkC4L+1D8Z1powbhgCvJU00rutR5EfqPDfNNaWAeUXMjNwMvYiyobxRAlC9zE1Sz8zeKCJWtNfE2TKCkGw0rqCNUq+XQzT8CbcH6+nqnSBQWcDdK9lRDSTwd7hiFTA7PfqtH5iSxy1gvvkVukSfmFF2oj0qaNxEAxm2B5zSdKMTNAxVNBqkCImMFtmXhapShsigpOJqXNJnno2bZfrw6XE2E+Qy0gCPfSzL16Zp86IO7WRg6pew78mfkvefWHebPB23l6lx003dFhQdTxfQENTGqesR4WExZCO978YL6K3dHGSLMsZ4XvVXB85qItP259/Z7Rt9OS8fuAQnsiR2vy/bX/S2fxn//FxtFXH4YqhCgyUgWF/n1wj52HX9Ox/wR+V+MoIXNUgPrRV5WTkAVPpDPvW86yXtJQuWE+TKb830qIkuj4IuCLhPxXUw9S6M3WSISLNH/YHkcCvfjfP1v4cP39UQD+Y0dN7QdMOCxpawZCyAk7L+YpjJj4TtP+TqfNyq6DeBVl893xOBZ+kEKbvRTtJ+Dl7ixI/5rIHEY+U2NAp+wwfQ+NtvSd0epqObVgHzIngb5YXMaRfwn62yAoU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVVZQnhLL3d1QXZmSFNIVjFUYzR4UngvMEV3T01FSXRzOXR0Q2RvYVptN2ZL?=
 =?utf-8?B?V25BbHdJc0NhazMrdHhvbWxrVFpwd0ZFZFAvS1BtZWV1bzZLNDNZNmtrMlc4?=
 =?utf-8?B?UHlTRjdMM1VaVFBCSVhiTmlOWElzby9CTGhsRXdpUUQ3QUV4dkJBaWlYVUhW?=
 =?utf-8?B?WkkrWmt5cUpBRHlLSFIxYmxXNnFLS1ZqaFc4Vkk2eWJzTGZDS3pQL3JBUk1R?=
 =?utf-8?B?OUQ5NEpMZnIwS1ZyVWdwQWtvMGlibjUvN2IvSHVGWjEzUUxmcFFMUThFWk8y?=
 =?utf-8?B?RlA1Y0xLVHZGcGRYWEYzUmhGTm9oZUIrQUlqckJZRGx2ekMxd3pyZjBLVkEx?=
 =?utf-8?B?Q21jcytQN1JoUXVSMnBnWjluc1YzMmc1N2ZxSmZFQUNGelFycFZYZ1YxSnBF?=
 =?utf-8?B?ZnQ5aCtlTjljR1FLMDFEb2ZEdmNETGVjdHVyYUdMWmd1UUVwUVViOTZQNHRS?=
 =?utf-8?B?RUNqOTVxZy9mSWlRdHlESnZEZW1JaWpDWG94VHJ3Q2dSNmFqakdDbEJRNmd3?=
 =?utf-8?B?TzlZN00zejRZMWY5RDRBanF3S20rWmxSUWEreGpOSEtRbGM0NlIyTHBscG1F?=
 =?utf-8?B?UWVlYjJnN3B0Q0tBZC9ESmRlTEJhd0s4NkVGbFJaU2dSYk8yT3drL2tQQlEr?=
 =?utf-8?B?TG91d3FWYnFtQ1l4OElLN3hFUmJrRVYzUUtETU9iSElRcGJvVXB4SG95NzJJ?=
 =?utf-8?B?bk5vQ3FRTTJIeC9RRTluVzcvNlNKWVIzYjNZK2pMWDM4OXVqVUM2d3hUN1dl?=
 =?utf-8?B?SVplMWtycjVmSC9KSUgwcjkvTXNqKzZWVXdkeEdiOVZZWlZXeWlBS2lsOTdY?=
 =?utf-8?B?ZG9jNHV0Y0NFVUpVNXRsQmdXTk1uR2hYNzA5Rm0xa1JyMEZzYmVRQXlYSlZ3?=
 =?utf-8?B?aVpObDJZTVR5RmpIa3dqOEJQK0ZGS0t1ckJtN3JaOHhVNWxXT2hPQlJOaXdu?=
 =?utf-8?B?K0t0bk9obno1K2M5Y1ljaGc5djVHQmNWejhTTW5RdGxQY1A4SkdUcjlaaHB0?=
 =?utf-8?B?MFNES054cDRHeW56NnhWUnZxRU5zZFVNenNWcTIyRWU4QXBtanFSNlhKdnky?=
 =?utf-8?B?aTRrdDFzekovN0c3SXNIZVhpVnNxUVNsZS85NWdUd2FtNS9VOUFsbkdnTkpY?=
 =?utf-8?B?NE5JdGd1Y3lDaXg2a0VoOUZRUGtIazkzQVlHLzd4MUpzTUYyMnlDQkUxc0ZF?=
 =?utf-8?B?Ni9WM0l1WWhvWTFjUVdReUVMeFBud0I2RFQ5bFR0cVd0ZHBmcW9lREJhcVhT?=
 =?utf-8?B?NEFBdURoTUtMQisvS2FEUjBRZHpzZTlkTU5ycmo2K3dCekYwL3BPZVc0WDZo?=
 =?utf-8?B?bkllVFhxbzVvdHQ5UnhZUnAzWEVVUWc2cUJVeU1qUXhIemRJV0dTVDdpL2pa?=
 =?utf-8?B?M1kxNDBhZGE1U0hiOUlDL2EveGJyWFd5OWJLTUx0YzRKbGlvV29GWkxNeU0v?=
 =?utf-8?B?eVBac2tDdkdzdHVHTnd6Mlp4MC9qMjVoVU9kRHU0bkp5T3Jjd1M4YjBXQnVy?=
 =?utf-8?B?L2kwUUF0UXhxZXhZQkVXN1lhN0hKckJzNlZRNG9RaDVEVGpMQlh6Z0JkTjJS?=
 =?utf-8?B?b3BIUk13aVVCbWUyQ2w5aFNOQ2EzUVBPYTN5OUg4c1gvWlhXeS9ONXo5YSsr?=
 =?utf-8?B?d2tBb3paTDNqbWljNldaWGluaGxkMFRENVBhYWRqaFA4MzBIT3dNSXVhUHlS?=
 =?utf-8?B?RWUrQll0SmFVTGtjbWdWWnJMbm5ZSG1kcUdvV3h1TWcraWs0OGgybDhZV1U1?=
 =?utf-8?B?L3NtR1lPYUdJVGExT0tHMTE1ZnlIc3NTY1ljckZJcUdEbm1xajNGVjZtN2Va?=
 =?utf-8?B?emZicnRsN0tHTDh0SHFVNUVmc3FWQlJwL2FpTDdsNStYVFhCOUp0RUI3aUo5?=
 =?utf-8?B?c0NnREtETzU2U0hQUWZQY1FWZjdSWFBzbTVzRklxQWdoZWNRNElvQVBqUnFH?=
 =?utf-8?B?bUVmMm5QS016WGVMR05QbWU3NUVyc0xhSHdyMDluaEFSOUVRM2M2VHpjTjhY?=
 =?utf-8?B?anByUFZIWkJsbU1CaHphY2pKWDZWU0hiZlRZZldkblBxcmtheE5FMStTbFdi?=
 =?utf-8?B?bkV5ZmJOVWRHQzFxQ0dHdmM3aTBNeUlZU2ljcGthcEV3SWdrQlRVblNWeVFK?=
 =?utf-8?Q?8loyL8un08i6oRHvnlTxDVHFr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A9ACBDFA971FB47B2B2B5D912FEDAF9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244418d4-1e3b-402e-54fa-08dc4a4ce75a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 08:48:53.9147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rSjW/XDpDKL7lsnd3H8pnXRuNbGQIsaHGWbFalk6Gf/iUszWC1eIF+xewyTDRRKbyII4i0IsyqULAtlcHY8Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8806
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.807400-8.000000
X-TMASE-MatchedRID: VPleTT1nwdQNtKv7cnNXnSa1MaKuob8PC/ExpXrHizxcKZwALwMGs5xz
	8+1dXyV4hpv9C7a+dY66AcOfQyTZW3OErgCAgGZubc297PAGtWaeEP0DdJruliz+5QCTrE/s2ft
	v/5jXki9X6UIPOG+iLbpxDH0YWH+ICRueYusp1xzd+fuf9kcapu3+iQEtoSj4XaZ/Rba9vHHic9
	PyNm/U0eLzNWBegCW2PZex/kxUIHW3sNbcHjySQd0H8LFZNFG7bkV4e2xSge49ufFJBOEB/i6tY
	UFbougOyYa+7Z0yIEsIC0ANgox4jD6Qrn3xh/cy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.807400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E00BDBEF73B41523CD25955EB72321A798237D99D1F43C5237687EC00FB5246C2000:8

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTAyLTAxIGF0IDEzOjUzICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gQWRkIGEgbmV3IG10a19kZHBfY29tcF9kZXN0
cm95KCkgZnVuY3Rpb24gYW5kIGNhbGwgaXQgaW4gdGhlIHRlYXJkb3duDQo+IHBhdGggb2YgbXRr
X2RybV9kcnYgdG8gbWFrZSBzdXJlIHRoYXQgd2UgdW5tYXAgdGhlIGlvc3BhY2Ugb2YgdGhlDQo+
IHNpbXBsZSBERFAgY29tcG9uZW50cy4NCj4gDQo+IFdoaWxlIGF0IGl0LCBhbHNvIGZpeCBpb3Vu
bWFwcGluZyBvbiBtdGtfZGRwX2NvbXBfaW5pdCgpIGVycm9yIHBhdGguDQoNClJldmlld2VkLWJ5
OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBGaXhlczogZmYxMzk1NjA5ZTIw
ICgiZHJtL21lZGlhdGVrOiBNb3ZlIG10a19kZHBfY29tcF9pbml0KCkgZnJvbSBzdWINCj4gZHJp
dmVyIHRvIERSTSBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERl
bCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgMzgN
Cj4gKysrKysrKysrKysrKysrKysrKystDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9kZHBfY29tcC5oIHwgIDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZHJ2LmMgICAgICB8ICA0ICsrLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5jDQo+IGluZGV4IGMxMzM1OWVlYjNjZC4uNTM5YjUyNmE2YjBhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4g
QEAgLTYyNiw4ICs2MjYsMTEgQEAgaW50IG10a19kZHBfY29tcF9pbml0KHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbm9kZSwNCj4gc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCj4gIA0KPiAgCXByaXYt
PnJlZ3MgPSBvZl9pb21hcChub2RlLCAwKTsNCj4gIAlwcml2LT5jbGsgPSBvZl9jbGtfZ2V0KG5v
ZGUsIDApOw0KPiAtCWlmIChJU19FUlIocHJpdi0+Y2xrKSkNCj4gKwlpZiAoSVNfRVJSKHByaXYt
PmNsaykpIHsNCj4gKwkJaW91bm1hcChwcml2LT5yZWdzKTsNCj4gKwkJcHJpdi0+cmVncyA9IE5V
TEw7DQo+ICAJCXJldHVybiBQVFJfRVJSKHByaXYtPmNsayk7DQo+ICsJfQ0KPiAgDQo+ICAjaWYg
SVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4gIAlyZXQgPSBjbWRxX2Rldl9nZXRfY2xp
ZW50X3JlZyhjb21wLT5kZXYsICZwcml2LT5jbWRxX3JlZywgMCk7DQo+IEBAIC02MzksMyArNjQy
LDM2IEBAIGludCBtdGtfZGRwX2NvbXBfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsDQo+
IHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsDQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4g
Kw0KPiArdm9pZCBtdGtfZGRwX2NvbXBfZGVzdHJveShzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21w
KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZGRwX2NvbXBfZGV2ICpwcml2Ow0KPiArDQo+ICsJaWYg
KCFjb21wIHx8ICFjb21wLT5kZXYpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCS8qIENvbXBsZXgg
Y29tcG9uZW50cyBhcmUgZGVzdHJveWVkIHdpdGggdGhlaXIgb3duIHJlbW92ZQ0KPiBjYWxsYmFj
ayAqLw0KPiArCWlmICh0eXBlID09IE1US19ESVNQX0FBTCB8fA0KPiArCSAgICB0eXBlID09IE1U
S19ESVNQX0JMUyB8fA0KPiArCSAgICB0eXBlID09IE1US19ESVNQX0NDT1JSIHx8DQo+ICsJICAg
IHR5cGUgPT0gTVRLX0RJU1BfQ09MT1IgfHwNCj4gKwkgICAgdHlwZSA9PSBNVEtfRElTUF9HQU1N
QSB8fA0KPiArCSAgICB0eXBlID09IE1US19ESVNQX01FUkdFIHx8DQo+ICsJICAgIHR5cGUgPT0g
TVRLX0RJU1BfT1ZMIHx8DQo+ICsJICAgIHR5cGUgPT0gTVRLX0RJU1BfT1ZMXzJMIHx8DQo+ICsJ
ICAgIHR5cGUgPT0gTVRLX0RJU1BfUFdNIHx8DQo+ICsJICAgIHR5cGUgPT0gTVRLX0RJU1BfUkRN
QSB8fA0KPiArCSAgICB0eXBlID09IE1US19EUEkgfHwNCj4gKwkgICAgdHlwZSA9PSBNVEtfRFBf
SU5URiB8fA0KPiArCSAgICB0eXBlID09IE1US19EU0kpDQo+ICsJCXJldHVybjsNCj4gKw0KPiAr
CXByaXYgPSBkZXZfZ2V0X2RydmRhdGEoY29tcC0+ZGV2KTsNCj4gKwlpZiAoIXByaXYpDQo+ICsJ
CXJldHVybjsNCj4gKw0KPiArCWlmIChwcml2LT5yZWdzKSB7DQo+ICsJCWlvdW5tYXAocHJpdi0+
cmVncyk7DQo+ICsJCXByaXYtPnJlZ3MgPSBOVUxMOw0KPiArCX0NCj4gK30NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+IGluZGV4IDE1YjJlYWZm
ZjQzOC4uNDMzNzJiNDE2YTNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcF9jb21wLmgNCj4gQEAgLTMxOCw2ICszMTgsNyBAQCB1bnNpZ25lZCBpbnQNCj4g
bXRrX2RybV9maW5kX3Bvc3NpYmxlX2NydGNfYnlfY29tcChzdHJ1Y3QgZHJtX2RldmljZSAqZHJt
LA0KPiAgCQkJCQkJc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIGludCBtdGtfZGRwX2NvbXBfaW5p
dChzdHJ1Y3QgZGV2aWNlX25vZGUgKmNvbXBfbm9kZSwgc3RydWN0DQo+IG10a19kZHBfY29tcCAq
Y29tcCwNCj4gIAkJICAgICAgdW5zaWduZWQgaW50IGNvbXBfaWQpOw0KPiArdm9pZCBtdGtfZGRw
X2NvbXBfZGVzdHJveShzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wKTsNCj4gIGVudW0gbXRrX2Rk
cF9jb21wX3R5cGUgbXRrX2RkcF9jb21wX2dldF90eXBlKHVuc2lnbmVkIGludCBjb21wX2lkKTsN
Cj4gIHZvaWQgbXRrX2RkcF93cml0ZShzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0LCB1bnNpZ25l
ZCBpbnQgdmFsdWUsDQo+ICAJCSAgIHN0cnVjdCBjbWRxX2NsaWVudF9yZWcgKmNtZHFfcmVnLCB2
b2lkIF9faW9tZW0NCj4gKnJlZ3MsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2Rydi5jDQo+IGluZGV4IDE0YTFlMDE1N2NjNC4uODliNmMzMWExNTExIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBAQCAtOTQ0LDggKzk0NCwxMCBAQCBz
dGF0aWMgdm9pZCBtdGtfZHJtX3JlbW92ZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiAgCWNvbXBvbmVudF9tYXN0ZXJfZGVsKCZwZGV2LT5kZXYsICZtdGtfZHJtX29wcyk7DQo+
ICAJcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOw0KPiAgCW9mX25vZGVfcHV0KHByaXZh
dGUtPm11dGV4X25vZGUpOw0KPiAtCWZvciAoaSA9IDA7IGkgPCBERFBfQ09NUE9ORU5UX0RSTV9J
RF9NQVg7IGkrKykNCj4gKwlmb3IgKGkgPSAwOyBpIDwgRERQX0NPTVBPTkVOVF9EUk1fSURfTUFY
OyBpKyspIHsNCj4gKwkJbXRrX2RkcF9jb21wX2Rlc3Ryb3koJnByaXZhdGUtPmRkcF9jb21wW2ld
KTsNCj4gIAkJb2Zfbm9kZV9wdXQocHJpdmF0ZS0+Y29tcF9ub2RlW2ldKTsNCj4gKwl9DQo+ICB9
DQo+ICANCj4gIHN0YXRpYyBpbnQgbXRrX2RybV9zeXNfcHJlcGFyZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQo=

