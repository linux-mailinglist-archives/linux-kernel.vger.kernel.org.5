Return-Path: <linux-kernel+bounces-152715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209278AC34A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2991F21838
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCF812E4D;
	Mon, 22 Apr 2024 04:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NkQDPn6k";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fu1tiooL"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D81F9EC;
	Mon, 22 Apr 2024 04:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713758429; cv=fail; b=a5GCXrYG+OTNhpwA+hmCYr0J4b7S11iMHCzVfc2iLX5fmB0Z9l98jwej1l+4Yc9kGvLqCXWcKjS2x78A1Z49gUEHkBCs4njiLz9vxUo8Qy1cymhs04t1jweVPzh2v5vjGtaz3TdlloE/2DsVGnq1JfGtMgusenGEcOpBlBvm2N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713758429; c=relaxed/simple;
	bh=IFRNSyr6vW+3WiR1E+N997dDu/HL2T0B9b6V5Vfwa4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iIpBD65B0c/MjRyUjUNNNfdhcpqZVPHMj219vu7V31iSEL5GlmHDswSvu8z8+aNsBvfow0WvPT12fp7q+WeoBOzxLtzzlvVNdgLmXf27mxHwyjef0+WUi15gz8Gr5NfxoEdA1xL4jTYVii5ozW6CO41nX1t+wOAaJ3+Rmo33LvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NkQDPn6k; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fu1tiooL; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713758427; x=1745294427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IFRNSyr6vW+3WiR1E+N997dDu/HL2T0B9b6V5Vfwa4k=;
  b=NkQDPn6krt0Ht1LekG7fWJUP+5qijq8MP4LeTEDvP4BKhpRQJZ+m3IFM
   2Ff8o3Ykvx1TEXen4UeSrPOlpwWhycBOEHEl2HRRw+349XkXUaMaMypSl
   BOhsqbtLhjcwboCXCnWsKjPN8OcUhcPFc0do12Iyjf+OMBYJAL7y14fb/
   zLmiqiQROHpiW/lIoIjYdQeRTA7O/u1ydDuy2FuWUgqjOiJ43CwY4v0ez
   PAoo1stFe5RQSwDTNNJ0AAoIGkFr/3yx+GHc9O9zd+S/akdOMd9q+zRp0
   c8lNW/aCLW7yML39EPm2vAGon42X9OF98bsRGDqFY2y0qI0C1E4hl1KVf
   w==;
X-CSE-ConnectionGUID: BQkixaF7Sya+GZ0gWJ/mqg==
X-CSE-MsgGUID: /x4AKV7rRhaiWr4fQsFaSQ==
X-IronPort-AV: E=Sophos;i="6.07,219,1708412400"; 
   d="scan'208";a="24098140"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2024 21:00:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Apr 2024 20:59:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 21 Apr 2024 20:59:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THhMNMCTmXfRcHR7wewlU7QrOgjHvF/E602KZbSCeuOmc+hohVL+ORG+arHqMQ4LxFT7c5M3zN6oerWELOxMQkklkS9B+24w0rEHuAQdSXrVN/SwUwljABBGw+6tCA+KfHxIqg9VipWeFq4KB4LlR5/r4V+d8J3BTwFPd9kSLsT7E8pIne550eUa55C6d5JjIdb+bUJNA4X2Kdw6Ley4rKZ0lNHhUchJU0SItV/bNfou/JhBALkwti6N+679bZUWi9uCtRR/s/1Scn63S++MQKkeuaF813SQ8CLXS1nHpmqyT+kXhAceRNNcpJlStBfB+ayjUYrWljIMcZ+X4NKhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFRNSyr6vW+3WiR1E+N997dDu/HL2T0B9b6V5Vfwa4k=;
 b=Qk6worwJjg7AJMePBfgl8GmRsT1TS2c9WKYqtClZCBEZokjYGLoWPqcgF4ook4UOBX/MccWVE2Ce/ltWmCLCd+ivdvwpNvfMqw8mez2B5LygyPmc/xbmyk7XbtXEOuV+1LwkEqWBBEOnWRzMIrKFHnRmkhCzWPvJunnm2BF7RM5pNOslDY9+f1sHZ/9opM1U1qwPEkvp4ENddE/N1CeQ42x6wAjcgopjcGyhHJN2OsLW1hEfitSI3R9Z4aP99AOhoRWM5BLbItlpQ2c2RPIix6WyoYAzrIfEDbyMuUwJkoTemyJUFzPuMmYNMlPGfXepjOB+VGeO9lbr4hdcV2upEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFRNSyr6vW+3WiR1E+N997dDu/HL2T0B9b6V5Vfwa4k=;
 b=fu1tiooLaj3Fz6lvRA4T12GGFSThOryDeEGQaOaXrX3YTpgTqB0EnAYdzllifZZbvphRNgm3yYWhj2O1UgHrE4JmaWlc5lCkcC1Bx/XDrO7uIohvPncqTwI9rTKtMfwlgrzQIeQz4+eJf4WRD4jLBrrqLkpP7GdCAKV6eZTPIF0LRLkjnQjwmXR6jCJkDZIMOiKEgoQe0kc1kbSmNNHYv1qPYmCUoTSfUuKlf2EPp853QV54zVSf2uMTZzUtjS1E4C8d0OVIpnbqeFtCZA0ctQRk9h0s3gT84ByHg3vIRIyUl+u8MqV1tIKEfs1Cxgjvz1iwgrdJX6F9JiSHh2NETQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 03:59:32 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 03:59:31 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <conor@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v4 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHakZA01VegT/3r7Uq03tjnEIunvbFuKi4AgAWFvoA=
