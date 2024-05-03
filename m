Return-Path: <linux-kernel+bounces-167532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0738BAAF2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8959B22186
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E421514D0;
	Fri,  3 May 2024 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nAOI6/9K";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kBmJmwla"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB72135B;
	Fri,  3 May 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733047; cv=fail; b=KXmAenhf0ewz5pSMANLkxFEHQ8VLF1yveYek37dS1xS1DErNM35OGisZyeH/1B/yFGShvjx5AmF9uL2p0LR5OuODFFdqasN1GC1JbgTZevVH8HwiIEqZqWUlzzi2vVImBbmKPvfzCpN4JUmY/seG7LWDvVcoReVz/TF9ifNleI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733047; c=relaxed/simple;
	bh=C+fdFZyOdoU6E2xUYit67BAKex+e+Csp1aPD6A5PBg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vnp1pkQMqgdblgnd9nHvt7j/9G7S8cNwiebCimqoY0ebsWl2hCY1W9lX0ZTtVS1sgtULSaGvFkZ5ig+GinmY3wCSik/Vdf+JscdZoF+S0KOs+Dvzi2J90qUt/5MVehLH2nHt5v8twXPfcc2a+IKubw++0n5f9+8SGHQ2Kul8mI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nAOI6/9K; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kBmJmwla; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714733046; x=1746269046;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C+fdFZyOdoU6E2xUYit67BAKex+e+Csp1aPD6A5PBg8=;
  b=nAOI6/9KPajzxyiJoEJtwnqg8w59K6XcUccVK/rxZf1l4phELzlOjbjN
   WT+OeQeZmCIJXZl3a+YFvVzvtPuH1pC7CLayj60ADQg4RK9hEqxNNyfpK
   f+obCaXC7D0wXgvvNRVo/Rqb0VOC4A1XNWzjIO2sQGr18lhVuXh0GKqB0
   ojBkb8XJv6jIVElTNL8OkuFQ24921IzN4520wWgrK7oAP0mKcDtkg3jw/
   fAqjG6FhG3dI4Zj1IYpQBMx4/MlBUSzAFLjWeqiZkXpy8l8d09BIReMWp
   u77L5mL5KfgNI4r3J8P0o2sf8qW7AMO+MAUhRoXZ8bCdT1PQWiDoUgPU/
   w==;
X-CSE-ConnectionGUID: aGrhGeQrT6WqoIRC01+57g==
X-CSE-MsgGUID: U8NTCfrPT4SnGD5C8ASuvg==
X-IronPort-AV: E=Sophos;i="6.07,251,1708358400"; 
   d="scan'208";a="15257871"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2024 18:43:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e61Q7tbuliQ7dabfKbrX6fzgTjdoLHRz67mzNs/4616Sx7YuYc9bvSUGAyEOMAVvAL3OZuxU87YTNfwZMnscREXnXRJETCq/UBWyGx+74ECt5h0XutNXkctxnhMtsx8LLiZoWb30J3LprBZYxpaqdNgZLm6zu4luefhXaLiGVvl4WRc6AOuQtlupmxML/c+uy0EJgna1qoKg9fYWQkQHBQxRHSh1bK2JXEB+tnZbPvagYCQbwF5hmPrvENOJub6mPrstvSL/dY4qGkX+8UqAR8+FJY5VBEiuNewPwGrkDHy44AYHJXk7foWV6aKPgaqwrORawTmpA41fasSGSwZhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+fdFZyOdoU6E2xUYit67BAKex+e+Csp1aPD6A5PBg8=;
 b=gm6VuM1j7bfqhGo4p/Vxn+9GUBjtVfDH8QTYDcsAfKZcvRmy/JkhJlDqgM6i1ig7QGOhO9y9eOQOdto1WnXNnmn7UrBxf2NBIG2BgHfeSF60PGNIepkib8hFc0kz1S7CXJPnEgugFYO37FAyTryKPljNEC9n0/lcxjgLE+vJxNbU8H1LB/FPT/Lpp+axPkVFp1nDk2DT1JjQXVBibQxB499hS0Z5q1qKUSrC92OetAwQ2JgkpWuBeeNhwcbiZgtTOwqQEPFmKmpGrZ8iUWmAxanxzOtCtaNgyWZcNr20lH8HyaZz5k7ehlO7v2zgwyQAqlgzXHrrv7h4dlUGOk4q2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+fdFZyOdoU6E2xUYit67BAKex+e+Csp1aPD6A5PBg8=;
 b=kBmJmwlaHqTVVz3aBPScCfRpBlcgwQJ+KNUunCChixDPjGyUFE3wzKDTTzwoUUcIuku6OY6pE6SKbE9TxRk7DUw9gECKgzrMZMXgmG905V5ikFg4lsK2go5SXEkjweSFTxbT+pQPLbCjzDqTgCmQLQgnoM2IvfJ92h/e43JKl8U=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM8PR04MB7944.namprd04.prod.outlook.com (2603:10b6:8:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.30; Fri, 3 May 2024 10:43:56 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::73a8:8d4e:8c05:62a5]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::73a8:8d4e:8c05:62a5%5]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 10:43:56 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <huobean@gmail.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
