Return-Path: <linux-kernel+bounces-59169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2AF84F278
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503CF1F2655D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEA267A1A;
	Fri,  9 Feb 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CLBNA2NY";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ee9qa/Kj"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF633664A3;
	Fri,  9 Feb 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471903; cv=fail; b=Ewz24UkggbpHBKK6sYwDy0K8rRHPznQ6M6/BqJnkiJGTVGnUlB/LEzD+owTOnj/QW24xr35y7tk778Vuik89FhML8cdSpAPJS6iYmMiCGz1LMr2iEePlLEGoh8qBjiV9Ad6+wgVxgxG7GXgErWA+XSia4wSputx/Ns4UV5lw38o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471903; c=relaxed/simple;
	bh=TlxCOzVyGObf5rydNYVdAV3X6OeiWmi05hlomyo55NQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P74M/5qIsVs+zonn+CJ3dsKZ03T/T3pq0iY+MSJm7+/4ynNMsOzWH+5IKin45J2wybdgcUQoxBUpzPJ+BMRqRk/1V3go4YxZlujYM6AQpMVFtc9mlnfvQ1L+FHEWloRvdV5ssUXvwE94owh8KHeBEAa/zjb9q0fPG1goZ+G4Ktw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CLBNA2NY; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ee9qa/Kj; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707471900; x=1739007900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TlxCOzVyGObf5rydNYVdAV3X6OeiWmi05hlomyo55NQ=;
  b=CLBNA2NYeXSD11Z4C2uFW9BVtl2jldfOQ9AdxVfD3vXugge6DQEY1n1I
   dM38pFwktWEC1LmcUL2ayQyABp8JAyzsa/dF6epUvtJgEZmsk1u3uqIsz
   q49FBnVYpkyIxGSDNbluPnKo8dbkX9arhNaiBGr6wemt+hnbHkYbiZbQ9
   kDdbS0+a37Sn/CJAkHVRysmS3XLc1tw6f7kbq/79FidZwpQW2nthi0ETM
   FCJXRTQY348t7pFgRO2ebvSI5abDzgKeHf2SlAkNa43RZRRJgFs7k5K8Z
   RJT6ODMGOV3ftLlr6BDd5TY1uOuaUd/TDNTzwzJwjeVKCPMOwWvbtqz73
   g==;
X-CSE-ConnectionGUID: zL2WbNM3Td6yBFmNo4vV6A==
X-CSE-MsgGUID: oCZZ+03jRkeClfKsDsWczQ==
X-IronPort-AV: E=Sophos;i="6.05,256,1701154800"; 
   d="scan'208";a="16004285"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2024 02:44:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 02:44:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 02:44:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1xlpBCo9zXnnO4fGtWkKRKHIHandbXElg4KlbpEeTZXdmdCKFJnK8aRrAGhbN0PQpdxb0yfE9dd6cbAuKon4P+0isX08CQNKLvIKWfSO3/8/buu14biun8KHB/05gry6pWj6bu5/rotj8W9oyyPGN4bZ+VjE0Q4ReFYfsGHqQfxqYeQ6t7ntVCcOQsOf9Nrt2wkTrnz3sTiWy5qKFhZHuMkZSNd4wVe2gSYOpja4LYPYNEp74yMg2tPU0iedDFV3hUWnfR8Vz5uAv6JjHslT9alNQDF1wKnxHnyjh3Kvw803dEvRCnYDEzmhnic88/Z9ZDbNk5xOMPnghrbJtuHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlxCOzVyGObf5rydNYVdAV3X6OeiWmi05hlomyo55NQ=;
 b=m0m4hynTb4NSA4nuXW4kcOt+e7u/F/GT9r5nbwrNmEywPmRWc9EO9wAhLi/VmQHal8DLbJrj8sHPS5d3OTeXx5eV8/MoRCD/Eva93NvVanaex0eCY2czjc5GHNb3PKUEpVzUvhi7nxalHKGpaBtnTiU77H+N9wq+CSIXOhcHY6GBd+WEml7EHS1OTHHD59PWd4mguz7bSelfKA7nSEyhYM5gnld9SUjtEgnXe84+Fz+E4g1kfGl6pHXYxnWZsR0GLOMcNnyIzY/G/whrLzLHdhD3srfwH7i/9sJ8H8hj030Bcq79plldvDqGXQbHH6mItceL6Lly5i7G6o0myA4w6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlxCOzVyGObf5rydNYVdAV3X6OeiWmi05hlomyo55NQ=;
 b=Ee9qa/Kju+lPSLgFdaidMjdJWtSQZnQgl6XVRQjhDbU4bLAtgzrtHS5V6B9vDuDwmVR1mVLqk+ejyzOWXZ2Dhp1ETss9FqRFQmiwCHLbXgZcOzC1ABLLIZoKKrxpcGrDiV6hdbBX/wk/Ml/4ou+wPk0n59UYcka54dtIMoWDi37Wrv5KjxKcgTWg1Ph0hWZu2l9gl+HXsUVUCdDQeupeKLmWZaaZ66s/YURXn7dwPIYMVzAr4u4VQjEpsa95sZCAk8nq9QrErZlB/t0xefASZ5PfTsDOSyAmdowR9Dh+C5rhlDWVUmom2+Wzcd4o43qfBCuaEEYU5BGpbv2iO/aQOQ==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 09:44:32 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee%3]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 09:44:32 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>
