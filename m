Return-Path: <linux-kernel+bounces-116617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB0B88A12B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2844D2C5644
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F297F176550;
	Mon, 25 Mar 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f0JJogjg";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZDa8Lzq0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11463182EED;
	Mon, 25 Mar 2024 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350808; cv=fail; b=dQ33Ubh+AOLJAnvIe3YANXPp8rMd7cyJZqWbeaUFpIHL80xmcw+7IrTwBIJlvtQ0YNShEuGH4MQubM5yaC9fCOoosDtxbOwsPIwurv12WimAifpV5MBgcEj3MhZ+gWq5Zakafwv8e9j8k6TT0Egi1CjKNiUKpDqIbUmmD+qjux8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350808; c=relaxed/simple;
	bh=56dvhioLz5UiX3Si287LxnrTY3RbQx4QYFvSv8jgjEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QQSjAKE2dsxKKDUmRg3kyNmqzJ/kCwBV+6g7kinDzzbGTXgbujS7/dDTVjHWAE0t3gCMwrT6xYSsKgXpsMdSFMmV+zAJNXN5FxOOUNE965tui3W0aUFgxq8Y5KMedJywFnjh/GjB18Dozpf9S2gBZUAVWbGDbX53U+ZyCmHqW/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f0JJogjg; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZDa8Lzq0; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711350806; x=1742886806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=56dvhioLz5UiX3Si287LxnrTY3RbQx4QYFvSv8jgjEU=;
  b=f0JJogjg14Ut0MSypWamnEqq0uqAiPvwAN53tPRU09NF+JWriF9H8gBK
   VJ3FTGCuxf/+KmdmrwDkdri//4x8MQRmTUxYwkiet4cpeLtCzBIIYMEro
   BV98KiqT3dbt52SCS7fEO/jrRWNt+AwVe7hHmBLmXiBOhMhu3o9F1FG2K
   01WzSkhqtpmVTKoKPTOGm2eHy3lKH1CNY38o8P56nosioorY99RrnWcCN
   y8bZfUCrUuFKhSRebsTnNKcGQ5hhIE1I61H/gF34KmNBf3nOkcb/ZKylD
   27oYGo4RVyDSvY37dZNqyh0qjG53X9cB9A3YVA26TH9uGRvLNH2A+nu5V
   Q==;
