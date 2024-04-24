Return-Path: <linux-kernel+bounces-156617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1C8B05AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B392828B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5E5158DDE;
	Wed, 24 Apr 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e7ejlEDr";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rcyQQvDd"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7E158DA5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950101; cv=fail; b=bgeVBVvBN0OTTIQEMiVBn71JESjDTQf3ePROhvMphjnpEUaT0iNqAuOF7J9l6+G6hNUhiiNEpUJN1PO6nW2tNHWsSCJCDUWoj1yciHN5SCY6XSXR5Q7RG7HuKULrfzF6bV7KdVtWQO2QL09IfTgYDpoPf+Iq27yCuaZO5wbcLdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950101; c=relaxed/simple;
	bh=k8vnJpftnQL94rmKxGN9VbvKqvpyM8HBjpqv5sdow7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=typyy5KOtdp8iTxd14XaMPzj9IclnjwU6fBznfP0mL370q4gTgzWBtqLOSNv+3t3nO/R+YlykBBqnGdFpbtYFi/wWagxMKMSFe/zSRn9Iq4vVSjHHcz6q0QKkk4xHMdogbro4dLaV6XE97tngdW+z83Ssavme04LRhu19zxv42k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=e7ejlEDr; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rcyQQvDd; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1845aed6021b11ef935d6952f98a51a9-20240424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=k8vnJpftnQL94rmKxGN9VbvKqvpyM8HBjpqv5sdow7E=;
	b=e7ejlEDr3kg2eULhyj03SbT/8ZuOKizfgzwnh4iMD59ScM90zOf8wk7GAvy8L+TjnogL3bdytsDhEGl84AzVe/4WTcbRjmXwUHZozohmKvzmyHFkzQ14f2JarIBJQYXOtwL0xmrid1TGXdyyA4s1I9oswLdmwL5N0xoiB+21ATk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:f41078e9-6f8f-4ff6-b65b-bbb0496dcb24,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:8eea8e86-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT
X-CID-BAS: 1,FCT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1845aed6021b11ef935d6952f98a51a9-20240424
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shuijing.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 241168714; Wed, 24 Apr 2024 17:14:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Apr 2024 17:14:45 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Apr 2024 17:14:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/Bk+noFcim//Z5GajADFEY79XCOCSiTNHJ2f74TXZ+zf9ngzbIyNb3r7oRvQP4HtZ3Tgw3y9L76hCFcLbSdy0WZlRdqfx7rYZ4qn3B1xkQ62pfiEyAt2u3c6zrCtFsQqfhoIsxpMauYMKz5LnjDzNE4P811iNJaKmaKy69OrJ5aEs9tcBnftfprOysCocyeKzqk6rO6QCwq0FYVaBwGMoJVD8O6BOUOpj6527JYuSnJfGIPzt7ZxmpaI+IbW4xE4JpCLyc//OBADDMAkgvrwO7e8Q8EV1euxoMrSa8RoSgFVPGB+Zu4eiNWDiTCCVZCzWOzBhpRN5436lr6GjjIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8vnJpftnQL94rmKxGN9VbvKqvpyM8HBjpqv5sdow7E=;
 b=HMDdhiLdhpH6KmDbqrvlUjVVtoqmRTMVgNNqt6v2SFQB02jlYHAF/iUF6L+VJa4coV1ZW8xXWv7FU4sO4QId4MV4TrjXZc+nN9ur2zuAF2rCzjYTGlfrEpMhkpK0gi86hHvCDJPCUxzGYPu9GbtW3OrmiSOTaz4DJwH+0OIo9RNd5MDzfLldz36Fbu4kpQSX2nFjFe42MnQA5yPnaIhT9X74lylXNSAzti6oR2hCpuH1nNywIOEmvDz52Ba1H0xYIN17nYT5Ijxtjw5rW5FiPWGKHq7KgPYGbLn21J4LyFPw0CLVKs3gjd/3e4QYAIULcwA7skzmPMV++dLpIVoqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8vnJpftnQL94rmKxGN9VbvKqvpyM8HBjpqv5sdow7E=;
 b=rcyQQvDdMox25fjjpaIw2WryFRbb07uCSxshJ3yet+EADlOFVGBzWSPpY1lsFgV/6u6IecsKUK2WNslCp9zWo7lwrC/eaMGA42+8Q7aCjrotXOUckUg4GcvVtMpvf1Wp9bqjoRqqvVyrZX6vAE83mWNKdlfaezC2BX8fnDPbv+A=
