Return-Path: <linux-kernel+bounces-57623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C6984DB88
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99F91C23CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E16A8A2;
	Thu,  8 Feb 2024 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BvoUX3yX";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uRnajwJ/"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B92AD1D;
	Thu,  8 Feb 2024 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381400; cv=fail; b=qsmF0jn97ZKmVGiwooI2R0t3JDj2+wgxailXgDPUcSxNTzxnx7hsM0Xk26T0jn4BtljQ3l4nRdOnMFqTM+uRAT//67NI45OpMxjbAH2wjHwg/jeGVZxm9HemLg4TWijMUHMoHN2t/ssuoMV/3frjCsxKe+k0iEH14uPneBuk0LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381400; c=relaxed/simple;
	bh=SOY1OwOyNelkxPOdufyWUhUhRnqjPxfn9H+cB48vsi4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EjcAYQAAm51FXW5wJ2mDnHs/xckWxs9Hfb6V3Lk8ViWvrI1EhJp1ROMR8SGCu4J4DZ4CC44YBOgJKoXzg1j6O+YjbBPdmfz0sPqd6aR5YrDWezOvra28V0L5H+W+WA3tel6jkLDC2a7nrvR2DsQieL5XJM79yhapppgrg4nietc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BvoUX3yX; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uRnajwJ/; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707381398; x=1738917398;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=SOY1OwOyNelkxPOdufyWUhUhRnqjPxfn9H+cB48vsi4=;
  b=BvoUX3yXOq+DuubW66N5YpJ1fT3ZwDzSahvy/CZkSSV0mctyx6iITrpU
   ncOEBOFjRYHmZQtariDSTeP0YgRw9gLBgqxcLPLQOsjrOSxEWAUZX/QjG
   rVCa2VKYukXXx8sNpS9psh3rGhwBr4yuVSOBFbfKt8Wa0GY7SINk+dMCY
   DetrzvPQhxaLvWlvZKXXEQmnvRRp+/QgPEUfIDSLAlySvU3E6Jo0slFcC
   3ok2yS4Bm/iVeM5k+z+lXi0c6c6TjjIDmaD1SMNa+Mnox/NLX+C92mXqF
   /ZY2fKHgzDWm+1d+Qa6LyPaYerIvCHWqO/6qv1BZlS06H7rexqp7Pmn83
   g==;
X-CSE-ConnectionGUID: QqN0UMcNRjmV0GgjQatiag==
X-CSE-MsgGUID: Mm6FFJmLSYml+WrF9tK2ug==
X-IronPort-AV: E=Sophos;i="6.05,253,1701154800"; 
   d="scan'208";a="246684010"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2024 01:36:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 01:36:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 01:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxA3M40JMknNDxt5OdRZNtFGaB8JlLIQrN/5MN6B4BLoXcMCt78AqhI45EKiBjxSmk768d05zGfCD3J9TVq0KIKlZ16ULT1Is2foCamZPL9os0C3XsG5S+1UHmrtHLgKrLiGWi1dvAjSFDnF1jxd1B5zDtmfU9NxPSDtYq+gefXX1LFc/tD5kvlHv2Xptb5kOdpiLusl51UadFd5RonmT5wDtW5sGdCZ7c7T/BQP8hulHRHcGGBpsblqF+gEXCyU6gH20H++CpdQu1Lpc6qDU0cZ5r+0MiyXC/d/TX5xbfZpt5eXOCi5WcwL3zwND2Uzd9Ab/EyYxPrxv5kWwcw38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOY1OwOyNelkxPOdufyWUhUhRnqjPxfn9H+cB48vsi4=;
 b=m6aC7jEl60evW0gcH5YeTZUIR/FqwAq4sTEBLOWF8Ls2WE7tpY8B8XBw88EVbkLgqCcoJzGQBtm349OgIu+DBwWYJay63S/1UIHLU0bxSqHbkka0BEwMwI4M7cW9AhHc7qHi+DPAFLUfWVgQmZjy+NB27CnDNFHytzdgQ52o3Kx9x+icF1DHCn8GjesG82tUueWvMiH2QOtTAx+DibRpLc+AiGKwj9G5VdRgdg3myL8opIxFxAAB9Rb3qA8yLP8Bo1PQGBdBU6Kpky13rGfq+QGeePAq4uFqa1+ESJmwIlaRm1zsUCQW3D12Xm5hKnjNgTLMKTKKLcMjJ+R7GG234w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOY1OwOyNelkxPOdufyWUhUhRnqjPxfn9H+cB48vsi4=;
 b=uRnajwJ/iuO0UXFwTjRJWy7gaIfvAv/Xz+zRmmmExdBNse32TSlJIyWp7hWslvjCGlLYeCTdD6BZXYmXEgNtyl/uZ1x8t/OrS28oQSVDckpsq6k8sBI3z5lHe4Nggtyt2Jnf9/Uf8GSUVFnwteiVVEtA22ssExhInLnpCb++slGgRXJRN7wZ8MsLOqAN9eVcRrZc8Ya//uzlTxE15bGCxCOHLadqoLkPL+buv9o3ASpBS03yRr2ENZ3KDm2pKbzNOyPAMPLp/ehYDCL3pSZHqEjXUc7TukuBT5hsaVPAVxfTxBcmFvITeXgPyoaMmdB1PpXhQosZTPVAURy7EJ0Tmg==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 08:36:08 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 08:36:08 +0000
