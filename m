Return-Path: <linux-kernel+bounces-164981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C6B8B85D6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB601C21E57
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2DF4CB4E;
	Wed,  1 May 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aXGBrNzO";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dRi0MXHW"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8957F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714547415; cv=fail; b=X1kL/wW2ZsNbU+g4g+G+Su/rqNzd3mdVlVzWQZGyDNsO5msyXkPLxBQrKkd7f5rEMeR6LWABwJa657C5oooukkUK3rBOwkJdB42jSD81uvZ1JNzw+QwTtTfSh5TizyDOrKYZAh9cFEp2JQXjXimmIc1OuqfW585FJtOJ5lXvz+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714547415; c=relaxed/simple;
	bh=TDTZV4X0zhJ6fs7iURvPzEm2vi8vj8M1tX2s7CTZYNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HFAECszJ80m5SEHc+RPj3Kh03FCpMApcYC2cjxJgdUN3rcMKaRyJn+l894lvOHWpROVRbYnxKL+HnCRFV0ch6xB0YxgE7DcxMIk0xTCzhmr2f7vKLCc9z6mer6v7JYFvbTJOYgZFwwPQwZF90XCx7P0+6kTldC4u0emN0+xA6yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aXGBrNzO; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dRi0MXHW; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d28f9dec078911efb92737409a0e9459-20240501
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TDTZV4X0zhJ6fs7iURvPzEm2vi8vj8M1tX2s7CTZYNQ=;
	b=aXGBrNzOuqg0tDmdcyj1GMneXBIFIgnoTb+f9d3iyDixUwcPLxiYUEZoOMrjGq8ZOubQ1UdvFPqksJSIhqzKmQ1g7QrhEi7CsyYiCf/r02FWGGLADS6VDWoGJgYn1StxIWbagiIgENfK8T6bdgTlgugzn3zqYy16FMv6DkPD/P4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:9d2fa4d4-6c8e-4097-897c-4edc2b9b7eb9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:5e6f8efb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d28f9dec078911efb92737409a0e9459-20240501
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2109614356; Wed, 01 May 2024 15:09:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 1 May 2024 15:09:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 1 May 2024 15:09:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiCBlaP2+ym4krb7Evqweq0UU8vh0May9BfeOfNHUo534wqobip9Wpe7czkno/hiAv7L7qTy02TiF/zWGs53OvqkMhjEgtFWU3z/8wCXXwJkQdxihbXBQLRZ3U2giWCJEXMLAgVGSTTr3E0J422AoY3Eo4R1pH04Kq1oeCVqZj58zTDTy7mTMrPfPeWV9IOYrOXQUWSzT00OIn6IleO3o9Gp9nt11/wswEq9kGBhov5qfUNgtDwB8EeXvbE/Ub7g7o/b1g+lBPOpD1p5ff25CpSuvAkRIn/tI7HmVB0H5oeZZEIWKsZtw8hQ/2rKO8P37qt4H1jSLhtcdiS6mYUzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDTZV4X0zhJ6fs7iURvPzEm2vi8vj8M1tX2s7CTZYNQ=;
 b=DeT+Ys7afGu3AGE91k5ofDPaR3DjZfRmwk1Xy4T/N6Nm3hRMha9cLthoPa2k4GLUAZ/PnLcmgz5OqPywBuxzJPuLzzTfvF2NM/l57w0oInlx2w4zWf8Mj4MUuTAud+e0A+eimBkQbav01K8Rwyb16bXJzSrQOiJoPwFtqqZWfnfwEZyqakYfB2LXx0ZJXjjI6u5geNNjIMqvQptv36nFuf5rd3hgIjWQCHOVMAM/P/NgspYbjVDbux4XVNRhaIKY4Z3BdBOl9ebnfzB10FbLcaC7duKq0isDpJ5CujE3lbE1s0AeP9FeL5dBlQY4/0Mt0TX8vp0pWK5yPxghuy6YrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDTZV4X0zhJ6fs7iURvPzEm2vi8vj8M1tX2s7CTZYNQ=;
 b=dRi0MXHWXBtCAt7QAkmq9GTrcde5bmpZK+5jh9a/54EEwOWBBkU4LjcUjhbHvOYs+511JwbZrDCUR/Lcu37gi59MviB9DEHNoyX/t+Bpu8guFS7DzmB0eyN6K/C2UazUQxiT4h54T3XjuSsnkh8K9+WdFTVMfhnRK1WMa1g+Vl8=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB7007.apcprd03.prod.outlook.com (2603:1096:101:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 07:09:56 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 07:09:55 +0000
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
Subject: Re: [PATCH] mailbox: mtk-cmdq: Fix sleeping function called from
 invalid context
Thread-Topic: [PATCH] mailbox: mtk-cmdq: Fix sleeping function called from
 invalid context
Thread-Index: AQHamtnwxWfcTPEcl0yXxzKAMY2iurGAjsQAgAFoqgA=
Date: Wed, 1 May 2024 07:09:55 +0000
Message-ID: <747b383eb63797da52bb604ed98d2ab768eb2754.camel@mediatek.com>
References: <20240430083934.26980-1-jason-jh.lin@mediatek.com>
	 <2b46b3c0-f4ad-48e1-964b-128d29bafa9c@collabora.com>
In-Reply-To: <2b46b3c0-f4ad-48e1-964b-128d29bafa9c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB7007:EE_
x-ms-office365-filtering-correlation-id: a2b7ceb1-47f9-40b2-2c76-08dc69adb466
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SVV5UlJsc3A1d3ZDT1ZLM3k5cUhoRmZvNFd6QXFSd2Rya2x1TFh2bzZPNWpH?=
 =?utf-8?B?dzRtekR2M284MTZMSFJSN2huYmJUTEFOai9rMExzMXd3ZmY4RGVLeWhhc25Q?=
 =?utf-8?B?VDVUOTRqUDNNRW9RbmN1NGhVMEN3blVzQ3c3K01RUmFlRVFPR0l2eVpJSk5m?=
 =?utf-8?B?Tk8xbnI0TkxURlAzRWhKNGg1L2d5cTAvWUF4N0tESXg3L2pqTlpEVEZEcDlZ?=
 =?utf-8?B?eWxkSVBFUEpkaXB5cGk4Q2tDNUpPeWFRdGorUTg1OEFudE5NYnI2YlBodVRE?=
 =?utf-8?B?U0xEV0FDL3F3cnl6TFhKN1NUcytCRkRSRm05K0UzeU1uQm9nR25qL1ovbk8r?=
 =?utf-8?B?Z0g2V1FvemlsOHlMZDBrTjZUS215L09CK0dGaEhSMmxiNmg0T2tKQ0JZeDZl?=
 =?utf-8?B?OGQ5L3VqQ0Ftd3UyTWcrOXhuUUJVb2Q0eUNWN2ZXWXNsRE9zUVdBQm5qSmU1?=
 =?utf-8?B?OHZXdlI0UEsydmpwTFY1cnUxTW9iZjBKendEQkVWeFpFR05IR2NOSmZ4a2M4?=
 =?utf-8?B?OEhxMnl6VW5pQ3hTQldrTmg3OW83ZC9aT21jUElMeElWSmtaUlhIK1RPSjZB?=
 =?utf-8?B?Y2lTM2xONUV0RXZ5c3I4cTdzaUNaR0RPODNRL05lS01kMU9QaFNBTlZYa0FW?=
 =?utf-8?B?cnJNWHlCYTMzMUloS3Foa0ZidWVLSUwvUHlBcFJNMGFmUnpUaitGanIzZXVZ?=
 =?utf-8?B?M29LcEEyTjNneUdqdmR5YUpmb0NQZ0cycWE1L2FlQVFCRWFPU2tDV1plemEz?=
 =?utf-8?B?ZUZ4Q2RScnpXYXpERVRRVzEwV01hU2dwcWJGL0JSWmtUVXc0Skoybmc1NklV?=
 =?utf-8?B?NGJhRFhyYWRQblNuTzhRM0tRRFlRT3BFSi93eTc4aGh1NWNPRDJ2ZTZ5RHZv?=
 =?utf-8?B?bHRhT3cxRWtkdjVKdG9EV3R4WHF4Rzl5K3I4d1pERkRUb3hXU3g2U3pCOHRL?=
 =?utf-8?B?QStKcjRhdUs4M3BrTXVFRHUramI0b085cjVvM1UzTnBMKzFndnhTcDljS3Vh?=
 =?utf-8?B?ZkZIcTNFSXZkbVkzNGx3d2FWakM5Qzd0REYySkNHQXhwTjdTZzh3Zmh5L0lL?=
 =?utf-8?B?V1FUR29pM1dsUjRXcW1ORkExU0JuSFljSnpHTThQeWVDVDlHTkM0UFpVMXhD?=
 =?utf-8?B?QzVielJnckM1QWRnYWpiaXkyUjcwcm04bnd0ZkVleDVIaTNmcjUvbEY3VE9r?=
 =?utf-8?B?Uyt1M2pkWUJBZDdBWmlXV0MwQUNiNWwrK3FjeTJMbDEvWHhuSitXTGhVVkpt?=
 =?utf-8?B?TE0zcHZuRmZlbnFBZGhhYzVmdXdUOExPSkhHaTBVQUY4RlIrNTc0UVBFYWYr?=
 =?utf-8?B?dTBlaGlVSDRXTEZZMDIvTlFYMDVnQlBwUHcwRXVna1NJOWhuamhTSWs2M0x5?=
 =?utf-8?B?Ulk0T3h3S2JLVDgwa1hGNmE5SFdqYkNzc1R3VDZEM3RJdUJ3MzZUNEI4amxi?=
 =?utf-8?B?czV5OU1uZlZmMHdjQllFSWZGSElKN3FhM3l3T3NiZVAyblh6NUpsaWFHbGpa?=
 =?utf-8?B?QXBhMXNTZEhaWXdFRlVrUHNGZHIzNkI4RC83U0NYYWtsVlNwRStpeFhaeXJE?=
 =?utf-8?B?NUFaOUhWUjdKQnpGS2FRV1BvSVZWdkxnM2IvYnY1cFZ6OTlYazdidWoyditH?=
 =?utf-8?B?akRwRXZ1WTRjZDFjenJXMDUzM0pQWkRmbEFJc2ZOTFFTY0pPN0ZUWmxraE5j?=
 =?utf-8?B?SzhhSEw5OFhodGFDRnM3WlRrTjA1dTVBTUxrYzJVYWZUUDJpeE5lcnRubTho?=
 =?utf-8?B?YWZOMFA5eGFBL20ydUp4YkhWU3VkanlqQWxsclByTE1MVWRvWElVdGlhYjVL?=
 =?utf-8?B?U1BhcVFQWTZQNmh1VXdtZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blNwSUxVQmhFM0VJV2YwbUtRK3RvQngxbHNqTGZjZUpGQU1EMGIrZlRGNC9K?=
 =?utf-8?B?alFENUQ0ZEI5RmZDQ3g0SUVOa29FWjNKeko0M085TVVReGpOUHVHdlVicFQ2?=
 =?utf-8?B?cjJZaWRkdzB3dE5ndndXVWx4bGlvenRuMEduTFp5UDBOU0JUY2FCU1ZZcVVw?=
 =?utf-8?B?VzVUcG5uNWpQTEEybzJSVVF6MHJMTW9ZTUpXMkx1M0ZBN2JERlVMYmlQVEVl?=
 =?utf-8?B?V2hpU2ZjQVUvOGE3VVJhRGxERWhtd29ZaTcrRlI0YTBQdW1jZVl2Vk5IU1N6?=
 =?utf-8?B?a1hWSkwvaEkrZS9qc1pJUjhld25mUmUwajQ4S1NHemtUOGh1MndqMzFsWlJQ?=
 =?utf-8?B?cTZKWnB2aFdGRmF4SHNGMmw3R01KQ0RyR21tck05MHhyQnNzVWw1SDZBc0Ux?=
 =?utf-8?B?TmdTQjNLRGc0c2x3NkI5VWdieXlRMURPZUxoT1pseVAzaXB3cURCNWF5QlQ1?=
 =?utf-8?B?MmpPNUU1RE1XL3A5ZEZRc0FsS0dNNCtXSHF6dGRaeWhYZnYvZzJuaWw2RUM3?=
 =?utf-8?B?NDFISFdiU09MMWtSTm05US9VcWV0aHB3K0lMaW4zOXd2eEV6SHUrMXFGMFZQ?=
 =?utf-8?B?N0d1WjhxUDFKV1pMck8yK2dva0NrcmEyOXJaWisrbmFBRzhWcDdna0xac1R2?=
 =?utf-8?B?am05a0d6WDhkOXE3Sm1GKzk3VlRQU1NCc1F4Uzh3UExQZ2owZUdSeUljRHNw?=
 =?utf-8?B?cm9seDhOZm5TS01jdEI1R283S01GTEhuUkgveFZmV1AzMk1RdmgybndMUUlZ?=
 =?utf-8?B?czZEaUV2RDM0b1V0RXIwcUpuWC81aWdINTZTdmtRaXk3Q3FHQ3prUlBDdGV5?=
 =?utf-8?B?Y0ZLSjRCcjdLamVBK00zbEJJVmFZcEN4SyttdzAxTCtLd3B2T0JLQndFeWlX?=
 =?utf-8?B?MGpXS09mdG1HcVFHQW55NklBOWNSZ05zUFc5Ym94QzlvRU5sQzlkUDRnVXhu?=
 =?utf-8?B?U0NrMG12VVhlc2s1bkV4Uy94b2VLN1VxcFVkbURrVzRIOU1qbkd2cy9rd1ZK?=
 =?utf-8?B?UkVNa3VxMlBJamt1T0l0clNoY254SVNsdFd0TmZrMko2UytBeW5pdzN6MVNo?=
 =?utf-8?B?K0JrZjJ5Q3pNOFZuNHNkZTJpY3lrVDBRZFV0cll6WVJYYUtMSUhOeGhNMGNp?=
 =?utf-8?B?NmNoM29jUDRBS1FneWNqOW0yWmozNHVMN2J6VS9iWVN1Y2dmK2gvb0MveVcw?=
 =?utf-8?B?bFloVU1CUnR1S3FmemNsOVBQK0VGNDlLdGFlRmJ6aTNsRjJEdDdxa3ZQNW9y?=
 =?utf-8?B?Q0tnVE9BdVR5Q1lGcFZ0V3FZdEgwQks2RlozeFA0SHZralRJVmd0MWNBK2x5?=
 =?utf-8?B?Z0dMNmJIMkNoTm51TVFFVi9FeWQ2WmtwbWNPdTFsWHQwRVNDbTRyOUxPN1Ir?=
 =?utf-8?B?Mms4emI2NUI0bVFSN0J6WW5CVDB1cllCanRxdFZoSmJsQUJtbTVMdlZjc3Ey?=
 =?utf-8?B?alczc3dFOFFBL2pOVVkvbWFOWS8yLzJOeldBNFU4Ykh4aTBTeW9OV292c0VF?=
 =?utf-8?B?QllWVW50SXdTMm1xZ01ia2VreVZqcHJDRS94VFIwN2ExRGo4cEUrcXAwQjh0?=
 =?utf-8?B?TitKSW43RDBwMnlrbWhySGdUOUo3RXRqMlIxOVBSMFJjdzR5TU85emFodGhG?=
 =?utf-8?B?bHBTTVd5KzdlVUZoWGdhVWhMUWk4RTZOL1N0UG95SDdrV0ZYa3Z5Tjdrc1lo?=
 =?utf-8?B?Si84WS83QTFwbTd3MnZXR0RSUncwL29NQmpYaC9TVEVkU3JtUUIrakNISER1?=
 =?utf-8?B?N1Z0c056bG04L0xUQTl3a1JmNzYrYVl4eENkRm1iMGRueEl5RVYvYVJmb1Zn?=
 =?utf-8?B?enhmdTlrNVNHQldBdWkxd1pVaTkyRWVLaWtmNkd3b0RWS1N6TldZSGR1ZjY0?=
 =?utf-8?B?SVlnWUI4TW9qOWd1b2U2c3JBeGxjRnZHL0xUc2VhZ1lRbU5lZ1ordEpuRjNy?=
 =?utf-8?B?UnhaRHRmRXE0aXBZM3lLaisxV3Y1UU9mdmNubmNTb1AyQkFucTdOWFo3Skxn?=
 =?utf-8?B?aThlem1YWG1KZms1WXhIK001QU0ydDllUlR3NUdCTzNmWVNaWVZFUk9ObUND?=
 =?utf-8?B?RHg4N2t2ZEtmeUUyb2Zib2syNGJTNnA4YzQrVzRGdUxXZFQ0L1R6N1MyZUlz?=
 =?utf-8?B?QnRidkZUSDE1WkFXT2hHM29BUGFoc1dZd0lEaGYvQlMrbUc3dkF0c2pLQkRr?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C99F887AD79824C9930394F0406085B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b7ceb1-47f9-40b2-2c76-08dc69adb466
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 07:09:55.6591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+RRjgwYGpbKLZwUxX9zY/7LWCILZzjnWcw0zWJARK8TAYaQ2Z6q1p+aUAocPh4wqqLImHZ3Vu5EVl3TGd+TrQZ5tLXyyOvwyXXmTj+0xUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7007
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--25.070400-8.000000
X-TMASE-MatchedRID: dL10VBB8yoenykMun0J1wmjZ8q/Oc1nAYefZ7F9kLgsNcckEPxfz2OLB
	DcjMHcx7UmsNbSHn8eC6zbhlzid4ETT7rmcnNv1sGVyS87Wb4ly94JvJnfFrHgZbeEWcL03VxW1
	hpE4d75MBtPOmmKHFMe1wOkAIhUvIIaVPgU+koVFHL73iZZtH5hPVHMMzH1WY0pHDCyZ4ZZwGb+
	Ypk3XX32ecENAzQnFW3Q6t2kvlmv5NzXckEGP5NFu4M/xm4KZeDZprldOqlhY3XlVVGX0OkR2Yl
	IfD257qjopcgE+WIdQZ6nuQ5u+kQwq8jvPeX6492OSj4qJA9QagBWRVHG2+kbDUHYVkjKWEfoKq
	eUCVpC25hm/MC4Uy/wTlbNtY2Qg0LnAOxJZg0/2JQ9k+Ypk5CdFqG4/BpDVaE1xmZGbPGMJ7+uS
	QIU88H0kRJxQmJRMtjwcsoUSVK5sd6KvWfwuK0umc4/pDEQa2UAjrAJWsTe9m7Osd7G4BJq+O3p
	9xFzgDjl8ljwBdnIgBKjVc0+Gs+raFzPn1CONWA9lly13c/gH0O7M3lSnTW5soi2XrUn/J+ZL5o
	+vRV7yhMIDkR/KfwLkblkrgCLv43QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.070400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	50AA8EC6FEA978D0EE029B34B7FB0AFAB16C5167A4C97574F54FAA17E343B5142000:8

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBUdWUsIDIwMjQtMDQt
MzAgYXQgMTE6MzkgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAzMC8wNC8yNCAxMDozOSwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gV2hlbiB3ZSBy
dW4ga2VybmVsIHdpdGggbG9ja2RlYnVnIG9wdGlvbiwgd2Ugd2lsbCBnZXQgdGhlIEJVRw0KPiA+
IGJlbG93Og0KPiA+IFsgIDEwNi42OTIxMjRdIEJVRzogc2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVk
IGZyb20gaW52YWxpZCBjb250ZXh0DQo+ID4gYXQgZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUu
YzoxMTY0DQo+ID4gWyAgMTA2LjY5MjE5MF0gaW5fYXRvbWljKCk6IDEsIGlycXNfZGlzYWJsZWQo
KTogMTI4LCBub25fYmxvY2s6IDAsDQo+ID4gcGlkOiAzNjE2LCBuYW1lOiBrd29ya2VyL3UxNzoz
DQo+ID4gWyAgMTA2LjY5MjIyNl0gcHJlZW1wdF9jb3VudDogMSwgZXhwZWN0ZWQ6IDANCj4gPiBb
ICAxMDYuNjkyMjU0XSBSQ1UgbmVzdCBkZXB0aDogMCwgZXhwZWN0ZWQ6IDANCj4gPiBbICAxMDYu
NjkyMjgyXSBJTkZPOiBsb2NrZGVwIGlzIHR1cm5lZCBvZmYuDQo+ID4gWyAgMTA2LjY5MjMwNl0g
aXJxIGV2ZW50IHN0YW1wOiAwDQo+ID4gWyAgMTA2LjY5MjMzMV0gaGFyZGlycXMgbGFzdCAgZW5h
YmxlZCBhdCAoMCk6IFs8MDAwMDAwMDAwMDAwMDAwMD5dDQo+ID4gMHgwDQo+ID4gWyAgMTA2LjY5
MjM3Nl0gaGFyZGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoMCk6IFs8ZmZmZmZmZWUxNWQzN2ZhMD5d
DQo+ID4gY29weV9wcm9jZXNzKzB4YzkwLzB4MmFjMA0KPiA+IFsgIDEwNi42OTI0MjldIHNvZnRp
cnFzIGxhc3QgIGVuYWJsZWQgYXQgKDApOiBbPGZmZmZmZmVlMTVkMzdmYzQ+XQ0KPiA+IGNvcHlf
cHJvY2VzcysweGNiNC8weDJhYzANCj4gPiBbICAxMDYuNjkyNDczXSBzb2Z0aXJxcyBsYXN0IGRp
c2FibGVkIGF0ICgwKTogWzwwMDAwMDAwMDAwMDAwMDAwPl0NCj4gPiAweDANCj4gPiBbICAxMDYu
NjkyNTEzXSBDUFU6IDEgUElEOiAzNjE2IENvbW06IGt3b3JrZXIvdTE3OjMgTm90IHRhaW50ZWQN
Cj4gPiA2LjEuODctbG9ja2RlcC0xNDEzMy1nMjZlOTMzYWNhNzg1ICMxDQo+ID4gNjgzOTk0MmUx
Y2YzNDkxNGIwYTM2NjEzNzg0M2RkMjM2NmY1MmFhOQ0KPiA+IFsgIDEwNi42OTI1NTZdIEhhcmR3
YXJlIG5hbWU6IEdvb2dsZSBDaXJpIHNrdTAvdW5wcm92aXNpb25lZCBib2FyZA0KPiA+IChEVCkN
Cj4gPiBbICAxMDYuNjkyNTg2XSBXb3JrcXVldWU6IGltZ3N5c19ydW5uZXIgaW1nc3lzX3J1bm5l
cl9mdW5jDQo+ID4gWyAgMTA2LjY5MjYzOF0gQ2FsbCB0cmFjZToNCj4gPiBbICAxMDYuNjkyNjYy
XSAgZHVtcF9iYWNrdHJhY2UrMHgxMDAvMHgxMjANCj4gPiBbICAxMDYuNjkyNzAyXSAgc2hvd19z
dGFjaysweDIwLzB4MmMNCj4gPiBbICAxMDYuNjkyNzM3XSAgZHVtcF9zdGFja19sdmwrMHg4NC8w
eGI0DQo+ID4gWyAgMTA2LjY5Mjc3NV0gIGR1bXBfc3RhY2srMHgxOC8weDQ4DQo+ID4gWyAgMTA2
LjY5MjgwOV0gIF9fbWlnaHRfcmVzY2hlZCsweDM1NC8weDRjMA0KPiA+IFsgIDEwNi42OTI4NDdd
ICBfX21pZ2h0X3NsZWVwKzB4OTgvMHhlNA0KPiA+IFsgIDEwNi42OTI4ODNdICBfX3BtX3J1bnRp
bWVfcmVzdW1lKzB4NzAvMHgxMjQNCj4gPiBbICAxMDYuNjkyOTIxXSAgY21kcV9tYm94X3NlbmRf
ZGF0YSsweGU0LzB4YjFjDQo+ID4gWyAgMTA2LjY5Mjk2NF0gIG1zZ19zdWJtaXQrMHgxOTQvMHgy
ZGMNCj4gPiBbICAxMDYuNjkzMDAzXSAgbWJveF9zZW5kX21lc3NhZ2UrMHgxOTAvMHgzMzANCj4g
PiBbICAxMDYuNjkzMDQzXSAgaW1nc3lzX2NtZHFfc2VuZHRhc2srMHgxNjE4LzB4MjIyNA0KPiA+
IFsgIDEwNi42OTMwODJdICBpbWdzeXNfcnVubmVyX2Z1bmMrMHhhYy8weDExYw0KPiA+IFsgIDEw
Ni42OTMxMThdICBwcm9jZXNzX29uZV93b3JrKzB4NjM4LzB4Zjg0DQo+ID4gWyAgMTA2LjY5MzE1
OF0gIHdvcmtlcl90aHJlYWQrMHg4MDgvMHhjZDANCj4gPiBbICAxMDYuNjkzMTk2XSAga3RocmVh
ZCsweDI0Yy8weDMyNA0KPiA+IFsgIDEwNi42OTMyMzFdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgy
MA0KPiA+IA0KPiA+IFdlIGZvdW5kIHRoYXQgdGhlcmUgaXMgYSBzcGluX2xvY2tfaXJxc2F2ZSBw
cm90ZWN0aW9uIGluDQo+ID4gbXNnX3N1Ym1pdCgpDQo+ID4gb2YgbWFpbGJveC5jLg0KPiA+IFNv
IHdoZW4gY21kcSBkcml2ZXIgY2FsbHMgcG1fcnVudGltZV9nZXRfc3luYygpIGluDQo+ID4gY21k
cV9tYm94X3NlbmRfZGF0YSgpLA0KPiA+IGl0IHdpbGwgZ2V0IHRoaXMgQlVHIHJlcG9ydC4NCj4g
PiANCj4gPiBBZGQgcG1fcnVudGltZV9pcnFfc2FmZSgpIHRvIGxldCBwbV9ydW50aW1lIGNhbGxi
YWNrcyBpcyBzYWZlIGluDQo+ID4gYXRvbWljDQo+ID4gY29udGV4dCB3aXRoIGludGVycnVwdHMg
ZGlzYWJsZWQuDQo+ID4gDQo+IA0KPiBJIHNlZS4gVGhlIHByb2JsZW0gd2l0aCB0aGlzIGlzIHRo
YXQgcG1fcnVudGltZV9pcnFfc2FmZSgpIHdpbGwgcmFpc2UNCj4gdGhlIHJlZmNvdW50DQo+IG9m
IHRoZSBwYXJlbnQgZGV2aWNlICJmb3JldmVyIiwgd2hpY2ggaXNuJ3QgdGhlIGJlc3QgYW5kIHBh
cnRpYWxseQ0KPiBkZWZlYXRzIHdoYXQgd2UNCj4gYXJlIHRyeWluZyB0byBkbyBoZXJlIChrZWVw
aW5nIHN0dWZmIG9mZiB1bmxlc3MgcmVhbGx5IG5lZWRlZCkuDQo+IA0KPiBBdCB0aGlzIHBvaW50
IEkgd29uZGVyIGlmIGl0J2QgYmUganVzdCBiZXR0ZXIgdG8gcmVhbGx5IGZpeCB0aGlzDQo+IGlu
c3RlYWQgb2Ygd29ya2luZw0KPiBhcm91bmQgdGhlIHByb2JsZW0uDQo+IA0KPiBJJ2Qgc2F5IHRo
YXQgb25lIG9mIHRoZSBvcHRpb25zIHdvdWxkIGJlIHRvIHBlcmZvcm0gYSBjaGFuZ2UgdG8NCj4g
bXNnX3N1Ym1pdCgpIHNvDQo+IHRoYXQgaXQgd2lsbCB0YWtlIGludG8gYWNjb3VudCB0aGF0IGEg
LnNlbmRfZGF0YSgpIGNhbGxiYWNrIG1pZ2h0IGJlDQo+IHVzaW5nIFJQTQ0KPiBmdW5jdGlvbnMu
DQo+IA0KPiBJZGVhcz8gOi0pDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KPiANCg0KQXMgSmFz
c2kgbWVudGlvbmVkLCAuc2VuZF9kYXRhKCkgY2FuIG5vdCB1c2Ugc2xlZXAsIHNvIHdlIGNhbiBu
b3QgdXNlDQpwbV9ydW50aW1lX2dldF9zeW5jKCkgaW4gY21kcV9tYm94X3NlbmRfZGF0YSgpLg0K
DQpCZWNhdXNlIHdlIGhhdmUgdG8gbWFrZSBzdXJlIHRoZSBjbG9ja3MgaXMgZW5hYmxlZCBiZWZv
cmUgc2V0dGluZyBHQ0UNCnJlZ2lzdGVycyBpbnNpZGUgdGhlIGNtZHFfbWJveF9zZW5kX2RhdGEo
KS4gSSB0aGluayB3ZSBjYW4ndCB1c2UgdGhlDQpBU1lOQyBwbV9ydW50aW1lX2dldCgpIGluc3Rl
YWQgb2YgcG1fcnVudGltZV9nZXRfc3luYygpIGVpdGhlci4NCg0KQW5kIHlvdSdyZSByaWdodCwg
SSBkaWRuJ3Qgbm90aWNlIHRoYXQgcmFpc2luZyB0aGUgaXJxX3NhZmUgZmxhZyB3aWxsDQptYWtl
IHRoZSBwYXJlbnQgZGV2aWNlIGNhbiBub3QgYmUgc3VzcGVuZGVkLg0KDQpIb3cgYWJvdXQgdGhp
czoNCjEuIFVzZSBjbGtfYmx1a19lbmFibGUoKSArIHBtX3J1bnRpbWVfZ2V0KCkgaW5zdGVhZCBv
ZiANCnBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBldmVyeXdoZXJlIGluIG10ay1jbWRxLW1haWxib3gu
Yy4NCg0KMi4gVXNlIHJlZmNvdW50KysgaW5zdGVhZCBvZiBjbGtfYmx1a19lbmFibGUoKSBpbg0K
Y21kcV9ydW50aW1lX3Jlc3VtZSgpLg0KDQozLiBDYWxsIGNsa19ibHVrX2Rpc2FibGUoKSB3aGVu
IHJlZmNvdW50ID4gMCBpbiBjbWRxX3J1bnRpbWVfc3VzcGVuZCgpLg0KDQpJcyB0aGlzIGFuIG9w
dGlvbj8NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+ID4gRml4ZXM6IDhhZmU4MTZiMGM5
OSAoIm1haWxib3g6IG10ay1jbWRxLW1haWxib3g6IEltcGxlbWVudCBSdW50aW1lDQo+ID4gUE0g
d2l0aCBhdXRvc3VzcGVuZCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNv
bi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tYWlsYm94L210
ay1jbWRxLW1haWxib3guYyB8IDEgKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMNCj4gPiBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiBpbmRl
eCBlYWQyMjAwZjM5YmEuLjNiNGYxOTYzM2M4MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1j
bWRxLW1haWxib3guYw0KPiA+IEBAIC02OTQsNiArNjk0LDcgQEAgc3RhdGljIGludCBjbWRxX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gPiAqcGRldikNCj4gPiAgIA0KPiA+ICAgCXBt
X3J1bnRpbWVfc2V0X2F1dG9zdXNwZW5kX2RlbGF5KGRldiwNCj4gPiBDTURRX01CT1hfQVVUT1NV
U1BFTkRfREVMQVlfTVMpOw0KPiA+ICAgCXBtX3J1bnRpbWVfdXNlX2F1dG9zdXNwZW5kKGRldik7
DQo+ID4gKwlwbV9ydW50aW1lX2lycV9zYWZlKGRldik7DQo+ID4gICANCj4gPiAgIAlyZXR1cm4g
MDsNCj4gPiAgIH0NCj4gDQo+IA0KPiANCg==

