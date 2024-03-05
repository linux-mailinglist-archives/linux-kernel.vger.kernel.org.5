Return-Path: <linux-kernel+bounces-91500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D09871265
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C1C1C21C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C8C18048;
	Tue,  5 Mar 2024 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gq6Ru6V5";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="e2+WmwF1"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61717BBD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602760; cv=fail; b=D3KaBKUV8IWzY4E0LaTM2tF8I4fdEWqYYPNkLZMsNWjONpoG4mRVyQVjEIv3trykASNKsgK6DE0I87zwkZW3gwe6jmo7VjZy0aoKCBy5zmhB6LwKfmdQi/JsK1mkS1lZT34pNj5jxY8Ypiz3/G1agPbi9d8MSlzTl5vvTnNRcaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602760; c=relaxed/simple;
	bh=TIOUvDkb2Kq1aXOsFx7BUrNdI35cJSjP5FKjcufV1Pk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ixs7hcWHmG7Y8G7pSLVuzWMoir8dSlRpMOAuK1YDKA5+qZW/2lHTwD7Wm5A4YmgnU+rf1RB1dVVBIrFvM7AUUwyWwUmqij1ezM04CbMnvQwT5Cz1P8cUZhKzdzaFV27bEEHmJLLndI2a/wYdaRF3rx5ybaNY5ydqKdfaYK2pBvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gq6Ru6V5; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=e2+WmwF1; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 29442908da9111ee935d6952f98a51a9-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TIOUvDkb2Kq1aXOsFx7BUrNdI35cJSjP5FKjcufV1Pk=;
	b=gq6Ru6V5WV7opAlErZNnU4sAiXBajhiDcTwPKt8fETvp/+ksZBLx+x7VxcmjKc8TeO3osnXJF8yATZhnxHrZMl6K1Pl6wbnUBaIHO3xheGFskCj3tB6UD+pOo6khrrXnEBNEgv/ZzsurI41VIXUlImDFud+tEn8nhrf8zEXUvtA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:5a5af65b-2fdc-4bb0-8f9a-7b3cda824b1b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ec630390-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 29442908da9111ee935d6952f98a51a9-20240305
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 188641247; Tue, 05 Mar 2024 09:39:09 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 09:39:08 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 09:39:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvI6HELR3ZoAEJx3SFLzylKRSzTZB+AghE5ME/dSx0OwlEtVpxQRiFnP/VgklqlDlfK22Ol/kTwnuDOr1oy2/c8faTgRV0MukXZqTs0t/fz6Fgn+jh1T4lUc+MSF4uaVyChtku+g9aRoMgQlXhdKZAQMxcc8zMQTyRuzLklFEpqj4eezwyDVtOXsQWIAsMko2X+ii7IqATAl4jOoeXrr/3DRTnX6mdya9B9WzLDt2wXUsVwjsNlbouepiDfx65X+HPT04bMYG1w5bKfWsTm4Mo0tYYnDgE+ng8VuKHMhKQWghQA3JxuLcaCpoxFJmDJCwLSV2GwmjSGRCrdq5OakJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIOUvDkb2Kq1aXOsFx7BUrNdI35cJSjP5FKjcufV1Pk=;
 b=JxwlGwDkACm4A8lTK7n1WZRFwHfNPp/1qbZRXnapUUxezyZmr/DCCJ/9BRV6/ZxgYhQD5rKd7wEBhBu7Tnl1z4tqXb62r6ANIHDlESQ+yP41UmmSb0KEoWHiXNLGHoJsHClgnKrjmFZt1QGUZskt9dRvh23P5Jr/93dqfcBqGJ9PAWBTlgou3kPZhD5J+uK50mjLaLRClgG0RiiPS9Wl1DhqnHY21KgQ8wFx/DYwjXEY5FMGm5n7zzgqDcRPy6yeVcytEAvBDRlZ4hmaxWgFQiCspfhPiOxmXXgr7lv2EAWjyfYBrEUjiKGC6kJQRgfU2zpwwxRGOs6fhfkIPf+u/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIOUvDkb2Kq1aXOsFx7BUrNdI35cJSjP5FKjcufV1Pk=;
 b=e2+WmwF1OS0kInic0wItFO+ju7zdcdnLWHlGVePk+qLhr0T4KPsjd6QaSfb2d4VGMlFoJcZ2W9CEf02kbQfkN9JrbCDek7PvDa5oQzQUfT2cB5L3vfh9zTq8dJ/FgXA+4a9lWr+aLfVrwPqwvOwexEBgVGXx1E+nZzrw7mjubPQ=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB8123.apcprd03.prod.outlook.com (2603:1096:101:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 01:39:05 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 01:39:05 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_mem_move()
 function
Thread-Topic: [PATCH 2/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_mem_move()
 function
Thread-Index: AQHaa8lZiPNUJVSduEadklRVdCKA/7EnX3wAgAEEwQA=
Date: Tue, 5 Mar 2024 01:39:05 +0000
Message-ID: <791ab60f10ae5819ee2a217cd84e097e045e9033.camel@mediatek.com>
References: <20240301111126.22035-1-jason-jh.lin@mediatek.com>
	 <20240301111126.22035-3-jason-jh.lin@mediatek.com>
	 <41a2017f-5627-42fe-a624-642c3c47f436@collabora.com>
In-Reply-To: <41a2017f-5627-42fe-a624-642c3c47f436@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB8123:EE_
x-ms-office365-filtering-correlation-id: 55d45145-5502-4f81-dea7-08dc3cb50b2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hroO+lcqew0fiWjGIFWZDBqXzoXZjSZtCXNrbMgTJmGBIfX5GkwDl6kjZTsoxV9/1U9uM9iiDhlQPuQfkc3ArlWCs4xAOsJ7XJyjjODY2kBKFf7znGeJ5iaBajdO2NmMcTuMPkOprPEuWEDzAmSplcNmfrllC+BXDsUdKo2vaVaG/8CvxXMbk9o+NkqgYRaFNB93eKIgnHR56aH5YdEQXUNhLWKIQnXpCDK4zDlYgRpw0TsMdDsMM4jPUmGWHVQaeUElKCV6q1rEWitncIYDQG2I2OKg0D/HvAbNqUts11D1wKHyxRDwGBzoLUz7FtbgTorR3NdT9XtUP0qAJPsloQF1ZGI33zTSoYoOX3maF+hEMkaFr7EQjC3hbcfso1s9caCF4K/Nan8wKJ7aA1DfxIEXRfQ8LwNjnVtGznxCGt3wUUH8JSP7Wo8n9peHV2qty9vMDy1wtPVFku89Q1mTu73WFRsQ28D0ufSjOyDHxeeJ3GBrFmRxLjrpK+SIu3tKRPAL4EkvkLs2nPC+HZJxQrpaKLLJV+DHKQJNd2D9fse4cmGzeTm2iGldLiOoEc/n5GND8C00sGtLEjolZiPe2N26eTaI2bYtY5ZU4OtXkrT7cN+ZDG9d/gIy9DNem9Zisvb0lmjdZ432H76Ay8xY8/XJE6N2MuUQf3Vqxig28Kl5BJdt0xNzzxnAPIC/sIuZ7YtJQpdY37gYsjHJFw+fxoASmNOy8ekVuriql9iz3qw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3c1WlE3dFpCeUdURi9OSzE0dGpDWlRERWc2TnZXS0pHZk9lcTh6OHY1Z0JQ?=
 =?utf-8?B?dm9VM1VuZTYyNlVLUmd0MFU4NFg0SmlYclZFbUZ3MkNoT3ZUb1hQbER0dm9F?=
 =?utf-8?B?R21MeE55UWZOU0wwVFEwUk1BWHhXU3RTZUxBY3lXaG9HQVpEbXFvMW91Y1JU?=
 =?utf-8?B?dlp5WkFEZ0NlZDZESnBmamlna3JBUFoxNXdLYWNRbkRKUGd0a25peVV4WTBO?=
 =?utf-8?B?c3h6Q3dkMXpoVk9maFpsd293c2lScjIvM0E2YVJZREgzRkRxTTdvSGIwZlJC?=
 =?utf-8?B?cndTcFF5V1VYZHdjNXo3WFVRb1JJWFJlQzg2VlFzckZvNmdIVGRiVTRoN2lF?=
 =?utf-8?B?U1R0QzE5azcvejVyeFY5Z3I4UFNFOXNPYnJCZDhLOW5XSUJmeGI1T1UvckVL?=
 =?utf-8?B?WkpzRWhiQkxzZW5sRUQ3NUVPUlpSUlE1L1BZbjFrUlFMWU53bnlFWXdHY1Qy?=
 =?utf-8?B?cUdCeWlMUE11MmE1elhQcUVEVmpNUzN0Ung5RzdWRlFIYVJ5KzBCVDV4bEtz?=
 =?utf-8?B?QkozTnV3WlBRbVZVK0dFZXJ2dnJORmtmMW9IZ2lBRXU3YlBqdjNVRlhjNjRK?=
 =?utf-8?B?OWNIVkZySjFBa0hLcFBXMllycXllRnMzZWdYa2tKcnVidHVIUStBWE5NT3Yv?=
 =?utf-8?B?TWxxbHhLNWs0Sjl6eUl0aVBoT1E1dmJpOFdBcFlPZkpySXNMZDJFU0R3TGFQ?=
 =?utf-8?B?aEREVGt3WWRGNnA4djBVMTFYOXczYnFMRld4cUg1eUg2N2l1NDRUdk5VMUdr?=
 =?utf-8?B?UTc0NWZXRmlnbVFreEtMWG5YQmFudmlnWGJzQkpESGtKbjM3ZUp3VytuUGJM?=
 =?utf-8?B?YllCaFROelFXY2lrWjl5eXl1QytFZ3VQNXkwTXhsdldNVWpEOTVnbCtFOG10?=
 =?utf-8?B?ZmRVMjlxWHBzZXQ1a0ppTjhhVWtUSml3RHN2cno1bld3MG1LazVWMk0xN0NM?=
 =?utf-8?B?bmErak9iTml1aFRaQmM0WVlKbGtLeFJBbGNPUHlOdVN4eXRWZFZTR3U2TUh4?=
 =?utf-8?B?UW9taEtzUUFWeHFkWFMrSjJoelFXYUM1MjNOWE5wNWRLclBNTllHMnZzNzNN?=
 =?utf-8?B?Tlg3dEE3WFBXTms2SlU0OThpWjRIODltdUxVaGQ3S0lDWUZnVFpGZGpUQnVB?=
 =?utf-8?B?YnVCTVVFZHVxNWIzcmFUekExYThoc2gwcUQxWHdNTTU3RnU5eHcrb3JXNERU?=
 =?utf-8?B?TWZLUElsZmV4MXBBMHhhTzZ1QU5mSDNZVVhHYjRCdGZidTBSNGpZcis1dXVE?=
 =?utf-8?B?dnZNUEpPalJ2MVJzalpEdDlOK3pmdEpOTVdITWg1M20wTG9ybDhYNERJUVdp?=
 =?utf-8?B?OWhSblFvZXFmSzYwUVFsVktEQVVha2pMREoxUU1vbGhsaUJoVGxGeGdoZVBp?=
 =?utf-8?B?ZXdpSzRrUXF1ZzcyeldIbnU4MkFCbzl2MzVSbTlhTGkrcVFZWHFGdGUwemIz?=
 =?utf-8?B?bVVRVEQ3cUdIczhtV1YrTFFSQWVSbGJCQ2ZYbUdnSjNPN2JDUmlLUzI2d0s4?=
 =?utf-8?B?ZU5GUnJXMGQrWEtHMGM3dElpakMzSE13eUxFaU1MK1FXdGJBRjZrZUhISlQw?=
 =?utf-8?B?TnQvSmpUZTJMNHhlb2JyQmM1bU5WeXdUNzVVZDVESXdIeXJXVGloK1NDdU9p?=
 =?utf-8?B?UDZrTmVKdjd0VkNmL2Erak1wRDFod3M4NitZNEttTk5kTU5TMXBUS2ZKUjVI?=
 =?utf-8?B?T0JzQ2F5S0EreCtRL3lnWTg0LzY5UDI3M1pxNGUwVlc4OVFsT0Y0SzZYcXVW?=
 =?utf-8?B?MEpsUTJ5STVYYXVpV3IrYWpaa0RMUkwwcGJqVnhJVVkvb0NMMzhjcHg2Q1BH?=
 =?utf-8?B?MTBEM2V0TkxkdjlhMEpvZWRBV2RNZFdDK25JcGZ4bmdsa1prVDF3VHRRd1dL?=
 =?utf-8?B?RzhwMS8zNlhvSWhUL2J5RmZ5ZkQzSTJFYmVnelpIU0xIRWV6TnNHaWdVQ1g1?=
 =?utf-8?B?TndTSzJGMUY5SHllRlgvZ3VNY24ya2JZUzFFTStLUUhoQnAwcjc1aEtudnNB?=
 =?utf-8?B?MEk4ckV3amF0TjVkSjhGOXZKVUh0ZFNaREtzcjZONmhiK1JHZUhMellWTTgz?=
 =?utf-8?B?Uk4yZU44ZmdFZEtCenhWb3VXdTZ5VkJ4QVRhWit3QmQxN1lUTVdVV3VpWGNX?=
 =?utf-8?B?UTI1YWtKbWt3bnpMMGk2OUpJY0N5Y1BqVEllTkRuanRXcEhKa0FScFI4M3VP?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E3BD1C223662E4F870090C241433F35@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d45145-5502-4f81-dea7-08dc3cb50b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 01:39:05.3398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SftdpUGShUCeNr8Tw1jgG/7ZaLYozuEPGuAkczmwaM/SZIMoisgPn9saNoaF89X+XR1SHts4CrBcym9e12505RVBS7Xb0J8BUevQu6i/xXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8123
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.369800-8.000000
X-TMASE-MatchedRID: 6otD/cJAac3oSitJVour/eYAh37ZsBDCA9UhA/EMrwPI0741P9lNrkUb
	nwDpGS5v1Fc61VCGvh0P3DFN6qmL8nYIQoHEix+qXP5rFAucBUHEoDEGChh7CQZbeEWcL03VHBs
	H6IIpfoJkpgwC5uOBF6woSk24kDBQyTBgz6hl0ddNI82n17+7U7LiLKO9VZOiLP7lAJOsT+xm+j
	6YVbX2YCcH6DaUItAMga0KtKweaStUdw1LqmKXvXQEQEU5OIefzHmrvxa8UmS0rcU5V/oSe8sQy
	lgoXsVExus2xPyI7E5LHhP0pFusqBiQc5OixN2zsgYw1+LBrk19LQinZ4QefKU8D0b0qFy9suf7
	RWbvUtyrusVRy4an8bxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.369800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CF7ABFC564BF152A7101AE1A47FE349C831FF57863B1882F84B21F3B69816BD12000:8

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBNb24sIDIwMjQtMDMt
MDQgYXQgMTE6MDUgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAwMS8wMy8yNCAxMjoxMSwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gQWRkIGNtZHFf
cGt0X21lbV9tb3ZlKCkgZnVuY3Rpb24gdG8gc3VwcG9ydCBDTURRIHVzZXIgbWFraW5nDQo+ID4g
YW4gaW5zdHJ1Y3Rpb24gZm9yIG1vdmluZyBhIHZhbHVlIGZyb20gYSBzb3VyY2UgYWRkcmVzcyB0
byBhDQo+ID4gZGVzdGluYXRpb24gYWRkcmVzcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
YXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gQ2hhbmdlLUlkOiBJ
MDEyOGRiNmEzNDEyMzAzZmM2ZGE2MWY4YTU3YTBjMDhlMGMwMDY3ZQ0KPiANCj4gRHJvcCBDaGFu
Z2UtaWQgcGxlYXNlDQo+IA0KT0ssIEknbGwgZHJvcCB0aGlzLg0KDQo+ID4gLS0tDQo+ID4gICBk
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDI2DQo+ID4gKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmggIHwgMTAgKysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRp
b25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1j
bWRxLWhlbHBlci5jDQo+ID4gYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
Yw0KPiA+IGluZGV4IGIwY2QwNzFjNDcxOS4uM2ExZTQ3YWQ4YTQxIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gKysrIGIvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBAQCAtMjk5LDYgKzI5OSwzMiBA
QCBpbnQgY21kcV9wa3Rfd3JpdGVfc19tYXNrX3ZhbHVlKHN0cnVjdA0KPiA+IGNtZHFfcGt0ICpw
a3QsIHU4IGhpZ2hfYWRkcl9yZWdfaWR4LA0KPiA+ICAgfQ0KPiA+ICAgRVhQT1JUX1NZTUJPTChj
bWRxX3BrdF93cml0ZV9zX21hc2tfdmFsdWUpOw0KPiA+ICAgDQo+ID4gK3MzMiBjbWRxX3BrdF9t
ZW1fbW92ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBzcmNfYWRkciwNCj4gPiBk
bWFfYWRkcl90IGRzdF9hZGRyKQ0KPiA+ICt7DQo+ID4gKwlzMzIgZXJyOw0KPiA+ICsJY29uc3Qg
dTE2IHRtcF9yZWdfaWR4ID0gQ01EUV9USFJfU1BSX0lEWDA7DQo+ID4gKwljb25zdCB1MTYgc3dh
cF9yZWdfaWR4ID0gQ01EUV9USFJfU1BSX0lEWDE7DQo+IA0KPiBzMzIgZXJyIGF0IHRoZSBlbmQg
cGxlYXNlDQoNCk9LLCBJJ2xsIG1vdmUgaXQgaGVyZSBhbmQgSSdsbCBjaGFuZ2UgJ3MzMicgdG8g
J2ludCcgdG8gYWxpZ24gd2l0aA0Kb3RoZXIgZnVuY3Rpb25zLg0KDQo+ID4gKw0KPiA+ICsJLyog
cmVhZCB0aGUgdmFsdWUgb2Ygc3JjX2FkZHIgaW50byBzd2FwX3JlZ19pZHggKi8NCj4gPiArCWVy
ciA9IGNtZHFfcGt0X2Fzc2lnbihwa3QsIHRtcF9yZWdfaWR4LA0KPiA+IENNRFFfQUREUl9ISUdI
KHNyY19hZGRyKSk7DQo+ID4gKwlpZiAoZXJyIDwgMCkNCj4gPiArCQlyZXR1cm4gZXJyOw0KPiA+
ICsJZXJyID0gY21kcV9wa3RfcmVhZF9zKHBrdCwgdG1wX3JlZ19pZHgsDQo+ID4gQ01EUV9BRERS
X0xPVyhzcmNfYWRkciksIHN3YXBfcmVnX2lkeCk7DQo+ID4gKwlpZiAoZXJyIDwgMCkNCj4gPiAr
CQlyZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArCS8qIHdyaXRlIHRoZSB2YWx1ZSBvZiBzd2FwX3Jl
Z19pZHggaW50byBkc3RfYWRkciAqLw0KPiA+ICsJZXJyID0gY21kcV9wa3RfYXNzaWduKHBrdCwg
dG1wX3JlZ19pZHgsDQo+ID4gQ01EUV9BRERSX0hJR0goZHN0X2FkZHIpKTsNCj4gPiArCWlmIChl
cnIgPCAwKQ0KPiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKwllcnIgPSBjbWRxX3BrdF93cml0ZV9z
KHBrdCwgdG1wX3JlZ19pZHgsDQo+ID4gQ01EUV9BRERSX0xPVyhkc3RfYWRkciksIHN3YXBfcmVn
X2lkeCk7DQo+ID4gKwlpZiAoZXJyIDwgMCkNCj4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ICsNCj4g
PiArCXJldHVybiBlcnI7DQo+IA0KPiBJbiB0aGUgZG9jdW1lbnRhdGlvbiwgeW91IHNheSAiMCBm
b3Igc3VjY2VzcyIsIHNvLi4uDQo+IA0KPiByZXR1cm4gMDsgaGVyZSA6LSkNCg0KT0ssIEknbGwg
Y2hhbmdlIGl0Lg0KDQo+IA0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0woY21kcV9wa3RfbWVt
X21vdmUpOw0KPiA+ICsNCj4gPiAgIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcikNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgY21kcV9p
bnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaA0KPiA+IGluZGV4IDFkYWU4MDE4NWY5Zi4uYjZkYmUyZDhmMTZhIDEwMDY0
NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gQEAgLTE4Miw2
ICsxODIsMTYgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNtZHFfcGt0DQo+
ID4gKnBrdCwgdTggaGlnaF9hZGRyX3JlZ19pZHgsDQo+ID4gICBpbnQgY21kcV9wa3Rfd3JpdGVf
c19tYXNrX3ZhbHVlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OA0KPiA+IGhpZ2hfYWRkcl9yZWdf
aWR4LA0KPiA+ICAgCQkJCXUxNiBhZGRyX2xvdywgdTMyIHZhbHVlLCB1MzIgbWFzayk7DQo+ID4g
ICANCj4gPiArLyoqDQo+ID4gKyAqIGNtZHFfcGt0X21lbV9tb3ZlKCkgLSBhcHBlbmQgbWVtb3J5
IG1vdmUgY29tbWFuZCB0byB0aGUgQ01EUQ0KPiA+IHBhY2tldA0KPiA+ICsgKiBAcGt0Ogl0aGUg
Q01EUSBwYWNrZXQNCj4gPiArICogQHNyY19hZGRyOglzb3VyY2UgYWRkcmVzcw0KPiA+ICsgKiBA
ZG1hX2FkZHJfdDogZGVzdGluYXRpb24gYWRkcmVzcw0KPiA+ICsgKg0KPiANCj4gICAqIEBkc3Rf
YWRkcjogZGVzdGluYXRpb24gYWRkcmVzcw0KPiAgICoNCkknbGwgZml4IHRoYXQgdHlwby4gVGhh
bmtzIQ0KDQo+ICAgKiBBcHBlbmRzIGEgQ01EUSBjb21tYW5kIHRvIGNvcHkgdGhlIHZhbHVlIGZv
dW5kIGluIGBzcmNfYWRkcmAgdG8NCj4gYGRzdF9hZGRyYA0KPiAgICoNCj4gICAqIFJldHVybiAu
Li4uDQo+IA0KYW5kIGFsc28gY2hhbmdlIHRoZSBkb2MgZm9ybWF0IGxpa2UgdGhpcy4NCg0KUmVn
YXJkcywNCkphc29uLUpILkxpbg0KDQo+ID4gKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxz
ZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KPiA+ICsgKi8NCj4gPiAraW50IGNtZHFfcGt0
X21lbV9tb3ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBkbWFfYWRkcl90IHNyY19hZGRyLA0KPiA+
IGRtYV9hZGRyX3QgZHN0X2FkZHIpOw0KPiA+ICsNCj4gPiAgIC8qKg0KPiA+ICAgICogY21kcV9w
a3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUQ0KPiA+
IHBhY2tldA0KPiA+ICAgICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+IA0KPiANCg==

