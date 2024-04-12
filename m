Return-Path: <linux-kernel+bounces-142521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE298A2CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3556DB21D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C766943AD5;
	Fri, 12 Apr 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fYYtUXVz";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zbAuwsbd"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A742056;
	Fri, 12 Apr 2024 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918605; cv=fail; b=aDzeCEY6Y05z8rnqghv9oWqPWJihDt8lyukFBg6U4zo37ukMRXI3k3lGaSMthIYpEJotp7N7oOZlOMG4vZfyQg6h4axvIhrnBNEoQidJ2lc2Dx6kyn2wEqBZ93fgBr9eFHCMZkxzAI5OaxlZexOAW2JHuJPFVAFwZBGZPGbhw8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918605; c=relaxed/simple;
	bh=ZEiZBxi/3EUYlKxurFqGaxSI6i4gyK8XkxVQ6UrJOJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HZfTVxES9LI+D26aBxMiAHhXAH/dS62yMmZGiKzDfaothut9pFPvV8wOTFIgUAUHtSrCo9g9dNOIZN1m9W4BesTbtCkzZ4qOKPJbQBb/85bcdjAcAeLYZI/COJfUvu3/aDReZzX/Y7s9Rm5XnkixYknEqAcZCsT5OOckiBmzQiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fYYtUXVz; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zbAuwsbd; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712918603; x=1744454603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZEiZBxi/3EUYlKxurFqGaxSI6i4gyK8XkxVQ6UrJOJs=;
  b=fYYtUXVz6xQIIRh/QuoCeo1lP/TJQtQvT3GqKTSaLAKHapo3K+0jPYVS
   nhz1erizVFbKtYoypf8Hk30g+eImc2yzh7faLYRAdszLafq8bHbzQU+3G
   GEe/8wKBdyRrSVZo4bNfWI8BMM/08BF3D0JQLYQsplJXP9CVuULt7K8R6
   ZgDINAroC1Vwgs8bzElBaAI1w9RPJzn2nMb+O+a3qgav1a/LwbUsxdtjQ
   sbbRWPS5Yx/5jwW3SPZoflr+8F93ojk91nCHDvddcZni3zF3EQx8va+ZM
   e6zkrx7oQ2+1vp+CSL5vMfonQMMwAdb3KvH7GbU+9WCEiaBWghOCTxBPy
   A==;
