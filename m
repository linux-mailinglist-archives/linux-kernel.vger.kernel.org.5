Return-Path: <linux-kernel+bounces-161777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95D8B510F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649FC1F23D30
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C71111A3;
	Mon, 29 Apr 2024 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PdRMDedv";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jBVifHOp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199AF9DF;
	Mon, 29 Apr 2024 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371211; cv=fail; b=oc+RtxXF/kb/91AI6Hhycl0mCyl2U4vX96fhyG1evNaSzHx8C0KJ06eDm27LRoIrXJux4ZVFLoAyUfVKf7FyJxlKM844YpDVnlF3gju0rNF8R8blEYGz+H/X/AnAiJDmFWHS26pypmGmZJ047XanX34pTQxn+DmQci/J89iUcxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371211; c=relaxed/simple;
	bh=g3SbwPGDoqUZb1nHuuKKGVLPmcB/Wm+poD1vy1ZIGgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oh5GBREVY2b3Go4/PgZ2rN8s4gj1grywDlfYAsV/TSoT3GvYeyfRZw0DE7WuNEKruxl8rWiG7TSKp+gQNhTiXV707kSRBXfEMtQ2rPHiCozTQ1p8LlNvtEp0X5kMG1frEjuioyLwF5CmoLmFFbdeAGSnhN8sFtrnZGnglXlp7xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PdRMDedv; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jBVifHOp; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714371209; x=1745907209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g3SbwPGDoqUZb1nHuuKKGVLPmcB/Wm+poD1vy1ZIGgg=;
  b=PdRMDedvBImKzBh+UsGWa6qD9D4kwToVrHbcVTizJ8RRyXaIMiHkcFay
   IWoHgxA4LJcBo9lEaC0H9Lmnknki5y6LdAQ7ssOK+RqYQZu59JCcsmZRx
   zLBDid+7MY+8I65jpn8yP/Blota6N+995CL6YrQF4lpeX38pHeghc4GFQ
   U+1uZRtu+LkrbtxAQaXVkL4qXZJZNT4GeLNaWkPLMc8dlgKKcOhG2Yjmp
   ST6s6DxI/UOeN4zNzpp35P6AnDkWOUNNNw9y4ru/SACAtFooXMtIggO4N
   ok2mc8/tyr3dHbsKyQn2OPAArsiwMmn9QHW8YZGcyG9Zyd6rhMSgvi39p
   A==;
