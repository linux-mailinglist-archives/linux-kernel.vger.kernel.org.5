Return-Path: <linux-kernel+bounces-141882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44878A24A3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C601F23594
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6CB182DF;
	Fri, 12 Apr 2024 04:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Q1R8geKP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OHJPOM+Y"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED3179B2;
	Fri, 12 Apr 2024 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712894406; cv=fail; b=b9M1DBPFj8g4H+GQNsLmtE9Kc+HFIaqsPRvIrIkNqXZEAOwBBJVRZo4DmZtX6ZlcbAFr+epClBIzGcoIO4CG3mXjspL8WLeOr6p+3w6gMWc1LVb1ZzA1AmcLDXdBsUiWnAStS9/nX90GKC/5jcFh9kE8dfdPuj70nhtGCBBO0ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712894406; c=relaxed/simple;
	bh=Ie8Xb3ONcevzYCOEN/2Urkb9mAMhesyRIg2AFnrB9HI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ixqwQY+uLWltaGM6aZM57zZBBP0cq2UIT+ePsBa1oOYdlNbJBsYgp1et5Al4TFYPvvk+863jrPlcpEOZbQfrT1++OhK43op68NuyRFB45AW5o8GYsQYpsTY9WVJLt8/uXnmUL6XHbWMViPs+Bboke1AlFCQj8cOrZOpDAZU1d2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Q1R8geKP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=OHJPOM+Y; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 20f4ece8f88111ee935d6952f98a51a9-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ie8Xb3ONcevzYCOEN/2Urkb9mAMhesyRIg2AFnrB9HI=;
	b=Q1R8geKPfPsrDqqjv7F05bWEmOhxFvhtewHs2wgW6ys0Xji7pO5AWKkRwigPB35qzmtX56w1T3hNXmgcEgfwOh+ZdzyFE3Z11U18JV80/fZGackNNpmBIROatkkLzYK2oTVh9zM8Cf2rCvA/jgaYyvi6JoSdUXnwo2sr487AjuQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:797a387c-145d-4fd0-b6fb-bc21c85a1c57,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:d35ad2fa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 20f4ece8f88111ee935d6952f98a51a9-20240412
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 420159777; Fri, 12 Apr 2024 11:59:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 11:59:57 +0800
Received: from SG2PR03CU006.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 11:59:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7oxAq92QdjW+Yspev1bHsJkS5KY9KztUn5vIr3g1hUDx0ZLp6YwoRncTSKx6FBUwa482x6stQ+68mVc6/ZooMvcgCnuKrFG8BS5szreKDwOIM6YRQkcM36/HaorESekYwJ6qYkKiJTfTm6VqpvusuqE64/cuiWnvAqRAvj/cRQtJ19eQnF61dPJFC2EO7I+IIxTRbsDDb2vjgGdg8C1cz5ipUr+u1I+Epcadr+NEsDnNsrtFf124xJdcm7wwmS7nZetd068pVRYDiJ1ESi6tDkfxO3JjCihKPiMYRPKVIscxjf8MHriK02LuTuWKWtZcQqYZQ2//efkpT/sYqurpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie8Xb3ONcevzYCOEN/2Urkb9mAMhesyRIg2AFnrB9HI=;
 b=ANW6dEyNHg/EwJhMO9a56DqLD6spaqOZYAbr5+4M2dCBDqVGZoAsPlJS88PcqsyXiMnIq6pYzStUarvk6BhwhVSFNnDiBpbJvTlvwdEA3a3QOdRPxu7UVqmkBBOoF7/gC44jgliaSdJgC5XUYrv9cP6PaWHeu4rGr3OU5OsQzZrFXu5WPhzCqJgeBjbpSBD0fzTEWmfJ1GaDN5IoMnbN4KVs4D2rTqsvEqbcI5RBCKy56Z9XshBIFxzgwmS+WZKQu1wYIY8BPIldX0XcwSWNJRuJXdWFnWFayQ9zk8OCl2Ibo9bWjYz8oAs/WTroIuROWpjpDrvd5VdtPEdGABi6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie8Xb3ONcevzYCOEN/2Urkb9mAMhesyRIg2AFnrB9HI=;
 b=OHJPOM+YGdsW1A8yRMY4/7Va/FdVxR684rs/lTf9vlyAfjUCl9hXtveov4o9xo25EE8YX0+g3+rdCG19zBJBjpUoLQHYxdMtLa+HT8u5cA/8lawvI9SeKdbX9kCLvm+ZppLuI5kHTsOCctidruE/ZvgXNBqeC3CehiEyuSvIcPs=
