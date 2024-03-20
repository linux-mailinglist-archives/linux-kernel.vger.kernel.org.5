Return-Path: <linux-kernel+bounces-108466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3F880AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8C0282F25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A317BA1;
	Wed, 20 Mar 2024 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OZxEqL5H";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TxPDXESn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D014A96;
	Wed, 20 Mar 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914172; cv=fail; b=ldkVhOWJ1CI4/Gk4wwHwRf0nHiP2yfQ3DBceqQBITWGNq9KWCSC2//EtQpvMTfSXTrvILiAITkERggEHyGmdSCvWeQF1ZJ5yJZz5PiUwaHuTR4RJRSMFglxzPJdsJqgbuLcV0dMxXFecw7V9aGva/3njdVlY6GYWFeO43LMUU6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914172; c=relaxed/simple;
	bh=vMeeIoDJfMtag40RDeEPXc048tbiWDRVo9MzklCUxZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RmCzgbWbmzbrFCFF03lrYdMZUHIBjkfeDPZdTUiZJlnt+xbDj+Awto/adAPKKim6XND4vZSZAlMw631rgiOVsKMC9SW679+G6oSKtoPOwP4po/i7evvrAaUZprz2qY82oJgrp7KAZyslwp2qEJZRlBl5XvwgxidtmFrr8NhUZwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OZxEqL5H; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TxPDXESn; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710914171; x=1742450171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vMeeIoDJfMtag40RDeEPXc048tbiWDRVo9MzklCUxZo=;
  b=OZxEqL5HMHYVAT0SeCa6t3weZSguAB8YdOFAWKDj9ePbDZwnB6Q6t4hr
   KBPg/NZxVX7R6YjowRt3X1wYJvLHq76U/FaTqiQNp+vC/DDtEZH3ZFZr8
   WLMEvL2h5SdxwNWPn6VSB19POwG+VW5jzFOd/1jofhEzEzuGcGni7zJ8Z
   LB8YdfRtHh3LjT4cAfXG3Gr1pJzxQNC9gWVmlPrEtHStyq5UPvfUMwv65
   6FJYlfELQv6aL/IGeMzplEXe/t/+WM9AVWnApmWgxyfoqROATXS3Jis/+
   Ff5lLhKn0nvXn4pEU0ZJCBl78wFULUXXvY5Ml9KR1KZxTWw8iCIwAWvTi
   Q==;
