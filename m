Return-Path: <linux-kernel+bounces-59041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A473E84F03E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301301F26E29
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9BB6027F;
	Fri,  9 Feb 2024 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1zCM/N9j";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GcJbDle7"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10095FF1D;
	Fri,  9 Feb 2024 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460294; cv=fail; b=VpDLrpuqGeXQGz45Gx/WlcrcRVOnCaqJAm+M+lNnneBrmN8yzqp+7kGda8K5e6z+S07zx2wIdqM3rTro9XRGgIFL6hRymwysQbzD3YgDWlP3mGtMAmvghsO4+G3xsGV0K62yzmcnAZWW0oMiwzFUYh2DsBM2Q5HxUQHT/tUAF5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460294; c=relaxed/simple;
	bh=pOu8A4sKeXj1FtYLTHHJNL80fFhIFp/rT2lqdW9nxH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MarQ55CPB8ea2vNbqhwrZ+g5SjTQ5yavrRE2+dHrm4twq3pXMX1ncvbOk/Z8ceyNgnV6jV7SJT++5GiPT6kzqyuwwzZMO6p85bt40DhFc7BNE1wihH+2piR0fLOjskMCe1b04ffnGDrelSkYCt0EDtF8pJ+pcb3Trj9vARHkvcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1zCM/N9j; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GcJbDle7; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707460292; x=1738996292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pOu8A4sKeXj1FtYLTHHJNL80fFhIFp/rT2lqdW9nxH0=;
  b=1zCM/N9joSaN9EOW66bwFwmrEvOGbcg+Is9TStF4MLSK4l06nkoaU7Of
   HNynhhuQdkKAqukeGh8cJTvgRcR2jV1KmNGXK54UQ0aA7Ik9L2rQvhUoK
   bc+uKM/6T57+m714//Gpofd/HKBBeYlz925kCUjwbxtoV+jMStFU+zLPH
   ZIyc6QUFCNJn602mECEXrvn4aR9at9BvlURRGYPFG4TNdz7wlerP/ycjK
   5U+faxtbtMGqdgtp6sSvDenvMFXYjKJwSrnkZ5f3YwB2J2dpyUHOTg6GM
   fA+GwBKJaLQZoXt1+fDaOLuNwbn5rRDaHu8ThDcrcjb+TzNxBIlznhjWZ
   w==;
X-CSE-ConnectionGUID: s7hrUtVSQem+Im+JdOFLbQ==
X-CSE-MsgGUID: EqalBFqeQn6WgRxGk7tcSw==
X-IronPort-AV: E=Sophos;i="6.05,256,1701154800"; 
   d="scan'208";a="183270030"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2024 23:31:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 23:31:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 23:31:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4zhqIzKTAp/wv/7Rpf+nAOK/WWLt/9PG/Qtpxyt0eR+J1BTSIr0pydoe3cysNTkXcyc4OHSBuk+7UKXdsxbEKC9if5eUhLoQ099d7oEDUYDHra95VpR1lP2hrao2Wi2uq4h6X2JotQDf/4Sdz2eSPcTmcI8Kwj5eD6FpFX/RAmcvq/p9YDU4H5DR8EG8n+Viiw2E/WE52rZRluN+GwTGDh3ynsK+3WHfEIRTuilGlbt0GuT3aBShZ3X4ItlHagcG/cobt3eVowEEMM2Acw081QkYLdRdq/+sWp3tqxpvpvs0b8lEr56chqvUi+383leOt2FJN64Ri/uqEC1yR5iEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOu8A4sKeXj1FtYLTHHJNL80fFhIFp/rT2lqdW9nxH0=;
 b=k8CwEu+/pOvPgygVXIpI0ll2TYK8A1rGYE4WRRm0mq7oBTeESLQUR3gc+adX6d83P2M/Y2Yc9TIgC6Dn7qqxOVWKLntG/MRCDUhQNvhl7aYUnTRtRvGxubeDCXheEct4o1CeIakdog30wVG1xkzdBMY6v5YeAFN6i/i5N7crLPa8Cipm2IhiF6hnNhopvRO4POjfkDEK5UO/6sKu3pRTpQyuDRJE2JN2hWHfAmVKHbrwmXQ2INSVfch1vfeyKaPPs3gEgYMFIQZIvjkMw1L6tOg/xospbTPdVRrsWsPFXzuBL+E62uGdRSsgt7YyRZlud3wPBpCqjMTcBheBQRwPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOu8A4sKeXj1FtYLTHHJNL80fFhIFp/rT2lqdW9nxH0=;
 b=GcJbDle76hghGdPkAWmRxN20/P796WxS+rbwwqfZtvtrer+awKQeyUuXNjRTrwAfw7vLCuVFXUH3S9VkrC7QTe7bJpSA3Y5UWxk4erYVnwQJxU8snGuj8jfs6PB6S5pxKg6KSFezBDiRPFrWZ5zPk11E3TwIrZLm1R74jgBGMbuWP5MchboFZfEGWBIvNfphAO72hsIObrqIdx3PWdNgVV85E0AFZ6en8Kj69tDiiShbUKi+AmFHTq6nurFTaaZFGIIOFcv2UEuiZ1YqTybVGmFpsN5X/Gfvq/doRusg9MW/5uxeWEB0vr+zIcsJAJv2jJxD8dKIjmYI3zhQC9xbAg==