Received: from OSQPR03MB8697.apcprd03.prod.outlook.com (2603:1096:604:292::8)
 by SEZPR03MB6849.apcprd03.prod.outlook.com (2603:1096:101:94::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 03:59:53 +0000
Received: from OSQPR03MB8697.apcprd03.prod.outlook.com
 ([fe80::9e99:12:7cbe:1294]) by OSQPR03MB8697.apcprd03.prod.outlook.com
 ([fe80::9e99:12:7cbe:1294%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 03:59:52 +0000
From: =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= <Yunfei.Dong@mediatek.com>
To: "nhebert@chromium.org" <nhebert@chromium.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "nicolas.dufresne@collabora.com"
	<nicolas.dufresne@collabora.com>, "benjamin.gaignard@collabora.com"
	<benjamin.gaignard@collabora.com>, "hverkuil-cisco@xs4all.nl"
	<hverkuil-cisco@xs4all.nl>, "sebastian.fricke@collabora.com"
	<sebastian.fricke@collabora.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>
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
Subject: Re: [PATCH v3] media: mediatek: vcodec: support 36 bits physical
 address
Thread-Topic: [PATCH v3] media: mediatek: vcodec: support 36 bits physical
 address
Thread-Index: AQHai94nDx/OQgQvZkW9R2IyuHopv7Fipx0AgAFc5AA=
Date: Fri, 12 Apr 2024 03:59:52 +0000
Message-ID: <26acb3d0aad64d629c794867b4428c50ef9f97a6.camel@mediatek.com>
References: <20240411070127.12384-1-yunfei.dong@mediatek.com>
	 <d230b840-471b-4f77-b9f4-34a4063f1db9@xs4all.nl>
In-Reply-To: <d230b840-471b-4f77-b9f4-34a4063f1db9@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR03MB8697:EE_|SEZPR03MB6849:EE_
x-ms-office365-filtering-correlation-id: dfdd4b92-3c44-4b67-0fb6-08dc5aa501fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +yGXM1pzuTlpgGwWlv55Ulvf8OGNG3mIslv8Ssz3vh9bQNunwIbTnWIzVyUaxmwXNgRhzWOooAu7lU7Y3V78dw5GPkLS2CeVcRoF2608gwhOjAWLw+yrZVbL6THNTFOVR8E4dwWTXdCU2Fb34ZOE15aFpf5uW05E/3gMVGIvvssVlbmmOGNYwsf/ChjsKZ4XE5+Bnh1g0j8RtVlS8T79xLeIW1keYonlePr1qTmk+vhF/v8VZxt5J0Lt/YwwaGxZ9lB44LcXbYOavLZjAnAwpfTBpIDlFWmVed/uYj/HJlDH7gmZH7FUetlCsED1Ve6V4Q4pKnJVZ56meHf7zzOzG9Tk155Pw7V2fup3mdlQz0Z2/hjmI2UDx1SrkgAp2uk/9F4pdICLj5Npevw7X9DyjlCugQKEtv14FJxurmTHL4m5rDVaggARcqdDIDnMFe1JVf6IbX+4F7XAQ7Dso0lPKSG1uc65eDQG9ZB+OUCfkyMJJnalE/Jx/TigiUxyngpofoRwfQuCjFOlLOMXjvkueWtpZxKBmmWPr4A14V0Y9suYTvABwN63lPi642BPOiuoMy0eME1CzHsAe7GiiVZcUEEoAtfKHn1WTSNNNxXte/j6d3/9R+oMyu3UsOFNAMa0NCoVeNoIIxQ7piPrYIE9BKQwVBtAevxHgEqeUdhPp8skOv/DBqGdn9Fpl2TCDNDpEVVFL3ucU6Ic8vRoJuBzGK9XiBDMQUjZ7FYamOJhc58=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR03MB8697.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXBEMlJPdE5GclZMSk1tenBzQllWVDYvUkNkdzV5WHF6dFVJMkN1Q2hYRzJr?=
 =?utf-8?B?V1RGRERHSTBEd0Jad013MnRoTVRHVVQyRndxSHZPaWVMaTlRZk1aQnQ3dzlJ?=
 =?utf-8?B?a3VhcWVZZ3JUc3lvdXBDNWR1VGFKaDVQY2piY2hmYnlkdFdoQ2xsT0VKaUwy?=
 =?utf-8?B?SGFyckYwT0JLNWoyazl0OEhOS1Y5L2JOQjkrSHBtbFU0NUt6ZTl4UHNpQ3gw?=
 =?utf-8?B?dGdINXk0RXhENWpMdmcxV3RibGxwVmF0dEhoM3ZRVUhYZ1FmZmJIcFNndmw0?=
 =?utf-8?B?ZVAxdG9Pcnplc28za29LV1VXMzFtM3hrZUNLRndpbjFTME90Z2VzS2o4a3hh?=
 =?utf-8?B?bXBuc1B4MEFVMzFzQzdrN0JBL2VNZFhXV3MzTGxKZTc2UjdxMTRjNjE5NU80?=
 =?utf-8?B?bFZsVGVGYWNSZU1JTExaUE05TTkwOVJJTmY1WkxhMG5JS2tpSFlOVE9xd3po?=
 =?utf-8?B?U2F4ektCSHZCNDhqQ3F6THdhOE1WczEzL3o5djhKMGIxUXpVSis1OW5XY0ZP?=
 =?utf-8?B?UVRUNDZwZm8xRjhIZFlTaE9oU1NLSE9ULzRETmJEU1BFc0RTUWNwcVpKSS8y?=
 =?utf-8?B?ZHNNdURKNFBHVTZYV3U0aG8yY0VxcW1ZUGlWYm9kZ1pNTHkyZjQ0VzJGaXFX?=
 =?utf-8?B?bjRJTTlrempEWElhL045MlFYTDRoOE94b3E0c1hWWVR5UG03QkU4TFYwdWlU?=
 =?utf-8?B?QmNxSVJZSE9IYnVMMlZGTmZXK0Z5eUV5Wnd0MGZpNElKd3FTNnJOQ2I5c0Fx?=
 =?utf-8?B?NmxlamZHSzVRWTJmdGhNREJ6Wm4rSDBCajJKRE9ERGhqTnR4a3pSblRuV2Q0?=
 =?utf-8?B?RkJZOTk0T3lBa1NMMllaeGNuWGp0Zmo3TmpLVzlKYVNHL3dlZlZORGV5WjF6?=
 =?utf-8?B?Tk9ZN2hqU3lzRjh5bW0wWGpWKy9sLzduWWRrVkZ6UVFzUDIwQ09lZ3BWY3k0?=
 =?utf-8?B?dWFIUU54SXZqNUg5VHd3YWNqT2dMN09qaHgvaTB6aldQODdHSUZjekZRYWhm?=
 =?utf-8?B?QnBaWEo4QW9nNGZHU2h2ZVJlUC9kL1doWkNhcVk3cWNHMU5SZ1MxL0JqOXJ0?=
 =?utf-8?B?S0l2OGFSUXdJWHVWaE5kcG8vS0FRbDVkeFJrOGZRWWdnVlkyTkFOa21tYVo1?=
 =?utf-8?B?VkdWRHY0K2RBUExINnhGbFdKVEMybk1paVZ6dXlzbDlraitMbjh1d0YzdGxE?=
 =?utf-8?B?M2pDUzhkQnJHekxGR2NSRWxzVHhIWVRZZjZJM3pabkEwZkZzWThWWHhTYWlW?=
 =?utf-8?B?QTlrOHVzeEk5UGt4Wk9xdkV0cGlaV0h1ajV1WUNLTENTK2Q3eC9tMktuOGxH?=
 =?utf-8?B?ZXd3UHJWcUkxSWVIMW1OVGRpdXY5Y2lRbzloc2tGbXFtSlRId0xOOVF5akh4?=
 =?utf-8?B?alB3U3BGb21rdzZrY2VOWjdFOFpnbEZzbWpGT0VDTS9VK0Roa2R5TnJnM2xK?=
 =?utf-8?B?aDN2dGgvMzFtVzdmVHJ5alZxQXlJN0drcjJoYmhjamtDcmNLUmttS05INnpX?=
 =?utf-8?B?d0NVWE5DMWJBVFhpb1MySFg2aGtTVS8xb2cybSs1TVJYZVNuZ1Zza0pEbjJu?=
 =?utf-8?B?RWlXKzVpMU1YQ3BvaHdOMk1zK2llZEdwZG1HL1RtZFpkVFBtdTRLbExuYnlN?=
 =?utf-8?B?MU9RR0Y0WDF5ZTlZc000T21Va3c0Sm5Fd3E0dHA5MTE5ajF5b04zeVVaVTdp?=
 =?utf-8?B?Yk01VHJBaXVHZUVrNkxUVk51ZjgxNUdlMDJZdlAyU0laeFo1eHpJTTFWamJN?=
 =?utf-8?B?bEFvUXl3RlNvTC9wc0svZThtNHg4L0NHNENUUEVEZkFoRFZSWDRURW9CTU1O?=
 =?utf-8?B?OHRCSHpEaWFzOU84dmRocmIvc0xwcllqR0RYdjVCZDVyaHB2YndjVzJiTEkz?=
 =?utf-8?B?N3Z2b0tWNnBudzZ5VEk0amNEdFlPY0Q2cDAxYmR5QkRJd2dBcGhkREkxZDhO?=
 =?utf-8?B?eC9jMUhOTjhrWWdGSzQrM281aFQydVFBeTBmeWRiNXI3YnlkblJPRzhPbEFo?=
 =?utf-8?B?MlhzVlBRbEFhcWxlTXlCZWJlSnd1ZTFZNUlBcnNYdC80em5nS25LdUU2V3Bz?=
 =?utf-8?B?bW9uVWphcjMxZlg3aURoVG1LVnBSU0ttcXg2MEN1RkZCWVZuQkFNY3pjTWhk?=
 =?utf-8?B?WVA1T2VobFA1TmVrMk9uSDh1RGMyL3VCL3BveHg0UlN3UFJNT3o2L3VKTkow?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <047FBBE8E087824CB4627AC1AE502EA4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR03MB8697.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdd4b92-3c44-4b67-0fb6-08dc5aa501fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 03:59:52.8540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLzVnmtazlQA6YZRj1Ujr7S676mVI0N16f7q9T/aRI8K21D+Q0DWU+gSfnKN1iiXcM/VRzvFA8znMYtbLlCqntq+cNy92C5BQoyDM+q/Wkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6849
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--27.218100-8.000000
X-TMASE-MatchedRID: QfHZjzml1E+nykMun0J1wpmug812qIbzvtVce6w5+K8NcckEPxfz2DEU
	xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CxfohHCqSnabqr1EweP157Q0/x
	bS3+sxpQr1LDF5Dz/8davgVF061xEc4SuAICAZm5A+s/DdZtQCxhH6ApagZfO31GU/N5W5BAiiF
	Ii+xQv7zFKvVyvO1BmBa4k6KHoaTQtVrIvuTuiXBl7FdaNVULcreESfAXjbwpcTkKj9pRvYKPFj
	JEFr+olFUew0Fl/1pEBi3kqJOK62QtuKBGekqUpPjKoPgsq7cA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--27.218100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5F5B0CAAA72EE18E72AB26F727ACA09A748BD0C0CF08297A150DFC553CE222512000:8
X-MTK: N

SGkgSGFucywNCg0KVGhhbmtzIGZvciB5b3VyIGFkdmljZS4NCg0KU2VuZCB0aGUgZml4IHBhdGNo
IGFnYWluID0+IG1lZGlhOiBtZWRpYXRlazogdmNvZGVjOiBGaXggdW5yZWFzb25hYmxlDQpkYXRh
IGNvbnZlcnNpb24NCg0KQmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCg0KT24gVGh1LCAyMDI0
LTA0LTExIGF0IDA5OjExICswMjAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+ICAJIA0KPiBFeHRl
cm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiAgSGkgWXVuZmVpLA0KPiANCj4gU2luY2UgdGhlIHYyIHBhdGNoIGlzIG5vdyBtZXJnZWQgaW4g
bWFpbmxpbmUgYXMtaXMsIHlvdSBuZWVkIHRvIG1ha2UNCj4gYSBwYXRjaA0KPiBvbiB0b3Agb2Yg
dGhhdC4NCj4gDQo+IFNvIGp1c3QgcG9zdCBhIG5ldyBwYXRjaCB0aGF0IGFwcGxpZXMgdG8gdGhl
IG1haW5saW5lLg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCj4gDQo+IE9uIDExLzA0LzIw
MjQgMDk6MDEsIFl1bmZlaSBEb25nIHdyb3RlOg0KPiA+IFRoZSBwaHlzaWNhbCBhZGRyZXNzIG9u
IHRoZSBNVDgxODggcGxhdGZvcm0gaXMgbGFyZ2VyIHRoYW4gMzIgYml0cywNCj4gPiBjaGFuZ2Ug
dGhlIHR5cGUgZnJvbSB1bnNpZ25lZCBpbnQgdG8gZG1hX2FkZHJfdCB0byBiZSBhYmxlIHRvDQo+
IGFjY2Vzcw0KPiA+IHRoZSBoaWdoIGJpdHMgb2YgdGhlIGFkZHJlc3MuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gPiBS
ZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2No
aW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gLS0tDQo+ID4gY29tcGFyZWQgd2l0aCB2
MjoNCj4gPiAtIHJlbW92ZSB1bmxlc3MgY2FzdA0KPiA+IC0tLQ0KPiA+ICAuLi4vbWVkaWEvcGxh
dGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvdmRlYy92ZGVjX3ZwOF9pZi5jIHwgMg0KPiAr
LQ0KPiA+ICAuLi4vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvdmRlYy92ZGVjX3ZwOV9yZXFfbGF0
X2lmLmMgICAgICAgIHwgNA0KPiArKy0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRlY192cDhfaWYu
Yw0KPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvdmRl
Yy92ZGVjX3ZwOF9pZi5jDQo+ID4gaW5kZXggOTY0OWY0ZWMxZjJhLi41Zjg0ODY5MWNlYTQgMTAw
NjQ0DQo+ID4gLS0tDQo+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMv
ZGVjb2Rlci92ZGVjL3ZkZWNfdnA4X2lmLmMNCj4gPiArKysNCj4gYi9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRlY192cDhfaWYuYw0KPiA+IEBA
IC00NDksNyArNDQ5LDcgQEAgc3RhdGljIGludCB2ZGVjX3ZwOF9kZWNvZGUodm9pZCAqaF92ZGVj
LCBzdHJ1Y3QNCj4gbXRrX3Zjb2RlY19tZW0gKmJzLA0KPiA+ICAgICAgICAgaW5zdC0+ZnJtX2Nu
dCwgeV9mYl9kbWEsIGNfZmJfZG1hLCBmYik7DQo+ID4gIA0KPiA+ICBpbnN0LT5jdXJfZmIgPSBm
YjsNCj4gPiAtZGVjLT5ic19kbWEgPSAodW5zaWduZWQgbG9uZylicy0+ZG1hX2FkZHI7DQo+ID4g
K2RlYy0+YnNfZG1hID0gYnMtPmRtYV9hZGRyOw0KPiA+ICBkZWMtPmJzX3N6ID0gYnMtPnNpemU7
DQo+ID4gIGRlYy0+Y3VyX3lfZmJfZG1hID0geV9mYl9kbWE7DQo+ID4gIGRlYy0+Y3VyX2NfZmJf
ZG1hID0gY19mYl9kbWE7DQo+ID4gZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvdmRlYy92ZGVjX3ZwOV9yZXFfbGENCj4gdF9pZi5j
DQo+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci92ZGVj
L3ZkZWNfdnA5X3JlcV9sYQ0KPiB0X2lmLmMNCj4gPiBpbmRleCBjZjQ4ZDA5Yjc4ZDcuLmVlYTcw
OWQ5MzgyMCAxMDA2NDQNCj4gPiAtLS0NCj4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlh
dGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRlY192cDlfcmVxX2xhDQo+IHRfaWYuYw0KPiA+ICsr
Kw0KPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvdmRl
Yy92ZGVjX3ZwOV9yZXFfbGENCj4gdF9pZi5jDQo+ID4gQEAgLTEwNzQsNyArMTA3NCw3IEBAIHN0
YXRpYyBpbnQNCj4gdmRlY192cDlfc2xpY2Vfc2V0dXBfdGlsZV9idWZmZXIoc3RydWN0IHZkZWNf
dnA5X3NsaWNlX2luc3RhbmNlICppbnN0DQo+ID4gIHVuc2lnbmVkIGludCBtaV9yb3c7DQo+ID4g
IHVuc2lnbmVkIGludCBtaV9jb2w7DQo+ID4gIHVuc2lnbmVkIGludCBvZmZzZXQ7DQo+ID4gLXVu
c2lnbmVkIGludCBwYTsNCj4gPiArZG1hX2FkZHJfdCBwYTsNCj4gPiAgdW5zaWduZWQgaW50IHNp
emU7DQo+ID4gIHN0cnVjdCB2ZGVjX3ZwOV9zbGljZV90aWxlcyAqdGlsZXM7DQo+ID4gIHVuc2ln
bmVkIGNoYXIgKnBvczsNCj4gPiBAQCAtMTEwOSw3ICsxMTA5LDcgQEAgc3RhdGljIGludA0KPiB2
ZGVjX3ZwOV9zbGljZV9zZXR1cF90aWxlX2J1ZmZlcihzdHJ1Y3QgdmRlY192cDlfc2xpY2VfaW5z
dGFuY2UgKmluc3QNCj4gPiAgcG9zID0gdmEgKyBvZmZzZXQ7DQo+ID4gIGVuZCA9IHZhICsgYnMt
PnNpemU7DQo+ID4gIC8qIHRydW5jYXRlZCAqLw0KPiA+IC1wYSA9ICh1bnNpZ25lZCBpbnQpYnMt
PmRtYV9hZGRyICsgb2Zmc2V0Ow0KPiA+ICtwYSA9IGJzLT5kbWFfYWRkciArIG9mZnNldDsNCj4g
PiAgdGIgPSBpbnN0YW5jZS0+dGlsZS52YTsNCj4gPiAgZm9yIChpID0gMDsgaSA8IHJvd3M7IGkr
Kykgew0KPiA+ICBmb3IgKGogPSAwOyBqIDwgY29sczsgaisrKSB7DQo+IA0KPiANCg==

