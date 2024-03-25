Return-Path: <linux-kernel+bounces-116480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00386889EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691AF1F376F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA37174947;
	Mon, 25 Mar 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Jo+B4Us5";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sIyj1DpO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EF13DDD7;
	Mon, 25 Mar 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350646; cv=fail; b=lK8NwbwU2O1h3qZo0pQrmtGkdLt8KP2IINoeUHkGi3mrNCLiDu92rWigF91A11YXFqcrOnrj41BSvQDoSrM9oYpH5x9IBgmIRClRTfPaE1Rx7ZA65AA8BPe5eakHnOpGq/cxSnFy4jxvtzQDlEhopgiF8IyNXPr08PM4NJEz1x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350646; c=relaxed/simple;
	bh=7LloCdrMGLGxRS9RhEW2FsKQJ/xPgZEw7WIwkPx77KI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a3gny2VwzqbbUDTXDzRr24ZdblgSZRdgb8f3a2Amg7+PXDv5pTFFxu12ToDL0KyrdmaSA21MSTH885L8BKbibolT9CJzQIjcYVixj6lfsIYEBuHpoKv/VSUXN1Uja8hw0XUGDj+cpvqKKFPKAW3M/AOEfYKarmnRtEth2YxqmE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Jo+B4Us5; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sIyj1DpO; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711350644; x=1742886644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7LloCdrMGLGxRS9RhEW2FsKQJ/xPgZEw7WIwkPx77KI=;
  b=Jo+B4Us5kOEuMilahSB7wuA+e2vnmpvIEfppgTb+6Rfix6Ry1TGHH4P5
   EjKXYbqeVcZBU7lVpm/9krT1BxRvS1R1cB+3bBD4LyzsmN65D/6cvuuKJ
   oHwp4lRImc38exl+H7ouxjU2wKRJsnpkeR19+B7RCdyAlG1iWLCt5IIy0
   YNdxjjPxVbxMVSyjZEPWnCuZjeNwCPALcUbQEYvbaZOVMxtfbda152aHT
   /P7PstIm2lJgUo0JBOYGFeIxgbdWlwI4CkYbbBOZFi36DqkymXj/ZsbOu
   HSXTKxNnsP17uTi73OuNgkT08tm2iouMS8kJ5mrJy6uVc1F6U3WQp1yqa
   A==;
