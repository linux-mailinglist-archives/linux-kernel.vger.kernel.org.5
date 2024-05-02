Return-Path: <linux-kernel+bounces-166285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9032E8B988C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF351C21A26
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FC559161;
	Thu,  2 May 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="veCUJOYn";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xlui2x55"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC6D58ABC;
	Thu,  2 May 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644618; cv=fail; b=NYXXG7+CoHpB276gvkigWEqmUkduIsf+bSwCiIFn74WZ9Rjz8AooERe4hUnb7y62QzT2XT1mHz/h345ThxVUBWQYsk/PqsDO0SkpziRDFyc9k8datyHPNcrpssnz0dpYNC++LqgluoR/GBj6H42rIjUljT9RKgLT+7Anxc0FTbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644618; c=relaxed/simple;
	bh=Loz9TsDP19BRn+qvPzluelEJ7avRy2j5UbXKbxF/xDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SyG9TZiLAM1iClTMjhjPuUizjpkmZiao4a6jxJlIn7Zj2mOg+VenRcWZawB6h6smDQtkj1pog0ZZJK4cg/Mkb3EieBGURNLCDuFf3ICPNVQ2dsJ+oqndydH5S/cDI7QqpltDp950KGUserlLvfqM3W/3zGF+3YDijYJx5XKh+x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=veCUJOYn; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xlui2x55; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714644615; x=1746180615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Loz9TsDP19BRn+qvPzluelEJ7avRy2j5UbXKbxF/xDo=;
  b=veCUJOYnBCmsReIe1eFumAN/alwNw/bjwuCEgZ/lLExph+OLu0Ao4p7R
   LyFn4gGqTGBxCG/cSPdwhwMxCqSp01O+PHYeg+TMprWodLzSF+y3jaAL+
   Wj5SP6v6KnL5Enmq2ILqMrdt5Tr/KNpCBz72T6We5xCmP8qH606YqnXfQ
   rDVKiJb8WURRVQxHAbYKg+yO8uCg68ysfyCrQVrtjx7vEGy33KcQWH/Yi
   aqPrdKQnZ8RBk8wdGENs3oeJyJxM2j4ZczaNm3N0varW68t/yIeOeHZFd
   sWCbcrOpX6+DpDjJ5YJkzAOXb0/SAUbQGrYRewLvyZZ5M90fNLwNshq+H
   A==;
