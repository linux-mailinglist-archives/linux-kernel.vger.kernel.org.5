Return-Path: <linux-kernel+bounces-106032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21B887E7EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6031F224BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DDD3612A;
	Mon, 18 Mar 2024 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W4IIszAC";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kWj6eI3P"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE7364AB;
	Mon, 18 Mar 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759709; cv=fail; b=jIk4BLSotb0zTBkKPDV7W5umoFRwwmiBkC/I1IFyB+KAS1c6sqOG6e7UHmxq0A7yrBk+z5nRxMGiRUnseeb5C5mxoTULmiFvmBgCaq19pH9VIBbUCA4so5Az6htDiBfCET1ZAqjFzXOnLGCMsGUn13abD4h9UFbLAvLvuV8hLoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759709; c=relaxed/simple;
	bh=HNAIVZuuF9cJZ2UhoYmC1HM66yTLiQDHJBTpQKMkDXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=msA6q2re4T1EeYkXKC8DxSNA2hHbpv7yUJjZne13+UuIArr5LQLdAw0r5WCXs7mTg9mf5XnL4/TsQXhY6DKzyW0NcVVeSHXw/zf/wOVpu3fhSYjKSUeaNIRiRdtFVy6yv7vkINTT1ArVtMMmlmxaZP+5Mwijqu6TvZ1pdCbm5YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=W4IIszAC; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kWj6eI3P; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710759706; x=1742295706;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HNAIVZuuF9cJZ2UhoYmC1HM66yTLiQDHJBTpQKMkDXE=;
  b=W4IIszAC8PQ6xfOe7Ft0NBfQkG95UoI6gkODKfpf12c3oeAOSKBa8wlx
   gRFH9SLuwx7a+uyhMX5bXvb0iudFnbbkREcHNwkH5PScK8+oBNVpERlxL
   vWjYswJrm5ggwk7lLFbKzlMXfK+z2UPv0VtgsINmcGwaKMUHGn8emZ6ef
   VuZwYEOHa2DvfobqjQPonGzLBhE9RAhgJvibyRSqEljLpHF9pGO0Ob+p+
   oigovA6zJC3Bpz2pfzjYl1qUgCetNiERMMlDw5IffH8qyc1leZ1W/Ozkj
   uyGnnnxP0PUgzU7pVVupKTDU6JdQEGF8R4FBRLKVNACHHmxAU9cHI28kI
   w==;