X-CSE-ConnectionGUID: +2YOEnfMRz2YT+Yw1nuW/w==
X-CSE-MsgGUID: InFpLJFMTQ6OeZWALQeDMg==
X-IronPort-AV: E=Sophos;i="6.07,152,1708412400"; 
   d="scan'208";a="185376440"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2024 00:10:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 00:10:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 00:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLvQF597i1GlPZqK3740XnuOX3idv1Q4DSTVb2ow4PLU/vgyprhM3sQ/1rXYolCDn2vstBSKPvmFLlrY8jpcupomsxnvFCvM5xeU2w/3ORLcC9aV9SrDnI7OSj7ROOVFqO1WDRpNQsNOZcwDRFlpuR+OlqF6Ez29pGza+cHm2NsKmTsPINDjoa9v9nFWJDOSRWpVUYLPi29FO/PRKFLg2qi/IwuesbaZLWar+e0MNthT58AEOZMstFHVjlXn//c5mHPwrfStq+pT+1hoeDHUNTHSY3u1B/NC2B8LN0Q6PWeBOgxCUcnXEF3FbsknQceQprgpS/z/M6F1SYLSHOvk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LloCdrMGLGxRS9RhEW2FsKQJ/xPgZEw7WIwkPx77KI=;
 b=mua1CKo+Ujth9vG9lz2b4wFkuFl9OFi+qx6uPDEn+ma9n1h6aP33Ip44HkPFa9wwaAKR62VAoSzPo5zWME0e5+cttiYjwCQsEON+AVBzsrCYjuDw0IjFXw+dNJfh+kyWOELKJx8cB/TIMT1NW5RoqyaKk2ZspvT0VgWTbt8HFmhZkgMOOUGfCpLjdT2tA2lx5ZWDd8vOhyH0w+BsdIPMzp2SMOqjEIRg6Jj6b6P3JJ625If+a5o2QdpamVcz6ga4aXgx7duwgM7caQVTK3NBNCVPTNgjj0jFixEzDRJrKUl53IdOC/6WA8Ke1IDIhUttkCldH5OLseZISfPYaP+e4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LloCdrMGLGxRS9RhEW2FsKQJ/xPgZEw7WIwkPx77KI=;
 b=sIyj1DpOvwupECmjsy/dFkitUcoFD0OICUwCVpqbWeUNxq0KRLFraIe1cXON2oOBliRUoseclO3C6LJe1OhdfnbRSwQ1oE+bUk0580YIqet5tHnLH7p4GAVnUkQ9/Ua+f6ztjebQwXIKrOWSWimCHpVC74TSmz5RxQeduy4cmHJJbJ8vW0RvPl0+QpOJHm3Cz+1pNtA/Z/gKijwpf1HRKdkkcfLwLxUhIAu5mSB/WtvWFn6E7Qn2drSu0JBEAOBIOaZXfJlLPSetq4kW8QJ9g0ZXseWY8jiP67Rimychj8BlQdk8pVZ8ndCE2KRawge2p5JQdHMP7IJ4ySzYAfQhdw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SJ0PR11MB4880.namprd11.prod.outlook.com (2603:10b6:a03:2af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:10:10 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Mon, 25 Mar 2024
 07:10:10 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <krzysztof.kozlowski@linaro.org>, <conor@kernel.org>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
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
Thread-Index: AQHab6Ox6ghenOTJpkWNbGLTwd03cbErBYYAgAAJFoCAAANkgIAVU1wAgAAUTICAAX1RAIAAAHgAgAA4LwCAADuQgIAA+O2AgAAKtoCAABfTgIABsrcAgALuXgA=
Date: Mon, 25 Mar 2024 07:10:10 +0000
Message-ID: <dc5b3a71-c1b1-4a9d-8db6-b179888917c6@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>
 <20240306-spree-islamist-957acf0ee368@spud>
 <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>
 <20240306-ripeness-dimple-e360a031ccde@spud>
 <05a9a7ee-e4f0-443e-9c8a-8ee649a11448@microchip.com>
 <2f384a54-74a0-4a75-a325-8985257b5d66@linaro.org>
 <ba37c212-fb98-407d-9bee-6d14801754d9@microchip.com>
 <96493beb-afbf-42f2-88f0-ad645422ecdb@linaro.org>
 <1735add6-4a6a-452b-bf26-1cf19c95493e@microchip.com>
 <20240321-upcountry-finless-b0e9b1ab4deb@spud>
 <13a28ba3-2da4-428c-8091-25e75c6c11e8@microchip.com>
 <d41a53bd-ea1e-476a-a18c-ed51dbac0a98@linaro.org>
 <b3c5d217-a5e3-4957-884c-02e8c10aba9d@microchip.com>
 <703de50e-f271-4e65-bda4-85b1835afa6e@linaro.org>
In-Reply-To: <703de50e-f271-4e65-bda4-85b1835afa6e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SJ0PR11MB4880:EE_
x-ms-office365-filtering-correlation-id: 4b2938fc-778e-486c-87f9-08dc4c9a9c01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZeOKY+PSFijSlC2U5jCvXMLi28GwlneODQ01PPpccIHnfMf9HvRgzw/6mTtUOUGXQhNTi+Z3dQO5kf/Gw3PtqqEQ6Mfb2pWoXSm1vQKpoGh40hJQRTLb1WSSoKmuQfpHpAO89jC2GszWjqyYEnpPL6at/cAIXXn/dWPvMN7XKN9ot2z3G+jhpKMybVLtXnvUvZmdFmxfMshVLDXHIAIqgxTf/YNw5VXmMLuTJZJRoE5hnxH3P/ikOgwp9bt56wxESS2E/usSO12w77t/Ojz2HyaIRyB6tTvGTrViECw3ClpW8+AKqHnknd+N7g4Q64rMx25DQw9CwvuK7j4avxHjoBIs92iK3jCragxgYuICTIN2D2Ue5f2Ync6vPD+WRfW0Tkot63M/CzmG1HKzq8enRehwbyP8bVR3+20YoqW1uaSnYJ9mnK1VK6XBl5cQECfK0JBER3mUdovwIsV6dTTC1y9YOW27p4zLxlJehkswrCZxnW4yUkdN4i4r/ZFyIkTKvtAfHbRLPkSx1v6BU/yKFAn+BR8cytbrMnxO4dRfCfsetlSEs14fgdpPa+wS4PCuiUvEQr4Bgsj3NSeVmblZHZMprylsMoquKMFvpAEMWCKJ6bzV108DJ5E4dy21eRPoQE8L7IX4zocpJV6kKMkPK1Zhja7g3Vn+9T6nOD1JnHrYsnnGI+Xo40zlrfbtgmgXVg9L+D8RjnHcM+a1BErKXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlpjMjBFdnR1YnVoWEN0Z3VZUVFSM3J2RWJTRW5HdzlOUUxFUHZRYytGVndK?=
 =?utf-8?B?WW4vcVAzb0pYNHd1WXVHVGhueUpESWo3ODdvcnhXbERXbm13cXpJek41Z29S?=
 =?utf-8?B?MzhqTXJydjE2S1NLenpTZzJSc2laZHM0VE81WGFlTzZyQ014RzlUMlorSDBX?=
 =?utf-8?B?Vm5rdkFrRlRsV0VvVlhUeVRGMzR4MXlXMTd6SWsrNVNveS9jRHZvMmk3TWV5?=
 =?utf-8?B?RTBMSlBMNFlWSTZwWkRWZWg4dUVmb1BPNjdSNUZYZTJWeE1WSVNOc3FKZDRn?=
 =?utf-8?B?QnpwNUNxbGlydG1SekxUZ3ZtTkFORmNQeDl2bVVqaGJ2cXZlQ0krOXRBSTJG?=
 =?utf-8?B?ZkV2ZmcwWTFOamVvSm9YL2haM3R2Z2UwQ0J4eHRHZEZxMDBUdTBhL0Uwc2xV?=
 =?utf-8?B?cVdvMUprTFNZTFRmemNOT001RTg4TTJDSXNzMDBZZTN2UU9QWDFYekF6Zlp6?=
 =?utf-8?B?MitGTlorT29ESVVRL29NSVk1RTY5T3I0MXIxQ0RNVlk5NWt5ZElmTnduR2tF?=
 =?utf-8?B?RjBqaFZiUFRFMm1BVGJGODR2cUZMcXcrak1ldEFNaXZ0Z052dzZOWmdGUGxU?=
 =?utf-8?B?d2cxT0lJMHA5MzU3NmVXK0JnL1dpS2hjWlp5cXFTTXh3V1RUWXhFclU1bmow?=
 =?utf-8?B?ZjdCSTJlQXFGanBnVUlmMng4N3VCK3dwcVUrSVVPTVp2RmZqdkJZYk5YNEIy?=
 =?utf-8?B?cklDS2xybHpSd3pGMHVmdmpxRkIzcUF6R1J5d05sWGxoTVQ4alBUeWZNejY2?=
 =?utf-8?B?d2xUNFFwYUZJdktaeUJ1cjhaNTcwcTJQNW1qYllvelR2RVpuS3pZdXYyaGJO?=
 =?utf-8?B?ckE3WkVJZUpYZjJrNmMvbjVia0IrQ0NjYjhSWm1OL3l1bHFReW45Tk1ZSjJ0?=
 =?utf-8?B?WHRzTXNzMG0rYkhQWlZmeXZBcytqeSt4SHdBMktLY1FVQ0E1T2g5M1g2VWc2?=
 =?utf-8?B?OWRrWXdFYitRKzdFQ2JIU1dRcXdiOVZ6SW9lb2NxUFg1UGxFT3YvMHEraWtT?=
 =?utf-8?B?SUZKQnhUdVJhWXlkWHpNVkFzNFpDSURlcjE0eVM3bVFlMXNJcDkxZGNwSDJI?=
 =?utf-8?B?VVMyMHZvTHhhZUVjdlR2Wk43L1hVRVIwTllWTDZnS21ZVWJwT0N1NjFqcVl1?=
 =?utf-8?B?czkxSE1ZN3lTSTBGZGwxcHJ6di9oZG10NU1Xc3pNdGU5Rk0xekNKdEI5V29R?=
 =?utf-8?B?cHpGTUxHRmxwWHpFVEdKbU0zdkxMbU84ZGJTNFRaYmcxdmcyeCs4NDdpeEk2?=
 =?utf-8?B?dWR5Z2hJZnhuZXZFWEpmNnJpZXlkUGRMSXRGL3FmRFdvRW0yc1djNEVTOWIy?=
 =?utf-8?B?T0crMkJoN2pxWG1sZElES2NrM1ZiSHNWTjFTeVBoOHA4V1dJemI3Zk5ZNTBu?=
 =?utf-8?B?NjdGNkIvNTBQVk5tNVQwRjV5QTY4eStFZlpLa3hOVkRHeFRJVnlzZ3k5N0hD?=
 =?utf-8?B?a2R0RU01Q3hEZXA4NkFJRzU2MVNDN25ZcXVDdkI3YnhVN1JuMS92cTVjNDh2?=
 =?utf-8?B?RVhkL1ZxV0hTZFJJT1lZL2Q4NHdicFZ1YVREazR5UDA0cTFYOWNsLy9RU3Bw?=
 =?utf-8?B?d1ZBbXhqVTEwQVVVaDhTT1R5YVUzT1NhSTRqMkJjbEdieTN2b3V0eC9Qd2R1?=
 =?utf-8?B?SVljNUpySVVmQjdBRVZxRm9UM1R3bWtMaUpyZGswb1JkMmhNcGNLTHh4Y281?=
 =?utf-8?B?OUN6VTQ1bGVGTk9CbHh0Um1Ndko1OU5OaVJZbVJqTjF1R01ZeVFOM0gxdlJl?=
 =?utf-8?B?Y3lHL2dXVEZuVHZ0dWN0cU1vR1oyNkZvOVFXSkF6aU9hUGs5MnVUSkl5NkFo?=
 =?utf-8?B?YndpdDdHd0ZvTUprUUNQd081QlIvTlZNbFhjOWdJWHRUdm1BZitpUFNENms5?=
 =?utf-8?B?LzV5SFlOcGllT2NtbDh1bVVhN04yMEhJUXFLMzNYd0dvQlRxU0U2S3FHRWha?=
 =?utf-8?B?WVBPbllNQXdPdkJtdTdJeEcvSGFjS283ek1PbEg1MVpOQ3NsVVJLWEs5QkNl?=
 =?utf-8?B?LzZhYnJodytTbVYvNVl1NVdrNm5OUklieU85a005V0I3eFV3bFJEb3NPQVps?=
 =?utf-8?B?RnUrVWlsMlBZQUVsNFJSRlEweXhZV1NmdmMwME5NM3dqRjRIdXN6bTJDTytQ?=
 =?utf-8?B?VFpHL1BkcnpEbmNjbVdNUjBMNFNoZDZRR2hMZDlPbUdGejV4VGxLc1BzK1NX?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <497925E795831946884E5C3764F73E54@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2938fc-778e-486c-87f9-08dc4c9a9c01
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 07:10:10.5384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NY/VvPf3Cpt/4gefXi4MwWhPQlsRTnPthig7y983S6GkcS/s+FOPaoLm9143blIBvETd6eaYqD+KO7J1hv41bnHqiCpSRt+f6fBH0NZkBZgo97h5/OqBWrlK9EmmbGp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4880

SGkgS3J6eXN6dG9mLA0KDQpPbiAyMy8wMy8yNCAzOjU0IHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIy
LzAzLzIwMjQgMDk6MjgsIFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4+Pg0KPj4+PiAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbGFuODY1MA0KPj4+Pg0K
Pj4+PiAgICAgICAgICAtIGl0ZW1zOg0KPj4+Pg0KPj4+PiAgICAgICAgICAgICAgLSBjb25zdDog
bWljcm9jaGlwLGxhbjg2NTENCj4+Pj4NCj4+Pj4gICAgICAgICAgICAgIC0gY29uc3Q6IG1pY3Jv
Y2hpcCxsYW44NjUwDQo+Pj4+DQo+Pj4+IEV4ZWN1dGVkIGR0X2JpbmRpbmdfY2hlY2sgd2l0aCB0
aGUgYWJvdmUgdXBkYXRlIGFuZCBpdCB3YXMgc3VjY2Vzc2Z1bC4NCj4+Pj4gSG9wZSB0aGlzIGlz
IE9LPw0KPj4+DQo+Pj4gVGhpcyBpcyB0aGUgdGhpcmQgdGltZSB5b3UgYXNrIHVzLiBOb25lIG9m
IHRoZSBwcmV2aW91cyBjYXNlcyB3ZXJlDQo+Pj4gYWN0dWFsbHkgdGVzdGVkLiBNYXliZSB0aGlz
IG9uZSB3YXMsIG1heWJlIG5vdC4gSSBhc3N1bWUgdGhlIGxhdHRlci4NCj4+Pg0KPj4+IEZpcnN0
LCB0ZXN0IHlvdXIgY29kZS4NCj4+IEFzIEkgbWVudGlvbmVkIGluIHRoZSBwcmV2aW91cyBlbWFp
bCBpdHNlbGYsIEkgdGVzdGVkIHRoaXMgY2FzZSBhbmQgdGhlDQo+PiBwcmV2aW91cyBjYXNlIGJv
dGggaW4gbXkgUlBJIDQgc2V0dXAgYmVmb3JlIHJlcGx5aW5nIHRvIHRoZSBjb21tZW50LiBUaGUN
Cj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCBob3cgb25lIGNhbiB0ZXN0IGJpbmRpbmdzIGFuZCBE
VFMgb24gUlBJIDQuIFRlc3RpbmcNCj4gaXMgd2l0aCBkdF9iaW5kaW5nc19jaGVjayBhbmQgZHRi
c19jaGVjay4NCk9rLCBtYXkgYmUgSSBoYWQgYSBtaXN1bmRlcnN0YW5kaW5nIGhlcmUuIEV2ZXJ5
IHRpbWUgSSB1c2VkIHRvIHRlc3QgdGhlIA0KZHJpdmVyIHdpdGggdGhlIGdlbmVyYXRlZCBkdHMg
aW4gUlBJIDQuIEkgdGhvdWdodCB5b3UgYXJlIGFza2luZyBhYm91dCANCml0LiBJIHVzZWQgdGhl
IGJlbG93IGNvbW1hbmRzIHRvIGNoZWNrIHRoZSBkdCBiaW5kaW5ncyBhbmQgZHRicy4NCg0KJCBt
YWtlIEFSQ0g9YXJtIENST1NTX0NPTVBJTEU9YXJtLWxpbnV4LWdudWVhYmloZi0gDQpEVF9TQ0hF
TUFfRklMRVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAs
bGFuODY1eC55YW1sIA0KZHRfYmluZGluZ19jaGVjaw0KDQokIG1ha2UgQVJDSD1hcm0gQ1JPU1Nf
Q09NUElMRT1hcm0tbGludXgtZ251ZWFiaWhmLSANCkRUX1NDSEVNQV9GSUxFUz1Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwgDQpkdGJz
X2NoZWNrDQoNClRoZXkgZGlkbid0IHJlcG9ydCBhbnkgZXJyb3IuDQoNCkJlc3QgcmVnYXJkcywN
ClBhcnRoaWJhbiBWDQo+IA0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+
IA0KPiANCg0K

