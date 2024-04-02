Return-Path: <linux-kernel+bounces-128306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364C89591C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C042A1F22DB4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE212134720;
	Tue,  2 Apr 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Uup8+tV/";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zq8+D/xt"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C413328A;
	Tue,  2 Apr 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073572; cv=fail; b=cMQsGl5IecDXXRJMq6NMW5w7W0JYC0pQzjoj1dRNtLXJhMGAF7iaTFzCPhMP+QjEmUlPung7vl9S2NuIzr9r3suYWw1PkbyHI/kpMYLs+XWmBFiIe8MlUOkIP0jZzcufpGLojMcIlTGVBTfWhFGShCus1uDIjSQ/SBL44X/IoFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073572; c=relaxed/simple;
	bh=3v7tZwC+SFefPQo6T2uawwG+K2XQxfN6T4OO/vhcVCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E77NLo7X+GJhFwoxyW2jUAM9r1ya6nTAhkMTdT7Y5zgb+pWY6PfBQKR+Kb2TnH/62gopWjraQnkFJy5gqIu4coHoCerUsqpYjHowHG0aKao2Iz+xTQE3ZElhxMc41l/5q1Nf3WDimM372o88XFiCGOVAJ2G5uKW231MVxPDvhmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Uup8+tV/; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zq8+D/xt; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712073570; x=1743609570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3v7tZwC+SFefPQo6T2uawwG+K2XQxfN6T4OO/vhcVCo=;
  b=Uup8+tV/I4r99wsan0rADTEHF0PXPWn8oV6pGFmg7AyfXBpkonawChAV
   5HfoGt7tj0rONY7FGk40Xkm2FHEdS/IQC52SbUwKVR/XwxBz8/HG5Zmpn
   RYZBLxl/UQJI7NA9Pl1I7C71GS9uweMdn2ah6pQZqXjxzRv2LKBCXUJeP
   AvKGucDhWVdWe/cGHjqnImvhzv6gDSou7ZFenokcBpAmYcBDbvRn3WoJq
   A/gMQrDJX9X7J5jmxQC8c0DPgCr1uph5s7l6DWUMk3nP8tj3ajl9Kecxu
   8HXajOtK6xPCs+qZffM3r6MdLn65Mecrls1fEjo8IhepHEr10USLqsOOy
   w==;
X-CSE-ConnectionGUID: COomB28ZQq680ua6bxGtLQ==
X-CSE-MsgGUID: RiPMlJNGTWSPyva0ez9/2w==
X-IronPort-AV: E=Sophos;i="6.07,175,1708412400"; 
   d="scan'208";a="19129802"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 08:59:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 08:59:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 08:59:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzZYlrlXE63CFNISHkPgUDWHzot4X48YHPFDSgmipHcwXTjvseQ9kiJWmg8rE0Ftpk4hvks+OpxUew0DdEvf/k2/ddEiFiwA2tBcvkdevVlyCtgB73Y0a8YUrup7JqVeItOpH7RLISuTQpbRtgNb2+CkJI3XfBK1P7MnpFMbgxxGtrgGezPpD60b51CGqC+hpveFKZDlJ9nyfsSFTi+zm75cgqEcuRlOaGmd/JRmoB+7EbrC7UR42+xJ8dWvDlQmosDWVHiDLHf6Qt5gjhGIVmS+0/acH+3ziJ11cV0i5BzOT+v+mxcIvQVRUtZ2oICCo4Nf4xwLs8nt8RUH/Q0Yow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v7tZwC+SFefPQo6T2uawwG+K2XQxfN6T4OO/vhcVCo=;
 b=CLSQbfMql6KoQRyZFJLwwthahPlm+zXqGhWJVFr5A+8XEQwULh1XJZFFS1hKqTT18bEkz/JA7be7Ufjptu2D1ZraxUYqgjkrqmmJ8HWUc+FN4Z2c+5PUyXBRUeUTgV5HYw8gITbvWWuTXqupzzih5T1sdb+uMciprb+GmuNrhTazYzc26W0gq1Tnn/aW14MFl9WbtkSG3gKT5ixaQIaK+Y2useQjHYnKDFvarfLZ0qiYesRc41zPfZ8aHbnZPVCp9dhbeS3FZ7bf/D7o0j+zpIBy6Woj6EpLtm7kPw05Rmgwk5Ps/BRt9tfLrPQfaurLPRFWOQ7xJ5hpj/ebRc48yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v7tZwC+SFefPQo6T2uawwG+K2XQxfN6T4OO/vhcVCo=;
 b=zq8+D/xtXQB5FUBVDivjeXN/q0Wp4BeSNQR3/GiEO6xgFbp0BhZSuUOE/chEEP67nKrjZcHs+/85R7DgUjwLsAYHaoAZE3nXtgtEC4l+lbrkTj6SZlA3nwlpO2yme9+0sGFVAmZkq4zF1aUhsCzgBuKnhgttJsgMBxoN2bm6DnVDjmvJuhJy7VQgJ3OTuejmFeoVOsAU8p6qz8fjYjDZW/tSOywgxQHVRhH8cOIN0oc2Ec6prM+aPamLejozWUFfKJYGv9jp+sNptsSiqwjfkXJM+jltdkT3mFGxVgFs12pbPLY1m/UB5tWEIlDqycrt6dRGqp0sLWhTvtGPnnvFSA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 15:59:05 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7409.031; Tue, 2 Apr 2024
 15:59:05 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <san@skov.dk>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 7/8] net: dsa: microchip:
 ksz8_r_dyn_mac_table(): return read/write error if we got any