X-CSE-ConnectionGUID: dD/w9ZYcRq2VY1Ypojt4EQ==
X-CSE-MsgGUID: 4U5jA34vSy+aHOGLTEwZfw==
X-IronPort-AV: E=Sophos;i="6.07,152,1708412400"; 
   d="scan'208";a="18067959"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2024 00:13:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 00:12:51 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 00:12:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6BU96MuUmVQbKTXrwlktzOh/01qAFg6MrWYSyKmaYT3DoqYMHkz71Pp2NeIBPCypvg/E1Oql5JhuQunjSzJh8mAgTlh9Yp9t3YNu43m3bH6sEFzEdkUmqrKoxQooHO9pzNtAaxyTCaHm6nJri46y97lIV7+NBYtGZZrsAhTl0Hq8bYMkDO7swZxGXw1WkBSJ2MzDr2tqW2v9blvZlJ7L/TEGg4SIjp3Mx0ciE+4L2RCvxQbwByR9xxXReDywRYkb9Vf47B0o/WtAZTn9ice+0e92FrRkFVUzsVeRbA+mV71G/7UJZeJmmkxY/erPOz4vxyzZN4Ujh/AngMrdSksCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56dvhioLz5UiX3Si287LxnrTY3RbQx4QYFvSv8jgjEU=;
 b=GxA/8NbHf0jMJyqXukn/fJzeY42Wuo0ed+fZigmGMm9sxann5z0+GUjm0FZm1fCS7HDzD7djqkE6JqU3nlsC0O9Xxcxl0vXKHXbo74IymXgjyVJFYFm1P8VHDxRDy5y383dQ72u3DStgj2rPeA06fLUaMOsSLPxjjszyqXBMJSKIs4HEGWyziaSUVmzIAs4N6b1Y7NzJKT75dNka8wqjwax6tyKmBzS2aRWa4ExRy2XkQX4l1NB6UHY2qVedvrfhzVy+hiSPpQ9HwfcD4mqmmwr+1YHn2MIFS1OjzKZxaob7ww7yyQlrLj75yhW5wp2iPIRUOtv5ILUHy2I7EH9ojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56dvhioLz5UiX3Si287LxnrTY3RbQx4QYFvSv8jgjEU=;
 b=ZDa8Lzq0D/W5putvLts6k8okKVsE6W/5ppK3xT2+xJmUMm9hQXzkZgJdsrZoE4pMMitror0z9E3mKUv/C6fNO5f90GjoCkThrOnZjpXEbXJhk511xzZPJER7xlviG60KrhXUWcIKF9dODywbRLOhvdNOF0nZfr5e8oXMd4sCdXVJ9jTnT5NDJvbjyLRkPWh+JlJ5c/eIcR9t8gGJrVHBk53CavdlM7nRLSiEPZef2yRVl8tjxpBcLFwoOljIGjWDz2zJ1/XLhzPADUXdC8RwEQhr8tLe8QIBDPYkgM+t3A2RN5KAFHyc8BT7+DI01oaCVOnIO0S5Lrv9ZvpmLarUDw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CY5PR11MB6185.namprd11.prod.outlook.com (2603:10b6:930:27::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Mon, 25 Mar
 2024 07:12:49 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Mon, 25 Mar 2024
 07:12:49 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <conor@kernel.org>
CC: <krzysztof.kozlowski@linaro.org>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHab6Ox6ghenOTJpkWNbGLTwd03cbErBYYAgAAJFoCAAANkgIAVU1wAgAAUTICAAX1RAIAAAHgAgAA4LwCAADuQgIAA+O2AgADEZACAA//4gA==
Date: Mon, 25 Mar 2024 07:12:49 +0000
Message-ID: <8fc993af-7803-46e7-aed6-318ff398bbd4@microchip.com>
References: <20240306-spree-islamist-957acf0ee368@spud>
 <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>
 <20240306-ripeness-dimple-e360a031ccde@spud>
 <05a9a7ee-e4f0-443e-9c8a-8ee649a11448@microchip.com>
 <2f384a54-74a0-4a75-a325-8985257b5d66@linaro.org>
 <ba37c212-fb98-407d-9bee-6d14801754d9@microchip.com>
 <96493beb-afbf-42f2-88f0-ad645422ecdb@linaro.org>
 <1735add6-4a6a-452b-bf26-1cf19c95493e@microchip.com>
 <20240321-upcountry-finless-b0e9b1ab4deb@spud>
 <13a28ba3-2da4-428c-8091-25e75c6c11e8@microchip.com>
 <20240322-bronzing-gangrene-486296d6117c@spud>
In-Reply-To: <20240322-bronzing-gangrene-486296d6117c@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CY5PR11MB6185:EE_
x-ms-office365-filtering-correlation-id: b97e5502-b584-420f-0511-08dc4c9afae4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f2riqvnFrDbFQwmLOJr4+j+PmJBP0/fx5k0rGRW98kJmf4RP4h5psk13ld8VXHVK+8csOPpVZuMKrG4K3dgc8ruiaEeD3haTgNJio/5k+uYsL1A2ASxn3QYLD9x6s+kGw30b2am2ZE5zFuic991QCz6GBxYE+ZBqVjzGmTb6fPlkMcgdFda3816yMJKZVfJb9t6Ip2vTQEPwI57la+9znjXpS4sMeFRP89BRyeU/V+QjERJfLT0cCu+jV25bXYb/WrhRcuknVg2ZPiSIfhqMoU/J4VQrTBm67vhIoNfNLkSjf1TVdE/LW8MasPb670St4WYOjYdEQ9UXEppR6DbNtAHlg28BtHVBiFxbg4ANevop02lQoWOvxykqpyjloqeYTYC71I94LgyYVHmI4uY38FWelRt9x/fC0o+WEjI5jzeYO81TR47jQXBK+jx3B97kFqSIb+I56F1xgEq6m+1ZrFlyMBQCPrr9kgfPJrmii4R6KxvD1Uekt/fER0b3NvmsWIv6KTjL1PtUtxekkUIkwVi5ruNtyeAQn0hxZt5zJUO4CYdPh3IhDltR0ZJWxQIt7VUnnb/Rb+FPGa0EYnOtFcGWh9QZWiP8mYUIdRxAv+3tT/VWF0UpPvVl3SQV+HgzHTvyUronplw/VPt74SLg7G5qMnnm6v3TjpAfJe6y/+wHsR8QYTjXZjAqm3ZWXEQM0PD4CA15gow9q8Z2LX84cQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG52YTJSK2Y0TFFOZnlIMEsyMGpVVEdHYnF2a1JoT01tODk0Ti9TOGY4dXVq?=
 =?utf-8?B?RlRhc0dqQncwdHlFOFMxY3pOUU50OEZIR1grYnFwWFBXT29LL0tIMG51Q0dZ?=
 =?utf-8?B?WE0rQjVPZnd2RHFZU1hRQTFINzBxbnNwekJpSVJnOTRqbjFKSW1HUFR2VzZI?=
 =?utf-8?B?VDlHVHhSUmJ0V2gvdFhCSVduRk9acHZtSjJYVnlTYy9zUWt6QTVuTlpoWStI?=
 =?utf-8?B?L2F6dklDblFZT3k0U3dpTE5ncnBYVERveVYwbTNMcG5oaTdha0ZIOHlVcE90?=
 =?utf-8?B?Yk5oa3ZjL2thZ1UzNnhyREhzU3VHc216N3JNYmFxRFJvajhJQ2VOSG1sNDlu?=
 =?utf-8?B?aDBvTWlUSmY0UkNxaEZUd21vZXlUNmZKMmF2TUNuQlJKNFYzdmg0Tld4aFF3?=
 =?utf-8?B?cmE4QlVXYkwrdjFCTjYvaXpHbVNuelRZN3VYd05wMUhmR2NGRFA0Y25NOEY3?=
 =?utf-8?B?TEt0cGJhZGhOa3c5MkprVlM1Ym9kK0dBWXdCQktrYVJabTh2b0gzcVhTQk4x?=
 =?utf-8?B?N3NGSVpDQlhHakN0K21GcjhIMGxGaHF3ckZvd3RLVmdmdXUxMXBiTG12Zkdo?=
 =?utf-8?B?Mkw4bWZDa2xsOTk0T1lJN29TTTF2WWFCNUQ3WW1QZENGVzlMOGJlYThZM3Fs?=
 =?utf-8?B?WEMyWmp5SDdza2VWcHFoUitMRzNQTCtod2k0aTcwa3ZEa1h3dUF6NkZyVDZv?=
 =?utf-8?B?ZVhoNnZJNXg2Y3UyZ0tHekZQZnNBWGZvMUlkM3M5RERtUDdBenpDbmVvVENS?=
 =?utf-8?B?TktPMmVhamptR3RnQmlwV1orQkxpL1ZWZDFXZlJBc2dkeVc1QmNpWlhlTHFa?=
 =?utf-8?B?ZDUvQURIaFNyTXVrZG9vRyt1ZStZWFQzSW9YelFkbzRZRjMvRTVTK3czeEhL?=
 =?utf-8?B?RVJja3gvc1VtTnRrNmVqMkhERUdrbkE4dlZxQUVDNDQvNGpyZmJTQ0prcjV2?=
 =?utf-8?B?QWRNNG1GUnZ4Q2ZnUjNyd3NXNzE4MDdUb01Rc2xHWms4Mm8xWVowOTdWQldS?=
 =?utf-8?B?ZGZTZStIb1dVV3BudzhRU0RBSGJuNlBrWWVZVHdCSE9QRjE1cnloZ3FSWm1h?=
 =?utf-8?B?SGwxWDVra2tjMVZqczB4azlIYWtIYkI2WkR2Y3B1UGxxRlFJdDh1MnNoRW9Q?=
 =?utf-8?B?TFF1Y1M5NWR2VDNxdTJKVFB4enh3T2xON1RGa2RpRkVONzZiZnMwVURsbnRi?=
 =?utf-8?B?ODR5ZFFteHlaTSthMzlsL29LQUFXSUoxVHY0d0hDaTBwbXl3MDM5aUZiaUF2?=
 =?utf-8?B?N1Q2ODJXYnRUQnBNMUszdDRkWC9mRGpUa2dhOHZCMWF3b2pDOTUxUkl5SGdl?=
 =?utf-8?B?VUw2VzhnWmszL1RNbWRld09CeWF1Tk1YZWIrSmxKR1B2MFVQaWJQQTJyQ3hs?=
 =?utf-8?B?elFzOVRCUTNrdW0yUXJvTEJIVjFGRHRHS0xRWC8wZGtUK1oxdDVYZ2JxVFYv?=
 =?utf-8?B?aHFrRzM4bDdGUjVFUWxWWldhOGg5SEFwZnZsVFZKRG05cWVBVnN2Nm5ydlRh?=
 =?utf-8?B?TG9qWmc1TDVuQWtrdEpQbWN4Mi9WeHh0bmlla1VtV2k5RTA1Wnd3M0xZTnBL?=
 =?utf-8?B?UzZtMmRPcDk3R29GWWxNTENodkprZmlnb3VrWkR6S3ZuZlZ6aEljTTljQVVl?=
 =?utf-8?B?bWlXOFM5SW9BdWRHQ0tzL2MzOEVUeFIyUjBVY3Zvd0tXLzdrbkJzZE9INXlN?=
 =?utf-8?B?MHpOUUxrU0ppYWZqT1RHUWhWbEV5TlVVQ25waTlHbUR0d2Z1OXVodDFBSG1F?=
 =?utf-8?B?VHFsY2txc2ZNOWFRTitDaG1QdnR5cEhZR0pSaU5IWThCbVNmQ2F3bXU5UExz?=
 =?utf-8?B?cW5VSnFWOVJUQ082RWNQYmtDd2U2bWdicG5uZVpHaU1JaVFXNGNKWFBEWmtG?=
 =?utf-8?B?NXFGNmQyczNPWGUyZ3JhRmlsTFlRRmNrMGhPdGRGV1VGcmpjUEVVclpGVUZD?=
 =?utf-8?B?Ni9uWEVGTGdXRWdhUzFIakpwb0VtRjkxZUYza1lLYWNOZ293bWo1Yjh2STJJ?=
 =?utf-8?B?MzI4MEUrZmJ5ci9oYWdISlB2K0RnRDNFN0tlT2RGQTVncVZKVE13RitlQkhX?=
 =?utf-8?B?QjJKK1E1OVdBRnRIQitZdk1saVpva0JYbTc4RlJ4M21tZzFabXhCN21BVmpL?=
 =?utf-8?B?M0lTYi82SGowb2JGL1BGRHVZekhXYUx0TjdpTWlsSVhsUlRHQkdkQlloTStx?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F116F37BB2A8E84FBC8EF9CB6AD51E8D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97e5502-b584-420f-0511-08dc4c9afae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 07:12:49.7509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4EydPmDOq/6SPjOuWD4vrLpNyAOqJkTJZpmBHAZNMjVxhbYeQMmNanix8sxk1LkWaP3LNu+iBBPM/JpM6FbbKThgGNqjmpAQtm8rbXVNwXBf20aDTtpqRJ3BckA68Ni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6185

SGkgQ29ub3IsDQoNCk9uIDIyLzAzLzI0IDExOjM4IHBtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIEZyaSwgTWFyIDIyLCAyMDI0IGF0IDA2OjI1OjAyQU0gKzAwMDAsUGFydGhpYmFuLlZlZXJh
c29vcmFuQG1pY3JvY2hpcC5jb20gIHdyb3RlOg0KPj4gQWggb2ssIG5vdyBJIHVuZGVyc3RhbmQg
dGhpcy4gVGhlbiBpdCBpcyBzdXBwb3NlZCB0byBiZSBsaWtlIGJlbG93LA0KPj4NCj4+IHByb3Bl
cnRpZXM6DQo+Pg0KPj4gICAgIGNvbXBhdGlibGU6DQo+Pg0KPj4gICAgICAgb25lT2Y6DQo+Pg0K
Pj4gICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbGFuODY1MA0KPj4NCj4+ICAgICAgICAgLSBp
dGVtczoNCj4+DQo+PiAgICAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbGFuODY1MQ0KPj4N
Cj4+ICAgICAgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxsYW44NjUwDQo+Pg0KPj4gRXhlY3V0
ZWQgZHRfYmluZGluZ19jaGVjayB3aXRoIHRoZSBhYm92ZSB1cGRhdGUgYW5kIGl0IHdhcyBzdWNj
ZXNzZnVsLg0KPj4gSG9wZSB0aGlzIGlzIE9LPw0KPiBUaGF0IGxvb2tzIGFib3V0IHdoYXQgSSB3
b3VsZCBleHBlY3QgdG8gc2VlLCB5ZXMuDQpPSywgdGhhbmtzIGZvciB0aGUgY29uZmlybWF0aW9u
LiBJIHdpbGwgdXBkYXRlIHRoaXMgY2hhbmdlIGluIHRoZSBuZXh0IA0KdmVyc2lvbi4NCg0KQmVz
dCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQoNCg==

