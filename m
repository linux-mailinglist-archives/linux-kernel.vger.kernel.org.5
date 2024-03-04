Return-Path: <linux-kernel+bounces-90877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B587062A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830731C21D89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A72E47A6A;
	Mon,  4 Mar 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="US8ObE9w";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZgHFvWsc"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F745BF6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567417; cv=fail; b=Y3Kngf/mW75LZnoge58wqtBzJwWleApUkKzRh+SGkdRslvKKVGVs76mxTaC7Cbp9SnPubqPaCTPiy/bG7/xCt4R5RpSL+JFzAxMz1OvGaQOvdwEKO7TzZpJeCRtl6XSKk17P5BoA/49ELGVdCy6QlPVFrab2PCNmdWz9e+j9w2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567417; c=relaxed/simple;
	bh=TeSiJK/pcJ/zWvbDAm6m0ai5DMB4lDRB8RBOr4OmtpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1s4XZL+Sv0Eu6LfGiZGa+FwB+izokfwI6Y7yAQ+DPBittIg+L8sYKy2/ScfbChj2YqpsJ7BidQy/pR09Jd+LqF9H3xRASGbNfENcu4HpD9TcWCUv7pc3wfHL7AUJMPq2FRdqxBTsIkQWXeVzyk+el7Fvb1azgVOjasINyX/ZKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=US8ObE9w; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZgHFvWsc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e0a39ab4da3e11ee935d6952f98a51a9-20240304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TeSiJK/pcJ/zWvbDAm6m0ai5DMB4lDRB8RBOr4OmtpA=;
	b=US8ObE9wrDOZ7iHacHvBeQ3N1S1zT1jvOmcklvzl+ko4xGvHAFXuHvTmUTbNvatiQJgDbjGY+FsO59XsJru/OhgLmlAtPrKAMeB1Ro4gPWd8fITnqXE70UovBMR4rWxiSGJ8cyMPIrJgkV+QyAkdaa8wv+mYkT/Npi0WGz1Oo0c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:79ac8d27-acd0-48ff-9a34-9f8f5f4e61fc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:f496ff8f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e0a39ab4da3e11ee935d6952f98a51a9-20240304
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 145733631; Mon, 04 Mar 2024 23:50:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Mar 2024 23:50:07 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Mar 2024 23:50:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL+lSGgREZXJfYpFbfmWZqbvrfkA/fyeiytMRicm0uJTQZZFllWyo4bwSMOafs24/yXvwiwoQKrvgWu23+UNi6EydXEZzKWjnMrU3CoGZayFgkDoA3QUgr49lzAL7x98PghAvBkc8/qdHYjurvSsefdwZGB5aiISTxKRHXB+doank+pxbW4UpAm1n8cANtLXpxnArjDAKIwet52SblzKgSUmN244shC7uRXa6icVmjeMl7cTLuGjlDBXSF6Zftsi5un4F4QsvWqPXglI5IEh/N+NiFglYVRuB5NwYk5sj1XhbXyJ2CQ2DHpgUDFFk5LQWoD3OEc2kjo+paAMUKy7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeSiJK/pcJ/zWvbDAm6m0ai5DMB4lDRB8RBOr4OmtpA=;
 b=XFeOcQ9o2GNyudrpESoHlaPDS7NIRxHLUGs/6micyFvbrHDj0Bq6JVvIZ5rpzZzJh/HrUOYzk4xUg/fRDKcqa5Udw8GV0G1+dE2foOUfvQPW8PPqua+hZO8hU65BG/jruvsGBJJTH93YtV2xvyCdvh38vujwmhAJysAzd1LMT6TwS2sT2nXgLBwWPAmcDxujxToZucV1TN9SzvPKvcEJFes/LTWhvuncxKwH84EDzO83visTXz5pwLba0EQ4+GS0Cs1cGprNy4CX2KQmdGztndpxDgoLVQL5VPBXxd6Iep0SgQDkYyQLjP6o2aDon6WxzhueLM/iHeyLE4SoxgHg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeSiJK/pcJ/zWvbDAm6m0ai5DMB4lDRB8RBOr4OmtpA=;
 b=ZgHFvWscg7iKBL22yYUHDqQ93/OSC6edjZs1naRcWw+PHlB1Cel5394zlIyFeN42xDEbzBEnJ/PY+6DrTnf7s63n1qgXB+QcO2BbJt0e7ueTjUymnEjTdR7B3bTAc19YrQe9GOOV0d4hX9LP67hxQmveqNdu3FvNOSr2ZCfmgbo=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB7098.apcprd03.prod.outlook.com (2603:1096:101:eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 15:50:05 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 15:50:05 +0000
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
Subject: Re: [RESEND, PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get
 and set GCE event
Thread-Topic: [RESEND, PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get
 and set GCE event
Thread-Index: AQHaa+cCzUxpGjkGLEWHYFHl9iiQSbEm3+cAgADfigA=
Date: Mon, 4 Mar 2024 15:50:05 +0000
Message-ID: <ceab73ebb925dacc14376f7054e20411612b507e.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-6-jason-jh.lin@mediatek.com>
	 <1d14bad104b8e5c74ffe6c08cbafb4da6e1e751a.camel@mediatek.com>
In-Reply-To: <1d14bad104b8e5c74ffe6c08cbafb4da6e1e751a.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB7098:EE_
x-ms-office365-filtering-correlation-id: 56b4742e-2d84-4ede-abc1-08dc3c62c2ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OExWufsNbFcmg6SlFqngm8ZdaB7Q5cAtYjCPr2Fdr3KrxXEA/sy/obT2ymVulc8+kAkbrD85OS4nRzInS1AlFMNf0VSqipIAH4LbLpZRzmFlgHi2yTd4+q2ZZEC0OzEyMbKdTNoDM9A+mej8S9cMH5Rihap9JdBgMINRwODBKG6xXtWEmqPbTWudnmB/gQcWYxh7ie6QvdCauB8iENuk0aW0Br6mjRCZlM2qaPjbi4tnF4gPI46TC+/lvN9zNdDGkUejNZCjkFUS3HGNWAuxaBXTImbYMzfwqqUMm+iVLxv+rQvrQ86gmj5tLvb7xK/Moi0VLBDUuxz/cEo5cqE+bz6nSCQNLuY69cCe73L7ODVKf+EeQe6CpLJ/Sg7xQeOIbPKJKzUXzuhLQJfGP43GX43nkQpWPjN2AQj5ROOV88ILq9366BFVkXbkhSO669o2LLLp6DFy80LyuTniZRkfsAbSG2L8MR+aZXt7+jjdWdGrKURIXfFSG28tfv7Ojtg6J4AaqVEo4pRT5hIyOgaRqDYcw6GBPtejeE5ByyQzcA9kco3whnSVdeIZty53pNp8pRR+ppskHCMygIAVZuYy6KDJSx8TjbaxH8EFjf8YGW/BQVJfMe+stFWbe37lL8WbDKO09v8R96Tf16OBm4wgTYaso1nsMAdkBmmt5SV2q+Ne41laHfT5fDn53VtalbCibUaRZoGjxPX71KDrtYDZ3n2XDRm4Sw+VGK9qR4DjPWo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blBTLzc4bXgzb281T1RxZUYxL0pGQk1QNlhxb3dDMjg0NmtEVnU0T29TQ0xU?=
 =?utf-8?B?R1JjT0FFRldEazBiVi9kMXplR2Y5d3NOcG1uNmdOa0JqRkIrUFlkVTBuVTNE?=
 =?utf-8?B?aW5CVldHSzU5eXo0QWttU0NEanVWOUVpdFpPQjgxMXBZRjFjSE1rT2xkZlZJ?=
 =?utf-8?B?UDlic1dJL3FSODVzRmNPMWRSRVpmYkhGWUdiY3IrT0t4cTN5bVVSZWNqeER6?=
 =?utf-8?B?MGNUbWNRcHZ3QXhLaTNvUm56ZnVCckcvc2UxaWIrV29JSFNZZ2Q5T0dKWXU4?=
 =?utf-8?B?OTRBUWgvVnVhRUY2ZjNxSTB0OVN2Rk9NaDQ5SFZ6RVNLTUtZNythRVBYcm5P?=
 =?utf-8?B?MnROVHdKRzRQS1R0YVcrUElsS1NSQ1QvSHRuNkJaVW93aFhwQllNWEdPWnhh?=
 =?utf-8?B?Q1JZOEdYVXJkWjNhMXIwbFMvdFdUa08ycTcwaHlDN2xrRlV2WDVaR05EcW5l?=
 =?utf-8?B?bEhuSzBRSWo1dEJLbHRXMVFCZ2QzajVJeHZLdUJUTWVmRHNtd3hPMWtjWnpx?=
 =?utf-8?B?d080NTl6L3V2QUU4amY2UEE3c3p4T0V1RkQzTVE0a2Z3cmJvNUluWERqU1hP?=
 =?utf-8?B?VHVPeXRIL3pqYnowTnhLYUR0aDlkWFc5ZVNqaEREMXF5REhyRlFTdEZhRXhF?=
 =?utf-8?B?L3NNcnJ6K0pBWCthVVBYYWkzRWdGQitPRkZia1NZcEN4T2xkREx1UURxNmJ4?=
 =?utf-8?B?Ky9yZUJSbGNTbVQzL0xxaEJuV3NaWU5BdVI3ZWNjSS8xZ2pnZFU4TVFMOFVW?=
 =?utf-8?B?alYvbHBZUU5Ra3c0QlU2bHJVNy8xdUpVMWZ6SThKb3pqNUZ5NmhhU05uN3RF?=
 =?utf-8?B?U01wdjQvR3BiRzhrUStIUlNxSFlpUmRFZm9oZnk5ZDMzQzVXVlV1MEFGM1Za?=
 =?utf-8?B?V1JHaUNPVFMrZmNtaWp3cmpGVHZYQ2dDcisyb3Q0SmRFcFVQY1VrQ0I1eUcz?=
 =?utf-8?B?VExyZ3AyQTJzNFpPL2xPaHk4bExzdmJ6YzIyOXF2SjJvV0pYYmZnVFNnczM0?=
 =?utf-8?B?Q09kYnpBckJ0QXc1YnM1cFlBdVF2VG5MS3hRd3BySkEwckxDWVNLd2JTZ3BL?=
 =?utf-8?B?TjI1SkdJcklLSnpjTjB2UjJ4cFM2THRRUWZZdFVuYWNFWjVzY0lSUG1uWkJJ?=
 =?utf-8?B?eVM3c2xLVVlNSUhVdjhkOUcyMFFRRzlaZFpIdk9Rdmw0OUVSZDJ3TUE3djVN?=
 =?utf-8?B?c1I1V0xsNVUrUlVtM002ZFR3dlUrUzBXczlobmlJTkxPcW1ldmh1TWJzZDhk?=
 =?utf-8?B?NGFnVGttNWxuSTdTeitiaFpyQVQyUXIyQnRsMDhzUGIwWi9RRTM4dWxTbi9a?=
 =?utf-8?B?SWtzS3pleWFhZjJpQjF5K2h3bFZkR1hDNS92bFFtN1NXbWo1Y242d0UzY3pt?=
 =?utf-8?B?cC94QmdZUjRyb3dId3hGM01PVWlaWmo0NUtIV3VOeG5Hd2pVNWRyVUFRekRJ?=
 =?utf-8?B?eG9TV2dPZjRDVWladnU3akxrVnNCREFwM3JGSHhTYWd3Nm9pWWZHNlJYalF2?=
 =?utf-8?B?ejlmWkQwNFNiZzlqT3JlUlQzL1VOeUtiakJuRWlUcE41TzdnQzFGSm5scm5L?=
 =?utf-8?B?WUhQQXJqZlkrcllMVy9vU0hGSld1UzlqYTl4VWJUTGFxQVQwVHhJcVRZMlRZ?=
 =?utf-8?B?akZBcWplUUhjc1NpUzBoZjh5NUFaQkxkeXIrNWpJTnhRbmUzQk1mNExHNXE0?=
 =?utf-8?B?SFM3ekR4bmx0U25pZW9TY3BWRkxySVpUY0tsdG14R3Vuek9DQzBnMmNTNXMx?=
 =?utf-8?B?bVAwWjFUaWUyaFAzZVpLY1g2amVuT0dtS09PYkdJUjVacnpZb1VHUmoySWFv?=
 =?utf-8?B?RHN6eGV4NEpiaXd4LzJReS9tQlNzSFkvS2t6SkFxTUp2MXZHd2JadjZ4UjBl?=
 =?utf-8?B?NTVSRWF2RjBtblpJZzBCM1Q5SktvdEVPTmhsQ1lGdjhlQ0oyNk9qV09iYlA3?=
 =?utf-8?B?MFJhR29JZnFOY05ud1kyZS9Zdzdqc09ZV1kzYmJGMEpEZ08rSURuV3cyaXFT?=
 =?utf-8?B?dS8vTnloc2FqQWdqTGhtaU1idWhaUE8zaUUzL2phNnJDdkt1VklJZDRManhh?=
 =?utf-8?B?T05ndVpxeWJPVGl0aS9JZlJKRGwwakIyOHpRRnpPelpaMElabjAzUXY5bmhk?=
 =?utf-8?B?Wk9iTG96bzk5RVpGVmxkby9pRStqWlhtdXk1aDVxd2Vta29TQkIzWWo2V3E1?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76127E9B667E664682D519D062E22E0A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b4742e-2d84-4ede-abc1-08dc3c62c2ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 15:50:05.0840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAwEDGtraHaxkVMsa36eMr7P94JVTlFBYl7AkKaU0ktMnXsXxPnClQcJjh9XbDVOL6UDkmA87WqZaXrB5npUcZy9j/VokCfu0IkSeZpYyck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7098

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyNC0wMy0wNCBh
dCAwMjozMCArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyNC0wMy0wMSBhdCAyMjo0NCArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IElTUCBkcml2ZXJzIG5lZWQgdG8gZ2V0IGFuZCBzZXQgR0NFIGV2ZW50IGluIHRoZWly
IHJ1bnRpbWUgY29udG9ybA0KPiA+IGZsb3cuDQo+ID4gU28gYWRkIHRoZXNlIGZ1bmN0aW9ucyB0
byBzdXBwb3J0IGdldCBhbmQgc2V0IEdDRSBieSBDUFUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jICAgICAgIHwgMzcNCj4gPiArKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRx
LW1haWxib3guaCB8ICAyICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygr
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5jDQo+ID4gYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gaW5kZXgg
ZWFkMjIwMGYzOWJhLi5kN2MwODI0OWM4OTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tYWls
Ym94L210ay1jbWRxLW1haWxib3guYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMNCj4gPiBAQCAtMjUsNyArMjUsMTEgQEANCj4gPiAgI2RlZmluZSBDTURRX0dD
RV9OVU1fTUFYCQkoMikNCj4gPiAgDQo+ID4gICNkZWZpbmUgQ01EUV9DVVJSX0lSUV9TVEFUVVMJ
CTB4MTANCj4gPiArI2RlZmluZSBDTURRX1NZTkNfVE9LRU5fSUQJCTB4NjANCj4gPiArI2RlZmlu
ZSBDTURRX1NZTkNfVE9LRU5fVkFMVUUJCTB4NjQNCj4gPiArI2RlZmluZSBDTURRX1RPS0VOX0lE
X01BU0sJCQlHRU5NQVNLKDksIDApDQo+ID4gICNkZWZpbmUgQ01EUV9TWU5DX1RPS0VOX1VQREFU
RQkJMHg2OA0KPiA+ICsjZGVmaW5lIENNRFFfVE9LRU5fVVBEQVRFX1ZBTFVFCQkJQklUKDE2KQ0K
PiA+ICAjZGVmaW5lIENNRFFfVEhSX1NMT1RfQ1lDTEVTCQkweDMwDQo+ID4gICNkZWZpbmUgQ01E
UV9USFJfQkFTRQkJCTB4MTAwDQo+ID4gICNkZWZpbmUgQ01EUV9USFJfU0laRQkJCTB4ODANCj4g
PiBAQCAtODMsNiArODcsNyBAQCBzdHJ1Y3QgY21kcSB7DQo+ID4gIAlzdHJ1Y3QgY21kcV90aHJl
YWQJKnRocmVhZDsNCj4gPiAgCXN0cnVjdCBjbGtfYnVsa19kYXRhCWNsb2Nrc1tDTURRX0dDRV9O
VU1fTUFYXTsNCj4gPiAgCWJvb2wJCQlzdXNwZW5kZWQ7DQo+ID4gKwlzcGlubG9ja190CQlldmVu
dF9sb2NrOyAvKiBsb2NrIGZvciBnY2UgZXZlbnQgKi8NCj4gPiAgfTsNCj4gPiAgDQo+ID4gIHN0
cnVjdCBnY2VfcGxhdCB7DQo+ID4gQEAgLTExMyw2ICsxMTgsMzggQEAgdTggY21kcV9nZXRfc2hp
ZnRfcGEoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9M
KGNtZHFfZ2V0X3NoaWZ0X3BhKTsNCj4gPiAgDQo+ID4gK3ZvaWQgY21kcV9zZXRfZXZlbnQodm9p
ZCAqY2hhbiwgdTE2IGV2ZW50X2lkKQ0KPiANCj4gc3RydWN0IG1ib3hfY2hhbiAqY2hhbg0KPiAN
Ck9LLCBJJ2xsIGNoYW5nZSBpdC4NCg0KPiBJcyB0aGUgZXZlbnRfaWQgdGhlIGhhcmR3YXJlIGV2
ZW50IGlkIGxpc3RlZCBpbiBpbmNsdWRlL2R0LQ0KPiBiaW5kaW5ncy9nY2UgDQo+ID8gSSBtZWFu
IENQVSBjb3VsZCB0cmlnZ2VyIHRoZSBldmVudCB3aGljaCBzaG91bGQgYmUgdHJpZ2dlciBieQ0K
PiBoYXJkd2FyZT8NCj4gDQpZZXMsIHRoaXMgY2FuIGFsc28gdHJpZ2dlciB0aGUgaGFyZHdhcmUg
ZXZlbnQsIGJ1dCBDTURRIHVzZXIgc2hvdWxkIG5vdA0KZG8gdGhhdC4gT3RoZXJ3aXNlLCBpdCB3
aWxsIGNhdXNlIGVycm9yIGluIG90aGVyIEdDRSB0aHJlYWRzIHRoYXQgdXNlDQp0aGlzIGhhcmR3
YXJlIGV2ZW50Lg0KDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBjbWRxICpjbWRxID0gY29udGFpbmVy
X29mKCgoc3RydWN0IG1ib3hfY2hhbiAqKWNoYW4pLQ0KPiA+ID4gbWJveCwNCj4gPiANCj4gPiAr
CQl0eXBlb2YoKmNtZHEpLCBtYm94KTsNCj4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4g
Kw0KPiA+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmNtZHEtPmV2ZW50X2xvY2ssIGZsYWdzKTsNCj4g
PiArDQo+ID4gKwl3cml0ZWwoQ01EUV9UT0tFTl9VUERBVEVfVkFMVUUgfCBldmVudF9pZCwgY21k
cS0+YmFzZSArDQo+ID4gQ01EUV9TWU5DX1RPS0VOX1VQREFURSk7DQo+ID4gKw0KPiA+ICsJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmY21kcS0+ZXZlbnRfbG9jaywgZmxhZ3MpOw0KPiA+ICt9DQo+
ID4gK0VYUE9SVF9TWU1CT0woY21kcV9zZXRfZXZlbnQpOw0KPiA+ICsNCj4gPiArdTMyIGNtZHFf
Z2V0X2V2ZW50KHZvaWQgKmNoYW4sIHUxNiBldmVudF9pZCkNCj4gDQo+IERvZXMgdGhpcyBnZXQg
dGhlIGV2ZW50IHN0YXR1cz8gSSB0aGluayBldmVudCBoYXMgb25seSB0d28gc3RhdHVzLA0KPiBz
ZXQNCj4gb3IgY2xlYXJlZC4gU28gSSB3b3VsZCBsaWtlIHRoaXMgdG8gcmV0dXJuIHRydWUgZm9y
IHNldCBhbmQgZmFsc2UgZm9yDQo+IGNsZWFyZWQuDQpZZXMsIHRoZSBldmVudCBzdGF0dXMgaXMg
MSBvciAwLiBJJ2xsIGNoYW5nZSBpdCB0byBib29sZWFuLg0KDQpSZWdhcmRzLA0KSmFzb24tSkgu
TGluDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0K

