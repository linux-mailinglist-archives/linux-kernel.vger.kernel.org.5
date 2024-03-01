Return-Path: <linux-kernel+bounces-88606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1255486E415
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31AE11C21DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04B26E2BD;
	Fri,  1 Mar 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dnoVt7ID";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="a8uwyFdn"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88125622;
	Fri,  1 Mar 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305954; cv=fail; b=Rij/BqIRGmoabyH1uOZT+5sHgg5MKmnQla6oeyE8/vd8mfcrquBRcnFmqynjNlkAK4ENiic6IzaXhj0QAq5s6vqMYOy+nbx54Y2CmO4zChM71lYb/xCq3oWcKCT94RJGxN30MHQGl7KIzSzhtoaqUopzzgczNA5cWG2UQmzlqm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305954; c=relaxed/simple;
	bh=IZUR4MyqRKiOvrqP/zVjb0oSt5npYT/jGrlpJcuxHvo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sPD5TsMCjbyzKKerxrJyiEKbC+esVTFWNbU7YLoI9uKfc/nHBDO4AXI6oDib/W1X0cb6UOtw5CqqH1B8NGC/yyg3hJ7Uv8+2syzWTbqTfJHpHTCSZfHxt3UDuuphJWLla7uEDLGDZux0yQDij9pZguw4ESDJEheNPs3quuH82pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dnoVt7ID; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=a8uwyFdn; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1df943b8d7de11eeb8927bc1f75efef4-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=IZUR4MyqRKiOvrqP/zVjb0oSt5npYT/jGrlpJcuxHvo=;
	b=dnoVt7IDFApCGwqs84NdJ5qZ71Q2YyMSZ5EXLSu3hYiXtfqot3CNdOLjClPrcRDIGbaVVaU9LbGjh8v20HXeRK/38mdCWrKCk+NA/yJjfQU+ONg4brhaVQUpCCiBRJ64tyWzl8uFpFVS2IKxMl+uu+We1ZARS+uknjDcSzY4wXk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a2fb74b0-9f62-40eb-a297-db7a7f984288,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:7f6be88f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1df943b8d7de11eeb8927bc1f75efef4-20240301
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1912379308; Fri, 01 Mar 2024 23:12:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 23:12:26 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 23:12:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTnoCllAr8vBZt0CtHR/2SmCJRDWFJ5iFC1pMk1Og0+13aHnH+MsUw0fninpF0r6FOXTiQIPluk5/qyU/Lo2Kd+LJk3gO0alKJG+RUbbk7+h435kzxpw/Qqfg62FR4EzQRb8YxJxAcjhOTCKXFhYjcXKcdrhNfP4+aFCSlGxx53F8/lCqeMBYq9kBGf/6frKLeKKLKlXOz+udwG/MBTH9EB18mRldztP2iKPKydJ/D90jzua2vbgBkvkktaRHflhUyRg66M4bNGbCIotEg8pMPpo0Vi2QjP9GEsYVCOckJIPlo4noJQ3/6ANgiL857vbfYnQlJAgKMcIf/+DUr044A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZUR4MyqRKiOvrqP/zVjb0oSt5npYT/jGrlpJcuxHvo=;
 b=JCveFP9VP3uzQDPduMkA5+lkoE4xsKf1d6cbbYq8bUvsr/VFGulyQ3tYKGUqdhRI6pKFytSHGqphzKPmUITxVdK/BurDPZ4nDyFloIVuSQq2s0/ppSWg3nqHsraJRCtfvHDbmyNtMXdPoFyZ8ERzRm9jsoQivRVmyA/ZPqo+pJpzlqBVtMpPS8bVTvAyR2VzLdNInqr9z8mPKprNS1T1zT+OFU3ZiMII3PAyVYZXSo13w000ZHdp8UEee0JkRAXiL8yHPusDIXQVp4gcgSa/NrczNVy1aZX97YsjAY/lw+7z95hqbYvIRlXu2v0wHOycgEL1/GtJJA0zdtrvizBYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZUR4MyqRKiOvrqP/zVjb0oSt5npYT/jGrlpJcuxHvo=;
 b=a8uwyFdnKEEPslr21daQrh/MTEGuhb/Kw/rXewJjuN6thlIefYla/TpcgAwWEyreZYW2jg+L6cu0eqnNniI5uqPFAs4+3bU2C6N6a0FDCMhtXH0q2hnknEbyJ+tDUPkXP68rDusgHffr3TOkpFHcJ2peoaROjVjI1cozFqzPKB0=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by JH0PR03MB8667.apcprd03.prod.outlook.com (2603:1096:990:91::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Fri, 1 Mar
 2024 15:12:24 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 15:12:24 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "fw@strlen.de" <fw@strlen.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "pablo@netfilter.org" <pablo@netfilter.org>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: [PATCH net v2] netfilter: Add protection for bmp length out of range
Thread-Topic: [PATCH net v2] netfilter: Add protection for bmp length out of
 range
Thread-Index: AQHaa+rdzH5Tz/8ipEqlkF6sbjThfg==
Date: Fri, 1 Mar 2024 15:12:24 +0000
Message-ID: <d2b63acc5cd76db46132eb6ebd106f159fc5132d.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|JH0PR03MB8667:EE_
x-ms-office365-filtering-correlation-id: 22fe3f85-c2f9-4397-bb0c-08dc3a02001f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gCmwC7CmLsiXBdCBRKzdR4WjJIndjvELigEhKISsxNuTA1A2vMtVWxSPDTOYAQLUmCDLckl4SMNAJpoUDyiyz9BOyYvoxki8IDTk4CJvcx+1IvQaRBS4PdINKRikhEv92wIE/GyQ1UypRKBLw/UuvWrjTFQEpfNGTmcG+LxYfxhGvKrwtA9RPodzf+Pn/0+oaDyJXktTGHwp1PEx5Yf7WVJlkM+2Ln3HZRMj82kIEpvPTMQb+vmHPUrdrZWt48D7+x7w3Cj7+Bm/TIRtbO/r4wakeJiX/Il/mhn49pot32dp+c+19gHuTGM2zGfEJOMF9Ada0bHnaHc13vfd5f5IqT1pjtq6iBO1VtUrAA2pYiqY/e3fKmIeeKj8PJMnKFtktCQ8VJkeql+KvZMeGtkTXBNnMocBxSy1UhPbPwf6sC0BmdnMF6vQ6E+zAIMoYQhjsGqTN+PIOv8amiObdpOTrSC39y+yUXz7idW99go0a60nQgobUgJoHVsP+bMmYSXX6VCArjheUR0U0V84khGqZOdwj0NCNaomg93LKit0/Mneasmhy7zbHXu2y2LUsw+q/Tx/TlQV3poZUHByxrYxQQV6XOm6NcPqHjaSOzcIoobpCNEu0BuCRCm/tC8S00ZWm2F9p4Zej7WFavCTv6EON9tTrcDoYtQMAI451Jt7uI9p0tohDBNfosavcmNSv8SGa6wzbx3D3dfkzu+GW23fsdPCoDE7OmkcA9QjVfpPWAw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVVrOVVkSm9nN3Vyam1ZY0pSUVk4aEdXc2s0NkRuZkZUVTIwbGlFYUtvTjh5?=
 =?utf-8?B?emoyQzQ0Z3NRUDgvY28vUlZBOUdNeVVpRmE2N0dEbFhRaTJRWFVvckxxUWdE?=
 =?utf-8?B?TWpjWi9rcWpmcjFMaXZKN1gvbWlmMk1qcVBLblE5SXdzd0JpZ0psbnJ5MGph?=
 =?utf-8?B?WU9LSUlkdG4xUm9sNzIyNlQ2R0NNRXFBendnNHVLcTFVZVZRU0FKbXdnbEY0?=
 =?utf-8?B?Q09FeTdYbGVNSFZxWUcycHpLRUFzLzc4QnE4L2JlMU1Fci8rb3ZoTWhuMUlM?=
 =?utf-8?B?K0dKWlBBcE83U1VVazVNbnJpK1RmT25Jdm4wc0hiR3hteUdDcFFuVVIrdjhU?=
 =?utf-8?B?TVYvZS9KYUpHNW5PWGczREJXWDQrS2xwV04yQ3lMdWxBbjB3Wk9UUmVjdlhR?=
 =?utf-8?B?dGgrYkRiZzM5WGxpdTdUNVdOSWdmWVVLcUZWVS9XUC85SmFpTm83Zjl3Y3hE?=
 =?utf-8?B?c1pZRWtJUFpnMXNXYUVBcDg5UDVDNGticStOSTh5ekRaNTV2MGNHTjFtR3pB?=
 =?utf-8?B?cHhDQThoSGFvV3l6Vm83UjM5Vm9BUmdCd2F0RFdRaDRKOVErUXRVaEVpT08r?=
 =?utf-8?B?enBZajIzY0NHaFFCSndQbS9BbEI4TWIvSjUzUkJ4QVV4Q2ViSWQ5cjZEbnh5?=
 =?utf-8?B?MXdVa1IyOWN5UGF3OXJoR2gvSVU0RTA1b3JIcUNISXphSFV5dU56L0hXTGhp?=
 =?utf-8?B?YldoSkUyR0J1SjZlN0lYdVFQbnZyaHZ6bkxQZW5wWFVWN3Z0c0RTQmlpbkJX?=
 =?utf-8?B?N2NuM0ozMnhPSGV0NFd6VU1zN1g2WElpRVhHV1VMbXBkMTNnMmo4bE00TEtF?=
 =?utf-8?B?cjNabGVzWEFrekl5NmxSMzFXLzZzRnM3d1diWkJJQ2VFcTlxWHBrdzI0Nmto?=
 =?utf-8?B?b2FDOHhZN2IzYVFaK2NlUGo0MWw0bityYU11L1dzN3dKaXNHUWJRL2RaNC9u?=
 =?utf-8?B?eXduWFZCRkhPVHFzdmd4bUNJU1ZxQS9nbS85QSt6WFdzTmM1NUVWWEl2MVJ3?=
 =?utf-8?B?V3RINzdCeXkzeExVYkVqTzVhZ2V2SXE3RzF5ZzlKdTJDb1AzVEFKWWxrVGpQ?=
 =?utf-8?B?VXpqZS90L3Y4N0wxOVpjYVdxbVV0b2QyUFdqaWx0NVNVVmhQMG5Mc01PRmtv?=
 =?utf-8?B?eUVnbm5VNVpySnRqd1Q5SWp5WUwybnd5eFQ3TUhGWnhXSkplY2dzc2lmSHgr?=
 =?utf-8?B?UWZhYUlJd3RYcVp2RG8rQjFwL0M0Vm5pNDNkdjAzclVvUk1obkVVcTlSV3M0?=
 =?utf-8?B?Q1FLY3oxem8yT2ZwMmN4N1VtZ3dvVW1sbkRRanZHVXpjWERwM0pJT2E2amRv?=
 =?utf-8?B?VmZxMVRWM0J0bm5UZ2oxQktZRXJsemtFNEFSc2lqTnJDWTJHdHpBSWUvcm5r?=
 =?utf-8?B?YmxOdUxnOUxYRk9QQ3VZb2tzUlhiQ2VhYXBxRjIrRkk5SDFKMDhkdUIrS05t?=
 =?utf-8?B?ZGF5a0lYR1liZFBCQVZ4cVRZSlJpYjUzSVA2eVVkWXJBTjkya3VsWjFTcjg4?=
 =?utf-8?B?Y1VIbk9maUVXckMvOTNoekpNWStDaVVpQzB0dFZGVU1pSUZvR1BvRGZyWGdM?=
 =?utf-8?B?QjczZW4yK2xKTUx4S1NPNHRXcXFpd1ZvRURTZXVLQzdwcGg0YzVMNUJISUFU?=
 =?utf-8?B?Q1E1SGhTd25XRFloRzVNeHB5Nmg4c25JZklySFI2M1lMYm9YQnZmVmdURXNv?=
 =?utf-8?B?MmsxTzA3M21ScVUvTmNKeUtkSytVeHUwbXA4cE84d0UvaTM4TXpUVUdYd21J?=
 =?utf-8?B?RGFyb3E2d0lLT05MSUJiQTAwb2kyVFpKTmZqV290VzMxeEJObjE5eHFxWGFx?=
 =?utf-8?B?MjhiMHpEd2ZDR0xQSE5TK0tyZ3JQM000YkxJS3FmYTNvdnBFUWJUSlhZcU4x?=
 =?utf-8?B?bkwyYTRhUC90S1FsU3ZudStQa0JrMEtlb2lxelIzd2dvWGFsSUNCNGFOaXZC?=
 =?utf-8?B?NTJMQlZCK2gxMlB4eS81YzRNQ1kySmZuSzNJK05lVG9xVmQzTmtpM3d2RGJs?=
 =?utf-8?B?TVJuM2JHYzVZY1NyNzNyb3BlNVhtZXZDM2dPS244MHd1Zi9VNTRjaW1YbFVZ?=
 =?utf-8?B?M0JNWFRZY2JLQU5jWWxGQTUwUzYxbHFJUTB4MGxpdklyZk1JMTZnaWlBQ1ln?=
 =?utf-8?B?Q0l2NXhoZ0hzWDUzbk0zOGVSVGlEemVrbkgvY0tKcm5EanRNTGhlY3plcFNF?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58EC96C7AF4993409323F1161E908462@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fe3f85-c2f9-4397-bb0c-08dc3a02001f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 15:12:24.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +49DUi/B2zXFowf9QvbEATGncTfLvbfNDGL2Kn9gZuvDL33UeiAL9rnbrUj2ZNxmpRL6QjitzibCQLHqygOW+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8667
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.079800-8.000000
X-TMASE-MatchedRID: cWqVi5YGo5wIAPmAuSvJ8Yzb2GR6Ttd3X5TqQagR07dLBxm1Vv3RsJ93
	TfvULFt2/5f0y/6L/68GwOiwlwYHMkeBpfM21lfTmsge4JmkzOX/wK4D5v9hhLIPyqeQTeKk0nE
	XIG9RfVfgRfDXjOa2sgN6C4LgNZr9EJHpQ2Y9lUQD2WXLXdz+Ae3+iQEtoSj4hj0Um3z4RXl18v
	vd24eboroaAxIVVU84kZOl7WKIImrS77Co4bNJXQtuKBGekqUpbGVEmIfjf3te9apuqjZI/X8It
	2Uf4xrQeAvJK1GayvDGMaxYwdXC1VGkx04md/ow
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.079800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	27A67240241F6D061C0090B4B511A7A6468764F22637FE828506653D67D770242000:8

RnJvbTogTGVuYSBXYW5nIDxsZW5hLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpVQlNBTiBsb2FkIHJl
cG9ydHMgYW4gZXhjZXB0aW9uIG9mIEJSSyM1NTE1IFNISUZUX0lTU1VFOkJpdHdpc2Ugc2hpZnRz
DQp0aGF0IGFyZSBvdXQgb2YgYm91bmRzIGZvciB0aGVpciBkYXRhIHR5cGUuDQoNCnZtbGludXgg
ICBnZXRfYml0bWFwKGI9NzUpICsgNzEyDQo8bmV0L25ldGZpbHRlci9uZl9jb25udHJhY2tfaDMy
M19hc24xLmM6MD4NCnZtbGludXggICBkZWNvZGVfc2VxKGJzPTB4RkZGRkZGRDAwODAzNzAwMCwg
Zj0weEZGRkZGRkQwMDgwMzcwMTgsDQpsZXZlbD0xMzQ0NDMxMDApICsgMTk1Ng0KPG5ldC9uZXRm
aWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jOjU5Mj4NCnZtbGludXggICBkZWNvZGVfY2hv
aWNlKGJhc2U9MHhGRkZGRkZEMDA4MDM3MEYwLCBsZXZlbD0yMzg0MzYzNikgKyAxMjE2DQo8bmV0
L25ldGZpbHRlci9uZl9jb25udHJhY2tfaDMyM19hc24xLmM6ODE0Pg0Kdm1saW51eCAgIGRlY29k
ZV9zZXEoZj0weEZGRkZGRkQwMDgwMzcxQTgsIGxldmVsPTEzNDQ0MzUwMCkgKyA4MTINCjxuZXQv
bmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX2FzbjEuYzo1NzY+DQp2bWxpbnV4ICAgZGVjb2Rl
X2Nob2ljZShiYXNlPTB4RkZGRkZGRDAwODAzNzI4MCwgbGV2ZWw9MCkgKyAxMjE2DQo8bmV0L25l
dGZpbHRlci9uZl9jb25udHJhY2tfaDMyM19hc24xLmM6ODE0Pg0Kdm1saW51eCAgIERlY29kZVJh
c01lc3NhZ2UoKSArIDMwNA0KPG5ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5j
OjgzMz4NCnZtbGludXggICByYXNfaGVscCgpICsgNjg0DQo8bmV0L25ldGZpbHRlci9uZl9jb25u
dHJhY2tfaDMyM19tYWluLmM6MTcyOD4NCnZtbGludXggICBuZl9jb25maXJtKCkgKyAxODgNCjxu
ZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19wcm90by5jOjEzNz4NCg0KRHVlIHRvIGFibm9ybWFs
IGRhdGEgaW4gc2tiLT5kYXRhLCB0aGUgZXh0ZW5zaW9uIGJpdG1hcCBsZW5ndGgNCmV4Y2VlZHMg
MzIgd2hlbiBkZWNvZGluZyByYXMgbWVzc2FnZS4gVGhlbiBnZXRfYml0bWFwIHVzZXMgdGhlDQps
ZW5ndGggdG8gbWFrZSBhIHNoaWZ0IG9wZXJhdGlvbi4gSXQgd2lsbCBjaGFuZ2UgaW50byBuZWdh
dGl2ZQ0KYWZ0ZXIgc2V2ZXJhbCBsb29wLg0KDQpVQlNBTiBsb2FkIGNhbiBkZXRlY3QgYSBuZWdh
dGl2ZSBzaGlmdCBhcyBhbiB1bmRlZmluZWQgYmVoYXZpb3VyDQphbmQgcmVwb3J0cyBhbiBleGNl
cHRpb24uDQoNClNvIHdlIHNob3VsZCBhZGQgdGhlIHByb3RlY3Rpb24gdG8gYXZvaWQgdGhlIGxl
bmd0aCBleGNlZWRpbmcgMzIuDQpJZiBpdCBleGNlZWRzIGl0IHdpbGwgcmV0dXJuIG91dCBvZiBy
YW5nZSBlcnJvciBhbmQgc3RvcCBkZWNvZGluZw0KcmFzIG1lc3NhZ2UuDQoNClNpZ25lZC1vZmYt
Ynk6IExlbmEgV2FuZyA8bGVuYS53YW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjI6DQogIC0gYWRk
IGxlbmd0aCBwcm90ZWN0b24gZm9yIGFub3RoZXIgZ2V0X2JpdG1hcCBjYWxsLg0KICAtIHVwZGF0
ZSBjb21taXQgbWVzc2FnZSB0byB0cmltIHN0YWNrdHJhY2UuDQotLS0NCi0tLQ0KIG5ldC9uZXRm
aWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jIHwgNCArKysrDQogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L25ldGZpbHRlci9uZl9jb25udHJh
Y2tfaDMyM19hc24xLmMNCmIvbmV0L25ldGZpbHRlci9uZl9jb25udHJhY2tfaDMyM19hc24xLmMN
CmluZGV4IGU2OTdhODI0YjAwMS4uNTQwZDk3NzE1YmQyIDEwMDY0NA0KLS0tIGEvbmV0L25ldGZp
bHRlci9uZl9jb25udHJhY2tfaDMyM19hc24xLmMNCisrKyBiL25ldC9uZXRmaWx0ZXIvbmZfY29u
bnRyYWNrX2gzMjNfYXNuMS5jDQpAQCAtNTMzLDYgKzUzMyw4IEBAIHN0YXRpYyBpbnQgZGVjb2Rl
X3NlcShzdHJ1Y3QgYml0c3RyICpicywgY29uc3QNCnN0cnVjdCBmaWVsZF90ICpmLA0KIAkvKiBH
ZXQgZmllbGRzIGJpdG1hcCAqLw0KIAlpZiAobmZfaDMyM19lcnJvcl9ib3VuZGFyeShicywgMCwg
Zi0+c3opKQ0KIAkJcmV0dXJuIEgzMjNfRVJST1JfQk9VTkQ7DQorCWlmIChmLT5zeiA+IDMyKQ0K
KwkJcmV0dXJuIEgzMjNfRVJST1JfUkFOR0U7DQogCWJtcCA9IGdldF9iaXRtYXAoYnMsIGYtPnN6
KTsNCiAJaWYgKGJhc2UpDQogCQkqKHVuc2lnbmVkIGludCAqKWJhc2UgPSBibXA7DQpAQCAtNTg5
LDYgKzU5MSw4IEBAIHN0YXRpYyBpbnQgZGVjb2RlX3NlcShzdHJ1Y3QgYml0c3RyICpicywgY29u
c3QNCnN0cnVjdCBmaWVsZF90ICpmLA0KIAlibXAyX2xlbiA9IGdldF9iaXRzKGJzLCA3KSArIDE7
DQogCWlmIChuZl9oMzIzX2Vycm9yX2JvdW5kYXJ5KGJzLCAwLCBibXAyX2xlbikpDQogCQlyZXR1
cm4gSDMyM19FUlJPUl9CT1VORDsNCisJaWYgKGJtcDJfbGVuID4gMzIpDQorCQlyZXR1cm4gSDMy
M19FUlJPUl9SQU5HRTsNCiAJYm1wMiA9IGdldF9iaXRtYXAoYnMsIGJtcDJfbGVuKTsNCiAJYm1w
IHw9IGJtcDIgPj4gZi0+c3o7DQogCWlmIChiYXNlKQ0KLS0gDQoyLjE4LjANCg==

