Return-Path: <linux-kernel+bounces-88171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7F86DE21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C0283D67
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E336A8C8;
	Fri,  1 Mar 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Qie4zqVF";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rvEUcu2V"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2971E886;
	Fri,  1 Mar 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285050; cv=fail; b=lUfZxKqa6xAUXGaXZMJQ92/9dxBY1KCSUDaO6+pKZm+hj2i/VDa8+nci359VLbc3Up3gr9Ten/ngfaTtGs6BudeU/4q2eL/zOcQQlh7E62F2GwseOLwuOUXadQERI5el0XMjIHgj+VmrXt+KgAy7nx0AVGhiY9K8Bj6j6WU8/F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285050; c=relaxed/simple;
	bh=71PRDLp9UMQayZxC8BMGrZIqRK1XSijHjbMYqM0ifvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V2TAeyqKirgzcQAD1YkvsJG/atK2ODghTMaV9Vq3VpIZRKzmghxxPrb6a1sKBFa7C4ewDlMs8/UCQPg/ijaOY7Nb16yFyTVsRLdQkPY7xmEC/xBHRHB5mzhIxA6UOD2M8+5rlFlX+L+dYy040gTZ74Gs9XlzFNr4WxYitNZcvZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Qie4zqVF; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rvEUcu2V; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 71a49430d7ad11ee935d6952f98a51a9-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=71PRDLp9UMQayZxC8BMGrZIqRK1XSijHjbMYqM0ifvc=;
	b=Qie4zqVFi3jZn1neKvx1zc75pySOBFMF5LmhFwoa5ANEKiWR/dmKY1zXlVE48BVZ0puke4IbF9fiSNp+c2/mi/CM5oq+L6jO9JPZNDZkT+uQCQZT5Pd69Q81vArts3YNsOWcS+myvRolmCfYeDmyNPqVtMe3lPFHDIxBL6M2D9c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:7b4d8281-098b-4c4c-bdc6-b97443b701ec,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:3d1ae68f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 71a49430d7ad11ee935d6952f98a51a9-20240301
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1806181933; Fri, 01 Mar 2024 17:24:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 17:24:01 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 17:24:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFjypTjQhfsgJgasOyZFQDAicXB+QXCBQXFpUIfqUpZrYR8kButeoIIFRDB24iukms/G7pnDRQlkm0yDr7RceMdG/z66/LgjVg+ObqdMHIYCXEFnEa0WBIlS32Scpy/HuigeQJaCEjg8hG2FNq5PwYUwFFn38u9+4D3bOSrD2xEvDbcSQ1bUGZPcH0tuSz9PGJ1aMi0UdreDdgXS/pyaDeGn9ktBBl1pFMp1vxHwmcrSGp5Jo9FdK7awJmHKdB+B+T0Sdi7nlLprhJ+cVHTLZ4CboBhfRi7n24KOdj1HEIQxrtex9L5eCrsg+w3Zk5zW6BKuUd0PYjxH1pVboowPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71PRDLp9UMQayZxC8BMGrZIqRK1XSijHjbMYqM0ifvc=;
 b=C5K+TCsK/ApN9buNRyMV0CrZsRPNbXJPwUdlrEytDt0Wsk1jJcV+1+cEhvV03J7k9Bsxvw2V7K4trl9AW8/EpU8Kx861xRqW4XCkTQVcNAC8nFn86pgSAgGKvruC3pWBREYQB1tiWXXTBkgdti7USa/Bd/HA34C/TuBErKCjl0chQfmM1b7RQV1rKpmVKWp09CS263SsZzqU0SqEvhjdns2oiQgU5MBFevSOjELvwWtrk+FW/b5E+KZGQXx0fFOkVB0NUE4re5RcXK6AG2fGhHGrN41pOOtOykJrzc07okVozernWmUEu7jhRD7eB2Fsz2JJemo3/XLC7CAsmFIriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71PRDLp9UMQayZxC8BMGrZIqRK1XSijHjbMYqM0ifvc=;
 b=rvEUcu2VJGjG167jT5j6kJkgxpFIZg/mlm4M5Wj/L5IQ50lbjfsthP07PoK2BIr+Kg3GihBaU0p7aGUvGO2VxN8vTSqoMgKQksQAGqAzugCVNaNCLqUwXkg/9lVo8EB8B6EPLJ3fth9vHIhtv/Hq+mBwuFGiKyvfOluAUlt0jt0=