CC: <tglx@linutronix.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC to
 json-schema
Thread-Topic: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC to
 json-schema
Thread-Index: AQHaWnAMbpa2jba9NEOaeGq/acSuiLEBEycAgACxIoA=
Date: Fri, 9 Feb 2024 09:44:32 +0000
Message-ID: <af5c5d55-99b8-4de8-9719-c2d76bf2a9c8@microchip.com>
References: <20240208092015.263210-1-dharma.b@microchip.com>
 <20240208-daintily-craftsman-c7f514d49c0f@spud>
In-Reply-To: <20240208-daintily-craftsman-c7f514d49c0f@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DS0PR11MB7192:EE_
x-ms-office365-filtering-correlation-id: e40f4f0e-c9e6-4de1-9c0a-08dc2953b7f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8uMf3dvYJYIkh0CvXy0RibibJDSisVjjuDNVIh8r0Jf2Ci7XtP45cqr+a8Jmws4RCB04za6eVrE1FUy7HVcBl0FTiwYKsMmKs5N1MR03ObQ0+LQ9bsxSCZePFzTgH67crO/kxIzqyng+zb1mloaYMUGdIdj0QFvSSpsIHd/NesB/h7XAaTjXeO8btV3n8BmB/6xjg7p/LjxMOXe+Nkyhl4YaaVyW2qCiMl2zAqF66RrXYEK5p/BBCXJKRDrVlhJWFF96z2eV6sJLX6w2B4xljkDBOSQnZEWQXlRoQxgPPkrA89g2/wvG6qM5HBO/PEIrfdP/wRa4wMTRdGMPjSk7u7t6VpDTufrQBJDII4KoWzCLh0rP98KfmnfdXs8TrAArXhWwu4c2tU2fPHvulwrb4lkQXLCL78rN8oxTBAOqbMP+Dizj4a5AL/YOjZvT5+7fe7Ez/rEjni8cFdza0l36+iAY9tTiT8NbcLnqfLeYM/nNHg+EwJBd/q/ek4fDNvcpSP9t4U4tUheJAJSJnfsM+FjKSL31V1aERPjRF4AkvlKg5XLcxbHALpzmmWmnD2MyxU77U8k4UrpRH1fjWy5E7hemDI3e+QicP2vXVfalG5b4j4J9U5GoMfTuonCNE8wm4k9tLrpAUtaM45AKMMX/+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(53546011)(41300700001)(2616005)(6486002)(6506007)(6512007)(478600001)(31686004)(2906002)(7416002)(5660300002)(64756008)(66446008)(66556008)(4326008)(6916009)(66946007)(91956017)(8676002)(8936002)(66476007)(76116006)(316002)(54906003)(71200400001)(38070700009)(26005)(83380400001)(36756003)(38100700002)(31696002)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UERiUzNLZHpMUnJySWlLWmFVTmpvOTE1T3VZS0dwTEg5S2orMkNDeU1GT1Br?=
 =?utf-8?B?VjIvS2QrZys3dnVGbnNraEZHSFhiaWpQZnRLVUhsdy9zN0dvKzhOOW4ya1Bt?=
 =?utf-8?B?ZDg1akVuaXBWRDRmaDdJTm9Xd3A2UDVGUHU2SXc3TTB0QzFoajAyaHJJRHhI?=
 =?utf-8?B?bEFHNm5IOGlpV04wbDRzTGU5bmdlVDYvTjYyVzBYUWZ5T0tPdzlCTzQrdzVY?=
 =?utf-8?B?TzZRcFFYRTZ6S3J0SFZUWEpZUmhlYU5jVVJwR0xRd3YrR3FBd0FHMkJKTHZY?=
 =?utf-8?B?WitsTlkvejBPMGkxWmxQcmdpV0RSZHV4bURncEZmZWY0NlRaajR4dzBBSSto?=
 =?utf-8?B?TkUzVit3aGtZZWZaWE8yUnprTFI0WHJkOVg4Rmc5U1JuOHpkbitRTEZ0VmdB?=
 =?utf-8?B?d2JsbUQzTmNPcExlSG9FOWppODJUMnB4YmtnVlU2bVczSm5iQUI4V1pTd2RL?=
 =?utf-8?B?dm9LQ0pCM25oZTBQMStOSTdzTlRPbEg1QVZ2YW10clB2cmUzM1hmY2hpeDkx?=
 =?utf-8?B?ZzZCb2UvamJpOE83Q08xd0JOdzZ3Z1ZXVlh4TDQ0b2h5aGRiYkJUU25yZnlq?=
 =?utf-8?B?eStUc25EQWpGanlkNUZCUEI0TmV6MU5pbzFsQVJyV040Zldaa0s2NHo4Znor?=
 =?utf-8?B?VkYxWml5U1UyelRCcnpITUh3eUJ0Y3lXdTNyd2pBenJpbnY4MzF4OU9vYkgy?=
 =?utf-8?B?MGVtSE5lbktIcmtGNEVJc1hJeXk0WDJxNUU2bk51UE4vSUVGYm02cWVlbHdF?=
 =?utf-8?B?VkVIc1pEbWRKZDlGSGtHbE8wdVlDRXNmTmNvVlFvT2ZLeGNGcmw1OGhzT3Iy?=
 =?utf-8?B?eTA3RW9vSmx1dStoY3V2OU16YWV2N05lWUtPM3hLU2QxNzhBd21hc0VlY01S?=
 =?utf-8?B?WWpaT2Erd25nNzQ4VmxBUXZ2SkJFcmd2Z3A2TUxjTVNmUExWc3dlZWVJMmNW?=
 =?utf-8?B?SkdEZkp4b1V3ZGFDQ2hVMC8xQjkvOUFuNkdHeE90RXB6Z1YwWUFFR0xCeXJp?=
 =?utf-8?B?WHFkUExRMGVuNlFGRnB0ZjVvMXRrSjYxV3czNmdaZkN5MFlMdUZWL3AxandW?=
 =?utf-8?B?Q3U2dEpZempZOU5OMVFQdGRlditOQjFvOTBLZVZ2TlBVZXNiTDRkZ1N6Qzdt?=
 =?utf-8?B?MnZzWGc4NWwxTFNDS1dMNTZNSnVERFJkeFl1Ry9kNnhPME1oS0ZIY2lOQ2Yy?=
 =?utf-8?B?UnIzSkNYSDZ1a3N6WktieGx3RUVNTE9MWUh1SERObFBuTitrSnlsdDExbnFE?=
 =?utf-8?B?TnBZdDNncVErc2NLNmlmM2JQbXJqNm9IejFFWGFyNTg3a3o2amNSWmlpd2lm?=
 =?utf-8?B?SU5CWDA3UTk2c2ZJNlQzQ3VCVmdHckZMSThJclRnZ3dJZDRaWXBWMllMNWZG?=
 =?utf-8?B?NFJkajBDczZGUnVLRVh5SlFhbk40OFJHZWpLTUtzRVBVWFhJZ0RidHRIem91?=
 =?utf-8?B?V1hMelhvNkRGaGFQWXgzd3dyNzFzbFd2eGtDUnlwRjhoYVF6Z2Y2TUZUNkpI?=
 =?utf-8?B?TGZwY3cyalhNY080emZzQTgvRkxzMHpHTXg0Vkdka1pBdjFORVhYcnd1RFpk?=
 =?utf-8?B?ejkxNnFkc0U2QWJnNVNnQ0Y4RTdLUEJUQUpVZk5FRml1djlwczVHQy9BNGxT?=
 =?utf-8?B?MjV1RlVTS3ZDRFpLUzRQMjhWZzRnb0pLMVFZNHVHQnRSdk94MWJEZzhNMmg4?=
 =?utf-8?B?ZkZPb3pwNkF4aUJwL01rOENNM2hzTTc1UGVpSmQ5bG5wTkhGb3ZqNFZUMDVW?=
 =?utf-8?B?Z1Y3dFFNQm1SNUhROUM4Slp0M3RVTDNWQnNHNEpCVWpXa3JwbExoVGVwcG82?=
 =?utf-8?B?V29VekdNRFQrcHVxYzVFa0owS1E3dDlGclhFQWNJajlUc3dOalByZGJ0VlRR?=
 =?utf-8?B?YVFyZmtxRmxGMWZUSXBRL0hRa29WenpiaHJiL0hsWXhpbEQwWnNkaklkOWJl?=
 =?utf-8?B?NmRQdXREUnFDdDE0RGNXcDE0RHJiSzg4cVVPODNpUkNDcU9lYU95QlhqY05R?=
 =?utf-8?B?UWM3YTdNWWQ1ZkZTbUtvNjBaYXRNUHRaWEo0bndWU1l2YUlCQmhRdUhVRkR6?=
 =?utf-8?B?RWV4ZVgvVGdkQnU4NnNrRGp0d0RBT1FOSDhRQ3BCbGpGT05wQlpYaHFNV2hn?=
 =?utf-8?Q?2G8cMherAm+nqabxy0YJ2UCN0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B68AFC1827E21C47A1BF9D59A559DA59@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40f4f0e-c9e6-4de1-9c0a-08dc2953b7f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 09:44:32.4697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWLgqvdZfQ/z+xMXahNUciOXy60V79y4gSgqQXYHjx8seXqEFUj/qLYkdVLZSLCvpUCA9SfCYqVA0Nw8lB4FMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192

