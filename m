Return-Path: <linux-kernel+bounces-95015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB58087482E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414A41F28274
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D841BF5C;
	Thu,  7 Mar 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ioHVsrPq";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vjz0fIFB"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49651BF50;
	Thu,  7 Mar 2024 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792998; cv=fail; b=mLz648mLs61lJuCTSEeFxZyp2AwU1LZGwHHws11sX4Gwi1h3GQJocBrQ3hDBmcG1/NiZEIHwqB4zPoLX9CJrljyBIAUyqGd4LL3ENN82ZWMafGRU7sV8+i432sXm8wTJfz0dF7XI52r5F9UUGHfe3KVxX1s6/uHA63a7zduHSug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792998; c=relaxed/simple;
	bh=0r0+RzYC8pXU4jfPZcA2nFVtyXeBBK3ZJaCXpUBVTFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o0J+RLc1BU0pt7Pjrd43k+EkZFimLyPuX98bojXshM8tIJBfZXg46NqyUMPxqQH6W2gBsiHtHFJnCNqUkMtW4xv26PR1Bk0quKwJkynQgvZF+3BgvqSXcDQXWszKfrPMDlNnIx1XvJ+kGMvEgo4AKYgxEJo8gJVJsTvNg0WNfj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ioHVsrPq; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vjz0fIFB; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709792995; x=1741328995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0r0+RzYC8pXU4jfPZcA2nFVtyXeBBK3ZJaCXpUBVTFE=;
  b=ioHVsrPqoLmnfCvbm93chro7JXvBJ0pyuHzJm+tNGDOWALK1i6gu7bSn
   3GZ1zNY08Rx1wqqIrfzTjnok7U+iJWJjbx7NKMxCT41aHp9YbobC/Sd8S
   cHpxlE/VBdQpWl/j+uX+twTJ7MaHrggtBNa3lH/KeNXTtlbZC2a8lqHCm
   t86MLK42vhAl2MRSjDdceGXc2InprnRkb2FEBAToB6EZAnYd3dLUA/Mc5
   AYchV+ksrTS6+GDVJAD2y4khtJAKkdOXFpI/eI5jVUpwSu2kimlRkc8Gk
   jhPCbPBUucQC6Mj2D4IMsCK3A0CnH1jM4Wb4Smry3ezgDntPQDfuK2aO9
   A==;
