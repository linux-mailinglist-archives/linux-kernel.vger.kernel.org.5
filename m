Return-Path: <linux-kernel+bounces-17514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43098824EAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9551F22A27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2C7E;
	Fri,  5 Jan 2024 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B4xWdoJ4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kNGYQvgY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701D41D685;
	Fri,  5 Jan 2024 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e120d390ab9411eea2298b7352fd921d-20240105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=808IFYp3Sk385M/GElXeD0nERItEz/X84CAFVpxzslc=;
	b=B4xWdoJ4gHg4EEjZnL8JhrWNcvQqFkBhMa381BrcV9iimeNJNiI7HwhViRiAXgg1hctGtDqg2K1LXPUoxQlGM7cVYEtHYWpXxgoCV2+4TimUd6PTuE061k2PHcSl7yzX26ADK+UGE0R/+yegoGJKYTvFq7NeQYAY4r/2Gk8LcOM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:84d67780-6a0c-42f9-a486-d60567473afc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:deaf047f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e120d390ab9411eea2298b7352fd921d-20240105
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1768838729; Fri, 05 Jan 2024 14:37:21 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Jan 2024 14:37:20 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Jan 2024 14:37:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx3tM7UfODHwkw9XVZnzqGan8Y5y1IN64SNIQRatyEBkCbSouCVQf4kM3zOolbIf6S4s1PzLV3bYs+q3KewhTH+/gg0tSdqRhO9h52rZNjqPyjaJr4c2EGmNHCn2fJOCGD+NQdFZT4QySzc7f/z7x4RNNDeUSPKBMJM7J3fscrOSqk/fq+qTDiPLP5DhDDzcFUuT0uP6NroX17oLiTUrRVRSBSZfa7TVo0sQrq3kexfDXaDwmJMzlKFh/t8+si6aJlHSA/OHGi8qy2va7V12I2+TMpxIz0/9Vypb2eJamtBjoeXL25XZAS+mNgKqHP/qTJjjiURVBLqgEi3/FTrgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=808IFYp3Sk385M/GElXeD0nERItEz/X84CAFVpxzslc=;
 b=l4oM4StDDuZ9PzkIeAWEOJgreUG9nyo/yqy701zo/j8t/jmrz17FuWx7vKIWUUDaIwFNdE3sWiPA3O6uRI+f3SlkxZDRuUNv4Q/nTq3PFqJoV8dt2afgK9u6S1SHH52kgd03yJ2nKPouQmAzy4qQHmddF1es46mqoLhObXUUeJmHWOxPlPl/vV0KfD4LJD4JkK3g2SPKgOsjBjOvSaEfkJQCgtQyHbfl5Gq0+1Xjg+D9rBy0LqCeL+iQhm/DxMgPaESU/HQZhUk7id3bcZEf4ZpqCj32HoQx0oeEHxTqe7b7/jeAcUVIKcKUuKM7UQuPQN4nd1S9aewplBE4gZ6H3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=808IFYp3Sk385M/GElXeD0nERItEz/X84CAFVpxzslc=;
 b=kNGYQvgYvJP/I+YleKe0TopP8ZdICjqs5zPpZwteHRkn9bwsdPbixTvqyqAuTn7ckBdEWLWgcRumRty/DbTki16/qeXTpZADo+XaSzc1t9C9XrkGgxAo67/TLA8HRmdbYMIfGOS/US2fNOdr6NIrSfMAv6sPxumcpUXNg2zxErU=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PSAPR03MB5607.apcprd03.prod.outlook.com (2603:1096:301:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Fri, 5 Jan
 2024 06:37:17 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 06:37:17 +0000
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
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC+WDsAgAlkn4CAAXuNgIABobIA
Date: Fri, 5 Jan 2024 06:37:17 +0000
Message-ID: <c3d24075c8dfa1c651806231a412fad3dae436ee.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <c33745a4424777df44efe811dba060700f0009f0.camel@mediatek.com>
	 <a3b2f7c395e287c6d85bfbe1dd76525f3af076c9.camel@mediatek.com>
	 <fdd275452f99e3fa1b1b98be05151121858dcc60.camel@mediatek.com>
In-Reply-To: <fdd275452f99e3fa1b1b98be05151121858dcc60.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PSAPR03MB5607:EE_
x-ms-office365-filtering-correlation-id: 25fdf0bd-c589-4d21-52c0-08dc0db8c2b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xwfVrud6boUJrKwYo7iJxMe3VhBbVBsLHlDTYKMjXJJq/1X087pnCpaBPg3VMvp5YcExrPOSV1wOj0a/miQky1pAv0hqPFovvQ6NTtQVALdooz038KnFL6C1BV8UnZJmk5ebulD0YvtUL9MFPPHvHc7551rx9ZKrBbBeWb4hbAdD1SMvYeYZKn3RkBhxJ23yzyOH3bl82rNnuZ4MHdBH8+jceDMwp2wJdeaJX8qHDbFudsMBwhsvVVf8U+FBK1LZf9eavSUaJvxdEsXTKosfqkJxfI3k+WmaVUXmDVg9yxv+jfuWP2ef7zr0I0ypFUu5T7gwgevC0BKVrx+ATS0X/ibhatdXcoWOrfmVMR6G6NJulT7iL5kaeFFxDLLugViS/iNezK8UWlAbvcLiy2uUc8BHrUGb0OZ/Q/fpnaOszaa/1rd3td5v+Y6g5q+bdTP1M7JwTYWkje3p/jEAh8Yuw1nRrrDe+wi8GNwzBsT5dtdNXFpPKx7lJlPcvE1eFDua23Oej0BYK7aekhx0j841J8nWe+CZoN8xGckvHU/oymIe05Mrx8cUgzDCmXvG54KkYaefl86fvna4PV+D+KXc2vlvp80rUvXRsdZKU2ZEZdwryRNuqwC8dXwqgGF/o3rGkJH5KvP5UNcToh6zAfdWiIFZLxtLLy8NY4R7jdue5l4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66446008)(66556008)(76116006)(66476007)(66946007)(91956017)(71200400001)(26005)(2616005)(36756003)(85182001)(6512007)(38070700009)(122000001)(86362001)(38100700002)(83380400001)(6486002)(41300700001)(6506007)(478600001)(64756008)(4001150100001)(7416002)(4326008)(5660300002)(15650500001)(316002)(54906003)(110136005)(2906002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUd4YWV0MWxmWXJhM0Y1MkZXUFhWRFdhS2xWSmlCRHA1N21NQVl2TlBDa2Fq?=
 =?utf-8?B?ZmRZeHliRjIyblJISGJGSzBMbEs2VEhVbm9lVUlYb2ZmL00wZURBU1ZJTjc5?=
 =?utf-8?B?MHhKeTdvRG1EVC9pUXNPZC9vMXpXUHEzZ2RvL1ZDWllnaDF0REdWRlhldE5T?=
 =?utf-8?B?UitBc0tBVlFwa3dySGpJZGFSblN0U3V2VTFLajRvL2dTY05lTTVoaUNIOWY2?=
 =?utf-8?B?T3dqb3c5REhHQjJDUmZiWkFRVFRVSU1DMzl5THZCQmxCeC9ucXIyTkYrSGZk?=
 =?utf-8?B?YnRFUVFUWFRXbk1kL21hd0xQMW9jZHd3ajZLV1Q0VG9LZW8zSStuM2o1RDNz?=
 =?utf-8?B?U1dhL29TTXJrenBwU3pleGdGR08xanZBQ3RJb3RVMENrUWREZVNZV05VRko4?=
 =?utf-8?B?OU1QYkJtTFZSY1lzZGRDUVFZVWxLeHV2alZRUkVhR3BnZU5weFVYTnoxY0M1?=
 =?utf-8?B?R1B3ZEdOblZPL0lEUmR1WGx4VEM5OHBHb04rN1VrR3R2NEN0OHl5eGFOYWZy?=
 =?utf-8?B?K2dkZ2FtNUlyL0lONFl5Szhqc3RlTmJ2Z2M2ZzE5bmE5c0xMejRZVytKYVJv?=
 =?utf-8?B?ZFg5V2hrdjV0c3ZWYTRIc3FBMzhaU2xpRVpKWDNuZGlsblZ4MTM0U2RBSzlT?=
 =?utf-8?B?MEtoby81WGxhQWNxa1NzVmg3Z3lIS3dIT0tlWEM5Ny9uMGRrKzg5bTlVT05I?=
 =?utf-8?B?SDJVY1o0QXR4VWVwbWRVRWZlVG00OUhsY3dnZG1aQ1pNaGkzbk5kZ014aVpZ?=
 =?utf-8?B?UFI5c2NONEdveTV6cVVMbG5YdnhCSWdnSFRZT0pWODhvMS82dWZWWkJiekpa?=
 =?utf-8?B?d3R5RVcwY244SjZVT3ZhYnNzNjdhUzdQa21nS3NBQ1gvWEpMSGhQMStHRTZt?=
 =?utf-8?B?bHU2Q2srZG1GMmJLdWxXNmd4NnFhOFJCVk40Y2dYYU5WbVFWY1ZRVDVpbFI3?=
 =?utf-8?B?VDR5L1BnemFPWjArUStVenpIb0VPV2k4UTVFU0hYZEZKMU1NRWFPWmxsa01t?=
 =?utf-8?B?MWMvR204MWJjN3Z4YlVmRG55aTFkanhBVDBIa3pvSGo5dFdnTlljWEpITnho?=
 =?utf-8?B?UkdILzhFc0FOZVNCMU1iM0VLcjhudHVYNmRwVk1ld1N1dWREY3JYbDZJWk9C?=
 =?utf-8?B?L3krSUpod29DOW0zZ3JvNFZMR1Vpcnl1TGRSd1BOOC9Cak5QVGNVMEtZaEhF?=
 =?utf-8?B?ZUZJQ2lTald6cG9rSkxqWkNaN3h5UDhkMWY0dzZZZU95N2o3RUdkY3N4cTRN?=
 =?utf-8?B?aHVRalJaSUZId2xlOHdjUmhoaDJISVVIKzVPOUk1T3o5MjNzd20rT2szdjhV?=
 =?utf-8?B?c0lqdnoxSjJMTU5QbjVtejNMbmR0RW5aSGpqTDlaOU1IaENpQjZidEdEdWV4?=
 =?utf-8?B?ajlvTnBmK1FmUzE0Z2p4bVVtTUpXU3VpSm9IWW8wbXdkUmFtMmxETnlmRkhu?=
 =?utf-8?B?Zm8rMys0Y1o2Vk9hLzdaK050ZWllM3oxZ0xRbVIwS0dVdEVNR2tBMHpCYmdq?=
 =?utf-8?B?di9uR0FOdGw3dlUxTVdzUzRobU11NHIxV09TR3cvRGpNMTRyQUI2MzQ5MDVO?=
 =?utf-8?B?VnJhdm9mUUgwOHA0K3diUVg4STZqMXJWbHRISU9CSTZJeUlYTjZFOHdsbjNG?=
 =?utf-8?B?QzJyN2NLWXNsRzA4NExSVnFoUWhwZDNyNlg5RjNrY3pkN1d2TDlYWmFYZmxq?=
 =?utf-8?B?S2hGb2tIZE12aVVDd3IwTHNHenc5UkZsV25Ld0x5eUVpcndpdXg2c2t0ZWRB?=
 =?utf-8?B?WUNlcWQ0MVQ4dWg1UTZFQ0ZKdm5QWmUrRmg1SGdkR2s1YVhuYnFza0xZV2pE?=
 =?utf-8?B?SUVFY1gxVXpEQk1XRDBMTkRxR3VuUFhMU2c2YXltY20wS1RmZ1ZmK0FyWTAz?=
 =?utf-8?B?TGRUUjdrc1JxeDdWaEZMYnpodDhaaTVFUTNYbEMzRXdlSExXemNsOXZBdzdi?=
 =?utf-8?B?K1ptZlpwR2s1Sms2aEVCdXJPd1NnUHhFMERNWHY4aW9oM3ppdnYwcDFFY29v?=
 =?utf-8?B?WTB0S0tnWmQrSFhkdlJESlFoS01aa2NwZU5IbEVpU1ZqZWczZWJZUTNKZThX?=
 =?utf-8?B?NWdTdzAzUnVPUzluQkNzT0NWSlIveURva0cwWU5ybU9VWVZseVZKY0VoK2lK?=
 =?utf-8?B?eUxlbUs4YzdyL2RZRWVWT2l2QTBQellHdXE2ZTRTODM0OEZVTHU3RTRZdXM1?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7513541E5C95F489E51A873A289564E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fdf0bd-c589-4d21-52c0-08dc0db8c2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 06:37:17.1287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPbNRj3RIEaxe/NWG5f8DbYLGBVeN2rfYfEczybIdQ4EQQi5Ni5oz5/xgXZnx6CSfjM1Xq2NmLUQBlOthpcq/Tj0nhFJZtaEswuHne/Hzns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5607
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.662800-8.000000
X-TMASE-MatchedRID: HXSqh3WYKfsOwH4pD14DsPHkpkyUphL9fjJOgArMOCb3bBqxmjinTbs0
	9RsYKeKEiUqxWFzqa/9QGF7v4Up8Fw9FV6kNYiPHbc297PAGtWaQoBr+SFneJHPBWZjlMys28ha
	W4U9IrFqspZWETm/FhrxEriApWTrhOVzKEd+ERcq3UCG/IQp2PgMDwjfX+DzgrcsFdtecvlMJ/a
	H0DaAUBT3SbOdbz3vJbYH4cnTg5BjGUecy8W1eak0jzafXv7tTGEfoClqBl86bKItl61J/yfmS+
	aPr0Ve8SXhbxZVQ5H+OhzOa6g8KrZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.662800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7934310AFE2F5FC56952583C009982C1CBDDD79AA14886D851F26868C3E78DAD2000:8

T24gVGh1LCAyMDI0LTAxLTA0IGF0IDA1OjQyICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gV2VkLCAyMDI0LTAxLTAzIGF0IDA3OjAzICswMDAw
LCBKYXNvbi1KSCBMaW4gKOael+edv+elpSkgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDIzLTEyLTI4
IGF0IDA3OjM3ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiA+IEhpLCBKYXNv
bjoNCj4gPiA+IA0KPiA+ID4gT24gRnJpLCAyMDIzLTEyLTIyIGF0IDEyOjUyICswODAwLCBKYXNv
bi1KSC5MaW4gd3JvdGU6DQo+ID4gPiA+IFRvIHN1cHBvcnQgc2VjdXJlIHZpZGVvIHBhdGggZmVh
dHVyZSwgR0NFIGhhdmUgdG8gcmVhZC93cml0ZQ0KPiA+ID4gPiByZWdpc3RnZXJzDQo+ID4gPiA+
IGluIHRoZSBzZWN1cmUgd29ybGQuIEdDRSB3aWxsIGVuYWJsZSB0aGUgc2VjdXJlIGFjY2Vzcw0K
PiA+ID4gPiBwZXJtaXNzaW9uDQo+ID4gPiA+IHRvDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBIVyB3
aG8gd2FudHMgdG8gYWNjZXNzIHRoZSBzZWN1cmUgY29udGVudCBidWZmZXIuDQo+ID4gPiA+IA0K
PiA+ID4gPiBBZGQgQ01EUSBzZWN1cmUgbWFpbGJveCBkcml2ZXIgdG8gbWFrZSBDTURRIGNsaWVu
dCB1c2VyIGlzIGFibGUNCj4gPiA+ID4gdG8NCj4gPiA+ID4gc2VuZGluZyB0aGVpciBIVyBzZXR0
aW5ncyB0byB0aGUgc2VjdXJlIHdvcmxkLiBTbyB0aGF0IEdDRSBjYW4NCj4gPiA+ID4gZXhlY3V0
ZQ0KPiA+ID4gPiBhbGwgaW5zdHJ1Y3Rpb25zIHRvIGNvbmZpZ3VyZSBIVyBpbiB0aGUgc2VjdXJl
IHdvcmxkLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxq
YXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+IA0KPiA+ID4gW3Nu
aXBdDQo+ID4gPiANCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIGJvb2wgY21kcV9zZWNfaXJx
X2hhbmRsZXIoc3RydWN0IGNtZHFfc2VjX3RocmVhZA0KPiA+ID4gPiAqc2VjX3RocmVhZCwNCj4g
PiA+ID4gKwkJCQkgY29uc3QgdTMyIGNvb2tpZSwgY29uc3QgaW50DQo+ID4gPiA+IGVycikNCj4g
PiA+ID4gK3sNCj4gPiA+ID4gKwlzdHJ1Y3QgY21kcV9zZWNfdGFzayAqc2VjX3Rhc2s7DQo+ID4g
PiA+ICsJc3RydWN0IGNtZHFfdGFzayAqdGFzaywgKnRlbXAsICpjdXJfdGFzayA9IE5VTEw7DQo+
ID4gPiA+ICsJc3RydWN0IGNtZHFfc2VjICpjbWRxID0gY29udGFpbmVyX29mKHNlY190aHJlYWQt
DQo+ID4gPiA+ID50aHJlYWQuY2hhbi0NCj4gPiA+ID4gPiBtYm94LCBzdHJ1Y3QgY21kcV9zZWMs
IG1ib3gpOw0KPiA+ID4gPiANCj4gPiA+ID4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ID4g
PiArCWludCBkb25lOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJnNl
Y190aHJlYWQtPnRocmVhZC5jaGFuLT5sb2NrLA0KPiA+ID4gPiBmbGFncyk7DQo+ID4gPiA+ICsJ
aWYgKHNlY190aHJlYWQtPndhaXRfY29va2llIDw9IGNvb2tpZSkNCj4gPiA+ID4gKwkJZG9uZSA9
IGNvb2tpZSAtIHNlY190aHJlYWQtPndhaXRfY29va2llICsgMTsNCj4gPiA+ID4gKwllbHNlIGlm
IChzZWNfdGhyZWFkLT53YWl0X2Nvb2tpZSA9PSAoY29va2llICsgMSkgJQ0KPiA+ID4gPiBDTURR
X01BWF9DT09LSUVfVkFMVUUpDQo+ID4gPiA+ICsJCWRvbmUgPSAwOw0KPiA+ID4gPiArCWVsc2UN
Cj4gPiA+ID4gKwkJZG9uZSA9IENNRFFfTUFYX0NPT0tJRV9WQUxVRSAtIHNlY190aHJlYWQtDQo+
ID4gPiA+ID53YWl0X2Nvb2tpZQ0KPiA+ID4gPiArIDEgKyBjb29raWUgKyAxOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHRhc2ssIHRlbXAsICZzZWNfdGhy
ZWFkLQ0KPiA+ID4gPiA+IHRocmVhZC50YXNrX2J1c3lfbGlzdCwgbGlzdF9lbnRyeSkgew0KPiA+
ID4gPiANCj4gPiA+ID4gKwkJaWYgKCFkb25lKQ0KPiA+ID4gPiArCQkJYnJlYWs7DQo+ID4gPiA+
ICsNCj4gPiA+ID4gKwkJc2VjX3Rhc2sgPSBjb250YWluZXJfb2YodGFzaywgc3RydWN0DQo+ID4g
PiA+IGNtZHFfc2VjX3Rhc2ssDQo+ID4gPiA+IHRhc2spOw0KPiA+ID4gPiArCQljbWRxX3NlY190
YXNrX2RvbmUoc2VjX3Rhc2ssIGVycik7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJaWYgKHNlY190
aHJlYWQtPnRhc2tfY250KQ0KPiA+ID4gPiArCQkJc2VjX3RocmVhZC0+dGFza19jbnQgLT0gMTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArCQlkb25lLS07DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiArDQo+
ID4gPiA+ICsJY3VyX3Rhc2sgPSBsaXN0X2ZpcnN0X2VudHJ5X29yX251bGwoJnNlY190aHJlYWQt
DQo+ID4gPiA+ID4gdGhyZWFkLnRhc2tfYnVzeV9saXN0LA0KPiA+ID4gPiANCj4gPiA+ID4gKwkJ
CQkJICAgIHN0cnVjdCBjbWRxX3Rhc2ssDQo+ID4gPiA+IGxpc3RfZW50cnkpOw0KPiA+ID4gPiAr
CWlmIChlcnIgJiYgY3VyX3Rhc2spIHsNCj4gPiA+ID4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmc2VjX3RocmVhZC0NCj4gPiA+ID4gPnRocmVhZC5jaGFuLT5sb2NrLA0KPiA+ID4gPiBmbGFn
cyk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJc2VjX3Rhc2sgPSBjb250YWluZXJfb2YoY3VyX3Rh
c2ssIHN0cnVjdA0KPiA+ID4gPiBjbWRxX3NlY190YXNrLA0KPiA+ID4gPiB0YXNrKTsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArCQkvKiBmb3IgZXJyb3IgdGFzaywgY2FuY2VsLCBjYWxsYmFjayBhbmQg
ZG9uZSAqLw0KPiA+ID4gPiArCQltZW1zZXQoJmNtZHEtPmNhbmNlbCwgMCwgc2l6ZW9mKGNtZHEt
PmNhbmNlbCkpOw0KPiA+ID4gPiArCQljbWRxX3NlY190YXNrX3N1Ym1pdChjbWRxLCBzZWNfdGFz
aywNCj4gPiA+ID4gQ01EX0NNRFFfSVdDX0NBTkNFTF9UQVNLLA0KPiA+ID4gPiArCQkJCSAgICAg
c2VjX3RocmVhZC0+aWR4LCAmY21kcS0NCj4gPiA+ID4gPmNhbmNlbCk7DQo+ID4gPiANCj4gPiA+
IGNtZHEtPmNhbmNlbCBpcyB1c2VsZXNzLCBzbyBkcm9wIGl0Lg0KPiA+ID4gDQo+ID4gPiBSZWdh
cmRzLA0KPiA+ID4gQ0sNCj4gPiA+IA0KPiA+IA0KPiA+IEkgdGhpbmsgd2Ugc2hvdWxkIHVzZSB0
aGlzIHRvIHRlbGwgQ01EUSBQVEEgd2hpY2ggdGhyZWFkIG5lZWQgdG8NCj4gPiByZXNldA0KPiA+
IGFuZCB1cGRhdGUgaXRzIGNvb2tpZSB2YWx1ZSwgc28gQ01EUSBjYW4gc3RpbGwgbW92ZSBvbiB3
aGVuIGVycm9yDQo+ID4gb2NjdXJzLg0KPiANCj4gQ01EX0NNRFFfSVdDX0NBTkNFTF9UQVNLIGlz
IHVzZWQgdG8gdGVsbCBDTURRIFBUQSB3aGljaCB0aHJlYWQgbmVlZA0KPiB0bw0KPiByZXNldCBh
bmQgdXBkYXRlIGl0cyBjb29raWUgdmFsdWUsIGFuZCBjbWRxLT5jYW5jZWwgaXMgdGhlIHJldHVy
bg0KPiB2YWx1ZS4gQnV0IHlvdSBkb2VzIG5vdCBwcm9jZXNzIHRoaXMgcmV0dXJuIHZhbHVlLCBz
byBkcm9wIGNtZHEtDQo+ID5jYW5jZWwuDQo+IA0KR290IGl0LiBJJ2xsIHJlbW92ZSB0aGF0IHJl
dHVybiB2YWx1ZS4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IFJlZ2FyZHMsDQo+IENL
DQo+IA0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gSmFzb24tSkguTGluDQo=

