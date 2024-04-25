Return-Path: <linux-kernel+bounces-158088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E878B1B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F451B21133
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0105A7AB;
	Thu, 25 Apr 2024 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ipun6+Qk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Emds6A9V"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392605A116
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028061; cv=fail; b=tJwa8EJhUtx9q2/IQnPPd8Udb75Dh2PuzFNZ9PkUygPYoOacLGYLVYTxL6yawFFhcCsX3c9OM6lQAwFL0pfX+Y/1hftQwp3iX+G/oPv34juBv1hJguLzsJ4eAPvw/C3L2aUaItIHgw+kzcv1SNhTtGFcdBZKq5X9us2gdidBxGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028061; c=relaxed/simple;
	bh=s1SD/izp2GjCMXV27mIgnO46Lt95FZSjFWQIi+cP+Ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BCAners37/AaPEN2ruPyxIe5U1B3FZNFuHq5FWHpJ+ViH8rzDQqKsQEMxMWcEZVBWhzCGJ0xZ1hMTJdYjpVHXVFHE3HqfNS6UrPVJ3P3E5rRDuXE8wAR7rhXbtKy+yCIAdMtvzDRRW3rLs4nxC+3JZC+knQkYRd4wr1vPpaFyj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ipun6+Qk; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Emds6A9V; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9f357f5602d011efb8927bc1f75efef4-20240425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=s1SD/izp2GjCMXV27mIgnO46Lt95FZSjFWQIi+cP+Ug=;
	b=Ipun6+QktxiWkSoIzt8Tk2oq43m5AVAaPMaBEcZfiPnF9SSlbRN3uaQxIqH549ARd41xpnDdfvtqNLdGVFTIziWJUWT+P854N3mEtDUKcuSLqZcW034rPd6Vf6bmic+Lyzh7SJLmr9CqrIVwssXOOmFTMOxKy+5LmEc1t9SICx4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:4145d503-e834-49bd-bc89-d72397b829d7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:54341883-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9f357f5602d011efb8927bc1f75efef4-20240425
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1576118772; Thu, 25 Apr 2024 14:54:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 Apr 2024 14:54:09 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 Apr 2024 14:54:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtwYfHZIPcoLm+l11tsI5ulCj6bp7vzpQOG7CCtfNO+RNzAnKSa0vUO80wT59Ltk7e/5JhbW2xSSdNW3hdQk674efQB1odyVNw6PPFldf2mK9YNl8V0tBb3N4kX1pbdakCnb3UDAnwLaPooMG+RbaHVP4/AsAOzu90XlEXX2lkqCYrzNEEMRvIwICba4f5cQiiSWOtCrddaCHQvrMtMu7lNdUYcGn33lg86e8XjVo5dIrBYKoYFz54fUtXFTIJrbwy9mKO/63FuglVKPB4gAhJ2sXfjn+A5TtgbktnffmwEhfvIn8B5Rs7L+QvoWu5d02s9Ys/AI23KXDL8XIZah8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1SD/izp2GjCMXV27mIgnO46Lt95FZSjFWQIi+cP+Ug=;
 b=Nr1AcAjC9m9A4GRbUYFgGGhIKdo8Cwltn+7hXJxQ5BQ12fAvIhn6rbnmV6viOJzR98B6kAu+HIEcP9cw6N02UbuMQMbKbAJrnXvWOQP1Y7iuSCQGs9wSHN6Qaf7ts0z1Ga/MJAZ4ZgV8C4qsJPkJZBYN3PPCfPCmMLtVTmIEIZfkQlmuRIcK7U6TEpa5+ykeqgJdDbxt8y7Jvkc/Raw6MQVfP/yHS/t8kNBY3zg6X5fdrFyGMkGGp73rds85ZKrlsNbB6udad0rhTO9HIIgCDXVuBgrqwiXHN3R9Fzp4qnHb8XDgjnQ176iucSJoXwB+3ysajQOdn8Pn8SpL+eo2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1SD/izp2GjCMXV27mIgnO46Lt95FZSjFWQIi+cP+Ug=;
 b=Emds6A9V6jsJXb3ebWg0rWBSNZ5cdmr9X6/utoUIbFgmossMkWnMh00mglIwdtQvOHzohYGQz/kcc7aJMKSSy8rZM0mNlija0v/+nrUHiytMmNRMM4ks4NHZXXF2Gj8TPdGay3cJLvHpX99LUxmcy/+lqaQVKaaYmkCxyj78dBk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7928.apcprd03.prod.outlook.com (2603:1096:990:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.11; Thu, 25 Apr
 2024 06:54:07 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 06:54:06 +0000
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
Subject: Re: [PATCH v6 05/14] drm/mediatek: Set DRM mode configs accordingly
Thread-Topic: [PATCH v6 05/14] drm/mediatek: Set DRM mode configs accordingly
Thread-Index: AQHafBnI+aER5x3XV0qqMCDo3cOi8rF4woaA
Date: Thu, 25 Apr 2024 06:54:06 +0000
Message-ID: <422cad9aaff5d167f2fb6695882611e6e3afbfd1.camel@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
	 <20240322052829.9893-6-shawn.sung@mediatek.com>
In-Reply-To: <20240322052829.9893-6-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7928:EE_
x-ms-office365-filtering-correlation-id: acfc9b24-a13e-4c99-6371-08dc64f48051
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cHlRSHhSVFlCUDRjYjFXVDFtcVFsOElQalJEQS9uMVBaK3ZGcnd1L0JGeEJO?=
 =?utf-8?B?Q3dUWHlLZFVNa0dabC8xRGZsNG8xcDVPeHFTeUdtaG1Ta0ZXQmZyelI3V2JY?=
 =?utf-8?B?eEtwdjR3L1pKNmMwdk4ydXN5MlZnRjJxam9WaUMrV3V0cUpwZHFoOEdrcytW?=
 =?utf-8?B?OTVpVjJWWlhLUHNJcFhLWEg5N1VqcVRLUUkxZGtOUFl5RXhLUnVDMnJUaXFY?=
 =?utf-8?B?MmV2RHdxQ2x0YVBGSVZjcDVUQVdacDNkR3AvVngxZURTU01qRjRqanpsZEpE?=
 =?utf-8?B?aTlFdVRkdUtZSlI4bFR1NDQ1aE92VTltS2krZjhaakJGdUN4Yy9JZ0QyNG9G?=
 =?utf-8?B?b2JobEFaQWZRQk9abHlIQXByV21LOEg5c3NES3BTclJPc1NTRnBFeGRyN21x?=
 =?utf-8?B?ajhtVkp4TzhySjJiTnR5T3JOMEpaNGZIdlZuVTdQMitKYlA1aWR5RjVLbVBy?=
 =?utf-8?B?MExrb1ZLaDVhcy80QUN1djBFZTNoMkxTL3psVjUyMmJPWHZzTHE1dzRLTHhN?=
 =?utf-8?B?Z2V4L0t5amZtTEhTVGMyQzRTSXIrYTFWK29aeEpOZ3pqV21Ma1FlNk00TUZk?=
 =?utf-8?B?MUNybTU4Nk1VRmovZzJuVGVoUDdMbXNna3d5M2JiOFI1N3VyMFp5MklzWFg0?=
 =?utf-8?B?WWp2aGtMVG9EdTlJa29hajFFTC8xaFRGYjhRMk0rSkFPYzVIMkZFYzR5eDA3?=
 =?utf-8?B?RDhjc2VvWFBpNnJmeVV6dDhNdjdnd1NDenpIUjY2Kzhva1V0OVNScnZmVWVP?=
 =?utf-8?B?WjBla21qOWlxSHgrTlhiUmNiMDMxK3l1NUJpSDFpRUtuR2tHNFJJTVZVMWtj?=
 =?utf-8?B?OTREUVpJOFo5Q1o4OGs4SlB2blRzbnV0dGFidVErTE55WTJvOWJtUFJXV3U5?=
 =?utf-8?B?Y1RaSFIzSVJKeHEzbHJHdzlJUzY3K2VMK21FODYzaHQ0MklMMzNrU2Y0bGQw?=
 =?utf-8?B?OFFwaHNQK2tVbnVuWGEzSHBJVjJ3MVRzYlc0NXZQK1hpWGFTYnRpdDl4SUV4?=
 =?utf-8?B?Mm9Yako5U1pFWDNYMktoeU9kMnltQm9WUDhFM3ZUM2JxeWhlbHBLekUyRkpq?=
 =?utf-8?B?aEMzRlV2ZEZERllkcmJ2NTNtdjZvSVpEUnh4b1o0bnJMQ2dpTWs4aFdFdlR6?=
 =?utf-8?B?bDVjcjc2SjUvUDJNZVFCczFMdEx6bWNRV3FUdUY5YjlzbmxDbFRlcE5XVmRk?=
 =?utf-8?B?eHF1S0JMYWNBMVVSN3R2d3FucGxCUnpQL3FBOUhzM2I4SHE5MzJPeWFBby9M?=
 =?utf-8?B?QkRxYnlLUmJoK1FUaHRWcEJ5aVhoOEdsbUw2Z3FEcE10alJqTTk0VDI3TDR6?=
 =?utf-8?B?SnA3V0szZFh4VzRWalZGanRJUnNMTVMyVUp3RVpXUVk4cjlBaWV5OEJ5ZXUx?=
 =?utf-8?B?MVNBd1VZOHNvWjRhcGp0OSszbjladU1CUkxMT3hGZUxCVVZ3MjhCQUtDTHBZ?=
 =?utf-8?B?UFppY0RrZWh2dGg2UVBmQ011ZjRqcXNlTTQ1SjA5TCszbkhoQlVLam9HTVh3?=
 =?utf-8?B?VE5TaUhpUXZoQ2h6ZE5EeTlYd0tDYkFlTHRRd0tSdzZVeG1FdExFWmRrSzRs?=
 =?utf-8?B?UnlTNXVLa2xjN29JdDBNMVczamRHT1JpWnExYzBvZmtVSHg2V3g4SEUyNTdT?=
 =?utf-8?B?RUNIQmpIVFV2OGUzUHIxcEVKalY5SHo1ZkdCRHBzMGJFL2RqRUJseHd2SmJv?=
 =?utf-8?B?M3RpeGZCVUFJMHdLcy9RaWFGOWJpSXc1dW5EMWZPTnpGMlFCb2FLVGhkNFla?=
 =?utf-8?B?dVFKT29RdXlNVGFKZ2ZPZnZDZ2dhRXBuUE5kMU1LY2dGSXBxQjVmRXMyN1BI?=
 =?utf-8?B?SzU3ZHlLVTRrbHFrWFNzQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0hEWC9SWjJWcTdHTDhFS2xQRi9lQnlyL05HcHBwY0ZySkZqUWNYek5lWjdk?=
 =?utf-8?B?cUZ0SlpyYzFhVmF0K3pqWWFPdG5BcWFqZ3VqbmdFbmVkT29xNmpzNVllOEky?=
 =?utf-8?B?aFhtWWVoUkJmR1hVWndTZHZRbFdvd3ZtUmdrcVp0dUJDMko5UDhDc2htMm1w?=
 =?utf-8?B?Q3JUTjNzU1VlOHJEaGhpWXVYVUE1S0NlUzdSblJYUkhSam1LZWxibDFWSi9m?=
 =?utf-8?B?TXpLYjNRS25SNjBFQWNoazNtOUhCakhkMkJGYVBOVDl1dThzc3B5VHJwQkgx?=
 =?utf-8?B?RnZMWWtSL3NTcmhVMHdoZElEVm9IYnNRdkVUR3BnK2o4TVZXRVZhaTZrZ0lv?=
 =?utf-8?B?ZlJWYUpZNU1EMnlBT3FnUmppbHFCN1diSzk1T280NTdIazd0YnpCZUxDeitV?=
 =?utf-8?B?SVBSb2ZEZFNJdTdZR2IvVUN5VDZMZVA1eFpudVN2NEl3endCR1ZBRDV2TVNV?=
 =?utf-8?B?Z085aWtpM0NXYTFySU5MU0Jld0FUR2o4NEVnM0pmUkpMTXpIbHNGTk1rR1ZW?=
 =?utf-8?B?Sm5hZ28rZ3Mxc1VsRmNSa0FkRmc4eTNvZzdpWFMxRlczQWtWL1hLWWV0aHlO?=
 =?utf-8?B?ZFFKN2t0ODY1NmtvY2ZZdlAyaWpGWHcvdlAwQzY4aFJ4emptU0piMmR3UDV3?=
 =?utf-8?B?ME9rUWJoMnNTdWVRbi83cHVJM1Z5WDJiRnRxYkV2NzYva1JzeVdBZGFuNXRK?=
 =?utf-8?B?SGZtaGRGa3dCRTlkdEIvMm1TMGVuRTdJQzNEVFZHeUw4V2J0bW1nMTI0K1E0?=
 =?utf-8?B?bjNEanNTTitJYkppSkR1VXkrMzA2Q0NGbGMxNjZsaXRDV09kbVV6YkswOXhB?=
 =?utf-8?B?R0MvODgxODM1cWJ3VzRhbFpJU0tNa3Z5MmV6RnRuQmpLRjVqRk9jTVNhZGYw?=
 =?utf-8?B?SUQwM3hDNGhFUitRaURaNnlrTXhrN3RSVnBWV3NOTFl2eUM2NWpPaVRqYzU4?=
 =?utf-8?B?TUU2cHdDSGZ5bVJqMWx3RjZ1bGZ3VnVTMDRpWmZQZjFlU2o5NG5MeUVUOUtk?=
 =?utf-8?B?UmozNXZSY09KZ2lZWFFtTGhUMmNJU29PK2NaaUlQSVNFdERsYStTMXBPUjdl?=
 =?utf-8?B?dWlqNG9BM2xQaEd1L2hpS0lGcWUyQ2RrUWVPUXM3N251QmZWdk9rczJTQTZX?=
 =?utf-8?B?K0h5WkFPNmh2bXFrR2Y3UFlDRDVoSWh3UkhQelhLVUx1WlQyZlBsbmcyQlNy?=
 =?utf-8?B?ZTBXSFdnSHI1UVpkN2lLcmJCemFTR3FhZGxLRW5UVHhTbGlFdUNOT3dhTTF6?=
 =?utf-8?B?R2F2bkNrNzF1R3ZJa3JEMzhNODVSaUVCQVhXaHBBNzllOVJ6MWgyUmxPZ1cz?=
 =?utf-8?B?eHZFODVVZTUya3R5QTR6elJQSHVnYk5kN2lYZWNkM1NwZVJHMUtCSktLRERh?=
 =?utf-8?B?MVVycXFPR0xzcjNUaCswYURGNkRxY3hGR21HVnVRZUFpTXRMdnRRRGZpbVlH?=
 =?utf-8?B?S0xpYnFhbVZkeDljZEUyWmJjQVoxWVdOamxxb1RzSEFHajlHMGpYY2ZpMlNq?=
 =?utf-8?B?Tm11c1d3SGtaRWQwcHR4QldKcFYzeWpqNmpuZVFVVDU5akFFWStLSzloRWVI?=
 =?utf-8?B?d1g2ZldEcDl2ZWg4Z1E1aHQrN25SNWJ3emVUTGVjSUF1cVRJL1VFMGQwYTFL?=
 =?utf-8?B?cnlPMjdOSnQyL0ZoU0oxd0RCRmw4NEVlMFArdUo5QkFUY2EydDhQZkgxU2F4?=
 =?utf-8?B?YkNYWm8xUVAwRWozWXptRExwSUZXSHNsaU5pOUU0b09hMEJQU084VG16M1Fx?=
 =?utf-8?B?QTdOSk42OXRoc3JzeXJ4cFZTL0xFdzVQTjBqQXlLb2pXOXBYVmMxNFN2UUN1?=
 =?utf-8?B?dnV4ZFM0QUxyT2w4b2dHTm44QVJrcHgyTFVSQzBtbjdrbHhwOGdmWnF0KzdS?=
 =?utf-8?B?T0dpTWVEYkh0YmhiaXpLSStaK2RLT2xaYnErbW1KMnZaZVcvUDBKaW9KUGpH?=
 =?utf-8?B?NllSWGlSbDlPQW9LQlZpL2pvTzBRbWlBVTFmTnlhWktYTi9tbzhGazdiNWE0?=
 =?utf-8?B?T1BMdFBMZmkwMHlKNVVTTU1UcXlKREdFOGNzQ0xtbHRURWMwZm9UMVFXMGpT?=
 =?utf-8?B?azF0TDlSUUtkZlU3OHRnRnpaTURXaFBuMTZNVndBQlpTdEZyZm9xVTk2SUY1?=
 =?utf-8?Q?3kdhnsKln9M2SrYemCZrYU8EN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D63896B7080C3B4E97494CCE4E016879@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfc9b24-a13e-4c99-6371-08dc64f48051
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 06:54:06.6839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sz4xCawj/Wpu1Gj6PL301ErbO9yxIjch2ADVqX2FbJz2x78mvo3ei0aO9a60oUJim5qYZWp5KJemnC5JhpJ8pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7928
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.581600-8.000000
X-TMASE-MatchedRID: u7Yf2n7Ca/0/XHdICuW5rya1MaKuob8PC/ExpXrHizy7qpOHKudqc6Ge
	nlo/ebgn19iuiJe0Zld7fWQyyQ7Sr66UR+fsf9oDwVaayvK71l+46mo/tvaT3JEfv6UzUvbdoKq
	dagw8NC4FnYYGFnsf2ETPGwUzV65mb3gilrWi3Gjil2r2x2Pwtbi8G4TZfQeVYmQk5BUIinBaR/
	7gXfJSjrpc9PLeQ6rI0WNpcueVtr4tlu2PjaXfUXV7tdtvoibaGEfoClqBl87fc2Xd6VJ+yhM9e
	bPbqKjLI0VEPr+J+I+KGUoOUuWu8gzyMxeMEX6w0gVVXNgaM0qcIZLVZAQa0J27Ec/Gh+82q7rF
	UcuGp/EgBwKKRHe+r8+jvTbGHxyt8OX3m8gBttpKwHsSvr/zveIBgKwCgIHfkIcxjZnlaoc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.581600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5413198BEC2F33429184CE21CE369FDB82E86CFF1C345AB5F56DE7A9DC3D04032000:8

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBGcmksIDIwMjQtMDMtMjIgYXQgMTM6MjggKzA4MDAsIFNo
YXduIFN1bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVk
aWF0ZWsuY29tPg0KPiANCj4gU2V0IERSTSBtb2RlIGNvbmZpZ3MgbGltaXRhdGlvbiBhY2NvcmRp
bmcgdG8gdGhlIGhhcmR3YXJlDQo+IGNhcGFiaWxpdGllcw0KPiBhbmQgcGFzcyB0aGUgSUdUIGNo
ZWNrcyBhcyBiZWxvdzoNCj4gDQo+IC0gVGhlIHRlc3QgImdyYXBoaWNzLklndEttcy5rbXNfcGxh
bmUiIHJlcXVpcmVzIGEgZnJhbWUgYnVmZmVyIHdpdGgNCj4gICB3aWR0aCBvZiA0NTEyIHBpeGVs
cyAoPiA0MDk2KS4NCj4gLSBUaGUgdGVzdCAiZ3JhcGhpY3MuSWd0S21zLmttc19jdXJzb3JfY3Jj
IiBjaGVja3MgaWYgdGhlIGN1cnNvciBzaXplDQo+IGlzDQo+ICAgZGVmaW5lZCwgYW5kIHJ1biB0
aGUgdGVzdCB3aXRoIGN1cnNvciBzaXplIGZyb20gMXgxIHRvIDUxMng1MTIuDQo+IA0KPiBQbGVh
c2Ugbm90aWNlIHRoYXQgdGhlIHRlc3QgY29uZGl0aW9ucyBtYXkgY2hhbmdlIGFzIElHVCBpcyB1
cGRhdGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3Vu
Z0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZHJ2LmMgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kcnYuaCB8ICAzICsrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYu
Yw0KPiBpbmRleCA2MjEwMTViNjQ2NzRkLi44ZTA0ZTk1NzZmN2YyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBAQCAtMjk2LDYgKzI5Niw5IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbXRrX21tc3lzX2RyaXZlcl9kYXRhDQo+IG10ODE4OF92ZG9zeXMwX2Ry
aXZlcl9kYXRhID0gew0KPiAgCS5jb25uX3JvdXRlcyA9IG10ODE4OF9tdGtfZGRwX21haW5fcm91
dGVzLA0KPiAgCS5udW1fY29ubl9yb3V0ZXMgPSBBUlJBWV9TSVpFKG10ODE4OF9tdGtfZGRwX21h
aW5fcm91dGVzKSwNCj4gIAkubW1zeXNfZGV2X251bSA9IDIsDQo+ICsJLm1heF93aWR0aCA9IDgx
OTEsDQo+ICsJLm1pbl93aWR0aCA9IDEsDQo+ICsJLm1pbl9oZWlnaHQgPSAxLA0KPiAgfTsNCj4g
IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfbW1zeXNfZHJpdmVyX2RhdGEgbXQ4MTkyX21t
c3lzX2RyaXZlcl9kYXRhID0NCj4gew0KPiBAQCAtMzEwLDYgKzMxMyw5IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX21tc3lzX2RyaXZlcl9kYXRhDQo+IG10ODE5NV92ZG9zeXMwX2RyaXZlcl9k
YXRhID0gew0KPiAgCS5tYWluX3BhdGggPSBtdDgxOTVfbXRrX2RkcF9tYWluLA0KPiAgCS5tYWlu
X2xlbiA9IEFSUkFZX1NJWkUobXQ4MTk1X210a19kZHBfbWFpbiksDQo+ICAJLm1tc3lzX2Rldl9u
dW0gPSAyLA0KPiArCS5tYXhfd2lkdGggPSA4MTkxLA0KPiArCS5taW5fd2lkdGggPSAxLA0KPiAr
CS5taW5faGVpZ2h0ID0gMSwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRr
X21tc3lzX2RyaXZlcl9kYXRhIG10ODE5NV92ZG9zeXMxX2RyaXZlcl9kYXRhDQo+ID0gew0KPiBA
QCAtMzE3LDYgKzMyMyw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX21tc3lzX2RyaXZlcl9k
YXRhDQo+IG10ODE5NV92ZG9zeXMxX2RyaXZlcl9kYXRhID0gew0KPiAgCS5leHRfbGVuID0gQVJS
QVlfU0laRShtdDgxOTVfbXRrX2RkcF9leHQpLA0KPiAgCS5tbXN5c19pZCA9IDEsDQo+ICAJLm1t
c3lzX2Rldl9udW0gPSAyLA0KPiArCS5tYXhfd2lkdGggPSA4MTkxLA0KPiArCS5taW5fd2lkdGgg
PSAyLCAvKiAyLXBpeGVsIGFsaWduIHdoZW4gZXRoZHIgaXMgYnlwYXNzZWQgKi8NCj4gKwkubWlu
X2hlaWdodCA9IDEsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCBtdGtfZHJtX29mX2lkc1tdID0gew0KPiBAQCAtNDk1LDYgKzUwNCwxNSBAQCBzdGF0aWMg
aW50IG10a19kcm1fa21zX2luaXQoc3RydWN0IGRybV9kZXZpY2UNCj4gKmRybSkNCj4gIAkJZm9y
IChqID0gMDsgaiA8IHByaXZhdGUtPmRhdGEtPm1tc3lzX2Rldl9udW07IGorKykgew0KPiAgCQkJ
cHJpdl9uID0gcHJpdmF0ZS0+YWxsX2RybV9wcml2YXRlW2pdOw0KPiAgDQo+ICsJCQlpZiAocHJp
dl9uLT5kYXRhLT5tYXhfd2lkdGgpDQo+ICsJCQkJZHJtLT5tb2RlX2NvbmZpZy5tYXhfd2lkdGgg
ID0gcHJpdl9uLQ0KPiA+ZGF0YS0+bWF4X3dpZHRoOw0KDQpSZW1vdmUgb25lIGV4dHJhIHNwYWNl
IGJlZm9yZSAnPScuDQoNCj4gKw0KPiArCQkJaWYgKHByaXZfbi0+ZGF0YS0+bWluX3dpZHRoKQ0K
PiArCQkJCWRybS0+bW9kZV9jb25maWcubWluX3dpZHRoID0gcHJpdl9uLQ0KPiA+ZGF0YS0+bWlu
X3dpZHRoOw0KPiArDQo+ICsJCQlpZiAocHJpdl9uLT5kYXRhLT5taW5faGVpZ2h0KQ0KPiArCQkJ
CWRybS0+bW9kZV9jb25maWcubWluX2hlaWdodCA9IHByaXZfbi0NCj4gPmRhdGEtPm1pbl9oZWln
aHQ7DQo+ICsNCj4gIAkJCWlmIChpID09IENSVENfTUFJTiAmJiBwcml2X24tPmRhdGEtPm1haW5f
bGVuKSB7DQo+ICAJCQkJcmV0ID0gbXRrX2NydGNfY3JlYXRlKGRybSwgcHJpdl9uLQ0KPiA+ZGF0
YS0+bWFpbl9wYXRoLA0KPiAgCQkJCQkJICAgICAgcHJpdl9uLT5kYXRhLQ0KPiA+bWFpbl9sZW4s
IGosDQo+IEBAIC01MjIsNiArNTQwLDEwIEBAIHN0YXRpYyBpbnQgbXRrX2RybV9rbXNfaW5pdChz
dHJ1Y3QgZHJtX2RldmljZQ0KPiAqZHJtKQ0KPiAgCQl9DQo+ICAJfQ0KPiAgDQo+ICsJLyogSUdU
IHdpbGwgY2hlY2sgaWYgdGhlIGN1cnNvciBzaXplIGlzIGNvbmZpZ3VyZWQgKi8NCj4gKwlkcm0t
Pm1vZGVfY29uZmlnLmN1cnNvcl93aWR0aCA9IGRybS0+bW9kZV9jb25maWcubWF4X3dpZHRoOw0K
PiArCWRybS0+bW9kZV9jb25maWcuY3Vyc29yX2hlaWdodCA9IGRybS0+bW9kZV9jb25maWcubWF4
X2hlaWdodDsNCj4gKw0KPiAgCS8qIFVzZSBPVkwgZGV2aWNlIGZvciBhbGwgRE1BIG1lbW9yeSBh
bGxvY2F0aW9ucyAqLw0KPiAgCWNydGMgPSBkcm1fY3J0Y19mcm9tX2luZGV4KGRybSwgMCk7DQo+
ICAJaWYgKGNydGMpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9kcnYuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oDQo+
IGluZGV4IDc4ZDY5OGVkZTFiZjguLjg5MTdhMTRkN2MwZjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oDQo+IEBAIC00Niw2ICs0Niw5IEBAIHN0cnVjdCBtdGtf
bW1zeXNfZHJpdmVyX2RhdGEgew0KPiAgCWJvb2wgc2hhZG93X3JlZ2lzdGVyOw0KPiAgCXVuc2ln
bmVkIGludCBtbXN5c19pZDsNCj4gIAl1bnNpZ25lZCBpbnQgbW1zeXNfZGV2X251bTsNCj4gKw0K
PiArCWludCBtYXhfd2lkdGg7DQo+ICsJaW50IG1pbl93aWR0aCwgbWluX2hlaWdodDsNCg0KSSB3
b3VsZCBsaWtlIHRvIGJlIGRpZmZlcmVudCBsaW5lOg0KDQppbnQgbWluX3dpZHRoOw0KaW50IG1p
bl9oZWlnaHQ7DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICB9Ow0KPiAgDQo+ICBzdHJ1Y3QgbXRrX2Ry
bV9wcml2YXRlIHsNCg==

