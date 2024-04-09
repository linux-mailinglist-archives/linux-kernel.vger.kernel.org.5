Return-Path: <linux-kernel+bounces-137030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F7C89DB56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90ADB22A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353C312FB23;
	Tue,  9 Apr 2024 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0GNwTgz7";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5R0ktwPL"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E381127B67;
	Tue,  9 Apr 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670880; cv=fail; b=BLKSfYXQ+yMmbLU4bb4xZ6RdkMneP/Em74sYRSFiQMNaGg+rseRw2Xlfq19TU3i+AHYnFWLclN/qBxa5Dh8lYcbeTCNwQX2SDtSEns7xumLdtr/QtIo2Ehn5uGT1VIlSdj1HOuLMtP7UQlwidjw+41+/ox6/dHqxqGSYaaPTXHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670880; c=relaxed/simple;
	bh=VH7D3eRQwjIyPug+yIhWqCP3zeOnX5bdTvNZc2msaNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f1qp5jiv7FEMHPDCV/x1T3cUNTXe3qglggdLDWehinOXqq8hRo3Jc6P1y6noT9t83a9O+HfxLbO5Fk3MXaClx0W/3FMMHQdnCdrx3Tcskf/dFDyUJn6aH0VdLmAZk6+SzhpybFGNtkTTpf0GrhT0/6DS8QkaZkq/XSlCNFSFmD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0GNwTgz7; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5R0ktwPL; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712670878; x=1744206878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VH7D3eRQwjIyPug+yIhWqCP3zeOnX5bdTvNZc2msaNo=;
  b=0GNwTgz7Wyr5mQLMSkUXWzEVFrf3kQqNFmfTu5YQjsrWHg3St6zzwsRq
   Ga0IitH+CM6DkBbC/I8zeMeloguc2Bzp3fJUKeZ6S0KgyYcGP5cZW5uMn
   H95wMFLC8CfKUxedzwfLtVvhsgPYLt0bZp63HUF/dmKGQ1iVeN6mdfehj
   rHwxOcGCCngZ8abOP73TRQ2UY1XfsUe3zz3BbMil9zUr+QqlInTWg+VaX
   dXwonEaMj86Ndx1/vlhXfnUJ43ayMoCH7OeBtNZOKVIwgHBPiUEsV/VJ9
   tn53CHDb7KWz4tbaCUzJ+mNsA6c/glCJlmZ+/yjqZQnz/xeLpABJY+EnR
   Q==;
