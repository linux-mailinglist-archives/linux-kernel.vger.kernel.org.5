Return-Path: <linux-kernel+bounces-15226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECEC8228B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26036284E08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719011802F;
	Wed,  3 Jan 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BweWZKLv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="V5L0ywPF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45E179AC;
	Wed,  3 Jan 2024 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 41b356a0aa0611eea2298b7352fd921d-20240103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pvhIpRQTIQH89wWZNlpUBBkCX6rPB7fl+FB7UkICKGM=;
	b=BweWZKLv2dG5Z+bB3z4IGFhc60BDFzZjzGGvacLnPgSepgHKKzermd5eHgxRqnwdf0LrQut741fhGZ+wfW92zsMmdy+dTIzB7OueIRFph1M+8sdPRIsaVw+gt6O8125yqRpkVnUAEHi2EImxavBIyT8RPKCRgDxGr0IhCIaXPLo=;
X-CID-CACHE: Type:Local,Time:202401031453+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ec004032-9a31-4855-ab49-84dca1c31a88,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:6755d68d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 41b356a0aa0611eea2298b7352fd921d-20240103
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1360682873; Wed, 03 Jan 2024 15:03:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Jan 2024 15:03:53 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Jan 2024 15:03:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnpvciIFJPa+e0Lr4DoHQCC7FDVUSI0R+jiL5ukX56lkqZyWNPCkg0VEk2aTujehg1e/6+YfN2w9us5J0I+powpQSFjxPQYGrtMDarG4hp4gqmIWFmSuYFF/dPY5svN5ewTrPF/qLZsnGh2PBJ3fhowLgtODKYwpUm5fZzdkJH695Y9++Faeuh3h6SaYSS2AmRsl0pl11y03i1vdOehcMwPvlTdv8nih3Q3Dwa5mJdAygbxYMs3lFrGjNbpewAzYwxBRcxd8g+ALwPGgpJOqR4pY4PhUuDhE70GwUsStSN8KfB0xFSXcb2H+SWtPNA21dka6sFst3GcS4r8SoTP0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvhIpRQTIQH89wWZNlpUBBkCX6rPB7fl+FB7UkICKGM=;
 b=BDZ4SGMhdDN7CzN2Pl53LjO/TG7hn25Dqs5Bh7hZiah2mYr8Wd0Pjh072iTyzr5MhIcR+U/P1FZpvSxhW0nIq2ssY/krXj1//D8hk+Rir7Q4WEn9lQ9+gbTmu7vCcU6vvAxmBpH1beTC5cxjB2jD2dBkEIfOJB62EhI72GWLiF8UKI0sslsgpTvlWyVnDBAJCWgQpYXek9skdCpG9wNImjXNRTi4GfsKy43Xj+qXpOezxZHPW2SlptFw82C0ItxDq8Ltm6oi0C0tdeoVT3dfSPgbbtrI6Pl/jBh69FxUo0SBSjQHhYB/Ee9puRtl1scCBY6tVVfNsqvapMnqAqaL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvhIpRQTIQH89wWZNlpUBBkCX6rPB7fl+FB7UkICKGM=;
 b=V5L0ywPFIu82HLPzhpqI78Vvk6lOWTx7T5UP1y3WCkDVqQe2A86eeYgusoJucRvNdiyFwy9xQIKytH5X5dNA7pBHIdhc1/PSMT+O1GIqpoTIEZSyyNtre9lTWO32ImmZEnq/hDd132bw9zVQf2pyFqUOoAEwA/nFUIgTnGUrVac=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB8412.apcprd03.prod.outlook.com (2603:1096:405:73::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 07:03:51 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 07:03:50 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Topic: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC+WDsAgAlkn4A=
Date: Wed, 3 Jan 2024 07:03:50 +0000
Message-ID: <a3b2f7c395e287c6d85bfbe1dd76525f3af076c9.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <c33745a4424777df44efe811dba060700f0009f0.camel@mediatek.com>
In-Reply-To: <c33745a4424777df44efe811dba060700f0009f0.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB8412:EE_
x-ms-office365-filtering-correlation-id: 01027f43-8269-45c7-9da7-08dc0c2a23c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M3klZubZC2pMzo+TwvSY59NQgdXIFCTIjUpSiiEWep1P007oPjJLojTfpI5zO8p1xiw1bRIoOec23pcX7o9/v4obvTAKvH7ppSR7FwZ/2ZijChjYZvCvuicZETQft5ANsnkt/QhlTwEyWaooXTQhTV+MUKfIv7NC1MXfA0QqmOPXfgFjsAjMIVJC8k2bT0otgiyiJWd8OYf3nnLlmuhinOx+WLRL/SVUEub++Hwty4/7y1WyajYI5IzJ3LUEgqM9Gm2BQRxLbj+5nBxY2b94bSisKEKa+GLN+sTs3LOdcihwAReid30d1S4+CB2/pHRE3eO/yEN2RTD8hsXczzxF0FKvD8xNsEz9r8ylj8a2lWZN0u7mp+R6jQXXmopDIX5EPJgxbROt5TlmRH6mis7/3mWJP74QXnPr+qUNs7kaMNme5JpIoCjTP7jALDun3TRwuhj0aVGwJxMqrpAwjPKi/NL5ceq3PBKPQb7gM1MeaU3iZzbf6ogHy/tZ46SJ94mPhuYM43znzX0i+0gcWA/88P4qg4yiA2euTRPjz0s3wjZHIbBX4kMXQ4wI5Vf6YRI8zTRZFzgUe1A6U9X98BFidexNhx2qG0Cz+gQAVK6uqsgyMVfE59eR3iQlO4vPdKM0gFOuynZpa7oyFouGDDrUcK7DjV7FFDBK3OQrbTbzCIE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(26005)(2616005)(41300700001)(122000001)(38100700002)(110136005)(54906003)(8936002)(316002)(15650500001)(8676002)(5660300002)(7416002)(71200400001)(2906002)(4326008)(478600001)(66446008)(6486002)(66946007)(6506007)(64756008)(91956017)(76116006)(66556008)(6512007)(4001150100001)(66476007)(38070700009)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkFma0ZqWStDdlpzaFFMQjk4UWlzOEw4NEorMjhVNnZ1OER5NlNQSjR0SzF2?=
 =?utf-8?B?V2xhak5ycUVkbjhZODVIdVZQTUZpVVhRM1I4QnZ3YVE5aVNqL0lxUnpraDZR?=
 =?utf-8?B?REs2QnF0cUhKci81ZTlsVEUvMCtCUDBsSzVTd29Ob0xtcklZSUwzSzhoQW9D?=
 =?utf-8?B?RStEUG1IK0pMZHBzMkRaeXFKNWU5bzlObi9uN0ZmZFE5R0VxeVlwZTlMTDhy?=
 =?utf-8?B?Y2FNdnV3bkRSR1lCNWVnbU8vTmFKcHNBNUZpQnppc0FOclgySmtBakt1OVl5?=
 =?utf-8?B?OCtqdzNtQzE4b1k5STJWRXdFSUgzU3NjZTZ2TnBHTlpVNHpQUVhLSjlDN3Jp?=
 =?utf-8?B?dnltMTAxb21LamxFSkVQZGpLU2tLMXNTenBUS1JoandJZlcvbXBoZDVxTytR?=
 =?utf-8?B?ZzExS0s1U0prVkxqUy9KMmtlekM3dEFwazNRaWdGTWFHM2NLSytKenE3Tita?=
 =?utf-8?B?RndoTTJqUTErVVk4UVpjYmIvZ2hCcGJ5ZnlObytnVm9oaTFsbm02L3JpMVBh?=
 =?utf-8?B?UDFJSjdxVWpWdWdQU2NUaWZyeGs2U0l2a3preHB1akNsWnNERFk1L1Y0MkFR?=
 =?utf-8?B?Y0xvQlc5RFZIZHJTNXF0dXJqSnVOTTU1aXNwUTlPbWc2RGh0Z1l1b2VZMHJP?=
 =?utf-8?B?U2NOaFd0Vlh1NERlMTBLQXJsY29DVDJISVJtdk9XTDVNUDB3WXhyNmNyTTNT?=
 =?utf-8?B?RTFFWUp6bnllM1BGdjZPaWdnZ3NNQzlpSUZEY2pUR3lnSDZDZjZGdnZsakpH?=
 =?utf-8?B?Wk8yVkd3R0J3WFdxVnFZRzIxQUlpQ0RhUzlDY3VCVkNRUXBtb3l6eG13OTZl?=
 =?utf-8?B?d2JCYnRGLzJ3NCtQdFNtajhQZjYwdlEvdmpSWHRhZjF4YVNiK3NNN3IvTE5C?=
 =?utf-8?B?Y01DRkpram5WUVl5ZnFhYUNHN2NuaTcrbjgyblNOMWtxNzlyZTZVeE01S0VR?=
 =?utf-8?B?NmJIcUdKVENyOTh3WFJodW44TjdVbG1nWjNZbXNBaEFlQ0YveDlOK3dUUnI0?=
 =?utf-8?B?akVtQVpJdnJxb3JPRkVTdFdVaklXRk4rVmxxMlVMdnZjdHJ0WmV2WFowclF6?=
 =?utf-8?B?WEx5RmZ2eVdvRXJHVjBaQXljSytqNUdXdEt2bzRVWjg0MjA5SFp0VHVaWHBR?=
 =?utf-8?B?bTBPdk9FWk80TTdmUGxHWkxmdkFqNDQyU2ZqWEMrS3NHYjYrSWFGaFVUQWNS?=
 =?utf-8?B?aTZFTkgxR09vZU1OVmtCczFncVVYVGdOd0YvdEVYN3FISWdDWlFSbzBYR0wv?=
 =?utf-8?B?MmNrN2I2YTVwbXFTT3pLc1BPS3pucC9mUElQT3FPd1JSZG9zRW1MUmNjbnhM?=
 =?utf-8?B?ZFFBUi8yeGszTi9xU1ZmWEF0YTc5KzI2RFh4c1lIdUlXWDhkLzl6WmlTcWsy?=
 =?utf-8?B?aU5SakFycjM4VEtZY2FmTXF2OXNFeCtHalNsREpHZUNQeUh5c01Rdy81dURh?=
 =?utf-8?B?L1FybkRYT3NGOEFEUEtMNGNOSlQycGZkc0Q1Y3BWYTIzZm1HdWkyeThVbFFy?=
 =?utf-8?B?bjMxcWh4cVRLUjkvNjVQNmt5cDJ5a3czVHF2dDA4MDMxUzZoM1RnU2JhSnFH?=
 =?utf-8?B?VTVIQm96R29LY2p2b21OenNydU5BS0lTc2VSYkFRN3R3T2FnaHp6bkt5VjNH?=
 =?utf-8?B?Rk4rdDNROVd6QlRnUU9CWWRsYTBhL3YyWmJ2WUR2cWlsbEM1TUtDRUJXYjNq?=
 =?utf-8?B?a2UxdjhHc2M3Ny93RWc0ZzRnSlQ3RHl5SWJZMnhRQ2lmdVlVRVlEYnA3V3hL?=
 =?utf-8?B?ZXo2eUsyVEZsR1F5RXNjYmxKRFJraG5JV3NWOGxkTytseFhwZ0tZbndlQjZL?=
 =?utf-8?B?RWt4VlpSV2lCdlNrTEwzRiswOTZhT0VJVGN1c3ZkTUt3QUI5alcxOFhpd2hU?=
 =?utf-8?B?K3hZaTRSR2lvZFAydHdHNDVEaWo0OUE5Tlp6RnBPVEdWekM4YndMT3ppTko3?=
 =?utf-8?B?Q2haZUNaaWoyVElEL0ZUQWxEVDM4WVRCdkVYK1hvQkhXajdST2dqV3JDTU52?=
 =?utf-8?B?Vy9KQTdJMlRJbytDdFZuTUNuNEFLZnJkRWRUNFlQZWFqbGlkUGpKaHJXenZ4?=
 =?utf-8?B?S3V5VlZVc2trcWxJVzJwS0QwZmttTWFWUldYQ1gwOG1zTHJ6RWFDbXBzTkpm?=
 =?utf-8?B?MzdLRUVXc3U0ay91SFJpNUFxZFhQcFd6U0xYejFKTmFNMXk0amtJaUJXZEgv?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45D195EF08702C418B663D69005E6653@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01027f43-8269-45c7-9da7-08dc0c2a23c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 07:03:50.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HgH01mz/SIxsgka2xmQrFpsfYalg6qYjzuXZbBuVYcUPybt/NdL7lTz+CLnwWynS85GJqu+rumwagF1hxDcq530tFU+TmIOZ9iakflMzag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8412

T24gVGh1LCAyMDIzLTEyLTI4IGF0IDA3OjM3ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gRnJpLCAyMDIzLTEyLTIyIGF0IDEyOjUyICswODAw
LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBm
ZWF0dXJlLCBHQ0UgaGF2ZSB0byByZWFkL3dyaXRlDQo+ID4gcmVnaXN0Z2Vycw0KPiA+IGluIHRo
ZSBzZWN1cmUgd29ybGQuIEdDRSB3aWxsIGVuYWJsZSB0aGUgc2VjdXJlIGFjY2VzcyBwZXJtaXNz
aW9uDQo+ID4gdG8NCj4gPiB0aGUNCj4gPiBIVyB3aG8gd2FudHMgdG8gYWNjZXNzIHRoZSBzZWN1
cmUgY29udGVudCBidWZmZXIuDQo+ID4gDQo+ID4gQWRkIENNRFEgc2VjdXJlIG1haWxib3ggZHJp
dmVyIHRvIG1ha2UgQ01EUSBjbGllbnQgdXNlciBpcyBhYmxlIHRvDQo+ID4gc2VuZGluZyB0aGVp
ciBIVyBzZXR0aW5ncyB0byB0aGUgc2VjdXJlIHdvcmxkLiBTbyB0aGF0IEdDRSBjYW4NCj4gPiBl
eGVjdXRlDQo+ID4gYWxsIGluc3RydWN0aW9ucyB0byBjb25maWd1cmUgSFcgaW4gdGhlIHNlY3Vy
ZSB3b3JsZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpo
LmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gKw0KPiA+
ICtzdGF0aWMgYm9vbCBjbWRxX3NlY19pcnFfaGFuZGxlcihzdHJ1Y3QgY21kcV9zZWNfdGhyZWFk
DQo+ID4gKnNlY190aHJlYWQsDQo+ID4gKwkJCQkgY29uc3QgdTMyIGNvb2tpZSwgY29uc3QgaW50
IGVycikNCj4gPiArew0KPiA+ICsJc3RydWN0IGNtZHFfc2VjX3Rhc2sgKnNlY190YXNrOw0KPiA+
ICsJc3RydWN0IGNtZHFfdGFzayAqdGFzaywgKnRlbXAsICpjdXJfdGFzayA9IE5VTEw7DQo+ID4g
KwlzdHJ1Y3QgY21kcV9zZWMgKmNtZHEgPSBjb250YWluZXJfb2Yoc2VjX3RocmVhZC0+dGhyZWFk
LmNoYW4tDQo+ID4gPiBtYm94LCBzdHJ1Y3QgY21kcV9zZWMsIG1ib3gpOw0KPiA+IA0KPiA+ICsJ
dW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiArCWludCBkb25lOw0KPiA+ICsNCj4gPiArCXNwaW5f
bG9ja19pcnFzYXZlKCZzZWNfdGhyZWFkLT50aHJlYWQuY2hhbi0+bG9jaywgZmxhZ3MpOw0KPiA+
ICsJaWYgKHNlY190aHJlYWQtPndhaXRfY29va2llIDw9IGNvb2tpZSkNCj4gPiArCQlkb25lID0g
Y29va2llIC0gc2VjX3RocmVhZC0+d2FpdF9jb29raWUgKyAxOw0KPiA+ICsJZWxzZSBpZiAoc2Vj
X3RocmVhZC0+d2FpdF9jb29raWUgPT0gKGNvb2tpZSArIDEpICUNCj4gPiBDTURRX01BWF9DT09L
SUVfVkFMVUUpDQo+ID4gKwkJZG9uZSA9IDA7DQo+ID4gKwllbHNlDQo+ID4gKwkJZG9uZSA9IENN
RFFfTUFYX0NPT0tJRV9WQUxVRSAtIHNlY190aHJlYWQtPndhaXRfY29va2llDQo+ID4gKyAxICsg
Y29va2llICsgMTsNCj4gPiArDQo+ID4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUodGFzaywg
dGVtcCwgJnNlY190aHJlYWQtDQo+ID4gPiB0aHJlYWQudGFza19idXN5X2xpc3QsIGxpc3RfZW50
cnkpIHsNCj4gPiANCj4gPiArCQlpZiAoIWRvbmUpDQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsNCj4g
PiArCQlzZWNfdGFzayA9IGNvbnRhaW5lcl9vZih0YXNrLCBzdHJ1Y3QgY21kcV9zZWNfdGFzaywN
Cj4gPiB0YXNrKTsNCj4gPiArCQljbWRxX3NlY190YXNrX2RvbmUoc2VjX3Rhc2ssIGVycik7DQo+
ID4gKw0KPiA+ICsJCWlmIChzZWNfdGhyZWFkLT50YXNrX2NudCkNCj4gPiArCQkJc2VjX3RocmVh
ZC0+dGFza19jbnQgLT0gMTsNCj4gPiArDQo+ID4gKwkJZG9uZS0tOw0KPiA+ICsJfQ0KPiA+ICsN
Cj4gPiArCWN1cl90YXNrID0gbGlzdF9maXJzdF9lbnRyeV9vcl9udWxsKCZzZWNfdGhyZWFkLQ0K
PiA+ID4gdGhyZWFkLnRhc2tfYnVzeV9saXN0LA0KPiA+IA0KPiA+ICsJCQkJCSAgICBzdHJ1Y3Qg
Y21kcV90YXNrLA0KPiA+IGxpc3RfZW50cnkpOw0KPiA+ICsJaWYgKGVyciAmJiBjdXJfdGFzaykg
ew0KPiA+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNlY190aHJlYWQtPnRocmVhZC5jaGFu
LT5sb2NrLA0KPiA+IGZsYWdzKTsNCj4gPiArDQo+ID4gKwkJc2VjX3Rhc2sgPSBjb250YWluZXJf
b2YoY3VyX3Rhc2ssIHN0cnVjdCBjbWRxX3NlY190YXNrLA0KPiA+IHRhc2spOw0KPiA+ICsNCj4g
PiArCQkvKiBmb3IgZXJyb3IgdGFzaywgY2FuY2VsLCBjYWxsYmFjayBhbmQgZG9uZSAqLw0KPiA+
ICsJCW1lbXNldCgmY21kcS0+Y2FuY2VsLCAwLCBzaXplb2YoY21kcS0+Y2FuY2VsKSk7DQo+ID4g
KwkJY21kcV9zZWNfdGFza19zdWJtaXQoY21kcSwgc2VjX3Rhc2ssDQo+ID4gQ01EX0NNRFFfSVdD
X0NBTkNFTF9UQVNLLA0KPiA+ICsJCQkJICAgICBzZWNfdGhyZWFkLT5pZHgsICZjbWRxLT5jYW5j
ZWwpOw0KPiANCj4gY21kcS0+Y2FuY2VsIGlzIHVzZWxlc3MsIHNvIGRyb3AgaXQuDQo+IA0KPiBS
ZWdhcmRzLA0KPiBDSw0KPiANCg0KSSB0aGluayB3ZSBzaG91bGQgdXNlIHRoaXMgdG8gdGVsbCBD
TURRIFBUQSB3aGljaCB0aHJlYWQgbmVlZCB0byByZXNldA0KYW5kIHVwZGF0ZSBpdHMgY29va2ll
IHZhbHVlLCBzbyBDTURRIGNhbiBzdGlsbCBtb3ZlIG9uIHdoZW4gZXJyb3INCm9jY3Vycy4NCg0K
UmVnYXJkcywNCkphc29uLUpILkxpbg0K

