Return-Path: <linux-kernel+bounces-129017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4020896338
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE4C28144C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056674086B;
	Wed,  3 Apr 2024 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cRnLTI1F";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="riWJjs78"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170BD79F2;
	Wed,  3 Apr 2024 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115932; cv=fail; b=Dih2gDdhSRsmO6juN2k+OxsFhKyOsmPGUeUfu/QvPflQDkbe1ven3g9f2pBwojqFCb/wBAJWOSn0Ucv1a47InYYQVKY/v+RJaCEOnb2Dyz17eeHyagVuYM6sPjJWsE2mgD1p5JZOZ4j1f4GhEU9f0Xh0MMCz8K7gc4UJApv1xcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115932; c=relaxed/simple;
	bh=em8XVhqU085Y+MF18CsBpAcVWC+x1o6VkEVhZ8Gqjqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bcmBGSzK39P2Se0vwXb9MnwJsQkZ/qNK4dNgfC3GY7FbwLUQM84YkhdN44YJ2D/HyO2t8ruEiy6mhKLVY6pbji5QCOaa/26VWtf8rXm+1jQNDZ1gBovV6I2mFm6H+YCyrdC26Mb4ZjjR6zlxhcdpYW63RFxwEe/Y1saqsbVSMA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cRnLTI1F; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=riWJjs78; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9ab54454f16c11eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=em8XVhqU085Y+MF18CsBpAcVWC+x1o6VkEVhZ8Gqjqw=;
	b=cRnLTI1FzGMLpySHBWsuE8mNMRzv32MUvzcehUgYWvykuW4u7SJR4sVXM0vtTIEez0AocGpEbbpjAgl7RuwthBY8wlh2m+9BtfneobYdzLDZUW8nKrazfid0p7YS1MGrmiE3PcivbS/vHuqoqo3+AujbwEwC9s/uTrjFvnO42lY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:09ff4bd9-c4e9-4c00-bc9c-4edb4714569e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:e0d0a500-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9ab54454f16c11eeb8927bc1f75efef4-20240403
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 940931751; Wed, 03 Apr 2024 11:45:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 11:45:23 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 11:45:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScoCD8UHdj0NYfSoBYlnAxk1au+oBtGdRuwtZo0Iu5WL/0uyVopYF8zoPQHZ4SoZCpV6cMqOmq4aKSVAOYrkgVULli/UknX0B9i5X1Is3LvwicTRs4s2UnrqfoZUJxe1fsJbuGNjJ5Y2Qhp6wkS1IANTpQUOje11FMCUTpzJM1H30JjIIIV8dU4fnHpEGZ23F+VcUUuDfRgGULecUwLvTEjmK5Q0rSb/RNf8cLcy47bDtdHHC+72ag5EyPiKUiuL9uQs15nkrzAP9gYMWX6IGZXOYj0zdh2ajLsPmD+4yXMdx2qCE2j0WDvhAWzZjYOBFjHJkX2x+rWpj4gXXilcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em8XVhqU085Y+MF18CsBpAcVWC+x1o6VkEVhZ8Gqjqw=;
 b=nklnyDIdYkPcmP2J3dpXA4Fixl4vrrZ1MsTH2S58O0kJhW/6qk+trTaSDpcetiuzp/B+/ZW4MHTqx5CyO5GGAeiga+7baWdh9e4sxQDQPidKg/a4oxGq0UZ306m09xN2ggXF5azHXFfDuGZP1urYvax6y69gdwo5K8V3hws+MKi7rmPfBxshlqvkGeaAKkj5ewAQvQJ5r17d+64y+gRzctDlmNo6zBMgIBDS+u7BAws81n6YjWEaZzPLDZvRpmF5vjUliMxBU7unsejlSKmeGqzlJO9lCn+IkxRWy2qrTb3FjjSnu64NROnecTjJe+4B/6uwIYXlfNG82N07HoTsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em8XVhqU085Y+MF18CsBpAcVWC+x1o6VkEVhZ8Gqjqw=;
 b=riWJjs78ZaDNd42/f74vpl5bxRBjOPCXLzSxVXJuK1mdU5wqJaiPHZTUwRbzRcfYjOT8M6KpLwZvXJR0FgYhCS5302X4fS8VcgcXATo4mcBcfC5/WgWnDWQv+zplCKjl/rXCuw0Rk9aet3XPsIZsqJM/E8FBvAtKubL1E7RuPd0=
