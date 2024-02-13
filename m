Return-Path: <linux-kernel+bounces-62905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB56A8527B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8220228585B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECADA92E;
	Tue, 13 Feb 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2bVTa0+P";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S6HvsjzB"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3535F8480;
	Tue, 13 Feb 2024 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794429; cv=fail; b=h36VNSyh3xjf+7ItMbRF1kJfRh2M/feng3V2QKGwa5sj0CWu3YS7e/4pSUpKLgVmTQyhChwW/hiYI0gPLM9fHS5gAtb0GOOseyyc6rEHJ+7ttf0sHwCcskcUo5Ouz5tIjK1mgnKeoQQKhB8per4ptAa+Xbip9/F6rb6MOuKqL3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794429; c=relaxed/simple;
	bh=SmMrfpkbYMko2PPWZJ9C694Tpf3o8vrbELa4cpOS/Do=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rwLPg4DoQLd59XnzZZPoh6MtJ1GZmxpV2DSwu/tFvlT2+73PA4oeV1Dnzjqh7mGNIJS0s3ZA0itBohev5+ih0pS5XKdYgQcRDvaVuvS+8W4E7fKnu0JKYqnuBole8tZ/txH9mlK8gbioeaEOMcr+AzIiq11RJuGQr5fSVZm1Wjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2bVTa0+P; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S6HvsjzB; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707794427; x=1739330427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SmMrfpkbYMko2PPWZJ9C694Tpf3o8vrbELa4cpOS/Do=;
  b=2bVTa0+P8bqA5akc5PJ6LMIAwOBv/Md7R4RLaWCA8CrQDFe69tpxYbDX
   u/x+u9ewIa7V0hbDCWN5ekrdHof/29cBC1OuXnpMCY0DGhQUF6yev0jiu
   ruswlIniDQvgNsnddavKWvIXGtClPixlyA+f5WAZjDkBbiaUflEEiCX8V
   yQ908EaXIUvv/vQpLoIIjPNwwK09IdmCppr7OYrH95lDvPbsaVZ4Mu2LL
   wOqhpr5qWZ6viSEO3by5mVSoBAolWicZ2NVfLJK2SdId/GAVoa4ZQTzBA
   p+hqhYlwLgt4z4CFFbcy3o2bd8rEXw3EA+2ZlIEPpG/QluXieuYDezwnF
   g==;
X-CSE-ConnectionGUID: /l3h7nEqSY6SNiSTq7iszw==
X-CSE-MsgGUID: 5pX9e5DaTKmcs+Fgwu4cSQ==
X-IronPort-AV: E=Sophos;i="6.06,155,1705388400"; 
   d="scan'208";a="183412426"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2024 20:20:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 20:19:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 20:19:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzfBGu9z0EoKJ0BBttnfvBzJSooASV/XTfFVoOoMvn159VdeJyYl668CB/wqcjMJ1XrzL7ennAlsMGsWAruT0C+8HpQDDJ9/Us7aG/p+uvRIoMJBhn+hU/0kFoIFnUNabIp4jb8UyZDeCXPtpACVEyEBmdP50mhM1qoJDUvsFsj1LKf0CPZp58jT3CUQLynEhPgCR8mNFdc7ql3dNxO4rlUtlmU7LLeYuNqIi7pr9NWUJu9WKN+GeTTr9v+0obOsFCtpF22oQlX+6sKmLMw7pxP/QyDu7hdBhkrGt2amMjcL/65hUwLetUTORK9Y8HXaUBXVvskzA0HvckdaEtBiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmMrfpkbYMko2PPWZJ9C694Tpf3o8vrbELa4cpOS/Do=;
 b=fbqLN7JbuutuxrNdy7H4grxfDefwjNtbIWvuVxyydBWKKz/2Tri6YIiU5hYDZpyMCl5ScjAE8Q5iZ+FGrZ58iZy9IwT+eqfuUyp1IdZUrDEiOuyBFGIDoi1TXXfvVrmmRilbg3tFTUTjUfSTxtCmWGqTnniNC+LylVlvvhNpIlPQ0cKp1B9B4u5EkJEc4J2S0zoMWX3TxDUL1KjZQcUF9dXDExqEr/TcrB6s9onR4pdf0lXekwMdYLK/cRZkaQcx8eWpVQtfEfOmtjQlHwoEZ6QtfOUje4QV6B6snRHjGO6rlQuWRHFkuv41s3FZhcK3mt5Ax+QeRmosuGQ084iLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmMrfpkbYMko2PPWZJ9C694Tpf3o8vrbELa4cpOS/Do=;
 b=S6HvsjzBbowvK9NPvjmh2N61ZPUIy0UsXuNN5AZjnRv4O/tHk57ntadXQWsR+DT/dp8fStwt8zm2W8HMluBEwACKJ7lmvLaiDufB8DafUZbI24jaiBSsbAqmJ9/eqa1UsqlynAPvndQeD/bAfqkPCfoMKMmdFiVCDjEz99wZewGFPynVKBNwaPXT/DXwGjQiVj4cN50jErdcU4zlxbYh9Ed9WoeHgFnJ+V/cGCmgnOq+2zGW0hbAvniH89NBBTZsyQkWYkWd9cdtrkRwht30G3RD3bl45wi+RkfF87xMkJ5raLM5R7nqWx6fVeRVgmGlxoTIFMBe47c5GoYQKzQqDQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SJ0PR11MB6693.namprd11.prod.outlook.com (2603:10b6:a03:44b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Tue, 13 Feb
 2024 03:19:36 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::a1ae:867c:66d4:123b]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::a1ae:867c:66d4:123b%7]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 03:19:35 +0000
