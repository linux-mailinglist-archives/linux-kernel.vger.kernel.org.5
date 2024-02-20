Return-Path: <linux-kernel+bounces-72765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455E185B875
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF47E282741
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB7360DD2;
	Tue, 20 Feb 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bMI2QPxM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VOBOY/0I"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0CF60861;
	Tue, 20 Feb 2024 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423323; cv=fail; b=lh5H2N5ObUyiozFOmbABEfQmNobViGbEdFsFiysE5m3l9htROCU0OqStxmK0F1MQiQn8aPQn3VdOuZK4wn0UPH7DJT+oYeyvVW+UuD3nwFXDApZmvKw46ZunXN1MTjYdWONolGNjzqKGgdxTGg3oBL41pVlilAaIFQ+JVYkpCrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423323; c=relaxed/simple;
	bh=OcTCzZffNSVmSx1F1UINxJK0MrHnIpeoyYfInynm7U4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FA013/1JfcwWnFRNxDqeaOrCRZVZttGF+O1ZDxNzigowsSAzKjuzODDPMJOmwAUaehuxbaq4HIC160GDFDf1tdOq2gzblWOAJgr/XI/KqhcWle6hNK10UeN6iILMgOiGKmAUHJgP2Co4ECRHfNnQCsqYtRU5o9nqwAMNydIlFAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bMI2QPxM; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VOBOY/0I; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 14c62720cfd711eea2298b7352fd921d-20240220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=OcTCzZffNSVmSx1F1UINxJK0MrHnIpeoyYfInynm7U4=;
	b=bMI2QPxMbsW7ZVmyb3OjfZX2Itlc7v1X0Dic2BgSlUi8KsV83wfLoEt+hEk4ztZX48blXb8Tkho12cdbj0+JjPX0UBlBvcwf74zXR1ITDaJ0mnNPUcF7zh2QOjyXqrwME3RF84iWpDd8cgLTT9iYeJScy75DAZnH4cV4q2NBSgo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:771a7c96-f427-4ffc-b169-37d6eec82eb9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:9cba1984-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 14c62720cfd711eea2298b7352fd921d-20240220
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2147397978; Tue, 20 Feb 2024 18:01:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Feb 2024 18:01:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Feb 2024 18:01:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8PD0aD9LUYVjlUEAoH0H5PWnM1zaDwrw5EQznq6qRYJ9DSQngJxI0m5J6yseyay7uSOewGArE9lABsSB3CDiR+tyhR72ms/7na4mvTBnD12wBHXw7xKO84miXL3xKY0+JLRh3K1AQEAahzjKypY9+6ZfIrvgfH9v/RFU9EWOcrd2aZUZF5iFEncnz3oePLZNB+bWpKZqeov7dTaenDeVOmkFfoWmtY1+BrOqvnSyG5M+j7ltpaUIHAEwTkXScQVgCbPPDpq+vL7itk/VPS/7oQwA1WzF29WAObIeQVljI3KqidEeKdFLa0e4iJBcwTGVtY+7NaFpzVa/skTljoAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcTCzZffNSVmSx1F1UINxJK0MrHnIpeoyYfInynm7U4=;
 b=CYW5MGXSukLFUvBxZ3iid+L4CpboVwYVujDFRu0fMa2dXqTl/yfl9b2G3ay5NHTxeBL0llq+f/QoAQBQotLYrkxkV5V1RPzrcOc0dR3obPLf+1i6uzyqxgWTyDAMOLsIHptAJnJE4whS4sZ5xlgarD6JdeShEjBzM3OaONDB4LcNk+uPdbaHbYy7Cmn28vBioFZyDWOE9fRDOGBB+xrimRPv2STXU21T2DXsXFjPQBO/iYOXT60mPYObytKWWTrAL9BqBFvUvFtwoNdT5P4eR5ga1wlespR0fI8O4lFPzh/9HIWLI2fxDnBrS1J8PnC7It2Lem1JLVTHYL9enXQjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcTCzZffNSVmSx1F1UINxJK0MrHnIpeoyYfInynm7U4=;
 b=VOBOY/0IAJwLEZpuej4xvBOy4e4684gdf69wmGLtPjy47YY2g9pKoTXSqmAbix3Ywip8FAj/S1BalD9DUnwGeuvR2nhywN3JgYQmrynJ9AuBFDG4E2c3PQiQMvdkSi3PS/V7YWGZ8bc8h01Y2IGgDorluTFtrUXqc2nZp26VWu0=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by PSAPR03MB5432.apcprd03.prod.outlook.com (2603:1096:301:48::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 10:01:54 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea%2]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 10:01:54 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "fw@strlen.de" <fw@strlen.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "pablo@netfilter.org" <pablo@netfilter.org>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: [PATCH] Add protection for bmp length out of range
