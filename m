Return-Path: <linux-kernel+bounces-111180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474608868CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B05B1C23DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93491B7F3;
	Fri, 22 Mar 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kPWYbR4S";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QgNtyvN7"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA820B27
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098191; cv=fail; b=PO2U+OEaB/SeNi+sOYeFu6AjEGigmNqVFRPAZ50MLYO1J8HOIej2Gf8VvtcHl5rRpPz23YjIVIbAx6hmaeZWlQv9Hrtp6lBbEacwk5C6vTFKXwXoIi5shV9C+eXCKqIe1VFWU0GjxBKmTl0jrYaWCRLCTvaKK9XMVVeXqTKFbm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098191; c=relaxed/simple;
	bh=5CiYp6Ou0UXHx9GYP+w6YTbvGJxfwbrimMr1RrQpfAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RV12BHoy9Vu3OM/GyobUeImoYwFdu4BZ6iDSYdKNMvGyTTs+pSdXtPBUxHSlw/MnOzCAdzPfv3xiLfCn7rY+vfkRhJoGHJgOtED7pdOc26NqnV2Il1y2RHPHeGjzmwYTlvi7qvP7IBhrRUKSy6z7IfBnGook1/6s6ZSAXyns7Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kPWYbR4S; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QgNtyvN7; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fcfca008e82a11eeb8927bc1f75efef4-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5CiYp6Ou0UXHx9GYP+w6YTbvGJxfwbrimMr1RrQpfAM=;
	b=kPWYbR4Spvb11XfvdJAn4pnlRADIhRKDCd/gUNteOH6XimYIbe4XSjDUpj7VssjHKp5Rr99/Thflp5RIJ4uE4wpWKZ/qPw0HI6tZU+OSAgaDqj/0c100mUMM1hlRt7gOp0H/BvB0T/b/ciCTOV+giaFyi7C1r8Bx/v5XmcdpNa8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:74d85a81-d2e7-4852-ad19-9d369e7853c8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:3ffdce81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: fcfca008e82a11eeb8927bc1f75efef4-20240322
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 526344345; Fri, 22 Mar 2024 17:03:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 17:03:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 17:03:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9rgqB517Hfq1R9u8scXfLSy5LeXOgWn8Cf24YHqaAyfxCk4yJduypUh88dhVTWGPCMbIvoYTyBqbQTPefnfQGdwBpU3s1pvIe0oiDyFh9IVxpRPqA58jJk5G6Eay/UEnBc+aMzNE+srTmf/Vkb/dpGbji2v92AQmrra3pZF9pPkkHo630HHXL1EEagshbprzx2Ofd7fLrrzxjUiq/ePEGuuLX5+AOfCVCTg+7eq0QQ8GxDCcdBpO92CIea74+ccFvQk0EcjH4B7Cu4MqrsUdzPui2CJNc5qLRZp+CbypThbeJiLznKzLkNWUFZq1NuZRPItJP6ZzPpDT2nWQPYTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CiYp6Ou0UXHx9GYP+w6YTbvGJxfwbrimMr1RrQpfAM=;
 b=gM/mfB/l5FBqmcpNJh0zIUaa4zjoqX2P89QD+T7sVTgQ+pBlmB3TQLFs/A7/ZJBmZl54OJSLIFh7WJHGT5avbvCIfdVBo8a763Rljk0B2CvARbdxEqQMDHNmr9QmEzqmYZP6DD+P5sfQmgP2/r/ibGNIImpL6/1EgVc/FTHWLy6o6HXAXsi+Cvcw96RGxGjG/RIJuhyXPN2tOO53BCnoncSl+4+CuuGGkDROByELJdrB+pFNeWTh+u7RSst5hVdNl1Ccj7CradRKjB8U6FrCKKKVxfnRu8FEdX6Uql6MSs5iJmC0JvoJBYWvVdC6+JWc9nfSXxqXUZ3wTm839guTEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CiYp6Ou0UXHx9GYP+w6YTbvGJxfwbrimMr1RrQpfAM=;
 b=QgNtyvN78pBC72ARW83jCRJp0S281xH1Qij2Z4dCpumtRaVfODhIHnAfyEHsGfJYS3KJAQooeXw65+tRbZwrRDgP3ESIvA8rltibiAev6LsH3LBXEjkpdoZDXgtvdY0nNL1xNmsrUXiKzzFezeD8R3XW84mYdockF7p9u0tD2Oc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7713.apcprd03.prod.outlook.com (2603:1096:990:a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 09:02:58 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 09:02:58 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v6 04/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation
 property
Thread-Topic: [PATCH v6 04/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation
 property
Thread-Index: AQHafBnuCAQWF4qq7ESf/M74clw44rFDd0KA
Date: Fri, 22 Mar 2024 09:02:58 +0000
Message-ID: <a5b00d343b922e726476e4b3c1973d44a05aacb3.camel@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
	 <20240322052829.9893-5-shawn.sung@mediatek.com>
In-Reply-To: <20240322052829.9893-5-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7713:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1TC57ReLF9hXKcMfDSIR+M0jlpnMb2acNiKJVnlkbjjbzCDx3j8Gr5BXf8Kx1DzNFQOBQUh10mUJ3csoL/JLLu/82b8+rpD0IfAMhFxrVnz7f0/WdsPFW5KyUDVViPUEENNp/qTzwlpAVsFaSXcZabSr0R3AJGn1t8U6/c/YQtXJ1BXGus4zLGggERvTGVphYnoMGT5Z7rpAAtDHZSZGXolykp9CoNp9+9QQfEJ5BgT7jQvoLjcb7MCDMAA4dSyCQm3pBFRLK7GCi+pAIF1vf5daAAWdLb7s8zydCrNd5pkhOy6s3o0d+DQIa1ujKl0kfpcvfvry0C/b/zl0TOihEIMjh3/LXHXy4GFxiCBAJQ3v3XkpgiSBIsM8gRIz1TKydy/A5WQSqPYOoUQi9rKzP3NzxHE8uB3NeppQ6NiEPQBgvij7uVX32cuTpy+bt4rAp9VNUAnyORGC04VPXqFV5Dg9DBonTlj7UIY+dVmLZSBdts51NGo6kIIktvYTDV0pOQMgFMhID4xcNGIZuVzLUVZSoxwCwH2XRm/ZtJUt0mX2vumnow+6TEKpcsqFRQ4TkGgwYcrQ4eHeEA4x3TCyTIZBNRBQLEXp/RlGqM/z97FITLXg9OnQSRbwuUm6FQ1KFqIpRmRLyyAlVxKHO8JNxTWdDcmYNB8jyyZfyg6EPSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2FLVW1vU2tOSkxEdjBxRmRkWFkrTS9tNlVjbVVWZzFIRGhGSU13c3JiYWJx?=
 =?utf-8?B?L20wd2pCS1ZDclM5MVN1MVVRcUNZRklBOXZkM084SDlzdDlRRnRoS3poNThl?=
 =?utf-8?B?V1A2dS9COHFoL2xUcVdLclpEbFZQT0RoM0JNMVpsVEM3N0YzcVNnY0wxMU1G?=
 =?utf-8?B?RGtxa0oxMWd4ZmdsaWpJQnUxSkpMMGdkamJ1SjZWOEswZi9DTk1MWXhiRGZv?=
 =?utf-8?B?cmZIV3A3ZEhZSzlOb0RVUHlwa0NERXZsYXoyMU5WRVRpNmhFdEI4M1JrMUVU?=
 =?utf-8?B?R3lCc1hUbzJvSzBDR0Ztd2VHbnowUjc0TTM1NjF4Ym82bS9sZzArVFBnWkpa?=
 =?utf-8?B?dVNYUk1EeTd1bTUzamVGdjREYTZ3RHZ3WTNzMUVtQnFZTGhiVGRRYlJ3Tno0?=
 =?utf-8?B?dmQxd3FNQmtjNXBjUmppWWVaMFVGNDBZcFRVdUlIR2toMEtlWS8rNmY5alZM?=
 =?utf-8?B?dk5qS09YWVFVZmVxci9rSWdpQlRnQ2tzeGtwNEhlWVpGalFxdUlNVC91R2Jr?=
 =?utf-8?B?RTRvRGZUTXE5OE44VWZDa254ZjMrSCtPbU9oWjhRS3pOSFhyL2o2dTlNQ1Ix?=
 =?utf-8?B?WEQyVjBobEsrSWgyMkxZUlBsazlUNjgzcHFXbmJSMGJTYjBKdlAxd296WVU0?=
 =?utf-8?B?dmdlcDNxSnNtaXhWU29KdE9rb2QvRHhTUWhPUGFQdU9LbEtNb0FXVEd0K29J?=
 =?utf-8?B?dmduN1ZtMGZwM25MVWVtNDc5a1ZtN0lNY3ovZWlxSmIyaXg3Z0s0YjJoMTBQ?=
 =?utf-8?B?YXhabW1jdDFZelF0VzZ4UDRIc0FXYlRXcytHMVYvSW9yaStEY3phMllJazN1?=
 =?utf-8?B?WHZlSlc3cjd5YjJnWC9Yait4WDBDSEJ3ZFdNYzBqU1VOdnhMSkV0VWR0ZXk2?=
 =?utf-8?B?TnBFMVdlS3hWZWN4Q3c3TUwrcjdLRXVNa05nVjIzWkVvNVkvcGhZZmRxbGY1?=
 =?utf-8?B?RkUwQnVRRnpqc0hUNlRSVlIweFBwZWV3bHo4dXRsSjNaWFhNSEY0NURwOE50?=
 =?utf-8?B?alVIV1hiWXJYcWFRNmNUeVZCNFhEdEhIQVhCY0FlbmRrdTU3ZlRIRkdybmFp?=
 =?utf-8?B?dldjam95RVdPUGtaVXB0Nnpaa2Q4YnFjWGtqb051L2ZOSytZTlVPaW5ZK3Fx?=
 =?utf-8?B?emtReE4rN1VVbTBXdng3RkxLZ2cvOWdyUGRrSEk2Qzd6d2V3Z1pMMWY3UlV0?=
 =?utf-8?B?MzZjd1ZuUEZQSkNVWnJWQ0p3TDBmT0NBdTZXTDhWVTJ4RnhMZWhPc0tmNWQv?=
 =?utf-8?B?RnhycVEzZGtObkRHYWZxZnZEVFFSQ2tPRHFIUW1SQ2pIWCtOOStib2dsNmt2?=
 =?utf-8?B?ZWIxMzVCanowQUJicWpFc3RHK0hFUmUrN2FnSFlQeklKbG5pY0xheWhsdU9G?=
 =?utf-8?B?aFJEU2lwZlpUZVlDanlVcHVITm9oZU8vMnlxQ2xxMmV2UE50d0piMDFoQXlQ?=
 =?utf-8?B?bXcwanJXNHhuY0NPR25kbHZTZFhkQVNoa0hXTitRSmNuNWdIU1Q1TUlsbVl5?=
 =?utf-8?B?NlBqNTBHVE13RHJDMHkzQjhFcndSMWIwQUZDUVJUQ0YyaTNYa3RBU3lvUEth?=
 =?utf-8?B?Q2JzMHpkeTJHT0NOR0x1QWVnMXc3U2FsazJiZitEejdzbGxlcE14YnhEOTE1?=
 =?utf-8?B?Wnl5cEV0OFVtQnR1S2VhYWl5by9xTFV5OUExR05VN0FLZEpBbkJ0K0hKc2F6?=
 =?utf-8?B?YXlHR1RaSjErUW85TzRUT2JtSXlSYzNLb0RNZmY2ZWE2ZGsycDh0YUNBd2Uz?=
 =?utf-8?B?RXVjT0xqTncwN2ZUd2p5ZkdNZy9xNy9CcW5taHB4VFNUNDlQSUplbDhuSC9l?=
 =?utf-8?B?ZjB2TDRzY3B6dUJjUG4vTGllbzhpaUVWSy94T0NMV281Yzd2NFFCbEx0TnVa?=
 =?utf-8?B?THJ5QmRZYmFQd0paek9DeVp0YnY5Q2ptVTJ5TmYxQXZ3V1BvZ041MkthQjlF?=
 =?utf-8?B?VjZjYWFGL1FFaUErcW4vbFN2TUtTWVM3M0hzV29NQVFaU0xJekE0YUtPVm92?=
 =?utf-8?B?T0N6MFl4TjlYaGxNdnNYdDFiMnFrWkpwMnNkb1d5eENkZW40RHBpbDR0bmFk?=
 =?utf-8?B?VGJZN2VwZ2Z6N2RUSlVmdU5tOGtiY3drM0tDeE1qM0QwdDZ5bUZBMHVvWk1R?=
 =?utf-8?Q?JmBrwM2iamccrcoZLqVfMmNmu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2A601083A6DDF479769FD462F1A3DCD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a18626-e3f3-4342-3774-08dc4a4edebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:02:58.4526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vXurppBQOsBLtfzmjEngpYtk+Q548e9nSBanplDtDidH1sALZCpW6gMM9TJmBwRQPCWaJMnpQuv3PKgOEMf1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7713
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.372000-8.000000
X-TMASE-MatchedRID: VPleTT1nwdQOwH4pD14DsPHkpkyUphL9X4GSJGyYc35cKZwALwMGs9Ev
	k7xjlIKiQfALEPHeHX1c7/JU/kbLPqXzgcphDfm8H5YQyOg71ZZMkOX0UoduuXXeJBXr7CDU0l/
	NX3Dm9e4FCXmAJJjxmPFjRYaB9JwDtR3ZHtcq+fcxKOWR6zQpr94N8Q+ldC7Uus6H8bDI7AIT5J
	IS2H7mhOLzNWBegCW2PZex/kxUIHW3sNbcHjySQd0H8LFZNFG7bkV4e2xSge5JVH+gIfn8LhZjM
	cMfi7Kwq4Pad+2CeQ65LHXFmplFjD6Qrn3xh/cy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.372000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A0EDA0449D2178F97788AF59C730AAFAD65B8A3E3EB774D24B0583D9976743892000:8

SGksIFNoYXduOg0KDQpPbiBGcmksIDIwMjQtMDMtMjIgYXQgMTM6MjggKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gQWx3YXlzIGFkZCBEUk1fTU9ERV9ST1RBVEVfMCB0byByb3RhdGlvbiBwcm9w
ZXJ0eSB0byBtZWV0DQo+IElHVCdzIChJbnRlbCBHUFUgVG9vbHMpIHJlcXVpcmVtZW50Lg0KDQpS
ZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gUmV2aWV3ZWQt
Ynk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxy
ZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxz
aGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RkcF9jb21wLmggfCAgNiArKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmwuYyB8IDIxICsrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5jICAgIHwgIDIgKy0NCj4gIDMgZmlsZXMgY2hhbmdl
ZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+IGluZGV4IDI2MjM2NjkxY2U0YzIuLmY3ZmUy
ZTA4ZGM4ZTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRw
X2NvbXAuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmgN
Cj4gQEAgLTE5Miw3ICsxOTIsMTEgQEAgdW5zaWduZWQgaW50DQo+IG10a19kZHBfY29tcF9zdXBw
b3J0ZWRfcm90YXRpb25zKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApDQo+ICAJaWYgKGNvbXAt
PmZ1bmNzICYmIGNvbXAtPmZ1bmNzLT5zdXBwb3J0ZWRfcm90YXRpb25zKQ0KPiAgCQlyZXR1cm4g
Y29tcC0+ZnVuY3MtPnN1cHBvcnRlZF9yb3RhdGlvbnMoY29tcC0+ZGV2KTsNCj4gIA0KPiAtCXJl
dHVybiAwOw0KPiArCS8qDQo+ICsJICogSW4gb3JkZXIgdG8gcGFzcyBJR1QgdGVzdHMsIERSTV9N
T0RFX1JPVEFURV8wIGlzIHJlcXVpcmVkDQo+IHdoZW4NCj4gKwkgKiByb3RhdGlvbiBpcyBub3Qg
c3VwcG9ydGVkLg0KPiArCSAqLw0KPiArCXJldHVybiBEUk1fTU9ERV9ST1RBVEVfMDsNCj4gIH0N
Cj4gIA0KPiAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgbXRrX2RkcF9jb21wX2xheWVyX25y
KHN0cnVjdCBtdGtfZGRwX2NvbXANCj4gKmNvbXApDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gaW5kZXggMGViZWFmOTgzMGQ4My4uMmE3NjdhODIzYzgzYSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBAQCAtMjg4
LDYgKzI4OCwxMCBAQCB1bnNpZ25lZCBpbnQgbXRrX292bF9sYXllcl9ucihzdHJ1Y3QgZGV2aWNl
DQo+ICpkZXYpDQo+ICANCj4gIHVuc2lnbmVkIGludCBtdGtfb3ZsX3N1cHBvcnRlZF9yb3RhdGlv
bnMoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiArCS8qDQo+ICsJICogYWx0aG91Z2ggY3Vy
cmVudGx5IE9WTCBjYW4gb25seSBkbyByZWZsZWN0aW9uLA0KPiArCSAqIHJlZmxlY3QgeCArIHJl
ZmxlY3QgeSA9IHJvdGF0ZSAxODANCj4gKwkgKi8NCj4gIAlyZXR1cm4gRFJNX01PREVfUk9UQVRF
XzAgfCBEUk1fTU9ERV9ST1RBVEVfMTgwIHwNCj4gIAkgICAgICAgRFJNX01PREVfUkVGTEVDVF9Y
IHwgRFJNX01PREVfUkVGTEVDVF9ZOw0KPiAgfQ0KPiBAQCAtMjk2LDI3ICszMDAsMjAgQEAgaW50
IG10a19vdmxfbGF5ZXJfY2hlY2soc3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQg
aWR4LA0KPiAgCQkJc3RydWN0IG10a19wbGFuZV9zdGF0ZSAqbXRrX3N0YXRlKQ0KPiAgew0KPiAg
CXN0cnVjdCBkcm1fcGxhbmVfc3RhdGUgKnN0YXRlID0gJm10a19zdGF0ZS0+YmFzZTsNCj4gLQl1
bnNpZ25lZCBpbnQgcm90YXRpb24gPSAwOw0KPiAgDQo+IC0Jcm90YXRpb24gPSBkcm1fcm90YXRp
b25fc2ltcGxpZnkoc3RhdGUtPnJvdGF0aW9uLA0KPiAtCQkJCQkgRFJNX01PREVfUk9UQVRFXzAg
fA0KPiAtCQkJCQkgRFJNX01PREVfUkVGTEVDVF9YIHwNCj4gLQkJCQkJIERSTV9NT0RFX1JFRkxF
Q1RfWSk7DQo+IC0Jcm90YXRpb24gJj0gfkRSTV9NT0RFX1JPVEFURV8wOw0KPiAtDQo+IC0JLyog
V2UgY2FuIG9ubHkgZG8gcmVmbGVjdGlvbiwgbm90IHJvdGF0aW9uICovDQo+IC0JaWYgKChyb3Rh
dGlvbiAmIERSTV9NT0RFX1JPVEFURV9NQVNLKSAhPSAwKQ0KPiArCS8qIGNoZWNrIGlmIGFueSB1
bnN1cHBvcnRlZCByb3RhdGlvbiBpcyBzZXQgKi8NCj4gKwlpZiAoc3RhdGUtPnJvdGF0aW9uICYg
fm10a19vdmxfc3VwcG9ydGVkX3JvdGF0aW9ucyhkZXYpKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gIA0KPiAgCS8qDQo+ICAJICogVE9ETzogUm90YXRpbmcvcmVmbGVjdGluZyBZVVYgYnVmZmVy
cyBpcyBub3Qgc3VwcG9ydGVkIGF0DQo+IHRoaXMgdGltZS4NCj4gIAkgKgkgT25seSBSR0JbQVhd
IHZhcmlhbnRzIGFyZSBzdXBwb3J0ZWQuDQo+ICsJICoJIFNpbmNlIERSTV9NT0RFX1JPVEFURV8w
IG1lYW5zICJubyByb3RhdGlvbiIsIHdlDQo+IHNob3VsZCBub3QNCj4gKwkgKgkgcmVqZWN0IGxh
eWVycyB3aXRoIHRoaXMgcHJvcGVydHkuDQo+ICAJICovDQo+IC0JaWYgKHN0YXRlLT5mYi0+Zm9y
bWF0LT5pc195dXYgJiYgcm90YXRpb24gIT0gMCkNCj4gKwlpZiAoc3RhdGUtPmZiLT5mb3JtYXQt
PmlzX3l1diAmJiAoc3RhdGUtPnJvdGF0aW9uICYNCj4gfkRSTV9NT0RFX1JPVEFURV8wKSkNCj4g
IAkJcmV0dXJuIC1FSU5WQUw7DQo+ICANCj4gLQlzdGF0ZS0+cm90YXRpb24gPSByb3RhdGlvbjsN
Cj4gLQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX3BsYW5lLmMNCj4gaW5kZXggYTc0YjI2ZDM1OTg1Ny4uMTcyM2Q0MzMzZjM3MSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGxhbmUuYw0KPiBAQCAtMzM4LDcgKzMzOCw3IEBA
IGludCBtdGtfcGxhbmVfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1Y3QNCj4gZHJt
X3BsYW5lICpwbGFuZSwNCj4gIAkJcmV0dXJuIGVycjsNCj4gIAl9DQo+ICANCj4gLQlpZiAoc3Vw
cG9ydGVkX3JvdGF0aW9ucyAmIH5EUk1fTU9ERV9ST1RBVEVfMCkgew0KPiArCWlmIChzdXBwb3J0
ZWRfcm90YXRpb25zKSB7DQo+ICAJCWVyciA9IGRybV9wbGFuZV9jcmVhdGVfcm90YXRpb25fcHJv
cGVydHkocGxhbmUsDQo+ICAJCQkJCQkJIERSTV9NT0RFX1JPVEFUDQo+IEVfMCwNCj4gIAkJCQkJ
CQkgc3VwcG9ydGVkX3JvdGENCj4gdGlvbnMpOw0K