From: <Arun.Ramadoss@microchip.com>
To: <Woojung.Huh@microchip.com>, <d.dulov@aladdin.ru>
CC: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<vivien.didelot@gmail.com>, <helmut.grohne@intenta.de>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>,
	<alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>,
	<kuba@kernel.org>, <lvc-project@linuxtesting.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 18/18] net: dsa: microchip: Check return value of
 of_get_phy_mode()
Thread-Topic: [PATCH 18/18] net: dsa: microchip: Check return value of
 of_get_phy_mode()
Thread-Index: AQHaXPwvTrBcMF31/UG2yGfi12PUfrEHnUAA
Date: Tue, 13 Feb 2024 03:19:35 +0000
Message-ID: <e36f633f99040aa5864008d2afca586b0af5d6f1.camel@microchip.com>
References: <20240211150804.3893-1-d.dulov@aladdin.ru>
In-Reply-To: <20240211150804.3893-1-d.dulov@aladdin.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SJ0PR11MB6693:EE_
x-ms-office365-filtering-correlation-id: 114e12a4-61e5-444c-1acb-08dc2c429afc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aTfshBYG2I0oEX6HaB+EiWdbdkfKN8vOy+j8U7NitZ46fHa0JRLzrV+LloDORIFRr8FlnfBUgXUuSzZlJhcgYrFsmP0sRygfyuRl4K//boh3D3PuvcJQzveDFYuTweiIR0zfg5++A3mrXD2E8WAQGg3mPG7AldfdlDlowIkoa4r1PWYCkmgbB25b8zFUgu5ID4QMb5jjlY7J11SY8tXaGEftNuI4rUuByJXqkjgyB06Gx71Ypdh6/jtMJGmLA4NwPd+YtPsMSqRszsLGAivepDd0DAfVZuZMWolDYgnSEm4IfjjQVZoW8FKl5C8ffMCYd6DU8QXN+WPlrU1cihSsQO/Tyq07j6p8CMEKG/dHquMXI+Jm6CTS8t6kQ8nJjBsHCERch0Q/s2inVQWt2Q985iSQPitZBw0CWFb3xq/PtGJ0d/9zRihjrZmc4r7Z2gBF/lQkGnCiuV1oOd8jOF3zN5Dq0ieMNcwTzSM96IHMCKjKTrj3XYjL7O1L6jse+dKYOohl+wgwnv6+JE0S4OaONGEw/3aImr+tfSJQUssos0I/vNQNrdL5LsMurizoDi410CIvYHJ4xea7JAD3RpEjowQ7rGi37moFQRTaiVcWy/3Zrq+nrsDLwMg+kaH/kDMq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8936002)(4326008)(2906002)(8676002)(41300700001)(5660300002)(7416002)(83380400001)(86362001)(36756003)(38070700009)(66476007)(66946007)(71200400001)(110136005)(64756008)(6506007)(66446008)(2616005)(76116006)(316002)(66556008)(54906003)(38100700002)(6486002)(122000001)(6512007)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDhaMzNWeUtZL0xtZ1NXMWpjTFZLTXRLTkpyZ3VnUHV6YXVvWkxlN3pTam5i?=
 =?utf-8?B?TGNHTVpNclg1eEJZaDFFZGdBN0VuVVhWRHZXZUd6YlRQWkNvMTFnaGFMQVFF?=
 =?utf-8?B?VXExdHhxWTBnbzhwY1U1NkYwbFlSb3BLY0ppV1JWd3puRXNiTkJIMXNJMWVj?=
 =?utf-8?B?OXBxVVh4RVNERmc4eFFjV3Mwd09idmUraEljU3l4dHEvUmFIdzlnemszQlU0?=
 =?utf-8?B?YnFmTlZpTnViQU1BYldReWgrZ2ZoUWMzZmxmK2RGSVp2MHJSUWNvbnkxZkNk?=
 =?utf-8?B?eHpKdW00MnpNRkZNeUV4VnM3M05QY1lqa2NRampDeGVSRi9vV2p1djV6WjJC?=
 =?utf-8?B?VkVjeE4xclVleDFIeFU0S3pNUENtS0daMHI1dWFRZUNtWkZCVkVNTldYM3pE?=
 =?utf-8?B?UE9jTVN0N3BXakhzS3h0RmRab2p5Rzk1S3FNZXdIeDl5dW5XTktZekp6S0F6?=
 =?utf-8?B?MmJ3ak5lTGRqbmpFSE1GcGJyRncya0tERUdsTWVWQnZBZTlvMEJEUDkwamdJ?=
 =?utf-8?B?QkNYZTV0Z0FaemxxdTJVdnJOOGdTWUkxb3ZGZW9KWnYwU0hrWnExTXJFV3J3?=
 =?utf-8?B?L0xPNEFQcjRWd1BaeHdJL1BaOTlGcmZhRCtQOVprSVZRZDFMY25XUnROVlpL?=
 =?utf-8?B?L0xZeFMzdk0xaC9vRHhMSlFvNXFJREM0Ynh1ZUhtOUF6aHJ1bW03Z2ZrUlVG?=
 =?utf-8?B?VU5Lek1QZHV4eWs4NWZtdXBiV3dPZU9BekRrNkJFbzM2eDF3bnY0TU9hVEo3?=
 =?utf-8?B?SFhRdGNWcG52OGJLakNpa3hvN0pvTThaS01kMTNSb25lNHlHUGRsNlY2bEVh?=
 =?utf-8?B?UkVvWVEzbFRzYmt6emh6SkQ5L0VPemlZcFFXS2ZzUE1rdmUwTGlxanA2MlV0?=
 =?utf-8?B?cmdtVk5QL2NqMmNZZzZQL3lrb3FTYzNXay91clZ3bG9zcEp2amJDVUJXeXQr?=
 =?utf-8?B?M3A0cENXL0RzZ0FURlQxcE0wMFBqTjhTNXhMN2pBZDNHZ3YyaWRXVEw4RVRn?=
 =?utf-8?B?NWE2V3gyTGp1cXBBUmNxWndVdEEzTVBVaEhLMUJYMkh5MDhVaGxFc08zVUsy?=
 =?utf-8?B?WEpTL1lNaDlmb29aL1BZcmpudzQ4Z0xVVFNlUWx6Wm15YjdNdGc4bmRrdDM5?=
 =?utf-8?B?c002b3EreHVFWk9hQXpRQk5iSzNMWS9vazdoV011UVZlVFZCcjEzemJ6bnkw?=
 =?utf-8?B?NTF2NGYwTWZpMC9FT2ZTU2lGM0NWaVp0SVJoalAraWZpVHBqWWJnenpKNm9k?=
 =?utf-8?B?MFRBQlcvcE55M0FXVXVpR2Rya3pUVWVqT05sUHZTOEx2WlNwWlRRazEwaUtF?=
 =?utf-8?B?ci81ZFJZaU9rclZiWnFYNTNIb2x0V0RYS3hWSVBvRk9VTUV6VUZOQXVxUVBi?=
 =?utf-8?B?bWdaOHA5MnRWcUlUaEc1L21YcnA2d2U2WXA4M2NWekxNRStldGJxMHJmYisw?=
 =?utf-8?B?L2lta09BbEx2RFgyS3RWaHdTOGl4Z01VWEdod2Z6a25YV2JYUTkxVkVRb2gw?=
 =?utf-8?B?blZ1dWVWbTRnZzAwSFZQQ3QvZzV6S2UyY3BjMmdWOWlxRjhDaktsbFFJcW5z?=
 =?utf-8?B?ZVc5eGEvNHZ1WHdDNGMzbktkcWd2ZUc4N0QrSWJmaWhYVCtXN2R6SENpK241?=
 =?utf-8?B?aCtSUWowbGc0dDVJOFI4WnpXUFZaSEVaTGhrM2FyNzF6Y0RiZ3hJUHR0Rkww?=
 =?utf-8?B?MW43QkZqOUlUQ0xVbnZaOUYvdHdKbDhiN21LVzBMdjJEVlNkRTJzSk1tK0Jt?=
 =?utf-8?B?TDZ2ZFpZQk1VRkdyU2N6OEZ1UStmUFFRMjFxYS9nN3EzajhUd1hOZWNPRnlY?=
 =?utf-8?B?UmgxZ0xVc2dMdEYrQmUxdll2YW9hZDRuak9ObHVGUzRxRE9mSkNGMy8rL014?=
 =?utf-8?B?OVF5ZHBteDVGS0RBWDltN2lyWVJvWFhiYlZ2RWJSRzBMdmtQRFFrYWtkUzZV?=
 =?utf-8?B?bGxYSzU0ckpHMzFZL3g5YlRubWZNeVFuMGdnSy9aaU9qOGdvMmNER3dMSkp5?=
 =?utf-8?B?Z0g3cTBtWS92RXAwMW9FWXJzdVJpT0d5azJNVnhTMDlweGZlOFF3ZHNnc3gw?=
 =?utf-8?B?bmw2SmdYRkhSQURQNEFlU0loZUdtNkJhUlBnSDJuQkNNZzA4a0pHMmROWXVW?=
 =?utf-8?B?R0w4Mk4rMWVNWHQ2OGdRcTdndkloblpvdGpybkREaFUzcVZtRHFsZy9ISHJH?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E7FD7D5BF047D48A5F9CA00E87D0DE0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114e12a4-61e5-444c-1acb-08dc2c429afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 03:19:35.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PS82Rsv5QhIIv8fsOgQQ12782xAhHjFuA24KBPZg+YruhYxP9ewIE60pUhPprpeDwB9T08JyVnceAVgvXaeklk3AM+DCcpF0IAVvE0hsw34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6693