Date: Mon, 22 Apr 2024 03:59:31 +0000
Message-ID: <a2c2d5ae-f709-42bf-9b60-c4428da4197d@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-13-Parthiban.Veerasooran@microchip.com>
 <20240418-hypnosis-oblong-028c107e6c3f@spud>
In-Reply-To: <20240418-hypnosis-oblong-028c107e6c3f@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CO1PR11MB5073:EE_
x-ms-office365-filtering-correlation-id: da152a8f-bbe2-4841-caed-08dc62809d9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UmgzcVIyaDhCSERFR01aVXp0OGRVdTBBN1lRQm9PYXExcUZWOGo0bXpncGF2?=
 =?utf-8?B?cEV3SlhhbnoyT0JaejFaclMzZUUrYUR4U1ZEN0JGOGxaOGFMYmIxeENmMkg0?=
 =?utf-8?B?NEZjZk5MRlFPRGdWMmpvTk50TlUyTXZtcnVHK1NVMHhqa0NVU2tjblFHa3p6?=
 =?utf-8?B?VytaZlgrbXJGMEJSd0IwZGd4R01rbmw3bktuU3RjYnhGc2NVdXE4b0tLZ1VJ?=
 =?utf-8?B?dGlleWpaaVpaNWJxL2V4NTBXOUNXbzlhaUZUNUZpOGdaY1JRYTFOdzRNOVdX?=
 =?utf-8?B?dGF0SURnSEVKNkI1VmlZZEtiZkdKckNNQ1VIaUgzK3kvY3Q3SkZHcW5NY1ZP?=
 =?utf-8?B?L2J5WFExcisyTjhMVklxSUdWVkV4eFZLZDJaK3VIdXd3TlhJandaSFU3Z0FI?=
 =?utf-8?B?T2VPY1hQZDNqVDE4amc0M1MzSzBJQWhLRlVkRUJ4SjZVUWZ6d2txVHJUVmEz?=
 =?utf-8?B?cHEzRXpaTW82MHNxb05hdGcwVzJ2czcxZlVYRlFIbDlxamUzSktrVmVxS1lP?=
 =?utf-8?B?L0tEcWNzOFo4L29XdFl6RldOcEtZeXFSOGVzVFdTc2IrWDA1eldlZEFhQkcy?=
 =?utf-8?B?TGc2K0FlRjE0TVZrSU9wcDBNT1hFZXFYdXRiNzU0VThwckczbWNxazVzQ2Zw?=
 =?utf-8?B?WFFkc01UaWZxM3c3Nklmc1F4eFFzV2IxY1hZNG41eG96VVhYcGNUM1loWEs1?=
 =?utf-8?B?LzJtYm1zZHFKM3hGVVg5L0VwR2Iyd2VPNkg4cDZ2ZklsUDZiU2FQMVc5MC91?=
 =?utf-8?B?VmtLNDZsa2ZiSWxwazlTbEtZRG9lYmtkcDNxMm56T09EWlBOclpGZnBKZll5?=
 =?utf-8?B?SUptTGcwcjdWY0ZNb0Y2VmVHQ3h3WVNEQUZXMUUrb2ZYNHdiSGt2MEpyN1Zx?=
 =?utf-8?B?TVBkUmh3aEF0THRZeEFINlU5cTNsb2Z4K2h1eXlTTnBhaUdqTjF4b1VVR2ZU?=
 =?utf-8?B?b2RVMXd6NVhjOGFyTXhDYjVPTmE3Ujh3NUZYMmdMYXNPKzB2Zk11cHhBaDB3?=
 =?utf-8?B?QmlJR2NzRTh5cUcwVmcreHBRZnlTNGpJV1RjNE5ZbWtiUHg0ZERsNmFoNlRD?=
 =?utf-8?B?R2ZEbkt3RWFVL2RkV2VTRVowMHV0a2JZU0c5VEd3YWlTS1E0QnhCem1xbDM1?=
 =?utf-8?B?blRacHRUMjdzRW5hSkI1VGNUTTdRYVU2MFNUZXRXdmZGc0UzLzFhWEFXZDBW?=
 =?utf-8?B?SXVJRTB4cmhzdDQ4cDBTVXhyR294bEJIcUYwbzc2c01xVUwxay9TdUxaUmRy?=
 =?utf-8?B?Wk8vdFIzR1BFZXM4RzNOck8xR3F6NmRoMkh6Ylh3d2dnUjV5N284QmNGa3dy?=
 =?utf-8?B?WFE1aGF5VTZudXBEM0d4N25Wd2FDSWE4Z01IMDd6VnYyMTdOenplRC9GZXVy?=
 =?utf-8?B?VWdZZjFxb3pwTmpHNHNaQy9Ya09VUFBYVjRrMnc4QUxVUW9sRWpmQ0dqRnJx?=
 =?utf-8?B?dkRGRnlxVnIxa1FLT0V2OElPMmRPWXR2R2JveW5UcUllYjRRbC9wb3lMSzIv?=
 =?utf-8?B?NWRsSTFWanFIYm1TZDFUZHo1WnkwdzkyOG1hVTd4dHI1RmJuRXZYQUJGLzNn?=
 =?utf-8?B?VUREOGR5TW0rcU1tNllJaEZCcnVJUXNSM2p4TkR5RitxMlRHWU1jaEJyU0xx?=
 =?utf-8?B?cUtaWGh6Yk8zZHdKd1ByR00vNHRzOEVzNmtxRzFmYkpPZmJCa3EvQTVQeHBm?=
 =?utf-8?B?K1Y4eUpic0xRUkZVK09TcmxCdzRoQ0NzTlZQditHTWpBRFU2cGpOY3UyOFZi?=
 =?utf-8?Q?DzBr1Spz5f9XeFiTMA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlJDOHk3ZjVaQ3VEdC95RUNoVjQ0M2hYdzJjRXlBdGppMFNnNGNmQkoyQUdr?=
 =?utf-8?B?MlpTNUlaRDlTeUMrR1B0a3RvSlNubTlqL0h6cy9oUjRGSDBBWEo0bTVIenVS?=
 =?utf-8?B?dFhWWlg2c0ZLT2V1VzBqTXU0dmtqNjdhUTBWZlJTM0FCbFdVVzdLL040c0px?=
 =?utf-8?B?YWdsYkh1Yld2dnFPREMzQWNPdGdtY2Myakp6SkN4bnBtemp2aTVjWEtFKzZP?=
 =?utf-8?B?eHRKZXNxaFJqdnhDQVJnS0JKS2xtMldLV3B4RmNZdHRlNkhLU1pHWEYrUUxz?=
 =?utf-8?B?Z0ZJMXh0cCtwY1A0TlRuUCt4MlBGMFpCZjd0YmQ4S2thZHE0aFVJd3dDbG5v?=
 =?utf-8?B?eUhlejlFN29qOXJYT0FYU21JdjJwejBDcnBZbGpiNWdEYmxNVWp2eFZkWjNl?=
 =?utf-8?B?ZXlnKzJGYTRyN1p3Q3FRaGdFZlZ3Rmh0WU9aeDNoVHdMd2hReTV5M1d6VENP?=
 =?utf-8?B?U2NDSXRWaGxnOFFDVTE5TTI4aGdnekJyb1ozWUhzS1JDNG1xblFiWXJNRTBV?=
 =?utf-8?B?SXoxQTVFWHVjcS9uTXZJYml1SGVsY0F3YVhGWFpMRG5JM3VWN2JTcDFJQ1hm?=
 =?utf-8?B?NVFjbSsxL0xsdUthZnRJYWFiRGhNNG4wb0p5U3owcEpBVzFhclJyaTNlWjNM?=
 =?utf-8?B?dWtXb0U4N28vU3NTNUl5V3BEUEhMZHlacTlyUmdmK1J6NVlGSVZwM05qMHUz?=
 =?utf-8?B?Z2dQVkNURzY5dUlXMG55MjFsVVVIUldPdmdiZkZpVldhUUlUQStFY2pjTS9X?=
 =?utf-8?B?TTU2M1A1eUtXTUl1aHpYaHZrQVFFWHppMkE1OVBWSHFPR2llMDhHOWZPZ3FK?=
 =?utf-8?B?WUIvZ3NPZ01Bc0thL2pJajQ5UXJVSTVPU2ZRM2JEZmlieUIzK0dHeGFmaC94?=
 =?utf-8?B?Qk1teFoxQTgyNTZmd2lZMHZlVVBiYkJyNDFRQ3pEUXJkL213cU01Y1ZRbjNJ?=
 =?utf-8?B?ZG0vU01RaDl4eU5XOG05V1U5b3VWWWRMbTdXbnkxOWtHaytWK3AwbkdmQUZa?=
 =?utf-8?B?eVpiS0drUkVkOFNPVDhmNUpMVGJ4bk13MlQxY0VheHdQdWxpYjRuSlB5Q05s?=
 =?utf-8?B?Y2pTYVUvdUxhZG1sWUVjRlVTNXdXMTNpeTR3aytEbFd2d0FkTllGYS9sU1A0?=
 =?utf-8?B?WVlqUVNTSys0Z3VGR1lMdkJVV2gwOXVuRVpPQWJmemhobUFrd2ZZLzkzSHIw?=
 =?utf-8?B?T2RJTW1xK3J5T1UyQ2swZTI2MWhOdUZneEk3bWZrRmZ0bGtZZElVRW5kcHUv?=
 =?utf-8?B?N0hYU3FXY1czRCtsZVRiYmVDdG11Z0IwMVdkR2MwelVpaDlQSEdlekZ1OG5t?=
 =?utf-8?B?N2IzbEhtRXVScEJmWVF5RWJieXV1dGV4eWYrUVJOTE9OK2hqdFo0aVV2ZnVX?=
 =?utf-8?B?VjZKZ3h6THQzakVTbW9jQmc2dTZqN2RJUkVsZ2tIWmp0V1Z2MDdwYWRyWFA3?=
 =?utf-8?B?b0t0NzdPUnFQbXhkY1VWOGppdWVRdGlTRkMwRjRXa0w5d3JWRkFQWU1PZ1hY?=
 =?utf-8?B?SEFFaXlhTEhpOWpOT1JoWlJmNDRPTzdiYzgrWDR2Q3Z1TlRMa0UzVWdnVVl1?=
 =?utf-8?B?MVRYQmtEaW5lZ01ieEZDa0lmUG16b080NmZsRmVvRkVveHAxZmd4aVZPbHJU?=
 =?utf-8?B?T2srV01QdGZRa1UvT0tlcHdrM2tneEtpdk9Id05Ta1Faa1Q2UjZwdG5Ebzhy?=
 =?utf-8?B?WkROYzZyUSt5SFFUa1o3ZndFNERKOWZYelNTRWNJK1h3U2ZvWWpZZnNBdXhw?=
 =?utf-8?B?K2kzRWdFR2tZQWRseWZHZC9VWHdKemNtR0NDb2NMUFF6aWhMOWY3dFd2c1pU?=
 =?utf-8?B?YWFMeXdQZGh3VGh6ZXE1eFZBc1Q4NzlGMG1kTUVaalh1d0doYkMyRFA4U0Vm?=
 =?utf-8?B?YWVGbTNkZ2c4YnhwYkVlRjk3VXh1ZzVmaXROdGZRMTIrOHFNOC9kd3prM2g2?=
 =?utf-8?B?a3pycXpRMzVOb1p6WVZQenB2cFQwQ2lxcGxuU1dqaWt0TVpvVFJKNTZkUnl6?=
 =?utf-8?B?RENZa1dpYng4aDREc0RYMGJnN2xLTGdNZ3hUSWIzalZKN0ptbUFjYU9XYUlV?=
 =?utf-8?B?bU9NZ0lhYmpteXc1Mkw2OTczZG0zRG0yUkhES2JWTlVwbzhZNFVMRG9jUjUz?=
 =?utf-8?B?NmlNQmZ6Q1plYTNPRWduWk1DWSttRlEvWVkvenEwNUEranE2U0wrN1FDam1H?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5641583FF095754488D27C82C3D01852@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da152a8f-bbe2-4841-caed-08dc62809d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 03:59:31.8964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9S8NLSYqm46+J2/DzYpY02LCRj+O87nuZslwREPxWQ4jDugfzU+bV2oEQeIxXXYAv6lbwn+fswj9Ij2PtfgqKKO7JOWsDykJmd9uRxhV+ncTV1EZHLk94HxLPAcl9a9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5073

