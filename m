Return-Path: <linux-kernel+bounces-160043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95E8B3838
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27F41C2224B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE001474CA;
	Fri, 26 Apr 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qa0xInMO";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KxtFJ9dr"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79C14534D;
	Fri, 26 Apr 2024 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137593; cv=fail; b=hbG0aFLNArItOOzZgLvf6WZqPQrvPv2U83GACPMrbPtyZCWDyZJghOsWYkYM2Rk0UlgDcIEaAv6LGOwHzfPBJZFkbIgXFvNSbU+yV/e/ziQr0Sr8JrxTXI1qASwlMRW7wKypWKpbhQdUINRIfRO/J7aRRAyISfJ8yLqKq37P6pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137593; c=relaxed/simple;
	bh=0UZCxyUAN21dXoUZbeZhfYr3hXWuS8XfQJ2J5XCYs10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bu+V1cVmOPo4EfRKF6WYNE6oUsitTRQ3oH3gWBNPXsUuWd36VWDDHtAsfK0xxSi0t9dWrBVJLzhO+ix8NfQ1TleXHGrThLUNML/Qbi/nXZtoXQwkK/yQeZNLdbi7+w9K4RxvCK6OcH1dmMwfLWLWbIiMiv7G3fWvzfFImltMego=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qa0xInMO; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KxtFJ9dr; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714137591; x=1745673591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0UZCxyUAN21dXoUZbeZhfYr3hXWuS8XfQJ2J5XCYs10=;
  b=qa0xInMO86MpfwIVKkxOQqFJFY+/Q9RJZK76n4+SM5Wl33g9X+F4yzuv
   D2k7ifMZlV1WgueqFYnMgaaSS81zCXvdSRMQzeGj0stK8+qshqBxir5qs
   H4KINnpzdtRDhyzi6XXzquQ1RaxDi7JrW/WPvBy1liC3u6Copbz8OPhRD
   gJN0sMbkP5O2WeK+29DFmdG/koNzcEgYx27ZeN0J3KnzV4gbq5rAaZBGw
   EvuoznbGIUidNcZwQHNxwNj7/62moVGqawT+zlXIZEeagOpz5Pp6jidUn
   MvlDQOC350i6yi6dtk6QHHr95s6rZy1u1FQhnmrEBxusGZzR0DxT3+g62
   w==;