Received: from SEZPR03MB8678.apcprd03.prod.outlook.com (2603:1096:101:231::6)
 by OS8PR03MB8982.apcprd03.prod.outlook.com (2603:1096:604:2a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 09:14:43 +0000
Received: from SEZPR03MB8678.apcprd03.prod.outlook.com
 ([fe80::97b7:3c7d:8683:b0f4]) by SEZPR03MB8678.apcprd03.prod.outlook.com
 ([fe80::97b7:3c7d:8683:b0f4%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 09:14:43 +0000
From: =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?=
	<ck.hu@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] mediatek: dsi: Add dsi per-frame lp code for mt8188
Thread-Topic: [PATCH] mediatek: dsi: Add dsi per-frame lp code for mt8188
Thread-Index: AQHadfPtb+z3LozX/E+GiLbBEBgpt7FALL6AgDc3CAA=
Date: Wed, 24 Apr 2024 09:14:43 +0000
Message-ID: <6a817e32cb2c2c9a65b6878a49f98578e7478b72.camel@mediatek.com>
References: <20240314094238.3315-1-shuijing.li@mediatek.com>
	 <2a0a4d12edfc92d40d5ae463f8a261e8799ddafa.camel@mediatek.com>
In-Reply-To: <2a0a4d12edfc92d40d5ae463f8a261e8799ddafa.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB8678:EE_|OS8PR03MB8982:EE_
x-ms-office365-filtering-correlation-id: 968ba0df-00bb-4ec1-31f4-08dc643efa73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?bDNXc2Qybzk5K1M4NzRYVWxCRHlPc2l2Q2ZNYUl3N1d2bVpqcm4xSWVtVXVa?=
 =?utf-8?B?ek5HVkhvMUk1bDk2ZmZZUDBEWFV2WHllTVFITWZpdGw0cFFRUmV1a3k1dndr?=
 =?utf-8?B?ZWFtMERYaEJzQVhxRHZEZ2dBcmtseDFFRUFWanN6NmR1eDEwZlo2SkZNMUNy?=
 =?utf-8?B?TVJZM1gwMzJRd3dSZTQxZGRNdHdFRHFmSXlxcHE3QUU3SG9RNFhNSDR3V1Vx?=
 =?utf-8?B?WVB5L2FyT01jS09BTW9tY0lZTUVnTnlsTFo3ZnlCOThvUXVtVkZMaVZSRlgz?=
 =?utf-8?B?ZXpmeklsREp3Q0NUYWZ6Smx1UTBHQlZ6bnByaFJKMVgvT0t1UXhVb0tsY3RN?=
 =?utf-8?B?WTF1VjIxZjF2VTdrWGpoKytiNWU0VEJLTjBtRlJtbkZSTmFwcGhzNFR6ZGdO?=
 =?utf-8?B?ZzlJaHBFQVVnVVUzTGtKK2JodXgyK3YxZk11R3dyVlAvNGRvMWs4anFKeENi?=
 =?utf-8?B?OTlSM0ZqeHRVMU9KZGNtLzFUaS94WGw5VWM0d1pUNm1aTmcrVzZUVi9OYjQx?=
 =?utf-8?B?VFVZY2FXMjRnUk1JUnkvempnZy9PYVVybWVjUm1ub1AySjZ0SVhnSUlCbzJi?=
 =?utf-8?B?cCtiUzh2eVF6TnBXSmxUQXVPTkRJQWcxVW92cnlnUG1QMFduTU53WXU5ODJr?=
 =?utf-8?B?aUFIL1JrNVhGeU1zVWxjREVldWEraU5HbDNGMTNzM3hJOWd5eXBBWjdKV2sz?=
 =?utf-8?B?UDNvNFoycGRheUxoYkQ0MmZac0g4L3lKVHJxNlpTbE1FNHc4eXdNeGU0emtF?=
 =?utf-8?B?U0VMSmFuU1JSRFJqempmaUgwaE9KOUwzQXdZVHRRbXVkREFuZm5Xbmp6ZWRN?=
 =?utf-8?B?ZmppVlFuS0dqcmI4YmJQSGVTQUtGVEd6anpDYkRCUVZ3bE1uUW5XU0t1ckNJ?=
 =?utf-8?B?ZzNod2szZXBoWFVZanVtWDBhV3VpZktJOHBROFV1UGNkRlU3WmRSdWxsT0dL?=
 =?utf-8?B?NkQvdGNHNWVtMWphbmlMUDh6SnJoSFpZaFcxNHowS0xPallRRmlmeElHdzEr?=
 =?utf-8?B?UHZzNTFjY0pKa0RPUjNCdER6cmpTY0lhaTgvb0E0bkg0eXVzTk5mQ0N5SmZF?=
 =?utf-8?B?WmxGeUFmTGgyWGN3NGhlWmp0aXRoRmt3VC8rcGdDUUpRZ0xyYTFpTXBldFlG?=
 =?utf-8?B?MDNVQVdzd1JYMWRSVjE4MHZjSU9tOENjbjR2UFFvb1dsVlU5b21xNWdFTHI5?=
 =?utf-8?B?azY3a3BRNDdSdzNxWS9VUDJJcW05Z0FTU1ZiQU5jRlJzNmUzdENDNytTeWI3?=
 =?utf-8?B?T3JLZ2FZbFJETkRXQnY2SjRMdldMZWhjNXd2aDlncFBEZjNPVllmOGtJMGRW?=
 =?utf-8?B?UkY0MHgxVDlTZXRMZzRka21hL0x6MzE3Zk5xbmlBcFhFdWkvSTYxd0l6dVhj?=
 =?utf-8?B?UEsyQm05ZENlM3A4UzhjLzMxREltME5lS0xkK1hnQmVqWXpEYnByWklabTdV?=
 =?utf-8?B?QnduVHRvY3BwQkoybnVpTHZOcnloOCtrYnZWRXQrSk85QTZmR1o4QWtISmN0?=
 =?utf-8?B?OFM2YXVTSEZMeTZBbE5EdEJQeE9OV05nVWQwL3JweTRPT0RTVXB5OTNJeWdD?=
 =?utf-8?B?NFBGcXRBRWFqak0rTW82THNuZmlYdzJIcmg0Vk83QnBHNzBhdlM0Zit3dGcw?=
 =?utf-8?B?eDUvdmdGa2xzb2xVakg4M3ErNEhTNWNTK3FwcHZyMklJd3Q3T1FQVmp5Nm8z?=
 =?utf-8?B?S3BVSmpCdWUwVjd4MWZ1a0IweENTdHpqV1l6b1ZmUXBzbVJMQVE3WEdocU9K?=
 =?utf-8?B?WXIzSUhiMW9nbUE0NEYvbVFVVHp1dC9UQXNPdWlIOVlTTktEeFBLWXBNRVY5?=
 =?utf-8?B?WHVmNEZFaFpXNzhHOVV5Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB8678.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEtXOE8rRDRtVERoMThGUWFOaUZhNWVRUmFQTklSL0hmYkF2L28zK3lWa1dz?=
 =?utf-8?B?MHJPNm9sM0ZGYm94cEg3UUNCVEtnU2JtSTkwRTVrUnpUeVVwVVdNK2R2eVRr?=
 =?utf-8?B?U1BjaXRDZlBOTWt1QmdocFR2Z2Job1RXUkhESklHSWl1SWhFRXROYUpGY01S?=
 =?utf-8?B?ekk1L0JOWEYwVHdIdGh6YmFyUTlJdTFJa3FtMU5LTEhXdWJneEtLK0hqekVP?=
 =?utf-8?B?eGlENEYwVUVpVldUYTBxeWJtMzJHYU9BRGxpUFlqVGRXTlpnV3g4T2pVUEtm?=
 =?utf-8?B?VTZNY3NQbDdmRm16bCtpSUt5WXRQb3R1MStVbnVybk9Qd0hFajlSYmFWU3ZW?=
 =?utf-8?B?a0ZzQ0pNRFFCNUh6ekxrTVBUeHRoYWxBY2hrYXVoNlB3dXkxRm5FZVFFUjZ4?=
 =?utf-8?B?eUwxN3FYN1pWL2MvSkVBNXlJeXN4VGRFTWNIWHpoOFVhejFHbjZiZnRVS295?=
 =?utf-8?B?c3ROWW1hNlgzVVEzSDNza091SGduYmh2RlF1TDB4TDZhMFBYQTNvdVlnYTlu?=
 =?utf-8?B?Kys2MzZjaXkvamtCT3BLTEgyVlkxSXdGcWJWMUJybTJteWc0OUg5bXNBSDhS?=
 =?utf-8?B?MTY4UGN6TDY1OTlxb2JRcVZVWEwyMUVjMlQrUkNGUUZTbDVadlQzK0U5K2hF?=
 =?utf-8?B?dEdEYWY0TC9lWHNoQ2hQUjV6dTl0WE1wNzhLR2M4SUZ4OHI2NFBsRXQyZUdG?=
 =?utf-8?B?NG9qUTdsbTBTeVlFQWxoZ0JNWUgxdW9qVHhGcnpZVGFoT0N6Y05nMm9yblli?=
 =?utf-8?B?MmsrMm5rTFFGQVZpMmZSWHgwQWVZZVkwbDBDdVdkZ1NXS2RqaCtZREgyRHMy?=
 =?utf-8?B?clZva1ZCS1FKM3hHT0hUYVF4ZW51ckdlanUvYVk2MG9sYkM4UnQ3Z3F5a2Zz?=
 =?utf-8?B?UFdRUVhiVHlqcmdwcmxPTXhCSE1Zd0NaVkFUaGd5YUZncG5tSHorakdIUkRa?=
 =?utf-8?B?eHF4b3JnSEdad0Y2ZWhRMWh3dUc3SEhvZXo3RG80YnI4MFJ6YjlKT2tReXJa?=
 =?utf-8?B?RjhnZWxzSk9vcmxnemRlWEZzRFZqSVlwZWFDNEtIaFRvMi9TWjc5MGVoY0E4?=
 =?utf-8?B?OFY2Sm9iTzlZTkJNbHlSb0JlZGRHb1JoQ3FCVTJURjd0UDljWk1mL1NGWmNv?=
 =?utf-8?B?TGs3TktrKzV5ZVA5QldJU3VyTlV3cFN6eW5RRXNOT0RpQlBhRmNicTM4aFB6?=
 =?utf-8?B?N29TbXdRYldKd3VXa3crUmt6YVNBd1JUR2JsMWNRTUJYR0NjVm9GNVVQbk0z?=
 =?utf-8?B?SzM2Ni9BS0ltNUpVUGRjSDYrNjQzWW1ydFAxV3FtVFkrM0pmL3pySEUxN0xr?=
 =?utf-8?B?bnFmL2hUK3VkM05NTXNuMU9MaU4vSUxndU0wQ0lkaEc4VWplWUNsK2hZRTVW?=
 =?utf-8?B?Z24rdFBGVTRrWlM3bnExQ0hQWFVWRFlrNzNvZTNiUWdqTHA2REpwZmJTQUxU?=
 =?utf-8?B?YmFLb2N0YWd4am0zb05NVWdoN2tKaXpLaE4yRkkyb0lRUXVEZDZiL0d1eHlY?=
 =?utf-8?B?YlU4bnp3R0xua2JZQUNCSVBqQjB2cTRaLzNDcndpOEo5RkV4TG1iZnJTWFZu?=
 =?utf-8?B?TG5UWWxMMVFwbit5azE5MXR0bDl6ZHRQSExKYzFrZUF4M054d2FDakl5SVF6?=
 =?utf-8?B?RitxcUdJQTFsZExPTnNJVVB6Y3VaREUzY29Wbm1lWnVzR284eU1RaElLU29T?=
 =?utf-8?B?S2YxODhZbUJXR2xBMTJCdytWQ21BQUNFa3NzcnY1R3hRNDE5Ujl5MXFpc3R6?=
 =?utf-8?B?WXVJWitubXNCYk4rREtoaytEZWQyQWcybWpiMVV1YVg4UkRiWjNCUlVjSytt?=
 =?utf-8?B?RFVubDk2UUxhdEdSSUhQM3RsODdxWUU1TU1kOVorUHcxejhoS29GMS9uakJR?=
 =?utf-8?B?b1RHNkNoOUlFbFViUlZYanFORWdWUUlaZWs3ZENwN2Z0ZFp3NEw2bCt0b1hy?=
 =?utf-8?B?UlNFYXpnc0VTYmZ0U2VLS0ZlRGVlUlpuM1pwaFNpb3F1eC9LL0JJblEvYkpH?=
 =?utf-8?B?Y0RYNzRpVHdwVHI4UGgwWkFwSzMyVW1mMWNTbEd6RnF1bVVUN29ReXR2eDNR?=
 =?utf-8?B?REo5U2ZnT09Qa3JSVmdTeWhOZU0rTDdvSlV6Yk9pSlBoVVEvaThBZmdvbjVE?=
 =?utf-8?B?R0ExSTJmMks3NG1oejZibzlaTDM0cDNadUZ6RXhScUxSQnRZWmVSc1lNcGVM?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55C500923C9E504D94174B1B319AC0D1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB8678.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968ba0df-00bb-4ec1-31f4-08dc643efa73
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 09:14:43.2006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3RXr2DHHWlGeJIt1OobDN3TdYX4wrNdJVeyG5qEhEGctB6tpcyche9r9cHr0FfEb4HG/sm7PmuaC8CU7XAE87JpDhDQEVh1POv9yjx+0Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR03MB8982

RGVhciBDSywNCg0KPiBBcyBJIGtub3csIHNvbWUgbG93IHBvd2VyIG1vZGUgd291bGQgaGFzIHNv
bWUgc2lkZSBlZmZlY3QuIEZvcg0KPiBleGFtcGxlLA0KPiBDUFUgZHZmcyB3b3VsZCBsZXQgQ1BV
IHJ1biBpbiBsb3cgZnJlcXVlbmN5IHdoZW4gQ1BVIGlzIGlkbGUsIGJ1dA0KPiB3aGVuDQo+IENQ
VSBpcyBzdWRkZW5seSBidXN5LCBpdCB3b3VsZCB0YWtlIHNvbWUgdGltZSB0byBsZXQgQ1BVIGZy
ZXF1ZW5jeQ0KPiBzcGVlZCB1cCBhbmQgbWF5IGNhdXNlIHNvbWUgcmVhbCB0aW1lIGlzc3VlLiBE
b2VzIHRoaXMgaGF2ZSBhbnkgc2lkZQ0KPiBlZmZlY3QuIElmIHNvLCBwbGVhc2UgZGVzY3JpYmUg
aXQuDQo+IA0KPT3jgItUaGlzIGlzIG5vdCBhIENQVSBsb3ctcG93ZXIgZmVhdHVyZSwgYnV0IGEg
Y2hhcmFjdGVyaXN0aWMgb2YgRFNJLiBJdA0KbWFpbnRhaW5zIGhpZ2ggc3BlZWQgd2l0aG91dCBl
bnRlcmluZyBsb3cgcG93ZXIgZHVyaW5nIHRoZSBEU0kgYWN0aXZlDQpwZXJpb2QsIHdoaWNoIGNh
biBzYXZlIHRoZSB0aW1lIG9mIGVudGVyaW5nIGFuZCBleGl0aW5nIGxvdyBwb3dlciwNCndpdGhv
dXQgc2lkZSBlZmZlY3RzLg0KDQpCYXNlZCBvbiB0aGUgZmVlZGJhY2sgeW91IHByb3ZpZGVkLCBJ
IGhhdmUgbWFkZSB0aGUgbmVjZXNzYXJ5IGNoYW5nZXMNCmFuZCB3b3VsZCBsaWtlIHRvIHN1Ym1p
dCBhIHZlcnNpb24gMiBmb3IgeW91ciBjb25zaWRlcmF0aW9uIGF0IGEgbGF0ZXINCmRhdGUuDQoN
ClRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIGFuZCBhdHRlbnRpb24gdG8gdGhpcyBtYXR0ZXIuDQoN
Cg0KQmVzdCByZWdhcmRzLA0KU2h1aWppbmcNCg0KDQpPbiBXZWQsIDIwMjQtMDMtMjAgYXQgMDY6
MDMgKzAwMDAsIENLIEh1ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiBIaSwgU2h1aWppbmc6DQo+IA0K
PiBBZGQgJ2RybS8nIGluIHRoZSB0aXRsZS4NCj4gDQo+IE9uIFRodSwgMjAyNC0wMy0xNCBhdCAx
Nzo0MSArMDgwMCwgU2h1aWppbmcgTGkgd3JvdGU6DQo+ID4gQWRkaW5nIHRoZSBwZXItZnJhbWUg
bHAgZnVuY3Rpb24gb2YgbXQ4MTg4LCB3aGljaCBjYW4ga2VlcCBIRlAgaW4NCj4gPiBIUw0KPiA+
IGFuZA0KPiA+IHJlZHVjZSB0aGUgdGltZSByZXF1aXJlZCBmb3IgZWFjaCBsaW5lIHRvIGVudGVy
IGFuZCBleGl0IGxvdyBwb3dlci4NCj4gPiBQZXIgRnJhbWUgTFA6DQo+ID4gICB8PC0tLS0tLS0t
LS1PbmUgQWN0aXZlIEZyYW1lLS0tLS0tLS0+fA0KPiA+IC0tX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18tLS0tX19fX19fX19fX19fX19fX19fXw0KPiA+ICAgXkhTQStIQlBe
XlJHQl5eSEZQXl5IU0ErSEJQXl5SR0JeXkhGUF4gICAgXkhTQStIQlBeXlJHQl5eSEZQXg0KPiA+
IA0KPiA+IFBlciBMaW5lIExQOg0KPiA+ICAgfDwtLS0tLS0tLS0tLS0tLS1PbmUgQWN0aXZlIEZy
YW1lLS0tLS0tLS0tLS0+fA0KPiA+IC0tX19fX19fX19fX19fX18tLV9fX19fX19fX19fX19fLS1f
X19fX19fX19fX19fXy0tLS1fX19fX19fX19fX19fXw0KPiA+ICAgXkhTQStIQlBeXlJHQl4gIF5I
U0ErSEJQXl5SR0JeICBeSFNBK0hCUF5eUkdCXiAgICBeSFNBK0hCUF5eUkdCXg0KPiANCj4gQXMg
SSBrbm93LCBzb21lIGxvdyBwb3dlciBtb2RlIHdvdWxkIGhhcyBzb21lIHNpZGUgZWZmZWN0LiBG
b3INCj4gZXhhbXBsZSwNCj4gQ1BVIGR2ZnMgd291bGQgbGV0IENQVSBydW4gaW4gbG93IGZyZXF1
ZW5jeSB3aGVuIENQVSBpcyBpZGxlLCBidXQNCj4gd2hlbg0KPiBDUFUgaXMgc3VkZGVubHkgYnVz
eSwgaXQgd291bGQgdGFrZSBzb21lIHRpbWUgdG8gbGV0IENQVSBmcmVxdWVuY3kNCj4gc3BlZWQg
dXAgYW5kIG1heSBjYXVzZSBzb21lIHJlYWwgdGltZSBpc3N1ZS4gRG9lcyB0aGlzIGhhdmUgYW55
IHNpZGUNCj4gZWZmZWN0LiBJZiBzbywgcGxlYXNlIGRlc2NyaWJlIGl0Lg0KPiANCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTaHVpamluZyBMaSA8c2h1aWppbmcubGlAbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgMTAwDQo+
ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEw
MCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHNpLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNp
LmMNCj4gPiBpbmRleCBhMmZkZmM4ZGRiMTUuLmU2ZjQ4MDdjODcxMSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiA+IEBAIC04Myw2ICs4Myw3IEBADQo+ID4gICNk
ZWZpbmUgRFNJX0hTQV9XQwkJMHg1MA0KPiA+ICAjZGVmaW5lIERTSV9IQlBfV0MJCTB4NTQNCj4g
PiAgI2RlZmluZSBEU0lfSEZQX1dDCQkweDU4DQo+ID4gKyNkZWZpbmUgRFNJX0JMTFBfV0MJCTB4
NUMNCj4gPiAgDQo+ID4gICNkZWZpbmUgRFNJX0NNRFFfU0laRQkJMHg2MA0KPiA+ICAjZGVmaW5l
IENNRFFfU0laRQkJCTB4M2YNCj4gPiBAQCAtMTgwLDYgKzE4MSw3IEBAIHN0cnVjdCBtdGtfZHNp
X2RyaXZlcl9kYXRhIHsNCj4gPiAgCWJvb2wgaGFzX3NoYWRvd19jdGw7DQo+ID4gIAlib29sIGhh
c19zaXplX2N0bDsNCj4gPiAgCWJvb2wgY21kcV9sb25nX3BhY2tldF9jdGw7DQo+ID4gKwlib29s
IHN1cHBvcnRfcGVyX2ZyYW1lX2xwOw0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgc3RydWN0IG10a19k
c2kgew0KPiA+IEBAIC01MTYsNiArNTE4LDEwMyBAQCBzdGF0aWMgdm9pZCBtdGtfZHNpX2NvbmZp
Z192ZG9fdGltaW5nKHN0cnVjdA0KPiA+IG10a19kc2kgKmRzaSkNCj4gPiAgCQkJKHZtLT5oYWN0
aXZlICogZHNpX3RtcF9idWZfYnBwICsgMikgJSBkc2ktDQo+ID4gPiBsYW5lczsNCj4gPiANCj4g
PiAgCX0NCj4gPiAgDQo+ID4gKwlpZiAoZHNpLT5kcml2ZXJfZGF0YS0+c3VwcG9ydF9wZXJfZnJh
bWVfbHApIHsNCj4gPiArCQl1bnNpZ25lZCBpbnQgbHB4ID0gMCwgZGFfaHNfZXhpdCA9IDAsIGRh
X2hzX3ByZXAgPSAwLA0KPiA+IGRhX2hzX3RyYWlsID0gMDsNCj4gPiArCQl1bnNpZ25lZCBpbnQg
ZGFfaHNfemVybyA9IDAsIHBzX3djID0gMCwgaHNfdmJfcHNfd2MgPQ0KPiA+IDA7DQo+IA0KPiBJ
dCdzIG5vdCBuZWNlc3NhcnkgdG8gaW5pdGlhbGl6ZSB0byB6ZXJvIGJlY2F1c2UgdGhlc2UgdmFy
aWFibGUgd291bGQNCj4gYmUgYXNzaWduZWQgdG8gb3RoZXIgdmFsdWUgbGF0ZXIuDQo+IA0KPiA+
ICsJCXUzMiBibGxwX3djLCBibGxwX2VuLCB2X2FjdGl2ZV9yb3VuZHVwLCBoc3R4X2NrbHBfd2M7
DQo+ID4gKwkJdTMyIGhzdHhfY2tscF93Y19tYXgsIGhzdHhfY2tscF93Y19taW47DQo+ID4gKw0K
PiA+ICsJCWRhX2hzX3RyYWlsID0gKHJlYWRsKGRzaS0+cmVncyArIERTSV9QSFlfVElNRUNPTjAp
ID4+DQo+ID4gMjQpICYgMHhmZjsNCj4gDQo+IG9wZXJhdG9yICc+PicgaGFzIGhpZ2hlciBwcmlv
cml0eSB0aGFuIG9wZXJhdG9yICcmJywgc28gaXQncyBub3QNCj4gbmVjZXNzYXJ5IHRvIGFkZCAn
KCknLg0KPiANCj4gPiArCQlibGxwX2VuID0gKHJlYWRsKGRzaS0+cmVncyArIERTSV9UWFJYX0NU
UkwpID4+IDcpICYNCj4gPiAweDE7DQo+ID4gKwkJaWYgKGRzaS0+bW9kZV9mbGFncyAmIE1JUElf
RFNJX01PREVfVklERU9fU1lOQ19QVUxTRSkgew0KPiA+ICsJCQlob3Jpem9udGFsX3N5bmNfYWN0
aXZlX2J5dGUgPQ0KPiA+ICsJCQkJKHZtLT5oc3luY19sZW4gKiBkc2lfdG1wX2J1Zl9icHAgLSAx
MCk7DQo+IA0KPiAnKCknIGlzIHJlZHVuZGFudC4NCj4gDQo+ID4gKwkJCWhvcml6b250YWxfYmFj
a3BvcmNoX2J5dGUgPQ0KPiA+ICsJCQkJKHZtLT5oYmFja19wb3JjaCAqIGRzaV90bXBfYnVmX2Jw
cCAtDQo+ID4gMTApOw0KPiANCj4gZGl0dG8uDQo+IA0KPiA+ICsJCQlob3Jpem9udGFsX2Zyb250
cG9yY2hfYnl0ZSA9DQo+ID4gKwkJCQkodm0tPmhmcm9udF9wb3JjaCAqIGRzaV90bXBfYnVmX2Jw
cCAtDQo+ID4gMTIpOw0KPiANCj4gZGl0dG8uDQo+IA0KPiA+ICsNCj4gPiArCQkJcHNfd2MgPSBy
ZWFkbChkc2ktPnJlZ3MgKyBEU0lfUFNDVFJMKSAmIDB4N2ZmZjsNCj4gPiArCQkJdl9hY3RpdmVf
cm91bmR1cCA9ICgzMiArDQo+ID4gaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRlICsNCj4gPiAr
CQkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgKyBwc193YyArDQo+ID4gKwkJCQlob3Jpem9u
dGFsX2Zyb250cG9yY2hfYnl0ZSkgJSBkc2ktDQo+ID4gPiBsYW5lczsNCj4gPiANCj4gPiArCQkJ
aWYgKHZfYWN0aXZlX3JvdW5kdXApDQo+ID4gKwkJCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRl
ID0NCj4gPiBob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlICsNCj4gPiArCQkJCQlkc2ktPmxhbmVz
IC0gdl9hY3RpdmVfcm91bmR1cDsNCj4gPiArCQkJaHN0eF9ja2xwX3djX21pbiA9IChESVZfUk9V
TkRfVVAoKDEyICsgMiArIDQgKw0KPiA+ICsJCQkJaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRl
KSwgZHNpLQ0KPiA+ID4gbGFuZXMpICsgZGFfaHNfdHJhaWwgKyAxKQ0KPiA+IA0KPiA+ICsJCQkJ
KiBkc2ktPmxhbmVzIC8gNiAtIDE7DQo+ID4gKwkJCWhzdHhfY2tscF93Y19tYXggPSAoRElWX1JP
VU5EX1VQKCgyMCArIDYgKyA0ICsNCj4gPiArCQkJCWhvcml6b250YWxfc3luY19hY3RpdmVfYnl0
ZSArDQo+ID4gaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSArDQo+ID4gKwkJCQlwc193YyksIGRz
aS0+bGFuZXMpICsgZGFfaHNfdHJhaWwgKyAxKQ0KPiA+ICogZHNpLT5sYW5lcyAvIDYgLSAxOw0K
PiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJCWhvcml6b250YWxfc3luY19hY3RpdmVfYnl0ZSA9IHZt
LT5oc3luY19sZW4gKg0KPiA+IGRzaV90bXBfYnVmX2JwcCAtIDQ7DQo+ID4gKw0KPiA+ICsJCQlo
b3Jpem9udGFsX2JhY2twb3JjaF9ieXRlID0gKHZtLT5oYmFja19wb3JjaCArDQo+ID4gdm0tPmhz
eW5jX2xlbikgKg0KPiA+ICsJCQkJZHNpX3RtcF9idWZfYnBwIC0gMTA7DQo+ID4gKwkJCWhzdHhf
Y2tscF93Y19taW4gPSAoRElWX1JPVU5EX1VQKDQsIGRzaS0NCj4gPiA+bGFuZXMpIA0KPiA+ICsg
ZGFfaHNfdHJhaWwgKyAxKQ0KPiA+ICsJCQkJKiBkc2ktPmxhbmVzIC8gNiAtIDE7DQo+ID4gKw0K
PiA+ICsJCQlpZiAoZHNpLT5tb2RlX2ZsYWdzICYNCj4gPiBNSVBJX0RTSV9NT0RFX1ZJREVPX0JV
UlNUKSB7DQo+ID4gKwkJCQlwc193YyA9IHJlYWRsKGRzaS0+cmVncyArIERTSV9QU0NUUkwpICYN
Cj4gPiAweDdmZmY7DQo+ID4gKwkJCQlibGxwX3djID0gcmVhZGwoZHNpLT5yZWdzICsNCj4gPiBE
U0lfQkxMUF9XQykgJiAweGZmZjsNCj4gPiArCQkJCWhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRl
ID0gKHZtLQ0KPiA+ID4gaGZyb250X3BvcmNoICoNCj4gPiANCj4gPiArCQkJCQlkc2lfdG1wX2J1
Zl9icHAgLSAxOCk7DQo+ID4gKw0KPiA+ICsJCQkJdl9hY3RpdmVfcm91bmR1cCA9ICgyOCArDQo+
ID4gaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSArIHBzX3djICsNCj4gPiArCQkJCQlob3Jpem9u
dGFsX2Zyb250cG9yY2hfYnl0ZSArDQo+ID4gYmxscF93YykgJSBkc2ktPmxhbmVzOw0KPiA+ICsJ
CQkJaWYgKHZfYWN0aXZlX3JvdW5kdXApDQo+ID4gKwkJCQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hf
Ynl0ZSA9DQo+ID4gaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSArDQo+ID4gKwkJCQkJZHNpLT5s
YW5lcyAtIHZfYWN0aXZlX3JvdW5kdXA7DQo+ID4gKwkJCQlpZiAoYmxscF9lbikgew0KPiA+ICsJ
CQkJCWhzdHhfY2tscF93Y19tYXggPQ0KPiA+IChESVZfUk9VTkRfVVAoKDE2ICsgNiArIDQgKw0K
PiA+ICsJCQkJCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieQ0KPiA+IHRlICsgYmxscF93YyArIHBz
X3djKSwNCj4gPiArCQkJCQkJZHNpLT5sYW5lcykgKw0KPiA+IGRhX2hzX3RyYWlsICsgMSkgKiBk
c2ktPmxhbmVzIC8gNiAtIDE7DQo+ID4gKwkJCQl9IGVsc2Ugew0KPiA+ICsJCQkJCWhzdHhfY2ts
cF93Y19tYXggPQ0KPiA+IChESVZfUk9VTkRfVVAoKDEyICsgNCArIDQgKw0KPiA+ICsJCQkJCQlo
b3Jpem9udGFsX2JhY2twb3JjaF9ieQ0KPiA+IHRlICsgYmxscF93YyArIHBzX3djKSwNCj4gPiAr
CQkJCQkJZHNpLT5sYW5lcykgKw0KPiA+IGRhX2hzX3RyYWlsICsgMSkgKiBkc2ktPmxhbmVzIC8g
NiAtIDE7DQo+ID4gKwkJCQl9DQo+ID4gKwkJCX0gZWxzZSB7DQo+ID4gKwkJCQlwc193YyA9IHJl
YWRsKGRzaS0+cmVncyArIERTSV9QU0NUUkwpICYNCj4gPiAweDdmZmY7DQo+ID4gKwkJCQlob3Jp
em9udGFsX2Zyb250cG9yY2hfYnl0ZSA9ICh2bS0NCj4gPiA+IGhmcm9udF9wb3JjaCAqDQo+ID4g
DQo+ID4gKwkJCQkJZHNpX3RtcF9idWZfYnBwIC0gMTIpOw0KPiA+ICsNCj4gPiArCQkJCXZfYWN0
aXZlX3JvdW5kdXAgPSAoMjIgKw0KPiA+IGhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgKyBwc193
YyArDQo+ID4gKwkJCQkJaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUpICUNCj4gPiBkc2ktPmxh
bmVzOw0KPiA+ICsJCQkJaWYgKHZfYWN0aXZlX3JvdW5kdXApDQo+ID4gKwkJCQkJaG9yaXpvbnRh
bF9iYWNrcG9yY2hfYnl0ZSA9DQo+ID4gaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSArDQo+ID4g
KwkJCQkJZHNpLT5sYW5lcyAtIHZfYWN0aXZlX3JvdW5kdXA7DQo+ID4gKw0KPiA+ICsJCQkJaHN0
eF9ja2xwX3djX21heCA9IChESVZfUk9VTkRfVVAoKDEyICsNCj4gPiA0ICsgNCArDQo+ID4gKwkJ
CQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSArDQo+ID4gcHNfd2MpLA0KPiA+ICsJCQkJCWRz
aS0+bGFuZXMpICsgZGFfaHNfdHJhaWwgKyAxKQ0KPiA+ICogZHNpLT5sYW5lcyAvIDYgLSAxOw0K
PiA+ICsJCQl9DQo+ID4gKwkJfQ0KPiA+ICsJCWhzdHhfY2tscF93YyA9IChyZWFkbChkc2ktPnJl
Z3MgKyBEU0lfSFNUWF9DS0xfV0MpID4+DQo+ID4gMikgJiAweDNmZmY7DQo+IA0KPiBIYXJkd2Fy
ZSByZWdpc3RlciBpcyBzZXQgYWNjb3JkaW5nIHRvIHNvZnR3YXJlIHZhcmlhYmxlLCBzbyB5b3Ug
Y291bGQNCj4gZ2V0IHRoaXMgdmFsdWUgZnJvbSBzb2Z0d2FyZSB2YXJpYWJsZS4gRFNJX0hTVFhf
Q0tMX1dDIGlzIHNldCBpbg0KPiBtdGtfZHNpX3BzX2NvbnRyb2xfdmFjdCgpIGFzIHBzX3djLCBz
byB5b3UgY291bGQgdXNlIHBzX3djIGluc3RlYWQgb2YNCj4gcmVhZCBpdCBiYWNrIGZyb20gcmVn
aXN0ZXIuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCj4gPiArCQlpZiAoaHN0eF9ja2xwX3dj
IDw9IGhzdHhfY2tscF93Y19taW4gfHwNCj4gPiArCQkJaHN0eF9ja2xwX3djID49IGhzdHhfY2ts
cF93Y19tYXgpIHsNCj4gPiArCQkJaHN0eF9ja2xwX3djID0gKGhzdHhfY2tscF93Y19tYXggLyAy
KSA8PCAyOw0KPiA+ICsJCQl3cml0ZWwoaHN0eF9ja2xwX3djLCBkc2ktPnJlZ3MgKw0KPiA+IERT
SV9IU1RYX0NLTF9XQyk7DQo+ID4gKwkJfQ0KPiA+ICsJCWhzdHhfY2tscF93YyA9IGhzdHhfY2ts
cF93YyA+PiAyOw0KPiA+ICsJCWlmIChoc3R4X2NrbHBfd2MgPD0gaHN0eF9ja2xwX3djX21pbiB8
fA0KPiA+ICsJCQloc3R4X2NrbHBfd2MgPj0gaHN0eF9ja2xwX3djX21heCkgew0KPiA+ICsJCQlE
Uk1fV0FSTigiV3Jvbmcgc2V0dGluZyBvZiBoc3R4X2NrbF93Y1xuIik7DQo+ID4gKwkJfQ0KPiA+
ICsNCj4gPiArCQlscHggPSByZWFkbChkc2ktPnJlZ3MgKyBEU0lfUEhZX1RJTUVDT04wKSAmIDB4
ZmY7DQo+ID4gKwkJZGFfaHNfZXhpdCA9IChyZWFkbChkc2ktPnJlZ3MgKyBEU0lfUEhZX1RJTUVD
T04xKSA+Pg0KPiA+IDI0KSAmIDB4ZmY7DQo+ID4gKwkJZGFfaHNfcHJlcCA9IChyZWFkbChkc2kt
PnJlZ3MgKyBEU0lfUEhZX1RJTUVDT04wKSA+PiA4KQ0KPiA+ICYgMHhmZjsNCj4gPiArCQlkYV9o
c196ZXJvID0gKHJlYWRsKGRzaS0+cmVncyArIERTSV9QSFlfVElNRUNPTjApID4+DQo+ID4gMTYp
ICYgMHhmZjsNCj4gPiArCQlwc193YyA9IHJlYWRsKGRzaS0+cmVncyArIERTSV9QU0NUUkwpICYg
MHg3ZmZmOw0KPiA+ICsJCWhzX3ZiX3BzX3djID0gcHNfd2MgLQ0KPiA+ICsJCQkobHB4ICsgZGFf
aHNfZXhpdCArIGRhX2hzX3ByZXAgKyBkYV9oc196ZXJvICsNCj4gPiAyKQ0KPiA+ICsJCQkqIGRz
aS0+bGFuZXM7DQo+ID4gKwkJaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUgPSAoMSA8PCAzMSkN
Cj4gPiArCQkJfCAoaHNfdmJfcHNfd2MgPDwgMTYpDQo+ID4gKwkJCXwgKGhvcml6b250YWxfZnJv
bnRwb3JjaF9ieXRlKTsNCj4gPiArCX0NCj4gPiAgCXdyaXRlbChob3Jpem9udGFsX3N5bmNfYWN0
aXZlX2J5dGUsIGRzaS0+cmVncyArIERTSV9IU0FfV0MpOw0KPiA+ICAJd3JpdGVsKGhvcml6b250
YWxfYmFja3BvcmNoX2J5dGUsIGRzaS0+cmVncyArIERTSV9IQlBfV0MpOw0KPiA+ICAJd3JpdGVs
KGhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRlLCBkc2ktPnJlZ3MgKyBEU0lfSEZQX1dDKTsNCj4g
PiBAQCAtMTI0Niw2ICsxMzQ1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHNpX2RyaXZl
cl9kYXRhDQo+ID4gbXQ4MTg4X2RzaV9kcml2ZXJfZGF0YSA9IHsNCj4gPiAgCS5oYXNfc2hhZG93
X2N0bCA9IHRydWUsDQo+ID4gIAkuaGFzX3NpemVfY3RsID0gdHJ1ZSwNCj4gPiAgCS5jbWRxX2xv
bmdfcGFja2V0X2N0bCA9IHRydWUsDQo+ID4gKwkuc3VwcG9ydF9wZXJfZnJhbWVfbHAgPSB0cnVl
LA0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
bXRrX2RzaV9vZl9tYXRjaFtdID0gew0K

