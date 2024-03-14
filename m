Return-Path: <linux-kernel+bounces-102896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9E187B821
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F31F286C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0095D27E;
	Thu, 14 Mar 2024 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kaX13rde";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gZspkc4v"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B5523A;
	Thu, 14 Mar 2024 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399462; cv=fail; b=tLNWUCmiY4q01rq3BBnvMdMfJXUP/BuhflLjvBHR5/WZOlntdxmaiuuxjU9vOPWBdHTpfE+mMQFig8SkBMZkQgpLz9i0Yanmequ39SjYJ8RgPqZBQC2AQdm6oe/TT6v0zZn9y726UeTKBUFuvcGboYcT8jvDM0T+mKim0gYDcx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399462; c=relaxed/simple;
	bh=bmVdya/e7DUIpqGcURD3enzWlSLCiVbKxgcGbl03Xtg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rbrra2SVOolaPo6To4GqwyiFMZ1hYrEz2mzccYvTWf75QuwhN45fQ/fbYLFlwBfaAHiy4ZsnIXFrd5IcgSt8L6njM7NYEG/LnTVhO7T8O+0uKXlPwx9PWwaCHw2nU6+ATkmy/yqTkdVYS2DoJw0x5m3hg5/utuMIn2WPFuFIYPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kaX13rde; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gZspkc4v; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 227b1820e1d011ee935d6952f98a51a9-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bmVdya/e7DUIpqGcURD3enzWlSLCiVbKxgcGbl03Xtg=;
	b=kaX13rdegTh9payne5fAbA4g2np2EN6GugHyqQaosY9FLqr9dTfibvpMp4AaVQmoUpMN6it93JfJxWdjjPMqy4SgJuMtatBnEi8d3pDYqPxRE/WceKg3oul1lvOSNttzn2pc1zm3/x7jTJvgkH6oCtsJTumjaGYXKj3nAMzeYUc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:fbc3be0d-a348-4eda-88bb-9311157c7e7f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:be2a7d81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 227b1820e1d011ee935d6952f98a51a9-20240314
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 778972867; Thu, 14 Mar 2024 14:57:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 14:57:33 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 14:57:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USETxE2LjMDEDP4TdoTSIVH9DXb6yEsz7esPQo3FODnliuTx0rtLF7uX7mR/FxFwa4dO2N2BBrYu9WLKGb+Bdnz4tInqhs6/INJkEE0suoJ7waOGPADv158p00aPKTM7vOG57sQ750jqH+EW5r8TvcmJnBcBYpK36vU6kNyyLk2awXHseMRPR83sLFh3g2bXaoqFNOUZkm0YGqwfhSvH/39Ng7aRMzwqqKd3bmZd+6PYkJxQbPuk+HVynGljg4DwPViouiFJbS7WAGaUT+X8laiXIlqnGjhnu22Bnrj1M44gH2I5YVeSG+2ltEzzY1sQmGdWj2Pj+AcwRBV0Y8Rojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmVdya/e7DUIpqGcURD3enzWlSLCiVbKxgcGbl03Xtg=;
 b=ctrH4lejn4lZ2Xz8GrEKZqUQ6MqbZpEj1bl6roGiUn/zcx2Guc5Q8QJK76TWzttdZHuYmP/yA+Rr5Gsb4Qwjfc8xmtleddUQ763iFKgmRwE8mC8TmYuJHbXW9eFqKbY6ImfLcOMZ1Ab1miKR7g08kKPfXxn4LvbevGJjNSBoUwZVCzlEfPp1MWvCqCmnuLbJZyDXk/Jx19b5myLMBl3CkmCzAW3qyK983BOLxy/QaWRit0ma/U6ZjCYG4HgXeeLNIavwzoRDqpiIHMPew6WccQKG1K9lZfrjjGtAnglxbn605e1eFX9IbEaA6zEX5tkIGxOH3qDXaRA9cHxnEp27Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmVdya/e7DUIpqGcURD3enzWlSLCiVbKxgcGbl03Xtg=;
 b=gZspkc4vuVsu0yoHv3q7LGSyNV7iZpbxhxp8g/LD60uPRiLq9OC5iu6HsYvj07oGLM0QMEgrYf4gHcRGW4/P9D9QM1F4Q7A0sFQkL9qjnRO/cVTbv/LpU2x/KwpNcLWywefgWkEn5L9m6+cRlybcdl7l+5VbLp0oO0Y/E1889io=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6509.apcprd03.prod.outlook.com (2603:1096:4:1a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 06:57:31 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7362.031; Thu, 14 Mar 2024
 06:57:31 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
	"shawn.sung@mediatek.corp-partner.google.com"
	<shawn.sung@mediatek.corp-partner.google.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH 08/11] drm/mediatek: Rename files "mtk_drm_plane.*" to
 "mtk_plane.*"