CC: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: Allow RTT negotiation
Thread-Topic: [PATCH] scsi: ufs: Allow RTT negotiation
Thread-Index: AQHanJN3smS5sBuLWEmHzoXjg+8MlbGEWvmAgAD4/OA=
Date: Fri, 3 May 2024 10:43:56 +0000
Message-ID:
 <DM6PR04MB6575A1337E81A241CD37FCB1FC1F2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240502131943.7292-1-avri.altman@wdc.com>
 <4fe336f1-0441-4697-9da5-45a5f7a4007a@gmail.com>
In-Reply-To: <4fe336f1-0441-4697-9da5-45a5f7a4007a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM8PR04MB7944:EE_
x-ms-office365-filtering-correlation-id: 36e89da1-9dfa-4668-2c16-08dc6b5def01
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkZzUXIwQWVLOHFpblV4ZEJFNVBIR0Y3MnVpanhkOG1yaHhHUXA3ZUNWaUZN?=
 =?utf-8?B?WUhCNzdjbU5JazU5RHlONnAvUlZ1Y011d05raVZ6SmFnWXpZdHFZUnhwQWUw?=
 =?utf-8?B?ZHJSUTN4UGtMb0EwVjBuV0lPcU0zdGpRZjBKa0VRTm01NG1NTXBoampSQlNL?=
 =?utf-8?B?WFBRb3FJTUxaMlBuVWRtbXF2Q2Nnc2UrSm5lay9IYjIzVzB2c1FDTjB0ZUxK?=
 =?utf-8?B?ekNhZVdHc2Q5dGZReDA3OGE3QkdzNDJFYWNOcFdCVlVyUG0xOXB4ODRiUDkv?=
 =?utf-8?B?VlBXM0VjbS85bC9weFNxTzZtL0RoUE9pVUNOZkZhUnRvbDBFbnlna0Ficito?=
 =?utf-8?B?UkJxMUMzbGtCdG9hOGllSGYrM0cwd2xYR2podldUZUVVSHRGY09uRnIvb1pQ?=
 =?utf-8?B?VnEzUUFma2lyb0ZEZ2VkK2N5WkdqRnZZYkcxNjBFSzdxTzU1RFg1Q29MVDFu?=
 =?utf-8?B?QkhoVkpUbmI5andKT2pTQjNOSnpBdmwxMzhlYXZvaS9ZSGtiZ2I2QldncDVy?=
 =?utf-8?B?V2xYL1ZiaWxFQUtnc2JPUDhZZlZ4RVliVHZIMkZmVW93dkowZEcrdlREMkUz?=
 =?utf-8?B?ZzlVWEdIUFpIUzNoTVNFTm1MV2lPVitCTi9tamUxRDFjTWRLMlpHclFYK1Q4?=
 =?utf-8?B?Q0t4SysxNDFPY2Y0UXNpQW1DbkZkVHI5WWFqbVB4SWtxdnZwYXREcUlwUHFa?=
 =?utf-8?B?SEk3N0Y3RjVzWW11b0p6RUJEdzQ2TC9tSXM3SG03ZEp5TWc3SjZFNnRKYUt4?=
 =?utf-8?B?SVdRRFd1a0NXbXFQa0kwZ1BKaExyTjBQdktBdzRFWjFQYi9wRmRqS2ladFJ4?=
 =?utf-8?B?RWF3Tlo4b3l5WnJYMmNSMU9WSVA0Y2dOTXoraWErNTlCM2dDdUJLRUZHVGxP?=
 =?utf-8?B?Q1gxTVRKcWpDZmtJRlFzSm1mcFZ2SzgzMEJ2SUxzREw3VXNTaXI4dGxIRGp6?=
 =?utf-8?B?NGlWTHdzZUZWVG5VenNkdkpKNXNIN1hxZzBEQU01UkdLK29vL2NKaHk5a0s3?=
 =?utf-8?B?T3Z3cVJrMjhNSjNjdktJdDRsdHBWaXIrbzgvKy9qakNMT1lVb09lSUFLZ3VK?=
 =?utf-8?B?OVlLRmJxMkh0OGwvL0trbmY5MDVPYUdXbFlzVTljM0VDZm5VWUlqVWxpNUcw?=
 =?utf-8?B?Sis3Y0tGL1ZDUGpQeTI4MUg2aGNLUzZ6MlVmS2N2V0F5WmlmNTVrZk9idFpC?=
 =?utf-8?B?Z1IydFVCY2R3ZWwxRlVzNDJDRDFyTUhvU2hZWUlyMGdSTDcvanBjOGJTVHow?=
 =?utf-8?B?V2dwOCtPa3VLcU0xRDRQYWNnQ0pGV2w2QXRlWm9mZnV0NnpObEtsaEJJM2RO?=
 =?utf-8?B?cU5kNmFsSlJjNWZWbW5SdndWS2ROeUc2c2ZCbGFyMUJ2NjRENmlYYi9VR0ZB?=
 =?utf-8?B?QW9wQjhmNmZ2L3N5N3Zka2U3N3lYMm9FLyt1a2FWTC9LOUU0RTVhaGN3aExF?=
 =?utf-8?B?WUxycEY5aitEb0cxTU9xcnZTZU04UUYzU09aN0UwY0hoMGFkdS9yYXVmenZW?=
 =?utf-8?B?T05VRi9ZYUpIejE0QW1zMFJRQkRtL29sQnoyUmo3MzdtRGRFNXZwUXgwYU1k?=
 =?utf-8?B?RUYwUnpwMGtKTVF5UXdKUUFQaDBFc3lHYlpTM1QvdkF4aURZOFR6cUQ4bnYr?=
 =?utf-8?B?eDFxdzRXWG4zZytRMW9QcjZYWXY3eUpsejRuVkRzQXNIVGFRSXJMdVFkNVN3?=
 =?utf-8?B?ci9zODhUSEo3OE1yakpDUnl6RXFuYXk2S05MSERvUE1hZVZ2UzNWeDZiMzBa?=
 =?utf-8?B?S3RGNG5SMlFMSWhLak5YQlliVE9wMFBQaFZmSmwydXVYeHZ6bzNuU2hPUnh2?=
 =?utf-8?B?bGJaZTVSNG9vdzh4V3kyZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFY1U0REeU9tY0JUWTlaOWtRSnpGQjVScjBCVUFmYXJUZHUxWm9Fbkc2cjhQ?=
 =?utf-8?B?ZXFhSE1MenlSMDFLS3U3ZW5rdWtVYVpoaThRVnFBMDhvOURGd2FKcFhjVnFq?=
 =?utf-8?B?M01UWkFmRXV6TDNFS1lqZ0trbFoyU2V0dzdVZ3VBSkJRbjJkTlZzRGcwRTRw?=
 =?utf-8?B?YjNGbUFUMThRV09ZYjUydXJtNHBBZTdGSlBpdlRxNTJpWThUY2RiQzhuUlJ1?=
 =?utf-8?B?MU9sQXlhaXRlSHVRbVI0V0RXa3paTFJhUDJ6TjhjZ2FGYXVsaGtlSVMzM3ZH?=
 =?utf-8?B?Ujh0TWxUWVROeFE3QUpOMnYwS0wzeUtJWGo1ZkIvK1RTaG1lS3RwZmRWMUNp?=
 =?utf-8?B?NjJES0g1aC9JenRuZ3VHWktXTjNTWk5wK3FkQkVuTVJTTlFQY1NRNXExTUo5?=
 =?utf-8?B?bTk1bnNEeS9UU2NnY3pCeWdoQ1JncFh2cFlQUlF1TU1QWE0yL1o5VUVUdE1s?=
 =?utf-8?B?YUhXeEZ5WlhTOE5GSS9WRElmS0xDcVBlTDBDZVVYcEp3Ukt4ai9BU2Jtcm56?=
 =?utf-8?B?WVdaNFpWcEE0TXZTUjRBQnZLM2p5aTVCTkFjanl4YTRodUxycXNnZ0dYZXBW?=
 =?utf-8?B?VnBQNnVpb0xjQW85cEEzSkRSb0VOREZNdFRsZ1gvVEdKT0lDZi9ZNW1PbmhU?=
 =?utf-8?B?aU5XWW0ydGlMQm9aU3dDQ2RZMzZndTVabGl2UXVDMGpoL1hBeU5Zb0t5amkx?=
 =?utf-8?B?ZE9SZjZQRFJYV1FoTnMxbklTMFdqbk1VNnAyZ2owWEVSSnV3K0RsNXFoclBn?=
 =?utf-8?B?SnhrWURydzY2N3VqTStaaU5wZmQ4dTA1b3RkK0JQS2pGQVdBRXBNMkY1THpK?=
 =?utf-8?B?RCtwbDVMZnRDY01CWU1lbTV1OTIyWDJqRGlHblRObHpYaUFQWXZicmZRRWhF?=
 =?utf-8?B?U1BNems0YlEzOXp0WDZsd2g1Q2VlU3lTZU9pZU8zMENBazNRaVNTcU1USzkw?=
 =?utf-8?B?WWJYMDNJOFFHem9qUm13RWdBOHNPK0FlWlNMTEtOc2g4aVZIZUNNV2lwUUFw?=
 =?utf-8?B?VjhUSlhVMElSS2N6TjVJWTBZWlFNaEhiZjdCMzQvaVVHZzViWTVJZml2VDZ0?=
 =?utf-8?B?Y28xRWZ4dmZBTGxoMXdWWi85UW9BYWZhdHFLcTVoRzVsNnlsdWpKR2J3WExl?=
 =?utf-8?B?TVNnOUQzajZwOEt0eU92UzV6VDhrMCtWT1VadDExRmhYVEVVMjh2bnVteVpZ?=
 =?utf-8?B?ell3MnBWaUxUVkFxdXFkeVlUWmhKa1NNcjZrQWVTVzBYNzlVL3p1Z2dHcjRO?=
 =?utf-8?B?S0NEajlNckhYUVhYK2NiK3lIOVQwVklwRXk2SkJ6QXYrRGYwaVZhVG5URVNy?=
 =?utf-8?B?MGFJMk1FaDJ5ejVOY1VLaVVkdXIzcVNNMEI5Ri91YkUvT3dBVDBIMzA3UnNz?=
 =?utf-8?B?c2lsQkdIMGZWQ24yTFMzcys4RFFLMDU2eG40b0ZRNm5oZHlzUEVWa1V3eDd2?=
 =?utf-8?B?OTJzMkErYnNjY0g0Sncyc1NZdnBrOHhVb2xsRm5xWjdsdDJHcTdjR2hwV2ox?=
 =?utf-8?B?UGl0MzZkVmUxd3ZGK0hXRncvT2dDM1FUemlCc0N6QlIxZWlZRVYzWVZORDh5?=
 =?utf-8?B?cVloUUNCaWd4Yit0UjBFOXJ4b1ZJbUFSYWxIMnJ5dDZJZC90NjBuVUJnQjRE?=
 =?utf-8?B?Mkw0dGZkVGxBMWdFdFlEeUxBZmdIZFhUYmNKNGwrSEtqNTB2RTFBMzE4TzBi?=
 =?utf-8?B?a0o1dEpRUDhZUzVaU0kxbmJ3Z3phaHdkWDdsRlZuUHZCcnFjMis0QkdldG5B?=
 =?utf-8?B?NUJJaFQ0RUEwSFNvYS9GVWtuMHlIT1QzNzVDR3JJWjV2d2d3Rlo0b0lCOXZ6?=
 =?utf-8?B?UkVuOWJ2MU9zQWVBL2xqMW5rR3VyMzFXVnQ2Z0RDQlo2RHRCQmpkdkdKOGdR?=
 =?utf-8?B?bGtmaHRkQWZwRjArNnBUVEpRZE0rVU92U2FYL21LaTZER1dZbjd3LzM1dWc3?=
 =?utf-8?B?UmRaRmtGc2dDSTQ0NVQ4L3pyayt1RWRvSjNOZmpqQjBVK2JBOFJONkppK2sv?=
 =?utf-8?B?OW9ZdlltYW5xSldnYWNqYnhFbXlFTzJ6R0g1c2hkZGd6MVVXM2g5QVdsbkRY?=
 =?utf-8?B?QS9VSXlBeEdHL3R1TVlPMG9wdEFRd2MyN1F0RXdjMWFrLzVBbXZ4Z3Nja3BZ?=
 =?utf-8?Q?xG8TTMsTVjnxXIulb8grYSmIX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	phkzRkuKTOvFLzOnr2stFmjUiZyVC0bYzczhn4XbDgbPdht1V23z9pRsyGGR4HIUJ4RM6lCcaFvfR3oLqX6jwETWQZwryDbqIQDjLIIBb7EM4nX1NN03c7hfbJuw0fYcpEHdmpx/1j3s7ZT92mhBZ9K/Gj1F55C97A6xI8efgaGnJP42K+tFg9nBLkWFjvanteKDVHCvWVgjLPhOHQv/ibEFRzflw8td5+0cI+qcj/XihtpDup0HyEoQTGa7CCDR/qErtqRU62KjXMPR2gVnlLLZ6p8+kfd5U6aA+Wb97GlwakyY5NGTMzLVtCJvfAeZ8b4CDVt92gXtaI5KpkXzSuS8yOXQA2KeP8Nip+kVUtGPEI0nmHj+74gFGHEDcPkQ2IpiGiUhO1Kcg88WuAb1AHP3vep0DKWobGGQYTe1PorjhvruPLGsMOxmkCnF4dVJPiwDwAtZkhd/4HJsDxPiHvbQx8uiTFnuqiNCcT/O3f5UNhsi8g83c8LIPGRIUTwAFtmVnThQp1x83gfsfqygCluzLuo2Rpj8p8demqJVl5IGzILz42WLdYHrJJ588nfqevd5ZHUPH0CjMaG0L8c5eSvtSvgVcjZ4TOFdtd3udBNWmq3uqIQtnjF1dulRcogK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e89da1-9dfa-4668-2c16-08dc6b5def01
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 10:43:56.5221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xu/i2c4jC1WtDbnbfMPeblLUu9Bv+h9aGZmXfkcS3kRPWfc71Isn53SRT/vOnNnqDckAt6oVSiRfunSBJ1SgSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7944