Received: from BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 06:31:15 +0000
Received: from BL3PR11MB6436.namprd11.prod.outlook.com
 ([fe80::96fe:b914:e84a:73fc]) by BL3PR11MB6436.namprd11.prod.outlook.com
 ([fe80::96fe:b914:e84a:73fc%6]) with mapi id 15.20.7249.038; Fri, 9 Feb 2024
 06:31:15 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>, <robh@kernel.org>
CC: <alexandre.belloni@bootlin.com>, <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
	<Nicolas.Ferre@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<robh+dt@kernel.org>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC to
 json-schema
Thread-Topic: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC to
 json-schema
Thread-Index: AQHaWnAMbpa2jba9NEOaeGq/acSuiLEAmH6AgAAxpQCAAMQmgA==
Date: Fri, 9 Feb 2024 06:31:15 +0000
Message-ID: <8dcae60c-1aba-4e76-99cd-de78c2c4ba6a@microchip.com>
References: <20240208092015.263210-1-dharma.b@microchip.com>
 <170740748922.3230402.17318224112819715619.robh@kernel.org>
 <20240208-acuteness-visible-b60cd37c2b32@spud>
In-Reply-To: <20240208-acuteness-visible-b60cd37c2b32@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6436:EE_|MN2PR11MB4661:EE_
x-ms-office365-filtering-correlation-id: c39a1992-8c73-4d2e-6bd4-08dc2938b7b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KyuPT30Io0YdwTCqx2sdt8+qjE8D3YfBw7PceODkOsUApZ6aNIdjVo3PZtzRuHXKLVlIbdDqGGoziuG8RKRo55XFFNnNviSobqaSKX7N6jIEKEEdWYLWM/kwCfAuRTDLd+ynDtsh4ezNPJzFSjIn4F9JQT0obl8CgCDvWKKI1KQAZU8PsAul14TPv7L32LiwRoGwwti2T8crMdhHyq/qHopg5suaNjbotF1NJCam4gXd9XYVHAPbgd4bhXjRsvLp13e0Py0u78da83w6t40KiOY0ydmxKhLudATspb+Y7/KEA70IaRlFOJnX3tpj+7zb1IBT1ifUBboPad1x4ewNB39WnAuTgWZ5hQM4GY/whTKIngjOQCe/eqPv27WWnUXKuxglxUYKDTs5dRC5sKDCdbde1g0HURLI7deoazcQFaVc4TmZmrxGX4cyoapYr3zBH6olXVZvpAb8Q4/zZKOpzmSOMRQNiysSxutj6YPGXsawspXWJ0PtmPUu1tdDw6eso+bQM6qUazHdBPMApHhXZQTSaG4esXZzMOOEWB2YIXPkPL+so+UhMlMZx3hkv6nMW//k7swbHw2Enf3+dDA4ILWSy6V3OIrIwASY92e7cRy+Ys5gmusJg86/ap1ltpcJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6436.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31696002)(83380400001)(86362001)(6486002)(38100700002)(54906003)(316002)(26005)(478600001)(66476007)(66446008)(110136005)(2616005)(64756008)(6506007)(53546011)(71200400001)(66556008)(91956017)(66946007)(76116006)(122000001)(6512007)(38070700009)(36756003)(5660300002)(7416002)(4326008)(8936002)(41300700001)(2906002)(8676002)(31686004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzA4T0tRNm40NWZvY2ttT29IZUMzcEZHaHpHb0dJdzRsWUEzU2p5Slh5QzBP?=
 =?utf-8?B?djdMREozLythYnJiTCtKMHBEQnMva01rcjhYY29NallTdld6OUhmV0JIdUZB?=
 =?utf-8?B?TXlYbW0vbzJoT3JaOGFXU3cyMmxJY0pmWTkxTnIxUDRoRXNqQm1pdXFlckMr?=
 =?utf-8?B?NXpBMXh4bU54cFZkOFpIc3IxR0tnVU5lNVY3K2tvQjNIeVIzVmlCTXZlaEZU?=
 =?utf-8?B?cmJhVWs4RGZ3MllvdThTYjhwemVFLzdYOGNJSWEzRmhrYnhQNEsyNyt5ZDhw?=
 =?utf-8?B?Vk5Ma3VjWjM5QjRQbUFEUys1d3FEMk1OU2tDYWpiZlFDUjk2azkwL3ljdWJM?=
 =?utf-8?B?VHoxTmp4a29jZmM1bjRZQ01iK3FrQ2hRTWhpV1NyWGsvT29XRzhzYTV5NG9X?=
 =?utf-8?B?RmZUR0JrRnlXeWdzRjI3OENldlJHU3lld0tHcXRsdkcvVC9zLytVR2IyM3hT?=
 =?utf-8?B?WU5MYUtScXVkd21kaVlieDJCN2JIVWRzMFhDemxHd0NuOHFHQ011eDZQUWFL?=
 =?utf-8?B?TG9salFrMWRPa0NwcFMvdWVOVzlsK0VKajIyenRQVDlvZEM5bW9nQWE3UWVH?=
 =?utf-8?B?aERoT1BOY29uUnR3RVR4d2xBWHBkRktYVG9MS1U5bmRkRVgxUy9mL1J4bHAx?=
 =?utf-8?B?QzJYdUh6MkFtdHM5VldxS09OdTdFekhIWWRvTGx5L3Nickt5NFRXRG5SNWFW?=
 =?utf-8?B?bzR5UThPQjNvZjArSEVuRXM0LzF0SHRhM1pxTCtuL0RFQ3dFVStwY0FHeXpu?=
 =?utf-8?B?byswdUg2VlNWazdzTloyRnZzcWo4UjlDY0QyZC9PM3BUYkZqeGRvczhKdXdw?=
 =?utf-8?B?Szh2QUt4Y2wxeXdzV0RDMzE5Z1MvNjNCMHo0N2FuUG8yQjFPRnlxV1RFT0w1?=
 =?utf-8?B?NWJRelo2VXo5SDZHL0VKa2w3Q2QzOGl3V0xrTU9HTENPMWxpMGJzSnNacFNm?=
 =?utf-8?B?QURIWnJiU3l5OXpnWmJPVW93c2k3bjRSZWxwSWVSRHRMd252Q1IvSjhka1JC?=
 =?utf-8?B?aTBpejBxZHd1MnJtUWM5bkZIbktQTDVXMWNoOG1WclJJclVkcFI4bWVNZGFR?=
 =?utf-8?B?N2lIdExYZGFoamc4VXA1bFU0TTVHbWhCc0pkQS9jK1VrTThldllENFpETnRx?=
 =?utf-8?B?bGZTZHU1emlXSWw2cXVVOXdYUnVBNWxjVGlJcnFEOUR2ckYwYnNlN2l4c29l?=
 =?utf-8?B?Zkc1anVXRFpKMVI3dFluM2NNTHpWdC94R3ZtTFBkcDRxWGFqREVaUWVFdWtJ?=
 =?utf-8?B?Y05jRkY1Rmx6eEhKS1FvcFl0M3NSTmR2L1M4dmo0ZGNRbFF0TFdVL0xXWWti?=
 =?utf-8?B?U2Nxd0FEWEJkak1hSnVpRmdWOVVxRFdISVdJZnNrUVFQeVJxOW03TXBsWVFz?=
 =?utf-8?B?U3lRQWlqSzhVa2hpcVJHayt0WjZwZ2xMU1VZV1l1Z21LQllsNitvcWFhTG02?=
 =?utf-8?B?S1hxVGh0Y0dpNGF3clpXQXZuUzYyYWFJTENDTm82TGZoR1JPNmdYZnFtcTM0?=
 =?utf-8?B?dmMyZEhEQkFBd3dvbHFtNi9mRUIwaE05ZmVQd1pieldXZ2JNVDl2S1FiOXVM?=
 =?utf-8?B?b2tpMlRkMUNRNUlXZEpQaGdIZDMwNi81WUxJMXhRUDRCQ3ozYXNrV2YzSXZx?=
 =?utf-8?B?anlkemxSUTJMeGdLcm40VzI1bEJPY2JjNHQ5VjZaWnlzLysya0gxdnM2Z09j?=
 =?utf-8?B?eDdOOEdERTV1REdsN1kvbHNUbUw2Y3Fpcjc0SjhkRG1VZVNJZWhxR0xaeU5Q?=
 =?utf-8?B?UjhJZFpkUTNSait6eExCVVdPV1VUdnZYZzlvQ3RwamRwLzk0Y1BkMXJpTXBZ?=
 =?utf-8?B?Z1pFaU1pYzJaWGNwY0kxdXh2YTc1K2F5R0c5eXpTRlVSZ1hsRjlGb2hzaEhW?=
 =?utf-8?B?NnZuMnlOKzk3YzBqV0Q5KzdxM3EyRktMY2JrbURTckpIdEtiakNzTmdYckVx?=
 =?utf-8?B?a1JHeXBVSE56M3Bybm5SWnFuNGM1Sm9vckp1cGtUYnRNa1ZrSEFSejl4Mllx?=
 =?utf-8?B?dWFDSzJDNUVqcGt6bi9KbVJ1QW13czh2TlpwanV6ODZmME5JTitjQ3pjWlIv?=
 =?utf-8?B?dGp1SkhDOEtPTC9saDBWR0drSEZWTmRXQ1NhakNmczVCb0t4bmZ6dnNncjAz?=
 =?utf-8?Q?pnwBY+gcY4LQA7bZ/L9YPqqTv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0627C11A569AED4EB82C84431CACD861@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6436.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39a1992-8c73-4d2e-6bd4-08dc2938b7b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 06:31:15.5996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdHUw13IcDvAIjjlD8exPIKhQdB+V9dxUJzBSREIUXewzwCF9uio+iMExw7pRGCqXjLAZiRgpQZ2gH9R/nmN7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661