X-CSE-ConnectionGUID: luYSc1YNTQmFLFBtWVwjyw==
X-CSE-MsgGUID: ucRhjHHXThih1IBAQ50ZiQ==
X-IronPort-AV: E=Sophos;i="6.07,195,1708412400"; 
   d="scan'208";a="22703568"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 03:43:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 03:43:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 03:43:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ9SO455hSg92rA2DfRCQEK00pYNW2zoDuuzb3/llEpxS3OTJqJ1T4Qi82WYuPxGtOXUkQXkBRYYJdL8tei6uAGHeYOFgYsoD4SC/Nr3a3E98PUffDGZHyiU6RJKtVNfonsC6FJhooDf1+Q6/bHGfZD6WiqEjqXlIBceBHpMaj3bdU8mfJfjmxwDJy/U4471hGSxOHT05Bxk57XqD5MwXG+Yag6NU0yN6Ei69mwGG+OwCsLST2Uww6Sxh9eb7paK6hwRe564jYmB5P83NbVhEPQ7moDtxpGLm9fAvzAH1+iRG0p5w6vfpw8w5umnO/P/eyVS+vGcpTfGL2ODt4WlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEiZBxi/3EUYlKxurFqGaxSI6i4gyK8XkxVQ6UrJOJs=;
 b=ehZzz2Rl6fS6mLeTH1f2n/XO2qI1cboOpXB+47o23om2RxM9Oh3hJD4WiFhiq1vv30geH5NLZh0DAX8Z20YJh2qdD0tXrdPqXzSdJxAogXbdD3oWMEAQjV6tS5n9d+ozLmYLmdpYDZHgQTHIdAj6PTMumVlYR2lILycF8rXrPtxB9r+T/D/8p7BMSFhYl8z4Wzv+91jc5+KHnv9CxgE4zgenoNEzE7Qh5S8G8gbDe7W0K1tLFJrUSs7e6FB9i/T1f7EP0RPuB68cx+i8EU3idVnRwOScWKQ3FQYs7M3aRA5z9HLXHKDv7NeOERnZWG7biXp32MhW9hourO8lqEe6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEiZBxi/3EUYlKxurFqGaxSI6i4gyK8XkxVQ6UrJOJs=;
 b=zbAuwsbdO05M2/RKNfv3T4FQQ7kZID/YT27rlECdTXW0KuAgofmjH8wRX6fwO0+R+3yhyMxsybvXxFe3+4TLnjPy/71ZA/6l1Hh5T6THrFI174QIJ3ltQyg1qsu7CBZp1rTab1P//aw60Kg1tgjXK7bmf7g2HCYpfq5rHU6+ZMTvu7PnNmlvP6JshZ0EP13EOyhfS7kyU8iuFq61ZmjUNU1Lbn2Pf5bb5F23cGGxI9SwZbtZYwBm+U9gd6pIjIuYR6dMmoXy5BBeiK67ctlXcwYgByF5xNj9hSE40tAS2HhbdjhqrqUkYAedGbgM5UMriiyRut5T/eCyUrNrG0cWlA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by IA1PR11MB6369.namprd11.prod.outlook.com (2603:10b6:208:3af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Fri, 12 Apr
 2024 10:43:15 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 10:43:15 +0000
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
Thread-Index: AQHab6OHj5kLkYW7WEGlK1Xe+8KWTLEregYAgADhwoCAACAwgIABRrCAgAAYZQCAD4ziAIAnRUiA
Date: Fri, 12 Apr 2024 10:43:15 +0000
Message-ID: <ee5dcd07-7c44-4317-9d62-0fc68565988a@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
 <8c2b95f4-75a7-4d6d-ab9c-9c3498c040d8@lunn.ch>
 <eeb57938-e21e-406d-a835-93c6fb19b161@microchip.com>
 <7ddbe599-187e-401f-b508-4dc62bca8374@lunn.ch>
 <e9bc573e-61f0-484a-b1fb-b5100eb9ee0a@microchip.com>
 <8de7a4bb-a127-4771-97dd-038f08fcce9d@lunn.ch>
 <372a45c3-1372-4956-8d42-8e989f86d131@microchip.com>
