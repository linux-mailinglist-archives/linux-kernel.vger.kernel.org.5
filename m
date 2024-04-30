Return-Path: <linux-kernel+bounces-163845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEE78B7470
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8551C23290
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB3912DD8F;
	Tue, 30 Apr 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PEtFThCW";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r2DvVqfw"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E812BF32;
	Tue, 30 Apr 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476643; cv=fail; b=C3EbafOlpu/rDNU55LXmaX7VCo6ayyKFoMYjtkLpN1h4Hm21dZvsHrjfz5dKI6XtB13IQfA/XIZK0Dyu6ld+F46Ug4VUS9xi+RbFUPIMlwa/TKkV8vT7QC0OwW3NoD5v0cB9B/wsWZvoAcqiqTVh3/a3oiEXKM7IkpZzXbowPnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476643; c=relaxed/simple;
	bh=h8FIiGNH1ycphTO3U7JeYiBwfa7IYVG1qDOOWiFwl2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KucTpTz/cXLPtM/cxVOnAG0yt0fmN3unzghOMm+YTac7yNiFZWJhTtChMF42Ie7X9MihWqE+UdxlQ7SZUwWyOrA6eYTi4bztmy/zX8laoHeB6pS8chlT0ERp6bfx9sunqJJQ2Ehmr1rmAkHfH9tNr1lL+PNmTXqQCpTXJ5hmXqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PEtFThCW; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r2DvVqfw; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714476640; x=1746012640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h8FIiGNH1ycphTO3U7JeYiBwfa7IYVG1qDOOWiFwl2k=;
  b=PEtFThCWgN/EDjtiujBMGjw4uMiL+KOFJ5rCUb1OB+HrYjAAyvoBJAB+
   AcsgOIiLFsL6FP3py1+yBuvUTIvwngxcN2j5Pz7YEf4iu26P5qD12fmtn
   ogz8hBT/LwePpmBn3kO2FxbfT7Sd7IBqIztzbQYIN2McP4oi69cb0JBbJ
   F+JHRWKmVDpUXtcDotvEx1lWTiv53Jydy7IhDDErRWm8YGoiBXlx+Cini
   n28B42majAET9KGjgHoGTrpCnTCRYoVxe5TlDjV3/myFgZ7iXQWjyE2Qe
   KEBQ9Q2XGyizXfS6ZkbRlqQ40jkJFbtwfEqcAP6IphJ/Q30UVgaNTsysy
   w==;
X-CSE-ConnectionGUID: Z2PQcOEARHCoHqpQ9E0UCg==
X-CSE-MsgGUID: 1nX+M3D/S1y4bHZejVgG0Q==
X-IronPort-AV: E=Sophos;i="6.07,242,1708412400"; 
   d="scan'208";a="190592283"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Apr 2024 04:30:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 04:30:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 04:30:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuisAInQNWIOrJ1qhPplBCaC61pYVXI2MmM6eol8eYS/fExpK+GC5Qp/sllefiyZAZ9uhT+ujr64ObTmx5L7KT/s3fvgeFQW5ean2Rj8/b+haTVXtnWNMxegozKB2RhWLRo8fwHv/0b2TfI3H3buHomsfds254HrAmKlIq7jpV/6HFlXF/Bz/WqdsS582Z/1Yj8goCZRrQioXOSt/QW3TySWxpTwHeG37JBJJ27D2ggovAc5ssMEpi0LNHem4ObCRtyyAqT9yfEovCp6eA6/PGcO6vMn6Lbl/SIWid0t88h4+3zMKUkYJE/sWMC9XjPYFrBoD3ALnNINo9wiWdFSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8FIiGNH1ycphTO3U7JeYiBwfa7IYVG1qDOOWiFwl2k=;
 b=kn8xeLBdmmc5SKsnmxn4Trv9kFEii18NLz2F25Eq4MSYy3OTZQe5zrQMJY9ggXdG4PYayASAHVadmk+VFi//osqpfatS7b7SWmKU6qSY76oMMNTaKgLO0KAMiX8UoVvvQ0wD9bT9aS/Jf+R5NFpdwF7utvaZCLHhT08JNQMTRPa1SbTvgNiwJ9rjQuxKLDG7M6AGnBDb3o6jNzgODrOPpH8W6o13eByzDyrPyHDW26J2UsrRnj1dWlZJWEJ3MSNHnNs/MKr5/P//07SR0HjocptaD2NA8w8YzfKLnDSR3ynMFKHMAf17EqfnbL5hCKip2zmhW1+x8lG+ghNZ98If+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8FIiGNH1ycphTO3U7JeYiBwfa7IYVG1qDOOWiFwl2k=;
 b=r2DvVqfwymwtAxAfXqdnP6z1+WZft1uQ2U2meFkYmMM1zbP1e0i+tmkIpEbGOjKdn7U44mY9xPpPhgwJjVBy0cvXVbp7RAu+VZYGX0YM8pzd+BZKwDLuHiSFwDBYkOaHUjxaJoGKhU3960sjZ678/6+aHwyKjEwyMrciZHjJBvsOld1xd02ZTA97wUjlJyEiwcOqH9HJuE13r78RRtNyeK913hZHy5FTD7aRWrVaZ1O2J33uyCcU4qfM1RZumddr91oJrowfJc4VZEYrt0Kv5+yButjmFcu1pWkRGAM8kEXPQ6H1M25fzgA9iyMwgr9a6sdEFLUCzB9qsngQa7k8HA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CO1PR11MB5137.namprd11.prod.outlook.com (2603:10b6:303:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 11:30:10 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 11:30:10 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 01/12] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Thread-Topic: [PATCH net-next v4 01/12] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Thread-Index: AQHakY/6sQRIWqa8eEy+60OQ1lk9aLF/fkYAgAFCCwA=
