Return-Path: <linux-kernel+bounces-108802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A731881035
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41FD1C231C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42123D984;
	Wed, 20 Mar 2024 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mU880+w6";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p9qbtrXV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D30038F96;
	Wed, 20 Mar 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931425; cv=fail; b=a3liTZxb2HaflAm6/JGRah4224EsnRwJePsCSH5iE1GrK9s41gn00b70/sfLZgCHjF/sGoU0Rx3iY8HzgWnPJ4WnJn4+a7yCWA6tn37/PXivA26Nx2xslgUciABoPtrLpMmcIT6o6SRIwpYDM51W4mGIT8RqBN0IUlLzRsuxHmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931425; c=relaxed/simple;
	bh=xCptxvM6UJqjAVxXRbKSlsqY7aiVzTsUcNiPLfty68U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EwnDT544zdivmuiEqufD8PIzrCfAwaaws9JNlsXnhGwOsEXHDu9eQCnQX5xXWmMfsaspUtBJam9BfiPLHJbCW/3CQpUg19N62AHdkdozFMONILVJmjfDd34GnrsvaM7AneWg6J4SD+dXnE7s8+e/pZ3AC14Zj7uuYsoTRrZF+P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mU880+w6; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p9qbtrXV; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710931422; x=1742467422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xCptxvM6UJqjAVxXRbKSlsqY7aiVzTsUcNiPLfty68U=;
  b=mU880+w6Gr1IUvNxLSn2NLib0swrb6iCOElx8WBjBQRxSxQmDMD1eMPn
   qNtw7sWy8NO3eoosjYvGk2tYIikRp3YAqLhXRK50S1fhciKt81C5I8zkz
   z5GcxeYaZ+3rUzDvSG4qzbC35o55qc1tQboF5eBx87tovAnUNL79eodtZ
   //y1eyMU4RaGiWp3fuP23OiKBrJb+vfr+VWFAA5HWEhQ9VRs7QgCfEAYk
   bcqJ6Kqy1Ox4ro39EhDQc8bS0BJ37YGnh7m9c72Dm7WP14zFRCH1yESvm
   Loj0aBanVi4vxEObL5enckMAiX3obwPhVGL8TUFWKkPf1jksczwXTKHsA
   w==;