From: <Dharma.B@microchip.com>
To: <krzysztof.kozlowski@linaro.org>, <dmitry.torokhov@gmail.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: input: atmel,captouch: convert bindings to
 YAML
Thread-Topic: [PATCH] dt-bindings: input: atmel,captouch: convert bindings to
 YAML
Thread-Index: AQHaWaVZ3HXNK2d4rUGusN/lqEUw5rD+/aOAgADVnoCAADqcgIAAEpCA
Date: Thu, 8 Feb 2024 08:36:08 +0000
Message-ID: <070f94b5-afe9-4098-8a6c-ae98104f94bb@microchip.com>
References: <20240207090853.188400-1-dharma.b@microchip.com>
 <982e81db-3bf9-49e9-b57f-a91612d62f5c@linaro.org>
 <09c25824-f56b-4598-b8cc-1df992812754@microchip.com>
 <6e703599-0389-435e-b163-55e5a046a8f5@linaro.org>
In-Reply-To: <6e703599-0389-435e-b163-55e5a046a8f5@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|LV8PR11MB8608:EE_
x-ms-office365-filtering-correlation-id: 940210a7-b0df-45fd-d6d1-08dc2880ff71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 893vxXwAE3QahHtQ7Ug+KGpMNKYYW87npxSqQz3pNkRl/LZJwd1dzn9bQPP41EDrPmfJrRoKkZRSGAaLGrh7KJPfFbMHThcl+AMIXeVNachFTQeXPg0JIS0cEuhIUUrL5bYeTdneHHtgLvuCmwT+UWBNYbZ1eopK7iYzy3z8pzVjw7a8m4e+3b2abqVss4o4yGyJEndOgz6zHCGMF/ar9WxDOL5VJcDdj67naDu6zZDFVFmV2UZIF4WKUltm0RRw6wfoSX8BTAsfFZktTtLWmljoUV656+4AIenW4c6YbGXcoqTBzBfEpC2kCI7KN6DjRhQRnFqVBu7r1a94H2ABqb0F34/l2yDNKX0kNtlJicTvSWocDtmme4eUpJbXSBl7KOQgYle8liRxWDMeKGcwxaACTgXDIeTx78BEtee065TufMmE6y3aXWNVPCi5Zh6XgABPMXYCKmOdodQvqYEpchgxIrINM2IgBLGDPc+yOe+FyrNKC/5q9B/c7vHq5uo/w4tzXG4U1pgxJnzhgRG5u5Gz/k9NlbfcYQRnsbe99qYb10m0ZC9HaUgMpYVB2jP9es7oWucAlesBu5Cww9PynoNPDAeuWvoUUcR1Z7AfG8N/9/iYY2hXQ2hwdHRPAO37nIK1HN8Xk+KDvNwn67j1ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230273577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2616005)(122000001)(26005)(36756003)(91956017)(6486002)(76116006)(66946007)(8936002)(66476007)(66446008)(64756008)(53546011)(110136005)(71200400001)(66556008)(6512007)(478600001)(38070700009)(8676002)(6506007)(316002)(38100700002)(86362001)(31696002)(41300700001)(5660300002)(7416002)(921011)(2906002)(4744005)(31686004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUNHaFcxV2JGeU92OXVwNnl6UWxkSTBwSnNUNGVkUVRWOUJ6WUVjTnQwR09t?=
 =?utf-8?B?cjhLNjVEWlc2L093VnpHMGE3MjBsRmpna3Joa0puRjJRWHBMWFpyYzlKdUhF?=
 =?utf-8?B?dGRFRWczVXhWSVduanVpVEQ4WFlxOEJQL2NpdlRVOHNPV0FMRXo3ZWtFbERw?=
 =?utf-8?B?VHk1Y08zbzE2MFBObVV5SS8yY3BMZ3o5c01COXdtTHRiTHZHZko5YUJ2cnJl?=
 =?utf-8?B?K05QMEFlVXdISGl0V1huK2M1Q29tOEZWT1R2VHlZTCtmZ1BacUxYRkRtK1Zr?=
 =?utf-8?B?K1IwakNmQUVyV3JOM2ljOGd0SzArakV0c2VoVVhmYm82UmxhMzI0NDJYc3dH?=
 =?utf-8?B?VXdYcEp0azlhbTZUVUlDRXViNTdXVE8xdW55VGhVZVVnSityaTQvWUhiUHlU?=
 =?utf-8?B?OW41M3pJTVFDaWpLaURPSnl3RHVCUnRzL3IwazQwRnk1TUxxcXRZdmhJZmk2?=
 =?utf-8?B?OWpaYlF5NjJzRE95NUFTNjc3TmdycXRodFB5aVVFVElLTms1QVJ3US9penlQ?=
 =?utf-8?B?Z3c3SEZrVVJyM1IyL0RaenhFS2ZxT2hmREU3STh2RmdnZWl3UUlDZVlzVW1L?=
 =?utf-8?B?d1N2ZkF3RnpxQkEwMjE0aEx1UGZidkgrakV6YW5qYTZKVDV2U2RzU2xMVVVl?=
 =?utf-8?B?RlZTUmx2bE0yOVV3SFB5bzZnMkQ0NEUxSnQ5NWVvREJLQzNmTHJVQzV2aFlJ?=
 =?utf-8?B?eXhFTTJuczJlNDU3ZW0wc3cwdWF2YjJkRUJPUndXM3laMmQwV1ZUUUFRdTR2?=
 =?utf-8?B?MWJZV0MwZ3NtR0NWUnVxTkYwM3ZRNDFVZVliVGVmajNDM2E5VkdTMk5tUUQ4?=
 =?utf-8?B?TlluTVlKbzlFSXhCMWlCeUJEQU5yQi83TVphcG9ZcWp6UitIdnBhZGk5VXEx?=
 =?utf-8?B?QVhzanlPZ2xSUTM4U0g0VTJpY01TeHV2ZkREUTdxRjkwQnJ6d2lkclpENDF5?=
 =?utf-8?B?TEhNK0JoeUljWjU0WHBIRnhibGdYSDFhL2F6Qnd0Vkl4WU1lZy9GckxXNkZC?=
 =?utf-8?B?Zy9lbkJZOHFnUHJUK0hhSjlnck40V0lqQU1ablY1SDNKSFpMaC8yZEd1Vm1l?=
 =?utf-8?B?a1cxdThPN0k3NCtiRGpGU0RoSFJvL0JHQUptSFhGTDVKOGF1UzlyV2J2MWlk?=
 =?utf-8?B?TUhGVFN0Yk4xZzlnVXQ4bzRzSUhDK1pGZURoY2IvYUpGZ1RsY0JETjM3eUx1?=
 =?utf-8?B?Vk9TcStuRWlzY1U0b0FSTitqNVZvaWFibEtwZDJrYUtDV2VnZFFLZit1NWNu?=
 =?utf-8?B?M0hjUFFUQmJCTzZDQkQrY2lnWVdoZ1hjK1U5aUVzOUhWcHRkaCtnam9mdDRr?=
 =?utf-8?B?RkJwdW9pSVJKaHBmdDlGaWwxS3VVeWl1T3RoUy85bmtYREZiamlQR1BSRkls?=
 =?utf-8?B?QlZGbERFT1d3T2ZzUVd6bU90UjIxczlESWpac1ZXK1hxYXFEemVXWStWd2t6?=
 =?utf-8?B?SmM0Y3c3OG1pMXhsQm5xbUh1UFpVeU9jTVlwRjBFNGF6Wm45b2M3bEdmenpY?=
 =?utf-8?B?RVAraUxkR1ZyQmZWWCtBNUp6akpGQzR2bjVCbFlPL2ZCbDRteFdPT3NrNGdX?=
 =?utf-8?B?S2FtaDE1VHZTSG15QytFSkljU0dVTzF5KzBQMVVKNm5Wakl5Q25rSmN0VDhy?=
 =?utf-8?B?Yzhaa2JoT3kveG4va0k1OGpRblpZRytWNG1ybFJZeERHKzlEQUp5WUdjMVJx?=
 =?utf-8?B?VDJHTVIybEtkTStDcFM3NEdtcXM3amRDNi9kbzlzWFNFdWEzWThiZVVhN0JQ?=
 =?utf-8?B?bzRRVkFnbWUwN3dHZTJzcmRIYTZzdEJjR21SOWExa1pOdnRjWm1mZzR2QUR5?=
 =?utf-8?B?d1I5MmpVU2o5QmR2SmsvOUV3NkNyVXRRTWZ5aUFlWWFBekxpd2l0eE44aVp1?=
 =?utf-8?B?d1RvaXFRRkVqRW9GZTlEY1VaZEs3VEp4cG5zcTk2dTVJRms0c0YvME0yOUxB?=
 =?utf-8?B?T0FZc3hSS2ozVGZuYnhYUnkxZUJBZUg1bmJYNUlkTGNyeFpHWndNVCtkTVZH?=
 =?utf-8?B?SUptei9sUXRaYU5kQVlsandjbmF0N1M3MDJlSDI5djM4cHhDOWo3ZGphM1FC?=
 =?utf-8?B?TnJuVytEbHpaZk1wTGJRd1ZwbVp5Z3Y4L0MvcUZ1OHU4TFlqaUZEOU9saUtV?=
 =?utf-8?Q?wvZyQizZEzVR45VOQTEgEAW7y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13F64A6D58148D4E9BA7899624DDB4DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940210a7-b0df-45fd-d6d1-08dc2880ff71
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:36:08.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ti0VPnXkcfluBUCdoltxRoEmPVg7XMvL0DEZ1mP6peM+SmZ0Z78V5Hgu2m+Tj6/h71YCaJru53d9fQ9rWRkXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608

SGkgS3J6eXN6dG9mLA0KDQpPbiAwOC8wMi8yNCAxMjo1OSBwbSwgS3J6eXN6dG9mIEtvemxvd3Nr
aSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAw
OC8wMi8yMDI0IDA0OjU5LCBEaGFybWEuQkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+PiArDQo+
Pj4+ICtwcm9wZXJ0aWVzOg0KPj4+PiArICBjb21wYXRpYmxlOg0KPj4+PiArICAgIGNvbnN0OiBh
dG1lbCxjYXB0b3VjaA0KPj4+PiArDQo+Pj4+ICsgIHJlZzoNCj4+Pj4gKyAgICBtYXhJdGVtczog
MQ0KPj4+PiArDQo+Pj4+ICsgIGludGVycnVwdHM6DQo+Pj4+ICsgICAgbWF4SXRlbXM6IDENCj4+
Pj4gKw0KPj4+PiArICBsaW51eCxrZXljb2RlczoNCj4+Pj4gKyAgICBtaW5JdGVtczogMQ0KPj4+
PiArICAgIG1heEl0ZW1zOiA4DQo+Pj4+ICsNCj4+Pj4gKyAgYXV0b3JlcGVhdDoNCj4+Pj4gKyAg
ICB0eXBlOiBib29sZWFuDQo+Pj4NCj4+PiBZb3UgY2FuIGRyb3AgZW50aXJlIHByb3BlcnR5LCBj
b21pbmcgZnJvbSBpbnB1dC55YW1sLg0KPj4NCj4+IFN1cmUsIEkgd2lsbCBkcm9wIHRoZSAnbGlu
dXgsa2V5Y29kZXMnIGFuZCAnYXV0b3JlcGVhdCcgcHJvcGVydGllcy4NCj4gDQo+IFdoeSBsaW51
eCxrZXljb2Rlcz8gSXMgdGhlIHNpemUgcmVzdHJpY3RlZCBpbiBhbnkgb3RoZXIgcmVmZXJlbmNl
ZCBzY2hlbWE/DQoNClNvcnJ5LCBJIG1pc2ludGVycHJldGVkIHRoZSBzdGF0ZW1lbnQgImVudGly
ZSBwcm9wZXJ0eShpZXMpIGNvbWluZyBmcm9tIA0KaW5wdXQueWFtbCIuDQoNClRoZSBsaW51eCxr
ZXljb2RlcyBzaXplIHNob3VsZCBiZSByZXN0cmljdGVkIHRvIG1heGl0ZW1zIDggaGVyZS4NCg0K
SSB3aWxsIGRyb3Agb25seSB0aGUgb3B0aW9uYWwgcHJvcGVydHkgImF1dG9yZXBlYXQiLg0KDQpU
aGFua3MuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQotLSANCldp
dGggQmVzdCBSZWdhcmRzLA0KRGhhcm1hIEIuDQoNCg==