SGkgRGFuaWlsLA0KDQpPbiBTdW4sIDIwMjQtMDItMTEgYXQgMDc6MDggLTA4MDAsIERhbmlpbCBE
dWxvdiB3cm90ZToNCj4gIGRyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5jIHwg
NCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9u
LmMNCj4gYi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9jb21tb24uYw0KPiBpbmRleCBl
M2MzMzg2MjRiOTUuLmZhZmZjZTZlYTFlMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZHNh
L21pY3JvY2hpcC9rc3pfY29tbW9uLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hp
cC9rc3pfY29tbW9uLmMNCj4gQEAgLTQzNCw4ICs0MzQsMTAgQEAgaW50IGtzel9zd2l0Y2hfcmVn
aXN0ZXIoc3RydWN0IGtzel9kZXZpY2UgKmRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChwb3J0X251bSA+PSBkZXYtPm1pYl9wb3J0X2NudCkNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG9mX2dldF9waHlfbW9kZShwb3J0LA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJldCA9IG9mX2dldF9waHlfbW9kZShwb3J0LA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZGV2LQ0KPiA+cG9ydHNb
cG9ydF9udW1dLmludGVyZmFjZSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJl
dDsNCg0KSWYgcGh5IG1vZGUgaXMgbm90IGRlZmluZWQgaW4gZGV2aWNlIHRyZWUsIGNhbiBwaHkg
bW9kZSBoYXZlIHNvbWUNCmRlZmF1bHQgbW9kZSBsaWtlIGludGVybmFsIG9yIHJnbWlpX3R4X2lk
Lg0KDQpJZiB0aGlzIGZpZWxkIGlzIG1hbmRhdG9yeSB0byBiZSBzcGVjaWZpZWQgaW4gZGV2aWNl
IHRyZWUsIFRoZW4gaW5zdGVhZA0Kb2YganVzdCByZXR1cm5pbmcsIGl0IHdpbGwgYmUgZ29vZCB0
byByZXR1cm4gd2l0aCBkZXZfZXJyIG1lc3NhZ2UsIHNvDQp0aGUgdXNlciB3aWxsIGJlIGF3YXJl
IG9mIHdoYXRzIHdyb25nIHdpdGggdGhlIGRyaXZlci4NCg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICB9DQo+ICAgICAgICAgICAgICAgICBkZXYtPnN5bmNsa29fMTI1ID0gb2ZfcHJvcGVydHlf
cmVhZF9ib29sKGRldi0+ZGV2LQ0KPiA+b2Zfbm9kZSwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIm1pY3JvY2hpcCxzDQo+IHluY2xr
by0xMjUiKTsNCj4gLS0NCj4gMi4yNS4xDQo+IA0K