PiBBdnJpLA0KPiANCj4gT24gMDIuMDUuMjQgMzoxOSBQTSwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+
ID4gKyAgICAgLyogUlRUIG92ZXJyaWRlIG1ha2VzIHNlbnNlIG9ubHkgZm9yIFVGUy00LjAgYW5k
IGFib3ZlICovDQo+ID4gKyAgICAgaWYgKGRldl9pbmZvLT53c3BlY3ZlcnNpb24gPCAweDQwMCkN
Cj4gPiArICAgICAgICAgICAgIHJldHVybjsNCj4gPiArDQo+ID4gKyAgICAgcnR0ID0gbWluX3Qo
aW50LCBkZXNjX2J1ZltERVZJQ0VfREVTQ19QQVJBTV9SVFRfQ0FQXSwgaGJhLT5ub3J0dCk7DQo+
ID4gKyAgICAgLyogcnR0IGlzIDIgYWZ0ZXIgbWFudWZhY3R1cmluZyAqLw0KPiA+ICsgICAgIGlm
IChydHQgPCAzKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gPiArICAgICBp
ZiAodWZzaGNkX3F1ZXJ5X2F0dHJfcmV0cnkoaGJhLCBVUElVX1FVRVJZX09QQ09ERV9XUklURV9B
VFRSLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRVUVSWV9BVFRSX0lE
Tl9NQVhfTlVNX09GX1JUVCwgMCwgMCwgJnJ0dCkpDQo+ID4gKyAgICAgICAgICAgICBkZXZfZXJy
KGhiYS0+ZGV2LCAiZmFpbGVkIHdyaXRpbmcgYk1heE51bU9mUlRUXG4iKTsgfQ0KPiANCj4gYk1h
eE51bU9mUlRUIGlzIFBlcnNpc3RlbnQgUHJvcGVydHksICBkbyB3ZSBuZWVkIHRvIHJlLXdyaXRl
IGV2ZXJ5IHRpbWUNCj4gcG93ZXIgY3ljbGU/DQpDb3JyZWN0Lg0KTW9yZW92ZXIsIGRvbid0IHdh
bnQgdG8gb3ZlcnJpZGUgdXNlLXNwYWNlIHNob3VsZCBpdCB3YXMgd3JpdHRlbi4NCldpbGwgZml4
Lg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IEJlYW4NCj4g
DQoNCg==