In-Reply-To: <372a45c3-1372-4956-8d42-8e989f86d131@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|IA1PR11MB6369:EE_
x-ms-office365-filtering-correlation-id: 760f3998-7839-4cb0-54d3-08dc5add5bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qgxxL3HyovIUnjqzna97y7HQIRkbREGV20Tr9OSqjKetjFr67Gd/gCBBkn5oYfw0H2fmFjgj6fWzaujwNDDv0fWnidjYr2khLEWGe2tMj+JwTIwH3fyGda1cEzoiKK+KaA+J3LgLi2PuF2DnVf2QRYeudsDoazoW+KSt6qXJTqENNzjfWVwMyFYZfveNa13Lc06YbDdkaArKYEdNkX1HGxo5DTI7mihoQpvqZMa54fTDnDrlzPTLQN3v/lKSsCS8NLrlgEs8QwzF3dKw+FiuUFwWY/z02wLCBsNxIK3hlpbJoQsk9qbyvWl603tiK5KzvpsdWSzhKeGIxUlbJzV5RJMQk8oEDc2r4Swcjs+JslbxKV4h0glR20ZLcB/M5kvRznOf3gBANDXz5Xa0YLfL9pb9eHU6YonEhjErt4LeXLZ72ka9QcOKI+7ZEoNF1C8ht4lgqYKpZQ1hLDNQg1xNgrnv5iZ+Caf/SeOYTnWDHV+lL747zxTRB1H3kf2CtqSgpS06AzPm5SxRS/AaNtm299dvhG8KdTM1lA0nZAI0mURGnQcdz+rgD3qx4S2VSRuPShK3MT9x4ou/T3+0T1yibiEp2wY4jDigJK05pDzyKyusH52nStKohnC6539sPrg4+MWRiNfB4tp/vY2s3D1/b6Ov8cvFbrVoEV1mb9VrNHMqUbLeHzZS+fUIJhifIP49RjN0e7010DOJVMQAbRjEyfDIyypE92gB9FOsdnehTI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlpzU3NuNTQ4dEJKNEh0c3BTTFZuTkpzZ1ZXbDJWRlFib0h5dlFNdjRERDg5?=
 =?utf-8?B?dEhpbTB4Ujg4MGN1TU5mRXVXb0YzZnFIMUV5a2tDaElnb3JGZVZiVUlJWXov?=
 =?utf-8?B?U01rbkVDMWJnNHJyOFJ5Rmg4c0EzbmhidmI2cVppNk1zT2Z4T09zNld3aE8y?=
 =?utf-8?B?SkNWNzBZdzUrdVUrblN3c2tqVUJTbEhVTGRna0k4Sk1Zb1l0c1pXWFlzcDNw?=
 =?utf-8?B?QVNJa0g0MVVISjRzdmp4RjIxeWY5QXZidEQvRVNoQjR6Y2NBc0Z0K0VnN3hM?=
 =?utf-8?B?bHc5U3Z1anlEeDN2RkVlSVMxZTFOUW16dVA0NDJjYXV0U2dxWDRra0VZV3c5?=
 =?utf-8?B?UHJvMFFSNTFISHBOTTI5L05qN05VU3FnVVBQc291bjRON2xXdW4rdEdqb1kz?=
 =?utf-8?B?YkhiTnFZVlRwTkRZbnhvYkVtZEVHTkppVGVYanRiUjY0VjYxMEM0WERHdUI1?=
 =?utf-8?B?TS9LTFNRWWRnUEN5VFBoZU9uYVFWUjVESFZOU0p5ZzFtL3NkS2pHQnhMUjNI?=
 =?utf-8?B?WnRGRThKWWZkbFlCRi9icDZkTE5oMC9LN2hLMFVaK1c2d3pvNG1kcm5HV0Qz?=
 =?utf-8?B?U3BTM1M5aUl0Y0lpM0xvLzZ0ZDZpajRhZWRMcWpVd2ppMU83NE9SdjAxK1Nm?=
 =?utf-8?B?bkx4di9RdGNjVHpvcFptblNMMDV4WmtuT1cxT21zdk5zbzdMODZzWnFDVzlC?=
 =?utf-8?B?QUk1ei9LWCtqY04zQ21ldDJyd2N3dVUwY2lVRTJTc0FpUG5VUUdzTHRrMk04?=
 =?utf-8?B?bS9ScStZdmJkdXJyckNqcm5Hell2YjllMUJTbGhvTVZBWjVvUjljYVMxMS9o?=
 =?utf-8?B?U1hFUHMxcGx4bmJpVTFsZUpEWWx5WFg2VklqYmc4QVlwa2plOWdLZGtkaHEx?=
 =?utf-8?B?em5zTVhYVUs4NUpxaEE3NWZUVGNDNFFiUXhEUHo0ck5kOW9WbFBtditKaHNV?=
 =?utf-8?B?SVJJNUczMEhLaUtXNml6TUdpbU4wL1lFRkpnL2gyT3J6K3BReUJXY0tMUFNO?=
 =?utf-8?B?TXRTSDNibHpyN2NPWWpIYTFjYWhOclp4V3RQYXcrVDBkNjNzdjJvRG1uU3lu?=
 =?utf-8?B?RFViVHdxdXV0blNVVGlxNjJwVEk2d0JMT1BwenNrbWFYU216U2JMZU5sdC9O?=
 =?utf-8?B?OUFjdXBGWVhVRHBKK2ZhMmFlOHpyTFJ1S0Rnck9BZjhlcUt0ZmM4UnFKazl6?=
 =?utf-8?B?YlpBMGl3Y2xZTTh3aWFxTi9oS1Y4UDV0UmsvV2pmN0JCTXZKT1Fwb3lVTVJK?=
 =?utf-8?B?U3hGZEY0ZndDVjFkNHFsdFFuS1dQTnp3T3k4MWY2R21kRk04SDAxUVRYVVFy?=
 =?utf-8?B?bjRJUUVhSk1NODlIeFYydGtjWEZ0U2NWd29hMlM1MmpxZjNNL0Q5VGQwVURB?=
 =?utf-8?B?WXlzTVZydXBEa1BtY0ZDOVZHWXAyUDNyMzJEOGppSmpaaG9wRmhnQ1FkS2Vx?=
 =?utf-8?B?QUxEQ0Via1hkeEhlVlJ1enhCTHJJcXZPMS96VDZvc2RueThMVTdVc0xwNE4x?=
 =?utf-8?B?NnF0aFNiUEpRU1IyVmRHMnYxL0llejV5SkRzRlVrQXNIemhxV0FweVZLUTVP?=
 =?utf-8?B?dHh0Wk9BeEtNRkd3a1g5VFlwZGxnczB5cFZ3bHRHb3g4Z0lhbDZoZ0gySThY?=
 =?utf-8?B?eTUvVm55SS9xV0U0K2k5bHZOaSsxWGFnSmpkNlJpck1hckRKVGY3R1NYNGpU?=
 =?utf-8?B?RDBDcWM5QmF6cnR1ck1OeDA2TlZXN0ZjUFpiTXFWa1RmMTVDaW1zekowcnR6?=
 =?utf-8?B?RDcwYmhoTUtINThNV0taL0dqZkNQZEordlR0QTlEeE00ZklWUjgvMlkrck1E?=
 =?utf-8?B?Y2JsLzlSTjMrQ3Z1OVAwUDgvT3czcktldHNCdFJvMEwyTmIrT3dPN0NERWxK?=
 =?utf-8?B?SlFhalo4SStrdFNYaU5JS1g3SWh1dlBFYWhMTlVBMUhLc2Q3Y2hySFBtcWVn?=
 =?utf-8?B?WkMrZmI3amNFam9xam8zOWpLRUtmQWIrOVFlbk92NlNyQ0phWUJjR2w3T0hX?=
 =?utf-8?B?V3huZHR4N1FhVjZLdUF1WTQrWEhMWm80Z3lFOEQ4TGxGUWl1RUhGalkyc1Zn?=
 =?utf-8?B?d3pIaUxCc2dvdy9RRHZ1TFdOU21mWnVyd1dSdVkxYStHc3l4RHNySTI1SWhr?=
 =?utf-8?B?MmkxeWxzMUVTS3JwbGF5eUpqVklKMUJHWFVhYy96ME82aG9oT1cxV20yRmpQ?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <776D2BFB28904E48880ECBFFC19BEBC5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760f3998-7839-4cb0-54d3-08dc5add5bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 10:43:15.3391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vb84DSE1hA13gUY+RHchuanvKsGiWtBn1kIDyPiXDQZLtIKdE3OvyRPMHtF/XKT2mZAEEbhPZpIE8Ge6tpxI09qVZknBEbuNc6v3tjT6Ej3unJNGezN5q/VNZtiaV134
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6369