Thread-Topic: [PATCH net-next v1 7/8] net: dsa: microchip:
 ksz8_r_dyn_mac_table(): return read/write error if we got any
Thread-Index: AQHahP+hREfs0rNvoUWOa28aOEvy97FVI8KA
Date: Tue, 2 Apr 2024 15:59:05 +0000
Message-ID: <9054ad8ddd42f70ddec546e7d05d5cabe6febee3.camel@microchip.com>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
	 <20240402131339.1525330-8-o.rempel@pengutronix.de>
In-Reply-To: <20240402131339.1525330-8-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|MN2PR11MB4743:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRgpci88/l+SF/Ctdb2TiQbXSGFWcZFEBOcjlu366VarCwmIfYzNyRJ2+mkzcpJydOB6XuFu0+AWH/ji5h1P3JU+bgQ9lDffn/clc7xUSsW/j2F7Y+59CZgIwWJGh8wr2KxTvyAz7pAzJXR8Z2evI6IH8bXno9J1RbAvUegZ+K7RAqRjYDkPAgtCA9F/0MZBKZnOq1g+6TxlySpF1p+59VerQz4ykg7KVBhs80WcWtIJ2D3iiIATEo418dPZHgfXtIcVSUCddm1OaODXQ5USiSzYviJGHbFgonPoj4xsoRvYA8VzJP9KI1ibSYyJzr/JebT3JNNeeBVR641aoJwfoF61hRq/T5GEsR+1go4ilTXAiqhWgPOq1NMunvYTqDRuPqE1mIWHLBy4FFdXaRo7CkR2uU3nesFRGaV0dhbPC0YFBIi5mujJbXpxdOMD4sdtKKPyWXCftWFjmFxDo0NbO+0Wl8/g98H71DdVpoIKJw+/AQkMTQSkPSALZSgt3ADc8JVrr/mGT1CsquHMvEPE49HF22LABHqcIUmsJ1uXOxnkOFGqPnevo0uGeNcUbDCQxGAjNmF22r8QMMgbNs7l/IsQmp37l7bbCVOBZLRyxBqM/rO1wtomTCfdjlIZU826/k5cxN76S3h54ORiPYgBup2YinZJK2bnZcpgoKkbv9c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDRwcWJ1c3dmL0RYYjRWYlpnQ1JaVXFqRCtuck90Y01OUTREQ0xTUVJ5ZUlR?=
 =?utf-8?B?QnZPMHV1ZnVBejRyZXJ0TzJNYkR6VnE0N05RdHNmT1g1dVdRNVFLWjhSSThL?=
 =?utf-8?B?ZjlRbVJURklDM2tVWjl0VUphYW54RWF5c28vWm5BYVdpa1Y2WElvTlZtdjdU?=
 =?utf-8?B?TWJ4d2d1UCtVZGNmcWZEODAyL0Q3aEhzWWFwVXRiYXhqaE9CVk9GZ1RtOTVT?=
 =?utf-8?B?RzI2RENRN0lQMStMQVYzaXlVMWlGU3ZHTnYyWDJvbi9qWGtHa3kwNHdsQnBy?=
 =?utf-8?B?WHQ3N3pReXVvd2dlbmxjSFh4QXk1MzRNeWZxUXNQeHVDN0RxV1VNY1Y3KzNn?=
 =?utf-8?B?cy9pTkZxSk0wWnRKZTBod1JGL3phSEtMTldvTE5IL2xCUHMxbW1Tak9kUXhv?=
 =?utf-8?B?UW9aYXJOMFBtajFGbG1UeEtncklGaTZVY3BkZEsxbTR1b2RUdUNQdzQ4ZFgz?=
 =?utf-8?B?V0RZaVhzNEtNL3lWYjVwTmJsMyttZWhWNjJBTThvQ0lKMnBZbGxvSEdDWXBX?=
 =?utf-8?B?Q0RWenhqbC83S0pQWnowa2VtRkNRQ1RCZkk3VDJLVGRBMzFqeTdKUVYwRmVC?=
 =?utf-8?B?MVVGOVdIcXI0Uy9oS0x3ZWdvTWRXTmV4YWV0V01RcVdhZFN5K05hcGQzS1BZ?=
 =?utf-8?B?UDFjRkRYTzVCZFhPci9nckZaYjF2QkljckExVFpURHdtUysydmJvanNrOUp3?=
 =?utf-8?B?dmY5SFUvQ0VDb3hJRDF3cjc1UTc4ZjBCSzVncVFMSWVIZytJSzB0dXEvWVhs?=
 =?utf-8?B?aVpucWhEWVJqWTJsVWVQVkRwSlZLRXYzWGNiTHBDYXhQb1Q0b3A5cyt6RjFn?=
 =?utf-8?B?YnYweXM2REUvUVpuRHhERE44VUk4T0lkNVlhbnBsclY0cHhNZU1EQ2xENUhC?=
 =?utf-8?B?dFQvUlNZd1kzWGpVdlFteUs4Z2NZWHlrendBUjBWQStOSmNGTXo4d0lqNFlW?=
 =?utf-8?B?Q0VXOE5hbW14NHc5N25BZnJhQUNObkl2aG5UY0RLemVlRkNjRVp2ekVYSzJT?=
 =?utf-8?B?bVF5UXoxMWI5THpkVXFLbENmVW1aekc4Z1RRK0V2M1d6UkNQVGVFbitvZlB1?=
 =?utf-8?B?L1VWbWRrR044UG9IMi9DVmd5c3NJSGlqd2M4RDQ4N255SmVibGd3L21JdE9C?=
 =?utf-8?B?bjdQMHBockJYRzBNWGhZNnpqQUxmaDNmV0FLdWozU3VueUlpbmxRdzRmeTRm?=
 =?utf-8?B?OS81UFlwOHZvdUZmUkY1ei92TVRKVmNqVlIvWEZ6dlhzU3Z0aXpnVDhrUytE?=
 =?utf-8?B?Q2FDNXlUaXFNR1h0K0JCTEYwMTR6eGVDMDdCUWdGQTkxMmhkNzFPanhYdlhZ?=
 =?utf-8?B?eThFQUhzd3pOcE91eStrd3h0QmJYWVRFMUQvZjkxdmo1a3k4NzNVTnFnTS9q?=
 =?utf-8?B?N0ZCajlhU2ROcG5Pcnk5MGEwY0hPSU9tenlpTHZSTmpZaGkzV3UwdG1DM2xp?=
 =?utf-8?B?blBhbDNCdHh4Um5OUEVqbnBsYU5GdEtjUS9KSitvQzNTS3dvM3FRWnV4Qm5R?=
 =?utf-8?B?dWxXZ1E2SDJ5ZjVQdDRmd3EzL0RaRnBEenNZR3pDTFIrOHpjczhzUGJCWnFG?=
 =?utf-8?B?ei83QVJ6ejhwVkZYTjU0UHpJZGd2UU1NMVpVdUJLY25vWXNGeHlCT2xxSThj?=
 =?utf-8?B?b1BNSHRNL29JVGlRdlhHQW9wbHNoVHpTbDQ4aHByZGg3UVpjWFQ3UC9Zejcr?=
 =?utf-8?B?QUVMWXBVU3Y2VzRyTGF0aklPbE1vTUVlWS9RQXBOUjcxdW5KRkxnWE1YVGkr?=
 =?utf-8?B?aXV0d2UzckdmbFJ0OGlPcFRaMGhtMk85UjJkRVBnb2NjbDMvRDBrM2xSQVRG?=
 =?utf-8?B?RUJycktwbTJ1VEppdFB0ZVRxQmF2ZGhOeURmeUZCMmpwMUNIMWsxQjNDSUpy?=
 =?utf-8?B?d3M5SmFTVTBKMzMxMkJzN28wVkpQWldnODYyUlBVUkx5RDFMci9EOEtWRTdU?=
 =?utf-8?B?MWNmdU9SUElROVRkcG9ZSW5wTWYxYy9TUHV2TGZwR05sM1VqOGt1NjY1bDZK?=
 =?utf-8?B?cFgzdHYvbmRSTVBaWUZlZ2FwUk4zT0Y0V1pGN2RKelZSOFF5bmFSTC9uaUVW?=
 =?utf-8?B?Z3VZTjF5a09wWkpaeUtZaUMxMlZDV3VOMmxGWlFnOVVvK1VaVk9JQXpvdVdX?=
 =?utf-8?B?OFgwRE1LWVFJSjFhRGQ5MmU0S0lVYSs3WTFZRHBNQ2NJcmNUa3J4Q3duTSti?=
 =?utf-8?Q?mROcishu393OS/izHkvhou8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <592EA2B61016234A8D56A7AD57746592@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84894684-8ad6-48ee-b984-08dc532dd2ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 15:59:05.7956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/R8rlJ7kqVE1RAUK45TncRfHgPSDxRWuF/FLeHQv02RMZx6S9oC+g5eEhFUSoQZKUqS1k1+HP9Mueog/ZCHnuLToFqeSF0OMawIZtjJoyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743

T24gVHVlLCAyMDI0LTA0LTAyIGF0IDE1OjEzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgcmVhZC93
cml0ZSBwYXRoIG1heSBmYWlsLiBTbywgcmV0dXJuIGVycm9yIGlmIHdlIGdvdCBpdC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4N
Cg0KQWNrZWQtYnk6IEFydW4gUmFtYWRvc3MgPGFydW4ucmFtYWRvc3NAbWljcm9jaGlwLmNvbT4g
DQoNCg==