Thread-Topic: [PATCH 08/11] drm/mediatek: Rename files "mtk_drm_plane.*" to
 "mtk_plane.*"
Thread-Index: AQHaaJFBdTOmnyIWqkGbAVEBr5TGnrE26KAA
Date: Thu, 14 Mar 2024 06:57:31 +0000
Message-ID: <beee956d5ab13d85643f1c2b28ca95ccd4bf8bc4.camel@mediatek.com>
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
	 <20240226085059.26850-9-shawn.sung@mediatek.com>
In-Reply-To: <20240226085059.26850-9-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6509:EE_
x-ms-office365-filtering-correlation-id: d42e57e1-9a28-44f9-e00a-08dc43f404d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o1pXtWVe7fEXDa+CuOq5HlbaQZb0bI8aDOWornMDm3oQZILTELnHGhK1aFnuMjtcMVldtTQegbCuawVcrpixiSPRkeZdDCCeOJtbsyRkS13/s5sRxtv69z+UykYmREcQai3dwxBPy1IxD3hyPG5T8uZv2cHzXIbogQ5f+YFlAnnJ7jSXrvR9W5nicd2Pmvc7oQY6SCMWLoXepQQ14rYrWcKtUjWUXPhR5Zgq0RKu9Vnb2WPrwDtsYE2isjnfCJ+XrHVbZz2Yl8hDVkW658oEOspJpgtuc6NCrIY3iSypuw5OEIziMh7DpyStIUy5Tg8o3nD/qpPGVp6knDv3v7NBOUsjAKfBiq0nSFJpFEUaptWdWeg0HaBq+gkDM/ThD6cez+2kCJJcDxZOuytmGipp1jXoUHSCIDo3fN61jWK1sE6yJifL4nuVBdwIrAqZYaCtt6BP0RxP3A9HsdYvS9s1SHtPP3fAOrDIAh5LEWLl2xc1qXEuXEGPM/CRmgpj+tQWREYVhm1FqSsMmrcJSwRWZAlhLNHMDC8oTQmoQzeO1MbVMXDasCn7IK0n4E0rFV4O5N6xMCAniS8DLXxTcXRl8DFxNdvbBFw2mWEHKe9xKp4/oqEW0SrFok5jeu99aL3I/cjSSEMF1T6PJ9SkyhOeBAzZDZNwwXB6ta2rnf3AEB88DWUlRQHP8/mq+YFjpY92ww6tJ2pVOWGXVIM2c6SajYCSHOVd59PhbIiKolmJGQU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmVBb3JvZGp1VXFoVkt5dDB6dVZ4b01Qc0ppMFlnRHVwbmdqY242b2dHRDBL?=
 =?utf-8?B?UnpKNW9RVUFGMUJwQ0dad0JiSkU1RUx6VUQvYzJ1dzZ3NTdVa2YyTjlOQURX?=
 =?utf-8?B?dlA3OGp1b00vbFF3Q1JYR29YQjJpYkljMEJYVE5ySysrdnF6aXloaFVaV241?=
 =?utf-8?B?d09EY3BWS3BoNXRXWVZ1RTREdTlYNi81QWwvYW1NZ0I3VjAzQjIvVkp6RFNy?=
 =?utf-8?B?MGJJRDdmY2RqSVFFcGhMMFpVVnI0SG1ZTk5GVVh1ampHbGpWaUFySGhTS3Jp?=
 =?utf-8?B?Y2I5aDN4a0dRSFhnY1Y3d0lLeWlDbkFUZjcydUlMRjdFc0hrOHJBeFpkb3cr?=
 =?utf-8?B?UU9yTG9HTWxqenV5VktVQWpXcy9sa01PSkxRazFNQ1IrOFlhRytJVGx4V0hG?=
 =?utf-8?B?QWlBazdBVVNlUmhXb25wN0NMWUcrTUpCQkJUYnNKbmZSUFc3TTg3QUNkMU9Q?=
 =?utf-8?B?aWdvdzd1eWw4OUNTZk5PTFY0Rm43eGdMVmVMRFNxeW85T2kxQkJobGpNUTht?=
 =?utf-8?B?WWEzMU1idXM5c2VETFNCQjBJNnFoNFhkUnVnM2J5THIzSmlFUWxiYitBWk9L?=
 =?utf-8?B?eWhKdmJvNXNsdkw5WmFlSjNwVktKbmZ4cVN0OVhIV2ZoZ2NkZzIyTmVWU0NM?=
 =?utf-8?B?UGsvckdQajBtZnVhbEdqZnpJSjZZTkNkamhhQXRQdFA4ZndzL0p0N1Z6Tnhs?=
 =?utf-8?B?ZVJPREg0enB2QmVpeVZvNzF3L1pHZjExRTV4ZlFzUWlscUJlaFlUUElURXhv?=
 =?utf-8?B?YUNPWjNQMmVodHlnVDgyRmVhZFQ3cXE4VHlCYXBUTHM2OXowbS8yYzIvUkZS?=
 =?utf-8?B?NUcxbWFIWUZrVUJTSXpycTBBZDZRWlNBcmkvNzVPOHZNNzlkUmxTZkJrWGpB?=
 =?utf-8?B?dWl2MkVMMDM1T3hsckJhQkJBc09McE5VMUhLSTM1WWFwd2NHNGdldEE3dTFO?=
 =?utf-8?B?L2V1cFpqR3EyYjRvRjc2VUp1M2oxZnd3QU9DU21NSXBRT0FqbmVGYjUwcU1v?=
 =?utf-8?B?QTh2Z3BNd0tSOEM1bWFsT0k3OU5FUDVwWnJJVGlwcjVGZkkxNmFMaTVNY1Rj?=
 =?utf-8?B?Y3JBNnhVNlV0UVpxQUppWEg4UjBrK3NnN1U3dHNKQVpzbEhWUUI5eC9WTUxF?=
 =?utf-8?B?TnoyQS9vNTd1RDZmZWFuSHJqd0kzbXpucnI5c0ZHb1RpdlB0K2RDaEV1YVlC?=
 =?utf-8?B?ZG8reTYxS1Z0dzZObCtERjIyVVhoZytyWVpVSXJqTG8rNVhUaXlUMUwrcjdP?=
 =?utf-8?B?ajZkUWZDcENtbXIxd0ZQR04wM055YmRrWEphYjVLakVYYTBqVGNHc3NneDZZ?=
 =?utf-8?B?Y1EwbkxVMjVPazU2akh3cS9PWUZORFVYWlRWOEs1U215ZE50bEV0a0p2SkpW?=
 =?utf-8?B?NFQxQW96VWkrZzdFNURSdHB2dVJLa3JnQzJuM0lMSGF2bW5CTm9Lc0RLdGdU?=
 =?utf-8?B?U053c0N2SDB2TFEzallhOG9OQVkyZHV3Ulk5b1NlM0k4cmpLR2ZMVzlQSWJm?=
 =?utf-8?B?QTFSeEcwdE5vNmJRUnl1bERENmpabnpjcUxlVVRod2ZmWmRBcHZMR3ZBeXFI?=
 =?utf-8?B?VkpPdU5JZXRxOG9iU1VoQUJ5d25XZTB6K1QvWWkwU2I4RmZPZzU0MzlXYzYx?=
 =?utf-8?B?UzdKcEptQkY3RlI2NklOc1RxK085MmdjQk1ydUZJMTZPQUZyRmozVDBTYjNP?=
 =?utf-8?B?ZUpSSDJDSk44a2V4UVVlTTNDMkJmd1ZvZitFOUM5SDFSUVUvcjRWZXpETFd5?=
 =?utf-8?B?V2dXcC9FU1JGOVh0NmZoWHdHQzk0d3hHbG8xdWNPb0tYTE5CUnpxNmNzOFFM?=
 =?utf-8?B?MVVaN0NvbU5xc1hDMjQ2b2lMSzF6STNBWExpbVJuUGxFb0FyK2c4R0JqakJ1?=
 =?utf-8?B?N1F3cDZydjVCcDRCM1RST1gzZnJ0WUFzcm0zWjFyWXQzZ3pwQTlBbW5oOFJX?=
 =?utf-8?B?MU1zUDRPY3E5SXB1aTg2U0xtUkRmR29yMlIvVVV5QXZxSVNIZDFCR2p0VUYw?=
 =?utf-8?B?cC9FWW1XYk1keUh3SyszMXhtUXNTeXcxUThYMzNVUy9adE02N1JUMW5mOXVV?=
 =?utf-8?B?c1ZnZ05GL25ENjNZNXF4Ull0cXJHYUxJOEVUbHdtK0lPVEU4TGFFa0lNbXFs?=
 =?utf-8?Q?CcsY83x5O0nu1OhRYdr9ZrR/5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BC16B3831114648A1B6E0774D85EC3B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42e57e1-9a28-44f9-e00a-08dc43f404d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 06:57:31.1821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RC9Oe05iQOFQlBAzD3X5vuxNyx4Y9Jbq9Y0JdwE+hUaXcRTPV7F2/dIACQx37M+Tcq8ql3Jem9hZdd0KzDEhnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6509