SGkgQW5kcmV3LA0KDQpPbiAxOC8wMy8yNCA0OjMxIHBtLCBQYXJ0aGliYW4uVmVlcmFzb29yYW5A
bWljcm9jaGlwLmNvbSB3cm90ZToNCj4gSGkgQW5kcmV3LA0KPiANCj4gT24gMDgvMDMvMjQgNzow
MyBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUNCj4+DQo+Pj4gT2ssIGFzIHBlciB0aGUgdGFibGUgNiBpbiB0aGUgc3BlYywgUEhZIEM0
NSByZWdpc3RlcnMgYXJlIG1hcHBlZCBpbiB0aGUNCj4+PiBNTVMgbGlrZSBiZWxvdywNCj4+Pg0K
Pj4+IFBIWSDigJMgUENTIFJlZ2lzdGVycyAoTU1EIDMpICAtLS0+ICBNTVMgMg0KPj4+IFBIWSDi
gJMgUE1BL1BNRCBSZWdpc3RlcnMgKE1NRCAxKSAgLS0tPiAgIE1NUyAzDQo+Pj4gUEhZIOKAkyBW
ZW5kb3IgU3BlY2lmaWMgYW5kIFBMQ0EgUmVnaXN0ZXJzIChNTUQgMzEpICAtLS0+ICBNTVMgNA0K
Pj4+IFBIWSDigJMgQXV0by1OZWdvdGlhdGlvbiBSZWdpc3RlcnMgKE1NRCA3KSAgLS0tPiAgTU1T
IDUNCj4+PiBQSFkg4oCTIFBvd2VyIFVuaXQgKE1NRCAxMykgIC0tLT4gIE1NUyA2DQo+Pj4NCj4+
PiBNTUQgMTMgZm9yIFBIWSAtIFBvd2VyIFVuaXQgaXMgbm90IGRlZmluZWQgaW4gdGhlIG1kaW8u
aC4gU28gaW4gdGhlDQo+Pj4gYmVsb3cgY29kZSBJIGhhdmUgZGVmaW5lZCBpdCBsb2NhbGx5IChN
RElPX01NRF9QT1dFUl9VTklUKS4gTWF5IGJlDQo+Pj4gbmVlZGVkIHRvIGRvIHRoaXMgaW4gdGhl
IG1kaW8uaCBmaWxlIHdoZW4gY29taW5nIHRvIHRoaXMgcGF0Y2guDQo+Pg0KPj4gWWVzLCBwbGVh
c2UgYWRkIGl0IHRvIG1kaW8uaA0KPiBTdXJlIHdpbGwgYWRkIGl0IGluIHRoZSBtZGlvLmggZmls
ZS4NCj4+DQo+Pj4gLyogUEhZIOKAkyBDbGF1c2UgNDUgcmVnaXN0ZXJzIG1lbW9yeSBtYXAgc2Vs
ZWN0b3IgKE1NUykgYXMgcGVyIHRhYmxlIDYgaW4NCj4+PiB0aGUgT1BFTiBBbGxpYW5jZSBzcGVj
aWZpY2F0aW9uLg0KPj4+ICAgICAqLw0KPj4+ICNkZWZpbmUgT0FfVEM2X1BIWV9QQ1NfTU1TMiAg
ICAgICAgICAgICAgICAgICAgIDIgICAgICAgLyogTU1EIDMgKi8NCj4+PiAjZGVmaW5lIE9BX1RD
Nl9QSFlfUE1BX1BNRF9NTVMzICAgICAgICAgICAgICAgICAzICAgICAgIC8qIE1NRCAxICovDQo+
Pj4gI2RlZmluZSBPQV9UQzZfUEhZX1ZTX1BMQ0FfTU1TNCAgICAgICAgICAgICAgICAgNCAgICAg
ICAvKiBNTUQgMzEgKi8NCj4+PiAjZGVmaW5lIE9BX1RDNl9QSFlfQVVUT19ORUdfTU1TNSAgICAg
ICAgICAgICAgICA1ICAgICAgIC8qIE1NRCA3ICovDQo+Pj4gI2RlZmluZSBPQV9UQzZfUEhZX1BP
V0VSX1VOSVRfTU1TNiAgICAgICAgICAgICAgNiAgICAgICAvKiBNTUQgMTMgKi8NCj4+Pg0KPj4+
IC8qIE1ESU8gTWFuYWdlYWJsZSBEZXZpY2UgKE1NRCkgZm9yIFBIWSBQb3dlciBVbml0ICovDQo+
Pj4gI2RlZmluZSBNRElPX01NRF9QT1dFUl9VTklUICAgICAgICAgICAgICAgICAgICAgMTMgICAg
ICAvKiBQSFkgUG93ZXIgVW5pdCAqLw0KPj4+DQo+Pj4gc3RhdGljIGludCBvYV90YzZfbWRpb2J1
c19yZWFkX2M0NShzdHJ1Y3QgbWlpX2J1cyAqYnVzLCBpbnQgYWRkciwgaW50DQo+Pj4gZGV2bnVt
LCBpbnQgcmVnbnVtKQ0KPj4+IHsNCj4+Pg0KPj4+ICAgICAgICAgICAgc3RydWN0IG9hX3RjNiAq
dGM2ID0gYnVzLT5wcml2Ow0KPj4+DQo+Pj4gICAgICAgICAgICB1MzIgcmVndmFsOw0KPj4+DQo+
Pj4gICAgICAgICAgICBib29sIHJldDsNCj4+Pg0KPj4+ICAgICAgICAgICAgdTMyIG1tczsNCj4+
Pg0KPj4+DQo+Pj4NCj4+PiAgICAgICAgICAgIGlmIChkZXZudW0gPT0gTURJT19NTURfUENTKQ0K
Pj4+DQo+Pj4gICAgICAgICAgICAgICAgICAgIG1tcyA9IE9BX1RDNl9QSFlfUENTX01NUzI7DQo+
Pj4NCj4+PiAgICAgICAgICAgIGVsc2UgaWYgKGRldm51bSA9PSBNRElPX01NRF9QTUFQTUQpDQo+
Pj4NCj4+PiAgICAgICAgICAgICAgICAgICAgbW1zID0gT0FfVEM2X1BIWV9QTUFfUE1EX01NUzM7
DQo+Pj4NCj4+PiAgICAgICAgICAgIGVsc2UgaWYgKGRldm51bSA9PSBNRElPX01NRF9WRU5EMikN
Cj4+Pg0KPj4+ICAgICAgICAgICAgICAgICAgICBtbXMgPSBPQV9UQzZfUEhZX1ZTX1BMQ0FfTU1T
NDsNCj4+Pg0KPj4+ICAgICAgICAgICAgZWxzZSBpZiAoZGV2bnVtID09IE1ESU9fTU1EX0FOKQ0K
Pj4+DQo+Pj4gICAgICAgICAgICAgICAgICAgIG1tcyA9IE9BX1RDNl9QSFlfQVVUT19ORUdfTU1T
NTsNCj4+Pg0KPj4+ICAgICAgICAgICAgZWxzZSBpZiAoZGV2bnVtID09IE1ESU9fTU1EX1BPV0VS
X1VOSVQpDQo+Pj4NCj4+PiAgICAgICAgICAgICAgICAgICAgbW1zID0gT0FfVEM2X1BIWV9QT1dF
Ul9VTklUX01NUzY7DQo+Pg0KPj4gSSB3b3VsZCBwcm9iYWJseSB1c2UgYSBzd2l0Y2ggc3RhdGVt
ZW50Lg0KPiBBaCBvaywgSSB3aWxsIHVzZSBzd2l0Y2ggaGVyZS4NCj4+DQo+Pj4NCj4+PiAgICAg
ICAgICAgIGVsc2UNCj4+Pg0KPj4+ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT1RTVVBQ
Ow0KPj4NCj4+IDgwMi4zIHNheXM6DQo+Pg0KPj4gICAgIElmIGEgZGV2aWNlIHN1cHBvcnRzIHRo
ZSBNRElPIGludGVyZmFjZSBpdCBzaGFsbCByZXNwb25kIHRvIGFsbA0KPj4gICAgIHBvc3NpYmxl
IHJlZ2lzdGVyIGFkZHJlc3NlcyBmb3IgdGhlIGRldmljZSBhbmQgcmV0dXJuIGEgdmFsdWUgb2YN
Cj4+ICAgICB6ZXJvIGZvciB1bmRlZmluZWQgYW5kIHVuc3VwcG9ydGVkIHJlZ2lzdGVycy4gV3Jp
dGVzIHRvIHVuZGVmaW5lZA0KPj4gICAgIHJlZ2lzdGVycyBhbmQgcmVhZC1vbmx5IHJlZ2lzdGVy
cyBzaGFsbCBoYXZlIG5vIGVmZmVjdC4gVGhlDQo+PiAgICAgb3BlcmF0aW9uIG9mIGFuIE1NRCBz
aGFsbCBub3QgYmUgYWZmZWN0ZWQgYnkgd3JpdGVzIHRvIHJlc2VydmVkIGFuZA0KPj4gICAgIHVu
c3VwcG9ydGVkIHJlZ2lzdGVyIGJpdHMsIGFuZCBzdWNoIHJlZ2lzdGVyIGJpdHMgc2hhbGwgcmV0
dXJuIGENCj4+ICAgICB2YWx1ZSBvZiB6ZXJvIHdoZW4gcmVhZC4NCj4+DQo+PiBTbyBtYXliZSBy
ZXR1cm4gMC4gRU5PVFNVUFAgaXMgd3JvbmcsIHRoYXQgaXMgYW4gTkZTIG9ubHkgZXJyb3INCj4+
IGNvZGUuIFRoZSBnZW5lcmljIG9uZSBpcyBFT1BOT1RTVVBQLiBJIHdvdWxkIHNheSAtRU9QTk9U
U1VQUCBpcyBhbHNvDQo+PiBPLksuDQo+IFN1cmUsIEkgd2lsbCB1c2UgLUVPUE5PVFNVUFAgaW4g
dGhlIG5leHQgdmVyc2lvbiBpbnN0ZWFkIG9mIC1FTk9UU1VQUC4NCj4+DQo+Pj4gICAgICAgICAg
ICByZXQgPSBvYV90YzZfcmVhZF9yZWdpc3Rlcih0YzYsIChtbXMgPDwgMTYpIHwgcmVnbnVtLCAm
cmVndmFsKTsNCj4+Pg0KPj4+ICAgICAgICAgICAgaWYgKHJldCkNCj4+Pg0KPj4+ICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4+DQo+PiBvYV90YzZfcmVhZF9yZWdpc3Rlcigp
IHNob3VsZCByZXR1cm4gYW4gZXJyb3IgY29kZSwgc28gcmV0dXJuIHdoYXRldmVyDQo+PiBpcyBy
ZXR1cm5zLiBEb24ndCBvdmVyd3JpdGUgZXJyb3IgY29kZXMuIEl0IG1ha2VzIGl0IGhhcmRlciB0
byB0cmFjaw0KPj4gZXJyb3JzIHRocm91Z2ggdGhlIGNhbGwgc3RhY2suDQo+IEFoIG9rLCB3aWxs
IHJldHVybiB0aGUgZXJyb3IgY29kZSBmcm9tIG9hX3RjNl9yZWFkX3JlZ2lzdGVyKCkgaW4gdGhl
DQo+IG5leHQgdmVyc2lvbi4NCkFmdGVyIGltcGxlbWVudGluZyB0aGUgbmV3IEFQSXMgb2FfdGM2
X21kaW9idXNfcmVhZF9jNDUoKSBhbmQgDQpvYV90YzZfbWRpb2J1c193cml0ZV9jNDUoKSwgSSB0
cmllZCB0ZXN0aW5nLiBCdXQsIGZvciBzb21lIHJlYXNvbiB0aGVzZSANCkFQSXMgYXJlIG5ldmVy
IGdldCBjYWxsZWQgYnkgcGh5X3JlYWRfbW1kKCkgb3IgcGh5X3dyaXRlX21tZCgpIGFzIHRob3Nl
IA0KQVBJcyBhcmUgY2hlY2tpbmcgZm9yIHBoeWRldi0+aXNfYzQ1IGZsYWcgZm9yIGNhbGxpbmcg
dGhpcyBuZXcgYzQ1IEFQSXMgDQp3aGljaCBpcyBub3Qgc2V0IGluIHRoaXMgY2FzZS4NCg0KSWYg
dGhlIHBoeWRldiBpcyBmb3VuZCB2aWEgYzIyLCBwaHlsaWIgZG9lcyBub3Qgc2V0IHBoeWRldi0+
aXNfYzQ1LCBhbmQgDQpldmVyeXRoaW5nIGVuZHMgdXAgZ29pbmcgaW5kaXJlY3QuDQoNClRvIHZl
cmlmeSB0aGUgQVBJcywgSSBqdXN0IGNhbGxlZCB0aGVtIGxvY2FsbHkgd2l0aGluZyB0aGUgb2Ff
dGM2X2luaXQoKSANCmZ1bmN0aW9uLCB0aGVyZSBJIGdvdCB0aGUgZXhwZWN0ZWQgcmVzdWx0cyBi
dXQgYWNjZXNzaW5nIHRoZW0gdGhyb3VnaCANCnBoeWxpYiBpcyBub3Qgd29ya2luZyBiZWNhdXNl
IG9mIHRoZSBhYm92ZSByZWFzb24uDQoNCkRvIHlvdSBoYXZlIGFueSBpZGVhIG9yIHN1Z2dlc3Rp
b24gdG8gdGVzdCB0aGlzIEFQSXMgb3IgZG8gSSBtaXNzIA0KYW55dGhpbmcgaGVyZT8NCg0KQmVz
dCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gUGFydGhpYmFu
IFYNCj4+DQo+PiAgICAgICAgICBBbmRyZXcNCj4+DQo+IA0KDQo=

