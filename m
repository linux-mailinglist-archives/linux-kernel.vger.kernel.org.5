Return-Path: <linux-kernel+bounces-66262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F482855975
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19D61F2CA47
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D716107;
	Thu, 15 Feb 2024 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Xzpg7egq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="O9TRr/1s"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031028E6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707967046; cv=fail; b=BvypNBnGJfHtPqe/3AjIuMqpQumwUnLF7HRAOwh5NSojr5FN3n9k4R32Y063Sa5TazP01pRImaEK8Bp2OxQg6L4ceVrCdfpFfi5qOLwLfO7RDJYkfnN5PNvs9rDS9Rpo+O6nYId3tk70A5BVJvPLVM3p5Ilkw9X4zG1P5ONQpDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707967046; c=relaxed/simple;
	bh=7WZHnhsFYNPnCxLespnUGWYsH7WOOstpb490rsjCsUI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jjZDssX6D0I5poj5uevel4k1Hcq814aPqVQ78raPUgdmp6TRz1pZA8IP7rcJEcxDCApL4qwDrt9Qkg9Gxy8dQ0CMFoMwajHr9YDzc+B1NmkSqLaVkmaMYN21cES27vqRIxtSguZPMkmUxbfQOY7LrsNpeaIKkLQ2lYaIxAVsbbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Xzpg7egq; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=O9TRr/1s; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 994458d2cbae11ee9e680517dc993faa-20240215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=7WZHnhsFYNPnCxLespnUGWYsH7WOOstpb490rsjCsUI=;
	b=Xzpg7egqVTIc1Bk4Iza4I08NrE1QM5J/ZitS98sV6w1AL1+IDScNr8vMfxRD4G2MerS1ugfow/LT8zaTz8bxyB9I1OJiUqE6VO4MBnptdhVCdhq/EQNAfjvKzhKQ3MhFUouOni3wmInP6fxaGvmnQnyHGETuLZ9l7FI23aj9wj0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a95a2331-dea7-433f-a43e-d1f173ed84cf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ae3ce783-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 994458d2cbae11ee9e680517dc993faa-20240215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <kuan-ying.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 471487434; Thu, 15 Feb 2024 11:02:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Feb 2024 11:02:03 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Feb 2024 11:02:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acHP7eKNmt4D5zUwBlLa2YmWmRD8/cJhGlHXXR298XW1F1Rbqs0gw39J8ZB5D23fktU6gzdI46Iobmi875HehG5wPrtEJ0IyNvpbR1UcYxnTX8Z7eTPH6xwMHS+85J9DYJmrNIp5lDAjNt0HGPvvq8jDPm+lhKbux0f3mQf/naLn8PyxBCmLJg3YPMnHPeDNjwQ/GVOMgweGLqiDw2GCGFoGA1KhLjka4BIRNHyQNogSKSv5hLqE3z+6WGpEDOP3aFrSoEwCDkkfgl0v78JGItTH2bQb0iUmBnk7+nV2n9dzCPdTmqZvAwt8V9WFmZ+k8xdzIAm9pjr3u9ekZzCNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WZHnhsFYNPnCxLespnUGWYsH7WOOstpb490rsjCsUI=;
 b=i00hYDYC0IiZEtAtKR2j4U9YY4AYyHTi3N5F7g29d7i4yhI6+IEKt2MA+RXc1yavaKX2yrVWVLPe0BovT+0NP4WhpEuJRHet9LBsAC3+2DvkRs1S33wK0tMuQxLZ2mmprUNI8DnPJV6Uv48DZ7QgvJrmOoSSQHuojeGzBv2drwzXOQhrTy6vWvmH1qV3ckvPcUbpaZolP8iiyMwfGNOaGKxBME7vCCvqvu7F69ppZ+/5wd8bVEWd9rc3cYVyKalmtUH9JhLQg39K5CLHVSKimuqXf8T4BVwr7D88on94yzchQPbrSytGWMpAlBAXFSm8icHvscjt/QNtCZrlkDecVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WZHnhsFYNPnCxLespnUGWYsH7WOOstpb490rsjCsUI=;
 b=O9TRr/1s3AR1J8pEbpHZ+MhOMXShEOlVGa8pIa60eRBM4FPGYizhQC4uPRrPbNkXNSOsu8pudJt2LXC0pMZtz6xR7rrzasv1mOimTi5zH7cbuXxgUtgzzvDRXsKdkaRDHtp19H8DjdzVKfAJl7fgNIry82gKH4FzXNiJ0oKRkA8=
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com (2603:1096:301:b4::11)
 by KL1PR03MB8899.apcprd03.prod.outlook.com (2603:1096:820:148::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 03:02:01 +0000
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::9eca:ae69:b721:31e7]) by PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::9eca:ae69:b721:31e7%5]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 03:02:01 +0000
From: =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?=
	<Kuan-Ying.Lee@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	=?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
	<chinwen.chang@mediatek.com>, =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?=
	<casper.li@mediatek.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "kbingham@kernel.org" <kbingham@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "urezki@gmail.com" <urezki@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>
