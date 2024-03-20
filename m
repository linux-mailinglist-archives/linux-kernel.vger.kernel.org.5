Return-Path: <linux-kernel+bounces-108627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13AF880D41
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAA71F23114
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58CE3A1BE;
	Wed, 20 Mar 2024 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="i288ETuC";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QGT1cGOb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791513A1A1;
	Wed, 20 Mar 2024 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924080; cv=fail; b=vFVsMr3gotUHtjgNpU70doGylTBBtRskbA4gD/0D68wpdmdx3iLujGy9t0zfMbDY9SG8gp+d50HQDx/mdyiTeLj97bwPzH138eS2k5YpXVRszZFthaXDXdMdInZPosg4UcrZaB+3QGxJAxNHClvt4ngiPX8HospcJEItbLj+FA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924080; c=relaxed/simple;
	bh=GTQcl1K34NzNe4lwASdUhURRUi3b+HyrX+sPFxepMPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dvQaUWi4V+OKtT3qTgL2lIJQ743tgFSWJ1m7XMZARTENJ0NIe3+o99E1YrQRJE4/WNGjKF+xmixsfE7ZF4LGDrZgUn21HOrxMucoH3JfdwjdIQjQOMQ4zrqQx8ka4OUaMNH29DpXqqVdVdzLHExk/YQ6iFl5/KYsk7BGoV2yM1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=i288ETuC; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QGT1cGOb; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710924078; x=1742460078;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GTQcl1K34NzNe4lwASdUhURRUi3b+HyrX+sPFxepMPw=;
  b=i288ETuCFoFkIQyKZM8+KKIJjdfSNcIiuKWxGHzKo+19KSAMAR0lIJqK
   esYDAxl9olLuI26UH42i3XJQ1UShFHsBRBjU3+35iJRkf03uYc/7Li8NX
   GhnkdcCrTHSo+8V/VLdarnHeg45NCgclj/7VGsRAfrQX0NBVkZi38EnC0
   40rfqcCHa0DvZDsaPC0q4h3VlwsDxgMNCbaup+9odrGqR6inRSFERJ+Pw
   U0sZXs7pcWUCzw2L21wGgr/U0Jaf/AHcBOKFpFDeJV3ZJGONqjBw7U0uR
   v6OeaNVeJ41cJaecewzhgweqVyYOCbSrmoVpy097U75wZiRP6EsSlYFpP
   A==;
