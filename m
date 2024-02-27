Return-Path: <linux-kernel+bounces-82620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2634F868757
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0917287CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD911B7E9;
	Tue, 27 Feb 2024 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UMxypmU6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kNieR8dO"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947D12B75;
	Tue, 27 Feb 2024 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001677; cv=fail; b=Lq+uxrpMvqNRP9oNJVMLy+e5Yw+bTr8GfxyyoVgYTDoXnNwkKVkQZtIOBK1K87nfmcvWict/9P1DFPRSlWPO4b/vvaw4O1O/u4iT6o0hARVTHTxb8uEDbkj1Js9VBggUaflQIDVa1+QogJwvqhP2fjRQvzokcFOCj4J8GTZ9BT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001677; c=relaxed/simple;
	bh=srKisvGM4vQ9lYnQQGgPPqkLBQ1I95k6WUSQbh6lS08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EiwMUsdR3qeYGuOZYm8ZSY6YKvWmGtBUyWD5i6cJoyBNEdgDWgbeLp2clcomxYOHaCg5z2h/IkRXuW4WDGtCkTS92Tj92dpuQbWccYoqhQGsxDWnPbTkbjL+qXRs2cMOPPMbcz/84d85sr9uFlIJUhrR8t7MHaunlQHdok18YQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UMxypmU6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kNieR8dO; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: aa38f1b0d51911eea4ad694c3f9da370-20240227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=srKisvGM4vQ9lYnQQGgPPqkLBQ1I95k6WUSQbh6lS08=;
	b=UMxypmU6jIzuvdag+G/4HG0s9kL5tdpDLug6Mwmu06ihtR0m7VQdwCtuiDN98btV7hA5ZwG+G4PtyveMolV4l2Rnc1eJhP5ArkPtBsjw6qfkYIXm/WMg3KM4NyH7iqPXyToa6kOsXkKnPBvD5525E0NafggudFAUkkp5dVlPOs4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f9feef3c-58aa-4e1c-8f39-c384881e700c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:32d8c08f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aa38f1b0d51911eea4ad694c3f9da370-20240227
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1250513744; Tue, 27 Feb 2024 10:41:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Feb 2024 10:41:08 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Feb 2024 10:41:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf9YbnSSbwRXbfJipcIPpNRXT47qMH6xdOYAC0rHWEHYkahsO/adtXGmF/Mn+reclO61s8cWeI9jgSz+x1em/3RjYf7q1qOx9ETW72u4D01CkVoCfN9XN8y0yhYp5dEH1q8X+g9W3Nxn7ZCqtB80LWTodlpLs2z2KebDEneQ67TuYdB96eD9QahDJrU7h+N2rPCFWErsi62f0v0MWet3CTiHP1YBCzxXyOgKoGFG2oC91nflYQ4E9VzOPlrqqYUIr2XGG3LO05uUo0nqQ6tYlRmRqSsSyU2NcglmzSqs4eVsq9qb9hI/ytRimmbASn0k2D47Fkgc0j1N7uM2naotOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srKisvGM4vQ9lYnQQGgPPqkLBQ1I95k6WUSQbh6lS08=;
 b=CLvE+HZ9bUDakDUUSMIyXT43qWssxxlS+yPIDEQKMFOu6b0MlOU4lfCrf7ahBKtb818HjkbpN2YSBBkUBsussjz1/rnUzaPx98+GXE8CllIUikNYhE7ycIIeQ7E7mGLo8yvVeF9L0WQ8A6TK2KstHYkI2hkXgPP/t00hy4GMI4ZJJQ/AQ1sZgroCmZQG2mFPT89NANjggeGF6id/HkNdebgpSHbKHd2TnwwNE4hnlEtc8cfoUqKhbYpj7YLhe5+qFyTAOxfOZnziIG8/xudOrkInURW7bz2yX4PIls6dhN3RssCUj8caziwjYLrUnob3nKSjFBz/yIWNQ8USXimLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srKisvGM4vQ9lYnQQGgPPqkLBQ1I95k6WUSQbh6lS08=;
 b=kNieR8dOW+rsqfM3djhX3cYhSjuYdRob9lzvPf1EP0A2vncS16N640oJdcCZdJ6aUs+EtrX5y4gnNZPQRTWye3Y8qSL/bKP1JuqV2GUysVrZg/zMvssGiwQncnl0DO8iTJPK/joJnQC62VFpSX9MXIreglmUC6zKvf/P6Xl78lY=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by KL1PR0302MB5203.apcprd03.prod.outlook.com (2603:1096:820:49::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Tue, 27 Feb
 2024 02:41:07 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::f890:d417:7a30:6413]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::f890:d417:7a30:6413%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 02:41:06 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC: "heiko@sntech.de" <heiko@sntech.de>, "tomi.valkeinen@ideasonboard.com"
	<tomi.valkeinen@ideasonboard.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dan.scally@ideasonboard.com"
	<dan.scally@ideasonboard.com>, "gerald.loacker@wolfvision.net"
	<gerald.loacker@wolfvision.net>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "jacopo.mondi@ideasonboard.com"
	<jacopo.mondi@ideasonboard.com>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "bingbu.cao@intel.com"
	<bingbu.cao@intel.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "10572168@qq.com"
	<10572168@qq.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v5 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Topic: [PATCH v5 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Index: AQHaY5veBU1X1CrPZ0CXXYfsLn46lrETWRsAgAosfQA=
Date: Tue, 27 Feb 2024 02:41:06 +0000
Message-ID: <1201202f1205c32b435952f1b1618eea6e93fd5c.camel@mediatek.com>
References: <20240220012540.10607-1-zhi.mao@mediatek.com>
	 <20240220012540.10607-3-zhi.mao@mediatek.com>
	 <CAHp75Vfbc0jE43Z-trFRnFdT5SxvJN+w2x7hS4vHuF5M2kTXgg@mail.gmail.com>
In-Reply-To: <CAHp75Vfbc0jE43Z-trFRnFdT5SxvJN+w2x7hS4vHuF5M2kTXgg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|KL1PR0302MB5203:EE_
x-ms-office365-filtering-correlation-id: 700a3c62-b057-48de-b40e-08dc373d8c4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQNJ6S3s7D1/kgSJGVi3sk7kAlYieONUWQixq+wYBbify7ErIhhlQHf/vVDf1jLq2+9NsGUpzDSrAi9x7yclqYvmcbIxuCNGrS4T9AqelQo4CuLZTnp2IT68rbya4kFkqoxtG+UTXXdcGkZtoMVhi6X2E4Q+Jbh7H0SB8TRTJwdq0uVyzpHTpTMsqFJ7XuqqRaJWXTjsstXWNUgqmVoFZsEZWqNO+bgYtFaIB/mdS8oOgvdmkBFsWclArctupFeHxPawvZgOpD3rt1dOoj2NVtSLmg9IcI1XVYPI/IQRs1tEDEecgnCpLF2/GVxiPWxk42XzPJuUwrCKjqh7Zt+jnRTtl4jBZ2SdYmyqLzR8hbEJ98bH6pcraGnTDoLilyCY/W0YQ6sSUam5ciMQ4AlmpwLgUPW1WhLHV7wQt6Jr9BvOJUJ9NaALMyOxHVA5lc9srqwuvPgHA9HKZHUaKIu+esT0JsNIjRZ2mu4fsTdnkvfkGGur16C8P5KRFtgw/aNjFETjeccYrMlCPKYyJcl6266w56L9hkQ25F/d1KdxwNDDMICdn5YlV1k1sFonXGp3tszHo3iFL/GwufF6Ep61OXnTR+n3oGKAHmmllqgboj9tahAPRopXqxYRtx8uUn2c5tb4AwB2Ke6CvKftyh8BGP5T0EMqMgGEKvBh1Hr+114mRIXiFICC/GrbUKyLBSt6P8n0w9fF/PYw2P08ubU0lA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUM3bDhrYTZQc3lpV29qSEZnSmpaeHdJbW16ZzEyYUJKdExuRVB2bUFvc2Mv?=
 =?utf-8?B?Q01FQW1sK1lKTHJ1MmpicDJNNkJXczVSVFhJSkFHS05XWm1vOVZZcUNRQnZt?=
 =?utf-8?B?L2grQkdqU0s1alNXQXVDRUJKU0dYUC9VTXRhV25kMmt2STNXR1hlTkdrd0Rl?=
 =?utf-8?B?Z0xVc1NWWm9NY1dHdzB2eXhoWGZQYlQ0aytJUlp4dmsyeGpWOHBMRXBRdmJ5?=
 =?utf-8?B?RDdnSGtHamJ5cTVNdmNIRXlIK2drZUdVM3ZjYmpXTldqdzhTQUE2M3ZKYkNO?=
 =?utf-8?B?dWFEWmI4M3VsSVVYdWF3clpMWURRSUxGUnBCS1pDdVhISnZ5eUgvMVl2L0c2?=
 =?utf-8?B?YlpmV002SndxOEVzZW5UbTdJVUlyVW11UnA3aVFZbG1Vem5IeGc0OUJxeXRh?=
 =?utf-8?B?dDVxSjk0NXFOWUtseVJUUXNJL1N2ckJjRklQMmtmZ0xzcitjZTJIUWRQN3hG?=
 =?utf-8?B?K2lmK1QvaXd6ZWR4RWZwMGIrRURYY0lwWGIrMHBuampZWHp4Y0tkclBEMXQ5?=
 =?utf-8?B?UzQ4TjNHUGFuZDJtT0crQ1loL1RUQUxyRURQZUJaZVhsUjlETnpoZnZuWU1C?=
 =?utf-8?B?SG10WUtHSFpSMHFNeHNLSHhFZVA4SmJ2SFV0dFAzMW9pdFFrS01lUlBSdExk?=
 =?utf-8?B?OFpVdlkvbHM1WmNrd1J0V3hhOFM4OWpLcm9wOTZlWGExWmVEN29YamZuL3BR?=
 =?utf-8?B?WTNjclMzUjJBVTdGamprbXRrdVpzMFlKUzMwYURlNWRxVzMybFprR3pmU0U2?=
 =?utf-8?B?bU9zY1l2MDJqN0lsZ1BMdHluWCtkV2hCa1p5aXZzUTdjY0dSK3htVmM0bWdK?=
 =?utf-8?B?ZnIxanlFMFlxZEFTSlk0RGdOeGhVZTFQSW5uMlFtQU05T01tUEw4SUNCSDQv?=
 =?utf-8?B?NURoNUcxQnRhcE1Db0hYdGkvMXFWSkdMZUFPN1JsanhKT0Y1SEs2Qlp2N0E1?=
 =?utf-8?B?QzZGYURnRmg0dkl2ZEZ2bkozVFdXYkI5cU53YWhaekdQWEQreE5zM3kyeSsw?=
 =?utf-8?B?VUM1WnVod3A0dnlmTWtZeXRnMElJNE1aTU9iWUp6RXk0UHFFb05mNlV6RmRt?=
 =?utf-8?B?c1JoSWs3SmZDaUpHRkRQb1RmVFQ5TitETG1JTmRabTIzTU5jeC96WUJVMjBW?=
 =?utf-8?B?TG1VT0VMUWlhcVF5eDA0RndyV3VOZkxMdVYwRCtVM3hIaE55c1JQS2kxeEpJ?=
 =?utf-8?B?aFdGV0dCN3ZHbjRZck9zbWpHR1Jwb25TMGp2bk43UW5DWEZXOWcxVWlYV0RY?=
 =?utf-8?B?Y204S0tFOGFUaUtsdjE2RXJ4REQzdUtqUm1WZFZmYlJ3V0tQSkJZc0VXMWFz?=
 =?utf-8?B?SjhOaUl5VWkvaE9BNEY1UWJFNk11Yi9jTFMyUWRuWVhZcXZaaWkvRitqU1hp?=
 =?utf-8?B?dlJjMTdweFEvSldXNFBtTkFOOVdEZTFGclgxd2VRSEVzeU01VW9WQjhYL0h2?=
 =?utf-8?B?OVJWU3RGVkNpeTVhMVZFV0tlK2QrVU4wT3ZvRENCS25rTHloNzE0cmJCT0Z2?=
 =?utf-8?B?SGh1VFlnU3dZMlR2cUd5T203Q3Q4ZVJXbGE4bHpGMDBYYnlSNnZVSFBuSmRn?=
 =?utf-8?B?ZU9lVXNQbk9ESmsrNWJ5MFpvMTlTYkVyRVBFYlpHUUZFeW5neDlYNlBaSHFT?=
 =?utf-8?B?dFFwUWFyRVRGT3k1N1ZCTHVNUEYxN0pmZ0NCNUx0YmE5UHdndkcxMy8vaEZk?=
 =?utf-8?B?cDJ4R0VZZHUrQndtcm5USy80VlcrRUxLY3BBeE9pWXl1NGt1VXVJNDFhaC9u?=
 =?utf-8?B?bnpaM3dRYkh6SXZCenQrNzBFd3FRTDNJL2NnSXorQzk5cUU5djR6SlEvU2NJ?=
 =?utf-8?B?Y3pTZUxjTGZVczF6Y1pGYlZnMGFNWG1yTVRwcEJETTEreEhJTUc0eGlxc0lD?=
 =?utf-8?B?Z0U1WWQzaUFJbXd4a0JCenhaUk90TSt2VnBJVUw1dnBsVEpGK1FJSitjL0lF?=
 =?utf-8?B?SUk2MjF2UXZQMTZhL3ZLRGk4bXRiMmh4YnVYQ09DMEZib3AyN2hxeGxRb1pR?=
 =?utf-8?B?NGFoY0ltY2NhbW5tNkp5RTJpQ2ZYNmx5eWlHNGUycitjYnBlWFpzQ21sRHhC?=
 =?utf-8?B?QnFwNUllU0hRR3NQWnB5cmdhb3VRNk9mNmJjb1NjYXBJRnFRV3VnQ3BXQmJD?=
 =?utf-8?B?MURVU1JWQmgwZUIrbFREeG1NMVN6TkxxREZyWXpaTSt5eXhmVXhSZVFDemVM?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DE38C79B6000C448C24A32FD39925E5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700a3c62-b057-48de-b40e-08dc373d8c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 02:41:06.5801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWMTHMzsTSV1pSsnOF4ihM+DpPylq81Ei32x89mGKkP+WMGeuXOQwpSA8kIjG/ycZkFSp05OtEuGz66A7ymNuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5203

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KT24gVHVlLCAyMDI0LTAyLTIw
IGF0IDE3OjE5ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5h
bCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAg
T24gVHVlLCBGZWIgMjAsIDIwMjQgYXQgMzo0N+KAr0FNIFpoaSBNYW8gPHpoaS5tYW9AbWVkaWF0
ZWsuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBhIFY0TDIgc3ViLWRldmljZSBkcml2ZXIg
Zm9yIEdhbGF4eWNvcmUgR0MwOEEzIGltYWdlIHNlbnNvci4NCj4gDQo+IC4uLg0KPiANCj4gPiAr
I2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4NCj4gDQo+IFVzdWFsbHkgYXNtLyogZ28gYWZ0ZXIg
bGludXgvKg0KPiANCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvZGVsYXkuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L2kyYy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9yZWd1bGF0b3IvY29uc3VtZXIuaD4NCj4gDQo+IFRoaXMgbG9va3Mgc2VtaS1yYW5kb20uDQo+
IEZvciBleGFtcGxlLCBfYXQgbGVhc3RfIHRoZSBhcnJheV9zaXplLmgsIGJpdHMuaCwgY29udGFp
bmVyX29mLmgsDQo+IGRldmljZS5oLCBlcnIuaCwgbW9kX2RldmljZXRhYmxlLmgsIHByb3BlcnR5
LmgsIHR5cGVzLmggYXJlIG1pc3NpbmcsDQo+IFBsZWFzZSwgdXNlIElXWVUgcHJpbmNpcGxlLg0K
PiANCkkgaGF2ZSByZW1vdmUgc29tZSB1c2VsZXNzIGhlYWRlciBmaWxlLCByZWZlciB0byBzb21l
IG90aGVycyBzZW5zb3INCmRyaXZlciBjb2RlKHN1Y2ggYXMgZ2MwYTA4L2djMjE0NSBhbmQgaW14
L292IHNlbnNvciBkcml2ZXIpLg0KQXMgdGhlc2UgaGVhZGVyIGZpbGVzIHdoaWNoIG1lbnRpb25l
ZCBhYm92ZSwgYXJlIGluY2x1ZGVkIGJ5IHNvbWUgb3RoZXINCmhlYWRlciBmaWxlcywgZm9yIGV4
YW1wbGUgImNvbnRhaW5lcl9vZi5oIiBpcyBpbmNsdWRlZCBieSAibWVkaWEtDQplbnRpdHkuaCIs
IHdoaWxlICJtZWRpYS1lbnRpdHkuaCIgaXMgaW5jdWxkZWQgYnkgInY0bDItc3ViZGV2LmgiLCBz
byB3ZQ0KanVzdCBuZWVkIGluY2x1ZGUgInY0bDItc3ViZGV2LmgiIGluIHNlbnNvciBkcml2ZXIg
Y29kZS4NCg0KPiAuLi4NCj4gDQo+ID4gKyNkZWZpbmUgR0MwOEEzX0RFRkFVTFRfQ0xLX0ZSRVEg
MjQwMDAwMDANCj4gDQo+IEhaX1BFUl9NSFogPw0KPiANCmZpeGVkIGluIHBhdGNoOnY2DQo+IC4u
Lg0KPiANCj4gPiArI2RlZmluZSBHQzA4QTNfU0xFRVBfVVMgIDIwMDANCj4gDQo+IFVTRUNfUEVS
X01TRUMgPw0KPiANCmZpeGVkIGluIHBhdGNoOnY2DQo+IC4uLg0KPiANCj4gPiArc3RhdGljIGNv
bnN0IHM2NCBnYzA4YTNfbGlua19mcmVxX21lbnVfaXRlbXNbXSA9IHsNCj4gPiArICAgICAgIDMz
NjAwMDAwMFVMTCwNCj4gPiArICAgICAgIDIwNzAwMDAwMFVMTCwNCj4gDQo+IEhaX1BFUl9NSFog
Pw0KPiANCmZpeGVkIGluIHBhdGNoOnY2DQo+ID4gK307DQo+IA0KPiAuLi4NCj4gDQo+ID4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBnYzA4YTNfcG1fb3BzID0gew0KPiA+ICsgICAg
ICAgU0VUX1JVTlRJTUVfUE1fT1BTKGdjMDhhM19wb3dlcl9vZmYsIGdjMDhhM19wb3dlcl9vbiwg
TlVMTCkNCj4gPiArfTsNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIC5wbSA9ICZnYzA4YTNfcG1f
b3BzLA0KPiANCj4gVXNlIG5ldyBQTSBtYWNyb3MgKHBtX3B0cigpIGFuZCBmcmllbmRzKS4NCj4g
DQpmaXhlZCBpbiBwYXRjaDp2Ng0KPiAtLSANCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkg
U2hldmNoZW5rbw0K

