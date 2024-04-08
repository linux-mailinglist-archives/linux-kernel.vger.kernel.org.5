Return-Path: <linux-kernel+bounces-135659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C899489C961
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEFA287BFC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9339B1422C9;
	Mon,  8 Apr 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sXJ6qE++";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rNc1jFDR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69731422AC;
	Mon,  8 Apr 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592662; cv=fail; b=rVluvOD1qMEgY13JI9eMgvU1mYxcurIQBLvI2HOfZXSE2iyknxWj+1JTx5up3M0XlNjMCs8xAG2HSML0bD2soqWTD75QZWae2azNtQXAoPyTVQGj3rQ9KndsBNhiGMP8gXCYoh4Bskukz55xEGh2fBlgY0oABlg/h3ft+TD+iZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592662; c=relaxed/simple;
	bh=YCic5sy8rmHMbHkiUoMyogg6/fYMDQVWe4V/fCOe4Xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NkfzN9TnPtd0+ujhO5Wk/w/ryHbAZQ3Ls0PHbhXf9jsvbFjzQ32WzY+q7JHPiWKm5SnJ2OQMDCXgxToBEWajSCJsWA0kmDkNq3ZciED2X3Y0YlHQGDvOujBt3OE+ZlMCofhg+uXgt1yY4IgLXognekHM0YxAn8Eq4/czVZCO4Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sXJ6qE++; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rNc1jFDR; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712592660; x=1744128660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YCic5sy8rmHMbHkiUoMyogg6/fYMDQVWe4V/fCOe4Xg=;
  b=sXJ6qE++4CYVtBMnzesaPy5AqLimC7jze7i6lXy+SE/RQJM78n++ttPj
   ZsW0WpYhkqG+EnBcMNqLN00PXyKX0DUnBdYZAUGKoZeD+YxA7zku7cKsj
   FZIpLnz2932smX7lGnNEo2PrrYAQEkbfhkvqDGzI4tgomr4PZ8Jnm6+Mj
   EE9/04VszJdIZbQyCh6AjHcliCsrFCHDHYAjsbFX28DZhzsIsNkqjJhi1
   Y1xcTxiWtwMoyMPK377IM7v/TUTo68U/5bOcI1MtWyo+BzWA5xf8E370T
   s0DpG6WI5lOUXxZ9pvoIH47Mw2S0Ng/2piVp4CibLiMBkTreORleKSfpe
   A==;