Thread-Topic: [PATCH] Add protection for bmp length out of range
Thread-Index: AQHaY+PUz/TFYaSdlUKuAtw8lP8Ajg==
Date: Tue, 20 Feb 2024 10:01:54 +0000
Message-ID: <f387b6098460f4da0f5ec24c1692190155863de4.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|PSAPR03MB5432:EE_
x-ms-office365-filtering-correlation-id: d28bd9d1-3941-4d22-feb6-08dc31faf752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWxWvfCe/j9AC3h8zB49MXuh272DU6fVDyYvWNcrkryILCA0Zl86twbiO5+1Wc3bn6F3bXEZGIfjcjfsY4aob3PkdoyQGN3+p+MicpArnPcjiFcEKH1kR5pCCaqNbnDetk6Vcyapn8Uisy2Qd11Ad87sQanCjxeAiYKaC5VHYzQSDLBqlovqXF5w7AZJNwKfHQz/O/1pbAlJHSk5y3dkE4LQP5v6O01dUu+K2QhmKfk4awkrQykq2mi6aaqDxiANWunfye3cJ1ct4nXG+VRLzD2m7v9KsGSeui1OGSe7KbN5iagcUZWIrFInc3YwTYDX9lLPiaGtVcM7qzca5q31oGvbE4gON346ud6QVYcibkQKq0VapAMfjgi8aSGzeQcojJuO/2tvudwAZHvItEP95WE33VOJ/+cGcv3iEAkQdq8s9/RZ8CKhwvpo5T+ht0Atea0Pmek0I5rx8ZDnDfTE9pu5jn84Ug8ZCG7XP9W2Aek5CGiKy/ZNpOESaGcAe8MsLiEmm1JI/8B8rMTnJxYMIjvEkVK4KkMI6R5/981rC0gVbM9893kPkkicjpp7duVfQLfFObJVhtu81FlX7zpBBSm1z7Eax9t0Lmolh/JKLqlZKleLWRxTFga29sQhmAST
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V25SRGNQV2hyb3EwSVNDaDA1VXBDRVpMS0dubDUvclo0bHVlWkpwMUlaUEMz?=
 =?utf-8?B?b2YxWE8wdFhsTHlPQlpQM0ZhbVU3Wi9PL1V1elU2TGdWTmlua3k1cTZYa3VK?=
 =?utf-8?B?WmsvMTFwVStmSU5zbFVUNWdyS3FDQ1VJSlBkYzI4RUlwVUFaVkFDemVyRUtl?=
 =?utf-8?B?S0hSSkpPYkNKTHI1Q01Od2J4dDlXdFI1aEhybGloT205eXluRGdpL1h2emhy?=
 =?utf-8?B?c3pHdHVreWN3b1pqSXo3UFhvRVZWdmE1Sk5Jb3dXNW9UVTlqeXhpVmJTekJX?=
 =?utf-8?B?NllueCtyS2dRaEtTblM3S1ZVQ1dFdVZNaVdBeTFzd0pNbG9hVm4wNFdUZmFN?=
 =?utf-8?B?OW51MHNBNFNqd2lRZDRrUXR3ZEwwa2dMWU56enlvQ2VKakZxZXIzUFFFTUNx?=
 =?utf-8?B?TURlUXcrK2JtRkpEQzUveGNKVklvSDZEeVdBVitZWEo0cDBGRzhOazdOZG1u?=
 =?utf-8?B?U1JjSXJTbTNFZW1acXppOUsvaXlhUU5Ldnl6WHlGYnZOK2Uwcm1QQ0NaaWhN?=
 =?utf-8?B?VXc4TWd5cGZYbGs5NyttNUdLRXhTbnMySjQ3NVpaN0N3UkYrdEtpNHh2MWlx?=
 =?utf-8?B?cVNxZTZWYlZ6ZVJHaWFmQU5oVUhienNaaytnRkFneDI0dzh4MjgwMDdTUDdr?=
 =?utf-8?B?RmhYbnRWL1RIOGRQSXdkcXNPRG13WDJWT2JzWHI2a1hLdjkwRHBCQ053bmNu?=
 =?utf-8?B?RDJrMGpPU2NzdXFmZmZUbERYSytWRmQ4MnhMOHlsZElYdE5FaTNQcHozdnFp?=
 =?utf-8?B?SVQ0MS9KTHBlL0tWdWJqK2RSeGQrSzd1L0NVZTgxUVlMQnNzTHVvcHFaZ1ZI?=
 =?utf-8?B?MjY0d0owRklKS1FWdGFIRjdyOE9Yb1BaWUNSbm9TZmhYc2JEUUxwa3lwbUY4?=
 =?utf-8?B?RElvcE5uc1JPOCtIMnl2d1l0UXJLcUNmZmIrNDZsNmRiQldyVitSOUJkcTI3?=
 =?utf-8?B?bUJ0UjA2UklCaFVSY2s5ZmkxTVgxMWVuUFV2Sjg4cGFQeW5qYkFmUzZ5VEo3?=
 =?utf-8?B?ZlpKenJCOFcxSk45ejNoSnI3N0JoOVdrWWVkQzExSW81K09rWkNvOUVFR1ZO?=
 =?utf-8?B?eVUxV0k1Tm9YcmRsVDRPT0VSVXVETkd4TGxueEppZ2R0M0RJWFN1aCtNRmdq?=
 =?utf-8?B?b3NZRXhSWFJhMks1UVA3RGtKNWtMS0VJVnFQYThmSU5LOWhwZ3liWG54Sjdp?=
 =?utf-8?B?UGQzVDNOZlcwU01rTGRncGN6eDdnbndLYllXaXBFUkZTQ1A0ajF0SHNvSFZk?=
 =?utf-8?B?czdRUEErOS9URVB6MTUzTlpwWldlK29KQ1dhSnZZZVpLUkg4S2JULzFSWCtC?=
 =?utf-8?B?eDJueXI0L3h3Yi9IMTQ1dlVvYzVjbzlKVXZKcnUxdjY1M0hDckJJS3FGMDBE?=
 =?utf-8?B?VlFtTUdzTi9uT3Nyc0JSTmRiSHhKLzZnUm5ST2NkMlU0SmNEekR3eDJCNnNS?=
 =?utf-8?B?NUd3emRVdjV5N3V1STFXTlhrRU1IR21HeG82cW1GejZDOWhjN1AwdUF4T0I3?=
 =?utf-8?B?cWllTFYxZTBXR2g2T2hDOXhWeFQ1Zm5yQUovbFRnUUdvV1Y2VFRYS3ZKRzYw?=
 =?utf-8?B?ZjVaazZNQSs3UkJUTUcyT0R0dzZGODFVaG9BUkFRcXpxdzRDbkpxSWdiYVYx?=
 =?utf-8?B?QmZFejdNaUU1RUVwZ0FZTmQ5cmloVnlZcTJtS2Zzam9ZdC9rNHpNNFRwTTdC?=
 =?utf-8?B?bUYrRkZ2TDRjS2FjdExXY1Y0YW9hSnBCL1c1TzdCZXcrVXRab1R2ODB6WElQ?=
 =?utf-8?B?TXUxT2VVR3FQSXNzYTcvZnJVM2xkc0pRbC9wYnhwbXY1SjdiODY0ZEtRLzZX?=
 =?utf-8?B?MVUwYU51b2VRZU5jRW94cm0yTVB0N0lRRkFJZVVsZkFwTkVUbXZ2SktvNC8z?=
 =?utf-8?B?aEwvcnpOODR0N25DNG01ckVYZWRLOHB2K29YbzRNNzJoYjV0c2pYRzRJR0Zw?=
 =?utf-8?B?U04yaXh3a3Q0cXVQalJ4YXBtTTJxajRXMFQzVmQrQjh1d2ZzRjd3TGZTMGJs?=
 =?utf-8?B?ZG4raEp6bGE4bURYV1BXUkpjRFpSVWNubUJXTmFnR2lSZFFldk14b050ajZ4?=
 =?utf-8?B?UVZXMjV1L2lBNzZzcWtOVlJhSW1hNzNvUmljY2dXeE9VdG9mU0xUL1k1NzFS?=
 =?utf-8?B?N2Q1aFAwMXlzN1RPaExuQTRxdEthelVNOVJzYUN5b2dzYTNnZWFmVXhPUWN2?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <209928C8C93C0E4EAE793C2E40F4D3D1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28bd9d1-3941-4d22-feb6-08dc31faf752
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 10:01:54.0314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNyeN6LWPoRqJkTIq0/NxMyZySa0oFR2MfkIBy/U7PP0BC+B9IaesvYx0ZQi2QKtN0hexXhB6/4DFac6FVi4mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5432