Date: Tue, 30 Apr 2024 11:30:10 +0000
Message-ID: <8164fe59-dde6-41b3-8e9d-8e050d1c7109@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-2-Parthiban.Veerasooran@microchip.com>
 <20240429161716.GZ516117@kernel.org>
In-Reply-To: <20240429161716.GZ516117@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CO1PR11MB5137:EE_
x-ms-office365-filtering-correlation-id: cbebb434-c709-4938-c8d9-08dc6908e4e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VlFqRThQMityYTRSdHZIZ0pKS2tuY3NFdlhrNGRWK3hVZmdnRXRvYVVodjhH?=
 =?utf-8?B?NWdGVGUvRUtTVnNCQnNMNzQ2Nlg3ZUs4VERyWjY3aHhlbUx3ZUs5aTRlM0NK?=
 =?utf-8?B?VDhBc29MWThNbWw0OG9YazMweVdQNkVneElHNVFVU2FJTWlnMGtybHBhMTh4?=
 =?utf-8?B?d3Q3d0EyTnRlaDV1QXZRM0l6WUpxTFBNalhkVGxpckdHTW5odXJOdXROTjBk?=
 =?utf-8?B?eG52TWdiUmtTWnFPVXZWTHNBWXhUUHR0VHpVT2FOMHpvdTFsK0U3VytlYUdn?=
 =?utf-8?B?S2JwVjZHZkVLdDRPZW1CcWVOeVpnNmFjZjlDbUg0bklQSjkxdHFKS240YkQ0?=
 =?utf-8?B?WkNOWUI4TkJJeUlqTllYOElmay96RG5MN2ZzUnZKaXFaWnUzblRCdmhMdlpR?=
 =?utf-8?B?a3dNR2dRaEYrQ04yYUNBWmhhSGxtTy9XaVZyVVlKdlp6VnFlMGV1L2xIVlNi?=
 =?utf-8?B?ek5sODdCVXhMS2JOWm5LZHVaR0h6VmtCWW9Wei9GTWlBV0VjbkNmVjdzU01m?=
 =?utf-8?B?VldDYnVDUE5pTUR0N2JncTA1d3ZseGlJRmlxSHdEY0RvcE5oL2R0cEVjVk9m?=
 =?utf-8?B?MVlHbERtSGpGWXVRTmJHQ0F5TzNyb3BJanJ1aVdhN2UzeHdrd2VmU2dvMytU?=
 =?utf-8?B?am1lYTZZcSs0K0FId1FrQnA2bExuVlFjU21ZN0FCT2NlS2VReEVxUzVXRm1U?=
 =?utf-8?B?TFNsdVR1cmtkR3pGRkg0ZDBFbXVNTmUyMlluMlduUGZLSzN3L3J2MytMTkdP?=
 =?utf-8?B?M2FlQlZMY043bENtWDBIenJaVTJIcW94ZGd6WkRlT09QUVRmL2pkbHgxUnBa?=
 =?utf-8?B?VzVkMzVrellZV0dXM0NmN3BnNFVBWmRwdlhRTjdqU2xvVFNCQjl1TlA5M1la?=
 =?utf-8?B?TGRzT2IwZ29DbVFXL0VHQmx0MkM0R0pSd3VvdUFHS2JFOTBGd1dmbFF5Zm1X?=
 =?utf-8?B?QUFJN1V6dWEvUktsL2JvRTViWTZUYVYyL2RCTmU1UW1DaFN3TUNJc3U2aFRU?=
 =?utf-8?B?b2xaQ0t4S292WG9pVlpVeUVwUnZxdkduMXNwSW5FdFFDZG5lYlExakVGM0JW?=
 =?utf-8?B?SGNwZFdLTUt4dzNnS3dTdHFYaDk2Wk5oMUVrOTY4NkkxRzI2SzVIZHlDb21C?=
 =?utf-8?B?em9jTkthcVJRU2FmTlduNlNIYm1wNWt0L3RmdnZjd0g0Z2QzVHord05MT1Mx?=
 =?utf-8?B?Vk83TC95T0hrRXM0RGNIOHQ2WWNyT0xJRlZwZms4M0dkNUdxSEJkVThweXd2?=
 =?utf-8?B?bTRPQi9IeWhOYkR5L0s5NmEzU0tMNmF4Mk9IL3ZmNlYxN0dpSTIzNHdjK0ZX?=
 =?utf-8?B?ZFVSdWgzUE8yckk1TGpRTDc2dTJLNWRSaFF6bk9pQUJXZm1PVU1IWGVVSW5I?=
 =?utf-8?B?RmVYY1NGUUw2QnN0WHIyR09QMFRZOHhBS2Jkd1NGamlxS2xPNWJGeVVJSUxB?=
 =?utf-8?B?RGxEOHVtZGZaV0VnS253NDFhNjZQQUdBdkJFK2pvRjdhazRaV2tKVkRRcUYr?=
 =?utf-8?B?ellOdTlRZkh1cGFqSXU0NWVGVzg0cml3WlYvMi9IZExkUi91WUw3NWVPQWRU?=
 =?utf-8?B?VTQ5N2ZLSmpLS1VEVUU5NHdCeUVGZisxemowNEZqVnlFYnJQREpmemFEbEhR?=
 =?utf-8?B?YXEzRmtiSzhjSEJmVXBFeUk1MHdtR3JMNFRUdWlyVzFxSEhyL0VtWVRyL1ow?=
 =?utf-8?B?cjErVmpYcmlveENydDlma2dZMGxHNlYybGFpU2hXdU5EUnQ2WEErNGR3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejJ3TlpzNXVvOFBLQ3FwZUFSOFhEV00xT3RmbnVpdXl6TExOelo2WmJjVkRH?=
 =?utf-8?B?RU1GNGRHd09mcTJMb2MyRDlreWtQM1RiWVB5bll4MjhVWXRka3hvaHNMZm9i?=
 =?utf-8?B?bk4wWVJkMnlwT2F6UGRnenJtYU5BcEdaeXJjZk83bmt0STZ4aFNhMVBtbm9D?=
 =?utf-8?B?enBEVEU2aG9uQmxZN01tdUp2cWJteTJSSG5tSENOQldmcnBxNC9jMmpPRWla?=
 =?utf-8?B?aEhOVHR3d210MWJzUitsdU9lYkJvOFJWcHJ3R2tsN3JSTEthL2U3aXFaYWtH?=
 =?utf-8?B?b0U5NnV3WDhNMkxNVUxJUzZyMWlPbVZtbCtVVDVMV0NZM2dNY05WRTkrbEN4?=
 =?utf-8?B?OUo0amFYM21jS3h2dW10RFJ6TFZIenZHYVVMQkZicDF4Zk5xTUdYUzJFTlA5?=
 =?utf-8?B?ZWhSTnRydlVScjdCTVZHUS9aUGxpdXk4Z0pKVjVxbUd4VDRXT2hrVW9zcWhM?=
 =?utf-8?B?SGdNZUs2eXVqTTVUaFhrcjNPQ2twL1c4a1Jac0ZlRkFFZ01EK3lGU0tXVXk5?=
 =?utf-8?B?TUFCMTd2dkRhWjN6N1pETzFReEZGdjZONHhaWUNIeUJqUWs5N2xWdmt6alFr?=
 =?utf-8?B?ak1OKzI2TFBhSnladWx1TzBEakhNMW53YlgyZjZkWC9ZbW9uaU9aeGxTV2x0?=
 =?utf-8?B?dFhjWUVYanNzNFN6bk5mOWRvbHhyNmQ4emZvYVg2R1BTdC9rY2o1R1FnWnhv?=
 =?utf-8?B?Mkd3cTVZb0d0UU93amhXLzNhZ2FjWmxRUHE1NFN6TUtVMnZzZUZUYWc1VFdy?=
 =?utf-8?B?MUZ3MTdsTWJPQU4waUREZWxSeHBGdVRrWEdQZmVMNzRIZHRYcm9NUmJkMzhp?=
 =?utf-8?B?TUxOMVAySUEvN1hZSEgyME9KV0U5c0RYc2E2L3phU0J5dDhGS2tmTHFKeHdY?=
 =?utf-8?B?MWZPWkpPY3NSUWIyenhha1ZscnpvcWk3VldvcVNXcmJCUXRWbHp0Rzg0R0lY?=
 =?utf-8?B?M3lxdzNNUW0xbUpkUGhITGJkUU5xSXBMaXB1ejFpN3lqWjd3RHMrN2d6MXZC?=
 =?utf-8?B?aHpkdzNzV3JhRXYxTXdkNFBkcGNKVmpFdWx6WDZya2wxWFlqSVpTNlVEd0JC?=
 =?utf-8?B?UkRDb29vOUVYT0dPMEl2Y2JXay92NUIvVFptSnZqbmFQVi91UjgzMGgyb3pQ?=
 =?utf-8?B?Q01PZi9XY2hHSnhqNGgwbDRvM1IvNWdCMjJQRE9RZHlPVzBEZVdiSWVSelVE?=
 =?utf-8?B?TUJHbUQxcEpCWUNGOWpudVY5bVNNcHV3Y3lWVnB3ZUJsMDZuZFRmb3h2d244?=
 =?utf-8?B?SkE2MkZ3bEd2VWl1TlZkT2hhYWNBaHpUN2tQSHF2K2FweERzQ2tzbWlTVUx6?=
 =?utf-8?B?RjlVTEUzWUZoeFRnd0diSjZkZVVyUDlFODl1RVhPSmR6Y0RsMENVWVFwSnFC?=
 =?utf-8?B?cmJ2RHNwWFNyVFJVNldlR2xpMzJVc3kyY1NyOGQwRDhmMkMxZEdkd2N6RUVK?=
 =?utf-8?B?RE14YzZrS0xzR0h2WUh2cXBSbGFjVGtlbmtEaElaem1BZC82N1k2N3A4Qzh2?=
 =?utf-8?B?YmZLdXBEdzNtandqeVFLcVFCb2FvRk51OUtFU1IzMjVQUFd4Mi9XVE1oSWJP?=
 =?utf-8?B?UTNJRC9qR0Z0WnI1Z2FSRW1ZNmovcEhBTnJWM1Y5aGhWbTBjQnBDaHNsNlky?=
 =?utf-8?B?UjJqY1VmNVA0WGNVQ2dUVGRtV3hBR3Z3cDJ4OVN4ZWRRWXpBQ0xrNnpVZGp2?=
 =?utf-8?B?UXppdGF0M2JLaTdYcjErRUZlb1JwRHZxQUVTVFJPOFBSRTBXYzZTby9CeDZj?=
 =?utf-8?B?bjRlMHVkSldxT1Z1N3RoWEhLRkJ6UnlLUzRiRE9TWGVrTWVDbGtNV3pRak01?=
 =?utf-8?B?REhoVm1JbTBhNUlOcERvamdvR2RHLzZoYmgyaU8zY0RyVnBQOU9QWHVaNUFv?=
 =?utf-8?B?dTlobi9LajRuZnB1LzBkM1N4Q3p1UkxmeWFBVGlCNDBPZTVIMzdYUGZldWM5?=
 =?utf-8?B?RDBwQ3RTNmNaR1lvMXJWQWliSGpYblRDc0hLbU1uWURYVmNsSzNjbEJVeUxI?=
 =?utf-8?B?dyt3cGg4MnV4SUpqSlRGcndIS2d5Q1dta3o4azRxbVlQK2g3THZrdVZtYW0y?=
 =?utf-8?B?ZFRXK2ZjUVppbEZ3bko3VFAwVlBRVjVkRnFEeVRvdHBoNzJBN3RhSkxGVVJH?=
 =?utf-8?B?ZGpCQU04QlUxOVV2MHVmTXFqMEljVDVJVCsvYjBuYnREUFh2NWdFcDhwSUdO?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AB5E0D7F2C92B419F1AC59738221CA9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbebb434-c709-4938-c8d9-08dc6908e4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 11:30:10.0511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBlkl6IXeM5nQZCaVJT05G0x1O0bM6sdSfOagHhX/0mFnLCcmYnPCJASFPHSusCTNHiU8N/DisA9SkgqR3tnwL/czeUa4psvx0lId5cPLTp6zDgvIRS+5F/E3r6clluA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137