X-CSE-ConnectionGUID: B/Y+lmanRsCFurkl6s9Alg==
X-CSE-MsgGUID: 1bKfpCgSTkObUNGz7zP5Kg==
X-IronPort-AV: E=Sophos;i="6.07,238,1708412400"; 
   d="scan'208";a="25269930"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2024 23:13:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 23:13:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Apr 2024 23:13:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gITqcxvo8ex8acUl7+3u3NE0rmJpZSNs025lgFdZ+f7hIHr9VdKVni8VKEvD56f32aWN0O0J8qBz7jNpfAwAG14XL1USkxnTCpo1QYtFRbLvsb3Fhnu9Gw4EL4+/HHvlHp38Qa7XWr7aOsWcRPGutyECNmHBV42zbZ3qkQeAcen/xOouHqpyq6CNgrWuNhlveJxsbdnO5PdeAyqVz6RxIPdZIo5OGPTuoQ4uAlLm3cDRRIAK6apzeGEyTyeCyJuwyynUPUkKnBP9+7wE7AlLtWbVQ+DU6iL+L1FsVTwzM9FKUEf0DYMPG6IwORUZIobrWi89ikkBg9J1+DPIMfyfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3SbwPGDoqUZb1nHuuKKGVLPmcB/Wm+poD1vy1ZIGgg=;
 b=kEwAj9jhbte772TrFGAG2HuVvBxiH15c5GInBUFb9uKxopHNl3TAgBjfcCsAlN2E5Gc1YnbRr7gjjEhATXzUuVaCQX+kwv6DTIMs9X5QNegMss38sSR0yhByv7B4uADh1KN5vURCBHmLVfisA+7/2GfKUuVABLr8X71CaT3laYRwovyNRlyjke+XFM770QF6+49EGtMEX8eOTdIkovW0jOqUdJ7XIXLTKHsuTcuqvvXq8bKDPWQHGpswMBQESUjUJleFR0WMSW43DFAAgXrS06Snm0aphc5KzVqyaUP38ooC1ZLG1CziSyKfPcoiX1GlaVjOIZuZVL8quvMTDdyx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3SbwPGDoqUZb1nHuuKKGVLPmcB/Wm+poD1vy1ZIGgg=;
 b=jBVifHOpkhkQEF+pXPfzm+WznLEc7JJNUgiKk2V85FBQaf6UAqIgG9MG6sak/aaja3bl14JHamFJfrENANpAWYTB4y4+7lfBN1elXhASw5dXxpn3WJSyRBiFZfezL4KDe6b+p+Pcf59U+a1y6yJDKaH7g4COh+com5DAgCoqzOPr4n3x3vgTP31QIECnIZ7oH14u6Q2L0ut4upKXJm5lBO+2+hKG8SaknAYE6ZwNZmtpwpAAxWprqoKyPQcrJxDgrp8J+RjNHn6gyDVkQ6vmrA/mNHTvoa0mvc8WUDEqcxUtVf+clyFrsK7qi5E3TEt8/gNdt8MPtlVc1rvCFws2zw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:13:10 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:13:10 +0000
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
Subject: Re: [PATCH net-next v4 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Topic: [PATCH net-next v4 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Index: AQHakZAeMmJyUl87WkuqM6F297dNprF2k/SAgAQI+ACAAEraAIAD7dOA
Date: Mon, 29 Apr 2024 06:13:10 +0000
Message-ID: <8274f036-87a0-46de-8746-63b39cb6a6ec@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-10-Parthiban.Veerasooran@microchip.com>
 <574fec4d-5a23-490a-ba12-c40432ebe4b8@lunn.ch>
 <6e529720-3caa-4dc4-b9be-bc6674806ba5@microchip.com>
 <669541fd-abc5-4461-a92f-af5a09c1e1e6@lunn.ch>
In-Reply-To: <669541fd-abc5-4461-a92f-af5a09c1e1e6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH0PR11MB5901:EE_
x-ms-office365-filtering-correlation-id: 4ee1b80f-5fa8-465f-a48e-08dc681371d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MjVSQnpGdGV1S3NpcFhQTk1rWDVaazdvU1N1VTY1WFdyTWNtWXRDT3o2dFNs?=
 =?utf-8?B?UzIvMnNVYU9RdG1tSVkycW9rQ2FVR2tOeGRPSk4rVlNuTnR4ZjY5N3pJKzZl?=
 =?utf-8?B?YmpjSW5EcnBUQ1FuZXNNZmlnaHZ5UVorR1JaVDFyUERCc0FJcjVwU1NDYk5O?=
 =?utf-8?B?RHFDbDVOT1JBZ2tVeG5LNGZQMHNrWnhCK0pEU0hTWlpXenlKTnBsZDE3Rm5z?=
 =?utf-8?B?djJobW02SjgzNnpzZnBrYkt4bjJIOWJ5RlZOVkI4K0hma1RBeE42bnBlTXFn?=
 =?utf-8?B?NlVzbW9uWkIvZVdnZ0lNMFgrd2ZrenVwY2FCZngrMXp2UCsvT0M0VXg4RUhz?=
 =?utf-8?B?cCtzNEY2bEV1WExQQm1MNG5NR3BHbTBFd2xiTmkzNmY5Z0RsYUtVeTNweEI5?=
 =?utf-8?B?eVFsc0t6OUpLWW9qMTRqZWxDMTFMQ3ZlSDNQWkNLZXBtRlFlWCtvQ0k4MTUr?=
 =?utf-8?B?clcwMnVRQkg5aVFOenR6OHRRVjJTR2pQR3pkQ0wwS3NqWFVWRm1SWUNmcERZ?=
 =?utf-8?B?WG9uZi94UjVyeUIxRHZuK0ZGRGRRZUFweGpvRG80ZVgySXR3RkpLU0IyNFFK?=
 =?utf-8?B?bkpzbkVYaXkxYk5PandMVmVUUHFlUzc4aTZjQVVRdEd5Vi9JZzUvQnJpUmRD?=
 =?utf-8?B?WEZoUEt5aXp3MG9wOWRqdWI0QlRHRnNaQ2p4OXQxeDBQKzlqQTJGYWZYeXFW?=
 =?utf-8?B?akRYZHJMcTJZQ1ZlcjJ1TmY0aGZwWlMwOFEvWVBPaENwM28wVDJsYUJQcTRu?=
 =?utf-8?B?L0Y3K09vUEN1QlBoZitoM3RWdjdxTVFBQzJFYXdyWTF3L3JMOFhaTXhMM3ht?=
 =?utf-8?B?M282U1NpUU5HWjcyNmN1MjBaNFV1ZDBiQjVXWFhoVmpkNnRrRXFHZ2xGdk5H?=
 =?utf-8?B?L3ZseUpJVnVhWlZic2ZoeGZ5dkIzQk1hTzJObW1sTFpFMkh6clVJUlN1VTJT?=
 =?utf-8?B?bDhBd1ZPQWJPUEt0cmZwWG45TThtQmpoV1lSeHFTWmpvcTBEdkt3UkZMOWVN?=
 =?utf-8?B?Zmp3S1pDcTl6cFZ2d2NHcnN4SC9OMEdHRS9HTUNsZDdqSGZwZmtNUDRGeldL?=
 =?utf-8?B?czJTbWVGdm9iUGEzdThFcGxwSnhwbk9PZWhlcVlqWkM1NHozbWIvZmplVkZO?=
 =?utf-8?B?K3dob3ZHNzFxQXQ4cXpXejBQVEdFTy9UQ3BUY2FMMkVIN25XVXJwYk9QR3NM?=
 =?utf-8?B?OUd5cGl4dnpXcndQNVlVNkxzQll5WmdRT2ZlSWFiUFFzQ1NCOWR3MGIxeUEy?=
 =?utf-8?B?VUowUGh4MldhbXkyeHQ2SHpmRUFMd1Fva3U5UVBmT3Axdk0xbW5yTXpOQ0Ex?=
 =?utf-8?B?Mng1T0ZyclBCZ2NabS9BZit5L3hVcG5uL2VFaHd1WEdOaWpPcmFzWlNrVnpB?=
 =?utf-8?B?V2szMjJkZENGYWliZDJCblBMRzR3MktXMis3M3VHOGxaS2dWRnA5U0ZvTVdw?=
 =?utf-8?B?YTk5aDN2bE8rOUg0RlU4UXBiYVU1Vi91UXBwQk5GYnlHN25GZS9IWkZBV2Vz?=
 =?utf-8?B?akxzcWJDR0lvYkhjSEpOUXRGRzhZYUNYdGVCNHZEbm54NlBxSXNqZGN2em02?=
 =?utf-8?B?Z3VJeGVFYmR4VmZqeXVrem4rUHp0YkwwMUFtTFVuV3AzNmNqejBYK00vK1lw?=
 =?utf-8?B?VkMrTkZmdDNaWWxaeno0VFpucFJxZEtMRmtlSjVZT0xIYnpRNCtJejhnc0ly?=
 =?utf-8?B?Y3BXNlVMOU1YeTVLUHhXQ0E2WGlHZzV1R256c0FLYmxtZUlZeGRsRGd6MlFl?=
 =?utf-8?B?d1k3WCs1OG5HMmt0aWc1TElzemxHb1VFa3kyUTUrRnZ3RkQrUm50cU51VXhu?=
 =?utf-8?B?ZmsrbGtoYXh0QXdhZDJIdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWljQVRyU0FsVjBTcGpXeEpKSjgxZEdhQXk1QlpHcXhZSjFqdWhGclpMQ1o4?=
 =?utf-8?B?TlZQZFBPci9oMmVkL1BZRzJYVlZkMEhlYXlnNjJ1Z0lZM2xXNmFwaEh3VUw5?=
 =?utf-8?B?OUNSQnJISWtPcEhUcWpGYVRNVFl1Y0dhZExkT3pYNjh3eHg0YzFEdkV2alZv?=
 =?utf-8?B?MWxNQjU4S0ViZjA5TG8rUzgveDR2T29RUVhhVlJOSSs3VnBZUktWVkhZeVhu?=
 =?utf-8?B?V3V5S2lEU1R6Z3NKU2ljZTh1Y04zTTZOL2VhdmVwdWRKdTJjSWFHU1AzNW1m?=
 =?utf-8?B?T04rVzBIaVVQUSs5SEVKdmZENEFCOHRhYlFBUDZiaStONU5LMlcrOHUvNFVU?=
 =?utf-8?B?ZmxNMjV3R2o4MDRJazkxdzlTaVhFdkI0a0x6OEFXZU1ZYlgvYkxBUVM0ZU5T?=
 =?utf-8?B?eE9ETlFMVlFaQ0thTDJ0ZXdCNnpRRlEyQThpeHlGZEtTM2ZGYTM5OE5EVWpD?=
 =?utf-8?B?a0E4VEZUTThsZ0E1RE93Z3F6WEN6M05oelF3WXM5V0Z4aU02RFlmUlVuajho?=
 =?utf-8?B?MHlYUTRJeW5qQmIrRXdMdFZEcGlHUU9FdHo4RVZKb2kwMElNcnAxY3hiSVI3?=
 =?utf-8?B?eUZmd1ZVVVhNMGtjb3hnQS9XWFBManNGTHVlcTY2bVNvc2xvUkU2bDIzRnIr?=
 =?utf-8?B?WnNNMi82d251d2dKMmtOTWhTOStGc1NleEs2ZkdhSVlaZ2VhVjF5VEVDNWRr?=
 =?utf-8?B?UTV4TjZqV21RenJVaGNYZzZsUXFCcTVUbDNReEVTZnFOa0NPNE1nRXJHR0Zv?=
 =?utf-8?B?aFRBVFZOR2wxdWJkbnIvYVMySXJqOUZwS2VPRW9xTzRkc1AvQVJFa1BFWEFV?=
 =?utf-8?B?UHFhTnBNK09nMlhjSDhUYlpUSURZVmdwNnNBOVY0cW5RWGw1VWtKSThDb2J4?=
 =?utf-8?B?R3g4R2RPalpnbnU4aHhHdmhXUzFTampZOGZvVkpEUUQzTjlLYWxxOU9uVXFE?=
 =?utf-8?B?QXlUTHlTMUlJMDVWZzc1MVNjUGdMN25WTkNSN2JlWFRQUFU1OTFSd3ZMVmxz?=
 =?utf-8?B?bCt2S2o1NjN2RGZDeHpQd2RsQW14VGI0b1RENHNNeVFtOE9OaE1iK1BNazZk?=
 =?utf-8?B?Ny9xSlF1WEZHK0RCUUNMalNFUHpkbFl1MVlZQ3B6T2pBZHhWMWM3M1F6dVdT?=
 =?utf-8?B?eW96Q0hPdnFtdVVTcWZyWE94N3FLUEtXWjBNUnNsNmE5ZE5zb0d5RlFUclV3?=
 =?utf-8?B?RTJqRlJGQUZYaHd6TkdjMXpzMjlwRTZBellvcjRPVUR6cm8vR2dLVHhXUlMv?=
 =?utf-8?B?K1hvZlJ4bEJxeXJId3VmMDRFTmdjM2pkc3gzbStZYVBvdHQ0cEhjVGxteldR?=
 =?utf-8?B?ZTBZYjdWbHAwcXJlQUVtNUtmMmNNSFp4cUw1bHl0NkVRRzRBa2piL2pKbzVE?=
 =?utf-8?B?Vm1NTG1PVWxLelF6SVJYZUdaYWUwcW1ZaThVRzhHR1RONDArV1ZqNEdxZTRX?=
 =?utf-8?B?dlUwWFV5Vm91Z2pVbkRXL21yNVNxb3l1ZG1IdzFRT1QrYnA5cmJRdVNvelNh?=
 =?utf-8?B?TUp6TDVaOFVzVGtKTHdScXA3cDk2WUpwSWhCaXVXb1JVQ0lZRTFYdEVTdnRB?=
 =?utf-8?B?NEhiaUdDQzNNaXhDVTRhWVo0YWdYdGNSd2dtejQ1bTd4NHBESi95c3pjRWZL?=
 =?utf-8?B?dkpBYmhjYUhFNlBNYlp0cCtmdVJ0NVZCN3UySGRyZUNtMlpycHhiVENObWtG?=
 =?utf-8?B?MzA0NVlNOGE0WHhxODVyWkwrMWZRSko3Q0tsa1RXdFhEd0NoclBOSUNzK2pt?=
 =?utf-8?B?VTBPV2VVWVNTenh5TndrZXd4c2VLNFljMjVZanZLRzAxVWUzeFovV1RsRVBq?=
 =?utf-8?B?ZmdiKzVrK1p4Um9scVVFZmg5Zmx2YTVRU0Z3R1dURGJ4ZXNkaW53Q2xlMitP?=
 =?utf-8?B?cWE0aFRHcnRSYXUzbVRpS2lBS0xYaVVQZGJ1ekVqV1BqZ1Vjd250NS9BY3lL?=
 =?utf-8?B?ZUI3WGVLL1RONkdoN3hEdlA2blFTLzdsS1ZJUWxQcytEMzFNMnRJT0FJVlRZ?=
 =?utf-8?B?Y3JWYU44VURNaEEyTXpkbXZ0QzBlWVRnWURVK045YzdDd0RuTWQ3TGg4SkpH?=
 =?utf-8?B?YUVWMktiMEN5UzNYZ1pLK0k0TTg2WTNLa1plZS9GU0U2YTFBblJvYmI3d0VN?=
 =?utf-8?B?WFJpNjhmTFlmUERUU1Z5QkgxTDl1eWNocWZEZlUxeGdHaHVLN0FnSnM2Rjk0?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84BF87656995EA4DBF1466CBB79852EA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee1b80f-5fa8-465f-a48e-08dc681371d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 06:13:10.2635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/IufUDLFb8JPfBEo4vCsTGdn/OdV0bt6FDz3JH0YW0VlspR2Ot6IyU6VZZF0XdmYGGL8JvGohxoFSSCtUEtlMDaOJorz9FbEEs9TOzkGGol/talvU+0C7z8t9FUM9iD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901

SGkgQW5kcmV3LA0KDQpPbiAyNi8wNC8yNCAxMTo0MyBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gRnJpLCBBcHIgMjYs
IDIwMjQgYXQgMDE6NDU6MjBQTSArMDAwMCwgUGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hp
cC5jb20gd3JvdGU6DQo+PiBIaSBBbmRyZXcsDQo+Pg0KPj4gT24gMjQvMDQvMjQgNTozOCBhbSwg
QW5kcmV3IEx1bm4gd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+Pj4NCj4+Pj4gK3N0YXRpYyBpbnQgb2FfdGM2X2FsbG9jYXRlX3J4X3NrYihzdHJ1Y3Qgb2Ff
dGM2ICp0YzYpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgIHRjNi0+cnhfc2tiID0gbmV0ZGV2X2FsbG9j
X3NrYih0YzYtPm5ldGRldiwgdGM2LT5uZXRkZXYtPm10dSArIEVUSF9ITEVOICsNCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVUSF9GQ1NfTEVOICsgTkVUX0lQX0FM
SUdOKTsNCj4+Pj4gKyAgICAgaWYgKCF0YzYtPnJ4X3NrYikgew0KPj4+PiArICAgICAgICAgICAg
IHRjNi0+bmV0ZGV2LT5zdGF0cy5yeF9kcm9wcGVkKys7DQo+Pj4+ICsgICAgICAgICAgICAgcmV0
dXJuIC1FTk9NRU07DQo+Pj4+ICsgICAgIH0NCj4+Pj4gKyAgICAgc2tiX3Jlc2VydmUodGM2LT5y
eF9za2IsIE5FVF9JUF9BTElHTik7DQo+Pj4NCj4+PiBJIHRoaW5rIHlvdSBjYW4gdXNlIG5ldGRl
dl9hbGxvY19za2JfaXBfYWxpZ24oKSBoZXJlLg0KPj4gQWggT0ssIHRoZW4gZG8geW91IG1lYW4g
d2UgY2FuIHJld3JpdGUgdGhlIGZ1bmN0aW9uDQo+PiBvYV90YzZfYWxsb2NhdGVfcnhfc2tiKCkg
YXMgYmVsb3c/DQo+Pg0KPj4gc3RhdGljIGludCBvYV90YzZfYWxsb2NhdGVfcnhfc2tiKHN0cnVj
dCBvYV90YzYgKnRjNikNCj4+IHsNCj4+ICAgICAgICB0YzYtPnJ4X3NrYiA9IG5ldGRldl9hbGxv
Y19za2JfaXBfYWxpZ24odGM2LT5uZXRkZXYsIHRjNi0+bmV0ZGV2LT5tdHUgKw0KPj4gRVRIX0hM
RU4gKyBFVEhfRkNTX0xFTik7DQo+PiAgICAgICAgaWYgKHRjNi0+cnhfc2tiKQ0KPj4gICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+Pg0KPj4gICAgICAgIHRjNi0+bmV0ZGV2LT5zdGF0cy5yeF9k
cm9wcGVkKys7DQo+PiAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+PiB9DQo+IA0KPiBMb29rcyBh
Ym91dCByaWdodC4gQnV0IGkgZGlkIHNheSAnSSB0aGluaycsIG1lYW5pbmcgaSdtIG5vdCB0b28g
c3VyZQ0KPiBhYm91dCB0aGlzLg0KPiANCj4gSSBnZW5lcmFsbHkgZG9uJ3QgcmV2aWV3IGNvZGUg
YWN0dWFsbHkgbW92aW5nIHBhY2tldHMgYXJvdW5kLiBJdCBpcw0KPiB3aGF0IGRldmVsb3BlcnMg
Zm9jdXMgb24sIHRlc3QgaGVhdmlseSwgYW5kIHNvIGlzIGdlbmVyYWxseSBPLksuIEl0IGlzDQo+
IHRoZSBjb2RlIGFyb3VuZCB0aGUgZWRnZXMgd2hpY2ggb2Z0ZW4gbmVlZHMgaW1wcm92ZW1lbnRz
IHByb21wdGVkIGJ5DQo+IHJldmlldywgZXRodG9vbCwgUEhZIGhhbmRsaW5nLCBzdGF0aXN0aWNz
Lg0KWW91IGFyZSByaWdodC4gQnV0IEkgdGVzdGVkIGltcGxlbWVudGluZyB5b3VyIHByb3Bvc2Fs
IHdpdGggaXBlcmYzIGFuZCANCml0IHdvcmtzIGFzIGV4cGVjdGVkLiBTbyB3aWxsIGtlZXAgdGhp
cyBpbXBsZW1lbnRhdGlvbiBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpQ
YXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAgQW5kcmV3DQoNCg==