X-CSE-ConnectionGUID: LmZzoYz3RlO6qnD09tCRiA==
X-CSE-MsgGUID: m6Hd6ZqwRQOSrkGVhdMZGA==
X-IronPort-AV: E=Sophos;i="6.07,189,1708412400"; 
   d="scan'208";a="22139573"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Apr 2024 06:54:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 06:54:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 06:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCg26WhriOCfGX1/uWU/lXZQjAk+SHXsl8U0PEC7pQEs+6U2zPCLtIGb9pPT4VNUYruib1kB7/vWMRcyi1EhgIKhcofCd4LBNE1FyS6uGVV79xUyBSyLblGNnTFUOLZafXdJoLHMj8c5Dbp5DC/W0idhb1EbOoroZDHpZ6mOIUgcAADr0wpfQRbh2u5DVgu93AworcsoyD9MfijISx193A5GtMvIJUAxrkRxGUDaRWl2kdwSQcsDdDSFgNynG8jriMmlXvvLcyQadactTyMrwnbPXHqft3VlVhnABEgw4RsNzHygxK4fTrw/Bb5+PCa8EAYBON3+M3YvIh67TCTTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH7D3eRQwjIyPug+yIhWqCP3zeOnX5bdTvNZc2msaNo=;
 b=E7h2JvLvoE9+pgi5xqa5A47sIMeb6+8+w1VvpaeTWhxqu9xiGduz5xl0+x/LRYKHufNaBZFP9W7fgmrbIslUWvhkULOrtP4vCgdCbgwQhTz7uG6c7QerUeQQDgyDHqh+AEaPLRqsIYY/HBQQneIOXW02nvSOe5Z00zqPaxwHmoIeYJ1/75yBsO21nrTwuxJQ367e9Xl6HdfkVrA7DxAPOQmpJagx3/cf3NnHRSJ+2AffS+/JuPutC0LnQSMEdqtb3Y33ajC6Ky+oUzxlJJUaLhfW5NMlJKzbhJ5qnKpUn+woqda8iARN15gLuk68RjXEWHWqUXd2T4vC9ntZPjkHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH7D3eRQwjIyPug+yIhWqCP3zeOnX5bdTvNZc2msaNo=;
 b=5R0ktwPLoJWJemHpNKEkaS7mEyX6BU5N++dts4tvsMaZ52AOVApyXaTghwNFEdvD9KrAmJ4ApgFg4MvLUU9VOw5122tIvxyoi65/JQqHxF1X7z9SGqYjkOWh9vLCOJzzCXoFaeVA4yDM/ezuoXzaxVnnyltV2W8+TaGYIgUur+44rDeX4GMprkhPY5OLJ9lMhz3jbe4gVrfuwbg4QzySmf/QCRZbmfTTkcTEGOVNgAsvw/2unvR20pi4IsgVchbZyXAXS89fm/fcp0VczZ/x9x30TmgO0dju1nH6RezruoCQ6XbnXDhuFimPo+8IUQ9vNneer/M1uUUogHkuSgVlZA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 13:53:59 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7430.045; Tue, 9 Apr 2024
 13:53:59 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v5 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Thread-Topic: [PATCH net-next v5 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Thread-Index: AQHailai3B566szv/kud4o84xgiSF7Ff9n0A
Date: Tue, 9 Apr 2024 13:53:59 +0000
Message-ID: <82cd95e2ecb4106cc4e40c10726e7c42c31a13cd.camel@microchip.com>
References: <20240409081851.3530641-1-o.rempel@pengutronix.de>
	 <20240409081851.3530641-6-o.rempel@pengutronix.de>
In-Reply-To: <20240409081851.3530641-6-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|MN0PR11MB6111:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wHTHJ4vhbpJTqTGeNu2TfE9Y4D8zUl9bLbz5fwbSX/1BTtAnFJNrOEx9WHHFOLUVXsXWDIkSd/NFOOKxgfsT77QSBnzECaXWmNZx3y7pfMQ6YeGzbRRpxDjK6BeXyIPSFesmbeV3CQyUiUWMdbF/D085p5fH+Rl42FOGzRBCxJYWpl+OkYXXoG5Ih9gHvoAfTBi66nXJFborJLb/CAIPTNftMTgGziE0ZNhx0yt9KnE6zc2JmVRG7DptvMqBkxTWT0TTloOz5ebp2gVrs2YFLmtBGM8nNgiohH7jszh+egRB9q96DAPigtUj6VTOlRg1cyRgLPfsrDwsJcH6FpgFrwuvv6OEIYCjG6IN7LPUcXiVElSXIeQsDOYBZrOQ8x6nn5+obE/XJDpIWKtuQap5T2scNjx7KkVp52XkG1hwAHezJLWVSYuYLFBSNmoojWWR8EIRDPq0TYPFQEpF5PvhfLSWG3LjJQIwEiNrj15L/G6xf+N4U5f4BkQTgF44AGyQ2OvI3fSmEqPlR5XVAQEPTY5vh64FpVtFMsd9ldj+X4OclEjurYxf/3+1OzcYf/OOHc1AAvgs/ON6VTjPzSqRl/EDkNJrejzf8Mx6P0VRgxCAqhPe9NbwU1caByeWIj3JxSI4uByHzyvB5bLqo4y8i78psQSbk2JhNAMNOjQOPsI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVRrMHZ5MjdIUnJyWFFDSHVERzhiVGZha1RRYUp4djhVYTBSRUdEWjcvdGVG?=
 =?utf-8?B?OVMwclpVdkVobkMxOW11c2pJWVpjQzhJdHpXMTcycEkyUDhIdkRwUTB3YUJu?=
 =?utf-8?B?ZWpGc29Yc2JuYmF5YmZMZktORUhVU2tmd05IL05Wb2srckd3QmlpUDA2NXpV?=
 =?utf-8?B?d2dZMzYwblZuenpicG4wTUxDVlpzbVZPMGpsSCtqMmtXc2RoNVplQW41TTZj?=
 =?utf-8?B?OVVERHQwZFNBWk5pbkZTamxqaXFGajNvcm1TajhQd3Z3ZUFuSGlvNlZVYU1n?=
 =?utf-8?B?M3NsbEg5QkMzQXlDL0xtYjJtSHFHNlNXM0VhT0V0UFdsWHBtN2lRM0doRTQ2?=
 =?utf-8?B?UDVzQzJVaGNpeDVDL2tDcmtEMDhSdDIyTGJ4QnVsd0dUZS9zczAzM0lSTG93?=
 =?utf-8?B?d2pMUmxwNk9wZWN2ZkNzbXNVcXFubmRyZU84QlhNbHBFMGc0ZndGUW9neTBl?=
 =?utf-8?B?MjdSenBLLzQ4aEFJRU8xeDVEdTZmcTFmNlV4WUZSQ214SXMrSkZWZWhyNjNK?=
 =?utf-8?B?OHByUW5iT2RhZFQ5ekxTYW1EOFNhaEhhMGpFNjdHMWVUbWY5WGN2K0wwV2dv?=
 =?utf-8?B?U3p5a1JsQVgyZHg3SjJOc3FFVjRQUjYzdXQ1eVFBL2tGaWxiUG5qSWRrUXpK?=
 =?utf-8?B?OG9uak55SkhBcGY2VlVBVDZiam1maEgzWkkxazMrdG1vc2FiS2ZBeFdydHdO?=
 =?utf-8?B?aHR1RHNsYnh4WnJQcFQxMTdLbG9EcXBEaE9OZHJMTlprS213THRtTC9kTGtY?=
 =?utf-8?B?NVNWVWF4NjN5eXVGeEhVazNQaGNXeWFIS0Q4V2JxU0duSU1JV0prWUcyZ0FG?=
 =?utf-8?B?UnFoVUp4aHpFeFluYjhyRHFFOVhxbWdaSWwxNHlJeGo1VmNkTVl3bGNseS9v?=
 =?utf-8?B?QmlaVUEreUhibFhyRGxYYm9VandoeFVvam5iOU5uYzhWS3FXR2gxYzVtazJk?=
 =?utf-8?B?bU9WSUEvVnZzMzNpZCtrVW5kdUNZS21nMmx3SjZKNGFndUxaMHJqUkx4cUM4?=
 =?utf-8?B?cnN5eUFWQWhwUWxFYU1zR2poZHlsT1dVQUcxUUFaN2FNNEo2MmIvU01DcE0v?=
 =?utf-8?B?MithaU0wdXI0TUhPekN1cHQvL0N0SUpjMEMxRGt2ZG5rL2ttZDJpUlBSYmpn?=
 =?utf-8?B?L1FDdExnb3NsdVhZdEJRTGhDUUV6UWNvY3pKMk1TYWV3aGJSUjhyTjhWNFBu?=
 =?utf-8?B?M1VLVUpWTnZXaXk4YVlMSFdPazhTWnE2cU5ZSmZvaGdkT3ZzNkhZRGMrV2pF?=
 =?utf-8?B?anRaeHdyQnhab0M1ZVJLLytENkswMlAwb0JYQnZlTEo3MjVBYXJFUDNXazJl?=
 =?utf-8?B?dE9YYkNoWlZZWU1WTTcwMVJUYU9GWGN6Nk01YUFWWTd1TjBWWXcwU0JyU25u?=
 =?utf-8?B?U1AwZHRsYUluL3pKV0pWNi94dUcyTVdQU0svdytBaFNxQ3QrLzZ4Z3JJRW1F?=
 =?utf-8?B?bklXNHZVZEhkSVR4bjNDa08xQUduR25mVXhyQldUdEVkamFXRXhDQWgwN21B?=
 =?utf-8?B?bi9EOVd2ZnhvaytlRzM2S2xtY2dkVFZSOTZ1RmJNL3l2ZHBPVVpSRmNVV1RJ?=
 =?utf-8?B?NmsyeXhhV1l5R0Uzc3R1R1AzWmFWRUhXbHZOckw2UzYrZzcwQlFpUWJzYXJN?=
 =?utf-8?B?L1lrRjJTNDRIVVdIV2o0Q2JaZ1FhV0pma0xTOGdUMkdlaFdjUndrOUloWHFF?=
 =?utf-8?B?WTNROW9rOTN6MUhJcDdEU1lNaXlVQTN5a0k3YlJGcVZPcTB6bkJjYjd1ekRh?=
 =?utf-8?B?MVBNeitOQ0dsLzJ3OUg0ZmFHWlNmOWZ1aWFYU0F3L0Y1RzhidTJoL1VMTTM1?=
 =?utf-8?B?RTZjcFZuUkkwcHVtbHRYYnhzcWtsRHhQOUlEbGpNNHBLaEdFLzZNd0VoUSs3?=
 =?utf-8?B?c1NMSjRRNHdPeFFqWDJLalFXcDVKL3ZRZk45SWdtN3R5T0tYeVdzUU1GdHZi?=
 =?utf-8?B?MnM0V01SbXE3b2RvelNzY0t5YjZJY2w3eEpDK2xnbS82S0YrZnY5c1VyUldm?=
 =?utf-8?B?MndYWmNpOURGbmhrMDFNMVdVWmRNRUwwRlFxMWhmbFc5MlB4NDI3ZkQvNGlF?=
 =?utf-8?B?ZVVoblNrRWZFMGNzbVpJRCtGSGJjY2hqc3EvR01iVlgzZGc4ZHowd1FKREI4?=
 =?utf-8?B?b05NOHBOa1BNdVR3Q2p5VVJpTVRFT2FZN3RrTktLUVVGV2RERVQrc1IydkF5?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE08B19AAEC26B4E8F210EE76EDCADB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75269cf-318d-442f-6ff2-08dc589c81ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 13:53:59.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ni3okxTv4EaYq40clSxZp6gXYQYm/HVbFTEQ5yo7PzIWZN8Ac09Pdt0TbL4n17XPfBQ6DmIvGMMkPvsvBN6bsO32fygSoZxXlZrrYuRXXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111

T24gVHVlLCAyMDI0LTA0LTA5IGF0IDEwOjE4ICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgRENCIHN1
cHBvcnQgdG8gY29uZmlndXJlIGFwcCB0cnVzdCBzb3VyY2VzIGFuZCBkZWZhdWx0IHBvcnQNCj4g
cHJpb3JpdHkuDQo+IA0KPiBGb2xsb3dpbmcgY29tbWFuZHMgY2FuIGJlIHVzZWQgZm9yIHRlc3Rp
bmc6DQo+IGRjYiBhcHB0cnVzdCBzZXQgZGV2IGxhbjEgb3JkZXIgcGNwIGRzY3ANCj4gZGNiIGFw
cCByZXBsYWNlIGRldiBsYW4xIGRlZmF1bHQtcHJpbyAzDQo+IA0KPiBTaW5jZSBpdCBpcyBub3Qg
cG9zc2libGUgdG8gY29uZmlndXJlIERTQ1AtUHJpbyBtYXBwaW5nIHBlciBwb3J0LA0KPiB0aGlz
DQo+IHBhdGNoIHByb3ZpZGUgb25seSBhYmlsaXR5IHRvIHJlYWQgc3dpdGNoIGdsb2JhbCBkc2Nw
LXByaW8gbWFwcGluZw0KPiBhbmQNCj4gd2F5IHRvIGVuYWJsZS9kaXNhYmxlIGFwcCB0cnVzdCBm
b3IgRFNDUC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBw
ZW5ndXRyb25peC5kZT4NCg0KQWNrZWQtYnk6IEFydW4gUmFtYWRvc3MgPGFydW4ucmFtYWRvc3NA
bWljcm9jaGlwLmNvbT4NCg0KDQo=