X-CSE-ConnectionGUID: Eqmpn7WqQM+AzgEjWq/awg==
X-CSE-MsgGUID: Cflp9ZJsR3KBJ7/NCL33rA==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="scan'208";a="185158768"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2024 01:41:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 01:40:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 01:40:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhEbFXqqIHI4b512ZhdGue2wyMy4rYROrAvUewsPBh+oroPW4H8Y7LN+LTCbVUcmiSBmwl0BCjTAAiEFKGHxWbLTywN55UtMFR1JoeYpnX5954f5ahPkp6yiDZFHJ+b9JwnXFhtKAs+Y2MKGF9vxUIJ98U9Yn1gV2eSXbCvkma0FOrI/KHY37et4pGdTuKvxFy9IPkSmc35CHm4Zj1J6Qzf9V1H/D/Vh1Z699xDXXsHb+31X0GAloTRMPiySTsi+KT1fEQ7WVMAnQ3xf5HYdo2sPYHHrTDRvMT+3WfksiIC1uiRwICDFajugGKdNMVJyOm/mn8OtsqgRluYAnz4Lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTQcl1K34NzNe4lwASdUhURRUi3b+HyrX+sPFxepMPw=;
 b=nnY5Dapt1HmqQ6FRy+ftm8Avh9OMRt/pGWXcOalRtZjIGLsGTvO/rHIaymXuT9GxFcbWYZWlG9mrKtxy293/YcG3BkEKmgw6QjtmS62MMaIEzo0KS6zRUKwTu8riC6JC59Xl3UADIY2VaIoxx4ZO4LsUm4zsdF3uXCEd3QS1WMWDRcQHhlocTZ2WJq08qZ8rHzvfBe1jKns15W5KIiXuSQq8EYkJDE9eqyt5gxk9sObrMU2JPfvCwD2WQgS/eL2oYGuO9gWAFXDLjGU72mdfNmHlCI7CAR/gMQiTqwAclGDH99Tt7vGFslfO6BfpUnMemiPJjQkXoLLlvZxz8CnmcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTQcl1K34NzNe4lwASdUhURRUi3b+HyrX+sPFxepMPw=;
 b=QGT1cGObDX3sIXfLZeg33tbNfLDZkPOqeygsYCEOhHixid8ceDgSWL169toeGC0sdE0qrOG8oYNxtQOi82QgmxHC/hhMk2mzqUBhjkkF6IxIhnwU+l8NdcuH/y1c98SrzU8LaktNA1DRKpExB2TzKE5YaQM/uOpNnkDto8KgFTCsBL9K981VaDlTTqtVqbeHU7YZPbU3VRUx7OcKYBVAsQpfdZ6M4C6iITWfZvAEnee54fe/GevWMJC2WSWTCzDRvCs8dOcFrydsUfN9tXbyIwl+XveiItbBnoc6LcI+f/r9jGpA65RdszNLm6rHlR4lZouV86eGNnP/n85xl+BSuQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SN7PR11MB6948.namprd11.prod.outlook.com (2603:10b6:806:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 08:40:45 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Wed, 20 Mar 2024
 08:40:45 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <conor@kernel.org>, <andrew@lunn.ch>
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
Subject: Re: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHab6Ox6ghenOTJpkWNbGLTwd03cbErBYYAgAAJFoCAAANkgIAVU1wA
Date: Wed, 20 Mar 2024 08:40:45 +0000
Message-ID: <05a9a7ee-e4f0-443e-9c8a-8ee649a11448@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>
 <20240306-spree-islamist-957acf0ee368@spud>
 <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>
 <20240306-ripeness-dimple-e360a031ccde@spud>
In-Reply-To: <20240306-ripeness-dimple-e360a031ccde@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SN7PR11MB6948:EE_
x-ms-office365-filtering-correlation-id: 54da5262-f4df-4d3d-def1-08dc48b96f47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4iG2SqLa8RcQFtjchaVsMAiqwPpWuMDTWZTBkyVR3PUOfMt3pykcTRIs+7GC/hHiXA+yz/i4BSB6KBxuGk4Ie3/9svFpjfOtUD6RtwdrveJSRQPXoGb7ZB+uKTFUlzFCqX1WrxFQhSS8g08DQTNxfGKFmbLikwxSbXQtmL6BnUB/3F9yD6wrKgpy3FYSge6CQQ34of3uxi8tCLpFf5cFAYzu8v9UKdyCltAryFNdCum+Y9IMjCCiTEcaxKMWaZPFfWzSA2OqLwZCmnWR+4LZI5QCWbdSCtPN/irnXMTG5dyy718+LrQlCTtd3qHTXZL6aEmzLuVa0ssFf/WEcQkI/clwZAhsnfpdpl1EsjKZ8wl5lFTl8AjTK/bcLdMjbzfqeOZc8spAkK7cmWuKKbaEGYBMLglXExUeqEWXGulNT/a5WusHgFK51LzOdMcpHiJ71RbteGAVTaO2S4rj2w4OcF8AF3o18RfTmE2pQzJhZXQyrwMw0m27ChHUed7pMwKZT+JRpudTSqvRJleJ5mDR3nOgYlvOy4DH/fBbaZndbkd6DkhzAf0hOZDu3fgqw5b25SRWBabimCRMB9JtqiBntX6e0IKKC1WMHRuR9GAvQPorAj1GWHISUi8gd4SizAjoAfL80frWRy7SR8dDn81hH+6KdNubiDtg2VI05dcHgdzhO1MM86Wr6FdSL6BuHzjVJjXX+9qIUVlipL763ZKtzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0VoUld4RjZLSGRIQk1OSlI2QjRPZzZqaVZCZXljMDhjaCtXSm00NC9ocDZG?=
 =?utf-8?B?bmRmbVkxT04yNTU4OFY0STlRN281K1BUMUozWGdIak5nZndRdG4xQjRaR0Q0?=
 =?utf-8?B?d1N2ZVZ6b1Y5VmNtRjZpM0xUNUQxdjdsOWc4cWVjSjkxbW5CeXl6V25aMkY5?=
 =?utf-8?B?SE5NT2FST2d4Qm1BUlFQdnkwTW1LRkZzaUprUDU3dlZQSGd0S1I4ejU5RVJG?=
 =?utf-8?B?NzhoMzFHRXZNaGtZZjlSRG5rL0xxOEpMNmtHWEkvcmhIZ0tQcUczWFZKQUlQ?=
 =?utf-8?B?SkxVb2JZQzZ6UTdPSXlKTjJoNzdVb1ZEcEh1aVhPeTI4NUh6aWpqaTFCbC81?=
 =?utf-8?B?M0IrcnVwalN1UEVRWlFIOGJNQnB4MHdvNm1CVzFDOXh1b1dPQ05Zdnc4Q09p?=
 =?utf-8?B?aW9LaWVKVmhRMjNqWG1BSGpjTFNvRTZYYVMrZG1HQThsanRodFB5S25OZXdO?=
 =?utf-8?B?Yk5OSndmUWIxdTFwSU1pYTk0aURkcWcveU9HbzV1Wk1hbmpSMDY1dnp4bWh4?=
 =?utf-8?B?SStlVzhoMFpiOHBOVk5vMWQ0eWQ0YnlqVE1SZjc5WHRiLzRTZlA1cDU1NVZ0?=
 =?utf-8?B?aWxyZmNLWDladFg0Z0FyazlVaTM1Z0tVSTh3OERzeG4xY2M5ZlpZWU5RSjNI?=
 =?utf-8?B?bUtMZCszS3FMMFdYMjJuRXlGQk1WWUxabE5hTkhQWk95KzZtQ2VZbHFJdlZx?=
 =?utf-8?B?N3k1Zm5LRVA1L2dRNkVXd2lDNlE0SG9Na28zazZOT1FhTUFvcC8yWmQ4Y3hJ?=
 =?utf-8?B?UExMeWxLQUU1YkFudlVCdUxFU1dGaC81M0JqakxOM2JXNHNHdlUxY3BIdlpW?=
 =?utf-8?B?Uk1hRzBqUXBKcEFGVDRlV3k4bThzbjVhalVRTEFIY0djK3JldkQyOC84ZXFD?=
 =?utf-8?B?bjZodWpSdHNJSmRldG5CNjFwMXduTy9jdEhkMzJWNTNnRzZDUlRDMlgyWStV?=
 =?utf-8?B?Uk9kWXRHcU1GSkhEYktvM1U5cnhyM0VMYzlFTVVzNWw0TTQ3RnZwVDZ0eTVI?=
 =?utf-8?B?YzNUdm1GTnZ4MmV5U29Falc3ZnRaS2lEanVPSUhOUmhFV0lBdnNYTmlldlRY?=
 =?utf-8?B?L0ExVFdsNWtLSUpZU0tDMG1BYndXTlBBcG5VejNyVEtacjZrSUY0VjgrMlYr?=
 =?utf-8?B?dFRrYStuckJndVlhZ2YwT3RaNjJTRDhxbVcyK3k1U1BzK3Ryd0NHdXJENEFR?=
 =?utf-8?B?UGl2TS80ZXpzbS9EQ2ZyUTlraWdHOWVYTm43cy9ReW9CWGhBSEtJaWNYSkp4?=
 =?utf-8?B?bDJqTFYxRVdyT0dDQ2JWN1ZhR1d0YXNuOFlKREltV1c2TnZIcFRkNjFPTHcz?=
 =?utf-8?B?Y3ZPS1Q1M1Y0dVNyTGZOOUdMbUZ5ZmtRRkNMbEJId082M1dteTlBM0t6NWQz?=
 =?utf-8?B?STNwNzREYVlRU1ovQ2x6MC9qNm4wSXNVQ2FqY1BGL1pKWE9FTGZjYnhIeXBn?=
 =?utf-8?B?dTd6aVJEOTRCaXlBQUFxY3plN2kxU2twbkI2dC91OW42ZFNGYVJGZjRDMFlj?=
 =?utf-8?B?bHljL0MyL205U1ZnY2Mzb0o4WVRsWmtaeVpGajVSSXZhRVdMVWNBQzVFQzFM?=
 =?utf-8?B?TERTVlpHdWlhTzBQemFpeHdCSFM1MDNsTDVQYWxHb1BreGJjOU01MU1yM1FV?=
 =?utf-8?B?THdtem13L1VtckZGZHlIeGo5ejdCMHdmK2QvWjcydjljcXYrN1d0amUyVWc2?=
 =?utf-8?B?YXh3UDRZK0xYZW4ySDZIdG1rakxFMzFzeUJVSWxxSVpSSUJHdXJZNjhwQUIr?=
 =?utf-8?B?TFRhN0tjcmhXUlMvWnU0WC9DbWR3aU5JUW1ES3M5T0dreEkwdUZtdW1ZZHRZ?=
 =?utf-8?B?MGxjSTh1UkFSNWlndk91MElIc0pRRDVJUkc2a2x6WUFJZlozK3RIRW5GQlk2?=
 =?utf-8?B?YXJncnAyc29FdEFneWxsSVcrNmVvRVVJYUZNamR3NEtISnZ6dzZuMW1DSVRj?=
 =?utf-8?B?RFJNRXlrdnNnTlJqam5YWi8zOHFYN0FWbm5KdUovYSt6Y3NKOUhORWNRa01x?=
 =?utf-8?B?VHJ6WUdGYUZTeVU3UUpKOXNjUmhQZ0xJeGVCZEtzQW5wMzYwcmVSYVRSMllJ?=
 =?utf-8?B?ZGlpVkYybXM1VUI2QWVRSGRJOHBhRzZQMFBPY1JwTk1DbkVCaWtCYjB1T1JF?=
 =?utf-8?B?WkJwczI1aEc5RDhIYVp1cUcxcXZLWGYvSVlKMDRMTFZtSGY2dFloRnZuVlln?=
 =?utf-8?Q?RRjQ7uiDIYokfx86WqHeYsY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C12060FA5CBD58499D7C34AB23E6CF4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54da5262-f4df-4d3d-def1-08dc48b96f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 08:40:45.2355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kp4reUqkGSh2kXH8FEEMODHPw1mGB5PBoYA8NRNMiwjVrZLqmMM91XpFx6Cxs1V626qsdhWaxtQJEy6Npkp78ZRO+sF5sq3jhr5GV2TYctVNb3zPlI9YXO1o8+Aoooou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6948

SGkgQ29ub3IgJiBBbmRyZXcsDQoNClBsZWFzZSBmaW5kIG15IHJlcGx5IGJlbG93IGJ5IGNvbnNv
bGlkYXRpbmcgb3RoZXIgdHdvIGVtYWlscyBjb21tZW50cyANCnJlbGF0ZWQgdG8gdGhpcy4NCg0K
T24gMDcvMDMvMjQgMTI6MzEgYW0sIENvbm9yIERvb2xleSB3cm90ZToNCj4gT24gV2VkLCBNYXIg
MDYsIDIwMjQgYXQgMDc6NDg6NTdQTSArMDEwMCwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+Pj4+ICtk
ZXNjcmlwdGlvbjoNCj4+Pj4gKyAgVGhlIExBTjg2NTAvMSBjb21iaW5lcyBhIE1lZGlhIEFjY2Vz
cyBDb250cm9sbGVyIChNQUMpIGFuZCBhbiBFdGhlcm5ldA0KPj4+PiArICBQSFkgdG8gZW5hYmxl
IDEwQkFTReKAkVQxUyBuZXR3b3Jrcy4gVGhlIEV0aGVybmV0IE1lZGlhIEFjY2VzcyBDb250cm9s
bGVyDQo+Pj4+ICsgIChNQUMpIG1vZHVsZSBpbXBsZW1lbnRzIGEgMTAgTWJwcyBoYWxmIGR1cGxl
eCBFdGhlcm5ldCBNQUMsIGNvbXBhdGlibGUNCj4+Pj4gKyAgd2l0aCB0aGUgSUVFRSA4MDIuMyBz
dGFuZGFyZCBhbmQgYSAxMEJBU0UtVDFTIHBoeXNpY2FsIGxheWVyIHRyYW5zY2VpdmVyDQo+Pj4+
ICsgIGludGVncmF0ZWQgaW50byB0aGUgTEFOODY1MC8xLiBUaGUgY29tbXVuaWNhdGlvbiBiZXR3
ZWVuIHRoZSBIb3N0IGFuZA0KPj4+PiArICB0aGUgTUFDLVBIWSBpcyBzcGVjaWZpZWQgaW4gdGhl
IE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUNQSFkgU2VyaWFsDQo+Pj4+ICsgIEludGVyZmFj
ZSAoVEM2KS4NCj4+Pj4gKw0KPj4+PiArYWxsT2Y6DQo+Pj4+ICsgIC0gJHJlZjogZXRoZXJuZXQt
Y29udHJvbGxlci55YW1sIw0KPj4+PiArDQo+Pj4+ICtwcm9wZXJ0aWVzOg0KPj4+PiArICBjb21w
YXRpYmxlOg0KPj4+PiArICAgIG9uZU9mOg0KPj4+PiArICAgICAgLSBpdGVtczoNCj4+Pj4gKyAg
ICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbGFuODY1MA0KPj4+PiArICAgICAgICAgIC0gY29u
c3Q6IG1pY3JvY2hpcCxsYW44NjUxDQo+Pj4gVGhlIG9yZGVyIGhlcmUgaXMgd3JvbmcsIGxhbjg1
NjEgbmVlZHMgdG8gY29tZSBiZWZvcmUgdGhlIGZhbGxiYWNrIG9mDQo+Pj4gbGFuODY1MC4NCj4+
IEkgZG9uJ3QgdGhpbmsgaXQgaXMgYSBmYWxsYmFjay4gVGhlcmUgYXJlIHR3byBkZXZpY2VzLCBh
bmQgaGVuY2UgdHdvDQo+PiBkaWZmZXJlbnQgY29tcGF0aWJsZXMuIFNvIGkgc3VzcGVjdCB0aGUg
LWl0ZW1zOiBpcyB3cm9uZyBoZXJlPw0KPiBJdCdkIGp1c3QgYmUgYSB0d28gZW50cnkgZW51bSB0
aGVuLCBidXQgSSBkaWQgdGFrZSBhIHF1aWNrIGxvb2sgYXQgdGhlDQo+IGRyaXZlciBlYXJsaWVy
IGFuZCBzYXc6DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBsYW44NjV4X2R0
X2lkc1tdID0gew0KPiArCXsgLmNvbXBhdGlibGUgPSAibWljcm9jaGlwLGxhbjg2NTAiIH0sDQo+
ICsJeyAuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MSIgfSwNCj4gKwl7IC8qIFNlbnRp
bmVsICovIH0NCj4gK307DQo+IA0KPiBUaGF0LCBhbG9uZyB3aXRoIG5vIG90aGVyIG9mX2Rldmlj
ZV9pc19jb21wYXRpYmxlKCkgdHlwZSBvcGVyYXRpb25zDQo+IG1hZGUgbWUgdGhpbmsgdGhhdCBo
YXZpbmcgYSBmYWxsYmFjayBhY3R1YWxseSB3YXMgc3VpdGFibGUuDQo+IA0KPiBZb3UgY3JvcHBl
ZCBpdCBvdXQsIGJ1dCB0aGUgcGF0Y2ggaGFkOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAg
b25lT2Y6DQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsgICAgICAgICAgLSBjb25zdDogbWljcm9j
aGlwLGxhbjg2NTANCj4+ICsgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLGxhbjg2NTENCj4+
ICsgICAgICAtIGVudW06DQo+PiArICAgICAgICAgIC0gbWljcm9jaGlwLGxhbjg2NTANCj4gU28g
aXQgZG9lc24ndCBhcHBlYXIgdG8gYmUgYW4gYWNjaWRlbnRhbCBpdGVtcyBpbiBwbGFjZSBvZiBh
biBlbnVtLA0KPiBzaW5jZSB0aGUgb3RoZXIgY29tcGF0aWJsZSBpcyBpbiBhbm90aGVyIGVudW0u
DQpBcyBwZXIgQW5kcmV3J3MgY29tbWVudCBpbiBhbm90aGVyIGVtYWlsLCBib3RoIExBTjg2NTAg
YW5kIExBTjg2NTEgYXJlIA0KdHdvIGRpZmZlcmVudCB2YXJpYW50cyBidXQgdGhleSBib3RoIHNo
YXJlIGFsbW9zdCBhbGwgY2hhcmFjdGVyaXN0aWNzIA0KZXhjZXB0IG9uZSB0aGluZyB0aGF0IGlz
IExBTjg2NTEgaGFzICJTaW5nbGUgMy4zViBzdXBwbHkgd2l0aCBpbnRlZ3JhdGVkIA0KMS44ViBy
ZWd1bGF0b3IiIHdoaWNoIGRvZXNuJ3QgaGF2ZSBhbnl0aGluZyB0byBkbyB3aXRoIGRyaXZlci4g
VGhhdCdzIA0Kd2h5IEkgaGF2ZSBrZXB0IHRoZW0gYXMgZmFsbGJhY2sgYXMgQ29ub3Igc2FpZCBp
biB0aGlzIGVtYWlsLiBIb3BlIHlvdSANCmFsbCBPSyB3aXRoIHRoaXMuDQo+IA0KPiBJIGp1c3Qg
bm90aWNlZCBhbHNvIHRoYXQgdGhhdCBlbnVtIHNob3VsZCBhY3R1YWxseSBiZSBjb25zdCwgc28g
SSdkDQo+IGV4cGVjdCB0aGlzIHRvIGJlOg0KPiAgICBjb21wYXRpYmxlOg0KPiAgICAgIG9uZU9m
Og0KPiAgICAgICAgLSBpdGVtczoNCj4gICAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbGFu
ODY1MQ0KPiAgICAgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxsYW44NjUwDQo+IA0KPiAgICAg
ICAgLSBjb25zdDogbWljcm9jaGlwLGxhbjg2NTANCk9LLCBJIHdpbGwgdXBkYXRlIHRoaXMgaW4g
dGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCg==