Received: from OSQPR03MB8697.apcprd03.prod.outlook.com (2603:1096:604:292::8)
 by TYSPR03MB7426.apcprd03.prod.outlook.com (2603:1096:400:417::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 09:23:59 +0000
Received: from OSQPR03MB8697.apcprd03.prod.outlook.com
 ([fe80::9e99:12:7cbe:1294]) by OSQPR03MB8697.apcprd03.prod.outlook.com
 ([fe80::9e99:12:7cbe:1294%3]) with mapi id 15.20.7316.037; Fri, 1 Mar 2024
 09:23:59 +0000
From: =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= <Yunfei.Dong@mediatek.com>
To: "nhebert@chromium.org" <nhebert@chromium.org>,
	"benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
	"nfraprado@collabora.com" <nfraprado@collabora.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "nicolas.dufresne@collabora.com"
	<nicolas.dufresne@collabora.com>, "hverkuil-cisco@xs4all.nl"
	<hverkuil-cisco@xs4all.nl>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"frkoenig@chromium.org" <frkoenig@chromium.org>, "stevecho@chromium.org"
	<stevecho@chromium.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "hsinyi@chromium.org"
	<hsinyi@chromium.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] media: mediatek: vcodec: support 36bit physical address
Thread-Topic: [PATCH] media: mediatek: vcodec: support 36bit physical address
Thread-Index: AQHaa3xzr7P+z/OFNEClVpf2N0kmjbEil8SAgAAFowA=
Date: Fri, 1 Mar 2024 09:23:59 +0000
Message-ID: <c1f489c474e3d00ff8573225c5d282df4d82f9e1.camel@mediatek.com>
References: <20240301020126.11539-1-yunfei.dong@mediatek.com>
	 <ea7f25bf-2294-4ad4-bc18-226827d49ae8@collabora.com>
