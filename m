Return-Path: <linux-kernel+bounces-31750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B16833364
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0651C212C0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 09:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA41D266;
	Sat, 20 Jan 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nHur9tx8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oiufzMkc"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE28333D3;
	Sat, 20 Jan 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705744125; cv=fail; b=HfopHE+H6ogVRNe9uDaX+s4mHnEX4u/2X2OMLJYaOPYuQ3acg9El5KgrtRwfKJhrQCiaGRwDVg91sUZa69OMzkT/K4y2LeaxGvTNGg7cHAx8uNj7ukeygJSbGDzreLCp+m+X5a6nQ02DvYdCKsKygDesVr63LjM7t4lhcyu9fGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705744125; c=relaxed/simple;
	bh=VQAhKouoh7wc8nliA+5a6M/5mfpasYhdz/lKxJL0ANw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V7ght4Ail6r/PpectBdOPMZNgh/mlZUo4rGQjowlX06MCuDR92f3RthX/iBp4yVrob/8s6ysQCh+XQtizB1uL+2IcwzF6yKmsyxU8Cnefp9a6rceriYz/EyZCSXkd3RY5xZUAOniBgjtzKuiNhFIX3WqGSNSIL09NJQ+md0AAKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nHur9tx8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=oiufzMkc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 13a42098b77911eea2298b7352fd921d-20240120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VQAhKouoh7wc8nliA+5a6M/5mfpasYhdz/lKxJL0ANw=;
	b=nHur9tx8L54DNybpit8Hq4lXjf5TjXcTP47dOpJEKYJmUGDjSN2gBrRWaLnjMuiXhupDbmXwuL6y1KFMDYAWObukX7vk4ZTAjRQ259ZKR6F0htnTovVkFHvAgkcCGnqhtd18jsYp1HObqVX0KDjQUiOQG2WHQ3GsvDH5wX4UzSQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:6e753abd-29fd-4080-adb7-2af428ef8ebb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:4eaa0e83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 13a42098b77911eea2298b7352fd921d-20240120
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1445738539; Sat, 20 Jan 2024 17:48:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 20 Jan 2024 17:48:33 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 20 Jan 2024 17:48:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiQeBDDhX220HCe0G9zOBe6S6AWwe7M6LlNM+ugKMPq9aEWCmh2kDGzGSkVWbiXqRnmEMkW4uvMtL99jmQjWNHbiaurWdedomQupRk46uR8np3qj3fiToVGrXBagkvLjjcLhAx0Siq7ESGwG7lkqKd23RqCuve4csxGhj46MJ2GRMELmUxXK1Va+xRg4tvTzk1PYRwwW5O/DW3cRxkmalXkSYzADaJGRLAcFDKMIpMuPY/Yt5wyY4SJd1LfvZlhY3gIkTm1phTDLbeJnR9+34F7QjfPpbbWc6VTsD3z0RHcAiXuXkrGSJjSZ2SarurN6PBHDnV0NgCcAyFYHsButSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQAhKouoh7wc8nliA+5a6M/5mfpasYhdz/lKxJL0ANw=;
 b=J56Ao5m2rVQCGsz6FXup5oZbbFqSZ6Ktj2rmMkLgxwS/P3b5UJjpiT2jXgPfPpAz0dA8UngL6xfOgLFj8B5xe5surwtSUbCiAI8dsS6n70qjwawS/nd5gS6uNV1blCvyQWtrKikoQsGELBnzRDGVy9/5WT+TIaz/SgiWNAMeOqXXXi51BDn37Id2eg40eIpGgnoLL57LqlzyNgA6no6rjbztDgo6LdbflWsUAzebFv3bNvh+Px1ik33SinFRH0biqOYVeBtM1JJzUDeSYUhQmFgWWWawp9zfdiE8CcIto3+0nqieZTbW4oXy/bwFs1GRv4QSBdKA8tPOkaOjLwyBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQAhKouoh7wc8nliA+5a6M/5mfpasYhdz/lKxJL0ANw=;
 b=oiufzMkcM7b4GyPgGWKAppLjeoE6SHMbDnuyygL2Ugs9ZS8AbBqM4WH3H6LBQZ+4LZBfZcaGXoiWyTR9NPX3BZrlfPNiK2o9awBAf4KQHDl5HkkX4kSLhP/YibGgF/a5O0eD3hOZvig617Ny2B2KG0EsCJIYeB0MNJ9TJ1KEDxA=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI6PR03MB9010.apcprd03.prod.outlook.com (2603:1096:4:21c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Sat, 20 Jan
 2024 09:48:29 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%5]) with mapi id 15.20.7202.024; Sat, 20 Jan 2024
 09:48:28 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: mailbox: Add mediatek,gce-props.yaml