SGkgQ29ub3IsDQoNCk9uIDA5LzAyLzI0IDEyOjE5IGFtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IEhleSBEaGFybWEsDQo+IA0KPiBPbiBUaHUsIEZlYiAwOCwgMjAyNCBhdCAwMzo1MTozMVBNICsw
MDAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4+IE9uIFRodSwgMDggRmViIDIwMjQgMTQ6NTA6MTUg
KzA1MzAsIERoYXJtYSBCYWxhc3ViaXJhbWFuaSB3cm90ZToNCj4+PiBDb252ZXJ0IHRoZSBBdG1l
bCBBSUMgYmluZGluZyBkb2N1bWVudCB0byBEVCBzY2hlbWEgZm9ybWF0IHVzaW5nDQo+Pj4ganNv
bi1zY2hlbWEuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBEaGFybWEgQmFsYXN1YmlyYW1hbmk8
ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4NCj4+PiAtLS0NCj4+PiBOb3RlOiBJIGdldCB0aGUgZm9s
bG93aW5nIHdhcm5pbmdzIG9uIGxhdGVzdCBrZXJuZWwgYnV0IG5vdCBpbiA2LjcuDQo+Pj4gU2hv
dWxkIEkgYmUgd29ycmllZD8NCj4+PiB1c2FnZTogeWFtbGxpbnQgWy1oXSBbLV0gWy1jIENPTkZJ
R19GSUxFIHwgLWQgQ09ORklHX0RBVEFdIFstLWxpc3QtZmlsZXNdIFstZiB7cGFyc2FibGUsc3Rh
bmRhcmQsY29sb3JlZCxnaXRodWIsYXV0b31dIFstc10gWy0tbm8td2FybmluZ3NdIFstdl0gW0ZJ
TEVfT1JfRElSIFtGSUxFX09SX0RJUiAuLi5dXQ0KPj4+IHlhbWxsaW50OiBlcnJvcjogb25lIG9m
IHRoZSBhcmd1bWVudHMgRklMRV9PUl9ESVIgLSBpcyByZXF1aXJlZA0KPiBIYXJkIHRvIHNheSwg
aG93IHdlcmUgeW91IGVudm9raW5nIHRoZSBjb21tYW5kPyBUaGVyZSB3ZXJlIHNvbWUgaXNzdWVz
DQo+IHJlY2VudGx5IHdpdGggZHRfYmluZGluZ19jaGVjaywgYnV0IEkgdGhvdWdodCB0aG9zZSBo
YWQgYmVlbiBmaXhlZC4NCg0KSSB1c2UgdGhpcyBjb21tYW5kIHRvIHZhbGlkYXRlDQoNCm1ha2Ug
QVJDSD1hcm0gQ1JPU1NfQ09NUElMRT1hcm0tbGludXgtZ251ZWFiaS0gZHRfYmluZGluZ19jaGVj
ayANCkRUX1NDSEVNQV9GSUxFUz1Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50
ZXJydXB0LWNvbnRyb2xsZXIvYXRtZWwsYWljLnlhbWwNCg0KYW5kIGFsc28gZHRic19jaGVjay4N
Cg0KdmVyc2lvbiA9IHlhbWxsaW50IDEuMzIuMA0KPiANCj4+IGR0c2NoZW1hL2R0YyB3YXJuaW5n
cy9lcnJvcnM6DQo+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0
LWNvbnRyb2xsZXIvYXRtZWwsYWljLmV4YW1wbGUuZHRiOiAvZXhhbXBsZS0xL2RtYS1jb250cm9s
bGVyQGZmZmZlYzAwOiBmYWlsZWQgdG8gbWF0Y2ggYW55IHNjaGVtYSB3aXRoIGNvbXBhdGlibGU6
IFsnYXRtZWwsYXQ5MXNhbTlnNDUtZG1hJ10NCj4gQnV0IHlvdSBkaWRuJ3Qgc2VlIHRoaXMgd2Fy
bmluZz8NCg0KTm8gSSBkaWRuJ3Qgc2VlIHRoaXMgd2FybmluZyB3aGVuIGFwcGxpZWQgb24gdGFn
OjYuNy4gRG9uJ3Qga25vdyB3aHkuDQoNCj4gSSB0aGluayB5b3UgY2FuIHJlc29sdmUgaXQgYnkg
anVzdCBkcm9wcGluZyB0aGUgInVzZXIiIGV4YW1wbGUgZnJvbSB0aGUNCj4gYmluZGluZyBlbnRp
cmVseS4gSSBkb24ndCB0aGluayBpdCBhZGRzIGFueXRoaW5nIGF0IGFsbC4NCg0KSSBpbnRlbnRp
b25hbGx5IGNoZWNrZWQgdGhlIGdlbmVyYXRlZCBleGFtcGxlIGR0cyBmaWxlIGFuZCBmb3VuZCB0
aGF0IA0KYm90aCB0aGUgZXhhbXBsZXMgbG9vayBjb3JyZWN0Lg0KDQogICAgIGV4YW1wbGUtMCB7
DQogICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCiAgICAgICAgICNzaXplLWNlbGxzID0g
PDE+Ow0KDQogICAgICAgICAvKiBBSUMgKi8NCiAgICAgICAgIGFpYzogaW50ZXJydXB0LWNvbnRy
b2xsZXJAZmZmZmYwMDAgew0KICAgICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFybTky
MDAtYWljIjsNCiAgICAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQogICAgICAgICAgICNp
bnRlcnJ1cHQtY2VsbHMgPSA8Mz47DQogICAgICAgICAgIHJlZyA9IDwweGZmZmZmMDAwIDB4MjAw
PjsNCiAgICAgICAgICAgYXRtZWwsZXh0ZXJuYWwtaXJxcyA9IDwzMT47DQogICAgICAgICB9Ow0K
DQogICAgIH07DQoNCiAgICAgZXhhbXBsZS0xIHsNCiAgICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KICAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQoNCiAgICAgICAgIGludGVycnVwdC1w
YXJlbnQgPSA8JmZha2VfaW50YzE+Ow0KICAgICAgICAgZmFrZV9pbnRjMTogZmFrZS1pbnRlcnJ1
cHQtY29udHJvbGxlciB7DQogICAgICAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQogICAg
ICAgICAgICAgI2ludGVycnVwdC1jZWxscyA9IDwgMyA+Ow0KICAgICAgICAgfTsNCg0KICAgICAg
ICAgLyogQW4gaW50ZXJydXB0IGdlbmVyYXRpbmcgZGV2aWNlIHRoYXQgaXMgd2lyZWQgdG8gYW4g
QUlDLiAqLw0KICAgICAgICAgZG1hOiBkbWEtY29udHJvbGxlckBmZmZmZWMwMCB7DQogICAgICAg
ICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTlnNDUtZG1hIjsNCiAgICAgICAgICAgI2Rt
YS1jZWxscyA9IDwyPjsNCiAgICAgICAgICAgcmVnID0gPDB4ZmZmZmVjMDAgMHgyMDA+Ow0KICAg
ICAgICAgICBpbnRlcnJ1cHRzID0gPDIxIDQgNT47DQogICAgICAgICB9Ow0KDQogICAgIH07DQoN
Cj4gDQo+IENoZWVycywNCj4gQ29ub3IuDQoNClBsZWFzZSBjb3JyZWN0IG1lIGlmIEknbSBkb2lu
ZyBzb21ldGhpbmcgd3JvbmcgaGVyZS4NCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJt
YSBCLg0KDQo=