SGkgU2ltb24sDQoNCk9uIDI5LzA0LzI0IDk6NDcgcG0sIFNpbW9uIEhvcm1hbiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIEFwciAxOCwg
MjAyNCBhdCAwNjoyNjozN1BNICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+
PiBUaGUgSUVFRSA4MDIuM2NnIHByb2plY3QgZGVmaW5lcyB0d28gMTAgTWJpdC9zIFBIWXMgb3Bl
cmF0aW5nIG92ZXIgYQ0KPj4gc2luZ2xlIHBhaXIgb2YgY29uZHVjdG9ycy4gVGhlIDEwQkFTRS1U
MUwgKENsYXVzZSAxNDYpIGlzIGEgbG9uZyByZWFjaA0KPj4gUEhZIHN1cHBvcnRpbmcgZnVsbCBk
dXBsZXggcG9pbnQtdG8tcG9pbnQgb3BlcmF0aW9uIG92ZXIgMSBrbSBvZiBzaW5nbGUNCj4+IGJh
bGFuY2VkIHBhaXIgb2YgY29uZHVjdG9ycy4gVGhlIDEwQkFTRS1UMVMgKENsYXVzZSAxNDcpIGlz
IGEgc2hvcnQgcmVhY2gNCj4+IFBIWSBzdXBwb3J0aW5nIGZ1bGwgLyBoYWxmIGR1cGxleCBwb2lu
dC10by1wb2ludCBvcGVyYXRpb24gb3ZlciAxNSBtIG9mDQo+PiBzaW5nbGUgYmFsYW5jZWQgcGFp
ciBvZiBjb25kdWN0b3JzLCBvciBoYWxmIGR1cGxleCBtdWx0aWRyb3AgYnVzDQo+PiBvcGVyYXRp
b24gb3ZlciAyNSBtIG9mIHNpbmdsZSBiYWxhbmNlZCBwYWlyIG9mIGNvbmR1Y3RvcnMuDQo+Pg0K
Pj4gRnVydGhlcm1vcmUsIHRoZSBJRUVFIDgwMi4zY2cgcHJvamVjdCBkZWZpbmVzIHRoZSBuZXcg
UGh5c2ljYWwgTGF5ZXINCj4+IENvbGxpc2lvbiBBdm9pZGFuY2UgKFBMQ0EpIFJlY29uY2lsaWF0
aW9uIFN1YmxheWVyIChDbGF1c2UgMTQ4KSBtZWFudCB0bw0KPj4gcHJvdmlkZSBpbXByb3ZlZCBk
ZXRlcm1pbmlzbSB0byB0aGUgQ1NNQS9DRCBtZWRpYSBhY2Nlc3MgbWV0aG9kLiBQTENBDQo+PiB3
b3JrcyBpbiBjb25qdW5jdGlvbiB3aXRoIHRoZSAxMEJBU0UtVDFTIFBIWSBvcGVyYXRpbmcgaW4g
bXVsdGlkcm9wIG1vZGUuDQo+Pg0KPj4gVGhlIGFmb3JlbWVudGlvbmVkIFBIWXMgYXJlIGludGVu
ZGVkIHRvIGNvdmVyIHRoZSBsb3ctc3BlZWQgLyBsb3ctY29zdA0KPj4gYXBwbGljYXRpb25zIGlu
IGluZHVzdHJpYWwgYW5kIGF1dG9tb3RpdmUgZW52aXJvbm1lbnQuIFRoZSBsYXJnZSBudW1iZXIN
Cj4+IG9mIHBpbnMgKDE2KSByZXF1aXJlZCBieSB0aGUgTUlJIGludGVyZmFjZSwgd2hpY2ggaXMg
c3BlY2lmaWVkIGJ5IHRoZQ0KPj4gSUVFRSA4MDIuMyBpbiBDbGF1c2UgMjIsIGlzIG9uZSBvZiB0
aGUgbWFqb3IgY29zdCBmYWN0b3JzIHRoYXQgbmVlZCB0byBiZQ0KPj4gYWRkcmVzc2VkIHRvIGZ1
bGZpbCB0aGlzIG9iamVjdGl2ZS4NCj4+DQo+PiBUaGUgTUFDLVBIWSBzb2x1dGlvbiBpbnRlZ3Jh
dGVzIGFuIElFRUUgQ2xhdXNlIDQgTUFDIGFuZCBhIDEwQkFTRS1UMXggUEhZDQo+PiBleHBvc2lu
ZyBhIGxvdyBwaW4gY291bnQgU2VyaWFsIFBlcmlwaGVyYWwgSW50ZXJmYWNlIChTUEkpIHRvIHRo
ZSBob3N0DQo+PiBtaWNyb2NvbnRyb2xsZXIuIFRoaXMgYWxzbyBlbmFibGVzIHRoZSBhZGRpdGlv
biBvZiBFdGhlcm5ldCBmdW5jdGlvbmFsaXR5DQo+PiB0byBleGlzdGluZyBsb3ctZW5kIG1pY3Jv
Y29udHJvbGxlcnMgd2hpY2ggZG8gbm90IGludGVncmF0ZSBhIE1BQw0KPj4gY29udHJvbGxlci4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXJ0aGliYW4gVmVlcmFzb29yYW4gPFBhcnRoaWJhbi5W
ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPiANCj4gSGkgUGFydGhpYmFuLA0KPiANCj4gU29t
ZSBtaW5vciBmZWVkYmFjayBmcm9tIG15IHNpZGUuDQo+IA0KPj4gLS0tDQo+PiAgIERvY3VtZW50
YXRpb24vbmV0d29ya2luZy9vYS10YzYtZnJhbWV3b3JrLnJzdCB8IDQ5MSArKysrKysrKysrKysr
KysrKysNCj4gDQo+IFBsZWFzZSBhZGQgb2EtdGM2LWZyYW1ld29yayB0bw0KPiANCj4gRmxhZ2dl
ZCBieTogbWFrZSBTUEhJTlhESVJTPSJuZXR3b3JraW5nIiBodG1sZG9jcw0KT0suIFRoYW5rcyBm
b3IgcG9pbnRpbmcgdGhpcy4gV2lsbCBjb3JyZWN0IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQo+
IA0KPj4gICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDYgKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDQ5NyBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvb2EtdGM2LWZyYW1ld29yay5y
c3QNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL29hLXRjNi1m
cmFtZXdvcmsucnN0IGIvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL29hLXRjNi1mcmFtZXdvcmsu
cnN0DQo+IA0KPiAuLi4NCj4gDQo+PiArRGV2aWNlIGRyaXZlcnMgQVBJDQo+PiArPT09PT09PT09
PT09PT09PT09DQo+PiArDQo+PiArVGhlIGluY2x1ZGUvbGludXgvb2FfdGM2LmggZGVmaW5lcyB0
aGUgZm9sbG93aW5nIGZ1bmN0aW9uczoNCj4+ICsNCj4+ICsuLiBjOmZ1bmN0aW9uOjogc3RydWN0
IG9hX3RjNiAqb2FfdGM2X2luaXQoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG5ldF9kZXZpY2UgKm5l
dGRldikNCj4gDQo+IEkgdGhpbmsgdGhhdCB5b3UgbmVlZCB0byB1c2UgYSAnXCcgdG8gZXNjYXBl
IG5ld2xpbmVzDQo+IGZvciBhIGZvciBhIG11bHRpLWxpbmUgYzpmdW5jdGlvbi4NCj4gDQo+IGUu
Zy4NCj4gLi4gYzpmdW5jdGlvbjo6IHN0cnVjdCBvYV90YzYgKm9hX3RjNl9pbml0KHN0cnVjdCBz
cGlfZGV2aWNlICpzcGksIFwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2KQ0KPiANCj4gTGluazogaHR0cHM6Ly93
d3cuc3BoaW54LWRvYy5vcmcvZW4vbWFzdGVyL3VzYWdlL2RvbWFpbnMvaW5kZXguaHRtbA0KPiAN
Cj4gRmxhZ2dlZCBieSBtYWtlIFNQSElOWERJUlM9Im5ldHdvcmtpbmciIGh0bWxkb2NzDQo+IHdo
ZW4gdXNpbmcgU3BoaW54IDcuMi42DQpZZXMgbm90ZWQuIFdpbGwgY29ycmVjdCBpdCBpbiB0aGUg
bmV4dCB2ZXJzaW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4+ICsNCj4+
ICtJbml0aWFsaXplIE9BIFRDNiBsaWIuDQo+PiArDQo+PiArLi4gYzpmdW5jdGlvbjo6IHZvaWQg
b2FfdGM2X2V4aXQoc3RydWN0IG9hX3RjNiAqdGM2KQ0KPj4gKw0KPj4gK0ZyZWUgYWxsb2NhdGVk
IE9BIFRDNiBsaWIuDQo+PiArDQo+PiArLi4gYzpmdW5jdGlvbjo6IGludCBvYV90YzZfd3JpdGVf
cmVnaXN0ZXIoc3RydWN0IG9hX3RjNiAqdGM2LCB1MzIgYWRkcmVzcywNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgdmFsdWUpDQo+PiArDQo+PiArV3Jp
dGUgYSBzaW5nbGUgcmVnaXN0ZXIgaW4gdGhlIE1BQy1QSFkuDQo+PiArDQo+PiArLi4gYzpmdW5j
dGlvbjo6IGludCBvYV90YzZfd3JpdGVfcmVnaXN0ZXJzKHN0cnVjdCBvYV90YzYgKnRjNiwgdTMy
IGFkZHJlc3MsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHUzMiB2YWx1ZVtdLCB1OCBsZW5ndGgpDQo+PiArDQo+PiArV3JpdGluZyBtdWx0aXBsZSBjb25z
ZWN1dGl2ZSByZWdpc3RlcnMgc3RhcnRpbmcgZnJvbSBAYWRkcmVzcyBpbiB0aGUgTUFDLVBIWS4N
Cj4+ICtNYXhpbXVtIG9mIDEyOCBjb25zZWN1dGl2ZSByZWdpc3RlcnMgY2FuIGJlIHdyaXR0ZW4g
c3RhcnRpbmcgYXQgQGFkZHJlc3MuDQo+PiArDQo+PiArLi4gYzpmdW5jdGlvbjo6IGludCBvYV90
YzZfcmVhZF9yZWdpc3RlcihzdHJ1Y3Qgb2FfdGM2ICp0YzYsIHUzMiBhZGRyZXNzLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTMyICp2YWx1ZSkNCj4+ICsN
Cj4+ICtSZWFkIGEgc2luZ2xlIHJlZ2lzdGVyIGluIHRoZSBNQUMtUEhZLg0KPj4gKw0KPj4gKy4u
IGM6ZnVuY3Rpb246OiBpbnQgb2FfdGM2X3JlYWRfcmVnaXN0ZXJzKHN0cnVjdCBvYV90YzYgKnRj
NiwgdTMyIGFkZHJlc3MsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdTMyIHZhbHVlW10sIHU4IGxlbmd0aCkNCj4+ICsNCj4+ICtSZWFkaW5nIG11bHRpcGxl
IGNvbnNlY3V0aXZlIHJlZ2lzdGVycyBzdGFydGluZyBmcm9tIEBhZGRyZXNzIGluIHRoZSBNQUMt
UEhZLg0KPj4gK01heGltdW0gb2YgMTI4IGNvbnNlY3V0aXZlIHJlZ2lzdGVycyBjYW4gYmUgcmVh
ZCBzdGFydGluZyBhdCBAYWRkcmVzcy4NCj4+ICsNCj4+ICsuLiBjOmZ1bmN0aW9uOjogbmV0ZGV2
X3R4X3Qgb2FfdGM2X3N0YXJ0X3htaXQoc3RydWN0IG9hX3RjNiAqdGM2LA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2ti
KTsNCj4+ICsNCj4+ICtUaGUgdHJhbnNtaXQgRXRoZXJuZXQgZnJhbWUgaW4gdGhlIHNrYiBpcyBv
ciBnb2luZyB0byBiZSB0cmFuc21pdHRlZCB0aHJvdWdoDQo+PiArdGhlIE1BQy1QSFkuDQo+IA0K
PiAuLi4NCg0K