X-CSE-ConnectionGUID: 9xPnPBQ2ScyXZapFGKGEBg==
X-CSE-MsgGUID: NT/sIFWQSvyWYkhOKpZBzg==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="23353056"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2024 03:10:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 03:10:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 03:10:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLjak31mRqrO/hCrLQ4f8XhHOmvcgfwcvrTnMla2MY7G2FXhhdlhk804aYwVRTzBiN/in/dFS1j1z9v33T8zJoNc+2zpDPRPICvCVy1dMeGU4uqlsgqZOQt1lNAqYaRk+88WKhEiVQk0KkzsCLyxGLtXw2d9sCfyXPd3Da4fgVrNIL337iKr0rgWNgiadVS3lNvn0TNxRZ99NoP/s+XCM0E4yaIIVSwZhmCmWzsHFJdW//QPk556oB6rhklBMjyttA2lHnGh+A0Te6rmaZJXFgDbtbN44JLesIeu/nnsHf0174RmTW4vuYd3PYRlZEWljgvS4x3iEbC+mlSmqRg/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Loz9TsDP19BRn+qvPzluelEJ7avRy2j5UbXKbxF/xDo=;
 b=kRz7NdxVwGz4OXdcdBQnVmodCpSG8UEzQVyyQfVTQaApqMncnye0TdYA7YykeE/lvFnfHu+3LeUH3c+jZBUpEMO3QxOf0iYFZMWIMMVNprX22M3DUgyh9U8g3o1ApJwAkdU7llBeft/3jVgDjXDMJTOhqyBWrUdSEdMKY5cmXEoV1QoDLBSxbujHLcFdJ0jhYRE+LqQEmI7+Kj43Ork1/XwqHj1XzTDSdgqTKaMvS/igETj6R0MpYa+ZwS6y6uw2rRkkqD2Pbam3qN7jkC6d6vLdQs1XCracUAlRA/AjfPfRH/pJ9+6cerFieKJJpxXaJwyiR9jj0OtKbjY4XwAZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Loz9TsDP19BRn+qvPzluelEJ7avRy2j5UbXKbxF/xDo=;
 b=xlui2x558y0qH4x7Y/o6LBCtPdCsLI3PPMVwRqykELxMQL8kxjvUPBCPQyT6mJdlS8Y3a+lpqfHqsYKA4bQH9RRyavzvw3aeBjXfg/oVNwxvFGSVBHgt/sMaCKjf9DrraWWd5pG1OyoOdIYGrP5vf1ktJGdX5HXyYq71MZ6tmmn0mk6Fxt3JSLPZzcqKb1RZlTKLo7BD2+xgnV1IXskRImtxRmtJyh061RyeNYvGvvsVdg7wmW/grmcGMepHNC7hbM+ms+zyqyXErgZEgjvUPJoqAr6fjmANr/C2niQc+ashjEpbnjVHsHOCpRfNfbv3herpb/PoA7S0wlCVcq2ViQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM6PR11MB4595.namprd11.prod.outlook.com (2603:10b6:5:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 10:10:03 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 10:10:03 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <ramon.nordin.rodriguez@ferroamp.se>, <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Topic: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Index: AQHakZAQrurZHAw3l0Wxg+eFKGxGMbF8la2AgAAX2oCAANNtAIAAVU8AgATxiICAAQb4gA==
Date: Thu, 2 May 2024 10:10:03 +0000
Message-ID: <b7c7aad7-3e93-4c57-82e9-cb3f9e7adf64@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder> <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi4czGX8jlqSdNrr@builder> <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
 <ZjKJ93uPjSgoMOM7@builder>
In-Reply-To: <ZjKJ93uPjSgoMOM7@builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM6PR11MB4595:EE_
x-ms-office365-filtering-correlation-id: 79792660-39ad-483f-8332-08dc6a90089d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MkFuU2U0K01wN0lIY0xCaDlqZHBEOEZOaEUzc1RwYjhyREVlS0xSTCttY1NY?=
 =?utf-8?B?ZlJGMlZIOWVET2J6dGtTZ2RiM1dwUlY0QU5qZjhnMW5OOVdKS3BWdFZFVmIz?=
 =?utf-8?B?Vnk2UE03OHhINHlrdEdNdmsraFY2elhwY2hyR2NoUnZLWXROVDBpcXdpSnEy?=
 =?utf-8?B?NnoxOHFzVHE5em5jQjRTOGtEcjhLRDl3K1B3RnFoTGpVOW1MeVNXdVMzczEv?=
 =?utf-8?B?OUtWbTJUN1VseHFEa3FpdXlvV3JSNU12YnV5bXNFdXpDMkZUNmtKTWlKL1Q2?=
 =?utf-8?B?dnVLZmhqUE9jb1NOL2x1dWFtaW9SK2dFMW14b1dDWDFQRWl4VkplT010NjI3?=
 =?utf-8?B?c2kzeFIvb3ZLK0dWdDNPK1pEWHZPdlI3R0ZVS3VzWXBEd2E0azZmYmZiZEVO?=
 =?utf-8?B?T1hSRytidThHaGEzRXZoUjE2cldjUnZIRk9qVnlKdWh4b0dkWkVzcFdUaXMw?=
 =?utf-8?B?bXdaMzlDeFhzdVo4YmhMWlJJdWNzUit3d1JLRGRsYnIrbERINnMwUmhwMVZw?=
 =?utf-8?B?Vko2VkN4V2E0NWZ1MTZWemhSQkJybFZBUUxLLzZzU2lwb3dxUE9KTnZPTlhP?=
 =?utf-8?B?NjM1L0NiODRwSXo2VkZDMHRxM0JwVDRyMUhvMFpTTE11d2tmOHBGUCtJa1Jj?=
 =?utf-8?B?T1NZTWFyTzBxWGNuQmUrUHRpdWZaS2g2R2VsWndNTFBvL1Z5cE9meTN3SmFX?=
 =?utf-8?B?dU5qR3BSb3YxaVJEWkJ1ZnpKb1NjZURUUng4NzRBNzdpME4rL0hxRHlPTnlj?=
 =?utf-8?B?RDI5YjFUQU5NNEpkczdmR3JaZXpJNDBOeGM3UmRDNGV4L1NhVnB2V0hma3g3?=
 =?utf-8?B?Ymo2MU9CcnJ5Ni9SRXh2NURVa3ZZNnBwTTVoQVNxTWYwckV4eGJEQlVTK0NQ?=
 =?utf-8?B?THZtY1hGOSsxN015dktLUmhzbWpGUnRmeXlEOFJET0wvUXZMNGp2K0pyMnNm?=
 =?utf-8?B?TmZQWFVJV1h3dEVzdUY0UFA1bTJTMms4dmhMOEpZWVpuZ3NUaGhqMHNwOFU1?=
 =?utf-8?B?Mmt2bUk0cFlLdk9OanUyWHEyNjJZMmRkeTZPSmlnZmphMERTKzRZaDgxR1ZB?=
 =?utf-8?B?cUY1eTQycHJwRzRIN09NdDcvRnhGc0tiRVlHR1gxM0l6ZlZwMEtSa2lid2Z5?=
 =?utf-8?B?QzRZWHlucHNCcUV2TTdISlRwVjV4SytCZGpLTTBPcnovT25MeVNtVUtnUFlB?=
 =?utf-8?B?aTVPbG0wL01mYnBBMWdKNW5jekVVbmNEQnVwNEFESExyK2hFd3kzK09hV1U0?=
 =?utf-8?B?RWpkbFBzZXJTZ2c3NS9XeFRnOEV5R3NiZ2NwVDdRZE9OL2ZVQ2pOcTFFN2x3?=
 =?utf-8?B?VDV3ck1ESzBRWWxaSHJPMzFRYjFVdFphRDFHWTdyeG1GMWREWk1iQnRDUUF0?=
 =?utf-8?B?eHExQnMzOUF5Uzh1TWorUC95dU8yZSswcHZmTTV0S2lzTU15akI0RGw2ZUQw?=
 =?utf-8?B?S1gzQXU1ZUp6d1lyTmMvTzh4amtKTGxzVWgvSlJqcm1OTklIUUxQYklvYWU2?=
 =?utf-8?B?RTdJYjN3OHJ2TkNQcHpzd3drajNZSGZLbkIzK1Z6ZkdibFhSRjBFK3pSM2FF?=
 =?utf-8?B?ODdJNllqa01TNGJ0OXMvMVBhS1o1d2ZrMldRVy9uVXBCL2RKeG5lY3BnT3pw?=
 =?utf-8?B?WXdpZEdTNDU2U1N3OE1DV0lLMUhpMUYyazlBbW1EVVNkSHlrTmpKZFFFazZS?=
 =?utf-8?B?OHVSVm9qYWloUzRNYjJkQUpBbmNJSmRodjlSOVVhcjk1aDMwdzIzcDlicmZm?=
 =?utf-8?B?MDNaS1VHMjMxeGZSTnd4WFZDZDFpeWJUUGhxWFR6bFJiSUFlYkdNRWdIT1pK?=
 =?utf-8?B?RkpLWi9LYUxzVVNzZ0w4dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enJCcmQveDdqQWRIR1RmcVdyR1hHeGxLVVVuVG5TMDZORkc0NkxlRThtc3d6?=
 =?utf-8?B?L2V1MWMwZTVPRUhhOW1aWnFZZ082R0Nuc2E0RXN6b3FqdlpSc2lIUjB4SEhq?=
 =?utf-8?B?S1o2VDFzZkFabjJQMzZaUDI2bU5TVmdsVHJLV2RGcE1FY2hwYnZudnQ4dHMz?=
 =?utf-8?B?RHd2TzJRdVFxZ01Xc1JsTGRyWjBqbkpMMFdFYmJrWkszVWRVSnNlSlVXaXpW?=
 =?utf-8?B?ODRqQjZLemx4ODV4TTdZdnVXRExabG5LQlloNXhEOHpSdmw2Vy9YZWxLTmlk?=
 =?utf-8?B?M3BqTk54SE5POSt6aVRKdzBqYng5UlV0VjZocEJ0aC9sNDFTVmkyamwzWGdy?=
 =?utf-8?B?WDQwNlNvby8xR0lnSTZNQ0RCVlF0MGpPdXlMRklxSWZ0OFB1dk9KcnR3Szl6?=
 =?utf-8?B?STdDZlo1bngxdTZhZmRrak1UZXAwTmdieC9BZHkzRm54Mzhob09oQTZ5TEVN?=
 =?utf-8?B?Nkpkd25FWGM3RXF3MkdpSUExWk12L29MNythMGhZeGFWeXhSUzFUcmdWb3VI?=
 =?utf-8?B?Vis4ZUZ0OFlGMDhVdGt4eE9HQzQvOS96dnFtVEdUeElCT1g1cmpYeHFMbXBG?=
 =?utf-8?B?YTNaU1JoT0FMSlJwUjRMQVNSZU9oVzl4SXYzSXZDaXNFT0xMTWtvUEx1R2dN?=
 =?utf-8?B?ZDlnUFpuYnQveFZ3V2NHT3BEQ3FUUHNmTXFEdFZKSnFXTmVpc0RsRE5QcFJk?=
 =?utf-8?B?RHZSZGF3eTNuTWlxb3hVV2pCSndJOER2VVR6VjE0MFVLbUk1UnprajRYU0dZ?=
 =?utf-8?B?Mml6Zmw2YVdQUnhISFdWckVlUytDQVZ1M2ExcWtlblBGN0diSVpqUS9MOWp4?=
 =?utf-8?B?ZlM0U3pMWENFWGNlK2owQVRmaWxvWGUyMlhPOXZKbllaUEtWeTJEMkJLMm5K?=
 =?utf-8?B?VExSd1ppUWF0cnNFWWFHOGJTTmVFWlVjVktPQ3F3YXU5ZGJjK0MvYkl6TW1J?=
 =?utf-8?B?aEZzTFJQU3hoalgxdU5XUHRIUUY4SkIrditWQ2FRbG0wcC9qemhydktoMW1h?=
 =?utf-8?B?cy96bmRGSEg2RytMQ3Y5NXVVUmFKaG9mM3BVUFlXSk5EMUZnVXovNWVSYTBG?=
 =?utf-8?B?VGZGRTRxREQzM3czM2d6Ym1SOTJwM0EybDk1dGdEY1BUalB5UTI0ZjNkOXZQ?=
 =?utf-8?B?THJFNEdybkF4ZElxVXYvVGZ1MTBvUzJCWVVyQy9nQURmdks4dzRsUkREQnc0?=
 =?utf-8?B?VEkrTmpoZ1VWM2tibjBrcXZoMVRMRnlsVnZ4MjdLWnY2b05ieWY1MW0vdzhQ?=
 =?utf-8?B?T0ZFWGpSUlhaY3BxclpQendLcXl0cVZlZDFRVVo2U21EL2tjVStyb1B4bTkz?=
 =?utf-8?B?MkdjU1lncUtieHVLZlZGTktUT3FDcFhudEJxdW90SDJra2gvRTloNHZ6UEdT?=
 =?utf-8?B?VlpqdG5zMHN1SGVoZ0krd0J5dkRkejFzVEhrZHNmTzA4TEhYemZZRlJXQWlZ?=
 =?utf-8?B?OCtYZ3JkMFFRbHBXNzh2d2MrMlZmbXZCRE9rWk1DL212NG1TQi85am10ZnRV?=
 =?utf-8?B?b28wZFpHa2xQNXZlTFFEaHdZd21ibFFmeFpycFV6M1dNcmcxZmNwQklMRnFS?=
 =?utf-8?B?OUttbHlPd3YwakQrbHAxSHIyWDhlUHRnNlJNR2pNMlZGRlpucHo2Q1Jlaks2?=
 =?utf-8?B?UmtwZ3F3WDlvTU1CTW52OTAvSGZITlNLR1ZnR2tCSklGWVpYYnQ1ejNXbDUy?=
 =?utf-8?B?a3J5cUxBYzEyVzFxMnhNbUplOFpGNnNMdEZVZU9wdEsvZEZVa0IvMWZLUHBB?=
 =?utf-8?B?dFRqMUdBbWVIYk5YN0N1THpJck0xNGU3WEc1YzBFSVF1cXlkb29hRWh5b3RB?=
 =?utf-8?B?bkp6dlF2T0E3R2R6M2pBanhWNVlEZTJRQ0FxQjV3VXhzYmxXMno2VlRYcWtC?=
 =?utf-8?B?YUZrSlR4SmJ2dlJmN0xOamt3M0JtMXJySnVsNUQ3cDFjRmFmQUNQLzZlMjlU?=
 =?utf-8?B?cTJMQWZydXJlUG1sNk9jSmVwU1RSd0JRTnlabWowT0JEWFBFY0pPZGxkaVdM?=
 =?utf-8?B?L3ZHemJOcHp2UHR1c1I5cDlaWTFhVHBuMkxjeHpWUU1pODZmSnhrM1FXcngz?=
 =?utf-8?B?OHQxUGpoWk5MZ3RkaC92enJzclN1dVoyTkhrSkZEZFdMMHc3WENOcktRZ2FG?=
 =?utf-8?B?YWhrYnFLNkhCWnpabWZjWWp0bVhNa2syc2J2c1E3RVJ3cG1UeWx1OXk2czhs?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <613BBDDA2AA93B47A99C7FA1CAA76911@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79792660-39ad-483f-8332-08dc6a90089d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 10:10:03.1938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6A0mJ1G56vOEHZtFd9/qs5QgnVKT/OqTj5rj+YrtxXoNiNTDVPKG0XK6USrySthyN718jCZ98FTD383AyX7d7l+K6ysbexu5/sy5JJeGPu/CEcpm1qxiRhLu8WyHPviD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4595

SGkgUmFtb24sDQoNCk9uIDAxLzA1LzI0IDExOjU5IHBtLCBSYW3Ds24gTm9yZGluIFJvZHJpZ3Vl
eiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4+IG4g
IHwgIG5hbWUgICAgIHwgIG1pbiAgfCAgYXZnICB8ICBtYXggIHwgIHJ4IGRyb3BwZWQgIHwgIHNh
bXBsZXMNCj4+PiAxICB8ICBubyBtb2QgICB8ICA4MjdLIHwgIDg0NksgfCAgODkxSyB8ICAgICAg
OTQ1ICAgICB8ICAgICA1DQo+Pj4gMiAgfCAgbm8gbG9nICAgfCAgNzExSyB8ICA3MjZLIHwgIDc0
NEsgfCAgICAgIDU2MiAgICAgfCAgICAgNQ0KPj4+IDMgIHwgIGxlc3MgaXJxIHwgIDgxNUsgfCAg
ODMzSyB8ICA4NDZLIHwgICAgICBOL0EgICAgIHwgICAgIDUNCj4+PiA0ICB8ICBubyBpcnEgICB8
ICA5MTRLIHwgIDkyNEsgfCAgOTMxSyB8ICAgICAgTi9BICAgICB8ICAgICA1DQo+Pj4gNSAgfCAg
c2ltcGxlICAgfCAgODU3SyB8ICA4NjhLIHwgIDg3OUsgfCAgICAgIDYxNSAgICAgfCAgICAgNQ0K
Pj4NCj4+IFRoYXQgaXMgb2RkLg0KPj4NCj4+IFNpZGUgcXVlc3Rpb246IFdoYXQgQ09ORklHX0ha
PSBkbyB5b3UgaGF2ZT8gMTAwLCAyNTAsIDEwMDA/ICBUcnkNCj4+IDEwMDAuIEkndmUgc2VlbiBw
cm9ibGVtcyB3aGVyZSB0aGUgZHJpdmVyIHdhbnRzIHRvIHNsZWVwIGZvciBhIHNob3J0DQo+PiB0
aW1lLCBidXQgdGhlIENPTkZJR19IWiB2YWx1ZSBsaW1pdHMgaG93IHNob3J0IGEgdGltZSBpdCBj
YW4gYWN0dWFsbHkNCj4+IHNsZWVwLiBJdCBlbmRzIHVwIHNsZWVwaW5nIG11Y2ggbG9uZ2VyIHRo
YW4gaXQgd2FudHMuDQo+Pg0KPiANCj4gSSBoYXZlIGJlZW4gZG9pbmcgbXkgYmVzdCB0byBhYnVz
ZSB0aGUgbGluayBzb21lIG1vcmUuIEluIGJyaWVmIHR3ZWFraW5nDQo+IENPTkZJR19IWiBoYXMg
c29tZSBidXQgbGltaXRlZCBlZmZlY3QuDQo+IFNhdHVyYXRpbmcgdGhlIGxpbmsgd2l0aCB0aGUg
cnggYnVmZmVyIGludGVycnVwdCBlbmFibGVkIGJyZWFrcyB0aGUgZHJpdmVyLg0KPiBTYXR1cmF0
aW5nIHRoZSBsaW5rIHdpdGggdGhlIHJ4IGJ1ZmZlciBpbnRlcnJ1cHQgZGlzYWJsZWQgaGFzIHBv
b3INCj4gcGVyZm9ybWFuY2UuDQo+IA0KPiBUaGUgZm9sbG93aW5nIHNjZW5hcmlvIGhhcyBiZWVu
IHRlc3RlZC4gQm90aCBlbmRzIG9mIHRoZSBsaW5rIHJ1bjoNCj4gKiBzZXJ2ZXIucHkNCj4gKiBj
bGllbnQucHkNCj4gDQo+IE9uZSBlbmQgaXMgYW4gYXJtNjQgcXVhZCBjb3JlIHJ1bm5pbmcgYXQg
MS4yR0h6IHdpdGggdGhlIGxhbjg2NTAgbWFjcGh5Lg0KPiBUaGUgb3RoZXIgZW5kIGlzIGFuIGFt
ZCAzOTUweCBydW5uaW5nIHRoZSBsYW44NjcwIHVzYiBldmFsIGJvYXJkLg0KPiBCb3RoIHN5c3Rl
bXMgc2hvdWxkIGJlIGZhc3QgZW5vdWdoIHRoYXQgcnVubmluZyBweXRob24gc2hvdWxkIG5vdCBi
ZSBhDQo+IGxpbWl0aW5nIGZhY3Rvci4NCj4gDQo+IC0tIFRoZSB0ZXN0IGNvZGUgLS0NCj4gc2Vy
dmVyLnB5DQo+ICMhL2Jpbi9lbnYgcHl0aG9uMw0KPiBpbXBvcnQgc29ja2V0DQo+IA0KPiBkZWYg
c2VydmUoc29jazogc29ja2V0LnNvY2tldCk6DQo+ICAgICAgd2hpbGUgVHJ1ZToNCj4gICAgICAg
ICAgY2xpZW50LCBhZGRyID0gc29jay5hY2NlcHQoKQ0KPiAgICAgICAgICBwcmludChmJ2Nvbm5l
Y3Rpb24gZnJvbToge2FkZHJ9JykNCj4gICAgICAgICAgd2hpbGUgbGVuKGNsaWVudC5yZWN2KDIw
NDgpKSA+IDA6DQo+ICAgICAgICAgICAgICBwYXNzDQo+ICAgICAgICAgIHByaW50KCdjbGllbnQg
ZGlzY29ubmVjdGVkJykNCj4gICAgICAgICAgY2xpZW50LmNsb3NlKCkNCj4gDQo+IGlmIF9fbmFt
ZV9fID09ICdfX21haW5fXyc6DQo+ICAgICAgc29jayA9IHNvY2tldC5zb2NrZXQoc29ja2V0LkFG
X0lORVQsIHNvY2tldC5TT0NLX1NUUkVBTSkNCj4gICAgICBzb2NrLnNldHNvY2tvcHQoc29ja2V0
LlNPTF9TT0NLRVQsIHNvY2tldC5TT19SRVVTRUFERFIsIDEpDQo+ICAgICAgc29jay5iaW5kKCgn
MC4wLjAuMCcsIDQwNDApKQ0KPiAgICAgIHNvY2subGlzdGVuKDEpDQo+ICAgICAgc2VydmUoc29j
aykNCj4gICAgICBwcmludCgic29tZXRoaW5nIHdlbnQgd3JvbmciKQ0KPiANCj4gY2xpZW50LnB5
DQo+ICMhL2Jpbi9lbnYgcHl0aG9uMw0KPiBpbXBvcnQgc29ja2V0DQo+IGltcG9ydCBzeXMNCj4g
DQo+IGlmIF9fbmFtZV9fID09ICdfX21haW5fXyc6DQo+ICAgICAgc29jayA9IHNvY2tldC5zb2Nr
ZXQoc29ja2V0LkFGX0lORVQsIHNvY2tldC5TT0NLX1NUUkVBTSkNCj4gICAgICBzb2NrLmNvbm5l
Y3QoKHN5cy5hcmd2WzFdLCA0MDQwKSkNCj4gDQo+ICAgICAgd2hpbGUgVHJ1ZToNCj4gICAgICAg
ICAgc29jay5zZW5kYWxsKGInMCcqMjA0OCkNCj4gDQo+IC0tIHRlc3QgcnVucyAtLQ0KPiBydW4g
MSAtIGFsbCBpbnRlcnJ1cHRzIGVuYWJsZWQNCj4gVGltZSB0byBmYWlsdXJlOg0KPiAxIG1pbiBv
ciBsZXNzDQo+IA0KPiBLZXJuZWwgb3V0cHV0Og0KPiBbICAgOTQuMzYxMzEyXSBzY2hlZDogUlQg
dGhyb3R0bGluZyBhY3RpdmF0ZWQNCj4gDQo+IHRvcCBvdXRwdXQ6DQo+ICAgUElEIFVTRVIgICAg
ICBQUiAgTkkgICAgVklSVCAgICBSRVMgICAgU0hSIFMgICVDUFUgICVNRU0gICAgIFRJTUUrIENP
TU1BTkQNCj4gICAxNDUgcm9vdCAgICAgLTUxICAgMCAgICAgICAwICAgICAgMCAgICAgIDAgUiAg
OTUuNSAgIDAuMCAgIDE6MTEuMjIgb2EtdGM2LXNwaS10aHJlYWQNCj4gDQo+IGxpbmsgc3RhdHM6
DQo+IDM6IGV0aDE6IDxCUk9BRENBU1QsTVVMVElDQVNULFVQLExPV0VSX1VQPiBtdHUgMTUwMCBx
ZGlzYyBwZmlmb19mYXN0IHN0YXRlIFVQIG1vZGUgREVGQVVMVCBncm91cCBkZWZhdWx0IHFsZW4g
MTAwMA0KPiAgICAgIGxpbmsvZXRoZXIgMzI6YzI6N2U6MjI6OTM6OTkgYnJkIGZmOmZmOmZmOmZm
OmZmOmZmDQo+ICAgICAgUlg6ICBieXRlcyBwYWNrZXRzIGVycm9ycyBkcm9wcGVkICBtaXNzZWQg
ICBtY2FzdA0KPiAgICAgICAgIDMzNzE5MDIgICAgNzE4NiAgICAgIDAgICAgICA0OCAgICAgICAw
ICAgICAgIDANCj4gICAgICBSWCBlcnJvcnM6ICBsZW5ndGggICAgY3JjICAgZnJhbWUgICAgZmlm
byBvdmVycnVuDQo+ICAgICAgICAgICAgICAgICAgICAgICAwICAgICAgMCAgICAgICAwICAgICAg
IDAgICAgICAgMA0KPiAgICAgIFRYOiAgYnl0ZXMgcGFja2V0cyBlcnJvcnMgZHJvcHBlZCBjYXJy
aWVyIGNvbGxzbnMNCj4gICAgICAgIDEwMzQxNDM4ICAgIDgwNzEgICAgICAwICAgICAgIDAgICAg
ICAgMCAgICAgICAwDQo+ICAgICAgVFggZXJyb3JzOiBhYm9ydGVkICAgZmlmbyAgd2luZG93IGhl
YXJ0YnQgdHJhbnNucw0KPiAgICAgICAgICAgICAgICAgICAgICAgMCAgICAgIDAgICAgICAgMCAg
ICAgICAwICAgICAgIDENCj4gc3RhdGU6DQo+IENvbXBsZXRseSBib3JrZWQsIGNhbid0IHBpbmcg
aW4gb3Igb3V0LCBicmluZ2luZyB0aGUgaW50ZXJmYWNlIGRvd24gdGhlbiB1cA0KPiBoYXMgbm8g
ZWZmZWN0Lg0KPiBUaGVyZSBpcyBubyBTUEkgY2xvY2sgYW5kIG5vIGludGVycnVwdHMgZ2VuZXJh
dGVkIGJ5IHRoZSBtYWMtcGh5Lg0KPiBUaGUgd29ya2VyIHRocmVhZCBzZWVtcyB0byBoYXZlIGxp
dmUgbG9ja2VkLg0KPiANCj4gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0g
LS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0NCj4gcnVuIDIgLSBSWF9CVUZG
RVJfT1ZFUkxPVyBpbnRlcnJ1cHQgZGlzYWJsZWQNCj4gDQo+IHN0YXRlOg0KPiBSdW5zIGp1c3Qg
ZmluZSBidXQgdGhlIG9hLXRjNi1zcGktdGhyZWFkIGlzIGNvbnN1bWluZyAxMC0yMCUgY3B1DQo+
IFBpbmcgdGltZXMgaGF2ZSBpbmNyZWFzZWQgZnJvbSAxLTJtcyB0byA4LTM1bXMNCj4gDQo+IA0K
PiAtLSBhZGRpdGlvbmFsIG5vdGVzIC0tDQo+IFdoZW4gdHdlYWtpbmcgQ09ORklHX0haIEkgZG8g
Z2V0IHNvbWUgY2hhbmdlcyBpbiBiZWhhdmlvdXIsIHRoZSBjcHUNCj4gY29uc3VtcHRpb24gc3Rh
eXMgc3RhYmxlIGF0IDIwJSstMiB3aXRoIENPTkZJR19IWj0yNTAsIHdoZW4gaW5jcmVhc2VkIHRv
DQo+IENPTkZJR19IWj0xMDAwIGl0IGp1bXBzIHVwIGFuZCBkb3duIGJldHdlZW4gMTAtMjAlLg0K
PiANCj4gSSBkb24ndCBoYXZlIGFjY2VzcyB0byBhIGxvZ2ljIGFuYWx5emVyIGJ1dCBteSBvbGQg
b3NjaWxsb3Njb3BlIGlzDQo+IGFsbW9zdCByZWxpYWJsZS4gSSBjb3VsZCBjb25maXJtIHRoYXQg
dGhlIHNwaSBjbG9jayBpcyBpbmRlZWQgcnVubmluZyBhdA0KPiB0aGUgZXhwZWN0ZWQgMjVNSHos
IGJ1dCBJIGNvdWxkIG9ic2VydmUgc29tZSBnYXBzIG9mIHVwIHRvIDMyMMK1cyBzbw0KPiB0aGF0
J3MgOGsgc3BpIGN5Y2xlcyBzcGVudCBkb2luZyBzb21ldGhpbmcgZWxzZS4NCj4gVGhlc2UgZ2Fw
cyB3ZXJlIG9ic2VydmVkIG9uIHRoZSBTUEkgY2xvY2sgYW5kIHRoZSBtYWNwaHkgaW50ZXJydXB0
IHdhcw0KPiBhY3RpdmUgZm9yIHRoZSBzYW1lIGFtbW91bnQgb2YgdGltZSh0aG91Z2ggdGhpcyB3
YXMgbWVhc3VyZWQgaW5kZXBlbmRlbnRseQ0KPiBhbmQgbm90IG9uIHRoZSBzYW1lIHRyaWdnZXIp
Lg0KPiBJJ3ZlIGJlZW4gZHJpbmtpbmcgd2F5IHRvIG11Y2ggY29mZmUsIHNvIHNvbGRlcmluZyBp
cyBub3QgZ29ubmEgaGFwcGVuDQo+IHRvZGF5IChzaGFreSBoYW5kcyksIGJ1dCBpZiBpdCBoZWxw
cyBJIGNhbiBzb2xkZXIgd2lyZXMgdG8gYXR0YWNoIGJvdGgNCj4gcHJvYmVzIHRvIGNvbmZpcm0g
dGhhdCB0aGUgZ2FwIGluIHRoZSBTUEkgY2xvY2sgaGFwcGVucyBhdCB0aGUgc2FtZSB0aW1lDQo+
IG9yIG5vdCBhcyB0aGUgaW50ZXJydXB0IGlzIGFjdGl2ZS4NCj4gDQo+IEknZCBiZSBrZWVuIG9u
IGhlYXJpbmcgd2hhdCBNaWNyb2NoaXBzIHBsYW5zIHRvIGFkZHJlc3MuIElmIHRyYWNraW5nDQo+
IGRvd24gcGVyZm9ybWFuY2UgaXNzdWVzIGlzIGEgcHJpb3JpdHkgSSdsbCBwcm9iYWJseSBub3Qg
c3BlbmQgYW55IHRpbWUNCj4gb24gaXQsIGlmIG5vdCB0aGVuIEknbGwgZGVmaW5ldGx5IGRpZyBp
bnRvIGl0IG1vcmUuDQpJIHRyaWVkIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUgaW4gbXkgc2V0dXAg
d2l0aCB5b3VyIGFib3ZlIGFwcGxpY2F0aW9ucy4NCkJ1dCBzdXJwcmlzaW5nbHkgSSBjb3VsZG4n
dCByZXByb2R1Y2UgdGhlIGlzc3VlIHlvdSBhcmUgZmFjaW5nLg0KDQpPbmUgZW5kIGlzIFJhc3Bi
ZXJyeSBQaSA0IHdpdGggbGFuODY1MSBNQUMtUEhZIGFuZCB0aGUgb3RoZXIgZW5kIGlzIA0KUmFz
cGJlcnJ5IFBpIDQgd2l0aCBFVkItTEFOODY3MC1VU0IgU3RpY2suDQoNCmxhbjg2NTEgTUFDLVBI
WSBzaWRlOg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCnBpQHJhc3BiZXJyeXBpOn4vbGFuODY1
eC92NF9tYWlubGluZSAkIHB5dGhvbjMgc2VydmVyLnB5DQpjb25uZWN0aW9uIGZyb206ICgnMTky
LjE2OC41LjEwMScsIDQ2NjA4KQ0KDQpUb3Agb3V0cHV0Og0KLS0tLS0tLS0tLS0NCnRvcCAtIDE0
OjI4OjE0IHVwICAxOjE0LCAgNCB1c2VycywgIGxvYWQgYXZlcmFnZTogMC42OCwgMC42NywgMC42
Mw0KVGFza3M6IDIwMSB0b3RhbCwgICAxIHJ1bm5pbmcsIDIwMCBzbGVlcGluZywgICAwIHN0b3Bw
ZWQsICAgMCB6b21iaWUNCiVDcHUocyk6ICAwLjIgdXMsICAxLjEgc3ksICAwLjAgbmksIDk4Ljcg
aWQsICAwLjAgd2EsICAwLjAgaGksICAwLjEgc2ksIA0KMC4wIHN0DQpNaUIgTWVtIDogICA3ODEw
LjAgdG90YWwsICAgNzExMC41IGZyZWUsICAgIDM5Mi4zIHVzZWQsICAgIDQzMi40IA0KYnVmZi9j
YWNoZQ0KTWlCIFN3YXA6ICAgIDEwMC4wIHRvdGFsLCAgICAxMDAuMCBmcmVlLCAgICAgIDAuMCB1
c2VkLiAgIDc0MTcuNyBhdmFpbCBNZW0NCg0KICAgICBQSUQgVVNFUiAgICAgIFBSICBOSSAgICBW
SVJUICAgIFJFUyAgICBTSFIgUyAgJUNQVSAgJU1FTSAgICAgVElNRSsgDQpDT01NQU5EIA0KDQog
ICAgNzIxOSByb290ICAgICAtNTEgICAwICAgICAgIDAgICAgICAwICAgICAgMCBTICAgMi43ICAg
MC4wICAgMToxMy4xMSANCm9hLXRjNi1zcGktdGhyZWFkIA0KDQogICAzNTMwNyBwaSAgICAgICAg
MjAgICAwICAgMTYyODAgICA5MjE2ICAgNTI0OCBTICAgMC43ICAgMC4xICAgMDoxNi41MyANCnB5
dGhvbjMgDQoNCiAgIDg4ODMxIHBpICAgICAgICAyMCAgIDAgICAxMTcyOCAgIDQ4NjQgICAyODE2
IFIgICAwLjMgICAwLjEgICAwOjAwLjIyIA0KdG9wIA0KDQogICA4OTgxOSB2bmMgICAgICAgMjAg
ICAwICAgIDIzMjAgICAgMzg0ICAgIDM4NCBTICAgMC4zICAgMC4wICAgMDowMC4wNCANCnNoIA0K
DQogICAgICAgMSByb290ICAgICAgMjAgICAwICAxNjg2NTIgIDExNTgwICAgODQzNiBTICAgMC4w
ICAgMC4xICAgMDowMy44NSANCnN5c3RlbWQgDQoNCiAgICAgICAyIHJvb3QgICAgICAyMCAgIDAg
ICAgICAgMCAgICAgIDAgICAgICAwIFMgICAwLjAgICAwLjAgICAwOjAwLjAxIA0Ka3RocmVhZGQg
DQoNCiAgICAgICAzIHJvb3QgICAgICAyMCAgIDAgICAgICAgMCAgICAgIDAgICAgICAwIFMgICAw
LjAgICAwLjAgICAwOjAwLjAwIA0KcG9vbF93b3JrcXVldWVfcmVsZWFzZSANCg0KICAgICAgIDQg
cm9vdCAgICAgICAwIC0yMCAgICAgICAwICAgICAgMCAgICAgIDAgSSAgIDAuMCAgIDAuMCAgIDA6
MDAuMDAgDQprd29ya2VyL1ItcmN1X2cgDQoNCiAgICAgICA1IHJvb3QgICAgICAgMCAtMjAgICAg
ICAgMCAgICAgIDAgICAgICAwIEkgICAwLjAgICAwLjAgICAwOjAwLjAwIA0Ka3dvcmtlci9SLXJj
dV9wIA0KDQogICAgICAgNiByb290ICAgICAgIDAgLTIwICAgICAgIDAgICAgICAwICAgICAgMCBJ
ICAgMC4wICAgMC4wICAgMDowMC4wMCANCmt3b3JrZXIvUi1zbHViXyANCg0KICAgICAgIDcgcm9v
dCAgICAgICAwIC0yMCAgICAgICAwICAgICAgMCAgICAgIDAgSSAgIDAuMCAgIDAuMCAgIDA6MDAu
MDAgDQprd29ya2VyL1ItbmV0bnMgDQoNCiAgICAgIDExIHJvb3QgICAgICAyMCAgIDAgICAgICAg
MCAgICAgIDAgICAgICAwIEkgICAwLjAgICAwLjAgICAwOjAwLjAzIA0Ka3dvcmtlci91ODowLWV4
dDQtcnN2LWNvbnZlcnNpb24gDQoNCiAgICAgIDEyIHJvb3QgICAgICAgMCAtMjAgICAgICAgMCAg
ICAgIDAgICAgICAwIEkgICAwLjAgICAwLjAgICAwOjAwLjAwIA0Ka3dvcmtlci9SLW1tX3BlDQoN
CmlmY29uZmlnIG91dHB1dDoNCi0tLS0tLS0tLS0tLS0tLS0NCmV0aDE6IGZsYWdzPTQxNjM8VVAs
QlJPQURDQVNULFJVTk5JTkcsTVVMVElDQVNUPiAgbXR1IDE1MDANCiAgICAgICAgIGluZXQgMTky
LjE2OC41LjEwMCAgbmV0bWFzayAyNTUuMjU1LjI1NS4wICBicm9hZGNhc3QgMC4wLjAuMA0KICAg
ICAgICAgZXRoZXIgMDQ6MDU6MDY6MDE6MDI6MDMgIHR4cXVldWVsZW4gMTAwMCAgKEV0aGVybmV0
KQ0KICAgICAgICAgUlggcGFja2V0cyAxNTg5ODc5ICBieXRlcyAyMzkxMDQ1NTgyICgyLjIgR2lC
KQ0KICAgICAgICAgUlggZXJyb3JzIDAgIGRyb3BwZWQgMCAgb3ZlcnJ1bnMgMCAgZnJhbWUgMA0K
ICAgICAgICAgVFggcGFja2V0cyAxMDIyNDE5ICBieXRlcyA3MTk1NDkwNSAoNjguNiBNaUIpDQog
ICAgICAgICBUWCBlcnJvcnMgMCAgZHJvcHBlZCAwIG92ZXJydW5zIDAgIGNhcnJpZXIgMCAgY29s
bGlzaW9ucyAwDQogICAgICAgICBkZXZpY2UgaW50ZXJydXB0IDU1DQoNCmRtZXNnIG91dHB1dDoN
Ci0tLS0tLS0tLS0tLS0NCnBpQHJhc3BiZXJyeXBpOn4vbGFuODY1eC92NF9tYWlubGluZSAkIGRt
ZXNnDQpbICAyMzQuMDE5OTY4XSBMQU44NjVYIFJldi5CMCBJbnRlcm5hbCBQaHkgc3BpMC4wOjAw
OiBhdHRhY2hlZCBQSFkgDQpkcml2ZXIgKG1paV9idXM6cGh5X2FkZHI9c3BpMC4wOjAwLCBpcnE9
UE9MTCkNClsgIDIzNC4wNjkzODddIGxhbjg2NXggc3BpMC4wIGV0aDE6IExpbmsgaXMgVXAgLSAx
ME1icHMvSGFsZiAtIGZsb3cgDQpjb250cm9sIG9mZg0KDQpFVkItTEFOODY3MC1VU0Igc3RpY2sg
c2lkZToNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KcGlAcHYtcnBpLXRwMjp+L21pY3Jv
Y2hpcC90MXMtdXNiICQgcHl0aG9uMyBjbGllbnQucHkgMTkyLjE2OC41LjEwMA0KDQppZmNvbmZp
ZyBvdXRwdXQ6DQotLS0tLS0tLS0tLS0tLS0tDQpldGgxOiBmbGFncz00MTYzPFVQLEJST0FEQ0FT
VCxSVU5OSU5HLE1VTFRJQ0FTVD4gIG10dSAxNTAwDQogICAgICAgICBpbmV0IDE5Mi4xNjguNS4x
MDEgIG5ldG1hc2sgMjU1LjI1NS4yNTUuMCAgYnJvYWRjYXN0IDE5Mi4xNjguNS4yNTUNCiAgICAg
ICAgIGV0aGVyIDAwOjFlOmMwOmQxOmNhOjM5ICB0eHF1ZXVlbGVuIDEwMDAgIChFdGhlcm5ldCkN
CiAgICAgICAgIFJYIHBhY2tldHMgMTAzNDYwNiAgYnl0ZXMgNTgzMzAzMzUgKDU1LjYgTWlCKQ0K
ICAgICAgICAgUlggZXJyb3JzIDAgIGRyb3BwZWQgMCAgb3ZlcnJ1bnMgMCAgZnJhbWUgMA0KICAg
ICAgICAgVFggcGFja2V0cyAxNzIyNDAwICBieXRlcyAyNjI4MTk5MTk3ICgyLjQgR2lCKQ0KICAg
ICAgICAgVFggZXJyb3JzIDAgIGRyb3BwZWQgMCBvdmVycnVucyAwICBjYXJyaWVyIDAgIGNvbGxp
c2lvbnMgMA0KDQpMZXQgbWUga25vdyBpZiB5b3Ugd2FudCB0byB0cnkgYW55dGhpbmcgbW9yZS4N
Cg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IExldCBtZSBrbm93IGlmIGFueXRo
aW5nIGlzIHVuY2xlYXIgb3IgaWYgSSBjYW4gaGVscCBvdXQgd2l0aCBhbnl0aGluZw0KPiBzcGVj
aWZpYy4NCj4gDQo+IFINCg0K