X-CSE-ConnectionGUID: QAOa6bHzSIGY4xWemN7tpA==
X-CSE-MsgGUID: bitNwtoZQAq1rIMB3rLPyg==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="scan'208";a="18427515"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2024 03:43:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 03:43:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 03:43:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csKBcKI1zhjZXu5GTngK8LsD/VSBsYdMkrZt0tEN2OzCt7twofrMcDmu3aTzEYllomKPaOedENBfGsxJS8w/Uq1kwXMdKWkHC7fKHOTgi7JHpy+zFKL/hnFcTkNv3leneR7FBiIHFPXtRd00l0RGduOV+O/iRu1xZLgoKfSPOHXWixtD0W2XilpcYntsdNdgEBBr2XeXx5/WzhHeCm9lYRJY2Gc8nC+IMUlvMy3C+3dSrTuoaMVdBxq9QTOZn9BJyx32Tcoyfu6wcqDlXLn7yAW3eZu54E6T3HYZAynQfOJP3DIjoUvx0VMY73FDSE8Ef8GT1GldZAoOBevZFeXlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCptxvM6UJqjAVxXRbKSlsqY7aiVzTsUcNiPLfty68U=;
 b=PF6tg8LeEEvTu8CBsmaK9ZEGPGmtfMAA2QUy9wTOm4xMUx3V4YX9dctlO/2X6RUmOU4YJXrehUmS0YWmQxjYb/BKbJTxHWfYyplnD7jLh8EHB5XGvG7WmmKcjQiKiwKmNeW6oVML+dHFodEIWPCtSOadueUO7+O2Iy0CSY6488OUMXChAFw/90u9ccFy4d6+I3skhF9nKqXRQxjtspJ+rNdsqhfGWHeC3TPcQ2zNn4rNwnBHiXOqe4QAEmKg2itIjTAxEeAzT9gaSat7reMGQV8j/IVSce+dx/SsfQqnSh474TCb4184T9vFo4UgZVpcTFVBYVc2vAsW75rybTv2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCptxvM6UJqjAVxXRbKSlsqY7aiVzTsUcNiPLfty68U=;
 b=p9qbtrXVmana/TmvvpQ4L5xouIoDi7Q/6LrnDP0uvFgXgHJfgdUgw0tfvo+NF1TiKzcBE1ERZ1urQxqvZWSMak9dcMs1Ml58C3Ul5NCl+USsJeexoOy6Cc/4VmQxFDL4Dl+LqP4AqgrHXWtjm7eRfdRf3rjwC3ei5+/waLCka+F2unjRq4oBmBJ1UjvgY/U8bNnK4IOhcZ0PGzppkO/FoYOK/wDtGuFOsbxM4igxNJmHPBCEsXoX6+2J2dBvAdyS9q28Mz99SEz6dxjfND9k7b0lQAFmRVrI0HR4skuj0qpGl740GgRByPwGgZjaPzkV5zztC0tBWt71cQNpZjyJAw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Wed, 20 Mar
 2024 10:43:18 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Wed, 20 Mar 2024
 10:43:18 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
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
Subject: Re: [PATCH net-next v3 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Topic: [PATCH net-next v3 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Index: AQHab6OSKZ/bhrjyTk2coMHmsOmbgbEshPoAgBKU84CAAAbkgIABZsmA
Date: Wed, 20 Mar 2024 10:43:18 +0000
Message-ID: <53b090b1-d7bb-4a81-9f0b-9979db8dec59@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-9-Parthiban.Veerasooran@microchip.com>
 <208fb61b-4740-46bf-8c70-29ab59cbb965@lunn.ch>
 <f9d8a18c-b1fe-450c-a5ca-d91f96793a04@microchip.com>
 <96dd422f-0bf9-411d-8cc2-5755c1e60e27@lunn.ch>
In-Reply-To: <96dd422f-0bf9-411d-8cc2-5755c1e60e27@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CH3PR11MB7866:EE_
x-ms-office365-filtering-correlation-id: 21153a6f-4b56-4311-9757-08dc48ca8e19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMG5tXhkm+zNrGl5YlC1hB7QhhE6E8OTlzI0rL/VqWAnUgnxZaPlGbGp2v3V3k8ECXusHSf1tVDGP3nnQvpoWYXK4kTOU55soJ5fQk08yOjWxsaR8QD89yhujCFYH04bskaStaRMv1n8cdnGcLqq23l8BpOdl2AtDRhE2l6rtjR7Q5JhIwnghyDa1Y1/M61P8tMkSC4acjq9hyOpaw/gi9e645FNmlEvpAjkG3OhlSeuQzzbj/mdyfsAOiuS77N4+0cL7C319p4FGRrlxwLfrsOI++miE8OoR0RO26SdqEIMf7OEJxGP7Y6TV+yMYSKc7503eBRQIaaN44feeO5ia1n9Znhez6FR8RIJr3XXMPJdBY7RYd0mkWV4xYpkAzvBpVk7ZN/BKCynmtw79fRLruCR6k70UIv0jnH6GL3InBXHPExzBa0OmBriLaEvXIi7dZvbFjQFoWGCBIearbKN0gXNBf+ctt/udLuIKDREffpQjD5fZ6fsnqtTJr/8LkcQO47cegjj0cGQnTdc2q3z/wbyrrVZMpBsxt1MdvrlRw4om0lCQ5sXD5XEyTpnlQQZDzoqqD9fBXXo28B2fiJc/u8/fZkNTuMfiCIwlYKuTXxK76oykTcBYF9wjiRDm4qd9Pzg9q1C4+waxkNMIi/UszFxc2s4pi23iyuNDC+ElJb2zBijKM2I2MYihjrIOtvj7LXL0nOo8a67QsTUPzjqQ6nSlk7qSEq5BLVCojYW1cI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnkwemQzbUZMS3crM3lIRTlvTHZsaEJSK2FrdEh0Smc5TWoySEYweW9KbVVq?=
 =?utf-8?B?eU9VYjhqVktFdFh6a1lUY1N1RmpRNmZ3UmxpZzFEZkZ3d2Y2WGYzQlpnaE50?=
 =?utf-8?B?YktXY1hOQTZISWdidkszNjF1eTlpdWVTL0RrMC80Z1FNZXZQQzNPazI3Tzd1?=
 =?utf-8?B?eDRWV1FDZnNuYWtmb0NnZzhZQklZWjNsY3BCVG14SDhjLzBIdENhVkVna3JM?=
 =?utf-8?B?ai9Jck5vZ0wxRVQzdUVsWTJiR3lRUkxtaHBrMCtFSUNGUHR5N2p5Q3FXc3d3?=
 =?utf-8?B?dWhZMjB1bGJFajFCSDA3Z2hCbFN3dFVEV3plREUyZ094djBYSlhPV0MzZzcy?=
 =?utf-8?B?dnNSN1A2dWVaQjcxRGlWdG9kZDR0RjYzcHJBUkhkMEVncS81UDhtNGk0MjVI?=
 =?utf-8?B?dCtxM2RnNDNQZXMzTTZwWmV4ZW5kd0FvT21SR1JzS0gwTGtEUnJQTHFpNVpN?=
 =?utf-8?B?a3ZNWWV3c3BGOGNrZURRSmVHb29pemtzOW9hNk5oc0VobXAxMkRsZGRZMmhi?=
 =?utf-8?B?SmdlQnJEVVUxN3p5QlovZklZdVdhMzREN3pZMjlxQzhmVDNRUkdPVTVMTDBu?=
 =?utf-8?B?Yzd1b3JoRDFwb0k4MVFwZVBKR0MxbVBxL0JsOVFRME9LdWVvMGIyUE4xU2Iz?=
 =?utf-8?B?MW4xTnU1Rk43akt6VGJ6ZXBWakg3cHdiYkNXRGJWclNHdG1SeDlGRnRpOFFS?=
 =?utf-8?B?Sk52czVmUHNhMzZkSHNLd0UrcytQRGxUOHhKa09rR2NyL0tFRXRYbmhaVUor?=
 =?utf-8?B?TEdVc1BCTXpqMEVOZUNMblhhL1pVbllYeW1wek5IZ1BBMG5TKzRoRVEwVm9t?=
 =?utf-8?B?ejNsOEg1YmpmZTc4cGEyaWN3YmYrTFlxS0E3NEJXd1ozVUY0RTdOZE0rbWpz?=
 =?utf-8?B?M0xxZXVSa1VjSytUaXhoVVZndVpYUFlOc2RVT3lSTWt0UVFucjhBZUZJbU14?=
 =?utf-8?B?WDRZYXNqTVo2YVNIOENZWEVvUkxIYmxoN21YaURQbjdNa1N2Sk5zMTY0Q0ZH?=
 =?utf-8?B?Z2t0NU54TzZhTmtmMnRnaWpsZmo2NUtrVUpreDhkaC8zU3I0MGp5ODZUekx6?=
 =?utf-8?B?M3RObURuV1pKTG04VE1kYkhYMkpPakwyWU0zNlN4dDlpZWFrNHJkY1hITFVN?=
 =?utf-8?B?UDlRK2pPc2ZsWFMyWE95bFE2OURFRU1jZDQvOUVOYzAvWEZoY1ZOVkRxYXA3?=
 =?utf-8?B?L0JTSEFDNW9aTFF2b1VGbXVmb01xbVY2TGRLNk1PM0U2Q3BFTExzcFJPTHFJ?=
 =?utf-8?B?S0pIVCtpTE9LTExpenNVOGhZeUs4cjdaZGVxdkZ2WmEvTlJkYUd5NWdiRjlv?=
 =?utf-8?B?ZlFGMVRmWEd5dzRsajY5ck93bXptOTNMaUNKVGx1RWsvbmRlWWF4L3grdUVj?=
 =?utf-8?B?K0Q1N1hIalc0SHVLaGlNa0R5eUhuV0YremN1QnR4WEtHMmpjSUplb0swdnM1?=
 =?utf-8?B?bnVyZ2VCQjFZUzVJQkV0ZnlaOTBHbnRuUzFVRTN6NDQrQXVKSU9sYlpSRFJS?=
 =?utf-8?B?c3FuL2RST1lwMTBSYVZFZVNNQ21mMklJenZDdVQwcjBOY2t6L2tMdUJpYzNx?=
 =?utf-8?B?RkNwL3pmZm5HcmQ5TjE0UjcxRUVDN3IrTGk3RnF0UGs2a0YrTjJjekFnTENH?=
 =?utf-8?B?MlVUd1BhRmEySm9hSmxZQTVkZFhjQStqSmJOK2p5QTU2SjM5VFd6Y3cyeDFC?=
 =?utf-8?B?NVJPYnNvTVlQTkg4ZEpMcUw3SVR0ODlwNnA1akhFU1N2OE5qTE9wWUJtUTZW?=
 =?utf-8?B?eGJzclV1QStyT1hvMHowWEVRMzhPaHVOVmZBaW1DNEFoUjJSMXU2MDJJNlBI?=
 =?utf-8?B?VUNvaS9tWnI5czZGZVNMcWNJV2tUb0pQWURpeDhHbU1LUWFXMncxNEVLcTJ4?=
 =?utf-8?B?OGFITG5sd0IrS1VONmd5MzlGeTY4Mkx2YmlPbVlTeGNNUlV3ckd6OGMvRlVX?=
 =?utf-8?B?SGF2eEFXWkFLNENJNVhwVmFBZmFaajczSmovNjJuQ3hRWFJPMjlyYkdwYWtD?=
 =?utf-8?B?b0NUZFJIY0RITUJ2Y2FmbUNBakIxVWtrSHAwc2tOcDJwalRybmpHalF6NlBN?=
 =?utf-8?B?VDk0Z2tYRi9xZWlPaGk5emVnT3FldFBxUmlCTnY3TWxNd2pGZ3FrTnpqdW5l?=
 =?utf-8?B?dVFDcXMweHI3REo3cllyQjJEemtaNGI5RnRwTVR1T29WWGJ3Y3dYY0I0bDNZ?=
 =?utf-8?Q?Xd+Dxietx1DLoE5KslbERLI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F15A8F0705D0E94CBB508ADDEF7F1908@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21153a6f-4b56-4311-9757-08dc48ca8e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 10:43:18.3963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BczVAlKDUaL9dZz/Hao6owfTe/mDp2ABJTeRMANGga6DGQjHZpxZt96XAciaAR5HygdIlXsDJ1qpvlulqn2cz/yVBxFpmdL1fvwSPv89p6Bb5WUdRmbTfSyBQkuLO7om
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7866

SGkgQW5kcmV3LA0KDQpPbiAxOS8wMy8yNCA2OjQ5IHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIE1hciAxOSwg
MjAyNCBhdCAxMjo1NDozMFBNICswMDAwLCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+IEhpIEFuZHJldywNCj4+DQo+PiBPbiAwNy8wMy8yNCAxMDozOCBwbSwg
QW5kcmV3IEx1bm4gd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+Pj4NCj4+Pj4gQEAgLTU1LDYgKzc3LDE0IEBADQo+Pj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIChPQV9UQzZfQ1RSTF9NQVhfUkVHSVNURVJTICpc
DQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9B
X1RDNl9DVFJMX1JFR19WQUxVRV9TSVpFKSArXA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBPQV9UQzZfQ1RSTF9JR05PUkVEX1NJWkUpDQo+Pj4+
ICsjZGVmaW5lIE9BX1RDNl9DSFVOS19QQVlMT0FEX1NJWkUgICAgICAgICAgICA2NA0KPj4+PiAr
I2RlZmluZSBPQV9UQzZfREFUQV9IRUFERVJfU0laRSAgICAgICAgICAgICAgICAgICAgICA0DQo+
Pj4+ICsjZGVmaW5lIE9BX1RDNl9DSFVOS19TSVpFICAgICAgICAgICAgICAgICAgICAoT0FfVEM2
X0RBVEFfSEVBREVSX1NJWkUgK1wNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE9BX1RDNl9DSFVOS19QQVlMT0FEX1NJWkUpDQo+Pj4+ICsjZGVmaW5l
IE9BX1RDNl9UWF9TS0JfUVVFVUVfU0laRSAgICAgICAgICAgICAxMDANCj4+Pg0KPj4+IFNvIHlv
dSBrZWVwIHVwIHRvIDEwMCBwYWNrZXRzIGluIGEgcXVldWUuIElmIHVzZSBhc3N1bWUgdHlwaWNh
bCBNVFUNCj4+PiBzaXplIHBhY2tldHMsIHRoYXQgaXMgMSwyMzgsNDAwIGJpdHMuIEF0IDEwTWJw
cywgdGhhdCBpcyAxMjBtcyBvZg0KPj4+IHRyYWZmaWMuIFRoYXQgaXMgcXVpdGUgYSBsb3Qgb2Yg
bGF0ZW5jeSB3aGVuIGEgaGlnaCBwcmlvcml0eSBwYWNrZXQgaXMNCj4+PiBhZGRlZCB0byB0aGUg
dGFpbCBvZiB0aGUgcXVldWUgYW5kIG5lZWRzIHRvIHdhaXQgZm9yIGFsbCB0aGUgb3RoZXINCj4+
PiBwYWNrZXRzIHRvIGJlIHNlbnQgZmlyc3QuDQo+Pj4NCj4+PiBDaHVua3MgYXJlIDY0IGJ5dGVz
LiBTbyBpbiBwcmFjdGljZSwgeW91IG9ubHkgZXZlciBuZWVkIHR3bw0KPj4+IHBhY2tldHMuIFlv
dSBuZWVkIHRvIGJlIGFibGUgdG8gZmlsbCBhIGNodW5rIHdpdGggdGhlIGZpbmFsIHBhcnQgb2YN
Cj4+PiBvbmUgcGFja2V0LCBhbmQgdGhlIGJlZ2lubmluZyBvZiB0aGUgbmV4dC4gU28gaSB3b3Vs
ZCB0cnkgdXNpbmcgYSBtdWNoDQo+Pj4gc21hbGxlciBxdWV1ZSBzaXplLiBUaGF0IHdpbGwgYWxs
b3cgTGludXggcXVldWUgZGlzY2lwbGluZXMgdG8gZ2l2ZQ0KPj4+IHlvdSB0aGUgaGlnaCBwcmlv
cml0eSBwYWNrZXRzIGZpcnN0IHdoaWNoIHlvdSBzZW5kIHdpdGggbG93IGxhdGVuY3kuDQo+PiBU
aGFua3MgZm9yIHRoZSBkZXRhaWxlZCBleHBsYW5hdGlvbi4gSWYgSSB1bmRlcnN0YW5kIHlvdSBj
b3JyZWN0bHksDQo+Pg0KPj4gMS4gVGhlIHR4IHNrYiBxdWV1ZSBzaXplIChPQV9UQzZfVFhfU0tC
X1FVRVVFX1NJWkUpIHNob3VsZCBiZSAyIHRvIGF2b2lkDQo+PiB0aGUgbGF0ZW5jeSB3aGVuIGEg
aGlnaCBwcmlvcml0eSBwYWNrZXQgYWRkZWQuDQo+Pg0KPj4gMi4gTmVlZCB0byBpbXBsZW1lbnQg
dGhlIGhhbmRsaW5nIHBhcnQgb2YgdGhlIGJlbG93IGNhc2UsDQo+PiBJbiBjYXNlIGlmIG9uZSBw
YWNrZXQgZW5kcyBpbiBhIGNodW5rIGFuZCB0aGF0IGNodW5rIHN0aWxsIGhhdmluZyBzb21lDQo+
PiBzcGFjZSBsZWZ0IHRvIGFjY29tbW9kYXRlIHNvbWUgYnl0ZXMgZnJvbSB0aGUgbmV4dCBwYWNr
ZXQgaWYgYXZhaWxhYmxlDQo+PiBmcm9tIG5ldHdvcmsgbGF5ZXIuDQo+IA0KPiBUaGlzIHNlY29u
ZCBwYXJ0IGlzIGNsZWFybHkgYW4gb3B0aW1pc2F0aW9uLiBJZiB5b3UgaGF2ZSBsb3RzIG9mIGZ1
bGwNCj4gTVRVIHBhY2tldHMsIDE1MTQgYnl0ZXMsIHRoZXkgdGFrZSBhcm91bmQgMjQgY2h1bmtz
LiBIYXZpbmcgdGhlIGxhc3QNCj4gY2h1bmsgb25seSAxLzIgZnVsbCBkb2VzIG5vdCB3YXN0ZSB0
b28gbXVjaCBiYW5kd2lkdGguIEJ1dCBpZiB5b3UgYXJlDQo+IGNhcnJ5aW5nIGxvdHMgb2Ygc21h
bGwgcGFja2V0cywgc2F5IHZvaWNlLCAxMzAgYnl0ZXMsIHRoZSB3YXN0ZWQNCj4gYmFuZHdpZHRo
IHN0YXJ0cyB0byBhZGQgdXAuIEJ1dCBpcyB0aGVyZSBhIHVzZSBjYXNlIGZvciAxME1icHMgb2YN
Cj4gc21hbGwgcGFja2V0cz8gSSBkb3VidCBpdC4NClllcywgZm9yIHN1cmUgdGhlcmUgaXMgYSBw
b3NzaWJpbGl0eSB0byBnZXQgaW50byB0aGlzIHNjZW5hcmlvIGFuZCB0aGUgDQpwcm90b2NvbCBh
bHNvIHN1cHBvcnRzIHRoYXQuIEJ1dCBhcyBwcm9wb3NlZCBieSB5b3UgYmVsb3csIGxldCdzIA0K
aW1wbGVtZW50IGl0IGFzIHBhcnQgb2Ygb3B0aW1pemF0aW9uIGxhdGVyLg0KPiANCj4gU28gaWYg
eW91IGRvbid0IGhhdmUgdGhlIGFiaWxpdHkgdG8gY29tYmluZSB0d28gcGFja2V0cyBpbnRvIG9u
ZQ0KPiBjaHVuaywgaSB3b3VsZCBkbyB0aGF0IGxhdGVyLiBMZXRzIGdldCB0aGUgYmFzaWNzIG1l
cmdlZCBmaXJzdCwgaXQgY2FuDQo+IGJlIG9wdGltaXNlZCBsYXRlci4NClllcywgSSBhZ3JlZSB3
aXRoIHRoaXMgcHJvcG9zYWwgdG8gZ2V0IHRoZSBiYXNpYyB2ZXJzaW9uIG1lcmdlZCBmaXJzdC4N
Cg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAgICAgIEFuZHJldw0KDQo=