Subject: Re: [PATCH] scripts/gdb/vmalloc: fix vmallocinfo error
Thread-Topic: [PATCH] scripts/gdb/vmalloc: fix vmallocinfo error
Thread-Index: AQHaWaPmNoi5a2Rih0SlkdhQUUafsbD/jzmAgAAA3oCACzNRAA==
Date: Thu, 15 Feb 2024 03:02:01 +0000
Message-ID: <8e2fbab4c611cc1bbf45f58e88736a0bd0bd6fa2.camel@mediatek.com>
References: <20240207085856.11190-1-Kuan-Ying.Lee@mediatek.com>
	 <20240207155623.a943328ba0b77859246e0d9f@linux-foundation.org>
	 <20240207155929.cc107bcc14b982789bdc9fab@linux-foundation.org>
In-Reply-To: <20240207155929.cc107bcc14b982789bdc9fab@linux-foundation.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5964:EE_|KL1PR03MB8899:EE_
x-ms-office365-filtering-correlation-id: 865008fb-8be5-4a0e-f02b-08dc2dd27b56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XaBBc7NX+zKlPfWhV/RtHd8XJ+Mt1xtAxavAE5LuvhnoyqYBEL5EWRBVhOlVtl4D44gVfH6Ow4DYg0NQN1Ww0M5VkNhOpFIft3EL1xG9p++i/ahVR3vPCk9kpyrLorw5zolZwEnS+Irr77qM/P+ZwRuRg+Q/pZq4vxzGRKk/UvJOwbubsb2VjdyqUcnSe2j6I0Rkbvgj+13okzDuYEGuP8Ri6L0IXmAWS895pLBXnSiQFSTapy5LoF6UMw+q6d2itCCPMs3WpmmIGRDFpOPQTapTtzw+ZbM/hCHa7ZndutF3SZ9BiMjjue1alW/SFOJd8xdnsQvF60Ew2qyWwjL0zYzQDcFeGhny8MQwZBCTM0CcGhbgFYuwCC/9RQjl6EWulw2m7ddKLT99y7zPFRF0QXKnvM09MvKD2nmhT5V/WSf10WtkSd4rjOQZQDDfk5OL7Ipz9VukwCfuDLhhtszZ4321mCv8Y5g7v2Ysg08BkURG4CCz5F9cJIm0XfQXWKtGUMX3+Lezs4K18Lo5F+Bsx6tsreUHVjAOKGtF2p83D9gsqdwGWWwrX70tvfHwgvK8k0H3kaDFgb+y43MQf9ThqHmNhrbA5lddUT7oXaoWvxh/jCk8qiwuWvP2u6PigdwL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(346002)(366004)(230922051799003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(66476007)(5660300002)(64756008)(7416002)(76116006)(66946007)(66446008)(8936002)(8676002)(66556008)(2906002)(38070700009)(83380400001)(26005)(921011)(122000001)(36756003)(85182001)(38100700002)(110136005)(86362001)(71200400001)(316002)(41300700001)(2616005)(478600001)(966005)(6512007)(6506007)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHB3clNLTEtWUDBHdURIeEY3dkNTUElvb0lmcHFlMHJsOVhVY0dpNUhrdkdV?=
 =?utf-8?B?aDgrMFlhd2VCRis1K09RS0t5SzVrMVNmME02OW5SVDRzN2Q3VEMwV1Z0NTln?=
 =?utf-8?B?VytGSTVhWnRtSEN1S3ZjZURtUXlCdThxbDFOOVVEa3kwVzF5bk1rN1QvTlVh?=
 =?utf-8?B?TjIzbGZNckx6NGpjbXVseG56QUNFLzhnRndYT3l1T0dCbERZNitoVTB6bmEx?=
 =?utf-8?B?MmFQaVM0a3NuOFRwcmZYL0d1ZWFUeXhXV1pKQkdpOHpMN0ZheUlPcnBBT3B6?=
 =?utf-8?B?MWE5cjdiSXd5RVl0T0R3SEx5VEUrRGZEWjUwYW9BS2lTWHhmdzdtYUplbXBq?=
 =?utf-8?B?c1ZjeXQ3UDZ0WUVZRURDQ3ZTZDlDUEx3OVloVjREdTBuTEk3Ujh1ZWpsVmZV?=
 =?utf-8?B?aUlIRXhtQ3ptTlptdzZVeWlaWVdhOFN3YzlKNXBSUklVYXkwNVRPS3lMSW9H?=
 =?utf-8?B?c01aUWM4V09Kb0JkRW9nUU9uandEck5TOGc5bVg0NGUwVXRTNGhJVUVuOVJm?=
 =?utf-8?B?QnRuMVBrYU9LbnhaQUZOVU1EU0lFbEloUEhvZFZlallzNlFaS3JyK0Y3NDZo?=
 =?utf-8?B?S3hOU0szWDc5N3Q4aTZFT2N4K0hrVElUalhMc09GWHFQSWJZNU5zYlpXYWZS?=
 =?utf-8?B?a25CSDk1Y1Z3ejZJbXl3Q3kwZStFRmNjeEtqTmdnQURvamw0akJjbmpaU1Q2?=
 =?utf-8?B?L2s1cXhRRzdFaDl5MHFkYnRXOGE4TncxOXZkRWlkcWFGMXFZUWtxV25zTWNj?=
 =?utf-8?B?NWorZkZuckZab2FoSnRyUHJ5ZWxUdG13TzdRWkM3V082UDlGQXVVUG9hU3BG?=
 =?utf-8?B?Sm9lbk5FNFl1Y2ZzSFZmWnh5WGZOZ1lPcGR6Ui90NzZMWEVueVNJZmh5Q205?=
 =?utf-8?B?NWh6MEFoTXE1VlFJSDFaeE0yN3ppR0FDM1VtanFNSDl1K2dpTWRzYlBhUFlV?=
 =?utf-8?B?TjJJdXp3bFFxM0llU3JMMFNDVW5HaTFPS09lU2N1ZFZvWDZDamVTWGNad3R2?=
 =?utf-8?B?d3BscWs1MkVnMlBKM1g4YlVrNWdzdklEVnZjZERGT09LcDlOY2Z2NUVaNlZ4?=
 =?utf-8?B?V3dDaGRvaVN4ZlZjdnNUeVNrMVA2L0NYZms4anJRbFBRM1RhdGdVc2h3S3Jz?=
 =?utf-8?B?TWs2TGVOZVB2RmgzUGNaNUhxb3JMcU5Xd2RvM3MxZEN5bHlPT2xGUE5Jdjd3?=
 =?utf-8?B?Qll3eUpBR24wTWhaMlN0VEhRd2ZRaTl2ZUJ0NDliSEFFR0hGNFc3dUNmMVp2?=
 =?utf-8?B?c3pBNjFoUlhWRmxkdlZ5UC9rMWF2UW96TDM3L2VvZEkyZDhEZUFJNWc1Zk15?=
 =?utf-8?B?QWhDbitrS2tUdElvbGd0RHhmVThWTnlFU2pydzh0SHJIZkZLK2hBbVdBcVBw?=
 =?utf-8?B?RE52U3d5THdQSi94U0Jzdm91Y21hRWJ3SnovKzZjeEVSblZXV2VxOTU4QjEy?=
 =?utf-8?B?R3NaWmxvcW55SDU1TEhiKytpbGpQVk9Wdm1wbnZFTmh2eGU5UGlmZ3B0cUFo?=
 =?utf-8?B?YytuQXcyMCtLVTR1ZThqV2Noc1VFeVEyQlNEV0ZremRnZ1JsMFpaQ054bVcz?=
 =?utf-8?B?UzRTSGlieW1pWEJtdDdtSWd3U3l3eGNid3huUlMzaDhTQ2ZEQU9TNGZpZkhm?=
 =?utf-8?B?VTB2Z0V4SUQ0ZGVMd2V4QmpkTUJCYnNJQk9VcFNlbXdxdSszWEhMamRnMmRq?=
 =?utf-8?B?RTVTd0NvTUsxNGI4eXF4RUR4eEZETDd6Ymx5OTF4VzdCSGxGeHV6NEsxVzYv?=
 =?utf-8?B?TjZGcFRIelVUNlJHQnZLRFJqQkFPSkV4d2owT0RVMVZHT3N6R3JqdmpROUpL?=
 =?utf-8?B?OXpEUU9HTUtGUXlRZ0s4OFh5VGFWWng3OG5QSko2MUxuWExkMlZqbVQ1Y3BJ?=
 =?utf-8?B?Z2xoL2dYY0l1d0Y1QjVJNE1MaDNXZ0F1NGxjbzJnaWI3dytocjNkbDdXVmRu?=
 =?utf-8?B?M2xEbDFrWDNEYWpCY0lscmljV3d0b3hlU3RrNE5YT2tlTkNzY3VHb1hYK255?=
 =?utf-8?B?a05UY3dROEsvYll3by9mbGdocnJ2VG5GWFNXRHNqZ29rd1pFT1g1RG1YQTdT?=
 =?utf-8?B?RnZ4SmpRQ21wSzh0WFRQK2tieStzVlEwZXQrQXF1VzZEVVcraVJoY0lOa0ln?=
 =?utf-8?B?bXBjUWdQeGhJNFJWY3IrTVNKRS8rNFNCdGt4b2VmeS9UM2o3R1Z6aFRzRDhl?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DFE8CE381309143AAD6D5DA2EE2E0DC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865008fb-8be5-4a0e-f02b-08dc2dd27b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 03:02:01.5027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKsg+shO9bst15FC3UDffpKe4NCaM+WZb7aTmHErluhWjn4QuB8wloiEXn8Rfxaw+aGy7qm6AISNMwOENfjXlL6mDlLnztbrT14q6jL5474=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8899
X-MTK: N

T24gV2VkLCAyMDI0LTAyLTA3IGF0IDE1OjU5IC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIE9uIFdlZCwgNyBGZWIgMjAyNCAxNTo1NjoyMyAtMDgwMCBBbmRyZXcg
TW9ydG9uIDwNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiA+ID4g
WzFdIA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDI0MDEwMjE4NDYzMy43
NDgxMTMtMS11cmV6a2lAZ21haWwuY29tLw0KPiA+IA0KPiA+IHZtYXBfYXJlYV9saXN0IHdhcyBy
ZW1vdmVkIGJ5IA0KPiBodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIwMjQwMTAyMTg0NjMzLjc0
ODExMy02LXVyZXpraUBnbWFpbC5jb20NCj4gPiANCj4gPiBTbyBJIHRoaW5rIHRoaXMgcGF0Y2gg
aXMgYWN0dWFsbHkgYSBmaXggYWdhaW5zdCBtbS5naXQ6bW0tDQo+IHVuc3RhYmxlJ3MNCj4gPiBt
bS12bWFsbG9jLXJlbW92ZS12bWFwX2FyZWFfbGlzdC5wYXRjaD8NCj4gPiANCg0KWWVzLCB5b3Ug
YXJlIHJpZ2h0Lg0KVGhhbmtzIGZvciBoZWxwaW5nIHRvIGZpeCB0aGUgY29tbWl0IG1lc3NhZ2Uu
DQoNCj4gPiBIb3dldmVyIHRoaXMgZ2RiIGZ1bmN0aW9uIHdhcyBwcm9iYWJseSBwcm9iYWJseSBi
cm9rZW4gZWFybGllciBpbg0KPiB0aGF0DQo+ID4gc2VyaWVzLCBzbyBwZXJoYXBzIHRoaXMgcGF0
Y2ggd291bGQgYmUgYmVzdCBzdGFnZWQgYXMgYSBwcmVkZWNlc3Nvcg0KPiB0bw0KPiA+IFVsYWQn
cyB2bWFsbG9jIHNlcmllcy4NCj4gDQo+IGllLCB0aGlzOg0KPiANCj4gDQo+IEZyb206IEt1YW4t
WWluZyBMZWUgPEt1YW4tWWluZy5MZWVAbWVkaWF0ZWsuY29tPg0KPiBTdWJqZWN0OiBzY3JpcHRz
L2dkYi92bWFsbG9jOiBmaXggdm1hbGxvY2luZm8gZXJyb3INCj4gRGF0ZTogV2VkLCA3IEZlYiAy
MDI0IDE2OjU4OjUxICswODAwDQo+IA0KPiBUaGUgcGF0Y2ggc2VyaWVzICJNaXRpZ2F0ZSBhIHZt
YXAgbG9jayBjb250ZW50aW9uIiByZW1vdmVzDQo+IHZtYXBfYXJlYV9saXN0LA0KPiB3aGljaCB3
aWxsIGJyZWFrIHRoZSBnZGIgdm1hbGxvY2luZm8gY29tbWFuZDoNCj4gDQo+IChnZGIpIGx4LXZt
YWxsb2NpbmZvDQo+IFB5dGhvbiBFeGNlcHRpb24gPGNsYXNzICdnZGIuZXJyb3InPjogTm8gc3lt
Ym9sICJ2bWFwX2FyZWFfbGlzdCIgaW4NCj4gY3VycmVudCBjb250ZXh0Lg0KPiBFcnJvciBvY2N1
cnJlZCBpbiBQeXRob246IE5vIHN5bWJvbCAidm1hcF9hcmVhX2xpc3QiIGluIGN1cnJlbnQNCj4g
Y29udGV4dC4NCj4gDQo+IFNvIHdlIGNhbiBpbnN0ZWFkIHVzZSB2bWFwX25vZGVzIHRvIGl0ZXJh
dGUgYWxsIHZtYWxsb2NpbmZvLg0KPiANCj4gTGluazogDQo+IGh0dHBzOi8vbGttbC5rZXJuZWwu
b3JnL3IvMjAyNDAyMDcwODU4NTYuMTExOTAtMS1LdWFuLVlpbmcuTGVlQG1lZGlhdGVrLmNvbQ0K
PiBTaWduZWQtb2ZmLWJ5OiBLdWFuLVlpbmcgTGVlIDxLdWFuLVlpbmcuTGVlQG1lZGlhdGVrLmNv
bT4NCj4gQ2M6IENhc3BlciBMaSA8Y2FzcGVyLmxpQG1lZGlhdGVrLmNvbT4NCj4gQ2M6IEFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xs
YWJvcmEuY29tPg0KPiBDYzogQ2hpbndlbiBDaGFuZyA8Y2hpbndlbi5jaGFuZ0BtZWRpYXRlay5j
b20+DQo+IENjOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBDYzogS2ll
cmFuIEJpbmdoYW0gPGtiaW5naGFtQGtlcm5lbC5vcmc+DQo+IENjOiBNYXR0aGlhcyBCcnVnZ2Vy
IDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiBDYzogUXVuLVdlaSBMaW4gPHF1bi13ZWkubGlu
QG1lZGlhdGVrLmNvbT4NCj4gQ2M6IFVsYWR6aXNsYXUgUmV6a2kgKFNvbnkpIDx1cmV6a2lAZ21h
aWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5k
YXRpb24ub3JnPg0KPiAtLS0NCj4gDQo+ICBzY3JpcHRzL2dkYi9saW51eC92bWFsbG9jLnB5IHwg
ICA1NiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAtDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+IA0KPiAtLS0gYS9zY3Jp
cHRzL2dkYi9saW51eC92bWFsbG9jLnB5fnNjcmlwdHMtZ2RiLXZtYWxsb2MtZml4LQ0KPiB2bWFs
bG9jaW5mby1lcnJvcg0KPiArKysgYS9zY3JpcHRzL2dkYi9saW51eC92bWFsbG9jLnB5DQo+IEBA
IC0yOSwzMiArMjksMzQgQEAgY2xhc3MgTHhWbWFsbG9jSW5mbyhnZGIuQ29tbWFuZCk6DQo+ICAg
ICAgICAgIGlmIG5vdCBjb25zdGFudHMuTFhfQ09ORklHX01NVToNCj4gICAgICAgICAgICAgIHJh
aXNlIGdkYi5HZGJFcnJvcigiUmVxdWlyZXMgTU1VIHN1cHBvcnQiKQ0KPiAgDQo+IC0gICAgICAg
IHZtYXBfYXJlYV9saXN0ID0gZ2RiLnBhcnNlX2FuZF9ldmFsKCd2bWFwX2FyZWFfbGlzdCcpDQo+
IC0gICAgICAgIGZvciB2bWFwX2FyZWEgaW4gbGlzdHMubGlzdF9mb3JfZWFjaF9lbnRyeSh2bWFw
X2FyZWFfbGlzdCwNCj4gdm1hcF9hcmVhX3B0cl90eXBlLCAibGlzdCIpOg0KPiAtICAgICAgICAg
ICAgaWYgbm90IHZtYXBfYXJlYVsndm0nXToNCj4gLSAgICAgICAgICAgICAgICBnZGIud3JpdGUo
IjB4JXgtMHgleCAlMTBkIHZtX21hcF9yYW1cbiIgJQ0KPiAodm1hcF9hcmVhWyd2YV9zdGFydCdd
LCB2bWFwX2FyZWFbJ3ZhX2VuZCddLA0KPiAtICAgICAgICAgICAgICAgICAgICB2bWFwX2FyZWFb
J3ZhX2VuZCddIC0gdm1hcF9hcmVhWyd2YV9zdGFydCddKSkNCj4gLSAgICAgICAgICAgICAgICBj
b250aW51ZQ0KPiAtICAgICAgICAgICAgdiA9IHZtYXBfYXJlYVsndm0nXQ0KPiAtICAgICAgICAg
ICAgZ2RiLndyaXRlKCIweCV4LTB4JXggJTEwZCIgJSAodlsnYWRkciddLCB2WydhZGRyJ10gKw0K
PiB2WydzaXplJ10sIHZbJ3NpemUnXSkpDQo+IC0gICAgICAgICAgICBpZiB2WydjYWxsZXInXToN
Cj4gLSAgICAgICAgICAgICAgICBnZGIud3JpdGUoIiAlcyIgJSBzdHIodlsnY2FsbGVyJ10pLnNw
bGl0KCcgJylbLTFdKQ0KPiAtICAgICAgICAgICAgaWYgdlsnbnJfcGFnZXMnXToNCj4gLSAgICAg
ICAgICAgICAgICBnZGIud3JpdGUoIiBwYWdlcz0lZCIgJSB2Wyducl9wYWdlcyddKQ0KPiAtICAg
ICAgICAgICAgaWYgdlsncGh5c19hZGRyJ106DQo+IC0gICAgICAgICAgICAgICAgZ2RiLndyaXRl
KCIgcGh5cz0weCV4IiAlIHZbJ3BoeXNfYWRkciddKQ0KPiAtICAgICAgICAgICAgaWYgdlsnZmxh
Z3MnXSAmIGNvbnN0YW50cy5MWF9WTV9JT1JFTUFQOg0KPiAtICAgICAgICAgICAgICAgIGdkYi53
cml0ZSgiIGlvcmVtYXAiKQ0KPiAtICAgICAgICAgICAgaWYgdlsnZmxhZ3MnXSAmIGNvbnN0YW50
cy5MWF9WTV9BTExPQzoNCj4gLSAgICAgICAgICAgICAgICBnZGIud3JpdGUoIiB2bWFsbG9jIikN
Cj4gLSAgICAgICAgICAgIGlmIHZbJ2ZsYWdzJ10gJiBjb25zdGFudHMuTFhfVk1fTUFQOg0KPiAt
ICAgICAgICAgICAgICAgIGdkYi53cml0ZSgiIHZtYXAiKQ0KPiAtICAgICAgICAgICAgaWYgdlsn
ZmxhZ3MnXSAmIGNvbnN0YW50cy5MWF9WTV9VU0VSTUFQOg0KPiAtICAgICAgICAgICAgICAgIGdk
Yi53cml0ZSgiIHVzZXIiKQ0KPiAtICAgICAgICAgICAgaWYgdlsnZmxhZ3MnXSAmIGNvbnN0YW50
cy5MWF9WTV9ETUFfQ09IRVJFTlQ6DQo+IC0gICAgICAgICAgICAgICAgZ2RiLndyaXRlKCIgZG1h
LWNvaGVyZW50IikNCj4gLSAgICAgICAgICAgIGlmIGlzX3ZtYWxsb2NfYWRkcih2WydwYWdlcydd
KToNCj4gLSAgICAgICAgICAgICAgICBnZGIud3JpdGUoIiB2cGFnZXMiKQ0KPiAtICAgICAgICAg
ICAgZ2RiLndyaXRlKCJcbiIpDQo+ICsgICAgICAgIG5yX3ZtYXBfbm9kZXMgPSBnZGIucGFyc2Vf
YW5kX2V2YWwoJ25yX3ZtYXBfbm9kZXMnKQ0KPiArICAgICAgICBmb3IgaSBpbiByYW5nZSgwLCBu
cl92bWFwX25vZGVzKToNCj4gKyAgICAgICAgICAgIHZuID0gZ2RiLnBhcnNlX2FuZF9ldmFsKCcm
dm1hcF9ub2Rlc1slZF0nICUgaSkNCj4gKyAgICAgICAgICAgIGZvciB2bWFwX2FyZWEgaW4NCj4g
bGlzdHMubGlzdF9mb3JfZWFjaF9lbnRyeSh2blsnYnVzeSddWydoZWFkJ10sIHZtYXBfYXJlYV9w
dHJfdHlwZSwNCj4gImxpc3QiKToNCj4gKyAgICAgICAgICAgICAgICBpZiBub3Qgdm1hcF9hcmVh
Wyd2bSddOg0KPiArICAgICAgICAgICAgICAgICAgICBnZGIud3JpdGUoIjB4JXgtMHgleCAlMTBk
IHZtX21hcF9yYW1cbiIgJQ0KPiAodm1hcF9hcmVhWyd2YV9zdGFydCddLCB2bWFwX2FyZWFbJ3Zh
X2VuZCddLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgdm1hcF9hcmVhWyd2YV9lbmQnXSAt
DQo+IHZtYXBfYXJlYVsndmFfc3RhcnQnXSkpDQo+ICsgICAgICAgICAgICAgICAgICAgIGNvbnRp
bnVlDQo+ICsgICAgICAgICAgICAgICAgdiA9IHZtYXBfYXJlYVsndm0nXQ0KPiArICAgICAgICAg
ICAgICAgIGdkYi53cml0ZSgiMHgleC0weCV4ICUxMGQiICUgKHZbJ2FkZHInXSwgdlsnYWRkcidd
ICsNCj4gdlsnc2l6ZSddLCB2WydzaXplJ10pKQ0KPiArICAgICAgICAgICAgICAgIGlmIHZbJ2Nh
bGxlciddOg0KPiArICAgICAgICAgICAgICAgICAgICBnZGIud3JpdGUoIiAlcyIgJSBzdHIodlsn
Y2FsbGVyJ10pLnNwbGl0KCcgJylbLQ0KPiAxXSkNCj4gKyAgICAgICAgICAgICAgICBpZiB2Wydu
cl9wYWdlcyddOg0KPiArICAgICAgICAgICAgICAgICAgICBnZGIud3JpdGUoIiBwYWdlcz0lZCIg
JSB2Wyducl9wYWdlcyddKQ0KPiArICAgICAgICAgICAgICAgIGlmIHZbJ3BoeXNfYWRkciddOg0K
PiArICAgICAgICAgICAgICAgICAgICBnZGIud3JpdGUoIiBwaHlzPTB4JXgiICUgdlsncGh5c19h
ZGRyJ10pDQo+ICsgICAgICAgICAgICAgICAgaWYgdlsnZmxhZ3MnXSAmIGNvbnN0YW50cy5MWF9W
TV9JT1JFTUFQOg0KPiArICAgICAgICAgICAgICAgICAgICBnZGIud3JpdGUoIiBpb3JlbWFwIikN
Cj4gKyAgICAgICAgICAgICAgICBpZiB2WydmbGFncyddICYgY29uc3RhbnRzLkxYX1ZNX0FMTE9D
Og0KPiArICAgICAgICAgICAgICAgICAgICBnZGIud3JpdGUoIiB2bWFsbG9jIikNCj4gKyAgICAg
ICAgICAgICAgICBpZiB2WydmbGFncyddICYgY29uc3RhbnRzLkxYX1ZNX01BUDoNCj4gKyAgICAg
ICAgICAgICAgICAgICAgZ2RiLndyaXRlKCIgdm1hcCIpDQo+ICsgICAgICAgICAgICAgICAgaWYg
dlsnZmxhZ3MnXSAmIGNvbnN0YW50cy5MWF9WTV9VU0VSTUFQOg0KPiArICAgICAgICAgICAgICAg
ICAgICBnZGIud3JpdGUoIiB1c2VyIikNCj4gKyAgICAgICAgICAgICAgICBpZiB2WydmbGFncydd
ICYgY29uc3RhbnRzLkxYX1ZNX0RNQV9DT0hFUkVOVDoNCj4gKyAgICAgICAgICAgICAgICAgICAg
Z2RiLndyaXRlKCIgZG1hLWNvaGVyZW50IikNCj4gKyAgICAgICAgICAgICAgICBpZiBpc192bWFs
bG9jX2FkZHIodlsncGFnZXMnXSk6DQo+ICsgICAgICAgICAgICAgICAgICAgIGdkYi53cml0ZSgi
IHZwYWdlcyIpDQo+ICsgICAgICAgICAgICAgICAgZ2RiLndyaXRlKCJcbiIpDQo+ICANCj4gIEx4
Vm1hbGxvY0luZm8oKQ0KPiBfDQo+IA0K

