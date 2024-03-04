Return-Path: <linux-kernel+bounces-90881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D0887063E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A1C1C210BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADCA47F69;
	Mon,  4 Mar 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eOTzxmnd";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NElBIX+I"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F047793
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567570; cv=fail; b=hQr8gjRQbhZhxjNMrvOnY1jSGOeZv0neTaEiBs4rUmIux9+nF6LQI1y3z83LRETrFG75LDX9lsNToEguIQI+2fsQHl/ts2o+LVOUomviANSnm/N2qMI6eQiR4FOJkzmoQTCafgpWcx1M9awQlR/JIt7ap+lL40YPXiZhKQE+Bis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567570; c=relaxed/simple;
	bh=dOS5aY1dFcVqHfaoM2Kl4NF0ILnvYuk3C4g8eadXBXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sjBr1RCHu0HqT3Udnwa4ULlGfOIC8XRUTiwokFFHGUsFqjVOF54Eifq0vveUJ+zIeqy9xdqr0fa/DpOlNCRAYLRa4t0cSQuW7TaBp+ABVWSfQ+6MkLszyhohE3MkOIFRp0BjdZ4t2AS6KPbF5SEVpXzqEsZ4ND5sBPUcKkIKhrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eOTzxmnd; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NElBIX+I; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3c405aecda3f11ee935d6952f98a51a9-20240304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dOS5aY1dFcVqHfaoM2Kl4NF0ILnvYuk3C4g8eadXBXs=;
	b=eOTzxmndqoBWuIQO8WY3l+JE7esSoP8KpImt/yv/39pV9YMiMfDK2w0dKse5/oZ5ddbK0M4Vz7ALCwBDbHQPUV96LE+sjj3pfTK18ghBzTJfRee+K3Q8igRUFnkAVUoxpK/V+eD/jFLQFSUiNvJreKpvvWQ5DLej9y9/28+Hqio=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:99880a5d-7028-43e2-a08d-c4dea440b389,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:3cc89884-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3c405aecda3f11ee935d6952f98a51a9-20240304
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 89744404; Mon, 04 Mar 2024 23:52:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Mar 2024 23:52:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Mar 2024 23:52:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO/Qo2ko1acH//pZyPAmqT0D8H7SgVxPzc6Ss0uV4w3RZpbXOKOMzVV03fbFLY0pkXyrp1oz7atwUJ02vQsrTAu30TvIJaJoQa/mEpEdf1yOsLhqhMzqOcZyKlQKFYVIuukJ/95/jP/caaD+wUmn6DYcSQzHGm5gM6NB21wc40hnlWVTKVnrmW6mo9ghVVVVq2AT5mluF8R5HGsYZ/NPg2kc5z8r6e9ayi2coR27mGKI0vM31h82pOoczJJGVxpw9dup5z1EdqroUJofAme+fV4bz24l380Y4MQkKXqrYOToIEUosae6z9hg4/22mY4DOuJGs0utSVeT+yyDroiT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOS5aY1dFcVqHfaoM2Kl4NF0ILnvYuk3C4g8eadXBXs=;
 b=iIceY05LVSQiadv5mgw/7gHCG/11DnujPPzKx2zhxtaH4ihd2OkVymua3Qb2oRGYx66MVUgUdsQFZlbTCnQJSlksoAZz8rIrSz6MIuz99FZmLRLw0DiPTRhCoLtQTYzk3jrJCdK71jQpn1t+HYuU3GrbVux9QOZ7iU+4PgojuFIskx/vKddsZ/fRtOMkyXS0Q0jaJ9XyhhL3Zokxw40E42iXG4i/crfHOqPP5gWSNtb3QQkUwfQ8q7IqTEkwf0COpkm9yTLi9R6YEG17wVhxGOddT7L4cNKnWUNAfZ177PI6XDE7jTMUh3cwSryAO6ZU7VnqBTCMr/I4bhy+z6Mw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOS5aY1dFcVqHfaoM2Kl4NF0ILnvYuk3C4g8eadXBXs=;
 b=NElBIX+IH8HaO1izxWZbNXJIpSmEWPyTXLMwzdsjP/F54ZsTpXjFubJ1c4YYuH43VDR7NtrU0aktFgxylo8BVXnB8flDhA2uH6KgAPuOfagFBQtynBF2Z5S9iGZJdbGqKiFbdIEejd+IEFWau1nsmI6OLdX/VL6yS3ayuovpKIU=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB7807.apcprd03.prod.outlook.com (2603:1096:990:3b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Mon, 4 Mar
 2024 15:52:38 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 15:52:38 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [RESEND, PATCH 2/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_mem_move() function
Thread-Topic: [RESEND, PATCH 2/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_mem_move() function
Thread-Index: AQHaa+cD5VzcLYGY6kyxoI5akHVlTLEm4qqAgADdfYA=
Date: Mon, 4 Mar 2024 15:52:38 +0000
Message-ID: <c04fd6aeb0eb4226c230ff15b4b47bdd325c908d.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-3-jason-jh.lin@mediatek.com>
	 <fc7bf56d8bc962d3f8d28c9aeab1e2282acccca0.camel@mediatek.com>
In-Reply-To: <fc7bf56d8bc962d3f8d28c9aeab1e2282acccca0.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB7807:EE_
x-ms-office365-filtering-correlation-id: cdd32559-be78-444f-d6be-08dc3c631e49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mQ7s8qUdj1zxeN8LMEM9Mcyf9D//akZU+xCv+ZKN3NMlKM4QvTirMHKVnJzPUYw2Hm+IDlZRe3jm0bq2nTOQBsxjJbOzOCriMNQg2WZ9JlIUn45d7j6HjaZx4hCQlQOS9WiCI8Qe43xpvAwenw710mbyweDmDRW615q5dfj9wE1c15Xz4H7WLXYAtYKYAhlfW/r7Vg3RXABRsE+Q4+z/B4yZWhHGoOacsb8cygNq8dTBh16QDDaQJwIwbUWNOXHee32+t+wVTXKN8Rw5YuWzAVX539mFG1Ao8qt7uKdswIguBHKoG+YqcZC492oBmoP9gFGNhNNyxc+cpPmRaV08j07ayFzV7WmlpMTUn/zkpC0DKirNmwdM/Iqe+kwEEbFnl6P7Qya1vc4fSiG7liVSTv7ZhWBEjvLeXySr2m1xTACNxfqVsPvePwapcfG9DHzlfIxU7fR5ZtdtzszVOROoqO3lxw4vF9tuS2PUUsXKguQhzWMZiSjHn4LB4nzXgPWlhoH1Klywjms5SLCa8Ys7S23HuslXnRFr88+OiJrG4rNWi7cEXOukufXDr2WUhV0Sfm4QIiP3EPcLkt/xjPZ8L6R6VR1nK4IRn2Q1nw/oyy2en+ulylJHrFEKMHBv12CEC+BvmFaNf9dK3M7okdaLcouUl3GFUU9IOI7Xdv4AF7IV0zBP0AYvwotP7mDyOvSICbE+BE5W3rzdlxyRIaZiu+JgJz8uzmbdFlTrG6wkq3Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUJqazFSakVhZVZXUml1R0FDV25TUU16Ky9XUk1tNUkrVjczWTdyTjMwYks1?=
 =?utf-8?B?Q1ZUb3JHQktncVpEclI5OFJkUytGbFMwTHpqT1JISXZYSTVnKzVTTkg4dVVL?=
 =?utf-8?B?azBWR3BjUk1NN1pvQWJ2L0U2OVNvWG5KN1diSUhsTkd3U2FaV0pGL2pPemtY?=
 =?utf-8?B?U2p0VnBHSWtXVmN5ZW92dHBSYklDMlNnVmI4OElWaEpMVS9YTnVETVh0U041?=
 =?utf-8?B?dFhDbTVEU0VGZzhUNjRHM2oweG1JV0wzQkp2MDlPUFl2Q21ZajRsWUQyc3Rt?=
 =?utf-8?B?WGIxZ2t1WTlvdGdwZEhVVzd3aUJVaElYcmlCbTBLQVgwczFzVHZrRHQ2Q0xM?=
 =?utf-8?B?VWVPNkljU3NudU9Ob2d0M0tCMTVIUVZJR2NHKzJCMUkxQVpiMGlleitXd2FL?=
 =?utf-8?B?cHpmcHh1QTBieXhBMjA4dzB5ZjZ0VGZ5YjZ5MjltZHVDQkpjNS9xTC9NNG42?=
 =?utf-8?B?TGdyY0NIazNpTmZyV3pMUEJncTM2eXFaZWw3TWdCd3dHVFJYc2pyY01COXBI?=
 =?utf-8?B?cVhWZUZGTy9sTGZreEhWMGNYajVQczZrRG5vNTlEd1FKMzVjV0hTWUdraERF?=
 =?utf-8?B?TysweERMWmV0N05LcDJWRWxQWEY3NlN4WFllWmdHVjRKcHZmWjZ3YmhreUpN?=
 =?utf-8?B?MnNXb3ltVDVvbW43a3hpdFFLN2ZTa0U4dWtuN3RiNTZOYjdHc3FoMlV0Z3lR?=
 =?utf-8?B?Mm1oVEJacXpzenpibC82bEdmUnNDSUNNRG1yU3hPV0p1NDdiMTFFME15ZXhx?=
 =?utf-8?B?WERZZktTUnNuc3R4bUtQZ0h0NHAxRjhWakdRaENYcmhkdTg5emRIdVRSNm1n?=
 =?utf-8?B?YitjakMrQ3VuM3RHM0lMRmsrVnM4dU1rTTZHY0lQdjdlZTk3WDllaDhMaEk1?=
 =?utf-8?B?TERYZDN2bDQwWGQzWXlQcTRzdjl2T25iM2NjTG84U3pTM2t6NUZvL1ZJYngw?=
 =?utf-8?B?WkJpVTRnSjZSWEp2UWdBUmJveDl1aDBFR3BUVlRKSFNWMnVuOFl0cmhBZ3FC?=
 =?utf-8?B?NkVxNDYrNGNnVDNBMmIvQkM2VWFpd3Z4SUhxWm5BRWdSbjVXMndnL1pUMDJT?=
 =?utf-8?B?a2gxckJrZ3hpQkpTdGdqL1puQndHVllqQUw0RDNHTExlRW5JbThBWEhEQmVV?=
 =?utf-8?B?bEcxUDVrNGFFM1FBRHpNUFFRSC82L1JvRFlIUjk2alo1dUY0cmw0c2RHZXA3?=
 =?utf-8?B?YWhVTUtkc3MrSlM3ZDluSXNuR2FJekdaTXBFcXFreE10aFEzbHdkS2ZjTWQw?=
 =?utf-8?B?U1c3TEIzekFQdk1ZNkNWdk80ajV4K3M5VVpuNis4UjF1MUlya29YK1VoUzZK?=
 =?utf-8?B?aWRXcnFZd1RqR0pvTEIwSU9UTGFkc1hEdFo0ZVFQMFQzUDJ1eGJPRG05RnFT?=
 =?utf-8?B?MzFrVUNnTVhlakFGUHcvcVhjQlYvL242V2tKeUxTN1VlRUFObFlBdGpVU3do?=
 =?utf-8?B?bjM5aHpqTVFjcStSbW1yODlrQVB3VGN2WklyVkl4T1hmTFc5akRKRmszM1VN?=
 =?utf-8?B?bWtuMFlMUDJZYlgzVXJrdVY4aVAzMEZpWXlVazVPUCtSbjJ1NXptRWNBVzdN?=
 =?utf-8?B?MzRUQXplSDd3ZTRHNHRKY2xma1V1U1puQzhlZzBXb2ZaN1Q2VTVkbnF2Y1VW?=
 =?utf-8?B?TGdlSzlBYVJ2MUNYWmg3TFc4UlFsM0JyY3AwNXFIVGZPUWZmM0duaW85eVhT?=
 =?utf-8?B?SGZ5cFFsWFNxTnBnNW1MaURHc3ZrdDg1NkFhMjFEbDlaQy9SM2tISXhnVUJF?=
 =?utf-8?B?cVZWUVRLQ1pOZmRvaXVvNnV0YndlRXlhbkwzZGJ3em0rWGs5WWdyK1dWNWc3?=
 =?utf-8?B?SVJrUCt1a2lDYk9Jcy8yK0gwaDNMdXg5bHBpaldnNkpTeGYyNXUvL1lVbzlC?=
 =?utf-8?B?ZUxNNXBRZDE1aGlHQnZiTjVoZlQrR3h2a2FMWlJJTkJOZ0RWZlRyL25seS9w?=
 =?utf-8?B?dzZvV2JLQ1BJUFNNV1E0SmNnVzhHaFN6azhhTkVQejFmbTY0bm1meG5LbXEz?=
 =?utf-8?B?TEV4aE84VXZBV1BnbFBnLzB1a2JGc0RaYVpLUmViYktPYTlEWUljOXBpd2xW?=
 =?utf-8?B?aUl3bFVncFI3c0MxOTJkaTVveEVtQStjVVF2TXY4NldoZkh3VHhiZWMxcHlP?=
 =?utf-8?B?dVBCMC9uemFpZUVLYTVPU2JmRWliWkd2V1I1dzRtUnRIRHhuMlRNbnd2Misy?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D832332ED344D24BA89C612D4DDE611A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd32559-be78-444f-d6be-08dc3c631e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 15:52:38.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zcKTQoYDjoHOAGBKHX2qCo2VqyHFxd9c28VYpjnpweKMA/BXbMnWtLTJNObw47o0Mhc8Spe9JXq5y7tXRk1fFUZWYDBju2pa/jOAWeplqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7807
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.494200-8.000000
X-TMASE-MatchedRID: zGP2F0O7j/voSitJVour/eYAh37ZsBDCA9UhA/EMrwNV1lQ/Hn0TOskU
	hKWc+gwPo0hcL4S9vYNWz2eiIuWGmklOB2P1GQ+kVU3yVpaj3QyQoBr+SFneJA2Y8xyy93kW4On
	UpIjOuGHwDJaTY0Uw1uKOmN63egZIsPJBU3ZwaVESDAzxRL+lMaOI1u80g4PZGNAPebYwJ/tITG
	5SYWUUalQrQWfNw93SHgNlvZ/ZyI4M8jMXjBF+sNIFVVzYGjNKcmfM3DjaQLHEQdG7H66TyOk/y
	0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.494200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F2857667565B6AF05DCDE63ECBDB03B9A6C1FFB58F140093153EC7C411485ACC2000:8

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyNC0wMy0wNCBh
dCAwMjozOSArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyNC0wMy0wMSBhdCAyMjo0NCArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IEFkZCBjbWRxX3BrdF9tZW1fbW92ZSgpIGZ1bmN0aW9uIHRvIHN1cHBvcnQgQ01EUSB1
c2VyIG1ha2luZw0KPiA+IGFuIGluc3RydWN0aW9uIGZvciBtb3ZpbmcgYSB2YWx1ZSBmcm9tIGEg
c291cmNlIGFkZHJlc3MgdG8gYQ0KPiA+IGRlc3RpbmF0aW9uIGFkZHJlc3MuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDI2
DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaCAgfCAxMCArKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgMzYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCBiMGNkMDcxYzQ3MTkuLjNhMWU0N2FkOGE0MSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTI5
OSw2ICsyOTksMzIgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3NfbWFza192YWx1ZShzdHJ1Y3QNCj4g
PiBjbWRxX3BrdA0KPiA+ICpwa3QsIHU4IGhpZ2hfYWRkcl9yZWdfaWR4LA0KPiA+ICB9DQo+ID4g
IEVYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfc19tYXNrX3ZhbHVlKTsNCj4gPiAgDQo+ID4g
K3MzMiBjbWRxX3BrdF9tZW1fbW92ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBz
cmNfYWRkciwNCj4gPiBkbWFfYWRkcl90IGRzdF9hZGRyKQ0KPiANCj4gcmV0dXJuIHR5cGUgaW50
Lg0KDQpPSywgSSdsbCBjaGFuZ2UgaXQuDQo+IA0KPiA+ICt7DQo+ID4gKwlzMzIgZXJyOw0KPiAN
Cj4gSXQgbWF5IG5vdCBlcnJvciwgc28gSSBwcmVmZXIgdG8gdXNlICdyZXQnLg0KPiBNb3ZlIHRo
aXMgYWZ0ZXIgdGhlIG5leHQgdHdvIGRlY2xhcmF0aW9uLg0KDQpPSywgSWxsIGNoYW5nZSBpdCB0
byAncmV0JyBhbmQgbW92ZSBpdC4NCj4gDQo+ID4gKwljb25zdCB1MTYgdG1wX3JlZ19pZHggPSBD
TURRX1RIUl9TUFJfSURYMDsNCj4gPiArCWNvbnN0IHUxNiBzd2FwX3JlZ19pZHggPSBDTURRX1RI
Ul9TUFJfSURYMTsNCj4gDQo+IEkgd291bGQgbGlrZSB0bXBfcmVnX2lkeCB0byBiZSBoaWdoX2Fk
ZHJfcmVnX2lkeCBhbmQgc3dhcF9yZWdfaWR4IHRvDQo+IGJlDQo+IHZhbHVlX3JlZ19pZHguDQo+
IA0KDQpPSywgSSdsbCByZW5hbWUgdGhlbS4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+
IFJlZ2FyZHMsDQo+IENLDQo+IA0K