X-CSE-ConnectionGUID: ZxQvaH2uSRKkgc9qDmHnRA==
X-CSE-MsgGUID: kUoI383OTvq8VK0CtLeiRA==
X-IronPort-AV: E=Sophos;i="6.07,232,1708412400"; 
   d="scan'208";a="190115797"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2024 06:19:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 06:19:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 06:19:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5mDIRxzKO1DpJWxdNPNS/Y0OHvOBAbI7XBgCe8R5rYySCdfbTALu9/FsmD2UIYCfI2W0maaYrn0sy1KueBkGYCnBLsIAU6EfonpX2B+K+gxoE+cEo+am0ZC6QhGBq1OjOLNkBsjWKyR3/pMLtesK/o9Sd380heAvWefqDIP/HeG2++RJXvL/O+wxkQgM6uZre7IrtU7WhLsYEo3ErjEcKuAUeKBy43zIeMCMNM64UAdeN8ejVOL1kSyHlEeJQNLaFxo1CIKV9+uTko8lRo5KafOsXw+11pLAd8FiQbogvXOK/EGwbFBHy5u4dvxhgL+duwJQK7pCrnMr+JqkTm2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UZCxyUAN21dXoUZbeZhfYr3hXWuS8XfQJ2J5XCYs10=;
 b=nY3a1/GoqUGfCBn/OCH1q0xN3rpIRdFBoJgN+aqHUphH30SR8JfTkezuGB8aFStCVAf8kmk0RkA6HoDafqCSUI2DRYMn1cY4/srXi8JdWjgxen7kvGJXtcQbuxp0BIJVCU1QxVZ/mVJ8NBadjT5mj3JSxl8tPonRmuVHtF+8ExN0ZEkTG1wSzm10Yzg6XfmKhw93F8keyiBHhiYYVQJnCsBRcMn46aW3p7ZDF8YVm+AN5cyYduSU5L/rnhREAZeUkBMSci73MXcQMEis1J84FSSOtdaQqdvic025u1BXyx4MvaKfa+A2nyrzPPXkQazcajG8o+33aaM2cnlznou4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UZCxyUAN21dXoUZbeZhfYr3hXWuS8XfQJ2J5XCYs10=;
 b=KxtFJ9dr8BoXNVr17ABGQqr0KhOIT605sbFzbQ4uCETAmJWFRFPpyt/7fEhOGioIE0fj+bw5NT+r1Kmjx22b3D3Sc8bIjIVlcI53fWNvWndBeGfwhURMCcSAhiFEiEn1Ak+ry0SiXoiSUSQfEtiDuR7rngwUbYHJ/wxNVPaGzYd5btO51wD30zYn/SWLzWhLZYA2gmhCodCMuU1UQhU93Fbe6fEp0u6ld96AWwY3zRMIlhnx2NqdmXoGANR4+gVDRtkN4+mtm3KAWtG3nCkVo5+uCaaI9Xd0etCQJnF0vCo0srGAXg4QMusO2pNU+mozjvaGN16ghRD/WTzo1Re+bQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.30; Fri, 26 Apr
 2024 13:19:41 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 13:19:41 +0000
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
Subject: Re: [PATCH net-next v4 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Topic: [PATCH net-next v4 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Index: AQHakZAdlrQB9OyLIE6rMN7WNIEkiLF2kk8AgAQDc4A=
Date: Fri, 26 Apr 2024 13:19:40 +0000
Message-ID: <d8ccfb7a-5ff4-4a27-b027-2d73171b39c8@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-9-Parthiban.Veerasooran@microchip.com>
 <460a42cf-2b67-49f5-be4d-fcce6c824ba6@lunn.ch>
In-Reply-To: <460a42cf-2b67-49f5-be4d-fcce6c824ba6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW4PR11MB5892:EE_
x-ms-office365-filtering-correlation-id: 3ca727ad-2fa0-4372-869a-08dc65f387d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QUxmdWlYRW95aHloaTNCc1gzWVFwOUNHZERsMk9VOHVCREdEMkhDa25jOEsx?=
 =?utf-8?B?N2V2M2RTSFZ0TE9rOURlOUNzV3VJZVpGUlphdG9ZRENJR1RlUm1ZdzJkSHpE?=
 =?utf-8?B?WWcrMEV2WjFXQ1VHT1o2Q01tQmdmdDlaZ01CUm5sNG1jQ0pZbGNaZjBTNmNa?=
 =?utf-8?B?RTlrSUFWVmp1dnM2bElCU1pUbjhFWnphU2wvc2ZSNGJRS2hzM0txS1A5UWUx?=
 =?utf-8?B?RjJoeTZmdS9vbWh5TWNCR2pJRE9sS3ZuSFBBMEM3YUZMRUxTdi93blV4V3lk?=
 =?utf-8?B?MkwzUTduV054bSt2REQ4dFlnVVd1OXBzREc2YWRIaFd2amN1amZOZVEySTZU?=
 =?utf-8?B?R1NHeU5JbzRuUVlnQkRCMXM1SDRoMlNLdzhldDVFQ211Skt2am5lRitLelY3?=
 =?utf-8?B?TmhFVUtVOFEyRVZDeE9OR1JKRjJhM1k1NXEvUVVWcHRtblhKVnpwTWNMMyto?=
 =?utf-8?B?dlZZYlJJbUEzRUIrS0wrK1dmY2NhK2RyMFJIMXNVL1YraGltcUJzZk5wbEs4?=
 =?utf-8?B?aE8ySnJJdDVmdU5mSzU1S1Ntc2lsc2Y3cjB3eFdsZ2VIcVdCK3N6UjNtWDVv?=
 =?utf-8?B?OVZrRXZEbUZ4aUsyY3o3TEdDcEJzZmRmdzR2T3NHalNmSXVpVWFmc1ZXeVRN?=
 =?utf-8?B?MHNCaWM5UXFkaVJpaHU0NzI0Zy9kQkZyQnUvOVpYaWJ4emVZN2YzdEVwNmpk?=
 =?utf-8?B?OXBwQWIvSVFiV2E4eElzUEZpRFRCdG0rdVpzUXpydzZEYXRmTVVIR3hmb3I3?=
 =?utf-8?B?dlJreWsxZEpXTWY0bnI5Zzk4MFNnUFM4YWlEeHU2UWJyUGdZMEZQaXJSVDV1?=
 =?utf-8?B?RTBMcXphNkRsZ1BqUllQbnRkcDlSdXd3cjk1b0E1OFpBR2U4T01CQWdxMWts?=
 =?utf-8?B?RjIwVVpCN3NmT2QyVkdpU0wxTjdHWk00cjFsM3FraGpOZHE1cGxHdTRPSHQr?=
 =?utf-8?B?OUpJZmNyWHRndTNrdVZFWE8vNXdnNUMvYlozNmFnMWl1V3huY2dBa2JyZUJM?=
 =?utf-8?B?dW80eWR0V1VCaExBWkFzQjJ4MkFwc3Z6ODlCemg1bjJpWWxyTVlLS2cza0Vi?=
 =?utf-8?B?VmhNa0hGZnBWZXJaaXZmQ1NtQTFuS2RnaUxoc1FNZllWaWV2MG5YU3JudUhO?=
 =?utf-8?B?VHRMdU1uSXgzZEVseWFRY1RnTGRhT25tNVMvblZMYUszeW1wVXRyd2ZIMjV6?=
 =?utf-8?B?SWZJZ0lXQjcrWjhTTWxCS0ZMK2g3YkhmaitlMndZT2hXRS9TaWJKSGcrVzFk?=
 =?utf-8?B?N3hZRjhWaHJ1ZlZFSHB1b0FYcU9uM3Y2TkhGejR1RitmbXRtS1pYQW0yWTJT?=
 =?utf-8?B?Q2pPNnRlL3VuM1I2VzRnbmg4dXRIeUhHMWY0STdvcm96a0pqSkFvMFJ2UG0x?=
 =?utf-8?B?dFNjZ2dBY2k1c1dhUDFkdzJaamNCemRhTEU4aGh0aFV6cHZNNUFteGxOYUNr?=
 =?utf-8?B?dG5mckN6OVMybDBuMmtWQnNOQmlRNFQ1WGl3dUpIalhqOUVwZDMrQytIb21a?=
 =?utf-8?B?TnJoaVBSdTNnY0VPdjYxSmFPWllpVmdUUlY4MWNqVDloWm5OL284T3lsamZR?=
 =?utf-8?B?c0pmWkdPVkZVSmVvR3QxTmMyR2p2OTF3bHc4UWlURitXN1pvdlZtbCt2S09T?=
 =?utf-8?B?LzlqUjRzWi93T0lFRXFicHkvQTRtU3BxUVlCd2Z2cmQxVHhIQWwzLzZSeExE?=
 =?utf-8?B?cFIyaUdHbGdKZENBNHdWbGhCTDZjTllVN1ZGOXR3bkJ6MkllT0dGMGNCcmo5?=
 =?utf-8?B?cWQzSGpSWThxRGI5Vm1ra3ZjbHgvYkdJMnJva0Q1cXBlVkRsa2tTSkl5Mzlj?=
 =?utf-8?B?Y2R1LzFyREVTeXoyUjNsdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE0rSDA2N2twc1pzZlJjWWlYVzg4a0ZnZFZkN0NKNDlJUzdIbS9pSXZDc0pu?=
 =?utf-8?B?MUt3Rml4STc3cm81WDdORXQva2grUlJMejBDalF3UTAySU0raDRPbzdyMjl3?=
 =?utf-8?B?eHJqTzh6SGd0cU5sSE1yay90UWhreXNCYUlVVFo3WVEySWljcVhpOElxMWxw?=
 =?utf-8?B?QmlEQ2lySys5MjVMQnNESmhhUmZoYXFpS2kzVlhNWEJudzNCc084aWU3aFli?=
 =?utf-8?B?QldWQXJxUjJUTDBGNEVCREVSNDVjcDg0N1Zrbm9oSmVSeVVRcUJCUFp2SU1C?=
 =?utf-8?B?M2pMZlU5WFBDNUJxcVVpZ3hDWGt1NmRtei9UVnhLSUNpdWxaV2NaenFyTVV3?=
 =?utf-8?B?dUlXdTVoVnFRaHh0WnQxamFkYXIvQ2hzTUhzQVJMUldWam1jYlRzcXdLVUxv?=
 =?utf-8?B?K2pnd004bDhKTnBIbzNadHBIalpQSmxWcWViTVh0TU5XMFQrQTVROXBXUmlP?=
 =?utf-8?B?SktISXpvN3pKR283ZDZBcHZUU2M3UEJkSEMzcmhTTUk0czkxcGROVFRnSGUw?=
 =?utf-8?B?MjBvVS93WEs2TEIrUVlHK2ZNM2FTM3VZQjMxZThpZk10R2V5MEQrUStlU0tk?=
 =?utf-8?B?cHhNZm5HcnRDOHN4YmhwRWFXWTZRRDBOdjVoK1RVb3hpTEF6S1NBazNnMTFa?=
 =?utf-8?B?ekNSaGVWSnU5SkZHYjFJbVVJdFd0N3p0UnNWVlpRS01IMVJYTE1PVEZNajNC?=
 =?utf-8?B?RzZ3UDdaTjdJWjBUeTFFY1JUKzVwMjFabE8yTFhyTXM3MzNvM0kvckszb0pS?=
 =?utf-8?B?akphMTRHSXhqS0pRSFRkeDF0OTRXWVNJbGJZTUMrYSt2clNhbzBSMmJmZlM3?=
 =?utf-8?B?Q21rNTgxVFlwL3oyV3FZdWh2ZHhiUTFVaG52eW4yYzRpZk5MVWRyQVkrZWFQ?=
 =?utf-8?B?WExlQ0g4Yk9ZTGNGdEEzRkowTUR1NUNIWDltakhWMDVibENUd2ZwcU1vTVZZ?=
 =?utf-8?B?dDJ3Nk5XK1RYWi9pbDdWMDlSOHZQemx4S0Zxd2xtb09GdUdXblUrOWpUNG4z?=
 =?utf-8?B?WnFuSUdHZ2o0UU84SUtiNTRKc0I3azg1ODR3QTIwamF2YUg5aUtWdW0yeGFp?=
 =?utf-8?B?YjhNNlhjd00wZkFzUDY0d2Q1Vm9TcGxhdWEvTWxEWjZTNCtKblBTNldWS1BQ?=
 =?utf-8?B?UFJDYnFMV3ByTmM4OXdrc25Wbm9UZjkxbURPWW5mcEEzZU5ORXQxUjlOOTVQ?=
 =?utf-8?B?QlZLeHVkK20xQUVXZUM4RjcwY1NFQnR0dk0wTTB4K2EzSUpVVFVmeWVqV2Mv?=
 =?utf-8?B?OThVUGg5YlJVN2VaZS9KVGRTVFpnaDJnb0RwVUo1MUgzUFhaN3d0dWt6bUYw?=
 =?utf-8?B?dFpMY1RJWUhhaDFueWViTm9rMks3OXBlTDFqdUQ4RGJ1dlFWbTBUZkFxeGkr?=
 =?utf-8?B?Y2pIdm9FQ3ljQkhjY0t6ZjhDWHk4Y2xiSXBkRytkK1FBWldSQmlZb3B2anJw?=
 =?utf-8?B?eFN3Q08xQUdpaFZPdmdZRzZCT1gxcXlLNDlDVUlQU2Q3cWtOWUJ1a2lSVXJW?=
 =?utf-8?B?Tm1CTlZIMnh5amk5aEFmY1luR2graE5xajZXZkE4Uno5SjJLd25iK0pNYVox?=
 =?utf-8?B?L0F2akF3ODJ5T3pyVVIzYXdtTWdQVFBKWTVnMlR1cTdaS2w3OW9jNTIxc3lO?=
 =?utf-8?B?R2lFamhjRi9LZ2JmOEs3NFhxbTZtU1hkN0p0OThOY2o5MGxIclpWeFY2Zzh1?=
 =?utf-8?B?YjV3VkN4QnlFbFNXKy8raDVFWXcxVG1DZm81S2lBbzc1UzBJamlERTduUW9r?=
 =?utf-8?B?VUV0QnBXUHcvcU1Ea0ZUVnY3SmNrTlZ1R3p0OFpJbUMvdFNmY3FYRDNmSW5B?=
 =?utf-8?B?UXNrcnZtQlU2TFJPbkVGTVVub3Mydmt4dDM0MisrMkd1eC9hcENXeVc4VWpK?=
 =?utf-8?B?Uy9DUFJLMmFSVXpxdXV0OWE4OVhDMmhmUUFPaE5WYzUzbzJQM05kdjFSUUhx?=
 =?utf-8?B?ay9tSlByWnc1dnNtUEpKM1M4ZE15QTRqanQ4T3BPSnphREsxUkRFZnErYzBC?=
 =?utf-8?B?aVY0Zng1L2JDbUZkRDVKclVNcGxwTnpNdWN4dzE0Z2FqZXIrUGo2QTZGTytx?=
 =?utf-8?B?R0k0T0dtOXR3RjAwV1grQ0lSazhnTC9yWFowTGRPbXlyREZrQUFobHNOWUJY?=
 =?utf-8?B?ZUM1ZUNGNmFXcmFnREJ2aTlKcFEwNExoQjRjQ2NkZkZWWDh5ZkxRT3RrMVBK?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <315767056C9FCF4B90B54A6EEC9C05F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca727ad-2fa0-4372-869a-08dc65f387d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 13:19:41.0218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vh1ylptig+nCmc8mQD8GJljeD8VzEIkds3nsFzpEPZJ0VSy9Pquic2CqrS5R07WQ/oHC18z533Q5zXbIy/08MzmTkKtU4/tvoFD/64juFH9+CqP0zi23EtZqX8n7RuGB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892

SGkgQW5kcmV3LA0KDQpPbiAyNC8wNC8yNCA1OjMyIGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gK3N0YXRpYyBpbnQgb2Ff
dGM2X3Byb2Nlc3NfZXh0ZW5kZWRfc3RhdHVzKHN0cnVjdCBvYV90YzYgKnRjNikNCj4+ICt7DQo+
PiArICAgICB1MzIgdmFsdWU7DQo+PiArICAgICBpbnQgcmV0Ow0KPj4gKw0KPj4gKyAgICAgcmV0
ID0gb2FfdGM2X3JlYWRfcmVnaXN0ZXIodGM2LCBPQV9UQzZfUkVHX1NUQVRVUzAsICZ2YWx1ZSk7
DQo+PiArICAgICBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgIG5ldGRldl9lcnIodGM2LT5u
ZXRkZXYsICJTVEFUVVMwIHJlZ2lzdGVyIHJlYWQgZmFpbGVkOiAlZFxuIiwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICByZXQpOw0KPj4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsN
Cj4+ICsgICAgIH0NCj4+ICsNCj4+ICsgICAgIC8qIENsZWFyIHRoZSBlcnJvciBpbnRlcnJ1cHRz
IHN0YXR1cyAqLw0KPj4gKyAgICAgcmV0ID0gb2FfdGM2X3dyaXRlX3JlZ2lzdGVyKHRjNiwgT0Ff
VEM2X1JFR19TVEFUVVMwLCB2YWx1ZSk7DQo+PiArICAgICBpZiAocmV0KSB7DQo+PiArICAgICAg
ICAgICAgIG5ldGRldl9lcnIodGM2LT5uZXRkZXYsICJTVEFUVVMwIHJlZ2lzdGVyIHdyaXRlIGZh
aWxlZDogJWRcbiIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgcmV0KTsNCj4+ICsgICAg
ICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+IA0KPiBNb3JlIGV4YW1wbGVzIHdoZXJlIHlvdSBy
ZXBsYWNlIG9uZSBlcnJvciBjb2RlIHdpdGggYSBkaWZmZXJlbnQgb25lLg0KWWVzIEkgbm90ZWQu
IFNvbWVob3cgSSBtZXNzZWQgdXAgd2l0aCBhbGwgdGhlIC1FTk9ERVYuIEkgd2lsbCB0YWtlIG9m
IA0KdGhpcyBpbiBhbGwgdGhlIHBsYWNlcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IHJl
Z2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgQW5kcmV3DQo+IA0KDQo=