X-CSE-ConnectionGUID: 5m+ti3J/TXSy6z8EqO64Jw==
X-CSE-MsgGUID: R2KMnYXjQ+29zyScI9GRzA==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; 
   d="scan'208";a="18315042"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2024 04:01:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 04:01:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 04:01:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgT6GWDtegQgzBl4oUK9vXiKNFxuFP1GUkU15tZoEan2S8QUZWTocj/q46agkwWA3pMG9U/wYWo3BgbPm0gisiMxU66CKushVBs0EFhGDvfa5XqJcQiHBUhttSoMTsabKfF++QLzaTfXZ4xm2CnNwdrAAo5mzBGSd6koxQFYwS3bnUDfCmBI4ISusH+Dbe2yV+MUncPyViwoo4DQgiQhSXCerM9vaAEzPtlA3Gw+BJcgqWve3DE8HesCkztl1apSL4nqBdZTO4buzoZhOf3v92GSL4RtlECcVsaHut6t3ElgiSn0l6ZKsVFUdwm6D9nkTq6yNECxKivV0BcnPssnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNAIVZuuF9cJZ2UhoYmC1HM66yTLiQDHJBTpQKMkDXE=;
 b=XEw8J8sanQumD3zjl1yaws2Z2zrNSAAp70xswt68rKJONqhx9i9HEOYmjUQ+c1khMu8M7TgsKLyeGIrmR004RBLlPHl+Gsa/s5aKvE5pZUVYzP3AhFcAGByCbbizeUG+T1cbwpg+L5wZOdbc6BV5X7nRMk2TRKJgMW1Edk7jXeu9gmhkbr5kJdH74Bz8wUat9P4lag0Hd1xHXGY8OfC7NLih/lhNWOaFtYobXlbe6xMj44PRZ1MMirUnD+cS/poccS092+tudhEM7bfHHnuIhXjNEFDxO+p4o+2TP8jEVoXPKDSKIqEOsUq/0iEKjUrxuu6ITZImB48kOTZJ9nTRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNAIVZuuF9cJZ2UhoYmC1HM66yTLiQDHJBTpQKMkDXE=;
 b=kWj6eI3PNuX5j3+g70+5KS4PMyF55Of8qFcSnSEbPwG6HKNVP07uphybUsfnIx5/zMKcze5sqofbPoRofT7YIRZg8qXYAoytWfekWNq3GTTnn06VlW9EYWUrNV1yFcBhySYry751Jlr6visaDShitbFu8KGAfYG+p9cmSWS2ZgIX/h8MT37kdHicSx5jrOuKksiusWfd0Tt4ipa8UBbK3vGspFiDWGieujJvPAq0l5L2hRmdEg6o3Ht+pVaZik62NCf0igPq5Zbh1ddtTtA2GqlJGwMXv61LfAFi38F5KmFfmd6wdsQVTl2wbG3UD/ecn+7amwYf764VH/9AwpJUAw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA1PR11MB6823.namprd11.prod.outlook.com (2603:10b6:806:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.14; Mon, 18 Mar
 2024 11:01:13 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Mon, 18 Mar 2024
 11:01:13 +0000
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
Subject: Re: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Topic: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Index: AQHab6OHj5kLkYW7WEGlK1Xe+8KWTLEregYAgADhwoCAACAwgIABRrCAgAAYZQCAD4ziAA==
Date: Mon, 18 Mar 2024 11:01:12 +0000
Message-ID: <372a45c3-1372-4956-8d42-8e989f86d131@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
 <8c2b95f4-75a7-4d6d-ab9c-9c3498c040d8@lunn.ch>
 <eeb57938-e21e-406d-a835-93c6fb19b161@microchip.com>
 <7ddbe599-187e-401f-b508-4dc62bca8374@lunn.ch>
 <e9bc573e-61f0-484a-b1fb-b5100eb9ee0a@microchip.com>
 <8de7a4bb-a127-4771-97dd-038f08fcce9d@lunn.ch>
In-Reply-To: <8de7a4bb-a127-4771-97dd-038f08fcce9d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SA1PR11MB6823:EE_
x-ms-office365-filtering-correlation-id: 78d83ebd-175d-451c-8bef-08dc473ab9c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8QYYGsrT+sx3V0reIh3mfBkbH0qWG70cmiVwqS/uWvYuZdKoQBJCusbpJ31Ro6WdhZmvdl7/HUDowGIier/k/uMWuN42k5ToEMq4Y/2bgK5aHnb5+uHujMq3CVzVIUARZMle6ATfe+qG9twZgAjQfL/cmjsq/+LS9wcyy2KFHMTx4j+CyyT0RKaz7ocjht4M169wLPkrxKsTGglrF45AFV+PCN/dsabS6AHBmCemSmRGsuxIInyx66HI3AegbQIw8gXVHL0JB+0OCTkhCQVON6gprYoDmIVhFyivozBcE+8i0MYdWbp6GLRJ35oFVyKHhu4drDrm9j0qMVxuNbRvB5K9/3muj5BmqPX/WJiWpEZENnbC3DOumFGPSZPJjdiSukAVUVwhKUU5lyfOcs2OJA49TUdHZ8dVaN7icGzBSE4fEgChgxXAN7YhUrYlbgxRS54LWsE4lSnQbDe2Y9QhdwY5x+QFcRBQoxmQ1UVTuvc55Qpi8LSgn73CZqU7aKJTen/EC6GqczWrcbux042hVsKNEtGkG5XoSYLxDnYz8VOkFFnw/8JClwA2JqWjBR0VDIFIym1YKFJrtBP4PWJ/QE/Bspr7kM2ClpNk/FCDFQL9Dlh8czEK5iB1WdRdDQ+WR5bHfM5yrzPd6h7yr6b2cQyXjTOSg7ny9rRQqsVgzNl241CkTEDfugOUC5Pyd9DSYIRQvw4M6r5SIA4RlqbDta5VMy/FS5npO5lPWxoMZbI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW1aTTJOMkNEc01HQ2lHR2gycGVVVUl6ZUZLaG1wZXgyRWh5d0RmNG1VRStJ?=
 =?utf-8?B?anFrcFlCcDZDNXFsVnI2eXY1aHVCR2g1UFhIOFBScDBDK21CbHRnYVJBbnNM?=
 =?utf-8?B?d3VDd0JpUFF3TmF0cEJUUkM5S0RwRVdxSXpxcnc0YzZOME0wT290N0tSMEFO?=
 =?utf-8?B?SU82VGlkekZ3UlU1WEFWK05FQ0h5anVBd3ozMVBHekxucGZQQ0VRbWVjWjda?=
 =?utf-8?B?aDFtUm8rYUJaWVZQTE04QTJKdkdsY0ZHWWFBbHNyUzJQYVRCKzF6WGNSdnVE?=
 =?utf-8?B?U2J5UjFkV1lNanRiM1BlRmd6WlpWeHVSWUFOTWViSjAvSHdFV2M2OVpQdGpX?=
 =?utf-8?B?Zi9zQ2RkTm9BK1VRYk5wYnNwVzg4Z2lFZTFOZkxtUkdFZHI0eHBIeUI3V0Jj?=
 =?utf-8?B?cGJvTDVlaWF2QkFBNmNtR2dOMHRrSGM5eEdhYVhidlcvWlNBQzFiMW4wZyta?=
 =?utf-8?B?TS9KL0k0RTQ3S2ppNVJSbXRrc1Q3dkltU0FGSkJCKzRidjFHTGxIQ3BLOGRp?=
 =?utf-8?B?MVdCcTRTUmlEdTM4NngvbDFWL05KNWUwM1J6TzR2WG9YbnhMcnIxU3EvRU5O?=
 =?utf-8?B?OXUyelVtQVMzQ2NqZXRFVjhsK2hJNFVoMjlPV1RXZ1czQjF4YVI4eklzOWgz?=
 =?utf-8?B?Y2dwT3BJaWI0OUdtbkcrTTRSUXVpL293TGdlQUZNTXFOWng4OUx1U3lUVHJo?=
 =?utf-8?B?MWIyT0RTZS81ZkFLYkJJdXk2a0xsUjMyNy9QV0pzSnpOczVNbDczc0pNVFBQ?=
 =?utf-8?B?eGdlSkppZGRVcWJUVnNjREhMSmdYZVdxRzlOUlhDR1hzSWRRaVpiUUFXQUJp?=
 =?utf-8?B?YUU3Q1ZSRkpKLzRtdzlGR0kxa1NOdko1ZXYxdi9hK1lBRzFCZ1ZSVzlGVmli?=
 =?utf-8?B?aHJodllTYTdDUSsxQTRPK1F4ajB4NTVQMjN1Vis4VXowbU5hU21KZm1QTkt4?=
 =?utf-8?B?REozaS9rd0VUUHF3eE11dHdNTTY0c003Qk9mZVV3cEJJVHQvM3BNbEEwVjY1?=
 =?utf-8?B?UkxKYVhuZmZKeEtDeUlWaXhPN3BTa1hla3JPVTdIWVlBYXB2cEZ4aUx6UG1t?=
 =?utf-8?B?KzNldnEvRWhSdkFUWkthZmQ3OUVJWE8xM3BDR2NydmlXRnNYbG5VTlloUXlx?=
 =?utf-8?B?dkdUWVdTMERnTk8rN1l4UHN0RUg2ZGFvZ1poWXpMTUovWFdjRmZVS2tBeHFl?=
 =?utf-8?B?ZXRnQkh1YzdpeGVnNWUvMGRuRnFsZzlmZysrN0lzeElRaTQwTE1qbkp6SjVB?=
 =?utf-8?B?YloyK3JuSVMvU2hTeFZscjlQdUhpYzNpUVJETXJUR1VZYTFvYkY0M0lrajVB?=
 =?utf-8?B?cnNHdkNWTjVRVUhud2lCSWFMVmJvaEF2QzZmSzVicVJUVGhaYTJyVHFKejVV?=
 =?utf-8?B?N1A0czhtUTBWU3dVeS8rL0dEb00zYWQxZzdKQTVrWXd1WHJnd1lZS1ppYlo1?=
 =?utf-8?B?V3dvaERqZ3JraUVOSUw2MnFXK1hIUzI0NkpRZForS0tVSUtSNXhDSERDNVhl?=
 =?utf-8?B?aWFQZ1gwQ0pyR1FhZXVzdkJPaHZOUy9SYVNlb1AzeVVwNEdodk1zbitpejIz?=
 =?utf-8?B?KytRK3puUmRhUlZwQzVIODVCdzdtVWRzY1hOT1ZqUjhhR2NOTGczeFBXdnpM?=
 =?utf-8?B?bUtwM1lXcEV3cWpNVERpQkhWK0UrZEFkbEhIbGg1Z0hmeWo2RTl4MmNZdVQw?=
 =?utf-8?B?a3BXWGEvWXBPUzdzUXVhMEZRaUdaVWozNXdYa3NwTHhQMGVnTlRPeFBtMnBK?=
 =?utf-8?B?YTNvR3kzdHk0WlJuYXNIdlgwM3RCaysrZEdBYUlMRmdtcnlHQ1Yxd29yNlZr?=
 =?utf-8?B?d01DKzRlbXRwck9KQkZtc2RxVGVZSmw4ZWRTQ2U5OGxOckpuRUtqemRhTk9l?=
 =?utf-8?B?QVVkNlgvZlJVb0IxTzM1UDB4eDczeEJlZ3FyTERobjVHK3Nud3lZTStCRzBI?=
 =?utf-8?B?emM3RFdRcW1EYzJNeThNaUp2eitNaHZuLzNrVUIydkxVdmFFc0FHdWZCVDZD?=
 =?utf-8?B?ZitYcVN6bXYxU2FwaEdnUUpZdlMvbHVGdXJ0b09RdkREK0FBL3doWU9DQzl4?=
 =?utf-8?B?dTZtWENTckdvalhNdEMyRDB5d3ByYUJpelNiUFowUXRnR3FVMGVYNG1BSGZx?=
 =?utf-8?B?a2N6MWp2ZFZBWmdmWTJzLzBHNkFKUDloRzNFaFQvVUEyVURncWxBa3FlQmJq?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73F76D68D1F25A4296C5E2497F345832@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d83ebd-175d-451c-8bef-08dc473ab9c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 11:01:12.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXTgPLljKQQJKP0EZm7hJGns0Fg+Fry+uUqvLqxy1qSwqoHMPG3skjX/mJmqtEnq5MB+tuUHf4HoDK6bha/F1FQn6qwxUK0qWIE8/hCloFt+IGNpKekW8YIY34loN3W7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6823

SGkgQW5kcmV3LA0KDQpPbiAwOC8wMy8yNCA3OjAzIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gT2ssIGFzIHBlciB0aGUg
dGFibGUgNiBpbiB0aGUgc3BlYywgUEhZIEM0NSByZWdpc3RlcnMgYXJlIG1hcHBlZCBpbiB0aGUN
Cj4+IE1NUyBsaWtlIGJlbG93LA0KPj4NCj4+IFBIWSDigJMgUENTIFJlZ2lzdGVycyAoTU1EIDMp
ICAtLS0+ICBNTVMgMg0KPj4gUEhZIOKAkyBQTUEvUE1EIFJlZ2lzdGVycyAoTU1EIDEpICAtLS0+
ICAgTU1TIDMNCj4+IFBIWSDigJMgVmVuZG9yIFNwZWNpZmljIGFuZCBQTENBIFJlZ2lzdGVycyAo
TU1EIDMxKSAgLS0tPiAgTU1TIDQNCj4+IFBIWSDigJMgQXV0by1OZWdvdGlhdGlvbiBSZWdpc3Rl
cnMgKE1NRCA3KSAgLS0tPiAgTU1TIDUNCj4+IFBIWSDigJMgUG93ZXIgVW5pdCAoTU1EIDEzKSAg
LS0tPiAgTU1TIDYNCj4+DQo+PiBNTUQgMTMgZm9yIFBIWSAtIFBvd2VyIFVuaXQgaXMgbm90IGRl
ZmluZWQgaW4gdGhlIG1kaW8uaC4gU28gaW4gdGhlDQo+PiBiZWxvdyBjb2RlIEkgaGF2ZSBkZWZp
bmVkIGl0IGxvY2FsbHkgKE1ESU9fTU1EX1BPV0VSX1VOSVQpLiBNYXkgYmUNCj4+IG5lZWRlZCB0
byBkbyB0aGlzIGluIHRoZSBtZGlvLmggZmlsZSB3aGVuIGNvbWluZyB0byB0aGlzIHBhdGNoLg0K
PiANCj4gWWVzLCBwbGVhc2UgYWRkIGl0IHRvIG1kaW8uaA0KU3VyZSB3aWxsIGFkZCBpdCBpbiB0
aGUgbWRpby5oIGZpbGUuDQo+IA0KPj4gLyogUEhZIOKAkyBDbGF1c2UgNDUgcmVnaXN0ZXJzIG1l
bW9yeSBtYXAgc2VsZWN0b3IgKE1NUykgYXMgcGVyIHRhYmxlIDYgaW4NCj4+IHRoZSBPUEVOIEFs
bGlhbmNlIHNwZWNpZmljYXRpb24uDQo+PiAgICAqLw0KPj4gI2RlZmluZSBPQV9UQzZfUEhZX1BD
U19NTVMyICAgICAgICAgICAgICAgICAgICAgMiAgICAgICAvKiBNTUQgMyAqLw0KPj4gI2RlZmlu
ZSBPQV9UQzZfUEhZX1BNQV9QTURfTU1TMyAgICAgICAgICAgICAgICAgMyAgICAgICAvKiBNTUQg
MSAqLw0KPj4gI2RlZmluZSBPQV9UQzZfUEhZX1ZTX1BMQ0FfTU1TNCAgICAgICAgICAgICAgICAg
NCAgICAgICAvKiBNTUQgMzEgKi8NCj4+ICNkZWZpbmUgT0FfVEM2X1BIWV9BVVRPX05FR19NTVM1
ICAgICAgICAgICAgICAgIDUgICAgICAgLyogTU1EIDcgKi8NCj4+ICNkZWZpbmUgT0FfVEM2X1BI
WV9QT1dFUl9VTklUX01NUzYgICAgICAgICAgICAgIDYgICAgICAgLyogTU1EIDEzICovDQo+Pg0K
Pj4gLyogTURJTyBNYW5hZ2VhYmxlIERldmljZSAoTU1EKSBmb3IgUEhZIFBvd2VyIFVuaXQgKi8N
Cj4+ICNkZWZpbmUgTURJT19NTURfUE9XRVJfVU5JVCAgICAgICAgICAgICAgICAgICAgIDEzICAg
ICAgLyogUEhZIFBvd2VyIFVuaXQgKi8NCj4+DQo+PiBzdGF0aWMgaW50IG9hX3RjNl9tZGlvYnVz
X3JlYWRfYzQ1KHN0cnVjdCBtaWlfYnVzICpidXMsIGludCBhZGRyLCBpbnQNCj4+IGRldm51bSwg
aW50IHJlZ251bSkNCj4+IHsNCj4+DQo+PiAgICAgICAgICAgc3RydWN0IG9hX3RjNiAqdGM2ID0g
YnVzLT5wcml2Ow0KPj4NCj4+ICAgICAgICAgICB1MzIgcmVndmFsOw0KPj4NCj4+ICAgICAgICAg
ICBib29sIHJldDsNCj4+DQo+PiAgICAgICAgICAgdTMyIG1tczsNCj4+DQo+Pg0KPj4NCj4+ICAg
ICAgICAgICBpZiAoZGV2bnVtID09IE1ESU9fTU1EX1BDUykNCj4+DQo+PiAgICAgICAgICAgICAg
ICAgICBtbXMgPSBPQV9UQzZfUEhZX1BDU19NTVMyOw0KPj4NCj4+ICAgICAgICAgICBlbHNlIGlm
IChkZXZudW0gPT0gTURJT19NTURfUE1BUE1EKQ0KPj4NCj4+ICAgICAgICAgICAgICAgICAgIG1t
cyA9IE9BX1RDNl9QSFlfUE1BX1BNRF9NTVMzOw0KPj4NCj4+ICAgICAgICAgICBlbHNlIGlmIChk
ZXZudW0gPT0gTURJT19NTURfVkVORDIpDQo+Pg0KPj4gICAgICAgICAgICAgICAgICAgbW1zID0g
T0FfVEM2X1BIWV9WU19QTENBX01NUzQ7DQo+Pg0KPj4gICAgICAgICAgIGVsc2UgaWYgKGRldm51
bSA9PSBNRElPX01NRF9BTikNCj4+DQo+PiAgICAgICAgICAgICAgICAgICBtbXMgPSBPQV9UQzZf
UEhZX0FVVE9fTkVHX01NUzU7DQo+Pg0KPj4gICAgICAgICAgIGVsc2UgaWYgKGRldm51bSA9PSBN
RElPX01NRF9QT1dFUl9VTklUKQ0KPj4NCj4+ICAgICAgICAgICAgICAgICAgIG1tcyA9IE9BX1RD
Nl9QSFlfUE9XRVJfVU5JVF9NTVM2Ow0KPiANCj4gSSB3b3VsZCBwcm9iYWJseSB1c2UgYSBzd2l0
Y2ggc3RhdGVtZW50Lg0KQWggb2ssIEkgd2lsbCB1c2Ugc3dpdGNoIGhlcmUuDQo+IA0KPj4NCj4+
ICAgICAgICAgICBlbHNlDQo+Pg0KPj4gICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQ
UDsNCj4gDQo+IDgwMi4zIHNheXM6DQo+IA0KPiAgICBJZiBhIGRldmljZSBzdXBwb3J0cyB0aGUg
TURJTyBpbnRlcmZhY2UgaXQgc2hhbGwgcmVzcG9uZCB0byBhbGwNCj4gICAgcG9zc2libGUgcmVn
aXN0ZXIgYWRkcmVzc2VzIGZvciB0aGUgZGV2aWNlIGFuZCByZXR1cm4gYSB2YWx1ZSBvZg0KPiAg
ICB6ZXJvIGZvciB1bmRlZmluZWQgYW5kIHVuc3VwcG9ydGVkIHJlZ2lzdGVycy4gV3JpdGVzIHRv
IHVuZGVmaW5lZA0KPiAgICByZWdpc3RlcnMgYW5kIHJlYWQtb25seSByZWdpc3RlcnMgc2hhbGwg
aGF2ZSBubyBlZmZlY3QuIFRoZQ0KPiAgICBvcGVyYXRpb24gb2YgYW4gTU1EIHNoYWxsIG5vdCBi
ZSBhZmZlY3RlZCBieSB3cml0ZXMgdG8gcmVzZXJ2ZWQgYW5kDQo+ICAgIHVuc3VwcG9ydGVkIHJl
Z2lzdGVyIGJpdHMsIGFuZCBzdWNoIHJlZ2lzdGVyIGJpdHMgc2hhbGwgcmV0dXJuIGENCj4gICAg
dmFsdWUgb2YgemVybyB3aGVuIHJlYWQuDQo+IA0KPiBTbyBtYXliZSByZXR1cm4gMC4gRU5PVFNV
UFAgaXMgd3JvbmcsIHRoYXQgaXMgYW4gTkZTIG9ubHkgZXJyb3INCj4gY29kZS4gVGhlIGdlbmVy
aWMgb25lIGlzIEVPUE5PVFNVUFAuIEkgd291bGQgc2F5IC1FT1BOT1RTVVBQIGlzIGFsc28NCj4g
Ty5LLg0KU3VyZSwgSSB3aWxsIHVzZSAtRU9QTk9UU1VQUCBpbiB0aGUgbmV4dCB2ZXJzaW9uIGlu
c3RlYWQgb2YgLUVOT1RTVVBQLg0KPiANCj4+ICAgICAgICAgICByZXQgPSBvYV90YzZfcmVhZF9y
ZWdpc3Rlcih0YzYsIChtbXMgPDwgMTYpIHwgcmVnbnVtLCAmcmVndmFsKTsNCj4+DQo+PiAgICAg
ICAgICAgaWYgKHJldCkNCj4+DQo+PiAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsN
Cj4gDQo+IG9hX3RjNl9yZWFkX3JlZ2lzdGVyKCkgc2hvdWxkIHJldHVybiBhbiBlcnJvciBjb2Rl
LCBzbyByZXR1cm4gd2hhdGV2ZXINCj4gaXMgcmV0dXJucy4gRG9uJ3Qgb3ZlcndyaXRlIGVycm9y
IGNvZGVzLiBJdCBtYWtlcyBpdCBoYXJkZXIgdG8gdHJhY2sNCj4gZXJyb3JzIHRocm91Z2ggdGhl
IGNhbGwgc3RhY2suDQpBaCBvaywgd2lsbCByZXR1cm4gdGhlIGVycm9yIGNvZGUgZnJvbSBvYV90
YzZfcmVhZF9yZWdpc3RlcigpIGluIHRoZSANCm5leHQgdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRz
LA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAgICAgQW5kcmV3DQo+IA0KDQo=