SGkgQ29ub3IsDQoNCk9uIDA5LzAyLzI0IDQ6NDAgYW0sIENvbm9yIERvb2xleSB3cm90ZToNCj4g
SGV5IERoYXJtYSwNCj4gDQo+IE92ZXJhbGwgdGhpcyBsb29rcyBhbHJpZ2h0LCBidXQgSSBoYXZl
IGEgZmV3IGNvbW1lbnRzIGZvciB5b3UuDQo+IA0KPiBPbiBUaHUsIEZlYiAwOCwgMjAyNCBhdCAw
Mjo1MDoxNVBNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1hbmkgd3JvdGU6DQo+IA0KPj4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9hdG1lbCxhaWMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9hdG1lbCxhaWMueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMzk2ZWFjNTNkYTNhDQo+PiAtLS0gL2Rldi9u
dWxsDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0
LWNvbnRyb2xsZXIvYXRtZWwsYWljLnlhbWwNCj4+IEBAIC0wLDAgKzEsODggQEANCj4+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlB
TUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOmh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lu
dGVycnVwdC1jb250cm9sbGVyL2F0bWVsLGFpYy55YW1sIw0KPj4gKyRzY2hlbWE6aHR0cDovL2Rl
dmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0bGU6IEFk
dmFuY2VkIEludGVycnVwdCBDb250cm9sbGVyIChBSUMpDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6
DQo+PiArICAtIE5pY29sYXMgRmVycmU8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPj4g
KyAgLSBEaGFybWEgYmFsYXN1YmlyYW1hbmk8ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4NCj4+ICsN
Cj4+ICtkZXNjcmlwdGlvbjogfA0KPiBUaGUgY2hvbXBpbmcgb3BlcmF0b3IsIHwsIGlzIG5vdCBu
ZWVkZWQgaGVyZSBhcyB5b3UgaGF2ZSBubyBmb3JtYXR0aW5nDQo+IHRvIHByZXNlcnZlLg0KDQpJ
IG1pc3NlZCBpdCBhZ2FpbiwgSSB3aWxsIGZpeCBpdC4NCj4gDQo+PiArICBUaGUgQWR2YW5jZWQg
SW50ZXJydXB0IENvbnRyb2xsZXIgKEFJQykgaXMgYW4gOC1sZXZlbCBwcmlvcml0eSwgaW5kaXZp
ZHVhbGx5DQo+PiArICBtYXNrYWJsZSwgdmVjdG9yZWQgaW50ZXJydXB0IGNvbnRyb2xsZXIgcHJv
dmlkaW5nIGhhbmRsaW5nIG9mIHVwIHRvIG9uZQ0KPj4gKyAgaHVuZHJlZCBhbmQgdHdlbnR5LWVp
Z2h0IGludGVycnVwdCBzb3VyY2VzLg0KPj4gSXQgaXMgZGVzaWduZWQgdG8gc3Vic3RhbnRpYWxs
eQ0KPj4gKyAgcmVkdWNlIHRoZSBzb2Z0d2FyZSBhbmQgcmVhbC10aW1lIG92ZXJoZWFkIGluIGhh
bmRsaW5nIGludGVybmFsIGFuZCBleHRlcm5hbA0KPj4gKyAgaW50ZXJydXB0cy4NCj4gVGhpcyBy
ZWVrcyBvZiBhIG1hcmtldGluZyBzdGF0ZW1lbnQgYW5kIHNob3VsZCBiZSByZW1vdmVkIElNTy4N
Cg0KTm90ZWQuIEkgd2lsbCByZW1vdmUgaXQuDQo+IA0KPj4gK2FsbE9mOg0KPj4gKyAgLSAkcmVm
OiAvc2NoZW1hcy9pbnRlcnJ1cHQtY29udHJvbGxlci55YW1sIw0KPj4gKw0KPj4gK3Byb3BlcnRp
ZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBlbnVtOg0KPj4gKyAgICAgIC0gYXRtZWws
YXQ5MXJtOTIwMC1haWMNCj4+ICsgICAgICAtIGF0bWVsLHNhbWE1ZDItYWljDQo+PiArICAgICAg
LSBhdG1lbCxzYW1hNWQzLWFpYw0KPj4gKyAgICAgIC0gYXRtZWwsc2FtYTVkNC1haWMNCj4+ICsg
ICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLWFpYw0KPj4gKw0KPj4gKyAgaW50ZXJydXB0LWNvbnRy
b2xsZXI6IHRydWUNCj4+ICsNCj4+ICsgICIjaW50ZXJydXB0LWNlbGxzIjoNCj4+ICsgICAgY29u
c3Q6IDMNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsgICAgICBUaGUgMXN0IGNlbGwgaXMg
dGhlIElSUSBudW1iZXIgKFBlcmlwaGVyYWwgSURlbnRpZmllciBvbiBkYXRhc2hlZXQpLg0KPj4g
KyAgICAgIFRoZSAybmQgY2VsbCBzcGVjaWZpZXMgZmxhZ3M6DQo+PiArICAgICAgICBiaXRzWzM6
MF0gdHJpZ2dlciB0eXBlIGFuZCBsZXZlbCBmbGFnczoNCj4+ICsgICAgICAgICAgMSA9IGxvdy10
by1oaWdoIGVkZ2UgdHJpZ2dlcmVkLg0KPj4gKyAgICAgICAgICAyID0gaGlnaC10by1sb3cgZWRn
ZSB0cmlnZ2VyZWQuDQo+PiArICAgICAgICAgIDQgPSBhY3RpdmUgaGlnaCBsZXZlbC1zZW5zaXRp
dmUuDQo+PiArICAgICAgICAgIDggPSBhY3RpdmUgbG93IGxldmVsLXNlbnNpdGl2ZS4NCj4+ICsg
ICAgICAgIFZhbGlkIGNvbWJpbmF0aW9uczogMSwgMiwgMywgNCwgOC4NCj4gU2hhbWUgdGhhdCB0
aGVzZSBhcmUgbm90IGFsaWduZWQgd2l0aCB0aGUgSVJRX1RZUEUgZGVmaW5lcyDwn5mBDQo+IA0K
Pj4gKyAgICAgICAgRGVmYXVsdCBmb3IgaW50ZXJuYWwgc291cmNlczogNCAoYWN0aXZlIGhpZ2gp
Lg0KPj4gKyAgICAgIFRoZSAzcmQgY2VsbCBzcGVjaWZpZXMgaXJxIHByaW9yaXR5IGZyb20gMCAo
bG93ZXN0KSB0byA3IChoaWdoZXN0KS4NCj4+ICsNCj4+ICsgIGludGVycnVwdHM6DQo+PiArICAg
IGRlc2NyaXB0aW9uOiBJbnRlcnJ1cHQgc291cmNlIG9mIHRoZSBwYXJlbnQgaW50ZXJydXB0IGNv
bnRyb2xsZXIuDQo+IERyb3AgdGhlIGRlc2NyaXB0aW9uLCBpdCdzIG9idmlvdXMuDQoNClN1cmUu
DQo+IA0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgcmVnOg0KPiBBIG5pdCwgYnV0
IEkgd291bGQgcHV0IHJlZyBhZnRlciBjb21wYXRpYmxlLg0KDQpTdXJlLg0KPiANCj4+ICsgICAg
ZGVzY3JpcHRpb246IFNwZWNpZmllcyBiYXNlIHBoeXNpY2FsIGFkZHJlc3MocykgYW5kIHNpemUg
b2YgdGhlIEFJQyByZWdpc3RlcnMuDQo+IFNhbWUgaGVyZS4NCg0KU3VyZSwgSSB3aWxsIGRyb3Ag
dGhlIGRlc2NyaXB0aW9uLg0KPiANCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGF0
bWVsLGV4dGVybmFsLWlycXM6DQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2Rl
ZmluaXRpb25zL3VpbnQzMi1hcnJheQ0KPj4gKyAgICBkZXNjcmlwdGlvbjogdTMyIGFycmF5IG9m
IGV4dGVybmFsIGlycXMuDQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+PiArICAtIGNvbXBhdGlibGUN
Cj4+ICsgIC0gaW50ZXJydXB0LWNvbnRyb2xsZXINCj4+ICsgIC0gIiNpbnRlcnJ1cHQtY2VsbHMi
DQo+PiArICAtIHJlZw0KPiBBIG5pdCwgYnV0IEkgd291bGQgcHV0IHJlZyBhZnRlciBjb21wYXRp
YmxlDQoNClN1cmUuDQo+IA0KPj4gKyAgLSBhdG1lbCxleHRlcm5hbC1pcnFzDQo+PiArDQo+PiAr
dW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAg
LSB8DQo+PiArICAgIC8qIEFJQyAqLw0KPiBEcm9wIHRoZSBjb21tZW50LCBpdHMgb2J2aW91cy4N
Cg0KU3VyZSwgSSB3aWxsIGRyb3AgaXQNCj4gDQo+PiArICAgIGFpYzogaW50ZXJydXB0LWNvbnRy
b2xsZXJAZmZmZmYwMDAgew0KPiBUaGUgbm9kZSBuYW1lIGhlcmUgaXMgbm90IHVzZWQsIGRyb3Ag
aXQuDQoNClN1cmUsIEkgd2lsbCBkcm9wIHRoZSBhaWMgYW5kIHVzZSBqdXN0IGludGVycnVwdC1j
b250cm9sbGVyQGZmZmZmMDAwLg0KPiANCj4+ICsgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0
OTFybTkyMDAtYWljIjsNCj4+ICsgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4+ICsgICAg
ICAjaW50ZXJydXB0LWNlbGxzID0gPDM+Ow0KPj4gKyAgICAgIHJlZyA9IDwweGZmZmZmMDAwIDB4
MjAwPjsNCj4+ICsgICAgICBhdG1lbCxleHRlcm5hbC1pcnFzID0gPDMxPjsNCj4+ICsgICAgfTsN
Cj4+ICsNCj4+ICsgIC0gfA0KPj4gKyAgICAvKiBBbiBpbnRlcnJ1cHQgZ2VuZXJhdGluZyBkZXZp
Y2UgdGhhdCBpcyB3aXJlZCB0byBhbiBBSUMuICovDQo+PiArICAgIGRtYTogZG1hLWNvbnRyb2xs
ZXJAZmZmZmVjMDAgew0KPj4gKyAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTlnNDUt
ZG1hIjsNCj4+ICsgICAgICAjZG1hLWNlbGxzID0gPDI+Ow0KPj4gKyAgICAgIHJlZyA9IDwweGZm
ZmZlYzAwIDB4MjAwPjsNCj4+ICsgICAgICBpbnRlcnJ1cHRzID0gPDIxIDQgNT47DQo+PiArICAg
IH07DQo+IEFuZCBkZWxldGUgdGhpcyB3aG9sZSBleGFtcGxlIPCfmYINCg0KU3VyZSwgSSB3aWxs
IGRlbGV0ZSB0aGlzIGV4YW1wbGUuDQo+IA0KPiBDaGVlcnMsDQo+IENvbm9yLg0KPiANCg0KLS0g
DQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0KDQo=