Thread-Topic: [PATCH v3 1/3] dt-bindings: mailbox: Add mediatek,gce-props.yaml
Thread-Index: AQHaSqF1IA9qW0PoQkym//6hgpJgy7Dg9jIAgAGALYA=
Date: Sat, 20 Jan 2024 09:48:28 +0000
Message-ID: <7d1226dbca72070dc4b5c5066e3f0f1e9de2e6bb.camel@mediatek.com>
References: <20240119063224.29671-1-jason-jh.lin@mediatek.com>
	 <20240119063224.29671-2-jason-jh.lin@mediatek.com>
	 <30dca707-2b48-4309-8567-8c1297a75db5@collabora.com>
In-Reply-To: <30dca707-2b48-4309-8567-8c1297a75db5@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI6PR03MB9010:EE_
x-ms-office365-filtering-correlation-id: d54e7702-f099-45cd-ccff-08dc199cf49b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WqXqbqMBPDQsxID3Ible8XkZvMfkl3eE4UhiMV0aYqjbNue29qs6gnk+esQTQNoqWd+78+f+lTAAmevBuzBwGAsSTr7fuY1hrFqZh6T4ZXne+qnxIuHT0UrqdMLLJSEK9p52Y3JFwLAcbDTtR9T5RbVPpcd4mmIBc8qcjEJtksbEEWUdO+H/076gMRjd5r7lf+qX16+6CmzS7x4hcsaiDCxjMMKZ7uJsxnoYRSCh3e3ZmQ6+66NU1LhL0GWo0Wsv9G6xhkJ1Pg5D53R1Joxh9FRwwmH/RiCrX2vZ98yOsrOVZ86tiLXdVfI4h4zj2mUkq3edZYw96/m2RnjXBCeqwaX+XTecO9eyNYcDQYYXBUpuEYG0qZKraJE9kAK1Wt538Mym9oj24m8hm6znqLf91aCjMO9L24lR2PAALSsNjcxA3nMFHpqhd2oaB3y5oU6m3eIvh4pGglDvzIkgWO3zNA/XPMBuBRc/4Q+LpHC57wtzBs/51PYGBFLTY70kctza0NTEsyYejq86hz840CwDT7zbjMpZ5lhEXDrVqyy7d47DUuK2X1IqBLHRCIkpLuP7mz+PJFFJ/rqEtAdrxV7W9zGSjzV8diiWR4WfKNF9kvsAt0Cw89zQ8S3moD+VBYGHavwuVGKrBMZNAwq0fM61kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(8936002)(478600001)(6506007)(71200400001)(966005)(66446008)(91956017)(64756008)(66946007)(66556008)(66476007)(76116006)(110136005)(54906003)(6486002)(316002)(2616005)(26005)(6512007)(83380400001)(41300700001)(2906002)(4326008)(5660300002)(7416002)(15650500001)(86362001)(36756003)(85182001)(38070700009)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1ZJOVRHdjJSU3JtWUt1VHRFU1hLRjBsdmZBd1ZFbXVmMzNweWRocStwQzN6?=
 =?utf-8?B?UDBLbVhSeTQ0dnE3QnVFSVVBOTFrcXA5V1FraGpoQ1pYaUlxRmhOQ1FoeHFs?=
 =?utf-8?B?Um5wVHVxZGltT25tT1M0ek16ZlAwY241V3JHemdDVVhBNm12SzZZbjhTMUJP?=
 =?utf-8?B?OTRRQURzYWJzc0R2cUxWczIxb0hjZEFwVXcxcFVNTlZBVzRsdy9IbEF3NCtY?=
 =?utf-8?B?bXN3aVc1SlpBeGZwTGNaSGZwdS9LdDFXZVdrZFFVbzVxUm0rNE42WFA1SStB?=
 =?utf-8?B?bU83Z2pyTjNwWjgwNHVoc0VKd292ajVaUGVKazBQdk9FYmsxRUludFdPV1JR?=
 =?utf-8?B?bUIxNDJyNFJrVTcrMWZINEJsUFNCZUNWRS9RSi9rLzNPT09jSWEyd1J3Tngw?=
 =?utf-8?B?NWE5bUptUWlQTjVKbVZ0N2dWblVIMlkxVGcweFdTUnlaUlUzeE94S1FKOFlj?=
 =?utf-8?B?Z2dpVEUvS1RycDJTYTRmeHNGRGIxNm1uSGozeTlRdnV4T2hPbzM2TEoxMEZ2?=
 =?utf-8?B?eGovYXJCYVRVekhjM2Q3UkhMMGxkcCtOTUtaWXlJS1lnd3kvY1QyREp2SVh6?=
 =?utf-8?B?S3FnUGxmb3Q0R0VHLzBJbU1CeXdFbGd5cDUxNVVxZ1FoazFjK0p1SkNDak1C?=
 =?utf-8?B?dTlLWW5YdkVUcGxpaHcyVFRaWW9BVlBkZnE3d0V6U0ZJcE1WbFlIZGV4Rmp6?=
 =?utf-8?B?a3gvQXJBczJlUytKT005bGNsb3NnY0ZpUXR5bVZhMFlQZjExUlBHcU0xTEhK?=
 =?utf-8?B?cnhWYk92VHcwZjFzMkM1cm5valg4ZGoyaVVwTlZlenJwN3ZVeG9ZRlBXYzhU?=
 =?utf-8?B?NnZYVlBLcFN3b3ROQ1lhNks1ejJhdG1lTWF5Tk1vMnlkdGxNTk9Rc041c3lV?=
 =?utf-8?B?UnlObnJON2MrM1E2b2FwL1RCdnBtTm92dklxTlhTRUtNRXQrS3liVldBalcv?=
 =?utf-8?B?QjE3QmJFeHdITUJCN1hWTE8vK1drL01oUTZSNElyRjR3R2xORVorMCt4ckZ5?=
 =?utf-8?B?UFVwTS9kYXdLdzJFVTd4WjYxb0R3Y3pVdlFtUlJUZ1IzUkpwS0w0dmVBMHZM?=
 =?utf-8?B?bTRuNDYyY1NYb20xUnJWMkRaSllpZGpZaThGUW5tSktKRUFVUTRxd3pvN2ht?=
 =?utf-8?B?Z3ZBNWNRVEtJRGlvaE50ZnVkSnNGcGkwWWw0elJkR09WdS9sbERGdDhYWlpj?=
 =?utf-8?B?d0dKaFAxK1BhcGRaVGVJMW9CMjF3L3ZMbFc1WjNubzFVY0NaeE1jS1Q5bmhF?=
 =?utf-8?B?UHY4cTJIZGw3bHJNUGFMczhQb1hRUmJGMk5iT2s5YysveGhEelFmMExsWkpN?=
 =?utf-8?B?Q2I3TjdqRlVmYkZtdFdCbFl6YTFBdG9jcWt3VDVIb2FncWRzVDM5WHlEMjMz?=
 =?utf-8?B?bnUxRm5CTEw0VCttRGRyMTc1amxkUkU0d1B1cnRXVFYzd2tobk1EWXdRdU1X?=
 =?utf-8?B?WUJZZXdvTXN6NEpVRU5wSkM1NGNWRTVTT3pmSFNwbDJ0VTZqZ2doUkhVbm9i?=
 =?utf-8?B?K1h2WVpaODZ5bTVsQTVUYTgyR3dqb0Ixb0UvZFcxRTNNaldkVVNKRjdqTlo4?=
 =?utf-8?B?ekV0dnBzTGVYTmUrbkJqQm9OU3k0Y1grVzk5ZUtsNHl3VHVvdmFsaFlUMmRU?=
 =?utf-8?B?SEZLRXlSaGdCMzQrbWZ0alhYVjVPZ1F0T1pENUM1SnM4LzBJaUxqWU5ybUVX?=
 =?utf-8?B?aFZmVDdrNloxbnl2Zy9hRlh5VEhPcEpqc05ESTJFdlJlaFRac0kwU25aU1BR?=
 =?utf-8?B?WEZLbzBDN1A5Tm9sbU5ja1ZmR1FDeWhOTGc5YnkxVlhnYmMyTGdHY1BjYkJ4?=
 =?utf-8?B?VGg2QTE4Q05peUhVaVQ1N3dVbHlDTHJBQWRwOXBkTkpYcXJJQ21TNXhPQmRq?=
 =?utf-8?B?WWQ3Y1VTTDJyL1lid3FTQVUrM3BUSGtKLzM0ZCtlbG9MWmhqMkQzTVlybWpu?=
 =?utf-8?B?cGVXTnc1WGFEdGdYR29wMFdIU1AzQ3VkYWlnMkh4aTdqVzRhZnMzcDNFWmNO?=
 =?utf-8?B?MlE0ZytCZFJFcGhYMkluNGwwNm5yL00zT3QyeWxSQmE1cFB0RENzK1Nha3p5?=
 =?utf-8?B?aWRoQWtwbEl6RFZEZ3RPR29MRlg3WHRUUVdNbmxGSnB1L3B6Y3BsMWM3SnpW?=
 =?utf-8?B?ZUMwNWlMRTZlTjFPVjlwUkoycnFGczAzeDA4T29GM3Q1MGtiOStwUDVYYlBr?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4297E26978F85C42AB4047498F63F38D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54e7702-f099-45cd-ccff-08dc199cf49b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2024 09:48:28.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNQgNAbqlCLA2+e28HPVxdMU8e6zNVvtms7yUGA2fN4UGQsQ0mX55ccsrzCmhj3KDXowtoRpB9VKd3URJm8YNCGomcs7I/NQ0nDkxENLaI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB9010
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--32.791000-8.000000
X-TMASE-MatchedRID: H0/uSqZo4D6nykMun0J1wmjZ8q/Oc1nAYefZ7F9kLgsNcckEPxfz2OLB
	DcjMHcx7UmsNbSHn8eBWz2eiIuWGmt8PJCed6tIs/IBH0OAL+EdMjQ19j30wyd9RlPzeVuQQR3R
	HPHTssNX3pNg3V87yDrL0CwDGT5MlADAYgCjdKFudVNZaI2n6/99WrDP4LKdpdZevWwVvpQy5fu
	+XEabSpvIs19Gb68mzaZO4Eiz5bsMEW+0WFTTr4Z7tR0mnRAg1QPCPzycuBFNGL0g1nVmkYe8fa
	d4FArWr/ZoI2dvJSJnYM+9YZY/gRsFeWQ9rEC3VFYJUGv4DL3wUkWvaqUqLH5gWnaLDiGgh7vfj
	HqfMw2K8+TVtXJWVfU2NKIsmvPZ6AjPI/s9IvI9CnGIuUMP0Ve8lj2kHOCDUbaZMa0fgRtbGxDt
	fjJi11ebKQJwTmvpZJdDx9BhljWQiFiZZuOl7cE1Wvi92YKnOkT7cMJfe6JtXopZjyO6CZSzsQu
	rLskPGyhHpVlrxD3NJnroza1PHuFTi3dX5AzhKY6Gjtu6/t32jiNbvNIOD2RjQD3m2MCf7GUcJa
	cfXB7mQQRInB0Mnn2nhUL4Tgbhg5UcZtwNsCrrSBVVc2BozSlkMvWAuahr80AUPEgVMzF+rusVR
	y4an8bxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--32.791000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	513A7C7573AFBD3E4242B5B2EBB1D951708FCCCBC7F8B4766CB443F2877DAE8C2000:8

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBGcmksIDIwMjQtMDEt
MTkgYXQgMTE6NTMgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAxOS8wMS8yNCAwNzozMiwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gQWRkIG1lZGlh
dGVrLGdjZS1wcm9wcy55YW1sIGZvciBjb21tb24gR0NFIHByb3BlcnRpZXMgdGhhdCBpcyB1c2Vk
DQo+ID4gZm9yDQo+ID4gYm90aCBtYWlsYm94IHByb3ZpZGVycyBhbmQgY29uc3VtZXJzLiBXZSBw
bGFjZSB0aGUgY29tbW9uIHByb3BlcnR5DQo+ID4gIm1lZGlhdGVrLGdjZS1ldmVudHMiIGluIHRo
aXMgYmluZGluZyBjdXJyZW50bHkuDQo+ID4gDQo+ID4gVGhlIHByb3BlcnR5ICJtZWRpYXRlayxn
Y2UtZXZlbnRzIiBpcyB1c2VkIGZvciBHQ0UgZXZlbnQgSUQNCj4gPiBjb3JyZXNwb25kaW5nDQo+
ID4gdG8gYSBoYXJkd2FyZSBldmVudCBzaWduYWwgc2VudCBieSB0aGUgaGFyZHdhcmUgb3IgYSBz
b2Z3YXJlDQo+ID4gZHJpdmVyLg0KPiA+IElmIHRoZSBtYWlsYm94IHByb3ZpZGVycyBvciBjb25z
dW1lcnMgd2FudCB0byBtYW5pcHVsYXRlIHRoZSB2YWx1ZQ0KPiA+IG9mDQo+ID4gdGhlIGV2ZW50
IElELCB0aGV5IG5lZWQgdG8ga25vdyB0aGUgc3BlY2lmaWMgZXZlbnQgSUQuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgLi4uL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLXByb3BzLnlh
bWwgIHwgNTINCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
NTIgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2UtcHJvcHMueWFtbCANCj4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS1wcm9wcy55YW1sDQo+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjY4YjUxOWZm
MDg5Zg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2UtDQo+ID4gcHJvcHMueWFtbA0KPiA+IEBA
IC0wLDAgKzEsNTIgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAt
b25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlk
OiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3Jn
L3NjaGVtYXMvbWFpbGJveC9tZWRpYXRlayxnY2UtcHJvcHMueWFtbCpfXztJdyEhQ1RSTktBOXdN
ZzBBUmJ3IWtNQ2tod1FfYXo4SG91U1FncU11REM1UXBLRml6UXJXTWx3YVdQZllwMUdwaGx1ZVhW
ZlBmUzlGQTgzODA2XzdLX3FxY2ZIT2FwcnFBV05Pb0JrenNUSk5VU1pwdWdSU19RJA0KPiA+ICAN
Cj4gPiArJHNjaGVtYTogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFS
Yncha01Da2h3UV9hejhIb3VTUWdxTXVEQzVRcEtGaXpRcldNbHdhV1BmWXAxR3BobHVlWFZmUGZT
OUZBODM4MDZfN0tfcXFjZkhPYXBycUFXTk9vQmt6c1RKTlVTWXNvdF9zb2ckDQo+ID4gIA0KPiA+
ICsNCj4gPiArdGl0bGU6IE1lZGlhVGVrIEdsb2JhbCBDb21tYW5kIEVuZ2luZSBDb21tb24gUHJv
cGVydGVzDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEhvdWxvbmcgV2VpIDxo
b3Vsb25nLndlaUBtZWRpYXRlay5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjoNCj4gPiAr
ICBUaGUgR2xvYmFsIENvbW1hbmQgRW5naW5lIChHQ0UpIGlzIGFuIGluc3RydWN0aW9uIGJhc2Vk
LCBtdWx0aS0NCj4gPiB0aHJlYWRlZCwNCj4gPiArICBzaW5nbGUtY29yZSBjb21tYW5kIGRpc3Bh
dGNoZXIgZm9yIE1lZGlhVGVrIGhhcmR3YXJlLiBUaGUNCj4gPiBDb21tYW5kIFF1ZXVlDQo+ID4g
KyAgKENNRFEpIG1haWxib3ggZHJpdmVyIGlzIGEgZHJpdmVyIGZvciBHQ0UsIGltcGxlbWVudGVk
IHVzaW5nIHRoZQ0KPiA+IExpbnV4DQo+ID4gKyAgbWFpbGJveCBmcmFtZXdvcmsuIEl0IGlzIHVz
ZWQgdG8gcmVjZWl2ZSBtZXNzYWdlcyBmcm9tIG1haWxib3gNCj4gPiBjb25zdW1lcnMNCj4gPiAr
ICBhbmQgY29uZmlndXJlIEdDRSB0byBleGVjdXRlIHRoZSBzcGVjaWZpZWQgaW5zdHJ1Y3Rpb24g
c2V0IGluDQo+ID4gdGhlIG1lc3NhZ2UuDQo+ID4gKyAgV2UgdXNlIG1lZGlhdGVrLGdjZS1tYWls
Ym94LnlhbWwgdG8gZGVmaW5lIHRoZSBwcm9wZXJ0aWVzIGZvcg0KPiA+IENNRFEgbWFpbGJveA0K
PiA+ICsgIGRyaXZlci4gQSBkZXZpY2UgZHJpdmVyIHRoYXQgdXNlcyB0aGUgQ01EUSBkcml2ZXIg
dG8gY29uZmlndXJlDQo+ID4gaXRzIGhhcmR3YXJlDQo+ID4gKyAgcmVnaXN0ZXJzIGlzIGEgbWFp
bGJveCBjb25zdW1lci4gVGhlIG1haWxib3ggY29uc3VtZXIgY2FuDQo+ID4gcmVxdWVzdCBhIG1h
aWxib3gNCj4gPiArICBjaGFubmVsIGNvcnJlc3BvbmRpbmcgdG8gYSBHQ0UgaGFyZHdhcmUgdGhy
ZWFkIHRvIHNlbmQgYQ0KPiA+IG1lc3NhZ2UsIHNwZWNpZnlpbmcNCj4gPiArICB0aGF0IHRoZSBH
Q0UgdGhyZWFkIHRvIGNvbmZpZ3VyZSBpdHMgaGFyZHdhcmUuIFRoZSBtYWlsYm94DQo+ID4gcHJv
dmlkZXIgY2FuIGFsc28NCj4gPiArICByZXNlcnZlZCBhIG1haWxib3ggY2hhbm5lbCB0byBjb25m
aWd1cmUgR0NFIGhhcmR3YXJlIHJlZ2lzdGVyIGJ5DQo+ID4gdGhlIHNwY2lmaWMNCj4gPiArICBH
Q0UgdGhyZWFkLiBUaGlzIGJpbmRpbmcgZGVmaW5lcyB0aGUgY29tbW9uIEdDRSBwcm9wZXJ0aWVz
IGZvcg0KPiA+IGJvdGggbWFpbGJveA0KPiA+ICsgIHByb3ZpZGVyIGFuZCBjb25zdW1lcnMuDQo+
ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIG1lZGlhdGVrLGdjZS1ldmVudHM6DQo+ID4g
KyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgR0NFIGhhcyBhbiBldmVudCB0YWJsZSBpbiBT
UkFNLCBjb25zaXN0aW5nIG9mIDEwMjQgZXZlbnQgSURzDQo+ID4gKDB+MTAyMykuDQo+ID4gKyAg
ICAgIEVhY2ggZXZlbnQgSUQgaGFzIGEgYm9vbGVhbiBldmVudCB2YWx1ZSB3aXRoIHRoZSBkZWZh
dWx0DQo+ID4gdmFsdWUgMC4NCj4gPiArICAgICAgVGhlIHByb3BlcnR5IG1lZGlhdGVrLGdjZS1l
dmVudHMgaXMgdXNlZCB0byBvYnRhaW4gdGhlIGV2ZW50DQo+ID4gSURzLg0KPiA+ICsgICAgICBT
b21lIGdjZS1ldmVudHMgYXJlIGhhcmR3YXJlLWJvdW5kIGFuZCBjYW5ub3QgYmUgY2hhbmdlZCBi
eQ0KPiA+IHNvZnR3YXJlLg0KPiA+ICsgICAgICBGb3IgaW5zdGFuY2UsIGluIE1UODE5NSwgd2hl
biBWRE8wX01VVEVYIGlzIHN0cmVhbSBkb25lLA0KPiA+IFZET19NVVRFWCB3aWxsDQo+ID4gKyAg
ICAgIHNlbmQgYW4gZXZlbnQgc2lnbmFsIHRvIEdDRSwgc2V0dGluZyB0aGUgdmFsdWUgb2YgZXZl
bnQgSUQNCj4gPiA1OTcgdG8gMS4NCj4gPiArICAgICAgU2ltaWxhcmx5LCBpbiBNVDgxODgsIHRo
ZSB2YWx1ZSBvZiBldmVudCBJRCA1NzQgd2lsbCBiZSBzZXQNCj4gPiB0byAxIHdoZW4NCj4gPiAr
ICAgICAgVk9EMF9NVVRFWCBpcyBzdHJlYW0gZG9uZS4NCj4gPiArICAgICAgT24gdGhlIG90aGVy
IGhhbmQsIHNvbWUgZ2NlLWV2ZW50cyBhcmUgbm90IGhhcmR3YXJlLWJvdW5kDQo+ID4gYW5kIGNh
biBiZQ0KPiA+ICsgICAgICBjaGFuZ2VkIGJ5IHNvZnR3YXJlLiBGb3IgZXhhbXBsZSwgaW4gTVQ4
MTg4LCB3ZSBjYW4gc2V0IHRoZQ0KPiA+IHZhbHVlIG9mDQo+ID4gKyAgICAgIGV2ZW50IElEIDg1
NSwgd2hpY2ggaXMgbm90IGJvdW5kIHRvIGFueSBoYXJkd2FyZSwgdG8gMSB3aGVuDQo+ID4gdGhl
IGRyaXZlcg0KPiA+ICsgICAgICBpbiB0aGUgc2VjdXJlIHdvcmxkIGNvbXBsZXRlcyBhIHRhc2su
IEhvd2V2ZXIsIGluIE1UODE5NSwNCj4gPiBldmVudCBJRCA4NTUNCj4gPiArICAgICAgaXMgYWxy
ZWFkeSBib3VuZCB0byBWREVDX0xBVDEsIHNvIHdlIG5lZWQgdG8gc2VsZWN0IGFub3RoZXINCj4g
PiBldmVudCBJRCB0bw0KPiA+ICsgICAgICBhY2hpZXZlIHRoZSBzYW1lIHB1cnBvc2UuIFRoaXMg
ZXZlbnQgSUQgY2FuIGJlIGFueSBJRCB0aGF0DQo+ID4gaXMgbm90IGJvdW5kDQo+ID4gKyAgICAg
IHRvIGFueSBoYXJkd2FyZSBhbmQgaXMgbm90IHlldCB1c2VkIGluIGFueSBzb2Z0d2FyZSBkcml2
ZXIuDQo+ID4gKyAgICAgIFRvIGRldGVybWluZSBpZiB0aGUgZXZlbnQgSUQgaXMgYm91bmQgdG8g
dGhlIGhhcmR3YXJlIG9yDQo+ID4gdXNlZCBieSBhDQo+ID4gKyAgICAgIHNvZnR3YXJlIGRyaXZl
ciwgcmVmZXIgdG8gdGhlIEdDRSBoZWFkZXINCj4gPiArICAgICAgaW5jbHVkZS9kdC1iaW5kaW5n
cy9nY2UvPGNoaXA+LWdjZS5oIG9mIGVhY2ggY2hpcC4NCj4gPiArICAgICRyZWY6IC9zY2hlbWFz
L3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMi1hcnJheQ0KPiA+ICsgICAgbWluSXRlbXM6
IDENCj4gPiArICAgIG1heEl0ZW1zOiAxMDI0DQo+IA0KPiBtYXhJdGVtczogMTAyNCBzZWVtcyB0
byBiZSBhIGJpdCB0b28gbWFueS4uLiB0aGlzIG1lYW5zIHRoYXQgb25lDQo+IGRldmljZXRyZWUg
bm9kZQ0KPiBtYXkgaGF2ZSB1cCB0byAxMDI0IGdjZSBldmVudHMsIHdoaWNoIGlzIGltcG9zc2li
bGUhIElmIGEgZHJpdmVyDQo+IG5lZWRlZCBhbGwgb2YNCj4gdGhlIDEwMjQgZXZlbnRzLCB0aGlz
IG1lYW5zIHRoYXQgaXQncyBub3QgYW4gdXNlciBvZiB0aGUgR0NFLCBidXQgdGhlDQo+IEdDRSBp
dHNlbGYhDQo+IA0KPiBJbWFnaW5lIHNlZWluZyBhIGRldmljZXRyZWUgbm9kZSB3aXRoIDEwMjQg
YXJyYXkgZW50cmllcyBmb3INCj4gbWVkaWF0ZWssZ2NlLWV2ZW50cy4uLg0KPiANClllcywgdGhh
dCdzIGltcG9zc2libGUgdG8gc2V0IHVwIHRvIDEwMjQgYXJyYXkgZW50cmllcy4NCkkganVzdCBo
YXZlIHVzZWQgdGhlIG1heGltdW0gdmFsdWUgdG8gY292ZXIgYWxsIHRoZSBwb3NzaWJsZSBjYXNl
cy4NCg0KPiBJJ2Qgc2V0IHRoYXQgdG8gYSBtb3JlIHNlbnNpYmxlIHZhbHVlIG9mIDMyIC0gZXZl
bnR1YWxseSB3ZSBjYW4NCj4gZXh0ZW5kIGl0IGxhdGVyLA0KPiBpZiBldmVyIG5lZWRlZC4NCj4g
DQpPSywgSSBhZ3JlZSB3aXRoIHRoYXQhDQpJJ2xsIGNoYW5nZSB0aGUgbWF4SXRlbXMgdG8gMzIu
DQoNCj4gQmVzaWRlcywgbmljZSBqb2IgYWJvdXQgYWxsIHRoaXMgZG9jdW1lbnRhdGlvbiBvZiB0
aGUgR0NFIGFuZCBpdHMNCj4gZXZlbnRzOiBsb3ZlIGl0IQ0KPiANCkknbSBhcHByZWNpYXRlIHlv
dSBsb3ZlIGl0IDopDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBDaGVlcnMsDQo+IEFu
Z2Vsbw0KPiANCj4gDQo=