X-CSE-ConnectionGUID: Cu2L3kt9QZqXGGOs6a3d+g==
X-CSE-MsgGUID: kTaexa7nTgyV63iqaMd6pg==
X-IronPort-AV: E=Sophos;i="6.07,187,1708412400"; 
   d="scan'208";a="20571262"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Apr 2024 09:10:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 09:10:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 09:10:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqpaOHlskHc9pKpC8ZfvHxm8aPCeTEq2eT2WYmychbzeuz0bvRsRKMYpXrpOSyL58CrZ04j8qoNr2d6Dz5S0rqhtuqUGagNFEUB4xYNKtJwDBaCf+aDIKQvbeMBMhAO12etvJ3tO/xmgt3otqbdOVHXCS7Y3hL+4tMAZuZj2VbN7Bm8cz2LElMcD0PSCifr172V9brTxWNwtv+LDtsdY2oJ0iYRH6ZMHCBLlqZ56KsuFc0evfpYR5shWSfEEtP7xIr9ShuuUy9DIbbaU/7bfy9YbFVhaQtYq7F8Sqa/khBo/GmsgfZzYTNv/tYr6G92LYoUCrqntL6E0xwEVyExYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCic5sy8rmHMbHkiUoMyogg6/fYMDQVWe4V/fCOe4Xg=;
 b=AwUQ6cZEIWMyXuejrl+Vgt1k3V/ORSe+9Yw6x6HdPBQmaMOncFpnLf1COsB6+d1Ksf8vVJ1ecxxX6Y4SCkFGEM7j9hFwZn0o3qBFeCNpdpLG8IoIcn8rN2JfjX5oGMtB6pi1I+YnC8bgjqpT4qCd1SU8qtI2EA/0wpzeUVqd8fIKv9/mgWNUJ7WGZo2xX+k6CXMncZ6lgOMuUFy7pTIoAOPiCyEEVm2xao1VNuEYzyAbWu5nSNQjQNMwq6OEqskl6xCZxBpCA01WIhSYmZN1i61CWuxdaXoLf06aEZVl9Zg/vtOS/ypjojoaCGAjc0gZ/Yoo5TYw7rX5QFrsEcg6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCic5sy8rmHMbHkiUoMyogg6/fYMDQVWe4V/fCOe4Xg=;
 b=rNc1jFDRKyj7rMhBV8psVdOaJxZA+f8+NfCwCrbnI53gcwcp8ukPbXn5fMhR2NgwIvvikgFlqPDoR5EWci2Djz5KPWSaX2Y5+ac0gibOwnysReAEF72KvvYqaQ4RtaVSPYDf4jdEzUauow6it9KwKDVw0qJEh+yy5Wwayrqj3uDYwrDy/+uz24KzsRO0VnqX2juC4IBTTVQgXY31c+Kxnq5NtoWdftGLe1PgCSF2LvAHcxeKGxNQL6jUOI8Mh6szkQQ+ZLWCsdcorRX1l9zNblNbW4Jc01EVMrpqytx4xHd+yUd75L1UZIgfP7aOwymtXuPp+2T9jMdn9i67FGMsgw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by CH0PR11MB5284.namprd11.prod.outlook.com (2603:10b6:610:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Mon, 8 Apr
 2024 16:10:15 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 16:10:15 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v4 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Thread-Topic: [PATCH net-next v4 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Thread-Index: AQHaiYknStc1x6bzqUGj0vkKgaRKGLFei9UA
Date: Mon, 8 Apr 2024 16:10:15 +0000
Message-ID: <40d90a28d95bff48f352a3aaf81df2b1a6133cc7.camel@microchip.com>
References: <20240408074758.1825674-1-o.rempel@pengutronix.de>
	 <20240408074758.1825674-6-o.rempel@pengutronix.de>
In-Reply-To: <20240408074758.1825674-6-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|CH0PR11MB5284:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sXzunYLGiwlMY6MMKpDYttBNxiOw0QjIcjQACeT6qKki449ZgXw1kHpxGsVHPsPJJrxINYPsZXSIegNsYWcHVRrgP5MNJG4XQ8tq0t3ViGRz0AFxdqd7AioqZF/DZOKF3xr9szQ2+PHmq/hucyMVa6WgqhdF3chNj8rMfwV3yhs1bvuvSOQJzI3Fm2vQKrpUJ1+MVA54XEQT+KPqHShRzc33Bi8G2si09XCL89PiZWcFbkGDORmmkWKjfsLWKv6ow1z1Py7epZEeXA2K6Kf/FECbOR2esDusR9D4saQyT5aF0gC0yLF8oTMAexHHr7jqlVob+HJgRcJ2OSklOmOMtvLu7GJze87bFhBVCB6OOoINyeFohcglNxHaZkJFmq3vyO/7IYVYzWJXIRrDVOgVUdE72Lw0u3dRrBph7n9U0qGlHuR6daFJf6Pfy7Zlht3SnFxIwBWiuNpBe9AGSU/YcmUNs1NbB67r6zO+nX+QeU8NfMGeqMqIb6SRuNK7YXy+Jde/eyf7THSjGxGdZRredCn2Q9flez31ry9ZaWSd+EPi6Xw/TZLlLPV0Dpr6juzLO01LFl8XzNWj/sdlDYPjuSVcsmVImuPij+ZIY+ElXaDeXP0YQKdjkN4oxcw/NkKg9EtI0e1w9PWewqYh+EEt0YMefKHWgsEQfyrsSKuyxMM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0c4VDdncHJTd082RnFtRDBNM0cxdm1JZFYrT1FEdDk1Ymg2RlVCL01YVDAy?=
 =?utf-8?B?V29aSWtFbDROU1dFbHRRZUFkM3BOdzN3OE1DWnFJRTc3WDBtb1VMS0tDdzBz?=
 =?utf-8?B?QWdhT3V1OHFCak81cFYxTDE5YVJMSU1xYm5GMXBTQTVJL3hSdVpMV09jeVhU?=
 =?utf-8?B?ZTR6ejNrZXFRQTE3UFBxdVQzbTVrOVh2TVBKeGlWZVVCZXR1Tk5pck1raUtB?=
 =?utf-8?B?Ync3UHJ1TFlDa1REOWY3ZWZvdEdsUWhwTEFOYThvMVc3SVRENGZmYzZRbWp4?=
 =?utf-8?B?SmFOVStjR21lR3NJUFU2V2hwdDN2QzIzSVhwL3lTZzQvWnZFUU81ckEyZTRh?=
 =?utf-8?B?enhvOHdxTktlYU0wcGFaYVhCVkhkNjM0d3ozWUN4Z0dzWVBTQXlDYjR2S0Zx?=
 =?utf-8?B?MFpoeTZGNjNHRC9HZGhOamprejhLakdLZ2tHQ3JrWHg4d3JmRm8yUFR3TC81?=
 =?utf-8?B?OUtVS0VFVHd0Ym5wT3pBUzZ2bDZoYStxOGNybXhpa1BUdlJVZk9QRnc4YUdV?=
 =?utf-8?B?MVp0aHllWVkyMkgvTFhDWWVFVERDYzBjOFZsYUxSVTFxR0FYeWsraXUzMEgr?=
 =?utf-8?B?ZVRmUTR5TThGeXN2MW1Qb2cxeFU3S3hpRStEaTV3eXpyNzQ4Uzh6enlqV2tq?=
 =?utf-8?B?YkVLbnJCZGhJM0djSEd6WnpmZzBSRHZHMFRHS1RKWmlkekdsejdJOHZ5Y0Nm?=
 =?utf-8?B?RlJOOWpEbURDSnBRSmZsUkN5SmZrV08xc0xpcDVzTkgrNHZpTnBoY2RyaVRv?=
 =?utf-8?B?M3BIeWpUM3RBTXpMMDRIZTlKTU0rYitneUJwVEw0SW8xbVp0bkVZMmdFT2JX?=
 =?utf-8?B?cmhDcnVta2VURkZETDdqR1FPeDE4anV3RkJENkpacHlseGU2eTlhS2xXTUxa?=
 =?utf-8?B?bldCTFBiUHpTTmpxUXBBaTJsUHRtZERFM0JrMG1GaXZ4d0FLVWVocjRaWGV0?=
 =?utf-8?B?UytRNXBwbVRwdGhjbDVNd2R3bnc5V3dqNTVDSGNZbWt3cWFKV1krWVBxek5Z?=
 =?utf-8?B?YlVaUnd6cnRGQ1A2SEV3MlBzTC9wS3JwK2pBVWptUWpmUlV6cFVGcG5GemVI?=
 =?utf-8?B?aWpZcjhFalRCYlhDYjhzMnZqTU1pd2ZiUkJnQUViUDVVYTBCK1greCszVSs5?=
 =?utf-8?B?cW0xNjA5dE5sSE9JdER5eHl1OTF0RXN2VjJPcjBTQjE0d01RYy9WT0RyY29u?=
 =?utf-8?B?dTlZYmx3TkZ3aG5RZU9rNGVUK2tiVklJWjlKN1FDbGlNTnBqc2xPeC9oemxP?=
 =?utf-8?B?ek5tRnJFcUhXMWNmTkt5eFRWTCtVWkZjL2I1TWp4MmMzbGpWaVA2K1NQbjZj?=
 =?utf-8?B?MW9LckxlZWhGaGZoelRIcHFOZEIrRVBZT2hEci8waDM4ZGdXMDkyQlloM25R?=
 =?utf-8?B?UTBJRTZxbnZ0dC9EcDlMSjRraUVmemFUWURMVTlZMHZwR2tISDhPQnQxcUJV?=
 =?utf-8?B?UElnVVFCUUI1cnlrL0ZDY0p5M3dqZEQxbDBOb0I0MWNhMFp0Q0pLUUNWelVm?=
 =?utf-8?B?RlFKaU5YdklVL2JGTXlyNWlYaldaRWVsVjByaDVpL3FVbUxFdGIybFFCTlNw?=
 =?utf-8?B?cVl4Z1JRWW80bHhQVUxiVWYrMS9wRDY0NVBQNlA0Wk00VTR1bHBlN2RaZUtR?=
 =?utf-8?B?bG5ETjJackE5RGxPOEIxR0FLMW9jVlJzRlZ1NFZkS0l2eFFhbWZ0M05xK0pn?=
 =?utf-8?B?NVJvT05paU5OaFlrT1hjRUJsQWwzYk1jYi96Zm1zK3E2YTJHS0N0WFB5Y3NV?=
 =?utf-8?B?aW9RdlhtTnV2RWgya1VoQnR5anV4UVBSV0NZMjRXL25WazV1R0kvTUQ0WWE2?=
 =?utf-8?B?NElEckJZUjRSZE5Vc1h0MXF1Y2pQL2xGVkVRTmVJd3BkRk1vOFRiU0hNN2d5?=
 =?utf-8?B?LytRL2UrNXFVT3hIckhXZFhoNWZvb0hXTUhrOFpaYnl4RW1PUGJZS2NXbnBk?=
 =?utf-8?B?TW9oaURuM01JMnpQVU4wOVY4RHhvVWU1a1hXRVNVZTVlUzdlazdVY0VTTFNV?=
 =?utf-8?B?aWJtWFRyU1NpK2FwUFVFOTJnWnhjdFM5NUV4Mi81Wk1HVWZkQ1FhWUkxYzlv?=
 =?utf-8?B?MmppUFF6UHY4eHNLQXJqcyt5ZGZPUjZzR1lRSU50TXdLaXByNDkyN29Scm0v?=
 =?utf-8?B?OEpYWUVSVThYcEVReisvUDEwYXdUTEZwSFFyazRHWWZCY1JNN2F1WVl2eEUv?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5E6B84CBDDAD346B9C18D443EC4AB96@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23e91a7-4289-4c4c-e624-08dc57e66065
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 16:10:15.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqoxls01IF0bV9Lf4dw+ObVTtdxV4lN/qOyywvO8YG7aVHbS89DNA5B7+HnaNu0CI59HW/u4/nj38DM5HMEqSqP0teU3Mc7hvDjo/WI5aPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5284

SGkgT2xla3NpaiwNCg0KPiANCj4gIHZvaWQga3N6X3BvcnRfc3RwX3N0YXRlX3NldChzdHJ1Y3Qg
ZHNhX3N3aXRjaCAqZHMsIGludCBwb3J0LCB1OA0KPiBzdGF0ZSkNCj4gQEAgLTM5NDMsNiArMzk0
OCwxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRzYV9zd2l0Y2hfb3BzDQo+IGtzel9zd2l0Y2hf
b3BzID0gew0KPiAgICAgICAgIC5wb3J0X3NldHVwX3RjICAgICAgICAgID0ga3N6X3NldHVwX3Rj
LA0KPiAgICAgICAgIC5nZXRfbWFjX2VlZSAgICAgICAgICAgID0ga3N6X2dldF9tYWNfZWVlLA0K
PiAgICAgICAgIC5zZXRfbWFjX2VlZSAgICAgICAgICAgID0ga3N6X3NldF9tYWNfZWVlLA0KPiAr
ICAgICAgIC5wb3J0X2dldF9kZWZhdWx0X3ByaW8gID0ga3N6X3BvcnRfZ2V0X2RlZmF1bHRfcHJp
bywNCj4gKyAgICAgICAucG9ydF9zZXRfZGVmYXVsdF9wcmlvICA9IGtzel9wb3J0X3NldF9kZWZh
dWx0X3ByaW8sDQo+ICsgICAgICAgLnBvcnRfZ2V0X2RzY3BfcHJpbyAgICAgPSBrc3pfcG9ydF9n
ZXRfZHNjcF9wcmlvLA0KPiArICAgICAgIC5wb3J0X3NldF9hcHB0cnVzdCAgICAgID0ga3N6X3Bv
cnRfc2V0X2FwcHRydXN0LA0KPiArICAgICAgIC5wb3J0X2dldF9hcHB0cnVzdCAgICAgID0ga3N6
X3BvcnRfZ2V0X2FwcHRydXN0LA0KDQpuaXRwaWNrOiBwb3J0X3NldF9hcHB0cnVzdCBhbmQgcG9y
dF9nZXRfYXBwdHJ1c3QgY2FuIGJlIHN3YXBwZWQgdG8gaGF2ZQ0Kb21tb24gZmxvdyBvZiBnZXQg
YW5kIHNldC4NCj4gIH07DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL21pY3Jv
Y2hpcC9rc3pfZGNiLmMNCj4gYi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9kY2IuYw0K
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAwLi40NjQ5MWM2ZGQ2
ZjYwDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9r
c3pfZGNiLmMNCj4gQEAgLTAsMCArMSw1NDQgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wDQo+ICsvLyBDb3B5cmlnaHQgKGMpIDIwMjQgUGVuZ3V0cm9uaXgsIE9sZWtz
aWogUmVtcGVsIDwNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlPg0KPiArDQo+ICsjaW5jbHVkZSA8
bGludXgvZHNhL2tzel9jb21tb24uaD4NCj4gKyNpbmNsdWRlIDxuZXQvZHNhLmg+DQo+ICsjaW5j
bHVkZSA8bmV0L2RzY3AuaD4NCj4gKyNpbmNsdWRlIDxuZXQvaWVlZTgwMjFxLmg+DQo+ICsNCj4g
DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGtzel9nZXRfZGVmdWx0X3BvcnRfcHJpb19yZWcoc3RydWN0
IGtzel9kZXZpY2UgKmRldiwgaW50DQoNCnMvZGVmdWx0L2RlZmF1bHQNCg0KPiAqcmVnLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4ICptYXNrLCBpbnQgKnNo
aWZ0KQ0KPiArew0KPiArICAgICAgIGlmIChpc19rc3o4KGRldikpIHsNCj4gKyAgICAgICAgICAg
ICAgICpyZWcgPSBLU1o4X1JFR19QT1JUXzFfQ1RSTF8wOw0KPiArICAgICAgICAgICAgICAgKm1h
c2sgPSBLU1o4X1BPUlRfQkFTRURfUFJJT19NOw0KPiArICAgICAgICAgICAgICAgKnNoaWZ0ID0g
X19iZl9zaGYoS1NaOF9QT1JUX0JBU0VEX1BSSU9fTSk7DQo+ICsgICAgICAgfSBlbHNlIHsNCj4g
KyAgICAgICAgICAgICAgICpyZWcgPSBLU1o5NDc3X1JFR19QT1JUX01SSV9NQUNfQ1RSTDsNCj4g
KyAgICAgICAgICAgICAgICptYXNrID0gS1NaOTQ3N19QT1JUX0JBU0VEX1BSSU9fTTsNCj4gKyAg
ICAgICAgICAgICAgICpzaGlmdCA9IF9fYmZfc2hmKEtTWjk0NzdfUE9SVF9CQVNFRF9QUklPX00p
Ow0KPiArICAgICAgIH0NCj4gK30NCj4gKw0KPiArDQo+ICtpbnQga3N6X3BvcnRfZ2V0X2RlZmF1
bHRfcHJpbyhzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMsIGludCBwb3J0KQ0KPiArew0KPiArICAgICAg
IHN0cnVjdCBrc3pfZGV2aWNlICpkZXYgPSBkcy0+cHJpdjsNCj4gKyAgICAgICBpbnQgcmV0LCBy
ZWcsIHNoaWZ0Ow0KPiArICAgICAgIHU4IGRhdGEsIG1hc2s7DQo+ICsNCj4gKyAgICAgICBrc3pf
Z2V0X2RlZnVsdF9wb3J0X3ByaW9fcmVnKGRldiwgJnJlZywgJm1hc2ssICZzaGlmdCk7DQo+ICsN
Cj4gKyAgICAgICByZXQgPSBrc3pfcHJlYWQ4KGRldiwgcG9ydCwgcmVnLCAmZGF0YSk7DQo+ICsg
ICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsNCj4gKyAg
ICAgICByZXR1cm4gKGRhdGEgJiBtYXNrKSA+PiBzaGlmdDsNCg0KSSBhc3N1bWUgd2UgY2FuIHVz
ZSByZXRydW4gRklFTERfR0VUKG1hc2ssIGRhdGEpLCBzaW5jZSBtYXNrIGlzIEdFTk1BU0sNCmZv
cm1hdC4gDQoNCj4gDQo+ICtpbnQga3N6X3BvcnRfc2V0X2RlZmF1bHRfcHJpbyhzdHJ1Y3QgZHNh
X3N3aXRjaCAqZHMsIGludCBwb3J0LCB1OA0KPiBwcmlvKQ0KPiBwcmlvKQ0KPiArew0KPiArICAg
ICAgIHN0cnVjdCBrc3pfZGV2aWNlICpkZXYgPSBkcy0+cHJpdjsNCj4gKyAgICAgICBpbnQgcmVn
LCBzaGlmdDsNCj4gKyAgICAgICB1OCBtYXNrOw0KPiArDQo+ICsgICAgICAgaWYgKHByaW8gPj0g
ZGV2LT5pbmZvLT5udW1fdHhfcXVldWVzKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+ICsNCj4gKyAgICAgICBrc3pfZ2V0X2RlZnVsdF9wb3J0X3ByaW9fcmVnKGRldiwgJnJl
ZywgJm1hc2ssICZzaGlmdCk7DQo+ICsNCj4gKyAgICAgICByZXR1cm4ga3N6X3BybXc4KGRldiwg
cG9ydCwgcmVnLCBtYXNrLCAocHJpbyA8PCBzaGlmdCkgJg0KPiBtYXNrKTsNCg0KRklFTERfUFJF
UChtYXNrLCBwcmlvKQ0KDQo+ICt9DQo+ICsNCj4gKy8qKg0KPiArICoga3N6X2dldF9kc2NwX3By
aW9fcmVnIC0gUmV0cmlldmVzIHRoZSBEU0NQLXRvLXByaW9yaXR5LW1hcHBpbmcNCj4gcmVnaXN0
ZXINCj4gKyAqIEBkZXY6IFBvaW50ZXIgdG8gdGhlIEtTWiBzd2l0Y2ggZGV2aWNlIHN0cnVjdHVy
ZQ0KPiArICogQHJlZzogUG9pbnRlciB0byB0aGUgcmVnaXN0ZXIgYWRkcmVzcyB0byBiZSBzZXQN
Cj4gKyAqIEBwZXJfcmVnOiBQb2ludGVyIHRvIHRoZSBudW1iZXIgb2YgRFNDUCB2YWx1ZXMgcGVy
IHJlZ2lzdGVyDQo+ICsgKiBAbWFzazogUG9pbnRlciB0byB0aGUgbWFzayB0byBiZSBzZXQNCj4g
KyAqDQo+ICsgKiBUaGlzIGZ1bmN0aW9uIHJldHJpZXZlcyB0aGUgRFNDUCB0byBwcmlvcml0eSBt
YXBwaW5nIHJlZ2lzdGVyLA0KPiB0aGUgbnVtYmVyIG9mDQo+ICsgKiBEU0NQIHZhbHVlcyBwZXIg
cmVnaXN0ZXIsIGFuZCB0aGUgbWFzayB0byBiZSBzZXQuDQo+ICsgKi8NCj4gK3N0YXRpYyB2b2lk
IGtzel9nZXRfZHNjcF9wcmlvX3JlZyhzdHJ1Y3Qga3N6X2RldmljZSAqZGV2LCBpbnQgKnJlZywN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCAqcGVyX3JlZywgdTggKm1h
c2spDQo+ICt7DQo+ICsgICAgICAgaWYgKGtzel9pc19rc3o4N3h4KGRldikpIHsNCj4gKyAgICAg
ICAgICAgICAgICpyZWcgPSBLU1o4NzY1X1JFR19UT1NfRFNDUF9DVFJMOw0KPiArICAgICAgICAg
ICAgICAgKnBlcl9yZWcgPSA0Ow0KPiArICAgICAgICAgICAgICAgKm1hc2sgPSBHRU5NQVNLKDEs
IDApOw0KPiArICAgICAgIH0gZWxzZSBpZiAoa3N6X2lzX2tzejg4eDMoZGV2KSkgew0KPiArICAg
ICAgICAgICAgICAgKnJlZyA9IEtTWjg4WDNfUkVHX1RPU19EU0NQX0NUUkw7DQo+ICsgICAgICAg
ICAgICAgICAqcGVyX3JlZyA9IDQ7DQo+ICsgICAgICAgICAgICAgICAqbWFzayA9IEdFTk1BU0so
MSwgMCk7DQo+ICsgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgICpyZWcgPSBLU1o5
NDc3X1JFR19ESUZGU0VSVl9QUklPX01BUDsNCj4gKyAgICAgICAgICAgICAgICpwZXJfcmVnID0g
MjsNCj4gKyAgICAgICAgICAgICAgICptYXNrID0gR0VOTUFTSygyLCAwKTsNCj4gKyAgICAgICB9
DQo+ICt9DQoNCm5pdHBpY2s6IHRvIGhhdmUgY29tbW9uIGZsb3csIHlvdSBjYW4gZ3JvdXAgYWxs
IHRoZSBnZXQgcmVnaXN0ZXINCmZ1bmN0aW9uIGluIHRvcCBvZiBmaWxlLiANCg0KPiANCj4gK3N0
YXRpYyBpbnQga3N6X3BvcnRfc2V0X2FwcHRydXN0X3ZhbGlkYXRlKHN0cnVjdCBrc3pfZGV2aWNl
ICpkZXYsDQo+IGludCBwb3J0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb25zdCB1OCAqc2VsLCBpbnQgbnNlbCkNCj4gK3sNCj4gKyAgICAgICBpbnQgaSwg
aiwgZm91bmQ7DQo+ICsgICAgICAgaW50IGpfcHJldiA9IDA7DQo+ICsNCj4gKyAgICAgICAvKiBJ
dGVyYXRlIHRocm91Z2ggdGhlIHJlcXVlc3RlZCBzZWxlY3RvcnMgKi8NCj4gKyAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgbnNlbDsgaSsrKSB7DQo+ICsgICAgICAgICAgICAgICBmb3VuZCA9IDA7DQo+
ICsNCj4gKyAgICAgICAgICAgICAgIC8qIENoZWNrIGlmIHRoZSBjdXJyZW50IHNlbGVjdG9yIGlz
IHN1cHBvcnRlZCBieSB0aGUNCj4gaGFyZHdhcmUgKi8NCj4gKyAgICAgICAgICAgICAgIGZvciAo
aiA9IDA7IGogPCBzaXplb2Yoa3N6X3N1cHBvcnRlZF9hcHB0cnVzdCk7IGorKykNCj4gew0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICBpZiAoc2VsW2ldICE9IGtzel9zdXBwb3J0ZWRfYXBwdHJ1
c3Rbal0pDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ICsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgZm91bmQgPSAxOw0KPiArDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIC8qIEVuc3VyZSB0aGF0IG5vIGhpZ2hlciBwcmlvcml0eSBzZWxlY3Rvcg0K
PiAobG93ZXIgaW5kZXgpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIHByZWNlZGVzIGEg
bG93ZXIgcHJpb3JpdHkgb25lDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBpZiAoaSA+IDAgJiYgaiA8PSBqX3ByZXYpDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZ290byBpbnZhbGlkOw0KPiArDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGpfcHJldiA9IGo7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiArICAgICAgICAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgICAgICAgICBpZiAoIWZvdW5k
KQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGludmFsaWQ7DQoNCmRpZmZlcmVudCBs
YWJlbCBvdGhlciB0aGFuIGludmFsaWQgY2FuIGJlIHVzZWQgbGlrZSBlcnJfDQoNCj4gKyAgICAg
ICB9DQo+ICsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gKw0KPiAraW52YWxpZDoNCj4gKyAgICAg
ICBrc3pfYXBwdHJ1c3RfZXJyb3IoZGV2KTsNCj4gKw0KPiArICAgICAgIHJldHVybiAtRUlOVkFM
Ow0KPiArfQ0KPiArDQo+ICsvKioNCj4gKyAqIGtzel9nZXRfYXBwdHJ1c19tYXBfYW5kX3JlZyAt
IFJldHJpZXZlcyB0aGUgYXBwdHJ1c3QgbWFwIGFuZA0KPiByZWdpc3Rlcg0KPiArICogQGRldjog
UG9pbnRlciB0byB0aGUgS1NaIHN3aXRjaCBkZXZpY2Ugc3RydWN0dXJlDQo+ICsgKiBAbWFwOiBQ
b2ludGVyIHRvIHRoZSBhcHB0cnVzdCBtYXAgdG8gYmUgc2V0DQo+ICsgKiBAcmVnOiBQb2ludGVy
IHRvIHRoZSByZWdpc3RlciBhZGRyZXNzIHRvIGJlIHNldA0KPiArICogQG1hc2s6IFBvaW50ZXIg
dG8gdGhlIG1hc2sgdG8gYmUgc2V0DQo+ICsgKg0KPiArICogVGhpcyBmdW5jdGlvbiByZXRyaWV2
ZXMgdGhlIGFwcHRydXN0IG1hcCBhbmQgcmVnaXN0ZXIgYWRkcmVzcyBmb3INCj4gdGhlDQo+ICsg
KiBhcHB0cnVzdCBjb25maWd1cmF0aW9uLg0KPiArICovDQo+ICtzdGF0aWMgdm9pZCBrc3pfZ2V0
X2FwcHRydXNfbWFwX2FuZF9yZWcoc3RydWN0IGtzel9kZXZpY2UgKmRldiwNCg0Kcy9hcHB0cnVz
Xy9hcHB0cnVzdF8NCg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y29uc3Qgc3RydWN0IGtzel9hcHB0cnVzdF9tYXANCj4gKiptYXAsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgKnJlZywgdTggKm1hc2spDQo+ICt7DQo+ICsg
ICAgICAgaWYgKGlzX2tzejgoZGV2KSkgew0KPiArICAgICAgICAgICAgICAgKm1hcCA9IGtzejhf
YXBwdHJ1c3RfbWFwX3RvX2JpdDsNCj4gKyAgICAgICAgICAgICAgICpyZWcgPSBLU1o4X1JFR19Q
T1JUXzFfQ1RSTF8wOw0KPiArICAgICAgICAgICAgICAgKm1hc2sgPSBLU1o4X1BPUlRfRElGRlNF
UlZfRU5BQkxFIHwNCj4gS1NaOF9QT1JUXzgwMl8xUF9FTkFCTEU7DQo+ICsgICAgICAgfSBlbHNl
IHsNCj4gKyAgICAgICAgICAgICAgICptYXAgPSBrc3o5NDc3X2FwcHRydXN0X21hcF90b19iaXQ7
DQo+ICsgICAgICAgICAgICAgICAqcmVnID0gS1NaOTQ3N19SRUdfUE9SVF9NUklfUFJJT19DVFJM
Ow0KPiArICAgICAgICAgICAgICAgKm1hc2sgPSBLU1o5NDc3X1BPUlRfODAyXzFQX1BSSU9fRU5B
QkxFIHwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgS1NaOTQ3N19QT1JUX0RJRkZTRVJWX1BS
SU9fRU5BQkxFOw0KPiArICAgICAgIH0NCj4gK30NCj4gKw0KPiArDQo+IA0K