In-Reply-To: <ea7f25bf-2294-4ad4-bc18-226827d49ae8@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR03MB8697:EE_|TYSPR03MB7426:EE_
x-ms-office365-filtering-correlation-id: 52883f3d-7f14-4d16-7107-08dc39d153a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWujVGA79MCFbTuJIJPI4vlj03dhHsUJTlkGRBsy3fKlB+4j0QF0EsANZx66cgAVaPdyTKkV675qDiLnitMdS4j4vdz6FGOz8OrMnI7nBYNKa3qVxTQbdmVd0NeZOvcnIEecLtn8AsPAU8AAH/0FbSlBdAprR/Wx5Fk0hV/AnF5wA9n+R1fmG1BowshPKXftqlhIBGn97vkAk6y7DiiHSbQYkHfH3OxuQjXgJFM2JkLesgJXZMMAIDvNKI//y5c1U0YhBlR3hcmlepZeG53x15uGwWVwdr+S7W5Y3Ydk64KRXJ95XMRDk/wgnF6nLR54iCDRHhZ3JcI3wYY9PYJLkXK3k1/k6psQ6/1S0AVU3F7NVlL72hSTM6vZGOBbVBOrs4hb5MacLHIzX6AdH5wLKxUXyWKVa/WzFLe2kXLXtZ9PaDFj+byDcWvoWMiyAGLM76mrGedvn+DVXZOwFsvHZ2jC013scgz/zYjYbjzw9vLOyVbhMwnkAEeL0q8Zw+4vkyPqGu8YVKmFE+LXcN/VaC1YfIBaDZH4Ys01wqFg6S8Ht3c+GfegKGtfhz7SNepBpq8G1HorGCPcifjoL7VFHjE2jJ3Pdh3KP2ts/Lz0H9XXp14pa99F6gOmPCRog13wVfdE40GJpfaaFQ9Jn8dVU8eLusqUVcpi1LpJOd59fXSxFkYmFHRjWSmu5yWJVxbnQGZXBL6xwdKQsdJmBt65SYCgtrXfDihB9RNFI4CkRCE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR03MB8697.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDJTTm5NZjRjSElLeTlZR09GL1NyWjUzUnY1eW1LZWtOZ2YxSHM2VjZHdEM0?=
 =?utf-8?B?ZjNsQ29MTTZrb3RwQUhlaGp3OFZGcHBZNmJpTGZkdXIvSHp1WTZZdzZIY2h2?=
 =?utf-8?B?T0lEVFJuREllYXRwUlppNEtPYkhFa3FYZkpISmFyQ2tmR1owQ0VyTStqQ0Ro?=
 =?utf-8?B?TW1yTDBkZTM3SnRUcUZZQzMvL293bTZoN0liU0ZPbXpacGl3WnpFQnFPY1di?=
 =?utf-8?B?U3Z1cnIySW0xWDVIeFlwRnlCdlY1VGdnNVYwZFJyeGV6REZzbFY3aDdPQWFX?=
 =?utf-8?B?OHZ0dmVtSU1SVzByaSs2MnpKQXhhdGtIVzFwck9oWmN3VW56ZjJzUHRYTnJF?=
 =?utf-8?B?YWdtZlh4bVZNUXlPY011L2dEMUNuVkpRN28rY0oyckNIbGlJMkY1K29mMWha?=
 =?utf-8?B?OGVGaHlHRmIrOVhXVWlsS29ROWh1N1BSNFpjaUVyY3hGdzhpbjJMVHdISzRN?=
 =?utf-8?B?aDRaMWp3N1Arb25xSldsaVVxdFpRcUQ2WktHMjVUVVJLOGtHR2tQVjM2U3FK?=
 =?utf-8?B?VUZtR0Y2UkxWdGlITTlMallyN0MrSXBlSUoyUERtR1hnK0FLa1BzV1ZjazRl?=
 =?utf-8?B?ZE5obnczcVRxN1lmTFdxdzFacmdRelpKRStxNHdFS2RjRlNHWTAxbGE3SVFi?=
 =?utf-8?B?U25Mbks3YUsrL3B4OWZuR041R1pLTE55NHBydXJXQ3dPN2JtZEJleU1pdlVJ?=
 =?utf-8?B?SjRtWmphOVJnaUhQSlNiV3ZNS2p5SWt1MURvWTZBZ1VsQXN1L1lwK1FFMmt1?=
 =?utf-8?B?aDVLWnZnMXFlWXhXTHNEMVUwaDBGbHJ0ZEhOQllGcDdaclZ6VFM1Ni85Wkk3?=
 =?utf-8?B?OGc5UHV6WDZoYXRZdFZZRlpHa2FpcVdXOUlTL2o5UkdZMGpzYUZGMFhwMlpl?=
 =?utf-8?B?TlJ3REMzbW1sckxuVVhxM29kVDlhRjVHT0I2bmFqVjBhV0R5RWw1UWZ6UGl0?=
 =?utf-8?B?Sm5rU3ovblREWXlTRVUyT3k0Ni9Kc0lVNk1sRCtrNDQrMEVoV01QNHVkQ2hJ?=
 =?utf-8?B?TllzVE5GRFRaaHBCUXg0c3hLUW85WDBTS0l0MitDUjJjaVhydnRKa2FMZ1Iv?=
 =?utf-8?B?L0RQQmVabU9UNjNYdUNKdXpxNzUvZFdRYnBxbWNHVURUYkpydXMrWHE1VEcr?=
 =?utf-8?B?Myt3SkpUeGZYcVNzajJQMFNJbGgwMTZ3a201aDV3Z2FUcWpSaTd2bi93RkpY?=
 =?utf-8?B?cGZQVEQ1bDlDQ09XZno2bjJjS0M4QjNpQTN0R1JzSU0wYko4ZDVBMnVhazBS?=
 =?utf-8?B?bTk1L2pGWGl4QkhlejBaNTVJbW0rNmJ2QTNtUENYTWRxeEhiWUNYNHdRc2Zq?=
 =?utf-8?B?djRGbzc2MndYQlQwMnhNb0tVV1B3c3lOUEdrZWdPQ3FrZDBUU21sTmhpOVNq?=
 =?utf-8?B?QnN6OGF3dW9oUXB0MVQ4TEVTOGlDU1BYVlBGZXQ3MzVtNTNleEhXQ2h5Z2I4?=
 =?utf-8?B?Z0svWTUrUWtMZWJwc01seTM5WGdqWU1BKzUxSGYybk9CTkg4WitJd1dTMlZT?=
 =?utf-8?B?U1Y1ZWJGZHc1dzJLMTFBVGVrV3IyamliNWFJbytlZzhJMThHdlF5NmI1VWFr?=
 =?utf-8?B?MXorOVZrZ0tHdEJYUGhXcExUSjJUV1FMc2o2blpXeHo3UHAvMVRIVnFsTVcy?=
 =?utf-8?B?SGhzNWo3OHNXQ21EWkVrdHlzK2hma3piYlJkRHlCNEJSR2pBSTFXZHd1YVNP?=
 =?utf-8?B?TlBFTFd0dDVIUVBLTmdSaEhyL092dDIrSFZnNCttdlM3Tk1ZbjZpUk03TDNI?=
 =?utf-8?B?L0FicXhGa2F0OVdSU1RXN3Voa1RGQk1SZnJwa281NDlMSTNEY1NSNUp0c0NP?=
 =?utf-8?B?bEhsaWY5MkhSVUtJZU1kM3RqNkVGaVp0TVdEdTB6N2Z6L3hvQUxMS29OSW0w?=
 =?utf-8?B?N01HczZqS3ZsbjFBNW1ienFBcGxkOWl2T1BiRmJPWjNLVVFIR1JOK3g0NEhD?=
 =?utf-8?B?WGJzOVQyTWhDc21hSDcrQ1E5Z2dSclR3MC9CYUpxMlZtNldaV2t3TXF4ZmRo?=
 =?utf-8?B?d1ZjYS9mYlRwc05tbzVLd1FSYXJqUVRoemNUeDRYTVBScXRBTzU5TUJuaFhZ?=
 =?utf-8?B?QXlDRmh6SVlJV3orL3BMeVFkdnlHdVV0TytaejZ2NEMxa0dYWTdnWlNsV2Vy?=
 =?utf-8?B?ZGoyTURMeDFQYzFsYWdJVENWNW05ZWNRMVp2bDVZeUNtUHFJTWZIM05IQ2t3?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87214C0943B4894BAAFC0867C48EE496@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR03MB8697.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52883f3d-7f14-4d16-7107-08dc39d153a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 09:23:59.3585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izcM8Yi9NcNEJNEGpSmnZwT9vwh+Aba7x5I87nuaIO9S7JfHZB0wOT9nzKgjHpHsFBm2xBf2PoDQg5IcWmeLvl1cePLPR/w7f1DuAJBvx5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7426
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.609100-8.000000
X-TMASE-MatchedRID: 9zTThWtzImunykMun0J1wkD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
	bY7xfgXYtdqVep+vHB6TnOeejF/wC7BAQLqGlKiv4pdq9sdj8LW+1Vx7rDn4r9qCxkzSpW/XrRG
	iaFY8lpAoG7EoDeLDfGLP47+knfp2XZXnjooQdcgZexXWjVVC3K3hEnwF428KXE5Co/aUb2CjxY
	yRBa/qJRVHsNBZf9aR9TBysq4cSBYLbigRnpKlKT4yqD4LKu3A
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.609100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D681E3DA7711A93AB72F7BDAE395880CBD2348AC39BB597DB818862E22D375AC2000:8
X-MTK: N

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3UgcmV2aWV3aW5nLg0KT24gRnJp
LCAyMDI0LTAzLTAxIGF0IDEwOjAzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3
cm90ZToNCj4gSWwgMDEvMDMvMjQgMDM6MDEsIFl1bmZlaSBEb25nIGhhIHNjcml0dG86DQo+ID4g
VGhlIHBoeXNpY2FsIGFkZHJlc3MgaXMgYmV5b25kIDMyYml0IGZvciBtdDgxODggcGxhdGZvcm0s
IG5lZWQNCj4gPiB0byBjaGFuZ2UgdGhlIHR5cGUgZnJvbSB1bnNpZ25lZCBpbnQgdG8gdW5zaWdu
ZWQgbG9uZyBpbiBjYXNlIG9mDQo+ID4gdGhlIGhpZ2ggYml0IG1pc3NpbmcuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci92ZGVjL3ZkZWNfdnA5X3Jl
cV9sYXRfaWYuYyAgICAgICAgfCA0DQo+ID4gKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4g
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRl
Y192cDlfcmVxXw0KPiA+IGxhdF9pZi5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21l
ZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRlY192cDlfcmVxXw0KPiA+IGxhdF9pZi5jDQo+
ID4gaW5kZXggY2Y0OGQwOWI3OGQ3Li44NWRmM2U3YzI5ODMgMTAwNjQ0DQo+ID4gLS0tDQo+ID4g
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRl
Y192cDlfcmVxXw0KPiA+IGxhdF9pZi5jDQo+ID4gKysrDQo+ID4gYi9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRlY192cDlfcmVxXw0KPiA+IGxh
dF9pZi5jDQo+ID4gQEAgLTEwNzQsNyArMTA3NCw3IEBAIHN0YXRpYyBpbnQNCj4gPiB2ZGVjX3Zw
OV9zbGljZV9zZXR1cF90aWxlX2J1ZmZlcihzdHJ1Y3QgdmRlY192cDlfc2xpY2VfaW5zdGFuY2UN
Cj4gPiAqaW5zdA0KPiA+ICAgCXVuc2lnbmVkIGludCBtaV9yb3c7DQo+ID4gICAJdW5zaWduZWQg
aW50IG1pX2NvbDsNCj4gPiAgIAl1bnNpZ25lZCBpbnQgb2Zmc2V0Ow0KPiA+IC0JdW5zaWduZWQg
aW50IHBhOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBwYTsNCj4gDQo+IElmIHlvdSB1c2VkIHRoZSBy
aWdodCB0eXBlIGZyb20gdGhlIGJlZ2lubmluZywgeW91IHdvdWxkbid0IGhhdmUgdG8NCj4gZml4
IHRoYXQgOy0pDQo+IA0KWWVzLCB5b3UgYXJlIHJpZ2h0LCB0aGFua3MgZm9yIHlvdXIgcmVtaW5k
Lg0KPiBJcyB0aGVyZSBhbnkgcmVhc29uIHdoeSB5b3UgZGlkbid0IC0gYW5kIHN0aWxsIGRvbid0
IHVzZSB0aGUNCj4gYHBoeXNfYWRkcl90YCB0eXBlDQo+IGZvciB0aGUgYHBhYCBtZW1iZXI/DQo+
IA0KcGEgaXMgYWxzbyBpb3ZhLCBkbWEgYWRkcmVzcy4gQ2hhbmdlIGl0IHRvIGRtYV9hZGRyX3Qg
bG9va3MgbXVjaA0KYmV0dGVyLg0KDQpJIHdpbGwgY2hhbmdlIGl0IGluIG5leHQgcGF0Y2guDQo+
IENoZWVycywNCj4gQW5nZWxvDQo+IA0KQmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCj4gPiAg
IAl1bnNpZ25lZCBpbnQgc2l6ZTsNCj4gPiAgIAlzdHJ1Y3QgdmRlY192cDlfc2xpY2VfdGlsZXMg
KnRpbGVzOw0KPiA+ICAgCXVuc2lnbmVkIGNoYXIgKnBvczsNCj4gPiBAQCAtMTEwOSw3ICsxMTA5
LDcgQEAgc3RhdGljIGludA0KPiA+IHZkZWNfdnA5X3NsaWNlX3NldHVwX3RpbGVfYnVmZmVyKHN0
cnVjdCB2ZGVjX3ZwOV9zbGljZV9pbnN0YW5jZQ0KPiA+ICppbnN0DQo+ID4gICAJcG9zID0gdmEg
KyBvZmZzZXQ7DQo+ID4gICAJZW5kID0gdmEgKyBicy0+c2l6ZTsNCj4gPiAgIAkvKiB0cnVuY2F0
ZWQgKi8NCj4gPiAtCXBhID0gKHVuc2lnbmVkIGludClicy0+ZG1hX2FkZHIgKyBvZmZzZXQ7DQo+
ID4gKwlwYSA9ICh1bnNpZ25lZCBsb25nKWJzLT5kbWFfYWRkciArIG9mZnNldDsNCj4gPiAgIAl0
YiA9IGluc3RhbmNlLT50aWxlLnZhOw0KPiA+ICAgCWZvciAoaSA9IDA7IGkgPCByb3dzOyBpKysp
IHsNCj4gPiAgIAkJZm9yIChqID0gMDsgaiA8IGNvbHM7IGorKykgew0KPiANCj4gDQo=