SGksIFNoYXduOg0KDQpPbiBNb24sIDIwMjQtMDItMjYgYXQgMTY6NTAgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IA0KPiBSZW5hbWUgZmlsZXMgbXRrX2RybV9wbGFu
ZS4qIHRvIG10a19wbGFuZS4qLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3Vu
ZyA8DQo+IHNoYXduLnN1bmdAbWVkaWF0ZWsuY29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMgICAg
ICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19jcnRjLmggICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kZHBfY29tcC5jICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICAgICAgICAgICAgICAgIHwg
MiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL3ttdGtfZHJtX3BsYW5lLmMgPT4gbXRr
X3BsYW5lLmN9IHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL3ttdGtfZHJtX3Bs
YW5lLmggPT4gbXRrX3BsYW5lLmh9IHwgMA0KPiAgNyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ICByZW5hbWUgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L3ttdGtfZHJtX3BsYW5lLmMgPT4gbXRrX3BsYW5lLmN9DQo+ICg5OSUpDQo+ICByZW5hbWUgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL3ttdGtfZHJtX3BsYW5lLmggPT4gbXRrX3BsYW5lLmh9DQo+
ICgxMDAlKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtl
ZmlsZQ0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZQ0KPiBpbmRleCBiYmRm
MWU1OWVkODQuLjBlMTk4YzAwYzZmMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmls
ZQ0KPiBAQCAtMTIsNyArMTIsNyBAQCBtZWRpYXRlay1kcm0teSA6PSBtdGtfZGlzcF9hYWwubyBc
DQo+ICAJCSAgbXRrX2RkcF9jb21wLm8gXA0KPiAgCQkgIG10a19kcm1fZHJ2Lm8gXA0KPiAgCQkg
IG10a19kcm1fZ2VtLm8gXA0KPiAtCQkgIG10a19kcm1fcGxhbmUubyBcDQo+ICsJCSAgbXRrX3Bs
YW5lLm8gXA0KPiAgCQkgIG10a19kc2kubyBcDQo+ICAJCSAgbXRrX2RwaS5vIFwNCj4gIAkJICBt
dGtfZXRoZHIubyBcDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2NydGMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jDQo+IGluZGV4
IDdiYzRmNzY3MThlNS4uOTZhZjE5NGQwZDQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2NydGMuYw0KPiBAQCAtMjMsNyArMjMsNyBAQA0KPiAgI2luY2x1ZGUgIm10a19jcnRjLmgi
DQo+ICAjaW5jbHVkZSAibXRrX2RkcF9jb21wLmgiDQo+ICAjaW5jbHVkZSAibXRrX2RybV9nZW0u
aCINCj4gLSNpbmNsdWRlICJtdGtfZHJtX3BsYW5lLmgiDQo+ICsjaW5jbHVkZSAibXRrX3BsYW5l
LmgiDQo+ICANCj4gIC8qDQo+ICAgKiBzdHJ1Y3QgbXRrX2NydGMgLSBNZWRpYVRlayBzcGVjaWZp
YyBjcnRjIHN0cnVjdHVyZS4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfY3J0Yy5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmgNCj4g
aW5kZXggNTg2NWU0OTU1NDcxLi5jYzhjYTdjMjA1NmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfY3J0Yy5oDQo+IEBAIC05LDcgKzksNyBAQA0KPiAgI2luY2x1ZGUgPGRybS9kcm1f
Y3J0Yy5oPg0KPiAgI2luY2x1ZGUgIm10a19kZHBfY29tcC5oIg0KPiAgI2luY2x1ZGUgIm10a19k
cm1fZHJ2LmgiDQo+IC0jaW5jbHVkZSAibXRrX2RybV9wbGFuZS5oIg0KPiArI2luY2x1ZGUgIm10
a19wbGFuZS5oIg0KPiAgDQo+ICAjZGVmaW5lIE1US19NQVhfQlBDCTEwDQo+ICAjZGVmaW5lIE1U
S19NSU5fQlBDCTMNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGRwX2NvbXAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuYw0K
PiBpbmRleCA5ODM5ODk5MzUwMGYuLmFiODQ2YTlmOThjNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuYw0KPiBAQCAtMTYsNyArMTYsNyBAQA0KPiAgDQo+ICAj
aW5jbHVkZSAibXRrX2Rpc3BfZHJ2LmgiDQo+ICAjaW5jbHVkZSAibXRrX2RybV9kcnYuaCINCj4g
LSNpbmNsdWRlICJtdGtfZHJtX3BsYW5lLmgiDQo+ICsjaW5jbHVkZSAibXRrX3BsYW5lLmgiDQoN
CkFscGhhYmV0aWMgb3JkZXIuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAjaW5jbHVkZSAibXRrX2Rk
cF9jb21wLmgiDQo+ICAjaW5jbHVkZSAibXRrX2NydGMuaCINCj4gIA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IGluZGV4IDkwZTY0NDY3ZWE4Zi4uZDliNWE2
YWQzYmVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
ZHJ2LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+
IEBAIC05LDcgKzksNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstY21k
cS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW11dGV4Lmg+DQo+IC0jaW5jbHVkZSAibXRr
X2RybV9wbGFuZS5oIg0KPiArI2luY2x1ZGUgIm10a19wbGFuZS5oIg0KPiAgI2luY2x1ZGUgIm10
a19tZHBfcmRtYS5oIg0KPiAgDQo+ICBpbnQgbXRrX2FhbF9jbGtfZW5hYmxlKHN0cnVjdCBkZXZp
Y2UgKmRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9wbGFuZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5jDQo+IHNp
bWlsYXJpdHkgaW5kZXggOTklDQo+IHJlbmFtZSBmcm9tIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX3BsYW5lLmMNCj4gcmVuYW1lIHRvIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfcGxhbmUuYw0KPiBpbmRleCA2M2E3YTI0NDY4YzEuLjk1YTQzMjhhOWIwYiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMNCj4gQEAgLTE3LDcgKzE3LDcgQEAN
Cj4gICNpbmNsdWRlICJtdGtfZGRwX2NvbXAuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX2Rydi5o
Ig0KPiAgI2luY2x1ZGUgIm10a19kcm1fZ2VtLmgiDQo+IC0jaW5jbHVkZSAibXRrX2RybV9wbGFu
ZS5oIg0KPiArI2luY2x1ZGUgIm10a19wbGFuZS5oIg0KPiAgDQo+ICBzdGF0aWMgY29uc3QgdTY0
IG1vZGlmaWVyc1tdID0gew0KPiAgCURSTV9GT1JNQVRfTU9EX0xJTkVBUiwNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmgNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmgNCj4gc2ltaWxhcml0eSBpbmRleCAxMDAlDQo+
IHJlbmFtZSBmcm9tIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmgNCj4g
cmVuYW1lIHRvIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGxhbmUuaA0K