Received: from OSQPR03MB8697.apcprd03.prod.outlook.com (2603:1096:604:292::8)
 by SEZPR03MB8739.apcprd03.prod.outlook.com (2603:1096:101:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 03:45:21 +0000
Received: from OSQPR03MB8697.apcprd03.prod.outlook.com
 ([fe80::9e99:12:7cbe:1294]) by OSQPR03MB8697.apcprd03.prod.outlook.com
 ([fe80::9e99:12:7cbe:1294%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 03:45:21 +0000
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
Subject: Re: [PATCH 1/3] media: mediatek: vcodec: fix h264 multi statless
 decoder smatch warning
Thread-Topic: [PATCH 1/3] media: mediatek: vcodec: fix h264 multi statless
 decoder smatch warning
Thread-Index: AQHaavWfoJ/oW9t8PkCrph5H3rWpH7FU8JWAgAEsMAA=
Date: Wed, 3 Apr 2024 03:45:21 +0000
Message-ID: <9ba79ccf849054974a937d1d605910cf4c8552d6.camel@mediatek.com>
References: <20240229095611.6698-1-yunfei.dong@mediatek.com>
	 <20240229095611.6698-2-yunfei.dong@mediatek.com>
	 <4949bd54-8c32-4490-ab19-d38796d29ac1@collabora.com>
In-Reply-To: <4949bd54-8c32-4490-ab19-d38796d29ac1@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR03MB8697:EE_|SEZPR03MB8739:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yblHun1i10bvp7LoZODZP+9LZt9et0Xl8SD/nmjXKzq61OycING6KR5ZS2SxA9z9e1+PsppyEE8tgGoY616mBK6goY5xSzbLGWFqf4mz9Q0JzOcx//wz8sLN1JY/iHRFhsAopT5ew3241SneR9Hih6ZvFPBip3EhAmFUIU8kmh20yFYUtvbSPmOYAPRNzLF+8aCdyWpDSmu2fqvBARPixgx0VJ9zLXPmedSSB+I1urLWx77PTnDWQuvIRFDjzmRJj2dMsDSNWP1Tt0xid/Ny2k3aN5+QYx1Zrubd8zxPAxwJQ8ELTJ5DbU0ezkHRClIyj86TnuLK+6CGMF5SlkHOJym+Xe/wIfzYR4c8T4ob3hTMcMHqNhIVrx/o9HTiG30l3fH+Bmp1IP7ekT4LZGEpDrTP/J9a2t80WsltxhVMF28kMm3kcTP8iJTQbUAJ55SEpJqBdYSvu9Y7AbQiO5fjn+3bFzBrs5/r5xcvoPPdxNIaJJUXeUl2dPODVXvlljIfBgRx7Yd+I7XvSfH+xKTmqbnCbBxiN77+JHEMQQndfIkqmZ1qsXMZc6DJnNDDuEHvBRuPs2WA3tmn313+4qdrBPjUHr2ga6SNUPtSt3fNRiqtN9HtAFWkHafX1ldKUE7CAN9n073vS+PLpUfAv4sidsprL4zpRYyoUyqGYCUANt0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR03MB8697.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0t0WFdMemhNcGtCWnlmVnZuT0FRNis4R0ZHVlhreXEzNi9QaWtkekRIRjIr?=
 =?utf-8?B?d3JpNHNyYnVHY1czOFNUeEhPblVZS3BxVkl0cS9qWnArRjZZOWlxaE9LNkNa?=
 =?utf-8?B?WnoyT1M2VWJIVE5MZ0IwR242QkNpc2FwMEpxazRUeXhhKy9CL3o1M2ZNblQ0?=
 =?utf-8?B?eFI1QjcwbnRNdE5BdkdYVFc2OWlCbXNmZ0ZnSnNnYjRGeEVSdnBWdnJxcGFq?=
 =?utf-8?B?YldrQVIzZTNZN3JLUHAzdFlFcFNTbFJxeUVOaGNQUWZvdjlGSzI0K0RmY3pL?=
 =?utf-8?B?eUYreXBnSVplL3dLWDQ1blFjRUZEai9KUWtkMW1DTFNERnJ6Ums5WXliU05F?=
 =?utf-8?B?N1huMVZWc0Y2ZmFCK2Q2TThrb1E4OHprQk01TUZCLzZTTk9TKzkzdEdhc2sv?=
 =?utf-8?B?YjN1clk5d1lxSnNRSnBNNkN5MkpBRW41Zi9LeW15V2RGbHZzNFFSajJMd0dz?=
 =?utf-8?B?NmEveFBOU2pQbFRBNkFtUFdHeUl2WHQ2eUxRYVMwcTFIMjVqTndaZHdPdm1N?=
 =?utf-8?B?bWM1WmgwWE9jTGZTcC9NODZLRmxKTlA5RTFXT2xCeSt0bnRwNEhDcnNIN2k0?=
 =?utf-8?B?dEMxbFYrTVA0elJrV0Y1dnlnWGxrMUl1dDlvOGNqTXlYYkZGaUJKNHhXa0hq?=
 =?utf-8?B?cG1vWFlJS3dXS0pTSXpDcy94L2tiUXBKTHlHYUErdUYyQVJBYkl5c0p5UFg1?=
 =?utf-8?B?aVd4TWdiTmJlckJkamI4eFFCYjVNZml4Z3V0aDdVUkpSVjc2VENFUk1DS0pI?=
 =?utf-8?B?RUhVTXBHRnk4N095U0V6SW1BV3B1ejFueTlWRjdkaExlSFRNYjVEU05UVVpD?=
 =?utf-8?B?VERhQ0NvYlRESXFMdnRxL1VkUFhLNHlzcXBQbFZ0WVI4MU1GdjVGaDdZZjMx?=
 =?utf-8?B?T2FkamtIVnBSNUhIWk84OTZBcHg3OEFTcFZFUEczYUJEV2drMnlsVk9JNTEw?=
 =?utf-8?B?ZmUwb3JvaDMwc1lvZVVEem9kMURyQjNWa2JrMVUxV3p1OC9LZjJuOHF4VUxi?=
 =?utf-8?B?QzJQWDRxMHFLcndnaVJ3VmdGZExzMTErcFBSbmdYUlVGemlzSHptRnhPODhi?=
 =?utf-8?B?MG5RUEVTVlY1WlVzMkg5SDlOUXloQU5GeFA4dzFJUEpWUUxXSFhTWng5aG1p?=
 =?utf-8?B?bjI5d2ZSMUFVRW85czJYR3pwS0d2NERuOE5qM3ZiVURTQmNIUWh0YTQrVU9W?=
 =?utf-8?B?WW1zK21yZTBlOEZaRSs0MXVVVVMrT1QxU3lhRTl0T2lXdjk4Vi9XVGpLZi9y?=
 =?utf-8?B?SzIrSUNpbmlyTmU3TURKWGpXUEFNSWdkSlF3QllwVzRZajdBQkZQTHFpRnBr?=
 =?utf-8?B?TWNZdTlCMHlmZFpHclVrSnRxdDhidjllaGlWTENJK0JFQ1VXRkJxYnZNM3dX?=
 =?utf-8?B?OGtjdmNObFJIS1VQYTBiMkQ2VHdicDBRWWhtR2h4VlpzZk5UZzJSTk9MeVJO?=
 =?utf-8?B?RU5YQlBrNUhmdWZWajBvZU1IaCtNMjQ0Tm5QdlVaWDd0ZEk4d1VOY3JwRy9H?=
 =?utf-8?B?L1JqakhmallvOHk2TmhQMkJtM2o2b3BhaE1vKzlXSHN1V29KcHptZTRmeDRw?=
 =?utf-8?B?bk93VHVLZ25Ma1JvQUhPN2JVeHRKK1NiY1VQcElINU1iTnE5YkM3MHpaMnRK?=
 =?utf-8?B?TDI4L1htcmZmSHVsLzgvMHdnVHVxMFF1RzBDWEZGNk5UaDdQS0NaV0NQZXdM?=
 =?utf-8?B?UkVYZTBEcDdIamtlSU1pdGZ5bkRhMCtwTFErdFZzZEdTQXQ0eDR3NXhnSVpF?=
 =?utf-8?B?RzE4Y2ZDa3IwSUFLS0hDV3RnMkZEY2NpeFFvL2ZGUFJ4UUZjYUtGQTdhTlpr?=
 =?utf-8?B?ZiswbGNBQnF1R0h1NXgzQkRaZUJnVGtGOUZSNmxRVU9vSnV1SVJlc252ZHc5?=
 =?utf-8?B?am11cE1BM1liVTU5Rk05WDVkWDMycHdoRldLK0hkMWMvWDR5ekMwWjRQdldY?=
 =?utf-8?B?YlhNT2VBS1RsakVKLzFZMFliSDcwRjl5STVnTjhsUm12Smh4R1hNR2pZdUZm?=
 =?utf-8?B?cWxNQjZyeUtFT3FhVWxLTGFzU2FQZ0F4eHI2dGtJMU5vNnFGNThJa0YwcUN4?=
 =?utf-8?B?YkNsUGVpMlZVVlRyZUlkeDlGSEYxckY3L3dEbm9KUUFoNjRVb3BjUFpML3dL?=
 =?utf-8?B?aE4xZFd5STJ2a3R3clJlbW53VmdvY3pOazZzc3pjUVFSTHZpNnVQYWdScDhy?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A84BEB081F24B048ACD304DE3B6F2FD3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR03MB8697.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f6ae37-08df-45ee-ab65-08dc53907c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 03:45:21.0606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIa6k50IVIw7eyr+9n4xw03pCpoQVnnN9/KKof1klgDYzNJO0E9r33ewlmsECdgfN4kIAE53cgj/mywoaRyjaV4lDAy7oyIPQv/VEUlycxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8739
X-MTK: N

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlld2luZy4NCk9uIFR1
ZSwgMjAyNC0wNC0wMiBhdCAxMTo1MCArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8g
d3JvdGU6DQo+IElsIDI5LzAyLzI0IDEwOjU2LCBZdW5mZWkgRG9uZyBoYSBzY3JpdHRvOg0KPiA+
IEZpeCBzbWF0Y2ggc3RhdGljIGNoZWNrZXIgd2FybmluZyBmb3IgdmRlY19oMjY0X3JlcV9tdWx0
aV9pZi5jLg0KPiA+IExlYWRpbmcgdG8ga2VybmVsIGNyYXNoIHdoZW4gZmIgaXMgTlVMTC4NCj4g
PiANCj4gPiBGaXhlczogMzk3ZWRjNzAzYTEwICgibWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IGFk
ZCBoMjY0IGRlY29kZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1bmZlaSBEb25nIDx5dW5mZWku
ZG9uZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vdmNvZGVjL2RlY29kZXIvdmRl
Yy92ZGVjX2gyNjRfcmVxX211bHRpX2lmLmMgICAgICAgICB8IDkNCj4gPiArKysrKysrLS0NCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92
Y29kZWMvZGVjb2Rlci92ZGVjL3ZkZWNfaDI2NF9yZXENCj4gPiBfbXVsdGlfaWYuYw0KPiA+IGIv
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci92ZGVjL3ZkZWNf
aDI2NF9yZXENCj4gPiBfbXVsdGlfaWYuYw0KPiA+IGluZGV4IDBlNzQxZTBkYzhiYS4uYWI4ZTcw
OGUwZGYxIDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRp
YXRlay92Y29kZWMvZGVjb2Rlci92ZGVjL3ZkZWNfaDI2NF9yZXENCj4gPiBfbXVsdGlfaWYuYw0K
PiA+ICsrKw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVj
b2Rlci92ZGVjL3ZkZWNfaDI2NF9yZXENCj4gPiBfbXVsdGlfaWYuYw0KPiA+IEBAIC03MjQsMTEg
KzcyNCwxNiBAQCBzdGF0aWMgaW50IHZkZWNfaDI2NF9zbGljZV9zaW5nbGVfZGVjb2RlKHZvaWQN
Cj4gPiAqaF92ZGVjLCBzdHJ1Y3QgbXRrX3Zjb2RlY19tZW0gKmJzDQo+ID4gICAJCXJldHVybiB2
cHVfZGVjX3Jlc2V0KHZwdSk7DQo+ID4gICANCj4gPiAgIAlmYiA9IGluc3QtPmN0eC0+ZGV2LT52
ZGVjX3BkYXRhLT5nZXRfY2FwX2J1ZmZlcihpbnN0LT5jdHgpOw0KPiA+ICsJaWYgKCFmYikgew0K
PiA+ICsJCW10a192ZGVjX2VycihpbnN0LT5jdHgsICJmYiBidWZmZXIgaXMgTlVMTCIpOw0KPiA+
ICsJCXJldHVybiAtRUJVU1k7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAgCXNyY19idWZfaW5mbyA9
IGNvbnRhaW5lcl9vZihicywgc3RydWN0IG10a192aWRlb19kZWNfYnVmLA0KPiA+IGJzX2J1ZmZl
cik7DQo+ID4gICAJZHN0X2J1Zl9pbmZvID0gY29udGFpbmVyX29mKGZiLCBzdHJ1Y3QgbXRrX3Zp
ZGVvX2RlY19idWYsDQo+ID4gZnJhbWVfYnVmZmVyKTsNCj4gPiAgIA0KPiA+IC0JeV9mYl9kbWEg
PSBmYiA/ICh1NjQpZmItPmJhc2VfeS5kbWFfYWRkciA6IDA7DQo+ID4gLQljX2ZiX2RtYSA9IGZi
ID8gKHU2NClmYi0+YmFzZV9jLmRtYV9hZGRyIDogMDsNCj4gDQo+IFlvdSdyZSBjaGFuZ2luZyB0
aGUgYmVoYXZpb3IgaGVyZSwgY2FuIHlvdSBwbGVhc2UgZXhwbGFpbiB3aHkgdGhpcw0KPiBjaGFu
Z2UgaXMgdmFsaWQNCj4gaW50byB0aGUgY29tbWl0IGRlc2NyaXB0aW9uPw0KPiANClRoZSBkcml2
ZXIgYWxyZWFkeSBhZGQgdGhlIGNvbmRpdGlvbiB0byBjaGVjayB3aGV0aGVyIGZiIGlzIE5VTEwg
YXQgdGhlDQpmcm9udCwgbm8gbmVlZCB0aGVzZSB0d28gbGluZXMgYWdhaW4uDQoNCj4gVGhhbmtz
LA0KPiBBbmdlbG8NCj4gDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0KPiA+ICsJeV9mYl9k
bWEgPSAodTY0KWZiLT5iYXNlX3kuZG1hX2FkZHI7DQo+ID4gKwljX2ZiX2RtYSA9ICh1NjQpZmIt
PmJhc2VfYy5kbWFfYWRkcjsNCj4gPiAgIAltdGtfdmRlY19kZWJ1ZyhpbnN0LT5jdHgsICJbaDI2
NC1kZWNdIFslZF0geV9kbWE9JWxseA0KPiA+IGNfZG1hPSVsbHgiLA0KPiA+ICAgCQkgICAgICAg
aW5zdC0+Y3R4LT5kZWNvZGVkX2ZyYW1lX2NudCwgeV9mYl9kbWEsDQo+ID4gY19mYl9kbWEpOw0K
PiA+ICAgDQo+IA0KPiANCj4gDQo=