RnJvbSAzOWEwMDhjYzgwZTAzNzNlZDBjZmZkYzJmMjdkYWJhNTU5MmMyMDEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogbGVuYSB3YW5nIDxsZW5hLndhbmdAbWVkaWF0ZWsuY29tPg0K
RGF0ZTogVHVlLCAyMCBGZWIgMjAyNCAxNDowMDozMSArMDgwMA0KU3ViamVjdDogW1BBVENIXSBB
ZGQgcHJvdGVjdGlvbiBmb3IgYm1wIGxlbmd0aCBvdXQgb2YgcmFuZ2UNCg0KVUJTQU4gbG9hZCBy
ZXBvcnRzIGFuIGV4Y2VwdGlvbiBvZiBCUksjNTUxNSBTSElGVF9JU1NVRTpCaXR3aXNlIHNoaWZ0
cw0KdGhhdCBhcmUgb3V0IG9mIGJvdW5kcyBmb3IgdGhlaXIgZGF0YSB0eXBlLg0KDQp2bWxpbnV4
ICAgZ2V0X2JpdG1hcChiPTc1KSArIDcxMg0KPG5ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gz
MjNfYXNuMS5jOjA+DQp2bWxpbnV4ICAgZGVjb2RlX3NlcShicz0weEZGRkZGRkQwMDgwMzcwMDAs
IGY9MHhGRkZGRkZEMDA4MDM3MDE4LA0KbGV2ZWw9MTM0NDQzMTAwKSArIDE5NTYNCjxuZXQvbmV0
ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX2FzbjEuYzo1OTI+DQp2bWxpbnV4ICAgZGVjb2RlX2No
b2ljZShiYXNlPTB4RkZGRkZGRDAwODAzNzBGMCwgbGV2ZWw9MjM4NDM2MzYpICsgMTIxNg0KPG5l
dC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jOjgxND4NCnZtbGludXggICBkZWNv
ZGVfc2VxKGY9MHhGRkZGRkZEMDA4MDM3MUE4LCBsZXZlbD0xMzQ0NDM1MDApICsgODEyDQo8bmV0
L25ldGZpbHRlci9uZl9jb25udHJhY2tfaDMyM19hc24xLmM6NTc2Pg0Kdm1saW51eCAgIGRlY29k
ZV9jaG9pY2UoYmFzZT0weEZGRkZGRkQwMDgwMzcyODAsIGxldmVsPTApICsgMTIxNg0KPG5ldC9u
ZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jOjgxND4NCnZtbGludXggICBEZWNvZGVS
YXNNZXNzYWdlKCkgKyAzMDQNCjxuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX2FzbjEu
Yzo4MzM+DQp2bWxpbnV4ICAgcmFzX2hlbHAoKSArIDY4NA0KPG5ldC9uZXRmaWx0ZXIvbmZfY29u
bnRyYWNrX2gzMjNfbWFpbi5jOjE3Mjg+DQp2bWxpbnV4ICAgbmZfY29uZmlybSgpICsgMTg4DQo8
bmV0L25ldGZpbHRlci9uZl9jb25udHJhY2tfcHJvdG8uYzoxMzc+DQp2bWxpbnV4ICAgaXB2NF9j
b25maXJtKCkgKyAyMDQNCjxuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19wcm90by5jOjE2OT4N
CnZtbGludXggICBuZl9ob29rX2VudHJ5X2hvb2tmbigpICsgNTYNCjxpbmNsdWRlL2xpbnV4L25l
dGZpbHRlci5oOjEzNz4NCnZtbGludXggICBuZl9ob29rX3Nsb3cocz0wKSArIDE1Ng0KPG5ldC9u
ZXRmaWx0ZXIvY29yZS5jOjU4ND4NCnZtbGludXggICBuZl9ob29rKHBmPTIsIGhvb2s9MSwgc2s9
MCwgb3V0ZGV2PTApICsgNzQ4DQo8aW5jbHVkZS9saW51eC9uZXRmaWx0ZXIuaDoyNTQ+DQp2bWxp
bnV4ICAgTkZfSE9PSyhwZj0yLCBob29rPTEsIHNrPTAsIG91dD0wKSArIDc0OA0KPGluY2x1ZGUv
bGludXgvbmV0ZmlsdGVyLmg6Mjk3Pg0Kdm1saW51eCAgIGlwX2xvY2FsX2RlbGl2ZXIoKSArIDEw
NzINCjxuZXQvaXB2NC9pcF9pbnB1dC5jOjI1Mj4NCnZtbGludXggICBkc3RfaW5wdXQoKSArIDY0
DQo8aW5jbHVkZS9uZXQvZHN0Lmg6NDQzPg0Kdm1saW51eCAgIGlwX3Jjdl9maW5pc2goc2s9MCkg
KyAxMjANCjxuZXQvaXB2NC9pcF9pbnB1dC5jOjQzNT4NCnZtbGludXggICBORl9IT09LKHBmPTIs
IGhvb2s9MCwgc2s9MCwgb3V0PTApICsgMTM2DQo8aW5jbHVkZS9saW51eC9uZXRmaWx0ZXIuaDoy
OTk+DQp2bWxpbnV4ICAgaXBfcmN2KCkgKyAzMjANCjxuZXQvaXB2NC9pcF9pbnB1dC5jOjU0Nj4N
CnZtbGludXggICBkZWxpdmVyX3NrYihvcmlnX2Rldj0weEZGRkZGRkQwMDgwQjdGNUMpICsgMjY4
DQo8bmV0L2NvcmUvZGV2LmM6MjI3ND4NCnZtbGludXggICBkZWxpdmVyX3B0eXBlX2xpc3Rfc2ti
KG9yaWdfZGV2PTB4RkZGRkZGRDAwODAzN0FCOCkgKyA5Ng0KPG5ldC9jb3JlL2Rldi5jOjIyODk+
DQp2bWxpbnV4ICAgX19uZXRpZl9yZWNlaXZlX3NrYl9jb3JlKHBmbWVtYWxsb2M9ZmFsc2UpICsg
NDk4NA0KPG5ldC9jb3JlL2Rldi5jOjUzMjg+DQp2bWxpbnV4ICAgX19uZXRpZl9yZWNlaXZlX3Nr
Yl9vbmVfY29yZShwZm1lbWFsbG9jPWZhbHNlKSArIDcyDQo8bmV0L2NvcmUvZGV2LmM6NTM3MD4N
CnZtbGludXggICBfX25ldGlmX3JlY2VpdmVfc2tiKCkgKyAyNjgNCjxuZXQvY29yZS9kZXYuYzo1
NDg2Pg0Kdm1saW51eCAgIHByb2Nlc3NfYmFja2xvZyhxdW90YT0xMzQ0NDYxMDApICsgNjcyDQo8
bmV0L2NvcmUvZGV2LmM6NjM5Mz4NCnZtbGludXggICBuYXBpX3BvbGwoKSArIDMxMg0KPG5ldC9j
b3JlL2Rldi5jOjY4NDQ+DQp2bWxpbnV4ICAgbmV0X3J4X2FjdGlvbigpICsgNzMyDQo8bmV0L2Nv
cmUvZGV2LmM6NjkxND4NCnZtbGludXggICBfX2RvX3NvZnRpcnEoKSArIDcxMg0KPGtlcm5lbC9z
b2Z0aXJxLmM6MzA1Pg0Kdm1saW51eCAgIGRvX3NvZnRpcnFfb3duX3N0YWNrKCkNCjxpbmNsdWRl
L2xpbnV4L2ludGVycnVwdC5oOjU3OD4NCnZtbGludXggICBpbnZva2Vfc29mdGlycSgpICsgMTUy
DQo8a2VybmVsL3NvZnRpcnEuYzo0MDI+DQp2bWxpbnV4ICAgZWwwX3N2YygpICsgMzINCjxhcmNo
L2FybTY0L2tlcm5lbC9lbnRyeS1jb21tb24uYzozNTc+DQp2bWxpbnV4ICAgZWwwX3N5bmNfaGFu
ZGxlcigpICsgMTMyDQo8YXJjaC9hcm02NC9rZXJuZWwvZW50cnktY29tbW9uLmM6MzczPg0KDQpE
dWUgdG8gYWJub3JtYWwgZGF0YSBpbiBza2ItPmRhdGEsIHRoZSBleHRlbnNpb24gYml0bWFwIGxl
bmd0aA0KZXhjZWVkcyAzMiB3aGVuIGRlY29kaW5nIHJhcyBtZXNzYWdlIHRoZW4gdXNlcyB0aGUg
bGVuZ3RoIHRvIG1ha2UNCmEgc2hpZnQgb3BlcmF0aW9uLiBJdCB3aWxsIGNoYW5nZSBpbnRvIG5l
Z2F0aXZlIGFmdGVyIHNldmVyYWwgbG9vcC4NClVCU0FOIGxvYWQgY291bGQgZGV0ZWN0IGEgbmVn
YXRpdmUgc2hpZnQgYXMgYW4gdW5kZWZpbmVkIGJlaGF2aW91cg0KYW5kIHJlcG9ydHMgZXhjZXB0
aW9uLg0KU28gd2UgYWRkIHRoZSBwcm90ZWN0aW9uIHRvIGF2b2lkIHRoZSBsZW5ndGggZXhjZWVk
aW5nIDMyLiBPciBlbHNlDQppdCB3aWxsIHJldHVybiBvdXQgb2YgcmFuZ2UgZXJyb3IgYW5kIHN0
b3AgZGVjb2RpbmcuDQoNClNpZ25lZC1vZmYtYnk6IGxlbmEgd2FuZyA8bGVuYS53YW5nQG1lZGlh
dGVrLmNvbT4NCi0tLQ0KIG5ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jIHwg
MiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL25l
dC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jDQpiL25ldC9uZXRmaWx0ZXIvbmZf
Y29ubnRyYWNrX2gzMjNfYXNuMS5jDQppbmRleCBlNjk3YTgyNGIwMDEuLjg1YmUxYzU4OWVmMCAx
MDA2NDQNCi0tLSBhL25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jDQorKysg
Yi9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX2FzbjEuYw0KQEAgLTU4OSw2ICs1ODks
OCBAQCBzdGF0aWMgaW50IGRlY29kZV9zZXEoc3RydWN0IGJpdHN0ciAqYnMsIGNvbnN0DQpzdHJ1
Y3QgZmllbGRfdCAqZiwNCiAgICAgICAgYm1wMl9sZW4gPSBnZXRfYml0cyhicywgNykgKyAxOw0K
ICAgICAgICBpZiAobmZfaDMyM19lcnJvcl9ib3VuZGFyeShicywgMCwgYm1wMl9sZW4pKQ0KICAg
ICAgICAgICAgICAgIHJldHVybiBIMzIzX0VSUk9SX0JPVU5EOw0KKyAgICAgICBpZiAoYm1wMl9s
ZW4gPiAzMikNCisgICAgICAgICAgICAgICByZXR1cm4gSDMyM19FUlJPUl9SQU5HRTsNCiAgICAg
ICAgYm1wMiA9IGdldF9iaXRtYXAoYnMsIGJtcDJfbGVuKTsNCiAgICAgICAgYm1wIHw9IGJtcDIg
Pj4gZi0+c3o7DQogICAgICAgIGlmIChiYXNlKQ0KLS0NCjIuMTguMA0K