X-CSE-ConnectionGUID: ufuuSC5cRBKkzczbTinxiQ==
X-CSE-MsgGUID: zuwoK3G/RZu2XVawn2NMEA==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="scan'208";a="185152601"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 22:56:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 22:55:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 22:55:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNVsUXgS6QbQ+1ehKNlCOzY4GYMD8pvMnzfrUzPNMK/y/6tFSTvnFnKEduDH/KK/yUvBkdIfMLyUclzGAWS0UFRFStHGTXGGAX5bKtQcfhhPTcMMBwf+yk0Suq4Dsi9rxky8mYMwmtjESSkB0gu1NCBlpT4+LwAqDf5zPuEoHiq7gd6CXU8YyEYsVi1GbjFnPPIFYNPwdEHF8EqTh19a3eUzMGkMo3L/tG6FkoOSfA5BurpoSfOYe17s01His+6kzWKsX5uq9w8p1uz89xC07g5guJAnhKAqIKL/PksTEvCArQ2VL208G2BtTNMQRPjDAkNPR10NUWo63j15Cbjq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMeeIoDJfMtag40RDeEPXc048tbiWDRVo9MzklCUxZo=;
 b=CgdwmP21XlLA+B3Gr2rq3eZzdx9lcjwowDGsOEeYMrk6jeDBoIV15lBXuK8iDvl3YCig8e6cIG2B79KHm+Sbez8q4pV+d1PiKr+gGqKGX87ywfPf/sl4/ygCbI1UNtAB/rsZ7xDuGZ2dyb5iQk9iU6+CRDh1KTjesoSuUzaprd0sDKm8F++Bjfev6HqG/hyx+vP4cvfqQoUjmdbMPrK+0Ty4TcJR7DgwhywPRe0r/ys1zvpQKaL9ENnxo+ZYAtBfPgtUZ3HRrVhv5b5AI8x8+eBOmY95AQv7/s7xxOtzOVBSqz1tMpjjPpMkRy/4TkIAEuGFvcDAtJAd6K60BL3XGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMeeIoDJfMtag40RDeEPXc048tbiWDRVo9MzklCUxZo=;
 b=TxPDXESn2V9zmMM8P7wR42algXTlg/J+1fGKtkKkpTxQKfn1fX7elO2W0SuhkhOphYHGWRhrMmVPCaRhz3M1tgy3I0KzDNFqY7UPwIWiN6sLGAtutxh1lFsPT0/vkHa6yslTTHo5A9qF3tUo1eQkSz+U4pCB4xfKG9Gxhev6RCT52+5zam0aNQAe/gpaa0g+YmZhWFFRBs9xsUvbzo6ljHOaK49zKIlrHANAjGrMnW2wlVr1/QTTrN5K1zojott+C/ZZJ9N3bEz7d4Kobng9mpnVDBwiHCSCHogR9R4gKg9QEK+OrWpb3Ib7t1+i9e1ultuBoyR6h6eHXTu6Z6CTBA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA1PR11MB6965.namprd11.prod.outlook.com (2603:10b6:806:2bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 05:55:31 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Wed, 20 Mar 2024
 05:55:31 +0000
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
Subject: Re: [PATCH net-next v3 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Topic: [PATCH net-next v3 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Index: AQHab6OdU0M6Qlks6kCHViBNnqnl3LEs++mAgBIeCYCAAAczgIABFg0A
Date: Wed, 20 Mar 2024 05:55:31 +0000
Message-ID: <430f3c59-fa41-4d16-bc4f-23a5c2af3580@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-10-Parthiban.Veerasooran@microchip.com>
 <49f8b067-4e56-4e8f-97e0-bac314619b82@lunn.ch>
 <cd971029-c1f3-40b0-b940-4d48e03b9f55@microchip.com>
 <5b1e7439-a41f-426a-8bf1-9a5b20b44019@lunn.ch>
In-Reply-To: <5b1e7439-a41f-426a-8bf1-9a5b20b44019@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SA1PR11MB6965:EE_
x-ms-office365-filtering-correlation-id: fa492a8a-da06-466e-a563-08dc48a25a60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R4XJj47r1w5Qti5BBgYZkMAKXQFBOlauein+3Tr0jJYtZotzweGevZRmfw2adCh+ikMnA15deYP2/w7zVaRlTJwuIdSrXTVYEIkUjPd3jeYhttlnatkdfF9b30lOX9fbeBNgkmUK6SJDN82S5wk+pgHFSMfJt7clgrbMbFV91txVnyYN/JbEqOhQDtWJTPMpPRe0q+ozaDCUdGo2one1fqTX3OftDJwC3Vpx6nnT9BzGfOCmSunP25kVfDMwQdVd74dnjB6l5bB7gHMWNc+0y03mJNNy2pFfFiJaIStIVzReE1O5bYfW0ZZfwm/CnrLqoEEs5OJ/Qxwjim3BpqJ/JBC/owd5P7wNFzh0R053Hdu3ianJfHZreXNuPCsLnNYG2EgOmM2awLnVYUMNtcPJCy9uD14xJlYsA/JqCjGZuuwgqQgfbOilQySK5H4BK4DzElaKYdyyrE6yBfDAS14aVa/ZYuda9YVRWCP6CXFq17eeGchJt5+vp5RyvMo0T8092gMY6SxIv2x1uyt/OTUc22A89b36FghZB7m4eYh0vz8NuOvS8X36G0XFkmIwSj4U9Wvv90RF4Z/+5mNj//32W+O/hvYOeTBdl35gApWKSKxSxY+YbyieZgSHNWlPChQf+ilOPowpXeiv10J+Diq2OZT4/ASkh1X+QZYNnRbfExqNpIpAS/EnAWUtE8ZbF9l3IvL5xC/Bxb5Ye92Cfm7/sQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXNrSzR0SGVnVzVwcFdFSDJ5S2JHWi9yNW5mcTQ2NTB3VmVDQnJiS1FCQk0y?=
 =?utf-8?B?Rk40aEFXYXNKOGp6Z3NBcmQ1OVp1ODNLb0RFZVhTYlJPZFJqb0ZKbjRBQkR5?=
 =?utf-8?B?K2NNd1kxbDN3SmNvU0U0dExycTgxTUZZZ210QzJCd3VjQjhCU21QcUltQlVJ?=
 =?utf-8?B?dENZcHk3YUNJbDRFak1EaFdpaElLaVk4aUNQNUVRVEZ2OUFPNTZLSkU4S1RJ?=
 =?utf-8?B?SVYrTEQvM0VuaXdPQkxKMHVscmNiOUlnSnF6WkFGVDdBa3AzQUlyR2IxNjU4?=
 =?utf-8?B?alRValpvUkI5dzR5bVcvUXZ0T0J4WHd4SDBqQUJtcGdLTm95dERkR1pLbjhM?=
 =?utf-8?B?QmNBMGd6bGEyM0pZMCtYMEo0STc3UFN1UlkvQUFDbTRLcjZrZXNRdzhUYVlK?=
 =?utf-8?B?bGp3b254ZDVIN3JUeGR6WEhBRlUySTZxTWpWYXcwc1FIM1pRQm5JZXN6VXBr?=
 =?utf-8?B?MVBhTlhZeGlBOUJaL2ZLZ1JWeFZNekExU3ZoNi96d0F1MXh2ckpJK1BaSG5s?=
 =?utf-8?B?YXNRUk9tWklQR3FVUnc5YTZWL2tEaWtxZWorSnpNSTZFbHpFTytGbURSd3RL?=
 =?utf-8?B?aXZwdzhXM2xrTnNzT3BlNEliOGtFbkVrV3hoV3dVbzlFTDRMSG5xakQrMHdr?=
 =?utf-8?B?cmJ0VEMyU1lhMHI5T3pFSnVrUkRQTmdQa1VIRy9GWFNjdDZxYnFvZUpzdno3?=
 =?utf-8?B?ZUlOczdjcXdqbDVtMnNwbE1aUTh5dllHWHFmYU1rN3d5TnpqRWFWV2NROExj?=
 =?utf-8?B?TFVhRXZDcld0eWpEZGtlclExWllOUCs3Q0t2eVAwMm1CdWxmeGlOM0ZzMVc4?=
 =?utf-8?B?Rm1tczQ4Y2JLT21YSm9qMjZiSGQyMWxMZkNDL0JnazE1YTNvaHdQaElSb1I3?=
 =?utf-8?B?cTg1VUYxRjlaYXBUWUhFV1QzZjJJdUdsOVd0NVAxQm9XVWM5bzd1WEdTSXho?=
 =?utf-8?B?Q3N5Nko2ZXZXQ1lkOWFDRW5IbkR1cU5OZ1N1b0hwY1ZVM3NRaFVBeUpjUFBl?=
 =?utf-8?B?SGhyWS9rZ09qTnZlUGJZN2hQQklmc3dXUGpFbmRrc3JvMEFSVmFPNGNZdUIz?=
 =?utf-8?B?UUFWWmQ0NTFpMm1qd2dvRU1TdHhtUDc2cHlBaGp2S2lxUCtFZ0F6L3c4RTlp?=
 =?utf-8?B?WWpscEx2VlpTWG9ONW9PYkJJbVgwNndERjZENlRLMWE2LzJJSnlELzM5d2dV?=
 =?utf-8?B?U1FoVzhna20xUWt3T2wzN1I4dVBUb1NudFRVb1hBbEVZdmlLUlpaRXI0QTFJ?=
 =?utf-8?B?UnJmT1p2MFFSYzB5b3lDalBER2hLNnB2dmVMUDFXMEdiM1hKdU5waEJaRE1Y?=
 =?utf-8?B?MWZINzBMQWlDWmRsUGV2TnRJR2hsOU9uQi93cVNiR200NEttQm9HMGtjYm5Z?=
 =?utf-8?B?VzJlQmJlZTI2Rng2NDUvNyttRC9QSnJiN3A4QklMMUQ4aHgvUUs2RXZ3bWpm?=
 =?utf-8?B?L08rVnI4RjIrclB3K1cxcG93cXJTbFlhb3pDUGJrQVR4cEpLcVlOTlFHNldF?=
 =?utf-8?B?K1p0bTRENGxlN1JMclM0bmhPeTJOM1BvTVRqVTMybXovTlQ5NE5YMUxLaG5G?=
 =?utf-8?B?RFQvK1l1NlpRekdRcjluRmoyb3V6RWllTlNFdUxCQk00bTF6K3R6ZzhGZnRu?=
 =?utf-8?B?VUNpL0dhUEZ1ZkxNQVNWNnJaaUd5Rll3MG5NMStzcXRzdUhaaC9IWVZxMUpU?=
 =?utf-8?B?WGNGYmpiZkFBWXg0c05OOXBKKzBUNUxaZkt6R1ZVM0FnODlGQlltVGkrMVcr?=
 =?utf-8?B?STlLVjUvTnI0L0luRnA1aWh3SmZhMWNBalEweUltdjFRSW1ZMzdReE9iaFht?=
 =?utf-8?B?ek1OdUxWN2FxU0duSGtZTFFXVWJ6TWN3SnBmbjl5UXZLQ0JDK3l3cWduMERZ?=
 =?utf-8?B?YWN1OUtTQjJiejBKcDVxTlY2dzVkekZ4VFlsUVFoUlRYL0plUm4ydXdRM0JQ?=
 =?utf-8?B?OU9GVnVTMzd4VjRCRFVzMnZJd25oOEQ5bWQrRFVwdnozem1jbHNDSVBLS3Vx?=
 =?utf-8?B?ay8zNU9wRlVZTGtmNjlLRFRQRVYvbm5tK2haeDUrSVFrRm83UURvT3NDS29O?=
 =?utf-8?B?MWMyc1JUYmNZRDBFR2lWOVovK0VkMVoxS3p2VE1OTHpna1VMVmo2NDV1d0pl?=
 =?utf-8?B?V2grMTZhblBkTFBBc2hqenVHZkEyOVRHOEhsb3N5QjFHSG1aSnNBLzd2cjRi?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <030F87EFE2286646B0E1A7BD5DA7116C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa492a8a-da06-466e-a563-08dc48a25a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 05:55:31.7927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqIovQ3+vZ35iwDl2gLXXEeEuDLYz1PWTFWj9FVLhEcEk6JhvZu8FUqBBOlerNDjcRXZYAOyKXeAslm3jPRkHvXaTSLWodVWjH9hdggxsESqWMyZuoLC6m6Sose99DoY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6965

SGkgQW5kcmV3LA0KDQpPbiAxOS8wMy8yNCA2OjUwIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIE1hciAxOSwg
MjAyNCBhdCAxMjo1NDozNFBNICswMDAwLCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+IEhpIEFuZHJldywNCj4+DQo+PiBPbiAwOC8wMy8yNCA1OjQ0IGFtLCBB
bmRyZXcgTHVubiB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+PiArc3RhdGljIGludCBvYV90YzZfYWxsb2NhdGVfcnhfc2tiKHN0cnVjdCBvYV90
YzYgKnRjNikNCj4+Pj4gK3sNCj4+Pj4gKyAgICAgdGM2LT5yeF9za2IgPSBuZXRkZXZfYWxsb2Nf
c2tiKHRjNi0+bmV0ZGV2LCB0YzYtPm5ldGRldi0+bXR1ICsgRVRIX0hMRU4gKw0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRVRIX0ZDU19MRU4gKyBORVRfSVBfQUxJ
R04pOw0KPj4+PiArICAgICBpZiAoIXRjNi0+cnhfc2tiKSB7DQo+Pj4+ICsgICAgICAgICAgICAg
dGM2LT5uZXRkZXYtPnN0YXRzLnJ4X2Ryb3BwZWQrKzsNCj4+Pj4gKyAgICAgICAgICAgICBuZXRk
ZXZfZXJyKHRjNi0+bmV0ZGV2LCAiT3V0IG9mIG1lbW9yeSBmb3IgcngnZCBmcmFtZSIpOw0KPj4+
DQo+Pj4gSWYgdGhhdCBoYXBwZW5zLCBpdCBpcyBub3Qgc29tZXRoaW5nIHdoaWNoIHdpbGwgZml4
IGl0c2VsZiBxdWlja2x5LiBTbw0KPj4+IHlvdSBhcmUgbGlrZWx5IHRvIHNwYW0gdGhlIGxvZ3Mu
IFRoZSBjb3VudGVyIG9uIGl0cyBvd24gaXMgcHJvYmFibHkNCj4+PiBlbm91Z2guDQo+PiBPaywg
dGhlbiBkb24ndCB3ZSBuZWVkIHRvIGNvbnZleSB0aGlzIGluZm8gaW4gdGhlIGRtZXNnIHRvIHRo
ZSB1c2VyLiBGb3INCj4+IHRoYXQgc2hhbGwgd2UgdXNlIG5ldF9lcnJfcmF0ZWxpbWl0ZWQoKSBp
bnN0ZWFkIG9mIG5ldGRldl9lcnIoKT8gT3Igd2UNCj4+IGRvbid0IG5lZWQgYW55IHByaW50IGF0
IGFsbD8NCj4gDQo+IEkgd291bGQgbm90IHByaW50IGFueXRoaW5nIGF0IGFsbC4NCk9LLCBJIHdp
bGwgcmVtb3ZlIHRoZSBwcmludCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IHJlZ2FyZHMs
DQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAgQW5kcmV3DQo+IA0KDQo=