SGkgQ29ub3IsDQoNCk9uIDE4LzA0LzI0IDk6MDkgcG0sIENvbm9yIERvb2xleSB3cm90ZToNCj4g
T24gVGh1LCBBcHIgMTgsIDIwMjQgYXQgMDY6MjY6NDhQTSArMDUzMCwgUGFydGhpYmFuIFZlZXJh
c29vcmFuIHdyb3RlOg0KPj4gVGhlIExBTjg2NTAvMSBjb21iaW5lcyBhIE1lZGlhIEFjY2VzcyBD
b250cm9sbGVyIChNQUMpIGFuZCBhbiBFdGhlcm5ldA0KPj4gUEhZIHRvIGVuYWJsZSAxMEJBU0Ut
VDFTIG5ldHdvcmtzLiBUaGUgRXRoZXJuZXQgTWVkaWEgQWNjZXNzIENvbnRyb2xsZXINCj4+IChN
QUMpIG1vZHVsZSBpbXBsZW1lbnRzIGEgMTAgTWJwcyBoYWxmIGR1cGxleCBFdGhlcm5ldCBNQUMs
IGNvbXBhdGlibGUNCj4+IHdpdGggdGhlIElFRUUgODAyLjMgc3RhbmRhcmQgYW5kIGEgMTBCQVNF
LVQxUyBwaHlzaWNhbCBsYXllciB0cmFuc2NlaXZlcg0KPj4gaW50ZWdyYXRlZCBpbnRvIHRoZSBM
QU44NjUwLzEuIFRoZSBjb21tdW5pY2F0aW9uIGJldHdlZW4gdGhlIEhvc3QgYW5kIHRoZQ0KPj4g
TUFDLVBIWSBpcyBzcGVjaWZpZWQgaW4gdGhlIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUNQ
SFkgU2VyaWFsDQo+PiBJbnRlcmZhY2UgKFRDNikuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGFy
dGhpYmFuIFZlZXJhc29vcmFuPFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0K
Pj4gLS0tDQo+PiAgIC4uLi9iaW5kaW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2NXgueWFtbCAgICAg
ICB8IDgwICsrKysrKysrKysrKysrKysrKysNCj4+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDgxIGlu
c2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2NXgueWFtbA0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44
NjV4LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hp
cCxsYW44NjV4LnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAw
MDAwMDAuLjRmZGVjMGJhMzUzMg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1sDQo+IEZp
bGVuYW1lIG1hdGNoaW5nIGEgY29tcGF0aWJsZSBwbGVhc2UuDQo+IA0KPiANCk9LLiBUaGVuIEkg
d2lsbCBrZWVwIHRoZSBmaWxlbmFtZSBhcyBtaWNyb2NoaXAsbGFuODY1MC55YW1sDQoNCj4+IEBA
IC0wLDAgKzEsODAgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1v
bmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6aHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwjDQo+
PiArJHNjaGVtYTpodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMN
Cj4+ICsNCj4+ICt0aXRsZTogTWljcm9jaGlwIExBTjg2NTAvMSAxMEJBU0UtVDFTIE1BQ1BIWSBF
dGhlcm5ldCBDb250cm9sbGVycw0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBQYXJ0
aGliYW4gVmVlcmFzb29yYW48cGFydGhpYmFuLnZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+
PiArDQo+PiArZGVzY3JpcHRpb246DQo+PiArICBUaGUgTEFOODY1MC8xIGNvbWJpbmVzIGEgTWVk
aWEgQWNjZXNzIENvbnRyb2xsZXIgKE1BQykgYW5kIGFuIEV0aGVybmV0DQo+PiArICBQSFkgdG8g
ZW5hYmxlIDEwQkFTReKAkVQxUyBuZXR3b3Jrcy4gVGhlIEV0aGVybmV0IE1lZGlhIEFjY2VzcyBD
b250cm9sbGVyDQo+PiArICAoTUFDKSBtb2R1bGUgaW1wbGVtZW50cyBhIDEwIE1icHMgaGFsZiBk
dXBsZXggRXRoZXJuZXQgTUFDLCBjb21wYXRpYmxlDQo+PiArICB3aXRoIHRoZSBJRUVFIDgwMi4z
IHN0YW5kYXJkIGFuZCBhIDEwQkFTRS1UMVMgcGh5c2ljYWwgbGF5ZXIgdHJhbnNjZWl2ZXINCj4+
ICsgIGludGVncmF0ZWQgaW50byB0aGUgTEFOODY1MC8xLiBUaGUgY29tbXVuaWNhdGlvbiBiZXR3
ZWVuIHRoZSBIb3N0IGFuZA0KPj4gKyAgdGhlIE1BQy1QSFkgaXMgc3BlY2lmaWVkIGluIHRoZSBP
UEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbA0KPj4gKyAgSW50ZXJmYWNlIChU
QzYpLg0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSAkcmVmOiBldGhlcm5ldC1jb250cm9sbGVy
LnlhbWwjDQo+PiArICAtICRyZWY6IC9zY2hlbWFzL3NwaS9zcGktcGVyaXBoZXJhbC1wcm9wcy55
YW1sIw0KPiBDYW4geW91IHVzZSB0aGUgc2FtZSByZWZlcmVuY2luZyBzdHlsZSBmb3IgYm90aCBl
bGVtZW50cyBoZXJlIHBsZWFzZT8NCj4gDQo+IA0KT0suIFRoZW4gSSB3aWxsIHVwZGF0ZSB0aGlz
IGFsbE9mIHNlY3Rpb24gbGlrZSBiZWxvdywNCg0KYWxsT2Y6DQogICAtICRyZWY6IC9zY2hlbWFz
L25ldC9ldGhlcm5ldC1jb250cm9sbGVyLnlhbWwjDQogICAtICRyZWY6IC9zY2hlbWFzL3NwaS9z
cGktcGVyaXBoZXJhbC1wcm9wcy55YW1sIw0KDQo+IE90aGVyd2lzZSwgbG9va3MgYWlnaHQgdG8g
bWUsIHNvIHdpdGggdGhvc2UgZml4ZWQ6DQo+IFJldmlld2VkLWJ5OiBDb25vciBEb29sZXk8Y29u
b3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KT0suIElmIHlvdSBhZ3JlZSB3aXRoIHRoZSBh
Ym92ZSBjaGFuZ2VzIHRoYXQgeW91IGV4cGVjdGVkIHRoZW4gSSB3aWxsIA0KYWRkIHRoZSB0YWcg
aW4gdGhlIG5leHQgdmVyc2lvbiB3aXRoIHRoZSBwcm9wb3NlZCBjaGFuZ2VzLg0KDQpCZXN0IHJl
Z2FyZHMsDQpQYXJ0aGliYW4gVg0KPiBUaGFua3MsDQo+IENvbm9yLg0KPiANCj4gDQo+PiArDQo+
PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIG9uZU9mOg0KPj4gKyAg
ICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxsYW44NjUwDQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsg
ICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLGxhbjg2NTENCj4+ICsgICAgICAgICAgLSBjb25z
dDogbWljcm9jaGlwLGxhbjg2NTANCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRlbXM6
IDENCj4+ICsNCj4+ICsgIGludGVycnVwdHM6DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAg
ICAgIEludGVycnVwdCBmcm9tIE1BQy1QSFkgYXNzZXJ0ZWQgaW4gdGhlIGV2ZW50IG9mIFJlY2Vp
dmUgQ2h1bmtzDQo+PiArICAgICAgQXZhaWxhYmxlLCBUcmFuc21pdCBDaHVuayBDcmVkaXRzIEF2
YWlsYWJsZSBhbmQgRXh0ZW5kZWQgU3RhdHVzDQo+PiArICAgICAgRXZlbnQuDQo+PiArICAgIG1h
eEl0ZW1zOiAxDQo+PiArDQo+PiArICBzcGktbWF4LWZyZXF1ZW5jeToNCj4+ICsgICAgbWluaW11
bTogMTUwMDAwMDANCj4+ICsgICAgbWF4aW11bTogMjUwMDAwMDANCj4+ICsNCj4+ICsgICIjYWRk
cmVzcy1jZWxscyI6DQo+PiArICAgIGNvbnN0OiAxDQo+PiArDQo+PiArICAiI3NpemUtY2VsbHMi
Og0KPj4gKyAgICBjb25zdDogMA0KPj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRp
YmxlDQo+PiArICAtIHJlZw0KPj4gKyAgLSBpbnRlcnJ1cHRzDQo+PiArICAtIHNwaS1tYXgtZnJl
cXVlbmN5DQo+PiArDQo+PiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4gKw0KPj4g
K2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRl
cnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dw
aW8vZ3Bpby5oPg0KPj4gKw0KPj4gKyAgICBzcGkgew0KPj4gKyAgICAgICNhZGRyZXNzLWNlbGxz
ID0gPDE+Ow0KPj4gKyAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKw0KPj4gKyAgICAgIGV0
aGVybmV0QDAgew0KPj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MSIs
ICJtaWNyb2NoaXAsbGFuODY1MCI7DQo+PiArICAgICAgICByZWcgPSA8MD47DQo+PiArICAgICAg
ICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4gKyAgICAgICAgcGluY3RybC0wID0gPCZl
dGgwX3BpbnM+Ow0KPj4gKyAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmZ3Bpbz47DQo+PiAr
ICAgICAgICBpbnRlcnJ1cHRzID0gPDYgSVJRX1RZUEVfRURHRV9GQUxMSU5HPjsNCj4+ICsgICAg
ICAgIGxvY2FsLW1hYy1hZGRyZXNzID0gWzA0IDA1IDA2IDAxIDAyIDAzXTsNCj4+ICsgICAgICAg
IHNwaS1tYXgtZnJlcXVlbmN5ID0gPDE1MDAwMDAwPjsNCj4+ICsgICAgICB9Ow0KPj4gKyAgICB9
Ow0KPj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4+IGluZGV4IGY0
MWI3ZjIyNTdkMi4uMjE3MjQzMWExOTM1IDEwMDY0NA0KPj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4+
ICsrKyBiL01BSU5UQUlORVJTDQo+PiBAQCAtMTQzNzgsNiArMTQzNzgsNyBAQCBNSUNST0NISVAg
TEFOODY1MC8xIDEwQkFTRS1UMVMgTUFDUEhZIEVUSEVSTkVUIERSSVZFUg0KPj4gICBNOglQYXJ0
aGliYW4gVmVlcmFzb29yYW48cGFydGhpYmFuLnZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+
PiAgIEw6CW5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4+ICAgUzoJTWFpbnRhaW5lZA0KPj4gK0Y6
CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2NXgu
eWFtbA0KPj4gICBGOglkcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC9sYW44
NjV4LmMNCj4+ICAgDQo+PiAgIE1JQ1JPQ0hJUCBMQU44N3h4L0xBTjkzN3ggVDEgUEhZIERSSVZF
Ug0KPj4gLS0gDQo+PiAyLjM0LjENCj4+DQoNCg==