X-CSE-ConnectionGUID: 3HldqJPjRESpdfLpEnPpNw==
X-CSE-MsgGUID: kPbw33IzQNea4kx733kzSg==
X-IronPort-AV: E=Sophos;i="6.06,210,1705388400"; 
   d="scan'208";a="184600439"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 23:29:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 23:29:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 23:29:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPQeF8QzlaUPx3IvgRTOcCSDkgv45iqC9v0lMrXbWlo9OTE+cRv7Ovtkwi0UcewIaWOK/VKFmg0Bxb34Qa6ZSxXtHZaBFadE4w55v+ppfWcl/YGIt0tzQQfigQLdRWGvsYTbS284Dajbg/G3/OSWLnL0c8XAp7oE+wIMCqLjqC5/3rj2Hr8FQb+rA+kRuAiCmwO6iRyy49btjnEHJo2kp00Hq8bw5ab4S0owZKHQCXQXK5zZG//m4JMqIcjUv+khSOg54Y+YAv87sB5bU2o96L6SRuuqLXLuHNZavL/oB0I83bgFBhWioLmF+bN14M/3f9b07cBI7g8PkVhXEmiR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r0+RzYC8pXU4jfPZcA2nFVtyXeBBK3ZJaCXpUBVTFE=;
 b=GFy1zdAL1nFtg2652pCG+Ql70bIKWSNewzV4eb2BjlfYgXh+ojFesCmKzX53CDr6l3eZEGv0aHRYVfDd9tHblG5irNpHFCZ3QEWfGr66hUecmSryyVBhi80zdC0HqLdOXWumAiw/Fz2ndAn65JKgdBfrwg9YdrTbRsJ+I1Ez8WCUXSwR14MNwL2+HDeQI5wG+Hvxna+9GC8HXrPV3/8Mmf9U+qVhggc8RRVtI58uwAxHvco89D6r5SOIhPRyb9ckVR0YiYWHZpF6StskXAxWDj7Tle+oigRpB5Vr8kcFEofp1cCk6x7mPdWcZZTVlZgc2hZh0cG2Ks2IzqyCzcSPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r0+RzYC8pXU4jfPZcA2nFVtyXeBBK3ZJaCXpUBVTFE=;
 b=vjz0fIFB45BHd82Iongxo+wP8SheCaI7EI2ffQcqU02tsHItAwyucqzS0VCTfkqI1CmilgAzf5rEIxCGIRnJ/vwZincR32fGa6vSbhPo68YVsYGONm+Tz10iZ/lB4bC7cwFuQvQd842SHxD2g6p3Kl+lhm6DnhHnmmaA3BPGckdxXZYhQBgxtcb8ZetcR1F6TkxJHGBzmg52ns185Jzh6ELbNWxgm9GDgKVOo9VV2gPyVZM32FiGZDm8y+wPX+yk4/wlZDrFzuiU26x9X5dTavJlJ20MSE0RVDoo1AumXyPLg4IbwjhUCAh1/FQ60vL911Ev8D7PTiJ9kSzBgSZt6g==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB8249.namprd11.prod.outlook.com (2603:10b6:510:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 06:29:30 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 06:29:30 +0000
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
Subject: Re: [PATCH net-next v3 01/12] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Thread-Topic: [PATCH net-next v3 01/12] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Thread-Index: AQHab6NqD8Lu7sMliEGxzIiuoy+HQLEqs5WAgAEevgA=
Date: Thu, 7 Mar 2024 06:29:30 +0000
Message-ID: <9e48f3a1-08cd-4af4-86ee-8ab352352bf7@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-2-Parthiban.Veerasooran@microchip.com>
 <a9c8a5b1-866e-4ade-ad07-af715042ec9c@lunn.ch>
In-Reply-To: <a9c8a5b1-866e-4ade-ad07-af715042ec9c@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB8249:EE_
x-ms-office365-filtering-correlation-id: 0fa36b77-0553-4e18-32bd-08dc3e6ff1eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bRyseDEXjNj+sGwIUMyhf44FEeVzXTacODcKmGzc7X2fyN4b+JOb4d08Cpr2Xd2zx/bEQkX3vOEvp6CufAMqrHtqOV9R70XE82Cb1AuCT8WlJMYczrWxogELjEocGEUYZW+fHiP63+4Wu0HHkwhjI+J9JKHEeIiGKC3XSEx7epmK0ca6VcKlNI3DAoaDmt2+l1xjjKwfbFkW+Xon1xJJuIjdmTxdHg9VC79vV97vdVtFfo+APKS1MW9hCh2J1aCDpC7G6neyKRGt19auVYwabQlLf3bDGkvja9zPN/Ex7vstVSPnogP80cX7Sw0dwsAPSu9JTIXoNWDx/2VPJ7uhkfmT3IkxHHgVAiYcAawiPULDezd3ZjRUBSSY7s/qYtWDKC0XCWOoixqMLGP1Zpeqjs00aFS7V4mO5TZjggIVsWT+P2o8ZrJuWUSQLiMuQFEuTfgIt2Scmo7COh+cSWFQQW2mk3lPnAmZ4fhDij6NtA5jD94nnvmJjJjJ0WxpKXC+m0eATKEea+SVdJF8pQvLZolZP3wusiwmniV+tVgKHIHW+j4Zn/jLVFdHzvbFuyDQB2g/E4AMSaDvovgw1OZVNFyKVtEOrW0PVOYBWVjVWeZKFwflWc+RX5Aox8NUqiMbBon1s9fjc2nw6TpU17ycEFX68EYYi1oRP1CzILLen+HwomwBcr8Xwu3Xhw69G55RvkIBYCdXQkWFj/REhjuB7oOKj3S+xe36YTNu71D+lCA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHZtR1dYRGxiYXVENjdOTzBveXFpd29ya3ArY05DM0xMUjNyVTdrN0hhR2h1?=
 =?utf-8?B?U3VkVXZhRWwvNHo2Z2prdTBBTUFoQjZTWW0yKzl6QUxyMkRzRzIrMWtxMzl5?=
 =?utf-8?B?SDdZRVhqdGdhb0cwWlhHamtJRTRXMDg0TWJLTjl6ckdvMURqZm9GVlBRdGNq?=
 =?utf-8?B?UGRJdDA3V3VFdjcrdy94a2NaRGJKSHRPUkxyT2FNdGpSMHBiYXNYU05GN2d5?=
 =?utf-8?B?aTRLYmd6cG9zRVpSdHJITDVKOHplWFo5ZjNpbWJjRzdNTUk2c3N1eHA4MkJZ?=
 =?utf-8?B?bW9lVk1MbmVwK2dkOFExVDA2UlFnckZRbThGSWk0UFozVXRyS2VvRWdxWi9h?=
 =?utf-8?B?UExtT2tMNHJ1K0VEb1hyZXNRT3Arc1JidjJSd284L2tDS0FTalFvbHRoeDZM?=
 =?utf-8?B?VUFIR1g5TVZ2bUwxYS9tZzlNdm5rSXNERlRWdHovbmJSbmVZSFYvWmdtQncz?=
 =?utf-8?B?TERYOFM2TjlHRUIyWkNrTHJtMzJJMGNIZmlMYUFlNllaNmpBYjBCR09hVWtk?=
 =?utf-8?B?Z09aT1huSkRsWE85ZGVISmN5SE1nWDUwckZPcUdualZJdThNenU4SUdCZkh5?=
 =?utf-8?B?eFkva3J4RlBwZmtxVU5BbHJVellIZXVKMXlVQVNmaVZpNWgvWVkvMGRib1FZ?=
 =?utf-8?B?RnZSSTJzSDVzUHh3SEFabCt3R2JXVE1qNHh6cnhKWDQwVUFKY3dmbGd1ZFFk?=
 =?utf-8?B?Mm5GTnppUDExUWxVeGpPQUtDalgvWFdHMzJTQWN0dUFmL1pOR2tkWEtBZnlE?=
 =?utf-8?B?eGxZRGJpenlXOHNvblhlNFRzZDRwZXQrY29UWElCbzdUcGhwNEZ4YmVrOGdy?=
 =?utf-8?B?V3VabzNJRCtTQnNWdWpENDBwU25YYkxCM0RrVnROemgvbm5tMm83UjUwRGFl?=
 =?utf-8?B?REYxaGxlb1JTcDdKNVlwTkRJUG80SzBhRFNWV3llaEtoZjltYzBsM0x6Uk5M?=
 =?utf-8?B?cExYeDk0U0tRNkRvYm0rSlhWUGNGbFhKRmNaNlgrcVBNOEx0NXAyR0tIVmlB?=
 =?utf-8?B?bUdwY3pqZHBtbDRFTjk2V1ljUlpoVWdIZUxDalRqSGtIMTVCUXNHMGFTQmQx?=
 =?utf-8?B?cytVTFdHb1RCV1lxYVRhRXpPZ3l5b0lMZFlZQ1V5Smc0cGY4M3lzUzM1WElp?=
 =?utf-8?B?eW9jVU1FY0E5WnA3d3BwK2JPeEdnYmxSb2lkVktzNWNqa04rVm1vVDlXRy8x?=
 =?utf-8?B?UE5ubWs5L3VLNFR2MXA5azJ3Q3J6aXJkekNMWjdPb0hNZlZybmhhb2QvTzdO?=
 =?utf-8?B?bHNTcVZGaEp2K2x4djdjRWQ5dzc4ZThaMmdCRlk5VTYwQmdObzlTS0RVblhL?=
 =?utf-8?B?aWhNQzNYa2F1WGFheDZKSHRmclcxclVMeUptN3FPYXdJZFVRcUZ2d05zTEUz?=
 =?utf-8?B?dGZsWHRBN0FOTWthU2g2aWsxYWNrc2hUQk1ENU94b3JvWVBheHJQOFg5eXNu?=
 =?utf-8?B?Vm5haU00bFh1N1gyakwwaW1XVkFiZVpqdDloTWJEbWtMMkV6Um5yZFU1ZXBp?=
 =?utf-8?B?ZjNvMnc3QitjVVRHWHJHS1lXandQSFJRYkJ0b0xuMHhtOHpObnluYUVZOGI1?=
 =?utf-8?B?aTRMOVJGSGVrWEJxVUpOVXdJZFBnbURTZUtnclFqTlk1OGVqM3lCZUg3clVZ?=
 =?utf-8?B?L3FkNFhySVFnbS9FTFlYVmk3dEtma25IOHdqQTk3cmZDbk5LSWFnUXB1d042?=
 =?utf-8?B?bGgzQlYxRGtuRENRL2hQWHppQm9MTUIxeFVscXlRZW40ellTL3NQeTlCMkVK?=
 =?utf-8?B?V3hMVDJDanVwTkZXdlBKYVFZQzJlQUVXbEZZRkRrN21WbFVnWmlSKzFXMStr?=
 =?utf-8?B?dGk5VnhjRVMzZFdROVdtTGtySkxwRCtiR29hdGZWNkd3RWxzVkxrYndCK1BN?=
 =?utf-8?B?UWJNUHFuRTFPUElMLzNzRXJXeHJJdnBMN1RUY2MvNG1OQ2JWbFgzUzBXM29M?=
 =?utf-8?B?U3JVY01BU2RUbTlFYW1PY2ozM205UUhwQXZ4NjFQSVRCUW54SkxtT1NJaDlu?=
 =?utf-8?B?c21QOU1yalk0ZmNvRGk0NXhTZVdma0g1MzJPNzdDeWlrK3M0ZUN5dzBWSy9Z?=
 =?utf-8?B?K0NPN1pkRXBmSjhaV0dJZEdPT3lvR3NFdTBLcVFENldwOGRlc1FObDQxZHFL?=
 =?utf-8?B?T3o3RzVRQ0Z0TyttSlFIcXNNcXp6TDUwcDY5NTA5R2JtWjhodUxpSXlvVVhK?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B03E05C6DF476346B6DFB7BA54B01F60@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa36b77-0553-4e18-32bd-08dc3e6ff1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 06:29:30.0748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKs7JKvSYpL+2qVgllm//Uc6FPOzIDIuA10YBISBwSL0ph6C1ZLktOSTyQzGhBpMBPCgW18fHzPwB7Sy+24QVeLBimrEw7gXZhBWsOLfPTjPZ72OmUtk1GhWrORbSeRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8249

SGkgQW5kcmV3LA0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcy4NCg0KT24gMDYv
MDMvMjQgNjo1MyBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNv
bnRlbnQgaXMgc2FmZQ0KPiANCj4+ICtOT1JYIChCaXQgMjkpIC0gTm8gUmVjZWl2ZSBmbGFnLiBU
aGUgU1BJIGhvc3QgbWF5IHNldCB0aGlzIGJpdCB0byBwcmV2ZW50DQo+PiArICAgICAgICAgICAg
ICAgIHRoZSBNQUMtUEhZIGZyb20gY29udmV5aW5nIFJYIGRhdGEgb24gdGhlIE1JU08gZm9yIHRo
ZQ0KPj4gKyAgICAgICAgICAgICBjdXJyZW50IGNodW5rIChEViA9IDAgaW4gdGhlIGZvb3Rlciks
IGluZGljYXRpbmcgdGhhdCB0aGUNCj4+ICsgICAgICAgICAgICAgaG9zdCB3b3VsZCBub3QgcHJv
Y2VzcyBpdC4gVHlwaWNhbGx5LCB0aGUgU1BJIGhvc3Qgc2hvdWxkDQo+PiArICAgICAgICAgICAg
IHNldCBOT1JYID0gMCBpbmRpY2F0aW5nIHRoYXQgaXQgd2lsbCBhY2NlcHQgYW5kIHByb2Nlc3MN
Cj4+ICsgICAgICAgICAgICAgYW55IHJlY2VpdmUgZnJhbWUgZGF0YSB3aXRoaW4gdGhlIGN1cnJl
bnQgY2h1bmsuDQo+PiArDQo+PiArUlNWRCAoQml0IDI4Li4yNCkgLSBSZXNlcnZlZDogQWxsIHJl
c2VydmVkIGJpdHMgc2hhbGwgYmUg4oCYMOKAmS4NCj4+ICsNCj4+ICtWUyAoQml0IDIzLi4yMikg
LSBWZW5kb3IgU3BlY2lmaWMuIFRoZXNlIGJpdHMgYXJlIGltcGxlbWVudGF0aW9uIHNwZWNpZmlj
Lg0KPj4gKyAgICAgICAgICAgICAgICAgIElmIHRoZSBNQUMtUEhZIGRvZXMgbm90IGltcGxlbWVu
dCB0aGVzZSBiaXRzLCB0aGUgaG9zdA0KPj4gKyAgICAgICAgICAgICAgIHNoYWxsIHNldCB0aGVt
IHRvIOKAmDDigJkuDQo+PiArDQo+PiArRFYgKEJpdCAyMSkgLSBEYXRhIFZhbGlkIGZsYWcuIFRo
ZSBTUEkgaG9zdCB1c2VzIHRoaXMgYml0IHRvIGluZGljYXRlDQo+PiArICAgICAgICAgICAgICB3
aGV0aGVyIHRoZSBjdXJyZW50IGNodW5rIGNvbnRhaW5zIHZhbGlkIHRyYW5zbWl0IGZyYW1lIGRh
dGENCj4+ICsgICAgICAgICAgIChEViA9IDEpIG9yIG5vdCAoRFYgPSAwKS4gV2hlbiDigJgw4oCZ
LCB0aGUgTUFDLVBIWSBpZ25vcmVzIHRoZQ0KPj4gKyAgICAgICAgICAgY2h1bmsgcGF5bG9hZC4g
Tm90ZSB0aGF0IHRoZSByZWNlaXZlIHBhdGggaXMgdW5hZmZlY3RlZCBieQ0KPj4gKyAgICAgICAg
ICAgdGhlIHNldHRpbmcgb2YgdGhlIERWIGJpdCBpbiB0aGUgZGF0YSBoZWFkZXIuDQo+IA0KPiBU
aGVyZSBpcyBzb21lIG9kZCBpbmRlbnRhdGlvbiBnb2luZyBvbiBoZXJlLiBNYXliZSB0YWIgdnMg
c3BhY2VzPw0KWWVzLCB0aGVyZSBpcyBhIG1peHR1cmUgb2YgdGFiIGFuZCBzcGFjZXMuIEkgd2ls
bCBjb3JyZWN0IHRoaXMgDQppbmRlbnRhdGlvbiBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiANCj4g
T3RoZXJ3aXNlLCB0aGlzIGlzIG5pY2UgZG9jdW1lbnRhdGlvbi4gVGhhbmtzLg0KVGhhbmtzLg0K
DQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAgQW5kcmV3DQoNCg==

